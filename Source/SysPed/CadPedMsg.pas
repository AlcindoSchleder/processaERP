unit CadPedMsg;

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
  Dialogs, StdCtrls, ComCtrls, VirtualTrees, ToolWin, Menus, TSysPed, PrcCombo,
  ProcUtils, CadModel;

type
  POrdMessage = ^TOrdMessage;
  TOrdMessage = record
    Node : PVirtualNode;
    Msg  : TOrderMessage;
    Index: Integer;
  end;

  TCdPedMsg = class(TfrmModel)
    pgMessages: TPageControl;
    tsData: TTabSheet;
    tsList: TTabSheet;
    lFk_Departamentos: TStaticText;
    eFk_Departamentos: TPrcComboBox;
    eText_Msg: TMemo;
    eHor_Msg: TDateTimePicker;
    eDta_Msg: TDateTimePicker;
    lDtHr_Msg: TStaticText;
    vtMessages: TVirtualStringTree;
    cbMessage: TCoolBar;
    tbTools: TToolBar;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    tbToolSep: TToolButton;
    tbSave: TToolButton;
    tbNavigation: TToolBar;
    tbPrior: TToolButton;
    tbNext: TToolButton;
    eDtHr_Rcbm: TEdit;
    ToolButton1: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure vtMessagesDblClick(Sender: TObject);
    procedure vtMessagesGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure ChangeState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure tbSaveClick(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbPriorClick(Sender: TObject);
    procedure tbNextClick(Sender: TObject);
  private
    FActiveOrder: TOrder;
    FItemIndex: Integer;
    { Private declarations }
    function  GetActiveMsg: TOrderMessage;
    function  GetQtdMsg: Integer;
    function  GetOrderMessages: TOrderMessages;
    function  GetFkDepartament: Integer;
    procedure SetFkDepartament(AValue: Integer);
    function  GetDtHrMsg: TDateTime;
    procedure SetDtHrMsg(AValue: TDateTime);
    function  GetDtHrRcbm: TDateTime;
    procedure SetDtHrRcbm(AValue: TDateTime);
    function  GetTextMsg: TStrings;
    procedure SetTextMsg(AValue: TStrings);
    procedure SetActiveOrder(const Value: TOrder);
  public
    { Public declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    property  ActiveOrder  : TOrder         read FActiveOrder     write SetActiveOrder;
    property  ItemIndex    : Integer        read FItemIndex       write FItemIndex default -1;
    property  ActiveMsg    : TOrderMessage  read GetActiveMsg;
    property  QtdMsg       : Integer        read GetQtdMsg;
    property  OrderMessages: TOrderMessages read GetOrderMessages;
    property  FkDepartament: Integer        read GetFkDepartament write SetFkDepartament;
    property  DtHrMsg      : TDateTime      read GetDtHrMsg       write SetDtHrMsg;
    property  DtHrRcbm     : TDateTime      read GetDtHrRcbm      write SetDtHrRcbm;
    property  TextMsg      : TStrings       read GetTextMsg       write SetTextMsg;
  end;

implementation

{$R *.dfm}

uses Dado, mSysPed, DateUtils;

procedure TCdPedMsg.FormCreate(Sender: TObject);
begin
  cbMessage.Images         := Dados.Image16;
  tbTools.Images           := Dados.Image16;
  tbNavigation.Images      := Dados.Image16;
  vtMessages.Images        := Dados.Image16;
  vtMessages.Header.Images := Dados.Image16;
  vtMessages.NodeDataSize  := SizeOf(TOrdMessage);
  OnInternalState          := ChangeState;
  FActiveOrder             := TOrder.Create(Dados.DecimalPlaces);
  inherited;
end;

procedure TCdPedMsg.LoadDefaults;
begin
  if (not ListLoaded) then
    eFk_Departamentos.Items.AddStrings(dmSysPed.LoadDepartament);
  MoveDataToControls;
end;

procedure TCdPedMsg.MoveDataToControls;
begin
  Loading := True;
  try
    FkDepartament := ActiveMsg.FkDepartament;
    DtHrMsg       := ActiveMsg.DtHrMsg;
    DtHrRcbm      := ActiveMsg.DtHrRcbm;
    TextMsg       := ActiveMsg.TextMsg;
  finally
    Loading       := False;
  end;
end;

procedure TCdPedMsg.ClearControls;
begin
  Loading := True;
  try
    FkDepartament := 0;
    DtHrMsg       := 0;
    DtHrRcbm      := 0;
    TextMsg       := nil;
  finally
    Loading       := False;
  end;
end;

procedure TCdPedMsg.SaveIntoDB;
var
  Node: PVirtualNode;
  Data: POrdMessage;
begin
  if (ActiveMsg = nil) then
    Node := vtMessages.AddChild(nil)
  else
    Node := vtMessages.FocusedNode;
  if (Node = nil) then exit;
  Data := vtMessages.GetNodeData(Node);
  if (Data = nil) then exit;
  Data^.Node := Node;
  Data^.Msg               := TOrderMessage.Create(nil);
  Data^.Msg.FkDepartament := FkDepartament;
  Data^.Msg.DscDpto       := eFk_Departamentos.Text;
  Data^.Msg.DtHrMsg       := DtHrMsg;
  Data^.Msg.DtHrRcbm      := DtHrRcbm;
  Data^.Msg.TextMsg       := TextMsg;
  Data^.Index             := OrderMessages.AddMsg(Data^.Msg);
  vtMessages.FocusedNode  := Node;
end;

procedure TCdPedMsg.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  tbCancel.Enabled := (AState in UPDATE_MODE);
  tbDelete.Enabled := (AState in SCROLL_MODE) and (vtMessages.RootNodeCount > 0);
  tbSave.Enabled   := (AState in UPDATE_MODE);
  tbPrior.Enabled  := (AState in SCROLL_MODE) and (vtMessages.RootNodeCount > 0) and
                      (vtMessages.FocusedNode <> vtMessages.GetFirst);
  tbNext.Enabled   := (AState in SCROLL_MODE) and (vtMessages.RootNodeCount > 0) and
                      (vtMessages.FocusedNode <> vtMessages.GetLast);
end;

function  TCdPedMsg.GetActiveMsg: TOrderMessage;
var
  Data: POrdMessage;
begin
  Result := nil;
  if (vtMessages.FocusedNode <> nil) then
  begin
    Data := vtMessages.GetNodeData(vtMessages.FocusedNode);
    if (Data <> nil) and (Data^.Msg <> nil) then
    begin
      FItemIndex := Data^.Index;
      if (FItemIndex > -1) and (FItemIndex < ActiveOrder.OrderMessages.Count) then
        Result    := ActiveOrder.OrderMessages.Items[FItemIndex];
    end;
  end;
end;

function  TCdPedMsg.GetQtdMsg: Integer;
begin
  Result := OrderMessages.Count;
end;

function  TCdPedMsg.GetOrderMessages: TOrderMessages;
begin
  Result := nil;
  if (FActiveOrder <> nil) then
    Result := FActiveOrder.OrderMessages;
end;

function  TCdPedMsg.GetFkDepartament: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Departamentos.ItemIndex;
  if (AIdx > 0) and (eFk_Departamentos.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Departamentos.Items.Objects[aIdx]);
end;

procedure TCdPedMsg.SetFkDepartament(AValue: Integer);
begin
  eFk_Departamentos.SetIndexFromIntegerValue(AValue)
end;

function  TCdPedMsg.GetDtHrMsg: TDateTime;
begin
  Result := eDta_Msg.Date + eHor_Msg.Time;
end;

procedure TCdPedMsg.SetDtHrMsg(AValue: TDateTime);
begin
  if (AValue > 0) then
  begin
    eHor_Msg.Time := TimeOf(AValue);
    eDta_Msg.Date := DateOf(AValue);
  end
  else
  begin
    eHor_Msg.Time := Time;
    eDta_Msg.Date := Date;
  end;
end;

function  TCdPedMsg.GetDtHrRcbm: TDateTime;
begin
  Result := 0;
  if (ActiveMsg <> nil) then
    Result := ActiveMsg.DtHrRcbm;
end;

procedure TCdPedMsg.SetDtHrRcbm(AValue: TDateTime);
begin
 eDtHr_Rcbm.ReadOnly := False;
  if (AValue > 0) then
    eDtHr_Rcbm.Text := DateTimeToStr(AValue)
  else
    eDtHr_Rcbm.Text := '';
 eDtHr_Rcbm.ReadOnly := True;
end;

function  TCdPedMsg.GetTextMsg: TStrings;
begin
  Result := eText_Msg.Lines;
end;

procedure TCdPedMsg.SetTextMsg(AValue: TStrings);
begin
  if (AValue = nil) then
    eText_Msg.Lines.Clear
  else
    eText_Msg.Lines.Assign(AValue);
end;

procedure TCdPedMsg.vtMessagesDblClick(Sender: TObject);
begin
  pgMessages.ActivePageIndex := 0;
  MoveDataToControls;
end;

procedure TCdPedMsg.vtMessagesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: POrdMessage;
  PosR: Integer;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.Msg = nil) then exit;
  if Pos(#10, Data^.Msg.TextMsg.Text) > 0 then
    PosR := Pos(#10, Data^.Msg.TextMsg.Text)
  else
    if Pos(#13, Data^.Msg.TextMsg.Text) > 0 then
      PosR := Pos(#13, Data^.Msg.TextMsg.Text)
    else
      PosR := Length(Data^.Msg.TextMsg.Text);
  case Column of
    0: if (Data^.Msg.DscDpto = '') then
         CellText := '<Nenhum>'
       else
         CellText := Data^.Msg.DscDpto;
    1: CellText := DateTimeToStr(Data^.Msg.DtHrMsg);
    2: if (Data^.Msg.DtHrRcbm = 0) then
         CellText := ' '
       else
         CellText := DateTimeToStr(Data^.Msg.DtHrRcbm);
    3: CellText := Copy(Data^.Msg.TextMsg.Text, 1, PosR);
  end;
end;

procedure TCdPedMsg.tbSaveClick(Sender: TObject);
begin
  SaveIntoDB;
  ScrState := dbmBrowse;
  pgMessages.ActivePageIndex := 1;
end;

procedure TCdPedMsg.tbInsertClick(Sender: TObject);
begin
  SaveIntoDB;
  ScrState := dbmBrowse;
  ClearControls;
  vtMessages.FocusedNode := nil;
  ScrState := dbmInsert;
end;

procedure TCdPedMsg.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmBrowse;
  ClearControls;
  pgMessages.ActivePageIndex := 1;
end;

procedure TCdPedMsg.tbDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: POrdMessage;
begin
  Node := vtMessages.FocusedNode;
  if (Node = nil) then exit;
  Data := vtMessages.GetNodeData(Node);
  if (Data = nil) then exit;
  OrderMessages.Delete(Data^.Index);
  Data^.Node := nil;
  Data^.Msg.Free;
  Data^.Msg  := nil;
  if (vtMessages.RootNodeCount > 1) then
    vtMessages.FocusedNode := vtMessages.GetNext(Node);
  vtMessages.DeleteNode(Node);
  ScrState := dbmBrowse;
end;

procedure TCdPedMsg.tbPriorClick(Sender: TObject);
begin
  if (vtMessages.FocusedNode = nil) then exit;
  vtMessages.FocusedNode := vtMessages.GetPrevious(vtMessages.FocusedNode);
  tbPrior.Enabled  := (ScrState in SCROLL_MODE) and (vtMessages.RootNodeCount > 0) and
                      (vtMessages.FocusedNode <> vtMessages.GetFirst);
end;

procedure TCdPedMsg.tbNextClick(Sender: TObject);
begin
  if (vtMessages.FocusedNode = nil) then exit;
  vtMessages.FocusedNode := vtMessages.GetNext(vtMessages.FocusedNode);
  tbNext.Enabled   := (ScrState in SCROLL_MODE) and (vtMessages.RootNodeCount > 0) and
                      (vtMessages.FocusedNode <> vtMessages.GetLast);
end;

procedure TCdPedMsg.SetActiveOrder(const Value: TOrder);
  procedure SetOrderMessages;
  var
    Node: PVirtualNode;
    Data: POrdMessage;
    i: Integer;
  begin
    if (OrderMessages.Count > 0) then
    begin
      Node := vtMessages.GetFirst;
      while (Node <> nil) do
      begin
        Data := vtMessages.GetNodeData(Node);
        if (Data <> nil) and (Data^.Msg <> nil) then
        begin
          Data^.Msg.Free;
          Data^.Msg  := nil;
          Data^.Node := nil;
        end;
      end;
      vtMessages.Clear;
      for i := 0 to OrderMessages.Count - 1 do
      begin
        Node := vtMessages.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtMessages.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Node  := Node;
            Data^.Msg   := TOrderMessage.Create(nil);
            Data^.Msg   := OrderMessages.Items[i];
            Data^.Index := i;
          end;
        end;
      end;
      vtMessages.FocusedNode := vtMessages.GetFirst;
    end;
  end;
begin
  FActiveOrder.Clear;
  if (Value <> nil) then
  begin
    FActiveOrder.Assign(Value);
    SetOrderMessages;
    if FActiveOrder.PkOrder > 0 then
      Pk := FActiveOrder.PkOrder;
  end;
end;

end.
