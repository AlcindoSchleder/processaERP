unit CadMarks;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 19/05/2007 - DD/MM/YYYY                                    *}
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
  Dialogs, StdCtrls, ExtCtrls, VirtualTrees, mSysTrans, ProcUtils, Mask,
  ToolEdit, CurrEdit, CadModel;

type
  TCdMarks = class(TfrmModel)
    shTitle: TShape;
    lTitle: TLabel;
    lPk_Veiculos_Marcas: TStaticText;
    lDsc_Mrc: TStaticText;
    eDsc_Mrc: TEdit;
    vtSuppliers: TVirtualStringTree;
    ePk_Veiculos_Marcas: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtSuppliersGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtSuppliersGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtSuppliersChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtSuppliersChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtSuppliersPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscMrc: string;
    function  GetPkMark: Integer;
    function  GetSuppliers: TList;
    procedure LoadSuppliers;
    procedure SetDscMrc(const Value: string);
    procedure SetPkMark(const Value: Integer);
    procedure SetSuppliers(const Value: TList);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  PkMark   : Integer  read GetPkMark    write SetPkMark;
    property  DscMrc   : string   read GetDscMrc    write SetDscMrc;
    property  Suppliers: TList    read GetSuppliers write SetSuppliers;
  end;

var
  CdMarks: TCdMarks;

implementation

{$R *.dfm}

uses Dado, FuncoesDB, ProcType, ArqSqlTrans, DB, GridRow;

function TCdMarks.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (DscMrc = '') then
  begin
    C := eDsc_Mrc;
    S := 'Campo Descrição deve ser preenchido';
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdMarks.ClearControls;
begin
  Loading := True;
  try
    PkMark    := 0;
    DscMrc    := '';
    Suppliers := nil;
  finally
    Loading := False;
  end;
end;

procedure TCdMarks.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

procedure TCdMarks.FormDestroy(Sender: TObject);
begin
  inherited;
  OnCheckRecord := nil;
  ReleaseTreeNodes(vtSuppliers);
end;

function TCdMarks.GetDscMrc: string;
begin
  Result := eDsc_Mrc.Text;
end;

function TCdMarks.GetPkMark: Integer;
begin
  Result := StrToIntDef(ePk_Veiculos_Marcas.Text, 0);
end;

function TCdMarks.GetSuppliers: TList;
var
  Node: PVirtualNode;
  Data: PGridData;
  aRow: TDataRow;
begin
  Result := TList.Create;
  with vtSuppliers do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data = nil) and (Data^.DataRow <> nil) and
         (TDBMode(Data^.DataRow.FindField['STATUS'].AsInteger) in UPDATE_MODE) then
      begin
        aRow := TDataRow.Create(nil);
        aRow.AddAs('FK_CADASTROS', Data^.DataRow.FieldByName['PK_CADASTROS'].AsInteger, ftInteger, SizeOf(integer));
        aRow.AddAs('FK_VEICULOS_MARCAS', PkMark, ftInteger, SizeOf(integer));
        aRow.AddAs('STATUS', Data^.DataRow.FieldByName['STATUS'].AsInteger, ftInteger, SizeOf(integer));
        Result.Add(aRow);
      end;
      Node := GetNext(Node);
    end;
  end;
end;

procedure TCdMarks.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    LoadSuppliers;
    ListLoaded := True;
  end;
end;

procedure TCdMarks.LoadSuppliers;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtSuppliers);
  with dmSysTrans, vtSuppliers do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlSuppliers);
    BeginUpdate;
    Screen.Cursor := crSQLWait;
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.Eof) do
      begin
        Node := AddChild(nil);
        if (Node <> nil) then
        begin
          Node^.CheckType := ctCheckBox;
          Data := GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.DataRow  := TDataRow.CreateFromDataSet(vtSuppliers, qrSqlAux, True);
            Data^.Level    := 0;
            Data^.Node     := Node;
            Data^.NodeType := tnData;
          end;
        end;
        qrSqlAux.Next;
      end;
    finally
      EndUpdate;
      Screen.Cursor := crDefault;
      if (qrSqlAux.Active) then qrSqlAux.Close;
    end;
  end;
end;

procedure TCdMarks.MoveDataToControls;
var
  aItem: TDataRow;
begin
  Loading := True;
  try
    aItem     := dmSysTrans.Marks[Pk];
    PkMark    := Pk;
    DscMrc    := aItem.FieldByName['DSC_MRC'].AsString;
    Suppliers := dmSysTrans.MarkSuppliers[Pk];
  finally
    Loading := False;
  end;
end;

procedure TCdMarks.SaveIntoDB;
var
  aItem: TDataRow;
  aRow : TDataRow;
  aPk  : Integer;
begin
  aItem := TDataRow.Create(Self);
  aRow  := TDataRow.Create(Self);
  try
    aItem.AddAs('PK_VEICULOS_MARCAS', PkMark, ftInteger, SizeOf(Integer));
    aItem.AddAs('DSC_MRC', DscMrc, ftString, 31);
    dmSysTrans.Marks[Ord(ScrState)] := aItem;
    aPk := aItem.FieldByName['PK_VEICULOS_MARCAS'].AsInteger;
    dmSysTrans.MarkSuppliers[aPk]   := Suppliers;
    aRow.AddAs('PK', aPk, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', aItem.FieldByName['DSC_MRC'].AsString, ftString, 31);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := aPk;
  finally
    FreeAndNil(aItem);
    FreeAndNil(aRow);
  end;
end;

procedure TCdMarks.SetDscMrc(const Value: string);
begin
  eDsc_Mrc.Text := Value;
end;

procedure TCdMarks.SetPkMark(const Value: Integer);
begin
  ePk_Veiculos_Marcas.Text := IntToStr(Value);
end;

procedure TCdMarks.SetSuppliers(const Value: TList);
var
  Node: PVirtualNode;
  Data: PGridData;
  aRow: TDataRow;
  i   : Integer;
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  i := 0;
  with vtSuppliers do
  begin
    BeginUpdate;
    try
      Node := GetFirst;
      while (Node <> nil) do
      begin
        Node^.CheckState := csUncheckedNormal;
        aRow := TDataRow(Value.Items[i]);
        Data := GetNodeData(Node);
        if (Data <> nil) and (Data^.DataRow <> nil) then
        begin
          if (aRow.FieldByName['FK_CADASTROS'].AsInteger =
              Data^.DataRow.FieldByName['PK_CADASTROS'].AsInteger) then
          begin
            Node^.CheckState := csCheckedNormal;
            Inc(i);
          end;
        end;
        GetNext(Node);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCdMarks.vtSuppliersGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TGridData);
end;

procedure TCdMarks.vtSuppliersGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
end;

procedure TCdMarks.vtSuppliersChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Allowed := True;
  if (NewState = csCheckedNormal) then
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmInsert);
  if (NewState = csUnCheckedNormal) then
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmDelete);
end;

procedure TCdMarks.vtSuppliersChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
  aStt: TDBMode;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (PkMark > 0) then exit;
  aStt := TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger);
  if (aStt in UPDATE_MODE) then
  begin
    dmSysTrans.SetMarkSupplier(Pk, Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger, aStt);
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmBrowse);
  end;
end;

procedure TCdMarks.vtSuppliersPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
  aStt: TDBMode;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aStt := TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger);
  if (aStt in UPDATE_MODE) then
    TargetCanvas.Font.Color := $000080FF
  else
    TargetCanvas.Font.Color := clWindowText;
end;

end.



