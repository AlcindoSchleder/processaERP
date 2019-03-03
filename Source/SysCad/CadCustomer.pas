unit CadCustomer;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created  : 02/06/2003                                                 *}
{* Modified : 02/06/2003                                                 *}
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
  Dialogs, StdCtrls, ExtCtrls, ToolEdit, CurrEdit, Mask, Buttons, GridRow,
  ComCtrls, PrcCombo, VirtualTrees, TSysPedAux, TSysCad, TSysBcCx, TSysCadAux,
  TSysEstqAux, ProcUtils, CadModel;

type
  TPageLoaded = (dlCustomer, dlCollection, dlDelivery, dlReferences, dlPartners, dlPersonal);
  TDataLoaded = set of TPageLoaded;

  TTypeGridData = (tgdReferences, tgdPartners);
  PCustomData = ^TCustomData;
  TCustomData = record
    Level  : Integer;
    Node   : PVirtualNode;
    Index  : Integer;
    State  : TDBMode;
    case TypeGridData: TTypeGridData of
      tgdReferences: (DataRef: TReference);
      tgdPartners  : (DataPrt: TPartner);
  end;

  TCdCustomer = class(TfrmModel)
    pgControl: TPageControl;
    tsCustumerData: TTabSheet;
    pgControlCust: TPageControl;
    tsData_cli: TTabSheet;
    lFk_Vw_Vendedores: TStaticText;
    lFk_Vw_Representantes: TStaticText;
    lFk_Tipo_Pagamentos: TStaticText;
    lFk_Tipo_Descontos: TStaticText;
    lFk_Tabela_Precos: TStaticText;
    lFk_Meios_Pagamento: TStaticText;
    lFk_Tipo_Bloqueios: TStaticText;
    eFk_Tipo_Pagamentos: TPrcComboBox;
    eFk_Vw_Vendedores: TPrcComboBox;
    eFk_Vw_Representantes: TPrcComboBox;
    eFk_Tipo_Descontos: TPrcComboBox;
    eFk_Tabela_Precos: TPrcComboBox;
    eFk_Meios_Pagamento: TPrcComboBox;
    eFk_Tipo_Bloqueios: TPrcComboBox;
    tsComplement_cli: TTabSheet;
    lFk_Bancos: TStaticText;
    lFk_Tipo_Estabelecimentos: TStaticText;
    lFk_Vw_Cadastros: TStaticText;
    lFk_Portos__Emb: TStaticText;
    lFk_Portos__Dst: TStaticText;
    eFk_Tipo_Estabelecimentos: TPrcComboBox;
    eFk_Vw_Cadastros: TPrcComboBox;
    eFk_Portos__Emb: TPrcComboBox;
    eFk_Portos__Dst: TPrcComboBox;
    eFk_Bancos: TPrcComboBox;
    lFlag_DtaBas: TStaticText;
    eFlag_DtaBas: TPrcComboBox;
    tsParams: TTabSheet;
    lFlag_Cnsm: TCheckBox;
    lLim_Crd: TStaticText;
    eLim_Crd: TCurrencyEdit;
    lPwd_Access: TStaticText;
    lDsc_Aut: TStaticText;
    eDsct_Aut: TCurrencyEdit;
    lDsct_Atc: TStaticText;
    eDsct_Atc: TCurrencyEdit;
    tsCollectionAddress: TTabSheet;
    tsDeliveryAddress: TTabSheet;
    sbAddCmpEnt: TSpeedButton;
    eNum_Ent: TCurrencyEdit;
    lFax_Ent: TStaticText;
    lCxp_Ent: TStaticText;
    eCep_Ent: TCurrencyEdit;
    eCxp_Ent: TEdit;
    lCep_Ent: TStaticText;
    lNum_Ent: TStaticText;
    eEnd_Ent: TEdit;
    eCmp_Ent: TEdit;
    lFon_Ent: TStaticText;
    lEnd_Ent: TStaticText;
    lFk_Municipios_ent: TStaticText;
    lFk_Paises_ent: TStaticText;
    eFk_Paises_ent: TPrcComboBox;
    lCnpj_Entr: TStaticText;
    eCnpj_Entr: TEdit;
    lIe_Entr: TStaticText;
    lFk_Estados_ent: TStaticText;
    eFk_Estados_ent: TPrcComboBox;
    eIe_Entr: TEdit;
    eFk_Municipios_ent: TPrcComboBox;
    eFon_Ent: TMaskEdit;
    eFax_Ent: TMaskEdit;
    tsComercialReferences: TTabSheet;
    pgRefCom: TPageControl;
    tsListRefCom: TTabSheet;
    vtReferences: TVirtualStringTree;
    tsDataRefCom: TTabSheet;
    sbSaveRef: TSpeedButton;
    sbCancelRef: TSpeedButton;
    sbInsertRef: TSpeedButton;
    lFon_Ref: TStaticText;
    lNom_Ref: TStaticText;
    eNom_Ref: TEdit;
    lFlag_Cnf: TCheckBox;
    eMail_Ref: TEdit;
    lMail_Ref: TStaticText;
    lObs_Ref: TStaticText;
    eObs_Ref: TMemo;
    eFon_Ref: TMaskEdit;
    tsCompanyPartners: TTabSheet;
    sbSendMail_soc: TSpeedButton;
    pgPartners: TPageControl;
    tsPartnerList: TTabSheet;
    vtPartners: TVirtualStringTree;
    tsPartnerData: TTabSheet;
    sbAddCmpSoc: TSpeedButton;
    sbInsertSoc: TSpeedButton;
    sbCancelSoc: TSpeedButton;
    sbSaveSoc: TSpeedButton;
    eCmp_Soc: TEdit;
    lDta_Nas: TStaticText;
    eDta_Nasc_Soc: TDateEdit;
    eNom_Soc: TEdit;
    lNom_Soc: TStaticText;
    lFk_Paises_soc: TStaticText;
    eFk_Paises_soc: TPrcComboBox;
    lFk_Estados_Soc: TStaticText;
    eFk_Estados_soc: TPrcComboBox;
    eFk_Municipios_soc: TPrcComboBox;
    lFk_Municipios_soc: TStaticText;
    lEnd_Soc: TStaticText;
    eEnd_Soc: TEdit;
    lNum_Soc: TStaticText;
    lCep_Soc: TStaticText;
    StaticText1: TStaticText;
    eMail_Soc: TEdit;
    eCep_Soc: TCurrencyEdit;
    eNum_Soc: TCurrencyEdit;
    lPk_Socios: TStaticText;
    ePk_Socios: TMaskEdit;
    tsDataPersonal: TTabSheet;
    pgPersonalData: TPageControl;
    tsData_dps: TTabSheet;
    lEmp_Trb: TStaticText;
    lDta_Adm: TStaticText;
    lCrg_Cli: TStaticText;
    lFon_Emp: TStaticText;
    lPrf_Cli: TStaticText;
    ePrf_Cli: TEdit;
    eCrg_Cli: TEdit;
    eEmp_Trb: TEdit;
    eDta_Adm: TDateEdit;
    lFlag_Sex: TRadioGroup;
    eFon_Emp: TMaskEdit;
    tsComplement_dps: TTabSheet;
    lNum_Cnh: TStaticText;
    lDta_Exp: TStaticText;
    lVal_Cnh: TStaticText;
    eNum_Cnh: TEdit;
    eDta_Exp: TDateEdit;
    eVal_Cnh: TDateEdit;
    lSal_Cli: TStaticText;
    eSal_Cli: TCurrencyEdit;
    lCmp_Sal: TStaticText;
    eVlr_Alg: TCurrencyEdit;
    eCmp_Sal: TCurrencyEdit;
    lVlr_Alg: TStaticText;
    eObs_Pes: TMemo;
    lObs_Cad: TStaticText;
    lEsc_Cad: TStaticText;
    eEsc_Cad: TEdit;
    tsPersObs: TTabSheet;
    gbNatural: TGroupBox;
    lNom_Pai: TStaticText;
    lNom_Mae: TStaticText;
    lFk_Paises_dps: TStaticText;
    lFk_Estados_dps: TStaticText;
    lFk_Municipios_dps: TStaticText;
    eFk_Paises_dps: TPrcComboBox;
    eFk_Estados_dps: TPrcComboBox;
    eFk_Municipios_dps: TPrcComboBox;
    eNom_Mae: TEdit;
    eNom_Pai: TEdit;
    lFk_Paises__ca: TStaticText;
    eFk_Paises__ca: TPrcComboBox;
    lFk_Estados__ca: TStaticText;
    eFk_Estados__ca: TPrcComboBox;
    eFk_Municipios__ca: TPrcComboBox;
    lFk_Municipios__ca: TStaticText;
    lEnd_Cbr: TStaticText;
    eEnd_Cbr: TEdit;
    lCmp_Cbr: TStaticText;
    eCmp_Cbr: TEdit;
    eCxp_Cbr: TEdit;
    lCxp_Cbr: TStaticText;
    lFon_Cbr: TStaticText;
    eFon_Cbr: TMaskEdit;
    lFax_Cbr: TStaticText;
    eFax_Cbr: TMaskEdit;
    eCep_Cbr: TCurrencyEdit;
    lCep_Cbr: TStaticText;
    lNum_Cbr: TStaticText;
    eNum_Cbr: TCurrencyEdit;
    tsParamsCmpl: TTabSheet;
    lFk_Vw_Transportadoras: TStaticText;
    eFk_Vw_Transportadoras: TPrcComboBox;
    lDia_Ems: TStaticText;
    eDia_Ems: TCurrencyEdit;
    lFkTipoTabelaFracao: TStaticText;
    eFkTipoTabelaFracao: TPrcComboBox;
    eFk_Tipo_Prazo_Entrega: TPrcComboBox;
    lFk_Tipo_Prazo_Entrega: TStaticText;
    vtMovement: TVirtualStringTree;
    lIdx_Conv: TStaticText;
    eIdx_Conv: TCurrencyEdit;
    lFlagFobDirigido: TCheckBox;
    lFlagSameRegion: TCheckBox;
    lTax_Access: TStaticText;
    eMin_Access: TCurrencyEdit;
    eTax_Access: TCurrencyEdit;
    lFlag_DifAcc: TRadioGroup;
    bbClearFLagDiffAcc: TBitBtn;
    sbGetPasswd: TSpeedButton;
    ePwd_Access: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pgControlChange(Sender: TObject);
    procedure eFk_Paises__caSelect(Sender: TObject);
    procedure eFk_Estados__caSelect(Sender: TObject);
    procedure eFk_Paises_entSelect(Sender: TObject);
    procedure eFk_Estados_entSelect(Sender: TObject);
    procedure eFk_Paises_socSelect(Sender: TObject);
    procedure eFk_Estados_socSelect(Sender: TObject);
    procedure eFk_Paises_dpsSelect(Sender: TObject);
    procedure eFk_Estados_dpsSelect(Sender: TObject);
    procedure TreeViewGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure TreeViewFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure TreeViewDblClick(Sender: TObject);
    procedure sbSaveRefClick(Sender: TObject);
    procedure sbInsertRefClick(Sender: TObject);
    procedure sbCancelRefClick(Sender: TObject);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbSaveSocClick(Sender: TObject);
    procedure sbCancelSocClick(Sender: TObject);
    procedure sbInsertSocClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure eFk_Tipo_PagamentosSelect(Sender: TObject);
    procedure vtMovementGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtMovementInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtMovementGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtMovementBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtMovementChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtMovementFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtMovementFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtMovementChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtMovementPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure bbClearFLagDiffAccClick(Sender: TObject);
    procedure lFlag_DifAccClick(Sender: TObject);
    procedure eFk_Tabela_PrecosSelect(Sender: TObject);
    procedure sbGetPasswdClick(Sender: TObject);
  private
    { Private declarations }
    FDataLoaded : TDataLoaded;
    FFlagTCad   : TTypeOwner;
    FFkCountry  : Integer;
    FCstmIsChild: Boolean;
    FClAdIsChild: Boolean;
    FDlAdIsChild: Boolean;
    FPDatIsChild: Boolean;
    FSitBlockAnt: Integer;
    FOpeLib: string;
    FOpeAut: string;
    function  GetCepEnd(Index: Integer): Integer;
    function  GetCmpEnd(Index: Integer): string;
    function  GetCmpSal: Double;
    function  GetCnpjEntr_: string;
    function  GetPwdAccess: string;
    function  GetCrgCli: string;
    function  GetCxpCbr: string;
    function  GetCxpEnt: string;
    function  GetDiaEms: Integer;
    function  GetDscEnd(Index: Integer): string;
    function  GetDsctAtc: Double;
    function  GetDsctAut: Double;
    function  GetDtaAdm: TDate;
    function  GetDtaExp: TDate;
    function  GetDtaNascSoc: TDate;
    function  GetEmpTrb: string;
    function  GetEscCad: string;
    function  GetFaxCbr: string;
    function  GetFaxEnt: string;
    function  GetFkAgent: Integer;
    function  GetFkBancos: TBank;
    function  GetFkCity(Index: Integer): TCity;
    function  GetFkCountry(Index: Integer): TCountry;
    function  GetFkMeiosPagamento: TPaymentWay;
    function  GetFkPortosDst: Integer;
    function  GetFkPortosEmb: Integer;
    function  GetFkState(Index: Integer): TState;
    function  GetFkTabelaPrecos: TPriceTable;
    function  GetFkTipoBloqueios: TTypeBlock;
    function  GetFkTipoDescontos: TTypeDiscount;
    function  GetFkTipoEstablishment: Integer;
    function  GetFkTipoPagamentos: TTypePayment;
    function  GetFkVwRepresentantes: Integer;
    function  GetFkVwTransportadoras: Integer;
    function  GetFkVwVendedores: Integer;
    function  GetFlagCnf: Boolean;
    function  GetFlagCnsm: Boolean;
    function  GetFlagDtaBas: TBaseDate;
    function  GetFlagSex: TSexType;
    function  GetFonCbr: string;
    function  GetFonEmp: string;
    function  GetFonEnt: string;
    function  GetFonRef: string;
    function  GetIeEntr_: string;
    function  GetLimCrd: Double;
    function  GetMailRef: string;
    function  GetMailSoc: string;
    function  GetNomMae: string;
    function  GetNomPai: string;
    function  GetNomRef: string;
    function  GetNomSoc: string;
    function  GetNumCnh: string;
    function  GetNumEnd(Index: Integer): Integer;
    function  GetObsPes: TStrings;
    function  GetObsRef: TStrings;
    function  GetPkPartner: string;
    function  GetPrfCli: string;
    function  GetSalCli: Double;
    function  GetValCnh: TDate;
    function  GetVlrAlg: Double;
    function  GetFkTipoTabelaFracao: Integer;
    function  GetFlagFobDirigido: Boolean;
    function  GetFlagSameRegion: Boolean;
    function  GetIdxConv: Double;
    function  GetFkTypeDelivryPeriod: Integer;
    function  GetFkBanks: Integer;
    function  GetFlagDifAcc: Integer;
    function  GetMinAccess: Double;
    function  GetTaxAccess: Double;
    procedure SetCepEnd(Index: Integer; const Value: Integer);
    procedure SetCmpEnd(Index: Integer; const Value: string);
    procedure SetCmpSal(const Value: Double);
    procedure SetCnpjEntr_(const Value: string);
    procedure SetPwdAccess(const Value: string);
    procedure SetCrgCli(const Value: string);
    procedure SetCxpCbr(const Value: string);
    procedure SetCxpEnt(const Value: string);
    procedure SetDiaEms(const Value: Integer);
    procedure SetDscEnd(Index: Integer; const Value: string);
    procedure SetDsctAtc(const Value: Double);
    procedure SetDsctAut(const Value: Double);
    procedure SetDtaAdm(const Value: TDate);
    procedure SetDtaExp(const Value: TDate);
    procedure SetDtaNascSoc(const Value: TDate);
    procedure SetEmpTrb(const Value: string);
    procedure SetEscCad(const Value: string);
    procedure SetFaxCbr(const Value: string);
    procedure SetFaxEnt(const Value: string);
    procedure SetFkAgent(const Value: Integer);
    procedure SetFkBancos(const Value: TBank);
    procedure SetFkCity(Index: Integer; const Value: TCity);
    procedure SetFkCountry(Index: Integer; const Value: TCountry);
    procedure SetFkMeiosPagamento(const Value: TPaymentWay);
    procedure SetFkPortosDst(const Value: Integer);
    procedure SetFkPortosEmb(const Value: Integer);
    procedure SetFkState(Index: Integer; const Value: TState);
    procedure SetFkTabelaPrecos(const Value: TPriceTable);
    procedure SetFkTipoBloqueios(const Value: TTypeBlock);
    procedure SetFkTipoDescontos(const Value: TTypeDiscount);
    procedure SetFkTipoEstablishment(const Value: Integer);
    procedure SetFkTipoPagamentos(const Value: TTypePayment);
    procedure SetFkVwRepresentantes(const Value: Integer);
    procedure SetFkVwTransportadoras(const Value: Integer);
    procedure SetFkVwVendedores(const Value: Integer);
    procedure SetFlagCnf(const Value: Boolean);
    procedure SetFlagCnsm(const Value: Boolean);
    procedure SetFlagDtaBas(const Value: TBaseDate);
    procedure SetFlagSex(const Value: TSexType);
    procedure SetFonCbr(const Value: string);
    procedure SetFonEmp(const Value: string);
    procedure SetFonEnt(const Value: string);
    procedure SetFonRef(const Value: string);
    procedure SetIeEntr_(const Value: string);
    procedure SetLimCrd(const Value: Double);
    procedure SetMailRef(const Value: string);
    procedure SetMailSoc(const Value: string);
    procedure SetNomMae(const Value: string);
    procedure SetNomPai(const Value: string);
    procedure SetNomRef(const Value: string);
    procedure SetNomSoc(const Value: string);
    procedure SetNumCnh(const Value: string);
    procedure SetNumEnd(Index: Integer; const Value: Integer);
    procedure SetObsPes(const Value: TStrings);
    procedure SetObsRef(const Value: TStrings);
    procedure SetPkPartner(const Value: string);
    procedure SetPrfCli(const Value: string);
    procedure SetSalCli(const Value: Double);
    procedure SetValCnh(const Value: TDate);
    procedure SetVlrAlg(const Value: Double);
    procedure SetFkTipoTabelaFracao(const Value: Integer);
    procedure SetFlagFobDirigido(const Value: Boolean);
    procedure SetFlagSameRegion(const Value: Boolean);
    procedure SetIdxConv(const Value: Double);
    procedure SetFkTypeDelivryPeriod(const Value: Integer);
    procedure ChangeOwner(Sender: TObject);
    procedure LocalChangeScrMode(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure LoadFlagDtaBas;
    procedure LoadPartnersGrid;
    procedure LoadReferencesGrid;
    procedure ReleaseTreeNodesCstm(ATree: TVirtualStringTree);
    procedure LoadCollectionAddress;
    procedure LoadCustomerData;
    procedure LoadCommercialReferences;
    procedure LoadCompanyPartners;
    procedure LoadDataPersonal;
    procedure LoadDeliveryAddress;
    procedure SaveCollectionAddress;
    procedure SaveCommercialReferences;
    procedure SaveCompanyPartners;
    procedure SaveCustomerData;
    procedure SaveDataPersonal;
    procedure SaveDeliveryAddress;
    procedure ClearCollectionAddress;
    procedure ClearCommercialReferences;
    procedure ClearCompanyPartners;
    procedure ClearCustomerData;
    procedure ClearDataPersonal;
    procedure ClearDeliveryAddress;
    procedure SetFlagTCad(const Value: TTypeOwner);
    procedure LoadTypeMoviment;
    procedure SetFkBanks(const Value: Integer);
    procedure SetMinAccess(const Value: Double);
    procedure SetTaxAccess(const Value: Double);
    procedure SetFlagDifAcc(const Value: Integer);
    procedure SetDifAccScreen;
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
  // Control Properties
    property CstmIsChild             : Boolean       read FCstmIsChild default False;
    property ClAdIsChild             : Boolean       read FClAdIsChild default False;
    property DlAdIsChild             : Boolean       read FDlAdIsChild default False;
    property PDatIsChild             : Boolean       read FPDatIsChild default False;
  // Customer properties
    property FkVwVendedores          : Integer       read GetFkVwVendedores      write SetFkVwVendedores;
    property FkVwRepresentantes      : Integer       read GetFkVwRepresentantes  write SetFkVwRepresentantes;
    property FkTipoBloqueios         : TTypeBlock    read GetFkTipoBloqueios     write SetFkTipoBloqueios;
    property FkTabelaPrecos          : TPriceTable   read GetFkTabelaPrecos      write SetFkTabelaPrecos;
    property FkTipoPagamentos        : TTypePayment  read GetFkTipoPagamentos    write SetFkTipoPagamentos;
    property FkTipoDescontos         : TTypeDiscount read GetFkTipoDescontos     write SetFkTipoDescontos;
    property FkVwTransportadoras     : Integer       read GetFkVwTransportadoras write SetFkVwTransportadoras;
    property FkBanks                 : Integer       read GetFkBanks             write SetFkBanks;
    property FkAgent                 : Integer       read GetFkAgent             write SetFkAgent;
    property FkPortosEmb             : Integer       read GetFkPortosEmb         write SetFkPortosEmb;
    property FkPortosDst             : Integer       read GetFkPortosDst         write SetFkPortosDst;
    property FkTipoEstablishment     : Integer       read GetFkTipoEstablishment write SetFkTipoEstablishment;
    property FkTipoTabelaFracao      : Integer       read GetFkTipoTabelaFracao  write SetFkTipoTabelaFracao;
    property FkTypeDelivryPeriod     : Integer       read GetFkTypeDelivryPeriod write SetFkTypeDelivryPeriod;
    property FkMeiosPagamento        : TPaymentWay   read GetFkMeiosPagamento    write SetFkMeiosPagamento;
    property DiaEms                  : Integer       read GetDiaEms              write SetDiaEms;
    property FlagDtaBas              : TBaseDate     read GetFlagDtaBas          write SetFlagDtaBas;
    property FlagFobDirigido         : Boolean       read GetFlagFobDirigido     write SetFlagFobDirigido;
    property FlagSameRegion          : Boolean       read GetFlagSameRegion      write SetFlagSameRegion;
    property FlagDifAcc              : Integer       read GetFlagDifAcc          write SetFlagDifAcc;
    property DsctAut                 : Double        read GetDsctAut             write SetDsctAut;
    property DsctAtc                 : Double        read GetDsctAtc             write SetDsctAtc;
    property IdxConv                 : Double        read GetIdxConv             write SetIdxConv;
    property TaxAccess               : Double        read GetTaxAccess           write SetTaxAccess;
    property MinAccess               : Double        read GetMinAccess           write SetMinAccess;
  // Properties FKCountry, FkState and FKCity following the convention:
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
    property FkCountry[Index:Integer]: TCountry      read GetFkCountry           write SetFkCountry;
    property FkState  [Index:Integer]: TState        read GetFkState             write SetFkState;
    property FkCity   [Index:Integer]: TCity         read GetFkCity              write SetFkCity;
    property DscEnd   [Index:Integer]: string        read GetDscEnd              write SetDscEnd;
    property CmpEnd   [Index:Integer]: string        read GetCmpEnd              write SetCmpEnd;
    property CepEnd   [Index:Integer]: Integer       read GetCepEnd              write SetCepEnd;
    property NumEnd   [Index:Integer]: Integer       read GetNumEnd              write SetNumEnd;
  // Collection Address properties
    property CxpCbr                  : string        read GetCxpCbr              write SetCxpCbr;
    property CxpEnt                  : string        read GetCxpEnt              write SetCxpEnt;
    property FonEnt                  : string        read GetFonEnt              write SetFonEnt;
    property FaxEnt                  : string        read GetFaxEnt              write SetFaxEnt;
    property FonRef                  : string        read GetFonRef              write SetFonRef;
    property FaxCbr                  : string        read GetFaxCbr              write SetFaxCbr;
    property FonCbr                  : string        read GetFonCbr              write SetFonCbr;
    property FkBancos                : TBank         read GetFkBancos            write SetFkBancos;
    property PrfCli                  : string        read GetPrfCli              write SetPrfCli;
    property CrgCli                  : string        read GetCrgCli              write SetCrgCli;
    property FonEmp                  : string        read GetFonEmp              write SetFonEmp;
    property EmpTrb                  : string        read GetEmpTrb              write SetEmpTrb;
    property DtaAdm                  : TDate         read GetDtaAdm              write SetDtaAdm;
    property NumCnh                  : string        read GetNumCnh              write SetNumCnh;
    property DtaExp                  : TDate         read GetDtaExp              write SetDtaExp;
    property ValCnh                  : TDate         read GetValCnh              write SetValCnh;
    property FlagSex                 : TSexType      read GetFlagSex             write SetFlagSex;
    property FlagCnf                 : Boolean       read GetFlagCnf             write SetFlagCnf;
    property FlagTCad                : TTypeOwner    read FFlagTCad              write SetFlagTCad;
    property FlagCnsm                : Boolean       read GetFlagCnsm            write SetFlagCnsm;
    property DtaNascSoc              : TDate         read GetDtaNascSoc          write SetDtaNascSoc;
    property PkPartner               : string        read GetPkPartner           write SetPkPartner;
    property NomSoc                  : string        read GetNomSoc              write SetNomSoc;
    property MailSoc                 : string        read GetMailSoc             write SetMailSoc;
    property NomRef                  : string        read GetNomRef              write SetNomRef;
    property MailRef                 : string        read GetMailRef             write SetMailRef;
    property ObsRef                  : TStrings      read GetObsRef              write SetObsRef;
    property LimCrd                  : Double        read GetLimCrd              write SetLimCrd;
    property PwdAccess               : string        read GetPwdAccess           write SetPwdAccess;
    property CnpjEntr_               : string        read GetCnpjEntr_           write SetCnpjEntr_;
    property IeEntr_                 : string        read GetIeEntr_             write SetIeEntr_;
    property NomMae                  : string        read GetNomMae              write SetNomMae;
    property NomPai                  : string        read GetNomPai              write SetNomPai;
    property SalCli                  : Double        read GetSalCli              write SetSalCli;
    property VlrAlg                  : Double        read GetVlrAlg              write SetVlrAlg;
    property CmpSal                  : Double        read GetCmpSal              write SetCmpSal;
    property ObsPes                  : TStrings      read GetObsPes              write SetObsPes;
    property EscCad                  : string        read GetEscCad              write SetEscCad;
    property OpeAut                  : string        read FOpeAut                write FOpeAut;
    property OpeLib                  : string        read FOpeLib                write FOpeLib;
    property SitBlockAnt             : Integer       read FSitBlockAnt           write FSitBlockAnt;
  end;

var
  CdCustomer: TCdCustomer;

implementation

uses Dado, mSysCad, ProcType, TSysEstq, DB, CadArqSql, Funcoes, FuncoesDB;

{$R *.dfm}

{ TfrmModel1 }

const
  CONVERSION_TYPES: array [TTypeFraction] of string =
    ('<Nenhuma>', 'Peso', 'Percentual Nota Fiscal', 'Volume (m3)', 'Quantidade de Volumes');


procedure TCdCustomer.FormCreate(Sender: TObject);
begin
  vtReferences.NodeDataSize      := SizeOf(TCustomData);
  vtReferences.Images            := Dados.Image16;
  vtReferences.Header.Images     := Dados.Image16;
  vtPartners.NodeDataSize        := SizeOf(TCustomData);
  vtPartners.Images              := Dados.Image16;
  vtPartners.Header.Images       := Dados.Image16;
  vtMovement.NodeDataSize        := SizeOf(TGridData);
  vtMovement.Images              := Dados.Image16;
  vtMovement.Header.Images       := Dados.Image16;
  pgPartners.ActivePageIndex     := 0;
  pgRefCom.ActivePageIndex       := 0;
  pgControl.ActivePageIndex      := 0;
  pgControlCust.ActivePageIndex  := 0;
  pgRefCom.ActivePageIndex       := 0;
  pgPersonalData.ActivePageIndex := 0;
  OnChangePK                     := ChangeOwner;
  OnInternalState                := LocalChangeScrMode;
  Dados.Image16.GetBitmap(36, sbSaveRef.Glyph);
  Dados.Image16.GetBitmap(34, sbInsertRef.Glyph);
  Dados.Image16.GetBitmap(28, sbCancelRef.Glyph);
  Dados.Image16.GetBitmap(36, sbSaveSoc.Glyph);
  Dados.Image16.GetBitmap(34, sbInsertSoc.Glyph);
  Dados.Image16.GetBitmap(28, sbCancelSoc.Glyph);
  inherited;
end;

procedure TCdCustomer.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodesCstm(vtReferences);
  ReleaseTreeNodesCstm(vtPartners);
  ReleaseTreeNodes(vtMovement);
  inherited;
end;

procedure TCdCustomer.ClearCustomerData;
begin
  FkVwVendedores      := 0;
  FkVwRepresentantes  := 0;
  FkTipoBloqueios     := nil;
  FkTabelaPrecos      := nil;
  FkTipoPagamentos    := nil;
  FkMeiosPagamento    := nil;
  FkTipoDescontos     := nil;
  FkVwTransportadoras := 0;
  FkBancos            := nil;
  FkAgent             := 0;
  FkPortosEmb         := 0;
  FkPortosDst         := 0;
  FkTipoEstablishment := 0;
  FkTypeDelivryPeriod := 0;
  FkTipoTabelaFracao  := 0;
  FlagDtaBas          := bdInvoice;
  DiaEms              := 0;
  FlagFobDirigido     := False;
  FlagSameRegion      := False;
  FlagDifAcc          := -1;
  FlagCnsm            := False;
  DsctAtc             := 0.0;
  DsctAut             := 0.0;
  LimCrd              := 0.0;
  PwdAccess           := '';
  IdxConv             := 0.0;
  MinAccess           := 0.0;
  TaxAccess           := 0.0;
  OpeAut              := '';
  OpeLib              := '';
  SitBlockAnt         := 0;
end;

procedure TCdCustomer.ClearCollectionAddress;
begin
  // Index 0 ==> Collection Address
  FkCountry[0] := nil;
  FkState[0]   := nil;
  FkCity[0]    := nil;
  DscEnd[0]    := '';
  CmpEnd[0]    := '';
  CepEnd[0]    := 0;
  NumEnd[0]    := 0;
  FonCbr       := '';
  FaxCbr       := '';
  CxpCbr       := '';
end;

procedure TCdCustomer.ClearDeliveryAddress;
begin
  // Index 1 ==> Delivery Address
  FkCountry[0] := nil;
  FkState[0]   := nil;
  FkCity[0]    := nil;
  DscEnd[0]    := '';
  CmpEnd[0]    := '';
  CepEnd[0]    := 0;
  NumEnd[0]    := 0;
  FonEnt       := '';
  FaxEnt       := '';
  CxpEnt       := '';
  IeEntr_      := '';
  CnpjEntr_    := '';
end;

procedure TCdCustomer.ClearCommercialReferences;
begin
  NomRef  := '';
  FonRef  := '';
  MailRef := '';
  FlagCnf := False;
  ObsRef  := nil;
end;

procedure TCdCustomer.ClearCompanyPartners;
begin
  // Index 2 ==> Partners
  PkPartner    := '';
  NomSoc       := '';
  MailSoc      := '';
  FkCountry[2] := nil;
  FkState[2]   := nil;
  FkCity[2]    := nil;
  DscEnd[2]    := '';
  CmpEnd[2]    := '';
  CepEnd[2]    := 0;
  NumEnd[2]    := 0;
end;

procedure TCdCustomer.ClearDataPersonal;
begin
  // Index 3 ==> Personal Data
  FkCountry[3]            := nil;
  FkState[3]              := nil;
  FkCity[3]               := nil;
  CmpSal                  := 0.0;
  CrgCli                  := '';
  DtaAdm                  := 0;
  DtaExp                  := 0;
  EmpTrb                  := '';
  EscCad                  := '';
  FlagSex                 := stMale;
  FonEmp                  := '';
  NomMae                  := '';
  NomPai                  := '';
  NumCnh                  := '';
  PrfCli                  := '';
  SalCli                  := 0.0;
  VlrAlg                  := 0.0;
  ValCnh                  := 0;
  ObsPes                  := nil;
end;

procedure TCdCustomer.ClearControls;
begin
  Loading := True;
  try
    if (pgControl.ActivePage = tsCustumerData) then
      ClearCustomerData;
    if (pgControl.ActivePage = tsCollectionAddress) then
      ClearCollectionAddress;
    if (pgControl.ActivePage = tsDeliveryAddress) then
      ClearDeliveryAddress;
    if (pgControl.ActivePage = tsComercialReferences) then
      ClearCommercialReferences;
    if (pgControl.ActivePage = tsCompanyPartners) then
      ClearCompanyPartners;
    if (pgControl.ActivePage = tsDataPersonal) then
      ClearDataPersonal;
  finally
    Loading := False;
  end;
end;

function TCdCustomer.GetCepEnd(Index: Integer): Integer;
begin
  Result := 0;
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0: Result := eCep_Cbr.AsInteger;
    1: Result := eCep_Ent.AsInteger;
    2: Result := eCep_Soc.AsInteger;
  end;
end;

function TCdCustomer.GetCmpEnd(Index: Integer): string;
begin
  Result := '';
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0: Result := eCmp_Cbr.Text;
    1: Result := eCmp_Ent.Text;
    2: Result := eCmp_Soc.Text;
  end;
end;

function TCdCustomer.GetCmpSal: Double;
begin
  Result := eCmp_Sal.Value;
end;

function TCdCustomer.GetCnpjEntr_: string;
begin
  Result := eCnpj_Entr.Text;
end;

function TCdCustomer.GetPwdAccess: string;
begin
  Result := ePwd_Access.Text;
end;

function TCdCustomer.GetCrgCli: string;
begin
  Result := eCrg_Cli.Text;
end;

function TCdCustomer.GetCxpCbr: string;
begin
  Result := eCxp_Cbr.Text;
end;

function TCdCustomer.GetCxpEnt: string;
begin
  Result := eCxp_Ent.Text;
end;

function TCdCustomer.GetDiaEms: Integer;
begin
  Result := eDia_Ems.AsInteger;
end;

function TCdCustomer.GetDsctAut: Double;
begin
  Result := eDsct_Aut.Value;
end;

function TCdCustomer.GetDscEnd(Index: Integer): string;
begin
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0: Result := eEnd_Cbr.Text;
    1: Result := eEnd_Ent.Text;
    2: Result := eEnd_Soc.Text;
    3: Result := '';
  end;
end;

function TCdCustomer.GetDsctAtc: Double;
begin
  Result := eDsct_Atc.Value;
end;

function TCdCustomer.GetDtaAdm: TDate;
begin
  Result := eDta_Adm.Date;
end;

function TCdCustomer.GetDtaExp: TDate;
begin
  Result := eDta_Exp.Date;
end;

function TCdCustomer.GetDtaNascSoc: TDate;
begin
  Result := eDta_Nasc_Soc.Date;
end;

function TCdCustomer.GetEmpTrb: string;
begin
  Result := eEmp_Trb.Text;
end;

function TCdCustomer.GetEscCad: string;
begin
  Result := eEsc_Cad.Text;
end;

function TCdCustomer.GetFaxCbr: string;
begin
  Result := eFax_Cbr.Text;
end;

function TCdCustomer.GetFaxEnt: string;
begin
  Result := eFax_Ent.Text;
end;

function TCdCustomer.GetFkAgent: Integer;
begin
  Result := 0;
  with eFk_Vw_Cadastros do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkBancos: TBank;
begin
  Result := nil;
  with eFk_Bancos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TBank(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkCity(Index: Integer): TCity;
begin
  Result := nil;
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0:  with eFk_Municipios__ca do
          if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
            Result := TCity(Items.Objects[ItemIndex]);
    1:  with eFk_Municipios_ent do
          if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
            Result := TCity(Items.Objects[ItemIndex]);
    2:  with eFk_Municipios_soc do
          if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
            Result := TCity(Items.Objects[ItemIndex]);
    3:  with eFk_Municipios_dps do
          if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
            Result := TCity(Items.Objects[ItemIndex]);
  end;
end;

function TCdCustomer.GetFkCountry(Index: Integer): TCountry;
begin
  Result := nil;
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0:  with eFk_Paises__ca do
          if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
            Result := TCountry(Items.Objects[ItemIndex]);
    1:  with eFk_Paises_ent do
          if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
            Result := TCountry(Items.Objects[ItemIndex]);
    2:  with eFk_Paises_soc do
          if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
            Result := TCountry(Items.Objects[ItemIndex]);
    3:  with eFk_Paises_dps do
          if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
            Result := TCountry(Items.Objects[ItemIndex]);
  end;
end;

function TCdCustomer.GetFkMeiosPagamento: TPaymentWay;
begin
  Result := nil;
  with eFk_Meios_Pagamento do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TPaymentWay(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkPortosDst: Integer;
begin
  Result := 0;
  with eFk_Portos__Dst do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkPortosEmb: Integer;
begin
  Result := 0;
  with eFk_Portos__Emb do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkState(Index: Integer): TState;
begin
  Result := nil;
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0: with eFk_Estados__ca do
        if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
          Result := TState(Items.Objects[ItemIndex]);
    1: with eFk_Estados_ent do
        if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
          Result := TState(Items.Objects[ItemIndex]);
    2: with eFk_Estados_soc do
        if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
          Result := TState(Items.Objects[ItemIndex]);
    3: with eFk_Estados_dps do
        if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
          Result := TState(Items.Objects[ItemIndex]);
  end;
end;

function TCdCustomer.GetFkTabelaPrecos: TPriceTable;
begin
  Result := nil;
  with eFk_Tabela_Precos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TPriceTable(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkTipoBloqueios: TTypeBlock;
begin
  Result := nil;
  with eFk_Tipo_Bloqueios do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypeBlock(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkTipoDescontos: TTypeDiscount;
begin
  Result := nil;
  with eFk_Tipo_Descontos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypeDiscount(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkTipoEstablishment: Integer;
begin
  Result := 0;
  with eFk_Tipo_Estabelecimentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkTipoPagamentos: TTypePayment;
begin
  Result := nil;
  with eFk_Tipo_Pagamentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypePayment(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFkVwRepresentantes: Integer;
begin
  Result := 0;
  with eFk_Vw_Representantes do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOwner(Items.Objects[ItemIndex]).PkCadastros;
end;

function TCdCustomer.GetFkVwTransportadoras: Integer;
begin
  Result := 0;
  with eFk_Vw_Transportadoras do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOwner(Items.Objects[ItemIndex]).PkCadastros;
end;

function TCdCustomer.GetFkVwVendedores: Integer;
begin
  Result := 0;
  with eFk_Vw_Vendedores do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOwner(Items.Objects[ItemIndex]).PkCadastros;
end;

function TCdCustomer.GetFlagDtaBas: TBaseDate;
begin
  Result := bdInvoice;
  if (eFlag_DtaBas.ItemIndex > -1) then
    Result := TBaseDate(eFlag_DtaBas.ItemIndex);
end;

function TCdCustomer.GetFonCbr: string;
begin
  Result := eFon_Cbr.Text;
end;

function TCdCustomer.GetFonEmp: string;
begin
  Result := eFon_Emp.Text;
end;

function TCdCustomer.GetFonEnt: string;
begin
  Result := eFon_Ent.Text;
end;

function TCdCustomer.GetFonRef: string;
begin
  Result := eFon_Ref.Text;
end;

function TCdCustomer.GetIeEntr_: string;
begin
  Result := eIe_Entr.Text;
end;

function TCdCustomer.GetLimCrd: Double;
begin
  Result := eLim_Crd.Value;
end;

function TCdCustomer.GetMailRef: string;
begin
  Result := eMail_Ref.Text;
end;

function TCdCustomer.GetMailSoc: string;
begin
  Result := eMail_Soc.Text;
end;

function TCdCustomer.GetNomMae: string;
begin
  Result := eNom_Mae.Text;
end;

function TCdCustomer.GetNomPai: string;
begin
  Result := eNom_Pai.Text;
end;

function TCdCustomer.GetNomRef: string;
begin
  Result := eNom_Ref.Text;
end;

function TCdCustomer.GetNomSoc: string;
begin
  Result := eNom_Soc.Text;
end;

function TCdCustomer.GetNumCnh: string;
begin
  Result := eNum_Cnh.Text;
end;

function TCdCustomer.GetNumEnd(Index: Integer): Integer;
begin
  Result := 0;
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0: Result := eNum_Cbr.AsInteger;
    1: Result := eNum_Ent.AsInteger;
    2: Result := eNum_Soc.AsInteger;
  end;
end;

function TCdCustomer.GetObsPes: TStrings;
begin
  Result := eObs_Pes.Lines;
end;

function TCdCustomer.GetObsRef: TStrings;
begin
  Result := eObs_Ref.Lines;
end;

function TCdCustomer.GetPrfCli: string;
begin
  Result := ePrf_Cli.Text;
end;

function TCdCustomer.GetSalCli: Double;
begin
  Result := eSal_Cli.Value;
end;

function TCdCustomer.GetValCnh: TDate;
begin
  Result := eVal_Cnh.Date;
end;

function TCdCustomer.GetVlrAlg: Double;
begin
  Result := eVlr_Alg.Value;
end;

function TCdCustomer.GetFlagCnsm: Boolean;
begin
  Result := lFlag_Cnsm.Checked;
end;

function TCdCustomer.GetFlagSex: TSexType;
begin
  Result := TSexType(lFlag_Sex.ItemIndex);
end;

function TCdCustomer.GetFlagCnf: Boolean;
begin
  Result := lFlag_Cnf.Checked;
end;

function TCdCustomer.GetPkPartner: string;
begin
  Result := ePk_Socios.Text;
end;

procedure TCdCustomer.LoadDefaults;
var
  aCountries: Smallint;
begin
  if (not ListLoaded) then
  begin
    if (FFlagTCad = toForeigner) then
      aCountries := -1
    else
      aCountries := 1;
    eFk_Vw_Vendedores.Items.AddStrings(dmSysCad.LoadVendors);
    eFk_Vw_Representantes.Items.AddStrings(dmSysCad.LoadRepresentants);
    eFk_Vw_Transportadoras.Items.AddStrings(dmSysCad.LoadCarriers);
    eFk_Vw_Cadastros.Items.AddStrings(dmSysCad.LoadAgents);
    eFk_Tipo_Pagamentos.Items.AddStrings(dmSysCad.LoadTypePayment(True));
    eFk_Tipo_Descontos.Items.AddStrings(dmSysCad.LoadTypeDiscounts(True));
    eFk_Tipo_Bloqueios.Items.AddStrings(dmSysCad.LoadTypeBlock);
    eFk_Tabela_Precos.Items.AddStrings(dmSysCad.LoadPriceTable);
    eFk_Bancos.Items.AddStrings(dmSysCad.LoadBanks);
    eFk_Tipo_Estabelecimentos.Items.AddStrings(dmSysCad.LoadTypeEstablishment);
    eFk_Portos__Emb.Items.AddStrings(dmSysCad.LoadPorts(Dados.Parametros.soCompanyCountry));
    eFk_Portos__Dst.Items.AddStrings(dmSysCad.LoadPorts(FFkCountry));
    eFk_Tipo_Prazo_Entrega.Items.AddStrings(dmSysCad.LoadTypeDelivery);
    Loading := True;
    try
      with eFk_Paises__ca do
      begin
        Items.AddStrings(dmSysCad.LoadCountries(aCountries));
        if (Items.Count = 2) then
        begin
          ItemIndex := 1;
          if Assigned(OnSelect) then
            OnSelect(Self);
        end;
      end;
      with eFk_Paises_ent do
      begin
        Items.AddStrings(dmSysCad.LoadCountries(aCountries));
        if (Items.Count = 2) then
        begin
          ItemIndex := 1;
          if Assigned(OnSelect) then
            OnSelect(Self);
        end;
      end;
      with eFk_Paises_soc do
      begin
        Items.AddStrings(dmSysCad.LoadCountries(aCountries));
        if (Items.Count = 2) then
        begin
          ItemIndex := 1;
          if Assigned(OnSelect) then
            OnSelect(Self);
        end;
      end;
      with eFk_Paises_dps do
      begin
        Items.AddStrings(dmSysCad.LoadCountries(aCountries));
        if (Items.Count = 2) then
        begin
          ItemIndex := 1;
          if Assigned(OnSelect) then
            OnSelect(Self);
        end;
      end;
    finally
      Loading := False;
    end;
    LoadFlagDtaBas;
    ListLoaded := True;
  end;
end;

procedure TcdCustomer.LoadCustomerData;
var
  aCustomer: TCustomer;
begin
  if (dlCustomer in FDataLoaded) then exit;
  FDataLoaded           := FDataLoaded + [dlCustomer];
  aCustomer             := dmSysCad.GetCustomerData(Pk, FFkCountry, FFlagTCad);
  FCstmIsChild          := (FFkCountry >= 0);
  SetFlagTCad(FFlagTCad);
  try
    if (aCustomer <> nil) then
    begin
      FkVwVendedores      := aCustomer.FkVendor;
      FkVwRepresentantes  := aCustomer.FkRepresentant;
      FkTipoBloqueios     := aCustomer.FkTypeBlock;
      FkTabelaPrecos      := aCustomer.FkPriceTable;
      FkTipoPagamentos    := aCustomer.FkTypePayment;
      FkMeiosPagamento    := aCustomer.FkPaymentWay;
      FkTipoDescontos     := aCustomer.FkTypeDiscount;
      FkVwTransportadoras := aCustomer.FkCarrier;
      FkBancos            := aCustomer.FkBank;
      FkAgent             := aCustomer.FkAgent;
      FkPortosEmb         := aCustomer.FkPortEmb;
      FkPortosDst         := aCustomer.FkPortDst;
      FkTipoEstablishment := aCustomer.FkTypeEstablishment;
      FkTypeDelivryPeriod := aCustomer.FkDeliveryPeriod;
      FkTipoTabelaFracao  := aCustomer.FkTypeFraction;
      FlagDtaBas          := aCustomer.FlagDtaBas;
      DiaEms              := aCustomer.DiaEms;
      FlagFobDirigido     := aCustomer.FlagFobDirigido;
      FlagSameRegion      := aCustomer.FlagSameRegion;
      FlagDifAcc          := aCustomer.FlagDifAcc;
      FlagCnsm            := ((aCustomer.FlagCnsm) or (FFlagTCad = toPeople));
      DsctAtc             := aCustomer.DsctAtc;
      DsctAut             := aCustomer.DsctAut;
      LimCrd              := aCustomer.LimCred;
      PwdAccess           := aCustomer.PwdAccess;
      IdxConv             := aCustomer.IdxConv;
      MinAccess           := aCustomer.MinAccess;
      TaxAccess           := aCustomer.TaxAccess;
      OpeAut              := aCustomer.OpeAut;
      OpeLib              := aCustomer.OpeLib;
      SitBlockAnt         := aCustomer.SitBlockAnt;
    end
    else
      ClearControls;
    LoadTypeMoviment;
  finally
    FreeAndNil(aCustomer);
  end;
end;

procedure TCdCustomer.LoadCollectionAddress;
var
  aCol: TCollectionAddress;
begin
  FClAdIsChild := False;
  if (dlCollection in FDataLoaded) then exit;
  FDataLoaded    := FDataLoaded + [dlCollection];
  // Index 0 ==> Collection Address
  aCol := dmSysCad.GetCollectionData(Pk);
  if (aCol <> nil) then
  begin
    with aCol do
    begin
      FClAdIsChild := True;
      FkCountry[0] := Address.FkCity.FkState.FkCountry;
      FkState[0]   := Address.FkCity.FkState;
      FkCity[0]    := Address.FkCity;
      DscEnd[0]    := Address.EndAdd;
      CmpEnd[0]    := Address.CmpEnd;
      CepEnd[0]    := Address.CepAdd;
      NumEnd[0]    := Address.NumAdd;
      FonCbr       := Phones.Items[0].FonCad;
      FaxCbr       := Phones.Items[1].FonCad;
      CxpCbr       := Address.CxpAdd;
    end;
  end
  else
    ClearControls;
end;

procedure TCdCustomer.LoadDeliveryAddress;
var
  aDlv: TDeliveryAddress;
begin
  FDlAdIsChild := False;
  if (dlDelivery in FDataLoaded) then exit;
  FDataLoaded    := FDataLoaded + [dlDelivery];
  // Index 1 ==> Delivery Address
  aDlv := dmSysCad.GetDeliveryAddressData(Pk);
  if (aDlv <> nil) then
  begin
    with aDlv do
    begin
      FDlAdIsChild := True;
      FkCountry[1] := Address.FkCity.FkState.FkCountry;
      FkState[1]   := Address.FkCity.FkState;
      FkCity[1]    := Address.FkCity;
      DscEnd[1]    := Address.EndAdd;
      CmpEnd[1]    := Address.CmpEnd;
      CepEnd[1]    := Address.CepAdd;
      NumEnd[1]    := Address.NumAdd;
      FonEnt       := Phones.Items[0].FonCad;
      FaxEnt       := Phones.Items[1].FonCad;
      CxpEnt       := Address.CxpAdd;
      IeEntr_      := IEEntr;
      CnpjEntr_    := CNPJEntr;
    end;
  end
  else
    ClearControls;
end;

procedure TCdCustomer.LoadCommercialReferences;
var
  Data: PCustomData;
begin
  if (dlReferences in FDataLoaded) then exit;
  FDataLoaded := FDataLoaded + [dlReferences];
  LoadReferencesGrid;
  if (vtReferences.FocusedNode <> nil) then
  begin
    Data := vtReferences.GetNodeData(vtReferences.FocusedNode);
    if (Data <> nil) and (Data^.DataRef <> nil) then
    begin
      MailRef := Data^.DataRef.eMailRef;
      FlagCnf := Data^.DataRef.FlagCnf;
      FonRef  := Data^.DataRef.FonRef;
      NomRef  := Data^.DataRef.NomRef;
      ObsRef  := Data^.DataRef.ObsRef;
    end;
  end;
end;

procedure TCdCustomer.LoadCompanyPartners;
var
  Data: PCustomData;
begin
  if (dlPartners in FDataLoaded) then exit;
  FDataLoaded      := FDataLoaded + [dlPartners];
  LoadPartnersGrid;
  // Index 2 ==> Partners
  if (vtPartners.FocusedNode <> nil) then
  begin
    Data := vtPartners.GetNodeData(vtPartners.FocusedNode);
    if (Data <> nil) and (Data^.DataPrt <> nil) then
    begin
      MailSoc      := Data^.DataPrt.eMailSoc;
      NomSoc       := Data^.DataPrt.NomSoc;
      PkPartner    := Data^.DataPrt.PkPartner;
      DtaNascSoc   := Data^.DataPrt.DtaNasc;
      FkCountry[2] := Data^.DataPrt.Address.FkCity.FkState.FkCountry;
      FkState[2]   := Data^.DataPrt.Address.FkCity.FkState;
      FkCity[2]    := Data^.DataPrt.Address.FkCity;
      DscEnd[2]    := Data^.DataPrt.Address.EndAdd;
      CmpEnd[2]    := Data^.DataPrt.Address.CmpEnd;
      CepEnd[2]    := Data^.DataPrt.Address.CepAdd;
      NumEnd[2]    := Data^.DataPrt.Address.NumAdd;
    end;
  end;
end;

procedure TCdCustomer.LoadDataPersonal;
var
  aPersonalData: TPersonalData;
begin
  FPDatIsChild   := False;
  if (dlPersonal in FDataLoaded) then exit;
  FDataLoaded    := FDataLoaded + [dlPersonal];
  // Index 3 ==> Personal Data
  aPersonalData  := dmSysCad.GetPersonalData(Pk);
  try
    if aPersonalData <> nil then
    begin
      FPDatIsChild := True;
      FkCountry[3] := aPersonalData.FkCity.FkState.FkCountry;
      FkState[3]   := aPersonalData.FkCity.FkState;
      FkCity[3]    := aPersonalData.FkCity;
      CmpSal       := aPersonalData.CmpVal;
      CrgCli       := aPersonalData.CrgCli;
      DtaAdm       := aPersonalData.DtaAdm;
      DtaExp       := aPersonalData.DtaExp;
      EmpTrb       := aPersonalData.EmpTrb;
      EscCad       := aPersonalData.EscCad;
      FlagSex      := aPersonalData.FlagSex;
      FonEmp       := aPersonalData.FonEmp;
      NomMae       := aPersonalData.NomMae;
      NomPai       := aPersonalData.NomPai;
      NumCnh       := aPersonalData.NumCnh;
      PrfCli       := aPersonalData.PrfCli;
      SalCli       := aPersonalData.SalCli;
      VlrAlg       := aPersonalData.ValCnh;
      ValCnh       := aPersonalData.VlrAlg;
      ObsPes       := aPersonalData.ObsPes;
    end
    else
      ClearControls;
  finally
    FreeAndNil(aPersonalData);
  end;
end;

procedure TCdCustomer.MoveDataToControls;
begin
  if (ScrState in SCROLL_MODE) then
  begin
    Loading := True;
    try
      FDataLoaded := [];
      if (pgControl.ActivePage = tsCustumerData) then
        LoadCustomerData;
      if (pgControl.ActivePage = tsCollectionAddress) then
        LoadCollectionAddress;
      if (pgControl.ActivePage = tsDeliveryAddress) then
        LoadDeliveryAddress;
      if (pgControl.ActivePage = tsComercialReferences) then
        LoadCommercialReferences;
      if (pgControl.ActivePage = tsCompanyPartners) then
        LoadCompanyPartners;
      if (pgControl.ActivePage = tsDataPersonal) then
        LoadDataPersonal;
    finally
      Loading := False;
    end;
  end;
end;

procedure TCdCustomer.SaveCustomerData;
var
  aCustomer         : TCustomer;
begin
  aCustomer                       := TCustomer.Create;
  try
    aCustomer.FkVendor            := FkVwVendedores;
    aCustomer.FkRepresentant      := FkVwRepresentantes;
    aCustomer.FkTypeBlock         := FkTipoBloqueios;
    aCustomer.FkPriceTable        := FkTabelaPrecos;
    aCustomer.FkTypePayment       := FkTipoPagamentos;
    aCustomer.FkPaymentWay        := FkMeiosPagamento;
    aCustomer.FkTypeDiscount      := FkTipoDescontos;
    aCustomer.FkCarrier           := FkVwTransportadoras;
    aCustomer.FkBank              := FkBancos;
    aCustomer.FkAgent             := FkAgent;
    aCustomer.FkPortEmb           := FkPortosEmb;
    aCustomer.FkPortDst           := FkPortosDst;
    aCustomer.FkTypeEstablishment := FkTipoEstablishment;
    aCustomer.FkDeliveryPeriod    := FkTypeDelivryPeriod;
    aCustomer.FkTypeFraction      := FkTipoTabelaFracao;
    aCustomer.FlagDtaBas          := FlagDtaBas;
    aCustomer.DiaEms              := DiaEms;
    aCustomer.FlagFobDirigido     := FlagFobDirigido;
    aCustomer.FlagSameRegion      := FlagSameRegion;
    aCustomer.FlagDifAcc          := FlagDifAcc;
    aCustomer.FlagCnsm            := FlagCnsm;
    aCustomer.DsctAtc             := DsctAtc;
    aCustomer.DsctAut             := DsctAut;
    aCustomer.LimCred             := LimCrd;
    aCustomer.IdxConv             := IdxConv;
    aCustomer.MinAccess           := MinAccess;
    aCustomer.TaxAccess           := TaxAccess;
    aCustomer.PwdAccess           := PwdAccess;
    aCustomer.OpeAut              := OpeAut;
    aCustomer.OpeLib              := OpeLib;
    aCustomer.SitBlockAnt         := SitBlockAnt;
    if (CstmIsChild) then
      dmSysCad.SaveCustomerData(Pk, aCustomer, dbmEdit)
    else
      dmSysCad.SaveCustomerData(Pk, aCustomer, dbmInsert);
  finally
    FreeAndNil(aCustomer);
  end;
end;

procedure TCdCustomer.SaveCollectionAddress;
var
  aCollectionAddress: TCollectionAddress;
begin
  // Index 0 ==> Collection Address
  aCollectionAddress                   := TCollectionAddress.Create;
  try
    with aCollectionAddress do
    begin
      Address.FkCity.FkState.FkCountry := FkCountry[0];
      Address.FkCity.FkState           := FkState[0];
      Address.FkCity                   := FkCity[0];
      Address.EndAdd                   := DscEnd[0];
      Address.CmpEnd                   := CmpEnd[0];
      Address.CepAdd                   := CepEnd[0];
      Address.NumAdd                   := NumEnd[0];
      Phones.Items[0].FonCad           := FonCbr;
      Phones.Items[1].FonCad           := FaxCbr;
      Address.CxpAdd                   := CxpCbr;
    end;
    if (ClAdIsChild) then
      dmSysCad.SaveCollectionAddress(Pk, aCollectionAddress, dbmEdit)
    else
      dmSysCad.SaveCollectionAddress(Pk, aCollectionAddress, dbmInsert);
  finally
    FreeAndNil(aCollectionAddress);
  end;
end;

procedure TCdCustomer.SaveDeliveryAddress;
var
  aDeliveryAddress  : TDeliveryAddress;
begin
  // Index 1 ==> Delivery Address
  aDeliveryAddress                     := TDeliveryAddress.Create;
  try
    with aDeliveryAddress do
    begin
      Address.FkCity.FkState.FkCountry := FkCountry[1];
      Address.FkCity.FkState           := FkState[1];
      Address.FkCity                   := FkCity[1];
      Address.EndAdd                   := DscEnd[1];
      Address.CmpEnd                   := CmpEnd[1];
      Address.CepAdd                   := CepEnd[1];
      Address.NumAdd                   := NumEnd[1];
      Phones.Items[0].FonCad           := FonEnt;
      Phones.Items[1].FonCad           := FaxEnt;
      Address.CxpAdd                   := CxpEnt;
      IEEntr                           := IeEntr_;
      CNPJEntr                         := CnpjEntr_;
    end;
    if (DlAdIsChild) then
      dmSysCad.SaveDeliveryAddress(Pk, aDeliveryAddress, dbmEdit)
    else
      dmSysCad.SaveDeliveryAddress(Pk, aDeliveryAddress, dbmInsert);
  finally
    FreeAndNil(aDeliveryAddress);
  end;
end;

procedure TCdCustomer.SaveCommercialReferences;
var
  Node              : PVirtualNode;
  Data              : PCustomData;
begin
  Node := vtReferences.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtReferences.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRef <> nil) and
       (Data^.State in UPDATE_MODE) then
    begin
      dmSysCad.SaveReferenceData(Pk, Data^.DataRef, Data^.State);
      Data^.State := dbmBrowse;
    end;
    vtReferences.GetNext(Node);
  end;
end;

procedure TCdCustomer.SaveCompanyPartners;
var
  Node              : PVirtualNode;
  Data              : PCustomData;
begin
  Node := vtPartners.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtPartners.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataPrt <> nil) and
       (Data^.State in UPDATE_MODE) then
    begin
      dmSysCad.SavePartnerData(Pk, Data^.DataPrt, Data^.State);
      Data^.State := dbmBrowse;
    end;
    vtPartners.GetNext(Node);
  end;
end;

procedure TCdCustomer.SaveDataPersonal;
var
  aPersonalData     : TPersonalData;
begin
  aPersonalData                            := TPersonalData.Create;
  try
    aPersonalData.FkCity.FkState.FkCountry := FkCountry[3];
    aPersonalData.FkCity.FkState           := FkState[3];
    aPersonalData.FkCity                   := FkCity[3];
    aPersonalData.CmpVal                   := CmpSal;
    aPersonalData.CrgCli                   := CrgCli;
    aPersonalData.DtaAdm                   := DtaAdm;
    aPersonalData.DtaExp                   := DtaExp;
    aPersonalData.EmpTrb                   := EmpTrb;
    aPersonalData.EscCad                   := EscCad;
    aPersonalData.FlagSex                  := FlagSex;
    aPersonalData.FonEmp                   := FonEmp;
    aPersonalData.NomMae                   := NomMae;
    aPersonalData.NomPai                   := NomPai;
    aPersonalData.NumCnh                   := NumCnh;
    aPersonalData.PrfCli                   := PrfCli;
    aPersonalData.SalCli                   := SalCli;
    aPersonalData.ValCnh                   := VlrAlg;
    aPersonalData.VlrAlg                   := ValCnh;
    aPersonalData.ObsPes                   := ObsPes;
    if (PDatIsChild) then
      dmSysCad.SavePersonalData(Pk, aPersonalData, dbmEdit)
    else
      dmSysCad.SavePersonalData(Pk, aPersonalData, dbmInsert);
  finally
    FreeAndNil(aPersonalData);
  end;
end;

procedure TCdCustomer.SaveIntoDB;
begin
  if (Pk = 0) then exit;
  if (pgControl.ActivePage = tsCustumerData) and
     (TDBMode(tsCustumerData.Tag) in UPDATE_MODE) then
    SaveCustomerData;
  if (pgControl.ActivePage = tsCollectionAddress) and
     (TDBMode(tsCollectionAddress.Tag) in UPDATE_MODE) then
    SaveCollectionAddress;
  if (pgControl.ActivePage = tsDeliveryAddress) and
     (TDBMode(tsDeliveryAddress.Tag) in UPDATE_MODE) then
    SaveDeliveryAddress;
  if (pgControl.ActivePage = tsComercialReferences) and
     (TDBMode(tsComercialReferences.Tag) in UPDATE_MODE) then
    SaveCommercialReferences;
  if (pgControl.ActivePage = tsCompanyPartners) and
     (TDBMode(tsCompanyPartners.Tag) in UPDATE_MODE) then
    SaveCompanyPartners;
  if (pgControl.ActivePage = tsDataPersonal) and
     (TDBMode(tsDataPersonal.Tag) in UPDATE_MODE) then
    SaveDataPersonal;
end;

procedure TCdCustomer.SetCepEnd(Index: Integer; const Value: Integer);
begin
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0: eCep_Cbr.AsInteger := Value;
    1: eCep_Ent.AsInteger := Value;
    2: eCep_Soc.AsInteger := Value;
  end;
end;

procedure TCdCustomer.SetCmpEnd(Index: Integer; const Value: string);
begin
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0: eCmp_Cbr.Text := Value;
    1: eCmp_Ent.Text := Value;
    2: eCmp_Soc.Text := Value;
  end;
end;

procedure TCdCustomer.SetCmpSal(const Value: Double);
begin
  eCmp_Sal.Value := Value;
end;

procedure TCdCustomer.SetCnpjEntr_(const Value: string);
begin
  eCnpj_Entr.Text := Value;
end;

procedure TCdCustomer.SetPwdAccess(const Value: string);
begin
  ePwd_Access.Text := Value;
end;

procedure TCdCustomer.SetCrgCli(const Value: string);
begin
  eCrg_Cli.Text := Value;
end;

procedure TCdCustomer.SetCxpCbr(const Value: string);
begin
  eCxp_Cbr.Text := Value;
end;

procedure TCdCustomer.SetCxpEnt(const Value: string);
begin
  eCxp_Ent.Text := Value;
end;

procedure TCdCustomer.SetDiaEms(const Value: Integer);
begin
  eDia_Ems.Value := Value;
end;

procedure TCdCustomer.SetDsctAut(const Value: Double);
begin
  eDsct_Aut.Value := Value;
end;

procedure TCdCustomer.SetDscEnd(Index: Integer; const Value: string);
begin
    // Index 0 ==> Collection Address
    // Index 1 ==> Delivery Address
    // Index 2 ==> Partners
    // Index 3 ==> Personal Data
  case Index of
    0: eEnd_Cbr.Text := Value;
    1: eEnd_Ent.Text := Value;
    2: eEnd_Soc.Text := Value;
  end;
end;

procedure TCdCustomer.SetDsctAtc(const Value: Double);
begin
  eDsct_Atc.Value := Value;
end;

procedure TCdCustomer.SetDtaAdm(const Value: TDate);
begin
  eDta_Adm.Date := Value;
end;

procedure TCdCustomer.SetDtaExp(const Value: TDate);
begin
  eDta_Exp.Date := Value;
end;

procedure TCdCustomer.SetDtaNascSoc(const Value: TDate);
begin
  eDta_Nasc_Soc.Date := Value;
end;

procedure TCdCustomer.SetEmpTrb(const Value: string);
begin
  eEmp_Trb.Text := Value;
end;

procedure TCdCustomer.SetEscCad(const Value: string);
begin
  eEsc_Cad.Text := Value;
end;

procedure TCdCustomer.SetFaxCbr(const Value: string);
begin
  eFax_Cbr.Text := Value;
end;

procedure TCdCustomer.SetFaxEnt(const Value: string);
begin
  eFax_Ent.Text := Value;
end;

procedure TCdCustomer.SetFkAgent(const Value: Integer);
begin
  with eFk_Vw_Cadastros do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      SetIndexFromIntegerValue(Value);
  end;
end;

procedure TCdCustomer.SetFkBancos(const Value: TBank);
begin
  with eFk_Bancos do
  begin
    ItemIndex := -1;
    if (Value <> nil) then
      SetIndexFromObjectValue(Value.PkBank);
  end;
end;

procedure TCdCustomer.SetFkCity(Index: Integer; const Value: TCity);
begin
  // Index 0 ==> Collection Address
  // Index 1 ==> Delivery Address
  // Index 2 ==> Partners
  // Index 3 ==> Personal Data
  case Index of
    0: with eFk_Municipios__ca do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkCity);
       end;
    1: with eFk_Municipios_ent do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkCity);
       end;
    2: with eFk_Municipios_soc do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkCity);
       end;
    3: with eFk_Municipios_dps do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkCity);
       end;
  end;
end;

procedure TCdCustomer.SetFkCountry(Index: Integer; const Value: TCountry);
begin
  // Index 0 ==> Collection Address
  // Index 1 ==> Delivery Address
  // Index 2 ==> Partners
  // Index 3 ==> Personal Data
  case Index of
    0: with eFk_Paises__ca do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkCountry);
       end;
    1: with eFk_Paises_ent do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkCountry);
       end;
    2: with eFk_Paises_soc do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkCountry);
       end;
    3: with eFk_Paises_dps do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkCountry);
       end;
  end;
end;

procedure TCdCustomer.SetFkMeiosPagamento(const Value: TPaymentWay);
var
  i: integer;
begin
  with eFk_Meios_Pagamento do
  begin
    ItemIndex := -1;
    if (Value = nil) then exit;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (TPaymentWay(Items.Objects[i]).PkPaymentWay = Value.PkPaymentWay) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdCustomer.SetFkPortosDst(const Value: Integer);
begin
  with eFk_Portos__Dst do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      SetIndexFromIntegerValue(Value);
  end;
end;

procedure TCdCustomer.SetFkPortosEmb(const Value: Integer);
begin
  with eFk_Portos__Emb do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      SetIndexFromIntegerValue(Value);
  end;
end;

procedure TCdCustomer.SetFkState(Index: Integer; const Value: TState);
begin
  // Index 0 ==> Collection Address
  // Index 1 ==> Delivery Address
  // Index 2 ==> Partners
  // Index 3 ==> Personal Data
  case Index of
    0: with eFk_Estados__ca do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkState);
       end;
    1: with eFk_Estados_ent do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkState);
       end;
    2: with eFk_Estados_soc do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkState);
       end;
    3: with eFk_Estados_dps do
       begin
         ItemIndex := -1;
         if (Value <> nil) then
           SetIndexFromObjectValue(Value.PkState);
       end;
  end;
end;

procedure TCdCustomer.SetFkTabelaPrecos(const Value: TPriceTable);
begin
  with eFk_Tabela_Precos do
  begin
    ItemIndex := -1;
    if (Value <> nil) then
      SetIndexFromObjectValue(Value.PkPriceTable);
  end;
end;

procedure TCdCustomer.SetFkTipoBloqueios(const Value: TTypeBlock);
begin
  with eFk_Tipo_Bloqueios do
  begin
    ItemIndex := -1;
    if (Value <> nil) then
      SetIndexFromObjectValue(Value.PkTypeBlock);
  end;
end;

procedure TCdCustomer.SetFkTipoDescontos(const Value: TTypeDiscount);
begin
  with eFk_Tipo_Descontos do
  begin
    ItemIndex := -1;
    if (Value <> nil) then
      SetIndexFromObjectValue(Value.PkTypeDiscount);
  end;
end;

procedure TCdCustomer.SetFkTipoEstablishment(const Value: Integer);
begin
  with eFk_Tipo_Estabelecimentos do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      SetIndexFromIntegerValue(Value);
  end;
end;

procedure TCdCustomer.SetFkTipoPagamentos(const Value: TTypePayment);
begin
  with eFk_Tipo_Pagamentos do
  begin
    ItemIndex := -1;
    if (Value <> nil) then
      SetIndexFromObjectValue(Value.PkTypePgto);
  end;
end;

procedure TCdCustomer.SetFkVwRepresentantes(const Value: Integer);
begin
  with eFk_Vw_Representantes do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      SetIndexFromObjectValue(Value);
  end;
end;

procedure TCdCustomer.SetFkVwTransportadoras(const Value: Integer);
begin
  with eFk_Vw_Transportadoras do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      SetIndexFromObjectValue(Value);
  end;
end;

procedure TCdCustomer.SetFkVwVendedores(const Value: Integer);
begin
  with eFk_Vw_Vendedores do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      SetIndexFromObjectValue(Value);
  end;
end;

procedure TCdCustomer.SetFlagDtaBas(const Value: TBaseDate);
begin
  eFlag_DtaBas.ItemIndex := Ord(Value);
end;

procedure TCdCustomer.SetFonCbr(const Value: string);
begin
  eFon_Cbr.Text := Value;
end;

procedure TCdCustomer.SetFonEmp(const Value: string);
begin
  eFon_Emp.Text := Value;
end;

procedure TCdCustomer.SetFonEnt(const Value: string);
begin
  eFon_Ent.Text := Value;
end;

procedure TCdCustomer.SetFonRef(const Value: string);
begin
  eFon_Ref.Text := Value;
end;

procedure TCdCustomer.SetIeEntr_(const Value: string);
begin
  eFon_Ref.Text := Value;
end;

procedure TCdCustomer.SetLimCrd(const Value: Double);
begin
  eLim_Crd.Value := Value;
end;

procedure TCdCustomer.SetMailRef(const Value: string);
begin
  eMail_Ref.Text := Value;
end;

procedure TCdCustomer.SetMailSoc(const Value: string);
begin
  eMail_Soc.Text := Value;
end;

procedure TCdCustomer.SetNomMae(const Value: string);
begin
  eNom_Mae.Text := Value;
end;

procedure TCdCustomer.SetNomPai(const Value: string);
begin
  eNom_Pai.Text := Value;
end;

procedure TCdCustomer.SetNomRef(const Value: string);
begin
  eNom_Ref.Text := Value;
end;

procedure TCdCustomer.SetNomSoc(const Value: string);
begin
  eNom_Soc.Text := Value;
end;

procedure TCdCustomer.SetNumCnh(const Value: string);
begin
  eNum_Cnh.Text := Value;
end;

procedure TCdCustomer.SetNumEnd(Index: Integer; const Value: Integer);
begin
  // Index 0 ==> Collection Address
  // Index 1 ==> Delivery Address
  // Index 2 ==> Partners
  // Index 3 ==> Personal Data
  case Index of
    0: eNum_Cbr.Value := Value;
    1: eNum_Ent.Value := Value;
    2: eNum_Soc.Value := Value;
  end;
end;

procedure TCdCustomer.SetObsPes(const Value: TStrings);
begin
  eObs_Pes.Lines.Clear;
  if (Value <> nil) then
    eObs_Pes.Lines.Assign(Value);
end;

procedure TCdCustomer.SetObsRef(const Value: TStrings);
begin
  eObs_Ref.Lines.Clear;
  if (Value <> nil) then
    eObs_Ref.Lines.Assign(Value);
end;

procedure TCdCustomer.SetPrfCli(const Value: string);
begin
  ePrf_Cli.Text := Value;
end;

procedure TCdCustomer.SetSalCli(const Value: Double);
begin
  eSal_Cli.Value := Value;
end;

procedure TCdCustomer.SetValCnh(const Value: TDate);
begin
  eVal_Cnh.Date := Value;
end;

procedure TCdCustomer.SetVlrAlg(const Value: Double);
begin
  eVlr_Alg.Value := Value;
end;

procedure TCdCustomer.SetFlagCnsm(const Value: Boolean);
begin
  lFlag_Cnsm.Checked := Value;
end;

procedure TCdCustomer.SetFlagSex(const Value: TSexType);
begin
  lFlag_Sex.ItemIndex := Ord(Value);
end;

procedure TCdCustomer.SetFlagCnf(const Value: Boolean);
begin
  lFlag_Cnf.Checked := Value;
end;

procedure TCdCustomer.SetPkPartner(const Value: string);
begin
  ePk_Socios.Text := Value;
end;


procedure TCdCustomer.pgControlChange(Sender: TObject);
begin
  MoveDataToControls;
end;

procedure TCdCustomer.LoadFlagDtaBas;
var
  i: TBaseDate;
const
  S_BASE_DATE: array [bdInvoice..bdTyped] of string =
    ('Data do Faturamento', 'Data do Pedido', 'Data da Entrega', 'Data Informada');
begin
  eFlag_DtaBas.ReleaseObjects;
  for i := bdInvoice to bdTyped do
    eFlag_DtaBas.Items.AddObject(S_BASE_DATE[i], TObject(Integer(i)));
end;

procedure TCdCustomer.eFk_Paises__caSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with dmSysCad do
    with eFk_Paises__ca do
    begin
      if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
      begin
        eFk_Estados__ca.ReleaseObjects;
        eFk_Estados__ca.Items.AddStrings(LoadStates(TCountry(Items.Objects[ItemIndex])));
      end;
    end;
end;

procedure TCdCustomer.eFk_Estados__caSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Estados__ca do
  begin
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
    begin
      eFk_Municipios__ca.ReleaseObjects;
      eFk_Municipios__ca.Items.AddStrings(dmSysCad.LoadCities(TState(Items.Objects[ItemIndex])));
    end;
  end;
end;

procedure TCdCustomer.eFk_Paises_entSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Paises_ent do
  begin
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
    begin
      eFk_Estados_ent.ReleaseObjects;
      eFk_Estados_ent.Items.AddStrings(dmSysCad.LoadStates(TCountry(Items.Objects[ItemIndex])));
    end;
  end;
end;

procedure TCdCustomer.eFk_Estados_entSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Estados_ent do
  begin
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
    begin
      eFk_Municipios_ent.ReleaseObjects;
      eFk_Municipios_ent.Items.AddStrings(dmSysCad.LoadCities(TState(Items.Objects[ItemIndex])));
    end;
  end;
end;

procedure TCdCustomer.eFk_Paises_socSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Paises_soc do
  begin
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
    begin
      eFk_Estados_soc.ReleaseObjects;
      eFk_Estados_soc.Items.AddStrings(dmSysCad.LoadStates(TCountry(Items.Objects[ItemIndex])));
    end;
  end;
end;

procedure TCdCustomer.eFk_Estados_socSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Estados_soc do
  begin
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
    begin
      eFk_Municipios_soc.ReleaseObjects;
      eFk_Municipios_soc.Items.AddStrings(dmSysCad.LoadCities(TState(Items.Objects[ItemIndex])));
    end;
  end;
end;

procedure TCdCustomer.eFk_Paises_dpsSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Paises_dps do
  begin
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
    begin
      eFk_Estados_dps.ReleaseObjects;
      eFk_Estados_dps.Items.AddStrings(dmSysCad.LoadStates(TCountry(Items.Objects[ItemIndex])));
    end;
  end;
end;

procedure TCdCustomer.eFk_Estados_dpsSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Estados_dps do
  begin
    if (ItemIndex > 0) and (Items.Objects[ItemIndex] <> nil) then
    begin
      eFk_Municipios_dps.ReleaseObjects;
      eFk_Municipios_dps.Items.AddStrings(dmSysCad.LoadCities(TState(Items.Objects[ItemIndex])));
    end;
  end;
end;

procedure TCdCustomer.ChangeOwner(Sender: TObject);
begin
  tsCompanyPartners.TabVisible := (FFlagTCad = toCompany);
  tsDataPersonal.TabVisible    := (FFlagTCad = toPeople);
  pgControlChange(Sender);
end;

procedure TCdCustomer.LocalChangeScrMode(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  pgControl.ActivePage.Tag := Ord(AState);
end;

procedure TCdCustomer.LoadPartnersGrid;
var
  Node: PVirtualNode;
  Data: PCustomData;
  i   : Integer;
begin
  ReleaseTreeNodesCstm(vtPartners);
  with dmSysCad.GetPartnersData(Pk) do
  begin
    vtPartners.BeginUpdate;
    try
      for i := 0 to Count - 1 do
      begin
        Node := vtPartners.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtPartners.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.TypeGridData := tgdPartners;
            Data^.Level        := 0;
            Data^.Node         := Node;
            Data^.Index        := Items[i].Index;
            Data^.DataPrt      := TPartner.Create(nil);
            Data^.DataPrt.Assign(Items[i]);
          end;
        end;
      end;
    finally
      vtPartners.EndUpdate;
    end;
  end;
  if (vtPartners.RootNodeCount > 0) then
  begin
    vtPartners.FocusedNode := vtPartners.GetFirst;
    vtPartners.Selected[vtPartners.FocusedNode] := True;
  end;
end;

procedure TCdCustomer.LoadReferencesGrid;
var
  Node: PVirtualNode;
  Data: PCustomData;
  i   : Integer;
begin
  ReleaseTreeNodesCstm(vtReferences);
  with dmSysCad.GetReferenceData(Pk) do
  begin
    vtReferences.BeginUpdate;
    try
      for i := 0 to Count - 1 do
      begin
        Node := vtReferences.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtReferences.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.TypeGridData := tgdReferences;
            Data^.Level        := 0;
            Data^.Node         := Node;
            Data^.Index        := Items[i].Index;
            Data^.DataRef      := TReference.Create(nil);
            Data^.DataRef.Assign(Items[i]);
          end;
        end;
      end;
    finally
      vtReferences.EndUpdate;
    end;
  end;
  if (vtReferences.RootNodeCount > 0) then
  begin
    vtReferences.FocusedNode := vtReferences.GetFirst;
    vtReferences.Selected[vtReferences.FocusedNode] := True;
  end;
end;

procedure TCdCustomer.ReleaseTreeNodesCstm(ATree: TVirtualStringTree);
var
  Node: PVirtualNode;
  Data: PCustomData;
begin
  if (ATree.RootNodeCount = 0) then exit;
  ATree.BeginUpdate;
  try
    Node := ATree.GetFirst;
    while (Node <> nil) do
    begin
      Data := ATree.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level   := 0;
        Data^.Node    := nil;
        if (Data^.TypeGridData = tgdReferences) and (Data^.DataRef <> nil) then
        begin
          Data^.DataRef.Free;
          Data^.DataRef := nil;
        end;
        if (Data^.TypeGridData = tgdPartners) and (Data^.DataPrt <> nil) then
        begin
          Data^.DataPrt.Free;
          Data^.DataPrt := nil;
        end;
      end;
      Node := ATree.GetNext(Node);
    end;
    ATree.Clear;
  finally
    ATree.EndUpdate;
  end;
end;

procedure TCdCustomer.TreeViewGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PCustomData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or
     ((Data^.TypeGridData = tgdPartners) and (Data^.DataPrt = nil)) or
     ((Data^.TypeGridData = tgdReferences) and (Data^.DataRef = nil)) then
    exit;
  if (Data^.TypeGridData = tgdPartners) then
  begin
    case Column of
      0: CellText := Data^.DataPrt.NomSoc;
      1: CellText := Data^.DataPrt.eMailSoc;
    end;
  end;
  if (Data^.TypeGridData = tgdReferences) then
  begin
    case Column of
      0: CellText := Data^.DataRef.NomRef;
      1: CellText := Data^.DataRef.FonRef;
      2: CellText := Data^.DataRef.eMailRef;
    end;
  end;
end;

procedure TCdCustomer.TreeViewFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PCustomData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or
     ((Data^.TypeGridData = tgdPartners) and (Data^.DataPrt = nil)) or
     ((Data^.TypeGridData = tgdReferences) and (Data^.DataRef = nil)) then
    exit;
  MoveDataToControls;
end;

procedure TCdCustomer.TreeViewDblClick(Sender: TObject);
begin
  if (TVirtualStringTree(Sender).RootNodeCount = 0) then
  begin
    if (Pk = 0) then
      ScrState := dbmInsert
    else
      ScrState := dbmEdit;
    ClearControls;
    if (dlReferences in FDataLoaded) then
      tsDataRefCom.Tag  := Ord(dbmInsert);
    if (dlPartners in FDataLoaded) then
      tsPartnerData.Tag := Ord(dbmInsert);
  end;
  if (dlReferences in FDataLoaded) then
    pgRefCom.ActivePageIndex := 1;
  if (dlPartners in FDataLoaded) then
    pgPartners.ActivePageIndex := 1;
end;

procedure TCdCustomer.sbSaveRefClick(Sender: TObject);
var
  aItem: TReference;
  Data : PCustomData;
  Node : PVirtualNode;
begin
  Data  := nil;
  Node  := nil;
  aItem := nil;
  if (ScrState in UPDATE_MODE) then
  begin
    if (TDBMode(tsDataRefCom.Tag) = dbmInsert) then
      aItem        := TReference.Create(nil)
    else
    begin
      Node         := vtReferences.FocusedNode;
      if (Node <> nil) then
      begin
         Data := vtReferences.GetNodeData(Node);
         if (Data <> nil) and (Data^.DataRef <> nil) then
           aItem   := Data^.DataRef;
      end;
    end;
    if (aItem = nil) then exit;
    aItem.eMailRef := MailRef;
    aItem.FlagCnf  := FlagCnf;
    aItem.FonRef   := FonRef;
    aItem.NomRef   := NomRef;
    aItem.ObsRef   := ObsRef;
    if (Node = nil) then
      Node := vtReferences.AddChild(nil);
    if (Data = nil) then
      Data := vtReferences.GetNodeData(Node);
    if (Data <> nil) then
    begin
      if (Data^.DataRef = nil) then
        Data^.DataRef := TReference.Create(nil);
      Data^.DataRef.Assign(aItem);
      Data^.Level        := 0;
      Data^.Node         := Node;
      Data^.TypeGridData := tgdReferences;
      Data^.State        := TDBMode(tsDataRefCom.Tag);
    end;
  end;
  pgRefCom.ActivePageIndex := 0;
end;

procedure TCdCustomer.sbInsertRefClick(Sender: TObject);
begin
  ClearControls;
  tsDataRefCom.Tag := Ord(dbmInsert);
end;

procedure TCdCustomer.sbCancelRefClick(Sender: TObject);
begin
  LoadReferencesGrid;
  pgRefCom.ActivePageIndex := 0;
  tsDataRefCom.Tag := Ord(dbmBrowse);
end;

procedure TCdCustomer.TreeViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node: PVirtualNode;
  Data: PCustomData;
begin
  if (TVirtualStringTree(Sender).FocusedNode = nil) then exit;
  if (ssCtrl in Shift) and (Key = VK_DELETE) then
  begin
    Node := TVirtualStringTree(Sender).FocusedNode;
    if (Node <> nil) then
    begin
      Data := TVirtualStringTree(Sender).GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level   := 0;
        Data^.Node    := nil;
        if (Data^.TypeGridData = tgdReferences) and (Data^.DataRef <> nil) then
        begin
          Data^.DataRef.Free;
          Data^.DataRef := nil;
        end;
        if (Data^.TypeGridData = tgdPartners) and (Data^.DataPrt <> nil) then
        begin
          Data^.DataPrt.Free;
          Data^.DataPrt := nil;
        end;
        Data^.Index   := 0;
      end;
      TVirtualStringTree(Sender).DeleteNode(Node);
    end;
  end;
end;

procedure TCdCustomer.sbSaveSocClick(Sender: TObject);
var
  aItem: TPartner;
  Data : PCustomData;
  Node : PVirtualNode;
begin
  Data  := nil;
  Node  := nil;
  aItem := nil;
  if (ScrState in UPDATE_MODE) then
  begin
    if (TDBMode(tsDataRefCom.Tag) = dbmInsert) then
      aItem        := TPartner.Create(nil)
    else
    begin
      Node         := vtPartners.FocusedNode;
      if (Node <> nil) then
      begin
         Data := vtPartners.GetNodeData(Node);
         if (Data <> nil) and (Data^.DataPrt <> nil) then
           aItem   := Data^.DataPrt;
      end;
    end;
    if (aItem = nil) then exit;
    aItem.eMailSoc                         := MailSoc;
    aItem.NomSoc                           := NomSoc;
    aItem.PkPartner                        := PkPartner;
    aItem.DtaNasc                          := DtaNascSoc;
    aItem.Address.FkCity.FkState.FkCountry := FkCountry[2];
    aItem.Address.FkCity.FkState           := FkState[2];
    aItem.Address.FkCity                   := FkCity[2];
    aItem.Address.EndAdd                   := DscEnd[2];
    aItem.Address.CmpEnd                   := CmpEnd[2];
    aItem.Address.CepAdd                   := CepEnd[2];
    aItem.Address.NumAdd                   := NumEnd[2];
    if (Node = nil) then
      Node := vtPartners.AddChild(nil);
    if (Data = nil) then
      Data := vtPartners.GetNodeData(Node);
    if (Data <> nil) then
    begin
      if (Data^.DataPrt = nil) then
        Data^.DataPrt := TPartner.Create(nil);
      Data^.DataPrt.Assign(aItem);
      Data^.Level        := 0;
      Data^.Node         := Node;
      Data^.TypeGridData := tgdPartners;
      Data^.State        := TDBMode(tsPartnerData.Tag);
    end;
  end;
  pgPartners.ActivePageIndex := 0;
end;

procedure TCdCustomer.sbCancelSocClick(Sender: TObject);
begin
  LoadPartnersGrid;
  pgPartners.ActivePageIndex := 0;
  tsPartnerData.Tag := Ord(dbmBrowse);
end;

procedure TCdCustomer.sbInsertSocClick(Sender: TObject);
begin
  ClearControls;
  tsPartnerData.Tag := Ord(dbmInsert);
end;

procedure TCdCustomer.FormShow(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to pgControl.PageCount - 1 do
    pgControl.Pages[i].Tag := Ord(dbmBrowse);
end;

function TCdCustomer.GetFkTipoTabelaFracao: Integer;
begin
  Result := -1;
  with eFkTipoTabelaFracao do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFlagFobDirigido: Boolean;
begin
  Result := lFlagFobDirigido.Checked;
end;

function TCdCustomer.GetFlagSameRegion: Boolean;
begin
  Result := lFlagSameRegion.Checked;
end;

procedure TCdCustomer.SetFkTipoTabelaFracao(const Value: Integer);
begin
  with eFkTipoTabelaFracao do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromIntegerValue(Value);
  end;
end;

procedure TCdCustomer.SetFlagFobDirigido(const Value: Boolean);
begin
  lFlagFobDirigido.Checked := Value;
end;

procedure TCdCustomer.SetFlagSameRegion(const Value: Boolean);
begin
  lFlagSameRegion.Checked := Value;
end;

function TCdCustomer.GetIdxConv: Double;
begin
  Result := eIdx_Conv.Value;
end;

procedure TCdCustomer.SetIdxConv(const Value: Double);
begin
  eIdx_Conv.Value := Value;
end;

procedure TCdCustomer.eFk_Tipo_PagamentosSelect(Sender: TObject);
begin
  if (not Loading) then ChangeGlobal(Sender);
  if (FkTipoPagamentos <> nil) then
  begin
    eFk_Meios_Pagamento.ReleaseObjects;
    eFk_Meios_Pagamento.Items.AddStrings(dmSysCad.LoadPaymentWay(FkTipoPagamentos.PkTypePgto));
  end;
end;

procedure TCdCustomer.SetFlagTCad(const Value: TTypeOwner);
begin
  FFlagTCad := Value;
  lFk_Tipo_Estabelecimentos.Visible := (FFlagTCad = toCompany);
  eFk_Tipo_Estabelecimentos.Visible := (FFlagTCad = toCompany);
end;

function TCdCustomer.GetFkTypeDelivryPeriod: Integer;
begin
  Result := 0;
  with eFk_Tipo_Prazo_Entrega do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

procedure TCdCustomer.SetFkTypeDelivryPeriod(const Value: Integer);
begin
  with eFk_Tipo_Prazo_Entrega do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromIntegerValue(Value);
  end;
end;

procedure TCdCustomer.LoadTypeMoviment;
var
  Node: PVirtualNode;
  Data: PGridData;
  aPkGrupos: Integer;
  function AddDataNode(ANode: PVirtualNode): PVirtualNode;
  begin
    with dmSysCad, vtMovement do
    begin
      Result := AddChild(ANode);
      if (Result <> nil) then
      begin
        Data := GetNodeData(Result);
        if (Data <> nil) then
        begin
          Data^.DataRow    := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
          Data^.Level      := GetNodeLevel(Result);
          Data^.Node       := Result;
          if (Data^.Level = 0) then
            Data^.NodeType := tnFolder
          else
            Data^.NodeType := tnData;
        end;
      end;
    end;
  end;
begin
  Node := nil;
  Data := nil;
  aPkGrupos := 0;
  ReleaseTreeNodes(vtMovement);
  with dmSysCad, vtMovement do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAUx.SQL.Clear;
    qrSqlAUx.SQL.Add(SqlOwnerMoviments);
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('FkCadastros').AsInteger := Pk;
      qrSqlAux.ParamByName('FlagES').AsInteger := Ord(ioOut);
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.Eof) do
      begin
        if (qrSqlAux.FieldByName('PK_GRUPOS_MOVIMENTOS').AsInteger <> aPkGrupos) then
          Node := AddDataNode(nil);
        if (Node <> nil) then AddDataNode(Node);
        aPkGrupos := qrSqlAux.FieldByName('PK_GRUPOS_MOVIMENTOS').AsInteger;
        qrSqlAux.Next;
      end;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
    if (RootNodeCount > 0) then
      FullExpand;
  end;
end;

procedure TCdCustomer.vtMovementGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Capitalize(Data^.DataRow.FieldByName['DSC_GMOV'].AsString);
    1: CellText := Data^.DataRow.FieldByName['DSC_TMOV'].AsString   + ': '  +
                   Data^.DataRow.FieldByName['NAT_OPE_DE'].AsString + ' - ' +
                   Data^.DataRow.FieldByName['NAT_OPE_FE'].AsString + ' - ' +
                   Data^.DataRow.FieldByName['NAT_OPE_EX'].AsString;
  end;
end;

procedure TCdCustomer.vtMovementInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Data^.Level = 0) then exit;
  Node.CheckType  := ctCheckBox;
  if (Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger > 0) then
    Node.CheckState := csCheckedNormal
  else
    Node.CheckState := csUncheckedNormal;
end;

procedure TCdCustomer.vtMovementGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TGridData);
end;

procedure TCdCustomer.vtMovementBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if (Node = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: ItemColor := clSkyBlue;
    1: ItemColor := clInfoBk;
  end;
  EraseAction := eaColor;
end;

procedure TCdCustomer.vtMovementChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
begin
  if (Node = nil) then exit;
  Allowed :=  (Sender.GetNodeLevel(Node) > 0);
end;

procedure TCdCustomer.vtMovementFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  if (NewNode = nil) then exit;
  Allowed :=  (Sender.GetNodeLevel(NewNode) > 0);
end;

procedure TCdCustomer.vtMovementFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  if (Node = nil) then exit;
  Sender.Selected[Node] := False;
end;

procedure TCdCustomer.vtMovementChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (not (ScrState in UPDATE_MODE)) and (Pk = 0) then
    ScrState := dbmInsert;
  if (Node.CheckState = csCheckedNormal) then
    Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger := Pk
  else
    Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger := 0;
  if (Pk > 0) then
    if (Node.CheckState = csCheckedNormal) then
      dmSysCad.OwnerMovement[Ord(dbmInsert)] := Data^.DataRow
    else
      dmSysCad.OwnerMovement[Ord(dbmDelete)] := Data^.DataRow
  else
    if (Node.CheckState = csCheckedNormal) then
      Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmInsert)
    else
      Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmBrowse);
end;

procedure TCdCustomer.vtMovementPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Data^.Level = 0) then exit;
  TargetCanvas.Font.Color := ColorMode[TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger)];
end;

function TCdCustomer.GetFkBanks: Integer;
begin
  Result := 0;
  with eFk_Portos__Dst do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdCustomer.GetFlagDifAcc: Integer;
begin
  Result := lFlag_DifAcc.ItemIndex;
end;

function TCdCustomer.GetMinAccess: Double;
begin
  Result := eMin_Access.Value;
end;

function TCdCustomer.GetTaxAccess: Double;
begin
  Result := eTax_Access.Value;
end;

procedure TCdCustomer.SetFkBanks(const Value: Integer);
begin
  with eFk_Portos__Dst do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      SetIndexFromIntegerValue(Value);
  end;
end;

procedure TCdCustomer.SetMinAccess(const Value: Double);
begin
  eMin_Access.Value := Value;
end;

procedure TCdCustomer.SetTaxAccess(const Value: Double);
begin
  eMin_Access.Value := Value;
end;

procedure TCdCustomer.SetFlagDifAcc(const Value: Integer);
begin
  lFlag_DifAcc.ItemIndex := Value;
  SetDifAccScreen;
end;

procedure TCdCustomer.SetDifAccScreen;
begin
  lTax_Access.Enabled := (FlagDifAcc > -1);
  eTax_Access.Enabled := (FlagDifAcc > -1);
  eMin_Access.Enabled := (FlagDifAcc > -1);
end;

procedure TCdCustomer.bbClearFLagDiffAccClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  FlagDifAcc := -1;
end;

procedure TCdCustomer.lFlag_DifAccClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  SetDifAccScreen;
end;

procedure TCdCustomer.eFk_Tabela_PrecosSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  eFkTipoTabelaFracao.Items.Clear;
  eFkTipoTabelaFracao.Items.AddStrings(dmSysCad.LoadTypeTableFraction(FkTabelaPrecos.PkPriceTable));
end;

procedure TCdCustomer.sbGetPasswdClick(Sender: TObject);
begin
  PwdAccess := GeneratePassword(8);
end;

end.
