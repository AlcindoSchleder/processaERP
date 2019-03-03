unit CadGroups;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 30/06/2006 - DD/MM/YYYY                                    *}
{* Modified :            - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
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
  Dialogs, CadListModel, StdCtrls, ExtCtrls, PrcCombo, Mask, ToolEdit, ProcUtils,
  CurrEdit, VirtualTrees, ComCtrls, ToolWin, TSysFatAux, TSysBcCx, ImgList, DB,
  ProcType, Menus, TSysCtbAux, Buttons;

type
  TCdGroups = class(TfrmModelList)
    pmGrid: TPopupMenu;
    pmNewLevel: TMenuItem;
    pData: TPanel;
    sDiv: TSplitter;
    shTitle: TShape;
    lTitle: TLabel;
    lSeq_Class: TStaticText;
    lMask_Class: TStaticText;
    lDsc_PGru: TStaticText;
    eDsc_PGru: TEdit;
    eMask_Class: TEdit;
    eSeq_Class: TCurrencyEdit;
    lLev_Class: TStaticText;
    eLev_Class: TCurrencyEdit;
    pgFlagLastLevel: TPageControl;
    tsList: TTabSheet;
    tsDataLevel: TTabSheet;
    pgAccounts: TPageControl;
    tsGridList: TTabSheet;
    tsData: TTabSheet;
    lFk_Natureza_Operacoes: TStaticText;
    eFk_Natureza_Operacoes: TComboBox;
    lFk_Financeiro_Contas: TStaticText;
    eFk_Financeiro_Contas: TComboBox;
    vtGroupAccount: TVirtualStringTree;
    lDsct_Prod: TStaticText;
    eDsct_Prod: TCurrencyEdit;
    lMrgm_Ref: TStaticText;
    eMrgm_Ref: TCurrencyEdit;
    eCom_SGru: TCurrencyEdit;
    lCom_SGru: TStaticText;
    eCod_GRef: TEdit;
    lCod_GRef: TStaticText;
    eSeq_Ref: TCurrencyEdit;
    lSeq_Ref: TStaticText;
    stOk: TSpeedButton;
    stCancel: TSpeedButton;
    pmAccMenu: TPopupMenu;
    pmNewAcc: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure tbInsertClick(Sender: TObject);
    procedure pmNewLevelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtGroupAccountGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtGroupAccountFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtGroupAccountPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtGroupAccountDblClick(Sender: TObject);
    procedure eFk_Financeiro_ContasDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure pgFlagLastLevelChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure stCancelClick(Sender: TObject);
    procedure eFk_Financeiro_ContasSelect(Sender: TObject);
    procedure stOkClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmNewAccClick(Sender: TObject);
  private
    { Private declarations }
    FNodeHasChild    : Boolean;
    FFkFinanceAccount: Integer;
    FAccState        : TDBMode;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscPGru: string;
    function  GetFlagLastLevel: Boolean;
    function  GetFinaceAcc: TClassification;
    function  GetLevClass: Integer;
    function  GetMaskClass: string;
    function  GetSeqClass: Integer;
    function  GetCodGRef: string;
    function  GetComSGru: Double;
    function  GetDsctProd: Double;
    function  GetMrgmRef: Double;
    function  GetSeqRef: Integer;
    function  GetFkFinaceAcc: Integer;
    function  GetFkNatureOper: TNatureOperation;
    procedure SetDscPGru(const Value: string);
    procedure SetLevClass(const Value: Integer);
    procedure SetMaskClass(const Value: string);
    procedure SetSeqClass(const Value: Integer);
    procedure SetCodGRef(const Value: string);
    procedure SetComSGru(const Value: Double);
    procedure SetDsctProd(const Value: Double);
    procedure SetMrgmRef(const Value: Double);
    procedure SetSeqRef(const Value: Integer);
    procedure LoadAccountGrid;
    procedure SetNodeHasChild(const Value: Boolean);
    procedure SetFkFinaceAcc(const Value: Integer);
    procedure SetNatureOper(const Value: TNatureOperation);
    procedure StateChange(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    function GetAccountData(Index: PVirtualNode): PVirtualNode;
    procedure SetAccountData(Index: PVirtualNode;
      const Value: PVirtualNode);
    function  GetNodeFromFinanceAcc: PVirtualNode;
    procedure DeleteNode(ANode: PVirtualNode);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  DscPGru      : string           read GetDscPGru       write SetDscPGru;
    property  FlagLastLevel: Boolean          read GetFlagLastLevel;
    property  LevClass     : Integer          read GetLevClass      write SetLevClass;
    property  MaskClass    : string           read GetMaskClass     write SetMaskClass;
    property  SeqClass     : Integer          read GetSeqClass      write SetSeqClass;
    property  DsctProd     : Double           read GetDsctProd      write SetDsctProd;
    property  MrgmRef      : Double           read GetMrgmRef       write SetMrgmRef;
    property  ComSGru      : Double           read GetComSGru       write SetComSGru;
    property  CodGRef      : string           read GetCodGRef       write SetCodGRef;
    property  SeqRef       : Integer          read GetSeqRef        write SetSeqRef;
    property  NodeHasChild : Boolean          read FNodeHasChild    write SetNodeHasChild;
    property  FkNatureOper : TNatureOperation read GetFkNatureOper  write SetNatureOper;
    property  FkFinanceAcc : Integer          read GetFkFinaceAcc   write SetFkFinaceAcc;
    property  AccountData  [Index: PVirtualNode]: PVirtualNode     read GetAccountData   write SetAccountData;
    property  FinanceAcc   : TClassification  read GetFinaceAcc;
  public
    { Public declarations }
  end;

var
  CdGroups: TCdGroups;

implementation

uses Dado, mSysEstq, EstqArqSql, GridRow, FuncoesDB, Funcoes;

{$R *.dfm}

{ TCdFinanceAcc }

function TCdGroups.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscPGru = '') then
  begin
    Dados.DisplayHint(eDsc_PGru, 'Campo Descrição deve ser preenchido');
    Result := False;
  end;
end;

procedure TCdGroups.ClearControls;
begin
  Loading := True;
  try
    SeqClass      := 0;
    LevClass      := 0;
    MaskClass     := '';
    DscPGru       := '';
    DsctProd      := 0.0;
    MrgmRef       := 0.0;
    ComSGru       := 0.0;
    CodGRef       := '';
    SeqRef        := 0;
  finally
    Loading := False;
  end;
end;

function TCdGroups.GetDscPGru: string;
begin
  Result := eDsc_PGru.Text;
end;

function TCdGroups.GetFlagLastLevel: Boolean;
begin
  Result := (eCod_GRef.Text <> '');
end;

function TCdGroups.GetLevClass: Integer;
begin
  Result := eLev_Class.AsInteger;
end;

function TCdGroups.GetMaskClass: string;
begin
  Result := eMask_Class.Text;
end;

function TCdGroups.GetSeqClass: Integer;
begin
  Result := eSeq_Class.AsInteger;
end;

function TCdGroups.GetCodGRef: string;
begin
  Result := eCod_GRef.Text;
end;

function TCdGroups.GetComSGru: Double;
begin
  Result := eCom_SGru.Value;
end;

function TCdGroups.GetFkFinaceAcc: Integer;
begin
  Result := 0;
   with eFk_Financeiro_Contas do
     if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
       Result := TClassification(Items.Objects[ItemIndex]).Pk;
end;

function TCdGroups.GetFinaceAcc: TClassification;
begin
  Result := nil;
   with eFk_Financeiro_Contas do
     if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
       Result := TClassification(Items.Objects[ItemIndex]);
end;

function TCdGroups.GetFkNatureOper: TNatureOperation;
begin
  Result := nil;
   with eFk_Natureza_Operacoes do
     if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
       Result := TNatureOperation(Items.Objects[ItemIndex]);
end;

function TCdGroups.GetDsctProd: Double;
begin
  Result := eDsct_Prod.Value;
end;

function TCdGroups.GetMrgmRef: Double;
begin
  Result := eMrgm_Ref.Value;
end;

function TCdGroups.GetSeqRef: Integer;
begin
  Result := eSeq_Ref.AsInteger;
end;

procedure TCdGroups.LoadDefaults;
begin
  Screen.Cursor := crHourGlass;
  try
    if (not ListLoaded) then
    begin
      eFk_Financeiro_Contas.Items.AddStrings(dmSysEstq.LoadFinanceAccounts(-1));
      eFk_Natureza_Operacoes.Items.AddStrings(dmSysEstq.LoadNatureOper);
      ListLoaded := True;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TCdGroups.LoadList(Sender: TObject);
var
  Data : PGridData;
  Node : PVirtualNode;
  Child: PVirtualNode;
  APk  ,
  AFk  : Integer;
  AChl : Boolean;
  function GetFatherNode: PVirtualNode;
  begin
    Result := Node;
    if (vtList.NodeParent[Node] = nil) then exit;
    while (Result <> nil) and (APk <> AFk) do
    begin
      Result := vtList.NodeParent[Result];
      if (Result <> nil) then
      begin
        Data := vtList.GetNodeData(Result);
        if (Data <> nil) and (Data^.DataRow <> nil) then
          APk := Data^.DataRow.FieldByName['R_PK_PRODUTOS_GRUPOS'].AsInteger;
      end;
    end;
  end;
begin
  Node  := nil;
  Child := nil;
  Screen.Cursor := crHourGlass;
  inherited;
  vtList.BeginUpdate;
  with dmSysEstq.qrGroup do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlSelectGroups); // Get data from procedure STP_GET_ACCOUNTS
    Dados.StartTransaction(dmSysEstq.qrGroup);
    if not Active then Open;
    try
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, dmSysEstq.qrGroup, False);
      APk  := FieldByName('R_PK_PRODUTOS_GRUPOS').AsInteger;
      AFk  := FieldByName('R_FK_PRODUTOS_GRUPOS').AsInteger;
      while not EOF do
      begin
        if (APk <> AFk) then
        begin
          Node  := GetFatherNode;
          Child := AddDataNode(Node, dmSysEstq.qrGroup);
          APk   := FieldByName('R_FK_PRODUTOS_GRUPOS').AsInteger;
          aChl := True;
        end
        else
        begin
          Node := AddDataNode(Node, dmSysEstq.qrGroup);
          APk  := FieldByName('R_PK_PRODUTOS_GRUPOS').AsInteger;
          aChl := False;
        end;
        Next;
        AFk := FieldByName('R_FK_PRODUTOS_GRUPOS').AsInteger;
        if (AChl) then
        begin
          Node := Child;
          if (Node <> nil) then
          begin
            Data := vtList.GetNodeData(Node);
            if (Data <> nil) and (Data^.DataRow <> nil) then
              APk := Data^.DataRow.FieldByName['R_PK_PRODUTOS_GRUPOS'].AsInteger;
          end;
        end;
        if (FieldByName('R_FK_PRODUTOS_GRUPOS').AsInteger =
            FieldByName('R_PK_PRODUTOS_GRUPOS').AsInteger) then
          Node := nil;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(dmSysEstq.qrGroup);
      vtList.EndUpdate;
      Screen.Cursor := crDefault;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FullExpand;
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdGroups.MoveDataToControls;
var
  aObj: TGroups;
begin
  Loading := True;
  try
    AObj          := dmSysEstq.Groups[Pk];
    SeqClass      := aObj.Group.SeqCta;
    LevClass      := aObj.Group.NivCta;
    MaskClass     := aObj.Group.MaskCta;
    DscPGru       := aObj.Group.DscClass;
    DsctProd      := aObj.DsctProd;
    MrgmRef       := aObj.MrgmRef;
    ComSGru       := aObj.ComSGru;
    CodGRef       := aObj.CodGRef;
    SeqRef        := aObj.SeqRef;
  finally
    FreeAndNil(aObj);
    Loading := False;
  end;
end;

procedure TCdGroups.SaveIntoDB;
var
  aObj: TGroups;
  Node: PVirtualNode;
  Data: PGridData;
  i   : Integer;
begin
  Loading := True;
  aObj.Group := TClassification.Create;
  try
    aObj.Group.Pk               := Pk;
    aObj.Group.FkFinanceAccount := FFkFinanceAccount;
    aObj.Group.SeqCta           := SeqClass;
    aObj.Group.NivCta           := LevClass;
    aObj.Group.MaskCta          := MaskClass;
    aObj.Group.DscClass         := DscPGru;
    aObj.Group.FlagAnlSnt       := FlagLastLevel;
    aObj.DsctProd               := DsctProd;
    aObj.MrgmRef                := MrgmRef;
    aObj.ComSGru                := ComSGru;
    aObj.CodGRef                := CodGRef;
    aObj.SeqRef                 := SeqRef;
    dmSysEstq.Groups[Ord(ScrState)] := aObj;
    with vtList do
    begin
      if (FocusedNode <> nil) then
      begin
        Data := GetNodeData(FocusedNode);
        if (Data <> nil) and (Data^.DataRow <> nil) then
        begin
          for i := 0 to Data^.DataRow.Count - 1 do
            Data^.DataRow.Fields[i].TypeBuffer := buValue;
          Data^.DataRow.FieldByName['R_PK_PRODUTOS_GRUPOS'].AsInteger := aObj.Group.Pk;
          Data^.DataRow.FieldByName['R_FK_PRODUTOS_GRUPOS'].AsInteger := aObj.Group.FkFinanceAccount;
          Data^.DataRow.FieldByName['R_DSC_PGRU'].AsString            := DscPGru;
          Data^.DataRow.FieldByName['R_MASK_CLASS'].AsString          := MaskClass;
          Data^.DataRow.FieldByName['R_SEQ_CLASS'].AsInteger          := SeqClass;
          Data^.DataRow.FieldByName['R_FLAG_LAST_LEVEL'].AsInteger    := Ord(FlagLastLevel);
          Pk := aObj.Group.Pk;
        end;
      end;
    end;
    with vtGroupAccount do
    begin
      dmSysEstq.Accounts[Pk] := nil;
      if (ScrState <> dbmDelete) then
      begin
        Node := GetFirst;
        while (Node <> nil) do
        begin
          Data := GetNodeData(Node);
          if (GetNodeLevel(Node) > 0) and (Data <> nil) and
             (Data^.DataRow <> nil) then
          begin
            dmSysEstq.Accounts[Ord(dbmInsert)] := Data^.DataRow;
            Data^.DataRow.FieldByName['ROW_STATE'].AsInteger := Ord(dbmBrowse);
          end;
          Node := GetNext(Node);
        end;
      end;
    end;
  finally
    Loading := False;
    FreeAndNil(aObj);
  end;
  lSeq_Class.Enabled  := False;
  eSeq_Class.Enabled  := False;
  lLev_Class.Enabled  := False;
  eLev_Class.Enabled  := False;
  lMask_Class.Enabled := False;
  eMask_Class.Enabled := False;
end;

procedure TCdGroups.SetFkFinaceAcc(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Financeiro_Contas do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (TClassification(Items.Objects[i]).Pk = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdGroups.SetNatureOper(const Value: TNatureOperation);
var
  i: Integer;
begin
  with eFk_Natureza_Operacoes do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (TNatureOperation(Items.Objects[i]).TypeCfop.Pk = Value.TypeCfop.Pk) and
         (TNatureOperation(Items.Objects[i]).Pk = Value.Pk) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdGroups.SetDscPGru(const Value: string);
begin
  eDsc_PGru.Text := Value;
end;

procedure TCdGroups.SetLevClass(const Value: Integer);
begin
  eLev_Class.AsInteger := Value;
end;

procedure TCdGroups.SetMaskClass(const Value: string);
begin
  eMask_Class.Text := Value;
end;

procedure TCdGroups.SetSeqClass(const Value: Integer);
begin
  eSeq_Class.AsInteger := Value;
end;

procedure TCdGroups.SetCodGRef(const Value: string);
begin
  eCod_GRef.Text := Value;
end;

procedure TCdGroups.SetComSGru(const Value: Double);
begin
  eCom_SGru.Value := Value;
end;

procedure TCdGroups.SetDsctProd(const Value: Double);
begin
  eDsct_Prod.Value := Value;
end;

procedure TCdGroups.SetMrgmRef(const Value: Double);
begin
  eMrgm_Ref.Value := Value;
end;

procedure TCdGroups.SetNodeHasChild(const Value: Boolean);
begin
  FNodeHasChild             := Value;
  pgFlagLastLevel.Visible := (not FNodeHasChild);
  tsList.TabVisible       := (not FNodeHasChild);
  if (not FNodeHasChild) then
    LoadAccountGrid;
end;

procedure TCdGroups.SetSeqRef(const Value: Integer);
begin
  eSeq_Ref.AsInteger := Value;
end;

procedure TCdGroups.FormCreate(Sender: TObject);
begin
  pgFlagLastLevel.ActivePageIndex := 0;
  pgAccounts.ActivePageIndex      := 0;
  vtGroupAccount.NodeDataSize     := SizeOf(TGridData);
  FAccState     := dbmBrowse;
  OnCheckRecord := CheckRecord;
  OnChangeState := StateChange;
  OnListLoad    := LoadList;
  inherited;
  pmGrid.Images := Dados.Image16;
  pmNewLevel.ImageIndex := 65; //19;
end;

procedure TCdGroups.FormDestroy(Sender: TObject);
begin
  ReleaseCombos(eFk_Financeiro_Contas, toObject);
  ReleaseCombos(eFk_Natureza_Operacoes, toObject);
end;

procedure TCdGroups.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then  exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['R_MASK_CLASS'].AsString;
    1: CellText := Data^.DataRow.FieldByName['R_DSC_PGRU'].AsString;
  end;
end;

procedure TCdGroups.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
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
      if (Data^.DataRow.FieldByName['R_FLAG_LAST_LEVEL'].AsInteger = 0) then
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

procedure TCdGroups.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then  exit;
  FFkFinanceAccount  := Data^.DataRow.FieldByName['R_FK_PRODUTOS_GRUPOS'].AsInteger;
  Pk                 := Data^.DataRow.FieldByName['R_PK_PRODUTOS_GRUPOS'].AsInteger;
//  pmNewLevel.Visible := (Data^.DataRow.FieldByName['R_FLAG_LAST_LEVEL'].AsInteger = 1);
  NodeHasChild       := Sender.HasChildren[Node];
end;

procedure TCdGroups.tbInsertClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
  aFk ,
  aNiv,
  aLen,
  aSeq: Integer;
  aMsk: string;
begin
  Data := nil;
  Node := nil;
  aNiv := 0;
  aSeq := 0;
  aFk  := FFkFinanceAccount;
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data <> nil) then
      begin
        if (Data^.NodeType = tnData) then
        begin
          Node := FocusedNode;
          if (NodeParent[Node] <> nil) then
            Node := GetLastChild(NodeParent[Node])
          else
            Node := GetLast;
        end
        else
          Node := FocusedNode;
      end;
      Data := GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        aNiv := Data^.Level;
        aSeq := Data^.DataRow.FieldByName['R_SEQ_CLASS'].AsInteger;
        if (Data^.NodeType = tnFolder) then
        begin
          aFk := Data^.DataRow.FieldByName['R_PK_PRODUTOS_GRUPOS'].AsInteger;
          Inc(aNiv);
          aSeq := 0;
        end;
        aMsk := Data^.DataRow.FieldByName['R_MASK_CLASS'].AsString;
      end;
    end;
  end;
  inherited;
  Inc(aSeq);
  Inc(aNiv);
  LevClass   := aNiv;
  SeqClass   := aSeq;
  if (aNiv = 1) then
    MaskClass := IntToStr(aSeq)
  else
  begin
    if (Data <> nil) and (Data^.NodeType = tnFolder) then
      MaskClass := aMsk + '.' + IntToStr(aSeq)
    else
    begin
      Dec(aSeq);
      aLen := Length(IntToStr(aSeq));
      Delete(aMsk, (Length(aMsk) - aLen), aLen + 1);
      MaskClass := aMsk + '.' + IntToStr(SeqClass);
    end;
  end;
  FFkFinanceAccount := aFk;
end;

procedure TCdGroups.pmNewLevelClick(Sender: TObject);
var
  Data: PGridData;
begin
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data <> nil) then
      begin
        Data^.NodeType := tnFolder;
        tbInsert.Click;
        Data^.NodeType := tnData;
      end;
    end;
  end;
end;

procedure TCdGroups.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F2) then
  begin
    lSeq_Class.Enabled  := True;
    eSeq_Class.Enabled  := True;
    lLev_Class.Enabled  := True;
    eLev_Class.Enabled  := True;
    lMask_Class.Enabled := True;
    eMask_Class.Enabled := True;
    if eSeq_Class.CanFocus then eSeq_Class.SetFocus;
    Key := 0;
  end;
  if ((ssCtrl in Shift) and (Key = VK_INSERT)) and (ScrState in SCROLL_MODE) then
  begin
    pmNewLevel.Click;
    Key := 0;
  end;
  inherited;
end;

procedure TCdGroups.LoadAccountGrid;
var
  Node: PVirtualNode;
  Data: PGridData;
  aMsk: string;
  function AddNodeAccount(ANode: PVirtualNode): PVirtualNode;
  begin
    Result := vtGroupAccount.AddChild(ANode);
    if (Result <> nil) then
    begin
      Data := vtGroupAccount.GetNodeData(Result);
      if (Data <> nil) then
      begin
        Data^.DataRow  := TDataRow.CreateFromDataSet(nil, dmSysEstq.qrSqlAux, True);
        Data^.Level    := 0;
        Data^.Node     := Result;
        Data^.NodeType := tnData;
      end;
    end;
  end;
begin
  aMsk := '';
  Node := nil;
  ReleaseTreeNodes(vtGroupAccount);
  with dmSysEstq.qrSqlAux do
  begin
    if (Active) then Close;
    Sql.Clear;
    Sql.Add(SqlGroupAccounts);
    Dados.StartTransaction(dmSysEstq.qrSqlAux);
    try
      ParamByName('FkProdutosGrupos').AsInteger := Pk;
      if (not Active) then Open;
      while (not Eof) do
      begin
        if (aMsk <> FieldByName('MASK_CTA').AsString) then
          Node := AddNodeAccount(nil);
        if (Node <> nil) then AddNodeAccount(Node);
        aMsk := FieldByName('MASK_CTA').AsString;
        Next;
      end;
    finally
      if (Active) then Close;
      Dados.CommitTransaction(dmSysEstq.qrSqlAux);
    end;
  end;
  if (vtGroupAccount.RootNodeCount > 0) then
    vtGroupAccount.FullExpand(nil);
end;

procedure TCdGroups.vtGroupAccountGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['MASK_CTA'].AsString + ' : ' +
                   Data^.DataRow.FieldByName['DSC_CTA'].AsString;
    1: CellText := Data^.DataRow.FieldByName['COD_CFOP'].AsString + '/' +
                   Data^.DataRow.FieldByName['DSC_NTOP'].AsString;
  end;
end;

procedure TCdGroups.vtGroupAccountFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
  aItm: TNatureOperation;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  FkFinanceAcc := Data^.DataRow.FieldByName['PK_FINANCEIRO_CONTAS'].AsInteger;
  aItm := TNatureOperation.Create;
  try
    aItm.TypeCfop.Pk := Data^.DataRow.FieldByName['FK_TIPO_CFOP'].AsInteger;
    aItm.Pk := Data^.DataRow.FieldByName['PK_NATUREZA_OPERACOES'].AsInteger;
    FkNatureOper := aItm;
  finally
    FreeAndNil(aItm);
  end;
end;

procedure TCdGroups.vtGroupAccountPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
const
  TEXT_COLOR: array [TAccountNat] of TColor =
   (clGreen, clBlue, clMaroon, clTeal, clWindowText);
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['ROW_STATE'].AsInteger <> 3) then
    TargetCanvas.Font.Color := clRed
  else
    TargetCanvas.Font.Color := TEXT_COLOR[TAccountNat(Data^.DataRow.FieldByName['FLAG_TCTA'].AsInteger)];
end;

procedure TCdGroups.vtGroupAccountDblClick(Sender: TObject);
begin
  with vtGroupAccount do
    if (FocusedNode <> nil) and (GetNodeLevel(FocusedNode) = 1) then
      pgAccounts.ActivePageIndex := 1;
end;

procedure TCdGroups.eFk_Financeiro_ContasDrawItem(Control: TWinControl;
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
    TComboBox(Control).Canvas.Brush.Style := bsClear;
    TComboBox(Control).Canvas.DrawFocusRect(Rect);
    TComboBox(Control).Canvas.FrameRect(Rect);
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
    if ((TextWidth(Trim(aItmStr)) + Rect.Left + aOffSet) > (Rect.Left + 200)) then
    begin
      while ((TextWidth(Trim(aItmStr) + '...') + Rect.Left + aOffSet) > (Rect.Left + 200)) do
        Delete(aItmStr, Length(aItmStr), 1);
      aItmStr := aItmStr + '...'
    end;
    TextOut(Rect.Left + aOffSet, Rect.Top + 1, aItmStr);
    TextOut(Rect.Left + 200, Rect.Top + 1, aStr);
    if (odSelected in State) or
       (odFocused  in State) or
       (odHotLight in State) then
    begin
      TComboBox(Control).Canvas.Brush.Style := bsClear;
      TComboBox(Control).Canvas.DrawFocusRect(Rect);
      TComboBox(Control).Canvas.FrameRect(Rect);
    end;
  end;
end;

procedure TCdGroups.pgFlagLastLevelChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := ((pgAccounts.ActivePageIndex = 0) or
                 ((pgAccounts.ActivePageIndex = 1) and (ScrState in SCROLL_MODE)));
end;

procedure TCdGroups.stCancelClick(Sender: TObject);
begin
  if (FAccState in UPDATE_MODE) then
    ScrState := dbmCancel;
  pgAccounts.ActivePageIndex := 0;
end;

procedure TCdGroups.StateChange(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  if (FAccState in UPDATE_MODE) and (AState in SCROLL_MODE) then
    FAccState := AState;
  if (FAccState in UPDATE_MODE) and (AState in UPDATE_MODE) and
     (pgAccounts.ActivePageIndex > 0) then
    FAccState := AState;
end;

procedure TCdGroups.eFk_Financeiro_ContasSelect(Sender: TObject);
begin
  with eFk_Financeiro_Contas do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) and
       (TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) then
    begin
      Dados.DisplayHint(eFk_Financeiro_Contas, 'Você só pode selecionar uma conta analítica');
      ItemIndex := -1;
      exit;
    end;
  end;
  ChangeGlobal(Sender);
end;

procedure TCdGroups.stOkClick(Sender: TObject);
var
  Data: PGridData;
  aDta: PGridData;
  Node: PVirtualNode;
begin
  if (FkFinanceAcc = 0) then
  begin
    Dados.DisplayHint(eFk_Financeiro_Contas, 'Campo Conta dever ser preenchido');
    eFk_Financeiro_Contas.SetFocus;
    exit;
  end;
  if (FkNatureOper = nil) or (FkNatureOper.Pk = 0) then
  begin
    Dados.DisplayHint(eFk_Natureza_Operacoes, 'Campo Natureza da Operação dever ser preenchido');
    eFk_Natureza_Operacoes.SetFocus;
    exit;
  end;
  with vtGroupAccount do
  begin
    if (FocusedNode <> nil) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
        Data^.DataRow.FieldByName['ROW_STATE'].AsInteger := Ord(ScrState);
      AccountData[FocusedNode] := FocusedNode;
      if (GetNodeLevel(FocusedNode) = 1) and (FocusedNode.Parent <> nil) then
      begin
        Data := GetNodeData(FocusedNode.Parent);
        if (Data <> nil) and (Data^.DataRow <> nil) then
        begin
          if (Data^.DataRow.FieldByName['PK_FINANCEIRO_CONTAS'].AsInteger > 0) and
             (Data^.DataRow.FieldByName['PK_FINANCEIRO_CONTAS'].AsInteger <> FkFinanceAcc) then
          begin
            Self.DeleteNode(FocusedNode);
            Node := GetNodeFromFinanceAcc;
            if (Node = nil) then
            begin
              Node              := AccountData[nil];
              AccountData[Node] := Node;
              Node              := AccountData[Node];
              AccountData[Node] := Node;
            end;
            if (Node <> nil) then
            begin
              aDta := GetNodeData(Node);
              if (aDta = nil) or (aDta^.DataRow = nil) then
                Data := aDta;

            end;
          end;
          if (Data^.DataRow.FieldByName['FK_TIPO_CFOP'].AsInteger = 0) then
            AccountData[FocusedNode.Parent] := Data^.Node;
          Data^.DataRow.FieldByName['ROW_STATE'].AsInteger := Ord(ScrState);
        end;
      end;
    end
  end;
  pgAccounts.ActivePageIndex := 0;
end;

procedure TCdGroups.pmNewAccClick(Sender: TObject);
var
  Data: PGridData;
  aFkAcc: Integer;
begin
  aFkAcc := 0;
  FAccState := dbmInsert;
  with vtGroupAccount do
  begin
    if (FocusedNode <> nil) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
        aFkAcc := Data^.DataRow.FieldByName['PK_FINANCEIRO_CONTAS'].AsInteger;
    end;
    if (FocusedNode = nil) or (GetNodeLevel(FocusedNode) = 0) then
    begin
      FocusedNode         := AccountData[nil];
      if (FocusedNode <> nil) then
        FocusedNode       := AccountData[FocusedNode];
    end
    else
      if (FocusedNode.Parent <> nil) and (GetNodeLevel(FocusedNode.Parent) = 0) then
        FocusedNode       := AccountData[FocusedNode.Parent];
    Selected[FocusedNode] := True;
  end;
  pgAccounts.ActivePageIndex := 1;
  if (aFkAcc > 0) then
    FkFinanceAcc := aFkAcc;
end;

function TCdGroups.GetAccountData(Index: PVirtualNode): PVirtualNode;
var
  Data: PGridData;
begin
  with vtGroupAccount do
  begin
    BeginUpdate;
    try
      Result := AddChild(Index);
      if (Result <> nil) then
      begin
        Data := GetNodeData(Result);
        if (Data <> nil) then
        begin
          Data^.Level    := GetNodeLevel(Result);
          Data^.Node     := Result;
          Data^.NodeType := tnData;
          Data^.DataRow  := dmSysEstq.Accounts[0];
          SetAccountData(Result, Result);
        end;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCdGroups.SetAccountData(Index: PVirtualNode;
  const Value: PVirtualNode);
var
  Data: PGridData;
begin
  if (Value = nil) then exit;
  Data := vtGroupAccount.GetNodeData(Value);
  if (pgAccounts.ActivePageIndex > 0) and (FkNatureOper <> nil) and
     (FinanceAcc <> nil) then
  begin
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    with Data^.DataRow do
    begin
      FieldByName['FK_PRODUTOS_GRUPOS'].AsInteger    := Pk;
      FieldByName['FK_TIPO_CFOP'].AsInteger          := FkNatureOper.TypeCfop.Pk;
      FieldByName['PK_NATUREZA_OPERACOES'].AsInteger := FkNatureOper.Pk;
      FieldByName['DSC_NTOP'].AsString               := FkNatureOper.DscNtOp;
      FieldByName['COD_CFOP'].AsString               := FkNatureOper.CodCfop;
      FieldByName['PK_FINANCEIRO_CONTAS'].AsInteger  := FinanceAcc.Pk;
      FieldByName['MASK_CTA'].AsString               := FinanceAcc.MaskCta;
      FieldByName['DSC_CTA'].AsString                := FinanceAcc.DscClass;
      FieldByName['FLAG_TCTA'].AsInteger             := Ord(FinanceAcc.FlagAnlSnt);
    end;
  end;
  if (Data <> nil) then
    Data^.DataRow.FieldByName['ROW_STATE'].AsInteger   := Ord(dbmBrowse);
end;

function TCdGroups.GetNodeFromFinanceAcc: PVirtualNode;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := nil;
  with vtGroupAccount do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (GetNodeLevel(Node) = 0) and (Data <> nil) and (Data^.DataRow <> nil) and
         (Data^.DataRow.FieldByName['PK_FINANCEIRO_CONTAS'].AsInteger = FkFinanceAcc) then
      begin
        Result := Node;
        break;
      end;
      Node := GetNext(Node);
    end;
  end;
end;

procedure TCdGroups.DeleteNode(ANode: PVirtualNode);
var
  Data: PGridData;
begin
  if (ANode = nil) then exit;
  with vtGroupAccount do
  begin
    Data := GetNodeData(ANode);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      Data^.DataRow.Free;
      Data^.DataRow := nil;
    end;
    DeleteNode(ANode);
  end;
end;

initialization
  RegisterClass(TCdGroups);

end.
