unit CadUf;

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
  Dialogs, CadModel, StdCtrls, ExtCtrls, ProcUtils, TSysCadAux, Buttons;

type
  TCdEstados = class(TfrmModel)
    lPk_Estados: TStaticText;
    ePk_Estados: TEdit;
    lDsc_Uf: TStaticText;
    eDsc_Uf: TEdit;
    shTitle: TShape;
    lTitle: TLabel;
    lFk_Cargas_Regioes: TStaticText;
    eFk_Cargas_Regioes: TComboBox;
    sbNewRegion: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure sbNewRegionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FFkCountry: Integer;
    FPkState  : string;
    FState    : TState;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscState: string;
    function  GetFkRegions: Integer;
    function  GetPkStates: string;
    procedure SetDscState(const Value: string);
    procedure SetFkRegions(const Value: Integer);
    procedure SetPkState(const Value: string);
    procedure ReleaseRegions;
    procedure SetPkStates(const Value: string);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkStates : string  read GetPkStates      write SetPkStates;
    property  FkRegions: Integer read GetFkRegions     write SetFkRegions;
  public
    { Public declarations }
    property  FkCountry: Integer read FFkCountry       write FFkCountry;
    property  DscState : string  read GetDscState      write SetDscState;
    property  PkState  : string                        write SetPkState;
  end;

var
  CdEstados: TCdEstados;

implementation

uses Dado, mSysCad, GridRow, DB, CadReg;

{$R *.dfm}

function TCdEstados.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C: TControl;
  S: string;
begin
  Result := True;
  C := nil;
  S := '';
  if (DscState = '') then
  begin
    C := eDsc_UF;
    S := 'Campo descrição deve ser preenchido';
  end;
  if (PkStates = '') then
  begin
    C := ePk_Estados;
    S := 'Campo Código da UF deve ser preenchido';
  end;
  if (FkRegions = 0) then
  begin
    C := eFk_Cargas_Regioes;
    S := 'Campo Regiões deve ser preenchido';
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdEstados.ClearControls;
begin
  Loading := True;
  try
    PkStates  := '';
    DscState  := '';
    FkRegions := 0;
  finally
    Loading := False;
  end;
end;

procedure TCdEstados.FormCreate(Sender: TObject);
begin
  FState := TState.Create;
  inherited;
  OnCheckRecord := CheckRecord;
end;

function TCdEstados.GetDscState: string;
begin
  Result := eDsc_Uf.Text;
end;

function TCdEstados.GetFkRegions: Integer;
begin
  Result := 0;
  with eFk_Cargas_Regioes do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

procedure TCdEstados.LoadDefaults;
begin
  if (not ListLoaded) then
    eFk_Cargas_Regioes.Items.AddStrings(dmSysCad.LoadRegions(True));
end;

procedure TCdEstados.MoveDataToControls;
var
  Data: TState;
begin
  Loading := True;
  try
    Data      := dmSysCad.State[Pk];
    PkStates  := Data.PkState;
    DscState  := Data.DscUF;
    FkRegions := Data.FkRegions;
  finally
    FreeAndNil(Data);
    Loading := False;
  end;
end;

procedure TCdEstados.SaveIntoDB;
var
  Data: TState;
  aRow: TDataRow;
begin
  Data := TState.Create;
  aRow := TDataRow.Create(nil);
  try
    Data.FkCountry.PKCountry      := FFkCountry;
    Data.PkState                  := PkStates;
    Data.DscUF                    := DscState;
    Data.FkRegions                := FkRegions;
    dmSysCad.State[Ord(ScrState)] := Data;
    aRow.AddAs('PK', Data.PkState, ftString, 3);
    aRow.AddAs('DSC', Data.DscUF, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    PkState := Data.PkState;
  finally
    FreeAndNil(aRow);
    FreeAndNil(Data);
  end;
end;

procedure TCdEstados.SetDscState(const Value: string);
begin
  eDsc_Uf.Text := Value;
end;

procedure TCdEstados.SetFkRegions(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Cargas_Regioes do
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

procedure TCdEstados.SetPkState(const Value: string);
begin
  FPkState         := Value;
  if (not Assigned(FState)) then
    FState := TState.Create;
  if (Value = '') then
    FState.Clear
  else
  begin
    FState.FkCountry.PKCountry := FFkCountry;
    FState.PkState             := Value;
  end;
  Pk := LongInt(FState);
end;

procedure TCdEstados.sbNewRegionClick(Sender: TObject);
var
  aForm: TCdRegions;
  aPk  : Integer;
begin
  aForm := TCdRegions.Create(Application);
  try
    aForm.ShowModal;
    aPk := aForm.Pk;
  finally
    FreeAndNil(aForm);
  end;
  ReleaseRegions;
  ListLoaded := False;
  LoadDefaults;
  if (aPk > 0) then
    FkRegions := aPk;
end;

procedure TCdEstados.ReleaseRegions;
begin
  eFk_Cargas_Regioes.Items.Clear;
end;

procedure TCdEstados.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FState);
  ReleaseRegions;
  inherited;
end;

function TCdEstados.GetPkStates: string;
begin
  Result := ePk_Estados.Text;
end;

procedure TCdEstados.SetPkStates(const Value: string);
begin
  ePk_Estados.Text := Value;
end;

end.
