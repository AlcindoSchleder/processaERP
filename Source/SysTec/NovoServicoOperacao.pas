unit NovoServicoOperacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TfmNovoServicoOperacao = class(TForm)
    Label1: TLabel;
    cbServico: TComboBox;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    Label6: TLabel;
    edQtde: TCurrencyEdit;
    lFk_Secoes: TLabel;
    cbSecoes: TComboBox;
    Label2: TLabel;
    cbGrupos: TComboBox;
    Label3: TLabel;
    cbSubGrupos: TComboBox;
    Label4: TLabel;
    cbUnidades: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbSecoesClick(Sender: TObject);
    procedure cbGruposClick(Sender: TObject);
    procedure cbSubGruposClick(Sender: TObject);
    procedure cbUnidadesClick(Sender: TObject);
  private
    { Private declarations }
    FslServicosInd: TList;
    procedure LoadServicos;
    function GetSelectedDescServicosInd: String;
    function GetSelectedfkServicosInd: Integer;
    procedure SetSelectedDescServicosInd(const Value: String);
    procedure SetSelectedfkServicosInd(const Value: Integer);
    function GetQtde: Double;
    procedure SetQtde(const Value: Double);
    procedure LoadSecoes;
    procedure LoadGrupos;
    procedure LoadSubGrupos;
    procedure LoadUnidades;
  public
    { Public declarations }
    property SelectedfkServicosInd:Integer read GetSelectedfkServicosInd write SetSelectedfkServicosInd;
    property SelectedDescServicosInd:String read GetSelectedDescServicosInd write SetSelectedDescServicosInd;
    property Qtde:Double read GetQtde write SetQtde;
    property slServicosInd:TList read FslServicosInd;
  end;

var
  fmNovoServicoOperacao: TfmNovoServicoOperacao;

implementation

uses udmFichaTecnica;

{$R *.dfm}

procedure TfmNovoServicoOperacao.FormCreate(Sender: TObject);
begin
  FslServicosInd:=TList.Create;
  LoadSecoes;
  LoadUnidades;
end;

procedure TfmNovoServicoOperacao.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmNovoServicoOperacao.cmdUpdateClick(Sender: TObject);
var Ix:Integer;
begin
  if cbServico.ItemIndex<0 Then
     begin
       if cbServico.CanFocus Then cbServico.SetFocus;
       MessageBox(Self.Handle,'O Serviço deve ser selecionado !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if FslServicosInd<>Nil Then Ix:=FslServicosInd.IndexOf(cbServico.Items.Objects[cbServico.ItemIndex])
  else Ix:=-1;
  if Ix>-1 Then
     begin
       MessageBox(Self.Handle,'Este Serviço já faz parte da operação !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  ModalResult:=mrOk;
end;

function TfmNovoServicoOperacao.GetSelectedDescServicosInd: String;
begin
  Result:='';
  if cbServico.ItemIndex>-1 Then Result:=cbServico.Items[cbServico.ItemIndex];
end;

function TfmNovoServicoOperacao.GetSelectedfkServicosInd: Integer;
begin
  Result:=0;
  if cbServico.ItemIndex>-1 Then Result:=LongInt(cbServico.Items.Objects[cbServico.ItemIndex]);
end;

procedure TfmNovoServicoOperacao.LoadServicos;
begin
  cbServico.Items.Clear;
  if cbSecoes.ItemIndex<0 Then Exit;
  if cbGrupos.ItemIndex<0 Then Exit;
  if cbSubGrupos.ItemIndex<0 Then Exit;
  if cbUnidades.ItemIndex<0 Then Exit;
  with dmFichaTecnica.qrServicosInd do
       try
         ParamByName('fk_secoes').AsInteger:=LongInt(cbSecoes.Items.Objects[cbSecoes.ItemIndex]);
         ParamByName('fk_grupos').AsInteger:=LongInt(cbGrupos.Items.Objects[cbGrupos.ItemIndex]);
         ParamByName('fk_subgrupos').AsInteger:=LongInt(cbSubGrupos.Items.Objects[cbSubGrupos.ItemIndex]);
         ParamByName('fk_unidades').AsInteger:=LongInt(cbUnidades.Items.Objects[cbUnidades.ItemIndex]);
         Open;
         While Not(EOF) do
               begin
                 cbServico.Items.AddObject(FieldByName('COD_REF').AsString+' - '+FieldByName('DSC_SRV').AsString,TObject(FieldByName('PK_SERVICOS_IND').AsInteger));
                 Next;
               end;
       finally
         Close;
       end;
  if cbServico.Items.Count>0 Then cbServico.ItemIndex:=0;
end;

procedure TfmNovoServicoOperacao.SetSelectedDescServicosInd(
  const Value: String);
var Ix,fkSecoes,fkGrupos,fkSubGrupos,fkUnidades:Integer;
begin
  with dmFichaTecnica.qrServicoIndByDescricao do
       try
         ParamByName('dsc_srv').AsString:=Value;
         Open;
         if EOF Then Exit;
         fkSecoes:=FieldByName('fk_secoes').AsInteger;
         fkGrupos:=FieldByName('fk_grupos').AsInteger;
         fkSubGrupos:=FieldByName('fk_subgrupos').AsInteger;
         fkUnidades:=FieldByName('fkUnidades').AsInteger;
       finally
         Close;
       end;
  cbUnidades.ItemIndex:=-1; // to prevent servicos auto-load...
  Ix:=cbSecoes.Items.IndexOfObject(TObject(fkSecoes));
  if Ix<0 Then Exit;
  cbSecoes.ItemIndex:=Ix;
  if Assigned(cbSecoes.OnClick) Then cbSecoes.OnClick(Self);
  Ix:=cbGrupos.Items.IndexOfObject(TObject(fkGrupos));
  if Ix<0 Then Exit;
  if Assigned(cbGrupos.OnClick) Then cbGrupos.OnClick(Self);
  Ix:=cbSubGrupos.Items.IndexOfObject(TObject(fkSubGrupos));
  if Ix<0 Then Exit;
  if Assigned(cbSubGrupos.OnClick) Then cbSubGrupos.OnClick(Self);
  Ix:=cbUnidades.Items.IndexOfObject(TObject(fkUnidades));
  if Ix<0 Then Exit;
  if Assigned(cbUnidades.OnClick) Then cbUnidades.OnClick(Self);
  Ix:=cbServico.Items.IndexOf(Value);
  if Ix>-1 Then cbServico.ItemIndex:=Ix;
end;

procedure TfmNovoServicoOperacao.SetSelectedfkServicosInd(
  const Value: Integer);
var Ix,fkSecoes,fkGrupos,fkSubGrupos,fkUnidades:Integer;
begin
  with dmFichaTecnica.qrServicoInd do
       try
         ParamByName('pk_servicos_ind').AsInteger:=Value;
         Open;
         if EOF Then Exit;
         fkSecoes:=FieldByName('fk_secoes').AsInteger;
         fkGrupos:=FieldByName('fk_grupos').AsInteger;
         fkSubGrupos:=FieldByName('fk_subgrupos').AsInteger;
         fkUnidades:=FieldByName('fkUnidades').AsInteger;
       finally
         Close;
       end;
  cbUnidades.ItemIndex:=-1; // to prevent servicos auto-load...
  Ix:=cbSecoes.Items.IndexOfObject(TObject(fkSecoes));
  if Ix<0 Then Exit;
  cbSecoes.ItemIndex:=Ix;
  if Assigned(cbSecoes.OnClick) Then cbSecoes.OnClick(Self);
  Ix:=cbGrupos.Items.IndexOfObject(TObject(fkGrupos));
  if Ix<0 Then Exit;
  if Assigned(cbGrupos.OnClick) Then cbGrupos.OnClick(Self);
  Ix:=cbSubGrupos.Items.IndexOfObject(TObject(fkSubGrupos));
  if Ix<0 Then Exit;
  if Assigned(cbSubGrupos.OnClick) Then cbSubGrupos.OnClick(Self);
  Ix:=cbUnidades.Items.IndexOfObject(TObject(fkUnidades));
  if Ix<0 Then Exit;
  if Assigned(cbUnidades.OnClick) Then cbUnidades.OnClick(Self);
  Ix:=cbServico.Items.IndexOfObject(TObject(Value));
  if Ix>-1 Then cbServico.ItemIndex:=Ix;
end;

procedure TfmNovoServicoOperacao.FormDestroy(Sender: TObject);
begin
  FslServicosInd.Free;
  FslServicosInd:=Nil;
end;

function TfmNovoServicoOperacao.GetQtde: Double;
begin
  Result:=edQtde.Value;
end;

procedure TfmNovoServicoOperacao.SetQtde(const Value: Double);
begin
  edQtde.Value:=Value;
end;

procedure TfmNovoServicoOperacao.LoadGrupos;
begin
  cbGrupos.Items.Clear;
  cbSubGrupos.Items.Clear;
  cbServico.Items.Clear;
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
end;

procedure TfmNovoServicoOperacao.LoadSecoes;
var S:String;
begin
  cbSecoes.Items.Clear;
  cbGrupos.Items.Clear;
  cbSubGrupos.Items.Clear;
  cbServico.Items.Clear;
  with dmFichaTecnica.qrSecoes do
  try
    S:=SQL.Text;
    Sql.Insert(Sql.Count-1,'Where FLAG_TMAT=4');
    Open;
    while not(EOF) do
    begin
      cbSecoes.Items.AddObject(FieldByName('DSC_SEC').AsString,
        TObject(FieldByName('PK_SECOES').AsInteger));
      Next;
    end;
  finally
    Close;
    SQL.Text:=S;
  end;
end;

procedure TfmNovoServicoOperacao.LoadSubGrupos;
begin
  cbSubGrupos.Items.Clear;
  cbServico.Items.Clear;
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
end;

procedure TfmNovoServicoOperacao.LoadUnidades;
begin
  cbUnidades.Items.Clear;
  cbServico.Items.Clear;
  with dmFichaTecnica.qrUnidades do
  try
    Open;
    while not(EOF) do
    begin
      cbUnidades.Items.AddObject(FieldByName('DSC_UNI').AsString,
        TObject(FieldByName('PK_UNIDADES').AsInteger));
      Next;
    end;
  finally
    Close;
  end;
end;

procedure TfmNovoServicoOperacao.cbSecoesClick(Sender: TObject);
begin
  LoadGrupos;
end;

procedure TfmNovoServicoOperacao.cbGruposClick(Sender: TObject);
begin
  LoadSubGrupos;
end;

procedure TfmNovoServicoOperacao.cbSubGruposClick(Sender: TObject);
begin
  LoadServicos;
end;

procedure TfmNovoServicoOperacao.cbUnidadesClick(Sender: TObject);
begin
  LoadServicos;
end;

end.
