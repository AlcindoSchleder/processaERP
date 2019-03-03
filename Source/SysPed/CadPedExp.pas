unit CadPedExp;

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
  Dialogs, StdCtrls, Mask, ToolEdit, CurrEdit, PrcCombo, TSysCad, TSysPed,
  CadModel;

type
  TCdPedExp = class(TfrmModel)
    lFk_Vw_Agentes: TStaticText;
    eFk_Vw_Agentes: TPrcComboBox;
    lNum_Pro_Forma: TStaticText;
    eNum_Pro_Forma: TCurrencyEdit;
    eFk_Portos__Emb: TPrcComboBox;
    lFk_Portos__Emb: TStaticText;
    lFk_Portos__Dst: TStaticText;
    eFk_Portos__Dst: TPrcComboBox;
  private
    FActiveOrder: TOrder;
    { Private declarations }
    function  GetFkVwAgent: Integer;
    procedure SetFkVwAgent(AValue: Integer);
    function  GetFkPortosEmb: Integer;
    procedure SetFkFkPortosEmb(AValue: Integer);
    function  GetFkPortosDst: Integer;
    procedure SetFkFkPortosDst(AValue: Integer);
    function  GetNumProForma: Integer;
    procedure SetNumProForma(AValue: Integer);
    procedure SetActiveOrder(const Value: TOrder);
  public
    { Public declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    property  ActiveOrder: TOrder  read FActiveOrder   write SetActiveOrder;
    property  FkVwAgent  : Integer read GetFkVwAgent   write SetFkVwAgent;
    property  FkPortosEmb: Integer read GetFkPortosEmb write SetFkFkPortosEmb;
    property  FkPortosDst: Integer read GetFkPortosDst write SetFkFkPortosDst;
    property  NumProForma: Integer read GetNumProForma write SetNumProForma;
  end;

implementation

{$R *.dfm}

uses mSysPed, TSysMan, TSysPedAux;

procedure TCdPedExp.LoadDefaults;
var
  aPkCntryDst,
  aPkCntryEmb: Integer;
begin
  aPkCntryEmb := 0;
  aPkCntryDst := 0;
  if ((ActiveOrder.FkMovement.FlagES = ioIn)  and (ActiveOrder.FkMovement.FlagDev)) or
     ((ActiveOrder.FkMovement.FlagES = ioOut) and (not ActiveOrder.FkMovement.FlagDev)) then
  begin
    aPkCntryEmb := ActiveOrder.FkCompany.FkCountry;
    aPkCntryDst := ActiveOrder.FkOwner.Address.FkCity.FkState.FkCountry.PkCountry;
  end;
  if ((ActiveOrder.FkMovement.FlagES = ioIn)  and (not ActiveOrder.FkMovement.FlagDev)) or
     ((ActiveOrder.FkMovement.FlagES = ioOut) and (ActiveOrder.FkMovement.FlagDev)) then
  begin
    aPkCntryEmb := ActiveOrder.FkOwner.Address.FkCity.FkState.FkCountry.PkCountry;
    aPkCntryDst := ActiveOrder.FkCompany.FkCountry;
  end;
  if (not ListLoaded) then
  begin
    eFk_Vw_Agentes.Items.AddStrings(dmSysPed.LoadAgents);
    eFk_Portos__Dst.Items.AddStrings(dmSysPed.LoadPorts(aPkCntryDst));
    eFk_Portos__Emb.Items.AddStrings(dmSysPed.LoadPorts(aPkCntryEmb));
  end;
end;

procedure TCdPedExp.MoveDataToControls;
begin
  FkVwAgent   := ActiveOrder.FkAgent.PkCadastros;
  FkPortosEmb := ActiveOrder.FkPortoEmb;
  FkPortosDst := ActiveOrder.FkPortoDst;
  NumProForma := ActiveOrder.NumProForma;
end;

procedure TCdPedExp.ClearControls;
begin
  FkVwAgent   := 0;
  FkPortosEmb := 0;
  FkPortosDst := 0;
  NumProForma := 0;
end;

procedure TCdPedExp.SaveIntoDB;
begin
  ActiveOrder.FkAgent.PkCadastros := FkVwAgent;
  ActiveOrder.FkPortoEmb          := FkPortosEmb;
  ActiveOrder.FkPortoDst          := FkPortosDst;
  ActiveOrder.NumProForma         := NumProForma; 
end;

function  TCdPedExp.GetFkVwAgent: Integer;
begin
  Result := eFk_Vw_Agentes.ItemIndex;
  if (Result > 0) and (eFk_Vw_Agentes.Items.Objects[Result] <> nil) then
    Result := Integer(eFk_Vw_Agentes.Items.Objects[Result]);
end;

procedure TCdPedExp.SetFkVwAgent(AValue: Integer);
begin
  eFk_Vw_Agentes.SetIndexFromIntegerValue(AValue);
end;

function  TCdPedExp.GetFkPortosEmb: Integer;
begin
  Result := eFk_Portos__Emb.ItemIndex;
  if (Result > 0) and (eFk_Portos__Emb.Items.Objects[Result] <> nil) then
    Result := Integer(eFk_Portos__Emb.Items.Objects[Result]);
end;

procedure TCdPedExp.SetFkFkPortosEmb(AValue: Integer);
begin
  eFk_Portos__Emb.SetIndexFromIntegerValue(AValue);
end;

function  TCdPedExp.GetFkPortosDst: Integer;
begin
  Result := eFk_Portos__Dst.ItemIndex;
  if (Result > 0) and (eFk_Portos__Dst.Items.Objects[Result] <> nil) then
    Result := Integer(eFk_Portos__Dst.Items.Objects[Result]);
end;

procedure TCdPedExp.SetFkFkPortosDst(AValue: Integer);
begin
  eFk_Portos__Dst.SetIndexFromIntegerValue(AValue);
end;

function  TCdPedExp.GetNumProForma: Integer;
begin
  Result := eNum_Pro_Forma.AsInteger;
end;

procedure TCdPedExp.SetNumProForma(AValue: Integer);
begin
  eNum_Pro_Forma.Value := AValue;
end;

procedure TCdPedExp.SetActiveOrder(const Value: TOrder);
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
