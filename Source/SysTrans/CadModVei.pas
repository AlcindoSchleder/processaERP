unit CadModVei;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 19/05/2007 - DD/MM/YYYY                                    *}
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
  Dialogs, Mask, ToolEdit, CurrEdit, StdCtrls, ExtCtrls, ProcUtils, CadModel;

type
  TCdModels = class(TfrmModel)
    shTitle: TShape;
    lTitle: TLabel;
    lPk_Veiculos_Modelos: TStaticText;
    ePk_Veiculos_Modelos: TEdit;
    lDsc_Mod: TStaticText;
    eDsc_Mod: TEdit;
    lAno_FIni: TStaticText;
    eAno_FIni: TCurrencyEdit;
    lAno_FFin: TStaticText;
    eAno_FFin: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFkMarks: Integer;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function GetDscMod: string;
    function GetFactEndY: Integer;
    function GetFactIniY: Integer;
    function GetPkModels: Integer;
    procedure SetDscMod(const Value: string);
    procedure SetFactEndY(const Value: Integer);
    procedure SetFactIniY(const Value: Integer);
    procedure SetPkModels(const Value: Integer);
    procedure SetFkMarks(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property FkMarks : Integer read FFkMarks    write SetFkMarks;
    property PkModels: Integer read GetPkModels write SetPkModels;
    property DscMod  : string  read GetDscMod   write SetDscMod;
    property FactIniY: Integer read GetFactIniY write SetFactIniY;
    property FactEndY: Integer read GetFactEndY write SetFactEndY;
  end;

var
  CdModels: TCdModels;

implementation

uses Dado, mSysTrans, GridRow, ProcType, DB;

{$R *.dfm}

function TCdModels.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (DscMod = '') then
  begin
    C := eDsc_Mod;
    S := 'Campo Descrição deve ser preenchido';
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdModels.ClearControls;
begin
  Loading := True;
  try
    PkModels := 0;
    DscMod   := '';
    FactIniY := 0;
    FactEndY := 0;
  finally
    Loading := False;
  end;
end;

procedure TCdModels.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

function TCdModels.GetDscMod: string;
begin
  Result := eDsc_Mod.Text;
end;

function TCdModels.GetFactEndY: Integer;
begin
  Result := eAno_FFin.AsInteger;
end;

function TCdModels.GetFactIniY: Integer;
begin
  Result := eAno_FIni.AsInteger;
end;

function TCdModels.GetPkModels: Integer;
begin
  Result := StrToIntDef(ePk_Veiculos_Modelos.Text, 0);
end;

procedure TCdModels.LoadDefaults;
begin
  inherited;
end;

procedure TCdModels.MoveDataToControls;
var
  aItem: TDataRow;
begin
  aItem := dmSysTrans.Models[Pk];
  Loading := True;
  try
    if (aItem <> nil) then
    begin
      PkModels := Pk;
      DscMod   := aItem.FieldByName['DSC_MOD'].AsString;
      FactEndY := aItem.FieldByName['ANO_FFIN'].AsInteger;
      FactIniY := aItem.FieldByName['ANO_FINI'].AsInteger;
    end;
  finally
    FreeAndNil(aItem);
    Loading := False;
  end;
end;

procedure TCdModels.SaveIntoDB;
var
  aItem: TDataRow;
  aRow : TDataRow;
  aPk  : Integer;
begin
  aItem := TDataRow.Create(Self);
  aRow  := TDataRow.Create(Self);
  try
    aItem.AddAs('FK_VEICULOS_MARCAS', FFkMarks, ftInteger, SizeOf(Integer));
    aItem.AddAs('PK_VEICULOS_MODELOS', PkModels, ftInteger, SizeOf(Integer));
    aItem.AddAs('DSC_MOD', DscMod, ftString, 31);
    aItem.AddAs('ANO_FINI', FactIniY, ftInteger, SizeOf(Integer));
    aItem.AddAs('ANO_FFIN', FactEndY, ftInteger, SizeOf(Integer));
    dmSysTrans.Models[Ord(ScrState)] := aItem;
    aPk := aItem.FieldByName['PK_VEICULOS_MODELOS'].AsInteger;
    aRow.AddAs('PK', aPk, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', aItem.FieldByName['DSC_MOD'].AsString, ftString, 31);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := aPk;
  finally
    FreeAndNil(aItem);
    FreeAndNil(aRow);
  end;
end;

procedure TCdModels.SetDscMod(const Value: string);
begin
  eDsc_Mod.Text := Value;
end;

procedure TCdModels.SetFactEndY(const Value: Integer);
begin
  eAno_FFin.AsInteger := Value;
end;

procedure TCdModels.SetFactIniY(const Value: Integer);
begin
  eAno_FIni.AsInteger := Value;
end;

procedure TCdModels.SetFkMarks(const Value: Integer);
begin
  FFkMarks          := Value;
  dmSysTrans.FkMark := Value;
end;

procedure TCdModels.SetPkModels(const Value: Integer);
begin
  ePk_Veiculos_Modelos.Text := IntToStr(Value);
end;

end.
