object frmTasks: TfrmTasks
  Left = 192
  Top = 114
  BorderStyle = bsNone
  Caption = 'frmTasks'
  ClientHeight = 467
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object VpTaskList: TVpTaskList
    Left = 0
    Top = 0
    Width = 369
    Height = 467
    Color = 16776176
    Align = alClient
    TabStop = True
    TabOrder = 0
    ReadOnly = False
    DisplayOptions.CheckBGColor = clWindow
    DisplayOptions.CheckColor = cl3DDkShadow
    DisplayOptions.CheckStyle = csCheck
    DisplayOptions.DueDateFormat = 'd/M/yyyy'
    DisplayOptions.ShowCompletedTasks = True
    DisplayOptions.ShowAll = True
    DisplayOptions.ShowDueDate = True
    DisplayOptions.OverdueColor = clRed
    DisplayOptions.NormalColor = clBlack
    DisplayOptions.CompletedColor = clGray
    LineColor = clGray
    MaxVisibleTasks = 250
    TaskHeadAttributes.Color = clInfoBk
    TaskHeadAttributes.Font.Charset = DEFAULT_CHARSET
    TaskHeadAttributes.Font.Color = clBlue
    TaskHeadAttributes.Font.Height = -13
    TaskHeadAttributes.Font.Name = 'MS Sans Serif'
    TaskHeadAttributes.Font.Style = [fsBold]
    DrawingStyle = dsFlat
    ShowResourceName = True
  end
end
