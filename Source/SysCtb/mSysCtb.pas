unit mSysCtb;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 10/07/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses Windows, SysUtils, DB, Encryp, ProcType, FMTBcd, SqlExpr, Classes, Forms,
  GridRow, ProcUtils, TSysFatAux, TSysBcCx, TSysPedAux;

type
  TTaxes = record
    Taxes   : TDataRow;
    Accounts: TDataRow;
    Ranges  : TList;
  end;

  TdmSysCtb = class(TDataModule)
    qrTypeTax: TSQLQuery;
    qrSqlAux: TSQLQuery;
    qrOrigim: TSQLQuery;
    qrSituation: TSQLQuery;
    qrTypeCfop: TSQLQuery;
    qrNatOperation: TSQLQuery;
    qrFiscalClass: TSQLQuery;
    qrAccount: TSQLQuery;
    qrTaxPrinter: TSQLQuery;
    qrTax: TSQLQuery;
    qrTaxAccount: TSQLQuery;
    qrTaxRange: TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FFkCountry: Integer;
    FFkState: string;
    FFlagES: TInOut;
    FFkTypeTax: Integer;
    FFkTax: Integer;
    FFkTypeCfop: Integer;
    function  GetAccountPlan(APk: Integer): TClassification;
    function  GetTax(APk: Integer): TDataRow;
    function  GetTaxPrinter(APk: Integer): TDataRow;
    function  GetTypeTax(APk: Integer): TTaxes;
    function  GetTaxAccount(APk: Integer): TDataRow;
    function  GetTaxRanges(APk: Integer): TList;
    function  GetNatOperator(APk: Integer): TDataRow;
    function  GetTypeCfop(APk: Integer): TDataRow;
    function  GetOrigim(APk, AType: Integer): TDataRow;
    procedure SetAccountPlan(APk: Integer; const Value: TClassification);
    procedure SetTax(APk: Integer; const Value: TDataRow);
    procedure SetTaxPrinter(APk: Integer; const Value: TDataRow);
    procedure SetTypeTax(APk: Integer; const Value: TTaxes);
    procedure SetTaxAccount(APk: Integer; const Value: TDataRow);
    procedure SetTaxRanges(APk: Integer; const Value: TList);
    procedure SetNatOperator(APk: Integer; const Value: TDataRow);
    procedure SetTypeCfop(APk: Integer; const Value: TDataRow);
    procedure SetOrigim(APk, AType: Integer; const Value: TDataRow);
    function GetFiscalClass(APk: Integer): TDataRow;
    procedure SetFiscalClass(APk: Integer; const Value: TDataRow);
  public
    { Public declarations }
    function  LoadTCfop: TStrings;
    function  LoadPrinters: TStrings;
    function  LoadFinanceAccounts(AAccountNat: Integer): TStrings;
    function  LoadCountries: TStrings;
    function  LoadStates(ACountry: Integer): TStrings;
    property  FlagES                   : TInOut          read FFlagES        write FFlagES;
    property  FkCountry                : Integer         read FFkCountry     write FFkCountry;
    property  FkState                  : string          read FFkState       write FFkState;
    property  FkTax                    : Integer         read FFkTax         write FFkTax;
    property  FkTypeTax                : Integer         read FFkTypeTax     write FFkTypeTax;
    property  FkTypeCfop               : Integer         read FFkTypeCfop    write FFkTypeCfop;
    property  AccountPlan[APk: Integer]: TClassification read GetAccountPlan write SetAccountPlan;
    property  TypeTax    [APk: Integer]: TTaxes          read GetTypeTax     write SetTypeTax;
    property  Tax        [APk: Integer]: TDataRow        read GetTax         write SetTax;
    property  TaxPrinter [APk: Integer]: TDataRow        read GetTaxPrinter  write SetTaxPrinter;
    property  TaxAccount [APk: Integer]: TDataRow        read GetTaxAccount  write SetTaxAccount;
    property  TaxRanges  [APk: Integer]: TList           read GetTaxRanges   write SetTaxRanges;
    property  TypeCfop   [APk: Integer]: TDataRow        read GetTypeCfop    write SetTypeCfop;
    property  NatOperator[APk: Integer]: TDataRow        read GetNatOperator write SetNatOperator;
    property  Origim     [APk, AType: Integer]: TDataRow read GetOrigim      write SetOrigim;
    property  FiscalClass[APk: Integer]: TDataRow        read GetFiscalClass write SetFiscalClass;
  end;

var
  dmSysCtb: TdmSysCtb;

implementation

uses FuncoesDB, CtbArqSql, Dado, CmmConst, SqlComm, ArqCnst, TypInfo, Dialogs,
  Funcoes, TSysCadAux;

{$R *.DFM}

procedure TdmSysCtb.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

procedure TdmSysCtb.DataModuleDestroy(Sender: TObject);
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

function  TdmSysCtb.LoadTCfop: TStrings;
begin
  Result := TStringList.Create;
  if (qrTypeCfop.Active) then qrTypeCfop.Close;
  qrTypeCfop.SQL.Clear;
  qrTypeCfop.SQL.Add(SqlTiposCfop);
  Dados.StartTransaction(qrTypeCfop);
  qrTypeCfop.Open;
  try
    if (not qrTypeCfop.IsEmpty) then
    begin
      qrTypeCfop.First;
      Result.AddObject('<Nenhuma>', nil);
      while not qrTypeCfop.Eof do
      begin
        Result.AddObject(qrTypeCfop.FindField('DSC_TMRC').AsString,
          TObject(qrTypeCfop.FindField('PK_TIPO_CFOP').AsInteger));
        qrTypeCfop.Next;
      end;
    end;
  finally
    if (qrTypeCfop.Active) then qrTypeCfop.Close;
    Dados.CommitTransaction(qrTypeCfop);
  end;
end;

function TdmSysCtb.LoadCountries: TStrings;
begin
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlCountries);
  Dados.StartTransaction(qrSqlAux);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result := TStringList.Create;
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FindField('DSC_PAIS').AsString,
                         TObject(qrSqlAux.FindField('PK_PAISES').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysCtb.LoadStates(ACountry: Integer): TStrings;
var
  aItem: TState;
begin
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlStates);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkPaises').AsInteger := ACountry;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result := TStringList.Create;
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      aItem         := TState.Create;
      aItem.PkState := qrSqlAux.FindField('PK_ESTADOS').AsString;
      aItem.DscUF   := qrSqlAux.FindField('DSC_UF').AsString;
      aItem.cbIndex := Result.AddObject(aItem.DscUF, aItem);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysCtb.LoadPrinters: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlSuportedPrinters);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.AddObject('<Nenhuma>', nil);
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FindField('DSC_IMP').AsString,
          TObject(qrSqlAux.FindField('PK_SUPORTED_PRINTERS').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysCtb.LoadFinanceAccounts(AAccountNat: Integer): TStrings;
var
  aObj: TClassification;
begin
  Result := TStringList.Create;
  with qrSqlAux do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlFinanceAccounts);
    Dados.StartTransaction(qrSqlAux);
    try
      ParamByName('FlagTCta').AsInteger := AAccountNat;
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

function TdmSysCtb.GetAccountPlan(APk: Integer): TClassification;
begin
  with qrAccount do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlPlanAccount);
    Dados.StartTransaction(qrAccount);
    try
      ParamByName('PkPlanoContas').AsInteger := APk;
      if (not Active) then Open;
      Result := TClassification.Create;
      with Result do
      begin
        DscClass      := FieldByName('DSC_CTA').AsString;
        FkAccountPlan := FieldByName('FK_PLANO_CONTAS').AsInteger;
        FlagAnlSnt    := Boolean(FieldByName('FLAG_ANL_SNT').AsInteger);
        FlagID        := TAccountType(FieldByName('FLAG_ID').AsInteger);
        FlagTCta      := TAccountNat(FieldByName('FLAG_TCTA').AsInteger);
        MaskCta       := FieldByName('MASK_CTA').AsString;
        NivCta        := FieldByName('GRAU_CTA').AsInteger;
        SeqCta        := FieldByName('SEQ_PLCTA').AsInteger;
        Pk            := FieldByName('PK_PLANO_CONTAS').AsInteger;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(qrAccount);
    end;
  end;
end;

function TdmSysCtb.GetTypeTax(APk: Integer): TTaxes;
begin
  if qrTypeTax.Active then qrTypeTax.Close;
  qrTypeTax.SQL.Clear;
  qrTypeTax.SQL.Add(SqlSelectTypeTax);
  Dados.StartTransaction(qrTypeTax);
  try
    qrTypeTax.ParamByName('PkTipoImpostos').AsInteger := APk;
    if (not qrTypeTax.Active) then qrTypeTax.Open;
    Result.Taxes    := TDataRow.CreateFromDataSet(nil, qrTypeTax, True);
    FkTypeTax       := APk;
  finally
    if qrTypeTax.Active then qrTypeTax.Close;
    Dados.CommitTransaction(qrTypeTax);
  end;
  Result.Accounts := TaxAccount[APk];
  Result.Ranges   := TaxRanges[APk];
end;

function TdmSysCtb.GetTax(APk: Integer): TDataRow;
begin
  if qrTax.Active then qrTax.Close;
  qrTax.SQL.Clear;
  qrTax.SQL.Add(SqlSelectTax);
  Dados.StartTransaction(qrTax);
  try
    qrTax.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
    qrTax.ParamByName('FkTipoImpostos').AsInteger := FFkTypeTax;
    qrTax.ParamByName('FkPaises').AsInteger       := FFkCountry;
    qrTax.ParamByName('FkEstados').AsString       := FFkState;
    qrTax.ParamByName('PkAliquotas').AsInteger    := Ord(FFlagES);
    if (not qrTax.Active) then qrTax.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTax, True);
  finally
    if qrTax.Active then qrTax.Close;
    Dados.CommitTransaction(qrTax);
  end;
end;

function TdmSysCtb.GetTaxPrinter(APk: Integer): TDataRow;
begin
  if qrTaxPrinter.Active then qrTaxPrinter.Close;
  qrTaxPrinter.SQL.Clear;
  qrTaxPrinter.SQL.Add(SqlSelectTaxPrinter);
  Dados.StartTransaction(qrTaxPrinter);
  try
    qrTaxPrinter.ParamByName('FkEmpresas').AsInteger           := Dados.PkCompany;
    qrTaxPrinter.ParamByName('FkTipoImpostos').AsInteger       := FFkTypeTax;
    qrTaxPrinter.ParamByName('FkPaises').AsInteger             := FFkCountry;
    qrTaxPrinter.ParamByName('FkEstados').AsString             := FFkState;
    qrTaxPrinter.ParamByName('PkAliquotasImpFiscal').AsInteger := APk;
    if (not qrTaxPrinter.Active) then qrTaxPrinter.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTaxPrinter, True);
  finally
    if qrTaxPrinter.Active then qrTaxPrinter.Close;
    Dados.CommitTransaction(qrTaxPrinter);
  end;
end;

function TdmSysCtb.GetTaxAccount(APk: Integer): TDataRow;
begin
  if qrTaxAccount.Active then qrTaxAccount.Close;
  qrTaxAccount.SQL.Clear;
  qrTaxAccount.SQL.Add(SqlSelectTaxAccount);
  Dados.StartTransaction(qrTaxAccount);
  try
    qrTaxAccount.ParamByName('FkTipoImpostos').AsInteger := APk;
    qrTaxAccount.ParamByName('PkTipoImpostosFinanceiro').AsInteger := Ord(ioIn);
    if (not qrTaxAccount.Active) then qrTaxAccount.Open;
    Result := TDataRow.Create(nil);
    Result.AddAs('FK_TIPO_IMPOSTOS_IN',
      qrTaxAccount.FieldByName('FK_TIPO_IMPOSTOS').AsInteger, ftInteger, SizeOf(Integer));
    Result.AddAs('FK_FINANCEIRO_CONTAS_IN_CR',
      qrTaxAccount.FieldByName('FK_FINANCEIRO_CONTAS__CR').AsInteger, ftInteger, SizeOf(Integer));
    Result.AddAs('FK_FINANCEIRO_CONTAS_IN_DB',
      qrTaxAccount.FieldByName('FK_FINANCEIRO_CONTAS__DB').AsInteger, ftInteger, SizeOf(Integer));
    if qrTaxAccount.Active then qrTaxAccount.Close;
    qrTaxAccount.ParamByName('FkTipoImpostos').AsInteger := APk;
    qrTaxAccount.ParamByName('PkTipoImpostosFinanceiro').AsInteger := Ord(ioOut);
    if (not qrTaxAccount.Active) then qrTaxAccount.Open;
    Result.AddAs('FK_TIPO_IMPOSTOS_OUT',
      qrTaxAccount.FieldByName('FK_TIPO_IMPOSTOS').AsInteger, ftInteger, SizeOf(Integer));
    Result.AddAs('FK_FINANCEIRO_CONTAS_OUT_CR',
      qrTaxAccount.FieldByName('FK_FINANCEIRO_CONTAS__CR').AsInteger, ftInteger, SizeOf(Integer));
    Result.AddAs('FK_FINANCEIRO_CONTAS_OUT_DB',
      qrTaxAccount.FieldByName('FK_FINANCEIRO_CONTAS__DB').AsInteger, ftInteger, SizeOf(Integer));
  finally
    if qrTaxAccount.Active then qrTaxAccount.Close;
    Dados.CommitTransaction(qrTaxAccount);
  end;
end;

function TdmSysCtb.GetTaxRanges(APk: Integer): TList;
begin
  Result := TList.Create;
  if qrTaxRange.Active then qrTaxRange.Close;
  qrTaxRange.SQL.Clear;
  qrTaxRange.SQL.Add(SqlSelectTaxRange);
  Dados.StartTransaction(qrTaxRange);
  try
    qrTaxRange.ParamByName('FkTipoImpostos').AsInteger := APk;
    if (not qrTaxRange.Active) then qrTaxRange.Open;
    while (not qrTaxRange.Eof) do
    begin
      Result.Add(TDataRow.CreateFromDataSet(nil, qrTaxRange, True));
      qrTaxRange.Next;
    end;
  finally
    if qrTaxRange.Active then qrTaxRange.Close;
    Dados.CommitTransaction(qrTaxRange);
  end;
end;

function TdmSysCtb.GetNatOperator(APk: Integer): TDataRow;
begin
  if qrNatOperation.Active then qrNatOperation.Close;
  qrNatOperation.SQL.Clear;
  qrNatOperation.SQL.Add(SqlGetNatOper);
  Dados.StartTransaction(qrNatOperation);
  try
    qrNatOperation.ParamByName('FkTipoCfop').AsInteger          := FFkTypeCfop;
    qrNatOperation.ParamByName('PkNaturezaOperacoes').AsInteger := APk;
    if (not qrNatOperation.Active) then qrNatOperation.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrNatOperation, True);
  finally
    if qrNatOperation.Active then qrNatOperation.Close;
    Dados.CommitTransaction(qrNatOperation);
  end;
end;

function TdmSysCtb.GetTypeCfop(APk: Integer): TDataRow;
begin
  if qrTypeCfop.Active then qrTypeCfop.Close;
  qrTypeCfop.SQL.Clear;
  qrTypeCfop.SQL.Add(SqlGetTypeCfop);
  Dados.StartTransaction(qrTypeCfop);
  try
    qrTypeCfop.ParamByName('PkTipoCfop').AsInteger := APk;
    if (not qrTypeCfop.Active) then qrTypeCfop.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTypeCfop, True);
  finally
    if qrTypeCfop.Active then qrTypeCfop.Close;
    Dados.CommitTransaction(qrTypeCfop);
  end;
end;

function TdmSysCtb.GetOrigim(APk, AType: Integer): TDataRow;
const
  TYPE_DATA_PARAMS_NAMES: array [0..1] of string =
    ('PkOrigensTributarias', 'PkSituacaoTributaria');
begin
  if qrOrigim.Active then qrOrigim.Close;
  qrOrigim.SQL.Clear;
  case AType of
    0: qrOrigim.SQL.Add(SqlSelectOrigin);
    1: qrOrigim.SQL.Add(SqlSelectSituation);
  end;
  Dados.StartTransaction(qrOrigim);
  try
    qrOrigim.ParamByName(TYPE_DATA_PARAMS_NAMES[aType]).AsInteger := APk;
    if (not qrOrigim.Active) then qrOrigim.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrOrigim, True);
  finally
    if qrOrigim.Active then qrOrigim.Close;
    Dados.CommitTransaction(qrOrigim);
  end;
end;

function TdmSysCtb.GetFiscalClass(APk: Integer): TDataRow;
begin
  if qrFiscalClass.Active then qrFiscalClass.Close;
  qrFiscalClass.SQL.Clear;
  qrFiscalClass.SQL.Add(SqlSelectFsclClass);
  Dados.StartTransaction(qrFiscalClass);
  try
    qrFiscalClass.ParamByName('PkClassificacaoFiscal').AsString := IntToStr(APk);
    if (not qrFiscalClass.Active) then qrFiscalClass.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrFiscalClass, True);
  finally
    if qrFiscalClass.Active then qrFiscalClass.Close;
    Dados.CommitTransaction(qrFiscalClass);
  end;
end;

procedure TdmSysCtb.SetAccountPlan(APk: Integer; const Value: TClassification);
var
  aParams: TDataRow;
begin
  if qrAccount.Active then qrAccount.Close;
  qrAccount.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrAccount.SQL.Add(SqlDeletePlanAcc);
    dbmEdit  : qrAccount.SQL.Add(SqlUpdatePlanAcc);
    dbmInsert: qrAccount.SQL.Add(SqlInsertPlanAcc);
  end;
  Dados.StartTransaction(qrAccount);
  try
    with qrAccount, Value do
    begin
      if (Pk = 0) then
      begin
        aParams := TDataRow.Create(nil);
        try
          aParams.AddAs('FkPlanoContas', 0, ftInteger, SizeOf(Integer));
          aParams.AddAs('SeqCta', 0, ftInteger, SizeOf(Integer));
          Pk := Dados.GetPk(SqlGetPkPlanAcc, aParams).FieldByName['PK_PLANO_CONTAS'].AsInteger;
        finally
          FreeAndNil(aParams);
        end;
      end;
      ParamByName('PkPlanoContas').AsInteger        := Pk;
      if (NivCta = 1) or (FkFinanceAccount = 0) then FkFinanceAccount := Pk;
      if (Params.FindParam('FkPlanoContas') <> nil) then
        ParamByName('FkPlanoContas').AsInteger      := FkFinanceAccount;
      if (Params.FindParam('DscCta')             <> nil) then
        ParamByName('DscCta').AsString              := DscClass;
      if (Params.FindParam('FlagAnlSnt')         <> nil) then
        ParamByName('FlagAnlSnt').AsInteger         := Ord(FlagAnlSnt);
      if (Params.FindParam('FlagID')             <> nil) then
        ParamByName('FlagID').AsInteger             := Ord(FlagID);
      if (Params.FindParam('FlagTCta')           <> nil) then
        ParamByName('FlagTCta').AsInteger           := Ord(FlagTCta);
      if (Params.FindParam('MaskCta')            <> nil) then
        ParamByName('MaskCta').AsString             := MaskCta;
      if (Params.FindParam('GrauCta')            <> nil) then
        ParamByName('GrauCta').AsInteger            := NivCta;
      if (Params.FindParam('SeqCta')             <> nil) then
        ParamByName('SeqCta').AsInteger             := SeqCta;
    end;
    qrAccount.ExecSQL;
    Dados.CommitTransaction(qrAccount);
  except on E:Exception do
    begin
      if qrAccount.Active then qrAccount.Close;
      Dados.RollbackTransaction(qrAccount);
      raise Exception.Create('SetClassification: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrAccount.SQL.Text);
    end;
  end;
end;

procedure TdmSysCtb.SetTypeTax(APk: Integer; const Value: TTaxes);
var
  M: TStream;
begin
  if qrTypeTax.Active then qrTypeTax.Close;
  qrTypeTax.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTypeTax.SQL.Add(SqlDeleteTypeTax);
    dbmInsert: qrTypeTax.SQL.Add(SqlInsertTypeTax);
    dbmEdit  : qrTypeTax.SQL.Add(SqlUpdateTypeTax);
  end;
  if (Value.Taxes.FindField['MSG_IMP'] = nil) or
     (Value.Taxes.FieldByName['MSG_IMP'].IsNull) then
    qrTypeTax.SQL.Text := StringReplace(qrTypeTax.SQL.Text, ':MsgImp', 'null', []);
  Dados.StartTransaction(qrTypeTax);
  try
    if (Value.Taxes.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger = 0) then
      Value.Taxes.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger :=
        Dados.GetPk(SqlGenPkTypeTax, nil).FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
    FFkTypeTax := Value.Taxes.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
    qrTypeTax.ParamByName('PkTipoImpostos').AsInteger  := Value.Taxes.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
    if (qrTypeTax.Params.FindParam('DscImps') <> nil) then
      qrTypeTax.ParamByName('DscImps').AsString        := Value.Taxes.FieldByName['DSC_IMPS'].AsString;
    if (qrTypeTax.Params.FindParam('FlagCalc') <> nil) then
      qrTypeTax.ParamByName('FlagCalc').AsInteger      := Value.Taxes.FieldByName['FLAG_CALC'].AsInteger;
    if (qrTypeTax.Params.FindParam('FlagImpst') <> nil) then
      qrTypeTax.ParamByName('FlagImpst').AsInteger     := Value.Taxes.FieldByName['FLAG_IMPST'].AsInteger;
    if (qrTypeTax.Params.FindParam('FlagRet') <> nil) then
      qrTypeTax.ParamByName('FlagRet').AsInteger       := Value.Taxes.FieldByName['FLAG_RET'].AsInteger;
    if (qrTypeTax.Params.FindParam('FlagDstc') <> nil) then
      qrTypeTax.ParamByName('FlagDstc').AsInteger      := Value.Taxes.FieldByName['FLAG_DSTC'].AsInteger;
    if (qrTypeTax.Params.FindParam('FlagRange') <> nil) then
      qrTypeTax.ParamByName('FlagRange').AsInteger     := Value.Taxes.FieldByName['FLAG_RANGE'].AsInteger;
    if (qrTypeTax.Params.FindParam('FlagAlqtUnica') <> nil) then
      qrTypeTax.ParamByName('FlagAlqtUnica').AsInteger := Value.Taxes.FieldByName['FLAG_ALQT_UNICA'].AsInteger;
    if (qrTypeTax.Params.FindParam('RedBasC') <> nil) then
      qrTypeTax.ParamByName('RedBasC').AsFloat         := Value.Taxes.FieldByName['RED_BASC'].AsFloat;
    if (qrTypeTax.Params.FindParam('MsgImp') <> nil) then
    begin
      M := TMemoryStream.Create;
      try
        Value.Taxes.FieldByName['MSG_IMP'].SaveToStream(M, buValue);
        M.Position := 0;
        qrTypeTax.ParamByName('MsgImp').LoadFromStream(M, ftBlob);
      finally
        FreeAndNil(M);
      end;
    end;
    qrTypeTax.ExecSql;
    Dados.CommitTransaction(qrTypeTax);
  except on E:Exception do
    begin
      if qrTypeTax.Active then qrTypeTax.Close;
      Dados.RollbackTransaction(qrTypeTax);
      raise Exception.Create('SaveTypeTax: Falha ao salvar o registro!' + NL +
        E.Message + NL + qrTypeTax.SQL.Text);
    end;
  end;
  if (Value.Taxes.FieldByName['FLAG_CALC'].AsInteger = 1) then
    TaxAccount[APk] := Value.Accounts;
  TaxRanges[APk]  := Value.Ranges;
end;

procedure TdmSysCtb.SetTax(APk: Integer; const Value: TDataRow);
begin
  if qrTax.Active then qrTax.Close;
  qrTax.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTax.SQL.Add(SqlDeleteTax);
    dbmInsert: qrTax.SQL.Add(SqlInsertTax);
    dbmEdit  : qrTax.SQL.Add(SqlUpdateTax);
  end;
  Dados.StartTransaction(qrTax);
  try
    qrTax.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
    qrTax.ParamByName('FkTipoImpostos').AsInteger := FFkTypeTax;
    qrTax.ParamByName('FkPaises').AsInteger       := Value.FieldByName['FK_PAISES'].AsInteger;
    qrTax.ParamByName('FkEstados').AsString       := Value.FieldByName['FK_ESTADOS'].AsString;
    qrTax.ParamByName('PkAliquotas').AsInteger    := Ord(FFlagES);
    if (qrTax.Params.FindParam('AlqtImpst') <> nil) then
      qrTax.ParamByName('AlqtImpst').AsFloat      := Value.FieldByName['ALQT_IMPST'].AsFloat;
    if (qrTax.Params.FindParam('AlqtCnsf') <> nil) then
      qrTax.ParamByName('AlqtCnsf').AsFloat       := Value.FieldByName['ALQT_CNSF'].AsFloat;
    if (qrTax.Params.FindParam('AlqtArbt') <> nil) then
      qrTax.ParamByName('AlqtArbt').AsFloat       := Value.FieldByName['ALQT_ARBT'].AsFloat;
    qrTax.ExecSql;
    Dados.CommitTransaction(qrTax);
  except on E:Exception do
    begin
      if qrTax.Active then qrTax.Close;
      Dados.RollbackTransaction(qrTax);
      raise Exception.Create('SetTax: Falha ao salvar o registro!' + NL +
        E.Message + NL + qrTax.SQL.Text);
    end;
  end;
end;

procedure TdmSysCtb.SetTaxPrinter(APk: Integer; const Value: TDataRow);
begin
  if qrTaxPrinter.Active then qrTaxPrinter.Close;
  qrTaxPrinter.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTaxPrinter.SQL.Add(SqlDeleteTaxPrinter);
    dbmInsert: qrTaxPrinter.SQL.Add(SqlInsertTaxPrinter);
    dbmEdit  : qrTaxPrinter.SQL.Add(SqlUpdateTaxPrinter);
  end;
  Dados.StartTransaction(qrTaxPrinter);
  try
    qrTaxPrinter.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
    qrTaxPrinter.ParamByName('FkTipoImpostos').AsInteger := FFkTypeTax;
    qrTaxPrinter.ParamByName('FkPaises').AsInteger       := FFkCountry;
    qrTaxPrinter.ParamByName('FkEstados').AsString       := FFkState;
    qrTaxPrinter.ParamByName('FkAliquotas').AsInteger    := FFkTax;
    qrTaxPrinter.ParamByName('PkAliquotasImpFiscal').AsInteger := Value.FieldByName['PK_ALIQUOTAS_IMP_FISCAL'].AsInteger;
    if (qrTaxPrinter.Params.FindParam('CodAlqt') <> nil) then
      qrTaxPrinter.ParamByName('CodAlqt').AsInteger      := Value.FieldByName['COD_ALQT'].AsInteger;
    if (qrTaxPrinter.Params.FindParam('CodAlqtCnsf') <> nil) then
      qrTaxPrinter.ParamByName('CodAlqtCnsf').AsInteger  := Value.FieldByName['COD_ALQT_CNSF'].AsInteger;
    qrTaxPrinter.ExecSql;
    Dados.CommitTransaction(qrTaxPrinter);
  except on E:Exception do
    begin
      if qrTaxPrinter.Active then qrTaxPrinter.Close;
      Dados.RollbackTransaction(qrTaxPrinter);
      raise Exception.Create('SetTaxPrinter: Falha ao salvar o registro!' + NL +
        E.Message + NL + qrTaxPrinter.SQL.Text);
    end;
  end;
end;

procedure TdmSysCtb.SetTaxAccount(APk: Integer; const Value: TDataRow);
var
  i       : TInOut;
  TestData: TDataRow;
const
  LC_FIELD_NAME: array [0..2, ioIn..ioOut] of string =
    (('FK_TIPO_IMPOSTOS_IN', 'FK_TIPO_IMPOSTOS_OUT'),
     ('FK_FINANCEIRO_CONTAS_IN_CR', 'FK_FINANCEIRO_CONTAS_OUT_CR'),
     ('FK_FINANCEIRO_CONTAS_IN_DB', 'FK_FINANCEIRO_CONTAS_OUT_DB'));
begin
  for i := ioIn to ioOut do
  begin
    FFlagES := i;
    if (TDBMode(APk) = dbmEdit) then
    begin
      try
        TestData := GetTaxAccount(FFkTypeTax);
        if (TestData.FieldByName[LC_FIELD_NAME[0, i]].AsInteger = 0) then
          APk := Ord(dbmInsert)
        else
          if (Value.FieldByName[LC_FIELD_NAME[1, i]].AsInteger = 0) and
             (Value.FieldByName[LC_FIELD_NAME[2, i]].AsInteger = 0) then
            APk := Ord(dbmDelete)
      finally
        FreeAndNil(TestData);
      end;
    end;
    if qrTaxAccount.Active then qrTaxAccount.Close;
    qrTaxAccount.SQL.Clear;
    case TDBMode(APk) of
      dbmDelete: qrTaxAccount.SQL.Add(SqlDeleteTaxAccount);
      dbmInsert: qrTaxAccount.SQL.Add(SqlInsertTaxAccount);
      dbmEdit  : qrTaxAccount.SQL.Add(SqlUpdateTaxAccount);
    end;
    Dados.StartTransaction(qrTaxAccount);
    try
      qrTaxAccount.ParamByName('FkTipoImpostos').AsInteger := FFkTypeTax;
      qrTaxAccount.ParamByName('PkTipoImpostosFinanceiro').AsInteger := Ord(FlagES);
      if (qrTaxAccount.Params.FindParam('FkFinanceiroContasCR') <> nil) then
        qrTaxAccount.ParamByName('FkFinanceiroContasCR').AsInteger :=
         Value.FieldByName[LC_FIELD_NAME[1, i]].AsInteger;
      if (qrTaxAccount.Params.FindParam('FkFinanceiroContasDB') <> nil) then
        qrTaxAccount.ParamByName('FkFinanceiroContasDB').AsInteger :=
          Value.FieldByName[LC_FIELD_NAME[2, i]].AsInteger;
      qrTaxAccount.ExecSql;
      Dados.CommitTransaction(qrTaxAccount);
    except on E:Exception do
      begin
        if qrTaxAccount.Active then qrTaxAccount.Close;
        Dados.RollbackTransaction(qrTaxAccount);
        raise Exception.Create('SaveTypeTax: Falha ao salvar o registro!' + NL +
          E.Message + NL + qrTaxAccount.SQL.Text);
      end; // end except
    end; // end try
  end; // end for
end;

procedure TdmSysCtb.SetTaxRanges(APk: Integer; const Value: TList);
var
  i: Integer;
  c: Integer;
begin
  if (TDBMode(APk) = dbmEdit) then
  begin
    APk := Ord(dbmInsert);
    if qrTaxRange.Active then qrTaxRange.Close;
    qrTaxRange.SQL.Clear;
    qrTaxRange.SQL.Add(SqlDeleteTaxRange);
    Dados.StartTransaction(qrTaxRange);
    try
      qrTaxRange.ParamByName('FkTipoImpostos').AsInteger := FFkTypeTax;
      qrTaxRange.ExecSql;
    finally
      Dados.CommitTransaction(qrTaxRange);
    end;
  end;
  if (Value = nil) then
    c := 1
  else
    c := Value.Count - 1;
  if (c = 0) then exit;
  if qrTaxRange.Active then qrTaxRange.Close;
  qrTaxRange.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTaxRange.SQL.Add(SqlDeleteTaxRange);
    dbmInsert: qrTaxRange.SQL.Add(SqlInsertTaxRange);
  end;
  Dados.StartTransaction(qrTaxRange);
  try
    for i := 0 to c do
    begin
      qrTaxRange.ParamByName('FkTipoImpostos').AsInteger := FFkTypeTax;
      if (Value <> nil) then
      begin
        with TDataRow(Value.Items[i]) do
        begin
          if (qrTaxRange.Params.FindParam('PkStartRange') <> nil) then
            qrTaxRange.ParamByName('PkStartRange').AsFloat := FieldByName['PK_START_RANGE'].AsFloat;
          if (qrTaxRange.Params.FindParam('PkEndRange') <> nil) then
            qrTaxRange.ParamByName('PkEndRange').AsFloat   := FieldByName['PK_END_RANGE'].AsFloat;
          if (qrTaxRange.Params.FindParam('AlqtImpst') <> nil) then
            qrTaxRange.ParamByName('AlqtImpst').AsFloat    := FieldByName['ALQT_IMPST'].AsFloat;
        end;
      end;
      qrTaxRange.ExecSql;
    end;
    Dados.CommitTransaction(qrTaxRange);
  except on E:Exception do
    begin
      if qrTaxRange.Active then qrTaxRange.Close;
      Dados.RollbackTransaction(qrTaxRange);
      raise Exception.Create('SetTaxPrinter: Falha ao salvar o registro!' + NL +
        E.Message + NL + qrTaxRange.SQL.Text);
    end;
  end;
end;

procedure TdmSysCtb.SetNatOperator(APk: Integer; const Value: TDataRow);
  function GetPkNatOperator: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkNatOper);
    try
      qrSqlAux.ParamByName('FkTipoCfop').Value := FFkTypeCfop;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_NATUREZA_OPERACOES').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrNatOperation.Active then qrNatOperation.Close;
  qrNatOperation.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrNatOperation.SQL.Add(SqlDeleteNatOper);
    dbmInsert: qrNatOperation.SQL.Add(SqlInsertNatOper);
    dbmEdit  : qrNatOperation.SQL.Add(SqlUpdateNatOper);
  end;
  if (Value.FieldByName['CMPL_CFOP'].AsString = '') then
    qrNatOperation.SQL.Text := StringReplace(qrNatOperation.SQL.Text, ':CmplCfop', 'null', []);
  Dados.StartTransaction(qrNatOperation);
  try
    if (Value.FieldByName['PK_NATUREZA_OPERACOES'].AsInteger = 0) then
      Value.FieldByName['PK_NATUREZA_OPERACOES'].AsInteger := GetPkNatOperator;
    qrNatOperation.ParamByName('FkTipoCfop').AsInteger  := Value.FieldByName['FK_TIPO_CFOP'].AsInteger;
    qrNatOperation.ParamByName('PkNaturezaOperacoes').AsInteger  := Value.FieldByName['PK_NATUREZA_OPERACOES'].AsInteger;
    if (qrNatOperation.Params.FindParam('DscNtOp') <> nil) then
      qrNatOperation.ParamByName('DscNtOp').AsString  := Value.FieldByName['DSC_NTOP'].AsString;
    if (qrNatOperation.Params.FindParam('CodCfop') <> nil) then
      qrNatOperation.ParamByName('CodCfop').AsString  := Value.FieldByName['COD_CFOP'].AsString;
    if (qrNatOperation.Params.FindParam('CmplCfop') <> nil) then
      qrNatOperation.ParamByName('CmplCfop').AsString := Value.FieldByName['CMPL_CFOP'].AsString;
    if (qrNatOperation.Params.FindParam('FkFinanceiroContas') <> nil) then
      qrNatOperation.ParamByName('FkFinanceiroContas').AsInteger := Value.FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger;
    qrNatOperation.ExecSql;
    Dados.CommitTransaction(qrNatOperation);
  except on E:Exception do
    begin
      if qrNatOperation.Active then qrNatOperation.Close;
      Dados.RollbackTransaction(qrNatOperation);
      raise Exception.Create('SetNatOperator: Falha ao salvar o registro!' + NL +
        E.Message + NL + qrNatOperation.SQL.Text);
    end;
  end;
end;

procedure TdmSysCtb.SetTypeCfop(APk: Integer; const Value: TDataRow);
begin
  if qrTypeCfop.Active then qrTypeCfop.Close;
  qrTypeCfop.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTypeCfop.SQL.Add(SqlDeleteTypeCfop);
    dbmInsert: qrTypeCfop.SQL.Add(SqlInsertTypeCfop);
    dbmEdit  : qrTypeCfop.SQL.Add(SqlUpdateTypeCfop);
  end;
  Dados.StartTransaction(qrTypeCfop);
  try
    qrTypeCfop.ParamByName('PkTipoCfop').AsInteger      := Value.FieldByName['PK_TIPO_CFOP'].AsInteger;
    if (qrTypeCfop.Params.FindParam('OldPkTipoCfop') <> nil) then
      qrTypeCfop.ParamByName('OldPkTipoCfop').AsInteger := FFkTypeCfop;
    if (qrTypeCfop.Params.FindParam('DscTMrc') <> nil) then
      qrTypeCfop.ParamByName('DscTMrc').AsString  := Value.FieldByName['DSC_TMRC'].AsString;
    qrTypeCfop.ExecSql;
    Dados.CommitTransaction(qrTypeCfop);
  except on E:Exception do
    begin
      if qrTypeCfop.Active then qrTypeCfop.Close;
      Dados.RollbackTransaction(qrTypeCfop);
      raise Exception.Create('SetTypeCfop: Falha ao salvar o registro!' + NL +
        E.Message + NL + qrTypeCfop.SQL.Text);
    end;
  end;
end;

procedure TdmSysCtb.SetOrigim(APk, AType: Integer; const Value: TDataRow);
const
  TYPE_DATA_FIELDS_NAMES: array [0..1, 0..1] of string =
    (('PK_ORIGENS_TRIBUTARIAS', 'DSC_ORGM'),
     ('PK_ORIGENS_TRIBUTARIAS', 'DSC_IMPST'));
  TYPE_DATA_PARAMS_NAMES: array [0..1, 0..1] of string =
    (('PkOrigensTributarias', 'DscOrgm'),
     ('PkOrigensTributarias', 'DscImpst'));
begin
  if qrOrigim.Active then qrOrigim.Close;
  qrOrigim.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: case aType of
                 0: qrOrigim.SQL.Add(SqlDeleteOrigin);
                 1: qrOrigim.SQL.Add(SqlDeleteSituation);
               end;
    dbmInsert: case aType of
                 0: qrOrigim.SQL.Add(SqlInsertOrigin);
                 1: qrOrigim.SQL.Add(SqlInsertSituation);
               end;
    dbmEdit  : case aType of
                 0: qrOrigim.SQL.Add(SqlUpdateOrigin);
                 1: qrOrigim.SQL.Add(SqlUpdateSituation);
               end;
  end;
  Dados.StartTransaction(qrOrigim);
  try
    qrOrigim.ParamByName(TYPE_DATA_PARAMS_NAMES[AType, 0]).AsInteger :=
      Value.FieldByName[TYPE_DATA_FIELDS_NAMES[AType, 0]].AsInteger;
    if (qrOrigim.Params.FindParam(TYPE_DATA_PARAMS_NAMES[AType, 1]) <> nil) then
      qrOrigim.ParamByName(TYPE_DATA_PARAMS_NAMES[AType, 1]).AsString :=
        Value.FieldByName[TYPE_DATA_FIELDS_NAMES[AType, 1]].AsString;
    qrOrigim.ExecSql;
    Dados.CommitTransaction(qrOrigim);
  except on E:Exception do
    begin
      if qrOrigim.Active then qrOrigim.Close;
      Dados.RollbackTransaction(qrOrigim);
      raise Exception.Create('SetOrigim: Falha ao salvar o registro!' + NL +
        E.Message + NL + qrOrigim.SQL.Text);
    end;
  end;
end;

procedure TdmSysCtb.SetFiscalClass(APk: Integer; const Value: TDataRow);
begin
  if qrFiscalClass.Active then qrFiscalClass.Close;
  qrFiscalClass.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrFiscalClass.SQL.Add(SqlDeleteFsclClass);
    dbmInsert: qrFiscalClass.SQL.Add(SqlInsertFsclClass);
    dbmEdit  : qrFiscalClass.SQL.Add(SqlUpdateFsclClass);
  end;
  Dados.StartTransaction(qrFiscalClass);
  try
    qrFiscalClass.ParamByName('PkClassificacaoFiscal').AsString  := Value.FieldByName['PK_CLASSIFICACAO_FISCAL'].AsString;
    if (qrFiscalClass.Params.FindParam('DscClsF') <> nil) then
      qrFiscalClass.ParamByName('DscClsF').AsString  := Value.FieldByName['DSC_CLSF'].AsString;
    qrFiscalClass.ExecSql;
    Dados.CommitTransaction(qrFiscalClass);
  except on E:Exception do
    begin
      if qrFiscalClass.Active then qrFiscalClass.Close;
      Dados.RollbackTransaction(qrFiscalClass);
      raise Exception.Create('SetFiscalClass: Falha ao salvar o registro!' + NL +
        E.Message + NL + qrFiscalClass.SQL.Text);
    end;
  end;
end;

initialization
  Application.CreateForm(TdmSysCtb, dmSysCtb);
finalization
  if Assigned(dmSysCtb) then dmSysCtb.Free;
  dmSysCtb := nil;

end.
