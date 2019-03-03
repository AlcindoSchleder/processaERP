inherited CdTipoMotores: TCdTipoMotores
  Caption = 'CdTipoMotores'
  ClientHeight = 335
  PixelsPerInch = 96
  TextHeight = 13
  inherited Painel: TStatusBar
    Top = 316
  end
  inherited Control: TPageControl
    Height = 205
    inherited tsDataAware: TTabSheet
      object lPk_Tipos_Motores: TLabel [0]
        Left = 16
        Top = 11
        Width = 109
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Tipos_Motores'
        FocusControl = ePk_Tipos_Motores
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lDsc_Mot: TLabel [1]
        Left = 70
        Top = 44
        Width = 54
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Mot'
        FocusControl = eDsc_Mot
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lQtd_Polo: TLabel [2]
        Left = 69
        Top = 75
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'lQtd_Polo'
        FocusControl = eQtd_Polo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lCv_Mot: TLabel [3]
        Left = 78
        Top = 107
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'lCv_Mot'
        FocusControl = eCv_Mot
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lPreco_Mot: TLabel [4]
        Left = 332
        Top = 107
        Width = 65
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPreco_Mot'
        FocusControl = ePreco_Mot
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lRpm_Mot: TLabel [5]
        Left = 340
        Top = 75
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = 'lRpm_Mot'
        FocusControl = eRpm_Mot
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lFat_Rend: TLabel [6]
        Left = 66
        Top = 139
        Width = 59
        Height = 13
        Alignment = taRightJustify
        Caption = 'lFat_Rend'
        FocusControl = eFat_Rend
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      inherited pbModel: TProgressBar
        TabOrder = 6
      end
      object ePk_Tipos_Motores: TDBEdit
        Left = 128
        Top = 8
        Width = 97
        Height = 21
        Color = clTeal
        DataField = 'PK_TIPOS_MOTORES'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 0
        OnDblClick = ComponentDblClick
      end
      object eDsc_Mot: TDBEdit
        Left = 128
        Top = 40
        Width = 391
        Height = 21
        CharCase = ecUpperCase
        DataField = 'DSC_MOT'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 1
        OnDblClick = ComponentDblClick
      end
      object eQtd_Polo: TJvDBCalcEdit
        Left = 128
        Top = 72
        Width = 121
        Height = 21
        DataField = 'QTD_POLO'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        ButtonWidth = 0
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 2
        OnDblClick = ComponentDblClick
      end
      object eCv_Mot: TJvDBCalcEdit
        Left = 128
        Top = 104
        Width = 121
        Height = 21
        DataField = 'CV_MOT'
        DataSource = dsMain
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 3
        ZeroEmpty = False
        OnDblClick = ComponentDblClick
      end
      object ePreco_Mot: TJvDBCalcEdit
        Left = 400
        Top = 104
        Width = 121
        Height = 21
        DataField = 'PRECO_MOT'
        DataSource = dsMain
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 5
        OnDblClick = ComponentDblClick
      end
      object eRpm_Mot: TJvDBCalcEdit
        Left = 400
        Top = 72
        Width = 121
        Height = 21
        DataField = 'RPM_MOT'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        ButtonWidth = 0
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 4
        OnDblClick = ComponentDblClick
      end
      object lFlag_Vnd: TDBCheckBox
        Left = 400
        Top = 8
        Width = 129
        Height = 17
        Caption = 'lFlag_Vnd'
        DataField = 'FLAG_VND'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object eFat_Rend: TJvDBCalcEdit
        Left = 128
        Top = 136
        Width = 121
        Height = 21
        DataField = 'FAT_REND'
        DataSource = dsMain
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 8
        ZeroEmpty = False
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
