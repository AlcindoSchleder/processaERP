inherited CdParametros: TCdParametros
  Left = 336
  Caption = 'CdParametros'
  ClientHeight = 321
  ClientWidth = 514
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object eFk_Cenarios_Financeiros: TPrcComboBox
    Left = 152
    Top = 16
    Width = 353
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    OnSelect = ChangeGlobal
    TabOrder = 0
    TypeObject = toInteger
  end
  object lFk_Cenarios_Financeiros: TStaticText
    Left = 8
    Top = 16
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tipo Conta Previs'#227'o: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object lFlag_Com_Tpgto: TCheckBox
    Left = 152
    Top = 128
    Width = 353
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Comiss'#227'o sobre faixas de prazos m'#233'dios'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ChangeGlobal
  end
  object lFlag_Com_Desc: TCheckBox
    Left = 152
    Top = 152
    Width = 353
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Comiss'#227'o sobre a faixa da m'#233'dia de descontos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = ChangeGlobal
  end
  object lFlag_Desc_Item: TCheckBox
    Left = 152
    Top = 176
    Width = 353
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Perimitir desconto nos '#237'tem nas vendas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = ChangeGlobal
  end
  object eTax_JurM: TCurrencyEdit
    Left = 152
    Top = 56
    Width = 73
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.0000 %;-,0.0000 %'
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lTax_JurM: TStaticText
    Left = 8
    Top = 56
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Juros Mensal: '
    FocusControl = eTax_JurM
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lMrgl_Pdr: TStaticText
    Left = 8
    Top = 96
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Margem Padr'#227'o: '
    FocusControl = eMrgl_Pdr
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eMrgl_Pdr: TCurrencyEdit
    Left = 152
    Top = 96
    Width = 73
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.0000 %;-,0.0000 %'
    TabOrder = 8
    OnChange = ChangeGlobal
  end
  object eCust_Fix: TCurrencyEdit
    Left = 432
    Top = 56
    Width = 73
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.0000 %;-,0.0000 %'
    Anchors = [akTop, akRight]
    TabOrder = 9
    OnChange = ChangeGlobal
  end
  object lCust_Fix: TStaticText
    Left = 288
    Top = 56
    Width = 137
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '% Cuto Fixo: '
    FocusControl = eCust_Fix
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object lDsct_Max: TStaticText
    Left = 288
    Top = 96
    Width = 137
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Desconto M'#225'ximo: '
    FocusControl = eDsct_Max
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object eDsct_Max: TCurrencyEdit
    Left = 432
    Top = 96
    Width = 73
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.0000 %;-,0.0000 %'
    Anchors = [akTop, akRight]
    TabOrder = 12
    OnChange = ChangeGlobal
  end
  object lFlag_Com_Item: TRadioGroup
    Left = 8
    Top = 224
    Width = 497
    Height = 85
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Forma de incid'#234'ncia das comiss'#245'es'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Nenhum'
      #205'tem '
      'Grupo de '#237'tens'
      'Linhas')
    ParentFont = False
    TabOrder = 13
    OnClick = lFlag_Com_ItemClick
  end
  object lFlagAcmFin: TCheckBox
    Left = 152
    Top = 200
    Width = 353
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Transferir o financeiro das Filiais para a Matriz'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    OnClick = ChangeGlobal
  end
end
