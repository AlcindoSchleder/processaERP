unit CadForn;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
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
  Dialogs, CadModel, StdCtrls, PrcCombo, Mask, ToolEdit, CurrEdit, TSysPedAux,
  TSysCad, ComCtrls, VirtualTrees;

type
  TCdSupplier = class(TfrmModel)
    pgMain: TPageControl;
    tbDefaultSupplier: TTabSheet;
    tbCarrierData: TTabSheet;
    lNom_Vnd: TStaticText;
    eNom_Vnd: TEdit;
    eFk_Tipo_Pagamentos: TPrcComboBox;
    lFk_Tipo_Pagamentos: TStaticText;
    lFlag_Prod_Def: TCheckBox;
    lFk_Vw_Cadastros: TStaticText;
    eFk_Vw_Cadastros: TPrcComboBox;
    eFk_Portos_Emb: TPrcComboBox;
    lFk_Portos_Emb: TStaticText;
    lFk_Portos_Dst: TStaticText;
    eFk_Portos_Dst: TPrcComboBox;
    eFk_Tipo_Descontos: TPrcComboBox;
    eFk_Vw_Transportadoras: TPrcComboBox;
    lFk_Vw_Transportadoras: TStaticText;
    lFk_Tipo_Descontos: TStaticText;
    lFk_Tabela_Precos: TStaticText;
    eFk_Tabela_Precos: TPrcComboBox;
    lFk_Tipo_Tabela_Fracao: TStaticText;
    eFk_Tipo_Tabela_Fracao: TPrcComboBox;
    vtRegions: TVirtualStringTree;
    lFlag_Trn: TCheckBox;
    procedure FormDestroy(Sender: TObject);
    procedure lFlag_TrnClick(Sender: TObject);
  private
    FIsChild: Boolean;
    function  GetFkTypeDiscount: Integer;
    function  GetFkTypePayment: TTypePayment;
    function  GetFkVwCadastros: Integer;
    function  GetFkVwCarrier: Integer;
    function  GetFlagProdDef: Boolean;
    function  GetFlagTrn: Boolean;
    function  GetNomVnd: string;
    function  GetPortDst: Integer;
    function  GetPortEmb: Integer;
    function  GetFkPriceTable: Integer;
    procedure SetFkTypeDiscount(const Value: Integer);
    procedure SetFkTypePayment(const Value: TTypePayment);
    procedure SetFkVwCadastros(const Value: Integer);
    procedure SetFkVwCarrier(const Value: Integer);
    procedure SetFlagProdDef(const Value: Boolean);
    procedure SetFlagTrn(const Value: Boolean);
    procedure SetNomVnd(const Value: string);
    procedure SetPortDst(const Value: Integer);
    procedure SetPortEmb(const Value: Integer);
    procedure SetFkPriceTable(const Value: Integer);
    function GetFkTypeFraction: Integer;
    procedure SetFkTypeFraction(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  IsChild       : Boolean       read FIsChild;
    property  FkPortDst     : Integer       read GetPortDst        write SetPortDst;
    property  FkPortEmb     : Integer       read GetPortEmb        write SetPortEmb;
    property  FkTypeDiscount: Integer       read GetFkTypeDiscount write SetFkTypeDiscount;
    property  FkTypePayment : TTypePayment  read GetFkTypePayment  write SetFkTypePayment;
    property  FkVwCadastros : Integer       read GetFkVwCadastros  write SetFkVwCadastros;
    property  FkVwCarrier   : Integer       read GetFkVwCarrier    write SetFkVwCarrier;
    property  FkPriceTable  : Integer       read GetFkPriceTable   write SetFkPriceTable;
    property  FkTypeFraction: Integer       read GetFkTypeFraction write SetFkTypeFraction;
    property  FlagProdDef   : Boolean       read GetFlagProdDef    write SetFlagProdDef;
    property  FlagTrn       : Boolean       read GetFlagTrn        write SetFlagTrn;
    property  NomVnd        : string        read GetNomVnd         write SetNomVnd;
  end;

var
  CdSupplier: TCdSupplier;

implementation

uses Dado, mSysCad, ProcUtils;

{$R *.dfm}

procedure TCdSupplier.FormDestroy(Sender: TObject);
begin
  eFk_Tipo_Pagamentos.ReleaseObjects;
  inherited;
end;

procedure TCdSupplier.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Portos_Dst.Items.AddStrings(dmSysCad.LoadPorts(Dados.Parametros.soCompanyCountry));
    eFk_Portos_Emb.Items.AddStrings(dmSysCad.LoadPorts(Dados.Parametros.soCompanyCountry));
    eFk_Tipo_Descontos.Items.AddStrings(dmSysCad.LoadTypeDiscounts(False));
    eFk_Tipo_Pagamentos.Items.AddStrings(dmSysCad.LoadTypePayment(False));
    eFk_Vw_Cadastros.Items.AddStrings(dmSysCad.LoadAgents);
    eFk_Vw_Transportadoras.Items.AddStrings(dmSysCad.LoadCarriers);
    eFk_Tabela_Precos.Items.AddStrings(dmSysCad.LoadPriceTable);
    eFk_Tipo_Tabela_Fracao.Items.AddStrings(dmSysCad.LoadTypeFraction);
    ListLoaded := True;
  end;
end;

procedure TCdSupplier.MoveDataToControls;
var
  aSupplier: TSupplier;
begin
  FIsChild := False;
  if (Pk = 0) then exit;
  Loading := True;
  aSupplier        := dmSysCad.GetSupplierData(Pk);
  try
    if (aSupplier <> nil) then
    begin
      FIsChild       := True;
      FkPortDst      := aSupplier.FkPortDst;
      FkPortEmb      := aSupplier.FkPortEmb;
      FkTypeDiscount := aSupplier.FkTypeDiscount;
      FkTypePayment  := aSupplier.FkTypePayment;
      FkVwCadastros  := aSupplier.FkAgent;
      FkVwCarrier    := aSupplier.FkCarrier;
      FkPriceTable   := aSupplier.FkPriceTable;
      FkTypeFraction := aSupplier.FkTypeFraction;
      FlagTrn        := aSupplier.FlagTrn;
      NomVnd         := aSupplier.NomVnd;
    end
    else
      ClearControls;
    tbCarrierData.TabVisible := lFlag_Trn.Checked;
  finally
    FreeAndNil(aSupplier);
    Loading := False;
  end;
end;

procedure TCdSupplier.ClearControls;
begin
  Loading := True;
  try
    FkPortDst      := 0;
    FkPortEmb      := 0;
    FkTypeDiscount := 0;
    FkTypePayment  := nil;
    FkTypeFraction := 0;
    FkVwCadastros  := 0;
    FkVwCarrier    := 0;
    FkPriceTable   := 0;
    FlagProdDef    := False;
    FlagTrn        := False;
    NomVnd         := '';
    tbCarrierData.TabVisible := False;
  finally
    Loading := False;
  end;
end;

procedure TCdSupplier.SaveIntoDB;
var
  aSupplier: TSupplier;
begin
  if (ScrState in SCROLL_MODE) then exit;
  aSupplier                := TSupplier.Create;
  aSupplier.FkPortDst      := FkPortDst;
  aSupplier.FkPortEmb      := FkPortEmb;
  aSupplier.FkTypeDiscount := FkTypeDiscount;
  aSupplier.FkTypePayment  := FkTypePayment;
  aSupplier.FkAgent        := FkVwCadastros;
  aSupplier.FkCarrier      := FkVwCarrier;
  aSupplier.FkPriceTable   := FkPriceTable;
  aSupplier.FkTypeFraction := FkTypeFraction;
  aSupplier.FlagProdDef    := FlagProdDef;
  aSupplier.FlagTrn        := FlagTrn;
  aSupplier.NomVnd         := NomVnd;
  if IsChild then
    dmSysCad.SaveSupplierData(Pk, aSupplier, dbmEdit)
  else
    dmSysCad.SaveSupplierData(Pk, aSupplier, dbmInsert);
end;

function TCdSupplier.GetFkTypeDiscount: Integer;
begin
  Result := 0;
  with eFk_Tipo_Descontos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypeDiscount(Items.Objects[ItemIndex]).PkTypeDiscount;
end;

function TCdSupplier.GetFkTypePayment: TTypePayment;
begin
  Result := nil;
  with eFk_Tipo_Pagamentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypePayment(Items.Objects[ItemIndex]);
end;

function TCdSupplier.GetFkVwCadastros: Integer;
begin
  Result := 0;
  with eFk_Vw_Cadastros do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOwner(Items.Objects[ItemIndex]).PkCadastros;
end;

function TCdSupplier.GetFkVwCarrier: Integer;
begin
  Result := 0;
  with eFk_Vw_Transportadoras do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOwner(Items.Objects[ItemIndex]).PkCadastros;
end;

function TCdSupplier.GetFlagProdDef: Boolean;
begin
  Result := lFlag_Prod_Def.Checked;
end;

function TCdSupplier.GetFlagTrn: Boolean;
begin
  Result := lFlag_Trn.Checked;
end;

function TCdSupplier.GetNomVnd: string;
begin
  Result := eNom_Vnd.Text;
end;

function TCdSupplier.GetPortDst: Integer;
begin
  Result := 0;
  with eFk_Portos_Dst do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdSupplier.GetPortEmb: Integer;
begin
  Result := 0;
  with eFk_Portos_Emb do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

procedure TCdSupplier.SetFkTypePayment(const Value: TTypePayment);
begin
  with eFk_Tipo_Pagamentos do
  begin
    ItemIndex := -1;
    if (Value <> nil) then SetIndexFromObjectValue(Value.PkTypePgto);
  end;
end;

procedure TCdSupplier.SetFkVwCadastros(const Value: Integer);
begin
  with eFk_Vw_Cadastros do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromObjectValue(Value);
  end;
end;

procedure TCdSupplier.SetFkVwCarrier(const Value: Integer);
begin
  with eFk_Vw_Transportadoras do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromObjectValue(Value);
  end;
end;

procedure TCdSupplier.SetFlagProdDef(const Value: Boolean);
begin
  lFlag_Prod_Def.Checked := Value;
end;

procedure TCdSupplier.SetFlagTrn(const Value: Boolean);
begin
  lFlag_Trn.Checked := Value;
end;

procedure TCdSupplier.SetNomVnd(const Value: string);
begin
  eNom_Vnd.Text := Value;
end;

procedure TCdSupplier.SetPortDst(const Value: Integer);
begin
  with eFk_Portos_Dst do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromObjectValue(Value);
  end;
end;

procedure TCdSupplier.SetPortEmb(const Value: Integer);
begin
  with eFk_Portos_Emb do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromObjectValue(Value);
  end;
end;

procedure TCdSupplier.SetFkTypeDiscount(const Value: Integer);
begin
  with eFk_Tipo_Pagamentos do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromObjectValue(Value);
  end;
end;

function TCdSupplier.GetFkPriceTable: Integer;
begin
  Result := 0;
  with eFk_Tabela_Precos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypeDiscount(Items.Objects[ItemIndex]).PkTypeDiscount;
end;

procedure TCdSupplier.SetFkPriceTable(const Value: Integer);
begin
  with eFk_Portos_Dst do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromObjectValue(Value);
  end;
end;

procedure TCdSupplier.lFlag_TrnClick(Sender: TObject);
begin
  tbCarrierData.TabVisible := lFlag_Trn.Checked;
end;

function TCdSupplier.GetFkTypeFraction: Integer;
begin
  with eFk_Tipo_Tabela_Fracao do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

procedure TCdSupplier.SetFkTypeFraction(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Tabela_Fracao do
  begin
    if (Items.Count > 0) then
      ItemIndex := 0;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[ItemIndex] <> nil) and
         (Integer(Items.Objects[ItemIndex]) = Value)then
      begin
        ItemIndex := 1;
        break;
      end;
    end;
  end;
end;

end.
