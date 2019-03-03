unit CopyFicha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, JvEdit, JvSpin, RXSpin;

type

  TfmCopyFicha = class(TForm)
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    edReferencia: TEdit;
    laReferencia: TLabel;
    Label1: TLabel;
    edDescricao: TEdit;
    Label2: TLabel;
    edUltimaVersao: TEdit;
    Label3: TLabel;
    edVersaoAtiva: TEdit;
    Label4: TLabel;
    cmdSearch: TSpeedButton;
    edMajVer: TRxSpinEdit;
    edMinVer: TRxSpinEdit;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edReferenciaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edReferenciaExit(Sender: TObject);
  private
    { Private declarations }
    FfkSecoes               : Integer;
    FfkGrupos               : Integer;
    FfkSubGrupos            : Integer;
    FfkPecasDestino         : Integer;
    FfkPecas                : Integer;
    FTotalComponentes       : Integer;
    FLastReferencia         : String;
    FfkFichaTecnicaOrigem   : Integer;
    FfkFichaTecnicaDestino  : Integer;
    function GetReferencia: String;
    procedure SetReferencia(const Value: String);
    procedure ClearPeca;
    function GetMajVerDestino: Integer;
    function GetMinVerDestino: Integer;
  public
    { Public declarations }
    property Referencia             :String read GetReferencia write SetReferencia;
    property fkSecoes               :Integer read FfkSecoes;
    property fkGrupos               :Integer read FfkGrupos;
    property fkSubGrupos            :Integer read FfkSubGrupos;
    property fkPecas                :Integer read FfkPecas write FfkPecas;
    property fkPecasDestino         :Integer read FfkPecasDestino;
    property fkFichaTecnicaOrigem   :Integer read FfkFichaTecnicaOrigem write FfkFichaTecnicaOrigem;
    property fkFichaTecnicaDestino  :Integer read FfkFichaTecnicaDestino;
    property MajVerDestino          :Integer read GetMajVerDestino;
    property MinVerDestino          :Integer read GetMinVerDestino;
  end;

var
  fmCopyFicha: TfmCopyFicha;

implementation

uses udmFichaTecnica;

{$R *.dfm}

procedure TfmCopyFicha.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmCopyFicha.cmdUpdateClick(Sender: TObject);
var TemOp:Boolean;
    EstaAtiva:Boolean;
begin
  FfkFichaTecnicaDestino:=-1;
  if FfkPecasDestino<1 Then
     begin
       MessageBox(Self.Handle,'A Ficha Técnica de Destino deve ser escolhida !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if edMajVer.AsInteger<1 Then
     begin
       if edMajVer.CanFocus Then edMajVer.SetFocus;
       MessageBox(Self.Handle,'Versão Inválida !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  TemOp:=False;
  EstaAtiva:=False;
  with dmFichaTecnica.qrFichaTecnicaByVersion do
       try
         ParamByName('fk_pecas').AsInteger  :=FfkPecasDestino;
         ParamByName('Maj_Ver').AsInteger   :=edMajVer.AsInteger;
         ParamByName('Min_Ver').AsInteger   :=edMajVer.AsInteger;
         Open;
         if Not(EOF) Then
            begin
              FfkFichaTecnicaDestino:=FieldByName('pk_ficha_tecnica').AsInteger;
              TemOp:=(FieldByName('FLAG_OP').AsInteger=1);
              EstaAtiva:=(FieldByName('FLAG_ATV').AsInteger=1);
            end;
       finally
         Close;
       end;
  if ((FfkPecas=FfkPecasDestino)And(FfkFichaTecnicaOrigem=FfkFichaTecnicaDestino)) Then
     begin
       MessageBox(Self.Handle,'Uma Ficha Técnica não pode ser copiada para si mesma !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if TemOp Then
     begin
       MessageBox(Self.Handle,'A Ficha Técnica Destino já tem OP, e não pode ser modificada !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if EstaAtiva Then
     begin
       MessageBox(Self.Handle,'A Ficha Técnica Destino está ativa, e não pode ser modificada !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if FfkFichaTecnicaDestino>0 Then
     if MessageBox(Self.Handle,'A Ficha Técnica Destino já existe, por favor confirme a cópia !',PChar(Caption),MB_ICONQUESTION Or MB_YESNO)<>IDYES Then Exit;
  ModalResult:=mrOk;
end;

function TfmCopyFicha.GetReferencia: String;
begin
  Result:=Trim(edReferencia.Text);
end;

procedure TfmCopyFicha.SetReferencia(const Value: String);
begin
  edReferencia.Text:=Trim(Value);
end;

procedure TfmCopyFicha.ClearPeca;
begin
  edDescricao.Text      :='';
  edUltimaVersao.Text   :='';
  edVersaoAtiva.Text    :='';
  cmdUpdate.Enabled     :=False;
  FfkSecoes             :=-1;
  FfkGrupos             :=-1;
  FfkSubGrupos          :=-1;
  FfkPecasDestino       :=-1;
  FTotalComponentes     :=0;
  FfkFichaTecnicaDestino:=-1;
end;

procedure TfmCopyFicha.cmdSearchClick(Sender: TObject);
var S       : string;
begin
  edReferencia.Text := Trim(edReferencia.Text);
  if edReferencia.Text=FLastReferencia Then Exit;
  ClearPeca;
  FLastReferencia:=edReferencia.Text;
  if edReferencia.Text = '' Then Exit;
  S:='';
  with dmFichaTecnica.qrReferenciaPeca do
       try
         ParamByName('cod_ref').AsString      :=edReferencia.Text;
         Open;
         if EOF then Exit;
         FfkSecoes          := FieldByName('fk_secoes').AsInteger;
         FfkGrupos          := FieldByName('fk_grupos').AsInteger;
         FfkSubGrupos       := FieldByName('fk_subgrupos').AsInteger;
         FfkPecasDestino    := FieldByName('fk_pecas').AsInteger;
         FTotalComponentes  := FieldByName('total_componentes').AsInteger;
         edDescricao.Text   := FieldByName('DSC_PEC').AsString;
       finally
         Close;
       end;
  with dmFichaTecnica.qrVersaoAtivaFicha do
       try
         ParamByName('fk_pecas').AsInteger  :=FfkPecasDestino;
         Open;
         if Not(EOF) Then
            edVersaoAtiva.Text := IntToStr(FieldByName('MAJ_VER').AsInteger)+'.'+IntToStr(FieldByName('MIN_VER').AsInteger);
       finally
         Close;
       end;
  with dmFichaTecnica.qrUltimaVersaoFicha do
       try
         ParamByName('fk_pecas').AsInteger  :=FfkPecasDestino;
         Open;
         if Not(EOF) Then
            edUltimaVersao.Text := IntToStr(FieldByName('MAJ_VER').AsInteger)+'.'+IntToStr(FieldByName('MIN_VER').AsInteger);
       finally
         Close;
       end;
  cmdUpdate.Enabled:=True;
end;

function TfmCopyFicha.GetMajVerDestino: Integer;
begin
  Result:=edMajVer.AsInteger;
end;

function TfmCopyFicha.GetMinVerDestino: Integer;
begin
  Result:=edMinVer.AsInteger;
end;

procedure TfmCopyFicha.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Escape Then
     if Assigned(cmdCancel.OnClick) Then cmdCancel.OnClick(Self);
end;

procedure TfmCopyFicha.edReferenciaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return Then
     if Assigned(cmdSearch.OnClick) Then cmdSearch.OnClick(Self);
end;

procedure TfmCopyFicha.edReferenciaExit(Sender: TObject);
begin
  if Assigned(cmdSearch.OnClick) Then cmdSearch.OnClick(Self);
end;

end.
