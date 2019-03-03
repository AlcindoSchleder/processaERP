inherited CdSquare: TCdSquare
  Caption = 'CdSquare'
  PixelsPerInch = 96
  TextHeight = 13
  object lFk_Rodovias: TStaticText
    Left = 8
    Top = 40
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Rodovia: '
    FocusControl = eFk_Rodovias
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object eFk_Rodovias: TPrcComboBox
    Left = 120
    Top = 40
    Width = 257
    Height = 21
    Anchors = [akLeft, akRight]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    TabOrder = 1
    TypeObject = toObject
  end
  object lDsc_Prc: TStaticText
    Left = 8
    Top = 96
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Prc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eDsc_Prc: TEdit
    Left = 120
    Top = 96
    Width = 257
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 3
  end
  object lPos_Trc: TStaticText
    Left = 8
    Top = 152
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Posi'#231#227'o : '
    FocusControl = ePos_Trc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object ePos_Trc: TCurrencyEdit
    Left = 120
    Top = 152
    Width = 121
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.0000;- ,0.0000'
    Anchors = [akLeft, akRight]
    TabOrder = 5
  end
end
