inherited CdSimulator: TCdSimulator
  Left = 383
  Top = 110
  Caption = 'CdSimulator'
  ClientHeight = 413
  ClientWidth = 784
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pClientArea: TPanel
    Left = 0
    Top = 160
    Width = 784
    Height = 253
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object pCalc: TPanel
      Left = 0
      Top = 0
      Width = 784
      Height = 113
      Align = alClient
      BevelInner = bvLowered
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        784
        113)
      object pgCalc: TPageControl
        Left = 8
        Top = 8
        Width = 289
        Height = 97
        ActivePage = tsQuantity
        Anchors = [akLeft, akTop, akBottom]
        Style = tsFlatButtons
        TabOrder = 5
        OnChange = pgCalcChange
        object tsQuantity: TTabSheet
          Caption = 'Quantidade'
          DesignSize = (
            281
            66)
          object shPk_Pedidos_Fretes: TShape
            Left = 128
            Top = 45
            Width = 145
            Height = 21
            Anchors = [akLeft, akRight]
            Brush.Color = clYellow
          end
          object ePk_Pedidos_Fretes: TLabel
            Left = 136
            Top = 47
            Width = 129
            Height = 17
            Alignment = taCenter
            Anchors = [akLeft, akRight]
            AutoSize = False
            Caption = 'N'#186': 0000'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object sbCalcCub: TSpeedButton
            Left = 251
            Top = 0
            Width = 20
            Height = 20
            Hint = 
              'Calcular Cubagem | Calcula o valor em peso covertendo as medidas' +
              ' informadas'
            Anchors = [akRight]
            Flat = True
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
              73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
              0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
              0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
              0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
              0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
              0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
              0333337F777777737F333308888888880333337F333333337F33330888888888
              03333373FFFFFFFF733333700000000073333337777777773333}
            NumGlyphs = 2
            OnClick = sbCalcCubClick
          end
          object lQtdProd: TStaticText
            Left = 0
            Top = 0
            Width = 121
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Quantidade: '
            FocusControl = eQtd_Prod
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object eQtd_Prod: TRxCalcEdit
            Left = 128
            Top = 0
            Width = 121
            Height = 21
            AutoSize = False
            DecimalPlaces = 4
            DisplayFormat = ',0.0000'
            Anchors = [akLeft, akRight]
            NumGlyphs = 2
            TabOrder = 0
            OnChange = ChangeGlobal
          end
          object lDta_Ped: TStaticText
            Left = 0
            Top = 23
            Width = 121
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Data do Or'#231'am.: '
            FocusControl = eQtd_Prod
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object eDta_Ped: TDateEdit
            Left = 128
            Top = 23
            Width = 145
            Height = 21
            Anchors = [akLeft]
            NumGlyphs = 2
            PopupColor = clWhite
            Weekends = [Sun, Sat]
            TabOrder = 1
            OnChange = ChangeGlobal
          end
          object lQtd_Vol: TStaticText
            Left = 0
            Top = 45
            Width = 49
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Vol.: '
            FocusControl = eQtd_Vol
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object eQtd_Vol: TCurrencyEdit
            Left = 56
            Top = 45
            Width = 65
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = ',0.;- ,0.'
            Anchors = [akLeft]
            TabOrder = 5
            OnChange = ChangeGlobal
          end
        end
        object tsConsignatario: TTabSheet
          Caption = 'Consignat'#225'rio'
          ImageIndex = 3
          DesignSize = (
            281
            66)
          object shConsignee: TShape
            Left = 0
            Top = 23
            Width = 281
            Height = 20
            Anchors = [akLeft, akRight]
            Brush.Color = clInfoBk
          end
          object lConsignee: TLabel
            Left = 8
            Top = 25
            Width = 265
            Height = 16
            Anchors = [akLeft, akRight]
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object shDescriptionConsignee: TShape
            Left = 0
            Top = 45
            Width = 281
            Height = 20
            Anchors = [akLeft, akRight]
            Brush.Color = clInfoBk
          end
          object lDescriptionConsignee: TLabel
            Left = 8
            Top = 47
            Width = 265
            Height = 16
            Anchors = [akLeft, akRight]
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object sbSearchConsignee: TSpeedButton
            Tag = 2
            Left = 0
            Top = 0
            Width = 20
            Height = 20
            Flat = True
            Glyph.Data = {
              36050000424D3605000000000000360400002800000010000000100000000100
              08000000000000010000120B0000120B00000001000000000000314B6200444F
              5B0064636500325F8B00325F8C00355F890035608B000E6DDE000F6FDE00156D
              CE000F6FE100106FE200329DFF00359EFF00379FFF0032A0FE0037A1FF0037A4
              FE0038A5FE003BABFF005084B200925D5A008C777500A0746F00A67B7F00AC7D
              7E00B67F7600B67D7900B87E7A00BB7F7900FF00FF00A3837200AC867600B784
              7E00BB987E00EAA76C00EAA96A00EBAB6F00EEB87F00B48C8000B88B8000BB89
              8000B6978200BDA4A400A1CAE700C28F8800C1998300C2988600C0998C00CEA5
              8F00C9A39100D1A59200D0A79200D3AD9300D5AF9600D3B49900DCB79A00C6AD
              A700EFBD8000D5C2AC00DDCEA900F0C08600F0C28600F0C69000F6D09500FAD7
              9600FBDC9A00FCDE9D00E3CFB100F0D4A400F4D9A100F7DAA300F7DCA500FBDE
              A300EBE0B800FEE2A100FFEEAF00F8E2B500FAE9B400FCEBB100FFEDB200FBF0
              BD00FCF3B800EEEAC200F3EEC500F3EBD100FEF3C100FCF4C200F8F6CB00FEF8
              C600FCFBCC00FFFCCA00FEFCCE00FEFCCF00FFFFCE00FFFFCF00FFFFD000FFFF
              D100FFFFD300FFFFD400FFFFD500FFFFD700FFFFD800FFFFDC00F3EBE500FFF4
              E200FFFFE100FFFFE300FFFFE600FFFFEA00FFFFEE00FFFFF700FFFFFA00FFFF
              FF00000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000717171717171
              717171717171717171717102001C71717171717171717171717171140B051C71
              71717171717171717171710E0F08051C7171717171717171717171710E0F0802
              1C717171717171717171717171100F090171181B2D7171717171717171710E13
              1618374A53442D71717171717171712B30465B605F666927717171717171711C
              3F405760676F714A717171717171712F412651616A706E58227171717171712B
              4123405C646766622E7171717171712D463E3A47595E60542D71717171717171
              386B4D263D4759377171717171717171713B694B41433F2D7171717171717171
              71712E32372D7171717171717171717171717171717171717171}
            OnClick = sbSearchOwner
          end
          object lDocConsignee: TStaticText
            Left = 24
            Top = 0
            Width = 57
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'C.N.P.J.: '
            FocusControl = eDocRem
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object eTypeConsignee: TComboBox
            Left = 88
            Top = 0
            Width = 65
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft]
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 0
            Text = 'Jur'#237'dica'
            OnSelect = eTypeConsigneeSelect
            Items.Strings = (
              'Jur'#237'dica'
              'F'#237'sica')
          end
          object eDocConsignee: TMaskEdit
            Left = 160
            Top = 0
            Width = 119
            Height = 21
            Anchors = [akLeft, akRight]
            EditMask = '00.000.000\/0000\-00;0; '
            MaxLength = 18
            TabOrder = 1
            OnChange = ChangeGlobal
            OnExit = eDocConsigneeExit
          end
        end
        object tsObservations: TTabSheet
          Caption = 'Observa'#231#245'es'
          ImageIndex = 2
          DesignSize = (
            281
            66)
          object eObs_Ped: TMemo
            Left = 0
            Top = 24
            Width = 281
            Height = 42
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 1
            OnChange = ChangeGlobal
          end
          object lNomSol: TStaticText
            Left = 0
            Top = 0
            Width = 57
            Height = 20
            Alignment = taRightJustify
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Nome: '
            FocusControl = eNomSol
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object eNomSol: TEdit
            Left = 64
            Top = 0
            Width = 217
            Height = 21
            CharCase = ecUpperCase
            MaxLength = 50
            TabOrder = 0
          end
        end
        object tsCube: TTabSheet
          Caption = 'Cubagem'
          ImageIndex = 1
          object vtMeasure: TVirtualStringTree
            Left = 49
            Top = 0
            Width = 232
            Height = 66
            Align = alClient
            CheckImageKind = ckXP
            Colors.FocusedSelectionColor = 6730751
            Colors.FocusedSelectionBorderColor = clBtnShadow
            Colors.GridLineColor = clSilver
            Colors.SelectionRectangleBlendColor = 6730751
            Colors.UnfocusedSelectionColor = 6730751
            Ctl3D = True
            EditDelay = 0
            Header.AutoSizeIndex = 2
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clBlue
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HotCursor = crHandPoint
            ParentCtl3D = False
            SelectionCurveRadius = 20
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.MiscOptions = [toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            OnEditing = vtMeasureEditing
            OnGetText = vtMeasureGetText
            OnGetNodeDataSize = vtMeasureGetNodeDataSize
            OnKeyDown = vtMeasureKeyDown
            OnNewText = vtMeasureNewText
            Columns = <
              item
                ImageIndex = 9
                Position = 0
                Width = 76
                WideText = 'Altura'
              end
              item
                Position = 1
                Width = 76
                WideText = 'Largura'
              end
              item
                Position = 2
                Width = 80
                WideText = 'Profundidade'
              end>
            WideDefaultText = '...'
          end
          object rgTypeMed: TRadioGroup
            Left = 0
            Top = 0
            Width = 49
            Height = 66
            Align = alLeft
            Caption = 'Tipo'
            ItemIndex = 0
            Items.Strings = (
              'm'
              'cm')
            TabOrder = 1
            OnClick = rgTypeMedClick
          end
        end
        object tsComplement: TTabSheet
          Caption = 'Complementos'
          ImageIndex = 4
          object lFlag_ES: TRadioGroup
            Left = 0
            Top = 0
            Width = 89
            Height = 65
            Caption = 'Frete para:'
            ItemIndex = 0
            Items.Strings = (
              'Entradas'
              'Sa'#237'das')
            TabOrder = 0
          end
          object lFlag_Remb: TCheckBox
            Left = 104
            Top = 8
            Width = 177
            Height = 17
            Caption = 'Receber o frete na entrega'
            TabOrder = 1
          end
        end
      end
      object eFk_Tabela_Precos: TComboBox
        Left = 480
        Top = 40
        Width = 297
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 13
        TabOrder = 1
        OnSelect = ChangeGlobal
      end
      object lFk_Tabela_Precos: TStaticText
        Left = 304
        Top = 40
        Width = 169
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
        TabOrder = 6
      end
      object lVlr_NF: TStaticText
        Left = 592
        Top = 64
        Width = 81
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Valor: '
        FocusControl = eVlr_NF
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object eVlr_NF: TCurrencyEdit
        Left = 680
        Top = 64
        Width = 98
        Height = 21
        AutoSize = False
        DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
        Anchors = [akLeft]
        TabOrder = 3
        OnChange = ChangeGlobal
      end
      object lFk_Produtos: TStaticText
        Left = 304
        Top = 16
        Width = 169
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Tipo de Frete: '
        FocusControl = eFk_Produtos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object eFk_Produtos: TComboBox
        Left = 480
        Top = 16
        Width = 297
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 13
        TabOrder = 0
        OnSelect = eFk_ProdutosSelect
      end
      object lFk_Vendedores: TStaticText
        Left = 304
        Top = 88
        Width = 169
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Vendedor: '
        FocusControl = eFk_Vendedores
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object eFk_Vendedores: TComboBox
        Left = 480
        Top = 88
        Width = 297
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 13
        TabOrder = 4
        OnSelect = ChangeGlobal
      end
      object lNum_NF: TStaticText
        Left = 304
        Top = 64
        Width = 169
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'mero da Nota Fiscal: '
        FocusControl = eNum_NF
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object eNum_NF: TCurrencyEdit
        Left = 480
        Top = 64
        Width = 105
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0;- ,0'
        Anchors = [akLeft]
        TabOrder = 2
        OnChange = ChangeGlobal
      end
    end
    object pgCalcCarrier: TPageControl
      Left = 0
      Top = 113
      Width = 784
      Height = 140
      ActivePage = tsOwner
      Align = alBottom
      Style = tsFlatButtons
      TabOrder = 1
      object tsOwner: TTabSheet
        Caption = 'Frete Pr'#243'prio'
        DesignSize = (
          776
          109)
        object shTot_Ped: TShape
          Left = 280
          Top = 80
          Width = 289
          Height = 26
          Anchors = [akRight]
          Brush.Color = clYellow
        end
        object lTot_Ped: TLabel
          Left = 384
          Top = 82
          Width = 182
          Height = 22
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          Caption = 'Total do Frete:'
          FocusControl = eTot_Ped
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -21
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lVlr_Fre_Peso: TStaticText
          Left = 8
          Top = 32
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Frete Peso: '
          FocusControl = eVlr_Fre_Peso
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object eVlr_Fre_Peso: TCurrencyEdit
          Left = 112
          Top = 32
          Width = 98
          Height = 21
          TabStop = False
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft]
          ReadOnly = True
          TabOrder = 0
        end
        object lFre_Vlr: TStaticText
          Left = 8
          Top = 56
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Frete Valor: '
          FocusControl = eFre_Vlr
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object eFre_Vlr: TCurrencyEdit
          Left = 112
          Top = 56
          Width = 98
          Height = 21
          TabStop = False
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft]
          ReadOnly = True
          TabOrder = 1
        end
        object lVlr_Secat: TStaticText
          Left = 8
          Top = 80
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Secat: '
          FocusControl = eVlr_Secat
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object eVlr_Secat: TCurrencyEdit
          Left = 112
          Top = 80
          Width = 98
          Height = 21
          TabStop = False
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft]
          ReadOnly = True
          TabOrder = 2
        end
        object lVlr_Dif_Acc: TStaticText
          Left = 280
          Top = 56
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Dif'#237'cil Acesso: '
          FocusControl = eVlr_Dif_Acc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object eVlr_Dif_Acc: TCurrencyEdit
          Left = 384
          Top = 56
          Width = 98
          Height = 21
          TabStop = False
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft, akRight]
          ReadOnly = True
          TabOrder = 5
        end
        object eVlr_Pedg: TCurrencyEdit
          Left = 384
          Top = 32
          Width = 98
          Height = 21
          TabStop = False
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft, akRight]
          ReadOnly = True
          TabOrder = 4
        end
        object lVlr_Pedg: TStaticText
          Left = 280
          Top = 32
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Ped'#225'gio: '
          FocusControl = eVlr_Pedg
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object lVlr_Gris: TStaticText
          Left = 280
          Top = 8
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Gris: '
          FocusControl = eVlr_Gris
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object eVlr_Gris: TCurrencyEdit
          Left = 384
          Top = 8
          Width = 98
          Height = 21
          TabStop = False
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft, akRight]
          ReadOnly = True
          TabOrder = 3
        end
        object lBas_ICMS: TStaticText
          Left = 576
          Top = 8
          Width = 89
          Height = 20
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Base ICMS: '
          FocusControl = eBas_ICMS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object eBas_ICMS: TCurrencyEdit
          Left = 672
          Top = 8
          Width = 98
          Height = 21
          TabStop = False
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akRight]
          ReadOnly = True
          TabOrder = 6
        end
        object lAlqt_ICMS: TStaticText
          Left = 576
          Top = 32
          Width = 89
          Height = 20
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Al'#237'q. ICMS: '
          FocusControl = eAlqt_ICMS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
        end
        object eAlqt_ICMS: TCurrencyEdit
          Left = 672
          Top = 32
          Width = 98
          Height = 21
          TabStop = False
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akRight]
          ReadOnly = True
          TabOrder = 7
        end
        object eVlr_ICMS: TCurrencyEdit
          Left = 672
          Top = 56
          Width = 98
          Height = 21
          TabStop = False
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akRight]
          ReadOnly = True
          TabOrder = 8
        end
        object lVlr_ICMS: TStaticText
          Left = 576
          Top = 56
          Width = 89
          Height = 20
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Valor ICMS: '
          FocusControl = eVlr_ICMS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
        object eTot_Ped: TCurrencyEdit
          Left = 576
          Top = 80
          Width = 193
          Height = 26
          TabStop = False
          AutoSize = False
          Color = clYellow
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -21
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akRight]
          ParentFont = False
          TabOrder = 9
          OnChange = eTot_PedChange
        end
        object lVlr_Acr_Dsct: TStaticText
          Left = 8
          Top = 8
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Desconto: '
          FocusControl = eVlr_Acr_Dsct
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 19
        end
        object eVlr_Acr_Dsct: TCurrencyEdit
          Left = 112
          Top = 8
          Width = 97
          Height = 21
          AutoSize = False
          Anchors = [akLeft]
          TabOrder = 20
          OnChange = ChangeGlobal
        end
      end
      object tsParner: TTabSheet
        Caption = 'Frete Parceiro'
        ImageIndex = 1
        DesignSize = (
          776
          109)
        object shTot_Ped_P: TShape
          Left = 8
          Top = 80
          Width = 553
          Height = 28
          Anchors = [akLeft]
          Brush.Color = clYellow
        end
        object lTot_Ped_P: TLabel
          Left = 16
          Top = 83
          Width = 537
          Height = 23
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          Caption = 'Total do Frete:'
          FocusControl = eTot_Ped_P
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lVlr_Fre_Peso_P: TStaticText
          Left = 8
          Top = 32
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Frete Peso: '
          FocusControl = eVlr_Fre_Peso_P
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object eVlr_Fre_Peso_P: TCurrencyEdit
          Left = 112
          Top = 32
          Width = 98
          Height = 21
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft]
          ReadOnly = True
          TabOrder = 1
        end
        object lFre_Vlr_P: TStaticText
          Left = 8
          Top = 56
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Frete Valor: '
          FocusControl = eFre_Vlr_P
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object eFre_Vlr_P: TCurrencyEdit
          Left = 112
          Top = 56
          Width = 98
          Height = 21
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft]
          ReadOnly = True
          TabOrder = 2
        end
        object lVlr_Secat_P: TStaticText
          Left = 568
          Top = 32
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Secat: '
          FocusControl = eVlr_Secat_P
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object eVlr_Secat_P: TCurrencyEdit
          Left = 672
          Top = 32
          Width = 98
          Height = 21
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akRight]
          ReadOnly = True
          TabOrder = 3
        end
        object lVlr_Dif_Acc_P: TStaticText
          Left = 568
          Top = 56
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Dif'#237'cil Acesso: '
          FocusControl = eVlr_Dif_Acc_P
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object eVlr_Dif_Acc_P: TCurrencyEdit
          Left = 672
          Top = 56
          Width = 98
          Height = 21
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akRight]
          TabOrder = 6
        end
        object eVlr_Pedg_P: TCurrencyEdit
          Left = 384
          Top = 56
          Width = 98
          Height = 21
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft, akRight]
          ReadOnly = True
          TabOrder = 5
        end
        object lVlr_Pedg_P: TStaticText
          Left = 280
          Top = 56
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Ped'#225'gio: '
          FocusControl = eVlr_Pedg_P
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object lVlr_Gris_P: TStaticText
          Left = 280
          Top = 32
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Gris: '
          FocusControl = eVlr_Gris_P
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object eVlr_Gris_P: TCurrencyEdit
          Left = 384
          Top = 32
          Width = 98
          Height = 21
          AutoSize = False
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Anchors = [akLeft, akRight]
          ReadOnly = True
          TabOrder = 4
        end
        object eTot_Ped_P: TCurrencyEdit
          Left = 568
          Top = 80
          Width = 201
          Height = 29
          AutoSize = False
          Color = clYellow
          DisplayFormat = 'R$ ,0.00;- R$ ,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akRight]
          ParentFont = False
          TabOrder = 7
        end
        object lFk_Parceiro: TStaticText
          Left = 8
          Top = 8
          Width = 97
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Parceiro: '
          FocusControl = eFk_Parceiro
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object eFk_Parceiro: TComboBox
          Left = 112
          Top = 8
          Width = 657
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akRight]
          ItemHeight = 0
          TabOrder = 0
          OnSelect = ChangeGlobal
        end
      end
    end
  end
  object pgOrgmDstn: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 160
    ActivePage = tsSelRemDstn
    Align = alTop
    TabOrder = 0
    object tsSelOrgmDstn: TTabSheet
      Caption = 'Sele'#231#227'o de Origem e Destino'
      DesignSize = (
        776
        132)
      object gbOrigin: TGroupBox
        Left = 8
        Top = 0
        Width = 377
        Height = 129
        Anchors = [akLeft]
        Caption = 'Sele'#231#227'o da Origem'
        TabOrder = 0
        DesignSize = (
          377
          129)
        object shRegionOrgm: TShape
          Left = 8
          Top = 104
          Width = 361
          Height = 21
          Anchors = [akLeft, akRight]
          Brush.Color = clInfoBk
        end
        object lRegionOrgm: TLabel
          Left = 16
          Top = 106
          Width = 345
          Height = 17
          Alignment = taCenter
          Anchors = [akLeft, akRight]
          AutoSize = False
          Caption = 'Regi'#227'o:'
          Color = clWindow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object sbCancelOrgm: TSpeedButton
          Left = 184
          Top = 86
          Width = 17
          Height = 17
          Anchors = [akLeft, akRight]
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FF033B8A033D90013D95023B91033A89033A89FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0357D30147B20051D0035CE007
            63E3035CE0004ED30042B7023A8F023A8FFF00FFFF00FFFF00FFFF00FFFF00FF
            0650BA0357D32781F278B4F7CAE2FCE9F4FFDCEDFF9CC7FA3F8FF20155DD0140
            A404367DFF00FFFF00FFFF00FF075DD70762E155A0F7F3F8FEFFFFFFE9F3FCC6
            DEFAD9E9FCFFFFFFFFFFFF99C5F8055DE70040A302398BFF00FFFF00FF075DD7
            529EF7FEFEFFE2EFFC0F65EB0558E70959E50250E20454E16FA6F0DEEBFC9CC9
            F80355DE02398BFF00FF0455C9207DF0E1EFFEFFFFFF6FA7F076AFF7176CED06
            5AE9075AE60F5EE66AA1F06FA7F0FFFFFF3E8FF20043B7033E96085FDA56A1FA
            FFFFFF9ECBFB1573F779B4FACFE3FC1C72EF2274EECBE1FB6DA5F20556E3DEEB
            FC9FCBFA0050D4033E960F6BE68BC1FCFFFFFF2987FC1F7DFA1674F779B5FADE
            EDFEDDEDFC6EAAF4065AE90455E5A0C5F6DEEFFF0560E202409C1B76EDA4CFFC
            FFFFFF2988FF1C7EFE1C7BFB2D87FBEDF6FEEDF6FE2279F20B63ED085DEA88BA
            F4EBF6FF0C68E60141A1207AEBA5CFFEFFFFFF3F97FF1F81FF3B93FEE1EFFF6B
            ADFC69ABFBE0EEFE2C80F30C65EEC6DEFBCEE5FE0763E203419E146FE79ACAFC
            FFFFFFB2D8FF318EFFE7F3FF67AFFF1D7EFE1A7AFB60A7FCE5F2FE3F8FF6E2EF
            FE81BAF80258D8033E96FF00FF237BEBEDF6FFFAFCFF5DA9FF469AFF1F81FF1F
            81FF1E80FF1C7DFC4D9CFBF0F8FFF2F8FE3089F4024FC0FF00FFFF00FF237BEB
            BFDEFFF3F8FFFAFCFFB0D5FF3E96FF2B89FF308CFF6AB0FEFAFCFFFFFFFF5DA6
            F70860DE024FC0FF00FFFF00FFFF00FF4997F3C7E3FFF7FBFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFE0EFFE5CA5F80E6BE70552C2FF00FFFF00FFFF00FFFF00FF
            FF00FF2D82EB91C5FBCCE6FFD9EDFFDCEDFEC4E0FE86BFFC348BF40A65E10A65
            E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF247BEB4696F34A
            98F42F87F0116CE6075FDCFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = sbCancelOrgmClick
        end
        object lFkPaisesOrgm: TStaticText
          Left = 8
          Top = 16
          Width = 89
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Pa'#237's: '
          FocusControl = eFkPaisesOrgm
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object lFkEstadosOrgm: TStaticText
          Left = 8
          Top = 40
          Width = 89
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Estado: '
          FocusControl = eFkEstadosOrgm
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object lFkMunicipiosOrgm: TStaticText
          Left = 8
          Top = 64
          Width = 89
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Munic'#237'pio: '
          FocusControl = eFkMunicipiosOrgm
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object eFkPaisesOrgm: TPrcComboBox
          Left = 104
          Top = 16
          Width = 265
          Height = 21
          Anchors = [akLeft, akRight]
          BevelKind = bkNone
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 0
          OnSelect = eFkPaisesOrgmSelect
          TabOrder = 3
          TypeObject = toObject
        end
        object eFkEstadosOrgm: TPrcComboBox
          Left = 104
          Top = 40
          Width = 265
          Height = 21
          Anchors = [akLeft, akRight]
          BevelKind = bkNone
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 0
          OnSelect = eFkEstadosOrgmSelect
          TabOrder = 4
          TypeObject = toObject
        end
        object eFkMunicipiosOrgm: TPrcComboBox
          Left = 104
          Top = 64
          Width = 265
          Height = 21
          Anchors = [akLeft, akRight]
          BevelKind = bkNone
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 0
          OnSelect = eFkMunicipiosOrgmSelect
          TabOrder = 5
          TypeObject = toObject
        end
        object lFlag_Cnsm_Orgm: TRadioButton
          Left = 8
          Top = 86
          Width = 113
          Height = 17
          Anchors = [akLeft]
          Caption = 'Pessoa F'#237'sica'
          TabOrder = 6
        end
        object lFlag_Company_Orgm: TRadioButton
          Left = 304
          Top = 86
          Width = 65
          Height = 17
          Alignment = taLeftJustify
          Anchors = [akRight]
          Caption = 'Empresa'
          TabOrder = 7
        end
      end
      object gbDestination: TGroupBox
        Left = 392
        Top = 0
        Width = 377
        Height = 129
        Anchors = [akRight]
        Caption = 'Sele'#231#227'o do Destino'
        TabOrder = 1
        DesignSize = (
          377
          129)
        object shRegionDstn: TShape
          Left = 8
          Top = 104
          Width = 361
          Height = 21
          Anchors = [akLeft, akRight]
          Brush.Color = clInfoBk
        end
        object lRegionDstn: TLabel
          Left = 16
          Top = 106
          Width = 345
          Height = 17
          Alignment = taCenter
          Anchors = [akLeft, akRight]
          AutoSize = False
          Caption = 'Regi'#227'o:'
          Color = clWindow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object sbCancelDstn: TSpeedButton
          Left = 184
          Top = 86
          Width = 17
          Height = 17
          Anchors = [akLeft, akRight]
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FF033B8A033D90013D95023B91033A89033A89FF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0357D30147B20051D0035CE007
            63E3035CE0004ED30042B7023A8F023A8FFF00FFFF00FFFF00FFFF00FFFF00FF
            0650BA0357D32781F278B4F7CAE2FCE9F4FFDCEDFF9CC7FA3F8FF20155DD0140
            A404367DFF00FFFF00FFFF00FF075DD70762E155A0F7F3F8FEFFFFFFE9F3FCC6
            DEFAD9E9FCFFFFFFFFFFFF99C5F8055DE70040A302398BFF00FFFF00FF075DD7
            529EF7FEFEFFE2EFFC0F65EB0558E70959E50250E20454E16FA6F0DEEBFC9CC9
            F80355DE02398BFF00FF0455C9207DF0E1EFFEFFFFFF6FA7F076AFF7176CED06
            5AE9075AE60F5EE66AA1F06FA7F0FFFFFF3E8FF20043B7033E96085FDA56A1FA
            FFFFFF9ECBFB1573F779B4FACFE3FC1C72EF2274EECBE1FB6DA5F20556E3DEEB
            FC9FCBFA0050D4033E960F6BE68BC1FCFFFFFF2987FC1F7DFA1674F779B5FADE
            EDFEDDEDFC6EAAF4065AE90455E5A0C5F6DEEFFF0560E202409C1B76EDA4CFFC
            FFFFFF2988FF1C7EFE1C7BFB2D87FBEDF6FEEDF6FE2279F20B63ED085DEA88BA
            F4EBF6FF0C68E60141A1207AEBA5CFFEFFFFFF3F97FF1F81FF3B93FEE1EFFF6B
            ADFC69ABFBE0EEFE2C80F30C65EEC6DEFBCEE5FE0763E203419E146FE79ACAFC
            FFFFFFB2D8FF318EFFE7F3FF67AFFF1D7EFE1A7AFB60A7FCE5F2FE3F8FF6E2EF
            FE81BAF80258D8033E96FF00FF237BEBEDF6FFFAFCFF5DA9FF469AFF1F81FF1F
            81FF1E80FF1C7DFC4D9CFBF0F8FFF2F8FE3089F4024FC0FF00FFFF00FF237BEB
            BFDEFFF3F8FFFAFCFFB0D5FF3E96FF2B89FF308CFF6AB0FEFAFCFFFFFFFF5DA6
            F70860DE024FC0FF00FFFF00FFFF00FF4997F3C7E3FFF7FBFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFE0EFFE5CA5F80E6BE70552C2FF00FFFF00FFFF00FFFF00FF
            FF00FF2D82EB91C5FBCCE6FFD9EDFFDCEDFEC4E0FE86BFFC348BF40A65E10A65
            E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF247BEB4696F34A
            98F42F87F0116CE6075FDCFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = sbCancelDstnClick
        end
        object lFkPaisesDstn: TStaticText
          Left = 8
          Top = 16
          Width = 89
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Pa'#237's: '
          FocusControl = eFkPaisesDstn
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object lFkEstadosDstn: TStaticText
          Left = 8
          Top = 40
          Width = 89
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Estado: '
          FocusControl = eFkEstadosDstn
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object lFkMunicipiosDstn: TStaticText
          Left = 8
          Top = 64
          Width = 89
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Munic'#237'pio: '
          FocusControl = eFkMunicipiosDstn
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object eFkPaisesDstn: TPrcComboBox
          Left = 104
          Top = 16
          Width = 265
          Height = 21
          Anchors = [akLeft, akRight]
          BevelKind = bkNone
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 0
          OnSelect = eFkPaisesDstnSelect
          TabOrder = 3
          TypeObject = toObject
        end
        object eFkEstadosDstn: TPrcComboBox
          Left = 104
          Top = 40
          Width = 265
          Height = 21
          Anchors = [akLeft, akRight]
          BevelKind = bkNone
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 0
          OnSelect = eFkEstadosDstnSelect
          TabOrder = 4
          TypeObject = toObject
        end
        object eFkMunicipiosDstn: TPrcComboBox
          Left = 104
          Top = 64
          Width = 265
          Height = 21
          Anchors = [akLeft, akRight]
          BevelKind = bkNone
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 0
          OnSelect = eFkMunicipiosDstnSelect
          TabOrder = 5
          TypeObject = toObject
        end
        object lFlag_Company_Dstn: TRadioButton
          Left = 304
          Top = 86
          Width = 65
          Height = 17
          Alignment = taLeftJustify
          Anchors = [akRight]
          Caption = 'Empresa'
          TabOrder = 6
        end
        object lFlag_Cnsm_Dstn: TRadioButton
          Left = 8
          Top = 86
          Width = 113
          Height = 17
          Anchors = [akLeft]
          Caption = 'Pessoa F'#237'sica'
          TabOrder = 7
        end
      end
    end
    object tsSelRemDstn: TTabSheet
      Caption = 'Sele'#231#227'o do Remetente e Destinat'#225'rio'
      ImageIndex = 1
      object gbAddressee: TGroupBox
        Left = 0
        Top = 65
        Width = 776
        Height = 67
        Align = alClient
        Caption = 'Dados do Destinat'#225'rio'
        TabOrder = 1
        DesignSize = (
          776
          67)
        object shAddressee: TShape
          Left = 440
          Top = 16
          Width = 328
          Height = 20
          Anchors = [akLeft, akRight]
          Brush.Color = clInfoBk
        end
        object lAddressee: TLabel
          Left = 448
          Top = 18
          Width = 312
          Height = 16
          Anchors = [akLeft, akRight]
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object shDescriptionAddr: TShape
          Left = 8
          Top = 40
          Width = 760
          Height = 20
          Anchors = [akLeft, akRight]
          Brush.Color = clCream
        end
        object lDescriptionAddr: TLabel
          Left = 16
          Top = 42
          Width = 744
          Height = 16
          Anchors = [akLeft, akRight]
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object sbSearchAddressee: TSpeedButton
          Tag = 1
          Left = 8
          Top = 16
          Width = 20
          Height = 20
          Flat = True
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000120B0000120B00000001000000000000314B6200444F
            5B0064636500325F8B00325F8C00355F890035608B000E6DDE000F6FDE00156D
            CE000F6FE100106FE200329DFF00359EFF00379FFF0032A0FE0037A1FF0037A4
            FE0038A5FE003BABFF005084B200925D5A008C777500A0746F00A67B7F00AC7D
            7E00B67F7600B67D7900B87E7A00BB7F7900FF00FF00A3837200AC867600B784
            7E00BB987E00EAA76C00EAA96A00EBAB6F00EEB87F00B48C8000B88B8000BB89
            8000B6978200BDA4A400A1CAE700C28F8800C1998300C2988600C0998C00CEA5
            8F00C9A39100D1A59200D0A79200D3AD9300D5AF9600D3B49900DCB79A00C6AD
            A700EFBD8000D5C2AC00DDCEA900F0C08600F0C28600F0C69000F6D09500FAD7
            9600FBDC9A00FCDE9D00E3CFB100F0D4A400F4D9A100F7DAA300F7DCA500FBDE
            A300EBE0B800FEE2A100FFEEAF00F8E2B500FAE9B400FCEBB100FFEDB200FBF0
            BD00FCF3B800EEEAC200F3EEC500F3EBD100FEF3C100FCF4C200F8F6CB00FEF8
            C600FCFBCC00FFFCCA00FEFCCE00FEFCCF00FFFFCE00FFFFCF00FFFFD000FFFF
            D100FFFFD300FFFFD400FFFFD500FFFFD700FFFFD800FFFFDC00F3EBE500FFF4
            E200FFFFE100FFFFE300FFFFE600FFFFEA00FFFFEE00FFFFF700FFFFFA00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000717171717171
            717171717171717171717102001C71717171717171717171717171140B051C71
            71717171717171717171710E0F08051C7171717171717171717171710E0F0802
            1C717171717171717171717171100F090171181B2D7171717171717171710E13
            1618374A53442D71717171717171712B30465B605F666927717171717171711C
            3F405760676F714A717171717171712F412651616A706E58227171717171712B
            4123405C646766622E7171717171712D463E3A47595E60542D71717171717171
            386B4D263D4759377171717171717171713B694B41433F2D7171717171717171
            71712E32372D7171717171717171717171717171717171717171}
          OnClick = sbSearchOwner
        end
        object lDocDstn: TStaticText
          Left = 32
          Top = 16
          Width = 167
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'C.N.P.J. do Destinat'#225'rio: '
          FocusControl = eDocDstn
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object eTypeDstn: TComboBox
          Left = 208
          Top = 16
          Width = 80
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft]
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Jur'#237'dica'
          OnSelect = eTypeDstnSelect
          Items.Strings = (
            'Jur'#237'dica'
            'F'#237'sica')
        end
        object eDocDstn: TMaskEdit
          Left = 296
          Top = 16
          Width = 136
          Height = 21
          Anchors = [akLeft]
          EditMask = '00.000.000\/0000\-00;0; '
          MaxLength = 18
          TabOrder = 1
          OnChange = ChangeGlobal
          OnExit = eDocDstnExit
        end
      end
      object gbShipper: TGroupBox
        Left = 0
        Top = 0
        Width = 776
        Height = 65
        Align = alTop
        Caption = 'Dados do Remetente'
        TabOrder = 0
        DesignSize = (
          776
          65)
        object shDescriptionShipper: TShape
          Left = 8
          Top = 40
          Width = 760
          Height = 20
          Anchors = [akLeft, akRight]
          Brush.Color = clCream
        end
        object shShipper: TShape
          Left = 440
          Top = 16
          Width = 328
          Height = 20
          Anchors = [akLeft, akRight]
          Brush.Color = clInfoBk
        end
        object lShipper: TLabel
          Left = 448
          Top = 18
          Width = 312
          Height = 16
          Anchors = [akLeft, akRight]
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lDescriptionShipper: TLabel
          Left = 16
          Top = 42
          Width = 744
          Height = 16
          Anchors = [akLeft, akRight]
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object sbSearchShipper: TSpeedButton
          Left = 8
          Top = 16
          Width = 20
          Height = 20
          Flat = True
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000120B0000120B00000001000000000000314B6200444F
            5B0064636500325F8B00325F8C00355F890035608B000E6DDE000F6FDE00156D
            CE000F6FE100106FE200329DFF00359EFF00379FFF0032A0FE0037A1FF0037A4
            FE0038A5FE003BABFF005084B200925D5A008C777500A0746F00A67B7F00AC7D
            7E00B67F7600B67D7900B87E7A00BB7F7900FF00FF00A3837200AC867600B784
            7E00BB987E00EAA76C00EAA96A00EBAB6F00EEB87F00B48C8000B88B8000BB89
            8000B6978200BDA4A400A1CAE700C28F8800C1998300C2988600C0998C00CEA5
            8F00C9A39100D1A59200D0A79200D3AD9300D5AF9600D3B49900DCB79A00C6AD
            A700EFBD8000D5C2AC00DDCEA900F0C08600F0C28600F0C69000F6D09500FAD7
            9600FBDC9A00FCDE9D00E3CFB100F0D4A400F4D9A100F7DAA300F7DCA500FBDE
            A300EBE0B800FEE2A100FFEEAF00F8E2B500FAE9B400FCEBB100FFEDB200FBF0
            BD00FCF3B800EEEAC200F3EEC500F3EBD100FEF3C100FCF4C200F8F6CB00FEF8
            C600FCFBCC00FFFCCA00FEFCCE00FEFCCF00FFFFCE00FFFFCF00FFFFD000FFFF
            D100FFFFD300FFFFD400FFFFD500FFFFD700FFFFD800FFFFDC00F3EBE500FFF4
            E200FFFFE100FFFFE300FFFFE600FFFFEA00FFFFEE00FFFFF700FFFFFA00FFFF
            FF00000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000717171717171
            717171717171717171717102001C71717171717171717171717171140B051C71
            71717171717171717171710E0F08051C7171717171717171717171710E0F0802
            1C717171717171717171717171100F090171181B2D7171717171717171710E13
            1618374A53442D71717171717171712B30465B605F666927717171717171711C
            3F405760676F714A717171717171712F412651616A706E58227171717171712B
            4123405C646766622E7171717171712D463E3A47595E60542D71717171717171
            386B4D263D4759377171717171717171713B694B41433F2D7171717171717171
            71712E32372D7171717171717171717171717171717171717171}
          OnClick = sbSearchOwner
        end
        object lDocRem: TStaticText
          Left = 32
          Top = 16
          Width = 166
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'C.N.P.J. do Remetente: '
          FocusControl = eDocRem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object eTypeRem: TComboBox
          Left = 208
          Top = 16
          Width = 78
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft]
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Jur'#237'dica'
          OnSelect = eTypeRemSelect
          Items.Strings = (
            'Jur'#237'dica'
            'F'#237'sica')
        end
        object eDocRem: TMaskEdit
          Left = 296
          Top = 16
          Width = 135
          Height = 21
          Anchors = [akLeft]
          EditMask = '00.000.000\/0000\-00;0; '
          MaxLength = 18
          TabOrder = 1
          OnChange = ChangeGlobal
          OnExit = eDocRemExit
        end
      end
    end
    object tsSchedule: TTabSheet
      Caption = 'Agendamentos'
      ImageIndex = 2
      DesignSize = (
        776
        132)
      object StaticText1: TStaticText
        Left = 8
        Top = 8
        Width = 121
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data/Hora Inicial: '
        FocusControl = eDocRem
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object StaticText2: TStaticText
        Left = 8
        Top = 40
        Width = 121
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data/Hora Inicial: '
        FocusControl = eDocRem
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object DateTimePicker1: TDateTimePicker
        Left = 136
        Top = 8
        Width = 97
        Height = 21
        Anchors = [akLeft]
        Date = 39148.973049039350000000
        Time = 39148.973049039350000000
        TabOrder = 2
      end
      object DateTimePicker2: TDateTimePicker
        Left = 240
        Top = 8
        Width = 73
        Height = 21
        Anchors = [akLeft]
        Date = 39148.973049039350000000
        Time = 39148.973049039350000000
        Kind = dtkTime
        TabOrder = 3
      end
      object DateTimePicker3: TDateTimePicker
        Left = 136
        Top = 40
        Width = 97
        Height = 21
        Anchors = [akLeft]
        Date = 39148.973049039350000000
        Time = 39148.973049039350000000
        TabOrder = 4
      end
      object DateTimePicker4: TDateTimePicker
        Left = 240
        Top = 40
        Width = 73
        Height = 21
        Anchors = [akLeft]
        Date = 39148.973049039350000000
        Time = 39148.973049039350000000
        Kind = dtkTime
        TabOrder = 5
      end
      object StaticText3: TStaticText
        Left = 8
        Top = 72
        Width = 121
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Formato: '
        FocusControl = eDocRem
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object ComboBox1: TComboBox
        Left = 136
        Top = 72
        Width = 177
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft]
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 7
        Text = 'Data Completa'
        Items.Strings = (
          'Data Completa'
          'Dia da Semana')
      end
      object vtSchedule: TVirtualStringTree
        Left = 320
        Top = 8
        Width = 456
        Height = 113
        Anchors = [akLeft, akTop, akRight, akBottom]
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
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HotCursor = crHandPoint
        ParentCtl3D = False
        SelectionCurveRadius = 20
        TabOrder = 8
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
        TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
        Columns = <
          item
            ImageIndex = 9
            Position = 0
            Width = 226
            WideText = 'Data Inicial'
          end
          item
            Position = 1
            Width = 230
            WideText = 'Data Final'
          end>
        WideDefaultText = '...'
      end
      object cbOperSchedule: TCoolBar
        Left = 8
        Top = 96
        Width = 305
        Height = 33
        Align = alNone
        Anchors = [akLeft]
        Bands = <
          item
            Control = tbOperSchedule
            ImageIndex = -1
            Width = 301
          end>
        object tbOperSchedule: TToolBar
          Left = 9
          Top = 0
          Width = 288
          Height = 25
          ButtonHeight = 19
          ButtonWidth = 54
          Caption = 'tbOperSchedule'
          Flat = True
          List = True
          ShowCaptions = True
          TabOrder = 0
          object tbInsert: TToolButton
            Left = 0
            Top = 0
            Caption = 'Inserir'
            ImageIndex = 34
          end
          object tbSave: TToolButton
            Left = 54
            Top = 0
            Caption = 'Salvar'
            ImageIndex = 36
          end
          object ToolButton1: TToolButton
            Left = 108
            Top = 0
            Width = 8
            Caption = 'ToolButton1'
            ImageIndex = 4
            Style = tbsSeparator
          end
          object tbDelete: TToolButton
            Left = 116
            Top = 0
            Caption = 'Excluir'
            ImageIndex = 33
          end
          object tbCancel: TToolButton
            Left = 170
            Top = 0
            Caption = 'Cancelar'
            ImageIndex = 28
          end
        end
      end
    end
  end
end
