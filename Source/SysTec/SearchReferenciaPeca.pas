unit SearchReferenciaPeca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TReferenciaSearchType=(stSearch,stCopy);

  TfmSearchReferenciaPeca = class(TForm)
    cmdSearch: TBitBtn;
    cmdCancel: TBitBtn;
    edReferencia: TEdit;
    laReferencia: TLabel;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
  private
    FfkSecoes     : Integer;
    FfkGrupos     : Integer;
    FfkSubGrupos  : Integer;
    FfkPecas      : Integer;
    FSearchType   : TReferenciaSearchType;
    function GetReferencia: String;
    procedure SetReferencia(const Value: String);
    procedure SetSearchType(const Value: TReferenciaSearchType);
    { Private declarations }
  public
    { Public declarations }
    property SearchType :TReferenciaSearchType read FSearchType write SetSearchType;
    property Referencia :String read GetReferencia write SetReferencia;
    property fkSecoes   :Integer read FfkSecoes;
    property fkGrupos   :Integer read FfkGrupos;
    property fkSubGrupos:Integer read FfkSubGrupos;
    property fkPecas    :Integer read FfkPecas write FfkPecas;
  end;

var
  fmSearchReferenciaPeca: TfmSearchReferenciaPeca;

implementation

uses udmFichaTecnica;

{$R *.dfm}

const
   SEARCH_CAPTION    : array[TReferenciaSearchType] of string =
     ('Pesquisa por Referência', 'Copiar Ficha Técnica');
   REFERENCIA_CAPTION: array[TReferenciaSearchType] of string =
     ('Referência', 'Referência Destino');
   BTN_CAPTION       : array[TReferenciaSearchType] of string =
     ('Pesquisar', 'Copiar');

procedure TfmSearchReferenciaPeca.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmSearchReferenciaPeca.cmdSearchClick(Sender: TObject);
var
  afkPecas          : Integer;
  S                 : string;
  TotalComponentes  : Integer;
begin
  edReferencia.Text := Trim(edReferencia.Text);
  if edReferencia.Text = '' Then
  begin
    if edReferencia.CanFocus Then edReferencia.SetFocus;
    MessageBox(Self.Handle, 'A Referência deve ser preenchida !',
      PChar(Caption), MB_ICONWARNING);
    exit;
  end;
  TotalComponentes  := 0;
  FfkSecoes         := 0;
  FfkGrupos         := 0;
  FfkSubGrupos      := 0;
  afkPecas          := 0;
  with dmFichaTecnica.qrReferenciaPeca do
  try
    ParamByName('cod_ref').AsString      :=edReferencia.Text;
    Open;
    if not(EOF) then
    begin
      FfkSecoes        := FieldByName('fk_secoes').AsInteger;
      FfkGrupos        := FieldByName('fk_grupos').AsInteger;
      FfkSubGrupos     := FieldByName('fk_subgrupos').AsInteger;
      afkPecas         := FieldByName('fk_pecas').AsInteger;
      TotalComponentes := FieldByName('total_componentes').AsInteger;
    end;
  finally
    Close;
  end;
  if afkPecas < 1 then
    S := 'Esta referência não está cadastrada !'
  else
    if SearchType = stCopy then
      if FfkPecas = afkPecas then
        S := 'A Peça de Destino deve ser diferente da peça de origem !'
      else
        if TotalComponentes > 1 then
          S := 'A Peça de Destino já possui componentes !'
        else
          S := '';
  if S <> '' then
  begin
    if edReferencia.CanFocus then edReferencia.SetFocus;
    MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONWARNING);
    exit;
  end;
  FfkPecas:=afkPecas;
  ModalResult:=mrOk;
end;

function TfmSearchReferenciaPeca.GetReferencia: String;
begin
  Result:=Trim(edReferencia.Text);
end;

procedure TfmSearchReferenciaPeca.SetReferencia(const Value: String);
begin
  edReferencia.Text:=Trim(Value);
end;

procedure TfmSearchReferenciaPeca.SetSearchType(const Value: TReferenciaSearchType);
begin
  FSearchType           := Value;
  Caption               := SEARCH_CAPTION[FSearchType];
  laReferencia.Caption  := REFERENCIA_CAPTION[FSearchType];
  cmdSearch.Caption     := BTN_CAPTION[FSearchType];
end;

end.
