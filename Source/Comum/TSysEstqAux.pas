unit TSysEstqAux;

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
  SysUtils, Classes, TSysMan, 
    {$IFDEF WIN32} Controls {$ENDIF} 
    {$IFDEF LINUX} QControls {$ENDIF};

type

// 0 ==> Sale Products
// 1 ==> Purchase Products 
// 2 ==> Services
// 3 ==> Production Components
// 4 ==> Patrimony
  TTypeInsumos  = (tiSale, tiPurchase, tiService, tiPart, tiPatrimony);

// 0 ==> Revenda 
// 1 ==> Produção 
  TProductType  = (ptSale, ptProduction, ptNone);
  
// 0 ==> Compra 
// 1 ==> Composição 
// 2 ==> Similar 
  TMaterialType = (mtPurchase, mtComposition, mtSimilar, mtNone);
  
// 0 ==> Margem por Índice
// 1 ==> Margem por Percentual
  TTypeMargin   = (tmIndex, tmPercent); 

// 0 ==> Custo Médio
// 1 ==> Custo Real (PMZ)
// 2 ==> Custo Final (Informado)
// 3 ==> Custo Fornecedor Tabela
// 4 ==> Custo Referência (Fornecedor)
  TTypeCost     = (tcAverange, tcReal, tcFinal, tcSupplier, tcReference);

// 0 ==> Menor Valor dos acabamentos do mesmo tipo
// 1 ==> Valor Médio dos acabamentos do mesmo tipo
// 2 ==> Maior Valor dos acabamentos do mesmo tipo
  TTypeFinish   = (taMinor, taAverange, taMajor);

// 0 ==> Referência do Produto
// 1 ==> Código do Produto
// 2 ==> Código de Barras
// 3 ==> Código do Fornecedor
  TCodeTypes = (pcReference, pcPK, pcBarCode, pcSupplier);
  
// 0 ==> None
// 1 ==> Ean13
// 2 ==> Ean8
// 3 ==> Code39
// 4 ==> UPC
// 5 ==> Inteleave 2 de 5
  TBarCode      = (bcNone, bcEan13, bcEan8, bcCode39, bcUPC, bcInterleave);       

// 0 ==> Entrada
// 1 ==> Saída
// 2 ==> Transferência
// 3 ==> Ajuste / Inventario
  TMovimentations = (mvInput, mvOutput, mvTransfer, mvAdjustment);

// 0 ==> Estoque Geral
// 1 ==> Estoque Almoxarifados
// 2 ==> Estoque Geral e Almoxarifados
  TLocalMoviment = (lmGeneral, lmAlmox, lmBoth);

// 0 ==> Estoque Real
// 1 ==> Estoque Reservado
// 2 ==> Estoque Quarentena
// 3 ==> Estoque Devolução (Garantia)  
  TTypeEstq  = (etReal, etReserved, etQuarentine, etGiveBack);

// -1 ==> Nenhuma
//  0 ==> Somar
//  1 ==> Subtrait
  TTypeOper  = (opNone, opPlus, opMinus);
  
  TMovEstq = array [TTypeEstq] of Boolean;
  TOprEstq = array [TTypeEstq] of TTypeOper;

  TLines = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscLin: string;
    FFkTypeComission: Integer;
    FFontLin: string;
    FPkLines: Integer;
    procedure SetDscLin(const AValue: string);
    procedure SetFontLin(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscLin: string read FDscLin write SetDscLin;
    property FkTypeComission: Integer read FFkTypeComission write 
            FFkTypeComission;
    property FontLin: string read FFontLin write SetFontLin;
    property PkLines: Integer read FPkLines write FPkLines default 0;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TAlmox = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscAlmx: string;
    FDscSize: Integer;
    FLocAlmx: TStrings;
    FPkAlmox: Integer;
    procedure SetDscAlmx(AValue: string);
    procedure SetLocAlmx(AValue: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscAlmx: string read FDscAlmx write SetDscAlmx;
    property DscSize: Integer read FDscSize write FDscSize default 30;
    property LocAlmx: TStrings read FLocAlmx write SetLocAlmx;
    property PkAlmox: Integer read FPkAlmox write FPkAlmox default 0;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TTypeMoviment = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscMov: string;
    FFkTypeMoviment: Integer;
    FFlagCode: TCodeTypes;
    FFlagGenHst: Boolean;
    FFlagLocMov: TLocalMoviment;
    FFlagMov: TMovEstq;
    FFlagOper: TOprEstq;
    FFlagTMov: TMovimentations;
    FPkTypeMoviment: Integer;
    function GetFlagMov(Index: TTypeEstq): Boolean;
    function GetFlagOper(Index: TTypeEstq): TTypeOper;
    procedure SetDscMov(const AValue: string);
    procedure SetFlagMov(Index: TTypeEstq; Value: Boolean);
    procedure SetFlagOper(Index: TTypeEstq; Value: TTypeOper);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscMov: string read FDscMov write SetDscMov;
    property FkTypeMoviment: Integer read FFkTypeMoviment write FFkTypeMoviment;
    property FlagCode: TCodeTypes read FFlagCode write FFlagCode;
    property FlagGenHst: Boolean read FFlagGenHst write FFlagGenHst default 
            True;
    property FlagLocMov: TLocalMoviment read FFlagLocMov write FFlagLocMov 
            default lmBoth;
    property FlagMov[Index: TTypeEstq]: Boolean read GetFlagMov write 
            SetFlagMov;
    property FlagOper[Index: TTypeEstq]: TTypeOper read GetFlagOper write 
            SetFlagOper;
    property FlagTMov: TMovimentations read FFlagTMov write FFlagTMov default 
            mvInput;
    property PkTypeMoviment: Integer read FPkTypeMoviment write FPkTypeMoviment;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TParamEstq = class (TPersistent)
  private
    FFkAlmox: TAlmox;
    FFkCompany: TCompany;
    FFKTypeMovimentEntr: TTypeMoviment;
    FFKTypeMovimentSai: TTypeMoviment;
    FFlagTAcabm: TTypeFinish;
    FFlagTCusto: TTypeCost;
    FFlagTMrgm: TTypeMargin;
    FMrgDef: Double;
    procedure SetFkAlmox(AValue: TAlmox);
    procedure SetFkCompany(AValue: TCompany);
    procedure SetFKTypeMovimentEntr(AValue: TTypeMoviment);
    procedure SetFKTypeMovimentSai(AValue: TTypeMoviment);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property FkAlmox: TAlmox read FFkAlmox write SetFkAlmox;
    property FkCompany: TCompany read FFkCompany write SetFkCompany;
    property FKTypeMovimentEntr: TTypeMoviment read FFKTypeMovimentEntr write 
            SetFKTypeMovimentEntr;
    property FKTypeMovimentSai: TTypeMoviment read FFKTypeMovimentSai write 
            SetFKTypeMovimentSai;
    property FlagTAcabm: TTypeFinish read FFlagTAcabm write FFlagTAcabm default 
            taAverange;
    property FlagTCusto: TTypeCost read FFlagTCusto write FFlagTCusto default 
            tcAverange;
    property FlagTMrgm: TTypeMargin read FFlagTMrgm write FFlagTMrgm default 
            tmIndex;
    property MrgDef: Double read FMrgDef write FMrgDef;
  published
    function GetPkValue: Variant;
  end;
  
  TUnit = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscUni: string;
    FFlagAlt: Boolean;
    FFlagComp: Boolean;
    FFlagFrac: Boolean;
    FFlagFUni: Integer;
    FFlagLarg: Boolean;
    FFlagQtd: Boolean;
    FFlagTUni: Integer;
    FMnmoUni: string;
    FPkUnit: Integer;
    procedure SetDscUni(AValue: string);
    procedure SetMnmoUni(const AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscUni: string read FDscUni write SetDscUni;
    property FlagAlt: Boolean read FFlagAlt write FFlagAlt;
    property FlagComp: Boolean read FFlagComp write FFlagComp;
    property FlagFrac: Boolean read FFlagFrac write FFlagFrac default False;
    property FlagFUni: Integer read FFlagFUni write FFlagFUni;
    property FlagLarg: Boolean read FFlagLarg write FFlagLarg;
    property FlagQtd: Boolean read FFlagQtd write FFlagQtd;
    property FlagTUni: Integer read FFlagTUni write FFlagTUni;
    property MnmoUni: string read FMnmoUni write SetMnmoUni;
    property PkUnit: Integer read FPkUnit write FPkUnit;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TSimilar = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscSim: string;
    FPkSimilar: Integer;
    procedure SetDscSim(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscSim: string read FDscSim write SetDscSim;
    property PkSimilar: Integer read FPkSimilar write FPkSimilar default 0;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TPriceTable = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscTab: string;
    FDtaFin: TDate;
    FDtaIni: TDate;
    FFlagDefTab: Boolean;
    FFlagPrm: Boolean;
    FOwner: TPersistent;
    FPercDsct: Double;
    FPkPriceTable: Integer;
    procedure SetDscTab(AValue: string);
    procedure SetDtaFin(AValue: TDate);
    procedure SetDtaIni(AValue: TDate);
  public
    constructor Create(AOwner: TPersistent); reintroduce;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscTab: string read FDscTab write SetDscTab;
    property DtaFin: TDate read FDtaFin write SetDtaFin;
    property DtaIni: TDate read FDtaIni write SetDtaIni;
    property FlagDefTab: Boolean read FFlagDefTab write FFlagDefTab default 
            False;
    property FlagPrm: Boolean read FFlagPrm write FFlagPrm;
    property PercDsct: Double read FPercDsct write FPercDsct;
    property PkPriceTable: Integer read FPkPriceTable write FPkPriceTable;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  

implementation

{
************************************ TLines ************************************
}
constructor TLines.Create;
begin
  inherited Create;
  Clear;
end;

destructor TLines.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TLines.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TLines) then
  begin
    FFkTypeComission := TLines(Source).FkTypeComission;
    DscLin           := TLines(Source).DscLin;
    FFontLin         := TLines(Source).FontLin;
    FPkLines         := TLines(Source).PkLines;
  end
  else
    inherited Assign(Source);
end;

procedure TLines.Clear;
begin
  FFkTypeComission := 0;
  FDscLin          := '';
  FFontLin         := '';
  FPkLines         := 0;
  cbIndex          := 0;
end;

function TLines.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkLines) then
    Result := FcbIndex;
end;

function TLines.GetPkValue: Variant;
begin
  Result := FPkLines;
end;

procedure TLines.SetDscLin(const AValue: string);
begin
  FDscLin := Copy(AValue, 1, 30);
end;

procedure TLines.SetFontLin(AValue: string);
begin
  FFontLin := Copy(AValue, 1, 50);
end;

{
************************************ TAlmox ************************************
}
constructor TAlmox.Create;
begin
  inherited Create;
  FLocAlmx := TStringList.Create;
  Clear;
end;

destructor TAlmox.Destroy;
begin
  Clear;
  if Assigned(FLocAlmx) then
    FLocAlmx.Free;
  FLocAlmx := nil;
  inherited Destroy;
end;

procedure TAlmox.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TAlmox) then
  begin
    FDscSize := TAlmox(Source).DscSize;
    DscAlmx  := TAlmox(Source).DscAlmx;
    if Assigned(FLocAlmx) then
      LocAlmx := TAlmox(Source).LocAlmx;
    FPkAlmox := TAlmox(Source).PkAlmox;
    FcbIndex := TAlmox(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TAlmox.Clear;
begin
  FDscSize := 30;
  FDscAlmx := '';
  if Assigned(FLocAlmx) then
    FLocAlmx.Clear;
  FPkAlmox := 0;
  FcbIndex := 0;
end;

function TAlmox.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkAlmox) then
    Result := FcbIndex;
end;

function TAlmox.GetPkValue: Variant;
begin
  Result := FPkAlmox;
end;

procedure TAlmox.SetDscAlmx(AValue: string);
begin
  FDscAlmx := UpperCase(Copy(AValue, 1, FDscSize));
end;

procedure TAlmox.SetLocAlmx(AValue: TStrings);
begin
  if (AValue = nil) then
    FLocAlmx.Clear
  else
    FLocAlmx.Assign(AValue);
end;

{
******************************** TTypeMoviment *********************************
}
constructor TTypeMoviment.Create;
begin
  inherited Create;
  Clear;
end;

destructor TTypeMoviment.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TTypeMoviment.Assign(Source: TPersistent);
var
  i: TTypeEstq;
begin
  if (Source <> nil) and (Source is TTypeMoviment) then
  begin
    FcbIndex        := TTypeMoviment(Source).cbIndex;
    FDscMov         := TTypeMoviment(Source).DscMov;
    FFlagCode       := TTypeMoviment(Source).FlagCode;
    FFlagGenHst     := TTypeMoviment(Source).FlagGenHst;
    FFlagLocMov     := TTypeMoviment(Source).FlagLocMov;
    FPkTypeMoviment := TTypeMoviment(Source).PkTypeMoviment;
    for i := Low(TTypeEstq) to High(TTypeEstq) do
    begin
      FFlagMov[i]  := TTypeMoviment(Source).FlagMov[i];
      FFlagOper[i] := TTypeMoviment(Source).FlagOper[i];
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TTypeMoviment.Clear;
var
  i: TTypeEstq;
begin
  FcbIndex        := 0;
  FDscMov         := '';
  FFlagCode       := pcReference;
  FFlagGenHst     := True;
  FFlagLocMov     := lmBoth;
  FFlagTMov       := mvInput;
  FPkTypeMoviment := 0;
  for i := Low(TTypeEstq) to High(TTypeEstq) do
  begin
    FFlagMov[i]  := False;
    FFlagOper[i] := opNone;
  end;
end;

function TTypeMoviment.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkTypeMoviment) then
    Result := FcbIndex;
end;

function TTypeMoviment.GetFlagMov(Index: TTypeEstq): Boolean;
begin
  Result := FFlagMov[Index];
end;

function TTypeMoviment.GetFlagOper(Index: TTypeEstq): TTypeOper;
begin
  Result := FFlagOper[Index];
end;

function TTypeMoviment.GetPkValue: Variant;
begin
  Result := FPkTypeMoviment;
end;

procedure TTypeMoviment.SetDscMov(const AValue: string);
begin
  FDscMov := Copy(AValue, 1, 30);
end;

procedure TTypeMoviment.SetFlagMov(Index: TTypeEstq; Value: Boolean);
begin
  FFlagMov[Index] := Value;
end;

procedure TTypeMoviment.SetFlagOper(Index: TTypeEstq; Value: TTypeOper);
begin
  FFlagOper[Index] := Value;
end;

{
********************************** TParamEstq **********************************
}
constructor TParamEstq.Create;
begin
  inherited Create;
  FFkAlmox            := TAlmox.Create;
  FFkCompany          := TCompany.Create;
  FFkTypeMovimentEntr := TTypeMoviment.Create;
  FFkTypeMovimentSai  := TTypeMoviment.Create;
  Clear;
end;

destructor TParamEstq.Destroy;
begin
  Clear;
  if Assigned(FFkAlmox) then
    FFkAlmox.Free;
  if Assigned(FFkCompany) then
    FFkCompany.Free;
  if Assigned(FFkTypeMovimentEntr) then
    FFkTypeMovimentEntr.Free;
  if Assigned(FFkTypeMovimentSai) then
    FFkTypeMovimentSai.Free;
  FFkAlmox            := nil;
  FFkCompany          := nil;
  FFkTypeMovimentEntr := nil;
  FFkTypeMovimentSai  := nil;
  inherited Destroy;
end;

procedure TParamEstq.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TParamEstq) then
  begin
    if Assigned(FFkAlmox) then
      FkAlmox := TParamEstq(Source).FkAlmox;
    if Assigned(FFkCompany) then
      FkCompany  := TParamEstq(Source).FkCompany;
    if Assigned(FFkTypeMovimentEntr) then
      FkTypeMovimentEntr := TParamEstq(Source).FkTypeMovimentEntr;
    if Assigned(FFkTypeMovimentSai) then
      FkTypeMovimentSai  := TParamEstq(Source).FkTypeMovimentSai;
    FFlagTAcabm := TParamEstq(Source).FlagTAcabm;
    FFlagTCusto  := TParamEstq(Source).FlagTCusto;
    FFlagTMrgm   := TParamEstq(Source).FlagTMrgm;
  end
  else
    inherited Assign(Source);
end;

procedure TParamEstq.Clear;
begin
  if Assigned(FFkAlmox) then
    FFkAlmox.Clear;
  if Assigned(FFkCompany) then
    FFkCompany.Clear;
  if Assigned(FFkTypeMovimentEntr) then
    FFkTypeMovimentEntr.Clear;
  if Assigned(FFkTypeMovimentSai) then
    FFkTypeMovimentSai.Clear;
  FFlagTAcabm := taAverange;
  FFlagTCusto := tcAverange;
  FFlagTMrgm  := tmIndex;
end;

function TParamEstq.GetPkValue: Variant;
begin
  Result := FFkCompany.PkCompany;
end;

procedure TParamEstq.SetFkAlmox(AValue: TAlmox);
begin
  if (AValue = nil) then
    FFkAlmox.Clear
  else
    FFkAlmox.Assign(AValue);
end;

procedure TParamEstq.SetFkCompany(AValue: TCompany);
begin
  if (AValue = nil) then
    FFkCompany.Clear
  else
    FFkCompany.Assign(AValue);
end;

procedure TParamEstq.SetFKTypeMovimentEntr(AValue: TTypeMoviment);
begin
  if (AValue = nil) then
    FFKTypeMovimentEntr.Clear
  else
    FFKTypeMovimentEntr.Assign(AValue);
end;

procedure TParamEstq.SetFKTypeMovimentSai(AValue: TTypeMoviment);
begin
  if (AValue = nil) then
    FFKTypeMovimentSai.Clear
  else
    FFKTypeMovimentSai.Assign(AValue);
end;

{
************************************ TUnit *************************************
}
constructor TUnit.Create;
begin
  inherited Create;
  Clear;
end;

destructor TUnit.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TUnit.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TUnit) then
  begin
    DscUni    := TUnit(Source).DscUni;
    FFlagFrac := TUnit(Source).FlagFrac;
    FMnmoUni  := TUnit(Source).MnmoUni;
    PkUnit    := TUnit(Source).PkUnit;
    FFlagAlt  := TUnit(Source).FlagAlt;
    FFlagComp := TUnit(Source).FlagComp;
    FFlagFUni := TUnit(Source).FlagFUni;
    FFlagLarg := TUnit(Source).FlagLarg;
    FFlagQtd  := TUnit(Source).FlagQtd;
    FFlagTUni := TUnit(Source).FlagTUni;
    cbIndex   := TUnit(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TUnit.Clear;
begin
  cbIndex   := 0;
  FDscUni   := '';
  FFlagFrac := False;
  FMnmoUni  := '';
  PkUnit    := 0;
  FFlagAlt  := False;
  FFlagComp := False;
  FFlagFUni := 0;
  FFlagLarg := False;
  FFlagQtd  := False;
  FFlagTUni := 0;
  cbIndex   := 0;
end;

function TUnit.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkUnit) then
    Result := FcbIndex;
end;

function TUnit.GetPkValue: Variant;
begin
  Result := FPkUnit;
end;

procedure TUnit.SetDscUni(AValue: string);
begin
  FDscUni := Copy(AValue, 1, 30);
end;

procedure TUnit.SetMnmoUni(const AValue: string);
begin
  FMnmoUni := UpperCase(Copy(AValue, 1, 2));
end;

{
*********************************** TSimilar ***********************************
}
constructor TSimilar.Create;
begin
  inherited Create;
  Clear;
end;

destructor TSimilar.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TSimilar.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TSimilar) then
  begin
    DscSim     := TSimilar(Source).DscSim;
    FPkSimilar := TSimilar(Source).PkSimilar;
  end
  else
    inherited Assign(Source);
end;

procedure TSimilar.Clear;
begin
  FDscSim    := '';
  FPkSimilar := 0;
  cbIndex    := 0;
end;

function TSimilar.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkSimilar) then
    Result := FcbIndex;
end;

function TSimilar.GetPkValue: Variant;
begin
  Result := FPkSimilar;
end;

procedure TSimilar.SetDscSim(AValue: string);
begin
  FDscSim := Copy(AValue, 1, 30);
end;

{
********************************* TPriceTable **********************************
}
constructor TPriceTable.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  Clear;
end;

destructor TPriceTable.Destroy;
begin
  FOwner := nil;
  Clear;
  inherited Destroy;
end;

procedure TPriceTable.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TPriceTable) then
  begin
    FcbIndex      := TPriceTable(Source).cbIndex;
    DscTab        := TPriceTable(Source).DscTab;
    DtaIni        := TPriceTable(Source).DtaIni;
    DtaFin        := TPriceTable(Source).DtaFin;
    FFlagDefTab   := TPriceTable(Source).FlagDefTab;
    FFlagPrm      := TPriceTable(Source).FlagPrm;
    FPercDsct     := TPriceTable(Source).PercDsct;
    FPkPriceTable := TPriceTable(Source).PkPriceTable;
  end
  else
    inherited Assign(Source);
end;

procedure TPriceTable.Clear;
begin
  FDscTab       := '';
  FDtaIni       := 0;
  FDtaFin       := 0;
  FFlagDefTab   := False;
  FFlagPrm      := False;
  FPercDsct     := 0.0;
  FPkPriceTable := 0;
  FcbIndex      := 0;
end;

function TPriceTable.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkPriceTable) then
    Result := FcbIndex;
end;

function TPriceTable.GetPkValue: Variant;
begin
  Result := FPkPriceTable;
end;

procedure TPriceTable.SetDscTab(AValue: string);
begin
  FDscTab := Copy(AValue, 1, 30);
end;

procedure TPriceTable.SetDtaFin(AValue: TDate);
begin
  if (FDtaIni > 0) and (AValue > 0) and (AValue < FDtaIni) then
    raise exception.Create('TPriceTable Error: Field Final Date invalid');
  FDtaFin := AValue;
end;

procedure TPriceTable.SetDtaIni(AValue: TDate);
begin
  if (FDtaFin > 0) and (FDtaFin > 0) and (AValue < FDtaFin) then
    raise exception.Create('TPriceTable Error: Field Initial Date invalid');
  FDtaIni := AValue;
end;


end.
