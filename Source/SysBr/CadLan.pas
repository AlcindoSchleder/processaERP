unit CadLan;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 06/03/2003 - DD/MM/YYYY                                      *}
{* Modified: 06/03/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
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
  Dialogs, AccFrm, VirtualTrees, StdCtrls, Mask, ToolEdit, CurrEdit, TSysBcCx,
  PrcCombo, ExtCtrls, ComCtrls, mSysBcCx, TSysFatAux, ProcUtils;

type
  TTypeAccountLan = (taNone, taAccountLan, taPrevisionAccount);

  TCdLancamentos = class(TFrmAccounts)
    pgControlList: TPageControl;
    tsListLan: TTabSheet;
    tsDataLan: TTabSheet;
    pgControlLan: TPageControl;
    tsLan: TTabSheet;
    stFkFinanceOperation: TStaticText;
    eFkFinanceOperation: TPrcComboBox;
    stFkPaymentWay: TStaticText;
    eFkPaymentWay: TPrcComboBox;
    eTotSel: TCurrencyEdit;
    stTotSel: TStaticText;
    stNumDoc: TStaticText;
    eNumDoc: TCurrencyEdit;
    tsLanCta: TTabSheet;
    eSldCta: TCurrencyEdit;
    eDtaSld: TDateEdit;
    lSldCta: TStaticText;
    vtList: TVirtualStringTree;
    lPk_Contas_Lancamentos: TStaticText;
    ePk_Contas_Lancamentos: TCurrencyEdit;
    lFk_Finalizadoras: TStaticText;
    eFk_Finalizadoras: TPrcComboBox;
    eFk_Operacoes_Financeiras: TPrcComboBox;
    lFk_Operacoes_Financeiras: TStaticText;
    lFk_Cadastros: TStaticText;
    eFk_Cadastros: TPrcComboBox;
    lFk_Historicos_Padroes: TStaticText;
    eFk_Historicos_Padroes: TPrcComboBox;
    lDsc_Lan: TStaticText;
    eDsc_Lan: TEdit;
    sTitle: TShape;
    lTitle: TLabel;
    lDta_Lan: TStaticText;
    eDta_Lan: TDateEdit;
    lVlr_Lan: TStaticText;
    eVlr_Lan: TCurrencyEdit;
    lJur_Lan: TStaticText;
    eJur_Lan: TCurrencyEdit;
    pgClassification: TPageControl;
    tsClassification: TTabSheet;
    tsClassData: TTabSheet;
    vtClassList: TVirtualStringTree;
    lFk_Classificacao: TStaticText;
    lVlr_Lan_Clas: TStaticText;
    eVlr_Lan_Clas: TCurrencyEdit;
    lFlag_DbCr: TRadioGroup;
    lNum_Doc_Quit: TStaticText;
    eNum_Doc_Quit: TCurrencyEdit;
    lFk_Contas: TStaticText;
    eFk_Contas: TComboBox;
    eFk_Classificacao: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListBeforeItemErase(Sender: TBaseVirtualTree;
      Canvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtListInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure lFlag_DbCrClick(Sender: TObject);
    procedure eFk_ClassificacaoDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure eFk_ClassificacaoSelect(Sender: TObject);
  private
    { Private declarations }
    FPkAccount     : Integer;
    FTypeAccountLan: TTypeAccountLan;
    FTypeLan       : TTypeLan;
    FEndBaseDate   : TDate;
    FStartBaseDate : TDate;
    function  GetDscLan: string;
    function  GetDtaLan: TDate;
    function  GetDtaSld: TDate;
    function  GetFlagDbCr: TTypeLan;
    function  GetFkCadastros: Integer;
    function  GetFkClassificacao: Integer;
    function  GetFkFinalizadoras: Integer;
    function  GetFkFinanceOperation: Integer;
    function  GetFkHistoricosPadrao: Integer;
    function  GetFkOperacoesFinance: Integer;
    function  GetFkPaymentWay: Integer;
    function  GetJurLan: Double;
    function  GetNumDoc: Integer;
    function  GetPkContasLancamento: Integer;
    function  GetSldCta: Double;
    function  GetTotSel: Double;
    function  GetVlrLan: Double;
    function  GetVlrLanClass: Double;
    procedure SetDscLan(const Value: string);
    procedure SetDtaLan(const Value: TDate);
    procedure SetDtaSld(const Value: TDate);
    procedure SetFkCadastros(const Value: Integer);
    procedure SetFlagDbCr(const Value: TTypeLan);
    procedure SetFkClassificacao(const Value: Integer);
    procedure SetFkFinalizadoras(const Value: Integer);
    procedure SetFkFinanceOperation(const Value: Integer);
    procedure SetFkHistoricosPadrao(const Value: Integer);
    procedure SetFkOperacoesFinance(const Value: Integer);
    procedure SetJurLan(const Value: Double);
    procedure SetEnabledControls;
    procedure SetLancamento;
    procedure SetLancamentoConta;
    procedure SetNumDoc(const Value: Integer);
    procedure SetPaymentWay(const Value: Integer);
    procedure SetPkContasLancamento(const Value: Integer);
    procedure SetSldCta(const Value: Double);
    procedure SetTitle(const Value: string);
    procedure SetTotSel(const Value: Double);
    procedure SetTypeAccountLan(const Value: TTypeAccountLan);
    procedure SetVlrLan(const Value: Double);
    procedure SetVlrLanClass(const Value: Double);
    procedure SetEndBaseDate(const Value: TDate);
    procedure SetStartBaseDate(const Value: TDate);
    procedure LoadGrids(Sender: TVirtualStringTree; ATypeCount: TAccountType);
    procedure ChangeScrMode(Sender: TObject; AMode: TDBMode);
    function GetNumDocQuit: Integer;
    procedure SetNumDocQuit(const Value: Integer);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure DeleteFromDB; override;
    procedure ClearControls; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    // propriedades do Lançamento para quitação
    property FkFinanceOperation: Integer         read GetFkFinanceOperation write SetFkFinanceOperation;
    property FkPaymentWay      : Integer         read GetFkPaymentWay       write SetPaymentWay;
    property NumDoc            : Integer         read GetNumDoc             write SetNumDoc;
    property TotSel            : Double          read GetTotSel             write SetTotSel;
    // propriedades do Lançamento das contas
    property DtaSld            : TDate           read GetDtaSld             write SetDtaSld;
    property SldCta            : Double          read GetSldCta             write SetSldCta;
    // propriedades do Lancamento em inclusão ou edição
    property DscLan            : string          read GetDscLan             write SetDscLan;
    property DtaLan            : TDate           read GetDtaLan             write SetDtaLan;
    property FlagDbCr          : TTypeLan        read GetFlagDbCr           write SetFlagDbCr;
    property FkCadastros       : Integer         read GetFkCadastros        write SetFkCadastros;
    property FkFinalizadoras   : Integer         read GetFkFinalizadoras    write SetFkFinalizadoras;
    property FkHistoricosPadrao: Integer         read GetFkHistoricosPadrao write SetFkHistoricosPadrao;
    property FkOperacoesFinance: Integer         read GetFkOperacoesFinance write SetFkOperacoesFinance;
    property NumDocQuit        : Integer         read GetNumDocQuit         write SetNumDocQuit;
    property PkContasLancamento: Integer         read GetPkContasLancamento write SetPkContasLancamento;
    property Title             : string                              write SetTitle;
    property VlrLan            : Double          read GetVlrLan             write SetVlrLan;
    property JurLan            : Double          read GetJurLan             write SetJurLan;
    // propriedades das Calssificações do Lancamento em inclusão ou edição
    property FkClassificacao   : Integer         read GetFkClassificacao    write SetFkClassificacao;
    property VlrLanClass       : Double          read GetVlrLanClass        write SetVlrLanClass;
  public
    { Public declarations }
    property EndBaseDate       : TDate           read FEndBaseDate          write SetEndBaseDate;
    property PkAccount         : Integer         read FPkAccount            write FPkAccount;
    property StartBaseDate     : TDate           read FStartBaseDate        write SetStartBaseDate;
    property TypeAccountLan    : TTypeAccountLan read FTypeAccountLan       write SetTypeAccountLan;
  end;

var
  CdLancamentos: TCdLancamentos;

implementation

uses Dado, Funcoes, FuncoesDB, ProcType, GridRow, ArqSqlBcCx;

{$R *.dfm}

{ TCdLancamentos }

procedure TCdLancamentos.FormCreate(Sender: TObject);
begin
  vtList.NodeDataSize       := SizeOf(TGridData);
  vtList.Images             := Dados.Image16;
  vtList.Header.Images      := Dados.Image16;
  vtClassList.NodeDataSize  := SizeOf(TGridData);
  vtClassList.Images        := Dados.Image16;
  vtClassList.Header.Images := Dados.Image16;
  InternalScrMode           := ChangeScrMode;
  inherited;
end;

procedure TCdLancamentos.FormDestroy(Sender: TObject);
  procedure ReleaseAccounts;
  var
    i: Integer;
    P: Pointer;
  begin
    if (eFk_Contas.Items.Count = 0) then exit;
    for i := 0 to eFk_Contas.Items.Count - 1 do
    begin
      if (eFk_Contas.Items.Objects[i] <> nil) then
      begin
        if (TAccount(eFk_Contas.Items.Objects[i]).FkTypeAccount.Tag > 0) then
        begin
          P := Pointer(TAccount(eFk_Contas.Items.Objects[i]).FkTypeAccount.Tag);
          FreeMem(P);
        end;
        TAccount(eFk_Contas.Items.Objects[i]).Free;
        eFk_Contas.Items.Objects[i] := nil;
      end;
    end;
    eFk_Contas.Items.Clear;
  end;
begin
  ReleaseAccounts;
  ReleaseCombos(eFk_Classificacao, toObject);
  eFk_Operacoes_Financeiras.ReleaseObjects;
  eFk_Finalizadoras.ReleaseObjects;
  eFk_Cadastros.ReleaseObjects;
  eFk_Historicos_Padroes.ReleaseObjects;
  ReleaseTreeNodes(vtList);
  ReleaseTreeNodes(vtClassList);
  inherited;
end;

procedure TCdLancamentos.ClearControls;
begin
  Loading            := True;
  FkFinanceOperation := 0;
  FkPaymentWay       := 0;
  NumDoc             := 0;
  TotSel             := 0.0;
  DtaSld             := 0;
  SldCta             := 0.0;
  DscLan             := '';
  DtaLan             := 0;
  FlagDbCr           := tlCredit;
  FkCadastros        := 0;
  FkFinalizadoras    := 0;
  FkHistoricosPadrao := 0;
  FkOperacoesFinance := 0;
  PkContasLancamento := 0;
  Title              := 'Lancamentos';
  VlrLan             := 0.0;
  JurLan             := 0.0;
  FkClassificacao    := 0;
  VlrLanClass        := 0.0;
  Loading            := False;
end;

procedure TCdLancamentos.DeleteFromDB;
begin
  if (FTypeAccountLan <> taPrevisionAccount) then exit;
  // dmSysBcCx.SaveLancamento;
end;

function TCdLancamentos.GetDscLan: string;
begin
  Result := eDsc_Lan.Text;
end;

function TCdLancamentos.GetDtaLan: TDate;
begin
  Result := eDta_Lan.Date;
end;

function TCdLancamentos.GetDtaSld: TDate;
begin
  Result := eDtaSld.Date;
end;

function TCdLancamentos.GetFlagDbCr: TTypeLan;
begin
  FTypeLan := TTypeLan(lFLag_DbCr.ItemIndex);
  Result := FTypeLan;
end;

function TCdLancamentos.GetFkCadastros: Integer;
begin
  Result := eFk_Cadastros.ItemIndex;
  if (Result > -1) and (eFk_Cadastros.Items.Objects[Result] <> nil) then
    Result := Integer(eFk_Cadastros.Items.Objects[Result]);
end;

function TCdLancamentos.GetFkClassificacao: Integer;
begin
  Result := eFk_Classificacao.ItemIndex;
  if (Result > -1) and (eFk_Classificacao.Items.Objects[Result] <> nil) then
    Result := Integer(eFk_Classificacao.Items.Objects[Result]);
end;

function TCdLancamentos.GetFkFinalizadoras: Integer;
begin
  Result := eFk_Finalizadoras.ItemIndex;
  if (Result > -1) and (eFk_Finalizadoras.Items.Objects[Result] <> nil) then
    Result := Integer(eFk_Finalizadoras.Items.Objects[Result]);
end;

function TCdLancamentos.GetFkFinanceOperation: Integer;
begin
  Result := eFkFinanceOperation.ItemIndex;
  if (Result > -1) and (eFkFinanceOperation.Items.Objects[Result] <> nil) then
    Result := Integer(eFkFinanceOperation.Items.Objects[Result]);
end;

function TCdLancamentos.GetFkHistoricosPadrao: Integer;
begin
  Result := eFk_Historicos_Padroes.ItemIndex;
  if (Result > -1) and (eFk_Historicos_Padroes.Items.Objects[Result] <> nil) then
    Result := Integer(eFk_Historicos_Padroes.Items.Objects[Result]);
end;

function TCdLancamentos.GetFkOperacoesFinance: Integer;
begin
  Result := eFk_Operacoes_Financeiras.ItemIndex;
  if (Result > -1) and (eFk_Operacoes_Financeiras.Items.Objects[Result] <> nil) then
    Result := Integer(eFk_Operacoes_Financeiras.Items.Objects[Result]);
end;

function TCdLancamentos.GetFkPaymentWay: Integer;
begin
  Result := eFkPaymentWay.ItemIndex;
  if (Result > -1) and (eFkPaymentWay.Items.Objects[Result] <> nil) then
    Result := Integer(eFkPaymentWay.Items.Objects[Result]);
end;

function TCdLancamentos.GetJurLan: Double;
begin
  Result := eJur_Lan.Value;
end;

function TCdLancamentos.GetNumDoc: Integer;
begin
  Result := eNumDoc.AsInteger;
end;

function TCdLancamentos.GetPkContasLancamento: Integer;
begin
  Result := ePk_Contas_Lancamentos.AsInteger;
end;

function TCdLancamentos.GetSldCta: Double;
begin
  Result := eSldCta.Value;
end;

function TCdLancamentos.GetTotSel: Double;
begin
  Result := eTotSel.Value;
end;

function TCdLancamentos.GetVlrLan: Double;
begin
  Result := eVlr_Lan.Value;
end;

function TCdLancamentos.GetVlrLanClass: Double;
begin
  Result := eVlr_Lan_Clas.Value;
end;

procedure TCdLancamentos.LoadDefaults;
begin
//  Load All Combos
  if (not ListLoaded) then
  begin
    LoadGrids(vtList, atCash);
    eFk_Operacoes_Financeiras.Items.AddStrings(dmSysBcCx.LoadTypeOperations);
    eFk_Finalizadoras.Items.AddStrings(dmSysBcCx.LoadPaymentWay);
    eFk_Contas.Items.AddStrings(dmSysBcCx.LoadAccounts(Integer(FTypeAccountLan)));
    eFk_Historicos_Padroes.Items.AddStrings(dmSysBcCx.LoadHistorics);
    ListLoaded := True;
  end;
end;

procedure TCdLancamentos.MoveDataToControls;
begin
  case FTypeAccountLan of
    taNone            : SetLancamento;
    taAccountLan      ,
    taPrevisionAccount: SetLancamentoConta;
  end;
end;

procedure TCdLancamentos.SaveIntoDB;
begin

end;

procedure TCdLancamentos.SetDscLan(const Value: string);
begin
  eDsc_Lan.Text := Value;
end;

procedure TCdLancamentos.SetDtaLan(const Value: TDate);
begin
  eDta_Lan.Clear;
  if (Value > 0) then
    eDta_Lan.Date := Value;
end;

procedure TCdLancamentos.SetDtaSld(const Value: TDate);
begin
  eDtaSld.Clear;
  if (Value > 0) then
    eDtaSld.Date := Value;
end;

procedure TCdLancamentos.SetEndBaseDate(const Value: TDate);
begin
  FEndBaseDate := Value;
end;

procedure TCdLancamentos.SetFlagDbCr(const Value: TTypeLan);
begin
  if (FTypeLan <> Value) then
  begin
    FTypeLan := Value;
    eFk_Cadastros.ReleaseObjects;
    eFk_Cadastros.Items.AddStrings(dmSysBcCx.LoadOwners(FTypeLan));
    ReleaseCombos(eFk_Classificacao, toObject);
    eFk_Classificacao.Items.AddStrings(dmSysBcCx.LoadClassifications(FTypeLan));
  end;
  lFlag_DbCr.ItemIndex := Ord(Value);
end;

procedure TCdLancamentos.SetFkCadastros(const Value: Integer);
begin
  eFk_Cadastros.SetIndexFromIntegerValue(Value);
end;

procedure TCdLancamentos.SetFkClassificacao(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to eFk_Classificacao.Items.Count - 1 do
  begin
    if (eFk_Classificacao.Items.Objects[i] <> nil) and
       (TClassification(eFk_Classificacao.Items.Objects[i]).PkClassification = Value) then
      eFk_Classificacao.ItemIndex := Value;
  end;
end;

procedure TCdLancamentos.SetFkFinalizadoras(const Value: Integer);
begin
  eFk_Finalizadoras.SetIndexFromIntegerValue(Value);
end;

procedure TCdLancamentos.SetFkFinanceOperation(const Value: Integer);
begin
  eFkFinanceOperation.SetIndexFromIntegerValue(Value);
end;

procedure TCdLancamentos.SetFkHistoricosPadrao(const Value: Integer);
begin
  eFk_Historicos_Padroes.SetIndexFromIntegerValue(Value);
end;

procedure TCdLancamentos.SetFkOperacoesFinance(const Value: Integer);
begin
  eFk_Operacoes_Financeiras.SetIndexFromIntegerValue(Value);
end;

procedure TCdLancamentos.SetJurLan(const Value: Double);
begin
  eJur_Lan.Value := Value;
end;

procedure TCdLancamentos.SetNumDoc(const Value: Integer);
begin
  eJur_Lan.AsInteger := Value;
end;

procedure TCdLancamentos.SetPaymentWay(const Value: Integer);
begin
  eFkPaymentWay.SetIndexFromIntegerValue(Value);
end;

procedure TCdLancamentos.SetPkContasLancamento(const Value: Integer);
begin
  ePk_Contas_Lancamentos.AsInteger := Value;
end;

procedure TCdLancamentos.SetSldCta(const Value: Double);
begin
  eSldCta.Value := Value;
end;

procedure TCdLancamentos.SetStartBaseDate(const Value: TDate);
begin
  FStartBaseDate := Value;
end;

procedure TCdLancamentos.SetTitle(const Value: string);
begin
  lTitle.Caption := Value;
end;

procedure TCdLancamentos.SetTotSel(const Value: Double);
begin
  eTotSel.Value := Value;
end;

procedure TCdLancamentos.SetTypeAccountLan(const Value: TTypeAccountLan);
begin
  if (FTypeAccountLan <> Value) then
  begin
    FTypeAccountLan := Value;
    MoveDataToControls;
  end;
end;

procedure TCdLancamentos.SetVlrLan(const Value: Double);
begin
  eVlr_Lan.Value := Value;
end;

procedure TCdLancamentos.SetVlrLanClass(const Value: Double);
begin
  eVlr_Lan_Clas.Value := Value;
end;

procedure TCdLancamentos.SetLancamento;
begin
  pgControlLan.ActivePageIndex := 0;
  SetEnabledControls;
end;

procedure TCdLancamentos.SetLancamentoConta;
begin
  pgControlLan.ActivePageIndex := 1;
  SetEnabledControls;
end;

procedure TCdLancamentos.SetEnabledControls;
begin
  lFk_Finalizadoras.Enabled := (pgControlLan.ActivePageIndex = 1);
  eFk_Finalizadoras.Enabled := (pgControlLan.ActivePageIndex = 1);
  lNum_Doc_Quit.Enabled     := (pgControlLan.ActivePageIndex = 1);
  eNum_Doc_Quit.Enabled     := (pgControlLan.ActivePageIndex = 1);
end;

procedure TCdLancamentos.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
  aVdb: Double;
  aVcr: Double;
  aDec: Integer;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aDec := Dados.Parametros.CasasDecimais;
  if (Sender.GetNodeLevel(Node) = 0) then
    case Column of
      0: if (Data^.DataRow.FieldByName['DTA_SLD'].IsNull) then
           CellText := DateToStr(Date)
         else
           CellText := Data^.DataRow.FieldByName['DTA_SLD'].AsString;
      1: CellText := Data^.DataRow.FieldByName['DSC_CTA'].AsString;
      2: CellText := ' ';
      3: CellText := ' ';
      4: CellText := FloatToStrF(Data^.DataRow.FieldByName['SLD_CTA'].AsFloat, ffNumber, 7, 2);
      5: CellText := ' ';
    end
  else
  begin
    aVdb := 0;
    aVcr := 0;
    if Data^.DataRow.FieldByName['FLAG_DBCR'].AsInteger = 0 then
      aVdb := Data^.DataRow.FieldByName['VLR_LAN'].AsFloat;
    if Data^.DataRow.FieldByName['FLAG_DBCR'].AsInteger = 1 then
      aVcr := Data^.DataRow.FieldByName['VLR_LAN'].AsFloat;
    case Column of
      0: CellText := Data^.DataRow.FieldByName['DTA_LAN'].AsString;
      1: CellText := Data^.DataRow.FieldByName['DSC_LAN'].AsString;
      2: if aVdb > 0 then CellText := FloatToStrF(aVdb, ffNumber, 7, aDec) else CellText := ' ';
      3: if aVcr > 0 then CellText := FloatToStrF(aVcr, ffNumber, 7, aDec) else CellText := ' ';
      4: if (Data^.DataRow.FieldByName['SLD_LAN'].AsFloat = 0) then
           CellText := ' '
         else
           CellText := FloatToStrF(Data^.DataRow.FieldByName['SLD_LAN'].AsFloat, ffNumber, 7, aDec);
      5: CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
    end
  end;
end;

procedure TCdLancamentos.vtListBeforeItemErase(Sender: TBaseVirtualTree;
  Canvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    Canvas.Brush.Color := clSkyBlue;
    ItemColor          := clSkyBlue;
  end
  else
    if (Data^.DataRow.FieldByName['SLD_LAN'].AsFloat = 0) then
    begin
      Canvas.Brush.Color := clInfoBk;
      ItemColor          := clInfoBk;
    end
    else
    begin
      Canvas.Brush.Color := clInfoBk;
      ItemColor          := clMoneyGreen;
    end;
  EraseAction := eaColor;
end;

procedure TCdLancamentos.vtListPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  if (Node = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    TargetCanvas.Font.Style := [fsBold];
end;

procedure TCdLancamentos.LoadGrids(Sender: TVirtualStringTree; ATypeCount: TAccountType);
var
  Node: PVirtualNode;
  Data: PGridData;
  aCta: string;
  aDta: TDate;
  function AddNode(ANode: PVirtualNode): PVirtualNode;
  begin
    Result := Sender.AddChild(ANode);
    if (Result <> nil) then
    begin
      Data := Sender.GetNodeData(Result);
      if (Data <> nil) then
      begin
        Data^.Level   := 0;
        Data^.Node    := Result;
        Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysBcCx.qrFinance, True);
      end;
    end;
  end;
begin
  aCta := '';
  aDta := 0;
  ReleaseTreeNodes(Sender);
  with dmSysBcCx do
  begin
    if qrFinance.Active then qrFinance.Close;
    qrFinance.SQL.Clear;
    case FTypeAccountLan of
      taNone            : qrFinance.SQL.Add(SqlLancamentos);
      taAccountLan      ,
      taPrevisionAccount: qrFinance.SQL.Add(SqlLancamentosCta);
    end;
    if Dados.Conexao.TransactionsSupported then
      Dados.Conexao.StartTransaction(Dados.GetTr(Dados.FTr));
    Sender.BeginUpdate;
    try
      qrFinance.ParamByName('FkEmpresas').AsInteger := Dados.Parametros.EmpresaAtiva;
      qrFinance.ParamByName('StartDate').AsDate     := FStartBaseDate;
      qrFinance.ParamByName('EndDate').AsDate       := FEndBaseDate;
      if (qrFinance.Params.FindParam('FlagTCta') <> nil) then
        qrFinance.ParamByName('FlagTCta').AsInteger   := Integer(ATypeCount);
      if (qrFinance.Params.FindParam('PkTipoContas') <> nil) then
        qrFinance.ParamByName('PkTipoContas').AsInteger := Pk;
      if (qrFinance.Params.FindParam('PkContas') <> nil) then
        qrFinance.ParamByName('PkContas').AsInteger := PkAccount;
      if not qrFinance.Active then qrFinance.Open;
      while (not qrFinance.Eof) do
      begin
        if (aCta <> qrFinance.FieldByName('DSC_CTA').AsString) then
          Node := AddNode(nil);
        if (Node <> nil) then
        begin
          AddNode(Node);
          aCta := qrFinance.FieldByName('DSC_CTA').AsString;
          aDta := qrFinance.FieldByName('DTA_LAN').AsDateTime;
        end;
        qrFinance.Next;
        if (aDta = qrFinance.FieldByName('DTA_LAN').AsDateTime) and
           (Data <> nil) and (Data^.DataRow <> nil) then
          Data^.DataRow.FieldByName['SLD_LAN'].AsFloat := 0;
      end;
    finally
      if qrFinance.Active then qrFinance.Close;
      if Dados.Conexao.TransactionsSupported then
        Dados.Conexao.Commit(Dados.GetTr(Dados.FTr));
      Sender.EndUpdate;
    end;
  end;
  Sender.FullExpand;
end;

procedure TCdLancamentos.vtListInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FK_TIPO_CONTAS'].IsNull) or
     (Data^.DataRow.FieldByName['FK_TIPO_CONTAS'].AsInteger = 0) then
    Node.CheckType := ctNone
  else
    Node.CheckType := ctCheckBox;
end;

procedure TCdLancamentos.lFlag_DbCrClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (Ord(FTypeLan) <> lFLag_DbCr.ItemIndex) then
    SetFlagDbCr(TTypeLan(lFlag_DbCr.ItemIndex));
end;

procedure TCdLancamentos.eFk_ClassificacaoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aClass : TClassification;
  aColor : TColor;
  aOffSet: Integer;
  aStr   ,
  aItmStr: string;
begin
  if (Index > TComboBox(Control).Items.Count) or
     (TComboBox(Control).Items.Objects[Index] = nil) or
     (not (TComboBox(Control).Items.Objects[Index] is TClassification)) then
  begin
    TComboBox(Control).Canvas.TextOut(Rect.Left, Rect.Top,
      TComboBox(Control).Items.Strings[Index]);
    exit;
  end;
  aClass  := TClassification(TComboBox(Control).Items.Objects[Index]);
  aColor  := clGray;
  aOffSet := aClass.NivCta * 10;
  if aClass.FlagLanc then
  begin
    aColor  := clWindowText;
  end;
  with (Control as TComboBox).Canvas do
  begin
    Font.Color := aColor;
    aStr       := TComboBox(Control).Items.Strings[Index];
    aItmStr    := Copy(aStr, 1, Pos('|', aStr) - 1);
    Delete(aStr, 1, Pos('|', aStr));
    TextOut(Rect.Left + aOffSet, Rect.Top, aItmStr);
    TextOut(Rect.Left + 400, Rect.Top, aStr);
  end;
end;

procedure TCdLancamentos.eFk_ClassificacaoSelect(Sender: TObject);
var
  i: Integer;
begin
  if (Loading) then exit;
  ChangeGlobal(Sender);
  i := eFk_Classificacao.ItemIndex;
  if (i > 0) and (eFk_Classificacao.Items.Objects[i] <> nil) and
     (not TClassification(eFk_Classificacao.Items.Objects[i]).FlagLanc) then
    Dados.DisplayMessage('Atenção: Esta conta não pode ser usada para Lançamentos');
end;

procedure TCdLancamentos.ChangeScrMode(Sender: TObject; AMode: TDBMode);
begin
  eFk_Operacoes_Financeiras.Enabled := (AMode <> dbmEdit);
  lFlag_DbCr.Enabled                := (AMode <> dbmEdit);
  eFk_Cadastros.Enabled             := (AMode <> dbmEdit);
  eFk_Finalizadoras.Enabled         := (AMode <> dbmEdit) and (NumDocQuit = 0);
  eVlr_Lan.Enabled                  := (AMode <> dbmEdit);
  eJur_Lan.Enabled                  := (AMode <> dbmEdit);
  pgClassification.Enabled          := (AMode <> dbmEdit);
end;

function TCdLancamentos.GetNumDocQuit: Integer;
begin
  Result := eNum_Doc_Quit.AsInteger;
end;

procedure TCdLancamentos.SetNumDocQuit(const Value: Integer);
begin
  eNum_Doc_Quit.AsInteger := Value;
end;

end.
