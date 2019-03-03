unit EditComponente;

{*************************************************************************}
{*                                                                       *}
{* Author: CSD Informatica Ltda.                                         *}
{* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
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
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TfmEditComponente = class(TForm)
    Label1: TStaticText;
    cbTipoComponente: TComboBox;
    Label2: TStaticText;
    edQuantidade: TCurrencyEdit;
    cmdUpdate: TSpeedButton;
    cmdCancel: TSpeedButton;
    procedure SignalizeChange(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    FFkComponente: Integer;
    FFkProduto   : Integer;
    procedure SetFkComponente(const Value: Integer);
    procedure SetFkProduto   (const Value: Integer);
    procedure LoadTipoComponentes;
    procedure ClearComponente;
    procedure LoadComponente;
    function  GetFkTipoComponente: Integer;
    function  GetQuantidade: Double;
    function  GetDescricaoTipoComponente: string;
    { Private declarations }
  public
    { Public declarations }
    property FkProduto              : Integer read FFkProduto    write SetFkProduto;
    property FkComponente           : Integer read FFkComponente write SetFkComponente;
    property Quantidade             : Double  read GetQuantidade;
    property fkTipoComponente       : Integer read GetFkTipoComponente;
    property DescricaoTipoComponente: string  read GetDescricaoTipoComponente;
  end;

var
  fmEditComponente: TfmEditComponente;

implementation

uses mSysConf, ConfArqSql, Dado;

{$R *.dfm}

procedure TfmEditComponente.LoadTipoComponentes;
begin
  cbTipoComponente.Items.Clear;
  with dmSysConf do
  begin
    if qrTypeCmpnt.Active then qrTypeCmpnt.Close;
    qrTypeCmpnt.SQL.Clear;
    qrTypeCmpnt.SQL.Add(SqlTipoCompoProdutos);
    Dados.StartTransaction(qrTypeCmpnt);
    try
      qrTypeCmpnt.ParamByName('FkProdutos').AsInteger        := FFkProduto;
      qrTypeCmpnt.ParamByName('FkTipoComponentes').AsInteger := FFkComponente;
      if not qrTypeCmpnt.Active then qrTypeCmpnt.Open;
      while not (qrTypeCmpnt.EOF) do
      begin
        cbTipoComponente.Items.AddObject(qrTypeCmpnt.FieldByName('DSC_TCOMP').AsString,
          TObject(qrTypeCmpnt.FieldByName('PK_TIPO_COMPONENTES').AsInteger));
        qrTypeCmpnt.Next;
      end;
    finally
      if qrTypeCmpnt.Active then qrTypeCmpnt.Close;
      Dados.CommitTransaction(qrTypeCmpnt);
    end;
  end;
end;

procedure TfmEditComponente.ClearComponente;
begin
  edQuantidade.Value := 0;
  if cbTipoComponente.Items.Count > 0 then cbTipoComponente.ItemIndex := 0;
end;

procedure TfmEditComponente.LoadComponente;
begin
  if ((FfkProduto < 1) or (FFkComponente < 1)) then
  begin
    ClearComponente;
    exit;
  end;
  with dmSysConf do
  begin
    if Componente.Active then Componente.Close;
    Componente.SQL.Clear;
    Componente.SQL.Add(SqlComponentes1);
    Componente.SQL.Add(SqlComponentes2);
    Dados.StartTransaction(Componente);
    try
      Componente.ParamByName('FkProdutos').AsInteger        := FFkProduto;
      Componente.ParamByName('FkTipoComponentes').AsInteger := FFkComponente;
      if Componente.Active then Componente.Open;
      if not Componente.IsEmpty then
      begin
        edQuantidade.Value := Componente.FieldByName('QTD_COMP').AsFloat;
        cbTipoComponente.ItemIndex :=
          cbTipoComponente.Items.IndexOfObject(TObject(FFkComponente));
      end
      else
        ClearComponente;
    finally
      if Componente.Active then Componente.Close;
      Dados.CommitTransaction(Componente);
    end;
  end;
end;

procedure TfmEditComponente.SetfkComponente(const Value: Integer);
begin
  FFkComponente := Value;
  cbTipoComponente.Enabled := (FFkComponente < 1);
  LoadTipoComponentes;
  LoadComponente;
  cmdUpdate.Enabled := cbTipoComponente.Enabled;
end;

procedure TfmEditComponente.SetfkProduto(const Value: Integer);
begin
  if FFkProduto = Value then exit;
  FFkProduto := Value;
end;

procedure TfmEditComponente.SignalizeChange(Sender: TObject);
begin
  cmdUpdate.Enabled := True;
end;

procedure TfmEditComponente.cmdUpdateClick(Sender: TObject);
begin
  if (cbTipoComponente.ItemIndex < 0) then exit;
  with dmSysConf do
  begin
    if Componente.Active then Componente.Close;
    Componente.SQL.Clear;
    if FfkComponente < 1 then
      Componente.SQL.Add(SqlInsertComponente)
    else
      Componente.SQL.Add(SqlUpdateComponente);
    Dados.StartTransaction(Componente);
    try
      Componente.ParamByName('FkProdutos').AsInteger := FFkProduto;
      Componente.ParamByName('FkTipoComponentes').AsInteger :=
        LongInt(cbTipoComponente.Items.Objects[cbTipoComponente.ItemIndex]);
      Componente.ParamByName('QtdComp').AsFloat      := edQuantidade.Value;
      Componente.ExecSql;
    finally
      Close;
      Dados.CommitTransaction(Componente);
    end;
  end;
  ModalResult := mrOk;
end;

function TfmEditComponente.GetQuantidade: Double;
begin
  Result := edQuantidade.Value;
end;

function TfmEditComponente.GetfkTipoComponente: Integer;
begin
  Result := 0;
  if cbTipoComponente.ItemIndex < 0 then exit;
  Result := LongInt(cbTipoComponente.Items.Objects[cbTipoComponente.ItemIndex]);
end;

procedure TfmEditComponente.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

function TfmEditComponente.GetDescricaoTipoComponente: string;
begin
  Result := '';
  if cbTipoComponente.ItemIndex < 0 then exit;
  Result := cbTipoComponente.Items[cbTipoComponente.ItemIndex];
end;

end.
