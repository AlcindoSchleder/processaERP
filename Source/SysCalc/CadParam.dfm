inherited CdParametros: TCdParametros
  Left = 237
  Caption = 'CdParametros'
  ClientHeight = 409
  PixelsPerInch = 96
  TextHeight = 13
  inherited Painel: TStatusBar
    Top = 390
  end
  inherited Control: TPageControl
    Height = 279
    inherited tsDataAware: TTabSheet
      object lPk_Parametros_Calc: TLabel [0]
        Left = 4
        Top = 11
        Width = 121
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Parametros_Calc'
        FocusControl = ePk_Parametros_Calc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lDsc_Param: TLabel [1]
        Left = 56
        Top = 36
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Param'
        FocusControl = eDsc_Param
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lParam_Nhf: TLabel [2]
        Left = 331
        Top = 59
        Width = 66
        Height = 13
        Alignment = taRightJustify
        Caption = 'lParam_Nhf'
        FocusControl = eParam_Nhf
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lParam_Nhh: TLabel [3]
        Left = 328
        Top = 83
        Width = 69
        Height = 13
        Alignment = taRightJustify
        Caption = 'lParam_Nhh'
        FocusControl = eParam_Nhh
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lParam_Ndm: TLabel [4]
        Left = 326
        Top = 107
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lParam_Ndm'
        FocusControl = eParam_Ndm
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lParam_Nma: TLabel [5]
        Left = 326
        Top = 131
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lParam_Nma'
        FocusControl = eParam_Nma
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lCusto_Nhf: TLabel [6]
        Left = 334
        Top = 155
        Width = 63
        Height = 13
        Alignment = taRightJustify
        Caption = 'lCusto_Nhf'
        FocusControl = eCusto_Nhf
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lCusto_Nhh: TLabel [7]
        Left = 331
        Top = 179
        Width = 66
        Height = 13
        Alignment = taRightJustify
        Caption = 'lCusto_Nhh'
        FocusControl = eCusto_Nhh
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lPerc_Troca: TLabel [8]
        Left = 327
        Top = 203
        Width = 70
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPerc_Troca'
        FocusControl = ePerc_Troca
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lKwh_Mot: TLabel [9]
        Left = 341
        Top = 227
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'lKwh_Mot'
        FocusControl = eKwh_Mot
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
        TabOrder = 9
      end
      object ePk_Parametros_Calc: TDBEdit
        Left = 128
        Top = 8
        Width = 97
        Height = 21
        Color = clTeal
        DataField = 'PK_PARAMETROS_CALC'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 0
        OnDblClick = ComponentDblClick
      end
      object eDsc_Param: TDBEdit
        Left = 128
        Top = 32
        Width = 391
        Height = 21
        CharCase = ecUpperCase
        DataField = 'DSC_PARAM'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 1
        OnDblClick = ComponentDblClick
      end
      object eParam_Nhf: TJvDBCalcEdit
        Left = 400
        Top = 56
        Width = 121
        Height = 21
        DataField = 'PARAM_NHF'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        ButtonWidth = 0
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 2
        OnDblClick = ComponentDblClick
      end
      object eParam_Nhh: TJvDBCalcEdit
        Left = 400
        Top = 80
        Width = 121
        Height = 21
        DataField = 'PARAM_NHH'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        ButtonWidth = 0
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 3
        OnDblClick = ComponentDblClick
      end
      object eParam_Ndm: TJvDBCalcEdit
        Left = 400
        Top = 104
        Width = 121
        Height = 21
        DataField = 'PARAM_NDM'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        ButtonWidth = 0
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 4
        OnDblClick = ComponentDblClick
      end
      object eParam_Nma: TJvDBCalcEdit
        Left = 400
        Top = 128
        Width = 121
        Height = 21
        DataField = 'PARAM_NMA'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        ButtonWidth = 0
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 5
        OnDblClick = ComponentDblClick
      end
      object eCusto_Nhf: TJvDBCalcEdit
        Left = 400
        Top = 152
        Width = 121
        Height = 21
        DataField = 'CUSTO_NHF'
        DataSource = dsMain
        DecimalPlaces = 4
        DisplayFormat = ',0.####'
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 6
        OnDblClick = ComponentDblClick
      end
      object eCusto_Nhh: TJvDBCalcEdit
        Left = 400
        Top = 176
        Width = 121
        Height = 21
        DataField = 'CUSTO_NHH'
        DataSource = dsMain
        DecimalPlaces = 4
        DisplayFormat = ',0.####'
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 7
        OnDblClick = ComponentDblClick
      end
      object ePerc_Troca: TJvDBCalcEdit
        Left = 400
        Top = 200
        Width = 121
        Height = 21
        DataField = 'PERC_TROCA'
        DataSource = dsMain
        DisplayFormat = ',0.## %'
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 8
        OnDblClick = ComponentDblClick
      end
      object eKwh_Mot: TJvDBCalcEdit
        Left = 400
        Top = 224
        Width = 121
        Height = 21
        DataField = 'KWH_MOT'
        DataSource = dsMain
        DecimalPlaces = 4
        DisplayFormat = ',0.####'
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 10
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
