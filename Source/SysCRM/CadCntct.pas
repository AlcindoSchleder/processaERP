unit CadCntct;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 15/02/2004 - DD/MM/YYYY                                      *}
{* Modified: 15/02/2004 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
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
  Dialogs, Buttons, ExtCtrls, ComCtrls, StdCtrls, vpBase, vpData, VpBaseDS,
  VirtualTrees, Menus, ProcUtils, Mask, ToolEdit, CurrEdit, PrcCombo, TSysCad,
  vpConst, vpSR, TSysCadAux, AutoEdit;

type
  TCdContacts = class(TForm)
    pButtons: TPanel;
    sbOk: TSpeedButton;
    sbCancel: TSpeedButton;
    pgEvents: TPageControl;
    tsBasicData: TTabSheet;
    lName: TStaticText;
    eName: TEdit;
    eTitle: TEdit;
    lTitle: TStaticText;
    lCompany: TStaticText;
    lPosition: TStaticText;
    ePosition: TEdit;
    pHeader: TPanel;
    stStatus: TStaticText;
    stCaption: TStaticText;
    pgContacts: TPageControl;
    tsPhones: TTabSheet;
    pmContacts: TPopupMenu;
    pmNew: TMenuItem;
    tsAddress: TTabSheet;
    lAddress: TStaticText;
    eAddress: TEdit;
    lCountry: TStaticText;
    lState: TStaticText;
    lCity: TStaticText;
    lZipCode: TStaticText;
    lNumEnd: TStaticText;
    eNumEnd: TCurrencyEdit;
    lTypeCad: TRadioGroup;
    lDocPri: TStaticText;
    eDocPri: TMaskEdit;
    lDocSec: TStaticText;
    eDocSec: TMaskEdit;
    lNomFan: TStaticText;
    lCmpEnd: TStaticText;
    eCmpEnd: TEdit;
    lCxpCad: TStaticText;
    eCxpCad: TEdit;
    mNotes: TMemo;
    stNotes: TStaticText;
    eZipCode: TCurrencyEdit;
    cbCountry: TPrcComboBox;
    cbState: TPrcComboBox;
    cbCity: TPrcComboBox;
    cbCompany: TPrcComboBox;
    tsCategories: TTabSheet;
    pgList: TPageControl;
    tsList: TTabSheet;
    tsData: TTabSheet;
    vtPhones: TVirtualStringTree;
    cbPhone: TComboBox;
    sbDelete: TSpeedButton;
    sbIgnore: TSpeedButton;
    sbNew: TSpeedButton;
    vtCategory: TVirtualStringTree;
    pmMoveUp: TMenuItem;
    pmMoveDown: TMenuItem;
    N1: TMenuItem;
    ePhone: TMaskEdit;
    tsUsers: TTabSheet;
    vtUsers: TVirtualStringTree;
    tsComplements: TTabSheet;
    Splitter1: TSplitter;
    pgDataEvents: TPageControl;
    tsEventsGrid: TTabSheet;
    tsEventsData: TTabSheet;
    vtEvents: TVirtualStringTree;
    pgInternetAddress: TPageControl;
    tsAddressGrid: TTabSheet;
    tsAddressData: TTabSheet;
    vtInternet: TVirtualStringTree;
    sbNewEvent: TSpeedButton;
    sbCancelEvent: TSpeedButton;
    sbDeleteEvent: TSpeedButton;
    sbNewAddr: TSpeedButton;
    sbCancelAddr: TSpeedButton;
    sbDeleteAddr: TSpeedButton;
    lDsc_Evt: TStaticText;
    eDsc_Evt: TEdit;
    lPk_Cadastros_Eventos: TStaticText;
    ePk_Cadastros_Eventos: TDateEdit;
    lFlag_Inc_Evt: TCheckBox;
    lEnd_Cnt: TStaticText;
    eEnd_Cnt: TEdit;
    lDsc_End: TStaticText;
    eDsc_End: TEdit;
    lFlag_TCnt_Int: TStaticText;
    eFlag_TCnt_Int: TPrcComboBox;
    eNickName: TPrcComboBox;
    tsPhoneList: TTabSheet;
    vtPhoneList: TVirtualStringTree;
    procedure sbOkClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure eGlobalChange(Sender: TObject);
    procedure vtPhonesFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtPhonesGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtPhonesDblClick(Sender: TObject);
    procedure cbCountrySelect(Sender: TObject);
    procedure cbStateSelect(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure pmNewClick(Sender: TObject);
    procedure sbIgnoreClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lTypeCadClick(Sender: TObject);
    procedure vtCategoryInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtCategoryGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtUsersInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtUsersGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtCategoryChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtUsersChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtEventsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtEventsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtEventsChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtInternetGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtInternetInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtInternetChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtInternetChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure pgDataEventsChange(Sender: TObject);
    procedure sbNewEventClick(Sender: TObject);
    procedure sbCancelEventClick(Sender: TObject);
    procedure sbDeleteEventClick(Sender: TObject);
    procedure lFlag_Inc_EvtClick(Sender: TObject);
    procedure pgInternetAddressChange(Sender: TObject);
    procedure eFlag_TCnt_IntSelect(Sender: TObject);
    procedure sbNewAddrClick(Sender: TObject);
    procedure vtInternetGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure sbCancelAddrClick(Sender: TObject);
    procedure sbDeleteAddrClick(Sender: TObject);
    procedure eNickNameSearchListChange(Sender: TObject);
    procedure pgContactsChange(Sender: TObject);
    procedure vtPhoneListGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    { Private declarations }
    FActiveOwner: TOwner;
    FContact    : TVpContact;
    FResource   : TvpResource;
    FAliasSaved : Boolean;
    FLoading    : Boolean;
    FScrMode    : TDBMode;
    procedure LoadCaptions;
    procedure PopulateDialog;
    procedure DePopulateDialog;
    procedure SetScrMode(AValue: TDBMode);
    procedure LoadGridPhone;
    procedure LoadGridCategory;
    procedure LoadGridUsers;
    procedure LoadGridEvents;
    procedure LoadGridNetAddr;
    procedure SetActiveOwner(AValue: TOwner);
    procedure SetContact(AValue: TvpContact);
    procedure SetContactToOwner;
    function  GetTitle: string;
    procedure SetTitle(AValue: string);
    function  GetTypeOwner: TTypeOwner;
    procedure SetTypeOwner(AValue: TTypeOwner);
    function  GetCPF_CGC: string;
    procedure SetCPF_CGC(AValue: string);
    function  GetIE_RG: string;
    procedure SetIE_RG(AValue: string);
    function  GetNameOwner: string;
    procedure SetNameOwner(AValue: string);
    function  GetNickName: string;
    procedure SetNickName(AValue: string);
    function  GetFkAlias: Integer;
    procedure SetFkAlias(AValue: Integer);
    function  GetCompany: Integer;
    procedure SetCompany(AValue: Integer);
    function  GetPosition: string;
    procedure SetPosition(AValue: string);
    function  GetCategory: TCategories;
    procedure SetCategory(AValue: TCategories);
    function  GetPhones: TPhones;
    procedure SetPhones(AValue: TPhones);
    function  GetCountry: TCountry;
    procedure SetCountry(AValue: TCountry);
    function  GetState: TState;
    procedure SetState(AValue: TState);
    function  GetCity: TCity;
    procedure SetCity(AValue: TCity);
    function  GetAddress: string;
    procedure SetAddress(AValue: string);
    function  GetCmplAddress: string;
    procedure SetCmplAddress(AValue: string);
    function  GetNumbAddress: Integer;
    procedure SetNumbAddress(AValue: Integer);
    function  GetZipCode: Integer;
    procedure SetZipCode(AValue: Integer);
    function  GetPostalBox: string;
    procedure SetPostalBox(AValue: string);
    function  GetObservation: TStrings;
    procedure SetObservation(AValue: TStrings);
    function  GetPkCadEvt: TDate;
    procedure SetPkCadEvt(AValue: TDate);
    function  GetDscEvt: string;
    procedure SetDscEvt(AValue: string);
    function  GetFlagIncEvt: Boolean;
    procedure SetFlagIncEvt(AValue: Boolean);
    function  GetFlagTCntInt: TTypeInternetAddress;
    procedure SetFlagTCntInt(AValue: TTypeInternetAddress);
    function  GetEndCnt: string;
    procedure SetEndCnt(AValue: string);
    function  GetDscEnd: string;
    procedure SetDscEnd(AValue: string);
    function  GetNetAddr: TInternetAddresses;
    function  GetOwnerEvents: TOwnerEvents;
    procedure SetMaskToDocSet(AUF: string);
    procedure SetOwnerCategories;
    procedure SetOwnerResources;
    procedure GetPhoneList;
  public
    { Public declarations }
    constructor Create(AFrame: TControl; AMode: TDBMode; AContact: TVpContact;
       AResource: TVpResource; ASuper: Boolean = False); reintroduce;
    property Contact    : TvpContact     read FContact       write SetContact;
    property ActiveOwner: TOwner         read FActiveOwner   write SetActiveOwner;
    property AliasSaved : Boolean        read FAliasSaved    write FAliasSaved;
    property Resource   : TVpResource    read FResource      write FResource;
    property ScrMode    : TDBMode        read FScrMode       write SetScrMode;
    property Title      : string         read GetTitle       write SetTitle;
    property TypeOwner  : TTypeOwner     read GetTypeOwner   write SetTypeOwner;
    property CPF_CGC    : string         read GetCPF_CGC     write SetCPF_CGC;
    property IE_RG      : string         read GetIE_RG       write SetIE_RG;
    property NameOwner  : string         read GetNameOwner   write SetNameOwner;
    property NickName   : string         read GetNickName    write SetNickName;
    property FkAlias    : Integer        read GetFkAlias     write SetFkAlias;
    property Company    : Integer        read GetCompany     write SetCompany;
    property Position   : string         read GetPosition    write SetPosition;
    property Category   : TCategories    read GetCategory    write SetCategory;
    property Phones     : TPhones        read GetPhones      write SetPhones;
    property Country    : TCountry       read GetCountry     write SetCountry;
    property State      : TState         read GetState       write SetState;
    property City       : TCity          read GetCity        write SetCity;
    property Address    : string         read GetAddress     write SetAddress;
    property CmplAddress: string         read GetCmplAddress write SetCmplAddress;
    property NumbAddress: Integer        read GetNumbAddress write SetNumbAddress;
    property ZipCode    : Integer        read GetZipCode     write SetZipCode;
    property PostalBox  : string         read GetPostalBox   write SetPostalBox;
    property Observation: TStrings       read GetObservation write SetObservation;
    property PkCadEvt   : TDate          read GetPkCadEvt    write SetPkCadEvt;
    property DscEvt     : string         read GetDscEvt      write SetDscEvt;
    property FlagIncEvt : Boolean        read GetFlagIncEvt  write SetFlagIncEvt;
    property FlagTCntInt: TTypeInternetAddress read GetFlagTCntInt write SetFlagTCntInt;
    property EndCnt     : string         read GetEndCnt      write SetEndCnt;
    property DscEnd     : string         read GetDscEnd      write SetDscEnd;
    property NetAddr    : TInternetAddresses read GetNetAddr;
    property OwnerEvents: TOwnerEvents   read GetOwnerEvents;
  end;

var
  CdContacts: TCdContacts;

implementation

uses Dado, CmmConst, ProcType, GridRow, DB, mSysCrm, FuncoesDB, MaskUtils,
  StrUtils, Funcoes, vpMisc, CrmAgent, ArqSqlCrm, DateUtils;

{$R *.dfm}

const
  S_TYPES_ADDR_INTERNET: array [0..4] of string =
    ('Endereço Web', 'Endereço de e-Mail', 'Endereço de FTP',
     'Endereço de Messenger', 'Outros');

constructor TCdContacts.Create(AFrame: TControl; AMode: TDBMode;
  AContact: TVpContact; AResource: TVpResource; ASuper: Boolean = False);
begin
  inherited Create(AFrame);
  vtPhones.NodeDataSize   := SizeOf(TGridData);
  vtCategory.NodeDataSize := SizeOf(TGridData);
  vtUsers.NodeDataSize    := SizeOf(TGridData);
  vtEvents.NodeDataSize   := SizeOf(TGridData);
  vtInternet.NodeDataSize := SizeOf(TGridData);
  FActiveOwner            := TOwner.Create;
  tsUsers.TabVisible      := ASuper;
  FResource               := AResource;
  if (AContact = nil) or (AContact.RecordID = 0) then
    Contact               := nil
  else
    Contact               := AContact;
  ScrMode                 := AMode;
end;

procedure TCdContacts.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  LoadCaptions;
  pgEvents.Images          := Dados.Image16;
  pgDataEvents.Images      := Dados.Image16;
  pgInternetAddress.Images := Dados.Image16;
  pmContacts.Images        := Dados.Image16;
  vtPhones.Images          := Dados.Image16;
  vtPhones.Header.Images   := Dados.Image16;
  vtUsers.Images           := Dados.Image16;
  vtUsers.Header.Images    := Dados.Image16;
  vtCategory.Images        := Dados.Image16;
  vtCategory.Header.Images := Dados.Image16;
  vtEvents.Images          := Dados.Image16;
  vtEvents.Header.Images   := Dados.Image16;
  vtInternet.Images        := Dados.Image16;
  vtInternet.Header.Images := Dados.Image16;
  vtPhoneList.NodeDataSize  := SizeOf(TGridData);
  vtPhoneList.Images        := Dados.Image16;
  vtPhoneList.Header.Images := Dados.Image16;
  pgContacts.Images        := Dados.Image16;
  Dados.Image16.GetBitmap(16, sbOk.Glyph);
  Dados.Image16.GetBitmap(33, sbCancel.Glyph);
  Dados.Image16.GetBitmap(34, sbNew.Glyph);
  Dados.Image16.GetBitmap(28, sbIgnore.Glyph);
  Dados.Image16.GetBitmap(33, sbDelete.Glyph);
  Dados.Image16.GetBitmap(34, sbNewAddr.Glyph);
  Dados.Image16.GetBitmap(28, sbCancelAddr.Glyph);
  Dados.Image16.GetBitmap(33, sbDeleteAddr.Glyph);
  Dados.Image16.GetBitmap(34, sbNewEvent.Glyph);
  Dados.Image16.GetBitmap(28, sbCancelEvent.Glyph);
  Dados.Image16.GetBitmap(33, sbDeleteEvent.Glyph);
  tsBasicData.Caption := Dados.GetStringMessage(LANGUAGE, 'stsBasicData', 'Contato');
  tsAddress.Caption   := Dados.GetStringMessage(LANGUAGE, 'stsAddress', 'Endereço');
  eNickName.Items.AddStrings(dmSysCrm.LoadAlias);
  cbCountry.Items.AddStrings(dmSysCrm.LoadCountries); // Load Contries from table PAISES
  cbCompany.Items.AddStrings(dmSysCrm.LoadCompanies); // Load Companies from table CADASTROS
  for i := 0 to 4 do
    eFlag_TCnt_Int.Items.Add(S_TYPES_ADDR_INTERNET[i]);
//  PopulateDialog;
end;

procedure TCdContacts.FormShow(Sender: TObject);
begin
  pgEvents.ActivePageIndex   := 0;
  pgContacts.ActivePageIndex := 0;
  eName.SetFocus;
end;

procedure TCdContacts.FormDestroy(Sender: TObject);
begin
  cbCompany.ReleaseObjects;
  cbCountry.ReleaseObjects;
  cbState.ReleaseObjects;
  cbCity.ReleaseObjects;
  if Assigned(FActiveOwner) then
    FActiveOwner.Free;
  FActiveOwner := nil;
  FContact     := nil;
  ReleaseTreeNodes(vtPhones);
  ReleaseTreeNodes(vtCategory);
  ReleaseTreeNodes(vtUsers);
  ReleaseTreeNodes(vtEvents);
  ReleaseTreeNodes(vtInternet);
  ReleaseTreeNodes(vtPhoneList);
end;

procedure TCdContacts.sbOkClick(Sender: TObject);
var
  i: Integer;
begin
  if eName.Text = '' then
  begin
    Dados.DisplayMessage(RSNameIsRequired, hiError, [mbOK]);
    eName.SetFocus;
    exit;
  end;
  if (not FAliasSaved) then eNickNameSearchListChange(Self);
  i := -1;
  if (FScrMode in [dbmInsert, dbmEdit]) then
  begin
    DePopulateDialog;
    if (FActiveOwner.PkCadastros > 0) then
      for i := 0 to FResource.Contacts.Count - 1 do
        if (TVpContact(FResource.Contacts.ContactsList.Items[i]).RecordID =
           FActiveOwner.PkCadastros) then
          break;
    dmSysCrm.SaveAllContactData(FScrMode, FActiveOwner);
    if not Assigned(FContact) then
      FContact          := FResource.Contacts.AddContact(FActiveOwner.PkCadastros)
    else
      FContact.RecordID := FActiveOwner.PkCadastros;
    dmSysCrm.SetContactFromOwner(FActiveOwner, FResource, i);
    if (FScrMode = dbmInsert) then
    begin
      SetOwnerCategories;
      SetOwnerResources;
    end;
  end;
  Close;
end;

procedure TCdContacts.sbCancelClick(Sender: TObject);
begin
  if (ScrMode in UPDATE_MODE) then
    if (Dados.DisplayMessage('Deseja Salvar as Alterações?',
         hiQuestion, [mbYes, mbNo]) = mrYes) then
      sbOkClick(Sender);
  Close;
end;

procedure TCdContacts.LoadCaptions;
begin
  sbOK.Caption         := RSOKBtn;
  sbCancel.Caption     := RSCancelBtn;
  lName.Caption        := RSNameLbl;
  lTitle.Caption       := RSTitleLbl;
  lAddress.Caption     := RSAddressLbl;
  lCity.Caption        := RSCityLbl;
  lState.Caption       := RSStateLbl;
  lZipCode.Caption     := RSZipCodeLbl;
  lCountry.Caption     := RSCountryLbl;
  lCompany.Caption     := RSCompanyLbl;
  lPosition.Caption    := RSPositionLbl;
  tsCategories.Caption := RSCategoryLbl;
end;

procedure TCdContacts.PopulateDialog;
var
  j: TVpPhoneType;
begin
// mapping fields to the table CADASTROS that is in the TOwner Object
//  TOwner        ==> TvpContact.UserField0;
  FLoading    := True;
  FAliasSaved := False;
  Title       := FActiveOwner.Title;
  TypeOwner   := FActiveOwner.FlagTCad;
  CPF_CGC     := FActiveOwner.DocPri;
  IE_RG       := FActiveOwner.DocSec;
  if (FContact <> nil) then
    NameOwner   := AssembleName(FContact);
  NickName    := FActiveOwner.NomFan;
  Company     := FActiveOwner.FkContacts;
  Position    := FActiveOwner.AreaAtu;
  Country     := FActiveOwner.Address.FkCity.FkState.FkCountry;
  State       := FActiveOwner.Address.FkCity.FkState;
  City        := FActiveOwner.Address.FkCity;
  Address     := FActiveOwner.Address.EndAdd;
  CmplAddress := FActiveOwner.Address.CmpEnd;
  NumbAddress := FActiveOwner.Address.NumAdd;
  ZipCode     := FActiveOwner.Address.CepAdd;
  PostalBox   := FActiveOwner.Address.CxpAdd;
  Observation := FActiveOwner.ObsCad;
  LoadGridPhone;
  if tsCategories.TabVisible then LoadGridCategory;
  if tsUsers.TabVisible      then LoadGridUsers;
  for j := Low(TVpPhoneType) to High(TVpPhoneType) do
    cbPhone.Items.Add(PhoneLabel(j));
  LoadGridEvents;
  LoadGridNetAddr;
  cbCompany.Enabled := (FActiveOwner.FlagTCad = toPeople);
  FLoading := False;
end;

procedure TCdContacts.LoadGridEvents;
var
  i: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtEvents);
  vtEvents.BeginUpdate;
  try
    for i := 0 to FActiveOwner.OwnerEvents.Count - 1 do
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
          Data.DataRow.AddAs('PK_CADASTROS_EVENTOS',
            FActiveOwner.OwnerEvents.Items[i].PkOwnerEvent, ftDateTime, SizeOf(TDateTime));
          Data.DataRow.AddAs('DSC_EVT',
            FActiveOwner.OwnerEvents.Items[i].DscEvt, ftString,   51);
          Data.DataRow.AddAs('FLAG_INC_EVT',
            Integer(FActiveOwner.OwnerEvents.Items[i].FlagIncEvt), ftInteger, SizeOf(Integer));
        end;
      end;
    end;
  finally
    vtInternet.EndUpdate;
  end;
  if vtEvents.RootNodeCount = 0 then
    pgDataEvents.ActivePageIndex := 1;
end;

procedure TCdContacts.LoadGridNetAddr;
var
  i: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtInternet);
  vtInternet.BeginUpdate;
  try
    for i := 0 to FActiveOwner.InternetAddresses.Count - 1 do
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
          Data.DataRow.AddAs('FLAG_DEF',
            FActiveOwner.InternetAddresses.Items[i].FlagDef, ftInteger, SizeOf(Integer));
          Data.DataRow.AddAs('FLAG_TCNT_INT',
            Integer(FActiveOwner.InternetAddresses.Items[i].FlagTCntInt), ftInteger, SizeOf(Integer));
          Data.DataRow.AddAs('DSC_END',
            FActiveOwner.InternetAddresses.Items[i].DscEnd, ftString,   31);
          Data.DataRow.AddAs('END_CNT',
            FActiveOwner.InternetAddresses.Items[i].EndCnt, ftString,   101);
        end;
         vtInternet.FocusedNode := Node;
      end;
    end;
  finally
    vtInternet.EndUpdate;
  end;
  if vtInternet.RootNodeCount = 0 then
    pgInternetAddress.ActivePageIndex := 1;
end;

procedure TCdContacts.LoadGridPhone;
var
  i, a: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtPhones);
  vtPhones.BeginUpdate;
  try
    for i := 0 to FActiveOwner.Phones.Count - 1 do
    begin
      a := 0;
      Node := vtPhones.AddChild(nil);
      if Node <> nil then
      begin
        Data := vtPhones.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data.Level   := 0;
          Data.Node    := Node;
          Data.DataRow := TDataRow.Create(nil);
          Data.DataRow.AddAs('CODE_TYPE', a, ftInteger, SizeOf(Integer));
          Data.DataRow.AddAs('PHONE_IDX', i, ftInteger, SizeOf(Integer));
          Data.DataRow.AddAs('PHONE_TYPE', PhoneLabel(TVpPhoneType(a)), ftString,
            Length(PhoneLabel(TVpPhoneType(a))) + 1);
          Data.DataRow.AddAs('PHONE', FActiveOwner.Phones.Items[i].FonCad, ftString,
             Length(FActiveOwner.Phones.Items[i].FonCad) + 1);
        end;
         vtPhones.FocusedNode := Node;
      end;
    end;
  finally
    vtPhones.EndUpdate;
  end;
  sbNew.Enabled := vtPhones.RootNodeCount < 6;
  pmNew.Enabled := vtPhones.RootNodeCount < 6;
end;

procedure TCdContacts.LoadGridCategory;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtCategory);
  with dmSysCrm do
  begin
    if qrCategory.Active then qrCategory.Close;
    qrCategory.SQL.Clear;
    qrCategory.SQL.Add(SqlCategorias);
    Dados.StartTransaction(qrCategory);
    if (qrCategory.Params.FindParam('FkCadastros') <> nil) then
      qrCategory.ParamByName('FkCadastros').AsInteger := FActiveOwner.PkCadastros;
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
            Data.DataRow.AddAs('FLAG_ATV', qrCategory.FieldByName('FLAG_ATV').AsInteger,
              ftInteger, SizeOf(Integer));
            Data.DataRow.AddAs('FLAG_CAT', qrCategory.FieldByName('FLAG_CAT').AsInteger,
              ftInteger, SizeOf(Integer));
            Data.DataRow.AddAs('FK_CADASTROS', qrCategory.FieldByName('FK_CADASTROS').AsInteger,
              ftInteger, SizeOf(Integer));
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
end;

procedure TCdContacts.LoadGridUsers;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtUsers);
  with dmSysCrm do
  begin
    if qrResource.Active then qrResource.Close;
    qrResource.SQL.Clear;
    qrResource.SQL.Add(SqlResContact);
    Dados.StartTransaction(qrResource);
    qrResource.ParamByName('FkCadastros').AsInteger := ActiveOwner.PkCadastros;
    if not qrResource.Active then qrResource.Open;
    vtUsers.BeginUpdate;
    try
      while (not qrResource.Eof) do
      begin
        Node := vtUsers.AddChild(nil);
        if Node <> nil then
        begin
          Data := vtUsers.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data.Level   := 0;
            Data.Node    := Node;
            Data.DataRow := TDataRow.CreateFromDataSet(nil, qrResource, True);
          end;
        end;
        qrResource.Next;
      end;
    finally
      vtUsers.EndUpdate;
      if qrResource.Active then qrResource.Close;
      Dados.CommitTransaction(qrResource);
    end;
  end;
end;

procedure TCdContacts.DePopulateDialog;
begin
  FActiveOwner.Title                            := Title;
  FActiveOwner.FlagTCad                         := TypeOwner;
  FActiveOwner.DocPri                           := CPF_CGC;
  FActiveOwner.DocSec                           := IE_RG;
  FActiveOwner.NomFan                           := NickName;
  FActiveOwner.FkContacts                       := Company;
  FActiveOwner.AreaAtu                          := Position;
  FActiveOwner.Address.FkCity.FkState.FkCountry := Country;
  FActiveOwner.Address.FkCity.FkState           := State;
  FActiveOwner.Address.FkCity                   := City;
  FActiveOwner.Address.EndAdd                   := Address;
  FActiveOwner.Address.CmpEnd                   := CmplAddress;
  FActiveOwner.Address.NumAdd                   := NumbAddress;
  FActiveOwner.Address.CepAdd                   := ZipCode;
  FActiveOwner.Address.CxpAdd                   := PostalBox;
  FActiveOwner.ObsCad                           := Observation;
  FActiveOwner.RazSoc                           := NameOwner;
  GetPhones;
  GetCategory;
  GetNetAddr;
  GetOwnerEvents;
end;

procedure TCdContacts.eGlobalChange(Sender: TObject);
begin
  if FLoading then exit;
  if (FScrMode in [dbmInsert, dbmEdit]) then exit;
  if Contact.RecordID > 0 then
    ScrMode := dbmEdit
  else
    ScrMode := dbmInsert;
end;

procedure TCdContacts.vtPhonesFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  FLoading := True;
  ePhone.Text       := Data^.DataRow.FieldByName['PHONE'].AsString;
  cbPhone.ItemIndex := Data^.DataRow.FieldByName['CODE_TYPE'].AsInteger;
  FLoading := False;
end;

procedure TCdContacts.vtPhonesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['PHONE_TYPE'].AsString;
    1: CellText := MaskDoFormatText(S_PHONE_MASK, Data^.DataRow.FieldByName['PHONE'].AsString, ' ');
  end;
end;

procedure TCdContacts.vtPhonesDblClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vtPhones.FocusedNode;
  if (Node = nil) then exit;
  sbNew.Enabled := vtPhones.RootNodeCount < 6;
  pmNew.Enabled := vtPhones.RootNodeCount < 6;
  pgList.ActivePageIndex := 1;
end;

procedure TCdContacts.SetScrMode(AValue: TDBMode);
begin
  FScrMode              := AValue;
  stStatus.Color        := ColorMode[FScrMode];
  stStatus.Font.Color   := FontColorMode[FScrMode];
  stStatus.Caption      := ModeTypes[FScrMode];
  sbIgnore.Enabled      := (FScrMode in UPDATE_MODE);
  sbCancelAddr.Enabled  := (FScrMode in UPDATE_MODE);
  sbCancelEvent.Enabled := (FScrMode in UPDATE_MODE);
  sbDelete.Enabled      := (vtPhones.RootNodeCount > 0);
  sbDeleteAddr.Enabled  := (vtEvents.RootNodeCount > 0);
  sbDeleteEvent.Enabled := (vtInternet.RootNodeCount > 0);
end;

procedure TCdContacts.cbCountrySelect(Sender: TObject);
var
  aIdx: Integer;
begin
  eGlobalChange(Sender);
  aIdx := cbCountry.ItemIndex;
  if (aIdx > 0) and (cbCountry.Items.Objects[aIdx] <> nil) then
  begin
    cbState.ReleaseObjects;
    cbState.Items.AddStrings(dmSysCrm.LoadStates(TCountry(cbCountry.Items.Objects[aIdx])));
  end;
end;

procedure TCdContacts.cbStateSelect(Sender: TObject);
var
  aIdx: Integer;
begin
  eGlobalChange(Sender);
  aIdx := cbState.ItemIndex;
  if (aIdx > 0) and (cbState.Items.Objects[aIdx] <> nil) then
  begin
    cbCity.ReleaseObjects;
    cbCity.Items.AddStrings(dmSysCrm.LoadCities(TState(cbState.Items.Objects[aIdx])));
  end;
end;

procedure TCdContacts.sbNewClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  vtPhones.BeginUpdate;
  try
    Node := vtPhones.AddChild(nil);
    if Node <> nil then
    begin
      Data := vtPhones.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data.Level   := 0;
        Data.Node    := Node;
        Data.DataRow := TDataRow.Create(nil);
        Data.DataRow.AddAs('CODE_TYPE', cbPhone.ItemIndex, ftInteger, SizeOf(Integer));
        Data.DataRow.AddAs('PHONE_TYPE', cbPhone.Text, ftString, Length(cbPhone.Text) + 1);
        Data.DataRow.AddAs('PHONE', ePhone.Text, ftString, Length(ePhone.Text) + 1);
      end;
       vtPhones.FocusedNode := Node;
    end;
  finally
    vtPhones.EndUpdate;
  end;
  sbNew.Enabled := vtPhones.RootNodeCount < 6;
  pmNew.Enabled := vtPhones.RootNodeCount < 6;
  pgList.ActivePageIndex := 0;
end;

procedure TCdContacts.pmNewClick(Sender: TObject);
begin
  cbPhone.ItemIndex := 0;
  ePhone.Text       := '';
  pgList.ActivePageIndex   := 1;
  sbNew.Enabled := vtPhones.RootNodeCount < 6;
  pmNew.Enabled := vtPhones.RootNodeCount < 6;
  sbDelete.Enabled  := False;
end;

procedure TCdContacts.sbIgnoreClick(Sender: TObject);
begin
  pgList.ActivePageIndex := 0;
  sbNew.Enabled := vtPhones.RootNodeCount < 6;
  pmNew.Enabled := vtPhones.RootNodeCount < 6;
end;

procedure TCdContacts.sbDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vtPhones.FocusedNode;
  if (Node <> nil) then
    if Application.MessageBox(PAnsiChar('Deseja realmente excluir este registro?'),
         PAnsiChar(Application.Title), MB_ICONWARNING + MB_YESNO) = mrYes then
      vtPhones.DeleteNode(Node);
  pgList.ActivePageIndex := 0;
  sbNew.Enabled := vtPhones.RootNodeCount < 6;
  pmNew.Enabled := vtPhones.RootNodeCount < 6;
end;

procedure TCdContacts.SetActiveOwner(AValue: TOwner);
begin
  if (AValue = nil) then
    FActiveOwner.Clear
  else
    FActiveOwner.Assign(AValue);
end;

procedure TCdContacts.SetContact(AValue: TvpContact);
begin
  FContact := AValue;
  if (FContact = nil) then
    FActiveOwner.Clear
  else
    SetContactToOwner;
  PopulateDialog;
end;

procedure TCdContacts.SetContactToOwner;
var
  aStr: string;
  aInt: Integer;
begin
  if Contact.UserField0 = '' then exit;
  aStr := Contact.UserField0;
  try
    aInt := StrToIntDef(Contact.UserField0, 0);
    if (aInt > 0) then
      FActiveOwner.Assign(TOwner(aInt));
  except
    FActiveOwner.Clear;
    raise Exception.Create('CdContacts: TOwner não encontrado');
  end;
end;

function  TCdContacts.GetTitle: string;
begin
  Result := eTitle.Text;
end;

procedure TCdContacts.SetTitle(AValue: string);
begin
  eTitle.Text := AValue;
end;

function  TCdContacts.GetTypeOwner: TTypeOwner;
begin
  case lTypeCad.ItemIndex of
    0: Result := toCompany;
    1: Result := toPeople;
  else
    Result := toAll;
  end;
end;

procedure TCdContacts.SetTypeOwner(AValue: TTypeOwner);
begin
  case AValue of
    toCompany: lTypeCad.ItemIndex := 0;
    toPeople : lTypeCad.ItemIndex := 1;
  end;
  lTypeCadClick(lTypeCad);
  if (AValue = toCompany) and
     (FActiveOwner.Address.FkCity.FkState.PkState <> '') then
    SetMaskToDocSet(FActiveOwner.Address.FkCity.FkState.PkState);
end;

function  TCdContacts.GetCPF_CGC: string;
begin
  Result := eDocPri.Text;
end;

procedure TCdContacts.SetCPF_CGC(AValue: string);
begin
  eDocPri.Text := AValue;
end;

function  TCdContacts.GetIE_RG: string;
begin
  Result := eDocSec.Text;
end;

procedure TCdContacts.SetIE_RG(AValue: string);
begin
  eDocSec.Text := AValue;
end;

function  TCdContacts.GetNameOwner: string;
begin
  Result := eName.Text;
end;

procedure TCdContacts.SetNameOwner(AValue: string);
begin
  eName.Text := AValue;
end;

function  TCdContacts.GetNickName: string;
begin
  Result := eNickName.Text;
end;

procedure TCdContacts.SetNickName(AValue: string);
begin
  eNickName.Text := AValue;
end;

function  TCdContacts.GetFkAlias: Integer;
var
  aIdx: Integer;
begin
  Result := -1;
  aIdx := eNickName.Items.IndexOf(eNickName.Text);
  if (aIdx > -1) and (eNickName.Items.Objects[aIdx] <> nil) then
    Result := Integer(eNickName.Items.Objects[aIdx]);
end;

procedure TCdContacts.SetFkAlias(AValue: Integer);
begin
  if (AValue <= 0) then
    eNickName.ItemIndex := -1
  else
    eNickName.SetIndexFromIntegerValue(AValue);
end;

function  TCdContacts.GetCompany: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := cbCompany.ItemIndex;
  if (aIdx > 0) and (cbCompany.Items.Objects[aIdx] <> nil) then
    Result := TOwner(cbCompany.Items.Objects[aIdx]).PkCadastros;
end;

procedure TCdContacts.SetCompany(AValue: Integer);
begin
  cbCompany.SetIndexFromObjectValue(AValue);
end;

function  TCdContacts.GetPosition: string;
begin
  Result := ePosition.Text;
end;

procedure TCdContacts.SetPosition(AValue: string);
begin
  ePosition.Text := AValue;
end;

function  TCdContacts.GetCategory: TCategories;
var
  aCat: TCategory;
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := nil;
  FActiveOwner.Categories.Clear;
  Node := vtCategory.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtCategory.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      aCat            := FActiveOwner.Categories.Add;
      aCat.DscCat     := Data^.DataRow.FieldByName['DSC_CAT'].AsString;
      aCat.FlagCat    := TCategoryType(Data^.DataRow.FieldByName['FLAG_CAT'].AsInteger);
      aCat.PkCategory := Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger;
    end;
    Node := vtCategory.GetNext(Node);
  end;
  if (FActiveOwner.Categories <> nil) and (FActiveOwner.Categories.Count > 0) then
    Result := FActiveOwner.Categories;
end;

procedure TCdContacts.SetCategory(AValue: TCategories);
begin
  if (AValue = nil) then
    FActiveOwner.Categories.Clear
  else
    FActiveOwner.Categories := AValue;
end;

function  TCdContacts.GetPhones: TPhones;
var
  aPhone: TPhone;
  Node  : PVirtualNode;
  Data  : PGridData;
begin
  Result := nil;
  FActiveOwner.Phones.Clear;
  Node := vtPhones.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtPhones.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      aPhone := FActiveOwner.Phones.Add;
      aPhone.DscPhone   := Data^.DataRow.FieldByName['DSC_CNT'].AsString;
      aPhone.FonCad     := Data^.DataRow.FieldByName['CNT_CNT'].AsString;
    end;
    Node := vtPhones.GetNext(Node);
  end;
  if (FActiveOwner.Phones <> nil) and (FActiveOwner.Phones.Count > 0) then
    Result := FActiveOwner.Phones;
end;

procedure TCdContacts.SetPhones(AValue: TPhones);
begin
  if (AValue = nil) then
    FActiveOwner.Clear
  else
    FActiveOwner.Phones := AValue;
end;

function  TCdContacts.GetCountry: TCountry;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := cbCountry.ItemIndex;
  if (aIdx > 0) and (cbCountry.Items.Objects[aIdx] <> nil) then
    Result := TCountry(cbCountry.Items.Objects[aIdx]);
end;

procedure TCdContacts.SetCountry(AValue: TCountry);
begin
  if (AValue <> nil) then
  begin
    cbState.ReleaseObjects;
    cbCountry.SetIndexFromObjectValue(AValue.PKCountry);
    cbState.Items.AddStrings(dmSysCrm.LoadStates(AValue));
  end
  else
    cbCountry.ItemIndex := -1;
end;

function  TCdContacts.GetState: TState;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := cbState.ItemIndex;
  if (aIdx > 0) and (cbState.Items.Objects[aIdx] <> nil) then
    Result := TState(cbState.Items.Objects[aIdx]);
end;

procedure TCdContacts.SetState(AValue: TState);
begin
  if (AValue <> nil) then
  begin
    cbState.SetIndexFromObjectValue(AValue.PkState);
    cbCity.Items.AddStrings(dmSysCrm.LoadCities(AValue));
  end
  else
    cbState.ItemIndex := -1;
end;

function  TCdContacts.GetCity: TCity;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := cbCity.ItemIndex;
  if (aIdx > 0) and (cbCity.Items.Objects[aIdx] <> nil) then
    Result := TCity(cbCity.Items.Objects[aIdx]);
end;

procedure TCdContacts.SetCity(AValue: TCity);
begin
  if (AValue <> nil) then
    cbCity.SetIndexFromObjectValue(AValue.PkCity)
  else
    cbCity.ItemIndex := -1;
end;

function  TCdContacts.GetAddress: string;
begin
  Result := eAddress.Text;
end;

procedure TCdContacts.SetAddress(AValue: string);
begin
  eAddress.Text := AValue;
end;

function  TCdContacts.GetCmplAddress: string;
begin
  Result := eCmpEnd.Text;
end;

procedure TCdContacts.SetCmplAddress(AValue: string);
begin
  eCmpEnd.Text := AValue;
end;

function  TCdContacts.GetNumbAddress: Integer;
begin
  Result := Trunc(eNumEnd.Value);
end;

procedure TCdContacts.SetNumbAddress(AValue: Integer);
begin
  eNumEnd.Value := AValue;
end;

function  TCdContacts.GetZipCode: Integer;
begin
  Result := eZipCode.AsInteger;
end;

procedure TCdContacts.SetZipCode(AValue: Integer);
begin
  eZipCode.Value := AValue;
end;

function  TCdContacts.GetPostalBox: string;
begin
  Result := eCxpCad.Text;
end;

procedure TCdContacts.SetPostalBox(AValue: string);
begin
  eCxpCad.Text := AValue;
end;

function  TCdContacts.GetObservation: TStrings;
begin
  Result := mNotes.Lines;
end;

procedure TCdContacts.SetObservation(AValue: TStrings);
begin
  if (AValue = nil) then
    mNotes.Lines.Clear
  else
    mNotes.Lines.Assign(AValue);
end;

function  TCdContacts.GetPkCadEvt: TDate;
begin
  Result := ePk_Cadastros_Eventos.Date;
end;

procedure TCdContacts.SetPkCadEvt(AValue: TDate);
begin
  if (AValue = 0) then
    ePk_Cadastros_Eventos.Clear
  else
    ePk_Cadastros_Eventos.Date := AValue;
end;

function  TCdContacts.GetDscEvt: string;
begin
  Result := eDsc_Evt.Text;
end;

procedure TCdContacts.SetDscEvt(AValue: string);
begin
  eDsc_Evt.Text := AValue;
end;

function  TCdContacts.GetFlagIncEvt: Boolean;
begin
  Result := lFlag_Inc_Evt.Checked;
end;

procedure TCdContacts.SetFlagIncEvt(AValue: Boolean);
begin
  lFlag_Inc_Evt.Checked := AValue;
end;

function  TCdContacts.GetFlagTCntInt: TTypeInternetAddress;
begin
  Result := TTypeInternetAddress(eFlag_TCnt_Int.ItemIndex);
end;

procedure TCdContacts.SetFlagTCntInt(AValue: TTypeInternetAddress);
begin
  eFlag_TCnt_Int.ItemIndex := Integer(AValue);
end;

function  TCdContacts.GetEndCnt: string;
begin
  Result := eEnd_Cnt.Text;
end;

procedure TCdContacts.SetEndCnt(AValue: string);
begin
  eEnd_Cnt.Text := AValue;;
end;

function  TCdContacts.GetDscEnd: string;
begin
  Result := eDsc_End.Text;
end;

procedure TCdContacts.SetDscEnd(AValue: string);
begin
  eDsc_End.Text := AValue;
end;

function  TCdContacts.GetNetAddr: TInternetAddresses;
var
  aNet: TInternetAddress;
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := nil;
  FActiveOwner.InternetAddresses.Clear;
  Node := vtInternet.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtInternet.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      aNet             := FActiveOwner.InternetAddresses.Add;
      aNet.DscEnd      := Data^.DataRow.FieldByName['DSC_END'].AsString;
      aNet.EndCnt      := Data^.DataRow.FieldByName['END_CNT'].AsString;
      aNet.FlagDef     := Boolean(Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger);
      aNet.FlagTCntInt := TTypeInternetAddress(Data^.DataRow.FieldByName['FLAG_TCNT_INT'].AsInteger);
    end;
    Node := vtInternet.GetNext(Node);
  end;
  if (FActiveOwner.InternetAddresses <> nil) and
     (FActiveOwner.InternetAddresses.Count > 0) then
    Result := FActiveOwner.InternetAddresses;
end;

function  TCdContacts.GetOwnerEvents: TOwnerEvents;
var
  aEvt: TOwnerEvent;
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := nil;
  FActiveOwner.OwnerEvents.Clear;
  Node := vtEvents.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtEvents.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      aEvt              := FActiveOwner.OwnerEvents.Add;
      aEvt.DscEvt       := Data^.DataRow.FieldByName['DSC_EVT'].AsString;
      aEvt.PkOwnerEvent := Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsDateTime;
      aEvt.FlagIncEvt   := Boolean(Data^.DataRow.FieldByName['FLAG_INC_EVT'].AsInteger);
    end;
    Node := vtEvents.GetNext(Node);
  end;
  if (FActiveOwner.OwnerEvents <> nil) and
     (FActiveOwner.OwnerEvents.Count > 0) then
    Result := FActiveOwner.OwnerEvents;
end;

procedure TCdContacts.lTypeCadClick(Sender: TObject);
begin
  case lTypeCad.ItemIndex of
    0:
      begin
        eDocPri.EditMask := '00.000.000\/0000\-00;0; ';
        lDocSec.Caption  := 'I.E.:';
      end;
    1:
      begin
        eDocPri.EditMask := '000.000.000\-00;0; ';
        lDocSec.Caption  := 'R.G.:';
      end;
  else
    eDocPri.EditMask   := ''
  end;
end;

procedure TCdContacts.SetMaskToDocSet(AUF: string);
begin
  eDocSec.EditMask := Mascara_Inscricao(AUF);
end;

procedure TCdContacts.vtCategoryInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
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
end;

procedure TCdContacts.vtCategoryGetText(Sender: TBaseVirtualTree;
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

procedure TCdContacts.vtUsersInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Node.CheckType := ctCheckBox;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger = 0) then
    Node.CheckState := csUncheckedNormal
  else
    Node.CheckState := csCheckedNormal;
end;

procedure TCdContacts.vtUsersGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column = 0) then
    CellText := Data^.DataRow.FieldByName['FK_OPERADORES'].AsString;
end;

procedure TCdContacts.vtCategoryChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (FActiveOwner.PkCadastros > 0) and (ScrMode = dbmBrowse) then
  begin
    if (Node.CheckState = csUnCheckedNormal) then
      dmSysCrm.DeleteCategoryLink(ActiveOwner.PkCadastros,
            Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger)
    else
      if (Node.CheckState = csMixedNormal) then
        dmSysCrm.UpdateCategoryLink(ActiveOwner.PkCadastros,
            Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger)
      else
        if (Node.CheckState = csCheckedNormal) then
          dmSysCrm.InsertCategoryLink(ActiveOwner.PkCadastros,
            Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger);
  end;
end;

procedure TCdContacts.SetOwnerCategories;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (vtCategory.RootNodeCount = 0) then exit;
  dmSysCrm.DeleteCategoryLink(FActiveOwner.PkCadastros, 0, True);
  Node := vtCategory.GetFirst;
  if (Node <> nil) then
  begin
    Data := vtCategory.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    while (Node <> nil) do
    begin
      Data := vtCategory.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        if (Node.CheckState in [csCheckedNormal, csMixedNormal]) then
          dmSysCrm.InsertCategoryLink(ActiveOwner.PkCadastros,
            Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger);
        if (Node.CheckState = csMixedNormal) then
          dmSysCrm.UpdateCategoryLink(ActiveOwner.PkCadastros,
              Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger);
      end;
      Node := vtCategory.GetNext(Node);
    end;
  end;
end;

procedure TCdContacts.SetOwnerResources;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (vtUsers.RootNodeCount = 0) then exit;
  dmSysCrm.DeleteResourceLink(FActiveOwner.PkCadastros, 0, True);
  Node := vtUsers.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtUsers.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) and
       (Node.CheckState = csCheckedNormal) then
      dmSysCrm.InsertResourceLink(ActiveOwner.PkCadastros,
        Data^.DataRow.FieldByName['PK_RESOURCES'].AsInteger);
    Node := vtUsers.GetNext(Node);
  end;
end;

procedure TCdContacts.vtUsersChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (FActiveOwner.PkCadastros > 0) and (ScrMode = dbmBrowse) then
  begin
    if (Node.CheckState = csUnCheckedNormal) then
      dmSysCrm.DeleteResourceLink(ActiveOwner.PkCadastros,
        Data^.DataRow.FieldByName['PK_RESOURCES'].AsInteger);
    if (Node.CheckState = csCheckedNormal) then
      dmSysCrm.InsertResourceLink(ActiveOwner.PkCadastros,
        Data^.DataRow.FieldByName['PK_RESOURCES'].AsInteger);
  end;
end;

procedure TCdContacts.vtEventsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DSC_EVT'].AsString;
  end;
end;

procedure TCdContacts.vtEventsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
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

procedure TCdContacts.vtEventsChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  eGlobalChange(Sender);
  if Node.CheckState = csCheckedNormal then
    Data^.DataRow.FieldByName['FLAG_EVT'].AsInteger := 1
  else
    Data^.DataRow.FieldByName['FLAG_EVT'].AsInteger := 0;
{  if Node.CheckState = csCheckedNormal then
    dmSysCrm.InsertEventOnSchedule(FActiveOwner, FResource);
  if Node.CheckState = csUnCheckedNormal then
    dmSysCrm.DeleteEventOnSchedule(FActiveOwner, FResource);}
end;

procedure TCdContacts.vtInternetGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := S_TYPES_ADDR_INTERNET[Data^.DataRow.FieldByName['FLAG_TCNT_INT'].AsInteger];
    1: CellText := Data^.DataRow.FieldByName['END_CNT'].AsString;
  end;
end;

procedure TCdContacts.vtInternetInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Data^.DataRow.FieldByName['FLAG_TCNT_INT'].AsInteger <> 1) then exit;
  Node.CheckType := ctRadioButton;
  Node.CheckState := csUnCheckedNormal;
  if Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 1 then
    Node.CheckState := csCheckedNormal;
end;

procedure TCdContacts.vtInternetChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Allowed := Data^.DataRow.FieldByName['FLAG_TCNT_INT'].AsInteger = 1;
end;

procedure TCdContacts.vtInternetChecked(Sender: TBaseVirtualTree;
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
  eGlobalChange(Sender);
end;

procedure TCdContacts.pgDataEventsChange(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtEvents.FocusedNode;
  if (Node = nil) then exit;
  if (pgDataEvents.ActivePageIndex = 1) then
  begin
    if (Node = nil) then
    begin
      FlagIncEvt := False;
      PkCadEvt   := 0;
      DscEvt     := '';
    end
    else
    begin
      Data := vtEvents.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        if (ScrMode in SCROLL_MODE) then
          ScrMode  := dbmExecute;
        FlagIncEvt := Boolean(Data^.DataRow.FieldByName['FLAG_INC_EVT'].AsInteger);
        PkCadEvt   := Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsDateTime;
        DscEvt     := Data^.DataRow.FieldByName['DSC_EVT'].AsString;
        if (ScrMode in LOADING_MODE) then
          ScrMode  := dbmBrowse;
      end;
    end;
  end
  else
  begin
    Node := vtEvents.FocusedNode;
    if (Node <> nil) then
    begin
      Data := vtEvents.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['FLAG_INC_EVT'].AsInteger          := Integer(FlagIncEvt);
        Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsDateTime := PkCadEvt;
        Data^.DataRow.FieldByName['DSC_EVT'].AsString                := DscEvt;
      end;
    end;
  end;
end;

procedure TCdContacts.sbNewEventClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
  aItem: TOwnerEvent;
begin
  Node := vtEvents.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtEvents.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) and
       (CompareDate(ePk_Cadastros_Eventos.Date,
        Data^.DataRow.FieldByName['PK_CADASTROS_EVENTOS'].AsDateTime) <> 0) then
      raise Exception.Create('Erro: Data informada já existe no cadastro');
    Node := vtEvents.GetNext(Node);
  end;
  if (vtEvents.FocusedNode = nil) then
  begin
    vtEvents.BeginUpdate;
    try
      Node := vtEvents.AddChild(nil);
      if Node <> nil then
      begin
        Data := vtEvents.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data.Level         := 0;
          Data.Node          := Node;
          Data.DataRow       := TDataRow.Create(nil);
          aItem              := FActiveOwner.OwnerEvents.Add;
          aItem.PkOwnerEvent := PkCadEvt;
          aItem.DscEvt       := DscEvt;
          aItem.FlagIncEvt   := FlagIncEvt;
          Data.DataRow.AddAs('PK_CADASTROS_EVENTOS',
            aItem.PkOwnerEvent, ftDateTime, SizeOf(TDateTime));
          Data.DataRow.AddAs('DSC_EVT',
            aItem.DscEvt, ftString,   51);
          Data.DataRow.AddAs('FLAG_INC_EVT',
            Integer(aItem.FlagIncEvt), ftInteger, SizeOf(Integer));
        end;
        vtEvents.FocusedNode := Node;
      end;
    finally
      vtEvents.EndUpdate;
    end;
    sbNewEventClick(Sender);
  end
  else
  begin
    PkCadEvt             := 0;
    DscEvt               := '';
    FlagIncEvt           := False;
    vtEvents.FocusedNode := nil;
  end;
end;

procedure TCdContacts.sbCancelEventClick(Sender: TObject);
begin
  pgDataEvents.ActivePageIndex := 0;
end;

procedure TCdContacts.sbDeleteEventClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vtEvents.FocusedNode;
  if (Node <> nil) then
    if Application.MessageBox(PAnsiChar('Deseja realmente excluir este registro?'),
         PAnsiChar(Application.Title), MB_ICONWARNING + MB_YESNO) = mrYes then
      vtEvents.DeleteNode(Node);
  pgDataEvents.ActivePageIndex := 0;
end;

procedure TCdContacts.lFlag_Inc_EvtClick(Sender: TObject);
begin
  eGlobalChange(Sender);
end;

procedure TCdContacts.pgInternetAddressChange(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (pgInternetAddress.ActivePageIndex = 1) then
  begin
    Node := vtInternet.FocusedNode;
    if (Node = nil) then
    begin
      FlagTCntInt := iaMail;
      EndCnt      := '';
      DscEnd      := eFlag_TCnt_Int.Text;
    end
    else
    begin
      Data := vtInternet.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        if (ScrMode in SCROLL_MODE) then
          ScrMode   := dbmExecute;
        FlagTCntInt := TTypeInternetAddress(Data^.DataRow.FieldByName['FLAG_TCNT_INT'].AsInteger);
        EndCnt      := Data^.DataRow.FieldByName['END_CNT'].AsString;
        DscEnd      := Data^.DataRow.FieldByName['DSC_END'].AsString;
        if (ScrMode in LOADING_MODE) then
          ScrMode   := dbmBrowse;
      end;
    end;
  end
  else
  begin
    Node := vtInternet.FocusedNode;
    if (Node <> nil) then
    begin
      Data := vtInternet.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['FLAG_TCNT_INT'].AsInteger := Integer(FlagTCntInt);
        Data^.DataRow.FieldByName['END_CNT'].AsString        := EndCnt;
        Data^.DataRow.FieldByName['DSC_END'].AsString        := DscEnd;
      end;
    end;
  end;
end;

procedure TCdContacts.eFlag_TCnt_IntSelect(Sender: TObject);
begin
  eGlobalChange(Sender);
  if (vtInternet.FocusedNode = nil) and (DscEnd = '') then
    DscEnd := eFlag_TCnt_Int.Text;
end;

procedure TCdContacts.sbNewAddrClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
  aItem: TInternetAddress;
begin
  if (vtInternet.FocusedNode <> nil) then
  begin
    FlagTCntInt            := iaMail;
    EndCnt                 := '';
    DscEnd                 := eFlag_TCnt_Int.Text;
    vtInternet.FocusedNode := nil;
  end
  else
  begin
    vtInternet.BeginUpdate;
    try
      Node := vtInternet.AddChild(nil);
      if Node <> nil then
      begin
        Data := vtInternet.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data.Level        := 0;
          Data.Node         := Node;
          Data.DataRow      := TDataRow.Create(nil);
          aItem             := FActiveOwner.InternetAddresses.Add;
          aItem.FlagDef     := False;
          aItem.FlagTCntInt := FlagTCntInt;
          aItem.DscEnd      := DscEnd;
          aItem.EndCnt      := EndCnt;
          Data.DataRow.AddAs('FLAG_DEF',
            Integer(aItem.FlagDef), ftInteger, SizeOf(Integer));
          Data.DataRow.AddAs('FLAG_TCNT_INT',
            Integer(aItem.FlagTCntInt), ftInteger, SizeOf(Integer));
          Data.DataRow.AddAs('DSC_END',
            aItem.DscEnd, ftString,   31);
          Data.DataRow.AddAs('END_CNT',
            aItem.EndCnt, ftString,   101);
        end;
        vtInternet.FocusedNode := Node;
      end;
    finally
      vtInternet.EndUpdate;
    end;
    sbNewAddrClick(Sender);
  end;
end;

procedure TCdContacts.vtInternetGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or(Data^.DataRow = nil) or (Column > 0) then exit;
  Ghosted := False;
  if (Kind in [ikNormal, ikSelected]) then
  begin
    case Data^.DataRow.FieldByName['FLAG_TCNT_INT'].AsInteger of
      0: ImageIndex := 60;
      1: ImageIndex := 77;
      2: ImageIndex := 60;
      3: ImageIndex := 87;
      4: ImageIndex := 11;
    end;
  end;
end;

procedure TCdContacts.sbCancelAddrClick(Sender: TObject);
begin
  pgInternetAddress.ActivePageIndex := 0;
end;

procedure TCdContacts.sbDeleteAddrClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vtInternet.FocusedNode;
  if (Node <> nil) then
    if Application.MessageBox(PAnsiChar('Deseja realmente excluir este registro?'),
         PAnsiChar(Application.Title), MB_ICONWARNING + MB_YESNO) = mrYes then
      vtInternet.DeleteNode(Node);
  pgInternetAddress.ActivePageIndex := 0;
end;

procedure TCdContacts.eNickNameSearchListChange(Sender: TObject);
var
  aIdx: Integer;
begin
  if (eNickName.Text = '') or (ScrMode in SCROLL_MODE) or
     (ScrMode in LOADING_MODE) then exit;
  aIdx := eNickName.Items.IndexOf(eNickName.Text);
  if (aIdx = -1) then
  begin
    if (Dados.DisplayMessage(Format('Nome Fantasia não existe. ' +
       'Deseja Inserir %s no cadastro', [eNickName.Text]), hiInformation,
       [mbYes, mbNo]) = mrYes) then
    begin
      aIdx := dmSysCrm.ModifyAlias(FActiveOwner.FkAlias, eNickName.Text, dbmInsert);
      case aIdx of
        -1: raise Exception.Create('ModifyAlias: Invalid Alias');
        -2: raise Exception.Create('ModifyAlias: Invalid Alias Description');
        -3: raise Exception.Create('ModifyAlias: Alias Description already exists');
      end;
    end;
  end
  else
    aIdx := Integer(eNickName.Items.Objects[aIdx]);
  if (aIdx > 0) then
  begin
    FActiveOwner.FkAlias := aIdx;
    FActiveOwner.NomFan  := eNickName.Text;
    eNickName.ItemIndex  := eNickName.Items.AddObject(FActiveOwner.NomFan,
      TObject(FActiveOwner.FkAlias));
    FAliasSaved := True;
  end
  else
    Dados.DisplayHint(eNickName, 'Alias não selecionado',
      hiError, 'Seleção de Alias');
end;

procedure TCdContacts.GetPhoneList;
var
  ANode: PVirtualNode;
  Child: PVirtualNode;
  Data : PGridData;
  aRazSoc: string;
  procedure AddData(Node: PVirtualNode);
  begin
    if (Node <> nil) then
    begin
      Data := vtPhoneList.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data.Node    := Node;
        Data.Level   := 0;
        Data.DataRow := TDataRow.CreateFromDataSet(nil, dmSysCrm.qrSqlAux, True);
      end;
    end;
  end;
begin
  ANode := nil;
  if (ActiveOwner.PkCadastros <= 0) then exit;
  ReleaseTreeNodes(vtPhoneList);
  with dmSysCrm do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlPhoneList);
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('PkCadastros').AsInteger := ActiveOwner.PkCadastros;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.Eof) do
      begin
        if (aRazSoc = qrSqlAux.FieldByName('RAZ_SOC').AsString) then
        begin
          Child := vtPhoneList.AddChild(ANode);
          AddData(Child);
        end
        else
        begin
          ANode := vtPhoneList.AddChild(nil);
          AddData(ANode);
        end;
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

procedure TCdContacts.pgContactsChange(Sender: TObject);
begin
  if (pgContacts.ActivePageIndex = 1) and (ActiveOwner.PkCadastros > 0) then
    GetPhoneList;
end;

procedure TCdContacts.vtPhoneListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
    1: CellText := PhoneLabel(TVpPhoneType(Data^.DataRow.FieldByName['FLAG_MCNT'].AsInteger));
    2: CellText := MaskDoFormatText(S_PHONE_MASK, Data^.DataRow.FieldByName['DSC_CNT'].AsString, ' ');
  end;
end;

end.

