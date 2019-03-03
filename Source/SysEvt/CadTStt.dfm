inherited CdTipoStatus: TCdTipoStatus
  Caption = 'CdTipoStatus'
  ClientHeight = 286
  PixelsPerInch = 96
  TextHeight = 13
  inherited Painel: TStatusBar
    Top = 267
  end
  inherited Control: TPageControl
    Height = 156
    inherited tsDataAware: TTabSheet
      object lPk_Tipo_Status: TLabel [0]
        Left = 15
        Top = 19
        Width = 94
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Tipo_Status'
        FocusControl = ePk_Tipo_Status
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lDsc_Stt: TLabel [1]
        Left = 60
        Top = 67
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Stt'
        FocusControl = eDsc_Stt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object ePk_Tipo_Status: TDBEdit
        Left = 112
        Top = 16
        Width = 121
        Height = 21
        Color = clTeal
        DataField = 'PK_TIPO_STATUS'
        DataSource = dsMain
        TabOrder = 1
      end
      object eDsc_Stt: TDBEdit
        Left = 112
        Top = 64
        Width = 417
        Height = 21
        DataField = 'DSC_STT'
        DataSource = dsMain
        TabOrder = 2
      end
      object lFlag_Cad: TDBCheckBox
        Left = 112
        Top = 96
        Width = 169
        Height = 17
        Caption = 'lFlag_Cad'
        DataField = 'FLAG_CAD'
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
      object lFlag_Bloq: TDBCheckBox
        Left = 360
        Top = 96
        Width = 169
        Height = 17
        Caption = 'lFlag_Bloq'
        DataField = 'FLAG_BLOQ'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
  end
  inherited Panel1: TPanel
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
end
