unit CadSitOrgm;

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
  Dialogs, CadListModel, StdCtrls, VirtualTrees, ComCtrls, ToolWin, Mask, ProcUtils,
  ToolEdit, CurrEdit, ExtCtrls, ImgList;

type
  TTypeData = (tdOrigim, tdSituation);

  TCdSitTrib = class(TfrmModelList)
    lCode: TStaticText;
    lDescription: TStaticText;
    eDescription: TEdit;
    eCode: TCurrencyEdit;
    sTitle: TShape;
    lTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
  private
    { Private declarations }
    FTypeData: TTypeData;
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function  GetDscTab: string;
    function  GetPkTable: Integer;
    procedure SetDscTab(const Value: string);
    procedure SetPkTable(const Value: Integer);
    procedure SetTypeData(const Value: TTypeData);
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
  public
    { Public declarations }
    property  TypeData: TTypeData read FTypeData  write SetTypeData;
    property  PkTable : Integer   read GetPkTable write SetPkTable;
    property  DscTab  : string    read GetDscTab  write SetDscTab;
  end;

implementation

uses Dado, mSysCtb, CtbArqSql, GridRow, ProcType;

{$R *.dfm}

const
  TYPE_DATA_NAMES: array [TTypeData] of string =
    ('Origens Tributárias', 'Situação Tributárias');

  TYPE_DATA_FIELD_NAMES: array [TTypeData, 0..1] of string =
    (('PK_ORIGENS_TRIBUTARIAS', 'DSC_ORGM'),
     ('PK_SITUACAO_TRIBUTARIAS', 'DSC_IMPST'));

{ TCdSitTrib }

function TCdSitTrib.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  S := '';
  C := nil;
  Result := True;
  if (PkTable <= 0) then
  begin
    C := eCode;
    S := 'Campo Código deve conter um número > 0';
  end;
  if (DscTab = '') then
  begin
    C := eDescription;
    S := 'Campo Descrição deve ser preenchido';
  end;
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdSitTrib.ClearControls;
begin
  Loading := True;
  try
    PkTable := 0;
    DscTab  := '';
  finally
    Loading := False;
  end;
end;

function TCdSitTrib.GetDscTab: string;
begin
  Result := eDescription.Text;
end;

function TCdSitTrib.GetPkTable: Integer;
begin
  Result := eCode.AsInteger;
end;

procedure TCdSitTrib.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdSitTrib.LoadList(Sender: TObject);
var
  i: TTypeData;
  Node: PVirtualNode;
  Data: PGridData;
  procedure OpenDataSet(Sql: string);
  begin
    with dmSysCtb do
    begin
      if qrSqlAux.Active then qrSqlAux.Close;
      qrSqlAux.SQL.Clear;
      qrSqlAux.SQL.Add(Sql);
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(nil, qrSqlAux, False);
    end;
  end;
begin
  inherited;
  vtList.BeginUpdate;
  with dmSysCtb do
  begin
    Dados.StartTransaction(qrSqlAux);
    try
      for i := Low(TTypeData) to High(TTypeData) do
      begin
        case i of
          tdOrigim   : OpenDataSet(SqlGetOrigins);
          tdSituation: OpenDataSet(SqlGetSituations);
        end;
        Node := AddDataNode(nil, qrSqlAux);
        if (Node <> nil) then
        begin
          Data := vtList.GetNodeData(Node);
          if (Data <> nil) and (Data^.DataRow <> nil) then
          begin
            Data^.NodeType := tnFolder;
            Data^.DataRow.FieldByName['TYPE_DATA'].AsInteger := Ord(i);
            Data^.DataRow.FieldByName[TYPE_DATA_FIELD_NAMES[i, 0]].AsInteger := 0;
            Data^.DataRow.FieldByName[TYPE_DATA_FIELD_NAMES[i, 1]].AsString  := TYPE_DATA_NAMES[i];
            while (not qrSqlAux.Eof) do
            begin
              AddDataNode(Node, qrSqlAux);
              qrSqlAux.Next;
            end;
          end;
        end;
      end;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
      vtList.EndUpdate;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdSitTrib.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysCtb.Origim[Pk, Ord(FTypeData)] do
    begin
      PkTable := FieldByName[TYPE_DATA_FIELD_NAMES[FTypeData, 0]].AsInteger;
      DscTab  := FieldByName[TYPE_DATA_FIELD_NAMES[FTypeData, 1]].AsString;
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdSitTrib.SaveIntoDB;
var
  aItem: TDataRow;
begin
  aItem := dmSysCtb.Origim[Pk, Ord(FTypeData)];
  try
    aItem.FieldByName[TYPE_DATA_FIELD_NAMES[FTypeData, 0]].AsInteger := PkTable;
    aItem.FieldByName[TYPE_DATA_FIELD_NAMES[FTypeData, 1]].AsString  := DscTab;
  finally
    FreeAndNil(aItem);
  end;
end;

procedure TCdSitTrib.SetDscTab(const Value: string);
begin
  eDescription.Text := Value;
end;

procedure TCdSitTrib.SetPkTable(const Value: Integer);
begin
  eCode.AsInteger := Value;
end;

procedure TCdSitTrib.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdSitTrib.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  TypeData := TTypeData(Data^.DataRow.FieldByName['TYPE_DATA'].AsInteger);
  if (Data^.NodeType = tnFolder) then
    ClearControls
  else
    Pk := Data^.DataRow.FieldByName[TYPE_DATA_FIELD_NAMES[FTypeData, 0]].AsInteger;
end;

procedure TCdSitTrib.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
  aTypeData: TTYpeData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aTypeData := TTypeData(Data^.DataRow.FieldByName['TYPE_DATA'].AsInteger);
  CellText  := Data^.DataRow.FieldByName[TYPE_DATA_FIELD_NAMES[aTypeData, 1]].AsString;
end;

procedure TCdSitTrib.SetTypeData(const Value: TTypeData);
begin
  FTypeData := Value;
  lTitle.Caption := TYPE_DATA_NAMES[FTypeData];
end;

procedure TCdSitTrib.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
var
  Data: PGridData;
begin
  inherited;
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.NodeType = tnFolder) and (Kind in [ikSelected, ikNormal]) then
    ImageIndex := 22;
end;

initialization
  RegisterClass(TCdSitTrib);

end.
