unit Requisicoes;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 2.0.0.0                                                      *}
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
  Dialogs, StdCtrls, NovaRequisicao, ConsultaAlmoxarifado, ConsultaMovimentacao,
  ComCtrls, ProcUtils;

type
  TRequisicoesFormClass = class of TForm;
  TRequisicoesPageType = (rptDadosBasicos, rptConsultaAlmoxarifado,
    rptConsultaMovimentacao);

  TfmRequisicoes = class(TForm)
    pgMain: TPageControl;
    sbStatus: TStatusBar;
    procedure FormDestroy(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure pgMainChange(Sender : TObject);
    procedure FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbStatusClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FScrState    : TDBMode;
    FCompanyClick: Boolean;
    FRect        : TRect;
    procedure ShowAPage(Ix : Integer);
    procedure ClearPages;
    procedure LoadPages;
  public
    { Public declarations }
    procedure ChangeState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
  end;

var
  fmRequisicoes: TfmRequisicoes;

implementation

uses VirtualTrees, SelEmpr, Dado;

{$R *.dfm}

var
  RequisicaoFormClass: array[TRequisicoesPageType] of
  TRequisicoesFormClass = (TfmNovaRequisicao,
    TfmConsultaAlmoxarifado, TfmConsultaMovimentacao);
  RequisicaoPageTitle: array[TRequisicoesPageType] of
  string = ('Dados Básicos', 'Consulta por Almoxarifado',
    'Movimentações');

procedure TfmRequisicoes.ClearPages;
var
  i:     Integer;
  aForm: TForm;
  aTabSheet: TTabSheet;
begin
  i := Ord(High(TRequisicoesPageType));
  if i > pgMain.PageCount - 1 then
    i := pgMain.PageCount - 1;
  while i > -1 do
  begin
    aTabSheet := pgMain.Pages[i];
    aForm     := TForm(aTabSheet.Tag);
    if ((aForm <> nil) and (aForm is RequisicaoFormClass[TRequisicoesPageType(I)]))
    then
    begin
      aForm.Release;
      aTabSheet.Tag := 0;
    end;
    pgMain.RemoveControl(aTabSheet);
    aTabSheet.Free;
    aTabSheet := nil;
    if aTabSheet = nil then
      Dec(i);
  end;
end;

procedure TfmRequisicoes.ShowAPage(Ix : Integer);
var
  aForm:     TForm;
  aTabSheet: TTabSheet;
  PageType:  TRequisicoesPageType;
begin
  if ((Ix < 0) or (Ix > Ord(High(TRequisicoesPageType))) or (Ix >= pgMain.PageCount)) then
    exit;
  PageType  := TRequisicoesPageType(Ix);
  aTabSheet := pgMain.Pages[Ix];
  if aTabSheet = nil then exit;
  Caption := 'Requisições - ' + aTabSheet.Caption;
  aForm   := TForm(aTabSheet.Tag);
  if aForm = nil then
  begin
    aForm         := RequisicaoFormClass[PageType].Create(Self);
    aForm.Parent  := aTabSheet;
    aForm.Align   := alClient;
    aTabSheet.Tag := LongInt(aForm);
    if (aForm is TfmNovaRequisicao) then
      TfmNovaRequisicao(aForm).OnChangeState := ChangeState;
    aForm.Show;
  end;
end;

procedure TfmRequisicoes.LoadPages;
var
  aTabSheet: TTabSheet;
  PageType:  TRequisicoesPageType;
begin
  ClearPages;
  for PageType := Low(TRequisicoesPageType) to High(TRequisicoesPageType) do
  begin
    aTabSheet     := TTabSheet.Create(pgMain);
    aTabSheet.PageControl := pgMain;
    aTabSheet.Caption := RequisicaoPageTitle[PageType];
    aTabSheet.Tag := 0;
  end;
end;


procedure TfmRequisicoes.FormDestroy(Sender : TObject);
begin
  ClearPages;
end;

procedure TfmRequisicoes.FormShow(Sender : TObject);
begin
  FScrState := dbmBrowse;
  LoadPages;
  ShowAPage(0);
end;

procedure TfmRequisicoes.pgMainChange(Sender : TObject);
begin
  ShowAPage(pgMain.TabIndex);
end;

procedure TfmRequisicoes.FormKeyDown(Sender : TObject; var Key : Word;
  Shift : TShiftState);
var
  aControl: TWinControl;
begin
  aControl := Screen.ActiveControl;
  if aControl <> nil then
  begin
    if ((aControl is TVirtualStringTree) and
      (TVirtualStringTree(aControl).IsEditing)) then
      exit;
    aControl := aControl.Parent;
    if ((aControl <> nil) and (aControl is TVirtualStringTree) and
      (TVirtualStringTree(aControl).IsEditing)) then
      exit;
  end;
  if Key = vk_Escape then
    Close;
end;

procedure TfmRequisicoes.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  if (not (Panel.Index in [1, 2])) then exit;
  StatusBar.Canvas.Brush.Color := clBtnFace;
  StatusBar.Canvas.Font.Style  := [fsBold];
  StatusBar.Canvas.Font.Name := 'Arial';
  StatusBar.Canvas.FillRect(Rect);
  if (Panel.Index = 1) then
  begin
    FRect := Rect;
    StatusBar.Canvas.Font.Color := ClNavy;
    Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
    StatusBar.Canvas.TextOut(Rect.Left + 22, Rect.Top + 1,'Empresa: ' +
      IntToStr(Dados.PkCompany) + ' / ' + Dados.NameCompany);
  end;
  if Panel.Index = 2 then
  begin
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrState];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrState]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
  end;
end;

procedure TfmRequisicoes.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TfmRequisicoes.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  // Change the company...
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    FCompanyClick := False;
    SelEmpresa.Free;
  end;
  sbStatus.Repaint;
end;

procedure TfmRequisicoes.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  FScrState := AState;
  sbStatus.Repaint;
end;

procedure TfmRequisicoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (FScrState in UPDATE_MODE) then
    if (Dados.DisplayMessage('Há alterações na tela. Deseja sair e abandonar ' +
          'as alterações?', hiQuestion, [mbYes, mbNo]) = mrNo) then
      Action := caNone;
end;

initialization
  RegisterClass(TfmRequisicoes);
end.

