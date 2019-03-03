object frmSchedule: TfrmSchedule
  Left = 192
  Top = 114
  Width = 377
  Height = 501
  Caption = 'frmSchedule'
  Color = 16776176
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgMain: TPageControl
    Left = 0
    Top = 0
    Width = 369
    Height = 467
    ActivePage = tsVisual
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object tsVisual: TTabSheet
      Caption = 'tsVisual'
      TabVisible = False
    end
    object tsData: TTabSheet
      Caption = 'tsData'
      ImageIndex = 1
      TabVisible = False
    end
  end
end
