unit CadPais;

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
  Dialogs, CadModel, StdCtrls, ExtCtrls, ProcUtils;

type
  TCdPaises = class(TfrmModel)
    shTitle: TShape;
    lTitle: TLabel;
    lPk_Paises: TStaticText;
    ePk_Paises: TEdit;
    lDsc_Pais: TStaticText;
    eDsc_Pais: TEdit;
    lFk_Linguagens: TStaticText;
    eFk_Linguagens: TComboBox;
    lFk_Tipo_Moedas: TStaticText;
    eFk_Tipo_Moedas: TComboBox;
    lNac_Pais: TStaticText;
    eNac_Pais: TEdit;
    lFlag_Acm: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscCountry: string;
    function  GetFkCurrency: Integer;
    function  GetFkLanguage: string;
    function  GetFlagAcm: Boolean;
    function  GetNationality: string;
    function  GetPkCountry: Integer;
    procedure SetDscCountry(const Value: string);
    procedure SetFkCurrency(const Value: Integer);
    procedure SetFkLanguage(const Value: string);
    procedure SetFlagAcm(const Value: Boolean);
    procedure SetNationality(const Value: string);
    procedure SetPkCountry(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property PkContry   : Integer read GetPkCountry   write SetPkCountry;
    property FkLanguage : string  read GetFkLanguage  write SetFkLanguage;
    property FkCurrency : Integer read GetFkCurrency  write SetFkCurrency;
    property Nationality: string  read GetNationality write SetNationality;
    property FlagAcm    : Boolean read GetFlagAcm     write SetFlagAcm;
  public
    { Public declarations }
    property DscCountry: string  read GetDscCountry  write SetDscCountry;
  end;

var
  CdPaises: TCdPaises;

implementation

uses Dado, mSysCad, TSysCadAux, TSysGen, GridRow, DB;

{$R *.dfm}

function TCdPaises.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  C := nil;
  S := '';
  if (DscCountry = '') then
  begin
    S := 'Campo Descrição deve ser preenchido';
    C := eDsc_Pais;
  end;
  if (FkLanguage = '') then
  begin
    S := 'Campo Linguagem deve ser preenchido';
    C := eFk_Linguagens;
  end;
  if (FkCurrency <= 0) then
  begin
    S := 'Campo Tipo de Moeda deve ser preenchido';
    C := eFk_Tipo_Moedas;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdPaises.ClearControls;
begin
  Loading := True;
  try
    PkContry    := 0;
    DscCountry  := '';
    Nationality := '';
    FkLanguage  := '';
    FkCurrency  := 0;
    FlagAcm     := False;
  finally
    Loading := False;
  end;
end;

procedure TCdPaises.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

function TCdPaises.GetDscCountry: string;
begin
  Result := eDsc_Pais.Text;
end;

function TCdPaises.GetFkCurrency: Integer;
begin
  Result := 0;
  with eFk_Tipo_Moedas do
    if (ItemIndex <> 0) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdPaises.GetFkLanguage: string;
begin
  Result := '';
  with eFk_Linguagens do
    if (ItemIndex <> 0) and (Items.Objects[ItemIndex] <> nil) then
      Result := TLanguage(Items.Objects[ItemIndex]).PkLanguage;
end;

function TCdPaises.GetFlagAcm: Boolean;
begin
  Result := lFlag_Acm.Checked;
end;

function TCdPaises.GetNationality: string;
begin
  Result := eNac_Pais.Text;
end;

function TCdPaises.GetPkCountry: Integer;
begin
  Result := Pk;
end;

procedure TCdPaises.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Linguagens.Items.AddStrings(dmSysCad.LoadLanguage);
    eFk_Tipo_Moedas.Items.AddStrings(dmSysCad.LoadMoedas);
    ListLoaded := True;
  end;
end;

procedure TCdPaises.MoveDataToControls;
var
  Data: TCountry;
begin
  Loading := True;
  try
    Data        := dmSysCad.Country[Pk];
    PkContry    := Pk;
    DscCountry  := Data.DscPais;
    FkLanguage  := Data.FkLanguage.PkLanguage;
    FkCurrency  := Data.FkMoeda;
    Nationality := Data.NacPais;
    FlagAcm     := Data.FlagAcm;
  finally
    Loading := False;
  end;
end;

procedure TCdPaises.SaveIntoDB;
var
  Data: TCountry;
  aRow: TDataRow;
begin
  Data := TCountry.Create;
  aRow := TDataRow.Create(nil);
  try
    Data.PKCountry                  := Pk;
    Data.DscPais                    := DscCountry;
    Data.FkLanguage.PkLanguage      := FkLanguage;
    Data.FkMoeda                    := FkCurrency;
    Data.NacPais                    := Nationality;
    Data.FlagAcm                    := FlagAcm;
    dmSysCad.Country[Ord(ScrState)] := Data;
    aRow.AddAs('PK', Data.PKCountry, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', Data.DscPais, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := Data.PKCountry;
  finally
    FreeAndNil(Data);
    FreeAndNil(aRow);
  end;
end;

procedure TCdPaises.SetDscCountry(const Value: string);
begin
  eDsc_Pais.Text := Value;
end;

procedure TCdPaises.SetFkCurrency(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Moedas do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
        (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdPaises.SetFkLanguage(const Value: string);
var
  i: Integer;
begin
  with eFk_Linguagens do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
        (TLanguage(Items.Objects[i]).PkLanguage = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdPaises.SetFlagAcm(const Value: Boolean);
begin
  lFlag_Acm.Checked := Value;
end;

procedure TCdPaises.SetNationality(const Value: string);
begin
  eNac_Pais.Text := Value;
end;

procedure TCdPaises.SetPkCountry(const Value: Integer);
begin
  ePk_Paises.Text := IntToStr(Value);
end;

end.
