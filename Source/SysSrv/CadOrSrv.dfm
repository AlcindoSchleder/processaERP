object frmServiceOrder: TfrmServiceOrder
  Left = 191
  Top = 112
  Width = 800
  Height = 570
  Caption = 'frmServiceOrder'
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgMain: TPageControl
    Left = 0
    Top = 0
    Width = 792
    Height = 523
    Align = alClient
    TabOrder = 0
    OnChange = pgMainChange
    OnChanging = pgMainChanging
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 523
    Width = 792
    Height = 19
    Panels = <
      item
        Text = 'Mensagem:'
        Width = 500
      end
      item
        Style = psOwnerDraw
        Text = 'Empresa'
        Width = 300
      end>
    OnDblClick = sbChangeCompanyClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
end
