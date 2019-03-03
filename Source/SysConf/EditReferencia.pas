unit EditReferencia;

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
  Dialogs, StdCtrls, Buttons;

type
  TfmEditReferencia = class(TForm)
    cbTipoReferencia: TComboBox;
    cmdUpdate: TSpeedButton;
    cmdCancel: TSpeedButton;
    chkFLAG_ATIVO: TCheckBox;
    StaticText1: TStaticText;
    procedure cmdCancelClick(Sender: TObject);
    procedure SignalizeChange(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
  private
    FFkAcabamento: Integer;
    FFkReferencia: Integer;
    FFkComponente: Integer;
    FFkProduto   : Integer;
    FFkEmpresa   : Integer;
    { Private declarations }
    procedure LoadTipoReferencias;
    procedure ClearReferencia;
    procedure LoadReferencia;
    function  GetDescricaoTipoReferencia: string;
    function  GetFkTipoReferencia: Integer;
    procedure SetFkAcabamento(const Value: Integer);
    procedure SetFkComponente(const Value: Integer);
    procedure SetFkProduto   (const Value: Integer);
    procedure SetFkReferencia(const Value: Integer);
    procedure SetFkEmpresa   (const Value: Integer);
    function  GetReferenciaAtiva: Boolean;
  public
    { Public declarations }
    property FkEmpresa              : Integer read FFkEmpresa    write SetFkEmpresa;
    property FkProduto              : Integer read FFkProduto    write SetFkProduto;
    property FkComponente           : Integer read FFkComponente write SetFkComponente;
    property FkAcabamento           : Integer read FFkAcabamento write SetFkAcabamento;
    property FkReferencia           : Integer read FFkReferencia write SetFkReferencia;
    property FkTipoReferencia       : Integer read GetFkTipoReferencia;
    property DescricaoTipoReferencia: string  read GetDescricaoTipoReferencia;
    property ReferenciaAtiva        : Boolean read GetReferenciaAtiva;
  end;

var
  fmEditReferencia: TfmEditReferencia;

implementation

uses mSysConf, Dado, ConfArqSql;

{$R *.dfm}

{ TfmEditReferencia }

procedure TfmEditReferencia.ClearReferencia;
begin
  if cbTipoReferencia.Items.Count > 0 then
    cbTipoReferencia.ItemIndex := 0;
  chkFLAG_ATIVO.Checked := False;
end;

function TfmEditReferencia.GetDescricaoTipoReferencia: string;
begin
  Result := '';
  if cbTipoReferencia.ItemIndex < 0 then exit;
  Result := cbTipoReferencia.Items[cbTipoReferencia.ItemIndex];
end;

function TfmEditReferencia.GetfkTipoReferencia: Integer;
begin
  Result := 0;
  if cbTipoReferencia.ItemIndex < 0 then exit;
  Result := LongInt(cbTipoReferencia.Items.Objects[cbTipoReferencia.ItemIndex]);
end;

procedure TfmEditReferencia.LoadReferencia;
begin
  with dmSysConf do
  begin
    if Referencia.Active then Referencia.Close;
    Referencia.SQL.Clear;
    Referencia.SQL.Add(SqlReferencias);
    Dados.StartTransaction(Referencia);
    try
      Referencia.ParamByName('FkEmpresas').AsInteger        := FFkEmpresa;
      Referencia.ParamByName('FkProdutos').AsInteger        := FFkProduto;
      Referencia.ParamByName('FkTipoComponentes').AsInteger := FFkComponente;
      Referencia.ParamByName('FkTipoAcabamentos').AsInteger := FFkAcabamento;
      Referencia.ParamByName('FkTipoReferencias').AsInteger := FFkReferencia;
      if not Referencia.Active then Referencia.Open;
      if Referencia.IsEmpty then
      begin
        ClearReferencia;
        exit;
      end;
      cbTipoReferencia.ItemIndex :=
        cbTipoReferencia.Items.IndexOfObject(TObject(FfkReferencia));
      chkFLAG_ATIVO.Checked := (Referencia.FieldByName('FLAG_ATIVO').AsInteger <> 0);
    finally
      Close;
      Dados.CommitTransaction(Referencia);
    end;
  end;
end;

procedure TfmEditReferencia.LoadTipoReferencias;
begin
  cbTipoReferencia.Items.Clear;
  with dmSysConf do
  begin
    if qrTypeRef.Active then qrTypeRef.Close;
    qrTypeRef.SQL.Clear;
    qrTypeRef.SQL.Add(SqlTipoReferencias);
    Dados.StartTransaction(qrTypeRef);
    try
      qrTypeRef.ParamByName('FkEmpresas').AsInteger        := FFkEmpresa;
      qrTypeRef.ParamByName('FkProdutos').AsInteger        := FFkProduto;
      qrTypeRef.ParamByName('FkTipoComponentes').AsInteger := FFkComponente;
      qrTypeRef.ParamByName('FkTipoAcabamentos').AsInteger := FFkAcabamento;
      qrTypeRef.ParamByName('FkTipoReferencias').AsInteger := FFkReferencia;
      if not qrTypeRef.Active then qrTypeRef.Open;
      while not (qrTypeRef.EOF) do
      begin
        cbTipoReferencia.Items.AddObject(qrTypeRef.FieldByName('DSC_REF').AsString,
          TObject(qrTypeRef.FieldByName('PK_TIPO_REFERENCIAS').AsInteger));
        qrTypeRef.Next;
      end;
    finally
      if qrTypeRef.Active then qrTypeRef.Close;
      Dados.CommitTransaction(qrTypeRef);
    end;
  end;
end;

procedure TfmEditReferencia.SetFkAcabamento(const Value: Integer);
begin
  FFkAcabamento := Value;
end;

procedure TfmEditReferencia.SetFkComponente(const Value: Integer);
begin
  FFkComponente := Value;
end;

procedure TfmEditReferencia.SetFkEmpresa(const Value: Integer);
begin
  FFkEmpresa := Value;
end;

procedure TfmEditReferencia.SetFkProduto(const Value: Integer);
begin
  FFkProduto := Value;
end;

procedure TfmEditReferencia.SetFkReferencia(const Value: Integer);
begin
  FFkReferencia := Value;
  cbTipoReferencia.Enabled := (FFkReferencia < 1);
  LoadTipoReferencias;
  LoadReferencia;
  cmdUpdate.Enabled := cbTipoReferencia.Enabled;
end;

procedure TfmEditReferencia.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmEditReferencia.SignalizeChange(Sender: TObject);
begin
  cmdUpdate.Enabled := True;
end;

procedure TfmEditReferencia.cmdUpdateClick(Sender: TObject);
begin
  if (cbTipoReferencia.ItemIndex < 0) then exit;
  with dmSysConf do
  begin
    if Referencia.Active then Referencia.Close;
    Referencia.SQL.Clear;
    Referencia.Params.Clear;
    if FfkReferencia < 1 then
      Referencia.SQL.Add(SqlInsertReferencias)
    else
      Referencia.SQL.Add(SqlUpdateReferencias);
    Dados.StartTransaction(Referencia);
    try
      Referencia.ParamByName('FkEmpresas').AsInteger        := FfkEmpresa;
      Referencia.ParamByName('FkProdutos').AsInteger        := FfkProduto;
      Referencia.ParamByName('FkTipoComponentes').AsInteger := FfkComponente;
      Referencia.ParamByName('FkTipoAcabamentos').AsInteger := FfkAcabamento;
      Referencia.ParamByName('FkTipoReferencias').AsInteger :=
        LongInt(cbTipoReferencia.Items.Objects[cbTipoReferencia.ItemIndex]);
      Referencia.ParamByName('FlagAtivo').AsInteger         := Integer(chkFLAG_ATIVO.Checked);
      Referencia.ExecSql;
    finally
      if Referencia.Active then Referencia.Close;
      Dados.CommitTransaction(Referencia);
    end;
  end;
  ModalResult := mrOk;
end;

function TfmEditReferencia.GetReferenciaAtiva: Boolean;
begin
  Result := chkFLAG_ATIVO.Checked;
end;

end.
