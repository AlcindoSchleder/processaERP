inherited fmPrdPurchase: TfmPrdPurchase
  Left = 324
  Top = 126
  Caption = 'fmPrdPurchase'
  ClientHeight = 285
  ClientWidth = 591
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lFk_Tipo_Acabamentos: TStaticText
    Left = 8
    Top = 72
    Width = 105
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Acabam.:'
    FocusControl = eFk_Tipo_Acabamentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object eFk_Tipo_Acabamentos: TComboBox
    Left = 120
    Top = 72
    Width = 463
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
    OnSelect = eFk_Tipo_AcabamentosSelect
  end
  object lFk_Tipo_Referencias: TStaticText
    Left = 8
    Top = 128
    Width = 105
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Refer'#234'ncia:'
    FocusControl = eFk_Tipo_Referencias
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eFk_Tipo_Referencias: TComboBox
    Left = 120
    Top = 128
    Width = 463
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 3
  end
  object lVlr_Unit: TStaticText
    Left = 8
    Top = 184
    Width = 105
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Valor Unit.:'
    FocusControl = eVlr_Unit
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eVlr_Unit: TCurrencyEdit
    Left = 120
    Top = 184
    Width = 97
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.00;- ,0.00'
    Anchors = [akLeft]
    TabOrder = 5
  end
  object lFlag_Emp: TCheckBox
    Left = 120
    Top = 216
    Width = 121
    Height = 17
    Anchors = [akLeft]
    Caption = 'Permite Reserva'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lFlag_Cmpr: TCheckBox
    Left = 120
    Top = 248
    Width = 121
    Height = 17
    Anchors = [akLeft]
    Caption = 'Permite Compra'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
end
