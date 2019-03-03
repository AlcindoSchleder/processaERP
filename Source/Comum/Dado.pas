unit Dado;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 07/11/2006 - DD/MM/YYYY                                    *}
{* Modified : 07/11/2006 - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
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

uses SysUtils, Classes, SqlExpr, DB, FMTBcd, Encryp, ProcType, TextData, GridRow,
  DBXpress, JvComponent, JvBalloonHint, PrcDBInfo, PrcIBFBInfo,
  {$IFNDEF LINUX}
    Windows, ImgList, Forms, Controls, Dialogs, JvComponentBase
  {$ELSE}
    QT, QImgList, QForms, QControls, QDialogs
  {$ENDIF};

const
  MIN_TRANSACTIONS = 2;
  MAX_TRANSACTIONS = High(Integer);

type
  TSuportedDataBases = (sdInterbase, sdMSSQL, sdMySQL, sdOracle, sdPostgreSQL,
    sdUIBFireBird102, sdUIBFireBird103, sdUIBFireBird15, sdUIBInterbase6,
    sdUIBInterbase65, sdUIBInterbase7, sdUIBInterbase71, sdUIBYaffil, sdNone);

  THintIcons = (hiCustom, hiNone, hiApplication, hiError, hiInformation,
                hiQuestion, hiWarning);

  TUserAction  = (uaAdd, uaModify, uaDelete);

  TInfoDBClass = class of TPrcDBInfo;

  TParamsForm = record
    DscPrg  : string;
    PkReport: integer;
  end;

  TFormCallBack = procedure (AForm: TForm; const AParams: TParamsForm) of object;

  TDados = class(TDataModule)
    Text: TTextDataSet;
    TextLine: TStringField;
    Image32: TImageList;
    Conexao: TSQLConnection;
    qrEmpresa: TSQLQuery;
    qrSQLAux: TSQLQuery;
    qrAutorizar: TSQLQuery;
    qrParametros: TSQLQuery;
    qrDicAux: TSQLQuery;
    qrDicValues: TSQLQuery;
    qrMensagens: TSQLQuery;
    qrAcessos: TSQLQuery;
    qrProgramas: TSQLQuery;
    qrVersoes: TSQLQuery;
    qrReport: TSQLQuery;
    dbMonitor: TSQLMonitor;
    bhHint: TJvBalloonHint;
    Image16: TImageList;
    dsLog: TSQLQuery;
    qrTr: TSQLQuery;
    procedure DadosDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure qrParametrosBeforeOpen(DataSet: TDataSet);
    procedure qrReportAfterOpen(DataSet: TDataSet);
    procedure ConexaoAfterConnect(Sender: TObject);
    procedure ConexaoBeforeDisconnect(Sender: TObject);
    procedure qrEmpresaBeforeOpen(DataSet: TDataSet);
    procedure dbMonitorTrace(Sender: TObject; CBInfo: pSQLTRACEDesc;
      var LogTrace: Boolean);
    procedure dbMonitorLogTrace(Sender: TObject; CBInfo: pSQLTRACEDesc);
  private
    { Private declarations }
    FTr     : TTransactionDesc;
    FDBInfo : TPrcDBInfo;
    FMultiCompany: Boolean;
    FDefaultClient: Integer;
    FDsctMax: Double;
    FMrglPdr: Double;
    FDaysAtr: Integer;
    FFlagLanParc: Integer;
    FCompanyCity: Integer;
    FQtdDaysTol: Integer;
    FNomFan: string;
    FCnpjEmpr: string;
    FDecimalPlacesQtd: Integer;
    procedure DefFieldsReport;
    function  LocalizaOperador(const Nome, Senha: string): Integer;
    function  GetCurrentDataBase: TSuportedDataBases;
    function  GetDBInfo: TPrcDBInfo;
    function  GetCurrMask: string;
    function  GetDecimalPlaces: Integer;
    function  GetNumMask: string;
    function  GetQtdMask: string;
    function  GetNameCompany: string;
    function  GetPkCompany: Integer;
    function  GetCompanyCountry: Integer;
    function  GetCompanyState: string;
  public
    { Public declarations }
    FClassDBInfo : string;
    FSysDBAUser  : string;
    FSysDBAPasswd: string;
    Cod_Auto     : Integer;
    DataValidade : TDateTime;
    Historicos   : TSystemLog;
    Parametros   : TSysOptions;
    function  DisplayMessage(const AMsg: string; AIcons: THintIcons = hiInformation;
                Buttons: TMsgDlgButtons = [mbOk]): Integer;
    procedure DisplayHint(Control: TControl; const AMsg: string;
                AIcon: THintIcons = hiInformation; AHeader: string = '';
                ATimeOut: Cardinal = 5000); overload;
    procedure DisplayHint(Control: TCustomForm; APos: TPoint; const AMsg: string;
                AIcon: THintIcons = hiInformation; AHeader: string = '';
                ATimeOut: Cardinal = 5000); overload;
    function  PegaAutoriza(const Mensagem: string): Integer;
    function  LocalizaAcessos(const Form: string): Boolean;
    function  FindDicValues: Boolean;
    function  FindProgramTitle(FileName: string): string;
    function  StartTransaction(ADataSet: TDataSet = nil): Integer;
    procedure CommitTransaction(ADataSet: TDataSet = nil; Id: Integer = 0);
    procedure RollbackTransaction(ADataSet: TDataSet = nil; Id: Integer = 0);
    procedure UpdateUser(AProced: string; AType: Smallint); overload;
    function  SelecionaParamEmpr: Boolean;
    function  FindDictionary(const FileName: string): Boolean;
    function  FindDictionaryField(const FileName, FieldName: string): Boolean;
    function  ChangeCompany: Boolean;
    procedure GravaHistoricos;
    function  GetStringMessage(const Lang: string; const CnstNameVar: string;
                const Default: string = ''):  string;
    function  GetAllStringsMessage(const Lang: string;
                const Module, Rotine, Progr: Integer;
                var VarArray: array of string;
                const NameVars: array of string): Boolean;
    function  GetFieldsSchema(ATableName: string): TStrings;
    procedure ShowMonitor;
    procedure GetDBAUser;
    function  GetIdxMask(ADecimalPlaces: Word = 4): string;
    function  GetPercentMask(ADecimalPlaces: Word = 4): string;
    function  UpdateUser(const Action: TUserAction; const AUserName, APassword,
                AFirstName, AMiddleName, ALastName, ARole: string): Boolean; overload;
    function  GetPk(const ASql: string; AParamData: TDataRow): TDataRow;
    procedure ShowFormFromLib(ALib, AMainForm: string; ACallBack: TFormCallBack);
    property  DecimalPlaces   : Integer    read GetDecimalPlaces;
    property  DecimalPlacesQtd: Integer    read FDecimalPlacesQtd;
    property  PkCompany       : Integer    read GetPkCompany;
    property  CompanyCountry  : Integer    read GetCompanyCountry;
    property  CompanyState    : string     read GetCompanyState;
    property  ClassDBInfo     : string     read FClassDBInfo;
    property  CurrMask        : string     read GetCurrMask;
    property  NameCompany     : string     read GetNameCompany;
    property  NumMask         : string     read GetNumMask;
    property  QtdMask         : string     read GetQtdMask;
    property  PrcDBInfo       : TPrcDbInfo read GetDBInfo;
    property  MultiCompany    : Boolean    read FMultiCompany;
    property  DefaultClient   : Integer    read FDefaultClient;
    property  DsctMax         : Double     read FDsctMax;
    property  MrglPdr         : Double     read FMrglPdr;
    property  CnpjEmpr        : string     read FCnpjEmpr;
    property  NomFan          : string     read FNomFan;
    property  CompanyCity     : Integer    read FCompanyCity;
    property  DaysAtr         : Integer    read FDaysAtr;
    property  QtdDaysTol      : Integer    read FQtdDaysTol;
    property  FlagLanParc     : Integer    read FFlagLanParc;
  end;

var
  Dados: TDados;
const
  DECIMAL_PLACES_MASK: array [0..4] of string =
    ('0', '.0', '.00', '.000', '.0000');

  INT_MASK = ',0';

function  DeleteDataSetParams(AQuery: TSQLQuery; AParamName: string): Boolean;

implementation

uses Funcoes, Autor, FuncoesDB, CmmConst, SqlComm, uMonitor, Math;

{$R *.DFM}

const
  SqlDeleteTransaction = 'delete from DATABASE_TRANSACTIONS ' + NL +
                         ' where PK_DATABASE_TRANSACTIONS = :Pk';

  S_SUPORTED_DATABASES: array [TSuportedDataBases] of string = (
    'Interbase', 'MSSQL', 'MySQL', 'Oracle', 'PostgreSQL', 'UIB FireBird102',
    'UIB FireBird103', 'UIB FireBird15', 'UIB Interbase6', 'UIB Interbase65',
    'UIB Interbase7', 'UIB Interbase71', 'UIB Yaffil', '');

  S_CLASS_INFO        : array [TSuportedDataBases] of string = (
    'TPrcIBInfo', 'TPrcMSSQLInfo', 'TPrcMySQLInfo', 'TPrcOracleInfo',
    'TPrcPostgreSQLInfo', 'TPrcIBInfo', 'TPrcIBInfo', 'TPrcIBInfo', 'TPrcIBInfo',
    'TPrcIBInfo', 'TPrcIBInfo', 'TPrcIBInfo', 'TPrcYaffilInfo', '');

function  DeleteDataSetParams(AQuery: TSQLQuery; AParamName: string): Boolean;
var
  Ix: Integer;
begin
  Result := False;
  if (AQuery = nil) or (AParamName = '') or
     (AQuery.Params.FindParam(AParamName) = nil) then
    exit;
  AQuery.ParamByName(AParamName).Clear;
  Ix := AQuery.ParamByName(AParamName).Index;
  if Ix > -1 then AQuery.Params.Delete(Ix);
  Result := True;
end;

procedure TDados.DataModuleCreate(Sender: TObject);
begin
  FDBInfo       := nil;
  FMultiCompany := False;
  qrEmpresa.SQL.Clear;
  qrEmpresa.SQL.Add(SqlEmpresa);
  if Conexao.Connected then Conexao.Close;
end;

procedure TDados.DadosDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (TDataSet(Components[i]).Active) then
      TDataSet(Components[i]).Close;
  if DBMonitor.Active  then DBMonitor.Active := False;
  if Assigned(frmMonitor) then
  begin
    frmMonitor.Close;
    frmMonitor.Free;
  end;
  frmMonitor := nil;
  if Assigned(FDBInfo) then
    FDBInfo.Free;
  FDBInfo := nil;
  if Conexao.Connected then Conexao.Close;
end;

function  TDados.DisplayMessage(const AMsg: string; AIcons: THintIcons = hiInformation;
  Buttons: TMsgDlgButtons = [mbOk]): Integer;
const
  ICONS_MAP: array [hiCustom..hiWarning] of LongInt =
    (MB_USERICON, MB_ICONASTERISK, MB_ICONHAND, MB_ICONERROR,
     MB_ICONINFORMATION, MB_ICONQUESTION, MB_ICONWARNING);
var
  aFlagBtns: LongInt;
begin
   if Buttons = mbYesNoCancel then
     aFlagBtns := MB_YESNOCANCEL
   else
     if Buttons = mbOKCancel then
       aFlagBtns := MB_OKCANCEL
   else
     if Buttons = mbAbortRetryIgnore then
       aFlagBtns := MB_ABORTRETRYIGNORE
   else
     if Buttons = [mbOK] then
       aFlagBtns := MB_OK
     else
       if Buttons = [mbNo, mbYes] then
         aFlagBtns := MB_YESNO
       else
         aFlagBtns := MB_OK;
   Result := Application.MessageBox(PAnsiChar(AMsg), PAnsiChar(Application.Title),
               ICONS_MAP[AIcons] + aFlagBtns)
end;

procedure TDados.DisplayHint(Control: TControl; const AMsg: string;
                AIcon: THintIcons = hiInformation; AHeader: string = '';
                ATimeOut: Cardinal = 5000);
begin
  if AHeader = '' then
    AHeader := Application.Title;
  bhHint.ActivateHint(Control, AMsg, TJvIconKind(AIcon), AHeader, ATimeOut);
end;

procedure TDados.DisplayHint(Control: TCustomForm; APos: TPoint; const AMsg: string;
            AIcon: THintIcons = hiInformation; AHeader: string = '';
            ATimeOut: Cardinal = 5000);
begin
  if AHeader = '' then
    AHeader := Application.Title;
  bhHint.ActivateHintPos(Control, APos, AHeader, AMsg, ATimeOut, TJvIconKind(AIcon));
end;

function  TDados.LocalizaOperador(const Nome, Senha: string): Integer;
var
  Cripto: TCrypto;
begin
  Result := 0;
  if qrAutorizar.Active then qrAutorizar.Close;
  qrAutorizar.SQL.Clear;
  qrAutorizar.SQL.Add(SqlAutorizar);
  StartTransaction(qrAutorizar);
  if qrAutorizar.Params.FindParam('PkOperadores') <> nil then
    qrAutorizar.Params.FindParam('PkOperadores').AsString := Nome;
  qrAutorizar.Open;
  Cripto            := TCrypto.Create(Self);
  try
    Cripto.Input      := Senha;
    Cripto.Action     := atCrypto;
    Cripto.Key        := Senha;
    Cripto.TypeCipher := tcInterbase;
    Cripto.Execute;
    if (qrAutorizar.FieldByName('FK_CADASTROS').AsInteger <> 0) and
       (qrAutorizar.FieldByName('FLAG_LSEN').AsInteger = 1) and
       (qrAutorizar.FieldByName('SEN_NET').AsString = Cripto.OutPut) then
      Result := qrAutorizar.FieldByName('FK_CADASTROS').AsInteger;
  finally
    Cripto.Free;
    if qrAutorizar.Active then qrAutorizar.Close;
    CommitTransaction(qrAutorizar);
  end;
end;

function TDados.PegaAutoriza(const Mensagem: string): Integer;
var
  Oper, Senha: string;
begin
  Oper := '';
  Result := 0;
  with Dados do
  begin
    if MessageDlg(Mensagem  + #13 + 'Você deseja Continuar?', mtError, [mbYes, mbNo], 0) = mrYes then
    begin
      Application.CreateForm(TfrmAuthor, frmAuthor);
      try
        frmAuthor.UserMsg := Mensagem;
        if frmAuthor.ShowModal = MrOk then
        begin
          Oper := frmAuthor.UserName;
          Senha := frmAuthor.UserPasswd;
        end;
      finally
        frmAuthor.Free;
      end;
      if Oper <> '' then
        Result := LocalizaOperador(Oper, Senha);
    end;
  end;
end;

function  TDados.LocalizaAcessos(const Form: string): Boolean;
var
  StrAux: string;
begin
  if qrAcessos.Active then qrAcessos.Close;
  qrAcessos.SQL.Clear;
  qrAcessos.SQL.Add(SqlFindAccess);
  StartTransaction(qrAcessos);
  try
    qrAcessos.ParamByName('Form').AsString     := Form;
    StrAux                                     := Parametros.soUser;
    qrAcessos.ParamByName('Operador').AsString := Copy(StrAux, 1, 10);
    if not qrAcessos.Active then qrAcessos.Open;
    Result := not qrAcessos.IsEmpty;
    if Result then
      Result := qrAcessos.FindField('QTD').AsInteger > 0;
  finally
    if qrAcessos.Active then qrAcessos.Close;
    CommitTransaction(qrAcessos);
  end;
end;

function  TDados.ChangeCompany: Boolean;
var
  SaveComp: Integer;
begin
  SaveComp := Parametros.soActiveCompany;
  if Parametros.soNewCompany > 0 then
    Parametros.soActiveCompany := Parametros.soNewCompany;
  Result := SelecionaParamEmpr;
  if Result then
    Parametros.soNewCompany := 0
  else
  begin
    Parametros.soActiveCompany := SaveComp;
    SelecionaParamEmpr;
  end;
end;

procedure TDados.GravaHistoricos;
const
  SQL_INSERT_HISTORIC = 'execute procedure STP_INSERT_HISTORIC(:P_NOM_FORM, ' +
                           ':P_NOM_ARQ, :P_DSC_OPE, :P_COD_OPE)';

begin
  if dsLog.Active then dsLog.Close;
  dsLog.SQL.Clear;
  dsLog.SQL.Add(SQL_INSERT_HISTORIC);
  StartTransaction(dsLog);
  try
    dsLog.ParamByName('P_NOM_FORM').AsString  := Copy(Historicos.shForm   , 1, 31);
    dsLog.ParamByName('P_DSC_OPE').AsString   := Copy(Historicos.shOperDescr, 1, 30);
    dsLog.ParamByName('P_COD_OPE').AsString   := Copy(Historicos.shOperCode  , 1, 3);
    dsLog.ParamByName('P_NOM_ARQ').AsString   := Copy(Historicos.shTableName   , 1, 31);
    dsLog.ExecSQL;
    if dsLog.Active then dsLog.Close;
    CommitTransaction(dsLog);
  except on E:Exception do
    begin
      if dsLog.Active then dsLog.Close;
      RollbackTransaction(dsLog);
      raise Exception.Create(E.Message);
    end;
  end;
end;

function  TDados.SelecionaParamEmpr: Boolean;
begin
  if qrParametros.Active then qrParametros.Close;
  qrParametros.SQL.Clear;
  qrParametros.SQL.Add(SqlParamEmp);
  StartTransaction(qrParametros);
  try
    if not qrParametros.Active then qrParametros.Open;
    Result := not qrParametros.IsEmpty;
    if Result then
    begin
      ProgramVersion;
      Parametros.soActiveCompany  := qrParametros.FieldByName('FK_EMPRESAS').AsInteger;
      Parametros.soCompanyName    := qrParametros.FieldByName('RAZ_SOC').AsString;
      Parametros.soCompanyCountry := qrParametros.FieldByName('FK_PAISES').AsInteger;
      Parametros.soCompanyState   := qrParametros.FieldByName('FK_ESTADOS').AsString;
      Parametros.soDecimalPlaces  := qrParametros.FieldByName('NUM_CAS_DEC').AsInteger;
      FDecimalPlacesQtd           := qrParametros.FieldByName('NUM_CAS_DEC_QTD').AsInteger;
      FMultiCompany               := Boolean(qrParametros.FieldByName('FLAG_MULTI').AsInteger);
      FDefaultClient              := qrParametros.FieldByName('FK_CLIENTES').AsInteger;
      FDsctMax                    := qrParametros.FieldByName('DSCT_MAX').AsFloat;
      FMrglPdr                    := qrParametros.FieldByName('MRGL_PDR').AsFloat;
      FCnpjEmpr                   := qrParametros.FieldByName('CNPJ_EMP').AsString;
      FNomFan                     := qrParametros.FieldByName('NOM_FAN').AsString;
      FCompanyCity                := qrParametros.FieldByName('FK_MUNICIPIOS').AsInteger;
      FDaysAtr                    := qrParametros.FieldByName('DIAS_ATR').AsInteger;
      FQtdDaysTol                 := qrParametros.FieldByName('QTD_DTOL').AsInteger;
      FFlagLanParc                := qrParametros.FieldByName('FLAG_LAN_PARC').AsInteger;
    end;
  finally
    if qrParametros.Active then qrParametros.Close;
    CommitTransaction(qrParametros);
  end;
end;

function  TDados.GetCurrentDataBase: TSuportedDataBases;
var
  i: TSuportedDataBases;
begin
  Result := sdNone;
  for i := Low(TSuportedDataBases) to High(TSuportedDataBases) do
    if (S_SUPORTED_DATABASES[i] = Conexao.DriverName) then
    begin
      Result := i;
    end;
end;

function  TDados.FindDictionary(const FileName: string): Boolean;
begin
  if qrDicAux.Active then qrDicAux.Close;
  qrDicAux.SQL.Clear;
  qrDicAux.SQL.Add(SqlDictionary);
  qrDicAux.ParamByName('Linguagem').AsString := '';
  qrDicAux.ParamByName('NameFile').AsString  := FileName;
  if not qrDicAux.Active then qrDicAux.Open;
  Result := not qrDicAux.IsEmpty;
end;

function  TDados.FindDictionaryField(const FileName, FieldName: string): Boolean;
begin
  if qrDicAux.Active then qrDicAux.Close;
  qrDicAux.SQL.Clear;
  qrDicAux.SQL.Add(SqlDicField);
  qrDicAux.ParamByName('Linguagem').AsString  := '';
  qrDicAux.ParamByName('NameFile').AsString   := FileName;
  qrDicAux.ParamByName('NameField').AsString  := FieldName;
  if not qrDicAux.Active then qrDicAux.Open;
  Result := not qrDicAux.IsEmpty;
end;

function  TDados.GetStringMessage(const Lang: string; const CnstNameVar: string;
  const Default: string = ''):  string;
const
  FileName = 'MsgFail.txt';
begin
  Result := Default;
  if Length(CnstNameVar) <= 20 then
  begin
    if qrMensagens.Active then qrMensagens.Close;
    qrMensagens.SQL.Clear;
    qrMensagens.SQL.Add(SqlSelCnstMsg);
    StartTransaction(qrMensagens);
    try
      qrMensagens.ParamByName('Linguagem').AsString  := Lang;
      qrMensagens.ParamByName('NomCnst').AsString := CnstNameVar;
      if not qrMensagens.Active then qrMensagens.Open;
      if (qrMensagens.FieldByName('DSC_CNST').AsString <> '') then
        Result := qrMensagens.FieldByName('DSC_CNST').AsString
      else
      begin
        Text.FileName := ExtractFilePath(Application.ExeName) + FileName;
        if not Text.Active then Text.Open;
        Text.Insert;
        TextLine.Value := DateToStr(Date) + '--> '+ Lang + ' - ' +
                            CnstNameVar + ' - ' + Default;
        Text.Post;
        if Text.Active then Text.Close;
      end;
    finally
      if qrMensagens.Active then qrMensagens.Close;
      CommitTransaction(qrMensagens);
    end;
  end;
end;

function  TDados.GetAllStringsMessage(const Lang: string;
  const Module, Rotine, Progr: Integer; var VarArray: array of string;
  const NameVars: array of string): Boolean;
var
  i: Integer;
begin
  Result := True;
  if qrMensagens.Active then qrMensagens.Close;
  qrMensagens.SQL.Clear;
  qrMensagens.SQL.Add(SqlSelCnstMsg);
  for i := 0 to High(NameVars) do
  begin
    qrMensagens.ParamByName('Linguagem').AsString := Lang;
    qrMensagens.ParamByName('NomCnst').AsString   := NameVars[i];
    if not qrMensagens.Active then qrMensagens.Open;
    if Result then
      Result := not qrMensagens.IsEmpty;
    if (qrMensagens.FieldByName('DSC_CNST').AsString <> '') then
      VarArray[i] := qrMensagens.FieldByName('DSC_CNST').AsString;
    if qrMensagens.Active then qrMensagens.Close;
  end;
end;

procedure TDados.qrParametrosBeforeOpen(DataSet: TDataSet);
begin
  if (qrParametros.Params.Count > 0) and
     (qrParametros.Params.FindParam('Empresa') <> nil) then
    qrParametros.Params.ParamByName('Empresa').AsInteger := Parametros.soNewCompany;
end;

procedure TDados.qrReportAfterOpen(DataSet: TDataSet);
begin
  if qrReport.FieldDefList = nil then
    DefFieldsReport;
end;

procedure TDados.DefFieldsReport;
var
  i        : Integer;
  ListField: TStrings;
begin
  ListField := TStringList.Create;
  try
    with Dados do
    begin
      qrReport.GetFieldNames(ListField);
      for i := 0 to ListField.Count - 1 do
        with qrReport.FieldDefs.AddFieldDef do
        begin
          Name         := 'qrReport' + ListField[i];
          DataType     := qrReport.FieldByName(ListField[i]).DataType;
          Size         := qrReport.FieldByName(ListField[i]).Size;
        end;
    end;
  finally
    ListField.Free;
  end;
end;

procedure TDados.ConexaoAfterConnect(Sender: TObject);
begin
  UpdateUser('STP_LOG_USER', 1);
  Dados.Parametros.soTitle := Dados.GetStringMessage('pt_br', 'sProcCaption') + ProgramVersion;
  Application.Title := Dados.Parametros.soTitle;
  FClassDBInfo := S_CLASS_INFO[GetCurrentDataBase];
end;

procedure TDados.ConexaoBeforeDisconnect(Sender: TObject);
begin
  UpdateUser('STP_LOG_USER', 0);
end;

procedure TDados.qrEmpresaBeforeOpen(DataSet: TDataSet);
begin
  if (qrEmpresa.Params.Count > 0) and
     (qrEmpresa.Params.FindParam('EmpresaAtiva') <> nil) then
    if Parametros.soActiveCompany > 0 then
      qrEmpresa.Params.FindParam('EmpresaAtiva').AsInteger := Parametros.soActiveCompany
    else
      qrEmpresa.Params.FindParam('EmpresaAtiva').AsInteger := -1;
end;

function TDados.FindDicValues: Boolean;
begin
  if qrDicAux.Active then
  begin
    if qrDicValues.Active then qrDicValues.Close;
    qrDicValues.SQL.Clear;
    qrDicValues.SQL.Add(SqlValorCampos);
    qrDicValues.ParamByName('Linguagem').AsString := '';
    qrDicValues.ParamByName('NameFile').AsString  := qrDicAux.FieldByName('PK_DICIONARIOS__NA').AsString;
    qrDicValues.ParamByName('NameField').AsString := qrDicAux.FieldByName('PK_DICIONARIOS__NC').AsString;
    if not qrDicValues.Active then qrDicValues.Open;
  end;
  Result := not qrDicValues.IsEmpty;
end;

function  TDados.FindProgramTitle(FileName: string): string;
begin
  Result := '';
  if qrProgramas.Active then qrProgramas.Close;
  qrProgramas.SQL.Clear;
  qrProgramas.SQL.Add(SqlDscPrg);
  StartTransaction(qrProgramas);
  try
    qrProgramas.ParamByName('NameForm').AsString := FileName;
    if not qrProgramas.Active then qrProgramas.Open;
    if (not qrProgramas.IsEmpty) and (qrProgramas.FindField('DSC_PRG') <> nil) then
      Result := qrProgramas.FindField('DSC_PRG').AsString;
  finally
    if qrProgramas.Active then qrProgramas.Close;
    CommitTransaction(qrProgramas);
  end;
end;

procedure TDados.UpdateUser(AProced: string; AType: Smallint);
const
  SQL_STP_LOG_USER = 'execute procedure STP_LOG_USER (:P_TYPE_LOG)';
begin
  if (AProced <> 'STP_LOG_USER') then
  begin
    ShowMessage('Not calling ' + AProced);
    exit;
  end;
  if dsLog.Active then dsLog.Close;
  dsLog.SQL.Clear;
  dsLog.SQL.Add(SQL_STP_LOG_USER);
  StartTransaction(dsLog);
  try
    dsLog.Params.ParamByName('P_TYPE_LOG').AsInteger := AType;
    dsLog.ExecSQL;
    if dsLog.Active then dsLog.Close;
    CommitTransaction(dsLog);
  except on E:Exception do
    begin
      RollbackTransaction(dsLog);
      raise Exception.Create('Dados.UpdateUser: ' + E.Message);
    end;
  end;
end;

function  TDados.GetFieldsSchema(ATableName: string): TStrings;
const
  DB_FIELD_TYPES: array [0..12] of string =
    ('VARCHAR', 'NUMERIC', 'DECIMAL', 'INTEGER', 'SMALLINT', 'FLOAT',
     'DOUBLE PRECISION', 'DATE', 'TIME', 'TIMESTAMP', 'BLOB',
     'CHAR', 'CHARACTER');

  DELPHI_FIELD_TYPES: array [0..12] of TFieldType =
    (ftString, ftFMTBcd, ftFMTBcd, ftInteger, ftSmallint, ftFloat, ftFloat,
     ftDate, ftTime, ftDateTime, ftBlob, ftString, ftString);

  cFIELD_TYPES: array [ftUnknown..ftFMTBcd] of string =
    ('ftNadinha', 'ftString', 'ftSmallint', 'ftInteger', 'ftWord', 'ftBoolean',
     'ftFloat', 'ftCurrency', 'ftBCD', 'ftDate', 'ftTime', 'ftDateTime',
     'ftBytes', 'ftVarBytes', 'ftAutoInc', 'ftBlob', 'ftMemo', 'ftGraphic',
     'ftFmtMemo', 'ftParadoxOle', 'ftDBaseOle', 'ftTypedBinary', 'ftCursor',
     'ftFixedChar', 'ftWideString', 'ftLargeint', 'ftADT', 'ftArray',
     'ftReference', 'ftDataSet', 'ftOraBlob', 'ftOraClob', 'ftVariant',
     'ftInterface', 'ftIDispatch', 'ftGuid', 'ftTimeStamp', 'ftFMTBcd');

  function GetFieldTypeFromDBType(FDBType: string): TFieldType;
  var
    j: Integer;
  begin
    Result := ftUnknown;
    if Pos('(', FDBType) > 0 then
      FDBType := Copy(FDBType, 1, Pos('(', FDBType) - 1);
    for j := 0  to High(DB_FIELD_TYPES) do
      if CompareText(DB_FIELD_TYPES[j], FDBType) = 0 then
      begin
        Result := DELPHI_FIELD_TYPES[j];
        break;
      end;
  end;
begin
  Result := nil;
  if (ATableName = '') then exit;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SetSchemaInfo(stColumns, ATableName, '');
  qrSqlAux.Open;
  try
    if not qrSqlAux.IsEmpty then
    begin
      Result := TStringList.Create;
      while not qrSQLAux.Eof do
      begin
        Result.Add(qrSqlAux.FieldByName('COLUMN_NAME').Text);
        qrSQLAux.Next;
      end;
    end;
  finally
    qrSqlAux.Close;
  end;
end;

procedure TDados.ShowMonitor;
begin
  if (not Assigned(frmMonitor)) then
    Application.CreateForm(TfrmMonitor, frmMonitor);
  if (frmMonitor = nil) then exit;
  frmMonitor.Show;
  DBMonitor.Active := True;
end;

procedure TDados.dbMonitorTrace(Sender: TObject; CBInfo: pSQLTRACEDesc;
  var LogTrace: Boolean);
begin
  LogTrace := Assigned(frmMonitor);
end;

procedure TDados.dbMonitorLogTrace(Sender: TObject; CBInfo: pSQLTRACEDesc);
var
  Msg: string;
begin
  if (not Assigned(frmMonitor)) then exit;
  SetLength(Msg, StrLen(CBInfo.pszTrace));
  Move(CBInfo.pszTrace[0], PChar(Msg)[0], StrLen(CBInfo.pszTrace));
  frmMonitor.vlListMonitor.Strings.Add(DateTimeToStr(Now) + '=' + Msg);
end;

function  TDados.GetDBInfo: TPrcDBInfo;
var
  InfoClass: TPersistentClass;
begin
  if (FClassDBInfo <> '') and (FDBInfo = nil) then
  begin
    InfoClass := GetClass(FClassDBInfo);
    if (InfoClass <> nil) then
      FDBInfo := TInfoDBClass(InfoClass).Create(Conexao, '', FSysDBAUser, FSysDBAPasswd)
    else
      FDBInfo := nil;
  end;
  Result := FDBInfo;
end;

procedure TDados.GetDBAUser;
begin
  if (FSysDBAUser = '') then
  begin
    Application.CreateForm(TfrmAuthor, frmAuthor);
    try
      frmAuthor.frmCaption := 'Nome e Senha do Super Usuário';
      frmAuthor.UserMsg    := 'Nome e Senha do Super Usuário';
      if frmAuthor.ShowModal = MrOk then
      begin
        FSysDBAUser   := frmAuthor.UserName;
        FSysDBAPasswd := frmAuthor.UserPasswd;
      end;
    finally
      frmAuthor.Free;
    end;
  end;
  if Assigned(FDBInfo) then
  begin
    FDBInfo.User     := FSysDBAUser;
    FDBInfo.Password := FSysDBAPasswd;
  end;
end;

function TDados.GetCurrMask: string;
begin
  Result := CurrencyString + INT_MASK + DECIMAL_PLACES_MASK[Parametros.soDecimalPlaces];
  Result := Result + '; - ' + Result;
end;

function TDados.GetDecimalPlaces: Integer;
begin
  Result := Parametros.soDecimalPlaces;
end;

function TDados.GetNumMask: string;
begin
  Result := INT_MASK + DECIMAL_PLACES_MASK[Parametros.soDecimalPlaces];
  Result := Result + '; - ' + Result;
end;

function TDados.GetIdxMask(ADecimalPlaces: Word = 4): string;
begin
  if (ADecimalPlaces > 4) then
    Result := GetNumMask
  else
  begin
    Result := INT_MASK + DECIMAL_PLACES_MASK[ADecimalPlaces];
    Result := Result + '; - ' + Result;
  end;
end;

function TDados.GetPercentMask(ADecimalPlaces: Word = 4): string;
begin
  if (ADecimalPlaces > 4) then
    Result := GetNumMask
  else
  begin
    Result := INT_MASK + DECIMAL_PLACES_MASK[ADecimalPlaces] + ' %';
    Result := Result + '; - ' + Result;
  end;
end;

function TDados.GetNameCompany: string;
begin
  Result := Parametros.soCompanyName;
end;

function TDados.GetPkCompany: Integer;
begin
  Result := Parametros.soActiveCompany;
end;

procedure TDados.CommitTransaction(ADataSet: TDataSet = nil; Id: Integer = 0);
begin
  if (not Conexao.TransactionsSupported) or ((ADataSet = nil) and (Id = 0)) or
     ((ADataSet <> nil) and (ADataSet.Tag = 0) and (Id = 0)) then
    exit;
  if ((ADataSet <> nil) and (ADataSet.Tag > 0)) then
    Id := ADataSet.Tag;
  FTr.IsolationLevel := xilREADCOMMITTED;
  try
    FTr.TransactionID  := Id;
    Conexao.Commit(FTr);
    FTr.TransactionID  := 1;
    with qrTr do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Add(SqlDeleteTransaction);
      Conexao.StartTransaction(FTr);
      try
        ParamByName('Pk').AsInteger := Id;
        ExecSQL;
      finally
        if Active then Close;
        Conexao.Commit(FTr);
      end;
    end;
  finally
    if (ADataSet <> nil) then
      ADataSet.Tag := 0;
  end;
end;

procedure TDados.RollbackTransaction(ADataSet: TDataSet = nil; Id: Integer = 0);
begin
  if (not Conexao.TransactionsSupported) or ((ADataSet = nil) and (Id = 0)) or
     ((ADataSet <> nil) and (ADataSet.Tag = 0) and (Id = 0))  then
    exit;
  if (ADataSet <> nil) and (ADataSet.Tag > 0) then
    Id := ADataSet.Tag;
  FTr.IsolationLevel := xilREADCOMMITTED;
  try
    FTr.TransactionID  := Id;
    Conexao.RollBack(FTr);
    FTr.TransactionID  := 1;
    with qrTr do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Add(SqlDeleteTransaction);
      Conexao.StartTransaction(FTr);
      try
        ParamByName('Pk').AsInteger := Id;
        ExecSQL;
      finally
        if Active then Close;
        Conexao.Commit(FTr);
      end;
    end;
  finally
    if (ADataSet <> nil) then
      ADataSet.Tag := 0;
  end;
end;

function  TDados.StartTransaction(ADataSet: TDataSet = nil): Integer;
var
  ValidTr: Boolean;
const
  SqlTransaction       = 'select * from DATABASE_TRANSACTIONS ' + NL +
                         ' where PK_DATABASE_TRANSACTIONS = :Pk';
  SqlInsertTransaction = 'insert into DATABASE_TRANSACTIONS ' + NL +
                         '  (PK_DATABASE_TRANSACTIONS, DATASET, DTHR_TRNS) ' + NL +
                         'values ' + NL +
                         '  (:Pk, :DataSet, :Date)';
begin
  Result := 0;
  if Conexao.TransactionsSupported then
  begin
    FTr.IsolationLevel := xilREADCOMMITTED;
    ValidTr := False;
    FTr.TransactionID := 1;
    while (not ValidTr) do
    begin
      Result := RandomRange(MIN_TRANSACTIONS, MAX_TRANSACTIONS);
      with qrTr do
      begin
        if Active then Close;
        SQL.Clear;
        SQL.Add(SqlTransaction);
        Conexao.StartTransaction(FTr);
        try
          ParamByName('Pk').AsInteger := Result;
          if not Active then Open;
          ValidTr := (FieldByName('PK_DATABASE_TRANSACTIONS').AsInteger = 0);
        finally
          if Active then Close;
        end;
      end;
    end;
    with qrTr do
    begin
      Sql.Clear;
      SQL.Add(SqlInsertTransaction);
      Conexao.StartTransaction(FTr);
      try
        ParamByName('Pk').AsInteger     := Result;
        if (ADataSet <> nil) then
          ParamByName('DataSet').AsString := ADataSet.Name
        else
          ParamByName('DataSet').AsString := 'nil';
        ParamByName('Date').AsDateTime  := Now;
        ExecSql;
        Conexao.Commit(FTr);
      except on E:Exception do
        begin
          if Active then Close;
          Conexao.Rollback(FTr);
          raise Exception.Create('Erro ao abrir Transação' + NL + E.Message);
        end;
      end;
    end;
    if (ADataSet <> nil) then
      ADataSet.Tag := Result;
    FTr.TransactionID := Result;
    Conexao.StartTransaction(FTr);
  end;
end;

function TDados.UpdateUser(const Action: TUserAction; const AUserName, APassword,
  AFirstName, AMiddleName, ALastName, ARole: string): Boolean;
const
  S_USER_ACTIONS: array [TUserAction] of string =
    ('Adding', 'Modifying', 'Deleting');
begin
  Result := False;
  if (AUserName = '') or ((Action <> uaDelete) and (APassword = '')) then exit;
  GetDBAUser;
  if Assigned(PrcDBInfo) then
  begin
    try
      case Action of
        uaAdd   : Result := FDBInfo.AddUser(AUserName, APassword, AFirstName,
                              AMiddleName, ALastName, ARole);
        uaModify: Result := FDBInfo.ModifyUser(AUserName, APassword, AFirstName,
                              AMiddleName, ALastName, ARole);
        uaDelete: Result := FDBInfo.DeleteUser(AUserName);
      end;
    except on E:Exception do
      begin
        FSysDBAUser   := '';
        FSysDBAPasswd := '';
        raise Exception.CreateFmt('UpdateUser: Error when %s user %s!' + NL +
          E.Message, [S_USER_ACTIONS[Action], AUserName]);
      end;
    end;
  end;
  FSysDBAUser   := '';
  FSysDBAPasswd := '';
end;

function TDados.GetQtdMask: string;
begin
  Result := INT_MASK + DECIMAL_PLACES_MASK[FDecimalPlacesQtd];
  Result := Result + '; - ' + Result;
end;

function TDados.GetPk(const ASql: string; AParamData: TDataRow): TDataRow;
var
  i: Integer;
begin
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(ASql);
  try
    if (AParamData <> nil) then
    begin
      for i := 0 to AParamData.Count - 1 do
        qrSqlAux.ParamByName(AParamData.Fields[i].FieldName).Value := AParamData.Fields[i].Value;
    end;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
  end;
end;

function TDados.GetCompanyCountry: Integer;
begin
  Result := Parametros.soCompanyCountry;
end;

function TDados.GetCompanyState: string;
begin
  Result := Parametros.soCompanyState;
end;

procedure TDados.ShowFormFromLib(ALib, AMainForm: string; ACallBack: TFormCallBack);
var
  aForm   : TForm;
  hHandle : HMODULE;
  aClass  : TClass;
  aParams : TParamsForm;
begin
  aForm   := nil;
  aParams.PkReport := 0;
  aParams.DscPrg   := '';
  if (AMainForm = '') then exit;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlGetProgramLib);
  try
    qrSqlAux.ParamByName('NomFrm').AsString     := AMainForm;
    qrSqlAux.ParamByName('FkModulos').AsInteger := Parametros.soPkModule;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      aParams.PkReport := qrSqlAux.FieldByName('FK_RELATORIOS').AsInteger;
      aParams.DscPrg   := qrSqlAux.FieldByName('DSC_PRG').AsString;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
  ALib    := sDoth + sPathSep + ALib + SPCKEXT;
  hHandle := LoadPackage(ALib);
  if hHandle <> 0 then
  begin
    try
      aClass := GetClass(AMainForm);
      if (aClass <> nil) then
      begin
        aForm := TFormClass(aClass).Create(Self);
        aForm.Caption := aParams.DscPrg;
        if Assigned(ACallBack) then
          ACallBack(aForm, aParams);
        aForm.ShowModal;
      end
      else
        raise Exception.CreateFmt('GetFormFromLib: Form %s not found', [AMainForm]);
    finally
      FreeAndNil(aForm);
      UnloadPackage(hHandle);
    end
  end
  else
    raise Exception.CreateFmt('GetFormFromLib: Package %s not found', [ALib]);
end;

initialization
  Application.CreateForm(TDados, Dados);

end.


