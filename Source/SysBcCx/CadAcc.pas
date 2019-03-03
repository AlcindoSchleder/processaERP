unit CadAcc;

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
  Dialogs, CadModel, StdCtrls, ExtCtrls, ComCtrls, Mask, ToolEdit, CurrEdit,
  TSysBcCx;

type
  TCdAccount = class(TfrmModel)
    pgAccount: TPageControl;
    tsAccounts: TTabSheet;
    tsBankAccounts: TTabSheet;
    gbSld: TGroupBox;
    lSld_Cta: TStaticText;
    eSld_Cta: TCurrencyEdit;
    lSld_Prev: TStaticText;
    eSld_Prev: TCurrencyEdit;
    lDta_Abr: TStaticText;
    lDta_Fch: TStaticText;
    eDsc_Cta: TEdit;
    lDsc_Cta: TStaticText;
    lPk_Contas: TStaticText;
    ePk_Contas: TCurrencyEdit;
    lSld_Ini: TStaticText;
    eSld_Ini: TCurrencyEdit;
    lNum_Cta: TStaticText;
    eNum_Cta: TEdit;
    Shape1: TShape;
    lTitle: TLabel;
    lNum_IniTl: TStaticText;
    eNum_Chq: TCurrencyEdit;
    lNum_Chq: TStaticText;
    eNum_IniTl: TCurrencyEdit;
    lPag_Num: TStaticText;
    eNum_Rem: TCurrencyEdit;
    lNum_Rem: TStaticText;
    ePag_Num: TCurrencyEdit;
    lNum_Crt: TStaticText;
    eNum_Crt: TEdit;
    lSld_Real: TStaticText;
    eSld_Real: TCurrencyEdit;
    lSld_Prvst: TStaticText;
    eSld_Prvst: TCurrencyEdit;
    eDta_Abr: TDateEdit;
    eDta_Fch: TDateEdit;
    lDta_Sld: TStaticText;
    eDta_Sld: TEdit;
  private
    FPkAgency     : string;
    FPkBank       : Integer;
    FFkTypeAccount: Integer;
    { Private declarations }
    function  GetAccount: TAccount;
    function  GetAccountData: TAccount;
    function  GetBankAccount: TBankAccount;
    function  GetDscCta: string;
    function  GetDtaAbr: TDate;
    function  GetDtaFch: TDate;
    function  GetNumChq: Integer;
    function  GetNumCrt: string;
    function  GetNumCta: string;
    function  GetNumIniTl: Integer;
    function  GetNumRem: Integer;
    function  GetPagNum: Integer;
    function  GetPkAccount: Integer;
    function  GetSldCta: Double;
    function  GetSldIni: Double;
    function  GetSldPrev: Double;
    function  GetSldPrvst: Double;
    function  GetSldReal: Double;
    procedure SetDscCta(const Value: string);
    procedure SetDtaAbr(const Value: TDate);
    procedure SetDtaFch(const Value: TDate);
    procedure SetDtaSld(const Value: TDate);
    procedure SetNumChq(const Value: Integer);
    procedure SetNumCrt(const Value: string);
    procedure SetNumCta(const Value: string);
    procedure SetNumIniTl(const Value: Integer);
    procedure SetNumRem(const Value: Integer);
    procedure SetPagNum(const Value: Integer);
    procedure SetSldCta(const Value: Double);
    procedure SetSldIni(const Value: Double);
    procedure SetSldPrev(const Value: Double);
    procedure SetSldPrvst(const Value: Double);
    procedure SetSldReal(const Value: Double);
    procedure SetAccount(const Value: TAccount);
    procedure SetBankAccount(const Value: TBankAccount);
    procedure SetPkAccount(const Value: Integer);
    procedure SetFkTypeAccount(const Value: Integer);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  Account    : TAccount     read GetAccount     write SetAccount;
    property  BankAccount: TBankAccount read GetBankAccount write SetBankAccount;
    property  DtaAbr     : TDate        read GetDtaAbr      write SetDtaAbr;
    property  DtaFch     : TDate        read GetDtaFch      write SetDtaFch;
    property  DscCta     : string       read GetDscCta      write SetDscCta;
    property  DtaSld     : TDate                            write SetDtaSld;
    property  NumChq     : Integer      read GetNumChq      write SetNumChq;
    property  NumCrt     : string       read GetNumCrt      write SetNumCrt;
    property  NumCta     : string       read GetNumCta      write SetNumCta;
    property  NumIniTl   : Integer      read GetNumIniTl    write SetNumIniTl;
    property  NumRem     : Integer      read GetNumRem      write SetNumRem;
    property  PagNum     : Integer      read GetPagNum      write SetPagNum;
    property  SldCta     : Double       read GetSldCta      write SetSldCta;
    property  SldIni     : Double       read GetSldIni      write SetSldIni;
    property  SldPrev    : Double       read GetSldPrev     write SetSldPrev;
    property  SldPrvst   : Double       read GetSldPrvst    write SetSldPrvst;
    property  SldReal    : Double       read GetSldReal     write SetSldReal;
  public
    { Public declarations }
    property  FkTypeAccount: Integer    read FFkTypeAccount write SetFkTypeAccount;
    property  PkBank       : Integer    read FPkBank        write FPkBank;
    property  PkAccount    : Integer    read GetPkAccount   write SetPkAccount;
    property  PkAgency     : string     read FPkAgency      write FPkAgency;
  end;

var
  CdAccount: TCdAccount;

implementation

uses mSysBcCx;

{$R *.dfm}

{ TCdAccount }

procedure TCdAccount.ClearControls;
begin
  if (PkBank = 0) then
  begin
    DtaAbr    := 0;
    DtaFch    := 0;
    DscCta    := '';
    DtaSld    := 0;
    PkAccount := 0;
    SldCta    := 0.0;
    SldIni    := 0.0;
    SldPrev   := 0.0;
  end;
  if (PkBank > 0) then
  begin
    NumChq   := 0;
    NumCrt   := '';
    NumCta   := '';
    NumIniTl := 0;
    NumRem   := 0;
    PagNum   := 0;
    SldPrvst := 0.0;
    SldReal  := 0.0;
  end;
end;

function TCdAccount.GetAccount: TAccount;
begin
  PkAgency  := '';
  PkBank    := 0;
  pgAccount.ActivePageIndex := 0;
  tsBankAccounts.TabVisible := False;
  Result := GetAccountData;
end;

function TCdAccount.GetAccountData: TAccount;
begin
  Result    := dmSysBcCx.GetAccount(FFkTypeAccount, Pk);
  if (Result = nil) then exit;
  Loading   := True;
  PkAccount := Result.PkContas;
  DscCta    := Result.DscAcc;
  SldIni    := Result.SldIni;
  SldCta    := Result.SldAcc;
  SldPrev   := Result.SldPrev;
  DtaAbr    := Result.DtaAbr;
  DtaFch    := Result.DtaFch;
  DtaSld    := Result.DtaSld;
  Loading   := False;
end;

function TCdAccount.GetBankAccount: TBankAccount;
begin
  GetAccountData;
  Result    := dmSysBcCx.GetBankAccount(Pk, FPkBank, PkAccount, FPkAgency);
  tsBankAccounts.TabVisible := True;
  pgAccount.ActivePageIndex := 0;
  if (Result = nil) then exit;
  Loading   := True;
  NumCta    := Result.CodCta;
  NumCrt    := Result.NumCtr;
  NumIniTl  := Result.NumIniT;
  NumChq    := Result.NumCheck;
  NumRem    := Result.NumRem;
  SldReal   := Result.SldReal;
  SldPrvst  := Result.SldPrev;
  Loading   := False;
end;

function TCdAccount.GetDscCta: string;
begin
  Result := eDsc_Cta.Text;
end;

function TCdAccount.GetDtaAbr: TDate;
begin
  Result := eDta_Abr.Date;
end;

function TCdAccount.GetDtaFch: TDate;
begin
  Result := eDta_Fch.Date;
end;

function TCdAccount.GetNumChq: Integer;
begin
  Result := eNum_Chq.AsInteger;
end;

function TCdAccount.GetNumCrt: string;
begin
  Result := eNum_Crt.Text;
end;

function TCdAccount.GetNumCta: string;
begin
  Result := eNum_Cta.Text;
end;

function TCdAccount.GetNumIniTl: Integer;
begin
  Result := eNum_IniTl.AsInteger;
end;

function TCdAccount.GetNumRem: Integer;
begin
  Result := eNum_Rem.AsInteger;
end;

function TCdAccount.GetPagNum: Integer;
begin
  Result := ePag_Num.AsInteger;
end;

function TCdAccount.GetPkAccount: Integer;
begin
  Result := ePk_Contas.AsInteger;
end;

function TCdAccount.GetSldCta: Double;
begin
  Result := eSld_Cta.Value;
end;

function TCdAccount.GetSldIni: Double;
begin
  Result := eSld_Ini.Value;
end;

function TCdAccount.GetSldPrev: Double;
begin
  Result := eSld_Prev.Value;
end;

function TCdAccount.GetSldPrvst: Double;
begin
  Result := eSld_Prvst.Value;
end;

function TCdAccount.GetSldReal: Double;
begin
  Result := eSld_Real.Value;
end;

procedure TCdAccount.LoadDefaults;
begin
  MoveDataToControls;
end;

procedure TCdAccount.MoveDataToControls;
begin
  if (Pk = 0) then exit;
  if (FPkBank = 0) and (FPkAgency = '') then
    GetAccount
  else
    GetBankAccount;
end;

procedure TCdAccount.SaveIntoDB;
begin
  if (Pk = 0) then exit;
  if (FPkBank = 0) and (FPkAgency = '') then
    SetAccount(TAccount.Create)
  else
    SetBankAccount(TBankAccount.Create(nil));
end;

procedure TCdAccount.SetAccount(const Value: TAccount);
begin
  if (Value = nil) then exit;
  Loading        := True;
  Value.DtaAbr   := DtaAbr;
  Value.DtaFch   := DtaFch;
  Value.DscAcc   := DscCta;
  Value.PkContas := PkAccount;
  Value.SldAcc   := SldCta;
  Value.SldIni   := SldIni;
  Value.SldPrev  := SldPrev;
  Loading        := False;
  dmSysBcCx.SaveAccount(Pk, Value, ScrState);
  PkAccount      := Value.PkContas;
end;

procedure TCdAccount.SetBankAccount(const Value: TBankAccount);
begin
  if (Value = nil) then exit;
  Loading        := True;
  Value.NumCheck := NumChq;
  Value.NumCtr   := NumCrt;
  Value.CodCta   := NumCta;
  Value.NumIniT  := NumIniTl;
  Value.NumRem   := NumRem;
  Value.QtdCheck := PagNum;
  Value.SldPrev  := SldPrvst;
  Value.SldReal  := SldReal;
  Loading        := False;
  SetAccount(TAccount.Create);
  dmSysBcCx.SaveBankAccount(Pk, FPkBank, PkAccount, FPkAgency, Value, ScrState);
end;

procedure TCdAccount.SetDscCta(const Value: string);
begin
  eDsc_Cta.Text := Value;
end;

procedure TCdAccount.SetDtaAbr(const Value: TDate);
begin
  eDta_Abr.Clear;
  if (Value > 0) then
    eDta_Abr.Date := Value;
end;

procedure TCdAccount.SetDtaFch(const Value: TDate);
begin
  eDta_Fch.Clear;
  if (Value > 0) then
    eDta_Fch.Date := Value;
end;

procedure TCdAccount.SetNumChq(const Value: Integer);
begin
  eNum_Chq.AsInteger := Value;
end;

procedure TCdAccount.SetDtaSld(const Value: TDate);
begin
  eDta_Sld.Text := '  /  /    ';
  if Value > 0 then
    eDta_Sld.Text := DateToStr(Value);
end;

procedure TCdAccount.SetNumCrt(const Value: string);
begin
  eNum_Crt.Text := Value;
end;

procedure TCdAccount.SetNumCta(const Value: string);
begin
  eNum_Cta.Text := Value;
end;

procedure TCdAccount.SetNumIniTl(const Value: Integer);
begin
  eNum_IniTl.AsInteger := Value;
end;

procedure TCdAccount.SetNumRem(const Value: Integer);
begin
  eNum_Rem.AsInteger := Value;
end;

procedure TCdAccount.SetPagNum(const Value: Integer);
begin
  ePag_Num.AsInteger := Value;
end;

procedure TCdAccount.SetPkAccount(const Value: Integer);
begin
  ePk_Contas.AsInteger := Value;
end;

procedure TCdAccount.SetSldCta(const Value: Double);
begin
  eSld_Cta.Value := Value;
end;

procedure TCdAccount.SetSldIni(const Value: Double);
begin
  eSld_Ini.Value := Value;
end;

procedure TCdAccount.SetSldPrev(const Value: Double);
begin
  eSld_Prev.Value := Value;
end;

procedure TCdAccount.SetSldPrvst(const Value: Double);
begin
  eSld_Prvst.Value := Value;
end;

procedure TCdAccount.SetSldReal(const Value: Double);
begin
  eSld_Real.Value := Value;
end;

procedure TCdAccount.SetFkTypeAccount(const Value: Integer);
begin
  FFkTypeAccount := Value;
  if (Pk > 0) then
    MoveDataToControls;
end;

end.
