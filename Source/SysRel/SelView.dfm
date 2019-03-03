object frmDataView: TfrmDataView
  Left = 194
  Top = 114
  BorderStyle = bsNone
  Caption = 'frmDataView'
  ClientHeight = 404
  ClientWidth = 574
  Color = 16776176
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pOptions: TPanel
    Left = 0
    Top = 0
    Width = 574
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      574
      67)
    object rgPrintOpt: TRadioGroup
      Left = 136
      Top = 8
      Width = 300
      Height = 49
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Selecione o modo de Impress'#227'o'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Tela'
        'Impressora')
      ParentFont = False
      TabOrder = 0
    end
  end
  object vtListData: TVirtualStringTree
    Left = 0
    Top = 67
    Width = 574
    Height = 337
    Align = alClient
    BorderStyle = bsSingle
    Color = 16776176
    Ctl3D = False
    Header.AutoSizeIndex = -1
    Header.Background = 16776176
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = -1
    Header.Options = [hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    HintMode = hmDefault
    IncrementalSearchDirection = sdForward
    ParentCtl3D = False
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toMultiSelect, toRightClickSelect]
    Columns = <>
  end
end
