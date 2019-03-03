unit CadTOpe;

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
  Mask;

type
  TCdTOperacoes = class(TCdModelo)
    ePk_Tipo_Operacoes: TDBEdit;
    lPk_Tipo_Operacoes: TLabel;
    lDsc_Ope: TLabel;
    eDsc_Ope: TDBEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdTOperacoes: TCdTOperacoes;

implementation

uses mSysCosts;

{$R *.dfm}

procedure TCdTOperacoes.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  eSearch.CharCase := ecUpperCase;
  dsMain.DataSet := dmSysCosts.TipoOper;
  MainFileName   := 'TIPO_OPERACOES';
  MainPrefix     := 'Top';
  NullSql        := 'PK_TIPO_OPERACOES is null';
  DefControl     := eDSC_OPE;
  VisibleEntrp   := False;
  PrimaryKey     := 'PK_TIPO_OPERACOES';
end;

end.
