unit ClientMsg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Sockets;

resourcestring
  StatusDateTimeFormat = 'mm/dd/yyyy" - "hh:nn:ss:zzz AM/PM';

type
  TfrmClientChat = class(TForm)
    pcLearnSockets: TPageControl;
    tsClient: TTabSheet;
    gbBasicClientSettings: TGroupBox;
    gbConnectionAddressOrHost: TGroupBox;
    rbtnConnectionAddress: TRadioButton;
    rbtnConnectionHost: TRadioButton;
    edConnectionAddress: TEdit;
    edConnectionHost: TEdit;
    gbConnectionportOrService: TGroupBox;
    edConnectionPort: TEdit;
    rbtnConnectionPort: TRadioButton;
    lstClientActivity: TListBox;
    btnClearClientSocketLog: TButton;
    tsTextChat: TTabSheet;
    memSend: TMemo;
    ChatClient: TTcpClient;
    memReceive: TMemo;
    edScreenName: TEdit;
    Label6: TLabel;
    lbUsers: TListBox;
    pnlRefreshList: TPanel;
    cbAutoRefreshUserList: TCheckBox;
    procedure btnClearClientSocketLogClick(Sender: TObject);
    procedure memSendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure memReceiveKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlRefreshListClick(Sender: TObject);
    procedure ChatClientConnect(Sender: TObject);
    procedure ChatClientDisconnect(Sender: TObject);
    procedure ChatClientError(Sender: TObject; SocketError: Integer);
    procedure ChatClientReceive(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);
    procedure ChatClientSend(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbtnConnectionHostClick(Sender: TObject);
    procedure rbtnConnectionAddressClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FClientActive: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses Dado;

procedure TfrmClientChat.btnClearClientSocketLogClick(Sender: TObject);
begin
  lstClientActivity.Items.Clear;
end;

procedure TfrmClientChat.memSendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  WriteText : string;
  Receivers : TStringList;
  I : Integer;
begin
  if (Key = VK_RETURN) then
  begin
    if (UpperCase(Copy(memSend.Text, 1 ,6)) = 'SNAME=') then
      begin
        WriteText := memSend.Text;
        edScreenName.text := Copy(memSend.Text, 7, Length(memSend.Text) - 6);
        lbUsers.Clear;
      end
    else if (Copy(memSend.Text, 1 ,1) = '"') then
      WriteText := '"'
    else if (Copy(memSend.Text, 1 ,1) = '?') then
      WriteText := '?'
    else
      begin
        //<Sender><Receiver, Receiver...Receiver><Message>
        Receivers := TStringList.Create;
        for I := 0 to lbUsers.Items.Count - 1 do
        begin
          if lbUsers.Selected[I] then Receivers.Add(lbUsers.Items[I]);
        end;
        WriteText := '<' + edScreenName.Text + '>' +
                     '<' + Receivers.CommaText + '>' +
                     '<' + memSend.Text + #13#10'>';
        Receivers.Free;
      end;
    if ChatClient.Active then
      begin
        memReceive.Lines.Append(edScreenName.Text + ': ' + memSend.Text + #13#10);
        ChatClient.Sendln(WriteText);
      end
    else
        memReceive.Lines.Append('Cannot send message when disconnected!' + #13#10);
    memSend.Clear;
  end;
end;

procedure TfrmClientChat.memReceiveKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = VK_DELETE) then memReceive.Clear;
end;

procedure TfrmClientChat.pnlRefreshListClick(Sender: TObject);
begin
  pnlRefreshList.Color := clGreen;
  ChatClient.Sendln('"');
end;

procedure TfrmClientChat.ChatClientConnect(Sender: TObject);
begin
  lstClientActivity.Items.Add('Client: Connected');
  memReceive.Lines.Append('Connected...(' + FormatDateTime(StatusDateTimeFormat, Now) + ')' + #13#10);
end;

procedure TfrmClientChat.ChatClientDisconnect(Sender: TObject);
begin
  lstClientActivity.Items.Add('Client: Disconnecting...');
  memReceive.Lines.Append('Disconnected...(' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
  pnlRefreshList.Color := clGreen;
  lstClientActivity.Items.Add('Client: Disconnected');
end;

procedure TfrmClientChat.ChatClientError(Sender: TObject;
  SocketError: Integer);
begin
  lstClientActivity.Items.Add('Client Error: #' + IntToStr(SocketError));
end;

procedure TfrmClientChat.ChatClientReceive(Sender: TObject;
  Buf: PAnsiChar; var DataLen: Integer);
type
  PrevUser = record
    User : string;
    Selected : Boolean;
  end;
  PrevUserList = array of PrevUser;
var
  ReadText : string;
  Temp : PrevUserList;
  I, J : Integer;
begin
  ReadText := ChatClient.Receiveln;
  lstClientActivity.Items.Add('Client: Read ' + FormatDateTime(StatusDateTimeFormat, Now));
  if (Copy(ReadText, 1, 1) = '"') then //A list of users was sent
    begin
      SetLength(Temp, lbUsers.Items.Count);
      for I := 0 to lbUsers.Items.Count - 1 do
      begin
        Temp[I].User := lbUsers.Items[I];
        Temp[I].Selected := lbUsers.Selected[I];
      end;
      lbUsers.Clear;
      lbUsers.Items.CommaText := Copy(ReadText, 1, Length(ReadText));
      //Reselect users
      for I := 0 to lbUsers.Items.Count - 1 do
      begin
        for J := 0 to High(Temp) do
        begin
          if (Temp[J].User = lbUsers.Items[I]) then
            if (Temp[J].Selected) then lbUsers.Selected[I] := True;
        end;
      end;
      pnlRefreshList.Color := clGreen;
    end
  else
    if (Copy(ReadText, 1 ,1) = '*') then
    begin
      pnlRefreshList.Color := clLime;
      if (cbAutoRefreshUserList.Checked) then pnlRefreshList.OnClick(Self);
    end
  else
    memReceive.Lines.Append(ReadText);
end;

procedure TfrmClientChat.ChatClientSend(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
var
  Msg: string;
begin
  lstClientActivity.Items.Add('Client: Write ' + FormatDateTime(StatusDateTimeFormat, Now));
  Msg := 'SName=' + edScreenName.Text;
  Buf := PAnsiChar(Msg);
  DataLen := Length(Msg) + 1;
  ChatClient.SendBuf(Buf, DataLen);
  Application.ProcessMessages;
end;

procedure TfrmClientChat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  lstClientActivity.Items.Add('Client: Closing...');
  if not FClientActive then
    ChatClient.Close;
  memReceive.Lines.Append('Closed(' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
  lstClientActivity.Items.Add('Client: Closed');
end;

procedure TfrmClientChat.rbtnConnectionHostClick(Sender: TObject);
begin
  edConnectionHost.Enabled    := rbtnConnectionHost.Checked;
  edConnectionAddress.Enabled := rbtnConnectionAddress.Checked;
end;

procedure TfrmClientChat.rbtnConnectionAddressClick(Sender: TObject);
begin
  edConnectionHost.Enabled    := rbtnConnectionHost.Checked;
  edConnectionAddress.Enabled := rbtnConnectionAddress.Checked;
end;

procedure TfrmClientChat.FormActivate(Sender: TObject);
begin
  ShowMessage('Executando FormActivate');
  FClientActive := ChatClient.Active;
  ChatClient.OnReceive := ChatClientReceive;
  try
    if not ChatClient.Active then
      ChatClient.Open;
  except on E:Exception do
    lstClientActivity.Items.Add('Client: Error: ' + E.Message);
  end;
  lstClientActivity.Items.Add('Client: Open');
  lstClientActivity.Items.Add('Local Host: ' + ChatClient.LocalHost);
  lstClientActivity.Items.Add('Local Address: ' + ChatClient.LocalHostAddr);
  lstClientActivity.Items.Add('Local Port: ' + ChatClient.LocalPort);
end;

procedure TfrmClientChat.FormCreate(Sender: TObject);
begin
  // Set Name of User
  ShowMessage('Executando o Método FormCreate e Movendo o nome do Operador');
  edScreenName.Text := Dados.Parametros.soUser;
  //Set Connection Port or Service
  ShowMessage('edConnectionPort Text Operador');
  if (rbtnConnectionPort.Checked) then
    ChatClient.RemotePort := edConnectionPort.Text;
  //Set Connection Address or Host
  ShowMessage('edConnectionAddress Text');
  if (rbtnConnectionAddress.Checked) then
    ChatClient.RemoteHost := edConnectionAddress.Text
  else
    if (rbtnConnectionHost.Checked) then
      ChatClient.RemoteHost := edConnectionHost.Text;
  //Set Client Connection Type
  ShowMessage('BlockMode');
  ChatClient.BlockMode := bmNonBlocking;
  //Open Connection
  ShowMessage('Add Items in a client activity');
  lstClientActivity.Items.Add('Client: Opening...');
  ShowMessage('Prontio');
end;

procedure TfrmClientChat.FormDestroy(Sender: TObject);
begin
  if ChatClient.Active then ChatClient.Close;
end;

end.
