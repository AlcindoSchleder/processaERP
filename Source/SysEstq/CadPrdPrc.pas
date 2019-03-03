unit CadPrdPrc;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/03/2006                                                   *}
{* Modified:                                                             *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadModel, StdCtrls, Mask, ToolEdit, CurrEdit, TSysEstq,
  TSysEstqAux;

type
  TfmProductSale = class(TfrmModel)
    lFk_Linhas: TStaticText;
    eFk_Linhas: TComboBox;
    lFk_Similar: TStaticText;
    eFk_Similar: TComboBox;
    lFat_Conv_Cub: TStaticText;
    eFat_Conv_Cub: TCurrencyEdit;
    lFlag_Imp: TCheckBox;
    eDsc_Red: TEdit;
    lDsc_Prod: TStaticText;
    lPes_Liq: TStaticText;
    ePes_Liq: TCurrencyEdit;
    lPes_Bru: TStaticText;
    ePes_Bru: TCurrencyEdit;
    lVlr_Cub: TStaticText;
    eVlr_Cub: TCurrencyEdit;
    gbBrutMetric: TGroupBox;
    lAlt_Prod: TStaticText;
    eAlt_Prod: TCurrencyEdit;
    lProf_Prod: TStaticText;
    eProf_Prod: TCurrencyEdit;
    lLarg_Prod: TStaticText;
    eLarg_Prod: TCurrencyEdit;
    gbPackMetric: TGroupBox;
    lAlt_EProd: TStaticText;
    eAlt_EProd: TCurrencyEdit;
    lProf_EProd: TStaticText;
    eProf_EProd: TCurrencyEdit;
    lLarg_EProd: TStaticText;
    eLarg_EProd: TCurrencyEdit;
    gbInternalMetric: TGroupBox;
    lAlt_IProd: TStaticText;
    eAlt_IProd: TCurrencyEdit;
    lProf_IProd: TStaticText;
    eProf_IProd: TCurrencyEdit;
    lLarg_IProd: TStaticText;
    eLarg_IProd: TCurrencyEdit;
  private
    function GetAltEProd: Double;
    function GetAltIProd: Double;
    function GetAltProd: Double;
    function GetDscRed: string;
    function GetFatConvCub: Double;
    function GetFkLinhas: Integer;
    function GetFkSimilar: Integer;
    function GetLargIProd: Double;
    function GetLargProd: Double;
    function GetPesBru: Double;
    function GetPesLiq: Double;
    function GetProfEProd: Double;
    function GetProfIProd: Double;
    function GetProfProd: Double;
    function GetVlrCub: Double;
    procedure LoadLines;
    procedure LoadSimilar;
    procedure SetAltEProd(const Value: Double);
    procedure SetAltIProd(const Value: Double);
    procedure SetAltProd(const Value: Double);
    procedure SetDscRed(const Value: string);
    procedure SetFatConvCub(const Value: Double);
    procedure SetFkLinhas(const Value: Integer);
    procedure SetFkSimilar(const Value: Integer);
    procedure SetLargIProd(const Value: Double);
    procedure SetLargProd(const Value: Double);
    procedure SetPesBru(const Value: Double);
    procedure SetPesLiq(const Value: Double);
    procedure SetProfEProd(const Value: Double);
    procedure SetProfIProd(const Value: Double);
    procedure SetProfProd(const Value: Double);
    procedure SetVlrCub(const Value: Double);
    function GetLargEProd: Double;
    procedure SetLargEProd(const Value: Double);
    function GetFlagImp: Boolean;
    procedure SetFlagImp(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property AltProd   : Double  read GetAltProd    write SetAltProd;
    property AltEProd  : Double  read GetAltEProd   write SetAltEProd;
    property AltIProd  : Double  read GetAltIProd   write SetAltIProd;
    property DscRed    : string  read GetDscRed     write SetDscRed;
    property FlagImp   : Boolean read GetFlagImp    write SetFlagImp;
    property FkLinhas  : Integer read GetFkLinhas   write SetFkLinhas;
    property FkSimilar : Integer read GetFkSimilar  write SetFkSimilar;
    property FatConvCub: Double  read GetFatConvCub write SetFatConvCub;
    property LargProd  : Double  read GetLargProd   write SetLargProd;
    property LargIProd : Double  read GetLargIProd  write SetLargIProd;
    property LargEProd : Double  read GetLargEProd  write SetLargEProd;
    property PesLiq    : Double  read GetPesLiq     write SetPesLiq;
    property PesBru    : Double  read GetPesBru     write SetPesBru;
    property ProfEProd : Double  read GetProfEProd  write SetProfEProd;
    property ProfProd  : Double  read GetProfProd   write SetProfProd;
    property ProfIProd : Double  read GetProfIProd  write SetProfIProd;
    property VlrCub    : Double  read GetVlrCub     write SetVlrCub;
  end;

var
  fmProductSale: TfmProductSale;

implementation

uses mSysEstq, Funcoes, ProcUtils;

{$R *.dfm}

{ TfmProductSale }

procedure TfmProductSale.ClearControls;
begin
  Loading := True;
  try
    DscRed      := '';
    FlagImp     := True;
    FatConvCub  := 0.0;
    VlrCub      := 0.0;
    PesBru      := 0.0;
    PesLiq      := 0.0;
    AltProd     := 0.0;
    ProfProd    := 0.0;
    LargProd    := 0.0;
    AltEProd    := 0.0;
    ProfEProd   := 0.0;
    LargEProd   := 0.0;
    AltIProd    := 0.0;
    ProfIProd   := 0.0;
    LargIProd   := 0.0;
    FkLinhas    := 0;
    FkSimilar   := 0;
  finally
    Loading := False;
  end;
end;

function TfmProductSale.GetAltEProd: Double;
begin
  Result := eAlt_EProd.Value;
end;

function TfmProductSale.GetAltIProd: Double;
begin
  Result := eAlt_IProd.Value;
end;

function TfmProductSale.GetAltProd: Double;
begin
  Result := eAlt_Prod.Value;
end;

function TfmProductSale.GetDscRed: string;
begin
  Result := eDsc_Red.Text;
end;

function TfmProductSale.GetFatConvCub: Double;
begin
  Result := eFat_Conv_Cub.Value;
end;

function TfmProductSale.GetFkLinhas: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  with eFk_Linhas do
  begin
    aIdx := ItemIndex;
    if (aIdx > -1) and (Items.Objects[aIdx] <> nil) then
      Result := TLines(Items.Objects[aIdx]).PkLines;
  end;
end;

function TfmProductSale.GetFkSimilar: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  with eFk_Similar do
  begin
    aIdx := ItemIndex;
    if (aIdx > -1) and (Items.Objects[aIdx] <> nil) then
      Result := TSimilar(Items.Objects[aIdx]).PkSimilar;
  end;
end;

function TfmProductSale.GetFlagImp: Boolean;
begin
  Result := lFlag_Imp.Checked;
end;

function TfmProductSale.GetLargEProd: Double;
begin
  Result := eLarg_EProd.Value;
end;

function TfmProductSale.GetLargIProd: Double;
begin
  Result := eLarg_IProd.Value;
end;

function TfmProductSale.GetLargProd: Double;
begin
  Result := eLarg_Prod.Value;
end;

function TfmProductSale.GetPesBru: Double;
begin
  Result := ePes_Bru.Value;
end;

function TfmProductSale.GetPesLiq: Double;
begin
  Result := ePes_Liq.Value;
end;

function TfmProductSale.GetProfEProd: Double;
begin
  Result := eProf_EProd.Value;
end;

function TfmProductSale.GetProfIProd: Double;
begin
  Result := eProf_IProd.Value;
end;

function TfmProductSale.GetProfProd: Double;
begin
  Result := eProf_Prod.Value;
end;

function TfmProductSale.GetVlrCub: Double;
begin
  Result := eVlr_Cub.Value;
end;

procedure TfmProductSale.LoadDefaults;
begin
  if not ListLoaded then
  begin
    LoadLines;
    LoadSimilar;
    ListLoaded := True;
  end;
end;

procedure TfmProductSale.LoadLines;
begin
  ReleaseCombos(eFk_Linhas, toObject);
  eFk_Linhas.Items.AddStrings(dmSysEstq.LoadLinhas);
end;

procedure TfmProductSale.LoadSimilar;
begin
  ReleaseCombos(eFk_Similar, toObject);
  eFk_Similar.Items.AddStrings(dmSysEstq.LoadSimilar);
end;

procedure TfmProductSale.MoveDataToControls;
var
  aPrd: TProductSale;
begin
  Loading := True;
  aPrd := dmSysEstq.GetProductSale(Pk);
  try
    DscRed      := aPrd.DscRed;
    FlagImp     := aPrd.FlagImp;
    FatConvCub  := aPrd.FatConvCub;
    VlrCub      := aPrd.VlrCub;
    PesBru      := aPrd.PesBru;
    PesLiq      := aPrd.PesLiq;
    AltProd     := aPrd.AltProd;
    ProfProd    := aPrd.ProfProd;
    LargProd    := aPrd.LargProd;
    AltEProd    := aPrd.EmbAltProd;
    ProfEProd   := aPrd.EmbProfProd;
    LargEProd   := aPrd.EmbLargProd;
    AltIProd    := aPrd.IntAltProd;
    ProfIProd   := aPrd.IntProfProd;
    LargIProd   := aPrd.IntLargProd;
    FkLinhas    := aPrd.FkLines.PkLines;
    FkSimilar   := aPrd.FkSimilar.PkSimilar;
  finally
    FreeAndNil(aPrd);
    Loading := False;
  end;
end;

procedure TfmProductSale.SaveIntoDB;
var
  aPrd: TProductSale;
begin
  aPrd := TProductSale.Create(nil);
  try
    aPrd.DscRed              := DscRed;
    aPrd.FlagImp             := FlagImp;
    aPrd.PesBru              := PesBru;
    aPrd.PesLiq              := PesLiq;
    aPrd.AltProd             := AltProd;
    aPrd.ProfProd            := ProfProd;
    aPrd.LargProd            := LargProd;
    aPrd.EmbAltProd          := AltEProd;
    aPrd.EmbProfProd         := ProfEProd;
    aPrd.EmbLargProd         := LargEProd;
    aPrd.IntAltProd          := AltIProd;
    aPrd.IntProfProd         := ProfIProd;
    aPrd.IntLargProd         := LargIProd;
    aPrd.FatConvCub          := FatConvCub;
    aPrd.FkLines.PkLines     := FkLinhas;
    aPrd.FkSimilar.PkSimilar := FkSimilar;
    dmSysEstq.UpdateProductSale(Pk, aPrd, ScrState);
  finally
    FreeAndNil(aPrd);
  end;
end;

procedure TfmProductSale.SetAltEProd(const Value: Double);
begin
  eAlt_EProd.Value := Value;
end;

procedure TfmProductSale.SetAltIProd(const Value: Double);
begin
  eAlt_IProd.Value := Value;
end;

procedure TfmProductSale.SetAltProd(const Value: Double);
begin
  eAlt_Prod.Value := Value;
end;

procedure TfmProductSale.SetDscRed(const Value: string);
begin
  eDsc_Red.Text := Value;
end;

procedure TfmProductSale.SetFatConvCub(const Value: Double);
begin
  eFat_Conv_Cub.Value := Value;
end;

procedure TfmProductSale.SetFkLinhas(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Linhas do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (TLines(Items.Objects[i]).PkLines = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TfmProductSale.SetFkSimilar(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Similar do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (TSimilar(Items.Objects[i]).PkSimilar = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TfmProductSale.SetFlagImp(const Value: Boolean);
begin
  lFlag_Imp.Checked := Value;
end;

procedure TfmProductSale.SetLargEProd(const Value: Double);
begin
  eLarg_EProd.Value := Value;
end;

procedure TfmProductSale.SetLargIProd(const Value: Double);
begin
  eLarg_IProd.Value := Value;
end;

procedure TfmProductSale.SetLargProd(const Value: Double);
begin
  eLarg_Prod.Value := Value;
end;

procedure TfmProductSale.SetPesBru(const Value: Double);
begin
  ePes_Bru.Value := Value;
end;

procedure TfmProductSale.SetPesLiq(const Value: Double);
begin
  ePes_Liq.Value := Value;
end;

procedure TfmProductSale.SetProfEProd(const Value: Double);
begin
  eProf_EProd.Value := Value;
end;

procedure TfmProductSale.SetProfIProd(const Value: Double);
begin
  eProf_IProd.Value := Value;
end;

procedure TfmProductSale.SetProfProd(const Value: Double);
begin
  eProf_Prod.Value := Value;
end;

procedure TfmProductSale.SetVlrCub(const Value: Double);
begin
  eVlr_Cub.Value := Value;
end;

end.
