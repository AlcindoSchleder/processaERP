unit CadTFase;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 08/12/2003 - DD/MM/YYYY                                      *}
{* Modified: 08/12/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Encryp, SyncSource, QExportDialog, Enter, DB, Menus,
  Buttons, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  Mask, JvToolEdit, JvCurrEdit, JvDBCtrl;

type
  TCdTFasesProd = class(TCdModelo)
    lPk_Tipo_Fases_Producao: TLabel;
    ePk_Tipo_Fases_Producao: TDBEdit;
    eDsc_Fase: TDBEdit;
    lDsc_Fase: TLabel;
    eNiv_Fase: TJvDBCalcEdit;
    lNiv_Fase: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdTFasesProd: TCdTFasesProd;

implementation

uses mSysCosts;

{$R *.dfm}

procedure TCdTFasesProd.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  eSearch.CharCase := ecUpperCase;
  dsMain.DataSet := dmSysCosts.TFaseProd;
  MainFileName   := 'TIPO_FASES_PRODUCAO';
  MainPrefix     := 'Tfs';
  NullSql        := 'PK_TIPO_FASES_PRODUCAO is null';
  DefControl     := eDSC_FASE;
  VisibleEntrp   := False;
  PrimaryKey     := 'PK_TIPO_FASES_PRODUCAO';
end;

end.
