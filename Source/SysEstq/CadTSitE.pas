unit CadTSitE;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/01/2006 - DD/MM/YYYY                                      *}
{* Modified: 03/01/2006 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadListModel, StdCtrls, VirtualTrees, ComCtrls, ToolWin, ProcUtils,
  ExtCtrls;

type
  TCdTSitEstq = class(TfrmModelList)
    lPk_Tipo_Situacao_Estoques: TStaticText;
    ePk_Tipo_Situacao_Estoques: TEdit;
    eDsc_Tse: TEdit;
    lDsc_Tse: TStaticText;
    lFlag_Bloq: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscTse: string;
    function  GetFlagBloq: Boolean;
    function  GetPkTypeSupSit: Integer;
    procedure SetDscTse(const Value: string);
    procedure SetFlagBloq(const Value: Boolean);
    procedure SetPkTypeSupSit(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkTypeSupSit: Integer read GetPkTypeSupSit write SetPkTypeSupSit;
    property  DscTse      : string  read GetDscTse       write SetDscTse;
    property  FlagBloq    : Boolean read GetFlagBloq     write SetFlagBloq;
  public
    { Public declarations }
  end;

var
  CdTSitEstq: TCdTSitEstq;

implementation

uses Dado, ProcType, mSysEstq, GridRow, EstqArqSql, DB;

{$R *.dfm}

{ TCdTSitEstq }

function TCdTSitEstq.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscTse = '') then
  begin
    Dados.DisplayHint(eDsc_Tse, 'Campo descrição deve ser preenchido');
    Result := False;
  end;
end;

procedure TCdTSitEstq.ClearControls;
begin
  Loading := True;
  try
    PkTypeSupSit := 0;
    DscTse       := '';
    FlagBloq     := False;
  finally
    Loading := False;
  end;
end;

function TCdTSitEstq.GetDscTse: string;
begin
  Result := eDsc_Tse.Text;
end;

function TCdTSitEstq.GetFlagBloq: Boolean;
begin
  Result := lFlag_Bloq.Checked;
end;

function TCdTSitEstq.GetPkTypeSupSit: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Situacao_Estoques.Text, 0);
end;

procedure TCdTSitEstq.LoadDefaults;
begin
// nothing to do
end;

procedure TCdTSitEstq.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  inherited;
  with dmSysEstq do
  begin
    if qrTSitProd.Active then qrTSitProd.Close;
    qrTSitProd.SQL.Clear;
    qrTSitProd.SQL.Add(SqlTipoSitEstqs);
    Dados.StartTransaction(qrTSitProd);
    try
      if (not qrTSitProd.Active) then qrTSitProd.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrTSitProd, False)
      else
        if (RowModel.Count = 0) then
          RowModel.AddFieldsFromDataSet(qrTSitProd, False);
      while (not qrTSitProd.EOF) do
      begin
        Node := vtList.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtList.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrTSitProd, True);
          end;
        end;
        qrTSitProd.Next;
      end;
    finally
      if qrTSitProd.Active then qrTSitProd.Close;
      Dados.CommitTransaction(qrTSitProd);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdTSitEstq.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysEstq.TypeSitSupply[Pk] do
    begin
      PkTypeSupSit := FieldByName['PK_TIPO_SITUACAO_ESTOQUES'].AsInteger;
      DscTse       := FieldByName['DSC_TSE'].AsString;
      FlagBloq     := Boolean(FieldByName['FLAG_BLOQ'].AsInteger);
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdTSitEstq.SaveIntoDB;
var
  aRow: TDataRow;
  Data: PGridData;
begin
  if (ScrState in UPDATE_MODE) then
  begin
    aRow := TDataRow.Create(nil);
    try
      aRow.AddAs('PK_TIPO_SITUACAO_ESTOQUES', PkTypeSupSit, ftInteger, SizeOf(Integer));
      aRow.AddAs('DSC_TSE', DscTse, ftString, 31);
      aRow.AddAs('FLAG_BLOQ', Ord(FlagBloq), ftInteger, SizeOf(Integer));
      dmSysEstq.TypeSitSupply[Ord(ScrState)] := aRow;
      PkTypeSupSit := aRow.FieldByName['PK_TIPO_SITUACAO_ESTOQUES'].AsInteger;
    finally
      FreeAndNil(aRow);
    end;
  end;
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['PK_TIPO_SITUACAO_ESTOQUES'].AsInteger := PkTypeSupSit;
        Data^.DataRow.FieldByName['DSC_TSE'].AsString                    := DscTse;
      end;
    end;
  end;
  Pk := PkTypeSupSit;
end;

procedure TCdTSitEstq.SetDscTse(const Value: string);
begin
  eDsc_Tse.Text := Value;
end;

procedure TCdTSitEstq.SetFlagBloq(const Value: Boolean);
begin
  lFlag_Bloq.Checked := Value;
end;

procedure TCdTSitEstq.SetPkTypeSupSit(const Value: Integer);
begin
  ePk_Tipo_Situacao_Estoques.Text := IntToStr(Value);
end;

procedure TCdTSitEstq.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdTSitEstq.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_TSE'].AsString;
end;

procedure TCdTSitEstq.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_SITUACAO_ESTOQUES'].AsInteger;
end;

initialization
  RegisterClass(TCdTSitEstq);

end.
