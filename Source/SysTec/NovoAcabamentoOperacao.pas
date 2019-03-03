unit NovoAcabamentoOperacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TfmNovoAcabamentoOperacao = class(TForm)
    Label1: TLabel;
    cbAcabamento: TComboBox;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    Label6: TLabel;
    edQtde: TCurrencyEdit;
    Label9: TLabel;
    edPERC_PERDA: TCurrencyEdit;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FslTiposDeAcabamento: TList;
    procedure LoadAcabamentos;
    function GetSelectedDescTipoAcabamento: String;
    function GetSelectedfkTipoAcabamento: Integer;
    procedure SetSelectedDescTipoAcabamento(const Value: String);
    procedure SetSelectedfkTipoAcabamento(const Value: Integer);
    function GetQtde: Double;
    procedure SetQtde(const Value: Double);
    function GetPercPerda: Double;
    procedure SetPercPerda(const Value: Double);
  public
    { Public declarations }
    property SelectedfkTipoAcabamento:Integer read GetSelectedfkTipoAcabamento write SetSelectedfkTipoAcabamento;
    property SelectedDescTipoAcabamento:String read GetSelectedDescTipoAcabamento write SetSelectedDescTipoAcabamento;
    property Qtde:Double read GetQtde write SetQtde;
    property PercPerda:Double read GetPercPerda write SetPercPerda;
    property slTiposDeAcabamento:TList read FslTiposDeAcabamento;
  end;

var
  fmNovoAcabamentoOperacao: TfmNovoAcabamentoOperacao;

implementation

uses udmFichaTecnica;

{$R *.dfm}

procedure TfmNovoAcabamentoOperacao.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmNovoAcabamentoOperacao.FormCreate(Sender: TObject);
begin
  FslTiposDeAcabamento:=TList.Create;
  LoadAcabamentos;
end;

procedure TfmNovoAcabamentoOperacao.cmdUpdateClick(Sender: TObject);
var Ix:Integer;
begin
  if cbAcabamento.ItemIndex<0 Then
     begin
       if cbAcabamento.CanFocus Then cbAcabamento.SetFocus;
       MessageBox(Self.Handle,'O Acabamento deve ser selecionado !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if FslTiposDeAcabamento<>Nil Then Ix:=FslTiposDeAcabamento.IndexOf(cbAcabamento.Items.Objects[cbAcabamento.ItemIndex])
  else Ix:=-1;
  if Ix>-1 Then
     begin
       MessageBox(Self.Handle,'Este Acabamento já faz parte da operação !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  ModalResult:=mrOk;
end;

function TfmNovoAcabamentoOperacao.GetSelectedDescTipoAcabamento: String;
begin
  Result:='';
  if cbAcabamento.ItemIndex>-1 Then Result:=cbAcabamento.Items[cbAcabamento.ItemIndex];
end;

function TfmNovoAcabamentoOperacao.GetSelectedfkTipoAcabamento: Integer;
begin
  Result:=0;
  if cbAcabamento.ItemIndex>-1 Then Result:=LongInt(cbAcabamento.Items.Objects[cbAcabamento.ItemIndex]);
end;

procedure TfmNovoAcabamentoOperacao.LoadAcabamentos;
begin
  cbAcabamento.Items.Clear;
  with dmFichaTecnica.qrTipoAcabamentos do
       try
         Open;
         While Not(EOF) do
               begin
                 cbAcabamento.Items.AddObject(FieldByName('DSC_ACABM').AsString,TObject(FieldByName('PK_TIPO_ACABAMENTOS').AsInteger));
                 Next;
               end;
       finally
         Close;
       end;
  if cbAcabamento.Items.Count>0 Then cbAcabamento.ItemIndex:=0;
end;

procedure TfmNovoAcabamentoOperacao.SetSelectedDescTipoAcabamento(
  const Value: String);
var Ix:Integer;
begin
  Ix:=cbAcabamento.Items.IndexOf(Value);
  if Ix>-1 Then cbAcabamento.ItemIndex:=Ix;
end;

procedure TfmNovoAcabamentoOperacao.SetSelectedfkTipoAcabamento(
  const Value: Integer);
var Ix:Integer;
begin
  Ix:=cbAcabamento.Items.IndexOfObject(TObject(Value));
  if Ix>-1 Then cbAcabamento.ItemIndex:=Ix;
end;

procedure TfmNovoAcabamentoOperacao.FormDestroy(Sender: TObject);
begin
  FslTiposDeAcabamento.Free;
  FslTiposDeAcabamento:=Nil;
end;

function TfmNovoAcabamentoOperacao.GetQtde: Double;
begin
  Result:=edQtde.Value;
end;

procedure TfmNovoAcabamentoOperacao.SetQtde(const Value: Double);
begin
  edQtde.Value:=Value;
end;

function TfmNovoAcabamentoOperacao.GetPercPerda: Double;
begin
  Result:=edPERC_PERDA.Value;
end;

procedure TfmNovoAcabamentoOperacao.SetPercPerda(const Value: Double);
begin
  edPERC_PERDA.Value:=Value;
end;

end.
