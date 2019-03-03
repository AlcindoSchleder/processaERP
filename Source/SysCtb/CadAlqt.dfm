inherited CdTax: TCdTax
  Caption = 'CdTax'
  ClientHeight = 213
  ClientWidth = 396
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 0
    Top = 0
    Width = 396
    Height = 25
    Align = alTop
  end
  object lTitle: TLabel
    Left = 8
    Top = 5
    Width = 377
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Al'#237'quotas do Imposto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object eAlqt_Arbt: TCurrencyEdit
    Left = 160
    Top = 160
    Width = 105
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;- ,0.00'
    Anchors = [akLeft, akRight]
    MaxValue = 99.999900000000000000
    TabOrder = 0
    OnChange = ChangeGlobal
  end
  object lAlqt_Arbt: TStaticText
    Left = 8
    Top = 160
    Width = 145
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '% Arbitrariedade: '
    FocusControl = eAlqt_Arbt
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object lAlqt_Impst: TStaticText
    Left = 8
    Top = 136
    Width = 145
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Al'#237'q. para Revendas: '
    FocusControl = eAlqt_Impst
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eAlqt_Impst: TCurrencyEdit
    Left = 160
    Top = 136
    Width = 105
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;- ,0.00'
    Anchors = [akLeft, akRight]
    MaxValue = 99.999900000000000000
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lAlqt_Cnsf: TStaticText
    Left = 8
    Top = 112
    Width = 145
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Al'#237'q. Consumidor Final: '
    FocusControl = eAlqt_Cnsf
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eAlqt_Cnsf: TCurrencyEdit
    Left = 160
    Top = 112
    Width = 105
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;- ,0.00'
    Anchors = [akLeft, akRight]
    MaxValue = 99.999900000000000000
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object eFk_Estados: TComboBox
    Left = 136
    Top = 80
    Width = 257
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 6
    OnSelect = ChangeGlobal
  end
  object lFk_Estados: TStaticText
    Left = 8
    Top = 80
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Estado: '
    FocusControl = eFk_Estados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object lFk_Paises: TStaticText
    Left = 8
    Top = 48
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Pa'#237's: '
    FocusControl = eFk_Paises
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object eFk_Paises: TComboBox
    Left = 136
    Top = 48
    Width = 257
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 9
    OnSelect = eFk_PaisesSelect
  end
end
