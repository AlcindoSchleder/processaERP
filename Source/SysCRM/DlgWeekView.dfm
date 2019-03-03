inherited frmWeekView: TfrmWeekView
  Caption = 'frmWeekView'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgMain: TPageControl
    inherited tsVisual: TTabSheet
      object vpWeekView: TVpWeekView
        Left = 0
        Top = 0
        Width = 361
        Height = 457
        Color = clWindow
        Ctl3D = True
        AllDayEventAttributes.BackgroundColor = clWindow
        AllDayEventAttributes.EventBorderColor = clGray
        AllDayEventAttributes.EventBackgroundColor = clBtnFace
        AllDayEventAttributes.Font.Charset = DEFAULT_CHARSET
        AllDayEventAttributes.Font.Color = clWindowText
        AllDayEventAttributes.Font.Height = -11
        AllDayEventAttributes.Font.Name = 'MS Sans Serif'
        AllDayEventAttributes.Font.Style = []
        Align = alClient
        TabStop = True
        TabOrder = 0
        DateLabelFormat = 'dd '#39'de'#39' mmmm '#39'de'#39' yyyy'
        DayHeadAttributes.Color = 16776176
        DayHeadAttributes.DateFormat = 'dddd, dd '#39'de'#39' mmmm'
        DayHeadAttributes.Font.Charset = DEFAULT_CHARSET
        DayHeadAttributes.Font.Color = clWindowText
        DayHeadAttributes.Font.Height = -13
        DayHeadAttributes.Font.Name = 'Tahoma'
        DayHeadAttributes.Font.Style = []
        DayHeadAttributes.Bordered = True
        DrawingStyle = dsFlat
        EventFont.Charset = DEFAULT_CHARSET
        EventFont.Color = clWindowText
        EventFont.Height = -11
        EventFont.Name = 'MS Sans Serif'
        EventFont.Style = []
        HeadAttributes.Font.Charset = DEFAULT_CHARSET
        HeadAttributes.Font.Color = clBlue
        HeadAttributes.Font.Height = -11
        HeadAttributes.Font.Name = 'MS Sans Serif'
        HeadAttributes.Font.Style = [fsBold]
        HeadAttributes.Color = clInfoBk
        LineColor = clGray
        TimeFormat = tf24Hour
        ShowEventTime = True
        WeekStartsOn = dtMonday
      end
    end
  end
end
