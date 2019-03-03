unit CadProd;

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
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  jpeg, ExtCtrls, VirtualTrees, ProcType, ComCtrls, ToolWin, Menus, CadModel,
  GridRow, Mask, TSysEstq, CurrEdit, TSysEstqAux, ProcUtils, Types, Buttons,
  ToolEdit, ExtDlgs;

type
  TProdFormClass = class of TfrmModel;

  TProductPage  = (ppMargin, ppSale, ppPurchase, ppServices, ppPatrimony,
                   ppParts, ppCost, ppTaxes, ppSuppliers);
  TProductPages = set of TProductPage;

  TfrmProducts = class(TForm)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbSepOper: TToolButton;
    tbPrior: TToolButton;
    tbNext: TToolButton;
    tbSepSave: TToolButton;
    tbSave: TToolButton;
    tbDelete: TToolButton;
    tbFound: TToolButton;
    tbSepFind: TToolButton;
    tbSepClose: TToolButton;
    tbClose: TToolButton;
    pgControl: TPageControl;
    tsData: TTabSheet;
    tsList: TTabSheet;
    pAllData: TPanel;
    pProduct: TPanel;
    lPk_Produtos: TStaticText;
    eFk_Unidades: TComboBox;
    lFk_Unidades: TStaticText;
    lFk_Produtos_Grupos: TStaticText;
    lDsc_Prod: TStaticText;
    eDsc_Prod: TEdit;
    vtProdType: TVirtualStringTree;
    lFlag_Atv: TCheckBox;
    lQtd_Uni: TStaticText;
    eQtd_Uni: TCurrencyEdit;
    pgData: TPageControl;
    pDataAux: TPanel;
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
    sbStatus: TStatusBar;
    tbFind: TToolButton;
    opImage: TOpenPictureDialog;
    eFk_Produtos_Grupos: TComboBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbPriorClick(Sender: TObject);
    procedure tbNextClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure vtProdTypeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtProdTypeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtProdTypeChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtProdTypeChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
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
    procedure tbCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure pgControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbFindClick(Sender: TObject);
    procedure tbFoundClick(Sender: TObject);
    procedure ChangeGlobal(Sender: TObject);
    procedure vtSearchCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vtSearchHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pmCodesItemClick(Sender: TObject);
    procedure iImgProdDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure eFk_UnidadesSelect(Sender: TObject);
    procedure eQtd_UniChange(Sender: TObject);
    procedure vtSearchAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure vtSearchIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure vtSearchStateChange(Sender: TBaseVirtualTree; Enter,
      Leave: TVirtualTreeStates);
    procedure eFk_Produtos_GruposDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure eFk_Produtos_GruposSelect(Sender: TObject);
  private
    { Private declarations }
    FActivePages   : TProductPages;
    FActivePrdType : TProductType;
    FActiveMatType : TMaterialType;
    FCompanyClick  : Boolean;
    FColumnIndex   : Integer;
    FFkProductGroup: Integer;
    FFkUnit        : Integer;
    FQtdUnit       : Double;
    FListLoaded    : Boolean;
    FLoading       : Boolean;
    FPk            : Integer;
    FProductTypes  : TProductTypes;
    FRect          : TRect;
    FScrState      : TDBMode;
    FSearchField   : string;
    FSearchText    : string;
    FPagesState    : TDBMode;
    FSearchForm    : TForm;
    FVisibleTypes: TProductTypes;
    procedure ClearDataPages;
    procedure ShowDataPages(APages: TProductPages; ACallLoadDefauls: Boolean = False);
    // Load Data from DB
    procedure LoadProductsGroups;
    procedure LoadUnits;
    procedure LoadProductTypes;
    procedure SetActivePrdType(AValue: TProductType);
    procedure SetActiveMatType(AValue: TMaterialType);
    procedure SetScreenFromVisibleTypes;
    procedure SetVisibleTypes(AValue: TProductTypes);
    procedure ModifyProduct_X_Type(ARow: TDataRow; AMode: TDBMode; APkType: Integer);
    function  ValidateOperation: Boolean;
    function  GetDscProd: string;
    function  GetFkProductGroup: Integer;
    function  GetFkUnit: Integer;
    function  GetFlagAtv: Boolean;
    function  GetQtdUni: Double;
    procedure SetDscProd(const Value: string);
    procedure SetFkUnit(const Value: Integer);
    procedure SetFlagAtv(const Value: Boolean);
    procedure SetQtdUni(const Value: Double);
    procedure SetFkProductGroup(const Value: Integer);
    function  GetCodProd: string;
    procedure SetCodProd(const Value: string);
    function  GetProductCode: TCodeTypes;
    procedure SetPk(const Value: Integer);
    procedure SetScrState(const Value: TDBMode);
    procedure GetListFields;
    procedure SetNavigationButtons;
    function  SetAllPagesState(const AState: TDBMode): Boolean;
    procedure SetScrollScreen;
    procedure ChangeSrcState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure UpdateList(AState: TDBMode);
    procedure UpdateProductTypes;
    procedure GetDataFromDB;
  protected
    { Protected declarations }
    procedure LoadDefaults;
    procedure MoveDataToControls;
    procedure ClearControls;
    procedure SaveIntoDB;
    procedure DeleteFromDB;
    property  ActivePrdType : TProductType  read FActivePrdType  write SetActivePrdType;
    property  ActiveMatType : TMaterialType read FActiveMatType  write SetActiveMatType;
    property  ListLoaded    : Boolean       read FListLoaded     write FListLoaded;
    property  Loading       : Boolean       read FLoading        write FLoading;
    property  VisibleTypes  : TProductTypes read FVisibleTypes   write SetVisibleTypes;
  public
    { Public declarations }
    property  CodProd       : string        read GetCodProd        write SetCodProd;
    property  DscProd       : string        read GetDscProd        write SetDscProd;
    property  QtdUni        : Double        read GetQtdUni         write SetQtdUni;
    property  FlagAtv       : Boolean       read GetFlagAtv        write SetFlagAtv;
    property  FkProductGroup: Integer       read GetFkProductGroup write SetFkProductGroup;
    property  FkUnit        : Integer       read GetFkUnit         write SetFkUnit;
    property  ProductCode   : TCodeTypes    read GetProductCode;
    property  Pk            : Integer       read FPk               write SetPk;
    property  ScrState      : TDBMode       read FScrState         write SetScrState;
  published
    { Published declarations }
    property  ProductTypes: TProductTypes read FProductTypes   write FProductTypes;
  end;

implementation

uses Dado, mSysEstq, Funcoes, EstqArqSql, FuncoesDB, Math, CadPrCode, CadPrdPrc,
  CadPrdMrg, CadPrdTax, CadPrdCst, CadPrdPrch, CadPrdSup, CadPrdSrv, CadPrdPart,
  CadPrdPatrm, TypInfo, SqlComm, SelEmpr, CmmConst, TSysFatAux;

  {$R *.dfm}

var
  ProductFormClass: array [TProductPage] of TProdFormClass =
    (TfmProdMargins, TfmProductSale, TfmPrdPurchase, TfrmPrdService,
     TfrmPrdPatrimony, TfrmPart, TfmPrdCost, TfmPrdTaxes, TfmPrdSuppliers);
  ProductPageTitle: array [TProductPage] of string         =
    ('Margens e Preços', 'Revenda', 'Compras', 'Serviços', 'Patrimônio',
     'Peças de Produção', 'Custos, Datas e Estoque Geral', 'Impostos',
     'Fornecedores');
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
  PAGES_OF_SERVICE  : TProductPages = [ppServices, ppMargin, ppTaxes, ppCost, ppSuppliers];
  PAGES_OF_PART     : TProductPages = [ppParts, ppCost, ppSuppliers, ppTaxes];
  PAGES_OF_PATRIMONY: TProductPages = [ppPatrimony, ppSuppliers, ppCost, ppTaxes];

procedure TfrmProducts.FormCreate(Sender: TObject);
begin
  FVisibleTypes               := [];
  FProductTypes               := [tiSale, tiPurchase, tiService, tiPart, tiPatrimony];
  vtSearch.Images             := Dados.Image16;
  vtSearch.Header.Images      := Dados.Image16;
  cbTools.Images              := Dados.Image16;
  tbTools.Images              := Dados.Image16;
  cbTools.Images              := Dados.Image16;
  vtProdType.Images           := Dados.Image16;
  vtProdType.Header.Images    := Dados.Image16;
  pgControl.Images            := Dados.Image16;
  vtProdType.NodeDataSize     := SizeOf(TGridData);
  vtSearch.NodeDataSize       := SizeOf(TGridData);
  pgData.Images               := Dados.Image16;
  ListLoaded                  := False;
  FPagesState                 := dbmBrowse;
  FSearchField                := 'DSC_PROD';
  FSearchText                 := '';
  LoadDefaults;
end;

procedure TfrmProducts.FormShow(Sender: TObject);
begin
  Caption := Application.Title + Dados.Parametros.soProgramTitle;
  fmProductCode               := TfmProductCode.Create(Self);
  fmProductCode.Parent        := pCodes;
  fmProductCode.Align         := alClient;
  fmProductCode.BorderStyle   := bsNone;
  fmProductCode.OnChangeState := ChangeSrcState;
  fmProductCode.Show;
  tbFound.Click;
end;

procedure TfrmProducts.FormDestroy(Sender: TObject);
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

procedure TfrmProducts.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  aKey: Word;
  aState: TDBMode;
begin
  if (FPagesState <> FScrState) and
     ((FPagesState in UPDATE_MODE) and (FScrState in SCROLL_MODE)) then
    aState := FPagesState
  else
    aState := FScrState;
  aKey := Key;
  if (Key = VK_ESCAPE) then Key := 0;
  case aKey of
    VK_ESCAPE: if (aState in UPDATE_MODE) and (tbCancel.Enabled) then
               begin
                 if (Dados.DisplayMessage('Há alterações no registro atual. ' +
                     'Deseja realmente cancelar?', hiWarning,
                     [mbNo, mbYes]) = mrYes) then
                   tbCancel.Click;
               end
               else
                 Close;
    VK_F3    :
      begin
        if tbFound.Enabled then
          tbFound.Click;
        if tbFind.Enabled then
          tbFind.Click;
      end;
    VK_F5    : if (Pk > 0) then Pk := FPk;
    VK_F12   : if tbSave.Enabled then tbSave.Click;
    VK_INSERT: if tbInsert.Enabled then tbInsert.Click;
    VK_DELETE: if tbDelete.Enabled then tbDelete.Click;
    VK_NEXT  : if (aState in SCROLL_MODE) and (tbNext.Enabled)  then tbNext.Click;
    VK_PRIOR : if (aState in SCROLL_MODE) and (tbPrior.Enabled) then tbPrior.Click;
  end;
end;

procedure TfrmProducts.ClearDataPages;
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

procedure TfrmProducts.LoadDefaults;
begin
  if not ListLoaded then
  begin
    LoadUnits;
    LoadProductsGroups;
    ListLoaded := True;
  end;
end;

procedure TfrmProducts.SetScreenFromVisibleTypes;
begin
  ClearDataPages;
  if (tiSale in FVisibleTypes) and (FActivePrdType = ptSale) then
    ShowDataPages(PAGES_OF_PRODUCT);
  if (tiPurchase in FVisibleTypes) then
    ShowDataPages(PAGES_OF_MATERIAL);
  if (tiService   in FVisibleTypes) then
    ShowDataPages(PAGES_OF_SERVICE);
  if (tiPart      in FVisibleTypes) then
    ShowDataPages(PAGES_OF_PART);
  if (tiPatrimony in FVisibleTypes) then
    ShowDataPages(PAGES_OF_PATRIMONY);
  if (FScrState = dbmInsert) then
    SetAllPagesState(dbmInsert);
end;

procedure TfrmProducts.ShowDataPages(APages: TProductPages;
            ACallLoadDefauls: Boolean = False);
var
  iX       : TProductPage;
  aForm    : TfrmModel;
  aTabSheet: TTabSheet;
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
        aForm        := TfrmModel(aTabSheet.Tag);
        if (aForm = nil) and (ProductFormClass[Ix] <> nil) then
        begin
          aForm               := ProductFormClass[Ix].Create(Self);
          aForm.Parent        := aTabSheet;
          aForm.Align         := alClient;
          aTabSheet.Tag       := LongInt(aForm);
          aForm.OnChangeState := ChangeSrcState;
          TfrmModel(aForm).Pk := Pk
        end;
        aForm.Show;
      end;
    end;
  end;
end;

procedure TfrmProducts.ClearControls;
begin
  if Loading then exit;
  Loading    := True;
  try
    Pk         := 0;
    CodProd    := '';
    DscProd    := '';
    FlagAtv    := True;
    if (vtSearch.RootNodeCount = 0) or (ScrState in SCROLL_MODE) then
    begin
      if Assigned(fmProductCode) then
        ReleaseTreeNodes(fmProductCode.vtCodes);
      QtdUni         := 1;
      FkProductGroup := 0;
      FkUnit         := 0;
    end
    else
    begin
      QtdUni          := FQtdUnit;
      FkProductGroup  := FFkProductGroup;
      FkUnit          := FFkUnit;
    end;
  finally
    Loading := False;
  end;
end;

procedure TfrmProducts.MoveDataToControls;
var
  aItem: TProducts;
  i    : Integer;
begin
  if (Pk = 0) then
  begin
    ClearControls;
    exit;
  end;
  Loading := True;
  try
    aItem      := dmSysEstq.GetProduct(Pk);
    CodProd    := IntToStr(Pk);
    DscProd    := aItem.DscProd;
    QtdUni     := aItem.QtdUni;
    FlagAtv    := aItem.FlagAtv;
    FkUnit     := aItem.FkUnit.PkUnit;
    FkProductGroup := aItem.FkProductGroup;
  //  Load Image of Service or Part
    i := 0;
    iImgProd.Picture.Graphic := nil;
    iImgProd.Picture.Assign(dmSysEstq.LoadProductImage(FPk, i));
    iImgProd.Tag := i;
  // Load tecnical description of Product or Part
    i := 0;
    eObs_Prod.Clear;
    eObs_Prod.Lines.Assign(dmSysEstq.LoadProductDescription(FPk, i));
    eObs_Prod.Tag := i;
  finally
    Loading := False;
  end;
end;

procedure TfrmProducts.LoadProductsGroups;
begin
  ReleaseCombos(eFk_Produtos_Grupos, toObject);
  eFk_Produtos_Grupos.Items.AddStrings(dmSysEstq.LoadProductGroups);
end;

procedure TfrmProducts.LoadUnits;
begin
  ReleaseCombos(eFk_Unidades, toObject);
  eFk_Unidades.Items.AddStrings(dmSysEstq.LoadUnits);
end;

procedure TfrmProducts.LoadProductTypes;
var
  Node: PVirtualNode;
  Data: PGridData;
  aControlTypes  : TProductTypes;
begin
  aControlTypes            := [];
  ReleaseTreeNodes(vtProdType);
  with dmSysEstq do
  begin
    if qrTipoProd.Active then qrTipoProd.Close;
    qrTipoProd.SQL.Clear;
    qrTipoProd.SQL.Add(SqlVinculoTProd);
    Dados.StartTransaction(qrTipoProd);
    try
      if (qrTipoProd.Params.FindParam('FkProdutos') <> nil) then
        qrTipoProd.ParamByName('FkProdutos').AsInteger := Pk;
      if not qrTipoProd.Active then qrTipoProd.Open;
      while not qrTipoProd.Eof do
      begin
        Node := vtProdType.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtProdType.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrTipoProd, True);
            with Data^.DataRow do
            begin
              if (FindField['FK_PRODUTOS'].AsInteger > 0) then
              begin
                case TTypeInsumos(FindField['FLAG_TPROD'].AsInteger) of
                  tiSale     : aControlTypes := aControlTypes + [tiSale];
                  tiPurchase : aControlTypes := aControlTypes + [tiPurchase];
                  tiService  : aControlTypes := aControlTypes + [tiService];
                  tiPart     : aControlTypes := aControlTypes + [tiPart];
                  tiPatrimony: aControlTypes := aControlTypes + [tiPatrimony];
                end;
              end;
            end;
          end;
        end;
        qrTipoProd.Next;
      end;
      if qrTipoProd.Active then qrTipoProd.Close;
      Dados.CommitTransaction(qrTipoProd);
    except on E:Exception do
      begin
        if qrTipoProd.Active then qrTipoProd.Close;
        Dados.RollbackTransaction(qrTipoProd);
        Dados.DisplayMessage('SaveIntoDB: Erro ao gravar os registros!' + NL +
          E.Message, hiError);
      end;
    end;
  end;
  VisibleTypes := aControlTypes;
end;

procedure TfrmProducts.SetActivePrdType(AValue: TProductType);
begin
  if FActivePrdType <> AValue then
    FActivePrdType  := AValue;
end;

procedure TfrmProducts.SetActiveMatType(AValue: TMaterialType);
begin
  if FActiveMatType <> AValue then
    FActiveMatType  := AValue;
end;

procedure TfrmProducts.tbPriorClick(Sender: TObject);
begin
  if (vtSearch.FocusedNode = nil) then exit;
  vtSearch.FocusedNode := vtSearch.GetPrevious(vtSearch.FocusedNode);
  vtSearch.Selected[vtSearch.FocusedNode] := True;
  SetNavigationButtons;
end;

procedure TfrmProducts.tbNextClick(Sender: TObject);
begin
  if (vtSearch.FocusedNode = nil) then exit;
  vtSearch.FocusedNode := vtSearch.GetNext(vtSearch.FocusedNode);
  vtSearch.Selected[vtSearch.FocusedNode] := True;
  SetNavigationButtons;
end;

procedure TfrmProducts.tbSaveClick(Sender: TObject);
begin
  ScrState := dbmPost;
  SetAllPagesState(dbmBrowse);
  ScrState := dbmBrowse;
end;

procedure TfrmProducts.SaveIntoDB;
var
  aItem : TProducts;
//  aTr   : Integer;
  aState: TDBMode;
begin
  Dados.StartTransaction(dmSysEstq.qrProduct);
  try
    if (ScrState in UPDATE_MODE) then
    begin
      aState                 := FScrState;
      aItem                  := TProducts.Create;
      try
        aItem.PkProducts     := Pk;
        aItem.DscProd        := eDsc_Prod.Text;
        aItem.FlagAtv        := lFlag_Atv.Checked;
        aItem.QtdUni         := eQtd_Uni.Value;
        aItem.FkProductGroup := FkProductGroup;
        aItem.FkUnit.PkUnit  := FkUnit;
        FFkUnit              := FkUnit;
        dmSysEstq.UpdateProduct(aItem, ScrState);
        if (FPk = 0) then
        begin
          FPk := aItem.PkProducts;
          ePk_Produtos.Text := IntToStr(FPk);
        end;
        UpdateProductTypes;
        if (iImgProd.Picture.Graphic <> nil) then
          dmSysEstq.UpdateProductImage(Pk, IImgProd.Picture.Graphic, aState);
        if (eObs_Prod.Lines.Count > 0) then
          dmSysEstq.UpdateProductObs(Pk, eObs_Prod.Lines, aState);
      finally
        FreeAndNil(aItem);
      end;
    end;
    SetAllPagesState(dbmPost);
    Dados.CommitTransaction(dmSysEstq.qrProduct);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(dmSysEstq.qrProduct);
      raise Exception.Create(E.Message);
    end;
  end;
  UpdateList(FScrState);
end;

procedure TfrmProducts.tbInsertClick(Sender: TObject);
begin
  if (ScrState in LOADING_MODE) then SetScrollScreen;
  Pk := 0;
  ScrState := dbmInsert;
  if Assigned(fmProductCode) then
    ReleaseTreeNodes(fmProductCode.vtCodes);
  if (pgControl.ActivePageIndex = 1) then
    pgControl.ActivePageIndex := 0;
end;

procedure TfrmProducts.tbCancelClick(Sender: TObject);
begin
  SetAllPagesState(dbmCancel);
  SetAllPagesState(dbmBrowse);
  ScrState := dbmCancel;
  ScrState := dbmBrowse;
  if (vtSearch.RootNodeCount > 0) then
    if (vtSearch.FocusedNode = nil) then
      vtSearch.FocusedNode := vtSearch.GetFirst
    else
      vtSearchFocusChanged(vtSearch, vtSearch.FocusedNode, 0);
end;

procedure TfrmProducts.tbDeleteClick(Sender: TObject);
begin
  ScrState := dbmDelete;
  ScrState := dbmBrowse;
end;

procedure TfrmProducts.vtProdTypeInitNode(Sender: TBaseVirtualTree;
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
  Node.CheckState := csUncheckedNormal;
  if (Data^.DataRow.FindField['FK_PRODUTOS'].AsInteger > 0) then
  begin
    Node.CheckState := csCheckedNormal;
{    case TTypeInsumos(Data^.DataRow.FindField['FLAG_TPROD'].AsInteger) of
      tiProduct  : if (tiProduct   in ProductTypes) then VisibleTypes := VisibleTypes + [tiProduct];
      tiMaterial : if (tiMaterial  in ProductTypes) then VisibleTypes := VisibleTypes + [tiMaterial];
      tiService  : if (tiService   in ProductTypes) then VisibleTypes := VisibleTypes + [tiService];
      tiPart     : if (tiPart      in ProductTypes) then VisibleTypes := VisibleTypes + [tiPart];
      tiPatrimony: if (tiPatrimony in ProductTypes) then VisibleTypes := VisibleTypes + [tiPatrimony];
    end;}
  end;
  if (not (aFlagTProd in ProductTypes)) then
    Node.States   := Node.States + [vsDisabled]
  else
    if (vsDisabled in Node.States) then
      Node.States := Node.States - [vsDisabled];
end;

procedure TfrmProducts.vtProdTypeGetText(Sender: TBaseVirtualTree;
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

procedure TfrmProducts.vtProdTypeChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  Data: PGridData;
  aFlagTProd: TTypeInsumos;
begin
  if (Node = nil) then exit;
  Data := vtProdType.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aFlagTProd := TTypeInsumos(Data^.DataRow.FieldByName['FLAG_TPROD'].AsInteger);
  Allowed := (aFlagTProd in ProductTypes);
end;

procedure TfrmProducts.vtProdTypeChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data      : PGridData;
  aFlagTProd: TTypeInsumos;
  aPk       : Integer;
begin
  if (Node = nil) then exit;
  Data := vtProdType.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aFlagTProd := TTypeInsumos(Data^.DataRow.FieldByName['FLAG_TPROD'].AsInteger);
  if (aFlagTProd in ProductTypes) then
  begin
    aPk := Data^.DataRow.FieldByName['PK_TIPO_PRODUTOS'].AsInteger;
    if (Node.CheckState = csCheckedNormal) then
    begin
      Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmInsert);
      if (aFlagTProd in FProductTypes) then
        VisibleTypes := FVisibleTypes + [aFlagTProd];
    end
    else
    begin
      Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmDelete);
      if ((aFlagTProd in FProductTypes)) then
        VisibleTypes := FVisibleTypes - [aFlagTProd];
    end;
    if (Pk > 0) then
      ModifyProduct_X_Type(Data^.DataRow,
        TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger), aPk)
    else
      ChangeGlobal(Self);
  end;
end;

procedure TfrmProducts.ModifyProduct_X_Type(ARow: TDataRow; AMode: TDBMode;
  APkType: Integer);
begin
  with dmSysEstq do
  begin
    if qrTipoProd.Active then qrTipoProd.Close;
    qrTipoProd.SQL.Clear;
    if (AMode = dbmInsert) then
      qrTipoProd.SQL.Add(SqlInsertProd_X_Type);
    if (AMode = dbmDelete) then
      qrTipoProd.SQL.Add(SqlDeleteProd_X_Type);
    try
      if qrTipoProd.Params.FindParam('FkTipoProdutos') <> nil then
        qrTipoProd.ParamByName('FkTipoProdutos').AsInteger := APkType;
      if qrTipoProd.Params.FindParam('FkProdutos') <> nil then
        qrTipoProd.ParamByName('FkProdutos').AsInteger := Pk;
      qrTipoProd.ExecSQL;
      ARow.FieldByName['STATUS'].AsInteger := Ord(dbmBrowse);
    except on E:Exception do
      begin
        raise Exception.Create('TfmEditProd: Erro na gravação do vínculo' + NL +
          E.Message);
      end;
    end;
  end;
end;

function TfrmProducts.ValidateOperation: Boolean;
begin
  Result := False;
  if (FkProductGroup <= 0) then
  begin
    Dados.DisplayHint(eFk_Produtos_Grupos, 'Deve selecionar uma Classificação para o produto');
    exit;
  end;
  if (FkUnit <= 0) then
  begin
    Dados.DisplayHint(eFk_Unidades, 'Deve selecionar uma unidade para o produto');
    exit;
  end;
  if (QtdUni <= 0) then
  begin
    Dados.DisplayHint(eQtd_Uni, 'Deve preencher o campo quantidade de uso para o produto');
    exit;
  end;
  with eFk_Unidades do
  begin
    if (QtdUni > 0) and (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) and
       (QtdUni - Trunc(QtdUni) > 0.0) and
       (not TUnit(Items.Objects[ItemIndex]).FlagFrac) then
    begin
      Dados.DisplayHint(eQtd_Uni, 'Este tipo de unidade só aceita números inteiros!');
      exit;
    end;
  end;
  if (DscProd = '') then
  begin
    Dados.DisplayHint(eDsc_Prod, 'Deve preencher o campo descrição para o produto');
    exit;
  end;
  Result := True;
end;

function TfrmProducts.GetDscProd: string;
begin
  Result := eDsc_Prod.Text;
end;

function TfrmProducts.GetFkProductGroup: Integer;
var
  aIdx: Integer;
begin
  with eFk_Produtos_Grupos do
  begin
    Result := 0;
    aIdx := ItemIndex;
    if (aIdx > -1) and (Items.Objects[aIdx] <> nil) then
      Result := TClassification(Items.Objects[aIdx]).Pk;
  end;
end;

function TfrmProducts.GetFkUnit: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Unidades.ItemIndex;
  if (aIdx > -1) and (eFk_Unidades.Items.Objects[aIdx] <> nil) then
    Result := TUnit(eFk_Unidades.Items.Objects[aIdx]).PkUnit;
end;

function TfrmProducts.GetFlagAtv: Boolean;
begin
  Result := lFlag_Atv.Checked;
end;

function TfrmProducts.GetQtdUni: Double;
begin
  Result := eQtd_Uni.Value;
end;

procedure TfrmProducts.SetDscProd(const Value: string);
begin
  eDsc_Prod.Text := Value;
end;

procedure TfrmProducts.SetFkUnit(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Unidades do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil)  and
         (TUnit(Items.Objects[i]).PkUnit = Value) then
      begin
        ItemIndex := i;
        exit;
      end;
  end;
end;

procedure TfrmProducts.SetFlagAtv(const Value: Boolean);
begin
  lFlag_Atv.Checked := Value;
end;

procedure TfrmProducts.SetQtdUni(const Value: Double);
begin
  eQtd_Uni.Value := Value;
end;

procedure TfrmProducts.SetFkProductGroup(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Produtos_Grupos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil)  and
         (TClassification(Items.Objects[i]).Pk = Value) then
      begin
        ItemIndex := i;
        exit;
      end;
  end;
end;

procedure TfrmProducts.vtSearchEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TfrmProducts.vtSearchDblClick(Sender: TObject);
begin
  if (vtSearch.FocusedNode <> nil) then
    pgControl.ActivePageIndex := 0;
end;

procedure TfrmProducts.vtSearchGetText(Sender: TBaseVirtualTree;
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
    4: if (Data^.DataRow.FieldByName['DTA_UCMP'].AsDateTime = 0) then
         CellText := '  /  /    '
       else
         CellText := FormatDateTime('dd/mm/yyyy', Data^.DataRow.FieldByName['DTA_UCMP'].AsDateTime);
    5: if (Data^.DataRow.FieldByName['DTA_UMOV'].AsDateTime = 0) then
         CellText := '  /  /    '
       else
         CellText := FormatDateTime('dd/mm/yyyy', Data^.DataRow.FieldByName['DTA_UMOV'].AsDateTime);
    6: CellText := ' ';
  end;
end;

procedure TfrmProducts.vtSearchBeforeCellPaint(Sender: TBaseVirtualTree;
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

procedure TfrmProducts.vtSearchFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) or (vtSearch.GetNodeLevel(Node) > 0) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data.DataRow = nil) then exit;
  Pk := Data.DataRow.FieldByName['PK_PRODUTOS'].AsInteger;
  SetNavigationButtons;
end;

procedure TfrmProducts.vtSearchCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data: PGridData;
  Str1, Str2, aFn: string;
  function GetStringValue(Node: PVirtualNode): string;
  begin
    Result := '';
    if (Node = nil) then exit;
    Data := Sender.GetNodeData(Node);
    if (Data = nil) and (Data^.DataRow = nil) then exit;
    case TVirtualStringTree(Sender).Header.SortColumn of
      0: aFn := 'PK_PRODUTOS';
      1: aFn := 'COD_REF';
      2: aFn := 'DSC_PROD';
      3: aFn := 'PRE_VDA';
      4: aFn := 'DTA_UCMP';
      5: aFn := 'DTA_UMOV';
      6: aFn := 'FLAG_ATV';
    end;
    with Data^.DataRow do
    begin
      if (TVirtualStringTree(Sender).Header.SortColumn = 0) then
        Result := InsereZer(IntToStr(FieldByName[aFn].AsInteger), 20);
      if (TVirtualStringTree(Sender).Header.SortColumn in [1, 2]) then
        Result := FieldByName[aFn].AsString;
      if (TVirtualStringTree(Sender).Header.SortColumn = 3) then
        Result := InsereZer(FloatToStrF(FieldByName[aFn].AsFloat,
                 ffNumber, 18, Dados.DecimalPlaces), 20);
      if (TVirtualStringTree(Sender).Header.SortColumn in [4, 5]) then
        Result := FormatDateTime('yyyy/mm/dd', FieldByName[aFn].AsDateTime);
    end;
  end;
begin
  if (Node1 = nil) or (Node2 = nil) or
    (Column <> TVirtualStringTree(Sender).Header.SortColumn) then exit;
  Str1 := GetStringValue(Node1);
  Str2 := GetStringValue(Node2);
  case TVirtualStringTree(Sender).Header.SortDirection of
    sdAscending : Result := CompareText(Str1, Str2);
    sdDescending: Result := CompareText(Str1, Str2);
  end;
end;

procedure TfrmProducts.vtSearchHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
// Select the column to search on grid
  if (Column < 0) or (Column > 5) then exit;
  FColumnIndex := Column;
  case FColumnIndex of
    0: FSearchField := 'PK_PRODUTOS';
    1: FSearchField := 'COD_REF';
    2: FSearchField := 'DSC_PROD';
    3: FSearchField := 'PRE_VDA';
    4: FSearchField := 'DTA_UCMP';
    5: FSearchField := 'DTA_UMOV';
  end;
  if Sender.SortColumn = FColumnIndex then
    if Sender.SortDirection = sdAscending then
      Sender.SortDirection := sdDescending
    else
      Sender.SortDirection := sdAscending
  else
    Sender.SortDirection := sdAscending;
  Sender.SortColumn := FColumnIndex;
  vtSearch.SortTree(Sender.SortColumn, Sender.SortDirection);
  SetNavigationButtons;
end;

function TfrmProducts.GetCodProd: string;
begin
  Result := ePk_Produtos.Text;
end;

procedure TfrmProducts.SetCodProd(const Value: string);
begin
  ePk_Produtos.Text := Value;
end;

function TfrmProducts.GetProductCode: TCodeTypes;
var
  i: Integer;
begin
  Result := pcPK;
  for i := 0 to pmCodes.Items.Count - 1 do
    if (pmCodes.Items[i].Checked) then Result := TCodeTypes(i);
end;

procedure TfrmProducts.SetPk(const Value: Integer);
var
  i    : Integer;
  aForm: TForm;
begin
//  Set Active Product
  FPk := Value;
  if (FScrState in SCROLL_MODE) then
  begin
    if (not Loading) then
      MoveDataToControls;
  //  Load ProductTypes
    if (FPk > 0) or (vtProdType.RootNodeCount = 0) then
      LoadProductTypes;
  end;
  fmProductCode.Pk := FPk;
  fmProductCode.FkProductGroup := FkProductGroup;
  for i := 0 to pgData.PageCount - 1 do
  begin
    aForm := TForm(pgData.Pages[i].Tag);
    if (aForm <> nil) then
      TfrmModel(aForm).Pk := Pk
  end;
end;

procedure TfrmProducts.SetScrState(const Value: TDBMode);
begin
  if (FScrState <> Value) then
  begin
    if (Value = dbmPost) then
      if (not ValidateOperation) then
        Abort
      else
        if (not SetAllPagesState(dbmCheck)) then  // I can't save the product before check all updated pages
          Abort
        else
    else
      FScrState := Value;
    case Value of
      dbmFind   : ChangeControlColors(Self, clInfoBk, clGreen);
      dbmExecute: GetListFields;
      dbmInsert : ClearControls;
      dbmDelete : DeleteFromDB;
      dbmPost   : SaveIntoDB;
      dbmCancel : MoveDataToControls;
      dbmBrowse : MoveDataToControls;
    end;
    if (FScrState <> Value) then
      FScrState := Value;
  end;
  ChangeSrcState(Self, FScrState);
end;

procedure TfrmProducts.ChangeSrcState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
var
  _State: TDBMode;
begin
  if (Sender <> Self) then
  begin
    if (AState = dbmInsert) and (Pk > 0) then
      AState := dbmEdit;
    FPagesState := AState;
  end;
  if (FPagesState <> FScrState) and
     ((FPagesState in UPDATE_MODE) and (FScrState in SCROLL_MODE)) then
    _State := FPagesState
  else
    _State := FScrState;
{  ShowMessage('Sender ==> ' + TControl(Sender).Name + NL +
              'SenderState  ==> ' + ModeTypes[AScrState] + NL +
              'LocalState  ==> ' + ModeTypes[aState] + NL +
              'PagesState ==> ' + ModeTypes[FPagesState] + NL +
              'ScreenState ==> ' + ModeTypes[FScrState]);}
  tbCancel.Enabled := (_State in UPDATE_MODE);
  tbSave.Enabled   := (_State in UPDATE_MODE);
  tbDelete.Enabled := (_State in SCROLL_MODE) and (vtSearch.RootNodeCount > 0);
  tbFound.Enabled  := (_State in SCROLL_MODE);
  tbFind.Enabled   := (_State in LOADING_MODE);
  tbClose.Enabled  := (_State in SCROLL_MODE) or (_State in LOADING_MODE);
  tbInsert.Enabled := (_State in SCROLL_MODE) or (_State in LOADING_MODE);
  SetNavigationButtons;
  sbStatus.Repaint;
end;

function  TfrmProducts.SetAllPagesState(const AState: TDBMode): Boolean;
var
  i: Integer;
  aForm: TfrmModel;
begin
  Result := True;
  FPagesState := AState;
  if (ScrState in SCROLL_MODE) then
  begin
    if (fmProductCode.Pk = 0) then fmProductCode.Pk := Pk;
  end
  else
    fmProductCode.PkProduct := Pk;
  if (fmProductCode.ScrState <> AState) then
  begin
    fmProductCode.ScrState := AState;
    if (AState = dbmCheck) and (not fmProductCode.CheckRecord) then
     begin
      Result := False;
      exit;
    end;
  end;
  for i := 0 to pgData.PageCount - 1 do
  begin
    aForm := TfrmModel(pgData.Pages[i].Tag);
    if (aForm <> nil) then
    begin
      if (ScrState in SCROLL_MODE) then
      begin
        if (aForm.Pk = 0) then aForm.Pk := Pk;
      end
      else
        aForm.PkAux := Pk;
      if (aForm.ScrState <> AState) then
      begin
        aForm.ScrState := AState;
        if (AState = dbmCheck) and (not aForm.CheckRecord) then
        begin
          pgData.ActivePageIndex := i;
          Result := False;
          break;
        end;
      end;
    end;
  end;
end;

procedure TfrmProducts.SetNavigationButtons;
begin
  tbNext.Enabled  := (FScrState in SCROLL_MODE) and (vtSearch.RootNodeCount > 0) and
                     (vtSearch.FocusedNode <> vtSearch.GetLast);
  tbPrior.Enabled := (FScrState in SCROLL_MODE) and (vtSearch.RootNodeCount > 0) and
                     (vtSearch.FocusedNode <> vtSearch.GetFirst);
end;

procedure TfrmProducts.GetListFields;
var
  Node: PVirtualNode;
  Data: PGridData;
  aIn : Boolean;
begin
  if vtSearch.RootNodeCount > 0 then
    ReleaseTreeNodes(vtSearch);
  with dmSysEstq do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlSearchProdutos0);
    vtSearch.BeginUpdate;
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      qrSqlAux.ParamByName('FkTabelaPrecos').AsInteger := 1; // get default table from parametros_estq
      if (ProductCode <> pcPK) and (CodProd <> '') then
        qrSqlAux.SQL.Add(SqlAnd + 'Pcd.COD_REF = :CodRef ');
      qrSqlAux.SQL.Add(SqlSearchProdutos1);
      if (ProductCode = pcPK) and (CodProd <> '') then
        qrSqlAux.SQL.Add(SqlAnd + 'Prd.PK_PRODUTOS = :PkProdutos ');
      if (DscProd <> '') then
        qrSqlAux.SQL.Add(SqlAnd + 'Prd.DSC_PROD like :DscProd ');
      if (FkProductGroup > 0) then
      begin
        with eFk_Produtos_Grupos do
        begin
          if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
            aIn := TClassification(Items.Objects[ItemIndex]).FlagAnlSnt
          else
            aIn := True;
        end;
        if (not aIn) then
          qrSqlAux.SQL.Add(SqlAnd + 'FK_PRODUTOS_GRUPOS in ( ' +
            'select R_PK_PRODUTOS_GRUPOS ' + NL +
            '  from STP_GET_CHILD_PRODUCTS_GROUPS(:FkProdutosGrupos))')
        else
          qrSqlAux.SQL.Add(SqlAnd + 'Prd.FK_PRODUTOS_GRUPOS = :FkProdutosGrupos ');
      end;
      qrSqlAux.SQL.Add(SqlSearchProdutos2);
      if (qrSqlAux.Params.FindParam('FlagTCode') <> nil) then
        if (CodProd = '') then
          qrSqlAux.ParamByName('FlagTCode').AsInteger := -1
        else
          qrSqlAux.ParamByName('FlagTCode').AsInteger := Integer(ProductCode);
      if (CodProd <> '') and (ProductCode <> pcPK) and
         (qrSqlAux.Params.FindParam('CodRef') <> nil) then
        qrSqlAux.ParamByName('CodRef').AsString       := CodProd;
      if (qrSqlAux.Params.FindParam('FlagAtv')     <> nil) then
        qrSqlAux.ParamByName('FlagAtv').AsInteger     := Ord(FlagAtv);
      if (qrSqlAux.Params.FindParam('PkProdutos')  <> nil) then
        qrSqlAux.ParamByName('PkProdutos').AsInteger  := StrToInt(CodProd);
      if (qrSqlAux.Params.FindParam('DscProd')     <> nil) then
        qrSqlAux.ParamByName('DscProd').AsString      := '%' + DscProd + '%';
      if (qrSqlAux.Params.FindParam('FkProdutosGrupos')    <> nil) then
        qrSqlAux.ParamByName('FkprodutosGrupos').AsInteger := FkProductGroup;
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
      Dados.CommitTransaction(qrSqlAux);
      vtSearch.EndUpdate;
    end;
  end;
  if (vtSearch.RootNodeCount > 0) then
  begin
    pgControl.ActivePageIndex := 1;
    Node := vtSearch.GetFirst;
    if Node <> nil then
    begin
      vtSearch.FocusedNode    := Node;
      vtSearch.Selected[Node] := True;
    end;
    vtSearch.Header.SortColumn := 2;
    Dados.DisplayHint(tbTools, Format('Encontrados %d registros',
      [vtSearch.RootNodeCount]));
    SetNavigationButtons;
  end
  else
    Dados.DisplayHint(tbTools, 'Nenhum registro encontrado');
end;

procedure TfrmProducts.ChangeGlobal(Sender: TObject);
begin
  if (Loading) or (FScrState in LOADING_MODE) or (ScrState in UPDATE_MODE) then exit;
  if (Pk > 0) then
    ScrState := dbmEdit
  else
  begin
    Loading  := True;
    Pk       := 0;
    ScrState := dbmInsert;
    Loading  := False;
  end;
end;

procedure TfrmProducts.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProducts.pgControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (FScrState in SCROLL_MODE) and (vtSearch.RootNodeCount > 0);
end;

procedure TfrmProducts.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    FCompanyClick := False;
    SelEmpresa.Free;
    SelEmpresa := nil;
  end;
  sbStatus.Repaint;
end;

procedure TfrmProducts.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
  aState: TDBMode;
begin
  if (not (Panel.Index in [1, 2])) then exit;
  if (FPagesState <> FScrState) and
     ((FPagesState in UPDATE_MODE) and (FScrState in SCROLL_MODE)) then
    aState := FPagesState
  else
    aState := FScrState;
  StatusBar.Canvas.Brush.Color := clBtnFace;
  StatusBar.Canvas.Font.Style  := [fsBold];
  StatusBar.Canvas.Font.Name := 'Arial';
  StatusBar.Canvas.FillRect(Rect);
  if (Panel.Index = 1) then
  begin
    FRect := Rect;
    StatusBar.Canvas.Font.Color := ClNavy;
    Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
    StatusBar.Canvas.TextOut(Rect.Left + 22, Rect.Top + 1,'Empresa: ' +
      IntToStr(Dados.PkCompany) + ' / ' + Dados.NameCompany);
  end;
  if Panel.Index = 2 then
  begin
    StatusBar.Canvas.Font.Color  := FontColorMode[aState];
    StatusBar.Canvas.Brush.Color :=     ColorMode[aState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[aState]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[aState]);
  end;
end;

procedure TfrmProducts.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TfrmProducts.tbFindClick(Sender: TObject);
var
  aCode: Integer;
begin
  if (ProductCode = pcPK) and (CodProd <> '') then
  begin
    aCode := StrToIntDef(CodProd, 0);
    if (aCode = 0) then
    begin
      Dados.DisplayMessage('Erro: Código do Produto deve ser um valor numérico positivo > 0',
        hiError);
      exit;
    end;
  end;
  ScrState                := dbmExecute;
  SetScrollScreen;
end;

procedure TFrmProducts.SetScrollScreen;
begin
  ChangeControlColors(Self, clWindow, clWindowText);
  lPk_Produtos.Enabled    := False;
  ePk_Produtos.Enabled    := False;
  pDataAux.Enabled        := True;
  vtProdType.Enabled      := True;
  ClearControls;
  ScrState := dbmBrowse;
end;

procedure TfrmProducts.tbFoundClick(Sender: TObject);
begin
  Dados.DisplayHint(ePk_Produtos, 'Clique com o botão direito aqui para ' + NL +
    'selecionar o tipo de código a pesquisar');
  pgControl.ActivePageIndex := 0;
  pDataAux.Enabled          := False;
  vtProdType.Enabled        := False;
  lPk_Produtos.Enabled      := True;
  ePk_Produtos.Enabled      := True;
  ClearDataPages;
  ClearControls;
  ReleaseTreeNodes(vtSearch);
  ScrState                  := dbmFind;
end;

procedure TfrmProducts.SetVisibleTypes(AValue: TProductTypes);
begin
  if (AValue <> FVisibleTypes) then
  begin
    FVisibleTypes := AValue;
    SetScreenFromVisibleTypes;
  end;
end;

procedure TfrmProducts.pmCodesItemClick(Sender: TObject);
begin
  pmBarCode.Checked   := False;
  pmPk.Checked        := False;
  pmReference.Checked := False;
  pmSupplier.Checked  := False;
  TMenuItem(Sender).Checked := True;
end;

procedure TfrmProducts.iImgProdDblClick(Sender: TObject);
begin
  if opImage.Execute then
  begin
    iImgProd.Picture.LoadFromFile(opImage.FileName);
    if (not Loading) and (ScrState in SCROLL_MODE) then
    begin
      if (Pk > 0) then
        ScrState := dbmEdit
      else
        ScrState := dbmInsert;
    end;
  end;
end;

procedure TfrmProducts.UpdateList(AState: TDBMode);
var
  Node: PVirtualNode;
  Data: PGridData;
  procedure DeleteNode;
  begin
    vtSearch.BeginUpdate;
    try
      Data := vtSearch.GetNodeData(Node);
      if (vtSearch.GetNext(Node) <> nil) then
        vtSearch.FocusedNode := vtSearch.GetNext(Node)
      else
        if (vtSearch.GetPrevious(Node) <> nil) then
          vtSearch.FocusedNode := vtSearch.GetNext(Node)
        else
        begin
          VisibleTypes := [];
          ClearControls;
        end;
      if (Data <> nil) then
      begin
        Data^.Level   := 0;
        Data^.Node    := nil;
        if (Data^.DataRow <> nil) then
          Data^.DataRow.Free;
        Data^.DataRow := nil;
      end;
      vtSearch.DeleteNode(Node);
    finally
      vtSearch.EndUpdate;
    end;
  end;
begin
  Node := vtSearch.FocusedNode;
  if (Node <> nil) and (ScrState = dbmDelete) then
    DeleteNode
  else
    GetDataFromDB;
end;

procedure TfrmProducts.GetDataFromDB;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := nil;
  with dmSysEstq do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlSearchProdutos0);
    qrSqlAux.SQL.Add(SqlSearchProdutos1);
    qrSqlAux.SQL.Add(SqlAnd + 'Prd.PK_PRODUTOS = :PkProdutos ');
    vtSearch.BeginUpdate;
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
      qrSqlAux.ParamByName('FkTabelaPrecos').AsInteger := 1; // get default table from parametros_estq
      qrSqlAux.ParamByName('PkProdutos').AsInteger     := Pk;
      qrSqlAux.ParamByName('FlagTCode').AsInteger      := Integer(ProductCode); // get active code of first search
      qrSqlAux.ParamByName('FlagAtv').AsInteger        := Ord(FlagAtv); // get data as field seted
      if not qrSqlAux.Active then qrSqlAux.Open;
      if not qrSqlAux.IsEmpty then
      begin
        Node := vtSearch.FocusedNode;
        if (Node = nil) or (ScrState = dbmInsert) then
          Node := vtSearch.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtSearch.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := vtSearch.GetNodeLevel(Node);
            Data^.Node    := Node;
            if (Data^.DataRow <> nil) then
            begin
              Data^.DataRow.Free;
              Data^.DataRow := nil;
            end;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
          end;
        end;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
      vtSearch.EndUpdate;
    end;
  end;
  if (Node <> nil) then
  begin
    vtSearch.FocusedNode    := Node;
    vtSearch.Selected[Node] := True;
  end;
end;

procedure TfrmProducts.UpdateProductTypes;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  vtProdType.BeginUpdate;
  try
    Node := vtProdType.GetFirst;
    while (Node <> nil) do
    begin
      Data := vtProdType.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in UPDATE_MODE) then
        ModifyProduct_X_Type(Data^.DataRow,
          TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger),
          Data^.DataRow.FieldByName['PK_TIPO_PRODUTOS'].AsInteger);
      Node := vtProdType.GetNext(Node);
    end;
  finally
    vtProdType.EndUpdate;
  end;
end;

procedure TfrmProducts.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (ScrState in UPDATE_MODE) then
    if (Dados.DisplayMessage('Há alterações não salvas. Deseja sair e  ' +
          'abandonar as alterações?', hiQuestion, [mbYes, mbNo]) = mrNo) then
      Action := caNone;
end;

procedure TfrmProducts.DeleteFromDB;
begin
  if (Dados.DisplayMessage('Deseja Realmente excluir este registro?', hiWarning,
       [mbYes, mbNo]) = mrYes) then
    dmSysEstq.DeleteProduct(Pk);
  UpdateList(dbmDelete);
  SetAllPagesState(dbmBrowse);
  ScrState := dbmBrowse
end;

procedure TfrmProducts.eFk_UnidadesSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  FFkUnit := FkUnit;
end;

procedure TfrmProducts.eQtd_UniChange(Sender: TObject);
begin
  ChangeGlobal(Sender);
  FQtdUnit := QtdUni;
end;

procedure TfrmProducts.vtSearchAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  Data: PGridData;
begin
  if (Node = nil) or (Column in [0, 2]) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Column = 6) then
  begin
    vtSearch.Header.Columns[Column].Alignment := taCenter;
    Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 63);
    if Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger = 1 then
      Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 83);
  end;
end;

procedure TfrmProducts.vtSearchIncrementalSearch(Sender: TBaseVirtualTree;
  Node: PVirtualNode; const SearchText: WideString; var Result: Integer);
var
  Data: PgridData;
  S, F: string;
  aLen: Integer;
begin
  if (Node = nil) or (FSearchField = '') then exit;
  if (Sender.GetNodeLevel(Node) > 0) then
  begin
    Result := 1;
    exit;
  end;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Data^.DataRow.FindField[FSearchField] = nil) then
    exit;
  F := Data^.DataRow.FieldByName[FSearchField].AsString;
  S := SearchText;
  sbStatus.Panels[0].Text := 'Pesquisando por: ' + S;
  if (Length(F) < Length(S)) then
    aLen := Length(S)
  else
    aLen := Min(Length(S), Length(F));
  Result := StrLIComp(PAnsiChar(S), PAnsiChar(F), aLen);
  FSearchText := Copy(F, 1, Length(S));
end;

procedure TfrmProducts.vtSearchStateChange(Sender: TBaseVirtualTree; Enter,
  Leave: TVirtualTreeStates);
var
  aCol, X, Y: Integer;
  aRect: TRect;
begin
  if (tsIncrementalSearching in Leave) then
  begin
    sbStatus.Panels[0].Text := 'Mensagem:';
    aCol := -1;
    if (FSearchField = 'PK_PRODUTOS') then
      aCol := 0
    else
      if (FSearchField = 'COD_REF') then
        aCol := 1
      else
        if (FSearchField = 'DSC_PROD') then
          aCol := 2
        else
          if (FSearchField = 'PRE_VDA') then
            aCol := 3
          else
            if (FSearchField = 'DTA_UCMP') then
              aCol := 4
            else
              if (FSearchField = 'DTA_UMOV') then
                aCol := 5;
    if (Sender.FocusedNode = nil) or (aCol = -1) then exit;
    aRect := vtSearch.GetDisplayRect(Sender.FocusedNode, aCol, True);
    vtSearch.Canvas.Font.Color  := clWindowText;
    vtSearch.Canvas.Brush.Color := $0066B3FF;
    aRect.Right  := (aRect.Left + Canvas.TextWidth(UpperCase(FSearchText)) -2);
    aRect.Top    := aRect.Top + 2;
    aRect.Bottom := aRect.Bottom - 3;
    X            := aRect.Left;
    Y            := aRect.Top;
    aRect.Left   := aRect.Left + 4;
    vtSearch.Canvas.FillRect(aRect);
    vtSearch.Canvas.Font.Color := clWhite;
    vtSearch.Canvas.TextOut(X + 4, Y, UpperCase(FSearchText));
    FSearchText := '';
  end;
end;

procedure TfrmProducts.eFk_Produtos_GruposDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aClass : TClassification;
  aColor : TColor;
  aOffSet: Integer;
  aStr   ,
  aItmStr: string;
begin
  if (Index > TComboBox(Control).Items.Count) or
     (TComboBox(Control).Items.Objects[Index] = nil) or
     (not (TComboBox(Control).Items.Objects[Index] is TClassification)) then
  begin
    TComboBox(Control).Canvas.TextOut(Rect.Left, Rect.Top,
      TComboBox(Control).Items.Strings[Index]);
    TComboBox(Control).Canvas.Brush.Style := bsClear;
    TComboBox(Control).Canvas.DrawFocusRect(Rect);
    TComboBox(Control).Canvas.FrameRect(Rect);
    exit;
  end;
  aClass  := TClassification(TComboBox(Control).Items.Objects[Index]);
  aColor  := clGray;
  aOffSet := aClass.NivCta * 10;
  if aClass.FlagAnlSnt then
    aColor  := clWindowText;
  with (Control as TComboBox).Canvas do
  begin
    if (odSelected in State) then
      Font.Color := clWhite
    else
      Font.Color := aColor;
    aStr       := TComboBox(Control).Items.Strings[Index];
    aItmStr    := Copy(aStr, 1, Pos('|', aStr) - 1);
    Delete(aStr, 1, Pos('|', aStr));
    if ((TextWidth(Trim(aItmStr)) + Rect.Left + aOffSet) > (Rect.Left + 200)) then
    begin
      while ((TextWidth(Trim(aItmStr) + '...') + Rect.Left + aOffSet) > (Rect.Left + 200)) do
        Delete(aItmStr, Length(aItmStr), 1);
      aItmStr := aItmStr + '...'
    end;
    TextOut(Rect.Left + aOffSet, Rect.Top + 1, aItmStr);
    TextOut(Rect.Left + 200, Rect.Top + 1, aStr);
    if (odSelected in State) or
       (odFocused  in State) or
       (odHotLight in State) then
    begin
      TComboBox(Control).Canvas.Brush.Style := bsClear;
      TComboBox(Control).Canvas.DrawFocusRect(Rect);
      TComboBox(Control).Canvas.FrameRect(Rect);
    end;
  end;
end;

procedure TfrmProducts.eFk_Produtos_GruposSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if Assigned(fmProductCode) and (ScrState in SCROLL_MODE + UPDATE_MODE) then
    fmProductCode.FkProductGroup := FkProductGroup;
end;

initialization
  RegisterClass(TfrmProducts);
end.

