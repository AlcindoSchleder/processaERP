unit TSysManAux;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 22/04/2003 - DD/MM/YYYY                                    *}
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

uses SysUtils, Classes, TSysMan, TSysCad, TSysGen, TypInfo, PrcSysTypes, 
  ProcUtils, GridRow, 
{$IFDEF WIN32}
  ComCtrls, Forms, Controls, Dialogs
{$ELSE}
  QComCtrls, QForms, QControls, QDialogs
{$ENDIF};

type
  TPageClass = class of TForm;
  
  TModule = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscMod: string;
    FFkLanguage: TLanguage;
    FPkModule: Integer;
    FVer1: Byte;
    FVer2: Byte;
    FVer3: Byte;
    FVer4: Byte;
    FVersao: string;
    function GetPkLanguage: string;
    procedure SetDscMod(AValue: string);
    procedure SetFkLanguage(AValue: TLanguage);
    procedure SetPkLanguage(Value: string);
    procedure SetVer1(AValue: Byte);
    procedure SetVer2(AValue: Byte);
    procedure SetVer3(AValue: Byte);
    procedure SetVer4(AValue: Byte);
    procedure SetVersao(AValue: string);
    procedure SetVersion;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscMod: string read FDscMod write SetDscMod;
    property FkLanguage: TLanguage read FFkLanguage write SetFkLanguage;
    property PkLanguage: string read GetPkLanguage write SetPkLanguage;
    property PkModule: Integer read FPkModule write FPkModule;
    property Ver1: Byte read FVer1 write SetVer1;
    property Ver2: Byte read FVer2 write SetVer2;
    property Ver3: Byte read FVer3 write SetVer3;
    property Ver4: Byte read FVer4 write SetVer4;
    property Versao: string read FVersao write SetVersao;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TRotine = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscRot: string;
    FFkLanguage: TLanguage;
    FPkRotina: Integer;
    procedure SetDscRot(AValue: string);
    procedure SetFkLanguage(AValue: TLanguage);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscRot: string read FDscRot write SetDscRot;
    property FkLanguage: TLanguage read FFkLanguage write SetFkLanguage;
    property PkRotina: Integer read FPkRotina write FPkRotina;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TProgramParam = class (TCollectionItem)
  private
    FDscParam: string;
    FNomProp: string;
    FValProp: string;
    procedure SetDscParam(AValue: string);
    procedure SetNomProp(AValue: string);
    procedure SetValProp(AValue: string);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property DscParam: string read FDscParam write SetDscParam;
    property Index;
    property NomProp: string read FNomProp write SetNomProp;
    property ValProp: string read FValProp write SetValProp;
  end;
  
  TProgramParams = class (TCollection)
  private
    FOwner: TPersistent;
    function GetItems(Index: Integer): TProgramParam;
    procedure SetItems(Index: Integer; AValue: TProgramParam);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TProgramParam;
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TProgramParam;
    property Count;
    property Items[Index: Integer]: TProgramParam read GetItems write SetItems;
  end;
  
  TProgram = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscPrg: string;
    FFkLanguage: TLanguage;
    FFkModulo: TModule;
    FFkReport: Integer;
    FFKRotina: TRotine;
    FFlagRel: Boolean;
    FFlagVis: Boolean;
    FNomForm: string;
    FNomLib: string;
    FPkProgram: Integer;
    FProgramParams: TProgramParams;
    function GetPkLanguage: string;
    function GetPkModule: Integer;
    function GetPkRotine: Integer;
    procedure SetDscPrg(AValue: string);
    procedure SetFkLanguage(AValue: TLanguage);
    procedure SetFkModulo(AValue: TModule);
    procedure SetFKRotina(AValue: TRotine);
    procedure SetNomForm(AValue: string);
    procedure SetNomLib(AValue: string);
    procedure SetPkLanguage(const Value: string);
    procedure SetPkModule(Value: Integer);
    procedure SetPkRotine(Value: Integer);
    procedure SetProgramParams(AValue: TProgramParams);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscPrg: string read FDscPrg write SetDscPrg;
    property FkLanguage: TLanguage read FFkLanguage write SetFkLanguage;
    property FkModulo: TModule read FFkModulo write SetFkModulo;
    property FkReport: Integer read FFkReport write FFkReport;
    property FKRotina: TRotine read FFKRotina write SetFKRotina;
    property FlagRel: Boolean read FFlagRel write FFlagRel default False;
    property FlagVis: Boolean read FFlagVis write FFlagVis default True;
    property NomForm: string read FNomForm write SetNomForm;
    property NomLib: string read FNomLib write SetNomLib;
    property PkLanguage: string read GetPkLanguage write SetPkLanguage;
    property PkModule: Integer read GetPkModule write SetPkModule;
    property PkProgram: Integer read FPkProgram write FPkProgram default 0;
    property PkRotine: Integer read GetPkRotine write SetPkRotine;
    property ProgramParams: TProgramParams read FProgramParams write 
            SetProgramParams;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TOperator = class (TPersistent)
  private
    FcbIndex: Integer;
    FDsctMax: Double;
    FeMailOpe: string;
    FFkCompany: TCompany;
    FFkLanguage: TLanguage;
    FFkOwner: Integer;
    FFlagBrw: Boolean;
    FFlagDel: Boolean;
    FFlagFnd: Boolean;
    FFlagIns: Boolean;
    FFlagLSen: Boolean;
    FFlagUpd: Boolean;
    FPkOperator: string;
    FSenNet: string;
    procedure SetDsctMax(AValue: Double);
    procedure SeteMailOpe(AValue: string);
    procedure SetFkCompany(AValue: TCompany);
    procedure SetFkLanguage(AValue: TLanguage);
    procedure SetPkOperator(AValue: string);
    procedure SetSenNet(AValue: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    function GetFields: TStrings;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DsctMax: Double read FDsctMax write SetDsctMax;
    property eMailOpe: string read FeMailOpe write SeteMailOpe;
    property FkCompany: TCompany read FFkCompany write SetFkCompany;
    property FkLanguage: TLanguage read FFkLanguage write SetFkLanguage;
    property FkOwner: Integer read FFkOwner write FFkOwner;
    property FlagBrw: Boolean read FFlagBrw write FFlagBrw default True;
    property FlagDel: Boolean read FFlagDel write FFlagDel default False;
    property FlagFnd: Boolean read FFlagFnd write FFlagFnd default True;
    property FlagIns: Boolean read FFlagIns write FFlagIns default True;
    property FlagLSen: Boolean read FFlagLSen write FFlagLSen default False;
    property FlagUpd: Boolean read FFlagUpd write FFlagUpd default False;
    property PkOperator: string read FPkOperator write SetPkOperator;
    property SenNet: string read FSenNet write SetSenNet;
  published
    function GetPkValue: Variant;
  end;
  
  TAccess = class (TPersistent)
  private
    FFkOperator: TOperator;
    FFkPrograma: TProgram;
    FFlagBrw: Boolean;
    FFlagDel: Boolean;
    FFlagFnd: Boolean;
    FFlagIns: Boolean;
    FFlagUpd: Boolean;
    FFlagVis: Boolean;
    FPkAcesso: Integer;
    procedure SetFkOperator(AValue: TOperator);
    procedure SetFkPrograma(AValue: TProgram);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property FkOperator: TOperator read FFkOperator write SetFkOperator;
    property FkPrograma: TProgram read FFkPrograma write SetFkPrograma;
    property FlagBrw: Boolean read FFlagBrw write FFlagBrw default True;
    property FlagDel: Boolean read FFlagDel write FFlagDel default False;
    property FlagFnd: Boolean read FFlagFnd write FFlagFnd default True;
    property FlagIns: Boolean read FFlagIns write FFlagIns default True;
    property FlagUpd: Boolean read FFlagUpd write FFlagUpd default False;
    property FlagVis: Boolean read FFlagVis write FFlagVis default True;
    property PkAcesso: Integer read FPkAcesso write FPkAcesso;
  published
    function GetPkValue: Variant;
  end;
  

  TModelPages = class;

  TModelPage = class (TCollectionItem)
  private
    FDisplayImage: Integer;
    FErrorMessage: string;
    FForm: TForm;
    FFormClass: TPageClass;
    FFormName: string;
    FOnChangeState: TChangeStateEvent;
    FOnChangeTypeData: TNotifyEvent;
    FOnUpdateRow: TOnUpdateRow;
    FPageCaption: string;
    FPageControl: TPageControl;
    FSelectedImage: Integer;
    FStatusBar: TStatusBar;
    FTypeData: Integer;
    procedure SetErrorMessage(Value: string);
    procedure SetFormClass(Value: TPageClass);
    procedure SetTypeData(Value: Integer);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ChangeState(Sender: TObject; AState: TDBMode);
    procedure Clear;
    procedure ShowForm;
    procedure UpdateRow(Sender: TObject; Row: TDataRow);
    property DisplayImage: Integer read FDisplayImage write FDisplayImage;
    property ErrorMessage: string read FErrorMessage write SetErrorMessage;
    property Form: TForm read FForm;
    property FormClass: TPageClass read FFormClass write SetFormClass;
    property FormName: string read FFormName write FFormName;
    property PageCaption: string read FPageCaption write FPageCaption;
    property PageControl: TPageControl read FPageControl write FPageControl;
    property SelectedImage: Integer read FSelectedImage write FSelectedImage;
    property TypeData: Integer read FTypeData write SetTypeData;
  published
    property Collection;
    property DisplayName;
    property ID;
    property Index;
    property OnChangeState: TChangeStateEvent read FOnChangeState write 
            FOnChangeState;
    property OnChangeTypeData: TNotifyEvent read FOnChangeTypeData write 
            FOnChangeTypeData;
    property OnUpdateRow: TOnUpdateRow read FOnUpdateRow write FOnUpdateRow;
  end;
  
  TModelPages = class (TCollection)
  private
    FItemIndex: Integer;
    FOwner: TPersistent;
    FPageControl: TPageControl;
    function GetActiveForm: TForm;
    function GetItems(Index: Integer): TModelPage;
    procedure SetItemIndex(Value: Integer);
    procedure SetItems(Index: Integer; AValue: TModelPage);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Add: TModelPage;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    procedure Delete(Index: Integer);
    function Insert(Index: Integer): TModelPage;
    property ActiveForm: TForm read GetActiveForm;
    property Count;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items[Index: Integer]: TModelPage read GetItems write SetItems;
    property PageControl: TPageControl read FPageControl write FPageControl;
  end;
  

implementation

{
*********************************** TModule ************************************
}
constructor TModule.Create;
begin
  inherited Create;
  FFkLanguage := TLanguage.Create;
  Clear;
end;

destructor TModule.Destroy;
begin
  Clear;
  if Assigned(FFkLanguage) then
    FFkLanguage.Free;
  FFkLanguage := nil;
  inherited Destroy;
end;

procedure TModule.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TModule) then
  begin
    DscMod     := TModule(Source).DscMod;
    FkLanguage := TModule(Source).FkLanguage;
    FPkModule  := TModule(Source).PkModule;
    Ver1       := TModule(Source).Ver1;
    Ver2       := TModule(Source).Ver2;
    Ver3       := TModule(Source).Ver3;
    Ver4       := TModule(Source).Ver4;
    FcbIndex   := TModule(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TModule.Clear;
begin
  FDscMod     := '';
  if Assigned(FFkLanguage) then
    FFkLanguage.Clear;
  FPkModule  := 0;
  FVer1      := 0;
  FVer2      := 0;
  FVer3      := 0;
  FVer4      := 0;
  FcbIndex   := 0;
  SetVersion;
end;

function TModule.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkModule) then
    Result := FcbIndex;
end;

function TModule.GetPkLanguage: string;
begin
  Result := FkLanguage.PkLanguage;
end;

function TModule.GetPkValue: Variant;
begin
  Result := FPkModule;
end;

procedure TModule.SetDscMod(AValue: string);
begin
  if (Length(AValue) > 30) then
    AValue := Copy(AValue, 1, 30);
  FDscMod := AValue;
end;

procedure TModule.SetFkLanguage(AValue: TLanguage);
begin
  if not Assigned(FFkLanguage) then
    FFkLanguage := TLanguage.Create;
  if (AValue = nil) then
    FFkLanguage.Clear
  else
    FFkLanguage.Assign(AValue);
end;

procedure TModule.SetPkLanguage(Value: string);
begin
  if (FkLanguage <> nil) then
    FkLanguage.PkLanguage := Copy(Value, 1, 5);
end;

procedure TModule.SetVer1(AValue: Byte);
begin
  FVer1 := AValue;
  SetVersion;
end;

procedure TModule.SetVer2(AValue: Byte);
begin
  FVer2 := AValue;
  SetVersion;
end;

procedure TModule.SetVer3(AValue: Byte);
begin
  FVer3 := AValue;
  SetVersion;
end;

procedure TModule.SetVer4(AValue: Byte);
begin
  FVer4 := AValue;
  SetVersion;
end;

procedure TModule.SetVersao(AValue: string);
begin
  SetVersion;
end;

procedure TModule.SetVersion;
begin
  FVersao := IntToStr(FVer1) + '.' + IntToStr(FVer2) + '.' +
             IntToStr(FVer2) + '.' + IntToStr(FVer4);
end;

{
*********************************** TRotine ************************************
}
constructor TRotine.Create;
begin
  inherited Create;
  FFkLanguage := TLanguage.Create;
  Clear;
end;

destructor TRotine.Destroy;
begin
  Clear;
  if Assigned(FFkLanguage) then
    FFkLanguage.Free;
  FFkLanguage := nil;
  inherited Destroy;
end;

procedure TRotine.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TRotine) then
  begin
    DscRot     := TRotine(Source).DscRot;
    FkLanguage := TRotine(Source).FkLanguage;
    FPkRotina  := TRotine(Source).PkRotina;
    FcbIndex   := TRotine(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TRotine.Clear;
begin
  FDscRot     := '';
  if Assigned(FFkLanguage) then
    FFkLanguage.Clear;
  FPkRotina  := 0;
  FcbIndex   := 0;
end;

function TRotine.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkRotina) then
    Result := FcbIndex;
end;

function TRotine.GetPkValue: Variant;
begin
  Result := FPkRotina;
end;

procedure TRotine.SetDscRot(AValue: string);
begin
  if (Length(AValue) > 30) then
    AValue := Copy(AValue, 1, 30);
  FDscRot := AValue;
end;

procedure TRotine.SetFkLanguage(AValue: TLanguage);
begin
  if not Assigned(FFkLanguage) then
    FFkLanguage := TLanguage.Create;
  if (AValue = nil) then
    FFkLanguage.Clear
  else
    FFkLanguage.Assign(AValue);
end;

{
******************************** TProgramParam *********************************
}
constructor TProgramParam.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TProgramParam.Destroy;
begin
  inherited Destroy;
end;

procedure TProgramParam.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProgramParam) then
  begin
    DscParam := TProgramParam(Source).DscParam;
    NomProp  := TProgramParam(Source).NomProp;
    ValProp  := TProgramParam(Source).ValProp;
  end
  else
    inherited Assign(Source);
end;

function TProgramParam.GetDisplayName: string;
begin
  Result := FDscParam;
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TProgramParam.SetDscParam(AValue: string);
begin
  if (Length(AValue) > 30) then
    AValue := Copy(AValue, 1, 30);
  FDscParam := AValue;
end;

procedure TProgramParam.SetNomProp(AValue: string);
begin
  if (Length(AValue) > 30) then
    AValue := Copy(AValue, 1, 30);
  FNomProp := AValue;
end;

procedure TProgramParam.SetValProp(AValue: string);
begin
  if (Length(AValue) > 30) then
    AValue := Copy(AValue, 1, 30);
  FValProp := AValue;
end;

{
******************************** TProgramParams ********************************
}
constructor TProgramParams.Create(AOwner: TPersistent);
begin
  inherited Create(TProgramParam);
  FOwner := AOwner;
end;

destructor TProgramParams.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TProgramParams.Add: TProgramParam;
begin
  Result := TProgramParam(inherited Add);
end;

procedure TProgramParams.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TProgramParam;
begin
  if (Source <> nil) and (Source is TProgramParams) then
  begin
    for i := 0 to TProgramParams(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TProgramParams(Source).Items[i]);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TProgramParams.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TProgramParams.GetItems(Index: Integer): TProgramParam;
begin
  Result := inherited Items[Index] as TProgramParam;
end;

function TProgramParams.GetOwner: TPersistent;
begin
  if FOwner = nil then
    Result := inherited GetOwner
  else
    Result := FOwner;
end;

function TProgramParams.Insert(Index: Integer): TProgramParam;
begin
  Result := TProgramParam(inherited Insert(Index));
end;

procedure TProgramParams.SetItems(Index: Integer; AValue: TProgramParam);
begin
  inherited Items[Index] := AValue
end;

{
*********************************** TProgram ***********************************
}
constructor TProgram.Create;
begin
  inherited Create;
  FFkLanguage    := TLanguage.Create;
  FProgramParams := TProgramParams.Create(Self);
  FFkModulo      := TModule.Create;
  FFKRotina      := TRotine.Create;
  Clear;
end;

destructor TProgram.Destroy;
begin
  Clear;
  if Assigned(FFkLanguage) then
    FFkLanguage.Free;
  if Assigned(FProgramParams) then
    FProgramParams.Free;
  if Assigned(FFkModulo) then
    FFkModulo.Free;
  if Assigned(FFKRotina) then
    FFKRotina.Free;
  FFkLanguage    := nil;
  FProgramParams := nil;
  FFkModulo      := nil;
  FFKRotina      := nil;
  inherited Destroy;
end;

procedure TProgram.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TProgram) then
  begin
    DscPrg    := TProgram(Source).DscPrg;
    FFlagRel  := TProgram(Source).FlagRel;
    FFlagVis  := TProgram(Source).FlagVis;
    NomForm   := TProgram(Source).NomForm;
    NomLib    := TProgram(Source).NomLib;
    FFkReport := TProgram(Source).FkReport;
    if Assigned(FFkLanguage) then
      FkLanguage := TProgram(Source).FkLanguage;
    if Assigned(FProgramParams) then
      ProgramParams := TProgram(Source).ProgramParams;
    if Assigned(FFkModulo) then
      FkModulo := TProgram(Source).FkModulo;
    if Assigned(FFKRotina) then
      FKRotina := TProgram(Source).FkRotina;
  end
  else
    inherited Assign(Source);
end;

procedure TProgram.Clear;
begin
  FDscPrg  := '';
  FFlagRel := False;
  FFlagVis := True;
  FNomForm := '';
  FNomLib  := '';
  if Assigned(FFkLanguage) then
    FFkLanguage.Clear;
  if Assigned(FProgramParams) then
    FProgramParams.Clear;
  if Assigned(FFkModulo) then
    FFkModulo.Clear;
  if Assigned(FFKRotina) then
    FFKRotina.Clear;
  FFkReport := 0;
end;

function TProgram.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkProgram) then
    Result := FcbIndex;
end;

function TProgram.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('FK_LINGUAGENS');
  Result.Add('FK_MODULOS');
  Result.Add('FK_ROTINAS');
  Result.Add('PK_PROGRAMAS');
  Result.Add('DSC_PRG');
  Result.Add('NOM_LIB');
  Result.Add('NOM_FRM');
  Result.Add('FLAG_VIS');
  Result.Add('FLAG_REL');
  if (FFkReport > 0) then Result.Add('FK_RELATORIOS');
end;

function TProgram.GetPkLanguage: string;
begin
  Result := '';
  if Assigned(FFkLanguage) then
    Result := FFkLanguage.PkLanguage;
end;

function TProgram.GetPkModule: Integer;
begin
  Result := 0;
  if Assigned(FFkModulo) then
    Result := FkModulo.PkModule;
end;

function TProgram.GetPkRotine: Integer;
begin
  Result := 0;
  if Assigned(FFkRotina) then
    Result := FFkRotina.PkRotina;
end;

function TProgram.GetPkValue: Variant;
begin
  Result := FPkProgram;
end;

procedure TProgram.SetDscPrg(AValue: string);
begin
  if (Length(AValue) > 30) then
    AValue := Copy(AValue, 1, 30);
  FDscPrg := AValue;
end;

procedure TProgram.SetFkLanguage(AValue: TLanguage);
begin
  if not Assigned(FFkLanguage) then
    FFkLanguage := TLanguage.Create;
  if (AValue = nil) then
    FFkLanguage.Clear
  else
    FFkLanguage.Assign(AValue);
end;

procedure TProgram.SetFkModulo(AValue: TModule);
begin
  if not Assigned(FFkModulo) then
    FFkModulo := TModule.Create;
  if (AValue = nil) then
    FFkModulo.Clear
  else
    FFkModulo.Assign(AValue);
end;

procedure TProgram.SetFKRotina(AValue: TRotine);
begin
  if not Assigned(FFKRotina) then
    FFKRotina := TRotine.Create;
  if (AValue = nil) then
    FFKRotina.Clear
  else
    FFKRotina.Assign(AValue);
end;

procedure TProgram.SetNomForm(AValue: string);
begin
  if (Length(AValue) > 20) then
    AValue := Copy(AValue, 1, 20);
  FNomForm := AValue;
end;

procedure TProgram.SetNomLib(AValue: string);
begin
  if (Length(AValue) > 20) then
    AValue := Copy(AValue, 1, 20);
  FNomLib := AValue;
end;

procedure TProgram.SetPkLanguage(const Value: string);
begin
  if Assigned(FFkLanguage) then
    FFkLanguage.PkLanguage := Copy(Value, 1, 5);
end;

procedure TProgram.SetPkModule(Value: Integer);
begin
  if Assigned(FFkModulo) then
    FFkModulo.PkModule := Value;
end;

procedure TProgram.SetPkRotine(Value: Integer);
begin
  if Assigned(FFkRotina) then
    FFkRotina.PkRotina := Value;
end;

procedure TProgram.SetProgramParams(AValue: TProgramParams);
begin
  if not Assigned(FProgramParams) then
    FProgramParams := TProgramParams.Create(Self);
  if (AValue = nil) then
    FProgramParams.Clear
  else
    FProgramParams.Assign(AValue);
end;

{
********************************** TOperator ***********************************
}
constructor TOperator.Create;
begin
  inherited Create;
  FFkCompany  := TCompany.Create;
  FFkLanguage := TLanguage.Create;
  Clear;
end;

destructor TOperator.Destroy;
begin
  Clear;
  if Assigned(FFkCompany) then
    FFkCompany.Free;
  if Assigned(FFkLanguage) then
    FFkLanguage.Free;
  FFkCompany  := nil;
  FFkLanguage := nil;
  inherited Destroy;
end;

procedure TOperator.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TOperator) then
  begin
    FcbIndex     := TOperator(Source).cbIndex;
    DsctMax      := TOperator(Source).DsctMax;
    eMailOpe     := TOperator(Source).eMailOpe;
    if Assigned(FFkCompany) then
      FkCompany  := TOperator(Source).FkCompany;
    if Assigned(FFkLanguage) then
      FkLanguage := TOperator(Source).FkLanguage;
    FkOwner      := TOperator(Source).FkOwner;
    FFlagBrw     := TOperator(Source).FlagBrw;
    FFlagDel     := TOperator(Source).FlagDel;
    FFlagFnd     := TOperator(Source).FlagFnd;
    FFlagIns     := TOperator(Source).FlagIns;
    FFlagLSen    := TOperator(Source).FlagLSen;
    FFlagUpd     := TOperator(Source).FlagUpd;
    PkOperator   := TOperator(Source).PkOperator;
    SenNet       := TOperator(Source).SenNet;
  end
  else
    inherited Assign(Source);
end;

procedure TOperator.Clear;
begin
  FcbIndex    := 0;
  FDsctMax    := 0;
  FeMailOpe   := '';
  if Assigned(FFkCompany) then
    FFkCompany.Clear;
  if Assigned(FFkLanguage) then
    FFkLanguage.Clear;
  FFkOwner    := 0;
  FFlagBrw    := True;
  FFlagDel    := False;
  FFlagFnd    := True;
  FFlagIns    := True;
  FFlagLSen   := False;
  FFlagUpd    := False;
  FPkOperator := '';
  FSenNet     := '';
end;

function TOperator.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('PK_OPERADORES');
  Result.Add('FK_EMPRESAS');
  if (FFkLanguage.PkLanguage <> '') then
    Result.Add('FK_LINGUAGENS');
  if (FFkOwner > 0) then
    Result.Add('FK_CADASTROS');
  if (FDsctMax <> 0) then
    Result.Add('DSCT_MAX');
  Result.Add('FLAG_BRW');
  Result.Add('FLAG_DEL');
  Result.Add('FLAG_FND');
  Result.Add('FLAG_INS');
  Result.Add('FLAG_LSEN');
  Result.Add('FLAG_UPD');
  if (FSenNet <> '') then
    Result.Add('SEN_NET');
end;

function TOperator.GetPkValue: Variant;
begin
  Result := FPkOperator;
end;

procedure TOperator.SetDsctMax(AValue: Double);
begin
  if (AValue > 0) or (AValue < 100) then
    FDsctMax := AValue;
end;

procedure TOperator.SeteMailOpe(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 50) then
    AValue := Copy(AValue, 1, 50);
  FeMailOpe := AValue;
end;

procedure TOperator.SetFkCompany(AValue: TCompany);
begin
  if (AValue = nil) then
    FFkCompany.Clear
  else
    FFkCompany.Assign(AValue);
end;

procedure TOperator.SetFkLanguage(AValue: TLanguage);
begin
  if (AValue = nil) then
    FFkLanguage.Clear
  else
    FFkLanguage.Assign(AValue);
end;

procedure TOperator.SetPkOperator(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 10) then
    AValue := Copy(AValue, 1, 10);
  FPkOperator := AValue;
end;

procedure TOperator.SetSenNet(AValue: string);
begin
  if (AValue <> '') and (Length(AValue) > 14) then
    AValue := Copy(AValue, 1, 14);
  FSenNet := AValue;
end;

{
*********************************** TAccess ************************************
}
constructor TAccess.Create;
begin
  inherited Create;
  Clear;
  FFkOperator := TOperator.Create;
  FFkPrograma := TProgram.Create;
end;

destructor TAccess.Destroy;
begin
  Clear;
  if Assigned(FFkOperator) then
    FFkOperator.Free;
  FFkOperator := nil;
  if Assigned(FFkPrograma) then
    FFkPrograma.Free;
  FFkPrograma := nil;
  inherited Destroy;
end;

procedure TAccess.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TAccess) then
  begin
    if Assigned(FFkOperator) then
      FkOperator := TAccess(Source).FkOperator;
    FFlagBrw := TAccess(Source).FlagBrw;
    FFlagDel := TAccess(Source).FlagDel;
    FFlagFnd := TAccess(Source).FlagFnd;
    FFlagIns := TAccess(Source).FlagIns;
    FFlagUpd := TAccess(Source).FlagUpd;
    FFlagVis := TAccess(Source).FlagVis;
  end
  else
    inherited Assign(Source);
end;

procedure TAccess.Clear;
begin
  if Assigned(FFkOperator) then
    FFkOperator.Clear;
  FFlagBrw := True;
  FFlagDel := False;
  FFlagFnd := True;
  FFlagIns := True;
  FFlagUpd := False;
  FFlagVis := True;
end;

function TAccess.GetPkValue: Variant;
begin
  Result := FPkAcesso;
end;

procedure TAccess.SetFkOperator(AValue: TOperator);
begin
  if not Assigned(FFkOperator) then
    FFkOperator:= TOperator.Create;
  if (AValue = nil) then
    FFkOperator.Clear
  else
    FFkOperator.Assign(AValue);
end;

procedure TAccess.SetFkPrograma(AValue: TProgram);
begin
  if not Assigned(FFkPrograma) then
    FFkPrograma:= TProgram.Create;
  if (AValue = nil) then
    FFkPrograma.Clear
  else
    FFkPrograma.Assign(AValue);
end;

{
********************************** TModelPage **********************************
}
constructor TModelPage.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Clear;
  if (Collection is TModelPages) then
    PageControl := TModelPages(Collection).PageControl;
end;

destructor TModelPage.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TModelPage.Assign(Source: TPersistent);
begin
  if (Source <> nil) or (Source is TModelPage) then
  begin
    FDisplayImage     := TModelPage(Source).DisplayImage;
    FormClass         := TModelPage(Source).FormClass;
    FFormName         := TModelPage(Source).FormName;
    FPageCaption      := TModelPage(Source).PageCaption;
    FPageControl      := TModelPage(Source).PageControl;
    FSelectedImage    := TModelPage(Source).SelectedImage;
    FTypeData         := TModelPage(Source).TypeData;
    FOnChangeState    := TModelPage(Source).OnChangeState;
    FOnChangeTypeData := TModelPage(Source).OnChangeTypeData;
    FOnUpdateRow      := TModelPage(Source).OnUpdateRow;
  end
  else
    inherited Assign(Source);
end;

procedure TModelPage.ChangeState(Sender: TObject; AState: TDBMode);
begin
  if (Assigned(FOnChangeState)) then
    FOnChangeState(Sender, AState);
end;

procedure TModelPage.Clear;
begin
  FDisplayImage     := -1;
  FormClass         := nil;
  FFormName         := '';
  FPageCaption      := '';
  FPageControl      := nil;
  FSelectedImage    := -1;
  FTypeData         := -1;
  FOnChangeState    := nil;
  FOnChangeTypeData := nil;
  FOnUpdateRow      := nil;
end;

function TModelPage.GetDisplayName: string;
begin
  Result := inherited GetDisplayName;
end;

procedure TModelPage.SetErrorMessage(Value: string);
var
  i: Integer;
begin
  if (FStatusBar = nil) and (FPageControl <> nil) and
     (FPageControl.Parent <> nil) and (FPageControl.Parent is TForm) then
  begin
    with TForm(FPageControl.Parent) do
    begin
      for i := 0 to ComponentCount - 1 do
      begin
        if (Components[i].InheritsFrom(TStatusBar)) then
        begin
          FStatusBar :=  TStatusBar(Components[i]);
          break;
        end;
      end;
    end;
  end;
  if (FStatusBar <> nil) then
  begin
    if (FStatusBar.Panels.Count > 0) then
      FStatusBar.Panels[0].Text := Value
    else
      FStatusBar.SimpleText := Value;
  end
  else
    MessageDlg(Value, mtError, [mbOK], 0);
end;

procedure TModelPage.SetFormClass(Value: TPageClass);
  
  procedure SetFormEvent(const AProp, AMeth: string);
  var
    aMethod: TMethod;
  begin
    if (GetMethodProp(FForm, AProp).Code <> nil) and
       (FForm.MethodAddress(AMeth) <> nil) then
    begin
      aMethod.Code := FForm.MethodAddress(AMeth);
      aMethod.Data := Pointer(FForm);
      SetMethodProp(FForm, AProp, aMethod);
    end;
  end;
  
begin
  if (FForm <> nil) then
  begin
    FForm.Free;
    FForm := nil;
  end;
  if ((Value <> nil) and (FPageControl <> nil) and (FForm = nil)) then
  begin
    FForm := Value.Create(Application);
    if ((TPageControl(FPageControl).PageCount - 1) < Index) then
    begin
      with TTabSheet.Create(FPageControl) do
      begin
        PageControl := FPageControl;
        TabVisible  := False;
        Caption     := PageCaption;
        Name        := FormName;
      end;
      FForm.Parent      := FPageControl.Pages[Index];
      FForm.Align       := alClient;
      FForm.BorderStyle := bsNone;
      if (GetProperty(FForm, 'OnChangeState')) then
        SetFormEvent('OnChangeState', 'ChangeState')
      else
        ErrorMessage := 'OnChangeState event not found';
      if (GetProperty(FForm, 'OnUpdateRow')) then
        SetFormEvent('OnUpdateRow', 'UpdateRow')
      else
        ErrorMessage := 'OnUpdateRow event not found';
    end;
  end;
end;

procedure TModelPage.SetTypeData(Value: Integer);
begin
  if (Assigned(FOnChangeTypeData)) then
    FOnChangeTypeData(Self);
end;

procedure TModelPage.ShowForm;
begin
  FForm.Show;
end;

procedure TModelPage.UpdateRow(Sender: TObject; Row: TDataRow);
begin
  if (Assigned(FOnUpdateRow)) then
    FOnUpdateRow(Sender, Row);
end;

{
********************************* TModelPages **********************************
}
constructor TModelPages.Create(AOwner: TPersistent);
var
  i: Integer;
begin
  inherited Create(TModelPage);
  FOwner := AOwner;
  Clear;
  if (FOwner.InheritsFrom(TForm)) then
  begin
    for i := 0 to TForm(FOwner).ComponentCount - 1 do
      if (TForm(FOwner).Components[i] is TPageControl) then
        FPageControl := TPageControl(TForm(FOwner).Components[i]);
  end;
end;

destructor TModelPages.Destroy;
begin
  Clear;
  FOwner := nil;
  inherited Destroy;
end;

function TModelPages.Add: TModelPage;
begin
  Result := TModelPage(inherited Add);
  FItemIndex := Result.Index;
end;

procedure TModelPages.Assign(Source: TPersistent);
var
  i: Integer;
  aItem: TModelPage;
begin
  if (Source <> nil) and (Source is TModelPage) then
  begin
    Clear;
    for i := 0 to TModelPages(Source).Count - 1 do
    begin
      aItem := Add;
      aItem.Assign(TModelPages(Source).Items[i]);
    end;
    FItemIndex   := TModelPages(Source).FItemIndex;
    FPageControl := TModelPages(Source).FPageControl;
  end
  else
    inherited Assign(Source);
end;

procedure TModelPages.Clear;
begin
  inherited Clear;
  FItemIndex   := -1;
  FPageControl := nil;
end;

procedure TModelPages.Delete(Index: Integer);
begin
  inherited Delete(Index);
  if (FItemIndex = Index) then
    FItemIndex := Count - 1;
end;

function TModelPages.GetActiveForm: TForm;
begin
  if (FItemIndex > -1) and (FItemIndex < Count) and
     (Items[FItemIndex].Form <> nil) then
    Result := Items[FItemIndex].Form
  else
    Result := nil;
end;

function TModelPages.GetItems(Index: Integer): TModelPage;
begin
  Result := inherited Items[Index] as TModelPage;
  FItemIndex := Index;
end;

function TModelPages.GetOwner: TPersistent;
begin
  if FOwner = nil then
    Result := inherited GetOwner
  else
    Result := FOwner;
end;

function TModelPages.Insert(Index: Integer): TModelPage;
begin
  Result := TModelPage(inherited Insert(Index));
  FItemIndex := Result.Index;
end;

procedure TModelPages.SetItemIndex(Value: Integer);
begin
  if (Value <> FItemIndex) and (Value < Count) then
  begin
    FItemIndex := Value;
    if (PageControl <> nil) and (FItemIndex > -1) and
       (FItemIndex < PageControl.PageCount) and
       (PageControl.ActivePageIndex <> FItemIndex) then
    begin
      if (PageControl.ActivePage <> nil) then
        PageControl.ActivePage.TabVisible := False;
      PageControl.ActivePageIndex := FItemIndex;
      if (not PageControl.ActivePage.TabVisible) then
      begin
        PageControl.ActivePage.TabVisible := True;
        Items[FItemIndex].ShowForm;
      end;
    end;
  end;
end;

procedure TModelPages.SetItems(Index: Integer; AValue: TModelPage);
begin
  inherited Items[Index] := AValue;
  FItemIndex := Index;
end;


end.
