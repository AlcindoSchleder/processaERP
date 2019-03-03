inherited CdTypeOccurs: TCdTypeOccurs
  Caption = 'CdTypeOccurs'
  ClientWidth = 383
  PixelsPerInch = 96
  TextHeight = 13
  object lPk_Tipo_Ocorrencias: TStaticText
    Left = 8
    Top = 32
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Ocorrencias
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Tipo_Ocorrencias: TCurrencyEdit
    Left = 120
    Top = 32
    Width = 109
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Anchors = [akLeft, akRight]
    ParentFont = False
    TabOrder = 1
  end
  object eDsc_TOcr: TEdit
    Left = 120
    Top = 56
    Width = 249
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 2
  end
  object lDsc_TOcr: TStaticText
    Left = 8
    Top = 56
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TOcr
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object lPrefix_File: TStaticText
    Left = 8
    Top = 80
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Prefixo do Arq.: '
    FocusControl = ePrefix_File
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object ePrefix_File: TEdit
    Left = 120
    Top = 80
    Width = 109
    Height = 21
    Anchors = [akLeft, akRight]
    MaxLength = 10
    TabOrder = 5
  end
  object lFlag_GFin: TCheckBox
    Left = 240
    Top = 80
    Width = 135
    Height = 17
    Anchors = [akRight]
    Caption = 'Gerar Financeiro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eDta_LRead: TDateEdit
    Left = 120
    Top = 104
    Width = 113
    Height = 21
    Color = clTeal
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Anchors = [akLeft, akRight]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 7
  end
  object lDta_LRead: TStaticText
    Left = 8
    Top = 104
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Data '#218'lt. Leitura'
    FocusControl = eDta_LRead
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object stTitle: TStaticText
    Left = 0
    Top = 0
    Width = 383
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
    TabOrder = 9
  end
  object lFlag_TOcr: TRadioGroup
    Left = 8
    Top = 136
    Width = 369
    Height = 78
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Tipo de Ocorr'#234'ncia'
    Columns = 2
    Items.Strings = (
      'Ocorr'#234'ncias das Passagens'
      'Troca de Turnos'
      'Passagens com cart'#227'o magn'#233'tico'
      'Outras Ocorr'#234'ncias (co)'
      'Cobran'#231'a do Ped'#225'gio')
    TabOrder = 10
  end
end
