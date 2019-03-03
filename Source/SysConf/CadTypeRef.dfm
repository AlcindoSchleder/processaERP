inherited CdTypeReference: TCdTypeReference
  Left = 270
  Top = 237
  Caption = 'CdTypeReference'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 8
    Top = 8
    Width = 441
    Height = 25
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 13
    Width = 425
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Refer'#234'ncias'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lPk_Tipo_Referencias: TStaticText
    Left = 8
    Top = 40
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Referencias
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Tipo_Referencias: TEdit
    Left = 136
    Top = 40
    Width = 113
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
  object lDsc_Ref: TStaticText
    Left = 8
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Ref
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eDsc_Ref: TEdit
    Left = 136
    Top = 72
    Width = 305
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lFaixa_Cust_Fin: TStaticText
    Left = 8
    Top = 104
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Custo Inicial: '
    FocusControl = eFaixa_Cust_Fin
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eFaixa_Cust_Ini: TCurrencyEdit
    Left = 136
    Top = 136
    Width = 81
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.####'
    Anchors = [akLeft, akRight]
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lFaixa_Cust_Ini: TStaticText
    Left = 8
    Top = 136
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Custo Final: '
    FocusControl = eFaixa_Cust_Ini
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eFaixa_Cust_Fin: TCurrencyEdit
    Left = 136
    Top = 104
    Width = 81
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.####'
    Anchors = [akLeft, akRight]
    TabOrder = 7
    OnChange = ChangeGlobal
  end
  object lFlag_TIns: TRadioGroup
    Left = 8
    Top = 176
    Width = 433
    Height = 73
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Tipo de Tratamento do Insumo'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Seleciona Acabamento'
      'Acabamento Fornecido'
      'Sem Acabamento')
    ParentFont = False
    TabOrder = 8
    OnClick = ChangeGlobal
  end
end
