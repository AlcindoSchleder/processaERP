unit CadPedItem;

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
  Dialogs, OrderForms, ComCtrls, ToolWin, VirtualTrees, ExtCtrls, StdCtrls,
  Mask, ToolEdit, CurrEdit, Buttons, ProcUtils, PrcCombo, TSysEstq, TSysEstqAux,
  TSysConfAux, TSysPed, TSysPedAux, GridRow, jpeg;

type
  PItemRecord = ^TItemRecord;
  TItemRecord = record
    Node: PVirtualNode;
    Item: TOrderItem;
  end;

  TCdPedItem = class(TOrderForm)
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
    tbNavigation: TToolBar;
    tbPrior: TToolButton;
    tbNext: TToolButton;
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
  private
    { Private declarations }
    FGrMovID     : SmallInt;
    FNextConfig  : Boolean;
    FOwnerID     : Integer;
    FPriceTabID  : SmallInt;
    FTpMovID     : SmallInt;
    FTypeVol     : Byte;
    FTypeCode    : Byte;
    FOnChangeItem: TChangeItemEvent;
    function  GetActiveItem: TOrderItem;
    procedure SetGrMovID(AValue: SmallInt);
    function  GetOrderItems: TOrderItems;
    procedure SetOrderItems(AValue: TOrderItems);
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
    procedure ChangeMode(Sender: TForm; AScrMode: TDBMode);
    procedure SelectNewPriceToItem;
    procedure AddDataToGrid(AData: TDataRow);
    procedure AddConfigDataToGrid(ANode: PVirtualNode; AIdx: Integer);
    procedure SetActiveItemToConfigGrid(ALevel: Integer);
    procedure ShowItem(Item: TOrderItem);
  public
    { Public declarations }
    procedure LoadDefaults                  ; override;
    procedure MoveObjectToControls          ; override;
    procedure ClearControls(Sender: TObject); override;
    procedure SaveIntoDB                    ; override;
    property  ActiveCompany;
    property  ActiveOrder;
    property  OrderTypes;
    property  WorkOrder;
    property  OrderItems    : TOrderItems      read GetOrderItems     write SetOrderItems;
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
    property  AlqICMS       : Double           read GetAlqICMS        write SetAlqICMS;
    property  AlqICMSS      : Double           read GetAlqICMSS       write SetAlqICMSS;
    property  AlqISS        : Double           read GetAlqISS         write SetAlqISS;
    property  AlqOtr        : Double           read GetAlqOtr         write SetAlqOtr;
    property  FkTypeMovement: TMovement        read GetFkTypeMovement write SetFkTypeMovement;
    property  FkPriceTable  : TPriceTable      read GetFkPriceTable   write SetFkPriceTable;
    property  FkComponents  : TComponentType   read GetFkComponents   write SetFkComponents;
    property  FkReference   : TReferenceType   read GetFkReference    write SetFkReference;
    property  FkMaterial    : TProducts        read GetFkMaterial     write SetFkMaterial;
    property  QtdPec        : Double           read GetQtdPec         write SetQtdPec;
    property  QtdParcial    : Integer          read GetQtdParcial     write SetQtdParcial;
    property  QtdCompTot    : Integer          read GetQtdCompTot     write SetQtdCompTot;
    property  OnChangeItem  : TChangeItemEvent read FOnChangeItem     write FOnChangeItem;
  end;

var
  CdPedItem: TCdPedItem;

implementation

uses Dado, mSysPed, ProcType, FuncoesDB, DB;

{$R *.dfm}

procedure TCdPedItem.FormCreate(Sender: TObject);
begin
  inherited;
  FNextConfig             := True;
  pgItems.ActivePageIndex := 0;
  vtItems.NodeDataSize    := SizeOf(TGridData);
  vtConfig.NodeDataSize   := SizeOf(TGridData);
  vtItems.Images          := Dados.Image16;
  vtItems.Header.Images   := Dados.Image16;
  vtConfig.Images         := Dados.Image16;
  vtConfig.Header.Images  := Dados.Image16;
  cbItems.Images          := Dados.Image16;
  tbTools.Images          := Dados.Image16;
  tbNavigation.Images     := Dados.Image16;
  tbNavigation.Images     := Dados.Image16;
  OnChangeMode            := ChangeMode;
  ListLoaded              := False;
  FItemIndex              := -1;
  Dados.Image16.GetBitmap(35, sbSearchProd.Glyph);
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
  ReleaseTreeNodes(vtItems);
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

procedure TCdPedItem.MoveObjectToControls;
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
    QtdProd        := ActiveItem.QtdItem;
    VlrUnit        := ActiveItem.VlrUnit;
    FkUnidades     := ActiveItem.FkUnit;
    SubTot         := ActiveItem.SubTot;
    VlrAcrDsct     := ActiveItem.VlrAcrDsct;
    TotItem        := ActiveItem.TotItem;
    TotConfig      := ActiveItem.TotItem;
    AlqICMS        := ActiveItem.AlqIcms.TaxPercent;
    AlqICMSS       := ActiveItem.AlqIcmss.TaxPercent;
    AlqISS         := ActiveItem.AlqIss.TaxPercent;
    AlqOtr         := ActiveItem.AlqIpi.TaxPercent;
    FkTypeMovement := ActiveItem.FkMovement;
    FkPriceTable   := ActiveItem.FkPriceTable;
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
    i := ActiveItem.ConfigItems.ItemIndex;
    FkComponents   := ActiveItem.ConfigItems.Items[i].FkComponentType;
    FkReference    := ActiveItem.ConfigItems.Items[i].FkReferenceType;
    FkMaterial     := ActiveItem.ConfigItems.Items[i].FkProduct;
    QtdPec         := ActiveItem.QtdItem;
    TotConfig      := ActiveItem.TotItem;
    QtdParcial     := ActiveItem.ConfigItems.Items[i].QtdParcial;
    QtdCompTot     := ActiveItem.ConfigItems.Items[i].QtdCompTot;
  end;
  Loading := False;
end;

function  TCdPedItem.GetActiveItem: TOrderItem;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (vtItems.RootNodeCount > 0) or (vtItems.FocusedNode = nil) then exit;
  Data := vtItems.GetNodeData(vtItems.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) or (Data^.DataRow.UserData = nil) then
    exit;
  Result := TOrderItem(Data^.DataRow.UserData)
end;

function  TCdPedItem.GetOrderItems: TOrderItems;
begin
  Result := WorkOrder.OrderItems;
end;

procedure TCdPedItem.SetOrderItems(AValue: TOrderItems);
var
  i: Integer;
begin
  WorkOrder.OrderItems.Clear;
  if Assigned(AValue) then
    WorkOrder.OrderItems := AValue;
  if (MultiCompany) and (WorkOrder.OrderItems.Count > 0) then
    WorkOrder.SortCompany(0, WorkOrder.OrderItems.Count - 1);
  ReleaseTreeNodes(vtItems);
  for i := 0 to WorkOrder.OrderItems.Count - 1 do
    ShowItem(WorkOrder.OrderItems.Items[i]);
end;

procedure TCdPedItem.ClearControls(Sender: TObject);
begin
  Loading        := True;
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
  QtdPec         := 0;
  QtdParcial     := 0;
  QtdCompTot     := 0;
  Loading        := False;
end;

procedure TCdPedItem.SaveIntoDB;
begin
  if WorkOrder = nil then
    raise Exception.Create('SaveItem Error: WorkOrder = nil');
  if pgItems.ActivePageIndex > 0 then
    pgItems.ActivePageIndex := 0;
  ShowItem(ActiveItem);
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
  eFk_Componentes.ReleaseObjects;
  eFk_Componentes.Items.AddStrings(dmSysPed.LoadComponents(ActiveItem.FkProduct.PkProducts));
end;

procedure TCdPedItem.LoadPrdFinishes;
begin
  eFk_Tipo_Referencias.ReleaseObjects;
  eFk_Tipo_Referencias.Items.AddStrings(dmSysPed.LoadFinish(
    ActiveItem.FkProduct.ProductCost.FkCompany.PkCompany,
    ActiveItem.FkProduct.PkProducts, FkComponents));
end;

procedure TCdPedItem.LoadPrdMaterial;
begin
  eFk_Insumos.ReleaseObjects;
  eFk_Insumos.Items.AddStrings(dmSysPed.LoadMaterial(
    FkReference.FkFinishType.PkFinishType, FkReference.PkReferenceType));
end;

procedure TCdPedItem.ChangeMode(Sender: TForm; AScrMode: TDBMode);
begin
  tbCancel.Enabled := (AScrMode in UPDATE_MODE);
  tbSave.Enabled   := (AScrMode in UPDATE_MODE) and (ActiveItem <> nil);
  tbDelete.Enabled := (AScrMode in SCROLL_MODE) and (vtItems.RootNodeCount > 0);
  tbPrior.Enabled  := (AScrMode in SCROLL_MODE) and (vtItems.RootNodeCount > 0) and
                      (vtItems.GetFirst <> vtItems.FocusedNode);
  tbNext.Enabled   := (AScrMode in SCROLL_MODE) and (vtItems.RootNodeCount > 0) and
                      (vtItems.GetLast <> vtItems.FocusedNode);
  if (AScrMode = dbmInsert) then
    ClearControls(Self);
  if (AScrMode = dbmBrowse) then
    pgItems.ActivePageIndex := 0;
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
    eFk_Tipo_Movimentos.SetIndexFromObjectValue(AValue.PkTypeMovement);
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
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Componentes.ItemIndex;
  if (aIdx >= 0) and (eFk_Componentes.Items.Objects[aIdx] <> nil) then
    Result := TComponentType(eFk_Componentes.Items.Objects[aIdx]);
end;

procedure TCdPedItem.SetFkComponents(AValue: TComponentType);
begin
  if (AValue = nil) then
    eFk_Componentes.ItemIndex := -1
  else
    eFk_Componentes.SetIndexFromObjectValue(AValue.PkComponent);
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
  if (AValue = nil) then
    eFk_Insumos.ItemIndex := -1
  else
    eFk_Insumos.SetIndexFromObjectValue(AValue.PkProducts);
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
  if (AValue = nil) then
    eFk_Tipo_Referencias.ItemIndex := -1
  else
    eFk_Tipo_Referencias.SetIndexFromObjectValue(AValue.PkReferenceType);
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
  MoveObjectToControls;
end;

procedure TCdPedItem.eVlr_UnitChange(Sender: TObject);
begin
  if Loading then exit;
  ChangeGlobal(Sender);
  ActiveItem.VlrUnit := VlrUnit;
  MoveObjectToControls;
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
    eFk_Produtos.Items.AddStrings(dmSysPed.GetProdRef(ActiveCompany.PkCompany,
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
  if (FkComponents <> nil) then
  begin
    QtdCompTot := Trunc(FkComponents.QtdComp * QtdProd);
    QtdParcial := QtdCompTot;
    LoadPrdFinishes;
  end;
end;

procedure TCdPedItem.eFk_Tipo_ReferenciasSelect(Sender: TObject);
begin
  if (FkReference <> nil) then
    LoadPrdMaterial;
end;

procedure TCdPedItem.tbInsertClick(Sender: TObject);
begin
  if (FGrMovID <= 0) or (FTpMovID <= 0) then
  begin
    Dados.DisplayHint(tbInsert, 'Novo Item: Para inserir um ítem você deve ' +
      'preencher os campos acima.', 'Inserção de Ítens', hiError);
    exit;
  end;
  if (pgItems.ActivePageIndex = 0) then
    pgItems.ActivePageIndex := 1;
  ScrMode := dbmInsert;
end;

procedure TCdPedItem.ShowItem(Item: TOrderItem);
var
  Node: PVirtualNode;
  Data: PGridData;
  i: Integer;
begin
  vtItems.BeginUpdate;
  try
    if (ScrMode = dbmInsert) then
      Node := vtItems.AddChild(nil)
    else
      Node := vtItems.FocusedNode;
    if (Node <> nil) then
    begin
      Data := vtItems.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level := 0;
        Data^.Node  := Node;
        if (ScrMode = dbmInsert) then
          Data^.DataRow := TDataRow.Create(nil);
        AddDataToGrid(Data^.DataRow);
        for i := 0 to WorkOrder.OrderItems.Items[FItemIndex].ConfigItems.Count - 1 do
        begin
          if WorkOrder.OrderItems.Items[FItemIndex].HasConfig then
            AddConfigDataToGrid(Node, i);
        end;
        vtItems.FocusedNode := Node;
      end;
    end;
  finally
    vtItems.EndUpdate;
  end;
end;

procedure TCdPedItem.AddDataToGrid(AData: TDataRow);
begin
  if (AData = nil) or (ActiveItem = nil) then exit;
  with WorkOrder.OrderItems.Items[ItemIndex] do
  begin
    if (AData.FindField['PK_PEDIDOS_ITENS'] = nil) then
      AData.AddAs('PK_PEDIDOS_ITENS', Index + 1, ftInteger, SizeOf(Integer))
    else
      AData.FieldByName['PK_PEDIDOS_ITENS'].AsInteger := Index + 1;
    if (AData.FindField['COD_REF'] = nil) then
      AData.AddAs('COD_REF', CodRef, ftString, 31)
    else
      AData.FieldByName['COD_REF'].AsString := CodRef;
//    aStr := FkProduct.DscProd;
    if (AData.FindField['DSC_PROD'] = nil) then
      AData.AddAs('DSC_PROD', FActiveItem.FkProduct.DscProd, ftString, 51)
    else
      AData.FieldByName['DSC_PROD'].AsString := FActiveItem.FkProduct.DscProd;
    if (AData.FindField['QTD_PROD'] = nil) then
      AData.AddAs('QTD_PROD', QtdProd, ftFloat, SizeOf(Double))
    else
      AData.FieldByName['QTD_PROD'].AsFloat := QtdProd;
    if (AData.FindField['MNM_UNI'] = nil) then
      AData.AddAs('MNM_UNI', FkProduct.FkUnit.MnmoUni, ftString, 3)
    else
      AData.FieldByName['MNM_UNI'].AsString := FkProduct.FkUnit.MnmoUni;
    if (AData.FindField['VLR_UNIT'] = nil) then
      AData.AddAs('VLR_UNIT', VlrUnit, ftFloat, SizeOf(Double))
    else
      AData.FieldByName['VLR_UNIT'].AsFloat := VlrUnit;
    if (AData.FindField['VLR_ACR_DST'] = nil) then
      AData.AddAs('VLR_ACR_DST', VlrAcrDsct, ftFloat, SizeOf(Double))
    else
      AData.FieldByName['VLR_ACR_DST'].AsFloat := VlrAcrDsct;
    if (AData.FindField['TOT_PROD'] = nil) then
      AData.AddAs('TOT_PROD', TotItem, ftFloat, SizeOf(Double))
    else
      AData.FieldByName['TOT_PROD'].AsFloat := TotItem;
  end;
end;

procedure TCdPedItem.AddConfigDataToGrid(ANode: PVirtualNode; AIdx: Integer);
var
  aStr: string;
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (ANode = nil) then exit;
  Node := vtItems.AddChild(ANode);
  if (Node = nil) then exit;
  Data := vtItems.GetNodeData(Node);
  if (Data = nil) then exit;
  Data^.Level := 1;
  Data^.Node  := Node;
  Data^.DataRow := TDataRow.Create(nil);
  // Add all fields of configuration here...
  with WorkOrder.OrderItems.Items[FItemIndex] do
  begin
    if (Data^.DataRow.FindField['PK_PEDIDOS_ITENS_CONF'] = nil) then
      Data^.DataRow.AddAs('PK_PEDIDOS_ITENS_CONF', AIdx + 1, ftInteger, SizeOf(Integer))
    else
      Data^.DataRow.FieldByName['PK_PEDIDOS_CONF'].AsInteger := Index + 1;
    aStr := InsereZer(IntToStr(ConfigItems.Items[AIdx].FkComponentType.PkComponent), 2) + '-' +
            InsereZer(IntToStr(ConfigItems.Items[AIdx].FkFinishType.PkFinishType), 2) + '-' +
            InsereZer(IntToStr(ConfigItems.Items[AIdx].FkReferenceType.PkReferenceType), 2);
    if (Data^.DataRow.FindField['COD_REF'] = nil) then
      Data^.DataRow.AddAs('COD_REF', aStr, ftString, 31)
    else
      Data^.DataRow.FieldByName['COD_REF'].AsString := aStr;
    aStr := ConfigItems.Items[AIdx].FkComponentType.DscTComp + ' / ' +
            ConfigItems.Items[AIdx].FkReferenceType.DscRef + ' / ' +
            ConfigItems.Items[AIdx].FkProduct.DscProd;
    if (Data^.DataRow.FindField['DSC_CONF'] = nil) then
      Data^.DataRow.AddAs('DSC_CONF', aStr, ftString, Length(aStr) + 1)
    else
      Data^.DataRow.FieldByName['DSC_CONF'].AsString := aStr;
    if (Data^.DataRow.FindField['QTD_PROD'] = nil) then
      Data^.DataRow.AddAs('QTD_PROD', ConfigItems.Items[AIdx].QtdParcial, ftFloat, SizeOf(Double))
    else
      Data^.DataRow.FieldByName['QTD_PROD'].AsFloat := ConfigItems.Items[AIdx].QtdParcial;
    if (Data^.DataRow.FindField['VLR_UNIT'] = nil) then
      Data^.DataRow.AddAs('VLR_UNIT', ConfigItems.Items[AIdx].FkFinishType.PreVda, ftFloat, SizeOf(Double))
    else
      Data^.DataRow.FieldByName['VLR_UNIT'].AsFloat := ConfigItems.Items[AIdx].FkFinishType.PreVda;
    if (Data^.DataRow.FindField['TOT_CONF'] = nil) then
      Data^.DataRow.AddAs('TOT_CONF', ConfigItems.Items[AIdx].TotConf, ftFloat, SizeOf(Double))
    else
      Data^.DataRow.FieldByName['TOT_CONF'].AsFloat := ConfigItems.Items[AIdx].TotConf;
  end;
end;

procedure TCdPedItem.SetActiveItemToConfigGrid(ALevel: Integer);
var
  Node: PVirtualNode;
  Data: PGridData;
  aStr: string;
begin
  if (ALevel = 0) then
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
        Data^.DataRow.AddAs('DSC_PROD', FActiveItem.FkProduct.DscProd, ftString, 51);
        Data^.DataRow.AddAs('VLR_UNIT', FActiveItem.VlrUnit, ftFloat, SizeOf(Double))
    end
    else
    begin
      aStr := FkComponents.DscTComp + '/' + FkReference.FkFinishType.DscAcbm +
              '/' + FkReference.DscRef;
      Data^.DataRow.AddAs('DSC_ACBM', aStr, ftString, Length(aStr) + 1);
      Data^.DataRow.AddAs('VLR_ACBM', FkReference.FkFinishType.PreVda, ftFloat,
        SizeOf(Double))
    end;
  finally
    vtConfig.EndUpdate;
  end;
end;

procedure TCdPedItem.tbCancelClick(Sender: TObject);
begin
  ScrMode := dbmBrowse;
  if (FActiveItem <> nil) then
    WorkOrder.OrderItems.Delete(FActiveItem.Index);
  ClearControls(Sender);
  if (pgItems.ActivePageIndex > 0) then
    pgItems.ActivePageIndex := 0;
end;

procedure TCdPedItem.tbDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtItems.FocusedNode;
  if (Node = nil) then exit;
  Data := vtItems.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (WorkOrder = nil) or
     (Data^.DataRow.FindField['INDEX'].AsInteger = 0) or (WorkOrder.OrderItems = nil) or
     (Data^.DataRow.FieldByName['INDEX'].AsInteger >= WorkOrder.OrderItems.Count) then
    exit;
  WorkOrder.OrderItems.Delete(Data^.DataRow.FieldByName['INDEX'].AsInteger);
  vtItems.DeleteNode(Node);
  if (pgItems.ActivePageIndex > 0) then
    pgItems.ActivePageIndex := 0;
  ScrMode := dbmBrowse;
end;

procedure TCdPedItem.tbSaveClick(Sender: TObject);
var
  i: Integer;
begin
  if (pgItems.ActivePageIndex = 1) and (FActiveItem.FlagConf) then
  begin
    pgItems.ActivePageIndex := 2;
    FNextConfig             := True;
    QtdPec := Trunc(QtdProd);
    eFk_Componentes.ReleaseObjects;
    eFk_Componentes.Clear;
    eFk_Componentes.Text := '';
    LoadPrdComponents;
    SetActiveItemToConfigGrid(0);
    if (ScrMode = dbmEdit) and (FItemIndex > -1) and
       (WorkOrder.OrderItems.Count > FItemIndex) then
    begin
      eFk_Produtos.Items.AddObject(WorkOrder.OrderItems.Items[FItemIndex].FkProduct.DscProd,
        WorkOrder.OrderItems.Items[FItemIndex]);
      FActiveItem := WorkOrder.OrderItems.Items[FItemIndex];
      for i := 0 to WorkOrder.OrderItems.Items[FItemIndex].ConfigItems.Count - 1 do
      begin
        FActiveItem.ConfigItems.ItemIndex := i;
        SetActiveItemToConfigGrid(1);
      end;
    end;
  end
  else
  begin
    if (FNextConfig) then // if Configuration not saved then
    begin
      NextConfig;
      if (FNextConfig) and (FActiveItem <> nil) and
         (FActiveItem.FlagConf) and (not FActiveItem.HasConfig) then
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
        FOnChangeItem(WorkOrder, ActiveItem);
      ScrMode := dbmBrowse;
    end;
  end;
end;

procedure TCdPedItem.eProd_RefExit(Sender: TObject);
begin
  Loading := True;
  eFk_Produtos.ReleaseObjects;
  eFk_Produtos.Items.AddStrings(dmSysPed.GetProdRef(ActiveCompany.PkCompany,
    FOwnerID, ProdRef, FPriceTabID, FGrMovID, FTpMovID, FTypeVol, FTypeCode,
    QtdProd));
  if eFk_Produtos.Items.Count = 0 then
    raise Exception.Create('ProductItem: Produto não Encontrado')
  else
  begin
    eFk_Produtos.ItemIndex := 0;
    eFk_ProdutosSelect(eFk_Produtos);
    Loading := False;
  end;
end;

procedure TCdPedItem.eFk_ProdutosSelect(Sender: TObject);
var
  aIdx, i: Integer;
const
  STATUS_CODE: array [0..6] of ShortInt = (-50, -20, -10, -5, 0, 30, 40);
  STATUS_MSG : array [0..6] of string   = ('Todas as condições atendidas',
    'Não posso calcular o preço', 'Produto não encontrado',
    'Tipo de movimentação não encontrada', 'Impostos não encontrados',
    'Empresa do produto não definida', 'Classificação fiscal não cadastrada');
begin
  if (SelectedItem <> nil) then
  begin
    aIdx := WorkOrder.OrderItems.AddOrderItem(SelectedItem);
    if (aIdx > -1) then
    begin
      FActiveItem := WorkOrder.OrderItems.Items[aIdx];
      if (FActiveItem.Status <> 0) then
      begin
        aIdx := -1;
        for i := Low(STATUS_CODE) to High(STATUS_CODE) do
          if (FActiveItem.Status = STATUS_CODE[i]) then
            aIdx := i;
        if (aIdx > -1) then
        begin
          if (FActiveItem.Status > 0) then
            Dados.DisplayHint(eProd_Ref, STATUS_MSG[aIdx], 'Status do Produto', hiInformation)
          else
          begin
            Dados.DisplayMessage(STATUS_MSG[aIdx], hiError, [mbOk]);
            eProd_Ref.SetFocus;
          end;
        end;
      end;
      tbSave.Enabled := (FActiveItem <> nil);
      MoveObjectToControls;
    end;
  end;
end;

procedure TCdPedItem.sbSearchProdClick(Sender: TObject);
begin
 // Open Modal form to search products
end;

procedure TCdPedItem.NextConfig;
var
  i, j,
  aIdx: Integer;
begin
  // Save data into grid and into item config....
  // Subtract selected qtd, save it into eQtdPec and repeat configuration util
  // eQtdPec = 0 equal zero
  if (FkComponents = nil) or (FkReference = nil) or (FkMaterial = nil) then
    exit;
  with FActiveItem.ConfigItems.Add do
  begin
    FkComponentType := FkComponents;
    FkFinishType    := FkReference.FkFinishType;
    FkReferenceType := FkReference;
    FkProduct       := FkMaterial;
    FlagBxaStt      := False;
    FlagCntr        := True;
    FlagFrnCli      := False;
    FlagPend        := False;
    PerDsctIns      := 0;
    QtdParcial      := Self.QtdParcial;
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
  FNextConfig := False;
  if eFk_Componentes.Items.Count > 0 then
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
  Data: PGridData;
begin
  if (Node = nil) or (WorkOrder.OrderItems.Count = 0) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    case Column of
      0: CellText := Data^.DataRow.FieldByName['PK_PEDIDOS_ITENS'].AsString;
      1: CellText := Data^.DataRow.FieldByName['COD_REF'].AsString;
      2: CellText := Data^.DataRow.FieldByName['DSC_PROD'].AsString;
      3: CellText := FloatToStrF(Data^.DataRow.FieldByName['QTD_PROD'].AsFloat, ffNumber, 7, 2);
      4: CellText := Data^.DataRow.FieldByName['MNM_UNI'].AsString;
      5: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_UNIT'].AsFloat, ffNumber, 7, 2);
      6: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_ACR_DST'].AsFloat, ffNumber, 7, 2);
      7: CellText := FloatToStrF(Data^.DataRow.FieldByName['TOT_PROD'].AsFloat, ffNumber, 7, 2);
    end;
  end;
  if (Sender.GetNodeLevel(Node) = 1) then
  begin
    case Column of
      0: CellText := Data^.DataRow.FieldByName['PK_PEDIDOS_ITENS_CONF'].AsString;
      1: CellText := Data^.DataRow.FieldByName['COD_REF'].AsString;
      2: CellText := Data^.DataRow.FieldByName['DSC_CONF'].AsString;
      3: CellText := FloatToStrF(Data^.DataRow.FieldByName['QTD_PROD'].AsFloat, ffNumber, 7, 2);
      4: CellText := ' ';
      5: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_UNIT'].AsFloat, ffNumber, 7, 2);
      6: CellText := ' ';
      7: CellText := FloatToStrF(Data^.DataRow.FieldByName['TOT_CONF'].AsFloat, ffNumber, 7, 2);
    end;
  end;
end;

procedure TCdPedItem.eQtd_ProdChange(Sender: TObject);
begin
  if Loading then exit;
  ChangeGlobal(Sender);
  FActiveItem.QtdItem := QtdProd;
  MoveObjectToControls;
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

end.
