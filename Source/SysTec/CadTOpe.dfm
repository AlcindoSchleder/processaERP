inherited CdTOperacoes: TCdTOperacoes
  Caption = 'CdTOperacoes'
  ClientHeight = 259
  PixelsPerInch = 96
  TextHeight = 13
  inherited Painel: TStatusBar
    Top = 240
  end
  inherited Control: TPageControl
    Height = 129
    inherited tsDataAware: TTabSheet
      object lPk_Tipo_Operacoes: TLabel [0]
        Left = 14
        Top = 19
        Width = 119
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Tipo_Operacoes'
        FocusControl = ePk_Tipo_Operacoes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lDsc_Ope: TLabel [1]
        Left = 77
        Top = 51
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Ope'
        FocusControl = eDsc_Ope
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object ePk_Tipo_Operacoes: TDBEdit
        Left = 136
        Top = 16
        Width = 113
        Height = 21
        Color = clTeal
        DataField = 'PK_TIPO_OPERACOES'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 1
        OnDblClick = ComponentDblClick
      end
      object eDsc_Ope: TDBEdit
        Left = 136
        Top = 48
        Width = 401
        Height = 21
        CharCase = ecUpperCase
        DataField = 'DSC_OPE'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 2
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
