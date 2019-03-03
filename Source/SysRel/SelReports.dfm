object frmPrgReports: TfrmPrgReports
  Left = 194
  Top = 114
  BorderStyle = bsNone
  Caption = 'frmPrgReports'
  ClientHeight = 370
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object vtReportList: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 566
    Height = 370
    Align = alClient
    Color = 16776176
    Ctl3D = False
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clBlue
    Header.Font.Height = -13
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = [fsBold]
    Header.Height = 28
    Header.Options = [hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    ParentCtl3D = False
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnFocusChanged = vtReportListFocusChanged
    OnGetText = vtReportListGetText
    Columns = <
      item
        MaxWidth = 535
        Position = 0
        Width = 535
        WideText = 'Sele'#231#227'o dos Modelos de Relat'#243'rios existentes para %s'
      end>
  end
end
