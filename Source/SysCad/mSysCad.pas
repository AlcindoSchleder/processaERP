unit mSysCad;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.1.0.0                                                      *}
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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Encryp, ProcType, FMTBcd, StdCtrls, SqlExpr, TSysCadAux, ProcUtils,
  TSysCad, GridRow, TSysFatAux, LbCipher, LbClass;

type
  PCityTax = ^TCityTax;
  TCityTax = packed record
    PkSportedPrinter: Integer;
    DscPrinter      : string;
    CodAlqt         : Integer;
  end;

  TFindOwnersEvent  = procedure (Sender: TObject; ADataSet: TDataSet) of object;

  TTypeDocs         = (tdPrimary, tdSecondary, tdBoth);

  TLocalKeys = packed record
    PkCountry  : Integer;
    PkState    : string;
    PkCity     : Integer;
    PkDistrict : Integer;
    PkAddress  : Integer;
  end;

  TdmSysCad = class(TDataModule)
    qrCountry: TSQLQuery;
    qrState: TSQLQuery;
    qrCity: TSQLQuery;
    qrDistrict: TSQLQuery;
    qrLocality: TSQLQuery;
    qrCategory: TSQLQuery;
    qrTypeAddr: TSQLQuery;
    Cadastro: TSQLQuery;
    Vinculo: TSQLQuery;
    qrCustomer: TSQLQuery;
    TipoPgtos: TSQLQuery;
    Bancos: TSQLQuery;
    Vendedores: TSQLQuery;
    Representantes: TSQLQuery;
    qrComRange: TSQLQuery;
    qrTipoEstblc: TSQLQuery;
    Porto: TSQLQuery;
    Agentes: TSQLQuery;
    qrCollection: TSQLQuery;
    qrDelivery: TSQLQuery;
    qrReferences: TSQLQuery;
    qrPartners: TSQLQuery;
    qrPersonalData: TSQLQuery;
    qrSqlAux: TSQLQuery;
    qrTypeReduct: TSQLQuery;
    qrSupplier: TSQLQuery;
    qrRegions: TSQLQuery;
    qrTypeComission: TSQLQuery;
    Cargos: TSQLQuery;
    qrCntEvt: TSQLQuery;
    qrFuncionario: TSQLQuery;
    qrCntInternet: TSQLQuery;
    TabelaPrecos: TSQLQuery;
    qrTypeBlock: TSQLQuery;
    MeiosPgto: TSQLQuery;
    qrAlias: TSQLQuery;
    qrCntCnt: TSQLQuery;
    qrOwnerMov: TSQLQuery;
    lbCrypto: TLb3DES;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FLocalKeys: TLocalKeys;
    function  GetCategory(APk: Integer): TCategory;
    function  GetCountry(APk: Integer): TCountry;
    function  GetState(APk: LongInt): TState;
    function  GetCity(APk: Integer): TCity;
    function  GetDistrict(APk: Integer): TDistrict;
    function  GetLocality(APk: Integer): TLocality;
    function  GetAddrType(APk: Integer): TAddressType;
    function  GetRegions(APk: Integer): TDataRow;
    procedure SetCategory(APk: Integer; const Value: TCategory);
    procedure SetCountry(APk: Integer; const Value: TCountry);
    procedure SetState(APk: LongInt; const Value: TState);
    procedure SetCity(APk: Integer; const Value: TCity);
    procedure SetCityTaxes(APk: Integer; const Value: TCityTax);
    procedure SetDistrict(APk: Integer; const Value: TDistrict);
    procedure SetLocality(APk: Integer; const Value: TLocality);
    procedure SetAddrType(APk: Integer; const Value: TAddressType);
    procedure SetRegions(APk: Integer; const Value: TDataRow);
    procedure SetOwnerMovement(APk: Integer; const Value: TDataRow);
    function GetTypeComission(APk: Integer): TDataRow;
    procedure SetTypeComission(APk: Integer; const Value: TDataRow);
    function GetComRanges(APk: Integer): TList;
    procedure SetComRanges(APk: Integer; const Value: TList);
    procedure SetComisionRange(APk: Integer; const Value: TDataRow);
    function GetTypeBlock(APk: Integer): TTypeBlock;
    procedure SetTypeBlock(APk: Integer; const Value: TTypeBlock);
  public
    { Public declarations }
    FFindRecords : Boolean;
    Historicos   : TSystemLog;
    CodCadastro  : Integer;
    CodCategoria : Integer;
    CodVendedor  : Integer;
    function  CheckOwnerDocument(var ADoc: string; var APk: Integer;
                AType: TTypeDocs): Integer;
    procedure DeleteCategoryLink(APkCad, APkCat: Integer; All: Boolean = False);
    procedure UpdateCategoryLink(APkCad, APkCat: Integer);
    procedure InsertCategoryLink(const APkCad, APkCat, AFlagAtv: Integer;
                AWithTr: Boolean = True);
    function  SaveAllContactData(AMode: TDbMode; AOwner: TOwner): Integer;
    procedure SaveCustomerData(APk: Integer; ACustomer: TCustomer; AMode: TDbMode);
    procedure SaveCollectionAddress(APk: Integer; ACollectionAddress: TCollectionAddress; AMode: TDbMode);
    procedure SaveDeliveryAddress(APk: Integer; ADeliveryAddress: TDeliveryAddress; AMode: TDbMode);
    procedure SavePersonalData(APk: Integer; APersonalData: TPersonalData; AMode: TDbMode);
    procedure SaveReferenceData(APk: Integer; AReference: TReference; AMode: TDbMode);
    procedure SavePartnerData(APk: Integer; APartner: TPartner; AMode: TDbMode);
    procedure SaveSupplierData(APk: Integer; ASupplier: TSupplier; AMode: TDBMode);
    procedure SaveOwnerImage(const APk: Integer; APicture: TGraphic; AType: Integer);
    procedure SaveOwnerObs(const APk: Integer; ALines: TStrings; AType: Integer);
    procedure SaveEmployeeData(const APk: Integer; AItem: TEmployee; AState: TDBMode);
    function  GetActiveObject(AItems: TStrings; const AIdx: Integer;
                const AType: TCadAuxType): TObject;
    function  GetOwnerData(APk: Integer): TOwner;
    function  GetCustomerData(APk: Integer; var AFkCountry: Integer;
                var AFlagTCad: TTypeOwner): TCustomer;
    function  GetCollectionData(APk: Integer): TCollectionAddress;
    function  GetDeliveryAddressData(APk: Integer): TDeliveryAddress;
    function  GetPartnersData(APk: Integer): TPartners;
    function  GetSupplierData(APk: Integer): TSupplier;
    function  GetPersonalData(APk: Integer): TPersonalData;
    function  GetReferenceData(APk: Integer): TReferences;
    function  GetEmployeeData(APk: Integer): TEmployee;
    function  GetEstablishment(APK: Integer): TDataRow;
    function  LoadLanguage: TStrings;
    function  LoadMoedas: TStrings;
    function  LoadAddressType: TStrings;
    function  LoadFinanceAccounts(const AAccountNat: TAccountNat;
                AFlagAnlSnt: Smallint = 0): TStrings;
    function  LoadCountries(AllCountries: smallint = -1): TStrings;
    function  LoadStates(ACountry: TCountry): TStrings;
    function  LoadCities(AState: TState): TStrings;
    function  LoadDistrict(ACity: TCity): TStrings;
    function  LoadAlias: TStrings;
    function  LoadCompanies: TStrings;
    function  LoadVendors: TStrings;
    function  LoadRepresentants: TStrings;
    function  LoadCarriers: TStrings;
    function  LoadAgents: TStrings;
    function  LoadRegions(AFlagGeneric: Boolean): TStrings;
    function  LoadTypePayment(AFlagES: Boolean): TStrings;
    function  LoadTypeDiscounts(AFlagES: Boolean): TStrings;
    function  LoadTypeBlock: TStrings;
    function  LoadTypeDelivery: TStrings;
    function  LoadTypeTableFraction(AFkPriceTable: Integer): TStrings; 
    function  LoadPriceTable: TStrings;
    function  LoadTypeFraction: TStrings;
    function  LoadPaymentWay(const AFkTypePgto: Integer): TStrings;
    function  LoadBanks: TStrings;
    function  LoadTypeEstablishment: TStrings;
    function  LoadPorts(APkCountry: Integer): TStrings;
    function  LoadOwnerImage(const APk: Integer; var APkFound: Integer): TPicture;
    function  LoadOwnerObs(const APk: Integer; var APkFound: Integer): TStrings;
    function  SaveTypeEstablishment(AData : TDataRow; AState : TDBMode) : Integer;
    function  ValidateAlias(AAlias: string): Boolean;
    function  SaveAlias(AAlias: string)  : Integer;
    property  LocalKeys                  : TLocalKeys   read FLocalKeys       write FLocalKeys;
    property  Category     [APk: Integer]: TCategory    read GetCategory      write SetCategory;
    property  Country      [APk: Integer]: TCountry     read GetCountry       write SetCountry;
    property  State        [APk: LongInt]: TState       read GetState         write SetState;
    property  City         [APk: Integer]: TCity        read GetCity          write SetCity;
    property  CitTaxes     [APk: Integer]: TCityTax                           write SetCityTaxes;
    property  District     [APk: Integer]: TDistrict    read GetDistrict      write SetDistrict;
    property  Locality     [APk: Integer]: TLocality    read GetLocality      write SetLocality;
    property  AddrType     [APk: Integer]: TAddressType read GetAddrType      write SetAddrType;
    property  Regions      [APk: Integer]: TDataRow     read GetRegions       write SetRegions;
    property  OwnerMovement[APk: Integer]: TDataRow                           write SetOwnerMovement;
    property  TypeComission[APk: Integer]: TDataRow     read GetTypeComission write SetTypeComission;
    property  TypeBlock    [APk: Integer]: TTypeBlock   read GetTypeBlock     write SetTypeBlock;
    property  ComRanges    [APk: Integer]: TList        read GetComRanges     write SetComRanges;
    property  ComisionRange[APk: Integer]: TDataRow                           write SetComisionRange;
  end;

var
  dmSysCad: TdmSysCad;

implementation

uses Funcoes, CadArqSql, Dado, CmmConst, CadCnst, TSysGen, TypInfo,
  SqlComm, TSysPedAux, TSysEstqAux, TSysBcCx, FuncoesDB;

{$R *.DFM}

procedure TdmSysCad.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
  FLocalKeys.PkCountry   := 0;
  FLocalKeys.PkState     := '';
  FLocalKeys.PkCity      := 0;
  FLocalKeys.PkDistrict  := 0;
  FLocalKeys.PkAddress   := 0;
end;

procedure TdmSysCad.DataModuleDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].InheritsFrom(TDataSet)) and
       (TDataSet(Components[i]).Active)       then
      TDataSet(Components[i]).Close;
  end;
end;

// properties to TdmSysCad

function  TdmSysCad.GetActiveObject(AItems: TStrings; const AIdx: Integer;
  const AType: TCadAuxType): TObject;
var
  aCanGive: Boolean;
begin
  Result := nil;
  if (AIdx < 1) or (AItems = nil) or (AItems.Objects[AIdx] = nil) then exit;
  case aType of
    caCountry : aCanGive := (AItems.Objects[AIdx] is TCountry );
    caState   : aCanGive := (AItems.Objects[AIdx] is TState   );
    caCity    : aCanGive := (AItems.Objects[AIdx] is TCity    );
    caDistrict: aCanGive := (AItems.Objects[AIdx] is TDistrict);
  else
    aCanGive := False;
  end;
  if aCanGive then
    Result := AItems.Objects[AIdx];
end;

// Loading Data Functions

function TdmSysCad.GetOwnerData(APk: Integer): TOwner;
var
  aCat: TCategory;
  aFon: TPhone;
  aNet: TInternetAddress;
begin
  Result := TOwner.Create;
  if (APk <= 0) then exit;
  if Cadastro.Active then Cadastro.Close;
  Cadastro.SQL.Clear;
  Cadastro.SQL.Add(SqlPkCadastros);
  Dados.StartTransaction(Cadastro);
  if (Cadastro.Params.FindParam('PkCadastros') <> nil) then
    Cadastro.ParamByName('PkCadastros').AsInteger := APk;
  if (not Cadastro.Active) then Cadastro.Open;
  try
    with Result.Address do
    begin
      EndAdd := Cadastro.FieldByName('END_CAD').AsString;
      CmpEnd := Cadastro.FieldByName('CMP_END').AsString;
      NumAdd := Cadastro.FieldByName('NUM_END').AsInteger;
      CepAdd := Cadastro.FieldByName('CEP_CAD').AsInteger;
      CxpAdd := Cadastro.FieldByName('CXP_CAD').AsString;
      FkCity.FkState.FkCountry.PKCountry := Cadastro.FieldByName('FK_PAISES').AsInteger;
      FkCity.FkState.FkCountry.DscPais   := Cadastro.FieldByName('DSC_PAIS').AsString;
      FkCity.FkState.PkState := Cadastro.FieldByName('FK_ESTADOS').AsString;
      FkCity.FkState.DscUF   := Cadastro.FieldByName('DSC_UF').AsString;
      FkCity.PkCity := Cadastro.FieldByName('FK_MUNICIPIOS').AsInteger;
      FkCity.DscMun := Cadastro.FieldByName('DSC_MUN').AsString;
    end;
    Result.AreaAtu      := Cadastro.FieldByName('AREA_ATU').AsString;
    Result.DocPri       := Cadastro.FieldByName('DOC_PRI').AsString;
    Result.DocSec       := Cadastro.FieldByName('DOC_SEQ').AsString;
    Result.FkContacts   := Cadastro.FieldByName('FK_CONTATOS').AsInteger;
    Result.FlagEtq      := Boolean(Cadastro.FieldByName('FLAG_ETQ').AsInteger);
    Result.FlagTCad     := TTypeOwner(Cadastro.FieldByName('FLAG_TCAD').AsInteger);
    Result.FkAlias      := Cadastro.FieldByName('FK_TIPO_ALIAS').AsInteger;
    Result.NomFan       := Cadastro.FieldByName('DSC_ALIAS').AsString;
    Result.PkCadastros  := Cadastro.FieldByName('PK_CADASTROS').AsInteger;
    Result.RazSoc       := Cadastro.FieldByName('RAZ_SOC').AsString;
    Result.Title        := Cadastro.FieldByName('TRT_CNT').AsString;
  // Read Categories from table VINCULOS_CAD_CAT
    if qrCategory.Active then qrCntEvt.Close;
    qrCategory.SQL.Clear;
    qrCategory.SQL.Add(SqlCadCategory);
    qrCategory.ParamByName('PkCadastros').AsInteger :=
      Cadastro.FieldByName('PK_CADASTROS').AsInteger;
    if not qrCategory.Active then qrCategory.Open;
    while (not qrCategory.EOF) do
    begin
      aCat := Result.Categories.Add;
      aCat.DscCat     := qrCategory.FieldByName('DSC_CAT').AsString;
      aCat.FlagCat    := TCategoryType(qrCategory.FieldByName('FLAG_CAT').AsInteger);
      aCat.PkCategory := qrCategory.FieldByName('PK_CATEGORIAS').AsInteger;
      qrCategory.Next;
    end;
    if qrCategory.Active then qrCategory.Close;
  // Read from table CADASTROS_CONTATOS
    if qrCntCnt.Active then qrCntCnt.Close;
    qrCntCnt.SQL.Clear;
    qrCntCnt.SQL.Add(SqlCadContacts);
    qrCntCnt.ParamByName('FkCadastros').AsInteger :=
      Cadastro.FieldByName('PK_CADASTROS').AsInteger;
    if not qrCntCnt.Active then qrCntCnt.Open;
    while (not qrCntCnt.EOF) do
    begin
      aFon            := Result.Phones.Add;
      aFon.FlagDef    := Boolean(qrCntCnt.FieldByName('FLAG_DEF').AsInteger);
      aFon.DscPhone   := qrCntCnt.FieldByName('DSC_CNT').AsString;
      aFon.FonCad     := qrCntCnt.FieldByName('CNT_CNT').AsString;
      qrCntCnt.Next;
    end;
    if qrCntCnt.Active then qrCntCnt.Close;
  //   Read from table CADASTROS_EVENTOS
    if qrCntEvt.Active then qrCntEvt.Close;
    qrCntEvt.SQL.Clear;
    qrCntEvt.SQL.Add(SqlCadEvents);
    qrCntEvt.ParamByName('FkCadastros').AsInteger :=
      Cadastro.FieldByName('PK_CADASTROS').AsInteger;
    if not qrCntEvt.Active then qrCntEvt.Open;
    while (not qrCntEvt.Eof) do
    begin
      with Result.OwnerEvents.Add do
      begin
        PkOwnerEvent := qrCntEvt.FieldByName('PK_CADASTROS_EVENTOS').AsDateTime;
        DscEvt       := qrCntEvt.FieldByName('DSC_EVT').AsString;
        FlagIncEvt   := Boolean(qrCntEvt.FieldByName('FLAG_INC_EVT').AsInteger);
      end;
      qrCntEvt.Next;
    end;
    if qrCntEvt.Active then qrCntEvt.Close;
  // Read from table CADASTROS_INTERNET
    if qrCntInternet.Active then qrCntInternet.Close;
    qrCntInternet.SQL.Clear;
    qrCntInternet.SQL.Add(SqlCadInternet);
    qrCntInternet.ParamByName('FkCadastros').AsInteger :=
      Cadastro.FieldByName('PK_CADASTROS').AsInteger;
    if not qrCntInternet.Active then qrCntInternet.Open;
    while (not qrCntInternet.EOF) do
    begin
      aNet := Result.InternetAddresses.Add;
      aNet.EndCnt := qrCntInternet.FieldByName('END_CNT').AsString;
      aNet.DscEnd := qrCntInternet.FieldByName('DSC_END').AsString;
      aNet.FlagDef := Boolean(qrCntInternet.FieldByName('FLAG_DEF').AsInteger);
      qrCntInternet.Next;
    end;
    if qrCntInternet.Active then qrCntInternet.Close;
  finally
    if Cadastro.Active then Cadastro.Close;
    Dados.CommitTransaction(Cadastro);
  end;
end;

function  TdmSysCad.GetCustomerData(APk: Integer; var AFkCountry: Integer;
  var AFlagTCad: TTypeOwner): TCustomer;
begin
  Result := TCustomer.Create;
  if (APk <= 0) then exit;
  if (qrCustomer.Active) then qrCustomer.Close;
  qrCustomer.SQL.Clear;
  qrCustomer.SQL.Add(SqlOwnerCustomer);
  Dados.StartTransaction(qrCustomer);
  qrCustomer.ParamByName('FkCadastros').AsInteger := APk;
  try
    if (not qrCustomer.Active) then qrCustomer.Open;
    with Result do
    begin
      if (qrCustomer.FieldByName('FK_CADASTROS').AsInteger = 0) then
        AFkCountry       := -99
      else
      begin
        AFlagTCad        := TTypeOwner(qrCustomer.FieldByName('FLAG_TCAD').AsInteger);
        AFkCountry       := qrCustomer.FieldByName('FK_PAISES').AsInteger;
        DsctAtc          := qrCustomer.FieldByName('DSCT_ATC').AsFloat;
        DsctAut          := qrCustomer.FieldByName('DSCT_AUT').AsFloat;
        FkBank.PkBank    := qrCustomer.FieldByName('FK_BANCOS').AsInteger;
        FkDeliveryPeriod := qrCustomer.FieldByName('FK_TIPO_PRAZO_ENTREGA').AsInteger;
        FlagCnsm         := Boolean(qrCustomer.FieldByName('FLAG_CNSM').AsInteger);
        FlagDtaBas       := TBaseDate(qrCustomer.FieldByName('FLAG_DTABAS').AsInteger);
        FlagPAbr         := Boolean(qrCustomer.FieldByName('FLAG_PABR').AsInteger);
        FlagPend         := Boolean(qrCustomer.FieldByName('FLAG_PENP').AsInteger);
        FlagFobDirigido  := Boolean(qrCustomer.FieldByName('FLAG_FOB_DIRIGIDO').AsInteger);
        FlagSameRegion   := Boolean(qrCustomer.FieldByName('FLAG_SAME_REGION').AsInteger);
        if (qrCustomer.FieldByName('FLAG_DIFACC').IsNull) then
          FlagDifAcc     := -1
        else
          FlagDifAcc     := qrCustomer.FieldByName('FLAG_DIFACC').AsInteger;
        IdxConv          := qrCustomer.FieldByName('IDX_CONV').AsFloat;
        LimCred          := qrCustomer.FieldByName('LIM_CRD').AsFloat;
        TaxAccess        := qrCustomer.FieldByName('TAX_ACCESS').AsFloat;
        MinAccess        := qrCustomer.FieldByName('MIN_ACCESS').AsFloat;
        OpeAut           := qrCustomer.FieldByName('OPE_AUT').AsString;
        OpeLib           := qrCustomer.FieldByName('OPE_LIB').AsString;
        CodCtb           := qrCustomer.FieldByName('COD_CTB').AsInteger;
        DiaEms           := qrCustomer.FieldByName('DIA_EMS').AsInteger;
        FkCarrier        := qrCustomer.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
        FkRepresentant   := qrCustomer.FieldByName('FK_VW_REPRESENTANTES').AsInteger;
        FkVendor         := qrCustomer.FieldByName('FK_VW_VENDEDORES').AsInteger;
        FkBank.PkBank    := qrCustomer.FieldByName('FK_BANCOS').AsInteger;
        FkAgent          := qrCustomer.FieldByName('FK_VW_CADASTROS').AsInteger;
        FkPortEmb        := qrCustomer.FieldByName('FK_PORTOS__EMB').AsInteger;
        FkPortDst        := qrCustomer.FieldByName('FK_PORTOS__DST').AsInteger;
        FkDeliveryPeriod := qrCustomer.FieldByName('FK_TIPO_PRAZO_ENTREGA').AsInteger;
        FkTypeFraction   := qrCustomer.FieldByName('FK_TIPO_TABELA_FRACAO').AsInteger;
        FkPriceTable.PkPriceTable     := qrCustomer.FieldByName('FK_TABELA_PRECOS').AsInteger;
        FkTypePayment.PkTypePgto      := qrCustomer.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
        FkPaymentWay.PkPaymentWay     := qrCustomer.FieldByName('FK_FINALIZADORAS').AsInteger;
        FkTypeBlock.PkTypeBlock       := qrCustomer.FieldByName('FK_TIPO_BLOQUEIOS').AsInteger;
        FkTypeDiscount.PkTypeDiscount := qrCustomer.FieldByName('FK_TIPO_DESCONTOS').AsInteger;
        FkTypeEstablishment           := qrCustomer.FieldByName('FK_TIPO_ESTABELECIMENTOS').AsInteger;
        if (qrCustomer.FieldByName('PWD_ACCESS').AsString <> '') then
        begin
          lbCrypto.GenerateKey('x' + IntToStr(APk) + '#_AE4116E6_%@');
          PwdAccess      := lbCrypto.DecryptString(qrCustomer.FieldByName('PWD_ACCESS').AsString);
        end;
      end;
    end;
  finally
    if (qrCustomer.Active) then qrCustomer.Close;
    Dados.CommitTransaction(qrCustomer);
  end;
end;

function  TdmSysCad.GetCollectionData(APk: Integer): TCollectionAddress;
begin
  Result := nil;
  if (APk <= 0) then exit;
  if (qrCollection.Active) then qrCollection.Close;
  qrCollection.SQL.Clear;
  qrCollection.SQL.Add(SqlCollection);
  Dados.StartTransaction(qrCollection);
  if (qrCollection.Params.FindParam('FkCadastros') <> nil) then
    qrCollection.ParamByName('FkCadastros').AsInteger := APk;
  if (not qrCollection.Active) then qrCollection.Open;
  try
    if (not qrCollection.IsEmpty) then
    begin
      Result := TCollectionAddress.Create;
      with Result do
      begin
        Address.CepAdd  := qrCollection.FieldByName('CEP_CBR').AsInteger;
        Address.CmpEnd  := qrCollection.FieldByName('CMP_CBR').AsString;
        Address.CxpAdd  := qrCollection.FieldByName('CXP_CBR').AsString;
        Address.EndAdd  := qrCollection.FieldByName('END_CBR').AsString;
        with Address.FkCity.FkState do
          FkCountry.PkCountry := qrCollection.FieldByName('FK_PAISES').AsInteger;
        with Address.FkCity do
          FkState.PkState := qrCollection.FieldByName('FK_ESTADOS').AsString;
        with Address do
          FkCity.PkCity := qrCollection.FieldByName('FK_MUNICIPIOS').AsInteger;
        Address.NumAdd  := qrCollection.FieldByName('NUM_CBR').AsInteger;
        with Phones.Add do
          FonCad := qrCollection.FieldByName('FON_CBR').AsString;
        with Phones.Add do
          FonCad := qrCollection.FieldByName('FAX_CBR').AsString;
      end;
    end;
  finally
    if (qrCollection.Active) then qrCollection.Close;
    Dados.CommitTransaction(qrCollection);
  end;
end;

function  TdmSysCad.GetDeliveryAddressData(APk: Integer): TDeliveryAddress;
begin
  Result := TDeliveryAddress.Create;
  if (APk <= 0) then exit;
  if (qrDelivery.Active) then qrDelivery.Close;
  qrDelivery.SQL.Clear;
  qrDelivery.SQL.Add(SqlDelivery);
  Dados.StartTransaction(qrDelivery);
  if (qrDelivery.Params.FindParam('FkCadastros') <> nil) then
    qrDelivery.ParamByName('FkCadastros').AsInteger := APk;
  if (not qrDelivery.Active) then qrDelivery.Open;
  try
    with Result do
    begin
      CNPJEntr        := qrDelivery.FieldByName('CNPJ_ENTR').AsString;
      IEEntr          := qrDelivery.FieldByName('IE_ENTR').AsString;
      Address.CepAdd  := qrDelivery.FieldByName('CEP_ENT').AsInteger;
      Address.CmpEnd  := qrDelivery.FieldByName('CMP_ENT').AsString;
      Address.CxpAdd  := qrDelivery.FieldByName('CXP_ENT').AsString;
      Address.EndAdd  := qrDelivery.FieldByName('END_ENT').AsString;
      with Address.FkCity.FkState do
        FkCountry.PkCountry := qrDelivery.FieldByName('FK_PAISES').AsInteger;
      with Address.FkCity do
        FkState.PkState := qrDelivery.FieldByName('FK_ESTADOS').AsString;
      with Address do
        FkCity.PkCity := qrDelivery.FieldByName('FK_MUNICIPIOS').AsInteger;
      Address.NumAdd  := qrDelivery.FieldByName('NUM_ENT').AsInteger;
      with Phones.Add do
       FonCad := qrDelivery.FieldByName('FON_ENT').AsString;
      with Phones.Add do
        FonCad := qrDelivery.FieldByName('FAX_ENT').AsString;
    end;
  finally
    if (qrDelivery.Active) then qrDelivery.Close;
    Dados.CommitTransaction(qrDelivery);
  end;
end;

function  TdmSysCad.GetPartnersData(APk: Integer): TPartners;
begin
  Result := TPartners.Create(nil);
  if (Apk <= 0) then exit;
  if (qrPartners.Active) then qrPartners.Close;
  qrPartners.SQL.Clear;
  qrPartners.SQL.Add(SqlPartners);
  Dados.StartTransaction(qrPartners);
  if (qrPartners.Params.FindParam('FkCadastros') <> nil) then
    qrPartners.ParamByName('FkCadastros').AsInteger := APk;
  if (not qrPartners.Active) then qrPartners.Open;
  try
    while (not qrPartners.Eof) do
    begin
      with Result.Add do
      begin
        PkPartner       := qrPartners.FieldByName('PK_SOCIOS').AsString;
        EmailSoc        := qrPartners.FieldByName('EMAIL_SOC').AsString;
        NomSoc          := qrPartners.FieldByName('NOM_SOC').AsString;
        DtaNasc         := qrPartners.FieldByName('DTA_NAS').AsDateTime;
        Address.CepAdd  := qrPartners.FieldByName('CEP_SOC').AsInteger;
        Address.CmpEnd  := qrPartners.FieldByName('CMP_SOC').AsString;
        Address.CxpAdd  := qrPartners.FieldByName('CXP_SOC').AsString;
        Address.EndAdd  := qrPartners.FieldByName('END_SOC').AsString;
        with Address.FkCity.FkState do
          FkCountry.PkCountry := qrPartners.FieldByName('FK_PAISES').AsInteger;
        with Address.FkCity do
          FkState.PkState := qrPartners.FieldByName('FK_ESTADOS').AsString;
        with Address do
          FkCity.PkCity   := qrPartners.FieldByName('FK_MUNICIPIOS').AsInteger;
        Address.NumAdd    := qrPartners.FieldByName('NUM_SOC').AsInteger;
      end;
      qrPartners.Next;
    end;
  finally
    if (qrPartners.Active) then qrPartners.Close;
    Dados.CommitTransaction(qrPartners);
  end;
end;

function  TdmSysCad.GetPersonalData(APk: Integer): TPersonalData;
var
  sM: TMemoryStream;
begin
  Result := TPersonalData.Create;
  if (APk <= 0) then exit;
  if (qrPersonalData.Active) then qrPersonalData.Close;
  qrPersonalData.SQL.Clear;
  qrPersonalData.SQL.Add(SqlPersonalData);
  Dados.StartTransaction(qrPersonalData);
  if (qrPersonalData.Params.FindParam('FkCadastros') <> nil) then
    qrPersonalData.ParamByName('FkCadastros').AsInteger := APk;
  if (not qrPersonalData.Active) then qrPersonalData.Open;
  try
    with Result do
    begin
      CmpVal  := qrPersonalData.FieldByName('CMP_SAL').AsFloat;
      CrgCli  := qrPersonalData.FieldByName('CRG_CLI').AsString;
      DtaAdm  := qrPersonalData.FieldByName('DTA_ADM').AsDateTime;
      DtaExp  := qrPersonalData.FieldByName('DTA_EXP').AsDateTime;
      EmpTrb  := qrPersonalData.FieldByName('EMP_TRB').AsString;
      EscCad  := qrPersonalData.FieldByName('ESC_CAD').AsString;
      FlagSex := TSexType(qrPersonalData.FieldByName('FLAG_SEX').AsInteger);
      FonEmp  := qrPersonalData.FieldByName('FON_EMP').AsString;
      NomMae  := qrPersonalData.FieldByName('NOM_MAE').AsString;
      NomPai  := qrPersonalData.FieldByName('NOM_PAI').AsString;
      NumCnh  := qrPersonalData.FieldByName('NUM_CNH').AsString;
      PrfCli  := qrPersonalData.FieldByName('PRF_CLI').AsString;
      SalCli  := qrPersonalData.FieldByName('SAL_CLI').AsFloat;
      ValCnh  := qrPersonalData.FieldByName('VAL_CNH').AsDateTime;
      VlrAlg  := qrPersonalData.FieldByName('VLR_ALG').AsFloat;
      if (not qrPersonalData.FieldByName('OBS_PES').IsNull) then
      begin
        sM := TMemoryStream.Create;
        try
          sM.Position := 0;
          TBlobField(qrPersonalData.FieldByName('OBS_PES')).SaveToStream(sM);
          sM.Position := 0;
          ObsPes.LoadFromStream(sM);
        finally
          sM.Free;
        end;
      end;
      with FkCity.FkState do
        FkCountry.PkCountry := qrPersonalData.FieldByName('FK_PAISES').AsInteger;
      with FkCity do
        FkState.PkState := qrPersonalData.FieldByName('FK_ESTADOS').AsString;
      FkCity.PkCity     := qrPersonalData.FieldByName('FK_MUNICIPIOS').AsInteger;
    end;
  finally
    if (qrPersonalData.Active) then qrPersonalData.Close;
    Dados.CommitTransaction(qrPersonalData);
  end;
end;

function  TdmSysCad.GetReferenceData(APk: Integer): TReferences;
var
  sM: TMemoryStream;
begin
  Result := TReferences.Create(nil);
  if (APk <= 0) then exit;
  if (qrReferences.Active) then qrReferences.Close;
  qrReferences.SQL.Clear;
  qrReferences.SQL.Add(SqlReferences);
  Dados.StartTransaction(qrReferences);
  if (qrReferences.Params.FindParam('FkCadastros') <> nil) then
    qrReferences.ParamByName('FkCadastros').AsInteger := APk;
  if (not qrReferences.Active) then qrReferences.Open;
  try
    while (not qrReferences.Eof) do
    begin
      with Result.Add do
      begin
        eMailRef := qrReferences.FieldByName('MAIL_REF').AsString;
        FlagCnf  := Boolean(qrReferences.FieldByName('FLAG_CNF').AsInteger);
        FonRef   := qrReferences.FieldByName('FON_REF').AsString;
        NomRef   := qrReferences.FieldByName('NOM_REF').AsString;
        if (not qrReferences.FieldByName('OBS_REF').IsNull) then
        begin
          sM := TMemoryStream.Create;
          try
            sM.Position := 0;
            TBlobField(qrReferences.FieldByName('OBS_REF')).SaveToStream(sM);
            sM.Position := 0;
            ObsRef.LoadFromStream(sM);
          finally
            sM.Free;
          end;
        end;
      end;
      qrReferences.Next;
    end;
  finally
    if (qrReferences.Active) then qrReferences.Close;
    Dados.CommitTransaction(qrReferences);
  end;
end;

function  TdmSysCad.SaveAllContactData(AMode: TDbMode; AOwner: TOwner): Integer;
var
  i: Integer;
  aStrAux: TStrings;
  function GetPkCadastros: Integer;
  begin
    if Cadastro.Active then Cadastro.Close;
    try
      Cadastro.SQL.Clear;
      Cadastro.SQL.Add(SqlGenCadastros);
      if not Cadastro.Active then Cadastro.Open;
      if Cadastro.IsEmpty then
        raise Exception.Create('GetPkCadastros Error: Return of PkGenerator is null');
      Result := Cadastro.FieldByName('PK_CADASTROS').AsInteger;
      if Cadastro.Active then Cadastro.Close;
    except on E:Exception do
      raise Exception.Create('GetPkCadastros Error: Não posso atribuir ' +
        ' um valor para PK_CADASTROS! ' + NL + E.Message);
    end;
    Cadastro.SQL.Clear;
    Cadastro.SQL.AddStrings(GetInsertSQL(AOwner.GetFields, 'CADASTROS'));
  end;
begin
  if Cadastro.Active then Cadastro.Close;
  Cadastro.SQL.Clear;
  aStrAux := TStringList.Create;
  try
    aStrAux.Add('PK_CADASTROS');
    case AMode of
      dbmInsert: AOwner.PkCadastros := GetPkCadastros;
      dbmEdit  : Cadastro.SQL.AddStrings(GetUpdateSQL(AOwner.GetFields, aStrAux, 'CADASTROS'));
      dbmDelete: Cadastro.SQL.Add(SqlDelContacts);
    end;
  finally
    aStrAux.Free;
  end;
  try
    Result := AOwner.PkCadastros;
    if (Cadastro.Params.FindParam('PkCadastros') <> nil) then
      Cadastro.ParamByName('PkCadastros').AsInteger := Result;
    if (Cadastro.Params.FindParam('OldPkCadastros') <> nil) then
      Cadastro.ParamByName('OldPkCadastros').AsInteger := Result;
    if (Cadastro.Params.FindParam('FlagTCad') <> nil) then
      Cadastro.ParamByName('FlagTCad').AsInteger    := Ord(AOwner.FlagTCad);
    if (Cadastro.Params.FindParam('DocPri') <> nil) then
      Cadastro.ParamByName('DocPri').AsString    := AOwner.DocPri;
    if (Cadastro.Params.FindParam('DocSeq') <> nil) then
      Cadastro.ParamByName('DocSeq').AsString    := AOwner.DocSec;
    if (Cadastro.Params.FindParam('RazSoc') <> nil) then
      Cadastro.ParamByName('RazSoc').AsString    := AOwner.RazSoc;
    if (Cadastro.Params.FindParam('FkTipoAlias') <> nil) then
      Cadastro.ParamByName('FkTipoAlias').AsInteger := AOwner.FkAlias;
    if (Cadastro.Params.FindParam('FkPaises') <> nil) then
      Cadastro.ParamByName('FkPaises').AsInteger := AOwner.Address.FkCity.FkState.FkCountry.PKCountry;
    if (Cadastro.Params.FindParam('FkEstados') <> nil) then
      Cadastro.ParamByName('FkEstados').AsString := AOwner.Address.FkCity.FkState.PkState;
    if (Cadastro.Params.FindParam('FkMunicipios') <> nil) then
      Cadastro.ParamByName('FkMunicipios').AsInteger := AOwner.Address.FkCity.PkCity;
    if (Cadastro.Params.FindParam('EndCad') <> nil) then
      Cadastro.ParamByName('EndCad').AsString    := AOwner.Address.EndAdd;
    if (Cadastro.Params.FindParam('NumEnd') <> nil) then
      Cadastro.ParamByName('NumEnd').AsInteger   := AOwner.Address.NumAdd;
    if (Cadastro.Params.FindParam('CmpEnd') <> nil) then
      Cadastro.ParamByName('CmpEnd').AsString    := AOwner.Address.CmpEnd;
    if (Cadastro.Params.FindParam('CepCad') <> nil) then
      Cadastro.ParamByName('CepCad').AsInteger   := AOwner.Address.CepAdd;
    if (Cadastro.Params.FindParam('CxpCad') <> nil) then
      Cadastro.ParamByName('CxpCad').AsString    := AOwner.Address.CxpAdd;
    if (Cadastro.Params.FindParam('FlagEtq') <> nil) then
      Cadastro.ParamByName('FlagEtq').AsInteger  := Integer(AOwner.FlagEtq);
    if (Cadastro.Params.FindParam('FlagZumbi') <> nil) then
      if AOwner.Categories.Count = 0 then
        Cadastro.ParamByName('FlagZumbi').AsInteger := 1
      else
        Cadastro.ParamByName('FlagZumbi').AsInteger := 0;
    if (Cadastro.Params.FindParam('AreaAtu') <> nil) then
      Cadastro.ParamByName('AreaAtu').AsString    := AOwner.AreaAtu;
    if (Cadastro.Params.FindParam('TrtCnt') <> nil) then
      Cadastro.ParamByName('TrtCnt').AsString     := AOwner.Title;
    if (Cadastro.Params.FindParam('FkContatos') <> nil) then
      if AOwner.FkContacts <= 0 then
        Cadastro.Params.Delete(Cadastro.ParamByName('FkContatos').Index)
      else
        Cadastro.ParamByName('FkContatos').AsInteger  := AOwner.FkContacts;
    Cadastro.ExecSQL;
    if (AMode = dbmDelete) then exit;
    if (AMode = dbmInsert) and (AOwner.Categories.Count > 0) then
    begin
      for i := 0 to AOwner.Categories.Count - 1 do
        with AOwner.Categories.Items[i] do
          InsertCategoryLink(Result, PkCategory, Ord(FlagAtv), False);
    end;
//  Save all Date of events to table CADASTROS_EVENTOS
    //  delete all events from database
    if qrCntEvt.Active then qrCntEvt.Close;
    qrCntEvt.SQL.Clear;
    qrCntEvt.SQL.Add(SqlDelEvents);
    qrCntEvt.ParamByName('FkCadastros').AsInteger := Result;
    qrCntEvt.ExecSQL;
    //  insert all events of the object into database
    if qrCntEvt.Active then qrCntEvt.Close;
    if (AMode <> dbmDelete) then
    begin
      qrCntEvt.SQL.Clear;
      qrCntEvt.SQL.Add(SqlInsEvents);
      with AOwner.OwnerEvents do
        for i := 0 to Count - 1 do
        begin
          qrCntEvt.ParamByName('FkCadastros').AsInteger := Result;
          qrCntEvt.ParamByName('PkCadastrosEventos').AsDate := Items[i].PkOwnerEvent;
          qrCntEvt.ParamByName('DscEvt').AsString      := Items[i].DscEvt;
          qrCntEvt.ParamByName('FlagIncEvt').AsInteger := Ord(Items[i].FlagIncEvt);
//        if (AOwner.OwnerEvents.Items[i].FlagIncEvt) then
//          InsertEventOnSchedule(AOwner.OwnerEvents.Items[i]
//        else
//          DeleteEventOnSchedule(AOwner.OwnerEvents.Items[i]
          qrCntEvt.ExecSQL;
        end;
    end;
//  Save all data into table CADASTROS_INTERNET
    //  delete all internet address from database
    if qrCntInternet.Active then qrCntInternet.Close;
    qrCntInternet.SQL.Clear;
    qrCntInternet.SQL.Add(SqlDelInternet);
    qrCntInternet.ParamByName('FkCadastros').AsInteger := Result;
    qrCntInternet.ExecSQL;
    //  insert all internet address of the object into database
    if (AMode <> dbmDelete) then
    begin
      qrCntInternet.SQL.Clear;
      qrCntInternet.SQL.Add(SqlInsInternet);
      for i := 0 to AOwner.InternetAddresses.Count - 1 do
      begin
        qrCntInternet.ParamByName('FkCadastros').AsInteger := Result;
        qrCntInternet.ParamByName('PkCadastrosInternet').AsInteger := i + 1;
        with AOwner.InternetAddresses.Items[i] do
        begin
          qrCntInternet.ParamByName('EndCnt').AsString := EndCnt;
          qrCntInternet.ParamByName('DscEnd').AsString := DscEnd;
          qrCntInternet.ParamByName('FlagDef').AsInteger := Ord(FlagDef);
        end;
        qrCntInternet.ExecSQL;
      end;
    end;
//  Save all data into table CADASTROS_CONTATOS
    //  delete all Phones from database
    if qrCntCnt.Active then qrCntCnt.Close;
    qrCntCnt.SQL.Clear;
    qrCntCnt.SQL.Add(SqlDelCadCnt);
    qrCntCnt.ParamByName('FkCadastros').AsInteger := Result;
    qrCntCnt.ExecSQL;
    //  insert all phones of the object into database
    if (AMode <> dbmDelete) then
    begin
      qrCntCnt.SQL.Clear;
      qrCntCnt.SQL.Add(SqlInsCadCnt);
      for i := 0 to AOwner.Phones.Count - 1 do
      begin
        qrCntCnt.ParamByName('FkCadastros').AsInteger := Result;
        qrCntCnt.ParamByName('PkCadastrosContatos').AsInteger := i + 1;
        qrCntCnt.ParamByName('DscCnt').AsString    := AOwner.Phones.Items[i].DscPhone;
        qrCntCnt.ParamByName('CntCnt').AsString    := AOwner.Phones.Items[i].FonCad;
        qrCntCnt.ParamByName('FlagDef').AsInteger  := Ord(AOwner.Phones.Items[i].FlagDef);
        qrCntCnt.ExecSQL;
      end;
    end;
  except on E:Exception do
    raise Exception.Create('SaveAllContactData: Erro na Gravação dos dados.' +
      NL + E.Message);
  end;
end;

procedure TdmSysCad.SaveCustomerData(APk: Integer; ACustomer: TCustomer; AMode: TDbMode);
var
  aWhrFld: TStrings;
begin
// Save Customer Data
  if qrCustomer.Active then qrCustomer.Close;
  qrCustomer.SQL.Clear;
  aWhrFld := TStringList.Create;
  try
    aWhrFld.Add('FK_CADASTROS');
    case AMode of
      dbmInsert: qrCustomer.SQL.AddStrings(GetInsertSQL(ACustomer.GetFields, 'CLIENTES'));
      dbmEdit  : qrCustomer.SQL.AddStrings(GetUpdateSQL(ACustomer.GetFields,
                   aWhrFld, 'CLIENTES'));
    end;
  finally
    aWhrFld.Free;
  end;
  // move data to params
  try
    with ACustomer do
    begin
      qrCustomer.ParamByName('FkCadastros').AsInteger           := APk;
      if (qrCustomer.Params.FindParam('FlagCnsm') <> nil) then
        qrCustomer.ParamByName('FlagCnsm').AsInteger            := Ord(FlagCnsm);
      if (qrCustomer.Params.FindParam('FlagDtaBas') <> nil) then
        qrCustomer.ParamByName('FlagDtaBas').AsInteger          := Ord(FlagDtaBas);
      if (qrCustomer.Params.FindParam('FlagPAbr') <> nil) then
        qrCustomer.ParamByName('FlagPAbr').AsInteger            := Ord(FlagPAbr);
      if (qrCustomer.Params.FindParam('FlagPenp') <> nil) then
        qrCustomer.ParamByName('FlagPenp').AsInteger            := Ord(FlagPend);
      if (qrCustomer.Params.FindParam('FlagFobDirigido') <> nil) then
        qrCustomer.ParamByName('FlagFobDirigido').AsInteger     := Ord(FlagFobDirigido);
      if (qrCustomer.Params.FindParam('FlagSameRegion') <> nil) then
        qrCustomer.ParamByName('FlagSameRegion').AsInteger      := Ord(FlagSameRegion);
      if (qrCustomer.Params.FindParam('FlagDifAcc') <> nil) then
        qrCustomer.ParamByName('FlagDifAcc').AsInteger          := FlagDifAcc;
      if (qrCustomer.Params.FindParam('OldFkCadastros') <> nil) then
        qrCustomer.ParamByName('OldFkCadastros').AsInteger      := APk;
      if (qrCustomer.Params.FindParam('DsctAtc') <> nil) then
        qrCustomer.ParamByName('DsctAtc').AsFloat               := DsctAtc;
      if (qrCustomer.Params.FindParam('DsctAut') <> nil) then
        qrCustomer.ParamByName('DsctAut').AsFloat               := DsctAut;
      if (qrCustomer.Params.FindParam('FkBancos') <> nil) then
        qrCustomer.ParamByName('FkBancos').AsInteger            := FkBank.PkBank;
      if (qrCustomer.Params.FindParam('DiaEms') <> nil) then
        qrCustomer.ParamByName('DiaEms').AsInteger              := DiaEms;
      if (qrCustomer.Params.FindParam('CodCtb') <> nil) then
        qrCustomer.ParamByName('CodCtb').AsInteger              := DiaEms;
      if (qrCustomer.Params.FindParam('LimCrd') <> nil) then
        qrCustomer.Params.FindParam('LimCrd').AsFloat           := LimCred;
//      ShowMessage('IdxConv: ' + FloatToStr(IdxConv) + NL + 'PwdAccess: ' + PwdAccess + NL + qrCustomer.SQL.Text);
      if (qrCustomer.Params.FindParam('IdxConv') <> nil) then
        qrCustomer.Params.FindParam('IdxConv').AsFloat          := IdxConv;
      if (qrCustomer.Params.FindParam('TaxAccess') <> nil) then
        qrCustomer.Params.FindParam('TaxAccess').AsFloat        := TaxAccess;
      if (qrCustomer.Params.FindParam('MinAccess') <> nil) then
        qrCustomer.Params.FindParam('MinAccess').AsFloat        := MinAccess;
      if (qrCustomer.Params.FindParam('PwdAccess') <> nil) then
      begin
        lbCrypto.GenerateKey('x' + IntToStr(APk) + '#_AE4116E6_%@');
        qrCustomer.Params.FindParam('PwdAccess').AsString       := lbCrypto.EncryptString(PwdAccess);
      end;
      if (qrCustomer.Params.FindParam('SitBlockAnt') <> nil) then
        qrCustomer.Params.FindParam('SitBlockAnt').AsFloat      := 0;
      if (qrCustomer.Params.FindParam('FkBancos') <> nil) then
        qrCustomer.ParamByName('FkBancos').AsInteger            := FkBank.PkBank;
      if (qrCustomer.Params.FindParam('FkVwCadastros') <> nil) then
        qrCustomer.ParamByName('FkVwCadastros').AsInteger       := FkAgent;
      if (qrCustomer.Params.FindParam('FkPortosEmb') <> nil) then
        qrCustomer.ParamByName('FkPortosEmb').AsInteger         := FkPortEmb;
      if (qrCustomer.Params.FindParam('FkPortosDst') <> nil) then
        qrCustomer.ParamByName('FkPortosDst').AsInteger         := FkPortDst;
      if (qrCustomer.Params.FindParam('FkVwTransportadoras') <> nil) then
        qrCustomer.ParamByName('FkVwTransportadoras').AsInteger := FkCarrier;
      if (qrCustomer.Params.FindParam('FkVwRepresentantes') <> nil) then
        qrCustomer.ParamByName('FkVwRepresentantes').AsInteger  := FkRepresentant;
      if (qrCustomer.Params.FindParam('FkVwVendedores') <> nil) then
        qrCustomer.ParamByName('FkVwVendedores').AsInteger      := FkVendor;
      if (qrCustomer.Params.FindParam('FkTipoTabelaFracao') <> nil) then
        qrCustomer.ParamByName('FkTipoTabelaFracao').AsInteger  := FkTypeFraction;
      if (qrCustomer.Params.FindParam('FkTipoBloqueio') <> nil) then
        qrCustomer.ParamByName('FkTipoBloqueio').AsInteger      := FkTypeBlock.PkTypeBlock;
      if (qrCustomer.Params.FindParam('FkFinalizadoras') <> nil) then
        qrCustomer.ParamByName('FkFinalizadoras').AsInteger     := FkPaymentWay.PkPaymentWay;
      if (qrCustomer.Params.FindParam('FkTipoPrazoEntrega') <> nil) then
        qrCustomer.ParamByName('FkTipoPrazoEntrega').AsInteger  := FkDeliveryPeriod;
      if (qrCustomer.Params.FindParam('FkTipoPagamentos') <> nil) then
        qrCustomer.ParamByName('FkTipoPagamentos').AsInteger    := FkTypePayment.PkTypePgto;
      if (qrCustomer.Params.FindParam('FkTabelaPrecos') <> nil) then
        qrCustomer.ParamByName('FkTabelaPrecos').AsInteger      := FkPriceTable.PkPriceTable;
      if (qrCustomer.Params.FindParam('FkTipoDescontos') <> nil) then
        qrCustomer.ParamByName('FkTipoDescontos').AsInteger     := FkTypeDiscount.PkTypeDiscount;
      if (qrCustomer.Params.FindParam('FkTipoEstabelecimentos') <> nil) then
        qrCustomer.ParamByName('FkTipoEstabelecimentos').AsInteger := FkTypeEstablishment;
    end;
    qrCustomer.ExecSQL;
    if qrCustomer.Active then qrCustomer.Close;
  except on E:Exception do
    raise Exception.Create('SaveCustomerData:' + E.Message + NL +
      qrCustomer.SQL.Text);
  end;
end;

procedure TdmSysCad.SavePartnerData(APk: Integer; APartner: TPartner; AMode: TDBMode);
var
  aWhrFld: TStrings;
begin
  if qrPartners.Active then qrPartners.Close;
  qrPartners.SQL.Clear;
  aWhrFld := TStringList.Create;
  try
    aWhrFld.Add('FK_CLIENTES');
    aWhrFld.Add('PK_SOCIOS');
    case AMode of
      dbmInsert: qrPartners.SQL.AddStrings(GetInsertSQL(APartner.GetFields, 'SOCIOS'));
      dbmEdit  : qrPartners.SQL.AddStrings(GetUpdateSQL(APartner.GetFields,
                   aWhrFld, 'SOCIOS'));
    end;
  finally
    aWhrFld.Free;
  end;
  // move data to params
  try
    with APartner do
    begin
      qrPartners.ParamByName('FkClientes').AsInteger       := APk;
      qrPartners.ParamByName('PkSocios').AsString          := PkPartner;
      if (qrPartners.Params.FindParam('OldFkClientes') <> nil) then
        qrPartners.ParamByName('OldFkClientes').AsInteger       := APk;
      if (qrPartners.Params.FindParam('OldPkSocios') <> nil) then
        qrPartners.ParamByName('OldPkSocios').AsString          := PkPartner;
      qrPartners.ParamByName('NomSoc').AsString            := NomSoc;
      if (qrPartners.Params.FindParam('MailSoc') <> nil) then
        qrPartners.ParamByName('MailSoc').AsString         := EmailSoc;
      if (qrPartners.Params.FindParam('DtaNas') <> nil) then
        qrPartners.ParamByName('DtaNas').AsDateTime        := DtaNasc;
      if (qrPartners.Params.FindParam('CepSoc') <> nil) then
        qrPartners.ParamByName('CepSoc').AsInteger         := Address.CepAdd;
      if (qrPartners.Params.FindParam('CmpSoc') <> nil) then
        qrPartners.ParamByName('CmpSoc').AsString          := Address.CmpEnd;
      if (qrPartners.Params.FindParam('CxpSoc') <> nil) then
        qrPartners.ParamByName('CxpSoc').AsString          := Address.CxpAdd;
      if (qrPartners.Params.FindParam('EndSoc') <> nil) then
        qrPartners.ParamByName('EndSoc').AsString          := Address.EndAdd;
      if (qrPartners.Params.FindParam('NumSoc') <> nil) then
        qrPartners.ParamByName('NumSoc').AsInteger         := Address.NumAdd;
      with Address.FkCity.FkState do
        if (qrPartners.Params.FindParam('FkPaises') <> nil) then
          qrPartners.ParamByName('FkPaises').AsInteger     := FkCountry.PkCountry;
      with Address.FkCity do
        if (qrPartners.Params.FindParam('FkEstados') <> nil) then
          qrPartners.ParamByName('FkEstados').AsString     := FkState.PkState;
      with Address do
        if (qrPartners.Params.FindParam('FkMunicipios') <> nil) then
          qrPartners.ParamByName('FkMunicipios').AsInteger := FkCity.PkCity;
    end;
    qrPartners.ExecSQL;
    if qrPartners.Active then qrPartners.Close;
  except on E:Exception do
    raise Exception.Create('SaveAllPartnerData:' + E.Message + NL +
      qrPartners.SQL.Text);
  end;
end;

procedure TdmSysCad.SaveCollectionAddress(APk: Integer; ACollectionAddress: TCollectionAddress;
  AMode: TDbMode);
var
  aWhrFld: TStrings;
begin
// Save Customer Data
  if qrCollection.Active then qrCollection.Close;
  qrCollection.SQL.Clear;
  aWhrFld := TStringList.Create;
  try
    aWhrFld.Add('FK_CLIENTES');
    case AMode of
      dbmInsert: qrCollection.SQL.AddStrings(GetInsertSQL(
                   ACollectionAddress.GetFields, 'COBRANCAS'));
      dbmEdit  : qrCollection.SQL.AddStrings(GetUpdateSQL(
                   ACollectionAddress.GetFields, aWhrFld, 'COBRANCAS'));
    end;
  finally
    aWhrFld.Free;
  end;
  try
    // move data to params
    with ACollectionAddress do
    begin
      qrCollection.ParamByName('FkClientes').AsInteger := APk;
      if (qrCollection.Params.FindParam('OldFkClientes') <> nil) then
        qrCollection.ParamByName('OldFkClientes').AsInteger := APk;
      qrCollection.ParamByName('CepCbr').AsInteger     := Address.CepAdd;
      qrCollection.ParamByName('EndCbr').AsString      := Address.EndAdd;
      qrCollection.ParamByName('NumCbr').AsInteger     := Address.NumAdd;
      with Address.FkCity.FkState do
        qrCollection.ParamByName('FkPaises').AsInteger := FkCountry.PkCountry;
      with Address.FkCity do
        qrCollection.ParamByName('FkEstados').AsString := FkState.PkState;
      with Address do
        qrCollection.ParamByName('FkMunicipios').AsInteger := FkCity.PkCity;
      if (qrCollection.Params.FindParam('CmpCbr') <> nil) then
        qrCollection.ParamByName('CmpCbr').AsString    := Address.CmpEnd;
      if (qrCollection.Params.FindParam('CxpCbr') <> nil) then
        qrCollection.ParamByName('CxpCbr').AsString    := Address.CxpAdd;
      if (qrCollection.Params.FindParam('FonCbr') <> nil) then
        qrCollection.ParamByName('FonCbr').AsString    := Phones.Items[0].FonCad;
      if (qrCollection.Params.FindParam('FaxCbr') <> nil) then
        qrCollection.ParamByName('FaxCbr').AsString    := Phones.Items[1].FonCad;
    end;
    qrCollection.ExecSQL;
    if qrCollection.Active then qrCollection.Close;
  except on E:Exception do
    raise Exception.Create('SaveCollectionAddress:' + E.Message + NL +
      qrCollection.SQL.Text);
  end;
end;

procedure TdmSysCad.SaveDeliveryAddress(APk: Integer; ADeliveryAddress: TDeliveryAddress;
  AMode: TDbMode);
var
  aWhrFld: TStrings;
begin
// Save Customer Data
  if qrDelivery.Active then qrDelivery.Close;
  qrDelivery.SQL.Clear;
  aWhrFld := TStringList.Create;
  try
    aWhrFld.Add('FK_CLIENTES');
    case AMode of
      dbmInsert: qrDelivery.SQL.AddStrings(GetInsertSQL(
                   ADeliveryAddress.GetFields, 'ENTREGAS'));
      dbmEdit  : qrDelivery.SQL.AddStrings(GetUpdateSQL(
                   ADeliveryAddress.GetFields, aWhrFld, 'ENTREGAS'));
    end;
  finally
    aWhrFld.Free;
  end;
  try
    // move data to params
    with ADeliveryAddress do
    begin
      qrDelivery.ParamByName('FkClientes').AsInteger := APk;
      if (qrDelivery.Params.FindParam('OldFkClientes') <> nil) then
        qrDelivery.ParamByName('OldFkClientes').AsInteger := APk;
      qrDelivery.ParamByName('EndEnt').AsString  := Address.EndAdd;
      qrDelivery.ParamByName('NumEnt').AsInteger := Address.NumAdd;
      qrDelivery.ParamByName('CepEnt').AsInteger := Address.CepAdd;
      with Address.FkCity.FkState do
        qrDelivery.ParamByName('FkPaises').AsInteger := FkCountry.PkCountry;
      with Address.FkCity do
        qrDelivery.ParamByName('FkEstados').AsString := FkState.PkState;
      with Address do
        qrDelivery.ParamByName('FkMunicipios').AsInteger := FkCity.PkCity;
      if (qrDelivery.Params.FindParam('CnpjEnt') <> nil) then
        qrDelivery.ParamByName('CnpjEnt').AsString := CNPJEntr;
      if (qrDelivery.Params.FindParam('IeEnt') <> nil) then
        qrDelivery.ParamByName('IeEnt').AsString   := IEEntr;
      if (qrDelivery.Params.FindParam('CmpEnt') <> nil) then
        qrDelivery.ParamByName('CmpEnt').AsString  := Address.CmpEnd;
      if (qrDelivery.Params.FindParam('CxpEnt') <> nil) then
        qrDelivery.ParamByName('CxpEnt').AsString  := Address.CxpAdd;
      if (qrDelivery.Params.FindParam('FonEnt') <> nil) then
        qrDelivery.ParamByName('FonEnt').AsString  := Phones.Items[0].FonCad;
      if (qrDelivery.Params.FindParam('FaxEnt') <> nil) then
        qrDelivery.ParamByName('FaxEnt').AsString  := Phones.Items[1].FonCad;
    end;
    qrDelivery.ExecSQL;
    if qrDelivery.Active then qrDelivery.Close;
  except on E:Exception do
    raise Exception.Create('SaveDeliveryAddress:' + E.Message + NL +
      qrDelivery.SQL.Text);
  end;
end;

procedure TdmSysCad.SavePersonalData(APk: Integer; APersonalData: TPersonalData;
  AMode: TDbMode);
var
  aWhrFld: TStrings;
  sM     : TStream;
begin
// Save Customer Data
  if qrPersonalData.Active then qrPersonalData.Close;
  qrPersonalData.SQL.Clear;
  aWhrFld := TStringList.Create;
  try
    aWhrFld.Add('FK_CLIENTES');
    case AMode of
      dbmInsert: qrPersonalData.SQL.AddStrings(GetInsertSQL(
                   APersonalData.GetFields, 'DADOS_PESSOAIS'));
      dbmEdit  : qrPersonalData.SQL.AddStrings(GetUpdateSQL(
                   APersonalData.GetFields, aWhrFld, 'DADOS_PESSOAIS'));
    end;
  finally
    aWhrFld.Free;
  end;
  try
    // move data to params
    with APersonalData do
    begin
      qrPersonalData.ParamByName('FkClientes').AsInteger   := APk;
      if (qrPersonalData.Params.FindParam('OldFkClientes') <> nil) then
        qrPersonalData.ParamByName('OldFkClientes').AsInteger := APk;
      qrPersonalData.ParamByName('FlagSex').AsInteger      := Ord(FlagSex);
      with FkCity.FkState do
        qrPersonalData.ParamByName('FkPaises').AsInteger   := FkCountry.PkCountry;
      with FkCity do
        qrPersonalData.ParamByName('FkEstados').AsString   := FkState.PkState;
      qrPersonalData.ParamByName('FkMunicipios').AsInteger := FkCity.PkCity;
      qrPersonalData.ParamByName('NomPai').AsString        := NomPai;
      qrPersonalData.ParamByName('NomMae').AsString        := NomMae;
      qrPersonalData.ParamByName('SalCli').AsFloat         := SalCli;
      qrPersonalData.ParamByName('CmpVal').AsFloat         := CmpVal;
      qrPersonalData.ParamByName('VlrAlg').AsFloat         := VlrAlg;
      if (qrPersonalData.Params.FindParam('CrgCli') <> nil) then
        qrPersonalData.ParamByName('CrgCli').AsString      := CrgCli;
      if (qrPersonalData.Params.FindParam('DtaAdm') <> nil) then
        qrPersonalData.ParamByName('DtaAdm').AsDateTime    := DtaAdm;
      if (qrPersonalData.Params.FindParam('DtaExp') <> nil) then
        qrPersonalData.ParamByName('DtaExp').AsDateTime    := DtaExp;
      if (qrPersonalData.Params.FindParam('EmpTrb') <> nil) then
        qrPersonalData.ParamByName('EmpTrb').AsString      := EmpTrb;
      if (qrPersonalData.Params.FindParam('EscCad') <> nil) then
        qrPersonalData.ParamByName('EscCad').AsString      := EscCad;
      if (qrPersonalData.Params.FindParam('FonEmp') <> nil) then
        qrPersonalData.ParamByName('FonEmp').AsString      := FonEmp;
      if (qrPersonalData.Params.FindParam('NumCnh') <> nil) then
        qrPersonalData.ParamByName('NumCnh').AsString      := NumCnh;
      if (qrPersonalData.Params.FindParam('PrfCli') <> nil) then
        qrPersonalData.ParamByName('PrfCli').AsString      := PrfCli;
      if (qrPersonalData.Params.FindParam('ValCnh') <> nil) then
        qrPersonalData.ParamByName('ValCnh').AsDateTime     := ValCnh;
      if (qrPersonalData.Params.FindParam('ObsPes') <> nil) then
      begin
        sM := TMemoryStream.Create;
        try
          sM.Position := 0;
          ObsPes.SaveToStream(sM);
          sM.Position := 0;
          qrPersonalData.ParamByName('ObsPes').LoadFromStream(sM, ftMemo);
        finally
          sM.Free;
        end;
      end;
    end;
    qrPersonalData.ExecSQL;
    if qrPersonalData.Active then qrPersonalData.Close;
  except on E:Exception do
    raise Exception.Create('PersonalData:' + E.Message + NL +
      qrPersonalData.SQL.Text);
  end;
end;

procedure TdmSysCad.SaveReferenceData(APk: Integer; AReference: TReference;
  AMode: TDbMode);
var
  aWhrFld: TStrings;
  sM     : TStream;
begin
  if qrReferences.Active then qrReferences.Close;
  qrReferences.SQL.Clear;
  aWhrFld := TStringList.Create;
  try
    aWhrFld.Add('FK_CLIENTES');
    aWhrFld.Add('PK_REFERENCIA_COMERCIAIS');
    case AMode of
      dbmInsert: qrReferences.SQL.AddStrings(GetInsertSQL(AReference.GetFields,
                   'REFERENCIA_COMERIAIS'));
      dbmEdit  : qrReferences.SQL.AddStrings(GetUpdateSQL(AReference.GetFields,
                   aWhrFld, 'REFERENCIA_COMERIAIS'));
    end;
  finally
    aWhrFld.Free;
  end;
  try
    // move data to params
    with AReference do
    begin
      qrReferences.ParamByName('FkClientes').AsInteger             := APk;
      if (qrReferences.Params.FindParam('OldFkClientes') <> nil) then
        qrReferences.ParamByName('OldFkClientes').AsInteger := APk;
      if (qrReferences.Params.FindParam('OldPkReferenciaComerciais') <> nil) then
        qrReferences.ParamByName('OldPkReferenciaComerciais').AsInteger := Index + 1;
      qrReferences.ParamByName('NomRef').AsString                  := NomRef;
      qrReferences.ParamByName('PkReferenciaComerciais').AsInteger := Index + 1;
      qrReferences.ParamByName('FlagCnf').AsInteger                := Ord(FlagCnf);
      if (qrReferences.Params.FindParam('MailRef') <> nil) then
        qrReferences.ParamByName('MailRef').AsString               := eMailRef;
      if (qrReferences.Params.FindParam('FonRef') <> nil) then
        qrReferences.ParamByName('FonRef').AsString                := FonRef;
      if (qrReferences.Params.FindParam('ObsRef') <> nil) then
      begin
        sM := TMemoryStream.Create;
        try
          sM.Position := 0;
          ObsRef.SaveToStream(sM);
          sM.Position := 0;
          TBlobField(qrReferences.ParamByName('ObsRef')).LoadFromStream(sM);
        finally
          sM.Free;
        end;
      end;
    end;
    qrReferences.ExecSQL;
    if qrReferences.Active then qrReferences.Close;
  except on E:Exception do
    raise Exception.Create('SaveReferenceData:' + E.Message + NL +
      qrReferences.SQL.Text);
  end;
end;

procedure TdmSysCad.DeleteCategoryLink(APkCad, APkCat: Integer; All: Boolean = False);
begin
  if (APkCad <= 0) or ((APkCat <= 0) and (All = False)) then exit;
  if Cadastro.Active then Cadastro.Close;
  Cadastro.SQL.Clear;
  if All then
    Cadastro.SQL.Add(SqlDelCategories)
  else
    Cadastro.SQL.Add(SqlDelCategory);
  Dados.StartTransaction(Cadastro);
  try
    if (Cadastro.Params.FindParam('FkCadastros') <> nil) then
      Cadastro.ParamByName('FkCadastros').AsInteger := APkCad;
    if (Cadastro.Params.FindParam('FkCategorias') <> nil) then
      Cadastro.ParamByName('FkCategorias').AsInteger    := APkCat;
    Cadastro.ExecSQL;
    Dados.CommitTransaction(Cadastro);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(Cadastro);
      raise Exception.Create('DeleteCategoryLink: Erro na Gravação dos dados.' +
         NL + E.Message);
    end
  end;
end;

procedure TdmSysCad.UpdateCategoryLink(APkCad, APkCat: Integer);
begin
  if (APkCad <= 0) or (APkCat <= 0) then exit;
  if Cadastro.Active then Cadastro.Close;
  Cadastro.SQL.Clear;
  Cadastro.SQL.Add(SqlUpdCategory);
  Dados.StartTransaction(Cadastro);
  try
    if (Cadastro.Params.FindParam('FkCadastros') <> nil) then
      Cadastro.ParamByName('FkCadastros').AsInteger := APkCad;
    if (Cadastro.Params.FindParam('FkCategorias') <> nil) then
      Cadastro.ParamByName('FkCategorias').AsInteger    := APkCat;
    if (Cadastro.Params.FindParam('FlagAtv') <> nil) then
      Cadastro.ParamByName('FlagAtv').AsInteger    := 0;
    Cadastro.ExecSQL;
    Dados.CommitTransaction(Cadastro);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(Cadastro);
      raise Exception.Create('UpdateCategoryLink: Erro na Gravação dos dados.' +
         NL + E.Message);
    end
  end;
end;

procedure TdmSysCad.InsertCategoryLink(const APkCad, APkCat, AFlagAtv: Integer;
  AWithTr: Boolean = True);
begin
  if (APkCad <= 0) or (APkCat <= 0) then exit;
  if qrCategory.Active then qrCategory.Close;
  qrCategory.SQL.Clear;
  qrCategory.SQL.Add(SqlInsCategory);
  if AWithTr then
    Dados.StartTransaction(qrCategory);
  try
    if (qrCategory.Params.FindParam('FkCadastros') <> nil) then
      qrCategory.ParamByName('FkCadastros').AsInteger  := APkCad;
    if (qrCategory.Params.FindParam('FkCategorias') <> nil) then
      qrCategory.ParamByName('FkCategorias').AsInteger := APkCat;
    if (qrCategory.Params.FindParam('FkEmpresas') <> nil) then
      qrCategory.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
    if (qrCategory.Params.FindParam('FlagAtv') <> nil) then
      qrCategory.ParamByName('FlagAtv').AsInteger      := AFlagAtv;
    qrCategory.ExecSQL;
    if AWithTr then
      Dados.CommitTransaction(qrCategory);
  except on E:Exception do
    begin
      if AWithTr then
        Dados.RollbackTransaction(qrCategory);
      raise Exception.Create('InsertCategoryLink: Erro na Gravação dos dados.' +
         NL + E.Message);
    end
  end;
end;

function  TdmSysCad.LoadLanguage: TStrings;
var
  aItem: TLanguage;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlLinguagens);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.AddObject('<Nenhuma>', nil);
      while not qrSqlAux.Eof do
      begin
        aItem            := TLanguage.Create;
        aItem.PkLanguage := qrSqlAux.FindField('PK_LINGUAGENS').AsString;
        aItem.DscLang    := qrSqlAux.FindField('DSC_LANG').AsString;
        aItem.cbIndex    := Result.AddObject(aItem.DscLang, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadMoedas: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlMoedas);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.AddObject('<Nenhuma>', nil);
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FindField('DSC_MD').AsString,
          TObject(qrSqlAux.FindField('PK_TIPO_MOEDAS').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadAddressType: TStrings;
var
  aItem: TAddressType;
begin
  Result := TStringList.Create;
  if (qrTypeAddr.Active) then qrTypeAddr.Close;
  qrTypeAddr.SQL.Clear;
  qrTypeAddr.SQL.Add(SqlTypeAddresses);
  Dados.StartTransaction(qrTypeAddr);
  if (not qrTypeAddr.Active) then qrTypeAddr.Open;
  try
    if (not qrTypeAddr.IsEmpty) then
    begin
      qrTypeAddr.First;
      Result.Add('... Nenhum ...');
      while not qrTypeAddr.Eof do
      begin
        aItem               := TAddressType.Create;
        aItem.PkAddressType := qrTypeAddr.FindField('PK_TIPO_ENDERECOS').AsInteger;
        aItem.DscTEnd       := qrTypeAddr.FindField('DSC_TPE').AsString;
        aItem.cbIndex       := Result.AddObject(aItem.DscTEnd, aItem);
        qrTypeAddr.Next;
      end;
    end;
  finally
    if (qrTypeAddr.Active) then qrTypeAddr.Close;
    Dados.CommitTransaction(qrTypeAddr);
  end;
end;

function  TdmSysCad.LoadCountries(AllCountries: smallint = -1): TStrings;
var
  aItem: TCountry;
begin
  Result := TStringList.Create;
  if (qrCountry.Active) then qrCountry.Close;
  qrCountry.SQL.Clear;
  qrCountry.SQL.Add(SqlCountries);
  Dados.StartTransaction(qrCountry);
  try
    qrCountry.ParamByName('FlagAtu').AsInteger := AllCountries;
    if (not qrCountry.Active) then qrCountry.Open;
    if (not qrCountry.IsEmpty) then
    begin
      qrCountry.First;
      Result.Add('... Nenhum ...');
      while not qrCountry.Eof do
      begin
        aItem           := TCountry.Create;
        aItem.PKCountry := qrCountry.FindField('PK_PAISES').AsInteger;
        aItem.DscPais   := qrCountry.FindField('DSC_PAIS').AsString;
        aItem.cbIndex   := Result.AddObject(aItem.DscPais, aItem);
        qrCountry.Next;
      end;
    end;
  finally
    if (qrCountry.Active) then qrCountry.Close;
    Dados.CommitTransaction(qrCountry);
  end;
end;

function  TdmSysCad.LoadStates(ACountry: TCountry): TStrings;
var
  aItem: TState;
begin
  Result := TStringList.Create;
  if ACountry = nil then exit;
  if (qrState.Active) then qrState.Close;
  qrState.SQL.Clear;
  qrState.SQL.Add(SqlStates);
  Dados.StartTransaction(qrState);
  if qrState.Params.FindParam('FkPaises') <> nil then
    qrState.Params.FindParam('FkPaises').AsInteger := ACountry.PKCountry;
  qrState.Open;
  try
    if (not qrState.IsEmpty) then
    begin
      qrState.First;
      Result.Add('... Nenhum ...');
      while not qrState.Eof do
      begin
        aItem         := TState.Create;
        aItem.FkCountry.Assign(ACountry);
        aItem.PkState := qrState.FindField('PK_ESTADOS').AsString;
        aItem.DscUF   := qrState.FindField('DSC_UF').AsString;
        aItem.cbIndex := Result.AddObject(aItem.DscUF, aItem);
        qrState.Next;
      end;
    end;
  finally
    if (qrState.Active) then qrState.Close;
    Dados.CommitTransaction(qrState);
  end;
end;

function  TdmSysCad.LoadCities(AState: TState): TStrings;
var
  aItem: TCity;
begin
  Result := TStringList.Create;
  if AState = nil then exit;
  if (qrCity.Active) then qrCity.Close;
  qrCity.SQL.Clear;
  qrCity.SQL.Add(SqlCities);
  Dados.StartTransaction(qrCity);
  if qrCity.Params.FindParam('FkPaises') <> nil then
    qrCity.Params.FindParam('FkPaises').AsInteger  := AState.FkCountry.PkCountry;
  if qrCity.Params.FindParam('FkEstados') <> nil then
    qrCity.Params.FindParam('FkEstados').AsString := AState.PkState;
  qrCity.Open;
  try
    if (not qrCity.IsEmpty) then
    begin
      qrCity.First;
      Result.Add('... Nenhum ...');
      while not qrCity.Eof do
      begin
        aItem         := TCity.Create;
        aItem.FkState.Assign(AState);
        aItem.PkCity  := qrCity.FieldByName('PK_MUNICIPIOS').AsInteger;
        aItem.DscMun  := qrCity.FieldByName('DSC_MUN').AsString;
        aItem.CepMun  := qrCity.FieldByName('CEP_MUN').AsInteger;
        aItem.cbIndex := Result.AddObject(aItem.DscMun, aItem);
        qrCity.Next;
      end;
    end;
  finally
    if (qrCity.Active) then qrCity.Close;
    Dados.CommitTransaction(qrCity);
  end;
end;

function  TdmSysCad.LoadDistrict(ACity: TCity): TStrings;
var
  aItem: TDistrict;
begin
  Result := TStringList.Create;
  if ACity = nil then exit;
  if (qrDistrict.Active) then qrDistrict.Close;
  qrDistrict.SQL.Clear;
  qrDistrict.SQL.Add(SqlBairros);
  Dados.StartTransaction(qrDistrict);
  if qrDistrict.Params.FindParam('FkPaises') <> nil then
    qrDistrict.Params.FindParam('FkPaises').AsInteger  := ACity.FkState.FkCountry.PkCountry;
  if qrDistrict.Params.FindParam('FkEstados') <> nil then
    qrDistrict.Params.FindParam('FkEstados').AsString := ACity.FkState.PkState;
  if qrDistrict.Params.FindParam('FkMunicipios') <> nil then
    qrDistrict.Params.FindParam('FkMunicipios').AsInteger := ACity.PkCity;
  qrDistrict.Open;
  try
    if (not qrDistrict.IsEmpty) then
    begin
      qrDistrict.First;
      Result.Add('... Nenhum ...');
      while not qrDistrict.Eof do
      begin
        aItem         := TDistrict.Create;
        aItem.FkCity.Assign(ACity);
        aItem.PkDistrict := qrDistrict.FieldByName('PK_BAIRROS').AsInteger;
        aItem.DscBai     := qrDistrict.FieldByName('DSC_BAI').AsString;
        aItem.CepBai     := qrDistrict.FieldByName('CEP_BAI').AsInteger;
        aItem.cbIndex    := Result.AddObject(aItem.DscBai, aItem);
        qrDistrict.Next;
      end;
    end;
  finally
    if (qrDistrict.Active) then qrDistrict.Close;
    Dados.CommitTransaction(qrDistrict);
  end;
end;

function  TdmSysCad.LoadAlias: TStrings;
begin
  Result := TStringList.Create;
  if qrAlias.Active then qrAlias.Close;
  qrAlias.SQL.Clear;
  qrAlias.SQL.Add(SqlSelectAlias);
  Dados.StartTransaction(qrAlias);
  if not qrAlias.Active then qrAlias.Open;
  try
    Result.AddObject('<Nenhum>', TObject(0));
    while (not qrAlias.Eof) do
    begin
      Result.AddObject(qrAlias.FieldByName('DSC_ALIAS').AsString,
        TObject(qrAlias.FieldByName('PK_TIPO_ALIAS').AsInteger));
      qrAlias.Next;
    end;
  finally
    if qrAlias.Active then qrAlias.Close;
    Dados.CommitTransaction(qrAlias);
  end;
end;

function  TdmSysCad.LoadCompanies: TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlCompanies);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        aItem             := TOwner.Create;
        aItem.PkCadastros := qrSqlAux.FindField('PK_CADASTROS').AsInteger;
        aItem.RazSoc      := qrSqlAux.FindField('RAZ_SOC').AsString;
        aItem.FlagTCad    := TTypeOwner(qrSqlAux.FindField('FLAG_TCAD').AsInteger);
        aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadVendors: TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlVendedores);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    Result.Add('... Nenhum ...');
    while not qrSqlAux.Eof do
    begin
      aItem             := TOwner.Create;
      aItem.PkCadastros := qrSqlAux.FindField('PK_CADASTROS').AsInteger;
      aItem.RazSoc      := qrSqlAux.FindField('RAZ_SOC').AsString;
      aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadRepresentants: TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlRepresentantes);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('... Nenhum ...');
      while not qrSqlAux.Eof do
      begin
        aItem             := TOwner.Create;
        aItem.PkCadastros := qrSqlAux.FindField('PK_CADASTROS').AsInteger;
        aItem.RazSoc      := qrSqlAux.FindField('RAZ_SOC').AsString;
        aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysCad.LoadAgents: TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlAgentes);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('... Nenhum ...');
      while not qrSqlAux.Eof do
      begin
        aItem             := TOwner.Create;
        aItem.PkCadastros := qrSqlAux.FindField('PK_CADASTROS').AsInteger;
        aItem.RazSoc      := qrSqlAux.FindField('RAZ_SOC').AsString;
        aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysCad.LoadCarriers: TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTransportadoras);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('... Nenhum ...');
      while not qrSqlAux.Eof do
      begin
        aItem             := TOwner.Create;
        aItem.PkCadastros := qrSqlAux.FindField('PK_CADASTROS').AsInteger;
        aItem.RazSoc      := qrSqlAux.FindField('RAZ_SOC').AsString;
        aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadTypePayment(AFlagES: Boolean): TStrings;
var
  aItem: TTypePayment;
  i, j : Integer;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypePayment);
  Dados.StartTransaction(qrSqlAux);
  if qrSqlAux.Params.FindParam('FlagES') <> nil then
    qrSqlAux.ParamByName('FlagES').AsInteger := Ord(AFlagES);
  if not qrSqlAux.Active then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not qrSqlAux.EOF do
    begin
      aItem                  := TTypePayment.Create;
      aItem.PkTypePgto       := qrSqlAux.FieldByName('PK_TIPO_PAGAMENTOS').AsInteger;
      aItem.FkGroupMovement  := qrSqlAux.FieldByName('FK_GRUPOS_MOVIMENTOS').AsInteger;
      aItem.FkFinanceAccount := qrSqlAux.FieldByName('FK_FINANCEIRO_CONTAS').AsInteger;
      aItem.DscTPgt          := qrSqlAux.FieldByName('DSC_TPG').AsString;
      aItem.FlagBaseDate     := TBaseDate(qrSqlAux.FieldByName('FLAG_BDATE').AsInteger);
      aItem.FlagBlock        := Boolean(qrSqlAux.FieldByName('FLAG_BLOQ').AsInteger);
      aItem.FlagTInt         := TIntervalPay(qrSqlAux.FieldByName('FLAG_TINTV').AsInteger);
      aItem.FlagTVda         := TTypeSale(qrSqlAux.FieldByName('FLAG_TVDA').AsInteger);
      aItem.QtdParc          := qrSqlAux.FieldByName('QTD_PARC').AsInteger;
      aItem.DspFin           := qrSqlAux.FieldByName('DSP_FIN').AsFloat;
      // Data from table TIPO_PAGAMENTOS_INTERVALOS
      if (qrSqlAux.FieldByName('KC_INTERVALOS').AsInteger > 0) then
      begin
        j := qrSqlAux.FieldByName('KC_INTERVALOS').AsInteger - 1;
        for i := 0 to j do
        begin
          with aItem.Intervals.Add do
          begin
            QtdIntrv        := qrSqlAux.FieldByName('QTD_INTRV').AsInteger;
            OpeIntrv        := TTypeOperation(qrSqlAux.FieldByName('OPE_INTRV').AsInteger);
            IdxIntrv        := qrSqlAux.FieldByName('IDX_INTRV').AsFloat;
          end;
          qrSqlAux.Next;
        end;
      end;
      aItem.cbIndex         := Result.AddObject(aItem.DscTPgt, aItem);
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadTypeDiscounts(AFlagES: Boolean): TStrings;
var
  aItem: TTypeDiscount;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeDiscounts);
  Dados.StartTransaction(qrSqlAux);
  if qrSqlAux.Params.FindParam('FlagES') <> nil then
    qrSqlAux.ParamByName('FlagES').AsInteger := Ord(AFlagES);
  if not qrSqlAux.Active then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not (qrSqlAux.Eof) do
    begin
      aItem                := TTypeDiscount.Create;
      aItem.PkTypeDiscount := qrSqlAux.FieldByName('PK_TIPO_DESCONTOS').AsInteger;
      aItem.DscDsct        := qrSqlAux.FieldByName('DSC_TDSCT').AsString;
      aItem.cbIndex        := Result.AddObject(aItem.DscDsct, aItem);
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadTypeBlock: TStrings;
var
  aItem: TTypeBlock;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlSelectTypeBlocks);
  Dados.StartTransaction(qrSqlAux);
  if not qrSqlAux.Active then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not (qrSqlAux.Eof) do
    begin
      aItem                := TTypeBlock.Create;
      aItem.DscBlock       := qrSqlAux.FieldByName('DSC_TBL').AsString;
      aItem.FlagBlq        := Boolean(qrSqlAux.FieldByName('FLAG_BLQ').AsInteger);
      aItem.FlagCndPgt     := Boolean(qrSqlAux.FieldByName('FLAG_CONDP').AsInteger);
      aItem.FlagDtaBas     := Boolean(qrSqlAux.FieldByName('FLAG_DTABAS').AsInteger);
      aItem.FlagLimCr      := Boolean(qrSqlAux.FieldByName('FLAG_LIMCR').AsInteger);
      aItem.FlagMPgt       := Boolean(qrSqlAux.FieldByName('FLAG_MPGT').AsInteger);
      aItem.FlagVaVs       := Boolean(qrSqlAux.FieldByName('FLAG_VAVS').AsInteger);
      aItem.PkTypeBlock    := qrSqlAux.FieldByName('PK_TIPO_BLOQUEIOS').AsInteger;
      aItem.cbIndex        := Result.AddObject(aItem.DscBlock, aItem);
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadPriceTable: TStrings;
var
  aItem: TPriceTable;
begin
  Result := TStringList.Create;
  if ( qrSqlAux.Active) then  qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTabelaPrecos);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not  qrSqlAux.IsEmpty) then
    begin
       qrSqlAux.First;
      Result.Add('<Nenhuma>');
      while not  qrSqlAux.Eof do
      begin
        aItem              := TPriceTable.Create(nil);
        aItem.PkPriceTable :=  qrSqlAux.FindField('PK_TABELA_PRECOS').AsInteger;
        aItem.DscTab       :=  qrSqlAux.FindField('DSC_TAB').AsString;
        aItem.DtaIni       :=  qrSqlAux.FindField('DTA_INI').AsDateTime;
        aItem.DtaFin       :=  qrSqlAux.FindField('DTA_FIN').AsDateTime;
        aItem.FlagDefTab   := Boolean( qrSqlAux.FindField('FLAG_DEFTAB').AsInteger);
        aItem.PercDsct     :=  qrSqlAux.FindField('PERC_DSCT').AsFloat;
        aItem.cbIndex      := Result.AddObject(aItem.DscTab, aItem);
         qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then  qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadTypeFraction: TStrings;
begin
  Result := TStringList.Create;
  if ( qrSqlAux.Active) then  qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeFraction);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    Result.Add('<Nenhuma>');
    while not  qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FindField('DSC_TAB').AsString,
        TObject(qrSqlAux.FindField('PK_TIPO_TABELA_FRACAO').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then  qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadPaymentWay(const AFkTypePgto: Integer): TStrings;
var
  aItem: TPaymentWay;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlPaymentWay);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkTipoPagamentos').AsInteger := AFkTypePgto;
    if not qrSqlAux.Active then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while not (qrSqlAux.Eof) do
    begin
      aItem                := TPaymentWay.Create(nil);
      aItem.PkPaymentWay   := qrSqlAux.FieldByName('PK_FINALIZADORAS').AsInteger;
      aItem.DscMPgt        := qrSqlAux.FieldByName('DSC_MPGT').AsString;
      aItem.FlagBnc        := Boolean(qrSqlAux.FieldByName('FLAG_BNC').AsInteger);
      aItem.FlagCli        := Boolean(qrSqlAux.FieldByName('FLAG_CLI').AsInteger);
      aItem.FlagTef        := Boolean(qrSqlAux.FieldByName('FLAG_TEF').AsInteger);
      aItem.FlagTrc        := Boolean(qrSqlAux.FieldByName('FLAG_TRC').AsInteger);
      aItem.FlagTFin       := TTypeFinalization(qrSqlAux.FieldByName('FLAG_TFIN').AsInteger);
      Result.AddObject(aItem.DscMPgt, aItem);
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadBanks: TStrings;
var
  aItem: TBank;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlBancos);
  Dados.StartTransaction(qrSqlAux);
  if not qrSqlAux.Active then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not (qrSqlAux.Eof) do
    begin
      aItem                := TBank.Create;
      aItem.PkBank         := qrSqlAux.FieldByName('PK_BANCOS').AsInteger;
      aItem.DscBank        := qrSqlAux.FieldByName('DSC_BCO').AsString;
      Result.AddObject(aItem.DscBank, aItem);
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadTypeEstablishment: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeEstablisment);
  Dados.StartTransaction(qrSqlAux);
  if not qrSqlAux.Active then qrSqlAux.Open;
  try
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_TEST').AsString,
        TObject(qrSqlAux.FieldByName('PK_TIPO_ESTABELECIMENTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadPorts(APkCountry: Integer): TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlPortos);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.ParamByName('FkPaises').AsInteger := APkCountry;
  if not qrSqlAux.Active then qrSqlAux.Open;
  try
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_PORTO').AsString,
        TObject(qrSqlAux.FieldByName('PK_PORTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

procedure TdmSysCad.SaveSupplierData(APk: Integer; ASupplier: TSupplier; AMode: TDBMode);
var
  aWhrFld: TStrings;
begin
// Save Customer Data
  if qrSupplier.Active then qrSupplier.Close;
  qrSupplier.SQL.Clear;
  aWhrFld := TStringList.Create;
  try
    aWhrFld.Add('FK_CADASTROS');
    case AMode of
      dbmInsert: qrSupplier.SQL.AddStrings(GetInsertSQL(ASupplier.GetFields,
                   'FORNECEDORES'));
      dbmEdit  : qrSupplier.SQL.AddStrings(GetUpdateSQL(ASupplier.GetFields,
                   aWhrFld, 'FORNECEDORES'));
    end;
  finally
    aWhrFld.Free;
  end;
  try
    // move data to params
    with ASupplier do
    begin
      qrSupplier.ParamByName('FkCadastros').AsInteger           := APk;
      if (qrSupplier.Params.FindParam('OldFkCadastros') <> nil) then
        qrSupplier.ParamByName('OldFkCadastros').AsInteger      := Apk;
      if (qrSupplier.Params.FindParam('NomVnd') <> nil) then
        qrSupplier.ParamByName('NomVnd').AsString               := NomVnd;
      if (qrSupplier.Params.FindParam('FkVwTransportadoras') <> nil) then
        qrSupplier.ParamByName('FkVwTransportadoras').AsInteger := FkCarrier;
      if (qrSupplier.Params.FindParam('FkTipoPagamentos') <> nil) then
        qrSupplier.ParamByName('FkTipoPagamentos').AsInteger    := FkTypePayment.PkTypePgto;
      if (qrSupplier.Params.FindParam('FkTipoDescontos') <> nil) then
        qrSupplier.ParamByName('FkTipoDescontos').AsInteger     := FkTypeDiscount;
      if (qrSupplier.Params.FindParam('FlagProdDef') <> nil) then
        qrSupplier.ParamByName('FlagProdDef').AsInteger         := Ord(FlagProdDef);
      if (qrSupplier.Params.FindParam('FlagTrn') <> nil) then
        qrSupplier.ParamByName('FlagTrn').AsInteger             := Ord(FlagTrn);
      if (qrSupplier.Params.FindParam('FkVwCadastros') <> nil) then
        qrSupplier.ParamByName('FkVwCadastros').AsInteger       := FkAgent;
      if (qrSupplier.Params.FindParam('FkPortosDst') <> nil) then
        qrSupplier.ParamByName('FkPortosDst').AsInteger         := FkPortDst;
      if (qrSupplier.Params.FindParam('FkPortosEmb') <> nil) then
        qrSupplier.ParamByName('FkPortosEmb').AsInteger         := FkPortEmb;
      if (qrSupplier.Params.FindParam('FkTabelaPrecos') <> nil) then
        qrSupplier.ParamByName('FkTabelaPrecos').AsInteger      := FkPriceTable;
      if (qrSupplier.Params.FindParam('FkTipoTabelaFracao') <> nil) then
        qrSupplier.ParamByName('FkTipoTabelaFracao').AsInteger  := FkTypeFraction;
    end;
    qrSupplier.ExecSQL;
    if qrSupplier.Active then qrSupplier.Close;
  except on E:Exception do
    raise Exception.Create('SaveSupplierData:' + E.Message + NL +
      qrSupplier.SQL.Text);
  end;
end;

function TdmSysCad.GetSupplierData(APk: Integer): TSupplier;
begin
  Result := nil;
  if qrSupplier.Active then qrSupplier.Close;
  qrSupplier.SQL.Clear;
  qrSupplier.SQL.Add(SqlFornecCad);
  Dados.StartTransaction(qrSupplier);
  try
    qrSupplier.ParamByName('FkCadastros').AsInteger := APk;
    if (not qrSupplier.Active) then qrSupplier.Open;
    if (not qrSupplier.IsEmpty) then
    begin
      Result                 := TSupplier.Create;
      Result.FkPortDst       := qrSupplier.FieldByName('FK_PORTOS__DST').AsInteger;
      Result.FkPortEmb       := qrSupplier.FieldByName('FK_PORTOS__EMB').AsInteger;
      Result.FkTypeDiscount  := qrSupplier.FieldByName('FK_DESCONTOS').AsInteger;
      Result.FkTypePayment.PkTypePgto   := qrSupplier.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
      Result.FkAgent         := qrSupplier.FieldByName('FK_VW_CADASTROS').AsInteger;
      Result.FkCarrier       := qrSupplier.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
      Result.FlagProdDef     := (qrSupplier.FieldByName('FLAG_PROD_DEF').AsInteger = 1);
      Result.FlagTrn         := (qrSupplier.FieldByName('FLAG_TRN').AsInteger = 1);
      Result.FkPriceTable    := qrSupplier.FieldByName('FK_TABELA_PRECOS').AsInteger;
      Result.FkTypeFraction  := qrSupplier.FieldByName('FK_TIPO_TABELA_FRACAO').AsInteger;
      Result.NomVnd          := qrSupplier.FieldByName('NOM_VND').AsString;
    end;
  finally
    if qrSupplier.Active then qrSupplier.Close;
    Dados.CommitTransaction(qrSupplier);
  end;
end;

function TdmSysCad.GetEmployeeData(APk: Integer): TEmployee;
begin
  Result := TEmployee.Create;
  if qrFuncionario.Active then qrFuncionario.Close;
  qrFuncionario.SQL.Clear;
  qrFuncionario.SQL.Add(SqlEmployee);
  Dados.StartTransaction(qrFuncionario);
  try
    qrFuncionario.ParamByName('FkCadastros').AsInteger := APk;
    if (not qrFuncionario.Active) then qrFuncionario.Open;
    Result.AnoCheg           := qrFuncionario.FieldByName('ANO_CHEG').AsInteger;
    Result.CodCtb            := qrFuncionario.FieldByName('COD_CTB').AsInteger;
    Result.ComVnd            := qrFuncionario.FieldByName('COM_VND').AsFloat;
    Result.DsctMax           := qrFuncionario.FieldByName('DSCT_MAX').AsFloat;
    Result.DtaAdm            := qrFuncionario.FieldByName('DTA_ADM').AsDateTime;
    Result.DtaApst           := qrFuncionario.FieldByName('DTA_APST').AsDateTime;
    Result.DtaCad            := qrFuncionario.FieldByName('DTA_CAD').AsDateTime;
    Result.DtaEmiRg          := qrFuncionario.FieldByName('DTA_EMI_RG').AsDateTime;
    Result.DtaExp            := qrFuncionario.FieldByName('DTA_EXP').AsDateTime;
    Result.DtaNasc           := qrFuncionario.FieldByName('DTA_NASC').AsDateTime;
    Result.DtaNascFilho      := qrFuncionario.FieldByName('DTA_NASC_FILHO').AsDateTime;
    Result.FkBank.PkBank     := qrFuncionario.FieldByName('FK_BANCOS').AsInteger;
    if (qrFuncionario.FieldByName('CONTA').AsString <> '') then
    begin
      with Result.FkBank.Agencies.Add do
        with BankAccounts.Add do
          CodCta             := qrFuncionario.FieldByName('CONTA').AsString;
    end;
    Result.FkBankFgts.PkBank := qrFuncionario.FieldByName('FK_BANCOS__FGTS').AsInteger;
    if (qrFuncionario.FieldByName('CONTA_VINC').AsString <> '') then
    begin
      with Result.FkBankFgts.Agencies.Add do
        with BankAccounts.Add do
          CodCta             := qrFuncionario.FieldByName('CONTA_VINC').AsString;
    end;
    Result.FkBornFrom.PkCity := qrFuncionario.FieldByName('FK_MUNICIPIOS').AsInteger;
    Result.FkBornFrom.FkState.PkState := qrFuncionario.FieldByName('FK_ESTADOS').AsString;
    Result.FkBornFrom.FkState.FkCountry.PKCountry := qrFuncionario.FieldByName('FK_PAISES').AsInteger;
    Result.FkCostsCenter     := qrFuncionario.FieldByName('FK_CENTRO_CUSTOS').AsInteger;
    Result.FkDepartament     := qrFuncionario.FieldByName('FK_DEPARTAMENTOS').AsInteger;
    Result.FkFunctions       := qrFuncionario.FieldByName('FK_TIPO_CARGOS').AsInteger;
    Result.FkSector          := qrFuncionario.FieldByName('FK_SETOR').AsInteger;
    Result.FkTypeComission   := qrFuncionario.FieldByName('FK_TIPO_COMISSOES').AsInteger;
    Result.FlagApst          := Boolean(qrFuncionario.FieldByName('FLAG_APST').AsInteger);
    Result.FlagCrg           := TPostType(qrFuncionario.FieldByName('FLAG_CRG').AsInteger);
    Result.FlagDef           := Boolean(qrFuncionario.FieldByName('FLAG_DEF').AsInteger);
    Result.FlagEstCiv        := TCivilState(qrFuncionario.FieldByName('FLAG_ESTCV').AsInteger);
    Result.FlagGrInstr       := TSchoolLevel(qrFuncionario.FieldByName('FLAG_GRINSTR').AsInteger);
    Result.FlagOpPrv         := Boolean(qrFuncionario.FieldByName('FLAG_OPPRV').AsInteger);
    Result.FlagSex           := TSexType(qrFuncionario.FieldByName('FLAG_SEXO').AsInteger);
    Result.FlagTempr         := Boolean(qrFuncionario.FieldByName('FLAG_TEMPR').AsInteger);
    Result.FlagTSal          := TTypeSalary(qrFuncionario.FieldByName('FLAG_TSAL').AsInteger);
    Result.HabProf           := qrFuncionario.FieldByName('HAB_PROF').AsString;
    Result.NomConslh         := qrFuncionario.FieldByName('NOM_CONSLH').AsString;
    Result.NomMae            := qrFuncionario.FieldByName('NOM_MAE').AsString;
    Result.NomPai            := qrFuncionario.FieldByName('NOM_PAI').AsString;
    Result.NomSind           := qrFuncionario.FieldByName('NOM_SIND').AsString;
    Result.NumCtps           := qrFuncionario.FieldByName('NUM_CTPS').AsInteger;
    Result.NumDepIr          := qrFuncionario.FieldByName('NUM_DEP_IR').AsInteger;
    Result.NumFunc           := qrFuncionario.FieldByName('NUM_FUNC').AsInteger;
    Result.NumReg            := qrFuncionario.FieldByName('NUM_REG').AsString;
    Result.NumTit            := qrFuncionario.FieldByName('NUM_TIT').AsString;
    Result.PercInsl          := qrFuncionario.FieldByName('PERC_INS').AsFloat;
    Result.PercPeric         := qrFuncionario.FieldByName('PERC_PERIC').AsFloat;
    Result.PisFunc           := qrFuncionario.FieldByName('PIS_FUNC').AsString;
    Result.QtdFilhos         := qrFuncionario.FieldByName('QTD_FILHO').AsInteger;
    Result.QtdHours          := qrFuncionario.FieldByName('QTD_HORAS').AsInteger;
    Result.RacaCor           := qrFuncionario.FieldByName('RACA_COR').AsString;
    Result.RefLivro          := qrFuncionario.FieldByName('REF_LIVRO').AsInteger;
    Result.SecaoTit          := qrFuncionario.FieldByName('SECAO_TIT').AsString;
    Result.SerCtps           := qrFuncionario.FieldByName('SER_CTPS').AsString;
    Result.SitApst           := qrFuncionario.FieldByName('SIT_APST').AsString;
    Result.TipoVisto         := qrFuncionario.FieldByName('TIPO_VISTO').AsString;
    Result.UfCtps            := qrFuncionario.FieldByName('UF_CTPS').AsString;
    Result.VincFun           := qrFuncionario.FieldByName('VINC_FUNC').AsString;
    Result.VlrSal            := qrFuncionario.FieldByName('VLR_SAL').AsFloat;
    Result.ZonaTit           := qrFuncionario.FieldByName('ZONA_TIT').AsString;
    Result.LotFun            := qrFuncionario.FieldByName('LOT_FUN').AsString;
    Result.FkCompany.PkCompany := qrFuncionario.FieldByName('FK_EMPRESAS').AsInteger;
  finally
    if qrFuncionario.Active then qrFuncionario.Close;
    Dados.CommitTransaction(qrFuncionario);
  end;
end;

function TdmSysCad.CheckOwnerDocument(var ADoc: string; var APk: Integer;
  AType: TTypeDocs): Integer;
begin
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  if (AType = tdBoth) then
    qrSqlAux.SQL.Add(SqlCheckDocs)
  else
    qrSqlAux.SQL.Add(SqlCheckDoc);
  Dados.StartTransaction(qrSqlAux);
  try
    case AType of
      tdPrimary  :
      begin
        qrSqlAux.ParamByName('DocPri').AsString := ADoc;
        qrSqlAux.ParamByName('DocSec').AsString := '';
      end;
      tdSecondary:
      begin
        qrSqlAux.ParamByName('DocPri').AsString := '';
        qrSqlAux.ParamByName('DocSec').AsString := ADoc;
      end;
      tdBoth     : // when to use this param then the param ADoc must contains a
      begin        // separator of documents number using the symbol '|' (pipe)
        qrSqlAux.ParamByName('DocPri').AsString := Copy(ADoc, 1, Pos('|', ADoc) - 1);
        qrSqlAux.ParamByName('DocSec').AsString :=
          Copy(ADoc, Pos('|', ADoc) + 1, Length(ADoc) - Pos('|', ADoc));
      end;
    end;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result := qrSqlAux.FieldByName('QTD').AsInteger;
    ADoc   := qrSqlAux.FieldByName('RAZ_SOC').AsString;
    APk    := qrSqlAux.FieldByName('PK_CADASTROS').AsInteger;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysCad.GetEstablishment(APK: Integer): TDataRow;
begin
  if qrTipoEstblc.Active then qrTipoEstblc.Close;
  qrTipoEstblc.SQL.Clear;
  qrTipoEstblc.SQL.Add(SqlEstabelecimento);
  Dados.StartTransaction(qrTipoEstblc);
  try
    qrTipoEstblc.ParamByName('PkTipoEstabelecimentos').asInteger := APK;
    if not qrTipoEstblc.Active then qrTipoEstblc.Open;
    Result := TDataRow.CreateFromDataSet(nil,qrTipoEstblc,True);
  finally
    if qrTipoEstblc.Active then qrTipoEstblc.Close;
    Dados.CommitTransaction(qrTipoEstblc);
  end;
end;

function TdmSysCad.SaveTypeEstablishment(AData: TDataRow; AState: TDBMode): Integer;

  function GetPKEstblc : Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPKEstblc);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_TIPO_ESTABELECIMENTOS').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
  
begin
  if qrTipoEstblc.Active then qrTipoEstblc.Close;
  qrTipoEstblc.SQL.Clear;
  case aState of
    dbmDelete : qrTipoEstblc.SQL.Add(SqlDeleteEstblc);
    dbmInsert : qrTipoEstblc.SQL.Add(SqlInsertEstblc);
    dbmEdit   : qrTipoEstblc.SQL.Add(SqlUpdateEstblc);
  end;
  Dados.StartTransaction(qrTipoEstblc);
  try
    if aState = dbmInsert then
      aData.FieldByName['PK_TIPO_ESTABELECIMENTOS'].asInteger := GetPkEstblc;
    Result := aData.FieldByName['PK_TIPO_ESTABELECIMENTOS'].asInteger;
    qrTipoEstblc.ParamByName('PkTipoEstabelecimentos').asInteger := AData.FieldByName['PK_TIPO_ESTABELECIMENTOS'].AsInteger;
    if qrTipoEstblc.Params.FindParam('DscTest') <> nil then
      qrTipoEstblc.ParamByName('DscTest').asString := AData.FieldByName['DSC_TEST'].AsString;
    qrTipoEstblc.ExecSQL;
    Dados.CommitTransaction(qrTipoEstblc);
  except on E:Exception do
    begin
      if qrTipoEstblc.Active then qrTipoEstblc.Close;
      Dados.RollbackTransaction(qrTipoEstblc);
      raise Exception.Create('SaveTypeEstablishment: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrTipoEstblc.SQL.Text);
    end;
  end;
end;

function TdmSysCad.ValidateAlias(AAlias: string): Boolean;
begin
  if qrAlias.Active then qrAlias.Close;
  qrAlias.SQL.Clear;
  qrAlias.SQL.Add(SqlGetAlias);
  Dados.StartTransaction(qrAlias);
  try
    qrAlias.ParamByName('DscAlias').AsString := 'A';
    if (not qrAlias.Active) then qrAlias.Open;
    Result := (not qrAlias.IsEmpty);
  finally
    if qrAlias.Active then qrAlias.Close;
    Dados.CommitTransaction(qrAlias);
  end;
end;

function TdmSysCad.SaveAlias(AAlias: string): Integer;
  function GetPkAlias: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkAlias);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_TIPO_ALIAS').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrAlias.Active then qrAlias.Close;
  qrAlias.SQL.Clear;
  qrAlias.SQL.Add(SqlInsertAlias);
  Dados.StartTransaction(qrAlias);
  try
    Result := GetPkAlias;
    qrAlias.ParamByName('PkTipoAlias').AsInteger := Result;
    qrAlias.ParamByName('DscAlias').AsString     := AAlias;
    qrAlias.ExecSQL;
    Dados.CommitTransaction(qrAlias);
  except on E:Exception do
    begin
      if qrAlias.Active then qrAlias.Close;
      Dados.RollbackTransaction(qrAlias);
      raise Exception.Create('SaveAlias: Registro não pode ser salvo' + NL +
        E.Message + NL + qrAlias.SQL.Text);
    end;
  end;
end;

function TdmSysCad.LoadOwnerImage(const APk: Integer;
  var APkFound: Integer): TPicture;
begin
  APkFound := 0;
  Result := TPicture.Create;
  if (APk <= 0) then exit;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlOwnerImage);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.Params.FindParam('FkCadastros').AsInteger := APk;
    if not qrSqlAux.Active then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      GetImage_FromStream(TBlobField(qrSqlAux.FindField('IMG_CAD')), Result);
      APkFound := APk;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysCad.LoadOwnerObs(const APk: Integer; var APkFound: Integer): TStrings;
var
  M: TStream;
begin
  APkFound := 0;
  Result   := TStringList.Create;
  if (APk <= 0) then exit;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlOwnerObs);
  Dados.StartTransaction(qrSqlAux);
  M := TMemoryStream.Create;
  try
    if qrSqlAux.Params.FindParam('FkCadastros') <> nil then
      qrSqlAux.Params.FindParam('FkCadastros').AsInteger := APk;
    if not qrSqlAux.Active then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      TBlobField(qrSqlAux.FindField('OBS_CAD')).SaveToStream(M);
      M.Position := 0;
      Result.LoadFromStream(M);
      APkFound := APk;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
    FreeAndNil(M);
  end;
end;

procedure TdmSysCad.SaveOwnerImage(const APk: Integer; APicture: TGraphic; AType: Integer);
var
  M: TMemoryStream;
begin
  if (APicture = nil) or (APk <= 0) then exit;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  if (AType = 0) then
    qrSqlAux.SQL.Add(SqlOwnerInsertIm)
  else
    qrSqlAux.SQL.Add(SqlOwnerUpdateIm);
  M := TMemoryStream.Create;
  try
    qrSqlAux.ParamByName('FkCadastros').AsInteger := APk;
    APicture.SaveToStream(M);
    M.Position := 0;
    qrSqlAux.ParamByName('FlagTImg').AsInteger := Ord(GetTypeImage(M));
    M.Position := 0;
    qrSqlAux.ParamByName('ImgCad').LoadFromStream(M, ftBlob);
    qrSqlAux.ExecSQL;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    FreeAndNil(M);
  end;
end;

procedure TdmSysCad.SaveOwnerObs(const APk: Integer; ALines: TStrings; AType: Integer);
var
  M: TStream;
begin
  if (APk <= 0) then exit;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  if (AType = 0) then
    qrSqlAux.SQL.Add(SqlOwnerInsertOb)
  else
    qrSqlAux.SQL.Add(SqlOwnerUpdateOb);
  M := TMemoryStream.Create;
  try
    qrSqlAux.Params.FindParam('FkCadastros').AsInteger := APk;
    ALines.SaveToStream(M);
    M.Position := 0;
    qrSqlAux.ParamByName('ObsCad').LoadFromStream(M, ftBlob);
    qrSqlAux.ExecSQL;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    FreeAndNil(M);
  end;
end;

procedure TdmSysCad.SaveEmployeeData(const APk: Integer; AItem: TEmployee;
  AState: TDBMode);
var
  aWhr: TStrings;
begin
  if qrFuncionario.Active then qrFuncionario.Close;
  qrFuncionario.SQL.Clear;
  aWhr := TStringList.Create;
  try
    aWhr.Add('FK_CADASTROS');
    case AState of
      dbmEdit  : qrFuncionario.SQL.AddStrings(GetUpdateSQL(AItem.GetFields, aWhr, 'FUNCIONARIOS'));
      dbmInsert: qrFuncionario.SQL.AddStrings(GetInsertSQL(AItem.GetFields, 'FUNCIONARIOS'));
    end;
  finally
    FreeAndNil(aWhr);
  end;
  try
    qrFuncionario.ParamByName('FkCadastros').AsInteger        := APk;
    qrFuncionario.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
    qrFuncionario.ParamByName('FkDepartamentos').AsInteger    := AItem.FkDepartament;
    qrFuncionario.ParamByName('DtaCad').AsDate                := Date;
    qrFuncionario.ParamByName('FlagApst').AsInteger           := Ord(AItem.FlagApst);
    qrFuncionario.ParamByName('FlagCrg').AsInteger            := Ord(AItem.FlagCrg);
    qrFuncionario.ParamByName('FlagDef').AsInteger            := Ord(AItem.FlagDef);
    qrFuncionario.ParamByName('FlagEstCv').AsInteger          := Ord(AItem.FlagEstCiv);
    qrFuncionario.ParamByName('FlagGrInstr').AsInteger        := Ord(AItem.FlagGrInstr);
    qrFuncionario.ParamByName('FlagOpPrv').AsInteger          := Ord(AItem.FlagOpPrv);
    qrFuncionario.ParamByName('FlagSexo').AsInteger           := Ord(AItem.FlagSex);
    qrFuncionario.ParamByName('FlagTempr').AsInteger          := Ord(AItem.FlagTempr);
    qrFuncionario.ParamByName('FlagTSal').AsInteger           := Ord(AItem.FlagTSal);
    if (qrFuncionario.Params.FindParam('OldFkCadastros') <> nil) then
      qrFuncionario.ParamByName('OldFkCadastros').AsInteger   := APk;
    if (qrFuncionario.Params.FindParam('AnoCheg') <> nil) then
      qrFuncionario.ParamByName('AnoCheg').AsInteger          := AItem.AnoCheg;
    if (qrFuncionario.Params.FindParam('CodCtb') <> nil) then
      qrFuncionario.ParamByName('CodCtb').AsInteger           := AItem.CodCtb;
    if (qrFuncionario.Params.FindParam('ComVnd') <> nil) then
      qrFuncionario.ParamByName('ComVnd').AsFloat             := AItem.ComVnd;
    if (qrFuncionario.Params.FindParam('DsctMax') <> nil) then
      qrFuncionario.ParamByName('DsctMax').AsFloat            := AItem.DsctMax;
    if (qrFuncionario.Params.FindParam('DtaAdm') <> nil) then
      qrFuncionario.ParamByName('DtaAdm').AsDateTime          := AItem.DtaAdm;
    if (qrFuncionario.Params.FindParam('DtaApst') <> nil) then
      qrFuncionario.ParamByName('DtaApst').AsDateTime         := AItem.DtaApst;
    if (qrFuncionario.Params.FindParam('DtaEmiRg') <> nil) then
      qrFuncionario.ParamByName('DtaEmiRg').AsDateTime        := AItem.DtaEmiRg;
    if (qrFuncionario.Params.FindParam('DtaExp') <> nil) then
      qrFuncionario.ParamByName('DtaExp').AsDateTime          := AItem.DtaExp;
    if (qrFuncionario.Params.FindParam('DtaNasc') <> nil) then
      qrFuncionario.ParamByName('DtaNasc').AsDateTime         := AItem.DtaNasc;
    if (qrFuncionario.Params.FindParam('DtaNascFilho') <> nil) then
      qrFuncionario.ParamByName('DtaNascFilho').AsDateTime    := AItem.DtaNascFilho;
    if (qrFuncionario.Params.FindParam('FkBancos') <> nil) then
      qrFuncionario.ParamByName('FkBancos').AsInteger         := AItem.FkBank.PkBank;
    if (qrFuncionario.Params.FindParam('Conta') <> nil) then
      qrFuncionario.ParamByName('Conta').AsString             := AItem.FkBank.Agencies.Items[0].BankAccounts.Items[0].CodCta;
    if (qrFuncionario.Params.FindParam('FkBancosFgts') <> nil) then
      qrFuncionario.ParamByName('FkBancosFgts').AsInteger     := AItem.FkBankFgts.PkBank;
    if (qrFuncionario.Params.FindParam('ContaVinc') <> nil) then
      qrFuncionario.ParamByName('ContaVinc').AsString         := AItem.FkBankFgts.Agencies.Items[0].BankAccounts.Items[0].CodCta;
    if (qrFuncionario.Params.FindParam('FkMunicipios') <> nil) then
      qrFuncionario.ParamByName('FkMunicipios').AsInteger     := AItem.FkBornFrom.PkCity;
    if (qrFuncionario.Params.FindParam('FkEstados') <> nil) then
      qrFuncionario.ParamByName('FkEstados').AsString         := AItem.FkBornFrom.FkState.PkState;
    if (qrFuncionario.Params.FindParam('FkPaises') <> nil) then
      qrFuncionario.ParamByName('FkPaises').AsInteger         := AItem.FkBornFrom.FkState.FkCountry.PKCountry;
    if (qrFuncionario.Params.FindParam('FkCentroCustos') <> nil) then
      qrFuncionario.ParamByName('FkCentroCustos').AsInteger   := AItem.FkCostsCenter;
    if (qrFuncionario.Params.FindParam('FkTipoCargos') <> nil) then
      qrFuncionario.ParamByName('FkTipoCargos').AsInteger     := AItem.FkFunctions;
    if (qrFuncionario.Params.FindParam('FkSetor') <> nil) then
      qrFuncionario.ParamByName('FkSetor').AsInteger          := AItem.FkSector;
    if (qrFuncionario.Params.FindParam('FkTipoComissoes') <> nil) then
      qrFuncionario.ParamByName('FkTipoComissoes').AsInteger  := AItem.FkTypeComission;
    if (qrFuncionario.Params.FindParam('HabProf') <> nil) then
      qrFuncionario.ParamByName('HabProf').AsString           := AItem.HabProf;
    if (qrFuncionario.Params.FindParam('NomConslh') <> nil) then
      qrFuncionario.ParamByName('NomConslh').AsString         := AItem.NomConslh;
    if (qrFuncionario.Params.FindParam('NomMae') <> nil) then
      qrFuncionario.ParamByName('NomMae').AsString            := AItem.NomMae;
    if (qrFuncionario.Params.FindParam('NomPai') <> nil) then
      qrFuncionario.ParamByName('NomPai').AsString            := AItem.NomPai;
    if (qrFuncionario.Params.FindParam('NomSind') <> nil) then
      qrFuncionario.ParamByName('NomSind').AsString           := AItem.NomSind;
    if (qrFuncionario.Params.FindParam('NumCtps') <> nil) then
      qrFuncionario.ParamByName('NumCtps').AsInteger          := AItem.NumCtps;
    if (qrFuncionario.Params.FindParam('NumDepIr') <> nil) then
      qrFuncionario.ParamByName('NumDepIr').AsInteger         := AItem.NumDepIr;
    if (qrFuncionario.Params.FindParam('NumFunc') <> nil) then
      qrFuncionario.ParamByName('NumFunc').AsInteger          := AItem.NumFunc;
    if (qrFuncionario.Params.FindParam('NumReg') <> nil) then
      qrFuncionario.ParamByName('NumReg').AsString            := AItem.NumReg;
    if (qrFuncionario.Params.FindParam('NumTit') <> nil) then
      qrFuncionario.ParamByName('NumTit').AsString            := AItem.NumTit;
    if (qrFuncionario.Params.FindParam('PercIns') <> nil) then
      qrFuncionario.ParamByName('PercIns').AsFloat            := AItem.PercInsl;
    if (qrFuncionario.Params.FindParam('PercPeric') <> nil) then
      qrFuncionario.ParamByName('PercPeric').AsFloat          := AItem.PercPeric;
    if (qrFuncionario.Params.FindParam('PisFunc') <> nil) then
      qrFuncionario.ParamByName('PisFunc').AsString           := AItem.PisFunc;
    if (qrFuncionario.Params.FindParam('QtdFilho') <> nil) then
      qrFuncionario.ParamByName('QtdFilho').AsInteger         := AItem.QtdFilhos;
    if (qrFuncionario.Params.FindParam('QtdHoras') <> nil) then
      qrFuncionario.ParamByName('QtdHoras').AsInteger         := AItem.QtdHours;
    if (qrFuncionario.Params.FindParam('RacaCor') <> nil) then
      qrFuncionario.ParamByName('RacaCor').AsString           := AItem.RacaCor;
    if (qrFuncionario.Params.FindParam('RefLivro') <> nil) then
      qrFuncionario.ParamByName('RefLivro').AsInteger         := AItem.RefLivro;
    if (qrFuncionario.Params.FindParam('SecaoTit') <> nil) then
      qrFuncionario.ParamByName('SecaoTit').AsString          := AItem.SecaoTit;
    if (qrFuncionario.Params.FindParam('SerCtps') <> nil) then
      qrFuncionario.ParamByName('SerCtps').AsString           := AItem.SerCtps;
    if (qrFuncionario.Params.FindParam('SitApst') <> nil) then
      qrFuncionario.ParamByName('SitApst').AsString           := AItem.SitApst;
    if (qrFuncionario.Params.FindParam('TipoVisto') <> nil) then
      qrFuncionario.ParamByName('TipoVisto').AsString         := AItem.TipoVisto;
    if (qrFuncionario.Params.FindParam('UfCtps') <> nil) then
      qrFuncionario.ParamByName('UfCtps').AsString            := AItem.UfCtps;
    if (qrFuncionario.Params.FindParam('VincFunc') <> nil) then
      qrFuncionario.ParamByName('VincFunc').AsString          := AItem.VincFun;
    if (qrFuncionario.Params.FindParam('VlrSal') <> nil) then
      qrFuncionario.ParamByName('VlrSal').AsFloat             := AItem.VlrSal;
    if (qrFuncionario.Params.FindParam('ZonaTit') <> nil) then
      qrFuncionario.ParamByName('ZonaTit').AsString           := AItem.ZonaTit;
    if (qrFuncionario.Params.FindParam('LotFun') <> nil) then
      qrFuncionario.ParamByName('LotFun').AsString            := AItem.LotFun;
    qrFuncionario.ExecSql;
  except on E:Exception do
    begin
      if qrFuncionario.Active then qrFuncionario.Close;
      raise Exception.Create('SaveEmployeeData: Registro não pode ser salvo' + NL +
        E.Message + NL + qrFuncionario.SQL.Text);
    end;
  end;
end;

function TdmSysCad.LoadFinanceAccounts(const AAccountNat: TAccountNat;
  AFlagAnlSnt: Smallint = 0): TStrings;
var
  aObj: TClassification;
begin
  Result := TStringList.Create;
  with qrSqlAux do
  begin
    SQL.Clear;
    SQL.Add(SqlFinanceAccounts);
    Dados.StartTransaction(qrSqlAux);
    try
      ParamByName('FlagTCta').AsInteger   := Ord(AAccountNat);
      ParamByName('FlagAnlSnt').AsInteger := AFlagAnlSnt;
      if not Active then Open;
      Result.Add('<Nenhum>');
      while not (Eof) do
      begin
        aObj               := TClassification.Create;
        aObj.Pk            := FieldByName('R_PK_FINANCEIRO_CONTAS').AsInteger;
        aObj.FkAccountPlan := FieldByName('R_FK_FINANCEIRO_CONTAS').AsInteger;
        aObj.MaskCta       := FieldByName('R_MASK_CTA').AsString;
        aObj.DscClass      := FieldByName('R_DSC_CTA').AsString;
        aObj.NivCta        := FieldByName('R_GRAU_CTA').AsInteger;
        aObj.SeqCta        := FieldByName('R_SEQ_CTA').AsInteger;
        aObj.FlagAnlSnt    := Boolean(FieldByName('R_FLAG_ANL_SNT').AsInteger);
        aObj.FlagTCta      := TAccountNat(FieldByName('R_FLAG_TCTA').AsInteger);
        aObj.cbIndex       := Result.AddObject(InsereSpc(aObj.DscClass, 50) +
                                ' | ' + aObj.MaskCta, aObj);
        Next;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

procedure TdmSysCad.SetCategory(APk: Integer; const Value: TCategory);
  function GetPKCat : Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPKCat);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_CATEGORIAS').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrCategory.Active then qrCategory.Close;
  qrCategory.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrCategory.SQL.Add(SqlDeleteCat);
    dbmInsert : qrCategory.SQL.Add(SqlInsertCat);
    dbmEdit   : qrCategory.SQL.Add(SqlUpdateCat);
  end;
  if (Value.FkFinanceAcc = 0) then
    qrCategory.SQL.Text := StringReplace(qrCategory.SQL.Text, ':FkFinanceiroContas', 'null', []);
  if (Value.FkFinanceAccAcm = 0) then
    qrCategory.SQL.Text := StringReplace(qrCategory.SQL.Text, ':FkFinanceiroContasAcm', 'null', []);
  Dados.StartTransaction(qrCategory);
  try
    if (Value.PkCategory = 0) then
      Value.PkCategory := GetPkCat;
    qrCategory.ParamByName('pkCategorias').asInteger := Value.PKCategory;
    if qrCategory.Params.FindParam('DscCat') <> nil then
      qrCategory.ParamByName('DscCat').asString := Value.DscCat;
    if qrCategory.Params.FindParam('FlagCat') <> nil then
      qrCategory.ParamByName('FlagCat').asInteger := Ord(Value.FlagCat);
    if qrCategory.Params.FindParam('FkFinanceiroContas') <> nil then
      qrCategory.ParamByName('FkFinanceiroContas').asInteger := Value.FkFinanceAcc;
    if qrCategory.Params.FindParam('FkFinanceiroContasAcm') <> nil then
      qrCategory.ParamByName('FkFinanceiroContasAcm').asInteger := Value.FkFinanceAccAcm;
    qrCategory.ExecSQL;
    Dados.CommitTransaction(qrCategory);
  except on E:Exception do
    begin
      if qrCategory.Active then qrCategory.Close;
      Dados.RollbackTransaction(qrCategory);
      raise Exception.Create('SaveCategory: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrCategory.SQL.Text);
    end;
  end;
end;

function TdmSysCad.GetCategory(APK: Integer): TCategory;
begin
  if qrCategory.Active then qrCategory.Close;
  qrCategory.SQL.Clear;
  qrCategory.SQL.Add(SqlCategoria);
  Dados.StartTransaction(qrCategory);
  try
    qrCategory.ParamByName('PkCategorias').asInteger := APK;
    if not qrCategory.Active then qrCategory.Open;
    Result := TCategory.Create(nil);
    if not qrCategory.IsEmpty then
    begin
      Result.PkCategory      := qrCategory.FieldByName('PK_CATEGORIAS').AsInteger;
      Result.DscCat          := qrCategory.FieldByName('DSC_CAT').asString;
      Result.FlagCat         := TCategoryType(qrCategory.FieldByName('FLAG_CAT').AsInteger);
      Result.FkFinanceAcc    := qrCategory.FieldByName('FK_FINANCEIRO_CONTAS').AsInteger;
      Result.FkFinanceAccAcm := qrCategory.FieldByName('FK_FINANCEIRO_CONTAS_ACM').AsInteger;
    end;
  finally
    if qrCategory.Active then qrCategory.Close;
    Dados.CommitTransaction(qrCategory);
  end;
end;

function TdmSysCad.GetCountry(APk: Integer): TCountry;
begin
  Result := TCountry.Create;
  if qrCountry.Active then qrCountry.Close;
  qrCountry.SQL.Clear;
  qrCountry.SQL.Add(SqlCountry);
  Dados.StartTransaction(qrCountry);
  try
    qrCountry.ParamByName('PkPaises').AsInteger := APK;
    if not qrCountry.Active then qrCountry.Open;
    if not qrCountry.IsEmpty then
    begin
      Result.PKCountry   := qrCountry.FieldByName('PK_PAISES').AsInteger;
      Result.DscPais     := qrCountry.FieldByName('DSC_PAIS').AsString;
      Result.NacPais     := qrCountry.FieldByName('NAC_PAIS').AsString;
      Result.FlagAcm     := Boolean(qrCountry.FieldByName('FLAG_ACM').AsInteger);
      Result.FkLanguage.PkLanguage := qrCountry.FieldByName('FK_LINGUAGENS').AsString;
      Result.FkMoeda     := qrCountry.FieldByName('FK_TIPO_MOEDAS').AsInteger;
    end;
  finally
    if qrCountry.Active then qrCountry.Close;
    Dados.CommitTransaction(qrCountry);
  end;
end;

procedure TdmSysCad.SetCountry(APk: Integer; const Value: TCountry);
  function GetPkCountry : Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkCountry);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_PAISES').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrCountry.Active then qrCountry.Close;
  qrCountry.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrCountry.SQL.Add(SqlDeleteCountry);
    dbmInsert : qrCountry.SQL.Add(SqlInsertCountry);
    dbmEdit   : qrCountry.SQL.Add(SqlUpdateCountry);
  end;
  Dados.StartTransaction(qrCountry);
  try
    if (Value.PKCountry = 0) then
      Value.PKCountry := GetPkCountry;
    qrCountry.ParamByName('PkPaises').AsInteger := Value.PkCountry;
    if qrCountry.Params.FindParam('DscPais') <> nil then
      qrCountry.ParamByName('DscPais').AsString := Value.DscPais;
    if qrCountry.Params.FindParam('NacPais') <> nil then
      qrCountry.ParamByName('NacPais').AsString := Value.NacPais;
    if qrCountry.Params.FindParam('FlagAcm') <> nil then
      qrCountry.ParamByName('FlagAcm').AsInteger := Ord(Value.FlagAcm);
    if qrCountry.Params.FindParam('FkLinguagens') <> nil then
      qrCountry.ParamByName('FkLinguagens').AsString := Value.FkLanguage.PkLanguage;
    if qrCountry.Params.FindParam('FkTipoMoedas') <> nil then
      qrCountry.ParamByName('FkTipoMoedas').AsInteger := Value.FkMoeda;
    qrCountry.ExecSQL;
    Dados.CommitTransaction(qrCountry);
  except on E:Exception do
    begin
      if qrCountry.Active then qrCountry.Close;
      Dados.RollbackTransaction(qrCountry);
      raise Exception.Create('SetCountry: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrCountry.SQL.Text);
    end;
  end;
end;

function TdmSysCad.GetState(APk: LongInt): TState;
var
  Data: TState;
begin
  Result := TState.Create;
  Data := TState(APk);
  if (Data = nil) or (not (Data is TState)) then
    raise Exception.CreateFmt('GetState Error: Ponteiro da chave primária %d ' +
      'não pode ser acessado', [APk]);
  if qrState.Active then qrState.Close;
  qrState.SQL.Clear;
  qrState.SQL.Add(SqlState);
  Dados.StartTransaction(qrState);
  try
    qrState.ParamByName('FkPaises').AsInteger := Data.FkCountry.PKCountry;
    qrState.ParamByName('PkEstados').AsString := Data.PkState;
    if not qrState.Active then qrState.Open;
    if not qrState.IsEmpty then
    begin
      Result.FkCountry.PKCountry := qrState.FieldByName('FK_PAISES').AsInteger;
      Result.PkState             := qrState.FieldByName('PK_ESTADOS').AsString;
      Result.DscUF               := qrState.FieldByName('DSC_UF').AsString;
      Result.FkRegions           := qrState.FieldByName('FK_CARGAS_REGIOES').AsInteger;
    end;
  finally
    if qrState.Active then qrState.Close;
    Dados.CommitTransaction(qrState);
  end;
end;

procedure TdmSysCad.SetState(APk: LongInt; const Value: TState);
begin
  if qrState.Active then qrState.Close;
  qrState.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrState.SQL.Add(SqlDeleteState);
    dbmInsert : qrState.SQL.Add(SqlInsertState);
    dbmEdit   : qrState.SQL.Add(SqlUpdateState);
  end;
  if (Value.FkRegions = 0) and
     (qrState.Params.FindParam('FkCargasRegioes') <> nil) then
    qrState.SQL.Text := StringReplace(qrState.SQL.Text, ':FkCargasRegioes', 'null', [rfReplaceAll]);
  Dados.StartTransaction(qrState);
  try
    qrState.ParamByName('FkPaises').AsInteger := Value.FkCountry.PKCountry;
    qrState.ParamByName('PkEstados').AsString := Value.PkState;
    if qrState.Params.FindParam('DscUf') <> nil then
      qrState.ParamByName('DscUf').AsString   := Value.DscUF;
    if qrState.Params.FindParam('FkCargasRegioes') <> nil then
      qrState.ParamByName('FkCargasRegioes').AsInteger := Value.FkRegions;
    qrState.ExecSQL;
    Dados.CommitTransaction(qrState);
  except on E:Exception do
    begin
      if qrState.Active then qrState.Close;
      Dados.RollbackTransaction(qrState);
      raise Exception.Create('SetState: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrState.SQL.Text);
    end;
  end;
end;

function TdmSysCad.GetCity(APk: Integer): TCity;
begin
  Result := TCity.Create;
  if qrCity.Active then qrCity.Close;
  qrCity.SQL.Clear;
  qrCity.SQL.Add(SqlCity);
  Dados.StartTransaction(qrCity);
  try
    qrCity.ParamByName('FkPaises').AsInteger     := LocalKeys.PkCountry;
    qrCity.ParamByName('FkEstados').AsString     := LocalKeys.PkState;
    qrCity.ParamByName('PkMunicipios').AsInteger := APk;
    if not qrCity.Active then qrCity.Open;
    if not qrCity.IsEmpty then
    begin
      Result.FkState.FkCountry.PKCountry := qrCity.FieldByName('FK_PAISES').AsInteger;
      Result.FkState.PkState             := qrCity.FieldByName('FK_ESTADOS').AsString;
      Result.PkCity                      := qrCity.FieldByName('PK_MUNICIPIOS').AsInteger;
      Result.DscMun                      := qrCity.FieldByName('DSC_MUN').AsString;
      Result.FkRegions                   := qrCity.FieldByName('FK_CARGAS_REGIOES').AsInteger;
      Result.FlagCap                     := Boolean(qrCity.FieldByName('FLAG_CAP').AsInteger);
      Result.AlqtIss                     := qrCity.FieldByName('ALQ_ISS').AsFloat;
      Result.CepMun                      := qrCity.FieldByName('CEP_MUN').AsInteger;
    end;
  finally
    if qrCity.Active then qrCity.Close;
    Dados.CommitTransaction(qrCity);
  end;
end;

procedure TdmSysCad.SetCity(APk: Integer; const Value: TCity);
  function GetPkCity : Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkCity);
    qrSqlAux.ParamByName('FkPaises').AsInteger     := LocalKeys.PkCountry;
    qrSqlAux.ParamByName('FkEstados').AsString     := LocalKeys.PkState;
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_MUNICIPIOS').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  //  first delete all tax codes for this record
  if (Value.PkCity > 0) then
  begin
    if qrCity.Active then qrCity.Close;
    qrCity.SQL.Clear;
    qrCity.SQL.Add(SqlDeletePrinterTaxes);
    Dados.StartTransaction(qrCity);
    try
      qrCity.ParamByName('FkPaises').AsInteger     := LocalKeys.PkCountry;
      qrCity.ParamByName('FkEstados').AsString     := LocalKeys.PkState;
      qrCity.ParamByName('FkMunicipios').AsInteger := Value.PkCity;
      qrCity.ExecSQL;
      Dados.CommitTransaction(qrCity);
    except on E:Exception do
      begin
        if qrCity.Active then qrCity.Close;
        Dados.RollbackTransaction(qrCity);
        raise Exception.Create('SetCity: Erro ao excluir registros da tabela filha!' + NL +
              E.Message + NL + qrCity.SQL.Text);
      end;
    end;
  end;
  if qrCity.Active then qrCity.Close;
  qrCity.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrCity.SQL.Add(SqlDeleteCity);
    dbmInsert : qrCity.SQL.Add(SqlInsertCity);
    dbmEdit   : qrCity.SQL.Add(SqlUpdateCity);
  end;
  Dados.StartTransaction(qrCity);
  try
    if (Value.PkCity <= 0) then
      Value.PkCity := GetPkCity;
    qrCity.ParamByName('FkPaises').AsInteger     := LocalKeys.PkCountry;
    qrCity.ParamByName('FkEstados').AsString     := LocalKeys.PkState;
    qrCity.ParamByName('PkMunicipios').AsInteger := Value.PkCity;
    if (qrCity.Params.FindParam('DscMun') <> nil) then
      qrCity.ParamByName('DscMun').AsString      := Value.DscMun;
    if (qrCity.Params.FindParam('FkCargasRegioes') <> nil) then
      qrCity.ParamByName('FkCargasRegioes').AsInteger := Value.FkRegions;
    if (qrCity.Params.FindParam('AlqIss') <> nil) then
      qrCity.ParamByName('AlqIss').AsFloat            := Value.FkRegions;
    if (qrCity.Params.FindParam('CepMun') <> nil) then
      qrCity.ParamByName('CepMun').AsInteger          := Value.CepMun;
    if (qrCity.Params.FindParam('FlagCap') <> nil) then
      qrCity.ParamByName('FlagCap').AsInteger         := Ord(Value.FlagCap);
    qrCity.ExecSQL;
    Dados.CommitTransaction(qrCity);
  except on E:Exception do
    begin
      if qrCity.Active then qrCity.Close;
      Dados.RollbackTransaction(qrCity);
      raise Exception.Create('SetCity: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrCity.SQL.Text);
    end;
  end;
end;

function TdmSysCad.LoadRegions(AFlagGeneric: Boolean): TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeRegions);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FlagGeneric').AsInteger := Ord(AFlagGeneric);
    qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.AddObject('<Nenhuma>', nil);
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FindField('DSC_REG').AsString,
          TObject(qrSqlAux.FindField('PK_CARGAS_REGIOES').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

procedure TdmSysCad.SetCityTaxes(APk: Integer; const Value: TCityTax);
begin
  if qrCity.Active then qrCity.Close;
  qrCity.SQL.Clear;
  qrCity.SQL.Add(SqlInsertPrinterTaxes);
  Dados.StartTransaction(qrCity);
  try
    qrCity.ParamByName('FkPaises').AsInteger     := LocalKeys.PkCountry;
    qrCity.ParamByName('FkEstados').AsString     := LocalKeys.PkState;
    qrCity.ParamByName('FkMunicipios').AsInteger := LocalKeys.PkCity;
    qrCity.ParamByName('PkSuportedPrinters').AsInteger := Value.PkSportedPrinter;
    if (qrCity.Params.FindParam('CodIssEcf') <> nil) then
      qrCity.ParamByName('CodIssEcf').AsInteger         := Value.CodAlqt;
    qrCity.ExecSQL;
    Dados.CommitTransaction(qrCity);
  except on E:Exception do
    begin
      if qrCity.Active then qrCity.Close;
      Dados.RollbackTransaction(qrCity);
      raise Exception.Create('SetCity: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrCity.SQL.Text);
    end;
  end;
end;

function TdmSysCad.GetDistrict(APk: Integer): TDistrict;
begin
  Result := TDistrict.Create;
  if qrDistrict.Active then qrDistrict.Close;
  qrDistrict.SQL.Clear;
  qrDistrict.SQL.Add(SqlState);
  Dados.StartTransaction(qrDistrict);
  try
    qrDistrict.ParamByName('FkPaises').AsInteger     := LocalKeys.PkCountry;
    qrDistrict.ParamByName('FkEstados').AsString     := LocalKeys.PkState;
    qrDistrict.ParamByName('FkMunicipios').AsInteger := LocalKeys.PkCity;
    qrDistrict.ParamByName('PkBairros').AsInteger    := APk;
    if not qrDistrict.Active then qrDistrict.Open;
    if not qrDistrict.IsEmpty then
    begin
      Result.FkCity.FkState.FkCountry.PKCountry := qrDistrict.FieldByName('FK_PAISES').AsInteger;
      Result.FkCity.FkState.PkState             := qrDistrict.FieldByName('FK_ESTADOS').AsString;
      Result.FkCity.PkCity                      := qrDistrict.FieldByName('FK_MUNICIPIOS').AsInteger;
      Result.DscBai                             := qrDistrict.FieldByName('DSC_MUN').AsString;
      Result.CepBai                             := qrDistrict.FieldByName('CEP_MUN').AsInteger;
    end;
  finally
    if qrDistrict.Active then qrDistrict.Close;
    Dados.CommitTransaction(qrDistrict);
  end;
end;

procedure TdmSysCad.SetDistrict(APk: Integer; const Value: TDistrict);
  function GetPkDistrict: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkDistrict);
    qrSqlAux.ParamByName('FkPaises').AsInteger     := LocalKeys.PkCountry;
    qrSqlAux.ParamByName('FkEstados').AsString     := LocalKeys.PkState;
    qrSqlAux.ParamByName('FkMunicipios').AsInteger := LocalKeys.PkCity;
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_BAIRROS').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrDistrict.Active then qrDistrict.Close;
  qrDistrict.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrCity.SQL.Add(SqlDeleteDistrict);
    dbmInsert : qrCity.SQL.Add(SqlInsertDistrict);
    dbmEdit   : qrCity.SQL.Add(SqlUpdateDistrict);
  end;
  Dados.StartTransaction(qrDistrict);
  try
    if (Value.PkDistrict <= 0) then
      Value.PkDistrict := GetPkDistrict;
    qrDistrict.ParamByName('FkPaises').AsInteger     := LocalKeys.PkCountry;
    qrDistrict.ParamByName('FkEstados').AsString     := LocalKeys.PkState;
    qrDistrict.ParamByName('FkMunicipios').AsInteger := LocalKeys.PkCity;
    qrDistrict.ParamByName('PKBairros').AsInteger    := Value.PkDistrict;
    if (qrDistrict.Params.FindParam('DscBai') <> nil) then
      qrDistrict.ParamByName('DscBai').AsString      := Value.DscBai;
    if (qrDistrict.Params.FindParam('CepBai') <> nil) then
      qrDistrict.ParamByName('CepBai').AsInteger     := Value.CepBai;
    qrDistrict.ExecSQL;
    Dados.CommitTransaction(qrDistrict);
  except on E:Exception do
    begin
      if qrDistrict.Active then qrDistrict.Close;
      Dados.RollbackTransaction(qrDistrict);
      raise Exception.Create('SetDistrict: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrDistrict.SQL.Text);
    end;
  end;
end;

function TdmSysCad.GetLocality(APk: Integer): TLocality;
begin
  Result := TLocality.Create;
  if qrLocality.Active then qrLocality.Close;
  qrLocality.SQL.Clear;
  qrLocality.SQL.Add(SqlState);
  Dados.StartTransaction(qrLocality);
  try
    qrLocality.ParamByName('FkPaises').AsInteger      := LocalKeys.PkCountry;
    qrLocality.ParamByName('FkEstados').AsString      := LocalKeys.PkState;
    qrLocality.ParamByName('FkMunicipios').AsInteger  := LocalKeys.PkCity;
    qrLocality.ParamByName('FkBairros').AsInteger     := LocalKeys.PkDistrict;
    qrLocality.ParamByName('PkLogradouros').AsInteger := APk;
    if not qrLocality.Active then qrLocality.Open;
    if not qrLocality.IsEmpty then
    begin
      Result.FkDistrict.FkCity.FkState.FkCountry.PKCountry := qrLocality.FieldByName('FK_PAISES').AsInteger;
      Result.FkDistrict.FkCity.FkState.PkState             := qrLocality.FieldByName('FK_ESTADOS').AsString;
      Result.FkDistrict.FkCity.PkCity                      := qrLocality.FieldByName('FK_MUNICIPIOS').AsInteger;
      Result.FkDistrict.PkDistrict                         := qrLocality.FieldByName('FK_BAIRROS').AsInteger;
      Result.DscLog                             := qrLocality.FieldByName('DSC_LOG').AsString;
      Result.CepLog                             := qrLocality.FieldByName('CEP_LOG').AsInteger;
      Result.NumFin                             := qrLocality.FieldByName('NUM_FIN').AsInteger;
      Result.NumIni                             := qrLocality.FieldByName('NUM_INI').AsInteger;
      Result.FkAddressType.PkAddressType        := qrLocality.FieldByName('FK_TIPO_ENDERECOS').AsInteger;
    end;
  finally
    if qrLocality.Active then qrLocality.Close;
    Dados.CommitTransaction(qrLocality);
  end;
end;

procedure TdmSysCad.SetLocality(APk: Integer; const Value: TLocality);
  function GetPkLocality: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkDistrict);
    qrSqlAux.ParamByName('FkPaises').AsInteger     := LocalKeys.PkCountry;
    qrSqlAux.ParamByName('FkEstados').AsString     := LocalKeys.PkState;
    qrSqlAux.ParamByName('FkMunicipios').AsInteger := LocalKeys.PkCity;
    qrSqlAux.ParamByName('FkBairros').AsInteger    := LocalKeys.PkDistrict;
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_LOGRADOUROS').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrLocality.Active then qrLocality.Close;
  qrLocality.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrLocality.SQL.Add(SqlDeleteLocale);
    dbmInsert : qrLocality.SQL.Add(SqlInsertLocale);
    dbmEdit   : qrLocality.SQL.Add(SqlUpdateLocale);
  end;
  Dados.StartTransaction(qrLocality);
  try
    if (Value.PkLocality <= 0) then
      Value.PkLocality := GetPkLocality;
    qrLocality.ParamByName('FkPaises').AsInteger      := LocalKeys.PkCountry;
    qrLocality.ParamByName('FkEstados').AsString      := LocalKeys.PkState;
    qrLocality.ParamByName('FkMunicipios').AsInteger  := LocalKeys.PkCity;
    qrLocality.ParamByName('FkBairros').AsInteger     := LocalKeys.PkDistrict;
    qrLocality.ParamByName('PkLogradouros').AsInteger := Value.PkLocality;
    if (qrLocality.Params.FindParam('DscLoc') <> nil) then
      qrLocality.ParamByName('DscLoc').AsString      := Value.DscLog;
    if (qrLocality.Params.FindParam('CepLoc') <> nil) then
      qrLocality.ParamByName('CepLoc').AsInteger     := Value.CepLog;
    if (qrLocality.Params.FindParam('NumFin') <> nil) then
      qrLocality.ParamByName('NumFin').AsInteger     := Value.NumFin;
    if (qrLocality.Params.FindParam('NumIni') <> nil) then
      qrLocality.ParamByName('NumIni').AsInteger     := Value.NumIni;
    if (qrLocality.Params.FindParam('FkTipoEnderecos') <> nil) then
      qrLocality.ParamByName('FkTipoEnderecos').AsInteger := Value.FkAddressType.PkAddressType;
    if (qrLocality.Params.FindParam('FlagLado') <> nil) then
      qrLocality.ParamByName('FlagLado').AsInteger     := Value.FlagSide;
    qrLocality.ExecSQL;
    Dados.CommitTransaction(qrLocality);
  except on E:Exception do
    begin
      if qrLocality.Active then qrLocality.Close;
      Dados.RollbackTransaction(qrLocality);
      raise Exception.Create('SetLocality: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrLocality.SQL.Text);
    end;
  end;
end;

function TdmSysCad.GetAddrType(APk: Integer): TAddressType;
begin
  Result := TAddressType.Create;
  if (qrTypeAddr.Active) then qrTypeAddr.Close;
  qrTypeAddr.SQL.Clear;
  qrTypeAddr.SQL.Add(SqlTypeAddress);
  Dados.StartTransaction(qrTypeAddr);
  try
    qrTypeAddr.ParamByName('PkTipoEnderecos').AsInteger := APk;
    if (not qrTypeAddr.Active) then qrTypeAddr.Open;
    Result.PkAddressType := qrTypeAddr.FindField('PK_TIPO_ENDERECOS').AsInteger;
    Result.DscTEnd       := qrTypeAddr.FindField('DSC_TPE').AsString;
  finally
    if (qrTypeAddr.Active) then qrTypeAddr.Close;
    Dados.CommitTransaction(qrTypeAddr);
  end;
end;

procedure TdmSysCad.SetAddrType(APk: Integer; const Value: TAddressType);
  function GetPkAddressType: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkTypeAddress);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_TIPO_ENDERECOS').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrTypeAddr.Active then qrTypeAddr.Close;
  qrTypeAddr.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrTypeAddr.SQL.Add(SqlDeleteTypeAddress);
    dbmInsert : qrTypeAddr.SQL.Add(SqlInsertTypeAddress);
    dbmEdit   : qrTypeAddr.SQL.Add(SqlUpdateTypeAddress);
  end;
  Dados.StartTransaction(qrTypeAddr);
  try
    if (Value.PkAddressType <= 0) then
      Value.PkAddressType := GetPkAddressType;
    qrTypeAddr.ParamByName('PkTipoEnderecos').AsInteger := Value.PkAddressType;
    if (qrTypeAddr.Params.FindParam('DscTpe') <> nil) then
      qrTypeAddr.ParamByName('DscTpe').AsString         := Value.DscTEnd;
    qrTypeAddr.ExecSQL;
    Dados.CommitTransaction(qrTypeAddr);
  except on E:Exception do
    begin
      if qrTypeAddr.Active then qrTypeAddr.Close;
      Dados.RollbackTransaction(qrTypeAddr);
      raise Exception.Create('SetAddrType: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrTypeAddr.SQL.Text);
    end;
  end;
end;

function TdmSysCad.GetRegions(APk: Integer): TDataRow;
begin
  if (qrRegions.Active) then qrRegions.Close;
  qrRegions.SQL.Clear;
  qrRegions.SQL.Add(SqlRegion);
  Dados.StartTransaction(qrRegions);
  try
    qrRegions.ParamByName('PkCargasRegioes').AsInteger := APk;
    if (not qrRegions.Active) then qrRegions.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrRegions, True);
  finally
    if (qrRegions.Active) then qrRegions.Close;
    Dados.CommitTransaction(qrRegions);
  end;
end;

procedure TdmSysCad.SetRegions(APk: Integer; const Value: TDataRow);
  function GetPkRegion: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkRegions);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_CARGAS_REGIOES').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (Value = nil) or (Value.Count = 0) then
    raise Exception.Create('SetRegion: Parêmetros inválidos');
  if qrRegions.Active then qrRegions.Close;
  qrRegions.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrRegions.SQL.Add(SqlDeleteRegion);
    dbmInsert : qrRegions.SQL.Add(SqlInsertRegion);
    dbmEdit   : qrRegions.SQL.Add(SqlUpdateRegion);
  end;
  Dados.StartTransaction(qrRegions);
  try
    if (Value.FieldByName['PK_CARGAS_REGIOES'].AsInteger <= 0) then
      Value.FieldByName['PK_CARGAS_REGIOES'].AsInteger := GetPkRegion;
    qrRegions.ParamByName('PkCargasRegioes').AsInteger := Value.FieldByName['PK_CARGAS_REGIOES'].AsInteger;
    if (qrRegions.Params.FindParam('DscReg') <> nil) then
      qrRegions.ParamByName('DscReg').AsString         := Value.FieldByName['DSC_REG'].AsString;
    if (qrRegions.Params.FindParam('RefReg') <> nil) then
      qrRegions.ParamByName('RefReg').AsString         := Value.FieldByName['REF_REG'].AsString;
    if (qrRegions.Params.FindParam('FlagGeneric') <> nil) then
      qrRegions.ParamByName('FlagGeneric').AsInteger   := Value.FieldByName['FLAG_GENERIC'].AsInteger;
    qrRegions.ExecSQL;
    Dados.CommitTransaction(qrRegions);
  except on E:Exception do
    begin
      if qrRegions.Active then qrRegions.Close;
      Dados.RollbackTransaction(qrRegions);
      raise Exception.Create('SetRegions: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrRegions.SQL.Text);
    end;
  end;
end;

function TdmSysCad.LoadTypeDelivery: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeDeliveryPeriod);
  Dados.StartTransaction(qrSqlAux);
  if not qrSqlAux.Active then qrSqlAux.Open;
  try
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_PRZE').AsString,
        TObject(qrSqlAux.FieldByName('PK_TIPO_PRAZO_ENTREGA').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

procedure TdmSysCad.SetOwnerMovement(APk: Integer; const Value: TDataRow);
begin
  if qrOwnerMov.Active then qrOwnerMov.Close;
  qrOwnerMov.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrOwnerMov.SQL.Add(SqlDeleteOwnerMov);
    dbmInsert: qrOwnerMov.SQL.Add(SqlInsertOwnerMov);
  end;
  Dados.StartTransaction(qrOwnerMov);
  try
    qrOwnerMov.ParamByName('FkGruposMovimentos').AsInteger := Value.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
    qrOwnerMov.ParamByName('FkTipoMovimentos').AsInteger   := Value.FieldByName['PK_TIPO_MOVIMENTOS'].AsInteger;
    qrOwnerMov.ParamByName('FkCadastros').AsInteger        := Value.FieldByName['FK_CADASTROS'].AsInteger;
    qrOwnerMov.ExecSQL;
    Dados.CommitTransaction(qrOwnerMov);
  except on E:Exception do
    begin
      if qrOwnerMov.Active then qrOwnerMov.Close;
      Dados.RollbackTransaction(qrOwnerMov);
      raise Exception.Create('SetRegions: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrOwnerMov.SQL.Text);
    end;
  end;
end;

function TdmSysCad.LoadTypeTableFraction(AFkPriceTable: Integer): TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeFractionTable);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkTabelaPrecos').AsInteger := AFkPriceTable;
    if not qrSqlAux.Active then qrSqlAux.Open;
    Result.Add('<Nenhuma>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_TAB').AsString,
        TObject(qrSqlAux.FieldByName('PK_TIPO_TABELA_FRACAO').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysCad.GetTypeComission(APk: Integer): TDataRow;
begin
  if (qrTypeComission.Active) then qrTypeComission.Close;
  qrTypeComission.SQL.Clear;
  qrTypeComission.SQL.Add(SqlTypeComission);
  Dados.StartTransaction(qrTypeComission);
  try
    qrTypeComission.ParamByName('PkTipoComissoes').AsInteger := APk;
    if (not qrTypeComission.Active) then qrTypeComission.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTypeComission, True);
  finally
    if (qrTypeComission.Active) then qrTypeComission.Close;
    Dados.StartTransaction(qrTypeComission);
  end;
end;

procedure TdmSysCad.SetTypeComission(APk: Integer; const Value: TDataRow);
  function GetPkTypeComission: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenTypeComissions);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_TIPO_COMISSOES').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrTypeComission.Active then qrTypeComission.Close;
  qrTypeComission.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTypeComission.SQL.Add(SqlDelTypeComission);
    dbmInsert: qrTypeComission.SQL.Add(SqlInsTypeComission);
    dbmEdit  : qrTypeComission.SQL.Add(SqlUpdTypeComission);
  end;
  Dados.StartTransaction(qrTypeComission);
  try
    if (Value.FieldByName['PK_TIPO_COMISSOES'].AsInteger = 0) then
      Value.FieldByName['PK_TIPO_COMISSOES'].AsInteger := GetPkTypeComission;
    qrTypeComission.ParamByName('FkTipoComissoes').AsInteger  := Value.FieldByName['PK_TIPO_COMISSOES'].AsInteger;
    if (qrTypeComission.Params.FindParam('FkFinanceiroContsCr') <> nil) then
      qrTypeComission.ParamByName('FkFinanceiroContsCr').AsInteger := Value.FieldByName['FK_FINANCEIRO_CONTAS__CR'].AsInteger;
    if (qrTypeComission.Params.FindParam('FkFinanceiroContsDB') <> nil) then
      qrTypeComission.ParamByName('FkFinanceiroContsDB').AsInteger := Value.FieldByName['FK_FINANCEIRO_CONTAS__DB'].AsInteger;
    if (qrTypeComission.Params.FindParam('FlagTCom') <> nil) then
      qrTypeComission.ParamByName('FlagTCom').AsInteger := Value.FieldByName['FLAG_TCOM'].AsInteger;
    if (qrTypeComission.Params.FindParam('DscCom') <> nil) then
      qrTypeComission.ParamByName('DscCom').AsString := Value.FieldByName['DSC_COM'].AsString;
    if (qrTypeComission.Params.FindParam('PercCom') <> nil) then
      qrTypeComission.ParamByName('PercCom').AsFloat := Value.FieldByName['PERC_COM'].AsFloat;
    qrTypeComission.ExecSQL;
    Dados.CommitTransaction(qrTypeComission);
  except on E:Exception do
    begin
      if qrTypeComission.Active then qrTypeComission.Close;
      Dados.RollbackTransaction(qrTypeComission);
      raise Exception.Create('SetTypeComission: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrTypeComission.SQL.Text);
    end;
  end;
end;

function TdmSysCad.GetComRanges(APk: Integer): TList;
begin
  Result := TList.Create;
  if (qrTypeReduct.Active) then qrTypeReduct.Close;
  qrTypeReduct.SQL.Clear;
  qrTypeReduct.SQL.Add(SqlReductComission01);
  qrTypeReduct.SQL.Add(SqlReductComission02);
  qrTypeReduct.SQL.Add(SqlReductComission03);
  qrTypeReduct.SQL.Add(SqlReductComission04);
  Dados.StartTransaction(qrTypeReduct);
  try
    qrTypeReduct.ParamByName('FkTipoComissoes').AsInteger := APk;
    if (not qrTypeReduct.Active) then qrTypeReduct.Open;
    while (not qrTypeReduct.Eof) do
    begin
      Result.Add(TDataRow.CreateFromDataSet(nil, qrTypeReduct, True));
      qrTypeReduct.Next;
    end;
  finally
    if (qrTypeReduct.Active) then qrTypeReduct.Close;
    Dados.StartTransaction(qrTypeReduct);
  end;
end;

procedure TdmSysCad.SetComRanges(APk: Integer; const Value: TList);
var
  i: Integer;
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  ComisionRange[APk] := nil;
  for i := 0 to Value.Count - 1 do
    if (TDataRow(Value.Items[i]).FieldByName['PK_COMISSOES_REDUCOES'].AsInteger > 0) then
      ComisionRange[APk] := TDataRow(Value.Items[i]);
end;

procedure TdmSysCad.SetComisionRange(APk: Integer; const Value: TDataRow);
  function GetPkComissionRange: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenRangeComission);
    try
      qrSqlAux.ParamByName('FkTipoComissoes').AsInteger     := APk;
      qrSqlAux.ParamByName('PkComissoesReducoes').AsInteger := Value.FieldByName['PK_COMISSOES_REDUCOES'].AsInteger;
      if not qrSqlAux.Active then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_TIPO_COMISSOES').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrTypeReduct.Active then qrTypeReduct.Close;
  qrTypeReduct.SQL.Clear;
  qrTypeReduct.SQL.Add(SqlDelRedComission);
  Dados.StartTransaction(qrTypeReduct);
  try
    qrTypeReduct.ParamByName('FkTipoComissoes').AsInteger  := APk;
    qrTypeReduct.ExecSQL;
  except on E:Exception do
    begin
      if qrTypeReduct.Active then qrTypeReduct.Close;
      Dados.RollbackTransaction(qrTypeReduct);
      raise Exception.Create('SetComisionRange: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrTypeReduct.SQL.Text);
      exit;
    end;
  end;
  if (Value = nil) then exit;
  if qrTypeReduct.Active then qrTypeReduct.Close;
  qrTypeReduct.SQL.Add(SqlInsRedComission);
  try
    qrTypeReduct.ParamByName('FkTipoComissoes').AsInteger     := APk;
    qrTypeReduct.ParamByName('PkComissoesReducoes').AsInteger := Value.FieldByName['PK_COMISSOES_REDUCOES'].AsInteger;
    qrTypeReduct.ParamByName('DscRed').AsString               := Value.FieldByName['DSC_RED'].AsString;
    qrTypeReduct.ExecSQL;
  except on E:Exception do
    begin
      if qrTypeReduct.Active then qrTypeReduct.Close;
      Dados.RollbackTransaction(qrTypeReduct);
      raise Exception.Create('SetComisionRange€: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrTypeReduct.SQL.Text);
    end;
  end;
  if qrTypeReduct.Active then qrTypeReduct.Close;
  qrTypeReduct.SQL.Add(SqlInsRedComission);
  try
    if (Value.FieldByName['PK_COMISSOES_FAIXAS'].AsInteger = 0) then
      Value.FieldByName['PK_COMISSOES_FAIXAS'].AsInteger      := GetPkComissionRange;
    qrTypeReduct.ParamByName('FkTipoComissoes').AsInteger     := APk;
    qrTypeReduct.ParamByName('FkComissoesReducoes').AsInteger := Value.FieldByName['PK_COMISSOES_REDUCOES'].AsInteger;
    qrTypeReduct.ParamByName('PkComissoesFaixas').AsInteger   := Value.FieldByName['PK_COMISSOES_FAIXAS'].AsInteger;
    qrTypeReduct.ParamByName('VlrIni').AsFloat                := Value.FieldByName['VLR_INI'].AsFloat;
    qrTypeReduct.ParamByName('VlrFin').AsFloat                := Value.FieldByName['VLR_FIN'].AsFloat;
    qrTypeReduct.ParamByName('PercRed').AsFloat               := Value.FieldByName['PERC_RED'].AsFloat;
    qrTypeReduct.ExecSQL;
    Dados.CommitTransaction(qrTypeReduct);
  except on E:Exception do
    begin
      if qrTypeReduct.Active then qrTypeReduct.Close;
      Dados.RollbackTransaction(qrTypeReduct);
      raise Exception.Create('SetComisionRange€: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrTypeReduct.SQL.Text);
    end;
  end;
end;

function TdmSysCad.GetTypeBlock(APk: Integer): TTypeBlock;
begin
  Result := TTypeBlock.Create;
  with qrTypeBlock do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlSelectTypeBlock);
    Dados.StartTransaction(qrTypeBlock);
    try
      ParamByName('PkTipoBloqueios').AsInteger := APk;
      if (not Active) then Open;
      Result.PkTypeBlock := FieldByName('PK_TIPO_BLOQUEIOS').AsInteger;
      Result.DscBlock    := FieldByName('DSC_TBL').AsString;
      Result.FlagBlq     := Boolean(FieldByName('FLAG_BLQ').AsInteger);
      Result.FlagVaVs    := Boolean(FieldByName('FLAG_VAVS').AsInteger);
      Result.FlagMPgt    := Boolean(FieldByName('FLAG_MPGT').AsInteger);
      Result.FlagDtaBas  := Boolean(FieldByName('FLAG_DTABAS').AsInteger);
      Result.FlagCndPgt  := Boolean(FieldByName('FLAG_CONDP').AsInteger);
      Result.FlagLimCr   := Boolean(FieldByName('FLAG_LIMCR').AsInteger);
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrTypeBlock);
    end;
  end;
end;

procedure TdmSysCad.SetTypeBlock(APk: Integer; const Value: TTypeBlock);
var
  Data: TDataRow;
begin
  with qrTypeBlock do
  begin
    if Active then Close;
    SQL.Clear;
    case TDBMode(APk) of
      dbmDelete: SQL.Add(SqlDeleteTypeBlock);
      dbmInsert: SQL.Add(SqlInsertTypeBlock);
      dbmEdit  : SQL.Add(SqlUpdateTypeBlock);
    end;
    Dados.StartTransaction(qrTypeBlock);
    try
      if (Value.PkTypeBlock = 0) then
      begin
        Data := Dados.GetPk(SqlGenPkTypeBlocks, nil);
        if (Data <> nil) and (Data.FindField['PK_TIPO_BLOQUEIOS'] <> nil) then
          Value.PkTypeBlock := Data.FieldByName['PK_TIPO_BLOQUEIOS'].AsInteger
        else
          raise Exception.Create('SetTypeBlock Error: Can´t retrieve primary key form TTypeBlock');
      end;
      ParamByName('PkTipoBloqueios').AsInteger  := Value.PkTypeBlock;
      if (Params.FindParam('DscTbl')     <> nil) then
        ParamByName('DscTbl').AsString      := Value.DscBlock;
      if (Params.FindParam('FlagBlq')    <> nil) then
        ParamByName('FlagBlq').AsInteger    := Ord(Value.FlagBlq);
      if (Params.FindParam('FlagVaVs')   <> nil) then
        ParamByName('FlagVaVs').AsInteger   := Ord(Value.FlagVaVs);
      if (Params.FindParam('FlagMpgt')   <> nil) then
        ParamByName('FlagMpgt').AsInteger   := Ord(Value.FlagMPgt);
      if (Params.FindParam('FlagDtaBas') <> nil) then
        ParamByName('FlagDtaBas').AsInteger := Ord(Value.FlagDtaBas);
      if (Params.FindParam('FlagCondP')  <> nil) then
        ParamByName('FlagCondP').AsInteger  := Ord(Value.FlagCndPgt);
      if (Params.FindParam('FlagLimCr')  <> nil) then
        ParamByName('FlagLimCr').AsInteger  := Ord(Value.FlagLimCr);
      ExecSQL;
      Dados.CommitTransaction(qrTypeBlock);
    except on E:Exception do
      begin
        if Active then Close;
        Dados.RollbackTransaction(qrTypeBlock);
        raise Exception.Create('SetTypeBlock: Erro ao gravar ao registro!' + NL +
              E.Message + NL + SQL.Text);
      end;
    end;
  end;
end;

initialization
  Application.CreateForm(TdmSysCad, dmSysCad);
finalization
  if Assigned(dmSysCad) then dmSysCad.Free;
  dmSysCad := nil;
end.
