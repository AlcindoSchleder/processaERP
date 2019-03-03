unit CadDic;

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

uses SysUtils, Classes, ProcType, CurrEdit, TSysMan, Mask, ProcUtils,
  GridRow, Encryp, Enter, VirtualTrees, TSysGen, DataManager, DB,
  {$IFDEF WIN32}
    Windows, Controls, Forms, Dialogs, Menus, Buttons, StdCtrls, ExtCtrls,
    ComCtrls, ToolWin, ToolEdit
  {$ELSE}
    Qt, QGraphics, QControls, QForms, QDialogs, QMenus, QButtons, QStdCtrls,
    QExtCtrls, QComCtrls, QToolWin, QToolEdit
  {$ENDIF};

type
  TCdDictionary = class(TCdModelo)
    eDsc_Fld: TEdit;
    ePk_Dicionarios__Na: TComboBox;
    ePk_Dicionarios__Nc: TComboBox;
    eDsc_Lbl: TEdit;
    eMsk_Fld: TEdit;
    sbGetMask: TSpeedButton;
    eNom_Obj: TEdit;
    eDsc_Frgn: TEdit;
    lFk_Linguagens: TStaticText;
    eFk_Linguagens: TComboBox;
    lPk_Dicionarios__Na: TStaticText;
    lPk_Dicionarios__Nc: TStaticText;
    lNom_Obj: TStaticText;
    lDsc_Fld: TStaticText;
    lDsc_Lbl: TStaticText;
    lDsc_Frgn: TStaticText;
    lMsk_Fld: TStaticText;
    lPos_Fld: TStaticText;
    eMaskFld: TComboBox;
    ePos_Fld: TCurrencyEdit;
    pgDicData: TPageControl;
    tsBasicData: TTabSheet;
    tsDicValues: TTabSheet;
    lMaskTest: TStaticText;
    eMaskTest: TMaskEdit;
    lFlag_Frgn: TCheckBox;
    lFlag_Key: TCheckBox;
    lFlag_Qry: TCheckBox;
    lFlag_Find: TCheckBox;
    lFlag_Edit: TCheckBox;
    lFlag_Vis: TCheckBox;
    lFlag_ObjV: TCheckBox;
    lFlag_Val: TCheckBox;
    lFlag_Flag: TCheckBox;
    pgFields: TPageControl;
    tsListFiels: TTabSheet;
    tsDataFields: TTabSheet;
    cbToolsVal: TCoolBar;
    tbValueTools: TToolBar;
    tbInsVal: TToolButton;
    tbDelVal: TToolButton;
    tbCancelVal: TToolButton;
    tbSepVal: TToolButton;
    tbSaveVal: TToolButton;
    pgValues: TPageControl;
    tsListValue: TTabSheet;
    tsDataValue: TTabSheet;
    vtDicValues: TVirtualStringTree;
    eCmp_Val: TEdit;
    lCmp_Val: TStaticText;
    lDsc_Val: TStaticText;
    eDsc_Val: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbGetMaskClick(Sender: TObject);
    procedure eDsc_FldChange(Sender: TObject);
    procedure ePk_Dicionarios__NcSelect(Sender: TObject);
    procedure ePk_Dicionarios__NaSelect(Sender: TObject);
    procedure dsMainAfterPost(Sender: TObject);
    procedure eMaskFldChange(Sender: TObject);
    procedure dsMainSetFieldEditor(ASender: TObjectLink;
      AControl: TControl; AField: TDataField);
    procedure pgDicDataChange(Sender: TObject);
    procedure tbDelValClick(Sender: TObject);
    procedure vtDicValuesFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtDicValuesDblClick(Sender: TObject);
    procedure tbInsValClick(Sender: TObject);
    procedure tbCancelValClick(Sender: TObject);
    procedure tbSaveValClick(Sender: TObject);
    procedure dsMainGetDictionary(Sender: TObject; APopulateSql: Boolean;
      var ALoaded: Boolean);
    procedure lFlag_ValClick(Sender: TObject);
    procedure dsMainBeforePost(ASender: TDataManager; ADataRow: TDataRow;
      Mode: TDBMode);
  private
    { Private declarations }
    FFileAnt  : string;
    FItemSaved: Boolean;
    procedure SaveValues(ARow: TDataRow);
    procedure EnableValButtons(AEnabled: Boolean);
    procedure SetDicValuesTab;
  public
    { Public declarations }
  end;

implementation

uses mSysMan, CmmConst, ManArqSql, Dado, ForeTabl, ModelTyp, FuncoesDB, Funcoes,
  Variants, TypInfo;

{$R *.dfm}

procedure TCdDictionary.FormCreate(Sender: TObject);
var
  aItem: TForeignTable;
begin
  FItemSaved                := False;
  vtDicValues.Images        := Dados.Image16;
  vtDicValues.Header.Images := Dados.Image16;
  tbValueTools.Images       := Dados.Image16;
  cbToolsVal.Images         := Dados.Image16;
  dsMain.DataSet            := dmSysMan.Dicionario;
  dsMain.MethodExecSql      := dmSysMan.Dicionario.ExecSQL;
  dsMain.TableName          := 'DICIONARIOS';
  dsMain.MainPrefix         := 'Dic';
  dsMain.PrimaryKey.Add('FK_LINGUAGENS');
  dsMain.PrimaryKey.Add('PK_DICIONARIOS__NA');
  dsMain.PrimaryKey.Add('PK_DICIONARIOS__NC');
  aItem             := dsMain.ForeignTables.Add;
  aItem.TableName   := 'LINGUAGENS';
  aItem.JoinType    := jtLeftOuterJoin;
  aItem.JoinPrefix  := 'Lng';
  aItem.SelectField := 'DSC_LANG';
  aItem.MainField   := 'FK_LINGUAGENS';
  aItem.JoinFields.Add('PK_LINGUAGENS=FK_LINGUAGENS');
  inherited;
  pgDicData.Images := Dados.Image16;
  eFk_Linguagens.Items.AddStrings(dmSysMan.LoadLanguage);
  eMaskFld.Items.AddStrings(dmSysMan.LoadMasks);
  Dados.Conexao.GetTableNames(ePk_Dicionarios__Na.Items);
  Dados.Image16.GetBitmap(1, sbGetMask.Glyph);
  FFileAnt       := '';
  SetTreeEvents(vtDicValues, [vteCompareNodes, vteGetText]);
  tsDicValues.TabVisible := False;
end;

procedure TCdDictionary.FormDestroy(Sender: TObject);
begin
  inherited;
  ReleaseCombos(eFk_Linguagens, toObject);
end;

procedure TCdDictionary.sbGetMaskClick(Sender: TObject);
begin
  eMaskFld.Visible := not eMaskFld.Visible;
end;

procedure TCdDictionary.eDsc_FldChange(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (dsMain.State = dbmInsert) then
    eDsc_Lbl.Text := '&' + dsMain.DataRow.FieldByName['DSC_FLD'].AsString + ':';
end;

procedure TCdDictionary.ePk_Dicionarios__NcSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (dsMain.State = dbmInsert) then
    eNom_Obj.Text := dsMain.DataRow.FieldByName['PK_DICIONARIOS__NC'].AsString;
end;

procedure TCdDictionary.ePk_Dicionarios__NaSelect(Sender: TObject);
begin
  inherited ChangeGlobal(Sender);
  Dados.Conexao.GetFieldNames(ePk_Dicionarios__Na.Text, ePk_Dicionarios__Nc.Items);
end;

procedure TCdDictionary.dsMainAfterPost(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (dsMain.DataRow.FindField['FLAG_VAL'] <> nil) and
     (dsMain.DataRow.FindField['FLAG_VAL'].AsBoolean) then
  begin
    dsMainStartTransaction(Self);
    with dmSysMan do
    begin
      ValorCampo.SQL.Clear;
      ValorCampo.SQL.Add(SQLDeleteValorCampos);
      ValorCampo.Params.ParamByName('fklinguagens').AsString    :=
        dsMain.DataRow.FindField['FK_LINGUAGENS'].AsString;
      ValorCampo.ParamByName('fkdicionariosna').AsString :=
        dsMain.DataRow.FindField['FK_DICIONARIOS__NA'].AsString;
      ValorCampo.ParamByName('fkdicionariosnc').AsString :=
        dsMain.DataRow.FindField['FK_DICIONARIOS__NC'].AsString;
      ValorCampo.ExecSQL;
    end;
    dsMainCommitTransaction(Self);
    if vtDicValues.RootNodeCount = 0 then exit;
    Node := vtDicValues.GetFirst;
    while Node <> nil do
    begin
      Data := vtDicValues.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
        SaveValues(Data^.DataRow);
      Node := vtDicValues.GetNext(Node);
    end;
  end;
  FItemSaved                := False;
end;

procedure TCdDictionary.SaveValues(ARow: TDataRow);
begin
  if (ARow = nil) or (ARow.Count = 0) then exit;
  with dmSysMan do
  begin
    if ValorCampo.Active then ValorCampo.Close;
    ValorCampo.SQL.Clear;
    ValorCampo.SQL.Add(SQLInsertValorCampos);
    dsMainStartTransaction(Self);
    try
      ValorCampo.Params.ParamByName('fklinguagens').AsString    :=
        dsMain.DataRow.FindField['FK_LINGUAGENS'].AsString;
      ValorCampo.ParamByName('fkdicionariosna').AsString :=
        dsMain.DataRow.FindField['FK_DICIONARIOS__NA'].AsString;
      ValorCampo.ParamByName('fkdicionariosnc').AsString :=
        dsMain.DataRow.FindField['FK_DICIONARIOS__NC'].AsString;
      ValorCampo.Params.FindParam('pkvalorcampos').AsInteger  := 0;
      ValorCampo.Params.FindParam('cmpval').AsString :=
          ARow.FindField['CMP_VAL'].AsString;
      ValorCampo.Params.FindParam('dscval').AsString :=
          ARow.FindField['DSC_VAL'].AsString;
      ValorCampo.ExecSQL;
    finally
      dsMainCommitTransaction(Self);
    end;
  end;
end;

procedure TCdDictionary.eMaskFldChange(Sender: TObject);
begin
  eMsk_Fld.Text := '';
  if eMaskFld.ItemIndex > -1 then
    eMsk_Fld.Text := Copy(eMaskFld.Text, 1, Pos(' ==> ', eMaskFld.Text));
end;

procedure TCdDictionary.dsMainSetFieldEditor(ASender: TObjectLink;
  AControl: TControl; AField: TDataField);
begin
  if (AField.FieldName = 'FK_LINGUAGENS') then
  begin
    ASender.PropertyType   := ptItems;
    ASender.ListTypeObject := toObject;
    AField.FieldFlags      := AField.FieldFlags + [ffList];
    if (not AField.IsForeignKey) then
      AField.FieldFlags      := AField.FieldFlags + [ffForeignKey];
  end;
  if (AField.FieldName = 'PK_DICIONARIOS__NA') or
     (AField.FieldName = 'PK_DICIONARIOS__NC') or
     (AField.FieldName = 'MASK_FLD') then
  begin
    ASender.PropertyType    := ptText;
    ASender.PropToStoreCtrl := 'Items';
    ASender.ListTypeObject  := toNone;
    AField.FieldFlags       := AField.FieldFlags + [ffList];
  end;
end;

procedure TCdDictionary.pgDicDataChange(Sender: TObject);
var
  Node: PVirtualNode;
begin
  pgValues.ActivePageIndex := 0;
  EnableValButtons(True);
  if (vtDicValues.RootNodeCount = 0) then exit;
  Node := vtDicValues.GetFirst;
  if (Node = nil) then exit;
  vtDicValues.FocusedNode := Node;
  vtDicValues.Selected[Node] := True;
end;

procedure TCdDictionary.tbDelValClick(Sender: TObject);
var
  NextFocus,
  Node: PVirtualNode;
begin
  if (vtDicValues.RootNodeCount = 0) then exit;
  Node := vtDicValues.FocusedNode;
  if (Node = nil) then exit;
  NextFocus := vtDicValues.GetNext(Node);
  vtDicValues.DeleteNode(Node);
  if (vtDicValues.RootNodeCount = 0) then exit;
  if (NextFocus = nil) then
  begin
    Node := vtDicValues.GetFirst;
    if (Node = nil) then exit;
    vtDicValues.FocusedNode := Node;
    vtDicValues.Selected[Node] := True;
  end
  else
  begin
    vtDicValues.FocusedNode := NextFocus;
    vtDicValues.Selected[NextFocus] := True;
  end;
end;

procedure TCdDictionary.vtDicValuesFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := vtDicValues.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  eCmp_Val.Text := Data^.DataRow.FieldByName['CMP_VAL'].AsString;
  eDsc_Val.Text := Data^.DataRow.FieldByName['DSC_VAL'].AsString;
end;

procedure TCdDictionary.vtDicValuesDblClick(Sender: TObject);
begin
  EnableValButtons(False);
  
  pgValues.ActivePageIndex := 1;
end;

procedure TCdDictionary.tbInsValClick(Sender: TObject);
begin
  EnableValButtons(False);
  pgValues.ActivePageIndex := 1;
  eCmp_Val.Text := '';
  eDsc_Val.Text := '';
  vtDicValues.FocusedNode := nil;
  dsMain.Edit;
  tbInsVal.Tag := -1;
end;

procedure TCdDictionary.EnableValButtons(AEnabled: Boolean);
begin
  tbInsVal.Enabled    := AEnabled;
  tbDelVal.Enabled    := AEnabled;
  tbSaveVal.Enabled   := not AEnabled;
  tbCancelVal.Enabled := not AEnabled;
end;

procedure TCdDictionary.tbCancelValClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  pgValues.ActivePageIndex := 0;
  EnableValButtons(True);
  if (vtDicValues.RootNodeCount = 0) then exit;
  Node := vtDicValues.GetLast;
  if (Node = nil) then exit;
  vtDicValues.FocusedNode := Node;
  vtDicValues.Selected[Node] := True;
  dsMain.Cancel;
end;

procedure TCdDictionary.tbSaveValClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  pgValues.ActivePageIndex := 0;
  EnableValButtons(True);
  if vtDicValues.FocusedNode = nil then
    Node := vtDicValues.AddChild(nil)
  else
    Node := vtDicValues.FocusedNode;
  if (Node = nil) then exit;
  Data := vtDicValues.GetNodeData(Node);
  if (Data = nil) then exit;
  if (tbInsVal.Tag = -1) then
  begin
    Data^.Level   := 0;
    Data^.Node    := Node;
    Data^.DataRow := TDataRow.Create(nil);
    tbInsVal.Tag  := 0;
  end;
  if (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FindField['CMP_VAL'] = nil) then
    Data^.DataRow.AddAs('CMP_VAL', eCmp_Val.Text, ftString, Length(eCmp_Val.Text) + 1)
  else
    Data^.DataRow.FieldByName['CMP_VAL'].AsString := eCmp_Val.Text;
  if (Data^.DataRow.FindField['DSC_VAL'] = nil) then
    Data^.DataRow.AddAs('DSC_VAL', eDsc_Val.Text, ftString, Length(eDsc_Val.Text) + 1)
  else
    Data^.DataRow.FieldByName['DSC_VAL'].AsString := eDsc_Val.Text;
  vtDicValues.FocusedNode := Node;
  vtDicValues.Selected[Node] := True;
  FItemSaved := True;
end;

procedure TCdDictionary.SetDicValuesTab;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  tsDicValues.TabVisible := (dsMain.DataRow.FindField['FLAG_VAL'].AsInteger = 1) and
                            (dsMain.State <> dbmFind);
  if not tsDicValues.TabVisible then exit;
  ReleaseTreeNodes(vtDicValues);
  with dmSysMan do
  begin
    if ValorCampo.Active then ValorCampo.Close;
    ValorCampo.SQL.Clear;
    ValorCampo.SQL.Add(SqlValorCampos);
    dsMainStartTransaction(Self);
    vtDicValues.BeginUpdate;
    try
      ValorCampo.Params.ParamByName('fklinguagens').AsString    :=
        dsMain.DataRow.FindField['FK_LINGUAGENS'].AsString;
      ValorCampo.ParamByName('fkdicionariosna').AsString :=
        dsMain.DataRow.FindField['FK_DICIONARIOS__NA'].AsString;
      ValorCampo.ParamByName('fkdicionariosnc').AsString :=
        dsMain.DataRow.FindField['FK_DICIONARIOS__NC'].AsString;
      if not ValorCampo.Active then ValorCampo.Open;
      while not ValorCampo.Eof do
      begin
        Node := vtDicValues.AddChild(nil);
        if Node <> nil then
        begin
          Data := vtDicValues.GetNodeData(Node);
          if Data <> nil then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, ValorCampo, True);
          end;
        end;
        ValorCampo.Next;
      end;
    finally
      if ValorCampo.Active then ValorCampo.Close;
      dsMainCommitTransaction(Self);
      vtDicValues.EndUpdate;
    end;
  end;
end;

procedure TCdDictionary.dsMainGetDictionary(Sender: TObject;
  APopulateSql: Boolean; var ALoaded: Boolean);
begin
  inherited;
  dsMain.DataRow.FieldByName['FK_LINGUAGENS'].DefaultValue      := LANGUAGE;
  dsMain.DataRow.FieldByName['FLAG_FIND'].DefaultValue          := FLAG_SIM;
  dsMain.DataRow.FieldByName['FLAG_QRY'].DefaultValue           := FLAG_SIM;
  dsMain.DataRow.FieldByName['FLAG_KEY'].DefaultValue           := FLAG_NAO;
  dsMain.DataRow.FieldByName['FLAG_VAL'].DefaultValue           := FLAG_NAO;
  dsMain.DataRow.FieldByName['FLAG_EDIT'].DefaultValue          := FLAG_SIM;
  dsMain.DataRow.FieldByName['FLAG_VIS'].DefaultValue           := FLAG_SIM;
  dsMain.DataRow.FieldByName['FLAG_FRGN'].DefaultValue          := FLAG_NAO;
  dsMain.DataRow.FieldByName['FLAG_FLAG'].DefaultValue          := FLAG_NAO;
  dsMain.DataRow.FieldByName['FLAG_OBJV'].DefaultValue          := FLAG_NAO;
end;

procedure TCdDictionary.lFlag_ValClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (not dsMain.Browsing) then exit;
  tsDicValues.TabVisible := (dsMain.State <> dbmFind) and (lFlag_Val.Checked);
  SetDicValuesTab;
end;

procedure TCdDictionary.dsMainBeforePost(ASender: TDataManager;
  ADataRow: TDataRow; Mode: TDBMode);
begin
  inherited;
  dsMain.DataRow.FieldByName['PK_DICIONARIOS__NA'].DefaultValue :=
    ADataRow.FieldByName['PK_DICIONARIOS__NA'].Value;
end;

initialization
  Classes.RegisterClass(TCdDictionary);
end.

