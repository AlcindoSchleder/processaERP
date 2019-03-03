inherited CdTrack: TCdTrack
  Caption = 'CdTrack'
  PixelsPerInch = 96
  TextHeight = 13
  object lDsc_Pista: TStaticText
    Left = 8
    Top = 104
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Pista
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object eDsc_Pista: TEdit
    Left = 136
    Top = 104
    Width = 241
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 1
  end
  object ePk_Pracas_Pistas: TCurrencyEdit
    Left = 136
    Top = 56
    Width = 121
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akRight]
    TabOrder = 2
  end
  object lPk_Pracas_Pistas: TStaticText
    Left = 8
    Top = 56
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo da Pista: '
    FocusControl = ePk_Pracas_Pistas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object lFlag_Drt: TRadioGroup
    Left = 136
    Top = 152
    Width = 241
    Height = 49
    Caption = 'Dire'#231#227'o da Pista'
    Columns = 2
    Items.Strings = (
      'Norte'
      'Sul')
    TabOrder = 4
  end
  object stTitle: TStaticText
    Left = 0
    Top = 0
    Width = 387
    Height = 21
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Pra'#231'a:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
end
