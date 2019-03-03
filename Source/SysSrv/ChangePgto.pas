unit ChangePgto;

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
  Dialogs, VirtualTrees, StdCtrls, Buttons, ExtCtrls, ComCtrls, OsForms,
  TSysSrv, TSysCad, TSysSrvAux, TSysPedAux, jpeg, Mask, ToolEdit, CurrEdit,
  Placemnt;

type
  TfmChangePgtOS = class(TOSForm)
    paDetails  : TPanel;
    pgGrids: TPageControl;
    tsServiceOrder: TTabSheet;
    tsForecast: TTabSheet;
    vtSearch: TVirtualStringTree;
    pgFilters: TPageControl;
    pDecoration: TPanel;
    im: TImage;
    Label1: TLabel;
    Shape1: TShape;
    tsSearchOS: TTabSheet;
    tsFilterCounts: TTabSheet;
    stTypeOS: TStaticText;
    eTypeOS: TComboBox;
    stOwner: TStaticText;
    eFkOwners: TComboBox;
    ePkOS: TEdit;
    stPkOS: TStaticText;
    stFkRoads: TStaticText;
    eFkRoads: TComboBox;
    stStatusOS: TStaticText;
    eStatusOS: TComboBox;
    eFkPayment: TComboBox;
    lCondPgto: TStaticText;
    sbChangeAllStatus: TSpeedButton;
    cmdSearchOS: TSpeedButton;
    cbForecastCounts: TComboBox;
    stForecastCounts: TStaticText;
    cbRealCounts: TComboBox;
    stRealCounts: TStaticText;
    stStartDate: TStaticText;
    eStartDate: TDateEdit;
    eEndDate: TDateEdit;
    stEndDate: TStaticText;
    mDescription: TMemo;
    sbPreview: TSpeedButton;
    eLstPrz: TEdit;
    fsDataStore: TFormStorage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure eTypeOSChange(Sender: TObject);
    procedure cmdSearchOSClick(Sender: TObject);
    procedure vtSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtSearchInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtSearchChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure sbChangeAllStatusClick(Sender: TObject);
    procedure sbPreviewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eFkPaymentSelect(Sender: TObject);
    procedure vtSearchChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtSearchFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure pgGridsChange(Sender: TObject);
    procedure eStartDateChange(Sender: TObject);
    procedure eEndDateChange(Sender: TObject);
    procedure eLstPrzChange(Sender: TObject);
  private
    { Private declarations }
    FActivePayment: TTypePayment;
    FCheckCount   : Integer;
    FCodAut       : Integer;
    FTypeES       : TTypeES;
    FShowing      : Boolean;
    procedure LoadTypeOS;
    procedure LoadStatusOS;
    procedure LoadRoads;
    procedure LoadPayments;
    procedure LoadOwners;
    procedure SetTypeES(AValue: TTypeES);
    procedure GetServiceOrderItens(ANode: PVirtualNode; APkOS: Integer);
    procedure SetCheckCount(AValue: Integer);
    procedure ClearControls(Sender: TObject);
    procedure CheckError(Sender: TObject; AError: TCheckErrorType; var AMsg: string);
    procedure ActiveControls(AEnable: Boolean);
    procedure VerifyAndSaveOS(ACodAut: Integer);
    procedure MessagePgto(Sender: TObject; AMsg: string; AFontColor: TColor;
                AClear: Boolean = False);
    procedure SimulatorChangePeriod(Sender: TObject; const APeriodList: string);
    procedure SetTypePgto(APk: Integer);
    procedure SetTypeStatus(APk: Integer);
  protected
    { Protected declarations }
    property  TypeES    : TTypeES read FTypeES     write SetTypeES     default esSaida;
    property  CheckCount: Integer read FCheckCount write SetCheckCount default 0;
  public
    { Public declarations }
    procedure ChangeCompany(Sender: TObject; var Allowed, Reload: Boolean);
    property  ActiveCompany;
    property  PkServiceOrder;
  end;

resourcestring
  SChangeStatus = 'Troca de Status de %s para %s';
  SChangePgtos  = 'Alterada a Condição de Pagamentos de %s para %s';
  SNewPgtos     = 'Liberação da Condição de Pagamentos';

implementation

uses CmmConst, Dado, mSysSrv, SrvArqSql, DB, FuncoesDB, Funcoes, ProcType,
     GridRow, TSysMan, ProcUtils, CnsCash, SimPgto, DateUtils;

{$R *.dfm}

const
  DscrAux: array [esEntrada..esBoth] of string = ('Fornecedor', 'Cliente',
    'Fornecedor/Cliente');

procedure TfmChangePgtOS.FormCreate(Sender: TObject);
begin
  BorderStyle             := bsSizeable;
  Position                := poDesktopCenter;
  pgGrids.Images          := Dados.Image16;
  vtSearch.Images         := Dados.Image16;
  vtSearch.Header.Images  := Dados.Image16;
  pgFilters.ActivePageIndex := 0;
  inherited;
  AllowExit               := True;
  CountSearch             := 0;
  Dados.Image16.GetBitmap(35, cmdSearchOS.Glyph);
  cmdSearchOS.Down        := False;
  cmdSearchOS.Hint        := 'Pesquisar | Pesquisa o arquivo com os parâmetros informados';
  Dados.Image16.GetBitmap(56, sbChangeAllStatus.Glyph);
  Dados.Image16.GetBitmap(46, sbPreview.Glyph);
  ActiveCompany.PkCompany := Dados.PkCompany;
  ActiveCompany.DscEmp    := Dados.NameCompany;
  OnChangeCompany := ChangeCompany;
  FCheckCount := 0;
  frmContas := TfrmContas.Create(tsForecast);
  frmContas.Parent := tsForecast;
  frmContas.Align := alClient;
  frmContas.OnMessagePgto := MessagePgto;
  frmContas.Show;
  LoadTypeOS;
  LoadStatusOS;
  LoadRoads;
  LoadPayments;
  TypeES := esBoth;
  ActiveControls(True);
end;

procedure TfmChangePgtOS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ReleaseTreeNodes(vtSearch);
  ReleaseCombos(eTypeOS, toObject);
  ReleaseCombos(eStatusOS, toObject);
  ReleaseCombos(eFkRoads, toObject);
  ReleaseCombos(eFkOwners, toObject);
  ReleaseCombos(eFkPayment, toObject);
end;

procedure TfmChangePgtOS.LoadTypeOS;
begin
  ReleaseCombos(eTypeOS, toObject);
  eTypeOS.Items.AddStrings(dmSysSrv.GetTypeServiceOrder);
end;

procedure TfmChangePgtOS.LoadStatusOS;
begin
  ReleaseCombos(eStatusOS, toObject);
  eStatusOS.Items.AddStrings(dmSysSrv.GetStatusServiceOrder);
end;

procedure TfmChangePgtOS.LoadRoads;
begin
  ReleaseCombos(eFkRoads, toObject);
  eFkRoads.Items.AddStrings(dmSysSrv.GetHighWay);
end;

procedure TfmChangePgtOS.LoadPayments;
begin
  ReleaseCombos(eFkPayment, toObject);
  eFkPayment.Items.AddStrings(dmSysSrv.GetPayments);
end;

procedure TfmChangePgtOS.LoadOwners;
begin
  ReleaseCombos(eFkOwners, toObject);
  eFkOwners.Items.AddStrings(dmSysSrv.GetOwners(FTypeES));
end;

procedure TfmChangePgtOS.eTypeOSChange(Sender: TObject);
var
  Idx: Integer;
begin
  TypeES          := esBoth;
  Idx             := eTypeOS.ItemIndex;
  if (Idx > 0) and (eTypeOS.Items.Objects[Idx] <> nil) then
    TypeES        := TTypeServiceOrder(eTypeOS.Items.Objects[Idx]).FlagES;
end;

procedure TfmChangePgtOS.SetTypeES(AValue: TTypeES);
begin
  if (AValue <> FTypeES) then
  begin
    FTypeES := AValue;
    if (vtSearch.Header.Columns.Count > 2) then
      vtSearch.Header.Columns.Items[2].Text := DscrAux[FTypeES];
    LoadOwners;
  end;
end;

procedure TfmChangePgtOS.cmdSearchOSClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  cmdSearchOS.Glyph := nil;
  Dados.Image16.GetBitmap(43, cmdSearchOS.Glyph);
  cmdSearchOS.Hint    := 'Nova pesquisa | Limpa os controles para realizar uma nova pesquisa';
  cmdSearchOS.OnClick := ClearControls;
  cmdSearchOS.Repaint;
  ActiveControls(False);
  if vtSearch.RootNodeCount > 0 then
    ReleaseTreeNodes(vtSearch);
  with dmSysSrv do
  begin
    if SqlAux.Active then SqlAux.Close;
    SqlAux.SQL.Clear;
    SqlAux.SQL.Add(SqlOS);
    if (eTypeOS.ItemIndex > 0) and (eTypeOS.Items.Objects[eTypeOS.ItemIndex] <> nil) then
      SqlAux.SQL.Add(SqlAnd + 'Ors.FK_TIPO_ORDENS_SERVICOS = :FkTipoOrdensServicos ' + NL);
    if (eFkOwners.ItemIndex > 0) and (eFkOwners.Items.Objects[eFkOwners.ItemIndex] <> nil) then
      SqlAux.SQL.Add(SqlAnd + 'Ors.FK_CADASTROS = :FkCadastros ' + NL);
    if (eStatusOS.ItemIndex > 0) and (eStatusOS.Items.Objects[eStatusOS.ItemIndex] <> nil) then
      SqlAux.SQL.Add(SqlAnd + 'Ors.FK_TIPO_STATUS_OS = :FkTipoStatusOS ' + NL);
    if (eFkRoads.ItemIndex > 0) and (eFkRoads.Items.Objects[eFkRoads.ItemIndex] <> nil) then
      SqlAux.SQL.Add(SqlAnd + 'Ors.FK_RODOVIAS = :FkRodovias ' + NL)
    else
      if eFkRoads.ItemIndex = 0 then
        SqlAux.SQL.Add(SqlAnd + 'Ors.FK_RODOVIAS is null ' + NL);
    if (eFkPayment.ItemIndex > 0) and (eFkPayment.Items.Objects[eFkPayment.ItemIndex] <> nil) then
      SqlAux.SQL.Add(SqlAnd + 'Ors.FK_TIPO_PAGAMENTOS = :FkTipoPagamentos ' + NL)
    else
      if eFkPayment.ItemIndex = 0 then
        SqlAux.SQL.Add(SqlAnd + 'Ors.FK_TIPO_PAGAMENTOS is null ' + NL);
    SqlAux.SQL.Add(SqlOrderOS);
    if (SqlAux.Params.FindParam('FkEmpresas') <> nil) then
      SqlAux.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
//    if (SqlAux.Params.FindParam('FkTipoOrdensServicos') <> nil) then
//      SqlAux.Params.FindParam('FkTipoOrdensServicos').AsInteger := TTypeOrder(eTypeOS.Items.Objects[eTypeOS.ItemIndex]).PkTypeOrder;
    if (SqlAux.Params.FindParam('FkCadastros') <> nil) then
      SqlAux.ParamByName('FkCadastros').AsInteger := TOwner(eFkOwners.Items.Objects[eFkOwners.ItemIndex]).PkCadastros;
    if (SqlAux.Params.FindParam('FkTipoStatusOS') <> nil) then
      SqlAux.ParamByName('FkTipoStatusOS').AsInteger := TStatusOS(eStatusOS.Items.Objects[eStatusOS.ItemIndex]).PkStatusOS;
    if (SqlAux.Params.FindParam('FkRodovias') <> nil) then
      SqlAux.ParamByName('FkRodovias').AsInteger := TRodovias(eFkRoads.Items.Objects[eFkRoads.ItemIndex]).PkRodovias;
    if (SqlAux.Params.FindParam('FkTipoPagamentos') <> nil) then
      SqlAux.ParamByName('FkTipoPagamentos').AsInteger := TTypePayment(eFkPayment.Items.Objects[eFkPayment.ItemIndex]).PkTypePgto;
    if not SqlAux.Active then SqlAux.Open;
    vtSearch.NodeDataSize := SizeOf(TGridData);
    vtSearch.BeginUpdate;
    try
      if not SqlAux.IsEmpty then
      begin
        SqlAux.First;
        while not SqlAux.Eof do
        begin
          Node := vtSearch.AddChild(nil);
          if Node <> nil then
          begin
            Data           := vtSearch.GetNodeData(Node);
            Data^.Level    := vtSearch.GetNodeLevel(Node);
            Data^.Node     := Node;
            Data^.DataRow  := TDataRow.CreateFromDataSet(nil, SqlAux, True);
            GetServiceOrderItens(Node, SqlAux.FindField('PK_ORDENS_SERVICOS').AsInteger);
          end;
          SqlAux.Next;
        end;
      end
      else
        Application.MessageBox(PAnsiChar('Busca OS: Nenhum Documento Encontrado'),
          PAnsiChar(Application.Name), MB_ICONWARNING + MB_OK);
    finally
      vtSearch.EndUpdate;
      CountSearch := vtSearch.RootNodeCount;
      if SqlAux.Active then SqlAux.Close;
    end;
  end;
end;

procedure TfmChangePgtOS.GetServiceOrderItens(ANode: PVirtualNode; APkOS: Integer);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (ANode = nil) or (APkOS <= 0) then exit;
  with dmSysSrv do
  begin
    if SqlKey.Active then SqlKey.Close;
    SqlKey.SQL.Clear;
    SqlKey.SQL.Add(SqlOSItens);
    try
      if (SqlKey.Params.FindParam('FkEmpresas') <> nil) then
        SqlKey.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
      if (SqlKey.Params.FindParam('FkOrdensServicos') <> nil) then
        SqlKey.Params.FindParam('FkOrdensServicos').AsInteger := APkOS;
      if not SqlKey.Active then SqlKey.Open;
      if not SqlKey.IsEmpty then
      begin
        SqlKey.First;
        while not SqlKey.Eof do
        begin
          Node := vtSearch.AddChild(ANode);
          if Node <> nil then
          begin
            Data           := vtSearch.GetNodeData(Node);
            Data^.Level    := vtSearch.GetNodeLevel(Node);
            Data^.Node     := Node;
            Data^.DataRow  := TDataRow.CreateFromDataSet(nil, SqlKey, True);
          end;
          SqlKey.Next;
        end;
      end;
    finally
      if SqlKey.Active then SqlKey.Close;
    end;
  end;
end;

procedure TfmChangePgtOS.vtSearchGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data     := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Sender.GetNodeLevel(Node) = 0 then
    case Column of
      0: CellText := Data^.DataRow.FieldByName['PK_ORDENS_SERVICOS'].AsString;
      1: CellText := Data^.DataRow.FieldByName['DTA_OS'].AsString;
      2: CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
      3: CellText := Data^.DataRow.FieldByName['DSC_ORD'].AsString;
      4: CellText := Data^.DataRow.FieldByName['DSC_STT'].AsString;
      5: begin
           CellText := Data^.DataRow.FieldByName['DSC_TPG'].AsString;
           if Data^.DataRow.FieldByName['LST_PRZ'].AsString <> '' then
             CellText := CellText + ' ==> ' + Data^.DataRow.FieldByName['LST_PRZ'].AsString;
         end;
      6: CellText := Data^.DataRow.FieldByName['TOT_ORD'].AsString;
    end
  else
    case Column of
      0: CellText := Data^.DataRow.FieldByName['PK_ORDENS_SERVICOS_ITENS'].AsString;
      1: CellText := ' ';
      2: CellText := Data^.DataRow.FieldByName['DSC_QTD'].AsString;
      3: CellText := Data^.DataRow.FieldByName['DSC_PROD'].AsString;
      4: CellText := Data^.DataRow.FieldByName['DSC_FAT'].AsString;
      5: CellText := ' ';
      6: CellText := Data^.DataRow.FieldByName['TOT_SRV'].AsString;
    end;
end;

procedure TfmChangePgtOS.vtSearchInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
  if Node = nil then exit;
  if (vtSearch.GetNodeLevel(Node) = 0) then
  begin
    Node.CheckType  := ctCheckBox;
    Node.CheckState := csUncheckedNormal;
  end
  else
    Node.CheckType := ctNone;
end;

procedure TfmChangePgtOS.SetCheckCount(AValue: Integer);
begin
  FCheckCount := AValue;
  if FCheckCount < 0 then
    FCheckCount := 0;
  sbChangeAllStatus.Enabled := (FCheckCount > 0);
  eStatusOS.Enabled         := (FCheckCount = 0);
end;

procedure TfmChangePgtOS.vtSearchChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Allowed := (vtSearch.GetNodeLevel(Node) = 0);
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Allowed := (eStatusOS.ItemIndex > 0) and (eStatusOS.Items.Objects[eStatusOS.ItemIndex] <> nil);
  if (not Allowed) then exit;
  Allowed := ((Data^.DataRow.FindField['FK_TIPO_STATUS_OS'] <> nil) or
    (Data^.DataRow.FieldByName['FK_TIPO_STATUS_OS'].AsInteger <>
      TStatusOS(eStatusOS.Items[eStatusOS.ItemIndex]).PkStatusOS));
end;

procedure TfmChangePgtOS.sbChangeAllStatusClick(Sender: TObject);
begin
  if (Assigned(frmPgtos)) and (frmPgtos.Visible) then frmPgtos.Close;
  VerifyAndSaveOS(-1);
  eLstPrz.Text := '';
  if (not eFkPayment.Visible) then eFkPayment.Visible := True;
  eFkPayment.ItemIndex := 0;
  eStatusOS.ItemIndex  := 0;
end;

procedure TfmChangePgtOS.VerifyAndSaveOS(ACodAut: Integer);
var
  Node      : PVirtualNode;
  Data      : PGridData;
  AHist     : THistoric;
  aStatus   : TStatusOS;
  aPayment  : TTypePayment;
//  aBaseDate : TDate;
  aSavePgtos: Boolean;
begin
  if (ActiveOS = nil) then exit;
  Node       := vtSearch.GetFirst;
  aStatus    := nil;
  aPayment   := nil;
  aSavePgtos := False;
  if (eStatusOS.ItemIndex > 0) then
    aStatus  := TStatusOS(eStatusOS.Items.Objects[eStatusOS.ItemIndex]);
  if (eFkPayment.ItemIndex > 0) then
    aPayment := TTypePayment(eFkPayment.Items.Objects[eFkPayment.ItemIndex]);
  if (aStatus = nil) and (aPayment = nil) then
  begin
    Dados.DisplayHint(sbChangeAllStatus, 'Não há alterações a selecionadas',
      hiError, 'Liberação de Ordens de Serviços');
    exit;
  end;
  while (Node <> nil) do
  begin
    if (Node.CheckState = csCheckedNormal) then
    begin
      Data := vtSearch.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (Data^.DataRow.FindField['PK_ORDENS_SERVICOS'] <> nil) and
         (Data^.DataRow.FieldByName['PK_ORDENS_SERVICOS'].AsInteger > 0) then
      begin
        PkServiceOrder := Data^.DataRow.FieldByName['PK_ORDENS_SERVICOS'].AsInteger;
        ActiveOS.OnCheckError := CheckError;
        ActiveOS.FkEmpresas   := ActiveCompany;
        if (aStatus <> nil) and
           (ActiveOS.FkStatusOS.PkStatusOS <> aStatus.PkStatusOS) then
        begin
          aHist              := ActiveOS.Historics.Add;
          aHist.HistoricType := htStatus;
          aHist.DtHrHist     := Now;
          aHist.DscCad       := Dados.Parametros.soUser;
          aHist.CodAut       := FCodAut;
          aHist.FkStatusOS   := aStatus;
          aHist.DscHist      := Format(SChangeStatus,
            [ActiveOS.FkStatusOS.DscStt, aStatus.DscStt]);
          ActiveOS.FKStatusOS   := aStatus;
          Data^.DataRow.FieldByName['FK_TIPO_STATUS_OS'].AsInteger := aStatus.PkStatusOS;
          Data^.DataRow.FieldByName['DSC_STT'].AsString := aStatus.DscStt;
        end;
{        if (aPayment <> nil) and
           ((ActiveOS.FkPayment.PkTypePgto <> aPayment.PkTypePgto) or
           (ActiveOS.FkPayment.LstPrz <> eLstPrz.Text))  then
        begin
          if (aPayment.FlagSen) and Assigned(frmPgtos) and
             (frmPgtos.Modified) then
          begin
            FCodAut          := Dados.PegaAutoriza('Para modificar este tipo ' +
              'de condição de pagamentos é necessário autorização');
            if (FCodAut = 0) then
              raise Exception.Create('Erro: Opearação não autorizada');
            aHist              := ActiveOS.Historics.Add;
            aHist.HistoricType := htAutorization;
            aHist.DtHrHist     := Now;
            aHist.DscCad       := Dados.Parametros.Operator;
            aHist.CodAut       := FCodAut;
            aHist.FkStatusOS   := aStatus;
            aHist.DscHist      := 'Autorização da alteração na cond. pgto. gerada';
          end;
          aHist              := ActiveOS.Historics.Add;
          aHist.HistoricType := htNone;
          aHist.DtHrHist     := Now;
          aHist.DscCad       := Dados.Parametros.Operator;
          aHist.CodAut       := FCodAut;
          aHist.FkStatusOS   := aStatus;
          if ActiveOS.FkPayment.PkTypePgto > 0 then
            aHist.DscHist    := Format(SChangePgtos,
              [ActiveOS.FkStatusOS.DscStt, aStatus.DscStt])
          else
            aHist.DscHist    := SNewPgtos;
          ActiveOS.FkPayment := aPayment;
          if aPayment.FlagUser then
            ActiveOS.FkPayment.LstPrz := eLstPrz.Text
          else
            ActiveOS.FkPayment.LstPrz := '';
          ActiveOS.LstPrz := ActiveOS.FkPayment.LstPrz;
          Data^.DataRow.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger := aPayment.PkTypePgto;
          Data^.DataRow.FieldByName['DSC_TPG'].AsString := aPayment.DscTPgt;
          Data^.DataRow.FieldByName['LST_PRZ'].AsString := eLstPrz.Text;
          case ActiveOS.FkPayment.FlagBaseDate of
            bdOrder   : aBaseDate := ActiveOS.DtaOS;
            bdInvoice : aBaseDate := ActiveOS.DtaFin;
            bdDelivery: aBaseDate := ActiveOS.DtaFin;
          else
            aBaseDate := ActiveOS.DtaOS;
          end;
          ActiveOS.DtaLibFin := Date;
          if Assigned(frmPgtos) and (frmPgtos.eDtaBase.Date <> aBaseDate) then
            ActiveOS.FkPayment.CreatePayments(ActiveOS.TotOS, frmPgtos.eDtaBase.Date)
          else
            ActiveOS.FkPayment.CreatePayments(ActiveOS.TotOS, aBaseDate);
          aSavePgtos := True;
        end;}
        if ActiveOS.CheckRules(True) then
        begin
          dmSysSrv.MoveObject2Data(ActiveOS, dbmEdit);
          if ActiveOS.FkPayment.PkTypePgto = 0 then
            Dados.DisplayHint(eFkPayment, 'Não há tipo de pagamento ativo na OS',
              hiError, 'Tipo de Pagamentos')
          else
            if aSavePgtos then
              dmSysSrv.SaveInstallments(ActiveOS)
            else
              Dados.DisplayHint(eFkPayment, 'Ordens de Serviços sem liberação financeira',
                 hiError, 'Liberação das Ordens de Serviços');
          sbChangeAllStatus.Enabled := False;
        end;
      end;
    end;
    Node := vtSearch.GetNext(Node);
  end;
end;

procedure TfmChangePgtOS.ChangeCompany(Sender: TObject; var Allowed, Reload: Boolean);
begin
  if (vtSearch.RootNodeCount > 0) then
  begin
    Allowed := (Application.MessageBox(PAnsiChar('Atenção: A seleção de nova ' +
      'empresa exige nova pesquisa. Deseja continuar'),
      PAnsiChar(Application.Title), MB_ICONQUESTION + MB_YESNO) = mrYes);
    if Allowed then
      ClearControls(self);
  end;
end;

procedure TfmChangePgtOS.ClearControls(Sender: TObject);
begin
  cmdSearchOS.Glyph := nil;
  Dados.Image16.GetBitmap(35, cmdSearchOS.Glyph);
  cmdSearchOS.Hint := 'Pesquisar | Pesquisa o arquivo com os parâmetros informados';
  cmdSearchOS.OnClick := cmdSearchOSClick;
  cmdSearchOS.Repaint;
  ActiveControls(True);
  ReleaseTreeNodes(vtSearch);
  CheckCount := 0;
  ReleaseCombos(eFkOwners, toObject);
  ePkOS.Text           := '';
  eTypeOS.ItemIndex    := -1;
  eStatusOS.ItemIndex  := -1;
  eFkRoads.ItemIndex   := -1;
  eFkPayment.ItemIndex := -1;
  eFkPayment.Visible   := True;
  if Assigned(frmPgtos) and (frmPgtos.Visible) then frmPgtos.Close;
  sbPreview.Enabled    := False;
end;

procedure TfmChangePgtOS.CheckError(Sender: TObject; AError: TCheckErrorType;
  var AMsg: string);
const
  Msg: array [ceNullDtaOS..ceNullTotal] of string =
    ('Erro: Falta a Data da Ordem de Serviços',
     'Erro: Data Inicial da Ordem de Servicos Inválida',
     'Erro: Data Final da Ordem de Servicos Inválida',
     'Erro: Falta o emitente da Ordem de Serviços',
     'Erro: Falta a Empresa da Ordem de Serviços',
     'Erro: Falta Condição de Pagamentos da Ordem de Serviços',
     'Erro: Falta o Status da Ordem de Serviços',
     'Erro: Falta a Data de Finalização da Ordem de Serviços',
     'Erro: Falta a Data de Cancelamento da Ordem de Serviços',
     'Erro: Falta a Data de Bloqueio da Ordem de Serviços',
     'Erro: Falta a Data de Aprovação da Ordem de Serviços',
     'Erro: Autorização negada para este status',
     'Erro: Falta o Tipo da Ordem de Serviços',
     'Erro: Falta o número da Ordem de Serviços',
     'Erro: Não posso usar o status escolhido nesta Ordem de Serviços',
     'Erro: Ordem de Serviços deve ter pelo menos um serviço descriminado',
     'Erro: Total da Ordem de Serviços = 0 ou nulo');
begin
  AMsg := Msg[AError];
end;

procedure TfmChangePgtOS.ActiveControls(AEnable: Boolean);
begin
  ePkOS.Enabled     := AEnable;
  eTypeOS.Enabled   := AEnable;
  eFkOwners.Enabled := AEnable;
  eFkRoads.Enabled  := AEnable;
end;

procedure TfmChangePgtOS.sbPreviewClick(Sender: TObject);
begin
  if (ActiveOS.PkOS = 0) then
  begin
    Dados.DisplayHint(vtSearch, 'Para visualizar as parcelas deve selecionar ' +
      'uma Ordem de Serviços', hiInformation, 'Vizualização de Parcelas');
    exit;
  end;
  if (FActivePayment = nil) then
  begin
    Dados.DisplayHint(eFkPayment, 'Para visualizar as parcelas deve selecionar ' +
      'uma Condição de Pagamento', hiInformation, 'Vizualização de Parcelas');
    exit;
  end;
  ActiveOS.FkPayment := FActivePayment;
  if Assigned(frmPgtos) and (frmPgtos.Visible) then
  begin
    frmPgtos.Free;
    frmPgtos  := nil;
    exit;
  end;
  frmPgtos               := TfrmPgtos.Create(paDetails);
//  frmPgtos.OnChangeDate   := SimulatorChangeDate; Reserved for future use
  frmPgtos.OnChangePeriod := SimulatorChangePeriod;
  frmPgtos.BorderStyle    := bsNone;
  frmPgtos.Parent         := paDetails;
  frmPgtos.Align          := alLeft;
  frmPgtos.Top            := Top;
  frmPgtos.Left           := Left;
  frmPgtos.ActiveOS       := ActiveOS;
  frmPgtos.ActiveOS.FkPayment := FActivePayment;
  frmPgtos.Show;
end;

procedure TfmChangePgtOS.FormDestroy(Sender: TObject);
begin
  FActivePayment := nil;
  if Assigned(frmContas) then
    frmContas.Free;
  if Assigned(frmPgtos) then
    frmPgtos.Free;
  frmContas := nil;
  frmPgtos  := nil;
  inherited;
end;

procedure TfmChangePgtOS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  KeyPress: Word;
begin
  if Key in [VK_ESCAPE, VK_F3, VK_F5, VK_F10] then
  begin
    KeyPress := Key;
    Key := 0;
    case KeyPress of
      VK_ESCAPE: Close;
      VK_F3    : eFkPayment.Visible := not eFkPayment.Visible;
      VK_F5    : cmdSearchOS.Click;
      VK_F10   : sbChangeAllStatus.Click;
    end;
  end;
end;

procedure TfmChangePgtOS.eFkPaymentSelect(Sender: TObject);
var
  i: Integer;
begin
  i := eFkPayment.ItemIndex;
  if (i > 0) then
    FActivePayment := TTypePayment(eFkPayment.Items.Objects[i])
  else
    FActivePayment := nil;
  if (vtSearch.RootNodeCount > 0) and (ActiveOS.PkOS > 0) then
  begin
    sbPreview.Enabled := (vtSearch.RootNodeCount > 0) and (FActivePayment <> nil);
    if (ActiveOS.FkPayment <> nil) and (ActiveOS.FkPayment.PkTypePgto > 0) and
       (Dados.DisplayMessage('A Ordem de Serviços Selecionada já contém uma ' +
          'Condição de Pagamentos ativa. Deseja substituí-la?', hiWarning,
          [mbYes, mbNo]) = mrNo) then
    begin
      eFkPayment.ItemIndex := 0;
      exit;
    end;
    ActiveOS.FkPayment := FActivePayment;
    if Assigned(frmPgtos) then
    begin
       frmPgtos.ActiveOS.FkPayment.CreatePayments(frmPgtos.ActiveOS.TotOS,
         frmPgtos.ActiveOS.DtaFin);
       frmPgtos.ShowPayments;
    end;
  end;
end;

procedure TfmChangePgtOS.vtSearchChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if (Node = nil) then exit;
  if (Node.CheckState = csCheckedNormal) then
    Inc(FCheckCount);
  if (Node.CheckState = csUnCheckedNormal) then
    Dec(FCheckCount);
  if (FCheckCount < 0) then FCheckCount := 0;
  sbChangeAllStatus.Enabled := (FCheckCount > 0);
  if (not eFkPayment.Visible) then
    eFkPayment.Visible := True;
end;

procedure TfmChangePgtOS.vtSearchFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  FShowing := True;
  if (Node = nil) or (vtSearch.GetNodeLevel(Node) > 0) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data <> nil) and (Data^.DataRow <> nil) and
     (Data^.DataRow.FindField['PK_ORDENS_SERVICOS'] <> nil) then
  begin
    PkServiceOrder    := Data^.DataRow.FieldByName['PK_ORDENS_SERVICOS'].AsInteger;
    if ActiveOS.FkStatusOS.DscStt = '' then
      ActiveOS.FkStatusOS.DscStt := Data^.DataRow.FieldByName['DSC_STT'].AsString;
    if Data^.DataRow.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger > 0 then
    begin
      SetTypePgto(Data^.DataRow.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger);
      eLstPrz.Text := Data^.DataRow.FieldByName['LST_PRZ'].AsString;
    end
    else
    begin
      eLstPrz.Text := '';
      eFkPayment.Visible := True;
      eFkPayment.ItemIndex := 0;
    end;
    if Data^.DataRow.FieldByName['FK_TIPO_STATUS_OS'].AsInteger > 0 then
      SetTypeStatus(Data^.DataRow.FieldByName['FK_TIPO_STATUS_OS'].AsInteger);
  end;
  FShowing := False;
end;

procedure TfmChangePgtOS.pgGridsChange(Sender: TObject);
begin
  pgFilters.ActivePageIndex := pgGrids.ActivePageIndex;
  if Assigned(frmContas) then
  begin
    if (eStartDate.Date = 0) then
      eStartDate.Date := Date - 3;
    if (eEndDate.Date = 0) then
      eEndDate.Date := IncDay(Date, 7);
    frmContas.TestGrids;
  end;
end;

procedure TfmChangePgtOS.eStartDateChange(Sender: TObject);
begin
  if Assigned(frmContas) then
    frmContas.StartBaseDate := eStartDate.Date;
end;

procedure TfmChangePgtOS.eEndDateChange(Sender: TObject);
begin
  if Assigned(frmContas) then
    frmContas.EndBaseDate := eEndDate.Date;
end;

procedure TfmChangePgtOS.MessagePgto(Sender: TObject; AMsg: string;
            AFontColor: TColor; AClear: Boolean = False);
begin
  if AClear then mDescription.Lines.Clear;
  mDescription.Font.Color := AFontColor;
  mDescription.Lines.Add(AMsg);
end;

procedure TfmChangePgtOS.SimulatorChangePeriod(Sender: TObject; const APeriodList: string);
begin
  eLstPrz.Text := APeriodList;
end;

procedure TfmChangePgtOS.SetTypePgto(APk: Integer);
var
  i: Integer;
  aObj: TTypePayment;
begin
  if eFkPayment.Items.Count = 0 then exit;
  for i := 0 to eFkPayment.Items.Count - 1 do
  begin
    aObj := TTypePayment(eFkPayment.Items.Objects[i]);
    if (aObj <> nil) and (APk = aObj.PkTypePgto) then
    begin
      eFkPayment.ItemIndex := i;
//      eFkPayment.Visible := not aObj.FlagUser;
      break;
    end;
  end;
end;

procedure TfmChangePgtOS.SetTypeStatus(APk: Integer);
var
  i: Integer;
  aObj: TStatusOS;
begin
  if eStatusOS.Items.Count = 0 then exit;
  for i := 0 to eStatusOS.Items.Count - 1 do
  begin
    aObj := TStatusOS(eStatusOS.Items.Objects[i]);
    if (aObj <> nil) and (APk = aObj.PkStatusOS) then
    begin
      eStatusOS.ItemIndex := i;
      break;
    end;
  end;
end;

procedure TfmChangePgtOS.eLstPrzChange(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if FShowing then exit;
//  if (FActivePayment = nil) or (not FActivePayment.FlagUser) then
//    eLstPrz.Text := '';
  Node := vtSearch.FocusedNode;
  if Node = nil then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
//  Data^.DataRow.FieldByName['LST_PRZ'].AsString := eLstPrz.Text;
  vtSearch.Refresh;
end;

initialization
  RegisterCLass(TfmChangePgtOS);

end.
