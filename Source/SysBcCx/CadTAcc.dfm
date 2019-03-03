inherited CdTypeAccount: TCdTypeAccount
  Caption = 'CdTypeAccount'
  ClientHeight = 266
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 8
    Top = 8
    Width = 433
    Height = 25
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 11
    Width = 417
    Height = 19
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Tipos de Contas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object eDsc_TCta: TEdit
    Left = 160
    Top = 112
    Width = 273
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    TabOrder = 0
    OnChange = ChangeGlobal
  end
  object lPk_Tipo_Contas: TStaticText
    Left = 8
    Top = 64
    Width = 145
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Contas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object lDsc_TCta: TStaticText
    Left = 8
    Top = 112
    Width = 145
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TCta
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object lFlag_TCta: TRadioGroup
    Left = 160
    Top = 152
    Width = 185
    Height = 91
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Tipo de Conta'
    Items.Strings = (
      'Caixa'
      'Conta Banc'#225'ria'
      'Conta Previs'#227'o')
    TabOrder = 3
    OnClick = ChangeGlobal
  end
  object ePk_Tipo_Contas: TCurrencyEdit
    Left = 160
    Top = 64
    Width = 121
    Height = 21
    AutoSize = False
    Color = clTeal
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Anchors = [akLeft, akTop, akRight]
    ParentFont = False
    TabOrder = 4
  end
end
