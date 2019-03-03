unit udmCargas;

interface

uses
  SysUtils, Classes, dbObjects, DB, IBDatabase, IBCustomDataSet, IBQuery, VirtualTrees;

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

  TdmCargas = class(TDataModule)
    tr: TIBTransaction;
    qrItemsPedidos: TIBQuery;
    qrRegioes: TIBQuery;
    qrClientes: TIBQuery;
    qrTiposPedidos: TIBQuery;
    qrVinculosPedido: TIBQuery;
    qrCheckReferenciaCarga: TIBQuery;
    qrInsertCargaProducao: TIBQuery;
    qrMaxCargaProducao: TIBQuery;
    qrUpdatePedidosItems: TIBQuery;
    qrItemsCargas: TIBQuery;
    qrAtivaCargaProducao: TIBQuery;
    qrDeleteCargaProducao: TIBQuery;
    qrClearItemPedidoCargaProducao: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCargas: TdmCargas;

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

end.
