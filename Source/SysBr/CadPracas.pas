unit CadPracas;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2006 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/01/2006 - DD/MM/YYYY                                      *}
{* Modified: 03/01/2006 - DD/MM/YYYY                                     *}
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, VirtualTrees, TSysMan,
  GridRow, ProcUtils, SqrForm;

type
  TTypeGrids = (tgSquare, tgTrack, tgCategory, tgOperators, tgOccurrence);

  TfrmSquares = class(TForm)
    pSquare: TPanel;
    spDiv: TSplitter;
    pConfiguration: TPanel;
    cbTools: TCoolBar;
    pgSquare: TPageControl;
    tsSquareList: TTabSheet;
    tsSquareData: TTabSheet;
    pgOperators: TPageControl;
    tsOperList: TTabSheet;
    tsOperData: TTabSheet;
    spCatOper: TSplitter;
    pgCategory: TPageControl;
    tsCategoryList: TTabSheet;
    tsCategoryData: TTabSheet;
    vtSquare: TVirtualStringTree;
    vtCategory: TVirtualStringTree;
    vtOperators: TVirtualStringTree;
    tbOperations: TToolBar;
    tbActiveGrid: TToolBar;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    tbTollSep: TToolButton;
    tbSave: TToolButton;
    cbActiveGrid: TComboBox;
    tbGridSep: TToolButton;
    tbClose: TToolButton;
    sbStatus: TStatusBar;
    tsTrackData: TTabSheet;
    pgOccurrence: TPageControl;
    tsOccursList: TTabSheet;
    tsOccursData: TTabSheet;
    vtOccurrence: TVirtualStringTree;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbCloseClick(Sender: TObject);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure vtSquareGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtSquareFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtSquareDblClick(Sender: TObject);
    procedure vtCategoryGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtCategoryDblClick(Sender: TObject);
    procedure vtOperatorsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtOperatorsDblClick(Sender: TObject);
    procedure vtOccurrenceGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure tbCancelClick(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbActiveGridSelect(Sender: TObject);
    procedure vtOccurrenceChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtOccurrenceInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtOccurrenceDblClick(Sender: TObject);
  private
    FTypeRecords  : array [TTypeGrids] of TDataRow;
    FActiveCompany: TCompany;
    FCompanyClick : Boolean;
    FRect         : TRect;
    FScrMode      : TDBMode;
    function  GetPkSquare: Integer;
    procedure SetPkSquare(const Value: Integer);
    procedure SetScrMode(const Value: TDBMode);
    function  GetActiveGrid: TTypeGrids;
    procedure SetActiveGrid(const Value: TTypeGrids);
    procedure SetCdSquare(AData: TDataRow);
    procedure SetCdTrack(AData: TDataRow);
    procedure SetCdCategory(AData: TDataRow);
    procedure SetCdOperator(AData: TDataRow);
    procedure SetCdOccurrence(AData: TDataRow);
    function GetDscSquare: string;
    function GetActiveForm: TfrmSquareForms;
    procedure SetActiveForm(const Value: TfrmSquareForms);
  private
    { Private declarations }
    function  GetValidGrid: Boolean;
    procedure LoadCategories;
    procedure LoadOccurrences;
    procedure LoadOperators;
    procedure LoadSquares;
    property  PkSquare  : Integer         read GetPkSquare   write SetPkSquare;
    property  DscSquare : string          read GetDscSquare;
    property  ScrMode   : TDBMode         read FScrMode      write SetScrMode;
    property  ActiveGrid: TTypeGrids      read GetActiveGrid write SetActiveGrid;
    property  ActiveForm: TfrmSquareForms read GetActiveForm write SetActiveForm;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses Dado, ProcType, FuncoesDB, mSysBr, ArqSqlBr, SelEmpr, CadSqr,
  CadTrack, CadPrCat, CadPrOpe, CadTOcr;

procedure TfrmSquares.FormCreate(Sender: TObject);
begin
  vtSquare.NodeDataSize      := SizeOf(TGridData);
  vtCategory.NodeDataSize    := SizeOf(TGridData);
  vtOccurrence.NodeDataSize  := SizeOf(TGridData);
  vtOperators.NodeDataSize   := SizeOf(TGridData);
  vtSquare.Images            := Dados.Image16;
  vtSquare.Header.Images     := Dados.Image16;
  vtCategory.Images          := Dados.Image16;
  vtCategory.Header.Images   := Dados.Image16;
  vtOccurrence.Images        := Dados.Image16;
  vtOccurrence.Header.Images := Dados.Image16;
  vtOperators.Images         := Dados.Image16;
  vtOperators.Header.Images  := Dados.Image16;
  tbOperations.Images        := Dados.Image16;
  tbActiveGrid.Images        := Dados.Image16;
  cbTools.Images             := Dados.Image16;
  FActiveCompany             := TCompany.Create;
  FActiveCompany.PkCompany   := Dados.PkCompany;
  FActiveCompany.DscEmp      := Dados.NameCompany;
  ScrMode                    := dbmBrowse;
  Caption                    := Application.Title;
end;

procedure TfrmSquares.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (FScrMode in UPDATE_MODE) and (Dados.DisplayMessage('Há alterações não ' +
      'salvas. Deseja abandonar as alterações?', hiQuestion,
      [mbYes, mbNo]) = mrNo) then
    Action := caNone;
end;

procedure TfrmSquares.FormDestroy(Sender: TObject);
begin
  // Cloase All objects
  ReleaseTreeNodes(vtSquare);
  ReleaseTreeNodes(vtCategory);
  ReleaseTreeNodes(vtOccurrence);
  ReleaseTreeNodes(vtOperators);
  if Assigned(CdSquare)     then CdSquare.Free;
  if Assigned(CdTrack)      then CdTrack.Free;
  if Assigned(CdCategory)   then CdCategory.Free;
  if Assigned(CdOperator)   then CdOperator.Free;
  if Assigned(CdTypeOccurs) then CdTypeOccurs.Free;
  CdSquare     := nil;
  CdTrack      := nil;
  CdCategory   := nil;
  CdOperator   := nil;
  CdTypeOccurs := nil;
end;

procedure TfrmSquares.FormShow(Sender: TObject);
begin
  LoadSquares;
end;

procedure TfrmSquares.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
  end;
end;

function TfrmSquares.GetPkSquare: Integer;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := 0;
  Node   := vtSquare.FocusedNode;
  if (Node = nil) then exit;
  Data := vtSquare.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Data^.DataRow.FindField['PK_PRACAS'] = nil) then
    exit;
  Result := Data^.DataRow.FieldByName['PK_PRACAS'].AsInteger;
end;

function TfrmSquares.GetActiveGrid: TTypeGrids;
begin
  Result := TTypeGrids(cbActiveGrid.ItemIndex);
end;

function  TfrmSquares.GetValidGrid: Boolean;
begin
  Result := False;
  case ActiveGrid of
    tgSquare    : Result := (vtSquare.RootNodeCount     > 0);
    tgTrack     : Result := (vtSquare.RootNodeCount     > 0);
    tgCategory  : Result := (vtCategory.RootNodeCount   > 0);
    tgOperators : Result := (vtOperators.RootNodeCount  > 0);
    tgOccurrence: Result := (vtOccurrence.RootNodeCount > 0);
  end;
end;

procedure TfrmSquares.LoadCategories;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (PkSquare = 0) then  exit;
  ReleaseTreeNodes(vtCategory);
  with dmSysBr do
  begin
    if qrCategory.Active then qrCategory.Close;
    qrCategory.SQL.Clear;
    qrCategory.SQL.Add(SqlCategoryProd);
    Dados.StartTransaction(qrCategory);
    qrCategory.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrCategory.ParamByName('FkPracas').AsInteger   := PkSquare;
    if (not qrCategory.Active) then qrCategory.Open;
    FTypeRecords[tgCategory] := TDataRow.CreateFromDataSet(nil, dmSysBr.qrCategory, False);
    vtCategory.BeginUpdate;
    try
      while (not qrCategory.Eof) do
      begin
        Node := vtCategory.AddChild(nil);
        if (Node <> nil) then
        begin
          Data          := vtCategory.GetNodeData(Node);
          Data^.Level   := vtCategory.GetNodeLevel(Node);
          Data^.Node    := Node;
          Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrCategory, True);
        end;
        qrCategory.Next;
      end;
    finally
      if qrCategory.Active then qrCategory.Close;
      Dados.CommitTransaction(qrCategory);
      vtCategory.EndUpdate;
    end;
  end;
  vtCategory.FocusedNode                      := vtCategory.GetFirst;
  vtCategory.Selected[vtCategory.FocusedNode] := True;
end;

procedure TfrmSquares.LoadOccurrences;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (PkSquare = 0) then  exit;
  ReleaseTreeNodes(vtOccurrence);
  with dmSysBr do
  begin
    if qrTypeOccurs.Active then qrTypeOccurs.Close;
    qrTypeOccurs.SQL.Clear;
    qrTypeOccurs.SQL.Add(SqlTypeOccurs);
    Dados.StartTransaction(qrTypeOccurs);
    qrTypeOccurs.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrTypeOccurs.ParamByName('FkPracas').AsInteger   := PkSquare;
    if (not qrTypeOccurs.Active) then qrTypeOccurs.Open;
    FTypeRecords[tgOccurrence] := TDataRow.CreateFromDataSet(nil, dmSysBr.qrTypeOccurs, False);
    vtOccurrence.BeginUpdate;
    try
      while (not qrTypeOccurs.Eof) do
      begin
        Node := vtOccurrence.AddChild(nil);
        if (Node <> nil) then
        begin
          Data          := vtOccurrence.GetNodeData(Node);
          Data^.Level   := vtOccurrence.GetNodeLevel(Node);
          Data^.Node    := Node;
          Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrTypeOccurs, True);
        end;
        qrTypeOccurs.Next;
      end;
    finally
      if qrTypeOccurs.Active then qrTypeOccurs.Close;
      Dados.CommitTransaction(qrTypeOccurs);
      vtOccurrence.EndUpdate;
    end;
  end;
  vtOccurrence.FocusedNode                        := vtOccurrence.GetFirst;
  vtOccurrence.Selected[vtOccurrence.FocusedNode] := True;
end;

procedure TfrmSquares.LoadOperators;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (PkSquare = 0) then  exit;
  ReleaseTreeNodes(vtOperators);
  with dmSysBr do
  begin
    if qrOperator.Active then qrOperator.Close;
    qrOperator.SQL.Clear;
    qrOperator.SQL.Add(SqlOperators);
    Dados.StartTransaction(qrOperator);
    qrOperator.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrOperator.ParamByName('FkPracas').AsInteger   := PkSquare;
    if (not qrOperator.Active) then qrOperator.Open;
    FTypeRecords[tgOperators] := TDataRow.CreateFromDataSet(nil, qrOperator, False);
    vtOperators.BeginUpdate;
    try
      while (not qrOperator.Eof) do
      begin
        Node := vtOperators.AddChild(nil);
        if (Node <> nil) then
        begin
          Data          := vtOperators.GetNodeData(Node);
          Data^.Level   := vtOperators.GetNodeLevel(Node);
          Data^.Node    := Node;
          Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrOperator, True);
        end;
        qrOperator.Next;
      end;
    finally
      if qrOperator.Active then qrOperator.Close;
      Dados.CommitTransaction(qrOperator);
      vtOperators.EndUpdate;
    end;
  end;
  vtOperators.FocusedNode                        := vtOperators.GetFirst;
  vtOperators.Selected[vtOperators.FocusedNode] := True;
end;

procedure TfrmSquares.LoadSquares;
var
  Node     : PVirtualNode;
  ChildNode: PVirtualNode;
  Data     : PGridData;
  aStrAux  : string;
  procedure AddDataNode(ANode: PVirtualNode);
  begin
    if (ANode <> nil) then
    begin
      Data          := vtSquare.GetNodeData(ANode);
      Data^.Level   := vtSquare.GetNodeLevel(ANode);
      Data^.Node    := ANode;
      Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysBr.qrSquare, True);
    end;
  end;
begin
  Node := nil;
  with dmSysBr do
  begin
    aStrAux := '';
    if qrSquare.Active then qrSquare.Close;
    qrSquare.SQL.Clear;
    qrSquare.SQL.Add(SqlSquaresTracks);
    Dados.StartTransaction(qrSquare);
    qrSquare.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    if (not qrSquare.Active) then qrSquare.Open;
    FTypeRecords[tgSquare] := TDataRow.CreateFromDataSet(nil, qrSquare, False);
    FTypeRecords[tgTrack]  := TDataRow.CreateFromDataSet(nil, qrSquare, False);
    vtSquare.BeginUpdate;
    try
      while (not qrSquare.Eof) do
      begin
        if (aStrAux <> qrSquare.FieldByName('DSC_PRC').AsString) then
        begin
          Node := vtSquare.AddChild(nil);
          AddDataNode(Node);
        end;
        if (qrSquare.FieldByName('DSC_PISTA').AsString <> '') then
        begin
          ChildNode := vtSquare.AddChild(Node);
          AddDataNode(ChildNode);
        end;
        aStrAux := qrSquare.FieldByName('DSC_PRC').AsString;
        qrSquare.Next;
      end;
    finally
      if qrSquare.Active then qrSquare.Close;
      Dados.CommitTransaction(qrSquare);
      vtSquare.EndUpdate;
    end;
  end;
  vtSquare.FocusedNode                    := vtSquare.GetFirst;
  vtSquare.Selected[vtSquare.FocusedNode] := True;
end;

procedure TfrmSquares.SetActiveGrid(const Value: TTypeGrids);
begin
  cbActiveGrid.ItemIndex := Ord(Value);
end;

procedure TfrmSquares.SetPkSquare(const Value: Integer);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (Value = PkSquare) then exit;
  Node := vtSquare.GetFirst;
  while (Node <> nil) do
  begin
    if (vtSquare.GetNodeLevel(Node) = 0) then
    begin
      Data := vtSquare.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (Data^.DataRow.FindField['PK_PRACAS'] <> nil) and
         (Data^.DataRow.FieldByName['PK_PRACAS'].AsInteger = Value) then
      begin
        vtSquare.FocusedNode    := Node;
        vtSquare.Selected[Node] := True;
        break;
      end;
    end;
    Node := vtSquare.GetNext(Node);
  end;
end;

procedure TfrmSquares.SetScrMode(const Value: TDBMode);
begin
  if (FScrMode <> Value) then
  begin
    FScrMode := Value;
    tbInsert.Enabled := (FScrMode in SCROLL_MODE);
    tbDelete.Enabled := ((GetValidGrid) and (FScrMode in SCROLL_MODE));
    tbCancel.Enabled := (FScrMode in UPDATE_MODE);
    tbSave.Enabled   := (FScrMode in UPDATE_MODE);
    sbStatus.Repaint;
  end;
end;

procedure TfrmSquares.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSquares.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  // Change the company...
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    FCompanyClick := False;
    SelEmpresa.Free;
  end;
  if (FActiveCompany <> nil) then
    FActiveCompany          := TCompany.Create;
  if (FActiveCompany.PkCompany = Dados.PkCompany) then exit;
  FActiveCompany.PkCompany := Dados.PkCompany;
  FActiveCompany.DscEmp    := Dados.NameCompany;
  sbStatus.Repaint;
  if Assigned(CdSquare)   then CdSquare.FkCompany   := FActiveCompany;
  if Assigned(CdTrack)    then CdTrack.FkCompany    := FActiveCompany;
  if Assigned(CdCategory) then CdCategory.FkCompany := FActiveCompany;
  if Assigned(CdOperator) then CdOperator.FkCompany := FActiveCompany;
end;

procedure TfrmSquares.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TfrmSquares.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  if (not (Panel.Index in [1, 2])) then exit;
  StatusBar.Canvas.Brush.Color := clBtnFace;
  StatusBar.Canvas.Font.Style  := [fsBold];
  StatusBar.Canvas.Font.Name := 'Arial';
  StatusBar.Canvas.FillRect(Rect);
  if (Panel.Index = 1) then
  begin
    FRect := Rect;
    StatusBar.Canvas.Font.Color := ClNavy;
    Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
    StatusBar.Canvas.TextOut(Rect.Left + 22, Rect.Top + 1,'Empresa: ' +
      IntToStr(FActiveCompany.PkCompany) + ' / ' + FActiveCompany.DscEmp);
  end;
  if Panel.Index = 2 then
  begin
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrMode];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrMode];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrMode]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrMode]);
  end;
end;

procedure TfrmSquares.vtSquareGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['DSC_PRC'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DSC_PISTA'].AsString;
  end;
end;

procedure TfrmSquares.vtSquareFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  if (Node = nil) then exit;
  LoadCategories;
  LoadOccurrences;
  LoadOperators;
end;

procedure TfrmSquares.vtSquareDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtSquare.FocusedNode;
  // Edit Focused Record. Obs: Level One = Square; Level Two = Track
  if (ScrMode = dbmInsert) then
  begin
    if (FTypeRecords[ActiveGrid] = nil) then
      raise Exception.Create('Registro da grade não inicializado');
    if (ActiveGrid = tgSquare) then
      Node := vtSquare.AddChild(nil);
    if (ActiveGrid = tgTrack) then
    begin
      if (vtSquare.GetNodeLevel(Node) > 0) then
      begin
        Node := vtSquare.GetVisibleParent(Node);
        vtSquare.FocusedNode := Node;
        vtSquare.Selected[Node] := True;
      end;
      Node := vtSquare.AddChild(Node);
    end;
    Data          := vtSquare.GetNodeData(Node);
    Data^.Level   := vtSquare.GetNodeLevel(Node);
    Data^.DataRow := TDataRow.CreateAs(nil, FTypeRecords[ActiveGrid]);
    Data^.Node    := Node;
  end
  else
  begin
    if (Node = nil) then exit;
    Data := vtSquare.GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    ScrMode := dbmEdit;
  end;
  if (Data^.Level = 0) then
    SetCdSquare(Data^.DataRow);
  if (Data^.Level = 1) then
    SetCdTrack(Data^.DataRow);
  vtSquare.FocusedNode    := Node;
  vtSquare.Selected[Node] := True;
end;

procedure TfrmSquares.SetCdSquare(AData: TDataRow);
begin
  if (not Assigned(CdSquare)) then
  begin
    ActiveGrid             := tgSquare;
    CdSquare               := TCdSquare.Create(Application);
    CdSquare.Parent        := tsSquareData;
    CdSquare.Align         := alClient;
    CdSquare.BorderStyle   := bsNone;
    CdSquare.FkCompany     := FActiveCompany;
  end;
  CdSquare.DataRecord      := AData;
  CdSquare.PkSquare        := PkSquare;
  pgSquare.ActivePageIndex := 1;
  CdSquare.Show;
  CdSquare.ScrMode         := ScrMode;
end;

procedure TfrmSquares.SetCdTrack(AData: TDataRow);
begin
  if (not Assigned(CdTrack)) then
  begin
    ActiveGrid             := tgTrack;
    CdTrack                := TCdTrack.Create(Application);
    CdTrack.Parent         := tsTrackData;
    CdTrack.Align          := alClient;
    CdTrack.BorderStyle    := bsNone;
    CdTrack.FkCompany      := FActiveCompany;
  end;
  CdTrack.DataRecord       := AData;
  CdTrack.PkSquare         := PkSquare;
  CdTrack.Title            := DscSquare;
  pgSquare.ActivePageIndex := 2;
  CdTrack.Show;
  ShowMessage(AData.FieldByName['DSC_PISTA'].AsString);
  CdTrack.ScrMode          := ScrMode;
end;

procedure TfrmSquares.SetCdCategory(AData: TDataRow);
begin
  if (not Assigned(CdCategory)) then
  begin
    ActiveGrid               := tgCategory;
    CdCategory               := TCdCategory.Create(Application);
    CdCategory.Parent        := tsCategoryData;
    CdCategory.Align         := alClient;
    CdCategory.BorderStyle   := bsNone;
    CdCategory.FkCompany     := FActiveCompany;
  end;
  CdCategory.DataRecord      := AData;
  CdCategory.PkSquare        := PkSquare;
  CdCategory.Title           := DscSquare;
  pgCategory.ActivePageIndex := 1;
  CdCategory.Show;
  CdCategory.ScrMode         := ScrMode;
end;

procedure TfrmSquares.SetCdOperator(AData: TDataRow);
begin
  if (not Assigned(CdOperator)) then
  begin
    ActiveGrid                := tgOperators;
    CdOperator                := TCdOperator.Create(Application);
    CdOperator.Parent         := tsOperData;
    CdOperator.Align          := alClient;
    CdOperator.BorderStyle    := bsNone;
    CdOperator.FkCompany      := FActiveCompany;
  end;
  CdOperator.DataRecord       := AData;
  CdOperator.PkSquare         := PkSquare;
  CdOperator.Title            := DscSquare;
  pgOperators.ActivePageIndex := 1;
  CdOperator.Show;
  CdOperator.ScrMode          := ScrMode;
end;

procedure TfrmSquares.SetCdOccurrence(AData: TDataRow);
begin
  if (not Assigned(CdTypeOccurs)) then
  begin
    ActiveGrid                  := tgOccurrence;
    CdTypeOccurs                := TCdTypeOccurs.Create(Application);
    CdTypeOccurs.Parent         := tsOccursData;
    CdTypeOccurs.Align          := alClient;
    CdTypeOccurs.BorderStyle    := bsNone;
    CdTypeOccurs.FkCompany      := FActiveCompany;
  end;
  CdTypeOccurs.DataRecord       := AData;
  CdTypeOccurs.PkSquare         := PkSquare;
  CdTypeOccurs.Title            := DscSquare;
  CdTypeOccurs.PkTypeOccurs     := vtOccurrence.RootNodeCount;
  pgOccurrence.ActivePageIndex  := 1;
  CdTypeOccurs.Show;
  CdTypeOccurs.ScrMode          := ScrMode;
end;

procedure TfrmSquares.vtCategoryGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['PK_CATEGORIAS_PRODUTOS'].AsString +
                     ' / ' + Data^.DataRow.FieldByName['DSC_PROD'].AsString;
    1: CellText := FloatToStrF(Data^.DataRow.FieldByName['PRE_VDA'].AsFloat,
                     ffCurrency, 7, Dados.DecimalPlaces);
  end;
end;

procedure TfrmSquares.vtCategoryDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  // Edit Focused Record
  if (ScrMode = dbmInsert) then
  begin
    if (FTypeRecords[ActiveGrid] = nil) then
      raise Exception.Create('Registro da grade não inicializado');
    Node          := vtCategory.AddChild(nil);
    Data          := vtCategory.GetNodeData(Node);
    Data^.Level   := vtCategory.GetNodeLevel(Node);
    Data^.DataRow := TDataRow.CreateAs(nil, FTypeRecords[ActiveGrid]);
    Data^.Node    := Node;
  end
  else
  begin
    Node := vtCategory.FocusedNode;
    if (Node = nil) then exit;
    Data := vtCategory.GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    ScrMode := dbmEdit;
  end;
  vtCategory.FocusedNode    := Node;
  vtCategory.Selected[Node] := True;
  SetCdCategory(Data^.DataRow);
end;

procedure TfrmSquares.vtOperatorsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column = 0) then
    CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
end;

procedure TfrmSquares.vtOperatorsDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  // Edit Focused Record
  if (ScrMode = dbmInsert) then
  begin
    if (FTypeRecords[ActiveGrid] = nil) then
      raise Exception.Create('Registro da grade não inicializado');
    Node          := vtOperators.AddChild(nil);
    Data          := vtOperators.GetNodeData(Node);
    Data^.Level   := vtOperators.GetNodeLevel(Node);
    Data^.DataRow := TDataRow.CreateAs(nil, FTypeRecords[ActiveGrid]);
    Data^.Node    := Node;
  end
  else
  begin
    Node := vtOperators.FocusedNode;
    if (Node = nil) then exit;
    Data := vtOperators.GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    ScrMode := dbmEdit;
  end;
  vtOperators.FocusedNode    := Node;
  vtOperators.Selected[Node] := True;
  SetCdOperator(Data^.DataRow);
end;

procedure TfrmSquares.vtOccurrenceGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column = 0) then
    CellText := Data^.DataRow.FieldByName['DSC_TOCR'].AsString;
end;

procedure TfrmSquares.tbCancelClick(Sender: TObject);
var
  aForm: TfrmSquareForms;
begin
  if (ScrMode = dbmInsert) then
  begin
    case ActiveGrid of
      tgSquare    : if (vtSquare.FocusedNode   <> nil) then
                      vtSquare.DeleteNode(vtSquare.FocusedNode);
      tgTrack     : if (vtSquare.FocusedNode   <> nil) then
                      vtSquare.DeleteNode(vtSquare.FocusedNode);
      tgCategory  : if (vtCategory.FocusedNode <> nil) then
                      vtCategory.DeleteNode(vtCategory.FocusedNode);
      tgOperators : if (vtOperators.FocusedNode <> nil) then
                      vtOperators.DeleteNode(vtOperators.FocusedNode);
      tgOccurrence: if (vtOccurrence.FocusedNode <> nil) then
                     vtOccurrence.DeleteNode(vtOccurrence.FocusedNode);
    end;
  end;
  ScrMode := dbmBrowse;
  aForm := ActiveForm;
  if Assigned(aForm) then
    aForm.ScrMode := FScrMode;
  case ActiveGrid of
    tgSquare    : pgSquare.ActivePageIndex     := 0;
    tgTrack     : pgSquare.ActivePageIndex     := 0;
    tgCategory  : pgCategory.ActivePageIndex   := 0;
    tgOperators : pgOperators.ActivePageIndex  := 0;
    tgOccurrence: pgOccurrence.ActivePageIndex := 0;
  end;
end;

procedure TfrmSquares.tbInsertClick(Sender: TObject);
begin
  ScrMode := dbmInsert;
  case ActiveGrid of
    tgSquare    : vtSquareDblClick(Sender);
    tgTrack     : vtSquareDblClick(Sender);
    tgCategory  : vtCategoryDblClick(Sender);
    tgOperators : vtOperatorsDblClick(Sender);
    tgOccurrence: vtOccurrenceDblClick(Sender);
  end;
end;

procedure TfrmSquares.tbSaveClick(Sender: TObject);
var
  aForm: TfrmSquareForms;
begin
  ScrMode := dbmBrowse;
  aForm := ActiveForm;
  if Assigned(aForm) then
  begin
    aForm.SaveIntoDB;
    aForm.ScrMode := FScrMode;
  end;
  case ActiveGrid of
    tgSquare    : pgSquare.ActivePageIndex     := 0;
    tgTrack     : pgSquare.ActivePageIndex     := 0;
    tgCategory  : pgCategory.ActivePageIndex   := 0;
    tgOperators : pgOperators.ActivePageIndex  := 0;
    tgOccurrence: pgOccurrence.ActivePageIndex := 0;
  end;
end;

procedure TfrmSquares.cbActiveGridSelect(Sender: TObject);
begin
  case ActiveGrid of
    tgSquare    : vtSquare.SetFocus;
    tgTrack     : vtSquare.SetFocus;
    tgCategory  : vtCategory.SetFocus;
    tgOperators : vtOperators.SetFocus;
    tgOccurrence: vtOccurrence.SetFocus;
  end;
end;

procedure TfrmSquares.vtOccurrenceChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
// Save Data to DB
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Node.CheckState = csCheckedNormal) then
  begin
    Data^.DataRow.FieldByName['FK_PRACAS'].AsInteger   := PkSquare;
    Data^.DataRow.FieldByName['FK_EMPRESAS'].AsInteger := FActiveCompany.PkCompany;
    Data^.DataRow.FieldByName['FK_TIPO_OCORRENCIA'].AsInteger :=
      Data^.DataRow.FieldByName['PK_TIPO_OCORRENCIAS'].AsInteger;
    dmSysBr.InsertTOcrLink(Data^.DataRow);
  end
  else
    dmSysBr.DeleteTOcrLink(Data^.DataRow);
end;

procedure TfrmSquares.vtOccurrenceInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Node.CheckType := ctCheckBox;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FK_PRACAS'].AsInteger > 0) then
    Node.CheckState := csCheckedNormal
  else
    Node.CheckState := csUncheckedNormal;
end;

function TfrmSquares.GetDscSquare: string;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := '';
  Node   := vtSquare.FocusedNode;
  if (Node = nil) then exit;
  Data := vtSquare.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Data^.DataRow.FindField['DSC_PRC'] = nil) then
    exit;
  Result := Data^.DataRow.FieldByName['DSC_PRC'].AsString;
end;

procedure TfrmSquares.vtOccurrenceDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  // Edit Focused Record
  if (ScrMode = dbmInsert) then
  begin
    if (FTypeRecords[ActiveGrid] = nil) then
      raise Exception.Create('Registro da grade não inicializado');
    Node          := vtOccurrence.AddChild(nil);
    Data          := vtOccurrence.GetNodeData(Node);
    Data^.Level   := vtOccurrence.GetNodeLevel(Node);
    Data^.DataRow := TDataRow.CreateAs(nil, FTypeRecords[ActiveGrid]);
    Data^.Node    := Node;
  end
  else
  begin
    Node := vtOccurrence.FocusedNode;
    if (Node = nil) then exit;
    Data := vtOccurrence.GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    ScrMode := dbmEdit;
  end;
  vtOccurrence.FocusedNode    := Node;
  vtOccurrence.Selected[Node] := True;
  SetCdOccurrence(Data^.DataRow);
end;

function TfrmSquares.GetActiveForm: TfrmSquareForms;
begin
  Result := nil;
  case ActiveGrid of
    tgSquare    : if Assigned(CdSquare)     then Result := CdSquare;
    tgTrack     : if Assigned(CdTrack)      then Result := CdTrack;
    tgCategory  : if Assigned(CdCategory)   then Result := CdCategory;
    tgOperators : if Assigned(CdOperator)   then Result := CdOperator;
    tgOccurrence: if Assigned(CdTypeOccurs) then Result := CdTypeOccurs;
  end;
end;

procedure TfrmSquares.SetActiveForm(const Value: TfrmSquareForms);
begin

end;

initialization
  RegisterClass(TfrmSquares);

end.

