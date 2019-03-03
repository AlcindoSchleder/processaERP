object frmEgg: TfrmEgg
  Left = 278
  Top = 138
  BorderIcons = []
  BorderStyle = bsToolWindow
  ClientHeight = 300
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDblClick = spEggPanelDblClick
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object spEggPanel: TPrcScrtPnl
    Left = 46
    Top = 38
    Width = 208
    Height = 224
    AsyncDrawing = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    OnClick = spEggPanelClick
    OnDblClick = spEggPanelDblClick
    OnPaintClient = spEggPanelPaintClient
    ParentFont = False
    TabOrder = 0
  end
end
