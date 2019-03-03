unit mSysHist;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DB, SqlExpr;

type
  TdmHistoric = class(TDataModule)
    ConnHist: TSQLConnection;
    qrHistoric: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmHistoric: TdmHistoric;

implementation

{$R *.dfm}

end.
