unit CadPrdSup;

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
  Dialogs, CadModel, StdCtrls, CurrEdit, ExtCtrls, Mask, ToolEdit, TSysEstq,
  PrcCombo, VirtualTrees, ComCtrls, ProcType, ProcUtils, ToolWin, TSysCad,
  TSysPedAux, TSysEstqAux;

type
  PSuppData = ^TSuppData;
  TSuppData = packed record
    Level   : Integer;
    Index   : Integer;
    DataRow : TProductSupplier;
    OldSuppl: Integer;
    State   : TDbMode;
    Node    : PVirtualNode;
  end;

  TfmPrdSuppliers = class(TfrmModel)
    pgMain: TPageControl;
    tsList: TTabSheet;
    vtList: TVirtualStringTree;
    tsData: TTabSheet;
    lFk_VW_Fornecedores: TStaticText;
    eFk_VW_Fornecedores: TPrcComboBox;
    lFk_Unidades: TStaticText;
    eFk_Unidades: TPrcComboBox;
    lFk_Tipo_Descontos: TStaticText;
    eFk_Tipo_Descontos: TPrcComboBox;
    lSit_Trib: TStaticText;
    eSit_Trib: TEdit;
    lFlag_Rjst: TCheckBox;
    lDta_Grnt: TStaticText;
    eDta_Grnt: TDateEdit;
    lFlag_Insp: TRadioGroup;
    eQtd_Grnt: TCurrencyEdit;
    lQtd_Grnt: TStaticText;
    eFrete_Ins: TCurrencyEdit;
    lFrete_Ins: TStaticText;
    eQtd_Uni: TCurrencyEdit;
    lQtd_Uni: TStaticText;
    lPre_Tab: TStaticText;
    ePre_Tab: TCurrencyEdit;
    lPre_Final: TStaticText;
    ePre_Final: TCurrencyEdit;
    lQtd_Dias_Entr: TStaticText;
    eQtd_Dias_Entr: TCurrencyEdit;
    eObs_Forn: TMemo;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbInsert: TToolButton;
    tbSep: TToolButton;
    tbDelete: TToolButton;
    tbCompositions: TToolBar;
    tbComp: TToolButton;
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure tbInsertClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtListDblClick(Sender: TObject);
    procedure pgMainChange(Sender: TObject);
    procedure vtListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure pgMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PreFinChange(Sender: TObject);
  private
    { Private declarations }
    FSuppliers: TProductSuppliers;
    procedure ChangePK(Sender: TObject);
    function  GetActiveSupp: Integer;
    function  GetDtaGrnt: TDate;
    function  GetFkSuplier: TOwner;
    function  GetFkTypeDsct: TTypeDiscount;
    function  GetFkUnit: TUnit;
    function  GetFlagInsp: TInspectionType;
    function  GetFlagRjst: Boolean;
    function  GetFreteIns: Double;
    function  GetObsForn: TStrings;
    function  GetPreFinal: Double;
    function  GetPreTab: Double;
    function  GetQtdDiasEntr: Integer;
    function  GetQtdGrnt: Double;
    function  GetQtdUni: Double;
    function  GetSitTrib: string;
    procedure LoadSuppliers;
    procedure LoadUnits;
    procedure LoadTypeDiscounts;
    procedure SetActiveSupp(const Value: Integer);
    procedure SetDtaGrnt(const Value: TDate);
    procedure SetFkSuplier(const Value: TOwner);
    procedure SetFkTypeDsct(const Value: TTypeDiscount);
    procedure SetFkUnit(const Value: TUnit);
    procedure SetFlagInsp(const Value: TInspectionType);
    procedure SetFlagRjst(const Value: Boolean);
    procedure SetFreteIns(const Value: Double);
    procedure SetObsForn(const Value: TStrings);
    procedure SetPreFinal(const Value: Double);
    procedure SetPreTab(const Value: Double);
    procedure SetQtdDiasEntr(const Value: Integer);
    procedure SetQtdGrnt(const Value: Double);
    procedure SetQtdUni(const Value: Double);
    procedure SetSitTrib(const Value: string);
    procedure ShowProdSuppList;
    procedure ReleaseObjects;
    function  SetDataItem: Integer;
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
  public
    { Public declarations }
    property  ActiveSupp : Integer           read GetActiveSupp  write SetActiveSupp;
    property  DtaGrnt    : TDate             read GetDtaGrnt     write SetDtaGrnt;
    property  FkSupplier : TOwner            read GetFkSuplier   write SetFkSuplier;
    property  FkUnit     : TUnit             read GetFkUnit      write SetFkUnit;
    property  FkTypeDsct : TTypeDiscount     read GetFkTypeDsct  write SetFkTypeDsct;
    property  FlagInsp   : TInspectionType   read GetFlagInsp    write SetFlagInsp;
    property  FlagRjst   : Boolean           read GetFlagRjst    write SetFlagRjst;
    property  FreteIns   : Double            read GetFreteIns    write SetFreteIns;
    property  ObsForn    : TStrings          read GetObsForn     write SetObsForn;
    property  PreFinal   : Double            read GetPreFinal    write SetPreFinal;
    property  PreTab     : Double            read GetPreTab      write SetPreTab;
    property  QtdDiasEntr: Integer           read GetQtdDiasEntr write SetQtdDiasEntr;
    property  QtdGrnt    : Double            read GetQtdGrnt     write SetQtdGrnt;
    property  QtdUni     : Double            read GetQtdUni      write SetQtdUni;
    property  SitTrib    : string            read GetSitTrib     write SetSitTrib;
  end;

var
  fmPrdSuppliers: TfmPrdSuppliers;

implementation

uses Dado, EstqArqSql, Funcoes, FuncoesDB, mSysEstq;

{$R *.dfm}

{ TfmPrdSuppliers }

function TfmPrdSuppliers.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  if (pgMain.ActivePageIndex = 0) then
  begin
    Result := True;
    exit;
  end;
  Result := False;
  C := Self;
  if (FkSupplier = nil) then
  begin
    C := eFk_VW_Fornecedores;
    S := 'Atenção: um fornecedor deve ser informado!';
  end;
  if (FkUnit = nil) then
  begin
    C := eFk_Unidades;
    S := 'Atenção: Uma unidade deve ser informada!';
  end;
  if (QtdUni = 0) then
  begin
    C := eQtd_Uni;
    S := 'Atenção: A quantidade da unidade de compra deve ser informada!';
  end;
  if (SitTrib = '') then
  begin
    C := eSit_Trib;
    S := 'Atenção: A situação tributária do produto deve ser informada!';
  end;
//  if (ScrState = dbmEdit) and ((ActiveSupp = -1) or (ActiveSupp >= Suppliers.Count)) then
//    S := 'Erro: Não pude encontrar um ítem para atualização';
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    exit;
  end
  else
    Result := True;
end;

procedure TfmPrdSuppliers.ClearControls;
begin
  Loading := True;
  try
    DtaGrnt     := 0;
    FkSupplier  := nil;
    FkUnit      := nil;
    FkTypeDsct  := nil;
    FlagInsp    := itFree;
    FlagRjst    := False;
    FreteIns    := 0.0;
    ObsForn     := nil;
    PreFinal    := 0.0;
    PreTab      := 0.0;
    QtdDiasEntr := 0;
    QtdGrnt     := 0.0;
    QtdUni      := 1;
    SitTrib     := '000';
  finally
    Loading := False;
  end;
end;

function TfmPrdSuppliers.GetActiveSupp: Integer;
var
  Data: PSuppData;
begin
  Result := -1;
  if (vtList.FocusedNode = nil) or
     (vtList.GetNodeData(vtList.FocusedNode) = nil) then
    exit;
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data <> nil) and (Data^.DataRow <> nil) then
    Result := Data^.DataRow.Index;
end;

function TfmPrdSuppliers.GetDtaGrnt: TDate;
begin
  Result := eDta_Grnt.Date;
end;

function TfmPrdSuppliers.GetFkSuplier: TOwner;
var
  aIdx: Integer;
begin
  Result := nil;
  with eFk_VW_Fornecedores do
  begin
    aIdx := ItemIndex;
    if (aIdx > 0) and (Items.Objects[aIdx] <> nil) then
      Result := TOwner(Items.Objects[aIdx]);
  end;
end;

function TfmPrdSuppliers.GetFkTypeDsct: TTypeDiscount;
var
  aIdx: Integer;
begin
  Result := nil;
  with  eFk_Tipo_Descontos do
  begin
    aIdx := ItemIndex;
    if (aIdx > 0) and (aIdx < Items.Count) and
       (Items.Objects[aIdx] <> nil) then
      Result := TTypeDiscount(Items.Objects[aIdx]);
  end;
end;

function TfmPrdSuppliers.GetFkUnit: TUnit;
var
  aIdx: Integer;
begin
  Result := nil;
  with eFk_Unidades do
  begin
    aIdx := ItemIndex;
    if (aIdx > 0) and (aIdx < Items.Count) and
       (Items.Objects[aIdx] <> nil) then
      Result := TUnit(Items.Objects[aIdx]);
  end;
end;

function TfmPrdSuppliers.GetFlagInsp: TInspectionType;
begin
  Result := TInspectionType(lFlag_Insp.ItemIndex);
end;

function TfmPrdSuppliers.GetFlagRjst: Boolean;
begin
  Result := lFlag_Rjst.Checked;
end;

function TfmPrdSuppliers.GetFreteIns: Double;
begin
  Result := eFrete_Ins.Value
end;

function TfmPrdSuppliers.GetObsForn: TStrings;
begin
  Result := eObs_Forn.Lines;
end;

function TfmPrdSuppliers.GetPreFinal: Double;
begin
  Result := ePre_Final.Value;
end;

function TfmPrdSuppliers.GetPreTab: Double;
begin
  Result := ePre_Tab.Value;
end;

function TfmPrdSuppliers.GetQtdDiasEntr: Integer;
begin
  Result := eQtd_Dias_Entr.AsInteger;
end;

function TfmPrdSuppliers.GetQtdGrnt: Double;
begin
  Result := eQtd_Grnt.Value;
end;

function TfmPrdSuppliers.GetQtdUni: Double;
begin
  Result := eQtd_Uni.Value;
end;

function TfmPrdSuppliers.GetSitTrib: string;
begin
  Result := eSit_Trib.Text;
end;

procedure TfmPrdSuppliers.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    LoadSuppliers;
    LoadUnits;
    LoadTypeDiscounts;
    ListLoaded := True;
  end;
end;

procedure TfmPrdSuppliers.LoadSuppliers;
begin
  eFk_VW_Fornecedores.ReleaseObjects;
  eFk_VW_Fornecedores.Items.AddStrings(dmSysEstq.LoadSuppliers);
end;

procedure TfmPrdSuppliers.LoadTypeDiscounts;
begin
  eFk_Tipo_Descontos.ReleaseObjects;
  eFk_Tipo_Descontos.Items.AddStrings(dmSysEstq.LoadTypeDiscounts);
end;

procedure TfmPrdSuppliers.LoadUnits;
begin
  eFk_Unidades.ReleaseObjects;
  eFk_Unidades.Items.AddStrings(dmSysEstq.LoadUnits);
end;

procedure TfmPrdSuppliers.MoveDataToControls;
var
  aIdx: Integer;
begin
  Loading := True;
  try
    aIdx        := ActiveSupp;
    if (aIdx = -1) or (aIdx >= FSuppliers.Count) then exit;
    DtaGrnt     := FSuppliers.Items[aIdx].DtaGrnt;
    FkSupplier  := FSuppliers.Items[aIdx].FkSupplier;
    FkUnit      := FSuppliers.Items[aIdx].FkUnit;
    FkTypeDsct  := FSuppliers.Items[aIdx].FkTypeDsct;
    FlagInsp    := FSuppliers.Items[aIdx].FlagInsp;
    FlagRjst    := FSuppliers.Items[aIdx].FlagRjst;
    FreteIns    := FSuppliers.Items[aIdx].FreteIns;
    ObsForn     := FSuppliers.Items[aIdx].ObsForn;
    PreFinal    := FSuppliers.Items[aIdx].PreFinal;
    PreTab      := FSuppliers.Items[aIdx].PreTab;
    QtdDiasEntr := FSuppliers.Items[aIdx].QtdDiasEntr;
    QtdGrnt     := FSuppliers.Items[aIdx].QtdGrnt;
    QtdUni      := FSuppliers.Items[aIdx].QtdUni;
    SitTrib     := FSuppliers.Items[aIdx].SitTrib;
  finally
    Loading := False;
  end;
end;

function TfmPrdSuppliers.SetDataItem: Integer;
begin
  if (ScrState = dbmInsert) or (ActiveSupp = -1) then
    with FSuppliers.Add do
      ActiveSupp := Index;
  Result                               := ActiveSupp;
  FSuppliers.Items[Result].DtaGrnt     := DtaGrnt;
  FSuppliers.Items[Result].FkSupplier  := FkSupplier;
  FSuppliers.Items[Result].FkUnit      := FkUnit;
  FSuppliers.Items[Result].FkTypeDsct  := FkTypeDsct;
  FSuppliers.Items[Result].FlagInsp    := FlagInsp;
  FSuppliers.Items[Result].FlagRjst    := FlagRjst;
  FSuppliers.Items[Result].FreteIns    := FreteIns;
  FSuppliers.Items[Result].ObsForn     := ObsForn;
  FSuppliers.Items[Result].PreFinal    := PreFinal;
  FSuppliers.Items[Result].PreTab      := PreTab;
  FSuppliers.Items[Result].QtdDiasEntr := QtdDiasEntr;
  FSuppliers.Items[Result].QtdGrnt     := QtdGrnt;
  FSuppliers.Items[Result].QtdUni      := QtdUni;
  FSuppliers.Items[Result].SitTrib     := SitTrib;
  vtList.Refresh;
end;

procedure TfmPrdSuppliers.SaveIntoDB;
var
  Node: PVirtualNode;
  Data: PSuppData;
begin
  vtList.BeginUpdate;
  try
    Node := vtList.GetFirst;
    while (Node <> nil) do
    begin
      Data := vtList.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (Data.State in UPDATE_MODE) then
      begin
        dmSysEstq.UpdateProductSuppliers(Pk, Data^.OldSuppl,
          FSuppliers.Items[ActiveSupp], ScrState);
        Data.State  := dbmBrowse;
      end;
      Node := vtList.GetNext(Node);
    end;
  finally
    vtList.EndUpdate;
  end;
end;

procedure TfmPrdSuppliers.SetActiveSupp(const Value: Integer);
var
  Node: PVirtualNode;
  Data: PSuppData;
  aNew: Boolean;
begin
  aNew := Value >= Integer(vtList.RootNodeCount);
  vtList.BeginUpdate;
  try
    if Value >= Integer(vtList.RootNodeCount) then
      Node := vtList.AddChild(nil)
    else
      Node := vtList.FocusedNode;
    if (Node <> nil) then
    begin
      Data := vtList.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level      := 0;
        Data^.Node       := Node;
        if (Data^.DataRow <> nil) and (Data^.OldSuppl = 0) then
          Data^.OldSuppl := Data^.DataRow.FkSupplier.PkCadastros
        else
          Data^.OldSuppl := 0;
        Data^.DataRow    := FSuppliers.Items[Value];
        Data^.Index      := Value;
        if aNew then
          Data^.State    := dbmInsert
        else
          Data^.State    := dbmEdit;
      end;
    end;
  finally
    vtList.EndUpdate;
  end;
  if (Node <> nil) then
  begin
    vtList.OnFocusChanged               := nil;
    vtList.FocusedNode                  := Node;
    vtList.Selected[vtList.FocusedNode] := True;
    vtList.OnFocusChanged               := vtListFocusChanged;
  end;
end;

procedure TfmPrdSuppliers.SetDtaGrnt(const Value: TDate);
begin
  eDta_Grnt.Clear;
  if (Value > 0) then
    eDta_Grnt.Date := Value;
end;

procedure TfmPrdSuppliers.SetFkSuplier(const Value: TOwner);
begin
  eFk_VW_Fornecedores.ItemIndex := 0;
  if (Value <> nil) then
    eFk_VW_Fornecedores.SetIndexFromObjectValue(Value.PkCadastros);
end;

procedure TfmPrdSuppliers.SetFkTypeDsct(const Value: TTypeDiscount);
begin
  eFk_Tipo_Descontos.ItemIndex := 0;
  if (Value <> nil) then
    eFk_Tipo_Descontos.SetIndexFromObjectValue(Value.PkTypeDiscount);
end;

procedure TfmPrdSuppliers.SetFkUnit(const Value: TUnit);
begin
  eFk_Unidades.ItemIndex := 0;
  if (Value <> nil) then
    eFk_Unidades.SetIndexFromObjectValue(Value.PkUnit);
end;

procedure TfmPrdSuppliers.SetFlagInsp(const Value: TInspectionType);
begin
  lFlag_Insp.ItemIndex := Ord(Value);
end;

procedure TfmPrdSuppliers.SetFlagRjst(const Value: Boolean);
begin
  lFlag_Rjst.Checked := Value;
end;

procedure TfmPrdSuppliers.SetFreteIns(const Value: Double);
begin
  eFrete_Ins.Value := Value;
end;

procedure TfmPrdSuppliers.SetObsForn(const Value: TStrings);
begin
  eObs_Forn.Lines.Clear;
  if (Value <> nil) then
    eObs_Forn.Lines.Assign(Value);
end;

procedure TfmPrdSuppliers.SetPreFinal(const Value: Double);
begin
  ePre_Final.Value := Value;
end;

procedure TfmPrdSuppliers.SetPreTab(const Value: Double);
begin
  ePre_Tab.Value := Value;
end;

procedure TfmPrdSuppliers.SetQtdDiasEntr(const Value: Integer);
begin
  eQtd_Dias_Entr.AsInteger := Value;
end;

procedure TfmPrdSuppliers.SetQtdGrnt(const Value: Double);
begin
  eQtd_Grnt.Value := Value;
end;

procedure TfmPrdSuppliers.SetQtdUni(const Value: Double);
begin
  eQtd_Uni.Value := Value;
end;

procedure TfmPrdSuppliers.SetSitTrib(const Value: string);
begin
  eSit_Trib.Text := Value;
end;

procedure TfmPrdSuppliers.ShowProdSuppList;
var
  Node: PVirtualNode;
  Data: PSuppData;
  i   : Integer;
begin
  if (FSuppliers = nil) or (FSuppliers.Count = 0) then exit;
  if (vtList.RootNodeCount > 0) then ReleaseObjects;
  vtList.BeginUpdate;
  try
    for i := 0 to FSuppliers.Count - 1 do
    begin
      Node := vtList.AddChild(nil);
      if (Node <> nil) then
      begin
        Data := vtList.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.Level   := 0;
          Data^.Node    := Node;
          Data^.State   := dbmBrowse;
          Data^.DataRow := FSuppliers.Items[i];
          Data^.Index   := i;
        end;
      end;
    end;
  finally
    vtList.EndUpdate;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TfmPrdSuppliers.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PSuppData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FkSupplier.RazSoc;
    1: CellText := FloatToStrF(Data^.DataRow.PreTab, ffCurrency, 7, Dados.DecimalPlaces);
    2: CellText := Data^.DataRow.FkUnit.MnmoUni;
    3: CellText := FloatToStrF(Data^.DataRow.FreteIns, ffCurrency, 7, Dados.DecimalPlaces);
    4: CellText := FloatToStrF(Data^.DataRow.QtdDiasEntr, ffNumber, 7, 0);
  end;
end;

procedure TfmPrdSuppliers.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PSuppData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  MoveDataToControls;
end;

procedure TfmPrdSuppliers.tbInsertClick(Sender: TObject);
begin
  ClearControls;
  pgMain.ActivePageIndex := 1;
  ScrState := dbmInsert;
end;

procedure TfmPrdSuppliers.tbDeleteClick(Sender: TObject);
var
  aIdx : Integer;
  Node : PVirtualNode;
  Data : PSuppData;
  FkSup: Integer;
  FkEmp: Integer;
begin
  aIdx        := ActiveSupp;
  if (aIdx = -1) or (aIdx >= FSuppliers.Count) then exit;
  // delete node and Item from collection;
  FkEmp :=  FSuppliers.Items[aIdx].FkCompany.PkCompany;
  FkSup :=  FSuppliers.Items[aIdx].FkSupplier.PkCadastros;
  FSuppliers.Delete(aIdx);
  vtList.BeginUpdate;
  try
    Node := vtList.FocusedNode;
    if (Node = nil) then exit;
    Data := vtList.GetNodeData(Node);
    if (Data = nil) then exit;
    Data^.Level := 0;
    Data^.Index := 0;
    if (Assigned(Data^.DataRow)) then
      Data^.DataRow.Free;
    Data^.DataRow := nil;
    Data^.Node := nil;
    vtList.DeleteNode(Node);
  finally
    vtList.EndUpdate;
  end;
  dmSysEstq.DeleteProductSupplier(FkEmp, Pk, FkSup);
  if (pgMain.ActivePageIndex > 0) then
    pgMain.ActivePageIndex := 0;
end;

procedure TfmPrdSuppliers.ChangePK(Sender: TObject);
begin
  if (Pk > 0) then
  begin
    FSuppliers := dmSysEstq.GetProductSuppliers(Pk);
    if (FSuppliers <> nil) and (FSuppliers.Count > 0) then
      ShowProdSuppList
    else
      ReleaseObjects;
  end;
end;

procedure TfmPrdSuppliers.FormCreate(Sender: TObject);
begin
  vtList.NodeDataSize   := SizeOf(TSuppData);
  vtList.Images         := Dados.Image16;
  vtList.Header.Images  := Dados.Image16;
  tbTools.Images        := Dados.Image16;
  cbTools.Images        := Dados.Image16;
  tbCompositions.Images := Dados.Image16;
  inherited;
  OnChangePK            := ChangePk;
  OnCheckRecord         := CheckRecord;
  if (pgMain.ActivePageIndex > 0) then
    pgMain.ActivePageIndex := 0;
end;

procedure TfmPrdSuppliers.FormDestroy(Sender: TObject);
begin
  if Assigned(FSuppliers) then
    FSuppliers.Free;
  FSuppliers := nil;
  ReleaseObjects;
  eFk_VW_Fornecedores.ReleaseObjects;
  eFk_Tipo_Descontos.ReleaseObjects;
  eFk_Unidades.ReleaseObjects;
  inherited;
end;

procedure TfmPrdSuppliers.vtListDblClick(Sender: TObject);
begin
  MoveDataToControls;
  if (pgMain.ActivePageIndex = 0) then
    pgMain.ActivePageIndex := 1;
end;

procedure TfmPrdSuppliers.pgMainChange(Sender: TObject);
begin
  if pgMain.ActivePageIndex = 1 then
    MoveDataToControls;
  if pgMain.ActivePageIndex = 0 then
    SetDataItem;
end;

procedure TfmPrdSuppliers.ReleaseObjects;
var
  Node: PVirtualNode;
  Data: PSuppData;
begin
  vtList.BeginUpdate;
  try
    Node := vtList.GetFirst;
    while (Node <> nil) do
    begin
      Data := vtList.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Index   := 0;
        Data^.Node    := nil;
        Data^.DataRow := nil;
      end;
      Node := vtList.GetNext(Node);
    end;
    vtList.Clear;
  finally
    vtList.EndUpdate;
  end;
end;

procedure TfmPrdSuppliers.vtListPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PSuppData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.State in UPDATE_MODE) then
    TargetCanvas.Font.Color := clRed;
end;

procedure TfmPrdSuppliers.pgMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (pgMain.ActivePageIndex = 1) then
    AllowChange := CheckRecord(ScrState, ScrState)
  else
    AllowChange := True;
end;

procedure TfmPrdSuppliers.PreFinChange(Sender: TObject);
begin
  ChangeGlobal(Self);
  ePre_Final.OnChange := nil;
  if (FreteIns > 0) then
    PreFinal := PreTab + ((ePre_Tab.Value * FreTeIns) / 100)
  else
    PreFinal := PreTab;
  ePre_Final.OnChange := ChangeGlobal;
end;

end.
