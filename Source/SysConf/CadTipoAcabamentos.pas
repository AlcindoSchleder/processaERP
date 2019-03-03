unit CadTipoAcabamentos;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 18/04/2006 - DD/MM/YYYY                                      *}
{* Modified:                                                             *}
{* Version: 2.0.0.0                                                      *}
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMultiModel, ComCtrls, VirtualTrees, ToolWin, ExtCtrls, GridRow,
  ProcType, ProcUtils, ImgList;

type
  TScreenForms = (sfTypeFinish, sfTypeReference);

  TCdTipoAcabamentos = class(TfrmMultiModel)
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure FormCreate(Sender: TObject);
  private
    FPkFinishType: Integer;
    FPkReferenceType: Integer;
    procedure SetPkFinishType(const Value: Integer);
    procedure SetReferenceType(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadList(Sender: TObject);
    procedure LoadPages(Sender: TObject);
    procedure UpdateRecord(Sender: TObject; Row: TDataRow);
    property  PkFinishType   : Integer read FPkFinishType    write SetPkFinishType;
    property  PkReferenceType: Integer read FPkReferenceType write SetReferenceType;
  public
    { Public declarations }
  end;

var
  CdTipoAcabamentos: TCdTipoAcabamentos;

implementation

uses Dado, mSysConf, CadTFinish, CadTypeRef, ConfArqSql, TSysManAux;

{$R *.dfm}

const
  FORMS_CAPTIONS: array [TScreenForms] of string =
    ('Tipos de Acabamentos', 'Tipos de Referências');

procedure TCdTipoAcabamentos.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
  aStr: string;
begin
  aStr := '';
  Data := nil;
  Node := nil;
  with dmSysConf do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGetFinishReference);
    vtList.BeginUpdate;
    Dados.StartTransaction(qrSqlAux);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        if (aStr <> qrSqlAux.FieldByName('DSC_ACABM').AsString) then
          Node := AddDataNode(nil, qrSqlAux, Data);
        if (Node <> nil) then AddDataNode(Node, qrSqlAux, Data);
        aStr := qrSqlAux.FieldByName('DSC_ACABM').AsString;
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
      vtList.EndUpdate;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdTipoAcabamentos.LoadPages(Sender: TObject);
var
  i: TScreenForms;
const
  FORMS_OF_PAGES     : array [TScreenForms] of TPageClass =
    (TCdTypeFinish, TCdTypeReference);
  FORMS_NAMES        : array [TScreenForms] of string     =
    ('tsTypeFinish', 'CdTypeReference');
  FORMS_IMAGES_SEL   : array [TScreenForms] of Integer    =
    (11, 16);
  FORMS_IMAGES_NORMAL: array [TScreenForms] of Integer    =
    (19, 83);
begin
  for i := Low(TScreenForms) to High(TScreenForms) do
  begin
    with Pages.Add do
    begin
      DisplayImage  := FORMS_IMAGES_NORMAL[i];
      FormName      := FORMS_NAMES[i];
      PageCaption   := FORMS_CAPTIONS[i];
      PageControl   := pgMain;
      SelectedImage := FORMS_IMAGES_SEL[i];
      FormClass     := FORMS_OF_PAGES[i];
    end;
  end;
end;

procedure TCdTipoAcabamentos.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['DSC_ACABM'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DSC_REF'].AsString;
  end;
end;

procedure TCdTipoAcabamentos.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    PkFinishType := Data^.DataRow.FieldByName['PK_TIPO_ACABAMENTOS'].AsInteger
  else
    if (Sender.GetNodeLevel(Node) = 1) then
    begin
      FPkFinishType := Data^.DataRow.FieldByName['PK_TIPO_ACABAMENTOS'].AsInteger;
      if (ScrState = dbmInsert) then
        PkReferenceType := 0
      else
        PkReferenceType := Data^.DataRow.FieldByName['PK_TIPO_REFERENCIAS'].AsInteger;
      CdTypeReference.DscAcbm := Data^.DataRow.FieldByName['DSC_ACABM'].AsString;
    end
end;

procedure TCdTipoAcabamentos.UpdateRecord(Sender: TObject; Row: TDataRow);
var
  Data: PGridData;
  Node: PVirtualNode;
  aRow: TDataRow;
  procedure AddDataRow;
  begin
    Node := vtList.AddChild(vtList.FocusedNode);
    if (Node <> nil) then
    begin
      Data := vtList.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level   := vtList.GetNodeLevel(Node);
        Data^.DataRow := TDataRow.CreateAs(nil, aRow);
        Data^.Node    := Node;
      end;
    end;
  end;
begin
  if (vtList.FocusedNode = nil) then exit;
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  vtList.BeginUpdate;
  try
    if (vtList.GetNodeLevel(vtList.FocusedNode) = 0) then
    begin
      Data^.DataRow.FieldByName['PK_TIPO_ACABAMENTOS'].AsInteger := Row.FieldByName['PK_TIPO_ACABAMENTOS'].AsInteger;
      Data^.DataRow.FieldByName['DSC_ACABM'].AsString    := Row.FieldByName['DSC_ACABM'].AsString;
      FPkFinishType := Row.FieldByName['PK_TIPO_ACABAMENTOS'].AsInteger;
      aRow       := Data^.DataRow;
      if (vtList.GetFirstChild(vtList.FocusedNode) = nil) then AddDataRow;
    end;
    if (vtList.GetNodeLevel(vtList.FocusedNode) = 1) then
    begin
      Data^.DataRow.FieldByName['FK_TIPO_ACABAMENTOS'].AsInteger := Row.FieldByName['FK_TIPO_ACABAMENTOS'].AsInteger;
      Data^.DataRow.FieldByName['PK_TIPO_REFERENCIAS'].AsInteger := Row.FieldByName['PK_TIPO_REFERENCIAS'].AsInteger;
      Data^.DataRow.FieldByName['DSC_REF'].AsString := Row.FieldByName['DSC_REF'].AsString;
      Data^.DataRow.FieldByName['DSC_ACABM'].AsString := CdTypeReference.DscAcbm;
      FPkFinishType    := Row.FieldByName['FK_TIPO_ACABAMENTOS'].AsInteger;
      FPkReferenceType := Row.FieldByName['PK_TIPO_REFERENCIAS'].AsInteger;
      aRow        := Data^.DataRow;
    end;
  finally
    vtList.EndUpdate;
  end;
end;

procedure TCdTipoAcabamentos.vtListGetImageIndexEx(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
begin
  inherited;
  if (Node = Sender.FocusedNode) and (ScrState in UPDATE_MODE) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    ImageIndex := 61
  else
    ImageIndex := 26
end;

procedure TCdTipoAcabamentos.SetPkFinishType(const Value: Integer);
begin
  pgMain.ActivePageIndex := 0;
  FPkFinishType := Value;
  CdTypeFinish.Pk := Value;
end;

procedure TCdTipoAcabamentos.SetReferenceType(const Value: Integer);
begin
  pgMain.ActivePageIndex    := 1;
  FPkReferenceType             := Value;
  CdTypeReference.FkTypeFinish := FPkFinishType;
  if (CdTypeReference.Pk        = Value) then
    CdTypeReference.Pk         := 0;
  CdTypeReference.Pk           := Value;
end;

procedure TCdTipoAcabamentos.FormCreate(Sender: TObject);
begin
  OnLoadList  := LoadList;
  OnLoadPages := LoadPages;
  inherited;
end;

initialization
  RegisterClass(TCdTipoAcabamentos);

end.
