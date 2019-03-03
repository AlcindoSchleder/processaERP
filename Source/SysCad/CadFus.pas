unit CadFus;    

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
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
  Windows, Messages, SysUtils, Classes, Controls, Forms, CadMod, Enter, Menus,
  Buttons, StdCtrls, ExtCtrls, ComCtrls, ToolWin, Mask, ProcType, Encryp,
  ToolEdit, CurrEdit, DataManager, VirtualTrees;

type
  TCdFusoes = class(TCdModelo)
    pcControl: TPageControl;
    tsFusoes: TTabSheet;
    tsCollectionAddress: TTabSheet;
    lFk_Paises: TStaticText;
    eFk_Paises: TComboBox;
    eFk_Estados: TComboBox;
    lFk_Estados: TStaticText;
    lFk_Municipios: TStaticText;
    eFk_Municipios: TComboBox;
    sbCallPais_cbr: TSpeedButton;
    sbCallUf_cbr: TSpeedButton;
    sbCallMun_cbr: TSpeedButton;
    eCod_Bai_cbr: TComboBox;
    lEnd_Cbr: TStaticText;
    eCod_Loc_cbr: TComboBox;
    sbFindLocal_cbr: TSpeedButton;
    sbFindCep_cbr: TSpeedButton;
    lNum_Cbr: TStaticText;
    lCmp_Cbr: TStaticText;
    eCmp_Cbr: TEdit;
    sbFindBai_cbr: TSpeedButton;
    lCxp_Cbr: TStaticText;
    eCxp_Cbr: TEdit;
    lFax_Cbr: TStaticText;
    eFax_Cbr: TEdit;
    eFon_Cbr: TEdit;
    lFon_Cbr: TStaticText;
    eEnd_Cbr: TEdit;
    lCep_Cbr: TStaticText;
    eCep_Cbr: TCurrencyEdit;
    eNum_Cbr: TCurrencyEdit;
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


initialization
  RegisterClass(TCdFusoes);
end.
