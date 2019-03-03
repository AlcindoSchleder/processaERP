unit SelDosIm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Grids, DBGrids, DB;

type
  TSelImprDos = class(TForm)
    Status: TStatusBar;
    cbTools: TCoolBar;
    tbButtonTools: TToolBar;
    tbClose: TToolButton;
    tbPrint: TToolButton;
    tbView: TToolButton;
    tbCancel: TToolButton;
    dbgGridPrn: TDBGrid;
    dsImpressoras: TDataSource;
    procedure tbCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelImprDos: TSelImprDos;

implementation

uses mSysRel, Dado;

{$R *.dfm}

procedure TSelImprDos.tbCloseClick(Sender: TObject);
begin
  if Dados.Conexao.Connected then
    ShowMessage('Conexao Aberta');
  Close;
end;

procedure TSelImprDos.FormActivate(Sender: TObject);
begin
  with dmSysRel do
  begin
    if Printers.Active then Printers.Close;
    Printers.SQL.Clear;
    Printers.SQL.Add('select * from IMPRESSORAS order by DSC_IMP');
    if not Printers.Active then Printers.Open;
  end;
end;

procedure TSelImprDos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dmSysRel.Printers.Active then dmSysRel.Printers.Close;
end;

end.
