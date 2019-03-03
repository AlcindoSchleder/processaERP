unit CadLMun;      

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
  Buttons, StdCtrls, ExtCtrls, ComCtrls, ToolWin, ToolEdit, CurrEdit, Mask,
  DataManager, VirtualTrees;

type
  TCdLimites = class(TCdModelo)
    lPk_Limites_Municipios: TStaticText;
    ePk_Limites_Municipios: TEdit;
    lKm_Ini: TStaticText;
    eKm_Ini: TCurrencyEdit;
    lFk_Rodovias: TStaticText;
    eFk_Rodovias: TComboBox;
    lFk_Paises: TStaticText;
    eFk_Paises: TComboBox;
    eFk_Estados: TComboBox;
    lFk_Estados: TStaticText;
    lFk_Municipios: TStaticText;
    eFk_Municipios: TComboBox;
    eKm_Fin: TCurrencyEdit;
    lKm_Fin: TStaticText;
    lFk_Unidades: TStaticText;
    eFk_Unidades: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdLimites: TCdLimites;

implementation

uses mSysSrv, SrvArqSql;

const
  SYNC_FROM   =
  '  from LIMITES_MUNICIPIOS Lmp '                + #13 +
  '  left outer join RODOVIAS Rod '               + #13 +
  '    on Rod.PK_RODOVIAS = Lmp.FK_RODOVIAS '     + #13 +
  '  left outer join UNIDADES Uni '               + #13 +
  '    on Uni.PK_UNIDADES = Lmp.FK_UNIDADES '     + #13 +
  '  left outer join PAISES Pai '                 + #13 +
  '    on Pai.PK_PAISES = Lmp.FK_PAISES '         + #13 +
  '  left outer join ESTADOS Est '                + #13 +
  '    on Est.FK_PAISES  = Lmp.FK_PAISES '        + #13 +
  '   and Est.FK_ESTADOS = Lmp.FK_ESTADOS '       + #13 +
  '  left outer join MUNICIPIOS Mun '             + #13 +
  '    on Mun.FK_PAISES     = Lmp.FK_PAISES '     + #13 +
  '   and Mun.FK_ESTADOS    = Lmp.FK_ESTADOS '    + #13 +
  '   and Mun.FK_MUNICIPIOS = Lmp.FK_MUNICIPIOS ' + #13 +
  '    on Rod.PK_RODOVIAS = Prc.FK_RODOVIAS ';
  SYNC_WHERE =
  ' where Lmp.FK_EMPRESAS = :FkEmpresas ';

{$R *.dfm}

procedure TCdLimites.FormCreate(Sender: TObject);
begin
  dsMain.DataSet   := dmSysSrv.LimiteMunicipio;
  dsMain.TableName  := 'LIMITES_MUNICIPIOS';
  dsMain.MainPrefix := 'Lmn';
  dsMain.PrimaryKey.Add('FK_EMPRESAS');
  inherited;
end;

initialization
  RegisterClass(TCdLimites);
end.
