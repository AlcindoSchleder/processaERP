unit CadPrg;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 23/01/2003 - DD/MM/YYYY                                     *}
{* Version: 2.0.0.0                                                      *}
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

uses SysUtils, Classes, VirtualTrees, ProcType, GridRow, ProcUtils, DB,
  {$IFNDEF LINUX}
    Windows, Graphics, Controls, Forms, Dialogs, ToolWin, ComCtrls, StdCtrls,
    ExtCtrls, Buttons, Menus
  {$ELSE}
    Qt, QGraphics, QControls, QForms, QDialogs, QToolWin, QComCtrls, QStdCtrls,
    QExtCtrls, QButtons,
  {$ENDIF};

type
  TTypeGridEdit = (geLanguage, geModule, geRotine, geProgram, geOther);

  TCdProgramas = class(TForm)
    cbTools: TCoolBar;
    pgControl: TPageControl;
    tsModules: TTabSheet;
    tbTools: TToolBar;
    tbNew: TToolButton;
    tbDel: TToolButton;
    tbClose: TToolButton;
    tbSep: TToolButton;
    tbSave: TToolButton;
    tbSepOpe: TToolButton;
    tbSepNav: TToolButton;
    sbStatus: TStatusBar;
    tbCancel: TToolButton;
    vtGrid: TVirtualStringTree;
    sSplitter: TSplitter;
    tsPrograms: TTabSheet;
    tsRotines: TTabSheet;
    vtEditGrid: TVirtualStringTree;
    pmNewMenu: TPopupMenu;
    pmNewLng: TMenuItem;
    pmNewMod: TMenuItem;
    pmNewRot: TMenuItem;
    pmNewPrg: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtGridGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtGridGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure tbCloseClick(Sender: TObject);
    procedure vtGridFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtGridFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtGridPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtEditGridGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vtEditGridGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtEditGridNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbStatusClick(Sender: TObject);
    procedure tbNewClick(Sender: TObject);
    procedure pmNewLngClick(Sender: TObject);
    procedure pmNewModClick(Sender: TObject);
    procedure pmNewRotClick(Sender: TObject);
    procedure pmNewPrgClick(Sender: TObject);
    procedure vtEditGridEdited(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure tbDelClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure vtEditGridFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtEditGridFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
  private
    { Private declarations }
    FCompanyClick: Boolean;
    FRect        : TRect;
    FScrLevel    : TOperationLevel;
    FScrState    : TDBMode;
    FTypeGridEdit: TTypeGridEdit;
    FOldPkLng    : string;
    procedure FillTreeView;
    procedure SetScrState(AValue: TDBMode);
    procedure ConfigLanguage(ADataRow: TDataRow);
    procedure ConfigModule(ADataRow: TDataRow);
    procedure ConfigRotine(ADataRow: TDataRow);
    procedure ConfigProgram(ADataRow: TDataRow);
    procedure SetTypeGridEdit(const Value: TTypeGridEdit);
    procedure ChangeState(Sender: TObject; AState: TDBMode; AErrorCode: Integer = 0; AMsg: string = '');
    property  TypeGridEdit: TTypeGridEdit read FTypeGridEdit write SetTypeGridEdit;
  public
    { Public declarations }
    property ScrState: TDBMode read FScrState write SetScrState;
  end;

var
  CdProgramas: TCdProgramas;

implementation

{$R *.dfm}

uses Sobre, Dado, ManArqSql, FuncoesDB, mSysMan, CmmConst, CadProg, SelEmpr,
  CadModls;

procedure TCdProgramas.FormCreate(Sender: TObject);
begin
  vtGrid.NodeDataSize       := SizeOf(TGridData);
  vtEditGrid.NodeDataSize   := SizeOf(TGridData);
  cbTools.Images            := Dados.Image16;
  tbTools.Images            := Dados.Image16;
  vtGrid.Images             := Dados.Image16;
  vtGrid.Header.Images      := Dados.Image16;
  vtEditGrid.Images         := Dados.Image16;
  vtEditGrid.Header.Images  := Dados.Image16;
  pmNewMenu.Images          := Dados.Image16;
  frmModules                := TfrmModules.Create(Application);
  frmModules.Parent         := tsModules;
  frmModules.BorderStyle    := bsNone;
  frmModules.Align          := alClient;
  frmModules.OnChangeState  := ChangeState;
  frmModules.Show;
  frmPrograms               := TfrmPrograms.Create(Application);
  frmPrograms.Parent        := tsPrograms;
  frmPrograms.BorderStyle   := bsNone;
  frmPrograms.Align         := alClient;
  frmPrograms.OnChangeState := ChangeState;
  frmPrograms.Show;
  pgControl.ActivePageIndex := 0;
end;

procedure TCdProgramas.FormActivate(Sender: TObject);
begin
  with Dados.Parametros do
  begin
    Caption   := Application.Title + ' - ' + soProgramTitle;
    FScrLevel := soUserOperation;
  end;
  FillTreeView;
  ScrState                  := dbmBrowse;
end;

procedure TCdProgramas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (pgControl.ActivePageIndex > 0) and (FScrState <> dbmBrowse) then
    if Application.MessageBox(PAnsiChar('CdProgramas: Há Alterações na Tela. ' +
         'Deseja Abandonar as Alterações?'), PAnsiChar(Application.Title),
         MB_ICONWARNING + MB_YESNO + MB_DEFBUTTON2) = IDNO then
      Action := caNone;
end;

procedure TCdProgramas.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtGrid);
  ReleaseTreeNodes(vtEditGrid);
end;

procedure TCdProgramas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
  end;
end;

procedure TCdProgramas.FillTreeView;
var
  aLng, aMod,
  aRot      : string;
  NodeLevel0,
  NodeLevel1,
  NodeLevel2: PVirtualNode;
  Data: PGridData;
  function AddData(ANode: PVirtualNode): PVirtualNode;
  begin
    Result        := vtGrid.AddChild(ANode);
    Data          := vtGrid.GetNodeData(Result);
    Data^.Level   := vtGrid.GetNodeLevel(Result);
    Data^.Node    := Result;
    Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysMan.Programa, True);
  end;
begin
  aLng := '';
  aMod := '';
  aRot := '';
  NodeLevel0 := nil;
  NodeLevel1 := nil;
  NodeLevel2 := nil;
  with dmSysMan do
  begin
    if Linguagem.Active then Linguagem.Close;
    if Programa.Active then Programa.Close;
    Programa.SQL.Clear;
    Programa.SQL.Add(SqlAllPrograms);
    if not Programa.Active then Programa.Open;
    vtGrid.BeginUpdate;
    try
      Programa.First;
      while not Programa.Eof do
      begin
        if aLng <> Programa.FieldByName('DSC_LANG').AsString then
        begin
          NodeLevel0 := AddData(nil);
          aLng := Programa.FieldByName('DSC_LANG').AsString;
        end;
        if aMod <> Programa.FieldByName('DSC_MOD').AsString then
        begin
          NodeLevel1    := AddData(NodeLevel0);
          aMod          := Programa.FieldByName('DSC_MOD').AsString;
        end;
        if (aRot <> Programa.FieldByName('DSC_ROT').AsString) then
        begin
          NodeLevel2    := AddData(NodeLevel1);
          aRot          := Programa.FieldByName('DSC_ROT').AsString;
        end;
        if (Programa.FieldByName('PK_PROGRAMAS').AsInteger > 0) then
          AddData(NodeLevel2);
        Programa.Next;
      end;
    finally
      vtGrid.EndUpdate;
      Programa.Close;
    end;
  end;
  if VtGrid.RootNodeCount = 0 then exit;
  NodeLevel0                  := vtGrid.GetFirst;
  vtGrid.FocusedNode          := NodeLevel0;
  vtGrid.Selected[NodeLevel0] := True;
  vtGrid.SetFocus;
end;

procedure TCdProgramas.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  SetScrState(AState);
end;

procedure TCdProgramas.vtGridGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) or (Column <> 0) then exit;
  Data := vtGrid.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := '...';
  case vtGrid.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['DSC_LANG'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DSC_MOD'].AsString + ' / ' +
                   Data^.DataRow.FieldByName['VERSAO'].AsString;
    2: CellText := Data^.DataRow.FieldByName['DSC_ROT'].AsString;
    3: CellText := Data^.DataRow.FieldByName['DSC_PRG'].AsString + ' / ' +
                   Data^.DataRow.FieldByName['NOM_LIB'].AsString + ' / ' +
                   Data^.DataRow.FieldByName['NOM_FRM'].AsString;
  end;
end;

procedure TCdProgramas.vtGridGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PGridData;
begin
  if (Node = nil) or (Column > 0) or (Kind in [ikOverlay, ikState]) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Ghosted := False;
  case Sender.GetNodeLevel(Node) of
    0: Imageindex := 87;
    1: Imageindex := 85;
    2: Imageindex := 82;
    3: if Data^.DataRow.FieldByName['FLAG_REL'].AsBoolean then
         ImageIndex := 6
       else
         Imageindex := 27;
  end;
end;

procedure TCdProgramas.vtGridFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  if (OldNode = nil) or (NewNode = nil) then exit;
  if vtGrid.Expanded[OldNode] then
    vtGrid.FullCollapse(OldNode);
  if (not vtGrid.Expanded[NewNode]) then
    vtGrid.FullExpand(NewNode);
end;

procedure TCdProgramas.vtGridFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: ConfigLanguage(Data^.DataRow);
    1: ConfigModule(Data^.DataRow);
    2: ConfigRotine(Data^.DataRow);
    3: ConfigProgram(Data^.DataRow);
  end;
end;

procedure TCdProgramas.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  if Panel.Index = 1 then
  begin
    with StatusBar.Canvas do
    begin
      FRect := Rect;
      FillRect(Rect);
      Font.Name := 'Arial';
      Font.Color := ClNavy;
      Font.Style := [FsBold];
      Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
      TextOut(Rect.Left + 22, Rect.Top + 1, 'Empresa: ' +
        InsereZer(IntToStr(Dados.PkCompany), 3) + '/' + Dados.NameCompany);
    end;
  end;
  if Panel.Index = 2 then
  begin
    StatusBar.Canvas.Brush.Color := clWhite;
    StatusBar.Canvas.FillRect(Rect);
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrState];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrState]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
  end;
end;

procedure TCdProgramas.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (Y >= FRect.TopLeft.Y) and
                   (Y <= (FRect.TopLeft.Y + 22));
end;

procedure TCdProgramas.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    SelEmpresa.Free;
  end;
  sbStatus.Repaint;
end;

procedure TCdProgramas.SetScrState(AValue: TDBMode);
begin
  if (FScrState <> AValue) then
  begin
    FScrState := AValue;
    tbDel.Enabled    := (vtGrid.RootNodeCount > 0) and (FScrState in SCROLL_MODE);
    tbCancel.Enabled := (FScrState in UPDATE_MODE);
    tbSave.Enabled   := (FScrState in UPDATE_MODE);
    if (FScrState in SCROLL_MODE) then
    begin
      if Assigned(frmModules) then
        frmModules.ScrState  := FScrState;
      if Assigned(frmPrograms) then
        frmPrograms.ScrState := FScrState;
    end;
  sbStatus.Repaint;
  end;
end;

procedure TCdProgramas.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCdProgramas.vtGridPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := vtGrid.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (vtGrid.GetNodeLevel(Node) = 2) and
     (Data^.DataRow.FindField['PK_PROGRAMAS'] = nil) and
     (Data^.DataRow.FieldByName['PK_PROGRAMAS'].AsInteger < 1) then
    TargetCanvas.Font.Color := clTeal;
end;

procedure TCdProgramas.ConfigLanguage(ADataRow: TDataRow);
var
  Node   : PVirtualNode;
  aFocused: PVirtualNode;
  Data   : PGridData;
begin
  FOldPkLng    := '';
  aFocused     := nil;
  TypeGridEdit := geLanguage;
  pgControl.ActivePageIndex := 1;
  ReleaseTreeNodes(vtEditGrid);
  with dmSysMan do
  begin
    if Linguagem.Active then Linguagem.Close;
    Linguagem.SQL.Clear;
    Linguagem.SQL.Add(SqlLinguagens);
    Dados.StartTransaction(Linguagem);
    vtEditGrid.BeginUpdate;
    try
      if (not Linguagem.Active) then Linguagem.Open;
      while (not Linguagem.eof) do
      begin
        Node := vtEditGrid.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtEditGrid.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level := 0;
            Data^.Node  := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, Linguagem, True);
          end;
          if (ADataRow.FieldByName['PK_LINGUAGENS'].AsString =
              Linguagem.FieldByName('PK_LINGUAGENS').AsString) then
            aFocused := Node;
        end;
        Linguagem.Next;
      end;
    finally
      if Linguagem.Active then Linguagem.Close;
      Dados.CommitTransaction(Linguagem);
      vtEditGrid.EndUpdate;
    end;
  end;
  with vtEditGrid do
  begin
    if (RootNodeCount > 0) and (aFocused <> nil) then
    begin
      FocusedNode        := aFocused;
      Selected[aFocused] := True;
      SetFocus;
    end;
  end;
end;

procedure TCdProgramas.ConfigModule(ADataRow: TDataRow);
begin
  TypeGridEdit := geModule;
  if Assigned(frmModules) then
  begin
    pgControl.ActivePageIndex  := 0;
    frmModules.FkLanguage      := ADataRow.FieldByName['PK_LINGUAGENS'].AsString;
    frmModules.ScrState        := ScrState;
    if (ScrState = dbmInsert) then
      frmModules.Pk           := 0
    else
      frmModules.Pk           := ADataRow.FieldByName['PK_MODULOS'].AsInteger;
  end;
end;

procedure TCdProgramas.ConfigProgram(ADataRow: TDataRow);
begin
  TypeGridEdit := geProgram;
  if Assigned(frmPrograms) then
  begin
    frmPrograms.FkLanguage    := ADataRow.FieldByName['PK_LINGUAGENS'].AsString;
    frmPrograms.FkModule      := ADataRow.FieldByName['PK_MODULOS'].AsInteger;
    frmPrograms.FkRotine      := ADataRow.FieldByName['PK_ROTINAS'].AsInteger;
    frmPrograms.ScrState       := ScrState;
    if (ScrState = dbmInsert) then
      frmPrograms.Pk            := 0
    else
      frmPrograms.Pk            := ADataRow.FieldByName['PK_PROGRAMAS'].AsInteger;
    pgControl.ActivePageIndex := 2;
  end;
end;

procedure TCdProgramas.ConfigRotine(ADataRow: TDataRow);
var
  Node    : PVirtualNode;
  aFocused: PVirtualNode;
  Data    : PGridData;
begin
  FOldPkLng := ADataRow.FieldByName['PK_LINGUAGENS'].AsString;
  TypeGridEdit := geRotine;
  pgControl.ActivePageIndex := 1;
  aFocused := nil;
  ReleaseTreeNodes(vtEditGrid);
  with dmSysMan do
  begin
    if Rotina.Active then Rotina.Close;
    Rotina.SQL.Clear;
    Rotina.SQL.Add(SqlRotinas);
    Dados.StartTransaction(Linguagem);
    vtEditGrid.BeginUpdate;
    try
      Rotina.ParamByName('FkLinguagens').AsString :=
        ADataRow.FieldByName['PK_LINGUAGENS'].AsString;
      if (not Rotina.Active) then Rotina.Open;
      while (not Rotina.Eof) do
      begin
        Node := vtEditGrid.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtEditGrid.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level := 0;
            Data^.Node  := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, Rotina, True);
          end;
          if (ADataRow.FieldByName['PK_ROTINAS'].AsString =
              Rotina.FieldByName('PK_ROTINAS').AsString) then
            aFocused := Node;
        end;
        Rotina.Next;
      end;
    finally
      if Rotina.Active then Rotina.Close;
      Dados.CommitTransaction(Linguagem);
      vtEditGrid.EndUpdate;
    end;
  end;
  with vtEditGrid do
  begin
    if (RootNodeCount > 0) and (aFocused <> nil) then
    begin
      FocusedNode       := aFocused;
      Selected[aFocused] := True;
    end;
  end;
end;

procedure TCdProgramas.vtEditGridGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if (Node = nil) or (Column > 0) or (Kind in [ikOverlay, ikState]) then exit;
  Ghosted := False;
  if (Column = 0) then
    if (FTypeGridEdit = geLanguage) then
      Imageindex := 87
    else
      ImageIndex := 82;
end;

procedure TCdProgramas.vtEditGridGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := '...';
  case Column of
    0: if (FTypeGridEdit = geLanguage) then
         CellText := Data^.DataRow.FieldByName['PK_LINGUAGENS'].AsString
       else
         CellText := Data^.DataRow.FieldByName['FK_LINGUAGENS'].AsString + ' / ' +
                     Data^.DataRow.FieldByName['PK_ROTINAS'].AsString;
    1: if (FTypeGridEdit = geLanguage) then
         CellText := Data^.DataRow.FieldByName['DSC_LANG'].AsString
       else
         CellText := Data^.DataRow.FieldByName['DSC_ROT'].AsString;
  end;
end;

procedure TCdProgramas.vtEditGridNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PGridData;
  aInt: Integer;
begin
  if (Node = nil) or (Column < 0) or (Column > 1) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (FTypeGridEdit = geRotine) and (Column = 0) then
  begin
    aInt    := StrToIntDef(NewText, 0);
    NewText := IntToStr(aInt);
  end;
  if (Column = 1) then
    NewText := Copy(NewText, 1, 30);
  Data^.DataRow.Fields[Column].AsString := NewText;
end;

procedure TCdProgramas.vtEditGridEdited(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  if (ScrState in SCROLL_MODE) then
    ScrState := dbmEdit;
end;

procedure TCdProgramas.SetTypeGridEdit(const Value: TTypeGridEdit);
begin
  FTypeGridEdit := Value;
  pmNewLng.Enabled := (FTypeGridEdit = geLanguage) or (FTypeGridEdit = geLanguage);
  pmNewMod.Enabled := (FTypeGridEdit = geLanguage) or (FTypeGridEdit = geModule);
  pmNewRot.Enabled := (FTypeGridEdit = geModule)   or (FTypeGridEdit = geRotine);
  pmNewPrg.Enabled := (FTypeGridEdit = geRotine)   or (FTypeGridEdit = geProgram);
  case FTypeGridEdit of
    geLanguage: tbNew.MenuItem := pmNewLng;
    geModule  : tbNew.MenuItem := pmNewMod;
    geProgram : tbNew.MenuItem := pmNewPrg;
    geRotine  : tbNew.MenuItem := pmNewRot;
  end;
end;

procedure TCdProgramas.tbNewClick(Sender: TObject);
begin
  case tbNew.MenuItem.Tag of
    0: pmNewLng.Click;
    1: pmNewMod.Click;
    2: pmNewRot.Click;
    3: pmNewPrg.Click;
  end;
end;

procedure TCdProgramas.pmNewLngClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtEditGrid.AddChild(nil);
  if (Node = nil) then exit;
  Data := vtEditGrid.GetNodeData(Node);
  if (Data = nil) then exit;
  Data.Level   := 0;
  Data.Node    := Node;
  Data.DataRow := TDataRow.Create(nil);
  Data.DataRow.AddAs('PK_LINGUAGENS', ' ', ftString, 6);
  Data.DataRow.AddAs('DSC_LANG', ' ', ftString, 31);
  ScrState     := dbmInsert;
end;

procedure TCdProgramas.pmNewModClick(Sender: TObject);
var
  Data: PGridData;
begin
  if (vtGrid.FocusedNode = nil) then exit;
  Data := vtGrid.GetNodeData(vtGrid.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ScrState := dbmInsert;
  ConfigModule(Data^.DataRow);
end;

procedure TCdProgramas.pmNewRotClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtEditGrid.AddChild(nil);
  if (Node = nil) then exit;
  Data := vtEditGrid.GetNodeData(Node);
  if (Data = nil) then exit;
  Data.Level   := 0;
  Data.Node    := Node;
  Data.DataRow := TDataRow.Create(nil);
  Data.DataRow.AddAs('FK_LINGUAGENS', ' ', ftString, 6);
  Data.DataRow.AddAs('PK_ROTINAS', 0, ftInteger, SizeOf(Integer));
  Data.DataRow.AddAs('DSC_ROT', ' ', ftString, 31);
  ScrState     := dbmInsert;
end;

procedure TCdProgramas.pmNewPrgClick(Sender: TObject);
var
  Data: PGridData;
begin
  if (vtGrid.FocusedNode = nil) then exit;
  Data := vtGrid.GetNodeData(vtGrid.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ScrState := dbmInsert;
  ConfigProgram(Data^.DataRow);
end;

procedure TCdProgramas.tbDelClick(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  Node := vtGrid.FocusedNode;
  if (Node = nil) then exit;
  if Dados.DisplayMessage('Deseja realmente excluir este registro?', hiQuestion,
     [mbYes, mbNo]) = mrNo then
    exit;
  Data := vtGrid.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case FTypeGridEdit of
    geLanguage: dmSysMan.SaveLanguage(Data^.DataRow, dbmDelete);
    geModule  : if Assigned(frmModules) then frmModules.ScrState := dbmDelete;
    geRotine  : dmSysMan.SaveRotine(Data^.DataRow, dbmDelete, FOldPkLng);
    geProgram : if Assigned(frmPrograms) then frmPrograms.ScrState := dbmDelete;
  end;
  Data^.Level := 0;
  Data^.Node  := nil;
  Data^.DataRow.Free;
  Data^.DataRow := nil;
  if (vtGrid.GetLast = Node) then
    vtGrid.FocusedNode := vtGrid.GetPrevious(Node)
  else
    vtGrid.FocusedNode := vtGrid.GetNext(Node);
  vtGrid.Selected[Node] := True;
  vtGrid.DeleteNode(Node);
  ScrState := dbmBrowse;
end;

procedure TCdProgramas.tbCancelClick(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  if (FTypeGridEdit in [geLanguage, geRotine]) and (ScrState = dbmInsert) then
  begin
    Node := vtEditGrid.FocusedNode;
    if (Node = nil) then exit;
    Data := vtEditGrid.GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    Data^.Level := 0;
    Data^.Node  := nil;
    Data^.DataRow.Free;
    Data^.DataRow := nil;
    vtEditGrid.DeleteNode(Node);
  end;
  case FTypeGridEdit of
    geLanguage: ;
    geModule  : if Assigned(frmModules) then frmModules.ScrState := dbmCancel;
    geRotine  : ;
    geProgram : if Assigned(frmModules) then frmPrograms.ScrState := dbmCancel;
  end;
  ScrState := dbmBrowse;
  vtGrid.SetFocus;
end;

procedure TCdProgramas.tbSaveClick(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  Node := vtEditGrid.FocusedNode;
  if (Node = nil) then exit;
  Data := vtEditGrid.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case FTypeGridEdit of
    geLanguage: dmSysMan.SaveLanguage(Data^.DataRow, ScrState, FOldPkLng);
    geModule  : if Assigned(frmModules) then frmModules.ScrState := dbmPost;
    geRotine  : dmSysMan.SaveRotine(Data^.DataRow, ScrState, FOldPkLng);
    geProgram : if Assigned(frmModules) then frmPrograms.ScrState := dbmPost;
  end;
  ScrState := dbmBrowse;
  vtGrid.SetFocus;
end;

procedure TCdProgramas.vtEditGridFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  Allowed := (FScrState in SCROLL_MODE);
end;

procedure TCdProgramas.vtEditGridFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (FTypeGridEdit = geLanguage) then
    FOldPkLng := Data^.DataRow.FieldByName['PK_LINGUAGENS'].AsString
  else
    if (Data^.DataRow.FieldByName['FK_LINGUAGENS'].AsString <> '') then
      FOldPkLng := Data^.DataRow.FieldByName['FK_LINGUAGENS'].AsString;
end;

initialization
  Classes.RegisterClass(TCdProgramas);

end.
