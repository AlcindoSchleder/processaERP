library SysBuy;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/06/2003 - DD/MM/YYYY                                      *}
{* Modified: 03/06/2003 - DD/MM/YYYY                                     *}
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

uses
  Windows,
  System,
  SysUtils,
  Classes,
  Forms,
  midaslib,
  Dialogs,
  ProcType,
  CmmConst,
  Funcoes in '..\Comum\Funcoes.pas',
  FuncoesDB in '..\Comum\FuncoesDB.pas',
  TreeFunc in '..\Comum\TreeFunc.pas',
  CadMod in '..\Comum\CadMod.pas' {CdModelo},
  Dado in '..\Comum\Dado.pas' {Dados: TDataModule},
  Ovo in '..\Comum\Ovo.pas' {Pascoa},
  Autor in '..\Comum\Autor.pas' {Autoriza},
  AltPass in '..\Comum\AltPass.pas' {AltPassword},
  DualMod in '..\Comum\DualMod.pas' {DualOrder},
  SelEmpr in '..\Comum\SelEmpr.pas' {SelEmpresa},
  Sobre in '..\Comum\Sobre.pas' {SobreProcessa},
  ModelTyp in '..\Comum\ModelTyp.pas',
  RecErr in '..\Comum\RecErr.pas' {ReconcileErrorForm},
  CnsMod in '..\Comum\CnsMod.pas' {CnsModelo},
  SqlComm in '..\Comum\SqlComm.pas',
  ArqCnst in 'ArqCnst.pas',
  ArqSql in 'ArqSql.pas',
  mSysBuy in 'mSysBuy.pas' {dmSysBuy: TDataModule},
  CadCota in 'CadCota.pas' {CdCotacoes},
  dbObjects in '..\Comum\DBObjects.pas',
  ModFields in '..\Comum\ModFields.pas';

{$R *.res}

function CreateFormPrg(Form: string): TForm;
var
  a: Integer;
const
  NomForms: array [1..2] of string =
    ('CdCotacoes', 'CdAlgumForm');

  function IndexOfCnst: Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := Low(NomForms) to High(NomForms) do
      if Form = NomForms[i] then
      begin
        Result := i;
        break;
      end;
  end;

begin
  Result := nil;
  a := 0;
  if Copy(Form, 1, 2) = 'Cd' then
    a := 1
  else
    if Copy(Form, 1, 3) = 'Cns' then
      a := 2;
  case a of
    1: Application.CreateForm(TCdModelo, CdModelo);
  2: Application.CreateForm(TCnsModelo, CnsModelo);
  end;
  case IndexOfCnst of
    01: Result := TCdCotacoes.Create(Application);
    02: Result := TCdModelo.Create(Application);
  end;
end;

function  RodaPrograma(AHandle: THandle; Params: Pointer): Boolean; cdecl;
var
  Display  : TForm;
  LibHandle: THandle;
begin
  Result := Assigned(Params);
  Display := nil;
  if not Result then exit;
  SetLength(StringsLang, Integer(High(TTypeConst)) + 1);
  LibHandle          := Application.Handle;
  Application.Handle := AHandle;
  GetMem(ParamGlobal, SizeOf(TParamGlobal));
  try
    CopyParams(Params);
    GetStrings := False;
    LANGUAGE   := StrPas(ParamGlobal^.LANGUAGE);
    Application.CreateForm(TDados, Dados);
    Application.CreateForm(TdmSysBuy, dmSysBuy);
    Dados.Image32.GetIcon(0, Application.Icon);
    with Dados do
    begin
      Dados.ConfigFiles;
      dmSysBuy.ConfigFiles;
      Dados.Conexao.Params.Clear;
      Dados.Conexao.Params.Add('user_name=' + StrPas(ParamGlobal^.Operator));
      Dados.Conexao.Params.Add('password=' + StrPas(ParamGlobal^.Password));
      Dados.Conexao.DatabaseName := ParamGlobal^.DatabaseName;
      if not Dados.Conexao.Connected then Dados.Conexao.Open;
      if not Dados.GetAllStringsMessage(LANGUAGE, 0, 0, 0, StringsLang,
         ConstMessages) then
        ShowMessage(sErrRecoverStrings);
      Parametros.NewEmpr      := ParamGlobal^.ActiveCompany;
      Parametros.NameEnterpr  := StrPas(ParamGlobal^.NameCompany);
      Parametros.Operador     := StrPas(ParamGlobal^.Operator);
      Parametros.ServerName   := StrPas(ParamGlobal^.ServerName);
      SelecionaParamEmpr;
      Display                 := CreateFormPrg(StrPas(ParamGlobal^.NameForm));
    end;
    if Display <> nil then
      Display.ShowModal
    else
      Result := False;
  finally
    if Assigned(Display)  then Display.Free;
    Display := nil;
    if (Display = nil) and Assigned(CdModelo) then CdModelo.Free;
    CdModelo := nil;
    Application.Handle := LibHandle;
    if Dados.Conexao.Connected then Dados.Conexao.Close;
    if Assigned(dmSysBuy) then dmSysBuy.Free;
    if Assigned(Dados)    then Dados.Free;
    dmSysBuy := nil;
    Dados    := nil;
    FreeParamGlobal;
    FreeMem(ParamGlobal, SizeOf(TParamGlobal));
    FillChar(StringsLang, Length(StringsLang), 0);
  end;
end;

exports RodaPrograma;

end.
