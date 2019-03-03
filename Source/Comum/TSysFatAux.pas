unit TSysFatAux;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 22/04/2003 - DD/MM/YYYY                                    *}
{* Modified :            - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : (alcindo@sistemaprocessa.com.br)                           *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  SysUtils, Classes, PrcSysTypes, TSysBcCx;

type
  TAccountNat = (anActive, anPassive, anIncome, anExpense, anARE);
  
  TClassification = class (TSysProc)
  private
    FDscClass: string;
    FFkAccountPlan: Integer;
    FFkFinanceAccount: Integer;
    FFlagAnlSnt: Boolean;
    FFlagID: TAccountType;
    FFlagTCta: TAccountNat;
    FMaskCta: string;
    FNivCta: Integer;
    FSeqCta: Integer;
    procedure SetDscClass(Value: string);
  protected
    procedure AssignFields(Source: TPersistent); override;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Clear; override;
    function GetFields: TStrings; override;
    property DscClass: string read FDscClass write SetDscClass;
    property FkAccountPlan: Integer read FFkAccountPlan write FFkAccountPlan;
    property FkFinanceAccount: Integer read FFkFinanceAccount write 
            FFkFinanceAccount;
    property FlagAnlSnt: Boolean read FFlagAnlSnt write FFlagAnlSnt;
    property FlagID: TAccountType read FFlagID write FFlagID;
    property FlagTCta: TAccountNat read FFlagTCta write FFlagTCta;
    property MaskCta: string read FMaskCta write FMaskCta;
    property NivCta: Integer read FNivCta write FNivCta;
    property SeqCta: Integer read FSeqCta write FSeqCta;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
    property cbIndex;
    property Pk;
  end;
  

implementation

{
******************************* TClassification ********************************
}
constructor TClassification.Create;
begin
  inherited Create(TClassification);
end;

destructor TClassification.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TClassification.AssignFields(Source: TPersistent);
begin
  DscClass         := TClassification(Source).DscClass;
  FkAccountPlan    := TClassification(Source).FkAccountPlan;
  FkFinanceAccount := TClassification(Source).FkFinanceAccount;
  FlagAnlSnt       := TClassification(Source).FlagAnlSnt;
  FlagTCta         := TClassification(Source).FlagTCta;
  FlagID           := TClassification(Source).FlagID;
  MaskCta          := TClassification(Source).MaskCta;
  NivCta           := TClassification(Source).NivCta;
  PK               := TClassification(Source).Pk;
  SeqCta           := TClassification(Source).SeqCta;
end;

procedure TClassification.Clear;
begin
  DscClass         := '';
  FkAccountPlan    := 0;
  FkFinanceAccount := 0;
  FlagAnlSnt       := False;
  FlagTCta         := anActive;
  FlagID           := atOther;
  MaskCta          := '';
  NivCta           := 0;
  Pk               := 0;
  SeqCta           := 0;
end;

function TClassification.ComparePk(const AValue: Variant): Integer;
begin
  Result := inherited ComparePk(AValue);
end;

function TClassification.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('DSC_CTA');
  if (FkAccountPlan > 0) then
    Result.Add('FK_PLANO_CONTAS');
  Result.Add('FK_FINANCEIRO_CONTAS');
  Result.Add('FLAG_ANL_SNT');
  Result.Add('FLAG_ID');
  Result.Add('FLAG_TCTA');
  Result.Add('MASK_CTA');
  Result.Add('NIV_CTA');
  Result.Add('SEQ_CTA');
end;

function TClassification.GetPkValue: Variant;
begin
  Result := inherited GetPkValue;
end;

procedure TClassification.SetDscClass(Value: string);
begin
  FDscClass := Copy(Value, 1, 50);
end;


end.
