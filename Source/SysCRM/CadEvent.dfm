object CdEvents: TCdEvents
  Left = 343
  Top = 210
  BorderStyle = bsNone
  Caption = 'CdEvents'
  ClientHeight = 419
  ClientWidth = 369
  Color = 16776176
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pButtons: TPanel
    Left = 0
    Top = 384
    Width = 369
    Height = 35
    Align = alBottom
    BevelInner = bvLowered
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      369
      35)
    object sbOk: TSpeedButton
      Left = 16
      Top = 8
      Width = 129
      Height = 22
      Anchors = [akLeft]
      Caption = 'sbOk'
      Flat = True
      OnClick = sbOkClick
    end
    object sbCancel: TSpeedButton
      Left = 224
      Top = 8
      Width = 129
      Height = 22
      Anchors = [akRight]
      Caption = 'sbCancel'
      Flat = True
      OnClick = sbCancelClick
    end
  end
  object pgEvents: TPageControl
    Left = 0
    Top = 21
    Width = 369
    Height = 363
    ActivePage = tsBasicData
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object tsBasicData: TTabSheet
      Caption = 'tsBasicData'
      ImageIndex = 23
      object gbAppointment: TGroupBox
        Left = 0
        Top = 0
        Width = 361
        Height = 332
        Align = alClient
        Caption = 'gbAppointment'
        TabOrder = 0
        DesignSize = (
          361
          332)
        object bSepTimer: TBevel
          Left = 8
          Top = 116
          Width = 345
          Height = 2
          Anchors = [akLeft, akRight]
        end
        object bSepInterval: TBevel
          Left = 8
          Top = 208
          Width = 345
          Height = 2
          Anchors = [akLeft, akRight]
        end
        object bSepReminder: TBevel
          Left = 8
          Top = 296
          Width = 345
          Height = 2
          Anchors = [akLeft, akRight]
        end
        object sbGetSound: TSpeedButton
          Left = 317
          Top = 303
          Width = 23
          Height = 22
          Anchors = [akRight]
          Flat = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888000888888888888080808888088888080880888088888080888808
            0888880880888808888800888008880888880888808088080000088880808808
            8888008880088808888888088088880808888880808888088088888808088088
            8808888880808088888888888800088888888888888888888888}
          OnClick = sbGetSoundClick
        end
        object Image1: TImage
          Left = 3
          Top = 302
          Width = 23
          Height = 25
          Anchors = [akLeft]
          Picture.Data = {
            07544269746D61707E010000424D7E0100000000000076000000280000001600
            0000160000000100040000000000080100000000000000000000100000001000
            0000000000000000800000800000008080008000000080008000808000008080
            8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00878888888888888888887800887888888888888888878800888788888877
            8888887888008888888880000888888888008888880008888000888888008888
            708FF8F8F8880088880088887FFFFF8878787088880088888787F88887770888
            880088888878FF8878708888880088888877F88887708888880087778878FF88
            78708877780088888877F88887708888880088888878FF887870888888008888
            8877F888877088888800888888878F887808888888008888888878F880888888
            8800888887888788088878888800888878888877888887888800888788888870
            8888887888008878888888888888888788008888888888888888888888007888
            88888888888888888700}
          Transparent = True
        end
        object lDescription: TStaticText
          Left = 8
          Top = 48
          Width = 57
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lDescription'
          FocusControl = eDescription
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object lCategory: TStaticText
          Left = 8
          Top = 80
          Width = 57
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lCategory'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object lStartDate: TStaticText
          Left = 8
          Top = 152
          Width = 57
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lStartDate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object lEndDate: TStaticText
          Left = 8
          Top = 176
          Width = 57
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lEndDate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object lStartTime: TStaticText
          Left = 192
          Top = 152
          Width = 57
          Height = 21
          Anchors = [akLeft, akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lStartTime'
          FocusControl = cbStartTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object lEndTime: TStaticText
          Left = 192
          Top = 176
          Width = 57
          Height = 21
          Anchors = [akLeft, akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lEndTime'
          FocusControl = cbEndTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object lAppointmentRecurrence: TStaticText
          Left = 8
          Top = 224
          Width = 121
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lAppointmentRecurrence'
          FocusControl = cbRecurringType
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object lIntervalDays: TStaticText
          Left = 8
          Top = 248
          Width = 121
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lIntervalDays'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object lRepeatUntil: TStaticText
          Left = 8
          Top = 272
          Width = 121
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lRepeatUntil'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object eDescription: TEdit
          Left = 72
          Top = 48
          Width = 281
          Height = 21
          Anchors = [akLeft, akRight]
          BevelKind = bkFlat
          BorderStyle = bsNone
          MaxLength = 100
          TabOrder = 0
          OnChange = GlobalChange
        end
        object cbCategory: TPrcComboBox
          Left = 72
          Top = 80
          Width = 281
          Height = 19
          Anchors = [akLeft, akRight]
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 13
          OnDrawItem = cbCategoryDrawItem
          OnSelect = GlobalChange
          Style = csOwnerDrawVariable
          TabOrder = 1
        end
        object cbAllDayEvent: TCheckBox
          Left = 8
          Top = 128
          Width = 345
          Height = 17
          Anchors = [akLeft, akRight]
          Caption = 'cbAllDayEvent'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = cbAllDayEventClick
        end
        object cbStartTime: TPrcComboBox
          Left = 256
          Top = 152
          Width = 97
          Height = 21
          Anchors = [akRight]
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 13
          OnSelect = cbStartTimeSelect
          TabOrder = 3
        end
        object cbEndTime: TPrcComboBox
          Left = 256
          Top = 176
          Width = 97
          Height = 21
          Anchors = [akRight]
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 13
          OnSelect = cbEndTimeSelect
          TabOrder = 4
        end
        object cbRecurringType: TPrcComboBox
          Left = 136
          Top = 224
          Width = 217
          Height = 21
          Anchors = [akLeft, akRight]
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 13
          OnSelect = cbRecurringTypeSelect
          TabOrder = 5
        end
        object cbAlarmAdvType: TPrcComboBox
          Left = 222
          Top = 304
          Width = 88
          Height = 21
          Anchors = [akRight]
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 13
          TabOrder = 6
        end
        object cbAlarmSet: TCheckBox
          Left = 32
          Top = 306
          Width = 89
          Height = 17
          Anchors = [akLeft, akRight]
          Caption = '&Reminder:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = cbAlarmSetClick
        end
        object eStartDate: TDateEdit
          Left = 72
          Top = 152
          Width = 105
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          DialogTitle = 'Selecione uma Data'
          Anchors = [akLeft]
          NumGlyphs = 2
          YearDigits = dyFour
          TabOrder = 17
          OnChange = eStartDateChange
        end
        object eEndDate: TDateEdit
          Left = 72
          Top = 176
          Width = 105
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          DialogTitle = 'Selecione uma Data'
          Anchors = [akLeft]
          NumGlyphs = 2
          YearDigits = dyFour
          TabOrder = 18
          OnChange = eEndDateChange
        end
        object eRepeatUntil: TDateEdit
          Left = 136
          Top = 272
          Width = 105
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          DialogTitle = 'Selecione uma Data'
          Anchors = [akLeft, akRight]
          NumGlyphs = 2
          YearDigits = dyFour
          TabOrder = 19
        end
        object eCustomInterval: TCurrencyEdit
          Left = 136
          Top = 248
          Width = 105
          Height = 21
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          DecimalPlaces = 0
          DisplayFormat = ',0;-,0'
          Anchors = [akLeft, akRight]
          TabOrder = 20
        end
        object eAlarmAdvance: TCurrencyEdit
          Left = 136
          Top = 304
          Width = 81
          Height = 21
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          DecimalPlaces = 0
          DisplayFormat = ',0;-,0'
          Anchors = [akRight]
          TabOrder = 21
          OnChange = GlobalChange
        end
        object lFk_Contact: TStaticText
          Left = 8
          Top = 16
          Width = 57
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Contato:'
          FocusControl = eFk_Contact
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 22
        end
        object eFk_Contact: TPrcComboBox
          Left = 72
          Top = 16
          Width = 281
          Height = 21
          Anchors = [akLeft, akRight]
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 13
          OnSelect = GlobalChange
          TabOrder = 23
        end
      end
    end
    object tsNotes: TTabSheet
      Caption = 'tsNotes'
      ImageIndex = 60
      object mNotesMemo: TMemo
        Left = 0
        Top = 0
        Width = 361
        Height = 332
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = GlobalChange
      end
    end
  end
  object pHeader: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pHeader'
    TabOrder = 2
    object stStatus: TStaticText
      Left = 241
      Top = 0
      Width = 128
      Height = 21
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'stStatus'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object stCaption: TStaticText
      Left = 0
      Top = 0
      Width = 241
      Height = 21
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'Cadastro de Eventos'
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 1
    end
  end
  object FileDialog: TOpenDialog
    Left = 252
    Top = 287
  end
end
