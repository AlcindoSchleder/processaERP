unit CadModls;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 23/01/2003 - DD/MM/YYYY                                      *}
{* Modified: 23/01/2003 - DD/MM/YYYY                                     *}
{* Version: 2.0.0.0                                                      *}
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
  Dialogs, CadModel, Mask, ToolEdit, CurrEdit, StdCtrls, TSysManAux,
  VirtualTrees;

type
  TfrmModules = class(TfrmModel)
    lPk_Modulos: TStaticText;
    lDsc_Mod: TStaticText;
    eDsc_Mod: TEdit;
    lVer_1: TStaticText;
    eVer_1: TCurrencyEdit;
    lVer_2: TStaticText;
    eVer_2: TCurrencyEdit;
    lVer_3: TStaticText;
    eVer_3: TCurrencyEdit;
    lVer_4: TStaticText;
    eVer_4: TCurrencyEdit;
    eVersao: TEdit;
    lVersao: TStaticText;
    stTitle: TLabel;
    ePk_Modulos: TCurrencyEdit;
  private
    FFkLanguage: string;
    function  GetDscMod: string;
    function  GetModule: TModule;
    function  GetPkModule: Integer;
    function  GetVer1: Integer;
    function  GetVer2: Integer;
    function  GetVer3: Integer;
    function  GetVer4: Integer;
    function  GetVersion: string;
    procedure SetDscMod(const Value: string);
    procedure SetFkLanguage(const Value: string);
    procedure SetModule(const Value: TModule);
    procedure SetPkModule(const Value: Integer);
    procedure SetVer1(const Value: Integer);
    procedure SetVer2(const Value: Integer);
    procedure SetVer3(const Value: Integer);
    procedure SetVer4(const Value: Integer);
    procedure SetVersion(const Value: string);
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  Module  : TModule read GetModule   write SetModule;
    property  PkModule: Integer read GetPkModule write SetPkModule;
    property  DscMod  : string  read GetDscMod   write SetDscMod;
    property  Ver1    : Integer read GetVer1     write SetVer1;
    property  Ver2    : Integer read GetVer2     write SetVer2;
    property  Ver3    : Integer read GetVer3     write SetVer3;
    property  Ver4    : Integer read GetVer4     write SetVer4;
    property  Version : string  read GetVersion  write SetVersion;
  public
    { Public declarations }
    property FkLanguage: string read FFkLanguage write SetFkLanguage;
    property Pk;  
  end;

var
  frmModules: TfrmModules;

implementation

uses mSysMan;

{$R *.dfm}

{ TfrmModules }

procedure TfrmModules.ClearControls;
begin
  Loading  := True;
  PkModule := 0;
  DscMod   := '';
  Ver1     := 0;
  Ver2     := 0;
  Ver3     := 0;
  Ver4     := 0;
  Version  := '';
  Loading  := False;
end;

function TfrmModules.GetDscMod: string;
begin
  Result := eDsc_Mod.Text;
end;

function TfrmModules.GetModule: TModule;
begin
  Result   := dmSysMan.GetModule(FkLanguage, Pk);
  if (Result = nil) then exit;
  Loading  := True;
  PkModule := Result.PkModule;
  DscMod   := Result.DscMod  ;
  Ver1     := Result.Ver1    ;
  Ver2     := Result.Ver2    ;
  Ver3     := Result.Ver3    ;
  Ver4     := Result.Ver4    ;
  Version  := Result.Versao  ;
  Loading  := False;
end;

function TfrmModules.GetPkModule: Integer;
begin
  Result := ePk_Modulos.AsInteger;
end;

function TfrmModules.GetVer1: Integer;
begin
  Result := eVer_1.AsInteger;
end;

function TfrmModules.GetVer2: Integer;
begin
  Result := eVer_2.AsInteger;
end;

function TfrmModules.GetVer3: Integer;
begin
  Result := eVer_3.AsInteger;
end;

function TfrmModules.GetVer4: Integer;
begin
  Result := eVer_4.AsInteger;
end;

function TfrmModules.GetVersion: string;
begin
  Result := eVersao.Text;
end;

procedure TfrmModules.LoadDefaults;
begin
  MoveDataToControls
end;

procedure TfrmModules.MoveDataToControls;
begin
  if (Pk > 0) and (FFkLanguage <> '') then
    GetModule;
end;

procedure TfrmModules.SaveIntoDB;
begin
  SetModule(TModule.Create);
end;

procedure TfrmModules.SetDscMod(const Value: string);
begin
  eDsc_Mod.Text := Value;
end;

procedure TfrmModules.SetFkLanguage(const Value: string);
begin
  FFkLanguage := Value;
end;

procedure TfrmModules.SetModule(const Value: TModule);
begin
  Value.PkLanguage := FFkLanguage;
  Value.PkModule   := PkModule;
  Value.DscMod     := DscMod  ;
  Value.Ver1       := Ver1    ;
  Value.Ver2       := Ver2    ;
  Value.Ver3       := Ver3    ;
  Value.Ver4       := Ver4    ;
  Value.Versao     := Version ;
  dmSysMan.SaveModule(Value, ScrState, Pk, FFkLanguage);
end;

procedure TfrmModules.SetPkModule(const Value: Integer);
begin
  ePk_Modulos.AsInteger := Value;
end;

procedure TfrmModules.SetVer1(const Value: Integer);
begin
  eVer_1.AsInteger := Value;
end;

procedure TfrmModules.SetVer2(const Value: Integer);
begin
  eVer_2.AsInteger := Value;
end;

procedure TfrmModules.SetVer3(const Value: Integer);
begin
  eVer_3.AsInteger := Value;
end;

procedure TfrmModules.SetVer4(const Value: Integer);
begin
  eVer_4.AsInteger := Value;
end;

procedure TfrmModules.SetVersion(const Value: string);
begin
  eVersao.Text := Value;
end;

end.
