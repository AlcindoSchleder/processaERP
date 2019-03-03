unit EditFaseProducao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, CurrEdit, ExtCtrls, IBQuery;

type
  TUpdateFaseProducaoEvent=procedure (Sender:TObject;afkPecas,afkFichaTecnica,afkFaseProducao:Integer) of object;

  TfmEditFaseProducao = class(TForm)
    Label1: TLabel;
    cbFaseProducao: TComboBox;
    Shape1: TShape;
    laPecaPaiTitle: TLabel;
    laPecaPai: TLabel;
    Label3: TLabel;
    edSEQ_FASE: TCurrencyEdit;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    cmdNew: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FfkPecas              : Integer;
    FfkFichaTecnica       : Integer;
    FfkFaseProducao       : Integer;
    FOnInsertFaseProducao : TUpdateFaseProducaoEvent;
    FOnUpdateFaseProducao : TUpdateFaseProducaoEvent;
    FUpdateAllowed: Boolean;
    { Private declarations }
    procedure LoadTiposFaseProducao;
    procedure SetfkPecas(const Value: Integer);
    procedure SetfkFaseProducao(const Value: Integer);
    procedure ClearFaseProducao;
    procedure LoadFaseProducao;
    procedure SetOnInsertFaseProducao(
      const Value: TUpdateFaseProducaoEvent);
    procedure SetOnUpdateFaseProducao(
      const Value: TUpdateFaseProducaoEvent);
    procedure SetUpdateAllowed(const Value: Boolean);
  public
    { Public declarations }
    property UpdateAllowed:Boolean read FUpdateAllowed write SetUpdateAllowed;
    property fkFichaTecnica:Integer read FfkFichaTecnica write FfkFichaTecnica;
    property fkPecas:Integer read FfkPecas write SetfkPecas;
    property fkFaseProducao:Integer read FfkFaseProducao
      write SetfkFaseProducao;
    property OnInsertFaseProducao:TUpdateFaseProducaoEvent
      read FOnInsertFaseProducao write SetOnInsertFaseProducao;
    property OnUpdateFaseProducao:TUpdateFaseProducaoEvent
      read FOnUpdateFaseProducao write SetOnUpdateFaseProducao;
  end;

var
  fmEditFaseProducao: TfmEditFaseProducao;

implementation

uses udmFichaTecnica;

{$R *.dfm}

{ TfmEditFaseProducao }

procedure TfmEditFaseProducao.LoadTiposFaseProducao;
begin
  cbFaseProducao.Items.Clear;
  with dmFichaTecnica.qrTipoFasesProducao do
    try
      Open;
      while Not(EOF) do
        begin
        cbFaseProducao.Items.AddObject(
          FieldByName('DSC_FASE').AsString,TObject(
          FieldByName('PK_TIPO_FASES_PRODUCAO').AsInteger));
        Next;
        end;
    finally
      Close;
      end;
end;

procedure TfmEditFaseProducao.FormCreate(Sender: TObject);
begin
  LoadTiposFaseProducao;
end;

procedure TfmEditFaseProducao.SetfkPecas(const Value: Integer);
begin
  FfkPecas := Value;
end;

procedure TfmEditFaseProducao.SetfkFaseProducao(const Value: Integer);
begin
  FfkFaseProducao := Value;
end;

procedure TfmEditFaseProducao.ClearFaseProducao;
var
  S:String;
begin
  with dmFichaTecnica.qrPeca do
    try
      ParamByName('pk_pecas').AsInteger:=FfkPecas;
      ParamByName('fk_ficha_tecnica').AsInteger:=FfkFichaTecnica;
      Open;
      if EOF then
        begin
        S:='Erro: Peça com pk_pecas='+IntToStr(FfkPecas)+
          ' não encontrada !';
        MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONSTOP);
        PostMessage(Self.Handle,WM_CLOSE,0,0);
        Exit;
        end;
      laPecaPai.Caption:=FieldByName('DSC_PEC').AsString;
    finally
      Close;
      end;
  edSEQ_FASE.AsInteger    :=0;
  //chkFLAG_ACBM.Checked    :=FALSE;
  cmdUpdate.Visible       := FUpdateAllowed;
  cmdNew.Visible          := FUpdateAllowed;
  cbFaseProducao.Enabled  := ((FUpdateAllowed) and (FfkFaseProducao < 1));
  edSeq_fase.Enabled      := FUpdateAllowed;
  //chkFlag_acbm.Enabled    :=FUpdateAllowed;
end;

procedure TfmEditFaseProducao.LoadFaseProducao;
var
  S:String;
begin
  ClearFaseProducao;
  if FfkFaseProducao<1 then
    Exit;
  with dmFichaTecnica.qrFaseProducao do
    try
      ParamByName('fk_pecas').AsInteger          :=FfkPecas;
      ParamByName('fk_ficha_tecnica').AsInteger  :=FfkFichaTecnica;
      ParamByName('pk_fases_producao').AsInteger :=FfkFaseProducao;
      Open;
      if EOF then
        begin
        S:='Erro: Fase de Produção com fk_pecas='+IntToStr(
          FfkPecas)+' e pk_fases_producao='+IntToStr(FfkFaseProducao)+
          ' não encontrada !';
        MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONSTOP);
        PostMessage(Self.Handle,WM_CLOSE,0,0);
        Exit;
        end;
      cbFaseProducao.ItemIndex :=
        cbFaseProducao.Items.IndexOfObject(
        TObject(FieldByName('fk_tipo_fases_producao').AsInteger));
      edSEQ_FASE.AsInteger     :=FieldByName('SEQ_FASE').AsInteger;
      //chkFLAG_ACBM.Checked     :=(FieldByName('FLAG_ACBM').AsInteger<>0);
    finally
      Close;
      end;
end;

procedure TfmEditFaseProducao.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmEditFaseProducao.cmdNewClick(Sender: TObject);
begin
  FfkFaseProducao:=0;
  ClearFaseProducao;
end;

procedure TfmEditFaseProducao.cmdUpdateClick(Sender: TObject);
var
  afkTipoFaseProducao :Integer;
  aQuery              :TIBQuery;
begin
  if cbFaseProducao.ItemIndex<0 then
    begin
    if cbFaseProducao.CanFocus then
      cbFaseProducao.SetFocus;
    MessageBox(Self.Handle,
      'O Tipo de Fase de Produção deve ser escolhido !',PChar(Caption),MB_ICONSTOP);
    Exit;
    end;
  afkTipoFaseProducao:=LongInt(
    cbFaseProducao.Items.Objects[cbFaseProducao.ItemIndex]);
  if FfkFaseProducao<1 then
    aQuery:=dmFichaTecnica.qrInsertFaseProducao
  else
    aQuery:=dmFichaTecnica.qrUpdateFaseProducao;
  with aQuery do
    try
      ParamByName('fk_pecas').AsInteger              :=FfkPecas;
      ParamByName('fk_ficha_tecnica').AsInteger      :=FfkFichaTecnica;
      ParamByName('fk_tipo_fases_producao').AsInteger:=afkTipoFaseProducao;
      ParamByName('seq_fase').AsInteger              :=edSEQ_FASE.AsInteger;
      //ParamByName('flag_acbm').AsInteger             :=
        //Integer(chkFLAG_ACBM.Checked);
      if FfkFaseProducao>0 then
        ParamByName('pk_fases_producao').AsInteger:=FfkFaseProducao;
      ExecSql;
    finally
      Close;
      end;
  if FfkFaseProducao<1 then
    begin
    with dmFichaTecnica.qrMaxFaseProducao do
      try
        ParamByName('fk_pecas').AsInteger              :=FfkPecas;
        ParamByName('fk_ficha_tecnica').AsInteger      :=FfkFichaTecnica;
        Open;
        if Not(EOF) then
          FfkFaseProducao:=FieldByName('pk_fases_producao').AsInteger;
      finally
        Close;
        end;
    if Assigned(FOnInsertFaseProducao) then
      FOnInsertFaseProducao(Self,FfkPecas,FfkFichaTecnica,FfkFaseProducao);
    end
  else
  if Assigned(FOnUpdateFaseProducao) then
    FOnUpdateFaseProducao(Self,FfkPecas,FfkFichaTecnica,FfkFaseProducao);
  if dmFichaTecnica.tr.InTransaction then
    dmFichaTecnica.tr.Commit;
end;

procedure TfmEditFaseProducao.SetOnInsertFaseProducao(
  const Value: TUpdateFaseProducaoEvent);
begin
  FOnInsertFaseProducao := Value;
end;

procedure TfmEditFaseProducao.SetOnUpdateFaseProducao(
  const Value: TUpdateFaseProducaoEvent);
begin
  FOnUpdateFaseProducao := Value;
end;

procedure TfmEditFaseProducao.SetUpdateAllowed(const Value: Boolean);
begin
  FUpdateAllowed := Value;
end;

procedure TfmEditFaseProducao.FormShow(Sender: TObject);
begin
  LoadFaseProducao;
end;

end.
