unit SelEmpr;

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

uses SysUtils, Classes, VirtualTrees,
  {$IFNDEF LINUX}
    Controls, Forms, Dialogs, Buttons, StdCtrls, ExtCtrls, ComCtrls
  {$ELSE}
    QControls, QForms, QDialogs, QButtons, QStdCtrls, QExtCtrls, QComCtrls
  {$ENDIF};

type
  TSelEmpresa = class(TForm)
    lTitle: TLabel;
    vtGrid: TVirtualStringTree;
    StatusBar1: TStatusBar;
    gbControl: TGroupBox;
    sbOk: TSpeedButton;
    sbCancel: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure vtGridGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    { Private declarations }
    procedure GetDictionary;
  public
    { Public declarations }
  end;

var
  SelEmpresa: TSelEmpresa;

implementation

uses Dado, CmmConst, ProcType, SqlComm, FuncoesDB;

{$R *.dfm}

procedure TSelEmpresa.FormCreate(Sender: TObject);
begin
  Dados.Image16.GetBitmap(16, sbOk.Glyph);
  Dados.Image16.GetBitmap(55, sbCancel.Glyph);
  GetDictionary;
  with Dados do
  begin
    if qrEmpresa.Active then qrEmpresa.Close;
    qrEmpresa.SQL.Clear;
    qrEmpresa.SQL.Add(SqlEmpresa);
    if (qrEmpresa.Params.FindParam('PkEmpresas') <> nil) then
      qrEmpresa.ParamByName('PkEmpresas').AsInteger := 0;
    if not qrEmpresa.Active then qrEmpresa.Open;
    FillVirtualTreeView(vtGrid, qrEmpresa)
  end;
  if Dados.qrEmpresa.Active then Dados.qrEmpresa.Close;
end;

procedure TSelEmpresa.sbOkClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtGrid.FocusedNode;
  if Node = nil then exit;
  Data := vtGrid.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Dados.Parametros.soNewCompany := Data^.DataRow.FindField['PK_EMPRESAS'].AsInteger;
  if Dados.Parametros.soNewCompany <> Dados.PkCompany then
  begin
    if Dados.ChangeCompany then
      Close
    else
      raise Exception.Create('Parâmetros da Empresa não encontrado');
    Dados.UpdateUser('STP_UPDATE_ACTIVE_USER', 0);
  end
  else
    Close;
end;

procedure TSelEmpresa.sbCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TSelEmpresa.GetDictionary;
var
  DscField,
  FieldName: string;
begin
  with Dados do
  begin
    try
      if FindDictionaryField('EMPRESAS', 'PK_EMPRESAS') then
      begin
        FieldName := qrDicAux.FieldByName('PK_DICIONARIOS__NC').AsString;
        DscField  := qrDicAux.FieldByName('DSC_FLD').AsString;
        if vtGrid.Header.Columns.Count > 0 then
          vtGrid.Header.Columns.Items[0].Text := DscField;
      end;
      if FindDictionaryField('EMPRESAS', 'RAZ_SOC') then
      begin
        FieldName := qrDicAux.FieldByName('PK_DICIONARIOS__NC').AsString;
        DscField  := qrDicAux.FieldByName('DSC_FLD').AsString;
        if vtGrid.Header.Columns.Count > 0 then
          vtGrid.Header.Columns.Items[1].Text := DscField;
      end;
    finally
      if qrDicAux.Active    then qrDicAux.Close;
    end;
  end;
end;

procedure TSelEmpresa.vtGridGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data     := Sender.GetNodeData(Node);
  if (Data = nil) or (Data.DataRow = nil) or (Data.DataRow.Count = 0) then exit;
  CellText := Data.DataRow.Fields[Column].AsString;
end;

end.
