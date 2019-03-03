unit CadPedItem;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created  : 02/06/2003                                                 *}
{* Modified : 30/05/2006                                                 *}
{* Version  : 1.5.0.0                                                    *}
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
  Dialogs, ComCtrls, ToolWin, VirtualTrees, ExtCtrls, StdCtrls, Mask, ToolEdit,
  CurrEdit, Buttons, ProcUtils, PrcCombo, TSysEstq, TSysEstqAux, TSysConfAux,
  TSysPed, TSysPedAux, jpeg, CadModel;

type
  PItemsRecord = ^TItemsRecord;
  TItemsRecord = record
    State: TDBMode;
    Level: Integer;
    Node : PVirtualNode;
    Index: Integer;
    Item : TOrderItem;
  end;

  PConfRecord = ^TConfRecord;
  TConfRecord = record
    Level: Integer;
    Node : PVirtualNode;
    Index: Integer;
    Item : TConfItem;
  end;

  TBtnPageView = (pvPrior, pvNext);

  TTypeFieldValue = (fvQtd, fvVlr, fvAcrd, fvAll);

  TCdPedItem = class(TfrmModel)
    pgItems: TPageControl;
    cbItems: TCoolBar;
    tsGrid: TTabSheet;
    tsItems: TTabSheet;
    tbTools: TToolBar;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    tsConfig: TTabSheet;
    tbToolSep: TToolButton;
    tbSave: TToolButton;
    vtItems: TVirtualStringTree;
    vtConfig: TVirtualStringTree;
    pConfig: TPanel;
    eQtd_Comp_Tot: TCurrencyEdit;
    eQtd_Parcial: TCurrencyEdit;
    eQtd_Pec: TCurrencyEdit;
    lFk_Componentes: TStaticText;
    lFk_Tipo_Refernecias: TStaticText;
    lFk_Insumos: TStaticText;
    lQtd_Pec: TStaticText;
    lQtd_Parcial: TStaticText;
    lQtd_Comp_Ref: TStaticText;
    lFk_Produtos: TStaticText;
    eProd_Ref: TEdit;
    sbSearchProd: TSpeedButton;
    eQtd_Prod: TCurrencyEdit;
    eVlr_Unit: TCurrencyEdit;
    lQtd_Prod: TStaticText;
    lVlr_Unit: TStaticText;
    eLot_Item: TEdit;
    lSub_Tot: TStaticText;
    eSub_Tot: TCurrencyEdit;
    lVlr_Acr_Dsct: TStaticText;
    eVlr_Acr_Dsct: TCurrencyEdit;
    eTot_Item: TCurrencyEdit;
    lTot_Item: TStaticText;
    lFk_Tipo_Movimentos: TStaticText;
    lFk_Tabela_Precos: TStaticText;
    lFk_Unidades: TStaticText;
    eFk_Produtos: TPrcComboBox;
    eFk_Unidades: TPrcComboBox;
    eFk_Tipo_Movimentos: TPrcComboBox;
    eFk_Tabela_Precos: TPrcComboBox;
    eFk_Componentes: TPrcComboBox;
    eFk_Tipo_Referencias: TPrcComboBox;
    eFk_Insumos: TPrcComboBox;
    udQtdPec: TUpDown;
    pTaxes: TPanel;
    lAlq_ICMS: TStaticText;
    eAlq_ICMS: TCurrencyEdit;
    lAlq_ICMSS: TStaticText;
    eAlq_ICMSS: TCurrencyEdit;
    lAlq_ISS: TStaticText;
    eAlq_ISS: TCurrencyEdit;
    StaticText1: TStaticText;
    eAlq_IPI: TCurrencyEdit;
    lAlq_Otr: TStaticText;
    eAlq_Otr: TCurrencyEdit;
    imImpst: TImage;
    stProdTitle: TStaticText;
    lTot_Config: TStaticText;
    eTot_Config: TCurrencyEdit;
    lLot_Item: TStaticText;
    tbGridSep: TToolButton;
    tbContract: TToolButton;
    tbExpand: TToolButton;
    lTot_Ins: TStaticText;
    eTot_Ins: TCurrencyEdit;
    lNum_Extr: TStaticText;
    eNum_Extr: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eProd_RefKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eVlr_Acr_DsctChange(Sender: TObject);
    procedure eVlr_UnitChange(Sender: TObject);
    procedure eFk_Tabela_PrecosSelect(Sender: TObject);
    procedure eFk_ComponentesSelect(Sender: TObject);
    procedure eFk_Tipo_ReferenciasSelect(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure eProd_RefExit(Sender: TObject);
    procedure eFk_ProdutosSelect(Sender: TObject);
    procedure sbSearchProdClick(Sender: TObject);
    procedure NextConfig;
    procedure vtConfigGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtItemsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure eQtd_ProdChange(Sender: TObject);
    procedure stProdTitleDblClick(Sender: TObject);
    procedure tbContractClick(Sender: TObject);
    procedure tbExpandClick(Sender: TObject);
    procedure eNum_ExtrChange(Sender: TObject);
    procedure vtItemsDblClick(Sender: TObject);
    procedure vtItemsFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtItemsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
  private
    { Private declarations }
    FActiveNode  : PVirtualNode;
    FGrMovID     : SmallInt;
    FNextConfig  : Boolean;
    FConfigIndex : Integer;
    FNumExtrGen  : string;
    FOwnerID     : Integer;
    FPriceTabID  : SmallInt;
    FTpMovID     : SmallInt;
    FTypeVol     : Byte;
    FTypeCode    : Byte;
    FOnChangeItem: TChangeItemEvent;
    FOnDeleteItem: TChangeItemEvent;
    FOnCancel    : TNotifyEvent;
    FSitTrib: string;
    FActiveOrder: TOrder;
    FOrderTypes: TOrderTypes;
    procedure SetGrMovID(AValue: SmallInt);
    function  GetOrderItems: TOrderItems;
    procedure SetOrderItems(AValue: TOrderItems);
    function  GetActiveItem: TOrderItem;
    function  GetItemIndex: Integer;
    function  GetSelectedItem: TOrderItem;
    function  GetDscProd: string;
    procedure SetDscProd(AValue: string);
    function  GetProdRef: string;
    procedure SetProdRef(AValue: string);
    function  GetLotItem: string;
    procedure SetLotItem(AValue: string);
    function  GetQtdProd: Double;
    procedure SetQtdProd(AValue: Double);
    function  GetVlrUnit: Double;
    procedure SetVlrUnit(AValue: Double);
    function  GetFkUnidades: TUnit;
    procedure SetFkUnidades(AValue: TUnit);
    function  GetSubTot: Double;
    procedure SetSubTot(AValue: Double);
    function  GetVlrAcrDsct: Double;
    procedure SetVlrAcrDsct(AValue: Double);
    function  GetTotItem: Double;
    procedure SetTotItem(AValue: Double);
    function  GetTotConfig: Double;
    procedure SetTotConfig(AValue: Double);
    function  GetAlqICMS: Double;
    procedure SetAlqICMS(AValue: Double);
    function  GetAlqICMSS: Double;
    procedure SetAlqICMSS(AValue: Double);
    function  GetAlqISS: Double;
    procedure SetAlqISS(AValue: Double);
    function  GetAlqOtr: Double;
    procedure SetAlqOtr(AValue: Double);
    function  GetFkTypeMovement: TMovement;
    procedure SetFkTypeMovement(AValue: TMovement);
    function  GetFkPriceTable: TPriceTable;
    procedure SetFkPriceTable(AValue: TPriceTable);
    function  GetFkComponents: TComponentType;
    procedure SetFkComponents(AValue: TComponentType);
    function  GetFkReference: TReferenceType;
    procedure SetFkReference(AValue: TReferenceType);
    function  GetFkMaterial: TProducts;
    procedure SetFkMaterial(AValue: TProducts);
    function  GetNumExtr: string;
    procedure SetNumExtr(AValue: string);
    procedure SetNumExtrGen(AValue: string);
    procedure SetQtdIns(AValue: Double);
    function  GetTotIns: Double;
    procedure SetTotIns(AValue: Double);
    function  GetQtdPec: Double;
    procedure SetQtdPec(AValue: Double);
    function  GetQtdParcial: Integer;
    procedure SetQtdParcial(AValue: Integer);
    function  GetQtdCompTot: Integer;
    procedure SetQtdCompTot(AValue: Integer);
    procedure LoadUnidades;
    procedure LoadTipoMovimentos;
    procedure LoadTabelaPrecos;
    procedure LoadPrdComponents;
    procedure LoadPrdFinishes;
    procedure LoadPrdMaterial;
    procedure ChangeMode(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure SelectNewPriceToItem;
    procedure AddConfigDataToGrid(AItem: TOrderItem; ANode: PVirtualNode;
                const AIdx: Integer);
    procedure SetActiveItemToConfigGrid(ALevel: Integer);
    procedure ShowItem(AItem: TOrderItem; const AScrState: TDBMode);
    procedure MoveValues(const Sender: TTypeFieldValue);
    procedure SetActiveOrder(const Value: TOrder);
    procedure SetOrderTypes(AValue: TOrderTypes);
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    procedure vtItemsClear;
    property  OrderTypes    : TOrderTypes      read FOrderTypes       write SetOrderTypes;
    property  ActiveOrder   : TOrder           read FActiveOrder      write SetActiveOrder;
    property  OrderItems    : TOrderItems      read GetOrderItems     write SetOrderItems;
    property  ItemIndex     : Integer          read GetItemIndex;
    property  ActiveItem    : TOrderItem       read GetActiveItem;
    property  SelectedItem  : TOrderItem       read GetSelectedItem;
    property  OwnerID       : Integer          read FOwnerID          write FOwnerID;
    property  PriceTabID    : SmallInt         read FPriceTabID       write FPriceTabID;
    property  GrMovID       : SmallInt         read FGrMovID          write SetGrMovID;
    property  TpMovID       : SmallInt         read FTpMovID          write FTpMovID;
    property  TypeVol       : Byte             read FTypeVol          write FTypeVol;
    property  TypeCode      : Byte             read FTypeCode         write FTypeCode;
    property  DscProd       : string           read GetDscProd        write SetDscProd;
    property  ProdRef       : string           read GetProdRef        write SetProdRef;
    property  LotItem       : string           read GetLotItem        write SetLotItem;
    property  QtdProd       : Double           read GetQtdProd        write SetQtdProd;
    property  VlrUnit       : Double           read GetVlrUnit        write SetVlrUnit;
    property  FkUnidades    : TUnit            read GetFkUnidades     write SetFkUnidades;
    property  SubTot        : Double           read GetSubTot         write SetSubTot;
    property  VlrAcrDsct    : Double           read GetVlrAcrDsct     write SetVlrAcrDsct;
    property  TotItem       : Double           read GetTotItem        write SetTotItem;
    property  TotConfig     : Double           read GetTotConfig      write SetTotConfig;
    property  SitTrib       : string           read FSitTrib;
    property  AlqICMS       : Double           read GetAlqICMS        write SetAlqICMS;
    property  AlqICMSS      : Double           read GetAlqICMSS       write SetAlqICMSS;
    property  AlqISS        : Double           read GetAlqISS         write SetAlqISS;
    property  AlqOtr        : Double           read GetAlqOtr         write SetAlqOtr;
    property  FkTypeMovement: TMovement        read GetFkTypeMovement write SetFkTypeMovement;
    property  FkPriceTable  : TPriceTable      read GetFkPriceTable   write SetFkPriceTable;
    property  FkComponents  : TComponentType   read GetFkComponents   write SetFkComponents;
    property  FkReference   : TReferenceType   read GetFkReference    write SetFkReference;
    property  FkMaterial    : TProducts        read GetFkMaterial     write SetFkMaterial;
    property  NumExtr       : string           read GetNumExtr        write SetNumExtr;
    property  NumExtrGen    : string           read FNumExtrGen       write SetNumExtrGen;
    property  QtdIns        : Double                                  write SetQtdIns;
    property  TotIns        : Double           read GetTotIns         write SetTotIns;
    property  QtdPec        : Double           read GetQtdPec         write SetQtdPec;
    property  QtdParcial    : Integer          read GetQtdParcial     write SetQtdParcial;
    property  QtdCompTot    : Integer          read GetQtdCompTot     write SetQtdCompTot;
    property  OnChangeItem  : TChangeItemEvent read FOnChangeItem     write FOnChangeItem;
    property  OnDeleteItem  : TChangeItemEvent read FOnDeleteItem     write FOnDeleteItem;
    property  OnCancel      : TNotifyEvent     read FOnCancel         write FOnCancel;
  end;

implementation

uses Dado, mSysPed, ProcType, FuncoesDB, DB, GridRow, SearchItem;

{$R *.dfm}

procedure TCdPedItem.FormCreate(Sender: TObject);
begin
  FActiveOrder              := TOrder.Create(Dados.DecimalPlaces);
  vtItems.NodeDataSize      := SizeOf(TItemsRecord);
  vtConfig.NodeDataSize     := SizeOf(TConfRecord);
  with Dados do
  begin
    Image16.GetBitmap(35, sbSearchProd.Glyph);
    vtItems.Images              := Image16;
    vtItems.Header.Images       := Image16;
    vtConfig.Images             := Image16;
    vtConfig.Header.Images      := Image16;
    cbItems.Images              := Image16;
    tbTools.Images              := Image16;
    Loading                     := True;
    try
      eQtd_Prod.DecimalPlaces     := DecimalPlacesQtd;
      eQtd_Prod.DisplayFormat     := QtdMask;
      eVlr_Unit.DecimalPlaces     := DecimalPlaces;
      eVlr_Unit.DisplayFormat     := CurrMask;
      eSub_Tot.DecimalPlaces      := DecimalPlaces;
      eSub_Tot.DisplayFormat      := CurrMask;
      eVlr_Acr_Dsct.DecimalPlaces := DecimalPlaces;
      eVlr_Acr_Dsct.DisplayFormat := CurrMask;
      eTot_Item.DecimalPlaces     := DecimalPlaces;
      eTot_Item.DisplayFormat     := CurrMask;
      eTot_Config.DecimalPlaces   := DecimalPlaces;
      eTot_Config.DisplayFormat   := CurrMask;
    finally
      Loading                     := False;
    end;
  end;
  inherited;
  FNextConfig             := True;
  pgItems.ActivePageIndex := 0;
  OnInternalState         := ChangeMode;
  FNumExtrGen             := '';
end;

procedure TCdPedItem.FormDestroy(Sender: TObject);
begin
  FOnChangeItem := nil;
  eFk_Componentes.ReleaseObjects;
  eFk_Insumos.ReleaseObjects;
  eFk_Produtos.ReleaseObjects;
  eFk_Tabela_Precos.ReleaseObjects;
  eFk_Tipo_Movimentos.ReleaseObjects;
  eFk_Tipo_Referencias.ReleaseObjects;
  if Assigned(FActiveOrder) then
    FreeAndNil(FActiveOrder);
  vtItemsClear;
  ReleaseTreeNodes(vtConfig);
  inherited;
end;

procedure TCdPedItem.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    LoadUnidades;
    LoadTabelaPrecos;
    if (FGrMovID > 0) then
      LoadTipoMovimentos;
    ListLoaded := True;
  end;
end;

procedure TCdPedItem.MoveDataToControls;
var
  i: Integer;
begin
  if (ActiveItem = nil) then exit;
  Loading := True;
  if (pgItems.ActivePageIndex = 1) then
  begin
    DscProd        := ActiveItem.FkProduct.DscProd;
    ProdRef        := ActiveItem.CodRef;
    LotItem        := ActiveItem.LotItem;
    FkUnidades     := ActiveItem.FkUnit;
    AlqICMS        := ActiveItem.AlqIcms.TaxPercent;
    AlqICMSS       := ActiveItem.AlqIcmss.TaxPercent;
    AlqISS         := ActiveItem.AlqIss.TaxPercent;
    AlqOtr         := ActiveItem.AlqIpi.TaxPercent;
    FkTypeMovement := ActiveItem.FkMovement;
    FkPriceTable   := ActiveItem.FkPriceTable;
    NumExtr        := ActiveItem.NumExtr;
    FSitTrib       := ActiveItem.SitTrib;
    MoveValues(fvAll);
    if (FTpMovId > 0) then
      for i := 0 to eFk_Tipo_Movimentos.Items.Count - 1 do
        if (eFk_Tipo_Movimentos.Items.Objects[i] <> nil) and
           (TMovement(eFk_Tipo_Movimentos.Items.Objects[i]).PkTypeMovement = FTpMovID) then
          eFk_Tipo_Movimentos.ItemIndex := i;
    if ActiveItem.HasConfig then
      LoadPrdComponents;
  end;
  if (pgItems.ActivePageIndex = 2) then
  begin
    i              := ActiveItem.ConfigItems.ItemIndex;
    FkComponents   := ActiveItem.ConfigItems.Items[i].FkComponentType;
    if (FkComponents <> nil) then
      FkReference  := ActiveItem.ConfigItems.Items[i].FkReferenceType;
    FkMaterial     := ActiveItem.ConfigItems.Items[i].FkProduct;
    QtdPec         := ActiveItem.QtdItem;
    TotConfig      := ActiveItem.TotItem;
    QtdParcial     := ActiveItem.ConfigItems.Items[i].QtdParcial;
    QtdCompTot     := ActiveItem.ConfigItems.Items[i].QtdCompTot;
  end;
  if (ScrState in LOADING_MODE) then
    ScrState := dbmBrowse;
  Loading := False;
end;

procedure TCdPedItem.ClearControls;
begin
  Loading          := True;
  try
    ProdRef        := '';
    LotItem        := '';
    QtdProd        := 1;
    VlrUnit        := 0;
    FkUnidades     := nil;
    SubTot         := 0;
    VlrAcrDsct     := 0;
    TotItem        := 0;
    TotConfig      := 0;
    AlqICMS        := 0;
    AlqICMSS       := 0;
    AlqISS         := 0;
    AlqOtr         := 0;
    FkTypeMovement := nil;
    FkPriceTable   := nil;
    FkComponents   := nil;
    FkReference    := nil;
    FkMaterial     := nil;
    NumExtr        := FNumExtrGen;
    QtdPec         := 0;
    QtdParcial     := 0;
    QtdCompTot     := 0;
    ReleaseTreeNodes(vtConfig);
  finally
    Loading        := False;
  end;
end;

procedure TCdPedItem.SaveIntoDB;
begin
  if OrderItems = nil then
    raise Exception.Create('SaveItem Error: OrderItems = nil');
  if pgItems.ActivePageIndex > 0 then
    pgItems.ActivePageIndex := 0;
  if (ScrState = dbmEdit) then
  begin
    with ActiveOrder.OrderHistorics.Add do
    begin
      if (ScrState = dbmInsert) then
        DscHist     := 'Inserção de novo ítem '
      else
        DscHist     := 'Edição do ítem ' + IntToStr(ActiveItem.Index) + '/' +
                       ActiveItem.DscProd;
      DtHrHist      := Date;
      FkOrderStatus := ActiveOrder.FkOrderStatus;
    end;
  end;
  ShowItem(ActiveItem, ScrState);
  ScrState := dbmBrowse;
end;

function  TCdPedItem.GetOrderItems: TOrderItems;
begin
  Result := ActiveOrder.OrderItems;
end;

procedure TCdPedItem.SetOrderItems(AValue: TOrderItems);
var
  i: Integer;
begin
  OrderItems.Clear;
  if Assigned(AValue) then
    ActiveOrder.OrderItems.Assign(AValue);
  vtItemsClear;
  for i := 0 to ActiveOrder.OrderItems.Count - 1 do
    ShowItem(ActiveOrder.OrderItems.Items[i], dbmInsert);
end;

function  TCdPedItem.GetActiveItem: TOrderItem;
begin
  Result := nil;
  if (ItemIndex > -1) and (ItemIndex < ActiveOrder.OrderItems.Count) then
    Result := ActiveOrder.OrderItems.Items[ItemIndex];
end;

function  TCdPedItem.GetItemIndex: Integer;
begin
  Result := ActiveOrder.OrderItems.ItemIndex;
end;

procedure TCdPedItem.LoadUnidades;
begin
  eFk_Unidades.ReleaseObjects;
  eFk_Unidades.Items.AddStrings(dmSysPed.LoadUnits);
end;

procedure TCdPedItem.LoadTipoMovimentos;
begin
  eFk_Tipo_Movimentos.ReleaseObjects;
  eFk_Tipo_Movimentos.Items.AddStrings(dmSysPed.LoadMovement(OrderTypes, FGrMovID, True));
end;

procedure TCdPedItem.LoadTabelaPrecos;
begin
  eFk_Tabela_Precos.ReleaseObjects;
  eFk_Tabela_Precos.Items.AddStrings(dmSysPed.LoadTabPrices);
end;

procedure TCdPedItem.LoadPrdComponents;
begin
  if (ActiveItem = nil) then exit;
  with eFk_Componentes do
  begin
    if (Items.Count > 0) then ReleaseObjects;
    Items.AddStrings(dmSysPed.LoadComponents(ActiveItem.FkProduct.PkProducts));
  end;
end;

procedure TCdPedItem.LoadPrdFinishes;
begin
  if (FkComponents = nil) and (ActiveItem = nil) then exit;
  with eFk_Tipo_Referencias do
  begin
    if (Items.Count > 0) then ReleaseObjects;
    Items.AddStrings(dmSysPed.LoadFinish(
      ActiveItem.PkCompany, ActiveItem.FkProduct.PkProducts, FkComponents));
  end;
end;

procedure TCdPedItem.LoadPrdMaterial;
begin
  if (ActiveItem = nil) and (FkReference = nil) then exit;
  eFk_Insumos.ReleaseObjects;
  eFk_Insumos.Items.AddStrings(dmSysPed.LoadMaterial(
    FkReference.FkFinishType.PkFinishType, FkReference.PkReferenceType));
end;

procedure TCdPedItem.ChangeMode(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  if Loading then exit;
  tbCancel.Enabled := (AState in UPDATE_MODE);
  tbSave.Enabled   := (AState in UPDATE_MODE) and (ActiveItem <> nil);
  tbDelete.Enabled := (AState in SCROLL_MODE) and (vtItems.RootNodeCount > 0);
  if (AState = dbmInsert) then ClearControls;
  if (AState = dbmBrowse) then pgItems.ActivePageIndex := 0;
end;

procedure TCdPedItem.SetGrMovID(AValue: SmallInt);
begin
  FGrMovID := AValue;
  if (AValue > 0) then
    LoadTipoMovimentos;
end;

function  TCdPedItem.GetSelectedItem: TOrderItem;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Produtos.ItemIndex;
  if (aIdx > -1) and (eFk_Produtos.Items.Objects[aIdx] <> nil) then
  begin
    Result := TOrderItem(eFk_Produtos.Items.Objects[aIdx]);
    eFk_Produtos.Visible := False;
    stProdTitle.Caption  := eFk_Produtos.Text;
  end;
end;

function  TCdPedItem.GetDscProd: string;
begin
  Result := stProdTitle.Caption;
end;

procedure TCdPedItem.SetDscProd(AValue: string);
begin
  stProdTitle.Caption := AValue;
end;

function  TCdPedItem.GetProdRef: string;
begin
  Result := eProd_Ref.Text;
end;

procedure TCdPedItem.SetProdRef(AValue: string);
begin
  eProd_Ref.Text := AValue;
  if (AValue = '') then
  begin
    eFk_Produtos.ReleaseObjects;
    stProdTitle.Caption := '';
  end;
end;

function  TCdPedItem.GetLotItem: string;
begin
  Result := eLot_Item.Text;
end;

procedure TCdPedItem.SetLotItem(AValue: string);
begin
  eLot_Item.Text := AValue;
end;

function  TCdPedItem.GetQtdProd: Double;
begin
  Result := eQtd_Prod.Value;
end;

procedure TCdPedItem.SetQtdProd(AValue: Double);
begin
  eQtd_Prod.Value := AValue;
end;

function  TCdPedItem.GetVlrUnit: Double;
begin
  Result := eVlr_Unit.Value;
end;

procedure TCdPedItem.SetVlrUnit(AValue: Double);
begin
  eVlr_Unit.Value := AValue;
end;

function  TCdPedItem.GetFkUnidades: TUnit;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Unidades.ItemIndex;
  if (aIdx > 0) and (eFk_Unidades.Items.Objects[aIdx] = nil) then
    Result := TUnit(eFk_Unidades.Items.Objects[aIdx]);
end;

procedure TCdPedItem.SetFkUnidades(AValue: TUnit);
begin
  if (AValue = nil) then
    eFk_Unidades.ItemIndex := -1
  else
    eFk_Unidades.SetIndexFromObjectValue(AValue.PkUnit);
end;

function  TCdPedItem.GetSubTot: Double;
begin
  Result := eSub_Tot.Value;
end;

procedure TCdPedItem.SetSubTot(AValue: Double);
begin
  eSub_Tot.Value := AValue;
end;

function  TCdPedItem.GetVlrAcrDsct: Double;
begin
  Result := eVlr_Acr_Dsct.Value;
end;

procedure TCdPedItem.SetVlrAcrDsct(AValue: Double);
begin
  eVlr_Acr_Dsct.Value := AValue;
end;

function  TCdPedItem.GetTotItem: Double;
begin
  Result := eTot_Item.Value;
end;

procedure TCdPedItem.SetTotItem(AValue: Double);
begin
  eTot_Item.Value := AValue;
end;

function  TCdPedItem.GetTotConfig: Double;
begin
  Result := eTot_Config.Value;
end;

procedure TCdPedItem.SetTotConfig(AValue: Double);
begin
  eTot_Config.Value := AValue;
end;

function  TCdPedItem.GetAlqICMS: Double;
begin
  Result := eAlq_ICMS.Value;
end;

procedure TCdPedItem.SetAlqICMS(AValue: Double);
begin
  eAlq_ICMS.Value := AValue;
end;

function  TCdPedItem.GetAlqICMSS: Double;
begin
  Result := eAlq_ICMSS.Value;
end;

procedure TCdPedItem.SetAlqICMSS(AValue: Double);
begin
  eAlq_ICMSS.Value := AValue;
end;

function  TCdPedItem.GetAlqISS: Double;
begin
  Result := eAlq_ISS.Value;
end;

procedure TCdPedItem.SetAlqISS(AValue: Double);
begin
  eAlq_ISS.Value := AValue;
end;

function  TCdPedItem.GetAlqOtr: Double;
begin
  Result := eAlq_Otr.Value;
end;

procedure TCdPedItem.SetAlqOtr(AValue: Double);
begin
  eAlq_Otr.Value := AValue;
end;

function  TCdPedItem.GetFkTypeMovement: TMovement;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Tipo_Movimentos.ItemIndex;
  if (aIdx > 0) and (eFk_Tipo_Movimentos.Items.Objects[aIdx] = nil) then
    Result := TMovement(eFk_Tipo_Movimentos.Items.Objects[aIdx]);
end;

procedure TCdPedItem.SetFkTypeMovement(AValue: TMovement);
begin
  if (AValue = nil) then
    eFk_Tipo_Movimentos.ItemIndex := -1
  else
    eFk_Tipo_Movimentos.SetIndexFromObjectValue(AValue.PkGroupMovement);
end;

function  TCdPedItem.GetFkPriceTable: TPriceTable;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Tabela_Precos.ItemIndex;
  if (aIdx > 0) and (eFk_Tabela_Precos.Items.Objects[aIdx] = nil) then
    Result := TPriceTable(eFk_Tabela_Precos.Items.Objects[aIdx]);
end;

procedure TCdPedItem.SetFkPriceTable(AValue: TPriceTable);
begin
  if (AValue = nil) then
    eFk_Tabela_Precos.ItemIndex := -1
  else
    eFk_Tabela_Precos.SetIndexFromObjectValue(AValue.PkPriceTable);
end;

function  TCdPedItem.GetFkComponents: TComponentType;
begin
  Result := nil;
  with eFk_Componentes do
    if (ItemIndex >= 0) and (Items.Objects[ItemIndex] <> nil) then
      Result := TComponentType(Items.Objects[ItemIndex]);
end;

procedure TCdPedItem.SetFkComponents(AValue: TComponentType);
begin
  if (eFk_Componentes.Items.Count = 0) then
     LoadPrdComponents;
  if (AValue = nil) then
    eFk_Componentes.ItemIndex := -1
  else
    eFk_Componentes.SetIndexFromObjectValue(AValue.PkComponent);
end;

function  TCdPedItem.GetFkReference: TReferenceType;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Tipo_Referencias.ItemIndex;
  if (aIdx >= 0) and (eFk_Tipo_Referencias.Items.Objects[aIdx] <> nil) then
    Result := TReferenceType(eFk_Tipo_Referencias.Items.Objects[aIdx]);
end;

procedure TCdPedItem.SetFkReference(AValue: TReferenceType);
begin
  if (FkComponents <> nil) and (eFk_Tipo_Referencias.Items.Count = 0) then
    LoadPrdFinishes;
  if (AValue = nil) then
    eFk_Tipo_Referencias.ItemIndex := -1
  else
    eFk_Tipo_Referencias.SetIndexFromObjectValue(AValue.PkReferenceType);
end;

function  TCdPedItem.GetFkMaterial: TProducts;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Insumos.ItemIndex;
  if (aIdx >= 0) and (eFk_Insumos.Items.Objects[aIdx] <> nil) then
    Result := TProducts(eFk_Insumos.Items.Objects[aIdx]);
end;

procedure TCdPedItem.SetFkMaterial(AValue: TProducts);
begin
  if (FkComponents <> nil) and (FkReference <> nil) and
     (eFk_Insumos.Items.Count = 0) then
    LoadPrdMaterial;
  if (AValue = nil) then
    eFk_Insumos.ItemIndex := -1
  else
    eFk_Insumos.SetIndexFromObjectValue(AValue.PkProducts);
end;

function  TCdPedItem.GetNumExtr: string;
begin
  Result := Copy(eNum_Extr.Text, 1, 15);
end;

procedure TCdPedItem.SetNumExtr(AValue: string);
begin
  eNum_Extr.Text := Copy(AValue, 1, 15);
end;

procedure TCdPedItem.SetNumExtrGen(AValue: string);
begin
  FNumExtrGen := Copy(AValue, 1, 15);
  NumExtr := FNumExtrGen;
end;

procedure TCdPedItem.SetQtdIns(AValue: Double);
begin
  TotIns := AValue * eQtd_Parcial.Value;
end;

function  TCdPedItem.GetTotIns: Double;
begin
  Result := eTot_Ins.Value;
end;

procedure TCdPedItem.SetTotIns(AValue: Double);
begin
  eTot_Ins.Value := AValue;
end;

function  TCdPedItem.GetQtdPec: Double;
begin
  Result := eQtd_Pec.Value;
end;

procedure TCdPedItem.SetQtdPec(AValue: Double);
begin
  eQtd_Pec.Value := AValue;
end;

function  TCdPedItem.GetQtdParcial: Integer;
begin
  Result := eQtd_Parcial.AsInteger;
end;

procedure TCdPedItem.SetQtdParcial(AValue: Integer);
begin
  eQtd_Parcial.Value := AValue;
end;

function  TCdPedItem.GetQtdCompTot: Integer;
begin
  Result := eQtd_Comp_Tot.AsInteger;
end;

procedure TCdPedItem.SetQtdCompTot(AValue: Integer);
begin
  eQtd_Comp_Tot.Value := AValue;
end;

procedure TCdPedItem.eProd_RefKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key = VK_RETURN) or (Key = VK_TAB)) and (ProdRef <> '') then
    eProd_RefExit(Sender);
end;

procedure TCdPedItem.eVlr_Acr_DsctChange(Sender: TObject);
begin
  if Loading then exit;
  ChangeGlobal(Sender);
  ActiveItem.VlrAcrDsct := VlrAcrDsct;
  MoveValues(fvAcrd);
end;

procedure TCdPedItem.eVlr_UnitChange(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (Loading) or (ScrState in SCROLL_MODE) then exit;
  ActiveItem.VlrUnit := VlrUnit;
  MoveValues(fvVlr);
end;

procedure TCdPedItem.SelectNewPriceToItem;
var
  aIdx  : Integer;
begin
  if (Loading) then exit;
  Loading := True;
  aIdx := eFk_Produtos.ItemIndex;
  if (aIdx > 0) or (eFk_Produtos.Items.Objects[aIdx] <> nil) then
  begin
    aIdx := TPriceTable(eFk_Produtos.Items.Objects[aIdx]).PkPriceTable;
    eFk_Produtos.ReleaseObjects;
    eFk_Produtos.Items.AddStrings(dmSysPed.GetProdRef(Dados.PkCompany,
      FOwnerID, ProdRef, aIdx, FGrMovID, FTpMovID, FTypeVol, FTypeCode, QtdProd));
    if eFk_Produtos.Items.Count = 0 then
      raise Exception.Create('ProductItem: Produto não Encontrado')
    else
    begin
      eFk_Produtos.ItemIndex := 0;
      eFk_ProdutosSelect(eFk_Produtos);
    end;
  end;
  Loading := False;
end;

procedure TCdPedItem.eFk_Tabela_PrecosSelect(Sender: TObject);
var
  aIdx: Integer;
begin
  aIdx := eFk_Tabela_Precos.ItemIndex;
  if (aIdx > 0) and (eFk_Tabela_Precos.Items.Objects[aIdx] <> nil) then
  begin
    FPriceTabID := TPriceTable(eFk_Tabela_Precos.Items.Objects[aIdx]).PkPriceTable;
    SelectNewPriceToItem;
  end
  else
    eFk_Tabela_Precos.SetIndexFromObjectValue(FPriceTabID);
end;

procedure TCdPedItem.eFk_ComponentesSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (FkComponents <> nil) then
  begin
    QtdCompTot := Trunc(FkComponents.QtdComp * QtdProd);
    QtdParcial := QtdCompTot;
    LoadPrdFinishes;
  end;
end;

procedure TCdPedItem.eFk_Tipo_ReferenciasSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (FkReference <> nil) then
  begin
    LoadPrdMaterial;
    QtdIns := FkReference.FkFinishType.QtdPdr;
  end;
end;

procedure TCdPedItem.tbInsertClick(Sender: TObject);
begin
 if ((not (otPurchaseOrder in OrderTypes)) and (FPriceTabID <= 0)) or
    (FOwnerID <= 0) or (FGrMovID <= 0) or (FTpMovID <= 0) then
  begin
    Dados.DisplayHint(tbInsert, 'Novo Item: Para inserir um ítem você deve ' +
      'preencher os campos acima.' + NL +
      Format('Cadastros: %d', [FOwnerID]) + NL +
      Format('Tabela de Preços: %d', [FPriceTabID]) + NL +
      Format('Grupo Movimentos: %d', [FGrMovID]) + NL +
      Format('Tipo de Movimentação: %d', [FTpMovID]), hiError, 'Inserção de Ítens');
    exit;
  end;
  if (pgItems.ActivePageIndex = 0) then
    pgItems.ActivePageIndex := 1;
  ScrState := dbmInsert;
  ActiveOrder.OrderItems.ItemIndex := -1;
  if (eProd_Ref.CanFocus) then
    eProd_Ref.SetFocus;
end;

procedure TCdPedItem.ShowItem(AItem: TOrderItem; const AScrState: TDBMode);
var
  Node: PVirtualNode;
  Data: PItemsRecord;
  i: Integer;
begin
  vtItems.BeginUpdate;
  try
    if (AScrState = dbmInsert) then
      Node := vtItems.AddChild(nil)
    else
      Node := vtItems.FocusedNode;
    if (Node <> nil) then
    begin
      Data := vtItems.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.State := AScrState;
        Data^.Node  := Node;
        if (AScrState = dbmInsert) then
          Data^.Item := TOrderItem.Create(nil)
        else
          Data^.Item.Clear;
        Data^.Level := 0;
        Data^.Index := ItemIndex;
        Data^.Item.Assign(AItem);
        if AItem.HasConfig then
          for i := 0 to AItem.ConfigItems.Count - 1 do
            AddConfigDataToGrid(AItem, Node, i);
        vtItems.FocusedNode := Node;
      end;
    end;
  finally
    vtItems.EndUpdate;
  end;
end;

procedure TCdPedItem.AddConfigDataToGrid(AItem: TOrderItem; ANode: PVirtualNode;
  const AIdx: Integer);
var
  Node: PVirtualNode;
  Data: PConfRecord;
begin
  if (ANode = nil) then exit;
  Node := vtItems.AddChild(ANode);
  if (Node = nil) then exit;
  Data := vtItems.GetNodeData(Node);
  if (Data = nil) then exit;
  Data^.Level := 1;
  Data^.Node  := Node;
  Data^.Index := AIdx;
  Data^.Item  := TConfItem.Create(nil);
  Data^.Item.Assign(AItem.ConfigItems.Items[AIdx]);
end;

procedure TCdPedItem.SetActiveItemToConfigGrid(ALevel: Integer);
var
  Node: PVirtualNode;
  Data: PGridData;
  aStr: string;
begin
  if (ALevel = 0) and (vtConfig.RootNodeCount > 0) then
    ReleaseTreeNodes(vtConfig);
  vtConfig.BeginUpdate;
  try
    if (ALevel = 0) then
      Node := vtConfig.AddChild(nil)
    else
      Node := vtConfig.AddChild(vtConfig.GetFirst);
    if (Node = nil) then exit;
    Data := vtItems.GetNodeData(Node);
    if (Data = nil) then exit;
    Data^.Level   := ALevel;
    Data^.Node    := Node;
    Data^.DataRow := TDataRow.Create(nil);
    if (ALevel = 0) then
    begin
      Data^.DataRow.AddAs('DSC_PROD', ActiveItem.FkProduct.DscProd, ftString, 51);
      Data^.DataRow.AddAs('VLR_UNIT', ActiveItem.VlrUnit, ftFloat, SizeOf(Double))
    end
    else
      with ActiveItem.ConfigItems.Items[FConfigIndex] do
      begin
        aStr := FkComponentType.DscTComp + '/' + FkReferenceType.FkFinishType.DscAcbm +
              '/' + FkReferenceType.DscRef;
        Data^.DataRow.AddAs('DSC_ACBM', aStr, ftString, Length(aStr) + 1);
        Data^.DataRow.AddAs('VLR_ACBM', FkReferenceType.FkFinishType.PreVda,
          ftFloat, SizeOf(Double))
      end;
  finally
    vtConfig.EndUpdate;
  end;
end;

procedure TCdPedItem.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmBrowse;
  ClearControls;
  if (pgItems.ActivePageIndex > 0) then
    pgItems.ActivePageIndex := 0;
//  if Assigned(FOnCancel) then
//    FOnCancel(Self);
end;

procedure TCdPedItem.tbDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PItemsRecord;
begin
  if (vtItems.RootNodeCount = 0) then exit;
  if Dados.DisplayMessage('A Exclusão deste ítem gerará um histórico noo Pedido.' +
      NL + 'Deseja realmente excluir este ítem?', hiQuestion, [mbYes, mbNo]) = mrNo then
    exit;
  with ActiveOrder.OrderHistorics.Add do
  begin
    DscHist       := 'Excluído ítem ' + IntToStr(ActiveItem.Index) + '/' +
                     ActiveItem.DscProd;
    DtHrHist      := Date;
    FkOrderStatus := ActiveOrder.FkOrderStatus;
  end;
  Node := vtItems.FocusedNode;
  if (Node = nil) then exit;
  Data := vtItems.GetNodeData(Node);
  if (Data = nil) or (Data^.Item = nil) or (ActiveOrder = nil) or
     (Data^.Index = -1) or (OrderItems = nil) or
     (Data^.Index >= OrderItems.Count) then
    exit;
  OrderItems.ItemIndex := Data^.Index;
  if Assigned(FOnDeleteItem) then
    FOnDeleteItem(ActiveOrder, OrderItems.Items[Data^.Index]);
  OrderItems.Delete(Data^.Index);
  Data^.Item.Free;
  Data^.Item := nil;
  Data^.Node := nil;
  vtItems.DeleteNode(Node);
  if (pgItems.ActivePageIndex > 0) then
    pgItems.ActivePageIndex := 0;
  ScrState := dbmEdit;
  ScrState := dbmBrowse;
end;

procedure TCdPedItem.tbSaveClick(Sender: TObject);
var
  i: Integer;
  AState: TDBMode;
begin
  AState := ScrState;
  if (ActiveItem = nil) or (ItemIndex = -1) then exit;
  if (pgItems.ActivePageIndex = 1) and (ActiveItem.FlagConf) then
  begin
    pgItems.ActivePageIndex := 2;
    FNextConfig             := True;
    QtdPec := Trunc(QtdProd);
    eFk_Componentes.ReleaseObjects;
    eFk_Componentes.Clear;
    eFk_Componentes.Text := '';
    LoadPrdComponents;
    SetActiveItemToConfigGrid(0);
    if (ScrState = dbmEdit) and (ItemIndex > -1) and
       (ActiveOrder.OrderItems.Count > ItemIndex) then
    begin
      eFk_Produtos.Items.AddObject(ActiveItem.FkProduct.DscProd, ActiveItem);
      for i := 0 to ActiveItem.ConfigItems.Count - 1 do
      begin
        ActiveItem.ConfigItems.ItemIndex := i;
        SetActiveItemToConfigGrid(1);
      end;
    end;
  end
  else
  begin
    if (FNextConfig) then // if all Configurations not saved then
    begin
      NextConfig;
      if (FNextConfig) and (ActiveItem.FlagConf) and
         (not ActiveItem.HasConfig) then
      begin
        if Dados.DisplayMessage('Configurador: Configuração ainda não selecionada.' +
           NL + 'Deseja salvar sem montar a configuração?', hiQuestion,
           [mbYes, mbNo]) = mrYes then
          FNextConfig := False;
      end;
    end;
    if (not FNextConfig) then
    begin
      SaveIntoDB;
      if (pgItems.ActivePageIndex > 0) then
        pgItems.ActivePageIndex := 0;
      if Assigned(FOnChangeItem) then
        FOnChangeItem(ActiveOrder, ActiveItem, aState);
      ScrState := dbmBrowse;
    end;
  end;
end;

procedure TCdPedItem.eProd_RefExit(Sender: TObject);
begin
  Loading := True;
  if (ScrState in UPDATE_MODE) and ((ActiveItem = nil) or
     (eProd_Ref.Text <> ActiveItem.CodRef)) then
  begin
    eFk_Produtos.ReleaseObjects;
    eFk_Produtos.Items.AddStrings(dmSysPed.GetProdRef(Dados.PkCompany,
      FOwnerID, ProdRef, FPriceTabID, FGrMovID, FTpMovID, FTypeVol, FTypeCode,
      QtdProd));
    if eFk_Produtos.Items.Count = 0 then
      raise Exception.Create('ProductItem: Produto não Encontrado')
    else
    begin
      eFk_Produtos.ItemIndex := 0;
      eFk_ProdutosSelect(eFk_Produtos);
    end;
  end;
  Loading := False;
end;

procedure TCdPedItem.eFk_ProdutosSelect(Sender: TObject);
var
  aIdx, i: Integer;
const
  STATUS_CODE: array [0..6] of ShortInt = (-50, -20, -10, -7, -5, 0, 30);
  STATUS_MSG : array [0..6] of string   = ('Produto sem estoques e custos',
    'Tipo de movimentação não encontrada', 'Produto não encontrado',
    'Conversão do código inválida', 'Não posso calcular o preço',
    'Todas as condições atendidas', 'Impostos não encontrados');
begin
  ChangeGlobal(Sender);
  if (SelectedItem <> nil) then
  begin
    aIdx := ActiveOrder.OrderItems.AddOrderItem(SelectedItem);
    if (aIdx > -1) then
    begin
      ActiveOrder.OrderItems.Items[aIdx].FkMovement.PkGroupMovement := FGrMovID;
      ActiveOrder.OrderItems.Items[aIdx].FkMovement.PkTypeMovement  := FTpMovID;
      if (ActiveItem.Status <> 0) then
      begin
        aIdx := -1;
        for i := Low(STATUS_CODE) to High(STATUS_CODE) do
          if (ActiveItem.Status = STATUS_CODE[i]) then
            aIdx := i;
        if (aIdx > -1) then
        begin
//          ShowMessage(Format('Status ==> %d', [ActiveItem.Status]));
// na edição do ítem ta dando pau quando salva... list index out of bounds(0)
          if (ActiveItem.Status > 0) then
            Dados.DisplayHint(eProd_Ref, STATUS_MSG[aIdx])
          else
          begin
            Dados.DisplayMessage(STATUS_MSG[aIdx], hiError);
            eProd_Ref.SetFocus;
          end;
        end;
      end;
      tbSave.Enabled := (ActiveItem <> nil);
      MoveDataToControls;
//    NumExtr := FNumExtrGen;
      lVlr_Unit.Enabled := (otPurchaseOrder in OrderTypes) or (ActiveOrder.FkMovement.FlagLdv);
      eVlr_Unit.Enabled := (otPurchaseOrder in OrderTypes) or (ActiveOrder.FkMovement.FlagLdv);
    end;
  end;
end;

procedure TCdPedItem.sbSearchProdClick(Sender: TObject);
var
  aForm: TfmSearchProd;
begin
  aForm := TfmSearchProd.Create(Application);
  try
    aForm.ShowModal;
    if aForm.RefProduct <> '' then
      ProdRef := aForm.RefProduct;
  finally
    FreeAndNil(aForm);
  end;
  if (eProd_Ref.CanFocus) then
    eProd_Ref.SetFocus
end;

procedure TCdPedItem.NextConfig;
var
  i, j,
  aIdx: Integer;
  aStr: string;
begin
  // Save data into grid and into item config....
  // Subtract selected qtd, save it into eQtdPec and repeat configuration until
  // eQtdPec = 0 equal zero
  if (FkComponents = nil) or (FkReference = nil) or (FkMaterial = nil) then
  begin
    FNextConfig := False;
    exit;
  end;
  with ActiveItem.ConfigItems.Add do
  begin
    FkComponentType := FkComponents;
    FkFinishType    := FkReference.FkFinishType;
    FkReferenceType := FkReference;
    FkProduct       := FkMaterial;
    aStr := InsereZer(IntToStr(FkComponentType.PkComponent), 2) + '-' +
            InsereZer(IntToStr(FkFinishType.PkFinishType), 2) + '-' +
            InsereZer(IntToStr(FkReferenceType.PkReferenceType), 2);
    CodRef          := aStr;
    aStr := FkComponentType.DscTComp + ' / ' + FkReferenceType.DscRef + ' / ' +
            FkProduct.DscProd;
    DscConf         := aStr;
    FlagBxaStt      := False;
    FlagCntr        := True;
    FlagFrnCli      := False;
    FlagPend        := False;
    PerDsctIns      := 0;
    QtdParcial      := Self.QtdParcial;
    FConfigIndex    := Index;
  end;
  j    := FkComponents.PkComponent;
  aIdx := -1;
  for i := 0 to eFk_Componentes.Items.Count - 1 do
  begin
    if (eFk_Componentes.Items.Objects[i] <> nil) then
    begin
      if (j = TComponentType(eFk_Componentes.Items.Objects[i]).PkComponent) then
      begin
        aIdx := i;
        break;
      end;
    end;
  end;
  if (aIdx > -1) and (aIdx < eFk_Componentes.Items.Count) and
     (eFk_Componentes.Items.Objects[aIdx] <> nil) then
  begin
    eFk_Componentes.Items.Objects[aIdx].Free;
    eFk_Componentes.Items.Objects[aIdx] := nil;
    eFk_Componentes.Items.Delete(aIdx);
  end;
  FNextConfig := (eFk_Componentes.Items.Count > 0) and
                 (FConfigIndex < ActiveItem.ConfigItems.Count);
  SetActiveItemToConfigGrid(1);
  eFk_Tipo_Referencias.ReleaseObjects;
  eFk_Insumos.ReleaseObjects;
end;

procedure TCdPedItem.vtConfigGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    case Column of
      0: CellText := Data^.DataRow.FieldByName['DSC_PROD'].AsString;
      1: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_UNIT'].AsFloat, ffNumber, 7, 2);
    end;
  end;
  if (Sender.GetNodeLevel(Node) = 1) then
  begin
    case Column of
      0: CellText := Data^.DataRow.FieldByName['DSC_ACBM'].AsString;
      1: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_ACBM'].AsFloat, ffNumber, 7, 2);
    end;
  end;
end;

procedure TCdPedItem.vtItemsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data1: PItemsRecord;
  Data2: PConfRecord;
begin
  if (Node = nil) or (ActiveOrder.OrderItems.Count = 0) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    Data1 := Sender.GetNodeData(Node);
    if (Data1 = nil) or (Data1^.Item = nil) then exit;
    case Column of
      0: CellText := IntToStr(Node.Index + 1);
      1: CellText := Data1^.Item.CodRef;
      2: CellText := Data1^.Item.DscProd;
      3: CellText := FloatToStrF(Data1^.Item.QtdItem, ffNumber, 7, Dados.DecimalPlacesQtd);
      4: CellText := Data1^.Item.FKUnit.MnmoUni;
      5: CellText := FloatToStrF(Data1^.Item.VlrUnit, ffNumber, 7, Dados.DecimalPlaces);
      6: CellText := FloatToStrF(Data1^.Item.VlrAcrDsct, ffNumber, 7, Dados.DecimalPlaces);
      7: CellText := FloatToStrF(Data1^.Item.TotItem, ffNumber, 7, Dados.DecimalPlaces);
    end;
  end
  else
  begin
    Data2 := Sender.GetNodeData(Node);
    if (Data2 = nil) or (Data2^.Item = nil) then exit;
    case Column of
      0: CellText := IntToStr(Data2^.Index + 1);
      1: CellText := Data2^.Item.CodRef;
      2: CellText := Data2^.Item.DscConf;
      3: CellText := FloatToStrF(Data2^.Item.QtdParcial, ffNumber, 7, Dados.DecimalPlacesQtd);
      4: CellText := ' ';
      5: CellText := FloatToStrF(Data2^.Item.VlrItem, ffNumber, 7, Dados.DecimalPlaces);
      6: CellText := ' ';
      7: CellText := FloatToStrF(Data2^.Item.TotConf, ffNumber, 7, Dados.DecimalPlaces);
    end;
  end
end;

procedure TCdPedItem.eQtd_ProdChange(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (Loading) or (ScrState in SCROLL_MODE) then exit;
  ActiveItem.QtdItem := QtdProd;
  MoveValues(fvQtd);
end;

procedure TCdPedItem.stProdTitleDblClick(Sender: TObject);
begin
  stProdTitle.Caption := '';
  eFk_Produtos.Visible := True;
end;

procedure TCdPedItem.tbContractClick(Sender: TObject);
begin
  vtItems.FullCollapse;
end;

procedure TCdPedItem.tbExpandClick(Sender: TObject);
begin
  vtItems.FullExpand;
end;

procedure TCdPedItem.vtItemsClear;
var
  Node: PVirtualNode;
  Data: Pointer;
begin
  Node := vtItems.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtItems.GetNodeData(Node);
    if (Data <> nil) then
    begin
      if (vtItems.GetNodeLevel(Node) = 0) then
      begin
        PItemsRecord(Data)^.Index := 0;
        PItemsRecord(Data)^.Node  := nil;
        PItemsRecord(Data)^.Level := 0;
        if Assigned(PItemsRecord(Data)^.Item) then
          PItemsRecord(Data)^.Item.Free;
        PItemsRecord(Data)^.Item := nil;
      end;
      if (vtItems.GetNodeLevel(Node) = 1) then
      begin
        if Assigned(PConfRecord(Data)^.Item) then
          PConfRecord(Data)^.Item.Free;
        PConfRecord(Data)^.Item := nil;
      end;
      PItemsRecord(Data)^.Index := 0;
      PItemsRecord(Data)^.Node  := nil;
      PItemsRecord(Data)^.Level := 0;
    end;
    Node := vtItems.GetNext(Node);
  end;
  vtItems.Clear;
end;

procedure TCdPedItem.eNum_ExtrChange(Sender: TObject);
begin
  if Loading then exit;
  ChangeGlobal(Sender);
  FNumExtrGen := NumExtr;
end;

procedure TCdPedItem.vtItemsDblClick(Sender: TObject);
var
  Node   : PVirtualNode;
  Data   : PItemsRecord;
  aIdx, i: Integer;
  aChild : Boolean;
begin
  Node := vtItems.FocusedNode;
  if (Node = nil) then exit;
  aChild := (vtItems.GetNodeLevel(Node) > 0);
  if aChild then
    Node := vtItems.GetVisibleParent(Node);
  if (Node = nil) then exit;
  Data := vtItems.GetNodeData(Node);
  if (Data = nil) and (Data^.Item = nil) and (Data^.Index < 0) then exit;
  aIdx := Data^.Index;
  if (Data^.Index >= ActiveOrder.OrderItems.Count) then
  begin
    ActiveOrder.OrderItems.Clear;
    Node := vtItems.GetFirst;
    while (Node <> nil) do
    begin
      Data := vtItems.GetNodeData(Node);
      if (Data <> nil) and (Data^.Item <> nil) then
        Data^.Index := ActiveOrder.OrderItems.AddOrderItem(Data^.Item);
      Node := vtItems.GetNext(Node);
    end;
  end;
  ActiveOrder.OrderItems.ItemIndex := aIdx;
  if aChild then
  begin
    pgItems.ActivePageIndex := 2;
    MoveDataToControls;
    SetActiveItemToConfigGrid(0);
    for i := 0 to ActiveOrder.OrderItems.Items[aIdx].ConfigItems.Count - 1 do
    begin
      ActiveOrder.OrderItems.Items[aIdx].ConfigItems.ItemIndex := i;
      SetActiveItemToConfigGrid(1);
    end;
    if (not vtConfig.Expanded[vtConfig.GetFirst]) then
      vtConfig.FullExpand;
    if (Data^.State in UPDATE_MODE) then
      ScrState := dbmEdit;
  end
  else
  begin
    pgItems.ActivePageIndex := 1;
    MoveDataToControls;
    if (Data^.State in UPDATE_MODE) then
      ScrState := dbmEdit;
  end;
end;

procedure TCdPedItem.vtItemsFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  if (Node = nil) then exit;
  FActiveNode := Node;
end;

procedure TCdPedItem.MoveValues(const Sender: TTypeFieldValue);
begin
  if (Sender <> fvQtd) then
    QtdProd    := ActiveItem.QtdItem;
  if (Sender <> fvVlr) then
    VlrUnit    := ActiveItem.VlrUnit;
  if (Sender <> fvAcrd) then
    VlrAcrDsct := ActiveItem.VlrAcrDsct;
  SubTot       := ActiveItem.SubTot;
  TotItem      := ActiveItem.TotItem;
  TotConfig    := ActiveItem.TotItem;
end;

procedure TCdPedItem.SetOrderTypes(AValue: TOrderTypes);
begin
  inherited;
  lFk_Tabela_Precos.Enabled := (not (otPurchaseOrder in AValue));
  eFk_Tabela_Precos.Enabled := (not (otPurchaseOrder in AValue));
  lVlr_Unit.Enabled          := (otPurchaseOrder in AValue) or (ActiveOrder.FkMovement.FlagLdv);
  eVlr_Unit.Enabled          := (otPurchaseOrder in AValue) or (ActiveOrder.FkMovement.FlagLdv);
  if (otPurchaseOrder in AValue) then
    lNum_Extr.Caption := 'Núm. no Fornec.: '
  else
    lNum_Extr.Caption := 'Núm. do Cliente: '
end;

procedure TCdPedItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F3) and (pgItems.ActivePageIndex = 1) then
    sbSearchProd.Click;
end;

procedure TCdPedItem.vtItemsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  PData: PItemsRecord;
begin
  if (Node = nil) or (ActiveOrder.OrderItems.Count = 0) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    PData := Sender.GetNodeData(Node);
    if (PData = nil) or (PData^.Item = nil) then exit;
    if (PData^.Item.FlagBxaStt) then
      TargetCanvas.Font.Color := clGreen;
    if (PData^.Item.FlagPend) and (PData^.Item.DtaFat > 0) then
      TargetCanvas.Font.Color := clRed;
    if (not PData^.Item.FlagPend) and (PData^.Item.DtaFat > 0) then
      TargetCanvas.Font.Color := clBlue;
    if (PData^.Item.DtaLiq > 0) then
      TargetCanvas.Font.Color := clGray;
  end
end;

procedure TCdPedItem.SetActiveOrder(const Value: TOrder);
begin
  FActiveOrder.Clear;
  if (Value <> nil) then
  begin
    FActiveOrder.Assign(Value);
    if FActiveOrder.PkOrder > 0 then
      Pk := FActiveOrder.PkOrder;
  end;
end;

end.
