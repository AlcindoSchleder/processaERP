inherited CdFinalizadoras: TCdFinalizadoras
  Left = 246
  Top = 108
  Height = 527
  Caption = 'CdFinalizadoras'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 447
  end
  inherited sbStatus: TStatusBar
    Top = 480
  end
  inherited vtList: TVirtualStringTree
    Height = 447
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 447
    TabOrder = 16
  end
  object lPk_Finalizadoras: TStaticText
    Left = 248
    Top = 40
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Finalizadoras
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object eCod_Tecla: THotKey
    Left = 376
    Top = 64
    Width = 105
    Height = 21
    Anchors = [akLeft, akRight]
    HotKey = 0
    Modifiers = []
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object lCod_Tecla: TStaticText
    Left = 248
    Top = 64
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'd. da Tecla'
    FocusControl = eCod_Tecla
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object lDsc_MPgt: TStaticText
    Left = 248
    Top = 88
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o'
    FocusControl = eDsc_MPgt
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eDsc_MPgt: TEdit
    Left = 376
    Top = 88
    Width = 265
    Height = 21
    Anchors = [akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 7
    OnChange = ChangeGlobal
  end
  object lFlag_TFin: TRadioGroup
    Left = 248
    Top = 112
    Width = 393
    Height = 105
    Anchors = [akLeft, akRight]
    Caption = 'Tipo de Finalizadora'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Dinheiro'
      'Cheque'
      'Cheque Pr'#233'-Datado'
      'Cart'#227'o de Cr'#233'dito'
      'Cart'#227'o de D'#233'bito'
      'Dep'#243'sito Banc'#225'rio / DOC '
      'Boleto Banc'#225'rio'
      'Cobran'#231'a em Carteira'
      'Opera'#231#245'es Financeiras'
      'Tickets')
    ParentFont = False
    TabOrder = 8
    OnClick = lFlag_TFinClick
  end
  object gbParamsFin: TGroupBox
    Left = 248
    Top = 216
    Width = 393
    Height = 105
    Anchors = [akLeft, akRight]
    Caption = 'Parametros da Finalizadora'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    DesignSize = (
      393
      105)
    object lFlag_Cli: TCheckBox
      Left = 8
      Top = 48
      Width = 377
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Finalizadora exige c'#243'digo do Credor/Devedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ChangeGlobal
    end
    object lFlag_Bnc: TCheckBox
      Left = 8
      Top = 64
      Width = 377
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Finalizadora exige Banco ou Conta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ChangeGlobal
    end
    object lFlag_Trc: TCheckBox
      Left = 8
      Top = 16
      Width = 377
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Finalizadora permite devolu'#231#227'o de troco'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = ChangeGlobal
    end
    object lFlag_Tef: TCheckBox
      Left = 8
      Top = 32
      Width = 377
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Finalizadora deve realizar TEF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ChangeGlobal
    end
    object lFlag_GSld_Fin: TCheckBox
      Left = 8
      Top = 80
      Width = 377
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Finalizadora gera saldo no Financeiro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = ChangeGlobal
    end
  end
  object gbParamsOp: TGroupBox
    Left = 248
    Top = 328
    Width = 393
    Height = 89
    Anchors = [akLeft, akRight]
    Caption = 'Par'#226'metros da Opera'#231#227'o Financeira'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    DesignSize = (
      393
      89)
    object lFlag_GSld_Cta: TCheckBox
      Left = 8
      Top = 16
      Width = 377
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Opera'#231#227'o gera saldos na Conta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ChangeGlobal
    end
    object lFlag_Est: TCheckBox
      Left = 8
      Top = 64
      Width = 377
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Opera'#231#227'o de estorno de lan'#231'amento anterior'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ChangeGlobal
    end
    object lFlag_Trf: TCheckBox
      Left = 8
      Top = 32
      Width = 377
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Opera'#231#227'o de transfer'#234'ncia de saldos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = lFlag_TrfClick
    end
    object lFlag_Baixa: TCheckBox
      Left = 8
      Top = 48
      Width = 377
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Opera'#231#227'o permite a baixa de documentos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ChangeGlobal
    end
  end
  object lFk_Finalizadoras__DB: TStaticText
    Left = 248
    Top = 424
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Op. de D'#233'bito: '
    FocusControl = eFk_Finalizadoras__DB
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object eFk_Finalizadoras__DB: TPrcComboBox
    Left = 376
    Top = 424
    Width = 265
    Height = 21
    Anchors = [akRight]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    OnSelect = ChangeGlobal
    TabOrder = 12
    TypeObject = toInteger
  end
  object eFk_Finalizadoras__CR: TPrcComboBox
    Left = 376
    Top = 448
    Width = 265
    Height = 21
    Anchors = [akRight]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    OnSelect = ChangeGlobal
    TabOrder = 13
    TypeObject = toInteger
  end
  object lFk_Finalizadoras__CR: TStaticText
    Left = 248
    Top = 448
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Op. de D'#233'bito: '
    FocusControl = eFk_Finalizadoras__CR
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object ePk_Finalizadoras: TCurrencyEdit
    Left = 376
    Top = 40
    Width = 105
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    TabOrder = 15
  end
end
