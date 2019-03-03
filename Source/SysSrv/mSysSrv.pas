unit mSysSrv;

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
  DB, Encryp, ProcType, FMTBcd, SqlExpr, TSysSrv, ProcUtils, TSysEstqAux;

resourcestring
  sFormatDate     = 'mm-dd-yyyy';
  sFormatTime     = 'hh:mm:ss';
  sFormatDateTime = 'mm-dd-yyyy hh:mm:ss';

type
  TScrollKey = record
    PkRodovias  : Integer;
    PkTipoOS    : Integer;
    PkPaises    : Integer;
    PkEstados   : string;
    PkMunicipios: Integer;
    PkUnidades  : Integer;
    FlagLanParc : Integer;
  end;

  TdmSysSrv = class(TDataModule)
    Composicao: TSQLQuery;
    dsAccess: TSQLQuery;
    SqlAux: TSQLQuery;
    SqlKey: TSQLQuery;
    Classificacoes: TSQLQuery;
    qrFinance: TSQLQuery;
    Rodovia: TSQLQuery;
    Praca: TSQLQuery;
    Rodovias: TSQLQuery;
    Paises: TSQLQuery;
    Estados: TSQLQuery;
    Municipios: TSQLQuery;
    LimiteMunicipio: TSQLQuery;
    Unidades: TSQLQuery;
    Pracas: TSQLQuery;
    TipoStatus: TSQLQuery;
    TipoOS: TSQLQuery;
    Documentos: TSQLQuery;
    TiposOS: TSQLQuery;
    StatusOS: TSQLQuery;
    TipoPgtos: TSQLQuery;
    Cadastros: TSQLQuery;
    qrServiceOrder: TSQLQuery;
    qrSOItems: TSQLQuery;
    qrSOHistorics: TSQLQuery;
    qrSOItemsLocal: TSQLQuery;
    qrSOItemsIns: TSQLQuery;
    TipoCompo: TSQLQuery;
    Insumos: TSQLQuery;
    Parametro: TSQLQuery;
    Parametros: TSQLQuery;
    procedure RodoviaNewRecord(DataSet: TDataSet);
    procedure PracaNewRecord(DataSet: TDataSet);
    procedure RodoviasBeforeOpen(DataSet: TDataSet);
    procedure LimiteMunicipioNewRecord(DataSet: TDataSet);
    procedure LimiteMunicipioAfterScroll(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure LimiteMunicipioBeforePost(DataSet: TDataSet);
    procedure LimiteMunicipioBeforeOpen(DataSet: TDataSet);
    procedure PracaBeforeOpen(DataSet: TDataSet);
    procedure RodoviaBeforeOpen(DataSet: TDataSet);
    procedure TipoStatusNewRecord(DataSet: TDataSet);
    procedure ParametroNewRecord(DataSet: TDataSet);
    procedure ParametroBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FScrollKey   : TScrollKey;
  public
    { Public declarations }
    Historicos   : TSystemLog;
    procedure LoadMunicipios;
    function  GetPkRodovias: Integer;
    function  GetPkPracas: Integer;
    function  GetPkLimitesMunicipios(AFkRodovias: Integer): Integer;
    function  GetPkTipoStatus: Integer;
    procedure LoadEstados;
    function  GetTypeServiceOrder: TStrings;
    function  GetStatusServiceOrder: TStrings;
    function  GetHighWay : TStrings;
    function  GetPayments: TStrings;
    function  GetOwners(ATypeES: TTypeES): TStrings;
    function  GetPkServiceOrder(AServiceOrder: TServiceOrder): Integer;
    procedure MoveObject2Data(AServiceOrder: TServiceOrder; AMode: TDbMode);
    procedure MoveItemsObjects2Data(AServiceOrder: TServiceOrder);
    function  GetServiceOrder(AServiceOrder: TServiceOrder;
                const APkCompany, APkServiceOrder: Integer): Boolean;
    function  GetServiceOrderHistorics(AServiceOrder: TServiceOrder;
                const APkCompany, APkServiceOrder: Integer): Boolean;
    function  GetServiceOrderItems(AServiceOrderItems: TServiceOrderItems;
                const APkCompany, APkServiceOrder: Integer;
                const AFlagTOS: TTypeUse): Boolean;
    procedure GetServiceOrderItemsInsumos(AFkInsumos: TInsumos;
                const APkCompany, APkServiceOrder, APkServiceOrderItem: Integer);
    procedure MoveData2Object(AServiceOrder: TServiceOrder);
    procedure MoveData2ObjectHist(AServiceOrder: TServiceOrder);
    function  MoveData2ObjectItems(AServiceOrderItems: TServiceOrderItems;
                aFlagTOS: TTypeUse): Integer;
    procedure MoveData2ObjectItemsInsumos(AFkInsumos: TInsumos;
                APkServiceOrderIdx: Integer);
    function  GetTypeCompositions: TStrings;
    function  GetClassifications(AFlagES: Integer): TStrings;
    function  GetInsumos(AType: Integer): TStrings;
    procedure SaveInstallments(AOS: TServiceOrder);
    property  PkRodovias : Integer read FScrollKey.PkRodovias  write FScrollKey.PkRodovias  default 0;
  end;

var
  dmSysSrv: TdmSysSrv;

implementation

uses AltPass, Funcoes, Autor, FuncoesDB, ModelTyp, SrvArqSql, Dado,
  CmmConst, SqlComm, ArqCnst, Math, TSysSrvAux, TSysPedAux, TSysFatAux, TSysCad,
  TypInfo;

{$R *.DFM}

procedure TdmSysSrv.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
  FScrollKey.PkRodovias  := 0;
end;

function TdmSysSrv.GetPkRodovias: Integer;
begin
  if SqlKey.Active then SqlKey.Close;
  SqlKey.SQL.Clear;
  SqlKey.SQL.Add(SqlGetKeyForRodov);
  if (SqlKey.Params.Count > 0) and
     (SqlKey.Params.FindParam('FkEmpresas') <> nil) then
    SqlKey.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
  if not SqlKey.Active then SqlKey.Open;
  if (not SqlKey.IsEmpty) and
     (SqlKey.FindField('R_PK_RODOVIAS') <> nil) then
    Result := SqlKey.FindField('R_PK_RODOVIAS').AsInteger
  else
    Result := 0;
  if SqlKey.Active then SqlKey.Close;
end;

procedure TdmSysSrv.RodoviaNewRecord(DataSet: TDataSet);
begin
  try
    Rodovia.FieldByName('FK_EMPRESAS').AsInteger := Dados.PkCompany;
    Rodovia.FieldByName('PK_RODOVIAS').AsInteger := GetPkRodovias;
    Rodovia.FieldByName('EXT_TOT_ROD').AsFloat   := ZEROFLOAT;
    Rodovia.FieldByName('EXT_ROD_POLO').AsFloat  := ZEROFLOAT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

function TdmSysSrv.GetPkPracas: Integer;
begin
  if SqlKey.Active then SqlKey.Close;
  SqlKey.SQL.Clear;
  SqlKey.SQL.Add(SqlGetKeyForPraca);
  if (SqlKey.Params.Count > 0) and
     (SqlKey.Params.FindParam('FkEmpresas') <> nil) then
    SqlKey.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
  if not SqlKey.Active then SqlKey.Open;
  if (not SqlKey.IsEmpty) and
     (SqlKey.FindField('R_PK_PRACAS') <> nil) then
    Result := SqlKey.FindField('R_PK_PRACAS').AsInteger
  else
    Result := 0;
  if SqlKey.Active then SqlKey.Close;
end;

procedure TdmSysSrv.PracaNewRecord(DataSet: TDataSet);
begin
  try
    Praca.FieldByName('FK_EMPRESAS').AsInteger := Dados.PkCompany;
    Praca.FieldByName('PK_PRACAS').AsInteger   := GetPkPracas;
    Praca.FieldByName('POS_TRC').AsFloat       := ZEROFLOAT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysSrv.RodoviasBeforeOpen(DataSet: TDataSet);
begin
  if (Rodovias.Params.Count > 0) and
     (Rodovias.Params.FindParam('FkEmpresas') <> nil) then
    Rodovias.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
end;

function TdmSysSrv.GetPkLimitesMunicipios(AFkRodovias: Integer): Integer;
begin
  if SqlKey.Active then SqlKey.Close;
  SqlKey.SQL.Clear;
  SqlKey.SQL.Add(SqlGetKcLimites);
  if (SqlKey.Params.Count > 0) then
  begin
    if (SqlKey.Params.FindParam('FkEmpresas') <> nil) then
      SqlKey.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
    if (SqlKey.Params.FindParam('FkRodovias') <> nil) then
      SqlKey.Params.FindParam('FkRodovias').AsInteger := AFkRodovias;
  end;
  if not SqlKey.Active then SqlKey.Open;
  if (not SqlKey.IsEmpty) and
     (SqlKey.FindField('R_PK_LIMITES_MUNICIPIOS') <> nil) then
    Result := SqlKey.FindField('R_PK_LIMITES_MUNICIPIOS').AsInteger
  else
    Result := 0;
  if SqlKey.Active then SqlKey.Close;
end;

procedure TdmSysSrv.LimiteMunicipioNewRecord(DataSet: TDataSet);
begin
  try
    LimiteMunicipio.FieldByName('FK_EMPRESAS').AsInteger   := Dados.PkCompany;
    LimiteMunicipio.FieldByName('FK_RODOVIAS').AsInteger   := FScrollKey.PkRodovias;
    LimiteMunicipio.FieldByName('PK_LIMITES_MUNICIPIOS').AsInteger := ZEROINT;
    LimiteMunicipio.FieldByName('FK_PAISES').AsInteger     := FScrollKey.PkPaises;
    LimiteMunicipio.FieldByName('FK_ESTADOS').AsString     := FScrollKey.PkEstados;
    LimiteMunicipio.FieldByName('FK_MUNICIPIOS').AsInteger := FScrollKey.PkMunicipios;
    LimiteMunicipio.FieldByName('FK_UNIDADES').AsInteger   := FScrollKey.PkUnidades;
    LimiteMunicipio.FieldByName('KM_INI').AsFloat          := ZEROFLOAT;
    LimiteMunicipio.FieldByName('KM_FIN').AsFloat          := ZEROFLOAT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysSrv.LimiteMunicipioAfterScroll(DataSet: TDataSet);
begin
  if LimiteMunicipio.FieldByName('FK_PAISES').AsInteger <> FScrollKey.PkPaises then
  begin
    if FScrollKey.PkPaises = 0 then
      FScrollKey.PkPaises   := Dados.Parametros.soCompanyCountry;
    FScrollKey.PkPaises     := LimiteMunicipio.FieldByName('FK_PAISES').AsInteger;
    LoadEstados;
  end;
  if LimiteMunicipio.FieldByName('FK_ESTADOS').AsString <> FScrollKey.PkEstados then
  begin
    FScrollKey.PkPaises     := LimiteMunicipio.FieldByName('FK_PAISES').AsInteger;
    if FScrollKey.PkEstados = '' then
      FScrollKey.PkEstados  := Dados.Parametros.soCompanyState;
    FScrollKey.PkEstados    := LimiteMunicipio.FieldByName('FK_ESTADOS').AsString;
    LoadMunicipios;
  end;
  FScrollKey.PkRodovias   := LimiteMunicipio.FieldByName('FK_RODOVIAS').AsInteger;
  FScrollKey.PkPaises     := LimiteMunicipio.FieldByName('FK_PAISES').AsInteger;
  FScrollKey.PkEstados    := LimiteMunicipio.FieldByName('FK_ESTADOS').AsString;
  FScrollKey.PkMunicipios := LimiteMunicipio.FieldByName('FK_MUNICIPIOS').AsInteger;
  FScrollKey.PkUnidades   := LimiteMunicipio.FieldByName('FK_UNIDADES').AsInteger;
end;

procedure TdmSysSrv.LimiteMunicipioBeforePost(DataSet: TDataSet);
begin
  if (LimiteMunicipio.FieldByName('PK_LIMITES_MUNICIPIOS').AsInteger = 0) and
     (LimiteMunicipio.FieldByName('FK_RODOVIAS').AsInteger           > 0) then
    LimiteMunicipio.FieldByName('PK_LIMITES_MUNICIPIOS').AsInteger :=
      GetPkLimitesMunicipios(LimiteMunicipio.FieldByName('FK_RODOVIAS').AsInteger);
end;

procedure TdmSysSrv.LoadEstados;
begin
  if Estados.Active then Estados.Close;
  Estados.SQL.Clear;
  Estados.SQL.Add(SqlEstados);
  if Estados.Params.FindParam('FkPaises') <> nil then
    Estados.Params.FindParam('FkPaises').AsInteger :=
      Paises.FieldByName('PK_PAISES').AsInteger;
  if not Estados.Active then Estados.Open;
end;

procedure TdmSysSrv.LoadMunicipios;
begin
  if Municipios.Active then Municipios.Close;
  Municipios.SQL.Clear;
  Municipios.SQL.Add(SqlMunicipios);
  if Municipios.Params.FindParam('FkPaises') <> nil then
    Municipios.Params.FindParam('FkPaises').AsInteger :=
      Paises.FieldByName('PK_PAISES').AsInteger;
  if Municipios.Params.FindParam('FkEstados') <> nil then
    Municipios.Params.FindParam('FkEstados').AsString :=
      Estados.FieldByName('PK_ESTADOS').AsString;
    if not Municipios.Active then Municipios.Open;
end;

procedure TdmSysSrv.LimiteMunicipioBeforeOpen(DataSet: TDataSet);
begin
  if (LimiteMunicipio.Params.Count > 0) and
     (LimiteMunicipio.Params.FindParam('FkEmpresas') <> nil) then
    LimiteMunicipio.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
end;

procedure TdmSysSrv.PracaBeforeOpen(DataSet: TDataSet);
begin
  if (Praca.Params.Count > 0) and
     (Praca.Params.FindParam('FkEmpresas') <> nil) then
    Praca.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
end;

procedure TdmSysSrv.RodoviaBeforeOpen(DataSet: TDataSet);
begin
  if (Rodovia.Params.Count > 0) and
     (Rodovia.Params.FindParam('FkEmpresas') <> nil) then
    Rodovia.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
end;

function TdmSysSrv.GetPkTipoStatus: Integer;
begin
  if SqlKey.Active then SqlKey.Close;
  SqlKey.SQL.Clear;
  SqlKey.SQL.Add(SqlGetKcTipoStatus);
  if not SqlKey.Active then SqlKey.Open;
  if (not SqlKey.IsEmpty) and
     (SqlKey.FindField('R_PK_TIPO_STATUS_OS') <> nil) then
    Result := SqlKey.FindField('R_PK_TIPO_STATUS_OS').AsInteger
  else
    Result := 0;
  if SqlKey.Active then SqlKey.Close;
end;

procedure TdmSysSrv.TipoStatusNewRecord(DataSet: TDataSet);
begin
  try
    TipoStatus.FieldByName('PK_TIPO_STATUS_OS').AsInteger := GetPkTipoStatus;
    TipoStatus.FieldByName('FLAG_STT').AsInteger          := ZEROINT;
    TipoStatus.FieldByName('FLAG_AUT').AsInteger          := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysSrv.ParametroNewRecord(DataSet: TDataSet);
begin
  try
    Parametro.FieldByName('FK_EMPRESAS').AsInteger      := Dados.PkCompany;
    Parametro.FieldByName('FLAG_EDTSRV').AsInteger      := FLAG_NAO;
    Parametro.FieldByName('FLAG_EDTCOMP').AsInteger     := FLAG_NAO;
    Parametro.FieldByName('FLAG_EDTVAL_ABRT').AsInteger := FLAG_SIM;
    Parametro.FieldByName('KEY_PRACAS').AsInteger       := ZEROINT;
    Parametro.FieldByName('KEY_RODOVIAS').AsInteger     := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysSrv.ParametroBeforeOpen(DataSet: TDataSet);
begin
  if Parametro.Params.FindParam('FkEmpresas') <> nil then
    Parametro.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
end;

function TdmSysSrv.GetTypeServiceOrder: TStrings;
var
  aTypeOS: TTypeServiceOrder;
begin
  Result := TStringList.Create;
  if (TiposOS.Active) then TiposOS.Close;
  TiposOS.SQL.Clear;
  TiposOS.SQL.Add(SqlTiposOS);
  TiposOS.Open;
  try
    if (not TiposOS.IsEmpty) then
    begin
      TiposOS.First;
      Result.AddObject('<Nenhum>', nil);
      while not TiposOS.Eof do
      begin
        aTypeOS := TTypeServiceOrder.Create;
        aTypeOS.DscTOS               := TiposOS.FindField('DSC_TOS').AsString;
        aTypeOS.FkGruposMovimentos   := TiposOS.FindField('PK_GRUPOS_MOVIMENTOS').AsInteger;
        aTypeOS.FkTipoDocumentos     := TiposOS.FindField('FK_TIPO_DOCUMENTOS').AsInteger;
        aTypeOS.FkTipoMovimentos     := TiposOS.FindField('PK_TIPO_MOVIMENTOS').AsInteger;
        aTypeOS.FlagCns              := Boolean(TiposOS.FindField('FLAG_CNS').AsInteger);
        aTypeOS.FlagCod              := TCodeTypes(TiposOS.FindField('FLAG_COD').AsInteger);
        aTypeOS.FlagES               := TTypeES(TiposOS.FindField('FLAG_ES').AsInteger);
        aTypeOS.FlagGFin             := Boolean(TiposOS.FindField('FLAG_GFIN').AsInteger);
        aTypeOS.FlagLdv              := Boolean(TiposOS.FindField('FLAG_LDV').AsInteger);
        aTypeOS.FlagTOS              := TTypeUse(TiposOS.FindField('FLAG_TOS').AsInteger);
        aTypeOS.PkTipoOrdensServicos := TiposOS.FindField('PK_TIPO_ORDENS_SERVICOS').AsInteger;
        aTypeOS.Index                := Result.AddObject(aTypeOS.DscTOS, aTypeOS);
        TiposOS.Next;
      end;
    end;
  finally
    if (TiposOS.Active) then TiposOS.Close;
  end;
end;

function TdmSysSrv.GetStatusServiceOrder: TStrings;
var
  aStatusOS: TStatusOS;
begin
  Result := TStringList.Create;
  if (StatusOS.Active) then StatusOS.Close;
  StatusOS.SQL.Clear;
  StatusOS.SQL.Add(SqlStatusOS);
  StatusOS.Open;
  try
    if (not StatusOS.IsEmpty) then
    begin
      StatusOS.First;
      Result.AddObject('<Nenhum>', nil);
      while not StatusOS.Eof do
      begin
        aStatusOS := TStatusOS.Create;
        aStatusOS.PkStatusOS := StatusOS.FindField('PK_TIPO_STATUS_OS').AsInteger;
        aStatusOS.DscStt     := StatusOS.FindField('DSC_STT').AsString;
        aStatusOS.FlagStt    := TTypeStt(StatusOS.FindField('FLAG_STT').AsInteger);
        aStatusOS.FlagAut    := StatusOS.FindField('FLAG_AUT').AsInteger;
        aStatusOS.Index      := Result.AddObject(aStatusOS.DscStt, aStatusOS);
        StatusOS.Next;
      end;
    end;
  finally
    if (StatusOS.Active) then StatusOS.Close;
  end;
end;

function TdmSysSrv.GetHighWay: TStrings;
var
  aRodovias: TRodovias;
begin
  Result := TStringList.Create;
  if (Rodovias.Active) then Rodovias.Close;
  Rodovias.SQL.Clear;
  Rodovias.SQL.Add(SqlRodovias);
  Rodovias.Params.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
  Rodovias.Open;
  try
    if (not Rodovias.IsEmpty) then
    begin
      Rodovias.First;
      Result.AddObject('<Nenhum>', nil);
      while not Rodovias.Eof do
      begin
        aRodovias := TRodovias.Create;
        aRodovias.PkRodovias := Rodovias.FindField('PK_Rodovias').AsInteger;
        aRodovias.DscRod     := Rodovias.FindField('DSC_ROD').AsString;
        aRodovias.KmIni      := Rodovias.FindField('KM_INI').AsFloat;
        aRodovias.KmFin      := Rodovias.FindField('KM_FIN').AsFloat;
        aRodovias.ExtTot     := aRodovias.KmFin - aRodovias.KmIni;
        aRodovias.Index      := Result.AddObject(aRodovias.DscRod, aRodovias);
        Rodovias.Next;
      end;
    end;
  finally
    if (Rodovias.Active) then Rodovias.Close;
  end;
end;

function TdmSysSrv.GetPayments: TStrings;
var
  aPayment: TTypePayment;
begin
  Result := TStringList.Create;
  if (TipoPgtos.Active) then TipoPgtos.Close;
  TipoPgtos.SQL.Clear;
  TipoPgtos.SQL.Add(SqlTipoPgtos);
  TipoPgtos.Params.ParamByName('FkGruposMovimentos').AsInteger := 0;
  TipoPgtos.Open;
  try
    if (not TipoPgtos.IsEmpty) then
    begin
      TipoPgtos.First;
      Result.AddObject('<Nenhum>', nil);
      while not TipoPgtos.Eof do
      begin
        aPayment              := TTypePayment.Create;
        aPayment.PkTypePgto   := TipoPgtos.FieldByName('PK_TIPO_PAGAMENTOS').AsInteger;
        aPayment.DscTPgt      := TipoPgtos.FieldByName('DSC_TPG').AsString;
        aPayment.FlagBaseDate := TBaseDate(TipoPgtos.FieldByName('FLAG_DATA_BASE').AsInteger);
        aPayment.FlagBlock    := Boolean(TipoPgtos.FieldByName('FLAG_SEN').AsInteger);
        aPayment.FlagTInt     := TIntervalPay(TipoPgtos.FieldByName('FLAG_TINT').AsInteger);
        aPayment.FlagTVda     := TTypeSale(TipoPgtos.FieldByName('FLAG_TVDA').AsInteger);
        aPayment.cbIndex      := Result.AddObject(APayment.DscTPgt, aPayment);
        TipoPgtos.Next;
      end;
    end;
  finally
    if (TipoPgtos.Active) then TipoPgtos.Close;
  end;
end;

function TdmSysSrv.GetOwners(ATypeES: TTypeES): TStrings;
var
  aOwner: TOwner;
begin
  Result := TStringList.Create;
  if (ATypeES = esBoth) then exit;
  if (Cadastros.Active) then Cadastros.Close;
  Cadastros.SQL.Clear;
  case ATypeES of
    esSaida  : Cadastros.SQL.Add(SqlClientes);
    esEntrada: Cadastros.SQL.Add(SqlFornecedores);
  end;
  Cadastros.Open;
  try
    if (not Cadastros.IsEmpty) then
    begin
      Cadastros.First;
      Result.AddObject('<Nenhum>', nil);
      while not Cadastros.Eof do
      begin
        aOwner := TOwner.Create;
        aOwner.PkCadastros := Cadastros.FindField('PK_CADASTROS').AsInteger;
        aOwner.RazSoc      := Cadastros.FindField('RAZ_SOC').AsString;
        aOwner.cbIndex     := Result.AddObject(aOwner.RazSoc, aOwner);
        Cadastros.Next;
      end;
    end;
  finally
    if (Cadastros.Active) then Cadastros.Close;
  end;
end;

function  TdmSysSrv.GetPkServiceOrder(AServiceOrder: TServiceOrder): Integer;
begin
  Result := 0;
  if (AServiceOrder = nil) or (AServiceOrder.FkEmpresas = nil) or
     (AServiceOrder.FkEmpresas.PkCompany = 0) or
     (AServiceOrder.FkTypeServiceOrder = nil) or
     (AServiceOrder.FkTypeServiceOrder.FkTipoDocumentos = 0) then exit;
  if SqlKey.Active then SqlKey.Close;
  SqlKey.SQL.Clear;
  SqlKey.SQL.Add(SqlGetKcOS);
  if (SqlKey.Params.FindParam('FkEmpresas') <> nil) then
    SqlKey.Params.FindParam('FkEmpresas').AsInteger := AServiceOrder.FkEmpresas.PkCompany;
  if (SqlKey.Params.FindParam('FkTipoDocumentos') <> nil) then
    SqlKey.Params.FindParam('FkTipoDocumentos').AsInteger :=
      AServiceOrder.FkTypeServiceOrder.FkTipoDocumentos;
  try
    if not SqlKey.Active then SqlKey.Open;
    if SqlKey.IsEmpty then exit;
    if (SqlKey.FindField('R_PK_ORDENS_SERVICOS') <> nil) then
      Result := SqlKey.FindField('R_PK_ORDENS_SERVICOS').AsInteger;
  finally
    if SqlKey.Active then SqlKey.Close;
  end;
end;

procedure TdmSysSrv.MoveObject2Data(AServiceOrder: TServiceOrder; AMode: TDbMode);
var
  i: Integer;
  aPk: TStrings;
begin
  if qrServiceOrder.Active then qrServiceOrder.Close;
  qrServiceOrder.SQL.Clear;
  if AMode = dbmInsert then
    qrServiceOrder.SQL.AddStrings(GetInsertSQL(AServiceOrder.GetFields, 'ORDENS_SERVICOS'));
  if AMode = dbmEdit then
  begin
    aPk := TStringList.Create;
    try
      aPk.Add('FK_EMPRESAS');
      aPk.Add('PK_ORDENS_SERVICOS');
      qrServiceOrder.SQL.AddStrings(GetUpdateSQL(AServiceOrder.GetFields, aPk,
         'ORDENS_SERVICOS'));
    finally
      aPk.Free;
    end;
  end;
  Dados.StartTransaction(qrServiceOrder);
  try
    if (AMode = dbmInsert) and (AServiceOrder.PkOS = 0) then
      AServiceOrder.PkOS := GetPkServiceOrder(AServiceOrder);
    if qrServiceOrder.SQL.Count = 0 then exit;
    qrServiceOrder.ParamByName('FkEmpresas').AsInteger           := AServiceOrder.FkEmpresas.PkCompany;
    qrServiceOrder.ParamByName('PkOrdensServicos').AsInteger     := AServiceOrder.PkOS;
    if (qrServiceOrder.Params.FindParam('OldFkEmpresas') <> nil) then
      qrServiceOrder.ParamByName('OldFkEmpresas').AsInteger      := AServiceOrder.FkEmpresas.PkCompany;
    if (qrServiceOrder.Params.FindParam('OldPkOrdensServicos') <> nil) then
      qrServiceOrder.ParamByName('OldPkOrdensServicos').AsInteger := AServiceOrder.PkOS;
    qrServiceOrder.ParamByName('FkTipoOrdensServicos').AsInteger := AServiceOrder.FkTypeServiceOrder.PkTipoOrdensServicos;
    qrServiceOrder.ParamByName('FkGruposMovimentos').AsInteger   := AServiceOrder.FkTypeServiceOrder.FkGruposMovimentos;
    qrServiceOrder.ParamByName('FkTipoMovimentos').AsInteger     := AServiceOrder.FkTypeServiceOrder.FkTipoMovimentos;
    qrServiceOrder.ParamByName('FkCadastros').AsInteger          := AServiceOrder.FkCadastros.PkCadastros;
    qrServiceOrder.ParamByName('FkRodovias').AsInteger           := AServiceOrder.FkRodovias.PkRodovias;
    qrServiceOrder.ParamByName('FkTipoStatusOS').AsInteger       := AServiceOrder.FkStatusOS.PkStatusOS;
    qrServiceOrder.ParamByName('DtaOS').AsDate                   := AServiceOrder.DtaOS;
    qrServiceOrder.ParamByName('SubTot').AsFloat                 := AServiceOrder.SubTot;
    qrServiceOrder.ParamByName('VlrAcrDsct').AsFloat             := AServiceOrder.VlrAcrDsct;
    qrServiceOrder.ParamByName('TotOrd').AsFloat                 := AServiceOrder.TotOS;
    qrServiceOrder.ParamByName('QtdItems').AsInteger             := AServiceOrder.ServiceOrderItems.Count;
    qrServiceOrder.ParamByName('KeyItems').AsInteger             := AServiceOrder.ServiceOrderItems.Count;
    if (qrServiceOrder.Params.FindParam('FkTipoPagamentos') <> nil) then
      qrServiceOrder.ParamByName('FkTipoPagamentos').AsInteger := AServiceOrder.FkPayment.PkTypePgto;
    if (qrServiceOrder.Params.FindParam('DscOrd') <> nil) then
      if (AServiceOrder.DscOrd = '') then
        qrServiceOrder.ParamByName('DscOrd').AsString  := ' '
      else
        qrServiceOrder.ParamByName('DscOrd').AsString  := AServiceOrder.DscOrd;
    if (qrServiceOrder.Params.FindParam('DtaIni') <> nil) then
      qrServiceOrder.ParamByName('DtaIni').AsDate    := AServiceOrder.DtaIni;
    if (qrServiceOrder.Params.FindParam('DtaFin') <> nil) then
      qrServiceOrder.ParamByName('DtaFin').AsDate    := AServiceOrder.DtaFin;
    if (qrServiceOrder.Params.FindParam('DtaApr') <> nil) then
      qrServiceOrder.ParamByName('DtaApr').AsDate    := AServiceOrder.DtaAprv;
    if (qrServiceOrder.Params.FindParam('DtaCanc') <> nil) then
      qrServiceOrder.ParamByName('DtaCanc').AsDate   := AServiceOrder.DtaCanc;
    if (qrServiceOrder.Params.FindParam('DtaLiq') <> nil) then
      qrServiceOrder.ParamByName('DtaLiq').AsDate    := AServiceOrder.DtaLiq;
    if (qrServiceOrder.Params.FindParam('DtaBlq') <> nil) then
      qrServiceOrder.ParamByName('DtaBlq').AsDate    := AServiceOrder.DtaBlq;
    if (qrServiceOrder.Params.FindParam('CodAut') <> nil) then
      qrServiceOrder.ParamByName('CodAut').AsInteger := AServiceOrder.CodAut;
    if (qrServiceOrder.Params.FindParam('DtaLibFin') <> nil) then
      qrServiceOrder.ParamByName('DtaLibFin').AsDate := AServiceOrder.DtaLibFin;
    try
      qrServiceOrder.ExecSQL;
    except on E:Exception do
      raise Exception.Create(qrServiceOrder.SQL.Text + NL + E.Message);
    end;
  // Delete all Historics from active Service Order
    if (AServiceOrder.Historics.Count > 0) then
    begin
      if qrSOHistorics.Active then qrSOHistorics.Close;
      qrSOHistorics.SQL.Clear;
      qrSOHistorics.SQL.Add(SqlDeleteHistorics);
      qrSOHistorics.Params.ParamByName('FkEmpresas').AsInteger       := AServiceOrder.FkEmpresas.PkCompany;
      qrSOHistorics.Params.ParamByName('FkOrdensServicos').AsInteger := AServiceOrder.PkOS;
      try
        qrSOHistorics.ExecSQL;
      except on E:Exception do
        raise Exception.Create(qrSOHistorics.SQL.Text + NL + E.Message);
      end;
    // Save Service Order Historics
      if qrSOHistorics.Active then qrSOHistorics.Close;
      qrSOHistorics.SQL.Clear;
      qrSOHistorics.SQL.Add(SqlInsertHistorics);
      if (AServiceOrder.Historics <> nil) then
      begin
        for i := 0 to AServiceOrder.Historics.Count - 1 do
        begin
          qrSOHistorics.ParamByName('FkEmpresas').AsInteger       := AServiceOrder.FkEmpresas.PkCompany;;
          qrSOHistorics.ParamByName('FkOrdensServicos').AsInteger := AServiceOrder.PkOS;
          qrSOHistorics.ParamByName('PkOSHistoricos').AsInteger   := i;
          if AServiceOrder.FkStatusOS.PkStatusOS = 0 then
            qrSOHistorics.Params.Delete(qrSOHistorics.ParamByName('FkTipoStatusOS').Index)
          else
            qrSOHistorics.ParamByName('FkTipoStatusOS').AsInteger := AServiceOrder.FkStatusOS.PkStatusOS;
          qrSOHistorics.ParamByName('FkOrdensServicosItens').AsInteger :=
            AServiceOrder.Historics.Items[i].ServiceItem;
          qrSOHistorics.ParamByName('SeqIns').AsInteger           :=
            AServiceOrder.Historics.Items[i].SeqIns;
          qrSOHistorics.ParamByName('DtaHist').AsDateTime         := Now;
          qrSOHistorics.ParamByName('CodAut').AsInteger           := AServiceOrder.CodAut;
          qrSOHistorics.ParamByName('DscHist').AsString           :=
            AServiceOrder.Historics.Items[i].DscHist;
          try
            qrSOHistorics.ExecSQL;
          except on E:Exception do
            raise Exception.Create(qrSOHistorics.SQL.Text + NL + E.Message);
          end;
          if qrSOHistorics.Active then qrSOHistorics.Close;
        end;
      end;
    end;
  // Save Service Order Items
    MoveItemsObjects2Data(AServiceOrder);
    // Commit Transaction
    Dados.CommitTransaction(qrServiceOrder);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrServiceOrder);
      raise Exception.Create('Erro na Gravação: ' + NL + E.Message);
    end;
  end;
end;

procedure TdmSysSrv.MoveItemsObjects2Data(AServiceOrder: TServiceOrder);
var
  aIdx, i: Integer;
begin
  if (AServiceOrder = nil) or (AServiceOrder.ServiceOrderItems = nil) then
    exit;
  // Delete all items from active ServiceOrder
  if qrSOItems.Active then qrSOItems.Close;
  qrSOItems.SQL.Clear;
  qrSOItems.SQL.Add(SqlDeleteSOItems);
  qrSOItems.Params.ParamByName('FkEmpresas').AsInteger       := AServiceOrder.FkEmpresas.PkCompany;
  qrSOItems.Params.ParamByName('FkOrdensServicos').AsInteger := AServiceOrder.PkOS;
  try
    qrSOItems.ExecSQL;
  except on E:Exception do
    raise Exception.Create(qrSOItems.SQL.Text + NL + E.Message);
  end;
  if qrSOItems.Active then qrSOItems.Close;
  for aIdx := 0 to AServiceOrder.ServiceOrderItems.Count - 1 do
  begin
    qrSOItems.SQL.Clear;
    qrSOItems.SQL.Add(SqlInsertSOItems);
    qrSOItems.Params.ParamByName('FkEmpresas').AsInteger       := AServiceOrder.FkEmpresas.PkCompany;
    qrSOItems.Params.ParamByName('FkOrdensServicos').AsInteger := AServiceOrder.PkOS;
    with AServiceOrder.ServiceOrderItems.Items[aIdx] do
    begin
      qrSOItems.Params.ParamByName('PkOrdensServicosItens').AsInteger := aIdx + 1;
      qrSOItems.Params.ParamByName('FkProdutosServicos').AsInteger    := PkProduct;
      qrSOItems.Params.ParamByName('FkClassificacao').AsInteger       := FkClassification;
      qrSOItems.Params.ParamByName('FlagPers').AsInteger := Integer(FlagPers);
      qrSOItems.Params.ParamByName('QtdSrv').AsFloat     := QtdSrv;
      qrSOItems.Params.ParamByName('VlrUnit').AsFloat    := VlrUnit;
      qrSOItems.Params.ParamByName('TotSrv').AsFloat     := TotSrv;
      qrSOItems.Params.ParamByName('FlagTQtd').AsInteger := FlagDBQtd;
      qrSOItems.Params.ParamByName('AltSrv').AsFloat     := AltSrv;
      qrSOItems.Params.ParamByName('LargSrv').AsFloat    := LargSrv;
      qrSOItems.Params.ParamByName('CompSrv').AsFloat    := CompSrv;
      if DtaFat = 0 then
        qrSOItems.Params.Delete(qrSOItems.ParamByName('DtaFat').Index)
      else
        qrSOItems.Params.ParamByName('DtaFat').AsDate    := DtaFat;
      try
        qrSOItems.ExecSQL;
      except on E:Exception do
        raise Exception.Create(qrSOItems.SQL.Text + NL + E.Message);
      end;
      if qrSOItems.Active then qrSOItems.Close;
      if (AServiceOrder.FkTypeServiceOrder.FlagTOS = tuMetric) and
         (Assigned(FkMetricItem)) then
      begin
        if qrSOItemsLocal.Active then qrSOItemsLocal.Close;
        qrSOItemsLocal.SQL.Clear;
        qrSOItemsLocal.SQL.Add(SqlInsertSOItemsLo);
        qrSOItemsLocal.Params.ParamByName('FkEmpresas').AsInteger       := AServiceOrder.FkEmpresas.PkCompany;
        qrSOItemsLocal.Params.ParamByName('FkOrdensServicos').AsInteger := AServiceOrder.PkOS;
        qrSOItemsLocal.Params.ParamByName('FkOrdensServicosItens').AsInteger := aIdx + 1;
        qrSOItemsLocal.Params.ParamByName('LocIni').AsFloat     := FkMetricItem.KmIni;
        qrSOItemsLocal.Params.ParamByName('LocFin').AsFloat     := FkMetricItem.KmFin;
        qrSOItemsLocal.Params.ParamByName('FlagSide').AsInteger := Integer(FkMetricItem.FlagSide);
        try
          qrSOItemsLocal.ExecSQL;
        except on E:Exception do
          raise Exception.Create(qrSOItemsLocal.SQL.Text + NL + E.Message);
        end;
        if qrSOItemsLocal.Active then qrSOItemsLocal.Close;
      end;
      if (Assigned(FkInsumos)) and (FkInsumos.Count > 0) then
      begin
        if qrSOItemsIns.Active then qrSOItemsIns.Close;
        for i := 0 to FkInsumos.Count - 1 do
        begin
          qrSOItemsIns.SQL.Clear;
          qrSOItemsIns.SQL.Add(SqlInsertSOItmIns);
          qrSOItemsIns.Params.ParamByName('FkEmpresas').AsInteger := AServiceOrder.FkEmpresas.PkCompany;
          qrSOItemsIns.Params.ParamByName('FkOrdensServicos').AsInteger   := AServiceOrder.PkOS;
          qrSOItemsIns.Params.ParamByName('FkInsumo').AsInteger   := FkInsumos.Items[i].FKProduct;
          qrSOItemsIns.Params.ParamByName('SeqItem').AsInteger    := FkInsumos.Items[i].SeqIns;
          qrSOItemsIns.Params.ParamByName('FkOsItens').AsInteger  := aIdx + 1;
          qrSOItemsIns.Params.ParamByName('FlagFrn').AsInteger    := Integer(FkInsumos.Items[i].FlagFrn);
          qrSOItemsIns.Params.ParamByName('FlagTIns').AsInteger   := Integer(FkInsumos.Items[i].FlagTIns);
          qrSOItemsIns.Params.ParamByName('QtdIns').AsFloat       := RoundTo(FkInsumos.Items[i].QtdIns, -4);
          qrSOItemsIns.Params.ParamByName('AltIns').AsFloat       := FkInsumos.Items[i].AltIns;
          qrSOItemsIns.Params.ParamByName('LargIns').AsFloat      := FkInsumos.Items[i].LargIns;
          qrSOItemsIns.Params.ParamByName('CompIns').AsFloat      := FkInsumos.Items[i].CompIns;
          qrSOItemsIns.Params.ParamByName('FlagTQtd').AsInteger   := FkInsumos.Items[i].FlagDBQtd;
          qrSOItemsIns.Params.ParamByName('VlrUnit').AsFloat      := RoundTo(FkInsumos.Items[i].VlrUnit, -4);
          try
            qrSOItemsIns.ExecSQL;
          except on E:Exception do
            raise Exception.Create(qrSOItemsIns.SQL.Text + NL + E.Message);
          end;
          if qrSOItemsIns.Active then qrSOItemsIns.Close;
        end;
      end;
    end;
  end;
end;

function TdmSysSrv.GetServiceOrder(AServiceOrder: TServiceOrder;
           const APkCompany, APkServiceOrder: Integer): Boolean;
begin
  Result := False;
  if AServiceOrder = nil then exit;
  if AServiceOrder.PkOS > 0 then
    AServiceOrder.Clear;
  if qrServiceOrder.Active then qrServiceOrder.Close;
  qrServiceOrder.SQL.Clear;
  qrServiceOrder.SQL.Add(SqlServiceOrder);
  if (qrServiceOrder.Params.FindParam('FkEmpresas') <> nil) then
    qrServiceOrder.Params.FindParam('FkEmpresas').AsInteger       := APkCompany;
  if (qrServiceOrder.Params.FindParam('PkOrdensServicos') <> nil) then
    qrServiceOrder.Params.FindParam('PkOrdensServicos').AsInteger := APkServiceOrder;
  if not qrServiceOrder.Active then qrServiceOrder.Open;
  Result := not qrServiceOrder.IsEmpty;
  try
    if (Result) then
      MoveData2Object(AServiceOrder);
  finally
    if qrServiceOrder.Active then qrServiceOrder.Close;
  end;
  GetServiceOrderHistorics(AServiceOrder, APkCompany, APkServiceOrder);
  if Result then
    Result := GetServiceOrderItems(AServiceOrder.ServiceOrderItems, APkCompany,
                APkServiceOrder, AServiceOrder.FkTypeServiceOrder.FlagTOS);
end;

function TdmSysSrv.GetServiceOrderHistorics(AServiceOrder: TServiceOrder;
           const APkCompany, APkServiceOrder: Integer): Boolean;
begin
  Result := False;
  if (APkCompany <= 0) or (APkServiceOrder <= 0) then exit;
  if qrSOHistorics.Active then qrSOHistorics.Close;
  qrSOHistorics.SQL.Clear;
  qrSOHistorics.SQL.Add(SqlServiceOrderHst);
  if (qrSOHistorics.Params.FindParam('FkEmpresas') <> nil) then
    qrSOHistorics.Params.FindParam('FkEmpresas').AsInteger       := APkCompany;
  if (qrSOHistorics.Params.FindParam('FkOrdensServicos') <> nil) then
    qrSOHistorics.Params.FindParam('FkOrdensServicos').AsInteger := APkServiceOrder;
  if not qrSOHistorics.Active then qrSOHistorics.Open;
  try
    Result := not qrSOHistorics.IsEmpty;
    qrSOHistorics.First;
    while not qrSOHistorics.EOF do
    begin
      MoveData2ObjectHist(AServiceOrder);
      qrSOHistorics.Next;
    end;
  finally
    if qrSOHistorics.Active then qrSOHistorics.Close;
  end;
end;

function TdmSysSrv.GetServiceOrderItems(AServiceOrderItems: TServiceOrderItems;
           const APkCompany, APkServiceOrder: Integer;
           const AFlagTOS: TTypeUse): Boolean;
var
  aIdx: Integer;
begin
  if qrSOItems.Active then qrSOItems.Close;
  qrSOItems.SQL.Clear;
  qrSOItems.SQL.Add(SqlServiceOrderItm);
  if (qrSOItems.Params.FindParam('FkEmpresas') <> nil) then
    qrSOItems.Params.FindParam('FkEmpresas').AsInteger       := APkCompany;
  if (qrSOItems.Params.FindParam('FkOrdensServicos') <> nil) then
    qrSOItems.Params.FindParam('FkOrdensServicos').AsInteger := APkServiceOrder;
  if not qrSOItems.Active then qrSOItems.Open;
  Result := not qrSOItems.IsEmpty;
  try
    qrSOItems.First;
    while not qrSOItems.Eof do
    begin
      aIdx := MoveData2ObjectItems(AServiceOrderItems, AFlagTOS);
      if (qrSOItems.FindField('PK_ORDENS_SERVICOS_ITENS') <> nil) and
         (AIdx > -1) then
      begin
        GetServiceOrderItemsInsumos(
          AServiceOrderItems.Items[aIdx].FkInsumos,
          APkCompany, APkServiceOrder, aIdx + 1)
      end;
      qrSOItems.Next;
    end;
  finally
    if qrSOItems.Active then qrSOItems.Close;
  end;
end;

procedure TdmSysSrv.GetServiceOrderItemsInsumos(AFkInsumos: TInsumos;
           const APkCompany, APkServiceOrder, APkServiceOrderItem: Integer);
begin
  if AFkInsumos = nil then exit;
  if SqlAux.Active then SqlAux.Close;
  SqlAux.SQL.Clear;
  SqlAux.SQL.Add(SqlOSItemsInsumos1);
//  SqlAux.SQL.Add(SqlOSItemsInsumos2);
  if (SqlAux.Params.FindParam('FkEmpresas') <> nil) then
    SqlAux.Params.FindParam('FkEmpresas').AsInteger       := APkCompany;
  if (SqlAux.Params.FindParam('FkOrdensServicos') <> nil) then
    SqlAux.Params.FindParam('FkOrdensServicos').AsInteger := APkServiceOrder;
  if (SqlAux.Params.FindParam('FkOSItens') <> nil) then
    SqlAux.Params.FindParam('FkOSItens').AsInteger        := APkServiceOrderItem;
  if not SqlAux.Active then SqlAux.Open;
  try
    SqlAux.First;
    while not SqlAux.Eof do
    begin
      MoveData2ObjectItemsInsumos(AFkInsumos, APkServiceOrderItem - 1);
      SqlAux.Next;
    end;
  finally
    if SqlAux.Active then SqlAux.Close;
  end;
end;

procedure TdmSysSrv.MoveData2Object(AServiceOrder: TServiceOrder);
begin
  if not qrServiceOrder.Active then exit;
  AServiceOrder.FkEmpresas.PkCompany := qrServiceOrder.FieldbyName('FK_EMPRESAS').AsInteger;
  AServiceOrder.FkTypeServiceOrder.PkTipoOrdensServicos := qrServiceOrder.FieldbyName('FK_TIPO_ORDENS_SERVICOS').AsInteger;
  AServiceOrder.FkTypeServiceOrder.FlagTOS := TTypeUse(qrServiceOrder.FieldbyName('FLAG_TOS').AsInteger);
  AServiceOrder.FkTypeServiceOrder.FkGruposMovimentos := qrServiceOrder.FieldbyName('FK_GRUPOS_MOVIMENTOS').AsInteger;
  AServiceOrder.FkTypeServiceOrder.FkTipoMovimentos   := qrServiceOrder.FieldbyName('FK_TIPO_MOVIMENTOS').AsInteger;
//  AServiceOrder.FkTypeServiceOrder.FkTipoDocumentos   := qrServiceOrder.FieldbyName('FK_TIPO_DOCUMENTOS').AsInteger;
  AServiceOrder.FkTypeServiceOrder.FlagTOS := TTypeUse(qrServiceOrder.FieldbyName('FLAG_TOS').AsInteger);
  AServiceOrder.FkCadastros.PkCadastros := qrServiceOrder.FieldbyName('FK_CADASTROS').AsInteger;
  AServiceOrder.FkRodovias.PkRodovias   := qrServiceOrder.FieldbyName('FK_RODOVIAS').AsInteger;
  AServiceOrder.FkStatusOS.PkStatusOS   := qrServiceOrder.FieldbyName('FK_TIPO_STATUS_OS').AsInteger;
  AServiceOrder.FkPayment.PkTypePgto    := qrServiceOrder.FieldbyName('FK_TIPO_PAGAMENTOS').AsInteger;
  AServiceOrder.FkPayment.DscTPgt       := qrServiceOrder.FieldbyName('DSC_TPG').AsString;
  AServiceOrder.PkOS         := qrServiceOrder.FieldbyName('PK_ORDENS_SERVICOS').AsInteger;
  AServiceOrder.DscOrd       := qrServiceOrder.FieldbyName('DSC_ORD').AsString;
  AServiceOrder.DtaIni       := qrServiceOrder.FieldbyName('DTA_INI').AsDateTime;
  AServiceOrder.DtaFin       := qrServiceOrder.FieldbyName('DTA_FIN').AsDateTime;
  AServiceOrder.DtaLibFin    := qrServiceOrder.FieldbyName('DTA_LIB_FIN').AsDateTime;
  AServiceOrder.DtaAprv      := qrServiceOrder.FieldbyName('DTA_APR').AsDateTime;
  AServiceOrder.DtaOS        := qrServiceOrder.FieldbyName('DTA_OS').AsDateTime;
  AServiceOrder.DtaCanc      := qrServiceOrder.FieldbyName('DTA_CANC').AsDateTime;
  AServiceOrder.DtaLiq       := qrServiceOrder.FieldbyName('DTA_LIQ').AsDateTime;
  AServiceOrder.DtaBlq       := qrServiceOrder.FieldbyName('DTA_BLQ').AsDateTime;
  AServiceOrder.SubTot       := qrServiceOrder.FieldbyName('SUB_TOT').AsFloat;
  AServiceOrder.VlrAcrDsct   := qrServiceOrder.FieldbyName('VLR_ACR_DSCT').AsFloat;
  AServiceOrder.TotOS        := qrServiceOrder.FieldbyName('TOT_ORD').AsFloat;
  AServiceOrder.CodAut       := qrServiceOrder.FieldbyName('COD_AUT').AsInteger;
end;

procedure TdmSysSrv.MoveData2ObjectHist(AServiceOrder: TServiceOrder);
var
  aHist: THistoric;
begin
  aHist              := AServiceOrder.Historics.Add;
  aHist.CodAut       := qrSOHistorics.FindField('COD_AUT').AsInteger;
  aHist.DscHist      := qrSOHistorics.FindField('DSC_HIST').AsString;
  aHist.DscCad       := qrSOHistorics.FindField('RAZ_SOC').AsString;
  aHist.DtHrHist     := qrSOHistorics.FindField('DTA_HIST').AsDateTime;
  aHist.ServiceItem  := qrSOHistorics.FindField('FK_ORDENS_SERVICOS_ITENS').AsInteger;
  aHist.SeqIns       := qrSOHistorics.FindField('SEQ_INS').AsInteger;
  if Assigned(aHist.FkStatusOS) then
  begin
    aHist.FkStatusOS.PkStatusOS := qrSOHistorics.FindField('FK_TIPO_STATUS_OS').AsInteger;
    aHist.FKStatusOS.DscStt     := qrSOHistorics.FindField('DSC_STT').AsString;
    aHist.FkStatusOS.FlagStt    := TTypeStt(qrSOHistorics.FindField('FLAG_STT').AsInteger);
    aHist.FkStatusOS.FlagAut    := qrSOHistorics.FindField('FLAG_AUT').AsInteger;
  end;
  if aHist.CodAut > 0 then
    aHist.HistoricType := htAutorization;
  if (aHist.FkStatusOS <> nil) and (aHist.FkStatusOS.PkStatusOS > 0) then
    aHist.HistoricType := htStatus;
  if (aHist.FkStatusOS <> nil) and (aHist.FkStatusOS.PkStatusOS = 0) and
     (aHist.CodAut = 0) then
    aHist.HistoricType := htNone;
end;

function TdmSysSrv.MoveData2ObjectItems(AServiceOrderItems: TServiceOrderItems;
           aFlagTOS: TTypeUse): Integer;
var
  aOSItem: TServiceOrderItem;
begin
  aOSItem                  := AServiceOrderItems.Add;
  Result                   := aOsItem.Index;
  aOsItem.ItemIsVisible    := False;
  aOSItem.Node             := nil;
  aOsItem.FkClassification := qrSOItems.FieldByName('FK_CLASSIFICACAO').AsInteger;
  if not Assigned(aOSItem.FkInsumos) then
    aOsItem.FkInsumos := TInsumos.Create(aOsItem);
  if (qrSOItems.FindField('FK_PRODUTOS_SERVICOS') <> nil) then
    aOsItem.PkProduct := qrSOItems.FieldByName('FK_PRODUTOS_SERVICOS').AsInteger;
  if (qrSOItems.FindField('DSC_PROD')  <> nil) then
    aOsItem.DscTComp  := qrSOItems.FieldByName('DSC_PROD').AsString;
  if (qrSOItems.FieldByName('FLAG_TQTD') <> nil) then
    aOsItem.FlagDBQtd  := qrSOItems.FieldByName('FLAG_TQTD').AsInteger;
  if (qrSOItems.FindField('FK_CLASSIFICACAO') <> nil) then
    aOsItem.FkClassification := qrSOItems.FieldByName('FK_CLASSIFICACAO').AsInteger;
  if (qrSOItems.FindField('DTA_FAT') <> nil) then
    aOSItem.DtaFat := qrSOItems.FieldByName('DTA_FAT').AsDateTime;
  if (qrSOItems.FindField('QTD_SRV') <> nil) then
    aOSItem.QtdSrv := qrSOItems.FieldByName('QTD_SRV').AsFloat;
  if (qrSOItems.FindField('VLR_UNIT') <> nil) then
    aOSItem.VlrUnit := qrSOItems.FieldByName('VLR_UNIT').AsFloat;
  if (qrSOItems.FindField('FLAG_PERS') <> nil) then
    aOSItem.FlagPers := Boolean(qrSOItems.FieldByName('FLAG_PERS').AsInteger);
  if (qrSOItems.FindField('LARG_SRV') <> nil) then
    aOSItem.LargSrv := qrSOItems.FieldByName('LARG_SRV').AsFloat;
  if (qrSOItems.FindField('ALT_SRV') <> nil) then
    aOSItem.AltSrv := qrSOItems.FieldByName('ALT_SRV').AsFloat;
  if (qrSOItems.FindField('COMP_SRV') <> nil) then
    aOSItem.CompSrv := qrSOItems.FieldByName('COMP_SRV').AsFloat;
  if AFlagTOS = tuMetric then
  begin
    if not Assigned(aOSItem.FkMetricItem) then
      aOSItem.FkMetricItem := TMetricItem.Create;
    if (qrSOItems.FindField('LOC_INI') <> nil) then
      aOSItem.FkMetricItem.KmIni := qrSOItems.FieldByName('LOC_INI').AsFloat;
    if (qrSOItems.FindField('LOC_FIN') <> nil) then
      aOSItem.FkMetricItem.KmFin := qrSOItems.FieldByName('LOC_FIN').AsFloat;
    if (qrSOItems.FindField('FLAG_SIDE') <> nil) then
      aOSItem.FkMetricItem.FlagSide := TSide(qrSOItems.FieldByName('FLAG_SIDE').AsInteger);
  end;
end;

procedure TdmSysSrv.MoveData2ObjectItemsInsumos(AFkInsumos: TInsumos;
            APkServiceOrderIdx: Integer);
var
  aInsumo: TInsumo;
begin
  aInsumo := AFkInsumos.Add;
  aInsumo.Node := nil;
  if (SqlAux.FindField('SEQ_ITEM') <> nil) then
    aInsumo.SeqIns := SqlAux.FieldByName('SEQ_ITEM').AsInteger;
  if (SqlAux.FindField('FLAG_TINS') <> nil) then
    case SqlAux.FieldByName('FLAG_TINS').AsInteger of
      0: aInsumo.FlagTIns := tiService;
      1: aInsumo.FlagTIns := tiPurchase;
    end;
  if (SqlAux.FindField('DSC_PROD') <> nil) then
    aInsumo.DscIns := SqlAux.FieldByName('DSC_PROD').AsString;
  if (SqlAux.FindField('FLAG_TQTD') <> nil) then
    aInsumo.FlagDBQtd := SqlAux.FieldByName('FLAG_TQTD').AsInteger;
  if (SqlAux.FindField('QTD_INS') <> nil) then
    aInsumo.QtdIns := SqlAux.FieldByName('QTD_INS').AsFloat;
  if (SqlAux.FindField('ALT_INS') <> nil) then
    aInsumo.AltIns := SqlAux.FieldByName('ALT_INS').AsFloat;
  if (SqlAux.FindField('LARG_INS') <> nil) then
    aInsumo.LargIns := SqlAux.FieldByName('LARG_INS').AsFloat;
  if (SqlAux.FindField('COMP_INS') <> nil) then
    aInsumo.CompIns := SqlAux.FieldByName('COMP_INS').AsFloat;
  if (SqlAux.FindField('VLR_UNIT') <> nil) then
    aInsumo.VlrUnit := SqlAux.FieldByName('VLR_UNIT').AsFloat;
  if (SqlAux.FindField('FK_INSUMO') <> nil) then
    aInsumo.FKProduct := SqlAux.FieldByName('FK_INSUMO').AsInteger;
  if (SqlAux.FindField('FLAG_FRN') <> nil) then
    aInsumo.FlagFrn   := Boolean(SqlAux.FieldByName('FLAG_FRN').AsInteger);
end;

function  TdmSysSrv.GetTypeCompositions: TStrings;
var
  aService: TServiceOrderItem;
  aDscAnt : string;
  aInsumo : TInsumo;
begin
  Result := TStringList.Create;
  aDscAnt := '';
  with dmSysSrv do
  begin
    if (TipoCompo.Active) then TipoCompo.Close;
    TipoCompo.SQL.Clear;
    TipoCompo.SQL.Add(SqlServices);
    TipoCompo.Open;
    try
      if (not TipoCompo.IsEmpty) then
      begin
        TipoCompo.First;
        aService := nil;
        Result.AddObject('<Nenhum>', nil);
        while not TipoCompo.Eof do
        begin
          if (TipoCompo.FindField('R_FLAG_TINS').AsInteger = -1) then
          begin
            aService                  := TServiceOrderItem.Create(nil);
            aService.PkProduct        := TipoCompo.FindField('R_PK_PRODUTOS').AsInteger;
            aService.CodRef           := TipoCompo.FindField('R_COD_REF').AsString;
            aService.DscTComp         := TipoCompo.FindField('R_DSC_PROD').AsString;
            aService.FkClassification := TipoCompo.FindField('R_FK_CLASSIFICACAO').AsInteger;
            aService.FlagTQtd         := []; //(fqQtd, fqComp, fqLarg, fqAlt);
            if TipoCompo.FindField('R_FLAG_QTD').AsInteger = 1 then
              aService.FlagTQtd       := aService.FlagTQtd + [fqQtd];
            if TipoCompo.FindField('R_FLAG_COMP').AsInteger = 1 then
              aService.FlagTQtd       := aService.FlagTQtd + [fqComp];
            if TipoCompo.FindField('R_FLAG_LARG').AsInteger = 1 then
              aService.FlagTQtd       := aService.FlagTQtd + [fqLarg];
            if TipoCompo.FindField('R_FLAG_ALT').AsInteger = 1 then
              aService.FlagTQtd       := aService.FlagTQtd + [fqAlt];
            aService.VlrUnit          := TipoCompo.FindField('R_VLR_UNIT').AsFloat;
            if (aService.VlrUnit = 0) then
              aService.FlagCalcVlrIns := True
            else
              aService.FlagCalcVlrIns := False;
            aService.Index := Result.AddObject(aService.DscTComp, aService);
          end;
          if (TipoCompo.FindField('R_FLAG_TINS').AsInteger in [0, 1]) then
          begin
            if not Assigned(aService.FkInsumos) then
              aService.FkInsumos := TInsumos.Create(aService);
            aInsumo              := aService.FkInsumos.Add;
            aInsumo.DscIns       := TipoCompo.FindField('R_DSC_PROD').AsString;
            aInsumo.CodIns       := TipoCompo.FindField('R_COD_REF').AsString;
            aInsumo.FlagDef      := Boolean(TipoCompo.FindField('R_FLAG_DEF').AsInteger);
            case TipoCompo.FindField('R_FLAG_TINS').AsInteger of
              0: aInsumo.FlagTIns := tiService;
              1: aInsumo.FlagTIns := tiPurchase;
            end;
            aInsumo.CfcConv      := TipoCompo.FindField('R_QTD_INS').AsFloat;
            aInsumo.AltIns       := TipoCompo.FindField('R_MED_DEF').AsFloat;
            aInsumo.CompIns      := TipoCompo.FindField('R_MED_DEF').AsFloat;
            aInsumo.LargIns      := TipoCompo.FindField('R_MED_DEF').AsFloat;
            if aInsumo.CfcConv <> 0 then
              aInsumo.VlrUnit    := TipoCompo.FindField('R_VLR_UNIT').AsFloat * aInsumo.CfcConv
            else
              aInsumo.VlrUnit    := TipoCompo.FindField('R_VLR_UNIT').AsFloat;
            aInsumo.FlagTQtd     := []; //(fqQtd, fqComp, fqLarg, fqAlt);
            if TipoCompo.FindField('R_FLAG_QTD').AsInteger = 1 then
              aInsumo.FlagTQtd   := aInsumo.FlagTQtd + [fqQtd];
            if TipoCompo.FindField('R_FLAG_COMP').AsInteger = 1 then
              aInsumo.FlagTQtd   := aInsumo.FlagTQtd + [fqComp];
            if TipoCompo.FindField('R_FLAG_LARG').AsInteger = 1 then
              aInsumo.FlagTQtd   := aInsumo.FlagTQtd + [fqLarg];
            if TipoCompo.FindField('R_FLAG_ALT').AsInteger = 1 then
              aInsumo.FlagTQtd   := aInsumo.FlagTQtd + [fqAlt];
            aInsumo.SeqIns       := TipoCompo.FindField('R_SEQ_INS').AsInteger;
            aInsumo.FkProduct    := TipoCompo.FindField('R_FK_INSUMOS').AsInteger;
          end;
          TipoCompo.Next;
        end;
      end;
    finally
      if (TipoCompo.Active) then TipoCompo.Close;
    end;
  end;
end;

function  TdmSysSrv.GetClassifications(AFlagES: Integer): TStrings;
var
  aClass: TClassification;
begin
  Result := TStringList.Create;
  with dmSysSrv do
  begin
    if (Classificacoes.Active) then Classificacoes.Close;
    Classificacoes.SQL.Clear;
    Classificacoes.SQL.Add(SqlClassificaCRDB);
    if Classificacoes.Params.FindParam('FlagTCta') <> nil then
      Classificacoes.Params.FindParam('FlagTCta').AsInteger := AFlagES;
    Classificacoes.Open;
    try
      if (not Classificacoes.IsEmpty) then
      begin
        Classificacoes.First;
        Result.AddObject('<Nenhum>', nil);
        while not Classificacoes.Eof do
        begin
          aClass            := TClassification.Create;
          aClass.Pk         := Classificacoes.FindField('R_PK_CLASSIFICACAO').AsInteger;
          aClass.DscClass   := Classificacoes.FindField('R_DSC_CTA').AsString;
          aClass.MaskCta    := Classificacoes.FindField('R_CLAS_CTA').AsString;
          aClass.FlagAnlSnt := Boolean(Classificacoes.FindField('R_FLAG_CTAT').AsInteger);
          aClass.NivCta     := Classificacoes.FindField('R_NIV_CTA').AsInteger;
          aClass.cbIndex    := Result.AddObject(
            InsereSpc(aClass.DscClass, 50) + ' | ' + aClass.MaskCta, aClass);
          Classificacoes.Next;
        end;
      end;
    finally
      if (Classificacoes.Active) then Classificacoes.Close;
    end;
  end;
end;

function  TdmSysSrv.GetInsumos(AType: Integer): TStrings;
var
  aInsumo: TInsumo;
begin
  Result := TStringList.Create;
  with dmSysSrv do
  begin
    if (Insumos.Active) then Insumos.Close;
    Insumos.SQL.Clear;
    case AType of
      0: Insumos.SQL.Add(SqlGetMaterial);
      1: Insumos.SQL.Add(SqlGetServices);
    end;
    if Insumos.SQL.Text = '' then exit;
    if (Insumos.Params.FindParam('FlagAtv') <> nil) then
       Insumos.ParamByName('FlagAtv').AsInteger   := 1;
    if (Insumos.Params.FindParam('FlagTCode') <> nil) then
       Insumos.ParamByName('FlagTCode').AsInteger := 0;
    if (Insumos.Params.FindParam('FlagAtivo') <> nil) then
       Insumos.ParamByName('FlagAtivo').AsInteger := 1;
    Insumos.Open;
    try
      if (not Insumos.IsEmpty) then
      begin
        Insumos.First;
        Result.AddObject('<Nenhum>', nil);
        while not Insumos.Eof do
        begin
          aInsumo           := TInsumo.Create(nil);
          aInsumo.FkProduct := Insumos.FindField('PK_PRODUTOS').AsInteger;
          aInsumo.DscIns    := Insumos.FindField('DSC_PROD').AsString;
          aInsumo.CodIns    := Insumos.FindField('COD_REF').AsString;
          aInsumo.CfcConv   := Insumos.FindField('QTD_UNI').AsFloat;
          if aInsumo.CfcConv <> 0 then
            aInsumo.VlrUnit   := Insumos.FindField('VLR_UNIT').AsFloat * aInsumo.CfcConv;
          aInsumo.QtdIns    := 0.0;
          aInsumo.FlagTQtd  := [];
          if Insumos.FindField('FLAG_QTD').AsInteger = 1 then
            aInsumo.FlagTQtd   := aInsumo.FlagTQtd + [fqQtd];
          if Insumos.FindField('FLAG_COMP').AsInteger = 1 then
            aInsumo.FlagTQtd   := aInsumo.FlagTQtd + [fqComp];
          if Insumos.FindField('FLAG_LARG').AsInteger = 1 then
            aInsumo.FlagTQtd   := aInsumo.FlagTQtd + [fqLarg];
          if Insumos.FindField('FLAG_ALT').AsInteger = 1 then
            aInsumo.FlagTQtd   := aInsumo.FlagTQtd + [fqAlt];
          aInsumo.FlagDef   := False;
          case AType of
            0: aInsumo.FlagTIns := tiService;
            1: aInsumo.FlagTIns := tiPurchase;
          end;
          aInsumo.SeqIns    := 0;
          aInsumo.Index     := Result.AddObject(aInsumo.DscIns, aInsumo);
          Insumos.Next;
        end;
      end;
    finally
      if (Insumos.Active) then Insumos.Close;
    end;
  end;
end;

procedure TdmSysSrv.SaveInstallments(AOS: TServiceOrder);
var
  i: Integer;
  aStt: Integer;
begin
  if (AOS.FkPayment.Installments.Count = 0) then
    raise Exception.Create('Erro ao gerar previsão de caixa');
  if qrFinance.Active then qrFinance.Close;
  qrFinance.SQL.Clear;
  qrFinance.SQL.Add('select FLAG_LAN_PARC from PARAMETRO_GLOBAIS');
  Dados.StartTransaction(qrFinance);
  try
  // Save Service Order into Finance System
    if not qrFinance.Active then qrFinance.Open;
    FScrollKey.FlagLanParc := qrFinance.FieldByName('FLAG_LAN_PARC').AsInteger;
    if qrFinance.Active then qrFinance.Close;
    qrFinance.SQL.Clear;
    qrFinance.SQL.Add(SqlInsPrevFinance);
    for i := 0 to AOS.FkPayment.Installments.Count - 1 do
    begin
      qrFinance.ParamByName('FkEmpresas').AsInteger       := AOS.FkEmpresas.PkCompany;;
      qrFinance.ParamByName('PkOrdensServicos').AsInteger := AOS.PkOS;
      qrFinance.ParamByName('FkTipoOrdensServicos').AsInteger := AOS.FkTypeServiceOrder.PkTipoOrdensServicos;
      qrFinance.ParamByName('DtaVenc').AsDate    := AOS.FkPayment.Installments.Items[i].DtaVenc;
      qrFinance.ParamByName('VlrLan').AsFloat    := AOS.FkPayment.Installments.Items[i].VlrParc;
      qrFinance.ParamByName('NumParc').AsInteger := i + 1;
      qrFinance.ParamByName('TotParc').AsInteger := AOS.FkPayment.Installments.Count;
      if FScrollKey.FlagLanParc = 0 then
        qrFinance.ParamByName('QtdParc').AsInteger := 0
      else
        qrFinance.ParamByName('QtdParc').AsInteger := AOS.FkPayment.Installments.Count;
      try
        if not qrFinance.Active then qrFinance.Open;
        aStt := qrFinance.FieldByName('R_STATUS').AsInteger;
        if (aStt < 0) then
          raise Exception.CreateFmt('Geração da Previsão: Retorno do status %d', [aStt]);
      except on E:Exception do
        raise Exception.Create(qrFinance.SQL.Text + NL + E.Message);
      end;
      if qrFinance.Active then qrFinance.Close;
    end;
    Dados.CommitTransaction(qrFinance);
  except on E:Exception do
    begin
      if qrFinance.Active then qrFinance.Close;
      Dados.RollbackTransaction(qrFinance);
      raise Exception.Create('Error: Can''t save data into Database' + NL + E.Message);
    end;
  end;
end;

initialization
  Application.CreateForm(TdmSysSrv, dmSysSrv);
finalization
  if Assigned(dmSysSrv) then dmSysSrv.Free;
  dmSysSrv := nil;
end.
