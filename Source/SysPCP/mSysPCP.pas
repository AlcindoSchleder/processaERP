unit mSysPCP;
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
  SysUtils, Classes, DBClient, IBDatabase, DB, IBCustomDataSet, IBQuery,
  Provider, ProcType, Forms, Windows, Dialogs;

type
  TKeyLocal = record
    FkAlmoxarifado: Integer;
    FkPeca        : Integer;
    FkFichaTecnica: Integer;
    Grupo         : Integer;
    MajVer        : Integer;
    MinVer        : Integer;
    CodRef        : string;
    SubGrupo      : Integer;
    Secao         : Integer;
  end;

  TdmSysPCP = class(TDataModule)
    pAccess: TDataSetProvider;
    dsAccess: TIBQuery;
    TrMain: TIBTransaction;
    FichaTecn: TClientDataSet;
    PecaEstq: TClientDataSet;
    TrPCP: TIBTransaction;
    PecLotacoes: TIBQuery;
    Secoes: TIBQuery;
    Grupos: TIBQuery;
    SubGrupos: TIBQuery;
    Almoxarifados: TIBQuery;
    TrAux: TIBTransaction;
    qrySearch: TIBQuery;
    PecaCusto: TClientDataSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure ReconcileErrorHandler(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure DataModuleCreate(Sender: TObject);
    procedure dsAccessAfterClose(DataSet: TDataSet);
    procedure GruposBeforeOpen(DataSet: TDataSet);
    procedure SubGruposBeforeOpen(DataSet: TDataSet);
    procedure FichaTecnNewRecord(DataSet: TDataSet);
    procedure FichaTecnAfterScroll(DataSet: TDataSet);
    procedure PecaEstqNewRecord(DataSet: TDataSet);
    procedure PecaEstqAfterScroll(DataSet: TDataSet);
    procedure PecaEstqBeforeOpen(DataSet: TDataSet);
    procedure PecLotacoesBeforeOpen(DataSet: TDataSet);
    procedure FichaTecnAfterEdit(DataSet: TDataSet);
  private
    { Private declarations }
    FScrollKey: TKeyLocal;
    FFlagOp   : Integer;
    FFlagAtv  : Integer;
  public
    { Public declarations }
    MethodWithPar: TScrollTabPar;
    MethodWOutPar: TScrollTab;
    AFindRecord: Boolean;
    procedure ConfigFiles;
    function  LocalizaGrupos   : Boolean;
    function  LocalizaSubGrupos: Boolean;
    function  LocateNewVersion(const ACodPart: Integer;
      var AMajVer, AMinVer: Integer): Boolean;
    function  LocateVersion(const ARefPart: string; const AMajVer, AMinVer: Integer): Boolean;
    property  FkAlmoxarifado: Integer read FScrollKey.FkAlmoxarifado write FScrollKey.FkAlmoxarifado default 0;
    property  FkPeca        : Integer read FScrollKey.FkPeca         write FScrollKey.FkPeca         default 0;
    property  FkFichaTecnica: Integer read FScrollKey.FkFichaTecnica write FScrollKey.FkFichaTecnica default 0;
    property  MajVer        : Integer read FScrollKey.MajVer         write FScrollKey.MajVer         default 0;
    property  MinVer        : Integer read FScrollKey.MinVer         write FScrollKey.MinVer         default 0;
    property  FlagOp        : Integer read FFlagOp                   write FFlagOp                   default 0;
    property  FlagAtv       : Integer read FFlagAtv                  write FFlagAtv                  default 0;
    property  CodRef        : string  read FScrollKey.CodRef         write FScrollKey.CodRef;
  end;

var
  dmSysPCP: TdmSysPCP;

implementation

uses Dado, RecErr, CmmConst, Math, Funcoes, ArqSql;

{$R *.dfm}

procedure TdmSysPCP.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if ((Components[i] is TIBQuery) and (TIBQuery(Components[i]).Active)) then
      TIBQuery(Components[i]).Close;
  with Dados do
  begin
    if Tr.InTransaction  then Tr.Commit;
    if Conexao.Connected then Conexao.Close;
  end;
  dsAccess.DataBase    := nil;
end;

procedure TdmSysPCP.DataModuleCreate(Sender: TObject);
begin
  FillChar(FScrollKey, SizeOf(FScrollKey), 0);
  FkPeca         := 0;
  FkFichaTecnica := 0;
  FkAlmoxarifado := 0;
  FlagOp         := 0;
  FlagAtv        := 0;
  MajVer         := 0;
  MinVer         := 0;
  CodRef         := '';
end;

procedure TdmSysPCP.ConfigFiles;
begin
  dsAccess.DataBase := Dados.Conexao;
end;

function  TdmSysPCP.LocalizaGrupos: Boolean;
begin
  if Grupos.Active then
  begin
    Grupos.Close;
    Grupos.Open;
  end;
  Result := Grupos.Active and Grupos.IsEmpty;
end;

function  TdmSysPCP.LocalizaSubGrupos: Boolean;
begin
  if SubGrupos.Active then
  begin
    SubGrupos.Close;
    SubGrupos.Open;
  end;
  Result := SubGrupos.Active and SubGrupos.IsEmpty;
end;

function  TdmSysPCP.LocateNewVersion(const ACodPart: Integer;
  var AMajVer, AMinVer: Integer): Boolean;
begin
  Result := False;
  if qrySearch.Active then qrySearch.Close;
  if qrySearch.Transaction.InTransaction then
    qrySearch.Transaction.Commit;
  qrySearch.SQL.Clear;
  qrySearch.SQL.Add(SqlCodPecas);
  if not qrySearch.Prepared then qrySearch.Prepare;
  if qrySearch.Params.FindParam('Peca') <> nil then
    qrySearch.Params.FindParam('Peca').AsInteger := ACodPart;
  if not qrySearch.Active then qrySearch.Open;
  if not qrySearch.IsEmpty then
  begin
    Result := True;
    if qrySearch.FindField('MAJ_VER') <> nil then
      AMajVer    := qrySearch.FindField('MAJ_VER').AsInteger;
    if qrySearch.FindField('MIN_VER') <> nil then
      AMinVer    := qrySearch.FindField('MIN_VER').AsInteger;
    if qrySearch.FindField('FLAG_OP') <> nil then
      FFlagOp    := qrySearch.FindField('FLAG_OP').AsInteger;
    if qrySearch.FindField('FLAG_ATV') <> nil then
      FFlagAtv   := qrySearch.FindField('FLAG_ATV').AsInteger;
  end;
  if qrySearch.Active then qrySearch.Close;
  if qrySearch.Transaction.InTransaction then
    qrySearch.Transaction.Commit;
  qrySearch.SQL.Clear;
end;

function  TdmSysPCP.LocateVersion(const ARefPart: string;
  const AMajVer, AMinVer: Integer): Boolean;
begin
  if qrySearch.Active then qrySearch.Close;
  if qrySearch.Transaction.InTransaction then
    qrySearch.Transaction.Commit;
  qrySearch.SQL.Clear;
  qrySearch.SQL.Add(SqlNewVersionPart);
  if not qrySearch.Prepared then qrySearch.Prepare;
  if qrySearch.Params.FindParam('CodRef') <> nil then
    qrySearch.Params.FindParam('CodRef').AsString  := ARefPart;
  if qrySearch.Params.FindParam('MajVer') <> nil then
    qrySearch.Params.FindParam('MajVer').AsInteger := AMajVer;
  if qrySearch.Params.FindParam('MinVer') <> nil then
    qrySearch.Params.FindParam('MinVer').AsInteger := AMinVer;
  if not qrySearch.Active then qrySearch.Open;
  Result := not qrySearch.IsEmpty;
  if qrySearch.Active then qrySearch.Close;
  if qrySearch.Transaction.InTransaction then
    qrySearch.Transaction.Commit;
  qrySearch.SQL.Clear;
end;

procedure TdmSysPCP.ReconcileErrorHandler(
  DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  Action := HandleReconcileError(DataSet, UpdateKind, E);
end;

procedure TdmSysPCP.dsAccessAfterClose(DataSet: TDataSet);
begin
  if TrMain.InTransaction then TrMain.Commit;
end;

procedure TdmSysPCP.GruposBeforeOpen(DataSet: TDataSet);
begin
  if Secoes.Active and (not Secoes.IsEmpty) and (Grupos.Params.Count > 0) and
     (Secoes.FindField('PK_SECOES') <> nil) and (Grupos.Params.FindParam('Secao') <> nil) then
    Grupos.Params.FindParam('Secao').AsInteger := Secoes.FindField('PK_SECOES').AsInteger;
end;

procedure TdmSysPCP.SubGruposBeforeOpen(DataSet: TDataSet);
begin
  if Secoes.Active and (not Secoes.IsEmpty) and (Grupos.Params.Count > 0)              and
     (Secoes.FindField('PK_SECOES') <> nil) and (Grupos.FindField('PK_GRUPOS') <> nil) and
     (SubGrupos.Params.FindParam('Secao') <> nil) and
     (SubGrupos.Params.FindParam('Grupo') <> nil) then
  begin
    SubGrupos.Params.FindParam('Secao').AsInteger := Secoes.FindField('PK_SECOES').AsInteger;
    SubGrupos.Params.FindParam('Grupo').AsInteger := Grupos.FindField('PK_GRUPOS').AsInteger;
  end;
end;

procedure TdmSysPCP.FichaTecnNewRecord(DataSet: TDataSet);
begin
  try
    FichaTecn.FieldByName('FK_PECAS').AsInteger     := ZEROINT;
    FichaTecn.FieldByName('PK_FICHA_TECNICA').AsInteger := ZEROINT;
    FichaTecn.FieldByName('FLAG_TCOMP').AsInteger   := FLAG_NAO;
    FichaTecn.FieldByName('FK_SECOES').AsInteger    := FScrollKey.Secao;
    FichaTecn.FieldByName('FK_GRUPOS').AsInteger    := FScrollKey.Grupo;
    FichaTecn.FieldByName('FK_SUBGRUPOS').AsInteger := FScrollKey.SubGrupo;
    FichaTecn.FieldByName('FLAG_ATV').AsInteger     := FLAG_NAO;
    FichaTecn.FieldByName('FLAG_OP').AsInteger      := FLAG_NAO;
    FichaTecn.FieldByName('COD_REF').AsString       := FScrollKey.CodRef;
    FichaTecn.FieldByName('MAJ_VER').AsInteger      := FScrollKey.MajVer;
    FichaTecn.FieldByName('MIN_VER').AsInteger      := FScrollKey.MinVer;
    FichaTecn.FieldByName('MOT_NVER').AsString     := 'NOVA PECA';
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysPCP.FichaTecnAfterScroll(DataSet: TDataSet);
begin
  if FichaTecn.FieldByName('FK_SECOES').AsInteger <> FScrollKey.Secao then
    LocalizaGrupos;
  if FichaTecn.FieldByName('FK_GRUPOS').AsInteger <> FScrollKey.Grupo then
    LocalizaSubGrupos;
  FScrollKey.FkPeca         := FichaTecn.FieldByName('FK_PECAS').AsInteger;
  FScrollKey.CodRef         := FichaTecn.FieldByName('COD_REF').AsString;
  FScrollKey.FkFichaTecnica := FichaTecn.FieldByName('PK_FICHA_TECNICA').AsInteger;
  FScrollKey.Secao          := FichaTecn.FieldByName('FK_SECOES').AsInteger;
  FScrollKey.Grupo          := FichaTecn.FieldByName('FK_GRUPOS').AsInteger;
  FScrollKey.SubGrupo       := FichaTecn.FieldByName('FK_SUBGRUPOS').AsInteger;
  if Assigned(MethodWOutPar) then
    MethodWOutPar;
end;

procedure TdmSysPCP.PecaEstqNewRecord(DataSet: TDataSet);
begin
  try
    PecaEstq.FieldByName('FK_EMPRESAS').AsInteger      := Dados.Parametros.EmpresaAtiva;
    PecaEstq.FieldByName('FK_ALMOXARIFADOS').AsInteger := ZEROINT;
    PecaEstq.FieldByName('FK_PECAS').AsInteger         := FScrollKey.FkPeca;
    PecaEstq.FieldByName('FK_FICHA_TECNICA').AsInteger := FScrollKey.FkFichaTecnica;
    PecaEstq.FieldByName('FK_ALMOXARIFADOS').AsInteger := FScrollKey.FkAlmoxarifado;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysPCP.PecaEstqAfterScroll(DataSet: TDataSet);
begin
  if Assigned(MethodWOutPar) then
    MethodWOutPar;
  FScrollKey.FkAlmoxarifado := PecaEstq.FieldByName('FK_ALMOXARIFADOS').AsInteger;
end;

procedure TdmSysPCP.PecaEstqBeforeOpen(DataSet: TDataSet);
begin
  if (FScrollKey.FkPeca > 0) and (FScrollKey.FkFichaTecnica > 0) and
     (PecaEstq.Params.Count > 0) and
     (PecaEstq.Params.FindParam('Empresa') <> nil)        and
     (PecaEstq.Params.FindParam('FichaTecnica') <> nil)   and
     (PecaEstq.Params.FindParam('Peca') <> nil)           then
  begin
    PecaEstq.Params.FindParam('Empresa').AsInteger      := Dados.Parametros.EmpresaAtiva;
    PecaEstq.Params.FindParam('Peca').AsInteger         := FScrollKey.FkPeca;
    PecaEstq.Params.FindParam('FichaTecnica').AsInteger := FScrollKey.FkFichaTecnica;
  end;
end;

procedure TdmSysPCP.PecLotacoesBeforeOpen(DataSet: TDataSet);
begin
  if (PecLotacoes.Params.Count > 0)                          and
     (FScrollKey.FkPeca > 0) and (FScrollKey.FkFichaTecnica > 0) and
     (PecLotacoes.Params.FindParam('Empresa') <> nil)        and
     (PecLotacoes.Params.FindParam('Peca') <> nil)           and
     (PecLotacoes.Params.FindParam('FichaTecnica') <> nil)   and
     (PecLotacoes.Params.FindParam('Almoxarifado') <> nil)   then
  begin
    PecLotacoes.Params.FindParam('Empresa').AsInteger      := Dados.Parametros.EmpresaAtiva;
    PecLotacoes.Params.FindParam('Peca').AsInteger         := FScrollKey.FkPeca;
    PecLotacoes.Params.FindParam('FichaTecnica').AsInteger := FScrollKey.FkFichaTecnica;
    PecLotacoes.Params.FindParam('Almoxarifado').AsInteger := FScrollKey.FkAlmoxarifado;
  end;
end;

procedure TdmSysPCP.FichaTecnAfterEdit(DataSet: TDataSet);
begin
  FichaTecn.FieldByName('COD_REF').AsString  := CodRef;
  FichaTecn.FieldByName('MAJ_VER').AsInteger := MajVer;
  FichaTecn.FieldByName('MIN_VER').AsInteger := MinVer;
  FichaTecn.FieldByName('MOT_NVER').AsString := 'NOVA VERSAO';
end;

end.
