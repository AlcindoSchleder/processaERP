inherited CdCentroCustos: TCdCentroCustos
  Height = 320
  Caption = 'CdCentroCustos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited sbStatus: TStatusBar
    Top = 247
  end
  inherited pgControl: TPageControl
    Height = 190
    inherited tsData: TTabSheet
      object lDsc_CCst: TStaticText
        Left = 8
        Top = 64
        Width = 163
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lDsc_CCst'
        FocusControl = eDsc_CCst
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eDsc_CCst: TEdit
        Left = 176
        Top = 64
        Width = 425
        Height = 21
        Anchors = [akLeft, akRight]
        MaxLength = 50
        TabOrder = 1
      end
      object lPk_Centro_Custos: TStaticText
        Left = 8
        Top = 16
        Width = 163
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lPk_Centro_Custos'
        FocusControl = ePk_Centro_Custos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object ePk_Centro_Custos: TCurrencyEdit
        Left = 176
        Top = 16
        Width = 109
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akLeft]
        TabOrder = 2
      end
    end
    inherited tsList: TTabSheet
      inherited vtGrid: TVirtualStringTree
        WideDefaultText = 'vtGrid'
      end
    end
  end
end
