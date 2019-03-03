inherited CdPedVinc: TCdPedVinc
  Left = 199
  Top = 191
  Caption = 'CdPedVinc'
  ClientHeight = 95
  ClientWidth = 737
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object vtItems: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 737
    Height = 95
    Align = alClient
    EditDelay = 0
    Header.AutoSizeIndex = 1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toMiddleClickSelect, toRightClickSelect]
    WantTabs = True
    OnEditing = vtItemsEditing
    OnGetText = vtItemsGetText
    OnNewText = vtItemsNewText
    Columns = <
      item
        Alignment = taRightJustify
        ImageIndex = 19
        Position = 0
        Width = 100
        WideText = 'N'#250'mero'
      end
      item
        ImageIndex = 46
        Position = 1
        Width = 633
        WideText = 'Nome'
      end>
  end
end
