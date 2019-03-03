unit mSysPdv;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 06/03/2003 - DD/MM/YYYY                                      *}
{* Modified: 06/03/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Encryp, ProcType, FMTBcd, SqlExpr;

type
  TdmSysPdv = class(TDataModule)
    qrProducts: TSQLQuery;
    SqlAux: TSQLQuery;
    qrDocumento: TSQLQuery;
    qrDuplicata: TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmSysPdv: TdmSysPdv;

implementation

uses Dado, TypInfo;

{$R *.DFM}

function  GetProperty(AComponent: TComponent; const Propr: string): Boolean;
begin
  Result := GetPropInfo(AComponent.ClassInfo, Propr) <> nil;
end;

function  GetWhereSQL(const AWhereFields: TStrings): TStrings;
const
  S_WHERE = ' where ';
  S_AND   = '   and ';
var
  i: Integer;
  aField: string;
begin
  Result := TStringList.Create;
  if (AWhereFields = nil) or (AWhereFields.Count = 0) then exit;
  for i := 0 to AWhereFields.Count - 1 do
  begin
    if AWhereFields.Strings[i] <> '' then
    begin
      aField := AWhereFields.Strings[i];
      if i = 0 then
        Result.Add(S_WHERE + aField + ' = :' +
          LowerCase(StringReplace(AWhereFields.Strings[i], '_', '', [rfReplaceAll])))
      else
        Result.Add(S_AND + aField + ' = :' +
          LowerCase(StringReplace(AWhereFields.Strings[i], '_', '', [rfReplaceAll])));
    end;
  end;
end;

function  GetUpdateSQL(const AFields, AWhereFields: TStrings;
            const ATableName: string): TStrings;
const
  S_UPDATE   = 'update %s set ';
  S_OPERATOR = '%s = %s ';
  S_SPC      = '       ';
var
  i: Integer;
  S, S1: string;
begin
  Result := TStringList.Create;
  if (AFields = nil) or (AFields.Count = 0) or (ATableName = '') then exit;
  Result.Add(Format(S_UPDATE, [ATableName]));
  for i := 0 to AFields.Count - 1 do
  begin
    if (AFields[i] <> '') then
    begin
      S1 := ':' + LowerCase(StringReplace(AFields.Strings[i], '_', '', [rfReplaceAll]));
      S  := AFields.Strings[i];
      S  := Format(S_OPERATOR, [S, S1]);
      if i < AFields.Count - 1 then
        S := S + ', ';
      Result.Add(S_SPC + S);
    end;
  end;
  S := Result.Strings[Result.Count - 1];
  if (S <> '') and (S[(Length(S) - 1)] = ',') then
  begin
    S[(Length(S) - 1)] := ' ';
    Result.Strings[Result.Count - 1] := S;
  end;
  if (AWhereFields <> nil) and (AWhereFields.Count > 0) then
    Result.AddStrings(GetWhereSQL(AWhereFields));
end;

procedure TdmSysPdv.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

procedure TdmSysPdv.DataModuleDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].InheritsFrom(TDataSet)) and
       (TDataSet(Components[i]).Active)       then
      TDataSet(Components[i]).Close;
  end;
end;

initialization
  Application.CreateForm(TdmSysPdv, dmSysPdv);
finalization
  if Assigned(dmSysPdv) then dmSysPdv.Free;
  dmSysPdv := nil;
end.
