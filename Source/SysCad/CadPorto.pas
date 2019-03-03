unit CadPorto;                   

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
  Buttons, StdCtrls, ExtCtrls, ComCtrls, ToolWin, Encryp, DataManager,
  VirtualTrees, Mask;

type
  TCdPortos = class(TCdModelo)
    eFk_Paises: TComboBox;
    lPk_Portos: TStaticText;
    ePk_Portos: TEdit;
    lFk_Paises: TStaticText;
    lFk_Estados: TStaticText;
    eFk_Estados: TComboBox;
    eFk_Municipios: TComboBox;
    lFk_Municipios: TStaticText;
    lDsc_Porto: TStaticText;
    eDsc_Porto: TEdit;
    lFon_Porto: TStaticText;
    lFax_Porto: TStaticText;
    eFax_Porto: TEdit;
    lCnt_Porto: TStaticText;
    eCnt_Porto: TEdit;
    eFon_Porto: TMaskEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysCad, ForeTabl, Funcoes, TSysCadAux, ModelTyp, ProcUtils,
  CmmConst;

{$R *.dfm}

const
  JOIN_TABLES: array [1..3] of string =
     ('PAISES', 'ESTADOS', 'MUNICIPIOS');
  JOIN_PREFIX: array [1..3] of string =
     ('Pais', 'Est', 'Mun');
  JOIN_SELECT: array [1..3] of string =
     ('DSC_PAIS', 'DSC_UF', 'DSC_MUN');
  JOIN_MAIN  : array [1..3] of string =
     ('FK_PAISES', 'FK_ESTADOS', 'FK_MUNICIPIOS');
  JOIN_FIELDS: array [1..3, 1..3] of string =
     (('PK_PAISES=FK_PAISES', '', ''),
      ('FK_PAISES=FK_PAISES', 'PK_ESTADOS=FK_ESTADOS', ''),
      ('FK_PAISES=FK_PAISES', 'FK_ESTADOS=FK_ESTADOS', 'PK_MUNICIPIOS=FK_MUNICIPIOS'));

procedure TCdPortos.FormCreate(Sender: TObject);
var
  aItem: TForeignTable;
  i, j : Integer;
begin
  dsMain.DataSet       := dmSysCad.Cadastro;
  dsMain.MethodExecSql := dmSysCad.Cadastro.ExecSQL;
  dsMain.TableName     := 'PORTOS';
  dsMain.MainPrefix    := 'Prt';
  dsMain.PrimaryKey.Add('PK_PORTOS');
  for i := 1 to 3 do
  begin
    aItem             := dsMain.ForeignTables.Add;
    aItem.TableName   := JOIN_TABLES[i];
    aItem.JoinType    := jtLeftOuterJoin;
    aItem.JoinPrefix  := JOIN_PREFIX[i];
    aItem.SelectField := JOIN_SELECT[i];
    aItem.MainField   := JOIN_MAIN[i];
    for j := 1 to 3 do
      if JOIN_FIELDS[i, j] <> '' then
        aItem.JoinFields.Add(JOIN_FIELDS[i, j]);
  end;
  inherited;
  eFk_Paises.Items.AddStrings(dmSysCad.LoadCountries);
end;

initialization
  RegisterClass(TCdPortos);
end.
