unit CadOpe;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.2.0.0                                                      *}
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
  Menus, StdCtrls, ExtCtrls, ComCtrls, ToolWin, Buttons, Encryp, ProcType,
  ToolEdit, CurrEdit, DataManager, VirtualTrees, Mask, ProcUtils;

type
  TCdOperador = class(TCdModelo)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure EncryptPasswd(const New, Actual: string; const SaveDB: Boolean);
  public
    { Public declarations }
  end;

implementation

uses mSysMan, ManArqSql, Dado, CmmConst, SqlComm, AltPass, ForeTabl, ModelTyp,
     TSysManAux, TSysCad, TSysGen;

{$R *.dfm}

const
  JOIN_TABLES: array [1..2] of string =
     ('CADASTROS', 'LINGUAGENS');
  JOIN_Prefix: array [1..2] of string =
     ('Cad', 'Lng');
  JOIN_SELECT: array [1..2] of string =
     ('RAZ_SOC', 'DSC_LANG');
  JOIN_MAIN  : array [1..2] of string =
     ('FK_CADASTROS', 'FK_LINGUAGENS');
  JOIN_FIELDS: array [1..2] of string =
     ('PK_CADASTROS=FK_CADASTROS', 'PK_LINGUAGENS=FK_CADASTROS');

procedure TCdOperador.FormCreate(Sender: TObject);
var
  aItem: TForeignTable;
  i    : Integer;
begin
  dsMain.DataSet       := dmSysMan.Operador;
  dsMain.MethodExecSql := dmSysMan.Operador.ExecSQL;
  dsMain.TableName     := 'OPERADORES';
  dsMain.MainPrefix    := 'Ope';
  dsMain.PrimaryKey.Add('PK_OPERADORES');
  for i := 1 to 2 do
  begin
    aItem             := dsMain.ForeignTables.Add;
    aItem.TableName   := JOIN_TABLES[i];
    aItem.JoinType    := jtLeftOuterJoin;
    aItem.JoinPrefix  := JOIN_PREFIX[i];
    aItem.SelectField := JOIN_SELECT[i];
    aItem.MainField   := JOIN_MAIN[i];
    aItem.JoinFields.Add(JOIN_FIELDS[i]);
  end;
  inherited;
  Dados.Image16.GetBitmap(5, bbAltPasswd.Glyph);
  Dados.Image16.GetBitmap(24, sbAltPwdDB.Glyph);
  sbAltPwdDB.Hint := Dados.GetStringMessage(LANGUAGE, 'sAltPwdDB',
    'Altera a senha de Acesso ao Sistema');
  eFk_Linguagens.Items.AddStrings(dmSysMan.LoadLanguage);
  eFk_Cadastros.Items.AddStrings(dmSysMan.LoadOwners(SqlFuncionarios));
end;


initialization
   RegisterClass(TCdOperador);
end.
