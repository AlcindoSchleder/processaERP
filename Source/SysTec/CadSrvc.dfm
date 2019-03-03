inherited CdServicos: TCdServicos
  Left = 310
  Top = 107
  Caption = 'CdServicos'
  ClientHeight = 484
  PixelsPerInch = 96
  TextHeight = 13
  inherited Painel: TStatusBar
    Top = 465
  end
  inherited Control: TPageControl
    Height = 354
    inherited tsDataAware: TTabSheet
      object lPk_Servicos_Ind: TLabel [0]
        Left = 33
        Top = 19
        Width = 100
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Servicos_Ind'
        FocusControl = ePk_Servicos_Ind
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lDsc_Srv: TLabel [1]
        Left = 81
        Top = 139
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Srv'
        FocusControl = eDsc_Srv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lFk_Secoes: TLabel [2]
        Left = 65
        Top = 43
        Width = 67
        Height = 13
        Alignment = taRightJustify
        Caption = 'lFk_Secoes'
        FocusControl = eFk_Secoes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lFk_Grupos: TLabel [3]
        Left = 67
        Top = 67
        Width = 65
        Height = 13
        Alignment = taRightJustify
        Caption = 'lFk_Grupos'
        FocusControl = eFk_Grupos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lFk_SubGrupos: TLabel [4]
        Left = 45
        Top = 92
        Width = 87
        Height = 13
        Alignment = taRightJustify
        Caption = 'lFk_SubGrupos'
        FocusControl = eFk_SubGrupos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lFk_Unidades: TLabel [5]
        Left = 53
        Top = 115
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
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lQtd_Uni: TLabel [6]
        Left = 83
        Top = 187
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'lQtd_Uni'
        FocusControl = eQtd_Uni
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lVlr_Uni: TLabel [7]
        Left = 360
        Top = 187
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = 'lVlr_Uni'
        FocusControl = eVlr_Uni
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lCod_Ref: TLabel [8]
        Left = 320
        Top = 20
        Width = 53
        Height = 13
        Alignment = taRightJustify
        Caption = 'lCod_Ref'
        FocusControl = eCod_Ref
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lCod_Barra: TLabel [9]
        Left = 70
        Top = 163
        Width = 63
        Height = 13
        Alignment = taRightJustify
        Caption = 'lCod_Barra'
        FocusControl = eCod_Barra
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lObs_Srv: TLabel [10]
        Left = 0
        Top = 211
        Width = 544
        Height = 13
        Align = alBottom
        Alignment = taCenter
        Caption = 'lObs_Srv'
        FocusControl = eObs_Srv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object sbGetRef: TSpeedButton [11]
        Left = 504
        Top = 16
        Width = 23
        Height = 22
        Flat = True
        OnClick = sbGetRefClick
      end
      object ePk_Servicos_Ind: TDBEdit
        Left = 136
        Top = 16
        Width = 113
        Height = 21
        Color = clTeal
        DataField = 'PK_SERVICOS_IND'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 1
        OnDblClick = ComponentDblClick
      end
      object eDsc_Srv: TDBEdit
        Left = 136
        Top = 136
        Width = 390
        Height = 21
        CharCase = ecUpperCase
        DataField = 'DSC_SRV'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 2
        OnDblClick = ComponentDblClick
      end
      object eFk_Secoes: TDBLookupComboBox
        Left = 136
        Top = 40
        Width = 391
        Height = 21
        DataField = 'FK_SECOES'
        DataSource = dsMain
        KeyField = 'PK_SECOES'
        ListField = 'DSC_SEC'
        ListSource = Secoes
        PopupMenu = pmFields
        TabOrder = 3
      end
      object eFk_Grupos: TDBLookupComboBox
        Left = 136
        Top = 64
        Width = 391
        Height = 21
        DataField = 'FK_GRUPOS'
        DataSource = dsMain
        KeyField = 'PK_GRUPOS'
        ListField = 'DSC_GRU'
        ListSource = Grupos
        PopupMenu = pmFields
        TabOrder = 4
      end
      object eFk_SubGrupos: TDBLookupComboBox
        Left = 136
        Top = 88
        Width = 391
        Height = 21
        DataField = 'FK_SUBGRUPOS'
        DataSource = dsMain
        KeyField = 'PK_SUBGRUPOS'
        ListField = 'DSC_SGRU'
        ListSource = SubGrupos
        PopupMenu = pmFields
        TabOrder = 5
      end
      object eFk_Unidades: TDBLookupComboBox
        Left = 136
        Top = 112
        Width = 391
        Height = 21
        DataField = 'FK_UNIDADES'
        DataSource = dsMain
        KeyField = 'PK_UNIDADES'
        ListField = 'DSC_UNI'
        ListSource = Unidades
        PopupMenu = pmFields
        TabOrder = 6
      end
      object eQtd_Uni: TJvDBCalcEdit
        Left = 136
        Top = 184
        Width = 121
        Height = 21
        DataField = 'QTD_UNI'
        DataSource = dsMain
        DecimalPlaces = 4
        DisplayFormat = ',0.####'
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 7
        ZeroEmpty = False
        OnDblClick = ComponentDblClick
      end
      object eVlr_Uni: TJvDBCalcEdit
        Left = 408
        Top = 184
        Width = 121
        Height = 21
        DataField = 'VLR_UNI'
        DataSource = dsMain
        DecimalPlaces = 4
        DisplayFormat = ',0.####'
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 8
        ZeroEmpty = False
        OnDblClick = ComponentDblClick
      end
      object eCod_Ref: TDBEdit
        Left = 376
        Top = 16
        Width = 125
        Height = 21
        CharCase = ecUpperCase
        DataField = 'COD_REF'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 9
        OnDblClick = ComponentDblClick
      end
      object eCod_Barra: TDBEdit
        Left = 136
        Top = 160
        Width = 209
        Height = 21
        CharCase = ecUpperCase
        DataField = 'COD_BARRA'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 10
        OnDblClick = ComponentDblClick
      end
      object eObs_Srv: TDBMemo
        Left = 0
        Top = 224
        Width = 544
        Height = 98
        Align = alBottom
        DataField = 'OBS_SRV'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 11
        OnDblClick = ComponentDblClick
      end
      object lFlag_Atv: TDBCheckBox
        Left = 352
        Top = 162
        Width = 177
        Height = 17
        Caption = 'lFlag_Atv'
        DataField = 'FLAG_ATV'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 12
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    inherited tsTable: TTabSheet
      inherited dbgGrid: TDBGrid
        Height = 293
      end
    end
  end
  inherited Panel1: TPanel
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  object Secoes: TDataSource
    DataSet = dmSysCosts.Secoes
    Left = 264
    Top = 64
  end
  object Grupos: TDataSource
    DataSet = dmSysCosts.Grupos
    Left = 296
    Top = 64
  end
  object SubGrupos: TDataSource
    DataSet = dmSysCosts.SubGrupos
    Left = 328
    Top = 64
  end
  object Unidades: TDataSource
    DataSet = dmSysCosts.Unidades
    Left = 360
    Top = 64
  end
end
