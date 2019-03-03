unit TSysPed;

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

uses SysUtils, Classes, ProcType, ProcUtils, TSysMan, TSysPedAux, TSysCad,
     TSysEstq, TSysConfAux, TSysEstqAux,
    {$IFDEF WIN32} Controls {$ENDIF}
    {$IFDEF LINUX} QControls {$ENDIF};

type

  TTypeTax = (ttIcms, ttIcmss, ttIpi, ttIss, ttOtr);

  TTipoCadastro     = (tcJuridica, tcFisica, tcAllCat, tcAll);

  TFinishStatus     = (fsNone, fsFinish, fsPrice, fsClear);

  TNameOfFieldType  = (nfFkEmpresas, nfFkCadastros, nfFkGrpMov, nfFkTpMov,
                       nfFkTabPrice, nfFkTpPgto, nfFkTpDsct, nfFkTpOrder,
                       nfFkTpStatus, nfFkBuyOrder);

  TTaxDescription   = record
    TaxPercent: Double;
    TaxCode   : Smallint;
  end;

  TRasonTypes       = (rtUserChangePays, rtUserExceedDsct, rtOwnerExceedLimit,
                       rtOwnerIsBlocked, rtItemWithOutStock,
                       rtUserModifyItemPrice);

  TOrder = class;

  TOrderItem  = class;

  TNotifyFkChange = procedure (Sender: TObject; NameFieldType: TNameOfFieldType;
          Value: Integer) of object;
  TGetAutorizationEvent = procedure (Sender: TObject; ARason: TRasonTypes; var 
          AOpeAut: string; var Allowed: Boolean) of object;
  TGetProductDataEvent = procedure (Sender: TOrderItem; const AProdRef: string; 
          const AType: TCodeType; const AQtd: Double; var ALotation: string) of 
          object;
  TConfItem = class (TCollectionItem)
  private
    FDscConf: string;
    FFkComponentType: TComponentType;
    FFkFinishType: TFinishType;
    FFkProduct: TProducts;
    FFkReferenceType: TReferenceType;
    FFlagBxaStt: Boolean;
    FFlagCntr: Boolean;
    FFlagFrnCli: Boolean;
    FFlagPend: Boolean;
    FModified: Boolean;
    FPerDsctIns: Double;
    FQtdParcial: Integer;
    function GetCodRef: string;
    function GetPkItemConf: Integer;
    function GetQtdComp: Integer;
    function GetQtdCompTot: Integer;
    function GetQtdDif: Integer;
    function GetQtdInsTot: Double;
    function GetQtdInsumo: Double;
    function GetQtdItem: Double;
    function GetTotConf: Double;
    function GetVlrItem: Double;
    procedure SetCodRef(AValue: string);
    procedure SetDscConf(AValue: string);
    procedure SetFkComponentType(AValue: TComponentType);
    procedure SetFkFinishType(AValue: TFinishType);
    procedure SetFkProduct(AValue: TProducts);
    procedure SetFkReferenceType(AValue: TReferenceType);
    procedure SetQtdParcial(AValue: Integer);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property CodRef: string read GetCodRef write SetCodRef;
    property DscConf: string read FDscConf write SetDscConf;
    property FkComponentType: TComponentType read FFkComponentType write 
            SetFkComponentType;
    property FkFinishType: TFinishType read FFkFinishType write SetFkFinishType;
    property FkProduct: TProducts read FFkProduct write SetFkProduct;
    property FkReferenceType: TReferenceType read FFkReferenceType write 
            SetFkReferenceType;
    property FlagBxaStt: Boolean read FFlagBxaStt write FFlagBxaStt default 
            True;
    property FlagCntr: Boolean read FFlagCntr write FFlagCntr default True;
    property FlagFrnCli: Boolean read FFlagFrnCli write FFlagFrnCli default 
            False;
    property FlagPend: Boolean read FFlagPend write FFlagPend default False;
    property Modified: Boolean read FModified default False;
    property PerDsctIns: Double read FPerDsctIns write FPerDsctIns;
    property PkItemConf: Integer read GetPkItemConf;
    property QtdComp: Integer read GetQtdComp;
    property QtdCompTot: Integer read GetQtdCompTot;
    property QtdDif: Integer read GetQtdDif;
    property QtdInsTot: Double read GetQtdInsTot;
    property QtdInsumo: Double read GetQtdInsumo;
    property QtdItem: Double read GetQtdItem;
    property QtdParcial: Integer read FQtdParcial write SetQtdParcial default 0;
    property TotConf: Double read GetTotConf;
    property VlrItem: Double read GetVlrItem;
  end;
  
  TShowConfItem = procedure (AConfItem: TConfItem; AGetFromFile: Boolean = 
          False) of object;
  TConfItems = class (TCollection)
  private
    FItemIndex: Integer;
    FModified: Boolean;
    FOwner: TPersistent;
    function GetItem(Index: integer): TConfItem;
    procedure SetItem(Index: integer; AValue: TConfItem);
    procedure SetItemIndex(AValue: Integer);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TConfItem;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TConfItem;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items[Index: integer]: TConfItem read GetItem write SetItem; 
            default;
    property Modified: Boolean read FModified write FModified;
  end;
  
  TOrderPending = class (TCollectionItem)
  private
    FQtdPend: Double;
    FTypeOutstanding: string;
    FVlrUnit: Double;
    procedure SetTypeOutstanding(AValue: string);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property Index;
    property QtdPend: Double read FQtdPend write FQtdPend;
    property TypeOutstanding: string read FTypeOutstanding write 
            SetTypeOutstanding;
    property VlrUnit: Double read FVlrUnit write FVlrUnit;
  end;
  
  TOrderPendings = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TOrderPending;
    procedure SetItems(Index: Integer; AValue: TOrderPending);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TOrderPending;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TOrderPending;
    property Count;
    property Items[Index: Integer]: TOrderPending read GetItems write SetItems;
  end;
  
  TOrderItem = class (TCollectionItem)
  private
    FAlqIcms: TTaxDescription;
    FAlqIcmss: TTaxDescription;
    FAlqIpi: TTaxDescription;
    FAlqIss: TTaxDescription;
    FAlqOtr: TTaxDescription;
    FClassFiscal: string;
    FCodRef: string;
    FComProd: Double;
    FConfigItems: TConfItems;
    FDocument: TOrder;
    FDtaFat: TDate;
    FDtaLiq: TDate;
    FFkAlmox: Integer;
    FFkClassification: Integer;
    FFkLotacao: Integer;
    FFkMovement: TMovement;
    FFkPriceTable: TPriceTable;
    FFkProduct: TProducts;
    FFkProductionLoad: Integer;
    FFlagBxaStt: Boolean;
    FFlagConf: Boolean;
    FFlagDefTab: Boolean;
    FFlagSrv: Boolean;
    FLotItem: string;
    FMode: TDBMode;
    FNumExtr: string;
    FOnGetProductData: TGetProductDataEvent;
    FOnGetProductLotation: TGetProductDataEvent;
    FOrderPendings: TOrderPendings;
    FPerDsct: Double;
    FQtdItem: Double;
    FRedBas: Double;
    FSitTrib: string;
    FStatus: Integer;
    FVlrAcrDsct: Double;
    FVlrUnit: Double;
    FVolProd: Double;
    function GetDscProd: string;
    function GetFKUnit: TUnit;
    function GetFlagPend: Boolean;
    function GetFlagPrm: Boolean;
    function GetHasConfig: Boolean;
    function GetLotItem: string;
    function GetPkCompany: Integer;
    function GetSubTot: Double;
    function GetTotItem: Double;
    function GetVlrTab: Double;
    procedure SetClassFiscal(AValue: string);
    procedure SetCodRef(AValue: string);
    procedure SetConfigItems(AValue: TConfItems);
    procedure SetFkMovement(AValue: TMovement);
    procedure SetFkPriceTable(AValue: TPriceTable);
    procedure SetFkProduct(AValue: TProducts);
    procedure SetLotItem(AValue: string);
    procedure SetNumExtr(AValue: string);
    procedure SetOrderPendings(AValue: TOrderPendings);
    procedure SetSitTrib(AValue: string);
    procedure SetVlrUnit(AValue: Double);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property AlqIcms: TTaxDescription read FAlqIcms write FAlqIcms;
    property AlqIcmss: TTaxDescription read FAlqIcmss write FAlqIcmss;
    property AlqIpi: TTaxDescription read FAlqIpi write FAlqIpi;
    property AlqIss: TTaxDescription read FAlqIss write FAlqIss;
    property AlqOtr: TTaxDescription read FAlqOtr write FAlqOtr;
    property ClassFiscal: string read FClassFiscal write SetClassFiscal;
    property CodRef: string read FCodRef write SetCodRef;
    property ComProd: Double read FComProd write FComProd;
    property ConfigItems: TConfItems read FConfigItems write SetConfigItems;
    property DisplayName;
    property DscProd: string read GetDscProd;
    property DtaFat: TDate read FDtaFat write FDtaFat;
    property DtaLiq: TDate read FDtaLiq write FDtaLiq;
    property FkAlmox: Integer read FFkAlmox write FFkAlmox;
    property FkClassification: Integer read FFkClassification write 
            FFkClassification;
    property FkLotacao: Integer read FFkLotacao write FFkLotacao;
    property FkMovement: TMovement read FFkMovement write SetFkMovement;
    property FkPriceTable: TPriceTable read FFkPriceTable write SetFkPriceTable;
    property FkProduct: TProducts read FFkProduct write SetFkProduct;
    property FkProductionLoad: Integer read FFkProductionLoad write 
            FFkProductionLoad;
    property FKUnit: TUnit read GetFKUnit;
    property FlagBxaStt: Boolean read FFlagBxaStt;
    property FlagConf: Boolean read FFlagConf write FFlagConf;
    property FlagDefTab: Boolean read FFlagDefTab write FFlagDefTab;
    property FlagPend: Boolean read GetFlagPend;
    property FlagPrm: Boolean read GetFlagPrm;
    property FlagSrv: Boolean read FFlagSrv write FFlagSrv;
    property HasConfig: Boolean read GetHasConfig;
    property Index;
    property LotItem: string read GetLotItem write SetLotItem;
    property Mode: TDBMode read FMode write FMode default dbmBrowse;
    property NumExtr: string read FNumExtr write SetNumExtr;
    property OnGetProductData: TGetProductDataEvent read FOnGetProductData 
            write FOnGetProductData;
    property OnGetProductLotation: TGetProductDataEvent read 
            FOnGetProductLotation write FOnGetProductLotation;
    property OrderPendings: TOrderPendings read FOrderPendings write 
            SetOrderPendings;
    property PerDsct: Double read FPerDsct write FPerDsct;
    property PkCompany: Integer read GetPkCompany;
    property QtdItem: Double read FQtdItem write FQtdItem;
    property RedBas: Double read FRedBas write FRedBas;
    property SitTrib: string read FSitTrib write SetSitTrib;
    property Status: Integer read FStatus write FStatus default 0;
    property SubTot: Double read GetSubTot;
    property TotItem: Double read GetTotItem;
    property VlrAcrDsct: Double read FVlrAcrDsct write FVlrAcrDsct;
    property VlrTab: Double read GetVlrTab;
    property VlrUnit: Double read FVlrUnit write SetVlrUnit;
    property VolProd: Double read FVolProd write FVolProd;
  end;
  
  TOrderItems = class (TCollection)
  private
    FItemIndex: Integer;
    FOwner: TOrder;
    function GetItems(Index: Integer): TOrderItem;
    procedure SetItemIndex(AValue: Integer);
    procedure SetItems(Index: Integer; AValue: TOrderItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TOrder);
    destructor Destroy; override;
    function Add: TOrderItem;
    function AddOrderItem(Item: TOrderItem): Integer;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TOrderItem;
    property Count;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items[Index: Integer]: TOrderItem read GetItems write SetItems;
  end;
  
  TOrderHistoric = class (TCollectionItem)
  private
    FDscHist: string;
    FDtHrHist: TDateTime;
    FFkOrderStatus: TOrderStatus;
    FFlagBxaStt: Boolean;
    procedure SetDscHist(AValue: string);
    procedure SetFkOrderStatus(AValue: TOrderStatus);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property DscHist: string read FDscHist write SetDscHist;
    property DtHrHist: TDateTime read FDtHrHist write FDtHrHist;
    property FkOrderStatus: TOrderStatus read FFkOrderStatus write 
            SetFkOrderStatus;
    property FlagBxaStt: Boolean read FFlagBxaStt write FFlagBxaStt;
    property Index;
  end;
  
  TOrderHistorics = class (TCollection)
  private
    function GetItems(Index: Integer): TOrderHistoric;
    procedure SetItems(Index: Integer; AValue: TOrderHistoric);
  protected
    FOwner: TOrder;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TOrder);
    destructor Destroy; override;
    function Add: TOrderHistoric;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TOrderHistoric;
    property Count;
    property Items[Index: Integer]: TOrderHistoric read GetItems write SetItems;
  end;
  
  TOrderLink = class (TCollectionItem)
  private
    FFkCompany: Integer;
    FFkDocument: Integer;
    FFkOwner: Integer;
    FFkTypeDocument: Integer;
    FFlagTDocument: TOrderType;
    FResultStatus: Integer;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property FkCompany: Integer read FFkCompany write FFkCompany;
    property FkDocument: Integer read FFkDocument write FFkDocument;
    property FkOwner: Integer read FFkOwner write FFkOwner;
    property FkTypeDocument: Integer read FFkTypeDocument write FFkTypeDocument;
    property FlagTDocument: TOrderType read FFlagTDocument write FFlagTDocument;
    property Index;
    property ResultStatus: Integer read FResultStatus write FResultStatus;
  end;
  
  TOrderLinks = class (TCollection)
  private
    function GetItems(Index: Integer): TOrderLink;
    procedure SetItems(Index: Integer; AValue: TOrderLink);
  protected
    FOwner: TOrder;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TOrder);
    destructor Destroy; override;
    function Add: TOrderLink;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TOrderLink;
    property Count;
    property Items[Index: Integer]: TOrderLink read GetItems write SetItems;
  end;
  
  TOrderMessage = class (TCollectionItem)
  private
    FDscDpto: string;
    FDtHrMsg: TDateTime;
    FDtHrRcbm: TDateTime;
    FFkDepartament: Integer;
    FTextMsg: TStrings;
    procedure SetDscDpto(AValue: string);
    procedure SetTextMsg(AValue: TStrings);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property DscDpto: string read FDscDpto write SetDscDpto;
    property DtHrMsg: TDateTime read FDtHrMsg write FDtHrMsg;
    property DtHrRcbm: TDateTime read FDtHrRcbm write FDtHrRcbm;
    property FkDepartament: Integer read FFkDepartament write FFkDepartament;
    property Index;
    property TextMsg: TStrings read FTextMsg write SetTextMsg;
  end;
  
  TOrderMessages = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TOrderMessage;
    procedure SetItems(Index: Integer; AValue: TOrderMessage);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TOrderMessage;
    function AddMsg(AValue: TOrderMessage): Integer;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function Insert(Index: Integer): TOrderMessage;
    property Count;
    property Items[Index: Integer]: TOrderMessage read GetItems write SetItems;
  end;
  
  TOrder = class (TPersistent)
  private
    FAnoPrevEntr: SmallInt;
    FDiscounts: TDiscounts;
    FDsctFret: Double;
    FDspAces: Double;
    FDtaBas: TDate;
    FDtaCanc: TDate;
    FDtaEmb: TDate;
    FDtaEmbExt: TDate;
    FDtaEntr: TDate;
    FDtaFat: TDate;
    FDtaLib: TDate;
    FDtaLiq: TDate;
    FDtaPed: TDate;
    FDtaProd: TDate;
    FDtaRecb: TDate;
    FEndEntr: TStrings;
    FFkAgent: TOwner;
    FFkCarrier: TOwner;
    FFkCompany: TCompany;
    FFkDeliveryPeriod: Integer;
    FFkMovement: TMovement;
    FFkOrderStatus: TOrderStatus;
    FFkOwner: TOwner;
    FFkPaymentWay: TPaymentWay;
    FFkPortoDst: Integer;
    FFkPortoEmb: Integer;
    FFkPriceTable: TPriceTable;
    FFkPurchaseOrder: Integer;
    FFkRepresentant: TOwner;
    FFkTypeDiscount: TTypeDiscount;
    FFkTypePayment: TTypePayment;
    FFkVendor: TOwner;
    FFlagBxaC: Boolean;
    FFlagCPrvE: Boolean;
    FFlagCtb: Boolean;
    FFlagDtaBas: TBaseDate;
    FFlagEntrParc: Boolean;
    FFlagImp: Boolean;
    FFlagItmDsct: Boolean;
    FFlagProd: Boolean;
    FFlagTPed: TOrderType;
    FGenDocs: TOrderLinks;
    FLoading: Boolean;
    FMesPrevEntr: SmallInt;
    FModified: Boolean;
    FMunEntr: Integer;
    FNomCad: string;
    FNumExtr: string;
    FNumProForma: Integer;
    FNumVol: SmallInt;
    FOnCalcOrder: TNotifyEvent;
    FOnGetAutorization: TGetAutorizationEvent;
    FOnOwnerChange: TNotifyFkChange;
    FOnPaymentChange: TNotifyFkChange;
    FOnPurchaseOrderChange: TNotifyFkChange;
    FOnSetInstallments: TNotifyEvent;
    FOnTypeOrderChange: TNotifyFkChange;
    FOnTypeStatusChange: TNotifyFkChange;
    FOpeAut: string;
    FOrderHistorics: TOrderHistorics;
    FOrderInstallments: TInstallments;
    FOrderItems: TOrderItems;
    FOrderLinks: TOrderLinks;
    FOrderMessages: TOrderMessages;
    FPesBru: Double;
    FPesLiq: Double;
    FPkOrder: Integer;
    FPlcVei: string;
    FQtdVol: SmallInt;
    FTipoVol: string;
    FUfEntr: string;
    FVlrEntr: Double;
    FVlrFret: Double;
    FVlrIcms: Double;
    FVlrIcmss: Double;
    FVlrIpi: Double;
    FVlrISS: Double;
    FVlrOtr: Double;
    FVlrSeg: Double;
    function GetAliq(const ATypeTax: TTypeTax; const AIdx: Integer; var ACode: 
            Integer): Double;
    function GetBasIcms: Double;
    function GetBasIcmss: Double;
    function GetBasIpi: Double;
    function GetBasIsnt: Double;
    function GetBasISS: Double;
    function GetBasOtr: Double;
    function GetComVda: Double;
    function GetDsctPerc: Double;
    function GetFlagEDrtRdsp: Boolean;
    function GetFlagPend: Boolean;
    function GetFlagVincPed: Boolean;
    function GetSubTot: Double;
    function GetTotPed: Double;
    function GetVlrAcrDsct: Double;
    function GetVlrIcms: Double;
    function GetVlrIcmss: Double;
    function GetVlrIpi: Double;
    function GetVlrISS: Double;
    function GetVlrOtr: Double;
    procedure SetAnoPrevEntr(AValue: SmallInt);
    procedure SetDiscounts(AValue: TDiscounts);
    procedure SetDspAces(AValue: Double);
    procedure SetDtaBas(AValue: TDate);
    procedure SetDtaEntr(AValue: TDate);
    procedure SetDtaFat(AValue: TDate);
    procedure SetDtaLib(AValue: TDate);
    procedure SetDtaLiq(AValue: TDate);
    procedure SetDtaPed(AValue: TDate);
    procedure SetDtaRecb(AValue: TDate);
    procedure SetEndEntr(AValue: TStrings);
    procedure SetFkAgent(AValue: TOwner);
    procedure SetFkCarrier(AValue: TOwner);
    procedure SetFkCompany(AValue: TCompany);
    procedure SetFkMovement(AValue: TMovement);
    procedure SetFkOrderStatus(AValue: TOrderStatus);
    procedure SetFkOwner(AValue: TOwner);
    procedure SetFkPaymentWay(AValue: TPaymentWay);
    procedure SetFkPriceTable(AValue: TPriceTable);
    procedure SetFkRepresentant(AValue: TOwner);
    procedure SetFkTypeDiscount(AValue: TTypeDiscount);
    procedure SetFkTypePayment(AValue: TTypePayment);
    procedure SetFkVendor(AValue: TOwner);
    procedure SetGenDocs(Value: TOrderLinks);
    procedure SetMesPrevEntr(AValue: SmallInt);
    procedure SetNomCad(Value: string);
    procedure SetNumExtr(AValue: string);
    procedure SetOrderHistorics(AValue: TOrderHistorics);
    procedure SetOrderInstallments(AValue: TInstallments);
    procedure SetOrderItems(AValue: TOrderItems);
    procedure SetOrderLinks(AValue: TOrderLinks);
    procedure SetOrderMessages(AValue: TOrderMessages);
    procedure SetPlcVei(Value: string);
    procedure SetTipoVol(AValue: string);
    procedure SetUfEntr(AValue: string);
  public
    constructor Create(ADecimalPlaces: SmallInt); reintroduce;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CalcTaxes(const ATaxType: TTypeTax; var ATaxValue: Double): Double;
    procedure Clear;
    function GetDocFields: TStrings;
    function GetFields: TStrings;
    procedure SortCompany(ALo, AHi: Integer);
    property AnoPrevEntr: SmallInt read FAnoPrevEntr write SetAnoPrevEntr 
            default 0;
    property BasIcms: Double read GetBasIcms;
    property BasIcmss: Double read GetBasIcmss;
    property BasIpi: Double read GetBasIpi;
    property BasIsnt: Double read GetBasIsnt;
    property BasISS: Double read GetBasISS;
    property BasOtr: Double read GetBasOtr;
    property ComVda: Double read GetComVda;
    property Discounts: TDiscounts read FDiscounts write SetDiscounts;
    property DsctFret: Double read FDsctFret write FDsctFret;
    property DsctPerc: Double read GetDsctPerc;
    property DspAces: Double read FDspAces write SetDspAces;
    property DtaBas: TDate read FDtaBas write SetDtaBas;
    property DtaCanc: TDate read FDtaCanc write FDtaCanc;
    property DtaEmb: TDate read FDtaEmb write FDtaEmb;
    property DtaEmbExt: TDate read FDtaEmbExt write FDtaEmbExt;
    property DtaEntr: TDate read FDtaEntr write SetDtaEntr;
    property DtaFat: TDate read FDtaFat write SetDtaFat;
    property DtaLib: TDate read FDtaLib write SetDtaLib;
    property DtaLiq: TDate read FDtaLiq write SetDtaLiq;
    property DtaPed: TDate read FDtaPed write SetDtaPed;
    property DtaProd: TDate read FDtaProd write FDtaProd;
    property DtaRecb: TDate read FDtaRecb write SetDtaRecb;
    property EndEntr: TStrings read FEndEntr write SetEndEntr;
    property FkAgent: TOwner read FFkAgent write SetFkAgent;
    property FkCarrier: TOwner read FFkCarrier write SetFkCarrier;
    property FkCompany: TCompany read FFkCompany write SetFkCompany;
    property FkDeliveryPeriod: Integer read FFkDeliveryPeriod write 
            FFkDeliveryPeriod;
    property FkMovement: TMovement read FFkMovement write SetFkMovement;
    property FkOrderStatus: TOrderStatus read FFkOrderStatus write 
            SetFkOrderStatus;
    property FkOwner: TOwner read FFkOwner write SetFkOwner;
    property FkPaymentWay: TPaymentWay read FFkPaymentWay write SetFkPaymentWay;
    property FkPortoDst: Integer read FFkPortoDst write FFkPortoDst default 0;
    property FkPortoEmb: Integer read FFkPortoEmb write FFkPortoEmb default 0;
    property FkPriceTable: TPriceTable read FFkPriceTable write SetFkPriceTable;
    property FkPurchaseOrder: Integer read FFkPurchaseOrder write 
            FFkPurchaseOrder;
    property FkRepresentant: TOwner read FFkRepresentant write 
            SetFkRepresentant;
    property FkTypeDiscount: TTypeDiscount read FFkTypeDiscount write 
            SetFkTypeDiscount;
    property FkTypePayment: TTypePayment read FFkTypePayment write 
            SetFkTypePayment;
    property FkVendor: TOwner read FFkVendor write SetFkVendor;
    property FlagBxaC: Boolean read FFlagBxaC write FFlagBxaC;
    property FlagCPrvE: Boolean read FFlagCPrvE write FFlagCPrvE default False;
    property FlagCtb: Boolean read FFlagCtb write FFlagCtb;
    property FlagDtaBas: TBaseDate read FFlagDtaBas write FFlagDtaBas default 
            bdOrder;
    property FlagEDrtRdsp: Boolean read GetFlagEDrtRdsp default False;
    property FlagEntrParc: Boolean read FFlagEntrParc write FFlagEntrParc 
            default False;
    property FlagImp: Boolean read FFlagImp write FFlagImp default False;
    property FlagItmDsct: Boolean read FFlagItmDsct write FFlagItmDsct default 
            True;
    property FlagPend: Boolean read GetFlagPend default False;
    property FlagProd: Boolean read FFlagProd write FFlagProd default False;
    property FlagTPed: TOrderType read FFlagTPed write FFlagTPed default 
            otBudget;
    property FlagVincPed: Boolean read GetFlagVincPed default False;
    property GenDocs: TOrderLinks read FGenDocs write SetGenDocs;
    property Loading: Boolean read FLoading write FLoading;
    property MesPrevEntr: SmallInt read FMesPrevEntr write SetMesPrevEntr 
            default 0;
    property Modified: Boolean read FModified write FModified default False;
    property MunEntr: Integer read FMunEntr write FMunEntr;
    property NomCad: string read FNomCad write SetNomCad;
    property NumExtr: string read FNumExtr write SetNumExtr;
    property NumProForma: Integer read FNumProForma write FNumProForma default 
            0;
    property NumVol: SmallInt read FNumVol write FNumVol;
    property OnCalcOrder: TNotifyEvent read FOnCalcOrder write FOnCalcOrder;
    property OnGetAutorization: TGetAutorizationEvent read FOnGetAutorization 
            write FOnGetAutorization;
    property OnOwnerChange: TNotifyFkChange read FOnOwnerChange write 
            FOnOwnerChange;
    property OnPaymentChange: TNotifyFkChange read FOnPaymentChange write 
            FOnPaymentChange;
    property OnPurchaseOrderChange: TNotifyFkChange read FOnPurchaseOrderChange 
            write FOnPurchaseOrderChange;
    property OnSetInstallments: TNotifyEvent read FOnSetInstallments write 
            FOnSetInstallments;
    property OnTypeOrderChange: TNotifyFkChange read FOnTypeOrderChange write 
            FOnTypeOrderChange;
    property OnTypeStatusChange: TNotifyFkChange read FOnTypeStatusChange write 
            FOnTypeStatusChange;
    property OpeAut: string read FOpeAut write FOpeAut;
    property OrderHistorics: TOrderHistorics read FOrderHistorics write 
            SetOrderHistorics;
    property OrderInstallments: TInstallments read FOrderInstallments write 
            SetOrderInstallments;
    property OrderItems: TOrderItems read FOrderItems write SetOrderItems;
    property OrderLinks: TOrderLinks read FOrderLinks write SetOrderLinks;
    property OrderMessages: TOrderMessages read FOrderMessages write 
            SetOrderMessages;
    property PesBru: Double read FPesBru write FPesBru;
    property PesLiq: Double read FPesLiq write FPesLiq;
    property PkOrder: Integer read FPkOrder write FPkOrder default 0;
    property PlcVei: string read FPlcVei write SetPlcVei;
    property QtdVol: SmallInt read FQtdVol write FQtdVol;
    property SubTot: Double read GetSubTot;
    property TipoVol: string read FTipoVol write SetTipoVol;
    property TotPed: Double read GetTotPed;
    property UfEntr: string read FUfEntr write SetUfEntr;
    property VlrAcrDsct: Double read GetVlrAcrDsct;
    property VlrEntr: Double read FVlrEntr write FVlrEntr;
    property VlrFret: Double read FVlrFret write FVlrFret;
    property VlrIcms: Double read GetVlrIcms;
    property VlrIcmss: Double read GetVlrIcmss;
    property VlrIpi: Double read GetVlrIpi;
    property VlrISS: Double read GetVlrISS;
    property VlrOtr: Double read GetVlrOtr;
    property VlrSeg: Double read FVlrSeg write FVlrSeg;
  end;
  
  TChangeItemEvent = procedure (Sender: TOrder; AItem: TOrderItem; AState: 
          TDBMode = dbmInsert) of object;
implementation

uses DateUtils, Math;

var
  GDecimalPlaces: Smallint;

{
********************************** TConfItem ***********************************
}
constructor TConfItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFkComponentType := TComponentType.Create;
  FFkFinishType    := TFinishType.Create;
  FFkProduct       := TProducts.Create;
  FFkReferenceType := TReferenceType.Create;
  Clear;
end;

destructor TConfItem.Destroy;
begin
  Clear;
  if Assigned(FFkComponentType) then
    FFkComponentType.Free;
  if Assigned(FFkFinishType) then
    FFkFinishType.Free;
  if Assigned(FFkProduct) then
    FFkProduct.Free;
  if Assigned(FFkReferenceType) then
    FFkReferenceType.Free;
  FFkComponentType := nil;
  FFkFinishType    := nil;
  FFkProduct       := nil;
  FFkReferenceType := nil;
  inherited Destroy;
end;

procedure TConfItem.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TConfItem) then
  begin
    if Assigned(FFkComponentType) then
      FkComponentType := TConfItem(Source).FkComponentType;
    if Assigned(FFkFinishType) then
      FkFinishType := TConfItem(Source).FkFinishType;
    if Assigned(FFkProduct) then
      FkProduct := TConfItem(Source).FkProduct;
    if Assigned(FFkReferenceType) then
      FkReferenceType := TConfItem(Source).FkReferenceType;
    DscConf     := TConfItem(Source).DscConf;
    CodRef      := TConfItem(Source).CodRef;
    FFlagBxaStt := TConfItem(Source).FlagBxaStt;
    FFlagCntr   := TConfItem(Source).FlagCntr;
    FFlagFrnCli := TConfItem(Source).FlagFrnCli;
    FFlagPend   := TConfItem(Source).FlagPend;
    FModified   := TConfItem(Source).Modified;
    FPerDsctIns := TConfItem(Source).PerDsctIns;
    FQtdParcial := TConfItem(Source).QtdParcial;
  end
  else
    inherited Assign(Source);
end;

procedure TConfItem.Clear;
begin
  if Assigned(FFkComponentType) then
    FFkComponentType.Clear;
  if Assigned(FFkFinishType) then
    FFkFinishType.Clear;
  if Assigned(FFkProduct) then
    FFkProduct.Clear;
  if Assigned(FFkReferenceType) then
    FFkReferenceType.Clear;
  FFlagBxaStt := False;
  FFlagCntr   := False;
  FFlagFrnCli := False;
  FFlagPend   := False;
  FModified   := False;
  FPerDsctIns := 0.0;
  FQtdParcial := 0;
  FDscConf    := '';
end;

function TConfItem.GetCodRef: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FkProduct.ProductCodes.Count - 1 do
  begin
    if (FkProduct.ProductCodes.Items[i].FlagTCode = pcReference) then
    begin
      Result := FkProduct.ProductCodes.Items[i].CodRef;
      break;
    end;
  end;
end;

function TConfItem.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_EMPRESAS');
  Result.Add('FK_TIPO_PEDIDOS');
  Result.Add('FK_PEDIDOS');
  Result.Add('FK_PEDIDOS_ITENS');
  Result.Add('PK_PEDIDOS_ITENS_CONF');
  Result.Add('FK_GRUPOS_MOVIMENTOS');
  Result.Add('FK_TIPO_MOVIMENTOS');
  Result.Add('FK_TABELA_PRECOS');
  Result.Add('FK_PRODUTOS');
  Result.Add('FK_COMPONENTES');
  Result.Add('FK_ACABAMENTOS');
  Result.Add('FK_TIPO_REFERENCIAS');
  Result.Add('FK_INSUMOS');
  //    FK_TIPO_DOCUMENTOS     VALORS,
  Result.Add('COD_REF');
  Result.Add('VLR_ITM');
  Result.Add('QTD_COMP_TOT');
  Result.Add('QTD_INS');
  Result.Add('FLAG_FRNCLI');
  Result.Add('FLAG_PEND');
  Result.Add('FLAG_CNTR');
  Result.Add('FLAG_BXASTT');
  Result.Add('NUM_DOC_LIB');
  Result.Add('PER_DSCT_INS');
end;

function TConfItem.GetPkItemConf: Integer;
begin
  Result := Index + 1;
end;

function TConfItem.GetQtdComp: Integer;
begin
  Result := Trunc(FFkComponentType.QtdComp);
end;

function TConfItem.GetQtdCompTot: Integer;
begin
  Result := Trunc(FFkComponentType.QtdComp * QtdItem);
  if (FQtdParcial = 0) then FQtdParcial := Result;
end;

function TConfItem.GetQtdDif: Integer;
begin
  Result := QtdCompTot - FQtdParcial;
end;

function TConfItem.GetQtdInsTot: Double;
begin
  Result := 0.0;
  if (FFkFinishType <> nil) then
    if FFlagFrnCli then
      Result := FFkFinishType.QtdPers * QtdCompTot
    else
      Result := FFkFinishType.QtdPdr * QtdCompTot;
end;

function TConfItem.GetQtdInsumo: Double;
begin
  Result := 0.0;
  if (FFkFinishType <> nil) then
    if FFlagFrnCli then
      Result := FFkFinishType.QtdPers
    else
      Result := FFkFinishType.QtdPdr;
end;

function TConfItem.GetQtdItem: Double;
begin
  Result := 0.0;
  if (Collection <> nil) and (Collection is TConfItems) and
     (Collection.Owner <> nil) and (Collection.Owner is TOrderItem) then
    Result :=  TOrderItem(Collection.Owner).QtdItem;
end;

function TConfItem.GetTotConf: Double;
begin
  Result := QtdParcial * VlrItem;
end;

function TConfItem.GetVlrItem: Double;
begin
  Result := 0.0;
  if (FFkFinishType <> nil) then
    Result := FFkFinishType.PreVda;
end;

procedure TConfItem.SetCodRef(AValue: string);
var
  i: Integer;
begin
  if (AValue = '') then exit;
  if (FkProduct.ProductCodes.Count = 0) then
  begin
    with FkProduct.ProductCodes.Add do
    begin
      FlagTCode := pcReference;
      CodRef    := AValue;
    end
  end
  else
    for i := 0 to FkProduct.ProductCodes.Count - 1 do
    begin
      if (FkProduct.ProductCodes.Items[i].FlagTCode = pcReference) then
      begin
        FkProduct.ProductCodes.Items[i].CodRef := AValue;
        break;
      end;
    end;
end;

procedure TConfItem.SetDscConf(AValue: string);
begin
  FDscConf := Copy(AValue, 1, 50);
end;

procedure TConfItem.SetFkComponentType(AValue: TComponentType);
begin
  if (AValue = nil) then
    FFkComponentType.Clear
  else
    FFkComponentType.Assign(AValue);
end;

procedure TConfItem.SetFkFinishType(AValue: TFinishType);
begin
  if (AValue = nil) then
    FFkFinishType.Clear
  else
    FFkFinishType.Assign(AValue);
end;

procedure TConfItem.SetFkProduct(AValue: TProducts);
begin
  if (AValue = nil) then
    FFkProduct.Clear
  else
    FFkProduct.Assign(AValue);
end;

procedure TConfItem.SetFkReferenceType(AValue: TReferenceType);
begin
  if (AValue = nil) then
    FFkReferenceType.Clear
  else
    FFkReferenceType.Assign(AValue);
end;

procedure TConfItem.SetQtdParcial(AValue: Integer);
begin
  if (QtdCompTot = 0) then exit;
  if (AValue > QtdCompTot) then
    raise Exception.Create('QtdParcial Error: QtdParcial can''t be greather ' +
                           'than QtdCompTot');
  if (AValue = 0) then
    raise Exception.Create('QtdParcial Error: Ivalid value to QtdParcial');
  FQtdParcial := AValue;
end;

{
********************************** TConfItems **********************************
}
constructor TConfItems.Create(AOwner: TPersistent);
begin
  inherited Create(TConfItem);
  FOwner  := AOwner;
  Clear;
end;

destructor TConfItems.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TConfItems.Add: TConfItem;
begin
  Result := inherited Add as TConfItem;
  ItemIndex := Result.Index;
end;

procedure TConfItems.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TConfItem;
begin
  if (Source <> nil) and (Source is TConfItems) then
  begin
    for i := 0 to TConfItems(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TConfItems(Source).Items[i]);
    end
  end
  else
    inherited Assign(Source);
end;

procedure TConfItems.Clear;
begin
  inherited Clear;
  FModified := False;
  FItemIndex := -1;
end;

procedure TConfItems.Delete(Index: Integer);
begin
  if (Index <= 0) then
    ItemIndex := -1
  else
    if (Index < Count) and (Index > 0) then
      ItemIndex := Index - 1;
  inherited Delete(Index);
end;

function TConfItems.GetItem(Index: integer): TConfItem;
begin
  Result := inherited Items[Index] as TConfItem;
end;

function TConfItems.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TConfItems.Insert(Index: Integer): TConfItem;
begin
  Result := inherited Insert(Index) as TConfItem;
  ItemIndex := Result.Index;
end;

procedure TConfItems.SetItem(Index: integer; AValue: TConfItem);
begin
  inherited Items[Index] := AValue;
end;

procedure TConfItems.SetItemIndex(AValue: Integer);
begin
  if (Count = 0) then
    FItemIndex := -1
  else
    if (AValue < Count) then
      FItemIndex := AValue
    else
      raise Exception.CreateFmt('ConfigItems Count %d: Out of range %d', [Count, AValue]);
end;

{
******************************** TOrderPending *********************************
}
constructor TOrderPending.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
end;

destructor TOrderPending.Destroy;
begin
  inherited Destroy;
end;

procedure TOrderPending.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOrderPending) then
  begin
    FTypeOutstanding := TOrderPending(Source).TypeOutstanding;
    FQtdPend         := TOrderPending(Source).QtdPend;
    FVlrUnit         := TOrderPending(Source).VlrUnit;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderPending.Clear;
begin
  FTypeOutstanding := '';
  FQtdPend         := 0.0;
  FVlrUnit         := 0.0;
end;

function TOrderPending.GetDisplayName: string;
begin
  Result := FTypeOutstanding;
  if (Result = '') then Result := inherited GetDisplayName;
end;

procedure TOrderPending.SetTypeOutstanding(AValue: string);
begin
  FTypeOutstanding := Copy(AValue, 1, 50);
end;

{
******************************** TOrderPendings ********************************
}
constructor TOrderPendings.Create(AOwner: TPersistent);
begin
  inherited Create(TOrderPending);
  FOwner := AOwner;
  Clear;
end;

destructor TOrderPendings.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TOrderPendings.Add: TOrderPending;
begin
  Result := inherited Add as TOrderPending;
end;

procedure TOrderPendings.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TOrderPending;
begin
  if (Source <> nil) and (Source is TOrderPendings) then
  begin
    for i := 0 to TOrderPendings(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TOrderPendings(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderPendings.Clear;
begin
  inherited Clear;
end;

procedure TOrderPendings.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TOrderPendings.GetItems(Index: Integer): TOrderPending;
begin
  Result := inherited Items[Index] as TOrderPending;
end;

function TOrderPendings.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TOrderPendings.Insert(Index: Integer): TOrderPending;
begin
  Result := inherited Insert(Index) as TOrderPending;
end;

procedure TOrderPendings.SetItems(Index: Integer; AValue: TOrderPending);
begin
  inherited Items[Index] := AValue
end;

{
********************************** TOrderItem **********************************
}
constructor TOrderItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FConfigItems   := TConfItems.Create(Self);
  FFkMovement    := TMovement.Create;
  FFkPriceTable  := TPriceTable.Create(Self);
  FFkProduct     := TProducts.Create;
  FOrderPendings := TOrderPendings.Create(Self);
  Clear;
  if (Collection is TOrderItems) then
    FDocument := TOrderItems(Collection).FOwner;
end;

destructor TOrderItem.Destroy;
begin
  Clear;
  if Assigned(FConfigItems) then
    FConfigItems.Free;
  if Assigned(FFkMovement) then
    FFkMovement.Free;
  if Assigned(FFkPriceTable) then
    FFkPriceTable.Free;
  if Assigned(FFkProduct) then
    FFkProduct.Free;
  if Assigned(FOrderPendings) then
    FOrderPendings.Free;
  FConfigItems   := nil;
  FFkMovement    := nil;
  FFkPriceTable  := nil;
  FFkProduct     := nil;
  FOrderPendings := nil;
  FDocument      := nil;
  inherited Destroy;
end;

procedure TOrderItem.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOrderItem) then
  begin
    if Assigned(FFkProduct) then
      FkProduct       := TOrderItem(Source).FkProduct;
    if Assigned(FConfigItems) then
      ConfigItems     := TOrderItem(Source).ConfigItems;
    if Assigned(FFkMovement) then
      FkMovement      := TOrderItem(Source).FkMovement;
    if Assigned(FFkPriceTable) then
      FkPriceTable    := TOrderItem(Source).FkPriceTable;
    if Assigned(FOrderPendings) then
      OrderPendings   := TOrderItem(Source).FOrderPendings;
    FAlqIcms          := TOrderItem(Source).AlqIcms;
    FAlqIcmss         := TOrderItem(Source).AlqIcmss;
    FAlqIpi           := TOrderItem(Source).AlqIpi;
    FAlqIss           := TOrderItem(Source).AlqIss;
    FAlqOtr           := TOrderItem(Source).AlqOtr;
    FCodRef           := TOrderItem(Source).CodRef;
    FClassFiscal      := TOrderItem(Source).ClassFiscal;
    FFkProductionLoad := TOrderItem(Source).FkProductionLoad;
    FFlagBxaStt       := TOrderItem(Source).FlagBxaStt;
    FLotItem          := TOrderItem(Source).LotItem;
    FMode             := TOrderItem(Source).Mode;
    FQtdItem          := TOrderItem(Source).QtdItem;
    FVlrAcrDsct       := TOrderItem(Source).VlrAcrDsct;
    FVlrUnit          := TOrderItem(Source).VlrUnit;
    FDtaLiq           := TOrderItem(Source).DtaLiq;
    FVolProd          := TOrderItem(Source).VolProd;
    FFlagSrv          := TOrderItem(Source).FlagSrv;
    FFlagDefTab       := TOrderItem(Source).FlagDefTab;
    FComProd          := TOrderItem(Source).ComProd;
    FRedBas           := TOrderItem(Source).RedBas;
    FFlagConf         := TOrderItem(Source).FlagConf;
    FStatus           := TOrderItem(Source).Status;
    FPerDsct          := TOrderItem(Source).PerDsct;
    DtaFat            := TOrderItem(Source).DtaFat;
    FkAlmox           := TOrderItem(Source).FkAlmox;
    FkClassification  := TOrderItem(Source).FkClassification;
    FkLotacao         := TOrderItem(Source).FkLotacao;
    FNumExtr          := TOrderItem(Source).NumExtr;
    FSitTrib          := TOrderItem(Source).SitTrib;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderItem.Clear;
begin
  FAlqIcms.TaxPercent  := 0.0;
  FAlqIcms.TaxCode     := 0;
  FAlqIcmss.TaxPercent := 0.0;
  FAlqIcmss.TaxCode    := 0;
  FAlqIpi.TaxPercent   := 0.0;
  FAlqIpi.TaxCode      := 0;
  FAlqIss.TaxPercent   := 0.0;
  FAlqIss.TaxCode      := 0;
  FAlqOtr.TaxPercent   := 0.0;
  FAlqOtr.TaxCode      := 0;
  FClassFiscal         := '';
  FCodRef              := '';
  FComProd             := 0.0;
  if Assigned(FConfigItems) then
    FConfigItems.Clear;
  DtaFat               := 0;
  FDtaLiq              := 0;
  FkAlmox              := 0;
  FkClassification     := 0;
  FkLotacao            := 0;
  if Assigned(FFkMovement) then
    FFkMovement.Clear;
  if Assigned(FFkPriceTable) then
    FFkPriceTable.Clear;
  if Assigned(FFkProduct) then
    FFkProduct.Clear;
  FFkProductionLoad    := 0;
  FFlagBxaStt          := False;
  FFlagConf            := False;
  FFlagDefTab          := True;
  FFlagSrv             := False;
  FLotItem             := '';
  FMode                := dbmBrowse;
  FNumExtr             := '';
  if Assigned(FOrderPendings) then
    FOrderPendings.Clear;
  FPerDsct             := 0.0;
  FQtdItem             := 0.0;
  FRedBas              := 0.0;
  FSitTrib             := '';
  FStatus              := 0;
  FVlrAcrDsct          := 0.0;
  FVlrUnit             := 0.0;
  FVolProd             := 0.0;
end;

function TOrderItem.GetDisplayName: string;
begin
  if (FFkProduct <> nil) then
    Result := FFkProduct.DscProd
  else
    Result := '';
  if (Result = '') then Result := inherited GetDisplayName;
end;

function TOrderItem.GetDscProd: string;
begin
  Result := FkProduct.DscProd;
end;

function TOrderItem.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_EMPRESAS');
  Result.Add('FK_TIPO_PEDIDOS');
  Result.Add('FK_PEDIDOS');
  Result.Add('PK_PEDIDOS_ITENS');
  Result.Add('FK_GRUPOS_MOVIMENTOS');
  Result.Add('FK_TIPO_MOVIMENTOS');
  if (FkPriceTable.PkPriceTable > 0) then
    Result.Add('FK_TABELA_PRECOS');
  Result.Add('FK_UNIDADES');
  Result.Add('FK_PRODUTOS');
  if (FkProductionLoad > 0) then
    Result.Add('FK_CARGAS_PRODUCAO');
  Result.Add('REF_PRODUTO');
  Result.Add('QTD_ITEM');
  Result.Add('VLR_TAB');
  Result.Add('VLR_UNIT');
  Result.Add('SUB_TOT');
  Result.Add('VLR_ACR_DSCT');
  Result.Add('TOT_ITEM');
  Result.Add('SIT_TRIB');
  Result.Add('ALQ_ISS');
  Result.Add('ALQ_ICMS');
  Result.Add('ALQ_ICMSS');
  Result.Add('ALQ_IPI');
  Result.Add('ALQ_OTR');
  Result.Add('COD_ISS_ECF');
  Result.Add('COD_ICMS_ECF');
  Result.Add('COD_ICMSS_ECF');
  Result.Add('COD_IPI_ECF');
  Result.Add('COD_OTR_ECF');
  Result.Add('FLAG_PRM');
  Result.Add('FLAG_PEND');
  Result.Add('FLAG_BXASTT');
  Result.Add('FLAG_CONF');
  Result.Add('FLAG_SRV');
  if (NumExtr <> '') then
    Result.Add('NUM_EXT');
  if LotItem <> '' then
    Result.Add('LOT_ITEM');
  if DtaLiq        > 0  then Result.Add('DTA_LIQ');
  if DtaFat        > 0  then Result.Add('DTA_FAT');
  if FkAlmox > 0 then
    Result.Add('FK_ALMOXARIFADOS');
  if FkClassification > 0 then
    Result.Add('FK_CLASSIFICACAO');
  if FkLotacao > 0 then
    Result.Add('FK_LOTACOES');
end;

function TOrderItem.GetFKUnit: TUnit;
begin
  Result := nil;
  if (FFkProduct <> nil) and (FFkProduct.FkUnit <> nil) then
    Result := FFkProduct.FkUnit;
end;

function TOrderItem.GetFlagPend: Boolean;
begin
  Result := (not (FOrderPendings = nil) or (FOrderPendings.Count = 0));
end;

function TOrderItem.GetFlagPrm: Boolean;
begin
  Result := ((FFkPriceTable <> nil) and (FkPriceTable.FlagPrm));
end;

function TOrderItem.GetHasConfig: Boolean;
begin
  Result := ((FConfigItems <> nil) and (FConfigItems.Count > 0));
end;

function TOrderItem.GetLotItem: string;
begin
  Result := FLotItem;
  if (Result <> '') or (FFkProduct = nil) or (FFkProduct.PkProducts > 0) then exit;
  if (Assigned(FOnGetProductLotation)) then
    FOnGetProductLotation(Self, FCodRef, ctReference, FQtdItem, FLotItem);
end;

function TOrderItem.GetPkCompany: Integer;
begin
  Result := FkProduct.ProductCost.FkCompany.PkCompany;
end;

function TOrderItem.GetSubTot: Double;
begin
  Result := QtdItem * VlrUnit;
end;

function TOrderItem.GetTotItem: Double;
var
  i: Integer;
  SumConf: Double;
begin
  SumConf := 0;
  for i := 0 to ConfigItems.Count - 1 do
    SumConf := SumConf +
      (ConfigItems.Items[i].QtdParcial * ConfigItems.Items[i].VlrItem);
  Result := SubTot + SumConf + FVlrAcrDsct;
end;

function TOrderItem.GetVlrTab: Double;
var
  i: Integer;
begin
  Result := 0.0;
  if (FFkProduct <> nil) and (FFkProduct.ProductPrices <> nil) and
     (FFkProduct.ProductPrices.Count > 0) then
  begin
    with FFkProduct.ProductPrices do
    begin
      for i := 0 to Count - 1 do
      begin
        if (Items[i].FkPriceTable.PkPriceTable = FFkPriceTable.PkPriceTable) then
          Result := Items[i].PreVda;
        if (Result = 0) and (Items[i].FkPriceTable.PkPriceTable = 0) then
          Result := Items[i].PreVda;
      end;
    end
  end;
end;

procedure TOrderItem.SetClassFiscal(AValue: string);
begin
  FClassFiscal := Copy(AValue, 1, 20);
end;

procedure TOrderItem.SetCodRef(AValue: string);
begin
  if (AValue <> '') then
    if (Assigned(FOnGetProductData)) then
      FOnGetProductData(Self, AValue, FFkMovement.FlagCod, FQtdItem, FLotItem);
  FCodRef := AValue;
end;

procedure TOrderItem.SetConfigItems(AValue: TConfItems);
begin
  if (AValue = nil) then
    FConfigItems.Clear
  else
    FConfigItems.Assign(AValue);
end;

procedure TOrderItem.SetFkMovement(AValue: TMovement);
begin
  if (AValue = nil) then
    FFkMovement.Clear
  else
    FFkMovement.Assign(AValue);
end;

procedure TOrderItem.SetFkPriceTable(AValue: TPriceTable);
begin
  if (AValue = nil) then
    FFkPriceTable.Clear
  else
    FFkPriceTable.Assign(AValue);
end;

procedure TOrderItem.SetFkProduct(AValue: TProducts);
begin
  if (AValue = nil) then
    FFkProduct.Clear
  else
    FFkProduct.Assign(AValue);
end;

procedure TOrderItem.SetLotItem(AValue: string);
begin
  FLotItem := Copy(AValue, 1, 20);
end;

procedure TOrderItem.SetNumExtr(AValue: string);
begin
  FNumExtr := Copy(AValue, 1, 15);
end;

procedure TOrderItem.SetOrderPendings(AValue: TOrderPendings);
begin
  if (AValue = nil) then
    OrderPendings.Clear
  else
    OrderPendings.Assign(AValue);
end;

procedure TOrderItem.SetSitTrib(AValue: string);
begin
  FSitTrib := Copy(AValue, 1, 3);
end;

procedure TOrderItem.SetVlrUnit(AValue: Double);
begin
  FVlrUnit    := AValue;
  if (VlrTab > 0) then
    FVlrAcrDsct := VlrTab - FVlrUnit;
end;

{
********************************* TOrderItems **********************************
}
constructor TOrderItems.Create(AOwner: TOrder);
begin
  inherited Create(TOrderItem);
  FOwner := AOwner;
  Clear;
end;

destructor TOrderItems.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TOrderItems.Add: TOrderItem;
begin
  Result := inherited Add as TOrderItem;
  ItemIndex := Result.Index;
end;

function TOrderItems.AddOrderItem(Item: TOrderItem): Integer;
var
  aItem: TOrderItem;
begin
  aItem      := Add;
  aItem.Assign(Item);
  Item.Index := aItem.Index;
  Result     := aItem.Index;
end;

procedure TOrderItems.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TOrderItem;
begin
  if (Source <> nil) and (Source is TOrderItems) then
  begin
    for i := 0 to TOrderItems(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TOrderItems(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderItems.Clear;
begin
  inherited Clear;
  FItemIndex := -1;
end;

procedure TOrderItems.Delete(Index: Integer);
begin
  if (Index <= 0) then
    ItemIndex := -1
  else
    if (Index < Count) and (Index > 0) then
      ItemIndex := Index - 1;
  inherited Delete(Index);
end;

function TOrderItems.GetItems(Index: Integer): TOrderItem;
begin
  Result := inherited Items[Index] as TOrderItem;
end;

function TOrderItems.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TOrderItems.Insert(Index: Integer): TOrderItem;
begin
  Result := inherited Insert(Index) as TOrderItem;
  ItemIndex := Result.Index;
end;

procedure TOrderItems.SetItemIndex(AValue: Integer);
begin
  if (Count = 0) then
    FItemIndex := -1
  else
    if (AValue < Count) then
      FItemIndex := AValue
    else
      raise Exception.CreateFmt('OrderItem Count %d: Out of range %d', [Count, AValue]);
end;

procedure TOrderItems.SetItems(Index: Integer; AValue: TOrderItem);
begin
  inherited Items[Index] := AValue
end;

{
******************************** TOrderHistoric ********************************
}
constructor TOrderHistoric.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFkOrderStatus := TOrderStatus.Create;
  Clear;
end;

destructor TOrderHistoric.Destroy;
begin
  if Assigned(FFkOrderStatus) then
    FFkOrderStatus.Free;
  FFkOrderStatus := nil;
  inherited Destroy;
end;

procedure TOrderHistoric.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOrderHistoric) then
  begin
    DscHist     := TOrderHistoric(Source).DscHist;
    FDtHrHist   := TOrderHistoric(Source).DtHrHist;
    FFlagBxaStt := TOrderHistoric(Source).FlagBxaStt;
    if Assigned(FFkOrderStatus) then
      FkOrderStatus := TOrderHistoric(Source).FkOrderStatus;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderHistoric.Clear;
begin
  FDscHist    := '';
  FDtHrHist   := 0;
  FFlagBxaStt := False;
  if Assigned(FFkOrderStatus) then
    FFkOrderStatus.Clear;
end;

function TOrderHistoric.GetDisplayName: string;
begin
  if (FDtHrHist <> 0) then
    Result := DateTimeToStr(FDtHrHist);
  if (Result = '') then inherited GetDisplayName;
end;

procedure TOrderHistoric.SetDscHist(AValue: string);
begin
  FDscHist := Copy(AValue, 1, 100);
end;

procedure TOrderHistoric.SetFkOrderStatus(AValue: TOrderStatus);
begin
  if (AValue = nil) then
    FFkOrderStatus.Clear
  else
    FFkOrderStatus.Assign(AValue);
end;

{
******************************* TOrderHistorics ********************************
}
constructor TOrderHistorics.Create(AOwner: TOrder);
begin
  inherited Create(TOrderHistoric);
  FOwner := AOwner;
  Clear;
end;

destructor TOrderHistorics.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TOrderHistorics.Add: TOrderHistoric;
begin
  Result := inherited Add as TOrderHistoric;
end;

procedure TOrderHistorics.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TOrderHistoric;
begin
  if (Source <> nil) and (Source is TOrderHistorics) then
  begin
    for i := 0 to TOrderHistorics(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TOrderHistorics(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderHistorics.Clear;
begin
  inherited Clear;
end;

procedure TOrderHistorics.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TOrderHistorics.GetItems(Index: Integer): TOrderHistoric;
begin
  Result := inherited Items[Index] as TOrderHistoric;
end;

function TOrderHistorics.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TOrderHistorics.Insert(Index: Integer): TOrderHistoric;
begin
  Result := inherited Insert(Index) as TOrderHistoric;
end;

procedure TOrderHistorics.SetItems(Index: Integer; AValue: TOrderHistoric);
begin
  inherited Items[Index] := AValue
end;

{
********************************** TOrderLink **********************************
}
constructor TOrderLink.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
end;

destructor TOrderLink.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TOrderLink.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOrderLink) then
  begin
    FFkCompany      := TOrderLink(Source).FkCompany;
    FFkDocument     := TOrderLink(Source).FkDocument;
    FFkOwner        := TOrderLink(Source).FkOwner;
    FFkTypeDocument := TOrderLink(Source).FkTypeDocument;
    FFlagTDocument  := TOrderLink(Source).FlagTDocument;
    FResultStatus   := TOrderLink(Source).ResultStatus;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderLink.Clear;
begin
  FFkCompany      := 0;
  FFkDocument     := 0;
  FFkTypeDocument := 0;
  FFkOwner        := 0;
  FFlagTDocument  := otBudget;
  FResultStatus   := 0;
end;

function TOrderLink.GetDisplayName: string;
begin
  Result := '';
  if (FFkDocument > 0) then
    Result := IntToStr(FFkDocument);
  if (Result = '') then Result := inherited GetDisplayName;
end;

{
********************************* TOrderLinks **********************************
}
constructor TOrderLinks.Create(AOwner: TOrder);
begin
  inherited Create(TOrderLink);
  FOwner := AOwner;
  Clear;
end;

destructor TOrderLinks.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TOrderLinks.Add: TOrderLink;
begin
  Result := inherited Add as TOrderLink
end;

procedure TOrderLinks.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TOrderLink;
begin
  if (Source <> nil) and (Source is TOrderLinks) then
  begin
    for i := 0 to TOrderLinks(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TOrderLinks(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderLinks.Clear;
begin
  inherited Clear;
end;

procedure TOrderLinks.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TOrderLinks.GetItems(Index: Integer): TOrderLink;
begin
  Result := inherited Items[Index] as TOrderLink;
end;

function TOrderLinks.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TOrderLinks.Insert(Index: Integer): TOrderLink;
begin
  Result := inherited Insert(Index) as TOrderLink;
end;

procedure TOrderLinks.SetItems(Index: Integer; AValue: TOrderLink);
begin
  inherited Items[Index] := AValue
end;

{
******************************** TOrderMessage *********************************
}
constructor TOrderMessage.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FTextMsg := TStringList.Create;
  Clear;
end;

destructor TOrderMessage.Destroy;
begin
  Clear;
  if Assigned(FTextMsg) then
    FTextMsg.Free;
  FTextMsg := nil;
  inherited Destroy;
end;

procedure TOrderMessage.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOrderMessage) then
  begin
    FDtHrMsg       := TOrderMessage(Source).DtHrMsg;
    FDtHrRcbm      := TOrderMessage(Source).DtHrRcbm;
    FFkDepartament := TOrderMessage(Source).FkDepartament;
    FDscDpto       := TOrderMessage(Source).DscDpto;
    TextMsg        := TOrderMessage(Source).TextMsg;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderMessage.Clear;
begin
  FDtHrMsg       := 0;
  FDtHrRcbm      := 0;
  FFkDepartament := 0;
  FDscDpto       := '';
  if Assigned(FTextMsg) then
    FTextMsg.Clear;
end;

function TOrderMessage.GetDisplayName: string;
begin
  if FDtHrMsg > 0 then
    Result := DateToStr(FDtHrMsg)
  else
    Result := '';
  if (Result = '') then Result := inherited GetDisplayName;
end;

procedure TOrderMessage.SetDscDpto(AValue: string);
begin
  FDscDpto := Copy(AValue, 1, 30);
end;

procedure TOrderMessage.SetTextMsg(AValue: TStrings);
begin
  if (AValue = nil) then
    FTextMsg.Clear
  else
    FTextMsg.Assign(AValue);
end;

{
******************************** TOrderMessages ********************************
}
constructor TOrderMessages.Create(AOwner: TPersistent);
begin
  inherited Create(TOrderMessage);
  FOwner := AOwner;
  Clear;
end;

destructor TOrderMessages.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TOrderMessages.Add: TOrderMessage;
begin
  Result := inherited Add as TOrderMessage;
end;

function TOrderMessages.AddMsg(AValue: TOrderMessage): Integer;
begin
  Result := -1;
  if (AValue <> nil) then
  begin
    with Add do
    begin
      Assign(AValue);
      Result := Index;
    end;
  end;
end;

procedure TOrderMessages.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TOrderMessage;
begin
  if (Source <> nil) and (Source is TOrderMessages) then
  begin
    for i := 0 to TOrderMessages(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TOrderMessages(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TOrderMessages.Clear;
begin
  inherited Clear;
end;

function TOrderMessages.GetItems(Index: Integer): TOrderMessage;
begin
  Result := inherited Items[Index] as TOrderMessage;
end;

function TOrderMessages.GetOwner: TPersistent;
begin
  Result := FOwner;
  if (Result = nil) then Result := inherited GetOwner;
end;

function TOrderMessages.Insert(Index: Integer): TOrderMessage;
begin
  Result := inherited Insert(Index) as TOrderMessage;
end;

procedure TOrderMessages.SetItems(Index: Integer; AValue: TOrderMessage);
begin
  inherited Items[Index] := AValue
end;

{
************************************ TOrder ************************************
}
constructor TOrder.Create(ADecimalPlaces: SmallInt);
begin
  inherited Create;
  GDecimalPlaces     := (ADecimalPlaces * -2);
  FEndEntr           := TStringList.Create;
  FDiscounts         := TDiscounts.Create(Self);
  FFkAgent           := TOwner.Create;
  FFkCarrier         := TOwner.Create;
  FFkCompany         := TCompany.Create;
  FFkMovement        := TMovement.Create;
  FFkOrderStatus     := TOrderStatus.Create;
  FFkOwner           := TOwner.Create;
  FFkPaymentWay      := TPaymentWay.Create(nil);
  FFkPriceTable      := TPriceTable.Create(Self);
  FFkRepresentant    := TOwner.Create;
  FFkTypeDiscount    := TTypeDiscount.Create;
  FFkTypePayment     := TTypePayment.Create;
  FFkVendor          := TOwner.Create;
  FGenDocs           := TOrderLinks.Create(Self);
  FOrderHistorics    := TOrderHistorics.Create(Self);
  FOrderItems        := TOrderItems.Create(Self);
  FOrderLinks        := TOrderLinks.Create(Self);
  FOrderMessages     := TOrderMessages.Create(Self);
  FOrderInstallments := TInstallments.Create(Self);
  Clear;
end;

destructor TOrder.Destroy;
begin
  Clear;
  if Assigned(FEndEntr)           then FEndEntr.Free;
  if Assigned(FDiscounts)         then FDiscounts.Free;
  if Assigned(FFkAgent)           then FFkAgent.Free;
  if Assigned(FFkCarrier)         then FFkCarrier.Free;
  if Assigned(FFkCompany)         then FFkCompany.Free;
  if Assigned(FFkMovement)        then FFkMovement.Free;
  if Assigned(FFkOrderStatus)     then FFkOrderStatus.Free;
  if Assigned(FFkOwner)           then FFkOwner.Free;
  if Assigned(FFkPaymentWay)      then FFkPaymentWay.Free;
  if Assigned(FFkPriceTable)      then FFkPriceTable.Free;
  if Assigned(FFkRepresentant)    then FFkRepresentant.Free;
  if Assigned(FFkTypeDiscount)    then FFkTypeDiscount.Free;
  if Assigned(FFkTypePayment)     then FFkTypePayment.Free;
  if Assigned(FFkVendor)          then FFkVendor.Free;
  if Assigned(FGenDocs)           then FGenDocs.Free;
  if Assigned(FOrderHistorics)    then FOrderHistorics.Free;
  if Assigned(FOrderItems)        then FOrderItems.Free;
  if Assigned(FOrderLinks)        then FOrderLinks.Free;
  if Assigned(FOrderMessages)     then FOrderMessages.Free;
  if Assigned(FOrderInstallments) then FOrderInstallments.Free;
  FEndEntr           := nil;
  FDiscounts         := nil;
  FFkAgent           := nil;
  FFkCarrier         := nil;
  FFkCompany         := nil;
  FFkMovement        := nil;
  FFkOrderStatus     := nil;
  FFkOwner           := nil;
  FFkPaymentWay      := nil;
  FFkPriceTable      := nil;
  FFkRepresentant    := nil;
  FFkTypeDiscount    := nil;
  FFkTypePayment     := nil;
  FFkVendor          := nil;
  FGenDocs           := nil;
  FOrderHistorics    := nil;
  FOrderItems        := nil;
  FOrderLinks        := nil;
  FOrderMessages     := nil;
  FOrderInstallments := nil;
  inherited Destroy;
end;

procedure TOrder.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOrder) then
  begin
    FLoading         := True;
    FAnoPrevEntr     := TOrder(Source).AnoPrevEntr;
    FDspAces         := TOrder(Source).DspAces;
    FDtaBas          := TOrder(Source).DtaBas;
    FDtaCanc         := TOrder(Source).DtaCanc;
    FDtaEntr         := TOrder(Source).DtaEntr;
    FDtaFat          := TOrder(Source).DtaFat;
    FDtaLib          := TOrder(Source).DtaLib;
    FDtaLiq          := TOrder(Source).DtaLiq;
    FDtaPed          := TOrder(Source).DtaPed;
    FDtaRecb         := TOrder(Source).DtaRecb;
    FFkPortoDst      := TOrder(Source).FkPortoDst;
    FFkPortoEmb      := TOrder(Source).FkPortoEmb;
    FFkPurchaseOrder := TOrder(Source).FkPurchaseOrder;
    FFlagCPrvE       := TOrder(Source).FlagCPrvE;
    FFlagDtaBas      := TOrder(Source).FlagDtaBas;
    FFlagEntrParc    := TOrder(Source).FlagEntrParc;
    FFlagCtb         := TOrder(Source).FlagCtb;
    FFlagImp         := TOrder(Source).FlagImp;
    FFlagProd        := TOrder(Source).FlagProd;
    FFlagTPed        := TOrder(Source).FlagTPed;
    FMesPrevEntr     := TOrder(Source).MesPrevEntr;
    FModified        := False;
    FNumExtr         := TOrder(Source).NumExtr;
    FNumProForma     := TOrder(Source).NumProForma;
    FNumVol          := TOrder(Source).NumVol;
    FPesBru          := TOrder(Source).PesBru;
    FPesLiq          := TOrder(Source).PesLiq;
    FPkOrder         := TOrder(Source).PkOrder;
    FkDeliveryPeriod := TOrder(Source).FkDeliveryPeriod;
    FQtdVol          := TOrder(Source).QtdVol;
    FVlrEntr         := TOrder(Source).VlrEntr;
    FVlrFret         := TOrder(Source).VlrFret;
    FVlrSeg          := TOrder(Source).VlrSeg;
    UfEntr           := TOrder(Source).UfEntr;
    FMunEntr         := TOrder(Source).MunEntr;
    FFlagItmDsct     := TOrder(Source).FlagItmDsct;
    FDsctFret        := TOrder(Source).DsctFret;
    FNomCad          := TOrder(Source).NomCad;
    FPlcVei          := TOrder(Source).PlcVei;
    FDtaEmb          := TOrder(Source).DtaEmb;
    FDtaEmbExt       := TOrder(Source).DtaEmbExt;
    FFlagBxaC        := TOrder(Source).FlagBxaC;
    if Assigned(FEndEntr)        then
      EndEntr        := TOrder(Source).EndEntr;
    if Assigned(FFkCompany)      then
      FkCompany := TOrder(Source).FkCompany;
    if Assigned(FFkOwner)        then
      FkOwner := TOrder(Source).FkOwner;
    if Assigned(FFkPriceTable)   then
      FkPriceTable := TOrder(Source).FkPriceTable;
    if Assigned(FOrderItems)     then
      OrderItems := TOrder(Source).OrderItems;
    if Assigned(FFkOrderStatus)  then
      FkOrderStatus := TOrder(Source).FkOrderStatus;
    if Assigned(FFkTypeDiscount) then
      FkTypeDiscount := TOrder(Source).FkTypeDiscount;
    if Assigned(FFkTypePayment)  then
      FkTypePayment := TOrder(Source).FkTypePayment;
    if Assigned(FDiscounts)      then
      Discounts := TOrder(Source).Discounts;
    if Assigned(FFkAgent)        then
      FkAgent   := TOrder(Source).FkAgent;
    if Assigned(FFkCarrier)      then
      FkCarrier := TOrder(Source).FkCarrier;
    if Assigned(FFkMovement)     then
      FkMovement := TOrder(Source).FkMovement;
    if Assigned(FFkPaymentWay)   then
      FkPaymentWay := TOrder(Source).FkPaymentWay;
    if Assigned(FFkRepresentant) then
      FkRepresentant := TOrder(Source).FkRepresentant;
    if Assigned(FFkVendor)       then
      FkVendor := TOrder(Source).FkVendor;
    if Assigned(FGenDocs)     then
      GenDocs := TOrder(Source).GenDocs;
    if Assigned(FOrderHistorics) then
      OrderHistorics := TOrder(Source).OrderHistorics;
    if Assigned(FOrderLinks)     then
      OrderLinks := TOrder(Source).OrderLinks;
    if Assigned(FOrderMessages)  then
      OrderMessages := TOrder(Source).OrderMessages;
    FLoading         := False;
  end
  else
    inherited Assign(Source);
end;

function TOrder.CalcTaxes(const ATaxType: TTypeTax; var ATaxValue: Double): 
        Double;
var
  aPrcTax: Double;
  aCodTax: Integer;
  i: Integer;
begin
  ATaxValue := 0;
  Result    := 0.0;
  for i := 0 to OrderItems.Count - 1 do
  begin
    aPrcTax := GetAliq(ATaxType, i, aCodTax);
    if (aPrcTax > 0) or (aCodTax > 0) then
    begin
      Result   := Result + OrderItems.Items[i].TotItem;
      if (aPrcTax > 0) then
        ATaxValue := ATaxValue + ((Result * aPrcTax) / 100);
    end;
  end;
  if (DsctPerc <> 0) then
  begin
    Result := Result + ((Result * DsctPerc) / 100);
    ATaxValue := ATaxValue + ((ATaxValue * DsctPerc) / 100);
  end;
end;

procedure TOrder.Clear;
begin
  FLoading         := True;
  FAnoPrevEntr     := 0;
  FDspAces         := 0.0;
  FDtaBas          := 0;
  FDtaCanc         := 0;
  FDtaEntr         := 0;
  FDtaFat          := 0;
  FDtaLib          := 0;
  FDtaliq          := 0;
  FDtaPed          := 0;
  FDtaRecb         := 0;
  FFkPortoDst      := 0;
  FFkPortoEmb      := 0;
  FFkPurchaseOrder := 0;
  FFlagCPrvE       := False;
  FFlagDtaBas      := bdOrder;
  FFlagEntrParc    := False;
  FFlagCtb         := False;
  FFlagImp         := False;
  FFlagProd        := False;
  FFlagTPed        := otBudget;
  FMesPrevEntr     := 0;
  FModified        := False;
  FNumExtr         := '';
  FNumProForma     := 0;
  FNumVol          := 0;
  FPesBru          := 0.0;
  FPesLiq          := 0.0;
  FQtdVol          := 0;
  FVlrEntr         := 0.0;
  FVlrFret         := 0.0;
  FVlrSeg          := 0.0;
  FkDeliveryPeriod := 0;
  UfEntr           := '';
  FMunEntr         := 0;
  FDsctFret        := 0.0;
  FFlagItmDsct     := True;
  FNomCad          := '';
  FPlcVei          := '';
  FDtaEmb          := 0;
  FDtaEmbExt       := 0;
  FFlagBxaC        := False;
  if Assigned(FEndEntr)           then FEndEntr.Clear;
  if Assigned(FDiscounts)         then FDiscounts.Clear;
  if Assigned(FFkAgent)           then FFkAgent.Clear;
  if Assigned(FFkCarrier)         then FFkCarrier.Clear;
  if Assigned(FFkCompany)         then FFkCompany.Clear;
  if Assigned(FFkMovement)        then FFkMovement.Clear;
  if Assigned(FFkOrderStatus)     then FFkOrderStatus.Clear;
  if Assigned(FFkOwner)           then FFkOwner.Clear;
  if Assigned(FFkPaymentWay)      then FFkPaymentWay.Clear;
  if Assigned(FFkPriceTable)      then FFkPriceTable.Clear;
  if Assigned(FFkRepresentant)    then FFkRepresentant.Clear;
  if Assigned(FFkTypeDiscount)    then FFkTypeDiscount.Clear;
  if Assigned(FFkTypePayment)     then FFkTypePayment.Clear;
  if Assigned(FFkVendor)          then FFkVendor.Clear;
  if Assigned(FOrderHistorics)    then FOrderHistorics.Clear;
  if Assigned(FOrderItems)        then FOrderItems.Clear;
  if Assigned(FOrderLinks)        then FOrderLinks.Clear;
  if Assigned(FOrderMessages)     then FOrderMessages.Clear;
  if Assigned(FOrderInstallments) then FOrderInstallments.Clear;
  FLoading         := False;
end;

function TOrder.GetAliq(const ATypeTax: TTypeTax; const AIdx: Integer; var 
        ACode: Integer): Double;
begin
  Result := 0.0;
  case ATypeTax of
    ttIcms :
      begin
        Result := OrderItems.Items[AIdx].AlqIcms.TaxPercent;
        ACode  := OrderItems.Items[AIdx].AlqIcms.TaxCode;
      end;
    ttIcmss:
      begin
        Result := OrderItems.Items[AIdx].AlqIcmss.TaxPercent;
        ACode  := OrderItems.Items[AIdx].AlqIcmss.TaxCode;
      end;
    ttIpi  :
      begin
        Result := OrderItems.Items[AIdx].AlqIpi.TaxPercent;
        ACode  := OrderItems.Items[AIdx].AlqIpi.TaxCode;
      end;
    ttIss  :
      begin
        Result := OrderItems.Items[AIdx].AlqIss.TaxPercent;
        ACode  := OrderItems.Items[AIdx].AlqIss.TaxCode;
      end;
    ttOtr  :
      begin
        Result := OrderItems.Items[AIdx].AlqOtr.TaxPercent;
        ACode  := OrderItems.Items[AIdx].AlqOtr.TaxCode;
      end;
  end;
end;

function TOrder.GetBasIcms: Double;
begin
  Result := CalcTaxes(ttIcms, FVlrIcms);
end;

function TOrder.GetBasIcmss: Double;
begin
  Result := CalcTaxes(ttIcmss, FVlrIcmss);
end;

function TOrder.GetBasIpi: Double;
begin
  Result := CalcTaxes(ttIpi, FVlrIpi);
end;

function TOrder.GetBasIsnt: Double;
begin
  Result := TotPed - (BasIcms + BasIcms + BasIpi + BasISS + BasOtr);
end;

function TOrder.GetBasISS: Double;
begin
  Result := CalcTaxes(ttIss, FVlrIss);
end;

function TOrder.GetBasOtr: Double;
begin
  Result := CalcTaxes(ttOtr, FVlrOtr);
end;

function TOrder.GetComVda: Double;
begin
  Result := 0;
end;

function TOrder.GetDocFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_EMPRESAS');
  Result.Add('FK_TIPO_DOCUMENTOS');
  Result.Add('FK_CADASTROS');
  Result.Add('PK_DOCUMENTOS');
  Result.Add('FK_GRUPOS_MOVIMENTOS');
  Result.Add('FK_TIPO_PAGAMENTOS');
  Result.Add('FK_TABELA_PRECOS');
  Result.Add('DATA_DOC');
  Result.Add('FLAG_BXAC');
  Result.Add('FLAG_CTB');
  Result.Add('FLAG_DTABAS');
  Result.Add('FLAG_CANC');
  Result.Add('VLR_STOT');
  Result.Add('VLR_ENTR');
  Result.Add('VLR_ACR_DSCT');
  Result.Add('VLR_DSP_ACES');
  Result.Add('VLR_FRE');
  Result.Add('VLR_SEG');
  Result.Add('VLR_BICMS');
  Result.Add('VLR_ICMS');
  Result.Add('VLR_BICMSS');
  Result.Add('VLR_ICMSS');
  Result.Add('VLR_BISNT');
  Result.Add('VLR_BIPI');
  Result.Add('VAL_IPI');
  Result.Add('VLR_BISS');
  Result.Add('VLR_ISS');
  Result.Add('VAL_TOT');
  Result.Add('PES_LIQ');
  Result.Add('PES_BRU');
  Result.Add('QTD_VOL');
  Result.Add('NUM_VOL');
  if (FTipoVol <> '') then
    Result.Add('TIPO_VOL');
  if (FDtaCanc > 0) then
    Result.Add('DTA_CANC');
  if (FDtaLiq > 0) then
    Result.Add('DTA_LIQ');
  if (FDtaBas > 0) then
    Result.Add('DTA_BAS');
  if (FDtaEmb > 0) then
    Result.Add('DTA_EMB');
  if (FDtaEmbExt > 0) then
    Result.Add('DTA_EMB_EXT');
  if (FNumExtr <> '') then
    Result.Add('NUM_EXTR');
  if (FNumProForma > 0) then
    Result.Add('NUM_PRO_FORMA');
  if (FFkAgent.PkCadastros > 0) then
    Result.Add('FK_VW_AGENTE');
  if (FFkPortoEmb > 0) then
    Result.Add('FK_PORTOS_EMB');
  if (FFkPortoDst > 0) then
    Result.Add('FK_PORTOS_DST');
  if (FFkPurchaseOrder > 0) then
    Result.Add('FK_ORDEM_COMPRA');
  if (FFkDeliveryPeriod > 0) then
    Result.Add('FK_TIPO_PRAZO_ENTREGA');
  if (FFkVendor.PkCadastros > 0) then
    Result.Add('FK_VW_VENDEDORES');
  if (FFkRepresentant.PkCadastros > 0) then
    Result.Add('FK_VW_REPRESENTANTES');
  if (FFkCarrier.PkCadastros > 0) then
    Result.Add('FK_VW_TRANSPORTADORAS');
end;

function TOrder.GetDsctPerc: Double;
begin
  if (VlrAcrDsct <> 0) then
    Result := SubTot / VlrAcrDsct
  else
    Result := 0.0;
end;

function TOrder.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_EMPRESAS');
  Result.Add('PK_PEDIDOS');
  Result.Add('FK_GRUPOS_MOVIMENTOS');
  Result.Add('FK_TIPO_MOVIMENTOS');
  Result.Add('FK_CADASTROS');
  Result.Add('FK_TIPO_STATUS_PEDIDOS');
  Result.Add('KC_PEDIDOS_HISTORICOS');
  Result.Add('KC_PEDIDOS_MENSAGENS');
  Result.Add('KC_PEDIDOS_DESCONTOS');
  Result.Add('FK_TIPO_PAGAMENTOS');
  if (Assigned(FkTypeDiscount)) and (FkTypeDiscount.PkTypeDiscount > 0) then
    Result.Add('FK_TIPO_DESCONTOS');
  if (Assigned(FkVendor)) and (FkVendor.PkCadastros > 0) then
    Result.Add('FK_VW_VENDEDORES');
  if (Assigned(FkRepresentant)) and (FkRepresentant.PkCadastros > 0) then
    Result.Add('FK_VW_REPRESENTANTES');
  if (Assigned(FkCarrier)) and (FkCarrier.PkCadastros > 0) then
    Result.Add('FK_VW_TRANSPORTADORAS');
  if (Assigned(FkAgent)) and (FkAgent.PkCadastros > 0) then
    Result.Add('FK_VW_AGENTE');
  if (FkPortoDst > 0) then
    Result.Add('FK_PORTOS_DST');
  if (FkPortoEmb > 0) then
    Result.Add('FK_PORTOS_EMB');
  if (FkPurchaseOrder > 0) then
    Result.Add('FK_ORDEM_COMPRA');
  if (Assigned(FkPriceTable)) and (FkPriceTable.PkPriceTable > 0) then
    Result.Add('FK_TABELA_PRECOS');
  if (FkDeliveryPeriod > 0) then
    Result.Add('FK_TIPO_PRAZO_ENTREGA');
  if (Assigned(FkPaymentWay)) and (FkPaymentWay.PkPaymentWay > 0) then
    Result.Add('FK_FINALIZADORAS');
  Result.Add('QTD_DUPL');
  Result.Add('QTD_ITEM');
  Result.Add('VLR_FRET');
  Result.Add('VLR_SEG');
  Result.Add('VLR_ENTR');
  Result.Add('DSP_ACES');
  Result.Add('VLR_ACR_DSCT');
  Result.Add('SUB_TOT');
  Result.Add('TOT_PED');
  Result.Add('QTD_VOL');
  Result.Add('PES_LIQ');
  Result.Add('PES_BRU');
  Result.Add('NUM_VOL');
  Result.Add('TIPO_VOL');
  Result.Add('FLAG_ENTR_PARC');
  Result.Add('FLAG_VINC_PED');
  Result.Add('FLAG_PEND');
  Result.Add('FLAG_CPRVE');
  Result.Add('FLAG_IMP');
  Result.Add('FLAG_PROD');
  Result.Add('FLAG_EDRT_RDSP');
  Result.Add('FLAG_DTABAS');
  Result.Add('FLAG_TPED');
  if DtaRecb       > 0  then Result.Add('DTA_RECB');
  if DtaLib        > 0  then Result.Add('DTA_LIB');
  if DtaEntr       > 0  then Result.Add('DTA_ENTR');
  if DtaCanc       > 0  then Result.Add('DTA_CANC');
  if DtaBas        > 0  then Result.Add('DTA_BAS');
  if DtaFat        > 0  then Result.Add('DTA_FAT');
  if DtaLiq        > 0  then Result.Add('DTA_LIQ');
  if MesPrevEntr   > 0  then Result.Add('MES_PREV_ENTR');
  if AnoPrevEntr   > 0  then Result.Add('ANO_PREV_ENTR');
  if NumExtr      <> '' then Result.Add('NUM_EXTR');
  if NumProForma   > 0  then Result.Add('NUM_PRO_FORMA');
  if NomCad       <> '' then Result.Add('NOM_CAD');
end;

function TOrder.GetFlagEDrtRdsp: Boolean;
begin
  Result := (not ((FFkOwner = nil) or (FFkOwner.Customer = nil) or
            (FkOwner.Customer.DeliveryAddress = nil)           or
            (FkOwner.Customer.DeliveryAddress.Address = nil)   or
            (FkOwner.Customer.DeliveryAddress.Address.EndAdd = '')));
end;

function TOrder.GetFlagPend: Boolean;
var
  i, j: Integer;
begin
  Result := False;
  if (OrderItems = nil) or (OrderItems.Count = 0) then exit;
  for i := 0 to OrderItems.Count - 1 do
  begin
    if (OrderItems.Items[i].OrderPendings <> nil) and
       (OrderItems.Items[i].OrderPendings.Count > 0) then
      Result := True;
    if (not Result) and (OrderItems.Items[i].ConfigItems <> nil) and
       (OrderItems.Items[i].ConfigItems.Count > 0) then
    begin
      for j := 0 to OrderItems.Items[i].ConfigItems.Count - 1 do
        if (OrderItems.Items[i].ConfigItems.Items[j].FlagPend) then
          Result := True;
    end;
  end;
end;

function TOrder.GetFlagVincPed: Boolean;
begin
  Result := (not ((OrderLinks = nil) or (OrderLinks.Count = 0)));
end;

function TOrder.GetSubTot: Double;
var
  i: Integer;
begin
  Result  := 0.0;
  if (OrderItems = nil) or (OrderItems.Count = 0) then exit;
  for i := 0 to OrderItems.Count - 1 do
    if (FFlagItmDsct) then
      Result := Result + RoundTo(OrderItems.Items[i].SubTot, GDecimalPlaces)
    else
      Result := Result + RoundTo(OrderItems.Items[i].TotItem, GDecimalPlaces);
end;

function TOrder.GetTotPed: Double;
begin
  Result := SubTot + VlrAcrDsct;
end;

function TOrder.GetVlrAcrDsct: Double;
var
  i, j: Integer;
  aItemDsct: Double;
  aOrderDsct: Double;
  aTotItems: Double;
  
  function GetValue(AType: TTypeOperation; var ASubTot: Double; const AIdx:
          Double): Double;
  begin
    Result := 0.0;
    if AIdx = 0 then exit;
    case AType of
      toPercent : Result := ((ASubTot * AIdx) / 100) * -1;
      toMultiIdx: Result := (ASubTot * AIdx) - ASubTot;
      toDivIdx  : Result := (ASubTot / AIdx) - ASubTot;
      toValue   : Result := AIdx * -1;
    end;
    ASubTot := ASubTot + Result;
  end;
  
begin
  Result := 0.0;
  if (OrderItems <> nil) or (OrderItems.Count > 0) then
  begin
    aItemDsct := 0.0;
    aTotItems := 0.0;
    aOrderDsct := FDsctFret;
    for i := 0 to OrderItems.Count - 1 do
    begin
      aItemDsct := aItemDsct + OrderItems.Items[i].VlrAcrDsct;
      aTotItems := aTotItems + OrderItems.Items[i].TotItem;
    end;
    if (FFkTypeDiscount <> nil) or (FFkTypeDiscount.Discounts <> nil) and
       (FFkTypeDiscount.Discounts.Count > 0) and (FFkOwner <> nil)     then
    begin
      for i := 0 to FFkTypeDiscount.Discounts.Count - 1 do
      begin
        if (FFkTypeDiscount.Discounts.Items[i].FkCategory <> nil) and
           (FFkTypeDiscount.Discounts.Items[i].FkCategory.PkCategory > 0) and
           (FFkOwner.Categories <> nil) and (FFkOwner.Categories.Count > 0) then
        begin
          for j := 0 to FFkOwner.Categories.Count - 1 do
            if (FFkTypeDiscount.Discounts.Items[i].FkCategory.PkCategory =
                FFkOwner.Categories.Items[j].PkCategory) then
              aOrderDsct := aOrderDsct +
                GetValue(FFkTypeDiscount.Discounts.Items[i].FlagTDsct,
                  aTotItems, Discounts.Items[i].IdxDsct);
        end
        else
          if (FFkOwner.Address <> nil) and (FFkOwner.Address.FkCity <> nil)   and
             (FFkOwner.Address.FkCity.FkState <> nil) and
             (FFkOwner.Address.FkCity.FkState.PkState =
                FFkTypeDiscount.Discounts.Items[i].FkState.PkState) then
            aOrderDsct := aOrderDsct +
              GetValue(FFkTypeDiscount.Discounts.Items[i].FlagTDsct,
                aTotItems, Discounts.Items[i].IdxDsct)
          else
            aOrderDsct := aOrderDsct +
              GetValue(FFkTypeDiscount.Discounts.Items[i].FlagTDsct,
                aTotItems, Discounts.Items[i].IdxDsct);
      end;
    end;
    if (FDiscounts <> nil) and (FDiscounts.Count > 0) then
      for i := 0 to FDiscounts.Count - 1 do
      begin
        aOrderDsct := aOrderDsct +
          GetValue(FDiscounts.Items[i].FlagTDsct,
            aTotItems, Discounts.Items[i].IdxDsct);
      end;
    if (FFlagItmDsct) then
      Result := aOrderDsct + aItemDsct
    else
      Result := aOrderDsct;
  end;
end;

function TOrder.GetVlrIcms: Double;
begin
  Result := 0.0;
  if (OrderItems = nil) or (OrderItems.Count = 0) then exit;
  if (BasIcms > 0) then
    Result := FVlrIcms;
end;

function TOrder.GetVlrIcmss: Double;
begin
  Result := 0.0;
  if (OrderItems = nil) or (OrderItems.Count = 0) then exit;
  if (BasIcmss > 0) then
    Result := FVlrIcmss;
end;

function TOrder.GetVlrIpi: Double;
begin
  Result := 0.0;
  if (OrderItems = nil) or (OrderItems.Count = 0) then exit;
  if (BasIpi > 0) then
    Result := FVlrIpi;
end;

function TOrder.GetVlrISS: Double;
begin
  Result := 0.0;
  if (OrderItems = nil) or (OrderItems.Count = 0) then exit;
  if (BasIss > 0) then
    Result := FVlrIss;
end;

function TOrder.GetVlrOtr: Double;
begin
  Result := 0.0;
  if (OrderItems = nil) or (OrderItems.Count = 0) then exit;
  if (BasOtr > 0) then
    Result := FVlrOtr;
end;

procedure TOrder.SetAnoPrevEntr(AValue: SmallInt);
begin
  if not FLoading then
  begin
    if (AValue > 0) and (AValue < Integer(YearOf(Date))) then
      raise Exception.Create('Erro: Campo ano da previsão de entrega inválido');
    if (Modified) and (FPkOrder > 0) and (AValue <> FAnoPrevEntr) then
    begin
      with FOrderHistorics.Add do
      begin
        DscHist       := Format('Modificação do ano da Previsão de Entrega: %d para %d',
                          [AValue, FAnoPrevEntr]);
        DtHrHist      := Now;
        FkOrderStatus := FFkOrderStatus;
      end;
    end;
  end;
  FAnoPrevEntr := AValue;
end;

procedure TOrder.SetDiscounts(AValue: TDiscounts);
begin
  if (AValue = nil) then
    FDiscounts.Clear
  else
    FDiscounts.Assign(AValue);
end;

procedure TOrder.SetDspAces(AValue: Double);
begin
  FDspAces := AValue;
end;

procedure TOrder.SetDtaBas(AValue: TDate);
var
  aItem: TInstallment;
  aDay, aMonth, aYear: Word;
begin
  FDtaBas := AValue;
  if (not FLoading) then
  begin
    if (Modified) and (FPkOrder > 0) and (AValue <> FDtaBas) then
    begin
      with FOrderHistorics.Add do
      begin
        DscHist       := Format('Modificação da Data Base de Faturamento: %s para %s',
                          [FormatDateTime('dd/mm/yyyy', AValue),
                           FormatDateTime('dd/mm/yyyy', FDtaBas)]);
        DtHrHist      := Now;
        FkOrderStatus := FFkOrderStatus;
      end;
    end;
  end;
  if (FFkTypePayment = nil) then exit;
  FFkTypePayment.Installments.Clear;
  if (FFkTypePayment.FlagTVda = tsCash) then
  begin
    aItem := FFkTypePayment.Installments.Add;
    if (FFkOwner.Customer.DiaEms > 0) then
    begin
      aItem.DtaVenc := IncMonth(FDtaBas, 1);
      DecodeDate(aItem.DtaVenc, aDay, aMonth, aYear);
      aDay := FFkOwner.Customer.DiaEms;
      aItem.DtaVenc := EncodeDate(aYear, aMonth, aDay);
    end
    else
      aItem.DtaVenc := FDtaBas;
    aItem.VlrParc := TotPed;
  end;
  if (FFkTypePayment.FlagTVda = tsInReturn) and
     (FFkTypePayment.Installments <> nil) then
  begin
    aItem := FFkTypePayment.Installments.Add;
    aItem.DtaVenc := FDtaBas;
    aItem.VlrParc := TotPed;
  end;
  if (FFkTypePayment.FlagTVda in [tsPeriod, tsFuture]) and
     (FFkTypePayment.Installments <> nil) then
    FFkTypePayment.DocumentValue := TotPed;
  if Assigned(FOnSetInstallments) then
    FOnSetInstallments(Self);
end;

procedure TOrder.SetDtaEntr(AValue: TDate);
begin
  if (not FLoading) then
  begin
    if (AValue > 0) and (AValue < FDtaPed) then
      raise Exception.Create('Error: The Date of delivery can''t be less than ' +
        'Order Date');
    // see if need a param to set a minimium days to delivery
    if (Modified) and (FPkOrder > 0) and (AValue <> FDtaEntr) then
    begin
      with FOrderHistorics.Add do
      begin
        DscHist       := Format('Modificação da Data de Previsão de Entrega: %s para %s',
                          [FormatDateTime('dd/mm/yyyy', AValue),
                           FormatDateTime('dd/mm/yyyy', FDtaEntr)]);
        DtHrHist      := Now;
        FkOrderStatus := FFkOrderStatus;
      end;
    end;
  end;
  FDtaEntr     := AValue;
  if (FDtaEntr > 0) then
  begin
    FAnoPrevEntr := YearOf(FDtaEntr);
    FMesPrevEntr := MonthOf(FDtaEntr);
    if FFlagDtaBas = bdDelivery then
      DtaBas := AValue;
  end;
end;

procedure TOrder.SetDtaFat(AValue: TDate);
begin
  if (AValue = 0) then exit;
  if (not FLoading) then
  begin
    if (DtaLib = 0) or (DtaPed = 0) or (DtaRecb = 0) or (DtaCanc > 0) or
       (DtaLiq > 0) then
      raise Exception.Create('Error: I can''t invoice this document before check ' +
        'all sequences of the document status');
  end;
  FDtaFat := AValue;
  if FFlagDtaBas = bdInvoice then
    DtaBas := AValue;
end;

procedure TOrder.SetDtaLib(AValue: TDate);
begin
  if (AValue = 0) then exit;
  if (not FLoading) then
  begin
    if (DtaPed = 0) or (DtaRecb = 0) or (DtaCanc > 0) or (DtaLiq > 0) then
      raise Exception.Create('Error: I can''t liberate this document before check ' +
        'all sequences of the document status');
  end;
  FDtaLib := AValue;
  if FFlagDtaBas = bdOrder then
    DtaBas := AValue;
end;

procedure TOrder.SetDtaLiq(AValue: TDate);
begin
  if (AValue = 0) then exit;
  if (not FLoading) then
  begin
    if (DtaFat = 0) or (DtaLib = 0) or (DtaPed = 0) or (DtaRecb = 0) or
       (DtaCanc > 0) then
      raise Exception.Create('Error: I can''t invoice this document before check ' +
        'all sequences of the document status');
  end;
  FDtaLiq := AValue;
end;

procedure TOrder.SetDtaPed(AValue: TDate);
begin
  FDtaPed := AValue;
  if (not FLoading) and (PkOrder = 0) and (FDtaPed < Date) then
    FDtaPed := Date;
end;

procedure TOrder.SetDtaRecb(AValue: TDate);
begin
  FDtaRecb := AValue;
end;

procedure TOrder.SetEndEntr(AValue: TStrings);
begin
  if Assigned(AValue) then
    FEndEntr.Assign(AValue)
  else
    FEndEntr.Clear;
end;

procedure TOrder.SetFkAgent(AValue: TOwner);
begin
  if (AValue = nil) then
    FFkAgent.Clear
  else
    FFkAgent.Assign(AValue);
end;

procedure TOrder.SetFkCarrier(AValue: TOwner);
begin
  if (AValue = nil) then
    FFkCarrier.Clear
  else
    FFkCarrier.Assign(AValue);
end;

procedure TOrder.SetFkCompany(AValue: TCompany);
begin
  if (not FLoading) and (Modified) and (AValue <> nil) and (FPkOrder > 0) and
     (AValue.PkCompany <> FFkCompany.PkCompany) then
  begin
    with FOrderHistorics.Add do
    begin
      DscHist       := Format('Modificação da Empresa: %d para %d',
                        [FFkCompany.PkCompany, AValue.PkCompany]);
      DtHrHist      := Now;
      FkOrderStatus := FFkOrderStatus;
    end;
  end;
  FFkCompany.Clear;
  if (AValue <> nil) then
    FFkCompany.Assign(AValue);
end;

procedure TOrder.SetFkMovement(AValue: TMovement);
begin
  if (not FLoading) and (Modified) and (FPkOrder > 0) and (AValue <> nil) and
     ((FFkMovement.PkGroupMovement <> AValue.PkGroupMovement) or
      (FFkMovement.PkTypeMovement <> AValue.PkTypeMovement)) then
  begin
    with FOrderHistorics.Add do
    begin
      DscHist       := Format('Modificação do Tipo de Movimentação: %d/%d para %d/%d',
                        [FFkMovement.PkGroupMovement, FFkMovement.PkTypeMovement,
                         AValue.PkGroupMovement, AValue.PkTypeMovement]);
      DtHrHist      := Now;
      FkOrderStatus := FFkOrderStatus;
    end;
  end;
  FFkMovement.Clear;
  if (AValue <> nil) then
    FFkMovement.Assign(AValue);
end;

procedure TOrder.SetFkOrderStatus(AValue: TOrderStatus);
begin
  if (not FLoading) and (Modified) and (AValue <> nil) and (FPkOrder > 0) and
     (AValue.PkOrderStatus <> FFkOrderStatus.PkOrderStatus) then
  begin
    with FOrderHistorics.Add do
    begin
      if (FFkOrderStatus.DscStt = '') then FFkOrderStatus.DscStt := 'N/A';
      if (AValue.DscStt = '')         then AValue.DscStt := 'N/A';
      DscHist  := Format('Manipulação do Status: %d/%s para %d/%s',
        [FFkOrderStatus.PkOrderStatus, FFkOrderStatus.DscStt,
         AValue.PkOrderStatus, AValue.DscStt]);
      DtHrHist   := Now;
      FkOrderStatus := FFkOrderStatus;
    end;
  end;
  FFkOrderStatus.Clear;
  if (AValue <> nil) then
    FFkOrderStatus.Assign(AValue);
  if FFkOrderStatus.PkOrderStatus > 0 then
  begin
    with FFkOrderStatus do
    begin
      if (osOpened     in FlagStatus) and (DtaPed  = 0) then DtaPed  := Date;
      if (osReceived   in FlagStatus) and (DtaRecb = 0) then DtaRecb := Date;
      if (osLiberated  in FlagStatus) and (DtaLib  = 0) then DtaLib  := Date;
      if (osProduced   in FlagStatus) and (DtaProd = 0) then DtaProd := Date;
      if (osInvoiced   in FlagStatus) and (DtaFat  = 0) then DtaFat  := Date;
      if (osEliminated in FlagStatus) and (DtaLiq  = 0) then DtaLiq  := Date;
      if (osCanceled   in FlagStatus) and (DtaCanc = 0) then DtaCanc := Date;
    end;
  end;
  if Assigned(FOnTypeStatusChange) then
    FOnTypeStatusChange(Self, nfFkTpStatus, FFkOrderStatus.PkOrderStatus);
end;

procedure TOrder.SetFkOwner(AValue: TOwner);
begin
  if (not FLoading) and (Modified) and (AValue <> nil) and (FPkOrder > 0) and
     (AValue.PkCadastros <> FFkOwner.PkCadastros) then
  begin
    with FOrderHistorics.Add do
    begin
      if (FFkOwner.RazSoc = '') then FFkOwner.RazSoc := 'N/A';
      if (AValue.RazSoc = '')   then AValue.RazSoc := 'N/A';
      DscHist  := Format('Modificação do Destinatário: %d/%s para %d/%s',
        [FFkOwner.PkCadastros, FFkOwner.RazSoc,
         AValue.PkCadastros, AValue.RazSoc]);
      DtHrHist      := Now;
      FkOrderStatus := FFkOrderStatus;
    end;
  end;
  FFkOwner.Clear;
  if (AValue <> nil) then
    FFkOwner.Assign(AValue);
  if FFkOwner.PkCadastros > 0 then
  begin
    if Assigned(FOnOwnerChange) then
      FOnOwnerChange(Self, nfFkCadastros, FFkOwner.PkCadastros);
  end;
end;

procedure TOrder.SetFkPaymentWay(AValue: TPaymentWay);
begin
  if (AValue = nil) then
    FFkPaymentWay.Clear
  else
    FFkPaymentWay.Assign(AValue);
end;

procedure TOrder.SetFkPriceTable(AValue: TPriceTable);
begin
  if (not FLoading) and (Modified) and (AValue <> nil) and (FPkOrder > 0) and
     (AValue.PkPriceTable <> FFkPriceTable.PkPriceTable) then
  begin
    with FOrderHistorics.Add do
    begin
      if (FFkPriceTable.DscTab = '') then FFkPriceTable.DscTab := 'N/A';
      if (AValue.DscTab = '')        then AValue.DscTab        := 'N/A';
      DscHist  := Format('Modificação da Tabela de Preços: %d/%s para %d/%s',
        [FFkPriceTable.PkPriceTable, FFkPriceTable.DscTab,
         AValue.PkPriceTable, AValue.DscTab]);
      DtHrHist      := Now;
      FkOrderStatus := FFkOrderStatus;
    end;
  end;
  FFkPriceTable.Clear;
  if (AValue <> nil) then
    FFkPriceTable.Assign(AValue);
end;

procedure TOrder.SetFkRepresentant(AValue: TOwner);
begin
  if (not FLoading) and (Modified) and (AValue <> nil) and (FPkOrder > 0) and
     (AValue.PkCadastros <> FFkRepresentant.PkCadastros) then
  begin
    with FOrderHistorics.Add do
    begin
      if (FFkRepresentant.RazSoc = '') then FFkRepresentant.RazSoc := 'N/A';
      if (AValue.RazSoc          = '') then AValue.RazSoc          := 'N/A';
      DscHist  := Format('Modificação do Representante: %d/%s para %d/%s',
        [FFkRepresentant.PkCadastros, FFkRepresentant.RazSoc,
         AValue.PkCadastros, AValue.RazSoc]);
      DtHrHist      := Now;
      FkOrderStatus := FFkOrderStatus;
    end;
  end;
  FFkRepresentant.Clear;
  if (AValue <> nil) then
    FFkRepresentant.Assign(AValue);
end;

procedure TOrder.SetFkTypeDiscount(AValue: TTypeDiscount);
begin
  if (not FLoading) and (Modified) and (AValue <> nil) and (FPkOrder > 0) and
     (AValue.PkTypeDiscount <> FFkTypeDiscount.PkTypeDiscount) then
  begin
    with FOrderHistorics.Add do
    begin
      if (FFkTypeDiscount.DscDsct = '') then FFkTypeDiscount.DscDsct := 'N/A';
      if (AValue.DscDsct          = '') then AValue.DscDsct          := 'N/A';
      DscHist  := Format('Modificação do Tipo de Descontos: %d/%s para %d/%s',
        [FFkTypeDiscount.PkTypeDiscount, FFkTypeDiscount.DscDsct,
         AValue.PkTypeDiscount, AValue.DscDsct]);
      DtHrHist      := Now;
      FkOrderStatus := FFkOrderStatus;
    end;
  end;
  FFkTypeDiscount.Clear;
  if (AValue <> nil) then
    FFkTypeDiscount.Assign(AValue);
end;

procedure TOrder.SetFkTypePayment(AValue: TTypePayment);
begin
  if (AValue = nil) then
    FFkTypePayment.Clear
  else
    FFkTypePayment.Assign(AValue);
  if FDtaBas > 0 then SetDtaBas(FDtaBas);
end;

procedure TOrder.SetFkVendor(AValue: TOwner);
begin
  if (not FLoading) and (Modified) and (AValue <> nil) and (FPkOrder > 0) and
     (AValue.PkCadastros <> FFkVendor.PkCadastros) then
  begin
    with FOrderHistorics.Add do
    begin
      if (FFkVendor.RazSoc = '') then FFkVendor.RazSoc := 'N/A';
      if (AValue.RazSoc    = '') then AValue.RazSoc    := 'N/A';
      DscHist  := Format('Modificação do Vendedor: %d/%s para %d/%s',
        [FFkVendor.PkCadastros, FFkVendor.RazSoc,
         AValue.PkCadastros, AValue.RazSoc]);
      DtHrHist      := Now;
      FkOrderStatus := FFkOrderStatus;
    end;
  end;
  FFkVendor.Clear;
  if (AValue <> nil) then
    FFkVendor.Assign(AValue);
end;

procedure TOrder.SetGenDocs(Value: TOrderLinks);
begin
  if (Value = nil) then
    FGenDocs.Clear
  else
    FGenDocs.Assign(Value);
end;

procedure TOrder.SetMesPrevEntr(AValue: SmallInt);
begin
  if (not FLoading) then
  begin
    if (AValue > 0) and ((AValue < 1) or (AValue > 12)) then
      raise Exception.Create('Erro: Campo mês da previsão de entrega inválido');
    if (Modified) and (FPkOrder > 0) and (AValue <> FMesPrevEntr) then
    begin
      with FOrderHistorics.Add do
      begin
        DscHist       := Format('Manipulação do mês de Previsão de Entrega: %d para %d',
                          [FMesPrevEntr, AValue]);
        DtHrHist      := Now;
        FkOrderStatus := FFkOrderStatus;
      end;
    end;
  end;
  FMesPrevEntr := AValue;
end;

procedure TOrder.SetNomCad(Value: string);
begin
  FNomCad := Copy(Value, 1, 50);
end;

procedure TOrder.SetNumExtr(AValue: string);
begin
  FNumExtr := Copy(AValue, 1, 15);
end;

procedure TOrder.SetOrderHistorics(AValue: TOrderHistorics);
begin
  if (AValue = nil) then
    FOrderHistorics.Clear
  else
    FOrderHistorics.Assign(AValue);
end;

procedure TOrder.SetOrderInstallments(AValue: TInstallments);
begin
  if (AValue = nil) then
    FOrderInstallments.Clear
  else
    FOrderInstallments.Assign(AValue);
end;

procedure TOrder.SetOrderItems(AValue: TOrderItems);
begin
  if (AValue = nil) then
    FOrderItems.Clear
  else
    FOrderItems.Assign(AValue);
end;

procedure TOrder.SetOrderLinks(AValue: TOrderLinks);
begin
  if (AValue = nil) then
    FOrderLinks.Clear
  else
    FOrderLinks.Assign(AValue);
end;

procedure TOrder.SetOrderMessages(AValue: TOrderMessages);
begin
  if (AValue = nil) then
    FOrderMessages.Clear
  else
    FOrderMessages.Assign(AValue);
end;

procedure TOrder.SetPlcVei(Value: string);
begin
  FPlcVei := Copy(Value, 1, 10);
end;

procedure TOrder.SetTipoVol(AValue: string);
begin
  FTipoVol := Copy(AValue, 1, 20);
end;

procedure TOrder.SetUfEntr(AValue: string);
begin
  FUfEntr := Copy(AValue, 1, 2);
end;

procedure TOrder.SortCompany(ALo, AHi: Integer);
var
  i, j: Integer;
  aHiItem, aLoItem: TOrderItem;
begin
  for i := AHi downto ALo do // Buble Sort
  begin
    for j := ALo to AHi - 1 do
    begin
      if (OrderItems.Items[j].PkCompany > OrderItems.Items[J + 1].PkCompany) then
      begin
        aLoItem := TOrderItem.Create(nil);
        aHiItem := TOrderItem.Create(nil);
        try
          aLoItem.Assign(OrderItems.Items[j]);
          aHiItem.Assign(OrderItems.Items[j + 1]);
          OrderItems.Items[j].Clear;
          OrderItems.Items[j + 1].Clear;
          OrderItems.Items[j].Assign(aHiItem);
          OrderItems.Items[j + 1].Assign(aLoItem);
        finally
          FreeAndNil(aLoItem);
          FreeAndNil(aHiItem);
        end; // end Try
      end; // end if
    end; // end for j
  end; // end for i
end;


end.

