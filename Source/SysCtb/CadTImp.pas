unit CadTImp;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 10/07/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
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
  Dialogs, CadModel, StdCtrls, Mask, ToolEdit, CurrEdit, ExtCtrls, ProcUtils,
  ComCtrls, VirtualTrees, GridRow;

type
  TCdTypeTax = class(TfrmModel)
    pgMain: TPageControl;
    tsMessage: TTabSheet;
    tsFinance: TTabSheet;
    eMsg_Imp: TMemo;
    pData: TPanel;
    lFlag_Impst: TRadioGroup;
    lFlag_Dstc: TCheckBox;
    lFlag_Ret: TCheckBox;
    lFlag_Calc: TCheckBox;
    lDsc_Imps: TStaticText;
    eDsc_Imps: TEdit;
    lPk_Tipo_Impostos: TStaticText;
    ePk_Tipo_Impostos: TEdit;
    lRed_BasC: TStaticText;
    eRed_BasC: TCurrencyEdit;
    lFkPlanoContas__SalesCR: TStaticText;
    lFkPlanoContas__SalesDB: TStaticText;
    lFkPlanoContas__PurchCR: TStaticText;
    lFkPlanoContas__PurchDB: TStaticText;
    eFkPlanoContas__SalesCR: TComboBox;
    eFkPlanoContas__SalesDB: TComboBox;
    eFkPlanoContas__PurchCR: TComboBox;
    eFkPlanoContas__PurchDB: TComboBox;
    tsRanges: TTabSheet;
    vtList: TVirtualStringTree;
    lFlag_Alqt_Unica: TCheckBox;
    lFlag_Range: TCheckBox;
    procedure FkPlanoContasDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure eFkPlanoContasSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lFlag_RangeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure vtListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtListDblClick(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function  GetDscImps: string;
    function  GetFkPlanoContasPurcDB: Integer;
    function  GetFkPlanoContasPurchCR: Integer;
    function  GetFkPlanoContasSalesCR: Integer;
    function  GetFkPlanoContasSalesDB: Integer;
    function  GetFlagCalc: Boolean;
    function  GetFlagDstc: Boolean;
    function  GetFlagImpst: Integer;
    function  GetFlagAlqtUnica: Boolean;
    function  GetFlagRange: Boolean;
    function  GetFlagRet: Boolean;
    function  GetMsgImp: TStrings;
    function  GetPkTypeTax: Integer;
    function  GetTaxRanges: TList;
    function  GetRedBasC: Double;
    procedure SetDscImps(const Value: string);
    procedure SetFlagCalc(const Value: Boolean);
    procedure SetFlagDstc(const Value: Boolean);
    procedure SetFlagImpst(const Value: Integer);
    procedure SetFlagRet(const Value: Boolean);
    procedure SetMsgImp(const Value: TStrings);
    procedure SetPkTypeTax(const Value: Integer);
    procedure SetRedBasC(const Value: Double);
    procedure SetFkPlanoContasPurchCR(const Value: Integer);
    procedure SetFkPlanoContasPurchDB(const Value: Integer);
    procedure SetFkPlanoContasSalesCR(const Value: Integer);
    procedure SetFkPlanoContasSalesDB(const Value: Integer);
    procedure SetFlagAlqtUnica(const Value: Boolean);
    procedure SetFlagRange(const Value: Boolean);
    procedure SetTaxRanges(const Value: TList);
    procedure AddRangeNode(AData: TDataRow);
    procedure DeleteRangeNode(ANode: PVirtualNode);
    function  ValidateValuesOfRanges: Boolean;
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
    property  PkTypeTax           : Integer  read GetPkTypeTax            write SetPkTypeTax;
    property  DscImps             : string   read GetDscImps              write SetDscImps;
    property  FlagCalc            : Boolean  read GetFlagCalc             write SetFlagCalc;
    property  FlagRet             : Boolean  read GetFlagRet              write SetFlagRet;
    property  FlagDstc            : Boolean  read GetFlagDstc             write SetFlagDstc;
    property  FlagImpst           : Integer  read GetFlagImpst            write SetFlagImpst;
    property  FlagRange           : Boolean  read GetFlagRange            write SetFlagRange;
    property  FlagAlqtUnica       : Boolean  read GetFlagAlqtUnica        write SetFlagAlqtUnica;
    property  RedBasC             : Double   read GetRedBasC              write SetRedBasC;
    property  MsgImp              : TStrings read GetMsgImp               write SetMsgImp;
    property  TaxRanges           : TList    read GetTaxRanges            write SetTaxRanges;
    property  FkPlanoContasSalesCR: Integer  read GetFkPlanoContasSalesCR write SetFkPlanoContasSalesCR;
    property  FkPlanoContasSalesDB: Integer  read GetFkPlanoContasSalesDB write SetFkPlanoContasSalesDB;
    property  FkPlanoContasPurchCR: Integer  read GetFkPlanoContasPurchCR write SetFkPlanoContasPurchCR;
    property  FkPlanoContasPurchDB: Integer  read GetFkPlanoContasPurcDB  write SetFkPlanoContasPurchDB;
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysCtb, TSysFatAux, ProcType, FuncoesDB, DB, Funcoes;

{$R *.dfm}

{ TfrmTypeTax }

function TCdTypeTax.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  S := '';
  C := nil;
  Result := True;
  if (DscImps = '') then
  begin
    S := 'Campo Descrição deve conter um valor';
    C := eDsc_Imps;
  end;
  if (FlagRange) and ((TaxRanges = nil) or (TaxRanges.Count = 0)) then
  begin
    if (not tsRanges.TabVisible) then
      tsRanges.TabVisible := True;
    pgMain.ActivePage := tsRanges;
    C := vtList;
    S := 'Para gravar impostos do tipo "faixa de valores", ' + NL +
         'deve-se informar pelo menos uma faixa de valores com percentual';
  end;
  if (FlagRange) and (TaxRanges <> nil) and (TaxRanges.Count > 0) and
     (not ValidateValuesOfRanges) then
  begin
    C := vtList;
    S := '"faixa de valores" informada é inválida';
  end;
  if (FlagCalc) then
  begin
    if (FkPlanoContasSalesCR = 0) then
    begin
      C := eFkPlanoContas__SalesCR;
      S := 'Imposto deve informar uma conta do financeiro de crédito ' + NL +
           'para apuração do imposto nas vendas';
    end;
    if (FkPlanoContasSalesDB = 0) then
    begin
      C := eFkPlanoContas__SalesDB;
      S := 'Imposto deve informar uma conta do financeiro de débito ' + NL +
           'para apuração do imposto nas vendas';
    end;
    if (FkPlanoContasPurchCR = 0) then
    begin
      C := eFkPlanoContas__PurchCR;
      S := 'Imposto deve informar uma conta do financeiro de crédito ' + NL +
           'para apuração do imposto nas vendas';
    end;
    if (FkPlanoContasPurchDB = 0) then
    begin
      C := eFkPlanoContas__PurchDB;
      S := 'Imposto deve informar uma conta do financeiro de débito ' + NL +
           'para apuração do imposto nas vendas';
    end;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTypeTax.ClearControls;
begin
  Loading := True;
  try
//    Pk                   := 0;
    PkTypeTax            := 0;
    DscImps              := '';
    FlagCalc             := False;
    FlagRet              := False;
    FlagDstc             := False;
    FlagImpst            := 0;
    RedBasC              := 0;
    MsgImp               := nil;
    FkPlanoContasSalesCR := 0;
    FkPlanoContasSalesDB := 0;
    FkPlanoContasPurchCR := 0;
    FkPlanoContasPurchDB := 0;
    TaxRanges            := nil;
  finally
    Loading := False;
  end;
end;

function TCdTypeTax.GetDscImps: string;
begin
  Result := eDsc_Imps.Text;
end;

function TCdTypeTax.GetFkPlanoContasPurcDB: Integer;
begin
  with eFkPlanoContas__PurchDB do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
  end;
end;

function TCdTypeTax.GetFkPlanoContasPurchCR: Integer;
begin
  with eFkPlanoContas__PurchCR do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
  end;
end;

function TCdTypeTax.GetFkPlanoContasSalesCR: Integer;
begin
  with eFkPlanoContas__SalesCR do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
  end;
end;

function TCdTypeTax.GetFkPlanoContasSalesDB: Integer;
begin
  with eFkPlanoContas__SalesDB do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
  end;
end;

function TCdTypeTax.GetFlagCalc: Boolean;
begin
  Result := lFlag_Calc.Checked;
end;

function TCdTypeTax.GetFlagDstc: Boolean;
begin
  Result := lFlag_Dstc.Checked;
end;

function TCdTypeTax.GetFlagAlqtUnica: Boolean;
begin
  Result := lFlag_Alqt_Unica.Checked;
end;

function TCdTypeTax.GetFlagRange: Boolean;
begin
  Result := lFlag_Range.Checked;
end;

function TCdTypeTax.GetFlagImpst: Integer;
begin
  Result := lFlag_Impst.ItemIndex;
end;

function TCdTypeTax.GetFlagRet: Boolean;
begin
  Result := lFlag_Ret.Checked;
end;

function TCdTypeTax.GetMsgImp: TStrings;
begin
  Result := eMsg_Imp.Lines;
end;

function TCdTypeTax.GetPkTypeTax: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Impostos.Text, 0);
end;

function TCdTypeTax.GetTaxRanges: TList;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := TList.Create;
  with vtList do
  begin
    Node   := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         ((Data^.DataRow.FieldByName['PK_START_RANGE'].AsFloat >= 0) and
          (Data^.DataRow.FieldByName['PK_END_RANGE'].AsFloat > 0)) then
        Result.Add(Data^.DataRow);
      Node := GetNext(Node);
    end;
  end;
end;

function TCdTypeTax.GetRedBasC: Double;
begin
  Result := eRed_BasC.Value;
end;

procedure TCdTypeTax.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
//    eFkPlanoContas__SalesCR.Items.AddStrings(dmSysCtb.LoadFinanceAccounts(Ord(anPassive)));
//    eFkPlanoContas__SalesDB.Items.AddStrings(dmSysCtb.LoadFinanceAccounts(Ord(anIncome)));
//    eFkPlanoContas__PurchCR.Items.AddStrings(dmSysCtb.LoadFinanceAccounts(Ord(anIncome)));
//    eFkPlanoContas__PurchDB.Items.AddStrings(dmSysCtb.LoadFinanceAccounts(Ord(anActive)));
    ListLoaded := True;
  end;
end;

procedure TCdTypeTax.MoveDataToControls;
var
  M    : TStream;
begin
  Loading := True;
  M := TMemoryStream.Create;
  try
    with dmSysCtb.TypeTax[Pk] do
    begin
      PkTypeTax            := Pk;
      DscImps              := Taxes.FieldByName['DSC_IMPS'].AsString;
      FlagCalc             := Boolean(Taxes.FieldByName['FLAG_CALC'].AsInteger);
      FlagRet              := Boolean(Taxes.FieldByName['FLAG_RET'].AsInteger);
      FlagDstc             := Boolean(Taxes.FieldByName['FLAG_DSTC'].AsInteger);
      FlagImpst            := Taxes.FieldByName['FLAG_IMPST'].AsInteger;
      FlagAlqtUnica        := Boolean(Taxes.FieldByName['FLAG_ALQT_UNICA'].AsInteger);
      FlagRange            := Boolean(Taxes.FieldByName['FLAG_RANGE'].AsInteger);
      RedBasC              := Taxes.FieldByName['RED_BASC'].AsFloat;
      FkPlanoContasSalesCR := Accounts.FieldByName['FK_FINANCEIRO_CONTAS_OUT_CR'].AsInteger;
      FkPlanoContasSalesDB := Accounts.FieldByName['FK_FINANCEIRO_CONTAS_OUT_DB'].AsInteger;
      FkPlanoContasPurchCR := Accounts.FieldByName['FK_FINANCEIRO_CONTAS_IN_CR'].AsInteger;
      FkPlanoContasPurchDB := Accounts.FieldByName['FK_FINANCEIRO_CONTAS_IN_DB'].AsInteger;
      Taxes.FieldByName['MSG_IMP'].SaveToStream(M, buValue);
      M.Position           := 0;
      MsgImp.LoadFromStream(M);
      TaxRanges            := Ranges;
    end;
  finally
    FreeAndNil(M);
    Loading := False;
  end;
end;

procedure TCdTypeTax.SaveIntoDB;
var
  Value: TTaxes;
  M    : TStream;
begin
  M     := TMemoryStream.Create;
  Value := dmSysCtb.TypeTax[0];
  try
    Value.Taxes.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger  := Pk;
    Value.Taxes.FieldByName['DSC_IMPS'].AsString           := DscImps;
    Value.Taxes.FieldByName['FLAG_CALC'].AsInteger         := Ord(FlagCalc);
    Value.Taxes.FieldByName['FLAG_RET'].AsInteger          := Ord(FlagRet);
    Value.Taxes.FieldByName['FLAG_DSTC'].AsInteger         := Ord(FlagDstc);
    Value.Taxes.FieldByName['FLAG_ALQT_UNICA'].AsInteger   := Ord(FlagAlqtUnica);
    Value.Taxes.FieldByName['FLAG_RANGE'].AsInteger        := Ord(FlagRange);
    Value.Taxes.FieldByName['FLAG_IMPST'].AsInteger        := FlagImpst;
    Value.Taxes.FieldByName['RED_BASC'].AsFloat            := RedBasC;
    Value.Accounts.FieldByName['FK_FINANCEIRO_CONTAS_OUT_CR'].AsInteger := FkPlanoContasSalesCR;
    Value.Accounts.FieldByName['FK_FINANCEIRO_CONTAS_OUT_DB'].AsInteger := FkPlanoContasSalesDB;
    Value.Accounts.FieldByName['FK_FINANCEIRO_CONTAS_IN_CR'].AsInteger  := FkPlanoContasPurchCR;
    Value.Accounts.FieldByName['FK_FINANCEIRO_CONTAS_IN_DB'].AsInteger  := FkPlanoContasPurchDB;
    if (MsgImp.Text <> '') then
    begin
      MsgImp.SaveToStream(M);
      M.Position := 0;
      Value.Taxes.FieldByName['MSG_IMP'].LoadFromStream(M, buValue);
    end;
    Value.Ranges := TaxRanges;
    dmSysCtb.TypeTax[Ord(ScrState)] := Value;
    Pk := Value.Taxes.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
    if Assigned(OnUpdateRow) then OnUpdateRow(Self, Value.Taxes);
  finally
    FreeAndNil(M);
    FreeAndNil(Value.Taxes);
    FreeAndNil(Value.Ranges);
    Loading := False;
  end;
end;

procedure TCdTypeTax.SetDscImps(const Value: string);
begin
  eDsc_Imps.Text := Value;
end;

procedure TCdTypeTax.SetFkPlanoContasPurchCR(const Value: Integer);
var
  i: Integer;
begin
  with eFkPlanoContas__PurchCR do
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

procedure TCdTypeTax.SetFkPlanoContasPurchDB(const Value: Integer);
var
  i: Integer;
begin
  with eFkPlanoContas__PurchDB do
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

procedure TCdTypeTax.SetFkPlanoContasSalesCR(const Value: Integer);
var
  i: Integer;
begin
  with eFkPlanoContas__SalesCR do
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

procedure TCdTypeTax.SetFkPlanoContasSalesDB(const Value: Integer);
var
  i: Integer;
begin
  with eFkPlanoContas__SalesDB do
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

procedure TCdTypeTax.SetFlagCalc(const Value: Boolean);
begin
  lFlag_Calc.Checked := Value;
end;

procedure TCdTypeTax.SetFlagDstc(const Value: Boolean);
begin
  lFlag_Dstc.Checked := Value;
end;

procedure TCdTypeTax.SetFlagAlqtUnica(const Value: Boolean);
begin
  lFlag_Alqt_Unica.Checked := Value;
end;

procedure TCdTypeTax.SetFlagRange(const Value: Boolean);
begin
  lFlag_Range.Checked := Value;
  tsRanges.TabVisible := Value;
end;

procedure TCdTypeTax.SetFlagImpst(const Value: Integer);
begin
  lFlag_Impst.ItemIndex := Value;
end;

procedure TCdTypeTax.SetFlagRet(const Value: Boolean);
begin
  lFlag_Ret.Checked := Value;
end;

procedure TCdTypeTax.SetMsgImp(const Value: TStrings);
begin
  eMsg_Imp.Lines.Clear;
  if (Value <> nil) then
    eMsg_Imp.Lines.Assign(Value);
end;

procedure TCdTypeTax.SetPkTypeTax(const Value: Integer);
begin
  ePk_Tipo_Impostos.Text := IntToStr(Value);
end;

procedure TCdTypeTax.SetTaxRanges(const Value: TList);
var
  i   : Integer;
begin
  ReleaseTreeNodes(vtList);
  if (Value <> nil) then
  begin
    with vtList do
    begin
      BeginUpdate;
      try
        for i := 0 to Value.Count - 1 do
          AddRangeNode(TDataRow(Value.Items[i]));
      finally
        EndUpdate;
      end;
    end;
  end
  else
    AddRangeNode(nil);
end;

procedure TCdTypeTax.AddRangeNode(AData: TDataRow);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtList.AddChild(nil);
  if (Node <> nil) then
  begin
    Data := vtList.GetNodeData(Node);
    if (Data <> nil) then
    begin
      Data^.Level    := 0;
      Data^.Node     := Node;
      Data^.NodeType := tnData;
      if (AData <> nil) then
        Data^.DataRow := TDataRow.CreateAs(nil, AData)
      else
      begin
        Data^.DataRow  := TDataRow.Create(nil);
        Data^.DataRow.AddAs('PK_START_RANGE', 0.0, ftFloat, SizeOf(Double));
        Data^.DataRow.AddAs('PK_END_RANGE', 0.0, ftFloat, SizeOf(Double));
        Data^.DataRow.AddAs('ALQT_IMPST', 0.0, ftFloat, SizeOf(Double));
      end;
    end;
  end;
end;

procedure TCdTypeTax.SetRedBasC(const Value: Double);
begin
  eRed_BasC.Value := Value;
end;

procedure TCdTypeTax.FkPlanoContasDrawItem(Control: TWinControl;
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

procedure TCdTypeTax.eFkPlanoContasSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with TComboBox(Sender) do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) and
       (not TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) then
    begin
      ItemIndex := 0;
      Dados.DisplayHint(TComboBox(Sender), 'Você pode somente selecionar contas ' + NL +
        'que podem aceitar lançamentos');
    end;
  end;
end;

procedure TCdTypeTax.FormCreate(Sender: TObject);
begin
  vtList.NodeDataSize := SizeOf(TGridData);
  pgMain.ActivePageIndex := 0;
  inherited;
  OnCheckRecord := CheckRecord;
end;

procedure TCdTypeTax.lFlag_RangeClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (vtList.RootNodeCount > 0) and (not FlagRange) then
    ReleaseTreeNodes(vtList);
  tsRanges.TabVisible := FlagRange;
end;

procedure TCdTypeTax.FormDestroy(Sender: TObject);
begin
  inherited;
  ReleaseCombos(eFkPlanoContas__PurchCR, toObject);
  ReleaseCombos(eFkPlanoContas__PurchDB, toObject);
  ReleaseCombos(eFkPlanoContas__SalesCR, toObject);
  ReleaseCombos(eFkPlanoContas__SalesDB, toObject);
  ReleaseTreeNodes(vtList);
end;

function TCdTypeTax.ValidateValuesOfRanges: Boolean;
var
  Data       : TDataRow;
  i          : Integer;
  aStartRange,
  aEndRange  : Double;
begin
  Result      := True;
  aStartRange := 0.0;
  aEndRange   := 0.0;
  for i := 0 to TaxRanges.Count - 1 do
  begin
    Data := TaxRanges.Items[i];
    if (Data.FieldByName['PK_START_RANGE'].AsFloat >=
        Data.FieldByName['PK_END_RANGE'].AsFloat) then
      Result := False
    else
      if (i > 0) and (aStartRange >= Data.FieldByName['PK_START_RANGE'].AsFloat) then
        Result := False
      else
        if (aEndRange >= Data.FieldByName['PK_START_RANGE'].AsFloat) then
          Result := False;
    aStartRange := Data.FieldByName['PK_START_RANGE'].AsFloat;
    aEndRange   := Data.FieldByName['PK_START_RANGE'].AsFloat;
  end;
end;

procedure TCdTypeTax.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := FloatToStrF(Data^.DataRow.FieldByName['PK_START_RANGE'].AsFloat, ffNumber, 7, 2);
    1: CellText := FloatToStrF(Data^.DataRow.FieldByName['PK_END_RANGE'].AsFloat, ffNumber, 7, 2);
    2: CellText := FloatToStrF(Data^.DataRow.FieldByName['ALQT_IMPST'].AsFloat, ffNumber, 7, 4) + ' %';
  end;
end;

procedure TCdTypeTax.vtListNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PGridData;
const
  INV_FLOAT: Double = -9.99;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (StrToFloatDef(NewText, INV_FLOAT) = INV_FLOAT) then
  begin
    Dados.DisplayHint(Self, CalcTreeLinePos(vtList, Node, Column, ClientHeight),
      'Valor Inválido: Você deve digitar um valor entre 0 e 99,9999');
    // show Message of the invalid value
    exit;
  end;
  if (Sender.AbsoluteIndex(Node) > 0) and (Column = 2) and
     (ValidateValuesOfRanges) then
  begin
    Dados.DisplayHint(Self, CalcTreeLinePos(vtList, Node, Column, ClientHeight),
      'Faixa de valores Inválida: Você deve digitar o valor inicial menor ' + NL +
      'que o valor final em cada linha, sendo que o valor incial da linha ' + NL +
      'subsequente deve ser maior que o valor final da linha anterior', hiWarning,
      '', 10000);
    // show Message of the invalid range
    // SetFocus at start range...
    exit;
  end;
  case Column of
    0: Data^.DataRow.FieldByName['PK_START_RANGE'].AsFloat := StrToFloat(NewText);
    1: Data^.DataRow.FieldByName['PK_END_RANGE'].AsFloat   := StrToFloat(NewText);
    2: Data^.DataRow.FieldByName['ALQT_IMPST'].AsFloat     := StrToFloat(NewText);
  end;
end;

procedure TCdTypeTax.vtListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Data: PGridData;
  Column: TColumnIndex;
begin
  with vtList do
  begin
    if (FocusedNode = nil) then exit;
    Data := GetNodeData(FocusedNode);
    if (Data = nil) and (Data^.DataRow = nil) then exit;
    Column := FocusedColumn;
    case Key of
      VK_UP   :
        begin
          if (IsEditing) then EndEditNode;
          if ((Data^.DataRow.FieldByName['PK_START_RANGE'].AsFloat = 0) and
              ( Data^.DataRow.FieldByName['PK_END_RANGE'].AsFloat = 0)) and
              ( FocusedNode <> GetFirst) then
            DeleteRangeNode(vtList.FocusedNode);
        end;
      VK_DOWN :
        begin
          if (IsEditing) then EndEditNode;
          if (GetLast = FocusedNode) then
          begin
            AddRangeNode(nil);
            if (FocusedNode <> nil) then
              FocusedColumn := 0;
          end;
        end;
      VK_LEFT :
        begin
          if (IsEditing) then EndEditNode;
          if (Column > 0) then
            FocusedColumn := Column - 1
          else
            if (GetFirst <> FocusedNode) then
            begin
              FocusedNode           := GetPrevious(FocusedNode);
              FocusedColumn         := 2;
              Selected[FocusedNode] := True;
            end;
        end;
      VK_RIGHT:
        begin
          if (IsEditing) then EndEditNode;
          if (Column < 2) then
            FocusedColumn := Column + 1
          else
            if (GetLast <> FocusedNode) then
            begin
              FocusedNode           := GetNext(FocusedNode);
              FocusedColumn         := 0;
              Selected[FocusedNode] := True;
            end;
        end;
    else
      if (ssCtrl in Shift) and (Key = VK_DELETE) then
        DeleteRangeNode(FocusedNode);
    end;
  end;
end;

procedure TCdTypeTax.DeleteRangeNode(ANode: PVirtualNode);
var
  Data: PGridData;
begin
  with vtList do
  begin
    if (ANode <> nil) then
    begin
      Data := GetNodeData(ANode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        FreeAndNil(Data^.DataRow);
        Data^.Node := nil;
      end;
    end;
  end;
end;

procedure TCdTypeTax.vtListDblClick(Sender: TObject);
begin
  with vtList do
  begin
    if (RootNodeCount = 0) then
      AddRangeNode(nil);
  end;
end;

end.
