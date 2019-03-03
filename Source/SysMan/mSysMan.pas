unit mSysMan;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.6.0.0                                                      *}
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
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, TSysCadAux,
  DB, Encryp, ProcType, FMTBcd, SqlExpr, TSysMan, TSysManAux, GridRow,
  ProcUtils, TSysGen;

type
  TFieldsEvent = function : TStrings of object;

  TdmSysMan = class(TDataModule)
    qrHistorico: TSQLQuery;
    Cadastros : TSQLQuery;
    Municipios: TSQLQuery;
    Empresa: TSQLQuery;
    Modulo: TSQLQuery;
    Acesso: TSQLQuery;
    Operador: TSQLQuery;
    qrParametro: TSQLQuery;
    qrParamGlobal: TSQLQuery;
    Rotina: TSQLQuery;
    Programa: TSQLQuery;
    Relatorio: TSQLQuery;
    LayOut: TSQLQuery;
    Dicionario: TSQLQuery;
    Estados: TSQLQuery;
    Localidades: TSQLQuery;
    ImprNota: TSQLQuery;
    ImprDos: TSQLQuery;
    ImprFiscal: TSQLQuery;
    Categorias: TSQLQuery;
    Paises: TSQLQuery;
    Linguagem: TSQLQuery;
    qrTypeDoc: TSQLQuery;
    qrMessage: TSQLQuery;
    ValorCampo: TSQLQuery;
    qrMask: TSQLQuery;
    qrSqlAux: TSQLQuery;
    TipoEnd: TSQLQuery;
    qrParamPrg: TSQLQuery;
    Moedas: TSQLQuery;
    Versao: TSQLQuery;
    Script: TSQLQuery;
    LinkScriptMod: TSQLQuery;
    ClientVersion: TSQLQuery;
    ClientMod: TSQLQuery;
    Bairros: TSQLQuery;
    InsProgram: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure SaveProgramParams(AItem: TProgram);
    { Private declarations }
  public
    { Public declarations }
    function  GetMessages(const APk: Integer; const ALng: string): TDataRow;
    function  GetModule(const ALng: string; const AMod: Integer): TModule;
    function  GetProgram(const ALng: string; const AMod, ARot, APrg: Integer): TProgram;
    function  GetOperator(const AOperator: string): TOperator;
    function  GetCompanyParams(const APk: Integer): TDataRow;
    function  GetTypeDocument(const APk: Integer): TTypeDocument;
    function  GetGlobalParams(const APk: Integer): TDataRow;
    function  GetMask(const APk: Integer; const ALang: string): TDataRow;
    function  LoadCityFromPostalCode(const ACep: Integer): TCity;
    function  LoadDistrictFromPostalCode(const ACep: Integer): TDistrict;
    function  LoadLocalityFromPostalCode(const ACep: Integer): TLocality;
    function  LoadLanguage: TStrings;
    function  LoadMasks: TStrings;
    function  LoadOperators: TStrings;
    function  LoadTypeDocs: TStrings;
    function  LoadOwners(const ASQL: string): TStrings;
    function  LoadMoedas: TStrings;
    function  LoadCountries: TStrings;
    function  LoadStates(const ACountry: TCountry): TStrings;
    function  LoadCities(const AState: TState): TStrings;
    function  LoadModules(const ALang: string): TStrings;
    function  LoadPrograms(const ALng: string; const AMod, ARot: Integer): TStrings;
    function  LoadReports(const ALng: string; const AMod: Integer): TStrings;
    function  LoadRotines(const ALang: string): TStrings;
    function  LoadCenaries(ABaseOnly: Boolean = True): TStrings;
    procedure SaveLanguage(const AItem: TDataRow; const AState: TDBMode;
                const AOldPk: string = '');
    procedure SaveModule(const AItem: TModule; const AState: TDBMode;
                const AOldPk: Integer = 0; const AOldFkLng: string = '');
    procedure SaveRotine(const AItem: TDataRow; const AState: TDBMode;
                const AFkLng: string);
    procedure SaveProgram(const AItem: TProgram; const AState: TDBMode);
    procedure SaveOperator(const AItem: TOperator; const DataBasePwd,
                AOldPk: string; const AState: TDBMode);
    procedure SaveCampanyParams(const AData: TDataRow; DataFields: TFieldsEvent;
                const AState: TDBMode);
    function  SaveTypeDocument(AItem: TTypeDocument; AState: TDBMode): Integer;
    function  SaveMask(const AData: TDataRow; const AState: TDBMode): Integer;
    function  SaveMessage(const AData: TDataRow; const AState: TDBMode): Integer;
    function  SaveGlobalParams(const AData: TDataRow; const AState: TDBMode): Integer;
  end;

var
  dmSysMan: TdmSysMan;

implementation

uses AltPass, Funcoes, Autor, FuncoesDB, ModelTyp, ManArqSql, Dado,
  CmmConst, SqlComm, ArqCnst, Math, TypInfo, TSysCad;

{$R *.DFM}

procedure TdmSysMan.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

procedure TdmSysMan.DataModuleDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (TDataSet(Components[i]).Active)       then
      TDataSet(Components[i]).Close;
end;

{ functions of TSysMan }

function  TdmSysMan.GetModule(const ALng: string; const AMod: Integer): TModule;
begin
  Result := nil;
  if (ALng = '') or (AMod = 0) then exit;
  if (Modulo.Active) then Modulo.Close;
  Modulo.SQL.Clear;
  Modulo.SQL.Add(SqlModulo);
  Modulo.Params.FindParam('FkLinguagens').AsString := ALng;
  Modulo.Params.FindParam('PkModulos').AsInteger   := AMod;
  Dados.StartTransaction(Modulo);
  if (not Modulo.Active) then Modulo.Open;
  try
    if (not Modulo.IsEmpty) then
    begin
      Result            := TModule.Create;
      Result.PkModule   := Modulo.FindField('PK_MODULOS').AsInteger;
      Result.DscMod     := Modulo.FindField('DSC_MOD').AsString;
      Result.PkLanguage := Modulo.FindField('FK_LINGUAGENS').AsString;
      Result.Ver1       := Modulo.FindField('VER_1').AsInteger;
      Result.Ver2       := Modulo.FindField('VER_2').AsInteger;
      Result.Ver3       := Modulo.FindField('VER_3').AsInteger;
      Result.Ver4       := Modulo.FindField('VER_4').AsInteger;
      Result.Versao     := Modulo.FindField('VERSAO').AsString;
    end;
  finally
    if (Modulo.Active) then Modulo.Close;
    Dados.CommitTransaction(Modulo);
  end;
end;

function TdmSysMan.GetProgram(const ALng: string; const AMod, ARot,
  APrg: Integer): TProgram;
begin
  Result := nil;
  if (ALng = '') or (AMod = 0) or (ARot = 0) or (APrg = 0) then exit;
  if Programa.Active then Programa.Close;
  Programa.SQL.Clear;
  Programa.SQL.Add(SqlPrograma);
  Dados.StartTransaction(Programa);
  try
    Programa.ParamByName('FkLinguagens').AsString := ALng;
    Programa.ParamByName('FkModulos').AsInteger   := AMod;
    Programa.ParamByName('FkRotinas').AsInteger   := ARot;
    Programa.ParamByName('FkProgramas').AsInteger := APrg;
    if (not Programa.Active) then Programa.Open;
    if (not Programa.IsEmpty) then
    begin
      Result          := TProgram.Create;
      Result.FlagVis  := Boolean(Programa.FieldByName('FLAG_VIS').AsInteger);
      Result.FlagRel  := Boolean(Programa.FieldByName('FLAG_REL').AsInteger);
      Result.DscPrg   := Programa.FieldByName('DSC_PRG').AsString;
      Result.NomLib   := Programa.FieldByName('NOM_LIB').AsString;
      Result.NomForm  := Programa.FieldByName('NOM_FRM').AsString;
      Result.FkReport := Programa.FieldByName('FK_RELATORIOS').AsInteger;
    end;
  finally
    if Programa.Active then Programa.Close;
    Dados.CommitTransaction(Programa);
  end;
end;

function  TdmSysMan.GetOperator(const AOperator: string): TOperator;
begin
  Result := nil;
  if (Operador.Active) then Operador.Close;
  Operador.SQL.Clear;
  Operador.SQL.Add(SqlUserLogin);
  Dados.StartTransaction(Operador);
  Operador.ParamByName('FkOperadores').AsString := AOperator;
  Operador.Open;
  try
    if (not Operador.IsEmpty) then
    begin
      Result            := TOperator.Create;
      Result.PkOperator := Operador.FindField('PK_OPERADORES').AsString;
      Result.eMailOpe   := Operador.FindField('EMAIL_OPE').AsString;
      Result.DsctMax    := Operador.FindField('DSCT_MAX').AsFloat;
      Result.FkCompany.PkCompany   := Operador.FindField('FK_EMPRESAS').AsInteger;
      Result.FkLanguage.PkLanguage := Operador.FindField('FK_LINGUAGENS').AsString;
      Result.FkOwner    := Operador.FindField('FK_CADASTROS').AsInteger;
      Result.FlagBrw    := Boolean(Operador.FindField('FLAG_BRW').AsInteger);
      Result.FlagDel    := Boolean(Operador.FindField('FLAG_DEL').AsInteger);
      Result.FlagFnd    := Boolean(Operador.FindField('FLAG_FND').AsInteger);
      Result.FlagIns    := Boolean(Operador.FindField('FLAG_INS').AsInteger);
      Result.FlagLSen   := Boolean(Operador.FindField('FLAG_LSEN').AsInteger);
      Result.FlagUpd    := Boolean(Operador.FindField('FLAG_UPD').AsInteger);
      Result.SenNet     := Operador.FindField('SEN_NET').AsString;
    end;
  finally
    if (Operador.Active) then Operador.Close;
    Dados.CommitTransaction(Operador)
  end;
end;

function  TdmSysMan.LoadCityFromPostalCode(const ACep: Integer): TCity;
begin
  Result := TCity.Create;
  if Municipios.Active then Municipios.Close;
  Municipios.SQL.Clear;
  Municipios.SQL.Add(SqlCityPostalCode);
  Municipios.ParamByName('CepMun').AsInteger := ACep;
  if not Municipios.Active then Municipios.Open;
  if not Municipios.IsEmpty then
  begin
    Result.PkCity  := Municipios.FieldByName('PK_MUNICIPIOS').AsInteger;
    Result.DscMun  := Municipios.FieldByName('DSC_MUN').AsString;
    Result.FkState.PkState             := Municipios.FieldByName('FK_ESTADOS').AsString;
    Result.FkState.FkCountry.PKCountry := Municipios.FieldByName('FK_PAISES').AsInteger;
  end;
  if Municipios.Active then Municipios.Close;
end;

function  TdmSysMan.LoadDistrictFromPostalCode(const ACep: Integer): TDistrict;
begin
  Result := TDistrict.Create;
  if Bairros.Active then Bairros.Close;
  Bairros.SQL.Clear;
  Bairros.SQL.Add(SqlDistrictPostalCode);
  Bairros.ParamByName('CepBai').AsInteger := ACep;
  if not Bairros.Active then Bairros.Open;
  if not Bairros.IsEmpty then
  begin
    Result.PkDistrict := Bairros.FieldByName('PK_BAIRROS').AsInteger;
    Result.DscBai     := Bairros.FieldByName('DSC_MUN').AsString;
    Result.FkCity.FkState.FkCountry.PKCountry := Bairros.FieldByName('FK_PAISES').AsInteger;
    Result.FkCity.FkState.PkState             := Bairros.FieldByName('FK_ESTADOS').AsString;
    Result.FkCity.PkCity                      := Bairros.FieldByName('FK_MUNICIPIOS').AsInteger;
  end;
  if Bairros.Active then Bairros.Close;
end;

function  TdmSysMan.LoadLocalityFromPostalCode(const ACep: Integer): TLocality;
begin
  Result := TLocality.Create;
  if Localidades.Active then Localidades.Close;
  Localidades.SQL.Clear;
  Localidades.SQL.Add(SqlCityPostalCode);
  Localidades.ParamByName('CepMun').AsInteger := ACep;
  if not Localidades.Active then Localidades.Open;
  if not Localidades.IsEmpty then
  begin
    Result.PkLocality := Localidades.FieldByName('PK_LOCALIDADES').AsInteger;
    Result.DscLog     := Localidades.FieldByName('DSC_LOC').AsString;
    Result.CmplLog    := Localidades.FieldByName('CMPL_LOC').AsString;
    Result.CepLog     := Localidades.FieldByName('CEP_LOC').AsInteger;
    Result.FkDistrict.FkCity.FkState.FkCountry.PKCountry :=
                         Localidades.FieldByName('FK_PAISES').AsInteger;
    Result.FkDistrict.FkCity.FkState.PkState :=
                         Localidades.FieldByName('FK_ESTADOS').AsString;
    Result.FkDistrict.FkCity.PkCity := Localidades.FieldByName('FK_MUNICIPIOS').AsInteger;
    Result.FkDistrict.PkDistrict := Localidades.FieldByName('FK_BAIRROS').AsInteger;
    Result.FkDistrict.DscBai     := Localidades.FieldByName('DSC_BAI').AsString;
  end;
  if Localidades.Active then Localidades.Close;
end;

function  TdmSysMan.LoadOperators: TStrings;
var
  aItem: TOperator;
begin
  Result := TStringList.Create;
  if (Operador.Active) then Operador.Close;
  Operador.SQL.Clear;
  Operador.SQL.Add(SqlOperadores);
  Dados.StartTransaction(Operador);
  Operador.Open;
  try
    if (not Operador.IsEmpty) then
    begin
      Operador.First;
      while not Operador.Eof do
      begin
        aItem            := TOperator.Create;
        aItem.PkOperator := Operador.FindField('PK_OPERADORES').AsString;
        aItem.DsctMax    := Operador.FindField('DSCT_MAX').AsFloat;
        aItem.FkCompany.PkCompany   := Operador.FindField('FK_EMPRESAS').AsInteger;
        aItem.FkLanguage.PkLanguage := Operador.FindField('FK_LINGUAGENS').AsString;
        aItem.FkOwner    := Operador.FindField('FK_CADASTROS').AsInteger;
        aItem.FlagBrw    := Boolean(Operador.FindField('FLAG_BRW').AsInteger);
        aItem.FlagDel    := Boolean(Operador.FindField('FLAG_DEL').AsInteger);
        aItem.FlagFnd    := Boolean(Operador.FindField('FLAG_FND').AsInteger);
        aItem.FlagIns    := Boolean(Operador.FindField('FLAG_INS').AsInteger);
        aItem.FlagLSen   := Boolean(Operador.FindField('FLAG_LSEN').AsInteger);
        aItem.FlagUpd    := Boolean(Operador.FindField('FLAG_UPD').AsInteger);
        aItem.SenNet     := Operador.FindField('SEN_NET').AsString;
        aItem.cbIndex    := Result.AddObject(aItem.PkOperator, aItem);
        Operador.Next;
      end;
    end;
  finally
    if (Operador.Active) then Operador.Close;
    Dados.CommitTransaction(Operador)
  end;
end;

function  TdmSysMan.LoadLanguage: TStrings;
var
  aItem: TLanguage;
begin
  Result := TStringList.Create;
  if (Linguagem.Active) then Linguagem.Close;
  Linguagem.SQL.Clear;
  Linguagem.SQL.Add(SqlLinguagens);
  Dados.StartTransaction(Linguagem);
  Linguagem.Open;
  try
    if (not Linguagem.IsEmpty) then
    begin
      Linguagem.First;
      Result.AddObject('... Nenhum ...', nil);
      while not Linguagem.Eof do
      begin
        aItem            := TLanguage.Create;
        aItem.PkLanguage := Linguagem.FindField('PK_LINGUAGENS').AsString;
        aItem.DscLang    := Linguagem.FindField('DSC_LANG').AsString;
        aItem.cbIndex    := Result.AddObject(aItem.DscLang, aItem);
        Linguagem.Next;
      end;
    end;
  finally
    if (Linguagem.Active) then Linguagem.Close;
    Dados.CommitTransaction(Linguagem)
  end;
end;

function  TdmSysMan.LoadMasks: TStrings;
begin
  Result := TStringList.Create;
  if (qrMask.Active) then qrMask.Close;
  qrMask.SQL.Clear;
  qrMask.SQL.Add(SqlMascaras);
  Dados.StartTransaction(qrMask);
  qrMask.Open;
  try
    if (not qrMask.IsEmpty) then
    begin
      qrMask.First;
      Result.Add('... Nenhuma ...');
      while not qrMask.Eof do
      begin
        Result.AddObject(qrMask.FindField('MSK_MSK').AsString + ' ==> ' +
          qrMask.FindField('DSC_MSK').AsString,
          TObject(qrMask.FindField('DSC_MSK').AsString));
        qrMask.Next;
      end;
    end;
  finally
    if (qrMask.Active) then qrMask.Close;
    Dados.CommitTransaction(qrMask)
  end;
end;

function  TdmSysMan.LoadTypeDocs: TStrings;
var
  aItem: TTypeDocument;
  M: TStream;
begin
  Result := TStringList.Create;
  if (qrTypeDoc.Active) then qrTypeDoc.Close;
  qrTypeDoc.SQL.Clear;
  qrTypeDoc.SQL.Add(SqlTipoDocumentos);
  Dados.StartTransaction(qrTypeDoc);
  qrTypeDoc.Open;
  try
    if (not qrTypeDoc.IsEmpty) then
    begin
      qrTypeDoc.First;
      Result.Add('... Nenhuma ...');
      while not qrTypeDoc.Eof do            
      begin
        aItem := TTypeDocument.Create;
        aItem.PkTypeDocument := qrTypeDoc.FindField('PK_TIPO_DOCUMENTOS').AsInteger;
        aItem.DscTDoc        := qrTypeDoc.FindField('DSC_TDOC').AsString;
        aItem.FlagExt        := Boolean(qrTypeDoc.FindField('FLAG_EXT').AsInteger);
        aItem.FlagTDoc       := TDocumentType(qrTypeDoc.FindField('FLAG_TDOC').AsInteger);
        aItem.QtdItem        := qrTypeDoc.FindField('QTD_ITM').AsInteger;
        M                    := TMemoryStream.Create;
        try
          M.Position         := 0;
          TBlobField(qrTypeDoc.FindField('OBS_TDOC')).SaveToStream(M);
          M.Position         := 0;
          aItem.ObsDoc.LoadFromStream(M);
        finally
          M.Free;
        end;
        aItem.cbIndex        := Result.AddObject(aItem.DscTDoc, aItem);
        qrTypeDoc.Next;
      end;
    end;
  finally
    if (qrTypeDoc.Active) then qrTypeDoc.Close;
    Dados.CommitTransaction(qrTypeDoc);
  end;
end;

function  TdmSysMan.LoadOwners(const ASQL: string): TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (Cadastros.Active) then Cadastros.Close;
  Cadastros.SQL.Clear;
  Cadastros.SQL.Add(ASQL);
  Dados.StartTransaction(Cadastros);
  Cadastros.Open;
  try
    Result.Add('<Nenhum>');
    while not Cadastros.Eof do
    begin
      aItem               := TOwner.Create;
      aItem.PkCadastros   := Cadastros.FindField('PK_CADASTROS').AsInteger;
      aItem.RazSoc        := Cadastros.FindField('RAZ_SOC').AsString;
      aItem.cbIndex       := Result.AddObject(aItem.RazSoc, aItem);
      Cadastros.Next;
    end;
  finally
    if (Cadastros.Active) then Cadastros.Close;
    Dados.CommitTransaction(Cadastros);
  end;
end;

function  TdmSysMan.LoadMoedas: TStrings;
begin
  Result := TStringList.Create;
  if (Moedas.Active) then Moedas.Close;
  Moedas.SQL.Clear;
  Moedas.SQL.Add(SqlMoedas);
  Dados.StartTransaction(Moedas);
  Moedas.Open;
  try
    if (not Moedas.IsEmpty) then
    begin
      Moedas.First;
      Result.Add('... Nenhuma ...');
      while not Moedas.Eof do
      begin
        Result.AddObject(Moedas.FindField('DSC_MD').AsString,
          TObject(Moedas.FindField('PK_TIPO_MOEDAS').AsInteger));
        Moedas.Next;
      end;
    end;
  finally
    if (Moedas.Active) then Moedas.Close;
    Dados.CommitTransaction(Moedas);
  end;
end;

function  TdmSysMan.LoadCountries: TStrings;
var
  aItem: TCountry;
begin
  Result := TStringList.Create;
  if (Paises.Active) then Paises.Close;
  Paises.SQL.Clear;
  Paises.SQL.Add(SqlPaises);
  Dados.StartTransaction(Paises);
  Paises.Open;
  try
    if (not Paises.IsEmpty) then
    begin
      Paises.First;
      Result.Add('... Nenhum ...');
      while not Paises.Eof do
      begin
        aItem := TCountry.Create;
        aItem.PKCountry := Paises.FindField('PK_PAISES').AsInteger;
        aItem.DscPais   := Paises.FindField('DSC_PAIS').AsString;
        aItem.cbIndex   := Result.AddObject(aItem.DscPais, aItem);
        Paises.Next;
      end;
    end;
  finally
    if (Paises.Active) then Paises.Close;
    Dados.CommitTransaction(Paises)
  end;
end;

function  TdmSysMan.LoadStates(const ACountry: TCountry): TStrings;
var
  aItem: TState;
begin
  Result := TStringList.Create;
  if (Estados.Active) then Estados.Close;
  Estados.SQL.Clear;
  Estados.SQL.Add(SqlEstados);
  if Estados.Params.FindParam('FkPaises') <> nil then
    Estados.Params.FindParam('FkPaises').AsInteger := ACountry.PkCountry;
  Dados.StartTransaction(Estados);
  Estados.Open;
  try
    if (not Estados.IsEmpty) then
    begin
      Estados.First;
      Result.Add('... Nenhum ...');
      while not Estados.Eof do
      begin
        aItem           := TState.Create;
        aItem.FkCountry := ACountry;
        aItem.PkState   := Estados.FindField('PK_ESTADOS').AsString;
        aItem.DscUF     := Estados.FindField('DSC_UF').AsString;
        aItem.cbIndex   := Result.AddObject(aItem.DscUF, aItem);
        Estados.Next;
      end;
    end;
  finally
    if (Estados.Active) then Estados.Close;
    Dados.CommitTransaction(Estados);
  end;
end;

function  TdmSysMan.LoadCities(const AState: TState): TStrings;
var
  aItem: TCity;
begin
  Result := TStringList.Create;
  if (Municipios.Active) then Municipios.Close;
  Municipios.SQL.Clear;
  Municipios.SQL.Add(SqlMunicipio);
  if Municipios.Params.FindParam('FkPaises') <> nil then
    Municipios.Params.FindParam('FkPaises').AsInteger := AState.FkCountry.PKCountry;
  if Municipios.Params.FindParam('FkEstados') <> nil then
    Municipios.Params.FindParam('FkEstados').AsString := AState.PkState;
  Dados.StartTransaction(Municipios);
  Municipios.Open;
  try
    if (not Municipios.IsEmpty) then
    begin
      Municipios.First;
      Result.Add('... Nenhum ...');
      while not Municipios.Eof do
      begin
        aItem           := TCity.Create;
        aItem.FkState.FkCountry := AState.FkCountry;
        aItem.FkState   := AState;
        aItem.PkCity    := Municipios.FindField('PK_MUNICIPIOS').AsInteger;
        aItem.DscMun    := Municipios.FindField('DSC_MUN').AsString;
        aItem.CepMun    := Municipios.FindField('CEP_MUN').AsInteger;
        aItem.cbIndex   := Result.AddObject(aItem.DscMun, aItem);
        Municipios.Next;
      end;
    end;
  finally
    if (Municipios.Active) then Municipios.Close;
    Dados.CommitTransaction(Municipios);
  end;
end;

function  TdmSysMan.LoadModules(const ALang: string): TStrings;
var
  aItem: TModule;
begin
  Result := TStringList.Create;
  if (Modulo.Active) then Modulo.Close;
  Modulo.SQL.Clear;
  Modulo.SQL.Add(SqlModulos);
  if Modulo.Params.FindParam('FkLinguagens') <> nil then
    Modulo.Params.FindParam('FkLinguagens').AsString := ALang;
  Dados.StartTransaction(Modulo);
  Modulo.Open;
  try
    if (not Modulo.IsEmpty) then
    begin
      Modulo.First;
      Result.Add('... Nenhum ...');
      while not Modulo.Eof do
      begin
        aItem := TModule.Create;
        aItem.PkModule := Modulo.FindField('PK_MODULOS').AsInteger;
        aItem.DscMod   := Modulo.FindField('DSC_MOD').AsString;
        aItem.FkLanguage.PkLanguage := Modulo.FindField('FK_LINGUAGENS').AsString;
        aItem.Ver1     := Modulo.FindField('VER_1').AsInteger;
        aItem.Ver2     := Modulo.FindField('VER_2').AsInteger;
        aItem.Ver3     := Modulo.FindField('VER_3').AsInteger;
        aItem.Ver4     := Modulo.FindField('VER_4').AsInteger;
        aItem.cbIndex  := Result.AddObject(aItem.DscMod, aItem);
        Modulo.Next;
      end;
    end;
  finally
    if (Modulo.Active) then Modulo.Close;
    Dados.CommitTransaction(Modulo);
  end;
end;

function  TdmSysMan.LoadPrograms(const ALng: string; const AMod, ARot: Integer): TStrings;
var
  aItem: TProgram;
begin
  Result := TStringList.Create;
  if (Programa.Active) then Programa.Close;
  Programa.SQL.Clear;
  Programa.SQL.Add(SqlPrograma);
  if Programa.Params.FindParam('FkLinguagens') <> nil then
    Programa.Params.FindParam('FkLinguagens').AsString := ALng;
  if Programa.Params.FindParam('FkModulos') <> nil then
    Programa.Params.FindParam('FkModulos').AsInteger   := AMod;
  if Programa.Params.FindParam('FkRotinas') <> nil then
    Programa.Params.FindParam('FkRotinas').AsInteger   := ARot;
  Dados.StartTransaction(Programa);
  Programa.Open;
  try
    if (not Programa.IsEmpty) then
    begin
      Programa.First;
      Result.Add('... Nenhum ...');
      while not Programa.Eof do
      begin
        aItem                       := TProgram.Create;
        aItem.FkLanguage.PkLanguage := ALng;
        aItem.FkModulo.PkModule     := AMod;
        aItem.FkRotina.PkRotina     := ARot;
        aItem.PkProgram             := Programa.FindField('PK_PROGRAMAS').AsInteger;
        aItem.DscPrg                := Programa.FindField('DSC_PRG').AsString;
        aItem.NomForm               := Programa.FindField('NOM_FRM').AsString;
        aItem.NomLib                := Programa.FindField('NOM_LIB').AsString;
        aItem.cbIndex               := Result.AddObject(aItem.DscPrg, aItem);
        Programa.Next;
      end;
    end;
  finally
    if (Programa.Active) then Programa.Close;
    Dados.CommitTransaction(Programa);
  end;
end;

function  TdmSysMan.LoadReports(const ALng: string; const AMod: Integer): TStrings;
begin
  Result := TStringList.Create;
  if (ALng = '') or (AMod = 0) then exit;
  if Relatorio.Active then Relatorio.Close;
  Relatorio.SQL.Clear;
  Relatorio.SQL.Add(SqlRelatorio);
  Dados.StartTransaction(Relatorio);
  try
    if (aLng = '') then
      Relatorio.Params.ParamByName('FkLinguagens').AsString := LANGUAGE
    else
      Relatorio.Params.ParamByName('FkLinguagens').AsString := ALng;
    Relatorio.Params.ParamByName('FkModulos').AsInteger     := AMod;
    if (not Relatorio.Active) then Relatorio.Open;
    if (not Relatorio.IsEmpty) then
      Result.Add('<Nenhum>');
    while (not Relatorio.Eof) do
    begin
      Result.AddObject(Relatorio.FieldByName('DSC_REL').AsString,
        TObject(Relatorio.FieldByName('PK_RELATORIOS').AsInteger));
      Relatorio.Next;
    end;
  finally
    if Relatorio.Active then Relatorio.Close;
    Dados.CommitTransaction(Relatorio);
  end;
end;

function  TdmSysMan.LoadRotines(const ALang: string): TStrings;
var
  aItem: TRotine;
begin
  Result := TStringList.Create;
  if (Rotina.Active) then Rotina.Close;
  Rotina.SQL.Clear;
  Rotina.SQL.Add(SqlRotinas);
  Dados.StartTransaction(Rotina);
  if Rotina.Params.FindParam('FkLinguagens') <> nil then
    Rotina.Params.FindParam('FkLinguagens').AsString := ALang;
  Rotina.Open;
  try
    if (not Rotina.IsEmpty) then
    begin
      Rotina.First;
      Result.Add('... Nenhuma ...');
      while not Rotina.Eof do
      begin
        aItem := TRotine.Create;
        aItem.PkRotina := Rotina.FindField('PK_ROTINAS').AsInteger;
        aItem.DscRot   := Rotina.FindField('DSC_ROT').AsString;
        Result.AddObject(aItem.DscRot, aItem);
        Rotina.Next;
      end;
    end;
  finally
    if (Rotina.Active) then Rotina.Close;
    Dados.CommitTransaction(Rotina);
  end;
end;

function TdmSysMan.LoadCenaries(ABaseOnly: Boolean = True): TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlCenaries);
  Dados.StartTransaction(qrSqlAux);
  try
    if ABaseOnly then
      qrSqlAux.ParamByName('FlagTpCen').AsInteger := 0
    else
      qrSqlAux.ParamByName('FlagTpCen').AsInteger := -1;
    if not qrSqlAux.Active then qrSqlAux.Open;
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_CEN').AsString,
        TObject(qrSqlAux.FieldByName('PK_CENARIOS_FINANCEIROS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

procedure TdmSysMan.SaveLanguage(const AItem: TDataRow;
  const AState: TDBMode; const AOldPk: string = '');
begin
  if (AItem = nil) or (not (AState in UPDATE_MODE)) then exit;
  if Linguagem.Active then Linguagem.Close;
  Linguagem.SQL.Clear;
  case AState of
    dbmInsert: Linguagem.SQL.Add(SqlInsLanguage);
    dbmEdit  : Linguagem.SQL.Add(SqlUpdLanguage);
    dbmDelete: Linguagem.SQL.Add(SqlDelLanguage);
  end;
  Dados.StartTransaction(Linguagem);
  try
    Linguagem.ParamByName('PkLinguagens').AsString := AItem.FieldByName['PK_LINGUAGENS'].AsString;
    if (Linguagem.Params.FindParam('DscLang') <> nil) then
      Linguagem.ParamByName('DscLang').AsString    := AItem.FieldByName['DSC_LANG'].AsString;
    if (Linguagem.Params.FindParam('OldPkLinguagens') <> nil) then
      Linguagem.ParamByName('OldPkLinguagens').AsString := AOldPk;
    Linguagem.ExecSQL;
    Dados.CommitTransaction(Linguagem);
  except on E:Exception do
    begin
      if Linguagem.Active then Linguagem.Close;
      Dados.RollbackTransaction(Linguagem);
      raise Exception.Create('SaveLanguage: Erro ao salvar o registro.' + NL +
        E.Message);
    end;
  end;
end;

procedure TdmSysMan.SaveModule(const AItem: TModule; const AState: TDBMode;
  const AOldPk: Integer = 0; const AOldFkLng: string = '');
  function GetPkModule: Integer;
  begin
    if Modulo.Active then Modulo.Close;
    Modulo.SQL.Clear;
    Modulo.SQL.Add(SqlGenModule);
    Dados.StartTransaction(Modulo);
    try
      Modulo.ParamByName('FkLinguagens').AsString    := AItem.PkLanguage;
      if (not Modulo.Active) then Modulo.Open;
      Result := Modulo.FieldByName('PK_MODULOS').AsInteger
    finally
      if Modulo.Active then Modulo.Close;
      Dados.CommitTransaction(Modulo);
    end;
  end;
begin
  if (AItem = nil) or (not (AState in UPDATE_MODE)) then exit;
  if (AState = dbmInsert) and (AItem.PkModule = 0) then
    AItem.PkModule := GetPkModule;
  if Modulo.Active then Modulo.Close;
  Modulo.SQL.Clear;
  case AState of
    dbmInsert: Modulo.SQL.Add(SqlInsModule);
    dbmEdit  : Modulo.SQL.Add(SqlUpdModule);
    dbmDelete: Modulo.SQL.Add(SqlDelModule);
  end;
  Dados.StartTransaction(Modulo);
  try
    Modulo.ParamByName('FkLinguagens').AsString    := AItem.PkLanguage;
    Modulo.ParamByName('PkModulos').AsInteger      := AItem.PkModule;
    if (Modulo.Params.FindParam('DscMod') <> nil) then
      Modulo.ParamByName('DscMod').AsString        := AItem.DscMod;
    if (Modulo.Params.FindParam('Ver1') <> nil) then
      Modulo.ParamByName('Ver1').AsInteger         := AItem.Ver1;
    if (Modulo.Params.FindParam('Ver2') <> nil) then
      Modulo.ParamByName('Ver2').AsInteger         := AItem.Ver2;
    if (Modulo.Params.FindParam('Ver3') <> nil) then
      Modulo.ParamByName('Ver3').AsInteger         := AItem.Ver3;
    if (Modulo.Params.FindParam('Ver4') <> nil) then
      Modulo.ParamByName('Ver4').AsInteger         := AItem.Ver4;
    if (Modulo.Params.FindParam('Versao') <> nil) then
      Modulo.ParamByName('Versao').AsString        := AItem.Versao;
    if (Modulo.Params.FindParam('OldPkModulos') <> nil) then
      Modulo.ParamByName('OldPkModulos').AsInteger := AOldPk;
    if (Modulo.Params.FindParam('OldFkLinguagens') <> nil) then
      Modulo.ParamByName('OldFkLinguagens').AsString := AOldFkLng;
    Modulo.ExecSQL;
    Dados.CommitTransaction(Modulo);
  except on E:Exception do
    begin
      if Modulo.Active then Modulo.Close;
      Dados.RollbackTransaction(Modulo);
      raise Exception.Create('SaveModule: Erro ao salvar o registro.' + NL +
        E.Message);
    end;
  end;
end;

procedure TdmSysMan.SaveProgram(const AItem: TProgram; const AState: TDBMode);
var
  AStr: TStrings;
  function GetPkProgram: Integer;
  begin
    if Programa.Active then Programa.Close;
    Programa.SQL.Clear;
    Programa.SQL.Add(SqlGenProgram);
    Dados.StartTransaction(Programa);
    try
      Programa.ParamByName('FkLinguagens').AsString    := AItem.PkLanguage;
      Programa.ParamByName('FkModulos').AsInteger      := AItem.PkModule;
      Programa.ParamByName('FkRotinas').AsInteger      := AItem.PkRotine;
      if (not Programa.Active) then Programa.Open;
      Result := Programa.FieldByName('PK_PROGRAMAS').AsInteger
    finally
      if Programa.Active then Programa.Close;
      Dados.CommitTransaction(Programa);
    end;
  end;
begin
  if (AItem = nil) or (not (AState in UPDATE_MODE)) then exit;
  if (AState = dbmInsert) and (AItem.PkProgram = 0) then
    AItem.PkProgram := GetPkProgram;
  if Programa.Active then Programa.Close;
  Programa.SQL.Clear;
  case AState of
    dbmInsert: Programa.SQL.AddStrings(GetInsertSQL(AItem.GetFields, 'PROGRAMAS'));
    dbmEdit  :
    begin
      AStr := TStringList.Create;
      try
        AStr.Add('FK_LINGUAGENS');
        AStr.Add('FK_MODULOS');
        AStr.Add('FK_ROTINAS');
        AStr.Add('PK_PROGRAMAS');
        Programa.SQL.AddStrings(GetUpdateSQL(AItem.GetFields, AStr, 'PROGRAMAS'));
      finally
        FreeAndNil(AStr);
      end;
    end;
    dbmDelete: Programa.SQL.Add(SqlDelProgram);
  end;
  Dados.StartTransaction(Programa);
  try
    Programa.ParamByName('FkLinguagens').AsString    := AItem.PkLanguage;
    Programa.ParamByName('FkModulos').AsInteger      := AItem.PkModule;
    Programa.ParamByName('FkRotinas').AsInteger      := AItem.PkRotine;
    Programa.ParamByName('PkProgramas').AsInteger    := AItem.PkProgram;
    if (Programa.Params.FindParam('OldFkLinguagens') <> nil) then
      Programa.ParamByName('OldFkLinguagens').AsString := AItem.PkLanguage;
    if (Programa.Params.FindParam('OldFkModulos') <> nil) then
      Programa.ParamByName('OldFkModulos').AsInteger   := AItem.PkModule;
    if (Programa.Params.FindParam('OldFkRotinas') <> nil) then
      Programa.ParamByName('OldFkRotinas').AsInteger   := AItem.PkRotine;
    if (Programa.Params.FindParam('OldPkProgramas') <> nil) then
      Programa.ParamByName('OldPkProgramas').AsInteger := AItem.PkProgram;
    if (Programa.Params.FindParam('DscPrg') <> nil) then
      Programa.ParamByName('DscPrg').AsString          := AItem.DscPrg;
    if (Programa.Params.FindParam('NomLib') <> nil) then
      Programa.ParamByName('NomLib').AsString          := AItem.NomLib;
    if (Programa.Params.FindParam('NomFrm') <> nil) then
      Programa.ParamByName('NomFrm').AsString          := AItem.NomForm;
    if (Programa.Params.FindParam('FlagVis') <> nil) then
      Programa.ParamByName('FlagVis').AsInteger        := Ord(AItem.FlagVis);
    if (Programa.Params.FindParam('FlagRel') <> nil) then
      Programa.ParamByName('FlagRel').AsInteger        := Ord(AItem.FlagRel);
    if (Programa.Params.FindParam('FkRelatorios') <> nil) then
      Programa.ParamByName('FkRelatorios').AsInteger   := AItem.FkReport;
    if (Programa.Params.FindParam('QtdParam') <> nil) then
      Programa.ParamByName('QtdParam').AsInteger       := AItem.ProgramParams.Count;
    Programa.ExecSQL;
    SaveProgramParams(AItem);
    Dados.CommitTransaction(Programa);
  except on E:Exception do
    begin
      if Programa.Active then Programa.Close;
      Dados.RollbackTransaction(Programa);
      raise Exception.Create('SaveProgram: Erro ao salvar o registro.' + NL +
        E.Message + NL + Programa.SQL.Text);
    end;
  end;
end;

procedure TdmSysMan.SaveProgramParams(AItem: TProgram);
var
  i: Integer;
begin
  if qrParamPrg.Active then qrParamPrg.Close;
  qrParamPrg.SQL.Clear;
  qrParamPrg.SQL.Add(SqlDelProgramParam);
  qrParamPrg.ParamByName('FkModulos').AsInteger      := AItem.PkModule;
  qrParamPrg.ParamByName('FkRotinas').AsInteger      := AItem.PkRotine;
  qrParamPrg.ParamByName('FkProgramas').AsInteger    := AItem.PkProgram;
  qrParamPrg.ExecSQL;
  if (AItem.ProgramParams.Count = 0) then exit;
  if qrParamPrg.Active then qrParamPrg.Close;
  qrParamPrg.SQL.Clear;
  qrParamPrg.SQL.Add(SqlInsProgramParam);
  qrParamPrg.ParamByName('FkModulos').AsInteger      := AItem.PkModule;
  qrParamPrg.ParamByName('FkRotinas').AsInteger      := AItem.PkRotine;
  qrParamPrg.ParamByName('FkProgramas').AsInteger    := AItem.PkProgram;
  for i := 0 to AItem.ProgramParams.Count - 1 do
  begin
    with AItem.ProgramParams.Items[i] do
    begin
      qrParamPrg.ParamByName('PkParametrosPrg').AsInteger := i + 1;
      qrParamPrg.ParamByName('DscParam').AsString         := DscParam;
      qrParamPrg.ParamByName('NomProp').AsString          := NomProp;
      qrParamPrg.ParamByName('ValProp').AsString          := ValProp;
    end;
    qrParamPrg.ExecSQL;
  end;
end;

procedure TdmSysMan.SaveRotine(const AItem: TDataRow;
  const AState: TDBMode; const AFkLng: string);
  function GetPkRotine: Integer;
  begin
    if Rotina.Active then Rotina.Close;
    Rotina.SQL.Clear;
    Rotina.SQL.Add(SqlGenRotine);
    Dados.StartTransaction(Rotina);
    try
      Rotina.ParamByName('FkLinguagens').AsString := AFkLng;
      if (not Rotina.Active) then Rotina.Open;
      Result := Rotina.FieldByName('PK_ROTINAS').AsInteger
    finally
      if Rotina.Active then Rotina.Close;
      Dados.CommitTransaction(Rotina);
    end;
  end;
begin
  if (AItem = nil) or (not (AState in UPDATE_MODE)) then exit;
  if (AState = dbmInsert) and (AItem.FieldByName['PK_ROTINAS'].AsInteger = 0) then
    AItem.FieldByName['PK_ROTINAS'].AsInteger := GetPkRotine;
  if Rotina.Active then Rotina.Close;
  Rotina.SQL.Clear;
  case AState of
    dbmInsert: Rotina.SQL.Add(SqlInsRotine);
    dbmEdit  : Rotina.SQL.Add(SqlUpdRotine);
    dbmDelete: Rotina.SQL.Add(SqlDelRotine);
  end;
  Dados.StartTransaction(Rotina);
  try
    Rotina.ParamByName('FkLinguagens').AsString    := AFkLng;
    Rotina.ParamByName('PkRotinas').AsInteger      := AItem.FieldByName['PK_ROTINAS'].AsInteger;
    if (Rotina.Params.FindParam('DscRot') <> nil) then
      Rotina.ParamByName('DscRot').AsString        := AItem.FieldByName['DSC_ROT'].AsString;
    Rotina.ExecSQL;
    Dados.CommitTransaction(Rotina);
  except on E:Exception do
    begin
      if Rotina.Active then Rotina.Close;
      Dados.RollbackTransaction(Rotina);
      raise Exception.Create('SaveRotine: Erro ao salvar o registro.' + NL +
        E.Message);
    end;
  end;
end;

procedure TdmSysMan.SaveOperator(const AItem: TOperator; const DataBasePwd,
  AOldPk: string; const AState: TDBMode);
var
  aStrAux: TStrings;
const
  MAP_USER_ACTION: array [dbmInsert..dbmDelete] of TUserAction =
    (uaAdd, uaModify, uaDelete);
begin
  if (AItem = nil) or (not (AState in UPDATE_MODE)) then exit;
  if Operador.Active then Operador.Close;
  Operador.SQL.Clear;
  case AState of
    dbmInsert: Operador.SQL.AddStrings(GetInsertSQL(AItem.GetFields, 'OPERADORES'));
    dbmEdit  :
      begin
        aStrAux := TStringList.Create;
        try
          aStrAux.Add('PK_OPERADORES');
          Operador.SQL.AddStrings(GetUpdateSQL(AItem.GetFields, aStrAux, 'OPERADORES'));
        finally
          FreeAndNil(aStrAux);
        end;
      end;
    dbmDelete: Operador.SQL.Add(SqlDelOperator);
  end;
  Dados.StartTransaction(Operador);
  try
    Operador.ParamByName('PkOperadores').AsString    := AItem.PkOperator;
    if (Operador.Params.FindParam('DsctMax') <> nil) then
      Operador.ParamByName('DsctMax').AsFloat     := AItem.DsctMax;
    if (Operador.Params.FindParam('OldPkOperadores') <> nil) then
      Operador.ParamByName('OldPkOperadores').AsString := AOldPk;
    if (Operador.Params.FindParam('FkEmpresas') <> nil) then
      Operador.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    if (Operador.Params.FindParam('FkCadastros') <> nil) then
      Operador.ParamByName('FkCadastros').AsInteger := AItem.FkOwner;
    if (Operador.Params.FindParam('FkLinguagens') <> nil) then
      Operador.ParamByName('FkLinguagens').AsString := AItem.FkLanguage.PkLanguage;
    if (Operador.Params.FindParam('FlagBrw') <> nil) then
      Operador.ParamByName('FlagBrw').AsInteger     := Ord(AItem.FlagBrw);
    if (Operador.Params.FindParam('FlagDel') <> nil) then
      Operador.ParamByName('FlagDel').AsInteger     := Ord(AItem.FlagDel);
    if (Operador.Params.FindParam('FlagFnd') <> nil) then
      Operador.ParamByName('FlagFnd').AsInteger     := Ord(AItem.FlagFnd);
    if (Operador.Params.FindParam('FlagIns') <> nil) then
      Operador.ParamByName('FlagIns').AsInteger     := Ord(AItem.FlagIns);
    if (Operador.Params.FindParam('FlagLSen') <> nil) then
      Operador.ParamByName('FlagLSen').AsInteger    := Ord(AItem.FlagLSen);
    if (Operador.Params.FindParam('FlagUpd') <> nil) then
      Operador.ParamByName('FlagUpd').AsInteger     := Ord(AItem.FlagUpd);
    if (Operador.Params.FindParam('SenNet') <> nil) then
      Operador.ParamByName('SenNet').AsString       := AItem.SenNet;
    if (Operador.Params.FindParam('eMailOpe') <> nil) then
      Operador.ParamByName('eMailOpe').AsString     := AItem.eMailOpe;
    Operador.ExecSQL;
    // save Updates into Security DataBase
    Dados.UpdateUser(MAP_USER_ACTION[AState], AItem.PkOperator, DataBasePwd,
      '', '', '', ''); // Don't inform role because Processa System not support groups of users
    Dados.CommitTransaction(Operador);
  except on E:Exception do
    begin
      if Operador.Active then Operador.Close;
      Dados.RollbackTransaction(Operador);
      raise Exception.Create('SaveOperator: Erro ao salvar o registro.' + NL +
        E.Message);
    end;
  end;
end;

procedure TdmSysMan.SaveCampanyParams(const AData: TDataRow;
  DataFields: TFieldsEvent; const AState: TDBMode);
var
  aWhr: TStrings;
begin
  if (qrParametro.Active) then qrParametro.Close;
  qrParametro.SQL.Clear;
  aWhr := TStringList.Create;
  try
    aWhr.Add('FK_EMPRESAS');
    case AState of
      dbmEdit  : qrParametro.SQL.AddStrings(GetUpdateSQL(DataFields, aWhr, 'PARAMETROS'));
      dbmInsert: qrParametro.SQL.AddStrings(GetInsertSQL(DataFields, 'PARAMETROS'));
    end;
  finally
    FreeAndNil(aWhr);
  end;
  Dados.StartTransaction(qrParametro);
  try
    qrParametro.ParamByName('FkEmpresas').AsInteger := AData.FieldByName['FK_EMPRESAS'].AsInteger;
    if (qrParametro.Params.FindParam('FkCenariosFinanceiros') <> nil) then
      qrParametro.ParamByName('FkCenariosFinanceiros').AsInteger := AData.FieldByName['FK_CENARIOS_FINANCEIROS'].AsInteger;
    if (qrParametro.Params.FindParam('TaxJurM') <> nil) then
      qrParametro.ParamByName('TaxJurM').AsFloat := AData.FieldByName['TAX_JURM'].AsFloat;
    if (qrParametro.Params.FindParam('MrglPdr') <> nil) then
      qrParametro.ParamByName('MrglPdr').AsFloat := AData.FieldByName['MRGL_PDR'].AsFloat;
    if (qrParametro.Params.FindParam('CustFix') <> nil) then
      qrParametro.ParamByName('CustFix').AsFloat := AData.FieldByName['CUST_FIX'].AsFloat;
    if (qrParametro.Params.FindParam('DsctMax') <> nil) then
      qrParametro.ParamByName('DsctMax').AsFloat := AData.FieldByName['DSCT_MAX'].AsFloat;
    if (qrParametro.Params.FindParam('FlagComTPgto') <> nil) then
      qrParametro.ParamByName('FlagComTPgto').AsInteger := AData.FieldByName['FLAG_COM_TPGTO'].AsInteger;
    if (qrParametro.Params.FindParam('FlagComDesc') <> nil) then
      qrParametro.ParamByName('FlagComDesc').AsInteger := AData.FieldByName['FLAG_COM_DESC'].AsInteger;
    if (qrParametro.Params.FindParam('FlagDescItem') <> nil) then
      qrParametro.ParamByName('FlagDescItem').AsInteger := AData.FieldByName['FLAG_DESC_ITEM'].AsInteger;
    if (qrParametro.Params.FindParam('FlagComItem') <> nil) then
      qrParametro.ParamByName('FlagComItem').AsInteger := AData.FieldByName['FLAG_COM_ITEM'].AsInteger;
    if (qrParametro.Params.FindParam('FlagAcmFin') <> nil) then
      qrParametro.ParamByName('FlagAcmFin').AsInteger := AData.FieldByName['FLAG_ACM_FIN'].AsInteger;
    qrParametro.ExecSQL;
    Dados.CommitTransaction(qrParametro);
  except on E:Exception do
    begin
      if (qrParametro.Active) then qrParametro.Close;
      Dados.RollbackTransaction(qrParametro);
      raise Exception.Create('SaveCompanyParams: Não foi possível salvar o registro ' +
        NL + E.Message + NL + qrParametro.SQL.Text);
    end;
  end;
end;

function TdmSysMan.GetCompanyParams(const APk: Integer): TDataRow;
begin
  if qrParametro.Active then qrParametro.Close;
  qrParametro.SQL.Clear;
  qrParametro.SQL.Add(SqlParametros);
  Dados.StartTransaction(qrParametro);
  try
    qrParametro.ParamByName('FkEmpresas').AsInteger := APk;
    if (not qrParametro.Active) then qrParametro.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrParametro, True);
  finally
    if qrParametro.Active then qrParametro.Close;
    Dados.CommitTransaction(qrParametro);
  end;
end;

function TdmSysMan.GetTypeDocument(const APk: Integer): TTypeDocument;
var
  M: TStream;
begin
  Result := TTypeDocument.Create;
  if qrTypeDoc.Active then qrTypeDoc.Close;
  qrTypeDoc.SQL.Clear;
  qrTypeDoc.SQL.Add(SqlTipoDocumento);
  Dados.StartTransaction(qrTypeDoc);
  try
    qrTypeDoc.ParamByName('PkTipoDocumentos').AsInteger := APk;
    if (not qrTypeDoc.Active) then qrTypeDoc.Open;
    if (not qrTypeDoc.IsEmpty) then
    begin
      Result.PkTypeDocument := qrTypeDoc.FieldByName('PK_TIPO_DOCUMENTOS').AsInteger;
      Result.DscTDoc        := qrTypeDoc.FieldByName('DSC_TDOC').AsString;
      Result.QtdItem        := qrTypeDoc.FieldByName('QTD_ITM').AsInteger;
      Result.FlagExt        := Boolean(qrTypeDoc.FieldByName('FLAG_EXT').AsInteger);
      Result.FlagTDoc       := TDocumentType(qrTypeDoc.FieldByName('FLAG_TDOC').AsInteger);
      if (not qrTypeDoc.FieldByName('OBS_TDOC').IsNull) then
      begin
        M := TMemoryStream.Create;
        try
          TBlobField(qrTypeDoc.FieldByName('OBS_TDOC')).SaveToStream(M);
          M.Position := 0;
          Result.ObsDoc.LoadFromStream(M);
        finally
          FreeAndNil(M);
        end;
      end;
    end;
  finally
    if qrTypeDoc.Active then qrTypeDoc.Close;
    Dados.CommitTransaction(qrTypeDoc);
  end;
end;

function TdmSysMan.SaveTypeDocument(AItem: TTypeDocument;
  AState: TDBMode): Integer;
var
  aWhr: TStrings;
  M   : TMemoryStream;
  function GetPkTypeDoc: Integer;
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenTypeDoc);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_TIPO_DOCUMENTOS').AsInteger;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
    end;
  end;
begin
  if (qrTypeDoc.Active) then qrTypeDoc.Close;
  qrTypeDoc.SQL.Clear;
  aWhr := TStringList.Create;
  try
    aWhr.Add('PK_TIPO_DOCUMENTOS');
    case AState of
      dbmDelete: qrTypeDoc.SQL.Add(SqlDeleteTypeDoc);
      dbmEdit  : qrTypeDoc.SQL.AddStrings(GetUpdateSQL(AItem.GetFields, aWhr, 'TIPO_DOCUMENTOS'));
      dbmInsert: qrTypeDoc.SQL.AddStrings(GetInsertSQL(AItem.GetFields, 'TIPO_DOCUMENTOS'));
    end;
  finally
    FreeAndNil(aWhr);
  end;
  Dados.StartTransaction(qrTypeDoc);
  try
    if (AState = dbmInsert) then
      AItem.PkTypeDocument := GetPkTypeDoc;
    Result := AItem.PkTypeDocument;
    qrTypeDoc.ParamByName('PkTipoDocumentos').AsInteger := AItem.PkTypeDocument;
    if (qrTypeDoc.Params.FindParam('OldPkTipoDocumentos') <> nil) then
      qrTypeDoc.ParamByName('OldPkTipoDocumentos').AsInteger := AItem.PkTypeDocument;
    if (qrTypeDoc.Params.FindParam('DscTDoc') <> nil) then
      qrTypeDoc.ParamByName('DscTDoc').AsString := AItem.DscTDoc;
    if (qrTypeDoc.Params.FindParam('FlagTDoc') <> nil) then
      qrTypeDoc.ParamByName('FlagTDoc').AsInteger := Ord(AItem.FlagTDoc);
    if (qrTypeDoc.Params.FindParam('FlagExt') <> nil) then
      qrTypeDoc.ParamByName('FlagExt').AsInteger := Ord(AItem.FlagExt);
    if (qrTypeDoc.Params.FindParam('QtdItm') <> nil) then
      qrTypeDoc.ParamByName('QtdItm').AsInteger := AItem.QtdItem;
    if (qrTypeDoc.Params.FindParam('ObsTDoc') <> nil) then
    begin
      M := TMemoryStream.Create;
      try
        AItem.ObsDoc.SaveToStream(M);
        M.Position := 0;
        qrTypeDoc.ParamByName('ObsTDoc').LoadFromStream(M, ftBlob);
      finally
        FreeAndNil(M);
      end;
    end;
    qrTypeDoc.ExecSQL;
    Dados.CommitTransaction(qrTypeDoc);
  except on E:Exception do
    begin
      if (qrTypeDoc.Active) then qrTypeDoc.Close;
      Dados.RollbackTransaction(qrTypeDoc);
      raise Exception.Create('SaveTypeDocument: Não foi possível salvar o registro ' +
        NL + E.Message + NL + qrTypeDoc.SQL.Text);
    end;
  end;
end;

function TdmSysMan.GetMask(const APk: Integer; const ALang: string): TDataRow;
begin
  if qrMask.Active then qrMask.Close;
  qrMask.SQL.Clear;
  qrMask.SQL.Add(SqlMascara);
  Dados.StartTransaction(qrMask);
  try
    qrMask.ParamByName('FkLinguagens').AsString := ALang;
    qrMask.ParamByName('PkMascaras').AsInteger  := APk;
    if (not qrMask.Active) then qrMask.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrMask, True);
  finally
    if qrMask.Active then qrMask.Close;
    Dados.CommitTransaction(qrMask);
  end;
end;

function TdmSysMan.SaveMask(const AData: TDataRow;
  const AState: TDBMode): Integer;
  function GetPkMask: Integer;
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenMasks);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_MASCARAS').AsInteger;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
    end;
  end;
begin
  if (qrMask.Active) then qrMask.Close;
  qrMask.SQL.Clear;
  case AState of
    dbmDelete: qrMask.SQL.Add(SqlDeleteMask);
    dbmEdit  : qrMask.SQL.Add(SqlUpdateMask);
    dbmInsert: qrMask.SQL.Add(SqlInsertMask);
  end;
  Dados.StartTransaction(qrMask);
  try
    if (AState = dbmInsert) then
      AData.FieldByName['PK_MASCARAS'].AsInteger := GetPkMask;
    if (AState = dbmDelete) then
      Result := 0
    else
      Result := AData.FieldByName['PK_MASCARAS'].AsInteger;
    qrMask.ParamByName('FkLinguagens').AsString := AData.FieldByName['PK_LINGUAGENS'].AsString;
    qrMask.ParamByName('PkMascaras').AsInteger  := AData.FieldByName['PK_MASCARAS'].AsInteger;
    if (qrMask.Params.FindParam('DscMsk') <> nil) then
      qrMask.ParamByName('DscMsk').AsString     := AData.FieldByName['DSC_MSK'].AsString;
    if (qrMask.Params.FindParam('MskMsk') <> nil) then
      qrMask.ParamByName('MskMsk').AsString     := AData.FieldByName['MSK_MSK'].AsString;
    qrMask.ExecSQL;
    Dados.CommitTransaction(qrMask);
  except on E:Exception do
    begin
      if (qrMask.Active) then qrMask.Close;
      Dados.RollbackTransaction(qrMask);
      raise Exception.Create('SaveMask: Não foi possível salvar o registro ' +
        NL + E.Message + NL + qrMask.SQL.Text);
    end;
  end;
end;

function TdmSysMan.GetMessages(const APk: Integer;
  const ALng: string): TDataRow;
begin
  if qrMessage.Active then qrMessage.Close;
  qrMessage.SQL.Clear;
  qrMessage.SQL.Add(SqlMessage);
  try
    Dados.StartTransaction(qrMessage);
    qrMessage.ParamByName('FkLinguagens').AsString := ALng;
    qrMessage.ParamByName('PkMensagens').AsInteger := APk;
    Result := TDataRow.CreateFromDataSet(nil, qrMessage, True);
  finally
    if qrMessage.Active then qrMessage.Close;
    Dados.CommitTransaction(qrMessage);
  end;
end;

function  TdmSysMan.SaveMessage(const AData: TDataRow; const AState: TDBMode): Integer;
  function GetPkMessage: Integer;
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenMessage);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_MENSAGENS').AsInteger;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
    end;
  end;
begin
  if (qrMessage.Active) then qrMessage.Close;
  qrMessage.SQL.Clear;
  case AState of
    dbmDelete: qrMessage.SQL.Add(SqlDeleteMsg);
    dbmEdit  : qrMessage.SQL.Add(SqlUpdateMsg);
    dbmInsert: qrMessage.SQL.Add(SqlInsertMsg);
  end;
  Dados.StartTransaction(qrMessage);
  try
    if (AState = dbmInsert) then
      AData.FieldByName['FK_MENSAGENS'].AsInteger := GetPkMessage;
    Result := AData.FieldByName['FK_MENSAGENS'].AsInteger;
    qrMessage.ParamByName('FkLinguagens').AsString := AData.FieldByName['FK_LINGUAGENS'].AsString;
    qrMessage.ParamByName('FkMensagens').AsInteger := AData.FieldByName['FK_MENSAGENS'].AsInteger;
    if (qrMessage.Params.FindParam('FkModulos') <> nil) then
      qrMessage.ParamByName('FkModulos').AsInteger := AData.FieldByName['FK_MODULOS'].AsInteger;
    if (qrMessage.Params.FindParam('FkRotinas') <> nil) then
      qrMessage.ParamByName('FkRotinas').AsInteger := AData.FieldByName['FK_ROTINAS'].AsInteger;
    if (qrMessage.Params.FindParam('FkProgramas') <> nil) then
      qrMessage.ParamByName('FkProgramas').AsInteger := AData.FieldByName['FK_PROGRAMAS'].AsInteger;
    if (qrMessage.Params.FindParam('DscCnst') <> nil) then
      qrMessage.ParamByName('DscCnst').AsString := AData.FieldByName['DSC_CNST'].AsString;
    if (qrMessage.Params.FindParam('NomCnst') <> nil) then
      qrMessage.ParamByName('NomCnst').AsString := AData.FieldByName['NOM_CNST'].AsString;
    qrMessage.ExecSQL;
    Dados.CommitTransaction(qrMessage);
  except on E:Exception do
    begin
      if (qrMessage.Active) then qrMessage.Close;
      Dados.RollbackTransaction(qrMessage);
      raise Exception.Create('SaveCompanyParams: Não foi possível salvar o registro ' +
        NL + E.Message + NL + qrMessage.SQL.Text);
    end;
  end;
end;

function TdmSysMan.GetGlobalParams(const APk: Integer): TDataRow;
begin
  if qrParamGlobal.Active then qrParamGlobal.Close;
  qrParamGlobal.SQL.Clear;
  qrParamGlobal.SQL.Add(SqlGlobalParams);
  Dados.StartTransaction(qrParamGlobal);
  try
    qrParamGlobal.ParamByName('PkParametroGlobais').AsInteger := APk;
    Result := TDataRow.CreateFromDataSet(nil, qrParamGlobal, True);
  finally
    if qrParamGlobal.Active then qrParamGlobal.Close;
    Dados.CommitTransaction(qrParamGlobal);
  end;
end;

function TdmSysMan.SaveGlobalParams(const AData: TDataRow;
  const AState: TDBMode): Integer;
begin
  Result := 1;
  if qrParamGlobal.Active then qrParamGlobal.Close;
  qrParamGlobal.SQL.Clear;
  case AState of
    dbmInsert: qrParamGlobal.SQL.Add(SqlInsertGlbPrms);
    dbmEdit  : qrParamGlobal.SQL.Add(SqlUpdateGlbPrms);
  end;
  Dados.StartTransaction(qrParamGlobal);
  try
    with qrParamGlobal do
    begin
      ParamByName('PkParametroGlobais').AsInteger := 1;
      ParamByName('FkClientes').AsInteger   := AData.FieldByName['FK_CLIENTES'].AsInteger;
      ParamByName('DiasAtr').AsInteger      := AData.FieldByName['DIAS_ATR'].AsInteger;
      ParamByName('PerCvMed').AsInteger     := AData.FieldByName['PER_CVMED'].AsInteger;
      ParamByName('QtdDvMed').AsInteger     := AData.FieldByName['QTD_DVMED'].AsInteger;
      ParamByName('QtdDcMed').AsInteger     := AData.FieldByName['QTD_DCMED'].AsInteger;
      ParamByName('QtdDTol').AsInteger      := AData.FieldByName['QTD_DTOL'].AsInteger;
      ParamByName('NumCasDec').AsInteger    := AData.FieldByName['NUM_CAS_DEC'].AsInteger;
      ParamByName('NumCasDecQtd').AsInteger := AData.FieldByName['NUM_CAS_DEC_QTD'].AsInteger;
      ParamByName('FlagLanParc').AsInteger  := AData.FieldByName['FLAG_LAN_PARC'].AsInteger;
      ParamByName('FlagMulti').AsInteger    := AData.FieldByName['FLAG_MULTI'].AsInteger;
    end;
    qrParamGlobal.ExecSQL;
    Dados.CommitTransaction(qrParamGlobal);
  except on E:Exception do
    begin
      if qrParamGlobal.Active then qrParamGlobal.Close;
      Dados.RollbackTransaction(qrParamGlobal);
      raise Exception.Create('SaveGlobalParams: Não posso salvar o registro ' + NL +
        E.Message + NL + qrParamGlobal.SQL.Text);
    end;
  end;
end;

initialization
   Application.CreateForm(TdmSysMan, dmSysMan);
finalization
   if Assigned(dmSysMan) then dmSysMan.Free;
   dmSysMan := nil;
end.
