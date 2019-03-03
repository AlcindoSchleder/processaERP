inherited fmPrdSuppliers: TfmPrdSuppliers
  Left = 286
  Top = 188
  Caption = 'fmPrdSuppliers'
  ClientHeight = 285
  ClientWidth = 591
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgMain: TPageControl
    Left = 0
    Top = 0
    Width = 591
    Height = 285
    ActivePage = tsList
    Align = alClient
    TabOrder = 0
    OnChange = pgMainChange
    OnChanging = pgMainChanging
    object tsList: TTabSheet
      Caption = 'Listagem dos Fornecedores para o Produto'
      object vtList: TVirtualStringTree
        Left = 0
        Top = 33
        Width = 583
        Height = 224
        Align = alClient
        Colors.FocusedSelectionColor = clSilver
        Ctl3D = True
        Header.AutoSizeIndex = 4
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoDrag, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        ParentCtl3D = False
        SelectionCurveRadius = 10
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
        OnDblClick = vtListDblClick
        OnFocusChanged = vtListFocusChanged
        OnGetText = vtListGetText
        OnPaintText = vtListPaintText
        Columns = <
          item
            Position = 0
            Width = 229
            WideText = 'Fornecedor'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 100
            WideText = 'Pre'#231'o'
          end
          item
            Alignment = taCenter
            Position = 2
            WideText = 'UN'
          end
          item
            Alignment = taRightJustify
            Position = 3
            Width = 100
            WideText = 'Frete'
          end
          item
            Alignment = taRightJustify
            Position = 4
            Width = 100
            WideText = 'Dias Entr.'
          end>
      end
      object cbTools: TCoolBar
        Left = 0
        Top = 0
        Width = 583
        Height = 33
        Bands = <
          item
            Control = tbTools
            ImageIndex = -1
            Text = 'Ferramentas'
            Width = 488
          end
          item
            Break = False
            Control = tbCompositions
            ImageIndex = -1
            Text = 'Composi'#231#245'es'
            Width = 89
          end>
        object tbTools: TToolBar
          Left = 71
          Top = 0
          Width = 413
          Height = 25
          ButtonHeight = 19
          ButtonWidth = 43
          Caption = 'tbTools'
          Flat = True
          List = True
          ShowCaptions = True
          TabOrder = 0
          object tbInsert: TToolButton
            Left = 0
            Top = 0
            Caption = 'Inserir'
            ImageIndex = 34
            OnClick = tbInsertClick
          end
          object tbSep: TToolButton
            Left = 43
            Top = 0
            Width = 8
            Caption = 'tbSep'
            ImageIndex = 2
            Style = tbsSeparator
          end
          object tbDelete: TToolButton
            Left = 51
            Top = 0
            Caption = 'Excluir'
            ImageIndex = 33
            OnClick = tbDeleteClick
          end
        end
        object tbCompositions: TToolBar
          Left = 566
          Top = 0
          Width = 9
          Height = 25
          ButtonHeight = 19
          ButtonWidth = 104
          Caption = 'tbCompositions'
          Flat = True
          List = True
          ShowCaptions = True
          TabOrder = 1
          object tbComp: TToolButton
            Left = 0
            Top = 0
            Caption = 'Gerar Composi'#231#245'es'
            ImageIndex = 0
          end
        end
      end
    end
    object tsData: TTabSheet
      Caption = 'Detalhes'
      ImageIndex = 1
      DesignSize = (
        583
        257)
      object lFk_VW_Fornecedores: TStaticText
        Left = 0
        Top = 8
        Width = 129
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Fornecedor:'
        FocusControl = eFk_VW_Fornecedores
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eFk_VW_Fornecedores: TPrcComboBox
        Left = 136
        Top = 8
        Width = 305
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        BevelKind = bkNone
        CharCase = ecUpperCase
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 1
        TypeObject = toObject
      end
      object lFk_Unidades: TStaticText
        Left = 0
        Top = 32
        Width = 129
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Unid. de Compra:'
        FocusControl = eFk_Unidades
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object eFk_Unidades: TPrcComboBox
        Left = 136
        Top = 32
        Width = 305
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        BevelKind = bkNone
        CharCase = ecUpperCase
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 3
        TypeObject = toObject
      end
      object lFk_Tipo_Descontos: TStaticText
        Left = 0
        Top = 56
        Width = 129
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Desconto Default:'
        FocusControl = eFk_Tipo_Descontos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object eFk_Tipo_Descontos: TPrcComboBox
        Left = 136
        Top = 56
        Width = 305
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        BevelKind = bkNone
        CharCase = ecUpperCase
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 5
        TypeObject = toObject
      end
      object lSit_Trib: TStaticText
        Left = 0
        Top = 88
        Width = 105
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Situa'#231#227'o Trib.:'
        FocusControl = eSit_Trib
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object eSit_Trib: TEdit
        Left = 112
        Top = 88
        Width = 73
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 3
        TabOrder = 7
        OnChange = ChangeGlobal
      end
      object lFlag_Rjst: TCheckBox
        Left = 192
        Top = 88
        Width = 193
        Height = 21
        Alignment = taLeftJustify
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Reaj. Custos Automatic.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = ChangeGlobal
      end
      object lDta_Grnt: TStaticText
        Left = 392
        Top = 88
        Width = 97
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' '#218'lt. Garantia:'
        FocusControl = eDta_Grnt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object eDta_Grnt: TDateEdit
        Left = 496
        Top = 88
        Width = 81
        Height = 21
        Anchors = [akTop, akRight]
        NumGlyphs = 2
        PopupColor = clWindow
        TabOrder = 10
        OnChange = ChangeGlobal
      end
      object lFlag_Insp: TRadioGroup
        Left = 448
        Top = 0
        Width = 129
        Height = 81
        Anchors = [akTop, akRight]
        Caption = 'Tipo de Inspe'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Liberado'
          'Normal'
          'Assegurado'
          'Cr'#237'tico')
        ParentFont = False
        TabOrder = 11
        OnClick = ChangeGlobal
      end
      object eQtd_Grnt: TCurrencyEdit
        Left = 496
        Top = 112
        Width = 81
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.0000;- ,0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akTop, akRight]
        ParentFont = False
        TabOrder = 12
        OnChange = ChangeGlobal
      end
      object lQtd_Grnt: TStaticText
        Left = 392
        Top = 112
        Width = 97
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. Garantia:'
        FocusControl = eQtd_Grnt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object eFrete_Ins: TCurrencyEdit
        Left = 304
        Top = 112
        Width = 81
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.0000;- ,0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akTop, akRight]
        ParentFont = False
        TabOrder = 14
        OnChange = PreFinChange
      end
      object lFrete_Ins: TStaticText
        Left = 192
        Top = 112
        Width = 105
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Frete %:'
        FocusControl = eFrete_Ins
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
      end
      object eQtd_Uni: TCurrencyEdit
        Left = 112
        Top = 112
        Width = 73
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.0000;- ,0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnChange = ChangeGlobal
      end
      object lQtd_Uni: TStaticText
        Left = 0
        Top = 112
        Width = 105
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. Unidade:'
        FocusControl = eQtd_Uni
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object lPre_Tab: TStaticText
        Left = 0
        Top = 136
        Width = 105
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Pre'#231'o Tabela:'
        FocusControl = ePre_Tab
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object ePre_Tab: TCurrencyEdit
        Left = 112
        Top = 136
        Width = 73
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.0000;- ,0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
        OnChange = PreFinChange
      end
      object lPre_Final: TStaticText
        Left = 192
        Top = 136
        Width = 105
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Pre'#231'o Final:'
        FocusControl = ePre_Final
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
      end
      object ePre_Final: TCurrencyEdit
        Left = 304
        Top = 136
        Width = 81
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.0000;- ,0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akTop, akRight]
        ParentFont = False
        TabOrder = 21
        OnChange = ChangeGlobal
      end
      object lQtd_Dias_Entr: TStaticText
        Left = 392
        Top = 136
        Width = 97
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Dias Entrega:'
        FocusControl = eQtd_Dias_Entr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
      end
      object eQtd_Dias_Entr: TCurrencyEdit
        Left = 496
        Top = 136
        Width = 81
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0;- ,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akTop, akRight]
        ParentFont = False
        TabOrder = 23
        OnChange = ChangeGlobal
      end
      object eObs_Forn: TMemo
        Left = 0
        Top = 160
        Width = 577
        Height = 96
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 24
      end
    end
  end
end
