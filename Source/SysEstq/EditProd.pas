unit EditProd;

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
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ToolEdit,
  jpeg, ExtCtrls, VirtualTrees, ProcType, ComCtrls, ToolWin, Menus, CadListMod,
  GridRow, Mask, TSysEstq, CurrEdit, TSysEstqAux, ProcUtils, Types,
  PrdForms;

type
  TProdFormClass = class of TProdForm;

  TProductPage  = (ppSale, ppPurchase, ppServices, ppPatrimony, ppParts,
                   ppMargin, ppCost, ppTaxes, ppSuppliers);
  TProductPages = set of TProductPage;

  TTfrmProducts = class(TfrmModel)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbNew: TToolButton;
    tbCancel: TToolButton;
    tbSepOper: TToolButton;
    tbPrior: TToolButton;
    tbNext: TToolButton;
    tbSepSave: TToolButton;
    tbSave: TToolButton;
    tbDelete: TToolButton;
    tbFind: TToolButton;
    tbSepFind: TToolButton;
    tbSepClose: TToolButton;
    tbClose: TToolButton;
    pgControl: TPageControl;
    tsData: TTabSheet;
    tsList: TTabSheet;
    pAllData: TPanel;
    pProduct: TPanel;
    lPk_Produtos: TStaticText;
    eFk_Secoes: TComboBox;
    eFk_Grupos: TComboBox;
    eFk_SubGrupos: TComboBox;
    eFk_Unidades: TComboBox;
    lFk_Unidades: TStaticText;
    lFk_SubGrupos: TStaticText;
    lFk_Grupos: TStaticText;
    lFk_Secoes: TStaticText;
    lDsc_Prod: TStaticText;
    eDsc_Prod: TEdit;
    vtProdType: TVirtualStringTree;
    lFlag_Atv: TCheckBox;
    lQtd_Uni: TStaticText;
    eQtd_Uni: TCurrencyEdit;
    pgData: TPageControl;
    pDaraAux: TPanel;
    pCodes: TPanel;
    stCodeTitle: TStaticText;
    pgBlobs: TPageControl;
    tsPicture: TTabSheet;
    tsObservations: TTabSheet;
    iImgProd: TImage;
    eObs_Prod: TMemo;
    vtSearch: TVirtualStringTree;
    pmCodes: TPopupMenu;
    ePk_Produtos: TEdit;
    pmReference: TMenuItem;
    pmPk: TMenuItem;
    pmBarCode: TMenuItem;
    pmSupplier: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbPriorClick(Sender: TObject);
    procedure tbNextClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbNewClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure eFk_SecoesSelect(Sender: TObject);
    procedure eFk_GruposSelect(Sender: TObject);
    procedure vtProdTypeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtProdTypeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtProdTypeChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtProdTypeChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure tbFindClick(Sender: TObject);
    procedure vtSearchEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vtSearchDblClick(Sender: TObject);
    procedure vtSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtSearchBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure vtSearchFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
  private
    { Private declarations }
    FActivePages   : TProductPages;
    FFkSection     : Integer;
    FFkGroup       : Integer;
    FFkSubGroup    : Integer;
    FFkUnit        : Integer;
    FSearchForm    : TForm;
//    FActiveTypePrd : TTypeInsumos;
    FActivePrdType : TProductType;
    FActiveMatType : TMaterialType;
    FVisibleTypes  : TProductTypes;
    FOnScroll      : TScrollSearchEvent;
    FProductTypes: TProductTypes;
    procedure ClearDataPages;
    procedure ShowDataPages(APages: TProductPages; ACallLoadDefauls: Boolean = False);
    // Load Data from DB
    procedure LoadSections;
    procedure LoadGroups;
    procedure LoadSubGroups;
    procedure LoadUnits;
    procedure LoadProductTypes;
    procedure SetActivePrdType(AValue: TProductType);
    procedure SetActiveMatType(AValue: TMaterialType);
    procedure SetScreenFromVisibleTypes;
    procedure SetVisibleTypes(AValue: TProductTypes);
    procedure ModifyProduct_X_Type(AMode: TDBMode; APkType: Integer);
    function  ValidateOperation: Boolean;
    procedure ChangePkProduct(Sender: TObject);
    function  SetNavButtons(const ANodeCount, ANodePos: Integer): Boolean;
    function  GetDscProd: string;
    function  GetFkGroup: Integer;
    function  GetFkSection: Integer;
    function  GetFkUnit: Integer;
    function  GetFlagAtv: Boolean;
    function  GetQtdUni: Double;
    procedure SetDscProd(const Value: string);
    procedure SetFkUnit(const Value: Integer);
    procedure SetFlagAtv(const Value: Boolean);
    procedure SetQtdUni(const Value: Double);
    procedure SetFkGroup(const Value: Integer);
    procedure SetFkSection(const Value: Integer);
    procedure SetFkSubGroup(const Value: Integer);
    function  GetFkSubGroup: Integer;
    function  GetCodProd: string;
    procedure SetCodProd(const Value: string);
    function  GetProductCode: TCodeTypes;
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    property  ActivePrdType : TProductType  read FActivePrdType  write SetActivePrdType;
    property  ActiveMatType : TMaterialType read FActiveMatType  write SetActiveMatType;
    property  VisibleTypes  : TProductTypes read FVisibleTypes   write SetVisibleTypes;
  public
    { Public declarations }
    procedure ChangeSrcMode(Sender: TObject; AScrMode: TDBMode);
    procedure ChangeStatePages(Sender: TObject; AScrMode: TDBMode);
    property  CodProd     : string        read GetCodProd      write SetCodProd;
    property  DscProd     : string        read GetDscProd      write SetDscProd;
    property  QtdUni      : Double        read GetQtdUni       write SetQtdUni;
    property  FlagAtv     : Boolean       read GetFlagAtv      write SetFlagAtv;
    property  FkSection   : Integer       read GetFkSection    write SetFkSection;
    property  FkGroup     : Integer       read GetFkGroup      write SetFkGroup;
    property  FkSubGroup  : Integer       read GetFkSubGroup   write SetFkSubGroup;
    property  FkUnit      : Integer       read GetFkUnit       write SetFkUnit;
    property  ProductTypes: TProductTypes read FProductTypes   write FProductTypes;
    property  ProductCode : TCodeTypes    read GetProductCode;
    property  Pk;
    property  ScrState;
  end;

implementation

uses Dado, mSysEstq, Funcoes, EstqArqSql, FuncoesDB, Math, CadPrCode, CadPrdPrc,
  CadPrdMrg, CadPrdTax, CadPrdCst, CadPrdPrch, CadPrdSup, CadPrdSrv, CadPrdPart,
  CadPrdPatrm, TypInfo, SqlComm;

  {$R *.dfm}

var
  ProductFormClass: array [TProductPage] of TProdFormClass =
    (TfmProductSale, TfmPrdPurchase, TfrmPrdService, TfrmPrdPatrimony, TfrmPart,
     TfmProdMargins, TfmPrdCost, TfmPrdTaxes, TfmPrdSuppliers);
  ProductPageTitle: array [TProductPage] of string         =
    ('Revenda', 'Compras', 'Serviços', 'Patrimônio', 'Peças de Produção',
     'Margens e Preços',  'Custos', 'Impostos', 'Fornecedores');
  ProductPageImage: array [TProductPage] of Integer =
    (26, 51, 52, 20, 45, 47, 39, 9, 62);

const
  DSC_PRODS: array [TTypeInsumos, 0..2] of string =
    (('Revenda', 'Produção', ''),
     ('Compra', 'Composição', 'Similar'),
     ('Serviços', '', ''),
     ('Patrimônio', '', ''),
     ('Produção', '', '')
     );
  PAGES_OF_PRODUCT  : TProductPages = [ppSale, ppMargin, ppTaxes, ppCost];
  PAGES_OF_MATERIAL : TProductPages = [ppPurchase, ppSuppliers, ppCost, ppTaxes];
  PAGES_OF_SERVICE  : TProductPages = [ppServices, ppSuppliers, ppCost, ppTaxes];
  PAGES_OF_PART     : TProductPages = [ppParts, ppCost, ppSuppliers, ppTaxes];
  PAGES_OF_PATRIMONY: TProductPages = [ppPatrimony, ppSuppliers, ppCost, ppTaxes];

procedure TTfrmProducts.ClearDataPages;
var
  Ix       : Integer;
  aForm    : TForm;
  aTabSheet: TTabSheet;
begin
  Ix := Ord(High(TProductPage));
  FActivePages := [];
  if Ix > pgData.PageCount - 1 then Ix := pgData.PageCount - 1;
  while Ix > -1 do
  begin
    aTabSheet := pgData.Pages[Ix];
    aForm     := TForm(aTabSheet.Tag);
    if ((aForm <> nil) and
        (aForm is ProductFormClass[TProductPage(Ix)])) then
    begin
      aForm.Close;
      aForm.Free;
      aForm := nil;
      if aForm = nil then
        aTabSheet.Tag := 0;
    end;
    pgData.RemoveControl(aTabSheet);
    aTabSheet.Free;
    aTabSheet := nil;
    if aTabSheet = nil then Dec(Ix);
  end;
end;

procedure TTfrmProducts.FormCreate(Sender: TObject);
begin
  FVisibleTypes            := [];
  InternalState            := ChangeSrcMode;
  OnChangePK               := ChangePkProduct;
  vtSearch.Images          := Dados.Image16;
  vtSearch.Header.Images   := Dados.Image16;
  cbTools.Images           := Dados.Image16;
  tbTools.Images           := Dados.Image16;
  cbTools.Images           := Dados.Image16;
  vtProdType.Images        := Dados.Image16;
  vtProdType.Header.Images := Dados.Image16;
  vtProdType.NodeDataSize  := SizeOf(TGridData);
  pgData.Images            := Dados.Image16;
  inherited;
end;

procedure TTfrmProducts.FormDestroy(Sender: TObject);
begin
  if Assigned(fmProductCode) then
  begin
    fmProductCode.Close;
    fmProductCode.Free;
  end;
  fmProductCode := nil;
  ClearDataPages;
  ReleaseTreeNodes(vtSearch);
  ReleaseTreeNodes(vtProdType);
  FSearchForm := nil;
  inherited;
end;

procedure TTfrmProducts.LoadDefaults;
var
  i: Integer;
begin
  if not Assigned(fmProductCode) then
  begin
    fmProductCode               := TfmProductCode.Create(Application);
    fmProductCode.BorderStyle   := bsNone;
    fmProductCode.Parent        := pCodes;
    fmProductCode.Align         := alClient;
    fmProductCode.OnChangeState := ChangeSrcMode;
    fmProductCode.Show;
  end
  else
    fmProductCode.PkProduct := PK;
  if not ListLoaded then
  begin
    LoadUnits;
    LoadSections;
    ListLoaded := True;
  end;
  if Assigned(FOnScroll) then
    FOnScroll(Self, i, dbmNone, SetNavButtons);
end;

procedure TTfrmProducts.SetScreenFromVisibleTypes;
begin
  ClearDataPages;
  if (tiProduct in FVisibleTypes) and (FActivePrdType = ptSale) then
    ShowDataPages(PAGES_OF_PRODUCT);
  if (tiMaterial in FVisibleTypes) then
    ShowDataPages(PAGES_OF_MATERIAL);
  if (tiService   in FVisibleTypes) then
    ShowDataPages(PAGES_OF_SERVICE);
  if (tiPart      in FVisibleTypes) then
    ShowDataPages(PAGES_OF_PART);
  if (tiPatrimony in FVisibleTypes) then
    ShowDataPages(PAGES_OF_PATRIMONY);
end;

procedure TTfrmProducts.ShowDataPages(APages: TProductPages;
            ACallLoadDefauls: Boolean = False);
var
  iX       : TProductPage;
  aForm    : TForm;
  aTabSheet : TTabSheet;
  function LoadPages(APageType : TProductPage): TTabSheet;
  begin
    Result             := TTabSheet.Create(pgData);
    Result.PageControl := pgData;
    Result.Align       := alClient;
    Result.Caption     := ProductPageTitle[APageType];
    Result.ImageIndex  := ProductPageImage[APageType];
    Result.Tag         := 0;
  end;
begin
  if APages = [] then exit;
  for Ix := Low(TProductPage) to High(TProductPage) do
  begin
    if (Ix in APages) and (not (Ix in FActivePages)) then
    begin
      aTabSheet    := LoadPages(Ix);
      if aTabSheet <> nil then
      begin
        FActivePages := FActivePages + [Ix];
        aForm        := TForm(aTabSheet.Tag);
        if (aForm = nil) and (ProductFormClass[Ix] <> nil) then
        begin
          aForm               := ProductFormClass[Ix].Create(Self);
          aForm.Parent        := aTabSheet;
          aForm.Align         := alClient;
          aTabSheet.Tag       := LongInt(aForm);
          if aForm.InheritsFrom(TfrmModel) then
          begin
            TfrmModel(aForm).Pk             := Pk;
            TfrmModel(aForm).OnChangeState := ChangeStatePages;
          end
          else
          begin
            TProdForm(aForm).PkProduct     := Pk;
            TProdForm(aForm).OnChangeState := ChangeStatePages;
          end;
        end;
        aForm.Show;
      end;
    end;
  end;
end;

procedure TTfrmProducts.ClearControls;
begin
  Pk := 0;

  if Assigned(fmProductCode) then
  begin
    fmProductCode.ActiveProduct.Clear;
    fmProductCode.ClearControls(fmProductCode);
  end;
  MoveDataToControls;
end;

procedure TTfrmProducts.MoveDataToControls;
var
  aItem: TProducts;
begin
  if (Pk = 0) then exit;
  Loading := True;
  try
    aItem      := dmSysEstq.GetProduct(Pk);
    DscProd    := aItem.DscProd;
    QtdUni     := aItem.QtdUni;
    FlagAtv    := aItem.FlagAtv;
    FkSection  := aItem.FkSubGroup.FkGroup.FkSection.PkSection;
    FkGroup    := aItem.FkSubGroup.FkGroup.PkGroup;
    FkSubGroup := aItem.FkSubGroup.PkSubGroup;
    FkUnit     := aItem.FkUnit.PkUnit;
    if (FkSection > 0) then LoadGroups;
    if (FkGroup   > 0) then LoadSubGroups;
  finally
    Loading := False;
  end;
end;

procedure TTfrmProducts.LoadSections;
begin
  ReleaseCombos(eFk_Secoes, toObject);
  eFk_Secoes.Items.AddStrings(dmSysEstq.LoadSections);
end;

procedure TTfrmProducts.LoadGroups;
var
  aObj: TObject;
begin
  aObj := nil;
  if (FkSection > 0) then
    aObj := eFk_Secoes.Items.Objects[eFk_Secoes.ItemIndex];
  if (aObj <> nil) then
  begin
    ReleaseCombos(eFk_Grupos, toObject);
    eFk_Grupos.Items.AddStrings(dmSysEstq.LoadGroups(TSection(aObj)));
  end;
end;

procedure TTfrmProducts.LoadSubGroups;
var
  aObj: TObject;
begin
  aObj := nil;
  if (FkSection > 0) then
    aObj := eFk_Grupos.Items.Objects[eFk_Grupos.ItemIndex];
  if (aObj <> nil) then
  begin
    ReleaseCombos(eFk_SubGrupos, toObject);
    eFk_SubGrupos.Items.AddStrings(dmSysEstq.LoadSubGroups(TGroup(aObj)));
  end;
end;

procedure TTfrmProducts.LoadUnits;
begin
  ReleaseCombos(eFk_Unidades, toObject);
  eFk_Unidades.Items.AddStrings(dmSysEstq.LoadUnits);
end;

procedure TTfrmProducts.LoadProductTypes;
var
  Node: PVirtualNode;
  Data: PGridData;
  aControlTypes  : TProductTypes;
begin
  aControlTypes            := [];
  ReleaseTreeNodes(vtProdType);
  with dmSysEstq do
  begin
    if TipoProd.Active then TipoProd.Close;
    TipoProd.SQL.Clear;
    TipoProd.SQL.Add(SqlVinculoTProd);
    Dados.Conexao.StartTransaction(Dados.GetTr(Dados.FTr));
    try
      if (TipoProd.Params.FindParam('FkProdutos') <> nil) then
        TipoProd.ParamByName('FkProdutos').AsInteger := Pk;
      if not TipoProd.Active then TipoProd.Open;
      while not TipoProd.Eof do
      begin
        Node := vtProdType.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtProdType.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, TipoProd, True);
            with Data^.DataRow do
            begin
              if (FindField['FK_PRODUTOS'].AsInteger > 0) then
              begin
                case TTypeInsumos(FindField['FLAG_TPROD'].AsInteger) of
                  tiProduct  : if (tiProduct   in ProductTypes) then
                                 aControlTypes := aControlTypes + [tiProduct];
                  tiMaterial : if (tiMaterial  in ProductTypes) then
                                 aControlTypes := aControlTypes + [tiMaterial];
                  tiService  : if (tiService   in ProductTypes) then
                                 aControlTypes := aControlTypes + [tiService];
                  tiPart     : if (tiPart      in ProductTypes) then
                                 aControlTypes := aControlTypes + [tiPart];
                  tiPatrimony: if (tiPatrimony in ProductTypes) then
                                 aControlTypes := aControlTypes + [tiPatrimony];
                end;
              end;
            end;
          end;
        end;
        TipoProd.Next;
      end;
    finally
      if TipoProd.Active then TipoProd.Close;
      Dados.Conexao.Commit(Dados.GetTr(Dados.FTr));
    end;
  end;
  VisibleTypes := aControlTypes;
end;

procedure TTfrmProducts.SetActivePrdType(AValue: TProductType);
begin
  if FActivePrdType <> AValue then
    FActivePrdType  := AValue;
end;

procedure TTfrmProducts.SetActiveMatType(AValue: TMaterialType);
begin
  if FActiveMatType <> AValue then
    FActiveMatType  := AValue;
end;

procedure TTfrmProducts.tbPriorClick(Sender: TObject);
var
  aPk: Integer;
begin
  aPk := Pk;
  if Assigned(FOnScroll) then
    FOnScroll(Self, aPk, dbmPrior, SetNavButtons);
  Pk := aPk;
end;

procedure TTfrmProducts.tbNextClick(Sender: TObject);
var
  aPk: Integer;
begin
  aPk := Pk;
  if Assigned(FOnScroll) then
    FOnScroll(Self, aPk, dbmNext, SetNavButtons);
  Pk := aPk;
end;

procedure TTfrmProducts.ChangeSrcMode(Sender: TObject; AScrMode: TDBMode);
begin
  tbCancel.Enabled    := (AScrMode in UPDATE_MODE);
  tbSave.Enabled      := (AScrMode in UPDATE_MODE);
  tbDelete.Enabled    := (AScrMode in SCROLL_MODE) and (Pk > 0);
end;

procedure TTfrmProducts.tbSaveClick(Sender: TObject);
begin
  if not ValidateOperation then exit;
  ScrState := dbmPost;
  ScrState := dbmBrowse;
end;

procedure TTfrmProducts.SaveIntoDB;
var
  i: Integer;
  aForm: TForm;
  aItem: TProducts;
begin
  if (not (ScrState in UPDATE_MODE)) then exit;
  Dados.StartTransaction;
  aItem := TProducts.Create;
  try
    aItem.DscProd      := eDsc_Prod.Text;
    aItem.FlagAtv      := lFlag_Atv.Checked;
    aItem.QtdUni       := eQtd_Uni.Value;
    aItem.FkSubGroup.FkGroup.FkSection.PkSection := FkSection;
    aItem.FkSubGroup.FkGroup.PkGroup := FkGroup;
    aItem.FkSubGroup.PkSubGroup := FkSubGroup;
    aItem.FkUnit.PkUnit := FkUnit;
    FFkSection          := FkSection;
    FFkGroup            := FkGroup;
    FFkSubGroup         := FkSubGroup;
    FFkUnit             := FkUnit;
    dmSysEstq.UpdateProduct(aItem, ScrState);
    Pk := aItem.PkProducts;
    if (fmProductCode.ScrState in UPDATE_MODE) then
    begin
      fmProductCode.ActiveProduct.PkProducts := aItem.PkProducts;
      fmProductCode.ScrState := dbmPost;
      fmProductCode.ScrState := dbmBrowse;
    end;
    for i := 0 to pgData.PageCount - 1 do
    begin
      if pgData.Pages[i].Tag <> 0 then
      begin
        aForm := TForm(pgData.Pages[i].Tag);
        if aForm.InheritsFrom(TProdForm) then
        begin
          if (aForm <> nil) and (TProdForm(aForm).ScrState in UPDATE_MODE) then
          begin
            TProdForm(aForm).PkProduct := Pk;
            TProdForm(aForm).ScrState  := dbmPost;
            TProdForm(aForm).ScrState  := dbmBrowse;
          end
        end
        else
        begin
          if (aForm <> nil) and (TfrmModel(aForm).ScrState in UPDATE_MODE) then
          begin
            TfrmModel(aForm).Pk       := Pk;
            TfrmModel(aForm).ScrState := dbmPost;
            TfrmModel(aForm).ScrState := dbmBrowse;
          end;
        end;
      end;
    end;
    Dados.CommitTransaction;
  except on E:Exception do
    begin
      Dados.RollbackTransaction;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TTfrmProducts.tbNewClick(Sender: TObject);
begin
  Pk := 0;
  ClearControls;
  LoadProductTypes;
  ScrState := dbmInsert;
end;

procedure TTfrmProducts.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmCancel;
  if (Pk > 0) then Pk := Pk;
  ScrState := dbmBrowse;
end;

procedure TTfrmProducts.tbDeleteClick(Sender: TObject);
begin
  ScrState := dbmDelete;
  ScrState := dbmCancel;
end;

procedure TTfrmProducts.eFk_SecoesSelect(Sender: TObject);
begin
  if Loading then exit;
  ChangeGlobal(Sender);
  if (eFk_Secoes.ItemIndex > -1) and
     (eFk_Secoes.Items.Objects[eFk_Secoes.ItemIndex] <> nil) then
  begin
    FFkSection := TSection(eFk_Secoes.Items.Objects[eFk_Secoes.ItemIndex]).PkSection;
    ReleaseCombos(eFk_Grupos, toObject);
    ReleaseCombos(eFk_SubGrupos, toObject);
    FkGroup    := 0;
    FkSubGroup := 0;
    LoadGroups;
  end;
end;

procedure TTfrmProducts.eFk_GruposSelect(Sender: TObject);
begin
  if Loading then exit;
  ChangeGlobal(Sender);
  if (eFk_Grupos.ItemIndex > -1) and
     (eFk_Grupos.Items.Objects[eFk_Grupos.ItemIndex] <> nil) then
  begin
    FFkGroup := TGroup(eFk_Grupos.Items.Objects[eFk_Grupos.ItemIndex]).PkGroup;
    ReleaseCombos(eFk_SubGrupos, toObject);
    FkSubGroup := 0;
    LoadSubGroups;
  end;
end;

procedure TTfrmProducts.vtProdTypeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
  aFlagTProd: TTypeInsumos;
begin
  if (Node = nil) then exit;
  if Node.CheckType <> ctCheckBox then
    Node.CheckType := ctCheckBox;
  Data := vtProdType.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aFlagTProd := TTypeInsumos(Data^.DataRow.FieldByName['FLAG_TPROD'].AsInteger);
  if Data^.DataRow.FindField['FK_PRODUTOS'] = nil then
    Node.CheckState := csUncheckedNormal
  else
    if (Data^.DataRow.FindField['FK_PRODUTOS'].AsInteger > 0) then
    begin
      Node.CheckState := csCheckedNormal;
      case TTypeInsumos(Data^.DataRow.FindField['FLAG_TPROD'].AsInteger) of
        tiProduct  : if (tiProduct   in ProductTypes) then VisibleTypes := VisibleTypes + [tiProduct];
        tiMaterial : if (tiMaterial  in ProductTypes) then VisibleTypes := VisibleTypes + [tiMaterial];
        tiService  : if (tiService   in ProductTypes) then VisibleTypes := VisibleTypes + [tiService];
        tiPart     : if (tiPart      in ProductTypes) then VisibleTypes := VisibleTypes + [tiPart];
        tiPatrimony: if (tiPatrimony in ProductTypes) then VisibleTypes := VisibleTypes + [tiPatrimony];
      end;
    end;
  if (not (aFlagTProd in ProductTypes)) then
    Node.States   := Node.States + [vsDisabled]
  else
    if (vsDisabled in Node.States) then
      Node.States := Node.States - [vsDisabled];
end;

procedure TTfrmProducts.vtProdTypeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Column = 0 then
    CellText := Data^.DataRow.FieldByName['DSC_TPRD'].AsString;
end;

procedure TTfrmProducts.SetVisibleTypes(AValue: TProductTypes);
begin
  if (AValue <> FVisibleTypes) then
  begin
    FVisibleTypes := AValue;
    SetScreenFromVisibleTypes;
  end;
end;

procedure TTfrmProducts.vtProdTypeChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  Data: PGridData;
  aFlagTProd: TTypeInsumos;
begin
  if (Node = nil) then exit;
  Data := vtProdType.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aFlagTProd := TTypeInsumos(Data^.DataRow.FieldByName['FLAG_TPROD'].AsInteger);
  Allowed := ((aFlagTProd in ProductTypes) and (Pk > 0));
end;

procedure TTfrmProducts.vtProdTypeChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
  aFlagTProd: TTypeInsumos;
  aPk : Integer;
  aMode: TDBMode;
begin
  if (Node = nil) then exit;
  Data := vtProdType.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) and (Pk = 0) then exit;
  aFlagTProd := TTypeInsumos(Data^.DataRow.FieldByName['FLAG_TPROD'].AsInteger);
  if (aFlagTProd in ProductTypes) then
  begin
    aPk := Data^.DataRow.FieldByName['PK_TIPO_PRODUTOS'].AsInteger;
    if (Node.CheckState = csCheckedNormal) then
    begin
      aMode := dbmInsert;
      if (not (aFlagTProd in FVisibleTypes)) then
        VisibleTypes := FVisibleTypes + [aFlagTProd];
    end
    else
    begin
      aMode := dbmDelete;
      if ((aFlagTProd in FVisibleTypes)) then
        VisibleTypes := FVisibleTypes - [aFlagTProd];
    end;
    ModifyProduct_X_Type(aMode, aPk);
  end;
end;

procedure TTfrmProducts.ModifyProduct_X_Type(AMode: TDBMode; APkType: Integer);
begin
  with dmSysEstq do
  begin
    if TipoProd.Active then TipoProd.Close;
    TipoProd.SQL.Clear;
    if (AMode = dbmInsert) then
      TipoProd.SQL.Add(SqlInsertProd_X_Type);
    if (AMode = dbmDelete) then
      TipoProd.SQL.Add(SqlDeleteProd_X_Type);
    Dados.Conexao.StartTransaction(Dados.GetTr(Dados.FTr));
    try
      if TipoProd.Params.FindParam('FkTipoProdutos') <> nil then
        TipoProd.ParamByName('FkTipoProdutos').AsInteger := APkType;
      if TipoProd.Params.FindParam('FkProdutos') <> nil then
        TipoProd.ParamByName('FkProdutos').AsInteger := Pk;
      TipoProd.ExecSQL;
      Dados.Conexao.Commit(Dados.GetTr(Dados.FTr));
    except on E:Exception do
      begin
        Dados.Conexao.Rollback(Dados.GetTr(Dados.FTr));
        raise Exception.Create('TfmEditProd: Erro na gravação do vínculo' + NL +
          E.Message);
      end;
    end;
  end;
end;

function TTfrmProducts.ValidateOperation: Boolean;
begin
  Result := False;
  if (ScrState = dbmInsert) then
  begin
    if (Assigned(fmProductCode)) and (fmProductCode.vtCodes.RootNodeCount = 0) then
//      fmProductCode.tbReferenceClick(Self);
  end;
  if (FkSection <= 0) then
  begin
    Dados.DisplayHint(eFk_Secoes, 'Deve selecionar uma seção para o produto');
    exit;
  end;
  if (FkGroup <= 0) then
  begin
    Dados.DisplayHint(eFk_Grupos, 'Deve selecionar um grupo para o produto');
    exit;
  end;
  if (FkSubGroup <= 0) then
  begin
    Dados.DisplayHint(eFk_SubGrupos, 'Deve selecionar um subgrupo para o produto');
    exit;
  end;
  if (FkUnit <= 0) then
  begin
    Dados.DisplayHint(eFk_Unidades, 'Deve selecionar uma unidade para o produto');
    exit;
  end;
  if (QtdUni = 0) then
  begin
    Dados.DisplayHint(eQtd_Uni, 'Deve preencher o campo quantidade de uso para o produto');
    exit;
  end;
  if (DscProd = '') then
  begin
    Dados.DisplayHint(eDsc_Prod, 'Deve preencher o campo descrição para o produto');
    exit;
  end;
  Result := True;
end;

procedure TTfrmProducts.ChangePkProduct(Sender: TObject);
var
  i    : Integer;
  aForm: TForm;
begin
  // Set Active Product to other pages
  LoadProductTypes;
  if (Pk > 0) then
  begin
    for i := 0 to pgData.PageCount - 1 do
    begin
      aForm := TForm(pgData.Pages[i].Tag);
      if (aForm <> nil) then
        if aForm.InheritsFrom(TfrmModel) then
          TfrmModel(aForm).Pk := Pk
        else
          TProdForm(aForm).PkProduct := Pk;
    end;
  end;
end;

function TTfrmProducts.SetNavButtons(const ANodeCount,
  ANodePos: Integer): Boolean;
begin
  Result          := (ANodeCount > 0);
  if (ANodePos = -1) then
  begin
    tbPrior.Enabled := False;
    tbNext.Enabled  := False;
  end
  else
  begin
    tbPrior.Enabled := ((ANodeCount > 0) and (ANodePos > 1));
    tbNext.Enabled  := (ANodeCount > ANodePos);
  end;
end;

procedure TTfrmProducts.ChangeStatePages(Sender: TObject; AScrMode: TDBMode);
begin
  if (AScrMode = dbmInsert) and (Pk > 0) then
    ScrState := dbmEdit;
end;

function TTfrmProducts.GetDscProd: string;
begin
  Result := eDsc_Prod.Text;
end;

function TTfrmProducts.GetFkGroup: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Grupos.ItemIndex;
  if (aIdx > -1) and (eFk_Grupos.Items.Objects[aIdx] <> nil) then
    Result := TGroup(eFk_Grupos.Items.Objects[aIdx]).PkGroup;
end;

function TTfrmProducts.GetFkSection: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Secoes.ItemIndex;
  if (aIdx > -1) and (eFk_Secoes.Items.Objects[aIdx] <> nil) then
    Result := TSection(eFk_Secoes.Items.Objects[aIdx]).PkSection;
end;

function TTfrmProducts.GetFkUnit: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Unidades.ItemIndex;
  if (aIdx > -1) and (eFk_Unidades.Items.Objects[aIdx] <> nil) then
    Result := TUnit(eFk_Unidades.Items.Objects[aIdx]).PkUnit;
end;

function TTfrmProducts.GetFlagAtv: Boolean;
begin
  Result := lFlag_Atv.Checked;
end;

function TTfrmProducts.GetQtdUni: Double;
begin
  Result := eQtd_Uni.Value;
end;

procedure TTfrmProducts.SetDscProd(const Value: string);
begin
  eDsc_Prod.Text := Value;
end;

procedure TTfrmProducts.SetFkUnit(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to eFk_Unidades.Items.Count - 1 do
    if (eFk_Unidades.Items.Objects[i] <> nil)  and
       (TUnit(eFk_Unidades.Items.Objects[i]).PkUnit = Value) then
    begin
      eFk_Unidades.ItemIndex := i;
      exit;
    end;
end;

procedure TTfrmProducts.SetFlagAtv(const Value: Boolean);
begin
  lFlag_Atv.Checked := Value;
end;

procedure TTfrmProducts.SetQtdUni(const Value: Double);
begin
  eQtd_Uni.Value := Value;
end;

function TTfrmProducts.GetFkSubGroup: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_SubGrupos.ItemIndex;
  if (aIdx > -1) and (eFk_SubGrupos.Items.Objects[aIdx] <> nil) then
    Result := TSubGroup(eFk_SubGrupos.Items.Objects[aIdx]).PkSubGroup;
end;

procedure TTfrmProducts.SetFkGroup(const Value: Integer);
begin

end;

procedure TTfrmProducts.SetFkSection(const Value: Integer);
begin

end;

procedure TTfrmProducts.SetFkSubGroup(const Value: Integer);
begin

end;

procedure TTfrmProducts.tbFindClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  vtSearch.NodeDataSize := SizeOf(TGridData);
//  tbFind.Enabled    := False;  Set tbFind to Found after to list items
  if vtSearch.RootNodeCount > 0 then
    ReleaseTreeNodes(vtSearch);
  with dmSysEstq do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlSearchProdutos0);
    vtSearch.BeginUpdate;
    Dados.StartTransaction;
    try
      qrSqlAux.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      qrSqlAux.ParamByName('FkTabelaPrecos').AsInteger := 1; // get default table from parametros_estq
      if (CodProd <> '') and (ProductCode <> pcPK) then
        qrSqlAux.SQL.Add(SqlAnd + 'Pcd.COD_REF = :CodRef ');
      qrSqlAux.SQL.Add(SqlSearchProdutos1);
      if (Pk > 0) and (ProductCode = pcPK) then
        qrSqlAux.SQL.Add(SqlAnd + 'Prd.PK_PRODUTOS = :PkProdutos ');
      if DscProd <> '' then
        qrSqlAux.SQL.Add(SqlAnd + 'Prd.DSC_PROD like :DscProd ');
      if FkSection > 0 then
        qrSqlAux.SQL.Add(SqlAnd + 'Prd.FK_SECOES = :FkSecoes ');
      if FkGroup > 0 then
        qrSqlAux.SQL.Add(SqlAnd + 'Prd.FK_GRUPOS = :FkGrupos ');
      if FkSubGroup > 0 then
        qrSqlAux.SQL.Add(SqlAnd + 'Prd.FK_SUBGRUPOS = :FkSubGrupos ');
      qrSqlAux.SQL.Add(SqlSearchProdutos2);
      if (qrSqlAux.Params.FindParam('FlagTCode')         <> nil) then
        if (CodProd = '') then
          qrSqlAux.ParamByName('FlagTCode').AsInteger := -1
        else
          qrSqlAux.ParamByName('FlagTCode').AsInteger := Integer(ProductCode);
      if (CodProd <> '') and (ProductCode <> pcPK)            and
         (qrSqlAux.Params.FindParam('CodRef') <> nil) then
        qrSqlAux.ParamByName('CodRef').AsString       := CodProd;
      if (qrSqlAux.Params.FindParam('FlagAtv')     <> nil) then
        qrSqlAux.ParamByName('FlagAtv').AsInteger     := Ord(FlagAtv);
      if (qrSqlAux.Params.FindParam('PkProdutos')  <> nil) then
        qrSqlAux.ParamByName('PkProdutos').AsInteger  := Pk;
      if (qrSqlAux.Params.FindParam('DscProd')     <> nil) then
        qrSqlAux.ParamByName('DscProd').AsString      := '%' + DscProd + '%';
      if (qrSqlAux.Params.FindParam('FkSecoes')    <> nil) then
        qrSqlAux.ParamByName('FkSecoes').AsInteger    := FkSection;
      if (qrSqlAux.Params.FindParam('FkGrupos')    <> nil) then
        qrSqlAux.ParamByName('FkGrupos').AsInteger    := FkGroup;
      if (qrSqlAux.Params.FindParam('FkSubGrupos') <> nil) then
        qrSqlAux.ParamByName('FkSubGrupos').AsInteger := FkSubGroup;
        if not qrSqlAux.Active then qrSqlAux.Open;
      if not qrSqlAux.IsEmpty then
      begin
        qrSqlAux.First;
        while not qrSqlAux.Eof do
        begin
          Node := vtSearch.AddChild(nil);
          if (Node <> nil) then
          begin
            Data          := vtSearch.GetNodeData(Node);
            if (Data <> nil) then
            begin
              Data^.Level   := vtSearch.GetNodeLevel(Node);
              Data^.Node    := Node;
              Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
            end;
          end;
          qrSqlAux.Next;
        end;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction;
      vtSearch.EndUpdate;
    end;
  end;
  if (vtSearch.RootNodeCount > 0) then
  begin
    Node := vtSearch.GetFirst;
    if Node <> nil then
    begin
      vtSearch.FocusedNode    := Node;
      vtSearch.Selected[Node] := True;
    end;
    Dados.DisplayHint(tbTools, Format('Encontrados %d registros',
      [vtSearch.RootNodeCount]));
  end
  else
    Dados.DisplayHint(tbTools, 'Nenhum registro encontrado');
end;

procedure TTfrmProducts.vtSearchEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TTfrmProducts.vtSearchDblClick(Sender: TObject);
var
  Node : PVirtualNode;
  Data : PGridData;
  aForm: TfrmModel;
begin
  if (Parent is TTabSheet) then
  begin
    Node := vtSearch.FocusedNode;
    if (Node = nil) then exit;
    Data := vtSearch.GetNodeData(Node);
    if (Data = nil) and (Data^.DataRow = nil) then exit;
    TTabSheet(Parent).PageControl.TabIndex := 1;
    if Assigned(TTabSheet(Parent).PageControl.OnChange) then
      TTabSheet(Parent).PageControl.OnChange(Self);
    aForm := TfrmModel(TTabSheet(Parent).PageControl.Pages[1].Tag);
    if (aForm = nil) then exit;
    if (Data.DataRow.FindField['PK_PRODUTOS'] <> nil) then
      Pk := Data.DataRow.FieldByName['PK_PRODUTOS'].AsInteger;
    aForm.Pk := Pk;
  end;
end;

procedure TTfrmProducts.vtSearchGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data     := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Column >= Data.DataRow.Count) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['PK_PRODUTOS'].AsString;
    1: CellText := Data^.DataRow.FieldByName['COD_REF'].AsString;
    2: CellText := Data^.DataRow.FieldByName['DSC_PROD'].AsString;
    3: CellText := FloatToStrF(Data^.DataRow.FieldByName['PRE_VDA'].AsFloat, ffNumber, 18, dados.DecimalPlaces);
    4: if (Data^.DataRow.FieldByName['DTA_UMOV'].AsDateTime > 0) then
         CellText := DateToStr(Data^.DataRow.FieldByName['DTA_UMOV'].AsDateTime)
       else
         CellText := '  /  /    ';
    5: if (Data^.DataRow.FieldByName['DTA_UMOV'].AsDateTime > 0) then
         CellText := DateToStr(Data^.DataRow.FieldByName['DTA_UCMP'].AsDateTime)
       else
         CellText := '  /  /    ';
    6: CellText := ' ';
  end;
end;

procedure TTfrmProducts.vtSearchBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  Data: PGridData;
begin
  if (Node = nil) or (Column in [0, 2]) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Column in [1, 3, 5]) then
    TargetCanvas.Brush.Color := clSkyBlue;
  if (Column = 4) then
    TargetCanvas.Brush.Color := clInfoBk;
  TargetCanvas.FillRect(CellRect);
  if (Column = 6) then
  begin
    vtSearch.Header.Columns[Column].Alignment := taCenter;
    Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 63);
    if Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger = 1 then
      Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 83);
  end;
end;

procedure TTfrmProducts.vtSearchFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) or (vtSearch.GetNodeLevel(Node) > 0) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data.DataRow = nil) then exit;
  Pk := Data.DataRow.FieldByName['PK_PRODUTOS'].AsInteger;
end;

function TTfrmProducts.GetCodProd: string;
begin
  Result := ePk_Produtos.Text;
end;

procedure TTfrmProducts.SetCodProd(const Value: string);
begin
  ePk_Produtos.Text := Value;
end;

function TTfrmProducts.GetProductCode: TCodeTypes;
var
  i: Integer;
begin
  Result := pcPK;
  for i := 0 to pmCodes.Items.Count - 1 do
    if (pmCodes.Items[i].Checked) then Result := TCodeTypes(i);
end;

initialization
  RegisterClass(TfrmProducts);
end.

