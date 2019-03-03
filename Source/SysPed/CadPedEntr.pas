unit CadPedEntr;

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
  Dialogs, CadModel, Mask, ToolEdit, CurrEdit, TSysCadAux, StdCtrls, TSysPed,
  PrcCombo;

type
  TCdPedEntr = class(TfrmModel)
    eMun_Entr: TPrcComboBox;
    lMun_Entr: TStaticText;
    lUf_Entr: TStaticText;
    eUf_Entr: TPrcComboBox;
    lEnd_Entr: TStaticText;
    eEnd_Entr: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eUf_EntrSelect(Sender: TObject);
  private
    { Private declarations }
    FOwnerCountry: TCountry;
    FActiveOrder: TOrder;
    function  GetEndEntr: TStrings;
    procedure SetEndEntr(AValue: TStrings);
    function  GetMunEntr: Integer;
    procedure SetMunEntr(AValue: Integer);
    procedure SetOwnerCountry(AValue: TCountry);
    function  GetUfEntr: string;
    procedure SetUfEntr(AValue: string);
    procedure SetActiveOrder(const Value: TOrder);
  public
    { Public declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    property  ActiveOrder : TOrder   read FActiveOrder  write SetActiveOrder;
    property  EndEntr     : TStrings read GetEndEntr    write SetEndEntr;
    property  MunEntr     : Integer  read GetMunEntr    write SetMunEntr;
    property  OwnerCountry: TCountry read FOwnerCountry write SetOwnerCountry;
    property  UfEntr      : string   read GetUfEntr     write SetUfEntr;
  end;

implementation

{$R *.dfm}

uses mSysPed, ProcUtils;

procedure TCdPedEntr.FormCreate(Sender: TObject);
begin
  inherited;
  FOwnerCountry := TCountry.Create
end;

procedure TCdPedEntr.FormDestroy(Sender: TObject);
begin
  FOwnerCountry.Free;
  FOwnerCountry := nil;
  eUf_Entr.ReleaseObjects;
  eMun_Entr.ReleaseObjects;
  inherited;
end;

procedure TCdPedEntr.LoadDefaults;
begin
  MoveDataToControls;
end;

procedure TCdPedEntr.MoveDataToControls;
begin
  UfEntr  := ActiveOrder.UfEntr;
  MunEntr := ActiveOrder.MunEntr;
  EndEntr := ActiveOrder.EndEntr;
end;

procedure TCdPedEntr.ClearControls;
begin
  UfEntr  := '';
  MunEntr := 0;
  EndEntr := nil;
end;

procedure TCdPedEntr.SaveIntoDB;
begin
  ActiveOrder.UfEntr  := UfEntr;
  ActiveOrder.MunEntr := MunEntr;
  ActiveOrder.EndEntr := EndEntr;
end;

function  TCdPedEntr.GetEndEntr: TStrings;
begin
  Result := eEnd_Entr.Lines;
end;

procedure TCdPedEntr.SetEndEntr(AValue: TStrings);
begin
  if Assigned(AValue) then
    eEnd_Entr.Lines.Assign(AValue)
  else
    eEnd_Entr.Lines.Clear;
end;

function  TCdPedEntr.GetMunEntr: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eMun_Entr.ItemIndex;
  if (aIdx > 0) and (eMun_Entr.Items.Objects[aIdx] <> nil) then
    Result := TCountry(eMun_Entr.Items.Objects[aIdx]).PKCountry;
end;

procedure TCdPedEntr.SetMunEntr(AValue: Integer);
begin
  eMun_Entr.SetIndexFromIntegerValue(AValue);
end;

procedure TCdPedEntr.SetOwnerCountry(AValue: TCountry);
begin
  if (AValue = nil) then
    eUf_Entr.ReleaseObjects
  else
    eUf_Entr.Items.AddStrings(dmSysPed.LoadStates(AValue));
end;

function  TCdPedEntr.GetUfEntr: string;
var
  aIdx: Integer;
begin
  Result := '';
  aIdx := eUf_Entr.ItemIndex;
  if (aIdx > 0) and (eUf_Entr.Items.Objects[aIdx] <> nil) then
    Result := TState(eUf_Entr.Items.Objects[aIdx]).PkState;
end;

procedure TCdPedEntr.SetUfEntr(AValue: string);
begin
  eUf_Entr.SetIndexFromObjectValue(AValue);
end;

procedure TCdPedEntr.eUf_EntrSelect(Sender: TObject);
var
  aIdx: Integer;
begin
  ChangeGlobal(Sender);
  if (ScrState in LOADING_MODE) then exit;
  aIdx := eUf_Entr.ItemIndex;
  if (Aidx > 0) and (eUf_Entr.Items.Objects[aIdx] <> nil) then
    eMun_Entr.Items.AddStrings(dmSysPed.LoadCities(TState(eUf_Entr.Items.Objects[aIdx])));
end;

procedure TCdPedEntr.SetActiveOrder(const Value: TOrder);
begin
  FActiveOrder.Clear;
  if (Value <> nil) then
  begin
    FActiveOrder.Assign(Value);
    if FActiveOrder.PkOrder > 0 then
      Pk := FActiveOrder.PkOrder;
  end;
end;

end.
