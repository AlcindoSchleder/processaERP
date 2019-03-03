object dmReport: TdmReport
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 49
  Top = 346
  Height = 364
  Width = 506
  object frBarCode: TfrxBarCodeObject
    Left = 232
    Top = 72
  end
  object fDialogs: TfrxDialogControls
    Left = 128
    Top = 24
  end
  object frCrossObject: TfrxCrossObject
    Left = 232
    Top = 24
  end
  object frRichText: TfrxRichObject
    Left = 336
    Top = 24
  end
  object frCheckBox: TfrxCheckBoxObject
    Left = 24
    Top = 72
  end
  object frGradient: TfrxGradientObject
    Left = 128
    Top = 72
  end
  object frChart: TfrxChartObject
    Left = 336
    Top = 72
  end
  object frOLE: TfrxOLEObject
    Left = 232
    Top = 120
  end
  object frDotMatrix: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 24
    Top = 120
  end
  object frCompressor: TfrxGZipCompressor
    Left = 128
    Top = 120
  end
  object frTXT: TfrxTXTExport
    UseFileCache = True
    ShowProgress = True
    ScaleWidth = 1.000000000000000000
    ScaleHeight = 1.000000000000000000
    Borders = False
    Pseudogrpahic = False
    PageBreaks = True
    OEMCodepage = False
    EmptyLines = True
    LeadSpaces = False
    PrintAfter = False
    PrinterDialog = True
    UseSavedProps = True
    Left = 336
    Top = 120
  end
  object frHTML: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OpenAfterExport = True
    FixedWidth = True
    Navigator = True
    Multipage = True
    Background = True
    Centered = False
    EmptyLines = True
    Left = 128
    Top = 216
  end
  object frXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OpenExcelAfterExport = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 336
    Top = 216
  end
  object frXML: TfrxXMLExport
    UseFileCache = True
    ShowProgress = True
    OpenExcelAfterExport = True
    Background = True
    Creator = 'FastReport'#174
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 24
    Top = 168
  end
  object frRTF: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    Wysiwyg = True
    Creator = 'FastReport http://www.fast-report.com'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    Left = 128
    Top = 168
  end
  object frBMP: TfrxBMPExport
    UseFileCache = True
    ShowProgress = True
    Left = 232
    Top = 168
  end
  object frJPEG: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    Left = 336
    Top = 168
  end
  object frTIFF: TfrxTIFFExport
    UseFileCache = True
    ShowProgress = True
    Left = 232
    Top = 216
  end
  object frPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    PrintOptimized = True
    Outline = True
    Author = 'FastReport'#174
    Subject = 'FastReport'#174' PDF export'
    Background = False
    Creator = 'FastReport'#174' (http://www.fast-report.com)'
    HTMLTags = True
    Left = 24
    Top = 216
  end
  object frDBX: TfrxDBXComponents
    Left = 440
    Top = 120
  end
  object frReport: TfrxReport
    Tag = 1
    Version = '4.0.11'
    DataSet = frDataset
    DataSetName = 'frDataset'
    DotMatrixReport = False
    EngineOptions.PrintIfEmpty = False
    EngineOptions.TempDir = '.\'
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator]
    PreviewOptions.OutlineExpand = False
    PreviewOptions.Zoom = 50.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 38476.667838865740000000
    ReportOptions.LastChange = 39216.143775671300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeginDoc = frReportBeginDoc
    OnProgressStart = frReportProgressStart
    OnProgress = frReportProgress
    OnProgressStop = frReportProgressStop
    Left = 24
    Top = 24
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frDataset: TfrxDBDataset
    UserName = 'frDataset'
    CloseDataSource = False
    OpenDataSource = False
    Left = 440
    Top = 168
  end
  object frUserDataSet: TfrxUserDataSet
    UserName = 'frUserDataSet'
    Left = 440
    Top = 72
  end
  object frxMail: TfrxMailExport
    UseFileCache = True
    ShowProgress = True
    ShowExportDialog = True
    SmtpPort = 25
    UseIniFile = True
    Left = 440
    Top = 24
  end
  object frxCSV: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    Separator = ';'
    OEMCodepage = False
    Left = 440
    Top = 216
  end
  object frxGIF: TfrxGIFExport
    UseFileCache = True
    ShowProgress = True
    Left = 24
    Top = 264
  end
  object fsScript: TfsScript
    SyntaxType = 'PascalScript'
    Left = 128
    Top = 264
  end
end
