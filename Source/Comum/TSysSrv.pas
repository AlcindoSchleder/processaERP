unit TSysSrv;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 09/12/2004 - DD/MM/YYYY                                    *}
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
  SysUtils, Classes, TSysPedAux, TSysFatAux, TSysEstq, TSysCad, TSysMan, 
  ProcType, ProcUtils, TSysSrvAux, TSysEstqAux, PrcSysTypes, Funcoes,
    {$IFDEF LINUX} QControls {$ENDIF}
    {$IFDEF WIN32} Controls {$ENDIF};

type

  TEntryData         = (edService, edActivity);
  
  TDirectionScroll   = (dsPrior, dsNext);
  
//  0 ==> Medições (topografia)
//  1 ==> Oficina Mecânica
//  2 ==> Contrução Civil
//  3 ==> Tecnologia (Informática)
  TTypeUse           = (tuMetric, tuFix, tuBuild, tuTecnology, tuNone);
  
  TEntryLocation     = (elHeader, elItems);
  
  TTypeES            = (esEntrada, esSaida, esBoth);
      
  TTypeStt           = (stOpened, stParcialFinished, stFinished,
                        stCanceled, stBlocked, stApproved, stNone);
  
  THistoricType      = (htNone, htAutorization, htStatus);
  
  TValueType         = (vtNone, vtQtd, vtUnit, vtAlt, vtComp, vtLarg);
  
  TFlagQtd           = set of (fqQtd, fqComp, fqLarg, fqAlt); 
  
  TCheckErrorType    = (ceNullDtaOS, ceNullDtaIni, ceNullDtaFin, ceNullOwner,
                        ceNullCompany, ceNullPayment, ceNullStatus, ceNullDtaLiq, 
                        ceNullDtaCanc, ceNullDtaBlq, ceNullDtaApproved, ceAuthDenied,
                        ceNullTypeServiceOrder, ceNullPkOS, ceNullItems,
                        ceStatusError, ceNullTotal);
  TCheckErrors       =  set of TCheckErrorType;
  
  TInsumo            = class;
  
  TChangeValuesEvent = procedure (Sender: TObject; const AValueType: TValueType;
          const AValue: Double) of object;
  TInsumo = class (TCollectionItem)
  private
    FAltIns: Double;
    FcbIndex: Integer;
    FCfcConv: Double;
    FCodIns: string;
    FCompIns: Double;
    FDscIns: string;
    FFKProduct: Integer;
    FFlagDBQtd: Byte;
    FFlagDef: Boolean;
    FFlagFrn: Boolean;
    FFlagTIns: TTypeInsumos;
    FFlagTQtd: TFlagQtd;
    FLargIns: Double;
    FNode: Pointer;
    FOnChangeValues: TChangeValuesEvent;
    FQtdIns: Double;
    FSeqIns: Integer;
    FTotIns: Double;
    FVlrUnit: Double;
    procedure CalcQtd;
    function GetTotIns: Double;
    procedure SetAltIns(AValue: Double);
    procedure SetCodIns(const AValue: string);
    procedure SetCompIns(AValue: Double);
    procedure SetFlagDBQtd(AValue: Byte);
    procedure SetFlagTQtd(AValue: TFlagQtd);
    procedure SetLargIns(AValue: Double);
    procedure SetQtdIns(AValue: Double);
    procedure SetVlrUnit(AValue: Double);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property AltIns: Double read FAltIns write SetAltIns;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property CfcConv: Double read FCfcConv write FCfcConv;
    property CodIns: string read FCodIns write SetCodIns;
    property CompIns: Double read FCompIns write SetCompIns;
    property DisplayName;
    property DscIns: string read FDscIns write FDscIns;
    property FKProduct: Integer read FFKProduct write FFKProduct;
    property FlagDBQtd: Byte read FFlagDBQtd write SetFlagDBQtd;
    property FlagDef: Boolean read FFlagDef write FFlagDef;
    property FlagFrn: Boolean read FFlagFrn write FFlagFrn default True;
    property FlagTIns: TTypeInsumos read FFlagTIns write FFlagTIns default 
            tiService;
    property FlagTQtd: TFlagQtd read FFlagTQtd write SetFlagTQtd;
    property Index;
    property LargIns: Double read FLargIns write SetLargIns;
    property Node: Pointer read FNode write FNode;
    property OnChangeValues: TChangeValuesEvent read FOnChangeValues write 
            FOnChangeValues;
    property QtdIns: Double read FQtdIns write SetQtdIns;
    property SeqIns: Integer read FSeqIns write FSeqIns;
    property TotIns: Double read GetTotIns;
    property VlrUnit: Double read FVlrUnit write SetVlrUnit;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TInsumos = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TInsumo;
    procedure SetItems(Index: Integer; AValue: TInsumo);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TInsumo;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TInsumo;
    property Count;
    property Items[Index: Integer]: TInsumo read GetItems write SetItems;
  end;
  
  TInsumoEvent = procedure (Sender: TObject; AInsumo: TInsumo) of object;
  TTypeServiceOrder = class (TPersistent)
  private
    FDscTOS: string;
    FFkGruposMovimentos: Integer;
    FFkTipoDocumentos: Integer;
    FFkTipoMovimentos: Integer;
    FFlagCns: Boolean;
    FFlagCod: TCodeTypes;
    FFlagES: TTypeES;
    FFlagGFin: Boolean;
    FFlagLdv: Boolean;
    FFlagTOS: TTypeUse;
    FIndex: Integer;
    FPkTipoOrdensServicos: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DscTOS: string read FDscTOS write FDscTOS;
    property FkGruposMovimentos: Integer read FFkGruposMovimentos write 
            FFkGruposMovimentos;
    property FkTipoDocumentos: Integer read FFkTipoDocumentos write 
            FFkTipoDocumentos;
    property FkTipoMovimentos: Integer read FFkTipoMovimentos write 
            FFkTipoMovimentos;
    property FlagCns: Boolean read FFlagCns write FFlagCns;
    property FlagCod: TCodeTypes read FFlagCod write FFlagCod default 
            pcReference;
    property FlagES: TTypeES read FFlagES write FFlagES default esEntrada;
    property FlagGFin: Boolean read FFlagGFin write FFlagGFin;
    property FlagLdv: Boolean read FFlagLdv write FFlagLdv;
    property FlagTOS: TTypeUse read FFlagTOS write FFlagTOS;
    property Index: Integer read FIndex write FIndex;
    property PkTipoOrdensServicos: Integer read FPkTipoOrdensServicos write 
            FPkTipoOrdensServicos default 0;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TScrollOrderService = procedure (Sender: TObject; var APkOS: Integer; const 
          ADirection: TDirectionScroll; var AEnabled: Boolean) of object;

  THistoric          = class;
  TServiceOrder      = class;
  TServiceOrderItem  = class;
  TServiceOrderItems = class;
  
  TOnCheckError = procedure (Sender: TObject; AError: TCheckErrorType; var 
          AMsg: string) of object;
  THistoricEvent = procedure (Sender: THistoric; AType: THistoricType; var 
          ADscHist: string) of object;
  TStatusOS = class (TPersistent)
  private
    FDscStt: string;
    FFlagAut: Integer;
    FFlagStt: TTypeStt;
    FIndex: Integer;
    FPkStatusOS: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DscStt: string read FDscStt write FDscStt;
    property FlagAut: Integer read FFlagAut write FFlagAut;
    property FlagStt: TTypeStt read FFlagStt write FFlagStt default stOpened;
    property Index: Integer read FIndex write FIndex;
    property PkStatusOS: Integer read FPkStatusOS write FPkStatusOS default 0;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  THistoric = class (TCollectionItem)
  private
    FCodAut: Integer;
    FDscCad: string;
    FDscHist: string;
    FDtHrHist: TDateTime;
    FFkStatusOS: TStatusOS;
    FHistoricType: THistoricType;
    FNode: Pointer;
    FSeqIns: Integer;
    FServiceItem: Integer;
    procedure SetDscHist(AValue: string);
    procedure SetFkStatusOS(Value: TStatusOS);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property CodAut: Integer read FCodAut write FCodAut;
    property DscCad: string read FDscCad write FDscCad;
    property DscHist: string read FDscHist write SetDscHist;
    property DtHrHist: TDateTime read FDtHrHist write FDtHrHist;
    property FkStatusOS: TStatusOS read FFkStatusOS write SetFkStatusOS;
    property HistoricType: THistoricType read FHistoricType write FHistoricType;
    property Index;
    property Node: Pointer read FNode write FNode;
    property SeqIns: Integer read FSeqIns write FSeqIns;
    property ServiceItem: Integer read FServiceItem write FServiceItem;
  end;
  
  THistorics = class (TCollection)
  private
    FServiceOrder: TServiceOrder;
    function GetItems(Index: Integer): THistoric;
    procedure SetItems(Index: Integer; Value: THistoric);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ServiceOrder: TServiceOrder);
    destructor Destroy; override;
    function Add: THistoric;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate; override;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure EndUpdate; override;
    function Insert(Index: Integer): THistoric;
    property Count;
    property Items[Index: Integer]: THistoric read GetItems write SetItems;
  end;
  

  TServiceOrderItemClass  = class of TServiceOrderItem;
  THistoricClass          = class of THistoric;

  TAutorizationEvent = procedure (Sender: TObject; const AStatus: TStatusOS; 
          var ACodAut: Integer) of object;
  TServiceOrder = class (TComponent)
  private
    FActiveItem: Integer;
    FCodAut: Integer;
    FDscOrd: string;
    FDtaAprv: TDate;
    FDtaBlq: TDate;
    FDtaCanc: TDate;
    FDtaFin: TDate;
    FDtaIni: TDate;
    FDtaLibFin: TDate;
    FDtaLiq: TDate;
    FDtaOS: TDate;
    FFkCadastros: TOwner;
    FFkEmpresas: TCompany;
    FFkPayment: TTypePayment;
    FFkRodovias: TRodovias;
    FFkStatusOS: TStatusOS;
    FFkTypeServiceOrder: TTypeServiceOrder;
    FHistorics: THistorics;
    FOnAutorization: TAutorizationEvent;
    FOnChangeAuth: TOnVerifyIDEvent;
    FOnChangeFkCadastros: TOnVerifyIDEvent;
    FOnChangeFkEmpresas: TOnVerifyIDEvent;
    FOnChangeFkPayment: TOnVerifyIDEvent;
    FOnChangeFkTypeOS: TOnVerifyIDEvent;
    FOnChangeRodovias: TOnVerifyIDEvent;
    FOnChangeStatus: TOnVerifyIDEvent;
    FOnCheckError: TOnCheckError;
    FPkOS: Integer;
    FServiceOrderItems: TServiceOrderItems;
    FStateSO: TdbMode;
    FSubTot: Double;
    FTotOS: Double;
    FVlrAcrDsct: Double;
    procedure SetActiveItem(Value: Integer);
    procedure SetCodAut(Value: Integer);
    procedure SetDtaFin(AValue: TDate);
    procedure SetDtaIni(AValue: TDate);
    procedure SetFkCadastros(AValue: TOwner);
    procedure SetFkEmpresas(AValue: TCompany);
    procedure SetFkPayment(AValue: TTypePayment);
    procedure SetFkRodovias(AValue: TRodovias);
    procedure SetFkStatusOS(AValue: TStatusOS);
    procedure SetFkTypeServiceOrder(AValue: TTypeServiceOrder);
    procedure SetHistorics(AValue: THistorics);
    procedure SetServiceOrderItems(AValue: TServiceOrderItems);
    procedure SetVlrAcrDsct(Value: Double);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure CalcOrder;
    function CheckRules(CheckPk: Boolean): Boolean; dynamic;
    function CheckStatus: TCheckErrors; dynamic;
    procedure Clear;
    function GetFields: TStrings;
    function GetHistoricClass: THistoricClass;
    function GetServiceOrderItemClass: TServiceOrderItemClass;
    property ActiveItem: Integer read FActiveItem write SetActiveItem;
    property CodAut: Integer read FCodAut write SetCodAut;
    property DscOrd: string read FDscOrd write FDscOrd;
    property DtaAprv: TDate read FDtaAprv write FDtaAprv;
    property DtaBlq: TDate read FDtaBlq write FDtaBlq;
    property DtaCanc: TDate read FDtaCanc write FDtaCanc;
    property DtaFin: TDate read FDtaFin write SetDtaFin;
    property DtaIni: TDate read FDtaIni write SetDtaIni;
    property DtaLibFin: TDate read FDtaLibFin write FDtaLibFin;
    property DtaLiq: TDate read FDtaLiq write FDtaLiq;
    property DtaOS: TDate read FDtaOS write FDtaOS;
    property FkCadastros: TOwner read FFkCadastros write SetFkCadastros;
    property FkEmpresas: TCompany read FFkEmpresas write SetFkEmpresas;
    property FkPayment: TTypePayment read FFkPayment write SetFkPayment;
    property FkRodovias: TRodovias read FFkRodovias write SetFkRodovias;
    property FkStatusOS: TStatusOS read FFkStatusOS write SetFkStatusOS;
    property FkTypeServiceOrder: TTypeServiceOrder read FFkTypeServiceOrder 
            write SetFkTypeServiceOrder;
    property Historics: THistorics read FHistorics write SetHistorics;
    property OnAutorization: TAutorizationEvent read FOnAutorization write 
            FOnAutorization;
    property OnChangeAuth: TOnVerifyIDEvent read FOnChangeAuth write 
            FOnChangeAuth;
    property OnChangeFkCadastros: TOnVerifyIDEvent read FOnChangeFkCadastros 
            write FOnChangeFkCadastros;
    property OnChangeFkEmpresas: TOnVerifyIDEvent read FOnChangeFkEmpresas 
            write FOnChangeFkEmpresas;
    property OnChangeFkPayment: TOnVerifyIDEvent read FOnChangeFkPayment write 
            FOnChangeFkPayment;
    property OnChangeFkTypeOS: TOnVerifyIDEvent read FOnChangeFkTypeOS write 
            FOnChangeFkTypeOS;
    property OnChangeRodovias: TOnVerifyIDEvent read FOnChangeRodovias write 
            FOnChangeRodovias;
    property OnChangeStatus: TOnVerifyIDEvent read FOnChangeStatus write 
            FOnChangeStatus;
    property OnCheckError: TOnCheckError read FOnCheckError write FOnCheckError;
    property PkOS: Integer read FPkOS write FPkOS;
    property ServiceOrderItems: TServiceOrderItems read FServiceOrderItems 
            write SetServiceOrderItems;
    property StateSO: TdbMode read FStateSO write FStateSO default dbmBrowse;
    property SubTot: Double read FSubTot write FSubTot;
    property TotOS: Double read FTotOS write FTotOS;
    property VlrAcrDsct: Double read FVlrAcrDsct write SetVlrAcrDsct;
  end;
  
  TServiceOrderItems = class (TCollection)
  private
    FDscTComp: string;
    FServiceOrder: TServiceOrder;
    function GetItems(Index: Integer): TServiceOrderItem;
    procedure SetItems(Index: Integer; Value: TServiceOrderItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ServiceOrder: TServiceOrder);
    destructor Destroy; override;
    function Add: TServiceOrderItem;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate; override;
    procedure Delete(Index: Integer);
    procedure EndUpdate; override;
    function Insert(Index: Integer): TServiceOrderItem;
    function Owner: TPersistent;
    property Count;
    property DscTComp: string read FDscTComp write FDscTComp;
    property Items[Index: Integer]: TServiceOrderItem read GetItems write 
            SetItems;
  end;
  
  TServiceOrderItem = class (TCollectionItem)
  private
    FActiveInsumo: Integer;
    FAltSrv: Double;
    FCodRef: string;
    FCompSrv: Double;
    FDscTComp: string;
    FDtaFat: TDate;
    FFkClassification: Integer;
    FFkInsumos: TInsumos;
    FFkMetricItem: TMetricItem;
    FFlagCalcVlrIns: Boolean;
    FFlagDBQtd: Integer;
    FFlagPers: Boolean;
    FFlagTQtd: TFlagQtd;
    FItemIsVisible: Boolean;
    FLargSrv: Double;
    FNode: Pointer;
    FOnChangeService: TInsumoEvent;
    FOnChangeValues: TChangeValuesEvent;
    FOnInvoice: TNotifyEvent;
    FPkProduct: Integer;
    FQtdSrv: Double;
    FTotSrv: Double;
    FValueType: TValueType;
    FVlrUnit: Double;
    function CalcQtd: Double;
    procedure SetActiveInsumo(AValue: Integer);
    procedure SetAltSrv(AValue: Double);
    procedure SetCodRef(AValue: string);
    procedure SetCompSrv(AValue: Double);
    procedure SetDtaFat(Value: TDate);
    procedure SetFkInsumos(AValue: TInsumos);
    procedure SetFkMetricItem(AValue: TMetricItem);
    procedure SetFlagDBQtd(AValue: Integer);
    procedure SetFlagTQtd(AValue: TFlagQtd);
    procedure SetLargSrv(AValue: Double);
    procedure SetQtdSrv(AValue: Double);
    procedure SetVlrUnit(Value: Double);
    procedure ValidateMark(Sender: TObject; const Mark: TMarkType; var Value: 
            Double; const MarkIni, MarkFin: Double);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure CalcVlrUnitFromIns;
    procedure CheckRules;
    procedure Clear;
    property ActiveInsumo: Integer read FActiveInsumo write SetActiveInsumo;
    property AltSrv: Double read FAltSrv write SetAltSrv;
    property CodRef: string read FCodRef write SetCodRef;
    property CompSrv: Double read FCompSrv write SetCompSrv;
    property DscTComp: string read FDscTComp write FDscTComp;
    property DtaFat: TDate read FDtaFat write SetDtaFat;
    property FkClassification: Integer read FFkClassification write 
            FFkClassification;
    property FkInsumos: TInsumos read FFkInsumos write SetFkInsumos;
    property FkMetricItem: TMetricItem read FFkMetricItem write SetFkMetricItem;
    property FlagCalcVlrIns: Boolean read FFlagCalcVlrIns write FFlagCalcVlrIns 
            default False;
    property FlagDBQtd: Integer read FFlagDBQtd write SetFlagDBQtd;
    property FlagPers: Boolean read FFlagPers write FFlagPers;
    property FlagTQtd: TFlagQtd read FFlagTQtd write SetFlagTQtd;
    property Index;
    property ItemIsVisible: Boolean read FItemIsVisible write FItemIsVisible;
    property LargSrv: Double read FLargSrv write SetLargSrv;
    property Node: Pointer read FNode write FNode;
    property OnChangeService: TInsumoEvent read FOnChangeService write 
            FOnChangeService;
    property OnChangeValues: TChangeValuesEvent read FOnChangeValues write 
            FOnChangeValues;
    property OnInvoice: TNotifyEvent read FOnInvoice write FOnInvoice;
    property PkProduct: Integer read FPkProduct write FPkProduct;
    property QtdSrv: Double read FQtdSrv write SetQtdSrv;
    property TotSrv: Double read FTotSrv;
    property ValueType: TValueType read FValueType write FValueType;
    property VlrUnit: Double read FVlrUnit write SetVlrUnit;
  end;
  

implementation

const
  Msg: array [ceNullDtaOS..ceNullTotal] of string =
    ('Check Error: Missing Date of the Service Order',
     'Check Error: Invalid Intial Date of the Service Order',
     'Check Error: Invalid Final Date of the Service Order',
     'Check Error: Missing Owner of the Service Order',
     'Check Error: Missing Company',
     'Check Error: Missing Payment Condition',
     'Check Error: Missing Status of the Service Order',
     'Check Error: Missing Service Order Finish Date',
     'Check Error: Missing Service Order Cancel Date',
     'Check Error: Missing Service Order Block Date',
     'Check Error: Missing Service Order Approv Date',
     'Check Error: Autorization Denied for this Status',
     'Check Error: Missing Type of the Service Order',
     'Check Error: Missing Service Order Number',
     'Check Error: Service Order must to have a item',
     'Check Error: I Can not to use the status choosed in this Service Order',
     'Check Error: Total of the Service Order does not to be zero');

{
****************************** TTypeServiceOrder *******************************
}
constructor TTypeServiceOrder.Create;
begin
  inherited Create;
  Clear;
end;

destructor TTypeServiceOrder.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TTypeServiceOrder.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TTypeServiceOrder) then
  begin
    FDscTOS               := TTypeServiceOrder(Source).DscTOS;
    FFkGruposMovimentos   := TTypeServiceOrder(Source).FkGruposMovimentos;
    FFkTipoDocumentos     := TTypeServiceOrder(Source).FkTipoDocumentos;
    FFkTipoMovimentos     := TTypeServiceOrder(Source).FkTipoMovimentos;
    FlagCns               := TTypeServiceOrder(Source).FlagCns;
    FFlagCod              := TTypeServiceOrder(Source).FlagCod;
    FFlagES               := TTypeServiceOrder(Source).FlagES;
    FlagGFin              := TTypeServiceOrder(Source).FlagGFin;
    FlagLdv               := TTypeServiceOrder(Source).FlagLdv;
    FFlagTOS              := TTypeServiceOrder(Source).FlagTOS;
    FPkTipoOrdensServicos := TTypeServiceOrder(Source).PkTipoOrdensServicos;
  end
  else
    inherited Assign(Source);
end;

procedure TTypeServiceOrder.Clear;
begin
  FDscTOS               := '';
  FFkGruposMovimentos   := 0;
  FFkTipoDocumentos     := 0;
  FFkTipoMovimentos     := 0;
  FlagCns               := False;
  FFlagCod              := pcReference;
  FFlagES               := esEntrada;
  FlagGFin              := False;
  FlagLdv               := False;
  FFlagTOS              := tuFix;
  FPkTipoOrdensServicos := 0;
end;

function TTypeServiceOrder.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkTipoOrdensServicos) then
    Result := FIndex;
end;

function TTypeServiceOrder.GetPkValue: Variant;
begin
  Result := FPkTipoOrdensServicos;
end;

{
********************************** TStatusOS ***********************************
}
constructor TStatusOS.Create;
begin
  inherited Create;
  Clear;
end;

destructor TStatusOS.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TStatusOS.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TStatusOS) then
  begin
    FDscStt     := TStatusOS(Source).DscStt;
    FFlagAut    := TStatusOS(Source).FlagAut;
    FFlagStt    := TStatusOS(Source).FlagStt;
    FPkStatusOS := TStatusOS(Source).PkStatusOS;
  end
  else
    inherited Assign(Source);
end;

procedure TStatusOS.Clear;
begin
  FDscStt     := '';
  FFlagStt    := stNone;
  FFlagAut    := 0;
  FIndex      := 0;
  FPkStatusOS := 0;
end;

function TStatusOS.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkStatusOS) then
    Result := FIndex;
end;

function TStatusOS.GetPkValue: Variant;
begin
  Result := FPkStatusOS;
end;

{
********************************** THistoric ***********************************
}
constructor THistoric.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFkStatusOS := TStatusOS.Create;
  if (Collection       <> nil) and (Collection       is THistorics)    and
     (Collection.Owner <> nil) and (Collection.Owner is TServiceOrder) and
     (TServiceOrder(Collection.Owner) <> nil) and
     (TServiceOrder(Collection.Owner).FkStatusOS <> nil)  then
    FkStatusOS := TServiceOrder(Collection.Owner).FkStatusOS;
  Clear;
end;

destructor THistoric.Destroy;
begin
  FFkStatusOS.Free;
  FFkStatusOS := nil;
  Clear;
  inherited Destroy;
end;

procedure THistoric.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is THistoric) then
  begin
    FCodAut       := THistoric(Source).CodAut;
    FDscCad       := THistoric(Source).DscCad;
    FDscHist      := THistoric(Source).DscHist;
    FDtHrHist     := THistoric(Source).DtHrHist;
    FkStatusOS    := THistoric(Source).FkStatusOS;
    FHistoricType := THistoric(Source).HistoricType;
    FServiceItem  := THistoric(Source).ServiceItem;
    FSeqIns       := THistoric(Source).SeqIns;
    FNode         := THistoric(Source).Node;
  end
  else
    inherited Assign(Source);
end;

procedure THistoric.Clear;
begin
  FCodAut      := 0;
  FDscCad      := '';
  FDscHist     := '';
  FDtHrHist    := Now;
  Node         := nil;
  FServiceItem := 0;
  FSeqIns      := 0;
  if Assigned(FFKStatusOS) then
    FFKStatusOS.Clear;
  FHistoricType := htNone;
end;

function THistoric.GetDisplayName: string;
begin
  if FDtHrHist > 0 then
    Result := DateTimeToStr(FDtHrHist) + '_' + DscHist
  else
    Result := DscHist;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure THistoric.SetDscHist(AValue: string);
begin
  FDscHist := Copy(AValue, 1, 30);
end;

procedure THistoric.SetFkStatusOS(Value: TStatusOS);
begin
  if Value <> nil then
    FFKStatusOS.Assign(Value)
  else
    FFkStatusOS.Clear;
end;

{
********************************** THistorics **********************************
}
constructor THistorics.Create(ServiceOrder: TServiceOrder);
begin
  if ServiceOrder = nil then
    inherited Create(THistoric)
  else
    inherited Create(ServiceOrder.GetHistoricClass);
  FServiceOrder := ServiceOrder;
end;

destructor THistorics.Destroy;
begin
  FServiceOrder := nil;
  inherited Destroy;
end;

function THistorics.Add: THistoric;
begin
  Result := THistoric(inherited Add);
end;

procedure THistorics.Assign(Source: TPersistent);
var
  aIdx: Integer;
  aItem: THistoric;
begin
  if (Source <> nil) and (Source is THistorics) then
  begin
    Clear;
    for aIdx := 0 to THistorics(Source).Count - 1 do
    begin
      aItem := Self.Add;
      aItem.Assign(THistorics(Source).Items[aIdx]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure THistorics.BeginUpdate;
begin
  inherited BeginUpdate;
end;

procedure THistorics.Clear;
begin
  inherited Clear;
end;

procedure THistorics.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

procedure THistorics.EndUpdate;
begin
  inherited EndUpdate;
end;

function THistorics.GetItems(Index: Integer): THistoric;
begin
  Result := inherited Items[Index] as THistoric;
end;

function THistorics.GetOwner: TPersistent;
begin
  Result := FServiceOrder;
  if Result = nil then Result := inherited GetOwner;
end;

function THistorics.Insert(Index: Integer): THistoric;
begin
  Result := THistoric(inherited Insert(Index));
end;

procedure THistorics.SetItems(Index: Integer; Value: THistoric);
begin
  inherited Items[Index] := Value;
end;

{
*********************************** TInsumo ************************************
}
constructor TInsumo.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
  OnChangeValues := nil;
end;

destructor TInsumo.Destroy;
begin
  Clear;
  FNode := nil;
  OnChangeValues := nil;
  inherited Destroy;
end;

procedure TInsumo.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TInsumo) then
  begin
    FAltIns    := TInsumo(Source).AltIns;
    FCfcConv   := TInsumo(Source).CfcConv;
    FCodIns    := TInsumo(Source).CodIns;
    FCompIns   := TInsumo(Source).CompIns;
    DscIns     := TInsumo(Source).DscIns;
    FFkProduct := TInsumo(Source).FkProduct;
    FFlagDBQtd := TInsumo(Source).FlagDBQtd;
    FFlagDef   := TInsumo(Source).FlagDef;
    FFlagFrn   := TInsumo(Source).FlagFrn;
    FFlagTIns  := TInsumo(Source).FlagTIns;
    FFlagTQtd  := TInsumo(Source).FlagTQtd;
    FLargIns   := TInsumo(Source).LargIns;
    FNode      := TInsumo(Source).Node;
    FQtdIns    := TInsumo(Source).QtdIns;
    FSeqIns    := TInsumo(Source).SeqIns;
    FTotIns    := TInsumo(Source).TotIns;
    FVlrUnit   := TInsumo(Source).VlrUnit;
    FcbIndex   := TInsumo(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TInsumo.CalcQtd;
begin
  if (not (fqQtd in FFlagTQtd)) then
    FQtdIns := FAltIns * FCompIns * FLargIns;
end;

procedure TInsumo.Clear;
begin
  FAltIns    := 1;
  FCfcConv   := 0.0;
  FCodIns    := '';
  FCompIns   := 1;
  FDscIns    := '';
  FFkProduct := 0;
  FFlagDef   := False;
  FFlagFrn   := True;
  FFlagTQtd  := [];
  FFlagDBQtd := 0;
  FFlagTIns  := tiService;
  FLargIns   := 1;
  FNode      := nil;
  FQtdIns    := 1;
  FSeqIns    := 0;
  FVlrUnit   := 0.0;
  cbIndex    := 0;
end;

function TInsumo.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FFkProduct) then
    Result := FcbIndex;
end;

function TInsumo.GetDisplayName: string;
begin
  Result := FDscIns;
  if (Result = '') then Result := inherited GetDisplayName;
end;

function TInsumo.GetPkValue: Variant;
begin
  Result := FFkProduct;
end;

function TInsumo.GetTotIns: Double;
begin
  Result := 0;
  if (FQtdIns <> 0) and (FVlrUnit <> 0) then
    Result := FQtdIns * FVlrUnit;
end;

procedure TInsumo.SetAltIns(AValue: Double);
begin
  FAltIns := AValue;
  if FAltIns = 0 then FAltIns := 1;
  CalcQtd;
end;

procedure TInsumo.SetCodIns(const AValue: string);
begin
  FCodIns := Copy(AValue, 1, 30);
end;

procedure TInsumo.SetCompIns(AValue: Double);
begin
  FCompIns := AValue;
  if FCompIns = 0 then FCompIns := 1;
  CalcQtd;
end;

procedure TInsumo.SetFlagDBQtd(AValue: Byte);
var
  P: Pointer;
begin
  FFlagDBQtd := AValue;
  P := @FFlagDBQtd;
  FFlagTQtd := TFlagQtd(P^);
end;

procedure TInsumo.SetFlagTQtd(AValue: TFlagQtd);
var
  P: Pointer;
begin
  FFlagTQtd := AValue;
  P := @FFlagTQtd;
  FFlagDBQtd := Byte(P^);
end;

procedure TInsumo.SetLargIns(AValue: Double);
begin
  FLargIns := AValue;
  if FLargIns = 0 then FLargIns := 1;
  CalcQtd;
end;

procedure TInsumo.SetQtdIns(AValue: Double);
begin
  FQtdIns := AValue;
  if FQtdIns = 0 then FQtdIns := 1;
  FTotIns := FQtdIns * FVlrUnit;
end;

procedure TInsumo.SetVlrUnit(AValue: Double);
begin
  FVlrUnit := AValue;
  FTotIns  := FQtdIns * FVlrUnit;
end;

{
*********************************** TInsumos ***********************************
}
constructor TInsumos.Create(AOwner: TPersistent);
begin
  inherited Create(TInsumo);
  FOwner := AOwner;
  Clear;
end;

destructor TInsumos.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TInsumos.Add: TInsumo;
begin
  Result := inherited Add as TInsumo;
end;

procedure TInsumos.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TInsumo;
begin
  if (Source = nil) and (Source is TInsumos) then
  begin
    Clear;
    for i := 0 to Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TInsumos(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TInsumos.Clear;
begin
  inherited Clear;
end;

procedure TInsumos.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TInsumos.GetItems(Index: Integer): TInsumo;
begin
  Result := inherited Items[Index] as TInsumo;
end;

function TInsumos.GetOwner: TPersistent;
begin
  Result := FOwner;
  if Result = nil then Result := inherited GetOwner;
end;

function TInsumos.Insert(Index: Integer): TInsumo;
begin
  Result := inherited Insert(Index) as TInsumo;
end;

procedure TInsumos.SetItems(Index: Integer; AValue: TInsumo);
begin
  inherited Items[Index] := AValue;
end;

{
******************************** TServiceOrder *********************************
}
constructor TServiceOrder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Clear;
  FDtaOS              := Date;
  FHistorics          := THistorics.Create(Self);
  FServiceOrderItems  := TServiceOrderItems.Create(Self);
  FFkCadastros        := TOwner.Create;
  FFkEmpresas         := TCompany.Create;
  FFkPayment          := TTypePayment.Create;
  FFkRodovias         := TRodovias.Create;
  FFkStatusOS         := TStatusOS.Create;
  FFkTypeServiceOrder := TTypeServiceOrder.Create;
end;

destructor TServiceOrder.Destroy;
begin
  Clear;
  if Assigned(FHistorics) then
    FHistorics.Free;
  if Assigned(FServiceOrderItems) then
    FServiceOrderItems.Free;
  if Assigned(FFkCadastros) then
    FFkCadastros.Free;
  if Assigned(FFkEmpresas) then
    FFkEmpresas.Free;
  if Assigned(FFkPayment) then
    FFkPayment.Free;
  if Assigned(FFkRodovias) then
    FFkRodovias.Free;
  if Assigned(FFkStatusOS) then
    FFkStatusOS.Free;
  if Assigned(FFkTypeServiceOrder) then
    FFkTypeServiceOrder.Free;
  FFkCadastros        := nil;
  FFkEmpresas         := nil;
  FFkPayment          := nil;
  FFkRodovias         := nil;
  FFkStatusOS         := nil;
  FFkTypeServiceOrder := nil;
  FServiceOrderItems  := nil;
  FHistorics          := nil;
  inherited Destroy;
end;

procedure TServiceOrder.Assign(Source: TPersistent);
begin
  if Source is TServiceOrder then
  begin
    FActiveItem          := TServiceOrder(Source).ActiveItem;
    FCodAut              := TServiceOrder(Source).CodAut;
    FDscOrd              := TServiceOrder(Source).DscOrd;
    FDtaAprv             := TServiceOrder(Source).DtaAprv;
    FDtaBlq              := TServiceOrder(Source).DtaBlq;
    FDtaCanc             := TServiceOrder(Source).DtaCanc;
    FDtaFin              := TServiceOrder(Source).DtaFin;
    FDtaIni              := TServiceOrder(Source).DtaIni;
    FDtaLibFin           := TServiceOrder(Source).DtaLibFin;
    FDtaLiq              := TServiceOrder(Source).DtaLiq;
    FDtaOS               := TServiceOrder(Source).DtaOS;
    FkCadastros          := TServiceOrder(Source).FkCadastros;
    FkEmpresas           := TServiceOrder(Source).FkEmpresas;
    FkPayment            := TServiceOrder(Source).FkPayment;
    FkRodovias           := TServiceOrder(Source).FkRodovias;
    FkStatusOS           := TServiceOrder(Source).FkStatusOS;
    FkTypeServiceOrder   := TServiceOrder(Source).FkTypeServiceOrder;
    Historics            := TServiceOrder(Source).Historics;
    FPkOS                := TServiceOrder(Source).PkOS;
    FSubTot              := TServiceOrder(Source).SubTot;
    FTotOS               := TServiceOrder(Source).TotOS;
    FVlrAcrDsct          := TServiceOrder(Source).VlrAcrDsct;
    Historics            := TServiceOrder(Source).Historics;
    ServiceOrderItems    := TServiceOrder(Source).ServiceOrderItems;
  end
  else
    inherited Assign(Source);
end;

procedure TServiceOrder.CalcOrder;
var
  i: Integer;
begin
  FSubTot := 0;
  for i := 0 to FServiceOrderItems.Count - 1 do
    FSubTot := FSubTot + FServiceOrderItems.Items[i].TotSrv;
  FTotOS := FSubTot + FVlrAcrDsct;
end;

function TServiceOrder.CheckRules(CheckPk: Boolean): Boolean;
var
  aCheckError: TCheckErrors;
  i: TCheckErrorType;
  aMsg: string;
begin
  aCheckError := [];
  Result := True;
  // Check if DtaOS is not null
  if (FDtaOS = 0) then aCheckError := aCheckError + [ceNullDtaOS];
  // Check if Initial Date is null
  if (FDtaIni = 0) or (FDtaIni < FDtaOS) then
    aCheckError := aCheckError + [ceNullDtaIni];
  // Check if Final Date is null
  if (FDtaFin = 0) or (FDtaFin < FDtaOS) or (FDtaFin < FDtaIni) then
    aCheckError := aCheckError + [ceNullDtaFin];
  // Check if Owner of the Service Order is null
  if ((FFkCadastros = nil) or (FFkCadastros.PkCadastros = 0)) then
    aCheckError := aCheckError + [ceNullOwner];
  // Check if Company is not null
  if ((FFkEmpresas = nil) or (FFkEmpresas.PkCompany = 0)) then
    aCheckError := aCheckError + [ceNullCompany];
  // Check if Status of the Service Order is null
  if ((FFkStatusOS = nil) or (FFkStatusOS.PKStatusOS = 0)) then
    aCheckError := aCheckError + [ceNullStatus];
  aCheckError := aCheckError + CheckStatus;
  // Check if Type Service Order is null
  if ((FFkTypeServiceOrder = nil) or
     (FFkTypeServiceOrder.PkTipoOrdensServicos = 0)) then
    aCheckError := aCheckError + [ceNullTypeServiceOrder];
  // Check if Service Order has a Number
  if (CheckPk) and (FPkOS = 0) then aCheckError := aCheckError + [ceNullPkOS];
  // Check if Service Order has Items
  if (FServiceOrderItems = nil) or
     (FServiceOrderItems.Count = 0) then
    aCheckError := aCheckError + [ceNullItems];
  // Check Total of the Service Order is greather than zero
  if (FTotOS <= 0) then aCheckError := aCheckError + [ceNullItems];
  // if there is errors then raise it
  if aCheckError <> [] then
  begin
    Result := False;
    for i := ceNullDtaOS to ceNullTotal do
    begin
      if (i in aCheckError) then
      begin
        aMsg := Msg[i];
        if Assigned(FOnCheckError) then
          FOnCheckError(Self, i, aMsg);
        raise Exception.Create(aMsg);
      end;
    end;
  end;
end;

function TServiceOrder.CheckStatus: TCheckErrors;
var
  aIdx, aCountItems: Integer;
begin
  Result := [];
  // Check if status and dates are synchronized
  case FFkStatusOS.FlagStt of
    stFinished: if (FDtaLiq  = 0) then Result := Result + [ceNullDtaLiq];
    stCanceled: if (FDtaCanc = 0) then Result := Result + [ceNullDtaCanc];
    stBlocked : if (FDtaBlq  = 0) then Result := Result + [ceNullDtaBlq];
    stApproved: if (FDtaAprv = 0) then Result := Result + [ceNullDtaApproved];
  end;
  // Check if type Payment is not null tsCash, tsPeriod, tsFuture, tsInReturn
  if (DtaLibFin > 0) then
    if (FFkPayment = nil) or (FFkPayment.PkTypePgto = 0) then
      Result := Result + [ceNullPayment]
    else
      if (FFkPayment.FlagTVda = tsPeriod) and (FFkPayment.FlagTInt = ipUser) and
         (FFkPayment.Intervals.Count > 0) then
        Result := Result + [ceNullPayment];
  // Check if Status needs a autorization then call the OnAutorization Event
  if (Boolean(FFkStatusOS.FlagAut)) and (FCodAut = 0) then
  begin
    if Assigned(FOnAutorization) then
      FOnAutorization(Self, FFkStatusOS, FCodAut);
    if (FCodAut = 0) then Result := Result + [ceAuthDenied];
  end;
  // Check all Status if it satisfy al requests
  // stOpened
  if FFkStatusOS.FlagStt = stOpened then
    if (FDtaOS = 0) or (FDtaLiq <> 0) or (FDtaCanc <> 0) or (FDtaBlq <> 0) or
       (FDtaAprv <> 0) then
      Result := Result + [ceStatusError];
  // stBlocked
  if (FFkStatusOS.FlagStt = stBlocked) and
     (not (ceStatusError in Result)) then
    if (FDtaBlq <> 0) or (FDtaLiq <> 0) or (DtaCanc <> 0) then
      Result := Result + [ceStatusError];
  // stCanceled
  if (FFkStatusOS.FlagStt = stCanceled) and
     (not (ceStatusError in Result)) then
  begin
    if (FDtaLiq <> 0) then
      Result := Result + [ceStatusError];
    aCountItems := 0;
    if (FServiceOrderItems <> nil) then
      for aIdx := 0 to FServiceOrderItems.Count - 1 do
        if FServiceOrderItems.Items[aIdx].DtaFat <> 0 then
          Inc(aCountItems);
    if (aCountItems > 0) and (not (ceStatusError in Result)) then
      Result := Result + [ceStatusError];
  end;
  // stFinished
  if (FFkStatusOS.FlagStt = stFinished) and
     (not (ceStatusError in Result)) then
  begin
    if (FDtaLiq <> 0) or (FDtaCanc <> 0) or (FDtaBlq <> 0) or (DtaAprv = 0) then
      Result := Result + [ceStatusError];
  end;
  // stParcialFinished
  if (FFkStatusOS.FlagStt = stParcialFinished) and
     (not (ceStatusError in Result)) then
  begin
    if (FDtaCanc <> 0) or (FDtaBlq <> 0) or (DtaAprv = 0) then
      Result := Result + [ceStatusError];
    aCountItems := 0;
    if (FServiceOrderItems <> nil) then
      for aIdx := 0 to FServiceOrderItems.Count - 1 do
        if FServiceOrderItems.Items[aIdx].DtaFat <> 0 then
          Inc(aCountItems);
    if (aCountItems = 0) and (not (ceStatusError in Result)) then
      Result := Result + [ceStatusError];
  end;
  // stApproved
  if (FFkStatusOS.FlagStt = stApproved) and
     (not (ceStatusError in Result)) then
  begin
    if (FDtaAprv <> 0) or (FDtaCanc <> 0) or (FDtaBlq <> 0) or (FDtaLiq <> 0) then
      Result := Result + [ceStatusError];
    aCountItems := 0;
    if (FServiceOrderItems <> nil) then
      for aIdx := 0 to FServiceOrderItems.Count - 1 do
        if FServiceOrderItems.Items[aIdx].DtaFat <> 0 then
          Inc(aCountItems);
    if (aCountItems > 0) and (not (ceStatusError in Result)) then
      Result := Result + [ceStatusError];
  end;
end;

procedure TServiceOrder.Clear;
begin
  FStateSO            := dbmBrowse;
  FActiveItem         := -1;
  FCodAut             := 0;
  FDtaBlq             := 0;
  FDtaCanc            := 0;
  FDtaLiq             := 0;
  FDtaOS              := 0;
  FPkOS               := 0;
  FSubTot             := 0.0;
  FTotOS              := 0.0;
  FVlrAcrDsct         := 0.0;
  if Assigned(FFkEmpresas) then
    FFkEmpresas.Clear;
  if Assigned(FFkCadastros) then
    FFkCadastros.Clear;
  if Assigned(FFkStatusOS) then
    FFkStatusOS.Clear;
  if Assigned(FFkTypeServiceOrder) then
    FFkTypeServiceOrder.Clear;
  if Assigned(FFkRodovias) then
    FFkRodovias.Clear;
  if Assigned(FFkPayment) then
    FFkPayment.Clear;
  if Assigned(FHistorics) then
    FHistorics.Clear;
  if Assigned(FServiceOrderItems) then
    FServiceOrderItems.Clear;
end;

function TServiceOrder.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_EMPRESAS');
  Result.Add('PK_ORDENS_SERVICOS');
  Result.Add('FK_TIPO_ORDENS_SERVICOS');
  Result.Add('FK_GRUPOS_MOVIMENTOS');
  Result.Add('FK_TIPO_MOVIMENTOS');
  Result.Add('FK_CADASTROS');
  Result.Add('FK_RODOVIAS');
  Result.Add('FK_TIPO_STATUS_OS');
  if (Assigned(FkPayment)) and (FkPayment.PkTypePgto > 0) then
    Result.Add('FK_TIPO_PAGAMENTOS');
  Result.Add('DTA_OS');
  Result.Add('SUB_TOT');
  Result.Add('VLR_ACR_DSCT');
  Result.Add('TOT_ORD');
  Result.Add('QTD_ITEMS');
  Result.Add('KEY_ITEMS');
  Result.Add('DSC_ORD');
  if DtaIni    > 0  then Result.Add('DTA_INI');
  if DtaFin    > 0  then Result.Add('DTA_FIN');
  if DtaAprv   > 0  then Result.Add('DTA_APR');
  if DtaCanc   > 0  then Result.Add('DTA_CANC');
  if DtaLiq    > 0  then Result.Add('DTA_LIQ');
  if DtaBlq    > 0  then Result.Add('DTA_BLQ');
  if CodAut    > 0  then Result.Add('COD_AUT');
  if DtaLibFin > 0  then Result.Add('DTA_LIB_FIN');
end;

function TServiceOrder.GetHistoricClass: THistoricClass;
begin
  Result := THistoric;
end;

function TServiceOrder.GetServiceOrderItemClass: TServiceOrderItemClass;
begin
  Result := TServiceOrderItem;
end;

procedure TServiceOrder.SetActiveItem(Value: Integer);
begin
  if Value > -1 then
  begin
    if (FServiceOrderItems = nil) then
      raise Exception.Create('TServiceOrder Error: ServiceOrderItems is nil');
    if (FServiceOrderItems.Count <= Value) then
      raise Exception.CreateFmt('TServiceOrder Error: ActiveItem %d must be ' +
        'less than Items count (%d)', [Value, FServiceOrderItems.Count]);
  end;
  if (Value <> FActiveItem) then
    FActiveItem := Value;
end;

procedure TServiceOrder.SetCodAut(Value: Integer);
var
  Allowed: Boolean;
  aHistoric: THistoric;
begin
  FCodAut := 0;
  if Value = 0 then exit;
  Allowed := True;
  if (Assigned(FOnChangeAuth)) then
    FOnChangeAuth(Self, Value, Allowed)
  else
    if Value = 0 then exit;
  if Allowed and (StateSO in [dbmInsert, dbmEdit]) then
  begin
    FCodAut                := Value;
    aHistoric              := Historics.Add;
    aHistoric.CodAut       := Value;
    aHistoric.DscHist      := 'Autorization';
    aHistoric.DtHrHist     := Now;
    aHistoric.FkStatusOS   := FFkStatusOS;
    aHistoric.HistoricType := htAutorization;
  end
  else
    raise Exception.Create('Service Order: Operation not Autorized');
end;

procedure TServiceOrder.SetDtaFin(AValue: TDate);
begin
  FDtaFin := AValue;
  if (FStateSO in [dbmInsert, dbmEdit]) then
  begin
    if (FDtaFin < FDtaOS) or (FDtaFin < FDtaIni) then
        raise Exception.Create('Erro: Data do final da OS não pode ser menor ' +
          'que a data da OS ou a Data Inicial');
  end;
end;

procedure TServiceOrder.SetDtaIni(AValue: TDate);
begin
  FDtaIni := AValue;
  if (FStateSO in [dbmInsert, dbmEdit]) then
  begin
    if FDtaIni < FDtaOS then
        raise Exception.Create('Erro: Data do início da OS não pode ser menor ' +
          'que a data da OS');
  end;
end;

procedure TServiceOrder.SetFkCadastros(AValue: TOwner);
var
  Allowed: Boolean;
begin
  if (AValue <> nil) then
  begin
    Allowed := True;
    if (Assigned(FOnChangeFkCadastros)) then
      FOnChangeFkCadastros(Self, AValue.PkCadastros, Allowed);
    if (Allowed) then
      FFkCadastros.Assign(AValue)
    else
      raise Exception.CreateFmt('OS: Value informed to FkCadastros %s(%d) is not valid',
        [AValue.RazSoc, AValue.PkCadastros]);
  end
  else
    FFkCadastros.Clear;
end;

procedure TServiceOrder.SetFkEmpresas(AValue: TCompany);
begin
  if (AValue = nil) then
    FFkEmpresas.Clear
  else
    FFkEmpresas.Assign(AValue);
end;

procedure TServiceOrder.SetFkPayment(AValue: TTypePayment);
var
  Allowed: Boolean;
begin
  if (AValue <> nil) then
  begin
    Allowed := True;
    if (Assigned(OnChangeFkPayment)) then
      FOnChangeFkPayment(Self, AValue.PkTypePgto, Allowed);
    if (Allowed) then
      FFkPayment.Assign(AValue)
    else
      raise Exception.CreateFmt('OS: Value informed to FFkPayment %s(%d) is not valid',
        [AValue.DscTPgt, AValue.PkTypePgto]);
  end
  else
    FFkPayment.Clear;
end;

procedure TServiceOrder.SetFkRodovias(AValue: TRodovias);
var
  Allowed: Boolean;
begin
  if (AValue <> nil) then
  begin
    Allowed := True;
    if (Assigned(OnChangeRodovias)) then
      FOnChangeRodovias(Self, AValue.PkRodovias, Allowed);
    if (Allowed) then
      FFkRodovias.Assign(AValue)
    else
      raise Exception.CreateFmt('OS: Value informed to FFkRodovias %s(%d) is not valid',
        [AValue.DscRod, AValue.PkRodovias]);
  end
  else
    FFkRodovias.Clear;
end;

procedure TServiceOrder.SetFkStatusOS(AValue: TStatusOS);
var
  Allowed: Boolean;
  aHistoric: THistoric;
begin
  if (AValue <> nil) then
  begin
    Allowed := True;
    if (Assigned(FOnChangeStatus)) then
      FOnChangeStatus(Self, AValue.PkStatusOS, Allowed);
    if (Allowed) then
    begin
      FFkStatusOS.Assign(AValue);
      case FFkStatusOS.FlagStt of
        stOpened  : if FDtaOS   = 0 then FDtaOS   := Date;
        stFinished: if FDtaLiq  = 0 then FDtaLiq  := Date;
        stCanceled: if FDtaCanc = 0 then FDtaCanc := Date;
        stBlocked : if FDtaBlq  = 0 then FDtaBlq  := Date;
        stApproved: if FDtaAprv = 0 then FDtaAprv := Date;
      end;
      if StateSO in [dbmInsert, dbmEdit] then
      begin
        if (not Assigned(FHistorics)) then
          FHistorics           := THistorics.Create(Self);
        aHistoric              := FHistorics.Add;
        aHistoric.DscHist      := 'Change Status';
        aHistoric.FkStatusOS   := AValue;
        aHistoric.DtHrHist     := Now;
        aHistoric.HistoricType := htStatus;
      end;
    end
    else
      raise Exception.Create('Service Order: Value informed to FkStatusOS is not valid');
  end
  else
    FFkStatusOS.Clear;
end;

procedure TServiceOrder.SetFkTypeServiceOrder(AValue: TTypeServiceOrder);
var
  Allowed: Boolean;
begin
  if (AValue <> nil) then
  begin
    Allowed := True;
    if (Assigned(FOnChangeFkTypeOS)) then
      FOnChangeFkTypeOS(Self, AValue.PkTipoOrdensServicos, Allowed);
    if (Allowed) then
      FFkTypeServiceOrder.Assign(AValue)
    else
      raise Exception.CreateFmt('OS: Value informed to FkTypeOS %s(%d) is not valid',
        [AValue.DscTOS, AValue.PkTipoOrdensServicos]);
  end;
end;

procedure TServiceOrder.SetHistorics(AValue: THistorics);
begin
  if (AValue <> nil) then
    FHistorics.Assign(AValue)
  else
    FHistorics.Clear;
end;

procedure TServiceOrder.SetServiceOrderItems(AValue: TServiceOrderItems);
begin
  if (AValue <> nil) then
    FServiceOrderItems.Assign(AValue)
  else
    FServiceOrderItems.Clear;
end;

procedure TServiceOrder.SetVlrAcrDsct(Value: Double);
begin
  FVlrAcrDsct := Value;
  FTotOS := FSubTot + FVlrAcrDsct;
end;

{
****************************** TServiceOrderItems ******************************
}
constructor TServiceOrderItems.Create(ServiceOrder: TServiceOrder);
begin
  if ServiceOrder <> nil then
    inherited Create(ServiceOrder.GetServiceOrderItemClass)
  else
    inherited Create(TServiceOrderItem);
  FServiceOrder := ServiceOrder;
end;

destructor TServiceOrderItems.Destroy;
begin
  inherited Destroy;
end;

function TServiceOrderItems.Add: TServiceOrderItem;
begin
  Result := TServiceOrderItem(inherited Add);
end;

procedure TServiceOrderItems.Assign(Source: TPersistent);
var
  aIdx: Integer;
  aItem: TServiceOrderItem;
begin
  if (Source <> nil) and (Source is TServiceOrderItems) then
  begin
    Clear;
    for aIdx := 0 to TServiceOrderItems(Source).Count - 1 do
    begin
      aItem := Self.Add;
      aItem.Assign(TServiceOrderItems(Source).Items[aIdx]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TServiceOrderItems.BeginUpdate;
begin
  inherited BeginUpdate;
end;

procedure TServiceOrderItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
  //for i := 0 to Count - 1 do
  //  if Items[i].Index <> i then
  //    Items[i].Index := i;
  if (Owner <> nil) and (Owner is TServiceOrder) and
     (TServiceOrder(Owner).ActiveItem = Index) then
    TServiceOrder(Owner).ActiveItem := -1;
end;

procedure TServiceOrderItems.EndUpdate;
begin
  inherited EndUpdate;
end;

function TServiceOrderItems.GetItems(Index: Integer): TServiceOrderItem;
begin
  Result := inherited Items[Index] as TServiceOrderItem;
end;

function TServiceOrderItems.GetOwner: TPersistent;
begin
  Result := FServiceOrder;
end;

function TServiceOrderItems.Insert(Index: Integer): TServiceOrderItem;
begin
  Result := TServiceOrderItem(inherited Insert(Index));
end;

function TServiceOrderItems.Owner: TPersistent;
begin
  Result := inherited Owner;
end;

procedure TServiceOrderItems.SetItems(Index: Integer; Value: TServiceOrderItem);
begin
  inherited Items[Index] := Value;
end;

{
****************************** TServiceOrderItem *******************************
}
constructor TServiceOrderItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FOnChangeService := nil;
  FOnChangeValues  := nil;
  FOnInvoice       := nil;
  FFkMetricItem    := TMetricItem.Create;
  FFkInsumos       := TInsumos.Create(Self);
  Clear;
end;

destructor TServiceOrderItem.Destroy;
begin
  Clear;
  if Assigned(FFkMetricItem) then
    FFkMetricItem.Free;
  if Assigned(FFkInsumos) then
    FFkInsumos.Free;
  FOnChangeService := nil;
  FOnChangeValues  := nil;
  FOnInvoice       := nil;
  FFkInsumos       := nil;
  FFkMetricItem    := nil;
  inherited Destroy;
end;

procedure TServiceOrderItem.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TServiceOrderItem) then
  begin
    FActiveInsumo     := TServiceOrderItem(Source).ActiveInsumo;
    FAltSrv           := TServiceOrderItem(Source).AltSrv;
    FCodRef           := TServiceOrderItem(Source).CodRef;
    FCompSrv          := TServiceOrderItem(Source).CompSrv;
    FDscTComp         := TServiceOrderItem(Source).DscTComp;
    FDtaFat           := TServiceOrderItem(Source).DtaFat;
    FFkClassification := TServiceOrderItem(Source).FkClassification;
    FkInsumos         := TServiceOrderItem(Source).FkInsumos;
    FkMetricItem      := TServiceOrderItem(Source).FkMetricItem;
    FFlagCalcVlrIns   := TServiceOrderItem(Source).FlagCalcVlrIns;
    FFlagDBQtd        := TServiceOrderItem(Source).FlagDBQtd;
    FFlagPers         := TServiceOrderItem(Source).FlagPers;
    FFlagTQtd         := TServiceOrderItem(Source).FlagTQtd;
    FItemIsVisible    := TServiceOrderItem(Source).ItemIsVisible;
    FLargSrv          := TServiceOrderItem(Source).LargSrv;
    FNode             := TServiceOrderItem(Source).Node;
    FPkProduct        := TServiceOrderItem(Source).PkProduct;
    FQtdSrv           := TServiceOrderItem(Source).QtdSrv;
    FTotSrv           := TServiceOrderItem(Source).TotSrv;
    FValueType        := TServiceOrderItem(Source).ValueType;
    FVlrUnit          := TServiceOrderItem(Source).VlrUnit;
  end
  else
    inherited Assign(Source);
end;

function TServiceOrderItem.CalcQtd: Double;
begin
  Result := FCompSrv * FLargSrv * FAltSrv;
end;

procedure TServiceOrderItem.CalcVlrUnitFromIns;
var
  i: Integer;
begin
  FTotSrv := 0;
  for i := 0 to FkInsumos.Count - 1 do
    FTotSrv := FTotSrv + FkInsumos.Items[i].TotIns;
  if FTotSrv > 0 then
    VlrUnit := FTotSrv / FQtdSrv;
end;

procedure TServiceOrderItem.CheckRules;
var
  aTypeUse: TTypeUse;
begin
  aTypeUse := tuNone;
  if FPkProduct = 0 then
    raise Exception.Create('Erro: Deve-se especificar um serviço antes de salvar');
  if (Collection <> nil) and (Collection is TServiceOrderItems) and
     (Collection.Owner <> nil) and (Collection.Owner is TServiceOrder) and
     (TServiceOrder(Collection.Owner).FkTypeServiceOrder <> nil) then
    aTypeUse := TServiceOrder(Collection.Owner).FkTypeServiceOrder.FlagTOS;
  if (aTypeUse = tuMetric) and Assigned(FFkMetricItem) then
  begin
    if FFkMetricItem.KmIni < 0 then
      raise Exception.Create('Erro: Marco Incial inválido');
    if FFkMetricItem.KmFin < 0 then
      raise Exception.Create('Erro: Marco Final inválido');
  end;
  if (not (FFlagCalcVlrIns)) and (TotSrv = 0) then
    raise Exception.Create('Erro: Valor total do ítem inválido');
end;

procedure TServiceOrderItem.Clear;
begin
  FActiveInsumo     := -1;
  FAltSrv           := 1;
  FCodRef           := '';
  FCompSrv          := 1;
  FDscTComp         := '';
  FDtaFat           := 0;
  FFkClassification := 0;
  if Assigned(FFkInsumos) then
    FFkInsumos.Clear;
  if Assigned(FFkMetricItem) then
  begin
    FFkMetricItem.Clear;
    FFkMetricItem.OnValidateMark := ValidateMark;
  end;
  FFlagCalcVlrIns   := False;
  FFlagDBQtd        := 0;
  FFlagPers         := False;
  FFlagTQtd         := [];
  FItemIsVisible    := False;
  FNode             := nil;
  FLargSrv          := 1;
  FPkProduct        := 0;
  FQtdSrv           := 1;
  FTotSrv           := 0;
  FValueType        := vtNone;
  FVlrUnit          := 0;
end;

function TServiceOrderItem.GetDisplayName: string;
begin
  Result := FDscTComp;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TServiceOrderItem.SetActiveInsumo(AValue: Integer);
begin
  if (AValue <> FActiveInsumo) then
    FActiveInsumo := AValue;
end;

procedure TServiceOrderItem.SetAltSrv(AValue: Double);
var
  i: Integer;
begin
  FAltSrv := AValue;
  if FAltSrv = 0 then FAltSrv := 1;
  FValueType := vtAlt;
  if Assigned(FOnChangeValues) then
    FOnChangeValues(Self, vtAlt, FAltSrv);
  if FlagCalcVlrIns then
  begin
    QtdSrv := CalcQtd;
    for i := 0 to FFkInsumos.Count - 1 do
      FFkInsumos.Items[i].AltIns := FAltSrv;
  end;
end;

procedure TServiceOrderItem.SetCodRef(AValue: string);
begin
  FCodRef := Copy(AValue, 1, 30);
end;

procedure TServiceOrderItem.SetCompSrv(AValue: Double);
var
  i: Integer;
begin
  FCompSrv := AValue;
  if FCompSrv = 0 then FCompSrv := 1;
  FValueType := vtComp;
  if Assigned(FOnChangeValues) then
    FOnChangeValues(Self, vtComp, FCompSrv);
  if FlagCalcVlrIns then
  begin
    QtdSrv := CalcQtd;
    for i := 0 to FFkInsumos.Count - 1 do
      FFkInsumos.Items[i].CompIns := FCompSrv;
  end;
end;

procedure TServiceOrderItem.SetDtaFat(Value: TDate);
begin
  if (FDtaFat = 0) and (Value <> FDtaFat) then
  begin
    FDtaFat := Value;
    if Assigned(OnInvoice) then
      OnInvoice(Self);
  end;
end;

procedure TServiceOrderItem.SetFkInsumos(AValue: TInsumos);
begin
  if Assigned(AValue) then
    FFkInsumos.Assign(AValue)
  else
    FFkInsumos.Clear;
end;

procedure TServiceOrderItem.SetFkMetricItem(AValue: TMetricItem);
begin
  if (AValue <> nil) then
    FFkMetricItem.Assign(AValue)
  else
    FFkMetricItem.Clear;
end;

procedure TServiceOrderItem.SetFlagDBQtd(AValue: Integer);
var
  P: Pointer;
begin
  FFlagDBQtd := AValue;
  P := @FFlagDBQtd;
  FFlagTQtd := TFlagQtd(P^);
end;

procedure TServiceOrderItem.SetFlagTQtd(AValue: TFlagQtd);
var
  P: Pointer;
begin
  FFlagTQtd := AValue;
  P := @FFlagTQtd;
  FFlagDBQtd := Integer(P^);
end;

procedure TServiceOrderItem.SetLargSrv(AValue: Double);
var
  i: Integer;
begin
  FLargSrv := AValue;
  if FLargSrv = 0 then FLargSrv := 1;
  FValueType := vtLarg;
  if Assigned(FOnChangeValues) then
    FOnChangeValues(Self, vtLarg, FLargSrv);
  if FlagCalcVlrIns then
  begin
    QtdSrv := CalcQtd;
    for i := 0 to FFkInsumos.Count - 1 do
      FFkInsumos.Items[i].LargIns := FLargSrv;
  end;
end;

procedure TServiceOrderItem.SetQtdSrv(AValue: Double);
begin
  FQtdSrv := AValue;
  FTotSrv := FQtdSrv * FVlrUnit;
  FValueType := vtQtd;
  if Assigned(FOnChangeValues) then
    FOnChangeValues(Self, vtQtd, FQtdSrv);
end;

procedure TServiceOrderItem.SetVlrUnit(Value: Double);
begin
  FVlrUnit := Value;
  FTotSrv  := FQtdSrv * FVlrUnit;
  FValueType := vtUnit;
  if Assigned(FOnChangeValues) then
    FOnChangeValues(Self, vtUnit, FVlrUnit);
end;

procedure TServiceOrderItem.ValidateMark(Sender: TObject; const Mark: TMarkType;
        var Value: Double; const MarkIni, MarkFin: Double);
var
  KmIni, KmFin: Double;
  
  const
    sMSG: array [mtInitial..mtFinal] of string =
      ('Erro: Marco inicial inválido',
       'Erro: Marco final inválido');
  
begin
  if (Collection <> nil) and (Collection is TServiceOrderItems) and
     (Collection.Owner <> nil) and (Collection.Owner is TServiceOrder) and
     (TServiceOrder(Collection.Owner).FkRodovias <> nil) and
     (TServiceOrder(Collection.Owner).StateSO in [dbmInsert, dbmEdit]) then
  begin
    KmIni := TServiceOrder(Collection.Owner).FkRodovias.KmIni;
    KmFin := TServiceOrder(Collection.Owner).FkRodovias.KmFin;
    if ((Mark = mtInitial) and (((Value < KmIni) or (Value > KmFin)) or
       ((MarkFin > 0) and (Value > MarkFin)))) or
       ((Mark = mtFinal  ) and (((Value > KmFin) or (Value < KmIni)) or
       ((MarkIni > 0) and (Value < MarkIni)))) then
    begin
      Value := 0;
      raise Exception.Create(sMSG[Mark]);
    end;
  end;
end;


end.
