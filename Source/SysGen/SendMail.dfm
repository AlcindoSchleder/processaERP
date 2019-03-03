object fSendMail: TfSendMail
  Left = 260
  Top = 104
  BorderStyle = bsToolWindow
  Caption = 'fSendMail'
  ClientHeight = 447
  ClientWidth = 410
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 425
    Width = 410
    Height = 22
    Panels = <>
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 410
    Height = 49
    Bands = <
      item
        Control = ToolBar
        ImageIndex = -1
        MinHeight = 41
        Width = 406
      end>
    object ToolBar: TToolBar
      Left = 9
      Top = 0
      Width = 393
      Height = 41
      ButtonHeight = 36
      ButtonWidth = 42
      Caption = 'ToolBar'
      Flat = True
      Images = Dados.Image16
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
        Left = 42
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbMail: TToolButton
        Left = 50
        Top = 0
        Caption = 'tbMail'
        ImageIndex = 58
        OnClick = tbMailClick
      end
    end
  end
  object eMessage: TMemo
    Left = 0
    Top = 225
    Width = 410
    Height = 200
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 49
    Width = 410
    Height = 176
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lFile: TLabel
      Left = 59
      Top = 123
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Caption = 'lFile'
      FocusControl = eFile
    end
    object lToMail: TLabel
      Left = 43
      Top = 75
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'lToMail'
      FocusControl = eToMail
    end
    object Title: TLabel
      Left = 0
      Top = 0
      Width = 410
      Height = 24
      Align = alTop
      Alignment = taCenter
      Caption = 'Title'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lSubject: TLabel
      Left = 39
      Top = 99
      Width = 38
      Height = 13
      Alignment = taRightJustify
      Caption = 'lSubject'
      FocusControl = eSubject
    end
    object lFromMail: TLabel
      Left = 33
      Top = 51
      Width = 44
      Height = 13
      Alignment = taRightJustify
      Caption = 'lFromMail'
      FocusControl = eFromMail
    end
    object sbFile: TSpeedButton
      Left = 379
      Top = 120
      Width = 23
      Height = 22
      Flat = True
      OnClick = sbFileClick
    end
    object eToMail: TEdit
      Left = 80
      Top = 72
      Width = 321
      Height = 21
      TabOrder = 0
      Text = 'client@customers.com'
    end
    object stTitleBody: TStaticText
      Left = 0
      Top = 156
      Width = 410
      Height = 20
      Align = alBottom
      Alignment = taCenter
      BorderStyle = sbsSunken
      Caption = 'stTitleBody'
      FocusControl = eMessage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object eSubject: TEdit
      Left = 80
      Top = 96
      Width = 321
      Height = 21
      TabOrder = 2
    end
    object eFromMail: TEdit
      Left = 80
      Top = 48
      Width = 321
      Height = 21
      TabOrder = 3
      Text = 'suporte@processa.org'
    end
    object eFile: TEdit
      Left = 80
      Top = 120
      Width = 297
      Height = 21
      TabOrder = 4
    end
  end
  object mMain: TMainMenu
    Images = Dados.Image16
    Left = 344
    Top = 8
    object miFile: TMenuItem
      Caption = 'miFile'
      object miMail: TMenuItem
        Caption = 'miMail'
        ImageIndex = 58
        OnClick = tbMailClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miClose: TMenuItem
        Caption = 'miClose'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
    end
  end
  object idsMail: TIdSMTP
    IOHandler = idSSL
    MaxLineAction = maException
    ReadTimeout = 0
    BoundPort = 465
    Host = 'mail.processa.org'
    Port = 25
    AuthenticationType = atLogin
    Password = '90Am10'
    Username = 'suporte@processa.org'
    Left = 313
    Top = 8
  end
  object odOpenFile: TOpenDialog
    DefaultExt = '*.txt'
    Filter = 'Arquivos Texto|*.txt|Todos Arquivos|*.*'
    FilterIndex = 0
    InitialDir = '.\Temp'
    Title = 'Selecao de Arquivos'
    Left = 376
    Top = 8
  end
  object idmSendMail: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    Left = 344
    Top = 40
  end
  object idSSL: TIdSSLIOHandlerSocket
    SSLOptions.Method = sslvSSLv2
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 273
    Top = 8
  end
end
