unit TSysTrans;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 15/02/2007 - DD/MM/YYYY                                    *}
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
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, TSysEstq, TSysPed, TSysPedAux, TSysCadAux;

type
  TTypeCarrierDoc = (cdOwner, cdOther);

  TTypeVehicle   = (tvOwner, tvAgregates, tvNone);
  
  TTypeManifest = class (TPersistent)
  private
    FDscTMnf: string;
    FFkTypeDocument: Integer;
    FFlagTCnh: TTypeCarrierDoc;
    FPkTypeManifest: Integer;
    procedure SetDscTMnf(Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DscTMnf: string read FDscTMnf write SetDscTMnf;
    property FkTypeDocument: Integer read FFkTypeDocument write FFkTypeDocument;
    property FlagTCnh: TTypeCarrierDoc read FFlagTCnh write FFlagTCnh default 
            cdOwner;
    property PkTypeManifest: Integer read FPkTypeManifest write FPkTypeManifest;
  end;
  
  TTypeTable = class (TPersistent)
  private
    FDscFrac: string;
    FDscTab: string;
    FDtaFin: TDate;
    FDtaIni: TDate;
    FFlagDefTab: Boolean;
    FFlagType: TTypeFraction;
    FPercDsct: Double;
    FPkCalcOrgmDstn: Integer;
    FPkPriceTable: Integer;
    FPkTypeFraction: Integer;
    FVlrMin: Double;
    function GetDescription: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property Description: string read GetDescription;
    property DscFrac: string read FDscFrac write FDscFrac;
    property DscTab: string read FDscTab write FDscTab;
    property DtaFin: TDate read FDtaFin write FDtaFin;
    property DtaIni: TDate read FDtaIni write FDtaIni;
    property FlagDefTab: Boolean read FFlagDefTab write FFlagDefTab;
    property FlagType: TTypeFraction read FFlagType write FFlagType;
    property PercDsct: Double read FPercDsct write FPercDsct;
    property PkCalcOrgmDstn: Integer read FPkCalcOrgmDstn write FPkCalcOrgmDstn;
    property PkPriceTable: Integer read FPkPriceTable write FPkPriceTable;
    property PkTypeFraction: Integer read FPkTypeFraction write FPkTypeFraction;
    property VlrMin: Double read FVlrMin write FVlrMin;
  end;
  
  TCarrierWeight = class (TCollectionItem)
  private
    FAltVol: Double;
    FLargVol: Double;
    FProfVol: Double;
    function GetCubeVol: Double;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property AltVol: Double read FAltVol write FAltVol;
    property CubeVol: Double read GetCubeVol;
    property LargVol: Double read FLargVol write FLargVol;
    property ProfVol: Double read FProfVol write FProfVol;
  published
    property Index;
  end;
  
  TCarrierWeights = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TCarrierWeight;
    function GetTotVolume: Double;
    procedure SetItems(Index: Integer; Value: TCarrierWeight);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TCarrierWeight;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TCarrierWeight;
    property Items[Index: Integer]: TCarrierWeight read GetItems write SetItems;
    property TotVolume: Double read GetTotVolume;
  published
    property Count;
  end;
  
  TCarrierPartner = class (TPersistent)
  private
    FFKPartner: Integer;
    FFreVlr: Double;
    FTotFre: Double;
    FVlrDifAcc: Double;
    FVlrFrePeso: Double;
    FVlrGris: Double;
    FVlrPedg: Double;
    FVlrSecat: Double;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property FKPartner: Integer read FFKPartner write FFKPartner;
    property FreVlr: Double read FFreVlr write FFreVlr;
    property TotFre: Double read FTotFre write FTotFre;
    property VlrDifAcc: Double read FVlrDifAcc write FVlrDifAcc;
    property VlrFrePeso: Double read FVlrFrePeso write FVlrFrePeso;
    property VlrGris: Double read FVlrGris write FVlrGris;
    property VlrPedg: Double read FVlrPedg write FVlrPedg;
    property VlrSecat: Double read FVlrSecat write FVlrSecat;
  end;
  
  TCarrierOrder = class (TPersistent)
  private
    FAlqtIcms: Double;
    FCarrierPartner: TCarrierPartner;
    FCarrierWeights: TCarrierWeights;
    FCityDestination: TCity;
    FCityOrigim: TCity;
    FDecimalPlaces: Integer;
    FFkAddressee: Integer;
    FFkConsignee: Integer;
    FFkProduct: TProducts;
    FFkShipper: Integer;
    FFlagES: TInOut;
    FFlagRemb: Boolean;
    FFreVlr: Double;
    FNumNF: Integer;
    FOrder: TOrder;
    FQtdProd: Double;
    FTypeTable: TTypeTable;
    FVlrDifAcc: Double;
    FVlrFrePeso: Double;
    FVlrGris: Double;
    FVlrNf: Double;
    FVlrPedg: Double;
    FVlrSecat: Double;
    function GetFlagTpFre: TTypeCarrier;
    function GetQtdProd: Double;
    procedure SetCarrierPartner(Value: TCarrierPartner);
    procedure SetCarrierWeights(Value: TCarrierWeights);
    procedure SetCityDestination(Value: TCity);
    procedure SetCityOrigim(Value: TCity);
    procedure SetFkProduct(Value: TProducts);
    procedure SetOrder(Value: TOrder);
    procedure SetTypeTable(Value: TTypeTable);
  public
    constructor Create(ADecimalPlaces: Integer); reintroduce;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property AlqtIcms: Double read FAlqtIcms write FAlqtIcms;
    property CarrierPartner: TCarrierPartner read FCarrierPartner write 
            SetCarrierPartner;
    property CarrierWeights: TCarrierWeights read FCarrierWeights write 
            SetCarrierWeights;
    property CityDestination: TCity read FCityDestination write 
            SetCityDestination;
    property CityOrigim: TCity read FCityOrigim write SetCityOrigim;
    property FkAddressee: Integer read FFkAddressee write FFkAddressee;
    property FkConsignee: Integer read FFkConsignee write FFkConsignee;
    property FkProduct: TProducts read FFkProduct write SetFkProduct;
    property FkShipper: Integer read FFkShipper write FFkShipper;
    property FlagES: TInOut read FFlagES write FFlagES;
    property FlagRemb: Boolean read FFlagRemb write FFlagRemb;
    property FlagTpFre: TTypeCarrier read GetFlagTpFre;
    property FreVlr: Double read FFreVlr write FFreVlr;
    property NumNF: Integer read FNumNF write FNumNF;
    property Order: TOrder read FOrder write SetOrder;
    property QtdProd: Double read GetQtdProd write FQtdProd;
    property TypeTable: TTypeTable read FTypeTable write SetTypeTable;
    property VlrDifAcc: Double read FVlrDifAcc write FVlrDifAcc;
    property VlrFrePeso: Double read FVlrFrePeso write FVlrFrePeso;
    property VlrGris: Double read FVlrGris write FVlrGris;
    property VlrNf: Double read FVlrNf write FVlrNf;
    property VlrPedg: Double read FVlrPedg write FVlrPedg;
    property VlrSecat: Double read FVlrSecat write FVlrSecat;
  end;
  
  TVehicle = class (TPersistent)
  private
    FCpCdVcl: Double;
    FDscMark: string;
    FDscModel: string;
    FDscTVcl: string;
    FDscVcl: string;
    FFkMark: Integer;
    FFkModel: Integer;
    FFkOwner: Integer;
    FFlagTOwn: TTypeVehicle;
    FPk: Integer;
    FPlcVcl: string;
    FYearVcl: Integer;
    procedure SetDscMark(const Value: string);
    procedure SetDscModel(const Value: string);
    procedure SetDscVcl(const Value: string);
    procedure SetPlcVcl(Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property CpCdVcl: Double read FCpCdVcl write FCpCdVcl;
    property DscMark: string read FDscMark write SetDscMark;
    property DscModel: string read FDscModel write SetDscModel;
    property DscTVcl: string read FDscTVcl write FDscTVcl;
    property DscVcl: string read FDscVcl write SetDscVcl;
    property FkMark: Integer read FFkMark write FFkMark;
    property FkModel: Integer read FFkModel write FFkModel;
    property FkOwner: Integer read FFkOwner write FFkOwner;
    property FlagTOwn: TTypeVehicle read FFlagTOwn write FFlagTOwn;
    property Pk: Integer read FPk write FPk;
    property PlcVcl: string read FPlcVcl write SetPlcVcl;
    property YearVcl: Integer read FYearVcl write FYearVcl;
  end;
  

implementation

{
******************************** TTypeManifest *********************************
}
constructor TTypeManifest.Create;
begin
  inherited Create;
end;

destructor TTypeManifest.Destroy;
begin
  inherited Destroy;
end;

procedure TTypeManifest.Assign(Source: TPersistent);
begin
  if (Source is TTypeManifest) then
  begin
    FDscTMnf        := TTypeManifest(Source).DscTMnf;
    FFlagTCnh       := TTypeManifest(Source).FlagTCnh;
    FFkTypeDocument := TTypeManifest(Source).FkTypeDocument;
    FPkTypeManifest := TTypeManifest(Source).PkTypeManifest;
  end
  else
    inherited Assign(Source);
end;

procedure TTypeManifest.Clear;
begin
  FDscTMnf        := '';
  FFlagTCnh       := cdOwner;
  FFkTypeDocument := 0;
  FPkTypeManifest := 0;
end;

procedure TTypeManifest.SetDscTMnf(Value: string);
begin
  FDscTMnf := Copy(Value, 1, 30);
end;

{
********************************** TTypeTable **********************************
}
constructor TTypeTable.Create;
begin
  inherited Create;
  Clear;
end;

destructor TTypeTable.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TTypeTable.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TTypeTable) then
  begin
    FDscFrac        := TTypeTable(Source).DscFrac;
    FDscTab         := TTypeTable(Source).DscTab;
    FDtaFin         := TTypeTable(Source).DtaFin;
    FDtaIni         := TTypeTable(Source).DtaIni;
    FFlagDefTab     := TTypeTable(Source).FlagDefTab;
    FFlagType       := TTypeTable(Source).FlagType;
    FPercDsct       := TTypeTable(Source).PercDsct;
    FPkCalcOrgmDstn := TTypeTable(Source).PkCalcOrgmDstn;
    FPkPriceTable   := TTypeTable(Source).PkPriceTable;
    FPkTypeFraction := TTypeTable(Source).PkTypeFraction;
    FVlrMin         := TTypeTable(Source).VlrMin;
  end
  else
    inherited Assign(Source);
end;

procedure TTypeTable.Clear;
begin
  FDscFrac        := '';
  FDscTab         := '';
  FDtaFin         := 0;
  FDtaIni         := 0;
  FFlagDefTab     := False;
  FFlagType       := tfNone;
  FPercDsct       := 0.0;
  FPkCalcOrgmDstn := 0;
  FPkPriceTable   := 0;
  FPkTypeFraction := 0;
  FVlrMin         := 0.0;
end;

function TTypeTable.GetDescription: string;
begin
  Result := FDscTab + ' - ' + FDscFrac;
end;

{
******************************** TCarrierWeight ********************************
}
constructor TCarrierWeight.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TCarrierWeight.Destroy;
begin
  inherited Destroy;
end;

procedure TCarrierWeight.Assign(Source: TPersistent);
begin
  if (Source is TCarrierWeight) then
  begin
    AltVol  := TCarrierWeight(Source).AltVol;
    LargVol := TCarrierWeight(Source).LargVol;
    ProfVol := TCarrierWeight(Source).ProfVol;
  end
  else
    inherited Assign(Source);
end;

procedure TCarrierWeight.Clear;
begin
  AltVol  := 0.0;
  LargVol := 0.0;
  ProfVol := 0.0;
end;

function TCarrierWeight.GetCubeVol: Double;
begin
  Result := AltVol * LargVol * ProfVol;
end;

function TCarrierWeight.GetDisplayName: string;
begin
  if (AltVol > 0) and (LargVol > 0) and (ProfVol > 0) then
    Result := FloatToStrF(AltVol , ffNumber, 7, 2) + ' / ' +
              FloatToStrF(LargVol, ffNumber, 7, 2) + ' / ' +
              FloatToStrF(ProfVol, ffNumber, 7, 2)
  else
    Result := inherited GetDisplayName;
end;

{
******************************* TCarrierWeights ********************************
}
constructor TCarrierWeights.Create(AOwner: TPersistent);
begin
  FOwner := AOwner;
  inherited Create(TCarrierWeight);
end;

destructor TCarrierWeights.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

function TCarrierWeights.Add: TCarrierWeight;
begin
  Result := TCarrierWeight(inherited Add);
end;

procedure TCarrierWeights.Assign(Source: TPersistent);
var
  aIdx: Integer;
  aItem: TCarrierWeight;
begin
  if (Source <> nil) and (Source is TCarrierWeights) then
  begin
    Clear;
    for aIdx := 0 to TCarrierWeights(Source).Count - 1 do
    begin
      aItem := Self.Add;
      aItem.Assign(TCarrierWeights(Source).Items[aIdx]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TCarrierWeights.Clear;
begin
  inherited Clear;
end;

procedure TCarrierWeights.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TCarrierWeights.GetItems(Index: Integer): TCarrierWeight;
begin
  Result := inherited Items[Index] as TCarrierWeight;
end;

function TCarrierWeights.GetOwner: TPersistent;
begin
  if (Assigned(FOwner)) then
    Result := FOwner
  else
    Result := inherited GetOwner;
end;

function TCarrierWeights.GetTotVolume: Double;
var
  aIdx: Integer;
begin
  Result := 0;
  for aIdx := 0 to Count - 1 do
  begin
    Result := Result + Items[aIdx].CubeVol;
  end;
end;

function TCarrierWeights.Insert(Index: Integer): TCarrierWeight;
begin
  Result := TCarrierWeight(inherited Insert(Index));
end;

procedure TCarrierWeights.SetItems(Index: Integer; Value: TCarrierWeight);
begin
  inherited Items[Index] := Value;
end;

{
******************************* TCarrierPartner ********************************
}
constructor TCarrierPartner.Create;
begin
  inherited Create;
end;

destructor TCarrierPartner.Destroy;
begin
  inherited Destroy;
end;

procedure TCarrierPartner.Assign(Source: TPersistent);
begin
  if (Source is TCarrierPartner) then
  begin
    FFkPartner  := TCarrierPartner(Source).FkPartner;
    FFreVlr     := TCarrierPartner(Source).FreVlr;
    FVlrDifAcc  := TCarrierPartner(Source).VlrDifAcc;
    FVlrFrePeso := TCarrierPartner(Source).VlrFrePeso;
    FVlrGris    := TCarrierPartner(Source).VlrGris;
    FVlrPedg    := TCarrierPartner(Source).VlrPedg;
    FVlrSecat   := TCarrierPartner(Source).VlrSecat;
    FTotFre     := TCarrierPartner(Source).TotFre;
  end
  else
    inherited Assign(Source);
end;

procedure TCarrierPartner.Clear;
begin
  FFkPartner  := 0;
  FFreVlr     := 0.0;
  FVlrDifAcc  := 0.0;
  FVlrFrePeso := 0.0;
  FVlrGris    := 0.0;
  FVlrPedg    := 0.0;
  FVlrSecat   := 0.0;
  FTotFre     := 0.0;
end;

{
******************************** TCarrierOrder *********************************
}
constructor TCarrierOrder.Create(ADecimalPlaces: Integer);
begin
  inherited Create;
  FDecimalPlaces   := ADecimalPlaces;
  FCarrierPartner  := TCarrierPartner.Create;
  FCarrierWeights  := TCarrierWeights.Create(Self);
  FCityDestination := TCity.Create;
  FCityOrigim      := TCity.Create;
  FFkProduct       := TProducts.Create;
  FOrder           := TOrder.Create(FDecimalPlaces);
  FTypeTable       := TTypeTable.Create;
  Clear;
end;

destructor TCarrierOrder.Destroy;
begin
  if (Assigned(FCarrierPartner)) then
    FCarrierPartner.Free;
  if (Assigned(FCarrierWeights)) then
    FCarrierWeights.Free;
  if (Assigned(FCityDestination)) then
    FCityDestination.Free;
  if (Assigned(FCityOrigim)) then
    FCityOrigim.Free;
  if (Assigned(FFkProduct)) then
    FFkProduct.Free;
  if (Assigned(FOrder)) then
    FOrder.Free;
  if (Assigned(FTypeTable)) then
    FTypeTable.Free;
  FCarrierPartner  := nil;
  FCarrierWeights  := nil;
  FCityDestination := nil;
  FCityOrigim      := nil;
  FFkProduct       := nil;
  FOrder           := nil;
  FTypeTable       := nil;
  inherited Destroy;
end;

procedure TCarrierOrder.Assign(Source: TPersistent);
begin
  if (Source is TCarrierPartner) then
  begin
    CarrierPartner  := TCarrierOrder(Source).CarrierPartner;
    CarrierWeights  := TCarrierOrder(Source).CarrierWeights;
    CityDestination := TCarrierOrder(Source).CityDestination;
    CityOrigim      := TCarrierOrder(Source).CityOrigim;
    FkProduct       := TCarrierOrder(Source).FkProduct;
    FFkAddressee    := TCarrierOrder(Source).FkAddressee;
    FFkConsignee    := TCarrierOrder(Source).FkConsignee;
    FFkShipper      := TCarrierOrder(Source).FkShipper;
    FFreVlr         := TCarrierOrder(Source).FreVlr;
    FNumNF          := TCarrierOrder(Source).NumNF;
    Order           := TCarrierOrder(Source).Order;
    TypeTable       := TCarrierOrder(Source).TypeTable;
    FVlrDifAcc      := TCarrierOrder(Source).VlrDifAcc;
    FVlrFrePeso     := TCarrierOrder(Source).VlrFrePeso;
    FVlrGris        := TCarrierOrder(Source).VlrGris;
    FVlrNF          := TCarrierOrder(Source).VlrNF;
    FVlrPedg        := TCarrierOrder(Source).VlrPedg;
    FVlrSecat       := TCarrierOrder(Source).VlrSecat;
    FFlagES         := TCarrierOrder(Source).FlagES;
    FFlagRemb       := TCarrierOrder(Source).FlagRemb;
    FAlqtIcms       := TCarrierOrder(Source).AlqtIcms;
    FQtdProd        := TCarrierOrder(Source).QtdProd;
  end
  else
    inherited Assign(Source);
end;

procedure TCarrierOrder.Clear;
begin
  CarrierPartner  := nil;
  CarrierWeights  := nil;
  CityDestination := nil;
  CityOrigim      := nil;
  FkProduct       := nil;
  FFkAddressee    := 0;
  FFkConsignee    := 0;
  FFkShipper      := 0;
  FFreVlr         := 0.0;
  FNumNF          := 0;
  Order           := nil;
  TypeTable       := nil;
  FVlrDifAcc      := 0.0;
  FVlrFrePeso     := 0.0;
  FVlrGris        := 0.0;
  FVlrNF          := 0.0;
  FVlrPedg        := 0.0;
  FVlrSecat       := 0.0;
  FFlagES         := ioOut;
  FFlagRemb       := False;
  FAlqtIcms       := 0.0;
  FQtdProd        := 0.0;
end;

function TCarrierOrder.GetFlagTpFre: TTypeCarrier;
begin
  Result := FkProduct.ProductService.ProductCarrier.FlagTCarrier;
end;

function TCarrierOrder.GetQtdProd: Double;
begin
  if (FOrder.OrderItems.Count > 0) and
     (FOrder.OrderItems.Items[0].QtdItem > 0) then
    FQtdProd := FOrder.OrderItems.Items[0].QtdItem;
  Result := FQtdProd;
end;

procedure TCarrierOrder.SetCarrierPartner(Value: TCarrierPartner);
begin
  if (Value = nil) then
    FCarrierPartner.Clear
  else
    FCarrierPartner.Assign(Value);
end;

procedure TCarrierOrder.SetCarrierWeights(Value: TCarrierWeights);
begin
  if (Value = nil) then
    FCarrierWeights.Clear
  else
    FCarrierWeights.Assign(Value);
end;

procedure TCarrierOrder.SetCityDestination(Value: TCity);
begin
  FCityDestination.Clear;
  if (Value <> nil) then
    FCityDestination.Assign(Value);
end;

procedure TCarrierOrder.SetCityOrigim(Value: TCity);
begin
  FCityOrigim.Clear;
  if (Value <> nil) then
    FCityOrigim.Assign(Value);
end;

procedure TCarrierOrder.SetFkProduct(Value: TProducts);
begin
  if (Value = nil) then
    FFkProduct.Clear
  else
    FFkProduct.Assign(Value);
end;

procedure TCarrierOrder.SetOrder(Value: TOrder);
begin
  if (Value = nil) then
    FOrder.Clear
  else
    FOrder.Assign(Value);
end;

procedure TCarrierOrder.SetTypeTable(Value: TTypeTable);
begin
  if (Value = nil) then
    FTypeTable.Clear
  else
    FTypeTable.Assign(Value);
end;

{
*********************************** TVehicle ***********************************
}
constructor TVehicle.Create;
begin
  inherited Create;
  Clear;
end;

destructor TVehicle.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TVehicle.Assign(Source: TPersistent);
begin
  if (Source is TVehicle) then
  begin
    CpCdVcl  := TVehicle(Source).CpCdVcl;
    DscMark  := TVehicle(Source).DscMark;
    DscModel := TVehicle(Source).DscModel;
    DscTVcl  := TVehicle(Source).DscTVcl;
    DscVcl   := TVehicle(Source).DscVcl;
    FkMark   := TVehicle(Source).FkMark;
    FkModel  := TVehicle(Source).FkModel;
    FkOwner  := TVehicle(Source).FkOwner;
    FlagTOwn := TVehicle(Source).FlagTOwn;
    Pk       := TVehicle(Source).Pk;
    PlcVcl   := TVehicle(Source).PlcVcl;
    YearVcl  := TVehicle(Source).YearVcl;
  end
  else
    inherited Assign(Source);
end;

procedure TVehicle.Clear;
begin
  CpCdVcl  := 0.0;
  DscMark  := '';
  DscModel := '';
  DscTVcl  := '';
  DscVcl   := '';
  FkMark   := 0;
  FkModel  := 0;
  FkOwner  := 0;
  FlagTOwn := tvOwner;
  Pk       := 0;
  PlcVcl   := '';
  YearVcl  := 0;
end;

procedure TVehicle.SetDscMark(const Value: string);
begin
  FDscMark := Copy(Value, 1, 30);
end;

procedure TVehicle.SetDscModel(const Value: string);
begin
  FDscModel := Copy(Value, 1, 30);
end;

procedure TVehicle.SetDscVcl(const Value: string);
begin
  FDscVcl := Copy(Value, 1, 50);
end;

procedure TVehicle.SetPlcVcl(Value: string);
begin
  FPlcVcl := Copy(Value, 1, 20);
end;


end.
