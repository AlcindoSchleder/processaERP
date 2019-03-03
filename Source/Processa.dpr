program Processa;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 0.8.5.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

uses
  Forms,
  PrcPrgms,
  ProcType,
  Menu in 'Menu.pas' {fProcessa},
  mMenu in 'mMenu.pas' {dmMenu: TDataModule},
  Senha in 'Senha.pas' {FSenha},
  mArqSql in 'mArqSql.pas',
  ClientMsg in 'ClientMsg.pas' {frmClientChat};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Sistema Processa E.R.P. Open Source';
  Application.CreateForm(TFSenha, FSenha);
  Application.CreateForm(TdmMenu, dmMenu);
  Application.Run;
end.

