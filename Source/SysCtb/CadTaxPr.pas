unit CadTaxPr;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 10/07/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
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
  Dialogs, CadModel, StdCtrls, Mask, ToolEdit, CurrEdit, ExtCtrls, ProcUtils,
  TSysPedAux;

type
  TCdTaxPrinter = class(TfrmModel)
    lTitle: TLabel;
    shTitle: TShape;
    lFk_Suported_Printers: TStaticText;
    eFk_Suported_Printers: TComboBox;
    lCod_Alqt_Cnsf: TStaticText;
    eCod_Alqt_Cnsf: TCurrencyEdit;
    lCod_Alqt: TStaticText;
    eCod_Alqt: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FFkCountry: Integer;
    FFkState: string;
    FFlagES: TInOut;
    FFkTypeTax: Integer;
    FEnabledCtrls: Boolean;
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function GetCodAlqt: Integer;
    function GetCodAlqtCnsf: Integer;
    function GetFkSuportedPrinters: Integer;
    procedure SetCodAlqt(const Value: Integer);
    procedure SetCodAlqtCnsf(const Value: Integer);
    procedure SetFkCountry(const Value: Integer);
    procedure SetFkState(const Value: string);
    procedure SetFkSuportedPrinters(const Value: Integer);
    procedure SetFlagES(const Value: TInOut);
    procedure SetFkTypeTax(const Value: Integer);
    procedure ChangePk(Sender: TObject);
    procedure SetEnabledCtrls(const Value: Boolean);
    function GetDscPrinter: string;
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
    property  FkSuportedPrinters: Integer read GetFkSuportedPrinters write SetFkSuportedPrinters;
    property  CodAlqtCnsf       : Integer read GetCodAlqtCnsf        write SetCodAlqtCnsf;
    property  CodAlqt           : Integer read GetCodAlqt            write SetCodAlqt;
  public
    { Public declarations }
    property  DscPrinter  : string  read GetDscPrinter;
    property  EnabledCtrls: Boolean read FEnabledCtrls write SetEnabledCtrls;
    property  FlagES      : TInOut  read FFlagES       write SetFlagES;
    property  FkState     : string  read FFkState      write SetFkState;
    property  FkCountry   : Integer read FFkCountry    write SetFkCountry;
    property  FkTypeTax   : Integer read FFkTypeTax    write SetFkTypeTax;
  end;

implementation

uses Dado, mSysCtb, Funcoes, GridRow;

{$R *.dfm}

{ TCdTaxPrinter }

function TCdTaxPrinter.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (FkSuportedPrinters = 0) then
  begin
    S := 'Campo Impressora Fiscal deve ser preenchido';
    C := eFk_Suported_Printers;
  end;
  if (CodAlqtCnsf = 0) then
  begin
    S := 'Campo código da alíquota para consumidor final deve ser preechido';
    C := eCod_Alqt_Cnsf;
  end;
  if (CodAlqt = 0) then
  begin
    S := 'Campo código da alíquota para revendas deve ser preechido';
    C := eCod_Alqt;
  end;
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTaxPrinter.ClearControls;
begin
  Loading := True;
  try
    FkSuportedPrinters := 0;
    CodAlqtCnsf        := 0;
    CodAlqt            := 0;
  finally
    Loading := False;
  end;
end;

function TCdTaxPrinter.GetCodAlqt: Integer;
begin
  Result := eCod_Alqt.AsInteger;
end;

function TCdTaxPrinter.GetCodAlqtCnsf: Integer;
begin
  Result := eCod_Alqt_Cnsf.AsInteger;
end;

function TCdTaxPrinter.GetFkSuportedPrinters: Integer;
begin
  with eFk_Suported_Printers do
  begin
    Result := -1;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

procedure TCdTaxPrinter.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Suported_Printers.Items.AddStrings(dmSysCtb.LoadPrinters);
    ListLoaded := True;
  end;
end;

procedure TCdTaxPrinter.MoveDataToControls;
var
  aData: TDataRow;
begin
  Loading := True;
  aData := dmSysCtb.TaxPrinter[Pk];
  try
    FkSuportedPrinters := aData.FieldByName['PK_ALIQUOTAS_IMP_FISCAL'].AsInteger;
    CodAlqtCnsf        := aData.FieldByName['COD_ALQT_CNSF'].AsInteger;
    CodAlqt            := aData.FieldByName['COD_ALQT'].AsInteger;;
  finally
    Loading := False;
    FreeAndNil(aData);
  end;
end;

procedure TCdTaxPrinter.SaveIntoDB;
var
  aData: TDataRow;
begin
  aData := dmSysCtb.TaxPrinter[0];
  try
    aData.FieldByName['PK_ALIQUOTAS_IMP_FISCAL'].AsInteger := FkSuportedPrinters;
    aData.FieldByName['COD_ALQT_CNSF'].AsInteger           := CodAlqtCnsf;
    aData.FieldByName['COD_ALQT'].AsInteger                := CodAlqt;
    dmSysCtb.TaxPrinter[Ord(ScrState)] := aData;
    Pk := aData.FieldByName['PK_ALIQUOTAS_IMP_FISCAL'].AsInteger;
    if Assigned(OnUpdateRow) then OnUpdateRow(Self, aData);
  finally
    FreeAndNil(aData);
  end;
end;

procedure TCdTaxPrinter.SetCodAlqt(const Value: Integer);
begin
  eCod_Alqt.AsInteger := Value;
end;

procedure TCdTaxPrinter.SetCodAlqtCnsf(const Value: Integer);
begin
  eCod_Alqt_Cnsf.AsInteger := Value;
end;

procedure TCdTaxPrinter.SetFkCountry(const Value: Integer);
begin
  FFkCountry         := Value;
  dmSysCtb.FkCountry := Value;
end;

procedure TCdTaxPrinter.SetFkState(const Value: string);
begin
  FFkState         := Value;
  dmSysCtb.FkState := Value;
end;

procedure TCdTaxPrinter.SetFkSuportedPrinters(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Suported_Printers do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdTaxPrinter.SetFlagES(const Value: TInOut);
begin
  FFlagES := Value;
end;

procedure TCdTaxPrinter.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
  OnChangePK    := ChangePk;
end;

procedure TCdTaxPrinter.FormDestroy(Sender: TObject);
begin
  inherited;
  ReleaseCombos(eFk_Suported_Printers, toInteger);
end;

procedure TCdTaxPrinter.SetFkTypeTax(const Value: Integer);
begin
  FFkTypeTax         := Value;
  dmSysCtb.FkTypeTax := Value;
end;

procedure TCdTaxPrinter.ChangePk(Sender: TObject);
begin
  eFk_Suported_Printers.Enabled := (Pk = 0);
  lFk_Suported_Printers.Enabled := (Pk = 0);
end;

procedure TCdTaxPrinter.SetEnabledCtrls(const Value: Boolean);
begin
  FEnabledCtrls                 := Value;
  lFk_Suported_Printers.Enabled := FEnabledCtrls;
  eFk_Suported_Printers.Enabled := FEnabledCtrls;
  lCod_Alqt_Cnsf.Enabled        := FEnabledCtrls;
  eCod_Alqt_Cnsf.Enabled        := FEnabledCtrls;
  lCod_Alqt.Enabled             := FEnabledCtrls;
  eCod_Alqt.Enabled             := FEnabledCtrls;
  lTitle.Enabled                := FEnabledCtrls;
end;

function TCdTaxPrinter.GetDscPrinter: string;
begin
  with eFk_Suported_Printers do
  begin
    Result := '';
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Text;
  end;
end;

end.
