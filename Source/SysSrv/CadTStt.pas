unit CadTStt;   

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
  SysUtils, Classes, Controls, Forms, Dialogs, CadMod, StdCtrls, ExtCtrls, Mask,
  Encryp, Enter, Menus, Buttons, ComCtrls, ToolWin, DataManager, VirtualTrees;

type
  TCdTSttOS = class(TCdModelo)
    ePk_Tipo_Status_OS: TEdit;
    lPk_Tipo_Status_OS: TStaticText;
    lDsc_Stt: TStaticText;
    eDsc_Stt: TEdit;
    lFlag_Stt: TRadioGroup;
    lFlag_Aut: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses mSysSrv;

{$R *.dfm}

procedure TCdTSttOS.FormCreate(Sender: TObject);
begin
  dsMain.DataSet    := dmSysSrv.TipoStatus;
  dsMain.TableName  := 'TIPO_STATUS_OS';
  dsMain.MainPrefix := 'Tso';
  dsMain.PrimaryKey.Add('PK_TIPO_STATUS_OS');
  inherited;
end;

initialization
  RegisterClass(TCdTSttOS);
end.
