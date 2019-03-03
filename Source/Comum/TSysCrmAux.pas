unit TSysCrmAux;

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
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, TSysManAux, vpBaseDS;

type
  TOperatorRes = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscRes: TStrings;
    FFkOperator: TOperator;
    FFlagAtv: Boolean;
    FFlagSuper: Boolean;
    FObsRes: TStrings;
    FObsUser: TStrings;
    FPkResources: Integer;
    procedure SetDscRes(AValue: TStrings);
    procedure SetFkOperator(AValue: TOperator);
    procedure SetObsRes(AValue: TStrings);
    procedure SetObsUser(AValue: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscRes: TStrings read FDscRes write SetDscRes;
    property FkOperator: TOperator read FFkOperator write SetFkOperator;
    property FlagAtv: Boolean read FFlagAtv write FFlagAtv;
    property FlagSuper: Boolean read FFlagSuper write FFlagSuper;
    property ObsRes: TStrings read FObsRes write SetObsRes;
    property ObsUser: TStrings read FObsUser write SetObsUser;
    property PkResources: Integer read FPkResources write FPkResources;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  

implementation

{
********************************* TOperatorRes *********************************
}
constructor TOperatorRes.Create;
begin
  inherited Create;
  FDscRes     := TStringList.Create;
  FFkOperator := TOperator.Create;
  FObsRes     := TStringList.Create;
  FObsUser    := TStringList.Create;
  Clear;
end;

destructor TOperatorRes.Destroy;
begin
  Clear;
  if Assigned(FDscRes) then
    FDscRes.Free;
  if Assigned(FFkOperator) then
    FFkOperator.Free;
  if Assigned(FObsRes) then
    FObsRes.Free;
  if Assigned(FObsUser) then
    FObsUser.Free;
  FDscRes     := nil;
  FFkOperator := nil;
  FObsRes     := nil;
  FObsUser    := nil;
  inherited Destroy;
end;

procedure TOperatorRes.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOperatorRes) then
  begin
    cbIndex     := TOperatorRes(Source).cbIndex;
    DscRes      := TOperatorRes(Source).DscRes;
    FkOperator  := TOperatorRes(Source).FkOperator;
    FFlagAtv    := TOperatorRes(Source).FlagAtv;
    FFlagSuper  := TOperatorRes(Source).FlagSuper;
    ObsRes      := TOperatorRes(Source).ObsRes;
    ObsUser     := TOperatorRes(Source).ObsUser;
    PkResources := TOperatorRes(Source).PkResources;
  end
  else
    inherited Assign(Source);
end;

procedure TOperatorRes.Clear;
begin
  cbIndex     := 0;
  if Assigned(FDscRes) then
    FDscRes.Clear;
  if Assigned(FkOperator) then
    FFkOperator.Clear;
  FFlagAtv    := True;
  FFlagSuper  := False;
  if Assigned(FObsRes) then
    FObsRes.Clear;
  if Assigned(FObsUser) then
    FObsUser.Clear;
  PkResources := 0;
end;

function TOperatorRes.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkResources) then
    Result := FcbIndex;
end;

function TOperatorRes.GetPkValue: Variant;
begin
  Result := FPkResources;
end;

procedure TOperatorRes.SetDscRes(AValue: TStrings);
begin
  if (AValue = nil) then
    FDscRes.Clear
  else
    FDscRes.Assign(AValue);
end;

procedure TOperatorRes.SetFkOperator(AValue: TOperator);
begin
  if (AValue = nil) then
    FFkOperator.Clear
  else
    FFkOperator.Assign(AValue);
end;

procedure TOperatorRes.SetObsRes(AValue: TStrings);
begin
  if (AValue = nil) then
    FObsRes.Clear
  else
    FObsRes.Assign(AValue);
end;

procedure TOperatorRes.SetObsUser(AValue: TStrings);
begin
  if (AValue = nil) then
    FObsUser.Clear
  else
    FObsUser.Assign(AValue);
end;


end.
