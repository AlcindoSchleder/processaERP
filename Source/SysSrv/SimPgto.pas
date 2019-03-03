unit SimPgto;

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
  Dialogs, VirtualTrees, ComCtrls, ToolWin, TSysSrv, ToolEdit, StdCtrls,
  Mask, CurrEdit, ExtCtrls, Buttons, Menus;

type
  TChangeDateEvent   = procedure (Sender: TObject; AStartDate, AEndDate: TDate) of object;

  TChangePeriodEvent = procedure (Sender: TObject; const APeriodList: string) of object;

  TfrmPgtos = class(TForm)
    pPgtos: TPanel;
    lDtaBase: TStaticText;
    eVlrBase: TCurrencyEdit;
    eDtaBase: TDateEdit;
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
    procedure eDtaBaseChange(Sender: TObject);
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
  private
    { Private declarations }
    FActiveOS      : TServiceOrder;
    FPgtoIndex     : Integer;
    FCodAut        : Integer;
    FModified      : Boolean;
    FOnChangeDate  : TChangeDateEvent;
    FOnChangePeriod: TChangePeriodEvent;
    procedure SetActiveOS(AValue: TServiceOrder);
    procedure SetModified(AValue: Boolean);
    procedure MoveNodeToControls;
    procedure MoveControlsToNode;
    procedure RecalcPeriod;
  public
    { Public declarations }
    procedure ShowPayments;
    property  ActiveOS      : TServiceOrder      read FActiveOS       write SetActiveOS;
    property  CodAut        : Integer            read FCodAut         write FCodAut;
    property  Modified      : Boolean            read FModified       write SetModified;
    property  OnChangeDate  : TChangeDateEvent   read FOnChangeDate   write FOnChangeDate;
    property  OnChangePeriod: TChangePeriodEvent read FOnChangePeriod write FOnChangePeriod;
  end;

var
  frmPgtos: TfrmPgtos;

implementation

{$R *.dfm}

uses TSysPedAux, Dado, GridRow, ProcType, FuncoesDB, DB, Math, DateUtils;

procedure TfrmPgtos.FormCreate(Sender: TObject);
begin
  FActiveOS := TServiceOrder.Create(Self);
  FModified := False;
  vtPayments.NodeDataSize := SizeOf(TGridData);
  pgPayments.ActivePageIndex := 0;
end;

procedure TfrmPgtos.FormDestroy(Sender: TObject);
begin
 ReleaseTreeNodes(vtPayments);
 if Assigned(FActiveOS) then FActiveOS.Free;
 FActiveOS := nil;
end;

procedure TfrmPgtos.FormShow(Sender: TObject);
begin
  FPgtoIndex := -1;
  vtPayments.PopupMenu := nil;
  if (FActiveOS.FkPayment.PkTypePgto > 0) and (FActiveOS.TotOS > 0) and
     (FActiveOS.DtaFin > 0) then
  begin
    case FActiveOS.FkPayment.FlagBaseDate of
      bdOrder   : eDtaBase.Date := ActiveOS.DtaOS;
      bdInvoice : eDtaBase.Date := ActiveOS.DtaFin;
      bdDelivery: eDtaBase.Date := ActiveOS.DtaFin;
    else
      eDtaBase.Date := ActiveOS.DtaOS;
    end;
    eVlrBase.Value := FActiveOS.TotOS;
  end;
end;

procedure TfrmPgtos.SetActiveOS(AValue: TServiceOrder);
begin
  if (AValue = nil) then
    FActiveOS.Clear
  else
    FActiveOS.Assign(AValue);
end;

procedure TfrmPgtos.SetModified(AValue: Boolean);
begin
  FModified := AValue;
  pPgtos.Color := clBtnFace;
end;

procedure TfrmPgtos.eDtaBaseChange(Sender: TObject);
begin
  if (FActiveOS.FkPayment.PkTypePgto > 0) and (eVlrBase.Value > 0) and
     (eDtaBase.Date > 0) then
  begin
    Modified := (FActiveOS.DtaFin <> eDtaBase.Date) or
                (CompareValue(RoundTo(FActiveOS.TotOS, 2), eVlrBase.Value) = 0);
    FActiveOS.FkPayment.CreatePayments(eVlrBase.Value, eDtaBase.Date);
    ShowPayments;
  end;
end;

procedure TfrmPgtos.ShowPayments;
var
  i: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtPayments);
  for i := 0 to FActiveOS.FkPayment.Installments.Count - 1 do
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
          with FActiveOS.FkPayment.Installments.Items[i] do
          begin
            Data^.DataRow.AddAs('DTA_VENC', DtaVenc, ftDate, SizeOf(DtaVenc));
            Data^.DataRow.AddAs('VLR_PARC', VlrParc, ftFloat, SizeOf(Double));
            Data^.DataRow.AddAs('INDEX', i, ftInteger, SizeOf(Integer));
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmPgtos.pgPaymentsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (vtPayments.RootNodeCount > 0) and
                 (vtPayments.FocusedNode <> nil) and
                 (ActiveOS.FkPayment <> nil);
end;

procedure TfrmPgtos.pgPaymentsChange(Sender: TObject);
begin
  case pgPayments.ActivePageIndex of
    0: MoveControlsToNode;
    1: MoveNodeToControls;
  end;
end;

procedure TfrmPgtos.MoveNodeToControls;
var
  Data: PGridData;
const
  sDueTitle = 'Parcela %d de %d';
begin
//  eDtaVenc.Enabled := ActiveOS.FkPayment.FlagTInt := ;
//  lDtaVenc.Enabled := ActiveOS.FkPayment.FlagUser;
//  eVlrParc.Enabled := ActiveOS.FkPayment.FlagUser;
//  lVlrParc.Enabled := ActiveOS.FkPayment.FlagUser;
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

procedure TfrmPgtos.MoveControlsToNode;
var
  Data: PGridData;
begin
  if (vtPayments.FocusedNode <> nil) then
  begin
    Data := vtPayments.GetNodeData(vtPayments.FocusedNode);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      if (not FModified) then
        Modified := (Data^.DataRow.FieldByName['DTA_VENC'].AsDateTime <> eDtaVenc.Date ) or
                    (Data^.DataRow.FieldByName['VLR_PARC'].AsFloat     = eVlrParc.Value);
      if (Modified) and (FPgtoIndex > -1) then
      begin
        FActiveOS.FkPayment.Installments.Items[FPgtoIndex].DtaVenc := eDtaVenc.Date;
        FActiveOS.FkPayment.Installments.Items[FPgtoIndex].VlrParc := eVlrParc.Value;
        RecalcPeriod;
        Data^.DataRow.FieldByName['DTA_VENC'].AsDateTime := eDtaVenc.Date;
        Data^.DataRow.FieldByName['VLR_PARC'].AsFloat    := eVlrParc.Value;
      end;
    end;
  end;
end;

procedure TfrmPgtos.vtPaymentsGetText(Sender: TBaseVirtualTree;
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

procedure TfrmPgtos.vtPaymentsFocusChanged(Sender: TBaseVirtualTree;
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

procedure TfrmPgtos.pmInsertClick(Sender: TObject);
var
  aItem: TInstallment;
  aLastDate: TDate;
begin
  if (ActiveOS.FkPayment <> nil) then
  begin
    if ActiveOS.FkPayment.Installments.Count > 0 then
      aLastDate := ActiveOS.FkPayment.Installments.Items[
                      ActiveOS.FkPayment.Installments.Count -1].DtaVenc
    else
      aLastDate := Date;
    aItem := ActiveOS.FkPayment.Installments.Add;
    aItem.DtaVenc := aLastDate;
    aItem.VlrParc := 0.0;
    ShowPayments;
    RecalcPeriod;
  end;
end;

procedure TfrmPgtos.RecalcPeriod;
var
  i: Integer;
  aStartDate: TDate;
  aDifDays: Integer;
  aPeriods: string;
begin
  if ActiveOS.FkPayment.Installments.Count = 0 then exit;
  aStartDate := eDtaBase.Date;
  aPeriods   := '';
  for i := 0 to ActiveOS.FkPayment.Installments.Count - 1 do
  begin
    with ActiveOS.FkPayment.Installments do
    begin
      aDifDays := DaysBetween(aStartDate, Items[i].DtaVenc);
      if aDifDays > 0 then
        if (i = 0) then
          aPeriods := IntToStr(aDifDays)
        else
          aPeriods := aPeriods + '+' + IntToStr(aDifDays);
    end;
  end;
  if CompareValue(FActiveOS.TotOS, FActiveOS.FkPayment.Installments.Total, 2) <> 0 then
  begin
    Dados.DisplayHint(eVlrBase, Format('Total da OS é de %s e total apurado ' +
      'das parcelas é de %s. Sistema vai exigir Senha',
       [FloatToStrF(FActiveOS.TotOS, ffCurrency, 7, 2),
        FloatToStrF(FActiveOS.FkPayment.Installments.Total, ffCurrency, 7, 2)]),
        hiWarning, 'Parcelamento da OS');
//    FActiveOS.FkPayment.FlagSen := True;
  end;
  if Assigned(FOnChangePeriod) then
    FOnChangePeriod(Self, aPeriods);
end;

procedure TfrmPgtos.ExcluirParcel1Click(Sender: TObject);
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
  ActiveOS.FkPayment.Installments.Delete(aIdx);
  RecalcPeriod;
end;

end.

