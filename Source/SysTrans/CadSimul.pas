unit CadSimul;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created  : 14/02/2007                                                 *}
{* Modified :                                                            *}
{* Version  : 1.2.0.0                                                    *}
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
  Dialogs, ExtCtrls, VirtualTrees, StdCtrls, ComCtrls, Mask, ToolEdit, CurrEdit,
  ProcUtils, TSysCadAux, TSysTrans, mSysTrans, PrcCombo, Buttons, TSysCad,
  TSysEstq, ToolWin, TSysPedAux, CadModel;

type
  TTypeLocale = (toCountry, toState, toCity);

  TCdSimulator = class(TfrmModel)
    pClientArea: TPanel;
    pCalc: TPanel;
    pgCalc: TPageControl;
    tsQuantity: TTabSheet;
    tsCube: TTabSheet;
    eFk_Tabela_Precos: TComboBox;
    lFk_Tabela_Precos: TStaticText;
    lVlr_NF: TStaticText;
    lQtdProd: TStaticText;
    eVlr_NF: TCurrencyEdit;
    pgCalcCarrier: TPageControl;
    tsOwner: TTabSheet;
    tsParner: TTabSheet;
    lVlr_Fre_Peso: TStaticText;
    eVlr_Fre_Peso: TCurrencyEdit;
    lFre_Vlr: TStaticText;
    eFre_Vlr: TCurrencyEdit;
    lVlr_Secat: TStaticText;
    eVlr_Secat: TCurrencyEdit;
    shTot_Ped: TShape;
    lTot_Ped: TLabel;
    lVlr_Dif_Acc: TStaticText;
    eVlr_Dif_Acc: TCurrencyEdit;
    eVlr_Pedg: TCurrencyEdit;
    lVlr_Pedg: TStaticText;
    lVlr_Gris: TStaticText;
    eVlr_Gris: TCurrencyEdit;
    lBas_ICMS: TStaticText;
    eBas_ICMS: TCurrencyEdit;
    lAlqt_ICMS: TStaticText;
    eAlqt_ICMS: TCurrencyEdit;
    eVlr_ICMS: TCurrencyEdit;
    lVlr_ICMS: TStaticText;
    eTot_Ped: TCurrencyEdit;
    lVlr_Fre_Peso_P: TStaticText;
    eVlr_Fre_Peso_P: TCurrencyEdit;
    lFre_Vlr_P: TStaticText;
    eFre_Vlr_P: TCurrencyEdit;
    lVlr_Secat_P: TStaticText;
    eVlr_Secat_P: TCurrencyEdit;
    shTot_Ped_P: TShape;
    lTot_Ped_P: TLabel;
    lVlr_Dif_Acc_P: TStaticText;
    eVlr_Dif_Acc_P: TCurrencyEdit;
    eVlr_Pedg_P: TCurrencyEdit;
    lVlr_Pedg_P: TStaticText;
    lVlr_Gris_P: TStaticText;
    eVlr_Gris_P: TCurrencyEdit;
    eTot_Ped_P: TCurrencyEdit;
    lFk_Produtos: TStaticText;
    eFk_Produtos: TComboBox;
    ePk_Pedidos_Fretes: TLabel;
    vtMeasure: TVirtualStringTree;
    eQtd_Prod: TRxCalcEdit;
    tsObservations: TTabSheet;
    eObs_Ped: TMemo;
    pgOrgmDstn: TPageControl;
    tsSelOrgmDstn: TTabSheet;
    tsSelRemDstn: TTabSheet;
    lNomSol: TStaticText;
    eNomSol: TEdit;
    lDta_Ped: TStaticText;
    shPk_Pedidos_Fretes: TShape;
    eDta_Ped: TDateEdit;
    lFk_Parceiro: TStaticText;
    eFk_Parceiro: TComboBox;
    lFk_Vendedores: TStaticText;
    eFk_Vendedores: TComboBox;
    lNum_NF: TStaticText;
    eNum_NF: TCurrencyEdit;
    lVlr_Acr_Dsct: TStaticText;
    eVlr_Acr_Dsct: TCurrencyEdit;
    gbAddressee: TGroupBox;
    lDocDstn: TStaticText;
    eTypeDstn: TComboBox;
    eDocDstn: TMaskEdit;
    shAddressee: TShape;
    lAddressee: TLabel;
    shDescriptionAddr: TShape;
    lDescriptionAddr: TLabel;
    gbShipper: TGroupBox;
    lDocRem: TStaticText;
    eTypeRem: TComboBox;
    eDocRem: TMaskEdit;
    lShipper: TLabel;
    shShipper: TShape;
    lDescriptionShipper: TLabel;
    shDescriptionShipper: TShape;
    gbOrigin: TGroupBox;
    gbDestination: TGroupBox;
    lFkPaisesOrgm: TStaticText;
    lFkEstadosOrgm: TStaticText;
    lFkMunicipiosOrgm: TStaticText;
    lRegionOrgm: TLabel;
    shRegionOrgm: TShape;
    lFkPaisesDstn: TStaticText;
    lFkEstadosDstn: TStaticText;
    lFkMunicipiosDstn: TStaticText;
    shRegionDstn: TShape;
    lRegionDstn: TLabel;
    eFkPaisesOrgm: TPrcComboBox;
    eFkEstadosOrgm: TPrcComboBox;
    eFkMunicipiosOrgm: TPrcComboBox;
    eFkPaisesDstn: TPrcComboBox;
    eFkEstadosDstn: TPrcComboBox;
    eFkMunicipiosDstn: TPrcComboBox;
    tsSchedule: TTabSheet;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    StaticText3: TStaticText;
    ComboBox1: TComboBox;
    vtSchedule: TVirtualStringTree;
    cbOperSchedule: TCoolBar;
    tbOperSchedule: TToolBar;
    tbInsert: TToolButton;
    tbDelete: TToolButton;
    tbCancel: TToolButton;
    tbSave: TToolButton;
    ToolButton1: TToolButton;
    tsConsignatario: TTabSheet;
    lDocConsignee: TStaticText;
    eTypeConsignee: TComboBox;
    eDocConsignee: TMaskEdit;
    shConsignee: TShape;
    lConsignee: TLabel;
    shDescriptionConsignee: TShape;
    lDescriptionConsignee: TLabel;
    lFlag_Cnsm_Orgm: TRadioButton;
    lFlag_Company_Orgm: TRadioButton;
    lFlag_Company_Dstn: TRadioButton;
    lFlag_Cnsm_Dstn: TRadioButton;
    sbCancelOrgm: TSpeedButton;
    sbCancelDstn: TSpeedButton;
    sbSearchShipper: TSpeedButton;
    sbSearchAddressee: TSpeedButton;
    sbSearchConsignee: TSpeedButton;
    rgTypeMed: TRadioGroup;
    sbCalcCub: TSpeedButton;
    lQtd_Vol: TStaticText;
    eQtd_Vol: TCurrencyEdit;
    tsComplement: TTabSheet;
    lFlag_ES: TRadioGroup;
    lFlag_Remb: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eFkPaisesOrgmSelect(Sender: TObject);
    procedure eFkEstadosOrgmSelect(Sender: TObject);
    procedure eFkMunicipiosOrgmSelect(Sender: TObject);
    procedure eFkPaisesDstnSelect(Sender: TObject);
    procedure eFkEstadosDstnSelect(Sender: TObject);
    procedure eFkMunicipiosDstnSelect(Sender: TObject);
    procedure ChangeState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure eTot_PedChange(Sender: TObject);
    procedure eTypeRemSelect(Sender: TObject);
    procedure eTypeDstnSelect(Sender: TObject);
    procedure eTypeConsigneeSelect(Sender: TObject);
    procedure eFk_ProdutosSelect(Sender: TObject);
    procedure sbCancelOrgmClick(Sender: TObject);
    procedure sbCancelDstnClick(Sender: TObject);
    procedure sbSearchOwner(Sender: TObject);
    procedure eDocRemExit(Sender: TObject);
    procedure eDocDstnExit(Sender: TObject);
    procedure eDocConsigneeExit(Sender: TObject);
    procedure vtMeasureGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtMeasureKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtMeasureNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure rgTypeMedClick(Sender: TObject);
    procedure vtMeasureEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure pgCalcChange(Sender: TObject);
    procedure vtMeasureGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure sbCalcCubClick(Sender: TObject);
  private
    { Private declarations }
    FDocumentType   : TDocumentType;
    FFkOrigin       : Integer;
    FFkDestination  : Integer;
    FCalcOrder      : Boolean;
    FCarrierPrice   : TCarrierPrice;
    FCarrierPriceP  : TCarrierPrice;
    FFkPartnerOrgDst: Integer;
    FSubTot         : Double;
    FFkShipper      : TOwner;
    FFkAddressee    : TOwner;
    FFkConsignee    : TOwner;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetAlqtICMS: Double;
    function  GetBasICMS: Double;
    function  GetFkParceiro: Integer;
    function  GetFkProdutos: TProducts;
    function  GetFkTypeTable: TTypeTable;
    function  GetFreVlr: Double;
    function  GetFreVlrP: Double;
    function  GetObsPed: TStrings;
    function  GetPkPedidosFretes: Integer;
    function  GetQtdProd: Double;
    function  GetTotPed: Double;
    function  GetTotPedP: Double;
    function  GetVlrAcrDsct: Double;
    function  GetVlrDifAcc: Double;
    function  GetVlrDifAccP: Double;
    function  GetVlrFrePeso: Double;
    function  GetVlrFrePesoP: Double;
    function  GetVlrGris: Double;
    function  GetVlrGrisP: Double;
    function  GetVlrICMS: Double;
    function  GetVlrNF: Double;
    function  GetVlrPedg: Double;
    function  GetVlrPedgP: Double;
    function  GetVlrSecat: Double;
    function  GetVlrSecatP: Double;
    function  GetDatPed: TDate;
    function  GetNumNF: Integer;
    function  GetFkSaler: Integer;
    function  GetNomSol: string;
    function  GetFkAddressee: TOwner;
    function  GetFkShipper: TOwner;
    function  GetDocAddressee: string;
    function  GetDocShipper: string;
    function  GetDocConsignee: string;
    function  GetFkConsignee: TOwner;
    function  GetTypeCustomer: smallint;
    function  GetVolumeToWeight: Double;
    function  GetFlagES: TInOut;
    function  GetCarrierWeights: TCarrierWeights;
    function  GetFlagRemb: Boolean;
    function  GetFkEstados(ALocal: Integer): string;
    function  GetFkMunicipios(ALocal: Integer): Integer;
    function  GetFkPaises(ALocal: Integer): Integer;
    function  CheckCustomerData(ATypeCarrier: TTypeCarrier): Boolean;
    procedure SetAlqtICMS(const Value: Double);
    procedure SetBasICMS(const Value: Double);
    procedure SetFkParceiro(const Value: Integer);
    procedure SetFkProdutos(const Value: TProducts);
    procedure SetFkTypeTable(const Value: TTypeTable);
    procedure SetFreVlr(const Value: Double);
    procedure SetFreVlrP(const Value: Double);
    procedure SetObsPed(const Value: TStrings);
    procedure SetPkPedidosFretes(const Value: Integer);
    procedure SetQtdProd(const Value: Double);
    procedure SetTotPed(const Value: Double);
    procedure SetTotPedP(const Value: Double);
    procedure SetVlrAcrDsct(const Value: Double);
    procedure SetVlrDifAcc(const Value: Double);
    procedure SetVlrDifAccP(const Value: Double);
    procedure SetVlrFrePeso(const Value: Double);
    procedure SetVlrFrePesoP(const Value: Double);
    procedure SetVlrGris(const Value: Double);
    procedure SetVlrGrisP(const Value: Double);
    procedure SetVlrICMS(const Value: Double);
    procedure SetVlrNF(const Value: Double);
    procedure SetVlrPedg(const Value: Double);
    procedure SetVlrPedgP(const Value: Double);
    procedure SetVlrSecat(const Value: Double);
    procedure SetVlrSecatP(const Value: Double);
    procedure SetDocumentType(const Value: TDocumentType);
    procedure LoadProducts;
    procedure LoadPriceTables;
    procedure LoadSalers;
    procedure LoadPartners;
    procedure LoadLocales(ACombo: TPrcComboBox; const ALocale: TTypeLocale;
                const AFkCountry: Integer = 0; const AFkState: string = '');
    procedure SetFkDestination(const Value: Integer);
    procedure SetFkOrigin(const Value: Integer);
    procedure SetDtaPed(const Value: TDate);
    procedure SetNumNF(const Value: Integer);
    procedure SetFkSaler(const Value: Integer);
    procedure SetNomSol(const Value: string);
    procedure SetCalcOrder(const Value: Boolean);
    procedure SetCarrierPrice(const Value: TCarrierPrice);
    procedure SetCarrierPriceP(const Value: TCarrierPrice);
    procedure SetFkPartnerOrgDst;
    procedure SetFkAddressee(const Value: TOwner);
    procedure SetFkShipper(const Value: TOwner);
    procedure SetDocAddressee(const Value: string);
    procedure SetDocShipper(const Value: string);
    procedure SetMaskToControl(ALabel: TStaticText; const AIdx, AField: Integer);
    procedure SetDocConsignee(const Value: string);
    procedure SetFkConsignee(const Value: TOwner);
    procedure SetTypeCustomer(const Value: smallint);
    procedure SetFlagCustomer(const ATypeCarrier: TTypeCarrier);
    procedure InsertMeasureBlankNode;
    procedure SetCarrierWeights(const Value: TCarrierWeights);
    procedure SetFlagES(const Value: TInOut);
    procedure SetFlagRemb(const Value: Boolean);
    procedure SetFkEstados(ALocal: Integer; const Value: string);
    procedure SetFkMunicipios(ALocal: Integer; const Value: Integer);
    procedure SetFkPaises(ALocal: Integer; const Value: Integer);
    function GetQtdVol: Integer;
    procedure SetQtdVol(const Value: Integer);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    property  FkPaises    [ALocal: Integer]: Integer read GetFkPaises     write SetFkPaises;
    property  FkEstados   [ALocal: Integer]: string  read GetFkEstados    write SetFkEstados;
    property  FkMunicipios[ALocal: Integer]: Integer read GetFkMunicipios write SetFkMunicipios;
  public
    { Public declarations }
    property  PkPedidosFretes: Integer         read GetPkPedidosFretes write SetPkPedidosFretes;
    property  FkTypeTable    : TTypeTable      read GetFkTypeTable     write SetFkTypeTable;
    property  FkParceiro     : Integer         read GetFkParceiro      write SetFkParceiro;
    property  FkOrigin       : Integer         read FFkOrigin          write SetFkOrigin;
    property  FkDestination  : Integer         read FFkDestination     write SetFkDestination;
    property  FkSaler        : Integer         read GetFkSaler         write SetFkSaler;
    property  FkAddressee    : TOwner          read GetFkAddressee     write SetFkAddressee;
    property  FkShipper      : TOwner          read GetFkShipper       write SetFkShipper;
    property  FkConsignee    : TOwner          read GetFkConsignee     write SetFkConsignee;
    property  FlagES         : TInOut          read GetFlagES          write SetFlagES;
    property  FlagRemb       : Boolean         read GetFlagRemb        write SetFlagRemb;
    property  DtaPed         : TDate           read GetDatPed          write SetDtaPed;
    property  VlrNF          : Double          read GetVlrNF           write SetVlrNF;
    property  NumNF          : Integer         read GetNumNF           write SetNumNF;
    property  NomSol         : string          read GetNomSol          write SetNomSol;
    property  VlrFrePeso     : Double          read GetVlrFrePeso      write SetVlrFrePeso;
    property  FreVlr         : Double          read GetFreVlr          write SetFreVlr;
    property  VlrSecat       : Double          read GetVlrSecat        write SetVlrSecat;
    property  VlrDifAcc      : Double          read GetVlrDifAcc       write SetVlrDifAcc;
    property  VlrPedg        : Double          read GetVlrPedg         write SetVlrPedg;
    property  VlrGris        : Double          read GetVlrGris         write SetVlrGris;
    property  BasICMS        : Double          read GetBasICMS         write SetBasICMS;
    property  AlqtICMS       : Double          read GetAlqtICMS        write SetAlqtICMS;
    property  VlrICMS        : Double          read GetVlrICMS         write SetVlrICMS;
    property  SubTot         : Double          read FSubTot;
    property  TotPed         : Double          read GetTotPed          write SetTotPed;
    property  VlrFrePesoP    : Double          read GetVlrFrePesoP     write SetVlrFrePesoP;
    property  FreVlrP        : Double          read GetFreVlrP         write SetFreVlrP;
    property  VlrSecatP      : Double          read GetVlrSecatP       write SetVlrSecatP;
    property  VlrDifAccP     : Double          read GetVlrDifAccP      write SetVlrDifAccP;
    property  VlrPedgP       : Double          read GetVlrPedgP        write SetVlrPedgP;
    property  VlrGrisP       : Double          read GetVlrGrisP        write SetVlrGrisP;
    property  TotPedP        : Double          read GetTotPedP         write SetTotPedP;
    property  FkProdutos     : TProducts       read GetFkProdutos      write SetFkProdutos;
    property  CarrierWeights : TCarrierWeights read GetCarrierWeights  write SetCarrierWeights;
    property  QtdProd        : Double          read GetQtdProd         write SetQtdProd;
    property  QtdVol         : Integer         read GetQtdVol          write SetQtdVol;
    property  VlrAcrDsct     : Double          read GetVlrAcrDsct      write SetVlrAcrDsct;
    property  ObsPed         : TStrings        read GetObsPed          write SetObsPed;
    property  DocumentType   : TDocumentType   read FDocumentType      write SetDocumentType;
    property  CalcOrder      : Boolean         read FCalcOrder         write SetCalcOrder;
    property  CarrierPrice   : TCarrierPrice   read FCarrierPrice      write SetCarrierPrice;
    property  CarrierPriceP  : TCarrierPrice   read FCarrierPriceP     write SetCarrierPriceP;
    property  FkPartnerOrgDst: Integer         read FFkPartnerOrgDst;
    property  DocAddresse    : string          read GetDocAddressee    write SetDocAddressee;
    property  DocConsignee   : string          read GetDocConsignee    write SetDocConsignee;
    property  DocShipper     : string          read GetDocShipper      write SetDocShipper;
    property  TypeCustomer   : smallint        read GetTypeCustomer    write SetTypeCustomer;
    property  VolumeToWeight : Double          read GetVolumeToWeight;
  end;

var
  CdSimulator: TCdSimulator;

implementation

{$R *.dfm}

uses Dado, GridRow, ProcType, Funcoes, FuncoesDB, DB, ArqSqlTrans, Math,
  TSysPed;

{ TfrmSimulator }

const
  LABEL_CAPTION: array[0..1] of string = ('C.N.P.J.', 'C.P.F.');

function TCdSimulator.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C: TControl;
  S: string;
const
//  TDocumentType  = (dtSimulator, dtDocument, dtOrderToDoc);
  SHIPPER_ORIGIN       : array [TDocumentType] of string =
    ('Origem deve ser informada', 'Remetente deve ser informado', 'Remetente deve ser informado');
  ADDRESSEE_DESTINATION: array [TDocumentType] of string =
    ('Destino deve ser informado', 'Destinantário deve ser informado', 'Destinantário deve ser informado');
begin
  Result := True;
  C := nil;
  S := '';
  if (DocumentType <> dtSimulator) then
  begin
    if (FkProdutos <> nil) then
      Result := CheckCustomerData(FkProdutos.ProductService.ProductCarrier.FlagTCarrier);
    if (not Result) then exit;
  end;
  if (FkOrigin = 0) then
  begin
    if (DocumentType = dtSimulator) then
      C := gbOrigin
    else
      C := gbShipper;
    S := SHIPPER_ORIGIN[DocumentType];
  end;
  if (FkDestination = 0) then
  begin
    if (DocumentType = dtSimulator) then
      C := gbDestination
    else
      C := gbAddressee;
    S := ADDRESSEE_DESTINATION[DocumentType];
  end;
  if (FkProdutos = nil) or (FkProdutos.PkProducts = 0) then
  begin
    C := eFk_Produtos;
    S := 'Campo tipo de frete deve ser informado';
  end;
  if (FkTypeTable = nil) or (FkTypeTable.PkCalcOrgmDstn = 0) or
     (FkTypeTable.PkPriceTable = 0) or (FkTypeTable.PkTypeFraction = 0) then
  begin
    C := eFk_Tabela_Precos;
    S := 'Campo tabela de preços deve ser informado';
  end;
  if (VlrNF = 0) then
  begin
    C := eVlr_NF;
    S := 'Campo valor da Nota Fiscal deve ser informado';
  end;
  if (QtdProd = 0) then
  begin
    C := eQtd_Prod;
    S := 'Campo quantidade deve ser informado';
  end;
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S, hiError);
    Result := False;
  end;
end;

procedure TCdSimulator.ClearControls;
begin
  Loading := True;
  try
    PkPedidosFretes := 0;
    FkTypeTable     := nil;
    FkParceiro      := 0;
    VlrNF           := 0.0;
    VlrFrePeso      := 0.0;
    FreVlr          := 0.0;
    VlrSecat        := 0.0;
    VlrDifAcc       := 0.0;
    VlrPedg         := 0.0;
    VlrGris         := 0.0;
    BasICMS         := 0.0;
    AlqtICMS        := 0.0;
    VlrICMS         := 0.0;
    TotPed          := 0.0;
    VlrFrePesoP     := 0.0;
    FreVlrP         := 0.0;
    VlrSecatP       := 0.0;
    VlrDifAccP      := 0.0;
    VlrPedgP        := 0.0;
    VlrGrisP        := 0.0;
    TotPedP         := 0.0;
    FkProdutos      := nil;
    QtdProd         := 0.0;
    VlrAcrDsct      := 0.0;
    FlagES          := ioIn;
    ObsPed          := nil;
    CarrierWeights  := nil;
    FkAddressee     := nil;
    FkShipper       := nil;
    FkConsignee     := nil;
  finally
    Loading := False;
  end;
end;

function TCdSimulator.GetAlqtICMS: Double;
begin
  Result := eAlqt_ICMS.Value;
end;

function TCdSimulator.GetBasICMS: Double;
begin
  Result := eBas_ICMS.Value;
end;

function TCdSimulator.GetFkParceiro: Integer;
begin
  Result := 0;
  with eFk_Parceiro do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOwner(Items.Objects[ItemIndex]).PkCadastros;
end;

function TCdSimulator.GetFkProdutos: TProducts;
begin
  Result := nil;
  with eFk_Produtos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TProducts(Items.Objects[ItemIndex]);
end;

function TCdSimulator.GetFkTypeTable: TTypeTable;
begin
  Result := nil;
  with eFk_Tabela_Precos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypeTable(Items.Objects[ItemIndex]);
end;

function TCdSimulator.GetFreVlr: Double;
begin
  Result := eFre_Vlr.Value;
end;

function TCdSimulator.GetFreVlrP: Double;
begin
  Result := eFre_Vlr_P.Value;
end;

function TCdSimulator.GetObsPed: TStrings;
begin
  Result := eObs_Ped.Lines;
end;

function TCdSimulator.GetPkPedidosFretes: Integer;
var
  S, S1: string;
  i    : Integer;
begin
  S := Trim(ePk_Pedidos_Fretes.Caption);
  for i := 0 to Length(S) - 1 do
    if (S[i] in ['0'..'9']) then
      S1 := S1 + S[i];
  Result := StrToIntDef(S1, 0);
end;

function TCdSimulator.GetQtdProd: Double;
begin
  Result := eQtd_Prod.Value;
end;

function TCdSimulator.GetTotPed: Double;
begin
  Result := eTot_Ped.Value;
end;

function TCdSimulator.GetTotPedP: Double;
begin
  Result := eTot_Ped_P.Value;
end;

function TCdSimulator.GetVlrAcrDsct: Double;
begin
  Result := eVlr_Acr_Dsct.Value;
end;

function TCdSimulator.GetVlrDifAcc: Double;
begin
  Result := eVlr_Dif_Acc.Value;
end;

function TCdSimulator.GetVlrDifAccP: Double;
begin
  Result := eVlr_Dif_Acc_P.Value;
end;

function TCdSimulator.GetVlrFrePeso: Double;
begin
  Result := eVlr_Fre_Peso.Value;
end;

function TCdSimulator.GetVlrFrePesoP: Double;
begin
  Result := eVlr_Fre_Peso_P.Value;
end;

function TCdSimulator.GetVlrGris: Double;
begin
  Result := eVlr_Gris.Value;
end;

function TCdSimulator.GetVlrGrisP: Double;
begin
  Result := eVlr_Gris_P.Value;
end;

function TCdSimulator.GetVlrICMS: Double;
begin
  Result := eVlr_ICMS.Value;
end;

function TCdSimulator.GetVlrNF: Double;
begin
  Result := eVlr_NF.Value;
end;

function TCdSimulator.GetVlrPedg: Double;
begin
  Result := eVlr_Pedg.Value;
end;

function TCdSimulator.GetVlrPedgP: Double;
begin
  Result := eVlr_Pedg_P.Value;
end;

function TCdSimulator.GetVlrSecat: Double;
begin
  Result := eVlr_Secat.Value;
end;

function TCdSimulator.GetVlrSecatP: Double;
begin
  Result := eVlr_Secat_P.Value;
end;

procedure TCdSimulator.LoadDefaults;
var
  aFk: Integer;
begin
  aFk := 0;
  if (not ListLoaded) then
  begin
    LoadProducts;
    LoadSalers;
    LoadPartners;
    LoadLocales(eFkPaisesOrgm, toCountry);
    if (eFkPaisesOrgm.Items.Count = 2) then
    begin
      with eFkPaisesOrgm do
      begin
        ItemIndex := 1;
        if (Items.Objects[ItemIndex] <> nil) then
          aFk := TCountry(Items.Objects[ItemIndex]).PKCountry;
      end;
      if (aFk > 0) then
        LoadLocales(eFkEstadosOrgm, toState, aFk);
    end;
    LoadLocales(eFkPaisesDstn, toCountry);
    if (eFkPaisesDstn.Items.Count = 2) then
    begin
      with eFkPaisesDstn do
      begin
        ItemIndex := 1;
        if (Items.Objects[ItemIndex] <> nil) then
          aFk := TCountry(Items.Objects[ItemIndex]).PKCountry;
      end;
      if (aFk > 0) then
        LoadLocales(eFkEstadosDstn, toState, aFk);
    end;
    ListLoaded := True;
  end;
end;

procedure TCdSimulator.MoveDataToControls;
var
  aItem: TCarrierOrder;
begin
  aItem := nil;
  Loading := True;
  try
    case DocumentType of
      dtSimulator : aItem := dmSysTrans.CarrierOrder[Pk];
      dtDocument  : aItem := dmSysTrans.CarrierDocument[Pk];
    end;
    if (aItem = nil) then
      raise Exception.Create('MoveDataToControls: Erro ao buscar os detalhes do conhecimento (nil)!!');
    PkPedidosFretes := aItem.Order.PkOrder;
    if (DocumentType = dtSimulator) then
    begin
      FkPaises[0]     := aItem.CityOrigim.FkState.FkCountry.PKCountry;
      FkEstados[0]    := aItem.CityOrigim.FkState.PkState;
      FkMunicipios[0] := aItem.CityOrigim.PkCity;
      FkPaises[1]     := aItem.CityDestination.FkState.FkCountry.PKCountry;
      FkEstados[1]    := aItem.CityDestination.FkState.PkState;
      FkMunicipios[1] := aItem.CityDestination.PkCity;
    end;
    if (aItem.FkAddressee > 0) then
      SetFkAddressee(dmSysTrans.LoadCustomerFromDoc(aItem.FkAddressee));
    if (aItem.FkShipper > 0) then
      SetFkShipper(dmSysTrans.LoadCustomerFromDoc(aItem.FkShipper));
    if (aItem.FkConsignee > 0) then
      SetFkConsignee(dmSysTrans.LoadCustomerFromDoc(aItem.FkConsignee));
    FkProdutos      := aItem.FkProduct;
    FkTypeTable     := aItem.TypeTable;
    FkParceiro      := aItem.CarrierPartner.FKPartner;
    FkSaler         := aItem.Order.FkVendor.PkCadastros;
    DtaPed          := aItem.Order.DtaPed;
    NomSol          := aItem.Order.NomCad;
    NumNF           := aItem.NumNF;
    VlrNF           := aItem.VlrNf;
    VlrFrePeso      := aItem.VlrFrePeso;
    FreVlr          := aItem.FreVlr;
    VlrSecat        := aItem.VlrSecat;
    VlrDifAcc       := aItem.VlrDifAcc;
    VlrPedg         := aItem.VlrPedg;
    VlrGris         := aItem.VlrGris;
    BasICMS         := aItem.Order.BasIcms;
    VlrICMS         := aItem.Order.VlrIcms;
    FSubTot         := aItem.Order.SubTot;
    TotPed          := aItem.Order.VlrFret;
    VlrAcrDsct      := aItem.Order.DsctFret;
    QtdProd         := aItem.QtdProd;
    QtdVol          := aItem.Order.QtdVol;
    if (aItem.CarrierPartner.FKPartner > 0) then
    begin
      VlrFrePesoP   := aItem.CarrierPartner.VlrFrePeso;
      FreVlrP       := aItem.CarrierPartner.FreVlr;
      VlrSecatP     := aItem.CarrierPartner.VlrSecat;
      VlrDifAccP    := aItem.CarrierPartner.VlrDifAcc;
      VlrPedgP      := aItem.CarrierPartner.VlrPedg;
      VlrGrisP      := aItem.CarrierPartner.VlrGris;
      TotPedP       := aItem.CarrierPartner.TotFre;
    end;
    VlrAcrDsct      := aItem.Order.VlrAcrDsct;
    if (aItem.Order.OrderMessages.Count > 0) then
      ObsPed        := aItem.Order.OrderMessages.Items[0].TextMsg;
    CarrierWeights  := aItem.CarrierWeights;
  finally
    Loading := False;
  end;
end;

procedure TCdSimulator.SaveIntoDB;
var
  aItem: TCarrierOrder;
  aAlq : TTaxDescription;
begin
  CalcOrder := True;
  aItem := TCarrierOrder.Create(Dados.DecimalPlaces);
  try
    aItem.Order.PkOrder               := PkPedidosFretes;
    aItem.FkProduct                   := FkProdutos;
    aItem.TypeTable                   := FkTypeTable;
    aItem.Order.FkPriceTable.PkPriceTable := FkTypeTable.PkPriceTable;
    aItem.CarrierPartner.FKPartner    := FkParceiro;
    aItem.NumNf                       := NumNF;
    aItem.VlrNf                       := VlrNF;
    aItem.VlrFrePeso                  := VlrFrePeso;
    aItem.FreVlr                      := FreVlr;
    aItem.VlrSecat                    := VlrSecat;
    aItem.VlrDifAcc                   := VlrDifAcc;
    aItem.VlrPedg                     := VlrPedg;
    aItem.VlrGris                     := VlrGris;
    aItem.FlagES                      := FlagES;
    aItem.FlagRemb                    := FlagRemb;
    aItem.Order.NomCad                := NomSol;
    aItem.Order.VlrFret               := TotPed;
    aItem.Order.DsctFret              := VlrAcrDsct;
    aItem.Order.FkVendor.PkCadastros  := FkSaler;
    aItem.Order.DtaPed                := DtaPed;
    aItem.Order.QtdVol                := QtdVol;
//    aItem.Order.BasIcms              := BasICMS; ReadOnly
//    aItem.Order.VlrIcms              := VlrICMS; ReadOnly
    aItem.Order.FkOwner.PkCadastros   := 0;
    if (aItem.FkProduct.ProductService.ProductCarrier.FlagTCarrier = tcCif) and
       (FkShipper.PkCadastros > 0) then
    begin
      aItem.Order.FkOwner.PkCadastros := FkShipper.PkCadastros;
      aItem.Order.FkTypePayment       := FkShipper.Customer.FkTypePayment;
    end;
    if (aItem.FkProduct.ProductService.ProductCarrier.FlagTCarrier = tcFob) and
       (FkAddressee.PkCadastros > 0) then
    begin
      aItem.Order.FkOwner.PkCadastros := FkAddressee.PkCadastros;
      aItem.Order.FkTypePayment       := FkAddressee.Customer.FkTypePayment;
    end;
    if (FkConsignee.PkCadastros > 0) then
    begin
      aItem.Order.FkOwner.PkCadastros := FkConsignee.PkCadastros;
      aItem.Order.FkTypePayment       := FkConsignee.Customer.FkTypePayment;
    end;
    aItem.FkAddressee                 := FkAddressee.PkCadastros;
    aItem.FkShipper                   := FkShipper.PkCadastros;
    aItem.FkConsignee                 := FkConsignee.PkCadastros;
    if (FkShipper.PkCadastros = 0) then
    begin
      aItem.CityOrigim.FkState.FkCountry.PKCountry      := FkPaises[0];
      aItem.CityOrigim.FkState.PkState                  := FkEstados[0];
      aItem.CityOrigim.PkCity                           := FkMunicipios[0];
      aItem.CityOrigim.DscMun                           := lRegionOrgm.Caption;
    end
    else
    begin
      aItem.CityOrigim.FkState.FkCountry.PKCountry      := FkShipper.Address.FkCity.FkState.FkCountry.PKCountry;
      aItem.CityOrigim.FkState.PkState                  := FkShipper.Address.FkCity.FkState.PkState;
      aItem.CityOrigim.PkCity                           := FkShipper.Address.FkCity.PkCity;
      aItem.CityOrigim.DscMun                           := lRegionOrgm.Caption;
    end;
    if (FkAddressee.PkCadastros = 0) then
    begin
      aItem.CityDestination.FkState.FkCountry.PKCountry := FkPaises[1];
      aItem.CityDestination.FkState.PkState             := FkEstados[1];
      aItem.CityDestination.PkCity                      := FkMunicipios[0];
      aItem.CityDestination.DscMun                      := lRegionOrgm.Caption;
    end
    else
    begin
      aItem.CityOrigim.FkState.FkCountry.PKCountry      := FkAddressee.Address.FkCity.FkState.FkCountry.PKCountry;
      aItem.CityOrigim.FkState.PkState                  := FkAddressee.Address.FkCity.FkState.PkState;
      aItem.CityOrigim.PkCity                           := FkAddressee.Address.FkCity.PkCity;
      aItem.CityOrigim.DscMun                           := lRegionDstn.Caption;
    end;
    if (aItem.CarrierPartner.FKPartner > 0) then
    begin
      aItem.CarrierPartner.VlrFrePeso := VlrFrePesoP;
      aItem.CarrierPartner.FreVlr     := FreVlrP;
      aItem.CarrierPartner.VlrSecat   := VlrSecatP;
      aItem.CarrierPartner.VlrDifAcc  := VlrDifAccP;
      aItem.CarrierPartner.VlrPedg    := VlrPedgP;
      aItem.CarrierPartner.VlrGris    := VlrGrisP;
      aItem.CarrierPartner.TotFre     := TotPedP;
    end;
    with aItem.Order.OrderItems.Add do
    begin
      aAlq.TaxCode := 0;
      aAlq.TaxPercent := AlqtICMS;
      AlqIcms   := aAlq;
      FkProduct := FkProdutos;
      QtdItem   := QtdProd;
      if (QtdProd > 0) then
        VlrUnit := TotPed / QtdProd;
    end;
    if (ObsPed <> nil) and (ObsPed.Text <> '') then
      with aItem.Order.OrderMessages.Add do
        TextMsg := ObsPed;
    aItem.CarrierWeights := CarrierWeights;
    case DocumentType of
      dtSimulator : dmSysTrans.CarrierOrder[Ord(ScrState)]    := aItem;
      dtDocument  : dmSysTrans.CarrierDocument[Ord(ScrState)] := aItem;
      dtOrderToDoc: dmSysTrans.OrderToDocument[Pk]            := aItem;
    end;
    PkPedidosFretes := aItem.Order.PkOrder;
    PkAux := aItem.Order.PkOrder;
  finally
    FreeAndNil(aItem);
  end;
end;

procedure TCdSimulator.SetAlqtICMS(const Value: Double);
begin
  eAlqt_ICMS.Value := Value;
end;

procedure TCdSimulator.SetBasICMS(const Value: Double);
begin
  eBas_ICMS.Value := Value;
end;

procedure TCdSimulator.SetFkParceiro(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Parceiro do
  begin
    ItemIndex := -1;
    if (Value = 0) then exit;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdSimulator.SetFkProdutos(const Value: TProducts);
var
  i: Integer;
begin
  with eFk_Produtos do
  begin
    ItemIndex := -1;
    if (Value = nil) then exit;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Value.PkProducts = TProducts(Items.Objects[i]).PkProducts )then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdSimulator.SetFkTypeTable(const Value: TTypeTable);
var
  i: Integer;
begin
  with eFk_Tabela_Precos do
  begin
    ItemIndex := -1;
    if (Value = nil) then exit;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         ((Value.PkPriceTable = TTypeTable(Items.Objects[i]).PkPriceTable) and
         (Value.PkTypeFraction = TTypeTable(Items.Objects[i]).PkTypeFraction)) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdSimulator.SetFreVlr(const Value: Double);
begin
  eFre_Vlr.Value := Value;
end;

procedure TCdSimulator.SetFreVlrP(const Value: Double);
begin
  eFre_Vlr_P.Value := Value;
end;

procedure TCdSimulator.SetObsPed(const Value: TStrings);
begin
  if (Value <> nil) then
    eObs_Ped.Lines.Assign(Value)
  else
    eObs_Ped.Lines.Clear;
end;

procedure TCdSimulator.SetPkPedidosFretes(const Value: Integer);
begin
  ePk_Pedidos_Fretes.Caption := 'Nº: '  + IntToStr(Value);
end;

procedure TCdSimulator.SetQtdProd(const Value: Double);
begin
  eQtd_Prod.Value := Value;
end;

procedure TCdSimulator.SetTotPed(const Value: Double);
begin
  eTot_Ped.Value := Value;
end;

procedure TCdSimulator.SetTotPedP(const Value: Double);
begin
  eTot_Ped_P.Value := Value;
end;

procedure TCdSimulator.SetVlrAcrDsct(const Value: Double);
begin
  eVlr_Acr_Dsct.Value := Value;
end;

procedure TCdSimulator.SetVlrDifAcc(const Value: Double);
begin
  eVlr_Dif_Acc.Value := Value;
end;

procedure TCdSimulator.SetVlrDifAccP(const Value: Double);
begin
  eVlr_Dif_Acc_P.Value := Value;
end;

procedure TCdSimulator.SetVlrFrePeso(const Value: Double);
begin
  eVlr_Fre_Peso.Value := Value;
end;

procedure TCdSimulator.SetVlrFrePesoP(const Value: Double);
begin
  eVlr_Fre_Peso_P.Value := Value;
end;

procedure TCdSimulator.SetVlrGris(const Value: Double);
begin
  eVlr_Gris.Value := Value;
end;

procedure TCdSimulator.SetVlrGrisP(const Value: Double);
begin
  eVlr_Gris_P.Value := Value;
end;

procedure TCdSimulator.SetVlrICMS(const Value: Double);
begin
  eVlr_ICMS.Value := Value;
end;

procedure TCdSimulator.SetVlrNF(const Value: Double);
begin
  eVlr_NF.Value := Value;
end;

procedure TCdSimulator.SetVlrPedg(const Value: Double);
begin
  eVlr_Pedg.Value := Value;
end;

procedure TCdSimulator.SetVlrPedgP(const Value: Double);
begin
  eVlr_Pedg_P.Value := Value;
end;

procedure TCdSimulator.SetVlrSecat(const Value: Double);
begin
  eVlr_Secat.Value := Value;
end;

procedure TCdSimulator.SetVlrSecatP(const Value: Double);
begin
  eVlr_Secat_P.Value := Value;
end;

procedure TCdSimulator.FormCreate(Sender: TObject);
begin
  pgOrgmDstn.Images           := Dados.Image16;
  pgCalc.Images               := Dados.Image16;
  pgCalcCarrier.Images        := Dados.Image16;
  cbOperSchedule.Images       := Dados.Image16;
  tbOperSchedule.Images       := Dados.Image16;
  vtMeasure.NodeDataSize      := SizeOf(TGridData);
  vtMeasure.Images            := Dados.Image16;
  vtMeasure.Header.Images     := Dados.Image16;
  vtSchedule.NodeDataSize     := SizeOf(TGridData);
  vtSchedule.Images           := Dados.Image16;
  vtSchedule.Header.Images    := Dados.Image16;
  FFkShipper                  := TOwner.Create;
  FFkAddressee                := TOwner.Create;
  FFkConsignee                := TOwner.Create;
  pgCalc.ActivePageIndex      := 0;
  inherited;
  OnCheckRecord               := CheckRecord;
  OnInternalState             := ChangeState;
end;

procedure TCdSimulator.SetDocumentType(const Value: TDocumentType);
begin
  FDocumentType            := Value;
  tsSelOrgmDstn.TabVisible := (FDocumentType = dtSimulator);
  tsSelRemDstn.TabVisible  := True;
  tsSchedule.TabVisible    := (FDocumentType = dtDocument);
  if (FDocumentType = dtSimulator) then
    pgOrgmDstn.ActivePage  := tsSelOrgmDstn
  else
    pgOrgmDstn.ActivePage  := tsSelRemDstn;
end;

procedure TCdSimulator.LoadLocales(ACombo: TPrcComboBox; const ALocale: TTypeLocale;
  const AFKCountry: Integer = 0; const AFkState: string = '');
begin
  case ALocale of
    toCountry: ACombo.Items.AddStrings(dmSysTrans.LoadCountry);
    toState  : ACombo.Items.AddStrings(dmSysTrans.LoadState(AFkCountry));
    toCity   : ACombo.Items.AddStrings(dmSysTrans.LoadCity(AFkCountry, AFkState));
  end;
end;

procedure TCdSimulator.LoadPartners;
begin
  ReleaseCombos(eFk_Parceiro, toObject);
  eFk_Parceiro.Items.AddStrings(dmSysTrans.LoadPartners);
end;

procedure TCdSimulator.LoadPriceTables;
begin
  ReleaseCombos(eFk_Tabela_Precos, toObject);
  eFk_Tabela_Precos.Items.AddStrings(dmSysTrans.LoadPriceTable(FkOrigin, FkDestination));
  if (eFk_Tabela_Precos.Items.Count > 1) then
    Dados.DisplayHint(eFk_Tabela_Precos, 'Região de Origem: ' + IntToStr(FkOrigin) +
      ' - ' + lRegionOrgm.Caption + NL + 'Região de Destino: ' + IntToStr(FkDestination) +
      ' - ' + lRegionDstn.Caption, hiInformation, 'Seleção das tabelas de preços');
end;

procedure TCdSimulator.LoadProducts;
begin
  ReleaseCombos(eFk_Produtos, toObject);
  eFk_Produtos.Items.AddStrings(dmSysTrans.LoadProducts);
  SetFlagCustomer(tcSuppDelivery);
end;

procedure TCdSimulator.LoadSalers;
begin
  ReleaseCombos(eFk_Vendedores, toObject);
  eFk_Vendedores.Items.AddStrings(dmSysTrans.LoadSalers);
end;

procedure TCdSimulator.FormDestroy(Sender: TObject);
begin
  if Assigned(FFkShipper) then
    FFkShipper.Free;
  if Assigned(FFkAddressee) then
    FFkAddressee.Free;
  if Assigned(FFkConsignee) then
    FFkConsignee.Free;
  FFkShipper   := nil;
  FFkAddressee := nil;
  FFkConsignee := nil;
  ReleaseCombos(eFk_Tabela_Precos, toObject);
  eFkPaisesOrgm.ReleaseObjects;
  eFkEstadosOrgm.ReleaseObjects;
  eFkMunicipiosOrgm.ReleaseObjects;
  eFkPaisesDstn.ReleaseObjects;
  eFkEstadosDstn.ReleaseObjects;
  eFkMunicipiosDstn.ReleaseObjects;
end;

procedure TCdSimulator.eFkPaisesOrgmSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  eFkEstadosOrgm.ReleaseObjects;
  with eFkPaisesOrgm do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      LoadLocales(eFkEstadosOrgm, toState, TCountry(Items.Objects[ItemIndex]).PKCountry);
end;

procedure TCdSimulator.eFkEstadosOrgmSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  eFkMunicipiosOrgm.ReleaseObjects;
  with eFkEstadosOrgm do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
    begin
      LoadLocales(eFkMunicipiosOrgm, toCity,
        TState(Items.Objects[ItemIndex]).FkCountry.PKCountry,
        TState(Items.Objects[ItemIndex]).PkState);
      if (TState(Items.Objects[ItemIndex]).FkRegions > 0) then
        FkOrigin := TState(Items.Objects[ItemIndex]).FkRegions;
    end;
end;

procedure TCdSimulator.eFkMunicipiosOrgmSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFkMunicipiosOrgm do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) and
       (TCity(Items.Objects[ItemIndex]).FkRegions > 0) then
      FkOrigin := TCity(Items.Objects[ItemIndex]).FkRegions;
end;

procedure TCdSimulator.eFkPaisesDstnSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  eFkEstadosDstn.ReleaseObjects;
  with eFkPaisesDstn do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      LoadLocales(eFkEstadosDstn, toState, TCountry(Items.Objects[ItemIndex]).PKCountry);
end;

procedure TCdSimulator.eFkEstadosDstnSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  eFkMunicipiosDstn.ReleaseObjects;
  with eFkEstadosDstn do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
    begin
      LoadLocales(eFkMunicipiosDstn, toCity,
        TState(Items.Objects[ItemIndex]).FkCountry.PKCountry,
        TState(Items.Objects[ItemIndex]).PkState);
      if (TState(Items.Objects[ItemIndex]).FkRegions > 0) then
        FkDestination := TState(Items.Objects[ItemIndex]).FkRegions;
    end;
end;

procedure TCdSimulator.eFkMunicipiosDstnSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFkMunicipiosDstn do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) and
       (TCity(Items.Objects[ItemIndex]).FkRegions > 0) then
      FkDestination := TCity(Items.Objects[ItemIndex]).FkRegions;
end;

procedure TCdSimulator.SetFkDestination(const Value: Integer);
begin
  FFkDestination := Value;
  lRegionDstn.Caption := dmSysTrans.LoadRegion(FFkDestination);
  if (FFkDestination > 0) and (FFkOrigin > 0) then
    LoadPriceTables;
end;

procedure TCdSimulator.SetFkOrigin(const Value: Integer);
begin
  FFkOrigin := Value;
  lRegionOrgm.Caption := dmSysTrans.LoadRegion(FFkOrigin);
  if (FFkDestination > 0) and (FFkOrigin > 0) then
    LoadPriceTables;
end;

procedure TCdSimulator.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  if (AState = dbmInsert) then
  begin
    DtaPed := Date;
    if (vtMeasure.RootNodeCount = 0) then
      InsertMeasureBlankNode;
  end;
end;

function TCdSimulator.GetDatPed: TDate;
begin
  Result := eDta_Ped.Date;
end;

procedure TCdSimulator.SetDtaPed(const Value: TDate);
begin
  if (Value = 0) then
    eDta_Ped.Clear
  else
    eDta_Ped.Date := Value;
end;

function TCdSimulator.GetNumNF: Integer;
begin
  Result := eNum_NF.AsInteger;
end;

procedure TCdSimulator.SetNumNF(const Value: Integer);
begin
  eNum_NF.AsInteger := Value;
end;

function TCdSimulator.GetFkSaler: Integer;
begin
  Result := 0;
  with eFk_Vendedores do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

procedure TCdSimulator.SetFkSaler(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Vendedores do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count -1 do
      if (Items.Objects[i] <> nil) and
         (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

function TCdSimulator.GetNomSol: string;
begin
  Result := eNomSol.Text;
end;

procedure TCdSimulator.SetNomSol(const Value: string);
begin
  eNomSol.Text := Value;
end;

procedure TCdSimulator.SetCalcOrder(const Value: Boolean);
var
  aFkCustomer : TOwner;
  aFkAddressee: integer;
  aTypeCstm   : smallint;
begin
  FCalcOrder := Value;
  if (not CheckRecord(ScrState, ScrState)) then exit;
  aFkCustomer := TOwner.Create;
  try
    if (FFkConsignee <> nil) and (FFkConsignee.PkCadastros > 0) then
      aFkCustomer.Assign(FFkConsignee)
    else
      if (FkProdutos.ProductService.ProductCarrier.FlagTCarrier = tcCIF) and
         (FFkShipper <> nil) and (FFkShipper.PkCadastros > 0) then
        aFkCustomer.Assign(FFkShipper)
      else
        if (FkProdutos.ProductService.ProductCarrier.FlagTCarrier = tcFOB) and
           (FFkAddressee <> nil) and (FFkAddressee.PkCadastros > 0) then
          aFkCustomer.Assign(FFkAddressee);
    aTypeCstm := TypeCustomer;
    if (aFkCustomer <> nil) and (aFkCustomer.PkCadastros > 0) then
    begin
      if (aFkCustomer.FlagTCad <= toPeople) then
        aTypeCstm := Ord(aFkCustomer.FlagTCad)
    end;
    if (FFkAddressee = nil) then
      aFkAddressee := 0
    else
      aFkAddressee := FFkAddressee.PkCadastros;
    CarrierPrice := dmSysTrans.LoadCarrierPrice(FkProdutos.PkProducts, FkTypeTable.PkPriceTable,
      FkTypeTable.PkCalcOrgmDstn, FkTypeTable.PkTypeFraction, aFkAddressee,
      aFkCustomer.PkCadastros, aTypeCstm,  VlrAcrDsct, QtdProd, VlrNF);
    if (FkParceiro > 0) then
    begin
      if (FFkPartnerOrgDst = 0) then SetFkPartnerOrgDst;
      CarrierPriceP := dmSysTrans.LoadCarrierPrice(FkProdutos.PkProducts, FkTypeTable.PkPriceTable,
        FFkPartnerOrgDst, FkTypeTable.PkTypeFraction, aFkAddressee,
        aFkCustomer.PkCadastros, aTypeCstm,  0, QtdProd, VlrNF);
    end;
  finally
    FreeAndNil(aFkCustomer);
  end;
end;

procedure TCdSimulator.SetCarrierPrice(const Value: TCarrierPrice);
begin
  FCarrierPrice := Value;
  if (FCarrierPrice.Status < 0) then
  begin
    case FCarrierPrice.Status of
      -05: Dados.DisplayMessage('Parâmetros informados inválidos!');
      -10: Dados.DisplayMessage('Não consegui determinar a origem e destino!');
      -15: Dados.DisplayMessage('Não consegui determinar o valor do frete!');
      -20: Dados.DisplayMessage('Tipo de frete não encontrado ou não cadastrado corretamente!');
    end;
    exit;
  end;
  Loading    := True;
  try
    VlrFrePeso := FCarrierPrice.VlrFrePeso;
    FreVlr     := FCarrierPrice.FreVlr;
    VlrSecat   := FCarrierPrice.VlrSecat;
    VlrGris    := FCarrierPrice.VlrGris;
    VlrPedg    := FCarrierPrice.VlrPedg;
    VlrDifAcc  := FCarrierPrice.VlrDifAcc;
    VlrAcrDsct := FCarrierPrice.VlrAcrDsct;
    AlqtICMS   := FCarrierPrice.AlqtICMS;
    BasICMS    := FCarrierPrice.BasICMS;
    VlrICMS    := FCarrierPrice.VlrICMS;
    FSubTot    := FCarrierPrice.SubTot;
    TotPed     := FCarrierPrice.TotDoc;
  finally
    Loading    := False;
  end;
end;

procedure TCdSimulator.SetCarrierPriceP(const Value: TCarrierPrice);
begin
  FCarrierPriceP := Value;
  if (FCarrierPrice.Status < 0) then
  begin
    case FCarrierPrice.Status of
      -05: Dados.DisplayMessage('Parâmetros informados inválidos!');
      -10: Dados.DisplayMessage('Não consegui determinar a origem e destino!');
      -15: Dados.DisplayMessage('Não consegui determinar o valor do frete!');
      -20: Dados.DisplayMessage('Tipo de frete não encontrado ou não cadastrado corretamente!');
    end;
    exit;
  end;
  Loading    := True;
  try
    VlrFrePesoP := FCarrierPriceP.VlrFrePeso;
    FreVlrP     := FCarrierPriceP.FreVlr;
    VlrSecatP   := FCarrierPriceP.VlrSecat;
    VlrGrisP    := FCarrierPriceP.VlrGris;
    VlrPedgP    := FCarrierPriceP.VlrPedg;
    VlrDifAccP  := FCarrierPriceP.VlrDifAcc;
    TotPedP     := FCarrierPriceP.TotDoc;
  finally
    Loading    := False;
  end;
end;

procedure TCdSimulator.SetFkPartnerOrgDst;
var
  aLoadAll: Integer;
begin
  aLoadAll := 1;
  if (FDocumentType = dtDocument) then aLoadAll := -1;
  FFkPartnerOrgDst := dmSysTrans.LoadOriginDestination(FkParceiro, FkDestination,
    FkTypeTable.PkPriceTable, aLoadAll);
end;

procedure TCdSimulator.eTot_PedChange(Sender: TObject);
begin
  if (not Loading) and (eTot_Ped.Value <> 0) then
  begin
    ChangeGlobal(Sender);
    if (VlrFrePeso > 0) then
      VlrFrePeso := eTot_Ped.Value;
    if (FreVlr > 0) then
      FreVlr := eTot_Ped.Value;
    VlrAcrDsct := eTot_Ped.Value - SubTot;
  end;
end;

procedure TCdSimulator.SetFkAddressee(const Value: TOwner);
var
  aRegion: Integer;
begin
  if (Value = nil) then
    FFkAddressee.Clear
  else
    FFkAddressee.Assign(Value);
  with FFKAddressee do
  begin
    if (PkCadastros > 0) then
    begin
      eDocDstn.Text := DocPri;
      eTypeDstn.ItemIndex := Ord(FlagTCad);
      SetMaskToControl(lDocDstn, Ord(FlagTCad), 0);
      lAddressee.Caption := RazSoc;
      lDescriptionAddr.Caption := Address.EndAdd + ', ' + IntToStr(Address.NumAdd) +
        ' - ' + Address.CmpEnd + ' - ' + Address.FkCity.FkState.PkState + ' - ' +
        Address.FkCity.DscMun;
      aRegion := Address.FkCity.FkRegions;
      if (Address.FkCity.FkRegions > 0) then
        aRegion := Address.FkCity.FkRegions;
      FkDestination := aRegion;
    end
    else
    begin
      lAddressee.Caption := '';
      lDescriptionAddr.Caption := '';
      FkDestination := 0;
    end;
  end;
end;

procedure TCdSimulator.SetFkShipper(const Value: TOwner);
var
  aRegion: Integer;
begin
  if (Value = nil) then
    FFkShipper.Clear
  else
    FFkShipper.Assign(Value);
  with FFkShipper do
  begin
    if (PkCadastros > 0) then
    begin
      eDocRem.Text := DocPri;
      eTypeRem.ItemIndex := Ord(FlagTCad);
      SetMaskToControl(lDocRem, Ord(FlagTCad), 1);
      lShipper.Caption := RazSoc;
      lDescriptionShipper.Caption := Address.EndAdd + ', ' + IntToStr(Address.NumAdd) +
        ' - ' + Address.CmpEnd + ' - ' + Address.FkCity.FkState.PkState + ' - ' +
        Address.FkCity.DscMun;
      aRegion := Address.FkCity.FkRegions;
      if (Address.FkCity.FkRegions > 0) then
        aRegion := Address.FkCity.FkRegions;
      FkOrigin := aRegion;
    end
    else
    begin
      lShipper.Caption := '';
      lDescriptionShipper.Caption := '';
      FkOrigin := 0;
    end;
  end;
end;

function TCdSimulator.GetFkAddressee: TOwner;
begin
  Result := FFkAddressee;
end;

function TCdSimulator.GetFkShipper: TOwner;
begin
  Result := FFkShipper
end;

function TCdSimulator.GetDocAddressee: string;
begin
  Result := eDocDstn.Text;
end;

function TCdSimulator.GetDocShipper: string;
begin
 Result := eDocRem.Text;
end;

procedure TCdSimulator.SetDocAddressee(const Value: string);
begin
  eDocDstn.EditText := Value;
end;

procedure TCdSimulator.SetDocShipper(const Value: string);
begin
  eDocRem.EditText := Value;
end;

procedure TCdSimulator.eTypeRemSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  SetMaskToControl(lDocRem, eTypeRem.ItemIndex, 0);
end;

procedure TCdSimulator.eTypeDstnSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  SetMaskToControl(lDocDstn, eTypeDstn.ItemIndex, 1);
end;

procedure TCdSimulator.eTypeConsigneeSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  SetMaskToControl(lDocConsignee, eTypeConsignee.ItemIndex, 2);
end;

procedure TCdSimulator.SetMaskToControl(ALabel: TStaticText; const AIdx,
  AField: Integer);
const
  FIELD_MASK   : array[0..1] of string = ('00.000.000\/0000\-00;0; ', '000.000.000\-00;0; ');
  TYPE_FIELD   : array[0..2] of string = (' do Remetente: ', ' do Destinatário: ', ': ');
begin
  ALabel.Caption := LABEL_CAPTION[AIdx] + TYPE_FIELD[AField];
  if (ALabel.FocusControl <> nil) then
    TMaskEdit(ALabel.FocusControl).EditMask := FIELD_MASK[AIdx];
end;

function TCdSimulator.GetDocConsignee: string;
begin
  Result := eDocConsignee.Text;
end;

function TCdSimulator.GetFkConsignee: TOwner;
begin
  Result := FFkConsignee;
end;

procedure TCdSimulator.SetDocConsignee(const Value: string);
begin
  eDocConsignee.EditText := Value;
end;

procedure TCdSimulator.SetFkConsignee(const Value: TOwner);
begin
  if (Value = nil) then
    FFkConsignee.Clear
  else
    FFkConsignee.Assign(Value);
  with FFkConsignee do
  begin
    if (PkCadastros > 0) then
    begin
      eDocConsignee.Text := DocPri;
      eTypeConsignee.ItemIndex := Ord(FlagTCad);
      SetMaskToControl(lDocConsignee, Ord(FlagTCad), 2);
      lConsignee.Caption := RazSoc;
      lDescriptionConsignee.Caption := Address.EndAdd + ', ' + IntToStr(Address.NumAdd) +
        ' - ' + Address.CmpEnd + ' - ' + Address.FkCity.FkState.PkState + ' - ' +
        Address.FkCity.DscMun;
    end
    else
    begin
      lConsignee.Caption := '';
      lDescriptionConsignee.Caption := '';
    end;
  end;
end;

function TCdSimulator.GetTypeCustomer: smallint;
begin
  Result := -1;
  if (FkProdutos.PkProducts > 0) and
     (FkProdutos.ProductService.ProductCarrier.FlagTCarrier = tcCIF) then
  begin
     if (lFlag_Company_Orgm.Checked) then
       Result := 0;
     if (lFlag_Cnsm_Orgm.Checked) then
       Result := 1;
  end;
  if (FkProdutos.PkProducts > 0) and
     (FkProdutos.ProductService.ProductCarrier.FlagTCarrier = tcFOB) then
  begin
     if (lFlag_Company_Dstn.Checked) then
       Result := 0;
     if (lFlag_Cnsm_Dstn.Checked) then
       Result := 1;
  end
end;

procedure TCdSimulator.SetTypeCustomer(const Value: smallint);
begin
  if (Value < -1) or (Value > 1) then exit;
  lFlag_Cnsm_Orgm.Checked    := False;
  lFlag_Company_Orgm.Checked := False;
  lFlag_Cnsm_Dstn.Checked    := False;
  lFlag_Company_Dstn.Checked := False;
  if (Value = 0) then
  begin
    if (FkProdutos.PkProducts > 0) and
       (FkProdutos.ProductService.ProductCarrier.FlagTCarrier = tcCIF) then
      lFlag_Company_Orgm.Checked := True;
    if (FkProdutos.PkProducts > 0) and
       (FkProdutos.ProductService.ProductCarrier.FlagTCarrier = tcFOB) then
      lFlag_Company_Dstn.Checked := True;
  end;
  if (Value = 0) then
  begin
    if (FkProdutos.PkProducts > 0) and
       (FkProdutos.ProductService.ProductCarrier.FlagTCarrier = tcCIF) then
      lFlag_Cnsm_Orgm.Checked := True;
    if (FkProdutos.PkProducts > 0) and
       (FkProdutos.ProductService.ProductCarrier.FlagTCarrier = tcFOB) then
      lFlag_Cnsm_Dstn.Checked := True;
  end;
end;

procedure TCdSimulator.eFk_ProdutosSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (FkProdutos <> nil) and (FkProdutos.PkProducts > 0) then
    SetFlagCustomer(FkProdutos.ProductService.ProductCarrier.FlagTCarrier)
  else
    SetFlagCustomer(tcSuppDelivery);
end;

function  TCdSimulator.CheckCustomerData(ATypeCarrier: TTypeCarrier): Boolean;
var
  aItem: TTypeTable;
  aOwner: TOwner;
  aCtrl : TControl;
const
  MSG_NOT_A_CUSTOMER = '%s ' + NL + 'Não está cadastrado como um cliente válido!!!';
begin
  Result := True;
  aOwner := nil;
  if (ATypeCarrier = tcCif) then // frete pago
    aOwner := FkShipper;
  if (ATypeCarrier = tcFob) then // frete a pagar
    aOwner := FkAddressee;
  if (FkConsignee <> nil) and (FkConsignee.PkCadastros > 0) then
    aOwner := FkConsignee;
  if (aOwner <> nil) then
  begin
    if (aOwner.Customer.Modified) then
    begin
      case ATypeCarrier of
        tcCif: aCtrl := eDocRem;
        tcFob: aCtrl := eDocDstn;
      else
        aCtrl := eDocConsignee;
      end;
      Dados.DisplayHint(aCtrl, Format(MSG_NOT_A_CUSTOMER, [aOwner.RazSoc]));
      Result := False;
    end
    else
    begin
      if (FkTypeTable = nil) and  (aOwner.Customer.FkTypeFraction > 0) and
         (aOwner.Customer.FkPriceTable.PkPriceTable > 0) then
      begin
        aItem                  := TTypeTable.Create;
        try
          aItem.PkPriceTable   := aOwner.Customer.FkPriceTable.PkPriceTable;
          aItem.PkTypeFraction := aOwner.Customer.FkTypeFraction;
          FkTypeTable          := aItem;
        finally
          FreeAndNil(aitem);
        end;
      end;
      if (FkSaler = 0) and (aOwner.Customer.FkVendor > 0) then
        FkSaler                := aOwner.Customer.FkVendor;
    end;
  end
  else
    Result := False;
end;

procedure TCdSimulator.SetFlagCustomer(const ATypeCarrier: TTypeCarrier);
begin
  if (DocumentType = dtSimulator) then
  begin
    lFlag_Cnsm_Orgm.Enabled    := True;
    lFlag_Company_Orgm.Enabled := True;
    sbCancelOrgm.Enabled       := True;
    lFlag_Cnsm_Dstn.Enabled    := True;
    lFlag_Company_Dstn.Enabled := True;
    sbCancelDstn.Enabled       := True;
    if (ATypeCarrier = tcCif) then
    begin
      lFlag_Cnsm_Dstn.Checked    := False;
      lFlag_Company_Dstn.Checked := False;
      lFlag_Cnsm_Dstn.Enabled    := False;
      lFlag_Company_Dstn.Enabled := False;
      sbCancelDstn.Enabled       := False;
    end;
    if (ATypeCarrier = tcFob) then
    begin
      lFlag_Cnsm_Orgm.Checked    := False;
      lFlag_Company_Orgm.Checked := False;
      lFlag_Cnsm_Orgm.Enabled    := False;
      lFlag_Company_Orgm.Enabled := False;
      sbCancelOrgm.Enabled       := False;
    end;
  end
  else
    CheckCustomerData(ATypeCarrier)
end;

procedure TCdSimulator.sbCancelOrgmClick(Sender: TObject);
begin
  lFlag_Cnsm_Orgm.Checked    := False;
  lFlag_Company_Orgm.Checked := False;
end;

procedure TCdSimulator.sbCancelDstnClick(Sender: TObject);
begin
  lFlag_Cnsm_Dstn.Checked    := False;
  lFlag_Company_Dstn.Checked := False;
end;

procedure TCdSimulator.sbSearchOwner(Sender: TObject);
begin
  // Show search screen
  if (TSpeedButton(Sender).Tag = 0) then
  begin
    eDocRem.Text := '03680426000121';
    eDocRem.OnExit(eDocRem);
  end
  else
  begin
    eTypeDstn.ItemIndex := 1;
    eTypeDstnSelect(eTypeDstn);
    eDocDstn.Text := '05857392934';
    eDocDstn.OnExit(eDocDstn);
  end;
end;

procedure TCdSimulator.eDocRemExit(Sender: TObject);
begin
  if (DocShipper = '') then exit;
  if ((eTypeRem.ItemIndex = 0) and (not VerCgc(DocShipper))) or
     ((eTypeRem.ItemIndex = 1) and (not VerCpf(DocShipper))) then
  begin
    Dados.DisplayHint(eDocrem, LABEL_CAPTION[eTypeRem.ItemIndex] + ' Inváldo!');
    if (eDocRem.CanFocus) then eDocRem.SetFocus;
    exit;
  end;
  FkShipper := dmSysTrans.LoadCustomerFromDoc(DocShipper, eTypeRem.ItemIndex);
end;

procedure TCdSimulator.eDocDstnExit(Sender: TObject);
begin
  if (DocAddresse = '') then exit;
  if ((eTypeDstn.ItemIndex = 0) and (not VerCgc(DocAddresse))) or
     ((eTypeDstn.ItemIndex = 1) and (not VerCpf(DocAddresse))) then
  begin
    Dados.DisplayHint(eDocDstn, LABEL_CAPTION[eTypeDstn.ItemIndex] + ' Inváldo!');
    if (eDocDstn.CanFocus) then eDocDstn.SetFocus;
    exit;
  end;
  FkAddressee := dmSysTrans.LoadCustomerFromDoc(DocAddresse, eTypeDstn.ItemIndex);
end;

procedure TCdSimulator.eDocConsigneeExit(Sender: TObject);
begin
  if (DocConsignee = '') then exit;
  if ((eTypeConsignee.ItemIndex = 0) and (not VerCgc(DocConsignee))) or
     ((eTypeConsignee.ItemIndex = 1) and (not VerCpf(DocConsignee))) then
  begin
    Dados.DisplayHint(eDocConsignee, LABEL_CAPTION[eTypeConsignee.ItemIndex] + ' Inváldo!');
    if (eDocDstn.CanFocus) then eDocDstn.SetFocus;
    exit;
  end;
  FkConsignee := dmSysTrans.LoadCustomerFromDoc(DocConsignee, eTypeConsignee.ItemIndex);
end;

procedure TCdSimulator.InsertMeasureBlankNode;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtMeasure.AddChild(nil);
  if (Node <> nil) then
  begin
    Data := vtMeasure.GetNodeData(Node);
    if (Data <> nil) then
    begin
      Data^.Node     := Node;
      Data^.Level    := vtMeasure.GetNodeLevel(Node);
      Data^.NodeType := tnData;
      Data^.DataRow  := TDataRow.Create(vtMeasure);
      Data^.DataRow.AddAs('FLAG_TYPE_MED', rgTypeMed.ItemIndex, ftInteger, SizeOf(Integer));
      Data^.DataRow.AddAs('ALT_MED', 0.0, ftFloat, SizeOf(Double));
      Data^.DataRow.AddAs('LARG_MED', 0.0, ftFloat, SizeOf(Double));
      Data^.DataRow.AddAs('PROF_MED', 0.0, ftFloat, SizeOf(Double));
    end;
  end;
  vtMeasure.FocusedColumn := 0;
end;

procedure TCdSimulator.vtMeasureGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := FloatToStrF(Data^.DataRow.FieldByName['ALT_MED'].AsFloat,  ffNumber, 7, 4);
    1: CellText := FloatToStrF(Data^.DataRow.FieldByName['LARG_MED'].AsFloat, ffNumber, 7, 4);
    2: CellText := FloatToStrF(Data^.DataRow.FieldByName['PROF_MED'].AsFloat, ffNumber, 7, 4);
  end;
end;

procedure TCdSimulator.vtMeasureKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node: PVirtualNode;
  Data: PGridData;
  aCol: Integer;
  procedure DeleteANode;
  begin
    if (Node = nil) then exit;
    Data := TVirtualStringTree(Sender).GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    Data^.Level := 0;
    Data^.Node  := nil;
    FreeAndNil(Data^.DataRow);
    TVirtualStringTree(Sender).DeleteNode(Node);
  end;
begin
  with TVirtualStringTree(Sender) do
  begin
    Node := FocusedNode;
    if (Node = nil) then exit;
    Data := GetNodeData(Node);
    if (Data = nil) and (Data^.DataRow = nil) then exit;
    aCol := vtMeasure.FocusedColumn;
    if (aCol = 2) and (Key = VK_RETURN) then
      Key := VK_DOWN;
    case Key of
      VK_UP    : if (RootNodeCount > 1) then
                   if (GetFirst = Node) then
                     FocusedNode := GetLast
                   else
                     if (Data^.DataRow.FieldByName['ALT_MED'].AsFloat = 0) and
                        (Data^.DataRow.FieldByName['LARG_MED'].AsFloat = 0) and
                        (Data^.DataRow.FieldByName['PROF_MED'].AsFloat = 0) then
                       DeleteANode;
      VK_DOWN  : if (Data^.DataRow.FieldByName['ALT_MED'].AsFloat > 0) and
                    (Data^.DataRow.FieldByName['LARG_MED'].AsFloat > 0) and
                    (Data^.DataRow.FieldByName['PROF_MED'].AsFloat > 0) then
                   if (GetLast = Node) then
                     InsertMeasureBlankNode
                   else
                   begin
                     FocusedNode           := GetNext(Node);
                     Selected[FocusedNode] := True;
                   end;
      VK_RETURN: begin
                   if (FocusedColumn < 4) then
                     FocusedColumn := FocusedColumn + 1
                   else
                     FocusedColumn := 0;
                   EditNode(FocusedNode, FocusedColumn);
                 end;
    else
      if (not (ssShift in Shift)) and (ssCtrl in Shift) and (Key = VK_DELETE) then
        DeleteANode
      else
        if (Chr(Key) in ['0'..'9', ',']) then
          EditNode(Node, FocusedColumn);
    end;
  end;
end;

procedure TCdSimulator.vtMeasureNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data : PGridData;
  S    : string;
  Value: Double;
  procedure DisplayColumnWarning;
  var
    R: TRect;
  begin
    R := Sender.GetDisplayRect(Node, Column, False);
    R.BottomRight.Y := R.BottomRight.Y + (vtMeasure.Height -
                       Integer(TVirtualStringTree(Sender).DefaultNodeHeight));
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight, S);
  end;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (StrToFloatDef(NewText, -1) < 0) or (StrToFloatDef(NewText, -1) > 99.9999) then
  begin
    S := 'O valor neste campo deve ser um percentual entre 0,00 e 99,9999';
    DisplayColumnWarning;
    exit;
  end;
  Value := StrToFloat(NewText);
  case Column of
    0: Data^.DataRow.FieldByName['ALT_MED'].AsFloat  := Value;
    1: Data^.DataRow.FieldByName['LARG_MED'].AsFloat := Value;
    2: Data^.DataRow.FieldByName['PROF_MED'].AsFloat := Value;
  end;
end;

procedure TCdSimulator.rgTypeMedClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  with vtMeasure do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data = nil) and (Data^.DataRow = nil) then
        Data^.DataRow.FieldByName['FLAG_TYPE_MED'].AsInteger := rgTypeMed.ItemIndex;
      Node := GetNext(Node);
    end;
  end;
end;

procedure TCdSimulator.vtMeasureEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := True;
  if (ScrState in SCROLL_MODE) then
    if (Pk = 0) then
      ScrState := dbmInsert
    else
      ScrState := dbmEdit;
end;

function TCdSimulator.GetVolumeToWeight: Double;
var
  Node: PVirtualNode;
  Data: PGridData;
  aCub: Double;
const
  CM2M3  = 100;
  FACTOR = 300;
begin
  aCub := 0;
  with vtMeasure do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data = nil) and (Data^.DataRow = nil) then
      begin
        aCub := aCub + (Data^.DataRow.FieldByName['ALT_MED'].AsFloat *
                        Data^.DataRow.FieldByName['LARG_MED'].AsFloat *
                        Data^.DataRow.FieldByName['PROF_MED'].AsFloat);
      end;
      Node := GetNext(Node);
    end;
  end;
  Result := aCub * FACTOR;
  if (rgTypeMed.ItemIndex = 1) then
    Result := (aCub * CM2M3) * FACTOR;
end;

procedure TCdSimulator.pgCalcChange(Sender: TObject);
begin
  if (VolumeToWeight > 0) and (QtdProd = 0) then
    QtdProd := VolumeToWeight;
end;

procedure TCdSimulator.vtMeasureGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  vtMeasure.NodeDataSize := SizeOf(TGridData);
end;

procedure TCdSimulator.sbCalcCubClick(Sender: TObject);
begin
  QtdProd := VolumeToWeight;
end;

function TCdSimulator.GetCarrierWeights: TCarrierWeights;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := TCarrierWeights.Create(Self);
  with vtMeasure do
  begin
    Node := GetFirst;
    if (Node <> nil) then
    begin
      Data := GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (Data^.DataRow.UserData <> nil) then
        Result.Add.Assign(TCarrierWeight(Data^.DataRow.UserData));
    end;
  end;
end;

procedure TCdSimulator.SetCarrierWeights(const Value: TCarrierWeights);
var
  Node: PVirtualNode;
  Data: PGridData;
  i   : Integer;
begin
  ReleaseTreeNodes(vtMeasure);
  if (Value = nil) then exit;
  with vtMeasure do
  begin
    for i := 0 to Value.Count - 1 do
    begin
      Node := AddChild(nil);
      if (Node <> nil) and (Value.Items[i] <> nil) then
      begin
        Data := GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.DataRow  := TDataRow.Create(vtMeasure);
          with Data^.DataRow do
          begin
            UserData := Value.Items[i];
            AddAs('ALT_VOL', Value.Items[i].AltVol, ftFloat, SizeOf(Double));
            AddAs('LARG_VOL', Value.Items[i].LargVol, ftFloat, SizeOf(Double));
            AddAs('PROF_VOL', Value.Items[i].ProfVol, ftFloat, SizeOf(Double));
          end;
          Data^.Level    := 0;
          Data^.Node     := Node;
          Data^.NodeType := tnData;
        end;
      end;
    end;
  end;
end;

function TCdSimulator.GetFlagES: TInOut;
begin
  Result := TInOut(lFlag_ES.ItemIndex);
end;

procedure TCdSimulator.SetFlagES(const Value: TInOut);
begin
  lFlag_ES.ItemIndex := Ord(Value);
end;

function TCdSimulator.GetFlagRemb: Boolean;
begin
  Result := lFlag_Remb.Checked;
end;

procedure TCdSimulator.SetFlagRemb(const Value: Boolean);
begin
  lFlag_Remb.Checked := Value;
end;

function TCdSimulator.GetFkEstados(ALocal: Integer): string;
var
  aCombo: TPrcComboBox;
begin
  if (ALocal = 0) then
    aCombo := eFkEstadosOrgm
  else
    aCombo := eFkEstadosDstn;
  with aCombo do
  begin
    Result := '';
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TState(Items.Objects[ItemIndex]).PkState;
  end;
end;

function TCdSimulator.GetFkMunicipios(ALocal: Integer): Integer;
var
  aCombo: TPrcComboBox;
begin
  if (ALocal = 0) then
    aCombo := eFkMunicipiosOrgm
  else
    aCombo := eFkMunicipiosDstn;
  with aCombo do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TCity(Items.Objects[ItemIndex]).PkCity;
  end;
end;

function TCdSimulator.GetFkPaises(ALocal: Integer): Integer;
var
  aCombo: TPrcComboBox;
begin
  if (ALocal = 0) then
    aCombo := eFkPaisesOrgm
  else
    aCombo := eFkPaisesDstn;
  with aCombo do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TCountry(Items.Objects[ItemIndex]).PKCountry;
  end;
end;

procedure TCdSimulator.SetFkEstados(ALocal: Integer; const Value: string);
var
  i: Integer;
  aCombo: TPrcComboBox;
begin
  if (ALocal = 0) then
    aCombo := eFkEstadosOrgm
  else
    aCombo := eFkEstadosDstn;
  with aCombo do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if ((Items.Objects[i] <> nil) and (TState(Items.Objects[i]).PkState = Value)) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
    if (ItemIndex > -1) and (Assigned(aCombo.OnSelect)) then
      aCombo.OnSelect(aCombo);
  end;
end;

procedure TCdSimulator.SetFkMunicipios(ALocal: Integer;
  const Value: Integer);
var
  i: Integer;
  aCombo: TPrcComboBox;
begin
  if (ALocal = 0) then
    aCombo := eFkMunicipiosOrgm
  else
    aCombo := eFkMunicipiosDstn;
  with aCombo do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if ((Items.Objects[i] <> nil) and (TCity(Items.Objects[i]).PkCity = Value)) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
    if (ItemIndex > -1) and (Assigned(aCombo.OnSelect)) then
      aCombo.OnSelect(aCombo);
  end;
end;

procedure TCdSimulator.SetFkPaises(ALocal: Integer; const Value: Integer);
var
  i: Integer;
  aCombo: TPrcComboBox;
begin
  if (ALocal = 0) then
    aCombo := eFkPaisesOrgm
  else
    aCombo := eFkPaisesDstn;
  with aCombo do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if ((Items.Objects[i] <> nil) and (TCountry(Items.Objects[i]).PKCountry = Value)) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
    if (ItemIndex > -1) and (Assigned(aCombo.OnSelect)) then
      aCombo.OnSelect(aCombo);
  end;
end;

function TCdSimulator.GetQtdVol: Integer;
begin
  Result := eQtd_Vol.AsInteger
end;

procedure TCdSimulator.SetQtdVol(const Value: Integer);
begin
  eQtd_Vol.AsInteger := Value;
end;

end.
