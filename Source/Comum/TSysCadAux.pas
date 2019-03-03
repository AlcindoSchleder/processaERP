unit TSysCadAux;

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

uses SysUtils, Classes, TSysGen, Controls;

type
  TCheckDefaultEvent = function (Sender: TCollectionItem): Boolean of object;

  TCadAuxType   = (caCountry, caState, caCity, caDistrict);
  
// 0 ==> Clientes
// 1 ==> Fornecedores
// 2 ==> Funcionários
// 3 ==> Representantes
// 4 ==> Agentes
// 5 ==> Outros
  TCategoryType = (ctCustomer, ctSupplier, ctEmployee, ctRepresentant, ctAgent, ctOthers);
  TOwnerTypes   = set of TCategoryType;
  
// 0 ==> Endereço Web
// 1 ==> Endereço de e-Mail
// 2 ==> Endereço de FTP
// 3 ==> Endereço de Messenger
// 4 ==> Outros
  TTypeInternetAddress = (iaWeb, iaMail, iaFtp, iaMsn, iaNone);
  
  TComissionRanges     = (crAverangePeriod, crDiscounts);
  
  TOwnerComission      = (ocRepresentant, ocVendor);

  TOwnerEvents = class;

  TInternetAddress = class (TCollectionItem)
  private
    FDscEnd: string;
    FEndCnt: string;
    FFlagDef: Boolean;
    FFlagTCntInt: TTypeInternetAddress;
    procedure SetDscEnd(AValue: string);
    procedure SetEndCnt(AValue: string);
    procedure SetFlagDef(AValue: Boolean);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property DscEnd: string read FDscEnd write SetDscEnd;
    property EndCnt: string read FEndCnt write SetEndCnt;
    property FlagDef: Boolean read FFlagDef write SetFlagDef;
    property FlagTCntInt: TTypeInternetAddress read FFlagTCntInt write 
            FFlagTCntInt;
    property Index;
  published
    function GetPkValue: Variant;
  end;
  
  TInternetAddresses = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TInternetAddress;
    procedure SetItems(Index: Integer; AValue: TInternetAddress);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TInternetAddress;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TInternetAddress;
    property Count;
    property Items[Index: Integer]: TInternetAddress read GetItems write 
            SetItems;
  end;
  
  TOwnerEvent = class (TCollectionItem)
  private
    FDscEvt: string;
    FFlagIncEvt: Boolean;
    FPkOwnerEvent: TDate;
    procedure SetDscEvt(AValue: string);
    procedure SetPkOwnerEvent(AValue: TDate);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property DscEvt: string read FDscEvt write SetDscEvt;
    property FlagIncEvt: Boolean read FFlagIncEvt write FFlagIncEvt;
    property Index;
    property PkOwnerEvent: TDate read FPkOwnerEvent write SetPkOwnerEvent;
  published
    function GetPkValue: Variant;
  end;
  
  TOwnerEvents = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TOwnerEvent;
    procedure SetItems(Index: Integer; AValue: TOwnerEvent);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TOwnerEvent;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TOwnerEvent;
    property Count;
    property Items[Index: Integer]: TOwnerEvent read GetItems write SetItems;
  end;
  
  TPhone = class (TCollectionItem)
  private
    FDscPhone: string;
    FFlagDef: Boolean;
    FFonCad: string;
    procedure SetDscPhone(AValue: string);
    procedure SetFlagDef(AValue: Boolean);
    procedure SetFonCad(AValue: string);
  protected
    FOnCheckDefault: TCheckDefaultEvent;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DisplayName;
    property DscPhone: string read FDscPhone write SetDscPhone;
    property FlagDef: Boolean read FFlagDef write SetFlagDef;
    property FonCad: string read FFonCad write SetFonCad;
    property Index;
  published
    function GetPkValue: Variant;
  end;
  
  TPhones = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TPhone;
    procedure SetItems(Index: Integer; AValue: TPhone);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TPhone;
    procedure Assign(Source: TPersistent); override;
    function CheckDefault(Sender: TCollectionItem): Boolean;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TPhone;
    property Count;
    property Items[Index: Integer]: TPhone read GetItems write SetItems;
  end;
  
  TCategory = class (TCollectionItem)
  private
    FcbIndex: Integer;
    FDscCat: string;
    FFkFinanceAcc: Integer;
    FFkFinanceAccAcm: Integer;
    FFlagAtv: Boolean;
    FFlagCat: TCategoryType;
    FPkCategory: Integer;
    procedure SetDscCat(AValue: string);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DisplayName;
    property DscCat: string read FDscCat write SetDscCat;
    property FkFinanceAcc: Integer read FFkFinanceAcc write FFkFinanceAcc;
    property FkFinanceAccAcm: Integer read FFkFinanceAccAcm write 
            FFkFinanceAccAcm;
    property FlagAtv: Boolean read FFlagAtv write FFlagAtv;
    property FlagCat: TCategoryType read FFlagCat write FFlagCat;
    property Index;
    property PkCategory: Integer read FPkCategory write FPkCategory;
  published
    function GetPkValue: Variant;
  end;
  
  TCategories = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TCategory;
    procedure SetItems(Index: Integer; AValue: TCategory);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TCategory;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TCategory;
    property Count;
    property Items[Index: Integer]: TCategory read GetItems write SetItems;
  end;
  
  TAddressType = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscTEnd: string;
    FPkAddressType: Integer;
    procedure SetDscTEnd(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscTEnd: string read FDscTEnd write SetDscTEnd;
    property PkAddressType: Integer read FPkAddressType write FPkAddressType;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TCountry = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscPais: string;
    FFkLanguage: TLanguage;
    FFkMoeda: Integer;
    FFlagAcm: Boolean;
    FNacPais: string;
    FPKCountry: Integer;
    procedure SetDscPais(AValue: string);
    procedure SetFkLanguage(AValue: TLanguage);
    procedure SetNacPais(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscPais: string read FDscPais write SetDscPais;
    property FkLanguage: TLanguage read FFkLanguage write SetFkLanguage;
    property FkMoeda: Integer read FFkMoeda write FFkMoeda default 0;
    property FlagAcm: Boolean read FFlagAcm write FFlagAcm;
    property NacPais: string read FNacPais write SetNacPais;
    property PKCountry: Integer read FPKCountry write FPKCountry;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TState = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscUF: string;
    FFkCountry: TCountry;
    FFkRegions: Integer;
    FPkState: string;
    procedure SetDscUF(AValue: string);
    procedure SetFkCountry(AValue: TCountry);
    procedure SetPkState(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscUF: string read FDscUF write SetDscUF;
    property FkCountry: TCountry read FFkCountry write SetFkCountry;
    property FkRegions: Integer read FFkRegions write FFkRegions;
    property PkState: string read FPkState write SetPkState;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TCity = class (TPersistent)
  private
    FAlqtIss: Double;
    FcbIndex: Integer;
    FCepMun: Integer;
    FDscMun: string;
    FFkRegions: Integer;
    FFkState: TState;
    FFlagCap: Boolean;
    FPkCity: Integer;
    procedure SetDscMun(AValue: string);
    procedure SetFkState(AValue: TState);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property AlqtIss: Double read FAlqtIss write FAlqtIss;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property CepMun: Integer read FCepMun write FCepMun;
    property DscMun: string read FDscMun write SetDscMun;
    property FkRegions: Integer read FFkRegions write FFkRegions;
    property FkState: TState read FFkState write SetFkState;
    property FlagCap: Boolean read FFlagCap write FFlagCap;
    property PkCity: Integer read FPkCity write FPkCity;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TAddress = class (TPersistent)
  private
    FCepAdd: Integer;
    FCmpEnd: string;
    FCxpAdd: string;
    FEndAdd: string;
    FFkCity: TCity;
    FNumAdd: Integer;
    procedure SetCmpEnd(const AValue: string);
    procedure SetCxpAdd(const AValue: string);
    procedure SetEndAdd(AValue: string);
    procedure SetFkCity(AValue: TCity);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property CepAdd: Integer read FCepAdd write FCepAdd;
    property CmpEnd: string read FCmpEnd write SetCmpEnd;
    property CxpAdd: string read FCxpAdd write SetCxpAdd;
    property EndAdd: string read FEndAdd write SetEndAdd;
    property FkCity: TCity read FFkCity write SetFkCity;
    property NumAdd: Integer read FNumAdd write FNumAdd;
  end;
  
  TDistrict = class (TPersistent)
  private
    FcbIndex: Integer;
    FCepBai: Integer;
    FDscBai: string;
    FFkCity: TCity;
    FPkDistrict: Integer;
    procedure SetDscBai(AValue: string);
    procedure SetFkCity(AValue: TCity);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property CepBai: Integer read FCepBai write FCepBai;
    property DscBai: string read FDscBai write SetDscBai;
    property FkCity: TCity read FFkCity write SetFkCity;
    property PkDistrict: Integer read FPkDistrict write FPkDistrict;
  published
    function GetPkValue: Variant;
  end;
  
  TLocality = class (TPersistent)
  private
    FcbIndex: Integer;
    FCepLog: Integer;
    FCmplLog: string;
    FDscLog: string;
    FFkAddressType: TAddressType;
    FFkDistrict: TDistrict;
    FFlagSide: Integer;
    FNumFin: Integer;
    FNumIni: Integer;
    FPkLocality: Integer;
    procedure SetCmplLog(AValue: string);
    procedure SetDscLog(AValue: string);
    procedure SetFkAddressType(AValue: TAddressType);
    procedure SetFkDistrict(AValue: TDistrict);
    procedure SetNumFin(AValue: Integer);
    procedure SetNumIni(AValue: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property CepLog: Integer read FCepLog write FCepLog;
    property CmplLog: string read FCmplLog write SetCmplLog;
    property DscLog: string read FDscLog write SetDscLog;
    property FkAddressType: TAddressType read FFkAddressType write 
            SetFkAddressType;
    property FkDistrict: TDistrict read FFkDistrict write SetFkDistrict;
    property FlagSide: Integer read FFlagSide write FFlagSide;
    property NumFin: Integer read FNumFin write SetNumFin;
    property NumIni: Integer read FNumIni write SetNumIni;
    property PkLocality: Integer read FPkLocality write FPkLocality;
  published
    function GetPkValue: Variant;
  end;
  
  TTypeBlock = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscBlock: string;
    FFlagBlq: Boolean;
    FFlagCndPgt: Boolean;
    FFlagDtaBas: Boolean;
    FFlagLimCr: Boolean;
    FFlagMPgt: Boolean;
    FFlagVaVs: Boolean;
    FPkTypeBlock: Integer;
    procedure SetDscBlock(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscBlock: string read FDscBlock write SetDscBlock;
    property FlagBlq: Boolean read FFlagBlq write FFlagBlq;
    property FlagCndPgt: Boolean read FFlagCndPgt write FFlagCndPgt;
    property FlagDtaBas: Boolean read FFlagDtaBas write FFlagDtaBas;
    property FlagLimCr: Boolean read FFlagLimCr write FFlagLimCr;
    property FlagMPgt: Boolean read FFlagMPgt write FFlagMPgt;
    property FlagVaVs: Boolean read FFlagVaVs write FFlagVaVs;
    property PkTypeBlock: Integer read FPkTypeBlock write FPkTypeBlock;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  

implementation

{
******************************* TInternetAddress *******************************
}
constructor TInternetAddress.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
end;

destructor TInternetAddress.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TInternetAddress.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TInternetAddress) then
  begin
    DscEnd       := TInternetAddress(Source).DscEnd;
    EndCnt       := TInternetAddress(Source).EndCnt;
    FFlagTCntInt := TInternetAddress(Source).FlagTcntInt;
    FlagDef      := TInternetAddress(Source).FlagDef;
  end
  else
    inherited Assign(Source);
end;

procedure TInternetAddress.Clear;
begin
  FDscEnd      := '';
  FEndCnt      := '';
  FFlagTCntInt := iaNone;
  FlagDef      := False;
end;

function TInternetAddress.GetDisplayName: string;
begin
  Result := FDscEnd;
  if (Result = '') then Result := inherited GetDisplayName;
end;

function TInternetAddress.GetPkValue: Variant;
begin
  Result := Index;
end;

procedure TInternetAddress.SetDscEnd(AValue: string);
begin
  FDscEnd := Copy(AValue, 1, 30);
end;

procedure TInternetAddress.SetEndCnt(AValue: string);
begin
  FEndCnt := Copy(AValue, 1, 100);
end;

procedure TInternetAddress.SetFlagDef(AValue: Boolean);
var
  i: Integer;
begin
  if (Collection = nil) then exit;
  if AValue then
    with TInternetAddresses(Collection) do
      for i := 0 to Count - 1 do
        Items[i].FFlagDef := False;
  FFlagDef := AValue;
end;

{
****************************** TInternetAddresses ******************************
}
constructor TInternetAddresses.Create(AOwner: TPersistent);
begin
  inherited Create(TInternetAddress);
  Clear;
  FOwner := AOwner;
end;

destructor TInternetAddresses.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TInternetAddresses.Add: TInternetAddress;
begin
  Result := inherited Add as TInternetAddress;
end;

procedure TInternetAddresses.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TInternetAddress;
begin
  if (Source <> nil) and (Source is TInternetAddresses) then
  begin
    Clear;
    for i := 0 to TInternetAddresses(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TInternetAddresses(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TInternetAddresses.Clear;
begin
  inherited Clear;
end;

procedure TInternetAddresses.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TInternetAddresses.GetItems(Index: Integer): TInternetAddress;
begin
  Result := inherited Items[Index] as TInternetAddress;
end;

function TInternetAddresses.GetOwner: TPersistent;
begin
  Result := FOwner;
  if Result = nil then Result := inherited GetOwner;
end;

function TInternetAddresses.Insert(Index: Integer): TInternetAddress;
begin
  Result := inherited Insert(Index) as TInternetAddress;
end;

procedure TInternetAddresses.SetItems(Index: Integer; AValue: TInternetAddress);
begin
  inherited Items[Index] := AValue
end;

{
********************************* TOwnerEvent **********************************
}
constructor TOwnerEvent.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
end;

destructor TOwnerEvent.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TOwnerEvent.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOwnerEvent) then
  begin
    DscEvt       := TOwnerEvent(Source).DscEvt;
    FFlagIncEvt  := TOwnerEvent(Source).FlagIncEvt;
    PkOwnerEvent := TOwnerEvent(Source).PkOwnerEvent;
  end
  else
    inherited Assign(Source);
end;

procedure TOwnerEvent.Clear;
begin
  FDscEvt       := '';
  FFlagIncEvt   := False;
  FPkOwnerEvent := Date;
end;

function TOwnerEvent.GetDisplayName: string;
begin
  Result := FDscEvt;
  if (Result = '') then Result := inherited GetDisplayName;
end;

function TOwnerEvent.GetPkValue: Variant;
begin
  Result := FPkOwnerEvent;
end;

procedure TOwnerEvent.SetDscEvt(AValue: string);
begin
  FDscEvt := Copy(AValue, 1, 50);
end;

procedure TOwnerEvent.SetPkOwnerEvent(AValue: TDate);
var
  i: Integer;
begin
  if Collection = nil then exit;
  with TOwnerEvents(Collection) do
  begin
    for i := 0 to Count - 1 do
      if AValue = Items[i].PkOwnerEvent then
        raise Exception.CreateFmt('TOwnerEvent Error: Event of Date %s already ' +
          'exists.', [DateToStr(AValue)]);
  end;
  FPkOwnerEvent := AValue;
end;

{
********************************* TOwnerEvents *********************************
}
constructor TOwnerEvents.Create(AOwner: TPersistent);
begin
  inherited Create(TOwnerEvent);
  Clear;
  FOwner := AOwner;
end;

destructor TOwnerEvents.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TOwnerEvents.Add: TOwnerEvent;
begin
  Result := inherited Add as TOwnerEvent;
end;

procedure TOwnerEvents.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TOwnerEvent;
begin
  if (Source <> nil) and (Source is TOwnerEvents) then
  begin
    Clear;
    for i := 0 to TOwnerEvents(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TOwnerEvents(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TOwnerEvents.Clear;
begin
  inherited Clear;
end;

procedure TOwnerEvents.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TOwnerEvents.GetItems(Index: Integer): TOwnerEvent;
begin
  Result := inherited Items[Index] as TOwnerEvent;
end;

function TOwnerEvents.GetOwner: TPersistent;
begin
  Result := FOwner;
  if Result = nil then Result := inherited GetOwner;
end;

function TOwnerEvents.Insert(Index: Integer): TOwnerEvent;
begin
  Result := inherited Insert(Index) as TOwnerEvent;
end;

procedure TOwnerEvents.SetItems(Index: Integer; AValue: TOwnerEvent);
begin
  inherited Items[Index] := AValue
end;

{
************************************ TPhone ************************************
}
constructor TPhone.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
end;

destructor TPhone.Destroy;
begin
  Clear;
  FOnCheckDefault := nil;
  inherited Destroy;
end;

procedure TPhone.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TPhone) then
  begin
    DscPhone   := TPhone(Source).DscPhone;
    FonCad     := TPhone(Source).FonCad;
    FlagDef    := TPhone(Source).FlagDef;
  end
  else
    inherited Assign(Source);
end;

procedure TPhone.Clear;
begin
  FDscPhone  := '';
  FFonCad    := '';
  FFlagDef   := False;
end;

function TPhone.GetDisplayName: string;
begin
  Result := FDscPhone;
  if (Result = '') then Result := inherited GetDisplayName;
end;

function TPhone.GetPkValue: Variant;
begin
  Result := FFonCad;
end;

procedure TPhone.SetDscPhone(AValue: string);
begin
  FDscPhone := Copy(AValue, 1, 30)
end;

procedure TPhone.SetFlagDef(AValue: Boolean);
begin
  if (AValue <> FFlagDef) then
  begin
    if (AValue) and Assigned(FOnCheckDefault) then
      FFlagDef := FOnCheckDefault(Self)
    else
      FFlagDef := False;
  end;
end;

procedure TPhone.SetFonCad(AValue: string);
begin
  FFonCad := Copy(AValue, 1, 20);
end;

{
*********************************** TPhones ************************************
}
constructor TPhones.Create(AOwner: TPersistent);
begin
  inherited Create(TPhone);
  FOwner := AOwner;
  Clear;
end;

destructor TPhones.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TPhones.Add: TPhone;
begin
  Result := inherited Add as TPhone;
  Result.FOnCheckDefault := CheckDefault;
end;

procedure TPhones.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TPhone;
begin
  if (Source <> nil) and (Source is TPhones) then
  begin
    Clear;
    for i := 0 to TPhones(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TPhones(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

function TPhones.CheckDefault(Sender: TCollectionItem): Boolean;
var
  i, j: Integer;
begin
  j := 0;
  for i := 0 to Count - 1 do
    if (Items[i].FlagDef) then Inc(j);
  Result := ((j = 1) or (j = 0));
end;

procedure TPhones.Clear;
begin
  inherited Clear;
end;

procedure TPhones.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TPhones.GetItems(Index: Integer): TPhone;
begin
  Result := inherited Items[Index] as TPhone;
end;

function TPhones.GetOwner: TPersistent;
begin
  Result := FOwner;
  if Result = nil then Result := inherited GetOwner;
end;

function TPhones.Insert(Index: Integer): TPhone;
begin
  Result := inherited Insert(Index) as TPhone;
  Result.FOnCheckDefault := CheckDefault;
end;

procedure TPhones.SetItems(Index: Integer; AValue: TPhone);
begin
  inherited Items[Index] := AValue
end;

{
********************************** TCategory ***********************************
}
constructor TCategory.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
end;

destructor TCategory.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TCategory.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TCategory) then
  begin
    DscCat           := TCategory(Source).DscCat;
    FFlagCat         := TCategory(Source).FlagCat;
    FFlagAtv         := TCategory(Source).FlagAtv;
    FcbIndex         := TCategory(Source).cbIndex;
    FPkCategory      := TCategory(Source).PkCategory;
    FFkFinanceAcc    := TCategory(Source).FkFinanceAcc;
    FFkFinanceAccAcm := TCategory(Source).FkFinanceAccAcm;
  end
  else
    inherited Assign(Source);
end;

procedure TCategory.Clear;
begin
  FDscCat          := '';
  FFlagCat         := ctCustomer;
  cbIndex          := 0;
  FPkCategory      := 0;
  FFlagAtv         := True;
  FFkFinanceAcc    := 0;
  FFkFinanceAccAcm := 0;
end;

function TCategory.GetDisplayName: string;
begin
  Result := FDscCat;
  if Result = '' then Result := inherited GetDisplayName;
end;

function TCategory.GetPkValue: Variant;
begin
  Result := FPkCategory;
end;

procedure TCategory.SetDscCat(AValue: string);
begin
  FDscCat := Copy(AValue, 1, 30);
end;

{
********************************* TCategories **********************************
}
constructor TCategories.Create(AOwner: TPersistent);
begin
  inherited Create(TCategory);
  FOwner := AOwner;
  Clear;
end;

destructor TCategories.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TCategories.Add: TCategory;
begin
  Result := inherited Add as TCategory;
end;

procedure TCategories.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TCategory;
begin
  if (Source <> nil) and (Source is TCategories) then
  begin
    Clear;
    for i := 0 to TCategories(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TCategories(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TCategories.Clear;
begin
  inherited Clear;
end;

procedure TCategories.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TCategories.GetItems(Index: Integer): TCategory;
begin
  Result := inherited Items[Index] as TCategory;
end;

function TCategories.GetOwner: TPersistent;
begin
  Result := FOwner;
  if Result = nil then Result := inherited GetOwner;
end;

function TCategories.Insert(Index: Integer): TCategory;
begin
  Result := inherited Insert(Index) as TCategory;
end;

procedure TCategories.SetItems(Index: Integer; AValue: TCategory);
begin
  inherited Items[Index] := AValue
end;

{
********************************* TAddressType *********************************
}
constructor TAddressType.Create;
begin
  inherited Create;
  Clear
end;

destructor TAddressType.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TAddressType.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TAddressType) then
  begin
    FPkAddressType := TAddressType(Source).PkAddressType;
    FDscTEnd       := TAddressType(Source).DscTEnd;
    FcbIndex       := TAddressType(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TAddressType.Clear;
begin
  FDscTEnd       := '';
  FPkAddressType := 0;
  FcbIndex       := 0;
end;

function TAddressType.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkAddressType) then
    Result := FcbIndex;
end;

function TAddressType.GetPkValue: Variant;
begin
  Result := FPkAddressType;
end;

procedure TAddressType.SetDscTEnd(AValue: string);
begin
  FDscTEnd := Copy(AValue, 1, 50);
end;

{
*********************************** TCountry ***********************************
}
constructor TCountry.Create;
begin
  inherited Create;
  FFkLanguage := TLanguage.Create;
  Clear;
end;

destructor TCountry.Destroy;
begin
  Clear;
  FFkLanguage.Free;
  FFkLanguage := nil;
  inherited Destroy;
end;

procedure TCountry.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TCountry) then
  begin
    FcbIndex   := TCountry(Source).cbIndex;
    FDscPais   := TCountry(Source).DscPais;
    FFkMoeda   := TCountry(Source).FkMoeda;
    FFlagAcm   := TCountry(Source).FlagAcm;
    FNacPais   := TCountry(Source).NacPais;
    FPkCountry := TCountry(Source).PkCountry;
    if Assigned(FFkLanguage) then
      FkLanguage := TCountry(Source).FkLanguage;
  end
  else
    inherited Assign(Source);
end;

procedure TCountry.Clear;
begin
  cbIndex    := 0;
  FDscPais   := '';
  FFkMoeda   := 0;
  FFlagAcm   := False;
  FNacPais   := '';
  FPkCountry := 0;
  if Assigned(FFkLanguage) then
    FFkLanguage.Clear;
end;

function TCountry.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkCountry) then
    Result := FcbIndex;
end;

function TCountry.GetPkValue: Variant;
begin
  Result := FPkCountry;
end;

procedure TCountry.SetDscPais(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 50) then
    AValue := Copy(AValue, 1, 50);
  FDscPais := AValue;
end;

procedure TCountry.SetFkLanguage(AValue: TLanguage);
begin
  if (AValue <> nil) then
    FFkLanguage.Assign(AValue)
  else
    FFkLanguage.Clear;
end;

procedure TCountry.SetNacPais(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 50) then
    AValue := Copy(AValue, 1, 50);
  FNacPais := AValue;
end;

{
************************************ TState ************************************
}
constructor TState.Create;
begin
  inherited Create;
  FFkCountry := TCountry.Create;
  Clear;
end;

destructor TState.Destroy;
begin
  Clear;
  if Assigned(FFkCountry) then
    FFkCountry.Free;
  FFkCountry := nil;
  inherited Destroy;
end;

procedure TState.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TState) then
  begin
    FcbIndex    := TState(Source).cbIndex;
    DscUF       := TState(Source).DscUF;
    if Assigned(FFkCountry) then
      FkCountry := TState(Source).FkCountry;
    PkState     := TState(Source).PkState;
    FkRegions   := TState(Source).FkRegions;
  end
  else
    inherited Assign(Source);
end;

procedure TState.Clear;
begin
  FcbIndex := 0;
  FDscUF   := '';
  if Assigned(FFkCountry) then
    FFkCountry.Clear;
  FPkState   := '';
  FFkRegions := 0;
end;

function TState.ComparePk(const AValue: Variant): Integer;
var
  aPk: string;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := '';
  end;
  if (aPk = FPkState) then
    Result := FcbIndex;
end;

function TState.GetPkValue: Variant;
begin
  Result := FPkState;
end;

procedure TState.SetDscUF(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 50) then
    AValue := Copy(AValue, 1, 50);
  FDscUF := AValue;
end;

procedure TState.SetFkCountry(AValue: TCountry);
begin
  if (AValue = nil) then
    FFkCountry.Clear
  else
    FFkCountry.Assign(AValue);
end;

procedure TState.SetPkState(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 2) then
    AValue := Copy(AValue, 1, 2);
  FPkState := AValue;
end;

{
************************************ TCity *************************************
}
constructor TCity.Create;
begin
  inherited Create;
  FFkState   := TState.Create;
  Clear;
end;

destructor TCity.Destroy;
begin
  Clear;
  if Assigned(FFkState) then
    FFkState.Free;
  FFkState   := nil;
  inherited Destroy;
end;

procedure TCity.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TCity) then
  begin
    FcbIndex   := TCity(Source).cbIndex;
    FCepMun    := TCity(Source).CepMun;
    DscMun     := TCity(Source).DscMun;
    FkState    := TCity(Source).FkState;
    FPkCity    := TCity(Source).PkCity;
    FFkRegions := TCity(Source).FkRegions;
    FFlagCap   := TCity(Source).FlagCap;
    FAlqtIss   := TCity(Source).AlqtIss;
  end
  else
    inherited Assign(Source);
end;

procedure TCity.Clear;
begin
  FcbIndex   := 0;
  FCepMun    := 0;
  FDscMun    := '';
  if Assigned(FFkState) then
    FFkState.Clear;
  FPkCity    := 0;
  FFkRegions := 0;
  FFlagCap   := False;
  FAlqtIss  := 0.0;
end;

function TCity.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkCity) then
    Result := FcbIndex;
end;

function TCity.GetPkValue: Variant;
begin
  Result := FPkCity;
end;

procedure TCity.SetDscMun(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 30) then
    AValue := Copy(AValue, 1, 30);
  FDscMun := AValue;
end;

procedure TCity.SetFkState(AValue: TState);
begin
  if (AValue = nil) then
    FFkState.Clear
  else
    FFkState.Assign(AValue);
end;

{
*********************************** TAddress ***********************************
}
constructor TAddress.Create;
begin
  inherited Create;
  FFkCity := TCity.Create;
  Clear;
end;

destructor TAddress.Destroy;
begin
  Clear;
  if Assigned(FFkCity) then
    FFkCity.Free;
  FFkCity := nil;
  inherited Destroy;
end;

procedure TAddress.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TAddress) then
  begin
    FCepAdd := TAddress(Source).CepAdd;
    CmpEnd  := TAddress(Source).CmpEnd;
    CxpAdd  := TAddress(Source).CxpAdd;
    EndAdd  := TAddress(Source).EndAdd;
    FkCity  := TAddress(Source).FkCity;
    FNumAdd := TAddress(Source).NumAdd;
  end
  else
    inherited Assign(Source);
end;

procedure TAddress.Clear;
begin
  FCepAdd := 0;
  FCmpEnd := '';
  FCxpAdd := '';
  FEndAdd := '';
  if Assigned(FFkCity) then
    FFkCity.Clear;
  FNumAdd := 0;
end;

procedure TAddress.SetCmpEnd(const AValue: string);
begin
  FCmpEnd := Copy(AValue, 1, 50);
end;

procedure TAddress.SetCxpAdd(const AValue: string);
begin
  FCxpAdd := Copy(AValue, 1, 10);
end;

procedure TAddress.SetEndAdd(AValue: string);
begin
  FEndAdd := Copy(AValue, 1, 50);
end;

procedure TAddress.SetFkCity(AValue: TCity);
begin
  if (AValue = nil) then
    FFkCity.Clear
  else
    FFkCity.Assign(AValue);
end;

{
********************************** TDistrict ***********************************
}
constructor TDistrict.Create;
begin
  inherited Create;
  FFkCity := TCity.Create;
  Clear;
end;

destructor TDistrict.Destroy;
begin
  Clear;
  if Assigned(FFkCity) then
    FFkCity.Free;
  FFkCity := nil;
  inherited Destroy;
end;

procedure TDistrict.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TDistrict) then
  begin
    FDscBai     := TDistrict(Source).DscBai;
    FPkDistrict := TDistrict(Source).PkDistrict;
    FkCity      := TDistrict(Source).FkCity;
  end
  else
    inherited Assign(Source);
end;

procedure TDistrict.Clear;
begin
  FDscBai     := '';
  FPkDistrict := 0;
  FCepBai     := 0;
  if Assigned(FFkCity) then
    FFkCity.Clear;
end;

function TDistrict.GetPkValue: Variant;
begin
  Result := FPkDistrict;
end;

procedure TDistrict.SetDscBai(AValue: string);
begin
  FDscBai := Copy(AValue, 1, 50);
end;

procedure TDistrict.SetFkCity(AValue: TCity);
begin
  if (AValue <> nil) then
    FFkCity.Assign(AValue);
end;

{
********************************** TLocality ***********************************
}
constructor TLocality.Create;
begin
  inherited Create;
  FFkDistrict    := TDistrict.Create;
  FFkAddressType := TAddressType.Create;
  Clear;
end;

destructor TLocality.Destroy;
begin
  Clear;
  if Assigned(FFkDistrict) then
    FFkDistrict.Free;
  if Assigned(FFkAddressType) then
    FFkAddressType.Free;
  FFkDistrict    := nil;
  FFkAddressType := nil;
  inherited Destroy;
end;

procedure TLocality.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if (Source <> nil) and (Source is TLocality) then
  begin
    FCepLog        := TLocality(Source).CepLog;
    FDscLog        := TLocality(Source).DscLog;
    FFkAddressType := TLocality(Source).FkAddressType;
    FFkDistrict    := TLocality(Source).FkDistrict;
    FFlagSide      := TLocality(Source).FlagSide;
    FNumIni        := TLocality(Source).NumIni;
    FNumFin        := TLocality(Source).NumFin;
  end
  else
    inherited Assign(Source);
end;

procedure TLocality.Clear;
begin
  FcbIndex := 0;
  FCepLog  := 0;
  FDscLog  := '';
  FCmplLog := '';
  FFkAddressType.Clear;
  FFkDistrict.Clear;
  FFlagSide := 0;
  FNumIni   := 0;
  FNumFin   := 0;
end;

function TLocality.GetPkValue: Variant;
begin
  Result := FPkLocality
end;

procedure TLocality.SetCmplLog(AValue: string);
begin
  FCmplLog := Copy(AValue, 1, 50);
end;

procedure TLocality.SetDscLog(AValue: string);
begin
  FDscLog := Copy(AValue, 1, 50);
end;

procedure TLocality.SetFkAddressType(AValue: TAddressType);
begin
  if (AValue <> nil) then
    FFkAddressType.Assign(AValue);
end;

procedure TLocality.SetFkDistrict(AValue: TDistrict);
begin
  if (AValue <> nil) then
    FFkDistrict.Assign(AValue);
end;

procedure TLocality.SetNumFin(AValue: Integer);
begin
  if (NumIni > 0) and (NumIni > NumFin) then
    raise Exception.CreateFmt('Error: NumIni(%d) must be less than NumFin(%d)',
      [FNumIni, FNumFin]);
  FNumFin := AValue;
end;

procedure TLocality.SetNumIni(AValue: Integer);
begin
  if (NumFin > 0) and (NumIni > NumFin) then
    raise Exception.CreateFmt('Error: NumIni(%d) must be less than NumFin(%d)',
      [FNumIni, FNumFin]);
  FNumIni := AValue;
end;

{
********************************** TTypeBlock **********************************
}
constructor TTypeBlock.Create;
begin
  inherited Create;
  Clear;
end;

destructor TTypeBlock.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TTypeBlock.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TTypeBlock) then
  begin
    FPkTypeBlock := TTypeBlock(Source).FPkTypeBlock;
    DscBlock     := TTypeBlock(Source).DscBlock;
    FFlagBlq     := TTypeBlock(Source).FlagBlq;
    FFlagCndPgt  := TTypeBlock(Source).FlagCndPgt;
    FFlagDtaBas  := TTypeBlock(Source).FlagDtaBas;
    FFlagLimCr   := TTypeBlock(Source).FlagLimCr;
    FFlagMPgt    := TTypeBlock(Source).FlagMPgt;
    FFlagVaVs    := TTypeBlock(Source).FlagVaVs;
    FcbIndex     := TTypeBlock(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TTypeBlock.Clear;
begin
  FcbIndex     := 0;
  FDscBlock    := '';
  FFlagBlq     := False;
  FFlagCndPgt  := False;
  FFlagDtaBas  := False;
  FFlagLimCr   := False;
  FFlagMPgt    := False;
  FFlagVaVs    := False;
  FPkTypeBlock := 0;
end;

function TTypeBlock.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkTypeBlock) then
    Result := FcbIndex;
end;

function TTypeBlock.GetPkValue: Variant;
begin
  Result := FPkTypeBlock;
end;

procedure TTypeBlock.SetDscBlock(AValue: string);
begin
  FDscBlock := Copy(AValue, 1, 50);
end;


end.
