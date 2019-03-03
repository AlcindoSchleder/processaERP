unit CadOrgDst;

{*************************************************************************}
{*                                                                       *}
{* Author   : CSD Informatica Ltda.                                      *}
{* Copyright: © 2003 by CSD Informatica Ltda.. All rights reserved.      *}
{* Created  : 02/06/2003 - DD/MM/YYYY                                    *}
{* Modified : 22/01/2007 - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ExtCtrls,
  Mask, ToolEdit, CurrEdit, ProcUtils;

type
  TCdOrgmDstn = class(TfrmModelList)
    lPk_Tabela_Origem_Destino: TStaticText;
    ePk_Tabela_Origem_Destino: TEdit;
    lFk_Cargas_Regioes__Org: TStaticText;
    eFk_Cargas_Regioes__Org: TComboBox;
    lFk_Cargas_Regioes__Dst: TStaticText;
    eFk_Cargas_Regioes__Dst: TComboBox;
    lFk_Pazo_Entrega: TStaticText;
    eFk_Prazo_Entrega: TComboBox;
    lVlr_Min: TStaticText;
    eVlr_Min: TCurrencyEdit;
    shTitle: TShape;
    lTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function GetFkDelivery: Integer;
    function GetFkRegionDstn: Integer;
    function GetFkRegionOrgm: Integer;
    function GetVlrMin: Double;
    procedure SetFkDelivery(const Value: Integer);
    procedure SetFkRegionDstn(const Value: Integer);
    procedure SetFkRegionOrgm(const Value: Integer);
    procedure SetPkRegionOrgDst(const Value: Integer);
    procedure SetVlrMin(const Value: Double);
    function GetPkRegionOrgDst: Integer;
    function GetDscOrgmDstn: string;
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  DscOrgmDstn   : string  read GetDscOrgmDstn;
    property  FkRegionOrgm  : Integer read GetFkRegionOrgm   write SetFkRegionOrgm;
    property  FkRegionDstn  : Integer read GetFkRegionDstn   write SetFkRegionDstn;
    property  FkDelivery    : Integer read GetFkDelivery     write SetFkDelivery;
    property  PkRegionOrgDst: Integer read GetPkRegionOrgDst write SetPkRegionOrgDst;
    property  VlrMin        : Double  read GetVlrMin         write SetVlrMin;
  public
    { Public declarations }
  end;

var
  CdOrgmDstn: TCdOrgmDstn;

implementation

uses Dado, mSysEstq, ProcType, GridRow, DB, EstqArqSql;

{$R *.dfm}

procedure TCdOrgmDstn.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdOrgmDstn.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_ORDS'].AsString;
end;

procedure TCdOrgmDstn.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger;
end;

function TCdOrgmDstn.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
end;

procedure TCdOrgmDstn.ClearControls;
begin
  Loading := True;
  try
    PkRegionOrgDst := 0;
    FkRegionOrgm   := 0;
    FkRegionDstn   := 0;
    FkDelivery     := 0;
    VlrMin         := 0;
  finally
    Loading      := False;
  end;
end;

function TCdOrgmDstn.GetFkDelivery: Integer;
begin
  Result := 0;
  with eFk_Prazo_Entrega do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdOrgmDstn.GetFkRegionDstn: Integer;
begin
  Result := 0;
  with eFk_Cargas_Regioes__Dst do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdOrgmDstn.GetFkRegionOrgm: Integer;
begin
  Result := 0;
  with eFk_Cargas_Regioes__Org do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdOrgmDstn.GetVlrMin: Double;
begin
  Result := eVlr_Min.Value;
end;

procedure TCdOrgmDstn.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Cargas_Regioes__Org.Items.AddStrings(dmSysEstq.LoadRegions);
    eFk_Cargas_Regioes__Dst.Items.AddStrings(dmSysEstq.LoadRegions);
    eFk_Prazo_Entrega.Items.AddStrings(dmSysEstq.LoadDeliveryPeriod);
    ListLoaded := True;
  end;
end;

procedure TCdOrgmDstn.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  inherited;
  with dmSysEstq do
  begin
    if qrTableRegion.Active then qrTableRegion.Close;
    qrTableRegion.SQL.Clear;
    qrTableRegion.SQL.Add(SqlTableRegions);
    Dados.StartTransaction(qrTableRegion);
    try
      if (not qrTableRegion.Active) then qrTableRegion.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrTableRegion, False)
      else
        if (RowModel.Count = 0) then
          RowModel.AddFieldsFromDataSet(qrTableRegion, False);
      while (not qrTableRegion.EOF) do
      begin
        Node := vtList.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtList.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrTableRegion, True);
          end;
        end;
        qrTableRegion.Next;
      end;
    finally
      if qrTableRegion.Active then qrTableRegion.Close;
      Dados.CommitTransaction(qrTableRegion);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdOrgmDstn.MoveDataToControls;
var
  Data: TDataRow;
begin
  Loading        := True;
  try
    Data         := dmSysEstq.TableRegion[Pk];
    if (Data <> nil) and (Data.Count > 0) then
    begin
      PkRegionOrgDst := Data.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger;
      FkRegionOrgm   := Data.FieldByName['FK_CARGAS_REGIOES__ORG'].AsInteger;
      FkRegionDstn   := Data.FieldByName['FK_CARGAS_REGIOES__DST'].AsInteger;
      FkDelivery     := Data.FieldByName['FK_TIPO_PRAZO_ENTREGA'].AsInteger;
      VlrMin         := Data.FieldByName['VLR_MIN'].AsFloat;
    end;
  finally
    FreeAndNil(Data);
    Loading      := False;
  end;
end;

procedure TCdOrgmDstn.SaveIntoDB;
var
  Data: TDataRow;
  aDta: PGridData;
begin
  Data           := TDataRow.Create(Self);
  if (Data = nil) then exit;
  try
    Data.AddAs('PK_TABELA_ORIGEM_DESTINO', Pk, ftInteger, SizeOf(Integer));
    Data.AddAs('FK_CARGAS_REGIOES__ORG', FkRegionOrgm, ftInteger, SizeOf(Integer));
    Data.AddAs('FK_CARGAS_REGIOES__DST', FkRegionDstn, ftInteger, SizeOf(Integer));
    Data.AddAs('FK_TIPO_PRAZO_ENTREGA', FkDelivery, ftInteger, SizeOf(Integer));
    Data.AddAs('VLR_MIN', VlrMin, ftFloat, SizeOf(Double));
    dmSysEstq.TableRegion[Ord(ScrState)] := Data;
    PkRegionOrgDst := Data.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger;
  finally
    FreeAndNil(Data);
  end;
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      aDta := GetNodeData(FocusedNode);
      if (aDta <> nil) and (aDta^.DataRow <> nil) then
      begin
        aDta^.DataRow.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger := PkRegionOrgDst;
        aDta^.DataRow.FieldByName['DSC_ORDS'].AsString                  := DscOrgmDstn;
      end;
    end;
  end;
  Pk := PkRegionOrgDst;
end;

procedure TCdOrgmDstn.SetFkDelivery(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Prazo_Entrega do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdOrgmDstn.SetFkRegionDstn(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Cargas_Regioes__Dst do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdOrgmDstn.SetFkRegionOrgm(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Cargas_Regioes__Org do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdOrgmDstn.SetPkRegionOrgDst(const Value: Integer);
begin
  ePk_Tabela_Origem_Destino.Text := IntToStr(Value);
end;

procedure TCdOrgmDstn.SetVlrMin(const Value: Double);
begin
  eVlr_Min.Value := Value;
end;

procedure TCdOrgmDstn.FormDestroy(Sender: TObject);
begin
  eFk_Cargas_Regioes__Dst.Items.Clear;
  eFk_Cargas_Regioes__Org.Items.Clear;
  inherited;
end;

function TCdOrgmDstn.GetPkRegionOrgDst: Integer;
begin
  Result := StrToIntDef(ePk_Tabela_Origem_Destino.Text, 0);
end;

function TCdOrgmDstn.GetDscOrgmDstn: string;
begin
  Result := eFk_Cargas_Regioes__Org.Text + ' ==> ' + eFk_Cargas_Regioes__Dst.Text;
end;

end.
