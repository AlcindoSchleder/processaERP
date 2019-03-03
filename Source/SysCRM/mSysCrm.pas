unit mSysCrm;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 06/03/2003 - DD/MM/YYYY                                      *}
{* Modified: 06/03/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
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
  DB, Encryp, ProcType, FMTBcd, SqlExpr, VpData, TSysCadAux, ProcUtils, TSysCad;

type
  TKeyLocal = record
    Resource: Integer;
    Contact : Integer;
    DateIni : TDate;
    DateFin : TDate;
    FlagCmpl: Integer;
    Operador: string;
    Evento  : Integer;
    Edicao  : Integer;
    Cadastro: Integer;
    Contato : Integer;
  end;

  TdmSysCrm = class(TDataModule)
    qrResource: TSQLQuery;
    qrSqlAux: TSQLQuery;
    qrContact: TSQLQuery;
    qrEvent: TSQLQuery;
    qrOperadores: TSQLQuery;
    qrCntEvt: TSQLQuery;
    qrCntInternet: TSQLQuery;
    qrCntCnt: TSQLQuery;
    qrPais: TSQLQuery;
    qrEstado: TSQLQuery;
    qrMunicipio: TSQLQuery;
    qrCategory: TSQLQuery;
    qrTask: TSQLQuery;
    qrAlias: TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetOwnerFromDataSet(ADataSet: TDataSet; AOwner: TOwner);
  public
    { Public declarations }
    function  LoadCountries: TStrings;
    function  LoadCompanies(ASuper: Boolean = False; AContacts: Boolean = False): TStrings;
//    function  LoadCompanies: TStrings;
    function  LoadStates(ACountry: TCountry): TStrings;
    function  LoadCities(AState: TState): TStrings;
    function  LoadResources(var AIndex: Integer): TStrings;
    procedure LoadEvents(const AStartDate, AEndDate: TDate; AResource: TVpResource);
    procedure LoadContacts(const AFlagSuper: Boolean; AResource: TVpResource);
    procedure LoadTasks(const AllTasks: Boolean; AResource: TVpResource;
                const AStartDate, AEndDate: TDate);
    function  LoadAlias: TStrings;
    function  ModifyAlias(const APkAlias: Integer; const ANameAlias: string;
                const AMode: TDBMode): Integer;
    procedure SetContactFromOwner(AOwner: TOwner; AResource: TVpResource;
      AIndex: Integer = -1);
    function  SaveAllContactData(AMode: TDbMode; AOwner: TOwner): Boolean;
    procedure DeleteCategoryLink(APkCad, APkCat: Integer; All: Boolean = False);
    procedure UpdateCategoryLink(APkCad, APkCat: Integer);
    procedure InsertCategoryLink(APkCad, APkCat: Integer);
    procedure DeleteResourceLink(APkCad, APkRes: Integer; All: Boolean = False);
    procedure InsertResourceLink(APkCad, APkRes: Integer);
    procedure SaveEvent(AEvent: TVpEvent; AResource: TVpResource;
      AContact: TOwner; AMode: TDBMode);
    procedure SaveTask(ATask: TVpTask; AResource: TVpResource; AMode: TDBMode);
  published
    { Published declarations }
  end;

var
  dmSysCrm: TdmSysCrm;

implementation

uses AltPass, Funcoes, Autor, FuncoesDB, ModelTyp, ArqSqlCrm, Dado, Mask,
  CmmConst, SqlComm, ArqCnstCrm, Math, TypInfo, TSysCrmAux, MaskUtils, CrmAgent,
  vpMisc, vpSR;

{$R *.DFM}

procedure TdmSysCrm.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

procedure TdmSysCrm.DataModuleDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (TDataSet(Components[i]).Active)       then
      TDataSet(Components[i]).Close;
end;

function  TdmSysCrm.LoadCountries: TStrings;
var
  aItem: TCountry;
begin
  Result := TStringList.Create;
  if (qrPais.Active) then qrPais.Close;
  qrPais.SQL.Clear;
  qrPais.SQL.Add(SqlPaises);
  Dados.StartTransaction(qrPais);
  qrPais.Open;
  try
    if (not qrPais.IsEmpty) then
    begin
      qrPais.First;
      Result.Add('... Nenhum ...');
      while not qrPais.Eof do
      begin
        aItem           := TCountry.Create;
        aItem.PKCountry := qrPais.FieldByName('PK_PAISES').AsInteger;
        aItem.DscPais   := qrPais.FieldByName('DSC_PAIS').AsString;
        aItem.cbIndex   := Result.AddObject(aItem.DscPais, aItem);
        qrPais.Next;
      end;
    end;
  finally
    if (qrPais.Active) then qrPais.Close;
    Dados.CommitTransaction(qrPais);
  end;
end;

function  TdmSysCrm.LoadCompanies(ASuper: Boolean = False; AContacts: Boolean = False): TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrPais.Active) then qrPais.Close;
  qrPais.SQL.Clear;
  if AContacts then
    if ASuper then
      qrPais.SQL.Add(SqlContactsAll)
    else
      qrPais.SQL.Add(SqlContactsUsr)
  else
    qrPais.SQL.Add(SqlCompany);
  Dados.StartTransaction(qrPais);
  qrPais.Open;
  try
    if (not qrPais.IsEmpty) then
    begin
      qrPais.First;
      Result.Add('... Nenhum ...');
      while not qrPais.Eof do
      begin
        aItem             := TOwner.Create;
        aItem.PkCadastros := qrPais.FindField('PK_CADASTROS').AsInteger;
        aItem.RazSoc      := qrPais.FindField('RAZ_SOC').AsString;
        aItem.FlagTCad    := TTypeOwner(qrPais.FindField('FLAG_TCAD').AsInteger);
        aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
        qrPais.Next;
      end;
    end;
  finally
    if (qrPais.Active) then qrPais.Close;
    Dados.CommitTransaction(qrPais);
  end;
end;

function  TdmSysCrm.LoadStates(ACountry: TCountry): TStrings;
var
  aItem: TState;
begin
  Result := TStringList.Create;
  if ACountry = nil then exit;
  if (qrEstado.Active) then qrEstado.Close;
  qrEstado.SQL.Clear;
  qrEstado.SQL.Add(SqlEstados);
  Dados.StartTransaction(qrEstado);
  if qrEstado.Params.FindParam('FkPaises') <> nil then
    qrEstado.Params.FindParam('FkPaises').AsInteger := ACountry.PKCountry;
  qrEstado.Open;
  try
    if (not qrEstado.IsEmpty) then
    begin
      qrEstado.First;
      Result.Add('... Nenhum ...');
      while not qrEstado.Eof do
      begin
        aItem         := TState.Create;
        aItem.FkCountry.Assign(ACountry);
        aItem.PkState := qrEstado.FindField('PK_ESTADOS').AsString;
        aItem.DscUF   := qrEstado.FindField('DSC_UF').AsString;
        aItem.cbIndex := Result.AddObject(aItem.DscUF, aItem);
        qrEstado.Next;
      end;
    end;
  finally
    if (qrEstado.Active) then qrEstado.Close;
    Dados.CommitTransaction(qrEstado);
  end;
end;

function  TdmSysCrm.LoadCities(AState: TState): TStrings;
var
  aItem: TCity;
begin
  Result := TStringList.Create;
  if AState = nil then exit;
  if (qrMunicipio.Active) then qrMunicipio.Close;
  qrMunicipio.SQL.Clear;
  qrMunicipio.SQL.Add(SqlMunicipios);
  Dados.StartTransaction(qrMunicipio);
  if qrMunicipio.Params.FindParam('FkPaises') <> nil then
    qrMunicipio.Params.FindParam('FkPaises').AsInteger  := AState.FkCountry.PkCountry;
  if qrMunicipio.Params.FindParam('FkEstados') <> nil then
    qrMunicipio.Params.FindParam('FkEstados').AsString := AState.PkState;
  if not qrMunicipio.Active then qrMunicipio.Open;
  try
    if (not qrMunicipio.IsEmpty) then
    begin
      qrMunicipio.First;
      Result.Add('... Nenhum ...');
      while not qrMunicipio.Eof do
      begin
        aItem         := TCity.Create;
        aItem.FkState.Assign(AState);
        aItem.PkCity  := qrMunicipio.FieldByName('PK_MUNICIPIOS').AsInteger;
        aItem.DscMun  := qrMunicipio.FieldByName('DSC_MUN').AsString;
        aItem.CepMun  := qrMunicipio.FieldByName('CEP_MUN').AsInteger;
        aItem.cbIndex := Result.AddObject(aItem.DscMun, aItem);
        qrMunicipio.Next;
      end;
    end;
  finally
    if (qrMunicipio.Active) then qrMunicipio.Close;
    Dados.CommitTransaction(qrMunicipio);
  end;
end;

function  TdmSysCrm.LoadResources(var AIndex: Integer): TStrings;
var
  aItem: TOperatorRes;
begin
  Result := TStringList.Create;
  if qrResource.Active then qrResource.Close;
  qrResource.SQL.Clear;
  qrResource.SQL.Add(SqlResources);
  Dados.StartTransaction(qrResource);
  try
    if not qrResource.Active then qrResource.Open;
    Result.AddObject('Selecionar Operador', nil);
    while (not qrResource.Eof) do
    begin
      aItem := TOperatorRes.Create;
      aItem.FkOperator.PkOperator := qrResource.FieldByName('FK_OPERADORES').AsString;
      aItem.FkOperator.eMailOpe   := qrResource.FieldByName('EMAIL_OPE').AsString;
      aItem.FkOperator.SenNet     := qrResource.FieldByName('SEN_NET').AsString;
      aItem.FkOperator.FkOwner    := qrResource.FieldByName('FK_CADASTROS').AsInteger;
      aItem.PkResources := qrResource.FieldByName('PK_RESOURCES').AsInteger;
      aItem.FlagAtv     := Boolean(qrResource.FieldByName('FLAG_ATV').AsInteger);
      aItem.FlagSuper   := Boolean(qrResource.FieldByName('FLAG_SUPER').AsInteger);
      aItem.cbIndex     := Result.AddObject(aItem.FkOperator.PkOperator, aItem);
      if Dados.Parametros.soUser = qrResource.FieldByName('FK_OPERADORES').AsString then
        AIndex := aItem.cbIndex;
      qrResource.Next;
    end;
  finally
    if qrResource.Active then qrResource.Close;
    Dados.CommitTransaction(qrResource);
  end;
end;

procedure TdmSysCrm.LoadEvents(const AStartDate, AEndDate:
            TDate; AResource: TVpResource);
var
  aItem: TVpEvent;
begin
  AResource.Schedule.ClearEvents;
  if qrEvent.Active then qrEvent.Close;
  qrEvent.SQL.Clear;
  qrEvent.SQL.Add(SqlEvents);
  Dados.StartTransaction(qrEvent);
  try
    qrEvent.ParamByName('FkResources').AsInteger := AResource.ResourceID;
    qrEvent.ParamByName('DthrIni').AsDate        := AStartDate;
    qrEvent.ParamByName('DthrFin').AsDate        := AEndDate;
    if not qrEvent.Active then qrEvent.Open;
    while (not qrEvent.Eof) do
    begin
      aItem := AResource.Schedule.AddEvent(qrEvent.FieldByName('PK_EVENTS').AsInteger,
         qrEvent.FieldByName('DTHR_INI').AsDateTime,
         qrEvent.FieldByName('DTHR_FIN').AsDateTime);
      if (aItem <> nil) then
      begin
        aItem.Loading        := True;
        aItem.AlarmWavPath   := qrEvent.FieldByName('DING_PATH').AsString;
        aItem.AlarmSet       := Boolean(qrEvent.FieldByName('FLAG_ALARM').AsInteger);
        aItem.AllDayEvent    := Boolean(qrEvent.FieldByName('FLAG_ALLDAY').AsInteger);
        aItem.Description    := qrEvent.FieldByName('DSC_EVENT').AsString;
        aItem.Note           := qrEvent.FieldByName('OBS_EVT').AsString;
        aItem.Category       := qrEvent.FieldByName('CTA_EVT').AsInteger;
        aItem.AlarmAdv       := qrEvent.FieldByName('INTRV_ALARM').AsInteger;
        aItem.AlarmAdvType   := TVpAlarmAdvType(qrEvent.FieldByName('FLAG_TALARM').AsInteger);
        aItem.SnoozeTime     := qrEvent.FieldByName('DTHR_RPT_EVT').AsDateTime;
        aItem.RepeatCode     := TVpRepeatType(qrEvent.FieldByName('FLAG_TREPEAT').AsInteger);
        aItem.RepeatRangeEnd := qrEvent.FieldByName('DTHR_RPD_FIM').AsDateTime;
        aItem.CustInterval   := qrEvent.FieldByName('INTRV_RPT').AsInteger;
        aItem.AlertDisplayed := False;
        aItem.Changed        := False;
        aItem.Deleted        := False;
        aItem.Loading        := False;
      end;
      qrEvent.Next;
    end;
  finally
    if qrEvent.Active then qrEvent.Close;
    Dados.CommitTransaction(qrEvent);
  end;
end;

procedure TdmSysCrm.LoadContacts(const AFlagSuper: Boolean; AResource: TVpResource);
var
  aOwner   : TOwner;
begin
  AResource.Contacts.ClearContacts;
  if qrContact.Active then qrContact.Close;
  qrContact.SQL.Clear;
  if AFlagSuper then
    qrContact.SQL.Add(SqlContactsAll)  // Get All Contacts
  else
    qrContact.SQL.Add(SqlContactsUsr); // Get user Contacts
  Dados.StartTransaction(qrContact);
  try
    if (qrContact.Params.FindParam('FkResources') <> nil) then
      qrContact.ParamByName('FkResources').AsInteger := AResource.ResourceID;
    if not qrContact.Active then qrContact.Open;
    while (not qrContact.Eof) do
    begin
      aOwner := TOwner.Create;
      SetOwnerFromDataSet(qrContact, aOwner);
      SetContactFromOwner(aOwner, AResource);
      qrContact.Next;
    end;
  finally
    if qrContact.Active then qrContact.Close;
    Dados.CommitTransaction(qrContact);
  end;
end;

procedure TdmSysCrm.SetOwnerFromDataSet(ADataSet: TDataSet; AOwner: TOwner);
var
  aCat: TCategory;
  aFon: TPhone;
  aEvt: TOwnerEvent;
  aNet: TInternetAddress;
begin
  AOwner.FkAlias        := ADataSet.FieldByName('FK_TIPO_ALIAS').AsInteger;
  AOwner.Address.EndAdd := ADataSet.FieldByName('END_CAD').AsString;
  AOwner.Address.CmpEnd := ADataSet.FieldByName('CMP_END').AsString;
  AOwner.Address.NumAdd := ADataSet.FieldByName('NUM_END').AsInteger;
  AOwner.Address.CepAdd := ADataSet.FieldByName('CEP_CAD').AsInteger;
  AOwner.Address.CxpAdd := ADataSet.FieldByName('CXP_CAD').AsString;
  AOwner.Address.FkCity.FkState.FkCountry.PKCountry := ADataSet.FieldByName('FK_PAISES').AsInteger;
  AOwner.Address.FkCity.FkState.FkCountry.DscPais   := ADataSet.FieldByName('DSC_PAIS').AsString;
  AOwner.Address.FkCity.FkState.PkState := ADataSet.FieldByName('FK_ESTADOS').AsString;
  AOwner.Address.FkCity.FkState.DscUF   := ADataSet.FieldByName('DSC_UF').AsString;
  AOwner.Address.FkCity.PkCity := ADataSet.FieldByName('FK_MUNICIPIOS').AsInteger;
  AOwner.Address.FkCity.DscMun := ADataSet.FieldByName('DSC_MUN').AsString;
  AOwner.AreaAtu      := ADataSet.FieldByName('AREA_ATU').AsString;
// Read Categories from table VINCULOS_CAD_CAT
  if qrCategory.Active then qrCntEvt.Close;
  qrCategory.SQL.Clear;
  qrCategory.SQL.Add(SqlCadCategory);
  qrCategory.ParamByName('PkCadastros').AsInteger :=
    ADataSet.FieldByName('PK_CADASTROS').AsInteger;
  if not qrCategory.Active then qrCategory.Open;
  while (not qrCategory.EOF) do
  begin
    aCat := AOwner.Categories.Add;
    aCat.DscCat     := qrCategory.FieldByName('DSC_CAT').AsString;
    aCat.FlagCat    := TCategoryType(qrCategory.FieldByName('FLAG_CAT').AsInteger);
    aCat.PkCategory := qrCategory.FieldByName('PK_CATEGORIAS').AsInteger;
    qrCategory.Next;
  end;
  if qrCategory.Active then qrCategory.Close;
  AOwner.DocPri       := ADataSet.FieldByName('DOC_PRI').AsString;
  AOwner.DocSec       := ADataSet.FieldByName('DOC_SEQ').AsString;
  AOwner.FkContacts   := ADataSet.FieldByName('FK_CONTACTS').AsInteger;
  AOwner.FlagEtq      := Boolean(ADataSet.FieldByName('FLAG_ETQ').AsInteger);
  AOwner.FlagTCad     := TTypeOwner(ADataSet.FieldByName('FLAG_TCAD').AsInteger);
  AOwner.FlagTCad     := TTypeOwner(ADataSet.FieldByName('FLAG_TCAD').AsInteger);
  AOwner.NomFan       := ADataSet.FieldByName('DSC_ALIAS').AsString;
//  AOwner.ObsCad.Assign(ADataSet.FieldByName('OBS_CAD'));
// Read from table CADASTROS_CONTATOS
  if qrCntCnt.Active then qrCntCnt.Close;
  qrCntCnt.SQL.Clear;
  qrCntCnt.SQL.Add(SqlCadContacts);
  qrCntCnt.ParamByName('FkCadastros').AsInteger :=
    ADataSet.FieldByName('PK_CADASTROS').AsInteger;
  if not qrCntCnt.Active then qrCntCnt.Open;
  while (not qrCntCnt.EOF) do
  begin
    aFon            := AOwner.Phones.Add;
//    aFon.FlagDef    := qrCntCnt.FieldByName('FLAG_DEF').AsString;
    aFon.DscPhone   := qrCntCnt.FieldByName('DSC_CNT').AsString;
    aFon.FonCad     := qrCntCnt.FieldByName('CNT_CNT').AsString;
    qrCntCnt.Next;
  end;
  if qrCntCnt.Active then qrCntCnt.Close;
  AOwner.PkCadastros  := ADataSet.FieldByName('PK_CADASTROS').AsInteger;
  AOwner.RazSoc       := ADataSet.FieldByName('RAZ_SOC').AsString;
  AOwner.Title        := ADataSet.FieldByName('TRT_CNT').AsString;
//   Read from table CADASTROS_EVENTOS
  if qrCntEvt.Active then qrCntEvt.Close;
  qrCntEvt.SQL.Clear;
  qrCntEvt.SQL.Add(SqlCadEvents);
  qrCntEvt.ParamByName('FkCadastros').AsInteger :=
    ADataSet.FieldByName('PK_CADASTROS').AsInteger;
  if not qrCntEvt.Active then qrCntEvt.Open;
  while (not qrCntEvt.Eof) do
  begin
    aEvt              := AOwner.OwnerEvents.Add;
    aEvt.PkOwnerEvent := qrCntEvt.FieldByName('PK_CADASTROS_EVENTOS').AsDateTime;
    aEvt.DscEvt       := qrCntEvt.FieldByName('DSC_EVT').AsString;
    aEvt.FlagIncEvt   := Boolean(qrCntEvt.FieldByName('FLAG_INC_EVT').AsInteger);
    qrCntEvt.Next;
  end;
  if qrCntEvt.Active then qrCntEvt.Close;
// Read from table CADASTROS_INTERNET
  if qrCntInternet.Active then qrCntInternet.Close;
  qrCntInternet.SQL.Clear;
  qrCntInternet.SQL.Add(SqlCadInternet);
  qrCntInternet.ParamByName('FkCadastros').AsInteger :=
    ADataSet.FieldByName('PK_CADASTROS').AsInteger;
  if not qrCntInternet.Active then qrCntInternet.Open;
  while (not qrCntInternet.EOF) do
  begin
    aNet := AOwner.InternetAddresses.Add;
    aNet.EndCnt := qrCntInternet.FieldByName('END_CNT').AsString;
    aNet.DscEnd := qrCntInternet.FieldByName('DSC_END').AsString;
    aNet.FlagDef := Boolean(qrCntInternet.FieldByName('FLAG_DEF').AsInteger);
    if (aNet.FlagDef) then
      AOwner.eMailCad := qrCntInternet.FieldByName('END_CNT').AsString
    else
      AOwner.HttpCad  := qrCntInternet.FieldByName('END_CNT').AsString;
    qrCntInternet.Next;
  end;
  if qrCntInternet.Active then qrCntInternet.Close;
end;

procedure TdmSysCrm.SetContactFromOwner(AOwner: TOwner; AResource: TVpResource;
  AIndex: Integer = -1);
var
  aItem: TVpContact;
  i: LongInt;
  aMailDef,
  aMail: string;
  aItemOwner: TOwner;
begin
  if (AIndex > -1) then
    aItem            := AResource.Contacts.GetContact(AIndex)
  else
    aItem            := AResource.Contacts.AddContact(AOwner.PkCadastros);
  aItem.Loading      := True;
  aItem.FirstName    := AOwner.RazSoc;
  aItem.Position     := AOwner.AreaAtu;
  aItem.Title        := AOwner.Title;
  aItem.Address      := AOwner.Address.EndAdd + ', '    +
                        IntToStr(AOwner.Address.NumAdd) + ' - ' +
                        AOwner.Address.CmpEnd;
  aItem.City         := AOwner.Address.FkCity.DscMun;
  aItem.State        := AOwner.Address.FkCity.FkState.DscUF;
  aItem.Zip          := FormatFloat('##.###-###', AOwner.Address.CepAdd);
  aItem.Country      := AOwner.Address.FkCity.FkState.FkCountry.DscPais;
  aItem.Note         := AOwner.ObsCad.Text;
  if AOwner.Categories.Count > 0 then
    aItem.Category   := Integer(AOwner.Categories.Items[0].FlagCat);
  if AOwner.OwnerEvents.Count > 0 then
  begin
    aItem.BirthDate  := AOwner.OwnerEvents.Items[0].PkOwnerEvent;
    if AOwner.OwnerEvents.Count > 1 then
      aItem.Anniversary := AOwner.OwnerEvents.Items[1].PkOwnerEvent;
  end;
  aMailDef := '';
  aMail    := '';
  for i := 0 to AOwner.InternetAddresses.Count - 1 do
    if (AOwner.InternetAddresses.Items[i].FlagTCntInt = iaMail) then
      if (AOwner.InternetAddresses.Items[i].FlagDef) then
        aMailDef   := AOwner.InternetAddresses.Items[i].EndCnt
      else
        aMail      := AOwner.InternetAddresses.Items[i].EndCnt;
  if (aMailDef <> '') then
    aItem.EMail    := aMailDef
  else
    aItem.EMail    := aMail;
  for i := 0 to AOwner.Phones.Count - 1 do
  begin
    if (i = 0) then
    begin
      aItem.PhoneType1 := 0;
      aItem.Phone1     := MaskDoFormatText(S_PHONE_MASK, AOwner.Phones.Items[i].FonCad, ' ');
    end;
    if (i = 1) then
    begin
      aItem.PhoneType2 := 0;
      aItem.Phone2     := MaskDoFormatText(S_PHONE_MASK, AOwner.Phones.Items[i].FonCad, ' ');
    end;
    if (i = 2) then
    begin
      aItem.PhoneType3 := 0;
      aItem.Phone3     := MaskDoFormatText(S_PHONE_MASK, AOwner.Phones.Items[i].FonCad, ' ');
    end;
    if (i = 3) then
    begin
      aItem.PhoneType4 := 0;
      aItem.Phone4     := MaskDoFormatText(S_PHONE_MASK, AOwner.Phones.Items[i].FonCad, ' ');
    end;
    if (i = 4) then
    begin
      aItem.PhoneType5 := 0;
      aItem.Phone5     := MaskDoFormatText(S_PHONE_MASK, AOwner.Phones.Items[i].FonCad, ' ');
    end;
  end;
  aItem.Changed    := False;
  aItem.Deleted    := False;
  aItemOwner       := TOwner.Create;
  aItemOwner.Assign(AOwner);
  i                := LongInt(aItemOwner);
  aItem.UserField0 := IntToStr(i);
  aItem.Loading    := False;
end;

procedure TdmSysCrm.LoadTasks(const AllTasks: Boolean; AResource: TVpResource;
  const AStartDate, AEndDate: TDate);
var
  aItem: TVpTask;
begin
  AResource.Tasks.ClearTasks;
  if qrTask.Active then qrTask.Close;
  qrTask.SQL.Clear;
  qrTask.SQL.Add(SqlTasks);
  Dados.StartTransaction(qrTask);
  try
    qrTask.ParamByName('FkResources').AsInteger := AResource.ResourceID;
    qrTask.ParamByName('DtaCrtkI').AsDate       := AStartDate;
    qrTask.ParamByName('DtaCrtkF').AsDate       := AEndDate;
    if (AllTasks) then
      qrTask.ParamByName('FlagCmpl').AsInteger    := -1
    else
      qrTask.ParamByName('FlagCmpl').AsInteger    := 0;
    if not qrTask.Active then qrTask.Open;
    while (not qrTask.Eof) do
    begin
      aItem := AResource.Tasks.AddTask(qrTask.FieldByName('PK_TASKS').AsInteger);
      aItem.Loading     := True;
      aItem.DueDate     := qrTask.FieldByName('DTHR_TASK').AsDateTime;
      aItem.Description := qrTask.FieldByName('DSC_TASK').AsString;
      aItem.Details     := qrTask.FieldByName('DET_TASK').AsString;
      aItem.Complete    := Boolean(qrTask.FieldByName('FLAG_CMPL').AsInteger);
      aItem.RecordID    := qrTask.FieldByName('PK_TASKS').AsInteger;
      aItem.CreatedOn   := qrTask.FieldByName('DTA_CRTK').AsDateTime;
      aItem.CompletedOn := qrTask.FieldByName('DTA_CMPL_TASK').AsDateTime;
      aItem.Priority    := qrTask.FieldByName('FLAG_PRTY').AsInteger;
      aItem.Category    := qrTask.FieldByName('CAT_TASK').AsInteger;
      aItem.Changed     := False;
      aItem.Deleted     := False;
      qrTask.Next;
    end;
  finally
    if qrTask.Active then qrTask.Close;
    Dados.CommitTransaction(qrTask);
  end;
end;

function  TdmSysCrm.SaveAllContactData(AMode: TDbMode; AOwner: TOwner): Boolean;
var
  i: Integer;
  aStrAux: TStrings;
  procedure GetPkCadastros;
  begin
    if qrContact.Active then qrContact.Close;
    Dados.StartTransaction(qrContact);
    try
      qrContact.SQL.Clear;
      qrContact.SQL.Add(Format(SqlLoadKeys, ['CADASTROS', 'PK_CADASTROS']));
      if not qrContact.Active then qrContact.Open;
      if qrContact.IsEmpty then
        raise Exception.Create('GetPkCadastros Error: Return of PkGenerator is null');
      AOwner.PkCadastros := qrContact.FieldByName('PK_CADASTROS').AsInteger;
      if qrContact.Active then qrContact.Close;
      Dados.CommitTransaction(qrContact);
    except on E:Exception do
      begin
        if qrContact.Active then qrContact.Close;
        Dados.RollbackTransaction(qrContact);
        raise Exception.Create('GetPkCadastros Error: Can''t retrieve ' + NL +
          'PK_CADASTROS' + NL + E.Message);
      end;
    end;
    qrContact.SQL.Clear;
    qrContact.SQL.AddStrings(GetInsertSQL(AOwner.GetFields, 'CADASTROS'));
  end;
begin
  Result := True;
  if qrContact.Active then qrContact.Close;
  qrContact.SQL.Clear;
  aStrAux := TStringList.Create;
  try
    aStrAux.Add('PK_CADASTROS');
    case AMode of
      dbmInsert: GetPkCadastros;
      dbmEdit  : qrContact.SQL.AddStrings(GetUpdateSQL(AOwner.GetFields, aStrAux, 'CADASTROS'));
      dbmDelete: qrContact.SQL.Add(SqlDelContacts);
    end;
  finally
    aStrAux.Free;
  end;
  Dados.StartTransaction(qrContact);
  try
    if (qrContact.Params.FindParam('PkCadastros') <> nil) then
      qrContact.ParamByName('PkCadastros').AsInteger := AOwner.PkCadastros;
    if (qrContact.Params.FindParam('OldPkCadastros') <> nil) then
      qrContact.ParamByName('OldPkCadastros').AsInteger := AOwner.PkCadastros;
    if (qrContact.Params.FindParam('FlagTCad') <> nil) then
      qrContact.ParamByName('FlagTCad').AsInteger    := Integer(AOwner.FlagTCad);
    if (qrContact.Params.FindParam('DocPri') <> nil) then
      qrContact.ParamByName('DocPri').AsString    := AOwner.DocPri;
    if (qrContact.Params.FindParam('DocSeq') <> nil) then
      qrContact.ParamByName('DocSeq').AsString    := AOwner.DocSec;
    if (qrContact.Params.FindParam('RazSoc') <> nil) then
      qrContact.ParamByName('RazSoc').AsString    := AOwner.RazSoc;
    if (qrContact.Params.FindParam('FkTipoAlias') <> nil) then
      qrContact.ParamByName('FkTipoAlias').AsInteger := AOwner.FkAlias;
    if (qrContact.Params.FindParam('FkPaises') <> nil) then
      qrContact.ParamByName('FkPaises').AsInteger := AOwner.Address.FkCity.FkState.FkCountry.PKCountry;
    if (qrContact.Params.FindParam('FkEstados') <> nil) then
      qrContact.ParamByName('FkEstados').AsString := AOwner.Address.FkCity.FkState.PkState;
    if (qrContact.Params.FindParam('FkMunicipios') <> nil) then
      qrContact.ParamByName('FkMunicipios').AsInteger := AOwner.Address.FkCity.PkCity;
    if (qrContact.Params.FindParam('EndCad') <> nil) then
      qrContact.ParamByName('EndCad').AsString    := AOwner.Address.EndAdd;
    if (qrContact.Params.FindParam('NumEnd') <> nil) then
      qrContact.ParamByName('NumEnd').AsInteger   := AOwner.Address.NumAdd;
    if (qrContact.Params.FindParam('CmpEnd') <> nil) then
      qrContact.ParamByName('CmpEnd').AsString    := AOwner.Address.CmpEnd;
    if (qrContact.Params.FindParam('CepCad') <> nil) then
      qrContact.ParamByName('CepCad').AsInteger   := AOwner.Address.CepAdd;
    if (qrContact.Params.FindParam('CxpCad') <> nil) then
      qrContact.ParamByName('CxpCad').AsString    := AOwner.Address.CxpAdd;
    if (qrContact.Params.FindParam('FlagEtq') <> nil) then
      qrContact.ParamByName('FlagEtq').AsInteger  := Integer(AOwner.FlagEtq);
    if (qrContact.Params.FindParam('FlagZumbi') <> nil) then
      if AOwner.Categories.Count = 0 then
        qrContact.ParamByName('FlagZumbi').AsInteger := 1
      else
        qrContact.ParamByName('FlagZumbi').AsInteger := 0;
    if (qrContact.Params.FindParam('AreaAtu') <> nil) then
      qrContact.ParamByName('AreaAtu').AsString    := AOwner.AreaAtu;
    if (qrContact.Params.FindParam('TrtCnt') <> nil) then
      qrContact.ParamByName('TrtCnt').AsString     := AOwner.Title;
    if (qrContact.Params.FindParam('FkContatos') <> nil) then
      if AOwner.FkContacts <= 0 then
        qrContact.Params.Delete(qrContact.ParamByName('FkContatos').Index)
      else
        qrContact.ParamByName('FkContatos').AsInteger  := AOwner.FkContacts;
    qrContact.ExecSQL;
//  Save all Date of events to table CADASTROS_EVENTOS
    //  delete all events from database
    if qrCntEvt.Active then qrCntEvt.Close;
    qrCntEvt.SQL.Clear;
    qrCntEvt.SQL.Add(SqlDelEvents);
    qrCntEvt.ParamByName('FkCadastros').AsInteger := AOwner.PkCadastros;
    qrCntEvt.ExecSQL;
    //  insert all events of the object into database
    if qrCntEvt.Active then qrCntEvt.Close;
    if (AMode <> dbmDelete) then
    begin
      qrCntEvt.SQL.Clear;
      qrCntEvt.SQL.Add(SqlInsEvents);
      for i := 0 to AOwner.OwnerEvents.Count - 1 do
      begin
        qrCntEvt.ParamByName('FkCadastros').AsInteger := AOwner.PkCadastros;
        qrCntEvt.ParamByName('PkCadastrosEventos').AsDate := AOwner.OwnerEvents.Items[i].PkOwnerEvent;
        qrCntEvt.ParamByName('DscEvt').AsString      := AOwner.OwnerEvents.Items[i].DscEvt;
        qrCntEvt.ParamByName('FlagIncEvt').AsInteger := Integer(AOwner.OwnerEvents.Items[i].FlagIncEvt);
        qrCntEvt.ExecSQL;
      end;
    end;
//  Save all data into table CADASTROS_INTERNET
    //  delete all internet address from database
    if qrCntInternet.Active then qrCntInternet.Close;
    qrCntInternet.SQL.Clear;
    qrCntInternet.SQL.Add(SqlDelInternet);
    qrCntInternet.ParamByName('FkCadastros').AsInteger := AOwner.PkCadastros;
    qrCntInternet.ExecSQL;
    //  insert all internet address of the object into database
    if (AMode <> dbmDelete) then
    begin
      qrCntInternet.SQL.Clear;
      qrCntInternet.SQL.Add(SqlInsInternet);
      for i := 0 to AOwner.InternetAddresses.Count - 1 do
      begin
        qrCntInternet.ParamByName('FkCadastros').AsInteger := AOwner.PkCadastros;
        qrCntInternet.ParamByName('PkCadastrosInternet').AsInteger := i + 1;
        with AOwner.InternetAddresses.Items[i] do
        begin
          qrCntInternet.ParamByName('EndCnt').AsString := EndCnt;
          qrCntInternet.ParamByName('DscEnd').AsString := DscEnd;
          case FlagTCntInt of
            iaWeb : qrCntInternet.ParamByName('FlagTCntInt').AsInteger := 0;
            iaMail: qrCntInternet.ParamByName('FlagTCntInt').AsInteger := 1;
            iaFtp : qrCntInternet.ParamByName('FlagTCntInt').AsInteger := 2;
            iaMsn : qrCntInternet.ParamByName('FlagTCntInt').AsInteger := 3;
            iaNone: qrCntInternet.ParamByName('FlagTCntInt').AsInteger := 4;
          end;
          if FlagDef then
            qrCntInternet.ParamByName('FlagDef').AsInteger := 1
          else
            qrCntInternet.ParamByName('FlagDef').AsInteger := 0;
        end;
        qrCntInternet.ExecSQL;
      end;
    end;
//  Save all data into table CADASTROS_CONTATOS
    //  delete all Phones from database
    if qrCntCnt.Active then qrCntCnt.Close;
    qrCntCnt.SQL.Clear;
    qrCntCnt.SQL.Add(SqlDelCadCnt);
    qrCntCnt.ParamByName('FkCadastros').AsInteger := AOwner.PkCadastros;
    qrCntCnt.ExecSQL;
    //  insert all phones of the object into database
    if (AMode <> dbmDelete) then
    begin
      qrCntCnt.SQL.Clear;
      qrCntCnt.SQL.Add(SqlInsCadCnt);
      for i := 0 to AOwner.Phones.Count - 1 do
      begin
        qrCntCnt.ParamByName('FkCadastros').AsInteger := AOwner.PkCadastros;
        qrCntCnt.ParamByName('PkCadastrosContatos').AsInteger := i + 1;
        qrCntCnt.ParamByName('DscCnt').AsString    := AOwner.Phones.Items[i].DscPhone;
        qrCntCnt.ParamByName('CntCnt').AsString    := AOwner.Phones.Items[i].FonCad;
        qrCntCnt.ExecSQL;
      end;
    end;
    Dados.CommitTransaction(qrContact);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrContact);
      raise Exception.Create('SaveAllContactData: Erro na Gravação dos dados.' +
         NL + E.Message);
    end
  end;
end;

procedure TdmSysCrm.DeleteCategoryLink(APkCad, APkCat: Integer; All: Boolean = False);
begin
  if (APkCad <= 0) or ((APkCat <= 0) and (All = False)) then exit;
  if qrContact.Active then qrContact.Close;
  qrContact.SQL.Clear;
  if All then
    qrContact.SQL.Add(SqlDelCategories)
  else
    qrContact.SQL.Add(SqlDelCategory);
  Dados.StartTransaction(qrContact);
  try
    if (qrContact.Params.FindParam('FkCadastros') <> nil) then
      qrContact.ParamByName('FkCadastros').AsInteger := APkCad;
    if (qrContact.Params.FindParam('FkCategorias') <> nil) then
      qrContact.ParamByName('FkCategorias').AsInteger    := APkCat;
    qrContact.ExecSQL;
    Dados.CommitTransaction(qrContact);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrContact);
      raise Exception.Create('DeleteCategoryLink: Erro na Gravação dos dados.' +
         NL + E.Message);
    end
  end;
end;

procedure TdmSysCrm.UpdateCategoryLink(APkCad, APkCat: Integer);
begin
  if (APkCad <= 0) or (APkCat <= 0) then exit;
  if qrContact.Active then qrContact.Close;
  qrContact.SQL.Clear;
  qrContact.SQL.Add(SqlUpdCategory);
  Dados.StartTransaction(qrContact);
  try
    if (qrContact.Params.FindParam('FkCadastros') <> nil) then
      qrContact.ParamByName('FkCadastros').AsInteger := APkCad;
    if (qrContact.Params.FindParam('FkCategorias') <> nil) then
      qrContact.ParamByName('FkCategorias').AsInteger    := APkCat;
    if (qrContact.Params.FindParam('FlagAtv') <> nil) then
      qrContact.ParamByName('FlagAtv').AsInteger    := 0;
    qrContact.ExecSQL;
    Dados.CommitTransaction(qrContact);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrContact);
      raise Exception.Create('UpdateCategoryLink: Erro na Gravação dos dados.' +
         NL + E.Message);
    end
  end;
end;

procedure TdmSysCrm.InsertCategoryLink(APkCad, APkCat: Integer);
begin
  if (APkCad <= 0) or (APkCat <= 0) then exit;
  if qrContact.Active then qrContact.Close;
  qrContact.SQL.Clear;
  qrContact.SQL.Add(SqlInsCategory);
  Dados.StartTransaction(qrContact);
  try
    if (qrContact.Params.FindParam('FkCadastros') <> nil) then
      qrContact.ParamByName('FkCadastros').AsInteger  := APkCad;
    if (qrContact.Params.FindParam('FkCategorias') <> nil) then
      qrContact.ParamByName('FkCategorias').AsInteger := APkCat;
    if (qrContact.Params.FindParam('FkEmpresas') <> nil) then
      qrContact.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
    if (qrContact.Params.FindParam('FlagAtv') <> nil) then
      qrContact.ParamByName('FlagAtv').AsInteger      := 1;
    qrContact.ExecSQL;
    Dados.CommitTransaction(qrContact);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrContact);
      raise Exception.Create('InsertCategoryLink: Erro na Gravação dos dados.' +
         NL + E.Message);
    end
  end;
end;

procedure TdmSysCrm.DeleteResourceLink(APkCad, APkRes: Integer; All: Boolean = False);
begin
  if (APkCad <= 0) or ((All = False) and (APkRes <= 0)) then exit;
  if qrContact.Active then qrContact.Close;
  qrContact.SQL.Clear;
  if All then
    qrContact.SQL.Add(SqlDelResLinks)
  else
    qrContact.SQL.Add(SqlDelResLink);
  Dados.StartTransaction(qrContact);
  try
    if (qrContact.Params.FindParam('FkCadastros') <> nil) then
      qrContact.ParamByName('FkCadastros').AsInteger := APkCad;
    if (qrContact.Params.FindParam('FkResources') <> nil) then
      qrContact.ParamByName('FkResources').AsInteger    := APkRes;
    qrContact.ExecSQL;
    Dados.CommitTransaction(qrContact);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrContact);
      raise Exception.Create('DeleteResourceLink: Erro na Gravação dos dados.' +
         NL + E.Message);
    end
  end;
end;

procedure TdmSysCrm.InsertResourceLink(APkCad, APkRes: Integer);
begin
  if (APkCad <= 0) or (APkRes <= 0) then exit;
  if qrContact.Active then qrContact.Close;
  qrContact.SQL.Clear;
  qrContact.SQL.Add(SqlInsResLink);
  Dados.StartTransaction(qrContact);
  try
    if (qrContact.Params.FindParam('FkCadastros') <> nil) then
      qrContact.ParamByName('FkCadastros').AsInteger  := APkCad;
    if (qrContact.Params.FindParam('FkResources') <> nil) then
      qrContact.ParamByName('FkResources').AsInteger := APkRes;
    qrContact.ExecSQL;
    Dados.CommitTransaction(qrContact);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrContact);
      raise Exception.Create('InsertResourceLink: Erro na Gravação dos dados.' +
         NL + E.Message);
    end
  end;
end;

procedure TdmSysCrm.SaveEvent(AEvent: TVpEvent; AResource: TVpResource;
  AContact: TOwner; AMode: TDBMode);
var
  aStr: TStrings;
  aM  : TMemoryStream;
begin
  if qrEvent.Active then qrEvent.Close;
  qrEvent.SQL.Clear;
  case AMode of
    dbmDelete: qrEvent.SQL.Add(SqlDeleteEvents);
    dbmInsert: qrEvent.SQL.Add(SqlInsertEvents); // GetPkEvent
    dbmEdit  : qrEvent.SQL.Add(SqlUpdateEvents);
  end;
  Dados.StartTransaction(qrEvent);
  try
    if qrEvent.Params.FindParam('PkEvents') <> nil then
      qrEvent.ParamByName('PkEvents').AsInteger         := AEvent.RecordID;
    if qrEvent.Params.FindParam('FkResources') <> nil then
      qrEvent.ParamByName('FkResources').AsInteger      := AResource.ResourceID;
    if qrEvent.Params.FindParam('DthrIni') <> nil then
      qrEvent.ParamByName('DthrIni').AsDateTime         := AEvent.StartTime;
    if qrEvent.Params.FindParam('DthrFin') <> nil then
      qrEvent.ParamByName('DthrFin').AsDateTime         := AEvent.EndTime;
    if qrEvent.Params.FindParam('DscEvent') <> nil then
      qrEvent.ParamByName('DscEvent').AsString          := AEvent.Description;
    if qrEvent.Params.FindParam('ObsEvt') <> nil then
    begin
      aStr := TStringList.Create;
      aM   := TMemoryStream.Create;
      try
        aStr.Add(AEvent.Note);
        aM.Position := 0;
        aStr.SaveToStream(aM);
        if aM.Size > 0 then
        begin
          aM.Position := 0;
          qrEvent.ParamByName('ObsEvt').LoadFromStream(aM, ftMemo);
        end;
      finally
        aStr.Free;
        aM.Free;
      end;
    end;
    if qrEvent.Params.FindParam('CtaEvt') <> nil then
      qrEvent.ParamByName('CtaEvt').AsInteger           := AEvent.Category;
    if qrEvent.Params.FindParam('FlagAllDay') <> nil then
      qrEvent.ParamByName('FlagAllDay').AsInteger       := Ord(AEvent.AllDayEvent);
    if qrEvent.Params.FindParam('DingPath') <> nil then
      qrEvent.ParamByName('DingPath').AsString          := AEvent.AlarmWavPath;
    if qrEvent.Params.FindParam('FlagAlarm') <> nil then
      qrEvent.Params.FindParam('FlagAlarm').AsInteger   := Ord(AEvent.AlarmSet);
    if qrEvent.Params.FindParam('IntrvAlarm') <> nil then
      qrEvent.ParamByName('IntrvAlarm').AsInteger       := AEvent.CustInterval;
    if qrEvent.Params.FindParam('FlagTAlarm') <> nil then
      qrEvent.ParamByName('FlagTAlarm').AsInteger       := Ord(AEvent.AlarmAdvType);
    if qrEvent.Params.FindParam('DthrRptEvt') <> nil then
      qrEvent.ParamByName('DthrRptEvt').AsDateTime      := AEvent.StartTime;
    if qrEvent.Params.FindParam('FlagTRepeat') <> nil then
      qrEvent.ParamByName('FlagTRepeat').AsInteger      := Ord(AEvent.RepeatCode);
    if qrEvent.Params.FindParam('DthrRpdFim') <> nil then
      qrEvent.ParamByName('DthrRpdFim').AsDateTime      := AEvent.RepeatRangeEnd;
    if qrEvent.Params.FindParam('IntrvRpt') <> nil then
      qrEvent.ParamByName('IntrvRpt').AsInteger         := AEvent.AlarmAdv;
    qrEvent.ExecSQL;
    Dados.CommitTransaction(qrEvent);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrEvent);
      raise Exception.Create('SaveEvent: Erro na Gravação dos dados.' +
         NL + E.Message);
    end;
  end;
end;

procedure TdmSysCrm.SaveTask(ATask: TVpTask; AResource: TVpResource;
  AMode: TDBMode);
var
  aStr: TStrings;
  aM  : TMemoryStream;
begin
  if qrTask.Active then qrTask.Close;
  qrTask.SQL.Clear;
  case AMode of
    dbmDelete: qrTask.SQL.Add(SqlDeleteTask);
    dbmInsert: qrTask.SQL.Add(SqlInsertTask); // GetPkTask
    dbmEdit  : qrTask.SQL.Add(SqlUpdateTask);
  end;
  Dados.StartTransaction(qrTask);
  try
    if qrTask.Params.FindParam('PkTasks') <> nil then
      qrTask.ParamByName('PkTasks').AsInteger         := ATask.RecordID;
    if qrTask.Params.FindParam('FkResources') <> nil then
      qrTask.ParamByName('FkResources').AsInteger     := AResource.ResourceID;
    if qrTask.Params.FindParam('DscTask') <> nil then
      qrTask.ParamByName('DscTask').AsString          := ATask.Description;
    if (qrTask.Params.FindParam('DetTask') <> nil) then
    begin
      aStr := TStringList.Create;
      aM   := TMemoryStream.Create;
      try
        aStr.Add(ATask.Details);
        aM.Position := 0;
        aStr.SaveToStream(aM);
        if aM.Size > 0 then
        begin
          aM.Position := 0;
          qrTask.ParamByName('DetTask').LoadFromStream(aM, ftMemo);
        end;
      finally
        aStr.Free;
        aM.Free;
      end;
    end;
    if qrTask.Params.FindParam('FlagCmpl') <> nil then
      qrTask.ParamByName('FlagCmpl').AsInteger         := Ord(ATask.Complete);
    if qrTask.Params.FindParam('DtaCrtk') <> nil then
      qrTask.ParamByName('DtaCrtk').AsDateTime         := ATask.CreatedOn;
    if qrTask.Params.FindParam('FlagPrty') <> nil then
      qrTask.Params.FindParam('FlagPrty').AsInteger    := ATask.Priority;
    if qrTask.Params.FindParam('CatTask') <> nil then
      qrTask.ParamByName('CatTask').AsInteger          := ATask.Category;
    if qrTask.Params.FindParam('DtaCmplTask') <> nil then
      qrTask.ParamByName('DtaCmplTask').AsDateTime     := ATask.CompletedOn;
    if qrTask.Params.FindParam('DthrTask') <> nil then
      qrTask.ParamByName('DthrTask').AsDateTime        := ATask.DueDate;
    qrTask.ExecSQL;
    Dados.CommitTransaction(qrTask);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrTask);
      raise Exception.Create('SaveEvent: Erro na Gravação dos dados.' +
         NL + E.Message);
    end;
  end;
end;

function  TdmSysCrm.LoadAlias: TStrings;
begin
  Result := TStringList.Create;
  if qrAlias.Active then qrAlias.Close;
  qrAlias.SQL.Clear;
  qrAlias.SQL.Add(SqlSelectAlias);
  Dados.StartTransaction(qrAlias);
  if not qrAlias.Active then qrAlias.Open;
  try
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

function  TdmSysCrm.ModifyAlias(const APkAlias: Integer; const ANameAlias: string;
  const AMode: TDBMode): Integer;
begin
  Result := 0;
  if (AMode in UPDATE_MODE) then
  begin
    if qrAlias.Active then qrAlias.Close;
    qrAlias.SQL.Clear;
    qrAlias.SQL.Add(SqlManagerAlias);
    Dados.StartTransaction(qrAlias);
    try
      qrAlias.ParamByName('FlagDel').AsInteger     := 0;
      qrAlias.ParamByName('PkTipoAlias').AsInteger := APkAlias;
      case AMode of
        dbmInsert: qrAlias.ParamByName('PkTipoAlias').AsInteger := 0;
        dbmDelete: qrAlias.ParamByName('FlagDel').AsInteger     := 1;
      end;
      qrAlias.ParamByName('DscAlias').AsString := ANameAlias;
      if not qrAlias.Active then qrAlias.Open;
      if (qrAlias.FieldByName('R_STATUS').AsInteger < 0) then
        Result := qrAlias.FieldByName('R_STATUS').AsInteger
      else
        Result := qrAlias.FieldByName('R_PK_TIPO_ALIAS').AsInteger;
      if qrAlias.Active then qrAlias.Close;
      Dados.CommitTransaction(qrAlias);
    except on E:Exception do
      begin
        Dados.RollbackTransaction(qrAlias);
        raise Exception.Create('SaveEvent: Erro na Gravação dos dados.' + NL +
          E.Message);
      end;
    end;
  end;
end;

initialization
  RegisterClass(TdmSysCrm);
  Application.CreateForm(TdmSysCrm, dmSysCrm);

finalization
  if Assigned(dmSysCrm) then
    dmSysCrm.Free;
  dmSysCrm := nil;

end.

