unit SearchOrder;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, StdCtrls, ComCtrls, ToolWin, ExtCtrls, CurrEdit, Mask,
  ToolEdit, Buttons, GridRow, Menus, CadModel, TSysPedAux, TSysPed, PedArqSql;

type
  TSearchCrit     =(scOwner, scNick, scNumber, scClientNumber, scMoviment, scTMov,
                    scVendor, scRepresentant, scOrderPay, scOrderStatus,
                    scFlagPend, scFlagProd, scDatePed, scDateLib, scDateRec,
                    scDateLiq, scDateCanc, scDatePreEntr, scOrderVal, scOpen);

//  TExecuteAction  = (taNone, taScreenControl, taDataControl, taDisableAll,
//                     taStrings, taOrderNormal, taOrderColor);

//  TAction         = set of TExecuteAction;

  TSearchCriteria = set of TSearchCrit;



  TfmSearchOrder = class(TfrmModel)
    pSelectSearch: TPanel;
    lOrderDate: TStaticText;
    lin: TStaticText;
    lOrderVendor: TStaticText;
    lOrderMoviment: TStaticText;
    lOrderPay: TStaticText;
    lOrderNumber: TStaticText;
    lPurchaseOrder: TStaticText;
    sbSearchOwner: TSpeedButton;
    eOrderDate: TDateEdit;
    cbTypeDate: TComboBox;
    rgFlags: TRadioGroup;
    cbOrderVendor: TComboBox;
    cbOrderMoviment: TComboBox;
    cbOrderPay: TComboBox;
    eOrderNumber: TCurrencyEdit;
    cbPurchaseOrder: TComboBox;
    vtSearch: TVirtualStringTree;
    cbOrderOwner: TComboBox;
    cbSearch: TCoolBar;
    tbStatusBar: TToolBar;
    tbCheck: TToolButton;
    eSearchOwner: TEdit;
    cbOrderStatus: TComboBox;
    lOrderStatus: TStaticText;
    tbSearch: TToolButton;
    tbSepStt1: TToolButton;
    tbTools: TToolBar;
    tbRepresentant: TToolButton;
    tbSepVnd1: TToolButton;
    tbVendor: TToolButton;
    tbSepStt0: TToolButton;
    tbSepVnd0: TToolButton;
    tbSepStt2: TToolButton;
    tbInsert: TToolButton;
    cbSelNumber: TComboBox;
    cbVisibleEntrp: TCheckBox;
    pmFields: TPopupMenu;
    pmAddOrder: TMenuItem;
    pmOrderSql: TMenuItem;
    pmFlagFilter: TMenuItem;
    pmEqual: TMenuItem;
    pmNoEqual: TMenuItem;
    pmLessThan: TMenuItem;
    pmLessEQ: TMenuItem;
    pmGreaterThan: TMenuItem;
    pmGreaterEQ: TMenuItem;
    N2: TMenuItem;
    pmDates: TMenuItem;
    pmComplete: TMenuItem;
    pmDay: TMenuItem;
    pmMonth: TMenuItem;
    pmYear: TMenuItem;
    cbOwnerName: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbRepresentantClick(Sender: TObject);
    procedure tbVendorClick(Sender: TObject);
    procedure sbSearchOwnerClick(Sender: TObject);
    procedure cbOrderMovimentChange(Sender: TObject);
    procedure tbSearchClick(Sender: TObject);
    procedure vtSearchInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtSearchPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure tbCheckClick(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure vtSearchDblClick(Sender: TObject);
    procedure pmFieldsPopup(Sender: TObject);
    procedure pmOrderSqlClick(Sender: TObject);
    procedure pmFlagFilterClick(Sender: TObject);
  private
    { Private declarations }
    FSearchCriteria : TSearchCriteria;
    FAllOrders      : Boolean;
    FOrderTypes     : TOrderTypes;
    FMultiCompany   : Boolean;
    FActiveOrder    : TOrder;
    FStrIn          : string;
    FFkStatusOrder  : Integer;
    FFkOrderCompany : Integer;
    procedure GetRepresentants;
    procedure SearchOrders;
    procedure SetControls(AStt: Boolean);
    function  GetSqlInstruction(Operator: TSqlOperator;
                ACriteria: TSearchCrit): string;
    function  BuildSQL: string;
    function  FillSearchParams: Boolean;
    procedure SetParam(AParam: string; const AValue: Variant);
    procedure CheckAllItems(AValue: Boolean);
    function  GetSQLType: TStrings;
    procedure SetOrderTypes(const Value: TOrderTypes);
    procedure SetActiveOrder(const Value: TOrder);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  SQLTypeOrder  : TStrings    read GetSQLType;
    property  ActiveOrder   : TOrder      read FActiveOrder    write SetActiveOrder;
    property  FkOrderCompany: Integer     read FFkOrderCompany write FFkOrderCompany;
    property  FkStatusOrder : Integer     read FFkStatusOrder  write FFkStatusOrder;
  public
    { Public declarations }
    function  GetFkAlias: Integer;
    function  GetPkOwner: Integer;
    function  GetPkMoviment: Integer;
    function  GetPkTMov: Integer;
    function  GetPkVendor: Integer;
    function  GetPkOrderPayment: Integer;
    function  GetPkOrderStatus: Integer;
  published
    { Published declarations }
    property  OrderTypes    : TOrderTypes read FOrderTypes     write SetOrderTypes;
    property  MultiCompany  : Boolean     read FMultiCompany   write FMultiCompany;
  end;

var
  fmSearchOrder: TfmSearchOrder;

implementation

uses Dado, mSysPed, Funcoes, TSysCad, CmmConst, FuncoesDB,
  ProcType, ProcUtils;

{$R *.dfm}

const
  SQL_SEARCH: array [scOwner..scOpen, 1..3] of string =
  (('   and Ped.FK_CADASTROS           %s ', '',               ':fkcadastros         ' + #13),
   ('   and Cad.FK_TIPO_ALIAS          %s ', '',               ':fktipoalias         ' + #13),
   ('   and Ped.PK_PEDIDOS             %s ', '',               ':pkpedidos           ' + #13),
   ('   and Pit.NUM_EXT                %s ', '',               ':numextr             ' + #13),
   ('   and Ped.FK_GRUPOS_MOVIMENTOS   %s ', '',               ':fkgruposmovimentos  ' + #13),
   ('   and Ped.FK_TIPO_MOVIMENTOS     %s ', '',               ':fktipomovimentos    ' + #13),
   ('   and Ped.FK_VW_VENDEDORES       %s ', '',               ':fkvwvendedores      ' + #13),
   ('   and Ped.FK_VW_REPRESENTANTES   %s ', '',               ':fkvwrepresentantes  ' + #13),
   ('   and Ped.FK_TIPO_PAGAMENTOS     %s ', '',               ':fktipopagamentos    ' + #13),
   ('   and Ped.FK_TIPO_STATUS_PEDIDOS %s ', '',               ':fktipostatuspedidos ' + #13),
   ('   and Ped.FLAG_PEND              %s ', '',               ':flagPend            ' + #13),
   ('   and Ped.FLAG_PROD              %s ', '',               ':flagprod            ' + #13),
   ('   and Ped.DTA_PED                %s ', 'Ped.DTA_PED   ', ':dtaped              ' + #13),
   ('   and Ped.DTA_LIB                %s ', 'Ped.DTA_LIB   ', ':dtalib              ' + #13),
   ('   and Ped.DTA_RECB               %s ', 'Ped.DTA_RECB  ', ':dtarecb             ' + #13),
   ('   and Ped.DTA_LIQ                %s ', 'Ped.DTA_LIQ   ', ':dtaliq              ' + #13),
   ('   and Ped.DTA_CANC               %s ', 'Ped.DTA_CANC  ', ':dtacanc             ' + #13),
   ('   and Ped.PREV_ENTR              %s ', 'Ped.DTA_ENTR  ', ':dtaentr             ' + #13),
   ('   and Ped.VLR_PED                %s ', 'Ped.VLR_PED   ', ':vlrped              ' + #13),
   ('   and Ped.DTA_LIB                %s ' + #13 +
    '   and Ped.DTA_FAT                %s ' + #13 +
    '   and Ped.DTA_LIQ                %s ' + #13 +
    '   and Ped.DTA_CANC               %s ' + #13 +
    '   and Ped.PREV_ENTR              %s ', '',               ' is null ' + #13));

procedure TfmSearchOrder.LoadDefaults;
var
  aItem: TMovement;
begin
  aItem := nil;
  cbPurchaseOrder.Visible :=  (otPurchaseOrder in OrderTypes);
  lPurchaseOrder.Visible  :=  (otPurchaseOrder in OrderTypes);
  if (cbOrderMoviment.Items.Count = 0) then
  begin
    cbOrderMoviment.Items.AddStrings(dmSysPed.LoadMovement(OrderTypes, 0));
    with cbOrderMoviment do
    begin
      if (Items.Count > 1) then ItemIndex := 1;
      if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
        aItem := TMovement(Items.Objects[ItemIndex]);
    end;
  end;
  if (cbOrderMoviment.Items.Count = 0) and (aItem <> nil) then
    cbOrderMoviment.Items.AddStrings(dmSysPed.LoadMovement(OrderTypes,
       aItem.PkGroupMovement));
  if (cbOrderPay.Items.Count = 0) and (aItem <> nil) then
    cbOrderPay.Items.AddStrings(dmSysPed.LoadTypePayment(aItem.PkGroupMovement));
  if (cbOrderStatus.Items.Count = 0) and (aItem <> nil) then
    cbOrderStatus.Items.AddStrings(dmSysPed.LoadStatusType(aItem.PkGroupMovement));
  if (otPurchaseOrder in OrderTypes) and (cbPurchaseOrder.Visible) then
    if (cbPurchaseOrder.Items.Count = 0) and (aItem <> nil) then
      cbPurchaseOrder.Items.AddStrings(dmSysPed.LoadStatusType(aItem.PkGroupMovement));
end;

procedure TfmSearchOrder.ClearControls;
begin
  ReleaseTreeNodes(vtSearch);
  SetControls(True);
  FAllOrders                := False;
  tbSearch.ImageIndex       := 35;
  tbSearch.Tag              := 0;
  tbSearch.Down             := False;
  tbSearch.Caption          := 'Buscar';
  rgFlags.ItemIndex         := 0;
  cbOrderVendor.ItemIndex   := 0;
  cbOrderMoviment.ItemIndex := 0;
  cbOrderPay.ItemIndex      := 0;
  cbTypeDate.ItemIndex      := 0;
  cbPurchaseOrder.ItemIndex := 0;
  cbOrderStatus.ItemIndex   := 0;
  cbSelNumber.ItemIndex     := 0;
  cbOrderOwner.ItemIndex    := 0;
  eOrderDate.Clear;
  eOrderNumber.Clear;
  eSearchOwner.Clear;
  tbCheck.Enabled         := False;
end;

procedure TfmSearchOrder.FormShow(Sender: TObject);
begin
  vtSearch.NodeDataSize  := SizeOf(TGridData);
  pmFields.Images        := Dados.Image16;
  tbTools.Images         := Dados.Image16;
  tbStatusBar.Images     := Dados.Image16;
  cbSearch.Images        := Dados.Image16;
  vtSearch.Images        := Dados.Image16;
  vtSearch.Header.Images := Dados.Image16;
  Dados.Image16.GetBitmap(84, sbSearchOwner.Glyph);
end;

procedure TfmSearchOrder.tbRepresentantClick(Sender: TObject);
begin
  tbVendor.Down := (not tbRepresentant.Down);
  tbRepresentant.Down := (not tbVendor.Down);
  if tbRepresentant.Down then
    GetRepresentants;
end;

procedure TfmSearchOrder.tbVendorClick(Sender: TObject);
begin
  tbRepresentant.Down := (not tbVendor.Down);
  tbVendor.Down := (not tbRepresentant.Down);
  if tbVendor.Down then
    GetRepresentants;
end;

procedure TfmSearchOrder.GetRepresentants;
begin
  ReleaseCombos(cbOrderVendor, toObject);
  if tbVendor.Down then
  begin
    lOrderVendor.Caption := ' Vendedor:';
    cbOrderVendor.Items.AddStrings(dmSysPed.LoadVendors(False));
  end;
  if tbRepresentant.Down then
  begin
    lOrderVendor.Caption := ' Representante:';
    cbOrderVendor.Items.AddStrings(dmSysPed.LoadVendors(True));
  end;
end;

procedure TfmSearchOrder.sbSearchOwnerClick(Sender: TObject);
begin
// Search all Customers or Suppliers math with eSearchOwner
  ReleaseCombos(cbOrderOwner, toObject);
  if eSearchOwner.Visible then
  begin
    if otPurchaseOrder in OrderTypes then
      cbOrderOwner.Items.AddStrings(dmSysPed.LoadOwner(otPurchaseOrder,
        eSearchOwner.Text, toAll, (cbOwnerName.ItemIndex = 1)))
    else
      cbOrderOwner.Items.AddStrings(dmSysPed.LoadOwner(otRepresentant,
        eSearchOwner.Text, toAll, (cbOwnerName.ItemIndex = 1)));
    eSearchOwner.Visible := False;
    cbOrderOwner.Visible := True;
  end
  else
  begin
    eSearchOwner.Visible := True;
    cbOrderOwner.Visible := False;
  end;
end;

procedure TfmSearchOrder.cbOrderMovimentChange(Sender: TObject);
var
  aIdx: Integer;
begin
  aIdx := cbOrderMoviment.ItemIndex;
  if (aIdx > 0) and (cbOrderMoviment.Items.Objects[aIdx] <> nil) and
     (cbOrderMoviment.Items.Objects[aIdx] is TMovement) and
     (TMovement(cbOrderMoviment.Items.Objects[aIdx]).FlagExp) then
  begin
    ReleaseCombos(cbOrderOwner, toObject);
    cbOrderOwner.Items.AddStrings(dmSysPed.LoadOwner(otExportation, '', toAll));
  end;
end;

procedure TfmSearchOrder.tbSearchClick(Sender: TObject);
begin
  if (tbSearch.Tag = 0) then
  begin
    BuildSQL;
    if (FSearchCriteria = []) and (not FAllOrders) then exit;
    SearchOrders;
    Dados.DisplayHint(tbSearch, Format('Encontrados %d registros para a seleção atual',
      [vtSearch.RootNodeCount]));
  end
  else
    ClearControls;
end;

procedure TfmSearchOrder.SearchOrders;
var
  PNode,
  Node : PVirtualNode;
  Data : PGridData;
  PkPed: Integer;
begin
  PNode := nil;
  PkPed := 0;
  ReleaseTreeNodes(vtSearch);
  try
    with dmSysPed do
    begin
      qrOrders.SQL.Clear;
      qrOrders.SQL.Add(BuildSQL);
      Dados.StartTransaction(qrOrders);
      FillSearchParams;
      if (not qrOrders.Active) then qrOrders.Open;
      while (not qrOrders.Eof) do
      begin
        if (qrOrders.FieldByName('PK_PEDIDOS').AsInteger <> PkPed) then
        begin
          PNode  := vtSearch.AddChild(nil);
          if (PNode <> nil) then
          begin
            Data := vtSearch.GetNodeData(PNode);
            if (Data <> nil) then
            begin
              Data^.Level   := vtSearch.GetNodeLevel(PNode);
              Data^.Node    := PNode;
              Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrOrders, True);
            end;
          end;
        end;
        Node := vtSearch.AddChild(PNode);
        if (Node <> nil) then
        begin
          Data := vtSearch.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level := vtSearch.GetNodeLevel(Node);
            Data^.Node  := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrOrders, True);
          end;
        end;
        PkPed := qrOrders.FieldByName('PK_PEDIDOS').AsInteger;
        qrOrders.Next;
      end;
      if qrOrders.Active then qrOrders.Close;
      Dados.CommitTransaction(qrOrders);
    end;
    if vtSearch.RootNodeCount > 0 then
    begin
      Node := vtSearch.GetFirst;
      vtSearch.FocusedNode    := Node;
      vtSearch.Selected[Node] := True;
    end;
  except on E:Exception do
    begin
      if dmSysPed.qrOrders.Active then dmSysPed.qrOrders.Close;
      Dados.RollbackTransaction(dmSysPed.qrOrders);
      raise Exception.Create(E.Message + NL + dmSysPed.qrOrders.SQL.Text);
    end
  end;
  tbSearch.ImageIndex := 43;
  tbSearch.Tag        := -1;
  tbSearch.Down       := True;
  tbSearch.Caption    := 'Nova Busca';
  SetControls(False);
  tbCheck.Enabled         := True;
  cbOrderStatus.Enabled   := False;
  lOrderStatus.Enabled    := False;
end;

procedure TfmSearchOrder.SetControls(AStt: Boolean);
begin
  pmOrderSql.Enabled      := (not AStt);
  lOrderDate.Enabled      := AStt;
  lin.Enabled             := AStt;
  cbOwnerName.Enabled     := AStt;
  lOrderVendor.Enabled    := AStt;
  lOrderMoviment.Enabled  := AStt;
  lOrderPay.Enabled       := AStt;
  lOrderNumber.Enabled    := AStt;
  lPurchaseOrder.Enabled  := AStt;
  sbSearchOwner.Enabled   := AStt;
  eOrderDate.Enabled      := AStt;
  cbTypeDate.Enabled      := AStt;
  rgFlags.Enabled         := AStt;
  cbOrderVendor.Enabled   := AStt;
  cbOrderMoviment.Enabled := AStt;
  cbOrderPay.Enabled      := AStt;
  eOrderNumber.Enabled    := AStt;
  cbPurchaseOrder.Enabled := AStt;
  cbOrderOwner.Enabled    := AStt;
  eSearchOwner.Enabled    := AStt;
  tbCheck.Enabled         := AStt;
  cbOrderStatus.Enabled   := AStt;
  lOrderStatus.Enabled    := AStt;
  tbRepresentant.Enabled  := AStt;
  tbVendor.Enabled        := AStt;
  cbSelNumber.Enabled     := AStt;
end;

function TfmSearchOrder.GetSqlInstruction(Operator: TSqlOperator;
  ACriteria: TSearchCrit): string;
const
  QT = '''';
  _AND_ = '   and ';
var
  Line: string;
  DateOper: Integer;
begin
  if not (ACriteria in FSearchCriteria) then
    FSearchCriteria := FSearchCriteria + [ACriteria];
  if Operator < soEqual then exit;
  DateOper := 0;
  if Ord(Operator) > High(SQL_OPERATOR) then
  begin
    Operator := TSqlOperator(Ord(Operator) - High(SQL_OPERATOR));
    DateOper := High(SQL_OPERATOR) - Ord(Operator);
  end;
  if Ord(Operator) > INI_DATE_OPE then
  begin
    DateOper := Ord(Operator);
    Operator := soEqual;
  end;
  if (DateOper > 0) then
  begin
    Line := _AND_ + SQL_OPERATOR[DateOper];
    Line := Format(Line, [SQL_SEARCH[ACriteria, 2], SQL_OPERATOR[Ord(Operator)]]);
  end
  else
  begin
    Line := SQL_SEARCH[ACriteria, 1];
    Line := Format(Line, [SQL_OPERATOR[Ord(Operator)]]);
  end;
  Line := Format(Line, [SQL_SEARCH[ACriteria, 3]]);
  Result := Line;
end;

function TfmSearchOrder.BuildSQL: string;
const
  SELECT         = 'select Ped.PK_PEDIDOS, Ped.DTA_PED, Stt.DSC_STT, Ped.FK_EMPRESAS, ' + NL +
                   '       Cad.RAZ_SOC, Ped.DTA_FAT, Ped.DTA_LIQ, Ped.DTA_CANC, '   + NL +
                   '       Ped.FK_CADASTROS, Pit.PK_PEDIDOS_ITENS, Pit.REF_PRODUTO, ' + NL +
                   '       Prd.DSC_PROD, Pit.DTA_FAT as DTA_FAT_ITEN '              + NL +
                   '  from PEDIDOS Ped, CADASTROS Cad, TIPO_STATUS_PEDIDOS Stt, '   + NL +
                   '       PEDIDOS_ITENS Pit, PRODUTOS Prd '                        + NL +
                   ' where ((Ped.FK_EMPRESAS          = :fkempresas) '              + NL +
                   '    or ( -1                       = :fkempresas)) '             + NL +
                   '   and ((Ped.FLAG_TPED            = :FlagTPed) '                + NL +
                   '    or ( 5                       <> :FlagTPed)) '               + NL +
                   '   and Cad.PK_CADASTROS           = Ped.FK_CADASTROS '          + NL +
                   '   and Stt.PK_TIPO_STATUS_PEDIDOS = Ped.FK_TIPO_STATUS_PEDIDOS' + NL +
                   '   and Pit.FK_EMPRESAS            = Ped.FK_EMPRESAS '           + NL +
                   '   and Pit.FK_PEDIDOS             = Ped.PK_PEDIDOS '            + NL +
                   '   and Prd.PK_PRODUTOS            = Pit.FK_PRODUTOS '           + NL;
  SqlOrderBy     = ' order by Ped.FK_EMPRESAS, Ped.PK_PEDIDOS, Pit.PK_PEDIDOS_ITENS';
var
  SqlAux: string;
begin
  Result := '';
  FSearchCriteria := [];
  SqlAux := SELECT;
  if (cbOrderOwner.ItemIndex > 0) then
  begin
    case cbOwnerName.ItemIndex of
      0: SqlAux     := SqlAux + GetSqlInstruction(TSqlOperator(cbOrderOwner.Tag), scOwner);
      1: SqlAux     := SqlAux + GetSqlInstruction(TSqlOperator(cbOrderOwner.Tag), scNick)
    end;
  end;
  if (cbSelNumber.ItemIndex >= 0) and (eOrderNumber.Value > 0)  then
  begin
    case cbSelNumber.ItemIndex of
      0: SqlAux     := SqlAux + GetSqlInstruction(TSqlOperator(eOrderNumber.Tag), scClientNumber);
      1: SqlAux     := SqlAux + GetSqlInstruction(TSqlOperator(eOrderNumber.Tag), scNumber)
    end
  end;
  if cbOrderMoviment.ItemIndex > 0 then
  begin
    SqlAux          := SqlAux + GetSqlInstruction(TSqlOperator(cbOrderMoviment.Tag), scMoviment);
    SqlAux          := SqlAux + GetSqlInstruction(TSqlOperator(cbOrderMoviment.Tag), scTMov);
  end;
//  if cbOrderType.ItemIndex > 0 then
//    SqlAux          := SqlAux + GetSqlInstruction(TSqlOperator(cbOrderType.Tag), scType);
  if cbOrderVendor.ItemIndex > 0 then
    SqlAux          := SqlAux + GetSqlInstruction(TSqlOperator(cbOrderVendor.Tag), scVendor);
  if cbOrderPay.ItemIndex > 0 then
    SqlAux          := SqlAux + GetSqlInstruction(TSqlOperator(cbOrderPay.Tag), scOrderPay);
  if cbOrderStatus.ItemIndex > 0 then
    SqlAux          := SqlAux + GetSqlInstruction(TSqlOperator(cbOrderStatus.Tag), scOrderStatus);
  if rgFlags.ItemIndex > 0 then
  begin
    case rgFlags.ItemIndex of
      1: SqlAux := SqlAux + GetSqlInstruction(soEqual, scFlagPend);
      2: SqlAux := SqlAux + GetSqlInstruction(soIsNull, scOpen);
      3: SqlAux := SqlAux + GetSqlInstruction(soEqual, scFlagPend);
    end;
  end;
  if (eOrderDate.Date <> 0) and (cbTypeDate.ItemIndex > -1) then
    SqlAux := SqlAux + GetSqlInstruction(TSqlOperator(eOrderDate.Tag),
      TSearchCrit(cbTypeDate.ItemIndex + Integer(scDatePed)));
  if (FSearchCriteria = []) and (not FAllOrders) then
    if Application.MessageBox(PChar(Dados.GetStringMessage(LANGUAGE, 'sNoFilterSel',
         'Atenção: Nenhum critério de busca foi selecionado. Deseja Continuar?')),
         PChar(Application.Title), MB_ICONWARNING + MB_YESNO) = mrNo then
    begin
      tbSearch.Down := False;
      exit
    end
    else
      FAllOrders := True;
  Result := SqlAux + SqlOrderBy;
end;

function TfmSearchOrder.FillSearchParams: Boolean;
begin
  Result := True;
  with dmSysPed do
  begin
    try
      if (qrOrders.Params.FindParam('fkempresas') <> nil) then
        if (cbVisibleEntrp.Checked) and (not MultiCompany) then
          qrOrders.ParamByName('fkempresas').AsInteger := Dados.PkCompany
        else
          qrOrders.ParamByName('fkempresas').AsInteger := -1;
      if (qrOrders.Params.FindParam('FlagTPed') <> nil) then
         if (otPurchaseOrder in OrderTypes) then
           qrOrders.ParamByName('FlagTPed').AsInteger := Ord(otPurchaseOrder)
         else
           qrOrders.ParamByName('FlagTPed').AsInteger := 0;
      if (scOwner in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scOwner, 3]), GetPkOwner);
      if (scNick in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scNick, 3]), GetFkAlias);
      if (scNumber in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scNumber, 3]), eOrderNumber.AsInteger);
      if (scClientNumber in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scClientNumber, 3]), eOrderNumber.AsInteger);
      if (scMoviment in FSearchCriteria) then
      begin
        SetParam(Trim(SQL_SEARCH[scMoviment, 3]), GetPkMoviment);
        SetParam(Trim(SQL_SEARCH[scTMov, 3]), GetPkTMov);
      end;
//      if (scType in FSearchCriteria) then
//        SetParam(Trim(SQL_SEARCH[scType, 3]), GetPkOrderType);
      if (scVendor in FSearchCriteria) then
        if tbVendor.Down then
          SetParam(Trim(SQL_SEARCH[scVendor, 3]), GetPkVendor)
        else
          SetParam(Trim(SQL_SEARCH[scRepresentant, 3]), GetPkVendor);
      if (scOrderPay in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scOrderPay, 3]), GetPkOrderPayment);
      if (scOrderStatus in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scOrderStatus, 3]), GetPkOrderStatus);
      if (scFlagPend in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scFlagPend, 3]), 1);
      if (scFlagProd in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scFlagProd, 3]), 1);
      if (scDatePed in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scFlagProd, 3]), eOrderDate.Date);
      if (scDateLib in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scDateLib, 3]), eOrderDate.Date);
      if (scDateRec in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scDateRec, 3]), eOrderDate.Date);
      if (scDateLiq in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scDateLiq, 3]), eOrderDate.Date);
      if (scDateCanc in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scDateCanc, 3]), eOrderDate.Date);
      if (scDatePreEntr in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scDatePreEntr, 3]), eOrderDate.Date);
      if (scOpen in FSearchCriteria) then
        SetParam(Trim(SQL_SEARCH[scOpen, 3]), eOrderDate.Date);
    except
      Result := False;
    end;
  end;
end;

procedure TfmSearchOrder.SetParam(AParam: string; const AValue: Variant);
begin
  with dmSysPed do
  begin
    if Pos(':', AParam) > 0 then
      Delete(AParam, Pos(':', AParam), 1);
    if (qrOrders.Params.FindParam(AParam) <> nil) then
      qrOrders.ParamByName(AParam).Value := AValue;
  end;
end;

function  TfmSearchOrder.GetFkAlias: Integer;
begin
  Result := cbOrderOwner.ItemIndex;
  if (Result > 0) and (cbOrderOwner.Items.Objects[Result] <> nil) and
     (cbOrderOwner.Items.Objects[Result] is TOwner) then
    Result := TOwner(cbOrderOwner.Items.Objects[Result]).FkAlias
  else
    Result := 0;
end;

function  TfmSearchOrder.GetPkOwner: Integer;
begin
  Result := cbOrderOwner.ItemIndex;
  if (Result > 0) and (cbOrderOwner.Items.Objects[Result] <> nil) and
     (cbOrderOwner.Items.Objects[Result] is TOwner) then
    Result := TOwner(cbOrderOwner.Items.Objects[Result]).PkCadastros
  else
    Result := 0;
end;

function  TfmSearchOrder.GetPkMoviment: Integer;
begin
  Result := cbOrderMoviment.ItemIndex;
  if (Result > 0) and (cbOrderMoviment.Items.Objects[Result] <> nil) and
     (cbOrderMoviment.Items.Objects[Result] is TMovement) then
    Result := TMovement(cbOrderMoviment.Items.Objects[Result]).PkGroupMovement
  else
    Result := 0;
end;

function  TfmSearchOrder.GetPkTMov: Integer;
begin
  Result := cbOrderMoviment.ItemIndex;
  if (Result > 0) and (cbOrderMoviment.Items.Objects[Result] <> nil) and
     (cbOrderMoviment.Items.Objects[Result] is TMovement) then
    Result := TMovement(cbOrderMoviment.Items.Objects[Result]).PkTypeMovement
  else
    Result := 0;
end;

function  TfmSearchOrder.GetPkVendor: Integer;
begin
    Result := 0;
end;

function  TfmSearchOrder.GetPkOrderPayment: Integer;
begin
  Result := 0;
  if (Result > 0) and (cbOrderPay.Items.Objects[Result] <> nil) and
     (cbOrderPay.Items.Objects[Result] is TTypePayment) then
    Result := TTypePayment(cbOrderPay.Items.Objects[Result]).PkTypePgto;
end;

function  TfmSearchOrder.GetPkOrderStatus: Integer;
begin
  Result := cbOrderStatus.ItemIndex;
  if (Result > 0) and (cbOrderStatus.Items.Objects[Result] <> nil) and
     (cbOrderStatus.Items.Objects[Result] is TOrderStatus) then
    Result := TOrderStatus(cbOrderStatus.Items.Objects[Result]).PkOrderStatus
  else
    Result := 0;
end;

procedure TfmSearchOrder.vtSearchInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Data^.Level > 0) or
     (Data^.DataRow.FindField['DTA_LIQ'] = nil) or
     (Data^.DataRow.FindField['DTA_CANC'] = nil) then
    exit;
  if (not (Data^.DataRow.FieldByName['DTA_LIQ'].IsNull)) or
     (not (Data^.DataRow.FieldByName['DTA_CANC'].IsNull)) then
  begin
    Node.CheckType  := ctCheckBox;
    Node.CheckState := csUncheckedNormal;
  end;
end;

procedure TfmSearchOrder.vtSearchGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Data^.Level = 0 then
    case Column of
      0: CellText := Data^.DataRow.FieldByName['PK_PEDIDOS'].AsString;
      1: CellText := Data^.DataRow.FieldByName['DTA_PED'].AsString;
      2: CellText := Data^.DataRow.FieldByName['DSC_STT'].AsString;
      3: CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
      4: CellText := Data^.DataRow.FieldByName['DTA_FAT'].AsString;
      5: CellText := Data^.DataRow.FieldByName['DTA_LIQ'].AsString;
      6: CellText := Data^.DataRow.FieldByName['DTA_CANC'].AsString;
    end;
  if Data^.Level > 0 then
    case Column of
      0: CellText := Data^.DataRow.FieldByName['PK_PEDIDOS_ITENS'].AsString +
         ' - ' + Data^.DataRow.FieldByName['REF_PRODUTO'].AsString;
      1: ;
      2: ;
      3: CellText := Data^.DataRow.FieldByName['DSC_PROD'].AsString;
      4: CellText := Data^.DataRow.FieldByName['DTA_FAT_ITEN'].AsString;
      5: ;
    end;
end;

procedure TfmSearchOrder.vtSearchPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Data^.Level > 0) then exit;
  if Data^.DataRow.FieldByName['DTA_FAT'].AsDateTime > 0 then
    TargetCanvas.Font.Color := COLOR_STATUS[osInvoiced];
  if Data^.DataRow.FieldByName['DTA_LIQ'].AsDateTime > 0 then
    TargetCanvas.Font.Color := COLOR_STATUS[osEliminated];
  if Data^.DataRow.FieldByName['DTA_CANC'].AsDateTime > 0 then
    TargetCanvas.Font.Color := COLOR_STATUS[osCanceled];
end;

procedure TfmSearchOrder.tbCheckClick(Sender: TObject);
begin
  ShowMessage('SQL usado:' + NL + dmSysPed.qrOrders.SQL.Text);
end;

procedure TfmSearchOrder.tbInsertClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
  aForm: TfrmModel;
begin
  if (not (Parent is TTabSheet)) or
     (TTabSheet(Parent).PageControl = nil) then exit;
  TTabSheet(Parent).PageControl.TabIndex := 1;
  if Assigned(TTabSheet(Parent).PageControl.OnChange) then
    TTabSheet(Parent).PageControl.OnChange(Self);
  aForm := TfrmModel(TTabSheet(Parent).PageControl.Pages[1].Tag);
  if (aForm = nil) or (not (aForm is TfrmModel)) then exit;
  if (vtSearch.RootNodeCount > 0) then
  begin
    Node := vtSearch.FocusedNode;
    if Node <> nil then
    begin
      Data := vtSearch.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow.FindField['PK_PEDIDOS'] <> nil) then
        ActiveOrder.PkOrder := Data^.DataRow.FieldByName['PK_PEDIDOS'].AsInteger;
    end;
  end;
  aForm.Pk := Pk;
  aForm.ScrState := dbmInsert;
end;

procedure TfmSearchOrder.vtSearchDblClick(Sender: TObject);
var
  Data : PGridData;
  Node : PVirtualNode;
  aAllowChange: Boolean;
begin
  Node := vtSearch.FocusedNode;
  if (Node = nil) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Data^.Level > 0) then exit;
  FkOrderCompany := 0;
  FkStatusOrder  := 0;
  FkOrderCompany := Data^.DataRow.FieldByName['FK_EMPRESAS'].AsInteger;
  FkStatusOrder  := Data^.DataRow.FieldByName['FK_STATUS_PEDIDOS'].AsInteger;
  Pk             := Data^.DataRow.FieldByName['PK_PEDIDOS'].AsInteger;
  if (Parent is TTabSheet) then
  begin
    aAllowChange := True;
    if Assigned(TTabSheet(Parent).PageControl.OnChanging) then
      TTabSheet(Parent).PageControl.OnChanging(Self, aAllowChange);
    if aAllowChange then
    begin
      TTabSheet(Parent).PageControl.TabIndex := 1;
      if Assigned(TTabSheet(Parent).PageControl.OnChange) then
        TTabSheet(Parent).PageControl.OnChange(Self);
    end;
  end;
end;

procedure TfmSearchOrder.pmFieldsPopup(Sender: TObject);
var
  aVisible: Boolean;
begin
  if pmFields.PopupComponent = nil then exit;
  with pmFields.PopupComponent do
  begin
    aVisible               := (Name <> 'vtSearch');
    pmFlagFilter.Visible   := aVisible;
    pmEqual.Visible        := aVisible;
    pmNoEqual.Visible      := aVisible;
    aVisible               := (Name <> 'rgFlags');
    pmLessThan.Visible     := aVisible;
    pmLessEQ.Visible       := aVisible;
    pmGreaterThan.Visible  := aVisible;
    pmGreaterEQ.Visible    := aVisible;
    aVisible               := (Name = 'eOrderDate');
    pmDates.Visible        := aVisible;
    pmComplete.Visible     := aVisible;
    pmDay.Visible          := aVisible;
    pmMonth.Visible        := aVisible;
    pmYear.Visible         := aVisible;
    pmDates.Visible        := aVisible;
  end;
end;

procedure TfmSearchOrder.pmOrderSqlClick(Sender: TObject);
begin
// Show SQL from order
  if (dmSysPed.qrOrders.SQL.Text = '') then exit;
  Dados.DisplayMessage(dmSysPed.qrOrders.SQL.Text, hiQuestion);
end;

procedure TfmSearchOrder.pmFlagFilterClick(Sender: TObject);
begin
  if (pmFields.PopupComponent <> nil) and (Sender is TMenuItem) then
  begin
    CheckAllItems(False);
    TMenuItem(Sender).Checked := True;
    if pmFields.PopupComponent.Tag > -1 then
    begin
      if pmFields.PopupComponent.Tag < 11 then
        if TMenuItem(Sender).Tag > 11 then
          pmFields.PopupComponent.Tag := TMenuItem(Sender).Tag +
                                         pmFields.PopupComponent.Tag
        else
          pmFields.PopupComponent.Tag := TMenuItem(Sender).Tag
      else
        if TMenuItem(Sender).Tag < 11 then
          pmFields.PopupComponent.Tag := TMenuItem(Sender).Tag +
                                         pmFields.PopupComponent.Tag
        else
          pmFields.PopupComponent.Tag := TMenuItem(Sender).Tag;
    end
    else
      pmFields.PopupComponent.Tag := TMenuItem(Sender).Tag;
  end;
end;

procedure TfmSearchOrder.CheckAllItems(AValue: Boolean);
begin
  pmEqual.Checked        := AValue;
  pmNoEqual.Checked      := AValue;
  pmLessThan.Checked     := AValue;
  pmLessEQ.Checked       := AValue;
  pmGreaterThan.Checked  := AValue;
  pmGreaterEQ.Checked    := AValue;
  // Dates
  pmComplete.Checked     := AValue;
  pmDay.Checked          := AValue;
  pmMonth.Checked        := AValue;
  pmYear.Checked         := AValue;
end;

function TfmSearchOrder.GetSQLType: TStrings;
begin
  Result := TStringList.Create;
  Result.Add(SqlTipoPedidos);
  if FStrIn <> '' then
    Result.Add(Format('   and FLAG_TPED in (%s)', [FStrIn]));
  Result.Add(' order by DSC_TPED');
end;

procedure TfmSearchOrder.SetOrderTypes(const Value: TOrderTypes);
begin
  FOrderTypes := Value;
  FStrIn := '';
  if otBudget in OrderTypes then
    FStrIn := '0';
  if otRepresentant in OrderTypes then
    if FStrIn = '' then
      FStrIn := '1'
    else
      FStrIn := FStrIn + ', 1';
  if otExportation in OrderTypes then
    if FStrIn = '' then
      FStrIn := '2'
    else
      FStrIn := FStrIn + ', 2';
  if otBranch in OrderTypes then
    if FStrIn = '' then
      FStrIn := '3'
    else
      FStrIn := FStrIn + ', 3';
  if otInternet in OrderTypes then
    if FStrIn = '' then
      FStrIn := '4'
    else
      FStrIn := FStrIn + ', 4';
  if otPurchaseOrder in OrderTypes then
    if FStrIn = '' then
      FStrIn := '5'
    else
      FStrIn := FStrIn + ', 5';
  if otAssistance in OrderTypes then
    if FStrIn = '' then
      FStrIn := '6'
    else
      FStrIn := FStrIn + ', 6';
end;

procedure TfmSearchOrder.SetActiveOrder(const Value: TOrder);
begin
  FActiveOrder.Clear;
  if (Value <> nil) then
  begin
    FActiveOrder.Assign(Value);
    if FActiveOrder.PkOrder > 0 then
      Pk := FActiveOrder.PkOrder;
  end;
end;

procedure TfmSearchOrder.MoveDataToControls;
begin
//  NothingToDo
end;

procedure TfmSearchOrder.SaveIntoDB;
begin
//  NothingToDo
end;

end.
