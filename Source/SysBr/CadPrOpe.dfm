inherited CdOperator: TCdOperator
  Caption = 'CdOperator'
  PixelsPerInch = 96
  TextHeight = 13
  object lPk_Pracas_Operadores: TStaticText
    Left = 8
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo do Oper.: '
    FocusControl = ePk_Pracas_Operadores
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Pracas_Operadores: TCurrencyEdit
    Left = 136
    Top = 72
    Width = 121
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akRight]
    TabOrder = 1
  end
  object eFk_Cadastros: TPrcComboBox
    Left = 136
    Top = 136
    Width = 241
    Height = 21
    Anchors = [akLeft, akRight]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    TabOrder = 2
    TypeObject = toInteger
  end
  object lFk_Cadastros: TStaticText
    Left = 8
    Top = 136
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Funcion'#225'rio: '
    FocusControl = eFk_Cadastros
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
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
    TabOrder = 4
  end
end
