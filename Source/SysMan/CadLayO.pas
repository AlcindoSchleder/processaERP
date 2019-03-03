unit CadLayO;

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
  Windows, Messages, SysUtils,Classes, Graphics, Controls, Forms, Dialogs,
  CadMod, StdCtrls, ExtCtrls, ComCtrls, Enter, Menus, Buttons, ToolWin, Encryp,
  DataManager, VirtualTrees, Mask, ToolEdit, CurrEdit, ProcUtils, GridRow;

type
  TLayOutRec = record
    FkTipoDocumento: Integer;
    FkDivisoes     : Integer;
    PkCampos       : Integer;
  end;

  TCdLayOut = class(TCdModelo)
    pInitial: TPanel;
    lFk_Tipo_Documentos: TStaticText;
    eFk_Tipo_Documentos: TComboBox;
    vtFields: TVirtualStringTree;
    pData: TPanel;
    lLin_Cmp: TStaticText;
    eLin_Cmp: TCurrencyEdit;
    lDivision: TStaticText;
    lCol_Cmp: TStaticText;
    eCol_Cmp: TCurrencyEdit;
    lFlag_Frmt: TStaticText;
    eFlag_Frmt: TComboBox;
    eFlag_TDoc: TComboBox;
    lFlag_TDoc: TStaticText;
    eDsc_Cmp: TEdit;
    lDsc_Cmp: TStaticText;
    lCmp_Cmp: TStaticText;
    eCmp_Cmp: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure vtFieldsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtFieldsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure eDsc_CmpChange(Sender: TObject);
    procedure eFk_Tipo_DocumentosChange(Sender: TObject);
    procedure dsMainFindRecords(Sender: TObject; var Allowed: Boolean);
    procedure dsMainBeforePost(ASender: TDataManager; ADataRow: TDataRow;
      Mode: TDBMode);
  private
    { Private declarations }
    FPk: TLayOutRec;
    procedure LoadGrid;
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysMan, ManArqSql, ForeTabl, ProcType, FuncoesDB, ModelTyp,
  CmmConst;

{$R *.dfm}

procedure TCdLayOut.FormActivate(Sender: TObject);
var
  aItem: TForeignTable;
begin
  dsMain.DataSet    := dmSysMan.LayOut;
  dsMain.TableName  := 'LAYOUT';
  dsMain.MainPrefix := 'Cmp';
  aItem             := dsMain.ForeignTables.Add;
  aItem.TableName   := 'DIVISOES';
  aItem.JoinType    := jtLeftOuterJoin;
  aItem.JoinPrefix  := 'Div';
  aItem.SelectField := 'DSC_DIV';
  aItem.MainField   := 'FK_DIVISOES';
  aItem.JoinFields.Add('FK_EMPRESAS=FK_EMPRESAS');
  aItem.JoinFields.Add('FK_TIPO_DOCUMENTOS=FK_TIPO_DOCUMENTOS');
  aItem.JoinFields.Add('PK_DIVISOES=FK_DIVISOES');
  aItem             := dsMain.ForeignTables.Add;
  aItem.TableName   := 'TIPO_DOCUMENTOS';
  aItem.JoinType    := jtLeftOuterJoin;
  aItem.JoinPrefix  := 'Tdc';
  aItem.SelectField := 'DSC_TDOC';
  aItem.MainField   := 'FK_TIPO_DOCUMENTOS';
  aItem.JoinFields.Add('PK_TIPO_DOCUMENTOS=FK_TIPO_DOCUMENTOS');
  vtFields.NodeDataSize := SizeOf(TGridData);
  FPk.FkTipoDocumento := 0;
  FPk.FkDivisoes      := 0;
  inherited;
  eFk_Tipo_Documentos.Items.AddStrings(dmSysMan.LoadTypeDocs);
end;

procedure TCdLayOut.LoadGrid;
var
  Node  ,
  Child : PVirtualNode;
  Data  : PGridData;
  DscDiv: string;
begin
  if FPk.FkTipoDocumento <= 0 then exit;
  if vtFields.RootNodeCount > 0 then
    ReleaseTreeNodes(vtFields);
  with dmSysMan do
  begin
    if Campo.Active then Campo.Close;
    Campo.SQL.Clear;
    Campo.SQL.Add(SqlCampoFields);
    dsMainStartTransaction(Self);
    if Campo.Params.FindParam('FkEmpresas') <> nil then
      Campo.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
    if Campo.Params.FindParam('FkTipoDocumentos') <> nil then
      Campo.Params.FindParam('FkTipoDocumentos').AsInteger := FPk.FkTipoDocumento;
  end;
  DscDiv := '';
  Node   := nil;
  vtFields.BeginUpdate;
  try
    while not dmSysMan.Campo.EOF do
    begin
      if DscDiv <> dmSysMan.Campo.FieldByName('DSC_DIV').AsString then
      begin
        Node := vtFields.AddChild(nil);
        if Node <> nil then
        begin
          Data := vtFields.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := vtFields.GetNodeLevel(Node);
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysMan.Campo, True)
          end;
        end;
      end;
      if Node <> nil then
      begin
        Child := vtFields.AddChild(Node);
        if Child <> nil then
        begin
          Data := vtFields.GetNodeData(Child);
          if (Data <> nil) then
          begin
            Data^.Level   := vtFields.GetNodeLevel(Child);
            Data^.Node    := Child;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysMan.Campo, True)
          end;
        end;
      end;
      dmSysMan.Campo.Next;
      DscDiv := dmSysMan.Campo.FieldByName('DSC_DIV').AsString;
    end;
  finally
    vtFields.EndUpdate;
  end;
end;

procedure TCdLayOut.vtFieldsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := vtFields.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Column >= Data^.DataRow.Count) then
    exit;
  if Column = 0 then
    if Data^.Level = 0 then
      CellText := Data^.DataRow.FieldByName['DSC_DIV'].AsString
    else
      CellText := Data^.DataRow.FieldByName['DSC_CMP'].AsString
  else
    CellText := Data^.DataRow.Fields[Column].AsString;
end;

procedure TCdLayOut.vtFieldsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := vtFields.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  lCmp_Cmp.Caption  := 'Campo: ' + Data^.DataRow.FieldByName['CMP_CMP'].AsString;
  eDsc_Cmp.OnChange := nil;
  eDsc_Cmp.Text     := Data^.DataRow.FieldByName['DSC_CMP'].AsString;
  eDsc_Cmp.OnChange := eDsc_CmpChange;
end;

procedure TCdLayOut.eDsc_CmpChange(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (dsMain.State = dbmBrowse) then
    if vtGrid.RootNodeCount = 0 then
      dsMain.Insert
    else
      dsMain.Edit;
  Node := vtFields.FocusedNode;
  if Node = nil then exit;
  Data := vtFields.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Data^.DataRow.FieldByName['DSC_CMP'].AsString := eDsc_Cmp.Text;
  FPk.FkTipoDocumento := Data^.DataRow.FieldByName['FK_TIPO_DOCUMENTOS'].AsInteger;
  FPk.FkDivisoes      := Data^.DataRow.FieldByName['FK_DIVISOES'].AsInteger;
  FPk.PkCampos        := Data^.DataRow.FieldByName['PK_CAMPOS'].AsInteger;
end;

procedure TCdLayOut.eFk_Tipo_DocumentosChange(Sender: TObject);
var
  i: Integer;
begin
  i := eFk_Tipo_Documentos.ItemIndex;
  if (i >= 0) and (eFk_Tipo_Documentos.Items.Objects[i] <> nil) then
    FPk.FkTipoDocumento := LongInt(eFk_Tipo_Documentos.Items.Objects[i]);
  if (FPk.FkTipoDocumento > 0) and (dsMain.State = dbmFind) then
    LoadGrid;
  ChangeGlobal(Sender);
end;

procedure TCdLayOut.dsMainFindRecords(Sender: TObject;
  var Allowed: Boolean);
begin
  if (dsMain.DataRow.FilterCount = 0) then
  begin
    Allowed := False;
    Application.MessageBox(PAnsiChar(Dados.GetStringMessage(LANGUAGE,
         'sSelectDoc', 'Atenção: Deve selecionar um Tipo de Documento.')),
         PAnsiChar(Application.Name), MB_ICONINFORMATION + MB_OK);
  end;
  inherited;
end;

procedure TCdLayOut.dsMainBeforePost(ASender: TDataManager;
  ADataRow: TDataRow; Mode: TDBMode);
begin
  inherited;
  try
    with dsMain.DefaultRow do
    begin
      FieldByName['FK_TIPO_DOCUMENTOS'].DefaultValue :=
        ADataRow.FieldByName['FK_TIPO_DOCUMENTOS'].Value;
      FieldByName['FK_DIVISOES'].DefaultValue := ADataRow.FieldByName['FK_DIVISOES'].Value;
      FieldByName['PK_CAMPOS'].DefaultValue   := ADataRow.FieldByName['PK_CAMPOS'].Value;
    end;
  except on E:Exception do
    Dados.DisplayMessage(Format(VarModel[Integer(tcDataSetInsError)],
      [dsMain.TableName]) + #13 + E.Message, hiError);
  end;
end;

initialization
   RegisterClass(TCdLayOut);
end.
