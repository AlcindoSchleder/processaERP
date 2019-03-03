inherited CdTipoStatus: TCdTipoStatus
  Left = 479
  Caption = 'CdTipoStatus'
  ClientHeight = 358
  ClientWidth = 448
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object gbParams: TGroupBox
    Left = 8
    Top = 120
    Width = 434
    Height = 89
    Anchors = [akLeft, akRight]
    Caption = 'Fun'#231#245'es do Status'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      434
      89)
    object lFlagOpen: TCheckBox
      Left = 8
      Top = 21
      Width = 201
      Height = 17
      Anchors = [akLeft]
      Caption = 'Status de Abertura'
      TabOrder = 0
      OnClick = ChangeGlobal
    end
    object lFlagRecb: TCheckBox
      Left = 8
      Top = 43
      Width = 201
      Height = 17
      Anchors = [akLeft]
      Caption = 'Status de Recebimento'
      TabOrder = 1
      OnClick = ChangeGlobal
    end
    object lFlagLib: TCheckBox
      Left = 8
      Top = 65
      Width = 201
      Height = 17
      Anchors = [akLeft]
      Caption = 'Status de Libera'#231#227'o'
      TabOrder = 2
      OnClick = ChangeGlobal
    end
    object lFlagCanc: TCheckBox
      Left = 216
      Top = 21
      Width = 209
      Height = 17
      Anchors = [akRight]
      Caption = 'Status de Cancelamento'
      TabOrder = 3
      OnClick = ChangeGlobal
    end
    object lFlagProd: TCheckBox
      Left = 216
      Top = 36
      Width = 209
      Height = 17
      Anchors = [akRight]
      Caption = 'Status em Produ'#231#227'o'
      TabOrder = 4
      OnClick = ChangeGlobal
    end
    object lFlagFat: TCheckBox
      Left = 216
      Top = 51
      Width = 209
      Height = 17
      Anchors = [akRight]
      Caption = 'Status de Faturamento Parcial'
      TabOrder = 5
      OnClick = ChangeGlobal
    end
    object lFlagLiq: TCheckBox
      Left = 216
      Top = 65
      Width = 209
      Height = 17
      Anchors = [akRight]
      Caption = 'Status de Liquida'#231#227'o'
      TabOrder = 6
      OnClick = ChangeGlobal
    end
  end
  object eFk_Tipo_Movim_Estq: TComboBox
    Left = 136
    Top = 224
    Width = 306
    Height = 21
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 1
    OnSelect = ChangeGlobal
  end
  object lFk_Tipo_Movim_Estq: TStaticText
    Left = 8
    Top = 224
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Mov.dos Estoques: '
    FocusControl = eFk_Tipo_Movim_Estq
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eDsc_Stt: TEdit
    Left = 136
    Top = 80
    Width = 306
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lDsc_Stt: TStaticText
    Left = 8
    Top = 80
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Stt
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object lPk_Tipo_Status_Pedidos: TStaticText
    Left = 8
    Top = 48
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Status_Pedidos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object ePk_Tipo_Status_Pedidos: TCurrencyEdit
    Left = 136
    Top = 48
    Width = 89
    Height = 21
    AutoSize = False
    Color = clTeal
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Anchors = [akLeft]
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
  end
  object lQtd_Days_Next: TStaticText
    Left = 232
    Top = 48
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Prazo de Alerta: '
    FocusControl = eQtd_Days_Next
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eQtd_Days_Next: TCurrencyEdit
    Left = 360
    Top = 48
    Width = 82
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akRight]
    TabOrder = 8
    OnChange = ChangeGlobal
  end
  object pTitle: TPanel
    Left = 8
    Top = 8
    Width = 433
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
    TabOrder = 9
  end
  object lFk_Tipo_Documentos: TStaticText
    Left = 8
    Top = 304
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tipo Documento: '
    FocusControl = eFk_Tipo_Documentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object eFk_Tipo_Documentos: TComboBox
    Left = 136
    Top = 304
    Width = 306
    Height = 21
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 11
    OnSelect = ChangeGlobal
  end
  object lFk_Financeiro_Cenarios: TStaticText
    Left = 8
    Top = 264
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Cen'#225'rio Financeiro: '
    FocusControl = eFk_Financeiro_Cenarios
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object eFk_Financeiro_Cenarios: TComboBox
    Left = 136
    Top = 264
    Width = 306
    Height = 21
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 13
    OnSelect = ChangeGlobal
  end
end
