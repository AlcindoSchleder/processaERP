unit CadParam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Encryp, SyncSource, QExportDialog, Enter, DB, Menus,
  Buttons, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  JvToolEdit, JvCurrEdit, JvDBCtrl, Mask;

type
  TCdParametros = class(TCdModelo)
    lPk_Parametros_Calc: TLabel;
    ePk_Parametros_Calc: TDBEdit;
    eDsc_Param: TDBEdit;
    lDsc_Param: TLabel;
    lParam_Nhf: TLabel;
    eParam_Nhf: TJvDBCalcEdit;
    lParam_Nhh: TLabel;
    eParam_Nhh: TJvDBCalcEdit;
    lParam_Ndm: TLabel;
    eParam_Ndm: TJvDBCalcEdit;
    lParam_Nma: TLabel;
    eParam_Nma: TJvDBCalcEdit;
    eCusto_Nhf: TJvDBCalcEdit;
    lCusto_Nhf: TLabel;
    lCusto_Nhh: TLabel;
    eCusto_Nhh: TJvDBCalcEdit;
    lPerc_Troca: TLabel;
    ePerc_Troca: TJvDBCalcEdit;
    eKwh_Mot: TJvDBCalcEdit;
    lKwh_Mot: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdParametros: TCdParametros;

implementation

uses mSysCalc;

{$R *.dfm}

procedure TCdParametros.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  eSearch.CharCase := ecUpperCase;
  dsMain.DataSet := dmSysCalc.Parametro_Calc;
  MainFileName   := 'PARAMETROS_CALC';
  MainPrefix     := 'Pcl';
  NullSql        := 'PK_PARAMETROS_CALC is null';
  DefControl     := eDsc_Param;
  VisibleEntrp   := False;
  PrimaryKey     := 'PK_PARAMETROS_CALC';
end;

end.
