object CdProgramas: TCdProgramas
  Left = 193
  Top = 115
  Width = 800
  Height = 550
  Caption = 'CdProgramas'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object sSplitter: TSplitter
    Left = 393
    Top = 33
    Width = 5
    Height = 470
    Beveled = True
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
      ButtonWidth = 54
      EdgeBorders = []
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbSep: TToolButton
        Left = 0
        Top = 0
        Width = 8
        Caption = 'tbSep'
        ImageIndex = 42
        Style = tbsSeparator
      end
      object tbNew: TToolButton
        Left = 8
        Top = 0
        Caption = 'Novo'
        DropdownMenu = pmNewMenu
        ImageIndex = 82
        Style = tbsDropDown
        OnClick = tbNewClick
      end
      object tbDel: TToolButton
        Left = 75
        Top = 0
        Hint = 'Excluir | Exclui o registro atual'
        Caption = 'Excluir'
        Enabled = False
        ImageIndex = 33
        OnClick = tbDelClick
      end
      object tbCancel: TToolButton
        Left = 129
        Top = 0
        Caption = 'Cancelar'
        Enabled = False
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbSepOpe: TToolButton
        Left = 183
        Top = 0
        Width = 8
        Caption = 'tbSepOpe'
        ImageIndex = 42
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 191
        Top = 0
        Hint = 'Salvar | Salva as Altera'#231#245'es'
        Caption = 'Salvar'
        Enabled = False
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object tbSepNav: TToolButton
        Left = 245
        Top = 0
        Width = 8
        Caption = 'tbSepNav'
        ImageIndex = 42
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 253
        Top = 0
        Hint = 'Fechar | Fecha o programa'
        Caption = 'Sai&r'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
    end
  end
  object pgControl: TPageControl
    Left = 398
    Top = 33
    Width = 394
    Height = 470
    ActivePage = tsModules
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object tsModules: TTabSheet
      Caption = 'tsModules'
      ImageIndex = 1
      TabVisible = False
    end
    object tsRotines: TTabSheet
      Caption = 'tsRotines'
      ImageIndex = 1
      TabVisible = False
      object vtEditGrid: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 393
        Height = 454
        Align = alLeft
        CheckImageKind = ckXP
        Colors.FocusedSelectionColor = 6730751
        Colors.FocusedSelectionBorderColor = clBtnShadow
        Colors.GridLineColor = clSilver
        Colors.SelectionRectangleBlendColor = 6730751
        Colors.UnfocusedSelectionColor = 6730751
        EditDelay = 0
        Header.AutoSizeIndex = 1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clBlue
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HotCursor = crHandPoint
        SelectionCurveRadius = 20
        TabOrder = 0
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
        TreeOptions.MiscOptions = [toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus]
        OnEdited = vtEditGridEdited
        OnFocusChanged = vtEditGridFocusChanged
        OnFocusChanging = vtEditGridFocusChanging
        OnGetText = vtEditGridGetText
        OnGetImageIndex = vtEditGridGetImageIndex
        OnNewText = vtEditGridNewText
        Columns = <
          item
            ImageIndex = 75
            Position = 0
            Width = 100
            WideText = 'C'#243'd. Rotina'
          end
          item
            Position = 1
            Width = 293
            WideText = 'Descri'#231#227'o'
          end>
        WideDefaultText = ''
      end
    end
    object tsPrograms: TTabSheet
      Caption = 'tsPrograms'
      ImageIndex = 2
      TabVisible = False
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 503
    Width = 792
    Height = 19
    Color = clWindow
    Panels = <
      item
        Width = 300
      end
      item
        Style = psOwnerDraw
        Width = 300
      end
      item
        Style = psOwnerDraw
        Width = 100
      end>
    OnClick = sbStatusClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
  object vtGrid: TVirtualStringTree
    Left = 0
    Top = 33
    Width = 393
    Height = 470
    Align = alLeft
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
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    HotCursor = crHandPoint
    SelectionCurveRadius = 20
    TabOrder = 3
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    OnFocusChanged = vtGridFocusChanged
    OnFocusChanging = vtGridFocusChanging
    OnGetText = vtGridGetText
    OnPaintText = vtGridPaintText
    OnGetImageIndex = vtGridGetImageIndex
    Columns = <
      item
        ImageIndex = 75
        Position = 0
        Width = 389
        WideText = 'Items'
      end>
    WideDefaultText = ''
  end
  object pmNewMenu: TPopupMenu
    Left = 224
    Top = 88
    object pmNewLng: TMenuItem
      Caption = 'Nova &Linguagem'
      ImageIndex = 87
      OnClick = pmNewLngClick
    end
    object pmNewMod: TMenuItem
      Tag = 1
      Caption = 'Novo &M'#243'dulo'
      ImageIndex = 85
      OnClick = pmNewModClick
    end
    object pmNewRot: TMenuItem
      Tag = 2
      Caption = 'Nova &Rotina'
      ImageIndex = 82
      OnClick = pmNewRotClick
    end
    object pmNewPrg: TMenuItem
      Tag = 3
      Caption = 'Novo &Programa'
      ImageIndex = 27
      OnClick = pmNewPrgClick
    end
  end
end
