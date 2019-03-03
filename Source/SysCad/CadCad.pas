unit CadCad;

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

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, VirtualTrees, Buttons, ExtCtrls, TSysMan, jpeg, ProcType,
  CadModel, ProcUtils, TSysCad, TSysCadAux, StdCtrls, ToolWin, GridRow, Mask,
  Types, ExtDlgs, Menus, ToolEdit, CurrEdit, PrcCombo, mSysCad;

type
  TOwnerFormClass = class of TfrmModel;

  TSavedFields = packed record
    FlagTCad: TTypeOwner;
    TrtCnt  : string[20];
    Country : Integer;
    State   : string[2];
    City    : Integer;
  end;

  TTypeTree = (ttPhone, ttEvent, ttInternet);

  TfrmOwners = class(TForm)
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
    tsList: TTabSheet;
    sbStatus: TStatusBar;
    tbFind: TToolButton;
    opImage: TOpenPictureDialog;
    tsData: TTabSheet;
    pgCategory: TPageControl;
    pOwnerData: TPanel;
    eCrg_Cad: TEdit;
    lCrg_Cad: TStaticText;
    lFk_Contatos: TStaticText;
    lRaz_Soc: TStaticText;
    eRaz_Soc: TEdit;
    lFk_Tipo_Alias: TStaticText;
    eDoc_Sec: TMaskEdit;
    lDoc_Sec: TStaticText;
    eDoc_Pri: TMaskEdit;
    lDoc_Pri: TStaticText;
    eTrt_Cnt: TEdit;
    lTrt_Cnt: TStaticText;
    eFk_Tipo_Alias: TComboBox;
    pgComplement: TPageControl;
    tsAddress: TTabSheet;
    lFk_Paises: TStaticText;
    eFk_Paises: TPrcComboBox;
    lFk_Estados: TStaticText;
    eFk_Estados: TPrcComboBox;
    eFk_Municipios: TPrcComboBox;
    lFk_Municipios: TStaticText;
    lEnd_Cad: TStaticText;
    eEnd_Cad: TEdit;
    eNum_End: TCurrencyEdit;
    lNum_End: TStaticText;
    lCmp_End: TStaticText;
    eCmp_End: TEdit;
    eCxp_Cad: TEdit;
    lCxp_Cad: TStaticText;
    lCep_Cad: TStaticText;
    eCep_Cad: TCurrencyEdit;
    tsObservations: TTabSheet;
    eObs_Cad: TMemo;
    pgContactData: TPageControl;
    tsCategories: TTabSheet;
    vtCategory: TVirtualStringTree;
    tsPhones: TTabSheet;
    tsInternet: TTabSheet;
    vtSearch: TVirtualStringTree;
    iImg_Cad: TImage;
    eFlag_TCad: TComboBox;
    StaticText1: TStaticText;
    vtInternet: TVirtualStringTree;
    tsEvents: TTabSheet;
    vtEvents: TVirtualStringTree;
    vtPhones: TVirtualStringTree;
    tsContactList: TTabSheet;
    vtPhoneList: TVirtualStringTree;
    Shape1: TShape;
    lObs_Cad: TLabel;
    lImg_Cad: TLabel;
    Shape2: TShape;
    eFk_Contatos: TPrcComboBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbPriorClick(Sender: TObject);
    procedure tbNextClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure vtSearchEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vtSearchDblClick(Sender: TObject);
    procedure vtSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
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
    procedure iImgCadDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vtSearchFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtSearchPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtSearchIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure vtSearchStateChange(Sender: TBaseVirtualTree; Enter,
      Leave: TVirtualTreeStates);
    procedure vtCategoryChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtCategoryGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtCategoryInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtPhonesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtPhonesInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtPhonesChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtEventsChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtEventsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtEventsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtEventsNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure vtInternetChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtInternetGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtInternetInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtPhoneListGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure eFlag_TCadSelect(Sender: TObject);
    procedure eFk_PaisesSelect(Sender: TObject);
    procedure eFk_EstadosSelect(Sender: TObject);
    procedure vtSearchBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure eFk_Tipo_AliasExit(Sender: TObject);
    procedure eDoc_PriExit(Sender: TObject);
    procedure eDoc_SecExit(Sender: TObject);
    procedure TreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtPhonesNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure vtInternetNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure vtPhoneListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtCategoryChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure eFk_ContatosDblClick(Sender: TObject);
    procedure vtPhoneListDblClick(Sender: TObject);
  private
    { Private declarations }
    FActivePages  : TOwnerTypes;
    FActiveOwnType: TCategoryType;
    FColumnIndex  : Integer;
    FCompanyClick : Boolean;
    FOwnerTypes   : TOwnerTypes;
    FRect         : TRect;
    FSavedFields  : TSavedFields;
    FSearchField  : string;
    FSearchText   : string;
    FListLoaded   : Boolean;
    FLoading      : Boolean;
    FPk           : Integer;
    FScrState     : TDBMode;
    FPagesState   : TDBMode;
    FVisibleTypes : TOwnerTypes;
    function  ValidateOperation: Boolean;
    function  SetAllPagesState(const AState: TDBMode; APk: Integer = 0): Boolean;
    function  GetActiveOwner: TOwner;
    function  GetAddress: string;
    function  GetCategory: TCategories;
    function  GetContact: Integer;
    function  GetCity: Integer;
    function  GetCmplAddress: string;
    function  GetCompany: Integer;
    function  GetCountry: Integer;
    function  GetCPF_CGC: string;
    function  GetFkAlias: Integer;
    function  GetIE_RG: string;
    function  GetNameOwner: string;
    function  GetNetAddr: TInternetAddresses;
    function  GetNumbAddress: Integer;
    function  GetObservation: TStrings;
    function  GetOwnerEvents: TOwnerEvents;
    function  GetPhones: TPhones;
    function  GetPosition: string;
    function  GetPostalBox: string;
    function  GetState: string;
    function  GetTitle: string;
    function  GetTypeOwner: TTypeOwner;
    function  GetZipCode: Integer;
    function  CheckQtdDocuments(AType: TTypeDocs): Boolean;
    function  ShowDataPages(APages: TOwnerTypes; ACallLoadDefauls: Boolean = False): Boolean;
    procedure ClearDataPages;
    procedure SetVisibleTypes(AValue: TOwnerTypes);
    procedure SetScreenFromVisibleTypes;
    procedure SetPk(const Value: Integer);
    procedure SetScrState(const Value: TDBMode);
    procedure SetNavigationButtons;
    procedure SetScrollScreen;
    procedure ChangeSrcState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure UpdateList(AState: TDBMode);
    procedure GetListFields;
    procedure SetActiveOwnType(const Value: TCategoryType);
    procedure SetAddress(const Value: string);
    procedure SetCategory(const Value: TCategories);
    procedure SetCity(const Value: Integer);
    procedure SetCmplAddress(const Value: string);
    procedure SetCountry(const Value: Integer);
    procedure SetCPF_CGC(const Value: string);
    procedure SetFkAlias(const Value: Integer);
    procedure SetIE_RG(const Value: string);
    procedure SetNameOwner(const Value: string);
    procedure SetNumbAddress(const Value: Integer);
    procedure SetObservation(const Value: TStrings);
    procedure SetPhones(const Value: TPhones);
    procedure SetPosition(const Value: string);
    procedure SetPostalBox(const Value: string);
    procedure SetState(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetTypeOwner(const Value: TTypeOwner);
    procedure SetZipCode(const Value: Integer);
    procedure SetActiveOwner(Value: TOwner);
    procedure SetNetAddr(const Value: TInternetAddresses);
    procedure SetOwnerEvents(const Value: TOwnerEvents);
    procedure SetContact(const Value: Integer);
    procedure ChangeScreenData;
    procedure DeleteNode(Sender: TVirtualStringTree; ANode: PVirtualNode);
    procedure CreateNewNode(Sender: TVirtualStringTree; ATree: TTypeTree);
    procedure DefaultData;
    procedure SetNewVisibleTypes(const AState: TDBMode);
  protected
    { Protected declarations }
    // Load Data from DB
    procedure LoadAlias;
    procedure LoadCountries;
    procedure LoadCompanies;
    procedure LoadStates;
    procedure LoadCities;
    procedure GetDataFromDB;
    procedure LoadDefaults;
    procedure LoadListPhones;
    procedure MoveDataToControls;
    procedure ClearControls;
    procedure SaveIntoDB;
    procedure DeleteFromDB;
    property  ActiveOwnType : TCategoryType      read FActiveOwnType  write SetActiveOwnType;
    property  ListLoaded    : Boolean            read FListLoaded     write FListLoaded;
    property  Loading       : Boolean            read FLoading        write FLoading;
    property  VisibleTypes  : TOwnerTypes        read FVisibleTypes   write SetVisibleTypes;
  public
    { Public declarations }
    property  ActiveOwner : TOwner               read GetActiveOwner  write SetActiveOwner;
    property  Pk          : Integer              read FPk             write SetPk;
    property  ScrState    : TDBMode              read FScrState       write SetScrState;
    property  Title       : string               read GetTitle        write SetTitle;
    property  TypeOwner   : TTypeOwner           read GetTypeOwner    write SetTypeOwner;
    property  CPF_CGC     : string               read GetCPF_CGC      write SetCPF_CGC;
    property  IE_RG       : string               read GetIE_RG        write SetIE_RG;
    property  NameOwner   : string               read GetNameOwner    write SetNameOwner;
    property  FkAlias     : Integer              read GetFkAlias      write SetFkAlias;
    property  Contact     : Integer              read GetContact      write SetContact;
    property  Company     : Integer              read GetCompany;
    property  Position    : string               read GetPosition     write SetPosition;
    property  Category    : TCategories          read GetCategory     write SetCategory;
    property  Phones      : TPhones              read GetPhones       write SetPhones;
    property  Country     : Integer              read GetCountry      write SetCountry;
    property  State       : string               read GetState        write SetState;
    property  City        : Integer              read GetCity         write SetCity;
    property  Address     : string               read GetAddress      write SetAddress;
    property  CmplAddress : string               read GetCmplAddress  write SetCmplAddress;
    property  NumbAddress : Integer              read GetNumbAddress  write SetNumbAddress;
    property  ZipCode     : Integer              read GetZipCode      write SetZipCode;
    property  PostalBox   : string               read GetPostalBox    write SetPostalBox;
    property  Observation : TStrings             read GetObservation  write SetObservation;
    property  NetAddr     : TInternetAddresses   read GetNetAddr      write SetNetAddr;
    property  OwnerEvents : TOwnerEvents         read GetOwnerEvents  write SetOwnerEvents;
  published
    { Published declarations }
    property  OwnerTypes  : TOwnerTypes          read FOwnerTypes     write FOwnerTypes;
  end;

resourcestring
  S_PHONE_MASK = '!\(\0xx99\)9000-0000;0; ';

implementation

uses CadCustomer, CadForn, CadEmply, Dado, SelEmpr, CmmConst, FuncoesDB, DB,
  TypInfo, Math, Funcoes, CadArqSql, MaskUtils, Clipbrd;

  {$R *.dfm}

var
  OwnerFormClass: array [ctCustomer..ctEmployee] of TOwnerFormClass =
    (TCdCustomer, TCdSupplier, TCdEmployee);
  OwnerPageTitle: array [ctCustomer..ctEmployee] of string          =
    ('Clientes', 'Fornecedores', 'Funcionários');
  OwnerPageImage: array [0..2] of Integer = (87, 26, 84);

procedure TfrmOwners.FormCreate(Sender: TObject);
begin
  FVisibleTypes               := [ctRepresentant, ctAgent, ctOthers];
  OwnerTypes                  := [ctCustomer, ctSupplier, ctEmployee, ctRepresentant, ctAgent, ctOthers];
  vtSearch.Images             := Dados.Image16;
  vtSearch.Header.Images      := Dados.Image16;
  vtSearch.NodeDataSize       := SizeOf(TGridData);
  vtSearch.Header.SortColumn  := 1;
  vtCategory.Images           := Dados.Image16;
  vtCategory.Header.Images    := Dados.Image16;
  vtCategory.NodeDataSize     := SizeOf(TGridData);
  vtPhones.Images             := Dados.Image16;
  vtPhones.Header.Images      := Dados.Image16;
  vtPhones.NodeDataSize       := SizeOf(TGridData);
  vtEvents.Images             := Dados.Image16;
  vtEvents.Header.Images      := Dados.Image16;
  vtEvents.NodeDataSize       := SizeOf(TGridData);
  vtInternet.Images           := Dados.Image16;
  vtInternet.Header.Images    := Dados.Image16;
  vtInternet.NodeDataSize     := SizeOf(TGridData);
  vtPhoneList.Images          := Dados.Image16;
  vtPhoneList.Header.Images   := Dados.Image16;
  vtPhoneList.NodeDataSize    := SizeOf(TGridData);
  pgControl.Images            := Dados.Image16;
  pgControl.ActivePageIndex   := 0;
  pgCategory.Images           := Dados.Image16;
  pgContactData.Images        := Dados.Image16;
  cbTools.Images              := Dados.Image16;
  tbTools.Images              := Dados.Image16;
  ListLoaded                  := False;
  FSearchField                := 'RAZ_SOC';
  FSearchText                 := '';
  FPagesState                 := dbmBrowse;
  FSavedFields.TrtCnt         := '';
  FSavedFields.FlagTCad       := toCompany;
  FSavedFields.Country        := 0;
  FSavedFields.State          := '';
  FSavedFields.City           := 0;
  LoadDefaults;
end;

procedure TfrmOwners.FormShow(Sender: TObject);
begin
  pgContactData.ActivePageIndex     := 0;
  pgComplement.ActivePageIndex      := 0;
  Caption := Application.Title + ' - ' + Dados.Parametros.soProgramTitle;
  eRaz_Soc.SetFocus;
  tbFound.Click;
end;

procedure TfrmOwners.FormDestroy(Sender: TObject);
begin
  ClearDataPages;
  eFk_Contatos.ReleaseObjects;
  eFk_Paises.ReleaseObjects;
  eFk_Estados.ReleaseObjects;
  eFk_Municipios.ReleaseObjects;
  ReleaseTreeNodes(vtSearch);
  ReleaseTreeNodes(vtCategory);
  ReleaseTreeNodes(vtPhones);
  ReleaseTreeNodes(vtPhoneList);
  ReleaseTreeNodes(vtInternet);
  ReleaseTreeNodes(vtEvents);
end;

procedure TfrmOwners.FormKeyDown(Sender: TObject; var Key: Word;
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
  if (ssCtrl in Shift) and (Key = VK_INSERT) then
  begin
    Key := 0;
    DefaultData;
    exit;
  end;
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
    VK_DELETE: if (not (ssCtrl in Shift)) and (ssShift in Shift) and
                  (tbDelete.Enabled) then
                 tbDelete.Click;
    VK_NEXT  : if (aState in SCROLL_MODE) and (tbNext.Enabled)  then tbNext.Click;
    VK_PRIOR : if (aState in SCROLL_MODE) and (tbPrior.Enabled) then tbPrior.Click;
  end;
end;

procedure TfrmOwners.ClearDataPages;
var
  Ix       : Integer;
  aForm    : TForm;
  aTabSheet: TTabSheet;
begin
  Ix := 2;
  pgCategory.Visible := False;
  FActivePages := [ctRepresentant, ctAgent, ctOthers];
  if Ix > pgCategory.PageCount - 1 then Ix := pgCategory.PageCount - 1;
  while Ix > -1 do
  begin
    aTabSheet := pgCategory.Pages[Ix];
    aForm     := TForm(aTabSheet.Tag);
    if ((aForm <> nil) and
        (aForm is OwnerFormClass[TCategoryType(Ix)])) then
    begin
      aForm.Close;
      aForm.Free;
      aForm := nil;
      if aForm = nil then
        aTabSheet.Tag := 0;
    end;
    pgCategory.RemoveControl(aTabSheet);
    aTabSheet.Free;
    aTabSheet := nil;
    if aTabSheet = nil then Dec(Ix);
  end;
end;

function  TfrmOwners.ShowDataPages(APages: TOwnerTypes;
            ACallLoadDefauls: Boolean = False): Boolean;
var
  iX       : TCategoryType;
  aForm    : TfrmModel;
  aTabSheet: TTabSheet;
  function LoadPages(APageType : TCategoryType): TTabSheet;
  begin
    Result             := TTabSheet.Create(pgCategory);
    Result.PageControl := pgCategory;
    Result.Align       := alClient;
    Result.Caption     := OwnerPageTitle[APageType];
    Result.ImageIndex  := OwnerPageImage[Ord(APageType)];
    Result.Tag         := 0;
  end;
begin
  Result := False;
  if APages = [] then exit;
  for Ix := Low(TCategoryType) to High(TCategoryType) do
  begin
//    if (Ix in APages) and (Ix in OwnerTypes) and
//       (not (Ix in FActivePages)) then
    if (Ix in APages) and (Ix in OwnerTypes) then
    begin
      aTabSheet    := LoadPages(Ix);
      if aTabSheet <> nil then
      begin
        FActivePages := FActivePages + [Ix];
        Result := True;
        aForm        := TfrmModel(aTabSheet.Tag);
        if (aForm = nil) and (OwnerFormClass[Ix] <> nil) then
        begin
          aForm               := OwnerFormClass[Ix].Create(Self);
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

procedure TfrmOwners.SetScreenFromVisibleTypes;
var
  aFlag: Boolean;
  i: Integer;
begin
  aFlag := False;
  ClearDataPages;
  if (ctCustomer in FVisibleTypes)  then
    ShowDataPages([ctCustomer]);
  if (ctSupplier in FVisibleTypes) then
    ShowDataPages([ctSupplier]);
  if (ctEmployee   in FVisibleTypes) then
    ShowDataPages([ctEmployee]);
  for i := 0 to pgCategory.PageCount - 1 do
    if (pgCategory.Pages[i].TabVisible) then
      aFlag := True;
  pgCategory.Visible := aFlag;
end;

procedure TfrmOwners.LoadDefaults;
begin
  if not ListLoaded then
  begin
    LoadAlias;
    LoadCountries;
    LoadCompanies;
    ListLoaded := True;
  end;
end;

procedure TfrmOwners.ClearControls;
begin
  Loading    := True;
  try
    CPF_CGC     := '';
    IE_RG       := '';
    NameOwner   := '';
    FkAlias     := 0;
    Contact     := 0;
    Position    := '';
    Address     := '';
    CmplAddress := '';
    NumbAddress := 0;
    ZipCode     := 0;
    PostalBox   := '';
    Observation.Clear;
    SetCategory(nil);
    if (vtSearch.RootNodeCount = 0) or (ScrState in SCROLL_MODE) then
    begin
      Title       := '';
      TypeOwner   := toAll;
      Country     := 0;
      State       := '';
      City        := 0;
    end
    else
    begin
      Title       := FSavedFields.TrtCnt;
      TypeOwner   := FSavedFields.FlagTCad;
      Country     := FSavedFields.Country;
      State       := FSavedFields.State;
      City        := FSavedFields.City;
    end;
    ChangeScreenData;
  finally
    Loading := False;
  end;
end;

procedure TfrmOwners.MoveDataToControls;
begin
  if (Pk = 0) then
  begin
    ReleaseTreeNodes(vtPhones);
    ReleaseTreeNodes(vtCategory);
    ReleaseTreeNodes(vtEvents);
    ReleaseTreeNodes(vtInternet);
    Category    := TCategories.Create(nil);
    Phones      := TPhones.Create(nil);
    OwnerEvents := TOwnerEvents.Create(nil);
    NetAddr     := TInternetAddresses.Create(nil);
    exit;
  end;
  Loading := True;
  try
    ActiveOwner := dmSysCad.GetOwnerData(Pk);
  finally
    Loading := False;
  end;
end;

procedure TfrmOwners.LoadCountries;
begin
  eFk_Paises.ReleaseObjects;
  eFk_Paises.Items.AddStrings(dmSysCad.LoadCountries);
end;

procedure TfrmOwners.LoadStates;
begin
  eFk_Estados.ReleaseObjects;
  with eFk_Paises do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      eFk_Estados.Items.AddStrings(dmSysCad.LoadStates(TCountry(Items.Objects[ItemIndex])));
end;

procedure TfrmOwners.LoadCities;
begin
  eFk_Municipios.ReleaseObjects;
  with eFk_Estados do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      eFk_Municipios.Items.AddStrings(dmSysCad.LoadCities(TState(Items.Objects[ItemIndex])));
end;

procedure TfrmOwners.LoadAlias;
begin
  ReleaseCombos(eFk_Tipo_Alias, toInteger);
  eFk_Tipo_Alias.Items.AddStrings(dmSysCad.LoadAlias);
end;

procedure TfrmOwners.LoadCompanies;
begin
  eFk_Contatos.ReleaseObjects;
  eFk_Contatos.Items.AddStrings(dmSysCad.LoadCompanies);
end;

procedure TfrmOwners.SetActiveOwnType(const Value: TCategoryType);
begin
  if (FActiveOwnType <> Value) then
    FActiveOwnType  := Value;
end;

procedure TfrmOwners.tbPriorClick(Sender: TObject);
var
  Node: PVirtualNode;
  procedure SetPrevious;
  begin
    while (Node <> nil) and (vtSearch.GetNodeLevel(Node) > 0) do
      Node := vtSearch.GetPrevious(Node);
  end;
begin
  if (vtSearch.FocusedNode = nil) then exit;
  Node := vtSearch.GetPrevious(vtSearch.FocusedNode);
  SetPrevious;
  if (Node = nil) then
  begin
    Node := vtSearch.GetLast;
    SetPrevious;
  end;
  vtSearch.FocusedNode    := Node;
  vtSearch.Selected[Node] := True;
  SetNavigationButtons;
end;

procedure TfrmOwners.tbNextClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  if (vtSearch.FocusedNode = nil) then exit;
  Node := vtSearch.GetNext(vtSearch.FocusedNode);
  while (Node <> nil) and (vtSearch.GetNodeLevel(Node) > 0) do
    Node := vtSearch.GetNext(Node);
  if (Node = nil) then
    Node := vtSearch.GetFirst;
  vtSearch.FocusedNode    := Node;
  vtSearch.Selected[Node] := True;
  SetNavigationButtons;
end;

procedure TfrmOwners.tbSaveClick(Sender: TObject);
begin
  ScrState := dbmPost;
  SetAllPagesState(dbmBrowse);
  ScrState := dbmBrowse;
end;

procedure TfrmOwners.SaveIntoDB;
var
  aPk: Integer;
  aTr: Integer;
  aItem: TOwner;
begin
  aPk := Pk;
  if (ScrState in UPDATE_MODE) then
    eFk_Tipo_AliasExit(Self);
  aTr := Dados.StartTransaction;
  try
    if (ScrState in UPDATE_MODE) then
    begin
      aPk := dmSysCad.SaveAllContactData(ScrState, ActiveOwner);
      if ((TypeOwner = toCompany) and (ScrState = dbmInsert)) then
      begin
        aItem               := TOwner.Create;
        aItem.PkCadastros   := aPk;
        aItem.RazSoc        := ActiveOwner.RazSoc;
        aItem.FlagTCad      := ActiveOwner.FlagTCad;
        aItem.cbIndex       := eFk_Contatos.Items.AddObject(aItem.RazSoc, aItem);
        eFk_Contatos.Sorted := True;
      end;
      if (iImg_Cad.Picture.Graphic <> nil) then
        dmSysCad.SaveOwnerImage(aPk, iImg_Cad.Picture.Graphic, iImg_Cad.Tag);
      if (eObs_Cad.Lines.Count > 0) then
        dmSysCad.SaveOwnerObs(aPk, eObs_Cad.Lines, eObs_Cad.Tag);
    end;
    SetAllPagesState(dbmPost, aPk);
    Dados.CommitTransaction(nil, aTr);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(nil, aTr);
      raise Exception.Create(E.Message);
    end;
  end;
  UpdateList(FScrState);
  Pk := aPk;
  FSavedFields.Country       := Country;
  FSavedFields.State         := State;
  FSavedFields.
  City          := City;
  FSavedFields.FlagTCad      := TypeOwner;
  FSavedFields.TrtCnt        := Title;
end;

procedure TfrmOwners.tbInsertClick(Sender: TObject);
begin
  if (ScrState in LOADING_MODE) then SetScrollScreen;
  Pk := 0;
  ScrState := dbmInsert;
  if (pgControl.ActivePageIndex = 1) then
    pgControl.ActivePageIndex := 0;
end;

procedure TfrmOwners.tbCancelClick(Sender: TObject);
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

procedure TfrmOwners.tbDeleteClick(Sender: TObject);
begin
  ScrState := dbmDelete;
  ScrState := dbmBrowse;
end;

function TfrmOwners.ValidateOperation: Boolean;
begin
  Result := False;
  if (CPF_CGC <> '') and (IE_RG <> '') then
    if (not CheckQtdDocuments(tdBoth)) then
      exit
    else
      if (CPF_CGC <> '') then
        CheckQtdDocuments(tdPrimary)
      else
        if (not CheckQtdDocuments(tdSecondary)) then
          exit;
  if (NameOwner = '') then
  begin
    Dados.DisplayHint(eRaz_Soc, 'Campo Nome é obrigatório');
    exit;
  end;
  if (Country = 0) then
  begin
    Dados.DisplayHint(eFk_Paises, 'Campo País é obrigatório');
    exit;
  end;
  if (State = '') then
  begin
    Dados.DisplayHint(eFk_Estados, 'Campo Estado é obrigatório');
    exit;
  end;
  if (City = 0) then
  begin
    Dados.DisplayHint(eFk_Municipios, 'Campo Município é obrigatório');
    exit;
  end;
  if (not (TypeOwner in [toCompany, toPeople, toForeigner])) then
  begin
    Dados.DisplayHint(eFlag_TCad, 'Campo Tipo de Contato é obrigatório');
    exit;
  end;
  Result := True;
end;

procedure TfrmOwners.vtSearchEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TfrmOwners.vtSearchDblClick(Sender: TObject);
begin
  if (vtSearch.FocusedNode <> nil) then
    pgControl.ActivePageIndex := 0;
end;

procedure TfrmOwners.vtSearchGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Column of
    0: if (Sender.GetNodeLevel(Node) = 0) then
         CellText := Data^.DataRow.FieldByName['PK_CADASTROS'].AsString
       else
         CellText := 'Cat.';
    1: if (Sender.GetNodeLevel(Node) = 0) then
         CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString
       else
         CellText := LowerCase(Data^.DataRow.FieldByName['DSC_CAT'].AsString);
    2: begin
         CellText := '...';
         if (Sender.GetNodeLevel(Node) = 0) and
            (not Data^.DataRow.FieldByName['DSC_ALIAS'].IsNull) then
           CellText := Data^.DataRow.FieldByName['DSC_ALIAS'].AsString
       end;
    3: begin
         CellText := '...';
         if (Sender.GetNodeLevel(Node) = 0) and
            (not Data^.DataRow.FieldByName['DOC_PRI'].IsNull) then
            if (Length(Data^.DataRow.FieldByName['DOC_PRI'].AsString) = 14) then
              CellText := MaskDoFormatText('##.###.###/####-##', Data^.DataRow.FieldByName['DOC_PRI'].AsString, '-')
            else
              CellText := MaskDoFormatText('###.###.###-##', Data^.DataRow.FieldByName['DOC_PRI'].AsString, '-');
       end;
  end;
end;

procedure TfrmOwners.vtSearchFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) or (vtSearch.GetNodeLevel(Node) > 0) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data.DataRow = nil) then exit;
  Pk := Data.DataRow.FieldByName['PK_CADASTROS'].AsInteger;
  SetNavigationButtons;
end;

procedure TfrmOwners.vtSearchCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data: PGridData;
  Str1, Str2, aFn: string;
  function GetStringValue(aItem: TDataRow): string;
  begin
    case Column of
      0: aFn := 'PK_CADASTROS';
      1: aFn := 'RAZ_SOC';
      2: aFn := 'DSC_ALIAS';
      3: aFn := 'DOC_PRI';
    end;
    if (Column = 0) then
      Result := InsereZer(IntToStr(aItem.FieldByName[aFn].AsInteger), 20)
    else
      Result := aItem.FieldByName[aFn].AsString;
  end;
begin
  if (Node1 = nil) or (Node2 = nil) or (Column < 0) or
     (Sender.GetNodeLevel(Node1) > 0) or (Sender.GetNodeLevel(Node2) > 0) then
    exit;
  Data := Sender.GetNodeData(Node1);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Str1 := GetStringValue(Data^.DataRow);
  Data := Sender.GetNodeData(Node2);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Str2 := GetStringValue(Data^.DataRow);
  case TVirtualStringTree(Sender).Header.SortDirection of
    sdAscending : Result := CompareText(Str1, Str2);
    sdDescending: Result := CompareText(Str1, Str2);
  end;
end;

procedure TfrmOwners.vtSearchHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
// Select the column to search on grid
  if Column < 0 then exit;
  FColumnIndex := Column;
  case FColumnIndex of
    0: FSearchField := 'PK_CADASTROS';
    1: FSearchField := 'RAZ_SOC';
    2: FSearchField := 'DSC_ALIAS';
    3: FSearchField := 'DOC_PRI';
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

procedure TfrmOwners.SetPk(const Value: Integer);
var
  i    : Integer;
  aForm: TForm;
begin
//  Set Active Owner
  FPk := Value;
  if (FScrState in SCROLL_MODE) then
  begin
    MoveDataToControls;
    SetCategory(nil);
  //  Load Image and Observatiosn
    Loading := True;
    try
      i := Pk;
      iImg_Cad.Picture.Graphic := nil;
      if (FPk > 0) then
        iImg_Cad.Picture.Assign(dmSysCad.LoadOwnerImage(FPk, i));
      iImg_Cad.Tag := i;
      i := Pk;
      eObs_Cad.Clear;
      if (FPk > 0) then
        eObs_Cad.Lines.Assign(dmSysCad.LoadOwnerObs(FPk, i));
      eObs_Cad.Tag := i;
    finally
      Loading := False;
    end;
  end;
  for i := 0 to pgCategory.PageCount - 1 do
  begin
    aForm := TForm(pgCategory.Pages[i].Tag);
    if (aForm <> nil) then
      TfrmModel(aForm).Pk := Pk
  end;
end;

procedure TfrmOwners.SetScrState(const Value: TDBMode);
begin
  if (FScrState <> Value) then
  begin
    if (not (Value in [dbmPost, dbmCheck])) then
      FScrState := Value
    else
      if ((Value = dbmCheck) or (FScrState in UPDATE_MODE)) then
      begin
        if (not ValidateOperation) then exit;
        if (not SetAllPagesState(dbmCheck)) then exit;  // I can't save the product before check all updated pages
      end;
    if (Value = dbmCheck) then exit;
    case Value of
      dbmFind   : ChangeControlColors(Self, clInfoBk, clGreen);
      dbmExecute: GetListFields;
      dbmInsert : if (Pk > 0) then ClearControls;
      dbmDelete : DeleteFromDB;
      dbmPost   : SaveIntoDB;
      dbmCancel : MoveDataToControls;
      dbmBrowse : MoveDataToControls;
    end;
    FScrState := Value;
  end;
  ChangeSrcState(Self, FScrState);
end;

procedure TfrmOwners.ChangeSrcState(Sender: TObject; AState: TDBMode;
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
  tsEvents.TabVisible := (not (FScrState in LOADING_MODE));
  tbCancel.Enabled := (_State in UPDATE_MODE);
  tbSave.Enabled   := (_State in UPDATE_MODE);
  tbDelete.Enabled := (_State in SCROLL_MODE) and (vtSearch.RootNodeCount > 0);
  tbFound.Enabled  := (_State in SCROLL_MODE);
  tbFind.Enabled   := (_State in LOADING_MODE);
  tbClose.Enabled  := (_State in SCROLL_MODE + LOADING_MODE);
  tbInsert.Enabled := (_State in SCROLL_MODE + LOADING_MODE);
  SetNavigationButtons;
  sbStatus.Repaint;
end;

function  TfrmOwners.SetAllPagesState(const AState: TDBMode; APk: Integer = 0): Boolean;
var
  i    : Integer;
  aForm: TfrmModel;
begin
  Result      := True;
  FPagesState := AState;
  for i := 0 to pgCategory.PageCount - 1 do
  begin
    aForm := TfrmModel(pgCategory.Pages[i].Tag);
    if (aForm <> nil) and (Pk > 0) and (aForm.ScrState in UPDATE_MODE) then
    begin
      aForm.PkAux := APk;
      if (aForm.ScrState <> AState) then
      begin
        aForm.ScrState := AState;
        if (AState = dbmCheck) and (not aForm.CheckRecord) then
        begin
          pgCategory.ActivePageIndex := i;
          Result := False;
          break;
        end;
      end;
    end;
  end;
end;

procedure TfrmOwners.SetNavigationButtons;
begin
  tbNext.Enabled  := (FScrState in SCROLL_MODE) and (vtSearch.RootNodeCount > 0);
  tbPrior.Enabled := (FScrState in SCROLL_MODE) and (vtSearch.RootNodeCount > 0);
end;

procedure TfrmOwners.GetListFields;
var
  Node   : PVirtualNode;
  vnChild: PVirtualNode;
  Data   : PGridData;
  aStrAux: string;
  AClip  : TClipboard;
begin
  ReleaseTreeNodes(vtSearch);
  with dmSysCad do
  begin
    if Cadastro.Active then Cadastro.Close;
    Cadastro.SQL.Clear;
    Cadastro.SQL.AddStrings(ActiveOwner.GetSearchSQL);
    AClip := TClipboard.Create;
    AClip.AsText := Cadastro.SQL.Text;
    Dados.StartTransaction(Cadastro);
    Node := nil;
    vtSearch.BeginUpdate;
    try
      aStrAux := '';
      if not Cadastro.Active then Cadastro.Open;
      while not Cadastro.Eof do
      begin
        if (aStrAux <> Cadastro.FieldByName('RAZ_SOC').AsString) then
        begin
          Node := vtSearch.AddChild(nil);
          if (Node <> nil) then
          begin
            Data := vtSearch.GetNodeData(Node);
            if (Data <> nil) then
            begin
              Data^.Level   := 0;
              Data^.Node    := Node;
              Data^.DataRow := TDataRow.CreateFromDataSet(nil, Cadastro, True);
            end;
          end;
        end;
        if (Node <> nil) then
        begin
          vnChild := vtSearch.AddChild(Node);
          if (vnChild <> nil) then
          begin
            Data := vtSearch.GetNodeData(vnChild);
            if (Data <> nil) then
            begin
              Data^.Level   := 0;
              Data^.Node    := vnChild;
              Data^.DataRow := TDataRow.CreateFromDataSet(nil, Cadastro, True);
            end;
          end;
        end;
        aStrAux := Cadastro.FieldByName('RAZ_SOC').AsString;
        Cadastro.Next;
      end;
    finally
      vtSearch.EndUpdate;
      if Cadastro.Active then Cadastro.Close;
      Dados.CommitTransaction(Cadastro);
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
    vtSearch.Header.SortColumn := 1;
    Dados.DisplayHint(tbTools, Format('Encontrados %d registros',
      [vtSearch.RootNodeCount]));
    SetNavigationButtons;
  end
  else
    Dados.DisplayHint(tbTools, 'Nenhum registro encontrado');
end;

procedure TfrmOwners.ChangeGlobal(Sender: TObject);
begin
  if (Loading) or (FScrState in LOADING_MODE) or (ScrState in UPDATE_MODE) then exit;
  if (Pk > 0) then
    ScrState := dbmEdit
  else
    ScrState := dbmInsert;
end;

procedure TfrmOwners.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOwners.pgControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (FScrState in SCROLL_MODE) and (vtSearch.RootNodeCount > 0);
end;

procedure TfrmOwners.sbStatusClick(Sender: TObject);
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

procedure TfrmOwners.sbStatusDrawPanel(StatusBar: TStatusBar;
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

procedure TfrmOwners.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TfrmOwners.tbFindClick(Sender: TObject);
begin
  ScrState := dbmExecute;
  SetScrollScreen;
end;

procedure TfrmOwners.SetScrollScreen;
begin
  ChangeControlColors(Self, clWindow, clWindowText);
  tsPhones.TabVisible       := True;
  tsInternet.TabVisible     := True;
  tsEvents.TabVisible       := True;
  ClearControls;
  ScrState := dbmBrowse;
end;

procedure TfrmOwners.tbFoundClick(Sender: TObject);
begin
  pgControl.ActivePageIndex := 0;
  tsPhones.TabVisible       := False;
  tsInternet.TabVisible     := False;
  tsContactList.TabVisible  := False;
  tsEvents.TabVisible       := False;
  ClearDataPages;
  ClearControls;
  ReleaseTreeNodes(vtSearch);
  Pk                        := 0;
  ScrState                  := dbmFind;
end;

procedure TfrmOwners.SetVisibleTypes(AValue: TOwnerTypes);
begin
  if (AValue <> FVisibleTypes) then
  begin
    FVisibleTypes := AValue;
    SetScreenFromVisibleTypes;
  end;
end;

procedure TfrmOwners.iImgCadDblClick(Sender: TObject);
begin
  if opImage.Execute then
  begin
    iImg_Cad.Picture.LoadFromFile(opImage.FileName);
    if (not Loading) and (ScrState in SCROLL_MODE) then
    begin
      if (Pk > 0) then
        ScrState := dbmEdit
      else
        ScrState := dbmInsert;
    end;
  end;
end;

procedure TfrmOwners.UpdateList(AState: TDBMode);
var
  Node: PVirtualNode;
  vNew: PVirtualNode;
  Data: PGridData;
  procedure DeleteNode;
  begin
    vtSearch.BeginUpdate;
    try
      Data := vtSearch.GetNodeData(Node);
      vNew := vtSearch.GetNext(Node);
      while (vNew <> nil) and (vtSearch.GetNodeLevel(vNew) > 0) do
        vNew := vtSearch.GetNext(vNew);
      if (vNew = nil) then
      begin
        vNew := vtSearch.GetPrevious(Node);
        while (vNew <> nil) and (vtSearch.GetNodeLevel(vNew) > 0) do
          vNew := vtSearch.GetPrevious(vNew);
      end;
      if (vNew = nil) then
        vNew := vtSearch.GetFirst;
      if (vNew = nil) then
      begin
        VisibleTypes := [ctRepresentant, ctAgent, ctOthers];
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
    if (vNew <> nil) then
    begin
      vtSearch.FocusedNode    := vNew;
      vtSearch.Selected[vNew] := True;
    end;
  end;
begin
  Node := vtSearch.FocusedNode;
  if (Node <> nil) and (ScrState = dbmDelete) then
    DeleteNode
  else
    GetDataFromDB;
end;

procedure TfrmOwners.GetDataFromDB;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtSearch.FocusedNode;
  with dmSysCad do
  begin
    if Cadastro.Active then Cadastro.Close;
    Cadastro.SQL.Clear;
    Cadastro.SQL.Add(SqlCadastro);
    vtSearch.BeginUpdate;
    Dados.StartTransaction(Cadastro);
    try
      Cadastro.ParamByName('PkCadastros').AsInteger    := Pk;
      if not Cadastro.Active then Cadastro.Open;
      if (not Cadastro.IsEmpty) then
      begin
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
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, Cadastro, True);
          end;
        end;
      end;
    finally
      if Cadastro.Active then Cadastro.Close;
      Dados.CommitTransaction(Cadastro);
      vtSearch.EndUpdate;
    end;
  end;
  vtSearch.FocusedNode    := Node;
  vtSearch.Selected[Node] := True;
end;

procedure TfrmOwners.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (ScrState in UPDATE_MODE) then
    if (Dados.DisplayMessage('Há alterações não salvas. Deseja sair e  ' +
          'abandonar as alterações?', hiQuestion, [mbYes, mbNo]) = mrNo) then
      Action := caNone;
end;

procedure TfrmOwners.DeleteFromDB;
var
  aTr: Integer;
begin
  if (Dados.DisplayMessage('Deseja Realmente excluir este registro?', hiWarning,
       [mbYes, mbNo]) = mrYes) then
  begin
    aTr := Dados.StartTransaction;
    try
      dmSysCad.SaveAllContactData(dbmDelete, ActiveOwner);
      Dados.CommitTransaction(nil, aTr);
    except on E:Exception do
      begin
        Dados.RollbackTransaction(nil, aTr);
        raise Exception.Create(E.Message);
      end;
    end;
    UpdateList(dbmDelete);
    SetAllPagesState(dbmBrowse);
    ScrState := dbmBrowse
  end;
end;

procedure TfrmOwners.vtSearchFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  if (NewNode = nil) and (OldNode = nil) then exit;
  Allowed := (not (ScrState in UPDATE_MODE)) or (Sender.GetNodeLevel(NewNode) = 0);
end;

procedure TfrmOwners.vtSearchPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
  aCategory: TCategoryType;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aCategory := ctOthers;
  if (not Data^.DataRow.FieldByName['FLAG_CAT'].IsNull) then
    aCategory := TCategoryType(Data^.DataRow.FieldByName['FLAG_CAT'].AsInteger);
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    TargetCanvas.Font.Color := clGray;
    if (OwnerTypes <> []) and (aCategory in OwnerTypes) then
    begin
      TargetCanvas.Font.Color := clBlue;
      TargetCanvas.Font.Style := [fsBold];
    end
  end
  else
    TargetCanvas.Font.Color := clSkyBlue;
end;

procedure TfrmOwners.vtSearchIncrementalSearch(Sender: TBaseVirtualTree;
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

procedure TfrmOwners.vtSearchStateChange(Sender: TBaseVirtualTree; Enter,
  Leave: TVirtualTreeStates);
var
  aCol, X, Y: Integer;
  aRect: TRect;
begin
  if (tsIncrementalSearching in Leave) then
  begin
    sbStatus.Panels[0].Text := 'Mensagem:';
    aCol := -1;
    if (FSearchField = 'PK_CADASTROS') then
      aCol := 0
    else
      if (FSearchField = 'RAZ_SOC') then
        aCol := 1
      else
        if (FSearchField = 'DSC_ALIAS') then
          aCol := 2
        else
          if (FSearchField = 'DOC_PRI') then
             aCol := 3;
    if (Sender.FocusedNode = nil) or (aCol = -1) then exit;
    aRect := vtSearch.GetDisplayRect(Sender.FocusedNode, aCol, True);
    vtSearch.Canvas.Brush.Color := clHighlight;
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

function TfrmOwners.GetAddress: string;
begin
  Result := eEnd_Cad.Text;
end;

function TfrmOwners.GetCategory: TCategories;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := TCategories.Create(nil);
  Node := vtCategory.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtCategory.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) and
       (Node.CheckState <> csUnCheckedNormal) then
    begin
      with Result.Add do
      begin
        DscCat     := Data^.DataRow.FieldByName['DSC_CAT'].AsString;
        FlagCat    := TCategoryType(Data^.DataRow.FieldByName['FLAG_CAT'].AsInteger);
        FlagAtv    := (Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger = 1);
        PkCategory := Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger;
        cbIndex    := Data^.DataRow.FieldByName['STATUS'].AsInteger;
      end;
    end;
    Node := vtCategory.GetNext(Node);
  end;
end;

function TfrmOwners.GetCity: Integer;
begin
  Result := 0;
  with eFk_Municipios do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TCity(Items.Objects[ItemIndex]).PkCity;
end;

function TfrmOwners.GetCmplAddress: string;
begin
  Result := eCmp_End.Text;
end;

function TfrmOwners.GetCompany: Integer;
begin
  Result := Dados.PkCompany;
end;

function TfrmOwners.GetCountry: Integer;
begin
  Result := 0;
  with eFk_Paises do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TCountry(Items.Objects[ItemIndex]).PkCountry;
end;

function TfrmOwners.GetCPF_CGC: string;
begin
  Result := eDoc_Pri.Text;
end;

function TfrmOwners.GetFkAlias: Integer;
begin
  Result := 0;
  with eFk_Tipo_Alias do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TfrmOwners.GetIE_RG: string;
begin
  Result := eDoc_Sec.Text;
end;

function TfrmOwners.GetNameOwner: string;
begin
  Result := eRaz_Soc.Text;
end;

function TfrmOwners.GetNetAddr: TInternetAddresses;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := TInternetAddresses.Create(nil);
  Node := vtInternet.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtInternet.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) and
       (Data^.DataRow.FieldByName['DSC_END'].AsString <> '') then
    begin
      with Result.Add do
      begin
        DscEnd  := Data^.DataRow.FieldByName['DSC_END'].AsString;
        EndCnt  := Data^.DataRow.FieldByName['END_CNT'].AsString;
        FlagDef := (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 1);
      end;
    end;
    Node := vtInternet.GetNext(Node);
  end;
end;

function TfrmOwners.GetNumbAddress: Integer;
begin
  Result := eNum_End.AsInteger;
end;

function TfrmOwners.GetObservation: TStrings;
begin
  Result := eObs_Cad.Lines;
end;

function TfrmOwners.GetOwnerEvents: TOwnerEvents;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := TOwnerEvents.Create(nil);
  Node := vtEvents.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtEvents.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) and
       (Data^.DataRow.FieldByName['DSC_EVT'].AsString <> '') then
    begin
      with Result.Add do
      begin
        PkOwnerEvent := Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsDateTime;
        FlagIncEvt   := (Data^.DataRow.FieldByName['FLAG_INC_EVT'].AsInteger = 1);
        DscEvt       := Data^.DataRow.FieldByName['DSC_EVT'].AsString;
      end;
    end;
    Node := vtEvents.GetNext(Node);
  end;
end;

function TfrmOwners.GetPhones: TPhones;
var
  Node  : PVirtualNode;
  Data  : PGridData;
begin
  Result := TPhones.Create(nil);
  Node := vtPhones.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtPhones.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) and
       (Data^.DataRow.FieldByName['DSC_CNT'].AsString <> '') then
    begin
      with Result.Add do
      begin
        DscPhone   := Data^.DataRow.FieldByName['DSC_CNT'].AsString;
        FonCad     := Data^.DataRow.FieldByName['CNT_CNT'].AsString;
        FlagDef    := (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 1);
      end;
    end;
    Node := vtPhones.GetNext(Node);
  end;
end;

function TfrmOwners.GetPosition: string;
begin
  Result := eCrg_Cad.Text;
end;

function TfrmOwners.GetPostalBox: string;
begin
  Result := eCxp_Cad.Text;
end;

function TfrmOwners.GetState: string;
begin
  Result := '';
  with eFk_Estados do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TState(Items.Objects[ItemIndex]).PkState;
end;

function TfrmOwners.GetTitle: string;
begin
  Result := eTrt_Cnt.Text;
end;

function TfrmOwners.GetTypeOwner: TTypeOwner;
begin
  Result := TTypeOwner(eFlag_TCad.ItemIndex);
end;

function TfrmOwners.GetZipCode: Integer;
begin
  Result := eCep_Cad.AsInteger;
end;

procedure TfrmOwners.SetAddress(const Value: string);
begin
  eEnd_Cad.Text := Value;
end;

procedure TfrmOwners.SetCategory(const Value: TCategories);
var
  Node: PVirtualNode;
  Data: PGridData;
  aControlTypes: TOwnerTypes;
begin
  aControlTypes := [ctRepresentant, ctAgent, ctOthers];
  ReleaseTreeNodes(vtCategory);
  with dmSysCad do
  begin
    if qrCategory.Active then qrCategory.Close;
    qrCategory.SQL.Clear;
    if (Pk > 0) then
      qrCategory.SQL.Add(SqlPkCategorias)
    else
      qrCategory.SQL.Add(SqlCategorias);
    Dados.StartTransaction(qrCategory);
    if (qrCategory.Params.FindParam('FkCadastros') <> nil) then
      qrCategory.ParamByName('FkCadastros').AsInteger := Pk;
    if not qrCategory.Active then qrCategory.Open;
    vtCategory.BeginUpdate;
    try
      while (not qrCategory.Eof) do
      begin
        Node := vtCategory.AddChild(nil);
        if Node <> nil then
        begin
          Data := vtCategory.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data.Level   := 0;
            Data.Node    := Node;
            Data.DataRow := TDataRow.Create(nil);
            Data.DataRow.AddAs('PK_CATEGORIAS', qrCategory.FieldByName('PK_CATEGORIAS').AsInteger,
              ftInteger, SizeOf(Integer));
            Data.DataRow.AddAs('DSC_CAT', qrCategory.FieldByName('DSC_CAT').AsString,
              ftString, 31);
            if (qrCategory.FindField('FLAG_ATV') = nil) then
              Data.DataRow.AddAs('FLAG_ATV', 1, ftInteger, SizeOf(Integer))
            else
              Data.DataRow.AddAs('FLAG_ATV', qrCategory.FieldByName('FLAG_ATV').AsInteger,
                ftInteger, SizeOf(Integer));
            Data.DataRow.AddAs('FLAG_CAT', qrCategory.FieldByName('FLAG_CAT').AsInteger,
              ftInteger, SizeOf(Integer));
            if (qrCategory.FindField('FK_CADASTROS') <> nil) and
               (qrCategory.FieldByName('FK_CADASTROS').AsInteger > 0) and
               (not (TCategoryType(qrCategory.FieldByName('FLAG_CAT').AsInteger) in aControlTypes)) then
              aControlTypes := aControlTypes + [TCategoryType(qrCategory.FieldByName('FLAG_CAT').AsInteger)];
            if (qrCategory.FindField('FK_CADASTROS') = nil) then
              Data.DataRow.AddAs('FK_CADASTROS', 0, ftInteger, SizeOf(Integer))
            else
              if (Data.DataRow.FindField['FK_CADASTROS'] = nil) then
                Data.DataRow.AddAs('FK_CADASTROS', qrCategory.FieldByName('FK_CADASTROS').AsInteger,
                  ftInteger, SizeOf(Integer))
              else
                Data.DataRow.FieldByName['FK_CADASTROS'].AsInteger := qrCategory.FieldByName('FK_CADASTROS').AsInteger;
            Data.DataRow.AddAs('STATUS', Ord(dbmBrowse), ftInteger, SizeOf(Integer));
          end;
        end;
        qrCategory.Next;
      end;
    finally
      vtCategory.EndUpdate;
      if qrCategory.Active then qrCategory.Close;
      Dados.CommitTransaction(qrCategory);
    end;
  end;
  if (Pk > 0) then
    VisibleTypes := aControlTypes;
end;

procedure TfrmOwners.SetCity(const Value: Integer);
begin
  with eFk_Municipios do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromObjectValue(Value);
  end;
end;

procedure TfrmOwners.SetCmplAddress(const Value: string);
begin
  eCmp_End.Text := Value;
end;

procedure TfrmOwners.SetCountry(const Value: Integer);
begin
  with eFk_Paises do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromObjectValue(Value);
  end;
end;

procedure TfrmOwners.SetCPF_CGC(const Value: string);
begin
  eDoc_Pri.Text := Value;
end;

procedure TfrmOwners.SetFkAlias(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Alias do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      for i := 0 to Items.Count - 1 do
        if (Items.Objects[i] <> nil) and (Value = Integer(Items.Objects[i])) then
        begin
          ItemIndex := i;
          break;
        end;
  end;
end;

procedure TfrmOwners.SetIE_RG(const Value: string);
begin
  eDoc_Sec.Text := Value;
end;

procedure TfrmOwners.SetNameOwner(const Value: string);
begin
  eRaz_Soc.Text := Value;
end;

procedure TfrmOwners.SetNumbAddress(const Value: Integer);
begin
  eNum_End.AsInteger := Value;
end;

procedure TfrmOwners.SetObservation(const Value: TStrings);
begin
  eObs_Cad.Clear;
  if (Value <> nil) then eObs_Cad.Lines.Assign(Value);
end;

procedure TfrmOwners.SetPhones(const Value: TPhones);
var
  i, a: Integer;
  Node: PVirtualNode;
  Data: PGridData;
  aCount: Integer;
  S1, S2: string;
begin
  if (Value = nil) then exit;
  if Value.Count = 0 then
    aCount := 1
  else
    aCount := Value.Count;
  ReleaseTreeNodes(vtPhones);
  vtPhones.BeginUpdate;
  try
    for i := 0 to aCount - 1 do
    begin
      Node := vtPhones.AddChild(nil);
      if Node <> nil then
      begin
        Data := vtPhones.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data.Level   := 0;
          Data.Node    := Node;
          Data.DataRow := TDataRow.Create(nil);
          a := 0;
          if (Value.Count > 0) then
          begin
            a  := Integer(Value.Items[i].FlagDef);
            S1 := Value.Items[i].DscPhone;
            S2 := Value.Items[i].FonCad;
          end;
          Data.DataRow.AddAs('FLAG_DEF', Ord(a), ftInteger, SizeOf(Integer));
          Data.DataRow.AddAs('DSC_CNT', S1, ftString, 31);
          Data.DataRow.AddAs('CNT_CNT', S2, ftString, 31);
          Data.DataRow.AddAs('PK_CADASTROS_CONTATOS', i, ftInteger, SizeOf(Integer));
        end;
         vtPhones.FocusedNode := Node;
      end;
    end;
  finally
    vtPhones.EndUpdate;
  end;
end;

procedure TfrmOwners.SetPosition(const Value: string);
begin
  eCrg_Cad.Text := Value;
end;

procedure TfrmOwners.SetPostalBox(const Value: string);
begin
  eCxp_Cad.Text := Value;
end;

procedure TfrmOwners.SetState(const Value: string);
begin
  with eFk_Estados do
  begin
    ItemIndex := -1;
    if (Value <> '') then SetIndexFromObjectValue(Value);
  end;
end;

procedure TfrmOwners.SetTitle(const Value: string);
begin
  eTrt_Cnt.Text := Value;
end;

procedure TfrmOwners.SetTypeOwner(const Value: TTypeOwner);
begin
  eFlag_TCad.ItemIndex := Ord(Value);
end;

procedure TfrmOwners.SetZipCode(const Value: Integer);
begin
  eCep_Cad.AsInteger := Value;
end;

function TfrmOwners.GetActiveOwner: TOwner;
begin
  Result                   := TOwner.Create;
  Result.PkCadastros       := Pk;
  Result.Title             := Title;
  Result.FlagTCad          := TypeOwner;
  Result.DocPri            := CPF_CGC;
  Result.DocSec            := IE_RG;
  Result.FkContacts        := Contact;
  Result.AreaAtu           := Position;
  Result.FkAlias           := FkAlias;
  with Result.Address do
  begin
    with FkCity.FkState do
    begin
      FkCountry.PKCountry  := Country;
      PkState              := State;
    end;
    FkCity.PkCity          := City;
    EndAdd                 := Address;
    CmpEnd                 := CmplAddress;
    NumAdd                 := NumbAddress;
    CepAdd                 := ZipCode;
    CxpAdd                 := PostalBox;
  end;
  Result.ObsCad            := Observation;
  Result.RazSoc            := NameOwner;
  Result.Phones            := Phones;
  Result.Categories        := Category;
  Result.InternetAddresses := NetAddr;
  Result.OwnerEvents       := OwnerEvents;
end;

procedure TfrmOwners.SetActiveOwner(Value: TOwner);
begin
  if (Value = nil) then exit;
  try
    Title       := Value.Title;
    TypeOwner   := Value.FlagTCad;
    ChangeScreenData;
    CPF_CGC     := Value.DocPri;
    IE_RG       := Value.DocSec;
    NameOwner   := Value.RazSoc;
    FkAlias     := Value.FkAlias;
    Contact     := Value.FkContacts;
    Position    := Value.AreaAtu;
    Country     := Value.Address.FkCity.FkState.FkCountry.PKCountry;
    State       := Value.Address.FkCity.FkState.PkState;
    City        := Value.Address.FkCity.PkCity;
    Address     := Value.Address.EndAdd;
    CmplAddress := Value.Address.CmpEnd;
    NumbAddress := Value.Address.NumAdd;
    ZipCode     := Value.Address.CepAdd;
    PostalBox   := Value.Address.CxpAdd;
    Observation := Value.ObsCad;
    Category    := Value.Categories;
    Phones      := Value.Phones;
    OwnerEvents := Value.OwnerEvents;
    NetAddr     := Value.InternetAddresses;
  finally
    FreeAndNil(Value);
  end;
end;

procedure TfrmOwners.SetNetAddr(const Value: TInternetAddresses);
var
  i   : Integer;
  Node: PVirtualNode;
  Data: PGridData;
  aCnt: Integer;
  aFlg: Boolean;
  aDsc: string;
  aEnd: string;
begin
  ReleaseTreeNodes(vtInternet);
  if (Value = nil) then exit;
  aCnt := Value.Count;
  if (aCnt = 0) then aCnt := 1;
  aFlg := False;
  aDsc := '';
  aEnd := '';
  vtInternet.BeginUpdate;
  try
    for i := 0 to aCnt - 1 do
    begin
      Node := vtInternet.AddChild(nil);
      if Node <> nil then
      begin
        Data := vtInternet.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data.Level   := 0;
          Data.Node    := Node;
          Data.DataRow := TDataRow.Create(nil);
          if (Value.Count > 0) then
            with Value.Items[i] do
            begin
              aFlg := FlagDef;
              aDsc := DscEnd;
              aEnd := EndCnt;
            end;
          Data.DataRow.AddAs('FLAG_DEF', Ord(aFlg), ftInteger, SizeOf(Integer));
          Data.DataRow.AddAs('DSC_END', aDsc, ftString, 31);
          Data.DataRow.AddAs('END_CNT', aEnd, ftString, 101);
        end;
      end;
    end;
  finally
    vtInternet.EndUpdate;
  end;
end;

procedure TfrmOwners.SetOwnerEvents(const Value: TOwnerEvents);
var
  i: Integer;
  Node: PVirtualNode;
  Data: PGridData;
  aCnt: Integer;
  aPk : TDateTime;
  aDc : string;
  aFl : Boolean;
begin
  ReleaseTreeNodes(vtEvents);
  if (Value = nil) then exit;
  aCnt := Value.Count;
  if (aCnt = 0) then aCnt := 1;
  aPk := 0;
  aDc := '';
  aFl := False;
  vtEvents.BeginUpdate;
  try
    for i := 0 to aCnt - 1 do
    begin
      Node := vtEvents.AddChild(nil);
      if Node <> nil then
      begin
        Data := vtEvents.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data.Level   := 0;
          Data.Node    := Node;
          Data.DataRow := TDataRow.Create(nil);
          if (Value.Count > 0) then
          begin
            aPk := Value.Items[i].PkOwnerEvent;
            aDc := Value.Items[i].DscEvt;
            aFl := Value.Items[i].FlagIncEvt;
          end;
          Data^.DataRow.AddAs('PK_CADASTROS_EVENTOS', aPk, ftDateTime, SizeOf(TDateTime));
          Data^.DataRow.AddAs('DSC_EVT', aDc, ftString,   51);
          Data^.DataRow.AddAs('FLAG_INC_EVT', Ord(aFl), ftInteger, SizeOf(Integer));
        end;
      end;
    end;
  finally
    vtEvents.EndUpdate;
  end;
end;

procedure TfrmOwners.vtCategoryChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
  aStt: TDBMode;
  aTyp: TCategoryType;
begin
  aStt := dbmBrowse;
  if (Node = nil) or (ScrState in LOADING_MODE) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Pk > 0) then
  begin
    aTyp := TCategoryType(Data^.DataRow.FieldByName['FLAG_CAT'].AsInteger);
    if (Node.CheckState = csUnCheckedNormal) then
    begin
      dmSysCad.DeleteCategoryLink(Pk, Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger);
      if (aTyp in [ctCustomer, ctSupplier, ctEmployee]) then
        aStt := dbmDelete;
    end
    else
      if (Node.CheckState = csMixedNormal) then
        dmSysCad.UpdateCategoryLink(Pk, Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger)
      else
        if (Node.CheckState = csCheckedNormal) then
        begin
          dmSysCad.InsertCategoryLink(Pk,
            Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger,
            Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger);
          if (aTyp in [ctCustomer, ctSupplier, ctEmployee]) then
            aStt := dbmInsert;
        end;
  end
  else
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(ScrState);
  if (aStt in UPDATE_MODE) then
    SetNewVisibleTypes(aStt);
end;

procedure TfrmOwners.vtCategoryGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column = 0) then
    CellText := Data^.DataRow.FieldByName['DSC_CAT'].AsString;
end;

procedure TfrmOwners.vtCategoryInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
  aCategory: TCategoryType;
begin
  if (Node = nil) then exit;
  Node.CheckType := ctCheckBox;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger = 0) then
    Node.CheckState := csUncheckedNormal
  else
    if (Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger = 0) then
      Node.CheckState := csMixedNormal
    else
      Node.CheckState := csCheckedNormal;
  aCategory := TCategoryType(Data^.DataRow.FieldByName['FLAG_CAT'].AsInteger);
//0 ==> Clientes
//1 ==> Fornecedores
//2 ==> Funcionários
//3 ==> Representantes
//4 ==> Agentes
//5 ==> Outros
  if (not (aCategory in OwnerTypes)) then
    Node.States   := Node.States + [vsDisabled]
  else
    if (vsDisabled in Node.States) then
      Node.States := Node.States - [vsDisabled];
end;

procedure TfrmOwners.vtPhonesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['DSC_CNT'].AsString;
    1: CellText := MaskDoFormatText(S_PHONE_MASK, Data^.DataRow.FieldByName['CNT_CNT'].AsString, ' ');
  end;
end;

procedure TfrmOwners.vtPhonesInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Node.CheckType := ctRadioButton;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 0) then
    Node.CheckState := csUncheckedNormal
  else
    Node.CheckState := csCheckedNormal;
end;

procedure TfrmOwners.vtPhonesChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if (Loading) then exit;
  if (Node = nil) then exit;
  Node.CheckType := ctRadioButton;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ChangeGlobal(Sender);
  if (Node.CheckState = csCheckedNormal) then
    Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger := 1
  else
    Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger := 0;
end;

procedure TfrmOwners.vtEventsChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ChangeGlobal(Sender);
  if Node.CheckState = csCheckedNormal then
  begin
    Data^.DataRow.FieldByName['FLAG_INC_EVT'].AsInteger := 1;
//  if (Pk > 0) then
//    dmSysCad.InsertEventOnSchedule(ActiveEvent);
  end
  else
  begin
    Data^.DataRow.FieldByName['FLAG_INC_EVT'].AsInteger := 0;
//  if (Pk > 0) then
//    dmSysCad.DeleteEventOnSchedule(ActiveEvent);
  end;
end;

procedure TfrmOwners.vtEventsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: if (Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsDateTime = 0) then
         CellText := ''
       else
         CellText := Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DSC_EVT'].AsString;
  end;
end;

procedure TfrmOwners.vtEventsInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Node.CheckType := ctCheckBox;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Node.CheckState := csUnCheckedNormal;
  if Data^.DataRow.FieldByName['FLAG_INC_EVT'].AsInteger = 1 then
    Node.CheckState := csCheckedNormal;
end;

procedure TfrmOwners.vtEventsNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PGridData;
  R   : TRect;
  S   : string;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ChangeGlobal(Sender);
  case Column of
    0: if (NewText <> '') then
         if (StrToDateDef(NewText, 0) = 0) then
           S := 'Data Inválida!!'
         else
           Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsDateTime := StrToDate(NewText)
       else
         Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsString := NewText;
    1: Data^.DataRow.FieldByName['DSC_EVT'].AsString := NewText;
  end;
  if (S <> '') then
  begin
    R := Sender.GetDisplayRect(Node, Column, False);
    R.BottomRight.Y := R.BottomRight.Y + Integer(vtPhones.DefaultNodeHeight);
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight, S);
  end;
end;

procedure TfrmOwners.vtInternetChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Node.CheckState = csCheckedNormal then
    Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger := 1;
  if Node.CheckState = csUnCheckedNormal then
    Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger := 0;
  ChangeGlobal(Sender);
end;

procedure TfrmOwners.vtInternetGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['DSC_END'].AsString;
    1: CellText := Data^.DataRow.FieldByName['END_CNT'].AsString;
  end;
end;

procedure TfrmOwners.vtInternetInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  Node.CheckType := ctRadioButton;
  Node.CheckState := csUnCheckedNormal;
  if (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 1) then
    Node.CheckState := csCheckedNormal;
end;

procedure TfrmOwners.vtPhoneListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: if Sender.GetNodeLevel(Node) = 0 then
         CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString
       else
         CellText := Data^.DataRow.FieldByName['DSC_CNT'].AsString;
    1: if Sender.GetNodeLevel(Node) = 0 then
         CellText := ''
       else
         CellText := MaskDoFormatText(S_PHONE_MASK, Data^.DataRow.FieldByName['CNT_CNT'].AsString, ' ');
  end;
end;

procedure TfrmOwners.eFlag_TCadSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  ChangeScreenData;
end;

procedure TfrmOwners.ChangeScreenData;
begin
  eDoc_Sec.EditMask        := '';
  lCrg_Cad.Caption         := ' Cargo: ';
  case TypeOwner of
    toCompany:
      begin
        eDoc_Pri.EditMask  := '00.000.000\/0000\-00;0; ';
        lDoc_Pri.Caption   := ' C.N.P.J.: ';
        lDoc_Sec.Caption   := ' I.E.: ';
        lCrg_Cad.Caption   := ' Área Atuação: ';
        lTrt_Cnt.Caption   := ' Ins.Mun.:';
        if (State <> '') then eDoc_Sec.EditMask := Mascara_Inscricao(State);
      end;
    toPeople:
      begin
        lDoc_Pri.Caption   := ' C.P.F.:';
        lDoc_Sec.Caption   := ' R.G.:';
        eDoc_Pri.EditMask  := '000.000.000\-00;0; ';
        lTrt_Cnt.Caption   := ' Tratam.:';
      end;
  else
    begin
      lDoc_Pri.Caption     := 'Doc. Prim.:';
      lDoc_Sec.Caption     := 'Doc. Sec.:';
      eDoc_Pri.EditMask    := '';
    end;
  end;
  lFk_Contatos.Visible     := (TypeOwner <> toCompany);
  eFk_Contatos.Visible     := (TypeOwner <> toCompany);
  tsContactList.TabVisible := (TypeOwner = toCompany);
  if (TypeOwner = toCompany) then
    LoadListPhones;
end;

procedure TfrmOwners.eFk_PaisesSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Paises do
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
      LoadStates;
end;

procedure TfrmOwners.eFk_EstadosSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Estados do
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
    begin
      LoadCities;
      if (TypeOwner = toCompany) then
        eDoc_Sec.EditMask := Mascara_Inscricao(State);
    end;
end;

function TfrmOwners.GetContact: Integer;
begin
  with eFk_Contatos do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOwner(Items.Objects[ItemIndex]).PkCadastros;
  end;
end;

procedure TfrmOwners.SetContact(const Value: Integer);
begin
  with eFk_Contatos do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromObjectValue(Value);
  end;
end;

procedure TfrmOwners.vtSearchBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if (Node = nil) or (Sender.GetNodeLevel(Node) > 0) then exit;
  if (Odd(Node.Index)) then
  begin
    TargetCanvas.Brush.Color := clSkyBlue;
    ItemColor                := clSkyBlue;
  end
  else
  begin
    TargetCanvas.Brush.Color := clInfoBk;
    ItemColor                := clInfoBk;
  end;
  EraseAction := eaColor;
end;

procedure TfrmOwners.eFk_Tipo_AliasExit(Sender: TObject);
var
  i: Integer;
begin
  with eFk_Tipo_Alias do
  begin
    if (ItemIndex = -1) and (Text <> '') and
       (not dmSysCad.ValidateAlias(Text)) then
    begin
      i := dmSysCad.SaveAlias(Text);
      i := Items.AddObject(Text, TObject(i));
      ItemIndex := i;
    end
  end;
end;

function  TfrmOwners.CheckQtdDocuments(AType: TTypeDocs): Boolean;
var
  aQtd: Integer;
  aDoc: string;
  aCtl: TControl;
  aPk : Integer;
const
  DOCS_MSG: array [TTypeDocs] of string =
    ('Atenção: Já existe(m) %d cadastro(s) com este ' +
      'número de documento!' + NL + 'Este tipo de redundância somente pode ' +
      'ser utilizada ' + NL + 'se o cadastro for um produtor rural com ' + NL +
      'mais de uma propriedade',

      'Atenção: Já existe(m) %d cadastro(s) com este número de documento!',

      'Erro: Cadastro existente com os números de documentos informados (%d / %s)');
begin
  Result := True;
  aCtl   := nil;
  case AType of
    tdPrimary  :
    begin
      aDoc := CPF_CGC;
      aCtl := eDoc_Pri;
    end;
    tdSecondary:
    begin
      aDoc := IE_RG;
      aCtl := eDoc_Sec;
    end;
    tdBoth     :
    begin
      aDoc := CPF_CGC + '|' + IE_RG;
      aCtl := eDoc_Pri;
    end;
  end;
  aQtd := dmSysCad.CheckOwnerDocument(aDoc, aPk, AType);
  if ((aQtd > 0) and (ScrState = dbmInsert)) or ((aQtd > 1) and (ScrState = dbmEdit)) then
  begin
    Result := False;
    if (AType = tdBoth) then
      Dados.DisplayHint(aCtl, Format(DOCS_MSG[AType], [aPk, aDoc]), hiError)
    else
      Dados.DisplayHint(aCtl, Format(DOCS_MSG[AType], [aQtd]), hiInformation, '', 10000);
  end;
end;

procedure TfrmOwners.eDoc_PriExit(Sender: TObject);
begin
  if (ScrState = dbmEdit) then exit;
  if (eDoc_Pri.Text <> '') and (eDoc_Sec.Text <> '') then
    if (not CheckQtdDocuments(tdBoth)) and (eDoc_Pri.CanFocus) then
      eDoc_Pri.SetFocus
    else
  else
    if (eDoc_Pri.Text <> '')  then
      CheckQtdDocuments(tdPrimary)
end;

procedure TfrmOwners.eDoc_SecExit(Sender: TObject);
begin
  if (ScrState = dbmEdit) then exit;
  if (eDoc_Pri.Text <> '') and (eDoc_Sec.Text <> '') then
    if (not CheckQtdDocuments(tdBoth)) and (eDoc_Pri.CanFocus) then
      eDoc_Pri.SetFocus
    else
  else
    if (eDoc_Sec.Text <> '')  and (not CheckQtdDocuments(tdSecondary)) and
       (eDoc_Sec.CanFocus) then
      eDoc_Sec.SetFocus;
end;

procedure TfrmOwners.TreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node  : PVirtualNode;
  Data  : PGridData;
  aTree : TVirtualStringTree;
  aTpTr : TTypeTree;
  aField: string;
begin
  aTree := TVirtualStringTree(Sender);
  if (aTree.Name = 'vtPhones')   then
  begin
    aField := 'DSC_CNT';
    aTpTr  := ttPhone;
  end
  else
    if (aTree.Name = 'vtEvents')   then
    begin
      aField := 'PK_CADASTROS_EVENTOS';
      aTpTr  := ttEvent;
    end
    else
    begin
      aField := 'DSC_END';
      aTpTr  := ttInternet;
    end;
  Node := aTree.FocusedNode;
  if (Node = nil) then exit;
  Data := aTree.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Key of
    VK_UP   : if (aTree.RootNodeCount > 1) then
                if (aTree.GetFirst = Node) then
                  aTree.FocusedNode := aTree.GetLast
                else
                  if (Data^.DataRow.FieldByName[aField].AsString = '') then
                    DeleteNode(aTree, Node);
    VK_DOWN : if (Data^.DataRow.FieldByName[aField].AsString = '') then
                if (aTree.RootNodeCount > 1) then
                  DeleteNode(aTree, Node)
                else
                  Data^.DataRow.ClearFieldValues
              else
                if (aTree.GetLast = Node) then
                  CreateNewNode(aTree, aTpTr);
//      aTree.EditNode(aTree.FocusedNode, aTree.FocusedColumn);
  else
    if (not (ssShift in Shift)) and (ssCtrl in Shift) and (Key = VK_DELETE) then
      DeleteNode(aTree, Node);
  end;
end;

procedure TfrmOwners.vtPhonesNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PGridData;
  R   : TRect;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ChangeGlobal(Sender);
  if (NewText <> '') and (Length(NewText) > 30) then
  begin
    R := Sender.GetDisplayRect(Node, Column, False);
    R.BottomRight.Y := R.BottomRight.Y + Integer(vtPhones.DefaultNodeHeight);
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight, 'Tamanho máximo do campo é de 30 caracteres');
    exit;
  end;
  case Column of
    0: Data^.DataRow.FieldByName['DSC_CNT'].AsString := Copy(NewText, 1, 30);
    1: Data^.DataRow.FieldByName['CNT_CNT'].AsString := Copy(NewText, 1, 30);
  end;
end;

procedure TfrmOwners.CreateNewNode(Sender: TVirtualStringTree; ATree: TTypeTree);
var
  Node: PVirtualNode;
  Data: PGridData;
  procedure CreatePhoneDataRow;
  begin
    Data^.DataRow.AddAs('FLAG_DEF', 0, ftInteger, SizeOf(Integer));
    Data^.DataRow.AddAs('DSC_CNT', '', ftString, 31);
    Data^.DataRow.AddAs('CNT_CNT', '', ftString, 31);
    Data^.DataRow.AddAs('PK_CADASTROS_CONTATOS', 0, ftInteger, SizeOf(Integer));
  end;
  procedure CreateEventDataRow;
  begin
    Data^.DataRow.AddAs('PK_CADASTROS_EVENTOS', 0, ftDateTime, SizeOf(TDateTime));
    Data^.DataRow.AddAs('DSC_EVT', '', ftString,   51);
    Data^.DataRow.AddAs('FLAG_INC_EVT', Ord(False), ftInteger, SizeOf(Integer));
  end;
  procedure CreateInternetDataRow;
  begin
    Data^.DataRow.AddAs('FLAG_DEF', Ord(False), ftInteger, SizeOf(Integer));
    Data^.DataRow.AddAs('DSC_END', '', ftString, 31);
    Data^.DataRow.AddAs('END_CNT', '', ftString, 101);
  end;
begin
  ChangeGlobal(Self);
  Sender.BeginUpdate;
  try
    Node := Sender.AddChild(nil);
    if (Node <> nil) then
    begin
      Data := Sender.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level   := 0;
        Data^.Node    := Node;
        Data^.DataRow := TDataRow.Create(nil);
        case ATree of
          ttPhone   : CreatePhoneDataRow;
          ttEvent   : CreateEventDataRow;
          ttInternet: CreateInternetDataRow;
        end;
      end;
    end;
  finally
    Sender.EndUpdate;
  end;
  Sender.FocusedNode    := Node;
  Sender.FocusedColumn  := 0;
  Sender.Selected[Node] := True;
  Sender.EditNode(Node, 0)
end;

procedure TfrmOwners.DeleteNode(Sender: TVirtualStringTree; ANode: PVirtualNode);
var
  Data: PGridData;
begin
  ChangeGlobal(Self);
  if (ANode = nil) then exit;
  if Sender.IsEditing then Sender.EndEditNode;
  Data := Sender.GetNodeData(ANode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Data^.Node := nil;
  Data^.DataRow.Free;
  Data^.DataRow := nil;
  Sender.DeleteNode(ANode);
end;

procedure TfrmOwners.vtInternetNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PGridData;
  R   : TRect;
  aMax: Integer;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ChangeGlobal(Sender);
  aMax := 30;
  if (Column = 1) then aMax := 100;
  if (NewText <> '') and (Length(NewText) > aMax) then
  begin
    R := Sender.GetDisplayRect(Node, Column, False);
    R.BottomRight.Y := R.BottomRight.Y + Integer(vtPhones.DefaultNodeHeight);
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight,
      Format('Tamanho máximo do campo é de %d caracteres', [aMax]));
    exit;
  end;
  case Column of
    0: Data^.DataRow.FieldByName['DSC_END'].AsString := Copy(NewText, 1, 30);
    1: Data^.DataRow.FieldByName['END_CNT'].AsString := Copy(NewText, 1, 100);
  end;
end;

procedure TfrmOwners.LoadListPhones;
var
  Data: PGridData;
  aStr: string;
  Node: PVirtualNode;
  function AddNodeData(ANode: PVirtualNode): PVirtualNode;
  begin
    Result := vtPhoneList.AddChild(ANode);
    if (Result <> nil) then
    begin
      Data := vtPhoneList.GetNodeData(Result);
      if (Data <> nil) then
      begin
        Data^.Level   := vtPhoneList.GetNodeLevel(Result);
        Data^.Node    := Result;
        Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysCad.qrSqlAux, True);
      end;
    end;
  end;
begin
  ReleaseTreeNodes(vtPhoneList);
  aStr := '';
  Node := nil;
  with dmSysCad do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlAllContacts);
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('PkCadastros').AsInteger := Pk;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.Eof) do
      begin
        if (aStr <> qrSqlAux.FieldByName('RAZ_SOC').AsString) then
          Node := AddNodeData(nil);
        AddNodeData(Node);
        aStr := qrSqlAux.FieldByName('RAZ_SOC').AsString;
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
  vtPhoneList.FullExpand;
end;

procedure TfrmOwners.vtPhoneListPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 1) and
     (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 1) then
    TargetCanvas.Font.Color := clBlue
  else
    TargetCanvas.Font.Color := clWindowText;
end;

procedure TfrmOwners.vtCategoryChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  Data: PGridData;
begin
  if (Node = nil) or (ScrState in LOADING_MODE) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Allowed := True;
  case Node.CheckState of
    csUncheckedNormal:
      begin
        Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger := Pk;
        Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger := 1;
        NewState := csCheckedNormal;
      end;
    csCheckedNormal  :
      begin
        Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger := Pk;
        Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger := 0;
        NewState := csMixedNormal;
      end;
    csMixedNormal    :
      begin
        Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger := 0;
        Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger := 0;
        NewState := csUncheckedNormal;
      end;
  end;
end;

procedure TfrmOwners.eFk_ContatosDblClick(Sender: TObject);
begin
  with eFk_Contatos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Pk := TOwner(Items.Objects[ItemIndex]).PkCadastros;
end;

procedure TfrmOwners.vtPhoneListDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtPhoneList.FocusedNode;
  if (Node = nil) then exit; // or (vtPhoneList.GetNodeLevel(Node) = 0) then exit;
  Data := vtPhoneList.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['PK_CADASTROS'].AsInteger > 0) then
    Pk := Data^.DataRow.FieldByName['PK_CADASTROS'].AsInteger;
end;

procedure TfrmOwners.DefaultData;
var
  aStr: TStrings;
  aCat: TCategories;
  aFon: TPhones;
  aNet: TInternetAddresses;
  aEvt: TOwnerEvents;
begin
  aStr    := TStringList.Create;
  aStr.Add('Teste de observação');
  aStr.Add('Teste de observação');
  aCat    := TCategories.Create(Self);
  with aCat.Add do
  begin
    DscCat     := 'CLIENTES';
    FlagCat    := TCategoryType(0);
    FlagAtv    := True;
    PkCategory := 1;
    cbIndex    := Ord(dbmInsert);
  end;
  aFon   := TPhones.Create(Self);
  with aFon.Add do
  begin
    DscPhone   := 'Celular';
    FonCad     := '5499667591';
    FlagDef    := True;
  end;
  with aFon.Add do
  begin
    DscPhone   := 'Empresa';
    FonCad     := '5432868244';
    FlagDef    := False;
  end;
  aNet := TInternetAddresses.Create(Self);
  with aNet.Add do
  begin
    DscEnd  := 'e-mail';
    EndCnt  := 'alcindo@sistemaprocessa.com.br';
    FlagDef := True;
  end;
  with aNet.Add do
  begin
    DscEnd  := 'página html';
    EndCnt  := 'http://www.processa.org';
    FlagDef := True;
  end;
  aEvt := TOwnerEvents.Create(Self);
  with aEvt.Add do
  begin
    PkOwnerEvent := StrToDate('23/01/1966');
    FlagIncEvt   := False;
    DscEvt       := 'Aniversário';
  end;
  with aEvt.Add do
  begin
    PkOwnerEvent := StrToDate('23/01/1993');
    FlagIncEvt   := False;
    DscEvt       := 'Casamento';
  end;
  try
    TypeOwner   := toPeople;
    ChangeScreenData;
    Title       := 'Sr.';
    CPF_CGC     := '44636776020';
    IE_RG       := '118.170 SSP/MS';
    NameOwner   := 'ALCINDO SCHLEDER';
    FkAlias     := 8;
    Contact     := 0;
    Position    := 'ANALISTA DE SISTEMAS';
    Country     := 27;
    State       := 'RS';
    City        := 69663;
    Address     := 'DEMÉTRIO P. DOS SANTOS, 705';
    CmplAddress := 'B. PLANALTO';
    NumbAddress := 705;
    ZipCode     := 95670000;
    PostalBox   := '';
    Observation := aStr;
    Category    := aCat;
    Phones      := aFon;
    OwnerEvents := aEvt;
    NetAddr     := aNet;
//    iImg_Cad.Picture.LoadFromFile('C:\Documents and Settings\Alcindo\Meus documentos\Minhas imagens\Fotos\Costelão Campeiro 13-01\DSC01488.JPG');
  finally
    Loading := False;
    FreeAndNil(aStr);
    FreeAndNil(aCat);
    FreeAndNil(aFon);
    FreeAndNil(aNet);
    FreeAndNil(aEvt);
  end;
end;

procedure TfrmOwners.SetNewVisibleTypes(const AState: TDBMode);
var
  Node: PVirtualNode;
  Data: PGridData;
  aTpO: TOwnerTypes;
  i   : integer;
begin
  if (AState = dbmBrowse) then exit;
  for i := 0 to pgCategory.PageCount - 1 do
    pgCategory.Pages[i].TabVisible := False;
  aTpO := [ctRepresentant, ctAgent, ctOthers];
  with vtCategory do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
       if (Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger > 0) and
          (TCategoryType(Data^.DataRow.FieldByName['FLAG_CAT'].AsInteger) in FOwnerTypes) then
         aTpo := aTpo + [TCategoryType(Data^.DataRow.FieldByName['FLAG_CAT'].AsInteger)];
      Node := GetNext(Node);
    end;
  end;
  VisibleTypes := aTpO;
end;

initialization
  RegisterClass(TfrmOwners);

end.


