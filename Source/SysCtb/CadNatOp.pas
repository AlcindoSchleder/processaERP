unit CadNatOp;

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
  Dialogs, CadModel, StdCtrls, ProcUtils;

type
  TCdNatOper = class(TfrmModel)
    lPk_Natureza_Operacoes: TStaticText;
    ePk_Natureza_Operacoes: TEdit;
    lDsc_NtOp: TStaticText;
    eDsc_NtOp: TEdit;
    lCod_Cfop: TStaticText;
    eCod_Cfop: TEdit;
    lCmpl_Cfop: TStaticText;
    eCmpl_Cfop: TEdit;
    lFk_Financeiro_Contas: TStaticText;
    eFk_Financeiro_Contas: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure eFk_Financeiro_ContasDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    FFkTypeCfop: Integer;
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function  GetCmplCfop: string;
    function  GetCodCfop: string;
    function  GetDscNtOp: string;
    function  GetPkNatOper: Integer;
    procedure SetCmplCfop(const Value: string);
    procedure SetCodCfop(const Value: string);
    procedure SetDscNtOp(const Value: string);
    procedure SetFkTypeCfop(const Value: Integer);
    procedure SetPkNatOper(const Value: Integer);
    function GetFkAccount: Integer;
    procedure SetFkAccount(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
    property  PkNatOper : Integer read GetPkNatOper write SetPkNatOper;
    property  DscNtOp   : string  read GetDscNtOp   write SetDscNtOp;
    property  CodCfop   : string  read GetCodCfop   write SetCodCfop;
    property  CmplCfop  : string  read GetCmplCfop  write SetCmplCfop;
    property  FkAccount : Integer read GetFkAccount write SetFkAccount;
  public
    { Public declarations }
    property  FkTypeCfop: Integer read FFkTypeCfop  write SetFkTypeCfop;
  end;

implementation

uses Dado, mSysCtb, GridRow, TSysFatAux;

{$R *.dfm}

{ TCdNatOper }

function TCdNatOper.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  S := '';
  C := nil;
  Result := True;
  if (DscNtOp = '') then
  begin
    C := eDsc_NtOp;
    S := 'Campo Descrição deve conter um valor';
  end;
  if (CodCfop = '') then
  begin
    C := eCod_Cfop;
    S := 'Campo Código da Cfop deve conter um valor';
  end;
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdNatOper.ClearControls;
begin
  Loading := True;
  try
    PkNatOper := 0;
    DscNtOp   := '';
    CodCfop   := '';
    CmplCfop  := '001';
  finally
    Loading := False;
  end;
end;

function TCdNatOper.GetCmplCfop: string;
begin
  Result := eCmpl_Cfop.Text;
end;

function TCdNatOper.GetCodCfop: string;
begin
  Result := eCod_Cfop.Text;
end;

function TCdNatOper.GetDscNtOp: string;
begin
  Result := eDsc_NtOp.Text;
end;

function TCdNatOper.GetPkNatOper: Integer;
begin
  Result := StrToIntDef(ePk_Natureza_Operacoes.Text, 0);
end;

procedure TCdNatOper.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Financeiro_Contas.Items.AddStrings(dmSysCtb.LoadFinanceAccounts(-1));
    ListLoaded := True;
  end;
end;

procedure TCdNatOper.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysCtb.NatOperator[Pk] do
    begin
      PkNatOper := Pk;
      DscNtOp   := FieldByName['DSC_NTOP'].AsString;
      CodCfop   := FieldByName['COD_CFOP'].AsString;
      CmplCfop  := FieldByName['CMPL_CFOP'].AsString;
      FkAccount := FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger;
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdNatOper.SaveIntoDB;
var
  aItem: TDataRow;
begin
  aItem     := dmSysCtb.NatOperator[0];
  aItem.FieldByName['FK_TIPO_CFOP'].AsInteger          := FFkTypeCfop;
  aItem.FieldByName['PK_NATUREZA_OPERACOES'].AsInteger := PkNatOper;
  aItem.FieldByName['DSC_NTOP'].AsString  := DscNtOp;
  aItem.FieldByName['COD_CFOP'].AsString  := CodCfop;
  aItem.FieldByName['CMPL_CFOP'].AsString := CmplCfop;
  aItem.FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger := FkAccount;
  dmSysCtb.NatOperator[Ord(ScrState)] := aItem;
  if Assigned(OnUpdateRow) then
    OnUpdateRow(Self, aItem);
end;

procedure TCdNatOper.SetCmplCfop(const Value: string);
begin
  eCmpl_Cfop.Text := Value;
end;

procedure TCdNatOper.SetCodCfop(const Value: string);
begin
  eCod_Cfop.Text := Value;
end;

procedure TCdNatOper.SetDscNtOp(const Value: string);
begin
  eDsc_NtOp.Text := Value;
end;

procedure TCdNatOper.SetFkTypeCfop(const Value: Integer);
begin
  FFkTypeCfop := Value;
  dmSysCtb.FkTypeCfop := Value;
end;

procedure TCdNatOper.SetPkNatOper(const Value: Integer);
begin
  ePk_Natureza_Operacoes.Text := IntToStr(Value);
end;

procedure TCdNatOper.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

procedure TCdNatOper.eFk_Financeiro_ContasDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aClass : TClassification;
  aColor : TColor;
  aOffSet: Integer;
  aStr   ,
  aItmStr: string;
begin
  if (Index > TComboBox(Control).Items.Count) or
     (TComboBox(Control).Items.Objects[Index] = nil) or
     (not (TComboBox(Control).Items.Objects[Index] is TClassification)) then
  begin
    TComboBox(Control).Canvas.TextOut(Rect.Left, Rect.Top,
      TComboBox(Control).Items.Strings[Index]);
    TComboBox(Control).Canvas.Brush.Style := bsClear;
    TComboBox(Control).Canvas.DrawFocusRect(Rect);
    TComboBox(Control).Canvas.FrameRect(Rect);
    exit;
  end;
  aClass  := TClassification(TComboBox(Control).Items.Objects[Index]);
  aColor  := clGray;
  aOffSet := aClass.NivCta * 10;
  if aClass.FlagAnlSnt then
    aColor  := clWindowText;
  with (Control as TComboBox).Canvas do
  begin
    if (odSelected in State) then
      Font.Color := clWhite
    else
      Font.Color := aColor;
    aStr       := TComboBox(Control).Items.Strings[Index];
    aItmStr    := Copy(aStr, 1, Pos('|', aStr) - 1);
    Delete(aStr, 1, Pos('|', aStr));
    if ((TextWidth(Trim(aItmStr)) + Rect.Left + aOffSet) > (Rect.Left + 200)) then
    begin
      while ((TextWidth(Trim(aItmStr) + '...') + Rect.Left + aOffSet) > (Rect.Left + 200)) do
        Delete(aItmStr, Length(aItmStr), 1);
      aItmStr := aItmStr + '...'
    end;
    TextOut(Rect.Left + aOffSet, Rect.Top + 1, aItmStr);
    TextOut(Rect.Left + 200, Rect.Top + 1, aStr);
    if (odSelected in State) or
       (odFocused  in State) or
       (odHotLight in State) then
    begin
      TComboBox(Control).Canvas.Brush.Style := bsClear;
      TComboBox(Control).Canvas.DrawFocusRect(Rect);
      TComboBox(Control).Canvas.FrameRect(Rect);
    end;
  end;
end;

function TCdNatOper.GetFkAccount: Integer;
begin
  with eFk_Financeiro_Contas do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
  end;
end;

procedure TCdNatOper.SetFkAccount(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Financeiro_Contas do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (TClassification(Items.Objects[i]).Pk = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

end.
