object frmScreenReport: TfrmScreenReport
  Left = 517
  Top = 231
  Width = 273
  Height = 152
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    265
    124)
  PixelsPerInch = 96
  TextHeight = 13
  object sbPrint: TSpeedButton
    Left = 8
    Top = 40
    Width = 121
    Height = 25
    Anchors = [akLeft]
    Caption = 'Iniciar Impress'#227'o'
    OnClick = sbPrintClick
  end
  object sbCancel: TSpeedButton
    Left = 136
    Top = 40
    Width = 121
    Height = 25
    Anchors = [akRight]
    Caption = 'Cancelar Impress'#227'o'
    OnClick = sbCancelClick
  end
  object Shape1: TShape
    Left = 8
    Top = 8
    Width = 249
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Brush.Color = clBlue
  end
  object lTitle: TLabel
    Left = 16
    Top = 10
    Width = 233
    Height = 20
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Impress'#227'o de Relat'#243'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object pbProgress: TProgressBar
    Left = 8
    Top = 72
    Width = 249
    Height = 17
    Anchors = [akLeft, akRight]
    Max = 10
    Step = 1
    TabOrder = 0
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 105
    Width = 265
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
end
