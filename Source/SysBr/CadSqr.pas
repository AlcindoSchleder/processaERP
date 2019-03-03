unit CadSqr;

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
  Dialogs, SqrForm, StdCtrls, PrcCombo, Mask, ToolEdit, CurrEdit, TSysSrvAux;

type
  TCdSquare = class(TfrmSquareForms)
    lFk_Rodovias: TStaticText;
    eFk_Rodovias: TPrcComboBox;
    lDsc_Prc: TStaticText;
    eDsc_Prc: TEdit;
    lPos_Trc: TStaticText;
    ePos_Trc: TCurrencyEdit;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function GetDscPrc: string;
    function  GetFkHighWay: TRodovias;
    function  GetPosTrc: Double;
    procedure SetFkHighWay(const Value: TRodovias);
    procedure SetPosTrc(const Value: Double);
    procedure SetPrcDsc(const Value: string);
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
    property FkHighWay: TRodovias read GetFkHighWay write SetFkHighWay;
    property DscPrc   : string    read GetDscPrc    write SetPrcDsc;
    property PosTrc   : Double    read GetPosTrc    write SetPosTrc;
  end;

var
  CdSquare: TCdSquare;

implementation

uses mSysBr, GridRow, ProcUtils;

{$R *.dfm}

procedure TCdSquare.FormDestroy(Sender: TObject);
begin
  eFk_Rodovias.ReleaseObjects;
  inherited;
end;

procedure TCdSquare.ClearControls;
begin
  FkHighWay := nil;
  DscPrc    := '';
  PosTrc    := 0.0;
end;

procedure TCdSquare.LoadDefaults;
begin
  if (not ListLoaded) then
    eFk_Rodovias.Items.AddStrings(dmSysBr.LoadHighWay);
end;

procedure TCdSquare.MoveObjectToControls;
var
  aPk: Integer;
begin
  if (PkSquare <= 0) or (FkCompany.PkCompany <= 0) then exit;
  aPk       := DataRecord.FieldByName['FK_RODOVIAS'].AsInteger;
  FkHighWay := TRodovias(eFk_Rodovias.SetIndexFromObjectValue(aPk));
  DscPrc    := DataRecord.FieldByName['DSC_PRC'].AsString;
  PosTrc    := DataRecord.FieldByName['POS_TRC'].AsFloat;
end;

procedure TCdSquare.SaveIntoDB;
begin
  DataRecord.FieldByName['FK_EMPRESAS'].AsInteger := FkCompany.PkCompany;
  DataRecord.FieldByName['FK_PRACAS'].AsInteger   := PkSquare;
  DataRecord.FieldByName['FK_RODOVIAS'].AsInteger := FkHighWay.PkRodovias;
  DataRecord.FieldByName['DSC_PRC'].AsString      := DscPrc;
  DataRecord.FieldByName['POS_TRC'].AsFloat       := PosTrc;
  dmSysBr.SaveSquare(ScrMode, DataRecord);
  ScrMode := dbmBrowse;
end;

function TCdSquare.GetDscPrc: string;
begin
  Result := eDsc_Prc.Text;
end;

function TCdSquare.GetFkHighWay: TRodovias;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Rodovias.ItemIndex;
  if (aIdx > -1) and (eFk_Rodovias.Items.Objects[aIdx] <> nil) then
    Result := TRodovias(eFk_Rodovias.Items.Objects[aIdx]);
end;

function TCdSquare.GetPosTrc: Double;
begin
  Result := ePos_Trc.Value;
end;

procedure TCdSquare.SetFkHighWay(const Value: TRodovias);
begin
  if (Value = nil) then
    eFk_Rodovias.ItemIndex := 0
  else
    eFk_Rodovias.SetIndexFromObjectValue(Value.PkRodovias);
end;

procedure TCdSquare.SetPosTrc(const Value: Double);
begin
  ePos_Trc.Value := Value;
end;

procedure TCdSquare.SetPrcDsc(const Value: string);
begin
  eDsc_Prc.Text := Value;
end;

end.
