inherited CdLayOut: TCdLayOut
  Left = 204
  Top = 119
  Width = 800
  Height = 550
  Caption = 'CdLayOut'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 792
  end
  inherited sbStatus: TStatusBar
    Top = 477
    Width = 792
  end
  inherited pgControl: TPageControl
    Width = 792
    Height = 420
    inherited tsData: TTabSheet
      object pInitial: TPanel
        Left = 0
        Top = 0
        Width = 784
        Height = 37
        Align = alTop
        BevelInner = bvLowered
        ParentColor = True
        TabOrder = 0
        DesignSize = (
          784
          37)
        object lFk_Tipo_Documentos: TStaticText
          Left = 8
          Top = 8
          Width = 145
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lFk_Tipo_Documentos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnDblClick = ComponentDblClick
        end
        object eFk_Tipo_Documentos: TComboBox
          Left = 160
          Top = 8
          Width = 619
          Height = 21
          Anchors = [akLeft, akRight]
          ItemHeight = 13
          TabOrder = 1
          Text = 'eFk_Tipo_Documentos'
          OnChange = eFk_Tipo_DocumentosChange
        end
      end
      object vtFields: TVirtualStringTree
        Left = 0
        Top = 37
        Width = 480
        Height = 355
        Align = alClient
        BorderStyle = bsSingle
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
        Header.Options = [hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HintMode = hmDefault
        HotCursor = crHandPoint
        IncrementalSearchDirection = sdForward
        ParentCtl3D = False
        SelectionCurveRadius = 20
        TabOrder = 2
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
        TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
        OnChange = vtFieldsChange
        OnGetText = vtFieldsGetText
        OnPaintText = vtGridPaintText
        Columns = <
          item
            ImageIndex = 47
            Position = 0
            Width = 300
            WideText = 'Descri'#231#227'o'
          end
          item
            ImageIndex = 4
            Position = 1
            Width = 80
            WideText = 'Linha'
          end
          item
            ImageIndex = 65
            Position = 2
            Width = 80
            WideText = 'Coluna'
          end>
        WideDefaultText = 'vtGrid'
      end
      object pData: TPanel
        Left = 480
        Top = 37
        Width = 304
        Height = 355
        Align = alRight
        ParentColor = True
        TabOrder = 1
        DesignSize = (
          304
          355)
        object lLin_Cmp: TStaticText
          Left = 8
          Top = 96
          Width = 81
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lLin_Cmp'
          FocusControl = eLin_Cmp
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = pmFields
          TabOrder = 0
          OnDblClick = ComponentDblClick
        end
        object eLin_Cmp: TCurrencyEdit
          Left = 96
          Top = 96
          Width = 111
          Height = 21
          AutoSize = False
          DecimalPlaces = 0
          DisplayFormat = ',0'
          Anchors = [akRight]
          PopupMenu = pmFields
          TabOrder = 1
          OnDblClick = ComponentDblClick
        end
        object lDivision: TStaticText
          Left = 1
          Top = 1
          Width = 302
          Height = 21
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lDivision'
          FocusControl = eLin_Cmp
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = pmFields
          TabOrder = 2
          OnDblClick = ComponentDblClick
        end
        object lCol_Cmp: TStaticText
          Left = 8
          Top = 128
          Width = 81
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lCol_Cmp'
          FocusControl = eCol_Cmp
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = pmFields
          TabOrder = 3
          OnDblClick = ComponentDblClick
        end
        object eCol_Cmp: TCurrencyEdit
          Left = 96
          Top = 128
          Width = 111
          Height = 21
          AutoSize = False
          DecimalPlaces = 0
          DisplayFormat = ',0'
          Anchors = [akRight]
          PopupMenu = pmFields
          TabOrder = 4
          OnDblClick = ComponentDblClick
        end
        object lFlag_Frmt: TStaticText
          Left = 8
          Top = 160
          Width = 81
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lFlag_Frmt'
          FocusControl = eFlag_Frmt
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = pmFields
          TabOrder = 5
          OnDblClick = ComponentDblClick
        end
        object eFlag_Frmt: TComboBox
          Left = 96
          Top = 160
          Width = 114
          Height = 21
          Anchors = [akLeft, akRight]
          ItemHeight = 13
          TabOrder = 6
        end
        object eFlag_TDoc: TComboBox
          Left = 96
          Top = 192
          Width = 114
          Height = 21
          Anchors = [akLeft, akRight]
          ItemHeight = 13
          TabOrder = 7
        end
        object lFlag_TDoc: TStaticText
          Left = 8
          Top = 192
          Width = 81
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lFlag_TDoc'
          FocusControl = eFlag_TDoc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = pmFields
          TabOrder = 8
          OnDblClick = ComponentDblClick
        end
        object eDsc_Cmp: TEdit
          Left = 96
          Top = 64
          Width = 201
          Height = 21
          Anchors = [akLeft, akRight]
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 9
          OnChange = eDsc_CmpChange
        end
        object lDsc_Cmp: TStaticText
          Left = 8
          Top = 64
          Width = 81
          Height = 21
          Alignment = taCenter
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lDsc_Cmp'
          FocusControl = eDsc_Cmp
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = pmFields
          TabOrder = 10
          OnDblClick = ComponentDblClick
        end
        object lCmp_Cmp: TStaticText
          Left = 8
          Top = 32
          Width = 81
          Height = 21
          Alignment = taCenter
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'lCmp_Cmp'
          FocusControl = eCmp_Cmp
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = pmFields
          TabOrder = 11
          OnDblClick = ComponentDblClick
        end
        object eCmp_Cmp: TEdit
          Left = 95
          Top = 32
          Width = 201
          Height = 21
          Anchors = [akLeft, akRight]
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 12
        end
      end
    end
    inherited tsList: TTabSheet
      inherited SearchPanel: TPanel
        Width = 784
      end
      inherited vtGrid: TVirtualStringTree
        Width = 784
        Height = 338
        WideDefaultText = 'vtGrid'
      end
    end
  end
  inherited cbTools: TCoolBar
    Width = 792
    Bands = <
      item
        Break = False
        Control = tbNavigation
        ImageIndex = 82
        Width = 136
      end
      item
        Break = False
        Control = tbOperations
        HorizontalOnly = True
        ImageIndex = 91
        Text = 'Ferramentas'
        Width = 650
      end>
    inherited tbOperations: TToolBar
      Width = 573
    end
  end
  inherited dsMain: TDataManager
    BeforePost = dsMainBeforePost
  end
end
