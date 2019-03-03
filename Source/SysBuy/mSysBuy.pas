unit mSysBuy;

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
  TdmSysBuy = class(TDataModule)
    Tabela: TClientDataSet;
    dsAccess: TIBQuery;
    pAccess: TDataSetProvider;
    SqlAux: TIBQuery;
    TrMain: TIBTransaction;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataSetReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure dsAccessAfterClose(DataSet: TDataSet);
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
  dmSysBuy: TdmSysBuy;

implementation

uses AltPass, Funcoes, Autor, CadMod, FuncoesDB, ModelTyp, ArqSql, Dado,
  CmmConst, RecErr, SqlComm, ArqCnst, Math;

{$R *.DFM}

procedure TdmSysBuy.ConfigFiles;
begin
  dsAccess.DataBase      := Dados.Conexao;
  dsAccess.Transaction   := TrMain;
end;

procedure TdmSysBuy.DataModuleDestroy(Sender: TObject);
begin
  if Tabela.Active        then Tabela.Close;
  if dsAccess.Active      then dsAccess.Close;
  if TrMain.InTransaction then TrMain.Commit;
  with Dados do
  begin
    if Tr.InTransaction   then Tr.Commit;
    if Conexao.Connected  then Conexao.Close;
  end;
  dsAccess.DataBase    := nil;
  dsAccess.Transaction := nil;
end;

procedure TdmSysBuy.DataSetReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  Action := HandleReconcileError(DataSet, UpdateKind, E);
end;

procedure TdmSysBuy.dsAccessAfterClose(DataSet: TDataSet);
begin
  if TrMain.InTransaction then
    TrMain.Commit;
end;

end.
