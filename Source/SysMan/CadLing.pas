unit CadLing;

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
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, CadMod, Enter,
  Menus, Buttons, StdCtrls, ExtCtrls, ComCtrls, ToolWin, Encryp,
  DataManager, prcNavigator, VirtualTrees;

type
  TCdLinguagem = class(TCdModelo)
    ePk_Linguagens: TEdit;
    eDsc_Lang: TEdit;
    lPk_Linguagens: TStaticText;
    lDsc_Lang: TStaticText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses mSysMan, ManArqSql, SqlComm;

{$R *.dfm}

procedure TCdLinguagem.FormCreate(Sender: TObject);
begin
  dsMain.DataSet       := dmSysMan.Linguagem;
  dsMain.MethodExecSql := dmSysMan.Linguagem.ExecSQL;
  dsMain.TableName     := 'LINGUAGENS';
  dsMain.MainPrefix    := 'Lng';
  dsMain.PrimaryKey.Add('PK_LINGUAGENS');
  inherited;
end;

initialization
   RegisterClass(TCdLinguagem);
end.
