inherited CdModels: TCdModels
  Left = 493
  Top = 128
  Caption = 'CdModels'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 8
    Top = 8
    Width = 433
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 15
    Width = 417
    Height = 20
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Tabela de Modelos de Ve'#237'culos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lPk_Veiculos_Modelos: TStaticText
    Left = 8
    Top = 72
    Width = 137
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Veiculos_Modelos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Veiculos_Modelos: TEdit
    Left = 152
    Top = 72
    Width = 89
    Height = 21
    Anchors = [akLeft, akRight]
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = '0'
  end
  object lDsc_Mod: TStaticText
    Left = 8
    Top = 112
    Width = 137
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Mod
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eDsc_Mod: TEdit
    Left = 152
    Top = 112
    Width = 289
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lAno_FIni: TStaticText
    Left = 8
    Top = 152
    Width = 225
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Ano de Fabrica'#231#227'o Inicial: '
    FocusControl = eAno_FIni
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eAno_FIni: TCurrencyEdit
    Left = 240
    Top = 152
    Width = 89
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akRight]
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lAno_FFin: TStaticText
    Left = 8
    Top = 192
    Width = 225
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Ano de Fabrica'#231#227'o Final: '
    FocusControl = eAno_FFin
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eAno_FFin: TCurrencyEdit
    Left = 240
    Top = 192
    Width = 89
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akRight]
    TabOrder = 7
    OnChange = ChangeGlobal
  end
end
