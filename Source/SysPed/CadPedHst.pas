unit CadPedHst;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
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
  Dialogs, VirtualTrees, ComCtrls, StdCtrls, ExtCtrls, ToolWin, Mask, ToolEdit,
  jpeg, TSysPed, TSysPedAux, PrcCombo, ProcUtils, CadModel;

type
  PHistorics = ^THistorics;
  THistorics = record
    Level: Integer;
    Node : PVirtualNode;
    Index: Integer;
    Item : TOrderHistoric;
  end;

  TCdOrdersHist = class(TfrmModel)
    vtHistoric: TVirtualStringTree;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbFirst: TToolButton;
    tbPrior: TToolButton;
    tbNext: TToolButton;
    tbLast: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    ToolButton6: TToolButton;
    tbSave: TToolButton;
    tbStatistics: TToolButton;
    pData: TPanel;
    pImage: TPanel;
    imDecorative: TImage;
    pgHistoric: TPageControl;
    tsHistoric: TTabSheet;
    lFk_Tipo_Status_Pedidos: TStaticText;
    lDsc_Hist: TStaticText;
    eDsc_Hist: TEdit;
    lDta_Msg: TStaticText;
    eFk_Tipo_Status_Pedidos: TPrcComboBox;
    tsStatus: TTabSheet;
    eDta_Recb: TDateEdit;
    eDta_Fat: TDateEdit;
    eDta_Lib: TDateEdit;
    eDta_Liq: TDateEdit;
    eDta_Canc: TDateEdit;
    lDta_Recb: TStaticText;
    lDta_Fat: TStaticText;
    lDta_Lib: TStaticText;
    lDta_Ped: TStaticText;
    eDta_Ped: TDateEdit;
    lDta_Liq: TStaticText;
    lDta_Canc: TStaticText;
    eDtHr_Hist: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure vtHistoricFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtHistoricGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure tbInsertClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbFirstClick(Sender: TObject);
    procedure tbPriorClick(Sender: TObject);
    procedure tbNextClick(Sender: TObject);
    procedure tbLastClick(Sender: TObject);
    procedure tbStatisticsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FGrMovID  : Integer;
    FItemIndex: Integer;
    FActiveOrder: TOrder;
    function  GetDscHist: string;
    function  GetDtaCanc: TDate;
    function  GetDtaFat: TDate;
    function  GetDtaLib: TDate;
    function  GetDtaLiq: TDate;
    function  GetDtaPed: TDate;
    function  GetDtaRecb: TDate;
    function  GetDtHrMsg: TDateTime;
    function  GetStatusOrder: TOrderStatus;
    procedure SetDscHist(const Value: string);
    procedure SetDtaCanc(const Value: TDate);
    procedure SetDtaFat(const Value: TDate);
    procedure SetDtaLib(const Value: TDate);
    procedure SetDtaLiq(const Value: TDate);
    procedure SetDtaPed(const Value: TDate);
    procedure SetDtaRecb(const Value: TDate);
    procedure SetDtHrMsg(const Value: TDateTime);
    procedure SetItemIndex(const Value: Integer);
    procedure SetStatusOrder(const Value: TOrderStatus);
    procedure ReleaseTreeNodes(Sender: TVirtualStringTree);
    procedure ChangeState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure SetActiveOrder(const Value: TOrder);
  public
    { Public declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    property  ActiveOrder   : TOrder          read FActiveOrder      write SetActiveOrder;
    property  GrMovID       : Integer         read FGrMovID          write FGrMovID;
    property  FkStatusOrder : TOrderStatus    read GetStatusOrder    write SetStatusOrder;
    property  DscHist       : string          read GetDscHist        write SetDscHist;
    property  DtaRecb       : TDate           read GetDtaRecb        write SetDtaRecb;
    property  DtaFat        : TDate           read GetDtaFat         write SetDtaFat;
    property  DtaLib        : TDate           read GetDtaLib         write SetDtaLib;
    property  DtaLiq        : TDate           read GetDtaLiq         write SetDtaLiq;
    property  DtaCanc       : TDate           read GetDtaCanc        write SetDtaCanc;
    property  DtaPed        : TDate           read GetDtaPed         write SetDtaPed;
    property  DtHrMsg       : TDateTime       read GetDtHrMsg        write SetDtHrMsg;
    property  ItemIndex     : Integer         read FItemIndex        write SetItemIndex;
  end;

implementation

uses Dado, mSysPed, DateUtils;

{$R *.dfm}

procedure TCdOrdersHist.FormCreate(Sender: TObject);
begin
  cbTools.Images           := Dados.Image16;
  tbTools.Images           := Dados.Image16;
  vtHistoric.Images        := Dados.Image16;
  vtHistoric.Header.Images := Dados.Image16;
  vtHistoric.NodeDataSize  := SizeOf(THistorics);
  OnInternalState          := ChangeState;
  FActiveOrder             := TOrder.Create(Dados.DecimalPlaces);
  inherited;
end;

procedure TCdOrdersHist.LoadDefaults;
begin
  if (not ListLoaded) then
    eFk_Tipo_Status_Pedidos.Items.AddStrings(dmSysPed.LoadStatusType(FGrMovID));
end;

procedure TCdOrdersHist.MoveDataToControls;
begin
  Loading         := True;
  try
    DtaRecb         := ActiveOrder.DtaRecb;
    DtaFat          := ActiveOrder.DtaFat;
    DtaLib          := ActiveOrder.DtaLib;
    DtaLiq          := ActiveOrder.DtaLiq;
    DtaCanc         := ActiveOrder.DtaCanc;
    DtaPed          := ActiveOrder.DtaPed;
    if (FItemIndex > -1) and (ActiveOrder.OrderHistorics <> nil) and
       (FItemIndex < ActiveOrder.OrderHistorics.Count) then
    begin
      FkStatusOrder := ActiveOrder.OrderHistorics.Items[FItemIndex].FkOrderStatus;
      DscHist       := ActiveOrder.OrderHistorics.Items[FItemIndex].DscHist;
      DtHrMsg       := ActiveOrder.OrderHistorics.Items[FItemIndex].DtHrHist;
    end;
  finally
    Loading         := False;
  end;
  if ScrState in LOADING_MODE then
    ScrState      := dbmBrowse;
end;

procedure TCdOrdersHist.ClearControls;
begin
  Loading        := True;
  try
    FkStatusOrder  := nil;
    DscHist        := '';
    DtaRecb        := 0;
    DtaFat         := 0;
    DtaLib         := 0;
    DtaLiq         := 0;
    DtaCanc        := 0;
    DtaPed         := 0;
    DtHrMsg        := Now;
  finally
    Loading        := False;
  end;
end;

procedure TCdOrdersHist.SaveIntoDB;
var
  Node: PVirtualNode;
  Data: PHistorics;
  Item: TOrderHistoric;
begin
  vtHistoric.BeginUpdate;
  try
    Node := vtHistoric.AddChild(nil);
    if (Node <> nil) then
    begin
      Data := vtHistoric.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Item               := ActiveOrder.OrderHistorics.Add;
        Item.FkOrderStatus := FkStatusOrder;
        Item.DscHist       := DscHist;
        Item.DtHrHist      := DtHrMsg;
        Data^.Index        := Item.Index;
        Data^.Item         := TOrderHistoric.Create(nil);
        Data^.Item.Assign(Item);
        Data^.Level        := 0;
        Data^.Node         := Node;
      end;
    end;
    if (vtHistoric.RootNodeCount > 0) then
    begin
      vtHistoric.FocusedNode := Node;
      vtHistoric. Selected[Node] := True;
    end;
  finally
    vtHistoric.EndUpdate;
  end;
  ScrState := dbmBrowse;
end;

function TCdOrdersHist.GetDscHist: string;
begin
  Result := eDsc_Hist.Text;
end;

function TCdOrdersHist.GetDtaCanc: TDate;
begin
  Result := eDta_Canc.Date;
end;

function TCdOrdersHist.GetDtaFat: TDate;
begin
  Result := eDta_Fat.Date;
end;

function TCdOrdersHist.GetDtaLib: TDate;
begin
  Result := eDta_Lib.Date;
end;

function TCdOrdersHist.GetDtaLiq: TDate;
begin
  Result := eDta_Liq.Date;
end;

function TCdOrdersHist.GetDtaPed: TDate;
begin
  Result := eDta_Ped.Date;
end;

function TCdOrdersHist.GetDtaRecb: TDate;
begin
  Result := eDta_Recb.Date;
end;

function TCdOrdersHist.GetDtHrMsg: TDateTime;
begin
  Result := StrToDateTime(eDtHr_Hist.Text);
end;

function TCdOrdersHist.GetStatusOrder: TOrderStatus;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Tipo_Status_Pedidos.ItemIndex;
  if (aIdx > 0) and (eFk_Tipo_Status_Pedidos.Items.Objects[aIdx] <> nil) then
    Result := TOrderStatus(eFk_Tipo_Status_Pedidos.Items.Objects[aIdx]);
end;

procedure TCdOrdersHist.SetDscHist(const Value: string);
begin
  eDsc_Hist.Text := Copy(Value, 1, 100);
end;

procedure TCdOrdersHist.SetDtaCanc(const Value: TDate);
begin
  if (Value = 0) then
    eDta_Canc.Clear
  else
    eDta_Canc.Date := Value;
end;

procedure TCdOrdersHist.SetDtaFat(const Value: TDate);
begin
  if (Value = 0) then
    eDta_Fat.Clear
  else
    eDta_Fat.Date := Value;
end;

procedure TCdOrdersHist.SetDtaLib(const Value: TDate);
begin
  if (Value = 0) then
    eDta_Lib.Clear
  else
    eDta_Lib.Date := Value;
end;

procedure TCdOrdersHist.SetDtaLiq(const Value: TDate);
begin
  if (Value = 0) then
    eDta_Liq.Clear
  else
    eDta_Liq.Date := Value;
end;

procedure TCdOrdersHist.SetDtaPed(const Value: TDate);
begin
  if (Value = 0) then
    eDta_Ped.Clear
  else
    eDta_Ped.Date := Value;
end;

procedure TCdOrdersHist.SetDtaRecb(const Value: TDate);
begin
  if (Value = 0) then
    eDta_Recb.Clear
  else
    eDta_Recb.Date := Value;
end;

procedure TCdOrdersHist.SetDtHrMsg(const Value: TDateTime);
begin
  eDtHr_Hist.Text := FormatDateTime('dd/mm/yyyy hh:mm:ss', Value);
end;

procedure TCdOrdersHist.SetItemIndex(const Value: Integer);
var
  Node: PVirtualNode;
  Data: PHistorics;
begin
  FItemIndex := Value;
  if (FItemIndex < 0) and (vtHistoric.RootNodeCount = 0) then exit;
  Node := vtHistoric.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtHistoric.GetNodeData(Node);
    if (Data <> nil) and (Data^.Item <> nil) and
       (Data^.Item.Index = FItemIndex) then
    begin
      vtHistoric.FocusedNode := Node;
      break;
    end;
    Node := vtHistoric.GetNext(Node);
  end;
end;

procedure TCdOrdersHist.SetStatusOrder(const Value: TOrderStatus);
begin
  if (Value = nil) then
    eFk_Tipo_Status_Pedidos.ItemIndex := -1
  else
    eFk_Tipo_Status_Pedidos.SetIndexFromObjectValue(Value.PkOrderStatus);
end;

procedure TCdOrdersHist.ReleaseTreeNodes(Sender: TVirtualStringTree);
var
  Node: PVirtualNode;
  Data: PHistorics;
begin
  if Sender.RootNodeCount = 0 then exit;
  Sender.BeginUpdate;
  try
    Node   := Sender.GetFirst;
    while Node <> nil do
    begin
      Data  := Sender.GetNodeData(Node);
      if Data <> nil then
      begin
        if Data^.Item <> nil then
          Data^.Item.Free;
        Data^.Item  := nil;
        Data^.Node  := nil;
        Data^.Level := 0;
        Data^.Index := 0;
      end;
      Data := nil;
      if Data = nil then
        Node := Sender.GetNext(Node);
    end;
    if Sender.RootNodeCount > 0 then
      Sender.Clear;
  finally
    Sender.EndUpdate;
  end;
end;

procedure TCdOrdersHist.vtHistoricFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PHistorics;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.Item = nil) then exit;
  FItemIndex := Data^.Index;
  MoveDataToControls;
  tbFirst.Enabled := (Sender.AbsoluteIndex(Node) > 0) and (vtHistoric.RootNodeCount > 0);
  tbPrior.Enabled := (Sender.AbsoluteIndex(Node) > 0) and (vtHistoric.RootNodeCount > 0);
  tbNext.Enabled  := (Sender.AbsoluteIndex(Node) < (vtHistoric.RootNodeCount - 1))
                      and (vtHistoric.RootNodeCount > 0);
  tbLast.Enabled  := (Sender.AbsoluteIndex(Node) < (vtHistoric.RootNodeCount - 1))
                      and (vtHistoric.RootNodeCount > 0);
end;

procedure TCdOrdersHist.vtHistoricGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PHistorics;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.Item = nil) then exit;
  case Column of
    0: CellText := IntToStr(Data^.Index + 1);
    1: CellText := FormatDateTime('dd/mm/yyyy hh:mm:ss', Data^.Item.DtHrHist);
    2: CellText := Data^.Item.DscHist;
    3: CellText := Data^.Item.FkOrderStatus.DscStt;
  end;
end;

procedure TCdOrdersHist.tbInsertClick(Sender: TObject);
begin
  ClearControls;
  FkStatusOrder := ActiveOrder.FkOrderStatus;
  DtHrMsg       := Now;
  ScrState      := dbmInsert;
end;

procedure TCdOrdersHist.tbCancelClick(Sender: TObject);
begin
  if (FItemIndex < 0) then exit;
  MoveDataToControls;
  ScrState := dbmBrowse;
end;

procedure TCdOrdersHist.tbDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PHistorics;
begin
  Node := vtHistoric.GetFirst;
  if (Node = nil) then exit;
  Data := vtHistoric.GetNodeData(Node);
  if (Data = nil) or (Data^.Item = nil) or (Data^.Index < 0) then exit;
  vtHistoric.BeginUpdate;
  try
    Data^.Item.Free;
    Data^.Item := nil;
    Data^.Node := nil;
    ActiveOrder.OrderHistorics.Delete(Data^.Index);
    Data^.Index := 0;
    vtHistoric.DeleteNode(Node);
  finally
    vtHistoric.EndUpdate;
  end;
end;

procedure TCdOrdersHist.tbSaveClick(Sender: TObject);
begin
  SaveIntoDB;
end;

procedure TCdOrdersHist.tbFirstClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vtHistoric.FocusedNode;
  if (Node = nil) or (Node = vtHistoric.GetFirst) then exit;
  Node := vtHistoric.GetFirst;
  if (Node <> nil) then
  begin
    vtHistoric.FocusedNode := Node;
    vtHistoric.Selected[Node] := True;
  end;
end;

procedure TCdOrdersHist.tbPriorClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vtHistoric.FocusedNode;
  if (Node = nil) or (Node = vtHistoric.GetFirst) then exit;
  Node := vtHistoric.GetPrevious(Node);
  if (Node <> nil) then
  begin
    vtHistoric.FocusedNode := Node;
    vtHistoric.Selected[Node] := True;
  end;
end;

procedure TCdOrdersHist.tbNextClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vtHistoric.FocusedNode;
  if (Node = nil) or (Node = vtHistoric.GetLast) then exit;
  Node := vtHistoric.GetNext(Node);
  if (Node <> nil) then
  begin
    vtHistoric.FocusedNode := Node;
    vtHistoric.Selected[Node] := True;
  end;
end;

procedure TCdOrdersHist.tbLastClick(Sender: TObject);
var
  Node: PVirtualNode;
begin
  Node := vtHistoric.FocusedNode;
  if (Node = nil) or (Node = vtHistoric.GetLast) then exit;
  Node := vtHistoric.GetLast;
  if (Node <> nil) then
  begin
    vtHistoric.FocusedNode := Node;
    vtHistoric.Selected[Node] := True;
  end;
end;

procedure TCdOrdersHist.tbStatisticsClick(Sender: TObject);
begin
  if (pgHistoric.ActivePageIndex = 0) then
    pgHistoric.ActivePageIndex := 1
  else
    pgHistoric.ActivePageIndex := 0;
end;

procedure TCdOrdersHist.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  tbCancel.Enabled := (ScrState in UPDATE_MODE);
  tbSave.Enabled   := (ScrState in UPDATE_MODE);
  tbInsert.Enabled := (not tbCancel.Enabled) and (ScrState = dbmBrowse);
end;

procedure TCdOrdersHist.SetActiveOrder(const Value: TOrder);
  procedure SetOrderHistorics(AValue: TOrderHistorics);
  var
    i: Integer;
    Node: PVirtualNode;
    Data: PHistorics;
  begin
    ActiveOrder.OrderHistorics.Clear;
    if (AValue <> nil) then
      ActiveOrder.OrderHistorics := AValue;
    ReleaseTreeNodes(vtHistoric);
    for i := 0 to ActiveOrder.OrderHistorics.Count - 1 do
    begin
      Node := vtHistoric.AddChild(nil);
      if (Node <> nil) then
      begin
        Data := vtHistoric.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.Index := ActiveOrder.OrderHistorics.Items[i].Index;
          Data^.Item  := TOrderHistoric.Create(nil);
          Data^.Item.Assign(ActiveOrder.OrderHistorics.Items[i]);
          Data^.Level := 0;
          Data^.Node  := Node;
        end;
      end;
    end;
    if (vtHistoric.RootNodeCount > 0) then
    begin
      vtHistoric.FocusedNode := vtHistoric.GetFirst;
      vtHistoric. Selected[vtHistoric.FocusedNode] := True;
    end;
  end;
begin
  FActiveOrder.Clear;
  if (Value <> nil) then
  begin
    FActiveOrder.Assign(Value);
    SetOrderHistorics(FActiveOrder.OrderHistorics);
    if FActiveOrder.PkOrder > 0 then
      Pk := FActiveOrder.PkOrder;
  end;
end;

procedure TCdOrdersHist.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FActiveOrder);
end;

end.
