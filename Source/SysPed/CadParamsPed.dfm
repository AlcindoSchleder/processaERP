inherited CdParamsPed: TCdParamsPed
  Left = 305
  Top = 146
  Height = 361
  Caption = 'CdParamsPed'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 281
  end
  inherited sbStatus: TStatusBar
    Top = 314
  end
  inherited vtList: TVirtualStringTree
    Height = 281
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 281
    TabOrder = 18
  end
  object eFk_Tipo_Status_Pedidos: TComboBox
    Left = 384
    Top = 144
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 3
    OnSelect = ChangeGlobal
  end
  object eFk_Tipo_Prazo_Entrega: TComboBox
    Left = 384
    Top = 168
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 4
    OnSelect = ChangeGlobal
  end
  object gbTitle: TGroupBox
    Left = 248
    Top = 32
    Width = 401
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
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
  object lFk_Tipo_Status_Pedidos: TStaticText
    Left = 256
    Top = 144
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Status Default: '
    FocusControl = eFk_Tipo_Status_Pedidos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lFk_Tipo_Prazo_Entrega: TStaticText
    Left = 256
    Top = 168
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tipo Prz de Entr.: '
    FocusControl = eFk_Tipo_Prazo_Entrega
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object lPrz_Val_Orc: TStaticText
    Left = 256
    Top = 192
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Valid. dos Or'#231'am.: '
    FocusControl = ePrz_Val_Orc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object lPrz_Entr: TStaticText
    Left = 256
    Top = 216
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Prazo de Entrega: '
    FocusControl = ePrz_Entr
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object ePrz_Val_Orc: TCurrencyEdit
    Left = 384
    Top = 192
    Width = 121
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akRight]
    TabOrder = 10
    OnChange = ChangeGlobal
  end
  object ePrz_Entr: TCurrencyEdit
    Left = 384
    Top = 216
    Width = 121
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akRight]
    TabOrder = 11
    OnChange = ChangeGlobal
  end
  object lFlag_Itm_Dsct: TCheckBox
    Left = 256
    Top = 248
    Width = 385
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Desconto no '#237'tem '#233' acumulado no final do pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnClick = ChangeGlobal
  end
  object lFk_Grupos_Movimentos: TStaticText
    Left = 256
    Top = 120
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Moviment. Default: '
    FocusControl = eFk_Grupos_Movimentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object eFk_Grupos_Movimentos: TComboBox
    Left = 384
    Top = 120
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 14
    OnSelect = ChangeGlobal
  end
  object lFlag_TPed: TStaticText
    Left = 256
    Top = 280
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tipo Pedido: '
    FocusControl = eFlag_TPed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
  end
  object eFlag_TPed: TComboBox
    Left = 384
    Top = 280
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 16
    OnSelect = ChangeGlobal
  end
  object lPk_Parametros_Ped: TRadioGroup
    Left = 256
    Top = 80
    Width = 393
    Height = 33
    Caption = 'Tipo do Par'#226'metro'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Entradas'
      'Sa'#237'das')
    TabOrder = 17
  end
end
