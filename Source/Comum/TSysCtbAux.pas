unit TSysCtbAux;

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
  SysUtils, Classes, PrcSysTypes;

type
  TClassFisc = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscClsf: string;
    FPkClassificacaoFiscal: string;
    procedure SetDscClsf(AValue: string);
    procedure SetPkClassificacaoFiscal(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscClsf: string read FDscClsf write SetDscClsf;
    property PkClassificacaoFiscal: string read FPkClassificacaoFiscal write 
            SetPkClassificacaoFiscal;
  published
    function GetPkValue: Variant;
  end;
  
  TOrigimTrib = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscOrgm: string;
    FPkOrigensTributarias: Integer;
    procedure SetDscOrgm(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscOrgm: string read FDscOrgm write SetDscOrgm;
    property PkOrigensTributarias: Integer read FPkOrigensTributarias write 
            FPkOrigensTributarias;
  published
    function GetPkValue: Variant;
  end;
  
  TSitTrib = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscSitTrb: string;
    FPkSituacaoTributaria: Integer;
    procedure SetDscSitTrb(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscSitTrb: string read FDscSitTrb write SetDscSitTrb;
    property PkSituacaoTributaria: Integer read FPkSituacaoTributaria write 
            FPkSituacaoTributaria;
  published
    function GetPkValue: Variant;
  end;
  
  TRange = class (TSysProc)
  private
    FEndRange: Double;
    FStartRange: Double;
    FTaxRange: Double;
  protected
    procedure AssignFields(Source: TPersistent); override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Clear; override;
    function GetFields: TStrings; override;
    property EndRange: Double read FEndRange write FEndRange;
    property StartRange: Double read FStartRange write FStartRange;
    property TaxRange: Double read FTaxRange write FTaxRange;
  end;
  
  TTypeCfop = class (TSysProc)
  private
    FDscCfop: string;
    procedure SetDscCfop(Value: string);
  protected
    procedure AssignFields(Source: TPersistent); override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Clear; override;
    function GetFields: TStrings; override;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
    property cbIndex;
    property DscCfop: string read FDscCfop write SetDscCfop;
    property Pk;
  end;
  
  TNatureOperation = class (TSysProc)
  private
    FCmplCfop: string;
    FCodCfop: string;
    FDscNtOp: string;
    FFkFinanceAccount: Integer;
    FTypeCfop: TTypeCfop;
    procedure SetCmplCfop(Value: string);
    procedure SetCodCfop(Value: string);
    procedure SetDscNtOp(Value: string);
    procedure SetTypeCfop(Value: TTypeCfop);
  protected
    procedure AssignFields(Source: TPersistent); override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Clear; override;
    function GetFields: TStrings; override;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
    property cbIndex;
    property CmplCfop: string read FCmplCfop write SetCmplCfop;
    property CodCfop: string read FCodCfop write SetCodCfop;
    property DscNtOp: string read FDscNtOp write SetDscNtOp;
    property FkFinanceAccount: Integer read FFkFinanceAccount write 
            FFkFinanceAccount;
    property Pk;
    property TypeCfop: TTypeCfop read FTypeCfop write SetTypeCfop;
  end;
  

implementation

{
********************************** TClassFisc **********************************
}
constructor TClassFisc.Create;
begin
  inherited Create;
  Clear;
end;

destructor TClassFisc.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TClassFisc.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TClassFisc) then
  begin
    FcbIndex              := TClassFisc(Source).cbIndex;
    DscClsF               := TClassFisc(Source).DscClsF;
    PkClassificacaoFiscal := TClassFisc(Source).PkClassificacaoFiscal;
  end
  else
    inherited Assign(Source);
end;

procedure TClassFisc.Clear;
begin
  FcbIndex               := 0;
  FDscClsF               := '';
  FPkClassificacaoFiscal := '';
end;

function TClassFisc.GetPkValue: Variant;
begin
  Result := FPkClassificacaoFiscal;
end;

procedure TClassFisc.SetDscClsf(AValue: string);
begin
  FDscClsf := Copy(AValue, 1, 50);
end;

procedure TClassFisc.SetPkClassificacaoFiscal(AValue: string);
begin
  FPkClassificacaoFiscal := Copy(AValue, 1, 20);
end;

{
********************************* TOrigimTrib **********************************
}
constructor TOrigimTrib.Create;
begin
  inherited Create;
  Clear;
end;

destructor TOrigimTrib.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TOrigimTrib.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOrigimTrib) then
  begin
    FcbIndex              := TOrigimTrib(Source).cbIndex;
    DscOrgm               := TOrigimTrib(Source).DscOrgm;
    FPkOrigensTributarias := TOrigimTrib(Source).PkOrigensTributarias;
  end
  else
    inherited Assign(Source);
end;

procedure TOrigimTrib.Clear;
begin
  FcbIndex              := 0;
  FDscOrgm              := '';
  FPkOrigensTributarias := 0;
end;

function TOrigimTrib.GetPkValue: Variant;
begin
  Result := FPkOrigensTributarias;
end;

procedure TOrigimTrib.SetDscOrgm(AValue: string);
begin
  FDscOrgm := Copy(AValue, 1, 50);
end;

{
*********************************** TSitTrib ***********************************
}
constructor TSitTrib.Create;
begin
  inherited Create;
  Clear;
end;

destructor TSitTrib.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TSitTrib.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TSitTrib) then
  begin
    DscSitTrb             := TSitTrib(Source).DscSitTrb;
    FPkSituacaoTributaria := TSitTrib(Source).PkSituacaoTributaria;
    cbIndex               := TSitTrib(Source).cbIndex;
  end
  else
   inherited Assign(Source);
end;

procedure TSitTrib.Clear;
begin
  FDscSitTrb            := '';
  FPkSituacaoTributaria := 0;
  cbIndex               := 0;
end;

function TSitTrib.GetPkValue: Variant;
begin
  Result := FPkSituacaoTributaria;
end;

procedure TSitTrib.SetDscSitTrb(AValue: string);
begin
  FDscSitTrb := Copy(AValue, 1, 50);
end;

{
************************************ TRange ************************************
}
constructor TRange.Create;
begin
  inherited Create(TRange);
  Clear;
end;

destructor TRange.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TRange.AssignFields(Source: TPersistent);
begin
  FEndRange   := TRange(Source).EndRange;
  FStartRange := TRange(Source).StartRange;
  FTaxRange   := TRange(Source).TaxRange;
end;

procedure TRange.Clear;
begin
  FEndRange   := 0.0;
  FStartRange := 0.0;
  FTaxRange   := 0.0;
end;

function TRange.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('PK_END_RANGE');
  Result.Add('PK_START_RANGE');
  Result.Add('ALQT_IMPST');
end;

{
********************************** TTypeCfop ***********************************
}
constructor TTypeCfop.Create;
begin
  inherited Create(TTypeCfop);
end;

destructor TTypeCfop.Destroy;
begin
  inherited Destroy;
end;

procedure TTypeCfop.AssignFields(Source: TPersistent);
begin
  FDscCfop := TTypeCfop(Source).DscCfop;
  Pk       := TTypeCfop(Source).Pk;
end;

procedure TTypeCfop.Clear;
begin
  FDscCfop := '';
  Pk       := 0;
end;

function TTypeCfop.ComparePk(const AValue: Variant): Integer;
begin
  Result := inherited ComparePk(AValue);
end;

function TTypeCfop.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('DSC_CFOP');
  Result.Add('PK_TIPO_CFOP');
end;

function TTypeCfop.GetPkValue: Variant;
begin
  Result := inherited GetPkValue;
end;

procedure TTypeCfop.SetDscCfop(Value: string);
begin
  FDscCfop := Copy(Value, 1, 30);
end;

{
******************************* TNatureOperation *******************************
}
constructor TNatureOperation.Create;
begin
  inherited Create(TNatureOperation);
  FTypeCfop := TTypeCfop.Create;
end;

destructor TNatureOperation.Destroy;
begin
  Clear;
  if Assigned(FTypeCfop) then
    FTypeCfop.Free;
  FTypeCfop := nil;
  inherited Destroy;
end;

procedure TNatureOperation.AssignFields(Source: TPersistent);
begin
  Pk                := TNatureOperation(Source).Pk;
  FCmplCfop         := TNatureOperation(Source).CmplCfop;
  FCodCfop          := TNatureOperation(Source).CodCfop;
  FDscNtOp          := TNatureOperation(Source).DscNtOp;
  FFkFinanceAccount := TNatureOperation(Source).FkFinanceAccount;
  TypeCfop          := TNatureOperation(Source).TypeCfop;
end;

procedure TNatureOperation.Clear;
begin
  Pk                := 0;
  FCmplCfop         := '';
  FCodCfop          := '';
  FDscNtOp          := '';
  FFkFinanceAccount := 0;
  TypeCfop          := nil;
end;

function TNatureOperation.ComparePk(const AValue: Variant): Integer;
begin
  Result := inherited ComparePk(AValue);
end;

function TNatureOperation.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_TIPO_CFOP');
  Result.Add('PK_NATUREZA_OPERACOES');
  Result.Add('DSC_NTOP');
  Result.Add('COD_CFOP');
  if (FCmplCfop <> '') then
    Result.Add('CMPL_CFOP');
  if (FFkFinanceAccount > 0) then
    Result.Add('FK_FINANCEIRO_CONTAS');
end;

function TNatureOperation.GetPkValue: Variant;
begin
  Result := inherited GetPkValue;
end;

procedure TNatureOperation.SetCmplCfop(Value: string);
begin
  FCmplCfop := Copy(Value, 1, 3);
end;

procedure TNatureOperation.SetCodCfop(Value: string);
begin
  FCodCfop := Copy(Value, 1, 5);
end;

procedure TNatureOperation.SetDscNtOp(Value: string);
begin
  FDscNtOp := Copy(Value, 1, 50);
end;

procedure TNatureOperation.SetTypeCfop(Value: TTypeCfop);
begin
  if (Assigned(FTypeCfop)) then
  begin
    FTypeCfop.Clear;
    if (Value <> nil) then
      FTypeCfop.Assign(Value);
  end;
end;


end.
