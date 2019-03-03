object frmViewHistoric: TfrmViewHistoric
  Left = 191
  Top = 114
  Width = 800
  Height = 550
  Caption = 'frmHistorics'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 41
    Bands = <
      item
        Control = tbTools
        ImageIndex = 92
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
      ButtonWidth = 64
      Caption = 'tbTools'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbFirst: TToolButton
        Left = 0
        Top = 0
        Caption = '&In'#237'cio'
        ImageIndex = 31
        OnClick = tbFirstClick
      end
      object tbPrior: TToolButton
        Left = 64
        Top = 0
        Caption = '&Anterior'
        ImageIndex = 30
        OnClick = tbPriorClick
      end
      object tbNext: TToolButton
        Left = 128
        Top = 0
        Caption = '&Pr'#243'ximo'
        ImageIndex = 32
        OnClick = tbNextClick
      end
      object tbLast: TToolButton
        Left = 192
        Top = 0
        Caption = '&'#218'ltimo'
        ImageIndex = 29
        OnClick = tbLastClick
      end
      object tbNavSep: TToolButton
        Left = 256
        Top = 0
        Width = 8
        Caption = 'tbNavSep'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbSearch: TToolButton
        Left = 264
        Top = 0
        Caption = 'Pes&quisar'
        DropdownMenu = pmSearchButton
        ImageIndex = 90
        MenuItem = pmSearch
        Style = tbsDropDown
        OnClick = tbSearchClick
      end
      object tbSchSep: TToolButton
        Left = 341
        Top = 0
        Width = 8
        Caption = 'tbSchSep'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 349
        Top = 0
        Caption = 'Sai&r'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
    end
  end
  object pSearch: TPanel
    Left = 0
    Top = 41
    Width = 792
    Height = 136
    Align = alTop
    Color = clWindow
    TabOrder = 1
    DesignSize = (
      792
      136)
    object lSelOpe: TStaticText
      Left = 8
      Top = 8
      Width = 153
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Operador: '
      FocusControl = eSelOpe
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object pDtaIni: TPanel
      Left = 624
      Top = 3
      Width = 137
      Height = 41
      Anchors = [akRight]
      BevelInner = bvLowered
      ParentColor = True
      TabOrder = 1
      DesignSize = (
        137
        41)
      object eDtaIni: TDateEdit
        Left = 8
        Top = 6
        Width = 121
        Height = 21
        Anchors = [akLeft, akRight]
        NumGlyphs = 2
        PopupColor = clWindow
        TabOrder = 0
      end
      object tbCtrlDtaIni: TTrackBar
        Left = 5
        Top = 27
        Width = 127
        Height = 13
        HelpContext = 1
        Anchors = [akLeft, akRight]
        Ctl3D = True
        Max = 0
        ParentCtl3D = False
        TabOrder = 1
        ThumbLength = 8
        TickMarks = tmTopLeft
        TickStyle = tsNone
        OnChange = tbCtrlDtaIniChange
      end
    end
    object lDtaIni: TStaticText
      Left = 464
      Top = 8
      Width = 153
      Height = 21
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
      TabOrder = 2
    end
    object lDtaFin: TStaticText
      Left = 464
      Top = 72
      Width = 153
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Data Final: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object lSelTable: TStaticText
      Left = 8
      Top = 32
      Width = 153
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Tabela: '
      FocusControl = eSelTable
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object clbSelOperations: TCheckListBox
      Left = 168
      Top = 56
      Width = 289
      Height = 73
      Anchors = [akLeft, akRight]
      AutoComplete = False
      HeaderColor = clBlue
      HeaderBackgroundColor = 16776176
      ItemHeight = 13
      Items.Strings = (
        'Selecione as Opera'#231#245'es '#224' pesquisar'
        'Todas'
        'Inser'#231#227'o'
        'Edi'#231#227'o'
        'Exclus'#227'o')
      Style = lbOwnerDrawFixed
      TabOrder = 5
      OnDrawItem = clbSelOperationsDrawItem
    end
    object lSelOperations: TStaticText
      Left = 8
      Top = 56
      Width = 153
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Tipos de Opera'#231#245'es: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object pDtaFin: TPanel
      Left = 624
      Top = 67
      Width = 137
      Height = 41
      Anchors = [akRight]
      BevelInner = bvLowered
      ParentColor = True
      TabOrder = 7
      DesignSize = (
        137
        41)
      object eDtaFin: TDateEdit
        Left = 8
        Top = 6
        Width = 121
        Height = 21
        Anchors = [akLeft, akRight]
        NumGlyphs = 2
        PopupColor = clWindow
        TabOrder = 0
      end
      object tbCtrlDtaFin: TTrackBar
        Left = 5
        Top = 27
        Width = 127
        Height = 13
        Anchors = [akLeft, akRight]
        Ctl3D = True
        Max = 0
        ParentCtl3D = False
        TabOrder = 1
        ThumbLength = 8
        TickMarks = tmTopLeft
        TickStyle = tsNone
        OnChange = tbCtrlDtaFinChange
      end
    end
    object eHorIni: TDateTimePicker
      Left = 624
      Top = 46
      Width = 138
      Height = 21
      Date = 38764.064395254630000000
      Time = 38764.064395254630000000
      ShowCheckbox = True
      Checked = False
      Kind = dtkTime
      TabOrder = 8
      Visible = False
      OnChange = eHorIniChange
    end
    object eHorFin: TDateTimePicker
      Left = 624
      Top = 110
      Width = 138
      Height = 21
      Date = 38764.064395254630000000
      Time = 38764.064395254630000000
      ShowCheckbox = True
      Checked = False
      Kind = dtkTime
      TabOrder = 9
      Visible = False
      OnChange = eHorFinChange
    end
    object eSelOpe: TPrcComboBox
      Left = 168
      Top = 8
      Width = 289
      Height = 21
      BevelKind = bkNone
      CompareMethod = 'ComparePk'
      GetPkMethod = 'GetPkValue'
      ItemHeight = 13
      TabOrder = 10
      TypeObject = toObject
    end
    object eSelTable: TPrcComboBox
      Left = 168
      Top = 32
      Width = 289
      Height = 21
      BevelKind = bkNone
      CompareMethod = 'ComparePk'
      GetPkMethod = 'GetPkValue'
      ItemHeight = 13
      TabOrder = 11
      TypeObject = toObject
    end
  end
  object vtSearch: TVirtualStringTree
    Left = 0
    Top = 177
    Width = 792
    Height = 326
    Align = alClient
    Header.AutoSizeIndex = 5
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = 1
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    TabOrder = 2
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnBeforeItemErase = vtSearchBeforeItemErase
    OnCompareNodes = vtSearchCompareNodes
    OnGetText = vtSearchGetText
    OnPaintText = vtSearchPaintText
    OnHeaderClick = vtSearchHeaderClick
    Columns = <
      item
        ImageIndex = 8
        Position = 0
        Width = 100
        WideText = 'Operador'
      end
      item
        ImageIndex = 91
        Position = 1
        Width = 150
        WideText = 'Arquivo'
      end
      item
        ImageIndex = 21
        Position = 2
        Width = 150
        WideText = 'Data/Hora'
      end
      item
        ImageIndex = 27
        Position = 3
        Width = 100
        WideText = 'Formul'#225'rio'
      end
      item
        ImageIndex = 47
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
        Position = 4
        Width = 288
        WideText = 'Opera'#231#227'o'
      end>
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 503
    Width = 792
    Height = 19
    Panels = <
      item
        Width = 270
      end
      item
        Style = psOwnerDraw
        Width = 250
      end
      item
        Style = psOwnerDraw
        Width = 80
      end>
    ParentColor = True
    ParentShowHint = False
    ShowHint = True
    OnDrawPanel = sbStatusDrawPanel
  end
  object pmSearchButton: TPopupMenu
    Left = 512
    Top = 73
    object pmSearch: TMenuItem
      Caption = 'Pes&quisar'
      ImageIndex = 90
    end
    object pmNewSearch: TMenuItem
      Caption = '&Nova Pesquisa'
      ImageIndex = 43
    end
  end
end
