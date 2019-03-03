unit CadCfop;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 10/07/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMultiModel, ComCtrls, VirtualTrees, ToolWin, ExtCtrls, GridRow;

type
  TScreenForms = (tdCfop, tdNatOpe);

  TCdCfops = class(TfrmMultiModel)
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadList(Sender: TObject);
    procedure LoadPages(Sender: TObject);
    procedure SetActiveRow(Index: Integer; const Value: TDataRow); override;
  public
    { Public declarations }
    procedure UpdateRecord(Sender: TObject; Row: TDataRow);
    property  ActiveRow;
  end;

implementation

uses Dado, mSysCtb, CtbArqSql, ProcType, CadNatOp, CadTCfop, ProcUtils,
  TSysManAux;

{$R *.dfm}

{ TCdCfops }

const
  FORMS_CAPTIONS     : array [TScreenForms] of string      =
    ('Tipo de Cfop', 'Natureza das operações');

procedure TCdCfops.LoadList(Sender: TObject);
var
  aPkCfop: Integer;
  Node   : PVirtualNode;
  Data   : PGridData;
begin
  inherited;
  Data    := nil;
  Node    := nil;
  aPkCfop := 0;
  with dmSysCtb do
  begin
    if qrTypeCfop.Active then qrTypeCfop.Close;
    qrTypeCfop.SQL.Clear;
    qrTypeCfop.SQL.Add(SqlGetAllCfopNatOpe);
    if (not qrTypeCfop.Active) then qrTypeCfop.Open;
    try
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrTypeCfop, False);
      while (not qrTypeCfop.Eof) do
      begin
        if (aPkCfop <> qrTypeCfop.FieldByName('PK_TIPO_CFOP').AsInteger) then
        begin
          Node := AddDataNode(nil, qrTypeCfop, Data);
          if (Data <> nil) and (Data^.DataRow <> nil) then
            Data^.DataRow.FieldByName['TYPE_DATA'].AsInteger := Ord(tdCfop);
        end;
        if (Node <> nil) then
        begin
          AddDataNode(Node, qrTypeCfop, Data);
          if (Data <> nil) and (Data^.DataRow <> nil) then
            Data^.DataRow.FieldByName['TYPE_DATA'].AsInteger := Ord(tdNatOpe);
        end;
        aPkCfop   := qrTypeCfop.FieldByName('PK_TIPO_CFOP').AsInteger;
        qrTypeCfop.Next;
      end;
    finally
      if (not qrTypeCfop.Active) then qrTypeCfop.Close;
    end;
  end;
end;

procedure TCdCfops.LoadPages(Sender: TObject);
var
  i: TScreenForms;
const
  FORMS_OF_PAGES     : array [TScreenForms] of TPageClass =
    (TCdTipoCfop, TCdNatOper);
  FORMS_NAMES        : array [TScreenForms] of string     =
    ('tsTypeCfop', 'tsNatOper');
  FORMS_IMAGES_SEL   : array [TScreenForms] of Integer    =
    (11, 16);
  FORMS_IMAGES_NORMAL: array [TScreenForms] of Integer    =
    (19, 83);
begin
  if (Debug) then
    ShowMessage('Start LoadPages');
  for i := Low(TScreenForms) to High(TScreenForms) do
  begin
    with Pages.Add do
    begin
      if (Debug) then
        ShowMessage('Creating Page ' + FORMS_CAPTIONS[i] + ' with index ' + IntToStr(Ord(i)));
      DisplayImage  := FORMS_IMAGES_NORMAL[i];
      SelectedImage := FORMS_IMAGES_SEL[i];
      PageCaption   := FORMS_CAPTIONS[i];
      FormName      := FORMS_NAMES[i];
      PageControl   := pgMain;
      FormClass     := FORMS_OF_PAGES[i];
    end;
  end;
end;

procedure TCdCfops.SetActiveRow(Index: Integer; const Value: TDataRow);
begin
  inherited SetActiveRow(Index, Value);
  case TScreenForms(Index) of
    tdCfop  :
      with TCdTipoCfop(Pages.Items[Index].Form) do
        Pk := Value.FieldByName['PK_TIPO_CFOP'].AsInteger;
    tdNatOpe:
      with TCdNatOper(Pages.Items[Index].Form) do
      begin
        FkTypeCfop := Value.FieldByName['PK_TIPO_CFOP'].AsInteger;
        Pk         := Value.FieldByName['PK_NATUREZA_OPERACOES'].AsInteger;
      end;
  end;
end;

procedure TCdCfops.UpdateRecord(Sender: TObject; Row: TDataRow);
begin
  with ActiveRow[Pages.ItemIndex] do
  begin
    if (Row.FindField['PK_TIPO_CFOP'] <> nil) then
      dmSysCtb.FkTypeCfop := Row.FieldByName['PK_TIPO_CFOP'].AsInteger;
    case TScreenForms(Pages.ItemIndex) of
      tdCfop:
        begin
          FieldByName['PK_TIPO_CFOP'].AsInteger := Row.FieldByName['PK_TIPO_CFOP'].AsInteger;
          FieldByName['DSC_TMRC'].AsString      := Row.FieldByName['DSC_TMRC'].AsString;
        end;
      tdNatOpe:
        begin
          FieldByName['PK_TIPO_CFOP'].AsInteger          := Row.FieldByName['FK_TIPO_CFOP'].AsInteger;
          FieldByName['PK_NATUREZA_OPERACOES'].AsInteger := Row.FieldByName['PK_NATUREZA_OPERACOES'].AsInteger;
          FieldByName['DSC_NTOP'].AsString               := Row.FieldByName['DSC_NTOP'].AsString;
          FieldByName['COD_CFOP'].AsString               := Row.FieldByName['COD_CFOP'].AsString;
        end;
    end;
  end;
end;

procedure TCdCfops.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ActiveRow[Data^.Level] := Data^.DataRow;
end;

procedure TCdCfops.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['DSC_TMRC'].AsString;
    1: CellText := Data^.DataRow.FieldByName['COD_CFOP'].AsString + ' : ' +
                   Data^.DataRow.FieldByName['DSC_NTOP'].AsString;
  end;
end;

procedure TCdCfops.FormCreate(Sender: TObject);
begin
  OnLoadList  := LoadList;
  OnLoadPages := LoadPages;
  inherited;
end;

initialization
  RegisterClass(TCdCfops);

end.
