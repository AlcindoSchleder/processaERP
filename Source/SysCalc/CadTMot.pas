unit CadTMot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Encryp, SyncSource, QExportDialog, Enter, DB, Menus,
  Buttons, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  Mask, JvToolEdit, JvCurrEdit, JvDBCtrl;

type
  TCdTipoMotores = class(TCdModelo)
    lPk_Tipos_Motores: TLabel;
    ePk_Tipos_Motores: TDBEdit;
    lDsc_Mot: TLabel;
    eDsc_Mot: TDBEdit;
    lQtd_Polo: TLabel;
    eQtd_Polo: TJvDBCalcEdit;
    lCv_Mot: TLabel;
    eCv_Mot: TJvDBCalcEdit;
    lPreco_Mot: TLabel;
    ePreco_Mot: TJvDBCalcEdit;
    lRpm_Mot: TLabel;
    eRpm_Mot: TJvDBCalcEdit;
    lFlag_Vnd: TDBCheckBox;
    lFat_Rend: TLabel;
    eFat_Rend: TJvDBCalcEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdTipoMotores: TCdTipoMotores;

implementation

uses mSysCalc;

{$R *.dfm}

procedure TCdTipoMotores.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  eSearch.CharCase := ecUpperCase;
  dsMain.DataSet := dmSysCalc.Tipo_Motor;
  MainFileName   := 'TIPOS_MOTORES';
  MainPrefix     := 'Tmt';
  NullSql        := 'PK_TIPOS_MOTORES is null';
  DefControl     := eDsc_Mot;
  VisibleEntrp   := False;
  PrimaryKey     := 'PK_TIPOS_MOTORES';
end;

end.
