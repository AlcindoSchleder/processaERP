unit CadAlqt;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 10/07/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
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
  Dialogs, CadModel, StdCtrls, Mask, ToolEdit, CurrEdit, TSysPedAux, ProcUtils,
  ExtCtrls;

type
  TCdTax = class(TfrmModel)
    shTitle: TShape;
    lTitle: TLabel;
    eAlqt_Arbt: TCurrencyEdit;
    lAlqt_Arbt: TStaticText;
    lAlqt_Impst: TStaticText;
    eAlqt_Impst: TCurrencyEdit;
    lAlqt_Cnsf: TStaticText;
    eAlqt_Cnsf: TCurrencyEdit;
    eFk_Estados: TComboBox;
    lFk_Estados: TStaticText;
    lFk_Paises: TStaticText;
    eFk_Paises: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure eFk_PaisesSelect(Sender: TObject);
  private
    { Private declarations }
    FFlagES: TInOut;
    FFkTypeTax: Integer;
    FUniqueTax: Boolean;
    FEnabledCtrls: Boolean;
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function  GetAlqtArbt: Double;
    function  GetAlqtCnsf: Double;
    function  GetAlqtImpst: Double;
    function  GetFkCountry: Integer;
    function  GetFkState: string;
    procedure LoadStates;
    procedure SetAlqtArbt(const Value: Double);
    procedure SetAlqtCnsf(const Value: Double);
    procedure SetAlqtImpst(const Value: Double);
    procedure SetFkCountry(const Value: Integer);
    procedure SetFkState(const Value: string);
    procedure SetFlagES(const Value: TInOut);
    procedure SetFkTypeTax(const Value: Integer);
    procedure ChangePk(Sender: TObject);
    procedure SetUniqueTax(const Value: Boolean);
    procedure SetEnabledCtrls(const Value: Boolean);
    function  GetDscCountry: string;
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
    property  AlqtImpst: Double  read GetAlqtImpst write SetAlqtImpst;
    property  AlqtCnsf : Double  read GetAlqtCnsf  write SetAlqtCnsf;
    property  AlqtArbt : Double  read GetAlqtArbt  write SetAlqtArbt;
  public
    { Public declarations }
    property  DscCountry  : string  read GetDscCountry;
    property  EnabledCtrls: Boolean read FEnabledCtrls write SetEnabledCtrls;
    property  FlagES      : TInOut  read FFlagES       write SetFlagES;
    property  FkTypeTax   : Integer read FFkTypeTax    write SetFkTypeTax;
    property  FkState     : string  read GetFkState    write SetFkState;
    property  FkCountry   : Integer read GetFkCountry  write SetFkCountry;
    property  UniqueTax   : Boolean read FUniqueTax    write SetUniqueTax;
  end;

implementation

uses Dado, mSysCtb, Funcoes, GridRow, TSysCadAux;

{$R *.dfm}

{ TCdTax }

function TCdTax.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (FkCountry = 0) then
  begin
    S := 'Campo país deve ser preenchido';
    C := eFk_Paises;
  end;
  if (FkState = '') then
  begin
    S := 'Campo Estado deve ser preenchido';
    C := eFk_Paises;
  end;
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTax.ClearControls;
begin
  Loading := True;
  try
    AlqtImpst := 0;
    AlqtCnsf  := 0;
    AlqtArbt  := 0;
    FkCountry := 0;
    FkState   := '';
  finally
    Loading := False;
  end;
end;

function TCdTax.GetAlqtArbt: Double;
begin
  Result := eAlqt_Arbt.Value;
end;

function TCdTax.GetAlqtCnsf: Double;
begin
  Result := eAlqt_Cnsf.Value;
end;

function TCdTax.GetAlqtImpst: Double;
begin
  Result := eAlqt_Impst.Value;
end;

function TCdTax.GetFkCountry: Integer;
begin
  with eFk_Paises do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdTax.GetFkState: string;
begin
  with eFk_Estados do
  begin
    Result := '';
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TState(Items.Objects[ItemIndex]).PkState;
  end;
end;

procedure TCdTax.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Paises.Items.AddStrings(dmSysCtb.LoadCountries);
    ListLoaded := True;
  end;
end;

procedure TCdTax.LoadStates;
begin
  ReleaseCombos(eFk_Estados, toObject);
  eFk_Estados.Items.AddStrings(dmSysCtb.LoadStates(FkCountry));
end;

procedure TCdTax.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysCtb.Tax[Pk] do
    begin
      AlqtImpst := FieldByName['ALQT_IMPST'].AsFloat;
      AlqtCnsf  := FieldByName['ALQT_CNSF'].AsFloat;
      AlqtArbt  := FieldByName['ALQT_ARBT'].AsFloat;
      FkCountry := FieldByName['FK_PAISES'].AsInteger;
      FkState   := FieldByName['FK_ESTADOS'].AsString;
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdTax.SaveIntoDB;
var
  aData: TDataRow;
begin
  aData   := dmSysCtb.Tax[0];
  Loading := True;
  try
    aData.FieldByName['ALQT_IMPST'].AsFloat     := AlqtImpst;
    aData.FieldByName['ALQT_CNSF'].AsFloat      := AlqtCnsf;
    aData.FieldByName['ALQT_ARBT'].AsFloat      := AlqtArbt;
    aData.FieldByName['FK_PAISES'].AsInteger    := FkCountry;
    aData.FieldByName['FK_ESTADOS'].AsString    := FkState;
    dmSysCtb.Tax[Ord(ScrState)] := aData;
    if Assigned(OnUpdateRow) then OnUpdateRow(Self, aData);
    Pk := Ord(FFlagES);
  finally
    Loading := False;
    FreeAndNil(aData);
  end;
end;

procedure TCdTax.SetAlqtArbt(const Value: Double);
begin
  eAlqt_Arbt.Value := Value;
end;

procedure TCdTax.SetAlqtCnsf(const Value: Double);
begin
  eAlqt_Cnsf.Value := Value;
end;

procedure TCdTax.SetAlqtImpst(const Value: Double);
begin
  eAlqt_Impst.Value := Value;
end;

procedure TCdTax.SetFkCountry(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Paises do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        dmSysCtb.FkCountry := Integer(Items.Objects[i]);
        LoadStates;
        break;
      end;
    end;
    if (ItemIndex = -1) and (Items.Count <= 2) then
    begin
      if (Items.Count = 1) then
        ItemIndex := 0
      else
        ItemIndex := 1;
      LoadStates
    end;
  end;
end;

procedure TCdTax.SetFkState(const Value: string);
var
  i: Integer;
begin
  with eFk_Estados do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (Value = TState(Items.Objects[i]).PkState) then
      begin
        ItemIndex := i;
        dmSysCtb.FkState := TState(Items.Objects[i]).PkState;
        break;
      end;
    end;
  end;
end;

procedure TCdTax.SetFkTypeTax(const Value: Integer);
begin
  FFkTypeTax         := Value;
  dmSysCtb.FkTypeTax := Value;
end;

procedure TCdTax.SetFlagES(const Value: TInOut);
begin
  FFlagES         := Value;
  dmSysCtb.FlagES := Value;
end;

procedure TCdTax.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
  OnChangePK    := ChangePk;
end;

procedure TCdTax.ChangePk(Sender: TObject);
begin
  eFk_Estados.Enabled := (Pk = 0) and FUniqueTax;
  lFk_Estados.Enabled := (Pk = 0) and FUniqueTax;
  eFk_Paises.Enabled  := (Pk = 0) and FUniqueTax;
  lFk_Paises.Enabled  := (Pk = 0) and FUniqueTax;
end;

procedure TCdTax.eFk_PaisesSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (FkCountry > 0) then
    LoadStates;
end;

procedure TCdTax.SetUniqueTax(const Value: Boolean);
begin
  FUniqueTax := Value;
  FkCountry := Dados.CompanyCity;
  FkState   := Dados.CompanyState;
  dmSysCtb.FkCountry := FkCountry;
  dmSysCtb.FkState   := FkState;
end;

procedure TCdTax.SetEnabledCtrls(const Value: Boolean);
begin
  FEnabledCtrls       := Value;
  eFk_Paises.Enabled  := FEnabledCtrls;
  eFk_Estados.Enabled := FEnabledCtrls;
  eAlqt_Cnsf.Enabled  := FEnabledCtrls;
  eAlqt_Impst.Enabled := FEnabledCtrls;
  eAlqt_Arbt.Enabled  := FEnabledCtrls;
  lFk_Paises.Enabled  := FEnabledCtrls;
  lFk_Estados.Enabled := FEnabledCtrls;
  lAlqt_Cnsf.Enabled  := FEnabledCtrls;
  lAlqt_Impst.Enabled := FEnabledCtrls;
  lAlqt_Arbt.Enabled  := FEnabledCtrls;
  lTitle.Enabled      := FEnabledCtrls;
end;

function TCdTax.GetDscCountry: string;
begin
  with eFk_Paises do
  begin
    Result := '';
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Text;
  end;
end;

end.
