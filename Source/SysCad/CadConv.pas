unit CadConv;             

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
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, CadMod,
  Enter, Menus, Buttons, StdCtrls, ExtCtrls, ComCtrls, ToolWin, ProcType,
  Encryp, ToolEdit, CurrEdit, DataManager, VirtualTrees, CheckLst, Mask;

type
  TCdConvenios = class(TCdModelo)
    pcControl: TPageControl;
    tsAgreement: TTabSheet;
    tsAccorded: TTabSheet;
    lCxp_Cbr: TStaticText;
    eDsc_Fsc: TEdit;
    lDsc_Fsc: TStaticText;
    lFk_Clientes: TStaticText;
    eFlag_Day: TCheckBox;
    lDay_Fat: TStaticText;
    eDay_Fat: TEdit;
    lNameAgreement: TStaticText;
    lFk_Clientes__Acc: TStaticText;
    lFlag_Fat: TCheckBox;
    lTot_Cmp: TStaticText;
    clbCategories: TCheckListBox;
    eFk_Clientes: TComboBox;
    eFk_Clientes__Acc: TComboBox;
    eTot_Cmp: TCurrencyEdit;
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
  RegisterClass(TCdConvenios);
end.
