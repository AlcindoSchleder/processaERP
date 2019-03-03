unit CadBai;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 28/12/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadModel, Mask, ToolEdit, CurrEdit, StdCtrls, ExtCtrls, mSysCad,
  ProcUtils;

type
  TCdBairros = class(TfrmModel)
    lPk_Bairros: TStaticText;
    ePk_Bairros: TEdit;
    lCep_Bai: TStaticText;
    eCep_Bai: TCurrencyEdit;
    eDsc_Bai: TEdit;
    lDsc_Bai: TStaticText;
    shTitle: TShape;
    lTitle: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FKey: TLocalKeys;
    function  GetCepDistrict: Integer;
    function  GetDscDistrict: string;
    function  GetPkDistrict: Integer;
    procedure SetCepDistrict(const Value: Integer);
    procedure SetDscDistrict(const Value: string);
    procedure SetPkDistrict(const Value: Integer);
    procedure SetFkCity(const Value: Integer);
    procedure SetFkCountry(const Value: Integer);
    procedure SetFkState(const Value: string);
  protected
    { Protected declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkDistrict : Integer read GetPkDistrict  write SetPkDistrict;
    property  CepDistrict: Integer read GetCepDistrict write SetCepDistrict;
  public
    { Public declarations }
    property  FkCountry  : Integer read FKey.PkCountry write SetFkCountry;
    property  FkState    : string  read FKey.PkState   write SetFkState;
    property  FkCity     : Integer read FKey.PkCity    write SetFkCity;
    property  DscDistrict: string  read GetDscDistrict write SetDscDistrict;
  end;

var
  CdBairros: TCdBairros;

implementation

uses Dado, TSysCadAux, GridRow, DB;

{$R *.dfm}

{ TCdBairros }

function TCdBairros.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (DscDistrict = '') then
  begin
    C := eDsc_Bai;
    S := 'Campo Descrição deve ser preenchido';
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdBairros.ClearControls;
begin
  Loading := True;
  try
    PkDistrict  := 0;
    CepDistrict := 0;
    DscDistrict := '';
  finally
    Loading := False;
  end;
end;

procedure TCdBairros.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

function TCdBairros.GetCepDistrict: Integer;
begin
  Result := eCep_Bai.AsInteger;
end;

function TCdBairros.GetDscDistrict: string;
begin
  Result := eDsc_Bai.Text;
end;

function TCdBairros.GetPkDistrict: Integer;
begin
  Result := StrToInt(ePk_Bairros.Text);
end;

procedure TCdBairros.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdBairros.MoveDataToControls;
var
  Data: TDistrict;
begin
  Loading := True;
  try
    Data        := dmSysCad.District[Pk];
    PkDistrict  := Data.PkDistrict;
    CepDistrict := Data.CepBai;
    DscDistrict := Data.DscBai;
  finally
    Loading := False;
  end;
end;

procedure TCdBairros.SaveIntoDB;
var
  Data: TDistrict;
  aRow: TDataRow;
begin
  Data := TDistrict.Create;
  aRow := TDataRow.Create(nil);
  try
    Data.PkDistrict := Pk;
    Data.CepBai     := CepDistrict;
    Data.DscBai     := DscDistrict;
    dmSysCad.District[Pk] := Data;
    aRow.AddAs('PK', Data.PkDistrict, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', Data.DscBai, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := Data.PkDistrict;
  finally
    FreeAndNil(Data);
    FreeAndNil(aRow);
  end;
end;

procedure TCdBairros.SetCepDistrict(const Value: Integer);
begin
  eCep_Bai.AsInteger := Value;
end;

procedure TCdBairros.SetDscDistrict(const Value: string);
begin
  eDsc_Bai.Text := Value;
end;

procedure TCdBairros.SetFkCity(const Value: Integer);
begin
  FKey.PkCity        := Value;
  dmSysCad.LocalKeys := FKey;
end;

procedure TCdBairros.SetFkCountry(const Value: Integer);
begin
  FKey.PkCountry     := Value;
  dmSysCad.LocalKeys := FKey;
end;

procedure TCdBairros.SetFkState(const Value: string);
begin
  FKey.PkState       := Value;
  dmSysCad.LocalKeys := FKey;
end;

procedure TCdBairros.SetPkDistrict(const Value: Integer);
begin
  ePk_Bairros.Text := IntToStr(Value);
end;

end.
