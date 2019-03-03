unit CadPrCat;

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
  Dialogs, SqrForm, StdCtrls, Mask, ToolEdit, CurrEdit, PrcCombo;

type
  TCdCategory = class(TfrmSquareForms)
    lPk_Pracas_Categorias: TStaticText;
    ePk_Pracas_Categorias: TCurrencyEdit;
    eFk_Produtos: TPrcComboBox;
    lFk_Produtos: TStaticText;
    stTitle: TStaticText;
  private
    { Private declarations }
    function  GetDscProd: string;
    function  GetFkProdutos: Integer;
    function  GetPkPracasCategorias: Integer;
    procedure SetFkProdutos(const Value: Integer);
    procedure SetPkPracasCategorias(const Value: Integer);
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
    property DscProd           : string  read GetDscProd;
    property PkPracasCategorias: Integer read GetPkPracasCategorias write SetPkPracasCategorias;
    property FkProdutos        : Integer read GetFkProdutos         write SetFkProdutos;
  end;

var
  CdCategory: TCdCategory;

implementation

uses Dado, mSysBr, ProcUtils, GridRow;

{$R *.dfm}

{ TCdCategory }

procedure TCdCategory.ClearControls;
begin
  FkProdutos         := 0;
  PkPracasCategorias := 0;
end;

procedure TCdCategory.LoadDefaults;
begin
  stTitle.Caption := Title;
  if (not ListLoaded) then
  begin
    eFk_Produtos.Items.AddStrings(dmSysBr.LoadProducts);
    ListLoaded := False;
  end;
end;

procedure TCdCategory.MoveObjectToControls;
begin
  FkProdutos         := DataRecord.FieldByName['FK_PRODUTOS'].AsInteger;
  PkPracasCategorias := DataRecord.FieldByName['PK_CATEGORIAS_PRODUTOS'].AsInteger;
end;

procedure TCdCategory.SaveIntoDB;
var
  i: Integer;
begin
  for i := 0 to DataRecord.Count - 1 do
    DataRecord.Fields[i].TypeBuffer := buValue;
  DataRecord.FieldByName['FK_EMPRESAS'].AsInteger            := Dados.PkCompany;
  DataRecord.FieldByName['FK_PRACAS'].AsInteger              := PkSquare;
  DataRecord.FieldByName['FK_PRODUTOS'].AsInteger            := FkProdutos;
  DataRecord.FieldByName['DSC_PROD'].AsString                := DscProd;
  DataRecord.FieldByName['PK_CATEGORIAS_PRODUTOS'].AsInteger := PkPracasCategorias;
  dmSysBr.SaveCategory(ScrMode, DataRecord);
  ScrMode := dbmBrowse;
end;

function  TCdCategory.GetDscProd: string;
var
  aIdx: Integer;
begin
  Result := '';
  aIdx := eFk_Produtos.ItemIndex;
  if (aIdx > 0) and (eFk_Produtos.Items[aIdx] <> '') then
    Result := eFk_Produtos.Items[aIdx];
end;

function  TCdCategory.GetFkProdutos: Integer;
begin
  Result := 0;
  with eFk_Produtos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function  TCdCategory.GetPkPracasCategorias: Integer;
begin
  Result := ePk_Pracas_Categorias.AsInteger;
end;

procedure TCdCategory.SetFkProdutos(const Value: Integer);
begin
  eFk_Produtos.SetIndexFromIntegerValue(Value);
end;

procedure TCdCategory.SetPkPracasCategorias(const Value: Integer);
begin
  ePk_Pracas_Categorias.AsInteger := Value;
end;

end.
