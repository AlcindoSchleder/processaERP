unit CadParamsPed;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 18/04/2003 - DD/MM/YYYY                                    *}
{* Modified : 18/05/2003 - DD/MM/YYYY                                    *}
{* Version  : 1.0.0.0                                                    *}
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
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ProcUtils,
  Mask, ToolEdit, CurrEdit, TSysPedAux, ExtCtrls, ImgList;

type
  TCdParamsPed = class(TfrmModelList)
    eFk_Tipo_Status_Pedidos: TComboBox;
    eFk_Tipo_Prazo_Entrega: TComboBox;
    gbTitle: TGroupBox;
    lTitle: TLabel;
    lFk_Tipo_Status_Pedidos: TStaticText;
    lFk_Tipo_Prazo_Entrega: TStaticText;
    lPrz_Val_Orc: TStaticText;
    lPrz_Entr: TStaticText;
    ePrz_Val_Orc: TCurrencyEdit;
    ePrz_Entr: TCurrencyEdit;
    lFlag_Itm_Dsct: TCheckBox;
    lFk_Grupos_Movimentos: TStaticText;
    eFk_Grupos_Movimentos: TComboBox;
    lFlag_TPed: TStaticText;
    eFlag_TPed: TComboBox;
    lPk_Parametros_Ped: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetFkStatusOrder : Integer;
    function  GetFkTypeDelivery: Integer;
    function  GetPrzValOrder   : Integer;
    function  GetPrzEntr       : Integer;
    function  GetFlagItmDsct   : Boolean;
    function  GetOrderTypes    : TOrderTypes;
    function  GetPkParamsPed   : Integer;
    procedure SetFkStatusOrder(const Value: Integer);
    procedure SetFkTypeDelivery(const Value: Integer);
    procedure SetPrzValOrder(const Value: Integer);
    procedure SetPrzEntr(const Value: Integer);
    procedure SetFlagItmDsct(const Value: Boolean);
    procedure SetPkParamsPed(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property PkParamsPed   : Integer     read GetPkParamsPed     write SetPkParamsPed;
    property FkStatusOrder : Integer     read GetFkStatusOrder   write SetFkStatusOrder;
    property FkTypeDelivery: Integer     read GetFkTypeDelivery  write SetFkTypeDelivery;
    property PrzValOrder   : Integer     read GetPrzValOrder     write SetPrzValOrder;
    property PrzEntr       : Integer     read GetPrzEntr         write SetPrzEntr;
    property FlagItmDsct   : Boolean     read GetFlagItmDsct     write SetFlagItmDsct;
    property OrderTypes    : TOrderTypes read GetOrderTypes;
  end;

var
  CdParamsPed: TCdParamsPed;

implementation

uses Dado, mSysPed, GridRow, DB, ProcType, PedArqSql;

{$R *.dfm}

{ TCdParams }

function TCdParamsPed.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  S := '';
  C := nil;
  Result := True;
  if (PkParamsPed < 0) or (PkParamsPed > 1) then
  begin
    C := lPk_Parametros_Ped;
    S := 'Campo Tipo de parâmetro deve ser preenchido';
  end;
  if (FkStatusOrder = 0) then
  begin
    C := eFk_Tipo_Status_Pedidos;
    S := 'Campo Tipo de Status default deve ser preenchido';
  end;
  if (FkTypeDelivery = 0) then
  begin
    C := eFk_Tipo_Prazo_Entrega;
    S := 'Campo Tipo Prazo de Entrega default deve ser preenchido';
  end;
  if (PrzValOrder = 0) then
  begin
    C := ePrz_Val_Orc;
    S := 'Campo quantidade de dias de validade do orçamento deve ser preenchido';
  end;
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdParamsPed.ClearControls;
begin
  Loading := True;
  try
    PkParamsPed    := Pk;
    FkStatusOrder  := 0;
    FkTypeDelivery := 0;
    PrzValOrder    := 0;
    PrzEntr        := 0;
    FlagItmDsct    := False;
  finally
    Loading := False;
  end;
end;

function TCdParamsPed.GetFkStatusOrder: Integer;
begin
  Result := 0;
  with eFk_Tipo_Status_Pedidos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOrderStatus(Items.Objects[ItemIndex]).PkOrderStatus;
end;

function TCdParamsPed.GetFkTypeDelivery: Integer;
begin
  Result := 0;
  with eFk_Tipo_Prazo_Entrega do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdParamsPed.GetPrzValOrder: Integer;
begin
  Result := ePrz_Val_Orc.AsInteger;
end;

function TCdParamsPed.GetPrzEntr: Integer;
begin
  Result := ePrz_Entr.AsInteger;
end;

procedure TCdParamsPed.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFlag_TPed.Items.AddStrings(OrderTypesDescr(OrderTypes));
    eFk_Tipo_Prazo_Entrega.Items.AddStrings(dmSysPed.LoadTypeDelivery);
    eFk_Tipo_Status_Pedidos.Items.AddStrings(dmSysPed.LoadStatusType(0));
    ListLoaded := True;
  end;
end;

procedure TCdParamsPed.LoadList(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
  Flag: Integer;
  function AddNodeData(Node: PVirtualNode; AFlag: Integer): PVirtualNode;
  begin
    with vtList do
    begin
      Result := AddChild(Node);
      if (Result <> nil) then
      begin
        Data := GetNodeData(Result);
        if (Data <> nil) then
        begin
          Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysPed.qrSqlAux, True);
          Data^.DataRow.FieldByName['PK_PARAMETROS_PED'].AsInteger := AFlag;
          Data^.Node    := Result;
          Data^.Level   := GetNodeLevel(Result);
          if (Data^.Level = 0) then
            Data^.NodeType := tnFolder
          else
            Data^.NodeType := tnData;
        end;
      end;
    end;
  end;
begin
  inherited;
  Node := nil;
  with dmSysPed, vtList do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlAllParams);
    qrSqlAux.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    BeginUpdate;
    Flag := -1;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    try
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(nil, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        if (Flag <> qrSqlAux.FieldByName('PK_PARAMETROS_PED').AsInteger) then
          Node := AddNodeData(nil, qrSqlAux.FieldByName('PK_PARAMETROS_PED').AsInteger);
        if (Node <> nil) then
          AddNodeData(Node, qrSqlAux.FieldByName('PK_PARAMETROS_PED').AsInteger);
        Flag := qrSqlAux.FieldByName('PK_PARAMETROS_PED').AsInteger;
        qrSqlAux.Next;
      end;
      if (Flag = 0) then
        AddNodeData(nil, 1);
    finally
      EndUpdate;
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
    if (RootNodeCount > 0) then
    begin
      FullExpand;
      FocusedNode         := GetFirst;
      Selected[FocusedNode] := True;
    end;
  end;
end;

procedure TCdParamsPed.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysPed.ParamsPed[Pk] do
    begin
      FkStatusOrder   := FieldByName['FK_TIPO_STATUS_PEDIDOS'].AsInteger;
      FkTypeDelivery  := FieldByName['FK_TIPO_PRAZO_ENTREGA'].AsInteger;
      PrzValOrder     := FieldByName['PRZ_VAL_ORC'].AsInteger;
      PrzEntr         := FieldByName['PRZ_ENTR'].AsInteger;
      FlagItmDsct     := Boolean(FieldByName['FLAG_ITM_DSCT'].AsInteger);
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdParamsPed.SaveIntoDB;
var
  aData: TDataRow;
  Data : PGridData;
  APk  : Integer;
begin
  if (vtList.FocusedNode = nil) then exit;
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  APk := Data^.DataRow.FieldByName['PK_EMPRESAS'].AsInteger;
  if (APk = 0) then exit;
  aData := TDataRow.Create(nil);
  try
    aData.AddAs('FK_EMPRESAS', APk, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_TIPO_STATUS_PEDIDOS', FkStatusOrder, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_TIPO_PRAZO_ENTREGA', FkTypeDelivery, ftInteger, SizeOf(Integer));
    aData.AddAs('PRZ_VAL_ORC', PrzValOrder, ftInteger, SizeOf(Integer));
    aData.AddAs('PRZ_ENTR', PrzEntr, ftInteger, SizeOf(Integer));
    aData.AddAs('FLAG_ITM_DSCT', Ord(FlagItmDsct), ftInteger, SizeOf(Integer));
    dmSysPed.ParamsPed[Ord(ScrState)] := aData;
    Pk := APk;
  finally
    FreeAndNil(aData);
  end;
end;

procedure TCdParamsPed.SetFkStatusOrder(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Status_Pedidos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (TOrderStatus(Items.Objects[i]).PkOrderStatus = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParamsPed.SetFkTypeDelivery(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Prazo_Entrega do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParamsPed.SetPrzValOrder(const Value: Integer);
begin
  ePrz_Val_Orc.AsInteger := Value
end;

procedure TCdParamsPed.SetPrzEntr(const Value: Integer);
begin
  ePrz_Entr.AsInteger := Value;
end;

procedure TCdParamsPed.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
//  CanInsertNode := False;
end;

procedure TCdParamsPed.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
const
  FOLDER_DSC: array [0..1] of string = ('Entrada de Mercadorias', 'Saída de Mercadorias');
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Data^.Level of
    0: CellText := FOLDER_DSC[Data^.DataRow.FieldByName['PK_PARAMETROS_PED'].AsInteger];
    1: CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
  end;
end;

procedure TCdParamsPed.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  inherited;
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['FK_EMPRESAS'].AsInteger;
end;

function TCdParamsPed.GetFlagItmDsct: Boolean;
begin
  Result := lFlag_Itm_Dsct.Checked;
end;

procedure TCdParamsPed.SetFlagItmDsct(const Value: Boolean);
begin
  lFlag_Itm_Dsct.Checked := Value;
end;

function TCdParamsPed.GetOrderTypes: TOrderTypes;
var
  Data: PGridData;
begin
  Result := [otBudget, otRepresentant, otExportation, otBranch, otInternet];
  with vtList do
  begin
    if (vtList.RootNodeCount = 0) then exit;
    if (FocusedNode = nil) then
      FocusedNode := GetFirst;
    Data := GetNodeData(FocusedNode);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      if (Data^.DataRow.FieldByName['PK_PARAMETROS_PED'].AsInteger = 0) then
        Result := [otPurchaseOrder, otAssistance];
    end;
  end;
end;

function TCdParamsPed.GetPkParamsPed: Integer;
begin
  Result := lPk_Parametros_Ped.ItemIndex;
end;

procedure TCdParamsPed.SetPkParamsPed(const Value: Integer);
begin
  lPk_Parametros_Ped.ItemIndex := Value;
end;

procedure TCdParamsPed.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
var
  Data: PGridData;
begin
  if (Node = nil) or (Kind in [ikState, ikOverlay]) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data <> nil) and (Data^.NodeType = tnFolder) then
  begin
    ImageIndex := 22;
    ImageIndex := 22;
  end
  else
    inherited;
end;

initialization
  RegisterClass(TCdParamsPed);

end.
