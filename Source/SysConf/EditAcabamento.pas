unit EditAcabamento;

interface

uses SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Mask,
     ToolEdit, CurrEdit, Buttons;
type
  TfmEditAcabamento = class(TForm)
    Label1: TStaticText;
    cbTipoAcabamento: TComboBox;
    cmdUpdate: TSpeedButton;
    cmdCancel: TSpeedButton;
    chkOpcional: TCheckBox;
    Label2: TStaticText;
    edQuantidadePadrao: TCurrencyEdit;
    Label3: TStaticText;
    edQuantidadePersonalizada: TCurrencyEdit;
    procedure cmdCancelClick(Sender: TObject);
    procedure SignalizeChange(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
  private
    FFkProduto   : Integer;
    FFkAcabamento: Integer;
    FFkComponente: Integer;
    function  GetDescricaoTipoAcabamento: string;
    function  GetfkTipoAcabamento: Integer;
    function  GetQuantidadePadrao: Double;
    function  GetQuantidadePersonalizada: Double;
    procedure SetFkAcabamento(const Value: Integer);
    procedure SetFkComponente(const Value: Integer);
    procedure SetFkProduto(const Value: Integer);
    { Private declarations }
    procedure LoadTipoAcabamentos;
    procedure ClearAcabamento;
    procedure LoadAcabamento;
    function  GetAcabamentoOpcional: Boolean;
  public
    { Public declarations }
    property FkProduto              : Integer read FFkProduto    write SetFkProduto;
    property FkComponente           : Integer read FFkComponente write SetFkComponente;
    property FkAcabamento           : Integer read FFkAcabamento write SetFkAcabamento;
    property QuantidadePadrao       : Double  read GetQuantidadePadrao;
    property QuantidadePersonalizada: Double  read GetQuantidadePersonalizada;
    property fkTipoAcabamento       : Integer read GetFkTipoAcabamento;
    property DescricaoTipoAcabamento: string  read GetDescricaoTipoAcabamento;
    property AcabamentoOpcional     : Boolean read GetAcabamentoOpcional;
  end;

var
  fmEditAcabamento: TfmEditAcabamento;

implementation

uses mSysConf, Dado, ConfArqSql;

{$R *.dfm}

procedure TfmEditAcabamento.LoadTipoAcabamentos;
begin
  cbTipoAcabamento.Items.Clear;
  with dmSysConf do
  begin
    if qrTypeFinish.Active then qrTypeFinish.Close;
    qrTypeFinish.SQL.Clear;
    qrTypeFinish.SQL.Add(SqlTipoAcabamentoComp);
    try
      qrTypeFinish.ParamByName('FkProdutos').AsInteger        := FFkProduto;
      qrTypeFinish.ParamByName('FkTipoComponentes').AsInteger := FFkComponente;
      qrTypeFinish.ParamByName('FkTipoAcabamentos').AsInteger := FFkAcabamento;
      if not qrTypeFinish.Active then qrTypeFinish.Open;
      while not (qrTypeFinish.EOF) do
      begin
        cbTipoAcabamento.Items.AddObject(qrTypeFinish.FieldByName('DSC_ACABM').AsString,
          TObject(qrTypeFinish.FieldByName('PK_TIPO_ACABAMENTOS').AsInteger));
        qrTypeFinish.Next;
      end;
    finally
      if qrTypeFinish.Active then qrTypeFinish.Close;
    end;
  end
end;

procedure TfmEditAcabamento.ClearAcabamento;
begin
  edQuantidadePadrao.Value        := 0;
  edQuantidadePersonalizada.Value := 0;
  chkOpcional.Checked             := True;
  if cbTipoAcabamento.Items.Count > 0 then
    cbTipoAcabamento.ItemIndex    := 0;
end;

procedure TfmEditAcabamento.LoadAcabamento;
begin
  if ((FfkProduto < 1) or (FFkComponente < 1) or (FFkAcabamento < 1)) then
  begin
    ClearAcabamento;
    exit;
  end;
  with dmSysConf do
  begin
    if Acabamento.Active then Acabamento.Close;
    Acabamento.SQL.Clear;
    Acabamento.SQL.Add(SqlAcabamentos);
    try
      Acabamento.ParamByName('FkProdutos').AsInteger        := FFkProduto;
      Acabamento.ParamByName('FkTipoComponentes').AsInteger := FFkComponente;
      Acabamento.ParamByName('FkTipoAcabamentos').AsInteger := FFkAcabamento;
      if not Acabamento.Active then Acabamento.Open;
      if Acabamento.IsEmpty then
      begin
        ClearAcabamento;
        exit;
      end;
      edQuantidadePadrao.Value        := Acabamento.FieldByName('QTD_PDR').AsFloat;
      edQuantidadePersonalizada.Value := Acabamento.FieldByName('QTD_PERS').AsFloat;
      chkOpcional.Checked             := (Acabamento.FieldByName('FLAG_TACBM').AsInteger = 1);
      cbTipoAcabamento.ItemIndex      :=
        cbTipoAcabamento.Items.IndexOfObject(TObject(FfkAcabamento));
    finally
      if Acabamento.Active then Acabamento.Close;
    end;
  end;
end;

procedure TfmEditAcabamento.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

function TfmEditAcabamento.GetDescricaoTipoAcabamento: string;
begin
  Result := '';
  if cbTipoAcabamento.ItemIndex < 0 then exit;
  Result := cbTipoAcabamento.Items[cbTipoAcabamento.ItemIndex];
end;

function TfmEditAcabamento.GetFkTipoAcabamento: Integer;
begin
  Result := 0;
  if cbTipoAcabamento.ItemIndex < 0 then exit;
  Result := LongInt(cbTipoAcabamento.Items.Objects[cbTipoAcabamento.ItemIndex]);
end;

function TfmEditAcabamento.GetQuantidadePadrao: Double;
begin
  Result := edQuantidadePadrao.Value;
end;

function TfmEditAcabamento.GetQuantidadePersonalizada: Double;
begin
  Result := edQuantidadePersonalizada.Value;
end;

procedure TfmEditAcabamento.SetFkAcabamento(const Value: Integer);
begin
  FfkAcabamento            := Value;
  cbTipoAcabamento.Enabled := (FFkAcabamento < 1);
  LoadTipoAcabamentos;
  LoadAcabamento;
  cmdUpdate.Enabled        := cbTipoAcabamento.Enabled;
end;

procedure TfmEditAcabamento.SetFkComponente(const Value: Integer);
begin
  FfkComponente := Value;
end;

procedure TfmEditAcabamento.SetFkProduto(const Value: Integer);
begin
  FfkProduto := Value;
end;

procedure TfmEditAcabamento.SignalizeChange(Sender: TObject);
begin
  cmdUpdate.Enabled := True;
end;

procedure TfmEditAcabamento.cmdUpdateClick(Sender: TObject);
begin
  with dmSysConf do
  begin
    if Acabamento.Active then Acabamento.Close;
    Acabamento.SQL.Clear;
    if FfkAcabamento < 1 then
      Acabamento.SQL.Add(SqlInsertAcabamento)
    else
      Acabamento.SQL.Add(SqlUpdateAcabamento);
    Dados.StartTransaction(Acabamento);
    try
      Acabamento.ParamByName('FkProdutos').AsInteger        := FFkProduto;
      Acabamento.ParamByName('FkTipoComponentes').AsInteger := FFkComponente;
      Acabamento.ParamByName('FkTipoAcabamentos').AsInteger :=
        LongInt(cbTipoAcabamento.Items.Objects[cbTipoAcabamento.ItemIndex]);
      Acabamento.ParamByName('QtdPdr').AsFloat       := edQuantidadePadrao.Value;
      Acabamento.ParamByName('QtdPers').AsFloat      := edQuantidadePersonalizada.Value;
      Acabamento.ParamByName('FlagTAcbm').AsInteger  := Integer(chkOpcional.Checked);
      Acabamento.ExecSql;
    finally
      if Acabamento.Active then Acabamento.Close;
      Dados.CommitTransaction(Acabamento);
    end;
  end;
  ModalResult := mrOk;
end;

function TfmEditAcabamento.GetAcabamentoOpcional: Boolean;
begin
  Result := chkOpcional.Checked;
end;

end.
