inherited CdManifest: TCdManifest
  Left = 383
  Top = 191
  Caption = 'CdManifest'
  ClientHeight = 413
  ClientWidth = 784
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object gbVehicle: TGroupBox
    Left = 8
    Top = 104
    Width = 369
    Height = 97
    Anchors = [akLeft]
    Caption = 'Sele'#231#227'o do Ve'#237'culo'
    TabOrder = 0
    DesignSize = (
      369
      97)
    object lFk_Veiculos_Marcas: TStaticText
      Left = 8
      Top = 16
      Width = 105
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Marca: '
      FocusControl = eFk_Veiculos_Marcas
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object eFk_Veiculos_Marcas: TComboBox
      Left = 120
      Top = 16
      Width = 241
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      TabOrder = 1
      OnSelect = eFk_Veiculos_MarcasSelect
    end
    object lFk_Veiculos_Modelos: TStaticText
      Left = 8
      Top = 40
      Width = 105
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Modelo: '
      FocusControl = eFk_Veiculos_Modelos
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object eFk_Veiculos_Modelos: TComboBox
      Left = 120
      Top = 40
      Width = 241
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      TabOrder = 3
      OnSelect = eFk_Veiculos_ModelosSelect
    end
    object lFk_Veiculos: TStaticText
      Left = 8
      Top = 64
      Width = 105
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Ve'#237'culo: '
      FocusControl = eFk_Veiculos
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object eFk_Veiculos: TComboBox
      Left = 120
      Top = 64
      Width = 241
      Height = 21
      Style = csOwnerDrawFixed
      Anchors = [akLeft, akRight]
      ItemHeight = 15
      TabOrder = 5
      OnDrawItem = eFk_VeiculosDrawItem
      OnSelect = eFk_VeiculosSelect
    end
  end
  object gbManifest: TGroupBox
    Left = 8
    Top = 8
    Width = 369
    Height = 97
    Anchors = [akLeft]
    Caption = 'Dados do Manifesto'
    TabOrder = 1
    DesignSize = (
      369
      97)
    object eFk_Parceiros: TComboBox
      Left = 120
      Top = 64
      Width = 241
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      TabOrder = 6
      Visible = False
      OnSelect = ChangeGlobal
    end
    object lFk_Parceiros: TStaticText
      Left = 8
      Top = 64
      Width = 105
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Parceiro: '
      FocusControl = eFk_Parceiros
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
    object ePk_Manifestos: TEdit
      Left = 312
      Top = 16
      Width = 49
      Height = 21
      Anchors = [akLeft, akRight]
      Color = 8421440
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object lPk_Manifestos: TStaticText
      Left = 264
      Top = 16
      Width = 41
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'N'#250'm: '
      Enabled = False
      FocusControl = ePk_Manifestos
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object lDta_Sai: TStaticText
      Left = 8
      Top = 16
      Width = 89
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Data Sa'#237'da: '
      Enabled = False
      FocusControl = eDta_Sai
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object lFk_Tipo_Manifestos: TStaticText
      Left = 8
      Top = 40
      Width = 105
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Tipo de Manif.: '
      FocusControl = eFk_Tipo_Manifestos
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object eFk_Tipo_Manifestos: TComboBox
      Left = 120
      Top = 40
      Width = 241
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      TabOrder = 4
      OnSelect = eFk_Tipo_ManifestosSelect
    end
    object eDta_Sai: TDateEdit
      Left = 120
      Top = 16
      Width = 73
      Height = 21
      NumGlyphs = 2
      TabOrder = 7
      OnChange = ChangeGlobal
    end
    object eHor_Sai: TDateTimePicker
      Left = 184
      Top = 16
      Width = 73
      Height = 21
      Date = 39238.427425300930000000
      Time = 39238.427425300930000000
      Kind = dtkTime
      TabOrder = 8
      OnChange = ChangeGlobal
    end
  end
  object gbEmployee: TGroupBox
    Left = 8
    Top = 200
    Width = 369
    Height = 97
    Anchors = [akLeft]
    Caption = 'Sele'#231#227'o dos Funcion'#225'rios'
    TabOrder = 2
    DesignSize = (
      369
      97)
    object lFk_Motorista: TStaticText
      Left = 8
      Top = 16
      Width = 105
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Motorista: '
      FocusControl = eFk_Motorista
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object eFk_Motorista: TComboBox
      Left = 120
      Top = 16
      Width = 241
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      TabOrder = 1
    end
    object lFk_Carregadores: TStaticText
      Left = 8
      Top = 40
      Width = 105
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Carga: '
      FocusControl = eFk_Carregadores
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object eFk_Carregadores: TComboBox
      Left = 120
      Top = 40
      Width = 241
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      TabOrder = 3
    end
    object lFk_Conferente: TStaticText
      Left = 8
      Top = 64
      Width = 105
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Conferente: '
      FocusControl = eFk_Conferente
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object eFk_Conferente: TComboBox
      Left = 120
      Top = 64
      Width = 241
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      TabOrder = 5
    end
  end
  object gbManifestDetail: TGroupBox
    Left = 8
    Top = 296
    Width = 369
    Height = 113
    Anchors = [akLeft]
    Caption = 'Detalhes do Manifesto'
    TabOrder = 3
    DesignSize = (
      369
      113)
    object lFlag_Tot: TCheckBox
      Left = 8
      Top = 16
      Width = 145
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Totalizar o Manifesto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object lTot_Cnh: TStaticText
      Left = 160
      Top = 88
      Width = 89
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Total: '
      Enabled = False
      FocusControl = eTot_Cnh
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object eTot_Cnh: TCurrencyEdit
      Left = 256
      Top = 88
      Width = 105
      Height = 21
      AutoSize = False
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Anchors = [akRight]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object lTot_Pdg: TStaticText
      Left = 160
      Top = 16
      Width = 89
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Ped'#225'gio: '
      Enabled = False
      FocusControl = eTot_Pdg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object eTot_Pdg: TCurrencyEdit
      Left = 256
      Top = 16
      Width = 105
      Height = 21
      AutoSize = False
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Anchors = [akRight]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object lTot_Mrc: TStaticText
      Left = 160
      Top = 40
      Width = 89
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Total Nf'#180's: '
      Enabled = False
      FocusControl = eTot_Mrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object eTot_Mrc: TCurrencyEdit
      Left = 256
      Top = 40
      Width = 105
      Height = 21
      AutoSize = False
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Anchors = [akRight]
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
    object lVlr_Frt_Vst: TStaticText
      Left = 160
      Top = 64
      Width = 89
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Total a Vista: '
      Enabled = False
      FocusControl = eVlr_Frt_Vst
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object eVlr_Frt_Vst: TCurrencyEdit
      Left = 256
      Top = 64
      Width = 105
      Height = 21
      AutoSize = False
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Anchors = [akRight]
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object lVlr_Remb: TStaticText
      Left = 8
      Top = 40
      Width = 145
      Height = 21
      Alignment = taCenter
      Anchors = [akLeft, akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Total Reembolso: '
      Enabled = False
      FocusControl = eTot_Remb
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object eTot_Remb: TCurrencyEdit
      Left = 8
      Top = 64
      Width = 145
      Height = 21
      AutoSize = False
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Anchors = [akLeft, akRight]
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
    end
    object bbGenerateDocuments: TBitBtn
      Left = 8
      Top = 88
      Width = 145
      Height = 21
      Anchors = [akLeft, akRight]
      Caption = 'Gerar Recibos'
      TabOrder = 11
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
        8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
        93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
        9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
        678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
        8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
        E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
        8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
        EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
        C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
        C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
        D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
        9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
        B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
        BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
        C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
        C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
        AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
  end
  object gbFilterDocuments: TGroupBox
    Left = 384
    Top = 8
    Width = 393
    Height = 401
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Sele'#231#227'o dos Conhecimentos'
    TabOrder = 4
    object pFilter: TPanel
      Left = 2
      Top = 15
      Width = 389
      Height = 66
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        389
        66)
      object lNumDoc: TStaticText
        Left = 8
        Top = 8
        Width = 89
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'm. Docum.: '
        FocusControl = eNumDoc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eNumDoc: TCurrencyEdit
        Left = 104
        Top = 8
        Width = 65
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0; ,0'
        Anchors = [akLeft]
        TabOrder = 1
      end
      object lNumNF: TStaticText
        Left = 8
        Top = 32
        Width = 89
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'm. da NF: '
        FocusControl = eNumNF
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object eNumNF: TCurrencyEdit
        Left = 104
        Top = 32
        Width = 65
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0; ,0'
        Anchors = [akLeft]
        TabOrder = 3
      end
      object eDtaIni: TDateEdit
        Left = 264
        Top = 8
        Width = 89
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        TabOrder = 4
      end
      object lDtaIni: TStaticText
        Left = 176
        Top = 8
        Width = 81
        Height = 20
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Inicial: '
        FocusControl = eDtaIni
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object lDtaFin: TStaticText
        Left = 176
        Top = 32
        Width = 81
        Height = 20
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Final: '
        FocusControl = eDtaFin
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object eDtaFin: TDateEdit
        Left = 264
        Top = 32
        Width = 89
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        TabOrder = 7
      end
      object bbSearch: TBitBtn
        Left = 358
        Top = 7
        Width = 27
        Height = 45
        Anchors = [akTop, akRight, akBottom]
        TabOrder = 8
        OnClick = bbSearchClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
          CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
          1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
          D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
          7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
          E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
          EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
          8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        Layout = blGlyphTop
      end
    end
    object vtDocuments: TVirtualStringTree
      Left = 2
      Top = 81
      Width = 389
      Height = 318
      Align = alClient
      CheckImageKind = ckXP
      Colors.FocusedSelectionColor = 6730751
      Colors.FocusedSelectionBorderColor = clBtnShadow
      Colors.GridLineColor = clSilver
      Colors.SelectionRectangleBlendColor = 6730751
      Colors.UnfocusedSelectionColor = 6730751
      Ctl3D = True
      EditDelay = 0
      Header.AutoSizeIndex = -1
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clBlue
      Header.Font.Height = -11
      Header.Font.Name = 'MS Sans Serif'
      Header.Font.Style = [fsBold]
      Header.Options = [hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
      Header.Style = hsXPStyle
      HintAnimation = hatNone
      HotCursor = crHandPoint
      ParentCtl3D = False
      SelectionCurveRadius = 20
      TabOrder = 1
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
      TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
      OnBeforeItemErase = vtDocumentsBeforeItemErase
      OnGetText = vtDocumentsGetText
      OnPaintText = vtDocumentsPaintText
      OnGetNodeDataSize = vtDocumentsGetNodeDataSize
      OnInitNode = vtDocumentsInitNode
      Columns = <
        item
          Position = 0
          Width = 100
          WideText = 'N'#250'm. Doc.'
        end
        item
          Position = 1
          Width = 100
          WideText = 'Data Doc.'
        end
        item
          ImageIndex = 9
          Position = 2
          Width = 150
          WideText = 'Origem'
        end
        item
          Position = 3
          Width = 150
          WideText = 'Destino'
        end
        item
          Position = 4
          Width = 150
          WideText = 'Valor'
        end>
      WideDefaultText = '...'
    end
  end
  object pmGrid: TPopupMenu
    Left = 560
    Top = 232
    object pmDeleteDoc: TMenuItem
      Caption = '&Excluir Documentos'
      OnClick = pmDeleteDocClick
    end
    object pmClearrAllDocs: TMenuItem
      Caption = 'Exluir &Todos Documentos'
      OnClick = pmClearrAllDocsClick
    end
  end
end
