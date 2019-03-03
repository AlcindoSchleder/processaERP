unit CadEmply;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CurrEdit, ToolEdit, ExtCtrls, Mask, Buttons, ComCtrls,
  PrcCombo, TSysMan, TSysCadAux, TSysBcCx, TSysCad, ProcUtils, CadModel;

type
  TCdEmployee = class(TfrmModel)
    pgControlEmployee: TPageControl;
    tsE_Data: TTabSheet;
    lRaca_Cor: TStaticText;
    eRaca_Cor: TEdit;
    lNum_Tit: TStaticText;
    eNum_Tit: TEdit;
    lZona_Tit: TStaticText;
    eZona_Tit: TEdit;
    eSecao_Tit: TEdit;
    lSecao_Tit: TStaticText;
    lDta_Emi_Rg: TStaticText;
    eDta_Emi_Rg: TDateEdit;
    eNom_Pai: TEdit;
    lNom_Pai: TStaticText;
    lNom_Mae: TStaticText;
    eNom_Mae: TEdit;
    eFk_Country: TPrcComboBox;
    lDta_Nasc__emp: TStaticText;
    eDta_Nasc: TDateEdit;
    eFlag_Estcv: TPrcComboBox;
    lFlag_Estcv: TStaticText;
    lFlag_GrInstr: TStaticText;
    eFlag_GrInstr: TPrcComboBox;
    lFlag_Sexo: TStaticText;
    eFlag_Sexo: TPrcComboBox;
    tsE_Complement: TTabSheet;
    lFk_Tipo_Comissoes: TStaticText;
    eFk_Tipo_Comissoes: TPrcComboBox;
    lCom_Vnd: TStaticText;
    eCom_Vnd: TCurrencyEdit;
    lNum_Func: TStaticText;
    lDsct_Max: TStaticText;
    eDsct_Max: TCurrencyEdit;
    lFlag_Crg: TRadioGroup;
    lFk_Departamentos: TStaticText;
    eFk_Departamentos: TPrcComboBox;
    eFk_Setor: TPrcComboBox;
    lFk_Setor: TStaticText;
    lFk_Centro_Custos: TStaticText;
    eFk_Centro_Custos: TPrcComboBox;
    eFk_Cargos: TPrcComboBox;
    eNum_Func: TCurrencyEdit;
    tsE_Complement2: TTabSheet;
    lAno_Cheg: TStaticText;
    lTipo_Visto: TStaticText;
    eTipo_Visto: TEdit;
    lDta_Apst: TStaticText;
    eDta_Apst: TDateEdit;
    lSit_Apst: TStaticText;
    eSit_Apst: TEdit;
    lFlag_Apst: TCheckBox;
    lFlag_Def: TCheckBox;
    lNom_Conslh: TStaticText;
    eNom_Conslh: TEdit;
    lHab_Prof: TStaticText;
    eHab_Prof: TEdit;
    lNum_Reg: TStaticText;
    eNum_Reg: TEdit;
    eAno_Cheg: TCurrencyEdit;
    lRef_Livro: TStaticText;
    lNum_Ctps: TStaticText;
    lSer_Ctps: TStaticText;
    eSer_Ctps: TEdit;
    lDta_Exp__emp: TStaticText;
    eDta_Exp: TDateEdit;
    lUf_Ctps: TStaticText;
    eUf_Ctps: TPrcComboBox;
    lPis_Func: TStaticText;
    ePis_Func: TEdit;
    lDta_Cad: TStaticText;
    eDta_Cad: TDateEdit;
    eNum_Ctps: TCurrencyEdit;
    eRef_Livro: TCurrencyEdit;
    tsE_Complement3: TTabSheet;
    lPerc_Ins: TStaticText;
    ePerc_Ins: TCurrencyEdit;
    lNom_Sind: TStaticText;
    eNom_Sind: TEdit;
    eVal_Sal: TCurrencyEdit;
    lVlr_Sal: TStaticText;
    lQtd_Horas: TStaticText;
    lNum_Dep_IR: TStaticText;
    lDta_Nasc_Filho: TStaticText;
    eDta_Nasc_Filho: TDateEdit;
    lQtd_Filho: TStaticText;
    lFlag_Tempr: TCheckBox;
    lFlag_Opprv: TCheckBox;
    lCod_Ctb: TStaticText;
    eCod_Ctb: TCurrencyEdit;
    lFk_Bancos__FGTS: TStaticText;
    eFk_Bancos_FGTS: TPrcComboBox;
    eConta_Vinc: TEdit;
    lDta_Adm__emp: TStaticText;
    eDta_Adm: TDateEdit;
    lFlag_TSal: TStaticText;
    eFlag_TSal: TPrcComboBox;
    lPerc_Peric: TStaticText;
    ePerc_Peric: TCurrencyEdit;
    eFk_Bancos: TPrcComboBox;
    lConta_Vinc: TStaticText;
    eConta: TEdit;
    lConta: TStaticText;
    lFk_Bancos__emp: TStaticText;
    eQtd_Horas: TCurrencyEdit;
    eNum_Dep_IR: TCurrencyEdit;
    eQtd_Filho: TCurrencyEdit;
    eFk_State: TPrcComboBox;
    eFk_City: TPrcComboBox;
    Shape1: TShape;
    lNatural: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eFk_CountrySelect(Sender: TObject);
    procedure eFk_StateSelect(Sender: TObject);
  private
    function GetAnoCheg: Integer;
    function GetCodCtb: Integer;
    function GetComVnd: Double;
    function GetDsctMax: Double;
    function GetDtaAdm: TDate;
    function GetDtaApst: TDate;
    function GetDtaCad: TDate;
    function GetDtaEmiRg: TDate;
    function GetDtaExp: TDate;
    function GetDtaNasc: TDate;
    function GetDtaNascFilho: TDate;
    function GetFkBank: TBank;
    function GetFkBankFgts: TBank;
    function GetFkCity: TCity;
    function GetFkCompany: Integer;
    function GetFkCostsCenter: Integer;
    function GetFkDepartament: Integer;
    function GetFkFunctions: Integer;
    function GetFkSector: Integer;
    function GetFkTypeComission: Integer;
    function GetFlagApst: Boolean;
    function GetFlagCrg: TPostType;
    function GetFlagDef: Boolean;
    function GetFlagEstCiv: TCivilState;
    function GetFlagGrInstr: TSchoolLevel;
    function GetFlagOpPrv: Boolean;
    function GetFlagSex: TSexType;
    function GetFlagTempr: Boolean;
    function GetFlagTSal: TTypeSalary;
    function GetHabProf: string;
    function GetNomConslh: string;
    function GetNomMae: string;
    function GetNomPai: string;
    function GetNomSind: string;
    function GetNumCtps: Integer;
    function GetNumDepIr: Integer;
    function GetNumFunc: Integer;
    function GetNumReg: string;
    function GetNumTit: string;
    function GetPercInsl: Double;
    function GetPercPeric: Double;
    function GetPisFunc: string;
    function GetQtdFilhos: Integer;
    function GetQtdHours: Integer;
    function GetRacaCor: string;
    function GetRefLivro: Integer;
    function GetSecaoTit: string;
    function GetSerCtps: string;
    function GetSitApst: string;
    function GetTipoVisto: string;
    function GetUfCtps: string;
    function GetVincFun: string;
    function GetVlrSal: Double;
    function GetZonaTit: string;
    procedure SetAnoCheg(const Value: Integer);
    procedure SetCodCtb(const Value: Integer);
    procedure SetComVnd(const Value: Double);
    procedure SetDsctMax(const Value: Double);
    procedure SetDtaAdm(const Value: TDate);
    procedure SetDtaApst(const Value: TDate);
    procedure SetDtaCad(const Value: TDate);
    procedure SetDtaEmiRg(const Value: TDate);
    procedure SetDtaExp(const Value: TDate);
    procedure SetDtaNasc(const Value: TDate);
    procedure SetDtaNascFilho(const Value: TDate);
    procedure SetFkBank(const Value: TBank);
    procedure SetFkBankFgts(const Value: TBank);
    procedure SetFkCity(const Value: TCity);
    procedure SetFkCostsCenter(const Value: Integer);
    procedure SetFkDepartament(const Value: Integer);
    procedure SetFkFunctions(const Value: Integer);
    procedure SetFkSector(const Value: Integer);
    procedure SetFkTypeComission(const Value: Integer);
    procedure SetFlagApst(const Value: Boolean);
    procedure SetFlagCrg(const Value: TPostType);
    procedure SetFlagDef(const Value: Boolean);
    procedure SetFlagEstCiv(const Value: TCivilState);
    procedure SetFlagGrInstr(const Value: TSchoolLevel);
    procedure SetFlagOpPrv(const Value: Boolean);
    procedure SetFlagSex(const Value: TSexType);
    procedure SetFlagTempr(const Value: Boolean);
    procedure SetFlagTSal(const Value: TTypeSalary);
    procedure SetHabProf(const Value: string);
    procedure SetNomConslh(const Value: string);
    procedure SetNomMae(const Value: string);
    procedure SetNomPai(const Value: string);
    procedure SetNomSind(const Value: string);
    procedure SetNumCtps(const Value: Integer);
    procedure SetNumDepIr(const Value: Integer);
    procedure SetNumFunc(const Value: Integer);
    procedure SetNumReg(const Value: string);
    procedure SetNumTit(const Value: string);
    procedure SetPercInsl(const Value: Double);
    procedure SetPercPeric(const Value: Double);
    procedure SetPisFunc(const Value: string);
    procedure SetQtdFilhos(const Value: Integer);
    procedure SetQtdHours(const Value: Integer);
    procedure SetRacaCor(const Value: string);
    procedure SetRefLivro(const Value: Integer);
    procedure SetSecaoTit(const Value: string);
    procedure SetSerCtps(const Value: string);
    procedure SetSitApst(const Value: string);
    procedure SetTipoVisto(const Value: string);
    procedure SetUfCtps(const Value: string);
    procedure SetVincFun(const Value: string);
    procedure SetVlrSal(const Value: Double);
    procedure SetZonaTit(const Value: string);
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property AnoCheg        : Integer      read GetAnoCheg         write SetAnoCheg;
    property CodCtb         : Integer      read GetCodCtb          write SetCodCtb;
    property ComVnd         : Double       read GetComVnd          write SetComVnd;
    property DsctMax        : Double       read GetDsctMax         write SetDsctMax;
    property DtaAdm         : TDate        read GetDtaAdm          write SetDtaAdm;
    property DtaApst        : TDate        read GetDtaApst         write SetDtaApst;
    property DtaCad         : TDate        read GetDtaCad          write SetDtaCad;
    property DtaEmiRg       : TDate        read GetDtaEmiRg        write SetDtaEmiRg;
    property DtaExp         : TDate        read GetDtaExp          write SetDtaExp;
    property DtaNasc        : TDate        read GetDtaNasc         write SetDtaNasc;
    property DtaNascFilho   : TDate        read GetDtaNascFilho    write SetDtaNascFilho;
    property FkBank         : TBank        read GetFkBank          write SetFkBank;
    property FkBankFgts     : TBank        read GetFkBankFgts      write SetFkBankFgts;
    property FkCity         : TCity        read GetFkCity          write SetFkCity;
    property FkCompany      : Integer      read GetFkCompany;
    property FkCostsCenter  : Integer      read GetFkCostsCenter   write SetFkCostsCenter;
    property FkDepartament  : Integer      read GetFkDepartament   write SetFkDepartament;
    property FkFunctions    : Integer      read GetFkFunctions     write SetFkFunctions;
    property FkSector       : Integer      read GetFkSector        write SetFkSector;
    property FkTypeComission: Integer      read GetFkTypeComission write SetFkTypeComission;
    property FlagApst       : Boolean      read GetFlagApst        write SetFlagApst;
    property FlagCrg        : TPostType    read GetFlagCrg         write SetFlagCrg;
    property FlagDef        : Boolean      read GetFlagDef         write SetFlagDef;
    property FlagEstCiv     : TCivilState  read GetFlagEstCiv      write SetFlagEstCiv;
    property FlagGrInstr    : TSchoolLevel read GetFlagGrInstr     write SetFlagGrInstr;
    property FlagOpPrv      : Boolean      read GetFlagOpPrv       write SetFlagOpPrv;
    property FlagSex        : TSexType     read GetFlagSex         write SetFlagSex;
    property FlagTempr      : Boolean      read GetFlagTempr       write SetFlagTempr;
    property FlagTSal       : TTypeSalary  read GetFlagTSal        write SetFlagTSal;
    property HabProf        : string       read GetHabProf         write SetHabProf;
    property NomConslh      : string       read GetNomConslh       write SetNomConslh;
    property NomMae         : string       read GetNomMae          write SetNomMae;
    property NomPai         : string       read GetNomPai          write SetNomPai;
    property NomSind        : string       read GetNomSind         write SetNomSind;
    property NumCtps        : Integer      read GetNumCtps         write SetNumCtps;
    property NumDepIr       : Integer      read GetNumDepIr        write SetNumDepIr;
    property NumFunc        : Integer      read GetNumFunc         write SetNumFunc;
    property NumReg         : string       read GetNumReg          write SetNumReg;
    property NumTit         : string       read GetNumTit          write SetNumTit;
    property PercInsl       : Double       read GetPercInsl        write SetPercInsl;
    property PercPeric      : Double       read GetPercPeric       write SetPercPeric;
    property PisFunc        : string       read GetPisFunc         write SetPisFunc;
    property QtdFilhos      : Integer      read GetQtdFilhos       write SetQtdFilhos;
    property QtdHours       : Integer      read GetQtdHours        write SetQtdHours;
    property RacaCor        : string       read GetRacaCor         write SetRacaCor;
    property RefLivro       : Integer      read GetRefLivro        write SetRefLivro;
    property SecaoTit       : string       read GetSecaoTit        write SetSecaoTit;
    property SerCtps        : string       read GetSerCtps         write SetSerCtps;
    property SitApst        : string       read GetSitApst         write SetSitApst;
    property TipoVisto      : string       read GetTipoVisto       write SetTipoVisto;
    property UfCtps         : string       read GetUfCtps          write SetUfCtps;
    property VincFun        : string       read GetVincFun         write SetVincFun;
    property VlrSal         : Double       read GetVlrSal          write SetVlrSal;
    property ZonaTit        : string       read GetZonaTit         write SetZonaTit;
  end;

var
  CdEmployee: TCdEmployee;

implementation

uses Dado, mSysCad, ProcType;

{$R *.dfm}

procedure TCdEmployee.FormCreate(Sender: TObject);
begin
  pgControlEmployee.Images := Dados.Image16;
  inherited;
end;

procedure TCdEmployee.FormDestroy(Sender: TObject);
begin
  eFk_Bancos.ReleaseObjects;
  eFk_Bancos.ReleaseObjects;
  eFk_Bancos_FGTS.ReleaseObjects;
  eFk_City.ReleaseObjects;
  eUf_Ctps.ReleaseObjects;
  eFk_Departamentos.ReleaseObjects;
  eFk_Setor.Items.Clear;
  eFk_Cargos.Items.Clear;
  eFk_Centro_Custos.ReleaseObjects;
  inherited;
end;

procedure TCdEmployee.LoadDefaults;
var
  aCountry: TCountry;
begin
  if (not ListLoaded) then
  begin
    eFk_Bancos.Items.AddStrings(dmSysCad.LoadBanks);
    eFk_Bancos_FGTS.Items.AddStrings(dmSysCad.LoadBanks);
    eFk_Country.Items.AddStrings(dmSysCad.LoadCountries);
    aCountry := TCountry.Create;
    try
      aCountry.PKCountry := Dados.Parametros.soCompanyCountry;
      eUf_Ctps.Items.AddStrings(dmSysCad.LoadStates(aCountry));
    finally
      FreeAndNil(aCountry);
    end;
//    eFk_Departamentos.Items.AddStrings(dmSysCad.LoadDepartaments);
//    eFk_Setor.Items.AddStrings(dmSysCad.LoadSectors);
//    eFk_Cargos.Items.AddStrings(dmSysCad.LoadTypeFunctions);
//    eFk_Centro_Custos.Items.AddStrings(dmSysCad.LoadCostsCenter);
  end;
end;

procedure TCdEmployee.MoveDataToControls;
var
  aEmployee: TEmployee;
begin
  Loading           := True;
  aEmployee         := dmSysCad.GetEmployeeData(Pk);
  try
    AnoCheg         := aEmployee.AnoCheg;
    CodCtb          := aEmployee.CodCtb;
    ComVnd          := aEmployee.ComVnd;
    DsctMax         := aEmployee.DsctMax;
    DtaAdm          := aEmployee.DtaAdm;
    DtaApst         := aEmployee.DtaApst;
    DtaCad          := aEmployee.DtaCad;
    DtaEmiRg        := aEmployee.DtaEmiRg;
    DtaExp          := aEmployee.DtaExp;
    DtaNasc         := aEmployee.DtaNasc;
    DtaNascFilho    := aEmployee.DtaNascFilho;
    FkBank          := aEmployee.FkBank;
    FkBankFgts      := aEmployee.FkBankFgts;
    FkCity          := aEmployee.FkBornFrom;
    FkCostsCenter   := aEmployee.FkCostsCenter;
    FkDepartament   := aEmployee.FkDepartament;
    FkFunctions     := aEmployee.FkFunctions;
    FkSector        := aEmployee.FkSector;
    FkTypeComission := aEmployee.FkTypeComission;
    FlagApst        := aEmployee.FlagApst;
    FlagCrg         := aEmployee.FlagCrg;
    FlagDef         := aEmployee.FlagDef;
    FlagEstCiv      := aEmployee.FlagEstCiv;
    FlagGrInstr     := aEmployee.FlagGrInstr;
    FlagOpPrv       := aEmployee.FlagOpPrv;
    FlagSex         := aEmployee.FlagSex;
    FlagTempr       := aEmployee.FlagTempr;
    FlagTSal        := aEmployee.FlagTSal;
    HabProf         := aEmployee.HabProf;
    NomConslh       := aEmployee.NomConslh;
    NomMae          := aEmployee.NomMae;
    NomPai          := aEmployee.NomPai;
    NomSind         := aEmployee.NomSind;
    NumCtps         := aEmployee.NumCtps;
    NumDepIr        := aEmployee.NumDepIr;
    NumFunc         := aEmployee.NumFunc;
    NumReg          := aEmployee.NumReg;
    NumTit          := aEmployee.NumTit;
    PercInsl        := aEmployee.PercInsl;
    PercPeric       := aEmployee.PercPeric;
    PisFunc         := aEmployee.PisFunc;
    QtdFilhos       := aEmployee.QtdFilhos;
    QtdHours        := aEmployee.QtdHours;
    RacaCor         := aEmployee.RacaCor;
    RefLivro        := aEmployee.RefLivro;
    SecaoTit        := aEmployee.SecaoTit;
    SerCtps         := aEmployee.SerCtps;
    SitApst         := aEmployee.SitApst;
    TipoVisto       := aEmployee.TipoVisto;
    UfCtps          := aEmployee.UfCtps;
    VincFun         := aEmployee.VincFun;
    VlrSal          := aEmployee.VlrSal;
    ZonaTit         := aEmployee.ZonaTit;
  finally
    Loading         := False;
    FreeAndNil(aEmployee);
  end;
end;

procedure TCdEmployee.ClearControls;
begin
  Loading         := True;
  try
    AnoCheg         := 0;
    CodCtb          := 0;
    ComVnd          := 0.0;
    DsctMax         := 0.0;
    DtaAdm          := 0;
    DtaApst         := 0;
    DtaCad          := 0;
    DtaEmiRg        := 0;
    DtaExp          := 0;
    DtaNasc         := 0;
    DtaNascFilho    := 0;
    FkBank          := nil;
    FkBankFgts      := nil;
    FkCity          := nil;
    FkCostsCenter   := 0;
    FkDepartament   := 0;
    FkFunctions     := 0;
    FkSector        := 0;
    FkTypeComission := 0;
    FlagApst        := False;
    FlagCrg         := ptAdmin;
    FlagDef         := False;
    FlagEstCiv      := csMarried;
    FlagGrInstr     := slFirst;
    FlagOpPrv       := False;
    FlagSex         := stMale;
    FlagTempr       := False;
    FlagTSal        := tsMonthly;
    HabProf         := '';
    NomConslh       := '';
    NomMae          := '';
    NomPai          := '';
    NomSind         := '';
    NumCtps         := 0;
    NumDepIr        := 0;
    NumFunc         := 0;
    NumReg          := '';
    NumTit          := '';
    PercInsl        := 0.0;
    PercPeric       := 0.0;
    PisFunc         := '';
    QtdFilhos       := 0;
    QtdHours        := 0;
    RacaCor         := '';
    RefLivro        := 0;
    SecaoTit        := '';
    SerCtps         := '';
    SitApst         := '';
    TipoVisto       := '';
    UfCtps          := '';
    VincFun         := '';
    VlrSal          := 0.0;
    ZonaTit         := '';
  finally
    Loading         := False;
  end;
end;

procedure TCdEmployee.SaveIntoDB;
var
  aEmployee: TEmployee;
begin
  if (ScrState in SCROLL_MODE) then exit;
  aEmployee                  := TEmployee.Create;
  try
    aEmployee.AnoCheg         := AnoCheg;
    aEmployee.CodCtb          := CodCtb;
    aEmployee.ComVnd          := ComVnd;
    aEmployee.DsctMax         := DsctMax;
    aEmployee.DtaAdm          := DtaAdm;
    aEmployee.DtaApst         := DtaApst;
    aEmployee.DtaCad          := DtaCad;
    aEmployee.DtaEmiRg        := DtaEmiRg;
    aEmployee.DtaExp          := DtaExp;
    aEmployee.DtaNasc         := DtaNasc;
    aEmployee.DtaNascFilho    := DtaNascFilho;
    aEmployee.FkBank          := FkBank;
    aEmployee.FkBankFgts      := FkBankFgts;
    aEmployee.FkBornFrom      := FkCity;
    aEmployee.FkCostsCenter   := FkCostsCenter;
    aEmployee.FkDepartament   := FkDepartament;
    aEmployee.FkFunctions     := FkFunctions;
    aEmployee.FkSector        := FkSector;
    aEmployee.FkTypeComission := FkTypeComission;
    aEmployee.FlagApst        := FlagApst;
    aEmployee.FlagCrg         := FlagCrg;
    aEmployee.FlagDef         := FlagDef;
    aEmployee.FlagEstCiv      := FlagEstCiv;
    aEmployee.FlagGrInstr     := FlagGrInstr;
    aEmployee.FlagOpPrv       := FlagOpPrv;
    aEmployee.FlagSex         := FlagSex;
    aEmployee.FlagTempr       := FlagTempr;
    aEmployee.FlagTSal        := FlagTSal;
    aEmployee.HabProf         := HabProf;
    aEmployee.NomConslh       := NomConslh;
    aEmployee.NomMae          := NomMae;
    aEmployee.NomPai          := NomPai;
    aEmployee.NomSind         := NomSind;
    aEmployee.NumCtps         := NumCtps;
    aEmployee.NumDepIr        := NumDepIr;
    aEmployee.NumFunc         := NumFunc;
    aEmployee.NumReg          := NumReg;
    aEmployee.NumTit          := NumTit;
    aEmployee.PercInsl        := PercInsl;
    aEmployee.PercPeric       := PercPeric;
    aEmployee.PisFunc         := PisFunc;
    aEmployee.QtdFilhos       := QtdFilhos;
    aEmployee.QtdHours        := QtdHours;
    aEmployee.RacaCor         := RacaCor;
    aEmployee.RefLivro        := RefLivro;
    aEmployee.SecaoTit        := SecaoTit;
    aEmployee.SerCtps         := SerCtps;
    aEmployee.SitApst         := SitApst;
    aEmployee.TipoVisto       := TipoVisto;
    aEmployee.UfCtps          := UfCtps;
    aEmployee.VincFun         := VincFun;
    aEmployee.VlrSal          := VlrSal;
    aEmployee.ZonaTit         := ZonaTit;
    dmSysCad.SaveEmployeeData(Pk, aEmployee, ScrState);
  finally
    FreeAndNil(aEmployee);
  end;
end;

function TCdEmployee.GetAnoCheg: Integer;
begin
  Result := eAno_Cheg.AsInteger;
end;

function TCdEmployee.GetCodCtb: Integer;
begin
  Result := eCod_Ctb.AsInteger;
end;

function TCdEmployee.GetComVnd: Double;
begin
  Result := eCom_Vnd.Value;
end;

function TCdEmployee.GetDsctMax: Double;
begin
  Result := eDsct_Max.Value;
end;

function TCdEmployee.GetDtaAdm: TDate;
begin
  Result := eDta_Adm.Date;
end;

function TCdEmployee.GetDtaApst: TDate;
begin
  Result := eDta_Apst.Date;
end;

function TCdEmployee.GetDtaCad: TDate;
begin
  Result := eDta_Cad.Date;
end;

function TCdEmployee.GetDtaEmiRg: TDate;
begin
  Result := eDta_Emi_Rg.Date;
end;

function TCdEmployee.GetDtaExp: TDate;
begin
  Result := eDta_Exp.Date;
end;

function TCdEmployee.GetDtaNasc: TDate;
begin
  Result := eDta_Nasc.Date;
end;

function TCdEmployee.GetDtaNascFilho: TDate;
begin
  Result := eDta_Nasc_Filho.Date;
end;

function TCdEmployee.GetFkBank: TBank;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Bancos.ItemIndex;
  if (aIdx > -1) and (eFk_Bancos.Items.Objects[aIdx] <> nil) then
    Result := TBank(eFk_Bancos.Items.Objects[aIdx]);
end;

function TCdEmployee.GetFkBankFgts: TBank;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Bancos_FGTS.ItemIndex;
  if (aIdx > -1) and (eFk_Bancos_FGTS.Items.Objects[aIdx] <> nil) then
    Result := TBank(eFk_Bancos_FGTS.Items.Objects[aIdx]);
end;

function TCdEmployee.GetFkCity: TCity;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx   := eFk_City.ItemIndex;
  if (aIdx > -1) and (eFk_City.Items.Objects[aIdx] <> nil) then
    Result := TCity(eFk_City.Items.Objects[aIdx]);
end;

function TCdEmployee.GetFkCompany: Integer;
begin
  Result := Dados.PkCompany;
end;

function TCdEmployee.GetFkCostsCenter: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx   := eFk_Centro_Custos.ItemIndex;
  if (aIdx > -1) and (eFk_Centro_Custos.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Centro_Custos.Items.Objects[aIdx]);
end;

function TCdEmployee.GetFkDepartament: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx   := eFk_Departamentos.ItemIndex;
  if (aIdx > -1) and (eFk_Departamentos.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Departamentos.Items.Objects[aIdx]);
end;

function TCdEmployee.GetFkFunctions: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx   := eFk_Cargos.ItemIndex;
  if (aIdx > -1) and (eFk_Cargos.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Cargos.Items.Objects[aIdx]);
end;

function TCdEmployee.GetFkSector: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx   := eFk_Setor.ItemIndex;
  if (aIdx > -1) and (eFk_Setor.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Setor.Items.Objects[aIdx]);
end;

function TCdEmployee.GetFkTypeComission: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx   := eFk_Tipo_Comissoes.ItemIndex;
  if (aIdx > -1) and (eFk_Tipo_Comissoes.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Tipo_Comissoes.Items.Objects[aIdx]);
end;

function TCdEmployee.GetFlagApst: Boolean;
begin
  Result := lFlag_Apst.Checked;
end;

function TCdEmployee.GetFlagCrg: TPostType;
begin
  Result := TPostType(lFlag_Crg.ItemIndex);
end;

function TCdEmployee.GetFlagDef: Boolean;
begin
  Result := lFlag_Def.Checked;
end;

function TCdEmployee.GetFlagEstCiv: TCivilState;
begin
  Result := TCivilState(eFlag_Estcv.ItemIndex);
end;

function TCdEmployee.GetFlagGrInstr: TSchoolLevel;
begin
  Result := TSchoolLevel(eFlag_Estcv.ItemIndex);
end;

function TCdEmployee.GetFlagOpPrv: Boolean;
begin
  Result := lFlag_Opprv.Checked;
end;

function TCdEmployee.GetFlagSex: TSexType;
begin
  Result := TSexType(eFlag_Sexo.ItemIndex);
end;

function TCdEmployee.GetFlagTempr: Boolean;
begin
  Result := lFlag_Tempr.Checked;
end;

function TCdEmployee.GetFlagTSal: TTypeSalary;
begin
  Result := TTypeSalary(eFlag_TSal.ItemIndex);
end;

function TCdEmployee.GetHabProf: string;
begin
  Result := eHab_Prof.Text;
end;

function TCdEmployee.GetNomConslh: string;
begin
  Result := eNom_Conslh.Text;
end;

function TCdEmployee.GetNomMae: string;
begin
  Result := eNom_Mae.Text;
end;

function TCdEmployee.GetNomPai: string;
begin
  Result := eNom_Pai.Text;
end;

function TCdEmployee.GetNomSind: string;
begin
  Result := eNom_Sind.Text;
end;

function TCdEmployee.GetNumCtps: Integer;
begin
  Result := eNum_Ctps.AsInteger;
end;

function TCdEmployee.GetNumDepIr: Integer;
begin
  Result := eNum_Dep_IR.AsInteger
end;

function TCdEmployee.GetNumFunc: Integer;
begin
  Result := eNum_Func.AsInteger;
end;

function TCdEmployee.GetNumReg: string;
begin
  Result := eNum_Reg.Text;
end;

function TCdEmployee.GetNumTit: string;
begin
  Result := eNum_Tit.Text;
end;

function TCdEmployee.GetPercInsl: Double;
begin
  Result := ePerc_Ins.Value;
end;

function TCdEmployee.GetPercPeric: Double;
begin
  Result := ePerc_Peric.Value;
end;

function TCdEmployee.GetPisFunc: string;
begin
  Result := ePis_Func.Text;
end;

function TCdEmployee.GetQtdFilhos: Integer;
begin
  Result := eQtd_Filho.AsInteger;
end;

function TCdEmployee.GetQtdHours: Integer;
begin
  Result := eQtd_Horas.AsInteger;
end;

function TCdEmployee.GetRacaCor: string;
begin
  Result := eRaca_Cor.Text;
end;

function TCdEmployee.GetRefLivro: Integer;
begin
  Result := eRef_Livro.AsInteger;
end;

function TCdEmployee.GetSecaoTit: string;
begin
  Result := eSecao_Tit.Text;
end;

function TCdEmployee.GetSerCtps: string;
begin
  Result := eSer_Ctps.Text;
end;

function TCdEmployee.GetSitApst: string;
begin
  Result := eSit_Apst.Text;
end;

function TCdEmployee.GetTipoVisto: string;
begin
  Result := eTipo_Visto.Text;
end;

function TCdEmployee.GetUfCtps: string;
begin
  Result := eUf_Ctps.Text;
end;

function TCdEmployee.GetVincFun: string;
begin
  Result := eConta_Vinc.Text;
end;

function TCdEmployee.GetVlrSal: Double;
begin
  Result := eVal_Sal.Value;
end;

function TCdEmployee.GetZonaTit: string;
begin
  Result := eZona_Tit.Text;
end;

procedure TCdEmployee.SetAnoCheg(const Value: Integer);
begin
  eAno_Cheg.AsInteger := Value;
end;

procedure TCdEmployee.SetCodCtb(const Value: Integer);
begin
  eCod_Ctb.AsInteger := Value;
end;

procedure TCdEmployee.SetComVnd(const Value: Double);
begin
  eCom_Vnd.Value := Value;
end;

procedure TCdEmployee.SetDsctMax(const Value: Double);
begin
  eDsct_Max.Value := Value;
end;

procedure TCdEmployee.SetDtaAdm(const Value: TDate);
begin
  eDta_Adm.Date := Value;
end;

procedure TCdEmployee.SetDtaApst(const Value: TDate);
begin
  eDta_Apst.Date := Value;
end;

procedure TCdEmployee.SetDtaCad(const Value: TDate);
begin
  eDta_Cad.Date := Value;
end;

procedure TCdEmployee.SetDtaEmiRg(const Value: TDate);
begin
  eDta_Emi_Rg.Date := Value;
end;

procedure TCdEmployee.SetDtaExp(const Value: TDate);
begin
  eDta_Exp.Date := Value;
end;

procedure TCdEmployee.SetDtaNasc(const Value: TDate);
begin
  eDta_Nasc.Date := Value;
end;

procedure TCdEmployee.SetDtaNascFilho(const Value: TDate);
begin
  eDta_Nasc_Filho.Date := Value;
end;

procedure TCdEmployee.SetFkBank(const Value: TBank);
begin
  if (Value = nil) then
    eFk_Bancos.ItemIndex := -1
  else
    eFk_Bancos.SetIndexFromObjectValue(Value.PkBank);
end;

procedure TCdEmployee.SetFkBankFgts(const Value: TBank);
begin
  if (Value = nil) then
    eFk_Bancos_FGTS.ItemIndex := -1
  else
    eFk_Bancos_FGTS.SetIndexFromObjectValue(Value.PkBank);
end;

procedure TCdEmployee.SetFkCity(const Value: TCity);
begin
  if (Value = nil) then
    eFk_City.ItemIndex := -1
  else
    eFk_City.SetIndexFromObjectValue(Value.PkCity);
end;

procedure TCdEmployee.SetFkCostsCenter(const Value: Integer);
begin
  eFk_Centro_Custos.SetIndexFromIntegerValue(Value);
end;

procedure TCdEmployee.SetFkDepartament(const Value: Integer);
begin
  eFk_Departamentos.SetIndexFromIntegerValue(Value);
end;

procedure TCdEmployee.SetFkFunctions(const Value: Integer);
begin
  eFk_Cargos.SetIndexFromIntegerValue(Value);
end;

procedure TCdEmployee.SetFkSector(const Value: Integer);
begin
  eFk_Setor.SetIndexFromIntegerValue(Value);
end;

procedure TCdEmployee.SetFkTypeComission(const Value: Integer);
begin
  eFk_Tipo_Comissoes.SetIndexFromIntegerValue(Value);
end;

procedure TCdEmployee.SetFlagApst(const Value: Boolean);
begin
  lFlag_Apst.Checked := Value;
end;

procedure TCdEmployee.SetFlagCrg(const Value: TPostType);
begin
  lFlag_Crg.ItemIndex := Ord(Value);
end;

procedure TCdEmployee.SetFlagDef(const Value: Boolean);
begin
  lFlag_Def.Checked := Value;
end;

procedure TCdEmployee.SetFlagEstCiv(const Value: TCivilState);
begin
  eFlag_Estcv.ItemIndex := Ord(Value);
end;

procedure TCdEmployee.SetFlagGrInstr(const Value: TSchoolLevel);
begin
  eFlag_GrInstr.ItemIndex := Ord(Value);
end;

procedure TCdEmployee.SetFlagOpPrv(const Value: Boolean);
begin
  lFlag_Opprv.Checked := Value;
end;

procedure TCdEmployee.SetFlagSex(const Value: TSexType);
begin
  eFlag_Sexo.ItemIndex := Ord(Value);
end;

procedure TCdEmployee.SetFlagTempr(const Value: Boolean);
begin
  lFlag_Tempr.Checked := Value;
end;

procedure TCdEmployee.SetFlagTSal(const Value: TTypeSalary);
begin
  eFlag_TSal.ItemIndex := Ord(Value);
end;

procedure TCdEmployee.SetHabProf(const Value: string);
begin
  eHab_Prof.Text := Value;
end;

procedure TCdEmployee.SetNomConslh(const Value: string);
begin
  eNom_Conslh.Text := Value;
end;

procedure TCdEmployee.SetNomMae(const Value: string);
begin
  eNom_Mae.Text := Value;
end;

procedure TCdEmployee.SetNomPai(const Value: string);
begin
  eNom_Pai.Text := Value;
end;

procedure TCdEmployee.SetNomSind(const Value: string);
begin
  eNom_Sind.Text := Value;
end;

procedure TCdEmployee.SetNumCtps(const Value: Integer);
begin
  eNum_Ctps.AsInteger := Value;
end;

procedure TCdEmployee.SetNumDepIr(const Value: Integer);
begin
  eNum_Dep_IR.AsInteger := Value;
end;

procedure TCdEmployee.SetNumFunc(const Value: Integer);
begin
  eNum_Func.AsInteger := Value;
end;

procedure TCdEmployee.SetNumReg(const Value: string);
begin
  eNum_Reg.Text := Value;
end;

procedure TCdEmployee.SetNumTit(const Value: string);
begin
  eNum_Tit.Text := Value;
end;

procedure TCdEmployee.SetPercInsl(const Value: Double);
begin
  ePerc_Ins.Value := Value;
end;

procedure TCdEmployee.SetPercPeric(const Value: Double);
begin
  ePerc_Peric.Value := Value;
end;

procedure TCdEmployee.SetPisFunc(const Value: string);
begin
  ePis_Func.Text := Value;
end;

procedure TCdEmployee.SetQtdFilhos(const Value: Integer);
begin
  eQtd_Filho.AsInteger := Value;
end;

procedure TCdEmployee.SetQtdHours(const Value: Integer);
begin
  eQtd_Horas.AsInteger := Value;
end;

procedure TCdEmployee.SetRacaCor(const Value: string);
begin
  eRaca_Cor.Text := Value;
end;

procedure TCdEmployee.SetRefLivro(const Value: Integer);
begin
  eRef_Livro.AsInteger := Value;
end;

procedure TCdEmployee.SetSecaoTit(const Value: string);
begin
  eSecao_Tit.Text := Value;
end;

procedure TCdEmployee.SetSerCtps(const Value: string);
begin
  eSer_Ctps.Text := Value;
end;

procedure TCdEmployee.SetSitApst(const Value: string);
begin
  eSit_Apst.Text := Value;
end;

procedure TCdEmployee.SetTipoVisto(const Value: string);
begin
  eTipo_Visto.Text := Value;
end;

procedure TCdEmployee.SetUfCtps(const Value: string);
begin
  eUf_Ctps.Text := Value;
end;

procedure TCdEmployee.SetVincFun(const Value: string);
begin
  eConta_Vinc.Text := Value;
end;

procedure TCdEmployee.SetVlrSal(const Value: Double);
begin
  eVal_Sal.Value := Value;
end;

procedure TCdEmployee.SetZonaTit(const Value: string);
begin
  eZona_Tit.Text := Value;
end;

procedure TCdEmployee.eFk_CountrySelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Country do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      eFk_State.Items.AddStrings(dmSysCad.LoadStates(TCountry(Items.Objects[ItemIndex])));
  end;
end;

procedure TCdEmployee.eFk_StateSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_State do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      eFk_City.Items.AddStrings(dmSysCad.LoadCities(TState(Items.Objects[ItemIndex])));
  end;
end;

end.
