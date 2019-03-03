unit CadDiv;

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

uses SysUtils, Classes, ProcType, CadMod, CurrEdit, TSysMan, Mask, ProcUtils,
  GridRow, Encryp, Enter, prcNavigator, VirtualTrees, DataManager,
  {$IFNDEF LINUX}
    Windows, Controls, Forms, Dialogs, Menus, Buttons, StdCtrls, ExtCtrls,
    ComCtrls, ToolWin, ToolEdit
  {$ELSE}
    Qt, QGraphics, QControls, QForms, QDialogs, QMenus, QButtons, QStdCtrls,
    QExtCtrls, QComCtrls, QToolWin, QToolEdit
  {$ENDIF};

type
  TCdDivisoes = class(TCdModelo)
    pgDiv: TPageControl;
    lFk_Tipo_Documentos: TStaticText;
    eFk_Tipo_Documentos: TComboBox;
    lPk_Divisoes: TStaticText;
    ePk_Divisoes: TEdit;
    eDsc_Div: TEdit;
    lDsc_Div: TStaticText;
    lMin_Line: TStaticText;
    eMin_Line: TEdit;
    lMax_Line: TStaticText;
    eMax_Line: TEdit;
    eNiv_Div: TEdit;
    lNiv_Div: TStaticText;
    eSql_Div: TMemo;
    lSql_Div: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dsMainGetDictionary(Sender: TObject; APopulateSql: Boolean;
      var ALoaded: Boolean);
    procedure dsMainBeforePost(ASender: TDataManager; ADataRow: TDataRow;
      Mode: TDBMode);
    procedure dsMainAfterPost(ASender: TDataManager; ADataRow: TDataRow;
      Mode: TDBMode);
  private
    { Private declarations }
    FTDocIndex: Integer;
    FDivFields: TStrings;
    procedure SaveFields;
  public
    { Public declarations }
  end;

implementation

uses mSysMan, ManArqSql, Dado, ForeTabl, Funcoes, FuncoesDB,
     CmmConst, ModelTyp;

{$R *.dfm}

procedure TCdDivisoes.FormActivate(Sender: TObject);
var
  aItem: TForeignTable;
begin
  pgDiv.ActivePageIndex := 0;
  dsMain.DataSet        := dmSysMan.Divisao;
  dsMain.MethodExecSql  := dmSysMan.Divisao.ExecSQL;
  dsMain.TableName      := 'DIVISOES';
  dsMain.MainPrefix     := 'Div';     
  dsMain.PrimaryKey.Add('FK_TIPO_DOCUMENTOS');
  dsMain.PrimaryKey.Add('PK_DIVISOES');
  aItem             := dsMain.ForeignTables.Add;
  aItem.TableName   := 'TIPO_DOCUMENTOS';
  aItem.JoinType    := jtLeftOuterJoin;
  aItem.JoinPrefix  := 'Tdc';
  aItem.SelectField := 'DSC_TDOC';
  aItem.MainField   := 'FK_TIPO_DOCUMENTOS';
  aItem.JoinFields.Add('PK_TIPO_DOCUMENTOS=FK_TIPO_DOCUMENTOS');
  eFk_Tipo_Documentos.Items.AddStrings(dmSysMan.LoadTypeDocs);
  FDivFields        := TStringList.Create;
  inherited;
end;

procedure TCdDivisoes.FormDestroy(Sender: TObject);
begin
  FDivFields.Free;
  FDivFields := nil;
  inherited;
end;

procedure TCdDivisoes.SaveFields;
var
  i: Integer;
begin
  if FDivFields.Count = 0 then exit;
  with dmSysMan do
  begin
    if Campo.Active then Campo.Close;
    Campo.SQL.Clear;
    Campo.SQL.Add(SqlDeleteCampos);
    Dados.Conexao.StartTransaction(Dados.GetTr(Dados.FTr));
    if (Campo.Params.FindParam('FkEmpresas') <> nil) then
      Campo.Params.FindParam('FkEmpresas').AsInteger       := Dados.PkCompany;
    if (Campo.Params.FindParam('FkTipoDocumentos') <> nil) then
      Campo.Params.FindParam('FkTipoDocumentos').AsInteger := dsMain.FieldByName('FK_TIPO_DOCUMENTOS').AsInteger;
    if (Campo.Params.FindParam('FkDivisoes') <> nil) then
      Campo.Params.FindParam('FkDivisoes').AsInteger       := dsMain.FieldByName('PK_DIVISOES').AsInteger;
    Campo.ExecSQL;
    Dados.Conexao.Commit(Dados.GetTr(Dados.FTr));
    Campo.SQL.Clear;
    Campo.SQL.Add(SqlInsertCampos);
    Dados.Conexao.StartTransaction(Dados.GetTr(Dados.FTr));
    Campo.Prepared := True;
    for i := 0 to FDivFields.Count - 1 do
    begin
      if Campo.Params.FindParam('FkEmpresas') <> nil then
        Campo.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
      if Campo.Params.FindParam('FkTipoDocumentos') <> nil then
        Campo.Params.FindParam('FkTipoDocumentos').AsInteger :=
        dsMain.FieldByName('FK_TIPO_DOCUMENTOS').AsInteger;
      if Campo.Params.FindParam('FkDivisoes') <> nil then
        Campo.Params.FindParam('FkDivisoes').AsInteger :=
          dsMain.FieldByName('PK_DIVISOES').AsInteger;
      if Campo.Params.FindParam('PkCampos') <> nil then
        Campo.Params.FindParam('PkCampos').AsInteger := i;
      if Campo.Params.FindParam('DscCmp') <> nil then
        Campo.Params.FindParam('DscCmp').AsString := FDivFields.Strings[i];
      if Campo.Params.FindParam('CmpCmp') <> nil then
        Campo.Params.FindParam('CmpCmp').AsString := FDivFields.Strings[i];
      try
        Campo.ExecSQL;
      except on E:Exception do
        begin
          Dados.Conexao.Rollback(Dados.GetTr(Dados.FTr));
          raise Exception.Create(E.Message);
        end;
      end;
    end;
    Dados.Conexao.Commit(Dados.GetTr(Dados.FTr));
  end;
end;

procedure TCdDivisoes.dsMainGetDictionary(Sender: TObject;
  APopulateSql: Boolean; var ALoaded: Boolean);
begin
  inherited;
  try
    dsMain.DataRow.FieldByName['FK_EMPRESAS'].DefaultValue        := Dados.PkCompany;
    dsMain.DataRow.FieldByName['FK_TIPO_DOCUMENTOS'].DefaultValue := ZEROINT;
    dsMain.DataRow.FieldByName['PK_DIVISOES'].DefaultValue        := ZEROINT;
    dsMain.DataRow.FieldByName['NIV_DIV'].DefaultValue            := 1;
    dsMain.DataRow.FieldByName['MAX_LINE'].DefaultValue           := 1;
    dsMain.DataRow.FieldByName['MIN_LINE'].DefaultValue           := 1;
  except on E:Exception do
    Dados.DisplayMessage(Format(VarModel[Integer(tcDataSetInsError)],
      [dsMain.TableName]) + #13 + E.Message, hiError);
  end;
end;

procedure TCdDivisoes.dsMainBeforePost(ASender: TDataManager;
  ADataRow: TDataRow; Mode: TDBMode);
var
  i: Integer;
begin
  if (eSql_Div.Lines.Count > 0) then
  begin
    Application.MessageBox(PAnsiChar('Campos: Você deve informar uma instrução SQL antes'),
      PAnsiChar(Application.Title), MB_ICONWARNING + MB_OK);
    exit;
  end;
  with dmSysMan do
  begin
    if SqlAux.Active then SqlAux.Close;
    SqlAux.SQL.Clear;
    SqlAux.SQL.AddStrings(eSql_Div.Lines);
    try
      for i := 0 to SqlAux.Params.Count - 1 do
        SqlAux.Params[i].Clear;
      SqlAux.Open;
      for i := 0 to SqlAux.FieldCount - 1 do
        FDivFields.Add(SqlAux.Fields[i].FieldName);
    except on E:Exception do
      begin
        if SqlAux.Active then SqlAux.Close;
        raise Exception.Create('Sql da Divisão: Erro ao executar SQL.' + NL +
          E.Message);
      end;
    end;
    if SqlAux.Active then SqlAux.Close;
  end;
end;

procedure TCdDivisoes.dsMainAfterPost(ASender: TDataManager;
  ADataRow: TDataRow; Mode: TDBMode);
begin
  inherited;
  SaveFields;
end;

initialization
  Classes.RegisterClass(TCdDivisoes);
end.

