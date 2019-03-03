unit CadParam;     

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
  Buttons, StdCtrls, ExtCtrls, ComCtrls, ToolWin, DataManager, VirtualTrees;

type
  TCdParam = class(TCdModelo)
    lFk_Tipo_Ordens_Servicos: TStaticText;
    eFk_Tipo_Ordens_Servicos: TComboBox;
    lTipo_Status_OS: TStaticText;
    eTipo_Status_OS: TComboBox;
    lFlag_EdtSrv: TCheckBox;
    lFlag_EdtComp: TCheckBox;
    lFlag_EdtVal_Abrt: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses ArqCnst, SrvArqSql, mSysSrv, CmmConst;

{$R *.dfm}

const
  SYNC_FROM   =
  '  from PARAMETROS_SRV Par '                            + NL +
  '  left outer join TIPO_STATUS_OS Tst '                 + NL +
  '    on Tst.PK_TIPO_STATUS_OS = Par.FK_TIPO_STATUS_OS ' + NL +
  '  left outer join TIPO_ORDENS_SERVICOS Tos '           + NL +
  '    on Tos.PK_TIPO_ORDENS_SERVICOS = Par.FK_TIPO_ORDENS_SERVICOS';
  SYNC_WHERE =
  ' where Par.FK_EMPRESAS = :FkEmpresas ';

procedure TCdParam.FormCreate(Sender: TObject);
begin
  dsMain.DataSet    := dmSysSrv.Parametro;
  dsMain.TableName  := 'PARAMETROS_SRV';
  dsMain.MainPrefix := 'Par';
  dsMain.PrimaryKey.Add('FK_EMPRESAS');
//  SyncFrom.Add(SYNC_FROM);
//  SyncWhere.Add(SYNC_WHERE);
//  SyncFields.Add('FK_TIPO_STATUS_OS=Tst.DSC_STT');
//  SyncFields.Add('FK_TIPO_ORDENS_SERVICOS=Tos.DSC_TOS');
  inherited;
end;

initialization
  RegisterClass(TCdParam);
end.
