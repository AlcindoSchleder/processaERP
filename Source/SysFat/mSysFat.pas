unit mSysFat;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 30/06/2006 - DD/MM/YYYY                                    *}
{* Modified :            - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
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

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Encryp, ProcType, FMTBcd, SqlExpr, TSysPedAux, TSysFatAux, GridRow,
  TSysCtbAux, TSysBcCx;

type
  TdmSysFat = class(TDataModule)
    qrCenterCost: TSQLQuery;
    qrSqlAux: TSQLQuery;
    qrDocumento: TSQLQuery;
    qrDuplicata: TSQLQuery;
    qrFinance: TSQLQuery;
    qrFinalization: TSQLQuery;
    qrCenary: TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    function  GetFinalizations(APk: Integer): TDataRow;
    function  GetClassification(APk: Integer): TClassification;
    procedure SetFinalizations(APk: Integer; const Value: TDataRow);
    procedure SetClassification(APk: Integer; const Value: TClassification);
    function GetCenary(APk: Integer): TDataRow;
    procedure SetCenary(APk: Integer; const Value: TDataRow);
    { Private declarations }
  public
    { Public declarations }
    function  GetFinishKeyFromDB(APk: Integer; AKey: Word;
                AType: TTypeFinalization): Boolean;
    function  LoadCompanies: TStrings;
    function  LoadFinalizers(AType: TTypeFinalization): TStrings;
    function  LoadAccountPlan(const AAccountNat: TAccountNat;
                AAccountID: TAccountType = atOther; All: Boolean = False): TStrings;
    property  Finalizations [APk: Integer]: TDataRow        read GetFinalizations  write SetFinalizations;
    property  Classification[APk: Integer]: TClassification read GetClassification write SetClassification;
    property  Cenary        [APk: Integer]: TDataRow        read GetCenary         write SetCenary;
  end;

var
  dmSysFat: TdmSysFat;

implementation

uses Funcoes, FuncoesDB, Dado, TypInfo, ArqSqlFat, ProcUtils, Variants;

{$R *.DFM}

procedure TdmSysFat.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

procedure TdmSysFat.DataModuleDestroy(Sender: TObject);
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

function TdmSysFat.GetCenary(APk: Integer): TDataRow;
begin
  if qrCenary.Active then qrCenary.Close;
  qrCenary.SQL.Clear;
  qrCenary.SQL.Add(SqlCenary);
  Dados.StartTransaction(qrCenary);
  try
    qrCenary.ParamByName('PkCenariosFinanceiros').AsInteger := APk;
    if not qrCenary.Active then qrCenary.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrCenary, True);
  finally
    if qrCenary.Active then qrCenary.Close;
    Dados.CommitTransaction(qrCenary);
  end;
end;

function TdmSysFat.GetClassification(APk: Integer): TClassification;
begin
  with qrFinance do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlFinAccount);
    Dados.StartTransaction(qrFinance);
    try
      ParamByName('PkFinanceiroContas').AsInteger := APk;
      if (not Active) then Open;
      Result := TClassification.Create;
      with Result do
      begin
        DscClass         := FieldByName('DSC_CTA').AsString;
        FkFinanceAccount := FieldByName('FK_FINANCEIRO_CONTAS').AsInteger;
        FkAccountPlan    := FieldByName('FK_PLANO_CONTAS').AsInteger;
        FlagAnlSnt       := Boolean(FieldByName('FLAG_ANL_SNT').AsInteger);
        FlagID           := TAccountType(FieldByName('FLAG_ID').AsInteger);
        FlagTCta         := TAccountNat(FieldByName('FLAG_TCTA').AsInteger);
        MaskCta          := FieldByName('MASK_CTA').AsString;
        NivCta           := FieldByName('GRAU_CTA').AsInteger;
        SeqCta           := FieldByName('SEQ_CTA').AsInteger;
        Pk               := FieldByName('PK_FINANCEIRO_CONTAS').AsInteger;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(qrFinance);
    end;
  end;
end;

function TdmSysFat.GetFinalizations(APk: Integer): TDataRow;
begin
  if qrFinalization.Active then qrFinalization.Close;
  qrFinalization.SQL.Clear;
  qrFinalization.SQL.Add(SqlFinalization);
  Dados.StartTransaction(qrFinalization);
  try
    qrFinalization.ParamByName('PkFinalizadoras').AsInteger := APk;
    if not qrFinalization.Active then qrFinalization.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrFinalization, True);
  finally
    if qrFinalization.Active then qrFinalization.Close;
    Dados.CommitTransaction(qrFinalization);
  end;
end;

function TdmSysFat.GetFinishKeyFromDB(APk: Integer; AKey: Word;
  AType: TTypeFinalization): Boolean;
const
  FINALIZATIONS = '   and FLAG_TFIN        <> :FlagTFin';
  OPERATIONS    = '   and FLAG_TFIN         = :FlagTFin';
begin
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlFinishKeyCode);
  if (AType < fnOperation) then
    qrSqlAux.SQL.Add(FINALIZATIONS)
  else
    qrSqlAux.SQL.Add(OPERATIONS);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('PkFinalizadoras').AsInteger := APk;
    qrSqlAux.ParamByName('CodTecla').AsInteger        := AKey;
    qrSqlAux.ParamByName('FlagTFin').AsInteger        := Ord(fnOperation);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result := (qrSqlAux.FieldByName('COD_TECLA').AsInteger > 0);
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysFat.LoadAccountPlan(const AAccountNat: TAccountNat;
  AAccountID: TAccountType = atOther; All: Boolean = False): TStrings;
var
  aObj: TClassification;
begin
  Result := TStringList.Create;
  with qrSqlAux do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlCtbAccounts);
    Dados.StartTransaction(qrSqlAux);
    try
      if (AAccountID = atOther) or (All) then
        ParamByName('FlagID').AsInteger   := -1
      else
        ParamByName('FlagID').AsInteger   := Ord(AAccountID);
      if (All) then
        ParamByName('FlagTCta').AsInteger := -1
      else
        ParamByName('FlagTCta').AsInteger := Ord(AAccountNat);
      if not Active then Open;
      Result.Add('<Nenhum>');
      while not (Eof) do
      begin
        aObj               := TClassification.Create;
        aObj.Pk            := FieldByName('R_PK_PLANO_CONTAS').AsInteger;
        aObj.FkAccountPlan := FieldByName('R_FK_PLANO_CONTAS').AsInteger;
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

function TdmSysFat.LoadCompanies: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlCompanies);
  Dados.StartTransaction(qrSqlAux);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhuma>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('RAZ_SOC').AsString,
        TObject(qrSqlAux.FieldByName('PK_EMPRESAS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysFat.LoadFinalizers(AType: TTypeFinalization): TStrings;
begin
  Result := TStringList.Create;
  if qrFinalization.Active then qrFinalization.Close;
  qrFinalization.SQL.Clear;
  qrFinalization.SQL.Add(SqlFinalizers);
  Dados.StartTransaction(qrFinalization);
  try
    qrFinalization.ParamByName('FlagTFin').AsInteger := -1;
    if (AType = fnOperation) then
      qrFinalization.ParamByName('FlagTFin').AsInteger := Ord(AType);
    if not qrFinalization.Active then qrFinalization.Open;
    Result.Add('<Nenhum>');
    while not (qrFinalization.Eof) do
    begin
      Result.AddObject(qrFinalization.FieldByName('DSC_MPGT').AsString,
        TObject(qrFinalization.FieldByName('PK_FINALIZADORAS').AsInteger));
      qrFinalization.Next;
    end;
  finally
    if qrFinalization.Active then qrFinalization.Close;
    Dados.CommitTransaction(qrFinalization);
  end;
end;

procedure TdmSysFat.SetCenary(APk: Integer; const Value: TDataRow);
  function GetPkCenary: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkCenary);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_CENARIOS_FINANCEIROS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrCenary.Active then qrCenary.Close;
  qrCenary.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrCenary.SQL.Add(SqlDeleteCenary);
    dbmEdit  : qrCenary.SQL.Add(SqlUpdateCenary);
    dbmInsert: qrCenary.SQL.Add(SqlInsertCenary);
  end;
  Dados.StartTransaction(qrCenary);
  try
    if (Value.FieldByName['PK_CENARIOS_FINANCEIROS'].AsInteger = 0) then
      Value.FieldByName['PK_CENARIOS_FINANCEIROS'].AsInteger  := GetPkCenary;
    qrCenary.ParamByName('PkCenariosFinanceiros').AsInteger   := Value.FieldByName['PK_CENARIOS_FINANCEIROS'].AsInteger;
    if (qrCenary.Params.FindParam('DscCen') <> nil) then
      qrCenary.ParamByName('DscCen').AsString            := Value.FieldByName['DSC_CEN'].AsString;
    if (qrCenary.Params.FindParam('FkEmpresas') <> nil) then
      qrCenary.ParamByName('FkEmpresas').AsInteger       := Dados.Parametros.soActiveCompany;
    if (qrCenary.Params.FindParam('FlagTpCen') <> nil) then
      qrCenary.ParamByName('FlagTpCen').AsInteger        := Value.FieldByName['FLAG_TPCEN'].AsInteger;
    qrCenary.ExecSQL;
    Dados.CommitTransaction(qrCenary);
  except on E:Exception do
    begin
      if qrCenary.Active then qrCenary.Close;
      Dados.RollbackTransaction(qrCenary);
      raise Exception.Create('SetCenary: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrCenary.SQL.Text);
    end;
  end;
end;

procedure TdmSysFat.SetClassification(APk: Integer; const Value: TClassification);
var
  aStrAux: string;
  aParams: TDataRow;
begin
  if qrFinance.Active then qrFinance.Close;
  qrFinance.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: aStrAux := SqlDeleteClass;
    dbmEdit  : aStrAux := SqlUpdateClass;
    dbmInsert: aStrAux := SqlInsertClass;
  end;
  if (Value.FkAccountPlan = 0) then
    aStrAux := StringReplace(aStrAux, ':FkPlanoContas', 'null', []);
  qrFinance.SQL.Add(aStrAux);
  Dados.StartTransaction(qrFinance);
  try
    with qrFinance, Value do
    begin
      if (Pk = 0) then
      begin
        aParams := TDataRow.Create(nil);
        try
          aParams.AddAs('FkFinanceiroContas', 0, ftInteger, SizeOf(Integer));
          aParams.AddAs('SeqCta', 0, ftInteger, SizeOf(Integer));
          Pk := Dados.GetPk(SqlGetPkFinAcc, aParams).FieldByName['R_PK_FINANCEIRO_CONTAS'].AsInteger;
        finally
          FreeAndNil(aParams);
        end;
      end;
      ParamByName('PkFinanceiroContas').AsInteger   := Pk;
      if (NivCta = 1) or (FkFinanceAccount = 0) then
        FkFinanceAccount := Pk;
      if (Params.FindParam('FkFinanceiroContas') <> nil) then
        ParamByName('FkFinanceiroContas').AsInteger := FkFinanceAccount;
      if (Params.FindParam('DscCta')             <> nil) then
        ParamByName('DscCta').AsString              := DscClass;
      if (Params.FindParam('FkPlanoContas')      <> nil) then
        ParamByName('FkPlanoContas').AsInteger      := FkAccountPlan;
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
    qrFinance.ExecSQL;
    Dados.CommitTransaction(qrFinance);
  except on E:Exception do
    begin
      if qrFinance.Active then qrFinance.Close;
      Dados.RollbackTransaction(qrFinance);
      raise Exception.Create('SetClassification: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrFinance.SQL.Text);
    end;
  end;
end;

procedure TdmSysFat.SetFinalizations(APk: Integer; const Value: TDataRow);
  function GetPkFinalization: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkFinish);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_FINALIZADORAS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrFinalization.Active then qrFinalization.Close;
  qrFinalization.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrFinalization.SQL.Add(SqlDeleteFinish);
    dbmEdit  : qrFinalization.SQL.Add(SqlUpdateFinish);
    dbmInsert: qrFinalization.SQL.Add(SqlInsertFinish);
  end;
  Dados.StartTransaction(qrFinalization);
  try
    if (qrFinalization.Params.FindParam('FkFinalizadorasDB') <> nil) then
      if Value.FieldByName['FK_FINALIZADORAS__DB'].AsInteger > 0 then
        qrFinalization.ParamByName('FkFinalizadorasDB').AsInteger :=
           Value.FieldByName['FK_FINALIZADORAS__DB'].AsInteger
      else
        qrFinalization.SQL.Text := StringReplace(qrFinalization.SQL.Text,
          ':FkFinalizadorasDB', 'null', [rfReplaceAll]);
    if (qrFinalization.Params.FindParam('FkFinalizadorasCR') <> nil) then
      if Value.FieldByName['FK_FINALIZADORAS__CR'].AsInteger > 0 then
        qrFinalization.ParamByName('FkFinalizadorasCR').AsInteger :=
          Value.FieldByName['FK_FINALIZADORAS__CR'].AsInteger
      else
        qrFinalization.SQL.Text := StringReplace(qrFinalization.SQL.Text,
          ':FkFinalizadorasCR', 'null', [rfReplaceAll]);
    if (Value.FieldByName['PK_FINALIZADORAS'].AsInteger = 0) then
      Value.FieldByName['PK_FINALIZADORAS'].AsInteger := GetPkFinalization;
    qrFinalization.ParamByName('PkFinalizadoras').AsInteger   := Value.FieldByName['PK_FINALIZADORAS'].AsInteger;
    if (qrFinalization.Params.FindParam('DscMpgt') <> nil) then
      qrFinalization.ParamByName('DscMpgt').AsString           := Value.FieldByName['DSC_MPGT'].AsString;
    if (qrFinalization.Params.FindParam('CodTecla') <> nil) then
      qrFinalization.ParamByName('CodTecla').AsInteger         := Value.FieldByName['COD_TECLA'].AsInteger;
    if (qrFinalization.Params.FindParam('CodTecla') <> nil) then
      qrFinalization.ParamByName('CodTecla').AsInteger         := Value.FieldByName['COD_TECLA'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagTrc') <> nil) then
      qrFinalization.ParamByName('FlagTrc').AsInteger          := Value.FieldByName['FLAG_TRC'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagCli') <> nil) then
      qrFinalization.ParamByName('FlagCli').AsInteger          := Value.FieldByName['FLAG_CLI'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagBnc') <> nil) then
      qrFinalization.ParamByName('FlagBnc').AsInteger          := Value.FieldByName['FLAG_BNC'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagTef') <> nil) then
      qrFinalization.ParamByName('FlagTef').AsInteger          := Value.FieldByName['FLAG_TEF'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagTFin') <> nil) then
      qrFinalization.ParamByName('FlagTFin').AsInteger         := Value.FieldByName['FLAG_TFIN'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagBaixa') <> nil) then
      qrFinalization.ParamByName('FlagBaixa').AsInteger        := Value.FieldByName['FLAG_BAIXA'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagTrf') <> nil) then
      qrFinalization.ParamByName('FlagTrf').AsInteger          := Value.FieldByName['FLAG_TRF'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagEst') <> nil) then
      qrFinalization.ParamByName('FlagEst').AsInteger          := Value.FieldByName['FLAG_EST'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagGSldCta') <> nil) then
      qrFinalization.ParamByName('FlagGSldCta').AsInteger      := Value.FieldByName['FLAG_GSLD_CTA'].AsInteger;
    if (qrFinalization.Params.FindParam('FlagGSldFin') <> nil) then
      qrFinalization.ParamByName('FlagGSldFin').AsInteger      := Value.FieldByName['FLAG_GSLD_FIN'].AsInteger;
    qrFinalization.ExecSQL;
    Dados.CommitTransaction(qrFinalization);
  except on E:Exception do
    begin
      if qrFinalization.Active then qrFinalization.Close;
      Dados.RollbackTransaction(qrFinalization);
      raise Exception.Create('SetTypeOrder: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrFinalization.SQL.Text);
    end;
  end;
end;

initialization
  Application.CreateForm(TdmSysFat, dmSysFat);
finalization
  if Assigned(dmSysFat) then dmSysFat.Free;
  dmSysFat := nil;
end.
