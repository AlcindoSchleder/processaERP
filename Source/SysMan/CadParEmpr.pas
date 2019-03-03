unit CadParEmpr;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 25/03/2006 - DD/MM/YYYY                                     *}
{* Version: 2.0.0.0                                                      *}
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
  Dialogs, CadModel, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, ProcUtils,
  PrcCombo, GridRow, DB;

type
  TCdParametros = class(TfrmModel)
    eFk_Cenarios_Financeiros: TPrcComboBox;
    lFk_Cenarios_Financeiros: TStaticText;
    lFlag_Com_Tpgto: TCheckBox;
    lFlag_Com_Desc: TCheckBox;
    lFlag_Desc_Item: TCheckBox;
    eTax_JurM: TCurrencyEdit;
    lTax_JurM: TStaticText;
    lMrgl_Pdr: TStaticText;
    eMrgl_Pdr: TCurrencyEdit;
    eCust_Fix: TCurrencyEdit;
    lCust_Fix: TStaticText;
    lDsct_Max: TStaticText;
    eDsct_Max: TCurrencyEdit;
    lFlag_Com_Item: TRadioGroup;
    lFlagAcmFin: TCheckBox;
    procedure lFlag_Com_ItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function  GetCustFix: Double;
    function  GetDsctMax: Double;
    function  GetFkFinanceCenary: Integer;
    function  GetFlagComDesc: Boolean;
    function  GetFlagComItem: Integer;
    function  GetFlagComTPgto: Boolean;
    function  GetFlagDescItem: Boolean;
    function  GetMrglPdr: Double;
    function  GetTaxJurM: Double;
    procedure SetCustFix(const Value: Double);
    procedure SetDsctMax(const Value: Double);
    procedure SetFkFinanceCenary(const Value: Integer);
    procedure SetFlagComDesc(const Value: Boolean);
    procedure SetFlagComItem(const Value: Integer);
    procedure SetFlagComTPgto(const Value: Boolean);
    procedure SetFlagDescItem(const Value: Boolean);
    procedure SetMrglPdr(const Value: Double);
    procedure SetTaxJurM(const Value: Double);
    procedure ConfigFlags;
    function  CreateDataParams: TDataRow;
    function  GetDataParams: TDataRow;
    procedure SetDataParams(const Value: TDataRow);
    function  GetFlagAcmFin: Boolean;
    procedure SetFlagAcmFin(const Value: Boolean);
  protected
    { Protected declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    function  GetParamFields: TStrings;
    property  DataParams     : TDataRow read GetDataParams      write SetDataParams;
    property  FkFinanceCenary: Integer  read GetFkFinanceCenary write SetFkFinanceCenary;
    property  FlagComTPgto   : Boolean  read GetFlagComTPgto    write SetFlagComTPgto;
    property  FlagComDesc    : Boolean  read GetFlagComDesc     write SetFlagComDesc;
    property  FlagDescItem   : Boolean  read GetFlagDescItem    write SetFlagDescItem;
    property  TaxJurM        : Double   read GetTaxJurM         write SetTaxJurM;
    property  MrglPdr        : Double   read GetMrglPdr         write SetMrglPdr;
    property  CustFix        : Double   read GetCustFix         write SetCustFix;
    property  DsctMax        : Double   read GetDsctMax         write SetDsctMax;
    property  FlagComItem    : Integer  read GetFlagComItem     write SetFlagComItem;
    property  FlagAcmFin     : Boolean  read GetFlagAcmFin      write SetFlagAcmFin;
  end;

var
  CdParametros: TCdParametros;

implementation

uses Dado, mSysMan, SqlComm, ManArqSql;

{$R *.dfm}

{ TCdParametros }

function TCdParametros.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (FkFinanceCenary = 0) then
  begin
    C := eFk_Cenarios_Financeiros;
    S := 'Campo tipo de conta previsão deve ser preenchido';
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdParametros.ClearControls;
begin
  Loading        := True;
  try
    FkFinanceCenary := 0;
    FlagComTPgto    := False;
    FlagComDesc     := True;
    FlagDescItem    := False;
    TaxJurM         := 0.0;
    MrglPdr         := 0.0;
    CustFix         := 0.0;
    DsctMax         := 0.0;
    FlagComItem     := 0;
    ConfigFlags;
  finally
    Loading      := False;
  end;
end;

function TCdParametros.GetCustFix: Double;
begin
  Result := eCust_Fix.Value;
end;

function TCdParametros.GetDsctMax: Double;
begin
  Result := eDsct_Max.Value;
end;

function TCdParametros.GetFkFinanceCenary: Integer;
begin
  with eFk_Cenarios_Financeiros do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdParametros.GetFlagComDesc: Boolean;
begin
  Result := lFlag_Com_Desc.Checked;
end;

function TCdParametros.GetFlagComItem: Integer;
begin
  Result := lFlag_Com_Item.ItemIndex;
end;

function TCdParametros.GetFlagComTPgto: Boolean;
begin
  Result := lFlag_Com_Tpgto.Checked;
end;

function TCdParametros.GetFlagDescItem: Boolean;
begin
  Result := lFlag_Desc_Item.Checked;
end;

function TCdParametros.GetMrglPdr: Double;
begin
  Result := eMrgl_Pdr.Value;
end;

function TCdParametros.GetTaxJurM: Double;
begin
  Result := eTax_JurM.Value;
end;

procedure TCdParametros.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Cenarios_Financeiros.Items.AddStrings(dmSysMan.LoadCenaries);
    ListLoaded := True;
  end;
end;

procedure TCdParametros.MoveDataToControls;
begin
  if (Pk <= 0) then exit;
  Loading        := True;
  try
    DataParams      := dmSysMan.GetCompanyParams(Pk);
    ConfigFlags;
  finally
    Loading      := False;
  end;
end;

procedure TCdParametros.SaveIntoDB;
begin
  dmSysMan.SaveCampanyParams(DataParams, GetParamFields, ScrState);
end;

procedure TCdParametros.SetCustFix(const Value: Double);
begin
  eCust_Fix.Value := Value;
end;

procedure TCdParametros.SetDsctMax(const Value: Double);
begin
  eDsct_Max.Value := Value;
end;

procedure TCdParametros.SetFkFinanceCenary(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Cenarios_Financeiros do
  begin
    ItemIndex := -1;
    if (Value > 0) then
      for i := 0 to Items.Count -1 do
        if (Value = Integer(Items.Objects[i])) then
        begin
          ItemIndex := i;
          break;
        end;
  end;
end;

procedure TCdParametros.SetFlagComDesc(const Value: Boolean);
begin
  lFlag_Com_Desc.Checked := Value;
end;

procedure TCdParametros.SetFlagComItem(const Value: Integer);
begin
  lFlag_Com_Item.ItemIndex := Value;
end;

procedure TCdParametros.SetFlagComTPgto(const Value: Boolean);
begin
  lFlag_Com_Tpgto.Checked := Value;
end;

procedure TCdParametros.SetFlagDescItem(const Value: Boolean);
begin
  lFlag_Desc_Item.Checked := Value;
end;

procedure TCdParametros.SetMrglPdr(const Value: Double);
begin
  eMrgl_Pdr.Value := Value
end;

procedure TCdParametros.SetTaxJurM(const Value: Double);
begin
  eTax_JurM.Value := Value;
end;

procedure TCdParametros.lFlag_Com_ItemClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  ConfigFlags;
end;

procedure TCdParametros.ConfigFlags;
begin
  lFlag_Com_Desc.Enabled    := (lFlag_Com_Item.ItemIndex > 0);
  lFlag_Com_Tpgto.Enabled   := (lFlag_Com_Item.ItemIndex > 0);
  if (lFlag_Com_Item.ItemIndex < 1) then
  begin
    lFlag_Com_Desc.Checked  := False;
    lFlag_Com_Tpgto.Checked := False;
  end;
end;

function TCdParametros.GetDataParams: TDataRow;
begin
  Result := CreateDataParams;
  Result.FieldByName['FK_EMPRESAS'].AsInteger             := Pk;
  Result.FieldByName['FK_CENARIOS_FINANCEIROS'].AsInteger := FkFinanceCenary;
  Result.FieldByName['TAX_JURM'].AsFloat                  := TaxJurM;
  Result.FieldByName['MRGL_PDR'].AsFloat                  := MrglPdr;
  Result.FieldByName['CUST_FIX'].AsFloat                  := CustFix;
  Result.FieldByName['DSCT_MAX'].AsFloat                  := DsctMax;
  Result.FieldByName['FLAG_COM_TPGTO'].AsInteger          := Ord(FlagComTPgto);
  Result.FieldByName['FLAG_COM_DESC'].AsInteger           := Ord(FlagComDesc);
  Result.FieldByName['FLAG_DESC_ITEM'].AsInteger          := Ord(FlagDescItem);
  Result.FieldByName['FLAG_COM_ITEM'].AsInteger           := FlagComItem;
  Result.FieldByName['FLAG_ACM_FIN'].AsInteger            := Ord(FlagAcmFin);
end;

procedure TCdParametros.SetDataParams(const Value: TDataRow);
begin
  if (Value = nil) then exit;
  FkFinanceCenary := Value.FieldByName['FK_CENARIOS_FINANCEIROS'].AsInteger;
  TaxJurM         := Value.FieldByName['TAX_JURM'].AsFloat;
  MrglPdr         := Value.FieldByName['MRGL_PDR'].AsFloat;
  CustFix         := Value.FieldByName['CUST_FIX'].AsFloat;
  DsctMax         := Value.FieldByName['DSCT_MAX'].AsFloat;
  FlagComTPgto    := Boolean(Value.FieldByName['FLAG_COM_TPGTO'].AsInteger);
  FlagComDesc     := Boolean(Value.FieldByName['FLAG_COM_DESC'].AsInteger);
  FlagDescItem    := Boolean(Value.FieldByName['FLAG_DESC_ITEM'].AsInteger);
  FlagComItem     := Value.FieldByName['FLAG_COM_ITEM'].AsInteger;
  FlagAcmFin      := Boolean(Value.FieldByName['FLAG_ACM_FIN'].AsInteger);
end;

function TCdParametros.CreateDataParams: TDataRow;
begin
  Result := TDataRow.Create(nil);
  Result.AddAs('FK_EMPRESAS', 0, ftInteger, SizeOf(Integer));
  Result.AddAs('FK_CENARIOS_FINANCEIROS', 0, ftInteger, SizeOf(Integer));
  Result.AddAs('FK_CONTAS', 0, ftInteger, SizeOf(Integer));
  Result.AddAs('TAX_JURM', 0.0, ftFloat, SizeOf(Double));
  Result.AddAs('MRGL_PDR', 0.0, ftFloat, SizeOf(Double));
  Result.AddAs('CUST_FIX', 0.0, ftFloat, SizeOf(Double));
  Result.AddAs('DSCT_MAX', 0.0, ftFloat, SizeOf(Double));
  Result.AddAs('FLAG_COM_TPGTO', 0, ftInteger, SizeOf(Integer));
  Result.AddAs('FLAG_COM_DESC', 0, ftInteger, SizeOf(Integer));
  Result.AddAs('FLAG_DESC_ITEM', 0, ftInteger, SizeOf(Integer));
  Result.AddAs('FLAG_COM_ITEM', 0, ftInteger, SizeOf(Integer));
  Result.AddAs('FLAG_ACM_FIN', 0, ftInteger, SizeOf(Integer));
end;

function TCdParametros.GetParamFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FLAG_COM_TPGTO');
  Result.Add('FLAG_COM_DESC');
  Result.Add('FLAG_DESC_ITEM');
  Result.Add('FLAG_COM_ITEM');
  Result.Add('FLAG_ACM_FIN');
  if (ScrState = dbmInsert) then
    Result.Add('FK_EMPRESAS');
  if (FkFinanceCenary > 0) then
    Result.Add('FK_CENARIOS_FINANCEIROS');
  if (TaxJurM <> 0) then
    Result.Add('TAX_JURM');
  if (MrglPdr <> 0) then
    Result.Add('MRGL_PDR');
  if (CustFix <> 0) then
    Result.Add('CUST_FIX');
  if (DsctMax <> 0) then
    Result.Add('DSCT_MAX');
end;

procedure TCdParametros.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

function TCdParametros.GetFlagAcmFin: Boolean;
begin
  Result := lFlagAcmFin.Checked;
end;

procedure TCdParametros.SetFlagAcmFin(const Value: Boolean);
begin
  lFlagAcmFin.Checked := Value;
end;

end.
