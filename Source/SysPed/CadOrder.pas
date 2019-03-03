unit CadOrder;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created  : 02/06/2003                                                 *}
{* Modified : 30/05/2006                                                 *}
{* Version  : 1.5.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, StdCtrls, ComCtrls, ToolWin, ExtCtrls, CurrEdit, Mask,
  ToolEdit, Buttons, GridRow, TSysPedAux, TSysPed, PrcCombo, mSysPed, TSysCad,
  TSysEstqAux, ProcUtils, Menus, CadModel;

type
  TOrderFormClass = class of TfrmModel;

  TOrderScreen  =  (osPedItem, osPedMsg, osPedHist, osPedVinc, osPedEntr, osPedExp, osInstallments);
  TOrderScreens = set of TOrderScreen;

  PDsctRecord = ^TDsctRecord;
  TDsctRecord = record
    Node : PVirtualNode;
    Data : TDiscount;
    Index: Integer;
  end;

  TCdOrder = class(TfrmModel)
    cbStatus: TCoolBar;
    tbTools: TToolBar;
    tbCancel: TToolButton;
    tbInsert: TToolButton;
    tbTooSep: TToolButton;
    tbSave: TToolButton;
    ToolButton1: TToolButton;
    tbSelScreen: TToolButton;
    lFlag_TPed: TLabel;
    eFlag_TPed: TComboBox;
    pgOrders: TPageControl;
    tsPedidos: TTabSheet;
    tsHistorics: TTabSheet;
    pOrderHeader: TPanel;
    lFk_Grupos_Movimentos: TStaticText;
    lFk_Cadastros: TStaticText;
    lFk_Ordens_Compra: TStaticText;
    lFk_Tabela_Precos: TStaticText;
    eDta_Ped: TDateEdit;
    lDta_Ped: TStaticText;
    ePk_Pedidos: TCurrencyEdit;
    lPk_Pedidos: TStaticText;
    eFk_Grupos_Movimentos: TComboBox;
    eFk_Cadastros: TComboBox;
    eFk_Tabela_Precos: TComboBox;
    eFk_Ordens_Compra: TComboBox;
    pItems: TPanel;
    pgFooter: TPageControl;
    tsOrder: TTabSheet;
    lFk_Tipo_Descontos: TStaticText;
    lDsp_Aces: TStaticText;
    eDsp_Aces: TCurrencyEdit;
    eVlr_Entr: TCurrencyEdit;
    lVlr_Entr: TStaticText;
    pgValues: TPageControl;
    tsValues: TTabSheet;
    lSub_Tot: TStaticText;
    eSub_Tot: TCurrencyEdit;
    eVlr_Acr_Dsct: TCurrencyEdit;
    lVlr_Acr_Dsct: TStaticText;
    lTot_Ped: TStaticText;
    eTot_Ped: TCurrencyEdit;
    tsList: TTabSheet;
    vtDiscounts: TVirtualStringTree;
    tsDiscounts: TTabSheet;
    sbSaveDsct: TSpeedButton;
    sbNewDsct: TSpeedButton;
    stTypeDiscounts: TStaticText;
    eTypeDiscounts: TComboBox;
    lVlr_Dsct: TStaticText;
    eIdx_Dsct: TCurrencyEdit;
    lDsc_Dsct: TStaticText;
    eDsc_Dsct: TEdit;
    lFlag_Dstq: TCheckBox;
    eFk_Tipo_Descontos: TComboBox;
    tsVendor: TTabSheet;
    sbShowInstallments: TSpeedButton;
    lFk_Vw_Vendedores: TStaticText;
    lFk_Tipo_Prazo_Entrega: TStaticText;
    lFlag_DtaBas: TStaticText;
    eFk_Vw_Vendedores: TComboBox;
    eFk_Tipo_Prazo_Entrega: TComboBox;
    eFlag_DtaBas: TComboBox;
    pgPgtos: TPageControl;
    tsNormal: TTabSheet;
    eCom_Vda: TCurrencyEdit;
    lCom_Vda: TStaticText;
    lFlag_CPrvE: TCheckBox;
    lFlag_Vinc_Ped: TCheckBox;
    tsPgtos: TTabSheet;
    lDta_Bas: TStaticText;
    eDta_Bas: TDateEdit;
    lNum_Extr: TStaticText;
    eNum_Extr: TEdit;
    tsPack: TTabSheet;
    lFk_Vw_Transportadoras: TStaticText;
    lVlr_Fret: TStaticText;
    eVlr_Fre: TCurrencyEdit;
    lQtd_Vol: TStaticText;
    eQtd_Vol: TCurrencyEdit;
    ePes_Liq: TCurrencyEdit;
    lPes_Liq: TStaticText;
    lPes_Bru: TStaticText;
    ePes_Bru: TCurrencyEdit;
    lNum_Vol: TStaticText;
    eNum_Vol: TCurrencyEdit;
    eVlr_Seg: TCurrencyEdit;
    lVlr_Seg: TStaticText;
    lFlag_EDrt_Rdsp: TCheckBox;
    lFlag_Entr_Parc: TCheckBox;
    lDta_Entr: TStaticText;
    eDta_Entr: TDateEdit;
    eTipo_Vol: TEdit;
    lTipo_Vol: TStaticText;
    lMes_Prev_Entr: TStaticText;
    eMes_Prev_Entr: TCurrencyEdit;
    eAno_Prev_Entr: TCurrencyEdit;
    eFk_Vw_Transportadoras: TComboBox;
    tsTaxes: TTabSheet;
    lBas_ICMS: TStaticText;
    lVlr_ICMS: TStaticText;
    lBas_ICMSS: TStaticText;
    lVlr_ICMSS: TStaticText;
    lBas_ISS: TStaticText;
    lVlr_ISS: TStaticText;
    lBas_IPI: TStaticText;
    lVlr_IPI: TStaticText;
    lBas_Otr: TStaticText;
    lVlr_Otr: TStaticText;
    eBas_ICMS: TCurrencyEdit;
    eVlr_ICMS: TCurrencyEdit;
    eBas_ICMSS: TCurrencyEdit;
    eVlr_ICMSS: TCurrencyEdit;
    eVlr_IPI: TCurrencyEdit;
    eBas_IPI: TCurrencyEdit;
    eVlr_ISS: TCurrencyEdit;
    eBas_ISS: TCurrencyEdit;
    eBas_Otr: TCurrencyEdit;
    eVlr_Otr: TCurrencyEdit;
    tsExport: TTabSheet;
    tsVincPed: TTabSheet;
    tsDelivery: TTabSheet;
    tsMessages: TTabSheet;
    lFk_Tipo_Status_Pedidos: TStaticText;
    eFk_Tipo_Status_Pedidos: TComboBox;
    lFk_Tipo_Pagamentos: TStaticText;
    lFk_Finalizadoras: TStaticText;
    eFk_Finalizadoras: TComboBox;
    eFk_Tipo_Pagamentos: TComboBox;
    pmDiscounts: TPopupMenu;
    pmExit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure eFlag_TPedSelect(Sender: TObject);
    procedure eFk_Grupos_MovimentosSelect(Sender: TObject);
    procedure eFk_CadastrosSelect(Sender: TObject);
    procedure lFlag_Vinc_PedClick(Sender: TObject);
    procedure lFlag_EDrt_RdspClick(Sender: TObject);
    procedure sbShowInstallmentsClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbSelScreenClick(Sender: TObject);
    procedure eFk_Tabela_PrecosSelect(Sender: TObject);
    procedure eFk_Tipo_PagamentosSelect(Sender: TObject);
    procedure eFlag_DtaBasSelect(Sender: TObject);
    procedure eNum_ExtrChange(Sender: TObject);
    procedure eDta_EntrChange(Sender: TObject);
    procedure vtDiscountsDblClick(Sender: TObject);
    procedure vtDiscountsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtDiscountsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eTypeDiscountsSelect(Sender: TObject);
    procedure sbSaveDsctClick(Sender: TObject);
    procedure pmExitClick(Sender: TObject);
    procedure lVlr_Acr_DsctClick(Sender: TObject);
    procedure sbNewDsctClick(Sender: TObject);
  private
    { Private declarations }
    FDefaultRecord: TDefaultRecord;
    FCreating     : Boolean;
    FMultiCompany : Boolean;
    FOrderTypes   : TOrderTypes;
    FActiveOrder  : TOrder;
    function  GetActiveOrder: TOrder;
    function  GetAnoPrevEntr: Integer;
    function  GetComVda: Double;
    function  GetDsctNode: PVirtualNode;
    function  GetDspAces: Double;
    function  GetDtaBas: TDate;
    function  GetDtaEntr: TDate;
    function  GetDtaPed: TDate;
    function  GetFkCarrier: Integer;
    function  GetFkDeliveryPeriod: Integer;
    function  GetFkMovement: TMovement;
    function  GetFkOrderStatus: TOrderStatus;
    function  GetFkOwner: TOwner;
    function  GetFkPaymentWay: TPaymentWay;
    function  GetFkPriceTable: TPriceTable;
    function  GetFkPurchaseOrder: Integer;
    function  GetFkTypeDiscount: TTypeDiscount;
    function  GetFkTypePayment: TTypePayment;
    function  GetFkVendor: TOwner;
    function  GetFlagCPrvE: Boolean;
    function  GetFlagDtaBas: TBaseDate;
    function  GetFlagEDrtRdsp: Boolean;
    function  GetFlagEntrParc: Boolean;
    function  GetFlagTPed: TOrderType;
    function  GetFlagVincPed: Boolean;
    function  GetMesPrevEntr: Integer;
    function  GetNumExtr: string;
    function  GetNumVol: Integer;
    function  GetPesBru: Double;
    function  GetPesLiq: Double;
    function  GetPkPedidos: Integer;
    function  GetQtdVol: Integer;
    function  GetSubTot: Double;
    function  GetTotPed: Double;
    function  GetTypeVol: string;
    function  GetVlrAcrDsct: Double;
    function  GetVlrEntr: Double;
    function  GetVlrFre: Double;
    function  GetVlrSeg: Double;
    procedure ChangeState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure ChangeItem(Sender: TOrder; AItem: TOrderItem;
                AState: TDBMode = dbmInsert);
    procedure DeleteItem(Sender: TOrder; AItem: TOrderItem;
                AState: TDBMode = dbmInsert);
    procedure LoadDiscounts(const APk: Integer);
    procedure LoadFinalizers(const AFkTPgto: Integer);
    procedure LoadMovement(const APk: Integer);
    procedure LoadOrderPayment(const APk: Integer);
    procedure LoadOwners;
    procedure LoadPurchaseOrders;
    procedure LoadStatusType(const APk: Integer);
    procedure LoadVendors;
    procedure SetActiveOrder(const Value: TOrder);
    procedure SetAnoPrevEntr(const Value: Integer);
    procedure SetBasICMS(const Value: Double);
    procedure SetBasICMSS(const Value: Double);
    procedure SetBasIPI(const Value: Double);
    procedure SetBasISS(const Value: Double);
    procedure SetBasOTR(const Value: Double);
    procedure SetComVda(const Value: Double);
    procedure SetDspAces(const Value: Double);
    procedure SetDtaBas(const Value: TDate);
    procedure SetDtaEntr(const Value: TDate);
    procedure SetDtaPed(const Value: TDate);
    procedure SetFkCarrier(const Value: Integer);
    procedure SetFkDeliveryPeriod(const Value: Integer);
    procedure SetFkMovement(const Value: TMovement);
    procedure SetFkOrderStatus(const Value: TOrderStatus);
    procedure SetFkOwner(const Value: TOwner);
    procedure SetFkPaymentWay(const Value: TPaymentWay);
    procedure SetFkPriceTable(const Value: TPriceTable);
    procedure SetFkPurchaseOrder(const Value: Integer);
    procedure SetFkTypeDiscount(const Value: TTypeDiscount);
    procedure SetFkTypePayment(const Value: TTypePayment);
    procedure SetFkVendor(const Value: TOwner);
    procedure SetFlagCPrvE(const Value: Boolean);
    procedure SetFlagDtaBas(const Value: TBaseDate);
    procedure SetFlagEDrtRdsp(const Value: Boolean);
    procedure SetFlagEntrParc(const Value: Boolean);
    procedure SetFlagTPed(const Value: TOrderType);
    procedure SetFlagVincPed(const Value: Boolean);
    procedure SetMesPrevEntr(const Value: Integer);
    procedure SetNumExtr(const Value: string);
    procedure SetNumVol(const Value: Integer);
    procedure SetOrderTypes(const Value: TOrderTypes);
    procedure SetOwnerData;
    procedure SetPesBru(const Value: Double);
    procedure SetPesLiq(const Value: Double);
    procedure SetPkPedidos(const Value: Integer);
    procedure SetQtdVol(const Value: Integer);
    procedure SetSubTot(const Value: Double);
    procedure SetTotPed(const Value: Double);
    procedure SetTypeVol(const Value: string);
    procedure SetVlrAcrDsct(const Value: Double);
    procedure SetVlrEntr(const Value: Double);
    procedure SetVlrFre(const Value: Double);
    procedure SetVlrICMS(const Value: Double);
    procedure SetVlrICMSS(const Value: Double);
    procedure SetVlrIPI(const Value: Double);
    procedure SetVlrISS(const Value: Double);
    procedure SetVlrOTR(const Value: Double);
    procedure SetVlrSeg(const Value: Double);
    procedure AddAllDsctIntoGrid;
    procedure UpdateAllScreens;
    procedure ClearValuesData;
    procedure MoveValuesData(AData: PDsctRecord);
    procedure ChangePk(Sender: TObject);
  protected
    { Protected declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  ActiveOrder     : TOrder        read GetActiveOrder      write SetActiveOrder;
    property  AnoPrevEntr     : Integer       read GetAnoPrevEntr      write SetAnoPrevEntr;
    property  BasICMS         : Double                                 write SetBasICMS;
    property  BasICMSS        : Double                                 write SetBasICMSS;
    property  BasISS          : Double                                 write SetBasISS;
    property  BasIPI          : Double                                 write SetBasIPI;
    property  BasOTR          : Double                                 write SetBasOTR;
    property  ComVda          : Double        read GetComVda           write SetComVda;
    property  Creating        : Boolean       read FCreating           write FCreating;
    property  DsctNode        : PVirtualNode  read GetDsctNode;
    property  DspAces         : Double        read GetDspAces          write SetDspAces;
    property  DtaBas          : TDate         read GetDtaBas           write SetDtaBas;
    property  DtaEntr         : TDate         read GetDtaEntr          write SetDtaEntr;
    property  DtaPed          : TDate         read GetDtaPed           write SetDtaPed;
    property  FkDeliveryPeriod: Integer       read GetFkDeliveryPeriod write SetFkDeliveryPeriod;
    property  FkMovement      : TMovement     read GetFkMovement       write SetFkMovement;
    property  FkCarrier       : Integer       read GetFkCarrier        write SetFkCarrier;
    property  FkOwner         : TOwner        read GetFkOwner          write SetFkOwner;
    property  FkPaymentWay    : TPaymentWay   read GetFkPaymentWay     write SetFkPaymentWay;
    property  FkPriceTable    : TPriceTable   read GetFkPriceTable     write SetFkPriceTable;
    property  FkPurchaseOrder : Integer       read GetFkPurchaseOrder  write SetFkPurchaseOrder;
    property  FkStatusOrder   : TOrderStatus  read GetFkOrderStatus    write SetFkOrderStatus;
    property  FkTypeDiscount  : TTypeDiscount read GetFkTypeDiscount   write SetFkTypeDiscount;
    property  FkTypePayment   : TTypePayment  read GetFkTypePayment    write SetFkTypePayment;
    property  FkVendor        : TOwner        read GetFkVendor         write SetFkVendor;
    property  FlagCPrvE       : Boolean       read GetFlagCPrvE        write SetFlagCPrvE;
    property  FlagDtaBas      : TBaseDate     read GetFlagDtaBas       write SetFlagDtaBas default bdInvoice;
    property  FlagEDrtRdsp    : Boolean       read GetFlagEDrtRdsp     write SetFlagEDrtRdsp;
    property  FlagEntrParc    : Boolean       read GetFlagEntrParc     write SetFlagEntrParc;
    property  FlagTPed        : TOrderType    read GetFlagTPed         write SetFlagTPed;
    property  FlagVincPed     : Boolean       read GetFlagVincPed      write SetFlagVincPed;
    property  MesPrevEntr     : Integer       read GetMesPrevEntr      write SetMesPrevEntr;
    property  NumExtr         : string        read GetNumExtr          write SetNumExtr;
    property  NumVol          : Integer       read GetNumVol           write SetNumVol;
    property  PesBru          : Double        read GetPesBru           write SetPesBru;
    property  PesLiq          : Double        read GetPesLiq           write SetPesLiq;
    property  PkPedidos       : Integer       read GetPkPedidos        write SetPkPedidos;
    property  QtdVol          : Integer       read GetQtdVol           write SetQtdVol;
    property  SubTot          : Double        read GetSubTot           write SetSubTot;
    property  TotPed          : Double        read GetTotPed           write SetTotPed;
    property  TypeVol         : string        read GetTypeVol          write SetTypeVol;
    property  VlrAcrDsct      : Double        read GetVlrAcrDsct       write SetVlrAcrDsct;
    property  VlrEntr         : Double        read GetVlrEntr          write SetVlrEntr;
    property  VlrFre          : Double        read GetVlrFre           write SetVlrFre;
    property  VlrICMS         : Double                                 write SetVlrICMS;
    property  VlrICMSS        : Double                                 write SetVlrICMSS;
    property  VlrISS          : Double                                 write SetVlrISS;
    property  VlrIPI          : Double                                 write SetVlrIPI;
    property  VlrOTR          : Double                                 write SetVlrOTR;
    property  VlrSeg          : Double        read GetVlrSeg           write SetVlrSeg;
  published
    { Published declarations }
    property  OrderTypes    : TOrderTypes read FOrderTypes     write SetOrderTypes;
    property  MultiCompany  : Boolean     read FMultiCompany   write FMultiCompany;
  end;

var
  CdOrder: TCdOrder;

implementation

uses Dado, CadPedItem, CadPedVinc, CadPedEntr, Funcoes, FuncoesDB, DateUtils,
  CadPedMsg, CadPedExp, CadPedHst, CadInstlm, TypInfo;

{$R *.dfm}

{ TCdOrder }

var
  OrderFormClass: array [TOrderScreen] of TOrderFormClass =
    (TCdPedItem, TCdPedMsg, TCdOrdersHist, TCdPedVinc, TCdPedEntr, TCdPedExp, TCdInstallments);
  OrderScreenParent: array [TOrderScreen] of string =
    ('pItems', 'tsMessages', 'tsHistorics', 'tsVincPed', 'tsDelivery', 'tsExport', 'tsPgtos');

function TCdOrder.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  C: TControl;
  S: string;
begin
  C := nil;
  S := '';
  Result := True;
  if (DtaPed = 0) then
  begin
    C := eDta_Ped;
    S := 'Campo data do pedido deve ser preenchido';
  end;
  if (DtaPed = 0) then
  begin
    C := eDta_Ped;
    S := 'Campo data do pedido deve ser preenchido';
  end;
  if (FkMovement = nil) then
  begin
    C := eFk_Grupos_Movimentos;
    S := 'Campo tipo de movimentos deve ser preenchido';
  end;
  if (FkOwner = nil) then
  begin
    C := eFk_Cadastros;
    if (FlagTPed = otPurchaseOrder) then
      S := 'Campo fornecedor deve ser preenchido'
    else
      S := 'Campo cliente deve ser preenchido';
  end;
  if (FkTypePayment <> nil) and (DtaBas < DtaPed) then
  begin
    C := eDta_Bas;
    S := 'Campo data base deve ser preenchido';
  end;
  if (FkTypePayment <> nil) and (FkTypePayment.FlagTVda <> tsCash) and
     (FkPaymentWay <> nil) then
  begin
    C := eFk_Finalizadoras;
    S := 'Campo forma de pagamento deve ser preenchido para a condição de pagamento escolhida';
  end;
  if (FkStatusOrder = nil) then
  begin
    C := eFk_Tipo_Status_Pedidos;
    S := 'Campo satus do pedido deve ser preenchido';
  end;
  if (FlagTPed <> otPurchaseOrder) and (FkPriceTable = nil) then
  begin
    C := eFk_Tabela_Precos;
    S := 'Campo tabela de preços deve ser preenchido';
  end;
  if (TotPed <= 0) then
  begin
    C := eTot_Ped;
    S := 'O pedido deve conter pelo menos um ítem';
  end;
  if (C <> nil) and (S <> '') then
  begin
    Dados.DisplayHint(C, S, hiError);
    Result := False;
  end;
end;

procedure TCdOrder.ClearControls;
var
  aMov: TMovement;
  aStt: TOrderStatus;
begin
  aStt := TOrderStatus.Create;
  aMov := TMovement.Create;
  Loading := True;
  try
    aMov.PkGroupMovement := FDefaultRecord.FkGroupMov;
    aMov.PkTypeMovement  := FDefaultRecord.FkTypeMov;
    aStt.PkOrderStatus   := FDefaultRecord.StatusOrder;
    FlagTPed             := FDefaultRecord.FlagTPed;
    DtaPed               := Date;
    FkDeliveryPeriod     := FDefaultRecord.TypeDelivery;
    FkMovement           := aMov;
    FkStatusOrder        := aStt;
    FkTypePayment        := nil;
    FkPriceTable         := nil;
    FkOwner              := nil;
    AnoPrevEntr          := 0;
    BasICMS              := 0.0;
    BasICMSS             := 0.0;
    BasISS               := 0.0;
    BasIPI               := 0.0;
    BasOTR               := 0.0;
    ComVda               := 0.0;
    DspAces              := 0.0;
    DtaBas               := 0;
    DtaEntr              := 0;
    FkCarrier            := 0;
    FkPaymentWay         := nil;
    FkPurchaseOrder      := 0;
    FkTypeDiscount       := nil;
    FkVendor             := nil;
    FlagCPrvE            := False;
    FlagDtaBas           := bdInvoice;
    FlagEDrtRdsp         := False;
    FlagEntrParc         := False;
    FlagVincPed          := False;
    MesPrevEntr          := 0;
    NumExtr              := '';
    NumVol               := 0;
    PesBru               := 0.0;
    PesLiq               := 0.0;
    PkPedidos            := 0;
    QtdVol               := 0;
    SubTot               := 0.0;
    TotPed               := 0.0;
    TypeVol              := '';
    VlrAcrDsct           := 0.0;
    VlrEntr              := 0.0;
    VlrFre               := 0.0;
    VlrICMS              := 0.0;
    VlrICMSS             := 0.0;
    VlrISS               := 0.0;
    VlrIPI               := 0.0;
    VlrOTR               := 0.0;
    VlrSeg               := 0.0;
  finally
    Loading := False;
    FreeAndNil(aMov);
    FreeAndNil(aStt);
  end;
end;

function TCdOrder.GetActiveOrder: TOrder;
var
 aDay: Integer;
begin
  Result := TOrder.Create(Dados.DecimalPlaces);
  Result.Loading := True;
  try
    Result.AnoPrevEntr           := AnoPrevEntr;
    Result.DspAces               := DspAces;
    Result.DtaBas                := DtaBas;
    Result.DtaEntr               := DtaEntr;
    Result.DtaPed                := DtaPed;
    Result.FkDeliveryPeriod      := FkDeliveryPeriod;
    Result.FkMovement            := FkMovement;
    Result.FkCarrier.PkCadastros := FkCarrier;
    Result.FkOwner               := FkOwner;
    Result.FkPaymentWay          := FkPaymentWay;
    Result.FkPriceTable          := FkPriceTable;
    Result.FkPurchaseOrder       := FkPurchaseOrder;
    Result.FkOrderStatus         := FkStatusOrder;
    Result.FkTypeDiscount        := FkTypeDiscount;
    Result.FkTypePayment         := FkTypePayment;
    Result.FkVendor              := FkVendor;
    Result.FlagCPrvE             := FlagCPrvE;
    Result.FlagDtaBas            := FlagDtaBas;
    Result.FlagEntrParc          := FlagEntrParc;
    Result.FlagTPed              := FlagTPed;
    Result.MesPrevEntr           := MesPrevEntr;
    Result.NumExtr               := NumExtr;
    Result.NumVol                := NumVol;
    Result.PesBru                := PesBru;
    Result.PesLiq                := PesLiq;
    Result.PkOrder               := PkPedidos;
    Result.QtdVol                := QtdVol;
    Result.TipoVol               := TypeVol;
    Result.VlrEntr               := VlrEntr;
    Result.VlrFret               := VlrFre;
    Result.VlrSeg                := VlrSeg;
    if (Result.DtaEntr = 0) and (Result.AnoPrevEntr > 0) and
       (Result.MesPrevEntr > 0) then
    begin
      aDay := 1;
      if (Result.MesPrevEntr = Integer(MonthOf(Result.DtaPed))) then aDay := 15;
      Result.DtaEntr := EncodeDate(Result.AnoPrevEntr,
        Result.MesPrevEntr, 1) + aDay;
      if (Result.DtaEntr < Result.DtaPed) then
        IncMonth(Result.DtaEntr);
    end;
//    Result.SubTot                := SubTot;
//    Result.VlrAcrDsct            := VlrAcrDsct;
//    Result.TotPed                := TotPed;
//    Result.ComVda                := ComVda;
//    Result.FlagVincPed           := FlagVincPed;
//    Result.FlagEDrtRdsp          := FlagEDrtRdsp;
    Result.FkTypePayment.Installments.Clear;
    if (Result.DtaBas = 0) then
    begin
      Result.DtaBas := ActiveOrder.DtaPed;
      if (Result.FlagDtaBas in [bdInvoice, bdDelivery, bdTyped]) then
        Result.DtaBas := Result.DtaEntr;
    end;
    if (Result.FkTypePayment.PkTypePgto > 0) and
       (Result.FkTypePayment.FlagTVda > tsCash) then
      Result.FkTypePayment.CreatePayments(Result.TotPed, Result.DtaBas);
    if (tsMessages.Tag > 0) and (TCdPedMsg(tsMessages.Tag).QtdMsg > 0) then
      Result.OrderMessages := TCdPedMsg(tsMessages.Tag).OrderMessages;
    if (tsDelivery.Tag > 0) and (TCdPedEntr(tsDelivery.Tag).EndEntr.Text <> '') then
    begin
      Result.UfEntr  := TCdPedEntr(tsDelivery.Tag).UfEntr;
      Result.MunEntr := TCdPedEntr(tsDelivery.Tag).MunEntr;
      Result.EndEntr := TCdPedEntr(tsDelivery.Tag).EndEntr;
    end;
    if (tsExport.Tag > 0) and (TCdPedExp(tsExport.Tag).NumProForma > 0) then
    begin
      Result.FkAgent.PkCadastros := TCdPedExp(tsExport.Tag).FkVwAgent;
      Result.FkPortoEmb          := TCdPedExp(tsExport.Tag).FkPortosEmb;
      Result.FkPortoDst          := TCdPedExp(tsExport.Tag).FkPortosDst;
      Result.NumProForma         := TCdPedExp(tsExport.Tag).NumProForma;
    end;
    if (tsHistorics.Tag > 0) and
       (TCdOrdersHist(tsHistorics.Tag).ActiveOrder.OrderHistorics.Count > 0) then
      Result.OrderHistorics := TCdOrdersHist(tsHistorics.Tag).ActiveOrder.OrderHistorics;
//  if (Assigned(CdPedVinc)) then
//    ActiveOrder.OrderLinks := CdPedItem.OrderLinks;
  if (MultiCompany) and (Result.OrderItems.Count > 0) then
  begin
    Result.SortCompany(0, Result.OrderItems.Count - 1);
    if (pItems.Tag > 0) and (TCdPedItem(pItems.Tag).OrderItems.Count > 0) then
      Result.OrderItems := TCdPedItem(pItems.Tag).OrderItems;
  end;
  finally
    Result.Loading := False;
  end;
  FActiveOrder := Result;
end;

function TCdOrder.GetAnoPrevEntr: Integer;
begin
  Result := eAno_Prev_Entr.AsInteger;
end;

function TCdOrder.GetComVda: Double;
begin
  Result := eCom_Vda.Value;
end;

function TCdOrder.GetDsctNode: PVirtualNode;
begin
  Result := vtDiscounts.FocusedNode;
end;

function TCdOrder.GetDspAces: Double;
begin
  Result := eDsp_Aces.Value;
end;

function TCdOrder.GetDtaBas: TDate;
begin
  Result := eDta_Bas.Date;
end;

function TCdOrder.GetDtaEntr: TDate;
begin
  Result := eDta_Entr.Date;
end;

function TCdOrder.GetDtaPed: TDate;
begin
  Result := eDta_Ped.Date;
end;

function TCdOrder.GetFkCarrier: Integer;
begin
  Result := 0;
  with eFk_Vw_Transportadoras do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= Integer(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkDeliveryPeriod: Integer;
begin
  Result := 0;
  with eFk_Tipo_Prazo_Entrega do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= Integer(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkMovement: TMovement;
begin
  Result := nil;
  with eFk_Grupos_Movimentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= TMovement(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkOrderStatus: TOrderStatus;
begin
  Result := nil;
  with eFk_Tipo_Status_Pedidos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= TOrderStatus(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkOwner: TOwner;
begin
  Result := nil;
  with eFk_Cadastros do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= TOwner(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkPaymentWay: TPaymentWay;
begin
  Result := nil;
  with eFk_Finalizadoras do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= TPaymentWay(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkPriceTable: TPriceTable;
begin
  Result := nil;
  with eFk_Tabela_Precos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= TPriceTable(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkPurchaseOrder: Integer;
begin
  Result := 0;
  with eFk_Ordens_Compra do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= Integer(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkTypeDiscount: TTypeDiscount;
begin
  Result := nil;
  with eFk_Tipo_Descontos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= TTypeDiscount(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkTypePayment: TTypePayment;
begin
  Result := nil;
  with eFk_Tipo_Pagamentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= TTypePayment(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFkVendor: TOwner;
begin
  Result := nil;
  with eFk_Vw_Vendedores do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result:= TOwner(Items.Objects[ItemIndex]);
end;

function TCdOrder.GetFlagCPrvE: Boolean;
begin
  Result := lFlag_CPrvE.Checked;
end;

function TCdOrder.GetFlagDtaBas: TBaseDate;
begin
  Result := bdInvoice;
  if (eFlag_DtaBas.ItemIndex > -1) then
    Result := TBaseDate(eFlag_DtaBas.ItemIndex);
end;

function TCdOrder.GetFlagEDrtRdsp: Boolean;
begin
  Result := lFlag_EDrt_Rdsp.Checked;
end;

function TCdOrder.GetFlagEntrParc: Boolean;
begin
  Result := lFlag_Entr_Parc.Checked;
end;

function TCdOrder.GetFlagTPed: TOrderType;
begin
  if (otPurchaseOrder in OrderTypes) then
    Result := otPurchaseOrder
  else
    Result := otBudget;
  if (eFlag_TPed.ItemIndex > -1) then
    Result := TOrderType(eFlag_TPed.ItemIndex);
end;

function TCdOrder.GetFlagVincPed: Boolean;
begin
  Result := lFlag_Vinc_Ped.Checked;
end;

function TCdOrder.GetMesPrevEntr: Integer;
begin
  Result := eMes_Prev_Entr.AsInteger;
end;

function TCdOrder.GetNumExtr: string;
begin
  Result := eNum_Extr.Text;
end;

function TCdOrder.GetNumVol: Integer;
begin
  Result := eNum_Vol.AsInteger;
end;

function TCdOrder.GetPesBru: Double;
begin
  Result := ePes_Bru.Value;
end;

function TCdOrder.GetPesLiq: Double;
begin
  Result := ePes_Liq.Value;
end;

function TCdOrder.GetPkPedidos: Integer;
begin
  Result := ePk_Pedidos.AsInteger;
end;

function TCdOrder.GetQtdVol: Integer;
begin
  Result := eQtd_Vol.AsInteger;
end;

function TCdOrder.GetSubTot: Double;
begin
  Result := eSub_Tot.Value;
end;

function TCdOrder.GetTotPed: Double;
begin
  Result := eTot_Ped.Value;
end;

function TCdOrder.GetTypeVol: string;
begin
  Result := eTipo_Vol.Text;
end;

function TCdOrder.GetVlrAcrDsct: Double;
begin
  Result := eVlr_Acr_Dsct.Value;
end;

function TCdOrder.GetVlrEntr: Double;
begin
  Result := eVlr_Entr.Value;
end;

function TCdOrder.GetVlrFre: Double;
begin
  Result := eVlr_Fre.Value;
end;

function TCdOrder.GetVlrSeg: Double;
begin
  Result := eVlr_Seg.Value;
end;

procedure TCdOrder.LoadDefaults;
var
  i: TBaseDate;
const
  S_BASE_DATE: array [bdInvoice..bdTyped] of string =
    ('Data do Faturamento', 'Data do Pedido', 'Data da Entrega', 'Data Informada');
begin
  if (not ListLoaded) then
  begin
    eFk_Vw_Transportadoras.Items.AddStrings(dmSysPed.LoadCarrier);
    eFk_Tipo_Prazo_Entrega.Items.AddStrings(dmSysPed.LoadTypeDelivery);
    for i := bdInvoice to bdTyped do
      eFlag_DtaBas.Items.AddObject(S_BASE_DATE[i], TObject(Integer(i)));
    if (not (otPurchaseOrder in OrderTypes)) then
      eFk_Tabela_Precos.Items.AddStrings(dmSysPed.LoadTabPrices);
    ListLoaded := False;
  end;
  lFk_Ordens_Compra.Visible       := (otPurchaseOrder in OrderTypes);
  eFk_Ordens_Compra.Visible       := (otPurchaseOrder in OrderTypes);
end;

procedure TCdOrder.MoveDataToControls;
begin
  if (Pk > 0) then
    ActiveOrder := dmSysPed.Order[Pk];
end;

procedure TCdOrder.SaveIntoDB;
begin
  dmSysPed.Order[Pk] := ActiveOrder;
end;

procedure TCdOrder.SetActiveOrder(const Value: TOrder);
begin
  Loading := True;
  try
    AnoPrevEntr      := Value.AnoPrevEntr;
    BasICMS          := Value.BasIcms;
    BasICMSS         := Value.BasIcmss;
    BasISS           := Value.BasISS;
    BasIPI           := Value.BasIpi;
    BasOTR           := Value.BasOtr;
    ComVda           := Value.ComVda;
    DspAces          := Value.DspAces;
    DtaBas           := Value.DtaBas;
    DtaEntr          := Value.DtaEntr;
    DtaPed           := Value.DtaPed;
    FkDeliveryPeriod := Value.FkDeliveryPeriod;
    FkMovement       := Value.FkMovement;
    FkCarrier        := Value.FkCarrier.PkCadastros;
    FkOwner          := Value.FkOwner;
    FkPaymentWay     := Value.FkPaymentWay;
    FkPriceTable     := Value.FkPriceTable;
    FkPurchaseOrder  := Value.FkPurchaseOrder;
    FkStatusOrder    := Value.FkOrderStatus;
    FkTypeDiscount   := Value.FkTypeDiscount;
    FkTypePayment    := Value.FkTypePayment;
    FkVendor         := Value.FkVendor;
    FlagCPrvE        := Value.FlagCPrvE;
    FlagDtaBas       := Value.FlagDtaBas;
    FlagEDrtRdsp     := Value.FlagEDrtRdsp;
    FlagEntrParc     := Value.FlagEntrParc;
    FlagTPed         := Value.FlagTPed;
    FlagVincPed      := Value.FlagVincPed;
    MesPrevEntr      := Value.MesPrevEntr;
    NumExtr          := Value.NumExtr;
    NumVol           := Value.NumVol;
    PesBru           := Value.PesBru;
    PesLiq           := Value.PesLiq;
    PkPedidos        := Value.PkOrder;
    QtdVol           := Value.QtdVol;
    SubTot           := Value.SubTot;
    TotPed           := Value.TotPed;
    TypeVol          := Value.TipoVol;
    VlrAcrDsct       := Value.VlrAcrDsct;
    VlrEntr          := Value.VlrEntr;
    VlrFre           := Value.VlrFret;
    VlrICMS          := Value.VlrIcms;
    VlrICMSS         := Value.VlrIcmss;
    VlrISS           := Value.VlrISS;
    VlrIPI           := Value.VlrIpi;
    VlrOTR           := Value.VlrOtr;
    VlrSeg           := Value.VlrSeg;
  finally
    Loading := False;
  end;
end;

procedure TCdOrder.SetAnoPrevEntr(const Value: Integer);
begin
  eAno_Prev_Entr.AsInteger := Value;
end;

procedure TCdOrder.SetBasICMS(const Value: Double);
begin
  eBas_ICMS.Value := Value;
end;

procedure TCdOrder.SetBasICMSS(const Value: Double);
begin
  eBas_ICMSS.Value := Value;
end;

procedure TCdOrder.SetBasIPI(const Value: Double);
begin
  eBas_IPI.Value := Value;
end;

procedure TCdOrder.SetBasISS(const Value: Double);
begin
  eBas_ISS.Value := Value;
end;

procedure TCdOrder.SetBasOTR(const Value: Double);
begin
  eBas_Otr.Value := Value;
end;

procedure TCdOrder.SetComVda(const Value: Double);
begin
  eCom_Vda.Value := Value;
end;

procedure TCdOrder.SetDspAces(const Value: Double);
begin
  eDsp_Aces.Value := Value;
end;

procedure TCdOrder.SetDtaBas(const Value: TDate);
begin
  eDta_Bas.Date := Value;
end;

procedure TCdOrder.SetDtaEntr(const Value: TDate);
begin
  eDta_Entr.Date := Value;
end;

procedure TCdOrder.SetDtaPed(const Value: TDate);
begin
  eDta_Ped.Date := Value;
end;

procedure TCdOrder.SetFkCarrier(const Value: Integer);
var
 i: Integer;
begin
  with eFk_Vw_Transportadoras do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0
    else
      ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := Value;
        break;
      end;
  end;
end;

procedure TCdOrder.SetFkDeliveryPeriod(const Value: Integer);
var
 i: Integer;
begin
  with eFk_Tipo_Prazo_Entrega do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0
    else
      ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := Value;
        break;
      end;
  end;
end;

procedure TCdOrder.SetFkMovement(const Value: TMovement);
var
 i: Integer;
begin
  with eFk_Grupos_Movimentos do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0
    else
      ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Value <> nil) and
         (TMovement(Items.Objects[i]).PkGroupMovement = Value.PkGroupMovement) and
         (TMovement(Items.Objects[i]).PkTypeMovement = Value.PkTypeMovement) then
      begin
        ItemIndex := i;
        eFk_Grupos_MovimentosSelect(eFk_Grupos_Movimentos);
        break;
      end;
  end;
end;

procedure TCdOrder.SetFkOrderStatus(const Value: TOrderStatus);
var
 i: Integer;
begin
  with eFk_Tipo_Status_Pedidos do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0
    else
      ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Value <> nil) and
         (TOrderStatus(Items.Objects[i]).PkOrderStatus = Value.PkOrderStatus) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdOrder.SetFkOwner(const Value: TOwner);
var
 i: Integer;
begin
  with eFk_Cadastros do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0
    else
      ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Value <> nil) and
         (TOwner(Items.Objects[i]).PkCadastros = Value.PkCadastros) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdOrder.SetFkPaymentWay(const Value: TPaymentWay);
var
 i: Integer;
begin
  with eFk_Finalizadoras do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0
    else
      ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Value <> nil) and
         (TPaymentWay(Items.Objects[i]).PkPaymentWay = Value.PkPaymentWay) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdOrder.SetFkPriceTable(const Value: TPriceTable);
var
 i, j: Integer;
begin
  with eFk_Tabela_Precos do
  begin
    if (Items.Count > 0) then
      j := 0
    else
      j := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Value <> nil) and
         (TPriceTable(Items.Objects[i]).PkPriceTable = Value.PkPriceTable) then
      begin
        j := i;
        break;
      end;
      if (Items.Objects[i] <> nil) and ((j = -1) or (j = 0)) and
         (TPriceTable(Items.Objects[i]).FlagDefTab) then
        j := i;
    end;
    ItemIndex := j;
  end;
end;

procedure TCdOrder.SetFkPurchaseOrder(const Value: Integer);
var
 i: Integer;
begin
  with eFk_Ordens_Compra do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0
    else
      ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdOrder.SetFkTypeDiscount(const Value: TTypeDiscount);
var
 i: Integer;
begin
  with eFk_Tipo_Descontos do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0
    else
      ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Value <> nil) and
         (TTypeDiscount(Items.Objects[i]).PkTypeDiscount = Value.PkTypeDiscount) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdOrder.SetFkTypePayment(const Value: TTypePayment);
var
  i, j: Integer;
begin
  with eFk_Tipo_Pagamentos do
  begin
    if (Items.Count > 0) then
      j := 0
    else
      j := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Value <> nil) and
         (TTypePayment(Items.Objects[i]).PkTypePgto = Value.PkTypePgto) then
      begin
        j := i;
        break;
      end;
      if (Items.Objects[i] <> nil) and ((j = -1) or (j = 0)) and
         (TTypePayment(Items.Objects[i]).FlagTVda = tsCash) then
        j := i;
    end;
    ItemIndex := j;
    eFk_Tipo_PagamentosSelect(eFk_Tipo_Pagamentos);
  end;
end;

procedure TCdOrder.SetFkVendor(const Value: TOwner);
var
 i: Integer;
begin
  with eFk_Vw_Vendedores do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0
    else
      ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Value <> nil) and
         (TOwner(Items.Objects[i]).PkCadastros = Value.PkCadastros) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdOrder.SetFlagCPrvE(const Value: Boolean);
begin
  lFlag_CPrvE.Checked := Value;
end;

procedure TCdOrder.SetFlagDtaBas(const Value: TBaseDate);
begin
  eFlag_DtaBas.ItemIndex := Ord(Value);
end;

procedure TCdOrder.SetFlagEDrtRdsp(const Value: Boolean);
begin
  lFlag_EDrt_Rdsp.Checked := Value;
end;

procedure TCdOrder.SetFlagEntrParc(const Value: Boolean);
begin
  lFlag_Entr_Parc.Checked := Value;
end;

procedure TCdOrder.SetFlagTPed(const Value: TOrderType);
var
  aError: Boolean;
  aPkGrp: Integer;
begin
  aError := (Ord(Value) < 0) and (Ord(Value) >= eFlag_TPed.Items.Count);
  if (not aError) then aError := (not (Value in OrderTypes));
  if (aError) then exit;
  if (eFlag_TPed.ItemIndex <> Ord(Value)) then
  begin
    eFlag_TPed.ItemIndex := Ord(Value);
    LoadMovement(0);
    if (FkMovement = nil) then
      aPkGrp := FDefaultRecord.FkGroupMov
    else
      aPkGrp := FkMovement.PkGroupMovement;
    LoadOwners;
    LoadStatusType(aPkGrp);
    LoadDiscounts(aPkGrp);
    LoadOrderPayment(aPkGrp);
    if (not (otPurchaseOrder in OrderTypes)) then
      LoadVendors;
    lFk_Grupos_Movimentos.Enabled   := (aPkGrp > 0);
    eFk_Grupos_Movimentos.Enabled   := (aPkGrp > 0);
    lFk_Cadastros.Enabled           := (aPkGrp > 0);
    eFk_Cadastros.Enabled           := (aPkGrp > 0);
    lFk_Tipo_Pagamentos.Enabled     := (aPkGrp > 0);
    eFk_Tipo_Pagamentos.Enabled     := (aPkGrp > 0);
    lFk_Tipo_Descontos.Enabled      := (aPkGrp > 0);
    eFk_Tipo_Descontos.Enabled      := (aPkGrp > 0);
    lFk_Tipo_Status_Pedidos.Enabled := (aPkGrp > 0);
    eFk_Tipo_Status_Pedidos.Enabled := (aPkGrp > 0);
    lFk_Tabela_Precos.Enabled       := (aPkGrp > 0);
    eFk_Tabela_Precos.Enabled       := (aPkGrp > 0);
  end;
end;

procedure TCdOrder.SetFlagVincPed(const Value: Boolean);
begin
  lFlag_Vinc_Ped.Checked := Value;
end;

procedure TCdOrder.SetMesPrevEntr(const Value: Integer);
begin
  eMes_Prev_Entr.AsInteger := Value;
end;

procedure TCdOrder.SetNumExtr(const Value: string);
begin
  eNum_Extr.Text := Value;
end;

procedure TCdOrder.SetNumVol(const Value: Integer);
begin
  eNum_Vol.AsInteger := Value;
end;

procedure TCdOrder.SetOrderTypes(const Value: TOrderTypes);
begin
  eFlag_TPed.Clear;
  eFlag_TPed.Items.AddStrings(OrderTypesDescr(Value));
  FOrderTypes := Value;
  if (pItems.Tag > 0) then
    TCdPedItem(pItems.Tag).OrderTypes := OrderTypes;
end;

procedure TCdOrder.SetPesBru(const Value: Double);
begin
  ePes_Bru.Value := Value;
end;

procedure TCdOrder.SetPesLiq(const Value: Double);
begin
  ePes_Liq.Value := Value;
end;

procedure TCdOrder.SetPkPedidos(const Value: Integer);
begin
  ePk_Pedidos.AsInteger := Value;
end;

procedure TCdOrder.SetQtdVol(const Value: Integer);
begin
  eQtd_Vol.AsInteger := Value;
end;

procedure TCdOrder.SetSubTot(const Value: Double);
begin
  eSub_Tot.Value := Value;
end;

procedure TCdOrder.SetTotPed(const Value: Double);
begin
  eTot_Ped.Value := Value;
end;

procedure TCdOrder.SetTypeVol(const Value: string);
begin
  eTipo_Vol.Text := Value;
end;

procedure TCdOrder.SetVlrAcrDsct(const Value: Double);
begin
  eVlr_Acr_Dsct.Value := Value;
end;

procedure TCdOrder.SetVlrEntr(const Value: Double);
begin
  eVlr_Entr.Value := Value;
end;

procedure TCdOrder.SetVlrFre(const Value: Double);
begin
  eVlr_Fre.Value := Value;
end;

procedure TCdOrder.SetVlrICMS(const Value: Double);
begin
  eVlr_ICMS.Value := Value;
end;

procedure TCdOrder.SetVlrICMSS(const Value: Double);
begin
  eVlr_ICMSS.Value := Value;
end;

procedure TCdOrder.SetVlrIPI(const Value: Double);
begin
  eVlr_IPI.Value := Value;
end;

procedure TCdOrder.SetVlrISS(const Value: Double);
begin
  eVlr_ISS.Value := Value;
end;

procedure TCdOrder.SetVlrOTR(const Value: Double);
begin
  eVlr_Otr.Value := Value;
end;

procedure TCdOrder.SetVlrSeg(const Value: Double);
begin
  eVlr_Seg.Value := Value;
end;

procedure TCdOrder.FormCreate(Sender: TObject);
begin
  vtDiscounts.NodeDataSize      := SizeOf(TDsctRecord);
  vtDiscounts.Images            := Dados.Image16;
  vtDiscounts.Header.Images     := Dados.Image16;
  cbStatus.Images               := Dados.Image16;
  tbTools.Images                := Dados.Image16;
  pgValues.ActivePageIndex      := 0;
  pgFooter.ActivePageIndex      := 0;
  FActiveOrder                  := TOrder.Create(Dados.DecimalPlaces);
  with Dados do // Formating all fields to display correct values with mask of decimal places
  begin
    eVlr_Entr.DecimalPlaces     := DecimalPlaces;
    eVlr_Entr.DisplayFormat     := CurrMask;
    eDsp_Aces.DecimalPlaces     := DecimalPlaces;
    eDsp_Aces.DisplayFormat     := CurrMask;
    eSub_Tot.DecimalPlaces      := DecimalPlaces;
    eSub_Tot.DisplayFormat      := CurrMask;
    eVlr_Acr_Dsct.DecimalPlaces := DecimalPlaces;
    eVlr_Acr_Dsct.DisplayFormat := CurrMask;
    eTot_Ped.DecimalPlaces      := DecimalPlaces;
    eTot_Ped.DisplayFormat      := CurrMask;
    eCom_Vda.DecimalPlaces      := DecimalPlaces;
    eCom_Vda.DisplayFormat      := NumMask;
    ePes_Liq.DecimalPlaces      := DecimalPlaces;
    ePes_Liq.DisplayFormat      := NumMask;
    ePes_Bru.DecimalPlaces      := DecimalPlaces;
    ePes_Bru.DisplayFormat      := NumMask;
    eVlr_Fre.DecimalPlaces      := DecimalPlaces;
    eVlr_Fre.DisplayFormat      := CurrMask;
    eVlr_Seg.DecimalPlaces      := DecimalPlaces;
    eVlr_Seg.DisplayFormat      := CurrMask;
    eBas_ICMS.DecimalPlaces     := DecimalPlaces;
    eBas_ICMS.DisplayFormat     := CurrMask;
    eBas_ICMSS.DecimalPlaces    := DecimalPlaces;
    eBas_ICMSS.DisplayFormat    := CurrMask;
    eBas_ISS.DecimalPlaces      := DecimalPlaces;
    eBas_ISS.DisplayFormat      := CurrMask;
    eBas_IPI.DecimalPlaces      := DecimalPlaces;
    eBas_IPI.DisplayFormat      := CurrMask;
    eBas_Otr.DecimalPlaces      := DecimalPlaces;
    eBas_Otr.DisplayFormat      := CurrMask;
    eVlr_ICMS.DecimalPlaces     := DecimalPlaces;
    eVlr_ICMS.DisplayFormat     := CurrMask;
    eVlr_ICMSS.DecimalPlaces    := DecimalPlaces;
    eVlr_ICMSS.DisplayFormat    := CurrMask;
    eVlr_ISS.DecimalPlaces      := DecimalPlaces;
    eVlr_ISS.DisplayFormat      := CurrMask;
    eVlr_IPI.DecimalPlaces      := DecimalPlaces;
    eVlr_IPI.DisplayFormat      := CurrMask;
    eVlr_Otr.DecimalPlaces      := DecimalPlaces;
    eVlr_Otr.DisplayFormat      := CurrMask;
  end;
  inherited;
  dmSysPed.LoadParamsOrders(FDefaultRecord);
  FActiveOrder.FlagItmDsct      :=  FDefaultRecord.FlagItmDsct;
  OnInternalState               := ChangeState;
  OnChangePk                    := ChangePk;
  OnCheckRecord                 := CheckRecord;
end;

procedure TCdOrder.FormDestroy(Sender: TObject);
var
  i: TOrderScreen;
  aForm: TfrmModel;
  {$IFNDEF LINUX}
    aComp: TWinControl;
  {$ELSE}
    aComp: TWidgetControl;
  {$ENDIF}
begin
  for i := Low(TOrderScreen) to High(TOrderScreen) do
  begin
    {$IFNDEF LINUX}
      aComp := FindComponent(OrderScreenParent[i]) as TWinControl;
    {$ELSE}
      aComp := FindComponent(OrderScreenParent[i]) as TWidgetControl;
    {$ENDIF}
    if (aComp <> nil) and (aComp.Tag = 0) then
    begin
      aForm := TfrmModel(aComp.Tag);
      FreeAndNil(aForm);
    end;
  end;
  FreeAndNil(FActiveOrder);
  inherited;
end;

procedure TCdOrder.FormShow(Sender: TObject);
var
  i: TOrderScreen;
  aForm: TfrmModel;
  {$IFNDEF LINUX}
    aComp: TWinControl;
  {$ELSE}
    aComp: TWidgetControl;
  {$ENDIF}
begin
  for i := Low(TOrderScreen) to High(TOrderScreen) do
  begin
    {$IFNDEF LINUX}
      aComp := FindComponent(OrderScreenParent[i]) as TWinControl;
    {$ELSE}
      aComp := FindComponent(OrderScreenParent[i]) as TWidgetControl;
    {$ENDIF}
    if (aComp <> nil) and (aComp.Tag = 0) then
    begin
      aForm                   := OrderFormClass[i].Create(Application);
      aForm.Parent            := aComp;
      aForm.Align             := alClient;
      aForm.OnChangeState     := ChangeState;
      aComp.Tag               := Integer(aForm);
      if (i = osPedItem) then
      begin
        TCdPedItem(aForm).OnChangeItem := ChangeItem;
        TCdPedItem(aForm).OnDeleteItem := DeleteItem;
        TCdPedItem(aForm).OnCancel     := tbCancelClick;
      end;
    end
    else
      if (aComp <> nil) then
        aForm := TfrmModel(aComp.Tag)
      else
        aForm := nil;
    if (aForm <> nil) and (aComp.Visible) then
      aForm.Show
  end;
end;

procedure TCdOrder.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmCancel;
  ScrState := dbmBrowse;
end;

procedure TCdOrder.tbInsertClick(Sender: TObject);
begin
  ActiveOrder.Clear;
  ActiveOrder.PkOrder := 0;
  Pk := 0;
  ScrState := dbmInsert;
end;

procedure TCdOrder.eFlag_TPedSelect(Sender: TObject);
begin
  ChangeGlobal(eFlag_TPed);
  FlagTPed := GetFlagTPed;
end;

procedure TCdOrder.LoadDiscounts(const APk: Integer);
begin
  ReleaseCombos(eFk_Tipo_Descontos, toObject);
  eFk_Tipo_Descontos.Items.AddStrings(dmSysPed.LoadDiscounts(APk));
end;

procedure TCdOrder.LoadFinalizers(const AFkTPgto: Integer);
begin
  eFk_Finalizadoras.Enabled := (AFkTPgto > 0);
  if (eFk_Finalizadoras.Enabled) then
  begin
    ReleaseCombos(eFk_Finalizadoras, toObject);
    eFk_Finalizadoras.Items.AddStrings(dmSysPed.LoadFinalizers(AFkTPgto));
  end;
end;

procedure TCdOrder.LoadMovement(const APk: Integer);
var
  aMv: TMovement;
begin
  ReleaseCombos(eFk_Grupos_Movimentos, toObject);
  with eFk_Grupos_Movimentos do
  begin
    Items.AddStrings(dmSysPed.LoadMovement(OrderTypes, APk));
    aMv := TMovement.Create;
    try
      aMv.PkGroupMovement := FDefaultRecord.FkGroupMov;
      aMv.PkTypeMovement  := FDefaultRecord.FkTypeMov;
      FkMovement          := aMv;
    finally
      FreeAndNil(aMv);
    end;
  end;
end;

procedure TCdOrder.LoadOrderPayment(const APk: Integer);
var
  i: Integer;
begin
  ReleaseCombos(eFk_Tipo_Pagamentos, toObject);
  with eFk_Tipo_Pagamentos do
  begin
    Items.AddStrings(dmSysPed.LoadTypePayment(APk));
    if (Pk = 0) then
    begin
      for i := 0 to Items.Count - 1 do
        if (Items.Objects[i] <> nil) and
           (TTypePayment(Items.Objects[i]).FlagTVda = tsCash) then
        begin
          ItemIndex := i;
          LoadFinalizers(TTypePayment(Items.Objects[i]).PkTypePgto);
          break;
        end;
    end;
  end;
end;

procedure TCdOrder.LoadStatusType(const APk: Integer);
var
  i: Integer;
begin
  ReleaseCombos(eFk_Tipo_Status_Pedidos, toObject);
  with eFk_Tipo_Status_Pedidos do
  begin
    Items.AddStrings(dmSysPed.LoadStatusType(APk));
    if (Pk = 0) then
    begin
      for i := 0 to Items.Count - 1 do
        if (Items.Objects[i] <> nil) and
           (TOrderStatus(Items.Objects[i]).PkOrderStatus = FDefaultRecord.StatusOrder) then
        begin
          ItemIndex := i;
          break;
        end;
    end;
  end;
end;

procedure TCdOrder.LoadVendors;
begin
  ReleaseCombos(eFk_Vw_Vendedores, toObject);
  eFk_Vw_Vendedores.Items.AddStrings(dmSysPed.LoadVendors(False));
end;

procedure TCdOrder.eFk_Grupos_MovimentosSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (FkMovement <> nil) then
  begin
    if (pItems.Tag > 0) then
    begin
      TCdPedItem(pItems.Tag).TpMovID  := FkMovement.PkTypeMovement;
      TCdPedItem(pItems.Tag).GrMovID  := FkMovement.PkGroupMovement;
      TCdPedItem(pItems.Tag).TypeVol  := 0;
      TCdPedItem(pItems.Tag).TypeCode := Byte(FkMovement.FlagCod);
    end;
    if (tsHistorics.Tag > 0) then
      TCdOrdersHist(tsHistorics.Tag).GrMovID  := FkMovement.PkGroupMovement;
  end;
end;

procedure TCdOrder.eFk_CadastrosSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  SetOwnerData;
  if (otPurchaseOrder in OrderTypes) then
    LoadPurchaseOrders;
end;

procedure TCdOrder.SetOwnerData;
begin
  if (FkStatusOrder <> nil) and (FkOwner <> nil) then
  begin
    Loading := True;
    if (FlagTPed = otPurchaseOrder) then
    begin
      if (FkOwner.Supplier.FkTypePayment.PkTypePgto > 0) then
        FkTypePayment    := FkOwner.Supplier.FkTypePayment;
//      if (FkOwner.Supplier.FkFinalization > 0) then
//        eFk_Finalizadoras.SetIndexFromObjectValue(FkOwner.Customer.FkFinalization);
      if (FkOwner.Supplier.FkCarrier > 0) then
        FkCarrier        := FkOwner.Supplier.FkCarrier;
      if (FkOwner.Supplier.FkTypeDiscount > 0) then
      begin
        FkOwner.Customer.FkTypeDiscount.PkTypeDiscount := FkOwner.Supplier.FkTypeDiscount;
        FkTypeDiscount   := FkOwner.Customer.FkTypeDiscount;
      end;
//      if (FkOwner.Supplier.FkDeliveryPeriod > 0) then
//        eFk_Tipo_Prazo_Entrega.SetIndexFromObjectValue(FkOwner.Supplier.FkDeliveryPeriod);
//      FlagDtaBas := FKOwner.Supplier.FlagDtaBas;
    end
    else
    begin
      if (FkOwner.Customer.FkTypePayment.PkTypePgto > 0) then
        FkTypePayment    := FkOwner.Customer.FkTypePayment;
      if (FkOwner.Customer.FkPaymentWay.PkPaymentWay > 0) then
        FkPaymentWay     := FkOwner.Customer.FkPaymentWay;
      if (FkOwner.Customer.FkPriceTable.PkPriceTable > 0) then
        FkPriceTable     := FkOwner.Customer.FkPriceTable;
      if (FkOwner.Customer.FkCarrier > 0) then
        FkCarrier        := FkOwner.Customer.FkCarrier;
      if (FkOwner.Customer.FkTypeDiscount.PkTypeDiscount > 0) then
        FkTypeDiscount   := FkOwner.Customer.FkTypeDiscount;
      if (FkOwner.Customer.FkDeliveryPeriod > 0) then
        FkDeliveryPeriod := FkOwner.Customer.FkDeliveryPeriod;
      FlagDtaBas := FKOwner.Customer.FlagDtaBas;
    end;
    with FkOwner.Address.FkCity.FkState.FkCountry do
    begin
     if (PKCountry <> Dados.Parametros.soCompanyCountry) then
      begin
        tsExport.TabVisible := True;
        TfrmModel(tsExport.Tag).Show;
      end;
    end;
    ShowMessage('PItems.Tag = ' + IntToStr(pItems.Tag));
    if (pItems.Tag > 0) then
    begin
      ShowMessage('Movendo dados do cliente para a Itens');
      TCdPedItem(pItems.Tag).OwnerID    := FkOwner.PkCadastros;
      TCdPedItem(pItems.Tag).PriceTabID := FkPriceTable.PkPriceTable;
    end;
    Loading := False;
  end;
end;

procedure TCdOrder.LoadPurchaseOrders;
begin
  ReleaseCombos(eFk_Ordens_Compra, toObject);
  eFk_Ordens_Compra.Visible := (otPurchaseOrder in OrderTypes) and
                               (ActiveOrder.PkOrder > 0) and (FkOwner <> nil);
  lFk_Ordens_Compra.Visible := eFk_Ordens_Compra.Visible;
  if (eFk_Ordens_Compra.Visible) then
    eFk_Ordens_Compra.Items.AddStrings(dmSysPed.LoadPurchaseOrders(FkOwner.PkCadastros));
end;

procedure TCdOrder.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
var
  i: TOrderScreen;
  aForm: TfrmModel;
  {$IFNDEF LINUX}
    aComp: TWinControl;
  {$ELSE}
    aComp: TWidgetControl;
  {$ENDIF}
begin
//  if (ScrState in UPDATE_MODE) and (not (Sender is TCdOrder)) then exit;
  if (not (Sender is TCdOrder)) and (AState = dbmInsert) and (Pk > 0) then
    ScrState  := dbmEdit;
  tbCancel.Enabled := (ScrState in UPDATE_MODE) and (pgOrders.ActivePageIndex = 0);
  tbSave.Enabled   := (ScrState in UPDATE_MODE) and (pgOrders.ActivePageIndex = 0);
  if (pItems.Tag > 0) then
    tbSave.Enabled := (ScrState in UPDATE_MODE) and (pgOrders.ActivePageIndex = 0) and
                      (TCdPedItem(pItems.Tag).vtItems.RootNodeCount > 0);
  tbInsert.Enabled := (ScrState in SCROLL_MODE);
  if (ScrState in UPDATE_MODE) and (not (Sender is TCdOrder)) then exit;
  if (ScrState = dbmInsert) then
    ClearControls;
  for i := Low(TOrderScreen) to High(TOrderScreen) do
  begin
    {$IFNDEF LINUX}
      aComp := FindComponent(OrderScreenParent[i]) as TWinControl;
    {$ELSE}
      aComp := FindComponent(OrderScreenParent[i]) as TWidgetControl;
    {$ENDIF}
//    ShowMessage('ChangeState: Setting ' + OrderScreenParent[i] + ' State to ' + ModeTypes[AScrState]);
    if (aComp <> nil) and (aComp.Tag > 0) then
    begin
      aForm          := TfrmModel(aComp.Tag);
      aForm.ScrState := AState;
    end;
  end;
end;

procedure TCdOrder.lFlag_Vinc_PedClick(Sender: TObject);
var
  aForm: TfrmModel;
begin
  ChangeGlobal(Sender);
  if lFlag_Vinc_Ped.Checked then
  begin
    tsVincPed.TabVisible   := True;
    aForm                  := TfrmModel(tsVincPed.Tag);
    aForm.Show;
    pgFooter.ActivePage    := tsVincPed;
  end
  else
    tsVincPed.TabVisible := False;
end;

procedure TCdOrder.lFlag_EDrt_RdspClick(Sender: TObject);
var
  aForm: TfrmModel;
begin
  if lFlag_EDrt_Rdsp.Checked then
  begin
    tsDelivery.TabVisible  := True;
    aForm                  := TfrmModel(tsDelivery.Tag);
    aForm.Show;
    pgFooter.ActivePage    := tsDelivery;
  end
  else
    tsDelivery.TabVisible := False;
end;

procedure TCdOrder.sbShowInstallmentsClick(Sender: TObject);
var
  aForm: TfrmModel;
begin
  if (pgPgtos.ActivePageIndex = 0) then
  begin
    pgPgtos.ActivePageIndex := 1;
    aForm                   := TfrmModel(tsPgtos.Tag);
    aForm.Show;
  end
  else
    pgPgtos.ActivePageIndex := 0;
  sbShowInstallments.Down := (pgPgtos.ActivePageIndex = 1);
  if sbShowInstallments.Down then
    sbShowInstallments.Caption := 'Ocultar Parcelas'
  else
    sbShowInstallments.Caption := 'Mostrar Parcelas';
end;

procedure TCdOrder.ChangeItem(Sender: TOrder; AItem: TOrderItem;
  AState: TDBMode);
begin
  if (AItem = nil) then exit;
  if (ScrState in UPDATE_MODE) then
  begin
    FActiveOrder := ActiveOrder;
    if (AState = dbmInsert) then
      FActiveOrder.OrderItems.Add.Assign(AItem)
    else
      FActiveOrder.OrderItems.Items[AItem.Index].Assign(AItem);
    SubTot     := FActiveOrder.SubTot;
    VlrAcrDsct := FActiveOrder.VlrAcrDsct;
    TotPed     := FActiveOrder.TotPed;
    SubTot     := FActiveOrder.SubTot;
    VlrAcrDsct := FActiveOrder.VlrAcrDsct;
    TotPed     := FActiveOrder.TotPed;
    BasICMS    := FActiveOrder.BasIcms;
    VlrICMS    := FActiveOrder.VlrIcms;
    BasICMSS   := FActiveOrder.BasIcmss;
    VlrICMSS   := FActiveOrder.VlrIcmss;
    VlrIPI     := FActiveOrder.VlrIpi;
    BasIPI     := FActiveOrder.BasIpi;
    VlrISS     := FActiveOrder.VlrISS;
    BasISS     := FActiveOrder.BasISS;
    BasOtr     := FActiveOrder.BasOtr;
    VlrOtr     := FActiveOrder.VlrOtr;
    if (pItems.Tag > 0) then
      tbSave.Enabled := (ScrState in UPDATE_MODE) and
                        (TCdPedItem(pItems.Tag).vtItems.RootNodeCount > 0);
  end;
end;

procedure TCdOrder.DeleteItem(Sender: TOrder; AItem: TOrderItem;
  AState: TDBMode);
begin
  if (AItem = nil) then exit;
  FActiveOrder := ActiveOrder;
  FActiveOrder.OrderItems.Delete(AItem.Index);
  SubTot     := FActiveOrder.SubTot;
  VlrAcrDsct := FActiveOrder.VlrAcrDsct;
  TotPed     := FActiveOrder.TotPed;
  BasICMS    := FActiveOrder.BasIcms;
  VlrICMS    := FActiveOrder.VlrIcms;
  BasICMSS   := FActiveOrder.BasIcmss;
  VlrICMSS   := FActiveOrder.VlrIcmss;
  VlrIPI     := FActiveOrder.VlrIpi;
  BasIPI     := FActiveOrder.BasIpi;
  VlrISS     := FActiveOrder.VlrISS;
  BasISS     := FActiveOrder.BasISS;
  BasOtr     := FActiveOrder.BasOtr;
  VlrOtr     := FActiveOrder.VlrOtr;
  if (pItems.Tag > 0) then
    tbSave.Enabled := (ScrState in UPDATE_MODE) and
                      (TCdPedItem(pItems.Tag).vtItems.RootNodeCount > 0);
end;

procedure TCdOrder.tbSaveClick(Sender: TObject);
begin
  ScrState := dbmPost;
  ScrState := dbmBrowse;
end;

procedure TCdOrder.tbSelScreenClick(Sender: TObject);
begin
  if (pgOrders.ActivePageIndex = 0) then //and (ActiveOrder.OrderHistorics.Count > 0) then
  begin
    tbCancel.Enabled := False;
    tbInsert.Enabled := False;
    tbSave.Enabled   := False;
    lFk_Tipo_Status_Pedidos.Enabled := False;
    eFk_Tipo_Status_Pedidos.Enabled := False;
    if (tsHistorics.Tag > 0) then
    begin
      TCdOrdersHist(tsHistorics.Tag).ActiveOrder := ActiveOrder;
      pgOrders.ActivePageIndex := 1;
      tbSelScreen.Hint := 'Pedidos | Voltar para a Tela do Pedido';
    end;
  end
  else
  begin
    pgOrders.ActivePageIndex := 0;
    tbSelScreen.Hint := 'Históricos | Mostrar Tela de Históricos do Pedido';
  end;
end;

procedure TCdOrder.eFk_Tabela_PrecosSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (pItems.Tag > 0) then
    TCdPedItem(pItems.Tag).PriceTabID := FkPriceTable.PkPriceTable;
end;

procedure TCdOrder.eFk_Tipo_PagamentosSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (FkTypePayment = nil) then exit;
  if (FkTypePayment.FlagTInt = ipUser) then
    eFk_Tipo_Pagamentos.Visible := False
  else
    eFk_Tipo_Pagamentos.Visible := True;
  sbShowInstallments.Enabled := (FkTypePayment.FlagTVda <> tsCash);
  eFlag_DtaBas.Enabled       := (FkTypePayment.FlagTVda <> tsCash);
  LoadFinalizers(FkTypePayment.PkTypePgto);
end;

procedure TCdOrder.eFlag_DtaBasSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if Loading then exit;
  if (DtaBas = 0) then
  begin
    eDta_Bas.ReadOnly := (FlagDtaBas <> bdTyped);
    if (DtaEntr = 0) then
      DtaEntr         := IncDay(DtaPed, FDefaultRecord.PrzEntr);
    if (FlagDtaBas     = bdDelivery) then
      DtaBas          := DtaEntr
    else
      DtaBas          := DtaPed;
  end;
end;

procedure TCdOrder.eNum_ExtrChange(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (pItems.Tag > 0) then
  begin
    TCdPedItem(pItems.Tag).eNum_Extr.ReadOnly := (NumExtr <> '');
    TCdPedItem(pItems.Tag).NumExtrGen := NumExtr;
  end;
end;

procedure TCdOrder.eDta_EntrChange(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if eDta_Entr.Date > 0 then
  begin
    MesPrevEntr       := MonthOf(eDta_Entr.Date);
    AnoPrevEntr       := YearOf(eDta_Entr.Date);
    UpdateAllScreens;
  end;
end;

procedure TCdOrder.vtDiscountsDblClick(Sender: TObject);
begin
  if (DsctNode = nil) then
    ClearValuesData
  else
    MoveValuesData(vtDiscounts.GetNodeData(DsctNode));
  pgValues.ActivePageIndex := 2;
end;

procedure TCdOrder.vtDiscountsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PDsctRecord;
  StrFmt: string;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.Data = nil) then exit;
  case Data^.Data.FlagTDsct of
    toPercent : if (Data^.Data.IdxDsct < 100) then StrFmt := '00.00 %' else StrFmt := '000.00 %';
    toMultiIdx,
    toDivIdx  : if (Data^.Data.IdxDsct < 10) then StrFmt := '0.0000' else StrFmt := '00.0000';
    toValue   : StrFmt := CurrencyString + ' ###,###,##0.00';
  end;
  case Column of
    0: CellText := S_TYPE_DSCT[Data^.Data.FlagTDsct];
    1: CellText := FormatFloat(StrFmt, Data^.Data.IdxDsct);
    2: CellText := Data^.Data.DscDsct;
  end;
end;

procedure TCdOrder.vtDiscountsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_SPACE) then
    if pgValues.ActivePageIndex = 2 then
      pgValues.ActivePageIndex := 0
    else
      pgValues.ActivePageIndex := pgValues.ActivePageIndex + 1;
end;

procedure TCdOrder.eTypeDiscountsSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  eIdx_Dsct.DecimalPlaces := 4;
  if (TTypeOperation(eTypeDiscounts.ItemIndex) = toValue) then
    eIdx_Dsct.DecimalPlaces := 4;
  case TTypeOperation(eTypeDiscounts.ItemIndex) of
    toPercent : eIdx_Dsct.DisplayFormat := Dados.GetPercentMask(2);
    toMultiIdx: eIdx_Dsct.DisplayFormat := Dados.GetIdxMask;
    toDivIdx  : eIdx_Dsct.DisplayFormat := Dados.GetIdxMask;
    toValue   : eIdx_Dsct.DisplayFormat := Dados.CurrMask;
  end;
end;

procedure TCdOrder.sbSaveDsctClick(Sender: TObject);
var
  aItem: TDiscount;
  Data : PDsctRecord;
begin
  if (eDsc_Dsct.Text = '') then
  begin
    Dados.DisplayHint(eDsc_Dsct, 'Erro: O campo motivo do desconto deve ser informado');
    exit;
  end;
  if (eIdx_Dsct.Value <= 0) then
  begin
    Dados.DisplayHint(eIdx_Dsct, 'Erro: O campo índice do desconto deve ser informado');
    exit;
  end;
  aItem           := nil;
  if (DsctNode = nil) then
    vtDiscounts.FocusedNode := vtDiscounts.AddChild(nil);
  Data          := vtDiscounts.GetNodeData(DsctNode);
  if (Data <> nil) then
  begin
    if (Data^.Data = nil) then
    begin
      Data^.Data  := TDiscount.Create(nil);
      aItem       := FActiveOrder.Discounts.Add;
      Data^.Index := aItem.Index;
      Data^.Node  := DsctNode;
    end
    else
      if (Data^.Index < FActiveOrder.Discounts.Count) then
        aItem       := FActiveOrder.Discounts.Items[Data^.Index];
    if (aItem <> nil) then
    begin
      aItem.FlagTDsct := TTypeOperation(eTypeDiscounts.ItemIndex);
      aItem.FlagDstq  := lFlag_Dstq.Checked;
      aItem.DscDsct   := eDsc_Dsct.Text;
      aItem.IdxDsct   := eIdx_Dsct.Value;
      Data^.Data.Assign(aItem);
    end;
  end;
  VlrAcrDsct := FActiveOrder.VlrAcrDsct;
  TotPed     := FActiveOrder.TotPed;
  pgValues.ActivePageIndex := 0;
end;

procedure TCdOrder.pmExitClick(Sender: TObject);
begin
  pgValues.ActivePageIndex := 0;
end;

procedure TCdOrder.lVlr_Acr_DsctClick(Sender: TObject);
begin
  pgValues.ActivePageIndex := 1;
  if vtDiscounts.CanFocus then vtDiscounts.SetFocus;
  eTypeDiscountsSelect(eTypeDiscounts);
  AddAllDsctIntoGrid;
end;

procedure TCdOrder.AddAllDsctIntoGrid;
var
  Node: PVirtualNode;
  Data: PDsctRecord;
  i   : Integer;
begin
  Node := vtDiscounts.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtDiscounts.GetNodeData(Node);
    if (Data <> nil) and (Data^.Data <> nil) then
      Data^.Data.Free;
    Data^.Data  := nil;
    Data^.Node  := nil;
    Data^.Index := 0;
    Node := vtDiscounts.GetNext(Node);
  end;
  vtDiscounts.Clear;
  for i := 0 to FActiveOrder.Discounts.Count - 1 do
  begin
    Node := vtDiscounts.AddChild(nil);
    if (Node <> nil) then
    begin
      Data := vtDiscounts.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Node := Node;
        Data^.Data := TDiscount.Create(nil);
        Data^.Data.Assign(FActiveOrder.Discounts.Items[i]);
        Data^.Index := i;
      end;
    end;
  end;
end;

procedure TCdOrder.UpdateAllScreens;
begin
  if (tsMessages.Tag > 0) and (TCdPedMsg(tsMessages.Tag).QtdMsg > 0) then
    TCdPedMsg(tsMessages.Tag).ActiveOrder := FActiveOrder;
  if (tsDelivery.Tag > 0) then
  begin
    TCdPedEntr(tsDelivery.Tag).UfEntr  := FActiveOrder.UfEntr;
    TCdPedEntr(tsDelivery.Tag).MunEntr := FActiveOrder.MunEntr;
    TCdPedEntr(tsDelivery.Tag).EndEntr := FActiveOrder.EndEntr;
  end;
{  if (tsExport.Tag > 0) then
  begin
    TCdPedExp(tsExport.Tag).FkVwAgent   := ActiveOrder.FkAgent.PkCadastros;
    TCdPedExp(tsExport.Tag).FkPortosEmb := ActiveOrder.FkPortoEmb;
    TCdPedExp(tsExport.Tag).FkPortosDst := ActiveOrder.FkPortoDst;
    TCdPedExp(tsExport.Tag).NumProForma := ActiveOrder.NumProForma;
  end;
  if (pItems.Tag > 0) then
    TCdPedItem(pItems.Tag).OrderItems := ActiveOrder;
  if (Assigned(CdOrdersHist)) then
    CdOrdersHist.ActiveOrder := ActiveOrder;
  if (Assigned(CdPedVinc)) then
    CdPedItem.OrderLinks := ActiveOrder.OrderLinks;}
end;

procedure TCdOrder.ClearValuesData;
begin
  eTypeDiscounts.ItemIndex := 0;
  lFlag_Dstq.Checked       := True;
  eDsc_Dsct.Text           := '';
  eIdx_Dsct.Value          := 0;
  vtDiscounts.FocusedNode  := nil;
end;

procedure TCdOrder.MoveValuesData(AData: PDsctRecord);
begin
  Loading := True;
  try
    eTypeDiscounts.ItemIndex := Ord(AData^.Data.FlagTDsct);
    lFlag_Dstq.Checked       := AData^.Data.FlagDstq;
    eDsc_Dsct.Text           := AData^.Data.DscDsct;
    eIdx_Dsct.Value          := AData^.Data.IdxDsct;
  finally
    Loading := False;
  end;
end;

procedure TCdOrder.sbNewDsctClick(Sender: TObject);
begin
  ClearValuesData;
end;

procedure TCdOrder.ChangePk(Sender: TObject);
begin
  if (Pk <= 0) then exit;
  pgFooter.ActivePageIndex := 0;
  ScrState                 := dbmBrowse;
end;

procedure TCdOrder.LoadOwners;
begin
  with eFk_Cadastros do
  begin
    ReleaseCombos(eFk_Cadastros, toObject);
    eFk_Cadastros.Items.AddStrings(dmSysPed.LoadOwner(FlagTPed, ''));
    eFk_Cadastros.ItemIndex := 0;
  end;
end;

end.
