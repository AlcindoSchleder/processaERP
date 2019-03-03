unit CadPrdPrch;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/03/2006                                                   *}
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
  Dialogs, CadModel, ComCtrls, ToolWin, VirtualTrees, ExtCtrls, StdCtrls,
  Mask, ToolEdit, CurrEdit, TSysEstq, TSysConfAux, ProcType, ProcUtils, GridRow,
  TSysEstqAux;

type
  TfmPrdPurchase = class(TfrmModel)
    lFk_Tipo_Acabamentos: TStaticText;
    eFk_Tipo_Acabamentos: TComboBox;
    lFk_Tipo_Referencias: TStaticText;
    eFk_Tipo_Referencias: TComboBox;
    lVlr_Unit: TStaticText;
    eVlr_Unit: TCurrencyEdit;
    lFlag_Emp: TCheckBox;
    lFlag_Cmpr: TCheckBox;
    procedure eFk_Tipo_AcabamentosSelect(Sender: TObject);
  private
    function  GetFlagCmpr: Boolean;
    function  GetFlagEmp: Boolean;
    function  GetTypeFinish: Integer;
    function  GetTypeReference: Integer;
    function  GetVlrUnit: Double;
    procedure LoadFinish;
    procedure SetFlagCmpr(const Value: Boolean);
    procedure SetFlagEmp(const Value: Boolean);
    procedure SetTypeFinish(const Value: Integer);
    procedure SetTypeReference(const Value: Integer);
    procedure SetVlrUnit(const Value: Double);
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  FkTypeFinish   : Integer read GetTypeFinish    write SetTypeFinish;
    property  FkTypeReference: Integer read GetTypeReference write SetTypeReference;
    property  VlrUnit        : Double  read GetVlrUnit       write SetVlrUnit;
    property  FlagEmp        : Boolean read GetFlagEmp       write SetFlagEmp;
    property  FlagCmpr       : Boolean read GetFlagCmpr      write SetFlagCmpr;
  end;

var
  fmPrdPurchase: TfmPrdPurchase;

implementation

uses Funcoes, FuncoesDB, mSysEstq, Dado, EstqArqSql;

{$R *.dfm}

procedure TfmPrdPurchase.ClearControls;
begin
  Loading := True;
  try
    FkTypeFinish    := 0;
    FkTypeReference := 0;
    VlrUnit         := 0;
    FlagEmp         := False;
    FlagCmpr        := False;
  finally
    Loading := False;
  end;
end;

function TfmPrdPurchase.GetFlagCmpr: Boolean;
begin
  Result := lFlag_Cmpr.Checked;
end;

function TfmPrdPurchase.GetFlagEmp: Boolean;
begin
  Result := lFlag_Emp.Checked;
end;

function TfmPrdPurchase.GetTypeFinish: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  with eFk_Tipo_Acabamentos do
  begin
    aIdx := ItemIndex;
    if (aIdx > -1) and (Items.Objects[aIdx] <> nil) then
      Result := TFinishType(Items.Objects[aIdx]).PkFinishType;
  end;
end;

function TfmPrdPurchase.GetTypeReference: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  with eFk_Tipo_Referencias do
  begin
    aIdx := ItemIndex;
    if (aIdx > -1) and (Items.Objects[aIdx] <> nil) then
      Result := TReferenceType(Items.Objects[aIdx]).PkReferenceType;
  end;
end;

function TfmPrdPurchase.GetVlrUnit: Double;
begin
  Result := eVlr_Unit.Value;
end;

procedure TfmPrdPurchase.LoadDefaults;
begin
  if not ListLoaded then
  begin
    LoadFinish;
    ListLoaded := True;
  end;
end;

procedure TfmPrdPurchase.LoadFinish;
begin
  ReleaseCombos(eFk_Tipo_Acabamentos, toObject);
  eFk_Tipo_Acabamentos.Items.AddStrings(dmSysEstq.LoadTypeFinishes);
end;

procedure TfmPrdPurchase.MoveDataToControls;
var
  aPrd: TProductPurchase;
begin
  Loading := True;
  aPrd              := dmSysEstq.GetProductPurchase(Pk);
  try
    FkTypeFinish    := aPrd.FkReferenceType.FkFinishType.PkFinishType;
    FkTypeReference := aPrd.FkReferenceType.PkReferenceType;
    VlrUnit         := aPrd.VlrUnit;
    FlagEmp         := aPrd.FlagEmp;
    FlagCmpr        := aPrd.FlagCmpr;
  finally
    FreeAndNil(aPrd);
    Loading := False;
  end;
end;

procedure TfmPrdPurchase.SaveIntoDB;
var
  aPrd: TProductPurchase;
begin
  // save data into database
  aPrd := TProductPurchase.Create(nil);
  try
    aPrd.FkReferenceType.PkReferenceType           := FkTypeReference;
    aPrd.FkReferenceType.FkFinishType.PkFinishType := FkTypeFinish;
    aPrd.VlrUnit  := VlrUnit;
    aPrd.FlagCmpr := FlagCmpr;
    aPrd.FlagEmp  := FlagEmp;
    dmSysEstq.UpdateProductPurchase(Pk, aPrd, ScrState);
  finally
    FreeAndNil(aPrd);
  end;
end;

procedure TfmPrdPurchase.SetFlagCmpr(const Value: Boolean);
begin
  lFlag_Cmpr.Checked := Value;
end;

procedure TfmPrdPurchase.SetFlagEmp(const Value: Boolean);
begin
  lFlag_Emp.Checked := Value;
end;

procedure TfmPrdPurchase.SetTypeFinish(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Acabamentos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (TFinishType(Items.Objects[i]).PkFinishType = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TfmPrdPurchase.SetTypeReference(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Referencias do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (TReferenceType(Items.Objects[i]).PkReferenceType = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TfmPrdPurchase.SetVlrUnit(const Value: Double);
begin
  eVlr_Unit.Value := Value;
end;

procedure TfmPrdPurchase.eFk_Tipo_AcabamentosSelect(Sender: TObject);
var
  aIdx: Integer;
  aObj: TPersistent;
begin
  ChangeGlobal(Sender);
  aIdx := eFk_Tipo_Acabamentos.ItemIndex;
  if (aIdx = -1) then exit;
  if (eFk_Tipo_Acabamentos.Items.Objects[aIdx] <> nil) then
  begin
    aObj := TPersistent(eFk_Tipo_Acabamentos.Items.Objects[aIdx]);
    if (aObj is TFinishType) then
    begin
      ReleaseCombos(eFk_Tipo_Referencias, toObject);
      eFk_Tipo_Referencias.Items.AddStrings(dmSysEstq.LoadTypeReferences(TFinishType(aObj)));
    end;
  end;
end;

end.
