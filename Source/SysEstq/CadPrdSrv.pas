unit CadPrdSrv;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/03/2006                                                   *}
{* Modified:                                                             *}
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

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadModel, ExtCtrls, StdCtrls, Mask, ToolEdit, CurrEdit, TSysEstq,
  ComCtrls, ToolWin, VirtualTrees, ProcUtils, ProcType, GridRow, Buttons;

type
  TfrmPrdService = class(TfrmModel)
    pgServices: TPageControl;
    tsComps: TTabSheet;
    tsCarriers: TTabSheet;
    pgData: TPageControl;
    tsService: TTabSheet;
    vtCompositions: TVirtualStringTree;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbNew: TToolButton;
    tsCompositions: TTabSheet;
    lDsc_Comp: TStaticText;
    eDsc_Comp: TEdit;
    lFlag_Tp_Frete: TRadioGroup;
    gbProductService: TGroupBox;
    lFlag_Atv: TCheckBox;
    lFlag_Rdsp: TCheckBox;
    lVlr_Unit: TStaticText;
    eVlr_Unit: TCurrencyEdit;
    pgParts: TPageControl;
    tsListParts: TTabSheet;
    tsDetailPart: TTabSheet;
    vtInsumos: TVirtualStringTree;
    lSeq_Comp: TStaticText;
    eSeq_Comp: TCurrencyEdit;
    lMed_Def: TStaticText;
    eQtd_Prod: TCurrencyEdit;
    lQtd_Prod: TStaticText;
    eMed_Def: TCurrencyEdit;
    sbSavePart: TSpeedButton;
    eFk_Insumos: TComboBox;
    lFk_Insumos: TStaticText;
    lFlag_Def: TCheckBox;
    eFlag_TMat: TComboBox;
    lFlag_TMat: TStaticText;
    sbDelete: TSpeedButton;
    sbCancel: TSpeedButton;
    tbDelete: TToolButton;
    tbSepComp: TToolButton;
    sbNew: TSpeedButton;
    procedure vtCompositionsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtCompositionsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure FormCreate(Sender: TObject);
    procedure vtCompositionsDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtCompositionsChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure pgPartsChanging(Sender: TObject; var AllowChange: Boolean);
    procedure lFlag_AtvClick(Sender: TObject);
    procedure NewTypeComposition(Sender: TObject);
  private
    { Private declarations }
    procedure LoadTypeComp;
    function  GetCompositions: TList;
    function  GetFlagAtv: Boolean;
    function  GetFlagRdsp: Boolean;
    function  GetFlagTCarrier: TTypeCarrier;
    function  GetVlrUnit: Double;
    function  GetDscIns: string;
    function  GetFkInsumos: Integer;
    function  GetFlagtDef: Boolean;
    function  GetFlagTMat: Integer;
    function  GetMedDef: Double;
    function  GetQtdProd: Double;
    function  GetSeqComp: Integer;
    procedure SetCompositions(const Value: TList);
    procedure SetFlagAtv(const Value: Boolean);
    procedure SetFlagRdsp(const Value: Boolean);
    procedure SetFlagTCarrier(const Value: TTypeCarrier);
    procedure SetVlrUnit(const Value: Double);
    procedure ReleaseTree;
    procedure SetScreenControls;
    procedure SetFkInsumos(const Value: Integer);
    procedure SetFlagDef(const Value: Boolean);
    procedure SetFlagTMat(const Value: Integer);
    procedure SetMedDef(const Value: Double);
    procedure SetQtdProd(const Value: Double);
    procedure SetSeqComp(const Value: Integer);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    property  DscIns      : string       read GetDscIns;
    property  FkInsumos   : Integer      read GetFkInsumos    write SetFkInsumos;  
    property  FlagAtv     : Boolean      read GetFlagAtv      write SetFlagAtv;
    property  FlagDef     : Boolean      read GetFlagtDef     write SetFlagDef;
    property  FlagRdsp    : Boolean      read GetFlagRdsp     write SetFlagRdsp;
    property  FlagTCarrier: TTypeCarrier read GetFlagTCarrier write SetFlagTCarrier;
    property  FlagTMat    : Integer      read GetFlagTMat     write SetFlagTMat;
    property  MedDef      : Double       read GetMedDef       write SetMedDef;
    property  QtdProd     : Double       read GetQtdProd      write SetQtdProd;
    property  SeqComp     : Integer      read GetSeqComp      write SetSeqComp;
    property  VlrUnit     : Double       read GetVlrUnit      write SetVlrUnit;
    property  Compositions: TList        read GetCompositions write SetCompositions;
  public
    { Public declarations }
  end;

var
  frmPrdService: TfrmPrdService;

implementation

uses Funcoes, FuncoesDB, EstqArqSql, TSysFatAux, Dado, mSysEstq, TSysEstqAux;

{$R *.dfm}

{ TfrmPrdService }

procedure TfrmPrdService.ClearControls;
begin
  Loading := True;
  try
  finally
    Loading := False;
  end;
end;

procedure TfrmPrdService.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    LoadTypeComp;
    ListLoaded := True;
  end;
end;

procedure TfrmPrdService.LoadTypeComp;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtCompositions);
  with dmSysEstq do
  begin
    if qrTypeComp.Active then qrTypeComp.Close;
    qrTypeComp.SQL.Clear;
    qrTypeComp.SQL.Add(SqlCompositions);
    Dados.StartTransaction(qrTypeComp);
    try
      qrTypeComp.ParamByName('FkProdutos').AsInteger := Pk;
      if not qrTypeComp.Active then qrTypeComp.Open;
      while not qrTypeComp.Eof do
      begin
        Node := vtCompositions.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtCompositions.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrTypeComp, True);
            if (Data^.DataRow <> nil) then
            begin
              Data^.DataRow.Level        := 0;
              Data^.DataRow.ExternalData := Node;
            end
          end;
        end;
        qrTypeComp.Next;
      end;
    finally
      if qrTypeComp.Active then qrTypeComp.Close;
      Dados.CommitTransaction(qrTypeComp);
    end;
  end;
end;

procedure TfrmPrdService.MoveDataToControls;
var
  Data: TProductService;
begin
  Loading := True;
  Data := dmSysEstq.ProductSrv[Pk];
  try
    Data.ProductCarrier := dmSysEstq.ProductCarrier[Pk];
    FlagAtv             := Data.FlagAtv;
    VlrUnit             := Data.VlrUnit;
    FlagTCarrier        := Data.ProductCarrier.FlagTCarrier;
    FlagRdsp            := Data.ProductCarrier.FlagRdsp;
    Compositions        := dmSysEstq.ProductComps[Pk];
    SetScreenControls;
  finally
    Loading := False;
    FreeAndNil(Data);
  end;
end;

procedure TfrmPrdService.NewTypeComposition(Sender: TObject);
begin
  pgData.ActivePageIndex := 0;
  ReleaseTreeNodes(vtCompositions);
  LoadTypeComp;
end;

procedure TfrmPrdService.SaveIntoDB;
var
  Data: TProductService;
begin
  if (not (ScrState in UPDATE_MODE)) then exit;
  Data := TProductService.Create(Pk);
  try
    Data.FlagAtv                            := FlagAtv;
    Data.VlrUnit                            := VlrUnit;
    Data.ProductCarrier.FkProduct           := Pk;
    Data.ProductCarrier.FlagTCarrier        := FlagTCarrier;
    Data.ProductCarrier.FlagRdsp            := FlagRdsp;
    dmSysEstq.ProductSrv[Ord(ScrState)]     := Data;
    dmSysEstq.ProductCarrier[Ord(ScrState)] := Data.ProductCarrier;
    dmSysEstq.ProductComps[Pk]              := Compositions;
    SetScreenControls;
  finally
    FreeAndNil(Data);
  end;
end;

procedure TfrmPrdService.vtCompositionsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Column = 0 then
    CellText := Data^.DataRow.FieldByName['DSC_COMP'].AsString;
end;

procedure TfrmPrdService.vtCompositionsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Node.CheckType := ctRadioButton;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger > 0) then
    Node.CheckState := csCheckedNormal
  else
    Node.CheckState := csUnCheckedNormal;
end;

procedure TfrmPrdService.FormCreate(Sender: TObject);
begin
  inherited;
  cbTools.Images               := Dados.Image16;
  tbTools.Images               := Dados.Image16;
  vtCompositions.Images        := Dados.Image16;
  vtCompositions.Header.Images := Dados.Image16;
  vtCompositions.NodeDataSize  := SizeOf(TProductCompositions);
end;

procedure TfrmPrdService.vtCompositionsDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtCompositions.FocusedNode;
  if Node = nil then exit;
  Data := vtCompositions.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Data^.DataRow.FindField['PK_TIPO_COMPOSICOES'] = nil) then
    exit;
  pgData.ActivePageIndex := 1;
end;

procedure TfrmPrdService.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtCompositions);
  inherited;
end;

procedure TfrmPrdService.vtCompositionsChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
//  aPkC: Integer;
begin
  if Node = nil then exit;
  Data := vtCompositions.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
//  aPkC := Data^.DataRow.FieldByName['PK_TIPO_COMPOSICOES'].AsInteger;
end;

function TfrmPrdService.GetCompositions: TList;
var
  Node: PVirtualNode;
  Data: TProductCompositions;
begin
  Result := TList.Create;
  with vtCompositions do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data <> nil) then
        Result.Add(Data);
      Node := GetNext(Node);
    end;
  end;
end;

function TfrmPrdService.GetFlagAtv: Boolean;
begin
  Result := lFlag_Atv.Checked;
end;

function TfrmPrdService.GetFlagRdsp: Boolean;
begin
  Result := lFlag_Rdsp.Checked;
end;

function TfrmPrdService.GetFlagTCarrier: TTypeCarrier;
begin
  Result := TTypeCarrier(lFlag_Tp_Frete.ItemIndex);
end;

function TfrmPrdService.GetVlrUnit: Double;
begin
  Result := eVlr_Unit.Value;
end;

procedure TfrmPrdService.SetCompositions(const Value: TList);
var
  Node: PVirtualNode;
  Data: TProductCompositions;
  NChl: PVirtualNode;
  DChl: TProductComposition;
  i, j: Integer;
begin
  ReleaseTree;
  if (Value = nil) or (Value.Count = 0) then exit;
  with vtCompositions do
  begin
    for i := 0 to Value.Count - 1 do
    begin
      Node := AddChild(nil);
      if (Node <> nil) then
      begin
        Data := GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data.Assign(Value.Items[i]);
          if (Data.Count > 0) then
            for j := 0 to Data.Count - 1 do
            begin
              NChl := AddChild(Node);
              if (NChl <> nil) then
              begin
                Dchl := GetNodeData(NChl);
                if (DChl <> nil) then
                  DChl.Assign(Data.Items[j]);
              end;
            end;
        end;
      end;
    end;
  end;
end;

procedure TfrmPrdService.SetFlagAtv(const Value: Boolean);
begin
  lFlag_Atv.Checked := Value;
end;

procedure TfrmPrdService.SetFlagRdsp(const Value: Boolean);
begin
  lFlag_Rdsp.Checked := Value;
end;

procedure TfrmPrdService.SetFlagTCarrier(const Value: TTypeCarrier);
begin
  lFlag_Tp_Frete.ItemIndex := Ord(Value);
end;

procedure TfrmPrdService.SetVlrUnit(const Value: Double);
begin
  eVlr_Unit.Value := Value;
end;

procedure TfrmPrdService.ReleaseTree;
var
  Node: PVirtualNode;
  Data: TProductCompositions;
begin
  with vtCompositions do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (GetNodeLevel(Node) = 0) and (Data <> nil) then
      begin
        FreeAndNil(Data);
        DeleteNode(Node);
      end;
      Node := GetNext(Node);
    end;
    Clear;
  end;
end;

procedure TfrmPrdService.pgPartsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (vtInsumos.FocusedNode <> nil);
end;

procedure TfrmPrdService.lFlag_AtvClick(Sender: TObject);
begin
  if Loading then exit;
  ChangeGlobal(Sender);
  SetScreenControls;
end;

procedure TfrmPrdService.SetScreenControls;
begin
  lVlr_Unit.Visible := FlagAtv;
  eVlr_Unit.Visible := FlagAtv;
end;

function TfrmPrdService.GetDscIns: string;
begin
  Result := '';
  with eFk_Insumos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Items[ItemIndex];
end;

function TfrmPrdService.GetFkInsumos: Integer;
begin
  Result := 0;
  with eFk_Insumos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TfrmPrdService.GetFlagtDef: Boolean;
begin
  Result := lFlag_Def.Checked;
end;

function TfrmPrdService.GetFlagTMat: Integer;
begin
  Result := eFlag_TMat.ItemIndex;
end;

function TfrmPrdService.GetMedDef: Double;
begin
  Result := eMed_Def.Value;
end;

function TfrmPrdService.GetQtdProd: Double;
begin
  Result := eQtd_Prod.Value;
end;

function TfrmPrdService.GetSeqComp: Integer;
begin
  Result := eSeq_Comp.AsInteger;
end;

procedure TfrmPrdService.SetFkInsumos(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Insumos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TfrmPrdService.SetFlagDef(const Value: Boolean);
begin
  lFlag_Def.Checked := Value;
end;

procedure TfrmPrdService.SetFlagTMat(const Value: Integer);
begin
  eFlag_TMat.ItemIndex := Value;
end;

procedure TfrmPrdService.SetMedDef(const Value: Double);
begin
  eMed_Def.Value := Value;
end;

procedure TfrmPrdService.SetQtdProd(const Value: Double);
begin
  eQtd_Prod.Value := Value;
end;

procedure TfrmPrdService.SetSeqComp(const Value: Integer);
begin
  eQtd_Prod.AsInteger := Value;
end;

end.
