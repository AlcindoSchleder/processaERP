unit CadOpFin;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
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
  Dialogs, VirtualTrees, ExtCtrls, ComCtrls, ToolWin, StdCtrls, Mask,
  ToolEdit, CurrEdit, TSysBcCx, PrcCombo, Buttons, ProcUtils, ProcType;

type
  TCdOperFin = class(TForm)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    tbSepTools: TToolButton;
    tbSave: TToolButton;
    tbSepFile: TToolButton;
    tbClose: TToolButton;
    vtOperations: TVirtualStringTree;
    sbStatus: TStatusBar;
    lPk_Operacoes_Financeiras: TStaticText;
    ePk_Operacoes_Financeiras: TCurrencyEdit;
    eDsc_Ope: TEdit;
    lDsc_Ope: TStaticText;
    vtDocuments: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChangeGlobal(Sender: TObject);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vtOperationsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtOperationsFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtOperationsFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure tbInsertClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbCloseClick(Sender: TObject);
    procedure lFlag_TrfClick(Sender: TObject);
    procedure lFlag_BaixaClick(Sender: TObject);
    procedure vtDocumentsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtDocumentsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtDocumentsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtDocumentsBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure vtDocumentsColumnClick(Sender: TBaseVirtualTree;
      Column: TColumnIndex; Shift: TShiftState);
    procedure vtDocumentsHotChange(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode);
    procedure vtDocumentsChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
  private
    function GetFkOperationCR: Integer;
    function GetFkOperationDB: Integer;
    procedure SetFkOperationCR(const Value: Integer);
    procedure SetFkOperationDB(const Value: Integer);
  private
    { Private declarations }
    FLoading     : Boolean;
    FScrMode     : TDBMode;
    FListLoaded  : Boolean;
    FCompanyClick: Boolean;
    FRect        : TRect;
    procedure LoadOperations;
    function  GetDscOpe: string;
    function  GetFlagBaixa: Boolean;
    function  GetFlagEst: Boolean;
    function  GetFlagGSld: Boolean;
    function  GetFlagTrf: Boolean;
    function  GetPkOperation: Integer;
    function  GetOperation: TFinanceOperations;
    procedure SetDscOpe(const Value: string);
    procedure SetFlagBaixa(const Value: Boolean);
    procedure SetFlagEst(const Value: Boolean);
    procedure SetFlagGSld(const Value: Boolean);
    procedure SetFlagTrf(const Value: Boolean);
    procedure SetPkOperation(const Value: Integer);
    procedure SetOperation(const Value: TFinanceOperations);
    procedure SetScrMode(const Value: TDBMode);
    procedure LoadDefaults;
    procedure ClearControls;
    procedure DeleteFromDB;
    procedure MoveDataToControls;
    procedure SaveIntoDB;
    procedure LoadDocuments;
    function  CheckRecord: Boolean;
    property  DscOpe       : string             read GetDscOpe        write SetDscOpe;
    property  FkOperationDB: Integer            read GetFkOperationDB write SetFkOperationDB;
    property  FkOperationCR: Integer            read GetFkOperationCR write SetFkOperationCR;
    property  FlagBaixa    : Boolean            read GetFlagBaixa     write SetFlagBaixa;
    property  FlagTrf      : Boolean            read GetFlagTrf       write SetFlagTrf;
    property  FlagEst      : Boolean            read GetFlagEst       write SetFlagEst;
    property  FlagGSld     : Boolean            read GetFlagGSld      write SetFlagGSld;
    property  ListLoaded   : Boolean            read FListLoaded      write FListLoaded;
    property  Loading      : Boolean            read FLoading         write FLoading;
    property  Operation    : TFinanceOperations read GetOperation     write SetOperation;
    property  PkOperation  : Integer            read GetPkOperation   write SetPkOperation;
    property  ScrMode      : TDBMode            read FScrMode         write SetScrMode;
  public
    { Public declarations }
  end;

var
  CdOperFin: TCdOperFin;

resourcestring
  S_MissingDscOpe      = 'Não posso salvar sem a descrição da Operação';
  S_NotFinishDocument  = 'Não posso criar uma operação de transferência de ' +
                         'saldos com baixa de documentos';
  S_WithoutGSld        = 'Não posso criar uma operação de baixa de ' +
                         'documentos sem geração de saldos';
  S_TranferWithoutGSld = 'Não posso criar uma operação de baixa de ' +
                         'documentos sem geração de saldos';
  S_OperWithoutDoc     = 'Operação deve conter vínculo com pelo menos um tipo ' +
                         'de documento';
  S_DocumentWithoutDef = 'Vínculo com documentos deve conter um tipo de ' +
                         'documento marcado como default';
  S_DocumentManyDef    = 'Vínculo com documentos não pode conter mais de um ' +
                         'tipo de documento marcado como default';
  S_MissingOperation   = 'Falta preencher a Operação Financeira';

implementation

uses Dado, mSysBcCx, FuncoesDB, GridRow, ArqSqlBcCx, SelEmpr, DB;

{$R *.dfm}

procedure TCdOperFin.FormCreate(Sender: TObject);
begin
  vtOperations.NodeDataSize  := SizeOf(TGridData);
  vtOperations.Images        := Dados.Image16;
  vtOperations.Header.Images := Dados.Image16;
  vtDocuments.NodeDataSize   := SizeOf(TGridData);
  vtDocuments.Images         := Dados.Image16;
  vtDocuments.Header.Images  := Dados.Image16;
  cbTools.Images             := Dados.Image16;
  tbTools.Images             := Dados.Image16;
  Operation                  := nil;
  ScrMode                    := dbmBrowse;
end;

procedure TCdOperFin.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (FScrMode in UPDATE_MODE) then
    CanClose := Application.MessageBox(PanSiChar('Atenção: Há alterações ' +
                  'na tela. Deseja sair mesmo assim?'), PAnsiChar(Application.Title),
                  MB_ICONWARNING + MB_YESNO) = mrYes;
end;

procedure TCdOperFin.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtOperations);
  ReleaseTreeNodes(vtDocuments);
end;

procedure TCdOperFin.FormShow(Sender: TObject);
begin
  LoadDefaults;
end;

procedure TCdOperFin.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
  end;
end;

function TCdOperFin.CheckRecord: Boolean;
var
  aMsg: string;
  aCtr: TControl;
  Node: PVirtualNode;
  Data: PGridData;
  aIdx: Integer;
begin
  Result := True;
  aMsg := '';
  aCtr := Self;
  if (DscOpe = '') then
  begin
    aCtr := eDsc_Ope;
    aMsg := S_MissingDscOpe;
  end;
  if (FlagBaixa and FlagTrf) then
  begin
    aCtr := lFlag_Baixa;
    aMsg := S_NotFinishDocument;
  end;
  if (FlagBaixa) and (not FlagGSld) then
  begin
    aCtr := lFlag_Baixa;
    aMsg := S_WithoutGSld;
  end;
  if (FlagTrf) and (not FlagGSld) then
  begin
    aCtr := lFlag_Trf;
    aMsg := S_TranferWithoutGSld;
    if FkOperationCR = 0 then
    begin
      aCtr := eFk_Operacoes_Financeiras__CR;
      aMsg := S_MissingOperation;
    end;
    if FkOperationDB = 0 then
    begin
      aCtr := eFk_Operacoes_Financeiras__DB;
      aMsg := S_MissingOperation;
    end;
  end;
  if (vtDocuments.RootNodeCount > 0) then
  begin
    aIdx := 0;
    Node := vtDocuments.GetFirst;
    while (Node <> nil) do
    begin
      Data := vtDocuments.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 1) then
      begin
        aCtr := vtDocuments;
        Inc(aIdx);
      end;
      Node := vtDocuments.GetNext(Node);
    end;
    if (aIdx = 0) then
      aMsg := S_DocumentWithoutDef;
    if (aIdx > 1) then
      aMsg := S_DocumentManyDef;
  end
  else
  begin
    aCtr := vtDocuments;
    aMsg := S_OperWithoutDoc;
  end;
  if (aMsg <> '') then
  begin
    Dados.DisplayHint(aCtr, aMsg);
    Result := False;
  end;
end;

procedure TCdOperFin.ClearControls;
begin
  Loading     := True;
  DscOpe      := '';
  FlagBaixa   := False;
  FlagTrf     := False;
  FlagEst     := False;
  FlagGSld    := False;
  PkOperation := 0;
  Loading     := False;
end;

procedure TCdOperFin.ChangeGlobal(Sender: TObject);
begin
  if (Loading) or (FScrMode in UPDATE_MODE) then exit;
  if (FScrMode = dbmBrowse) and (PkOperation = 0) then
    ScrMode := dbmInsert
  else
    ScrMode := dbmEdit;
end;

procedure TCdOperFin.DeleteFromDB;
begin
  SetOperation(TFinanceOperations.Create);
end;

function TCdOperFin.GetDscOpe: string;
begin
  Result := eDsc_Ope.Text;
end;

function TCdOperFin.GetFlagBaixa: Boolean;
begin
  Result := lFlag_Baixa.Checked;
end;

function TCdOperFin.GetFlagEst: Boolean;
begin
  Result := lFlag_Est.Checked;
end;

function TCdOperFin.GetFlagGSld: Boolean;
begin
  Result := lFlag_GSld.Checked;
end;

function TCdOperFin.GetFlagTrf: Boolean;
begin
  Result := lFlag_Trf.Checked;
end;

function TCdOperFin.GetOperation: TFinanceOperations;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result      := TFinanceOperations.Create;
  if (Result = nil) then exit;
  Node        := vtOperations.FocusedNode;
  if (Node = nil) then exit;
  Data        := vtOperations.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Result.DscOpe      := Data^.DataRow.FieldByName['DSC_OPE'].AsString;
  Result.FlagBaixa   := Boolean(Data^.DataRow.FieldByName['FLAG_BAIXA'].AsInteger);
  Result.FlagTrf     := Boolean(Data^.DataRow.FieldByName['FLAG_TRF'].AsInteger);
  Result.FlagEst     := Boolean(Data^.DataRow.FieldByName['FLAG_EST'].AsInteger);
  Result.FlagGSld    := Boolean(Data^.DataRow.FieldByName['FLAG_GSLD'].AsInteger);
  Result.PkOperation := Data^.DataRow.FieldByName['PK_OPERACOES_FINANCEIRAS'].AsInteger;
  Loading     := True;
  DscOpe      := Result.DscOpe;
  FlagBaixa   := Result.FlagBaixa;
  FlagTrf     := Result.FlagTrf;
  FlagEst     := Result.FlagEst;
  FlagGSld    := Result.FlagGSld;
  PkOperation := Result.PkOperation;
  Loading     := False;
end;

function TCdOperFin.GetPkOperation: Integer;
begin
  Result := ePk_Operacoes_Financeiras.AsInteger;
end;

procedure TCdOperFin.LoadDefaults;
begin
  if (not ListLoaded) then
    LoadOperations;
  eFk_Operacoes_Financeiras__DB.Items.AddStrings(dmSysBcCx.LoadTypeOperations);
  eFk_Operacoes_Financeiras__CR.Items.AddStrings(dmSysBcCx.LoadTypeOperations);
end;

procedure TCdOperFin.MoveDataToControls;
begin
  GetOperation;
end;

procedure TCdOperFin.SaveIntoDB;
begin
  SetOperation(TFinanceOperations.Create);
end;

procedure TCdOperFin.SetDscOpe(const Value: string);
begin
  eDsc_Ope.Text := Value;
end;

procedure TCdOperFin.SetFlagBaixa(const Value: Boolean);
begin
  lFlag_Baixa.Checked := Value;
end;

procedure TCdOperFin.SetFlagEst(const Value: Boolean);
begin
  lFlag_Est.Checked := Value;
end;

procedure TCdOperFin.SetFlagGSld(const Value: Boolean);
begin
  lFlag_GSld.Checked := Value;
end;

procedure TCdOperFin.SetFlagTrf(const Value: Boolean);
begin
  lFlag_Trf.Checked := Value;
  if Value then
  begin
    eFk_Operacoes_Financeiras__CR.Enabled := True;
    eFk_Operacoes_Financeiras__DB.Enabled := True;
  end
  else
  begin
    eFk_Operacoes_Financeiras__CR.Enabled := False;
    eFk_Operacoes_Financeiras__DB.Enabled := False;
  end;
end;

procedure TCdOperFin.SetOperation(const Value: TFinanceOperations);
var
  List: TList;
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (Value = nil) then exit;
  Value.DscOpe      := DscOpe;
  Value.FlagBaixa   := FlagBaixa;
  Value.FlagTrf     := FlagTrf;
  Value.FlagEst     := FlagEst;
  Value.FlagGSld    := FlagGSld;
  Value.PkOperation := PkOperation;
  List := TList.Create;
  try
    Node := vtDocuments.GetFirst;
    while (Node <> nil) do
    begin
      Data := vtDocuments.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (Node.CheckState = csCheckedNormal) then
        List.Add(Data^.DataRow);
      Node := vtDocuments.GetNext(Node);
    end;
    dmSysBcCx.SaveFinanceOperation(Value, FScrMode, List);
  finally
    List.Clear;
    List.Free;
  end;
end;

procedure TCdOperFin.SetPkOperation(const Value: Integer);
begin
  ePk_Operacoes_Financeiras.AsInteger := Value;
end;

procedure TCdOperFin.SetScrMode(const Value: TDBMode);
begin
  if (FScrMode <> Value) then
  begin
    case Value of
      dbmInsert: ClearControls;
      dbmDelete: DeleteFromDB;
      dbmPost  : SaveIntoDB;
      dbmCancel: MoveDataToControls;
      dbmBrowse: MoveDataToControls;
    end;
    FScrMode := Value;
  end;
  tbInsert.Enabled  := (not (FScrMode in UPDATE_MODE));
  tbCancel.Enabled  := (FScrMode in UPDATE_MODE);
  tbDelete.Enabled  := ((FScrMode in SCROLL_MODE) and (vtOperations.RootNodeCount > 0));
  tbSave.Enabled    := (FScrMode in UPDATE_MODE);
  sbStatus.Repaint;
end;

procedure TCdOperFin.LoadOperations;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtOperations);
  with dmSysBcCx do
  begin
    if qrFinanceOperation.Active then qrFinanceOperation.Close;
    qrFinanceOperation.SQL.Clear;
    qrFinanceOperation.SQL.Add(SqlAllOperations);
    vtOperations.BeginUpdate;
    try
      if Dados.Conexao.TransactionsSupported then
        Dados.Conexao.StartTransaction(Dados.GetTr(Dados.FTr));
      if (not qrFinanceOperation.Active) then qrFinanceOperation.Open;
      while (not qrFinanceOperation.EOF) do
      begin
        Node := vtOperations.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtOperations.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := vtOperations.GetNodeLevel(Node);
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrFinanceOperation, True);
          end;
        end;
        qrFinanceOperation.Next;
      end;
    finally
      if qrFinanceOperation.Active then qrFinanceOperation.Close;
      if Dados.Conexao.TransactionsSupported then
        Dados.Conexao.Commit(Dados.GetTr(Dados.FTr));
      vtOperations.EndUpdate;
    end;
  end;
  if (vtOperations.RootNodeCount > 0) then
  begin
    vtOperations.FocusedNode := vtOperations.GetFirst;
    vtOperations.Selected[vtOperations.FocusedNode] := True;
  end;
end;

procedure TCdOperFin.sbStatusClick(Sender: TObject);
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
end;

procedure TCdOperFin.sbStatusDrawPanel(StatusBar: TStatusBar;
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
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrMode];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrMode];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrMode]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrMode]);
  end;
end;

procedure TCdOperFin.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TCdOperFin.vtOperationsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Column = 0) then
    CellText := Data^.DataRow.FieldByName['DSC_OPE'].AsString;
end;

procedure TCdOperFin.vtOperationsFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  Allowed := (FScrMode in SCROLL_MODE);
end;

procedure TCdOperFin.vtOperationsFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  GetOperation;
  LoadDocuments;
end;

procedure TCdOperFin.tbInsertClick(Sender: TObject);
begin
  ScrMode := dbmInsert;
  LoadDocuments;
end;

procedure TCdOperFin.tbCancelClick(Sender: TObject);
begin
  ReleaseTreeNodes(vtDocuments);
  ScrMode := dbmCancel;
  ScrMode := dbmBrowse;
end;

procedure TCdOperFin.tbDeleteClick(Sender: TObject);
begin
  ScrMode := dbmDelete;
  ScrMode := dbmBrowse;
  LoadOperations;
end;

procedure TCdOperFin.tbSaveClick(Sender: TObject);
begin
  if CheckRecord then
  begin
    ShowMessage('PostRecord');
    ScrMode := dbmPost;
    ScrMode := dbmBrowse;
    LoadOperations;
  end;
end;

procedure TCdOperFin.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCdOperFin.lFlag_TrfClick(Sender: TObject);
begin
  if FlagTrf then
  begin
    eFk_Operacoes_Financeiras__CR.Enabled := True;
    eFk_Operacoes_Financeiras__DB.Enabled := True;
    FlagGSld := True;
    FlagBaixa := False;
  end
  else
  begin
    eFk_Operacoes_Financeiras__CR.Enabled := False;
    eFk_Operacoes_Financeiras__DB.Enabled := False;
  end;
  ChangeGlobal(Sender);
end;

procedure TCdOperFin.lFlag_BaixaClick(Sender: TObject);
begin
  if FlagBaixa then FlagGSld := True;
  ChangeGlobal(Sender);
end;

procedure TCdOperFin.LoadDocuments;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtDocuments);
  with dmSysBcCx do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlOperDocuments);
    vtDocuments.BeginUpdate;
    try
      if Dados.Conexao.TransactionsSupported then
        Dados.Conexao.StartTransaction(Dados.GetTr(Dados.FTr));
      qrSqlAux.ParamByName('FkOperacoesFinanceiras').AsInteger := PkOperation;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.EOF) do
      begin
        Node := vtDocuments.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtDocuments.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := vtDocuments.GetNodeLevel(Node);
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
          end;
        end;
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      if Dados.Conexao.TransactionsSupported then
        Dados.Conexao.Commit(Dados.GetTr(Dados.FTr));
      vtDocuments.EndUpdate;
    end;
  end;
end;

procedure TCdOperFin.vtDocumentsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['DSC_TDOC'].AsString;
    1: if (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 0) then
         CellText := 'Não'
       else
         CellText := 'Sim';
  end;
end;

procedure TCdOperFin.vtDocumentsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (ssCtrl in Shift) and (Key = VK_DELETE) then
  begin
    Node := vtDocuments.FocusedNode;
    if (Node = nil) then exit;
    Data := vtDocuments.GetNodeData(Node);
    if (Data = nil) then exit;
    if (Data^.DataRow <> nil) then
      Data^.DataRow.Free;
    Data^.DataRow := nil;
    Data^.Node    := nil;
    Data := nil;
    vtDocuments.DeleteNode(Node);
  end;
end;

procedure TCdOperFin.vtDocumentsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Node.CheckType := ctCheckBox;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FK_OPERACOES_FINANCEIRAS'].IsNull) or
     (Data^.DataRow.FieldByName['FK_OPERACOES_FINANCEIRAS'].AsInteger = 0) then
    Node.CheckState := csUnCheckedNormal
  else
    Node.CheckState := csCheckedNormal;
end;

procedure TCdOperFin.vtDocumentsBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  Data: PGridData;
begin
  if (Node = nil) or (Column = 0) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 63);
  if (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 1) then
    Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 83);
end;

procedure TCdOperFin.vtDocumentsColumnClick(Sender: TBaseVirtualTree;
  Column: TColumnIndex; Shift: TShiftState);
var
  CheckedNode: PVirtualNode;
  Node       : PVirtualNode;
  Data       : PGridData;
  aIdx       : Integer;
begin
  Node := Sender.FocusedNode;
  if (Node = nil) or (Column = 0) then exit;
  if (Node.CheckState = csUncheckedNormal) then exit;
  if (vtDocuments.RootNodeCount > 0) then
  begin
    aIdx := 0;
    Node := Sender.GetFirst;
    while (Node <> nil) do
    begin
      Data := Sender.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 1) then
      begin
        Inc(aIdx);
        CheckedNode := Node;
      end;
      Node := Sender.GetNext(Node);
    end;
    if (aIdx = 1) and (CheckedNode <> Sender.FocusedNode) then
    begin
      Dados.DisplayHint(Sender, S_DocumentManyDef);
      exit;
    end;
  end;
  Node := Sender.FocusedNode;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger = 0) then
    Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger := 1
  else
    Data^.DataRow.FieldByName['FLAG_DEF'].AsInteger := 0;
  Sender.Refresh;
end;

procedure TCdOperFin.vtDocumentsHotChange(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode);
begin
  if (NewNode = nil) or (vtDocuments.RootNodeCount = 0) then exit;
  Sender.FocusedNode := NewNode;
  Sender.Selected[NewNode] := True;
end;

procedure TCdOperFin.vtDocumentsChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if (Node = nil) or (vtDocuments.RootNodeCount = 0) then exit;
  Sender.FocusedNode := Node;
  Sender.Selected[Node] := True;
  if (ScrMode in SCROLL_MODE) then
  ScrMode := dbmEdit;
end;

function TCdOperFin.GetFkOperationCR: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Operacoes_Financeiras__CR.ItemIndex;
  if (aIdx > -1) and (eFk_Operacoes_Financeiras__CR.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Operacoes_Financeiras__CR.Items.Objects[aIdx]);
end;

function TCdOperFin.GetFkOperationDB: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Operacoes_Financeiras__DB.ItemIndex;
  if (aIdx > -1) and (eFk_Operacoes_Financeiras__DB.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Operacoes_Financeiras__DB.Items.Objects[aIdx]);
end;

procedure TCdOperFin.SetFkOperationCR(const Value: Integer);
begin
  eFk_Operacoes_Financeiras__CR.SetIndexFromIntegerValue(Value);
end;

procedure TCdOperFin.SetFkOperationDB(const Value: Integer);
begin
  eFk_Operacoes_Financeiras__DB.SetIndexFromIntegerValue(Value);
end;

initialization
  RegisterClass(TCdOperFin);
end.
