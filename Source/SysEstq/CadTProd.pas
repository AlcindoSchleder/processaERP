unit CadTProd;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
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
  Dialogs, CadListModel, StdCtrls, ExtCtrls, VirtualTrees, ComCtrls, ToolWin,
  ProcUtils;

type
  TCdTipoProd = class(TfrmModelList)
    lPk_Tipo_Produtos: TStaticText;
    ePk_Tipo_Produtos: TEdit;
    lDsc_TPrd: TStaticText;
    eDsc_TPrd: TEdit;
    lFlag_TProd: TRadioGroup;
    vtCfop: TVirtualStringTree;
    shTitle: TShape;
    lTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtCfopInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtCfopGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtCfopPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtCfopBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure FormDestroy(Sender: TObject);
    procedure vtCfopChecking(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var NewState: TCheckState; var Allowed: Boolean);
    procedure vtCfopChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscTPrd: string;
    function  GetFlagTProd: Integer;
    function  GetPkTypeProduct: Integer;
    procedure LoadCfops;
    procedure SetDscTPrd(const Value: string);
    procedure SetFlagTProd(const Value: Integer);
    procedure SetPkTypeProduct(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkTypeProduct: Integer read GetPkTypeProduct write SetPkTypeProduct;
    property  DscTPrd      : string  read GetDscTPrd       write SetDscTPrd;
    property  FlagTProd    : Integer read GetFlagTProd     write SetFlagTProd;
  public
    { Public declarations }
  end;

var
  CdTipoProd: TCdTipoProd;

implementation

uses Dado, ProcType, mSysEstq, EstqArqSql, DB, GridRow, TSysFatAux, Types,
  FuncoesDB;

{$R *.dfm}

{ TfrmModelList1 }

function TCdTipoProd.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscTPrd = '') then
  begin
    Dados.DisplayHint(eDsc_TPrd, 'Campo descrição deve ser preenchido');
    Result := False;
  end;
end;

procedure TCdTipoProd.ClearControls;
begin
  Loading := True;
  try
    PkTypeProduct := 0;
    DscTPrd       := '';
    FlagTProd     := 0;
  finally
    Loading := False;
  end;
end;

function TCdTipoProd.GetDscTPrd: string;
begin
  Result := eDsc_TPrd.Text;
end;

function TCdTipoProd.GetFlagTProd: Integer;
begin
  Result := lFlag_TProd.ItemIndex;
end;

function TCdTipoProd.GetPkTypeProduct: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Produtos.Text, 0);
end;

procedure TCdTipoProd.LoadDefaults;
begin
  // Nothing to do
end;

procedure TCdTipoProd.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  inherited;
  with dmSysEstq do
  begin
    if qrTipoProd.Active then qrTipoProd.Close;
    qrTipoProd.SQL.Clear;
    qrTipoProd.SQL.Add(SqlTypeProducts);
    Dados.StartTransaction(qrTipoProd);
    try
      if (not qrTipoProd.Active) then qrTipoProd.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrTipoProd, False)
      else
        if (RowModel.Count = 0) then
          RowModel.AddFieldsFromDataSet(qrTipoProd, False);
      while (not qrTipoProd.EOF) do
      begin
        Node := vtList.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtList.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrTipoProd, True);
          end;
        end;
        qrTipoProd.Next;
      end;
    finally
      if qrTipoProd.Active then qrTipoProd.Close;
      Dados.CommitTransaction(qrTipoProd);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdTipoProd.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysEstq.TypeProduct[Pk] do
    begin
      PkTypeProduct := FieldByName['PK_TIPO_PRODUTOS'].AsInteger;
      DscTPrd       := FieldByName['DSC_TPRD'].AsString;
      FlagTProd     := FieldByName['FLAG_TPROD'].AsInteger;
    end;
    LoadCfops;
  finally
    Loading := False;
  end;
end;

procedure TCdTipoProd.SaveIntoDB;
var
  aRow: TDataRow;
  Data: PGridData;
begin
  if (ScrState in UPDATE_MODE) then
  begin
    aRow := dmSysEstq.TypeProduct[0];
    try
      aRow.FieldByName['PK_TIPO_PRODUTOS'].AsInteger              := PkTypeProduct;
      aRow.FieldByName['DSC_TPRD'].AsString                       := DscTPrd;
      aRow.FieldByName['FLAG_TPROD'].AsInteger                    := FlagTProd;
      dmSysEstq.TypeProduct[Ord(ScrState)] := aRow;
      PkTypeProduct := aRow.FieldByName['PK_TIPO_PRODUTOS'].AsInteger;
    finally
      FreeAndNil(aRow);
    end;
  end;
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['PK_TIPO_PRODUTOS'].AsInteger := PkTypeProduct;
        Data^.DataRow.FieldByName['DSC_TPRD'].AsString          := DscTPrd;
      end;
    end;
  end;
  Pk := PkTypeProduct;
end;

procedure TCdTipoProd.SetDscTPrd(const Value: string);
begin
  eDsc_TPrd.Text := Value;
end;

procedure TCdTipoProd.SetFlagTProd(const Value: Integer);
begin
  lFlag_TProd.ItemIndex := Value;
end;

procedure TCdTipoProd.SetPkTypeProduct(const Value: Integer);
begin
  ePk_Tipo_Produtos.Text := IntToStr(Value);
end;

procedure TCdTipoProd.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
  vtCfop.NodeDataSize := SizeOf(TGridData);
end;

procedure TCdTipoProd.FormDestroy(Sender: TObject);
begin
  if (vtCfop.RootNodeCount > 0) then
    ReleaseTreeNodes(vtCfop);
end;

procedure TCdTipoProd.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_TPRD'].AsString;
end;

procedure TCdTipoProd.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_PRODUTOS'].AsInteger;
end;

procedure TCdTipoProd.LoadCfops;
var
  aCodCfop: Integer;
  aNode   : PVirtualNode;
  function AddLocalNode(ANode: PVirtualNode): PVirtualNode;
  var
    aData: PGridData;
  begin
    Result := vtCfop.AddChild(ANode);
    if (Result <> nil) then
    begin
      aData := vtCfop.GetNodeData(Result);
      if (aData <> nil) then
      begin
        aData^.DataRow  := TDataRow.CreateFromDataSet(vtCfop, dmSysEstq.qrSqlAux, True);
        aData^.Level    := vtCfop.GetNodeLevel(Result);
        aData^.Node     := Result;
        aData^.NodeType := tnData;
      end;
    end;
  end;
begin
  if (vtCfop.RootNodeCount > 0) then
    ReleaseTreeNodes(vtCfop);
  aCodCfop := -1;
  aNode    := nil;
  with dmSysEstq.qrSqlAux do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlGetCfops);
    Dados.StartTransaction(dmSysEstq.qrSqlAux);
    try
      ParamByName('FkTipoProdutos').AsInteger := Pk;
      if (not Active) then Open;
      while (not Eof) do
      begin
        if (aCodCfop <> FieldByName('PK_TIPO_CFOP').AsInteger) then
          aNode := AddLocalNode(nil);
        if (aNode <> nil) then
          AddLocalNode(aNode);
        aCodCfop := FieldByName('PK_TIPO_CFOP').AsInteger;
        Next;
      end;
    finally
      if (Active) then Close;
      Dados.CommitTransaction(dmSysEstq.qrSqlAux);
    end;
  end;
  if (vtCfop.RootNodeCount > 0) then vtCfop.FullExpand;
end;

procedure TCdTipoProd.vtCfopInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  aData: PGridData;
begin
  if (Node = nil) then exit;
  aData := Sender.GetNodeData(Node);
  if (aData = nil) or (aData^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) > 0) then
  begin
    Node.CheckType  := ctCheckBox;
    if (aData^.DataRow.FieldByName['FK_TIPO_PRODUTOS'].AsInteger = 0) then
      Node.CheckState := csUncheckedNormal
    else
      Node.CheckState := csCheckedNormal;
  end;
end;

procedure TCdTipoProd.vtCfopGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  aData: PGridData;
begin
  if (Node = nil) then exit;
  aData := Sender.GetNodeData(Node);
  if (aData = nil) or (aData^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    case Column of
      0: CellText := aData^.DataRow.FieldByName['PK_TIPO_CFOP'].AsString;
      1: CellText := aData^.DataRow.FieldByName['DSC_TMRC'].AsString;
    end;
  end;
  if (Sender.GetNodeLevel(Node) = 1) then
  begin
    case Column of
      0: CellText := aData^.DataRow.FieldByName['COD_CFOP'].AsString;
      1: CellText := aData^.DataRow.FieldByName['DSC_NTOP'].AsString;
    end;
  end;
end;

procedure TCdTipoProd.vtCfopPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  aData: PGridData;
begin
  if (Node = nil) then exit;
  aData := Sender.GetNodeData(Node);
  if (aData = nil) or (aData^.DataRow = nil) then exit;
  if (aData^.DataRow.FieldByName['STATE'].AsInteger > -1) then
    TargetCanvas.Font.Color := clRed
  else
    TargetCanvas.Font.Color := clWindowText;
end;

procedure TCdTipoProd.vtCfopBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  aData: PGridData;
begin
  if (Node = nil) then exit;
  aData := Sender.GetNodeData(Node);
  if (aData = nil) or (aData^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    ItemColor := clSkyBlue;
  EraseAction := eaColor;
end;

procedure TCdTipoProd.vtCfopChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  aData: PGridData;
begin
  if (Node = nil) then exit;
  aData := Sender.GetNodeData(Node);
  if (aData = nil) or (aData^.DataRow = nil) or
     (aData^.DataRow.FieldByName['STATE'].AsInteger > -1) then
    exit;
  if (Node.CheckState = csCheckedNormal)   and (NewState = csUncheckedNormal) then
    aData^.DataRow.FieldByName['STATE'].AsInteger := Ord(dbmDelete);
  if (Node.CheckState = csUnCheckedNormal) and (NewState = csCheckedNormal  ) then
    aData^.DataRow.FieldByName['STATE'].AsInteger := Ord(dbmInsert);
end;

procedure TCdTipoProd.vtCfopChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  aData: PGridData;
begin
  if (Node = nil) then exit;
  aData := Sender.GetNodeData(Node);
  if (aData = nil) or (aData^.DataRow = nil) then exit;
  if (aData^.DataRow.FieldByName['STATE'].AsInteger > -1) and (Pk > 0) then
  begin
    if (aData^.DataRow.FieldByName['FK_TIPO_PRODUTOS'].AsInteger = 0) then
      aData^.DataRow.FieldByName['FK_TIPO_PRODUTOS'].AsInteger := Pk;
    dmSysEstq.SetTipoProdNatOper(aData^.DataRow);
  end;
end;

initialization
  RegisterClass(TCdTipoProd);

end.
