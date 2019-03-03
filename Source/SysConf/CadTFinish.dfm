inherited CdTypeFinish: TCdTypeFinish
  Caption = 'CdTypeFinish'
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
    Caption = 'Cadastro de Tipos de Acabamentos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lPk_Tipo_Acabamentos: TStaticText
    Left = 16
    Top = 48
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Acabamentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Tipo_Acabamentos: TEdit
    Left = 142
    Top = 48
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
  object lDsc_Acabm: TStaticText
    Left = 16
    Top = 96
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Acabm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eDsc_Acabm: TEdit
    Left = 142
    Top = 96
    Width = 307
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lFlag_TDsc: TRadioGroup
    Left = 14
    Top = 154
    Width = 427
    Height = 63
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Formato da Descri'#231#227'o do Insumo'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Refer'#234'ncia + Descri'#231#227'o'
      'Descri'#231#227'o'
      'Refer'#234'ncia'
      'Outros')
    ParentFont = False
    TabOrder = 4
    OnClick = ChangeGlobal
  end
end
