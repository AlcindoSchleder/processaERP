unit EditOS;

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
  Dialogs, StdCtrls, Mask, ToolEdit, jpeg, ExtCtrls, VirtualTrees, ProcType,
  ComCtrls, ToolWin, TSysSrv, TSysSrvAux, Menus, OsForms, GridRow, TSysCad,
  TSysPedAux, ProcUtils, Buttons, CurrEdit;

type
  TGridType = (gtHistorics, gtItems, gtInsumos);

  TfmEditOS = class(TOSForm)
    pmItems: TPopupMenu;
    pmInsert: TMenuItem;
    pmEdit: TMenuItem;
    pmDelete: TMenuItem;
    pmView: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    pmCopy: TMenuItem;
    pgOS: TPageControl;
    tsOS: TTabSheet;
    tsHistorics: TTabSheet;
    paDetails: TPanel;
    Shape1: TShape;
    im: TImage;
    sTitle: TShape;
    lTitle: TLabel;
    ldbMode: TLabel;
    cbControlBar: TControlBar;
    tbToolBar: TToolBar;
    tbNew: TToolButton;
    tbCancel: TToolButton;
    tSep1: TToolButton;
    tbPrior: TToolButton;
    tbNext: TToolButton;
    tSep2: TToolButton;
    tbSave: TToolButton;
    ePk_Ordens_Servicos: TEdit;
    lPk_Ordens_Servicos: TStaticText;
    lFk_Tipo_Ordens_Servicos: TStaticText;
    lFk_Cadastros: TStaticText;
    lDta_OS: TStaticText;
    eFk_Cadastros: TComboBox;
    lFk_Status_OS: TStaticText;
    eFk_Status_OS: TComboBox;
    eDta_OS: TDateEdit;
    eFk_Tipo_Ordens_Servicos: TComboBox;
    pgComplement: TPageControl;
    tsBasicData: TTabSheet;
    lDsc_Ord: TStaticText;
    eDsc_Ord: TEdit;
    lFk_Tipo_Pagamentos: TStaticText;
    eDscPgto: TEdit;
    tsMetrics: TTabSheet;
    lFk_Rodovias: TStaticText;
    eFk_Rodovias: TComboBox;
    tsFix: TTabSheet;
    lTot_Ord: TStaticText;
    eTot_Ord: TEdit;
    vtItems: TVirtualStringTree;
    vtHistorics: TVirtualStringTree;
    sDividor: TSplitter;
    tsDatas: TTabSheet;
    eDta_Ini: TDateEdit;
    lDta_Ini: TStaticText;
    eDta_Fin: TDateEdit;
    lDta_Fin: TStaticText;
    lDta_Canc: TStaticText;
    eDta_Canc: TDateEdit;
    lDta_Liq: TStaticText;
    eDta_Liq: TDateEdit;
    lDta_Blq: TStaticText;
    eDta_Blq: TDateEdit;
    eDta_Aprv: TDateEdit;
    lDta_Aprv: TStaticText;
    pHitoric: TPanel;
    stTitle: TStaticText;
    pVinculo: TPanel;
    pItem: TPanel;
    tsVincTitle: TStaticText;
    sbSave: TSpeedButton;
    pDataHist: TPanel;
    pDscHist: TPanel;
    lDsc_Hist: TStaticText;
    eDsc_Hist: TEdit;
    lbMessage: TListBox;
    sbInsert: TSpeedButton;
    eItemVinc: TCurrencyEdit;
    stStatus: TStaticText;
    pgItems: TPageControl;
    tsServices: TTabSheet;
    tsInsumos: TTabSheet;
    vtProducts: TVirtualStringTree;
    vtInsumos: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eFk_Tipo_Ordens_ServicosChange(Sender: TObject);
    procedure eFk_CadastrosChange(Sender: TObject);
    procedure eFk_Status_OSChange(Sender: TObject);
    procedure eFk_RodoviasChange(Sender: TObject);
    procedure tbNewClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure vtItemsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtItemsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure tbSaveClick(Sender: TObject);
    procedure vtItemsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tbPriorClick(Sender: TObject);
    procedure tbNextClick(Sender: TObject);
    procedure pmInsertClick(Sender: TObject);
    procedure pmEditClick(Sender: TObject);
    procedure pmDeleteClick(Sender: TObject);
    procedure pmViewClick(Sender: TObject);
    procedure vtItemsEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure pmCopyClick(Sender: TObject);
    procedure pgOSChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pgOSChange(Sender: TObject);
    procedure vtHistoricsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure eDta_IniChange(Sender: TObject);
    procedure eDta_FinChange(Sender: TObject);
    procedure vtItemsDblClick(Sender: TObject);
    procedure lTitleClick(Sender: TObject);
    procedure eDsc_OrdChange(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure sbInsertClick(Sender: TObject);
    procedure vtProductsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtProductsChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure eDsc_HistChange(Sender: TObject);
    procedure vtHistoricsChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtHistoricsFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtHistoricsFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure eItemVincChange(Sender: TObject);
    procedure pgItemsChanging(Sender: TObject; var AllowChange: Boolean);
    procedure vtInsumosChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
  private
    { Private declarations }
    FActiveControls: Boolean;
    FDefTypeOS     : Integer;
    FDefStatusOS   : Integer;
    FFlagEdtValAbrt: Boolean;
    FFlagEdtComp   : Boolean;
    FFlagEdtSrv    : Boolean;
    FItemIndex     : Integer;
    FScrollOS      : TScrollOrderService;
    FServiceOrder  : TServiceOrder;
    FTypeES        : TTypeES;
    FTypeUse       : TTypeUse;
    FDebug         : Boolean;
    // Load Data from DB
    procedure LoadTypeOS;
    procedure LoadStatusOS;
    procedure LoadRoads;
    procedure LoadOwners;
    procedure LoadServiceOrderItems;
    procedure LoadServiceOrderInsumos(ANode: PVirtualNode; const AItx, AInx: Integer);
    procedure LoadDefaults;
    procedure SetTypeES (AValue: TTypeES);
    procedure SetTypeUse(AValue: TTypeUse);
    function  ShowItems(AMode: TdbMode; AEntryData: TEntryData): Boolean;
    procedure ReleaseData(Data: TGridData);
    // Events Handle
    procedure AutorizationStatusChange(Sender: TObject; const AStatus: TStatusOS;
                var ACodAut: Integer);
    procedure ChangeAuthentication(Sender: TObject; const Value: Integer;
                var Allowed: Boolean);
    procedure CheckError(Sender: TObject; AError: TCheckErrorType; var AMsg: string);
    function  GetEntryData: TEntryData;
    function  GetDataFromItem(AItem: TServiceOrderItem): TDataRow;
    function  GetDataFromInsumoItem(AInsumo: TInsumo): TDataRow;
    procedure ChangeMode(Sender: TObject);
    procedure ChangePKOS(Sender: TObject);
    procedure CloseItemsForm(Sender: TObject);
    procedure PopulateGridFromObject;
    procedure SetActiveControls(AValue: Boolean);
    function  GetDataToGrid(Sender: TVirtualStringTree;
                GridType: TGridType; AIdx, AInx: Integer;
                NewNode: Boolean = True): PVirtualNode;
    function  CreateHistData(AItem: THistoric): TDataRow;
    function  CreateItemData(const AIdx: Integer; const ADsc: string;
                GridType: TGridType): TDataRow;
    procedure SetServiceOrder(AValue: TServiceOrder);
    procedure ChangeCompany(Sender: TObject; var Allowed, Reload: Boolean);
    procedure DisplayHistoric(AHistoric: THistoric);
  protected
    { Protected declarations }
    function  VerifyStatus: Boolean;
    procedure OnItem(AItem: TServiceOrderItem; const AChildItem: Integer;
                const AMode: TDBMode);
    property  ServiceOrder: TServiceOrder read FServiceOrder write SetServiceOrder;
    property  TypeES      : TTypeES       read FTypeES       write SetTypeES     default esSaida;
    property  TypeUse     : TTypeUse      read FTypeUse      write SetTypeUse    default tuMetric;
  public
    { Public declarations }
    // Screen Controls
    procedure ClearControls;
    procedure DisplayObject(Sender: TObject);
    property  ActiveCompany;
    property  dbMode;
    property  PkServiceOrder;
    property  ScrollOS      : TScrollOrderService read FScrollOS       write FScrollOS;
    property  ActiveControls: Boolean             read FActiveControls write SetActiveControls;
  end;

implementation

uses Dado, SearchOS, mSysSrv, Funcoes, SrvArqSql, FuncoesDB, DB, ItemOS, Math;

{$R *.dfm}

const
  DscrAux: array [esEntrada..esBoth] of string = ('Fornecedor', 'Cliente',
    'Fornecedor/Cliente');

procedure TfmEditOS.FormCreate(Sender: TObject);
var
  i    : Integer;
  aForm: TForm;
begin
  FServiceOrder         := TServiceOrder.Create(Self);
  FDebug                := False;
  FTypeUse              := tuNone;
  pgOS.ActivePageIndex  := 0;
  pgOS.Images           := Dados.Image16;
  tbToolBar.Images      := Dados.Image16;
  vtItems.Images        := Dados.Image16;
  vtItems.Header.Images := Dados.Image16;
  pgComplement.Images   := Dados.Image16;
  inherited;
  // Initilize Local variables
  ActiveControls        := True;
  OnChangeCompany       := ChangeCompany;
  OnChangePKOS          := ChangePKOS;
  OnChangeMode          := ChangeMode;
  vtItems.NodeDataSize  := SizeOf(TGridData);
  DbMode                := dbmBrowse;
  FTypeES               := esBoth;
  // Set Events to buttons Prior and Next
  aForm                 := nil;
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i].InheritsFrom(TfmSearchOS) then
      aForm := Screen.Forms[i];
  if (aForm <> nil) and (aForm is TfmSearchOS) then
    FScrollOS := nil;  //TfmSearchOS(aForm).ScrollOS;
  CountSearch := 0;
  FItemIndex := 0;
// Load all Combos data that are not has dependences of other changes
  LoadTypeOS;
  LoadStatusOS;
  LoadRoads;
  LoadDefaults;
  // Clear all Screen Controls
  ClearControls;
  ServiceOrder.OnChangeAuth   := ChangeAuthentication;
  ServiceOrder.OnAutorization := AutorizationStatusChange;
end;

procedure TfmEditOS.FormDestroy(Sender: TObject);
begin
  if Assigned(frmItemOS) then
    frmItemOS.Free;
  if Assigned(FServiceOrder) then
    FServiceOrder.Free;
  FServiceOrder   := nil;
  frmItemOS       := nil;
  FScrollOS       := nil;
  ReleaseTreeNodes(vtItems);
  inherited;
end;

procedure TfmEditOS.ChangeCompany(Sender: TObject; var Allowed, Reload: Boolean);
var
  aModify: Boolean;
begin
  aModify := False;
  if (dbMode in UPDATE_MODE) then
  begin
    aModify := True;
    Reload := Application.MessageBox(PAnsiChar('Atenção: Estou no modo ' +
      'de edição ao trocar a empresa você peerderá todas as alterações. ' + NL +
      'Deseja Continuar?'), PAnsiChar(Application.Title),
      MB_ICONWARNING + MB_YESNO) = mrYes;
  end;
  if (not Reload) and (ActiveOS.PkOS > 0) then
  begin
    aModify := True;
    Reload := Application.MessageBox(PAnsiChar('Atenção: Existe uma OS carregada ' +
      'ao trocar a empresa o sistema irá recarregar uma OS de mesma numeração ' +
      'com a nova empresa. ' + NL + 'Deseja Continuar?'), PAnsiChar(Application.Title),
      MB_ICONWARNING + MB_YESNO) = mrYes;
  end;
  if (aModify) then
    Allowed := Reload
  else
    Allowed := True;
  if Allowed then
  begin
    ClearControls;
    inherited;
    LoadDefaults;
  end;
end;

procedure TfmEditOS.LoadTypeOS;
begin
  ReleaseCombos(eFk_Tipo_Ordens_Servicos, toObject);
  eFk_Tipo_Ordens_Servicos.Items.AddStrings(dmSysSrv.GetTypeServiceOrder);
end;

procedure TfmEditOS.LoadStatusOS;
begin
  ReleaseCombos(eFk_Status_OS, toObject);
  eFk_Status_OS.Items.AddStrings(dmSysSrv.GetStatusServiceOrder);
end;

procedure TfmEditOS.LoadRoads;
begin
  ReleaseCombos(eFk_Rodovias, toObject);
  eFk_Rodovias.Items.AddStrings(dmSysSrv.GetHighWay);
end;

procedure TfmEditOS.LoadOwners;
begin
  ReleaseCombos(eFk_Cadastros, toObject);
  eFk_Cadastros.Items.AddStrings(dmSysSrv.GetOwners(FTypeES));
end;

procedure TfmEditOS.LoadDefaults;
begin
  with dmSysSrv do
  begin
    if (Parametros.Active) then Parametros.Close;
    Parametros.SQL.Clear;
    Parametros.SQL.Add(SqlParametrosSrv);
    Parametros.Params.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    Parametros.Open;
    try
      if (not Parametros.IsEmpty) then
      begin
        FDefTypeOS      := Parametros.FieldByName('FK_TIPO_ORDENS_SERVICOS').AsInteger;
        FDefStatusOS    := Parametros.FieldByName('FK_TIPO_STATUS_OS').AsInteger;
        FFlagEdtValAbrt := Boolean(Parametros.FieldByName('FLAG_EDTVAL_ABRT').AsInteger);
        FFlagEdtComp    := Boolean(Parametros.FieldByName('FLAG_EDTCOMP').AsInteger);
        FFlagEdtSrv     := Boolean(Parametros.FieldByName('FLAG_EDTSRV').AsInteger);
      end;
    finally
      if (dmSysSrv.Parametros.Active) then Parametros.Close;
    end;
  end;
end;

procedure TfmEditOS.ClearControls;
begin
  if (DBMode in SCROLL_MODE) then
    DBMode := dbmExecute;
  eFk_Tipo_Ordens_Servicos.ItemIndex := 0;
  ePk_Ordens_Servicos.Text           := '0';
  eDta_OS.Clear;
  if eFk_Cadastros.Items.Count > 0 then
    eFk_Cadastros.ItemIndex          := 0
  else
    eFk_Cadastros.ItemIndex          := -1;
  eFk_Status_OS.ItemIndex            := 0;
  eDsc_Ord.Text                      := '';
  eDscPgto.Text                      := '';
  eFk_Rodovias.ItemIndex             := 0;
  if vtItems.RootNodeCount > 0 then
    ReleaseTreeNodes(vtItems);
  if (DBMode in LOADING_MODE) then
    DBMode := dbmBrowse;
  AllowExit        := (dbMode = dbmBrowse);
  tbSave.Enabled   := (dbMode in [dbmInsert, dbmEdit]);
  tbNew.Enabled    := (dbMode = dbmBrowse);
  tbCancel.Enabled := (dbMode in [dbmInsert, dbmEdit]);
  tbPrior.Enabled  := ((dbMode = dbmBrowse) and Assigned(FScrollOS) and (CountSearch > 0));
  tbNext.Enabled   := ((dbMode = dbmBrowse) and Assigned(FScrollOS) and (CountSearch > 0));
end;

procedure TfmEditOS.DisplayObject(Sender: TObject);
var
  aObj: TPersistent;
  aIdx: Integer;
begin
  SetActiveObjectIndex(eFk_Tipo_Ordens_Servicos, ServiceOrder.FkTypeServiceOrder.PkTipoOrdensServicos);
  aIdx := eFk_Tipo_Ordens_Servicos.ItemIndex;
  if (aIdx > 0) then
  begin
    aObj    := TPersistent(eFk_Tipo_Ordens_Servicos.Items.Objects[aIdx]);
    TypeES  := TTypeServiceOrder(aObj).FlagES;
    TypeUse := TTypeServiceOrder(aObj).FlagTOS;
    ServiceOrder.FkTypeServiceOrder := TTypeServiceOrder(aObj);
  end;
  SetActiveObjectIndex(eFk_Cadastros, ServiceOrder.FkCadastros.PkCadastros);
  aIdx := eFk_Cadastros.ItemIndex;
  if (aIdx > 0) then
  begin
    aObj    := TPersistent(eFk_Cadastros.Items.Objects[aIdx]);
    ServiceOrder.FkCadastros := TOwner(aObj);
  end;
  SetActiveObjectIndex(eFk_Status_OS, ServiceOrder.FkStatusOS.PkStatusOS);
  aIdx := eFk_Status_OS.ItemIndex;
  if (aIdx > 0) then
  begin
    aObj    := TPersistent(eFk_Status_OS.Items.Objects[aIdx]);
    ServiceOrder.FkStatusOS := TStatusOS(aObj);
  end;
  SetActiveObjectIndex(eFk_Rodovias, ServiceOrder.FkRodovias.PkRodovias);
  aIdx := eFk_Rodovias.ItemIndex;
  if (aIdx > 0) then
  begin
    aObj    := TPersistent(eFk_Rodovias.Items.Objects[aIdx]);
    ServiceOrder.FkRodovias := TRodovias(aObj);
  end;
  eDscPgto.Text                      := ServiceOrder.FkPayment.DscTPgt;
  eDsc_Ord.Text                      := ServiceOrder.DscOrd;
  ePk_Ordens_Servicos.Text           := IntToStr(ServiceOrder.PkOS);
  eDta_OS.Date                       := ServiceOrder.DtaOS;
  eTot_Ord.Text                      := FloatToStrF(ServiceOrder.TotOS, ffCurrency, 7, Dados.DecimalPlaces);
  if ServiceOrder.DtaIni > 0 then
    eDta_Ini.Date                    := ServiceOrder.DtaIni
  else
    eDta_Ini.Clear;
  if ServiceOrder.DtaFin > 0 then
    eDta_Fin.Date                    := ServiceOrder.DtaFin
  else
    eDta_Fin.Clear;
  if ServiceOrder.DtaCanc > 0 then
    eDta_Canc.Date                   := ServiceOrder.DtaCanc
  else
    eDta_Canc.Clear;
  if ServiceOrder.DtaLiq > 0 then
    eDta_Liq.Date                    := ServiceOrder.DtaLiq
  else
    eDta_Liq.Clear;
  if ServiceOrder.DtaBlq > 0 then
    eDta_Blq.Date                    := ServiceOrder.DtaBlq
  else
    eDta_Blq.Clear;
  if ServiceOrder.DtaAprv > 0 then
    eDta_Aprv.Date                   := ServiceOrder.DtaAprv
  else
    eDta_Aprv.Clear;
end;

procedure TfmEditOS.LoadServiceOrderItems;
var
  i, j: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (ServiceOrder = nil) or (ServiceOrder.ServiceOrderItems = nil) then exit;
  vtItems.BeginUpdate;
  try
    with ServiceOrder.ServiceOrderItems do
    begin
      for i := 0 to Count - 1 do
      begin
        Node := vtItems.AddChild(nil);
        if Node <> nil then
        begin
          Data           := vtItems.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level    := vtItems.GetNodeLevel(Node);
            Data^.Node     := Node;
            Data^.DataRow  := GetDataFromItem(Items[i]);
            Items[i].ItemIsVisible := True;
            Items[i].Node  := Node;
            if Data^.DataRow <> nil then
              Data^.DataRow.UserData := Items[i];
            for j := 0 to Items[i].FkInsumos.Count - 1 do
              LoadServiceOrderInsumos(Node, i, j);
          end;
        end;
      end;
    end;
  finally
    vtItems.EndUpdate;
  end;
end;

procedure TfmEditOS.LoadServiceOrderInsumos(ANode: PVirtualNode;
  const AItx, AInx: Integer);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (ANode = nil) or (AItx < 0) or (AInx < 0) then exit;
  Node := vtItems.AddChild(ANode);
  if Node <> nil then
  begin
    Data           := vtItems.GetNodeData(Node);
    if (Data <> nil) then
    begin
      Data^.Level    := vtItems.GetNodeLevel(Node);
      Data^.Node     := Node;
      with ServiceOrder.ServiceOrderItems.Items[aItx] do
      begin
        Data^.DataRow          := GetDataFromInsumoItem(FkInsumos.Items[aInx]) ;
        Data^.DataRow.UserData := FkInsumos.Items[aInx];
        FkInsumos.Items[aInx].Node := Node;
      end;
    end;
  end;
end;

procedure TfmEditOS.AutorizationStatusChange(Sender: TObject;
            const AStatus: TStatusOS; var ACodAut: Integer);
begin
  if ACodAut > 0 then
  begin
    ShowMessage('Status Autorization');
  end;
end;

procedure TfmEditOS.ChangeAuthentication(Sender: TObject; const Value: Integer;
            var Allowed: Boolean);
begin
  if Value > 0 then
  begin
    ShowMessage('Change Autorization');
  end;
end;

procedure TfmEditOS.CheckError(Sender: TObject; AError: TCheckErrorType;
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
     'Erro: Ordem de Serviços deve ter pelo menos um serviço descriminado',
     'Erro: Não posso usar o status escolhido nesta Ordem de Serviços',
     'Erro: Total da Ordem de Serviços = 0 ou nulo');
begin
  AMsg := Msg[AError];
end;

procedure TfmEditOS.ChangeMode(Sender: TObject);
var
  aObj: TPersistent;
begin
  ldbMode.Caption     := ModeTypes[dbMode];
  ldbMode.Font.Color  := ColorMode[dbMode];
  stStatus.Caption    := ModeTypes[dbMode];
  stStatus.Font.Color := ColorMode[dbMode];
  if (dbMode in [dbmInsert, dbmEdit]) and (ServiceOrder <> nil) and
     (ServiceOrder.FkEmpresas = nil) then
    ServiceOrder.FkEmpresas := ActiveCompany;
  AllowExit        := (dbMode = dbmBrowse);
  tbSave.Enabled   := (dbMode in [dbmInsert, dbmEdit]);
  tbNew.Enabled    := (dbMode = dbmBrowse);
  tbCancel.Enabled := (dbMode in [dbmInsert, dbmEdit]);
  tbPrior.Enabled  := ((dbMode = dbmBrowse) and Assigned(FScrollOS) and (CountSearch > 0));
  tbNext.Enabled   := ((dbMode = dbmBrowse) and Assigned(FScrollOS) and (CountSearch > 0));
  eFk_Rodovias.Enabled := (DbMode = dbmInsert);
  if dbMode = dbmInsert then
  begin
    aObj := SetActiveObjectIndex(eFk_Tipo_Ordens_Servicos, FDefTypeOS);
    ServiceOrder.FkTypeServiceOrder := TTypeServiceOrder(aObj);
    TypeES                  := ServiceOrder.FkTypeServiceOrder.FlagES;
    TypeUse                 := ServiceOrder.FkTypeServiceOrder.FlagTOS;
    ServiceOrder.FkStatusOS := TStatusOS(SetActiveObjectIndex(eFk_Status_OS, FDefStatusOS));
    ServiceOrder.DtaOS      := Date;
    DisplayObject(Self);
  end;
  if ServiceOrder <> nil then
    ServiceOrder.StateSO := dbMode;
end;

procedure TfmEditOS.SetServiceOrder(AValue: TServiceOrder);
begin
  if (AValue = nil) then
    FServiceOrder.Clear
  else
    FServiceOrder.Assign(AValue);
end;

procedure TfmEditOS.SetTypeES(AValue: TTypeES);
begin
  if (AValue <> FTypeES) then
  begin
    FTypeES := AValue;
    LoadOwners;
  end;
end;

procedure TfmEditOS.SetTypeUse(AValue: TTypeUse);
begin
  if (AValue <> FTypeUse) then
  begin
    FTypeUse := AValue;
    case FTypeUse of
      tuMetric   : tsMetrics.TabVisible := True;
      tuFix      : ;
      tuBuild    : ;
      tuTecnology: ;
    end;
  end;
end;

procedure TfmEditOS.eFk_Tipo_Ordens_ServicosChange(Sender: TObject);
var
  Idx  : Integer;
  aItem: TTypeServiceOrder;
begin
  ChangeGlobal(Sender);
  if (not (dbMode in UPDATE_MODE)) then exit;
  Idx           := eFk_Tipo_Ordens_Servicos.ItemIndex;
  if (Idx > 0) and (eFk_Tipo_Ordens_Servicos.Items.Objects[Idx] <> nil) and
     (eFk_Tipo_Ordens_Servicos.Items.Objects[Idx] is TTypeServiceOrder) then
  begin
    aItem   := TTypeServiceOrder(eFk_Tipo_Ordens_Servicos.Items.Objects[Idx]);
    TypeES  := aItem.FlagES;
    TypeUse := aItem.FlagTOS;
    ServiceOrder.FkTypeServiceOrder := aItem;
  end;
end;

procedure TfmEditOS.eFk_CadastrosChange(Sender: TObject);
var
  Idx: Integer;
  aItem: TOwner;
begin
  ChangeGlobal(Sender);
  if (not (dbMode in UPDATE_MODE)) then exit;
  Idx := eFk_Cadastros.ItemIndex;
  if (Idx > 0) and (eFk_Cadastros.Items.Objects[Idx] <> nil) and
     (eFk_Cadastros.Items.Objects[Idx] is TOwner)            then
  begin
    aItem := TOwner(eFk_Cadastros.Items.Objects[Idx]);
    ServiceOrder.FkCadastros := aItem;
  end;
end;

procedure TfmEditOS.eFk_Status_OSChange(Sender: TObject);
var
  Idx: Integer;
  aItem: TStatusOS;
begin
  ChangeGlobal(Sender);
  if (not (dbMode in UPDATE_MODE)) then exit;
  Idx := eFk_Status_OS.ItemIndex;
  ServiceOrder.FkStatusOS.Clear;
  if (Idx > 0) and (eFk_Status_OS.Items.Objects[Idx] <> nil) and
     (eFk_Status_OS.Items.Objects[Idx] is TStatusOS) then
  begin
    aItem := TStatusOS(eFk_Status_OS.Items.Objects[Idx]);
    ServiceOrder.FkStatusOS := aItem;
    if VerifyStatus and (ServiceOrder.FkStatusOS.PkStatusOS > 0) then
    begin
      case ServiceOrder.FkStatusOS.FlagStt of
        stFinished: if ServiceOrder.DtaLiq  = 0 then ServiceOrder.DtaLiq  := Date;
        stCanceled: if ServiceOrder.DtaCanc = 0 then ServiceOrder.DtaCanc := Date;
        stBlocked : if ServiceOrder.DtaBlq  = 0 then ServiceOrder.DtaBlq  := Date;
        stApproved: if ServiceOrder.DtaAprv = 0 then ServiceOrder.DtaAprv := Date;
      end;
    end
    else
    begin
      eFk_Status_OS.ItemIndex := 0;
      if eFk_Status_OS.CanFocus then eFk_Status_OS.SetFocus;
    end;
  end;
end;

function  TfmEditOS.VerifyStatus: Boolean;
var
  i   : TCheckErrorType;
  aMsg: string;
begin
  Result := True;
  aMsg := '';
  if  ServiceOrder.CheckStatus <> [] then
  begin
    Result := False;
    for i := ceNullDtaOS to ceNullTotal do
    begin
      if (i in ServiceOrder.CheckStatus) then
      begin
        CheckError(Self, i, aMsg);
        Application.MessageBox(PAnsiChar(aMsg), PAnsiChar(Application.Title),
          MB_OK + MB_ICONERROR);
        Result := False;
        break;
      end;
    end;
  end;
end;

procedure TfmEditOS.eFk_RodoviasChange(Sender: TObject);
var
  Idx   : Integer;
  aItem : TRodovias;
begin
  ChangeGlobal(Sender);
  if (not (dbMode in UPDATE_MODE)) then exit;
  Idx := eFk_Rodovias.ItemIndex;
  if (Idx > 0) and (eFk_Rodovias.Items.Objects[Idx] <> nil) and
     (eFk_Rodovias.Items.Objects[Idx] is TRodovias) then
  begin
    aItem := TRodovias(eFk_Rodovias.Items.Objects[Idx]);
    ServiceOrder.FkRodovias := aItem;
  end;
end;

procedure TfmEditOS.tbNewClick(Sender: TObject);
begin
  ServiceOrder.Clear;
  ServiceOrder.FkEmpresas := ActiveCompany;
  ClearControls;
  eDta_OS.Date := Date;
  DbMode := dbmInsert;
end;

procedure TfmEditOS.tbCancelClick(Sender: TObject);
begin
  dbMode := dbmCancel;
  eDta_Ini.Enabled := False;
  eDta_Fin.Enabled := False;
  ClearControls;
  if ServiceOrder.PkOS = 0 then
    ServiceOrder.Clear
  else
  begin
    ServiceOrder := ActiveOS;
    PopulateGridFromObject;
  end;
  DisplayObject(Self);
  dbMode := dbmBrowse;
end;

procedure TfmEditOS.tbSaveClick(Sender: TObject);
begin
  if (FServiceOrder = nil) then exit;
  FServiceOrder.FkEmpresas := ActiveCompany; 
  if FServiceOrder.CheckRules(False) then
  begin
    dmSysSrv.MoveObject2Data(FServiceOrder, dbMode);
    ePk_Ordens_Servicos.Text := IntToStr(FServiceOrder.PkOS);
    ActiveOS := FServiceOrder;
    ServiceOrder.CheckRules(True);
  end;
  dbMode := dbmBrowse;
end;

procedure TfmEditOS.tbPriorClick(Sender: TObject);
var
  aBOF : Boolean;
  aPKOS: Integer;
begin
  aPKOS := PkServiceOrder;
  if Assigned(FScrollOS) then
    FScrollOS(Self, aPKOS, dsPrior, aBOF);
  PKServiceOrder  := aPKOS;
  tbPrior.Enabled := (aBOF and (PkServiceOrder > 0));
  if not tbNext.Enabled then tbNext.Enabled := True;
end;

procedure TfmEditOS.tbNextClick(Sender: TObject);
var
  aEOF : Boolean;
  aPKOS: Integer;
begin
  aPKOS := PkServiceOrder;
  if Assigned(FScrollOS) then
    FScrollOS(Self, aPKOS, dsNext, aEOF);
  PKServiceOrder  := aPKOS;
  tbNext.Enabled  := (aEOF and (PkServiceOrder > 0));
  if not tbPrior.Enabled then tbPrior.Enabled := True;
end;

procedure TfmEditOS.vtItemsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
  aStr: string;
  aCmp: TFlagQtd;
  p: Pointer;
  i: Integer;
begin
  if (Node = nil) then exit;
  Data    := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (vtItems.GetNodeLevel(Node) > 0) then
  begin
    case Column of
      0: CellText := '';
      1: CellText := Data^.DataRow.FieldByName['DSC_INS'].AsString;
      2: CellText := FloatToStrF(Data^.DataRow.FieldByName['QTD_INS'].AsFloat, ffNumber, 7, Dados.DecimalPlacesQtd);
      3: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_UNIT'].AsFloat, ffNumber, 7, Dados.DecimalPlaces);
      4: CellText := FloatToStrF(Data^.DataRow.FieldByName['TOT_INS'].AsFloat, ffNumber, 7,  Dados.DecimalPlaces);
    end;
  end
  else
  begin
    case Column of
      0: CellText := Data^.DataRow.FieldByName['PK_ORDENS_SERVICOS_ITENS'].AsString;
      1: CellText := Data^.DataRow.FieldByName['DSC_PROD'].AsString;
      2: CellText := FloatToStrF(Data^.DataRow.FieldByName['QTD_SRV'].AsFloat, ffNumber, 7, Dados.DecimalPlacesQtd);
      3: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_UNIT'].AsFloat, ffNumber, 7, Dados.DecimalPlaces);
      4: CellText := FloatToStrF(Data^.DataRow.FieldByName['TOT_SRV'].AsFloat, ffNumber, 7,  Dados.DecimalPlaces);
    end;
  end;
  if (Column = 5) then
  begin
    aStr := '';
    if Sender.GetNodeLevel(Node) = 0 then
    begin
      if (Data^.DataRow.FindField['LOC_FIN'] <> nil) and
         (Data^.DataRow.FindField['LOC_INI'] <> nil) then
      begin
        aStr     := 'Início: ' +
                    FloatToStrF(Data^.DataRow.FieldByName['LOC_INI'].AsFloat, ffNumber, 7, 4);
        CellText := aStr + ' - Fim: ' +
                    FloatToStrF(Data^.DataRow.FieldByName['LOC_FIN'].AsFloat, ffNumber, 7, 4);
      end;
    end
    else
    begin
      aStr := '';
      i := Data^.DataRow.FieldByName['FLAG_TQTD'].AsInteger;
      p := @i;
      aCmp := TFlagQtd(p^);
      if (fqComp in aCmp) and (Data^.DataRow.FindField['COMP_INS'] <> nil) and
         (Data^.DataRow.FieldByName['COMP_INS'].AsFloat > 0) then
        aStr := aStr + FloatToStrF(Data^.DataRow.FieldByName['COMP_INS'].AsFloat, ffNumber, 7, 4);
      if (fqLarg in aCmp) and (Data^.DataRow.FindField['LARG_INS'] <> nil) and
         (Data^.DataRow.FieldByName['LARG_INS'].AsFloat > 0) then
      begin
        if aStr <> '' then
          aStr := aStr + ' x ';
        aStr := aStr + FloatToStrF(Data^.DataRow.FieldByName['LARG_INS'].AsFloat, ffNumber, 7, 4);
      end;
      if (fqAlt in aCmp) and (Data^.DataRow.FindField['ALT_INS'] <> nil) and
         (Data^.DataRow.FieldByName['ALT_INS'].AsFloat > 0) then
      begin
        if aStr <> '' then
          aStr := aStr + ' x ';
        aStr := aStr + FloatToStrF(Data^.DataRow.FieldByName['ALT_INS'].AsFloat, ffNumber, 7, 4);
      end;
      CellText := aStr;
    end;
  end;
end;

procedure TfmEditOS.vtItemsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
  aActivity: TInsumo;
  aService : TServiceOrderItem;
begin
  Data := vtItems.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Data^.DataRow.UserData = nil) then exit;
  if vtItems.GetNodeLevel(Node) = 0 then
  begin
    TargetCanvas.Font.Style := [fsBold];
    aService := TServiceOrderItem(Data^.DataRow.UserData);
    if aService.FlagPers then
      TargetCanvas.Font.Color := clTeal;
    if aService.DtaFat > 0 then
      TargetCanvas.Font.Color := clBlue;
  end
  else
  begin
    TargetCanvas.Font.Style := [];
    aActivity := TInsumo(Data^.DataRow.UserData);
    if aActivity.FlagDef then
      TargetCanvas.Font.Color := clWindowText
    else
      TargetCanvas.Font.Color := clTeal;
    if aActivity.FlagFrn then
      TargetCanvas.Font.Color := clRed;
  end;
end;

procedure TfmEditOS.vtItemsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
  Root: PVirtualNode;
begin
  if (vtItems.PopupMenu = nil) and (FActiveControls) then
    vtItems.PopupMenu := pmItems;
  if Assigned(frmItemOS) and (frmItemOS.Visible) and // if Item is been edited exit change
     (frmItemOS.dbMode <> dbmBrowse) then
    exit;
  if (Node <> nil) then
  begin
    if (vtItems.GetNodeLevel(Node) > 0) then
    begin
      ServiceOrder.ActiveItem := -1;
      Root := Node.Parent;
      if Root <> nil then
      begin
        Data := vtItems.GetNodeData(Root);
        if (Data <> nil) and (Data^.DataRow <> nil) and (Data^.DataRow.UserData <> nil) and
           (Data^.DataRow.UserData is TServiceOrderItem) then
          ServiceOrder.ActiveItem := TServiceOrderItem(Data^.DataRow.UserData).Index
      end;
      if ServiceOrder.ActiveItem = -1 then
      begin
        ServiceOrder.ServiceOrderItems.Items[ServiceOrder.ActiveItem].ActiveInsumo := -1;
        raise Exception.Create('Erro: Não posso selecionar a Atividade sem ' +
          'selecionar o Serviço antes');
      end;
      Data := vtItems.GetNodeData(Node);
      if (Data = nil) or (Data^.DataRow = nil) or (Data^.DataRow.UserData = nil) or
         (not (Data^.DataRow.UserData is TInsumo)) or
         (ServiceOrder.ServiceOrderItems.Count < ServiceOrder.ActiveItem) then
        exit;
      ServiceOrder.ServiceOrderItems.Items[ServiceOrder.ActiveItem].ActiveInsumo :=
        TInsumo(Data^.DataRow.UserData).Index;
    end
    else
    begin
      Data := vtItems.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (Data^.DataRow.UserData <> nil) and
         (Data^.DataRow.UserData is TServiceOrderItem) then
        ServiceOrder.ActiveItem := TServiceOrderItem(Data^.DataRow.UserData).Index;
    end;
    pmDelete.Visible := (vtItems.RootNodeCount > 0) and (vtItems.SelectedCount > 0);
    pmEdit.Visible   := pmDelete.Visible;
    pmView.Visible   := pmDelete.Visible;
    pmCopy.Visible   := pmDelete.Visible;
    N1.Visible       := pmView.Visible;
    N2.Visible       := pmCopy.Visible;
  end;
end;

procedure TfmEditOS.vtItemsDblClick(Sender: TObject);
begin
  vtItems.PopupMenu := nil;
  ShowItems(dbmBrowse, GetEntryData);
end;

{ Handle Items Form (frmItemOS) }

function  TfmEditOS.GetEntryData: TEntryData;
var
  Node: PVirtualNode;
begin
  if vtItems.RootNodeCount = 0 then
    Result := edService
  else
  begin
    Node := vtItems.FocusedNode;
    if (Node <> nil) and (vtItems.GetNodeLevel(Node) = 1) then
      Result := edActivity
    else
      Result := edService;
  end;
end;

procedure TfmEditOS.pmInsertClick(Sender: TObject);
var
  aEntryData: TEntryData;
begin
  aEntryData := GetEntryData;
  if aEntryData = edService then
    ServiceOrder.ActiveItem := -1;
  if aEntryData = edActivity then
    if ServiceOrder.ActiveItem > -1 then
      ServiceOrder.ServiceOrderItems.Items[ServiceOrder.ActiveItem].ActiveInsumo := -1;
  vtItems.PopupMenu := nil;
  ShowItems(dbmInsert, aEntryData);
end;

procedure TfmEditOS.pmEditClick(Sender: TObject);
begin
  vtItems.PopupMenu := nil;
  ShowItems(dbmEdit, GetEntryData);
end;

procedure TfmEditOS.pmViewClick(Sender: TObject);
begin
  vtItems.PopupMenu := nil;
  ShowItems(dbmBrowse, GetEntryData);
end;

procedure TfmEditOS.pmDeleteClick(Sender: TObject);
var
  Node      : PVirtualNode;
  ChildNode : PVirtualNode;
  Data      : PGridData;
  aInx, aIdx: Integer;
  DataType  : TEntryData;
begin
//  Delete node focused node and childs nodes of the vtItems grid
  Node := vtItems.FocusedNode;
  if Node = nil then exit;
  Data := vtItems.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.UserData = nil) then
    raise Exception.Create('Erro: Não posso excluir o ítem do Objeto');
  aIdx := -1;
  aInx := -1;
  DataType := edService;
  if Data^.DataRow.UserData is TServiceOrderItem then
    aIdx     := TServiceOrderItem(Data^.DataRow.UserData).Index;
  if Data^.DataRow.UserData is TInsumo then
  begin
    DataType := edActivity;
    aInx     := TInsumo(Data^.DataRow.UserData).Index;
    aIdx     := TInsumo(Data^.DataRow.UserData).Index;
//    aIdx     := TInsumo(Data^.DataRow.UserData).ServiceIndex;
  end;
  Data^.DataRow.UserData := nil;
  if (DataType = edService) and (aIdx = -1) then
    raise Exception.CreateFmt('Erro: Não posso excluir o Serviço (%d)', [aIdx]);
  if (DataType = edActivity) and (aInx = -1) then
    raise Exception.CreateFmt('Erro: Não posso excluir o Insumo (%d)', [aInx]);
  vtItems.BeginUpdate;
  vtItems.TreeOptions.SelectionOptions := [toFullRowSelect, toMultiSelect];
  try // Free Data memory
    vtItems.Selected[Node] := True;
    ChildNode := vtItems.GetFirstChild(Node);
    ReleaseData(Data^);
    while ChildNode <> nil do
    begin
      vtItems.Selected[ChildNode] := True;
      Data := vtItems.GetNodeData(ChildNode);
      ChildNode := vtItems.GetNextSibling(ChildNode);
      if (Data <> nil) then
        ReleaseData(Data^);
    end;
    vtItems.DeleteSelectedNodes;
  finally
    vtItems.TreeOptions.SelectionOptions := [toFullRowSelect];
    vtItems.EndUpdate;
  end;
  if DataType = edService then
    ServiceOrder.ServiceOrderItems.Delete(aIdx)
  else
    ServiceOrder.ServiceOrderItems.Items[aIdx].FkInsumos.Delete(aInx);
  if Assigned(frmItemOS) and (frmItemOS.DelClose) then
    frmItemOS.Close;
end;

procedure TfmEditOS.ReleaseData(Data: TGridData);
begin
  if (Data.DataRow <> nil) then
    Data.DataRow.Free;
  Data.DataRow  := nil;
  Data.Node := nil;
end;

function TfmEditOS.ShowItems(AMode: TdbMode; AEntryData: TEntryData): Boolean;
const
  cTitle: array [edService..edActivity] of string =
    ('Manutenção do Serviço da Ordem de Serviços de %s',
     'Manutenção da Atividade da Ordem de Serviços de %s');
begin
  Result := True;
  if Assigned(frmItemOS) then
  begin
    frmItemOS.Free;
    frmItemOS := nil;
  end;
  if not Assigned(frmItemOS) then
  begin
    frmItemOS        := TfrmItemOS.Create(Self);
    frmItemOS.Parent := paDetails;
    frmItemOS.Align  := alClient;
  end;
  frmItemOS.OnUpdateItem  := OnItem;
  frmItemOS.OnUpdateOS    := DisplayObject;
  frmItemOS.OnCloseItems  := CloseItemsForm;
  frmItemOS.ServiceOrder  := ServiceOrder;
  frmItemOS.ActiveOS      := ActiveOS;
  frmItemOS.Show;
  frmItemOS.dbMode    := AMode;
  frmItemOS.EntryData := AEntryData;
  if (AMode = dbmBrowse) then
    DbMode := dbmEdit;
end;

procedure TfmEditOS.OnItem(AItem: TServiceOrderItem; const AChildItem: Integer;
  const AMode: TDBMode);
var
  Node: PVirtualNode;
  Data: PGridData;
  i   : Integer;
begin
  if (AItem = nil) then exit;
  if (AChildItem > -1) and ((AItem.FkInsumos = nil) or
     (AItem.FkInsumos.Count <= AChildItem)) then exit;
  if (AMode = dbmDelete) and (AItem.Node <> nil) then // delete node
  begin
    vtItems.Selected[AItem.Node] := True;
    vtItems.FocusedNode := AItem.Node;
    pmDeleteClick(Self);
    exit;
  end;
  vtItems.BeginUpdate;
  try
    if (AMode = dbmCancel) and (AItem.Node <> nil) then
    begin
      if (ServiceOrder.ServiceOrderItems.Count > AItem.Index) and  // Assign prior alt from node
         (AChildItem > -1) and
         (ServiceOrder.ServiceOrderItems.Items[AItem.Index].FkInsumos.Count > AChildItem) then
        AItem.FkInsumos.Assign(
          ServiceOrder.ServiceOrderItems.Items[AItem.Index].FkInsumos.Items[AChildItem])
      else
      begin
        if (AChildItem > -1) and  (AItem.FkInsumos.Count > AChildItem) then // delete Insumo
        begin
          vtItems.Selected[AItem.FkInsumos.Items[AChildItem].Node] := True;
          vtItems.FocusedNode := AItem.FkInsumos.Items[AChildItem].Node;
          pmDeleteClick(Self);
          exit;
        end;
      end;
      if ServiceOrder.ServiceOrderItems.Count > AItem.Index then
        AItem.Assign(ServiceOrder.ServiceOrderItems.Items[AItem.Index]) // Delete Node
      else
      begin
        vtItems.Selected[AItem.Node] := True;
        vtItems.FocusedNode := AItem.Node;
        pmDeleteClick(Self);
        exit;
      end;
    end;
    if (not AItem.ItemIsVisible) or (AItem.Node = nil) then
    begin
      AItem.ItemIsVisible := True;
      if (AChildItem > -1) then
        Node := vtItems.AddChild(AItem.Node)
      else
        Node := vtItems.AddChild(nil);
    end
    else
      if AChildItem = -1 then
        Node := AItem.Node
      else
        if AItem.FkInsumos.Items[AChildItem].Node = nil then
          Node := vtItems.AddChild(AItem.Node)
        else
          Node := AItem.FkInsumos.Items[AChildItem].Node;
    if Node = nil then exit;
    Data := vtItems.GetNodeData(Node);
    if (Data = nil) then exit;
    if (AChildItem = -1) then
    begin
      Data^.DataRow := GetDataFromItem(AItem);
      if (AItem.FkInsumos.Count > 0) then
      begin
        if AItem.Node = nil then
          AItem.Node := Node;
        for i := 0 to AItem.FkInsumos.Count - 1 do
        begin
          if AItem.FkInsumos.Items[i].Node = nil then
            Node := vtItems.AddChild(AItem.Node)
          else
            Node := AItem.FkInsumos.Items[i].Node;
          if Node <> nil then
          begin
            Data := vtItems.GetNodeData(Node);
            if (Data <> nil) then
              with AItem.FkInsumos do
                Data^.DataRow := GetDataFromInsumoItem(Items[i]);
            if AItem.FkInsumos.Items[i].Node = nil then
              AItem.FkInsumos.Items[i].Node := Node;
          end;
        end;
      end;
    end
    else
      Data^.DataRow := GetDataFromInsumoItem(AItem.FkInsumos.Items[AChildItem]);
  finally
    vtItems.EndUpdate;
    vtItems.PopupMenu := pmItems;
  end;
end;

function  TfmEditOS.GetDataFromItem(AItem: TServiceOrderItem): TDataRow;
var
  Data: PGridData;
begin
  Result := nil;
  if (AItem = nil)  then exit;
  if AItem.Node = nil then
    Result := TDataRow.Create(nil)
  else
  begin
    Data := vtItems.GetNodeData(AItem.Node);
    if Data <> nil then
      Result := Data^.DataRow
    else
     Result := nil;
  end;
  if Result = nil then exit;
  Result.UserData := AItem;
// PKItems Column 0
  if Result.FindField['PK_ORDENS_SERVICOS_ITENS'] = nil then
    Result.AddAs('PK_ORDENS_SERVICOS_ITENS', AItem.Index + 1, ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['PK_ORDENS_SERVICOS_ITENS'].AsInteger := AItem.Index + 1;
// Description Column 1
  with AItem do
    if Result.FindField['DSC_PROD'] = nil then
      Result.AddAs('DSC_PROD', DscTComp, ftString, SizeOf(DscTComp))
    else
      Result.FieldByName['DSC_PROD'].AsString := DscTComp;
// Quantity Column 2
  if Result.FindField['QTD_SRV'] = nil then
    Result.AddAs('QTD_SRV', AItem.QtdSrv, ftFloat, SizeOf(Double))
  else
    Result.FieldByName['QTD_SRV'].AsFloat := AItem.QtdSrv;
// Unitary Value Column 3
  if Result.FindField['VLR_UNIT'] = nil then
    Result.AddAs('VLR_UNIT', AItem.VlrUnit, ftFloat, SizeOf(Double))
  else
    Result.FieldByName['VLR_UNIT'].AsFloat := AItem.VlrUnit;
// Total of Service Column 4
  if Result.FindField['TOT_SRV'] = nil then
    Result.AddAs('TOT_SRV', AItem.TotSrv, ftFloat, SizeOf(Double))
  else
    Result.FieldByName['TOT_SRV'].AsFloat := AItem.TotSrv;
// Metric Item
  with AItem.FkMetricItem do
  begin
// Initial Mark Column 5
    if Result.FindField['LOC_INI'] = nil then
      Result.AddAs('LOC_INI', KmIni, ftFloat, SizeOf(Double))
    else
      Result.FieldByName['LOC_INI'].AsFloat := KmIni;
// Final Mark Column 6
    if Result.FindField['LOC_FIN'] = nil then
      Result.AddAs('LOC_FIN', KmFin, ftFloat, SizeOf(Double))
    else
      Result.FieldByName['LOC_FIN'].AsFloat := KmFin;
  end;
// Invoicement Date Column 7
  if Result.FindField['DTA_FAT'] = nil then
    Result.AddAs('DTA_FAT', AItem.DtaFat, ftDateTime, SizeOf(Double))
  else
    Result.FieldByName['DTA_FAT'].AsDateTime := AItem.DtaFat;
// FKCompositions Item
  with AItem do
// FKCompositions Column 8
    if Result.FindField['FK_TIPO_COMPOSICOES'] = nil then
      Result.AddAs('FK_TIPO_COMPOSICOES', PkProduct, ftInteger, SizeOf(Integer))
    else
      Result.FieldByName['FK_TIPO_COMPOSICOES'].AsInteger := PkProduct;
// FKClassification Column 9
  if Result.FindField['FK_CLASSIFICACAO'] = nil then
    Result.AddAs('FK_CLASSIFICACAO', AItem.FkClassification, ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['FK_CLASSIFICACAO'].AsInteger := AItem.FkClassification;
// Flag Personalization Column 10
  if Result.FindField['FLAG_PERS'] = nil then
    Result.AddAs('FLAG_PERS', Ord(AItem.FlagPers), ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['FLAG_PERS'].AsInteger := Ord(AItem.FlagPers);
// Flag Side Column 11
  with AItem.FkMetricItem do
    if Result.FindField['FLAG_SIDE'] = nil then
      Result.AddAs('FLAG_SIDE', Ord(FlagSide), ftInteger, SizeOf(Integer))
    else
      Result.FieldByName['FLAG_SIDE'].AsInteger := Ord(FlagSide);
end;

function  TfmEditOS.GetDataFromInsumoItem(AInsumo: TInsumo): TDataRow;
var
  Data: PGridData;
begin
  Result := nil;
  if AInsumo = nil then exit;
  if AInsumo.Node = nil then
    Result := TDataRow.Create(nil)
  else
  begin
    Data := vtItems.GetNodeData(AInsumo.Node);
    if Data <> nil then
      Result := Data^.DataRow
    else
      Result := nil;
  end;
  if Result = nil then exit;
  Result.UserData := AInsumo;
// Sequence of activity (Column 0)
  if Result.FindField['SEQ_ITEM'] = nil then
    Result.AddAs('SEQ_ITEM', AInsumo.SeqIns, ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['SEQ_ITEM'].AsInteger := AInsumo.SeqIns;
// Description of activity (Column 1)
  if Result.FindField['DSC_INS'] = nil then
    Result.AddAs('DSC_INS', AInsumo.DscIns, ftString, SizeOf(AInsumo.DscIns))
  else
    Result.FieldByName['DSC_INS'].AsString := AInsumo.DscIns;
// Quantity of Activity (Column 2)
  if Result.FindField['QTD_INS'] = nil then
    Result.AddAs('QTD_INS', AInsumo.QtdIns, ftFloat, SizeOf(Double))
  else
    Result.FieldByName['QTD_INS'].AsFloat := AInsumo.QtdIns;
// Value of Activity (Column 3)
  if Result.FindField['VLR_UNIT'] = nil then
    Result.AddAs('VLR_UNIT', AInsumo.VlrUnit, ftFloat, SizeOf(Double))
  else
    Result.FieldByName['VLR_UNIT'].AsFloat := AInsumo.VlrUnit;
// Total Value of Activity (Column 4)
  if Result.FindField['TOT_INS'] = nil then
    Result.AddAs('TOT_INS', AInsumo.TotIns, ftFloat, SizeOf(Double))
  else
    Result.FieldByName['TOT_INS'].AsFloat := AInsumo.TotIns;
// Height of Activity (Column 5)
  if Result.FindField['ALT_INS'] = nil then
    Result.AddAs('ALT_INS', AInsumo.AltIns, ftFloat, SizeOf(Double))
  else
    Result.FieldByName['ALT_INS'].AsFloat := AInsumo.AltIns;
// Width of Activity (Column 6)
  if Result.FindField['LARG_INS'] = nil then
    Result.AddAs('LARG_INS', AInsumo.LargIns, ftFloat, SizeOf(Double))
  else
    Result.FieldByName['LARG_INS'].AsFloat := AInsumo.LargIns;
// Length of Activity (Column 7)
  if Result.FindField['COMP_INS'] = nil then
    Result.AddAs('COMP_INS', AInsumo.CompIns, ftFloat, SizeOf(Double))
  else
    Result.FieldByName['COMP_INS'].AsFloat := AInsumo.CompIns;
// FKInsumo (Column 8)
  if Result.FindField['FK_INSUMO'] = nil then
    Result.AddAs('FK_INSUMO', AInsumo.FKProduct, ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['FK_INSUMO'].AsInteger := AInsumo.FKProduct;
// Type of Activity (Column 9)
  if Result.FindField['FLAG_TINS'] = nil then
    Result.AddAs('FLAG_TINS', Ord(AInsumo.FlagTIns), ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['FLAG_TINS'].AsInteger := Ord(AInsumo.FlagTIns);
// Flag of Material supplied from the Main Company (Column 8)
  if Result.FindField['FLAG_FRN'] = nil then
    Result.AddAs('FLAG_FRN', Ord(AInsumo.FlagFrn), ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['FLAG_FRN'].AsInteger := Ord(AInsumo.FlagFrn);
// Type of Quantity (Column 9)
  if Result.FindField['FLAG_TQTD'] = nil then
    Result.AddAs('FLAG_TQTD', AInsumo.FlagDBQtd, ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['FLAG_TQTD'].AsInteger := AInsumo.FlagDBQtd;
end;

procedure TfmEditOS.vtItemsEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TfmEditOS.ChangePKOS(Sender: TObject);
begin
  ServiceOrder := ActiveOS;
  if PkServiceOrder > 0 then // Load Service Order and set data to Screen Controls
  begin
    ReleaseTreeNodes(vtItems);
    LoadServiceOrderItems;
    DisplayObject(Self);
    if (ServiceOrder <> nil) and (ServiceOrder.FkTypeServiceOrder <> nil) and
       (ServiceOrder.FkStatusOS.FlagStt in
       [stParcialFinished, stFinished, stCanceled, stBlocked]) then
      ActiveControls := False;
  end;
end;

procedure TfmEditOS.CloseItemsForm(Sender: TObject);
begin
  vtItems.PopupMenu := pmItems;
  ServiceOrder.CalcOrder;
  eTot_Ord.Text := FloatToStrF(ServiceOrder.TotOS, ffCurrency, 7,
    Dados.DecimalPlaces);
  vtItems.FullExpand(ServiceOrder.ServiceOrderItems.Items[ServiceOrder.ActiveItem].Node);
end;

procedure TfmEditOS.PopulateGridFromObject;
var
  i: Integer;
begin
  if (ServiceOrder <> nil) and (ServiceOrder.ServiceOrderItems <> nil) and
     (ServiceOrder.ServiceOrderItems.Count > 0) then
    with ServiceOrder.ServiceOrderItems do
      for i := 0 to Count - 1 do
        OnItem(Items[i], -1, dbmBrowse);
end;

procedure TfmEditOS.SetActiveControls(AValue: Boolean);
begin
  eFk_Tipo_Ordens_Servicos.Enabled := AValue;
  ePk_Ordens_Servicos.Enabled      := AValue;
  eFk_Cadastros.Enabled            := AValue;
  eFk_Status_OS.Enabled            := AValue;
  eDsc_Ord.Enabled                 := AValue;
  eFk_Rodovias.Enabled             := AValue;
  if AValue then
    vtItems.PopupMenu                := pmItems
  else
    vtItems.PopupMenu                := nil;
  if dbMode <> dbmBrowse then dbMode := dbmBrowse;
end;

procedure TfmEditOS.pmCopyClick(Sender: TObject);
var
  Node     : PVirtualNode;
  ChildNode: PVirtualNode;
  Data     : PGridData;
  aItem    : TServiceOrderItem;
  aNewItem : TServiceOrderItem;
  aIdx     : Integer;
begin
//  Copy selected Node to other Node and insert in then ServiceOrder Object
  ChangeGlobal(Self);
  Node := vtItems.FocusedNode;
  if (Node = nil) or (vtItems.GetNodeLevel(Node) > 0) then exit;
  Data := vtItems.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.UserData = nil) or (not (Data^.DataRow.UserData is TServiceOrderItem)) then
    raise Exception.Create('Erro: Não posso copiar o ítem do Objeto');
  aItem := TServiceOrderItem(Data^.DataRow.UserData);
  if aItem = nil then exit;
  aNewItem := ServiceOrder.ServiceOrderItems.Add;
  if aNewItem = nil then exit;
  aNewItem.Assign(aItem);
  vtItems.BeginUpdate;
  try
    Node := vtItems.AddChild(nil);
    if Node <> nil then
    begin
      Data := vtItems.GetNodeData(Node);
      if Data <> nil then
      begin
        Data^.Level    := vtItems.GetNodeLevel(Node);
        Data^.Node     := Node;
        Data^.DataRow  := GetDataFromItem(aNewItem);
        aNewItem.Node  := Node;
        for aIdx := 0 to aNewItem.FkInsumos.Count - 1 do
        begin
          ChildNode := vtItems.AddChild(Node);
          if ChildNode <> nil then
          begin
            Data := vtItems.GetNodeData(ChildNode);
            if Data <> nil then
            begin
              Data^.Level    := vtItems.GetNodeLevel(ChildNode);
              Data^.Node     := Node;
              Data^.DataRow      := GetDataFromInsumoItem(
                aNewItem.FkInsumos.Items[aIdx]);
              aNewItem.FkInsumos.Items[aIdx].Node := Node;
            end;
          end;
        end;
      end;
    end;
  finally
    vtItems.EndUpdate;
  end;
end;

procedure TfmEditOS.pgOSChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (ServiceOrder.Historics <> nil);
end;

procedure TfmEditOS.pgOSChange(Sender: TObject);
const
  sTITLE = 'Históricos e Mensagens da Ordem de Serviços %s';
var
  i: Integer;
begin
  if pgOS.ActivePageIndex = 0 then exit;
  if Assigned(ServiceOrder.FkCadastros) then
    stTitle.Caption := Format(STitle, [ServiceOrder.FkCadastros.RazSoc]);
  vtProducts.Images := Dados.Image16;
  vtProducts.Header.Images := Dados.Image16;
  lbMessage.Items.Clear;
  eDsc_Hist.Tag := -1;
  vtProducts.Tag := -1;
  Dados.Image16.GetBitmap(36, sbSave.Glyph);
  Dados.Image16.GetBitmap(34, sbInsert.Glyph);
  ReleaseTreeNodes(vtHistorics);
  ReleaseTreeNodes(vtProducts);
  ReleaseTreeNodes(vtInsumos);
  for i := 0 to ServiceOrder.Historics.Count - 1 do
    ServiceOrder.Historics.Items[i].Node := GetDataToGrid(vtHistorics,
      gtHistorics, i, -1);
  vtHistorics.FocusedNode := vtHistorics.GetFirst;
end;

function  TfmEditOS.GetDataToGrid(Sender: TVirtualStringTree; GridType: TGridType;
  AIdx, AInx: Integer; NewNode: Boolean = True): PVirtualNode;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := nil;
  Sender.NodeDataSize := SizeOf(TGridData);
  Sender.BeginUpdate;
  try
    if NewNode then
      Node := Sender.AddChild(nil)
    else
      Node := Sender.FocusedNode;
    if Node <> nil then
    begin
      Result := Node;
      Data := Sender.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level    := 0;
        Data^.Node     := Node;
        case GridType of
          gtHistorics: Data^.DataRow := CreateHistData(ServiceOrder.Historics.Items[AIdx]);
          gtItems    : Data^.DataRow := CreateItemData(
            ServiceOrder.ServiceOrderItems.Items[AIdx].Index + 1,
            ServiceOrder.ServiceOrderItems.Items[AIdx].DscTComp, gtItems);
          gtInsumos  : Data^.DataRow := CreateItemData(
            ServiceOrder.ServiceOrderItems.Items[AIdx].FkInsumos.Items[AInx].SeqIns,
            ServiceOrder.ServiceOrderItems.Items[AIdx].FkInsumos.Items[AInx].DscIns,
            gtInsumos);
        end;
      end;
    end;
  finally
    Sender.EndUpdate;
  end;
end;

function  TfmEditOS.CreateHistData(AItem: THistoric): TDataRow;
var
  Data: PGridData;
const
  sOPERATION: array[htNone..htStatus] of string =
    ('Outra', 'Autorização', 'Troca de Status');
begin
  Result := nil;
  if (AItem = nil)  then exit;
  if AItem.Node = nil then
    Result := TDataRow.Create(nil)
  else
  begin
    Data := vtHistorics.GetNodeData(AItem.Node);
    if Data <> nil then
      Result := Data^.DataRow
    else
     Result := nil;
  end;
  if Result = nil then exit;
  Result.UserData := AItem;
// Index Column 1
  if Result.FindField['PK_OS_HISTORICOS'] = nil then
    Result.AddAs('PK_OS_HISTORICOS', AItem.Index + 1, ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['PK_OS_HISTORICOS'].AsInteger := AItem.Index + 1;
// Description Column 2
  if Result.FindField['DSC_HIST'] = nil then
    Result.AddAs('DSC_HIST', AItem.DscHist, ftString, Length(AItem.DscHist) + 1)
  else
    Result.FieldByName['DSC_HIST'].AsString := AItem.DscHist;
// Operation Column 3
  if Result.FindField['OPERATION'] = nil then
    Result.AddAs('OPERATIONS', sOPERATION[AItem.HistoricType], ftString,
      Length(sOPERATION[AItem.HistoricType]) + 1)
  else
    Result.FieldByName['OPERATIONS'].AsString := sOPERATION[AItem.HistoricType];
// No Column (FkOrdensServicosItens)
  if Result.FindField['FK_ORDENS_SERVICOS_ITENS'] = nil then
    Result.AddAs('FK_ORDENS_SERVICOS_ITENS', AItem.ServiceItem, ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['FK_ORDENS_SERVICOS_ITENS'].AsInteger := AItem.ServiceItem;
// No Column (SeqIns)
  if Result.FindField['SEQ_ITEM'] = nil then
    Result.AddAs('SEQ_ITEM', AItem.ServiceItem, ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['SEQ_ITEM'].AsInteger := AItem.SeqIns;
end;

function  TfmEditOS.CreateItemData(const AIdx: Integer; const ADsc: string;
            GridType: TGridType): TDataRow;
var
  aPk: Integer;
begin
  Result := TDataRow.Create(nil);
  aPk := eDsc_Hist.Tag;
  case GridType of
    gtItems  : aPk := FServiceOrder.Historics.Items[aPK].ServiceItem;
    gtInsumos: aPk := FServiceOrder.Historics.Items[aPK].SeqIns;
  end;
  if Result.FindField['INDEX'] = nil then
    Result.AddAs('INDEX', AIdx, ftInteger, SizeOf(Integer))
  else
    Result.FieldByName['INDEX'].AsInteger := AIdx;
  if Result.FindField['DSC_PROD'] = nil then
    Result.AddAs('DSC_PROD', ADsc, ftString, Length(ADsc) + 1)
  else
    Result.FieldByName['DSC_PROD'].AsString := ADsc;
  if Result.FindField['CHECK'] = nil then
    if (aPk = Result.FieldByName['INDEX'].AsInteger) then
    begin
      if GridType = gtItems then vtProducts.Tag := AIdx - 1;
      Result.AddAs('CHECK', 1, ftInteger, SizeOf(Integer));
    end
    else
      Result.AddAs('CHECK', 0, ftInteger, SizeOf(Integer))
  else
    if (aPk = Result.FieldByName['INDEX'].AsInteger) then
      Result.FieldByName['CHECK'].AsInteger := 1
    else
      Result.FieldByName['CHECK'].AsInteger := 0;
end;

procedure TfmEditOS.vtHistoricsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node   = nil then exit;
  Data     := Sender.GetNodeData(Node);
  if (Data  = nil) or (Data^.DataRow = nil) then exit;
  if Data^.DataRow.Count > Column then
    CellText := Data^.DataRow.Fields[Column].AsString;
end;

procedure TfmEditOS.eDta_IniChange(Sender: TObject);
begin
  if (DBMode in LOADING_MODE) then exit;
  ChangeGlobal(Self);
  ServiceOrder.DtaIni := eDta_Ini.Date;
end;

procedure TfmEditOS.eDta_FinChange(Sender: TObject);
begin
  if (DBMode in LOADING_MODE) then exit;
  ChangeGlobal(Self);
  ServiceOrder.DtaFin := eDta_Fin.Date;
end;

procedure TfmEditOS.lTitleClick(Sender: TObject);
begin
  FDebug := not FDebug;
  if FDebug then
    ShowMessage('Debug Ativo. Bãããããããããhhh !')
  else
    ShowMessage('Debug Inativo. Bãããããããããhhh !')
end;

procedure TfmEditOS.eDsc_OrdChange(Sender: TObject);
begin
  if (DBMode in LOADING_MODE) then exit;
  ChangeGlobal(Sender);
  ServiceOrder.DscOrd := eDsc_Ord.Text;
end;

procedure TfmEditOS.sbSaveClick(Sender: TObject);
var
  aItem: THistoric;
begin
  aItem := nil;
  sbInsert.Enabled := True;
  if eDsc_Hist.Tag = -1 then
    aItem := FServiceOrder.Historics.Add
  else
    if (eDsc_Hist.Tag >= 0) and (eDsc_Hist.Tag < FServiceOrder.Historics.Count) then
      aItem := FServiceOrder.Historics.Items[eDsc_Hist.Tag];
  if aItem = nil then exit;
  aItem.DscHist  := eDsc_Hist.Text;
  aItem.DtHrHist := Now;
  aItem.FkStatusOS := FServiceOrder.FkStatusOS;
  sbSave.Enabled := False;
  if (aItem <> nil) then
    if (eDsc_Hist.Tag = -1) then
      GetDataToGrid(vtHistorics, gtHistorics, aItem.Index, -1)
    else
      GetDataToGrid(vtHistorics, gtHistorics, aItem.Index, -1, False);
end;

procedure TfmEditOS.sbInsertClick(Sender: TObject);
begin
  sbInsert.Tag := -9;
  eDsc_Hist.Text := '';
  eDsc_Hist.Tag  := -1;
  lbMessage.Items.Clear;
  sbInsert.Enabled := False;
  sbSave.Enabled := True;
end;

procedure TfmEditOS.vtProductsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Node.CheckType  := ctRadioButton;
  Node.CheckState := csUncheckedNormal;
  Data            := Sender.GetNodeData(Node);
  if (Data  = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FindField['CHECK'] <> nil)          and
     (Data^.DataRow.FieldByName['CHECK'].AsInteger > 0) then
    Node.CheckState := csCheckedNormal
end;

procedure TfmEditOS.vtProductsChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
  i, j: Integer;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FindField['INDEX'] <> nil) and
     (Data^.DataRow.FindField['CHECK'] <> nil) then
  begin
    ChangeGlobal(Sender);
    sbSave.Enabled := (dbMode <> dbmBrowse);
    Data^.DataRow.FieldByName['CHECK'].AsInteger := 1;
    j := Data^.DataRow.FieldByName['INDEX'].AsInteger;
    i := eDsc_Hist.Tag;
    if (i >= 0) then
    begin
      FServiceOrder.Historics.Items[i].SeqIns      := 0;
      FServiceOrder.Historics.Items[i].ServiceItem := j;
      DisplayHistoric(FServiceOrder.Historics.Items[i]);
    end;
    eItemVinc.Value := j;
  end;
end;

procedure TfmEditOS.eDsc_HistChange(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if vtHistorics.RootNodeCount = 0 then
    sbInsert.Tag   := -9;
  sbInsert.Enabled := False;
  sbSave.Enabled   := True;
end;

procedure TfmEditOS.vtHistoricsChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
begin
  Allowed := (not sbSave.Enabled);
end;

procedure TfmEditOS.vtHistoricsFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
  i, j: Integer;
begin
  if Node   = nil then exit;
  Data     := Sender.GetNodeData(Node);
  if (Data  = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.UserData <> nil) and (Data^.DataRow.UserData is THistoric) then
  begin
    DisplayHistoric(THistoric(Data^.DataRow.UserData));
    pgItems.ActivePageIndex := 0;
    ReleaseTreeNodes(vtInsumos);
    ReleaseTreeNodes(vtProducts);
    vtProducts.Tag := -1;
    for i := 0 to ServiceOrder.ServiceOrderItems.Count - 1 do
      GetDataToGrid(vtProducts, gtItems, i, -1);
    if (THistoric(Data^.DataRow.UserData).SeqIns > 0) then
    begin
      j := vtProducts.Tag;
      with FServiceOrder.ServiceOrderItems.Items[j] do
        for i := 0 to FkInsumos.Count - 1 do
          GetDataToGrid(vtInsumos, gtInsumos, j, i);
    end;
  end;
end;

procedure TfmEditOS.vtHistoricsFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  Allowed := (not sbSave.Enabled);
end;

procedure TfmEditOs.DisplayHistoric(AHistoric: THistoric);
var
  StrAux: string;
begin
  sbInsert.Tag := AHistoric.Index;
  lbMessage.Clear;
  StrAux := DateTimeToStr(AHistoric.DtHrHist);
  if AHistoric.ServiceItem > 0 then
    StrAux := StrAux + ' - Ítem: ' + IntToStr(AHistoric.ServiceItem);
  if AHistoric.SeqIns > 0 then
    StrAux := StrAux + ' - Seq.: ' + IntToStr(AHistoric.SeqIns);
  lbMessage.Items.Add(StrAux);
  lbMessage.Items.Add(AHistoric.DscHist);
  eDsc_Hist.OnChange := nil;
  eDsc_Hist.Text := AHistoric.DscHist;
  eDsc_Hist.Tag  := AHistoric.Index;
  eDsc_Hist.OnChange := eDsc_HistChange;
  if AHistoric.FkStatusOS <> nil then
  begin
    StrAux := 'Status ==> ' + AHistoric.FkStatusOS.DscStt;
    lbMessage.Items.Add(StrAux);
  end;
  if AHistoric.CodAut > 0 then
  begin
    StrAux := 'Autorização ==> ' + IntToStr(AHistoric.CodAut) +
              ' / ' + AHistoric.DscCad;
    lbMessage.Items.Add(StrAux);
  end;
end;

procedure TfmEditOS.eItemVincChange(Sender: TObject);
var
  i: Integer;
begin
  if (dbMode <> dbmBrowse) then ChangeGlobal(Sender);
  if (pgItems.ActivePageIndex > 0) or
     ((Trunc(eItemVinc.Value) -1) > FServiceOrder.ServiceOrderItems.Count) then
    exit;
  ReleaseTreeNodes(vtInsumos);
  with FServiceOrder.ServiceOrderItems.Items[Trunc(eItemVinc.Value) - 1] do
    for i := 0 to FkInsumos.Count - 1 do
      GetDataToGrid(vtInsumos, gtInsumos, Trunc(eItemVinc.Value) -1, i);
  pgItems.ActivePageIndex := 1;
end;

procedure TfmEditOS.pgItemsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (vtInsumos.RootNodeCount > 0);
end;

procedure TfmEditOS.vtInsumosChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
  i, j: Integer;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FindField['INDEX'] <> nil) and
     (Data^.DataRow.FindField['CHECK'] <> nil) then
  begin
    ChangeGlobal(Sender);
    sbSave.Enabled := (dbMode <> dbmBrowse);
    Data^.DataRow.FieldByName['CHECK'].AsInteger := 1;
    j := Data^.DataRow.FieldByName['INDEX'].AsInteger;
    i := eDsc_Hist.Tag;
    if (i >= 0) then
    begin
      FServiceOrder.Historics.Items[i].SeqIns := j;
      DisplayHistoric(FServiceOrder.Historics.Items[i]);
    end;
    eItemVinc.OnChange := nil;
    eItemVinc.Value := j;
    eItemVinc.OnChange := eItemVincChange;
  end;
end;

end.
