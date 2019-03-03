object MvManifest: TMvManifest
  Left = 192
  Top = 200
  Width = 801
  Height = 548
  Caption = 'MvManifest'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pgMain: TPageControl
    Left = 0
    Top = 33
    Width = 793
    Height = 468
    Align = alClient
    TabOrder = 0
    OnChange = pgMainChange
    OnChanging = pgMainChanging
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 793
    Height = 33
    Bands = <
      item
        Break = False
        Control = tbTools
        ImageIndex = 46
        Text = 'Ferramentas'
        Width = 789
      end>
    ParentShowHint = False
    ShowHint = True
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 712
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 54
      Caption = 'tbTools'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbNew: TToolButton
        Left = 0
        Top = 0
        Caption = 'Novo'
        Enabled = False
        ImageIndex = 34
      end
      object tbCancel: TToolButton
        Left = 54
        Top = 0
        Caption = 'Cancelar'
        Enabled = False
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbDelete: TToolButton
        Left = 108
        Top = 0
        Caption = 'Excluir'
        Enabled = False
        ImageIndex = 33
      end
      object tbSepSave: TToolButton
        Left = 162
        Top = 0
        Width = 8
        Caption = 'tbSepSave'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 170
        Top = 0
        Caption = 'Salvar'
        Enabled = False
        ImageIndex = 36
      end
      object tbSepFind: TToolButton
        Left = 224
        Top = 0
        Width = 8
        Caption = 'tbSepFind'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbSearch: TToolButton
        Left = 232
        Top = 0
        Caption = 'Buscar'
        ImageIndex = 38
        OnClick = tbSearchClick
      end
      object tbSepClose: TToolButton
        Left = 286
        Top = 0
        Width = 8
        Caption = 'tbSepClose'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 294
        Top = 0
        Caption = 'Sair'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
      object tbSepCal: TToolButton
        Left = 348
        Top = 0
        Width = 8
        Caption = 'tbSepCal'
        ImageIndex = 43
        Style = tbsSeparator
      end
      object tbCalc: TToolButton
        Left = 356
        Top = 0
        Caption = 'Calcular'
        Enabled = False
        ImageIndex = 14
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 501
    Width = 793
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Style = psOwnerDraw
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
