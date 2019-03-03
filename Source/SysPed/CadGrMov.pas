unit CadGrMov;

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
  Dialogs, StdCtrls, ExtCtrls, ProcUtils, TSysPedAux, CadModel;

type
  TCdGruposMovim = class(TfrmModel)
    lFlag_Cod: TRadioGroup;
    lFlag_Estq: TCheckBox;
    lFlag_Dspa: TCheckBox;
    lFlag_GFin: TCheckBox;
    lFlag_Grnt: TRadioGroup;
    lFlag_Dev: TCheckBox;
    lFlag_Orgm: TRadioGroup;
    lFlag_Dsti: TRadioGroup;
    eDsc_GMov: TEdit;
    lDsc_GMov: TStaticText;
    lPk_Grupos_Movimentos: TStaticText;
    ePk_Grupos_Movimentos: TEdit;
    lFlag_ES: TRadioGroup;
    pTitle: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function GetDscGmov: string;
    function GetFlagCod: TCodeType;
    function GetFlagDev: Boolean;
    function GetFlagDspa: Boolean;
    function GetFlagDsti: TOrigimDestination;
    function GetFlagES: TInOut;
    function GetFlagEstq: Boolean;
    function GetFlagGFin: Boolean;
    function GetFlagOrgm: TOrigimDestination;
    function GetPkGroupMovim: Integer;
    procedure SetDscGmov(const Value: string);
    procedure SetFlagCod(const Value: TCodeType);
    procedure SetFlagDev(const Value: Boolean);
    procedure SetFlagDspa(const Value: Boolean);
    procedure SetFlagDsti(const Value: TOrigimDestination);
    procedure SetFlagES(const Value: TInOut);
    procedure SetFlagEstq(const Value: Boolean);
    procedure SetFlagGFin(const Value: Boolean);
    procedure SetFlagOrgm(const Value: TOrigimDestination);
    procedure SetPkGroupMovim(const Value: Integer);
    function GetFlagGrnt: TTypeGuarantee;
    procedure SetFlagGrnt(const Value: TTypeGuarantee);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property PkGroupMovim: Integer            read GetPkGroupMovim write SetPkGroupMovim;
    property DscGmov     : string             read GetDscGmov      write SetDscGmov;
    property FlagES      : TInOut             read GetFlagES       write SetFlagES;
    property FlagGFin    : Boolean            read GetFlagGFin     write SetFlagGFin;
    property FlagDspa    : Boolean            read GetFlagDspa     write SetFlagDspa;
    property FlagOrgm    : TOrigimDestination read GetFlagOrgm     write SetFlagOrgm;
    property FlagDsti    : TOrigimDestination read GetFlagDsti     write SetFlagDsti;
    property FlagDev     : Boolean            read GetFlagDev      write SetFlagDev;
    property FlagGrnt    : TTypeGuarantee     read GetFlagGrnt     write SetFlagGrnt;
    property FlagEstq    : Boolean            read GetFlagEstq     write SetFlagEstq;
    property FlagCod     : TCodeType          read GetFlagCod      write SetFlagCod;
  end;

implementation

uses Dado, mSysPed, GridRow, DB;

{$R *.dfm}

{ TCdGruposMovim }

function TCdGruposMovim.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscGMov = '') then
  begin
    Dados.DisplayHint(eDsc_GMov, 'Campo descrição deve conter um valor');
    Result := False;
  end;
end;

procedure TCdGruposMovim.ClearControls;
begin
  Loading := True;
  try
    PkGroupMovim := 0;
    DscGmov      := '';
    FlagES       := ioOut;
    FlagGFin     := True;
    FlagDspa     := False;
    FlagOrgm     := odStock;
    FlagDsti     := odCustomer;
    FlagDev      := False;
    FlagGrnt     := tgNone;
    FlagEstq     := False;
    FlagCod      := ctReference;
  finally
    Loading := False;
  end;
end;

function TCdGruposMovim.GetDscGmov: string;
begin
  Result := eDsc_GMov.Text;
end;

function TCdGruposMovim.GetFlagCod: TCodeType;
begin
  Result := TCodeType(lFlag_Cod.ItemIndex);
end;

function TCdGruposMovim.GetFlagDev: Boolean;
begin
  Result := lFLag_Dev.Checked;
end;

function TCdGruposMovim.GetFlagDspa: Boolean;
begin
  Result := lFlag_Dspa.Checked;
end;

function TCdGruposMovim.GetFlagDsti: TOrigimDestination;
begin
  Result := TOrigimDestination(lFlag_Dsti.ItemIndex);
end;

function TCdGruposMovim.GetFlagES: TInOut;
begin
  Result := TInOut(lFLag_ES.ItemIndex);
end;

function TCdGruposMovim.GetFlagEstq: Boolean;
begin
  Result := (lFlag_Estq.Checked);
end;

function TCdGruposMovim.GetFlagGFin: Boolean;
begin
  Result := lFlag_GFin.Checked;
end;

function TCdGruposMovim.GetFlagGrnt: TTypeGuarantee;
begin
  Result := TTypeGuarantee(lFlag_Grnt.ItemIndex);
end;

function TCdGruposMovim.GetFlagOrgm: TOrigimDestination;
begin
  Result := TOrigimDestination(lFlag_Orgm.ItemIndex);
end;

function TCdGruposMovim.GetPkGroupMovim: Integer;
begin
  Result := StrToIntDef(ePk_Grupos_Movimentos.Text, 0);
end;

procedure TCdGruposMovim.LoadDefaults;
begin
  pTitle.Caption := 'Grupos de Movimentos';
end;

procedure TCdGruposMovim.MoveDataToControls;
var
  aItem: TMovement;
begin
  Loading := True;
  try
    aItem        := dmSysPed.GroupMoviment[Pk];
    PkGroupMovim := aItem.PkGroupMovement;
    DscGmov      := aItem.DscMov;
    FlagES       := aItem.FlagES;
    FlagGFin     := aItem.FlagGFin;
    FlagDspa     := aItem.FlagDspa;
    FlagOrgm     := aItem.FlagOrgm;
    FlagDsti     := aItem.FlagDsti;
    FlagDev      := aItem.FlagDev;
    FlagGrnt     := aItem.FlagGrnt;
    FlagEstq     := aItem.FlagEstq;
    FlagCod      := aItem.FlagCod;
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
end;

procedure TCdGruposMovim.SaveIntoDB;
var
  aItem: TMovement;
  aRow : TDataRow;
begin
  aItem                   := TMovement.Create;
  aRow                    := TDataRow.Create(nil);
  try
    aItem.PkGroupMovement := PkGroupMovim;
    aItem.DscMov          := DscGmov;
    aItem.FlagES          := FlagES;
    aItem.FlagGFin        := FlagGFin;
    aItem.FlagDspa        := FlagDspa;
    aItem.FlagOrgm        := FlagOrgm;
    aItem.FlagDsti        := FlagDsti;
    aItem.FlagDev         := FlagDev;
    aItem.FlagGrnt        := FlagGrnt;
    aItem.FlagEstq        := FlagEstq;
    aItem.FlagCod         := FlagCod;
    dmSysPed.GroupMoviment[Ord(ScrState)] := aItem;
    aRow.AddAs('PK', aItem.PkGroupMovement, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', DscGmov, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := aItem.PkGroupMovement;
  finally
    FreeAndNil(aItem);
    FreeAndNil(aRow);
  end;
end;

procedure TCdGruposMovim.SetDscGmov(const Value: string);
begin
  eDsc_GMov.Text := Value;
end;

procedure TCdGruposMovim.SetFlagCod(const Value: TCodeType);
begin
  lFlag_Cod.ItemIndex := Ord(Value);
end;

procedure TCdGruposMovim.SetFlagDev(const Value: Boolean);
begin
  lFlag_Dev.Checked := Value;
end;

procedure TCdGruposMovim.SetFlagDspa(const Value: Boolean);
begin
  lFlag_Dspa.Checked := Value;
end;

procedure TCdGruposMovim.SetFlagDsti(const Value: TOrigimDestination);
begin
  lFlag_Dsti.ItemIndex := Ord(Value);
end;

procedure TCdGruposMovim.SetFlagES(const Value: TInOut);
begin
  lFlag_ES.ItemIndex := Ord(Value);
end;

procedure TCdGruposMovim.SetFlagEstq(const Value: Boolean);
begin
  lFlag_Estq.Checked := Value;
end;

procedure TCdGruposMovim.SetFlagGFin(const Value: Boolean);
begin
  lFlag_GFin.Checked := Value;
end;

procedure TCdGruposMovim.SetFlagGrnt(const Value: TTypeGuarantee);
begin
  lFlag_Grnt.ItemIndex := Ord(Value);
end;

procedure TCdGruposMovim.SetFlagOrgm(const Value: TOrigimDestination);
begin
  lFlag_Orgm.ItemIndex := Ord(Value);
end;

procedure TCdGruposMovim.SetPkGroupMovim(const Value: Integer);
begin
  ePk_Grupos_Movimentos.Text := IntToStr(Value);
end;

procedure TCdGruposMovim.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

end.
