unit mSysBcCx;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/01/2006 - DD/MM/YYYY                                      *}
{* Modified: 03/01/2006 - DD/MM/YYYY                                     *}
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
  SysUtils, Classes, FMTBcd, DB, SqlExpr, Forms, TSysBcCx, TSysFatAux, GridRow,
  ProcUtils, TSysPedAux;

type
  TTypeLan = (tlDebit, tlCredit);

  TdmSysBcCx = class(TDataModule)
    qrFinance: TSQLQuery;
    qrAccounts: TSQLQuery;
    qrSqlAux: TSQLQuery;
    qrTypeAccount: TSQLQuery;
    qrAgency: TSQLQuery;
    qrBank: TSQLQuery;
    qrAccount: TSQLQuery;
    qrBankAccount: TSQLQuery;
    qrFinanceOperation: TSQLQuery;
    qrTicket: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure SaveDocumentList(APk: Integer; AList: TList);
    function GetTickets(APk: Integer): TDataRow;
    procedure SetTickets(APk: Integer; const Value: TDataRow);
  public
    { Public declarations }
    function  GetAccount(const AFkTypeAccount, APk: Integer): TAccount;
    function  GetBankAccount(const APk, APkBank, APkAccount: Integer;
                const APkAgency: string): TBankAccount;
    function  GetAgencies(const AOwner: TPersistent; const APk: Integer;
                AAgencies: TAgencies): Boolean;
    function  GetBank(const APk: Integer): TBank;
    function  GetTypeAccount(APk: Integer): TTypeAccount;
    function  LoadAccounts(ATypeAccountLan: Integer): TStrings;
    function  LoadClassifications(ATypeLan: TTypeLan): TStrings;
    function  LoadFinalizations(AType: TTypeFinalization): TStrings;
    function  LoadOwners(ATypeLan: TTypeLan): TStrings;
    function  LoadProducts: TStrings;
    function  LoadTipoDocumentos: TStrings;
    function  LoadTypeOperations: TStrings;
    function  LoadPaymentWay: TStrings;
    procedure SaveAccount(const APk: Integer; const AItem: TAccount;
                const AMode: TDBMode);
    procedure SaveBankAccount(const APk, APkBank, APkAccount: Integer;
                const APkAgency: string; const ABankAccount: TBankAccount;
                const AMode: TDBMode);
    procedure SaveAgency(const APk: Integer; const AOldPk: string;
                const AAgency: TAgency; const AMode: TDBMode);
    procedure SaveBank(const AOldPk: Integer; const ABank: TBank;
                const AMode: TDBMode);
    procedure SaveFinanceOperation(AItem: TFinanceOperations; AMode: TDBMode;
                AList: TList);
    procedure SaveTypeAccount(AItem: TTypeAccount; AMode: TDBMode);
    property  Tickets[APk: Integer]: TDataRow read GetTickets write SetTickets;
  end;

var
  dmSysBcCx: TdmSysBcCx;

implementation

uses Funcoes, Dado, TypInfo, ArqSqlBcCx, Dialogs;

{$R *.dfm}

procedure TdmSysBcCx.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

procedure TdmSysBcCx.DataModuleDestroy(Sender: TObject);
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

function TdmSysBcCx.GetAccount(const AFkTypeAccount, APk: Integer): TAccount;
begin
  Result := TAccount.Create;
  if (AFkTypeAccount <= 0) or (APk <= 0) then exit;
  if qrAccount.Active then qrAccount.Close;
  qrAccount.SQL.Clear;
  qrAccount.SQL.Add(SqlAccount);
  Dados.StartTransaction(qrAccount);
  try
    qrAccount.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
    qrAccount.ParamByName('FkTipoContas').AsInteger := AFkTypeAccount;
    qrAccount.ParamByName('PkContas').AsInteger     := APk;
    if (not qrAccount.Active) then qrAccount.Open;
    Result.PkContas := qrAccount.FieldByName('PK_CONTAS').AsInteger;
    Result.DscAcc   := qrAccount.FieldByName('DSC_CTA').AsString;
    Result.DtaAbr   := qrAccount.FieldByName('DTA_ABR').AsDateTime;
    Result.DtaFch   := qrAccount.FieldByName('DTA_FCH').AsDateTime;
    Result.DtaSld   := qrAccount.FieldByName('DTA_SLD').AsDateTime;
    Result.SldAcc   := qrAccount.FieldByName('SLD_CTA').AsFloat;
    Result.SldIni   := qrAccount.FieldByName('SLD_INI').AsFloat;
    Result.SldPrev  := qrAccount.FieldByName('SLD_PREV').AsFloat;
  finally
    if qrAccount.Active then qrAccount.Close;
    Dados.CommitTransaction(qrAccount);
  end;
end;

function TdmSysBcCx.GetBankAccount(const APk, APkBank, APkAccount: Integer;
  const APkAgency: string): TBankAccount;
begin
  Result := TBankAccount.Create(nil);
  if (APk <= 0) or (APkBank = 0) or (APkAccount <= 0) or (APkAgency = '') then exit;
  if qrBankAccount.Active then qrBankAccount.Close;
  qrBankAccount.SQL.Clear;
  qrBankAccount.SQL.Add(SqlBankAccount);
  Dados.StartTransaction(qrBankAccount);
  try
    qrBankAccount.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
    qrBankAccount.ParamByName('FkTipoContas').AsInteger := APk;
    qrBankAccount.ParamByName('FkBancos').AsInteger     := APkBank;
    qrBankAccount.ParamByName('FkAgencias').AsString    := APkAgency;
    qrBankAccount.ParamByName('FkContas').AsInteger     := APkAccount;
    if (not qrBankAccount.Active) then qrBankAccount.Open;
    Result.NumCheck := qrBankAccount.FieldByName('NUM_CHQ').AsInteger;
    Result.CodCta   := qrBankAccount.FieldByName('COD_CTA').AsString;
    Result.NumCtr   := qrBankAccount.FieldByName('NUM_CTR').AsString;
    Result.NumIniT  := qrBankAccount.FieldByName('NUM_INITL').AsInteger;
    Result.NumRem   := qrBankAccount.FieldByName('NUM_REM').AsInteger;
    Result.QtdCheck := qrBankAccount.FieldByName('PAG_NUM').AsInteger;
    Result.SldReal  := qrBankAccount.FieldByName('SLD_REAL').AsFloat;
    Result.SldPrev  := qrBankAccount.FieldByName('SLD_PRVST').AsFloat;
  finally
    if qrBankAccount.Active then qrBankAccount.Close;
    Dados.CommitTransaction(qrBankAccount);
  end;
end;

function TdmSysBcCx.GetAgencies(const AOwner: TPersistent; const APk: Integer;
  AAgencies: TAgencies): Boolean;
begin
  if Assigned(AAgencies) then
    AAgencies.Clear
  else
    AAgencies := TAgencies.Create(AOwner);
  if qrAgency.Active then qrAgency.Close;
  qrAgency.SQL.Clear;
  qrAgency.SQL.Add(SqlAgencies);
  Dados.StartTransaction(qrAgency);
  try
    qrAgency.ParamByName('FkBancos').AsInteger := APk;
    if not qrAgency.Active then qrAgency.Open;
    while (not qrAgency.Eof) do
    begin
      with AAgencies.Add do
      begin
        PkAgency  := qrAgency.FieldByName('PK_AGENCIAS').AsString;
        DscAgency := qrAgency.FieldByName('DSC_AGE').AsString;
        FkOwner   := qrAgency.FieldByName('FK_CADASTROS').AsInteger;
      end;
      qrAgency.Next;
    end;
  finally
    if qrAgency.Active then qrAgency.Close;
    Dados.CommitTransaction(qrAgency);
    Result := (AAgencies.Count > 0);
  end;
end;

function TdmSysBcCx.GetBank(const APk: Integer): TBank;
begin
  Result := TBank.Create;
  if (APk <= 0) then exit;
  if qrBank.Active then qrBank.Close;
  qrBank.SQL.Clear;
  qrBank.SQL.Add(SqlBank);
  Dados.StartTransaction(qrBank);
  try
    qrBank.ParamByName('PkBancos').AsInteger := APk;
    if (not qrBank.Active) then qrBank.Open;
    Result.PkBank   := qrBank.FieldByName('PK_BANCOS').AsInteger;
    Result.DscBank  := qrBank.FieldByName('DSC_BCO').AsString;
  finally
    if qrBank.Active then qrBank.Close;
    Dados.CommitTransaction(qrBank);
  end;
end;

function TdmSysBcCx.GetTypeAccount(APk: Integer): TTypeAccount;
begin
  Result := TTypeAccount.Create;
  if qrTypeAccount.Active then qrTypeAccount.Close;
  qrTypeAccount.SQL.Clear;
  qrTypeAccount.SQL.Add(SqlTypeAccount);
  Dados.StartTransaction(qrTypeAccount);
  try
    qrTypeAccount.ParamByName('PkTipoContas').AsInteger := APk;
    if not qrTypeAccount.Active then qrTypeAccount.Open;
    if (not qrTypeAccount.IsEmpty) then
    begin
      Result.PkTypeAccount := qrTypeAccount.FieldByName('PK_TIPO_CONTAS').AsInteger;
      Result.DscTAcc       := qrTypeAccount.FieldByName('DSC_TCTA').AsString;
      Result.FlagTAcc      := TAccountType(qrTypeAccount.FieldByName('FLAG_TCTA').AsInteger);
    end;
  finally
    if qrTypeAccount.Active then qrTypeAccount.Close;
    Dados.CommitTransaction(qrTypeAccount);
  end;
end;

function  TdmSysBcCx.LoadAccounts(ATypeAccountLan: Integer): TStrings;
var
  aItem: TAccount;
  aPks : ^string;
  aStr : string;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlAccounts1);
  qrSqlAux.SQL.Add(SqlAccounts2);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.AddObject('<Nenhum>', nil);
    while not qrSqlAux.Eof do
    begin
      aItem := TAccount.Create;
      with aItem.FkTypeAccount do
      begin
        FlagTAcc := TAccountType(qrSqlAux.FieldByName('FLAG_CTA').AsInteger);
        PkTypeAccount := qrSqlAux.FieldByName('PK_TIPO_CONTAS').AsInteger;
        if (qrSqlAux.FieldByName('PK_BANCOS').AsInteger > 0) then
        begin
          DscTAcc := qrSqlAux.FieldByName('DSC_BCO').AsString;
          aStr    := qrSqlAux.FieldByName('PK_BANCOS').AsString + '|' +
                     qrSqlAux.FieldByName('PK_AGENCIAS').AsString;
          GetMem(aPks, Length(aStr) + 1);
          aPks^   := aStr;
          Tag     := Integer(aPks);
        end
        else
          DscTAcc := qrSqlAux.FieldByName('DSC_TCTA').AsString;
      end;
      if (qrSqlAux.FieldByName('PK_BANCOS').AsInteger > 0) then
        aItem.DscAcc := qrSqlAux.FieldByName('DSC_AGE').AsString + ' - ' +
                        qrSqlAux.FieldByName('COD_CTA').AsString
      else
        aItem.DscAcc := qrSqlAux.FieldByName('DSC_CTA').AsString;
      aItem.PkContas := qrSqlAux.FieldByName('PK_CONTAS').AsInteger;
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysBcCx.LoadClassifications(ATypeLan: TTypeLan): TStrings;
var
  aItem: TClassification;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlClassificaCRDB);
  Dados.StartTransaction(qrSqlAux);
  try
    if qrSqlAux.Params.FindParam('FlagTCta') <> nil then
      qrSqlAux.Params.FindParam('FlagTCta').AsInteger := Integer(ATypeLan);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.AddObject('<Nenhum>', nil);
    while not qrSqlAux.Eof do
    begin
      aItem            := TClassification.Create;
      aItem.Pk         := qrSqlAux.FindField('R_PK_CLASSIFICACAO').AsInteger;
      aItem.DscClass   := qrSqlAux.FindField('R_DSC_CTA').AsString;
      aItem.MaskCta    := qrSqlAux.FindField('R_CLASS_CTA').AsString;
      aItem.FlagAnlSnt := Boolean(qrSqlAux.FindField('R_FLAG_CTAT').AsInteger);
      aItem.NivCta     := qrSqlAux.FindField('R_NIV_CTA').AsInteger;
      aItem.cbIndex    := Result.AddObject(aItem.DscClass + ' | ' +
                            aItem.MaskCta, aItem);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysBcCx.LoadFinalizations(AType: TTypeFinalization): TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlFinalizations);
  Dados.StartTransaction(qrSqlAux);
  try
    if (AType <> fnAll) then
      qrSqlAux.ParamByName('FlagTFin').AsInteger := Ord(AType)
    else
      qrSqlAux.ParamByName('FlagTFin').AsInteger := -1;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_MPGT').AsString,
        TObject(qrSqlAux.FieldByName('PK_FINALIZADORAS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysBcCx.LoadOwners(ATypeLan: TTypeLan): TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  case ATypeLan of
    tlDebit : qrSqlAux.SQL.Add(SqlSuppliers);
    tlCredit: qrSqlAux.SQL.Add(SqlCustomers);
  end;
  Dados.StartTransaction(qrSqlAux);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('RAZ_SOC').AsString,
        TObject(qrSqlAux.FieldByName('PK_CADASTROS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBcCx.LoadProducts: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlProducts);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrSqlAux.ParamByName('FlagAtv').AsInteger    := 1;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_PROD').AsString,
        TObject(qrSqlAux.FieldByName('PK_PRODUTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBcCx.LoadTipoDocumentos: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeDocuments);
  Dados.StartTransaction(qrSqlAux);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_TDOC').AsString,
        TObject(qrSqlAux.FieldByName('PK_TIPO_DOCUMENTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBcCx.LoadTypeOperations: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlAllOperations);
  Dados.StartTransaction(qrSqlAux);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_OPE').AsString,
        TObject(qrSqlAux.FieldByName('PK_OPERACOES_FINANCEIRAS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysBcCx.LoadPaymentWay: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlAllOperations);
  Dados.StartTransaction(qrSqlAux);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_MPGT').AsString,
        TObject(qrSqlAux.FieldByName('PK_FINALIZADORAS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

procedure TdmSysBcCx.SaveAccount(const APk: Integer; const AItem: TAccount;
  const AMode: TDBMode);
  function GetPkAccount: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGetPkContas);
    try
      Dados.StartTransaction(qrSqlAux);
      qrSqlAux.ParamByName('PkTipoContas').AsInteger := APk;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('R_PK_CONTAS').AsInteger;
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    except on E:Exception do
      begin
        if qrSqlAux.Active then qrSqlAux.Close;
        Dados.RollbackTransaction(qrSqlAux);
        raise Exception.Create('SaveAccount.GetPkTypeAccount:' + E.Message);
      end;
    end;
  end;
begin
  if (AItem = nil) or (not (AMode in [dbmInsert, dbmEdit, dbmDelete])) then exit;
  if qrAccount.Active then qrAccount.Close;
  qrAccount.SQL.Clear;
  if (AMode = dbmInsert) and (AItem.PkContas = 0) then
    AItem.PkContas := GetPkAccount;
  case AMode of
    dbmDelete: qrAccount.SQL.Add(SqlDelAccount);
    dbmInsert: qrAccount.SQL.Add(SqlInsAccount);
    dbmEdit  : qrAccount.SQL.Add(SqlUpdAccount);
  end;
  Dados.StartTransaction(qrAccount);
  try
    qrAccount.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
    qrAccount.ParamByName('FkTipoContas').AsInteger := APk;
    qrAccount.ParamByName('PkContas').AsInteger     := AItem.PkContas;
    if (qrAccount.Params.FindParam('DscCta') <> nil) then
      qrAccount.ParamByName('DscCta').AsString      := AItem.DscAcc;
    if (qrAccount.Params.FindParam('DtaAbr') <> nil) then
      qrAccount.ParamByName('DtaAbr').AsDate         := AItem.DtaAbr;
    if (qrAccount.Params.FindParam('DtaFch') <> nil) then
      qrAccount.ParamByName('DtaFch').AsDate         := AItem.DtaFch;
    qrAccount.ExecSQL;
    Dados.CommitTransaction(qrAccount);
  except on E:Exception do
    begin
      if qrAccount.Active then qrAccount.Close;
      Dados.RollbackTransaction(qrAccount);
      raise Exception.Create('SaveAccount:' + E.Message);
    end;
  end;
end;

procedure TdmSysBcCx.SaveBankAccount(const APk, APkBank, APkAccount: Integer;
  const APkAgency: string; const ABankAccount: TBankAccount; const AMode: TDBMode);
begin
  if (ABankAccount = nil) or (not (AMode in [dbmInsert, dbmEdit, dbmDelete])) or
     (APk = 0) or (APkAccount = 0) then exit;
  if qrBankAccount.Active then qrBankAccount.Close;
  qrBankAccount.SQL.Clear;
  case AMode of
    dbmDelete: qrBankAccount.SQL.Add(SqlDelBankAccount);
    dbmInsert: qrBankAccount.SQL.Add(SqlInsBankAccount);
    dbmEdit  : qrBankAccount.SQL.Add(SqlUpdBankAccount);
  end;
  Dados.StartTransaction(qrBankAccount);
  try
    qrBankAccount.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
    qrBankAccount.ParamByName('FkTipoContas').AsInteger := APk;
    qrBankAccount.ParamByName('FkBancos').AsInteger     := APkBank;
    qrBankAccount.ParamByName('FkAgencias').AsString    := APkAgency;
    qrBankAccount.ParamByName('FkContas').AsInteger     := APkAccount;
    if (qrBankAccount.Params.FindParam('CodCta') <> nil) then
      qrBankAccount.ParamByName('CodCta').AsString      := ABankAccount.CodCta;
    if (qrBankAccount.Params.FindParam('NumIniTl') <> nil) then
      qrBankAccount.ParamByName('NumIniTl').AsInteger   := ABankAccount.NumIniT;
    if (qrBankAccount.Params.FindParam('PagNum') <> nil) then
      qrBankAccount.ParamByName('PagNum').AsInteger     := ABankAccount.QtdCheck;
    if (qrBankAccount.Params.FindParam('NumChq') <> nil) then
      qrBankAccount.ParamByName('NumChq').AsInteger     := ABankAccount.NumCheck;
    if (qrBankAccount.Params.FindParam('NumRem') <> nil) then
      qrBankAccount.ParamByName('NumRem').AsInteger     := ABankAccount.NumRem;
    if (qrBankAccount.Params.FindParam('NumCtr') <> nil) then
      qrBankAccount.ParamByName('NumCtr').AsString      := ABankAccount.NumCtr;
    qrBankAccount.ExecSQL;
    Dados.CommitTransaction(qrBankAccount);
  except on E:Exception do
    begin
      if qrBankAccount.Active then qrBankAccount.Close;
      Dados.RollbackTransaction(qrBankAccount);
      raise Exception.Create('SaveBankAccount:' + E.Message);
    end;
  end;
end;

procedure TdmSysBcCx.SaveAgency(const APk: Integer; const AOldPk: string;
  const AAgency: TAgency; const AMode: TDBMode);
begin
  if (AAgency = nil) or (not (AMode in [dbmInsert, dbmEdit, dbmDelete])) then exit;
  if qrAgency.Active then qrAgency.Close;
  qrAgency.SQL.Clear;
  case AMode of
    dbmDelete: qrAgency.SQL.Add(SqlDelAgency);
    dbmInsert: qrAgency.SQL.Add(SqlInsAgency);
    dbmEdit  : qrAgency.SQL.Add(SqlUpdAgency);
  end;
  Dados.StartTransaction(qrAgency);
  try
    qrAgency.ParamByName('FkBancos').AsInteger  := APk;
    qrAgency.ParamByName('PkAgencias').AsString := AAgency.PkAgency;
    if (qrAgency.Params.FindParam('OldPkAgencias') <> nil) then
      qrAgency.ParamByName('OldPkAgencias').AsString := AOldPk;
    if (qrAgency.Params.FindParam('DscAge') <> nil) then
      qrAgency.ParamByName('DscAge').AsString     := AAgency.DscAgency;
    if (qrAgency.Params.FindParam('FkCadastros') <> nil) then
      qrAgency.ParamByName('FkCadastros').AsInteger   := AAgency.FkOwner;
    qrAgency.ExecSQL;
    Dados.CommitTransaction(qrAgency);
  except on E:Exception do
    begin
      if qrAgency.Active then qrAgency.Close;
      Dados.RollbackTransaction(qrAgency);
      raise Exception.Create('SaveAgency:' + E.Message);
    end;
  end;
end;

procedure TdmSysBcCx.SaveBank(const AOldPk: Integer; const ABank: TBank;
  const AMode: TDBMode);
begin
  if (ABank = nil) or (not (AMode in [dbmInsert, dbmEdit, dbmDelete])) then exit;
  if qrBank.Active then qrBank.Close;
  qrBank.SQL.Clear;
  case AMode of
    dbmDelete: qrBank.SQL.Add(SqlDelBank);
    dbmInsert: qrBank.SQL.Add(SqlInsBank);
    dbmEdit  : qrBank.SQL.Add(SqlUpdBank);
  end;
  Dados.StartTransaction(qrBank);
  try
    qrBank.ParamByName('PkBancos').AsInteger      := ABank.PkBank;
    if (qrBank.Params.FindParam('OldPkBancos') <> nil) then
      qrBank.ParamByName('OldPkBancos').AsInteger := AOldPk;
    if (qrBank.Params.FindParam('DscBco') <> nil) then
      qrBank.ParamByName('DscBco').AsString       := ABank.DscBank;
    qrBank.ExecSQL;
    Dados.CommitTransaction(qrBank);
  except on E:Exception do
    begin
      if qrBank.Active then qrBank.Close;
      Dados.RollbackTransaction(qrBank);
      raise Exception.Create('SaveBank:' + E.Message);
    end;
  end;
end;

procedure TdmSysBcCx.SaveFinanceOperation(AItem: TFinanceOperations;
  AMode: TDBMode; AList: TList);
  function GetPkFinanceOperation: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGetPkFinOpe);
    try
      Dados.StartTransaction(qrSqlAux);
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('R_PK_OPERACOES_FINANCEIRAS').AsInteger;
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    except on E:Exception do
      begin
        if qrSqlAux.Active then qrSqlAux.Close;
        Dados.RollbackTransaction(qrSqlAux);
        raise Exception.Create('SaveFinanceOperation.GetPkFinanceOperation:' + E.Message);
      end;
    end;
  end;
begin
  if (AItem = nil) or (not (AMode in [dbmInsert, dbmEdit, dbmDelete])) then exit;
  if qrFinanceOperation.Active then qrFinanceOperation.Close;
  qrFinanceOperation.SQL.Clear;
  case AMode of
    dbmDelete: qrFinanceOperation.SQL.Add(SqlDelOperations);
    dbmInsert: qrFinanceOperation.SQL.Add(SqlInsOperations);
    dbmEdit  : qrFinanceOperation.SQL.Add(SqlUpdOperations);
  end;
  if (aItem.PkOperation = 0) and (AMode = dbmInsert) then
    aItem.PkOperation := GetPkFinanceOperation;
  Dados.StartTransaction(qrFinanceOperation);
  try
    qrFinanceOperation.ParamByName('PkOperacoesFinanceiras').AsInteger := AItem.PkOperation;
    if (qrFinanceOperation.Params.FindParam('DscOpe') <> nil) then
      qrFinanceOperation.ParamByName('DscOpe').AsString := AItem.DscOpe;
    if (qrFinanceOperation.Params.FindParam('FlagEst') <> nil) then
      qrFinanceOperation.ParamByName('FlagEst').AsInteger := Ord(AItem.FlagEst);
    if (qrFinanceOperation.Params.FindParam('FlagTrf') <> nil) then
      qrFinanceOperation.ParamByName('FlagTrf').AsInteger := Ord(AItem.FlagTrf);
    if (qrFinanceOperation.Params.FindParam('FlagGSld') <> nil) then
      qrFinanceOperation.ParamByName('FlagGSld').AsInteger := Ord(AItem.FlagGSld);
    if (qrFinanceOperation.Params.FindParam('FlagBaixa') <> nil) then
      qrFinanceOperation.ParamByName('FlagBaixa').AsInteger := Ord(AItem.FlagGSld);
    qrFinanceOperation.ExecSQL;
    if qrFinanceOperation.Active then qrFinanceOperation.Close;
    if (AList <> nil) and (AList.Count > 0) then
      SaveDocumentList(AItem.PkOperation, AList);
    Dados.CommitTransaction(qrFinanceOperation);
  except on E:Exception do
    begin
      if qrFinanceOperation.Active then qrFinanceOperation.Close;
      Dados.RollbackTransaction(qrFinanceOperation);
      raise Exception.Create('SaveFinanceOperation:' + E.Message);
    end;
  end;
end;

procedure TdmSysBcCx.SaveDocumentList(APk: Integer; AList: TList);
var
  i: Integer;
  Data: TDataRow;
begin
  if (APk <= 0) or (AList = nil) or (AList.Count = 0) then exit;
  if qrFinanceOperation.Active then qrFinanceOperation.Close;
  qrFinanceOperation.SQL.Clear;
  qrFinanceOperation.SQL.Add(SqlDelOperDoc);
  try
    qrFinanceOperation.ParamByName('FkOperacoesFinanceiras').AsInteger := APk;
    qrFinanceOperation.ExecSQL;
  finally
    if qrFinanceOperation.Active then qrFinanceOperation.Close;
  end;
  qrFinanceOperation.SQL.Clear;
  qrFinanceOperation.SQL.Add(SqlInsOperDoc);
  for i := 0 to AList.Count - 1 do
  begin
    Data := TDataRow(AList.Items[i]);
    try
      if (Data <> nil) then
      begin
        qrFinanceOperation.ParamByName('FkOperacoesFinanceiras').AsInteger := APk;
        qrFinanceOperation.ParamByName('FkTipoDocumentos').AsInteger       :=
          Data.FieldByName['PK_TIPO_DOCUMENTOS'].AsInteger;
        qrFinanceOperation.ParamByName('FlagDef').AsInteger :=
          Data.FieldByName['FLAG_DEF'].AsInteger;
        qrFinanceOperation.ExecSQL;
      end;
    finally
      if qrFinanceOperation.Active then qrFinanceOperation.Close;
    end;
  end;
end;

procedure TdmSysBcCx.SaveTypeAccount(AItem: TTypeAccount; AMode: TDBMode);
  function GetPkTypeAccount: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGetPkTypeAcc);
    try
      Dados.StartTransaction(qrSqlAux);
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('R_PK_TIPO_CONTAS').AsInteger;
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    except on E:Exception do
      begin
        if qrSqlAux.Active then qrSqlAux.Close;
        Dados.RollbackTransaction(qrSqlAux);
        raise Exception.Create('SaveTypeAccount.GetPkTypeAccount:' + E.Message);
      end;
    end;
  end;
begin
  if (AItem = nil) or (not (AMode in [dbmInsert, dbmEdit, dbmDelete])) then exit;
  if qrTypeAccount.Active then qrTypeAccount.Close;
  qrTypeAccount.SQL.Clear;
  if (AMode = dbmInsert) and (AItem.PkTypeAccount = 0) then
    AItem.PkTypeAccount := GetPkTypeAccount;
  case AMode of
    dbmDelete: qrTypeAccount.SQL.Add(SqlDelTypeAccount);
    dbmInsert: qrTypeAccount.SQL.Add(SqlInsTypeAccount);
    dbmEdit  : qrTypeAccount.SQL.Add(SqlUpdTypeAccount);
  end;
  Dados.StartTransaction(qrTypeAccount);
  try
    qrTypeAccount.ParamByName('PkTipoContas').AsInteger := AItem.PkTypeAccount;
    if (qrTypeAccount.Params.FindParam('DscTCta') <> nil) then
      qrTypeAccount.ParamByName('DscTCta').AsString     := AItem.DscTAcc;
    if (qrTypeAccount.Params.FindParam('FlagTCta') <> nil) then
      qrTypeAccount.ParamByName('FlagTCta').AsInteger   := Ord(AItem.FlagTAcc);
    qrTypeAccount.ExecSQL;
    Dados.CommitTransaction(qrTypeAccount);
  except on E:Exception do
    begin
      if qrTypeAccount.Active then qrTypeAccount.Close;
      Dados.RollbackTransaction(qrTypeAccount);
      raise Exception.Create('SaveTypeAccount:' + E.Message);
    end;
  end;
end;

function TdmSysBcCx.GetTickets(APk: Integer): TDataRow;
begin
  with qrTicket do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlTicket);
    Dados.StartTransaction(qrTicket);
    try
      ParamByName('PkTickets').AsInteger := APk;
      if (not Active) then Open;
      Result := TDataRow.CreateFromDataSet(nil, qrTicket, True);
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrTicket);
    end;
  end
end;

procedure TdmSysBcCx.SetTickets(APk: Integer; const Value: TDataRow);
var
  aStr: string;
  function GetPkTicket: Integer;
  begin
    with qrSqlAux do
    begin
      if (Active) then Close;
      SQL.Clear;
      SQL.Add(SqlGetPkTicket);
      if (not Active) then Open;
      try
        Result := FieldByName('PK_TICKETS').AsInteger;
        if (Result = 0) then Result := 1;
      finally
        if (Active) then Close;
      end;
    end;
  end;
begin
  with qrTicket do
  begin
    if (Active) then Close;
    SQL.Clear;
    case TDBMode(APk) of
      dbmDelete: aStr := SqlDeleteTicket;
      dbmInsert: aStr := SqlInsertTicket;
      dbmEdit  : aStr := SqlUpdateTicket;
    end;
    if (Value.FieldByName['FK_CADASTROS'].AsInteger = 0) then
      aStr := StringReplace(aStr, ':FkCadastros', 'null', [rfReplaceAll]);
    if (Value.FieldByName['FK_PRODUTOS'].AsInteger = 0) then
      aStr := StringReplace(aStr, ':FkProdutos', 'null', [rfReplaceAll]);
    SQL.Add(aStr);
    Dados.StartTransaction(qrTicket);
    try
      if (Value.FieldByName['PK_TICKETS'].AsInteger = 0) then
        Value.FieldByName['PK_TICKETS'].AsInteger := GetPkTicket;
      ParamByName('PkTickets').AsInteger          := Value.FieldByName['PK_TICKETS'].AsInteger;
      if (Params.FindParam('FkCadastros')     <> nil) then
        ParamByName('FkCadastros').AsInteger      := Value.FieldByName['FK_CADASTROS'].AsInteger;
      if (Params.FindParam('FkProdutos')     <> nil) then
        ParamByName('FkProdutos').AsInteger       := Value.FieldByName['FK_PRODUTOS'].AsInteger;
      if (Params.FindParam('FkFinalizadoras') <> nil) then
        ParamByName('FkFinalizadoras').AsInteger  := Value.FieldByName['FK_FINALIZADORAS'].AsInteger;
      if (Params.FindParam('FkClassificacao') <> nil) then
        ParamByName('FkClassificacao').AsInteger  := Value.FieldByName['FK_CLASSIFICACAO'].AsInteger;
      if (Params.FindParam('DscTicket')       <> nil) then
        ParamByName('DscTicket').AsString         := Value.FieldByName['DSC_TICKET'].AsString;
      if (Params.FindParam('FlagTTicket')     <> nil) then
        ParamByName('FlagTTicket').AsInteger      := Value.FieldByName['FLAG_TTICKET'].AsInteger;
      ExecSQL;
      Dados.CommitTransaction(qrTicket);
    except on E:Exception do
      begin
        if (Active) then Close;
        Dados.RollbackTransaction(qrTicket);
        raise Exception.Create('SetTickets: Erro ao Salvar o registro' + NL +
          E.Message + NL + qrTicket.SQL.Text);
      end;
    end;
  end
end;

initialization
  Application.CreateForm(TdmSysBcCx, dmSysBcCx);
finalization
  if Assigned(dmSysBcCx) then dmSysBcCx.Free;
  dmSysBcCx := nil;

end.
