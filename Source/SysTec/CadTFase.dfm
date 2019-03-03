inherited CdTFasesProd: TCdTFasesProd
  Caption = 'CdTFasesProd'
  ClientHeight = 290
  PixelsPerInch = 96
  TextHeight = 13
  inherited Painel: TStatusBar
    Top = 271
  end
  inherited Control: TPageControl
    Height = 160
    inherited tsDataAware: TTabSheet
      object lPk_Tipo_Fases_Producao: TLabel [0]
        Left = -19
        Top = 19
        Width = 152
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Tipo_Fases_Producao'
        FocusControl = ePk_Tipo_Fases_Producao
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lDsc_Fase: TLabel [1]
        Left = 73
        Top = 51
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Fase'
        FocusControl = eDsc_Fase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lNiv_Fase: TLabel [2]
        Left = 76
        Top = 83
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = 'lNiv_Fase'
        FocusControl = eNiv_Fase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object ePk_Tipo_Fases_Producao: TDBEdit
        Left = 136
        Top = 16
        Width = 113
        Height = 21
        Color = clTeal
        DataField = 'PK_TIPO_FASES_PRODUCAO'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 1
        OnDblClick = ComponentDblClick
      end
      object eDsc_Fase: TDBEdit
        Left = 136
        Top = 48
        Width = 401
        Height = 21
        CharCase = ecUpperCase
        DataField = 'DSC_FASE'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 2
        OnDblClick = ComponentDblClick
      end
      object eNiv_Fase: TJvDBCalcEdit
        Left = 136
        Top = 80
        Width = 121
        Height = 21
        DataField = 'NIV_FASE'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 3
        OnDblClick = ComponentDblClick
      end
    end
  end
  inherited Panel1: TPanel
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
end
