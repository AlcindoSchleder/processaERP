unit TSysConfAux;

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
  SysUtils, Classes;

type
  TTypeDescription = (tdDescrAndReference, tdDescription, tdReference, tdOther);
  
  TMaterialMode     = (mmSelectFinish, mmSuppliedFinish, mmWithOutFinish);
  
  TComponentType = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscTComp: string;
    FPkComponent: Integer;
    FQtdComp: Double;
    procedure SetDscTComp(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscTComp: string read FDscTComp write SetDscTComp;
    property PkComponent: Integer read FPkComponent write FPkComponent;
    property QtdComp: Double read FQtdComp write FQtdComp;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TFinishType = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscAcbm: string;
    FFlagTDsc: TTypeDescription;
    FPkFinishType: Integer;
    FPreVda: Double;
    FQtdPdr: Double;
    FQtdPers: Double;
    procedure SetDscAcbm(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscAcbm: string read FDscAcbm write SetDscAcbm;
    property FlagTDsc: TTypeDescription read FFlagTDsc write FFlagTDsc;
    property PkFinishType: Integer read FPkFinishType write FPkFinishType 
            default 0;
    property PreVda: Double read FPreVda write FPreVda;
    property QtdPdr: Double read FQtdPdr write FQtdPdr;
    property QtdPers: Double read FQtdPers write FQtdPers;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TReferenceType = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscRef: string;
    FEndRange: Double;
    FFkFinishType: TFinishType;
    FFlagTIns: TMaterialMode;
    FPkReferenceType: Integer;
    FStartRange: Double;
    procedure SetDscRef(AValue: string);
    procedure SetFkFinishType(AValue: TFinishType);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscRef: string read FDscRef write SetDscRef;
    property EndRange: Double read FEndRange write FEndRange;
    property FkFinishType: TFinishType read FFkFinishType write SetFkFinishType;
    property FlagTIns: TMaterialMode read FFlagTIns write FFlagTIns;
    property PkReferenceType: Integer read FPkReferenceType write 
            FPkReferenceType default 0;
    property StartRange: Double read FStartRange write FStartRange;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  

implementation

{
******************************** TComponentType ********************************
}
constructor TComponentType.Create;
begin
  inherited Create;
  Clear;
end;

destructor TComponentType.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TComponentType.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TComponentType) then
  begin
    FDscTComp    := TComponentType(Source).DscTComp;
    FPkComponent := TComponentType(Source).PkComponent;
    FQtdComp     := TComponentType(Source).QtdComp;
    FcbIndex     := TComponentType(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TComponentType.Clear;
begin
  FDscTComp    := '';
  FPkComponent := 0;
  FQtdComp     := 0.0;
  FcbIndex     := 0;
end;

function TComponentType.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkComponent) then
    Result := FcbIndex;
end;

function TComponentType.GetPkValue: Variant;
begin
  Result := FPkComponent;
end;

procedure TComponentType.SetDscTComp(AValue: string);
begin
  FDscTComp := Copy(AValue, 1, 30);
end;

{
********************************* TFinishType **********************************
}
constructor TFinishType.Create;
begin
  inherited Create;
  Clear;
end;

destructor TFinishType.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TFinishType.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TFinishType) then
  begin
    FPkFinishType := TFinishType(Source).PkFinishType;
    DscAcbm       := TFinishType(Source).DscAcbm;
    FcbIndex      := TFinishType(Source).cbIndex;
    FQtdPdr       := TFinishType(Source).QtdPdr;
    FQtdPers      := TFinishType(Source).QtdPers;
    FPreVda       := TFinishType(Source).PreVda;
    FFlagTDsc     := TFinishType(Source).FlagTDsc;
  end
  else
    inherited Assign(Source);
end;

procedure TFinishType.Clear;
begin
  FPkFinishType := 0;
  FDscAcbm      := '';
  FcbIndex      := 0;
  FQtdPdr       := 0.0;
  FQtdPers      := 0.0;
  FPreVda       := 0.0;
  FFlagTDsc     := tdDescrAndReference;
end;

function TFinishType.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkFinishType) then
    Result := FcbIndex;
end;

function TFinishType.GetPkValue: Variant;
begin
  Result := FPkFinishType;
end;

procedure TFinishType.SetDscAcbm(AValue: string);
begin
  FDscAcbm := Copy(AValue, 1, 30);
end;

{
******************************** TReferenceType ********************************
}
constructor TReferenceType.Create;
begin
  inherited Create;
  FFkFinishType := TFinishType.Create;
  Clear;
end;

destructor TReferenceType.Destroy;
begin
  Clear;
  if Assigned(FFkFinishType) then
    FFkFinishType.Free;
  FFkFinishType := nil;
  inherited Destroy;
end;

procedure TReferenceType.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TReferenceType) then
  begin
    FPkReferenceType := TReferenceType(Source).PkReferenceType;
    DscRef           := TReferenceType(Source).DscRef;
    FStartRange      := TReferenceType(Source).StartRange;
    FEndRange        := TReferenceType(Source).EndRange;
    FFlagTIns        := TReferenceType(Source).FlagTIns;
    FcbIndex         := TReferenceType(Source).cbIndex;
    if Assigned(FFkFinishType) then
      FkFinishType   := TReferenceType(Source).FkFinishType;
  end
  else
    inherited Assign(Source);
end;

procedure TReferenceType.Clear;
begin
  FPkReferenceType := 0;
  FDscRef          := '';
  FStartRange      := 0.0;
  FEndRange        := 0.0;
  FFlagTIns        := mmSelectFinish;
  FcbIndex         := 0;
  if Assigned(FFkFinishType) then
    FFkFinishType.Clear;
end;

function TReferenceType.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkReferenceType) then
    Result := FcbIndex;
end;

function TReferenceType.GetPkValue: Variant;
begin
  Result := FPkReferenceType;
end;

procedure TReferenceType.SetDscRef(AValue: string);
begin
  FDscRef := Copy(AValue, 1, 30);
end;

procedure TReferenceType.SetFkFinishType(AValue: TFinishType);
begin
  if (AValue = nil) then
    FFkFinishType.Clear
  else
    FFkFinishType.Assign(AValue);
end;


end.
