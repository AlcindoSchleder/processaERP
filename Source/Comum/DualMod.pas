unit DualMod;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
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

uses SysUtils, Classes, ProcType, GridRow,
  {$IFNDEF LINUX}
    Windows, Forms, Dialogs, Controls, StdCtrls, Buttons
  {$ELSE}
    Qt, QForms, QDialogs, QControls, QStdCtrls, QButtons
  {$ENDIF};

type
  TDualOrder = class(TForm)
    SrcList  : TListBox;
    DstList  : TListBox;
    SrcLabel : TLabel;
    DstLabel : TLabel;
    sbInclude: TSpeedButton;
    sbIncAll : TSpeedButton;
    sbExclude: TSpeedButton;
    sbExAll  : TSpeedButton;
    sbCancel : TSpeedButton;
    sbOk     : TSpeedButton;
    sbHelp   : TSpeedButton;
    sbUp     : TSpeedButton;
    sbDown   : TSpeedButton;
    procedure sbIncludeClick(Sender: TObject);
    procedure sbExcludeClick(Sender: TObject);
    procedure sbIncAllClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbUpClick(Sender: TObject);
    procedure DstListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbDownClick(Sender: TObject);
  private
    { Private declarations }
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function  GetFirstSelection(List: TCustomListBox): Integer;
    procedure SetButtons;
  public
    { Public declarations }
    FDataRow: TDataRow;
    constructor Create(AOwner: TComponent; ADataRow: TDataRow); reintroduce;
  end;

var
  DualOrder: TDualOrder;

implementation

uses CmmConst;

{$R *.dfm}

constructor TDualOrder.Create(AOwner: TComponent; ADataRow: TDataRow);
begin
  if (ADataRow = nil) then
    raise Exception.Create('Erro: Campo DataRow não pode ser nulo');
  inherited Create(AOwner);
  FDataRow := ADataRow;
end;

procedure TDualOrder.sbOkClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to SrcList.Count - 1 do
    if (SrcList.Items.Objects[i] <> nil) and
       (SrcList.Items.Objects[i] is TDataField) then
      TDataField(SrcList.Items.Objects[i]).FieldFlags :=
        TDataField(SrcList.Items.Objects[i]).FieldFlags - [ffOrder];
  for i := 0 to SrcList.Count - 1 do
    if (SrcList.Items.Objects[i] <> nil) and
       (SrcList.Items.Objects[i] is TDataField) then
      TDataField(SrcList.Items.Objects[i]).FieldFlags :=
        TDataField(SrcList.Items.Objects[i]).FieldFlags + [ffOrder];
  ModalResult := mrOk;
end;

procedure TDualOrder.sbCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDualOrder.FormActivate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to FDataRow.Count - 1 do
  begin
    if FDataRow.Fields[i].IsCommanded then
      DstList.Items.AddObject(FDataRow.Fields[i].DisplayName, FDataRow.Fields[i])
    else
      SrcList.Items.AddObject(FDataRow.Fields[i].DisplayName, FDataRow.Fields[i]);
  end;
end;

procedure TDualOrder.FormDestroy(Sender: TObject);
begin
  FDataRow := nil;
end;

procedure TDualOrder.sbIncludeClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(SrcList);
  MoveSelected(SrcList, DstList.Items);
  SetItem(SrcList, Index);
end;

procedure TDualOrder.sbExcludeClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  MoveSelected(DstList, SrcList.Items);
  SetItem(DstList, Index);
end;

procedure TDualOrder.sbIncAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to SrcList.Items.Count - 1 do
    DstList.Items.AddObject(SrcList.Items[I],
      SrcList.Items.Objects[I]);
  SrcList.Items.Clear;
  SetItem(SrcList, 0);
end;

procedure TDualOrder.ExcAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DstList.Items.Count - 1 do
    SrcList.Items.AddObject(DstList.Items[I], DstList.Items.Objects[I]);
  DstList.Items.Clear;
  SetItem(DstList, 0);
end;

procedure TDualOrder.MoveSelected(List: TCustomListBox; Items: TStrings);
var
  i: Integer;
begin
  for i := List.Items.Count - 1 downto 0 do
    if List.Selected[i] then
    begin
      Items.AddObject(List.Items[i], List.Items.Objects[i]);
      List.Items.Delete(i);
    end;
end;

procedure TDualOrder.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty           := SrcList.Items.Count = 0;
  DstEmpty           := DstList.Items.Count = 0;
  sbInclude.Enabled := not SrcEmpty;
  sbIncAll.Enabled  := not SrcEmpty;
  sbExclude.Enabled := not DstEmpty;
  sbExAll.Enabled   := not DstEmpty;
end;

function TDualOrder.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
  Result := -1;
end;

procedure TDualOrder.SetItem(List: TListBox; Index: Integer);
var
  MaxIndex: Integer;
begin
  with List do
  begin
    SetFocus;
    MaxIndex := List.Items.Count - 1;
    if Index = -1 then
      Index := 0
    else
      if Index > MaxIndex then
        Index := MaxIndex;
    Selected[Index] := True;
  end;
  SetButtons;
end;

procedure TDualOrder.sbUpClick(Sender: TObject);
begin
  if DstList.ItemIndex > 0 then
    DstList.Items.Move(DstList.ItemIndex, DstList.ItemIndex - 1);
  sbUp.Enabled   := DstList.ItemIndex > 0;
  sbDown.Enabled := DstList.ItemIndex < (DstList.Count - 1);
end;

procedure TDualOrder.DstListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP  : sbUpClick(Sender);
    VK_DOWN: sbDownClick(Sender);
  end;
end;

procedure TDualOrder.sbDownClick(Sender: TObject);
begin
  if DstList.ItemIndex < (DstList.Count - 1) then
    DstList.Items.Move(DstList.ItemIndex, DstList.ItemIndex + 1);
  sbUp.Enabled   := DstList.ItemIndex > 0;
  sbDown.Enabled := DstList.ItemIndex < (DstList.Count - 1);
end;

end.
