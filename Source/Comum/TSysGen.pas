unit TSysGen;

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
  Forms, Dialogs;

type
  TLanguage = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscLang: string;
    FPkLanguage: string;
    procedure SetDscLang(AValue: string);
    procedure SetPkLanguage(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscLang: string read FDscLang write SetDscLang;
    property PkLanguage: string read FPkLanguage write SetPkLanguage;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  

implementation

{
********************************** TLanguage ***********************************
}
constructor TLanguage.Create;
begin
  inherited Create;
  Clear;
end;

destructor TLanguage.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TLanguage.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TLanguage) then
  begin
    FcbIndex   := TLanguage(Source).cbIndex;
    DscLang    := TLanguage(Source).DscLang;
    PkLanguage := TLanguage(Source).PkLanguage;
  end
  else
    inherited Assign(Source);
end;

procedure TLanguage.Clear;
begin
  FcbIndex    := 0;
  FDscLang    := '';
  FPkLanguage := '';
end;

function TLanguage.ComparePk(const AValue: Variant): Integer;
var
  aPk: string;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := '';
  end;
  if (aPk = FPkLanguage) then
    Result := FcbIndex;
end;

function TLanguage.GetPkValue: Variant;
begin
  Result := FPkLanguage;
end;

procedure TLanguage.SetDscLang(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 30) then
    AValue := Copy(AValue, 1, 30);
  FDscLang := AValue;
end;

procedure TLanguage.SetPkLanguage(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 5) then
    AValue := Copy(AValue, 1, 5);
  FPkLanguage := AValue;
end;


end.
