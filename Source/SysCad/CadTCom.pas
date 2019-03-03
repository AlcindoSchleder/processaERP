unit CadTCom;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 28/12/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@processa.org                                       *}
{*            http://www.processa.org                                    *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ExtCtrls,
  Mask, ToolEdit, CurrEdit, ProcUtils, GridRow, TSysCadAux;

type
  TCdTypeCom = class(TfrmModelList)
    shTitle: TShape;
    lTitle: TLabel;
    lPk_Tipo_Comisoes: TStaticText;
    ePk_Tipo_Comisoes: TEdit;
    eDsc_TCom: TEdit;
    lDsc_TCom: TStaticText;
    lFk_Financeiro_Contas__CR: TStaticText;
    eFk_Financeiro_Contas__CR: TComboBox;
    lPerc_Com: TStaticText;
    ePerc_Com: TCurrencyEdit;
    vtRanges: TVirtualStringTree;
    eFk_Financeiro_Contas__DB: TComboBox;
    lFk_Financeiro_Contas__DB: TStaticText;
    lFlagTCad: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure TreeComboDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure eFk_Financeiro_Contas__CRSelect(Sender: TObject);
    procedure eFk_Financeiro_Contas__DBSelect(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtRangesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtRangesBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtRangesGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtRangesInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtRangesChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtRangesChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure FormDestroy(Sender: TObject);
    procedure vtRangesEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vtRangesNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure vtRangesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtRangesFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
  private
    { Private declarations }
    function  GetDscTCom: string;
    function  GetFkFinanceiroContasCR: Integer;
    function  GetFkFinanceiroContasDB: Integer;
    function  GetFlagTCad: TOwnerComission;
    function  GetPercCom: Double;
    function  GetPkTypeComission: Integer;
    function  GetReductionRanges: TList;
    function  AddNewDataNode(ANode: PVirtualNode; AData: TDataRow): PVirtualNode;
    procedure DeleteDataNode(ANode: PVirtualNode);
    procedure LoadFinanceCombos(ACombo: TComboBox; const AAccountType: smallint);
    procedure SetDscTCom(const Value: string);
    procedure SetFkFinanceiroContasCR(const Value: Integer);
    procedure SetFkFinanceiroContasDB(const Value: Integer);
    procedure SetFlagTCad(const Value: TOwnerComission);
    procedure SetPercCom(const Value: Double);
    procedure SetPkTypeComission(const Value: Integer);
    procedure SetReductionRanges(const Value: TList);
  protected
    { Protected declarations }
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
  public
    { Public declarations }
    property  PkTypeComission     : Integer         read GetPkTypeComission      write SetPkTypeComission;
    property  FkFinanceiroContasCR: Integer         read GetFkFinanceiroContasCR write SetFkFinanceiroContasCR;
    property  FkFinanceiroContasDB: Integer         read GetFkFinanceiroContasDB write SetFkFinanceiroContasDB;
    property  FlagTCad            : TOwnerComission read GetFlagTCad             write SetFlagTCad;
    property  DscTCom             : string          read GetDscTCom              write SetDscTCom;
    property  PercCom             : Double          read GetPercCom              write SetPercCom;
    property  ReductionRanges     : TList           read GetReductionRanges      write SetReductionRanges;
  end;

implementation

uses Dado, mSysCad, TSysFatAux, Funcoes, FuncoesDB, ProcType, DB,
  CadArqSql;

{$R *.dfm}

const
//  TComissionRanges     = (crAverangePeriod, crDiscounts)
  RANGES_DESCR: array [TComissionRanges] of string =
                  ('Prazo Médio', 'Descontos');

function TCdTypeCom.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C : TControl;
  S : String;
begin
  Result := True;
  C := nil;
  if (DscTCom = '') then
  begin
    S := 'Campo Descrição deve ser preenchido!';
    C := eDsc_TCom;
  end;
  with eFk_Financeiro_Contas__CR do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
    begin
      C := eFk_Financeiro_Contas__CR;
      if (TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) and
         (FlagTCad = ocRepresentant) then
        S := 'Para representante, você somente pode selecionar contas sintéticas!';
      if (not TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) and
         (FlagTCad = ocVendor) then
        S := 'Para Vendedor, você somente pode selecionar contas analíticas!';
    end;
  with eFk_Financeiro_Contas__DB do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) and
       (not TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) then
    begin
      C := eFk_Financeiro_Contas__DB;
      S := 'Você somente pode selecionar contas analíticas!';
    end;
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTypeCom.ClearControls;
begin
  Loading := True;
  try
    FlagTCad             := ocRepresentant;
    FkFinanceiroContasCR := 0;
    FkFinanceiroContasDB := 0;
    DscTCom              := '';
    PercCom              := 0.0;
    PkTypeComission      := 0;
    ReductionRanges      := nil;
  finally
    Loading := False;
  end;
end;

procedure TCdTypeCom.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

function TCdTypeCom.GetDscTCom: string;
begin
  Result := eDsc_TCom.Text;
end;

function TCdTypeCom.GetFkFinanceiroContasCR: Integer;
begin
  with eFk_Financeiro_Contas__CR do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
  end;
end;

function TCdTypeCom.GetFkFinanceiroContasDB: Integer;
begin
  with eFk_Financeiro_Contas__DB do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
  end;
end;

function  TCdTypeCom.GetFlagTCad: TOwnerComission;
begin
  Result := TOwnerComission(lFlagTCad.ItemIndex);
end;

function TCdTypeCom.GetPercCom: Double;
begin
  Result := ePerc_Com.Value;
end;

function TCdTypeCom.GetPkTypeComission: Integer;
begin
  Result := StrToInt(ePk_Tipo_Comisoes.Text);
end;

function TCdTypeCom.GetReductionRanges: TList;
begin
  Result := nil;
end;

procedure TCdTypeCom.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    LoadFinanceCombos(eFk_Financeiro_Contas__CR, 1);
    LoadFinanceCombos(eFk_Financeiro_Contas__DB, 3);
    ListLoaded := True;
  end;
end;

procedure TCdTypeCom.LoadList(Sender: TObject);
begin
  with dmSysCad, vtList do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlTypeComissions);
    Dados.StartTransaction(qrSqlAux);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        AddDataNode(nil, qrSqlAux);
        qrSqlAux.Next;
      end;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

procedure TCdTypeCom.MoveDataToControls;
var
  aItem: TDataRow;
begin
  Loading := True;
  try
    aItem                := dmSysCad.TypeComission[Pk];
    FlagTCad             := TOwnerComission(aItem.FieldByName['FLAG_TCOM'].AsInteger);
    FkFinanceiroContasCR := aItem.FieldByName['FK_FINANCEIRO_CONTAS__CR'].AsInteger;
    FkFinanceiroContasDB := aItem.FieldByName['FK_FINANCEIRO_CONTAS__DB'].AsInteger;
    DscTCom              := aItem.FieldByName['DSC_COM'].AsString;
    PercCom              := aItem.FieldByName['PERC_COM'].AsFloat;
    PkTypeComission      := aItem.FieldByName['FK_TIPO_COMISSOES'].AsInteger;
    ReductionRanges      := dmSysCad.ComRanges[Pk];
  finally
    FreeAndNil(aItem);
    Loading := False;
  end;
end;

procedure TCdTypeCom.SaveIntoDB;
var
  aItem: TDataRow;
begin
  aItem := TDataRow.Create(nil);
  try
    aItem.AddAs('FK_TIPO_COMISSOES', Pk, ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_TCOM', Ord(FlagTCad), ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_FINANCEIRO_CONTAS__CR', FkFinanceiroContasCR, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_FINANCEIRO_CONTAS__DB', FkFinanceiroContasDB, ftInteger, SizeOf(Integer));
    aItem.AddAs('DSC_COM', DscTCom, ftString, Length(DscTCom) + 1);
    aItem.AddAs('PERC_COM', PercCom, ftFloat, SizeOf(Double));
    dmSysCad.TypeComission[Ord(ScrState)] := aItem;
    dmSysCad.ComRanges[aItem.FieldByName['FK_TIPO_COMISSOES'].AsInteger];
    if (FocusedRow <> nil) then
    begin
      FocusedRow.FieldByName['FK_TIPO_COMISSOES'].AsInteger := aItem.FieldByName['FK_TIPO_COMISSOES'].AsInteger;
      FocusedRow.FieldByName['DSC_COM'].AsString            := DscTCom;
    end;
    Pk := aItem.FieldByName['FK_TIPO_COMISSOES'].AsInteger;
  finally
    FreeAndNil(aItem);
  end;
end;

procedure TCdTypeCom.SetDscTCom(const Value: string);
begin
  eDsc_TCom.Text := Value;
end;

procedure TCdTypeCom.SetFkFinanceiroContasCR(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Financeiro_Contas__CR do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Value = TClassification(Items.Objects[i]).Pk) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTypeCom.SetFkFinanceiroContasDB(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Financeiro_Contas__DB do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Value = TClassification(Items.Objects[i]).Pk) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTypeCom.SetFlagTCad(const Value: TOwnerComission);
begin
  lFlagTCad.ItemIndex := Ord(Value);
end;

procedure TCdTypeCom.SetPercCom(const Value: Double);
begin
  ePerc_Com.Value := Value;
end;

procedure TCdTypeCom.SetPkTypeComission(const Value: Integer);
begin
  ePk_Tipo_Comisoes.Text := IntToStr(Value);
end;

procedure TCdTypeCom.SetReductionRanges(const Value: TList);
var
  i: Integer;
  Node: PVirtualNode;
  Flag: smallint;
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  Flag := -1;
  ReleaseTreeNodes(vtRanges);
  Node := nil;
  for i := 0 to Value.Count - 1 do
  begin
    if (Flag <> TDataRow(Value.Items[i]).FieldByName['PK_COMISSOES_REDUCOES'].AsInteger) then
      Node := AddNewDataNode(nil, TDataRow(Value.Items[i]))
    else
      AddNewDataNode(Node, TDataRow(Value.Items[i]));
    Flag := TDataRow(Value.Items[i]).FieldByName['PK_COMISSOES_REDUCOES'].AsInteger;
  end;
end;

function TCdTypeCom.AddNewDataNode(ANode: PVirtualNode; AData: TDataRow): PVirtualNode;
var
  Data: PGridData;
begin
  with vtRanges do
  begin
    Result := AddChild(ANode);
    if (Result <> nil) then
    begin
      Data := GetNodeData(Result);
      if (Data <> nil) then
      begin
        if (AData = nil) then
          Data^.DataRow  := TDataRow.Create(vtRanges)
        else
          Data^.DataRow  := TDataRow.CreateAs(vtRanges, AData);
        Data^.Level      := GetNodeLevel(Result);
        Data^.Node       := Result;
        if (Data^.Level = 0) then
          Data^.NodeType := tnFolder
        else
          Data^.NodeType := tnData;
        if (AData = nil) then
        begin
          Data^.DataRow.AddAs('FK_TIPO_COMISSOES', 0, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('PK_COMISSOES_REDUCOES', 0, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('DSC_RED', 0, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('PK_COMISSOES_FAIXAS', 0, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('VLR_INI', 0.0, ftFloat, SizeOf(Double));
          Data^.DataRow.AddAs('VLR_FIN', 0.0, ftFloat, SizeOf(Double));
          Data^.DataRow.AddAs('PERC_RED', 0.0, ftFloat, SizeOf(Double));
        end
        else
        begin
          Data^.DataRow.FieldByName['FK_TIPO_COMISSOES'].AsInteger     := AData.FieldByName['FK_TIPO_COMISSOES'].AsInteger;
          Data^.DataRow.FieldByName['PK_COMISSOES_REDUCOES'].AsInteger := AData.FieldByName['PK_COMISSOES_REDUCOES'].AsInteger;
          Data^.DataRow.FieldByName['DSC_RED'].AsString                := AData.FieldByName['DSC_RED'].AsString;
          Data^.DataRow.FieldByName['PK_COMISSOES_FAIXAS'].AsInteger   := AData.FieldByName['PK_COMISSOES_FAIXAS'].AsInteger;
          Data^.DataRow.FieldByName['VLR_INI'].AsFloat                 := AData.FieldByName['VLR_INI'].AsFloat;
          Data^.DataRow.FieldByName['VLR_FIN'].AsFloat                 := AData.FieldByName['VLR_FIN'].AsFloat;
          Data^.DataRow.FieldByName['PERC_RED'].AsFloat                := AData.FieldByName['PERC_RED'].AsFloat;
        end;
      end;
    end;
  end;
end;

procedure TCdTypeCom.DeleteDataNode(ANode: PVirtualNode);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (ANode = nil) or (not vtRanges.HasChildren[ANode]) then exit;
  Node := vtRanges.GetFirstChild(ANode);
  while ((Node <> nil) or (vtRanges.GetNodeLevel(Node) > 0)) do
  begin
    Data := vtRanges.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      Data^.DataRow.Free;
      Data^.DataRow := nil;
      Data^.Level   := 0;
      Data^.Node    := nil;
    end;
    Node := vtRanges.GetNext(Node)
  end;
  vtRanges.DeleteChildren(ANode, True);
end;

procedure TCdTypeCom.TreeComboDrawItem(Control: TWinControl;
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

procedure TCdTypeCom.eFk_Financeiro_Contas__CRSelect(Sender: TObject);
var
  S: string;
begin
  S := '';
  ChangeGlobal(Sender);
  with eFk_Financeiro_Contas__CR do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
    begin
       if (TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) and
          (FlagTCad = ocRepresentant) then
         S := 'Para representante, você somente pode selecionar contas sintéticas!';
       if (not TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) and
          (FlagTCad = ocVendor) then
         S := 'Para Vendedor, você somente pode selecionar contas analíticas!';
    end;
  if (S <> '') then
   Dados.DisplayHint(eFk_Financeiro_Contas__CR, S);
end;

procedure TCdTypeCom.LoadFinanceCombos(ACombo: TComboBox;
  const AAccountType: smallint);
begin
  if (ACombo = nil) or (AAccountType < 0) or (AAccountType > 5) then exit;
  ReleaseCombos(ACombo, toObject);
  ACombo.Items.AddStrings(dmSysCad.LoadFinanceAccounts(TAccountNat(AAccountType), -1));
end;

procedure TCdTypeCom.eFk_Financeiro_Contas__DBSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Financeiro_Contas__CR do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) and
       (not TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) then
      Dados.DisplayHint(eFk_Financeiro_Contas__CR, 'Você somente pode selecionar contas analíticas!');
end;

procedure TCdTypeCom.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_COMISSOES'].AsInteger;
end;

procedure TCdTypeCom.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_COM'].AsString;
end;

procedure TCdTypeCom.vtRangesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    if (Column = 0) then
      CellText := Data^.DataRow.FieldByName['DSC_RED'].AsString
    else
      CellText := ' '
  else
    case Column of
      0: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_INI'].AsFloat, ffNumber, 7, Dados.DecimalPlaces);
      1: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_FIN'].AsFloat, ffNumber, 7, Dados.DecimalPlaces);
      2: CellText := FloatToStrF(Data^.DataRow.FieldByName['PERC_COM'].AsFloat, ffNumber, 7, Dados.DecimalPlaces);
    end;
end;

procedure TCdTypeCom.vtRangesBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if (Node = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    ItemColor := clSkyBlue
  else
    ItemColor := clInfoBk;
  EraseAction := eaColor;
end;

procedure TCdTypeCom.vtRangesGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TGridData);
end;

procedure TCdTypeCom.vtRangesInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  if (Sender.GetNodeLevel(Node) > 0) then
  begin
    Node.CheckType := ctCheckBox;
    Data := Sender.GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    if (Data^.DataRow.FieldByName['PK_COMISSOES_FAIXAS'].AsInteger > 0) then
      Node.CheckState := csCheckedNormal;
  end;
end;

procedure TCdTypeCom.vtRangesChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
begin
  Allowed := True;
end;

procedure TCdTypeCom.vtRangesChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Node.CheckState = csCheckedNormal) and (not Sender.HasChildren[Node]) then
    AddNewDataNode(Node, nil);
  if (Node.CheckState = csUnCheckedNormal) and (Sender.HasChildren[Node]) then
    DeleteDataNode(Node);
end;

procedure TCdTypeCom.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtRanges);
  inherited;
end;

procedure TCdTypeCom.vtRangesEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  if (Node = nil) then exit;
  Allowed := (Sender.GetNodeLevel(Node) = 1);
  if (Allowed) then ChangeGlobal(Sender);
end;

procedure TCdTypeCom.vtRangesNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data : PGridData;
  S    : string;
  Value: Double;
  procedure DisplayColumnWarning;
  var
    R: TRect;
  begin
    R := Sender.GetDisplayRect(Node, Column, False);
    R.BottomRight.Y := R.BottomRight.Y + (ClientHeight - vtList.Height -
                       Integer(TVirtualStringTree(Sender).DefaultNodeHeight));
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight, S);
  end;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if ((StrToFloatDef(NewText, -1) < 0) or
     ((Column = 2) and (StrToFloatDef(NewText, -1) > 99.9999))) then
  begin
    S := 'O valor neste campo deve ser um percentual entre 0,00 e 99,9999';
    DisplayColumnWarning;
    exit;
  end;
  Value := StrToFloat(NewText);
  case Column of
    0: Data^.DataRow.FieldByName['VLR_INI'].AsFloat  := Value;
    1: Data^.DataRow.FieldByName['VLR_FIN'].AsFloat  := Value;
    2: Data^.DataRow.FieldByName['PERC_COM'].AsFloat := Value;
  end;
end;

procedure TCdTypeCom.vtRangesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node: PVirtualNode;
  Data: PGridData;
  aCol: Integer;
  procedure DeleteANode;
  begin
    if (Node = nil) then exit;
    Data := TVirtualStringTree(Sender).GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    Data^.Level := 0;
    Data^.Node  := nil;
    FreeAndNil(Data^.DataRow);
    TVirtualStringTree(Sender).DeleteNode(Node);
  end;
begin
  with TVirtualStringTree(Sender) do
  begin
    Node := FocusedNode;
    if (Node = nil) then exit;
    Data := GetNodeData(Node);
    if (Data = nil) and (Data^.DataRow = nil) then exit;
    aCol := vtList.FocusedColumn;
    if (aCol = 2) and (Key = VK_RETURN) then
      Key := VK_DOWN;
    case Key of
      VK_UP   : if (RootNodeCount > 1) then
                  if (GetFirst = Node) then
                    FocusedNode := GetLast
                  else
                    if (Data^.DataRow.FieldByName['VLR_INI'].AsFloat = 0) and
                       (Data^.DataRow.FieldByName['VLR_FIN'].AsFloat = 0) and
                       (Data^.DataRow.FieldByName['PERC_COM'].AsFloat = 0) then
                      DeleteANode;
      VK_DOWN : if (Data^.DataRow.FieldByName['VLR_INI'].AsFloat = 0) and
                   (Data^.DataRow.FieldByName['VLR_FIN'].AsFloat = 0) and
                   (Data^.DataRow.FieldByName['PERC_COM'].AsFloat = 0) then
                  if (RootNodeCount > 1) then
                    DeleteANode
                  else
                    Data^.DataRow.ClearFieldValues
                else
                  if (GetLast = Node) then
                    AddNewDataNode(Node.Parent, Data^.DataRow)
                  else
                    if (GetNodeLevel(GetNext(Node)) = 0) then
                      AddNewDataNode(Node.Parent, Data^.DataRow);
      VK_RETURN: begin
                   if (FocusedColumn < 4) then
                     FocusedColumn := FocusedColumn + 1
                   else
                     FocusedColumn := 0;
                   EditNode(FocusedNode, FocusedColumn);
                 end;
    else
      if (not (ssShift in Shift)) and (ssCtrl in Shift) and (Key = VK_DELETE) then
        DeleteANode;
    end;
  end;
end;

procedure TCdTypeCom.vtRangesFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  if (NewNode = nil) then exit;
  Allowed := (Sender.GetNodeLevel(NewNode) > 0);
  if (not Allowed) and (OldNode <> nil) and (Sender.FocusedNode <> nil) then
    Sender.FocusedNode := OldNode;
end;

initialization
  RegisterClass(TCdTypeCom);

end.
