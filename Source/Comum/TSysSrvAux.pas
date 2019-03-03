unit TSysSrvAux;

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
  SysUtils, Classes, Controls;


(*
Os componentes desta unit são todos utilizados no módulo Ordem de Serviços do
Sistema Processa E.R.P. - Open Source.

Temos basicamente três categorias de componentes que definem as telas do módulo:
TTypeCheckObject e TCheckObject:
Classes genéricas para inserir os tipos de negócios a serem controlados na OS
ex: Carros, Construções, Rodovias, etc..

TTypeService e TInsumos:
Classes que definem os tipos de serviços e, dentro destes, atividades e
materiais utilizados para execução dos mesmos.
TypeSrv
*)

type

  TSide                = (sLeft, sRight, sBoth);
  
  TMarkType            = (mtInitial, mtFinal);
  
// 0 ==> Ocorrências das Passagens
// 1 ==> Troca de Turnos
// 2 ==> Passagens com cartão magnético
// 3 ==> Outras Ocorrências (co)
// 4 ==> Cobrança do Pedágio
  TOccurrenceType       = (otOccPass, otChangeShift, otMagneticCard, otOther,
                          otCollect); 
  
  TOnValidateMarkEvent = procedure (Sender: TObject; const Mark: TMarkType; var 
          Value: Double; const MarkIni, MarkFin: Double) of object;
  TRodovias = class (TPersistent)
  private
    FDscRod: string;
    FExtTot: Double;
    FIndex: Integer;
    FKmFin: Double;
    FKmIni: Double;
    FPkRodovias: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DscRod: string read FDscRod write FDscRod;
    property ExtTot: Double read FExtTot write FExtTot;
    property Index: Integer read FIndex write FIndex;
    property KmFin: Double read FKmFin write FKmFin;
    property KmIni: Double read FKmIni write FKmIni;
    property PkRodovias: Integer read FPkRodovias write FPkRodovias;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TMetricItem = class (TPersistent)
  private
    FActive: Boolean;
    FFlagSide: TSide;
    FKmFin: Double;
    FKmIni: Double;
    FOnValidateMark: TOnValidateMarkEvent;
    procedure SetKmFin(Value: Double);
    procedure SetKmIni(Value: Double);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; dynamic;
    property Active: Boolean read FActive write FActive;
    property FlagSide: TSide read FFlagSide write FFlagSide;
    property KmFin: Double read FKmFin write SetKmFin;
    property KmIni: Double read FKmIni write SetKmIni;
    property OnValidateMark: TOnValidateMarkEvent read FOnValidateMark write 
            FOnValidateMark;
  end;
  
  TTypeOccurs = class (TPersistent)
  private
    FDscTOcr: string;
    FDtaLRead: TDate;
    FFlagGFin: Boolean;
    FFlagTOcr: TOccurrenceType;
    FPkTypeOccurs: Integer;
    FPrefixFile: string;
    procedure SetDscTOcr(Value: string);
    procedure SetPrefixFile(Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DscTOcr: string read FDscTOcr write SetDscTOcr;
    property DtaLRead: TDate read FDtaLRead write FDtaLRead;
    property FlagGFin: Boolean read FFlagGFin write FFlagGFin;
    property FlagTOcr: TOccurrenceType read FFlagTOcr write FFlagTOcr default 
            otOccPass;
    property PkTypeOccurs: Integer read FPkTypeOccurs write FPkTypeOccurs;
    property PrefixFile: string read FPrefixFile write SetPrefixFile;
  end;
  

implementation

{
********************************** TRodovias ***********************************
}
constructor TRodovias.Create;
begin
  inherited Create;
  Clear;
end;

destructor TRodovias.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TRodovias.Assign(Source: TPersistent);
begin
  if (Source is TRodovias) then
  begin
    FDscRod     := TRodovias(Source).DscRod;
    FExtTot     := TRodovias(Source).ExtTot;
    FkmIni      := TRodovias(Source).KmIni;
    FkmFin      := TRodovias(Source).KmFin;
    FPkRodovias := TRodovias(Source).PkRodovias;
  end
  else
    inherited Assign(Source);
end;

procedure TRodovias.Clear;
begin
  FDscRod     := '';
  FExtTot     := 0.0;
  FkmIni      := 0.0;
  FkmFin      := 0.0;
  FPkRodovias := 0;
end;

function TRodovias.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkRodovias) then
    Result := FIndex;
end;

function TRodovias.GetPkValue: Variant;
begin
  Result := FPkRodovias;
end;

{
********************************* TMetricItem **********************************
}
constructor TMetricItem.Create;
begin
  inherited Create;
  Clear;
end;

destructor TMetricItem.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TMetricItem.Assign(Source: TPersistent);
begin
  if (Source is TMetricItem) then
  begin
    FActive    := TMetricItem(Source).Active;
    FKmIni     := TMetricItem(Source).KmIni;
    FKmFin     := TMetricItem(Source).KmFin;
    FFlagSide  := TMetricItem(Source).FlagSide;
  end
  else
    inherited Assign(Source);
end;

procedure TMetricItem.Clear;
begin
  FActive    := False;
  FKmIni     := 0.0;
  FKmFin     := 0.0;
  FFlagSide  := sBoth;
end;

procedure TMetricItem.SetKmFin(Value: Double);
begin
  if (Value <> 0) and (FkmFin <> Value) and (Assigned(FOnValidateMark)) then
    FOnValidateMark(Self, mtFinal, Value, FKmIni, FKmFin);
  FKmFin := Value;
end;

procedure TMetricItem.SetKmIni(Value: Double);
begin
  if (Value <> 0) and (FkmIni <> Value) and (Assigned(FOnValidateMark)) then
    FOnValidateMark(Self, mtInitial, Value, FKmIni, FKmFin);
  FKmIni := Value;
end;

{
********************************* TTypeOccurs **********************************
}
constructor TTypeOccurs.Create;
begin
  inherited Create;
  Clear;
end;

destructor TTypeOccurs.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TTypeOccurs.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TTypeOccurs) then
  begin
    DscTOcr       := TTypeOccurs(Source).DscTOcr;
    FDtaLRead     := TTypeOccurs(Source).DtaLRead;
    FFlagGFin     := TTypeOccurs(Source).FlagGFin;
    FFlagTOcr     := TTypeOccurs(Source).FlagTOcr;
    FPkTypeOccurs := TTypeOccurs(Source).PkTypeOccurs;
    PrefixFile    := TTypeOccurs(Source).PrefixFile;
  end
  else
    inherited Assign(Source);
end;

procedure TTypeOccurs.Clear;
begin
  FDscTOcr      := '';
  FDtaLRead     := 0;
  FFlagGFin     := False;
  FFlagTOcr     := otOccPass;
  FPkTypeOccurs := 0;
  FPrefixFile   := '';
end;

procedure TTypeOccurs.SetDscTOcr(Value: string);
begin
  FDscTOcr := Copy(Value, 1, 30);
end;

procedure TTypeOccurs.SetPrefixFile(Value: string);
begin
  FPrefixFile := Copy(Value, 1, 10);
end;


end.
