object CdReports: TCdReports
  Left = 197
  Top = 111
  Width = 800
  Height = 550
  Caption = 'CdReports'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 265
    Top = 41
    Width = 8
    Height = 462
    Beveled = True
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 41
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        MinHeight = 33
        Text = 'Ferramentas'
        Width = 788
      end>
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 711
      Height = 33
      ButtonHeight = 19
      ButtonWidth = 54
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
      object tbDelete: TToolButton
        Left = 54
        Top = 0
        Caption = 'Excluir'
        ImageIndex = 33
        OnClick = tbDeleteClick
      end
      object tbCancel: TToolButton
        Left = 108
        Top = 0
        Caption = 'Cancelar'
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbSepOper: TToolButton
        Left = 162
        Top = 0
        Width = 8
        ImageIndex = 7
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 170
        Top = 0
        Caption = 'Salvar'
        DropdownMenu = pmSave
        ImageIndex = 36
        Style = tbsDropDown
        OnClick = tbSaveClick
      end
      object tbSepSave: TToolButton
        Left = 237
        Top = 0
        Width = 8
        ImageIndex = 42
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 245
        Top = 0
        Hint = 'Fechar | Fecha o programa'
        Caption = 'Sair'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
      object tbSepClose: TToolButton
        Left = 299
        Top = 0
        Width = 8
        ImageIndex = 42
        Style = tbsSeparator
      end
      object tbDesignEdit: TToolButton
        Left = 307
        Top = 0
        Caption = 'Design'
        DropdownMenu = pmDesigner
        ImageIndex = 0
        Style = tbsDropDown
        OnClick = tbDesignEditClick
      end
      object tbSepDesign: TToolButton
        Left = 374
        Top = 0
        Width = 8
        ImageIndex = 58
        Style = tbsSeparator
      end
      object tbReportOptions: TToolButton
        Left = 382
        Top = 0
        Caption = 'Op'#231#245'es'
        DropdownMenu = pmReportOpt
        ImageIndex = 13
        Style = tbsDropDown
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 503
    Width = 792
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 300
      end
      item
        Width = 100
      end>
    OnClick = sbStatusClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
  object vtGrid: TVirtualStringTree
    Left = 0
    Top = 41
    Width = 265
    Height = 462
    Align = alLeft
    BevelKind = bkFlat
    BorderStyle = bsNone
    CheckImageKind = ckXP
    Colors.FocusedSelectionColor = 6730751
    Colors.FocusedSelectionBorderColor = clBtnShadow
    Colors.GridLineColor = clSilver
    Colors.SelectionRectangleBlendColor = 6730751
    Colors.UnfocusedSelectionColor = 6730751
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
    SelectionCurveRadius = 20
    TabOrder = 2
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    OnDblClick = vtGridDblClick
    OnFocusChanged = vtGridFocusChanged
    OnFocusChanging = vtGridFocusChanging
    OnGetText = vtGridGetText
    OnGetImageIndex = vtGridGetImageIndex
    Columns = <
      item
        ImageIndex = 75
        Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coVisible]
        Position = 0
        Width = 240
        WideText = 'Relat'#243'rios dos M'#243'dulos'
      end>
    WideDefaultText = ''
  end
  object pgReport: TPageControl
    Left = 273
    Top = 41
    Width = 519
    Height = 462
    ActivePage = tsDesigner
    Align = alClient
    TabOrder = 3
    object tsDesigner: TTabSheet
      Caption = 'tsDesigner'
      TabVisible = False
      object sbDesigner: TScrollBox
        Left = 0
        Top = 0
        Width = 511
        Height = 452
        HorzScrollBar.Position = 534
        HorzScrollBar.Range = 1024
        HorzScrollBar.Size = 1204
        VertScrollBar.Range = 780
        VertScrollBar.Size = 780
        VertScrollBar.Style = ssFlat
        VertScrollBar.Tracking = True
        Align = alClient
        AutoScroll = False
        BevelOuter = bvNone
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
      end
    end
    object tsData: TTabSheet
      Caption = 'tsData'
      ImageIndex = 1
      TabVisible = False
      DesignSize = (
        511
        452)
      object lPk_Produtos: TStaticText
        Left = 8
        Top = 7
        Width = 145
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' C'#243'digo:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object ePk_Relatorios: TCurrencyEdit
        Left = 160
        Top = 7
        Width = 73
        Height = 21
        AutoSize = False
        Color = clTeal
        DecimalPlaces = 0
        DisplayFormat = ',0;- ,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Anchors = [akLeft, akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object lFlag_Graph: TCheckBox
        Left = 296
        Top = 7
        Width = 209
        Height = 17
        Anchors = [akRight]
        Caption = 'Gerar Gr'#225'fico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = eDsc_RelChange
      end
      object eDsc_Rel: TEdit
        Left = 160
        Top = 54
        Width = 345
        Height = 21
        Anchors = [akLeft, akRight]
        MaxLength = 50
        TabOrder = 3
        OnChange = eDsc_RelChange
      end
      object lDsc_Prod: TStaticText
        Left = 8
        Top = 54
        Width = 145
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Descri'#231#227'o do Relat.:'
        FocusControl = eDsc_Rel
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object lDsc_Graph: TStaticText
        Left = 8
        Top = 100
        Width = 145
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Descri'#231#227'o do Gr'#225'fico:'
        FocusControl = eDsc_Graph
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object eDsc_Graph: TEdit
        Left = 160
        Top = 100
        Width = 343
        Height = 21
        Anchors = [akLeft, akRight]
        MaxLength = 50
        TabOrder = 6
        OnChange = eDsc_RelChange
      end
      object pgGraph: TPageControl
        Left = 0
        Top = 134
        Width = 511
        Height = 318
        ActivePage = tsGraph
        Align = alBottom
        Style = tsFlatButtons
        TabOrder = 7
        object tsGraphSql: TTabSheet
          Caption = 'Sql para Gr'#225'fico'
          object eSql_Graph: TMemo
            Left = 0
            Top = 0
            Width = 503
            Height = 287
            Align = alClient
            TabOrder = 0
          end
        end
        object tsGraph: TTabSheet
          Caption = 'Gr'#225'fico'
          ImageIndex = 1
          object Chart1: TChart
            Left = 0
            Top = 0
            Width = 503
            Height = 287
            BackWall.Brush.Color = clWhite
            BackWall.Brush.Style = bsClear
            Title.Text.Strings = (
              'TChart')
            Align = alClient
            TabOrder = 0
            object Series1: TBarSeries
              Marks.ArrowLength = 20
              Marks.Visible = True
              SeriesColor = clRed
              XValues.DateTime = False
              XValues.Name = 'X'
              XValues.Multiplier = 1.000000000000000000
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Bar'
              YValues.Multiplier = 1.000000000000000000
              YValues.Order = loNone
            end
            object Series2: TFastLineSeries
              Marks.ArrowLength = 8
              Marks.Visible = False
              SeriesColor = clGreen
              LinePen.Color = clGreen
              XValues.DateTime = False
              XValues.Name = 'X'
              XValues.Multiplier = 1.000000000000000000
              XValues.Order = loAscending
              YValues.DateTime = False
              YValues.Name = 'Y'
              YValues.Multiplier = 1.000000000000000000
              YValues.Order = loNone
            end
          end
        end
      end
      object lFlag_Matrix: TCheckBox
        Left = 296
        Top = 24
        Width = 209
        Height = 17
        Anchors = [akRight]
        Caption = 'Impres'#227'o Matricial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = eDsc_RelChange
      end
    end
  end
  object frDesigner: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    Restrictions = []
    RTLLanguage = False
    OnSaveReport = frDesignerSaveReport
    Left = 341
    Top = 79
  end
  object pmReportOpt: TPopupMenu
    Left = 437
    Top = 79
    object pmPageSettings: TMenuItem
      Caption = 'pmPageSettings'
    end
    object pmToolBars: TMenuItem
      Caption = 'pmToolBars'
      object pmStandart: TMenuItem
        Caption = 'pmStandart'
        OnClick = pmToolBarsClick
      end
      object pmText: TMenuItem
        Caption = 'pmText'
        OnClick = pmToolBarsClick
      end
      object pmFrame: TMenuItem
        Caption = 'pmFrame'
        OnClick = pmToolBarsClick
      end
      object pmAlignment: TMenuItem
        Caption = 'pmAlignment'
        OnClick = pmToolBarsClick
      end
      object pmTools: TMenuItem
        Caption = 'pmTools'
        OnClick = pmToolBarsClick
      end
      object pmInspector: TMenuItem
        Caption = 'pmInspector'
        OnClick = pmToolBarsClick
      end
      object pmDataTree: TMenuItem
        Caption = 'pmDataTree'
        OnClick = pmToolBarsClick
      end
      object pmReportTree: TMenuItem
        Caption = 'pmReportTree'
        OnClick = pmToolBarsClick
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object pmShowRulers: TMenuItem
      Caption = 'pmShowRulers'
    end
    object pmShowGuides: TMenuItem
      Caption = 'pmShowGuides'
    end
    object pmDeleteGuides: TMenuItem
      Caption = 'pmDeleteGuides'
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object pmOptions: TMenuItem
      Caption = 'pmOptions'
    end
  end
  object odReport: TOpenDialog
    DefaultExt = '*.fr3'
    Filter = 'Fast Report Templates|*.fr3'
    InitialDir = '.\Templates'
    Left = 469
    Top = 79
  end
  object pmSave: TPopupMenu
    Left = 405
    Top = 79
    object pmSaveAs: TMenuItem
      Caption = 'Salvar &Como'
      OnClick = pmSaveAsClick
    end
  end
  object pmDesigner: TPopupMenu
    Left = 373
    Top = 79
    object pmDesignClose: TMenuItem
      Caption = 'Fechar Designer'
      OnClick = pmDesignCloseClick
    end
  end
end
