inherited CdVehicle: TCdVehicle
  Left = 469
  Top = 218
  Caption = 'CdVehicle'
  ClientHeight = 364
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 8
    Top = 8
    Width = 441
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 15
    Width = 425
    Height = 20
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Tabela de Ve'#237'culos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lPk_Veiculos: TStaticText
    Left = 8
    Top = 56
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Veiculos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Veiculos: TEdit
    Left = 152
    Top = 56
    Width = 89
    Height = 21
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
  object lDsc_Vei: TStaticText
    Left = 8
    Top = 80
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Vei
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eDsc_Vei: TEdit
    Left = 152
    Top = 80
    Width = 297
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    MaxLength = 50
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object pgTypeVei: TPageControl
    Left = 8
    Top = 160
    Width = 441
    Height = 193
    ActivePage = tsSpecialData
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
    object tsSpecialData: TTabSheet
      Caption = 'Oberva'#231#245'es e Imagens'
      DesignSize = (
        433
        165)
      object eObs_Vei: TMemo
        Left = 0
        Top = 0
        Width = 209
        Height = 161
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        OnChange = ChangeGlobal
      end
      object vtImages: TVirtualDrawTree
        Left = 216
        Top = 0
        Width = 217
        Height = 161
        Header.AutoSizeIndex = 0
        Header.Background = clSkyBlue
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clBlue
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = [fsBold]
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsXPStyle
        TabOrder = 1
        OnDrawHint = vtImagesDrawHint
        OnDrawNode = vtImagesDrawNode
        OnGetHintSize = vtImagesGetHintSize
        OnGetImageIndex = vtImagesGetImageIndex
        OnGetNodeDataSize = vtImagesGetNodeDataSize
        Columns = <
          item
            Alignment = taCenter
            Position = 0
            Width = 213
            WideText = 'Imagens'
          end>
      end
    end
    object tsOwnerVehicle: TTabSheet
      Caption = 'Dados de Ve'#237'culos Pr'#243'prios'
      ImageIndex = 1
      DesignSize = (
        433
        165)
      object lFk_Produtos_Grupos: TStaticText
        Left = 8
        Top = 0
        Width = 81
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Grupos:'
        FocusControl = eFk_Produtos_Grupos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eFk_Produtos_Grupos: TComboBox
        Left = 96
        Top = 0
        Width = 209
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 1
        OnDrawItem = eFk_Produtos_GruposDrawItem
        OnSelect = ChangeGlobal
      end
      object lFlag_Atv: TCheckBox
        Left = 312
        Top = 24
        Width = 111
        Height = 17
        Alignment = taLeftJustify
        Anchors = [akLeft, akRight]
        Caption = 'Ve'#237'culo Ativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = ChangeGlobal
      end
      object vtProdType: TVirtualStringTree
        Left = 8
        Top = 48
        Width = 417
        Height = 105
        Anchors = [akLeft, akTop, akRight, akBottom]
        CheckImageKind = ckXP
        Ctl3D = True
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoDrag, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        ParentCtl3D = False
        TabOrder = 3
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnFocusChanged = vtProdTypeFocusChanged
        OnGetText = vtProdTypeGetText
        OnGetNodeDataSize = vtProdTypeGetNodeDataSize
        OnInitNode = vtProdTypeInitNode
        Columns = <
          item
            ImageIndex = 83
            Position = 0
            Width = 160
            WideText = 'Tipos'
          end>
      end
      object eFk_Unidades: TComboBox
        Left = 96
        Top = 24
        Width = 209
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        TabOrder = 4
        OnSelect = ChangeGlobal
      end
      object lFk_Unidades: TStaticText
        Left = 8
        Top = 24
        Width = 81
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Unidade:'
        FocusControl = eFk_Unidades
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object ePk_Produtos: TEdit
        Left = 312
        Top = 0
        Width = 113
        Height = 21
        Color = clTeal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        Text = '0'
      end
    end
    object tsOtherOwner: TTabSheet
      Caption = 'Dados de Ve'#237'culos Tercerizados'
      ImageIndex = 2
      DesignSize = (
        433
        165)
      object lFk_Fornecedores: TStaticText
        Left = 0
        Top = 32
        Width = 137
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Propriet'#225'rio: '
        FocusControl = eFk_Fornecedores
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eFk_Fornecedores: TComboBox
        Left = 144
        Top = 32
        Width = 281
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 0
        TabOrder = 1
        OnSelect = ChangeGlobal
      end
      object lNom_Mot: TStaticText
        Left = 0
        Top = 88
        Width = 137
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Nome do Motorista: '
        FocusControl = eNom_Mot
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object eNom_Mot: TEdit
        Left = 144
        Top = 88
        Width = 281
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 3
        OnChange = ChangeGlobal
      end
    end
  end
  object lFk_Centro_Custos: TStaticText
    Left = 8
    Top = 104
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Centro de Custos: '
    FocusControl = eFk_Centro_Custos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eFk_Centro_Custos: TComboBox
    Left = 152
    Top = 104
    Width = 297
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 6
    OnSelect = ChangeGlobal
  end
  object lAno_Vcl: TStaticText
    Left = 8
    Top = 128
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Ano de Fabrica'#231#227'o: '
    FocusControl = eAno_Vcl
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eAno_Vcl: TCurrencyEdit
    Left = 152
    Top = 128
    Width = 89
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    MaxValue = 2020.000000000000000000
    MinValue = 1970.000000000000000000
    TabOrder = 8
    Value = 1970.000000000000000000
    OnChange = ChangeGlobal
  end
  object lPlaca_Vcl: TStaticText
    Left = 248
    Top = 128
    Width = 105
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Placa: '
    FocusControl = ePlaca_Vcl
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eCpcd_Vcl: TCurrencyEdit
    Left = 360
    Top = 56
    Width = 89
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 10
    OnChange = ChangeGlobal
  end
  object lCpcd_Vcl: TStaticText
    Left = 248
    Top = 56
    Width = 105
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Cap. Carga: '
    FocusControl = eCpcd_Vcl
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object ePlaca_Vcl: TEdit
    Left = 360
    Top = 128
    Width = 87
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 12
    OnChange = ChangeGlobal
  end
  object pmImages: TPopupMenu
    Left = 300
    Top = 240
    object pmInsert: TMenuItem
      Caption = 'Nova Imagem'
      ImageIndex = 34
    end
    object pmDelete: TMenuItem
      Caption = 'Excluir Imagem'
      ImageIndex = 33
    end
  end
  object opImage: TOpenPictureDialog
    DefaultExt = '*.jpg'
    Filter = 
      'All (*.gif;*.gif;*.pcx;*.ani;*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wm' +
      'f)|*.jpg;*.jpeg;*.bmp;*.emf;*.wmf|JPEG Image File (*.jpg)|*.jpg|' +
      'JPEG Image File (*.jpeg)|*.jpeg|Bitmaps (*.bmp)|*.bmp|Enhanced M' +
      'etafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf'
    InitialDir = '.'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofNoNetworkButton, ofEnableSizing]
    Left = 57
    Top = 106
  end
end
