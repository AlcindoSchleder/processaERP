unit CadLot;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 26/02/2006                                                   *}
{* Modified:                                                             *}
{* Version: 1.0.0.0                                                      *}
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
  Dialogs, CadModel, Mask, ToolEdit, CurrEdit, StdCtrls, Buttons, GridRow,
  ExtCtrls;

type
  TCdLotacao = class(TfrmModel)
    lPk_Almoxarifados: TStaticText;
    lNivel_Lot: TStaticText;
    lRua_Lot: TStaticText;
    lBox_Lot: TStaticText;
    eBox_Lot: TEdit;
    ePk_Lotacoes: TCurrencyEdit;
    pTitle: TPanel;
    eNivel_Lot: TEdit;
    eRua_Lot: TEdit;
    procedure sbSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFkAlmox: Integer;
    FDscAlmox: string;
    function  GetBoxLot: string;
    function  GetDataRow: TDataRow;
    function  GetNivelLot: string;
    function  GetRuaLot: string;
    procedure SetBoxLot(const Value: string);
    procedure SetFkAlmox(const Value: Integer);
    procedure SetNivelLot(const Value: string);
    procedure SetPkLocation(const Value: Integer);
    procedure SetRuaLot(const Value: string);
    procedure SetPkLocationFromPk(Sender: TObject);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    procedure MoveDataToControls; override;
    property FkAlmox   : Integer  read FFkAlmox      write SetFkAlmox;
    property DscAlmox  : string   read FDscAlmox;
    property PkLocation: Integer                     write SetPkLocation;
    property RuaLot    : string   read GetRuaLot     write SetRuaLot;
    property NivelLot  : string   read GetNivelLot   write SetNivelLot;
    property BoxLot    : string   read GetBoxLot     write SetBoxLot;
    property DataRow   : TDataRow read GetDataRow;
  end;

var
  CdLotacao: TCdLotacao;

implementation

uses mSysEstq;

{$R *.dfm}

{ TCdLotacao }

procedure TCdLotacao.ClearControls;
begin
  Loading      := True;
  try
    PkLocation := 0;
    RuaLot     := '';
    NivelLot   := '';
    BoxLot     := '';
  finally
    Loading    := False;
  end;
end;

function TCdLotacao.GetBoxLot: string;
begin
  Result := eBox_Lot.Text;
end;

function TCdLotacao.GetNivelLot: string;
begin
  Result := eNivel_Lot.Text;
end;

function TCdLotacao.GetRuaLot: string;
begin
  Result := eRua_Lot.Text;
end;

procedure TCdLotacao.LoadDefaults;
begin
//  nothing to do
end;

procedure TCdLotacao.MoveDataToControls;
begin
  Loading    := True;
  try
    with DataRow do
    begin
      PkLocation := FieldByName['PK_LOTACOES'].AsInteger;
      RuaLot     := FieldByName['RUA_LOT'].AsString;
      NivelLot   := FieldByName['NIVEL_LOT'].AsString;
      BoxLot     := FieldByName['BOX_LOT'].AsString;
    end
  finally
    Loading    := False;
  end;
end;

procedure TCdLotacao.SaveIntoDB;
var
  aRow: TDataRow;
begin
  aRow := DataRow;
  with aRow do
  begin
    FieldByName['FK_ALMOXARIFADOS'].AsInteger := FkAlmox;
    FieldByName['PK_LOTACOES'].AsInteger      := Pk;
    FieldByName['RUA_LOT'].AsString           := RuaLot;
    FieldByName['NIVEL_LOT'].AsString         := NivelLot;
    FieldByName['BOX_LOT'].AsString           := BoxLot;
    dmSysEstq.SaveLotacao(aRow, ScrState);
    Pk       := FieldByName['PK_LOTACOES'].AsInteger;
    if Assigned(OnUpdateRow) then OnUpdateRow(Self, aRow);
  end;
end;

procedure TCdLotacao.SetBoxLot(const Value: string);
begin
  eBox_Lot.Text := Value;
end;

procedure TCdLotacao.SetFkAlmox(const Value: Integer);
begin
  if (Value = 0) then exit;
  FFkAlmox := Value;
  with dmSysEstq.GetAlmox(FFkAlmox) do
    FDscAlmox := FieldByName['DSC_ALMX'].AsString;
  pTitle.Caption := 'Almoxarifado: ' + IntToStr(FFkAlmox) + '/' + FDscAlmox;
end;

procedure TCdLotacao.SetNivelLot(const Value: string);
begin
  eNivel_Lot.Text := Value;
end;

procedure TCdLotacao.SetPkLocation(const Value: Integer);
begin
  ePk_Lotacoes.AsInteger := Value;
end;

procedure TCdLotacao.SetRuaLot(const Value: string);
begin
  eRua_Lot.Text := Value;
end;

procedure TCdLotacao.sbSaveClick(Sender: TObject);
begin
  Close;
end;

function TCdLotacao.GetDataRow: TDataRow;
begin
  Result := dmSysEstq.GetLotacao(FkAlmox, Pk);
end;

procedure TCdLotacao.FormCreate(Sender: TObject);
begin
  inherited;
  OnChangePK  := SetPkLocationFromPk;
end;

procedure TCdLotacao.SetPkLocationFromPk(Sender: TObject);
begin
  PkLocation := Pk;
end;

end.
