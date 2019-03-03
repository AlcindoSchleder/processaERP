unit CadPrOpe;

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
  Dialogs, SqrForm, StdCtrls, PrcCombo, Mask, ToolEdit, CurrEdit;

type
  TCdOperator = class(TfrmSquareForms)
    lPk_Pracas_Operadores: TStaticText;
    ePk_Pracas_Operadores: TCurrencyEdit;
    eFk_Cadastros: TPrcComboBox;
    lFk_Cadastros: TStaticText;
    stTitle: TStaticText;
  private
    function GetFkCadastros: Integer;
    function GetPkPracasOperadores: Integer;
    procedure SetFkCadastros(const Value: Integer);
    procedure SetPkPracasOperadores(const Value: Integer);
    function GetRazSoc: string;
    { Private declarations }
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
    property PkPracasOperadores: Integer read GetPkPracasOperadores write SetPkPracasOperadores;
    property FkCadastros       : Integer read GetFkCadastros        write SetFkCadastros;
    property RazSoc            : string  read GetRazSoc; 
  end;

var
  CdOperator: TCdOperator;

implementation

uses mSysBr, ProcUtils;

{$R *.dfm}

{ TCdOperator }

procedure TCdOperator.ClearControls;
begin
  FkCadastros        := 0;
  PkPracasOperadores := 0;
end;

procedure TCdOperator.LoadDefaults;
begin
  stTitle.Caption := Title;
  if (not ListLoaded) then
  begin
    eFk_Cadastros.Items.AddStrings(dmSysBr.LoadEmployee);
    ListLoaded := False;
  end;
end;

procedure TCdOperator.MoveObjectToControls;
begin
  FkCadastros        := DataRecord.FieldByName['FK_CADASTROS'].AsInteger;
  PkPracasOperadores := DataRecord.FieldByName['PK_PRACAS_OPERADORES'].AsInteger;
end;

procedure TCdOperator.SaveIntoDB;
begin
  DataRecord.FieldByName['FK_EMPRESAS'].AsInteger          := FkCompany.PkCompany;
  DataRecord.FieldByName['FK_PRACAS'].AsInteger            := PkSquare;
  DataRecord.FieldByName['FK_CADASTROS'].AsInteger         := FkCadastros;
  DataRecord.FieldByName['RAZ_SOC'].AsString               := RazSoc;
  DataRecord.FieldByName['PK_PRACAS_OPERADORES'].AsInteger := PkPracasOperadores;
  dmSysBr.SaveOperator(ScrMode, DataRecord);
  ScrMode := dbmBrowse;
end;

function TCdOperator.GetFkCadastros: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Cadastros.ItemIndex;
  if (aIdx > -1) and (eFk_Cadastros.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Cadastros.Items.Objects[aIdx]);
end;

function TCdOperator.GetPkPracasOperadores: Integer;
begin
  Result := ePk_Pracas_Operadores.AsInteger;
end;

function TCdOperator.GetRazSoc: string;
var
  aIdx: Integer;
begin
  Result := '';
  aIdx := eFk_Cadastros.ItemIndex;
  if (aIdx > -1) and (eFk_Cadastros.Items[aIdx] <> '') then
    Result := eFk_Cadastros.Items[aIdx];
end;

procedure TCdOperator.SetFkCadastros(const Value: Integer);
begin
  eFk_Cadastros.SetIndexFromIntegerValue(Value);
end;

procedure TCdOperator.SetPkPracasOperadores(const Value: Integer);
begin
  ePk_Pracas_Operadores.AsInteger := Value;
end;

end.
