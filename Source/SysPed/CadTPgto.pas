unit CadTPgto;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 18/04/2006 - DD/MM/YYYY                                      *}
{* Modified:                                                             *}
{* Version: 2.0.0.0                                                      *}
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
  Dialogs, VirtualTrees, StdCtrls, ExtCtrls, ProcUtils, TSysPedAux, Mask,
  ToolEdit, CurrEdit, ComCtrls, GridRow, Buttons, CadModel;

type
  TCdTipoPgtos = class(TfrmModel)
    pTitle: TPanel;
    eDsc_TPg: TEdit;
    lDsp_Fin: TStaticText;
    ePk_Tipo_Pagamentos: TEdit;
    lPk_Tipo_Pagamentos: TStaticText;
    lDsc_TPg: TStaticText;
    lQtd_Par: TStaticText;
    eQtd_Par: TCurrencyEdit;
    eDsp_Fin: TCurrencyEdit;
    vtIntervals: TVirtualStringTree;
    pgParameters: TPageControl;
    tsParams: TTabSheet;
    tsPaymentWays: TTabSheet;
    lFlag_TVda: TRadioGroup;
    lFlag_TInt: TRadioGroup;
    lFlag_Data_Base: TRadioGroup;
    lFlag_Bloq: TCheckBox;
    vtPaymentWay: TVirtualStringTree;
    tsPgtWayDetail: TTabSheet;
    eFk_Finalizadoras: TPanel;
    lFk_Financeiro_Contas: TStaticText;
    lFk_Finalizadoras: TStaticText;
    eFk_Financeiro_Contas: TComboBox;
    sbPgtWayOk: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure vtIntervalsEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vtIntervalsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtIntervalsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtIntervalsNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure vtPaymentWayEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vtPaymentWayGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtPaymentWayChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtPaymentWayChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure sbPgtWayOkClick(Sender: TObject);
    procedure vtPaymentWayInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtPaymentWayGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtPaymentWayPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtPaymentWayBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure eFk_Financeiro_ContasDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    FFkGroupMovim: Integer;
    FDscGmov     : string;
    FFlagES: TInOut;
    FActivePaymentWay: TDataRow;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetFkFinaceAccount: Integer;
    function  GetDscTPgt: string;
    function  GetFlagDtaBase: TBaseDate;
    function  GetFlagBlock: Boolean;
    function  GetFlagTInt: TIntervalPay;
    function  GetFlagTVda: TTypeSale;
    function  GetPkTypePayment: Integer;
    function  GetQtdPar: Integer;
    function  GetIntervals: TList;
    procedure SetDscTPgt(const Value: string);
    procedure SetFkGroupMovim(const Value: Integer);
    procedure SetFlagDtaBase(const Value: TBaseDate);
    procedure SetFlagBlock(const Value: Boolean);
    procedure SetFlagTInt(const Value: TIntervalPay);
    procedure SetFLagTVda(const Value: TTypeSale);
    procedure SetPkTypePayment(const Value: Integer);
    procedure SetQtdPar(const Value: Integer);
    procedure LoadPaymentWay;
    procedure LoadFinanceAccouts;
    procedure SetIntervals(const Value: TList);
    procedure InsertBlankNode;
    procedure SetFkFinaceAccount(const Value: Integer);
    function GetDspFin: Double;
    procedure SetDspFin(const Value: Double);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    procedure ChangeState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
  public
    { Public declarations }
    property FlagES          : TInOut       read FFlagES            write FFlagES;
    property FkGroupMovim    : Integer      read FFkGroupMovim      write SetFkGroupMovim;
    property FkFinanceAccount: Integer      read GetFkFinaceAccount write SetFkFinaceAccount;
    property PkTypePayment   : Integer      read GetPkTypePayment   write SetPkTypePayment;
    property DscTPgt         : string       read GetDscTPgt         write SetDscTPgt;
    property FlagDtaBase     : TBaseDate    read GetFlagDtaBase     write SetFlagDtaBase;
    property FlagTInt        : TIntervalPay read GetFlagTInt        write SetFlagTInt;
    property FlagBlock       : Boolean      read GetFlagBlock       write SetFlagBlock;
    property FlagTVda        : TTypeSale    read GetFlagTVda        write SetFLagTVda;
    property DspFin          : Double       read GetDspFin          write SetDspFin;
    property QtdPar          : Integer      read GetQtdPar          write SetQtdPar;
    property DscGmov         : string       read FDscGmov           write FDscGmov;
    property Intervals       : TList        read GetIntervals       write SetIntervals;
    property ActivePaymentWay: TDataRow     read FActivePaymentWay  write FActivePaymentWay;
  end;

implementation

uses Dado, mSysPed, procType, Funcoes, FuncoesDB, DB, TSysFatAux, PedArqSql;

{$R *.dfm}

{ TCdTipoPgtos }

const
  MAP_OPERATOR: array[0..3] of char = ('*', '%', '+', '/');

function TCdTipoPgtos.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
  aQtdParc: Integer;
begin
  Result := True;
  S := '';
  C := nil;
  aQtdParc := QtdPar;
  if (aQtdParc <> QtdPar) then
  begin
    C := eQtd_Par;
    S := 'Campo quantidade de parcelas não está em conformidade ' + NL +
         'com o campo lista de prazos';
  end;
  if (FlagTVda = tsPeriod) then
  begin
    if (QtdPar = 0) then
    begin
      C := eQtd_Par;
      S := 'Campo quantidade de parcelas não está em conformidade ' + NL +
           'com o campo tipo de operação';
    end;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTipoPgtos.ClearControls;
begin
  Loading := True;
  try
    PkTypePayment  := 0;
    DscTPgt        := '';
    QtdPar         := 0;
    FlagDtaBase    := bdInvoice;
    FlagTInt       := ipDays;
    FlagBlock      := False;
    FlagTVda       := tsCash;
  finally
    Loading := False;
  end;
end;

function TCdTipoPgtos.GetDscTPgt: string;
begin
  Result := eDsc_TPg.Text;
end;

function TCdTipoPgtos.GetFlagDtaBase: TBaseDate;
begin
  Result := TBaseDate(lFlag_Data_Base.ItemIndex);
end;

function TCdTipoPgtos.GetFlagBlock: Boolean;
begin
  Result := lFlag_Bloq.Checked;
end;

function TCdTipoPgtos.GetFlagTInt: TIntervalPay;
begin
  Result := TIntervalPay(lFlag_TInt.ItemIndex);
end;

function TCdTipoPgtos.GetFlagTVda: TTypeSale;
begin
  Result := TTypeSale(lFlag_TVda.ItemIndex);
end;

function TCdTipoPgtos.GetPkTypePayment: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Pagamentos.Text, 0);
end;

function TCdTipoPgtos.GetQtdPar: Integer;
begin
  Result := eQtd_Par.AsInteger;
end;

procedure TCdTipoPgtos.LoadDefaults;
begin
  pTitle.Caption := 'Condições de Pagamento';
  if (DscGMov <> '') then
    pTitle.Caption := pTitle.Caption + ' - ' + DscGMov;
  LoadFinanceAccouts;
  ListLoaded := True;
end;

procedure TCdTipoPgtos.MoveDataToControls;
var
  aItem:  TTypePayment;
begin
  Loading := True;
  try
    aItem          := dmSysPed.TypePayment[Pk];
    PkTypePayment  := aItem.PkTypePgto;
    DscTPgt        := aItem.DscTPgt;
    FlagDtaBase    := aItem.FlagBaseDate;
    FlagTInt       := aItem.FlagTInt;
    FlagBlock      := aItem.FlagBlock;
    FlagTVda       := aItem.FlagTVda;
    DspFin         := aItem.DspFin;
    LoadPaymentWay;
  finally
    Loading := False;
  end;
end;

procedure TCdTipoPgtos.SaveIntoDB;
var
  aItem: TTypePayment;
  aRow : TDataRow;
begin
  aItem                   := TTypePayment.Create;
  aRow                    := TDataRow.Create(nil);
  try
    aItem.PkTypePgto      := PkTypePayment;
    aItem.FkGroupMovement := FFkGroupMovim;
    aItem.DscTPgt         := DscTPgt;
    aItem.QtdParc         := QtdPar;
    aItem.FlagBaseDate    := FlagDtaBase;
    aItem.FlagTInt        := FlagTInt;
    aItem.FlagBlock       := FlagBlock;
    aItem.FlagTVda        := FlagTVda;
    aItem.DspFin          := DspFin;
    dmSysPed.TypePayment[Ord(ScrState)] := aItem;
    aRow.AddAs('PK', aItem.PkTypePgto, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', aItem.DscTPgt, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := aItem.PkTypePgto;
  finally
    FreeAndNil(aItem);
    FreeAndNil(aRow);
  end;
end;

procedure TCdTipoPgtos.SetDscTPgt(const Value: string);
begin
  eDsc_TPg.Text := Value;
end;

procedure TCdTipoPgtos.SetFkGroupMovim(const Value: Integer);
begin
  FFkGroupMovim := Value;
  dmSysPed.PkGroupMoviment := Value;
end;

procedure TCdTipoPgtos.SetFlagDtaBase(const Value: TBaseDate);
begin
  lFlag_Data_Base.ItemIndex := Ord(Value);
end;

procedure TCdTipoPgtos.SetFlagBlock(const Value: Boolean);
begin
  lFlag_Bloq.Checked := Value;
end;

procedure TCdTipoPgtos.SetFlagTInt(const Value: TIntervalPay);
begin
  lFlag_TInt.ItemIndex := Ord(Value);
end;

procedure TCdTipoPgtos.SetFLagTVda(const Value: TTypeSale);
begin
  lFlag_TVda.ItemIndex := Ord(Value);
end;

procedure TCdTipoPgtos.SetPkTypePayment(const Value: Integer);
begin
  ePk_Tipo_Pagamentos.Text := IntToStr(Value);
end;

procedure TCdTipoPgtos.SetQtdPar(const Value: Integer);
begin
  eQtd_Par.AsInteger := Value;
end;

procedure TCdTipoPgtos.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord                := CheckRecord;
  OnInternalState              := ChangeState;
  pgParameters.Images          := Dados.Image16;
  pgParameters.ActivePageIndex := 0;
  vtIntervals.NodeDataSize     := SizeOf(TGridData);
  vtIntervals.Images           := Dados.Image16;
  vtIntervals.Header.Images    := Dados.Image16;
  vtPaymentWay.NodeDataSize    := SizeOf(TGridData);
  vtPaymentWay.Images          := Dados.Image16;
  vtPaymentWay.Header.Images   := Dados.Image16;
end;

procedure TCdTipoPgtos.LoadPaymentWay;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtPaymentWay);
  with dmSysPed, vtPaymentWay do
  begin
    if (qrPgtWay.Active) then qrPgtWay.Close;
    qrPgtWay.SQL.Clear;
    qrPgtWay.SQL.Add(SqlGetPaymentWays);
    Dados.StartTransaction(qrPgtWay);
    BeginUpdate;
    try
      qrPgtWay.ParamByName('FkTipoPagamentos').AsInteger := Pk;
      if (not qrPgtWay.Active) then qrPgtWay.Open;
      while (not qrPgtWay.Eof) do
      begin
        Node := AddChild(nil);
        if (Node <> nil) then
        begin
          Data := GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.DataRow  := TDataRow.CreateFromDataSet(nil, qrPgtWay, True);
            Data^.Level    := 0;
            Data^.Node     := Node;
            Data^.NodeType := tnData;
          end;
        end;
        qrPgtWay.Next;
      end;
    finally
      if (qrPgtWay.Active) then qrPgtWay.Close;
      Dados.CommitTransaction(qrPgtWay);
      EndUpdate;
    end;
  end;
end;

function TCdTipoPgtos.GetIntervals: TList;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := TList.Create;
  with vtIntervals do
  begin
    Node := GetFirst;
    if (Node <> nil) then
    begin
      Data := GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
        Result.Add(Data^.DataRow);
    end;
  end;
end;

procedure TCdTipoPgtos.SetIntervals(const Value: TList);
var
  Node: PVirtualNode;
  Data: PGridData;
  i   : Integer;
begin
  ReleaseTreeNodes(vtIntervals);
  if (Value = nil) then exit;
  with vtIntervals do
  begin
    for i := 0 to Value.Count - 1 do
    begin
      Node := AddChild(nil);
      if (Node <> nil) and (Value.Items[i] <> nil) then
      begin
        Data := GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.DataRow  := TDataRow.CreateAs(vtIntervals, TDataRow(Value.Items[i]));
          Data^.Level    := 0;
          Data^.Node     := Node;
          Data^.NodeType := tnData;
        end;
      end;
    end;
  end;
end;

procedure TCdTipoPgtos.vtIntervalsEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := True;
  if (ScrState in SCROLL_MODE) then
    if (Pk = 0) then
      ScrState := dbmInsert
    else
      ScrState := dbmEdit;
end;

procedure TCdTipoPgtos.vtIntervalsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := FloatToStrF(Data^.DataRow.FieldByName['QTD_INTRV'].AsFloat,  ffNumber, 7, 4);
    1: CellText := Data^.DataRow.FieldByName['OPE_INTRV'].AsString;
    2: CellText := FloatToStrF(Data^.DataRow.FieldByName['IDX_INTRV'].AsFloat, ffNumber, 7, 4);
  end;
end;

procedure TCdTipoPgtos.vtIntervalsKeyDown(Sender: TObject; var Key: Word;
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
    aCol := vtIntervals.FocusedColumn;
    if (aCol = 2) and (Key = VK_RETURN) then
      Key := VK_DOWN;
    case Key of
      VK_UP    : if (RootNodeCount > 1) then
                   if (GetFirst = Node) then
                     FocusedNode := GetLast
                   else
                     if (Data^.DataRow.FieldByName['QTD_INTRV'].AsFloat = 0) and
                        (Data^.DataRow.FieldByName['OPE_INTRV'].AsFloat = 0) and
                        (Data^.DataRow.FieldByName['IDX_INTRV'].AsFloat = 0) then
                       DeleteANode;
      VK_DOWN  : if (Data^.DataRow.FieldByName['QTD_INTRV'].AsFloat > 0) and
                    (Data^.DataRow.FieldByName['OPE_INTRV'].AsFloat > 0) and
                    (Data^.DataRow.FieldByName['IDX_INTRV'].AsFloat > 0) then
                   if (GetLast = Node) then
                     InsertBlankNode
                   else
                   begin
                     FocusedNode           := GetNext(Node);
                     Selected[FocusedNode] := True;
                   end;
      VK_RETURN: begin
                   if (FocusedColumn < 4) then
                     FocusedColumn := FocusedColumn + 1
                   else
                     FocusedColumn := 0;
                   EditNode(FocusedNode, FocusedColumn);
                 end;
    else
      if (not (ssShift in Shift)) and (ssCtrl in Shift) and (Key = VK_DELETE) then
        DeleteANode
      else
        if (Chr(Key) in ['0'..'9', ',']) then
          EditNode(Node, FocusedColumn);
    end;
  end;
end;

procedure TCdTipoPgtos.vtIntervalsNewText(Sender: TBaseVirtualTree;
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
    R.BottomRight.Y := R.BottomRight.Y + ((ClientHeight - vtIntervals.Height) -
                       Integer(TVirtualStringTree(Sender).DefaultNodeHeight));
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight, S);
  end;
begin
  Value := 0;
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column in [0, 2]) then
  begin
    if (StrToFloatDef(NewText, -1) < 0) or (StrToFloatDef(NewText, -1) > 99.9999) then
    begin
      S := 'O valor neste campo deve ser um percentual entre 0,00 e 99,9999';
      DisplayColumnWarning;
      exit;
    end;
    Value := StrToFloat(NewText);
  end
  else
  begin
    if (Length(NewText) > 1) or
       (not (Char(NewText[1]) in ['*', '%', '+', '/'])) then
    begin
      S := 'O valor neste campo deve ser um dos seguintes carateres: ' + NL +
           '* ==> multiplicação; ' + NL +
           '% ==> Percentual; ' + NL +
           '+ ==> Taxa a somar em cada parcela; ' + NL +
           '/ ==> Divisor que calcula cada parcela';
      DisplayColumnWarning;
      exit;
    end;
  end;
  case Column of
    0: Data^.DataRow.FieldByName['QTD_INTRV'].AsFloat  := Value;
    1: Data^.DataRow.FieldByName['OPE_INTRV'].AsString := NewText;
    2: Data^.DataRow.FieldByName['IDX_INTRV'].AsFloat  := Value;
  end;
end;

procedure TCdTipoPgtos.InsertBlankNode;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtIntervals.AddChild(nil);
  if (Node <> nil) then
  begin
    Data := vtIntervals.GetNodeData(Node);
    if (Data <> nil) then
    begin
      Data^.Node     := Node;
      Data^.Level    := vtIntervals.GetNodeLevel(Node);
      Data^.NodeType := tnData;
      Data^.DataRow  := TDataRow.Create(vtIntervals);
      Data^.DataRow.AddAs('QTD_INTRV', 0.0, ftFloat, SizeOf(Double));
      Data^.DataRow.AddAs('OPE_INTRV', '*', ftString, 2);
      Data^.DataRow.AddAs('IDX_INTRV', 0.0, ftFloat, SizeOf(Double));
    end;
  end;
  vtIntervals.FocusedColumn := 0;
end;

procedure TCdTipoPgtos.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  if (AState in UPDATE_MODE) and (vtIntervals.RootNodeCount = 0) then
    InsertBlankNode;
end;

procedure TCdTipoPgtos.vtPaymentWayEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TCdTipoPgtos.vtPaymentWayGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_MPGT'].AsString;
//  CellText := 'Finalizadoras';
end;

procedure TCdTipoPgtos.vtPaymentWayChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
begin
  Allowed := True;
end;

procedure TCdTipoPgtos.vtPaymentWayChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  eFk_Finalizadoras.Caption := Data^.DataRow.FieldByName['DSC_MPGT'].AsString;
  if (Node.CheckState = csCheckedNormal) then
    FActivePaymentWay := Data^.DataRow
  else
    FActivePaymentWay := nil;
  if (Pk > 0) then
  begin
    Data^.DataRow.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger := Pk;
    if (Node.CheckState = csCheckedNormal) then
      pgParameters.ActivePageIndex := 2;
    if (Node.CheckState = csUnCheckedNormal) then
      dmSysPed.PaymentWay[Ord(dbmDelete)] := Data^.DataRow;
  end
  else
    if (Node.CheckState = csCheckedNormal) then
      pgParameters.ActivePageIndex := 2
    else
      Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmBrowse);
end;

procedure TCdTipoPgtos.sbPgtWayOkClick(Sender: TObject);
begin
  with vtPaymentWay do
  begin
    if (FActivePaymentWay <> nil) then
    begin
      if (FActivePaymentWay.FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger > 0) then
        FActivePaymentWay.FieldByName['STATUS'].AsInteger := Ord(dbmEdit)
      else
        FActivePaymentWay.FieldByName['STATUS'].AsInteger := Ord(dbmInsert);
      FActivePaymentWay.FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger := FkFinanceAccount;
      if (Pk > 0) then
      begin
        dmSysPed.PaymentWay[Ord(FActivePaymentWay.FieldByName['STATUS'].AsInteger)] := FActivePaymentWay;
        FActivePaymentWay.FieldByName['STATUS'].AsInteger := Ord(dbmBrowse);
      end
      else
        FActivePaymentWay.FieldByName['STATUS'].AsInteger := Ord(dbmInsert);
    end;
  end;
  pgParameters.ActivePageIndex := 1;
end;

function TCdTipoPgtos.GetFkFinaceAccount: Integer;
begin
  with eFk_Financeiro_Contas do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
  end;
end;

procedure TCdTipoPgtos.SetFkFinaceAccount(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Financeiro_Contas do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[ItemIndex] <> nil) and
         (TClassification(Items.Objects[ItemIndex]).Pk = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTipoPgtos.LoadFinanceAccouts;
begin
  ReleaseCombos(eFk_Financeiro_Contas, toObject);
  Screen.Cursor := crHourGlass;
  try
    eFk_Financeiro_Contas.Items.AddStrings(dmSysPed.LoadClassifications(Ord(FlagES)));
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TCdTipoPgtos.vtPaymentWayInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Node.CheckType := ctCheckBox;
  if (Data^.DataRow.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger > 0) then
    Node.CheckState := csCheckedNormal
  else
    Node.CheckState := csUnCheckedNormal;
end;

procedure TCdTipoPgtos.vtPaymentWayGetNodeDataSize(
  Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TGridData);
end;

procedure TCdTipoPgtos.vtPaymentWayPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  TargetCanvas.Font.Color := clWindowText;
  if (Data^.DataRow.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger > 0) and
     (Data^.DataRow.FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger = 0) then
    TargetCanvas.Font.Color := $000080FF;
  if (Data^.DataRow.FieldByName['STATUS'].AsInteger <> Ord(dbmBrowse)) then
    TargetCanvas.Font.Color := clRed;
end;

procedure TCdTipoPgtos.vtPaymentWayBeforeItemErase(
  Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  ItemRect: TRect; var ItemColor: TColor;
  var EraseAction: TItemEraseAction);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger > 0) and
     (Data^.DataRow.FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger = 0) then
    ItemColor := clYellow;
  EraseAction := eaColor;
end;

procedure TCdTipoPgtos.eFk_Financeiro_ContasDrawItem(Control: TWinControl;
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

function TCdTipoPgtos.GetDspFin: Double;
begin
  Result := eDsp_Fin.Value;
end;

procedure TCdTipoPgtos.SetDspFin(const Value: Double);
begin
  eDsp_Fin.Value := Value;
end;

end.
