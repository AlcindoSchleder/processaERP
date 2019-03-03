inherited frmDayView: TfrmDayView
  Caption = 'frmDayView'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgMain: TPageControl
    inherited tsVisual: TTabSheet
      object vpDayView: TVpDayView
        Left = 0
        Top = 0
        Width = 361
        Height = 457
        Color = clWindow
        Align = alClient
        ReadOnly = False
        TabStop = True
        TabOrder = 0
        AllDayEventAttributes.BackgroundColor = clBtnShadow
        AllDayEventAttributes.EventBorderColor = cl3DDkShadow
        AllDayEventAttributes.EventBackgroundColor = clBtnFace
        AllDayEventAttributes.Font.Charset = DEFAULT_CHARSET
        AllDayEventAttributes.Font.Color = clWindowText
        AllDayEventAttributes.Font.Height = -11
        AllDayEventAttributes.Font.Name = 'MS Sans Serif'
        AllDayEventAttributes.Font.Style = []
        ShowEventTimes = False
        DrawingStyle = dsFlat
        TimeSlotColors.Active = 16776176
        TimeSlotColors.Inactive = clMedGray
        TimeSlotColors.Holiday = 10930928
        TimeSlotColors.Weekday = 16776176
        TimeSlotColors.Weekend = clMoneyGreen
        TimeSlotColors.ActiveRange.RangeBegin = h_07
        TimeSlotColors.ActiveRange.RangeEnd = h_19
        HeadAttributes.Font.Charset = DEFAULT_CHARSET
        HeadAttributes.Font.Color = clBlue
        HeadAttributes.Font.Height = -13
        HeadAttributes.Font.Name = 'Tahoma'
        HeadAttributes.Font.Style = [fsBold]
        HeadAttributes.Color = clInfoBk
        RowHeadAttributes.HourFont.Charset = DEFAULT_CHARSET
        RowHeadAttributes.HourFont.Color = clBlue
        RowHeadAttributes.HourFont.Height = -24
        RowHeadAttributes.HourFont.Name = 'Tahoma'
        RowHeadAttributes.HourFont.Style = []
        RowHeadAttributes.MinuteFont.Charset = DEFAULT_CHARSET
        RowHeadAttributes.MinuteFont.Color = clBlue
        RowHeadAttributes.MinuteFont.Height = -12
        RowHeadAttributes.MinuteFont.Name = 'Tahoma'
        RowHeadAttributes.MinuteFont.Style = []
        RowHeadAttributes.Color = clInfoBk
        IconAttributes.AlarmBitmap.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888000888888888888080808888088888080880888088888080888808
          0888880880888808888800888008880888880888808088080000088880808808
          8888008880088808888888088088880808888880808888088088888808088088
          8808888880808088888888888800088888888888888888888888}
        IconAttributes.RecurringBitmap.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000010000000000000000000
          BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777700007777777778888887777700007777777000003888777700007777
          770BBBB03088877700007777770BBBB0308887770000777770BBBB0333088777
          0000777770BBBB03330887770000777770000003330887770000777777778033
          3308877700007777777000333308877700007777770BB0333308877700007777
          70BBBB0333088777000077770BBBBBB03308877700007770BBBBBBBB03088777
          0000777000BBBB00030887770000777770BBBB033308777700007777770BBBB0
          3087777700007777770BBBB03077777700007777777000003777777700007777
          77777777777777770000}
        ShowResourceName = True
        LineColor = clGray
        GutterWidth = 10
        DateLabelFormat = 'dddd, dd '#39'de'#39' mmmm '#39'de'#39' yyyy'
        Granularity = gr30Min
        DefaultTopHour = h_07
        TimeFormat = tf24Hour
        OnOwnerEditEvent = vpDayViewOwnerEditEvent
      end
    end
  end
end
