unit DlgAlrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, shForm, TrnspMem, VpData, vpSR,
  VpBaseDS, vpConst;

type
  TDlgResult = (drOpenItem, drNormal);

  TAlarmDlg  = class(TForm)
    Fundo: TShapeForm;
    sbOpen: TSpeedButton;
    lDescription: TLabel;
    sbSnooze: TSpeedButton;
    sbDismiss: TSpeedButton;
    eSnooze: TComboBox;
    lSnooze: TLabel;
    lCaption: TLabel;
    sbDown: TSpeedButton;
    sbUp: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure sbOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbSnoozeClick(Sender: TObject);
    procedure sbDismissClick(Sender: TObject);
    procedure eSnoozeChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbUpClick(Sender: TObject);
    procedure sbDownClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FSnoozeDelay: TDateTime;
    FShowTime   : TDateTime;
    FEvent: TVpEvent;
    procedure PopulateDlg;
  public
    { Public declarations }
    mText: TTransparentMemo;
    constructor Create(AEvent: TVpEvent); reintroduce;
    procedure WMNchitTest(var M:TWMNChitTest); message WM_NCHITTEST;
  published
    { Published declarations }
    property Event: TVpEvent read FEvent write FEvent;
  end;

implementation

uses Dado, CrmAgent;

{$R *.dfm}

constructor TAlarmDlg.Create(AEvent: TVpEvent);
begin
  inherited Create(nil);
  FEvent := AEvent;
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
  Icon := Application.Icon;
  mText := TTransparentMemo.Create(Self);
  mText.BorderStyle := bsNone;
  mText.Parent      := Self;
  mText.ScrollBars  := ssNone;
  mText.Top         := 54;
  mText.Left        := 21;
  mText.Height      := 106;
  mText.Width       := 276;
  mText.Visible     := True;
  FEvent.AlertDisplayed := True;
  PopulateDlg;
end;

procedure TAlarmDlg.FormActivate(Sender: TObject);
begin
  Top := 0;
  Left := 0;
  Fundo.Regionize;
  mText.ScrollTop;
  Dados.Image16.GetBitmap(41, sbDismiss.Glyph);
  Dados.Image16.GetBitmap(07, sbSnooze.Glyph);
  Dados.Image16.GetBitmap(00, sbOpen.Glyph);
  Dados.Image16.GetBitmap(69, sbDown.Glyph);
  Dados.Image16.GetBitmap(70, sbUp.Glyph);
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
      lCaption.Caption := RSOverdue + ' : '
    else
      lCaption.Caption := RSReminder + ' : ';

    lCaption.Caption := Self.Caption + FormatDateTime(ShortDateFormat + ' '
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
    FSnoozeDelay      := 5 / MinutesInDay;
    FShowTime         := Now;
  end;
end;

procedure TAlarmDlg.sbSnoozeClick(Sender: TObject);
begin
  FEvent.SnoozeTime := Now + FSnoozeDelay;
  Close;
end;

procedure TAlarmDlg.sbDismissClick(Sender: TObject);
begin
  FEvent.AlarmSet := false;
  Close;
end;

procedure TAlarmDlg.eSnoozeChange(Sender: TObject);
begin
  case eSnooze.ItemIndex of
    0 : FSnoozeDelay :=  5  / MinutesInDay; { 5 minutes }
    1 : FSnoozeDelay := 10  / MinutesInDay; {10 Minutes }
    2 : FSnoozeDelay := 15  / MinutesInDay; {15 Minutes }
    3 : FSnoozeDelay := 30  / MinutesInDay; {30 Minutes }
    4 : FSnoozeDelay := 45  / MinutesInDay; {45 Minutes }
    5 : FSnoozeDelay := 60  / MinutesInDay; {1 Hour     }
    6 : FSnoozeDelay := 120 / MinutesInDay; {2 Hours    }
    7 : FSnoozeDelay := 180 / MinutesInDay; {3 Hours    }
    8 : FSnoozeDelay := 240 / MinutesInDay; {4 Hours    }
    9 : FSnoozeDelay := 300 / MinutesInDay; {5 Hours    }
    10: FSnoozeDelay := 360 / MinutesInDay; {6 Hours    }
    11: FSnoozeDelay := 420 / MinutesInDay; {7 Hours    }
    12: FSnoozeDelay := 480 / MinutesInDay; {8 Hours    }
    13: FSnoozeDelay := 1.0;                {1 day      }
    14: FSnoozeDelay := 2.0;                {2 day      }
    15: FSnoozeDelay := 3.0;                {3 day      }
    16: FSnoozeDelay := 4.0;                {4 day      }
    17: FSnoozeDelay := 5.0;                {5 day      }
    18: FSnoozeDelay := 6.0;                {6 day      }
    19: FSnoozeDelay := 7.0;                {1 week     }
  end;
end;

procedure TAlarmDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    FEvent.SnoozeTime := Now + FSnoozeDelay;
    Close;
  end;
end;

procedure TAlarmDlg.sbUpClick(Sender: TObject);
begin
  if mText.Lines.Count > 0 then
    mText.ScrollLineUp;
end;

procedure TAlarmDlg.sbDownClick(Sender: TObject);
begin
  if mText.Lines.Count > 0 then
    mText.ScrollLineDown;
end;

procedure TAlarmDlg.FormDestroy(Sender: TObject);
begin
  FEvent := nil;
end;

procedure TAlarmDlg.FormClose(Sender: TObject; var Action: TCloseAction);
var
  WinHandle: HWND;
begin
  FEvent := nil;
  WinHandle       := FindWindow('TCdAgenda', nil);
  if WinHandle > 0 then
    PostMessage(WinHandle, WM_USER, -1, Ord(etShowAlert));
end;

end.
