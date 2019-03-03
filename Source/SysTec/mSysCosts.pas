unit mSysCosts;

{*************************************************************************}
{*                                                                       *}
{* Author: CSD Informatica Ltda.                                         *}
{* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
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
  SysUtils, Classes, DBClient, IBDatabase, DB, IBCustomDataSet, IBQuery,
  Provider, ProcType, Forms, Windows;

type
  TKeyLocal = record
    Unidade       : Integer;
    Grupo         : Integer;
    SubGrupo      : Integer;
    Secao         : Integer;
    Fornecedor    : Integer;
    Servico       : Integer;
    FaseProducao  : Integer;
    Linguagem     : string;
  end;

  TdmSysCosts = class(TDataModule)
    pAccess: TDataSetProvider;
    dsAccess: TIBQuery;
    TrMain: TIBTransaction;
    Secoes: TIBQuery;
    Unidades: TIBQuery;
    Grupos: TIBQuery;
    SubGrupos: TIBQuery;
    Fornecedores: TIBQuery;
    TrCosts: TIBTransaction;
    QueryAux: TIBQuery;
    pRecord: TDataSetProvider;
    dsRecord: TIBQuery;
    trRecord: TIBTransaction;
    TipoFases: TIBQuery;
    Servicos: TIBQuery;
    Servico: TClientDataSet;
    TFaseProd: TClientDataSet;
    TipoOper: TClientDataSet;
    Maquina: TClientDataSet;
    trAux: TIBTransaction;
    procedure DataModuleDestroy(Sender: TObject);
    procedure ReconcileErrorHandler(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure DataModuleCreate(Sender: TObject);
    procedure SubGruposBeforeOpen(DataSet: TDataSet);
    procedure dsAccessAfterClose(DataSet: TDataSet);
    procedure dsRecordAfterClose(DataSet: TDataSet);
    procedure ServicoAfterPost(DataSet: TDataSet);
    procedure ServicoAfterScroll(DataSet: TDataSet);
    procedure ServicoAfterOpen(DataSet: TDataSet);
    procedure ServicoNewRecord(DataSet: TDataSet);
    procedure TFaseProdNewRecord(DataSet: TDataSet);
    procedure TipoOperNewRecord(DataSet: TDataSet);
    procedure MaquinaNewRecord(DataSet: TDataSet);
    procedure MaquinaAfterPost(DataSet: TDataSet);
    procedure MaquinaAfterOpen(DataSet: TDataSet);
    procedure MaquinaAfterScroll(DataSet: TDataSet);
    procedure GruposBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FFieldChange: Boolean;
    KeyLocal    : TKeyLocal;
    ScrollKey   : TKeyLocal;
    procedure DataSetGlobalChange(Sender: TField);
    procedure CalcReferenceChange(Sender: TField);
  public
    { Public declarations }
    AFindRecord  : Boolean;
    ADtaIni      : TDateTime;
    ADtaFin      : TDateTime;
    MethodWithPar: TScrollTabPar;
    MethodWOutPar: TScrollTab;
    function  LocalizaGrupo           : Boolean;
    function  LocalizaSubGrupo        : Boolean;
    procedure ConfigFiles;
  end;

var
  dmSysCosts: TdmSysCosts;

implementation

uses Dado, RecErr, CmmConst, Math, Funcoes, ArqSql, FuncoesDB;

{$R *.dfm}

procedure TdmSysCosts.ConfigFiles;
begin
  dsAccess.DataBase       := Dados.Conexao;
end;

procedure TdmSysCosts.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if ((Components[i].InheritsFrom(TDataSet)) and
        (TDataSet(Components[i]).Active))      then
      TDataSet(Components[i]).Close;
    if (Components[i].InheritsFrom(TIBTransaction))  and
       (TIBTransaction(Components[i]).InTransaction) then
      TIBTransaction(Components[i]).Commit;
  end;
  dsAccess.DataBase    := nil;
  FillChar(KeyLocal, SizeOf(KeyLocal), 0);
  FillChar(ScrollKey, SizeOf(ScrollKey), 0);
end;

procedure TdmSysCosts.ReconcileErrorHandler(
  DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  Action := HandleReconcileError(DataSet, UpdateKind, E);
end;

procedure TdmSysCosts.DataSetGlobalChange(Sender: TField);
begin
  FFieldChange := True;
  if (Sender.DataSet.State in [dsInsert, dsEdit]) and
      Assigned(Sender.DataSet.AfterScroll)        then
    Sender.DataSet.AfterScroll(Sender.DataSet);
end;

procedure TdmSysCosts.DataModuleCreate(Sender: TObject);
begin
  ADtaIni := 0;
  ADtaFin := 0;
  FillChar(KeyLocal, SizeOf(KeyLocal), 0);
  FillChar(ScrollKey, SizeOf(ScrollKey), 0);
end;

function  TdmSysCosts.LocalizaGrupo: Boolean;
begin
  if Grupos.Active then
  begin
    Grupos.Close;
    Grupos.Open;
  end;
  Result := Grupos.Active and Grupos.IsEmpty;
end;

function  TdmSysCosts.LocalizaSubGrupo: Boolean;
begin
  if SubGrupos.Active then
  begin
    SubGrupos.Close;
    SubGrupos.Open;
  end;
  Result := SubGrupos.Active and SubGrupos.IsEmpty;
end;

procedure TdmSysCosts.SubGruposBeforeOpen(DataSet: TDataSet);
begin
  if (SubGrupos.ParamCount > 0) and Secoes.Active and Grupos.Active then
  begin
    SubGrupos.ParamByName('FkSecoes').AsInteger := Secoes.FieldByName('PK_SECOES').AsInteger;
    SubGrupos.ParamByName('FkGrupos').AsInteger := Grupos.FieldByName('PK_GRUPOS').AsInteger;
  end;
end;

procedure TdmSysCosts.dsAccessAfterClose(DataSet: TDataSet);
begin
  if TrMain.InTransaction then TrMain.Commit;
end;

procedure TdmSysCosts.dsRecordAfterClose(DataSet: TDataSet);
begin
  if TrRecord.InTransaction then TrRecord.Commit;
end;

procedure TdmSysCosts.ServicoAfterPost(DataSet: TDataSet);
begin
  KeyLocal.Secao    := Servico.FieldByName('FK_SECOES').AsInteger;
  KeyLocal.Grupo    := Servico.FieldByName('FK_GRUPOS').AsInteger;
  KeyLocal.SubGrupo := Servico.FieldByName('FK_SUBGRUPOS').AsInteger;
  KeyLocal.Unidade  := Servico.FieldByName('FK_UNIDADES').AsInteger;
end;

procedure TdmSysCosts.ServicoAfterScroll(DataSet: TDataSet);
begin
  KeyLocal.Servico  := Servico.FieldByName('PK_SERVICOS_IND').AsInteger;
  if Servico.FieldByName('FK_SECOES').AsInteger <> ScrollKey.Secao then
    LocalizaGrupo;
  if (Servico.FieldByName('FK_SECOES').AsInteger <> ScrollKey.Secao) or
     (Servico.FieldByName('FK_GRUPOS').AsInteger <> ScrollKey.Grupo) then
    LocalizaSubGrupo;
  ScrollKey.Secao      := Servico.FieldByName('FK_SECOES').AsInteger;
  ScrollKey.Grupo      := Servico.FieldByName('FK_GRUPOS').AsInteger;
end;

procedure TdmSysCosts.ServicoAfterOpen(DataSet: TDataSet);
begin
  Servico.FieldByName('FK_SECOES').OnChange := DataSetGlobalChange;
  Servico.FieldByName('FK_GRUPOS').OnChange := DataSetGlobalChange;
  Servico.FieldByName('FK_SUBGRUPOS').OnChange := CalcReferenceChange;
end;

procedure TdmSysCosts.ServicoNewRecord(DataSet: TDataSet);
begin
  try
    Servico.FieldByName('FK_SECOES').AsInteger       := KeyLocal.Secao;
    Servico.FieldByName('FK_GRUPOS').AsInteger       := KeyLocal.Grupo;
    Servico.FieldByName('FK_UNIDADES').AsInteger     := KeyLocal.Unidade;
    Servico.FieldByName('PK_SERVICOS_IND').AsInteger := ZEROINT;
    Servico.FieldByName('QTD_UNI').AsFloat           := ZEROFLOAT;
    Servico.FieldByName('VLR_UNI').AsFloat           := ZEROFLOAT;
    Servico.FieldByName('FLAG_ATV').AsInteger        := FLAG_SIM;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysCosts.TFaseProdNewRecord(DataSet: TDataSet);
begin
  try
    TFaseProd.FieldByName('PK_TIPO_FASES_PRODUCAO').AsInteger := ZEROINT;
    TFaseProd.FieldByName('NIV_FASE').AsInteger               := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysCosts.TipoOperNewRecord(DataSet: TDataSet);
begin
  try
    TipoOper.FieldByName('PK_TIPO_OPERACOES').AsInteger := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysCosts.MaquinaNewRecord(DataSet: TDataSet);
begin
  try
    Maquina.FieldByName('PK_MAQUINAS').AsInteger  := ZEROINT;
    Maquina.FieldByName('POT_MAQ').AsFloat        := ZEROFLOAT;
    Maquina.FieldByName('NUM_OPE').AsInteger      := ZEROINT;
    Maquina.FieldByName('TMMP_MAQ').AsInteger     := ZEROINT;
    Maquina.FieldByName('MTBF_MAQ').AsInteger     := ZEROINT;
    Maquina.FieldByName('FK_SECOES').AsInteger    := KeyLocal.Secao;
    Maquina.FieldByName('FK_GRUPOS').AsInteger    := KeyLocal.Grupo;
    Maquina.FieldByName('FK_SUBGRUPOS').AsInteger := KeyLocal.SubGrupo;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysCosts.MaquinaAfterOpen(DataSet: TDataSet);
begin
  ScrollKey.Secao := 0;
  ScrollKey.Grupo := 0;
  Maquina.FieldByName('FK_SECOES').OnChange    := DataSetGlobalChange;
  Maquina.FieldByName('FK_GRUPOS').OnChange    := DataSetGlobalChange;
  Maquina.FieldByName('FK_SUBGRUPOS').OnChange := CalcReferenceChange;
end;

procedure TdmSysCosts.MaquinaAfterPost(DataSet: TDataSet);
begin
  KeyLocal.Secao    := Maquina.FieldByName('FK_SECOES').AsInteger;
  KeyLocal.Grupo    := Maquina.FieldByName('FK_GRUPOS').AsInteger;
  KeyLocal.SubGrupo := Maquina.FieldByName('FK_SUBGRUPOS').AsInteger;
end;

procedure TdmSysCosts.CalcReferenceChange(Sender: TField);
begin
  if (not Sender.DataSet.Active)                        and
     (not (Sender.DataSet.State in [dsInsert, dsEdit])) and
     (Sender.DataSet.FindField('COD_REF')      = nil)   and
     (Sender.DataSet.FindField('FK_SECOES')    = nil)   and
     (Sender.DataSet.FindField('FK_GRUPOS')    = nil)   and
     (Sender.DataSet.FindField('FK_SUBGRUPOS') = nil)   then
   exit;
  if (Sender.DataSet.FieldByName('COD_REF').AsString      = '') and
     (Sender.DataSet.FieldByName('FK_SECOES').AsInteger    > 0) and
     (Sender.DataSet.FieldByName('FK_GRUPOS').AsInteger    > 0) and
     (Sender.DataSet.FieldByName('FK_SUBGRUPOS').AsInteger > 0) and
     (AFindRecord)                                              then
    Sender.DataSet.FieldByName('COD_REF').AsString :=
      GetTypedReference(Sender.DataSet.FieldByName('FK_SECOES').AsInteger,
                        Sender.DataSet.FieldByName('FK_GRUPOS').AsInteger,
                        Sender.DataSet.FieldByName('FK_SUBGRUPOS').AsInteger);
end;

procedure TdmSysCosts.MaquinaAfterScroll(DataSet: TDataSet);
begin
  if ScrollKey.Secao <> Maquina.FieldByName('FK_SECOES').AsInteger then
    LocalizaGrupo;
  if ScrollKey.Grupo <> Maquina.FieldByName('FK_GRUPOS').AsInteger then
    LocalizaSubGrupo;
  ScrollKey.Secao := Maquina.FieldByName('FK_SECOES').AsInteger;
  ScrollKey.Grupo := Maquina.FieldByName('FK_GRUPOS').AsInteger;
end;

procedure TdmSysCosts.GruposBeforeOpen(DataSet: TDataSet);
begin
  if (Grupos.ParamCount > 0) and Secoes.Active then
    Grupos.ParamByName('FkSecoes').AsInteger := Secoes.FieldByName('PK_SECOES').AsInteger;
end;

end.
