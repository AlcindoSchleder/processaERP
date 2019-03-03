unit CadTFinish;

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
  Dialogs, CadModel, StdCtrls, ExtCtrls, ProcUtils, TSysConfAux, GridRow;

type
  TCdTypeFinish = class(TfrmModel)
    lPk_Tipo_Acabamentos: TStaticText;
    ePk_Tipo_Acabamentos: TEdit;
    lDsc_Acabm: TStaticText;
    eDsc_Acabm: TEdit;
    lFlag_TDsc: TRadioGroup;
    shTitle: TShape;
    lTitle: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDataRow: TDataRow;
    function  GetDscAcabm: string;
    function  GetFlagTDsc: TTypeDescription;
    function  GetPkTypeFinish: Integer;
    procedure SetDscAcabm(const Value: string);
    procedure SetFlagTDsc(const Value: TTypeDescription);
    procedure SetPkTypeFinish(const Value: Integer);
    procedure SetPkFromPk(Sender: TObject);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  PkTypeFinish: Integer          read GetPkTypeFinish write SetPkTypeFinish;
    property  DscAcabm    : string           read GetDscAcabm     write SetDscAcabm;
    property  FlagTDsc    : TTypeDescription read GetFlagTDsc     write SetFlagTDsc;
  end;

var
  CdTypeFinish: TCdTypeFinish;

implementation

uses Dado, ProcType, mSysConf, DB;

{$R *.dfm}

{ TCdTypeFinish }

function TCdTypeFinish.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscAcabm = '') then
  begin
    Dados.DisplayHint(eDsc_Acabm, 'Campo descrição deve conter um valor');
    Result := False;
  end;
end;

procedure TCdTypeFinish.ClearControls;
begin
  Loading := True;
  try
    PkTypeFinish := 0;
    DscAcabm     := '';
    FlagTDsc     := tdDescrAndReference;
  finally
    Loading := False;
  end;
end;

function TCdTypeFinish.GetDscAcabm: string;
begin
  Result := eDsc_Acabm.Text;
end;

function TCdTypeFinish.GetFlagTDsc: TTypeDescription;
begin
  Result := TTypeDescription(lFlag_TDsc.ItemIndex);
end;

function TCdTypeFinish.GetPkTypeFinish: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Acabamentos.Text, 0);
end;

procedure TCdTypeFinish.LoadDefaults;
begin
//  nothing to do
end;

procedure TCdTypeFinish.MoveDataToControls;
var
  aItem: TFinishType;
begin
  Loading := True;
  try
    aItem := dmSysConf.TypeFinish[Pk];
    PkTypeFinish := aItem.PkFinishType;
    DscAcabm     := aItem.DscAcbm;
    FlagTDsc     := aItem.FlagTDsc;
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
end;

procedure TCdTypeFinish.SaveIntoDB;
var
  aItem: TFinishType;
  aRow : TDataRow;
begin
  aItem        := TFinishType.Create;
  try
    aItem.PkFinishType := PkTypeFinish;
    aItem.DscAcbm      := DscAcabm;
    aItem.FlagTDsc     := FlagTDsc;
    dmSysConf.TypeFinish[Ord(ScrState)] := aItem;
    Pk                 := aItem.PkFinishType;
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

procedure TCdTypeFinish.SetDscAcabm(const Value: string);
begin
  eDsc_Acabm.Text := Value;
end;

procedure TCdTypeFinish.SetFlagTDsc(const Value: TTypeDescription);
begin
  lFlag_TDsc.ItemIndex := Ord(Value);
end;

procedure TCdTypeFinish.SetPkTypeFinish(const Value: Integer);
begin
  ePk_Tipo_Acabamentos.Text := IntToStr(Value);
end;

procedure TCdTypeFinish.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
  OnChangePK    := SetPkFromPk;
end;

function TCdTypeFinish.GetDataRow: TDataRow;
begin
  Result := TDataRow.Create(nil);
  Result.AddAs('PK_TIPO_ACABAMENTOS', PkTypeFinish, ftInteger, SizeOf(Integer));
  Result.AddAs('DSC_ACABM', DscAcabm, ftString, 31);
end;

procedure TCdTypeFinish.SetPkFromPk(Sender: TObject);
begin
  PkTypeFinish := Pk;
end;

end.
