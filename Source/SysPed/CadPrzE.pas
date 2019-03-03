unit CadPrzE;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 18/04/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, Mask, ProcUtils,
  ToolEdit, CurrEdit, ExtCtrls;

type
  TCdDelivery = class(TfrmModelList)
    lPk_Tipo_Prazo_Entrega: TStaticText;
    eDsc_PrzE: TEdit;
    lDsc_PrzE: TStaticText;
    lQtd_Prv: TStaticText;
    eQtd_Prv: TCurrencyEdit;
    ePk_Tipo_Prazo_Entrega: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscPrzE: string;
    function  GetPkTypeDelivery: Integer;
    function  GetQtdPrv: Integer;
    procedure SetDscPrzE(const Value: string);
    procedure SetPkTypeDelivery(const Value: Integer);
    procedure SetQtdPrv(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkTypeDelivery: Integer read GetPkTypeDelivery write SetPkTypeDelivery;
    property  DscPrzE       : string  read GetDscPrzE        write SetDscPrzE;
    property  QtdPrv        : Integer read GetQtdPrv         write SetQtdPrv;
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysPed, PedArqSql, GridRow, ProcType, DB;

{$R *.dfm}

{ TCdDelivery }

function TCdDelivery.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (DscPrzE = '') then
  begin
    S := 'Campo Descrição deve ser preenchido';
    C := eDsc_PrzE;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdDelivery.ClearControls;
begin
  Loading := True;
  try
    PkTypeDelivery := 0;
    DscPrzE        := '';
    QtdPrv         := 0;
  finally
    Loading := False;
  end;
end;

function TCdDelivery.GetDscPrzE: string;
begin
  Result := eDsc_PrzE.Text;
end;

function TCdDelivery.GetPkTypeDelivery: Integer;
begin
  Result := ePk_Tipo_Prazo_Entrega.AsInteger;
end;

function TCdDelivery.GetQtdPrv: Integer;
begin
  Result := eQtd_Prv.AsInteger;
end;

procedure TCdDelivery.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdDelivery.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysPed, vtList do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlDeliveryPeriods);
    Dados.StartTransaction(qrSqlAux);
    BeginUpdate;
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        AddDataNode(nil, qrSqlAux);
        qrSqlAux.Next;
      end;
    finally
      EndUpdate;
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
    if (RootNodeCount > 0) then
    begin
      FocusedNode           := GetFirst;
      Selected[FocusedNode] := True;
    end;
  end;
end;

procedure TCdDelivery.MoveDataToControls;
var
  aItem: TDataRow;
begin
  Loading := True;
  try
    aItem          := dmSysPed.DeliveryPeriod[Pk];
    PkTypeDelivery := aItem.FieldByName['PK_TIPO_PRAZO_ENTREGA'].AsInteger;
    DscPrzE        := aItem.FieldByName['DSC_PRZE'].AsString;
    QtdPrv         := aItem.FieldByName['QTD_PRV'].AsInteger;
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
end;

procedure TCdDelivery.SaveIntoDB;
var
  aItem: TDataRow;
  Data : PGridData;
begin
  aItem := TDataRow.Create(nil);
  try
    aItem.AddAs('PK_TIPO_PRAZO_ENTREGA', PkTypeDelivery, ftInteger, SizeOf(Integer));
    aItem.AddAs('DSC_PRZE', DscPrzE, ftString, 31);
    aItem.AddAs('QTD_PRV', QtdPrv, ftInteger, SizeOf(Integer));
    dmSysPed.DeliveryPeriod[Ord(ScrState)] := aItem;
    with vtList do
    begin
      if (FocusedNode <> nil) then
      begin
        Data := GetNodeData(FocusedNode);
        if (Data <> nil) or (Data^.DataRow <> nil) then
        begin
          Data^.DataRow.FieldByName['PK_TIPO_PRAZO_ENTREGA'].AsInteger :=
            aItem.FieldByName['PK_TIPO_PRAZO_ENTREGA'].AsInteger;
          Data^.DataRow.FieldByName['DSC_PRZE'].AsString :=
            aItem.FieldByName['DSC_PRZE'].AsString;
        end;
      end;
    end;
    Pk := aItem.FieldByName['PK_TIPO_PRAZO_ENTREGA'].AsInteger;
  finally
    FreeAndNil(aItem);
  end;
end;

procedure TCdDelivery.SetDscPrzE(const Value: string);
begin
  eDsc_PrzE.Text := Value;
end;

procedure TCdDelivery.SetPkTypeDelivery(const Value: Integer);
begin
  ePk_Tipo_Prazo_Entrega.AsInteger := Value;
end;

procedure TCdDelivery.SetQtdPrv(const Value: Integer);
begin
  eQtd_Prv.AsInteger := Value;
end;

procedure TCdDelivery.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdDelivery.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_PRAZO_ENTREGA'].AsInteger;
end;

procedure TCdDelivery.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  with Data^.DataRow do
    CellText := FieldByName['PK_TIPO_PRAZO_ENTREGA'].AsString + ' / ' +
                FieldByName['DSC_PRZE'].AsString;
end;

initialization
  RegisterClass(TCdDelivery);

end.
