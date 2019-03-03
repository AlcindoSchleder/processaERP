unit CadModelList;

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
  Dialogs, ProcUtils, VirtualTrees, ComCtrls, ToolWin, ImgList, GridRow,
  PrcSysTypes, DB;

type
  THandleInsertEvent = procedure (Sender: TObject; var Row: TDataRow) of object;

  TfrmModelList = class(TForm)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    sbStatus: TStatusBar;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    tbSave: TToolButton;
    tbSepSave: TToolButton;
    vtList: TVirtualStringTree;
    tbSepClose: TToolButton;
    tbClose: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChangeGlobal(Sender: TObject);
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
    procedure sbStatusClick(Sender: TObject);
  private
    { Private declarations }
    FItemImgNrmIdx  : Integer;
    FItemImgSelIdx  : Integer;
    FListLoaded     : Boolean;
    FLoading        : Boolean;
    FPk             : LongInt;
    FRect           : TRect;
    FScrState       : TDBMode;
    FOnChangePk     : TNotifyEvent;
    FOnChangeState  : TChangeStateEvent;
    FOnCancel       : TNotifyEvent;
    FOnInsert       : THandleInsertEvent;
    FOnCheckRecord  : TOnCheckRecord;
    FCheckRecord    : Boolean;
    FDataRow        : TDataRow;
    FCanInsertNode  : Boolean;
    FLastNode       : PVirtualNode;
    FSearchCol      : shortint;
    FSearchField    : string;
    FSearchText     : string;
    FBeforeDestroy: TNotifyEvent;
    procedure InsertRecord;
    procedure CancelRecord;
    procedure SetPk(const Value: LongInt);
    procedure SetScrState(const Value: TDBMode);
    function  GetFocusedRow: TDataRow;
    function  GetFocusedLevel: Integer;
    procedure SetDataRow(const Value: TDataRow);
    procedure SetListLoaded(const Value: Boolean);
  protected
    { Protected declarations }
    FCompanyClick: Boolean;
    function  AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet;
      ATree: TBaseVirtualTree = nil): PVirtualNode; virtual;
    procedure ClearControls; dynamic; abstract;
    procedure LoadDefaults; virtual; abstract;
    procedure LoadList; virtual;
    procedure MoveDataToControls; dynamic; abstract;
    procedure SaveIntoDB; dynamic; abstract;
  public
    { Public declarations }
    property  FocusedRow   : TDataRow           read GetFocusedRow;
    property  FocusedLevel : Integer            read GetFocusedLevel;
    property  CheckRecord  : Boolean            read FCheckRecord;
    property  CanInsertNode: Boolean            read FCanInsertNode write FCanInsertNode;
    property  LastNode     : PVirtualNode       read FLastNode;
    property  RowModel     : TDataRow           read FDataRow       write SetDataRow;
    property  ItemImgNrmIdx: Integer            read FItemImgNrmIdx write FItemImgNrmIdx;
    property  ItemImgSelIdx: Integer            read FItemImgSelIdx write FItemImgSelIdx;
    property  ListLoaded   : Boolean            read FListLoaded    write SetListLoaded;
    property  Loading      : Boolean            read FLoading       write FLoading;
    property  Pk           : LongInt            read FPk            write SetPk;
    property  ScrState     : TDBMode            read FScrState      write SetScrState;
    property  SearchField  : string             read FSearchField   write FSearchField;
    property  SearchCol    : shortint           read FSearchCol     write FSearchCol default 0;
    property  OnChangePK   : TNotifyEvent       read FOnChangePk    write FOnChangePk;
    property  OnChangeState: TChangeStateEvent  read FOnChangeState write FOnChangeState;
    property  BeforeDestroy: TNotifyEvent       read FBeforeDestroy write FBeforeDestroy;
    property  OnInsert     : THandleInsertEvent read FOnInsert      write FOnInsert;
    property  OnCancel     : TNotifyEvent       read FOnCancel      write FOnCancel;
    property  OnCheckRecord: TOnCheckRecord     read FOnCheckRecord write FOnCheckRecord;
  end;

implementation

{$R *.dfm}

{ TfrmModel }

uses MainData, ProcType, FuncoesDB, Math;

procedure TfrmModelList.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    FOnChangeState       := nil;
    FOnChangePk          := nil;
    OnInsert             := nil;
    OnCancel             := nil;
    FBeforeDestroy       := nil;
    cbTools.Images       := dmMain.Image16;
    tbTools.Images       := dmMain.Image16;
    vtList.Images        := dmMain.Image16;
    vtList.Header.Images := dmMain.Image16;
    vtList.NodeDataSize  := SizeOf(TGridData);
    FScrState            := dbmBrowse;
    FLastNode            := nil;
    FCanInsertNode       := True;
    FSearchCol           := 0;
    FSearchField         := '';
    ClearControls;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmModelList.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtList);
  if (Assigned(FBeforeDestroy)) then
    FBeforeDestroy(Self);
  FOnChangeState := nil;
  FOnChangePk    := nil;
  OnInsert       := nil;
  OnCancel       := nil;
  inherited;
end;

procedure TfrmModelList.FormClose(Sender: TObject;
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

procedure TfrmModelList.FormShow(Sender: TObject);
begin
  Caption := Application.Title;
  LoadDefaults;
  LoadList;
  ScrState := dbmBrowse;
end;

procedure TfrmModelList.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmModelList.ChangeGlobal(Sender: TObject);
begin
  if (Loading) or (FScrState in UPDATE_MODE) then exit;
  if (FScrState = dbmBrowse) and (Pk = 0) then
    ScrState := dbmInsert
  else
    ScrState := dbmEdit;
end;

procedure TfrmModelList.SetScrState(const Value: TDBMode);
begin
  if (FScrState <> Value) then
  begin
    if (Value = dbmCancel) then
      CancelRecord;
    if (Value <> dbmPost) then
        FScrState := Value
    else
      if (FScrState in UPDATE_MODE) and Assigned(FOnCheckRecord) then
        if (not FOnCheckRecord(FScrState, Value)) then exit;
    case Value of
      dbmInsert: InsertRecord;
      dbmDelete: SaveIntoDB;
      dbmPost  : SaveIntoDB;
      dbmCancel: MoveDataToControls;
      dbmBrowse: MoveDataToControls;
    end;
    if Assigned(FOnChangeState) then
      FOnChangeState(Self, Value);
    FScrState := Value;
  end;
  tbInsert.Enabled := (FScrState in SCROLL_MODE) and (FCanInsertNode);
  tbCancel.Enabled := (FScrState in UPDATE_MODE);
  tbDelete.Enabled := (FScrState in SCROLL_MODE) and (vtList.RootNodeCount > 0);
  tbSave.Enabled   := (FScrState in UPDATE_MODE);
  tbClose.Enabled  := (FScrState in SCROLL_MODE);
  sbStatus.Repaint;
  vtList.Refresh;
end;

procedure TfrmModelList.SetPk(const Value: LongInt);
begin
  if (Value <> FPk) then
  begin
    FPk := Value;
    MoveDataToControls;
    if Assigned(FOnChangePk) then
      FOnChangePk(Self);
  end;
end;

function TfrmModelList.AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet;
  ATree: TBaseVirtualTree = nil): PVirtualNode;
var
  Data: PGridData;
begin
  if (ATree = nil) then ATree := vtList;
  Result := ATree.AddChild(ANode);
  if (Result <> nil) then
  begin
    Data := ATree.GetNodeData(Result);
    if (Data <> nil) then
    begin
      Data^.Level   := ATree.GetNodeLevel(Result);
      Data^.Node    := Result;
      Data^.DataRow := TDataRow.CreateFromDataSet(nil, ADataSet, True);
    end;
  end;
end;

procedure TfrmModelList.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  if (Panel.Index < 1) then exit;
  StatusBar.Canvas.Brush.Color := clBtnFace;
  StatusBar.Canvas.Font.Style  := [fsBold];
  StatusBar.Canvas.Font.Name := 'Arial';
  if (Panel.Index = 1) then
  begin
    FRect := Rect;
    StatusBar.Canvas.Font.Color := ClNavy;
    dmMain.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
    StatusBar.Canvas.TextOut(Rect.Left + 22, Rect.Top + 1,'Empresa: ' +
      IntToStr(dmMain.PkActiveCompany) + ' / ' + dmMain.CompanyName);
  end;
  if Panel.Index = 2 then
  begin
    StatusBar.Canvas.FillRect(Rect);
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrState];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrState]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
  end;
end;

procedure TfrmModelList.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TfrmModelList.tbInsertClick(Sender: TObject);
begin
  ScrState := dbmInsert;
end;

procedure TfrmModelList.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmCancel;
  ScrState := dbmBrowse;
end;

procedure TfrmModelList.tbDeleteClick(Sender: TObject);
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

procedure TfrmModelList.tbSaveClick(Sender: TObject);
begin
  ScrState := dbmPost;
  if (ScrState = dbmPost) then
    ScrState := dbmBrowse;
end;

procedure TfrmModelList.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmModelList.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
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

procedure TfrmModelList.InsertRecord;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  FLastNode := nil;
  Node      := nil;
  if (not FCanInsertNode) then exit;
  if (FDataRow <> nil) then
  begin
    vtList.OnFocusChanging := nil;
    vtList.BeginUpdate;
    try
      FLastNode := vtList.FocusedNode;
      if (vtList.FocusedNode <> nil) then
      begin
        Data := vtList.GetNodeData(vtList.FocusedNode);
        if (Data <> nil) then
          if (Data^.NodeType = tnFolder) then
            Node := vtList.AddChild(vtList.FocusedNode)
          else
            Node := vtList.AddChild(vtList.FocusedNode.Parent);
      end
      else
        Node := vtList.AddChild(nil);
      if (Node = nil) then exit;
      Data := vtList.GetNodeData(Node);
      if (Data = nil) then exit;
      Data^.Node    := Node;
      Data^.Level   := vtList.GetNodeLevel(Node);
      if (FDataRow = nil) then
        Data^.DataRow := TDataRow.Create(nil)
      else
        if (FDataRow.Count = 0) and (Assigned(FOnInsert)) then
          FOnInsert(Self, FDataRow)
        else
          Data^.DataRow := TDataRow.CreateAs(nil, FDataRow);
      if (Pk > 0) then ClearControls;
      if (not vtList.Expanded[vtList.FocusedNode]) then
        vtList.FullExpand(vtList.FocusedNode);
      vtList.Selected[Node]  := True;
      vtList.FocusedNode     := Node;
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

procedure TfrmModelList.CancelRecord;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
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
      end
      else
        ClearControls;
      vtList.DeleteNode(Node);
      if (Assigned(OnCancel)) then OnCancel(Self);
    finally
      vtList.EndUpdate;
      vtList.OnFocusChanging := vtListFocusChanging;
    end;
  end;
end;

procedure TfrmModelList.vtListFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  Allowed := (ScrState in SCROLL_MODE);
end;

function TfrmModelList.GetFocusedRow: TDataRow;
begin
  Result := nil;
  if (vtList.FocusedNode = nil) then exit;
  Result := PGridData(vtList.GetNodeData(vtList.FocusedNode))^.DataRow;
end;

function TfrmModelList.GetFocusedLevel: Integer;
begin
  Result := 0;
  if (vtList.FocusedNode = nil) then exit;
  Result := vtList.GetNodeLevel(vtList.FocusedNode);
end;

procedure TfrmModelList.SetDataRow(const Value: TDataRow);
begin
  if (Value = nil) then exit;
  FreeAndNil(FDataRow);
  FDataRow := TDataRow.CreateAs(Self, Value);
end;

procedure TfrmModelList.LoadList;
begin
  ReleaseTreeNodes(vtList);
end;

procedure TfrmModelList.SetListLoaded(const Value: Boolean);
begin
  FListLoaded := Value;
  if (not ListLoaded) then LoadDefaults;
end;

procedure TfrmModelList.vtListIncrementalSearch(Sender: TBaseVirtualTree;
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

procedure TfrmModelList.vtListStateChange(Sender: TBaseVirtualTree; Enter,
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

procedure TfrmModelList.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  // Change the company...
//  Application.CreateForm(TSelEmpresa, SelEmpresa);
//  try
//    SelEmpresa.ShowModal;
//  finally
//    FCompanyClick := False;
//    SelEmpresa.Free;
//  end;
//  sbStatus.Repaint;
//  LoadList;
//  LoadedList;
end;

end.
