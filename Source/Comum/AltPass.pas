unit AltPass;

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

uses SysUtils, Classes,
  {$IFNDEF LINUX}
    Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls, Dialogs
  {$ELSE}
    QGraphics, QForms, QControls, QStdCtrls, QButtons, QExtCtrls, QDialogs
  {$ENDIF};

type
  TAltPassword = class(TForm)
    lActPass: TStaticText;
    eActPass: TEdit;
    lNewPass: TStaticText;
    eNewPass: TEdit;
    eCnfPass: TEdit;
    lCnfPass: TStaticText;
    spOK: TSpeedButton;
    spCancel: TSpeedButton;
    sbGerPwd: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure spOKClick(Sender: TObject);
    procedure spCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eNewPassExit(Sender: TObject);
    procedure sbGerPwdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ActualPassword: string;
    NewPassword   : string;
  end;

var
  AltPassword: TAltPassword;

resourcestring
  slActPass  = 'Senha Atual:';
  slNewPass  = 'Nova Senha:';
  slCnfPass  = 'Confirmação:';
  scAltPass  = 'Alteração das Senhas';
  sspOk      = '&Ok';
  sspCancel  = '&Cancel';

implementation

uses Dado, Funcoes, CmmConst;

{$R *.DFM}

procedure TAltPassword.FormCreate(Sender: TObject);
begin
  lActPass.Caption := slActPass;
  lNewPass.Caption := slNewPass;
  lCnfPass.Caption := slCnfPass;
  Caption          := scAltPass;
  spOk.Caption     := sspOk;
  spCancel.Caption := sspCancel;
  Dados.Image16.GetBitmap(00, spCancel.Glyph);
  Dados.Image16.GetBitmap(16, spOK.Glyph);
end;

procedure TAltPassword.FormActivate(Sender: TObject);
begin
  eActPass.Clear;
  eNewPass.Clear;
  eCnfPass.Clear;
end;

procedure TAltPassword.spOKClick(Sender: TObject);
begin
  if eNewPass.Text <> eCnfPass.Text then
  begin
    MessageDlg('Atenção! Senhas Incorretas, por favor redigitá-las',
      mtError, [mbOk], 0);
    eNewPass.Clear;
    eCnfPass.Clear;
    eNewPass.SetFocus;
  end
  else
  begin
    ActualPassword := eActPass.Text;
    NewPassword    := eNewPass.Text;
    ModalResult    := mrOk;
  end;
end;

procedure TAltPassword.spCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAltPassword.eNewPassExit(Sender: TObject);
begin
  if (eNewPass.Text <> '') and
     (eCnfPass.Text <> '') then
    spOkClick(Sender);
end;

procedure TAltPassword.sbGerPwdClick(Sender: TObject);
begin
  eNewPass.Text := GeneratePassword(10);
end;

end.

