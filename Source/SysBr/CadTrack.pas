unit CadTrack;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2006 by Alcindo Schleder. All rights reserved.           *}
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
  Dialogs, SqrForm, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit;

type
  TTypeDirection = (tdSouth, tdNorth);

  TCdTrack = class(TfrmSquareForms)
    lDsc_Pista: TStaticText;
    eDsc_Pista: TEdit;
    ePk_Pracas_Pistas: TCurrencyEdit;
    lPk_Pracas_Pistas: TStaticText;
    lFlag_Drt: TRadioGroup;
    stTitle: TStaticText;
  private
    { Private declarations }
    function  GetDscPista: string;
    function  GetFlagDrt: TTypeDirection;
    function  GetPkPracasPistas: Integer;
    procedure SetDscPista(const Value: string);
    procedure SetFlagDrt(const Value: TTypeDirection);
    procedure SetPkPracasPistas(const Value: Integer);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveObjectToControls; override;
  public
    { Public declarations }
    procedure SaveIntoDB; override;
    property DataRecord;
    property FkCompany;
    property ListLoaded;
    property PkSquare;
    property ScrMode;
    property PkPracasPistas: Integer        read GetPkPracasPistas write SetPkPracasPistas;
    property DscPista      : string         read GetDscPista       write SetDscPista;
    property FlagDrt       : TTypeDirection read GetFlagDrt        write SetFlagDrt;
  end;

var
  CdTrack: TCdTrack;

implementation

uses mSysBr, ProcUtils;

{$R *.dfm}

{ TCdTrack }

procedure TCdTrack.ClearControls;
begin
  PkPracasPistas := 0;
  DscPista       := '';
  FlagDrt        := tdNorth;
end;

procedure TCdTrack.LoadDefaults;
begin
// nothing to load
  stTitle.Caption := Title;
end;

procedure TCdTrack.MoveObjectToControls;
begin
  PkPracasPistas := DataRecord.FieldByName['PK_PRACAS_PISTAS'].AsInteger;
  DscPista       := DataRecord.FieldByName['DSC_PISTA'].AsString;
  FlagDrt        := TTypeDirection(DataRecord.FieldByName['FLAG_DRT'].AsInteger);
end;

procedure TCdTrack.SaveIntoDB;
begin
  DataRecord.FieldByName['FK_EMPRESAS'].AsInteger      := FkCompany.PkCompany;
  DataRecord.FieldByName['PK_PRACAS'].AsInteger        := PkSquare;
  DataRecord.FieldByName['PK_PRACAS_PISTAS'].AsInteger := PkPracasPistas;
  DataRecord.FieldByName['DSC_PISTA'].AsString         := DscPista;
  DataRecord.FieldByName['FLAG_DRT'].AsInteger         := Ord(FlagDrt);
  dmSysBr.SaveTrack(ScrMode, DataRecord);
  ScrMode := dbmBrowse;
end;

function TCdTrack.GetDscPista: string;
begin
  Result := eDsc_Pista.Text;
end;

function TCdTrack.GetFlagDrt: TTypeDirection;
begin
  Result := TTypeDirection(lFlag_Drt.ItemIndex);
end;

function TCdTrack.GetPkPracasPistas: Integer;
begin
  Result := ePk_Pracas_Pistas.AsInteger;
end;

procedure TCdTrack.SetDscPista(const Value: string);
begin
  eDsc_Pista.Text := Value;
end;

procedure TCdTrack.SetFlagDrt(const Value: TTypeDirection);
begin
  lFlag_Drt.ItemIndex := Ord(Value);
end;

procedure TCdTrack.SetPkPracasPistas(const Value: Integer);
begin
  ePk_Pracas_Pistas.AsInteger := Value;
end;

end.
