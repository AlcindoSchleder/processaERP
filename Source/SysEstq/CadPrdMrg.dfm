inherited fmProdMargins: TfmProdMargins
  Left = 278
  Top = 191
  Caption = 'fmProdMargins'
  ClientHeight = 267
  ClientWidth = 594
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object vtPrices: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 594
    Height = 267
    Align = alClient
    CheckImageKind = ckXP
    Colors.FocusedSelectionColor = clSilver
    Colors.SelectionRectangleBlendColor = 33023
    EditDelay = 0
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    SelectionCurveRadius = 10
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toAutoChangeScale]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines]
    TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
    WantTabs = True
    OnAfterCellPaint = vtPricesBeforeCellPaint
    OnBeforeCellPaint = vtPricesBeforeCellPaint
    OnColumnClick = vtPricesColumnClick
    OnEditing = vtPricesEditing
    OnFocusChanged = vtPricesFocusChanged
    OnFocusChanging = vtPricesFocusChanging
    OnGetText = vtPricesGetText
    OnPaintText = vtPricesPaintText
    OnNewText = vtPricesNewText
    Columns = <
      item
        ImageIndex = 52
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
        Position = 0
        Width = 230
        WideText = 'Tabela de Pre'#231'os / Empresas'
      end
      item
        Alignment = taRightJustify
        ImageIndex = 39
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
        Position = 1
        Width = 90
        WideText = 'Pre'#231'o'
      end
      item
        Alignment = taCenter
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
        Position = 2
        Width = 60
        WideText = 'Fixo'
      end
      item
        Alignment = taCenter
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
        Position = 3
        Width = 40
        WideText = 'ST'
      end
      item
        Alignment = taCenter
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
        Position = 4
        Width = 100
        WideText = 'Class. Fiscal'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
        Position = 5
        Width = 70
        WideText = 'Margem'
      end>
    WideDefaultText = ''
  end
end
