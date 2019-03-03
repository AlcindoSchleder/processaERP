inherited CdExpositores: TCdExpositores
  Left = 248
  Top = 142
  Caption = 'CdExpositores'
  ClientHeight = 483
  ClientWidth = 749
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 749
  end
  inherited ControlBar: TControlBar
    Width = 749
  end
  inherited Painel: TStatusBar
    Top = 464
    Width = 749
  end
  inherited Control: TPageControl
    Width = 749
    Height = 353
    inherited tsDataAware: TTabSheet
      inherited pbModel: TProgressBar
        TabOrder = 2
      end
      object pcControl: TPageControl
        Left = 0
        Top = 0
        Width = 549
        Height = 321
        ActivePage = tsExpositors
        Align = alClient
        Images = Dados.Image16
        TabOrder = 0
        TabPosition = tpBottom
        OnChange = pcControlChange
        OnChanging = pcControlChanging
        object tsExpositors: TTabSheet
          Caption = 'tsExpositors'
          ImageIndex = 19
          object lDta_Ctr: TLabel
            Left = 62
            Top = 59
            Width = 47
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Ctr'
            FocusControl = eDta_Ctr
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lPk_Contratos: TLabel
            Left = 29
            Top = 35
            Width = 80
            Height = 13
            Alignment = taRightJustify
            Caption = 'lPk_Contratos'
            FocusControl = ePk_Contratos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lNum_Std: TLabel
            Left = 350
            Top = 83
            Width = 55
            Height = 13
            Alignment = taRightJustify
            Caption = 'lNum_Std'
            FocusControl = eNum_Std
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lVlr_Ctr: TLabel
            Left = 67
            Top = 83
            Width = 42
            Height = 13
            Alignment = taRightJustify
            Caption = 'lVlr_Ctr'
            FocusControl = eVlr_Ctr
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lRua_Std: TLabel
            Left = 352
            Top = 59
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = 'lRua_Std'
            FocusControl = eRua_Std
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lFk_Cadastros: TLabel
            Left = 28
            Top = 11
            Width = 81
            Height = 13
            Alignment = taRightJustify
            Caption = 'lFk_Cadastros'
            FocusControl = eFk_Cadastros
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lMtr_Std: TLabel
            Left = 357
            Top = 35
            Width = 48
            Height = 13
            Alignment = taRightJustify
            Caption = 'lMtr_Std'
            FocusControl = eMtr_Std
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lNom_Std: TLabel
            Left = 54
            Top = 107
            Width = 55
            Height = 13
            Alignment = taRightJustify
            Caption = 'lNom_Std'
            FocusControl = eNom_Std
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lObs_Ctr: TLabel
            Left = 0
            Top = 192
            Width = 541
            Height = 13
            Align = alBottom
            Alignment = taCenter
            Caption = 'lObs_Ctr'
            FocusControl = eObs_Ctr
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lSen_Exp: TLabel
            Left = 351
            Top = 131
            Width = 54
            Height = 13
            Alignment = taRightJustify
            Caption = 'lSen_Exp'
            FocusControl = eSen_Exp
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lLog_Exp: TLabel
            Left = 56
            Top = 131
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = 'lLog_Exp'
            FocusControl = eLog_Exp
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object sbGerLog: TSpeedButton
            Left = 232
            Top = 128
            Width = 23
            Height = 22
            Hint = 'Gerar o Login e Senha para o Expositor'
            OnClick = sbGerLogClick
          end
          object lQtd_Conv: TLabel
            Left = 345
            Top = 155
            Width = 60
            Height = 13
            Alignment = taRightJustify
            Caption = 'lQtd_Conv'
            FocusControl = eQtd_Conv
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object sbSendPasswd: TSpeedButton
            Left = 112
            Top = 152
            Width = 145
            Height = 22
            Caption = 'sbSendPasswd'
            Enabled = False
            Layout = blGlyphRight
            OnClick = sbSendPasswdClick
          end
          object eDta_Ctr: TJvDBDateEdit
            Left = 112
            Top = 56
            Width = 121
            Height = 21
            DataField = 'DTA_CTR'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 2
            OnDblClick = ComponentDblClick
          end
          object ePk_Contratos: TJvDBCalcEdit
            Left = 112
            Top = 32
            Width = 121
            Height = 21
            DataField = 'PK_CONTRATOS'
            DataSource = dsMain
            DecimalPlaces = 0
            DisplayFormat = ',0.'
            ButtonWidth = 0
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 1
            OnDblClick = ComponentDblClick
          end
          object eNum_Std: TJvDBCalcEdit
            Left = 408
            Top = 80
            Width = 121
            Height = 21
            DataField = 'NUM_STD'
            DataSource = dsMain
            DecimalPlaces = 0
            DisplayFormat = ',0.'
            GlyphKind = gkCustom
            ButtonWidth = 0
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 6
            OnDblClick = ComponentDblClick
          end
          object eVlr_Ctr: TJvDBCalcEdit
            Left = 112
            Top = 80
            Width = 121
            Height = 21
            DataField = 'VLR_CTR'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 3
            OnDblClick = ComponentDblClick
          end
          object eFk_Cadastros: TDBLookupComboBox
            Left = 111
            Top = 8
            Width = 418
            Height = 21
            DataField = 'FK_CADASTROS'
            DataSource = dsMain
            KeyField = 'PK_CADASTROS'
            ListField = 'RAZ_SOC'
            ListSource = Cadastros
            PopupMenu = pmFields
            TabOrder = 0
          end
          object eMtr_Std: TJvDBCalcEdit
            Left = 408
            Top = 32
            Width = 121
            Height = 21
            DataField = 'MTR_STD'
            DataSource = dsMain
            DecimalPlaces = 4
            DisplayFormat = ',0.####'
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 4
            OnDblClick = ComponentDblClick
          end
          object eRua_Std: TDBEdit
            Left = 408
            Top = 56
            Width = 121
            Height = 21
            CharCase = ecUpperCase
            DataField = 'RUA_STD'
            DataSource = dsMain
            PopupMenu = pmFields
            TabOrder = 5
            OnDblClick = ComponentDblClick
          end
          object eNom_Std: TDBEdit
            Left = 112
            Top = 104
            Width = 417
            Height = 21
            CharCase = ecUpperCase
            DataField = 'NOM_STD'
            DataSource = dsMain
            PopupMenu = pmFields
            TabOrder = 7
            OnDblClick = ComponentDblClick
          end
          object eObs_Ctr: TDBMemo
            Left = 0
            Top = 205
            Width = 541
            Height = 89
            Align = alBottom
            DataField = 'OBS_CTR'
            DataSource = dsMain
            TabOrder = 8
          end
          object eSen_Exp: TDBEdit
            Left = 408
            Top = 128
            Width = 121
            Height = 21
            DataField = 'SEN_EXP'
            DataSource = dsMain
            PopupMenu = pmFields
            TabOrder = 9
            OnDblClick = ComponentDblClick
          end
          object eLog_Exp: TDBEdit
            Left = 112
            Top = 128
            Width = 121
            Height = 21
            DataField = 'LOG_EXP'
            DataSource = dsMain
            PopupMenu = pmFields
            TabOrder = 10
            OnDblClick = ComponentDblClick
          end
          object eQtd_Conv: TJvDBCalcEdit
            Left = 408
            Top = 152
            Width = 121
            Height = 21
            DataField = 'QTD_CONV'
            DataSource = dsMain
            DecimalPlaces = 0
            DisplayFormat = ',0.'
            ButtonWidth = 0
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 11
            OnDblClick = ComponentDblClick
          end
        end
        object tsServices: TTabSheet
          Caption = 'tsServices'
          ImageIndex = 11
          object lQtd_Srv: TLabel
            Left = 307
            Top = 115
            Width = 50
            Height = 13
            Alignment = taRightJustify
            Caption = 'lQtd_Srv'
            FocusControl = eQtd_Srv
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lFk_Tipo_Servicos: TLabel
            Left = 216
            Top = 24
            Width = 106
            Height = 13
            Alignment = taCenter
            BiDiMode = bdLeftToRight
            Caption = 'lFk_Tipo_Servicos'
            FocusControl = eFk_Tipo_Servicos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentBiDiMode = False
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lTot_Srv: TLabel
            Left = 308
            Top = 171
            Width = 49
            Height = 13
            Alignment = taRightJustify
            Caption = 'lTot_Srv'
            FocusControl = eTot_Srv
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object eQtd_Srv: TJvDBCalcEdit
            Tag = 1
            Left = 360
            Top = 112
            Width = 121
            Height = 21
            DataField = 'QTD_SRV'
            NumGlyphs = 2
            TabOrder = 1
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 209
            Height = 294
            Align = alLeft
            BevelInner = bvLowered
            TabOrder = 3
            object lViewService: TLabel
              Left = 2
              Top = 2
              Width = 205
              Height = 16
              Align = alTop
              Alignment = taCenter
              Caption = 'lViewService'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object clbServices: TCheckListBox
              Left = 2
              Top = 18
              Width = 205
              Height = 274
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Ctl3D = False
              ItemHeight = 13
              ParentCtl3D = False
              TabOrder = 0
              OnClick = clbServicesClick
            end
          end
          object eFk_Tipo_Servicos: TDBLookupComboBox
            Tag = 1
            Left = 216
            Top = 40
            Width = 321
            Height = 21
            DataField = 'FK_TIPO_SERVICOS'
            KeyField = 'PK_TIPO_SERVICOS'
            ListField = 'DSC_TSRV'
            ListSource = TipoServicos
            PopupMenu = pmFields
            TabOrder = 0
          end
          object eTot_Srv: TJvDBCalcEdit
            Tag = 1
            Left = 360
            Top = 176
            Width = 121
            Height = 21
            DataField = 'TOT_SRV'
            NumGlyphs = 2
            TabOrder = 2
          end
        end
      end
      object pnCategories: TPanel
        Left = 549
        Top = 0
        Width = 192
        Height = 321
        Align = alRight
        BevelInner = bvLowered
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 1
        object lEvents: TLabel
          Left = 2
          Top = 2
          Width = 188
          Height = 20
          Align = alTop
          Alignment = taCenter
          Caption = 'lEvents'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object tvEvents: TTreeView
          Left = 2
          Top = 22
          Width = 188
          Height = 297
          Align = alClient
          Images = Dados.Image16
          Indent = 19
          TabOrder = 0
          OnChange = tvEventsChange
          OnChanging = tvEventsChanging
        end
      end
    end
    inherited tsTable: TTabSheet
      inherited dbgGrid: TDBGrid
        Height = 171
      end
    end
  end
  inherited Panel1: TPanel
    Width = 749
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 308
    end
  end
  inherited pCompany: TPanel
    Width = 749
    inherited lNameCompany: TLabel
      Width = 727
    end
    inherited Panel2: TPanel
      Left = 729
    end
  end
  object Cadastros: TDataSource
    DataSet = dmSysEvt.Cadastros
    Left = 264
    Top = 64
  end
  object TipoServicos: TDataSource
    DataSet = dmSysEvt.TipoServicos
    Left = 296
    Top = 64
  end
  object fsExpSrv: TJvFormStorage
    IniFileName = '.\SysConfig.ini'
    IniSection = 'ExpoService'
    StoredProps.Strings = (
      'tvEvents.Tag')
    StoredValues = <>
    Left = 328
    Top = 64
  end
end
