inherited CdGruposMovim: TCdGruposMovim
  Left = 336
  Caption = 'CdGruposMovim'
  ClientHeight = 314
  ClientWidth = 540
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lFlag_Cod: TRadioGroup
    Left = 272
    Top = 232
    Width = 257
    Height = 81
    Anchors = [akLeft, akRight]
    Caption = 'Tipo de C'#243'digo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Refer'#234'ncia Prod.'
      'C'#243'digo do Prod.'
      'C'#243'digo de Barras'
      'C'#243'digo do Fornec.')
    ParentFont = False
    TabOrder = 0
    OnClick = ChangeGlobal
  end
  object lFlag_Estq: TCheckBox
    Left = 272
    Top = 208
    Width = 257
    Height = 17
    Anchors = [akRight]
    Caption = 'Manipular Estoques'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ChangeGlobal
  end
  object lFlag_Dspa: TCheckBox
    Left = 8
    Top = 184
    Width = 257
    Height = 17
    Anchors = [akLeft]
    Caption = 'Gerar frete em Despesas Acess'#243'rias'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ChangeGlobal
  end
  object lFlag_GFin: TCheckBox
    Left = 272
    Top = 184
    Width = 257
    Height = 17
    Anchors = [akRight]
    Caption = 'Gerar Financeiro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = ChangeGlobal
  end
  object lFlag_Grnt: TRadioGroup
    Left = 8
    Top = 232
    Width = 257
    Height = 81
    Anchors = [akLeft]
    Caption = 'Tipo de Garantia:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Nenhuma'
      'Por conta do Fornecedor'
      'Por conta do Transportador'
      'Por conta do Cliente')
    ParentFont = False
    TabOrder = 4
    OnClick = ChangeGlobal
  end
  object lFlag_Dev: TCheckBox
    Left = 8
    Top = 208
    Width = 257
    Height = 17
    Anchors = [akLeft]
    Caption = 'Movimento de Devolu'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = ChangeGlobal
  end
  object lFlag_Orgm: TRadioGroup
    Left = 8
    Top = 112
    Width = 257
    Height = 65
    Anchors = [akLeft]
    Caption = 'Origem:'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Estoques'
      'Clientes'
      'Fornecedores'
      'Controle Interno'
      'Filiais')
    ParentFont = False
    TabOrder = 6
    OnClick = ChangeGlobal
  end
  object lFlag_Dsti: TRadioGroup
    Left = 272
    Top = 112
    Width = 257
    Height = 65
    Anchors = [akLeft, akRight]
    Caption = 'Destino:'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Estoques'
      'Clientes'
      'Fornecedores'
      'Controle Interno'
      'Filiais')
    ParentFont = False
    TabOrder = 7
    OnClick = ChangeGlobal
  end
  object eDsc_GMov: TEdit
    Left = 136
    Top = 80
    Width = 393
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 8
    OnChange = ChangeGlobal
  end
  object lDsc_GMov: TStaticText
    Left = 8
    Top = 80
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_GMov
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object lPk_Grupos_Movimentos: TStaticText
    Left = 8
    Top = 48
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Grupos_Movimentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object ePk_Grupos_Movimentos: TEdit
    Left = 136
    Top = 48
    Width = 97
    Height = 21
    Anchors = [akLeft]
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 11
    Text = '0'
  end
  object lFlag_ES: TRadioGroup
    Left = 272
    Top = 40
    Width = 257
    Height = 33
    Anchors = [akLeft, akRight]
    Caption = 'Tipo:'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Entradas'
      'Sa'#237'das')
    ParentFont = False
    TabOrder = 12
    OnClick = ChangeGlobal
  end
  object pTitle: TPanel
    Left = 8
    Top = 8
    Width = 521
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    Caption = 'pTitle'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
end
