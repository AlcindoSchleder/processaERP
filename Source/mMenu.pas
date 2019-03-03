unit mMenu;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
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
  SysUtils, Classes, Forms, DB, ProcType, SqlExpr, FMTBcd;

type
  TdmMenu = class(TDataModule)
    qrParametros: TSQLQuery;
    qrModulos: TSQLQuery;
    qrProgramas: TSQLQuery;
    qrParamGlb: TSQLQuery;
    qrOperadores: TSQLQuery;
    qrParamPrg: TSQLQuery;
    qrResource: TSQLQuery;
    procedure DadosDestroy(Sender: TObject);
    procedure qrModulosBeforeOpen(DataSet: TDataSet);
    procedure qrProgramasBeforeOpen(DataSet: TDataSet);
    procedure qrParametrosBeforeOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cod_Auto     : Integer;
    function  AchaOperador(const Nome: string): Boolean;
    function  SelecionaModulos: Boolean;
    function  SelecionaProgramas: Boolean;
    procedure CtrlTables(Active: Boolean);
    function  GetUserResources(const AUser: string): Boolean;
  end;

var
  dmMenu: TdmMenu;

implementation

uses Funcoes, mArqSql, Dado, CmmConst, TypInfo;

{$R *.DFM}

function  TdmMenu.AchaOperador(const Nome: string): Boolean;
begin
  if qrOperadores.Active then qrOperadores.Close;
  qrOperadores.SQL.Clear;
  qrOperadores.SQL.Add(SqlOperatorActive);
  qrOperadores.ParamByName('Operador').AsString := Nome;
  if not qrOperadores.Active then qrOperadores.Open;
  Result := (not qrOperadores.IsEmpty);
  Dados.Parametros.soActiveCompany := 0;
  Dados.Parametros.soNewCompany    := qrOperadores.FieldByName('FK_EMPRESAS').AsInteger;
  Dados.Parametros.soFromMail      := qrOperadores.FieldByName('EMAIL_OPE').AsString;
  Dados.Parametros.soUser          := qrOperadores.FieldByName('PK_OPERADORES').AsString;
  if qrOperadores.Active then qrOperadores.Close;
  if not Dados.ChangeCompany then
    raise Exception.CreateFmt('Empresa %d não encontrada', [Dados.Parametros.soNewCompany]);
end;

procedure TdmMenu.DadosDestroy(Sender: TObject);
begin
  if qrModulos.Active    then qrModulos.Close;
  if qrProgramas.Active  then qrProgramas.Close;
  if qrParametros.Active then qrParametros.Close;
  if qrParamGlb.Active  then qrParamGlb.Close;
end;

function  TdmMenu.SelecionaModulos: Boolean;
begin
  if qrModulos.Active then qrModulos.Close;
  qrModulos.SQL.Clear;
  qrModulos.SQL.Add(SqlModRot);
  if not qrModulos.Active then qrModulos.Open;
  Result := not qrModulos.IsEmpty;
end;

function  TdmMenu.SelecionaProgramas: Boolean;
begin
  if qrProgramas.Active then qrProgramas.Close;
  qrProgramas.SQL.Clear;
  qrProgramas.SQL.Add(SqlProgram);
  if not qrProgramas.Active then qrProgramas.Open;
  Result := not qrProgramas.IsEmpty;
end;

procedure TdmMenu.qrModulosBeforeOpen(DataSet: TDataSet);
begin
  if qrModulos.Params.Count > 0 then
  begin
    qrModulos.Params.ParamByName('Operador').AsString := Dados.Parametros.soUser;
    qrModulos.Params.ParamByName('FlagVis').AsInteger := FLAG_SIM;
  end;
end;

procedure TdmMenu.qrProgramasBeforeOpen(DataSet: TDataSet);
begin
  if qrProgramas.Params.Count > 0 then
  begin
    qrProgramas.Params.ParamByName('Operador').AsString := Dados.Parametros.soUser;
//    qrProgramas.Params.ParamByName('FlagVis').AsInteger := FLAG_SIM;
    qrProgramas.Params.ParamByName('Modulo').AsInteger  := Dados.Parametros.soPkModule;
    qrProgramas.Params.ParamByName('Rotina').AsInteger  := Dados.Parametros.soPkRotine;
  end;
end;

procedure TdmMenu.qrParametrosBeforeOpen(DataSet: TDataSet);
begin
  if (qrParametros.Params.Count > 0) and
     (qrParametros.Params.FindParam('Empresa') <> nil) then
    if Dados.Parametros.soNewCompany > 0 then
      qrParametros.Params.ParamByName('Empresa').AsInteger := Dados.Parametros.soNewCompany
    else
      if Dados.Parametros.soActiveCompany > 0 then
        qrParametros.Params.ParamByName('Empresa').AsInteger := Dados.Parametros.soActiveCompany;
end;

procedure TdmMenu.CtrlTables(Active: Boolean);
begin
  qrModulos.Active     := Active;
  qrProgramas.Active   := Active;
  qrOperadores.Active   := Active;
  qrParametros.Active  := Active;
  qrParamGlb.Active   := Active;
end;

procedure TdmMenu.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

function TdmMenu.GetUserResources(const AUser: string): Boolean;
begin
  if qrResource.Active then qrResource.Close;
  qrResource.SQL.Clear;
  qrResource.SQL.Add(SqlResourceOpe);
  Dados.StartTransaction(qrResource);
  try
    qrResource.ParamByName('FkOperadores').AsString := AUser;
    if not qrResource.Active then qrResource.Open;
    Result := (qrResource.FieldByName('PK_RESOURCES').AsInteger > 0)
  finally
    if qrResource.Active then qrResource.Close;
    Dados.CommitTransaction(qrResource);
  end;
end;

end.
