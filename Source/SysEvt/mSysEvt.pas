unit mSysEvt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Encryp, ProcType, FMTBcd, IBCustomDataSet, IBQuery, Provider, IniFiles,
  DBClient, IBScript, IBExtract, IBDatabase, StdCtrls, SqlExpr;

type
  TScrollCad = record
    Pais     : Integer;
    Estado   : string;
    Municipio: Integer;
    Bairro   : Integer;
  end;

  TRegKeys = record
    Cadastro       : Integer;
    Contrato       : Integer;
    TipoEvento     : Integer;
    Evento         : Integer;
    TipoAreaAtuacao: Integer;
    Inscricao      : Integer;
    Segmento       : Integer;
    TipoStatus     : Integer;
    TipoServico    : Integer;
  end;

  TdmSysEvt = class(TDataModule)
    Municipios: TSQLQuery;
    Inscricao: TSQLQuery;
    dsAccess: TSQLQuery;
    Logradouros: TSQLQuery;
    Paises: TSQLQuery;
    Estados: TSQLQuery;
    Bairros: TSQLQuery;
    SqlAux: TSQLQuery;
    TiposEnd: TSQLQuery;
    Categorias: TSQLQuery;
    Eventos: TSQLQuery;
    VincInsSegs: TSQLQuery;
    VincInsSeg: TSQLQuery;
    Categoria: TSQLQuery;
    Evento: TSQLQuery;
    Inscricoes: TSQLQuery;
    TAreasAct: TSQLQuery;
    VincEvtArea: TSQLQuery;
    TipoEvento: TSQLQuery;
    VincAreas: TSQLQuery;
    TipoArea: TSQLQuery;
    Unidades: TSQLQuery;
    TipoServico: TSQLQuery;
    Segmento: TSQLQuery;
    TipoStatus: TSQLQuery;
    TipoEventos: TSQLQuery;
    Segmentos: TSQLQuery;
    PrecoSeg: TSQLQuery;
    PrcSegs: TSQLQuery;
    Vinculos: TSQLQuery;
    TiposStatus: TSQLQuery;
    SaveProc: TSQLQuery;
    TipoServicos: TSQLQuery;
    Expositor: TSQLQuery;
    Servico: TSQLQuery;
    Cadastros: TSQLQuery;
    Servicos: TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataSetReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure InscricaoRAZ_SOCChange(Sender: TField);
    procedure InscricaoPAIS_CADChange(Sender: TField);
    procedure InscricaoUF_CADChange(Sender: TField);
    procedure EstadosBeforeOpen(DataSet: TDataSet);
    procedure MunicipiosBeforeOpen(DataSet: TDataSet);
    procedure BairrosBeforeOpen(DataSet: TDataSet);
    procedure InscricaoAfterScroll(DataSet: TDataSet);
    procedure ibsLocalExecuteError(Sender: TObject; Error,
      SQLText: String; LineIndex: Integer; var Ignore: Boolean);
    procedure EventosBeforeOpen(DataSet: TDataSet);
    procedure VincInsSegBeforeOpen(DataSet: TDataSet);
    procedure dsAccessAfterClose(DataSet: TDataSet);
    procedure TipoEventoAfterScroll(DataSet: TDataSet);
    procedure VincEvtAreaBeforeOpen(DataSet: TDataSet);
    procedure TipoAreaNewRecord(DataSet: TDataSet);
    procedure TipoServicoNewRecord(DataSet: TDataSet);
    procedure TipoEventoNewRecord(DataSet: TDataSet);
    procedure VincEvtAreaNewRecord(DataSet: TDataSet);
    procedure SegmentoNewRecord(DataSet: TDataSet);
    procedure TipoStatusNewRecord(DataSet: TDataSet);
    procedure EventoBeforeOpen(DataSet: TDataSet);
    procedure EventoNewRecord(DataSet: TDataSet);
    procedure EventoAfterScroll(DataSet: TDataSet);
    procedure PrecoSegBeforeOpen(DataSet: TDataSet);
    procedure PrecoSegNewRecord(DataSet: TDataSet);
    procedure EventosAfterScroll(DataSet: TDataSet);
    procedure InscricaoNewRecord(DataSet: TDataSet);
    procedure InscricaoAfterOpen(DataSet: TDataSet);
    procedure InscricaoFK_PAISESChange(Sender: TField);
    procedure InscricaoFLAG_CADChange(Sender: TField);
    procedure InscricaoBeforePost(DataSet: TDataSet);
    procedure ExpositorNewRecord(DataSet: TDataSet);
    procedure ExpositorBeforeOpen(DataSet: TDataSet);
    procedure ExpositorAfterScroll(DataSet: TDataSet);
    procedure ExpositorAfterOpen(DataSet: TDataSet);
    procedure ExpositorMTR_STDChange(Sender: TField);
    procedure ExpositorBeforePost(DataSet: TDataSet);
    procedure ServicoNewRecord(DataSet: TDataSet);
    procedure ServicoBeforeOpen(DataSet: TDataSet);
    procedure ServicoFK_TIPO_SERVICOSChange(Sender: TField);
    procedure ServicoAfterOpen(DataSet: TDataSet);
    procedure InscricaoBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    LocalKey : TScrollCad;
    KeyLocal : TScrollCad;
  public
    { Public declarations }
    DBStatus: TDBMode;
    RegKeys : TRegKeys;
    MethodWOutPar: TScrollTab;
    procedure ConfigFiles;
    function  LocalizaEstados   : Boolean;
    function  LocalizaMunicipio : Boolean;
    function  LocalizaBairro    : Boolean;
    function  LocalizaLocalidade: Boolean;
    function  LocalizaEvento       (const Codigo: Integer): Boolean;
    function  LocalizaCepMunicipio (const Cep   : Integer): Boolean;
    function  LocalizaCepBairro    (const Cep   : Integer): Boolean;
    function  LocalizaCepLocalidade(const Cep   : Integer): Boolean;
    function  LocalizaPrecoSegmentos: Boolean;
    function  LocalizaServicos: Boolean;
    function  LocalizaVincEvtArea: TCheckBoxState;
    function  LocalizaVincInsSegs   : Boolean;
   end;

var
  dmSysEvt: TdmSysEvt;

implementation

uses AltPass, Funcoes, Autor, CadMod, FuncoesDB, ArqStr, ModelTyp, ArqSql, Dado,
  CmmConst, RecErr, Math, prcConsts;

{$R *.DFM}

procedure TdmSysEvt.ConfigFiles;
begin
  dsAccess.Database    := Dados.Conexao;
  Paises.Database      := Dados.Conexao;
  Estados.Database     := Dados.Conexao;
  Municipios.Database  := Dados.Conexao;
  TiposEnd.Database    := Dados.Conexao;
  Bairros.Database     := Dados.Conexao;
  Logradouros.Database := Dados.Conexao;
  SqlAux.Database      := Dados.Conexao;
  LocalKey.Pais       := 0;
  LocalKey.Estado     := '';
  LocalKey.Municipio  := 0;
  LocalKey.Bairro     := 0;
end;

procedure TdmSysEvt.DataModuleDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].InheritsFrom(TDataSet)) and
       (TDataSet(Components[i]).Active)       then
      TDataSet(Components[i]).Close;
    if (Components[i].InheritsFrom(TIBTransaction)) and
       (TIBTransaction(Components[i]).InTransaction)       then
      TIBTransaction(Components[i]).Commit;
  end;
  dsAccess.DataBase    := nil;
  FillChar(RegKeys, SizeOf(RegKeys), #0);
end;

procedure TdmSysEvt.DataSetReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  Action := HandleReconcileError(DataSet, UpdateKind, E);
end;

function  TdmSysEvt.LocalizaPrecoSegmentos: Boolean;
begin
  if PrcSegs.Active           then PrcSegs.Close;
  if PrcSegs.Transaction.InTransaction  then PrcSegs.Transaction.Commit;
  PrcSegs.SQL.Clear;
  PrcSegs.SQL.Add(SqlPrcSegs);
  PrcSegs.Prepare;
  PrcSegs.ParamByName('Empresa').AsInteger    := Dados.Parametros.EmpresaAtiva;
  PrcSegs.ParamByName('TipoEvento').AsInteger := RegKeys.TipoEvento;
  PrcSegs.ParamByName('Evento').AsInteger     := RegKeys.Evento;
  PrcSegs.ParamByName('Segmento').AsInteger   := RegKeys.Segmento;
  PrcSegs.Open;
  Result := not PrcSegs.IsEmpty;
  if PrcSegs.Active       then PrcSegs.Close;
  if PrcSegs.Transaction.InTransaction  then PrcSegs.Transaction.Commit;
end;

function  TdmSysEvt.LocalizaServicos: Boolean;
begin
  if Servicos.Active          then Servicos.Close;
  if Servicos.Transaction.InTransaction  then Servicos.Transaction.Commit;
  Servicos.SQL.Clear;
  Servicos.SQL.Add(SqlServicos);
  Servicos.Prepare;
  Servicos.ParamByName('Empresa').AsInteger     := Dados.Parametros.EmpresaAtiva;
  Servicos.ParamByName('Contrato').AsInteger    := RegKeys.TipoEvento;
  Servicos.ParamByName('Cadastro').AsInteger    := RegKeys.Cadastro;
  Servicos.ParamByName('TipoServico').AsInteger := RegKeys.TipoServico;
  Servicos.Open;
  Result := not Servicos.IsEmpty;
  if Servicos.Active      then Servicos.Close;
  if Servicos.Transaction.InTransaction  then Servicos.Transaction.Commit;
end;

function  TdmSysEvt.LocalizaVincEvtArea: TCheckBoxState;
begin
  Result := cbUnchecked;
  if VincAreas.Active then VincAreas.Close;
  if VincAreas.Transaction.InTransaction  then VincAreas.Transaction.Commit;
  VincAreas.SQL.Clear;
  VincAreas.SQL.Add(SqlVincEvtArea);
  VincAreas.Prepare;
  VincAreas.ParamByName('TipoEvento').AsInteger      := RegKeys.TipoEvento;
  VincAreas.ParamByName('TipoAreaAtuacao').AsInteger := RegKeys.TipoAreaAtuacao;
  VincAreas.Open;
  if not VincAreas.IsEmpty then
    Result := cbChecked;
  if VincAreas.Active then VincAreas.Close;
  if VincAreas.Transaction.InTransaction  then VincAreas.Transaction.Commit;
end;

function  TdmSysEvt.LocalizaVincInsSegs: Boolean;
begin
  if Vinculos.Active then Vinculos.Close;
  if Vinculos.Transaction.InTransaction  then Vinculos.Transaction.Commit;
  Vinculos.SQL.Clear;
  Vinculos.SQL.Add(SqlVincInsSegs);
  Vinculos.Prepare;
  Vinculos.ParamByName('Inscricao').AsInteger  := RegKeys.Inscricao;
  Vinculos.ParamByName('Segmento').AsInteger   := RegKeys.Segmento;
  Vinculos.Open;
  Result := not Vinculos.IsEmpty;
  if Vinculos.Active then Vinculos.Close;
  if Vinculos.Transaction.InTransaction  then Vinculos.Transaction.Commit;
end;

// DataSet Events

procedure TdmSysEvt.InscricaoRAZ_SOCChange(Sender: TField);
begin
  if Inscricao.FieldByName('NOM_FAN').AsString = '' then
    if DBStatus in [dbmInsert, dbmEdit] then
      Inscricao.FieldByName('NOM_FAN').AsString := Inscricao.FieldByName('RAZ_SOC').AsString;
end;

function  TdmSysEvt.LocalizaCepMunicipio(const Cep: Integer): Boolean;
begin
  if not Dados.Tr.InTransaction then Dados.Tr.StartTransaction;
  if SqlAux.Active then SqlAux.Close;
  SqlAux.SQL.Clear;
  SqlAux.SQL.Add(SqlCepMuni);
  SqlAux.Prepare;
  SqlAux.ParamByName('CepMun').AsInteger := Cep;
  SqlAux.Open;
  Result := not SqlAux.IsEmpty;
end;

function  TdmSysEvt.LocalizaCepBairro(const Cep: Integer): Boolean;
begin
  if not Dados.Tr.InTransaction then Dados.Tr.StartTransaction;
  if SqlAux.Active then SqlAux.Close;
  SqlAux.SQL.Clear;
  SqlAux.SQL.Add(SqlCepBair);
  SqlAux.Prepare;
  SqlAux.ParamByName('CepBai').AsInteger := Cep;
  SqlAux.Open;
  Result := not SqlAux.IsEmpty;
end;

function  TdmSysEvt.LocalizaCepLocalidade(const Cep: Integer): Boolean;
begin
  if not Dados.Tr.InTransaction then Dados.Tr.StartTransaction;
  if SqlAux.Active then SqlAux.Close;
  SqlAux.SQL.Clear;
  SqlAux.SQL.Add(SqlCepLoca);
  SqlAux.Prepare;
  SqlAux.ParamByName('CepLoc').AsInteger := Cep;
  SqlAux.Open;
  Result := not SqlAux.IsEmpty;
end;

procedure TdmSysEvt.InscricaoPAIS_CADChange(Sender: TField);
begin
  if Inscricao.State in [dsInsert, dsEdit] then
    LocalizaEstados;
end;

procedure TdmSysEvt.InscricaoUF_CADChange(Sender: TField);
begin
  if Inscricao.State in [dsInsert, dsEdit] then
  LocalizaMunicipio;
end;

function  TdmSysEvt.LocalizaEstados: Boolean;
begin
  Estados.Close;
  Estados.SQL.Clear;
  Estados.SQL.Add(SqlEstados);
  Estados.Prepare;
  Estados.Open;
  Result := Estados.IsEmpty;
end;

function  TdmSysEvt.LocalizaMunicipio: Boolean;
begin
  Municipios.Close;
  Municipios.SQL.Clear;
  Municipios.SQL.Add(SqlMunicipio);
  Municipios.Prepare;
  Municipios.Open;
  Result := Municipios.IsEmpty;
end;

function  TdmSysEvt.LocalizaBairro: Boolean;
begin
  Bairros.Close;
  Bairros.SQL.Clear;
  Bairros.SQL.Add(SqlBairro);
  Bairros.Prepare;
  Bairros.Open;
  Result := Bairros.IsEmpty;
end;

function  TdmSysEvt.LocalizaLocalidade: Boolean;
begin
  Result := False;
end;

procedure TdmSysEvt.EstadosBeforeOpen(DataSet: TDataSet);
begin
  if Paises.Active then
    Estados.ParamByName('Pais').AsInteger := Paises.FieldByName('PK_PAISES').AsInteger;
end;

procedure TdmSysEvt.MunicipiosBeforeOpen(DataSet: TDataSet);
begin
  if Estados.Active then
  begin
    Municipios.ParamByName('Pais').AsInteger  := Estados.FieldByName('FK_PAISES').AsInteger;
    Municipios.ParamByName('Estado').AsString := Estados.FieldByName('PK_ESTADOS').AsString;
  end;
end;

procedure TdmSysEvt.BairrosBeforeOpen(DataSet: TDataSet);
begin
  if Municipios.Active then
  begin
    Bairros.ParamByName('Pais').AsInteger   := Municipios.FieldByName('FK_PAISES').AsInteger;
    Bairros.ParamByName('Estado').AsString  := Municipios.FieldByName('FK_ESTADOS').AsString;
    Bairros.ParamByName('City').AsInteger   := Municipios.FieldByName('PK_MUNICIPIOS').AsInteger;
  end;
end;

procedure TdmSysEvt.ibsLocalExecuteError(Sender: TObject; Error,
  SQLText: String; LineIndex: Integer; var Ignore: Boolean);
begin
  raise Exception.Create(Error + #13 + SQLText + #13 +
    'Linha: ' + IntToStr(LineIndex) + #13 + TIBScript(Sender).Script.Text);
end;

function  TdmSysEvt.LocalizaEvento(const Codigo: Integer): Boolean;
begin
  Eventos.SQL.Clear;
  Eventos.SQL.Add(SqlEvento);
  Eventos.Prepare;
  Eventos.ParamByName('Empresa').AsInteger := Dados.Parametros.EmpresaAtiva;
  Eventos.ParamByName('Evento').AsInteger  := Codigo;
  Eventos.Open;
  Result := not Eventos.IsEmpty;
end;

procedure TdmSysEvt.EventosBeforeOpen(DataSet: TDataSet);
begin
  if Eventos.ParamCount > 0 then
    Eventos.ParamByName('Empresa').AsInteger := Dados.Parametros.EmpresaAtiva;
end;

procedure TdmSysEvt.VincInsSegBeforeOpen(DataSet: TDataSet);
begin
  if VincInsSeg.Params.Count > 0 then
  begin
    VincInsSeg.Params.ParamByName('Inscricao').AsInteger  := RegKeys.Inscricao;
    VincInsSeg.Params.ParamByName('Segmento').AsInteger   := RegKeys.Segmento;
  end;
end;

procedure TdmSysEvt.dsAccessAfterClose(DataSet: TDataSet);
begin
  TrMain.Commit;
end;

procedure TdmSysEvt.TipoEventoAfterScroll(DataSet: TDataSet);
begin
  if Assigned(MethodWOutPar) then MethodWOutPar;
end;

procedure TdmSysEvt.VincEvtAreaBeforeOpen(DataSet: TDataSet);
begin
  if VincEvtArea.Params.Count > 0 then
  begin
    VincEvtArea.Params.ParamByName('TipoEvento').AsInteger      := RegKeys.TipoEvento;
    VincEvtArea.Params.ParamByName('TipoAreaAtuacao').AsInteger := RegKeys.TipoAreaAtuacao;
  end;
end;

procedure TdmSysEvt.TipoAreaNewRecord(DataSet: TDataSet);
begin
  try
    TipoArea.FieldByName('PK_TIPO_AREAS_ATUACAO').AsInteger := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.TipoServicoNewRecord(DataSet: TDataSet);
begin
  try
    TipoServico.FieldByName('PK_TIPO_SERVICOS').AsInteger := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.TipoEventoNewRecord(DataSet: TDataSet);
begin
  try
    TipoEvento.FieldByName('PK_TIPO_EVENTOS').AsInteger := ZEROINT;
    TipoEvento.FieldByName('MTRG_PROM').AsFloat         := ZEROFLOAT;
    TipoEvento.FieldByName('QTD_BONUS').AsFloat         := ZEROFLOAT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.VincEvtAreaNewRecord(DataSet: TDataSet);
begin
  try
    VincEvtArea.FieldByName('FK_TIPO_EVENTOS').AsInteger       := RegKeys.TipoEvento;
    VincEvtArea.FieldByName('FK_TIPO_AREAS_ATUACAO').AsInteger := RegKeys.TipoAreaAtuacao;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.SegmentoNewRecord(DataSet: TDataSet);
begin
  try
    Segmento.FieldByName('PK_SEGMENTOS').AsInteger := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.TipoStatusNewRecord(DataSet: TDataSet);
begin
  try
    TipoStatus.FieldByName('PK_TIPO_STATUS').AsInteger := ZEROINT;
    TipoStatus.FieldByName('FLAG_CAD').AsInteger := FLAG_NAO;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.EventoBeforeOpen(DataSet: TDataSet);
begin
  if Evento.Params.Count > 0 then
    Evento.Params.ParamByName('Empresa').AsInteger := Dados.Parametros.EmpresaAtiva;
end;

procedure TdmSysEvt.EventoNewRecord(DataSet: TDataSet);
var
  Ano, Filler: Word;
begin
  DecodeDate(Date, Ano, Filler, Filler);
  try
    Evento.FieldByName('FK_EMPRESAS').AsInteger     := Dados.Parametros.EmpresaAtiva;
    Evento.FieldByName('FK_TIPO_EVENTOS').AsInteger := RegKeys.TipoEvento;
    Evento.FieldByName('PK_EVENTOS').AsInteger      := Ano;
    Evento.FieldByName('NUM_EXP').AsInteger         := ZEROINT;
    Evento.FieldByName('NUM_CAT').AsInteger         := ZEROINT;
    Evento.FieldByName('NUM_INS').AsInteger         := ZEROINT;
    Evento.FieldByName('VLR_MT2').AsFloat           := ZEROFLOAT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.EventoAfterScroll(DataSet: TDataSet);
begin
  if not (DataSet.State in [dsInsert, dsEdit]) then
  begin
    RegKeys.TipoEvento := Evento.FieldByName('FK_TIPO_EVENTOS').AsInteger;
    RegKeys.Evento     := Evento.FieldByName('PK_EVENTOS').AsInteger;
  end;
end;

procedure TdmSysEvt.PrecoSegBeforeOpen(DataSet: TDataSet);
begin
  if PrecoSeg.Params.Count > 0 then
  begin
    PrecoSeg.Params.ParamByName('Empresa').AsInteger    := Dados.Parametros.EmpresaAtiva;
    PrecoSeg.Params.ParamByName('TipoEvento').AsInteger := RegKeys.TipoEvento;
    PrecoSeg.Params.ParamByName('Evento').AsInteger     := RegKeys.Evento;
  end;
end;

procedure TdmSysEvt.PrecoSegNewRecord(DataSet: TDataSet);
begin
  try
    PrecoSeg.FieldByName('FK_EMPRESAS').AsInteger     := Dados.Parametros.EmpresaAtiva;
    PrecoSeg.FieldByName('FK_TIPO_EVENTOS').AsInteger := RegKeys.TipoEvento;
    PrecoSeg.FieldByName('FK_EVENTOS').AsInteger      := RegKeys.Evento;
    PrecoSeg.FieldByName('FK_SEGMENTOS').AsInteger    := RegKeys.Segmento;
    PrecoSeg.FieldByName('PRE_SEG').AsFloat           := ZEROFLOAT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.EventosAfterScroll(DataSet: TDataSet);
begin
  RegKeys.TipoEvento := Eventos.FieldByName('PK_TIPO_EVENTOS').AsInteger;
  RegKeys.Evento     := Eventos.FieldByName('PK_EVENTOS').AsInteger;
end;

procedure TdmSysEvt.InscricaoNewRecord(DataSet: TDataSet);
begin
  try
    Inscricao.FieldByName('PK_INSCRICOES').AsInteger      := ZEROINT;
    Inscricao.FieldByName('FK_PAISES').AsInteger          := KeyLocal.Pais;
    Inscricao.FieldByName('FK_ESTADOS').AsString          := KeyLocal.Estado;
    Inscricao.FieldByName('FK_MUNICIPIOS').AsInteger      := KeyLocal.Municipio;
    Inscricao.FieldByName('FK_TIPO_STATUS').AsInteger     := 1;
    Inscricao.FieldByName('FLAG_CAD').AsInteger           := FLAG_TCAD_FISICA;
    Inscricao.FieldByName('FLAG_ETQ').AsInteger           := FLAG_SIM;
    Inscricao.FieldByName('FLAG_EXP').AsInteger           := FLAG_NAO;
    Inscricao.FieldByName('NUM_END').AsInteger            := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.InscricaoBeforeOpen(DataSet: TDataSet);
begin
  if (Inscricao.Params.Count > 0) and (RegKeys.TipoEvento > 0) and
     (RegKeys.Evento > 0) then
  begin
    Inscricao.Params.ParamByName('Empresa').AsInteger    := Dados.Parametros.EmpresaAtiva;
    Inscricao.Params.ParamByName('TipoEvento').AsInteger := RegKeys.TipoEvento;
    Inscricao.Params.ParamByName('Evento').AsInteger     := RegKeys.Evento;
  end;
end;

procedure TdmSysEvt.InscricaoAfterOpen(DataSet: TDataSet);
begin
  KeyLocal.Pais := Dados.Parametros.EmpresaPais;
  Inscricao.FieldByName('FK_PAISES').OnChange     := InscricaoFK_PAISESChange;
  Inscricao.FieldByName('FK_ESTADOS').OnChange    := InscricaoFK_PAISESChange;
  Inscricao.FieldByName('FK_MUNICIPIOS').OnChange := InscricaoFK_PAISESChange;
  Inscricao.FieldByName('FLAG_CAD').OnChange      := InscricaoFLAG_CADChange;
end;

procedure TdmSysEvt.InscricaoFK_PAISESChange(Sender: TField);
begin
  if Assigned(Sender.DataSet.AfterScroll) then
    Sender.DataSet.AfterScroll(Sender.DataSet);
end;

procedure TdmSysEvt.InscricaoFLAG_CADChange(Sender: TField);
begin
  if Assigned(Sender.DataSet.AfterScroll) then
    Sender.DataSet.AfterScroll(Sender.DataSet);
end;

procedure TdmSysEvt.InscricaoBeforePost(DataSet: TDataSet);
begin
  KeyLocal.Pais      := Inscricao.FieldByName('FK_PAISES').AsInteger;
  KeyLocal.Estado    := Inscricao.FieldByName('FK_ESTADOS').AsString;
  KeyLocal.Municipio := Inscricao.FieldByName('FK_MUNICIPIOS').AsInteger;
end;

procedure TdmSysEvt.InscricaoAfterScroll(DataSet: TDataSet);
begin
  RegKeys.Inscricao := Inscricao.FieldByName('PK_INSCRICOES').AsInteger;
  if Assigned(MethodWOutPar) then MethodWOutPar;
  if LocalKey.Pais <> Inscricao.FieldByName('FK_PAISES').AsInteger then
  begin
    Estados.Close;
    Estados.SQL.Clear;
    Estados.SQL.Add(SqlEstados);
    Estados.Prepare;
    Estados.Open;
  end;
  if LocalKey.Estado <> Inscricao.FieldByName('FK_ESTADOS').AsString then
  begin
    Municipios.Close;
    Municipios.SQL.Clear;
    Municipios.SQL.Add(SqlMunicipio);
    Municipios.Prepare;
    Municipios.Open;
  end;
  LocalKey.Pais      := Inscricao.FieldByName('FK_PAISES').AsInteger;
  LocalKey.Estado    := Inscricao.FieldByName('FK_ESTADOS').AsString;
  LocalKey.Municipio := Inscricao.FieldByName('FK_MUNICIPIOS').AsInteger;
end;

procedure TdmSysEvt.ExpositorNewRecord(DataSet: TDataSet);
begin
  try
    Expositor.FieldByName('FK_EMPRESAS').AsInteger     := Dados.Parametros.EmpresaAtiva;
    Expositor.FieldByName('FK_TIPO_EVENTOS').AsInteger := RegKeys.TipoEvento;
    Expositor.FieldByName('FK_EVENTOS').AsInteger      := RegKeys.Evento;
    Expositor.FieldByName('FK_CADASTROS').AsInteger    := ZEROINT;
    Expositor.FieldByName('PK_CONTRATOS').AsInteger    := 0;
    Expositor.FieldByName('DTA_CTR').AsDateTime        := Date;
    Expositor.FieldByName('VLR_CTR').AsFloat           := ZEROFLOAT;
    Expositor.FieldByName('MTR_STD').AsFloat           := ZEROFLOAT;
    Expositor.FieldByName('NUM_STD').AsInteger         := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.ExpositorBeforeOpen(DataSet: TDataSet);
begin
  if Expositor.Params.Count > 0 then
  begin
    Expositor.Params.ParamByName('Empresa').AsInteger    := Dados.Parametros.EmpresaAtiva;
    Expositor.Params.ParamByName('TipoEvento').AsInteger := RegKeys.TipoEvento;
    Expositor.Params.ParamByName('Evento').AsInteger     := RegKeys.Evento;
  end;
end;

procedure TdmSysEvt.ExpositorAfterScroll(DataSet: TDataSet);
begin
  RegKeys.Cadastro := Expositor.FieldByName('FK_CADASTROS').AsInteger;
  if Assigned(MethodWOutPar) then
    MethodWOutPar;
end;

procedure TdmSysEvt.ExpositorAfterOpen(DataSet: TDataSet);
begin
  Expositor.FieldByName('MTR_STD').OnChange := ExpositorMTR_STDChange;
end;

procedure TdmSysEvt.ExpositorMTR_STDChange(Sender: TField);
var
  QtdConv, ModConv, QtdDiv: Integer;
begin
  if (Expositor.FieldByName('MTR_STD').AsFloat > 0) and
     (Eventos.FieldByName('MTRG_PROM').AsFloat > 0) then
  begin
    if (Expositor.State in [dsInsert, dsEdit]) then
    begin
      if (Expositor.FieldByName('VLR_CTR').AsFloat = 0) then
        Expositor.FieldByName('VLR_CTR').AsFloat :=
          Expositor.FieldByName('MTR_STD').AsFloat * Eventos.FieldByName('VLR_MT2').AsFloat;
      if Expositor.FieldByName('MTR_STD').AsFloat >=
         Eventos.FieldByName('MTRG_PROM').AsFloat then
      begin
        QtdDiv  := Trunc(Expositor.FieldByName('MTR_STD').AsFloat /
                   Eventos.FieldByName('MTRG_PROM').AsFloat);
        QtdConv := Trunc(QtdDiv * Eventos.FieldByName('QTD_BONUS').AsFloat);
        if QtdConv > 0 then
        begin
          ModConv := Trunc(((Expositor.FieldByName('MTR_STD').AsFloat /
                     Eventos.FieldByName('MTRG_PROM').AsFloat) - QtdDiv) * 10) ;
          if ModConv > 5 then
            Inc(QtdConv);
          Expositor.FieldByName('QTD_CONV').AsInteger := QtdConv;
        end
        else
          Expositor.FieldByName('QTD_CONV').AsInteger := QtdConv;
      end;
    end;
  end;
end;

procedure TdmSysEvt.ExpositorBeforePost(DataSet: TDataSet);
begin
  with CdModelo do
  begin
    Crypto.Input      := Expositor.FieldByName('SEN_EXP').AsString;
    Crypto.Key        := Expositor.FieldByName('LOG_EXP').AsString;
    Crypto.Action     := atCrypto;
    Crypto.TypeCipher := tcUnix;
    Crypto.Execute;
  end;
  Expositor.FieldByName('SENHA_CRIPTO').AsString := CdModelo.Crypto.Output;
end;

procedure TdmSysEvt.ServicoNewRecord(DataSet: TDataSet);
begin
  try
    Servico.FieldByName('FK_EMPRESAS').AsInteger  := Dados.Parametros.EmpresaAtiva;
    Servico.FieldByName('FK_CONTRATOS').AsInteger := ZEROINT;
    Servico.FieldByName('FK_CADASTRO').AsInteger  := RegKeys.Cadastro;
    Servico.FieldByName('QTD_SRV').AsFloat        := 1;
    Servico.FieldByName('TOT_SRV').AsFloat        := ZEROFLOAT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysEvt.ServicoBeforeOpen(DataSet: TDataSet);
begin
  if Servico.Params.Count > 0 then
  begin
    Servico.Params.ParamByName('Empresa').AsInteger  := Dados.Parametros.EmpresaAtiva;
    Servico.Params.ParamByName('Contrato').AsInteger := RegKeys.TipoEvento;
    Servico.Params.ParamByName('Cadastro').AsInteger := RegKeys.Evento;
  end;
end;

procedure TdmSysEvt.ServicoFK_TIPO_SERVICOSChange(Sender: TField);
begin
  if (Servico.State in [dsInsert, dsEdit])        and
     (Servico.FieldByName('TOT_SRV').AsFloat = 0) then
    Servico.FieldByName('TOT_SRV').AsFloat :=
      Servico.FieldByName('QTD_SRV').AsFloat * TipoServicos.FieldByName('VLR_TSRV').AsFloat;
end;

procedure TdmSysEvt.ServicoAfterOpen(DataSet: TDataSet);
begin
  Servico.FieldByName('FK_TIPO_SERVICOS').OnChange := ServicoFK_TIPO_SERVICOSChange;
  Servico.FieldByName('QTD_SRV').OnChange          := ServicoFK_TIPO_SERVICOSChange;
end;

end.
