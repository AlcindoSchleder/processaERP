unit CadRod;            

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 06/03/2003 - DD/MM/YYYY                                      *}
{* Modified: 06/03/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  SysUtils, Classes, Controls, Forms, Dialogs, CadMod, Encryp, Enter, Menus,
  Buttons, StdCtrls, ExtCtrls, ComCtrls, ToolWin, ToolEdit, CurrEdit, Mask,
  DataManager, VirtualTrees;

type
  TCdRodovias = class(TCdModelo)
    ePk_Rodovias: TEdit;
    lPk_Rodovias: TStaticText;
    lDsc_Rod: TStaticText;
    eDsc_Rod: TEdit;
    lExt_Tot_Rod: TStaticText;
    eExt_Tot_Rod: TCurrencyEdit;
    eExt_Rod_Polo: TCurrencyEdit;
    lExt_Rod_Polo: TStaticText;
    lKm_Ini: TStaticText;
    eKm_Ini: TCurrencyEdit;
    eKm_Fin: TCurrencyEdit;
    lKm_Fin: TStaticText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdRodovias: TCdRodovias;

implementation

uses mSysSrv;

{$R *.dfm}

procedure TCdRodovias.FormCreate(Sender: TObject);
begin
//  ' where FK_EMPRESAS = :FkEmpresas ';
  dsMain.DataSet    := dmSysSrv.Rodovia;
  dsMain.TableName  := 'RODOVIAS';
  dsMain.MainPrefix := 'Rod';
  dsMain.PrimaryKey.Add('PK_RODOVIAS');
//  SyncWhere.Add(SYNC_WHERE);
  inherited;
end;

initialization
  RegisterClass(TCdRodovias);
end.
