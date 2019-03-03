object frmSquares: TfrmSquares
  Left = 188
  Top = 119
  Width = 800
  Height = 550
  Caption = 'frmSquares'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spDiv: TSplitter
    Left = 395
    Top = 33
    Width = 5
    Height = 470
    Align = alRight
    Beveled = True
    ResizeStyle = rsNone
  end
  object pSquare: TPanel
    Left = 0
    Top = 33
    Width = 395
    Height = 470
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 0
      Top = 225
      Width = 395
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Beveled = True
    end
    object pgSquare: TPageControl
      Left = 0
      Top = 0
      Width = 395
      Height = 225
      ActivePage = tsSquareList
      Align = alTop
      Style = tsFlatButtons
      TabOrder = 0
      object tsSquareList: TTabSheet
        Caption = 'tsSquareList'
        TabVisible = False
        object vtSquare: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 387
          Height = 215
          Align = alClient
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clBlue
          Header.Font.Height = -16
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = [fsBold]
          Header.Height = 26
          Header.Options = [hoAutoResize, hoHotTrack, hoShowImages, hoVisible]
          Header.Style = hsXPStyle
          HintAnimation = hatNone
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect]
          OnDblClick = vtSquareDblClick
          OnFocusChanged = vtSquareFocusChanged
          OnGetText = vtSquareGetText
          Columns = <
            item
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coVisible]
              Position = 0
              Width = 383
              WideText = 'Pra'#231'as e Pistas'
            end>
        end
      end
      object tsSquareData: TTabSheet
        Caption = 'tsSquareData'
        ImageIndex = 1
        TabVisible = False
      end
      object tsTrackData: TTabSheet
        ImageIndex = 2
        TabVisible = False
      end
    end
    object pgOccurrence: TPageControl
      Left = 0
      Top = 230
      Width = 395
      Height = 240
      ActivePage = tsOccursList
      Align = alClient
      TabOrder = 1
      object tsOccursList: TTabSheet
        Caption = 'tsOccursList'
        TabVisible = False
        object vtOccurrence: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 387
          Height = 230
          Align = alClient
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clBlue
          Header.Font.Height = -16
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = [fsBold]
          Header.Height = 26
          Header.Options = [hoAutoResize, hoHotTrack, hoShowImages, hoVisible]
          Header.Style = hsXPStyle
          HintAnimation = hatNone
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect]
          OnChecked = vtOccurrenceChecked
          OnDblClick = vtOccurrenceDblClick
          OnGetText = vtOccurrenceGetText
          OnInitNode = vtOccurrenceInitNode
          Columns = <
            item
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coVisible]
              Position = 0
              Width = 383
              WideText = 'Tipos de Ocorr'#234'ncias'
            end>
        end
      end
      object tsOccursData: TTabSheet
        Caption = 'tsOccursData'
        ImageIndex = 1
        TabVisible = False
      end
    end
  end
  object pConfiguration: TPanel
    Left = 400
    Top = 33
    Width = 392
    Height = 470
    Align = alRight
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object spCatOper: TSplitter
      Left = 0
      Top = 225
      Width = 392
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Beveled = True
    end
    object pgOperators: TPageControl
      Left = 0
      Top = 230
      Width = 392
      Height = 240
      ActivePage = tsOperList
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object tsOperList: TTabSheet
        Caption = 'tsOperList'
        TabVisible = False
        object vtOperators: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 384
          Height = 230
          Align = alClient
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clBlue
          Header.Font.Height = -16
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = [fsBold]
          Header.Height = 26
          Header.Options = [hoAutoResize, hoHotTrack, hoShowImages, hoVisible]
          Header.Style = hsXPStyle
          HintAnimation = hatNone
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect]
          OnDblClick = vtOperatorsDblClick
          OnGetText = vtOperatorsGetText
          Columns = <
            item
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coVisible]
              Position = 0
              Width = 380
              WideText = 'Operadores'
            end>
        end
      end
      object tsOperData: TTabSheet
        Caption = 'tsOperData'
        ImageIndex = 1
        TabVisible = False
      end
    end
    object pgCategory: TPageControl
      Left = 0
      Top = 0
      Width = 392
      Height = 225
      ActivePage = tsCategoryList
      Align = alTop
      Style = tsFlatButtons
      TabOrder = 1
      object tsCategoryList: TTabSheet
        Caption = 'tsCategoryList'
        TabVisible = False
        object vtCategory: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 384
          Height = 215
          Align = alClient
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clBlue
          Header.Font.Height = -16
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = [fsBold]
          Header.Height = 26
          Header.Options = [hoAutoResize, hoHotTrack, hoShowImages, hoVisible]
          Header.Style = hsXPStyle
          HintAnimation = hatNone
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect]
          OnDblClick = vtCategoryDblClick
          OnGetText = vtCategoryGetText
          Columns = <
            item
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coVisible]
              Position = 0
              Width = 280
              WideText = 'Categorias'
            end
            item
              Alignment = taRightJustify
              Position = 1
              Width = 100
              WideText = 'Valor'
            end>
        end
      end
      object tsCategoryData: TTabSheet
        Caption = 'tsCategoryData'
        ImageIndex = 1
        TabVisible = False
      end
    end
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 33
    Bands = <
      item
        Control = tbOperations
        ImageIndex = 82
        Text = 'Ferramentas'
        Width = 409
      end
      item
        Break = False
        Control = tbActiveGrid
        ImageIndex = 42
        Text = 'Grade Ativa'
        Width = 377
      end>
    object tbOperations: TToolBar
      Left = 73
      Top = 0
      Width = 332
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 60
      Caption = 'tbOperations'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbInsert: TToolButton
        Left = 0
        Top = 0
        Caption = '&Inserir'
        ImageIndex = 34
        OnClick = tbInsertClick
      end
      object tbCancel: TToolButton
        Left = 60
        Top = 0
        Caption = '&Cancelar'
        Enabled = False
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbDelete: TToolButton
        Left = 120
        Top = 0
        Caption = '&Excluir'
        Enabled = False
        ImageIndex = 33
      end
      object tbTollSep: TToolButton
        Left = 180
        Top = 0
        Width = 8
        Caption = 'tbTollSep'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 188
        Top = 0
        Caption = '&Salvar'
        Enabled = False
        ImageIndex = 36
        OnClick = tbSaveClick
      end
    end
    object tbActiveGrid: TToolBar
      Left = 482
      Top = 0
      Width = 302
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 36
      Caption = 'tbActiveGrid'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 1
      object tbClose: TToolButton
        Left = 0
        Top = 0
        Hint = 'Sair | Sair do Programa'
        Caption = 'Sai&r'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
      object tbGridSep: TToolButton
        Left = 36
        Top = 0
        Width = 8
        Caption = 'tbGridSep'
        Style = tbsSeparator
      end
      object cbActiveGrid: TComboBox
        Left = 44
        Top = 0
        Width = 209
        Height = 21
        Hint = 'Sele'#231#227'o da Grade | Seleciona a grade para alterar os dados'
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Pra'#231'as'
        OnSelect = cbActiveGridSelect
        Items.Strings = (
          'Pra'#231'as'
          'Pistas'
          'Categorias'
          'Operadores'
          'Ocorr'#234'ncias')
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
        Width = 350
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
end
