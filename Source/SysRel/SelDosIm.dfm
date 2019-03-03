object SelImprDos: TSelImprDos
  Left = 192
  Top = 107
  Width = 589
  Height = 315
  Caption = 'SelImprDos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Status: TStatusBar
    Left = 0
    Top = 262
    Width = 581
    Height = 19
    Panels = <>
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 581
    Height = 41
    Bands = <
      item
        Control = tbButtonTools
        ImageIndex = -1
        Width = 577
      end>
    object tbButtonTools: TToolBar
      Left = 9
      Top = 0
      Width = 564
      Height = 25
      ButtonHeight = 21
      ButtonWidth = 49
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object tbClose: TToolButton
        Left = 0
        Top = 0
        Caption = 'tbClose'
        ImageIndex = 0
        OnClick = tbCloseClick
      end
      object tbPrint: TToolButton
        Left = 49
        Top = 0
        Caption = 'tbPrint'
        ImageIndex = 1
      end
      object tbView: TToolButton
        Left = 98
        Top = 0
        Caption = 'tbView'
        ImageIndex = 2
      end
      object tbCancel: TToolButton
        Left = 147
        Top = 0
        Caption = 'tbCancel'
        ImageIndex = 3
      end
    end
  end
  object dbgGridPrn: TDBGrid
    Left = 0
    Top = 41
    Width = 581
    Height = 221
    Align = alClient
    DataSource = dsImpressoras
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'MAP_IMP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSC_IMP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNC_NAME'
        Visible = True
      end>
  end
  object dsImpressoras: TDataSource
    Left = 224
    Top = 72
  end
end
