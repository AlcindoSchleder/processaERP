unit CadTPrc;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 02/06/2003 - DD/MM/YYYY                                    *}
{* Modified : 22/01/2007 - DD/MM/YYYY                                    *}
{* Version  : 1.5.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadModel, CurrEdit, Mask, ToolEdit, StdCtrls, ProcUtils,
  ExtCtrls, EstqCnst;

type
  TCdTablePrice = class(TfrmModel)
    lPk_Tabela_Precos: TStaticText;
    ePk_Tabela_Precos: TEdit;
    lDsc_Tab: TStaticText;
    eDsc_Tab: TEdit;
    lDta_Ini: TStaticText;
    eDta_Ini: TDateEdit;
    lDta_Fin: TStaticText;
    eDta_Fin: TDateEdit;
    lPerc_Dsct: TStaticText;
    ePerc_Dsct: TCurrencyEdit;
    lTitle: TLabel;
    shTitle: TShape;
    lFlag_Def: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure lFlag_DefClick(Sender: TObject);
  private
    { Private declarations }
    FUncheckAll: Boolean;
    FOnCheckDefault: TAllowedEvent;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscTab: string;
    function  GetDtaFin: TDateTime;
    function  GetDtaIni: TDateTime;
    function  GetFlagDef: Boolean;
    function  GetPercDsct: Double;
    function  GetPkTablePrice: Integer;
    procedure SetDscTab(const Value: string);
    procedure SetDtaFin(const Value: TDateTime);
    procedure SetDtaIni(const Value: TDateTime);
    procedure SetPercDsct(const Value: Double);
    procedure SetPkTablePrice(const Value: Integer);
    procedure SetFlagDef(const Value: Boolean);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  DtaIni        : TDateTime     read GetDtaIni       write SetDtaIni;
    property  DtaFin        : TDateTime     read GetDtaFin       write SetDtaFin;
    property  PercDsct      : Double        read GetPercDsct     write SetPercDsct;
    property  PkTablePrice  : Integer       read GetPkTablePrice write SetPkTablePrice;
  public
    { Public declarations }
    property  DscTab        : string        read GetDscTab       write SetDscTab;
    property  FlagDef       : Boolean       read GetFlagDef      write SetFlagDef;
    property  OnCheckDefault: TAllowedEvent read FOnCheckDefault write FOnCheckDefault;
  end;

var
  CdTablePrice: TCdTablePrice;

implementation

uses Dado, mSysEstq, ProcType, GridRow, DB, FuncoesDB, TSysEstqAux;

{$R *.dfm}

{ TCdTablePrice }

function TCdTablePrice.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C: TControl;
  S: string;
begin
  C := nil;
  Result := True;
  if (DscTab = '') then
  begin
    S := 'Compo descrição deve conter um valor';
    C := eDsc_Tab;
  end;
  if (S <> '') then
  begin
    Result := False;
    Dados.DisplayHint(C, S);
  end;
end;

procedure TCdTablePrice.ClearControls;
begin
  Loading := True;
  try
    DscTab       := '';
    DtaIni       := 0;
    DtaFin       := 0;
    PercDsct     := 0.0;
    PkTablePrice := 0;
    FlagDef      := False;
  finally
    Loading := False;
  end;
end;

function TCdTablePrice.GetDscTab: string;
begin
  Result := eDsc_Tab.Text;
end;

function TCdTablePrice.GetDtaFin: TDateTime;
begin
  Result := eDta_Fin.Date;
end;

function TCdTablePrice.GetDtaIni: TDateTime;
begin
  Result := eDta_Ini.Date;
end;

function TCdTablePrice.GetFlagDef: Boolean;
begin
  Result := lFlag_Def.Checked;
end;

function TCdTablePrice.GetPercDsct: Double;
begin
  Result := ePerc_Dsct.Value;
end;

function TCdTablePrice.GetPkTablePrice: Integer;
begin
  Result := StrToIntDef(ePk_Tabela_Precos.Text, 0);
end;

procedure TCdTablePrice.LoadDefaults;
begin
// nothing to do
end;

procedure TCdTablePrice.MoveDataToControls;
var
  Data: TPriceTable;
begin
  Loading := True;
  try
    Data         := dmSysEstq.TablePrice[PK];
    DscTab       := Data.DscTab;
    DtaIni       := Data.DtaIni;
    DtaFin       := Data.DtaFin;
    PercDsct     := Data.PercDsct;
    PkTablePrice := Data.PkPriceTable;
    FlagDef      := Data.FlagDefTab;
  finally
    Loading := False;
    FreeAndNil(Data);
  end;
end;

procedure TCdTablePrice.SaveIntoDB;
var
  Data: TPriceTable;
  aRow: TDataRow;
begin
  Data                       := TPriceTable.Create(Self);
  aRow                       := TDataRow.Create(Self);
  try
    Data.DscTab              := DscTab;
    Data.DtaIni              := DtaIni;
    Data.DtaFin              := DtaFin;
    Data.PercDsct            := PercDsct;
    Data.PkPriceTable        := PkTablePrice;
    Data.FlagDefTab          := FlagDef;
    dmSysEstq.TablePrice[Ord(ScrState)] := Data;
    aRow.AddAs('PK', Data.PkPriceTable, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', Data.DscTab, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk                       := Data.PkPriceTable;
  finally
    FreeAndNil(Data);
    FreeAndNil(aRow);
  end;
end;

procedure TCdTablePrice.SetDscTab(const Value: string);
begin
  eDsc_Tab.Text := Value;
end;

procedure TCdTablePrice.SetDtaFin(const Value: TDateTime);
begin
  eDta_Fin.Date := Value;
end;

procedure TCdTablePrice.SetDtaIni(const Value: TDateTime);
begin
  eDta_Ini.Date := Value;
end;

procedure TCdTablePrice.SetFlagDef(const Value: Boolean);
begin
  lFlag_Def.Checked := Value;
end;

procedure TCdTablePrice.SetPercDsct(const Value: Double);
begin
  ePerc_Dsct.Value := Value;
end;

procedure TCdTablePrice.SetPkTablePrice(const Value: Integer);
begin
  ePk_Tabela_Precos.Text := IntToStr(Value);
end;

procedure TCdTablePrice.FormCreate(Sender: TObject);
begin
  FUncheckAll   := False;
  inherited;
  OnCheckRecord := CheckRecord;
end;

procedure TCdTablePrice.lFlag_DefClick(Sender: TObject);
var
  aAllowed: Boolean;
begin
  if Loading then exit;
  ChangeGlobal(Sender);
  aAllowed := FlagDef;
  if (Assigned(FOnCheckDefault)) then
    FOnCheckDefault(Sender, lFlag_Def.Checked, aAllowed);
  lFlag_Def.Checked := aAllowed;
end;

end.
