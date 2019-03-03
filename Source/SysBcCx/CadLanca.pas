unit CadLanca;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 24/10/2006 - DD/MM/YYYY                                    *}
{* Modified : 24/10/2006 - DD/MM/YYYY                                    *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : (alcindo@sistemaprocessa.com.br)                           *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, VirtualTrees, ToolWin, StdCtrls, PrcCombo,
  Mask, ToolEdit, CurrEdit, ProcUtils, CheckLst, Buttons, DB, ImgList,
  TSysFatAux;

type
  TAccountNats = set of TAccountNat;

  TOperation  = (opEqual, opGreatherThan, opLessThan);
  PFilterData = ^TFilterData;
  TFilterData = packed record
    AccountType: TAccountNats;
    AccountCode: string;
    OperAccCode: TOperation;
    Balance    : Double;
    OperBalance: TOperation;
  end;

  TfrmLancament = class(TForm)
    sbStatus: TStatusBar;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbFilter: TToolButton;
    tbSepSave: TToolButton;
    tbSave: TToolButton;
    tbSepClose: TToolButton;
    tbClose: TToolButton;
    eFkCenariosFinanceiros: TComboBox;
    pAccounts: TPanel;
    vtAccounts: TVirtualStringTree;
    pAccFilter: TPanel;
    Shape1: TShape;
    lTitle: TLabel;
    clAccountFilter: TCheckListBox;
    pAccManage: TPanel;
    pSearch: TPanel;
    eFkGruposMovimentos: TComboBox;
    lFkGruposMovimentos: TStaticText;
    lDtaIni: TStaticText;
    eDtaIni: TDateEdit;
    lDtaFin: TStaticText;
    eDtaFin: TDateEdit;
    lFkCadastros: TStaticText;
    ComboBox1: TComboBox;
    eDOC_PRI: TMaskEdit;
    pgDocuments: TPageControl;
    tsSearchDocs: TTabSheet;
    tsEditDocument: TTabSheet;
    vtDocuments: TVirtualStringTree;
    tbSepFilter: TToolButton;
    lFkCenariosFinanceiros: TLabel;
    CurrencyEdit1: TCurrencyEdit;
    StaticText1: TStaticText;
    StaticText4: TStaticText;
    CurrencyEdit2: TCurrencyEdit;
    ComboBox4: TComboBox;
    StaticText3: TStaticText;
    ComboBox3: TComboBox;
    lDsc_Lan: TStaticText;
    eDsc_Lan: TEdit;
    lDta_Lan: TStaticText;
    eDta_Lan: TDateEdit;
    StaticText7: TStaticText;
    CurrencyEdit5: TCurrencyEdit;
    lFlag_DBCR: TRadioGroup;
    StaticText2: TStaticText;
    ComboBox2: TComboBox;
    pPaymentChooses: TPanel;
    vtFinalizadoras: TVirtualStringTree;
    Shape2: TShape;
    lTotal_Payments: TLabel;
    CurrencyEdit4: TCurrencyEdit;
    Shape3: TShape;
    Label2: TLabel;
    lFk_Classificacao: TStaticText;
    eFk_Classificacao: TComboBox;
    eBalance: TCurrencyEdit;
    lBalance: TStaticText;
    eOperBalance: TComboBox;
    lAccountCode: TStaticText;
    eOperAccCode: TComboBox;
    eAccountCode: TEdit;
    sbFilter: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pgDocumentsChange(Sender: TObject);
    procedure pgDocumentsChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure vtAccountsBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtAccountsFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtAccountsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtAccountsGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure vtAccountsFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtAccountsIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure vtAccountsStateChange(Sender: TBaseVirtualTree; Enter,
      Leave: TVirtualTreeStates);
    procedure clAccountFilterClickCheck(Sender: TObject);
    procedure eFk_ClassificacaoDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure sbFilterClick(Sender: TObject);
  private
    { Private declarations }
    FCompanyClick: Boolean;
    FRect        : TRect;
    FScrState    : TDBMode;
    FSearchCol   : shortint;
    FSearchField : string;
    FSearchText  : string;
    FFilterAcc   : TAccountNats;
    function  GetActivePage: Integer;
    function  GetEndDate: TDate;
    function  GetStartDate: TDate;
    function  AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet): PVirtualNode;
    procedure SetEndDate(const Value: TDate);
    procedure SetStartDate(const Value: TDate);
    procedure SetActivePage(const Value: Integer);
    procedure SetScrState(const Value: TDBMode);
    procedure LoadAccountsList;
    procedure SetFilterAcc(const Value: TAccountNats);
    procedure HideNodes(Sender: TBaseVirtualTree;
                Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
  protected
    { Protected declarations }
    property ActivePage : Integer      read GetActivePage write SetActivePage;
    property ScrState   : TDBMode      read FScrState     write SetScrState;
    property SearchField: string       read FSearchField  write FSearchField;
    property SearchCol  : shortint     read FSearchCol    write FSearchCol default 0;
    property FilterAcc  : TAccountNats read FFilterAcc write SetFilterAcc;
  public
    { Public declarations }
    property StartDate: TDate read GetStartDate write SetStartDate;
    property EndDate  : TDate read GetEndDate   write SetEndDate;
  end;

var
  frmLancament: TfrmLancament;

implementation

uses Dado, FuncoesDB, ProcType, mSysBcCx, ArqSqlBcCx, SelEmpr, GridRow, Math;

{$R *.dfm}

const
  ACCOUNT_COLOR: array [TAccountNat] of TColor =
   (clInfoBk, clMoneyGreen, clSkyBlue, clCream, clWhite);

procedure TfrmLancament.FormCreate(Sender: TObject);
begin
  cbTools.Images            := Dados.Image16;
  tbTools.Images            := Dados.Image16;
  vtAccounts.Images         := Dados.Image16;
  vtAccounts.Header.Images  := Dados.Image16;
  vtAccounts.NodeDataSize   := SizeOf(TGridData);
  vtDocuments.Images        := Dados.Image16;
  vtDocuments.Header.Images := Dados.Image16;
  vtDocuments.NodeDataSize  := SizeOf(TGridData);
  FScrState                 := dbmBrowse;
  ActivePage                := 0;
  LoadAccountsList;
end;

procedure TfrmLancament.FormShow(Sender: TObject);
begin
  Caption := Application.Title + ' - ' + Dados.Parametros.soProgramTitle;
end;

procedure TfrmLancament.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (FScrState in UPDATE_MODE) then
    CanClose := Application.MessageBox(PanSiChar('Atenção: Há alterações ' +
                  'na tela. Deseja sair mesmo assim?'), PAnsiChar(Application.Title),
                  MB_ICONWARNING + MB_YESNO) = mrYes;
end;

procedure TfrmLancament.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtAccounts);
  ReleaseTreeNodes(vtDocuments);
end;

procedure TfrmLancament.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
  end;
end;

function TfrmLancament.GetEndDate: TDate;
begin
  Result := eDtaIni.Date;
end;

function TfrmLancament.GetStartDate: TDate;
begin
  Result := eDtaFin.Date;
end;

procedure TfrmLancament.SetEndDate(const Value: TDate);
begin
  eDtaIni.Date := Value;
end;

procedure TfrmLancament.SetStartDate(const Value: TDate);
begin
  eDtaFin.Date := Value;
end;

procedure TfrmLancament.sbStatusClick(Sender: TObject);
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

procedure TfrmLancament.sbStatusDrawPanel(StatusBar: TStatusBar;
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
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrState];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrState]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
  end;
end;

procedure TfrmLancament.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TfrmLancament.tbCloseClick(Sender: TObject);
begin
  Close;
end;

function TfrmLancament.GetActivePage: Integer;
begin
  Result := pgDocuments.ActivePageIndex;
end;

procedure TfrmLancament.SetActivePage(const Value: Integer);
begin
  pgDocuments.ActivePageIndex := Value;
  SetScrState(FScrState);
end;

procedure TfrmLancament.pgDocumentsChange(Sender: TObject);
begin
  ActivePage := pgDocuments.ActivePageIndex;
end;

procedure TfrmLancament.pgDocumentsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (FScrState in SCROLL_MODE);
end;

procedure TfrmLancament.SetScrState(const Value: TDBMode);
begin
  FScrState := Value;
  tbInsert.Enabled := (Value in SCROLL_MODE);
  tbSave.Enabled   := (ActivePage > 0) and (Value in UPDATE_MODE);
  tbCancel.Enabled := (ActivePage > 0) and (Value in UPDATE_MODE);
  tbFilter.Enabled := (ActivePage = 0);
end;

function TfrmLancament.AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet): PVirtualNode;
var
  Data: PGridData;
begin
  Result := vtAccounts.AddChild(ANode);
  if (Result <> nil) then
  begin
    Data := vtAccounts.GetNodeData(Result);
    if (Data <> nil) then
    begin
      Data^.Level   := vtAccounts.GetNodeLevel(Result);
      Data^.Node    := Result;
      Data^.DataRow := TDataRow.CreateFromDataSet(nil, ADataSet, True);
    end;
  end;
end;

procedure TfrmLancament.LoadAccountsList;
var
  Data: PGridData;
  Node: PVirtualNode;
  Child: PVirtualNode;
  APk : Integer;
  AFk : Integer;
  AChl: Boolean;
  function GetFatherNode: PVirtualNode;
  begin
    Result := Node;
    if (vtAccounts.NodeParent[Node] = nil) then exit;
    while (Result <> nil) and (APk <> AFk) do
    begin
      Result := vtAccounts.NodeParent[Result];
      if (Result <> nil) then
      begin
        Data := vtAccounts.GetNodeData(Result);
        if (Data <> nil) and (Data^.DataRow <> nil) then
          APk := Data^.DataRow.FieldByName['R_PK_FINANCEIRO_CONTAS'].AsInteger;
      end;
    end;
  end;
begin
  inherited;
  Node  := nil;
  Child := nil;
  Data  := nil;
  Screen.Cursor := crHourGlass;
  vtAccounts.BeginUpdate;
  with dmSysBcCx.qrFinance do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlFinAccounts); // Get data from procedure STP_GET_ACCOUNTS
    Dados.StartTransaction(dmSysBcCx.qrFinance);
    if not Active then Open;
    try
      APk  := FieldByName('R_PK_FINANCEIRO_CONTAS').AsInteger;
      AFk  := FieldByName('R_FK_FINANCEIRO_CONTAS').AsInteger;
      while not EOF do
      begin
        if (APk <> AFk) then
        begin
          Node  := GetFatherNode;
          Child := AddDataNode(Node, dmSysBcCx.qrFinance);
          APk   := FieldByName('R_FK_FINANCEIRO_CONTAS').AsInteger;
          aChl  := True;
        end
        else
        begin
          Node := AddDataNode(Node, dmSysBcCx.qrFinance);
          if (APk <> FieldByName('R_PK_FINANCEIRO_CONTAS').AsInteger) then
            APk := FieldByName('R_PK_FINANCEIRO_CONTAS').AsInteger;
          aChl := False;
        end;
        Next;
        AFk := FieldByName('R_FK_FINANCEIRO_CONTAS').AsInteger;
        if (AChl) then
        begin
          Node := Child;
          if (Node <> nil) then
          begin
            Data := vtAccounts.GetNodeData(Node);
            if (Data <> nil) and (Data^.DataRow <> nil) then
              APk := Data^.DataRow.FieldByName['R_PK_FINANCEIRO_CONTAS'].AsInteger;
          end;
        end;
        if (FieldByName('R_FK_FINANCEIRO_CONTAS').AsInteger =
            FieldByName('R_PK_FINANCEIRO_CONTAS').AsInteger) then
          Node := nil;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(dmSysBcCx.qrFinance);
      vtAccounts.EndUpdate;
      Screen.Cursor := crDefault;
    end;
  end;
  if (vtAccounts.RootNodeCount > 0) then
  begin
    vtAccounts.FullExpand;
    vtAccounts.FocusedNode := vtAccounts.GetFirst;
    vtAccounts.Selected[vtAccounts.FocusedNode] := True;
  end;
end;

procedure TfrmLancament.vtAccountsBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then  exit;
  ItemColor := ACCOUNT_COLOR[TAccountNat(Data^.DataRow.FieldByName['R_FLAG_TCTA'].AsInteger)];
  EraseAction := eaColor;
end;

procedure TfrmLancament.vtAccountsFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then  exit;
  SearchField        := 'R_DSC_CTA';
//  lFk_Plano_Contas.Enabled := not pmNewLevel.Visible;
//  eFk_Plano_Contas.Enabled := not pmNewLevel.Visible;
end;

procedure TfrmLancament.vtAccountsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then  exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['R_DSC_CTA'].AsString;
    1: CellText := Data^.DataRow.FieldByName['R_MASK_CTA'].AsString;
    2: CellText := 'R$ 0,00';
  end;
end;

procedure TfrmLancament.vtAccountsGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
var
  Data: PGridData;
begin
  if (Node = nil) or (Kind in [ikState, ikOverlay]) then exit;
  Data := Sender.GetNodeData(Node);
  if (Column = 0) then
    if (Data <> nil) and (Data^.DataRow <> nil) then
      if (Data^.DataRow.FieldByName['R_FLAG_ANL_SNT'].AsInteger = 0) then
        ImageIndex := 21
      else
        ImageIndex := 38
    else
      ImageIndex := 2;
  if (Column = 1) then
    if (Kind = ikSelected) then
      if (ScrState in UPDATE_MODE) then
        ImageIndex := 0
      else
        ImageIndex := 4
    else
      if (Kind = ikNormal) then
        ImageIndex := -1;
end;

procedure TfrmLancament.vtAccountsFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  Allowed := (ScrState in SCROLL_MODE);
end;

procedure TfrmLancament.vtAccountsIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode;
  const SearchText: WideString; var Result: Integer);
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

procedure TfrmLancament.vtAccountsStateChange(Sender: TBaseVirtualTree;
  Enter, Leave: TVirtualTreeStates);
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

procedure TfrmLancament.clAccountFilterClickCheck(Sender: TObject);
var
  i: Integer;
begin
  FFilterAcc := [];
  Cursor := crHourGlass;
  vtAccounts.BeginUpdate;
  try
    with clAccountFilter do
      for i := 0 to Items.Count - 1 do
        if (Checked[i]) then
          FFilterAcc := FFilterAcc + [TAccountNat(i)];
  finally
    vtAccounts.BeginUpdate;
    Cursor := crDefault;
  end;
  SetFilterAcc(FFilterAcc);
end;

procedure TfrmLancament.SetFilterAcc(const Value: TAccountNats);
begin
  FFilterAcc := Value;
end;

procedure TfrmLancament.sbFilterClick(Sender: TObject);
var
  aFilterData: PFilterData;
begin
  vtAccounts.BeginUpdate;
  GetMem(aFilterData, SizeOf(TFilterData));
  try
    aFilterData^.AccountType := FFilterAcc;
    aFilterData^.AccountCode := eAccountCode.Text;
    aFilterData^.OperAccCode := TOperation(eOperAccCode.ItemIndex);
    aFilterData^.Balance     := eBalance.Value;
    aFilterData^.OperAccCode := TOperation(eOperBalance.ItemIndex);
    vtAccounts.IterateSubtree(nil, HideNodes, aFilterData, [], True);
  finally
    vtAccounts.EndUpdate;
    FreeMem(aFilterData, SizeOf(TFilterData));
  end;
end;

procedure TfrmLancament.HideNodes(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  aData: PGridData;
begin
  if (Node = nil) or (Data = nil) then exit;
  aData := Sender.GetNodeData(Node);
  if (aData = nil) or (aData^.DataRow = nil) then exit;
  with aData^.DataRow do
    Sender.IsVisible[Node] := PFilterData(Data).AccountCode <= FieldByName['DSC_CTA'].AsString;
end;

procedure TfrmLancament.eFk_ClassificacaoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aClass : TClassification;
  aColor : TColor;
  aOffSet: Integer;
  aStr   ,
  aItmStr: string;
begin
  if (Index > TComboBox(Control).Items.Count) or
     (TComboBox(Control).Items.Objects[Index] = nil) or
     (not (TComboBox(Control).Items.Objects[Index] is TClassification)) then
  begin
    TComboBox(Control).Canvas.TextOut(Rect.Left, Rect.Top,
      TComboBox(Control).Items.Strings[Index]);
    exit;
  end;
  aClass  := TClassification(TComboBox(Control).Items.Objects[Index]);
  aColor  := clGray;
  aOffSet := aClass.NivCta * 10;
  if aClass.FlagAnlSnt then
    aColor  := clWindowText;
  with (Control as TComboBox).Canvas do
  begin
    if (odSelected in State) then
      Font.Color := clWhite
    else
      Font.Color := aColor;
    aStr       := TComboBox(Control).Items.Strings[Index];
    aItmStr    := Copy(aStr, 1, Pos('|', aStr) - 1);
    Delete(aStr, 1, Pos('|', aStr));
    TextOut(Rect.Left + aOffSet, Rect.Top, aItmStr);
    TextOut(Rect.Left + 300, Rect.Top, aStr);
  end;
end;

initialization
  RegisterClass(TfrmLancament);

end.
