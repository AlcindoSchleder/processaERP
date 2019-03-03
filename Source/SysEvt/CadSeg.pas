unit CadSeg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Enter, DB, ImgList, Menus, Buttons, StdCtrls, DBCtrls,
  ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin, Mask, SyncSource,
  QExportDialog, Encryp;

type
  TCdSegmentos = class(TCdModelo)
    lDsc_Seg: TLabel;
    eDsc_Seg: TDBEdit;
    lPk_Segmentos: TLabel;
    ePk_Segmentos: TDBEdit;
    lFlag_Area: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdSegmentos: TCdSegmentos;

implementation

uses mSysEvt, ArqSql;

{$R *.dfm}

procedure TCdSegmentos.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  dsMain.DataSet := dmSysEvt.Segmento;
  MainFileName   := 'SEGMENTOS';
  MainPrefix     := 'Seg';
  NullSql        := 'Seg.PK_SEGMENTOS is null';
  PrimaryKey     := 'PK_SEGMENTOS';
  MainSql.Add(SqlEmptyCateg);
  DefControl     := eDsc_Seg;
  VisibleEntrp   := False;
end;

end.
