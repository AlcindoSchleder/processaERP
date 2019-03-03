inherited fmPrdTaxes: TfmPrdTaxes
  Left = 281
  Top = 192
  Caption = 'fmPrdTaxes'
  ClientHeight = 285
  ClientWidth = 591
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object vtTaxes: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 591
    Height = 285
    Align = alClient
    CheckImageKind = ckXP
    Ctl3D = True
    Header.AutoSizeIndex = -1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoDrag, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    ParentCtl3D = False
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnChecked = vtTaxesChecked
    OnGetText = vtTaxesGetText
    OnInitNode = vtTaxesInitNode
    Columns = <
      item
        ImageIndex = 52
        MaxWidth = 580
        Position = 0
        Width = 500
        WideText = 'Empresas / Impostos'
      end>
  end
end
