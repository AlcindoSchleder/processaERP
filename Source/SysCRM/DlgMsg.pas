unit DlgMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, shForm, TrnspMem;

type
  TDlgMessage = class(TForm)
    ShapeForm1: TShapeForm;
    cbFlag_Atv: TCheckBox;
    sbClose: TSpeedButton;
    lCaption: TLabel;
    lFooter: TLabel;
    sbDown: TSpeedButton;
    cbUp: TSpeedButton;
    lFlag_Atv: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure cbFlag_AtvClick(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure cbUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbDownClick(Sender: TObject);
  private
    mText: TTransparentMemo;
    { Private declarations }
  public
    { Public declarations }
    procedure WMNchitTest(var M:TWMNChitTest); message WM_NCHITTEST;
  end;

var
  DlgMessage: TDlgMessage;

implementation

{$R *.dfm}

procedure TDlgMessage.WMNchitTest(var M: TWMNChitTest);
var
 pt: TPoint;
 i: Integer;
 NoMove: Boolean;
begin
  NoMove := False;
  inherited;
  GetCursorPos(pt);
  for i := 0 to ControlCount - 1 do
    if (pt.X >= Controls[i].ClientOrigin.X) and
       (pt.X <= Controls[i].ClientOrigin.X +
                Controls[i].Width)          and
       (pt.Y >= Controls[i].ClientOrigin.Y) and
       (pt.Y <= Controls[i].ClientOrigin.Y +
                Controls[i].Height) then
      NoMove := True;
  if NoMove then exit;
  if GetAsyncKeyState(VK_LBUTTON) < 0 then
    M.result := HTCAPTION
  else
    M.result := HTCLIENT;
end;

procedure TDlgMessage.FormCreate(Sender: TObject);
begin
  Icon := Application.Icon;
  mText := TTransparentMemo.Create(Self);
  mText.BorderStyle := bsNone;
  mText.Parent := Self;
  mText.ScrollBars := ssNone;
  mText.Top    := 17;
  mText.Left   := 21;
  mText.Height := 143;
  mText.Width  := 167;
  mText.Visible := True;
end;

procedure TDlgMessage.FormActivate(Sender: TObject);
var
  i: integer;
begin
  Top := 0;
  Left := 0;
  lCaption.Caption := 'Recado de ' + FormatDateTime('dd/mm/yy/ hh:mm', Now);
  lFooter.Caption := 'Enviado por: Alcindo Schleder';
  for i := 0 to 20 do
    mText.Lines.Add('Recadinho pra você: ' + IntToStr(i));
  ShapeForm1.Regionize;
  lFlag_atv.Caption := 'Desativar';
  ActiveControl := mText;
  mText.ScrollTop;
end;

procedure TDlgMessage.cbFlag_AtvClick(Sender: TObject);
begin
  if cbFlag_Atv.Checked then
    ShowMessage('deseja realmente desativar este recado?');
end;

procedure TDlgMessage.sbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TDlgMessage.cbUpClick(Sender: TObject);
begin
  mText.ScrollLineUp;
end;

procedure TDlgMessage.sbDownClick(Sender: TObject);
begin
  mText.ScrollLineDown;
end;

end.
