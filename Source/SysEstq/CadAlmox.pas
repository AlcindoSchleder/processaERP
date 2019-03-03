unit CadAlmox;

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
  Dialogs, CadModel, StdCtrls, Mask, ToolEdit, CurrEdit, Buttons, GridRow,
  ExtCtrls;

type
  TCdAlmox = class(TfrmModel)
    lPk_Almoxarifados: TStaticText;
    ePk_Almox: TCurrencyEdit;
    eDsc_Almx: TEdit;
    lDsc_Almx: TStaticText;
    lLocal_Almx: TStaticText;
    eLocal_Almx: TMemo;
    pTitle: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function  GetDscAlmx: string;
    function  GetLocalAlmx: TStrings;
    function  GetDataRow: TDataRow;
    procedure SetDscAlmx(const Value: string);
    procedure SetLocalAlmx(const Value: TStrings);
    procedure SetPkAlmox(const Value: Integer);
    procedure SetPkAlmoxFromPk(Sender: TObject);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    procedure MoveDataToControls; override;
    property  PkAlmox  : Integer                    write SetPkAlmox;
    property  DscAlmx  : string   read GetDscAlmx   write SetDscAlmx;
    property  LocalAlmx: TStrings read GetLocalAlmx write SetLocalAlmx;
    property  DataRow  : TDataRow read GetDataRow;
  end;

var
  CdAlmox: TCdAlmox;

implementation

uses mSysEstq, ProcUtils;

{$R *.dfm}

{ TCdAlmox }

procedure TCdAlmox.ClearControls;
begin
  Loading   := True;
  try
    PkAlmox   := Pk;
    DscAlmx   := '';
    LocalAlmx := nil;
  finally
    Loading   := False;
  end;
end;

function TCdAlmox.GetDataRow: TDataRow;
begin
  Result := dmSysEstq.GetAlmox(Pk);
end;

function TCdAlmox.GetDscAlmx: string;
begin
  Result := eDsc_Almx.Text;
end;

function TCdAlmox.GetLocalAlmx: TStrings;
begin
  Result := eLocal_Almx.Lines;
end;

procedure TCdAlmox.LoadDefaults;
begin
//  nothing to do
end;

procedure TCdAlmox.MoveDataToControls;
var
  M: TStream;
  S: TStrings;
begin
  Loading   := True;
  try
    with GetDataRow do
    begin
      PkAlmox   := Pk;
      DscAlmx   := FieldByName['DSC_ALMX'].AsString;
      if (FieldByName['DSC_ALMX'].DataSize > 0) then
      begin
        M := TMemoryStream.Create;
        S := TStringList.Create;
        try
          FieldByName['LOCAL_AMLX'].SaveToStream(M, buValue);
          M.Position := 0;
          S.LoadFromStream(M);
          LocalAlmx := S;
        finally
          FreeAndNil(M);
          FreeAndNil(S);
        end;
      end;
    end;
  finally
    Loading   := False;
  end;
end;

procedure TCdAlmox.SaveIntoDB;
var
  M: TStream;
  S: TStrings;
  aRow: TDataRow;
begin
  aRow := DataRow;
  with aRow do
  begin
    FieldByName['PK_ALMOXARIFADOS'].AsInteger := Pk;
    FieldByName['DSC_ALMX'].AsString := DscAlmx;
    M := TMemoryStream.Create;
    S := TStringList.Create;
    try
      S.Assign(LocalAlmx);
      S.SaveToStream(M);
      M.Position := 0;
      FieldByName['LOCAL_AMLX'].LoadFromStream(M, buValue);
    finally
      FreeAndNil(M);
      FreeAndNil(S);
    end;
    dmSysEstq.SaveAlmox(aRow, ScrState);
    Pk := FieldByName['PK_ALMOXARIFADOS'].AsInteger;
    if Assigned(OnUpdateRow) then OnUpdateRow(Self, aRow);
  end;
end;

procedure TCdAlmox.SetDscAlmx(const Value: string);
begin
  eDsc_Almx.Text := Value;
end;

procedure TCdAlmox.SetLocalAlmx(const Value: TStrings);
begin
  eLocal_Almx.Lines.Clear;
  if (Value <> nil) then
    eLocal_Almx.Lines.Assign(Value);
end;

procedure TCdAlmox.SetPkAlmox(const Value: Integer);
begin
  ePk_Almox.AsInteger := Value;
end;

procedure TCdAlmox.FormCreate(Sender: TObject);
begin
  inherited;
  OnChangePK  := SetPkAlmoxFromPk;
end;

procedure TCdAlmox.SetPkAlmoxFromPk(Sender: TObject);
begin
  PkAlmox := Pk;
end;

end.
