unit TSysEstq;

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

uses SysUtils, Classes, TSysEstqAux, TSysConfAux, TSysMan, TSysPedAux, 
     TSysCad, ProcUtils, TSysCtbAux, TSysFatAux, 
     {$IFDEF WIN32} Controls {$ENDIF} 
     {$IFDEF LINUX} QControls {$ENDIF};

type

// 0 ==> Liberado
// 1 ==> Normal
// 2 ==> Assegurado
// 3 ==> Crítico
  TInspectionType  = (itFree, itNormal, itEnsured, itCritic);

  TProductTypes = set of TTypeInsumos; // set of all products types

// 0 ==> Nenhuma
// 1 ==> Peso
// 2 ==> Percentual Nota Fiscal
// 3 ==> Volume (m3)
// 4 ==> Quantidade de Volumes
  TTypeFraction = (tfNone, tfWeight, tfPercentNF, tfVolume, tfQtdVol);

// 0 ==> Frete pago
// 1 ==> Frete a pagar
// 2 ==> Frete Consignado de Coleta
// 3 ==> Frete Consignado de Entrega
  TTypeCarrier = (tcCIF, tcFOB, tcSuppCollect, tcSuppDelivery);

  TProductCompositions = class;
     
  TProducts = class;
  
  TProductComposition = class (TCollectionItem)
  private
    FDscIns: string;
    FFkInsumos: Integer;
    FFlagDef: Boolean;
    FFlagTComp: Integer;
    FMedDef: Double;
    FQtdProd: Double;
    FSeqComp: Integer;
    function GetFkCompositions: Integer;
    function GetFkProduct: Integer;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property DscIns: string read FDscIns write FDscIns;
    property FkCompositions: Integer read GetFkCompositions;
    property FkInsumos: Integer read FFkInsumos write FFkInsumos;
    property FkProduct: Integer read GetFkProduct;
    property FlagDef: Boolean read FFlagDef write FFlagDef;
    property FlagTComp: Integer read FFlagTComp write FFlagTComp;
    property Index;
    property MedDef: Double read FMedDef write FMedDef;
    property QtdProd: Double read FQtdProd write FQtdProd;
    property SeqComp: Integer read FSeqComp write FSeqComp;
  end;
  
  TProductCompositions = class (TCollection)
  private
    FDscComp: string;
    FFlagAtv: Boolean;
    FOwner: TPersistent;
    FPkCompositions: Integer;
    function GetItems(Index: Integer): TProductComposition;
    procedure SetDscComp(Value: string);
    procedure SetItems(Index: Integer; AValue: TProductComposition);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TProductComposition;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TProductComposition;
    property Count;
    property DscComp: string read FDscComp write SetDscComp;
    property FlagAtv: Boolean read FFlagAtv write FFlagAtv;
    property Items[Index: Integer]: TProductComposition read GetItems write 
            SetItems;
    property PkCompositions: Integer read FPkCompositions write FPkCompositions;
  end;
  
  TProductCarrier = class (TPersistent)
  private
    FFkProduct: Integer;
    FFlagRdsp: Boolean;
    FFlagTCarrier: TTypeCarrier;
  public
    constructor Create(APkProduct: Integer);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property FkProduct: Integer read FFkProduct write FFkProduct;
    property FlagRdsp: Boolean read FFlagRdsp write FFlagRdsp;
    property FlagTCarrier: TTypeCarrier read FFlagTCarrier write FFlagTCarrier 
            default tcCIF;
  end;
  
  TProductService = class (TPersistent)
  private
    FcbIndex: Integer;
    FCompositions: TProductCompositions;
    FFkProduct: Integer;
    FFlagAtv: Boolean;
    FProductCarrier: TProductCarrier;
    FVlrUnit: Double;
    procedure SetCompositions(Value: TProductCompositions);
    procedure SetProductCarrier(Value: TProductCarrier);
  public
    constructor Create(APkProduct: Integer);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property Compositions: TProductCompositions read FCompositions write 
            SetCompositions;
    property FkProduct: Integer read FFkProduct;
    property FlagAtv: Boolean read FFlagAtv write FFlagAtv;
    property ProductCarrier: TProductCarrier read FProductCarrier write 
            SetProductCarrier;
    property VlrUnit: Double read FVlrUnit write FVlrUnit;
  end;
  
  TPermissionEvent = procedure (Sender: TObject; var Allowed: Boolean) of 
          object;
  TProductTax = class (TCollectionItem)
  private
    FAlqTax: Double;
    FDscTax: string;
    FFkTaxType: Integer;
    FFlagBase: Integer;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property AlqTax: Double read FAlqTax write FAlqTax;
    property DisplayName;
    property DscTax: string read FDscTax write FDscTax;
    property FkTaxType: Integer read FFkTaxType write FFkTaxType default 0;
    property FlagBase: Integer read FFlagBase write FFlagBase;
    property Index;
  end;
  
  TProductTaxes = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TProductTax;
    procedure SetItems(Index: Integer; AValue: TProductTax);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TProductTax;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TProductTax;
    property Count;
    property Items[Index: Integer]: TProductTax read GetItems write SetItems;
  end;
  
  TProductSupplier = class (TCollectionItem)
  private
    FDtaGrnt: TDate;
    FFkCompany: TCompany;
    FFkSupplier: TOwner;
    FFkTypeDsct: TTypeDiscount;
    FFkUnit: TUnit;
    FFlagInsp: TInspectionType;
    FFlagRjst: Boolean;
    FFreteIns: Double;
    FObsForn: TStrings;
    FPreFinal: Double;
    FPreTab: Double;
    FQtdDiasEntr: Integer;
    FQtdGrnt: Double;
    FQtdUni: Double;
    FSitTrib: string;
    procedure SetFkCompany(AValue: TCompany);
    procedure SetFkSupplier(AValue: TOwner);
    procedure SetFkTypeDsct(AValue: TTypeDiscount);
    procedure SetFkUnit(AValue: TUnit);
    procedure SetObsForn(AValue: TStrings);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property DisplayName;
    property DtaGrnt: TDate read FDtaGrnt write FDtaGrnt;
    property FkCompany: TCompany read FFkCompany write SetFkCompany;
    property FkSupplier: TOwner read FFkSupplier write SetFkSupplier;
    property FkTypeDsct: TTypeDiscount read FFkTypeDsct write SetFkTypeDsct;
    property FkUnit: TUnit read FFkUnit write SetFkUnit;
    property FlagInsp: TInspectionType read FFlagInsp write FFlagInsp default 
            itFree;
    property FlagRjst: Boolean read FFlagRjst write FFlagRjst;
    property FreteIns: Double read FFreteIns write FFreteIns;
    property Index;
    property ObsForn: TStrings read FObsForn write SetObsForn;
    property PreFinal: Double read FPreFinal write FPreFinal;
    property PreTab: Double read FPreTab write FPreTab;
    property QtdDiasEntr: Integer read FQtdDiasEntr write FQtdDiasEntr;
    property QtdGrnt: Double read FQtdGrnt write FQtdGrnt;
    property QtdUni: Double read FQtdUni write FQtdUni;
    property SitTrib: string read FSitTrib write FSitTrib;
  end;
  
  TProductSuppliers = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TProductSupplier;
    procedure SetItems(Index: Integer; AValue: TProductSupplier);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TProductSupplier;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TProductSupplier;
    property Count;
    property Items[Index: Integer]: TProductSupplier read GetItems write 
            SetItems;
  end;
  
  TProductCost = class (TPersistent)
  private
    FCustFinal: Double;
    FCustForn: Double;
    FCustMed: Double;
    FCustReal: Double;
    FCustRjst: Double;
    FCustUFrn: Double;
    FDtaPrvEntrCompra: TDate;
    FDtaUCmp: TDate;
    FDtaUInv: TDate;
    FDtaUMov: TDate;
    FDtaURsv: TDate;
    FDtaUSld: TDate;
    FFkCompany: TCompany;
    FFkSupplier: TOwner;
    FFlagRjst: Boolean;
    FQtdCmpMed: Double;
    FQtdCnsMed: Double;
    FQtdDiasEntr: Integer;
    FQtdDiasEstq: Integer;
    FQtdDiasRep: Integer;
    FQtdEMax: Double;
    FQtdEMin: Double;
    FQtdEstq: Double;
    FQtdEstqQR: Double;
    FQtdGrnt: Double;
    FQtdPedF: Double;
    FQtdRsrv: Double;
    function GetEstqDspn: Double;
    function GetEstqPrev: Double;
    procedure SetFkCompany(AValue: TCompany);
    procedure SetFkSupplier(Value: TOwner);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property CustFinal: Double read FCustFinal write FCustFinal;
    property CustForn: Double read FCustForn write FCustForn;
    property CustMed: Double read FCustMed write FCustMed;
    property CustReal: Double read FCustReal write FCustReal;
    property CustRjst: Double read FCustRjst write FCustRjst;
    property CustUFrn: Double read FCustUFrn write FCustUFrn;
    property DtaPrvEntrCompra: TDate read FDtaPrvEntrCompra write 
            FDtaPrvEntrCompra;
    property DtaUCmp: TDate read FDtaUCmp write FDtaUCmp;
    property DtaUInv: TDate read FDtaUInv write FDtaUInv;
    property DtaUMov: TDate read FDtaUMov write FDtaUMov;
    property DtaURsv: TDate read FDtaURsv write FDtaURsv;
    property DtaUSld: TDate read FDtaUSld write FDtaUSld;
    property EstqDspn: Double read GetEstqDspn;
    property EstqPrev: Double read GetEstqPrev;
    property FkCompany: TCompany read FFkCompany write SetFkCompany;
    property FkSupplier: TOwner read FFkSupplier write SetFkSupplier;
    property FlagRjst: Boolean read FFlagRjst write FFlagRjst;
    property QtdCmpMed: Double read FQtdCmpMed write FQtdCmpMed;
    property QtdCnsMed: Double read FQtdCnsMed write FQtdCnsMed;
    property QtdDiasEntr: Integer read FQtdDiasEntr write FQtdDiasEntr;
    property QtdDiasEstq: Integer read FQtdDiasEstq write FQtdDiasEstq;
    property QtdDiasRep: Integer read FQtdDiasRep write FQtdDiasRep;
    property QtdEMax: Double read FQtdEMax write FQtdEMax;
    property QtdEMin: Double read FQtdEMin write FQtdEMin;
    property QtdEstq: Double read FQtdEstq write FQtdEstq;
    property QtdEstqQR: Double read FQtdEstqQR write FQtdEstqQR;
    property QtdGrnt: Double read FQtdGrnt write FQtdGrnt;
    property QtdPedF: Double read FQtdPedF write FQtdPedF;
    property QtdRsrv: Double read FQtdRsrv write FQtdRsrv;
  end;
  
  TProductPrice = class (TCollectionItem)
  private
    FFkCompany: TCompany;
    FFkPriceTable: TPriceTable;
    FFlagFix: Boolean;
    FPreVda: Double;
    procedure SetFkCompany(AValue: TCompany);
    procedure SetFkPriceTable(AValue: TPriceTable);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property FkCompany: TCompany read FFkCompany write SetFkCompany;
    property FkPriceTable: TPriceTable read FFkPriceTable write SetFkPriceTable;
    property FlagFix: Boolean read FFlagFix write FFlagFix default False;
    property Index;
    property PreVda: Double read FPreVda write FPreVda;
  end;
  
  TProductPrices = class (TCollection)
  private
    FFkClassFisc: TClassFisc;
    FFkCompany: TCompany;
    FFkOrigimTrib: TOrigimTrib;
    FFkSitTrib: TSitTrib;
    FMrgLcr: Double;
    FOwner: TPersistent;
    function GetItems(Index: Integer): TProductPrice;
    function GetSitTrb: string;
    procedure SetFkClassFisc(AValue: TClassFisc);
    procedure SetFkCompany(AValue: TCompany);
    procedure SetFkOrigimTrib(AValue: TOrigimTrib);
    procedure SetFkSitTrib(AValue: TSitTrib);
    procedure SetItems(Index: Integer; AValue: TProductPrice);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TProductPrice;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function GetFields: TStrings;
    function Insert(Index: Integer): TProductPrice;
    property Count;
    property FkClassFisc: TClassFisc read FFkClassFisc write SetFkClassFisc;
    property FkCompany: TCompany read FFkCompany write SetFkCompany;
    property FkOrigimTrib: TOrigimTrib read FFkOrigimTrib write SetFkOrigimTrib;
    property FkSitTrib: TSitTrib read FFkSitTrib write SetFkSitTrib;
    property Items[Index: Integer]: TProductPrice read GetItems write SetItems;
    property MrgLcr: Double read FMrgLcr write FMrgLcr;
    property SitTrb: string read GetSitTrb;
  end;
  
  TProductCode = class (TCollectionItem)
  private
    FCodRef: string;
    FDscCode: string;
    FFlagTBarCode: TBarCode;
    FFlagTCode: TCodeTypes;
    FPkProductCode: Integer;
    procedure SetCodRef(AValue: string);
    procedure SetDscCode(AValue: string);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property CodRef: string read FCodRef write SetCodRef;
    property DisplayName;
    property DscCode: string read FDscCode write SetDscCode;
    property FlagTBarCode: TBarCode read FFlagTBarCode write FFlagTBarCode 
            default bcNone;
    property FlagTCode: TCodeTypes read FFlagTCode write FFlagTCode default 
            pcReference;
    property Index;
    property PkProductCode: Integer read FPkProductCode write FPkProductCode;
  end;
  
  TProductCodes = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TProductCode;
    procedure SetItems(Index: Integer; AValue: TProductCode);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TProductCode;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TProductCode;
    property Count;
    property Items[Index: Integer]: TProductCode read GetItems write SetItems;
  end;
  
  TProductPurchase = class (TPersistent)
  private
    FFkReferenceType: TReferenceType;
    FFlagCmpr: Boolean;
    FFlagEmp: Boolean;
    FFlagTMat: TMaterialType;
    FOwner: TPersistent;
    FVlrUnit: Double;
    procedure SetFkReferenceType(AValue: TReferenceType);
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property FkReferenceType: TReferenceType read FFkReferenceType write 
            SetFkReferenceType;
    property FlagCmpr: Boolean read FFlagCmpr write FFlagCmpr default True;
    property FlagEmp: Boolean read FFlagEmp write FFlagEmp default True;
    property FlagTMat: TMaterialType read FFlagTMat write FFlagTMat default 
            mtPurchase;
    property VlrUnit: Double read FVlrUnit write FVlrUnit;
  end;
  
  TProductSale = class (TPersistent)
  private
    FAltProd: Double;
    FComItem: Double;
    FDscRed: string;
    FEmbAltProd: Double;
    FEmbLargProd: Double;
    FEmbProfProd: Double;
    FFatConvCub: Double;
    FFkLines: TLines;
    FFkSimilar: TSimilar;
    FFlagImp: Boolean;
    FFlagTProd: TProductType;
    FIntAltProd: Double;
    FIntLargProd: Double;
    FIntProfProd: Double;
    FLargProd: Double;
    FOwner: TPersistent;
    FPesBru: Double;
    FPesLiq: Double;
    FProfProd: Double;
    function GetVlrCub: Double;
    procedure SetDscRed(AValue: string);
    procedure SetFkLines(AValue: TLines);
    procedure SetFkSimilar(AValue: TSimilar);
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property AltProd: Double read FAltProd write FAltProd;
    property ComItem: Double read FComItem write FComItem;
    property DscRed: string read FDscRed write SetDscRed;
    property EmbAltProd: Double read FEmbAltProd write FEmbAltProd;
    property EmbLargProd: Double read FEmbLargProd write FEmbLargProd;
    property EmbProfProd: Double read FEmbProfProd write FEmbProfProd;
    property FatConvCub: Double read FFatConvCub write FFatConvCub;
    property FkLines: TLines read FFkLines write SetFkLines;
    property FkSimilar: TSimilar read FFkSimilar write SetFkSimilar;
    property FlagImp: Boolean read FFlagImp write FFlagImp;
    property FlagTProd: TProductType read FFlagTProd write FFlagTProd default 
            ptSale;
    property IntAltProd: Double read FIntAltProd write FIntAltProd;
    property IntLargProd: Double read FIntLargProd write FIntLargProd;
    property IntProfProd: Double read FIntProfProd write FIntProfProd;
    property LargProd: Double read FLargProd write FLargProd;
    property PesBru: Double read FPesBru write FPesBru;
    property PesLiq: Double read FPesLiq write FPesLiq;
    property ProfProd: Double read FProfProd write FProfProd;
    property VlrCub: Double read GetVlrCub;
  end;
  
  TProducts = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscProd: string;
    FFkProductGroup: Integer;
    FFkUnit: TUnit;
    FFlagAtv: Boolean;
    FFlagMatT: TMaterialType;
    FFlagPrdT: TProductType;
    FFlagTProd: TTypeInsumos;
    FMode: TDBMode;
    FOnChangeType: TPermissionEvent;
    FPkProducts: Integer;
    FProductCodes: TProductCodes;
    FProductCost: TProductCost;
    FProductPrices: TProductPrices;
    FProductPurchase: TProductPurchase;
    FProductSale: TProductSale;
    FProductService: TProductService;
    FProductSuppliers: TProductSuppliers;
    FProductTaxes: TProductTaxes;
    FQtdUni: Double;
    procedure SetDscProd(AValue: string);
    procedure SetFkUnit(AValue: TUnit);
    procedure SetFlagMatT(AValue: TMaterialType);
    procedure SetFlagPrdT(AValue: TProductType);
    procedure SetFlagTProd(AValue: TTypeInsumos);
    procedure SetMode(AValue: TDBMode);
    procedure SetProductCodes(AValue: TProductCodes);
    procedure SetProductCost(AValue: TProductCost);
    procedure SetProductPrices(AValue: TProductPrices);
    procedure SetProductPurchase(AValue: TProductPurchase);
    procedure SetProductSale(AValue: TProductSale);
    procedure SetProductService(Value: TProductService);
    procedure SetProductSuppliers(AValue: TProductSuppliers);
    procedure SetProductTaxes(AValue: TProductTaxes);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; overload;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscProd: string read FDscProd write SetDscProd;
    property FkProductGroup: Integer read FFkProductGroup write FFkProductGroup;
    property FkUnit: TUnit read FFkUnit write SetFkUnit;
    property FlagAtv: Boolean read FFlagAtv write FFlagAtv default True;
    property FlagMatT: TMaterialType read FFlagMatT write SetFlagMatT default 
            mtNone;
    property FlagPrdT: TProductType read FFlagPrdT write SetFlagPrdT default 
            ptSale;
    property FlagTProd: TTypeInsumos read FFlagTProd write SetFlagTProd default 
            tiSale;
    property Mode: TDBMode read FMode write SetMode;
    property OnChangeType: TPermissionEvent read FOnChangeType write 
            FOnChangeType;
    property PkProducts: Integer read FPkProducts write FPkProducts;
    property ProductCodes: TProductCodes read FProductCodes write 
            SetProductCodes;
    property ProductCost: TProductCost read FProductCost write SetProductCost;
    property ProductPrices: TProductPrices read FProductPrices write 
            SetProductPrices;
    property ProductPurchase: TProductPurchase read FProductPurchase write 
            SetProductPurchase;
    property ProductSale: TProductSale read FProductSale write SetProductSale;
    property ProductService: TProductService read FProductService write 
            SetProductService;
    property ProductSuppliers: TProductSuppliers read FProductSuppliers write 
            SetProductSuppliers;
    property ProductTaxes: TProductTaxes read FProductTaxes write 
            SetProductTaxes;
    property QtdUni: Double read FQtdUni write FQtdUni;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  

implementation

{
***************************** TProductComposition ******************************
}
constructor TProductComposition.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
end;

destructor TProductComposition.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TProductComposition.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProductComposition) then
  begin
    FDscIns    := TProductComposition(Source).DscIns;
    FFkInsumos := TProductComposition(Source).FkInsumos;
    FFlagDef   := TProductComposition(Source).FlagDef;
    FlagTComp  := TProductComposition(Source).FlagTComp;
    FMedDef    := TProductComposition(Source).MedDef;
    FQtdProd   := TProductComposition(Source).QtdProd;
    FSeqComp   := TProductComposition(Source).SeqComp;
  end
  else
    inherited Assign(Source);
end;

procedure TProductComposition.Clear;
begin
  FDscIns    := '';
  FFkInsumos := 0;
  FFlagDef   := False;
  FlagTComp  := 0;
  FMedDef    := 0.0;
  FQtdProd   := 0.0;
  FSeqComp   := 0;
end;

function TProductComposition.GetDisplayName: string;
begin
  Result := DscIns;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TProductComposition.GetFkCompositions: Integer;
begin
  Result := 0;
  if (Collection <> nil) and (Collection is TProductCompositions) then
    Result := TProductCompositions(Collection).PkCompositions;
end;

function TProductComposition.GetFkProduct: Integer;
begin
  Result := 0;
  if (Collection is TProductCompositions) and
     (TProductCompositions(Collection).Owner <> nil) and
     (TProductCompositions(Collection).Owner is TProducts) then
    Result := TProducts(TProductCompositions(Collection).Owner).PkProducts;
end;

{
***************************** TProductCompositions *****************************
}
constructor TProductCompositions.Create(AOwner: TPersistent);
begin
  inherited Create(TProductComposition);
  FOwner := AOwner;
end;

destructor TProductCompositions.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

function TProductCompositions.Add: TProductComposition;
begin
  Result := inherited Add as TProductComposition;
end;

procedure TProductCompositions.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TProductComposition;
begin
  if (Source <> nil) and (Source is TProductCompositions) then
  begin
    for i := 0 to TProductCompositions(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TProductCompositions(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TProductCompositions.Clear;
begin
  inherited Clear;
  DscComp := '';
  FlagAtv := False;
end;

procedure TProductCompositions.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TProductCompositions.GetItems(Index: Integer): TProductComposition;
begin
  Result := inherited Items[Index] as TProductComposition;
end;

function TProductCompositions.GetOwner: TPersistent;
begin
  if Assigned(FOwner) then
    Result := FOwner
  else
    Result := inherited GetOwner;
end;

function TProductCompositions.Insert(Index: Integer): TProductComposition;
begin
  Result := inherited Insert(Index) as TProductComposition;
end;

procedure TProductCompositions.SetDscComp(Value: string);
begin
  FDscComp := Copy(Value, 1, 100);
end;

procedure TProductCompositions.SetItems(Index: Integer; AValue: 
        TProductComposition);
begin
  inherited Items[Index] := AValue
end;

{
******************************* TProductCarrier ********************************
}
constructor TProductCarrier.Create(APkProduct: Integer);
begin
  Clear;
  FFkProduct := APkProduct;
end;

destructor TProductCarrier.Destroy;
begin
  Clear;
  FFkProduct := 0;
  inherited Destroy;
end;

procedure TProductCarrier.Assign(Source: TPersistent);
begin
  if (Assigned(Source)) and (Source is TProductCarrier) then
  begin
    FFkProduct    := TProductCarrier(Source).FkProduct;
    FFlagRdsp     := TProductCarrier(Source).FlagRdsp;
    FFlagTCarrier := TProductCarrier(Source).FlagTCarrier;
  end
  else
    inherited Assign(Source);
end;

procedure TProductCarrier.Clear;
begin
  FFkProduct    := 0;
  FFlagRdsp     := False;
  FFlagTCarrier := tcCIF;
end;

{
******************************* TProductService ********************************
}
constructor TProductService.Create(APkProduct: Integer);
begin
  inherited Create;
  FFkProduct      := APkProduct;
  FProductCarrier := TProductCarrier.Create(APkProduct);
  FCompositions   := TProductCompositions.Create(Self);
  Clear;
end;

destructor TProductService.Destroy;
begin
  Clear;
  if Assigned(FProductCarrier) then
    FProductCarrier.Free;
  if Assigned(FCompositions) then
    FCompositions.Free;
  FProductCarrier := nil;
  FCompositions   := nil;
  FFkProduct      := 0;
  inherited Destroy;
end;

procedure TProductService.Assign(Source: TPersistent);
begin
  if (Assigned(Source)) and (Source is TProductService) then
  begin
    FFkProduct       := TProductService(Source).FkProduct;
    FcbIndex         := TProductService(Source).cbIndex;
    FFlagAtv         := TProductService(Source).FlagAtv;
    FVlrUnit         := TProductService(Source).VlrUnit;
    if Assigned(FProductCarrier) then
      ProductCarrier := TProductService(Source).ProductCarrier;
    if (Assigned(FCompositions)) then
      Compositions   := TProductService(Source).Compositions;
  end
  else
    inherited Assign(Source);
end;

procedure TProductService.Clear;
begin
  FcbIndex := 0;
  FFlagAtv := False;
  FVlrUnit := 0.0;
  if Assigned(FProductCarrier) then
    FProductCarrier.Clear;
  if Assigned(FCompositions) then
    FCompositions.Clear;
end;

procedure TProductService.SetCompositions(Value: TProductCompositions);
begin
  FCompositions.Clear;
  if (Value <> nil) and (Assigned(FCompositions)) then
    FCompositions.Assign(Value);
end;

procedure TProductService.SetProductCarrier(Value: TProductCarrier);
begin
  if (not Assigned(FProductCarrier)) then
    FProductCarrier := TProductCarrier.Create(FFkProduct);
  if (Value <> nil) then
    FProductCarrier.Assign(Value)
  else
    FProductCarrier.Clear;
end;

{
********************************* TProductTax **********************************
}
constructor TProductTax.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TProductTax.Destroy;
begin
  inherited Destroy;
end;

procedure TProductTax.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProductTax) then
  begin
    FAlqTax    := TProductTax(Source).AlqTax;
    FDscTax    := TProductTax(Source).DscTax;
    FFlagBase  := TProductTax(Source).FlagBase;
    FFkTaxType := TProductTax(Source).FkTaxType;
  end
  else
    inherited Assign(Source);
end;

procedure TProductTax.Clear;
begin
  FAlqTax    := 0.0;
  FDscTax    := '';
  FFlagBase  := 0;
  FFkTaxType := 0;
end;

function TProductTax.GetDisplayName: string;
begin
  Result := FDscTax;
  if Result = '' then Result := inherited GetDisplayName;
end;

{
******************************** TProductTaxes *********************************
}
constructor TProductTaxes.Create(AOwner: TPersistent);
begin
  inherited Create(TProductTax);
  FOwner := AOwner;
end;

destructor TProductTaxes.Destroy;
begin
  inherited Destroy;
end;

function TProductTaxes.Add: TProductTax;
begin
  Result := inherited Add as TProductTax;
end;

procedure TProductTaxes.Assign(Source: TPersistent);
var
  aItem: TProductTax;
  i: Integer;
begin
  if (Source <> nil) and (Source is TProductTaxes) then
  begin
    for i := 0 to TProductTaxes(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TProductTaxes(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TProductTaxes.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TProductTaxes.GetItems(Index: Integer): TProductTax;
begin
  Result := inherited Items[Index] as TProductTax;
end;

function TProductTaxes.GetOwner: TPersistent;
begin
  if Assigned(FOwner) then
    Result := FOwner
  else
    Result := inherited GetOwner;
end;

function TProductTaxes.Insert(Index: Integer): TProductTax;
begin
  Result := inherited Insert(Index) as TProductTax;
end;

procedure TProductTaxes.SetItems(Index: Integer; AValue: TProductTax);
begin
  inherited Items[Index] := AValue
end;

{
******************************* TProductSupplier *******************************
}
constructor TProductSupplier.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFkCompany  := TCompany.Create;
  FFkSupplier := TOwner.Create;
  FFkUnit     := TUnit.Create;
  FFkTypeDsct := TTypeDiscount.Create;
  FObsForn    := TStringList.Create;
  Clear;
end;

destructor TProductSupplier.Destroy;
begin
  Clear;
  if Assigned(FFkCompany) then
    FFkCompany.Free;
  if Assigned(FFkSupplier) then
    FFkSupplier.Free;
  if Assigned(FFkUnit) then
    FFkUnit.Free;
  if Assigned(FFkTypeDsct) then
    FFkTypeDsct.Free;
  if Assigned(FObsForn) then
    FObsForn.Free;
  FFkCompany  := nil;
  FFkSupplier := nil;
  FFkUnit     := nil;
  FFkTypeDsct := nil;
  FObsForn    := nil;
  inherited Destroy;
end;

procedure TProductSupplier.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProductSupplier) then
  begin
    FDtaGrnt     := TProductSupplier(Source).DtaGrnt;
    if Assigned(FFkCompany) then
      FkCompany  := TProductSupplier(Source).FkCompany;
    if Assigned(FFkSupplier) then
      FkSupplier := TProductSupplier(Source).FkSupplier;
    if Assigned(FFkTypeDsct) then
      FkTypeDsct := TProductSupplier(Source).FkTypeDsct;
    if Assigned(FFkUnit) then
      FkUnit     := TProductSupplier(Source).FkUnit;
    FFlagInsp    := TProductSupplier(Source).FlagInsp;
    FFlagRjst    := TProductSupplier(Source).FlagRjst;
    FFreteIns    := TProductSupplier(Source).FreteIns;
    if Assigned(FObsForn) then
      ObsForn    := TProductSupplier(Source).ObsForn;
    FPreFinal    := TProductSupplier(Source).PreFinal;
    FPreTab      := TProductSupplier(Source).PreTab;
    FQtdDiasEntr := TProductSupplier(Source).QtdDiasEntr;
    FQtdGrnt     := TProductSupplier(Source).QtdGrnt;
    FQtdUni      := TProductSupplier(Source).QtdUni;
    FSitTrib     := TProductSupplier(Source).SitTrib;
  end
  else
    inherited Assign(Source);
end;

procedure TProductSupplier.Clear;
begin
  FDtaGrnt     := 0;
  if Assigned(FFkCompany) then
    FFkCompany.Clear;
  if Assigned(FFkSupplier) then
    FFkSupplier.Clear;
  if Assigned(FFkTypeDsct) then
    FFkTypeDsct.Clear;
  if Assigned(FFkUnit) then
    FFkUnit.Clear;
  FFlagInsp    := itFree;
  FFlagRjst    := False;
  FFreteIns    := 0.0;
  if Assigned(FObsForn) then
    FObsForn.Clear;
  FPreFinal    := 0.0;
  FPreTab      := 0.0;
  FQtdDiasEntr := 0;
  FQtdGrnt     := 0.0;
  FQtdUni      := 0.0;
  FSitTrib     := '';
end;

function TProductSupplier.GetDisplayName: string;
begin
  if Assigned(FFkSupplier) then
    Result := FFkSupplier.RazSoc;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TProductSupplier.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_EMPRESAS');
  Result.Add('FK_PRODUTOS');
  Result.Add('FK_VW_FORNECEDORES');
  Result.Add('FK_UNIDADES');
  if (FFkTypeDsct.PkTypeDiscount > 0) then
    Result.Add('FK_TIPO_DESCONTOS');
  if (FSitTrib <> '') then
    Result.Add('SIT_TRIB');
  Result.Add('QTD_UNI');
  Result.Add('QTD_GRNT');
  Result.Add('FLAG_RJST');
  Result.Add('FLAG_INSP');
  Result.Add('PRE_TAB');
  Result.Add('PRE_FINAL');
  Result.Add('FRETE_INS');
  Result.Add('QTD_DIAS_ENTR');
  if (FObsForn.Count > 0) then
    Result.Add('OBS_FORN');
  if (FDtaGrnt > 0) then
    Result.Add('DTA_GRNT');
  Result.Add('KC_PRODUTOS_FONECEDORES_COMP');
end;

procedure TProductSupplier.SetFkCompany(AValue: TCompany);
begin
  if (AValue = nil) then
    FFkCompany.Clear
  else
    FFkCompany.Assign(AValue);
end;

procedure TProductSupplier.SetFkSupplier(AValue: TOwner);
begin
  if (AValue = nil) then
    FFkSupplier.Clear
  else
    FFkSupplier.Assign(AValue);
end;

procedure TProductSupplier.SetFkTypeDsct(AValue: TTypeDiscount);
begin
  if (AValue = nil) then
    FFkTypeDsct.Clear
  else
    FFkTypeDsct.Assign(AValue);
end;

procedure TProductSupplier.SetFkUnit(AValue: TUnit);
begin
  if (AValue = nil) then
    FFkUnit.Clear
  else
    FFkUnit.Assign(AValue);
end;

procedure TProductSupplier.SetObsForn(AValue: TStrings);
begin
  if (AValue = nil) then
    FObsForn.Clear
  else
    FObsForn.Assign(AValue);
end;

{
****************************** TProductSuppliers *******************************
}
constructor TProductSuppliers.Create(AOwner: TPersistent);
begin
  inherited Create(TProductSupplier);
  FOwner := AOwner;
end;

destructor TProductSuppliers.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

function TProductSuppliers.Add: TProductSupplier;
begin
  Result := inherited Add as TProductSupplier;
end;

procedure TProductSuppliers.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TProductSupplier;
begin
  if (Source <> nil) and (Source is TProductSuppliers) then
  begin
    for i := 0 to TProductSuppliers(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TProductSuppliers(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TProductSuppliers.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TProductSuppliers.GetItems(Index: Integer): TProductSupplier;
begin
  Result := inherited Items[Index] as TProductSupplier;
end;

function TProductSuppliers.GetOwner: TPersistent;
begin
  if Assigned(FOwner) then
    Result := FOwner
  else
    Result := inherited GetOwner;
end;

function TProductSuppliers.Insert(Index: Integer): TProductSupplier;
begin
  Result := inherited Insert(Index) as TProductSupplier;
end;

procedure TProductSuppliers.SetItems(Index: Integer; AValue: TProductSupplier);
begin
  inherited Items[Index] := AValue
end;

{
********************************* TProductCost *********************************
}
constructor TProductCost.Create;
begin
  inherited Create;
  FFkCompany  := TCompany.Create;
  FFkSupplier := TOwner.Create;
  Clear;
end;

destructor TProductCost.Destroy;
begin
  Clear;
  if Assigned(FFkCompany) then
    FFkCompany.Free;
  if Assigned(FFkSupplier) then
    FFkSupplier.Free;
  FFkSupplier := nil;
  FFkCompany  := nil;
  inherited Destroy;
end;

procedure TProductCost.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProductCost) then
  begin
    FCustFinal        := TProductCost(Source).CustFinal;
    FCustForn         := TProductCost(Source).CustForn;
    FCustMed          := TProductCost(Source).CustMed;
    FCustReal         := TProductCost(Source).CustReal;
    FCustRjst         := TProductCost(Source).CustRjst;
    FCustUFrn         := TProductCost(Source).CustUFrn;
    FDtaPrvEntrCompra := TProductCost(Source).DtaPrvEntrCompra;
    FDtaUCmp          := TProductCost(Source).DtaUCmp;
    FDtaUInv          := TProductCost(Source).DtaUInv;
    FDtaUMov          := TProductCost(Source).DtaUMov;
    FDtaURsv          := TProductCost(Source).DtaURsv;
    FDtaUSld          := TProductCost(Source).DtaUSld;
    if Assigned(FkCompany) then
      FkCompany       := TProductCost(Source).FkCompany;
    if Assigned(FFkSupplier) then
      FkSupplier      := TProductCost(Source).FkSupplier;
    FFlagRjst         := TProductCost(Source).FlagRjst;
    FQtdCnsMed        := TProductCost(Source).QtdCnsMed;
    FQtdDiasEntr      := TProductCost(Source).QtdDiasEntr;
    FQtdDiasEstq      := TProductCost(Source).QtdDiasEstq;
    FQtdDiasRep       := TProductCost(Source).QtdDiasRep;
    FQtdEMax          := TProductCost(Source).QtdEMax;
    FQtdEMin          := TProductCost(Source).QtdEMin;
    FQtdEstq          := TProductCost(Source).QtdEstq;
    FQtdEstqQR        := TProductCost(Source).QtdEstqQR;
    FQtdGrnt          := TProductCost(Source).QtdGrnt;
    FQtdPedF          := TProductCost(Source).QtdPedF;
    FQtdRsrv          := TProductCost(Source).QtdRsrv;
  end
  else
    inherited Assign(Source);
end;

procedure TProductCost.Clear;
begin
  FCustFinal        := 0.0;
  FCustForn         := 0.0;
  FCustMed          := 0.0;
  FCustReal         := 0.0;
  FCustRjst         := 0.0;
  FCustUFrn         := 0.0;
  FDtaPrvEntrCompra := 0;
  FDtaUCmp          := 0;
  FDtaUInv          := 0;
  FDtaUMov          := 0;
  FDtaURsv          := 0;
  FDtaUSld          := 0;
  if Assigned(FkCompany) then
    FFkCompany.Clear;
  if Assigned(FFkSupplier) then
    FFkSupplier.Clear;
  FFlagRjst         := False;
  FQtdCnsMed        := 0.0;
  FQtdDiasEntr      := 0;
  FQtdDiasEstq      := 0;
  FQtdDiasRep       := 0;
  FQtdEMax          := 0.0;
  FQtdEMin          := 0.0;
  FQtdEstq          := 0.0;
  FQtdEstqQR        := 0.0;
  FQtdGrnt          := 0.0;
  FQtdPedF          := 0.0;
  FQtdRsrv          := 0.0;
end;

function TProductCost.GetEstqDspn: Double;
begin
  Result := QtdEstq - (QtdRsrv + QtdEstqQR + QtdGrnt);
end;

function TProductCost.GetEstqPrev: Double;
begin
  Result := (QtdEstq + QtdPedF) - (QtdRsrv + QtdEstqQR + QtdGrnt);
end;

procedure TProductCost.SetFkCompany(AValue: TCompany);
begin
  if (AValue = nil) then
    FFkCompany.Clear
  else
    FFkCompany.Assign(AValue);
end;

procedure TProductCost.SetFkSupplier(Value: TOwner);
begin
  if (FFkSupplier = nil) then exit;
  FFkSupplier.Clear;
  if (Value <> nil) then FFkSupplier.Assign(Value);
end;

{
******************************** TProductPrice *********************************
}
constructor TProductPrice.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFkCompany    := TCompany.Create;
  FFkPriceTable := TPriceTable.Create(Self);
  Clear;
end;

destructor TProductPrice.Destroy;
begin
  Clear;
  if Assigned(FFkCompany) then
    FFkCompany.Free;
  if Assigned(FFkPriceTable) then
    FFkPriceTable.Free;
  FFkCompany    := nil;
  FFkPriceTable := nil;
  inherited Destroy;
end;

procedure TProductPrice.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProductPrice) then
  begin
    if Assigned(FFkCompany) then
      FkCompany    := TProductPrice(Source).FkCompany;
    if Assigned(FFkPriceTable) then
      FkPriceTable := TProductPrice(Source).FkPriceTable;
    FPreVda        := TProductPrice(Source).PreVda;
    FFlagFix       := TProductPrice(Source).FlagFix;
  end
  else
    inherited Assign(Source);
end;

procedure TProductPrice.Clear;
begin
  if Assigned(FFkCompany) then
    FFkCompany.Clear;
  if Assigned(FFkPriceTable) then
    FFkPriceTable.Clear;
  FPreVda         := 0.0;
  FFlagFix        := False;
end;

function TProductPrice.GetDisplayName: string;
begin
  if (FPreVda > 0) then
    Result := FloatToStrF(FPreVda, ffCurrency, 7, 2);
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TProductPrice.SetFkCompany(AValue: TCompany);
begin
  if (AValue = nil) then
    FFkCompany.Clear
  else
    FFkCompany.Assign(AValue);
end;

procedure TProductPrice.SetFkPriceTable(AValue: TPriceTable);
begin
  if (AValue = nil) then
    FFkPriceTable.Clear
  else
    FFkPriceTable.Assign(AValue);
end;

{
******************************** TProductPrices ********************************
}
constructor TProductPrices.Create(AOwner: TPersistent);
begin
  inherited Create(TProductPrice);
  FOwner := AOwner;
  FFkCOmpany    := TCompany.Create;
  FFkClassFisc  := TClassFisc.Create;
  FFkSitTrib    := TSitTrib.Create;
  FFkOrigimTrib := TOrigimTrib.Create;
  Clear;
end;

destructor TProductPrices.Destroy;
begin
  Clear;
  if Assigned(FFkCompany) then
    FFkCompany.Free;
  if Assigned(FFkClassFisc) then
    FFkClassFisc.Free;
  if Assigned(FFkSitTrib) then
    FFkSitTrib.Free;
  if Assigned(FFkOrigimTrib) then
    FFkOrigimTrib.Free;
  FFkCompany    := nil;
  FFkClassFisc  := nil;
  FFkSitTrib    := nil;
  FFkOrigimTrib := nil;
  FOwner := nil;
  inherited Destroy;
end;

function TProductPrices.Add: TProductPrice;
begin
  Result := inherited Add as TProductPrice;
end;

procedure TProductPrices.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TProductPrice;
begin
  if (Source <> nil) and (Source is TProductPrices) then
  begin
    FMrgLcr        := TProductPrices(Source).MrgLcr;
    if Assigned(FFkCompany) then
      FkCompany    := TProductPrices(Source).FkCompany;
    if Assigned(FFkClassFisc) then
      FkClassFisc  := TProductPrices(Source).FkClassFisc;
    if Assigned(FFkSitTrib) then
      FkSitTrib    := TProductPrices(Source).FkSitTrib;
    if Assigned(FFkOrigimTrib) then
      FkOrigimTrib := TProductPrices(Source).FkOrigimTrib;
    for i := 0 to TProductPrices(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TProductPrices(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TProductPrices.Clear;
begin
  inherited Clear;
  FMrgLcr := 0;
  if Assigned(FFkCompany) then
    FFkCompany.Clear;
  if Assigned(FFkClassFisc) then
    FFkClassFisc.Clear;
  if Assigned(FFkSitTrib) then
    FFkSitTrib.Clear;
  if Assigned(FFkOrigimTrib) then
    FFkOrigimTrib.Clear;
end;

procedure TProductPrices.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TProductPrices.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_EMPRESAS');
  Result.Add('FK_PRODUTOS');
  Result.Add('FK_SITUACAO_TRIBUTARIAS');
  Result.Add('FK_ORIGENS_TRIBUTARIAS');
  Result.Add('SIT_TRIB');
  Result.Add('MRG_LCR');
  if (FFkClassFisc <> nil) and (FFkClassFisc.PkClassificacaoFiscal <> '') then
    Result.Add('FK_CLASSIFICACAO_FISCAL');
end;

function TProductPrices.GetItems(Index: Integer): TProductPrice;
begin
  Result := inherited Items[Index] as TProductPrice;
end;

function TProductPrices.GetOwner: TPersistent;
begin
  if FOwner = nil then
    Result := inherited GetOwner
  else
    Result := FOwner;
end;

function TProductPrices.GetSitTrb: string;
begin
  Result := '';
  if Assigned(FFkSitTrib) and Assigned(FFkOrigimTrib) then
  begin
    Result := InsereZer(IntToStr(FFkSitTrib.PkSituacaoTributaria) +
                        IntToStr(FFkOrigimTrib.PkOrigensTributarias), 3);
  end;
end;

function TProductPrices.Insert(Index: Integer): TProductPrice;
begin
  Result := inherited Insert(Index) as TProductPrice;
end;

procedure TProductPrices.SetFkClassFisc(AValue: TClassFisc);
begin
  if (AValue <> nil) and (AValue is TClassFisc) then
    FFkCLassFisc.Assign(AValue)
  else
    FFkClassFisc.Clear;
end;

procedure TProductPrices.SetFkCompany(AValue: TCompany);
begin
  if (AValue <> nil) and (AValue is TCompany) then
    FFkCompany.Assign(AValue)
  else
    FFkCompany.Clear;
end;

procedure TProductPrices.SetFkOrigimTrib(AValue: TOrigimTrib);
begin
  if (AValue <> nil) and (AValue is TOrigimTrib) then
    FFkOrigimTrib.Assign(AValue)
  else
    FFkOrigimTrib.Clear;
end;

procedure TProductPrices.SetFkSitTrib(AValue: TSitTrib);
begin
  if (AValue <> nil) and (AValue is TSitTrib) then
    FFkSitTrib.Assign(AValue)
  else
    FFkSitTrib.Clear;
end;

procedure TProductPrices.SetItems(Index: Integer; AValue: TProductPrice);
begin
  inherited Items[Index] := AValue
end;

{
********************************* TProductCode *********************************
}
constructor TProductCode.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
end;

destructor TProductCode.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TProductCode.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProductCode) then
  begin
    FFlagTBarCode  := TProductCode(Source).FlagTBarCode;
    FFlagTCode     := TProductCode(Source).FlagTCode;
    FPkProductCode := TProductCode(Source).PkProductCode;
    CodRef         := TProductCode(Source).CodRef;
    DscCode        := TProductCode(Source).DscCode;
  end
  else
    inherited Assign(Source);
end;

procedure TProductCode.Clear;
begin
  FFlagTBarCode  := bcNone;
  FFlagTCode     := pcReference;
  FPkProductCode := 0;
  FCodRef        := '';
  FDscCode       := '';
end;

function TProductCode.GetDisplayName: string;
begin
  Result := FCodRef;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TProductCode.SetCodRef(AValue: string);
begin
  FCodRef := UpperCase(Copy(AValue, 1, 30));
end;

procedure TProductCode.SetDscCode(AValue: string);
begin
  FDscCode := Copy(AValue, 1, 30);
end;

{
******************************** TProductCodes *********************************
}
constructor TProductCodes.Create(AOwner: TPersistent);
begin
  inherited Create(TProductCode);
  FOwner := AOwner;
end;

destructor TProductCodes.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TProductCodes.Add: TProductCode;
begin
  Result := inherited Add as TProductCode;
end;

procedure TProductCodes.Assign(Source: TPersistent);
var
  aItem: TProductCode;
  i: Integer;
begin
  if (Source <> nil) and (Source is TProductCodes) then
  begin
    for i := 0 to TProductCodes(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TProductCodes(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TProductCodes.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TProductCodes.GetItems(Index: Integer): TProductCode;
begin
  Result := inherited Items[Index] as TProductCode;
end;

function TProductCodes.GetOwner: TPersistent;
begin
  if (FOwner = nil) then
    Result := inherited GetOwner
  else
    Result := FOwner;
end;

function TProductCodes.Insert(Index: Integer): TProductCode;
begin
  Result := inherited Insert(Index) as TProductCode;
end;

procedure TProductCodes.SetItems(Index: Integer; AValue: TProductCode);
begin
  inherited Items[Index] := AValue
end;

{
******************************* TProductPurchase *******************************
}
constructor TProductPurchase.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FFkReferenceType := TReferenceType.Create;
  Clear;
end;

destructor TProductPurchase.Destroy;
begin
  Clear;
  if Assigned(FFkReferenceType) then
    FFkReferenceType.Free;
  FOwner           := nil;
  FFkReferenceType := nil;
  inherited Destroy;
end;

procedure TProductPurchase.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProductPurchase) then
  begin
    if Assigned(FFkReferenceType) then
      FkReferenceType := TProductPurchase(Source).FkReferenceType;
    FFlagCmpr := TProductPurchase(Source).FlagCmpr;
    FFlagEmp  := TProductPurchase(Source).FlagEmp;
    FFlagTMat := TProductPurchase(Source).FlagTMat;
    FVlrUnit  := TProductPurchase(Source).VlrUnit;
  end
  else
    inherited Assign(Source);
end;

procedure TProductPurchase.Clear;
begin
  if Assigned(FFkReferenceType) then
    FFkReferenceType.Clear;
  FFlagCmpr := True;
  FFlagEmp  := True;
  FFlagTMat := mtPurchase;
  FVlrUnit  := 0.0;
end;

procedure TProductPurchase.SetFkReferenceType(AValue: TReferenceType);
begin
  if (AValue = nil) then
    FFkReferenceType.Clear
  else
    FkReferenceType.Assign(AValue);
end;

{
********************************* TProductSale *********************************
}
constructor TProductSale.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner      := AOwner;
  FFkLines    := TLines.Create;
  FFkSimilar  := TSimilar.Create;
end;

destructor TProductSale.Destroy;
begin
  Clear;
  FFkLines.Free;
  FFkSimilar.Free;
  FOwner     := nil;
  FFkLines   := nil;
  FFkSimilar := nil;
  inherited Destroy;
end;

procedure TProductSale.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProductSale) then
  begin
    FAltProd     := TProductSale(Source).AltProd;
    FComItem     := TProductSale(Source).ComItem;
    DscRed       := TProductSale(Source).DscRed;
    FEmbAltProd  := TProductSale(Source).EmbAltProd;
    FEmbLargProd := TProductSale(Source).EmbLargProd;
    FEmbProfProd := TProductSale(Source).EmbProfProd;
    FkLines      := TProductSale(Source).FkLines;
    FkSimilar    := TProductSale(Source).FkSimilar;
    FFlagTProd   := TProductSale(Source).FlagTProd;
    FFlagImp     := TProductSale(Source).FlagImp;
    FIntAltProd  := TProductSale(Source).IntAltProd;
    FIntLargProd := TProductSale(Source).IntLargProd;
    FIntProfProd := TProductSale(Source).IntProfProd;
    FLargProd    := TProductSale(Source).LargProd;
    FPesBru      := TProductSale(Source).PesBru;
    FPesLiq      := TProductSale(Source).PesLiq;
    FProfProd    := TProductSale(Source).ProfProd;
  end
  else
    inherited Assign(Source);
end;

procedure TProductSale.Clear;
begin
  FAltProd     := 0.0;
  FComItem     := 0.0;
  FDscRed      := '';
  FEmbAltProd  := 0.0;
  FEmbLargProd := 0.0;
  FEmbProfProd := 0.0;
  if Assigned(FFkLines) then
    FkLines.Clear;
  if Assigned(FFkSimilar) then
    FkSimilar.Clear;
  FFlagTProd   := ptSale;
  FFlagImp     := True;
  FIntAltProd  := 0.0;
  FIntLargProd := 0.0;
  FIntProfProd := 0.0;
  FLargProd    := 0.0;
  FPesBru      := 0.0;
  FPesLiq      := 0.0;
  FProfProd    := 0.0;
  FFatConvCub  := 1000;
end;

function TProductSale.GetVlrCub: Double;
begin
  if (FatConvCub > 0) then
    Result := (FEmbAltProd * FEmbLargProd * FEmbProfProd) / FatConvCub
  else
    Result := (FEmbAltProd * FEmbLargProd * FEmbProfProd);
end;

procedure TProductSale.SetDscRed(AValue: string);
begin
  FDscRed := Copy(AValue, 1, 30);
end;

procedure TProductSale.SetFkLines(AValue: TLines);
begin
  if (AValue = nil) then
    FFkLines.Clear
  else
    FFkLines.Assign(AValue);
end;

procedure TProductSale.SetFkSimilar(AValue: TSimilar);
begin
  if (AValue = nil) then
    FFkSimilar.Clear
  else
    FFkSimilar.Assign(AValue);
end;

{
********************************** TProducts ***********************************
}
constructor TProducts.Create;
begin
  inherited Create;
  FFkUnit           := TUnit.Create;
  FProductCodes     := TProductCodes.Create(Self);
  FProductCost      := TProductCost.Create;
  FProductPurchase  := TProductPurchase.Create(Self);
  FProductSale      := TProductSale.Create(Self);
  FProductPrices    := TProductPrices.Create(Self);
  FProductSuppliers := TProductSuppliers.Create(Self);
  FProductTaxes     := TProductTaxes.Create(Self);
  FProductService   := TProductService.Create(0);
  Clear;
end;

destructor TProducts.Destroy;
begin
  Clear;
  if Assigned(FFkUnit) then
    FFkUnit.Free;
  if Assigned(FProductCodes) then
    FProductCodes.Free;
  if Assigned(FProductCost) then
    FProductCost.Free;
  if Assigned(FProductPurchase) then
    FProductPurchase.Free;
  if Assigned(FProductSale) then
    FProductSale.Free;
  if Assigned(FProductPrices) then
    FProductPrices.Free;
  if Assigned(FProductSuppliers) then
    FProductSuppliers.Free;
  if Assigned(FProductTaxes) then
    FProductTaxes.Free;
  if Assigned(FProductService) then
    FProductService.Free;
  FFkUnit           := nil;
  FProductCodes     := nil;
  FProductCost      := nil;
  FProductPurchase  := nil;
  FProductSale      := nil;
  FProductPrices    := nil;
  FProductSuppliers := nil;
  FProductService   := nil;
  FProductTaxes     := nil;
  inherited Destroy;
end;

procedure TProducts.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProducts) then
  begin
    cbIndex            := TProducts(Source).cbIndex;
    FDscProd           := TProducts(Source).DscProd;
    if Assigned(FFkUnit) then
      FkUnit           := TProducts(Source).FkUnit;
    FFlagAtv           := TProducts(Source).FlagAtv;
    FFlagMatT          := mtNone;
    FFlagPrdT          := ptSale;
    FPkProducts        := TProducts(Source).PkProducts;
    if Assigned(FProductCodes) then
      ProductCodes     := TProducts(Source).ProductCodes;
    if Assigned(FProductCost) then
      ProductCost      := TProducts(Source).ProductCost;
    if Assigned(FProductPurchase) then
      ProductPurchase  := TProducts(Source).ProductPurchase;
    if Assigned(FProductSale) then
      ProductSale      := TProducts(Source).ProductSale;
    if Assigned(FProductPrices) then
      ProductPrices    := TProducts(Source).ProductPrices;
    if Assigned(FProductSuppliers) then
      ProductSuppliers := TProducts(Source).ProductSuppliers;
    if Assigned(FProductService) then
      ProductService   := TProducts(Source).ProductService;
    if Assigned(FProductTaxes) then
      ProductTaxes     := TProducts(Source).ProductTaxes;
    FQtdUni            := TProducts(Source).QtdUni;
  end
  else
    inherited Assign(Source);
end;

procedure TProducts.Clear;
begin
  FDscProd    := '';
  if Assigned(FFkUnit) then
    FFkUnit.Clear;
  FFlagAtv    := True;
  FFlagMatT   := mtNone;
  FFlagPrdT   := ptSale;
  FPkProducts := 0;
  if Assigned(FProductCodes) then
    FProductCodes.Clear;
  if Assigned(FProductCost) then
    FProductCost.Clear;
  if Assigned(FProductPurchase) then
    FProductPurchase.Clear;
  if Assigned(FProductSale) then
    FProductSale.Clear;
  if Assigned(FProductPrices) then
    FProductPrices.Clear;
  if Assigned(FProductSuppliers) then
    FProductSuppliers.Clear;
  if Assigned(FProductTaxes) then
    FProductTaxes.Clear;
  if Assigned(FProductService) then
    FProductService.Clear;
  FQtdUni     := 0.0;
  cbIndex     := 0;
end;

function TProducts.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkProducts) then
    Result := FcbIndex;
end;

function TProducts.GetPkValue: Variant;
begin
  Result := FPkProducts;
end;

procedure TProducts.SetDscProd(AValue: string);
begin
  FDscProd := Copy(AValue, 1, 50);
end;

procedure TProducts.SetFkUnit(AValue: TUnit);
begin
  FFkUnit.Clear;
  if (AValue <> nil) and (Assigned(FFkUnit)) then
    FFkUnit.Assign(AValue);
end;

procedure TProducts.SetFlagMatT(AValue: TMaterialType);
begin
  if (FFlagTProd <> tiPurchase) then
    FFlagMatT := mtNone
  else
    FFlagMatT := AValue;
end;

procedure TProducts.SetFlagPrdT(AValue: TProductType);
begin
  if (FFlagTProd <> tiSale) then
    FFlagPrdT := ptNone
  else
    FFlagPrdT := AValue;
end;

procedure TProducts.SetFlagTProd(AValue: TTypeInsumos);
var
  aAllowed: Boolean;
begin
  if (Assigned(FOnChangeType)) then
    OnChangeType(Self, aAllowed);
  if not aAllowed then exit;
  FFlagTProd := AValue;
  if FFlagTProd = tiSale then
    FFlagMatT := mtNone;
  if FFlagTProd = tiPurchase then
    FFlagPrdT := ptNone;
  if FFlagTProd in [tiService, tiPart] then
  begin
    FFlagPrdT := ptNone;
    FFlagMatT := mtNone;
  end;
end;

procedure TProducts.SetMode(AValue: TDBMode);
begin
  FMode := AValue;
  if FMode = dbmInsert then
  begin
    FDscProd    := '';
    FFlagAtv    := True;
    FPkProducts := 0;
    FQtdUni     := 0.0;
    if Assigned(FProductCodes) then
      FProductCodes.Clear;
    if Assigned(FProductCost) then
      FProductCost.Clear;
    if Assigned(FProductPurchase) then
      FProductPurchase.Clear;
    if Assigned(FProductSale) then
      FProductSale.Clear;
    if Assigned(FProductPrices) then
      FProductPrices.Clear;
    if Assigned(FProductSuppliers) then
      FProductSuppliers.Clear;
    if Assigned(FProductTaxes) then
      FProductTaxes.Clear;
  end;
end;

procedure TProducts.SetProductCodes(AValue: TProductCodes);
begin
  FProductCodes.Clear;
  if (AValue <> nil) and (Assigned(FProductCodes)) then
    FProductCodes.Assign(AValue);
end;

procedure TProducts.SetProductCost(AValue: TProductCost);
begin
  FProductCost.Clear;
  if (AValue <> nil) and (Assigned(FProductCost)) then
    FProductCost.Assign(AValue);
end;

procedure TProducts.SetProductPrices(AValue: TProductPrices);
begin
  FProductPrices.Clear;
  if (AValue <> nil) and (Assigned(FProductPrices)) then
    FProductPrices.Assign(AValue);
end;

procedure TProducts.SetProductPurchase(AValue: TProductPurchase);
begin
  FProductPurchase.Clear;
  if (AValue <> nil) and (Assigned(FProductPurchase)) then
    FProductPurchase.Assign(AValue);
end;

procedure TProducts.SetProductSale(AValue: TProductSale);
begin
  FProductSale.Clear;
  if (AValue <> nil) and (Assigned(FProductSale)) then
    FProductSale.Assign(AValue);
end;

procedure TProducts.SetProductService(Value: TProductService);
begin
  if (not Assigned(FProductService)) then
    FProductService := TProductService.Create(FPkProducts);
  if (Value <> nil) then
    FProductService.Assign(Value)
  else
    FProductService.Clear;
end;

procedure TProducts.SetProductSuppliers(AValue: TProductSuppliers);
begin
  FProductSuppliers.Clear;
  if (AValue <> nil) and (Assigned(FProductSuppliers)) then
    FProductSuppliers.Assign(AValue);
end;

procedure TProducts.SetProductTaxes(AValue: TProductTaxes);
begin
  FProductTaxes.Clear;
  if (AValue <> nil) and (Assigned(FProductTaxes)) then
    FProductTaxes.Assign(AValue);
end;


end.
