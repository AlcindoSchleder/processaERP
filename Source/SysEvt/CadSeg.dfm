inherited CdSegmentos: TCdSegmentos
  Left = 205
  Top = 129
  Caption = 'CdSegmentos'
  ClientHeight = 290
  ClientWidth = 560
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 560
  end
  inherited ControlBar: TControlBar
    Width = 560
  end
  inherited Painel: TStatusBar
    Top = 271
    Width = 560
  end
  inherited Control: TPageControl
    Width = 560
    Height = 160
    inherited tsDataAware: TTabSheet
      object lDsc_Seg: TLabel [0]
        Left = 54
        Top = 59
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Seg'
        FocusControl = eDsc_Seg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lPk_Segmentos: TLabel [1]
        Left = 21
        Top = 19
        Width = 88
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Segmentos'
        FocusControl = ePk_Segmentos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      inherited pbModel: TProgressBar
        TabOrder = 2
      end
      object eDsc_Seg: TDBEdit
        Left = 112
        Top = 56
        Width = 417
        Height = 21
        DataField = 'DSC_SEG'
        DataSource = dsMain
        TabOrder = 0
      end
      object ePk_Segmentos: TDBEdit
        Left = 112
        Top = 16
        Width = 121
        Height = 21
        Color = clTeal
        DataField = 'PK_SEGMENTOS'
        DataSource = dsMain
        TabOrder = 1
      end
      object lFlag_Area: TDBCheckBox
        Left = 112
        Top = 96
        Width = 417
        Height = 17
        Caption = 'lFlag_Area'
        DataField = 'FLAG_AREA'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    inherited tsTable: TTabSheet
      inherited dbgGrid: TDBGrid
        Height = 109
      end
    end
  end
  inherited Panel1: TPanel
    Width = 560
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 119
    end
  end
  inherited pCompany: TPanel
    Width = 560
    inherited lNameCompany: TLabel
      Width = 538
    end
    inherited Panel2: TPanel
      Left = 540
    end
  end
end
