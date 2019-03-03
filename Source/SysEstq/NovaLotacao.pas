unit NovaLotacao;

 {*************************************************************************}
 {*                                                                       *}
 {* Author: CSD Informatica Ltda.                                         *}
 {* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
 {* Created: 02/06/2003                                                   *}
 {* Modified: 02/06/2003                                                  *}
 {* Version: 1.2.0.0                                                      *}
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
  Dialogs, StdCtrls, Buttons, ToolEdit, CurrEdit, ExtCtrls, Mask, ComCtrls,
  ToolWin;

type
  TFakeWinControl = class(TWinControl);

  TfmNovaLotacao = class(TForm)
    eRua_Lot: TCurrencyEdit;
    eNivel_Lot: TCurrencyEdit;
    eBox_Lot: TEdit;
    eFk_Almoxarifados: TComboBox;
    eCod_Ref: TEdit;
    lFk_Almoxarifados: TStaticText;
    lCod_Ref: TStaticText;
    lRua_Lot: TStaticText;
    lNivel_Lot: TStaticText;
    lBox_Lot: TStaticText;
    stDsc_Prod: TStaticText;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbNew: TToolButton;
    tbCancel: TToolButton;
    tbSep: TToolButton;
    tbSave: TToolButton;
    procedure FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure tbCancelClick(Sender : TObject);
    procedure tbSaveClick(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure eCod_RefExit(Sender : TObject);
    procedure eFk_AlmoxarifadosClick(Sender : TObject);
    procedure SignalizeChange(Sender : TObject);
    procedure optInsumoClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
  private
    { Private declarations }
    FFkAlmoxarifados: Integer;
    FFkProdutos: Integer;
    FslAlmoxarifados: TStrings;
    FLotacoesUpdated: Boolean;
    function GetCodRef: String;
    procedure SetCodRef(const Value : String);
    procedure ClearProduto;
    procedure LoadProduto;
    function LotacaoSaved: Boolean;
    function GetBox: String;
    function GetNivel: Integer;
    function GetRua: Integer;
    procedure SetBox(const Value : String);
    procedure SetNivel(const Value : Integer);
    procedure SetRua(const Value : Integer);
  public
    { Public declarations }
    property FkProdutos: Integer Read FFkProdutos;
    property FkAlmoxarifados: Integer Read FFkAlmoxarifados Write FFkAlmoxarifados;
    property CodRef: String Read GetCodRef Write SetCodRef;
    property slAlmoxarifados: TStrings Read FslAlmoxarifados Write FslAlmoxarifados;
    property LotacoesUpdated: Boolean Read FLotacoesUpdated;
    property Rua: Integer Read GetRua Write SetRua;
    property Nivel: Integer Read GetNivel Write SetNivel;
    property Box: String Read GetBox Write SetBox;
  end;

var
  fmNovaLotacao: TfmNovaLotacao;

implementation

uses Dado, mSysEstq, ProcType, DataManager, FMTBcd, DB, SqlExpr,
  EstqArqSql;

{$R *.dfm}

procedure TfmNovaLotacao.FormKeyDown(Sender : TObject; var Key : Word;
  Shift : TShiftState);
begin
  if Key = vk_Escape then
    if Assigned(tbCancel.OnClick) then
      tbCancel.OnClick(Self);
end;

procedure TfmNovaLotacao.tbCancelClick(Sender : TObject);
begin
  Close;
end;

function TfmNovaLotacao.LotacaoSaved: Boolean;
var
  FkLotacao: Integer;
  Rua, Nivel, Box, S: String;
begin
  Result := FALSE;
  if ((ActiveControl <> NIL) and (Assigned(TFakeWinControl(ActiveControl).OnExit))) then
    TFakeWinControl(ActiveControl).OnExit(ActiveControl);
  if eFk_Almoxarifados.ItemIndex < 0 then
  begin
    if eFk_Almoxarifados.CanFocus then eFk_Almoxarifados.SetFocus;
    Dados.DisplayHint(eFk_Almoxarifados, 'O Almoxarifado deve ser especificado !');
    exit;
  end;
  S := '';
  if FFkProdutos < 1 then
    S := 'O Insumo deve ser especificado !';
  if S <> '' then
  begin
    if eCod_Ref.CanFocus then eCod_Ref.SetFocus;
    Dados.DisplayHint(eCod_Ref, S);
    exit;
  end;
  if eRua_Lot.AsInteger < 1 then
  begin
    if eRua_Lot.CanFocus then eRua_Lot.SetFocus;
    Dados.DisplayHint(eCod_Ref, 'A Rua deve ser informada !');
    exit;
  end;
  if eNivel_Lot.AsInteger < 1 then
  begin
    if eNivel_Lot.CanFocus then eNivel_Lot.SetFocus;
    Dados.DisplayHint(eCod_Ref, 'O Nível deve ser informado !');
    exit;
  end;
  eBox_Lot.Text := Trim(eBox_Lot.Text);
  if eBox_Lot.Text = '' then
  begin
    if eBox_Lot.CanFocus then eBox_Lot.SetFocus;
    Dados.DisplayHint(eCod_Ref, 'O Box deve ser informado !');
    exit;
  end;
  Rua   := FormatFloat('00', eRua_Lot.AsInteger);
  Nivel := FormatFloat('00', eNivel_Lot.AsInteger);
  Box   := eBox_Lot.Text;
  fkLotacao := 0;
  with dmSysEstq do
  begin
    if qrLotacao.Active then qrLotacao.Close;
    qrLotacao.SQL.Clear;
    qrLotacao.SQL.Add(SqlLotacoes);
    try
      qrLotacao.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      qrLotacao.ParamByName('FkAlmoxarifados').AsInteger := FfkAlmoxarifados;
      qrLotacao.ParamByName('RuaLot').AsString   := Rua;
      qrLotacao.ParamByName('NivelLot').AsString := Nivel;
      qrLotacao.ParamByName('BoxLot').AsString   := Box;
      if (not qrLotacao.Active) then qrLotacao.Open;
      if (not qrLotacao.EOF) then
        fkLotacao := qrLotacao.FieldByName('PK_LOTACOES').AsInteger;
    finally
      if qrLotacao.Active then qrLotacao.Close;
    end;
    S := '';
    if fkLotacao > 0 then
    begin
      if qrLotacao.Active then qrLotacao.Close;
      qrLotacao.SQL.Clear;
      qrLotacao.SQL.Add(SqlProdutosLotacoes);
      try
        qrLotacao.ParamByName('FkProdutos').AsInteger := FFkProdutos;
        qrLotacao.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
        qrLotacao.ParamByName('FkAlmoxarifados').AsInteger := FfkAlmoxarifados;
        qrLotacao.ParamByName('RuaLot').AsString      := Rua;
        qrLotacao.ParamByName('NivelLot').AsString    := Nivel;
        qrLotacao.ParamByName('BoxLot').AsString      := Box;
        if not qrLotacao.Active then qrLotacao.Open;
        if (not qrLotacao.EOF) and (qrLotacao.FieldByName('FK_LOTACOES').AsInteger > 0) then
          S := 'Este endereço de lotação para este Almoxarifado / Insumo já foi cadastrado !';
      finally
        if qrLotacao.Active then qrLotacao.Close;
      end;
    end;
  end;
  if S <> '' then
  begin
    Dados.DisplayMessage(S, hiError);
    exit;
  end;
  if fkLotacao < 1 then
  begin
    with dmSysEstq do
    begin
      if qrLotacao.Active then qrLotacao.Close;
      qrLotacao.SQL.Clear;
      qrLotacao.SQL.Add(SqlInsLotacoes);
      try
        qrLotacao.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
        qrLotacao.ParamByName('FkAlmoxarifados').AsInteger := FfkAlmoxarifados;
        qrLotacao.ParamByName('RuaLot').AsString           := Rua;
        qrLotacao.ParamByName('NivelLot').AsString         := Nivel;
        qrLotacao.ParamByName('BoxLot').AsString           := Box;
        qrLotacao.ExecSql;
      finally
        if qrLotacao.Active then qrLotacao.Close;
      end;
      if qrSqlAux.Active then qrSqlAux.Close;
      qrSqlAux.SQL.Clear;
      qrSqlAux.SQL.Add(SqlGetPkLotacao);
      try
        qrSqlAux.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
        qrSqlAux.ParamByName('FkAlmoxarifados').AsInteger := FfkAlmoxarifados;
        qrSqlAux.ParamByName('RuaLot').AsString           := Rua;
        qrSqlAux.ParamByName('NivelLot').AsString         := Nivel;
        qrSqlAux.ParamByName('BoxLot').AsString           := Box;
        if not qrSqlAux.Active then qrSqlAux.Open;
        if not (qrSqlAux.EOF) then
          FkLotacao := qrSqlAux.FieldByName('FK_LOTACOES').AsInteger;
      finally
        if qrSqlAux.Active then qrSqlAux.Close;
      end;
    end;
  end;
  with dmSysEstq do
  begin
    if qrLotacao.Active then qrLotacao.Close;
    qrLotacao.SQL.Clear;
    qrLotacao.SQL.Add(SqlInsertProdLot);
    Dados.StartTransaction(qrLotacao);
    try
      qrLotacao.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
      qrLotacao.ParamByName('FkProdutos').AsInteger      := FFkProdutos;
      qrLotacao.ParamByName('FkAlmoxarifados').AsInteger := FFkAlmoxarifados;
      qrLotacao.ParamByName('FkLotacoes').AsInteger      := FkLotacao;
      qrLotacao.ParamByName('QtdLot').AsInteger          := 0;
      qrLotacao.ExecSQL;
      Dados.CommitTransaction(qrLotacao);
    except on E:Exception do
      begin
        Dados.RollbackTransaction(qrLotacao);
        raise Exception.Create('SaveLotation: Erro ao salvar a lotação' + E.Message);
      end;
    end;
  end;
  Result := False;
  FLotacoesUpdated := True;
  tbSave.Enabled := False;
end;

procedure TfmNovaLotacao.tbSaveClick(Sender : TObject);
begin
  if LotacaoSaved then
    Dados.DisplayHint(Self, 'Lotação Incluída com sucesso !');
  Close;
end;

function TfmNovaLotacao.GetCodRef: String;
begin
  Result := eCod_Ref.Text;
end;

procedure TfmNovaLotacao.SetCodRef(const Value : String);
begin
  eCod_Ref.Text     := Value;
  eCod_Ref.Modified := TRUE;
end;

procedure TfmNovaLotacao.FormShow(Sender : TObject);
begin
  if FslAlmoxarifados <> NIL then
    eFk_Almoxarifados.Items.Assign(FslAlmoxarifados)
  else
    eFk_Almoxarifados.Items.Clear;
  eFk_Almoxarifados.ItemIndex :=
    eFk_Almoxarifados.Items.IndexOfObject(TObject(FfkAlmoxarifados));
  if Assigned(eFk_Almoxarifados.OnClick) then
    eFk_Almoxarifados.OnClick(eFk_Almoxarifados);
  if Assigned(eCod_Ref.OnExit) then
    eCod_Ref.OnExit(eCod_Ref);
end;

procedure TfmNovaLotacao.ClearProduto;
begin
  FFkProdutos        := 0;
  stDsc_Prod.Caption := '';
end;

procedure TfmNovaLotacao.LoadProduto;
begin
  ClearProduto;
  with dmSysEstq do
  begin
    if qrProduct.Active then qrProduct.Close;
    qrProduct.SQL.Clear;
    qrProduct.SQL.Add(SqlProdutosReq);
    try
      qrProduct.ParamByName('CodRef').AsString := eCod_Ref.Text;
      if not qrProduct.Active then qrProduct.Open;
      if (not qrProduct.EOF) then
      begin
        stDsc_Prod.Caption := qrProduct.FieldByName('DSC_PROD').AsString;
        FFkProdutos        := qrProduct.FieldByName('PK_PRODUTOS').AsInteger;
      end
      else
      begin
        Dados.DisplayHint(eCod_Ref, 'Produto ' + eCod_Ref.Text + ' não encontrado!');
        eCod_Ref.Text := '';
      end;
    finally
      if qrProduct.Active then qrProduct.Close;
    end;
  end;
end;

procedure TfmNovaLotacao.eCod_RefExit(Sender : TObject);
begin
  if not (eCod_Ref.Modified) then exit;
  LoadProduto;
  SignalizeChange(Sender);
end;

procedure TfmNovaLotacao.eFk_AlmoxarifadosClick(Sender : TObject);
begin
  if eFk_Almoxarifados.ItemIndex < 0 then
    FfkAlmoxarifados := 0
  else
    FfkAlmoxarifados := LongInt(eFk_Almoxarifados.Items.Objects[
      eFk_Almoxarifados.ItemIndex]);
  SignalizeChange(Sender);
end;

procedure TfmNovaLotacao.SignalizeChange(Sender : TObject);
begin
  if not (tbSave.Enabled) then
    tbSave.Enabled := True;
end;

procedure TfmNovaLotacao.optInsumoClick(Sender : TObject);
begin
  ClearProduto;
  SignalizeChange(Sender);
end;

function TfmNovaLotacao.GetBox: String;
begin
  Result := Trim(eBox_Lot.Text);
end;

function TfmNovaLotacao.GetNivel: Integer;
begin
  Result := eNivel_Lot.AsInteger;
end;

function TfmNovaLotacao.GetRua: Integer;
begin
  Result := eRua_Lot.AsInteger;
end;

procedure TfmNovaLotacao.SetBox(const Value : String);
begin
  eBox_Lot.Text := Trim(Copy(Value, 1, 2));
end;

procedure TfmNovaLotacao.SetNivel(const Value : Integer);
begin
  if ((Value > -1) and (Value < 100)) then
    eNivel_Lot.AsInteger := Value;
end;

procedure TfmNovaLotacao.SetRua(const Value : Integer);
begin
  if ((Value > -1) and (Value < 100)) then
    eRua_Lot.AsInteger := Value;
end;

procedure TfmNovaLotacao.FormCreate(Sender : TObject);
begin
  tbTools.Images := Dados.Image16;
  cbTools.Images := Dados.Image16;
end;

end.
