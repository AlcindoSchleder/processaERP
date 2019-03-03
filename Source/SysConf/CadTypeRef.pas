unit CadTypeRef;

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
  Dialogs, CadModel, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, ProcUtils,
  TSysConfAux, GridRow;

type
  TCdTypeReference = class(TfrmModel)
    lPk_Tipo_Referencias: TStaticText;
    ePk_Tipo_Referencias: TEdit;
    lDsc_Ref: TStaticText;
    eDsc_Ref: TEdit;
    lFaixa_Cust_Fin: TStaticText;
    eFaixa_Cust_Ini: TCurrencyEdit;
    lFaixa_Cust_Ini: TStaticText;
    eFaixa_Cust_Fin: TCurrencyEdit;
    lFlag_TIns: TRadioGroup;
    shTitle: TShape;
    lTitle: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FPkTypeFinish: Integer;
    FDscAcbm     : string;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDataRow: TDataRow;
    function  GetDscRef: string;
    function  GetEndRange: Double;
    function  GetFlagIns: TMaterialMode;
    function  GetPkTypeRef: Integer;
    function  GetStartRange: Double;
    procedure SetDscRef(const Value: string);
    procedure SetEndRange(const Value: Double);
    procedure SetFlagIns(const Value: TMaterialMode);
    procedure SetPkTypeRef(const Value: Integer);
    procedure SetStartRange(const Value: Double);
    procedure SetPkTypeFinish(const Value: Integer);
    procedure SetPkFromPk(Sender: TObject);
    procedure SetDscAcbm(const Value: string);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  DscAcbm     : string        read FDscAcbm      write SetDscAcbm;
    property  FkTypeFinish: Integer       read FPkTypeFinish write SetPkTypeFinish;
    property  PkTypeRef   : Integer       read GetPkTypeRef  write SetPkTypeRef;
    property  DscRef      : string        read GetDscRef     write SetDscRef;
    property  EndRange    : Double        read GetEndRange   write SetEndRange;
    property  StartRange  : Double        read GetStartRange write SetStartRange;
    property  FlagTIns    : TMaterialMode read GetFlagIns    write SetFlagIns;
  end;

var
  CdTypeReference: TCdTypeReference;

implementation

uses Dado, mSysConf, DB;

{$R *.dfm}

{ TCdTypeReference }

function TCdTypeReference.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscRef = '') then
  begin
    Dados.DisplayHint(eDsc_Ref, 'Campo descrição deve conter um valor');
    Result := False;
  end;
end;

procedure TCdTypeReference.ClearControls;
begin
  Loading := True;
  try
    PkTypeRef  := 0;
    DscRef     := '';
    EndRange   := 0.0;
    StartRange := 0.0;
    FlagTIns   := mmSelectFinish;
  finally
    Loading := False;
  end;
end;

function TCdTypeReference.GetDscRef: string;
begin
  Result := eDsc_Ref.Text;
end;

function TCdTypeReference.GetEndRange: Double;
begin
  Result := eFaixa_Cust_Fin.Value;
end;

function TCdTypeReference.GetFlagIns: TMaterialMode;
begin
  Result := TMaterialMode(lFlag_TIns.ItemIndex);
end;

function TCdTypeReference.GetPkTypeRef: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Referencias.Text, 0)
end;

function TCdTypeReference.GetStartRange: Double;
begin
  Result := eFaixa_Cust_Ini.Value;
end;

procedure TCdTypeReference.LoadDefaults;
begin
//  nothing to do.
end;

procedure TCdTypeReference.MoveDataToControls;
var
  aItem: TReferenceType;
begin
  Loading := True;
  try
    aItem        := dmSysConf.TypeReference[Pk];
    PkTypeRef    := aItem.PkReferenceType;
    FkTypeFinish := aItem.FkFinishType.PkFinishType;
    DscRef       := aItem.DscRef;
    EndRange     := aItem.EndRange;
    StartRange   := aItem.StartRange;
    FlagTIns     := aItem.FlagTIns;
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
end;

procedure TCdTypeReference.SaveIntoDB;
var
  aItem: TReferenceType;
  aRow : TDataRow;
begin
  aItem                              := TReferenceType.Create;
  try
    aItem.PkReferenceType            := PkTypeRef;
    aItem.FkFinishType.PkFinishType  := FkTypeFinish;
    aItem.DscRef                     := DscRef;
    aItem.EndRange                   := EndRange;
    aItem.StartRange                 := StartRange;
    aItem.FlagTIns                   := FlagTIns;
    dmSysConf.TypeReference[Pk]      := aItem;
    Pk                               := aItem.PkReferenceType;
  finally
    FreeAndNil(aItem);
  end;
  aRow := GetDataRow;
  try
    if Assigned(OnUpdateRow) then OnUpdateRow(Self, aRow);
  finally
    FreeAndNil(aRow);
  end;
end;

procedure TCdTypeReference.SetDscRef(const Value: string);
begin
  eDsc_Ref.Text := Value;
end;

procedure TCdTypeReference.SetEndRange(const Value: Double);
begin
  eFaixa_Cust_Fin.Value := Value;
end;

procedure TCdTypeReference.SetFlagIns(const Value: TMaterialMode);
begin
  lFlag_TIns.ItemIndex := Ord(Value);
end;

procedure TCdTypeReference.SetPkTypeRef(const Value: Integer);
begin
  ePk_Tipo_Referencias.Text := IntToStr(Value);
end;

procedure TCdTypeReference.SetStartRange(const Value: Double);
begin
  eFaixa_Cust_Ini.Value := Value;
end;

procedure TCdTypeReference.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
  OnChangePK    := SetPkFromPk;
end;

procedure TCdTypeReference.SetPkTypeFinish(const Value: Integer);
begin
  FPkTypeFinish          := Value;
  dmSysConf.PkTypeFinish := Value;
end;

procedure TCdTypeReference.SetDscAcbm(const Value: string);
begin
  lTitle.Caption := 'Cadastro de Referências';
  if (Value <> '') then
    lTitle.Caption := 'Cadastro de Referências: ' + Value;
end;

function TCdTypeReference.GetDataRow: TDataRow;
begin
  Result := TDataRow.Create(nil);
  Result.AddAs('PK_TIPO_ACABAMENTOS', FkTypeFinish, ftInteger, SizeOf(Integer));
  Result.AddAs('DSC_ACABM', DscAcbm, ftString, 31);
  Result.AddAs('FK_TIPO_ACABAMENTOS', FkTypeFinish, ftInteger, SizeOf(Integer));
  Result.AddAs('PK_TIPO_REFERENCIAS', PkTypeRef, ftInteger, SizeOf(Integer));
  Result.AddAs('DSC_REF', DscRef, ftString, 31);
end;

procedure TCdTypeReference.SetPkFromPk(Sender: TObject);
begin
  PkTypeRef := Pk;
end;

end.
