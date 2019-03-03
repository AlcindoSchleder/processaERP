inherited CdTipoAreas: TCdTipoAreas
  Left = 272
  Top = 214
  Caption = 'CdTipoAreas'
  ClientHeight = 289
  ClientWidth = 566
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 566
  end
  inherited ControlBar: TControlBar
    Width = 566
    inherited tbOperations: TToolBar
      Left = 306
      Width = 246
    end
    inherited tbTools: TToolBar
      Width = 282
    end
  end
  inherited Painel: TStatusBar
    Top = 270
    Width = 566
  end
  inherited Control: TPageControl
    Width = 566
    Height = 159
    inherited tsDataAware: TTabSheet
      object lDsc_Tara: TLabel [0]
        Left = 90
        Top = 59
        Width = 59
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Tara'
        FocusControl = eDsc_Tara
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lPk_Tipo_Areas_Atuacao: TLabel [1]
        Left = 5
        Top = 19
        Width = 144
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Tipo_Areas_Atuacao'
        FocusControl = ePk_Tipo_Areas_Atuacao
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
      object eDsc_Tara: TDBEdit
        Left = 152
        Top = 56
        Width = 377
        Height = 21
        DataField = 'DSC_TARA'
        DataSource = dsMain
        TabOrder = 0
      end
      object ePk_Tipo_Areas_Atuacao: TDBEdit
        Left = 152
        Top = 16
        Width = 121
        Height = 21
        Color = clTeal
        DataField = 'PK_TIPO_AREAS_ATUACAO'
        DataSource = dsMain
        TabOrder = 1
      end
    end
    inherited tsTable: TTabSheet
      inherited dbgGrid: TDBGrid
        Height = 109
      end
    end
  end
  inherited Panel1: TPanel
    Width = 566
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 125
    end
  end
  inherited pCompany: TPanel
    Width = 566
    inherited lNameCompany: TLabel
      Width = 544
    end
    inherited Panel2: TPanel
      Left = 546
    end
  end
end
