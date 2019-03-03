inherited CdTipoEventos: TCdTipoEventos
  Width = 571
  Height = 380
  Caption = 'CdTipoEventos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 563
  end
  inherited ControlBar: TControlBar
    Width = 563
  end
  inherited Painel: TStatusBar
    Top = 307
    Width = 563
  end
  inherited Control: TPageControl
    Width = 563
    Height = 196
    inherited tsDataAware: TTabSheet
      object pData: TPanel
        Left = 0
        Top = 0
        Width = 393
        Height = 164
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object lDsc_TEvt: TLabel
          Left = 57
          Top = 43
          Width = 60
          Height = 13
          Alignment = taRightJustify
          Caption = 'lDsc_TEvt'
          FocusControl = eDsc_TEvt
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnDblClick = ComponentDblClick
        end
        object lPk_Tipo_Eventos: TLabel
          Left = 13
          Top = 19
          Width = 104
          Height = 13
          Alignment = taRightJustify
          Caption = 'lPk_Tipo_Eventos'
          FocusControl = ePk_Tipo_Eventos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnDblClick = ComponentDblClick
        end
        object lMtrg_Prom: TLabel
          Left = 53
          Top = 91
          Width = 64
          Height = 13
          Alignment = taRightJustify
          Caption = 'lMtrg_Prom'
          FocusControl = eMtrg_Prom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnDblClick = ComponentDblClick
        end
        object lQtd_Bonus: TLabel
          Left = 51
          Top = 115
          Width = 66
          Height = 13
          Alignment = taRightJustify
          Caption = 'lQtd_Bonus'
          FocusControl = eQtd_Bonus
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnDblClick = ComponentDblClick
        end
        object lEMail_Evt: TLabel
          Left = 56
          Top = 139
          Width = 61
          Height = 13
          Alignment = taRightJustify
          Caption = 'lEMail_Evt'
          FocusControl = eEMail_Evt
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnDblClick = ComponentDblClick
        end
        object lFk_Categorias: TLabel
          Left = 32
          Top = 67
          Width = 85
          Height = 13
          Alignment = taRightJustify
          Caption = 'lFk_Categorias'
          FocusControl = eFk_Categorias
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnDblClick = ComponentDblClick
        end
        object eDsc_TEvt: TDBEdit
          Left = 120
          Top = 40
          Width = 263
          Height = 21
          CharCase = ecUpperCase
          DataField = 'DSC_TEVT'
          DataSource = dsMain
          PopupMenu = pmFields
          TabOrder = 0
          OnDblClick = ComponentDblClick
        end
        object ePk_Tipo_Eventos: TDBEdit
          Left = 120
          Top = 16
          Width = 113
          Height = 21
          Color = clTeal
          DataField = 'PK_TIPO_EVENTOS'
          DataSource = dsMain
          PopupMenu = pmFields
          TabOrder = 1
          OnDblClick = ComponentDblClick
        end
        object eMtrg_Prom: TJvDBCalcEdit
          Left = 120
          Top = 88
          Width = 121
          Height = 21
          DataField = 'MTRG_PROM'
          DataSource = dsMain
          ButtonWidth = 0
          NumGlyphs = 2
          TabOrder = 2
        end
        object eQtd_Bonus: TJvDBCalcEdit
          Left = 120
          Top = 112
          Width = 121
          Height = 21
          DataField = 'QTD_BONUS'
          DataSource = dsMain
          ButtonWidth = 0
          NumGlyphs = 2
          TabOrder = 3
        end
        object eEMail_Evt: TDBEdit
          Left = 120
          Top = 136
          Width = 261
          Height = 21
          DataField = 'EMAIL_EVT'
          DataSource = dsMain
          PopupMenu = pmFields
          TabOrder = 4
          OnDblClick = ComponentDblClick
        end
        object eFk_Categorias: TDBLookupComboBox
          Left = 120
          Top = 64
          Width = 265
          Height = 21
          DataField = 'FK_CATEGORIAS'
          DataSource = dsMain
          KeyField = 'PK_CATEGORIAS'
          ListField = 'DSC_CAT'
          ListSource = dsCategorias
          TabOrder = 5
        end
      end
      object pnCategories: TPanel
        Left = 393
        Top = 0
        Width = 162
        Height = 164
        Align = alRight
        BevelInner = bvLowered
        TabOrder = 2
        object lAreas: TLabel
          Left = 2
          Top = 2
          Width = 158
          Height = 20
          Align = alTop
          Alignment = taCenter
          Caption = 'lAreas'
          FocusControl = clbAreas
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object clbAreas: TCheckListBox
          Left = 2
          Top = 22
          Width = 158
          Height = 140
          OnClickCheck = clbAreasClickCheck
          Align = alClient
          Columns = 1
          ItemHeight = 13
          Items.Strings = (
            'item 1'
            'item 2')
          TabOrder = 0
        end
      end
    end
    inherited tsTable: TTabSheet
      inherited dbgGrid: TDBGrid
        Height = 109
      end
    end
  end
  inherited Panel1: TPanel
    Width = 563
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 122
    end
  end
  inherited pCompany: TPanel
    Width = 563
    inherited lNameCompany: TLabel
      Width = 541
    end
    inherited Panel2: TPanel
      Left = 543
    end
  end
  inherited MainMenu: TMainMenu
    inherited miTools: TMenuItem
      object miTAreasAct: TMenuItem
        Caption = 'miTAreasAct'
        ImageIndex = 13
        OnClick = miTAreasActClick
      end
    end
  end
  object dsCategorias: TDataSource
    DataSet = dmSysEvt.Categorias
    Left = 264
    Top = 64
  end
end
