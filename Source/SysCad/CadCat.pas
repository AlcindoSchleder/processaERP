unit CadCat;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 18/05/2003 - DD/MM/YYYY                                     *}
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
  Dialogs, CadListModel, StdCtrls, ExtCtrls, VirtualTrees, ComCtrls, ToolWin,
  TSysCadAux, ProcUtils, GridRow;

type
  TCdCategoria = class(TfrmModelList)
    lPk_Categorias: TStaticText;
    ePk_Categorias: TEdit;
    eDsc_Cat: TEdit;
    lDsc_Cat: TStaticText;
    lFlag_Cat: TRadioGroup;
    lFk_Financeiro_Contas: TStaticText;
    eFk_Financeiro_Contas: TComboBox;
    lFk_Financeiro_Contas_Acm: TStaticText;
    eFk_Financeiro_Contas_Acm: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure eFk_Financeiro_ContasSelect(Sender: TObject);
    procedure lFlag_CatClick(Sender: TObject);
    procedure eFk_Financeiro_ContasDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
  private
    function  GetDscCat      : string;
    function  GetFlagCat     : TCategoryType;
    function  GetFkFinanceAcc: Integer;
    function  GetFkFinanceAccAcm: Integer;
    function  GetPkCategory  : Integer;
    procedure SetDscCat    (const Value: string);
    procedure SetFlagCat   (const Value: TCategoryType);
    procedure SetPkCategory(const Value: Integer);
    procedure SetFkFinanceAcc(const Value: Integer);
    procedure SetFkFinanceAccAcm(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
    procedure LoadAccounts(ACombo: TComboBox);
  public
    { Public declarations }
    property  PkCategory     : Integer       read GetPkCategory      write SetPkCategory;
    property  FkFinanceAcc   : Integer       read GetFkFinanceAcc    write SetFkFinanceAcc;
    property  FkFinanceAccAcm: Integer       read GetFkFinanceAccAcm write SetFkFinanceAccAcm;
    property  DscCat         : string        read GetDscCat          write SetDscCat;
    property  FlagCat        : TCategoryType read GetFlagCat         write SetFlagCat;
  end;

implementation

uses Dado, ProcType, mSysCad, CadArqSql, TSysFatAux, Funcoes;

{$R *.dfm}

{ TCdCategoria }

procedure TCdCategoria.ClearControls;
begin
  Loading := True;
  try
    PkCategory      := 0;
    DscCat          := '';
    FlagCat         := ctCustomer;
    FkFinanceAcc    := 0;
    FkFinanceAccAcm := 0;
  finally
    Loading := False;
  end;
end;

function TCdCategoria.GetDscCat: String;
begin
  Result := eDsc_Cat.Text;
end;

function TCdCategoria.GetFlagCat: TCategoryType;
begin
  Result := TCategoryType(lFlag_Cat.ItemIndex);
end;

function TCdCategoria.GetFkFinanceAcc: Integer;
begin
  Result := 0;
  with eFk_Financeiro_Contas do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
end;

function TCdCategoria.GetFkFinanceAccAcm: Integer;
begin
  Result := 0;
  with eFk_Financeiro_Contas_Acm do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
end;

function TCdCategoria.GetPkCategory: Integer;
begin
  Result := StrToIntDef(ePK_Categorias.Text,0);
end;

procedure TCdCategoria.SetDscCat(const Value: String);
begin
  eDsc_Cat.Text := Value;
end;

procedure TCdCategoria.SetFlagCat(const Value: TCategoryType);
begin
  lFlag_Cat.ItemIndex := Ord(Value);
end;

procedure TCdCategoria.SetPkCategory(const Value: Integer);
begin
  ePk_Categorias.Text := IntToStr(Value);
end;

procedure TCdCategoria.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdCategoria.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysCad do
  begin
    if qrCategory.Active then qrCategory.Close;
    qrCategory.SQL.Clear;
    qrCategory.SQL.Add(SqlCategorias);
    Dados.StartTransaction(qrCategory);
    try
      if not qrCategory.Active then qrCategory.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(nil, qrCategory, False);
      while not qrCategory.Eof do
      begin
        AddDataNode(nil, qrCategory);
        qrCategory.Next;
      end;
    finally
      if qrCategory.Active then qrCategory.Close;
      Dados.CommitTransaction(qrCategory);
    end;
  end;
  if vtList.RootNodeCount > 0 then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.GetFirst] := True;
  end;
end;

procedure TCdCategoria.MoveDataToControls;
var
  aItem: TCategory;
begin
  Loading := True;
  try
    aItem           := dmSysCad.Category[Pk];
    PkCategory      := aItem.PkCategory;
    DscCat          := aItem.DscCat;
    FlagCat         := aItem.FlagCat;
    FkFinanceAcc    := aItem.FkFinanceAcc;
    FkFinanceAccAcm := aItem.FkFinanceAccAcm;
  finally
    FreeAndNil(aItem);
    Loading := False;
  end;
end;

procedure TCdCategoria.SaveIntoDB;
var
  aItem: TCategory;
begin
  aItem                   := TCategory.Create(nil);
  try
    aItem.PkCategory      := PkCategory;
    aItem.DscCat          := DscCat;
    aItem.FlagCat         := FlagCat;
    aItem.FkFinanceAcc    := FkFinanceAcc;
    aItem.FkFinanceAccAcm := FkFinanceAccAcm;
    dmSysCad.Category[Ord(ScrState)] := aItem;
    if (FocusedRow <> nil) then
    begin
      FocusedRow.FieldByName['PK_CATEGORIAS'].AsInteger := aItem.PkCategory;
      FocusedRow.FieldByName['DSC_CAT'].asString        := DscCat;
    end;
    PK := aItem.PkCategory;
  finally
    FreeAndNil(aItem);
  end;
end;

procedure TCdCategoria.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

function TCdCategoria.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C : TControl;
  S : String;
begin
  Result := True;
  C := nil;
  if DscCat = '' then
  begin
    S := 'Campo Descrição deve ser preenchido!';
    C := eDsc_Cat;
  end;
  with eFk_Financeiro_Contas do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) and
       (TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) then
    begin
      C := eFk_Financeiro_Contas;
      S := 'Você somente pode selecionar contas sintéticas neste campo';
    end;
  if S <> '' then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdCategoria.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data : PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then Exit;
  SearchField := 'DSC_CAT';
  PK := Data^.DataRow.FieldByName['PK_CATEGORIAS'].AsInteger;
end;

procedure TCdCategoria.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data : PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Column <> 0) then Exit;
  CellText := Data^.DataRow.FieldByName['DSC_CAT'].AsString;
end;

procedure TCdCategoria.eFk_Financeiro_ContasSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Financeiro_Contas do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) and
       (TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) then
      Dados.DisplayHint(eFk_Financeiro_Contas, 'Você somente pode selecionar ' + NL +
        'contas sintéticas neste campo');
end;

procedure TCdCategoria.SetFkFinanceAcc(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Financeiro_Contas do
  begin
    ItemIndex := 0;
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

procedure TCdCategoria.SetFkFinanceAccAcm(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Financeiro_Contas_Acm do
  begin
    ItemIndex := 0;
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

procedure TCdCategoria.lFlag_CatClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  LoadAccounts(eFk_Financeiro_Contas);
  LoadAccounts(eFk_Financeiro_Contas_Acm);
end;

procedure TCdCategoria.eFk_Financeiro_ContasDrawItem(Control: TWinControl;
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
      begin
        Delete(aItmStr, Length(aItmStr), 1);
      end;
      aItmStr := aItmStr + '...'
    end;
    TextOut(Rect.Left + aOffSet, Rect.Top, aItmStr);
    TextOut(Rect.Left + 200, Rect.Top, aStr);
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

procedure TCdCategoria.LoadAccounts(ACombo: TComboBox);
begin
  ReleaseCombos(ACombo, toObject);
  ACombo.Enabled := (lFlag_Cat.ItemIndex < 4);
  case lFlag_Cat.ItemIndex of
    0: ACombo.Items.AddStrings(dmSysCad.LoadFinanceAccounts(anActive)); // Load Active Accounts
    1: ACombo.Items.AddStrings(dmSysCad.LoadFinanceAccounts(anPassive)); // Load Passive Accounts
    2: ACombo.Items.AddStrings(dmSysCad.LoadFinanceAccounts(anExpense, -1)); // Load Expense Accounts
    3: ACombo.Items.AddStrings(dmSysCad.LoadFinanceAccounts(anPassive)); // Load Passive Accounts
    4: ;
    5: ;
  end;
  if (not ACombo.Enabled) then
    ACombo.ItemIndex := 0;
end;

initialization
  RegisterClass(TCdCategoria);

end.
