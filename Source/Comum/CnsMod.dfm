object CnsModelo: TCnsModelo
  Left = 368
  Top = 146
  Width = 800
  Height = 550
  Caption = 'CnsModelo'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object sbStatus: TStatusBar
    Left = 0
    Top = 497
    Width = 792
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Style = psOwnerDraw
        Text = 'Empresa'
        Width = 300
      end
      item
        Style = psOwnerDraw
        Width = 100
      end>
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 33
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 788
      end>
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 711
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 104
      Caption = 'tbTools'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbInsert: TToolButton
        Left = 0
        Top = 0
        Hint = 'Buscar | Selecioar Registros dos Par'#226'metros'
        Caption = 'Buscar'
        ImageIndex = 34
      end
      object tbCancel: TToolButton
        Left = 104
        Top = 0
        Hint = 'Nova Busca | Limpa os par'#226'metros'
        Caption = 'Nova'
        ImageIndex = 28
      end
      object tbSepCopy: TToolButton
        Left = 208
        Top = 0
        Width = 8
        Caption = 'tbSepCopy'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbCopy: TToolButton
        Left = 216
        Top = 0
        Caption = 'Copiar Selecionado'
        ImageIndex = 42
      end
      object tbSepClose: TToolButton
        Left = 320
        Top = 0
        Width = 8
        Caption = 'tbSepClose'
        ImageIndex = 42
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 328
        Top = 0
        Hint = 'Sair [Esc] | Fecha a janela'
        Caption = 'Sair'
        ImageIndex = 41
      end
    end
  end
  object pgParameters: TPageControl
    Left = 0
    Top = 33
    Width = 792
    Height = 144
    ActivePage = tsParameters
    Align = alTop
    TabOrder = 2
    object tsParameters: TTabSheet
      Caption = 'Pr'#226'metros da Busca'
    end
  end
  object vtList: TVirtualStringTree
    Left = 0
    Top = 177
    Width = 792
    Height = 320
    Align = alClient
    Colors.BorderColor = clScrollBar
    Colors.DropTargetColor = clActiveBorder
    Colors.DropTargetBorderColor = clActiveCaption
    Colors.FocusedSelectionColor = clSilver
    Colors.UnfocusedSelectionBorderColor = clBtnShadow
    DrawSelectionMode = smBlendedRectangle
    Header.AutoSizeIndex = -1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = 1
    Header.Options = [hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.SortColumn = 1
    Header.Style = hsXPStyle
    HintAnimation = hatFade
    HintMode = hmTooltip
    HotCursor = crHandPoint
    IncrementalSearch = isVisibleOnly
    SelectionCurveRadius = 10
    TabOrder = 3
    TreeOptions.AnimationOptions = [toAnimatedToggle]
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoSpanColumns, toAutoTristateTracking, toAutoHideButtons, toDisableAutoscrollOnFocus, toAutoChangeScale]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMiddleClickSelect, toMultiSelect, toRightClickSelect]
    OnBeforeItemErase = vtListBeforeItemErase
    OnCompareNodes = vtListCompareNodes
    OnFocusChanging = vtListFocusChanging
    OnGetText = vtListGetText
    OnGetImageIndexEx = vtListGetImageIndexEx
    OnGetNodeDataSize = vtListGetNodeDataSize
    OnHeaderClick = vtListHeaderClick
    OnIncrementalSearch = vtListIncrementalSearch
    OnStateChange = vtListStateChange
    Columns = <
      item
        Color = 16744576
        Options = [coEnabled, coParentBidiMode, coVisible, coAutoSpring]
        Position = 0
        Spacing = 0
        Width = 24
      end
      item
        Position = 1
        Width = 200
        WideText = 'Descri'#231#227'o'
      end>
  end
end
