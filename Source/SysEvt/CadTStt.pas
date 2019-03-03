unit CadTStt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Mask, DBCtrls, Encryp, SyncSource, QExportDialog, Enter,
  DB, Menus, Buttons, StdCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin;

type
  TCdTipoStatus = class(TCdModelo)
    lPk_Tipo_Status: TLabel;
    ePk_Tipo_Status: TDBEdit;
    eDsc_Stt: TDBEdit;
    lDsc_Stt: TLabel;
    lFlag_Cad: TDBCheckBox;
    lFlag_Bloq: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdTipoStatus: TCdTipoStatus;

implementation

uses mSysEvt;

{$R *.dfm}

procedure TCdTipoStatus.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  dsMain.DataSet := dmSysEvt.TipoStatus;
  MainFileName   := 'TIPO_STATUS';
  MainPrefix     := 'Tst';
  NullSql        := 'Tst.PK_TIPO_STATUS is null';
  PrimaryKey     := 'PK_TIPO_STATUS';
  DefControl     := eDsc_Stt;
  VisibleEntrp   := False;
end;

end.
