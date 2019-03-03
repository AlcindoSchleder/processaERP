unit CadImpr;

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
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, CadMod,
  StdCtrls, Enter, Menus, Buttons, ExtCtrls, ComCtrls, ToolWin, GridRow,
  Encryp, DataManager, prcNavigator, VirtualTrees;

type
  TCdImpressoras = class(TCdModelo)
    eMap_Imp: TEdit;
    eDsc_Imp: TEdit;
    eUnc_Name: TEdit;
    lFlag_Cpm: TCheckBox;
    ePk_Impressoras: TEdit;
    lImp_Fsc: TRadioGroup;
    lFlag_IFsc: TCheckBox;
    eFk_Drivers: TComboBox;
    eFk_Tipo_Documentos: TComboBox;
    lPk_Impressoras: TStaticText;
    lMap_Imp: TStaticText;
    lDsc_Imp: TStaticText;
    lUnc_Name: TStaticText;
    lFk_Drivers: TStaticText;
    lFk_Tipo_Documentos: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure dsMainGetDictionary(Sender: TObject; APopulateSql: Boolean;
      var ALoaded: Boolean);
    procedure dsMainSetFieldEditor(ASender: TObjectLink;
      AControl: TControl; AField: TDataField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses mSysMan, ManArqSql, ForeTabl, ModelTyp, CmmConst, ArqCnst, ProcUtils;

{$R *.dfm}

procedure TCdImpressoras.FormCreate(Sender: TObject);
var
  aItem: TForeignTable;
begin
  dsMain.DataSet       := dmSysMan.Impressora;
  dsMain.MethodExecSql := dmSysMan.Impressora.ExecSQL;
  dsMain.TableName     := 'IMPRESSORAS';
  dsMain.MainPrefix    := 'Imp';
  dsMain.PrimaryKey.Add('PK_IMPRESSORAS');
  aItem             := dsMain.ForeignTables.Add;
  aItem.TableName   := 'TIPO_DOCUMENTOS';
  aItem.JoinType    := jtLeftOuterJoin;
  aItem.JoinPrefix  := 'Tdc';
  aItem.SelectField := 'DSC_TDOC';
  aItem.MainField   := 'FK_TIPO_DOCUMENTOS';
  aItem.JoinFields.Add('PK_TIPO_DOCUMENTOS=FK_TIPO_DOCUMENTOS');
  aItem             := dsMain.ForeignTables.Add;
  aItem.TableName   := 'DRIVERS';
  aItem.JoinType    := jtLeftOuterJoin;
  aItem.JoinPrefix  := 'Drv';
  aItem.SelectField := 'DSC_DRV';
  aItem.MainField   := 'FK_DRIVERS';
  aItem.JoinFields.Add('PK_DRIVERS=FK_DRIVERS');
  inherited;
  eFk_Tipo_Documentos.Items.AddStrings(dmSysMan.LoadTypeDocs);
  eFk_Drivers.Items.AddStrings(dmSysMan.LoadDrivers);
end;

procedure TCdImpressoras.dsMainGetDictionary(Sender: TObject;
  APopulateSql: Boolean; var ALoaded: Boolean);
begin
  inherited;
  dsMain.DefaultRow.FieldByName['MAP_IMP'].DefaultValue := DEF_LPT_PORT;
end;

procedure TCdImpressoras.dsMainSetFieldEditor(ASender: TObjectLink;
  AControl: TControl; AField: TDataField);
begin
  if (AField <> nil) and ((AField.FieldName = 'FK_TIPO_DOCUMENTOS') or
     (AField.FieldName = 'FK_DRIVERS')) then
  begin
    AField.ObjectLink.PropertyType   := ptItems;
    if (AField.FieldName = 'FK_DRIVERS') then
      AField.ObjectLink.ListTypeObject := toInteger
    else
      AField.ObjectLink.ListTypeObject := toObject;
    AField.FieldFlags                := AField.FieldFlags + [ffList];
    if (not AField.IsForeignKey) then
      AField.FieldFlags              := AField.FieldFlags + [ffForeignKey];
  end;
end;

initialization
   RegisterClass(TCdImpressoras);
end.
