unit CnsHist;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 05/08/2006 - DD/MM/YYYY                                    *}
{* Modified :            - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, VirtualTrees, ExtCtrls, StdCtrls, Mask, ProcUtils,
  ToolEdit, CheckLst, Menus, PrcCombo;

type
  TFileOperation  = (foInsert, foEdit, foDelete);
  TFileOperations = set of TFileOperation;

  TFilterType = (ftInitialDate, ftFinalDate, ftInitialHour, ftFinalHour);
  PFilterData = ^TFilterData;
  TFilterData = packed record
    FilterType : TFilterType;
    InitialDate: TDateTime;
    FinalDate  : TDateTime;
  end;

  TfrmViewHistoric = class(TForm)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbFirst: TToolButton;
    tbPrior: TToolButton;
    tbNext: TToolButton;
    tbLast: TToolButton;
    tbNavSep: TToolButton;
    tbClose: TToolButton;
    tbSearch: TToolButton;
    tbSchSep: TToolButton;
    pSearch: TPanel;
    vtSearch: TVirtualStringTree;
    lSelOpe: TStaticText;
    pDtaIni: TPanel;
    eDtaIni: TDateEdit;
    tbCtrlDtaIni: TTrackBar;
    lDtaIni: TStaticText;
    lDtaFin: TStaticText;
    lSelTable: TStaticText;
    clbSelOperations: TCheckListBox;
    lSelOperations: TStaticText;
    pDtaFin: TPanel;
    eDtaFin: TDateEdit;
    tbCtrlDtaFin: TTrackBar;
    sbStatus: TStatusBar;
    pmSearchButton: TPopupMenu;
    pmSearch: TMenuItem;
    pmNewSearch: TMenuItem;
    eHorIni: TDateTimePicker;
    eHorFin: TDateTimePicker;
    eSelOpe: TPrcComboBox;
    eSelTable: TPrcComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure tbCloseClick(Sender: TObject);
    procedure tbFirstClick(Sender: TObject);
    procedure tbPriorClick(Sender: TObject);
    procedure tbNextClick(Sender: TObject);
    procedure tbLastClick(Sender: TObject);
    procedure tbSearchClick(Sender: TObject);
    procedure tbCtrlDtaIniChange(Sender: TObject);
    procedure tbCtrlDtaFinChange(Sender: TObject);
    procedure clbSelOperationsDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure vtSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtSearchPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtSearchBeforeItemErase(Sender: TBaseVirtualTree;
      Canvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtSearchHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vtSearchCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure eHorIniChange(Sender: TObject);
    procedure eHorFinChange(Sender: TObject);
  private
    { Private declarations }
    FScrState : TDBMode;
    FDtaFinRef: TDateTime;
    FDtaIniRef: TDateTime;
    FDtaFin   : TDateTime;
    FDtaIni   : TDateTime;
    procedure BuildSQL;
    procedure ClearControls;
    function  GetDtaFin: TDateTime;
    function  GetDtaIni: TDateTime;
    function  GetFileOperations: TFileOperations;
    function  GetOperator: string;
    function  GetTable: string;
    procedure SetDtaFin(const Value: TDateTime);
    procedure SetDtaIni(const Value: TDateTime);
    procedure SetFileOperations(const Value: TFileOperations);
    procedure SetOperator(const Value: string);
    procedure SetScrState(const Value: TDBMode);
    procedure SetTable(const Value: string);
    procedure SetButtons;
    procedure LoadGrid(ASql: string);
    procedure SetFilter(AFilter: TFilterType);
    procedure HideNodes(Sender: TBaseVirtualTree; Node: PVirtualNode;
                Data: Pointer; var Abort: Boolean);
  protected
    { Protected declarations }
    property DtaFin       : TDateTime       read GetDtaFin         write SetDtaFin;
    property DtaIni       : TDateTime       read GetDtaIni         write SetDtaIni;
    property FileOperation: TFileOperations read GetFileOperations write SetFileOperations;
    property Operator     : string          read GetOperator       write SetOperator;
    property Table        : string          read GetTable          write SetTable;
    property ScrState     : TDBMode         read FScrState         write SetScrState;
  public
    { Public declarations }
  end;

var
  frmViewHistoric: TfrmViewHistoric;

implementation

{$R *.dfm}

uses Dado, FuncoesDB, Funcoes, GridRow, ProcType, mSysMan, DateUtils;

const
  OPERATION_BACKGROUND_COLOR: array [TFileOperation] of TColor =
     (clSkyBlue , clMoneyGreen, $008DE4E9);
  OPERATION_FONT_COLOR      : array [TFileOperation] of TColor =
     (clMaroon, clGreen, clBlack);
  OPERATION_STRINGS         : array [0..4] of string =
     ('Navegando nos registros', 'Consultando os registros',
      'Inclusão dos registros', 'Edição de registros', 'Exclusão de registros');
  GRID_MAP_FIELDS           : array [0..4] of string =
     ('NOM_USU', 'NOM_ARQ', 'DTHR_OPE', 'NOM_FORM', 'FLAG_TOPE');

procedure TfrmViewHistoric.FormCreate(Sender: TObject);
begin
  cbTools.Images             := Dados.Image16;
  tbTools.Images             := Dados.Image16;
  pmSearchButton.Images      := Dados.Image16;
  vtSearch.Images            := Dados.Image16;
  vtSearch.Header.Images     := Dados.Image16;
  vtSearch.NodeDataSize      := SizeOf(TGridData);
  clbSelOperations.Header[0] := True;
  ClearControls;
  ScrState                   := dbmFind;
  Caption := Application.Title + ' - ' + Dados.Parametros.soProgramTitle;
end;

procedure TfrmViewHistoric.FormActivate(Sender: TObject);
begin
  eSelOpe.Items.AddStrings(dmSysMan.LoadOperators);
  Dados.Conexao.GetTableNames(eSelTable.Items);
end;

procedure TfrmViewHistoric.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtSearch);
  eSelTable.Clear;
  eSelOpe.ReleaseObjects;
end;

function TfrmViewHistoric.GetDtaFin: TDateTime;
begin
  Result := eDtaFin.Date;
end;

function TfrmViewHistoric.GetDtaIni: TDateTime;
begin
  Result := eDtaIni.Date;
end;

function TfrmViewHistoric.GetFileOperations: TFileOperations;
var
  i: Integer;
begin
  if clbSelOperations.Checked[1] then
  begin
    Result := [foInsert, foEdit, foDelete];
    exit;
  end;
  Result := [];
  for i := 2 to clbSelOperations.Count - 1 do
  begin
    if clbSelOperations.Checked[i] then
      Result := Result + [TFileOperation(i - 2)];
  end;
end;

function TfrmViewHistoric.GetOperator: string;
begin
  Result := eSelOpe.Text;
end;

function TfrmViewHistoric.GetTable: string;
begin
  Result := eSelTable.Text;
end;

procedure TfrmViewHistoric.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  with StatusBar.Canvas do
  begin
    if Panel.Index = 1 then
    begin
        Brush.Color := Self.Color;
        FillRect(Rect);
        Font.Name := 'Arial';
        Font.Color := ClNavy;
        Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
        TextOut(Rect.Left + 22, Rect.Top + 1, ' Empresa: ' +
          InsereZer(IntToStr(Dados.PkCompany), 3) + '/' + Dados.NameCompany);
    end;
    if Panel.Index = 2 then
    begin
      FillRect(Rect);
      Font.Color  := FontColorMode[FScrState];
      Brush.Color :=     ColorMode[FScrState];
      X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
           (TextWidth(ModeTypes[FScrState]) div 2);
      TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
    end;
  end;
end;

procedure TfrmViewHistoric.SetDtaFin(const Value: TDateTime);
begin
  eDtaFin.Date          := Value;
  tbCtrlDtaFin.Enabled  := (Value > 0);
  tbCtrlDtaFin.Position := 0;
end;

procedure TfrmViewHistoric.SetDtaIni(const Value: TDateTime);
begin
  eDtaIni.Date          := Value;
  tbCtrlDtaIni.Enabled  := (Value > 0);
  tbCtrlDtaIni.Position := 0;
end;

procedure TfrmViewHistoric.SetFileOperations(const Value: TFileOperations);
var
  i: Integer;
begin
  if (Value = [foInsert, foEdit, foDelete])then
  begin
    clbSelOperations.Checked[1] := True;
    exit;
  end;
  for i := 2 to clbSelOperations.Count - 1 do
  begin
    if (TFileOperation(i - 2) in Value) then
      clbSelOperations.Checked[i] := True ;
  end;
end;

procedure TfrmViewHistoric.SetOperator(const Value: string);
begin
  eSelOpe.Text := Value;
end;

procedure TfrmViewHistoric.SetScrState(const Value: TDBMode);
begin
  FScrState    := Value;
  if FScrState = dbmFind then
    ClearControls
  else
    BuildSQL;
  SetButtons;
  eDtaIni.Enabled          := (Value = dbmFind);
  eDtaFin.Enabled          := (Value = dbmFind);
  clbSelOperations.Enabled := (Value = dbmFind);
  eSelOpe.Enabled          := (Value = dbmFind);
  eSelTable.Enabled        := (Value = dbmFind);
  pmSearch.Visible         := (Value = dbmFind);
  pmNewSearch.Visible      := (Value = dbmBrowse);
  eHorIni.Visible          := (Value = dbmBrowse);
  eHorFin.Visible          := (Value = dbmBrowse);
  tbCtrlDtaFin.Enabled     := (Value = dbmBrowse);
  tbCtrlDtaIni.Enabled     := (Value = dbmBrowse);
  case Value of
    dbmBrowse: tbSearch.MenuItem := pmNewSearch;
    dbmFind  : tbSearch.MenuItem := pmSearch;
  end;
end;

procedure TfrmViewHistoric.SetButtons;
var
  Node: PVirtualNode;
  aOk: Boolean;
begin
  Node := vtSearch.FocusedNode;
  aOk := (Node <> nil) and (vtSearch.RootNodeCount > 0);
  tbFirst.Enabled := (FScrState = dbmBrowse) and (aOk) and (Node <> vtSearch.GetFirst);
  tbPrior.Enabled := (FScrState = dbmBrowse) and (aOk) and (Node <> vtSearch.GetFirst);
  tbNext.Enabled  := (FScrState = dbmBrowse) and (aOk) and (Node <> vtSearch.GetLast);
  tbLast.Enabled  := (FScrState = dbmBrowse) and (aOk) and (Node <> vtSearch.GetLast);
end;

procedure TfrmViewHistoric.SetTable(const Value: string);
begin
  eSelTable.Text := Value;
end;

procedure TfrmViewHistoric.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmViewHistoric.tbFirstClick(Sender: TObject);
begin
  vtSearch.FocusedNode := vtSearch.GetFirst;
  SetButtons;
end;

procedure TfrmViewHistoric.tbPriorClick(Sender: TObject);
begin
  vtSearch.FocusedNode := vtSearch.GetPrevious(vtSearch.FocusedNode);
  SetButtons;
end;

procedure TfrmViewHistoric.tbNextClick(Sender: TObject);
begin
  vtSearch.FocusedNode := vtSearch.GetNext(vtSearch.FocusedNode);
end;

procedure TfrmViewHistoric.tbLastClick(Sender: TObject);
begin
  vtSearch.FocusedNode := vtSearch.GetLast;
  SetButtons;
end;

procedure TfrmViewHistoric.tbSearchClick(Sender: TObject);
begin
  if FScrState = dbmBrowse then
    ScrState := dbmFind
  else
    ScrState := dbmBrowse;
end;

procedure TfrmViewHistoric.BuildSQL;
var
  aStr: TStrings;
  aAnd: Boolean;
  aIdx: Integer;
  aVal: string;
begin
  aStr := TStringList.Create;
  try
    aStr.Add('select * from HISTORICOS');
    if (Operator <> '') and (Operator <> '<Nenhum>') then
      aStr.Add(' where NOM_USU = :NomUsu');
    if (Table <> '') and (Table <> '<Nenhum>') then
      if (Pos('where', aStr.Text) > 0) then
        aStr.Add('   and NOM_ARQ = :NomArq')
      else
        aStr.Add(' where NOM_ARQ = :NomArq');
    aAnd := False;
    if (DtaIni > 0) then
    begin
      aAnd := True;
      if (Pos('where', aStr.Text) > 0) then
        aStr.Add('   and ((DTHR_OPE >= :DtaIni)')
      else
        aStr.Add(' where ((DTHR_OPE >= :DtaIni)');
    end;
    if (DtaFin > 0) then
    begin
      if aAnd then
        if (Pos('where', aStr.Text) > 0) then
          aStr.Add('  and (DTHR_OPE <= :DtaFin))')
        else
          aStr.Add(' where (DTHR_OPE <= :DtaFin)')
      else
        if (Pos('where', aStr.Text) > 0) then
          aStr.Add('   and DTHR_OPE <= :DtaFin')
        else
          aStr.Add(' where DTHR_OPE <= :DtaFin');
    end
    else
      if aAnd then
        aStr.Strings[aStr.Count - 1] := aStr.Strings[aStr.Count - 1] + ')';
    if (FileOperation <> [foInsert, foEdit, foDelete]) then
    begin
      if (Pos('where', aStr.Text) > 0) then
        aStr.Add('   and FLAG_TOPE in (')
      else
        aStr.Add(' where FLAG_TOPE in (');
      aIdx := aStr.Count - 1;
      aVal := '';
//0 ==> Navegação
//1 ==> Consulta
//2 ==> Inclusão
//3 ==> Atualização
//4 ==> Exclusão
      if (foInsert in FileOperation) then
        aVal := aVal + '2';
      aAnd := aVal <> '';
      if (foEdit in FileOperation) then
        if aAnd then
          aVal := aVal + ', 3'
        else
          aVal := aVal + '3';
      aAnd := aVal <> '';
      if (foDelete in FileOperation) then
        if aAnd then
          aVal := aVal + ', 4'
        else
          aVal := aVal + '4';
      aStr.Strings[aIdx] := aStr.Strings[aIdx] + aVal + ')';
    end;
    aStr.Add(' order by DTHR_OPE');
    LoadGrid(aStr.Text);
  finally
    FreeAndNil(aStr);
  end;
end;

procedure TfrmViewHistoric.LoadGrid(ASql: string);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  with dmSysMan do
  begin
    if qrHistorico.Active then qrHistorico.Close;
    qrHistorico.SQL.Clear;
    qrHistorico.SQL.Add(ASql);
    Dados.StartTransaction(qrHistorico);
    try
      if (qrHistorico.Params.FindParam('NomUsu') <> nil) then
        qrHistorico.ParamByName('NomUsu').AsString       := Operator;
      if (qrHistorico.Params.FindParam('NomArq') <> nil) then
        qrHistorico.ParamByName('NomArq').AsString       := Table;
      if (qrHistorico.Params.FindParam('DtaIni') <> nil) then
        qrHistorico.ParamByName('DtaIni').AsDate         := DtaIni;
      if (qrHistorico.Params.FindParam('DtaFin') <> nil) then
        qrHistorico.ParamByName('DtaFin').AsDate         := DtaFin;
      if (not qrHistorico.Active) then qrHistorico.Open;
      FDtaIniRef := StrToDateTime(DateToStr(qrHistorico.FieldByName('DTHR_OPE').AsDateTime) +
        ' 00:00:01') ;
      while (not qrHistorico.Eof) do
      begin
        Node := vtSearch.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtSearch.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Node    := Node;
            Data^.Level   := 0;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrHistorico, True);
          end;
        end;
        FDtaFinRef := StrToDateTime(DateToStr(qrHistorico.FieldByName('DTHR_OPE').AsDateTime) +
          ' 23:59:59') ;
        qrHistorico.Next;
      end;
    finally
      if qrHistorico.Active then qrHistorico.Close;
      Dados.CommitTransaction(qrHistorico);
    end;
  end;
  if (vtSearch.RootNodeCount > 0) then
  begin
    vtSearch.FocusedNode := vtSearch.GetFirst;
    vtSearch.Selected[vtSearch.FocusedNode] := True;
  end;
  FDtaIni          := FDtaIniRef;
  FDtaFin          := FDtaFinRef;
  eDtaIni.Date     := DateOf(FDtaIniRef);
  eDtaFin.Date     := DateOf(FDtaFinRef);
  eHorIni.Time     := TimeOf(FDtaIniRef);
  eHorFin.Time     := TimeOf(FDtaFinRef);
  tbCtrlDtaIni.Max := Trunc(FDtaFinRef - FDtaIniRef);
  tbCtrlDtaIni.Min := 0;
  tbCtrlDtaFin.Max := 0;
  tbCtrlDtaFin.Min := Trunc(FDtaIniRef - FDtaFinRef);
end;

procedure TfrmViewHistoric.tbCtrlDtaIniChange(Sender: TObject);
begin
  FDtaIni      := FDtaIniRef;
  ReplaceDate(FDtaIni, FDtaIniRef + tbCtrlDtaIni.Position);
  eDtaIni.Date := FDtaIni;
  SetFilter(ftInitialDate);
end;

procedure TfrmViewHistoric.tbCtrlDtaFinChange(Sender: TObject);
begin
  FDtaFin      := FDtaFinRef;
  ReplaceDate(FDtaFin, FDtaFinRef + tbCtrlDtaFin.Position);
  eDtaFin.Date := FDtaFin;
  SetFilter(ftFinalDate);
end;

procedure TfrmViewHistoric.ClearControls;
begin
  ReleaseTreeNodes(vtSearch);
  FileOperation   := [foInsert, foEdit, foDelete];
  DtaIni          := 0;
  DtaFin          := 0;
  eHorIni.Checked := False;
  eHorIni.Time    := 0;
  eHorFin.Checked := False;
  eHorFin.Time    := 0;
  Operator        := '<Nenhum>';
  Table           := '<Nenhum>';
end;

procedure TfrmViewHistoric.clbSelOperationsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with clbSelOperations.Canvas do
  begin
    if (Index in [0, 1]) then
    begin
      if (Index = 0) then
        Brush.Color := clSkyBlue
      else
        Brush.Color := clWindow;
      Font.Color := clWindowText;
      FillRect(Rect);
      TextOut(Rect.Left, Rect.Top, clbSelOperations.Items.Strings[Index]);
    end
    else
    begin
      Brush.Color := OPERATION_BACKGROUND_COLOR[TFileOperation(Index - 2)];
      Font.Color  := OPERATION_FONT_COLOR[TFileOperation(Index - 2)];
      FillRect(Rect);
      TextOut(Rect.Left, Rect.Top, clbSelOperations.Items.Strings[Index]);
    end;
  end;
end;

procedure TfrmViewHistoric.vtSearchGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
  aDate: TDateTime;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column = 2) then
  begin
    ReplaceDate(aDate, Data^.DataRow.FieldByName['DTHR_OPE'].AsDateTime);
    ReplaceTime(aDate, Data^.DataRow.FieldByName['DTHR_OPE'].AsDateTime);
  end;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['NOM_USU'].AsString;
    1: CellText := Data^.DataRow.FieldByName['NOM_ARQ'].AsString;
    2: CellText := DateTimeToStr(aDate);
    3: CellText := Data^.DataRow.FieldByName['NOM_FORM'].AsString;
    4: CellText := OPERATION_STRINGS[Data^.DataRow.FieldByName['FLAG_TOPE'].AsInteger];
  end;
end;

procedure TfrmViewHistoric.vtSearchPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FLAG_TOPE'].AsInteger = 2) then
    TargetCanvas.Font.Color  := OPERATION_FONT_COLOR[foInsert];
  if (Data^.DataRow.FieldByName['FLAG_TOPE'].AsInteger = 3) then
    TargetCanvas.Font.Color  := OPERATION_FONT_COLOR[foEdit];
  if (Data^.DataRow.FieldByName['FLAG_TOPE'].AsInteger = 4) then
    TargetCanvas.Font.Color  := OPERATION_FONT_COLOR[foDelete];
end;

procedure TfrmViewHistoric.vtSearchBeforeItemErase(Sender: TBaseVirtualTree;
  Canvas: TCanvas; Node: PVirtualNode; ItemRect: TRect; var ItemColor: TColor;
  var EraseAction: TItemEraseAction);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FLAG_TOPE'].AsInteger = 2) then
  begin
    vtSearch.Canvas.Brush.Color := OPERATION_BACKGROUND_COLOR[foInsert];
    ItemColor                   := OPERATION_BACKGROUND_COLOR[foInsert];
  end;
  if (Data^.DataRow.FieldByName['FLAG_TOPE'].AsInteger = 3) then
  begin
    vtSearch.Canvas.Brush.Color := OPERATION_BACKGROUND_COLOR[foEdit];
    ItemColor                   := OPERATION_BACKGROUND_COLOR[foEdit];
  end;
  if (Data^.DataRow.FieldByName['FLAG_TOPE'].AsInteger = 4) then
  begin
    vtSearch.Canvas.Brush.Color := OPERATION_BACKGROUND_COLOR[foDelete];
    ItemColor                   := OPERATION_BACKGROUND_COLOR[foDelete];
  end;
  EraseAction := eaColor;
end;

procedure TfrmViewHistoric.vtSearchHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if (Column < 0) and (Column > 4) then exit;
  if (vtSearch.Header.SortColumn = -1) then
    vtSearch.Header.SortDirection := sdAscending
  else
    if (vtSearch.Header.SortDirection = sdAscending) then
      vtSearch.Header.SortDirection := sdDescending
    else
      vtSearch.Header.SortDirection := sdAscending;
  vtSearch.Header.SortColumn := Column;
end;

procedure TfrmViewHistoric.vtSearchCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data: PGridData;
  Str1,
  Str2: string;
  function GetStringValue(aItem: TDataRow): string;
  var
    aFn      : string;
  begin
    aFn := GRID_MAP_FIELDS[Column];
    if (Column = 4) then
      Result := OPERATION_STRINGS[aItem.FieldByName[aFn].AsInteger]
    else
      Result := aItem.FieldByName[aFn].AsString;
    if (Column < 4) and (aItem.FieldByName[aFn].IsNumeric) then
      Result := InsereZer(Result, 18);
  end;
begin
  if (Node1 = nil) or (Node2 = nil) or (Column < 0) or (Column > 4) then exit;
  Data := Sender.GetNodeData(Node1);
  if (Data = nil) and (Data^.DataRow = nil) or
    (Data^.DataRow.Count <= Column) then exit;
  Str1 := GetStringValue(Data^.DataRow);
  Data := Sender.GetNodeData(Node2);
  if (Data = nil) and (Data^.DataRow = nil) or
    (Data^.DataRow.Count <= Column) then exit;
  Str2 := GetStringValue(Data^.DataRow);
  case TVirtualStringTree(Sender).Header.SortDirection of
    sdAscending : Result := CompareText(Str1, Str2);
    sdDescending: Result := CompareText(Str1, Str2);
  end;
end;

procedure TfrmViewHistoric.SetFilter(AFilter: TFilterType);
var
  aFilterData: PFilterData;
begin
  vtSearch.BeginUpdate;
  GetMem(aFilterData, SizeOf(TFilterData));
  try
    aFilterData^.FilterType  := AFilter;
    aFilterData^.InitialDate := FDtaIni;
    aFilterData^.FinalDate   := FDtaFin;
    vtSearch.IterateSubtree(nil, HideNodes, aFilterData, [], True);
  finally
    vtSearch.EndUpdate;
    FreeMem(aFilterData, SizeOf(TFilterData));
  end;
end;

procedure TfrmViewHistoric.HideNodes(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  aData: PGridData;
  aTimeIni: TTime;
  aTimeFin: TTime;
  aDateIni: TDate;
  aDateFin: TDate;
begin
  if (Node = nil) or (Data = nil) then exit;
  aData := Sender.GetNodeData(Node);
  if (aData = nil) or (aData^.DataRow = nil) then exit;
  aTimeIni := TimeOf(PFilterData(Data)^.InitialDate);
  aTimeFin := TimeOf(PFilterData(Data)^.FinalDate);
  aDateIni := DateOf(PFilterData(Data)^.InitialDate);
  aDateFin := DateOf(PFilterData(Data)^.FinalDate);
  with aData^.DataRow do
    Sender.IsVisible[Node] :=
      (((aDateIni <= DateOf(FieldByName['DTHR_OPE'].AsDateTime))  and
        (aDateFin >= DateOf(FieldByName['DTHR_OPE'].AsDateTime))) and
       ((aTimeIni <= TimeOf(FieldByName['DTHR_OPE'].AsDateTime))  and
        (aTimeFin >= TimeOf(FieldByName['DTHR_OPE'].AsDateTime))));
end;

procedure TfrmViewHistoric.eHorIniChange(Sender: TObject);
begin
  if (eHorIni.Checked) and (eHorIni.Time > 0) then
  begin
    ReplaceTime(FDtaIniRef, eHorIni.Time);
    FDtaIni := FDtaIniRef;
    SetFilter(ftInitialHour);
  end;
end;

procedure TfrmViewHistoric.eHorFinChange(Sender: TObject);
begin
  if (eHorFin.Checked) and (eHorFin.Time > 0) then
  begin
    ReplaceTime(FDtaFinRef, eHorFin.Time);
    FDtaFin      := FDtaFinRef;
    SetFilter(ftFinalHour);
  end;
end;

initialization
  RegisterClass(TfrmViewHistoric);

end.
