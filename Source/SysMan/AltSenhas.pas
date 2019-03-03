unit AltSenhas;

interface

uses SysUtils, Classes,
  {$IFNDEF LINUX}
    Forms, Dialogs, Controls, StdCtrls, Buttons, ExtCtrls
  {$ELSE}
    QForms, QDialogs, QControls, QStdCtrls, QButtons, QExtCtrls
  {$ENDIF};

type
  TAltSenha = class(TForm)
    pPrior: TPanel;
    lPriorPwd: TStaticText;
    ePriorPwd: TEdit;
    pNew: TPanel;
    eNewPwd: TEdit;
    lNewPwd: TStaticText;
    lConfPwd: TStaticText;
    eConfPwd: TEdit;
    spOK: TSpeedButton;
    spCancel: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure OffBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eNewPwdExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AltSenha: TAltSenha;

implementation

{$R *.DFM}

procedure TAltSenha.FormActivate(Sender: TObject);
begin
  ePriorPwd.Clear;
  eNewPwd.Clear;
  eConfPwd.Clear;
end;

procedure TAltSenha.BitBtn1Click(Sender: TObject);
begin
  if eNewPwd.Text <> eConfPwd.Text then
  begin
    MessageDlg('Senhas Incorretas, por favor redigitá-las', mtWarning, [mbOK], 0);
    eNewPwd.Clear;
    eConfPwd.Clear;
    eConfPwd.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TAltSenha.OffBtn2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TAltSenha.FormCreate(Sender: TObject);
begin
  AltSenha.Caption := Application.Title;
end;

procedure TAltSenha.eNewPwdExit(Sender: TObject);
begin
  if (eNewPwd.Text <> '') and
     (eConfPwd.Text <> '') then
    BitBtn1Click(Sender);
end;

end.

