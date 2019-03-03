unit DlgAlrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, shForm, TrnspMem, VpData, vpSR;

type
  TAlarmDlg = class(TForm)
    Fundo: TShapeForm;
    sbOpen: TSpeedButton;
    lDescription: TLabel;
    sbSnooze: TSpeedButton;
    sbDismiss: TSpeedButton;
    eSnooze: TComboBox;
    lSnooze: TLabel;
    lCaption: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure sbOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FEvent: TVpEvent;
    procedure PopulateDlg;
  public
    { Public declarations }
    mText: TTransparentMemo;
    constructor Create(AOwner: TComponent; AEvent: TVpEvent); reintroduce;
    procedure WMNchitTest(var M:TWMNChitTest); message WM_NCHITTEST;
  published
    { Published declarations }
    property Event: TVpEvent read FEvent write FEvent;
  end;

implementation

{$R *.dfm}

constructor TAlarmDlg.Create(AOwner: TComponent; AEvent: TVpEvent);
begin
  inherited Create(AOwner);
  mText := TTransparentMemo.Create(Self);
  mText.Name        := 'mText';
  mText.BorderStyle := bsNone;
  mText.Parent      := Self;
  mText.ScrollBars  := ssNone;
  mText.Top         := 54;
  mText.Left        := 21;
  mText.Height      := 106;
  mText.Width       := 276;
  mText.Visible     := True;
  FEvent            := AEvent;
end;

procedure TAlarmDlg.WMNchitTest(var M: TWMNChitTest);
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

procedure TAlarmDlg.FormCreate(Sender: TObject);
begin
  FEvent.AlertDisplayed := True;
  PopulateDlg;
end;

procedure TAlarmDlg.FormActivate(Sender: TObject);
//var
//  i: integer;
begin
  Top := 0;
  Left := 0;
  ShapeForm1.Regionize;
  mText.ScrollTop;
end;

procedure TAlarmDlg.sbOpenClick(Sender: TObject);
begin
  Close;
end;

procedure TAlarmDlg.PopulateDlg;
begin
  if FEvent <> nil then
  begin
    lSnooze.Caption      := RSSnoozeCaption;
    sbDismiss.Caption    := RSDismissBtn;
    sbSnooze.Caption     := RSSnoozeBtn;
    sbOpen.Caption       := RSOpenItemBtn;
    mText.Text           := Event.Note;
    lDescription.Caption := Event.Description;

    if Now > Event.StartTime then
      Self.Caption := RSOverdue + ' : '
    else
      Self.Caption := RSReminder + ' : ';

    Self.Caption := Self.Caption + FormatDateTime(ShortDateFormat + ' '
      + ShortTimeFormat, Event.StartTime);

    eSnooze.Items.Clear;
    eSnooze.Items.Add(RS5Minutes);
    eSnooze.Items.Add(RS10Minutes);
    eSnooze.Items.Add(RS15Minutes);
    eSnooze.Items.Add(RS30Minutes);
    eSnooze.Items.Add(RS45Minutes);
    eSnooze.Items.Add(RS1Hour);
    eSnooze.Items.Add(RS2Hours);
    eSnooze.Items.Add(RS3Hours);
    eSnooze.Items.Add(RS4Hours);
    eSnooze.Items.Add(RS5Hours);
    eSnooze.Items.Add(RS6Hours);
    eSnooze.Items.Add(RS7Hours);
    eSnooze.Items.Add(RS8Hours);
    eSnooze.Items.Add(RS1Days);
    eSnooze.Items.Add(RS2Days);
    eSnooze.Items.Add(RS3Days);
    eSnooze.Items.Add(RS4Days);
    eSnooze.Items.Add(RS5Days);
    eSnooze.Items.Add(RS6Days);
    eSnooze.Items.Add(RS1Week);
    eSnooze.ItemIndex := 0;
//    eSnoozeDelay := 5 / MinutesInDay;
//    eShowTime := Now;
  end;
end;

end.
