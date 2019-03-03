unit TSysCad;

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

uses
  SysUtils, Classes, TSysCadAux, TSysMan, TSysPedAux, TSysBcCx, TSysEstqAux,
    {$IFDEF WIN32} Controls {$ENDIF} 
    {$IFDEF LINUX} QControls {$ENDIF};

type
  TValidateStringEvent = procedure (Sender: TObject; AValue: string; var 
          AValid: Boolean) of object;

// 0 ==> Masculino
// 1 ==> Feminino
  TSexType  = (stMale, stFemale, stTransSex);
  
// 0 ==> Pessoa Jurídica
// 1 ==> Pessoa Física
// 2 ==> Estrangeiro
// 3 ==> Outro
  TTypeOwner = (toCompany, toPeople, toForeigner, toAll); 
  
// 0 ==> Admnistração
// 1 ==> Gerência
// 2 ==> Vendedores
// 4 ==> Técnicos
// 5 ==> Outros    
  TPostType  = (ptAdmin, ptManager, ptVendor, ptTecnician, ptOther);
  
// 0 ==> Solteiro
// 1 ==> Casado
// 2 ==> Divorciado
// 3 ==> Amasiado
  TCivilState = (csSingle, csMarried, Divorced, csTogether);  
  
// 0 ==> Primeiro Grau
// 1 ==> Segundo Grau
// 2 ==> Terceiro Grau
// 3 ==> Doutorado
// 4 ==> Outros
  TSchoolLevel = (slFirst, slSecond, slThird, slDoctorate, slOther);
  
// 0 ==> mensal
// 1 ==> semanal
// 2 ==> Quinzena
// 3 ==> Bimestral
// 4 ==> Trimestral
// 5 ==> Semestral
// 6 ==> Anual
  TTypeSalary = (tsMonthly, tsWeekly, tsTwoWeekly, tsTwoMonthly, tsQuartely, 
                 tsHalYearly, Yearly);
  
  TOwner = class;

  TPartner = class (TCollectionItem)
  private
    FAddress: TAddress;
    FDtaNasc: TDate;
    FeMailSoc: string;
    FNomSoc: string;
    FPkPartner: string;
    FValidateCPF: TValidateStringEvent;
    procedure SetAddress(Value: TAddress);
    procedure SeteMailSoc(Value: string);
    procedure SetNomSoc(Value: string);
    procedure SetPkPartner(Value: string);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property Address: TAddress read FAddress write SetAddress;
    property DtaNasc: TDate read FDtaNasc write FDtaNasc;
    property eMailSoc: string read FeMailSoc write SeteMailSoc;
    property NomSoc: string read FNomSoc write SetNomSoc;
    property PkPartner: string read FPkPartner write SetPkPartner;
    property ValidateCPF: TValidateStringEvent read FValidateCPF write 
            FValidateCPF;
  end;
  
  TPartners = class (TCollection)
  private
    FItemIndex: Integer;
    FOwner: TPersistent;
    function GetItems(Index: Integer): TPartner;
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Index: Integer; AValue: TPartner);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TPartner;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TPartner;
    property Count;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items[Index: Integer]: TPartner read GetItems write SetItems;
  end;
  
  TReference = class (TCollectionItem)
  private
    FeMailRef: string;
    FFlagCnf: Boolean;
    FFonRef: string;
    FModified: Boolean;
    FNomRef: string;
    FObsRef: TStrings;
    function GetPkCadastros: Integer;
    procedure SeteMailRef(Value: string);
    procedure SetFonRef(Value: string);
    procedure SetNomRef(Value: string);
    procedure SetObsRef(Value: TStrings);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property eMailRef: string read FeMailRef write SeteMailRef;
    property FlagCnf: Boolean read FFlagCnf write FFlagCnf;
    property FonRef: string read FFonRef write SetFonRef;
    property Modified: Boolean read FModified write FModified;
    property NomRef: string read FNomRef write SetNomRef;
    property ObsRef: TStrings read FObsRef write SetObsRef;
    property PkCadastros: Integer read GetPkCadastros;
  end;
  
  TReferences = class (TCollection)
  private
    FItemIndex: Integer;
    FOwner: TPersistent;
    function GetItems(Index: Integer): TReference;
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Index: Integer; AValue: TReference);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TReference;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TReference;
    property Count;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items[Index: Integer]: TReference read GetItems write SetItems;
  end;
  
  TPersonalData = class (TPersistent)
  private
    FCmpVal: Double;
    FCrgCli: string;
    FDtaAdm: TDate;
    FDtaExp: TDate;
    FEmpTrb: string;
    FEscCad: string;
    FFkCity: TCity;
    FFlagSex: TSexType;
    FFonEmp: string;
    FModified: Boolean;
    FNomMae: string;
    FNomPai: string;
    FNumCnh: string;
    FObsPes: TStrings;
    FPrfCli: string;
    FSalCli: Double;
    FValCnh: TDate;
    FVlrAlg: Double;
    procedure SetCrgCli(Value: string);
    procedure SetEmpTrb(Value: string);
    procedure SetEscCad(Value: string);
    procedure SetFkCity(Value: TCity);
    procedure SetFonEmp(Value: string);
    procedure SetNomMae(Value: string);
    procedure SetNomPai(Value: string);
    procedure SetNumCnh(Value: string);
    procedure SetObsPes(Value: TStrings);
    procedure SetPrfCli(Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property CmpVal: Double read FCmpVal write FCmpVal;
    property CrgCli: string read FCrgCli write SetCrgCli;
    property DtaAdm: TDate read FDtaAdm write FDtaAdm;
    property DtaExp: TDate read FDtaExp write FDtaExp;
    property EmpTrb: string read FEmpTrb write SetEmpTrb;
    property EscCad: string read FEscCad write SetEscCad;
    property FkCity: TCity read FFkCity write SetFkCity;
    property FlagSex: TSexType read FFlagSex write FFlagSex;
    property FonEmp: string read FFonEmp write SetFonEmp;
    property Modified: Boolean read FModified write FModified;
    property NomMae: string read FNomMae write SetNomMae;
    property NomPai: string read FNomPai write SetNomPai;
    property NumCnh: string read FNumCnh write SetNumCnh;
    property ObsPes: TStrings read FObsPes write SetObsPes;
    property PrfCli: string read FPrfCli write SetPrfCli;
    property SalCli: Double read FSalCli write FSalCli;
    property ValCnh: TDate read FValCnh write FValCnh;
    property VlrAlg: Double read FVlrAlg write FVlrAlg;
  end;
  
  TCollectionAddress = class (TPersistent)
  private
    FAddress: TAddress;
    FPhones: TPhones;
    procedure SetAddress(AValue: TAddress);
    procedure SetPhones(AValue: TPhones);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property Address: TAddress read FAddress write SetAddress;
    property Phones: TPhones read FPhones write SetPhones;
  end;
  
  TDeliveryAddress = class (TPersistent)
  private
    FAddress: TAddress;
    FCNPJEntr: string;
    FIEEntr: string;
    FPhones: TPhones;
    FValidateCNPJ: TValidateStringEvent;
    FValidateIE: TValidateStringEvent;
    procedure SetAddress(AValue: TAddress);
    procedure SetCNPJEntr(AValue: string);
    procedure SetIEEntr(AValue: string);
    procedure SetPhones(AValue: TPhones);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property Address: TAddress read FAddress write SetAddress;
    property CNPJEntr: string read FCNPJEntr write SetCNPJEntr;
    property IEEntr: string read FIEEntr write SetIEEntr;
    property Phones: TPhones read FPhones write SetPhones;
    property ValidateCNPJ: TValidateStringEvent read FValidateCNPJ write 
            FValidateCNPJ;
    property ValidateIE: TValidateStringEvent read FValidateIE write 
            FValidateIE;
  end;
  
  TEmployee = class (TPersistent)
  private
    FAnoCheg: Integer;
    FCodCtb: Integer;
    FComVnd: Double;
    FDsctMax: Double;
    FDtaAdm: TDate;
    FDtaApst: TDate;
    FDtaCad: TDate;
    FDtaEmiRg: TDate;
    FDtaExp: TDate;
    FDtaNasc: TDate;
    FDtaNascFilho: TDate;
    FFkBank: TBank;
    FFkBankFgts: TBank;
    FFkBornFrom: TCity;
    FFkCity: TCity;
    FFkCompany: TCompany;
    FFkCostsCenter: Integer;
    FFkDepartament: Integer;
    FFkFunctions: Integer;
    FFkSector: Integer;
    FFkTypeComission: Integer;
    FFlagApst: Boolean;
    FFlagCrg: TPostType;
    FFlagDef: Boolean;
    FFlagEstCiv: TCivilState;
    FFlagGrInstr: TSchoolLevel;
    FFlagOpPrv: Boolean;
    FFlagSex: TSexType;
    FFlagTempr: Boolean;
    FFlagTSal: TTypeSalary;
    FHabProf: string;
    FLotFun: string;
    FNomConslh: string;
    FNomMae: string;
    FNomPai: string;
    FNomSind: string;
    FNumCtps: Integer;
    FNumDepIr: Integer;
    FNumFunc: Integer;
    FNumReg: string;
    FNumTit: string;
    FPercInsl: Double;
    FPercPeric: Double;
    FPisFunc: string;
    FQtdFilhos: Integer;
    FQtdHours: Integer;
    FRacaCor: string;
    FRefLivro: Integer;
    FSecaoTit: string;
    FSerCtps: string;
    FSitApst: string;
    FTipoVisto: string;
    FUfCtps: string;
    FVincFun: string;
    FVlrSal: Double;
    FZonaTit: string;
    procedure SetFkBank(Value: TBank);
    procedure SetFkBankFgts(Value: TBank);
    procedure SetFkBornFrom(AValue: TCity);
    procedure SetFkCity(Value: TCity);
    procedure SetFkCompany(AValue: TCompany);
    procedure SetHabProf(Value: string);
    procedure SetLotFun(Value: string);
    procedure SetNomConslh(Value: string);
    procedure SetNomMae(Value: string);
    procedure SetNomPai(Value: string);
    procedure SetNomSind(Value: string);
    procedure SetNumReg(Value: string);
    procedure SetNumTit(Value: string);
    procedure SetPisFunc(Value: string);
    procedure SetRacaCor(Value: string);
    procedure SetSecaoTit(Value: string);
    procedure SetSerCtps(const Value: string);
    procedure SetSitApst(const Value: string);
    procedure SetTipoVisto(Value: string);
    procedure SetUfCtps(Value: string);
    procedure SetVincFun(Value: string);
    procedure SetZonaTit(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property AnoCheg: Integer read FAnoCheg write FAnoCheg;
    property CodCtb: Integer read FCodCtb write FCodCtb;
    property ComVnd: Double read FComVnd write FComVnd;
    property DsctMax: Double read FDsctMax write FDsctMax;
    property DtaAdm: TDate read FDtaAdm write FDtaAdm;
    property DtaApst: TDate read FDtaApst write FDtaApst;
    property DtaCad: TDate read FDtaCad write FDtaCad;
    property DtaEmiRg: TDate read FDtaEmiRg write FDtaEmiRg;
    property DtaExp: TDate read FDtaExp write FDtaExp;
    property DtaNasc: TDate read FDtaNasc write FDtaNasc;
    property DtaNascFilho: TDate read FDtaNascFilho write FDtaNascFilho;
    property FkBank: TBank read FFkBank write SetFkBank;
    property FkBankFgts: TBank read FFkBankFgts write SetFkBankFgts;
    property FkBornFrom: TCity read FFkBornFrom write SetFkBornFrom;
    property FkCity: TCity read FFkCity write SetFkCity;
    property FkCompany: TCompany read FFkCompany write SetFkCompany;
    property FkCostsCenter: Integer read FFkCostsCenter write FFkCostsCenter;
    property FkDepartament: Integer read FFkDepartament write FFkDepartament;
    property FkFunctions: Integer read FFkFunctions write FFkFunctions;
    property FkSector: Integer read FFkSector write FFkSector;
    property FkTypeComission: Integer read FFkTypeComission write 
            FFkTypeComission;
    property FlagApst: Boolean read FFlagApst write FFlagApst;
    property FlagCrg: TPostType read FFlagCrg write FFlagCrg default ptAdmin;
    property FlagDef: Boolean read FFlagDef write FFlagDef;
    property FlagEstCiv: TCivilState read FFlagEstCiv write FFlagEstCiv;
    property FlagGrInstr: TSchoolLevel read FFlagGrInstr write FFlagGrInstr;
    property FlagOpPrv: Boolean read FFlagOpPrv write FFlagOpPrv;
    property FlagSex: TSexType read FFlagSex write FFlagSex;
    property FlagTempr: Boolean read FFlagTempr write FFlagTempr;
    property FlagTSal: TTypeSalary read FFlagTSal write FFlagTSal;
    property HabProf: string read FHabProf write SetHabProf;
    property LotFun: string read FLotFun write SetLotFun;
    property NomConslh: string read FNomConslh write SetNomConslh;
    property NomMae: string read FNomMae write SetNomMae;
    property NomPai: string read FNomPai write SetNomPai;
    property NomSind: string read FNomSind write SetNomSind;
    property NumCtps: Integer read FNumCtps write FNumCtps;
    property NumDepIr: Integer read FNumDepIr write FNumDepIr;
    property NumFunc: Integer read FNumFunc write FNumFunc;
    property NumReg: string read FNumReg write SetNumReg;
    property NumTit: string read FNumTit write SetNumTit;
    property PercInsl: Double read FPercInsl write FPercInsl;
    property PercPeric: Double read FPercPeric write FPercPeric;
    property PisFunc: string read FPisFunc write SetPisFunc;
    property QtdFilhos: Integer read FQtdFilhos write FQtdFilhos;
    property QtdHours: Integer read FQtdHours write FQtdHours;
    property RacaCor: string read FRacaCor write SetRacaCor;
    property RefLivro: Integer read FRefLivro write FRefLivro;
    property SecaoTit: string read FSecaoTit write SetSecaoTit;
    property SerCtps: string read FSerCtps write SetSerCtps;
    property SitApst: string read FSitApst write SetSitApst;
    property TipoVisto: string read FTipoVisto write SetTipoVisto;
    property UfCtps: string read FUfCtps write SetUfCtps;
    property VincFun: string read FVincFun write SetVincFun;
    property VlrSal: Double read FVlrSal write FVlrSal;
    property ZonaTit: string read FZonaTit write SetZonaTit;
  end;
  
  TSupplier = class (TPersistent)
  private
    FFkAgent: Integer;
    FFkCarrier: Integer;
    FFkPortDst: Integer;
    FFkPortEmb: Integer;
    FFkPriceTable: Integer;
    FFkTypeDiscount: Integer;
    FFkTypeFraction: Integer;
    FFkTypePayment: TTypePayment;
    FFlagProdDef: Boolean;
    FFlagTrn: Boolean;
    FNomVnd: string;
    procedure SetFkTypePayment(Value: TTypePayment);
    procedure SetNomVnd(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property FkAgent: Integer read FFkAgent write FFkAgent;
    property FkCarrier: Integer read FFkCarrier write FFkCarrier;
    property FkPortDst: Integer read FFkPortDst write FFkPortDst;
    property FkPortEmb: Integer read FFkPortEmb write FFkPortEmb;
    property FkPriceTable: Integer read FFkPriceTable write FFkPriceTable;
    property FkTypeDiscount: Integer read FFkTypeDiscount write FFkTypeDiscount;
    property FkTypeFraction: Integer read FFkTypeFraction write FFkTypeFraction;
    property FkTypePayment: TTypePayment read FFkTypePayment write 
            SetFkTypePayment;
    property FlagProdDef: Boolean read FFlagProdDef write FFlagProdDef;
    property FlagTrn: Boolean read FFlagTrn write FFlagTrn;
    property NomVnd: string read FNomVnd write SetNomVnd;
  end;
  
  TCustomer = class (TPersistent)
  private
    FCodCtb: Integer;
    FCollectionAddress: TCollectionAddress;
    FDeliveryAddress: TDeliveryAddress;
    FDiaEms: Byte;
    FDsctAtc: Double;
    FDsctAut: Double;
    FFkAgent: Integer;
    FFkBank: TBank;
    FFkCarrier: Integer;
    FFkDeliveryPeriod: Integer;
    FFkPaymentWay: TPaymentWay;
    FFkPortDst: Integer;
    FFkPortEmb: Integer;
    FFkPriceTable: TPriceTable;
    FFkRepresentant: Integer;
    FFkTypeBlock: TTypeBlock;
    FFkTypeDiscount: TTypeDiscount;
    FFkTypeEstablishment: Integer;
    FFkTypeFraction: Integer;
    FFkTypePayment: TTypePayment;
    FFkVendor: Integer;
    FFlagCnsm: Boolean;
    FFlagDifAcc: Integer;
    FFlagDtaBas: TBaseDate;
    FFlagFobDirigido: Boolean;
    FFlagPAbr: Boolean;
    FFlagPend: Boolean;
    FFlagSameRegion: Boolean;
    FIdxConv: Double;
    FLimCred: Double;
    FMinAccess: Double;
    FModified: Boolean;
    FOpeAut: string;
    FOpeLib: string;
    FPartners: TPartners;
    FPersonalData: TPersonalData;
    FPwdAccess: string;
    FReferences: TReferences;
    FSitBlockAnt: Integer;
    FTaxAccess: Double;
    procedure SetCollectionAddress(AValue: TCollectionAddress);
    procedure SetDeliveryAddress(AValue: TDeliveryAddress);
    procedure SetFkBank(Value: TBank);
    procedure SetFkPaymentWay(Value: TPaymentWay);
    procedure SetFkPriceTable(Value: TPriceTable);
    procedure SetFkTypeBlock(Value: TTypeBlock);
    procedure SetFkTypeDiscount(Value: TTypeDiscount);
    procedure SetFkTypePayment(Value: TTypePayment);
    procedure SetOpeAut(AValue: string);
    procedure SetOpeLib(AValue: string);
    procedure SetPartners(Value: TPartners);
    procedure SetPersonalData(Value: TPersonalData);
    procedure SetReferences(Value: TReferences);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property CodCtb: Integer read FCodCtb write FCodCtb;
    property CollectionAddress: TCollectionAddress read FCollectionAddress 
            write SetCollectionAddress;
    property DeliveryAddress: TDeliveryAddress read FDeliveryAddress write 
            SetDeliveryAddress;
    property DiaEms: Byte read FDiaEms write FDiaEms;
    property DsctAtc: Double read FDsctAtc write FDsctAtc;
    property DsctAut: Double read FDsctAut write FDsctAut;
    property FkAgent: Integer read FFkAgent write FFkAgent;
    property FkBank: TBank read FFkBank write SetFkBank;
    property FkCarrier: Integer read FFkCarrier write FFkCarrier;
    property FkDeliveryPeriod: Integer read FFkDeliveryPeriod write 
            FFkDeliveryPeriod;
    property FkPaymentWay: TPaymentWay read FFkPaymentWay write SetFkPaymentWay;
    property FkPortDst: Integer read FFkPortDst write FFkPortDst;
    property FkPortEmb: Integer read FFkPortEmb write FFkPortEmb;
    property FkPriceTable: TPriceTable read FFkPriceTable write SetFkPriceTable;
    property FkRepresentant: Integer read FFkRepresentant write FFkRepresentant;
    property FkTypeBlock: TTypeBlock read FFkTypeBlock write SetFkTypeBlock;
    property FkTypeDiscount: TTypeDiscount read FFkTypeDiscount write 
            SetFkTypeDiscount;
    property FkTypeEstablishment: Integer read FFkTypeEstablishment write 
            FFkTypeEstablishment;
    property FkTypeFraction: Integer read FFkTypeFraction write FFkTypeFraction;
    property FkTypePayment: TTypePayment read FFkTypePayment write 
            SetFkTypePayment;
    property FkVendor: Integer read FFkVendor write FFkVendor;
    property FlagCnsm: Boolean read FFlagCnsm write FFlagCnsm;
    property FlagDifAcc: Integer read FFlagDifAcc write FFlagDifAcc;
    property FlagDtaBas: TBaseDate read FFlagDtaBas write FFlagDtaBas default 
            bdInvoice;
    property FlagFobDirigido: Boolean read FFlagFobDirigido write 
            FFlagFobDirigido;
    property FlagPAbr: Boolean read FFlagPAbr write FFlagPAbr;
    property FlagPend: Boolean read FFlagPend write FFlagPend default False;
    property FlagSameRegion: Boolean read FFlagSameRegion write FFlagSameRegion;
    property IdxConv: Double read FIdxConv write FIdxConv;
    property LimCred: Double read FLimCred write FLimCred;
    property MinAccess: Double read FMinAccess write FMinAccess;
    property Modified: Boolean read FModified write FModified;
    property OpeAut: string read FOpeAut write SetOpeAut;
    property OpeLib: string read FOpeLib write SetOpeLib;
    property Partners: TPartners read FPartners write SetPartners;
    property PersonalData: TPersonalData read FPersonalData write 
            SetPersonalData;
    property PwdAccess: string read FPwdAccess write FPwdAccess;
    property References: TReferences read FReferences write SetReferences;
    property SitBlockAnt: Integer read FSitBlockAnt write FSitBlockAnt;
    property TaxAccess: Double read FTaxAccess write FTaxAccess;
  end;
  
  TOwner = class (TPersistent)
  private
    FAddress: TAddress;
    FAreaAtu: string;
    FCategories: TCategories;
    FcbIndex: Integer;
    FCustomer: TCustomer;
    FDocPri: string;
    FDocSec: string;
    FeMailCad: string;
    FEmployee: TEmployee;
    FFkAlias: Integer;
    FFkContacts: Integer;
    FFlagEtq: Boolean;
    FFlagTCad: TTypeOwner;
    FHttpCad: string;
    FInternetAddresses: TInternetAddresses;
    FNomFan: string;
    FObsCad: TStrings;
    FOwnerEvents: TOwnerEvents;
    FPhones: TPhones;
    FPkCadastros: Integer;
    FRazSoc: string;
    FSupplier: TSupplier;
    FTitle: string;
    FValidateCNPJ: TValidateStringEvent;
    FValidateCPF: TValidateStringEvent;
    FValidateIE: TValidateStringEvent;
    function GetFlagZumbi: Boolean;
    procedure SetAddress(AValue: TAddress);
    procedure SetAreaAtu(AValue: string);
    procedure SetCategories(AValue: TCategories);
    procedure SetCustomer(AValue: TCustomer);
    procedure SetDocPri(AValue: string);
    procedure SetDocSec(AValue: string);
    procedure SeteMailCad(const AValue: string);
    procedure SetEmployee(AValue: TEmployee);
    procedure SetHttpCad(const AValue: string);
    procedure SetInternetAddresses(AValue: TInternetAddresses);
    procedure SetNomFan(const AValue: string);
    procedure SetObsCad(AValue: TStrings);
    procedure SetOwnerEvents(AValue: TOwnerEvents);
    procedure SetPhones(AValue: TPhones);
    procedure SetRazSoc(AValue: string);
    procedure SetSupplier(AValue: TSupplier);
    procedure SetTitle(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetCategory(ACategory: TCategoryType): Boolean;
    function GetFields: TStrings;
    function GetSearchSQL(AFieldOrder: string = 'Cad.RAZ_SOC'): TStrings;
    property Address: TAddress read FAddress write SetAddress;
    property AreaAtu: string read FAreaAtu write SetAreaAtu;
    property Categories: TCategories read FCategories write SetCategories;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property Customer: TCustomer read FCustomer write SetCustomer;
    property DocPri: string read FDocPri write SetDocPri;
    property DocSec: string read FDocSec write SetDocSec;
    property eMailCad: string read FeMailCad write SeteMailCad;
    property Employee: TEmployee read FEmployee write SetEmployee;
    property FkAlias: Integer read FFkAlias write FFkAlias;
    property FkContacts: Integer read FFkContacts write FFkContacts;
    property FlagEtq: Boolean read FFlagEtq write FFlagEtq default True;
    property FlagTCad: TTypeOwner read FFlagTCad write FFlagTCad default 
            toCompany;
    property FlagZumbi: Boolean read GetFlagZumbi;
    property HttpCad: string read FHttpCad write SetHttpCad;
    property InternetAddresses: TInternetAddresses read FInternetAddresses 
            write SetInternetAddresses;
    property NomFan: string read FNomFan write SetNomFan;
    property ObsCad: TStrings read FObsCad write SetObsCad;
    property OwnerEvents: TOwnerEvents read FOwnerEvents write SetOwnerEvents;
    property Phones: TPhones read FPhones write SetPhones;
    property PkCadastros: Integer read FPkCadastros write FPkCadastros default 
            0;
    property RazSoc: string read FRazSoc write SetRazSoc;
    property Supplier: TSupplier read FSupplier write SetSupplier;
    property Title: string read FTitle write SetTitle;
    property ValidateCNPJ: TValidateStringEvent read FValidateCNPJ write 
            FValidateCNPJ;
    property ValidateCPF: TValidateStringEvent read FValidateCPF write 
            FValidateCPF;
    property ValidateIE: TValidateStringEvent read FValidateIE write 
            FValidateIE;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  

implementation

{
*********************************** TPartner ***********************************
}
constructor TPartner.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FAddress := TAddress.Create;
  Clear;
end;

destructor TPartner.Destroy;
begin
  inherited Destroy;
  Clear;
  if Assigned(FAddress) then
    FAddress.Free;
  FAddress     := nil;
  FValidateCPF := nil;
end;

procedure TPartner.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TPartner) then
  begin
    eMailSoc  := TPartner(Source).eMailSoc;
    NomSoc    := TPartner(Source).NomSoc;
    FDtaNasc  := TPartner(Source).DtaNasc;
    PkPartner := TPartner(Source).PkPartner;
    if Assigned(FAddress) then
      Address := TPartner(Source).Address;
  end
  else
    inherited Assign(Source);
end;

procedure TPartner.Clear;
begin
  FeMailSoc  := '';
  FNomSoc    := '';
  FDtaNasc   := 0;
  FPkPartner := '';
  if Assigned(FAddress) then
    FAddress.Clear;
end;

function TPartner.GetDisplayName: string;
begin
  Result := FNomSoc;
  if (Result = '') then Result := inherited GetDisplayName;
end;

function TPartner.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_CLIENTES');
  Result.Add('PK_SOCIOS');
  Result.Add('NOM_SOC');
  if (Address.FkCity.FkState.FkCountry.PkCountry > 0) then
    Result.Add('FK_PAISES');
  if (Address.FkCity.FkState.PkState <> '') then
    Result.Add('FK_ESTADOS');
  if (Address.FkCity.PkCity > 0) then
    Result.Add('FK_MUNICIPIOS');
  if (Address.EndAdd <> '') then
    Result.Add('END_SOC');
  if (Address.NumAdd > 0) then
    Result.Add('NUM_SOC');
  if (Address.CmpEnd <> '') then
    Result.Add('CMP_SOC');
  if (Address.CepAdd > 0) then
    Result.Add('CEP_SOC');
  if (eMailSoc <> '') then
    Result.Add('MAIL_SOC');
  if (DtaNasc > 0) then
    Result.Add('DTA_NAS');
end;

procedure TPartner.SetAddress(Value: TAddress);
begin
  if (not Assigned(FAddress)) then exit;
  if (Value = nil) then
    FAddress.Clear
  else
    FAddress.Assign(Value);
end;

procedure TPartner.SeteMailSoc(Value: string);
begin
  FeMailSoc := Copy(Value, 1, 50);
end;

procedure TPartner.SetNomSoc(Value: string);
begin
  FNomSoc := Copy(Value, 1, 50);
end;

procedure TPartner.SetPkPartner(Value: string);
var
  aValidate: Boolean;
begin
  aValidate := True;
  if (Assigned(FValidateCPF))  then
    FValidateCPF(Self, Value, aValidate);
  if (aValidate) then
    FPkPartner := Copy(Value, 1, 14)
  else
    raise Exception.Create('Error: Field CPF Partner is Invalid');
end;

{
********************************** TPartners ***********************************
}
constructor TPartners.Create(AOwner: TPersistent);
begin
  inherited Create(TPhone);
  Clear;
  FOwner := AOwner;
end;

destructor TPartners.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TPartners.Add: TPartner;
begin
  Result := inherited Add as TPartner;
  if (Result <> nil) then
    FItemIndex := Result.Index;
end;

procedure TPartners.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if (Source <> nil) and (Source is TPartners) then
  begin
    Clear;
    for i := 0 to TPartners(Source).Count - 1 do
    begin
       with Add do
         Assign(TPartners(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TPartners.Clear;
begin
  inherited Clear;
  FItemIndex := -1;
end;

procedure TPartners.Delete(Index: Integer);
begin
  inherited Delete(Index);
  if (Index = FItemIndex) and ((FItemIndex - 1) < Count) then
    Dec(FItemIndex);
end;

function TPartners.GetItems(Index: Integer): TPartner;
begin
  Result := inherited Items[Index] as TPartner;
  if (Result <> nil) then
    FItemIndex := Result.Index;
end;

function TPartners.GetOwner: TPersistent;
begin
  Result := FOwner;
  if Result = nil then Result := inherited GetOwner;
end;

function TPartners.Insert(Index: Integer): TPartner;
begin
  Result := inherited Insert(Index) as TPartner;
  FItemIndex := Index;
end;

procedure TPartners.SetItemIndex(Value: Integer);
begin
  if (Value <> FItemIndex) and (Value < Count) then
    FItemIndex := Value;
end;

procedure TPartners.SetItems(Index: Integer; AValue: TPartner);
begin
  inherited Items[Index] := AValue;
  FItemIndex := Index;
end;

{
********************************** TReference **********************************
}
constructor TReference.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FObsRef := TStringList.Create;
  Clear;
end;

destructor TReference.Destroy;
begin
  Clear;
  if Assigned(FObsRef) then
    FObsRef.Free;
  FObsRef := nil;
  inherited Destroy;
end;

procedure TReference.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TReference) then
  begin
    eMailRef := TReference(Source).eMailRef;
    FFlagCnf := TReference(Source).FlagCnf;
    FonRef   := TReference(Source).FonRef;
    NomRef   := TReference(Source).NomRef;
    if Assigned(FObsRef) then
      ObsRef := TReference(Source).ObsRef;
  end
  else
    inherited Assign(Source);
end;

procedure TReference.Clear;
begin
  FeMailRef := '';
  FFlagCnf  := False;
  FFonRef   := '';
  FModified := False;
  FNomRef   := '';
  if Assigned(FObsRef) then
    FObsRef.Clear;
end;

function TReference.GetDisplayName: string;
begin
  Result := FNomRef;
  if (Result = '') then Result := inherited GetDisplayName;
end;

function TReference.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_CLIENTES');
  Result.Add('NOM_REF');
  Result.Add('FLAG_CNF');
  Result.Add('PK_REFERENCIA_COMERCIAIS');
  if (FonRef <> '') then
    Result.Add('FON_REF');
  if (eMailRef <> '') then
    Result.Add('MAIL_REF');
  if (ObsRef.Text <> '') then
    Result.Add('OBS_REF');
end;

function TReference.GetPkCadastros: Integer;
begin
  Result := 0;
  if (Collection.Owner is TOwner) then
    Result := TOwner(Collection.Owner).PkCadastros;
end;

procedure TReference.SeteMailRef(Value: string);
begin
  FeMailRef := Copy(Value, 1, 50);
end;

procedure TReference.SetFonRef(Value: string);
begin
  FFonRef := Copy(Value, 1, 20);
end;

procedure TReference.SetNomRef(Value: string);
begin
  FNomRef := Copy(Value, 1, 50);
end;

procedure TReference.SetObsRef(Value: TStrings);
begin
  if (not Assigned(FObsRef)) then exit;
  if (Value = nil) then
    FObsRef.Clear
  else
    FObsRef.Assign(Value);
end;

{
********************************* TReferences **********************************
}
constructor TReferences.Create(AOwner: TPersistent);
begin
  inherited Create(TPhone);
  Clear;
  FOwner := AOwner;
end;

destructor TReferences.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TReferences.Add: TReference;
begin
  Result := inherited Add as TReference;
  if (Result <> nil) then
    FItemIndex := Result.Index;
end;

procedure TReferences.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if (Source <> nil) and (Source is TReferences) then
  begin
    Clear;
    for i := 0 to TReferences(Source).Count - 1 do
    begin
      with Add do
        Assign(TReferences(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TReferences.Clear;
begin
  inherited Clear;
  FItemIndex := -1;
end;

procedure TReferences.Delete(Index: Integer);
begin
  inherited Delete(Index);
  if (Index = FItemIndex) and ((FItemIndex - 1) < Count) then
    Dec(FItemIndex);
end;

function TReferences.GetItems(Index: Integer): TReference;
begin
  Result := inherited Items[Index] as TReference;
  if (Result <> nil) then
    FItemIndex := Result.Index;
end;

function TReferences.GetOwner: TPersistent;
begin
  Result := FOwner;
  if Result = nil then Result := inherited GetOwner;
end;

function TReferences.Insert(Index: Integer): TReference;
begin
  Result := inherited Insert(Index) as TReference;
  FItemIndex := Index;
end;

procedure TReferences.SetItemIndex(Value: Integer);
begin
  if (Value <> FItemIndex) and (Value < Count) then
    FItemIndex := Value;
end;

procedure TReferences.SetItems(Index: Integer; AValue: TReference);
begin
  inherited Items[Index] := AValue;
  FItemIndex := Index;
end;

{
******************************** TPersonalData *********************************
}
constructor TPersonalData.Create;
begin
  inherited Create;
  FFkCity := TCity.Create;
  FObsPes := TStringList.Create;
  Clear;
end;

destructor TPersonalData.Destroy;
begin
  Clear;
  if Assigned(FFkCity) then
    FFkCity.Free;
  if Assigned(FObsPes) then
    FObsPes.Clear;
  FFkCity := nil;
  FObsPes := nil;
  inherited Destroy;
end;

procedure TPersonalData.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TPersonalData) then
  begin
    FCmpVal  := TPersonalData(Source).CmpVal;
    CrgCli   := TPersonalData(Source).CrgCli;
    FDtaAdm  := TPersonalData(Source).DtaAdm;
    FDtaExp  := TPersonalData(Source).DtaExp;
    EmpTrb   := TPersonalData(Source).EmpTrb;
    EscCad   := TPersonalData(Source).EscCad;
    FFlagSex := TPersonalData(Source).FlagSex;
    FonEmp   := TPersonalData(Source).FonEmp;
    NomMae   := TPersonalData(Source).NomMae;
    NomPai   := TPersonalData(Source).NomPai;
    NumCnh   := TPersonalData(Source).NumCnh;
    PrfCli   := TPersonalData(Source).PrfCli;
    FSalCli  := TPersonalData(Source).SalCli;
    FValCnh  := TPersonalData(Source).ValCnh;
    FVlrAlg  := TPersonalData(Source).VlrAlg;
    if Assigned(FFkCity) then
      FkCity := TPersonalData(Source).FkCity;
    if Assigned(FObsPes) then
      ObsPes := TPersonalData(Source).ObsPes;
  end
  else
    inherited Assign(Source);
end;

procedure TPersonalData.Clear;
begin
  FCmpVal  := 0.0;
  FCrgCli  := '';
  FDtaAdm  := 0;
  FDtaExp  := 0;
  FEmpTrb  := '';
  FEscCad  := '';
  FFlagSex := stMale;
  FFonEmp  := '';
  FNomMae  := '';
  FNomPai  := '';
  FNumCnh  := '';
  FPrfCli  := '';
  FSalCli  := 0.0;
  FValCnh  := 0;
  FVlrAlg  := 0.0;
  if Assigned(FFkCity) then
    FFkCity.Clear;
  if Assigned(FObsPes) then
    FObsPes.Clear;
end;

function TPersonalData.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_CLIENTES');
  Result.Add('FLAG_SEX');
  Result.Add('FK_PAISES');
  Result.Add('FK_ESTADOS');
  Result.Add('FK_MUNICIPIOS');
  Result.Add('NOM_PAI');
  Result.Add('NOM_MAE');
  Result.Add('SAL_CLI');
  Result.Add('CMP_SAL');
  Result.Add('VLR_ALG');
  if (FEmpTrb <> '') then
    Result.Add('EMP_TRB');
  if (FFonEmp <> '') then
    Result.Add('FON_EMP');
  if (FDtaAdm > 0) then
    Result.Add('DTA_ADM');
  if (FCrgCli <> '') then
    Result.Add('CRG_CLI');
  if (FNumCnh <> '') then
    Result.Add('NUM_CNH');
  if (FDtaExp > 0) then
    Result.Add('DTA_EXP');
  if (FValCnh > 0) then
    Result.Add('VAL_CNH');
  if (FEscCad <> '') then
    Result.Add('ESC_CAD');
  if (FPrfCli <> '') then
    Result.Add('PRF_CLI');
  if (FObsPes.Text <> '') then
    Result.Add('OBS_PES');
end;

procedure TPersonalData.SetCrgCli(Value: string);
begin
  FCrgCli := Copy(Value, 1, 30);
end;

procedure TPersonalData.SetEmpTrb(Value: string);
begin
  FEmpTrb := Copy(Value, 1, 30);
end;

procedure TPersonalData.SetEscCad(Value: string);
begin
  FEscCad := Copy(Value, 1, 20);
end;

procedure TPersonalData.SetFkCity(Value: TCity);
begin
  if (not Assigned(FFkCity)) then exit;
  FFkCity.Clear;
  if (Value = nil) then
    FFkCity.Assign(Value);
end;

procedure TPersonalData.SetFonEmp(Value: string);
begin
  FFonEmp := Copy(Value, 1, 20);
end;

procedure TPersonalData.SetNomMae(Value: string);
begin
  FNomMae := Copy(Value, 1, 50);
end;

procedure TPersonalData.SetNomPai(Value: string);
begin
  FNomPai := Copy(Value, 1, 50);
end;

procedure TPersonalData.SetNumCnh(Value: string);
begin
  FNumCnh := Copy(Value, 1, 20);
end;

procedure TPersonalData.SetObsPes(Value: TStrings);
begin
  if (not Assigned(FObsPes)) then exit;
  if (Value = nil) then
    FObsPes.Clear
  else
    FObsPes.Assign(Value);
end;

procedure TPersonalData.SetPrfCli(Value: string);
begin
  FPrfCli := Copy(Value, 1, 20);
end;

{
****************************** TCollectionAddress ******************************
}
constructor TCollectionAddress.Create;
begin
  inherited Create;
  FAddress := TAddress.Create;
  FPhones  := TPhones.Create(Self);
  Clear;
end;

destructor TCollectionAddress.Destroy;
begin
  Clear;
  if Assigned(FAddress) then
    FAddress.Free;
  if Assigned(FPhones) then
    FPhones.Free;
  FAddress := nil;
  FPhones  := nil;
  inherited Destroy;
end;

procedure TCollectionAddress.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TCollectionAddress) then
  begin
    if Assigned(FAddress) then
      Address := TCollectionAddress(Source).Address;
    if Assigned(FPhones) then
      Phones := TCollectionAddress(Source).Phones;
  end
  else
    inherited Assign(Source);
end;

procedure TCollectionAddress.Clear;
begin
  if Assigned(FAddress) then
    FAddress.Clear;
  if Assigned(FPhones) then
    Phones.Clear;
end;

function TCollectionAddress.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_CLIENTES');
  Result.Add('FK_PAISES');
  Result.Add('FK_ESTADOS');
  Result.Add('FK_MUNICIPIOS');
  Result.Add('END_CBR');
  Result.Add('NUM_CBR');
  Result.Add('CEP_CBR');
  if (FAddress.CmpEnd <> '') then
    Result.Add('CMP_CBR');
  if (FAddress.CxpAdd <> '') then
    Result.Add('CXP_CBR');
  if (FPhones.Items[0].FonCad <> '') then
    Result.Add('FON_CBR');
  if (FPhones.Items[1].FonCad <> '') then
    Result.Add('FAX_CBR');
end;

procedure TCollectionAddress.SetAddress(AValue: TAddress);
begin
  if (not Assigned(FAddress)) then exit;
  if (AValue = nil) then
    FAddress.Clear
  else
    FAddress.Assign(AValue);
end;

procedure TCollectionAddress.SetPhones(AValue: TPhones);
begin
  if (not Assigned(FPhones)) then exit;
  if (AValue = nil) then
    FPhones.Clear
  else
    FPhones.Assign(AValue);
end;

{
******************************* TDeliveryAddress *******************************
}
constructor TDeliveryAddress.Create;
begin
  inherited Create;
  FAddress := TAddress.Create;
  FPhones  := TPhones.Create(Self);
  Clear;
end;

destructor TDeliveryAddress.Destroy;
begin
  Clear;
  if Assigned(FAddress) then FAddress.Free;
  if Assigned(FPhones)  then FPhones.Free;
  FAddress := nil;
  FPhones  := nil;
  inherited Destroy;
end;

procedure TDeliveryAddress.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TDeliveryAddress) then
  begin
    if Assigned(FAddress) then
      Address := TDeliveryAddress(Source).Address;
    CNPJEntr  := TDeliveryAddress(Source).CNPJEntr;
    IEEntr    := TDeliveryAddress(Source).IEEntr;
    if Assigned(FPhones) then
      Phones  := TDeliveryAddress(Source).Phones;
  end
  else
    inherited Assign(Source);
end;

procedure TDeliveryAddress.Clear;
begin
  if Assigned(Address) then
    FAddress.Clear;
  if Assigned(Phones) then
    FPhones.Clear;
  FCNPJEntr := '';
  FIEEntr   := '';
end;

function TDeliveryAddress.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_CLIENTES');
  Result.Add('FK_PAISES');
  Result.Add('FK_ESTADOS');
  Result.Add('FK_MUNICIPIOS');
  Result.Add('END_ENT');
  Result.Add('NUM_ENT');
  Result.Add('CEP_ENT');
  if (FCNPJEntr <> '') then
    Result.Add('CNPJ_ENTR');
  if (FIEEntr <> '') then
    Result.Add('IE_ENTR');
  if (FAddress.CmpEnd <> '') then
    Result.Add('CMP_ENT');
  if (FAddress.CxpAdd <> '') then
    Result.Add('CXP_ENT');
  if (FPhones.Items[0].FonCad <> '') then
    Result.Add('FON_ENT');
  if (FPhones.Items[1].FonCad <> '') then
    Result.Add('FAX_ENT');
end;

procedure TDeliveryAddress.SetAddress(AValue: TAddress);
begin
  if (FAddress = nil) then exit;
  FAddress.Clear;
  if (AValue <> nil) then
    FAddress.Assign(AValue);
end;

procedure TDeliveryAddress.SetCNPJEntr(AValue: string);
var
  aValidate: Boolean;
begin
  aValidate := True;
  if (AValue <> '') and (Assigned(FValidateCNPJ)) then
    FValidateCNPJ(Self, FCNPJEntr, aValidate);
  if aValidate then
    FCNPJEntr := Copy(AValue, 1, 14)
  else
    raise Exception.Create('Error: Field CNPJ Delivery is not valid');
end;

procedure TDeliveryAddress.SetIEEntr(AValue: string);
var
  aValidate: Boolean;
begin
  aValidate := True;
  if (AValue <> '') and (Assigned(FValidateIE)) then
    FValidateIE(Self, FIEEntr, aValidate);
  if aValidate then
    FIEEntr := Copy(AValue, 1, 30)
  else
    raise Exception.Create('Error: Field IE Delivery is not valid');
end;

procedure TDeliveryAddress.SetPhones(AValue: TPhones);
begin
  if (FPhones = nil) then exit;
  FPhones.Clear;
  if (AValue <> nil) then
    FPhones.Assign(AValue);
end;

{
********************************** TEmployee ***********************************
}
constructor TEmployee.Create;
begin
  inherited Create;
  FFkCompany  := TCompany.Create;
  FFkBornFrom := TCity.Create;
  FFkCity     := TCity.Create;
  FFkBank     := TBank.Create;
  FFkBankFgts := TBank.Create;
  Clear;
end;

destructor TEmployee.Destroy;
begin
  Clear;
  if Assigned(FFkCompany) then
    FFkCompany.Free;
  if Assigned(FFkBornFrom) then
    FFkBornFrom.Free;
  if Assigned(FFkCity) then
    FFkCity.Free;
  if Assigned(FFkBank) then
    FFkBank.Free;
  if Assigned(FFkBankFgts) then
    FFkBankFgts.Free;
  FFkCity     := nil;
  FFkBank     := nil;
  FFkBankFgts := nil;
  FFkCompany  := nil;
  FFkBornFrom := nil;
  inherited Destroy;
end;

procedure TEmployee.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TEmployee) then
  begin
    if Assigned(FFkBornFrom) then
      FkBornFrom     := TEmployee(Source).FkBornFrom;
    if Assigned(FFkCompany) then
      FkCompany      := TEmployee(Source).FkCompany;
    FFlagCrg         := TEmployee(Source).FlagCrg;
    if Assigned(FFkBank) then
      FkBank         := TEmployee(Source).FkBank;
    if Assigned(FFkBankFgts) then
      FkBankFgts     := TEmployee(Source).FkBankFgts;
    if Assigned(FFkCity) then
      FkCity         := TEmployee(Source).FkCity;
    FFlagCrg         := TEmployee(Source).FlagCrg;
    FAnoCheg         := TEmployee(Source).AnoCheg;
    FCodCtb          := TEmployee(Source).CodCtb;
    FComVnd          := TEmployee(Source).ComVnd;
    FDsctMax         := TEmployee(Source).DsctMax;
    FDtaAdm          := TEmployee(Source).DtaAdm;
    FDtaApst         := TEmployee(Source).DtaApst;
    FDtaCad          := TEmployee(Source).DtaCad;
    FDtaEmiRg        := TEmployee(Source).DtaEmiRg;
    FDtaExp          := TEmployee(Source).DtaExp;
    FDtaNasc         := TEmployee(Source).DtaNasc;
    FDtaNascFilho    := TEmployee(Source).DtaNascFilho;
    FFkCostsCenter   := TEmployee(Source).FkCostsCenter;
    FFkDepartament   := TEmployee(Source).FkDepartament;
    FFkFunctions     := TEmployee(Source).FkFunctions;
    FFkSector        := TEmployee(Source).FkSector;
    FFkTypeComission := TEmployee(Source).FkTypeComission;
    FFlagApst        := TEmployee(Source).FlagApst;
    FFlagDef         := TEmployee(Source).FlagDef;
    FFlagEstCiv      := TEmployee(Source).FlagEstCiv;
    FFlagGrInstr     := TEmployee(Source).FlagGrInstr;
    FFlagOpPrv       := TEmployee(Source).FlagOpPrv;
    FFlagSex         := TEmployee(Source).FlagSex;
    FFlagTempr       := TEmployee(Source).FlagTempr;
    FFlagTSal        := TEmployee(Source).FlagTSal;
    FNumCtps         := TEmployee(Source).NumCtps;
    FNumDepIr        := TEmployee(Source).NumDepIr;
    FNumFunc         := TEmployee(Source).NumFunc;
    FPercInsl        := TEmployee(Source).PercInsl;
    FPercPeric       := TEmployee(Source).PercPeric;
    FQtdFilhos       := TEmployee(Source).QtdFilhos;
    FQtdHours        := TEmployee(Source).QtdHours;
    FRefLivro        := TEmployee(Source).RefLivro;
    FVlrSal          := TEmployee(Source).VlrSal;
    SerCtps          := TEmployee(Source).SerCtps;
    HabProf          := TEmployee(Source).HabProf;
    LotFun           := TEmployee(Source).LotFun;
    NomConslh        := TEmployee(Source).NomConslh;
    NomMae           := TEmployee(Source).NomMae;
    NomPai           := TEmployee(Source).NomPai;
    NomSind          := TEmployee(Source).NomSind;
    NumReg           := TEmployee(Source).NumReg;
    NumTit           := TEmployee(Source).NumTit;
    PisFunc          := TEmployee(Source).PisFunc;
    RacaCor          := TEmployee(Source).RacaCor;
    SecaoTit         := TEmployee(Source).SecaoTit;
    SitApst          := TEmployee(Source).SitApst;
    TipoVisto        := TEmployee(Source).TipoVisto;
    UfCtps           := TEmployee(Source).UfCtps;
    VincFun          := TEmployee(Source).VincFun;
    ZonaTit          := TEmployee(Source).ZonaTit;
  end
  else
    inherited Assign(Source);
end;

procedure TEmployee.Clear;
begin
  FkBornFrom       := nil;
  FkCompany        := nil;
  FkBank           := nil;
  FkBankFgts       := nil;
  FkCity           := nil;
  FFlagCrg         := ptAdmin;
  FAnoCheg         := 0;
  FCodCtb          := 0;
  FComVnd          := 0.0;
  FDsctMax         := 0.0;
  FDtaAdm          := 0;
  FDtaApst         := 0;
  FDtaCad          := 0;
  FDtaEmiRg        := 0;
  FDtaExp          := 0;
  FDtaNasc         := 0;
  FDtaNascFilho    := 0;
  FFkCostsCenter   := 0;
  FFkDepartament   := 0;
  FFkFunctions     := 0;
  FFkSector        := 0;
  FFkTypeComission := 0;
  FFlagApst        := False;
  FFlagDef         := False;
  FFlagEstCiv      := csSingle;
  FFlagGrInstr     := slFirst;
  FFlagOpPrv       := False;
  FFlagSex         := stMale;
  FFlagTempr       := False;
  FFlagTSal        := tsMonthly;
  FNumCtps         := 0;
  FNumDepIr        := 0;
  FNumFunc         := 0;
  FPercInsl        := 0.0;
  FPercPeric       := 0.0;
  FQtdFilhos       := 0;
  FQtdHours        := 0;
  FRefLivro        := 0;
  FVlrSal          := 0;
  SerCtps          := '';
  HabProf          := '';
  LotFun           := '';
  NomConslh        := '';
  NomMae           := '';
  NomPai           := '';
  NomSind          := '';
  NumReg           := '';
  NumTit           := '';
  PisFunc          := '';
  RacaCor          := '';
  SecaoTit         := '';
  SitApst          := '';
  TipoVisto        := '';
  UfCtps           := '';
  VincFun          := '';
  ZonaTit          := '';
end;

function TEmployee.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_CADASTROS');
  Result.Add('FK_EMPRESAS');
  Result.Add('FLAG_CRG');
  Result.Add('FLAG_SEXO');
  Result.Add('FLAG_ESTCV');
  Result.Add('FLAG_GRINSTR');
  Result.Add('FLAG_APST');
  Result.Add('FLAG_DEF');
  Result.Add('FLAG_OPPRV');
  Result.Add('FLAG_TSAL');
  Result.Add('FLAG_TEMPR');
  Result.Add('FK_DEPARTAMENTOS');
  Result.Add('DTA_CAD');
  if (FkFunctions > 0) then
    Result.Add('FK_TIPO_CARGOS');
  if (FkSector > 0) then
    Result.Add('FK_SETOR');
  if (FkCostsCenter > 0) then
    Result.Add('FK_CENTRO_CUSTOS');
  if (FkTypeComission > 0) then
    Result.Add('FK_TIPO_COMISSOES');
  if (FkBank.PkBank > 0) then
    Result.Add('FK_BANCOS');
  if (FkBankFgts.PkBank > 0) then
    Result.Add('FK_BANCOS__FGTS');
  if (FkCity.FkState.FkCountry.PkCountry > 0) then
    Result.Add('FK_PAISES');
  if (FkCity.FkState.PkState <> '') then
    Result.Add('FK_ESTADOS');
  if (FkCity.PkCity > 0) then
    Result.Add('FK_MUNICIPIOS');
  if (ComVnd > 0) then
    Result.Add('COM_VND');
  if (LotFun <> '') then
    Result.Add('LOT_FUN');
  if (CodCtb > 0) then
    Result.Add('COD_CTB');
  if (NumFunc > 0) then
    Result.Add('NUM_FUNC');
  if (NumCtps > 0) then
    Result.Add('NUM_CTPS');
  if (SerCtps <> '') then
    Result.Add('SER_CTPS');
  if (DtaExp > 0) then
    Result.Add('DTA_EXP');
  if (UfCtps <> '') then
    Result.Add('UF_CTPS');
  if (DtaEmiRg > 0) then
    Result.Add('DTA_EMI_RG');
  if (NumTit > '') then
    Result.Add('NUM_TIT');
  if (ZonaTit <> '') then
    Result.Add('ZONA_TIT');
  if (SecaoTit <> '') then
    Result.Add('SECAO_TIT');
  if (PisFunc <> '') then
    Result.Add('PIS_FUNC');
  if (DtaNasc > 0) then
    Result.Add('DTA_NASC');
  if (HabProf <> '') then
    Result.Add('HAB_PROF');
  if (NomConslh <> '') then
    Result.Add('NOM_CONSLH');
  if (NumReg <> '') then
    Result.Add('NUM_REG');
  if (AnoCheg > 0) then
    Result.Add('ANO_CHEG');
  if (TipoVisto <> '') then
    Result.Add('TIPO_VISTO');
  if (RacaCor <> '') then
    Result.Add('RACA_COR');
  if (DtaApst > 0) then
    Result.Add('DTA_APST');
  if (SitApst <> '') then
    Result.Add('SIT_APST');
  if (DtaAdm > 0) then
    Result.Add('DTA_ADM');
  if (FkBank.Agencies.Count > 0) then
    Result.Add('CONTA');
  if (FkBankFgts.Agencies.Count > 0) then
    Result.Add('CONTA_VINC');
  if (PercInsl > 0) then
    Result.Add('PERC_INS');
  if (PercPeric > 0) then
    Result.Add('PERC_PERIC');
  if (NomSind <> '') then
    Result.Add('NOM_SIND');
  if (VincFun <> '') then
    Result.Add('VINC_FUNC');
  if (QtdHours > 0) then
    Result.Add('QTD_HORAS');
  if (VlrSal > 0) then
    Result.Add('VLR_SAL');
  if (NumDepIr > 0) then
    Result.Add('NUM_DEP_IR');
  if (QtdFilhos > 0) then
    Result.Add('QTD_FILHO');
  if (DtaNascFilho > 0) then
    Result.Add('DTA_NASC_FILHO');
  if (NomPai <> '') then
    Result.Add('NOM_PAI');
  if (NomMae <> '') then
    Result.Add('NOM_MAE');
  if (RefLivro > 0) then
    Result.Add('REF_LIVRO');
  if (DsctMax > 0) then
    Result.Add('DSCT_MAX');
end;

procedure TEmployee.SetFkBank(Value: TBank);
begin
  if (FFkBank = nil) then exit;
  if (Value = nil) then
    FFkBank.Clear
  else
    FFkBank.Assign(Value);
end;

procedure TEmployee.SetFkBankFgts(Value: TBank);
begin
  if (FFkBankFgts = nil) then exit;
  if (Value = nil) then
    FFkBankFgts.Clear
  else
    FFkBankFgts.Assign(Value);
end;

procedure TEmployee.SetFkBornFrom(AValue: TCity);
begin
  if (FFkBornFrom = nil) then exit;
  if (AValue = nil) then
    FFkBornFrom.Clear
  else
    FFkBornFrom.Assign(AValue);
end;

procedure TEmployee.SetFkCity(Value: TCity);
begin
  if (FFkCity = nil) then exit;
  if (Value = nil) then
    FFkCity.Clear
  else
    FFkCity.Assign(Value);
end;

procedure TEmployee.SetFkCompany(AValue: TCompany);
begin
  if (FFkCompany = nil) then exit;
  if (AValue = nil) then
    FFkCompany.Clear
  else
    FFkCompany.Assign(AValue);
end;

procedure TEmployee.SetHabProf(Value: string);
begin
  FHabProf := Copy(Value, 1, 30);
end;

procedure TEmployee.SetLotFun(Value: string);
begin
  FLotFun := Copy(Value, 1, 20);
end;

procedure TEmployee.SetNomConslh(Value: string);
begin
  FNomConslh := Copy(Value, 1, 10);
end;

procedure TEmployee.SetNomMae(Value: string);
begin
  FNomMae := Copy(Value, 1, 50);
end;

procedure TEmployee.SetNomPai(Value: string);
begin
  FNomPai := Copy(Value, 1, 50);
end;

procedure TEmployee.SetNomSind(Value: string);
begin
  FNomSind := Copy(Value, 1, 30);
end;

procedure TEmployee.SetNumReg(Value: string);
begin
  FNumReg := Copy(Value, 1, 10);
end;

procedure TEmployee.SetNumTit(Value: string);
begin
  FNumTit := Copy(Value, 1, 30);
end;

procedure TEmployee.SetPisFunc(Value: string);
begin
  FPisFunc := Copy(Value, 1, 30);
end;

procedure TEmployee.SetRacaCor(Value: string);
begin
  FRacaCor := Copy(Value, 1, 10);
end;

procedure TEmployee.SetSecaoTit(Value: string);
begin
  FSecaoTit := Copy(Value, 1, 10);
end;

procedure TEmployee.SetSerCtps(const Value: string);
begin
  FSerCtps := Copy(Value, 1, 10);
end;

procedure TEmployee.SetSitApst(const Value: string);
begin
  FSitApst := Copy(Value, 1, 10);
end;

procedure TEmployee.SetTipoVisto(Value: string);
begin
  FTipoVisto := Copy(Value, 1, 20);
end;

procedure TEmployee.SetUfCtps(Value: string);
begin
  FUfCtps := Copy(Value, 1, 2);
end;

procedure TEmployee.SetVincFun(Value: string);
begin
  FVincFun := Copy(Value, 1, 30);
end;

procedure TEmployee.SetZonaTit(const Value: string);
begin
  FZonaTit := Copy(Value, 1, 10);
end;

{
********************************** TSupplier ***********************************
}
constructor TSupplier.Create;
begin
  inherited Create;
  FFkTypePayment  := TTypePayment.Create;
  Clear;
end;

destructor TSupplier.Destroy;
begin
  Clear;
  if Assigned(FFkTypePayment) then
    FFkTypePayment.Free;
  FFkTypePayment  := nil;
  inherited Destroy;
end;

procedure TSupplier.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TSupplier) then
  begin
    FFkAgent        := TSupplier(Source).FkAgent;
    FFkPortDst      := TSupplier(Source).FkPortDst;
    FFkPortEmb      := TSupplier(Source).FkPortEmb;
    FFkTypeDiscount := TSupplier(Source).FkTypeDiscount;
    if Assigned(FFkTypePayment) then
      FkTypePayment := TSupplier(Source).FkTypePayment;
    FFkCarrier      := TSupplier(Source).FkCarrier;
    FFkPriceTable   := TSupplier(Source).FkPriceTable;
    FFkTypeFraction := TSupplier(Source).FkTypeFraction;
    FFlagProdDef    := TSupplier(Source).FlagProdDef;
    FNomVnd         := TSupplier(Source).NomVnd;
  end
  else
    inherited Assign(Source);
end;

procedure TSupplier.Clear;
begin
  FFkAgent        := 0;
  FFkPortDst      := 0;
  FFkPortEmb      := 0;
  FFkTypeDiscount := 0;
  FkTypePayment   := nil;
  FFkCarrier      := 0;
  FkPriceTable    := 0;
  FkTypeFraction  := 0;
  FFlagProdDef    := False;
  FNomVnd         := '';
end;

function TSupplier.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_CADASTROS');
  Result.Add('FLAG_PROD_DEF');
  Result.Add('FLAG_TRN');
  if (FFkCarrier > 0) then
    Result.Add('FK_VW_TRANSPORTADORAS');
  if (FFkAgent > 0) then
    Result.Add('FK_VW_CADASTROS');
  if (FFkPortDst > 0) then
    Result.Add('FK_PORTOS__DST');
  if (FFkPortEmb > 0) then
    Result.Add('FK_PORTOS__EMB');
  if (FFkTypeDiscount > 0) then
    Result.Add('FK_DESCONTOS');
  if (FFkPriceTable > 0) then
    Result.Add('FK_TABELA_PRECOS');
  if (FFkTypeFraction > 0) then
    Result.Add('FK_TIPO_TABELA_FRACAO');
  if Assigned(FFkTypePayment) and (FFkTypePayment.PkTypePgto > 0) then
    Result.Add('FK_TIPO_PAGAMENTOS');
  if (FNomVnd <> '') then
    Result.Add('NOM_VND');
end;

procedure TSupplier.SetFkTypePayment(Value: TTypePayment);
begin
  if (FFkTypePayment = nil) then exit;
  if (Value = nil) then
    FFkTypePayment.Clear
  else
    FFkTypePayment.Assign(Value);
end;

procedure TSupplier.SetNomVnd(AValue: string);
begin
  FNomVnd := Copy(AValue, 1, 50);
end;

{
********************************** TCustomer ***********************************
}
constructor TCustomer.Create;
begin
  inherited Create;
  FCollectionAddress := TCollectionAddress.Create;
  FDeliveryAddress   := TDeliveryAddress.Create;
  FFkBank            := TBank.Create;
  FFkPaymentWay      := TPaymentWay.Create(nil);
  FFkPriceTable      := TPriceTable.Create(Self);
  FFkTypeBlock       := TTypeBlock.Create;
  FFkTypeDiscount    := TTypeDiscount.Create;
  FFkTypePayment     := TTypePayment.Create;
  FPartners          := TPartners.Create(Self);
  FPersonalData      := TPersonalData.Create;
  FReferences        := TReferences.Create(Self);
  Clear;
end;

destructor TCustomer.Destroy;
begin
  Clear;
  if Assigned(FCollectionAddress) then
    FCollectionAddress.Free;
  if Assigned(FDeliveryAddress) then
    FDeliveryAddress.Free;
  if Assigned(FFkBank) then
    FFkBank.Free;
  if Assigned(FFkPaymentWay) then
    FFkPaymentWay.Free;
  if Assigned(FFkPriceTable) then
    FFkPriceTable.Free;
  if Assigned(FFkTypeBlock) then
    FFkTypeBlock.Free;
  if Assigned(FFkTypeDiscount) then
    FFkTypeDiscount.Free;
  if Assigned(FFkTypePayment) then
    FFkTypePayment.Free;
  if Assigned(FPartners) then
    FPartners.Free;
  if Assigned(FPersonalData) then
    FPersonalData.Free;
  if Assigned(FReferences) then
    FReferences.Free;
  FCollectionAddress := nil;
  FDeliveryAddress   := nil;
  FFkBank            := nil;
  FFkPaymentWay      := nil;
  FFkPriceTable      := nil;
  FFkTypeBlock       := nil;
  FFkTypeDiscount    := nil;
  FFkTypePayment     := nil;
  FPartners          := nil;
  FPersonalData      := nil;
  FReferences        := nil;
  inherited Destroy;
end;

procedure TCustomer.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TCustomer) then
  begin
    FCodCtb              := TCustomer(Source).CodCtb;
    DiaEms               := TCustomer(Source).DiaEms;
    FDsctAtc             := TCustomer(Source).DsctAtc;
    FDsctAut             := TCustomer(Source).DsctAut;
    FFkCarrier           := TCustomer(Source).FkCarrier;
    FFkAgent             := TCustomer(Source).FkAgent;
    FFkDeliveryPeriod    := TCustomer(Source).FkDeliveryPeriod;
    FFkPortDst           := TCustomer(Source).FkPortDst;
    FFkPortEmb           := TCustomer(Source).FkPortEmb;
    FFkRepresentant      := TCustomer(Source).FkRepresentant;
    FFkTypeEstablishment := TCustomer(Source).FkTypeEstablishment;
    FFkVendor            := TCustomer(Source).FkVendor;
    FFkTypeFraction      := TCustomer(Source).FkTypeFraction;
    FFlagCnsm            := TCustomer(Source).FlagCnsm;
    FFlagDtaBas          := TCustomer(Source).FlagDtaBas;
    FFlagPAbr            := TCustomer(Source).FlagPAbr;
    FFlagPend            := TCustomer(Source).FlagPend;
    FFlagDifAcc          := TCustomer(Source).FlagDifAcc;;
    FLimCred             := TCustomer(Source).LimCred;
    FTaxAccess           := TCustomer(Source).TaxAccess;
    FMinAccess           := TCustomer(Source).MinAccess;
    FIdxConv             := TCustomer(Source).IdxConv;
    OpeAut               := TCustomer(Source).OpeAut;
    OpeLib               := TCustomer(Source).OpeLib;
    FModified            := TCustomer(Source).Modified;
    FSitBlockAnt         := TCustomer(Source).SitBlockAnt;
    FPwdAccess           := TCustomer(Source).PwdAccess;
    if Assigned(FCollectionAddress) then
      CollectionAddress  := TCustomer(Source).CollectionAddress;
    if Assigned(FDeliveryAddress) then
      DeliveryAddress    := TCustomer(Source).DeliveryAddress;
    if Assigned(FFkBank) then
      FkBank             := TCustomer(Source).FkBank;
    if Assigned(FFkPaymentWay) then
      FkPaymentWay       := TCustomer(Source).FkPaymentWay;
    if Assigned(FFkPriceTable) then
      FkPriceTable       := TCustomer(Source).FkPriceTable;
    if Assigned(FFkTypeBlock) then
      FkTypeBlock        := TCustomer(Source).FkTypeBlock;
    if Assigned(FFkTypeDiscount) then
      FkTypeDiscount     := TCustomer(Source).FkTypeDiscount;
    if Assigned(FFkTypePayment) then
      FkTypePayment      := TCustomer(Source).FkTypePayment;
    if Assigned(FPartners) then
      Partners           := TCustomer(Source).Partners;
    if Assigned(FPersonalData) then
      PersonalData       := TCustomer(Source).PersonalData;
    if Assigned(FReferences) then
      References         := TCustomer(Source).References;
  end
  else
    inherited Assign(Source);
end;

procedure TCustomer.Clear;
begin
  FCodCtb              := 0;
  FDiaEms              := 0;
  FDsctAtc             := 0.0;
  FDsctAut             := 0.0;
  FFkCarrier           := 0;
  FFkAgent             := 0;
  FFkDeliveryPeriod    := 0;
  FFkPortDst           := 0;
  FFkPortEmb           := 0;
  FFkRepresentant      := 0;
  FFkTypeEstablishment := 0;
  FFkVendor            := 0;
  FFkTypeFraction      := 0;
  FFlagCnsm            := False;
  FFlagDtaBas          := bdInvoice;
  FFlagPAbr            := False;
  FFlagPend            := False;
  FFlagDifAcc          := 0;
  FLimCred             := 0.0;
  FTaxAccess           := 0.0;
  FMinAccess           := 0.0;
  FIdxConv             := 0.0;
  FModified            := False;
  FPwdAccess           := '';
  FOpeAut              := '';
  FOpeLib              := '';
  FSitBlockAnt         := 0;
  if Assigned(FCollectionAddress) then
    FCollectionAddress.Clear;
  if Assigned(FDeliveryAddress) then
    FDeliveryAddress.Clear;
  if Assigned(FFkBank) then
    FFkBank.Clear;
  if Assigned(FFkPaymentWay) then
    FFkPaymentWay.Clear;
  if Assigned(FFkPriceTable) then
    FFkPriceTable.Clear;
  if Assigned(FFkTypeBlock) then
    FFkTypeBlock.Clear;
  if Assigned(FFkTypeDiscount) then
    FFkTypeDiscount.Clear;
  if Assigned(FFkTypePayment) then
    FFkTypePayment.Clear;
  if Assigned(FPartners) then
    FPartners.Clear;
  if Assigned(FPersonalData) then
    FPersonalData.Clear;
  if Assigned(FReferences) then
    FReferences.Clear;
end;

function TCustomer.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_CADASTROS');
  Result.Add('FLAG_CNSM');
  Result.Add('FLAG_DTABAS');
  Result.Add('FLAG_FOB_DIRIGIDO');
  Result.Add('FLAG_SAME_REGION');
  Result.Add('TAX_ACCESS');
  Result.Add('MIN_ACCESS');
  Result.Add('FLAG_DIFACC');
  if (FPwdAccess <> '') then
    Result.Add('PWD_ACCESS');
  if (FCodCtb > 0) then
    Result.Add('COD_CTB');
  if (FDiaEms > 0) then
    Result.Add('DIA_EMS');
  if (FDsctAtc > 0) then
    Result.Add('DSCT_ATC');
  if (FDsctAut > 0) then
    Result.Add('DSCT_AUT');
  if (FFkCarrier > 0) then
    Result.Add('FK_VW_TRANSPORTADORAS');
  if (FFkAgent > 0) then
    Result.Add('FK_VW_CADASTROS');
  if (FFkDeliveryPeriod > 0) then
    Result.Add('FK_TIPO_PRAZO_ENTREGA');
  if (FFkPortDst > 0) then
    Result.Add('FK_PORTOS__DST');
  if (FFkPortEmb > 0) then
    Result.Add('FK_PORTOS__EMB');
  if (FFkRepresentant > 0) then
    Result.Add('FK_VW_REPRESENTANTES');
  if (FFkTypeEstablishment > 0) then
    Result.Add('FK_TIPO_ESTABELECIMENTOS');
  if (FFkVendor > 0) then
    Result.Add('FK_VW_VENDEDORES');
  if (FFkTypeFraction > 0) then
    Result.Add('FK_TIPO_TABELA_FRACAO');
  if (FLimCred > 0) then
    Result.Add('LIM_CRD');
  if (FIdxConv > 0) then
    Result.Add('IDX_CONV');
  if (FOpeAut <> '') then
    Result.Add('OPE_AUT');
  if (FOpeLib <> '') then
    Result.Add('OPE_LIB');
  if (FSitBlockAnt > 0) then
    Result.Add('SIT_BLOCK_ANT');
  if Assigned(FFkBank) and (FFkBank.PkBank > 0) then
    Result.Add('FK_BANCOS');
  if Assigned(FFkPaymentWay) and (FFkPaymentWay.PkPaymentWay > 0) then
    Result.Add('FK_FINALIZADORAS');
  if Assigned(FFkPriceTable) and (FFkPriceTable.PkPriceTable > 0) then
    Result.Add('FK_TABELA_PRECOS');
  if Assigned(FFkTypeBlock) and (FFkTypeBlock.PkTypeBlock > 0) then
    Result.Add('FK_TIPO_BLOQUEIOS');
  if Assigned(FFkTypeDiscount) and (FFkTypeDiscount.PkTypeDiscount > 0) then
    Result.Add('FK_TIPO_DESCONTOS');
  if Assigned(FFkTypePayment) and (FFkTypePayment.PkTypePgto > 0) then
    Result.Add('FK_TIPO_PAGAMENTOS');
end;

procedure TCustomer.SetCollectionAddress(AValue: TCollectionAddress);
begin
  if (AValue = nil) then
    FCollectionAddress.Clear
  else
    FCollectionAddress.Assign(AValue);
end;

procedure TCustomer.SetDeliveryAddress(AValue: TDeliveryAddress);
begin
  if (AValue = nil) then
    FDeliveryAddress.Clear
  else
    FDeliveryAddress.Assign(AValue);
end;

procedure TCustomer.SetFkBank(Value: TBank);
begin
  if (not Assigned(FFkBank)) then exit;
  if (Value = nil) then
    FFkBank.Clear
  else
    FFkBank.Assign(Value);
end;

procedure TCustomer.SetFkPaymentWay(Value: TPaymentWay);
begin
  if (not Assigned(FFkPaymentWay)) then exit;
  if (Value = nil) then
    FFkPaymentWay.Clear
  else
    FFkPaymentWay.Assign(Value);
end;

procedure TCustomer.SetFkPriceTable(Value: TPriceTable);
begin
  if (not Assigned(FFkPriceTable)) then exit;
  if (Value = nil) then
    FFkPriceTable.Clear
  else
    FFkPriceTable.Assign(Value);
end;

procedure TCustomer.SetFkTypeBlock(Value: TTypeBlock);
begin
  if (not Assigned(FFkTypeBlock)) then exit;
  if (Value = nil) then
    FFkTypeBlock.Clear
  else
    FFkTypeBlock.Assign(Value);
end;

procedure TCustomer.SetFkTypeDiscount(Value: TTypeDiscount);
begin
  if (not Assigned(FFkTypeDiscount)) then exit;
  if (Value = nil) then
    FFkTypeDiscount.Clear
  else
    FFkTypeDiscount.Assign(Value);
end;

procedure TCustomer.SetFkTypePayment(Value: TTypePayment);
begin
  if (not Assigned(FFkTypePayment)) then exit;
  if (Value = nil) then
    FFkTypePayment.Clear
  else
    FFkTypePayment.Assign(Value);
end;

procedure TCustomer.SetOpeAut(AValue: string);
begin
  FOpeAut := Copy(AValue, 1, 10);
end;

procedure TCustomer.SetOpeLib(AValue: string);
begin
  FOpeLib := Copy(AValue, 1, 10);
end;

procedure TCustomer.SetPartners(Value: TPartners);
begin
  if (not Assigned(FPartners)) then exit;
  if (Value = nil) then
    FPartners.Clear
  else
    FPartners.Assign(Value);
end;

procedure TCustomer.SetPersonalData(Value: TPersonalData);
begin
  if (not Assigned(FPersonalData)) then exit;
  if (Value = nil) then
    FPersonalData.Clear
  else
    FPersonalData.Assign(Value);
end;

procedure TCustomer.SetReferences(Value: TReferences);
begin
  if (not Assigned(FReferences)) then exit;
  if (Value = nil) then
    FReferences.Clear
  else
    FReferences.Assign(Value);
end;

{
************************************ TOwner ************************************
}
constructor TOwner.Create;
begin
  inherited Create;
  FAddress            := TAddress.Create;
  FCategories         := TCategories.Create(Self);
  FCustomer           := TCustomer.Create;
  FEmployee           := TEmployee.Create;
  FObsCad             := TStringList.Create;
  FPhones             := TPhones.Create(Self);
  FSupplier           := TSupplier.Create;
  FOwnerEvents        := TOwnerEvents.Create(Self);
  FInternetAddresses  := TInternetAddresses.Create(Self);
  FValidateCNPJ       := nil;
  FValidateCPF        := nil;
  FValidateIE         := nil;
  Clear;
end;

destructor TOwner.Destroy;
begin
  Clear;
  if Assigned(FAddress) then
    FAddress.Free;
  if Assigned(FCategories) then
    FCategories.Free;
  if Assigned(FEmployee) then
    FEmployee.Free;
  if Assigned(FObsCad) then
    FObsCad.Free;
  if Assigned(FPhones) then
    FPhones.Free;
  if Assigned(FSupplier) then
    FSupplier.Free;
  if Assigned(FOwnerEvents) then
    FOwnerEvents.Free;
  if Assigned(FInternetAddresses) then
    FInternetAddresses.Free;
  if Assigned(FCustomer) then
    FCustomer.Free;
  FCustomer     := nil;
  FInternetAddresses  := nil;
  FOwnerEvents  := nil;
  FSupplier     := nil;
  FPhones       := nil;
  FObsCad       := nil;
  FEmployee     := nil;
  FCategories   := nil;
  FAddress      := nil;
  FValidateCNPJ := nil;
  FValidateCPF  := nil;
  FValidateIE   := nil;
  inherited Destroy;
end;

procedure TOwner.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOwner) then
  begin
    if Assigned(FAddress) then
      Address    := TOwner(Source).Address;
    if Assigned(FCategories) then
      Categories := TOwner(Source).Categories;
    if Assigned(FCustomer) then
      Customer   := TOwner(Source).Customer;
    if Assigned(FEmployee) then
      Employee   := TOwner(Source).Employee;
    if Assigned(FObsCad) then
      ObsCad     := TOwner(Source).ObsCad;
    if Assigned(FPhones) then
      Phones     := TOwner(Source).Phones;
    if Assigned(FSupplier) then
      Supplier   := TOwner(Source).Supplier;
    if Assigned(FOwnerEvents) then
      OwnerEvents := TOwner(Source).OwnerEvents;
    if Assigned(FInternetAddresses) then
      InternetAddresses := TOwner(Source).InternetAddresses;
    FFkAlias     := TOwner(Source).FkAlias;
    AreaAtu      := TOwner(Source).AreaAtu;
    Title        := TOwner(Source).Title;
    FcbIndex     := TOwner(Source).cbIndex;
    DocPri       := TOwner(Source).DocPri;
    DocSec       := TOwner(Source).DocSec;
    eMailCad     := TOwner(Source).eMailCad;
    FFlagEtq     := TOwner(Source).FlagEtq;
    FFlagTCad    := TOwner(Source).FlagTCad;
    HttpCad      := TOwner(Source).HttpCad;
    NomFan       := TOwner(Source).NomFan;
    FPkCadastros := TOwner(Source).PkCadastros;
    RazSoc       := TOwner(Source).RazSoc;
    FFkContacts  := TOwner(Source).FkContacts;
  end
  else
    inherited Assign(Source);
end;

procedure TOwner.Clear;
begin
  if Assigned(FAddress) then
    FAddress.Clear;
  if Assigned(FCategories) then
    FCategories.Clear;
  if Assigned(FCustomer) then
    FCustomer.Clear;
  if Assigned(FEmployee) then
    FEmployee.Clear;
  if Assigned(FObsCad) then
    FObsCad.Clear;
  if Assigned(FPhones) then
    FPhones.Clear;
  if Assigned(FSupplier) then
    FSupplier.Clear;
  if Assigned(FOwnerEvents) then
    FOwnerEvents.Clear;
  if Assigned(FInternetAddresses) then
    FInternetAddresses.Clear;
  FFkAlias     := 0;
  FAreaAtu     := '';
  FTitle       := '';
  FcbIndex     := 0;
  FDocPri      := '';
  FDocSec      := '';
  FeMailCad    := '';
  FFlagEtq     := True;
  FFlagTCad    := toCompany;
  FHttpCad     := '';
  FNomFan      := '';
  FPkCadastros := 0;
  FRazSoc      := '';
  FFkContacts  := 0;
end;

function TOwner.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkCadastros) then
    Result := FcbIndex;
end;

function TOwner.GetCategory(ACategory: TCategoryType): Boolean;
var
  i: Integer;
begin
  Result := False;
  if (FCategories = nil) or (FCategories.Count = 0) then exit;
  for i := 0 to FCategories.Count - 1 do
    if FCategories.Items[i].FlagCat = ACategory then
      Result := True;
end;

function TOwner.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('PK_CADASTROS');
  Result.Add('FLAG_TCAD');
  Result.Add('RAZ_SOC');
  Result.Add('NUM_END');
  Result.Add('CEP_CAD');
  Result.Add('FLAG_ETQ');
  Result.Add('FLAG_ZUMBI');
  if (FDocPri <> '') then
    Result.Add('DOC_PRI');
  if (FDocSec <> '') then
    Result.Add('DOC_SEQ');
  if (FFkAlias > 0) then
    Result.Add('FK_TIPO_ALIAS');
  if (FAddress.FkCity.FkState.FkCountry.PkCountry > 0) then
    Result.Add('FK_PAISES');
  if (FAddress.FkCity.FkState.PkState <> '') then
    Result.Add('FK_ESTADOS');
  if (FAddress.FkCity.PkCity > 0) then
    Result.Add('FK_MUNICIPIOS');
  if (FAddress.EndAdd <> '') then
    Result.Add('END_CAD');
  if (FAddress.CmpEnd <> '') then
    Result.Add('CMP_END');
  if (FAddress.CxpAdd <> '') then
    Result.Add('CXP_CAD');
  if (FAreaAtu <> '') then
    Result.Add('AREA_ATU');
  if (FTitle <> '') then
    Result.Add('TRT_CNT');
  if (FkContacts > 0) then
    Result.Add('FK_CONTATOS');
end;

function TOwner.GetFlagZumbi: Boolean;
begin
  Result := (Categories.Count = 0);
end;

function TOwner.GetPkValue: Variant;
begin
  Result := FPkCadastros;
end;

function TOwner.GetSearchSQL(AFieldOrder: string = 'Cad.RAZ_SOC'): TStrings;
var
  s: string;
  i: Integer;
  
  const
    S_WHERE_SQL = ' where ';
    S_AND       = '   and ';
    S_ON        = '    on ';
    SQ          = '''';
    S_LIKE      = ' like ';
    S_EQUAL     = ' = ';
    S_GREATER   = ' > ';
    S_GRT_EQ    = ' >= ';
    S_LESS      = ' < ';
    S_LESS_EQ   = ' <= ';
    S_FMT_LIKE  = ' like ''%s%s%s'' ';
    S_ALL       = '%';
  function GetWhereInstruction(const ASql, AField, AOperation, AValue: string): string;
  begin
    if Pos(S_WHERE_SQL, ASql) <= 0 then
      Result := S_WHERE_SQL + AField + AOperation + AValue
    else
      Result := S_AND + AField + AOperation + AValue
  end;
  
begin
  Result := TStringList.Create;
  Result.Add('select Cad.PK_CADASTROS, Cad.RAZ_SOC, Tal.DSC_ALIAS, ');
  Result.Add('       Cad.DOC_PRI, Cat.FLAG_CAT, Cat.DSC_CAT');
  Result.Add('  from CADASTROS Cad');
  Result.Add('  left outer join TIPO_ALIAS Tal');
  Result.Add('    on Tal.PK_TIPO_ALIAS = Cad.FK_TIPO_ALIAS');
  Result.Add('  left outer join VINCULOS_CAD_CAT Vin ');
  Result.Add('    on Vin.FK_CADASTROS  = Cad.PK_CADASTROS ');
  if (Categories.Count > 0) then
  begin
    s := '';
    for i := 0 to Categories.Count - 1 do
      if (i = (Categories.Count - 1)) then
        s := s + IntToStr(Categories.Items[i].PkCategory)
      else
        s := s + IntToStr(Categories.Items[i].PkCategory) + ', ';
    Result.Add(Format('   and Vin.FK_CATEGORIAS in (%s)', [s]));
  end;
  Result.Add('  left outer join CATEGORIAS Cat ');
  Result.Add('    on Cat.PK_CATEGORIAS = Vin.FK_CATEGORIAS');
  if (FPkCadastros > 0) then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.PK_CADASTROS', S_EQUAL,
      IntToStr(FPkCadastros)));
  if (FFlagTCad < toForeigner) then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.FLAG_TCAD', S_EQUAL,
      IntToStr(Ord(FlagTCad))));
  if (FRazSoc <> '') then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.RAZ_SOC', '',
      Format(S_FMT_LIKE, [S_ALL, FRazSoc, S_ALL])));
  if (FAddress.NumAdd > 0) then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.NUM_END', S_EQUAL,
      IntToStr(FAddress.NumAdd)));
  if (FAddress.CepAdd > 0) then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.CEP_CAD', S_EQUAL,
      IntToStr(FAddress.CepAdd)));
  if (FDocPri <> '') then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.DOC_PRI', '',
      Format(S_FMT_LIKE, [S_ALL, FDocPri, S_ALL])));
  if (FDocSec <> '') then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.DOC_SEQ', '',
      Format(S_FMT_LIKE, [S_ALL, FDocSec, S_ALL])));
  if (FFkAlias > 0) then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.FK_TIPO_ALIAS', S_EQUAL,
      IntToStr(FFkAlias)));
  if (FAddress.FkCity.FkState.FkCountry.PkCountry > 0) then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.FK_PAISES', S_EQUAL,
      IntToStr(FAddress.FkCity.FkState.FkCountry.PkCountry)));
  if (FAddress.FkCity.FkState.PkState <> '') then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.FK_ESTADOS', S_EQUAL,
      SQ + FAddress.FkCity.FkState.PkState + SQ));
  if (FAddress.FkCity.PkCity > 0) then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.FK_MUNICIPIOS', S_EQUAL,
      IntToStr(FAddress.FkCity.PkCity)));
  if (FAddress.EndAdd <> '') then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.END_CAD', '',
      Format(S_FMT_LIKE, [S_ALL, FAddress.EndAdd, S_ALL])));
  if (FAddress.CmpEnd <> '') then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.CMP_END', '',
      Format(S_FMT_LIKE, [S_ALL, FAddress.CmpEnd, S_ALL])));
  if (FAddress.CxpAdd <> '') then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.CXP_CAD', '',
      Format(S_FMT_LIKE, [S_ALL, FAddress.CxpAdd, S_ALL])));
  if (FAreaAtu <> '') then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.AREA_ATU', '',
      Format(S_FMT_LIKE, [S_ALL, FAreaAtu, S_ALL])));
  if (FTitle <> '') then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.TRT_CNT', '',
      Format(S_FMT_LIKE, [S_ALL, FTitle, S_ALL])));
  if (FFkContacts > 0) then
    Result.Add(GetWhereInstruction(Result.Text, 'Cad.FK_CONTATOS', S_EQUAL,
      IntToStr(FFkContacts)));
  Result.Add('order by ' + AFieldOrder);
end;

procedure TOwner.SetAddress(AValue: TAddress);
begin
  if (AValue = nil) then
    FAddress.Clear
  else
    FAddress.Assign(AValue);
end;

procedure TOwner.SetAreaAtu(AValue: string);
begin
  FAreaAtu := Copy(AValue, 1, 50);
end;

procedure TOwner.SetCategories(AValue: TCategories);
begin
  if (AValue = nil) then
    FCategories.Clear
  else
    FCategories.Assign(AValue);
end;

procedure TOwner.SetCustomer(AValue: TCustomer);
begin
  if (FCustomer = nil) then exit;
  FCustomer.Clear;
  if (AValue <> nil) then
    FCustomer.Assign(AValue);
end;

procedure TOwner.SetDocPri(AValue: string);
var
  aValidate: Boolean;
begin
  aValidate := True;
  if (AValue <> '') and (FlagTCad in [toCompany, toPeople]) then
  begin
    case FlagTCad of
      toCompany: if (Assigned(FValidateCNPJ)) then FValidateCNPJ(Self, AValue, aValidate);
      toPeople : if (Assigned(FValidateCPF))  then FValidateCPF(Self, AValue, aValidate);
    end;
  end;
  if (aValidate) then
    FDocPri := Copy(AValue, 1, 14)
  else
    raise Exception.Create('Error: Field Primary Document is Invalid');
end;

procedure TOwner.SetDocSec(AValue: string);
var
  aValidate: Boolean;
begin
  aValidate := True;
  if Assigned(FValidateIE) then
    FValidateIE(Self, AValue, aValidate);
  if (aValidate) then
    FDocSec := Copy(AValue, 1, 14)
  else
    raise Exception.Create('Error: Field Secondary Document is Invalid');
end;

procedure TOwner.SeteMailCad(const AValue: string);
begin
  FeMailCad := Copy(AValue, 1, 50);
end;

procedure TOwner.SetEmployee(AValue: TEmployee);
begin
  if (AValue <> nil) then
    FEmployee.Clear
  else
    FEmployee.Assign(AValue);
end;

procedure TOwner.SetHttpCad(const AValue: string);
begin
  FHttpCad := Copy(AValue, 1, 50);
end;

procedure TOwner.SetInternetAddresses(AValue: TInternetAddresses);
begin
  if (AValue = nil) then
    FInternetAddresses.Clear
  else
    FInternetAddresses.Assign(AValue);
end;

procedure TOwner.SetNomFan(const AValue: string);
begin
  FNomFan := Copy(AValue, 1, 50);
end;

procedure TOwner.SetObsCad(AValue: TStrings);
begin
  if (AValue = nil) then
    FObsCad.Clear
  else
    FObsCad.Assign(AValue);
end;

procedure TOwner.SetOwnerEvents(AValue: TOwnerEvents);
begin
  if (AValue = nil) then
    FOwnerEvents.Clear
  else
    FOwnerEvents.Assign(AValue);
end;

procedure TOwner.SetPhones(AValue: TPhones);
begin
  if (AValue = nil) then
    FPhones.Clear
  else
    FPhones.Assign(AValue);
end;

procedure TOwner.SetRazSoc(AValue: string);
begin
  FRazSoc := Copy(AValue, 1, 50);
end;

procedure TOwner.SetSupplier(AValue: TSupplier);
begin
  if (AValue = nil) then
    FSupplier.Clear
  else
    FSupplier.Assign(AValue);
end;

procedure TOwner.SetTitle(AValue: string);
begin
  FTitle := Copy(AValue, 1, 50);
end;


end.
