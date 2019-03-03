object SelEmpresa: TSelEmpresa
  Left = 307
  Top = 120
  BorderStyle = bsToolWindow
  Caption = 'SelEmpresa'
  ClientHeight = 267
  ClientWidth = 450
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lTitle: TLabel
    Left = 0
    Top = 0
    Width = 450
    Height = 24
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sele'#231#227'o de Empresas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object vtGrid: TVirtualStringTree
    Left = 0
    Top = 24
    Width = 450
    Height = 184
    Align = alClient
    CheckImageKind = ckXP
    Colors.FocusedSelectionBorderColor = clBlue
    Colors.GridLineColor = clSilver
    EditDelay = 0
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Images = Dados.Image16
    Header.Options = [hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    HotCursor = crHandPoint
    Images = Dados.Image16
    RootNodeCount = 5
    SelectionCurveRadius = 4
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
    OnGetText = vtGridGetText
    Columns = <
      item
        ImageIndex = 82
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible]
        Position = 0
        Width = 80
        WideText = 'Coluna'
      end
      item
        ImageIndex = 27
        Position = 1
        Width = 350
        WideText = 'Collumn'
      end>
    WideDefaultText = 'vtGrid'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 248
    Width = 450
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 130
      end>
  end
  object gbControl: TGroupBox
    Left = 0
    Top = 208
    Width = 450
    Height = 40
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      450
      40)
    object sbOk: TSpeedButton
      Left = 65
      Top = 11
      Width = 105
      Height = 22
      Anchors = [akLeft, akTop, akBottom]
      Caption = '&Ok'
      Flat = True
      OnClick = sbOkClick
    end
    object sbCancel: TSpeedButton
      Left = 248
      Top = 11
      Width = 105
      Height = 22
      Anchors = [akTop, akRight, akBottom]
      Caption = '&Cancela'
      Flat = True
      OnClick = sbCancelClick
    end
  end
end
