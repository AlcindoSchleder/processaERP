inherited CdTipoFretes: TCdTipoFretes
  Left = 288
  Top = 245
  Height = 340
  Caption = 'CdTipoFretes'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 260
  end
  inherited sbStatus: TStatusBar
    Top = 293
  end
  inherited vtList: TVirtualStringTree
    Height = 260
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 260
    TabOrder = 15
  end
  object lPk_Tipo_Fretes: TStaticText
    Left = 248
    Top = 40
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Fretes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object eFk_Tipo_Pagamentos: TComboBox
    Left = 376
    Top = 72
    Width = 273
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    OnSelect = ChangeGlobal
  end
  object lFk_Tipo_Pagamentos: TStaticText
    Left = 248
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Cond. Pgtos: '
    FocusControl = eFk_Tipo_Pagamentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object lFk_Classificacao: TStaticText
    Left = 248
    Top = 104
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Classifica'#231#227'o: '
    FocusControl = eFk_Classificacao
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eFk_Classificacao: TComboBox
    Left = 376
    Top = 104
    Width = 273
    Height = 21
    Style = csOwnerDrawFixed
    ItemHeight = 15
    TabOrder = 7
    OnDrawItem = eFk_ClassificacaoDrawItem
    OnSelect = ChangeGlobal
  end
  object eDsc_TpFre: TEdit
    Left = 376
    Top = 136
    Width = 273
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 8
    OnChange = ChangeGlobal
  end
  object lDsc_TpFre: TStaticText
    Left = 248
    Top = 136
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TpFre
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object lFlag_Tp_Fre: TRadioGroup
    Left = 248
    Top = 160
    Width = 401
    Height = 65
    Caption = 'Tipo de Frete: '
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Frete pago'
      'Frete a pagar'
      'Outros')
    ParentFont = False
    TabOrder = 10
    OnClick = ChangeGlobal
  end
  object lFlag_Acu: TCheckBox
    Left = 248
    Top = 248
    Width = 401
    Height = 17
    Caption = 'Acumular frete para pagamento posterior (previs'#227'o)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = ChangeGlobal
  end
  object lFlag_Fin: TCheckBox
    Left = 248
    Top = 232
    Width = 401
    Height = 17
    Caption = 'Gerar Financeiro para pagamento do frete'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnClick = ChangeGlobal
  end
  object lFlag_NF: TCheckBox
    Left = 248
    Top = 264
    Width = 401
    Height = 17
    Caption = 'Destacar o frete no corpo da Nota Fiscal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnClick = ChangeGlobal
  end
  object ePk_Tipo_Fretes: TCurrencyEdit
    Left = 376
    Top = 40
    Width = 81
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
    ParentFont = False
    TabOrder = 14
  end
end
