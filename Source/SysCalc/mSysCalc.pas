unit mSysCalc;

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
  DB, Encryp, ProcType, FMTBcd, IBCustomDataSet, IBQuery, Provider,
  DBClient, IBDatabase;

type
  TdmSysCalc = class(TDataModule)
    Tipo_Motor: TClientDataSet;
    dsAccess: TIBQuery;
    pAccess: TDataSetProvider;
    SqlAux: TIBQuery;
    TrMain: TIBTransaction;
    Parametro_Calc: TClientDataSet;
    Calculo: TClientDataSet;
    Tipos_Motores: TIBQuery;
    Clientes: TIBQuery;
    Parametros: TIBQuery;
    Motores: TIBQuery;
    trCalc: TIBTransaction;
    InsMotors: TIBQuery;
    Calculos: TIBQuery;
    TrMot: TIBTransaction;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataSetReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure dsAccessAfterClose(DataSet: TDataSet);
    procedure Parametro_CalcNewRecord(DataSet: TDataSet);
    procedure Tipo_MotorNewRecord(DataSet: TDataSet);
    procedure CalculoNewRecord(DataSet: TDataSet);
    procedure MotoresBeforeOpen(DataSet: TDataSet);
    procedure CalculosBeforeOpen(DataSet: TDataSet);
    procedure CalculoAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    Historicos   : THistorico;
    dsStatus     : TDBMode;
    MethodWithPar: TScrollTabPar;
    MethodWOutPar: TScrollTab;
    procedure ConfigFiles;
  end;

var
  dmSysCalc: TdmSysCalc;

implementation

uses AltPass, Funcoes, Autor, CadMod, FuncoesDB, ModelTyp, ArqSql, Dado,
  CmmConst, RecErr, SqlComm, ArqCnst, Math;

{$R *.DFM}

procedure TdmSysCalc.ConfigFiles;
begin
  dsAccess.DataBase      := Dados.Conexao;
  dsAccess.Transaction   := TrMain;
end;

procedure TdmSysCalc.DataModuleDestroy(Sender: TObject);
begin
  if Tipo_Motor.Active     then Tipo_Motor.Close;
  if Parametro_Calc.Active then Parametro_Calc.Close;
  if Calculo.Active        then Calculo.Close;
  if dsAccess.Active       then dsAccess.Close;
  if TrMain.InTransaction  then TrMain.Commit;
  with Dados do
    if Conexao.Connected   then Conexao.Close;
  dsAccess.DataBase    := nil;
  dsAccess.Transaction := nil;
end;

procedure TdmSysCalc.DataSetReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  Action := HandleReconcileError(DataSet, UpdateKind, E);
end;

procedure TdmSysCalc.dsAccessAfterClose(DataSet: TDataSet);
begin
  if TrMain.InTransaction then
    TrMain.Commit;
end;

procedure TdmSysCalc.Parametro_CalcNewRecord(DataSet: TDataSet);
begin
  try
    Parametro_Calc.FieldByName('PK_PARAMETROS_CALC').AsInteger := ZEROINT;
    Parametro_Calc.FieldByName('KWH_MOT').AsFloat              := 0.736;
    Parametro_Calc.FieldByName('PARAM_NHF').AsInteger          := ZEROINT;
    Parametro_Calc.FieldByName('PARAM_NHH').AsInteger          := ZEROINT;
    Parametro_Calc.FieldByName('PARAM_NDM').AsInteger          := ZEROINT;
    Parametro_Calc.FieldByName('PARAM_NMA').AsInteger          := ZEROINT;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysCalc.Tipo_MotorNewRecord(DataSet: TDataSet);
begin
  try
    Tipo_Motor.FieldByName('PK_TIPOS_MOTORES').AsInteger := ZEROINT;
    Tipo_Motor.FieldByName('QTD_POLO').AsInteger         := ZEROINT;
    Tipo_Motor.FieldByName('CV_MOT').AsFloat             := ZEROFLOAT;
    Tipo_Motor.FieldByName('FLAG_VND').AsInteger         := FLAG_SIM;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysCalc.CalculoNewRecord(DataSet: TDataSet);
begin
  try
    Calculo.FieldByName('FK_EMPRESAS').AsInteger := Dados.Parametros.EmpresaAtiva;
    Calculo.FieldByName('PK_CALCULOS').AsInteger := 0;
    Calculo.FieldByName('DTA_CALC').AsDateTime   := Date;
  except on E:Exception do
    Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
      'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
      [DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  end;
end;

procedure TdmSysCalc.MotoresBeforeOpen(DataSet: TDataSet);
begin
  if (Motores.Params.Count > 0)                   and
     (Motores.Params.FindParam('Empresa') <> nil) and
     (Motores.Params.FindParam('Calculo') <> nil) then
  begin
    Motores.Params.ParamByName('Empresa').AsInteger  := Calculo.FindField('FK_EMPRESAS').AsInteger;
    Motores.Params.ParamByName('Calculo').AsInteger  := Calculo.FindField('PK_CALCULOS').AsInteger;
  end;
end;

procedure TdmSysCalc.CalculosBeforeOpen(DataSet: TDataSet);
begin
  if (Calculos.Params.Count > 0)                   and
     (Calculos.Params.FindParam('Empresa') <> nil) and
     (Calculos.Params.FindParam('Calculo') <> nil) then
  begin
    Calculos.Params.ParamByName('Empresa').AsInteger := Calculo.FindField('FK_EMPRESAS').AsInteger;
    Calculos.Params.ParamByName('Calculo').AsInteger := Calculo.FindField('PK_CALCULOS').AsInteger;
  end;
end;

procedure TdmSysCalc.CalculoAfterScroll(DataSet: TDataSet);
begin
  if Assigned(MethodWOutPar) then MethodWOutPar;
end;

end.
