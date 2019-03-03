unit SendMail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, ComCtrls, ToolWin, DB,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdEMailAddress,
  IdMessageClient, IdSMTP, IdMessage, Buttons, IdTCPServer, IdSMTPServer,
  IdIOHandler, IdIOHandlerSocket, IdSSLOpenSSL;

type
  TGnCnstNames = (tgFile, tgClose, tgMail, tgTitle, tgFromMail, tgToMail,
    tgSubject, tgTitleBody);

  TfSendMail = class(TForm)
    StatusBar1: TStatusBar;
    CoolBar1: TCoolBar;
    ToolBar: TToolBar;
    tbClose: TToolButton;
    ToolButton1: TToolButton;
    mMain: TMainMenu;
    miFile: TMenuItem;
    N1: TMenuItem;
    miClose: TMenuItem;
    eMessage: TMemo;
    Panel1: TPanel;
    lFile: TLabel;
    lToMail: TLabel;
    eToMail: TEdit;
    tbMail: TToolButton;
    miMail: TMenuItem;
    stTitleBody: TStaticText;
    Title: TLabel;
    idsMail: TIdSMTP;
    odOpenFile: TOpenDialog;
    idmSendMail: TIdMessage;
    lSubject: TLabel;
    eSubject: TEdit;
    eFromMail: TEdit;
    lFromMail: TLabel;
    eFile: TEdit;
    sbFile: TSpeedButton;
    idSSL: TIdSSLIOHandlerSocket;
    procedure tbCloseClick(Sender: TObject);
    procedure tbMailClick(Sender: TObject);
    procedure sbFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SMTPServerCommandRCPT(const ASender: TIdCommand; var Accept,
      ToForward: Boolean; EMailAddress: String; var CustomError: String);
    procedure SMTPServerCommandMAIL(const ASender: TIdCommand;
      var Accept: Boolean; EMailAddress: String);
    procedure SMTPServerReceiveRaw(ASender: TIdCommand;
      var VStream: TStream; RCPT: TIdEMailAddressList;
      var CustomError: String);
  private
    { Private declarations }
    function CriticalSend: Boolean;
  public
    { Public declarations }
  end;

var
  fSendMail: TfSendMail;

implementation

uses CmmConst, Dado, Clipbrd, ProcType;

{$R *.dfm}

const
  GenConstants: array [0..Integer(High(TGnCnstNames))] of string =
    ('smiFile', 'smiClose', 'smiSendMail', 'sTitle', 'slFromMail',
    'slToMail', 'slSubject', 'slTitleBody');

procedure TfSendMail.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfSendMail.tbMailClick(Sender: TObject);
begin
  if CriticalSend then
  begin
//    if not SMTPServer.Active then SMTPServer.Active := True;
    try
      with idmSendMail do
      begin
        idmSendMail.Clear;
        Body.Assign(eMessage.Lines);
        From.Address := eFromMail.Text;
        if ParamGlobal^.Operator <> '' then
          From.Name := StrPas(ParamGlobal^.Operator);
        CCList.EMailAddresses := From.Address;
        Recipients.EMailAddresses := eToMail.Text;
        Subject := eSubject.Text; { Subject: header }
        if eFile.Text <> '' then
          TIdAttachment.Create(idmSendMail.MessageParts, eFile.Text);
      end;
      idsMail.Host := SMTPHOSTNAME;
  //    idsMail.Username := LoginUser;
  //    idsMail.Password := PasswordUser;
      idsMail.Port := 25;
      idsMail.Connect;
      idsMail.Send(idmSendMail);
    finally
      if idsMail.Connected then idsMail.Disconnect;
//      if SMTPServer.Active then SMTPServer.Active := False;
    end;
    if eFile.Text <> '' then
      if MessageDlg(Dados.GetStringMessage(ParamGlobal^.LANGUAGE, 'sDeleteFile',
         'Deseja excluir o arquivo enviado'), mtWarning,
         [mbYes, mbNo], 0) = mrYes then
        if FileExists(eFile.Text) then DeleteFile(eFile.Text);
    if FileExists('.\tmp.txt') then DeleteFile('.\tmp.txt');
  end;
end;

procedure TfSendMail.sbFileClick(Sender: TObject);
begin
  if odOpenFile.Execute then
    eFile.Text   := odOpenFile.FileName;
end;

procedure TfSendMail.FormCreate(Sender: TObject);
var
  VarGen: array of string;
  procedure FillStrings;
  begin
    miFile.Caption       := VarGen[Integer(tgFile)];
    tbClose.Caption      := VarGen[Integer(tgClose)];
    miClose.Caption      := VarGen[Integer(tgClose)];
    tbMail.Caption       := VarGen[Integer(tgMail)];
    miMail.Caption       := VarGen[Integer(tgMail)];
    Title.Caption        := VarGen[Integer(tgTitle)];
    lFromMail.Caption    := VarGen[Integer(tgFromMail)];
    lToMail.Caption      := VarGen[Integer(tgToMail)];
    lSubject.Caption     := VarGen[Integer(tgSubject)];
    lFile.Caption        := VarGen[Integer(tgFile)];
    stTitleBody.Caption  := VarGen[Integer(tgTitleBody)];
  end;
begin
  SetLength(VarGen, Integer(High(TGnCnstNames)) + 1);
  Dados.GetAllStringsMessage(LANGUAGE, 999, 999, 0, VarGen, GenConstants);
  Caption        := StrPas(ParamGlobal^.SystemTitle) + ' - ' + VarGen[Integer(tgTitle)];
  eToMail.Text   := StrPas(ParamGlobal^.ToMail);
  eFromMail.Text := StrPas(ParamGlobal^.FromMail);
  FillStrings;
  Dados.Image16.GetBitmap(10, sbFile.Glyph);
  if Clipboard.AsText <> '' then
    eMessage.Lines.Add(Clipboard.AsText);
//  smtpServer.LocalName := SMTPHOSTNAME;
end;

function TfSendMail.CriticalSend: Boolean;
begin
  Result := True;
  if eSubject.Text = '' then
  begin
    Application.MessageBox(PAnsiChar(Dados.GetStringMessage(ParamGlobal^.LANGUAGE,
      'sWithOutSubject', 'O assunto da mensagem não foi informado')),
      PAnsiChar(Application.Title), MB_ICONERROR + MB_OK);
    Result := False;
    exit;
  end;
  if eFromMail.Text = '' then
  begin
    Application.MessageBox(PAnsiChar(Dados.GetStringMessage(ParamGlobal^.LANGUAGE,
      'sWithOutFromMail', 'O e-mail do remetente não foi informado')),
      PAnsiChar(Application.Title), MB_ICONERROR + MB_OK);
    Result := False;
    exit;
  end;
  if eToMail.Text = '' then
  begin
    Application.MessageBox(PAnsiChar(Dados.GetStringMessage(ParamGlobal^.LANGUAGE,
      'sWithOutToMail', 'O e-mail do destinatário não foi informado')),
      PAnsiChar(Application.Title), MB_ICONERROR + MB_OK);
    Result := False;
    exit;
  end;
end;

procedure TfSendMail.SMTPServerCommandRCPT(const ASender: TIdCommand;
  var Accept, ToForward: Boolean; EMailAddress: String;
  var CustomError: String);
begin
 Accept := True;
end;

procedure TfSendMail.SMTPServerCommandMAIL(const ASender: TIdCommand;
  var Accept: Boolean; EMailAddress: String);
begin
 Accept := True;
end;

procedure TfSendMail.SMTPServerReceiveRaw(ASender: TIdCommand;
  var VStream: TStream; RCPT: TIdEMailAddressList;
  var CustomError: String);
//var
// M: TMemoryStream;
begin
  eMessage.Lines.Add(RCPT.EMailAddresses);
end;

end.
