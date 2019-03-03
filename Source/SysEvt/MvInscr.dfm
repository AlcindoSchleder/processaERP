object MovInscricao: TMovInscricao
  Left = 186
  Top = 51
  BorderStyle = bsToolWindow
  Caption = 'MovInscricao'
  ClientHeight = 316
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 0
    Top = 8
    Width = 201
    Height = 21
    Caption = 'Busca Informa'#231#245'es de Inscri'#231#245'es'
    Flat = True
    OnClick = tbSearchClick
  end
  object SpeedButton2: TSpeedButton
    Left = 240
    Top = 8
    Width = 201
    Height = 21
    Caption = 'Imprime Resultados'
    Flat = True
    OnClick = tbSearchClick
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 536
    Height = 49
    Bands = <
      item
        Control = tbTools
        ImageIndex = -1
        MinHeight = 41
        Width = 532
      end>
    object tbTools: TToolBar
      Left = 9
      Top = 0
      Width = 519
      Height = 41
      ButtonHeight = 21
      ButtonWidth = 70
      Caption = 'tbTools'
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object tbClose: TToolButton
        Left = 0
        Top = 0
        Caption = 'tbClose'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
      object ToolButton1: TToolButton
        Left = 70
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 46
        Style = tbsSeparator
      end
      object tbConnect: TToolButton
        Left = 78
        Top = 0
        Caption = 'tbConnect'
        ImageIndex = 35
        OnClick = tbConnectClick
      end
      object tbDisconnect: TToolButton
        Left = 148
        Top = 0
        Caption = 'tbDisconnect'
        Enabled = False
        ImageIndex = 56
        OnClick = tbDisconnectClick
      end
      object ToolButton2: TToolButton
        Left = 218
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 46
        Style = tbsSeparator
      end
      object tbSearch: TToolButton
        Left = 226
        Top = 0
        Caption = 'tbSearch'
        Enabled = False
        ImageIndex = 36
        OnClick = tbSearchClick
      end
      object tbPrint: TToolButton
        Left = 296
        Top = 0
        Caption = 'tbPrint'
        Enabled = False
        ImageIndex = 40
      end
    end
  end
  object Report: TMemo
    Left = 0
    Top = 49
    Width = 536
    Height = 267
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 336
    Top = 96
    object miFile: TMenuItem
      Caption = 'miFile'
      object miConnect: TMenuItem
        Caption = 'miConnect'
        ImageIndex = 35
        ShortCut = 113
        OnClick = tbConnectClick
      end
      object miDisconnect: TMenuItem
        Caption = 'miDisconnect'
        Enabled = False
        ImageIndex = 56
        ShortCut = 16497
        OnClick = tbDisconnectClick
      end
      object miSep0: TMenuItem
        Caption = '-'
      end
      object miSearch: TMenuItem
        Caption = 'miSearch'
        Enabled = False
        ImageIndex = 36
        ShortCut = 123
        OnClick = tbSearchClick
      end
      object miPrint: TMenuItem
        Caption = 'miPrint'
        Enabled = False
        ImageIndex = 40
        ShortCut = 16464
      end
      object miSep1: TMenuItem
        Caption = '-'
      end
      object miClose: TMenuItem
        Caption = 'miSair'
        ImageIndex = 41
        ShortCut = 27
        OnClick = tbCloseClick
      end
    end
  end
end
