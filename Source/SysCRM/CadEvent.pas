unit CadEvent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, ComCtrls, StdCtrls, VpEdPop, vpBase, vpData,
  vpConst, vpWavDlg, Spin, VpBaseDS, VpPrtFmtCBox, Mask, ProcUtils, ToolEdit,
  CurrEdit, PrcCombo, TSysCad, vpMisc;

type
  TCdEvents = class(TForm)
    pButtons: TPanel;
    sbOk: TSpeedButton;
    sbCancel: TSpeedButton;
    pgEvents: TPageControl;
    tsBasicData: TTabSheet;
    tsNotes: TTabSheet;
    gbAppointment: TGroupBox;
    lDescription: TStaticText;
    eDescription: TEdit;
    lCategory: TStaticText;
    cbCategory: TPrcComboBox;
    bSepTimer: TBevel;
    cbAllDayEvent: TCheckBox;
    lStartDate: TStaticText;
    lEndDate: TStaticText;
    lStartTime: TStaticText;
    cbStartTime: TPrcComboBox;
    cbEndTime: TPrcComboBox;
    lEndTime: TStaticText;
    bSepInterval: TBevel;
    FileDialog: TOpenDialog;
    lAppointmentRecurrence: TStaticText;
    cbRecurringType: TPrcComboBox;
    lIntervalDays: TStaticText;
    lRepeatUntil: TStaticText;
    bSepReminder: TBevel;
    cbAlarmAdvType: TPrcComboBox;
    sbGetSound: TSpeedButton;
    cbAlarmSet: TCheckBox;
    Image1: TImage;
    mNotesMemo: TMemo;
    eStartDate: TDateEdit;
    eEndDate: TDateEdit;
    eRepeatUntil: TDateEdit;
    eCustomInterval: TCurrencyEdit;
    eAlarmAdvance: TCurrencyEdit;
    pHeader: TPanel;
    stStatus: TStaticText;
    stCaption: TStaticText;
    lFk_Contact: TStaticText;
    eFk_Contact: TPrcComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure cbCategoryDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure GlobalChange(Sender: TObject);
    procedure cbAllDayEventClick(Sender: TObject);
    procedure cbStartTimeSelect(Sender: TObject);
    procedure cbEndTimeSelect(Sender: TObject);
    procedure eStartDateChange(Sender: TObject);
    procedure eEndDateChange(Sender: TObject);
    procedure cbRecurringTypeSelect(Sender: TObject);
    procedure cbAlarmSetClick(Sender: TObject);
    procedure sbGetSoundClick(Sender: TObject);
  private
    { Private declarations }
    FAlarmWavPath: string;
    FCatColorMap : TVpCategoryColorMap;
    FFlagSuper   : Boolean;
    FEvent       : TvpEvent;
    FLoading     : Boolean;
    FResource    : TvpResource;
    FScrMode     : TDBMode;
    FTimeFormat  : TVpTimeFormat;
    procedure PopLists;
    procedure LoadCaptions;
    procedure PopulateDialog;
    procedure DePopulateDialog;
    procedure SetScrMode(AValue: TDbMode);
    function  GetFkContact: TOwner;
    procedure SetFkContact(AValue: TOwner);
    function  GetDescription: string;
    procedure SetDescription(AValue: string);
    function  GetCategory: Integer;
    procedure SetCategory(AValue: Integer);
    function  GetAllDayEvent: Boolean;
    procedure SetAllDayEvent(AValue: Boolean);
    function  GetStartDate: TDate;
    procedure SetStartDate(AValue: TDate);
    function  GetStartTime: TTime;
    procedure SetStartTime(AValue: TTime);
    function  GetEndDate: TDate;
    procedure SetEndDate(AValue: TDate);
    function  GetEndTime: TTime;
    procedure SetEndTime(AValue: TTime);
    function  GetRepeatCode: TVpRepeatType;
    procedure SetRepeatCode(AValue: TVpRepeatType);
    function  GetCustInterval: Integer;
    procedure SetCustInterval(AValue: Integer);
    function  GetRepeatUntil: TDateTime;
    procedure SetRepeatUntil(AValue: TDateTime);
    function  GetAlarmSet: Boolean;
    procedure SetAlarmSet(AValue: Boolean);
    function  GetAlarmAdvance: Integer;
    procedure SetAlarmAdvance(AValue: Integer);
    function  GetAlarmAdvType: TVpAlarmAdvType;
    procedure SetAlarmAdvType(AValue: TVpAlarmAdvType);
    function  GetNotes: string;
    procedure SetNotes(AValue: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AEvent: TVpEvent;
      AResource: TVpResource; AMode: TDBMode; ACategoryColorMap: TVpCategoryColorMap;
      ATimeFormat: TVpTimeFormat = tf24Hour; AFlagSuper: Boolean = False); reintroduce;
    property FlagSuper   : Boolean         read FFlagSuper      write FFlagSuper;
    property Event       : TvpEvent        read FEvent          write FEvent;
    property Resource    : TVpResource     read FResource       write FResource;
    property ScrMode     : TDBMode         read FScrMode        write SetScrMode default dbmBrowse;
    property FkContact   : TOwner          read GetFkContact    write SetFkContact;
    property Description : string          read GetDescription  write SetDescription;
    property Category    : Integer         read GetCategory     write SetCategory;
    property AllDayEvent : Boolean         read GetAllDayEvent  write SetAllDayEvent;
    property StartDate   : TDate           read GetStartDate    write SetStartDate;
    property StartTime   : TTime           read GetStartTime    write SetStartTime;
    property EndDate     : TDate           read GetEndDate      write SetEndDate;
    property EndTime     : TTime           read GetEndTime      write SetEndTime;
    property RepeatCode  : TVpRepeatType   read GetRepeatCode   write SetRepeatCode;
    property CustInterval: Integer         read GetCustInterval write SetCustInterval;
    property RepeatUntil : TDateTime       read GetRepeatUntil  write SetRepeatUntil;
    property AlarmSet    : Boolean         read GetAlarmSet     write SetAlarmSet;
    property AlarmAdvance: Integer         read GetAlarmAdvance write SetAlarmAdvance;
    property AlarmAdvType: TVpAlarmAdvType read GetAlarmAdvType write SetAlarmAdvType;
    property Notes       : string          read GetNotes        write SetNotes;
  end;

var
  CdEvents: TCdEvents;

{$I VpSR.INC}

implementation

uses Dado, CmmConst, mSysCrm, DateUtils, TypInfo, ProcType;

{$R *.dfm}

constructor TCdEvents.Create(AOwner: TComponent; AEvent: TVpEvent;
  AResource: TVpResource; AMode: TDBMode; ACategoryColorMap: TVpCategoryColorMap;
  ATimeFormat: TVpTimeFormat = tf24Hour; AFlagSuper: Boolean = False);
begin
  inherited Create(AOwner);
  FTimeFormat  := ATimeFormat;
  Resource     := AResource;
  Event        := AEvent;
  FCatColorMap := ACategoryColorMap;
  FFlagSuper   := AFlagSuper;
  ScrMode      := AMode;
end;

procedure TCdEvents.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  LoadCaptions;
  cbStartTime.ItemIndex := -1;
  cbEndTime.ItemIndex   := -1;
  eEndDate.Enabled      := False;
  Dados.Image16.GetBitmap(16, sbOk.Glyph);
  Dados.Image16.GetBitmap(56, sbCancel.Glyph);
  tsBasicData.Caption   := Dados.GetStringMessage(LANGUAGE, 'stsBasicData', 'Dados Básicos');
  tsNotes.Caption       := Dados.GetStringMessage(LANGUAGE, 'stsObservation', 'Observações');
  eFk_Contact.Items.Clear;
  eFk_Contact.Items.AddStrings(dmSysCrm.LoadCompanies(FFlagSuper, True));
  cbCategory.Items.Clear;
  for i := 0 to 9 do
    if (FCatColorMap.GetName(i) <> '') then
      cbCategory.Items.Add(FCatColorMap.GetName(i));
  PopLists;
end;

procedure TCdEvents.FormShow(Sender: TObject);
begin
  if Event <> nil then
    PopulateDialog;
end;

function  TCdEvents.GetFkContact: TOwner;
var
  aIdx: Integer;
begin
  Result := nil;
  aIdx := eFk_Contact.ItemIndex;
  if (aIdx > 0) and (eFk_Contact.Items.Objects[aIdx] <> nil) then
    Result := TOwner(eFk_Contact.Items.Objects[aIdx]);
end;

procedure TCdEvents.SetFkContact(AValue: TOwner);
begin
  eFk_Contact.SetIndexFromObjectValue(AValue.PkCadastros);
end;

function  TCdEvents.GetDescription: string;
begin
  Result := eDescription.Text;
end;

procedure TCdEvents.SetDescription(AValue: string);
begin
  eDescription.Text := AValue;
end;

function  TCdEvents.GetCategory: Integer;
begin
  Result := cbCategory.ItemIndex;
end;

procedure TCdEvents.SetCategory(AValue: Integer);
begin
  cbCategory.ItemIndex := AValue;
end;

function  TCdEvents.GetAllDayEvent: Boolean;
begin
  Result :=  cbAllDayEvent.Checked;
end;

procedure TCdEvents.SetAllDayEvent(AValue: Boolean);
begin
  cbAllDayEvent.Checked := AValue;
  eStartDate.Enabled    := not cbAllDayEvent.Checked;
  cbEndTime.Enabled     := not cbAllDayEvent.Checked;
  cbStartTime.Enabled   := not cbAllDayEvent.Checked;
end;

function  TCdEvents.GetStartDate: TDate;
begin
  Result := eStartDate.Date;
end;

procedure TCdEvents.SetStartDate(AValue: TDate);
begin
  if (AValue = 0) then
    eStartDate.Clear
  else
    eStartDate.Date := AValue;
end;

function  TCdEvents.GetStartTime: TTime;
begin
  Result := StrToTime(cbStartTime.Text);
end;

procedure TCdEvents.SetStartTime(AValue: TTime);
var
  aStr: string;
begin
  aStr := FormatDateTime('hh:mm', AValue);
  cbStartTime.Text := FormatDateTime('hh:mm', AValue);
end;

function  TCdEvents.GetEndDate: TDate;
begin
  Result := eEndDate.Date;
end;

procedure TCdEvents.SetEndDate(AValue: TDate);
begin
  if (AValue = 0) then
    eEndDate.Clear
  else
    eEndDate.Date := AValue;
end;

function  TCdEvents.GetEndTime: TTime;
begin
  Result := StrToTime(cbEndTime.Text);
end;

procedure TCdEvents.SetEndTime(AValue: TTime);
begin
  cbEndTime.Text := FormatDateTime('hh:mm', AValue);
end;

function  TCdEvents.GetRepeatCode: TVpRepeatType;
begin
  Result := TVpRepeatType(cbRecurringType.ItemIndex);
end;

procedure TCdEvents.SetRepeatCode(AValue: TVpRepeatType);
begin
  cbRecurringType.ItemIndex := Ord(AValue);
end;

function  TCdEvents.GetCustInterval: Integer;
begin
  Result := eCustomInterval.AsInteger;
end;

procedure TCdEvents.SetCustInterval(AValue: Integer);
begin
  eCustomInterval.Value := AValue;
end;

function  TCdEvents.GetRepeatUntil: TDateTime;
begin
  Result := eRepeatUntil.Date;
end;

procedure TCdEvents.SetRepeatUntil(AValue: TDateTime);
begin
  if (AValue = 0) then
    eRepeatUntil.Clear
  else
    eRepeatUntil.Date := AValue;
end;

function  TCdEvents.GetAlarmSet: Boolean;
begin
  Result := cbAlarmSet.Checked;
end;

procedure TCdEvents.SetAlarmSet(AValue: Boolean);
begin
  cbAlarmSet.Checked := AValue;
end;

function  TCdEvents.GetAlarmAdvance: Integer;
begin
  Result := eAlarmAdvance.AsInteger;
end;

procedure TCdEvents.SetAlarmAdvance(AValue: Integer);
begin
  eAlarmAdvance.Value := AValue;
end;

function  TCdEvents.GetAlarmAdvType: TVpAlarmAdvType;
begin
  Result := TVpAlarmAdvType(cbAlarmAdvType.ItemIndex);
end;

procedure TCdEvents.SetAlarmAdvType(AValue: TVpAlarmAdvType);
begin
  cbAlarmAdvType.ItemIndex := Ord(AValue);
end;

function  TCdEvents.GetNotes: string;
begin
  Result := mNotesMemo.Lines.Text;
end;

procedure TCdEvents.SetNotes(AValue: string);
begin
  mNotesMemo.Lines.Text := AValue;
end;

procedure TCdEvents.sbOkClick(Sender: TObject);
begin
  if Event.Changed then
  begin
    DePopulateDialog;
    dmSysCrm.SaveEvent(Event, FResource, FkContact, ScrMode);
  end;
  Close;
end;

procedure TCdEvents.sbCancelClick(Sender: TObject);
begin
  if (ScrMode in UPDATE_MODE)then
  begin
    if (Dados.DisplayMessage('Deseja Salvar as Alterações?',
         hiQuestion, [mbYes, mbNo]) = mrYes) then
      sbOkClick(Sender)
  end
  else
    Close;
end;

procedure TCdEvents.cbCategoryDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  SaveColor: TColor;
  ColorRect: TRect;
begin
  cbCategory.Canvas.FillRect(Rect);
  SaveColor := cbCategory.Canvas.Brush.Color;
  cbCategory.Canvas.Brush.Color := FCatColorMap.GetColor(Index);
  cbCategory.Canvas.Pen.Color   := clBlack;
  ColorRect.Left                := Rect.Left + 3;
  ColorRect.Top                 := Rect.Top + 2;
  ColorRect.Bottom              := Rect.Bottom - 2;
  ColorRect.Right               := ColorRect.Left + 20;
  cbCategory.Canvas.FillRect(ColorRect);
  cbCategory.Canvas.Rectangle(ColorRect);
  Rect.Left                     := ColorRect.Right + 5;
  cbCategory.Canvas.Brush.Color := SaveColor;
  cbCategory.Canvas.TextOut(Rect.Left, Rect.Top, FCatColorMap.GetName(Index));
end;

procedure TCdEvents.PopLists;
var
  aStrLst: TStrings;
  aMin   : Word;
  aHour  : Word;
  i      : Integer;
  AMPMStr: string;
  aMinStr: string;
begin
  // Time Lists
  aStrLst := TStringList.Create;
  try
    aMin    := 0;
    AMPMStr := ' AM';
    for i := 0 to 96 do
    begin
      if i > 0 then Inc(aMin, 15);
      if aMin > 719 then
        AMPMStr := ' PM';
      if aMin = MinutesInDay then
        AMPMStr := ' AM';
      aHour   := (aMin div 15) div 4;
      aMinStr := IntToStr(aMin mod 60);
      if aMinStr = '0' then aMinStr := '00';
      if FTimeFormat = tf24Hour then
      begin
        if aHour < 24 then
          aStrLst.Add(IntToStr(aHour) + ':' + aMinStr)
      end
      else
      begin
        if aHour > 12 then aHour := aHour - 12;
        if aHour = 0  then aHour := 12;
        aStrLst.Add(IntToStr(aHour) + ':' + aMinStr + AMPMStr);
      end;
    end;
    cbStartTime.Items.Assign(aStrLst);
    cbStartTime.ItemIndex := 0;
    cbEndTime.Items.Assign(aStrLst);
    cbEndTime.ItemIndex := 0;
  finally
    aStrLst.Free;
  end;
  // RecurringList
  cbRecurringType.Items.Add(RSNone);
  cbRecurringType.Items.Add(RSDaily);
  cbRecurringType.Items.Add(RSWeekly);
  cbRecurringType.Items.Add(RSMonthlyByDay);
  cbRecurringType.Items.Add(RSMonthlyByDate);
  cbRecurringType.Items.Add(RSYearlyByDay);
  cbRecurringType.Items.Add(RSYearlyByDate);
  cbRecurringType.Items.Add(RSCustom);
  cbRecurringType.ItemIndex := 0;
  // Alarm Advance Type
  cbAlarmAdvType.Items.Add(RSMinutes);
  cbAlarmAdvType.Items.Add(RSHours);
  cbAlarmAdvType.Items.Add(RSDays);
  cbAlarmAdvType.ItemIndex := 0;
end;

procedure TCdEvents.LoadCaptions;
begin
  lStartDate.Caption      := RSStartDateLbl;
  lEndDate.Caption        := RSEndDateLbl;
  sbOK.Caption            := RSOKBtn;
  sbCancel.Caption        := RSCancelBtn;
  gbAppointment.Caption   := RSAppointmentGroupBox;
  lDescription.Caption    := RSDescriptionLbl;
  lCategory.Caption       := RSCategoryLbl;
  lStartTime.Caption      := RSStartTimeLbl;
  lEndTime.Caption        := RSEndTimeLbl;
  cbAlarmSet.Caption      := RSAlarmSet;
  lIntervalDays.Caption   := RSIntervalLbl;
  lRepeatUntil.Caption    := RSRecurrenceEndsLbl;
  cbAllDayEvent.Caption   := RSAllDayEvent;
  lAppointmentRecurrence.Caption := RSRecurringLbl;
end;

procedure TCdEvents.PopulateDialog;
begin
  FLoading       := True;
  AllDayEvent    := Event.AllDayEvent;
  StartDate      := Event.StartTime;
  EndDate        := Event.EndTime;
  RepeatUntil    := Event.RepeatRangeEnd;
  StartTime      := TimeOf(Event.StartTime);
  EndTime        := TimeOf(Event.EndTime);
  FAlarmWavPath  := Event.AlarmWavPath;
  Description    := Event.Description;
  Notes          := Event.Note;
  AlarmSet       := Event.AlarmSet;
  AlarmAdvance   := Event.AlarmAdv;
  AlarmAdvType   := Event.AlarmAdvType;
  RepeatCode     := Event.RepeatCode;
  CustInterval   := Event.CustInterval;
  Category       := Event.Category;
  FLoading       := False;
end;

procedure TCdEvents.DePopulateDialog;
begin
  // Events
  Event.StartTime      := StartDate + StartTime;
  Event.EndTime        := EndDate   + EndTime;
  Event.RepeatRangeEnd := RepeatUntil;
  Event.Description    := Description;
  Event.Note           := Notes;
  Event.Category       := Category;
  Event.AlarmSet       := AlarmSet;
  Event.AlarmAdv       := AlarmAdvance;
  Event.AlarmAdvType   := AlarmAdvType;
  Event.RepeatCode     := RepeatCode;
  Event.CustInterval   := CustInterval;
  Event.AllDayEvent    := AllDayEvent;
  Event.AlarmWavPath   := FAlarmWavPath;
end;

procedure TCdEvents.SetScrMode(AValue: TDbMode);
begin
  FScrMode              := AValue;
  stStatus.Color        := ColorMode[FScrMode];
  stStatus.Font.Color   := FontColorMode[FScrMode];
  stStatus.Caption      := ModeTypes[FScrMode];
end;

procedure TCdEvents.GlobalChange(Sender: TObject);
begin
  if (FLoading) or (FScrMode in UPDATE_MODE) then exit;
  Event.Changed := True;
  if Event.RecordID > 0 then
    ScrMode := dbmEdit
  else
    ScrMode := dbmInsert;
end;

procedure TCdEvents.cbAllDayEventClick(Sender: TObject);
begin
  SetAllDayEvent(cbAllDayEvent.Checked);
  GlobalChange(Sender);
end;

procedure TCdEvents.cbStartTimeSelect(Sender: TObject);
var
  ST : TDateTime;
begin
  if FLoading then exit;
  GlobalChange(Sender);
  { Verify the value is valid                                          }
  try
    ST := eStartDate.Date + StrToDateTime(cbStartTime.Text);
  except
    cbStartTime.Color := clRed;
    cbStartTime.SetFocus;
    exit;
  end;
  cbStartTime.Color := clWindow;
  { if the end time is less than the start time then change the end    }
  {  time to  follow the start time by 30 minutes                      }
  if (ST > (eEndDate.Date + StrToDateTime(cbEndTime.Text))) then
  begin
    if FTimeFormat = tf24Hour then
      cbEndTime.Text := FormatDateTime ('hh:mm', ST + (30/MinutesInDay))
    else
      cbEndTime.Text := FormatDateTime ('hh:mm AM/PM', ST + (30/MinutesInDay));
  end;
end;

procedure TCdEvents.cbEndTimeSelect(Sender: TObject);
var
  ET : TDateTime;
begin
  if FLoading then exit;
  GlobalChange(Sender);
  { Verify the value is valid                                          }
  try
    ET := eEndDate.Date + StrToDateTime(cbEndTime.Text);
  except
    cbEndTime.Color := clRed;
    cbEndTime.SetFocus;
    exit;
  end;
  cbEndTime.Color := clWindow;
  { if the end time is less than the start time then change the        }
  { start time to precede the end time by 30 minutes                   }
  if (ET < (eStartDate.Date + StrToDateTime(cbStartTime.Text))) then
  begin
    if FTimeFormat = tf24Hour then
      cbStartTime.Text := FormatDateTime ('h:mm', ET - (30/MinutesInDay))
    else
      cbStartTime.Text := FormatDateTime ('h:mm AM/PM', ET - (30/MinutesInDay));
  end;
end;

procedure TCdEvents.eStartDateChange(Sender: TObject);
begin
  if FLoading then exit;
  GlobalChange(Sender);
  if eStartDate.Date > eEndDate.Date then
    eEndDate.Date := eStartDate.Date;
end;

procedure TCdEvents.eEndDateChange(Sender: TObject);
begin
  if FLoading then exit;
  GlobalChange(Sender);
  if eStartDate.Date > eEndDate.Date then
    eStartDate.Date := eEndDate.Date;
end;

procedure TCdEvents.cbRecurringTypeSelect(Sender: TObject);
begin
  if FLoading then exit;
  GlobalChange(Sender);
  if (cbRecurringType.ItemIndex > 0) and
     (eRepeatUntil.Date <= eStartDate.Date) then
    eRepeatUntil.Date     := eStartDate.Date + 365;
  lRepeatUntil.Enabled    := (cbRecurringType.ItemIndex > 0);
  eRepeatUntil.Enabled    := lRepeatUntil.Enabled;
  eCustomInterval.Enabled := cbRecurringType.ItemIndex = 7;
  lIntervalDays.Enabled   := eCustomInterval.Enabled;
  if eCustomInterval.Enabled then
    if Visible then
      eCustomInterval.SetFocus;
end;

procedure TCdEvents.cbAlarmSetClick(Sender: TObject);
begin
  if FLoading then exit;
  GlobalChange(Sender);
  eAlarmAdvance.Enabled  := cbAlarmSet.Checked;
  cbAlarmAdvType.Enabled := cbAlarmSet.Checked;
  Event.SnoozeTime := 0.0;
end;

procedure TCdEvents.sbGetSoundClick(Sender: TObject);
begin
  ExecuteSoundFinder(FAlarmWavPath);
end;

end.
