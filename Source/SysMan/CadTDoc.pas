unit CadTDoc;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ExtCtrls,
  Mask, ToolEdit, CurrEdit, ProcUtils, TSysMan;

type
  TCdTypeDocs = class(TfrmModelList)
    lPk_Tipo_Documentos: TStaticText;
    ePk_Tipo_Documentos: TEdit;
    lQtd_Itm: TStaticText;
    eDsc_TDoc: TEdit;
    lDsc_TDoc: TStaticText;
    lFlag_TDoc: TRadioGroup;
    lObs_TDoc: TStaticText;
    eObs_TDoc: TMemo;
    eQtd_Itm: TCurrencyEdit;
    vtDocNumber: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtDocNumberGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure lFlag_TDocClick(Sender: TObject);
    procedure vtDocNumberPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
  private
    { Private declarations }
    function  GetDscTDoc: string;
    function  GetFlagTDoc: TDocumentType;
    function  GetObsTDoc: TStrings;
    function  GetPkTypeDocument: Integer;
    function  GetQtdItm: Integer;
    function  GetTypeDocument: TTypeDocument;
    procedure SetDscTDoc(const Value: string);
    procedure SetFlagTDoc(const Value: TDocumentType);
    procedure SetObsTDoc(const Value: TStrings);
    procedure SetPkTypeDocument(const Value: Integer);
    procedure SetQtdItm(const Value: Integer);
    procedure SetTypeDocument(const Value: TTypeDocument);
    procedure ConfigDataScreen;
    procedure GetListNumbers;
    property  DscTDoc       : string        read GetDscTDoc        write SetDscTDoc;
    property  FlagTDoc      : TDocumentType read GetFlagTDoc       write SetFlagTDoc;
    property  ObsTDoc       : TStrings      read GetObsTDoc        write SetObsTDoc;
    property  PkTypeDocument: Integer       read GetPkTypeDocument write SetPkTypeDocument;
    property  QtdItm        : Integer       read GetQtdItm         write SetQtdItm;
    property  TypeDocument  : TTypeDocument read GetTypeDocument   write SetTypeDocument;
  protected
    { Protected declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property OnListLoad;
  end;

var
  CdTypeDocs: TCdTypeDocs;

implementation

uses Dado, mSysMan, ProcType, FuncoesDB, GridRow, ManArqSql;

{$R *.dfm}

{ TCdTypeDocs }

function TCdTypeDocs.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  C      := Self;
  if (DscTDoc = '') then
  begin
    S := 'Campo Descrição deve ter um valor';
    C := eDsc_TDoc;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTypeDocs.ClearControls;
begin
  Loading        := True;
  try
    DscTDoc        := '';
    FlagTDoc       := dtNF;
    ObsTDoc        := nil;
    PkTypeDocument := 0;
    QtdItm         := 0;
    ConfigDataScreen;
  finally
    Loading        := False;
  end;
end;

function TCdTypeDocs.GetDscTDoc: string;
begin
  Result := eDsc_TDoc.Text;
end;

function TCdTypeDocs.GetFlagTDoc: TDocumentType;
begin
  Result := TDocumentType(lFlag_TDoc.ItemIndex);
end;

procedure TCdTypeDocs.GetListNumbers;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtDocNumber);
  with dmSysMan do
  begin
    if qrTypeDoc.Active then qrTypeDoc.Close;
    qrTypeDoc.SQL.Clear;
    qrTypeDoc.SQL.Add(SqlTDocNumbers);
    Dados.StartTransaction(qrTypeDoc);
    try
      qrTypeDoc.ParamByName('FkTipoDocumentos').AsInteger := Pk;
      if (not qrTypeDoc.Active) then qrTypeDoc.Open;
      while (not qrTypeDoc.Eof) do
      begin
        Node := vtDocNumber.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtDocNumber.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Node    := Node;
            Data^.Level   := 0;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrTypeDoc, True);
          end;
          qrTypeDoc.Next;
        end;
      end;
    finally
      if qrTypeDoc.Active then qrTypeDoc.Close;
      Dados.CommitTransaction(qrTypeDoc);
    end;
  end;
  if (vtDocNumber.RootNodeCount > 0) then
  begin
    vtDocNumber.FocusedNode                    := vtDocNumber.GetFirst;
    vtDocNumber.Selected[vtDocNumber.GetFirst] := True;
  end;
end;

function TCdTypeDocs.GetObsTDoc: TStrings;
begin
  Result := eObs_TDoc.Lines;
end;

function TCdTypeDocs.GetPkTypeDocument: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Documentos.Text, 0);
end;

function TCdTypeDocs.GetQtdItm: Integer;
begin
  Result := eQtd_Itm.AsInteger;
end;

function TCdTypeDocs.GetTypeDocument: TTypeDocument;
begin
  Result                := TTypeDocument.Create;
  Result.DscTDoc        := DscTDoc;
  Result.FlagTDoc       := FlagTDoc;
  Result.ObsDoc         := ObsTDoc;
  Result.PkTypeDocument := PkTypeDocument;
  Result.QtdItem        := QtdItm;
end;

procedure TCdTypeDocs.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdTypeDocs.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  inherited;
  with dmSysMan do
  begin
    if qrTypeDoc.Active then qrTypeDoc.Close;
    qrTypeDoc.SQL.Clear;
    qrTypeDoc.SQL.Add(SqlAllTypeDocs);
    Dados.StartTransaction(qrTypeDoc);
    try
      if (not qrTypeDoc.Active) then qrTypeDoc.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(nil, qrTypeDoc, False);
      while (not qrTypeDoc.Eof) do
      begin
        Node := vtList.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtList.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Node    := Node;
            Data^.Level   := 0;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrTypeDoc, True);
          end;
        end;
        qrTypeDoc.Next;
      end;
    finally
      if qrTypeDoc.Active then qrTypeDoc.Close;
      Dados.CommitTransaction(qrTypeDoc);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode               := vtList.GetFirst;
    vtList.Selected[vtList.GetFirst] := True;
  end;
end;

procedure TCdTypeDocs.MoveDataToControls;
begin
  Loading := True;
  try
    TypeDocument := dmSysMan.GetTypeDocument(Pk);
    GetListNumbers;
    ConfigDataScreen;
  finally
    Loading := False;
  end;
end;

procedure TCdTypeDocs.SaveIntoDB;
var
  APk: Integer;
begin
  APk := dmSysMan.SaveTypeDocument(TypeDocument, ScrState);
  if (FocusedRow <> nil) then
  begin
    FocusedRow.FieldByName['PK_TIPO_DOCUMENTOS'].AsInteger := APk;
    FocusedRow.FieldByName['DSC_TDOC'].AsString            := DscTDoc;
  end;
  Pk := APk;
end;

procedure TCdTypeDocs.SetDscTDoc(const Value: string);
begin
  eDsc_TDoc.Text := Value;
end;

procedure TCdTypeDocs.SetFlagTDoc(const Value: TDocumentType);
begin
  lFlag_TDoc.ItemIndex := Ord(Value);
end;

procedure TCdTypeDocs.SetObsTDoc(const Value: TStrings);
begin
  eObs_TDoc.Lines.Clear;
  if (Value <> nil) then
    eObs_TDoc.Lines.Assign(Value);
end;

procedure TCdTypeDocs.SetPkTypeDocument(const Value: Integer);
begin
  ePk_Tipo_Documentos.Text := IntToStr(Value);
end;

procedure TCdTypeDocs.SetQtdItm(const Value: Integer);
begin
  eQtd_Itm.AsInteger := Value;
end;

procedure TCdTypeDocs.SetTypeDocument(const Value: TTypeDocument);
begin
  if (Value = nil) then exit;
  DscTDoc        := Value.DscTDoc;
  FlagTDoc       := Value.FlagTDoc;
  ObsTDoc        := Value.ObsDoc;
  PkTypeDocument := Value.PkTypeDocument;
  QtdItm         := Value.QtdItem;
end;

procedure TCdTypeDocs.FormCreate(Sender: TObject);
begin
  vtDocNumber.NodeDataSize  := SizeOf(TGridData);
  vtDocNumber.Images        := Dados.Image16;
  vtDocNumber.Header.Images := Dados.Image16;
  OnCheckRecord             := CheckRecord;
  OnListLoad                := LoadList;
  inherited;
end;

procedure TCdTypeDocs.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtDocNumber);
  inherited;
end;

procedure TCdTypeDocs.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_DOCUMENTOS'].AsInteger;
end;

procedure TCdTypeDocs.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Column = 0) then
    CellText := Data^.DataRow.FieldByName['DSC_TDOC'].AsString;
end;

procedure TCdTypeDocs.vtDocNumberGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
    1: CellText := Data^.DataRow.FieldByName['NUM_DOC'].AsString;
  end;
end;

procedure TCdTypeDocs.lFlag_TDocClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  ConfigDataScreen;
end;

procedure TCdTypeDocs.ConfigDataScreen;
begin
  if (FlagTDoc in [dtNF, dtOS, dtRequisicao, dtPedido, dtOP, dtCI]) then
  begin
    lQtd_Itm.Enabled := True;
    eQtd_Itm.Enabled := True;
  end
  else
  begin
    lQtd_Itm.Enabled := False;
    eQtd_Itm.Enabled := False;
    QtdItm           := 0;
  end;
end;

procedure TCdTypeDocs.vtDocNumberPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['NUM_DOC'].AsInteger > 0) then
    TargetCanvas.Font.Color := clBlue
  else
    TargetCanvas.Font.Color := clWindowText;
end;

initialization
  RegisterClass(TCdTypeDocs);

end.
