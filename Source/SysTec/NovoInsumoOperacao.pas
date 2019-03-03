unit NovoInsumoOperacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TfmNovoInsumoOperacao = class(TForm)
    lFk_Secoes: TLabel;
    cbSecoes: TComboBox;
    lFk_Grupos: TLabel;
    cbGrupos: TComboBox;
    lFk_SubGrupos: TLabel;
    cbSubGrupos: TComboBox;
    lPK_PECAS: TLabel;
    cbInsumos: TComboBox;
    Label6: TLabel;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    edQtde: TRxCalcEdit;
    Label9: TLabel;
    edPERC_PERDA: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure cbSecoesClick(Sender: TObject);
    procedure cbGruposClick(Sender: TObject);
    procedure cbSubGruposClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FslInsumosOperacao: TList;
    procedure LoadSecoes;
    procedure LoadGrupos;
    procedure LoadSubGrupos;
    procedure LoadInsumos;
    function GetSelectedDescInsumo: String;
    function GetSelectedfkInsumo: Integer;
    procedure SetSelectedDescInsumo(const Value: String);
    procedure SetSelectedfkInsumo(const Value: Integer);
    function GetQtde: Double;
    procedure SetQtde(const Value: Double);
    function GetPercPerda: Double;
    procedure SetPercPerda(const Value: Double);
  public
    { Public declarations }
    property SelectedfkInsumo:Integer read GetSelectedfkInsumo write SetSelectedfkInsumo;
    property SelectedDescInsumo:String read GetSelectedDescInsumo write SetSelectedDescInsumo;
    property Qtde:Double read GetQtde write SetQtde;
    property PercPerda:Double read GetPercPerda write SetPercPerda;
    property slInsumosOperacao:TList read FslInsumosOperacao;

  public
    { Public declarations }
  end;

var
  fmNovoInsumoOperacao: TfmNovoInsumoOperacao;

implementation

uses udmFichaTecnica;

{$R *.dfm}

procedure TfmNovoInsumoOperacao.FormCreate(Sender: TObject);
begin
  FslInsumosOperacao:=TList.Create;
  LoadSecoes;
end;

procedure TfmNovoInsumoOperacao.cbSecoesClick(Sender: TObject);
begin
  LoadGrupos;
end;

procedure TfmNovoInsumoOperacao.cbGruposClick(Sender: TObject);
begin
  LoadSubGrupos;
end;

procedure TfmNovoInsumoOperacao.cbSubGruposClick(Sender: TObject);
begin
  LoadInsumos;
end;

procedure TfmNovoInsumoOperacao.LoadGrupos;
begin
  cbInsumos.Items.Clear;
  cbSubGrupos.Items.Clear;
  cbGrupos.Items.Clear;
  if cbSecoes.ItemIndex<0 Then Exit;
  with dmFichaTecnica.qrGrupos do
  try
    ParamByName('fk_secoes').AsInteger:=LongInt(cbSecoes.Items.Objects[cbSecoes.ItemIndex]);
    Open;
    while not(EOF) do
    begin
      cbGrupos.Items.AddObject(FieldByName('DSC_GRU').AsString,
        TObject(FieldByName('PK_GRUPOS').AsInteger));
      Next;
    end;
  finally
    Close;
  end;
  if cbGrupos.Items.Count<1 Then Exit;
  cbGrupos.ItemIndex:=0;
  if Assigned(cbGrupos.OnClick) Then cbGrupos.OnClick(Self);
end;

procedure TfmNovoInsumoOperacao.LoadInsumos;
begin
  cbInsumos.Items.Clear;
  if ((cbSecoes.ItemIndex<0)Or(cbGrupos.ItemIndex<0)Or(cbSubGrupos.ItemIndex<0)) Then Exit;
  with dmFichaTecnica.qrInsumos do
  try
    ParamByName('fk_secoes').AsInteger:=LongInt(cbSecoes.Items.Objects[cbSecoes.ItemIndex]);
    ParamByName('fk_grupos').AsInteger:=LongInt(cbGrupos.Items.Objects[cbGrupos.ItemIndex]);
    ParamByName('fk_subgrupos').AsInteger:=LongInt(cbSubGrupos.Items.Objects[cbSubGrupos.ItemIndex]);
    Open;
    while not(EOF) do
    begin
      cbInsumos.Items.AddObject(FieldByName('COD_REF').AsString+' - '+FieldByName('DSC_INS').AsString,
        TObject(FieldByName('PK_INSUMOS').AsInteger));
      Next;
    end;
  finally
    Close;
  end;
  if cbInsumos.Items.Count<1 Then Exit;
  cbInsumos.ItemIndex:=0;
  if Assigned(cbInsumos.OnClick) Then cbInsumos.OnClick(Self);
end;

procedure TfmNovoInsumoOperacao.LoadSecoes;
begin
  cbInsumos.Items.Clear;
  cbSubGrupos.Items.Clear;
  cbGrupos.Items.Clear;
  cbSecoes.Items.Clear;
  with dmFichaTecnica.qrSecoes do
  try
    Open;
    while not(EOF) do
    begin
      cbSecoes.Items.AddObject(FieldByName('DSC_SEC').AsString,
        TObject(FieldByName('PK_SECOES').AsInteger));
      Next;
    end;
  finally
    Close;
  end;
  if cbSecoes.Items.Count<1 Then Exit;
  cbSecoes.ItemIndex:=0;
  if Assigned(cbSecoes.OnClick) Then cbSecoes.OnClick(Self);
end;

procedure TfmNovoInsumoOperacao.LoadSubGrupos;
begin
  cbInsumos.Items.Clear;
  cbSubGrupos.Items.Clear;
  if ((cbSecoes.ItemIndex<0)Or(cbGrupos.ItemIndex<0)) Then Exit;
  with dmFichaTecnica.qrSubGrupos do
  try
    ParamByName('fk_secoes').AsInteger:=LongInt(cbSecoes.Items.Objects[cbSecoes.ItemIndex]);
    ParamByName('fk_grupos').AsInteger:=LongInt(cbGrupos.Items.Objects[cbGrupos.ItemIndex]);
    Open;
    while not(EOF) do
    begin
      cbSubGrupos.Items.AddObject(FieldByName('DSC_SGRU').AsString,
        TObject(FieldByName('PK_SUBGRUPOS').AsInteger));
      Next;
    end;
  finally
    Close;
  end;
  if cbSubGrupos.Items.Count<1 Then Exit;
  cbSubGrupos.ItemIndex:=0;
  if Assigned(cbSubGrupos.OnClick) Then cbSubGrupos.OnClick(Self);
end;

function TfmNovoInsumoOperacao.GetQtde: Double;
begin
  Result:=edQtde.Value;
end;

function TfmNovoInsumoOperacao.GetSelectedDescInsumo: String;
begin
  Result:='';
  if cbInsumos.ItemIndex>-1 Then Result:=cbInsumos.Items[cbInsumos.ItemIndex];
end;

function TfmNovoInsumoOperacao.GetSelectedfkInsumo: Integer;
begin
  Result:=0;
  if cbInsumos.ItemIndex>-1 Then Result:=LongInt(cbInsumos.Items.Objects[cbInsumos.ItemIndex]);
end;

procedure TfmNovoInsumoOperacao.SetQtde(const Value: Double);
begin
  edQtde.Value:=Value;
end;

procedure TfmNovoInsumoOperacao.SetSelectedDescInsumo(const Value: String);
var Ix:Integer;
begin
  Ix:=cbInsumos.Items.IndexOf(Value);
  if Ix>-1 Then cbInsumos.ItemIndex:=Ix;
end;

procedure TfmNovoInsumoOperacao.SetSelectedfkInsumo(const Value: Integer);
var Ix:Integer;
begin
  Ix:=cbInsumos.Items.IndexOfObject(TObject(Value));
  if Ix>-1 Then cbInsumos.ItemIndex:=Ix;
end;

procedure TfmNovoInsumoOperacao.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmNovoInsumoOperacao.cmdUpdateClick(Sender: TObject);
var Ix:Integer;
begin
  if cbInsumos.ItemIndex<0 Then
     begin
       if cbInsumos.CanFocus Then cbInsumos.SetFocus;
       MessageBox(Self.Handle,'O Insumo deve ser selecionado !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if FslInsumosOperacao<>Nil Then Ix:=FslInsumosOperacao.IndexOf(cbInsumos.Items.Objects[cbInsumos.ItemIndex])
  else Ix:=-1;
  if Ix>-1 Then
     begin
       MessageBox(Self.Handle,'Este Insumo já faz parte da operação !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  ModalResult:=mrOk;
end;

procedure TfmNovoInsumoOperacao.FormDestroy(Sender: TObject);
begin
  FslInsumosOperacao.Free;
  FslInsumosOperacao:=Nil;
end;

function TfmNovoInsumoOperacao.GetPercPerda: Double;
begin
  Result:=edPERC_PERDA.Value;
end;

procedure TfmNovoInsumoOperacao.SetPercPerda(const Value: Double);
begin
  edPERC_PERDA.Value:=Value;
end;

end.
