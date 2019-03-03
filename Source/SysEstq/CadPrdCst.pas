unit CadPrdCst;

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
  Dialogs, CadModel, ExtCtrls, VirtualTrees, Mask, ToolEdit, StdCtrls,
  CurrEdit, ComCtrls, TSysEstq;

type
  TfmPrdCost = class(TfrmModel)
    pgData: TPageControl;
    tsValues: TTabSheet;
    lCust_Final: TStaticText;
    eCust_Final: TCurrencyEdit;
    lCust_Forn: TStaticText;
    eCust_Forn: TCurrencyEdit;
    lCust_Rjst: TStaticText;
    eCust_Rjst: TCurrencyEdit;
    lCust_UFrn: TStaticText;
    eCust_UFrn: TCurrencyEdit;
    lQtd_Dias_Rep: TStaticText;
    eQtd_Dias_Rep: TCurrencyEdit;
    lCust_Real: TStaticText;
    eCust_Real: TCurrencyEdit;
    lCust_Med: TStaticText;
    eCust_Med: TCurrencyEdit;
    lFk_Vw_Fornecedores: TStaticText;
    eFk_Vw_Fornecedores: TEdit;
    lFlag_Rjst: TCheckBox;
    lQtd_Dias_Entr: TStaticText;
    eQtd_Dias_Entr: TCurrencyEdit;
    tsDatesAndQtd: TTabSheet;
    lQtd_EMax: TStaticText;
    eQtd_EMax: TCurrencyEdit;
    lDta_Prv_Entr_Compa: TStaticText;
    eDta_Prv_Entr_Compra: TDateEdit;
    lQtd_EMin: TStaticText;
    eQtd_EMin: TCurrencyEdit;
    lDta_UCmp: TStaticText;
    lDta_UMov: TStaticText;
    lDta_URsrv: TStaticText;
    eDta_URsrv: TMaskEdit;
    lDta_UInv: TStaticText;
    eDta_UInv: TMaskEdit;
    lDta_USld: TStaticText;
    eDta_USld: TMaskEdit;
    lQtd_Grnt: TStaticText;
    eQtd_Grnt: TCurrencyEdit;
    lQtd_Estq: TStaticText;
    eQtd_Estq: TCurrencyEdit;
    lQtd_Rsrv: TStaticText;
    eQtd_Rsrv: TCurrencyEdit;
    lQtd_Estq_Qr: TStaticText;
    eQtd_Estq_Qr: TCurrencyEdit;
    eEstq_Dspn: TCurrencyEdit;
    lEstq_Dspn: TStaticText;
    lQtd_Cns_Med: TStaticText;
    eQtd_Cns_Med: TCurrencyEdit;
    eQtd_Dias_Estq: TCurrencyEdit;
    lQtd_PedF: TStaticText;
    eQtd_PedF: TCurrencyEdit;
    lEstq_Prev: TStaticText;
    eEstq_Prev: TCurrencyEdit;
    eDta_UCmp: TDateEdit;
    eDta_UMov: TDateEdit;
    tsHistoric: TTabSheet;
    pgHistorics: TPageControl;
    tsCosts: TTabSheet;
    vtCostHist: TVirtualStringTree;
    tsStoks: TTabSheet;
    vtHistorics: TVirtualStringTree;
    pHist: TPanel;
    lInitialFilter: TStaticText;
    eInitialFilter: TDateEdit;
    eFinalFilter: TDateEdit;
    lFinalFilter: TStaticText;
    gbLegend: TGroupBox;
    shInPut: TShape;
    shOutput: TShape;
    shTransfer: TShape;
    lEntrada: TLabel;
    Label1: TLabel;
    shAdjust: TShape;
    lTransfer: TLabel;
    lAdjust: TLabel;
    lQtd_Cmp_Med: TStaticText;
    eQtd_Cmp_Med: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtHistoricsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtCostHistGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure pgHistoricsChange(Sender: TObject);
    procedure vtHistoricsBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure FilterChange(Sender: TObject);
  private
    { Private declarations }
    function  GetCustFinal: Double;
    function  GetCustRjst: Double;
    function  GetDtaPrvEntrCompra: TDate;
    function  GetDtaUCmp: TDate;
    function  GetDtaUMov: TDate;
    function  GetEndDate: TDate;
    function  GetFlagRjst: Boolean;
    function  GetQtdDiasEntr: Integer;
    function  GetQtdDiasRep: Integer;
    function  GetQtdEMax: Double;
    function  GetQtdEMin: Double;
    function  GetStartDate: TDate;
    procedure GetProdEstqHist;
    procedure GetProdCostHist;
    procedure SetCustFinal(const Value: Double);
    procedure SetCustForn(const Value: Double);
    procedure SetCustMed(const Value: Double);
    procedure SetCustReal(const Value: Double);
    procedure SetCustRjst(const Value: Double);
    procedure SetCustUFrn(const Value: Double);
    procedure SetDtaPrvEntrCompra(const Value: TDate);
    procedure SetDtaUCmp(const Value: TDate);
    procedure SetDtaUInv(const Value: TDate);
    procedure SetDtaUMov(const Value: TDate);
    procedure SetDtaURsrv(const Value: TDate);
    procedure SetDtaUSld(const Value: TDate);
    procedure SetEndDate(const Value: TDate);
    procedure SetEstqPrev(const Value: Double);
    procedure SetFkSupplier(const Value: string);
    procedure SetFlagRjst(const Value: Boolean);
    procedure SetQtdCnsMed(const Value: Double);
    procedure SetQtdDiasEntr(const Value: Integer);
    procedure SetQtdDiasEstq(const Value: Integer);
    procedure SetQtdDiasRep(const Value: Integer);
    procedure SetQtdDspn(const Value: Double);
    procedure SetQtdEMax(const Value: Double);
    procedure SetQtdEMin(const Value: Double);
    procedure SetQtdEstq(const Value: Double);
    procedure SetQtdEstqQr(const Value: Double);
    procedure SetQtdGrnt(const Value: Double);
    procedure SetQtdPedF(const Value: Double);
    procedure SetQtdRsrv(const Value: Double);
    procedure SetStartDate(const Value: TDate);
    procedure SetQtdCmpMed(const Value: Double);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  FkSupplier      : string                           write SetFkSupplier;
    property  CustFinal       : Double  read GetCustFinal        write SetCustFinal;
    property  CustRjst        : Double  read GetCustRjst         write SetCustRjst;
    property  QtdDiasRep      : Integer read GetQtdDiasRep       write SetQtdDiasRep;
    property  QtdDiasEntr     : Integer read GetQtdDiasEntr      write SetQtdDiasEntr;
    property  FlagRjst        : Boolean read GetFlagRjst         write SetFlagRjst;
    property  CustForn        : Double                           write SetCustForn;
    property  CustUFrn        : Double                           write SetCustUFrn;
    property  CustReal        : Double                           write SetCustReal;
    property  CustMed         : Double                           write SetCustMed;
    property  QtdEMax         : Double  read GetQtdEMax          write SetQtdEMax;
    property  QtdEMin         : Double  read GetQtdEMin          write SetQtdEMin;
    property  QtdEstq         : Double                           write SetQtdEstq;
    property  QtdRsrv         : Double                           write SetQtdRsrv;
    property  QtdEstqQr       : Double                           write SetQtdEstqQr;
    property  QtdGrnt         : Double                           write SetQtdGrnt;
    property  QtdDspn         : Double                           write SetQtdDspn;
    property  QtdPedF         : Double                           write SetQtdPedF;
    property  EstqPrev        : Double                           write SetEstqPrev;
    property  QtdCnsMed       : Double                           write SetQtdCnsMed;
    property  QtdCmpMed       : Double                           write SetQtdCmpMed;
    property  QtdDiasEstq     : Integer                          write SetQtdDiasEstq;
    property  DtaUCmp         : TDate   read GetDtaUCmp          write SetDtaUCmp;
    property  DtaUMov         : TDate   read GetDtaUMov          write SetDtaUMov;
    property  DtaURsrv        : TDate                            write SetDtaURsrv;
    property  DtaUInv         : TDate                            write SetDtaUInv;
    property  DtaUSld         : TDate                            write SetDtaUSld;
    property  DtaPrvEntrCompra: TDate   read GetDtaPrvEntrCompra write SetDtaPrvEntrCompra;
    property  StartDate       : TDate   read GetStartDate        write SetStartDate;
    property  EndDate         : TDate   read GetEndDate          write SetEndDate;
  end;

var
  fmPrdCost: TfmPrdCost;

implementation

uses Dado, mSysEstq, ProcUtils, ProcType, FuncoesDB, GridRow, EstqArqSql;

{$R *.dfm}

procedure TfmPrdCost.ClearControls;
begin
  if (Pk = 0) then exit;
  Loading := True;
  try
    CustFinal        := 0;
    CustForn         := 0;
    CustRjst         := 0;
    CustUFrn         := 0;
    QtdDiasRep       := 0;
    CustReal         := 0;
    CustMed          := 0;
    FlagRjst         := False;
    QtdDiasEntr      := 0;
    QtdEMax          := 0;
    DtaPrvEntrCompra := 0;
    QtdEMin          := 0;
    DtaUCmp          := 0;
    DtaUMov          := 0;
    DtaURsrv         := 0;
    DtaUInv          := 0;
    DtaUSld          := 0;
    QtdGrnt          := 0;
    QtdEstq          := 0;
    QtdRsrv          := 0;
    QtdEstqQr        := 0;
    QtdDspn          := 0;
    EstqPrev         := 0;
    QtdCnsMed        := 0;
    QtdDiasEstq      := 0;
    FkSupplier       := '';
  finally
    Loading := False;
  end;
end;

procedure TfmPrdCost.FormCreate(Sender: TObject);
begin
  inherited;
  pgData.Images             := Dados.Image16;
  pgHistorics.Images        := Dados.Image16;
  vtHistorics.Images        := Dados.Image16;
  vtHistorics.Header.Images := Dados.Image16;
  vtHistorics.NodeDataSize  := SizeOf(TGridData);
  vtCostHist.Images         := Dados.Image16;
  vtCostHist.Header.Images  := Dados.Image16;
  vtCostHist.NodeDataSize   := SizeOf(TGridData);
end;

procedure TfmPrdCost.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtHistorics);
  ReleaseTreeNodes(vtCostHist);
  inherited;
end;

function TfmPrdCost.GetCustFinal: Double;
begin
  Result := eCust_Final.Value;
end;

function TfmPrdCost.GetCustRjst: Double;
begin
  Result := eCust_Rjst.Value;
end;

function TfmPrdCost.GetDtaPrvEntrCompra: TDate;
begin
  Result := eDta_Prv_Entr_Compra.Date;
end;

function TfmPrdCost.GetDtaUCmp: TDate;
begin
  Result := eDta_UCmp.Date;
end;

function TfmPrdCost.GetDtaUMov: TDate;
begin
  Result := eDta_UMov.Date;
end;

function TfmPrdCost.GetEndDate: TDate;
begin
  Result := eFinalFilter.Date;
end;

function TfmPrdCost.GetFlagRjst: Boolean;
begin
  Result := lFlag_Rjst.Checked;
end;

function TfmPrdCost.GetQtdDiasEntr: Integer;
begin
  Result := eQtd_Dias_Entr.AsInteger;
end;

function TfmPrdCost.GetQtdDiasRep: Integer;
begin
  Result := eQtd_Dias_Rep.AsInteger;
end;

function TfmPrdCost.GetQtdEMax: Double;
begin
  Result := eQtd_EMax.Value;
end;

function TfmPrdCost.GetQtdEMin: Double;
begin
  Result := eQtd_EMin.Value;
end;

function TfmPrdCost.GetStartDate: TDate;
begin
  Result := eInitialFilter.Date;
end;

procedure TfmPrdCost.LoadDefaults;
begin
  StartDate := Date - 7;
  EndDate   := Date;
end;

procedure TfmPrdCost.MoveDataToControls;
var
  PrdCst: TProductCost;
begin
  Loading := True;
  try
    PrdCst           := dmSysEstq.GetProductCosts(Pk);
    CustFinal        := PrdCst.CustFinal;
    CustForn         := PrdCst.CustForn;
    CustRjst         := PrdCst.CustRjst;
    CustUFrn         := PrdCst.CustUFrn;
    QtdDiasRep       := PrdCst.QtdDiasRep;
    CustReal         := PrdCst.CustReal;
    CustMed          := PrdCst.CustMed;
    FlagRjst         := PrdCst.FlagRjst;
    QtdDiasEntr      := PrdCst.QtdDiasEntr;
    QtdEMax          := PrdCst.QtdEMax;
    DtaPrvEntrCompra := PrdCst.DtaPrvEntrCompra;
    QtdEMin          := PrdCst.QtdEMin;
    DtaUCmp          := PrdCst.DtaUCmp;
    DtaUMov          := PrdCst.DtaUMov;
    DtaURsrv         := PrdCst.DtaURsv;
    DtaUInv          := PrdCst.DtaUInv;
    DtaUSld          := PrdCst.DtaUSld;
    QtdGrnt          := PrdCst.QtdGrnt;
    QtdEstq          := PrdCst.QtdEstq;
    QtdRsrv          := PrdCst.QtdRsrv;
    QtdEstqQr        := PrdCst.QtdEstqQR;
    QtdDspn          := PrdCst.EstqDspn;
    EstqPrev         := PrdCst.EstqPrev;
    QtdCnsMed        := PrdCst.QtdCnsMed;
    QtdCmpMed        := PrdCst.QtdCmpMed;
    QtdDiasEstq      := PrdCst.QtdDiasEstq;
    FkSupplier       := PrdCst.FkSupplier.RazSoc;
  finally
    Loading := False;
  end;
end;

procedure TfmPrdCost.SaveIntoDB;
var
  aPrdCst: TProductCost;
begin
  aPrdCst := TProductCost.Create;
  try
    aPrdCst.CustFinal        := CustFinal;
    aPrdCst.CustRjst         := CustRjst;
    aPrdCst.QtdDiasRep       := QtdDiasRep;
    aPrdCst.QtdDiasEntr      := QtdDiasEntr;
    aPrdCst.FlagRjst         := FlagRjst;
    aPrdCst.QtdEMax          := QtdEMax;
    aPrdCst.QtdEMin          := QtdEMin;
    aPrdCst.DtaUCmp          := DtaUCmp;
    aPrdCst.DtaUMov          := DtaUMov;
    aPrdCst.DtaPrvEntrCompra := DtaPrvEntrCompra;
    dmSysEstq.UpdateProductCost(Pk, aPrdCst);
  finally
    aPrdCst.Clear;
    FreeAndNil(aPrdCst);
  end;
end;

procedure TfmPrdCost.SetCustFinal(const Value: Double);
begin
  eCust_Final.Value := Value;
end;

procedure TfmPrdCost.SetCustForn(const Value: Double);
begin
  eCust_Forn.Value := Value;
end;

procedure TfmPrdCost.SetCustMed(const Value: Double);
begin
  eCust_Med.Value := Value;
end;

procedure TfmPrdCost.SetCustReal(const Value: Double);
begin
  eCust_Real.Value := Value;
end;

procedure TfmPrdCost.SetCustRjst(const Value: Double);
begin
  eCust_Rjst.Value := Value;
end;

procedure TfmPrdCost.SetCustUFrn(const Value: Double);
begin
  eCust_UFrn.Value := Value;
end;

procedure TfmPrdCost.SetDtaPrvEntrCompra(const Value: TDate);
begin
  eDta_Prv_Entr_Compra.Clear;
  if (Value > 0) then
    eDta_Prv_Entr_Compra.Date := Value;
end;

procedure TfmPrdCost.SetDtaUCmp(const Value: TDate);
begin
  eDta_UCmp.Clear;
  if (Value > 0) then
    eDta_UCmp.Date := Value;
end;

procedure TfmPrdCost.SetDtaUInv(const Value: TDate);
begin
  eDta_UInv.Clear;
  if (Value > 0) then
    eDta_UInv.Text := FormatDateTime('dd/mm/yyyy', Value);
end;

procedure TfmPrdCost.SetDtaUMov(const Value: TDate);
begin
  eDta_UMov.Clear;
  if (Value > 0) then
    eDta_UMov.Date := Value;
end;

procedure TfmPrdCost.SetDtaURsrv(const Value: TDate);
begin
  eDta_URsrv.Clear;
  if (Value > 0) then
    eDta_URsrv.Text := FormatDateTime('dd/mm/yyyy', Value);
end;

procedure TfmPrdCost.SetDtaUSld(const Value: TDate);
begin
  eDta_USld.Clear;
  if (Value > 0) then
    eDta_USld.Text := FormatDateTime('dd/mm/yyyy', Value);
end;

procedure TfmPrdCost.SetEndDate(const Value: TDate);
begin
  eFinalFilter.Clear;
  if (Value = 0) or (StartDate = 0) then exit;
  eFinalFilter.Date := Value;
  case pgHistorics.ActivePageIndex of
    0: GetProdCostHist;
    1: GetProdEstqHist;
  end;
end;

procedure TfmPrdCost.SetEstqPrev(const Value: Double);
begin
  eEstq_Prev.Value := Value;
end;

procedure TfmPrdCost.SetFkSupplier(const Value: string);
begin
  eFk_Vw_Fornecedores.Text := Value;
end;

procedure TfmPrdCost.SetFlagRjst(const Value: Boolean);
begin
  lFlag_Rjst.Checked := Value;
end;

procedure TfmPrdCost.SetQtdCnsMed(const Value: Double);
begin
  eQtd_Cns_Med.Value := Value;
end;

procedure TfmPrdCost.SetQtdDiasEntr(const Value: Integer);
begin
  eQtd_Dias_Entr.AsInteger := Value;
end;

procedure TfmPrdCost.SetQtdDiasEstq(const Value: Integer);
begin
  eQtd_Dias_Estq.AsInteger := Value;
end;

procedure TfmPrdCost.SetQtdDiasRep(const Value: Integer);
begin
  eQtd_Dias_Rep.AsInteger := Value;
end;

procedure TfmPrdCost.SetQtdDspn(const Value: Double);
begin
  eEstq_Dspn.Value := Value;
end;

procedure TfmPrdCost.SetQtdEMax(const Value: Double);
begin
  eQtd_EMax.Value := Value;
end;

procedure TfmPrdCost.SetQtdEMin(const Value: Double);
begin
  eQtd_EMin.Value := Value;
end;

procedure TfmPrdCost.SetQtdEstq(const Value: Double);
begin
  eQtd_Estq.Value := Value;
end;

procedure TfmPrdCost.SetQtdEstqQr(const Value: Double);
begin
  eQtd_Estq_Qr.Value := Value;
end;

procedure TfmPrdCost.SetQtdGrnt(const Value: Double);
begin
  eQtd_Grnt.Value := Value;
end;

procedure TfmPrdCost.SetQtdPedF(const Value: Double);
begin
  eQtd_PedF.Value := Value;
end;

procedure TfmPrdCost.SetQtdRsrv(const Value: Double);
begin
  eQtd_Rsrv.Value := Value;
end;

procedure TfmPrdCost.SetStartDate(const Value: TDate);
begin
  eInitialFilter.OnChange := nil;
  try
    eInitialFilter.Clear;
    if (Value > 0) or (EndDate > 0) then
    begin
      eInitialFilter.Date := Value;
      case pgHistorics.ActivePageIndex of
        0: GetProdCostHist;
        1: GetProdEstqHist;
      end;
    end;
  finally
    eInitialFilter.OnChange := FilterChange;
  end;
end;

procedure TfmPrdCost.GetProdEstqHist;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (vtHistorics.RootNodeCount > 0) then
    ReleaseTreeNodes(vtHistorics);
  with dmSysEstq do
  begin
    if ProdHistoric.Active then ProdHistoric.Close;
    ProdHistoric.SQL.Clear;
    ProdHistoric.SQL.Add(SqlProdutosSaldos);
    vtHistorics.BeginUpdate;
    Dados.StartTransaction(ProdHistoric);
    try
      if (ProdHistoric.Params.FindParam('FkEmpresas') <> nil) then
        ProdHistoric.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      if (ProdHistoric.Params.FindParam('FkProdutos') <> nil) then
        ProdHistoric.ParamByName('FkProdutos').AsInteger := Pk;
      if (ProdHistoric.Params.FindParam('DthrSldIni') <> nil) then
        ProdHistoric.ParamByName('DthrSldIni').AsDateTime := StartDate;
      if (ProdHistoric.Params.FindParam('DthrSldFin') <> nil) then
        ProdHistoric.ParamByName('DthrSldFin').AsDateTime := EndDate;
{      ShowMessage('Sql do ProdHistoric: ' + NL + ProdHistoric.SQL.Text + NL +
        'Onde Parametros são: ' + NL +
        'FkEmpresas: ' + ProdHistoric.ParamByName('FkEmpresas').AsString + NL +
        'FkProdutos: ' + ProdHistoric.ParamByName('FkProdutos').AsString + NL +
        'DthrSldFin: ' + DateTimeToStr(ProdHistoric.ParamByName('DthrSldIni').AsDateTime) + NL +
        'DthrSldFin: ' + DateTimeToStr(ProdHistoric.ParamByName('DthrSldFin').AsDateTime));}
      if not ProdHistoric.Active then ProdHistoric.Open;
      while not ProdHistoric.Eof do
      begin
        Node := vtHistorics.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtHistorics.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, ProdHistoric, True);
          end;
        end;
        ProdHistoric.Next;
      end;
    finally
      if ProdHistoric.Active then ProdHistoric.Close;
      Dados.CommitTransaction(ProdHistoric);
      vtHistorics.EndUpdate;
    end;
  end;
end;

procedure TfmPrdCost.GetProdCostHist;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (vtCostHist.RootNodeCount > 0) then
    ReleaseTreeNodes(vtCostHist);
  with dmSysEstq do
  begin
    if ProdCostHist.Active then ProdCostHist.Close;
    ProdCostHist.SQL.Clear;
    ProdCostHist.SQL.Add(SqlProdCostHist);
    try
      Dados.StartTransaction(ProdCostHist);
      if (ProdCostHist.Params.FindParam('FkEmpresas') <> nil) then
        ProdCostHist.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      if (ProdCostHist.Params.FindParam('FkProdutos') <> nil) then
        ProdCostHist.ParamByName('FkProdutos').AsInteger := Pk;
      if (ProdCostHist.Params.FindParam('DthrIncIni') <> nil) then
        ProdCostHist.ParamByName('DthrIncIni').AsDateTime := StartDate;
      if (ProdCostHist.Params.FindParam('DthrIncFin') <> nil) then
        ProdCostHist.ParamByName('DthrIncFin').AsDateTime := EndDate;
      if not ProdCostHist.Active then ProdCostHist.Open;
      while not ProdCostHist.Eof do
      begin
        Node := vtCostHist.AddChild(nil);
        if (Node <> nil) then // Level 0 (Date, Supplier and New Costs)
        begin
          Data := vtCostHist.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level := 0;
            Data^.Node  := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, ProdCostHist, True);
          end;
          Node := vtCostHist.AddChild(Node);
          if Node <> nil then // Level 1 (Prior Supplier and Costs)
          begin
            Data := vtCostHist.GetNodeData(Node);
            if (Data <> nil) then
            begin
              Data^.Level := 0;
              Data^.Node  := Node;
              Data^.DataRow := TDataRow.CreateFromDataSet(nil, ProdCostHist, True);
            end;
          end;
        end;
        ProdCostHist.Next;
      end;
    finally
      if ProdCostHist.Active then ProdCostHist.Close;
      Dados.CommitTransaction(ProdCostHist);
    end;
  end;
end;

procedure TfmPrdCost.vtHistoricsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := FormatDateTime('dd/mm/yyyy hh:mm:ss', Data^.DataRow.FieldByName['DTHR_SLD'].AsDateTime);
    1: if (Data^.DataRow.FieldByName['QTD_ENTRADA'].AsFloat = 0) then
         CellText := ''
       else
         CellText := FloatToStrF(Data^.DataRow.FieldByName['QTD_ENTRADA'].AsFloat,
                     ffNumber, 7, Dados.DecimalPlacesQtd);
    2: if (Data^.DataRow.FieldByName['QTD_SAIDA'].AsFloat = 0) then
         CellText := ''
       else
         CellText := FloatToStrF(Data^.DataRow.FieldByName['QTD_SAIDA'].AsFloat,
                     ffNumber, 7, Dados.DecimalPlacesQtd);
    3: CellText := FloatToStrF(Data^.DataRow.FieldByName['SLD_INS'].AsFloat,
                     ffNumber, 7, Dados.DecimalPlacesQtd);
    4: CellText := Data^.DataRow.FieldByName['NUM_DOC'].AsString;
    5: CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
    6: CellText := Data^.DataRow.FieldByName['DSC_TMOV'].AsString;
    7: CellText := Data^.DataRow.FieldByName['DSC_TDOC'].AsString;
  end;
end;

procedure TfmPrdCost.vtCostHistGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
  cd  : Integer;
  procedure SetColumnsLevel0;
  begin
    case Column of
      0: CellText := FormatDateTime('dd/mm/yyyy hh:mm:ss', Data^.DataRow.FieldByName['DTHR_INC'].AsDateTime);
      1: CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
      2: CellText := FloatToStrF(Data^.DataRow.FieldByName['CUST_FORN'].AsFloat , ffNumber, 18, cd);
      3: CellText := FloatToStrF(Data^.DataRow.FieldByName['CUST_REAL'].AsFloat , ffNumber, 18, cd);
      4: CellText := FloatToStrF(Data^.DataRow.FieldByName['CUST_MED'].AsFloat  , ffNumber, 18, cd);
      5: CellText := FloatToStrF(Data^.DataRow.FieldByName['CUST_FINAL'].AsFloat, ffNumber, 18, cd);
    else
      CellText := '';
    end
  end;
  procedure SetColumnsLevel1;
  begin
    case Column of
      0: CellText := 'Anterior';
      1: CellText := Data^.DataRow.FieldByName['RAZ_SOC_ANT'].AsString;
      2: CellText := FloatToStrF(Data^.DataRow.FieldByName['CUST_FORN_ANT'].AsFloat , ffNumber, 18, cd);
      3: CellText := FloatToStrF(Data^.DataRow.FieldByName['CUST_REAL_ANT'].AsFloat , ffNumber, 18, cd);
      4: CellText := FloatToStrF(Data^.DataRow.FieldByName['CUST_MED_ANT'].AsFloat  , ffNumber, 18, cd);
      5: CellText := FloatToStrF(Data^.DataRow.FieldByName['CUST_FINAL_ANT'].AsFloat, ffNumber, 18, cd);
    else
      CellText := '';
    end;
  end;
begin
  cd := Dados.DecimalPlaces;
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: SetColumnsLevel0;
    1: SetColumnsLevel1;
  end;
end;

procedure TfmPrdCost.pgHistoricsChange(Sender: TObject);
begin
  gbLegend.Visible := (pgHistorics.ActivePageIndex = 1); 
  SetStartDate(eInitialFilter.Date);
end;

procedure TfmPrdCost.vtHistoricsBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  Data: PGridData;
const
  MOV_COLOR: array [0..3] of TColor =
    (clInfoBk, clMoneyGreen, clSkyBlue, clYellow);
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ItemColor := MOV_COLOR[Data^.DataRow.FieldByName['FLAG_TSLD'].AsInteger];
  EraseAction := eaColor;
end;

procedure TfmPrdCost.FilterChange(Sender: TObject);
begin
  pgHistoricsChange(Sender);
end;

procedure TfmPrdCost.SetQtdCmpMed(const Value: Double);
begin
  eQtd_Cmp_Med.Value := Value;
end;

end.
