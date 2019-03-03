unit CadListModel;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 03/01/2006 - DD/MM/YYYY                                    *}
{* Modified : 22/10/2008 - DD/MM/YYYY                                    *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcUtils, VirtualTrees, ComCtrls, ToolWin, ImgList, GridRow, DB, 
  PrcSysTypes, CadModel, ExtCtrls, ProcType;

type
  THandleInsertEvent = procedure (Sender: TObject; var Row: TDataRow) of object;

  TfrmModelList = class(TfrmModel)
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
    pMain: TPanel;
    spSplitter: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbStatusClick(Sender: TObject);
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
    procedure vtListGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
  private
    { Private declarations }
    FDataRow         : TDataRow;
    FCanInsertNode   : Boolean;
    FItemImgNrmIdx   : Integer;
    FItemImgSelIdx   : Integer;
    FOnCancel        : TNotifyEvent;
    FOnInsert        : THandleInsertEvent;
    FLastNode        : PVirtualNode;
    FRect            : TRect;
    FSearchCol       : shortint;
    FSearchField     : string;
    FSearchText      : string;
    FHasFolders      : Boolean;
    FOnListLoad      : TNotifyEvent;
    FOnListLoaded    : TNotifyEvent;
    function  GetFocusedRow: TDataRow;
    function  GetFocusedLevel: Integer;
    procedure SetDataRow(const Value: TDataRow);
    procedure LoadList;
    procedure LoadedList;
  protected
    { Protected declarations }
    FCompanyClick: Boolean;
    procedure InsertRecord; override;
    procedure CancelRecord; override;
    procedure SetScrState(const Value: TDBMode); override;
    function  AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet): PVirtualNode; overload; virtual;
    function  AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet;
                var AData: PGridData): PVirtualNode; overload; virtual;
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    procedure SetListLoaded(const Value: Boolean); override;
    property  OnListLoaded : TNotifyEvent       read FOnListLoaded   write FOnListLoaded;
  public
    { Public declarations }
    LastNode : PVirtualNode;
  published
    { published declaretions }
    property  CheckRecord;
    property  Debug;
    property  ListLoaded;
    property  Loading;
    property  Pk;
    property  PkAux;
    property  ScrState;
    property  OnChangePK;
    property  OnChangeState;
    property  OnCheckRecord;
    property  OnInternalState;
    property  OnUpdateRow;
    property  CanInsertNode: Boolean            read FCanInsertNode    write FCanInsertNode;
    property  FocusedRow   : TDataRow           read GetFocusedRow;
    property  FocusedLevel : Integer            read GetFocusedLevel;
    property  HasFolders   : Boolean            read FHasFolders       write FHasFolders;
    property  ItemImgNrmIdx: Integer            read FItemImgNrmIdx    write FItemImgNrmIdx;
    property  ItemImgSelIdx: Integer            read FItemImgSelIdx    write FItemImgSelIdx;
    property  RowModel     : TDataRow           read FDataRow          write SetDataRow;
    property  SearchField  : string             read FSearchField      write FSearchField;
    property  SearchCol    : ShortInt           read FSearchCol        write FSearchCol default 0;
    property  OnCancel     : TNotifyEvent       read FOnCancel         write FOnCancel;
    property  OnInsert     : THandleInsertEvent read FOnInsert         write FOnInsert;
    property  OnListLoad   : TNotifyEvent       read FOnListLoad       write FOnListLoad;
  end;

implementation

{$R *.dfm}

{ TfrmModel }

uses Dado, SelEmpr, FuncoesDB, Math;

procedure TfrmModelList.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    BorderStyle          := bsSizeable;
    cbTools.Images       := Dados.Image16;
    tbTools.Images       := Dados.Image16;
    vtList.Images        := Dados.Image16;
    vtList.Header.Images := Dados.Image16;
    FLastNode            := nil;
    FCanInsertNode       := True;
    FSearchCol           := 0;
    FSearchField         := '';
    inherited;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmModelList.FormDestroy(Sender: TObject);
begin
  inherited;
  ReleaseTreeNodes(vtList);
  OnInsert      := nil;
  OnCancel      := nil;
  FOnListLoad   := nil;
  FOnListLoaded := nil;
end;

procedure TfrmModelList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (ScrState in UPDATE_MODE) then
    if (Dados.DisplayMessage('Há alterações na tela. Deseja sair e abandonar ' +
          'as alterações?', hiQuestion, [mbYes, mbNo]) = mrNo) then
      Action := caNone;
end;

procedure TfrmModelList.FormShow(Sender: TObject);
begin
  Caption := Application.Title + ' - ' + Dados.Parametros.soTitle;
  LoadList;
  LoadedList;
  LoadDefaults;
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
  begin
    LoadList;
    LoadedList;
  end;
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

procedure TfrmModelList.SetScrState(const Value: TDBMode);
begin
  inherited;
  tbInsert.Enabled := (ScrState in SCROLL_MODE) and (FCanInsertNode);
  tbCancel.Enabled := (ScrState in UPDATE_MODE);
  tbDelete.Enabled := (ScrState in SCROLL_MODE) and (vtList.RootNodeCount > 0);
  tbSave.Enabled   := (ScrState in UPDATE_MODE);
  tbClose.Enabled  := (ScrState in SCROLL_MODE);
  sbStatus.Repaint;
  vtList.Refresh;
end;

function TfrmModelList.AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet): PVirtualNode;
var
  AData: PGridData;
begin
  Result := vtList.AddChild(ANode);
  if (Result <> nil) then
  begin
    AData := vtList.GetNodeData(Result);
    if (AData <> nil) then
    begin
      AData^.Level   := vtList.GetNodeLevel(Result);
      AData^.Node    := Result;
      AData^.DataRow := TDataRow.CreateFromDataSet(nil, ADataSet, True);
    end;
  end;
end;

function TfrmModelList.AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet;
  var AData: PGridData): PVirtualNode;
begin
  Result := vtList.AddChild(ANode);
  if (Result <> nil) then
  begin
    AData := vtList.GetNodeData(Result);
    if (AData <> nil) then
    begin
      AData^.Level   := vtList.GetNodeLevel(Result);
      AData^.Node    := Result;
      AData^.DataRow := TDataRow.CreateFromDataSet(nil, ADataSet, True);
    end;
  end;
end;

procedure TfrmModelList.sbStatusClick(Sender: TObject);
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
  sbStatus.Repaint;
  LoadList;
  LoadedList;
end;

procedure TfrmModelList.sbStatusDrawPanel(StatusBar: TStatusBar;
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
      IntToStr(Dados.PkCompany) + ' / ' + Dados.NameCompany);
  end;
  if Panel.Index = 2 then
  begin
    StatusBar.Canvas.Font.Color  := FontColorMode[ScrState];
    StatusBar.Canvas.Brush.Color :=     ColorMode[ScrState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[ScrState]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[ScrState]);
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
    if (Dados.DisplayMessage('Deseja realmente excluir este registro?', hiQuestion,
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
    Dados.DisplayMessage('Modelo da lista não criado... Podem ocorrer erros!');
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
  if (Debug) then
    ShowMessage('Starting Load List');
  if (Assigned(FOnListLoad)) then
  begin
    if (Debug) then
      ShowMessage('Calling OnListLoad');
    FOnListLoad(Self);
  end;
end;

procedure TfrmModelList.SetListLoaded(const Value: Boolean);
begin
  inherited;
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

procedure TfrmModelList.vtListGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TGridData);
end;

procedure TfrmModelList.ClearControls;
begin

end;

procedure TfrmModelList.LoadDefaults;
begin
  inherited;
  if (Debug) then
    ShowMessage('Starting Load Defaults');
end;

procedure TfrmModelList.MoveDataToControls;
begin
  inherited;

end;

procedure TfrmModelList.SaveIntoDB;
begin
  inherited;

end;

procedure TfrmModelList.LoadedList;
begin
  if (Assigned(FOnListLoaded)) then
  begin
    if (Debug) then
      ShowMessage('Calling OnListLoaded');
    FOnListLoaded(Self);
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    if (Debug) then
      ShowMessage('Setting First Node');
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
    vtList.FullExpand;
  end;
end;

end.
