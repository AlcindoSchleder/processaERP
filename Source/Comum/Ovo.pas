unit Ovo;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: � 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
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

uses SysUtils, Classes, Types, ProcType, SecrPnl,
  {$IFNDEF LINUX}
    Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls
  {$ELSE}
    QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls
  {$ENDIF};

type
  TfrmEgg = class(TForm)
    spEggPanel: TPrcScrtPnl;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure spEggPanelDblClick(Sender: TObject);
    procedure spEggPanelClick(Sender: TObject);
    procedure spEggPanelPaintClient(Sender: TObject; Canvas: TCanvas;
      Rect: TRect);
  private
    FundoBmp: TBitmap;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEgg: TfrmEgg;

implementation

uses Dado, CmmConst;

{$R *.DFM}

procedure TfrmEgg.FormCreate(Sender: TObject);
begin
  Caption := Application.Title + ' - Ovo de P�scoa';
  spEggPanel.Lines.Add('');
  spEggPanel.Lines.Add('Caracter�sticas do BD:');
  spEggPanel.Lines.Add('Comandos Ativos: ' + IntToStr(Dados.Conexao.ActiveStatements));
  spEggPanel.Lines.Add('Driver do Banco de Dados: ' + Dados.Conexao.DriverName);
  spEggPanel.Lines.Add('');
  spEggPanel.Lines.Add('Mensagem do Autor:');
  spEggPanel.Lines.Add('Caro usu�rio:');
  spEggPanel.Lines.Add('O Sistema Processa Open Source');
  spEggPanel.Lines.Add('� uma ferramenta E.R.P.');
  spEggPanel.Lines.Add('desenvolvida com tecnologia de ponta.');
  spEggPanel.Lines.Add('Este sistema de gest�o,');
  spEggPanel.Lines.Add('fora idealizado para empresas');
  spEggPanel.Lines.Add('de pequeno e m�dio porte');
  spEggPanel.Lines.Add('que n�o tem acesso aos sistemas');
  spEggPanel.Lines.Add('E.R.P. do mercado por seus pre�os');
  spEggPanel.Lines.Add('abusivos. Como � Open Source sob');
  spEggPanel.Lines.Add('a licen�a GPL, voc� pode utilizar');
  spEggPanel.Lines.Add('livremente, por�m necessitando');
  spEggPanel.Lines.Add('de suporte, voc� deve renumerar');
  spEggPanel.Lines.Add('este treinamento. Al�m disso,');
  spEggPanel.Lines.Add('se quiser tornar-se um membro');
  spEggPanel.Lines.Add('da equipe de desenvolvimento,');
  spEggPanel.Lines.Add('cadastre-se em');
  spEggPanel.Lines.Add('http:\\www.sistemaprocessa.com.br e envie-me');
  spEggPanel.Lines.Add('seu login para que eu possa');
  spEggPanel.Lines.Add('Adicion�-lo a equipe de desenv.');
  spEggPanel.Lines.Add('Aguardo sua correspon�ncia.');
  spEggPanel.Lines.Add('____________________________');
  spEggPanel.Lines.Add('Alcindo Schleder');
  spEggPanel.Lines.Add('alcindo@sistemaprocessa.com.br');
  spEggPanel.Lines.Add('http://www.sistemaprocessa.org.br');
  spEggPanel.Lines.Add('');
  spEggPanel.Lines.Add('Validade do Sistema:');
  spEggPanel.Lines.Add('Use livremente - Open Source');
end;

procedure TfrmEgg.FormActivate(Sender: TObject);
begin
  spEggPanelClick(Sender);
end;

procedure TfrmEgg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '+' then
    spEggPanel.Interval := spEggPanel.Interval + 50;
  if Key = '-' then
    spEggPanel.Interval := spEggPanel.Interval - 50;
end;

procedure TfrmEgg.spEggPanelDblClick(Sender: TObject);
begin
  if FundoBmp <> nil then FundoBmp.Free;
  Close;
end;

procedure TfrmEgg.spEggPanelClick(Sender: TObject);
begin
  if not spEggPanel.Active then
    spEggPanel.Active := True;
end;

procedure TfrmEgg.spEggPanelPaintClient(Sender: TObject; Canvas: TCanvas;
  Rect: TRect);
begin
  if FundoBmp <> nil then
    Canvas.StretchDraw(Rect, FundoBmp);
end;

end.
