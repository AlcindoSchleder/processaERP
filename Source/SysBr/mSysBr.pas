unit mSysBr;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2006 by Alcindo Schleder. All rights reserved.           *}
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

uses Windows, SysUtils, DB, Encryp, ProcType, FMTBcd, SqlExpr, Classes, Forms,
  TSysSrvAux, GridRow, ProcUtils, Dialogs, TSysBcCx;

type
  TdmSysBr = class(TDataModule)
    qrSquare: TSQLQuery;
    qrSqlAux: TSQLQuery;
    qrCategory: TSQLQuery;
    qrOperator: TSQLQuery;
    qrTypeOccurs: TSQLQuery;
    qrOccurrency: TSQLQuery;
    qrSqrTrack: TSQLQuery;
    qrParams: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    function GetParamsBr(Pk: Integer): TDataRow;
    procedure SetParamsBr(Pk: Integer; const Value: TDataRow);
    { Private declarations }
  public
    { Public declarations }
    function  LoadAccounts(AType: TAccountType): TStrings;
    function  LoadEmployee: TStrings;
    function  LoadHighWay: TStrings;
    function  LoadProducts: TStrings;
    function  LoadFinalizers: TStrings;
    function  LoadSquares: TStrings;
    function  LoadTypeOccurs: TStrings;
    function  LoadGroupMovements: TStrings;
    function  LoadOwners: TStrings;
    function  LoadTypeDocuments: TStrings;
    function  LoadTypeMovements(const FkTMov: Integer): TStrings;
    procedure InsertTOcrLink(const ADataRow: TDataRow);
    procedure DeleteTOcrLink(const ADataRow: TDataRow);
    procedure SaveCategory(AMode: TDBMode; ADataRow: TDataRow);
    procedure SaveOperator(AMode: TDBMode; ADataRow: TDataRow);
    procedure SaveSquare(AMode: TDBMode; ADataRow: TDataRow);
    procedure SaveTrack(AMode: TDBMode; ADataRow: TDataRow);
    procedure SaveTypeOccurs(AMode: TDBMode; ADataRow: TDataRow);
    property  ParamsBr[Pk: Integer]: TDataRow read GetParamsBr write SetParamsBr; 
  end;

var
  dmSysBr: TdmSysBr;

implementation

uses FuncoesDB, ArqSqlBr, Dado, CmmConst, SqlComm, ArqCnstBr, TypInfo;

{$R *.DFM}

procedure TdmSysBr.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

procedure TdmSysBr.DataModuleDestroy(Sender: TObject);
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

procedure TdmSysBr.DeleteTOcrLink(const ADataRow: TDataRow);
begin
  if (qrTypeOccurs.Active) then qrTypeOccurs.Close;
  qrTypeOccurs.SQL.Clear;
  qrTypeOccurs.SQL.Add(SqlDeleteTOccurs);
  Dados.StartTransaction(qrTypeOccurs);
  try
    qrTypeOccurs.ParamByName('FkEmpresas').AsInteger        := ADataRow.FieldByName['FK_EMPRESAS'].AsInteger;
    qrTypeOccurs.ParamByName('FkPracas').AsInteger          := ADataRow.FieldByName['FK_PRACAS'].AsInteger;
    qrTypeOccurs.ParamByName('FkTipoOcorrencias').AsInteger := ADataRow.FieldByName['PK_TIPO_OCORRENCIAS'].AsInteger;
    qrTypeOccurs.ExecSQL;
    Dados.CommitTransaction(qrTypeOccurs);
    if (qrTypeOccurs.Active) then qrTypeOccurs.Close;
  except on E:Exception do
    begin
      if (qrTypeOccurs.Active) then qrTypeOccurs.Close;
      Dados.RollbackTransaction(qrTypeOccurs);
      Dados.DisplayMessage('DeleteTOcrLink: Erro ao excluir registro' + NL + E.Message,
        hiError);
    end;
  end;
end;

function TdmSysBr.GetParamsBr(Pk: Integer): TDataRow;
begin
  if (qrParams.Active) then qrParams.Close;
  qrParams.SQL.Clear;
  qrParams.SQL.Add(SqlParamsBr);
  Dados.StartTransaction(qrParams);
  try
    qrParams.ParamByName('FkEmpresas').AsInteger := Pk;
    if (not qrParams.Active) then qrParams.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrParams, True);
  finally
    if (qrParams.Active) then qrParams.Close;
    Dados.CommitTransaction(qrParams);
  end;
end;

procedure TdmSysBr.InsertTOcrLink(const ADataRow: TDataRow);
begin
  if (qrTypeOccurs.Active) then qrTypeOccurs.Close;
  qrTypeOccurs.SQL.Clear;
  qrTypeOccurs.SQL.Add(SqlInsertTOccurs);
  Dados.StartTransaction(qrTypeOccurs);
  try
    qrTypeOccurs.ParamByName('FkEmpresas').AsInteger        := ADataRow.FieldByName['FK_EMPRESAS'].AsInteger;
    qrTypeOccurs.ParamByName('FkPracas').AsInteger          := ADataRow.FieldByName['FK_PRACAS'].AsInteger;
    qrTypeOccurs.ParamByName('FkTipoOcorrencias').AsInteger := ADataRow.FieldByName['PK_TIPO_OCORRENCIAS'].AsInteger;
    qrTypeOccurs.ExecSQL;
    Dados.CommitTransaction(qrTypeOccurs);
    if (qrTypeOccurs.Active) then qrTypeOccurs.Close;
  except on E:Exception do
    begin
      if (qrTypeOccurs.Active) then qrTypeOccurs.Close;
      Dados.RollbackTransaction(qrTypeOccurs);
      Dados.DisplayMessage('InsertTOcrLink: Erro ao incluir registro' + NL + E.Message,
        hiError);
    end;
  end;
end;

function TdmSysBr.LoadAccounts(AType: TAccountType): TStrings;
var
  aItem: TAccount;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeAccounts);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrSqlAux.ParamByName('FlagTCta').AsInteger   := Ord(AType);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      aItem               := TAccount.Create;
      aItem.DscAcc        := qrSqlAux.FieldByName('DSC_CTA').AsString;
      aItem.DtaAbr        := qrSqlAux.FieldByName('DTA_ABR').AsDateTime;
      aItem.DtaFch        := qrSqlAux.FieldByName('DTA_FCH').AsDateTime;
      aItem.DtaSld        := qrSqlAux.FieldByName('DTA_SLD').AsDateTime;
      aItem.FkCompany     := Dados.PkCompany;
      with aItem.FkTypeAccount do
      begin
        PkTypeAccount     := qrSqlAux.FieldByName('PK_TIPO_CONTAS').AsInteger;
        DscTAcc           := qrSqlAux.FieldByName('DSC_TCTA').AsString;
        FlagTAcc          := TAccountType(qrSqlAux.FieldByName('FLAG_TCTA').AsInteger);
      end;
      aItem.PkContas      := qrSqlAux.FieldByName('PK_CONTAS').AsInteger;
      aItem.SldAcc        := qrSqlAux.FieldByName('SLD_CTA').AsFloat;
      aItem.SldIni        := qrSqlAux.FieldByName('SLD_INI').AsFloat;
      aItem.SldPrev       := qrSqlAux.FieldByName('SLD_PREV').AsFloat;
      Result.AddObject(aItem.DscAcc, aItem);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadEmployee: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlEmployee);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FieldByName('RAZ_SOC').AsString,
        TObject(qrSqlAux.FieldByName('PK_CADASTROS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadFinalizers: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlFinalizers);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_MPGT').AsString,
        TObject(qrSqlAux.FieldByName('PK_FINALIZADORAS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadGroupMovements: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlGroupMovement);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_GMOV').AsString,
        TObject(qrSqlAux.FieldByName('PK_GRUPOS_MOVIMENTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadHighWay: TStrings;
var
  aItem: TRodovias;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlHighWay);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Params.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      aItem            := TRodovias.Create;
      aItem.PkRodovias := qrSqlAux.FieldByName('PK_RODOVIAS').AsInteger;
      aItem.DscRod     := qrSqlAux.FieldByName('DSC_ROD').AsString;
      aItem.KmIni      := qrSqlAux.FieldByName('KM_INI').AsFloat;
      aItem.KmFin      := qrSqlAux.FieldByName('KM_FIN').AsFloat;
      aItem.ExtTot     := aItem.KmFin - aItem.KmIni;
      aItem.Index      := Result.AddObject(aItem.DscRod, aItem);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadOwners: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlOwners);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FieldByName('RAZ_SOC').AsString,
        TObject(qrSqlAux.FieldByName('PK_CADASTROS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadProducts: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlProducts);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Params.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_PROD').AsString,
        TObject(qrSqlAux.FieldByName('PK_PRODUTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadSquares: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlSquares);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_PRC').AsString,
        TObject(qrSqlAux.FieldByName('PK_PRACAS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadTypeDocuments: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeDocument);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_TDOC').AsString,
        TObject(qrSqlAux.FieldByName('PK_TIPO_DOCUMENTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadTypeMovements(const FkTMov: Integer): TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeMovement);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkGruposMovimentos').AsInteger := FkTMov;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_TMOV').AsString,
        TObject(qrSqlAux.FieldByName('PK_TIPO_MOVIMENTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysBr.LoadTypeOccurs: TStrings;
var
  aItem: TTypeOccurs;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeOccurrence);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      aItem              := TTypeOccurs.Create;
      aItem.DscTOcr      := qrSqlAux.FieldByName('DSC_TOCR').AsString;
      aItem.DtaLRead     := qrSqlAux.FieldByName('DTA_LREAD').AsDateTime;
      aItem.FlagGFin     := Boolean(qrSqlAux.FieldByName('FLAG_GFIN').AsInteger);
      aItem.FlagTOcr     := TOccurrenceType(qrSqlAux.FieldByName('FLAG_TOCR').AsInteger);
      aItem.PkTypeOccurs := qrSqlAux.FieldByName('PK_TIPO_OCORRENCIAS').AsInteger;
      aItem.PrefixFile   := qrSqlAux.FieldByName('PREFIX_FILE').AsString;
      Result.AddObject(aItem.DscTOcr, aItem);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

procedure TdmSysBr.SaveCategory(AMode: TDBMode; ADataRow: TDataRow);
begin
  if (qrCategory.Active) then qrCategory.Close;
  qrCategory.SQL.Clear;
  case AMode of
    dbmDelete: qrCategory.SQL.Add(SqlDeleteCategory);
    dbmEdit  : qrCategory.SQL.Add(SqlUpdateCategory);
    dbmInsert: qrCategory.SQL.Add(SqlInsertCategory);
  end;
  Dados.StartTransaction(qrCategory);
  try
    if (qrCategory.Params.FindParam('FkProdutos') <> nil) then
      qrCategory.ParamByName('FkProdutos').AsInteger := ADataRow.FieldByName['FK_PRODUTOS'].AsInteger;
    qrCategory.ParamByName('FkEmpresas').AsInteger := ADataRow.FieldByName['FK_EMPRESAS'].AsInteger;
    qrCategory.ParamByName('FkPracas').AsInteger   := ADataRow.FieldByName['FK_PRACAS'].AsInteger;
    qrCategory.ParamByName('PkCategoriasProdutos').AsInteger :=
       ADataRow.FieldByName['PK_CATEGORIAS_PRODUTOS'].AsInteger;
    qrCategory.ExecSQL;
    Dados.CommitTransaction(qrCategory);
    if (qrCategory.Active) then qrTypeOccurs.Close;
  except on E:Exception do
    begin
      if (qrCategory.Active) then qrCategory.Close;
      Dados.RollbackTransaction(qrCategory);
      Dados.DisplayMessage('SaveCategory: Erro ao atualizar registro' + NL +
        E.Message + NL + qrCategory.SQL.Text, hiError);
    end;
  end;
end;

procedure TdmSysBr.SaveOperator(AMode: TDBMode; ADataRow: TDataRow);
begin
  if (qrOperator.Active) then qrOperator.Close;
  qrOperator.SQL.Clear;
  case AMode of
    dbmDelete: qrOperator.SQL.Add(SqlDeleteOperator);
    dbmEdit  : qrOperator.SQL.Add(SqlUpdateOperator);
    dbmInsert: qrOperator.SQL.Add(SqlInsertOperator);
  end;
  Dados.StartTransaction(qrOperator);
  try
    if (qrOperator.Params.FindParam('FkCadastros') <> nil) then
      qrOperator.ParamByName('FkCadastros').AsInteger := ADataRow.FieldByName['FK_CADASTROS'].AsInteger;
    qrOperator.ParamByName('FkEmpresas').AsInteger  := ADataRow.FieldByName['FK_EMPRESAS'].AsInteger;
    qrOperator.ParamByName('FkPracas').AsInteger    := ADataRow.FieldByName['FK_PRACAS'].AsInteger;
    qrOperator.ParamByName('PkPracasOperadores').AsInteger :=
       ADataRow.FieldByName['PK_PRACAS_OPERADORES'].AsInteger;
    qrOperator.ExecSQL;
    Dados.CommitTransaction(qrOperator);
    if (qrOperator.Active) then qrOperator.Close;
  except on E:Exception do
    begin
      if (qrOperator.Active) then qrOperator.Close;
      Dados.RollbackTransaction(qrOperator);
      Dados.DisplayMessage('SaveOperator: Erro ao atualizar registro' + NL +
        E.Message + NL + qrOperator.SQL.Text, hiError);
    end;
  end;
end;

procedure TdmSysBr.SaveSquare(AMode: TDBMode; ADataRow: TDataRow);
begin
  if (qrSquare.Active) then qrSquare.Close;
  qrSquare.SQL.Clear;
  case AMode of
    dbmDelete: qrSquare.SQL.Add(SqlDeleteSquare);
    dbmEdit  : qrSquare.SQL.Add(SqlUpdateSquare);
    dbmInsert: qrSquare.SQL.Add(SqlInsertSquare);
  end;
  Dados.StartTransaction(qrSquare);
  try
    qrSquare.ParamByName('FkEmpresas').AsInteger   := ADataRow.FieldByName['FK_EMPRESAS'].AsInteger;
    qrSquare.ParamByName('PkPracas').AsInteger     := ADataRow.FieldByName['PK_PRACAS'].AsInteger;
    if (qrSquare.Params.FindParam('FkRodovias') <> nil) then
      qrSquare.ParamByName('FkRodovias').AsInteger := ADataRow.FieldByName['FK_RODOVIAS'].AsInteger;
    if (qrSquare.Params.FindParam('DscPrc') <> nil) then
      qrSquare.ParamByName('DscPrc').AsString      := ADataRow.FieldByName['DSC_PRC'].AsString;
    if (qrSquare.Params.FindParam('PosTrc') <> nil) then
      qrSquare.ParamByName('PosTrc').AsFloat       := ADataRow.FieldByName['POS_TRC'].AsFloat;
    qrSquare.ExecSQL;
    Dados.CommitTransaction(qrSquare);
    if (qrSquare.Active) then qrTypeOccurs.Close;
  except on E:Exception do
    begin
      if (qrSquare.Active) then qrSquare.Close;
      Dados.RollbackTransaction(qrSquare);
      Dados.DisplayMessage('SaveSquare: Erro ao atualizar registro' + NL +
        E.Message + NL + qrSquare.SQL.Text, hiError);
    end;
  end;
end;

procedure TdmSysBr.SaveTrack(AMode: TDBMode; ADataRow: TDataRow);
begin
  if (qrSqrTrack.Active) then qrSqrTrack.Close;
  qrSqrTrack.SQL.Clear;
  case AMode of
    dbmDelete: qrSqrTrack.SQL.Add(SqlDeleteSqrTrack);
    dbmEdit  : qrSqrTrack.SQL.Add(SqlUpdateSqrTrack);
    dbmInsert: qrSqrTrack.SQL.Add(SqlInsertSqrTrack);
  end;
  Dados.StartTransaction(qrSqrTrack);
  try
    qrSqrTrack.ParamByName('FkEmpresas').AsInteger     := ADataRow.FieldByName['FK_EMPRESAS'].AsInteger;
    qrSqrTrack.ParamByName('FkPracas').AsInteger       := ADataRow.FieldByName['PK_PRACAS'].AsInteger;
    qrSqrTrack.ParamByName('PkPracasPistas').AsInteger := ADataRow.FieldByName['PK_PRACAS_PISTAS'].AsInteger;
    if (qrSqrTrack.Params.FindParam('DscPista') <> nil) then
      qrSqrTrack.ParamByName('DscPista').AsString      := ADataRow.FieldByName['DSC_PISTA'].AsString;
    if (qrSqrTrack.Params.FindParam('FlagDrt') <> nil) then
      qrSqrTrack.ParamByName('FlagDrt').AsFloat        := ADataRow.FieldByName['FLAG_DRT'].AsFloat;
    qrSqrTrack.ExecSQL;
    Dados.CommitTransaction(qrSqrTrack);
    if (qrSqrTrack.Active) then qrTypeOccurs.Close;
  except on E:Exception do
    begin
      if (qrSqrTrack.Active) then qrSqrTrack.Close;
      Dados.RollbackTransaction(qrSqrTrack);
      Dados.DisplayMessage('SaveTrack: Erro ao atualizar registro' + NL +
        E.Message + qrSqrTrack.SQL.Text, hiError);
    end;
  end;
end;

procedure TdmSysBr.SaveTypeOccurs(AMode: TDBMode; ADataRow: TDataRow);
begin
  if (qrTypeOccurs.Active) then qrTypeOccurs.Close;
  qrTypeOccurs.SQL.Clear;
  case AMode of
    dbmDelete: qrTypeOccurs.SQL.Add(SqlDeleteTypeOcc);
    dbmEdit  : qrTypeOccurs.SQL.Add(SqlUpdateTypeOcc);
    dbmInsert: qrTypeOccurs.SQL.Add(SqlInsertTypeOcc);
  end;
  Dados.StartTransaction(qrTypeOccurs);
  try
    qrTypeOccurs.ParamByName('PkTipoOcorrencias').AsInteger := ADataRow.FieldByName['PK_TIPO_OCORRENCIAS'].AsInteger;
    if (qrTypeOccurs.Params.FindParam('DscTOcr') <> nil) then
      qrTypeOccurs.ParamByName('DscTOcr').AsString    := ADataRow.FieldByName['DSC_TOCR'].AsString;
    if (qrTypeOccurs.Params.FindParam('FlagTOcr') <> nil) then
      qrTypeOccurs.ParamByName('FlagTOcr').AsInteger  := ADataRow.FieldByName['FLAG_TOCR'].AsInteger;
    if (qrTypeOccurs.Params.FindParam('FlagGFin') <> nil) then
      qrTypeOccurs.ParamByName('FlagGFin').AsInteger  := ADataRow.FieldByName['FLAG_GFIN'].AsInteger;
    if (qrTypeOccurs.Params.FindParam('PrefixFile') <> nil) then
      qrTypeOccurs.ParamByName('PrefixFile').AsString := ADataRow.FieldByName['PREFIX_FILE'].AsString;
    qrTypeOccurs.ExecSQL;
    Dados.CommitTransaction(qrTypeOccurs);
    if (qrTypeOccurs.Active) then qrTypeOccurs.Close;
  except on E:Exception do
    begin
      if (qrTypeOccurs.Active) then qrTypeOccurs.Close;
      Dados.RollbackTransaction(qrTypeOccurs);
      Dados.DisplayMessage('SaveTypeOccurs: Erro ao atualizar registro' + NL +
        E.Message + NL + qrTypeOccurs.SQL.Text, hiError);
    end;
  end;
end;

procedure TdmSysBr.SetParamsBr(Pk: Integer; const Value: TDataRow);
begin
  if (not (TDBMode(Pk) in UPDATE_MODE)) or (Value = nil) then exit;
  if (qrParams.Active) then qrParams.Close;
  qrParams.SQL.Clear;
  case TDBMode(Pk) of
    dbmDelete: qrParams.SQL.Add(SqlDeleteParamsBr);
    dbmEdit  : qrParams.SQL.Add(SqlUpdateParamsBr);
    dbmInsert: qrParams.SQL.Add(SqlInsertParamsBr);
  end;
  Dados.StartTransaction(qrParams);
  try
    qrParams.ParamByName('FkEmpresas').AsInteger := Value.FieldByName['FK_EMPRESAS'].AsInteger;
    if (qrParams.Params.FindParam('FkTipoDocumentos') <> nil) then
      qrParams.ParamByName('FkTipoDocumentos').AsInteger   := Value.FieldByName['FK_TIPO_DOCUMENTOS'].AsInteger;
    if (qrParams.Params.FindParam('FkCadastros') <> nil) then
      qrParams.ParamByName('FkCadastros').AsInteger        := Value.FieldByName['FK_CADASTROS'].AsInteger;
    if (qrParams.Params.FindParam('FkFinalizadoras') <> nil) then
      qrParams.ParamByName('FkFinalizadoras').AsInteger        := Value.FieldByName['FK_FINALIZADORAS'].AsInteger;
    if (qrParams.Params.FindParam('FkGruposMovimentos') <> nil) then
      qrParams.ParamByName('FkGruposMovimentos').AsInteger := Value.FieldByName['FK_GRUPOS_MOVIMENTOS'].AsInteger;
    if (qrParams.Params.FindParam('FkTipoMovimentos') <> nil) then
      qrParams.ParamByName('FkTipoMovimentos').AsInteger   := Value.FieldByName['FK_TIPO_MOVIMENTOS'].AsInteger;
    qrParams.ExecSQL;
    Dados.CommitTransaction(qrParams);
  except on E:Exception do
    begin
      if (qrParams.Active) then qrParams.Close;
      Dados.RollbackTransaction(qrParams);
      raise Exception.Create('SetParamsBr: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrParams.SQL.Text);
    end;
  end;
end;

initialization
  Application.CreateForm(TdmSysBr, dmSysBr);
finalization
  if Assigned(dmSysBr) then dmSysBr.Free;
  dmSysBr := nil;
end.
