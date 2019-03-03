unit CadModelMulti;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2007 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 07/07/2008 - DD/MM/YYYY                                    *}
{* Modified :            - DD/MM/YYYY                                    *}
{* Version  : 0.0.0.1                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@processa.org                                       *}
{*            http://www.processa.org                                    *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcUtils, VirtualTrees, ComCtrls, ToolWin, ImgList, GridRow, DB,
  ExtCtrls, CadModel, PrcSysTypes, ProcType;

type
  TPagesClass = class of TfrmModel;

  TfrmModelMulti = class(TForm)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    sbStatus: TStatusBar;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    tbSave: TToolButton;
    tbSepSave: TToolButton;
    vtList: TVirtualStringTree;
    tbSelClose: TToolButton;
    tbClose: TToolButton;
    pgControl: TPageControl;
    spSplitter: TSplitter;
    tsRoot: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbInsertClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbCloseClick(Sender: TObject);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure vtListFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtListIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure vtListStateChange(Sender: TBaseVirtualTree; Enter,
      Leave: TVirtualTreeStates);
  private
    { Private declarations }
    FCompanyClick : Boolean;
    FRect         : TRect;
    FScrState     : TDBMode;
    FOnInsert     : TOnUpdateRow;
    FCheckRecord  : Boolean;
    FDataRow      : TDataRow;
    FDebug        : Boolean;
    FPageIndex    : Integer;
    FCanInsertNode: Boolean;
    FLastNode     : PVirtualNode;
    FItemImgSelIdx: Integer;
    FItemImgNrmIdx: Integer;
    FHasFolders   : Boolean;
    FSearchCol    : shortint;
    FSearchField  : string;
    FSearchText   : string;
    procedure InsertRecord;
    procedure CancelRecord;
    procedure SetScrState(const Value: TDBMode);
    procedure UpdateScreen;
    function  GetActiveRow(Index: Integer): TDataRow;
    function  GetFocusedLevel: Integer;
    function  GetFocusedRow: TDataRow;
    procedure SetDataRow(const Value: TDataRow);
    procedure SetPageIndex(const Value: Integer);
  protected
    { Protected declarations }
    FFormsArray: array of TfrmModel;
    function  AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet;
                var AData: PGridData): PVirtualNode; virtual;
    procedure LoadList; virtual;
    procedure LoadPages; virtual; abstract;
    procedure ChangeState(Sender: TObject; AState: TDBMode);
    procedure SetActiveRow(Index: Integer; const Value: TDataRow); virtual;
  public
    { Public declarations }
    property  CheckRecord    : Boolean      read FCheckRecord;
    property  CanInsertNode  : Boolean      read FCanInsertNode write FCanInsertNode;
    property  HasFolders     : Boolean      read FHasFolders    write FHasFolders;
    property  LastNode       : PVirtualNode read FLastNode;
    property  Debug          : Boolean      read FDebug         write FDebug;
    property  FocusedRow     : TDataRow     read GetFocusedRow;
    property  FocusedLevel   : Integer      read GetFocusedLevel;
    property  ItemImgNrmIdx  : Integer      read FItemImgNrmIdx write FItemImgNrmIdx;
    property  ItemImgSelIdx  : Integer      read FItemImgSelIdx write FItemImgSelIdx;
    property  PageIndex      : Integer      read FPageIndex     write SetPageIndex;
    property  RowModel       : TDataRow     read FDataRow       write SetDataRow;
    property  ScrState       : TDBMode      read FScrState      write SetScrState;
    property  SearchField    : string       read FSearchField   write FSearchField;
    property  SearchCol      : shortint     read FSearchCol     write FSearchCol default 0;
    property  OnInsert       : TOnUpdateRow read FOnInsert      write FOnInsert;
    property  ActiveRow[Index: Integer]: TDataRow read GetActiveRow write SetActiveRow;
  end;

var
  frmModelMulti: TfrmModelMulti;

implementation

uses MainData, FuncoesDB, Funcoes, Math;

{$R *.dfm}

{ TfrmModel }

procedure TfrmModelMulti.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    cbTools.Images            := dmMain.Image16;
    tbTools.Images            := dmMain.Image16;
    vtList.Images             := dmMain.Image16;
    vtList.Header.Images      := dmMain.Image16;
    vtList.NodeDataSize       := SizeOf(TGridData);
    HasFolders                := False;
    FSearchCol                := 0;
    FSearchField              := '';
    LoadPages;
    pgControl.ActivePageIndex := 0;
    FScrState                 := dbmBrowse;
    FDataRow                  := nil;
    FDebug                    := False;
    FLastNode                 := nil;
    FCanInsertNode            := True;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmModelMulti.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  Screen.Cursor := crHourGlass;
  try
    if Assigned(FFormsArray) then
      for i := High(FFormsArray) downto 0 do
      begin
        if FDebug then
          ShowMessage(Format('Excluindo Form %d(%s)', [i, FFormsArray[i].Name]));
        if Assigned(FFormsArray[i]) then
          FFormsArray[i].Free;
        FFormsArray[i] := nil;
      end;
    SetLength(FFormsArray, 0);
    ReleaseTreeNodes(vtList);
    if Assigned(FDataRow) then FDataRow.Free;
    FDataRow := nil;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmModelMulti.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (FScrState in UPDATE_MODE) then
    if (dmMain.DisplayMessage('Há alterações na tela. Deseja sair e abandonar ' +
          'as alterações?', hiQuestion, [mbYes, mbNo]) = mrNo) then
      Action := caNone
    else
      Action := caFree
  else
    Action := caFree;
end;

procedure TfrmModelMulti.FormShow(Sender: TObject);
var
  i: Integer;
begin
  Caption := Application.Title;
  LoadList;
  if Assigned(FFormsArray) and (High(FFormsArray) > 0) then
    for i := 0 to High(FFormsArray) do
      FFormsArray[i].Show;
  ScrState := dbmBrowse;
end;

procedure TfrmModelMulti.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Shift = []) and (Key = VK_ESCAPE)) then
    if (ScrState in UPDATE_MODE) then
      tbCancel.Click
    else
      Close;
  if ((Shift = []) and (Key = VK_F5)) and (ScrState in SCROLL_MODE) then
    LoadList;
  if ((Shift = []) and (Key = VK_INSERT)) and (ScrState in SCROLL_MODE) then
    tbInsert.Click;
  if ((ssCtrl in Shift) and (Key = VK_DELETE)) and (ScrState in SCROLL_MODE) then
    tbDelete.Click;
  if ((Shift = []) and (Key = VK_F10))  and (ScrState in UPDATE_MODE) then
    tbSave.Click;
  if ((Shift = []) and (Key = VK_ESCAPE)) or
     ((Shift = []) and (Key = VK_F5)) or
     ((Shift = []) and (Key = VK_INSERT)) or
     ((ssCtrl in Shift) and (Key = VK_DELETE)) or
     ((Shift = []) and (Key = VK_F10)) then
    Key := 0;
end;

procedure TfrmModelMulti.SetScrState(const Value: TDBMode);
begin
  if (FScrState <> Value) then
  begin
    if (FPageIndex < Low(FFormsArray)) or
       (FPageIndex > High(FFormsArray)) then
    begin
      dmMain.DisplayMessage(Format('Erro: Número da Página inválido %d. ' +
        'Valor deve ser entre 0 e %d', [FPageIndex, High(FFormsArray)]), hiError);
      exit;
    end;
    if (Value = dbmCancel) then
      CancelRecord;
    if (Value <> dbmPost) then
    begin
      FScrState := Value;
      FFormsArray[FPageIndex].ScrState := Value;
    end;
    case Value of
      dbmCancel: CancelRecord;
      dbmInsert: InsertRecord;
    end;
    FFormsArray[FPageIndex].ScrState := Value;
    if (FScrState <> FFormsArray[FPageIndex].ScrState) then
      FScrState := Value;
  end;
  UpdateScreen;
end;

function TfrmModelMulti.AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet;
  var AData: PGridData): PVirtualNode;
begin
  Result := vtList.AddChild(ANode);
  if (Result <> nil) then
  begin
    AData := vtList.GetNodeData(Result);
    if (AData <> nil) then
    begin
      AData^.Level    := vtList.GetNodeLevel(Result);
      AData^.Node     := Result;
      AData^.NodeType := tnData;
      AData^.DataRow  := TDataRow.CreateFromDataSet(nil, ADataSet, True);
    end;
  end;
end;

procedure TfrmModelMulti.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  if (Panel.Index <  2) then exit;
  StatusBar.Canvas.Brush.Color := clBtnFace;
  StatusBar.Canvas.Font.Style  := [fsBold];
  StatusBar.Canvas.Font.Name := 'Arial';
  StatusBar.Canvas.FillRect(Rect);
  StatusBar.Canvas.Font.Color  := FontColorMode[FScrState];
  StatusBar.Canvas.Brush.Color :=     ColorMode[FScrState];
  X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
       (Canvas.TextWidth(ModeTypes[FScrState]) div 2);
  StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
end;

procedure TfrmModelMulti.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TfrmModelMulti.tbInsertClick(Sender: TObject);
begin
  ScrState := dbmInsert;
end;

procedure TfrmModelMulti.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmCancel;
  ScrState := dbmBrowse;
end;

procedure TfrmModelMulti.tbDeleteClick(Sender: TObject);
var
  Data: PGridData;
begin
  if (vtList.FocusedNode <> nil) then
  begin
    if (dmMain.DisplayMessage('Deseja realmente excluir este registro?', hiQuestion,
        [mbYes, mbNo]) = mrNo) then
      exit;
    vtList.BeginUpdate;
    try
      ScrState := dbmDelete;
      Data     := vtList.GetNodeData(vtList.FocusedNode);
      if (Data <> nil) then
      begin
        Data^.Node  := nil;
        Data^.Level := 0;
        if (Data^.DataRow <> nil) then Data^.DataRow.Free;
        Data^.DataRow := nil;
      end;
      vtList.DeleteNode(vtList.FocusedNode);
    finally
      vtList.EndUpdate;
      ScrState := dbmBrowse;
    end;
  end;
end;

procedure TfrmModelMulti.tbSaveClick(Sender: TObject);
begin
  ScrState := dbmPost;
  if (ScrState = dbmPost) then
    ScrState := dbmBrowse;
end;

procedure TfrmModelMulti.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmModelMulti.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
begin
  if (Node = nil) or (Kind in [ikState, ikOverlay]) then exit;
  if (FItemImgNrmIdx = 0) then FItemImgNrmIdx := 4;
  if (FItemImgSelIdx = 0) then FItemImgSelIdx := 2;
  if (Kind = ikSelected) then
    if (ScrState in UPDATE_MODE) then
      ImageIndex := 0
    else
      ImageIndex := FItemImgSelIdx
  else
    if (Kind = ikNormal) then
      ImageIndex := FItemImgNrmIdx;
end;

procedure TfrmModelMulti.vtListFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  Allowed := (ScrState in SCROLL_MODE);
end;

procedure TfrmModelMulti.InsertRecord;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (FPageIndex < Low(FFormsArray)) or
     (FPageIndex > High(FFormsArray)) then
  begin
    dmMain.DisplayMessage(Format('Erro: Número da Página inválido %d. ' +
      'Valor deve ser entre 0 e %d', [FPageIndex, High(FFormsArray)]), hiError);
    exit;
  end;
  FLastNode := nil;
  Node      := nil;
  if (not FCanInsertNode) then exit;
  if (FDataRow <> nil) then
  begin
    vtList.OnFocusChanging := nil;
    vtList.BeginUpdate;
    try
      if (vtList.FocusedNode <> nil) then
      begin
        Data := vtList.GetNodeData(vtList.FocusedNode);
        if (Data <> nil) and (Data^.DataRow <> nil) and (RowModel = nil) then
          RowModel := Data^.DataRow;
      end;
      if (vtList.FocusedNode <> nil) then
      begin
        Data := vtList.GetNodeData(vtList.FocusedNode);
        if (Data <> nil) then
          if (Data^.NodeType = tnFolder) or
             ((not HasFolders) and (Data^.Level <> PageIndex)) then
            Node := vtList.AddChild(vtList.FocusedNode)
          else
            Node := vtList.AddChild(vtList.FocusedNode.Parent);
      end
      else
      begin
        pgControl.ActivePageIndex := 0;
        Node := vtList.AddChild(nil);
      end;
      if (Node = nil) then exit;
      Data := vtList.GetNodeData(Node);
      if (Data = nil) then exit;
      Data^.Node     := Node;
      Data^.Level    := vtList.GetNodeLevel(Node);
      Data^.NodeType := tnData;
      if (FDataRow.Count = 0) and (Assigned(FOnInsert)) then
        FOnInsert(Self, FDataRow)
      else
        Data^.DataRow := TDataRow.CreateAs(nil, FDataRow);
      FFormsArray[FPageIndex].ScrState := dbmInsert;
      if (vtList.GetNodeLevel(Node) = 0) then
        Data^.DataRow.ClearFieldValues;
      if (not vtList.Expanded[vtList.FocusedNode]) then
        vtList.FullExpand(vtList.FocusedNode);
      vtList.Selected[Node]  := True;
      vtList.FocusedNode     := Node;
      if (vtList.GetNodeLevel(Node) > 0) then
        Data^.DataRow.ClearFieldValues;
    finally
      vtList.EndUpdate;
      vtList.OnFocusChanging := vtListFocusChanging;
      if (Node <> nil) then
        vtList.ScrollIntoView(Node, True)
    end;
  end
  else
    dmMain.DisplayMessage('Modelo da lista não criado... Podem ocorrer erros!');
end;

procedure TfrmModelMulti.CancelRecord;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (FPageIndex < Low(FFormsArray)) or
     (FPageIndex > High(FFormsArray)) then
  begin
    dmMain.DisplayMessage(Format('Erro: Número da Página inválido %d. ' +
      'Valor deve ser entre 0 e %d', [FPageIndex, High(FFormsArray)]), hiError);
    exit;
  end;
  if (not FCanInsertNode) then exit;
  if (ScrState = dbmInsert) then
  begin
    vtList.OnFocusChanging := nil;
    vtList.BeginUpdate;
    try
      Node := vtList.FocusedNode;
      if (Node = nil) then exit;
      Data := vtList.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Node := nil;
        Data^.DataRow.Free;
        Data^.DataRow := nil;
      end;
      FFormsArray[FPageIndex].ScrState := dbmCancel;
      if (vtList.RootNodeCount > 0) then
      begin
        vtList.FocusedNode := LastNode;
        if (Node <> nil) and (vtList.FocusedNode = nil) then
        begin
          vtList.FocusedNode := vtList.GetNext(Node);
          if (vtList.FocusedNode = nil) then
            vtList.FocusedNode := vtList.GetPrevious(Node);
          if (vtList.FocusedNode = nil) then
            vtList.FocusedNode := vtList.GetFirst;
        end;
        if (vtList.FocusedNode <> nil) then
          vtList.Selected[vtList.FocusedNode] := True;
      end;
      vtList.DeleteNode(Node);
    finally
      vtList.EndUpdate;
      vtList.OnFocusChanging := vtListFocusChanging;
    end;
  end;
end;

procedure TfrmModelMulti.ChangeState(Sender: TObject; AState: TDBMode);
begin
  FScrState := AState;
  UpdateScreen;
end;

procedure TfrmModelMulti.UpdateScreen;
begin
  tbInsert.Enabled := (FScrState in SCROLL_MODE);
  tbCancel.Enabled := (FScrState in UPDATE_MODE);
  tbDelete.Enabled := (FScrState in SCROLL_MODE) and (vtList.RootNodeCount > 0);
  tbSave.Enabled   := (FScrState in UPDATE_MODE);
  tbClose.Enabled  := (FScrState in SCROLL_MODE);
  sbStatus.Repaint;
  vtList.Refresh;
end;

function TfrmModelMulti.GetActiveRow(Index: Integer): TDataRow;
var
  Data: PGridData;
begin
  Result := RowModel;
  if (vtList.FocusedNode = nil) then exit;
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Result := Data^.DataRow;
end;

function TfrmModelMulti.GetFocusedLevel: Integer;
begin
  Result := 0;
  if (vtList.FocusedNode = nil) then exit;
  Result := vtList.GetNodeLevel(vtList.FocusedNode);
end;

function TfrmModelMulti.GetFocusedRow: TDataRow;
begin
  Result := nil;
  if (vtList.FocusedNode = nil) then exit;
  Result := PGridData(vtList.GetNodeData(vtList.FocusedNode))^.DataRow;
end;

procedure TfrmModelMulti.SetActiveRow(Index: Integer; const Value: TDataRow);
begin

end;

procedure TfrmModelMulti.SetDataRow(const Value: TDataRow);
var
  i: Integer;
begin
  if (Value = nil) then exit;
  FreeAndNil(FDataRow);
  FDataRow := TDataRow.CreateAs(Self, Value);
  for i := 0 to FDataRow.Count - 1 do
    FDataRow.Fields[i].Value := Value.Fields[i].Value;
end;

procedure TfrmModelMulti.SetPageIndex(const Value: Integer);
begin
  if (FPageIndex < Low(FFormsArray)) or
     (FPageIndex > High(FFormsArray)) then
    dmMain.DisplayMessage(Format('Erro: Número da Página inválido %d. ' +
      'Valor deve ser entre 0 e %d', [FPageIndex, High(FFormsArray)]), hiError)
  else
  begin
    FPageIndex := Value;
    if (FPageIndex < pgControl.PageCount) and
       (pgControl.ActivePageIndex <> FPageIndex) then
    begin
      pgControl.ActivePage.TabVisible := False;
      pgControl.ActivePageIndex       := FPageIndex;
    end;
    if (not pgControl.ActivePage.TabVisible) then
      pgControl.ActivePage.TabVisible := True;
  end;
end;

procedure TfrmModelMulti.LoadList;
begin
  ReleaseTreeNodes(vtList);
end;

procedure TfrmModelMulti.vtListIncrementalSearch(Sender: TBaseVirtualTree;
  Node: PVirtualNode; const SearchText: WideString; var Result: Integer);
var
  Data: PgridData;
  S, F: string;
  aLen: Integer;
begin
  if (Node = nil) or (FSearchField = '') or (ScrState in UPDATE_MODE) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Data^.DataRow.FindField[FSearchField] = nil) then
    exit;
  F := Data^.DataRow.FieldByName[FSearchField].AsString;
  S := SearchText;
  sbStatus.Panels[0].Text := 'Pesquisando por: ' + S;
  if (Length(F) < Length(S)) then
    aLen := Length(S)
  else
    aLen := Min(Length(S), Length(F));
  Result := StrLIComp(PAnsiChar(S), PAnsiChar(F), aLen);
  FSearchText := Copy(F, 1, Length(S));
end;

procedure TfrmModelMulti.vtListStateChange(Sender: TBaseVirtualTree; Enter,
  Leave: TVirtualTreeStates);
var
  X, Y : Integer;
  aRect: TRect;
begin
  if (FSearchField = '') or (ScrState in UPDATE_MODE) then exit;
  if (tsIncrementalSearching in Leave) then
  begin
    sbStatus.Panels[0].Text := 'Mensagem:';
    if (Sender.FocusedNode = nil) or (FSearchCol = -1) then exit;
    aRect := Sender.GetDisplayRect(Sender.FocusedNode, FSearchCol, True);
    TVirtualStringTree(Sender).Canvas.Brush.Color := clHighlight;
    aRect.Right  := (aRect.Left + Canvas.TextWidth(UpperCase(FSearchText)) -2);
    aRect.Top    := aRect.Top + 2;
    aRect.Bottom := aRect.Bottom - 3;
    X            := aRect.Left;
    Y            := aRect.Top;
    aRect.Left   := aRect.Left + 4;
    TVirtualStringTree(Sender).Canvas.FillRect(aRect);
    TVirtualStringTree(Sender).Canvas.Font.Color := clWhite;
    TVirtualStringTree(Sender).Canvas.TextOut(X + 4, Y, UpperCase(FSearchText));
    FSearchText := '';
  end;
end;

initialization
  RegisterClass(TfrmModelMulti);

end.

