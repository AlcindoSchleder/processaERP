unit CadLinhas;

{*************************************************************************}
{*                                                                       *}
{* Author: CSD Informatica Ltda.                                         *}
{* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
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
  Dialogs, CadListModel, Mask, ToolEdit, CurrEdit, StdCtrls, VirtualTrees,
  ComCtrls, ToolWin, ExtCtrls, TSysEstqAux, ProcUtils;

type
  TCdLines = class(TfrmModelList)
    lPk_Linhas: TStaticText;
    ePk_Linhas: TEdit;
    eDsc_Lin: TEdit;
    lDsc_Lin: TStaticText;
    lFk_Tipo_Comissao: TStaticText;
    Shape1: TShape;
    lTitle: TLabel;
    eFk_Tipo_Comissao: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetAciveLines: TLines;
    function  GetFkTypeComission: Integer;
    function  GetDscLine: string;
    function  GetPkLine: Integer;
    procedure SetActiveLines(const Value: TLines);
    procedure SetFkTypeComission(const Value: Integer);
    procedure SetDscLine(const Value: string);
    procedure SetPkLine(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  ActiveLine     : TLines   read GetAciveLines      write SetActiveLines;
    property  PkLine         : Integer  read GetPkLine          write SetPkLine;
    property  DscLine        : string   read GetDscLine         write SetDscLine;
    property  FkTypeComission: Integer  read GetFkTypeComission write SetFkTypeComission;
  end;

var
  CdLines: TCdLines;

implementation

uses Dado, mSysEstq, ProcType, GridRow, FuncoesDB, DB;

{$R *.dfm}

function TCdLines.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := False;
  C := nil;
  if (DscLine = '') then
  begin
    S := 'Atenção: Campo Descrição deve conter um valor';
    C := eDsc_Lin;
  end;
 if (S <> '') then
  begin
    if (C = nil) then C := Self;
    Dados.DisplayHint(C, S);
  end
  else
    Result := True;
end;

procedure TCdLines.ClearControls;
begin
  Loading := True;
  try
    PkLine          := 0;
    DscLine         := '';
    FkTypeComission := 0;
  finally
    Loading := False;
  end;
end;

procedure TCdLines.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

function TCdLines.GetAciveLines: TLines;
begin
  Result := TLines.Create;
  Result.PkLines          := Pk;
  Result.DscLin           := DscLine;
  Result.FkTypeComission  := FkTypeComission;
end;

function TCdLines.GetFkTypeComission: Integer;
begin
  with eFk_Tipo_Comissao do
  begin
    Result := 0;
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdLines.GetDscLine: string;
begin
  Result := eDsc_Lin.Text;
end;

function TCdLines.GetPkLine: Integer;
begin
  Result := StrToInt(ePk_Linhas.Text);
end;

procedure TCdLines.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdLines.LoadList(Sender: TObject);
var
  aStr: TStrings;
  i   : Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := nil;
  inherited;
  if (RowModel = nil) or (RowModel.Count = 0) then
  begin
    if (RowModel = nil) then
      RowModel := TDataRow.Create(Self);
    RowModel.AddAs('DSC_LIN', '', ftString, 31);
    RowModel.AddAs('COM_LIN', 0.0, ftFloat, SizeOf(Double));
    RowModel.AddAs('PK_LINHAS', 0, ftInteger, SizeOf(Integer));
  end;
  ReleaseTreeNodes(vtList);
  aStr := dmSysEstq.LoadLinhas(False);
  for i := 0 to aStr.Count - 1 do
  begin
    if (aStr.Objects[i] <> nil) then
    begin
      Node := vtList.AddChild(nil);
      if (Node <> nil) then
      begin
        Data := vtList.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.DataRow := TDataRow.Create(nil);
          Data^.Level   := 0;
          Data^.Node    := Node;
          Data^.DataRow.AddAs('DSC_LIN', aStr.Strings[i], ftString, 31);
          Data^.DataRow.AddAs('FK_TIPO_COMISSAO', TLines(aStr.Objects[i]).FkTypeComission, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('PK_LINHAS', TLines(aStr.Objects[i]).PkLines, ftInteger, SizeOf(Integer));
        end;
      end;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode    := Node;
    vtList.Selected[Node] := True;
  end;
end;

procedure TCdLines.MoveDataToControls;
begin
  Loading := True;
  try
    ActiveLine := dmSysEstq.GetLine(Pk);
  finally
    Loading := False;
  end;
end;

procedure TCdLines.SaveIntoDB;
var
  aPk: Integer;
begin
  aPk := dmSysEstq.SaveLine(ActiveLine, ScrState);
  FocusedRow.FieldByName['PK_LINHAS'].AsInteger := aPk;
  FocusedRow.FieldByName['DSC_LIN'].AsString    := DscLine;
  FocusedRow.FieldByName['FK_TIPO_COMISSOES'].AsFloat     := FkTypeComission;
  Pk := APk;
end;

procedure TCdLines.SetActiveLines(const Value: TLines);
begin
  if (Value <> nil) then
  begin
    Value.PkLines         := Pk;
    Value.DscLin          := DscLine;
    Value.FkTypeComission := FkTypeComission;
  end;
end;

procedure TCdLines.SetFkTypeComission(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Comissao do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if ((Items.Objects[i] <> nil) and (Value = Integer(Items.Objects[i]))) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdLines.SetDscLine(const Value: string);
begin
  eDsc_Lin.Text := Value;
end;

procedure TCdLines.SetPkLine(const Value: Integer);
begin
  ePk_Linhas.Text := IntToStr(Value);
end;

procedure TCdLines.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_LINHAS'].AsInteger;
end;

procedure TCdLines.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column = 0) then
    CellText := Data^.DataRow.FieldByName['DSC_LIN'].AsString;
end;

initialization
  RegisterClass(TCdLines);

end.
