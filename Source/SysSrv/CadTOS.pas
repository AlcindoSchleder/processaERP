unit CadTOS;            

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
  Buttons, StdCtrls, ExtCtrls, ComCtrls, ToolWin, Mask, DataManager,
  VirtualTrees;

type
  TCdTipoOS = class(TCdModelo)
    lPk_Tipo_Ordens_Servicos: TStaticText;
    ePk_Tipo_Ordens_Servicos: TEdit;
    lFk_Tipo_Documentos: TStaticText;
    eFk_Tipo_Documentos: TComboBox;
    eDsc_Tos: TEdit;
    lDsc_Tos: TStaticText;
    lFlag_TOS: TRadioGroup;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses mSysSrv, SrvArqSql;

{$R *.dfm}

const
  SYNC_FROM   =
  '  from TIPO_ORDENS_SERVICOS Tos '       + #13 +
  '  left outer join TIPO_DOCUMENTOS Tdc ' + #13 +
  '    on Tdc.PK_RODOVIAS = Tos.FK_TIPO_DOCUMENTOS ';

procedure TCdTipoOS.FormCreate(Sender: TObject);
begin
  dsMain.DataSet    := dmSysSrv.TipoOS;
  dsMain.TableName  := 'TIPO_ORDENS_SERVICOS';
  dsMain.MainPrefix := 'Tos';
  dsMain.PrimaryKey.Add('PK_TIPO_ORDENS_SERVICOS');
//  SyncFrom.Add(SYNC_FROM);
//  SyncFields.Add('FK_TIPO_DOCUMENTOS=Tdc.DSC_TDOC');
  inherited;
end;

initialization
  RegisterClass(TCdTipoOS);
end.
