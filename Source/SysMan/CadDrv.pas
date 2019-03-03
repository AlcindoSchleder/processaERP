unit CadDrv;

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
{*                                                                        *}
{*************************************************************************}

interface

uses SysUtils, Classes, ProcType, CadMod, CurrEdit, TSysMan, Mask, ProcUtils,
  GridRow, Encryp, Enter, prcNavigator, VirtualTrees, TSysGen,
  DataManager,
  {$IFDEF LINUX}
    Qt, QGraphics, QControls, QForms, QDialogs, QMenus, QButtons, QStdCtrls,
    QExtCtrls, QComCtrls, QToolWin, QToolEdit, StdCtrls, Menus, ComCtrls,
  ToolWin, Buttons, Controls, ExtCtrls
  {$ELSE}
    Windows, Controls, Forms, Dialogs, Menus, Buttons, StdCtrls, ExtCtrls,
    ComCtrls, ToolWin, ToolEdit
  {$ENDIF};

type
  TCdDriver = class(TCdModelo)
    ePk_Drivers: TEdit;
    eDsc_Drv: TEdit;
    gbComImpr: TGroupBox;
    eMod_Neg: TEdit;
    eCan_Exp: TEdit;
    eMod_Exp: TEdit;
    eCan_Itl: TEdit;
    eMod_Itl: TEdit;
    eCan_Cnd: TEdit;
    eMod_Cnd: TEdit;
    eCmp_Pag: TEdit;
    eNov_Pag: TEdit;
    eCan_Neg: TEdit;
    eIni_Imp: TEdit;
    lPk_Drivers: TStaticText;
    lDsc_Drv: TStaticText;
    lIni_Imp: TStaticText;
    lMod_Itl: TStaticText;
    lNov_Pag: TStaticText;
    lCmp_Pag: TStaticText;
    lMod_Cnd: TStaticText;
    lCan_Cnd: TStaticText;
    lCan_Itl: TStaticText;
    lMod_Exp: TStaticText;
    lCan_Exp: TStaticText;
    lMod_Neg: TStaticText;
    lCan_Neg: TStaticText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdDriver: TCdDriver;

implementation

uses mSysMan, ManArqSql, Dado, CmmConst, ModelTyp;

{$R *.dfm}

procedure TCdDriver.FormCreate(Sender: TObject);
begin
  dsMain.DataSet       := dmSysMan.Driver;
  dsMain.MethodExecSql := dmSysMan.Driver.ExecSQL;
  dsMain.TableName     := 'DRIVERS';
  dsMain.MainPrefix    := 'Drv';
  dsMain.PrimaryKey.Add('PK_DRIVERS');
  gbComImpr.Caption    := Dados.GetStringMessage(LANGUAGE, 'sgbComImpr',
    'Comandos da Impressora');
  inherited;
end;

initialization
  Classes.RegisterClass(TCdDriver);
end.
