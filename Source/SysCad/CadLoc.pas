unit CadLoc;

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
  Dialogs, CadModel, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, mSysCad,
  ProcUtils, Buttons;

type
  TCdLogradouros = class(TfrmModel)
    lPk_Logradouros: TStaticText;
    ePk_Logradouros: TEdit;
    lCep_Loc: TStaticText;
    eCep_Loc: TCurrencyEdit;
    eDsc_Loc: TEdit;
    lDsc_Loc: TStaticText;
    lFk_Tipo_Enderecos: TStaticText;
    eFk_Tipo_Enderecos: TComboBox;
    lNum_Ini: TStaticText;
    eNum_Ini: TCurrencyEdit;
    lNum_Fin: TStaticText;
    eNum_Fin: TCurrencyEdit;
    lFlag_Lado: TRadioGroup;
    shTitle: TShape;
    lTitle: TLabel;
    sbNewTAdd: TSpeedButton;
    procedure sbNewTAddClick(Sender: TObject);
  private
    { Private declarations }
    FKey: TLocalKeys;
    function GetCepAddress: Integer;
    function GetDscAddress: string;
    function GetFkTypeAddress: Integer;
    function GetNumFin: Integer;
    function GetNumIni: Integer;
    function GetPkAddress: Integer;
    procedure SetCepAddress(const Value: Integer);
    procedure SetDscAddress(const Value: string);
    procedure SetFkCity(const Value: Integer);
    procedure SetFkCountry(const Value: Integer);
    procedure SetFkDistrict(const Value: Integer);
    procedure SetFkState(const Value: string);
    procedure SetFkTypeAddress(const Value: Integer);
    procedure SetNumFin(const Value: Integer);
    procedure SetNumIni(const Value: Integer);
    procedure SetPkAddress(const Value: Integer);
    function  GetFlagSide: Integer;
    procedure SetFlagSide(const Value: Integer);
    procedure ReleaseTypeAddress;
  protected
    { Protected declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkAddress    : Integer read GetPkAddress     write SetPkAddress;
    property  CepAddress   : Integer read GetCepAddress    write SetCepAddress;
    property  FkTypeAddress: Integer read GetFkTypeAddress write SetFkTypeAddress;
    property  NumIni       : Integer read GetNumIni        write SetNumIni;
    property  NumFin       : Integer read GetNumFin        write SetNumFin;
    property  FlagSide     : Integer read GetFlagSide      write SetFlagSide;
  public
    { Public declarations }
    property  FkCountry  : Integer read FKey.PkCountry  write SetFkCountry;
    property  FkState    : string  read FKey.PkState    write SetFkState;
    property  FkCity     : Integer read FKey.PkCity     write SetFkCity;
    property  FkDistrict : Integer read FKey.PkDistrict write SetFkDistrict;
    property  DscAddress : string  read GetDscAddress   write SetDscAddress;
  end;

var
  CdLogradouros: TCdLogradouros;

implementation

uses Dado, TSysCadAux, GridRow, DB, CadTpe;

{$R *.dfm}

{ TCdLogradouros }

function TCdLogradouros.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (DscAddress = '') then
  begin
    C := eDsc_Loc;
    S := 'Campo Descrição deve ser preenchido';
  end;
  if (CepAddress <= 0) then
  begin
    C := eCep_Loc;
    S := 'Campo C.E.P. deve ser preenchido';
  end;
  if (FkTypeAddress <= 0) then
  begin
    C := eFk_Tipo_Enderecos;
    S := 'Campo Tipo do Endereço deve ser preenchido';
  end;
  if (NumIni <= 0) then
  begin
    C := eNum_Ini;
    S := 'Campo Número Inicial deve ser preenchido';
  end;
  if (NumFin <= 0) then
  begin
    C := eNum_Fin;
    S := 'Campo Número Final deve ser preenchido';
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdLogradouros.ClearControls;
begin
  Loading := True;
  try
    PkAddress     := 0;
    CepAddress    := 0;
    FkTypeAddress := 0;
    NumIni        := 0;
    NumFin        := 0;
    DscAddress    := '';
  finally
    Loading := False;
  end;
end;

function TCdLogradouros.GetCepAddress: Integer;
begin
  Result := eCep_Loc.AsInteger;
end;

function TCdLogradouros.GetDscAddress: string;
begin
  Result := eDsc_Loc.Text;
end;

function TCdLogradouros.GetFkTypeAddress: Integer;
begin
  Result := 0;
  with eFk_Tipo_Enderecos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TAddressType(Items.Objects[ItemIndex]).PkAddressType;
end;

function TCdLogradouros.GetFlagSide: Integer;
begin
  Result := lFlag_Lado.ItemIndex;
end;

function TCdLogradouros.GetNumFin: Integer;
begin
  Result := eNum_Fin.AsInteger;
end;

function TCdLogradouros.GetNumIni: Integer;
begin
  Result := eNum_Ini.AsInteger;
end;

function TCdLogradouros.GetPkAddress: Integer;
begin
  Result := Pk;
end;

procedure TCdLogradouros.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Tipo_Enderecos.Items.AddStrings(dmSysCad.LoadAddressType);
    ListLoaded := True;
  end;
end;

procedure TCdLogradouros.MoveDataToControls;
var
  Data: TLocality;
begin
  Loading := True;
  try
    Data          := dmSysCad.Locality[Pk];
    PkAddress     := Data.PkLocality;
    CepAddress    := Data.CepLog;
    FkTypeAddress := Data.FkAddressType.PkAddressType;
    NumIni        := Data.NumIni;
    NumFin        := Data.NumFin;
    DscAddress    := Data.DscLog;
    FlagSide      := Data.FlagSide;
  finally
    Loading := False;
  end;
end;

procedure TCdLogradouros.SaveIntoDB;
var
  Data: TLocality;
  aRow: TDataRow;
begin
  Data := TLocality.Create;
  aRow := TDataRow.Create(nil);
  try
    Data.PkLocality                  := PkAddress;
    Data.CepLog                      := CepAddress;
    Data.FkAddressType.PkAddressType := FkTypeAddress;
    Data.NumIni                      := NumIni;
    Data.NumFin                      := NumFin;
    Data.DscLog                      := DscAddress;
    Data.FlagSide                    := FlagSide;
    dmSysCad.Locality[Pk]            := Data;
    aRow.AddAs('PK', Data.PkLocality, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', Data.DscLog, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := Data.PkLocality;
  finally
    FreeAndNil(Data);
  end;
end;

procedure TCdLogradouros.SetCepAddress(const Value: Integer);
begin
  eCep_Loc.AsInteger := Value;
end;

procedure TCdLogradouros.SetDscAddress(const Value: string);
begin
  eDsc_Loc.Text := Value;
end;

procedure TCdLogradouros.SetFkCity(const Value: Integer);
begin
  FKey.PkCity := Value;
  dmSysCad.LocalKeys := FKey;
end;

procedure TCdLogradouros.SetFkCountry(const Value: Integer);
begin
  FKey.PkCountry := Value;
  dmSysCad.LocalKeys := FKey;
end;

procedure TCdLogradouros.SetFkDistrict(const Value: Integer);
begin
  FKey.PkDistrict := Value;
  dmSysCad.LocalKeys := FKey;
end;

procedure TCdLogradouros.SetFkState(const Value: string);
begin
  FKey.PkState := Value;
  dmSysCad.LocalKeys := FKey;
end;

procedure TCdLogradouros.SetFkTypeAddress(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Enderecos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (TAddressType(Items.Objects[i]).PkAddressType = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdLogradouros.SetFlagSide(const Value: Integer);
begin
  lFlag_Lado.ItemIndex := Value;
end;

procedure TCdLogradouros.SetNumFin(const Value: Integer);
begin
  eNum_Fin.AsInteger := Value;
end;

procedure TCdLogradouros.SetNumIni(const Value: Integer);
begin
  eNum_Ini.AsInteger := Value;
end;

procedure TCdLogradouros.SetPkAddress(const Value: Integer);
begin
  ePk_Logradouros.Text := IntToStr(Value);
end;

procedure TCdLogradouros.sbNewTAddClick(Sender: TObject);
var
  aForm: TCdTipoEnd;
  aPk  : Integer;
begin
  aForm := TCdTipoEnd.Create(Application);
  try
    aForm.ShowModal;
    aPk := aForm.Pk;
  finally
    FreeAndNil(aForm);
  end;
  ReleaseTypeAddress;
  ListLoaded := False;
  LoadDefaults;
  if (aPk > 0) then
    FkTypeAddress := aPk;
end;

procedure TCdLogradouros.ReleaseTypeAddress;
var
  i : Integer;
begin
  with eFk_Tipo_Enderecos do
  begin
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) then
      begin
        TAddressType(Items.Objects[i]).Free;
        Items.Objects[i] := nil;
      end;
    Items.Clear;
  end;
end;

end.
