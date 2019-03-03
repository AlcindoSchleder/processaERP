unit CadMsk;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 26/03/2006 - DD/MM/YYYY                                     *}
{* Version: 2.0.0.0                                                      *}
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
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, GridRow,
  ProcUtils, Mask, ExtCtrls;

type
  TCdMasks = class(TfrmModelList)
    eMsk_Msk: TEdit;
    lMsk_Msk: TStaticText;
    eDsc_Msk: TEdit;
    lDsc_Msk: TStaticText;
    lPk_Mascaras: TStaticText;
    ePk_Mascaras: TEdit;
    lTest: TStaticText;
    eTest: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure eMsk_MskChange(Sender: TObject);
  private
    { Private declarations }
    FFkLanguage: string;
    function  GetDscMask: string;
    function  GetMask: string;
    function  GetMaskData: TDataRow;
    function  GetPkMask: Integer;
    procedure SetDscMask(const Value: string);
    procedure SetMask(const Value: string);
    procedure SetMaskData(const Value: TDataRow);
    procedure SetPkMask(const Value: Integer);
    property  MaskData  : TDataRow read GetMaskData   write SetMaskData;
    property  PkMask    : Integer  read GetPkMask     write SetPkMask;
    property  DscMask   : string   read GetDscMask    write SetDscMask;
    property  Mask      : string   read GetMask       write SetMask;
    procedure ConfigDataScreen(CtrlEnabled: Boolean);
  protected
    { Protected declarations }
    procedure InsertListData(Sender: TObject; var Row: TDataRow);
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property OnListLoad;
  end;

var
  CdMasks: TCdMasks;

implementation

uses Dado, mSysMan, DB, ProcType, ManArqSql;

{$R *.dfm}

{ TCdMasks }

function TCdMasks.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  C      := Self;
  Result := True;
  if (DscMask = '') then
  begin
    S := 'Campo Descrição deve conter um valor';
    C := eDsc_Msk;
  end;
  if (Mask = '') then
  begin
    S := 'Campo Máscara deve conter um valor';
    C := eMsk_Msk;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdMasks.ClearControls;
begin
  Loading   := True;
  try
    PkMask  := 0;
    DscMask := '';
    Mask    := '';
  finally
    Loading := False;
  end;
end;

function TCdMasks.GetDscMask: string;
begin
  Result := eDsc_Msk.Text;
end;

function TCdMasks.GetMask: string;
begin
  Result := eMsk_Msk.Text;
end;

function TCdMasks.GetMaskData: TDataRow;
begin
  Result := TDataRow.Create(Self);
  Result.AddAs('PK_LINGUAGENS', FFkLanguage, ftString,  6);
  Result.AddAs('DSC_LANG',      FocusedRow.FieldByName['DSC_LANG'].AsString, ftString, 31);
  Result.AddAs('FK_LINGUAGENS', FFkLanguage, ftString,  6);
  Result.AddAs('PK_MASCARAS',   PkMask,      ftInteger, SizeOf(Integer));
  Result.AddAs('DSC_MSK',       DscMask,     ftString,  31);
  Result.AddAs('MSK_MSK',       Mask,        ftString,  31);
end;

function TCdMasks.GetPkMask: Integer;
begin
  Result := StrToIntDef(ePk_Mascaras.Text, 0);
end;

procedure TCdMasks.InsertListData(Sender: TObject; var Row: TDataRow);
begin
  Row.AddAs('PK_LINGUAGENS', FFkLanguage, ftString,  6);
  Row.AddAs('DSC_LANG',      FocusedRow.FieldByName['DSC_LANG'].AsString, ftString, 31);
  Row.AddAs('FK_LINGUAGENS', FFkLanguage, ftString,  6);
  Row.AddAs('PK_MASCARAS',   0,           ftInteger, SizeOf(Integer));
  Row.AddAs('DSC_MSK',       '',          ftString,  31);
  Row.AddAs('MSK_MSK',       '',          ftString,  31);
end;

procedure TCdMasks.LoadDefaults;
begin
//  nothing to do
end;

procedure TCdMasks.LoadList;
var
  Node: PVirtualNode;
  aStr: string;
begin
  aStr := '';
  Node := nil;
  inherited;
  with dmSysMan do
  begin
    if qrMask.Active then qrMask.Close;
    qrMask.SQL.Clear;
    qrMask.SQL.Add(SqlAllMaskData);
    Dados.StartTransaction(qrMask);
    try
      if (not qrMask.Active) then qrMask.Open;
      while (not qrMask.Eof) do
      begin
        if (aStr <> qrMask.FieldByName('DSC_LANG').AsString) then
          Node := AddDataNode(nil, qrMask);
        if (Node <> nil) and (qrMask.FieldByName('FK_LINGUAGENS').AsString <> '') then
          AddDataNode(Node, qrMask);
        aStr := qrMask.FieldByName('DSC_LANG').AsString;
        qrMask.Next;
      end;
    finally
      if qrMask.Active then qrMask.Close;
      Dados.CommitTransaction(qrMask);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FullExpand;
    Node := vtList.GetFirstChild(vtList.GetFirst);
    if (Node = nil) then exit;
    vtList.FocusedNode    := Node;
    vtList.Selected[Node] := True;
  end;
end;

procedure TCdMasks.MoveDataToControls;
begin
  Loading := True;
  try
    if (FocusedRow <> nil) then
      MaskData := dmSysMan.GetMask(Pk, FocusedRow.FieldByName['PK_LINGUAGENS'].AsString);
  finally
    Loading := False;
  end;
end;

procedure TCdMasks.SaveIntoDB;
var
  APk: Integer;
begin
  APk := dmSysMan.SaveMask(MaskData, ScrState);
  if (APk > 0) and (FocusedRow <> nil) then
  begin
    FocusedRow.FieldByName['PK_LINGUAGENS'].AsString := FFkLanguage;
    FocusedRow.FieldByName['FK_LINGUAGENS'].AsString := FFkLanguage;
    FocusedRow.FieldByName['PK_MASCARAS'].AsInteger  := APk;
    FocusedRow.FieldByName['DSC_MSK'].AsString       := DscMask;
  end;
  Pk := APk;
end;

procedure TCdMasks.SetDscMask(const Value: string);
begin
  eDsc_Msk.Text := Value;
end;

procedure TCdMasks.SetMask(const Value: string);
begin
  eMsk_Msk.Text := Value;
end;

procedure TCdMasks.SetMaskData(const Value: TDataRow);
begin
  if (Value = nil) then exit;
  PkMask  := Value.FieldByName['PK_MASCARAS'].AsInteger;
  DscMask := Value.FieldByName['DSC_MSK'].AsString;
  Mask    := Value.FieldByName['MSK_MSK'].AsString;
end;

procedure TCdMasks.SetPkMask(const Value: Integer);
begin
  ePk_Mascaras.Text := IntToStr(Value);
end;

procedure TCdMasks.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnInsert      := InsertListData;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdMasks.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column = 0) then
    if (Sender.GetNodeLevel(Node) = 0) then
      CellText := Data^.DataRow.FieldByName['DSC_LANG'].AsString
    else
      CellText := Data^.DataRow.FieldByName['DSC_MSK'].AsString;
end;

procedure TCdMasks.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
  CtlrEnabled: Boolean;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CtlrEnabled := (Sender.GetNodeLevel(Node) > 0);
  ConfigDataScreen(CtlrEnabled);
  if (Data^.DataRow.FieldByName['PK_LINGUAGENS'].AsString <> '') then
    FFkLanguage := Data^.DataRow.FieldByName['PK_LINGUAGENS'].AsString;
  if (CtlrEnabled) then
    Pk := Data^.DataRow.FieldByName['PK_MASCARAS'].AsInteger;
end;

procedure TCdMasks.ConfigDataScreen(CtrlEnabled: Boolean);
begin
  if (not CtrlEnabled) then ClearControls;
  lPk_Mascaras.Enabled := CtrlEnabled;
  ePk_Mascaras.Enabled := CtrlEnabled;
  lDsc_Msk.Enabled     := CtrlEnabled;
  eDsc_Msk.Enabled     := CtrlEnabled;
  lMsk_Msk.Enabled     := CtrlEnabled;
  eMsk_Msk.Enabled     := CtrlEnabled;
  lTest.Enabled        := CtrlEnabled and (Mask <> '');
  eTest.Enabled        := CtrlEnabled and (Mask <> '');
end;

procedure TCdMasks.eMsk_MskChange(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (Mask <> '') then
    eTest.EditMask     := Mask
  else
    eTest.EditMask     := '';
end;

initialization
   RegisterClass(TCdMasks);

end.
