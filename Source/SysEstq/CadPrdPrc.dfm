inherited fmProductSale: TfmProductSale
  Left = 272
  Top = 212
  Caption = 'fmProductSale'
  ClientHeight = 270
  ClientWidth = 591
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lFk_Linhas: TStaticText
    Left = 8
    Top = 8
    Width = 113
    Height = 21
    Anchors = [akLeft, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Linha:'
    FocusControl = eFk_Linhas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object eFk_Linhas: TComboBox
    Left = 128
    Top = 8
    Width = 457
    Height = 21
    Style = csDropDownList
    Anchors = [akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
    OnSelect = ChangeGlobal
  end
  object lFk_Similar: TStaticText
    Left = 8
    Top = 32
    Width = 113
    Height = 21
    Anchors = [akLeft, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Similar:'
    FocusControl = eFk_Similar
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eFk_Similar: TComboBox
    Left = 128
    Top = 32
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 3
    OnSelect = ChangeGlobal
  end
  object lFat_Conv_Cub: TStaticText
    Left = 408
    Top = 32
    Width = 89
    Height = 21
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Fator Conv.:'
    FocusControl = eFat_Conv_Cub
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eFat_Conv_Cub: TCurrencyEdit
    Left = 504
    Top = 32
    Width = 81
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.00;- ,0.00'
    Anchors = [akRight]
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lFlag_Imp: TCheckBox
    Left = 408
    Top = 56
    Width = 177
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akRight]
    Caption = 'Imprime na Lista de Pre'#231'os'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = ChangeGlobal
  end
  object eDsc_Red: TEdit
    Left = 128
    Top = 56
    Width = 265
    Height = 21
    Anchors = [akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 7
    OnChange = ChangeGlobal
  end
  object lDsc_Prod: TStaticText
    Left = 8
    Top = 56
    Width = 113
    Height = 21
    Anchors = [akLeft, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Descr. Resuzida:'
    FocusControl = eDsc_Red
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object lPes_Liq: TStaticText
    Left = 8
    Top = 80
    Width = 113
    Height = 21
    Anchors = [akLeft, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Peso L'#237'quido:'
    FocusControl = ePes_Liq
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object ePes_Liq: TCurrencyEdit
    Left = 128
    Top = 80
    Width = 81
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.0000;- ,0.0000'
    Anchors = [akRight]
    TabOrder = 10
    OnChange = ChangeGlobal
  end
  object lPes_Bru: TStaticText
    Left = 216
    Top = 80
    Width = 89
    Height = 21
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Peso Bruto:'
    FocusControl = ePes_Bru
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object ePes_Bru: TCurrencyEdit
    Left = 312
    Top = 80
    Width = 81
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.0000;- ,0.0000'
    Anchors = [akRight]
    TabOrder = 12
    OnChange = ChangeGlobal
  end
  object lVlr_Cub: TStaticText
    Left = 408
    Top = 80
    Width = 89
    Height = 21
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Cubagem:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object eVlr_Cub: TCurrencyEdit
    Left = 504
    Top = 80
    Width = 81
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00 m3;- ,0.00 m3'
    Anchors = [akRight]
    TabOrder = 14
    OnChange = ChangeGlobal
  end
  object gbBrutMetric: TGroupBox
    Left = 8
    Top = 104
    Width = 577
    Height = 51
    Anchors = [akLeft, akRight]
    Caption = 'Medidas Brutas'
    TabOrder = 15
    DesignSize = (
      577
      51)
    object lAlt_Prod: TStaticText
      Left = 8
      Top = 16
      Width = 89
      Height = 21
      Anchors = [akLeft, akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Altura:'
      FocusControl = eAlt_Prod
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object eAlt_Prod: TCurrencyEdit
      Left = 104
      Top = 16
      Width = 81
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000;- ,0.0000'
      Anchors = [akRight]
      TabOrder = 1
      OnChange = ChangeGlobal
    end
    object lProf_Prod: TStaticText
      Left = 192
      Top = 16
      Width = 97
      Height = 21
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Profundidade:'
      FocusControl = eProf_Prod
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object eProf_Prod: TCurrencyEdit
      Left = 296
      Top = 16
      Width = 81
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000;- ,0.0000'
      Anchors = [akRight]
      TabOrder = 3
      OnChange = ChangeGlobal
    end
    object lLarg_Prod: TStaticText
      Left = 384
      Top = 16
      Width = 97
      Height = 21
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Largura:'
      FocusControl = eLarg_Prod
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object eLarg_Prod: TCurrencyEdit
      Left = 488
      Top = 16
      Width = 81
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000;- ,0.0000'
      Anchors = [akRight]
      TabOrder = 5
      OnChange = ChangeGlobal
    end
  end
  object gbPackMetric: TGroupBox
    Left = 8
    Top = 160
    Width = 577
    Height = 49
    Anchors = [akLeft, akRight]
    Caption = 'Medidas com Embalagem'
    TabOrder = 16
    DesignSize = (
      577
      49)
    object lAlt_EProd: TStaticText
      Left = 8
      Top = 16
      Width = 89
      Height = 21
      Anchors = [akLeft, akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Altura:'
      FocusControl = eAlt_EProd
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object eAlt_EProd: TCurrencyEdit
      Left = 104
      Top = 16
      Width = 81
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000;- ,0.0000'
      Anchors = [akRight]
      TabOrder = 1
      OnChange = ChangeGlobal
    end
    object lProf_EProd: TStaticText
      Left = 192
      Top = 16
      Width = 97
      Height = 21
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Profundidade:'
      FocusControl = eProf_EProd
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object eProf_EProd: TCurrencyEdit
      Left = 296
      Top = 16
      Width = 81
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000;- ,0.0000'
      Anchors = [akRight]
      TabOrder = 3
      OnChange = ChangeGlobal
    end
    object lLarg_EProd: TStaticText
      Left = 384
      Top = 16
      Width = 97
      Height = 21
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Largura:'
      FocusControl = eLarg_EProd
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object eLarg_EProd: TCurrencyEdit
      Left = 488
      Top = 16
      Width = 81
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000;- ,0.0000'
      Anchors = [akRight]
      TabOrder = 5
      OnChange = ChangeGlobal
    end
  end
  object gbInternalMetric: TGroupBox
    Left = 8
    Top = 216
    Width = 577
    Height = 49
    Anchors = [akLeft, akRight]
    Caption = 'Medidas Internas'
    TabOrder = 17
    DesignSize = (
      577
      49)
    object lAlt_IProd: TStaticText
      Left = 8
      Top = 16
      Width = 89
      Height = 21
      Anchors = [akLeft, akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Altura:'
      FocusControl = eAlt_IProd
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object eAlt_IProd: TCurrencyEdit
      Left = 104
      Top = 16
      Width = 81
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000;- ,0.0000'
      Anchors = [akRight]
      TabOrder = 1
      OnChange = ChangeGlobal
    end
    object lProf_IProd: TStaticText
      Left = 192
      Top = 16
      Width = 97
      Height = 21
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Profundidade:'
      FocusControl = eProf_IProd
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object eProf_IProd: TCurrencyEdit
      Left = 296
      Top = 16
      Width = 81
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000;- ,0.0000'
      Anchors = [akRight]
      TabOrder = 3
      OnChange = ChangeGlobal
    end
    object lLarg_IProd: TStaticText
      Left = 384
      Top = 16
      Width = 97
      Height = 21
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Largura:'
      FocusControl = eLarg_IProd
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object eLarg_IProd: TCurrencyEdit
      Left = 488
      Top = 16
      Width = 81
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000;- ,0.0000'
      Anchors = [akRight]
      TabOrder = 5
      OnChange = ChangeGlobal
    end
  end
end
