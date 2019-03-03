unit CadTAcc;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/01/2006 - DD/MM/YYYY                                      *}
{* Modified: 03/01/2006 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadModel, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, TSysBcCx;

type
  TCdTypeAccount = class(TfrmModel)
    eDsc_TCta: TEdit;
    lPk_Tipo_Contas: TStaticText;
    lDsc_TCta: TStaticText;
    lFlag_TCta: TRadioGroup;
    ePk_Tipo_Contas: TCurrencyEdit;
    lTitle: TLabel;
    Shape1: TShape;
  private
    function GetDscTCta: string;
    function GetFlagTCta: TAccountType;
    function GetPkTipoContas: Integer;
    procedure SetDscTCta(const Value: string);
    procedure SetFlagTCta(const Value: TAccountType);
    procedure SetPkTipoContas(const Value: Integer);
    function GetTypeAccount: TTypeAccount;
    procedure SetTypeAccount(const Value: TTypeAccount);
  protected
    { Private declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property PkTipoContas: Integer      read GetPkTipoContas write SetPkTipoContas;
    property DscTCta     : string       read GetDscTCta      write SetDscTCta;
    property FlagTCta    : TAccountType read GetFlagTCta     write SetFlagTCta;
    property TypeAccount : TTypeAccount read GetTypeAccount  write SetTypeAccount;
  end;

var
  CdTypeAccount: TCdTypeAccount;

implementation

uses mSysBcCx;

{$R *.dfm}

{ TCdTypeAccount }

procedure TCdTypeAccount.ClearControls;
begin
  Loading      := True;
  DscTCta      := '';
  FlagTCta     := atCash;
  PkTipoContas := 0;
  Loading      := False;
end;

function TCdTypeAccount.GetDscTCta: string;
begin
  Result := eDsc_TCta.Text;
end;

function TCdTypeAccount.GetFlagTCta: TAccountType;
begin
  Result := TAccountType(lFlag_TCta.ItemIndex);
end;

function TCdTypeAccount.GetPkTipoContas: Integer;
begin
  Result := ePk_Tipo_Contas.AsInteger;
end;

function TCdTypeAccount.GetTypeAccount: TTypeAccount;
begin
  Result := dmSysBcCx.GetTypeAccount(Pk);
  if (Result = nil) then exit;
  Loading      := True;
  PkTipoContas := Result.PkTypeAccount;
  DscTCta      := Result.DscTAcc;
  FlagTCta     := Result.FlagTAcc;
  Loading      := False;
end;

procedure TCdTypeAccount.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdTypeAccount.MoveDataToControls;
begin
  // get data from Database
  GetTypeAccount;
end;

procedure TCdTypeAccount.SaveIntoDB;
begin
  // Set data into Database
  SetTypeAccount(TTypeAccount.Create);
end;

procedure TCdTypeAccount.SetDscTCta(const Value: string);
begin
  eDsc_TCta.Text := Value;
end;

procedure TCdTypeAccount.SetFlagTCta(const Value: TAccountType);
begin
  lFlag_TCta.ItemIndex := Ord(Value);
end;

procedure TCdTypeAccount.SetPkTipoContas(const Value: Integer);
begin
  ePk_Tipo_Contas.AsInteger := Value;
end;

procedure TCdTypeAccount.SetTypeAccount(const Value: TTypeAccount);
begin
  if (Value = nil) then exit;
  Loading             := True;
  Value.PkTypeAccount := PkTipoContas;
  Value.DscTAcc       := DscTCta;
  Value.FlagTAcc      := FlagTCta;
  Loading             := False;
  dmSysBcCx.SaveTypeAccount(Value, ScrState);
end;

end.
