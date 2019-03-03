unit CadInstlm;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 06/03/2003 - DD/MM/YYYY                                      *}
{* Modified: 06/03/2003 - DD/MM/YYYY                                     *}
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
  Dialogs, VirtualTrees, ComCtrls, ToolWin, TSysPed, ToolEdit, StdCtrls,
  Mask, CurrEdit, ExtCtrls, Buttons, Menus, CadModel;

type
  TChangeDateEvent   = procedure (Sender: TObject; AStartDate, AEndDate: TDate) of object;

  TChangePeriodEvent = procedure (Sender: TObject; const APeriodList: string) of object;

  TCdInstallments = class(TfrmModel)
    pgPayments: TPageControl;
    tsList: TTabSheet;
    tsData: TTabSheet;
    vtPayments: TVirtualStringTree;
    lDtaVenc: TStaticText;
    eDtaVenc: TDateEdit;
    lVlrParc: TStaticText;
    eVlrParc: TCurrencyEdit;
    stTitle: TStaticText;
    pmInstallments: TPopupMenu;
    pmInsert: TMenuItem;
    ExcluirParcel1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pgPaymentsChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure pgPaymentsChange(Sender: TObject);
    procedure vtPaymentsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtPaymentsFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure pmInsertClick(Sender: TObject);
    procedure ExcluirParcel1Click(Sender: TObject);
    procedure vtPaymentsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
  private
    { Private declarations }
    FActiveOrder   : TOrder;
    FPgtoIndex     : Integer;
    FCodAut        : Integer;
    FDtaBase       : TDate;
    FPgtosModified : Boolean;
    FOnChangeDate  : TChangeDateEvent;
    FOnChangePeriod: TChangePeriodEvent;
    FVlrBase: Double;
    procedure SetActiveOrder(AValue: TOrder);
    procedure SetPgtosModified(AValue: Boolean);
    procedure MoveNodeToControls;
    procedure MoveControlsToNode;
    procedure RecalcPeriod;
    procedure SetDtaBase(const Value: TDate);
    procedure SetVlrBase(const Value: Double);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    procedure ShowPayments;
    property  ActiveOrder   : TOrder             read FActiveOrder    write SetActiveOrder;
    property  CodAut        : Integer            read FCodAut         write FCodAut;
    property  DtaBase       : TDate              read FDtaBase        write SetDtaBase;
    property  PgtosModified : Boolean            read FPgtosModified  write SetPgtosModified;
    property  VlrBase       : Double             read FVlrBase        write SetVlrBase;
    property  OnChangeDate  : TChangeDateEvent   read FOnChangeDate   write FOnChangeDate;
    property  OnChangePeriod: TChangePeriodEvent read FOnChangePeriod write FOnChangePeriod;
  end;

implementation

{$R *.dfm}

uses TSysPedAux, Dado, GridRow, ProcType, FuncoesDB, DB, Math, DateUtils;

procedure TCdInstallments.FormCreate(Sender: TObject);
begin
  FActiveOrder               := TOrder.Create(Dados.DecimalPlaces);
  FPgtosModified             := False;
  vtPayments.NodeDataSize    := SizeOf(TGridData);
  pgPayments.ActivePageIndex := 0;
end;

procedure TCdInstallments.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtPayments);
  if Assigned(FActiveOrder) then FActiveOrder.Free;
  FActiveOrder := nil;
end;

procedure TCdInstallments.FormShow(Sender: TObject);
begin
  FPgtoIndex := -1;
  if (FActiveOrder.FkTypePayment.FlagTInt = ipUser) then
    vtPayments.PopupMenu := pmInstallments
  else
    vtPayments.PopupMenu := nil;
  if (FActiveOrder.FkTypePayment.PkTypePgto > 0) and (FActiveOrder.TotPed > 0) and
     (FActiveOrder.DtaBas > 0) then
  begin
    case FActiveOrder.FkTypePayment.FlagBaseDate of
      bdOrder   : DtaBase := ActiveOrder.DtaPed;
      bdInvoice : DtaBase := ActiveOrder.DtaBas;
      bdDelivery: DtaBase := ActiveOrder.DtaBas;
    else
      DtaBase := ActiveOrder.DtaPed;
    end;
    VlrBase := FActiveOrder.TotPed;
  end;
end;

procedure TCdInstallments.SetActiveOrder(AValue: TOrder);
begin
  if (AValue = nil) then
    FActiveOrder.Clear
  else
    FActiveOrder.Assign(AValue);
  if (FActiveOrder.DtaBas > 0) and (FActiveOrder.TotPed > 0) then
  begin
    FDtaBase := FActiveOrder.DtaBas;
    FVlrBase := FActiveOrder.TotPed;
    FActiveOrder.FkTypePayment.CreatePayments(FVlrBase, FDtaBase);
    ShowPayments;
  end;
end;

procedure TCdInstallments.SetPgtosModified(AValue: Boolean);
var
  Data: PGridData;
begin
  FPgtosModified := AValue;
  if (vtPayments.FocusedNode <> nil) then
  begin
    Data := vtPayments.GetNodeData(vtPayments.FocusedNode);
    if (Data <> nil) and (Data^.DataRow <> nil) then
      Data^.DataRow.FieldByName['MODIFIED'].AsInteger := Ord(AValue);
  end;
end;

procedure TCdInstallments.ShowPayments;
var
  i: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtPayments);
  for i := 0 to FActiveOrder.FkTypePayment.Installments.Count - 1 do
  begin
    Node := vtPayments.AddChild(nil);
    if (Node <> nil) then
    begin
      Data := vtPayments.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level   := 0;
        Data^.Node    := Node;
        Data^.DataRow := TDataRow.Create(nil);
        if (Data^.DataRow <> nil) then
        begin
          with FActiveOrder.FkTypePayment.Installments.Items[i] do
          begin
            Data^.DataRow.AddAs('DTA_VENC', DtaVenc, ftDate, SizeOf(DtaVenc));
            Data^.DataRow.AddAs('VLR_PARC', VlrParc, ftFloat, SizeOf(Double));
            Data^.DataRow.AddAs('INDEX', i, ftInteger, SizeOf(Integer));
            Data^.DataRow.AddAs('MODIFIED', Ord(Modified), ftInteger, SizeOf(Integer));
          end;
        end;
      end;
    end;
  end;
end;

procedure TCdInstallments.pgPaymentsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (vtPayments.RootNodeCount > 0) and
                 (vtPayments.FocusedNode <> nil) and
                 (ActiveOrder.FkTypePayment <> nil) and
                 (ActiveOrder.FkTypePayment.FlagTInt = ipUser);
end;

procedure TCdInstallments.pgPaymentsChange(Sender: TObject);
begin
  case pgPayments.ActivePageIndex of
    0: MoveControlsToNode;
    1: MoveNodeToControls;
  end;
end;

procedure TCdInstallments.MoveNodeToControls;
var
  Data: PGridData;
const
  sDueTitle = 'Parcela %d de %d';
begin
  eDtaVenc.Enabled := ActiveOrder.FkTypePayment.FlagTInt = ipUser;
  lDtaVenc.Enabled := ActiveOrder.FkTypePayment.FlagTInt = ipUser;
  eVlrParc.Enabled := ActiveOrder.FkTypePayment.FlagTInt = ipUser;
  lVlrParc.Enabled := ActiveOrder.FkTypePayment.FlagTInt = ipUser;
  if (vtPayments.FocusedNode <> nil) then
  begin
    Data := vtPayments.GetNodeData(vtPayments.FocusedNode);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      stTitle.Caption := Format(sDueTitle, [vtPayments.FocusedNode.Index + 1,
                                            vtPayments.RootNodeCount]);
      eDtaVenc.Date  := Data^.DataRow.FieldByName['DTA_VENC'].AsDateTime;
      eVlrParc.Value := Data^.DataRow.FieldByName['VLR_PARC'].AsFloat;
      FPgtoIndex     := Data^.DataRow.FieldByName['INDEX'].AsInteger;
    end;
  end;
end;

procedure TCdInstallments.MoveControlsToNode;
var
  Data: PGridData;
begin
  if (vtPayments.FocusedNode <> nil) then
  begin
    Data := vtPayments.GetNodeData(vtPayments.FocusedNode);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      if (not FPgtosModified) then
        PgtosModified := (Data^.DataRow.FieldByName['DTA_VENC'].AsDateTime <> eDtaVenc.Date ) or
                         (Data^.DataRow.FieldByName['VLR_PARC'].AsFloat     = eVlrParc.Value);
      if (PgtosModified) and (FPgtoIndex > -1) then
      begin
        FActiveOrder.FkTypePayment.Installments.Items[FPgtoIndex].DtaVenc  := eDtaVenc.Date;
        FActiveOrder.FkTypePayment.Installments.Items[FPgtoIndex].VlrParc  := eVlrParc.Value;
        FActiveOrder.FkTypePayment.Installments.Items[FPgtoIndex].Modified := PgtosModified;
        RecalcPeriod;
        Data^.DataRow.FieldByName['DTA_VENC'].AsDateTime := eDtaVenc.Date;
        Data^.DataRow.FieldByName['VLR_PARC'].AsFloat    := eVlrParc.Value;
      end;
    end;
  end;
end;

procedure TCdInstallments.vtPaymentsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['DTA_VENC'].AsString;
    1: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_PARC'].AsFloat, ffNumber, 7, 2);
  end;
end;

procedure TCdInstallments.vtPaymentsFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Assigned(FOnChangeDate) then
    FOnChangeDate(Self, Data^.DataRow.FieldByName['DTA_VENC'].AsDateTime, 0);
end;

procedure TCdInstallments.pmInsertClick(Sender: TObject);
var
  aItem: TInstallment;
  aLastDate: TDate;
begin
  if (ActiveOrder.FkTypePayment <> nil) then
  begin
    if ActiveOrder.FkTypePayment.Installments.Count > 0 then
      aLastDate := ActiveOrder.FkTypePayment.Installments.Items[
                      ActiveOrder.FkTypePayment.Installments.Count -1].DtaVenc
    else
      aLastDate := Date;
    aItem := ActiveOrder.FkTypePayment.Installments.Add;
    aItem.DtaVenc := aLastDate;
    aItem.VlrParc := 0.0;
    ShowPayments;
    RecalcPeriod;
  end;
end;

procedure TCdInstallments.RecalcPeriod;
var
  i: Integer;
  aStartDate: TDate;
  aDifDays: Integer;
  aPeriods: string;
begin
  if ActiveOrder.FkTypePayment.Installments.Count = 0 then exit;
  aStartDate := DtaBase;
  aPeriods   := '';
  for i := 0 to ActiveOrder.FkTypePayment.Installments.Count - 1 do
  begin
    with ActiveOrder.FkTypePayment.Installments do
    begin
      aDifDays := DaysBetween(aStartDate, Items[i].DtaVenc);
      if aDifDays > 0 then
        if (i = 0) then
          aPeriods := IntToStr(aDifDays)
        else
          aPeriods := aPeriods + '+' + IntToStr(aDifDays);
    end;
  end;
  if CompareValue(FActiveOrder.TotPed,
       FActiveOrder.FkTypePayment.Installments.Total, 2) <> 0 then
  begin
    Dados.DisplayHint(vtPayments, Format('Total da OS é de %s e total apurado ' +
      'das parcelas é de %s. Sistema vai exigir Senha',
       [FloatToStrF(FActiveOrder.TotPed, ffCurrency, 7, 2),
        FloatToStrF(FActiveOrder.FkTypePayment.Installments.Total, ffCurrency, 7, 2)]),
        hiWarning, 'Parcelamento da OS');
    FActiveOrder.FkTypePayment.FlagBlock := True;
  end;
end;

procedure TCdInstallments.ExcluirParcel1Click(Sender: TObject);
var
  aIdx: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtPayments.FocusedNode;
  if (Node = nil) then exit;
  Data := vtPayments.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aIdx := Data^.DataRow.FieldByName['INDEX'].AsInteger;
  Data^.Node := nil;
  Data^.DataRow.Free;
  Data^.DataRow := nil;
  vtPayments.DeleteNode(Node);
  ActiveOrder.FkTypePayment.Installments.Delete(aIdx);
  RecalcPeriod;
end;

procedure TCdInstallments.SetDtaBase(const Value: TDate);
begin
  FDtaBase := Value;
  if (Value > 0) and (Value <> FDtaBase) then
    if (FVlrBase > 0) then
      ActiveOrder.FkTypePayment.CreatePayments(FVlrBase, FDtaBase);
end;

procedure TCdInstallments.SetVlrBase(const Value: Double);
begin
  FVlrBase := Value;
  if (Value > 0) and (Value <> FVlrBase) then
    if (FDtaBase > 0) then
      ActiveOrder.FkTypePayment.CreatePayments(FVlrBase, FDtaBase);
end;

procedure TCdInstallments.vtPaymentsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Data^.DataRow.FieldByName['MODIFIED'].AsInteger = 1 then
    TargetCanvas.Font.Color := clRed;
end;

procedure TCdInstallments.ClearControls;
begin
  Loading := True;
  try
    CodAut        := 0;
    DtaBase       := 0;
    PgtosModified := False;
    VlrBase       := 0.0;
  finally
    Loading := False;
  end;
end;

procedure TCdInstallments.LoadDefaults;
begin
  // Nothing to do
end;

procedure TCdInstallments.MoveDataToControls;
begin
  // Nothing to do
end;

procedure TCdInstallments.SaveIntoDB;
begin
  // Nothing to do
end;

end.

