unit TSysBcCx;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 22/04/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
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
  SysUtils, Classes, TSysMan,
    {$IFDEF WIN32} Controls {$ENDIF} 
    {$IFDEF LINUX} QControls {$ENDIF};

type
// 0 ==> Outra
// 1 ==> Caixa
// 2 ==> Conta Bancária
// 3 ==> Conta Previsao
  TAccountType = (atOther, atCash, atBank, atPrevision);

  TTypeAccount = class (TPersistent)
  private
    FDscTAcc: string;
    FFlagTAcc: TAccountType;
    FPkTypeAccount: Integer;
    FTag: Integer;
    procedure SetDscTAcc(Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DscTAcc: string read FDscTAcc write SetDscTAcc;
    property FlagTAcc: TAccountType read FFlagTAcc write FFlagTAcc;
    property PkTypeAccount: Integer read FPkTypeAccount write FPkTypeAccount;
    property Tag: Integer read FTag write FTag;
  end;
  
  TAccount = class (TPersistent)
  private
    FDscAcc: string;
    FDtaAbr: TDate;
    FDtaFch: TDate;
    FDtaSld: TDate;
    FFkCompany: Integer;
    FFkTypeAccount: TTypeAccount;
    FLoading: Boolean;
    FPkContas: Integer;
    FSldAcc: Double;
    FSldIni: Double;
    FSldPrev: Double;
    procedure SetDscAcc(Value: string);
    procedure SetFkTypeAccount(Value: TTypeAccount);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DscAcc: string read FDscAcc write SetDscAcc;
    property DtaAbr: TDate read FDtaAbr write FDtaAbr;
    property DtaFch: TDate read FDtaFch write FDtaFch;
    property DtaSld: TDate read FDtaSld write FDtaSld;
    property FkCompany: Integer read FFkCompany write FFkCompany;
    property FkTypeAccount: TTypeAccount read FFkTypeAccount write 
            SetFkTypeAccount;
    property Loading: Boolean read FLoading write FLoading;
    property PkContas: Integer read FPkContas write FPkContas;
    property SldAcc: Double read FSldAcc write FSldAcc;
    property SldIni: Double read FSldIni write FSldIni;
    property SldPrev: Double read FSldPrev write FSldPrev;
  end;
  
  TBankAccount = class (TCollectionItem)
  private
    FCodCta: string;
    FFkAccount: TAccount;
    FFkCompany: TCompany;
    FFkTypeAccount: TTypeAccount;
    FNumCheck: Integer;
    FNumCtr: string;
    FNumIniT: Integer;
    FNumRem: Integer;
    FQtdCheck: Integer;
    FSldPrev: Double;
    FSldReal: Double;
    procedure SetCodCta(Value: string);
    procedure SetFkAccount(Value: TAccount);
    procedure SetFkCompany(Value: TCompany);
    procedure SetFkTypeAccount(Value: TTypeAccount);
    procedure SetNumCtr(Value: string);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property CodCta: string read FCodCta write SetCodCta;
    property FkAccount: TAccount read FFkAccount write SetFkAccount;
    property FkCompany: TCompany read FFkCompany write SetFkCompany;
    property FkTypeAccount: TTypeAccount read FFkTypeAccount write 
            SetFkTypeAccount;
    property NumCheck: Integer read FNumCheck write FNumCheck;
    property NumCtr: string read FNumCtr write SetNumCtr;
    property NumIniT: Integer read FNumIniT write FNumIniT;
    property NumRem: Integer read FNumRem write FNumRem;
    property QtdCheck: Integer read FQtdCheck write FQtdCheck;
    property SldPrev: Double read FSldPrev write FSldPrev;
    property SldReal: Double read FSldReal write FSldReal;
  published
    property Index;
  end;
  
  TBankAccounts = class (TCollection)
  private
    FItemIndex: Integer;
    FOwner: TPersistent;
    function GetItems(Index: Integer): TBankAccount;
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Index: Integer; Value: TBankAccount);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TBankAccount;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TBankAccount;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items[Index: Integer]: TBankAccount read GetItems write SetItems;
  published
    property Count;
  end;
  
  TAgency = class (TCollectionItem)
  private
    FBankAccounts: TBankAccounts;
    FDscAgency: string;
    FFkOwner: Integer;
    FPkAgency: string;
    procedure SetBankAccounts(Value: TBankAccounts);
    procedure SetDscAgency(Value: string);
    procedure SetPkAgency(Value: string);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property BankAccounts: TBankAccounts read FBankAccounts write 
            SetBankAccounts;
    property DscAgency: string read FDscAgency write SetDscAgency;
    property FkOwner: Integer read FFkOwner write FFkOwner;
    property PkAgency: string read FPkAgency write SetPkAgency;
  published
    property Index;
  end;
  
  TAgencies = class (TCollection)
  private
    FItemIndex: Integer;
    FOwner: TPersistent;
    function GetItems(Index: Integer): TAgency;
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Index: Integer; Value: TAgency);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TAgency;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TAgency;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items[Index: Integer]: TAgency read GetItems write SetItems;
  published
    property Count;
  end;
  
  TBank = class (TPersistent)
  private
    FAgencies: TAgencies;
    FcbIndex: Integer;
    FDscBank: string;
    FPkBank: Integer;
    function GetAccountIdx: Integer;
    function GetAgencyIdx: Integer;
    procedure SetAgencies(Value: TAgencies);
    procedure SetDscBank(Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property AccountIdx: Integer read GetAccountIdx;
    property Agencies: TAgencies read FAgencies write SetAgencies;
    property AgencyIdx: Integer read GetAgencyIdx;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscBank: string read FDscBank write SetDscBank;
    property PkBank: Integer read FPkBank write FPkBank;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TFinanceOperations = class (TPersistent)
  private
    FDscOpe: string;
    FFkOperationCR: Integer;
    FFkOperationDB: Integer;
    FFlagBaixa: Boolean;
    FFlagEst: Boolean;
    FFlagGSld: Boolean;
    FFlagTrf: Boolean;
    FPkOperation: Integer;
    procedure SetDscOpe(Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DscOpe: string read FDscOpe write SetDscOpe;
    property FkOperationCR: Integer read FFkOperationCR write FFkOperationCR;
    property FkOperationDB: Integer read FFkOperationDB write FFkOperationDB;
    property FlagBaixa: Boolean read FFlagBaixa write FFlagBaixa;
    property FlagEst: Boolean read FFlagEst write FFlagEst;
    property FlagGSld: Boolean read FFlagGSld write FFlagGSld;
    property FlagTrf: Boolean read FFlagTrf write FFlagTrf;
    property PkOperation: Integer read FPkOperation write FPkOperation;
  end;
  
  
implementation

{
********************************* TTypeAccount *********************************
}
constructor TTypeAccount.Create;
begin
  inherited Create;
  Clear;
end;

destructor TTypeAccount.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TTypeAccount.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TTypeAccount) then
  begin
    DscTAcc        := TTypeAccount(Source).DscTAcc;
    FFlagTAcc      := TTypeAccount(Source).FlagTAcc;
    FPkTypeAccount := TTypeAccount(Source).PkTypeAccount;
  end
  else
    inherited Assign(Source);
end;

procedure TTypeAccount.Clear;
begin
  FDscTAcc       := '';
  FFlagTAcc      := atCash;
  FPkTypeAccount := 0;
end;

procedure TTypeAccount.SetDscTAcc(Value: string);
begin
  FDscTAcc := Copy(Value, 1, 30);
end;

{
*********************************** TAccount ***********************************
}
constructor TAccount.Create;
begin
  inherited Create;
  FFkTypeAccount := TTypeAccount.Create;
  Clear;
end;

destructor TAccount.Destroy;
begin
  Clear;
  if Assigned(FFkTypeAccount) then
    FFkTypeAccount.Free;
  FFkTypeAccount := nil;
  inherited Destroy;
end;

procedure TAccount.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TAccount) then
  begin
    FLoading   := True;
    DscAcc     := TAccount(Source).DscAcc;
    FDtaAbr    := TAccount(Source).DtaAbr;
    FDtaFch    := TAccount(Source).DtaFch;
    FDtaSld    := TAccount(Source).DtaSld;
    FPkContas  := TAccount(Source).PkContas;
    FSldAcc    := TAccount(Source).SldAcc;
    FSldIni    := TAccount(Source).SldIni;
    FSldPrev   := TAccount(Source).SldPrev;
    FFkCompany := TAccount(Source).FkCompany;
    if Assigned(FFkTypeAccount) then
      FkTypeAccount := TAccount(Source).FkTypeAccount;
    FLoading := False;
  end
  else
    inherited Assign(Source);
end;

procedure TAccount.Clear;
begin
  FLoading   := True;
  FDscAcc    := '';
  FDtaAbr    := 0;
  FDtaFch    := 0;
  FDtaSld    := 0;
  FPkContas  := 0;
  FSldAcc    := 0.0;
  FSldIni    := 0.0;
  FSldPrev   := 0.0;
  FFkCompany := 0;
  if Assigned(FFkTypeAccount) then
    FFkTypeAccount.Clear;
  FLoading := False;
end;

procedure TAccount.SetDscAcc(Value: string);
begin
  FDscAcc := Copy(Value, 1, 50);
end;

procedure TAccount.SetFkTypeAccount(Value: TTypeAccount);
begin
  if (not Assigned(FFkTypeAccount)) then exit;
  if (Value = nil) then
    FFkTypeAccount.Clear
  else
    FFkTypeAccount.Assign(Value);
end;

{
********************************* TBankAccount *********************************
}
constructor TBankAccount.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFkAccount     := TAccount.Create;
  FFkCompany     := TCompany.Create;
  FFkTypeAccount := TTypeAccount.Create;
  Clear;
end;

destructor TBankAccount.Destroy;
begin
  Clear;
  if Assigned(FFkAccount) then
    FFkAccount.Free;
  if Assigned(FFkCompany) then
    FFkCompany.Free;
  if Assigned(FFkTypeAccount) then
    FFkTypeAccount.Free;
  FFkAccount     := nil;
  FFkCompany     := nil;
  FFkTypeAccount := nil;
  inherited Destroy;
end;

procedure TBankAccount.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TBankAccount) then
  begin
    CodCta    := TBankAccount(Source).CodCta;
    FNumCheck := TBankAccount(Source).NumCheck;
    NumCtr    := TBankAccount(Source).NumCtr;
    FNumIniT  := TBankAccount(Source).NumIniT;
    FNumRem   := TBankAccount(Source).NumRem;
    FQtdCheck := TBankAccount(Source).QtdCheck;
    FSldPrev  := TBankAccount(Source).SldPrev;
    FSldReal  := TBankAccount(Source).SldReal;
    if Assigned(FFkAccount) then
      FkAccount := TBankAccount(Source).FkAccount;
    if Assigned(FFkCompany) then
      FkCompany := TBankAccount(Source).FkCompany;
    if Assigned(FFkTypeAccount) then
      FkTypeAccount := TBankAccount(Source).FkTypeAccount;
  end
  else
    inherited Assign(Source);
end;

procedure TBankAccount.Clear;
begin
  CodCta    := '';
  FNumCheck := 0;
  FNumCtr   := '';
  FNumIniT  := 0;
  FNumRem   := 0;
  FQtdCheck := 0;
  FSldPrev  := 0.0;
  FSldReal  := 0.0;
  if Assigned(FFkAccount) then
    FFkAccount.Clear;
  if Assigned(FFkCompany) then
    FFkCompany.Clear;
  if Assigned(FFkTypeAccount) then
    FFkTypeAccount.Clear;
end;

function TBankAccount.GetDisplayName: string;
begin
  Result := CodCta;
  if (Result = '') then Result := inherited GetDisplayName;
end;

procedure TBankAccount.SetCodCta(Value: string);
begin
  FCodCta := Copy(Value, 1, 30);
end;

procedure TBankAccount.SetFkAccount(Value: TAccount);
begin
  if (not Assigned(FFkAccount)) then exit;
  if (Value = nil) then
    FFkAccount.Clear
  else
    FFkAccount.Assign(Value);
end;

procedure TBankAccount.SetFkCompany(Value: TCompany);
begin
  if (not Assigned(FFkCompany)) then exit;
  if (Value = nil) then
    FFkCompany.Clear
  else
    FFkCompany.Assign(Value);
end;

procedure TBankAccount.SetFkTypeAccount(Value: TTypeAccount);
begin
  if (not Assigned(FFkTypeAccount)) then exit;
  if (Value = nil) then
    FFkTypeAccount.Clear
  else
    FFkTypeAccount.Assign(Value);
end;

procedure TBankAccount.SetNumCtr(Value: string);
begin
  FNumCtr := Copy(Value, 1, 20);
end;

{
******************************** TBankAccounts *********************************
}
constructor TBankAccounts.Create(AOwner: TPersistent);
begin
  inherited Create(TBankAccount);
  FOwner := AOwner;
  Clear;
end;

destructor TBankAccounts.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TBankAccounts.Add: TBankAccount;
begin
  Result := inherited Add as TBankAccount;
  FItemIndex := Result.Index;
end;

procedure TBankAccounts.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if (Source <> nil) and (Source is TBankAccounts) then
  begin
    for i := 0 to Count - 1 do
      with Add do
        Assign(TBankAccounts(Source).Items[i]);
    FItemIndex := TBankAccounts(Source).ItemIndex;
  end
  else
    inherited Assign(Source)
end;

procedure TBankAccounts.Clear;
begin
  inherited Clear;
  FItemIndex := -1;
end;

procedure TBankAccounts.Delete(Index: Integer);
begin
  inherited Delete(Index);
  if (FItemIndex = Index) then
    FItemIndex := Count - 1;
end;

function TBankAccounts.GetItems(Index: Integer): TBankAccount;
begin
  Result := inherited Items[Index] as TBankAccount;
  FItemIndex := Index;
end;

function TBankAccounts.GetOwner: TPersistent;
begin
  if (FOwner = nil) then
    Result := inherited GetOwner
  else
    Result := FOwner
end;

function TBankAccounts.Insert(Index: Integer): TBankAccount;
begin
  Result := inherited Insert(Index) as TBankAccount;
  FItemIndex := Result.Index;
end;

procedure TBankAccounts.SetItemIndex(Value: Integer);
begin
  if (Value <> FItemIndex) and (Value < Count) then
    FItemIndex := Value;
end;

procedure TBankAccounts.SetItems(Index: Integer; Value: TBankAccount);
begin
  inherited Items[Index] := Value;
  FItemIndex := Index;
end;

{
*********************************** TAgency ************************************
}
constructor TAgency.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  BankAccounts := TBankAccounts.Create(Self);
  Clear;
end;

destructor TAgency.Destroy;
begin
  Clear;
  if Assigned(FBankAccounts) then
    FBankAccounts.Free;
  FBankAccounts := nil;
  inherited Destroy;
end;

procedure TAgency.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TAgency) then
  begin
    BankAccounts := TAgency(Source).BankAccounts;
    DscAgency    := TAgency(Source).DscAgency;
    PkAgency     := TAgency(Source).PkAgency;
    FFkOwner     := TAgency(Source).FkOwner;
  end
  else
    inherited Assign(Source);
end;

procedure TAgency.Clear;
begin
  FBankAccounts.Clear;
  FDscAgency := '';
  FPkAgency  := '';
  FFkOwner   := 0;
end;

function TAgency.GetDisplayName: string;
begin
  Result := FDscAgency;
  if (Result = '') then Result := inherited GetDisplayName;
end;

procedure TAgency.SetBankAccounts(Value: TBankAccounts);
begin
  FBankAccounts.Clear;
  if (Value <> nil) then
    FBankAccounts.Assign(Value);
end;

procedure TAgency.SetDscAgency(Value: string);
begin
  FDscAgency := Copy(Value, 1, 50);
end;

procedure TAgency.SetPkAgency(Value: string);
begin
  FPkAgency := Copy(Value, 1, 20);
end;

{
********************************** TAgencies ***********************************
}
constructor TAgencies.Create(AOwner: TPersistent);
begin
  inherited Create(TAgency);
  FItemIndex := -1;
  FOwner := AOwner;
  Clear;
end;

destructor TAgencies.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TAgencies.Add: TAgency;
begin
  Result := inherited Add as TAgency;
  FItemIndex := Result.Index;
end;

procedure TAgencies.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if (Source <> nil) and (Source is TAgencies) then
  begin
    for i := 0 to Count - 1 do
      with Add do
        Assign(TAgencies(Source).Items[i]);
    FItemIndex := TAgencies(Source).ItemIndex;
  end
  else
    inherited Assign(Source)
end;

procedure TAgencies.Clear;
begin
  inherited Clear;
  FItemIndex := -1;
end;

procedure TAgencies.Delete(Index: Integer);
begin
  inherited Delete(Index);
  if (FItemIndex = Index) then
    FItemIndex := Count - 1;
end;

function TAgencies.GetItems(Index: Integer): TAgency;
begin
  Result := inherited Items[Index] as TAgency;
  FItemIndex := Index;
end;

function TAgencies.GetOwner: TPersistent;
begin
  if (FOwner = nil) then
    Result := inherited GetOwner
  else
    Result := FOwner
end;

function TAgencies.Insert(Index: Integer): TAgency;
begin
  Result := inherited Insert(Index) as TAgency;
  FItemIndex := Result.Index;
end;

procedure TAgencies.SetItemIndex(Value: Integer);
begin
  if (Value <> FItemIndex) and (Value < Count) then
    FItemIndex := Value;
end;

procedure TAgencies.SetItems(Index: Integer; Value: TAgency);
begin
  inherited Items[Index] := Value;
  FItemIndex := Index;
end;

{
************************************ TBank *************************************
}
constructor TBank.Create;
begin
  inherited Create;
  FAgencies := TAgencies.Create(Self);
  Clear;
end;

destructor TBank.Destroy;
begin
  Clear;
  if Assigned(FAgencies) then
    FAgencies.Free;
  FAgencies := nil;
  inherited Destroy;
end;

procedure TBank.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TBank) then
  begin
    FPkBank  := TBank(Source).PkBank;
    DscBank  := TBank(Source).DscBank;
    cbIndex  := TBank(Source).cbIndex;
    if Assigned(FAgencies) then
    begin
      FAgencies.Clear;
      Agencies := TBank(Source).Agencies;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TBank.Clear;
begin
  FPkBank  := 0;
  FDscBank := '';
  cbIndex  := 0;
  if Assigned(FAgencies) then
    FAgencies.Clear;
end;

function TBank.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkBank) then
    Result := FcbIndex;
end;

function TBank.GetAccountIdx: Integer;
begin
  Result := -1;
  if (AgencyIdx > -1) and (AgencyIdx < FAgencies.Count) then
    Result := FAgencies.Items[AgencyIdx].BankAccounts.ItemIndex;
end;

function TBank.GetAgencyIdx: Integer;
begin
  Result := FAgencies.ItemIndex;
end;

function TBank.GetPkValue: Variant;
begin
  Result := FPkBank;
end;

procedure TBank.SetAgencies(Value: TAgencies);
begin
  if (not Assigned(FAgencies)) then exit;
  if (Value = nil) then
    FAgencies.Clear
  else
    FAgencies.Assign(Value);
end;

procedure TBank.SetDscBank(Value: string);
begin
  FDscBank := Copy(Value, 1, 50);
end;

{
****************************** TFinanceOperations ******************************
}
constructor TFinanceOperations.Create;
begin
  inherited Create;
  Clear;
end;

destructor TFinanceOperations.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TFinanceOperations.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TFinanceOperations) then
  begin
    FDscOpe     := TFinanceOperations(Source).DscOpe;
    FFlagBaixa  := TFinanceOperations(Source).FlagBaixa;
    FFlagEst    := TFinanceOperations(Source).FlagEst;
    FFlagGSld   := TFinanceOperations(Source).FlagGSld;
    FlagTrf     := TFinanceOperations(Source).FlagTrf;
    PkOperation := TFinanceOperations(Source).PkOperation;
  end
  else
    inherited Assign(Source);
end;

procedure TFinanceOperations.Clear;
begin
  FDscOpe     := '';
  FFlagBaixa  := False;
  FFlagEst    := False;
  FFlagGSld   := False;
  FlagTrf     := False;
  PkOperation := 0;
end;

procedure TFinanceOperations.SetDscOpe(Value: string);
begin
  FDscOpe := Copy(Value, 1, 30);
end;


end.
