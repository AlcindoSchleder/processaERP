unit SearchReferencia;

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
  TReferenciaSearchType = (stSearch, stCopy);

  TfmSearchReferencia = class(TForm)
    cmdSearch: TSpeedButton;
    cmdCancel: TSpeedButton;
    edReferencia: TEdit;
    laReferencia: TStaticText;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
  private
    FFkEmpresas: Integer;
    FfkLinhas: Integer;
    FfkSecoes: Integer;
    FfkGrupos: Integer;
    FfkProdutos: Integer;
    FSearchType: TReferenciaSearchType;
    function  GetReferencia: string;
    procedure SetReferencia(const Value: string);
    procedure SetSearchType(const Value: TReferenciaSearchType);
    { Private declarations }
  public
    { Public declarations }
    property SearchType: TReferenciaSearchType read FSearchType   write SetSearchType;
    property Referencia: string                read GetReferencia write SetReferencia;
    property fkEmpresas: Integer               read FFkEmpresas   write FFkEmpresas;
    property fkLinhas  : Integer               read FFkLinhas;
    property fkSecoes  : Integer               read FFkSecoes;
    property fkGrupos  : Integer               read FFkGrupos;
    property fkProdutos: Integer               read FFkProdutos   write FFkProdutos;
  end;

var
  fmSearchReferencia: TfmSearchReferencia;

implementation

uses mSysConf, ConfArqSql;

{$R *.dfm}

const
   SEARCH_CAPTION    : array[TReferenciaSearchType] of string =
     ('Pesquisa por Referência', 'Copiar Estrutura de Acabamentos');
   REFERENCIA_CAPTION: array[TReferenciaSearchType] of string =
     ('Referência:', 'Referência Destino:');
   BTN_CAPTION       : array[TReferenciaSearchType] of string =
     ('Pesquisar', 'Copiar');

procedure TfmSearchReferencia.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmSearchReferencia.cmdSearchClick(Sender: TObject);
var
  aFkProdutos       : Integer;
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
  TotalComponentes := 0;
  FFkLinhas        := 0;
  FFkSecoes        := 0;
  FFkGrupos        := 0;
  afkProdutos      := 0;
  with dmSysConf do
  begin
    if Produtos.Active then Produtos.Close;
    Produtos.SQL.Clear;
    Produtos.SQL.Add(SqlReferenciaProduto);
    try
      Produtos.ParamByName('CodRef').AsString     := edReferencia.Text;
      Produtos.ParamByName('FlagTCode').AsInteger := 0;
      if not Produtos.Active then Produtos.Open;
      if not Produtos.IsEmpty then
      begin
        FFkLinhas        := Produtos.FieldByName('FK_LINHAS').AsInteger;
        FFkSecoes        := Produtos.FieldByName('FK_SECOES').AsInteger;
        FFkGrupos        := Produtos.FieldByName('FK_GRUPOS').AsInteger;
        aFkProdutos      := Produtos.FieldByName('PK_PRODUTOS').AsInteger;
        TotalComponentes := Produtos.FieldByName('TOTAL_COMPONENTES').AsInteger;
      end;
    finally
      if Produtos.Active then Produtos.Close;
    end;
  end;
  if afkProdutos < 1 then
    S := 'Esta referência não está cadastrada !'
  else
    if SearchType = stCopy then
      if FfkProdutos = afkProdutos then
        S := 'O Produto de Destino deve ser diferente do produto de origem !'
      else
        if TotalComponentes > 0 then
          S := 'O Produto de Destino já possui componentes !'
        else
          S := '';
  if S <> '' then
  begin
    if edReferencia.CanFocus then edReferencia.SetFocus;
    MessageBox(Self.Handle, PChar(S), PChar(Caption), MB_ICONWARNING);
    exit;
  end;
  FFkProdutos := aFkProdutos;
  ModalResult := mrOk;
end;

function TfmSearchReferencia.GetReferencia: string;
begin
  Result := Trim(edReferencia.Text);
end;

procedure TfmSearchReferencia.SetReferencia(const Value: string);
begin
  edReferencia.Text := Trim(Value);
end;

procedure TfmSearchReferencia.SetSearchType(const Value: TReferenciaSearchType);
begin
  FSearchType           := Value;
  Caption               := SEARCH_CAPTION[FSearchType];
  laReferencia.Caption  := REFERENCIA_CAPTION[FSearchType];
  cmdSearch.Caption     := BTN_CAPTION[FSearchType];
end;

end.
