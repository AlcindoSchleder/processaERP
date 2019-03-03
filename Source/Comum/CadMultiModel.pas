unit CadMultiModel;

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
  Dialogs, CadListModel, ComCtrls, VirtualTrees, ToolWin, ExtCtrls, ProcUtils,
  GridRow, CadModel, TSysManAux;

type
  TfrmMultiModel = class(TfrmModelList)
    pgMain: TPageControl;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FOnLoadList : TNotifyEvent;
    FOnLoadPages: TNotifyEvent;
    FPages      : TModelPages;
    function  GetActiveRow(Index: Integer): TDataRow;
    procedure LoadPages(Sender: TObject);
    procedure LoadList(Sender: TObject);
    procedure SetModelPages(const Value: TModelPages);
    function GetPageIndex: Integer;
  protected
    { Protected declarations }
    procedure SetActiveRow(Index: Integer; const Value: TDataRow); virtual;
    procedure SetScrState(const Value: TDBMode); override;
    procedure InsertRecord; override;
    procedure CancelRecord; override;
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  OnListLoad;
  public
    { Public declarations }
    procedure ChangeState(Sender: TObject; AState: TDBMode; AErrorCode: Integer = 0;
                AMsg: string = '');
    property  PageIndex                : Integer      read GetPageIndex;
    property  ActiveRow[Index: Integer]: TDataRow     read GetActiveRow write SetActiveRow;
    property  Pages                    : TModelPages  read FPages       write SetModelPages;
    property  OnLoadPages              : TNotifyEvent read FOnLoadPages write FOnLoadPages;
    property  OnLoadList               : TNotifyEvent read FOnLoadList  write FOnLoadList;
  published
    { published declaretions }
    property  CanInsertNode;
    property  CheckRecord;
    property  Debug;
    property  FocusedRow;
    property  FocusedLevel;
    property  HasFolders;
    property  ItemImgNrmIdx;
    property  ItemImgSelIdx;
    property  ListLoaded;
    property  Loading;
    property  Pk;
    property  PkAux;
    property  RowModel;
    property  ScrState;
    property  SearchCol;
    property  SearchField;
    property  OnCancel;
    property  OnChangePK;
    property  OnChangeState;
    property  OnCheckRecord;
    property  OnInsert;
    property  OnInternalState;
    property  OnUpdateRow;
  end;

var
  frmMultiModel: TfrmMultiModel;

implementation

{$R *.dfm}

uses Dado, ProcType;

procedure TfrmMultiModel.CancelRecord;
begin
  if (PageIndex < 0) or
     (PageIndex >= FPages.Count) then
  begin
    Dados.DisplayMessage(Format('Erro: Número da Página inválido %d. ' +
      'Valor deve ser entre 0 e %d', [PageIndex, FPages.Count - 1]), hiError);
    exit;
  end;
  inherited;
  if (FPages.Items[PageIndex].Form is TfrmModel) then
    TfrmModel(FPages.Items[PageIndex].Form).ScrState := dbmCancel;
end;

procedure TfrmMultiModel.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  ScrState := AState;
end;

procedure TfrmMultiModel.FormDestroy(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    if Assigned(FPages) then
      FPages.Free;
    FPages := nil;
  finally
    Screen.Cursor := crDefault;
  end;
  OnLoadPages := nil;
  OnLoadList  := nil;
  inherited;
end;

procedure TfrmMultiModel.FormShow(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  if Assigned(FPages) and (FPages.Count > 0) then
    for i := 0 to FPages.Count - 1 do
      FPages.Items[i].ShowForm;
end;

function TfrmMultiModel.GetActiveRow(Index: Integer): TDataRow;
begin
  Result := FocusedRow;
end;

procedure TfrmMultiModel.InsertRecord;
var
  Node: PVirtualNode;
  Data: PGridData;
  VDat: TDataRow;
begin
  if (PageIndex < 0) or
     (PageIndex >= FPages.Count) then
  begin
    Dados.DisplayMessage(Format('Erro: Número da Página inválido %d. ' +
      'Valor deve ser entre 0 e %d', [PageIndex, FPages.Count - 1]), hiError);
    exit;
  end;
  LastNode := nil;
  Node     := nil;
  if (not CanInsertNode) then exit;
  if (RowModel <> nil) then
  begin
    vtList.OnFocusChanging := nil;
    vtList.BeginUpdate;
    try
      if (vtList.FocusedNode <> nil) then
      begin
        Data := vtList.GetNodeData(vtList.FocusedNode);
        if (Data <> nil) and (Data^.DataRow <> nil) then
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
        pgMain.ActivePageIndex := 0;
        Node := vtList.AddChild(nil);
      end;
      if (Node = nil) then exit;
      Data := vtList.GetNodeData(Node);
      if (Data = nil) then exit;
      Data^.Node     := Node;
      Data^.Level    := vtList.GetNodeLevel(Node);
      Data^.NodeType := tnData;
      if (RowModel.Count = 0) and (Assigned(OnInsert)) then
      begin
        VDat := RowModel;
        OnInsert(Self, VDat);
      end
      else
        Data^.DataRow := TDataRow.CreateAs(nil, RowModel);
      if (FPages.Items[PageIndex].Form is TfrmModel) then
        TfrmModel(FPages.Items[PageIndex].Form).ScrState := dbmInsert;
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
    Dados.DisplayMessage('Modelo da lista não criado... Podem ocorrer erros!');
end;

procedure TfrmMultiModel.SetActiveRow(Index: Integer; const Value: TDataRow);
begin
  if (Index < -1) and (Index >= Pages.Count) then
  begin
    Dados.DisplayHint(pgMain, Format('SetActiveRow: Index %d inválido', [Index]), hiError);
    exit;
  end;
  if (not pgMain.Pages[Index].TabVisible) then
  begin
    if (Debug) then
      ShowMessage('inherit SetActiveRow -> PageCount: ' + IntToStr(pgMain.PageCount) + ' and Index: ' + IntToStr(Index));
    Pages.ItemIndex := Index;
  end;
end;

procedure TfrmMultiModel.SetScrState(const Value: TDBMode);
begin
  if (ScrState <> Value) then
  begin
    if (PageIndex < 0) or
       (PageIndex >= FPages.Count) then
      Dados.DisplayMessage(Format('Erro: Número da Página inválido %d. ' +
        'Valor deve ser entre 0 e %d', [PageIndex, FPages.Count - 1]), hiError);
    if (Value <> dbmPost) and (FPages.Items[PageIndex].Form is TfrmModel) then
      TfrmModel(FPages.Items[PageIndex].Form).ScrState := Value;
    inherited;
    if (Value = dbmPost) and (FPages.Items[PageIndex].Form is TfrmModel) then
      TfrmModel(FPages.Items[PageIndex].Form).ScrState := Value;
  end;
end;

procedure TfrmMultiModel.FormCreate(Sender: TObject);
begin
  inherited;
  FPages := TModelPages.Create(Self);
  FPages.PageControl := pgMain;
  OnChangeState := ChangeState;
  OnListLoad    := LoadList;
  OnListLoaded  := LoadPages;
end;

procedure TfrmMultiModel.ClearControls;
begin
  inherited;

end;

procedure TfrmMultiModel.LoadDefaults;
begin
  inherited;

end;

procedure TfrmMultiModel.LoadPages(Sender: TObject);
begin
  if (Assigned(FOnLoadPages)) then
  begin
    if (Debug) then
      ShowMessage('Calling OnLoadPages');
    FOnLoadPages(Self);
    if (vtList.RootNodeCount = 0) then
      SetActiveRow(0, RowModel);
  end;
end;

procedure TfrmMultiModel.MoveDataToControls;
begin
  inherited;

end;

procedure TfrmMultiModel.SaveIntoDB;
begin
  inherited;

end;

procedure TfrmMultiModel.LoadList(Sender: TObject);
begin
  if (Assigned(FOnLoadList)) then
  begin
    if (Debug) then
      ShowMessage('Calling OnLoadList');
    FOnLoadList(Self);
  end;
end;

procedure TfrmMultiModel.SetModelPages(const Value: TModelPages);
begin
  if (Value <> nil) then
    FPages.Assign(Value);
end;

function TfrmMultiModel.GetPageIndex: Integer;
begin
  Result := Pages.ItemIndex;
end;

end.
