unit udmFichaTecnica;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase, VirtualTrees, dbObjects;

type
  TRowData = class(TObject)
    Node : PVirtualNode;
    dbRow: TdbRow;
    Level: Integer;
    constructor Create;
    destructor  Destroy;override;
  end;
  PRowData  = ^TRowData;

  TTreeData = record
    RowData: TRowData;
  end;
  PTreeData = ^TTreeData;

  TdmFichaTecnica = class(TDataModule)
    tr: TIBTransaction;
    qrPecasComponentes: TIBQuery;
    qrReferencia: TIBQuery;
    qrSecoes: TIBQuery;
    qrGrupos: TIBQuery;
    qrReferenciaPeca: TIBQuery;
    qrCopyFichaTecnica: TIBQuery;
    qrFasesPeca: TIBQuery;
    qrPeca: TIBQuery;
    qrPecas: TIBQuery;
    qrInsertPecaComponente: TIBQuery;
    qrUpdatePecaComponente: TIBQuery;
    qrPecaComponente: TIBQuery;
    qrSubGrupos: TIBQuery;
    qrDelPecasComponentes: TIBQuery;
    qrDelPecasCompoOper: TIBQuery;
    qrOperacoes: TIBQuery;
    qrPecasOperacao: TIBQuery;
    qrOperacao: TIBQuery;
    qrTipoFasesProducao: TIBQuery;
    qrTipoOperacoes: TIBQuery;
    qrDeleteComponentesOperacao: TIBQuery;
    qrInsertComponenteOperacao: TIBQuery;
    qrInsertOperacao: TIBQuery;
    qrUpdateOperacao: TIBQuery;
    qrMaxOperacao: TIBQuery;
    qrDeleteOperacoesDetalhes: TIBQuery;
    qrDeleteOperacao: TIBQuery;
    qrOperacoesOld: TIBQuery;
    qrOperacaoOld: TIBQuery;
    qrDeleteComponentesFaseProducao: TIBQuery;
    qrDeleteOperacoesDetalhesFaseProducao: TIBQuery;
    qrDeleteOperacoesFaseProducao: TIBQuery;
    qrDeleteFaseProducao: TIBQuery;
    qrFaseProducao: TIBQuery;
    qrInsertFaseProducao: TIBQuery;
    qrUpdateFaseProducao: TIBQuery;
    qrMaxFaseProducao: TIBQuery;
    qrServicosOperacao: TIBQuery;
    qrAcabamentosOperacao: TIBQuery;
    qrInsumosOperacao: TIBQuery;
    qrInsertOperacoesDetalhes: TIBQuery;
    qrTipoServicos: TIBQuery;
    qrTipoAcabamentos: TIBQuery;
    qrInsumos: TIBQuery;
    qrCheckPecaComponente: TIBQuery;
    qrFerramentasOperacao: TIBQuery;
    qrMaquinas: TIBQuery;
    qrFerramentas: TIBQuery;
    qrDeleteMaquinasOperacao: TIBQuery;
    qrDeleteFerramentasOperacao: TIBQuery;
    qrInsertMaquinaOperacao: TIBQuery;
    qrInsertFerramentaOperacao: TIBQuery;
    qrUnidades: TIBQuery;
    qrServicosInd: TIBQuery;
    qrServicoInd: TIBQuery;
    qrServicoIndByDescricao: TIBQuery;
    qrChaveFichaTecnica: TIBQuery;
    qrPecasAtivas: TIBQuery;
    qrTipoDocumentos: TIBQuery;
    qrCheckFichaAtiva: TIBQuery;
    qrUpdateFlagAtvFichaTecnica: TIBQuery;
    qrFichaTecnicaByVersion: TIBQuery;
    qrVersaoAtivaFicha: TIBQuery;
    qrUltimaVersaoFicha: TIBQuery;
    qrPecasAtivasOriginal: TIBQuery;
    qrReferenciaMaquina: TIBQuery;
    qrProdutosPeca: TIBQuery;
    qrDeleteFerramentasOperacaoFaseProducao: TIBQuery;
    qrDeleteMaquinasOperacaoFaseProducao: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function PecaIsParentOf(fkPecaParent, fkPecaChild:Integer):Boolean;
  end;

var
  dmFichaTecnica: TdmFichaTecnica;

implementation

uses Dado;

{$R *.dfm}

{ TRowData }

constructor TRowData.Create;
begin
  inherited Create;
end;

destructor TRowData.Destroy;
begin
  if dbRow <> nil then
  begin
    dbRow.Free;
    dbRow := nil;
  end;
  inherited Destroy;
end;

{ TdmFichaTecnica }

function TdmFichaTecnica.PecaIsParentOf(fkPecaParent,
  fkPecaChild: Integer): Boolean;
var
  sl    : TList;
  I     : Integer;
begin
  Result:=False;
  sl:=TList.Create;
  try
    with dmFichaTecnica.qrCheckPecaComponente do
         try
          ParamByName('fk_pecas').AsInteger:=fkPecaParent;
          Open;
          While Not(EOF) do
                begin
                  if FieldByName('fk_pecas_montagem').AsInteger=fkPecaChild Then
                     begin
                       Result:=True;
                       Exit;
                     end;
                  sl.Add(TObject(FieldByName('fk_pecas_montagem').AsInteger));
                  Next;
                end;
         finally
           Close;
         end;
    For I:=0 to sl.Count-1 do
        if PecaIsParentOf(LongInt(sl[I]),fkPecaChild) Then
           begin
             Result:=True;
             Exit;
           end;
  finally
    sl.Free;
  end;
end;

end.
