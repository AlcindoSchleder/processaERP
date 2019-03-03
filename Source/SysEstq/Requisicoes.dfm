object fmRequisicoes: TfmRequisicoes
  Left = 203
  Top = 114
  Width = 800
  Height = 600
  Caption = 'Requisi'#231#245'es'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgMain: TPageControl
    Left = 0
    Top = 0
    Width = 792
    Height = 553
    Align = alClient
    TabOrder = 0
    OnChange = pgMainChange
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 553
    Width = 792
    Height = 19
    Panels = <
      item
        Text = 'Mensagem:'
        Width = 300
      end
      item
        Style = psOwnerDraw
        Text = 'Empresa'
        Width = 300
      end
      item
        Style = psOwnerDraw
        Width = 100
      end>
    OnClick = sbStatusClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
end
