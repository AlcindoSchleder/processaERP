inherited frmChartView: TfrmChartView
  Caption = 'frmChartView'
  KeyPreview = True
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgMain: TPageControl
    inherited tsVisual: TTabSheet
      object raChart: TResourceAllocationChart
        Left = 0
        Top = 48
        Width = 361
        Height = 409
        ChartAppearance.Color = 16776176
        ChartAppearance.DateLineColor = clSilver
        ChartAppearance.DateLineInterval = 1.000000000000000000
        ChartAppearance.DateTimeFont.Charset = DEFAULT_CHARSET
        ChartAppearance.DateTimeFont.Color = clBlue
        ChartAppearance.DateTimeFont.Height = -13
        ChartAppearance.DateTimeFont.Name = 'MS Sans Serif'
        ChartAppearance.DateTimeFont.Style = [fsBold]
        ChartAppearance.DateTimeStyle = dtDateOnly
        ChartAppearance.PlotBackAlternateColor = clWhite
        ChartAppearance.PlotBackColor = clMoneyGreen
        ChartAppearance.ResourceLineStyle = psSolid
        ChartAppearance.ResourceNameFont.Charset = DEFAULT_CHARSET
        ChartAppearance.ResourceNameFont.Color = clBlue
        ChartAppearance.ResourceNameFont.Height = -13
        ChartAppearance.ResourceNameFont.Name = 'MS Sans Serif'
        ChartAppearance.ResourceNameFont.Style = [fsBold]
        ChartAppearance.ResourceNameWidth = 100
        ChartAppearance.ResourceSeparatorLineStyle = psSolid
        EndAt = 38611.000000000000000000
        Options = [racAllowDragAllocation, racAllowDragScroll, racAllowStretchAllocation, racAutoHint, racShowFocusRect, racDateAxisAtBottom]
        RoundTo = 0.010416666666666670
        StartAt = 38604.000000000000000000
      end
      object pSelection: TPanel
        Left = 0
        Top = 0
        Width = 361
        Height = 41
        Align = alTop
        BevelInner = bvLowered
        ParentColor = True
        TabOrder = 1
        object stDtaIni: TStaticText
          Left = 8
          Top = 8
          Width = 81
          Height = 21
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = ' Data Incial:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object eDtaIni: TDateEdit
          Left = 90
          Top = 8
          Width = 89
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          NumGlyphs = 2
          TabOrder = 1
        end
        object stDtaFin: TStaticText
          Left = 184
          Top = 8
          Width = 81
          Height = 21
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = ' Data Final:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object eDtaFin: TDateEdit
          Left = 266
          Top = 8
          Width = 89
          Height = 21
          BevelKind = bkFlat
          BorderStyle = bsNone
          NumGlyphs = 2
          TabOrder = 3
        end
      end
    end
  end
end
