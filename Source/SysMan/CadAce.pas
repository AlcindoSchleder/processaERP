unit CadAce;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
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

uses SysUtils, Classes, VirtualTrees, ProcType, GridRow, ProcUtils, DB, Encryp,
     TSysManAux, TSysGen, TSysCad,
  {$IFDEF WIN32}
    Windows, Graphics, Controls, Forms, Dialogs, ToolWin, ComCtrls, StdCtrls,
    ExtCtrls, Buttons, Mask, ToolEdit, CurrEdit, PrcCombo, Menus
  {$ELSE}
    Qt, QGraphics, QControls, QForms, QDialogs, QToolWin, QComCtrls, QStdCtrls,
    QExtCtrls
  {$ENDIF};

type
  TAccessKey = record
    Module: Integer;
    Rotine: Integer;
    Progrm: Integer;
    Access: Integer;
  end;

  TOperatorFlags = record
    FlagBrw: Boolean;
    FlagFnd: Boolean;
    FlagIns: Boolean;
    FlagUpd: Boolean;
    FlagDel: Boolean;
    FlagVis: Boolean;
  end;

  TCdAcessos = class(TForm)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbClose: TToolButton;
    tbPriorMod: TToolButton;
    tbNextMod: TToolButton;
    tbSep: TToolButton;
    tbPriorPrg: TToolButton;
    tbNextPrg: TToolButton;
    tbSepSearch: TToolButton;
    vtOperator: TVirtualStringTree;
    spOpeAccess: TSplitter;
    pgControl: TPageControl;
    tsAccess: TTabSheet;
    tsOperator: TTabSheet;
    vtGrid: TVirtualStringTree;
    lPk_Operadores: TStaticText;
    ePk_Operadores: TEdit;
    sbAltPasswd: TSpeedButton;
    sbAltPwdDB: TSpeedButton;
    eDsct_Max: TCurrencyEdit;
    lDsct_Max: TStaticText;
    lFk_Linguagens: TStaticText;
    lFlag_LSen: TCheckBox;
    lFk_Cadastros: TStaticText;
    lEmail_Ope: TStaticText;
    eEmail_Ope: TEdit;
    gbActions: TGroupBox;
    lFlag_Fnd: TCheckBox;
    lFlag_Ins: TCheckBox;
    lFlag_Upd: TCheckBox;
    lFlag_Del: TCheckBox;
    lFlag_Brw: TCheckBox;
    Crypto: TCrypto;
    sbStatus: TStatusBar;
    eFk_Linguagens: TPrcComboBox;
    eFk_Cadastros: TPrcComboBox;
    sbNew: TSpeedButton;
    sbCancel: TSpeedButton;
    sbDelete: TSpeedButton;
    sbSave: TSpeedButton;
    ToolButton1: TToolButton;
    tbLegend: TToolButton;
    pmLegend: TPopupMenu;
    pmShow: TMenuItem;
    pmBrowse: TMenuItem;
    pmInsert: TMenuItem;
    pmEdit: TMenuItem;
    pmFind: TMenuItem;
    pmDelete: TMenuItem;
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
    procedure tbPriorModClick(Sender: TObject);
    procedure tbPriorPrgClick(Sender: TObject);
    procedure tbNextPrgClick(Sender: TObject);
    procedure tbNextModClick(Sender: TObject);
    procedure tbCloseClick(Sender: TObject);
    procedure tbAboutClick(Sender: TObject);
    procedure vtGridFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtGridFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtOperatorGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtOperatorFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtGridInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtGridChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtGridBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure vtOperatorGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure sbAltPasswdClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbNewClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure ChangeGlobal(Sender: TObject);
    procedure pgControlChange(Sender: TObject);
    procedure pmShowDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure eFk_CadastrosSelect(Sender: TObject);
    procedure vtGridColumnClick(Sender: TBaseVirtualTree;
      Column: TColumnIndex; Shift: TShiftState);
  private
    { Private declarations }
    FCompanyClick: Boolean;
    FSecLevel    : TOperationLevel;
    FLastMod     : PVirtualNode;
    FdrAccess    : TDataRow;
    FKey         : TAccessKey;
    FFlags       : TOperatorFlags;
    FRect        : TRect;
    FActvOper    : string;
    FScrState    : TDBMode;
    FDataBasePwd : string;
    FOperatorPwd : string;
    procedure GetOperatorData;
    procedure GetProgramsData;
    procedure DeleteRecord;
    function  SaveAllData(AMode: TDBMode): Boolean;
    procedure SetActvOper(AValue: string);
    procedure SetdrAccess(AValue: TDataRow);
    function  EncryptPasswd(const New, Actual: string; const SaveDB: Boolean): Boolean;
    procedure ClearControls;
    procedure SaveIntoDB;
    procedure MoveDataToControls;
    function GetDsctMax: Double;
    function GeteEmailOpe: string;
    function GetFkLanguage: TLanguage;
    function GetFkOwner: Integer;
    function GetFlagBrw: Boolean;
    function GetFlagDel: Boolean;
    function GetFlagFnd: Boolean;
    function GetFlagIns: Boolean;
    function GetFlagUpd: Boolean;
    function GetOperator: TOperator;
    procedure SetDataBasePwd(const Value: string);
    procedure SetDsctMax(const Value: Double);
    procedure SeteEmailOpe(const Value: string);
    procedure SetFkLanguage(const Value: TLanguage);
    procedure SetFkOwner(const Value: Integer);
    procedure SetFlagBrw(const Value: Boolean);
    procedure SetFlagDel(const Value: Boolean);
    procedure SetFlagFnd(const Value: Boolean);
    procedure SetFlagIns(const Value: Boolean);
    procedure SetFlagUpd(const Value: Boolean);
    procedure SetOperator(const Value: TOperator);
    procedure SetScrState(const Value: TDBMode);
    function GetFlagLSen: Boolean;
    procedure SetFlagLSen(const Value: Boolean);
    function GetPkOperator: string;
    procedure SetOperatorPwd(const Value: string);
    procedure SetPkOperator(const Value: string);
  protected
    { Protected declarations }
    property Operator   : TOperator read GetOperator    write SetOperator;
    property ScrState   : TDBMode   read FScrState      write SetScrState;
    property PkOperator : string    read GetPkOperator  write SetPkOperator;
    property OperatorPwd: string    read FOperatorPwd   write SetOperatorPwd;
    property DataBasePwd: string    read FDataBasePwd   write SetDataBasePwd;
    property DsctMax    : Double    read GetDsctMax     write SetDsctMax;
    property FkLanguage : TLanguage read GetFkLanguage  write SetFkLanguage;
    property FkOwner    : Integer   read GetFkOwner     write SetFkOwner;
    property eEmailOpe  : string    read GeteEmailOpe   write SeteEmailOpe;
    property FlagFnd    : Boolean   read GetFlagFnd     write SetFlagFnd;
    property FlagIns    : Boolean   read GetFlagIns     write SetFlagIns;
    property FlagUpd    : Boolean   read GetFlagUpd     write SetFlagUpd;
    property FlagDel    : Boolean   read GetFlagDel     write SetFlagDel;
    property FlagBrw    : Boolean   read GetFlagBrw     write SetFlagBrw;
    property FlagLSen   : Boolean   read GetFlagLSen    write SetFlagLSen;
  public
    { Public declarations }
    property ActvOper: string read FActvOper write SetActvOper;
    property drAccess: TDataRow read FdrAccess write SetdrAccess;
  end;

var
  CdAcessos: TCdAcessos;

implementation

{$R *.dfm}

uses Sobre, Dado, ManArqSql, FuncoesDB, mSysMan, AltPass, CmmConst, SelEmpr,
  SqlComm, Types;

procedure TCdAcessos.FormCreate(Sender: TObject);
begin
  vtGrid.NodeDataSize       := SizeOf(TGridData);
  vtOperator.NodeDataSize   := SizeOf(TGridData);
  cbTools.Images            := Dados.Image16;
  tbTools.Images            := Dados.Image16;
  vtGrid.Images             := Dados.Image16;
  vtGrid.Header.Images      := Dados.Image16;
  vtOperator.Images         := Dados.Image16;
  vtOperator.Header.Images  := Dados.Image16;
  pmLegend.Images           := Dados.Image16;
  FLastMod                  := nil;
  FActvOper                 := '';
  pgControl.Images          := Dados.Image16;
  Dados.Image16.GetBitmap(05, sbAltPasswd.Glyph);
  Dados.Image16.GetBitmap(24, sbAltPwdDB.Glyph);
  Dados.Image16.GetBitmap(34, sbNew.Glyph);
  Dados.Image16.GetBitmap(28, sbCancel.Glyph);
  Dados.Image16.GetBitmap(33, sbDelete.Glyph);
  Dados.Image16.GetBitmap(36, sbSave.Glyph);
  pgControl.ActivePageIndex := 0;
  ScrState                  := dbmBrowse;
  GetOperatorData;
end;

procedure TCdAcessos.FormActivate(Sender: TObject);
begin
  with Dados.Parametros do
  begin
    Caption   := Application.Title + ' - ' + soProgramTitle;
    FSecLevel := soUserOperation;
  end;
end;

procedure TCdAcessos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (FScrState in UPDATE_MODE) then
    if Dados.DisplayMessage('CdAcessos: Há Alterações na Tela. Deseja ' +
         'Abandonar as Alterações?', hiQuestion, [mbYes, mbNo]) = mrNo then
      Action := caNone;
end;

procedure TCdAcessos.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtOperator);
  ReleaseTreeNodes(vtGrid);
end;

procedure TCdAcessos.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then Close;
end;

procedure TCdAcessos.GetOperatorData;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtOperator);
  with dmSysMan do
  begin
    if Operador.Active then Operador.Close;
    Operador.SQL.Clear;
    Operador.SQL.Add(SqlOperators);
    if not Operador.Active then Operador.Open;
    vtOperator.BeginUpdate;
    try
      Operador.First;
      while not Operador.Eof do
      begin
        Node          := vtOperator.AddChild(nil);
        Data          := vtOperator.GetNodeData(Node);
        Data^.Level   := 0;
        Data^.Node    := Node;
        Data^.DataRow := TDataRow.CreateFromDataSet(nil, Operador, True);
        Operador.Next;
      end;
    finally
      vtOperator.EndUpdate;
      Operador.Close;
    end;
  end;
  if vtOperator.RootNodeCount = 0 then exit;
  Node                      := vtOperator.GetFirst;
  vtOperator.FocusedNode    := Node;
  vtOperator.Selected[Node] := True;
end;

procedure TCdAcessos.GetProgramsData;
var
  aMod, aRot: string;
  NodeLevel0,
  NodeLevel1: PVirtualNode;
  Data: PGridData;
  function  AddData(Node: PVirtualNode): PVirtualNode;
  begin
    Result        := vtGrid.AddChild(Node);
    Data          := vtGrid.GetNodeData(Result);
    Data^.Level   := vtGrid.GetNodeLevel(Result);
    Data^.Node    := Result;
    Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysMan.Acesso, True);
  end;
begin
  if FActvOper = '' then exit;
  ReleaseTreeNodes(vtGrid);
  aMod := '';
  aRot := '';
  NodeLevel0 := nil;
  NodeLevel1 := nil;
  with dmSysMan do
  begin
    if Acesso.Active then Acesso.Close;
    Acesso.SQL.Clear;
    Acesso.SQL.Add(SqlAcessos);
    Acesso.SQL.Add(SqlAcessosWhr);
    if Acesso.Params.FindParam('FkOperadores') <> nil then
      Acesso.ParamByName('FkOperadores').AsString := FActvOper;
    if Acesso.Params.FindParam('FkLinguagens') <> nil then
      Acesso.ParamByName('FkLinguagens').AsString := LANGUAGE;
    if not Acesso.Active then Acesso.Open;
    vtGrid.BeginUpdate;
    try
      Acesso.First;
      while not Acesso.Eof do
      begin
        if aMod <> Acesso.FieldByName('DSC_MOD').AsString then
        begin
          NodeLevel0    := AddData(nil);
          aMod          := Acesso.FieldByName('DSC_MOD').AsString;
          aRot          := '';
          FLastMod      := NodeLevel0;
        end;
        if (aRot <> Acesso.FieldByName('DSC_ROT').AsString) and
           (NodeLevel0 <> nil) then
        begin
          NodeLevel1    := AddData(NodeLevel0);
          aRot         := Acesso.FieldByName('DSC_ROT').AsString;
        end;
        if (NodeLevel1 <> nil) and
           (Acesso.FieldByName('PK_PROGRAMAS').AsInteger > 0) then
          AddData(NodeLevel1);
        Acesso.Next;
      end;
    finally
      vtGrid.EndUpdate;
      Acesso.Close;
    end;
  end;
  vtGrid.Header.MainColumn := 6;
  if VtGrid.RootNodeCount = 0 then exit;
  NodeLevel0                  := vtGrid.GetFirst;
  while vtGrid.GetNodeLevel(NodeLevel0) < 2 do
    NodeLevel0                := vtGrid.GetNext(NodeLevel0);
  vtGrid.FocusedNode          := NodeLevel0;
  vtGrid.Selected[NodeLevel0] := True;
end;

procedure TCdAcessos.vtGridGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := vtGrid.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := ' ';
  if Column = 6 then
  begin
    case vtGrid.GetNodeLevel(Node) of
      0: CellText := Data^.DataRow.FieldByName['DSC_MOD'].AsString;
      1: CellText := Data^.DataRow.FieldByName['DSC_ROT'].AsString;
      2: CellText := Data^.DataRow.FieldByName['DSC_PRG'].AsString;
    end;
  end;
end;

procedure TCdAcessos.vtGridGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PGridData;
begin
  if (Node = nil) or (Column <> 6) or (Kind in [ikOverlay, ikState]) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Ghosted := False;
  case Sender.GetNodeLevel(Node) of
    0: Imageindex := 85;
    1: Imageindex := 82;
    2: if (Data^.DataRow.FieldByName['FLAG_REL'].AsInteger = 1) then
         ImageIndex := 6
       else
         Imageindex := 27;
  end;
end;

procedure TCdAcessos.vtGridFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  if (OldNode = nil) or (NewNode = nil) then exit;
  if vtGrid.Expanded[OldNode] then
    vtGrid.FullCollapse(OldNode);
  if not vtGrid.Expanded[NewNode] then
    vtGrid.FullExpand(NewNode);
end;

procedure TCdAcessos.vtGridFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  PrgNode: PVirtualNode;
  ModNode: PVirtualNode;
  AuxNode: PVirtualNode;
  Data   : PGridData;
begin
  PrgNode := nil;
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data <> nil) and (Data^.DataRow <> nil) then
    drAccess   := Data^.DataRow;
  ModNode := Node;
  AuxNode := Node;
  while ((vtGrid.GetNodeLevel(ModNode) <> 0) and (ModNode <> nil)) do
    ModNode := vtGrid.GetPrevious(ModNode);
  while (vtGrid.GetNodeLevel(AuxNode) <> 0) and (AuxNode <> nil) do
  begin
    if vtGrid.GetNodeLevel(AuxNode) = 2 then
      PrgNode := AuxNode;
    AuxNode := vtGrid.GetPrevious(AuxNode);
  end;
  tbPriorMod.Enabled := (ModNode <> nil) and (ModNode <> vtGrid.GetFirst);
  tbPriorPrg.Enabled := (PrgNode <> nil) and (PrgNode <> Node) or (tbPriorMod.Enabled);
  AuxNode := Node;
  while (vtGrid.GetNodeLevel(AuxNode) <> 0) and (AuxNode <> nil)  do
  begin
    if vtGrid.GetNodeLevel(AuxNode) = 2 then
      PrgNode := AuxNode;
    AuxNode := vtGrid.GetNext(AuxNode);
  end;
  tbNextMod.Enabled  := (ModNode <> nil) and (ModNode <> FLastMod );
  tbNextPrg.Enabled  := (PrgNode <> nil) and (Node <> vtGrid.GetLast);
end;

procedure TCdAcessos.SetdrAccess(AValue: TDataRow);
begin
  FdrAccess := AValue;
  FKey.Module := FdrAccess.FieldByName['PK_MODULOS'].AsInteger;
  FKey.Rotine := FdrAccess.FieldByName['PK_ROTINAS'].AsInteger;
  FKey.Progrm := FdrAccess.FieldByName['PK_PROGRAMAS'].AsInteger;
  FKey.Access := FdrAccess.FieldByName['PK_ACESSOS'].AsInteger;
end;

procedure TCdAcessos.tbPriorModClick(Sender: TObject);
var
  ModNode,
  Node   : PVirtualNode;
begin
  Node := vtGrid.FocusedNode;
  if Node = nil then exit;
  ModNode := Node;
  while ((vtGrid.GetNodeLevel(Node) <> 0) and (Node <> nil)) or
        (ModNode = Node) do
    Node := vtGrid.GetPrevious(Node);
  if Node = nil then exit;
  ModNode := Node;
  vtGrid.FocusedNode       := ModNode;
  vtGrid.Selected[ModNode] := True;
end;

procedure TCdAcessos.tbPriorPrgClick(Sender: TObject);
var
  PrgNode,
  Node   : PVirtualNode;
begin
  Node := vtGrid.FocusedNode;
  if (Node = nil) then exit;
  PrgNode := Node;
  while ((vtGrid.GetNodeLevel(Node) <> 2) and (Node <> nil)) or
        (PrgNode = Node) do
    Node := vtGrid.GetPrevious(Node);
  if PrgNode = nil then exit;
  PrgNode := Node;
  vtGrid.FocusedNode       := PrgNode;
  vtGrid.Selected[PrgNode] := True;
end;

procedure TCdAcessos.tbNextPrgClick(Sender: TObject);
var
  PrgNode,
  Node   : PVirtualNode;
begin
  Node    := vtGrid.FocusedNode;
  if Node = nil then exit;
  PrgNode := Node;
  while ((vtGrid.GetNodeLevel(Node) <> 2) and (Node <> nil)) or
        (PrgNode = Node) do
     Node := vtGrid.GetNext(Node);
  if Node = nil then exit;
  PrgNode                  := Node;
  vtGrid.FocusedNode       := PrgNode;
  vtGrid.Selected[PrgNode] := True;
end;

procedure TCdAcessos.tbNextModClick(Sender: TObject);
var
  ModNode,
  Node   : PVirtualNode;
begin
  Node := vtGrid.FocusedNode;
  if Node = nil then exit;
  ModNode := Node;
  while ((vtGrid.GetNodeLevel(Node) <> 0) and (Node <> nil)) or
        (ModNode = Node) do
    Node := vtGrid.GetNext(Node);
  if Node = nil then exit;
  ModNode := Node;
  vtGrid.FocusedNode       := ModNode;
  vtGrid.Selected[ModNode] := True;
end;

procedure TCdAcessos.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCdAcessos.tbAboutClick(Sender: TObject);
begin
  Application.CreateForm(TfrmAboutProcessa, frmAboutProcessa);
  try
    frmAboutProcessa.ShowModal;
  finally
    frmAboutProcessa.Free;
  end;
end;

procedure TCdAcessos.DeleteRecord;
begin
  with dmSysMan do
  begin
    Dados.StartTransaction(Acesso);
    if Acesso.Active then Acesso.Close;
    Acesso.SQL.Clear;
    Acesso.SQL.Add(SqlDeleteAcessos);
    if Acesso.Params.FindParam('FkOperadores') <> nil then
      Acesso.ParamByName('FkOperadores').AsString := FActvOper;
    if Acesso.Params.FindParam('PkAcessos') <> nil then
      Acesso.ParamByName('PkAcessos').AsInteger   := FKey.Access;
    try
      Acesso.ExecSQL;
      Dados.CommitTransaction(Acesso);
    except on E:Exception do
      begin
        Dados.RollbackTransaction(Acesso);
        raise Exception.CreateFmt('CdProgramas Post: Erro na Exclusao do Registro. (%s)',
          [E.Message]);
      end;
    end;
  end;
end;

function  TCdAcessos.SaveAllData(AMode: TDBMode): Boolean;
begin
  Result := False;
  if (not (AMode in [dbmInsert, dbmEdit])) or (FdrAccess = nil) then exit;
  with dmSysMan do
  begin
    // Save Program Data
    if Acesso.Active then Acesso.Close;
    Acesso.SQL.Clear;
    if AMode = dbmInsert then
      Acesso.SQL.Add(SqlInsertAcessos);
    if AMode = dbmEdit then
      Acesso.SQL.Add(SqlUpdateAcessos);
    Dados.StartTransaction(Acesso);
    try
      if Acesso.Params.FindParam('FkOperadores') <> nil then
        Acesso.ParamByName('FkOperadores').AsString := FActvOper;
      if Acesso.Params.FindParam('PkAcessos') <> nil then
      begin
        if (AMode = dbmEdit) then
          Acesso.ParamByName('PkAcessos').AsInteger   := FKey.Access;
        if (AMode = dbmInsert) then
          Acesso.ParamByName('PkAcessos').AsInteger   := 0;
      end;
      if Acesso.Params.FindParam('FkModulos') <> nil then
        Acesso.ParamByName('FkModulos').AsInteger   := FKey.Module;
      if Acesso.Params.FindParam('FkRotinas') <> nil then
        Acesso.ParamByName('FkRotinas').AsInteger   := FKey.Rotine;
      if Acesso.Params.FindParam('FkProgramas') <> nil then
        Acesso.ParamByName('FkProgramas').AsInteger := FKey.Progrm;
      if Acesso.Params.FindParam('FlagBrw') <> nil then
        Acesso.ParamByName('FlagBrw').AsInteger     :=
          FdrAccess.FieldByName['FLAG_BRW'].AsInteger;
      if Acesso.Params.FindParam('FlagFnd') <> nil then
        Acesso.ParamByName('FlagFnd').AsInteger     :=
          FdrAccess.FieldByName['FLAG_FND'].AsInteger;
      if Acesso.Params.FindParam('FlagIns') <> nil then
        Acesso.ParamByName('FlagIns').AsInteger     :=
          FdrAccess.FieldByName['FLAG_INS'].AsInteger;
      if Acesso.Params.FindParam('FlagUpd') <> nil then
        Acesso.ParamByName('FlagUpd').AsInteger     :=
          FdrAccess.FieldByName['FLAG_UPD'].AsInteger;
      if Acesso.Params.FindParam('FlagDel') <> nil then
        Acesso.ParamByName('FlagDel').AsInteger     :=
          FdrAccess.FieldByName['FLAG_DEL'].AsInteger;
      if Acesso.Params.FindParam('FlagVis') <> nil then
       Acesso.ParamByName('FlagVis').AsInteger :=
          FdrAccess.FieldByName['FLAG_VIS'].AsInteger;
      Acesso.ExecSQL;
      Dados.CommitTransaction(Acesso);
    except on E:Exception do
      begin
        Dados.RollbackTransaction(Acesso);
        raise Exception.CreateFmt('CdProgramas Post: Erro na Gravação do Registro. (%s)',
          [E.Message]);
      end;
    end;
  end;
end;

procedure TCdAcessos.vtOperatorGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['PK_OPERADORES'].AsString;
end;

procedure TCdAcessos.vtOperatorFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ActvOper := Data^.DataRow.FieldByName['PK_OPERADORES'].AsString;
  FFlags.FlagVis := True;
  FFlags.FlagBrw := Boolean(Data^.DataRow.FieldByName['FLAG_BRW'].AsInteger);
  FFlags.FlagIns := Boolean(Data^.DataRow.FieldByName['FLAG_INS'].AsInteger);
  FFlags.FlagDel := Boolean(Data^.DataRow.FieldByName['FLAG_DEL'].AsInteger);
  FFlags.FlagFnd := Boolean(Data^.DataRow.FieldByName['FLAG_FND'].AsInteger);
  FFlags.FlagUpd := Boolean(Data^.DataRow.FieldByName['FLAG_UPD'].AsInteger);
  MoveDataToControls;
end;

procedure TCdAcessos.SetActvOper(AValue: string);
begin
  if (FActvOper <> AValue) then
  begin
    FActvOper := AValue;
    GetProgramsData;
  end;
end;

procedure TCdAcessos.vtGridInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  if Sender.GetNodeLevel(Node) = 2 then
    Node.CheckType := ctCheckBox;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['PK_ACESSOS'].AsInteger > 0) then
    Node.CheckState := csCheckedNormal
  else
    Node.CheckState := csUnCheckedNormal;
end;

procedure TCdAcessos.vtGridChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if (Node = nil) or (FdrAccess = nil) then exit;
  Sender.FocusedNode := Node;
  Sender.Selected[Node] := True;
  if (Node.CheckState = csUnCheckedNormal) then
  begin
    FdrAccess.FieldByName['FLAG_VIS'].AsInteger := 0;
    FdrAccess.FieldByName['FLAG_FND'].AsInteger := 0;
    FdrAccess.FieldByName['FLAG_BRW'].AsInteger := 0;
    FdrAccess.FieldByName['FLAG_INS'].AsInteger := 0;
    FdrAccess.FieldByName['FLAG_UPD'].AsInteger := 0;
    FdrAccess.FieldByName['FLAG_DEL'].AsInteger := 0;
    DeleteRecord
  end
  else
  begin
    FdrAccess.FieldByName['FLAG_VIS'].AsInteger := Integer(FFlags.FlagVis);
    FdrAccess.FieldByName['FLAG_FND'].AsInteger := Integer(FFlags.FlagFnd);
    FdrAccess.FieldByName['FLAG_BRW'].AsInteger := Integer(FFlags.FlagBrw);
    FdrAccess.FieldByName['FLAG_INS'].AsInteger := Integer(FFlags.FlagIns);
    FdrAccess.FieldByName['FLAG_UPD'].AsInteger := Integer(FFlags.FlagUpd);
    FdrAccess.FieldByName['FLAG_DEL'].AsInteger := Integer(FFlags.FlagDel);
    SaveAllData(dbmInsert);
  end;
  Sender.Repaint;
  SetdrAccess(FdrAccess);
end;

procedure TCdAcessos.vtGridBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  Data: PGridData;
  FieldName: string;
begin
  if (Node = nil) or (Column = 6) or (Sender.GetNodeLevel(Node) < 2) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Column of
    0: FieldName := 'FLAG_VIS';
    1: FieldName := 'FLAG_FND';
    2: FieldName := 'FLAG_BRW';
    3: FieldName := 'FLAG_INS';
    4: FieldName := 'FLAG_UPD';
    5: FieldName := 'FLAG_DEL';
  end;
  Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 63);
  if (Data^.DataRow.FieldByName[FieldName].AsInteger = 1) then
    Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 83);
end;

procedure TCdAcessos.vtOperatorGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if (Node = nil) or (Kind in [ikState, ikOverlay]) then exit;
  ImageIndex := 84;
end;

procedure TCdAcessos.sbAltPasswdClick(Sender: TObject);
var
  aDB: Boolean;
begin
  aDB := (Sender = sbAltPwdDB);
  Application.CreateForm(TAltPassword, AltPassword);
  try
    AltPassword.lActPass.Enabled := (not aDB);
    AltPassword.eActPass.Enabled := (not aDB);
    if (AltPassword.ShowModal = mrOk) then
      EncryptPasswd(AltPassword.NewPassword, AltPassword.ActualPassword, aDB);
    lFlag_LSen.Enabled := (not aDB);
  finally
    AltPassword.Free;
  end;
end;

function TCdAcessos.EncryptPasswd(const New, Actual: string; const SaveDB: Boolean): Boolean;
var
  PwdAux: string;
begin
  Result := True;
  if (not SaveDB) then
  begin
    if Actual <> '' then
    begin
      Crypto.Input  := Actual;
      Crypto.Key    := Actual;
      Crypto.Action := atCrypto;
      Crypto.TypeCipher := tcUnix;
      Crypto.Execute;
    end;
    PwdAux := FOperatorPwd;
    if (PwdAux <> '') and (PwdAux <> Crypto.Output) and (PwdAux <> Actual) then
    begin
      Dados.DisplayMessage(Dados.GetStringMessage(LANGUAGE, 'sInvalidPasswd',
          'Erro: Senha Atual inválida'), hiError);
      Result := False;
    end;
    if New <> '' then
    begin
      Crypto.Input      := New;
      Crypto.Key        := New;
      Crypto.Action     := atCrypto;
      Crypto.TypeCipher := tcInterbase;
      Crypto.Execute;
      PwdAux := Crypto.Output;
    end
    else
      PwdAux := New;
  end;
  if (SaveDB) then
    FDataBasePwd := New
  else
    FOperatorPwd := PwdAux;
  if (FScrState in SCROLL_MODE) then
    FScrState := dbmEdit;
end;

procedure TCdAcessos.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  with StatusBar.Canvas do
  begin
    Font.Style := [FsBold];
    if Panel.Index = 1 then
    begin
        Brush.Color := Self.Color;
        FRect := Rect;
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

procedure TCdAcessos.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    SelEmpresa.Free;
  end;
  sbStatus.Canvas.TextOut(FRect.Left + 22, FRect.Top + 1, ' Empresa: ' +
    InsereZer(IntToStr(Dados.PkCompany), 3) + '/' + Dados.NameCompany);
end;

procedure TCdAcessos.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (Y >= FRect.TopLeft.Y) and
                   (Y <= (FRect.TopLeft.Y + 22));
end;

procedure TCdAcessos.ClearControls;
var
  aState: TDBMode;
begin
  aState      := FScrState;
  FScrState   := dbmFind;
  PkOperator  := '';
  OperatorPwd := '';
  DataBasePwd := '';
  DsctMax     := 0;
  FkLanguage  := nil;
  FkOwner     := 0;
  eEmailOpe   := '';
  FlagFnd     := True;
  FlagIns     := True;
  FlagUpd     := False;
  FlagDel     := False;
  FlagBrw     := True;
  FlagLSen    := False;
  FScrState   := aState;
end;

function TCdAcessos.GetDsctMax: Double;
begin
  Result := eDsct_Max.Value;
end;

function TCdAcessos.GeteEmailOpe: string;
begin
  Result := eEmail_Ope.Text;
end;

function TCdAcessos.GetFkLanguage: TLanguage;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Linguagens.ItemIndex;
  if (aIdx > -1) and (eFk_Linguagens.Items.Objects[aIdx] <> nil) then
    Result := TLanguage(eFk_Linguagens.Items.Objects[aIdx]);
end;

function TCdAcessos.GetFkOwner: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Cadastros.ItemIndex;
  if (aIdx > -1) and (eFk_Cadastros.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Cadastros.Items.Objects[aIdx]);
end;

function TCdAcessos.GetFlagBrw: Boolean;
begin
  Result := lFlag_Brw.Checked;
end;

function TCdAcessos.GetFlagDel: Boolean;
begin
  Result := lFlag_Del.Checked;
end;

function TCdAcessos.GetFlagFnd: Boolean;
begin
  Result := lFlag_Fnd.Checked;
end;

function TCdAcessos.GetFlagIns: Boolean;
begin
  Result := lFlag_Ins.Checked;
end;

function TCdAcessos.GetFlagUpd: Boolean;
begin
  Result := lFlag_Upd.Checked;
end;

function TCdAcessos.GetOperator: TOperator;
var
  AMode: TDBMode;
begin
  AMode        := FScrState;
  FScrState    := dbmFind;
  Result      := dmSysMan.GetOperator(FActvOper);
  if (Result <> nil) then
  begin
    PkOperator   := Result.PkOperator;
    DsctMax      := Result.DsctMax;
    FkLanguage   := Result.FkLanguage;
    FkOwner      := Result.FkOwner;
    eEmailOpe    := Result.eMailOpe;
    FlagFnd      := Result.FlagFnd;
    FlagIns      := Result.FlagIns;
    FlagUpd      := Result.FlagUpd;
    FlagDel      := Result.FlagDel;
    FlagBrw      := Result.FlagBrw;
    FlagLSen     := Result.FlagLSen;
    FOperatorPwd := Result.SenNet;
  end;
  FScrState    := AMode;
end;

function TCdAcessos.GetPkOperator: string;
begin
  Result := ePk_Operadores.Text;
end;

procedure TCdAcessos.MoveDataToControls;
begin
  GetOperator;
end;

procedure TCdAcessos.SaveIntoDB;
begin
  if (FScrState in UPDATE_MODE) then
    SetOperator(TOperator.Create);
  ScrState := dbmBrowse;
end;

procedure TCdAcessos.SetDataBasePwd(const Value: string);
begin
  FDataBasePwd := Value;
end;

procedure TCdAcessos.SetDsctMax(const Value: Double);
begin
  eDsct_Max.Value := Value;
end;

procedure TCdAcessos.SeteEmailOpe(const Value: string);
begin
  eEmail_Ope.Text := Value;
end;

procedure TCdAcessos.SetFkLanguage(const Value: TLanguage);
begin
  eFk_Linguagens.ItemIndex := -1;
  if (Value <> nil) then
    eFk_Linguagens.SetIndexFromObjectValue(Value.PkLanguage);
end;

procedure TCdAcessos.SetFkOwner(const Value: Integer);
begin
  eFk_Cadastros.SetIndexFromIntegerValue(Value);
end;

procedure TCdAcessos.SetFlagBrw(const Value: Boolean);
begin
  lFlag_Brw.Checked := Value;
end;

procedure TCdAcessos.SetFlagDel(const Value: Boolean);
begin
  lFlag_Del.Checked := Value;
end;

procedure TCdAcessos.SetFlagFnd(const Value: Boolean);
begin
  lFlag_Fnd.Checked := Value;
end;

procedure TCdAcessos.SetFlagIns(const Value: Boolean);
begin
  lFlag_Ins.Checked := Value;
end;

procedure TCdAcessos.SetFlagUpd(const Value: Boolean);
begin
  lFlag_Upd.Checked := Value;
end;

procedure TCdAcessos.SetOperator(const Value: TOperator);
begin
  Value.PkOperator := PkOperator;
  Value.DsctMax    := DsctMax;
  Value.FkLanguage := FkLanguage;
  Value.FkOwner    := FkOwner;
  Value.eMailOpe   := eEmailOpe;
  Value.FlagFnd    := FlagFnd;
  Value.FlagIns    := FlagIns;
  Value.FlagUpd    := FlagUpd;
  Value.FlagDel    := FlagDel;
  Value.FlagBrw    := FlagBrw;
  Value.FlagLSen   := FlagLSen;
  Value.SenNet     := FOperatorPwd;
  dmSysMan.SaveOperator(Value, FDataBasePwd, FActvOper, FScrState);
end;

procedure TCdAcessos.SetOperatorPwd(const Value: string);
begin
  FOperatorPwd := Value;
end;

procedure TCdAcessos.SetPkOperator(const Value: string);
begin
  ePk_Operadores.Text := Value;
end;

procedure TCdAcessos.SetScrState(const Value: TDBMode);
begin
  FScrState := Value;
  sbCancel.Enabled := (FScrState in UPDATE_MODE);
  sbDelete.Enabled := (FScrState in SCROLL_MODE);
  sbSave.Enabled   := (FScrState in UPDATE_MODE);
  sbStatus.Repaint;
end;

function TCdAcessos.GetFlagLSen: Boolean;
begin
  Result := lFlag_LSen.Checked;
end;

procedure TCdAcessos.SetFlagLSen(const Value: Boolean);
begin
  lFlag_LSen.Checked := Value;
end;

procedure TCdAcessos.sbNewClick(Sender: TObject);
begin
  ClearControls;
  ScrState := dbmInsert;
end;

procedure TCdAcessos.sbCancelClick(Sender: TObject);
begin
  ScrState := dbmBrowse;
  GetOperator;
end;

procedure TCdAcessos.sbDeleteClick(Sender: TObject);
begin
  if (FActvOper <> '') and (Dados.DisplayMessage('Deseja realmente excluir este ' +
    'registro?', hiQuestion, [mbYes, mbNo]) = mrYes) then
  begin
    ScrState := dbmDelete;
    SaveIntoDB;
    GetOperatorData;
  end;
end;

procedure TCdAcessos.sbSaveClick(Sender: TObject);
begin
  if (FScrState in UPDATE_MODE) then
  begin
    if (FDataBasePwd = '') and (FScrState = dbmInsert) then
      if (Dados.DisplayMessage('A senha de acesso ao Banco de dados não foi ' +
          'informada. Deseja Informar agora? ' + NL + 'Obs: Se a senha de acesso ' +
          'não for informada o sistema atribuirá a senha padrão (Processa).',
          hiInformation, [mbYes, mbNo]) = mrYes) then
        sbAltPasswdClick(sbAltPwdDB)
      else
        FDataBasePwd := 'Processa';
    SaveIntoDB;
    GetOperatorData;
  end;
end;

procedure TCdAcessos.ChangeGlobal(Sender: TObject);
begin
  if (FScrState in SCROLL_MODE) and (not (FScrState in LOADING_MODE)) then
    if (FActvOper = '') then
      ScrState := dbmInsert
    else
      ScrState := dbmEdit;
end;

procedure TCdAcessos.pgControlChange(Sender: TObject);
begin
  if (pgControl.ActivePageIndex = 1) then
  begin
    if (eFk_Linguagens.Items.Count = 0) then
      eFk_Linguagens.Items.AddStrings(dmSysMan.LoadLanguage);
    if (eFk_Cadastros.Items.Count = 0) then
      eFk_Cadastros.Items.AddStrings(dmSysMan.LoadOwners(SqlFuncionarios));
  end;
  tbLegend.Enabled := (pgControl.ActivePageIndex = 0);
end;

procedure TCdAcessos.pmShowDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
var
  BmpRect: TRect;
  aBmp   : TBitmap;
begin
  if (Sender is TMenuItem) then
  begin
    ACanvas.Font.Style  := [fsBold];
    ACanvas.Font.Color  := clBlue;
    BmpRect             := ARect;
    BmpRect.Right       := 18;
    ACanvas.Brush.Color := clWhite;
    ACanvas.FillRect(BmpRect);
    BmpRect.Left        := BmpRect.Left + 18;
    BmpRect.Right       := BmpRect.Left + 2;
    ACanvas.Brush.Color := clGray;
    ACanvas.FillRect(BmpRect);
    case TMenuItem(Sender).ImageIndex of
      07: ACanvas.Brush.Color := clSkyBlue;
      90: ACanvas.Brush.Color := clMoneyGreen;
      23: ACanvas.Brush.Color := cl3DLight;
      34: ACanvas.Brush.Color := clInfoBk;
      81: ACanvas.Brush.Color := clCream;
      33: ACanvas.Brush.Color := clSilver;
    end;
    aBmp := TBitmap.Create;
    try
      Dados.Image16.GetBitmap(TMenuItem(Sender).ImageIndex, aBmp);
      ACanvas.Draw(ARect.Left, ARect.Top + 2, aBmp);
      ARect.Left := ARect.Left + 20;
      ACanvas.FillRect(ARect);
      ACanvas.TextOut(ARect.Left + 2, ARect.Top, TMenuItem(Sender).Caption);
    finally
      FreeAndNil(aBmp)
    end;
  end;
end;

procedure TCdAcessos.eFk_CadastrosSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  sbAltPasswd.Enabled := (eFk_Cadastros.ItemIndex > -1) and
                         (eFk_Cadastros.Items.Objects[eFk_Cadastros.ItemIndex] <> nil);
end;

procedure TCdAcessos.vtGridColumnClick(Sender: TBaseVirtualTree;
  Column: TColumnIndex; Shift: TShiftState);
var
  Node       : PVirtualNode;
  Data       : PGridData;
begin
  Node := Sender.FocusedNode;
  if (Node = nil) or (Column = 6) then exit;
  if (Node.CheckState = csUncheckedNormal) then exit;
  Node := Sender.FocusedNode;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Column of
    0: if (Data^.DataRow.FieldByName['FLAG_VIS'].AsInteger = 0) then
         Data^.DataRow.FieldByName['FLAG_VIS'].AsInteger := 1
       else
         Data^.DataRow.FieldByName['FLAG_VIS'].AsInteger := 0;
    1: if (Data^.DataRow.FieldByName['FLAG_FND'].AsInteger = 0) then
         Data^.DataRow.FieldByName['FLAG_FND'].AsInteger := 1
       else
         Data^.DataRow.FieldByName['FLAG_FND'].AsInteger := 0;
    2: if (Data^.DataRow.FieldByName['FLAG_BRW'].AsInteger = 0) then
         Data^.DataRow.FieldByName['FLAG_BRW'].AsInteger := 1
       else
         Data^.DataRow.FieldByName['FLAG_BRW'].AsInteger := 0;
    3: if (Data^.DataRow.FieldByName['FLAG_INS'].AsInteger = 0) then
         Data^.DataRow.FieldByName['FLAG_INS'].AsInteger := 1
       else
         Data^.DataRow.FieldByName['FLAG_INS'].AsInteger := 0;
    4: if (Data^.DataRow.FieldByName['FLAG_UPD'].AsInteger = 0) then
         Data^.DataRow.FieldByName['FLAG_UPD'].AsInteger := 1
       else
         Data^.DataRow.FieldByName['FLAG_UPD'].AsInteger := 0;
    5: if (Data^.DataRow.FieldByName['FLAG_DEL'].AsInteger = 0) then
         Data^.DataRow.FieldByName['FLAG_DEL'].AsInteger := 1
       else
         Data^.DataRow.FieldByName['FLAG_DEL'].AsInteger := 0;
  end;
  Sender.Refresh;
  SaveAllData(dbmEdit);
end;

initialization
  Classes.RegisterClass(TCdAcessos);

end.
