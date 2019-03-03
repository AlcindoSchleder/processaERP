unit Senha;

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

uses Forms, Windows, SysUtils, Classes, Graphics, Controls, StdCtrls, Buttons,
  ExtCtrls, Dialogs, Messages, ComCtrls, Encryp, ImgList, Enter, IniFiles,
  shForm, DB, DBClient, MidasLib, XPMan;

type
  TFSenha = class(TForm)
    Cripto: TCrypto;      
    mrEnter: TMREnter;
    lPassword: TStaticText;
    lLogin: TStaticText;
    eSenha: TEdit;
    eNome: TEdit;
    sbEntra: TSpeedButton;
    sbSai: TSpeedButton;
    sbStatus: TStatusBar;
    XPManifest1: TXPManifest;
    procedure sbEntraClick(Sender: TObject);
    procedure sbSaiClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eNomeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSenha: TFSenha;

implementation

uses Dado, Funcoes, Menu, ProcType, CmmConst, mMenu, mArqSql;

{$R *.dfm}

procedure TFSenha.sbEntraClick(Sender: TObject);
begin
  with Dados do
  begin
    if Conexao.Connected then
      Conexao.Close;
    Conexao.Params.Values['Database']  := DBOptions.dboDBFile;
//  ShowMessage('DBOptions.dboHostName: ' + DBOptions.dboHostName + NL +
//              'DBOptions.dboDBFile: ' + DBOptions.dboDBFile);
    Dados.Parametros.soUser            := eNome.Text;
    Dados.Parametros.soUserPassword    := eSenha.Text;
    Conexao.Params.Values['User_Name'] := eNome.Text;
    Conexao.Params.Values['Password']  := eSenha.Text;
    try
      Conexao.Connected := True;
    except on E:Exception do
      begin
        eSenha.Text := '';
        eSenha.SetFocus;
        raise Exception.Create('Conexao DataBase Name ==> ' +
          Conexao.Params.Values['Database'] + #13 +
          'Erro ao conectar no banco de dados: ' + #13 +
          E.Message);
      end;
    end;
    if dmMenu.AchaOperador(eNome.Text) and dmMenu.SelecionaModulos then
    begin
      FSenha.Hide;
      try
        Application.CreateForm(TfProcessa, fProcessa);
        fProcessa.Password := eSenha.Text;
        fProcessa.Operator := eNome.Text;
        fProcessa.ShowModal;
      finally
        if Assigned(fProcessa) then
          fProcessa.Free;
        fProcessa := nil;
      end;
      FSenha.Show;
      eSenha.Clear;
      eSenha.SetFocus;
      if Conexao.Connected then Conexao.Close;
    end
    else
      MessageBox(Application.Handle, PChar('Login inválido!!!'),
        PChar('Login inválido!!!'), MB_ICONSTOP + MB_OK);
  end;
end;

procedure TFSenha.sbSaiClick(Sender: TObject);
begin
  Close;
end;

procedure TFSenha.FormActivate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
  Dados.Image16.GetBitmap(42, sbEntra.Glyph);
  Dados.Image16.GetBitmap(41, sbSai.Glyph);
end;

procedure TFSenha.ShowHint(Sender: TObject);
begin
  Sender := Screen.ActiveForm.FindComponent('sbStatus');
  if Sender <> nil then
    (Sender as TStatusBar).Panels[0].Text := ' ' + Application.Hint;
end;

procedure TFSenha.FormCreate(Sender: TObject);
var
  ArquivoIni: TIniFile;
begin
  Application.HelpFile := SHELPMENU;
  ArquivoIni := TIniFile.Create(PathDoPrograma('') + 'Processa.ini');
  {$IFDEF WIN32}
    DBOptions.dboDBFile := ArquivoIni.ReadString('BD', 'WinGdb', '');
  {$ENDIF}
  {$IFDEF LINUX}
    DBOptions.dboDBFile := ArquivoIni.ReadString('BD', 'LnxGdb', '');
  {$ENDIF}
  LANGUAGE              := ArquivoIni.ReadString('DB', 'Language', 'pt_br');
  DBOptions.dboHostName := ArquivoIni.ReadString('BD', 'ServerName', '');
  if (DBOptions.dboHostName = '') then
    DBOptions.dboHostName := Copy(DBOptions.dboDBFile, 1, Pos(':', DBOptions.dboDBFile) - 1);
  DBOptions.dboCharset  := ArquivoIni.ReadString('BD', 'ServerCharSet', 'WIN1252');
  Dados.Conexao.Params.Values['ServerCharSet']  := DBOptions.dboCharset;
  ArquivoIni.Free;
  FSenha.Caption := Application.Title;
  {$IFDEF WIN32}
    eNome.Text := GetWindowsUser;
  {$ENDIF}
end;

procedure TFSenha.eNomeExit(Sender: TObject);
begin
  if (eNome.Text <> '') and
     (eSenha.Text <> '') then
    sbEntraClick(Sender);
end;

procedure TFSenha.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  KeyOff: Word;
begin
  KeyOff := Key;
  if (Key = VK_ESCAPE) or ((key = VK_RETURN) and (eNome.Text <> '') and
     (eSenha.Text <> '')) then
    Key := 0;
  if KeyOff = VK_ESCAPE then
    Close;
  if (keyOff = VK_RETURN) and (eNome.Text <> '') and (eSenha.Text <> '') then
    sbEntra.Click;
end;

procedure TFSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(Dados) then Dados.Free;
  Dados := nil;
end;

end.

