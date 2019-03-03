inherited CdParamsEstq: TCdParamsEstq
  Left = 321
  Top = 149
  Height = 329
  Caption = 'CdParamsEstq'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 249
  end
  inherited sbStatus: TStatusBar
    Top = 282
  end
  inherited vtList: TVirtualStringTree
    Height = 249
    TabOrder = 10
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 249
    TabOrder = 17
  end
  object eFk_Almoxarifados: TComboBox
    Left = 376
    Top = 80
    Width = 273
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 0
    OnSelect = ChangeGlobal
  end
  object eFk_Tipo_Movim_Estq_In: TComboBox
    Left = 376
    Top = 104
    Width = 273
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 1
    OnSelect = ChangeGlobal
  end
  object eFk_Tipo_Movim_Estq_Out: TComboBox
    Left = 376
    Top = 128
    Width = 273
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 2
    OnSelect = ChangeGlobal
  end
  object gbTitle: TGroupBox
    Left = 248
    Top = 32
    Width = 401
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 11
    DesignSize = (
      401
      41)
    object lTitle: TLabel
      Left = 8
      Top = 10
      Width = 385
      Height = 24
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = 'Parametros do M'#243'dulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object lFk_Almoxarifados: TStaticText
    Left = 248
    Top = 80
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Almoxarifado: '
    FocusControl = eFk_Almoxarifados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object lFk_Tipo_Movim_Estq_In: TStaticText
    Left = 248
    Top = 104
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tipo Mov. Entr.: '
    FocusControl = eFk_Tipo_Movim_Estq_In
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object lFk_Tipo_Movim_Estq_Out: TStaticText
    Left = 248
    Top = 128
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tipo Mov. Sa'#237'da: '
    FocusControl = eFk_Tipo_Movim_Estq_Out
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object lPrz_Entr: TStaticText
    Left = 248
    Top = 176
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Margem Default: '
    FocusControl = eMrg_Def
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
  end
  object eMrg_Def: TCurrencyEdit
    Left = 376
    Top = 176
    Width = 121
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.0000;- ,0.0000'
    Anchors = [akLeft, akRight]
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object lFlag_TMrgm: TRadioGroup
    Left = 248
    Top = 208
    Width = 121
    Height = 65
    Anchors = [akLeft, akBottom]
    Caption = 'Tipo de Margem'
    Items.Strings = (
      'Por '#205'ndice'
      'Por Percentual')
    TabOrder = 5
    OnClick = lFlag_TMrgmClick
  end
  object lFlag_TCost: TRadioGroup
    Left = 520
    Top = 176
    Width = 121
    Height = 97
    Anchors = [akLeft, akBottom]
    Caption = 'Tipo de Custo'
    Items.Strings = (
      'Custo M'#233'dio'
      'Custo Real (PMZ)'
      'Custo Informado'
      'Custo Compra'
      'Custo Refer'#234'ncia')
    TabOrder = 7
    OnClick = ChangeGlobal
  end
  object lFlag_TAcabm: TRadioGroup
    Left = 384
    Top = 208
    Width = 121
    Height = 65
    Anchors = [akLeft, akBottom]
    Caption = 'Tipo de Acabamento'
    Items.Strings = (
      'Menor Valor'
      'Valor M'#233'dio '
      'Maior Valor')
    TabOrder = 6
    OnClick = ChangeGlobal
  end
  object lFk_Tabela_Precos: TStaticText
    Left = 248
    Top = 152
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tabela de Pre'#231'os: '
    FocusControl = eFk_Tabela_Precos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
  end
  object eFk_Tabela_Precos: TComboBox
    Left = 376
    Top = 152
    Width = 273
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 3
    OnSelect = ChangeGlobal
  end
end
