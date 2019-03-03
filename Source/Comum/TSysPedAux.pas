unit TSysPedAux;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 22/04/2003 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : (alcindo@sistemaprocessa.com.br)                           *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses SysUtils, Classes, TSysCadAux, TSysFatAux, TSysEstqAux, TSysMan, DateUtils,
    PrcSysTypes, Funcoes, ProcUtils,
    {$IFDEF WIN32} Controls, Graphics, Dialogs {$ENDIF} 
    {$IFDEF LINUX} QControls, QGraphics, QDialogs {$ENDIF};

type

// 0 ==> Data do Pedido
// 1 ==> Data de Faturamento
// 2 ==> Data da Entrega
// 3 ==> Data Informada
  TBaseDate         = (bdInvoice, bdOrder, bdDelivery, bdTyped);
  
// 0 ==> Dias
// 1 ==> Semanas
// 2 ==> Meses
// 3 ==> Anos
// 4 ==> Definida pelo usuário
  TIntervalPay       = (ipDays, ipWeeks, ipMonths, ipYears, ipUser);
  
// 00 ==> Prazos definidos pelo usuário sem lista de Intervalos 
// 01 ==> Lista de prazos inválida 
// 02 ==> Prazo sem definição do intervalo padrão
// 03 ==> Quantidade de prazos da lista diferente da quantidade de Parcelas
// 04 ==> Falta definição da Quantidade de Parcelas
  TCheckErrors = set of (ceNoUserInterval, ceInvalidList, ceNoInterval, 
                         ceDifQtdList, ceNoQtdInstallment); 
  TCheckDataEvent = procedure (Sender: TObject; AError: TCheckErrors) of object;

// 0 ==> Percentual
// 1 ==> MultiIdx
// 2 ==> DivIdx
// 3 ==> Valor
  TTypeOperation     = (toPercent, toMultiIdx, toDivIdx, toValue);

// 0 ==> Entradas
// 1 ==> Saídas
  TInOut             = (ioIn, ioOut);

// 0 ==> Referencia do Produto
// 1 ==> Código do Produto
// 2 ==> Código de Barras
// 3 ==> Código do Fornecedor
  TCodeType          = (ctReference, ctProduct, ctBar, ctSupplier);

// 0 ==> Por conta da Empresa
// 1 ==> Por conta do Fornecedor
// 2 ==> por conta do Transportador
// 3 ==> Por conta do Cliente
  TTypeGuarantee     = (tgNone, tgSupplier, tgTransporter, tgCustomer);

// 0 ==> Estoques
// 1 ==> Cliente
// 2 ==> Fornecedor
// 3 ==> Controle Interno
// 4 ==> Filial
  TOrigimDestination = (odStock, odCustomer, odSupplier, odInternal, odBranch);

// 0 ==> A Vista
// 1 ==> A Prazo
// 2 ==> Acerto Futuro (Carteira)
// 3 ==> Permuta
  TTypeSale          = (tsCash, tsPeriod, tsFuture, tsInReturn);

// 0 ==> Orçamentos
// 1 ==> Pedido Venda Representantes
// 2 ==> Pedido Venda Exportação
// 3 ==> Pedido Venda Filiais
// 4 ==> Pedido Venda Intenet
// 5 ==> Pedido Compra
// 6 ==> Asistências
  TOrderType         = (otBudget, otRepresentant, otExportation, otBranch, 
                        otInternet, otPurchaseOrder, otAssistance, otAll);
  TOrderTypes       = set of TOrderType;

// 0 ==> Aberta (Cadastrada)
// 1 ==> Recebidas
// 2 ==> Liberadas
// 3 ==> Liquidadas
// 3 ==> Canceladas
// 4 ==> Em Produção
// 5 ==> Faturadas
  TOrderStatusType = (osOpened, osReceived, osLiberated, osEliminated, 
                      osCanceled, osProduced, osInvoiced);

//  TOrderStatusTypes = (osSetFree, osReceived, osEliminated, osCanceled,
//                       osToDelivery, osEmmited, osPendency, osInProduction,
//                       osInvoiced);

  TSetStatus     = set of TOrderStatusType;
  
  TTypeFinalization = (fnMoney, fnCheck, fnPreCheck, fnCreditCard, fnDebitCard,
                       fnBankCash, fnBoleto, fnInFuture, fnOperation, fnTicket,
                       fnAll);
                    
  TMovement = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscMov: string;
    FFlagCns: Boolean;
    FFlagCod: TCodeType;
    FFlagDev: Boolean;
    FFlagDspa: Boolean;
    FFlagDsti: TOrigimDestination;
    FFlagES: TInOut;
    FFlagEstq: Boolean;
    FFlagExp: Boolean;
    FFlagGFin: Boolean;
    FFlagGrnt: TTypeGuarantee;
    FFlagLdv: Boolean;
    FFlagOrgm: TOrigimDestination;
    FNatOpeDe: string;
    FNatOpeEx: string;
    FNatOpeFe: string;
    FPkGroupMovement: Integer;
    FPkTypeMovement: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscMov: string read FDscMov write FDscMov;
    property FlagCns: Boolean read FFlagCns write FFlagCns default False;
    property FlagCod: TCodeType read FFlagCod write FFlagCod default 
            ctReference;
    property FlagDev: Boolean read FFlagDev write FFlagDev default False;
    property FlagDspa: Boolean read FFlagDspa write FFlagDspa default False;
    property FlagDsti: TOrigimDestination read FFlagDsti write FFlagDsti 
            default odCustomer;
    property FlagES: TInOut read FFlagES write FFlagES default ioIn;
    property FlagEstq: Boolean read FFlagEstq write FFlagEstq default True;
    property FlagExp: Boolean read FFlagExp write FFlagExp default False;
    property FlagGFin: Boolean read FFlagGFin write FFlagGFin default True;
    property FlagGrnt: TTypeGuarantee read FFlagGrnt write FFlagGrnt default 
            tgNone;
    property FlagLdv: Boolean read FFlagLdv write FFlagLdv default False;
    property FlagOrgm: TOrigimDestination read FFlagOrgm write FFlagOrgm 
            default odStock;
    property NatOpeDe: string read FNatOpeDe write FNatOpeDe;
    property NatOpeEx: string read FNatOpeEx write FNatOpeEx;
    property NatOpeFe: string read FNatOpeFe write FNatOpeFe;
    property PkGroupMovement: Integer read FPkGroupMovement write 
            FPkGroupMovement default 0;
    property PkTypeMovement: Integer read FPkTypeMovement write FPkTypeMovement 
            default 0;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TOrderStatus = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscStt: string;
    FFkMovement: TMovement;
    FFkTipoMovEstq: TTypeMoviment;
    FFkTypeDocument: TTypeDocument;
    FFlagStatus: TSetStatus;
    FPkOrderStatus: Integer;
    FQtdDaysNext: Integer;
    FSeqStt: Byte;
    procedure SetDscStt(AValue: string);
    procedure SetFkMovement(AValue: TMovement);
    procedure SetFkTipoMovEstq(AValue: TTypeMoviment);
    procedure SetFkTypeDocument(AValue: TTypeDocument);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscStt: string read FDscStt write SetDscStt;
    property FkMovement: TMovement read FFkMovement write SetFkMovement;
    property FkTipoMovEstq: TTypeMoviment read FFkTipoMovEstq write 
            SetFkTipoMovEstq;
    property FkTypeDocument: TTypeDocument read FFkTypeDocument write 
            SetFkTypeDocument;
    property FlagStatus: TSetStatus read FFlagStatus write FFlagStatus;
    property PkOrderStatus: Integer read FPkOrderStatus write FPkOrderStatus;
    property QtdDaysNext: Integer read FQtdDaysNext write FQtdDaysNext;
    property SeqStt: Byte read FSeqStt write FSeqStt;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TInstallment = class (TCollectionItem)
  private
    FDtaVenc: TDate;
    FModified: Boolean;
    FOnModified: TNotifyEvent;
    FVlrParc: Double;
    procedure SetDtaVenc(AValue: TDate);
    procedure SetModified(AValue: Boolean);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property DtaVenc: TDate read FDtaVenc write SetDtaVenc;
    property Index;
    property Modified: Boolean read FModified write SetModified default False;
    property OnModified: TNotifyEvent read FOnModified write FOnModified;
    property VlrParc: Double read FVlrParc write FVlrParc;
  end;
  
  TInstallments = class (TCollection)
  private
    FBaseDate: TDate;
    FOwner: TPersistent;
    function GetItems(Index: Integer): TInstallment;
    function GetTotal: Double;
    procedure SetItems(Index: Integer; Value: TInstallment);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TInstallment;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TInstallment;
    property BaseDate: TDate read FBaseDate write FBaseDate;
    property Count;
    property Items[Index: Integer]: TInstallment read GetItems write SetItems;
    property Total: Double read GetTotal;
  end;
  
  TDiscount = class (TCollectionItem)
  private
    FDscDsct: string;
    FFkCategory: TCategory;
    FFkState: TState;
    FFlagDstq: Boolean;
    FFlagTDsct: TTypeOperation;
    FIdxDsct: Double;
    procedure SetDscDsct(AValue: string);
    procedure SetFkCategory(AValue: TCategory);
    procedure SetFkState(AValue: TState);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property Collection;
    property DisplayName;
    property DscDsct: string read FDscDsct write SetDscDsct;
    property FkCategory: TCategory read FFkCategory write SetFkCategory;
    property FkState: TState read FFkState write SetFkState;
    property FlagDstq: Boolean read FFlagDstq write FFlagDstq;
    property FlagTDsct: TTypeOperation read FFlagTDsct write FFlagTDsct default 
            toPercent;
    property IdxDsct: Double read FIdxDsct write FIdxDsct;
    property Index;
  end;
  
  TDiscounts = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TDiscount;
    procedure SetItems(Index: Integer; Value: TDiscount);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TDiscount;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TDiscount;
    property Count;
    property Items[Index: Integer]: TDiscount read GetItems write SetItems;
  end;
  
  TTypeDiscount = class (TPersistent)
  private
    FcbIndex: Integer;
    FDiscounts: TDiscounts;
    FDscDsct: string;
    FFkMovement: TMovement;
    FPkTypeDiscount: Integer;
    procedure SetDiscounts(AValue: TDiscounts);
    procedure SetFkMovement(AValue: TMovement);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property Discounts: TDiscounts read FDiscounts write SetDiscounts;
    property DscDsct: string read FDscDsct write FDscDsct;
    property FkMovement: TMovement read FFkMovement write SetFkMovement;
    property PkTypeDiscount: Integer read FPkTypeDiscount write FPkTypeDiscount 
            default 0;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TPaymentWay = class (TCollectionItem)
  private
    FDscMPgt: string;
    FFlagBnc: Boolean;
    FFlagCli: Boolean;
    FFlagTef: Boolean;
    FFlagTFin: TTypeFinalization;
    FFlagTrc: Boolean;
    FKeyCode: Word;
    FOnAcceptKey: TOnVerifyIDEvent;
    FPkPaymentWay: Integer;
    procedure SetDscMPgt(AValue: string);
    procedure SetKeyCode(AValue: Word);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property DscMPgt: string read FDscMPgt write SetDscMPgt;
    property FlagBnc: Boolean read FFlagBnc write FFlagBnc;
    property FlagCli: Boolean read FFlagCli write FFlagCli;
    property FlagTef: Boolean read FFlagTef write FFlagTef;
    property FlagTFin: TTypeFinalization read FFlagTFin write FFlagTFin default 
            fnMoney;
    property FlagTrc: Boolean read FFlagTrc write FFlagTrc;
    property Index;
    property KeyCode: Word read FKeyCode write SetKeyCode;
    property PkPaymentWay: Integer read FPkPaymentWay write FPkPaymentWay;
  published
    property OnAcceptKey: TOnVerifyIDEvent read FOnAcceptKey write FOnAcceptKey;
  end;
  
  TPaymentWays = class (TCollection)
  private
    FOwner: TPersistent;
    procedure AcceptKeyCode(Sender: TObject; const Value: Integer; var Allowed: 
            Boolean);
    function GetItems(Index: Integer): TPaymentWay;
    procedure SetItems(Index: Integer; AValue: TPaymentWay);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TPaymentWay;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TPaymentWay;
    property Items[Index: Integer]: TPaymentWay read GetItems write SetItems;
  end;
  
  TInterval = class (TCollectionItem)
  private
    FIdxIntrv: Double;
    FOpeIntrv: TTypeOperation;
    FQtdIntrv: Integer;
  protected
    function GetDisplayName: string; override;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property IdxIntrv: Double read FIdxIntrv write FIdxIntrv;
    property Index;
    property OpeIntrv: TTypeOperation read FOpeIntrv write FOpeIntrv default 
            toPercent;
    property QtdIntrv: Integer read FQtdIntrv write FQtdIntrv;
  end;
  
  TIntervals = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TInterval;
    procedure SetItems(Index: Integer; Value: TInterval);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TInterval;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TInterval;
    property Items[Index: Integer]: TInterval read GetItems write SetItems;
  published
    property Count;
  end;
  
  TTypePayment = class (TPersistent)
  private
    FcbIndex: Integer;
    FDocumentValue: Double;
    FDscTPgt: string;
    FDspFin: Double;
    FFkFinanceAccount: Integer;
    FFkGroupMovement: Integer;
    FFlagBaseDate: TBaseDate;
    FFlagBlock: Boolean;
    FFlagTInt: TIntervalPay;
    FFlagTVda: TTypeSale;
    FFlagUTax: Boolean;
    FIntervals: TIntervals;
    FOnCheckData: TCheckDataEvent;
    FPaymentWays: TPaymentWays;
    FPkTypePgto: Integer;
    FQtdParc: Integer;
    procedure SetInstallments(Value: TInstallments);
    procedure SetIntervals(Value: TIntervals);
    procedure SetPaymentWays(AValue: TPaymentWays);
  protected
    FInstallments: TInstallments;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CheckData: TCheckErrors;
    procedure Clear;
    function CreatePayments(AValue: Double; ABaseDate: TDate): Boolean;
    function GetFields: TStrings;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DocumentValue: Double read FDocumentValue write FDocumentValue;
    property DscTPgt: string read FDscTPgt write FDscTPgt;
    property DspFin: Double read FDspFin write FDspFin;
    property FkFinanceAccount: Integer read FFkFinanceAccount write 
            FFkFinanceAccount;
    property FkGroupMovement: Integer read FFkGroupMovement write 
            FFkGroupMovement;
    property FlagBaseDate: TBaseDate read FFlagBaseDate write FFlagBaseDate 
            default bdOrder;
    property FlagBlock: Boolean read FFlagBlock write FFlagBlock;
    property FlagTInt: TIntervalPay read FFlagTInt write FFlagTInt default 
            ipDays;
    property FlagTVda: TTypeSale read FFlagTVda write FFlagTVda default tsCash;
    property FlagUTax: Boolean read FFlagUTax write FFlagUTax;
    property Installments: TInstallments read FInstallments write 
            SetInstallments;
    property Intervals: TIntervals read FIntervals write SetIntervals;
    property OnCheckData: TCheckDataEvent read FOnCheckData write FOnCheckData;
    property PaymentWays: TPaymentWays read FPaymentWays write SetPaymentWays;
    property PkTypePgto: Integer read FPkTypePgto write FPkTypePgto;
    property QtdParc: Integer read FQtdParc write FQtdParc;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  

function OrderTypesDescr(aOrderTypes: TOrderTypes): TStrings;

const
  COLOR_STATUS: array [osOpened..osInvoiced] of TColor =
    (clBlack, clGreen, clBlue, clGray, clGray, clMaroon, clRed);
  S_TYPE_DSCT: array [Low(TTypeOperation)..High(TTypeOperation)] of string =
    ('Percentual', 'Índice Multipl.', 'Índice Divisor', 'Valor');
  ORDER_TYPE_DESCR: array [Low(TOrderType)..High(TOrderType)] of string = 
    ('Vendas/Orçamentos', 'Representantes', 'Exportação', 'Filiais', 'Internet', 
     'Compras', 'Assistência', 'Nenhum');

implementation

function OrderTypesDescr(aOrderTypes: TOrderTypes): TStrings;
var
  i: TOrderType;
begin
  Result := TStringList.Create;
  for i := Low(TOrderType) to High(TOrderType) do
    if (i in aOrderTypes) then
      Result.AddObject(ORDER_TYPE_DESCR[i], TObject(Ord(i)));
end;

{
********************************** TMovement ***********************************
}
constructor TMovement.Create;
begin
  inherited Create;
  Clear;
end;

destructor TMovement.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TMovement.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TMovement) then
  begin
    FDscMov          := TMovement(Source).DscMov;
    FFlagCns         := TMovement(Source).FlagCns;
    FFlagCod         := TMovement(Source).FlagCod;
    FFlagDev         := TMovement(Source).FlagDev;
    FFlagDspa        := TMovement(Source).FlagDspa;
    FFlagDsti        := TMovement(Source).FlagDsti;
    FFlagES          := TMovement(Source).FlagES;
    FFlagEstq        := TMovement(Source).FlagEstq;
    FFlagExp         := TMovement(Source).FlagExp;
    FFlagGFin        := TMovement(Source).FlagGFin;
    FFlagGrnt        := TMovement(Source).FlagGrnt;
    FFlagLdv         := TMovement(Source).FlagLdv;
    FFlagOrgm        := TMovement(Source).FlagOrgm;
    FNatOpeDe        := TMovement(Source).NatOpeDe;
    FNatOpeFe        := TMovement(Source).NatOpeFe;
    FNatOpeEx        := TMovement(Source).NatOpeEx;
    FPkGroupMovement := TMovement(Source).PkGroupMovement;
    FPkTypeMovement  := TMovement(Source).PkTypeMovement;
    FcbIndex         := TMovement(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TMovement.Clear;
begin
  FDscMov          := '';
  FFlagCns         := False;
  FFlagCod         := ctReference;
  FFlagDev         := False;
  FFlagDspa        := False;
  FFlagDsti        := odCustomer;
  FFlagES          := ioIn;
  FFlagEstq        := True;
  FFlagExp         := False;
  FFlagGFin        := True;
  FFlagGrnt        := tgNone;
  FFlagLdv         := False;
  FFlagOrgm        := odStock;
  FNatOpeDe        := '';
  FNatOpeFe        := '';
  FNatOpeEx        := '';
  FPkGroupMovement := 0;
  FPkTypeMovement  := 0;
  FcbIndex         := 0;
end;

function TMovement.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkGroupMovement) then
    Result := FcbIndex;
end;

function TMovement.GetPkValue: Variant;
begin
  Result := FPkGroupMovement;
end;

{
********************************* TOrderStatus *********************************
}
constructor TOrderStatus.Create;
begin
  inherited Create;
  FFkMovement     := TMovement.Create;
  FFkTipoMovEstq  := TTypeMoviment.Create;
  FFkTypeDocument := TTypeDocument.Create;
  Clear;
end;

destructor TOrderStatus.Destroy;
begin
  Clear;
  if Assigned(FFkMovement) then
    FFkMovement.Free;
  if Assigned(FFkTipoMovEstq) then
    FFkTipoMovEstq.Free;
  if Assigned(FFkTypeDocument) then
    FFkTypeDocument.Free;
  FFkMovement     := nil;
  FFkTipoMovEstq  := nil;
  FFkTypeDocument := nil;
  inherited Destroy;
end;

procedure TOrderStatus.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOrderStatus) then
  begin
    FPkOrderStatus   := TOrderStatus(Source).PkOrderStatus;
    if Assigned(FFkMovement) then
      FkMovement     := TOrderStatus(Source).FkMovement;
    if Assigned(FFkTipoMovEstq) then
      FkTipoMovEstq  := TOrderStatus(Source).FkTipoMovEstq;
    if Assigned(FFkTypeDocument) then
      FkTypeDocument := TOrderStatus(Source).FkTypeDocument;
    DscStt           := TOrderStatus(Source).DscStt;
    FSeqStt          := TOrderStatus(Source).SeqStt;
    FFlagStatus      := TOrderStatus(Source).FlagStatus;
    FQtdDaysNext     := TOrderStatus(Source).QtdDaysNext;
  end
  else
   inherited Assign(Source);
end;

procedure TOrderStatus.Clear;
begin
  FPkOrderStatus  := 0;
  if Assigned(FFkMovement) then
    FkMovement.Clear;
  if Assigned(FFkTipoMovEstq) then
    FkTipoMovEstq.Clear;
  if Assigned(FFkTypeDocument) then
    FFkTypeDocument.Clear;
  FDscStt         := '';
  FSeqStt         := 0;
  FFlagStatus     := [osOpened];
  FQtdDaysNext    := 0;
  FcbIndex        := 0;
end;

function TOrderStatus.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkOrderStatus) then
    Result := FcbIndex;
end;

function TOrderStatus.GetPkValue: Variant;
begin
  Result := FPkOrderStatus;
end;

procedure TOrderStatus.SetDscStt(AValue: string);
begin
  FDscStt := Copy(AValue, 1, 20);
end;

procedure TOrderStatus.SetFkMovement(AValue: TMovement);
begin
  if (AValue = nil) then
    FFkMovement.Clear
  else
    FFkMovement.Assign(AValue);
end;

procedure TOrderStatus.SetFkTipoMovEstq(AValue: TTypeMoviment);
begin
  if (AValue = nil) then
    FkTipoMovEstq.Clear
  else
    FkTipoMovEstq.Assign(AValue);
end;

procedure TOrderStatus.SetFkTypeDocument(AValue: TTypeDocument);
begin
  if AValue = nil then
    FFkTypeDocument.Clear
  else
    FFkTypeDocument.Assign(AValue);
end;

{
********************************* TInstallment *********************************
}
constructor TInstallment.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
  FOnModified := nil;
end;

destructor TInstallment.Destroy;
begin
  Clear;
  FOnModified := nil;
  inherited Destroy;
end;

procedure TInstallment.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TInstallment) then
  begin
    FDtaVenc  := TInstallment(Source).DtaVenc;
    FVlrParc  := TInstallment(Source).VlrParc;
    FModified := TInstallment(Source).Modified;
  end
  else
    inherited Assign(Source);
end;

procedure TInstallment.Clear;
begin
  FDtaVenc  := 0;
  FVlrParc  := 0;
  FModified := False;
end;

function TInstallment.GetDisplayName: string;
begin
  if FDtaVenc > 0 then
    Result := DateToStr(FDtaVenc)
  else
    Result := inherited GetDisplayName;
end;

procedure TInstallment.SetDtaVenc(AValue: TDate);
var
  i: Integer;
begin
  if (Collection <> nil) and (Collection is TInstallments) and (AValue > 0) and
     (Collection.Count = 0) then
  begin
    for i := Index - 1 downto 0 do
      if TInstallments(Collection).Items[i].DtaVenc > AValue then
        raise Exception.Create('TInstallment (SetDtaVenc) Error: invalid ' +
          'due date (AValue ' + DateToStr(AValue) + ' < Installment ' +
          DateToStr(TInstallments(Collection).Items[i].DtaVenc) + ')');
  end;
  FDtaVenc := AValue;
end;

procedure TInstallment.SetModified(AValue: Boolean);
begin
  FModified := AValue;
  if (Assigned(FOnModified)) then
    FOnModified(Self);
end;

{
******************************** TInstallments *********************************
}
constructor TInstallments.Create(AOwner: TPersistent);
begin
  inherited Create(TInstallment);
  FOwner := AOwner;
  Clear;
end;

destructor TInstallments.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TInstallments.Add: TInstallment;
begin
  Result := inherited Add as TInstallment;
end;

procedure TInstallments.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TInstallment;
begin
  if (Source <> nil) and (Source is TInstallments) then
  begin
    for i := 0 to TInstallments(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TInstallments(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TInstallments.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TInstallments.GetItems(Index: Integer): TInstallment;
begin
  Result := inherited GetItem(Index) as TInstallment;
end;

function TInstallments.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TInstallments.GetTotal: Double;
var
  i: Integer;
begin
  Result := 0.0;
  for i := 0 to Count - 1 do
    Result := Result + Items[i].VlrParc;
end;

function TInstallments.Insert(Index: Integer): TInstallment;
begin
  Result := inherited Insert(Index) as TInstallment;
end;

procedure TInstallments.SetItems(Index: Integer; Value: TInstallment);
begin
  inherited Items[Index] := Value;
end;

{
********************************** TDiscount ***********************************
}
constructor TDiscount.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFkCategory  := TCategory.Create(nil);
  FFkState     := TState.Create;
  Clear;
end;

destructor TDiscount.Destroy;
begin
  Clear;
  if Assigned(FFkCategory) then
    FFkCategory.Free;
  if Assigned(FFkState) then
    FFkState.Free;
  FFkCategory  := nil;
  FFkState     := nil;
  inherited Destroy;
end;

procedure TDiscount.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TDiscount) then
  begin
    DscDsct := TDiscount(Source).DscDsct;
    if Assigned(FFkCategory) then
      FkCategory := TDiscount(Source).FkCategory;
    if Assigned(FFkState) then
      FkState  := TDiscount(Source).FkState;
    FFlagDstq  := TDiscount(Source).FlagDstq;
    FFlagTDsct := TDiscount(Source).FlagTDsct;
    FIdxDsct   := TDiscount(Source).IdxDsct;
  end
  else
    inherited Assign(Source);
end;

procedure TDiscount.Clear;
begin
  FDscDsct := '';
  if Assigned(FFkCategory) then
    FkCategory.Clear;
  if Assigned(FFkState) then
    FkState.Clear;
  FFlagDstq  := True;
  FFlagTDsct := toPercent;
  FIdxDsct   := 0.0;
end;

function TDiscount.GetDisplayName: string;
begin
  if (FDscDsct = '') and (IdxDsct > 0) then
    Result := FloatToStr(IdxDsct);
  if (FDscDsct <> '') then
    Result := FDscDsct;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TDiscount.SetDscDsct(AValue: string);
begin
  FDscDsct := Copy(AValue, 1, 30);
end;

procedure TDiscount.SetFkCategory(AValue: TCategory);
begin
  if AValue = nil then
    FFKCategory.Clear
  else
    FFkCategory.Assign(AValue);
end;

procedure TDiscount.SetFkState(AValue: TState);
begin
  if AValue = nil then
    FFKState.Clear
  else
    FFkState.Assign(AValue);
end;

{
********************************** TDiscounts **********************************
}
constructor TDiscounts.Create(AOwner: TPersistent);
begin
  inherited Create(TDiscount);
  FOwner := AOwner;
end;

destructor TDiscounts.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

function TDiscounts.Add: TDiscount;
begin
  Result := inherited Add as TDiscount;
end;

procedure TDiscounts.Assign(Source: TPersistent);
var
  aIdx: Integer;
  aItem: TDiscount;
begin
  if (Source <> nil) and (Source is TDiscounts) then
  begin
    for aIdx := 0 to TDiscounts(Source).Count - 1 do
    begin
      aItem := Self.Add;
      aItem.Assign(TDiscounts(Source).Items[aIdx]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TDiscounts.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TDiscounts.GetItems(Index: Integer): TDiscount;
begin
  Result := inherited Items[Index] as TDiscount;
end;

function TDiscounts.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TDiscounts.Insert(Index: Integer): TDiscount;
begin
  Result := inherited Insert(Index) as TDiscount;
end;

procedure TDiscounts.SetItems(Index: Integer; Value: TDiscount);
begin
  inherited Items[Index] := Value;
end;

{
******************************** TTypeDiscount *********************************
}
constructor TTypeDiscount.Create;
begin
  inherited Create;
  FDiscounts  := TDiscounts.Create(Self);
  FFkMovement := TMovement.Create;
  Clear;
end;

destructor TTypeDiscount.Destroy;
begin
  Clear;
  if Assigned(FFkMovement) then
    FFkMovement.Free;
  if Assigned(FDiscounts) then
    FDiscounts.Free;
  FDiscounts  := nil;
  FFkMovement := nil;
  inherited Destroy;
end;

procedure TTypeDiscount.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TTypeDiscount) then
  begin
    FPkTypeDiscount := TTypeDiscount(Source).PkTypeDiscount;
    FDscDsct        := TTypeDiscount(Source).DscDsct;
    FkMovement      := TTypeDiscount(Source).FkMovement;
    Discounts       := TTypeDiscount(Source).Discounts;
    cbIndex         := TTypeDiscount(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TTypeDiscount.Clear;
begin
  FDscDsct        := '';
  FPkTypeDiscount := 0;
  cbIndex         := 0;
  if Assigned(FDiscounts) then
    FDiscounts.Clear;
end;

function TTypeDiscount.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkTypeDiscount) then
    Result := FcbIndex;
end;

function TTypeDiscount.GetPkValue: Variant;
begin
  Result := FPkTypeDiscount;
end;

procedure TTypeDiscount.SetDiscounts(AValue: TDiscounts);
begin
  if AValue = nil then
    FDiscounts.Clear
  else
    FDiscounts.Assign(AValue);
end;

procedure TTypeDiscount.SetFkMovement(AValue: TMovement);
begin
  if AValue = nil then
    FFkMovement.Clear
  else
    FFkMovement.Assign(AValue);
end;

{
********************************* TPaymentWay **********************************
}
constructor TPaymentWay.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
end;

destructor TPaymentWay.Destroy;
begin
  Clear;
  FOnAcceptKey := nil;
  inherited Destroy;
end;

procedure TPaymentWay.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TPaymentWay) then
  begin
    DscMPgt       := TPaymentWay(Source).DscMPgt;
    FPkPaymentWay := TPaymentWay(Source).PkPaymentWay;
    FFlagBnc      := TPaymentWay(Source).FlagBnc;
    FFlagCli      := TPaymentWay(Source).FlagCli;
    FFlagTef      := TPaymentWay(Source).FlagTef;
    FFlagTFin     := TPaymentWay(Source).FlagTFin;
    FFlagTrc      := TPaymentWay(Source).FlagTrc;
    FKeyCode      := TPaymentWay(Source).KeyCode;
  end
  else
    inherited Assign(Source);
end;

procedure TPaymentWay.Clear;
begin
  FDscMPgt      := '';
  FPkPaymentWay := 0;
  FFlagBnc      := False;
  FFlagCli      := False;
  FFlagTef      := False;
  FFlagTFin     := fnMoney;
  FFlagTrc      := False;
  FKeyCode      := 0;
end;

function TPaymentWay.GetDisplayName: string;
begin
  Result := FDscMPgt;
  if (Result = '') then Result := inherited GetDisplayName;
end;

procedure TPaymentWay.SetDscMPgt(AValue: string);
begin
  FDscMPgt := Copy(AValue, 1, 30);
end;

procedure TPaymentWay.SetKeyCode(AValue: Word);
var
  Allowed: Boolean;
begin
  Allowed := True;
  if Assigned(FOnAcceptKey) then
    FOnAcceptKey(Self, AValue, Allowed);
  if Allowed then
    FKeyCode := AValue;
end;

{
********************************* TPaymentWays *********************************
}
constructor TPaymentWays.Create(AOwner: TPersistent);
begin
  inherited Create(TPaymentWay);
  FOwner := AOwner;
end;

destructor TPaymentWays.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TPaymentWays.AcceptKeyCode(Sender: TObject; const Value: Integer; var 
        Allowed: Boolean);
var
  i, j: Integer;
begin
  if (Value = 0) then exit;
  j := 0;
  for i := 0 to Count - 1 do
    if (Items[i].KeyCode = Value) then Inc(j);
  if (j > 1) then
    raise Exception.Create('TPaymentWays Error: Key Code already in use');
end;

function TPaymentWays.Add: TPaymentWay;
begin
  Result := inherited Add as TPaymentWay;
  Result.OnAcceptKey := AcceptKeyCode;
end;

procedure TPaymentWays.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TPaymentWay;
begin
  if (Source <> nil) and (Source is TPaymentWays) then
  begin
    for i := 0 to TPaymentWays(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TPaymentWays(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TPaymentWays.Clear;
begin
  inherited Clear;
end;

procedure TPaymentWays.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TPaymentWays.GetItems(Index: Integer): TPaymentWay;
begin
  Result := inherited GetItem(Index) as TPaymentWay;
end;

function TPaymentWays.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TPaymentWays.Insert(Index: Integer): TPaymentWay;
begin
  Result := inherited Insert(Index) as TPaymentWay;
  Result.OnAcceptKey := AcceptKeyCode;
end;

procedure TPaymentWays.SetItems(Index: Integer; AValue: TPaymentWay);
begin
  inherited Items[Index] := AValue;
end;

{
********************************** TInterval ***********************************
}
destructor TInterval.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TInterval.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TPaymentWay) then
  begin
    QtdIntrv := TInterval(Source).QtdIntrv;
    OpeIntrv := TInterval(Source).OpeIntrv;
    IdxIntrv := TInterval(Source).IdxIntrv;
  end
  else
    inherited Assign(Source);
end;

procedure TInterval.Clear;
begin
  QtdIntrv := 0;
  OpeIntrv := toPercent;
  IdxIntrv := 0.0;
end;

function TInterval.GetDisplayName: string;
begin
  Result := 'Intervalo:' + IntToStr(Index) + '/' + IntToStr(FQtdIntrv);
  if (Result = '') then Result := inherited GetDisplayName;
end;

{
********************************** TIntervals **********************************
}
constructor TIntervals.Create(AOwner: TPersistent);
begin
  inherited Create(TInterval);
  FOwner := AOwner;
end;

destructor TIntervals.Destroy;
begin
  inherited Clear;
  inherited Destroy;
end;

function TIntervals.Add: TInterval;
begin
  Result := inherited Add as TInterval;
end;

procedure TIntervals.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TInterval;
begin
  if (Source <> nil) and (Source is TIntervals) then
  begin
    inherited Clear;
    for i := 0 to TIntervals(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TIntervals(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TIntervals.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TIntervals.GetItems(Index: Integer): TInterval;
begin
  Result := inherited GetItem(Index) as TInterval;
end;

function TIntervals.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TIntervals.Insert(Index: Integer): TInterval;
begin
  Result := inherited Insert(Index) as TInterval;
end;

procedure TIntervals.SetItems(Index: Integer; Value: TInterval);
begin
  inherited Items[Index] := Value;
end;

{
********************************* TTypePayment *********************************
}
constructor TTypePayment.Create;
begin
  inherited Create;
  FPaymentWays  := TPaymentWays.Create(Self);
  FInstallments := TInstallments.Create(Self);
  FIntervals    := TIntervals.Create(Self);
  Clear;
end;

destructor TTypePayment.Destroy;
begin
  Clear;
  if Assigned(FPaymentWays) then
    FPaymentWays.Free;
  if Assigned(FInstallments) then
    FInstallments.Free;
  if Assigned(FIntervals) then
    FIntervals.Free;
  FPaymentWays  := nil;
  FInstallments := nil;
  FIntervals    := nil;
  inherited Destroy;
end;

procedure TTypePayment.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TTypePayment) then
  begin
    FcbIndex          := TTypePayment(Source).cbIndex;
    FDocumentValue    := TTypePayment(Source).DocumentValue;
    DscTPgt           := TTypePayment(Source).DscTPgt;
    FDspFin           := TTypePayment(Source).DspFin;
    FFkFinanceAccount := TTypePayment(Source).FkFinanceAccount;
    FFkGroupMovement  := TTypePayment(Source).FkGroupMovement;
    FFlagBaseDate     := TTypePayment(Source).FlagBaseDate;
    FFlagBlock        := TTypePayment(Source).FlagBlock;
    FFlagTInt         := TTypePayment(Source).FlagTInt;
    FFlagTVda         := TTypePayment(Source).FlagTVda;
    Intervals         := TTypePayment(Source).Intervals;
    PaymentWays       := TTypePayment(Source).PaymentWays;
    FPkTypePgto       := TTypePayment(Source).PkTypePgto;
    Installments      := TTypePayment(Source).Installments;
  end
  else
    inherited Assign(Source);
end;

function TTypePayment.CheckData: TCheckErrors;
var
  i, aIntAnt: Integer;
begin
  Result := [];
  if (FFlagTInt = ipUser) then
  begin
    if (FQtdParc = 0) then
      Result := [ceNoUserInterval]
    else
    begin
      aIntAnt := 0;
      for i := 0 to FQtdParc - 1 do
      begin
        if (FIntervals.Items[i].QtdIntrv < aIntAnt) and
           (not (ceInvalidList in Result))then
          Result := Result + [ceInvalidList];
        aIntAnt := FIntervals.Items[i].QtdIntrv;
      end;
    end;
  end;
  if (FFlagTInt <> ipUser) and (FQtdParc = 0) and (FFlagTVda <> tsCash) then
    Result := Result + [ceNoInterval];
  if (FQtdParc = 0) and (FFlagTVda <> tsCash) then
    Result := Result + [ceNoQtdInstallment];
  if (Result <> []) and Assigned(FOnCheckData) then
    FOnCheckData(Self, Result)
  else
  begin
    if ceNoUserInterval in Result then
      raise Exception.Create('Error: Missing value of List Interval');
    if ceInvalidList in Result then
      raise Exception.Create('Error: List Interval containing no valid characters');
    if ceNoInterval in Result then
      raise Exception.Create('Error: Field Interval must be a value > 0');
    if ceNoQtdInstallment in Result then
      raise Exception.Create('Error: Field Quantity Installments must be informed');
    if ceDifQtdList in Result then
      raise Exception.Create('Error: Field Quantity Installments and List Intervals are different');
  end;
end;

procedure TTypePayment.Clear;
begin
  FcbIndex          := 0;
  FDocumentValue    := 0.0;
  DscTPgt           := '';
  FDspFin           := 0.0;
  FFkFinanceAccount := 0;
  FFkGroupMovement  := 0;
  FFlagBaseDate     := bdInvoice;
  FFlagBlock        := False;
  FFlagTInt         := ipDays;
  FFlagTVda         := tsCash;
  if Assigned(FIntervals) then
    FIntervals.Clear;
  if Assigned(FPaymentWays) then
    FPaymentWays.Clear;
  FPkTypePgto       := 0;
end;

function TTypePayment.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkTypePgto) then
    Result := FcbIndex;
end;

function TTypePayment.CreatePayments(AValue: Double; ABaseDate: TDate): Boolean;
var
  i, aQtdIntrv: Integer;
  aItem: TInstallment;
  aVlrParc, aVlrEntr, aIdx: Double;
  aPriorDate: TDate;
  aTypeOpe: TTypeOperation;
begin
  Result := False;
  aVlrEntr := 0;
  aVlrParc := 0;
  if (FFlagTVda = tsCash) then exit;
  if (FQtdParc = 0) then
    raise Exception.Create('TTypePayment: I can´t to create invoices without periods!');
  if (FFlagTInt = ipUser) and (FIntervals.Count = 0) then
    raise Exception.Create('TTypePayment: Incomplete data for user defined periods!')
  else
    if (AValue = 0) or (ABaseDate = 0) or (FInstallments = nil) or
       (CheckData <> []) then
      raise Exception.Create('TTypePayment: Incomplete Data!');
  FInstallments.Clear;
  if (FFlagUTax) and (Intervals.Count >= 1) then
  begin
    aTypeOpe  := Intervals.Items[0].OpeIntrv;
    aIdx      := Intervals.Items[0].IdxIntrv;
    aQtdIntrv := Intervals.Items[0].QtdIntrv;
    case aTypeOpe of
      toPercent : begin
                    AValue   := AValue + ((AValue * aIdx) / 100);
                    aVlrParc := AValue / QtdParc;
                  end;
      toMultiIdx: aVlrParc := AValue * aIdx;
      toDivIdx  : aVlrParc := AValue / aIdx;
      toValue   : begin
                    AValue   := AValue + aIdx;
                    aVlrParc := AValue / QtdParc;
                  end;
    end;
    if (aQtdIntrv = 0) then
      aVlrEntr := aVlrParc;
  end;
  aPriorDate := ABaseDate;
  for i := 0 to FQtdParc - 1 do
  begin
    if (FFlagTInt = ipUser) and (not FFlagUTax) then
    begin
      aTypeOpe  := Intervals.Items[i].OpeIntrv;
      aIdx      := Intervals.Items[i].IdxIntrv;
      aQtdIntrv := Intervals.Items[i].QtdIntrv;
    end
    else
    begin
      aTypeOpe  := Intervals.Items[0].OpeIntrv;
      aIdx      := Intervals.Items[0].IdxIntrv;
      aQtdIntrv := Intervals.Items[0].QtdIntrv;
    end;
  //  case toPercent, toMultiIdx, toDivIdx, toValue
    if (FFlagTInt = ipUser) and (not FFlagUTax) then
    begin
      case aTypeOpe of
        toPercent : aVlrParc := (AValue / QtdParc) + (((AValue / QtdParc) * aIdx) / 100);
        toMultiIdx: aVlrParc := AValue * aIdx;
        toDivIdx  : if (aIdx <> 0) then aVlrParc := AValue / aIdx;
        toValue   : aVlrParc := (AValue / QtdParc) + aIdx;
      end;
    end;
    aItem      := FInstallments.Add;
    if (aVlrEntr > 0) then
      aItem.DtaVenc := ABaseDate;
    if (FFlagTInt = ipUser) and (not FFlagUTax) then
      ABaseDate := aPriorDate;
    case FlagTInt of
      ipDays  : ABaseDate := IncDay  (ABaseDate, aQtdIntrv);
      ipWeeks : ABaseDate := IncWeek (ABaseDate, aQtdIntrv);
      ipMonths: ABaseDate := IncMonth(ABaseDate, aQtdIntrv);
      ipYears : ABaseDate := IncYear (ABaseDate, aQtdIntrv);
    end;
    aItem.DtaVenc := ABaseDate;
    aItem.VlrParc := aVlrParc;
  end;
end;

function TTypePayment.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('PK_TIPO_PAGAMENTOS');
  Result.Add('FK_GRUPOS_MOVIMENTOS');
  Result.Add('DSC_TPG');
  Result.Add('DSP_FIN');
  Result.Add('FLAG_TINTV');
  Result.Add('FLAG_BLOQ');
  Result.Add('FLAG_TVDA');
  Result.Add('FLAG_BDATE');
  Result.Add('QTD_PARC');
end;

function TTypePayment.GetPkValue: Variant;
begin
  Result := FPkTypePgto;
end;

procedure TTypePayment.SetInstallments(Value: TInstallments);
begin
  FInstallments.Clear;
  if (Value <> nil) then
    FInstallments.Assign(Value);
end;

procedure TTypePayment.SetIntervals(Value: TIntervals);
begin
  if (Value = nil) then
    Intervals.Clear
  else
    Intervals.Assign(Value);
  FQtdParc := Intervals.Count;
end;

procedure TTypePayment.SetPaymentWays(AValue: TPaymentWays);
begin
  if (AValue = nil) then
    PaymentWays.Clear
  else
    PaymentWays.Assign(AValue);
end;

    
end.
