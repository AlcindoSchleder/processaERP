unit CadPlnAcc;

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
  Menus;

type
  TCdPlanAccount = class(TfrmModelList)
    pmGrid: TPopupMenu;
    pmNewLevel: TMenuItem;
    pData: TPanel;
    sDiv: TSplitter;
    shTitle: TShape;
    lTitle: TLabel;
    lFlag_TCta: TRadioGroup;
    lFlag_ID: TRadioGroup;
    lFlag_Anl_Snt: TRadioGroup;
    lSeq_Cta: TStaticText;
    lMask_Cta: TStaticText;
    lDsc_Cta: TStaticText;
    eDsc_Cta: TEdit;
    eMask_Cta: TEdit;
    eSeq_Cta: TCurrencyEdit;
    lGrau_Cta: TStaticText;
    eGrau_Cta: TCurrencyEdit;
    procedure lFlag_TCtaClick(Sender: TObject);
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
    procedure vtListBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure lFlag_Anl_SntClick(Sender: TObject);
  private
    FFkFinanceAccount: Integer;
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscCta: string;
    function  GetFlagAnlSnt: Boolean;
    function  GetFlagID: TAccountType;
    function  GetFlagTCta: TAccountNat;
    function  GetGrauCta: Integer;
    function  GetMaskCta: string;
    function  GetSeqCta: Integer;
    procedure SetDscCta(const Value: string);
    procedure SetFlagAnlSnt(const Value: Boolean);
    procedure SetFlagID(const Value: TAccountType);
    procedure SetFlagTCta(const Value: TAccountNat);
    procedure SetGrauCta(const Value: Integer);
    procedure SetMaskCta(const Value: string);
    procedure SetSeqCta(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  SeqCta          : Integer      read GetSeqCta         write SetSeqCta;
    property  GrauCta         : Integer      read GetGrauCta        write SetGrauCta;
    property  MaskCta         : string       read GetMaskCta        write SetMaskCta;
    property  DscCta          : string       read GetDscCta         write SetDscCta;
    property  FlagAnlSnt      : Boolean      read GetFlagAnlSnt     write SetFlagAnlSnt;
    property  FlagTCta        : TAccountNat  read GetFlagTCta       write SetFlagTCta;
    property  FlagID          : TAccountType read GetFlagID         write SetFlagID;
  public
    { Public declarations }
  end;

var
  CdPlanAccount: TCdPlanAccount;

implementation

uses Dado, mSysCtb, CtbArqSql, GridRow, ProcType, FuncoesDB;

{$R *.dfm}

{ TCdFinanceAcc }

const
  ACCOUNT_COLOR: array [TAccountNat] of TColor =
   (clInfoBk, clCream, clSkyBlue, clMoneyGreen, clWhite);
//  TAccountNat = (anActive, anPassive, anIncome, anExpense, anARE);

function TCdPlanAccount.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscCta = '') then
  begin
    Dados.DisplayHint(eDsc_Cta, 'Campo Descrição deve ser preenchido');
    Result := False;
  end;
end;

procedure TCdPlanAccount.ClearControls;
begin
  Loading := True;
  try
    SeqCta        := 0;
    GrauCta       := 0;
    MaskCta       := '';
    DscCta        := '';
    FlagAnlSnt    := False;
    FlagTCta      := anActive;
    FlagID        := atOther;
  finally
    Loading := False;
  end;
end;

function TCdPlanAccount.GetDscCta: string;
begin
  Result := eDsc_Cta.Text;
end;

function TCdPlanAccount.GetFlagAnlSnt: Boolean;
begin
  Result := Boolean(lFlag_Anl_Snt.ItemIndex);
end;

function TCdPlanAccount.GetFlagID: TAccountType;
begin
  Result := TAccountType(lFlag_ID.ItemIndex);
end;

function TCdPlanAccount.GetFlagTCta: TAccountNat;
begin
  Result := TAccountNat(lFlag_TCta.ItemIndex);
end;

function TCdPlanAccount.GetGrauCta: Integer;
begin
  Result := eGrau_Cta.AsInteger;
end;

function TCdPlanAccount.GetMaskCta: string;
begin
  Result := eMask_Cta.Text;
end;

function TCdPlanAccount.GetSeqCta: Integer;
begin
  Result := eSeq_Cta.AsInteger;
end;

procedure TCdPlanAccount.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdPlanAccount.LoadList(Sender: TObject);
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
    if (vtList.NodeParent[Node] = nil) then exit;
    while (Result <> nil) and (APk <> AFk) do
    begin
      Result := vtList.NodeParent[Result];
      if (Result <> nil) then
      begin
        Data := vtList.GetNodeData(Result);
        if (Data <> nil) and (Data^.DataRow <> nil) then
          APk := Data^.DataRow.FieldByName['R_PK_PLANO_CONTAS'].AsInteger;
      end;
    end;
  end;
begin
  Node := nil;
  Child := nil;
  Screen.Cursor := crHourGlass;
  inherited;
  vtList.BeginUpdate;
  with dmSysCtb.qrAccount do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlPlanAccounts); // Get data from procedure STP_GET_ACCOUNTS
    Dados.StartTransaction(dmSysCtb.qrAccount);
    if not Active then Open;
    try
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, dmSysCtb.qrAccount, False);
      APk  := FieldByName('R_PK_PLANO_CONTAS').AsInteger;
      AFk  := FieldByName('R_FK_PLANO_CONTAS').AsInteger;
      while not EOF do
      begin
        if (APk <> AFk) then
        begin
          Node  := GetFatherNode;
          Child := AddDataNode(Node, dmSysCtb.qrAccount);
          APk   := FieldByName('R_FK_PLANO_CONTAS').AsInteger;
          aChl := True;
        end
        else
        begin
          Node := AddDataNode(Node, dmSysCtb.qrAccount);
          if (APk <> FieldByName('R_PK_PLANO_CONTAS').AsInteger) then
            APk := FieldByName('R_PK_PLANO_CONTAS').AsInteger;
          aChl := False;
        end;
        Next;
        AFk := FieldByName('R_FK_PLANO_CONTAS').AsInteger;
        if (AChl) then
        begin
          Node := Child;
          if (Node <> nil) then
          begin
            Data := vtList.GetNodeData(Node);
            if (Data <> nil) and (Data^.DataRow <> nil) then
              APk := Data^.DataRow.FieldByName['R_PK_PLANO_CONTAS'].AsInteger;
          end;
        end;
        if (FieldByName('R_FK_PLANO_CONTAS').AsInteger =
            FieldByName('R_PK_PLANO_CONTAS').AsInteger) then
          Node := nil;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(dmSysCtb.qrAccount);
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

procedure TCdPlanAccount.MoveDataToControls;
var
  aObj: TClassification;
begin
  Loading := True;
  try
    AObj          := dmSysCtb.AccountPlan[Pk];
    SeqCta        := aObj.SeqCta;
    GrauCta       := aObj.NivCta;
    MaskCta       := aObj.MaskCta;
    DscCta        := aObj.DscClass;
    FlagAnlSnt    := aObj.FlagAnlSnt;
    FlagTCta      := aObj.FlagTCta;
    FlagID        := aObj.FlagID;
  finally
    Loading := False;
  end;
end;

procedure TCdPlanAccount.SaveIntoDB;
var
  aObj: TClassification;
  Data: PGridData;
  i   : Integer;
begin
  Loading := True;
  aObj := TClassification.Create;
  try
    aObj.Pk               := Pk;
    aObj.SeqCta           := SeqCta;
    aObj.NivCta           := GrauCta;
    aObj.MaskCta          := MaskCta;
    aObj.DscClass         := DscCta;
    aObj.FkFinanceAccount := FFkFinanceAccount;
    aObj.FlagAnlSnt       := FlagAnlSnt;
    aObj.FlagTCta         := FlagTCta;
    aObj.FlagID           := FlagID;
    dmSysCtb.AccountPlan[Ord(ScrState)] := aObj;
    with vtList do
    begin
      if (FocusedNode <> nil) then
      begin
        Data := GetNodeData(FocusedNode);
        if (Data <> nil) and (Data^.DataRow <> nil) then
        begin
          for i := 0 to Data^.DataRow.Count - 1 do
            Data^.DataRow.Fields[i].TypeBuffer := buValue;
          Data^.DataRow.FieldByName['R_PK_PLANO_CONTAS'].AsInteger := aObj.Pk;
          Data^.DataRow.FieldByName['R_FK_PLANO_CONTAS'].AsInteger := aObj.FkFinanceAccount;
          Data^.DataRow.FieldByName['R_DSC_CTA'].AsString          := DscCta;
          Data^.DataRow.FieldByName['R_MASK_CTA'].AsString         := MaskCta;
          Data^.DataRow.FieldByName['R_GRAU_CTA'].AsInteger        := GrauCta;
          Data^.DataRow.FieldByName['R_SEQ_CTA'].AsInteger         := SeqCta;
          Data^.DataRow.FieldByName['R_FLAG_ANL_SNT'].AsInteger    := Ord(FlagAnlSnt);
          Data^.DataRow.FieldByName['R_FLAG_TCTA'].AsInteger       := Ord(FlagTCta);
          Pk := aObj.Pk;
        end;
      end;
    end;
  finally
    Loading := False;
    FreeAndNil(aObj);
  end;
  lSeq_Cta.Enabled  := False;
  eSeq_Cta.Enabled  := False;
  lGrau_Cta.Enabled := False;
  eGrau_Cta.Enabled := False;
  lMask_Cta.Enabled := False;
  eMask_Cta.Enabled := False;
end;

procedure TCdPlanAccount.SetDscCta(const Value: string);
begin
  eDsc_Cta.Text := Value;
end;

procedure TCdPlanAccount.SetFlagAnlSnt(const Value: Boolean);
begin
  lFlag_Anl_Snt.ItemIndex := Ord(Value);
end;

procedure TCdPlanAccount.SetFlagID(const Value: TAccountType);
begin
  lFlag_ID.ItemIndex := Ord(Value);
end;

procedure TCdPlanAccount.SetFlagTCta(const Value: TAccountNat);
begin
  lFlag_TCta.ItemIndex := Ord(Value);
end;

procedure TCdPlanAccount.SetGrauCta(const Value: Integer);
begin
  eGrau_Cta.AsInteger := Value;
end;

procedure TCdPlanAccount.SetMaskCta(const Value: string);
begin
  eMask_Cta.Text := Value;
end;

procedure TCdPlanAccount.SetSeqCta(const Value: Integer);
begin
  eSeq_Cta.AsInteger := Value;
end;

procedure TCdPlanAccount.lFlag_TCtaClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with lFlag_TCta do
  begin
    lFlag_ID.Enabled := (ItemIndex = 0);
    if (lFlag_ID.Enabled) then
      FlagID := atOther;
  end;
end;

procedure TCdPlanAccount.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  pmGrid.Images := Dados.Image16;
  pmNewLevel.ImageIndex := 65; //19;
  inherited;
end;

procedure TCdPlanAccount.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then  exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['R_MASK_CTA'].AsString;
    1: CellText := Data^.DataRow.FieldByName['R_DSC_CTA'].AsString;
  end;
end;

procedure TCdPlanAccount.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
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

procedure TCdPlanAccount.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then  exit;
  FFkFinanceAccount  := Data^.DataRow.FieldByName['R_FK_PLANO_CONTAS'].AsInteger;
  Pk                 := Data^.DataRow.FieldByName['R_PK_PLANO_CONTAS'].AsInteger;
  pmNewLevel.Visible := (Data^.DataRow.FieldByName['R_FLAG_ANL_SNT'].AsInteger = 0);
end;

procedure TCdPlanAccount.tbInsertClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
  aTCt: TAccountNat;
  aAnS: Boolean;
  aFk ,
  aNiv,
  aLen,
  aSeq: Integer;
  aMsk: string;
begin
  aNiv := 0;
  aTCt := FlagTCta;
  aAnS := FlagAnlSnt;
  aSeq := 0;
  aFk  := FFkFinanceAccount;
  Data := nil;
  Node := nil;
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
        aSeq := Data^.DataRow.FieldByName['R_SEQ_CTA'].AsInteger;
        if (Data^.NodeType = tnFolder) then
        begin
          aFk := Data^.DataRow.FieldByName['R_PK_PLANO_CONTAS'].AsInteger;
          Inc(aNiv);
          aSeq := 0;
        end;
        aMsk := Data^.DataRow.FieldByName['R_MASK_CTA'].AsString;
      end;
    end;
  end;
  inherited;
  Inc(aSeq);
  Inc(aNiv);
  GrauCta    := aNiv;
  SeqCta     := aSeq;
  FlagTCta   := aTCt;
  FlagAnlSnt := aAnS;
  if (aNiv = 1) then
    MaskCta := IntToStr(aSeq)
  else
  begin
    if (Data <> nil) and (Data^.NodeType = tnFolder) then
      MaskCta := aMsk + '.' + IntToStr(aSeq)
    else
    begin
      Dec(aSeq);
      aLen := Length(IntToStr(aSeq));
      Delete(aMsk, (Length(aMsk) - aLen), aLen + 1);
      MaskCta := aMsk + '.' + IntToStr(SeqCta);
    end;
  end;
  FFkFinanceAccount := aFk;
end;

procedure TCdPlanAccount.pmNewLevelClick(Sender: TObject);
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

procedure TCdPlanAccount.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F2) then
  begin
    lSeq_Cta.Enabled  := True;
    eSeq_Cta.Enabled  := True;
    lGrau_Cta.Enabled := True;
    eGrau_Cta.Enabled := True;
    lMask_Cta.Enabled := True;
    eMask_Cta.Enabled := True;
    if eSeq_Cta.CanFocus then eSeq_Cta.SetFocus;
    Key := 0;
  end;
  if ((ssCtrl in Shift) and (Key = VK_INSERT)) and (ScrState in SCROLL_MODE) then
  begin
    pmNewLevel.Click;
    Key := 0;
  end;
  inherited;
end;

procedure TCdPlanAccount.vtListBeforeItemErase(Sender: TBaseVirtualTree;
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

procedure TCdPlanAccount.lFlag_Anl_SntClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  pmNewLevel.Visible := not FlagAnlSnt;
end;

initialization
  RegisterClass(TCdPlanAccount);

end.
