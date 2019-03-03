unit mSysConf;

{*************************************************************************}
{*                                                                       *}
{* Author: CSD Informatica Ltda.                                         *}
{* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
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
  SysUtils, Classes, ProcType, Forms, Windows, FMTBcd, DB, SqlExpr, Dialogs,
  TSysConfAux;

type
  TKeyLocal = record
    Unidade       : string;
    Material      : Integer;
    Grupo         : Integer;
    SubGrupo      : Integer;
    Secao         : Integer;
    Linha         : Integer;
    Similar       : Integer;
    Classificacao : Integer;
    Produto       : Integer;
    Bitola        : Integer;
    Almoxarifado  : Integer;
    TipoDesconto  : Integer;
    TipoComponente: Integer;
    TipoVariacao  : Integer;
    TabelaPreco   : Integer;
    TipoAcabamento: Integer;
    TipoReferencia: Integer;
    TipoProduto   : Integer;
    Fornecedor    : Integer;
    Insumo        : Integer;
    Imposto       : Integer;
    Composicao    : Integer;
    FaseProducao  : Integer;
    Engenharia    : Integer;
    Linguagem     : string;
    Componente    : Integer;
    Acabamento    : Integer;
  end;

  TdmSysConf = class(TDataModule)
    qrTypeFinish: TSQLQuery;
    Unidades: TSQLQuery;
    Precos: TSQLQuery;
    qrTypeCmpnt: TSQLQuery;
    qrTypeRef: TSQLQuery;
    Componente: TSQLQuery;
    Acabamento: TSQLQuery;
    Referencia: TSQLQuery;
    qrSqlAux: TSQLQuery;
    Produtos: TSQLQuery;
    Secoes: TSQLQuery;
    Grupos: TSQLQuery;
    Linhas: TSQLQuery;
    CopyStruct: TSQLQuery;
    Preco: TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
  private
    FPkTypeFinish: Integer;
    function  GetTypeFinish(APk: Integer): TFinishType;
    function  GetTypeReference(APk: Integer): TReferenceType;
    procedure SetTypeFinish(APk: Integer; const Value: TFinishType);
    procedure SetTypeReference(APk: Integer; const Value: TReferenceType);
    function GetTypeComponent(APk: Integer): TComponentType;
    procedure SetTypeComponent(APk: Integer; const Value: TComponentType);
    { Private declarations }
  public
    { Public declarations }
    property  PkTypeFinish               : Integer        read FPkTypeFinish    write FPkTypeFinish;
    property  TypeFinish   [APk: Integer]: TFinishType    read GetTypeFinish    write SetTypeFinish;
    property  TypeReference[APk: Integer]: TReferenceType read GetTypeReference write SetTypeReference;
    property  TypeComponent[APk: Integer]: TComponentType read GetTypeComponent write SetTypeComponent;
  end;

var
  dmSysConf: TdmSysConf;

implementation

uses Dado, CmmConst, Funcoes, ConfArqSql, ProcUtils;

{$R *.dfm}

procedure TdmSysConf.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if ((Components[i].InheritsFrom(TDataSet)) and
        (TDataSet(Components[i]).Active))      then
      TDataSet(Components[i]).Close;
  end;
end;

function TdmSysConf.GetTypeComponent(APk: Integer): TComponentType;
begin
  if (qrTypeCmpnt.Active) then qrTypeCmpnt.Close;
  qrTypeCmpnt.SQL.Clear;
  qrTypeCmpnt.SQL.Add(SqlTypeComponent);
  Dados.StartTransaction(qrTypeCmpnt);
  try
    qrTypeCmpnt.ParamByName('PkTipoComponentes').AsInteger := APk;
    if (not qrTypeCmpnt.Active) then qrTypeCmpnt.Open;
    Result             := TComponentType.Create;
    Result.PkComponent := qrTypeCmpnt.FindField('PK_TIPO_COMPONENTES').AsInteger;
    Result.DscTComp    := qrTypeCmpnt.FindField('DSC_TCOMP').AsString;
  finally
    if (qrTypeCmpnt.Active) then qrTypeCmpnt.Close;
    Dados.CommitTransaction(qrTypeCmpnt);
  end;
end;

function TdmSysConf.GetTypeFinish(APk: Integer): TFinishType;
begin
  if (qrTypeFinish.Active) then qrTypeFinish.Close;
  qrTypeFinish.SQL.Clear;
  qrTypeFinish.SQL.Add(SqlTypeFinish);
  Dados.StartTransaction(qrTypeFinish);
  try
    qrTypeFinish.ParamByName('PkTipoAcabamentos').AsInteger := APk;
    if (not qrTypeFinish.Active) then qrTypeFinish.Open;
    Result              := TFinishType.Create;
    Result.PkFinishType := qrTypeFinish.FindField('PK_TIPO_ACABAMENTOS').AsInteger;
    Result.DscAcbm      := qrTypeFinish.FindField('DSC_ACABM').AsString;
    Result.FlagTDsc     := TTypeDescription(qrTypeFinish.FindField('FLAG_TDSC').AsInteger);
  finally
    if (qrTypeFinish.Active) then qrTypeFinish.Close;
    Dados.CommitTransaction(qrTypeFinish);
  end;
end;

function TdmSysConf.GetTypeReference(APk: Integer): TReferenceType;
begin
  if (qrTypeRef.Active) then qrTypeRef.Close;
  qrTypeRef.SQL.Clear;
  qrTypeRef.SQL.Add(SqlTypeReference);
  Dados.StartTransaction(qrTypeRef);
  try
    qrTypeRef.ParamByName('FkTipoAcabamentos').AsInteger := FPkTypeFinish;
    qrTypeRef.ParamByName('PkTipoReferencias').AsInteger := APk;
    if (not qrTypeRef.Active) then qrTypeRef.Open;
    Result                 := TReferenceType.Create;
    Result.FkFinishType.PkFinishType := FPkTypeFinish;
    Result.PkReferenceType := qrTypeRef.FindField('PK_TIPO_REFERENCIAS').AsInteger;
    Result.DscRef          := qrTypeRef.FindField('DSC_REF').AsString;
    Result.StartRange      := qrTypeRef.FindField('FAIXA_CUST_INI').AsFloat;
    Result.EndRange        := qrTypeRef.FindField('FAIXA_CUST_FIN').AsFloat;
    Result.FlagTIns        := TMaterialMode(qrTypeRef.FindField('FLAG_TINS').AsInteger);
  finally
    if (qrTypeRef.Active) then qrTypeRef.Close;
    Dados.CommitTransaction(qrTypeRef);
  end;
end;

procedure TdmSysConf.SetTypeComponent(APk: Integer; const Value: TComponentType);
  function GetPkTypeComponent: Integer;
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenTypeComponent);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FindField('PK_TIPO_COMPONENTES').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
    end;
  end;
begin
  if (qrTypeCmpnt.Active) then qrTypeCmpnt.Close;
  qrTypeCmpnt.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTypeCmpnt.SQL.Add(SqlDeleteTComponent);
    dbmInsert: qrTypeCmpnt.SQL.Add(SqlInsertTComponent);
    dbmEdit  : qrTypeCmpnt.SQL.Add(SqlUpdateTComponent);
  end;
  Dados.StartTransaction(qrTypeCmpnt);
  try
    if (Value.PkComponent = 0) then
      Value.PkComponent := GetPkTypeComponent;
    qrTypeCmpnt.ParamByName('PkTipoComponentes').AsInteger := Value.PkComponent;
    if (qrTypeCmpnt.Params.FindParam('DscTComp') <> nil) then
      qrTypeCmpnt.ParamByName('DscTComp').AsString  := Value.DscTComp;
    qrTypeCmpnt.ExecSQL;
    Dados.CommitTransaction(qrTypeCmpnt);
  except on E:Exception do
    begin
      if (qrTypeCmpnt.Active) then qrTypeCmpnt.Close;
      Dados.RollbackTransaction(qrTypeCmpnt);
      raise Exception.Create('SetTypeFinish: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrTypeCmpnt.SQL.Text);
    end;
  end;
end;

procedure TdmSysConf.SetTypeFinish(APk: Integer; const Value: TFinishType);
  function GetPkTypeFinish: Integer;
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenTypeFinish);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FindField('PK_TIPO_ACABAMENTOS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
    end;
  end;
begin
  if (qrTypeFinish.Active) then qrTypeFinish.Close;
  qrTypeFinish.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTypeFinish.SQL.Add(SqlDeleteTypeFinish);
    dbmInsert: qrTypeFinish.SQL.Add(SqlInsertTypeFinish);
    dbmEdit  : qrTypeFinish.SQL.Add(SqlUpdateTypeFinish);
  end;
  Dados.StartTransaction(qrTypeFinish);
  try
    if (Value.PkFinishType = 0) then
      Value.PkFinishType := GetPkTypeFinish;
    qrTypeFinish.ParamByName('PkTipoAcabamentos').AsInteger := Value.PkFinishType;
    if (qrTypeFinish.Params.FindParam('DscAcabm') <> nil) then
      qrTypeFinish.ParamByName('DscAcabm').AsString  := Value.DscAcbm;
    if (qrTypeFinish.Params.FindParam('FlagTDsc') <> nil) then
      qrTypeFinish.ParamByName('FlagTDsc').AsInteger := Ord(Value.FlagTDsc);
    qrTypeFinish.ExecSQL;
    Dados.CommitTransaction(qrTypeFinish);
  except on E:Exception do
    begin
      if (qrTypeFinish.Active) then qrTypeFinish.Close;
      Dados.RollbackTransaction(qrTypeFinish);
      raise Exception.Create('SetTypeFinish: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrTypeFinish.SQL.Text);
    end;
  end;
end;

procedure TdmSysConf.SetTypeReference(APk: Integer; const Value: TReferenceType);
  function GetPkTypeReference: Integer;
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenTypeReference);
    try
      qrSqlAux.ParamByName('FkTipoAcabamentos').AsInteger := FPkTypeFinish;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FindField('PK_TIPO_REFERENCIAS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
    end;
  end;
begin
  if (qrTypeRef.Active) then qrTypeRef.Close;
  qrTypeRef.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTypeRef.SQL.Add(SqlDelTypeReference);
    dbmInsert: qrTypeRef.SQL.Add(SqlInsTypeReference);
    dbmEdit  : qrTypeRef.SQL.Add(SqlUpdTypeReference);
  end;
  Dados.StartTransaction(qrTypeRef);
  try
    if (Value.PkReferenceType = 0) then
      Value.PkReferenceType := GetPkTypeReference;
    qrTypeRef.ParamByName('FkTipoAcabamentos').AsInteger := Value.FkFinishType.PkFinishType;
    ShowMessage('Fk ==> ' + IntToStr(Value.FkFinishType.PkFinishType));
    qrTypeRef.ParamByName('PkTipoReferencias').AsInteger := Value.PkReferenceType;
    if (qrTypeRef.Params.FindParam('DscRef') <> nil) then
      qrTypeRef.ParamByName('DscRef').AsString      := Value.DscRef;
    if (qrTypeRef.Params.FindParam('FaixaCustIni') <> nil) then
      qrTypeRef.ParamByName('FaixaCustIni').AsFloat := Value.StartRange;
    if (qrTypeRef.Params.FindParam('FaixaCustFin') <> nil) then
      qrTypeRef.ParamByName('FaixaCustFin').AsFloat := Value.EndRange;
    if (qrTypeRef.Params.FindParam('FlagTDsc') <> nil) then
      qrTypeRef.ParamByName('FlagTDsc').AsInteger   := Ord(Value.FlagTIns);
    qrTypeRef.ExecSQL;
    Dados.CommitTransaction(qrTypeRef);
  except on E:Exception do
    begin
      if (qrTypeRef.Active) then qrTypeRef.Close;
      Dados.RollbackTransaction(qrTypeRef);
      raise Exception.Create('SetTypeReference: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrTypeRef.SQL.Text);
    end;
  end;
end;

initialization
  Application.CreateForm(TdmSysConf, dmSysConf);
finalization
  if Assigned(dmSysConf) then dmSysConf.Free;
  dmSysConf := nil;
end.
