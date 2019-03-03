object frmRestore: TfrmRestore
  Left = 282
  Top = 203
  Width = 506
  Height = 394
  Caption = 'frmRestore'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mResult: TMemo
    Left = 0
    Top = 0
    Width = 498
    Height = 360
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object cpRestore: TJvCreateProcess
    CreationFlags = [cfNewConsole, cfSharedWdm]
    StartupInfo.ShowWindow = swHide
    StartupInfo.DefaultWindowState = False
    ConsoleOptions = [coRedirect]
    OnTerminate = cpRestoreTerminate
    OnRead = cpRestoreRead
    Left = 352
    Top = 8
  end
  object tTimer: TTimer
    Enabled = False
    OnTimer = tTimerTimer
    Left = 384
    Top = 8
  end
end
