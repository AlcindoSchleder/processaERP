inherited frmTasksView: TfrmTasksView
  Caption = 'frmTasksView'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgMain: TPageControl
    inherited tsVisual: TTabSheet
      object VpTaskList: TVpTaskList
        Left = 0
        Top = 0
        Width = 361
        Height = 457
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
        OnOwnerEditTask = VpTaskListOwnerEditTask
      end
    end
  end
end
