inherited frmSearch: TfrmSearch
  Left = 356
  Top = 134
  Caption = 'frmSearch'
  ClientHeight = 436
  ClientWidth = 784
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object vtSearch: TVirtualStringTree
    Left = 0
    Top = 145
    Width = 784
    Height = 291
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
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
    OnFocusChanged = vtSearchFocusChanged
    OnGetText = vtSearchGetText
    OnGetNodeDataSize = vtSearchGetNodeDataSize
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
        Position = 2
        Width = 300
        WideText = 'Remetente'
      end
      item
        Position = 3
        Width = 300
        WideText = 'Destinat'#225'rio'
      end
      item
        ImageIndex = 9
        Position = 4
        Width = 150
        WideText = 'Origem'
      end
      item
        Position = 5
        Width = 150
        WideText = 'Destino'
      end
      item
        Position = 6
        Width = 150
        WideText = 'Valor'
      end>
    WideDefaultText = '...'
  end
  object pParams: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 145
    Align = alTop
    BevelInner = bvLowered
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      784
      145)
    object eNumNF: TCurrencyEdit
      Left = 656
      Top = 32
      Width = 121
      Height = 21
      AutoSize = False
      DecimalPlaces = 0
      DisplayFormat = ',0; ,0'
      TabOrder = 0
    end
    object eNumDoc: TCurrencyEdit
      Left = 656
      Top = 8
      Width = 121
      Height = 21
      AutoSize = False
      DecimalPlaces = 0
      DisplayFormat = ',0; ,0'
      TabOrder = 1
    end
    object pgSeacrh: TPageControl
      Left = 8
      Top = 8
      Width = 441
      Height = 129
      ActivePage = tsSimulator
      Anchors = [akLeft, akTop, akRight, akBottom]
      Style = tsFlatButtons
      TabOrder = 2
      object tsSimulator: TTabSheet
        Caption = 'tsSimulator'
        TabVisible = False
        DesignSize = (
          433
          119)
        object eNomCli: TEdit
          Left = 128
          Top = 8
          Width = 305
          Height = 21
          TabOrder = 0
        end
        object lNomCli: TStaticText
          Left = 0
          Top = 8
          Width = 121
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Nome do Cliente: '
          FocusControl = eNomCli
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object tsDocument: TTabSheet
        Caption = 'tsDocument'
        ImageIndex = 1
        TabVisible = False
        DesignSize = (
          433
          119)
        object shRazSocRem: TShape
          Left = 0
          Top = 32
          Width = 425
          Height = 20
          Anchors = [akLeft, akRight]
          Brush.Color = clCream
        end
        object shRazSocDstn: TShape
          Left = 0
          Top = 80
          Width = 425
          Height = 20
          Anchors = [akLeft, akRight]
          Brush.Color = clCream
        end
        object lRazSocRem: TLabel
          Left = 5
          Top = 34
          Width = 415
          Height = 16
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lRazSocDstn: TLabel
          Left = 5
          Top = 82
          Width = 415
          Height = 16
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object eCnpjRem: TMaskEdit
          Left = 280
          Top = 8
          Width = 144
          Height = 21
          Anchors = [akLeft, akRight]
          EditMask = '00.000.000\/0000\-00;0; '
          MaxLength = 18
          TabOrder = 0
        end
        object eCnpjDstn: TMaskEdit
          Left = 280
          Top = 56
          Width = 144
          Height = 21
          Anchors = [akLeft, akRight]
          EditMask = '00.000.000\/0000\-00;0; '
          MaxLength = 18
          TabOrder = 1
        end
        object eTypeRem: TComboBox
          Left = 200
          Top = 8
          Width = 81
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft]
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = 'Jur'#237'dica'
          OnSelect = eTypeRemSelect
          Items.Strings = (
            'Jur'#237'dica'
            'F'#237'sica')
        end
        object eTypeDstn: TComboBox
          Left = 200
          Top = 56
          Width = 81
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft]
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 3
          Text = 'Jur'#237'dica'
          OnSelect = eTypeDstnSelect
          Items.Strings = (
            'Jur'#237'dica'
            'F'#237'sica')
        end
        object lCnpjRem: TStaticText
          Left = 0
          Top = 8
          Width = 193
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'C.N.P.J. do Remetente: '
          FocusControl = eCnpjRem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object lCnpjDstn: TStaticText
          Left = 0
          Top = 56
          Width = 193
          Height = 20
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'C.N.P.J. do Destinat'#225'rio: '
          FocusControl = eCnpjDstn
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
    end
    object lNumNF: TStaticText
      Left = 456
      Top = 32
      Width = 193
      Height = 20
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'N'#250'mero da NF: '
      FocusControl = eNumNF
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object lNumDoc: TStaticText
      Left = 456
      Top = 8
      Width = 193
      Height = 20
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'N'#250'mero do Documento: '
      FocusControl = eNumDoc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object gbPeriod: TGroupBox
      Left = 456
      Top = 56
      Width = 321
      Height = 81
      Caption = 'Per'#237'odo'
      TabOrder = 5
      DesignSize = (
        321
        81)
      object lDtaIni: TStaticText
        Left = 8
        Top = 16
        Width = 185
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Inicial do Documento: '
        FocusControl = eDtaIni
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eDtaIni: TDateEdit
        Left = 200
        Top = 16
        Width = 113
        Height = 21
        NumGlyphs = 2
        TabOrder = 1
      end
      object lDtaFin: TStaticText
        Left = 8
        Top = 48
        Width = 185
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Final do Documento: '
        FocusControl = eDtaFin
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object eDtaFin: TDateEdit
        Left = 200
        Top = 48
        Width = 113
        Height = 21
        NumGlyphs = 2
        TabOrder = 3
      end
    end
  end
end
