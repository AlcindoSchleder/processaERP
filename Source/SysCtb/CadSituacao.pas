unit CadSituacao;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/06/2003 - DD/MM/YYYY                                      *}
{* Modified: 03/06/2003 - DD/MM/YYYY                                     *}
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
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms, Dialogs,
  CadMod, Encryp, Enter, Menus, Buttons, StdCtrls, ExtCtrls, ComCtrls, ToolWin,
  DataManager, VirtualTrees;

type
  TCdSitTribut = class(TCdModelo)
    lPk_Situacao_Tributaria: TStaticText;
    ePk_Situacao_Tributaria: TEdit;
    lDsc_Impst: TStaticText;
    eDsc_Impst: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdSitTribut: TCdSitTribut;

implementation

uses mSysCtb;

{$R *.dfm}

procedure TCdSitTribut.FormCreate(Sender: TObject);
begin
  dsMain.DataSet       := dmSysCtb.qrSituacaoTribut;
  dsMain.MethodExecSql := dmSysCtb.qrSituacaoTribut.ExecSQL;
  dsMain.TableName     := 'SITUACAO_TRIBUTARIAS';
  dsMain.MainPrefix    := 'Str';
  dsMain.PrimaryKey.Add('PK_SITUACAO_TRIBUTARIA');
  inherited;
end;

initialization
  RegisterClass(TCdSitTribut);
end.
