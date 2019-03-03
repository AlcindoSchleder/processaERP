object dgVersion: TdgVersion
  Left = 342
  Top = 259
  BorderStyle = bsToolWindow
  Caption = 'dgVersion'
  ClientHeight = 136
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lRefPart: TLabel
    Left = 39
    Top = 42
    Width = 38
    Height = 13
    Alignment = taRightJustify
    Caption = 'lRefPart'
    Visible = False
  end
  object lVersion: TLabel
    Left = 40
    Top = 68
    Width = 37
    Height = 13
    Alignment = taRightJustify
    Caption = 'lVersion'
  end
  object sbCancel: TSpeedButton
    Left = 112
    Top = 91
    Width = 97
    Height = 22
    Caption = 'Cancel'
    Flat = True
    OnClick = sbCancelClick
  end
  object sbOk: TSpeedButton
    Left = 8
    Top = 91
    Width = 97
    Height = 22
    Caption = 'OK'
    Flat = True
    OnClick = sbOkClick
  end
  object rgTypeMod: TRadioGroup
    Left = 0
    Top = 0
    Width = 217
    Height = 33
    Align = alTop
    Caption = 'rgTypeMod'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Nova Pe'#231'a'
      'Nova Vers'#227'o')
    TabOrder = 0
    OnClick = rgTypeModClick
  end
  object Painel: TStatusBar
    Left = 0
    Top = 117
    Width = 217
    Height = 19
    Panels = <
      item
        Width = 100
      end>
  end
  object seMajVer: TSpinEdit
    Left = 80
    Top = 64
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object seMinVer: TSpinEdit
    Left = 120
    Top = 64
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object eRefPart: TEdit
    Left = 80
    Top = 39
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'eRefPart'
    Visible = False
  end
end
