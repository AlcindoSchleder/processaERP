inherited CdTipoServicos: TCdTipoServicos
  Left = 205
  Top = 130
  Caption = 'CdTipoServicos'
  ClientHeight = 312
  PixelsPerInch = 96
  TextHeight = 13
  inherited Painel: TStatusBar
    Top = 293
  end
  inherited Control: TPageControl
    Height = 182
    inherited tsDataAware: TTabSheet
      object lDsc_TSrv: TLabel [0]
        Left = 49
        Top = 51
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_TSrv'
        FocusControl = eDsc_TSrv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lPk_Tipo_Servicos: TLabel [1]
        Left = 2
        Top = 19
        Width = 107
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Tipo_Servicos'
        FocusControl = ePk_Tipo_Servicos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lFk_Unidades: TLabel [2]
        Left = 31
        Top = 83
        Width = 78
        Height = 13
        Alignment = taRightJustify
        Caption = 'lFk_Unidades'
        FocusControl = eFk_Unidades
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lVlr_TSrv: TLabel [3]
        Left = 56
        Top = 115
        Width = 53
        Height = 13
        Alignment = taRightJustify
        Caption = 'lVlr_TSrv'
        FocusControl = eVlr_TSrv
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
      object eDsc_TSrv: TDBEdit
        Left = 112
        Top = 48
        Width = 417
        Height = 21
        CharCase = ecUpperCase
        DataField = 'DSC_TSRV'
        DataSource = dsMain
        TabOrder = 0
      end
      object ePk_Tipo_Servicos: TDBEdit
        Left = 112
        Top = 16
        Width = 121
        Height = 21
        Color = clTeal
        DataField = 'PK_TIPO_SERVICOS'
        DataSource = dsMain
        TabOrder = 1
      end
      object eFk_Unidades: TDBLookupComboBox
        Left = 112
        Top = 80
        Width = 417
        Height = 21
        DataField = 'FK_UNIDADES'
        DataSource = dsMain
        KeyField = 'PK_UNIDADES'
        ListField = 'DSC_UNI'
        ListSource = Unidades
        TabOrder = 3
      end
      object eVlr_TSrv: TJvDBCalcEdit
        Left = 112
        Top = 112
        Width = 121
        Height = 21
        DataField = 'VLR_TSRV'
        DataSource = dsMain
        NumGlyphs = 2
        TabOrder = 4
      end
    end
    inherited tsTable: TTabSheet
      inherited dbgGrid: TDBGrid
        Height = 109
      end
    end
  end
  inherited Panel1: TPanel
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  object Unidades: TDataSource
    DataSet = dmSysEvt.Unidades
    Left = 264
    Top = 64
  end
end
