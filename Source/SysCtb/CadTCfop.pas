unit CadTCfop;

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
  Dialogs, CadModel, StdCtrls, Mask, ToolEdit, CurrEdit, ProcUtils;

type
  TCdTipoCfop = class(TfrmModel)
    lPk_Tipo_Cfop: TStaticText;
    lDsc_Tmrc: TStaticText;
    eDsc_Tmrc: TEdit;
    ePk_Tipo_Cfop: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function  GetDscTMrc: string;
    function  GetPkTipoCfop: integer;
    procedure SetDscTMrc(const Value: string);
    procedure SetPkTipoCfop(const Value: integer);
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
  public
    { Public declarations }
    property  PkTipoCfop: integer read GetPkTipoCfop write SetPkTipoCfop;
    property  DscTMrc   : string  read GetDscTMrc    write SetDscTMrc;
  end;

implementation

uses Dado, mSysCtb, GridRow;

{$R *.dfm}

{ TCdTipoCfop }

function TCdTipoCfop.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscTMrc = '') then
  begin
    Dados.DisplayHint(eDsc_TMrc, 'Campo descrição deve conter um valor');
    Result := False;
  end;
end;

procedure TCdTipoCfop.ClearControls;
begin
  Loading := True;
  try
    PkTipoCfop := 0;
    DscTMrc    := '';
  finally
    Loading := False;
  end;
end;

function TCdTipoCfop.GetDscTMrc: string;
begin
  Result := eDsc_Tmrc.Text;
end;

function TCdTipoCfop.GetPkTipoCfop: integer;
begin
  Result := ePk_Tipo_Cfop.AsInteger;
end;

procedure TCdTipoCfop.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdTipoCfop.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysCtb.TypeCfop[Pk] do
    begin
      PkTipoCfop := FieldByName['PK_TIPO_CFOP'].AsInteger;
      DscTMrc    := FieldByName['DSC_TMRC'].AsString;
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdTipoCfop.SaveIntoDB;
var
  aItem: TDataRow;
begin
  aItem      := dmSysCtb.TypeCfop[0];
  PkTipoCfop := aItem.FieldByName['PK_TIPO_CFOP'].AsInteger;
  DscTMrc    := aItem.FieldByName['DSC_TMRC'].AsString;
  dmSysCtb.TypeCfop[Ord(ScrState)] := aItem;
  if Assigned(OnUpdateRow) then
    OnUpdateRow(Self, aItem);
end;

procedure TCdTipoCfop.SetDscTMrc(const Value: string);
begin
  eDsc_TMrc.Text := Value;
end;

procedure TCdTipoCfop.SetPkTipoCfop(const Value: integer);
begin
  ePk_Tipo_Cfop.AsInteger := Value;
end;

procedure TCdTipoCfop.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

end.
