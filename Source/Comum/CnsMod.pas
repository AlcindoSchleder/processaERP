unit CnsMod;

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
  Dialogs, VirtualTrees, ComCtrls, ToolWin, ImgList, DB, GridRow, ProcUtils;

type
  TCnsModelo = class(TForm)
    sbStatus: TStatusBar;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbSepCopy: TToolButton;
    tbClose: TToolButton;
    pgParameters: TPageControl;
    tsParameters: TTabSheet;
    vtList: TVirtualStringTree;
    tbSepClose: TToolButton;
    tbCopy: TToolButton;
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure vtListIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure vtListStateChange(Sender: TBaseVirtualTree; Enter,
      Leave: TVirtualTreeStates);
    procedure vtListFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtListGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtListHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vtListCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
  private
    FColumnIndex  : Integer;
    FListLoaded   : Boolean;
    FItemImgNrmIdx: Integer;
    FItemImgSelIdx: Integer;
    FPk           : LongInt;
    FSearchCol    : shortint;
    FSearchField  : string;
    FSearchText   : string;
    FScrState     : TDBMode;
    FOnChangePk   : TNotifyEvent;
    function GetFocusedLevel: Integer;
    function GetFocusedRow: TDataRow;
    procedure SetListLoaded(const Value: Boolean);
    procedure SetPk(const Value: LongInt);
    procedure SetScrState(const Value: TDBMode);
    { Private declarations }
  protected
    { Protected declarations }
    FCompanyClick: Boolean;
    function  AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet): PVirtualNode; virtual;
    procedure ClearControls; dynamic; abstract;
    procedure LoadDefaults; virtual; abstract;
    procedure LoadList; virtual;
  public
    { Public declarations }
    property  FocusedRow   : TDataRow           read GetFocusedRow;
    property  FocusedLevel : Integer            read GetFocusedLevel;
    property  ItemImgNrmIdx: Integer            read FItemImgNrmIdx write FItemImgNrmIdx;
    property  ItemImgSelIdx: Integer            read FItemImgSelIdx write FItemImgSelIdx;
    property  ListLoaded   : Boolean            read FListLoaded    write SetListLoaded;
    property  Pk           : LongInt            read FPk            write SetPk;
    property  ScrState     : TDBMode            read FScrState      write SetScrState;
    property  SearchField  : string             read FSearchField   write FSearchField;
    property  SearchCol    : shortint           read FSearchCol     write FSearchCol default 0;
    property  OnChangePK   : TNotifyEvent       read FOnChangePk    write FOnChangePk;
  end;

implementation

uses Dado, ProcType, Math;

{$R *.dfm}

{ TCnsModelo }

function TCnsModelo.AddDataNode(ANode: PVirtualNode;
  ADataSet: TDataSet): PVirtualNode;
var
  Data: PGridData;
begin
  Result := vtList.AddChild(ANode);
  if (Result <> nil) then
  begin
    Data := vtList.GetNodeData(Result);
    if (Data <> nil) then
    begin
      Data^.Level   := vtList.GetNodeLevel(Result);
      Data^.Node    := Result;
      Data^.DataRow := TDataRow.CreateFromDataSet(nil, ADataSet, True);
    end;
  end;
end;

function TCnsModelo.GetFocusedLevel: Integer;
begin
  Result := 0;
  if (vtList.FocusedNode = nil) then exit;
  Result := vtList.GetNodeLevel(vtList.FocusedNode);
end;

function TCnsModelo.GetFocusedRow: TDataRow;
begin
  Result := nil;
  if (vtList.FocusedNode = nil) then exit;
  Result := PGridData(vtList.GetNodeData(vtList.FocusedNode))^.DataRow;
end;

procedure TCnsModelo.LoadList;
begin

end;

procedure TCnsModelo.SetListLoaded(const Value: Boolean);
begin
  FListLoaded := Value;
end;

procedure TCnsModelo.SetPk(const Value: LongInt);
begin
  FPk := Value;
end;

procedure TCnsModelo.SetScrState(const Value: TDBMode);
begin
  FScrState := Value;
end;

procedure TCnsModelo.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
begin
  if (Node = nil) or (Kind in [ikState, ikOverlay]) then exit;
  if (FItemImgNrmIdx = 0) then FItemImgNrmIdx := 4;
  if (FItemImgSelIdx = 0) then FItemImgSelIdx := 2;
  if (Column = 0) and (Sender.FocusedNode = Node) then
    ImageIndex := 6
  else
    if (Kind = ikSelected) then
      ImageIndex := FItemImgSelIdx
    else
      ImageIndex := FItemImgNrmIdx;
end;

procedure TCnsModelo.vtListIncrementalSearch(Sender: TBaseVirtualTree;
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

procedure TCnsModelo.vtListStateChange(Sender: TBaseVirtualTree; Enter,
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

procedure TCnsModelo.vtListFocusChanging(Sender: TBaseVirtualTree; OldNode,
  NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  Allowed := (NewColumn > 0);
end;

procedure TCnsModelo.vtListGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TGridData);
end;

procedure TCnsModelo.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column = 0) then CellText := '';
end;

procedure TCnsModelo.vtListBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if (Node = nil) then exit;
  if (Odd(Sender.AbsoluteIndex(Node))) then
    ItemColor := clSkyBlue
  else
    ItemColor := clInfoBk;
  EraseAction := eaColor;
end;

procedure TCnsModelo.vtListHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  Data: PGridData;
begin
// Select the column to search on grid
  if (FSearchField = '') or (vtList.RootNodeCount = 0) or (Column < 1) then exit;
  if (vtList.FocusedNode = nil) then vtList.FocusedNode := vtList.GetFirst;
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Sender.SortColumn = FColumnIndex then
    if Sender.SortDirection = sdAscending then
      Sender.SortDirection := sdDescending
    else
      Sender.SortDirection := sdAscending
  else
    Sender.SortDirection := sdAscending;
  Sender.SortColumn := FColumnIndex;
  vtList.SortTree(Sender.SortColumn, Sender.SortDirection);
end;

procedure TCnsModelo.vtListCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data: PGridData;
  Str1, Str2, aFn: string;
  function GetStringValue(aItem: TDataRow): string;
  begin
    aFn := FSearchField;
    if (Column = 0) then
      Result := InsereZer(IntToStr(aItem.FieldByName[aFn].AsInteger), 20)
    else
      Result := aItem.FieldByName[aFn].AsString;
  end;
begin
  if (Node1 = nil) or (Node2 = nil) or (Column < 0) or
     (Sender.GetNodeLevel(Node1) > 0) or (Sender.GetNodeLevel(Node2) > 0) then
    exit;
  Data := Sender.GetNodeData(Node1);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Str1 := GetStringValue(Data^.DataRow);
  Data := Sender.GetNodeData(Node2);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Str2 := GetStringValue(Data^.DataRow);
  case TVirtualStringTree(Sender).Header.SortDirection of
    sdAscending : Result := CompareText(Str1, Str2);
    sdDescending: Result := CompareText(Str1, Str2);
  end;
end;

end.
