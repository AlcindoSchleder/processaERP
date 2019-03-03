unit CadTMov;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 18/04/2006 - DD/MM/YYYY                                      *}
{* Modified:                                                             *}
{* Version: 2.0.0.0                                                      *}
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
  Dialogs, StdCtrls, ProcUtils, ExtCtrls, TSysPedAux, CadModel;

type
  TCdTypeMovim = class(TfrmModel)
    pTitle: TPanel;
    lFlag_Exp: TCheckBox;
    lFlag_Ldv: TCheckBox;
    eNat_Ope_Ex: TComboBox;
    lNat_Ope_Ex: TStaticText;
    lNat_Ope_Fe: TStaticText;
    eNat_Ope_Fe: TComboBox;
    eNat_Ope_De: TComboBox;
    lNat_Ope_De: TStaticText;
    eDsc_TMov: TEdit;
    lDsc_TMov: TStaticText;
    ePk_Tipo_Movimentos: TEdit;
    lPk_Tipo_Movimentos: TStaticText;
    lFlag_Cns: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure eFk_ClassificacaoDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    FFkGroupMovim: Integer;
    FDscGmov     : string;
    FFlagES      : TInOut;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscTMov: string;
    function  GetFlagCns: Boolean;
    function  GetFlagExp: Boolean;
    function  GetFlagLdv: Boolean;
    function  GetNatOpeDE: string;
    function  GetNatOpeEX: string;
    function  GetNatOpeFE: string;
    function  GetPkTypeMovim: Integer;
    procedure SetDscGmov(const Value: string);
    procedure SetDscTMov(const Value: string);
    procedure SetFkGroupMovim(const Value: Integer);
    procedure SetFlagCns(const Value: Boolean);
    procedure SetFlagExp(const Value: Boolean);
    procedure SetFlagLdv(const Value: Boolean);
    procedure SetNatOpeDE(const Value: string);
    procedure SetNatOpeEX(const Value: string);
    procedure SetNatOpeFE(const Value: string);
    procedure SetPkTypeMovim(const Value: Integer);
    procedure SetFlagES(const Value: TInOut);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property FkGroupMovim: Integer read FFkGroupMovim  write SetFkGroupMovim;
    property PkTypeMovim : Integer read GetPkTypeMovim write SetPkTypeMovim;
    property DscTMov     : string  read GetDscTMov     write SetDscTMov;
    property NatOpeDE    : string  read GetNatOpeDE    write SetNatOpeDE;
    property NatOpeFE    : string  read GetNatOpeFE    write SetNatOpeFE;
    property NatOpeEX    : string  read GetNatOpeEX    write SetNatOpeEX;
    property FlagLdv     : Boolean read GetFlagLdv     write SetFlagLdv;
    property FlagExp     : Boolean read GetFlagExp     write SetFlagExp;
    property FlagCns     : Boolean read GetFlagCns     write SetFlagCns;
    property DscGmov     : string  read FDscGmov       write SetDscGmov;
    property FlagES      : TInOut  read FFlagES        write SetFlagES;
  end;

implementation

uses Dado, mSysPed, TSysFatAux, Funcoes, GridRow, DB;

{$R *.dfm}

{ TCdTypeMovim }

function TCdTypeMovim.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C: TControl;
  S: string;
begin
  Result := True;
  C := nil;
  S := '';
  if (DscTMov = '') then
  begin
    C := eDsc_TMov;
    S := 'Campo Descrição deve conter um valor';
  end;
  if (NatOpeDE = '') then
  begin
    C := eNat_Ope_De;
    S := 'Campo Natureza da operação dentro do estado deve conter um valor';
  end;
  if (NatOpeFE = '') then
  begin
    C := eNat_Ope_Fe;
    S := 'Campo Natureza da operação fora do estado deve conter um valor';
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTypeMovim.ClearControls;
begin
  Loading := True;
  try
    PkTypeMovim := 0;
    DscTMov     := '';
    NatOpeDE    := '';
    NatOpeFE    := '';
    NatOpeEX    := '';
    FlagLdv     := False;
    FlagExp     := False;
    FlagCns     := False;
  finally
    Loading := False;
  end;
end;

function TCdTypeMovim.GetDscTMov: string;
begin
  Result := eDsc_TMov.Text;
end;

function TCdTypeMovim.GetFlagCns: Boolean;
begin
  Result := lFlag_Cns.Checked;
end;

function TCdTypeMovim.GetFlagExp: Boolean;
begin
  Result := lFlag_Exp.Checked;
end;

function TCdTypeMovim.GetFlagLdv: Boolean;
begin
  Result := lFlag_Ldv.Checked;
end;

function TCdTypeMovim.GetNatOpeDE: string;
begin
  with eNat_Ope_De do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := StrPas(PChar(Items.Objects[ItemIndex]));
end;

function TCdTypeMovim.GetNatOpeEX: string;
begin
  with eNat_Ope_Ex do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := StrPas(PChar(Items.Objects[ItemIndex]));
end;

function TCdTypeMovim.GetNatOpeFE: string;
begin
  with eNat_Ope_Fe do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := StrPas(PChar(Items.Objects[ItemIndex]));
end;

function TCdTypeMovim.GetPkTypeMovim: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Movimentos.Text, 0);
end;

procedure TCdTypeMovim.LoadDefaults;
begin
  pTitle.Caption := 'Tipo de Movimentos';
  if (DscGMov <> '') then
    pTitle.Caption := pTitle.Caption + ' - ' + DscGMov;
  if (not ListLoaded) then
  begin
    eNat_Ope_De.Items.AddStrings(dmSysPed.LoadNatureOperation(FFlagES, onDe));
    eNat_Ope_Fe.Items.AddStrings(dmSysPed.LoadNatureOperation(FFlagES, onFe));
    eNat_Ope_Ex.Items.AddStrings(dmSysPed.LoadNatureOperation(FFlagES, onEx));
    ListLoaded := True;
  end;
end;

procedure TCdTypeMovim.MoveDataToControls;
var
  aItem: TMovement;
begin
  Loading := True;
  try
    aItem       := dmSysPed.TypeMoviment[Pk];
    PkTypeMovim := aItem.PkTypeMovement;
    DscTMov     := aItem.DscMov;
    NatOpeDE    := aItem.NatOpeDe;
    NatOpeFE    := aItem.NatOpeFe;
    NatOpeEX    := aItem.NatOpeEx;
    FlagLdv     := aItem.FlagLdv;
    FlagExp     := aItem.FlagExp;
    FlagCns     := aItem.FlagCns;
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
end;

procedure TCdTypeMovim.SaveIntoDB;
var
  aItem: TMovement;
  aRow : TDataRow;
begin
  aItem                   := TMovement.Create;
  aRow                    := TDataRow.Create(nil);
  try
    aItem.PkGroupMovement := FkGroupMovim;
    aItem.PkTypeMovement  := PkTypeMovim;
    aItem.DscMov          := DscTMov;
    aItem.NatOpeDe        := NatOpeDE;
    aItem.NatOpeFe        := NatOpeFE;
    aItem.NatOpeEx        := NatOpeEX;
    aItem.FlagLdv         := FlagLdv;
    aItem.FlagExp         := FlagExp;
    aItem.FlagCns         := FlagCns;
    dmSysPed.TypeMoviment[Ord(ScrState)] := aItem;
    aRow.AddAs('PK', aItem.PkTypeMovement, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', aItem.DscMov, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := aItem.PkTypeMovement;
  finally
    FreeAndNil(aItem);
    FreeAndNil(aRow);
  end;
end;

procedure TCdTypeMovim.SetDscGmov(const Value: string);
begin
  FDscGmov := Value;
  pTitle.Caption := 'Tipo de Movimentos';
  if (FDscGmov <> '') then
    pTitle.Caption := pTitle.Caption + ' - ' + DscGMov;
end;

procedure TCdTypeMovim.SetDscTMov(const Value: string);
begin
  eDsc_TMov.Text := Value;
end;

procedure TCdTypeMovim.SetFkGroupMovim(const Value: Integer);
begin
  FFkGroupMovim := Value;
  dmSysPed.PkGroupMoviment := Value;
end;

procedure TCdTypeMovim.SetFlagCns(const Value: Boolean);
begin
  lFLag_Cns.Checked := Value;
end;

procedure TCdTypeMovim.SetFlagExp(const Value: Boolean);
begin
  lFlag_Exp.Checked := Value;
end;

procedure TCdTypeMovim.SetFlagLdv(const Value: Boolean);
begin
  lFlag_Ldv.Checked := Value;
end;

procedure TCdTypeMovim.SetNatOpeDE(const Value: string);
var
  i: Integer;
begin
  with eNat_Ope_De do
  begin
    ItemIndex := -1;
    if (Value <> '') then
      for i := 0 to Items.Count - 1 do
        if (Items.Objects[i] <> nil) and
           (StrComp(PAnsiChar(Items.Objects[i]), PAnsiChar(Value)) = 0) then
          ItemIndex := i;
  end;
end;

procedure TCdTypeMovim.SetNatOpeEX(const Value: string);
var
  i: Integer;
begin
  with eNat_Ope_Ex do
  begin
    ItemIndex := -1;
    if (Value <> '') then
      for i := 0 to Items.Count - 1 do
        if (Items.Objects[i] <> nil) and
           (StrComp(PAnsiChar(Items.Objects[i]), PAnsiChar(Value)) = 0) then
          ItemIndex := i;
  end;
end;

procedure TCdTypeMovim.SetNatOpeFE(const Value: string);
var
  i: Integer;
begin
  with eNat_Ope_Fe do
  begin
    ItemIndex := -1;
    if (Value <> '') then
      for i := 0 to Items.Count - 1 do
        if (Items.Objects[i] <> nil) and
           (StrComp(PAnsiChar(Items.Objects[i]), PAnsiChar(Value)) = 0) then
          ItemIndex := i;
  end;
end;

procedure TCdTypeMovim.SetPkTypeMovim(const Value: Integer);
begin
  ePk_Tipo_Movimentos.Text := IntToStr(Value);
end;

procedure TCdTypeMovim.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

procedure TCdTypeMovim.eFk_ClassificacaoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aClass : TClassification;
  aColor : TColor;
  aOffSet: Integer;
  aStr   ,
  aItmStr: string;
begin
  if (Index > TComboBox(Control).Items.Count) or
     (TComboBox(Control).Items.Objects[Index] = nil) or
     (not (TComboBox(Control).Items.Objects[Index] is TClassification)) then
  begin
    TComboBox(Control).Canvas.TextOut(Rect.Left, Rect.Top,
      TComboBox(Control).Items.Strings[Index]);
    exit;
  end;
  aClass  := TClassification(TComboBox(Control).Items.Objects[Index]);
  aColor  := clGray;
  aOffSet := aClass.NivCta * 10;
  if aClass.FlagAnlSnt then
    aColor  := clWindowText;
  with (Control as TComboBox).Canvas do
  begin
    if (odSelected in State) then
      Font.Color := clWhite
    else
      Font.Color := aColor;
    aStr       := TComboBox(Control).Items.Strings[Index];
    aItmStr    := Copy(aStr, 1, Pos('|', aStr) - 1);
    Delete(aStr, 1, Pos('|', aStr));
    TextOut(Rect.Left + aOffSet, Rect.Top, aItmStr);
    TextOut(Rect.Left + 300, Rect.Top, aStr);
  end;
end;

procedure TCdTypeMovim.SetFlagES(const Value: TInOut);
begin
  if (FFlagES <> Value) then
  begin
    FFlagEs := Value;
    ReleaseCombos(eNat_Ope_De, toString);
    ReleaseCombos(eNat_Ope_Fe, toString);
    ReleaseCombos(eNat_Ope_Ex, toString);
    ListLoaded := False;
    LoadDefaults;
  end;
end;

end.
