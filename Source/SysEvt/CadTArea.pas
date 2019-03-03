unit CadTArea;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Enter, DB, ImgList, Menus, Buttons, StdCtrls, DBCtrls,
  ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin, Mask, SyncSource,
  QExportDialog, Encryp, JvPlacemnt;

type
  TCdTipoAreas = class(TCdModelo)
    lDsc_Tara: TLabel;
    eDsc_Tara: TDBEdit;          
    lPk_Tipo_Areas_Atuacao: TLabel;
    ePk_Tipo_Areas_Atuacao: TDBEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdTipoAreas: TCdTipoAreas;

implementation

uses mSysEvt, ArqSql;

{$R *.dfm}

procedure TCdTipoAreas.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  dsMain.DataSet := dmSysEvt.TipoArea;
  MainFileName   := 'TIPO_AREAS_ATUACAO';
  MainPrefix     := 'Taa';
  NullSql        := 'Taa.PK_TIPO_AREAS_ATUACAO is null';
  PrimaryKey     := 'PK_TIPO_AREAS_ATUACAO';
  DefControl     := eDsc_Tara;
  VisibleEntrp   := False;
end;

end.
