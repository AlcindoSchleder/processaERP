unit CadMsg;

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
  Dialogs, CadListModel, StdCtrls, VirtualTrees, ComCtrls, ToolWin, GridRow,
  ProcUtils, ImgList, ExtCtrls;

type
  TCdMessage = class(TfrmModelList)
    lPK_Mensagens: TStaticText;
    ePK_Mensagens: TEdit;
    lNom_Cnst: TStaticText;
    eNom_Cnst: TEdit;
    eDsc_Cnst: TEdit;
    lDsc_Cnst: TStaticText;
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFkLng: string;
    FFkMod: Integer;
    FFkRot: Integer;
    FFkPrg: Integer;
    function  GetDscCnst: string;
    function  GetNameCnst: string;
    function  GetPkMessage: Integer;
    function  GetSysMessages: TDataRow;
    procedure SetDscCnst(const Value: string);
    procedure SetNameCnst(const Value: string);
    procedure SetPkMessage(const Value: Integer);
    procedure SetSysMessages(const Value: TDataRow);
    procedure ConfigDataScreen(const ALevel: Integer);
    property  SysMessages: TDataRow read GetSysMessages write SetSysMessages;
    property  PkMessage  : Integer  read GetPkMessage   write SetPkMessage;
    property  NameCnst   : string   read GetNameCnst    write SetNameCnst;
    property  DscCnst    : string   read GetDscCnst     write SetDscCnst;
  protected
    { Protected declarations }
    function  GetParamFields: TStrings;
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
  CdMessage: TCdMessage;

implementation

uses Dado, mSysMan, ProcType, ManArqSql, DB;

{$R *.dfm}

{ TCdMessage }

function TCdMessage.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C: TControl;
  S: string;
begin
  Result := True;
  C      := Self;
  S      := '';
  if (DscCnst = '') then
  begin
    S := 'Campo descrição deve conter um valor';
    C := eDsc_Cnst;
  end;
  if (NameCnst = '') then
  begin
    S := 'Campo Nome da constante deve conter um valor';
    C := eNom_Cnst;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdMessage.ClearControls;
begin
  Loading := True;
  try
    PkMessage := 0;
    NameCnst  := '';
    DscCnst   := '';
  finally
    Loading := False;
  end;
end;

function TCdMessage.GetDscCnst: string;
begin
  Result := eDsc_Cnst.Text;
end;

function TCdMessage.GetNameCnst: string;
begin
  Result := eNom_Cnst.Text;
end;

function TCdMessage.GetParamFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_LINGUAGENS');
  Result.Add('FK_MODULOS');
  Result.Add('FK_ROTINAS');
  Result.Add('FK_PROGRAMAS');
  Result.Add('PK_MENSAGENS');
  Result.Add('NOM_CNST');
  Result.Add('DSC_CNST');
end;

function TCdMessage.GetPkMessage: Integer;
begin
  Result := StrToIntDef(ePk_Mensagens.Text, 0);
end;

function TCdMessage.GetSysMessages: TDataRow;
begin
  Result := TDataRow.Create(Self);
  Result.AddAs('FK_LINGUAGENS', FFkLng, ftString, 6);
  Result.AddAs('FK_MODULOS', FFkMod, ftInteger, SizeOf(Integer));
  Result.AddAs('FK_ROTINAS', FFkRot, ftInteger, SizeOf(Integer));
  Result.AddAs('FK_PROGRAMAS', FFkPrg, ftInteger, SizeOf(Integer));
  Result.AddAs('PK_MENSAGENS', PkMessage, ftInteger, SizeOf(Integer));
  Result.AddAs('NOM_CNST', NameCnst, ftString, 31);
  Result.AddAs('DSC_CNST', DscCnst, ftString, 31);
end;

procedure TCdMessage.LoadDefaults;
begin
// nothing to do
end;

procedure TCdMessage.LoadList(Sender: TObject);
var
  Chl0: PVirtualNode;
  Chl1: PVirtualNode;
  Chl2: PVirtualNode;
  Chl3: PVirtualNode;
  aSl0: string;
  aSl1: string;
  aSl2: string;
  aSl3: string;
begin
  inherited;
  aSl0 := '';
  aSl1 := '';
  aSl2 := '';
  aSl3 := '';
  Chl0 := nil;
  Chl1 := nil;
  Chl2 := nil;
  Chl3 := nil;
  with dmSysMan do
  begin
    if qrMessage.Active then qrMessage.Close;
    qrMessage.SQL.Clear;
    qrMessage.SQL.Add(SqlMensagens);
    Dados.StartTransaction(qrMessage);
    try
      if (not qrMessage.Active) then qrMessage.Open;
      while (not qrMessage.Eof) do
      begin
        if (aSl0 <> qrMessage.FieldByName('DSC_LANG').AsString) then
          Chl0 := AddDataNode(nil, qrMessage);
        if (Chl0 <> nil) and (aSl1 <> qrMessage.FieldByName('DSC_MOD').AsString) then
          Chl1 := AddDataNode(Chl0, qrMessage);
        if (Chl1 <> nil) and (aSl2 <> qrMessage.FieldByName('DSC_ROT').AsString) then
          Chl2 := AddDataNode(Chl1, qrMessage);
        if (Chl2 <> nil) and (aSl3 <> qrMessage.FieldByName('DSC_PRG').AsString) then
          Chl3 := AddDataNode(Chl2, qrMessage);
        if (Chl3 <> nil) and (qrMessage.FieldByName('DSC_CNST').AsString <> '') then
          AddDataNode(Chl3, qrMessage);
        aSl0 := qrMessage.FieldByName('DSC_LANG').AsString;
        aSl1 := qrMessage.FieldByName('DSC_MOD').AsString;
        aSl2 := qrMessage.FieldByName('DSC_ROT').AsString;
        aSl3 := qrMessage.FieldByName('DSC_PRG').AsString;
        qrMessage.Next;
      end;
    finally
      if qrMessage.Active then qrMessage.Close;
      Dados.CommitTransaction(qrMessage);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FullExpand;
    Chl0 := vtList.GetFirstChild(vtList.GetFirst);
    if (Chl0 = nil) then exit;
    vtList.FocusedNode    := Chl0;
    vtList.Selected[Chl0] := True;
  end;
end;

procedure TCdMessage.MoveDataToControls;
begin
  Loading := True;
  try
    SysMessages := dmSysMan.GetMessages(Pk, FFkLng);
  finally
    Loading := False;
  end;
end;

procedure TCdMessage.SaveIntoDB;
var
 aPk: Integer;
begin
  aPk := dmSysMan.SaveMessage(SysMessages, ScrState);
  if (FocusedRow <> nil) then
  begin
    FocusedRow.FieldByName['PK_MENSAGENS'].AsInteger := aPk;
    FocusedRow.FieldByName['DSC_CNST'].AsString      := DscCnst;
  end;
end;

procedure TCdMessage.SetDscCnst(const Value: string);
begin
  eDsc_Cnst.Text := Value;
end;

procedure TCdMessage.SetNameCnst(const Value: string);
begin
  eNom_Cnst.Text := Value;
end;

procedure TCdMessage.SetPkMessage(const Value: Integer);
begin
  ePK_Mensagens.Text := IntToStr(Value);
end;

procedure TCdMessage.SetSysMessages(const Value: TDataRow);
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  PkMessage := Value.FieldByName['PK_MENSAGENS'].AsInteger;
  DscCnst   := Value.FieldByName['DSC_CNST'].AsString;
  NameCnst  := Value.FieldByName['NOM_CNST'].AsString;
end;

procedure TCdMessage.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data.DataRow = nil) then exit;
  FFkLng := Data^.DataRow.FieldByName['PK_LINGUAGENS'].AsString;
  if (Data^.DataRow.FieldByName['PK_MODULOS'].AsInteger = 0) then
    FFkMod := Data^.DataRow.FieldByName['FK_MODULOS'].AsInteger
  else
    FFkMod := Data^.DataRow.FieldByName['PK_MODULOS'].AsInteger;
  if (Data^.DataRow.FieldByName['PK_ROTINAS'].AsInteger = 0) then
    FFkRot := Data^.DataRow.FieldByName['FK_ROTINAS'].AsInteger
  else
    FFkRot := Data^.DataRow.FieldByName['PK_ROTINAS'].AsInteger;
  if (Data^.DataRow.FieldByName['PK_PROGRAMAS'].AsInteger = 0) then
    FFkPrg := Data^.DataRow.FieldByName['FK_PROGRAMAS'].AsInteger
  else
    FFkPrg := Data^.DataRow.FieldByName['PK_PROGRAMAS'].AsInteger;
  if (Sender.GetNodeLevel(Node) = 4) then
    Pk   := Data^.DataRow.FieldByName['PK_MENSAGENS'].AsInteger
  else
    Pk   := 0;
  ConfigDataScreen(Sender.GetNodeLevel(Node));
end;

procedure TCdMessage.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data.DataRow = nil) or (Column <> 0) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['DSC_LANG'].AsString;
    1: if (Data^.DataRow.FieldByName['DSC_MOD'].AsString = '') then
         CellText := 'Módulo Genérico'
       else
         CellText := Data^.DataRow.FieldByName['DSC_MOD'].AsString;
    2: if (Data^.DataRow.FieldByName['DSC_ROT'].AsString = '') then
         CellText := 'Rotina Genérica'
       else
         CellText := Data^.DataRow.FieldByName['DSC_ROT'].AsString;
    3: if (Data^.DataRow.FieldByName['DSC_PRG'].AsString = '') then
         CellText := 'Programa Genérico'
       else
         CellText := Data^.DataRow.FieldByName['DSC_PRG'].AsString;
    4: CellText := Data^.DataRow.FieldByName['DSC_CNST'].AsString;
  end;
end;

procedure TCdMessage.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data.DataRow = nil) or (Column <> 0) or
     (Kind in [ikState, ikOverlay]) then
    exit;
  case Sender.GetNodeLevel(Node) of
    0: ImageIndex := 87;
    1: ImageIndex := 85;
    2: ImageIndex := 82;
    3: if Data^.DataRow.FieldByName['FLAG_REL'].AsBoolean then
         ImageIndex := 6
       else
         Imageindex := 27;
    4: inherited;
  end;
end;

procedure TCdMessage.ConfigDataScreen(const ALevel: Integer);
begin
  lPK_Mensagens.Enabled := (ALevel = 4);
  ePK_Mensagens.Enabled := (ALevel = 4);
  lDsc_Cnst.Enabled     := (ALevel = 4);
  eDsc_Cnst.Enabled     := (ALevel = 4);
  lNom_Cnst.Enabled     := (ALevel = 4);
  eNom_Cnst.Enabled     := (ALevel = 4);
end;

procedure TCdMessage.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

initialization
   RegisterClass(TCdMessage);
end.
