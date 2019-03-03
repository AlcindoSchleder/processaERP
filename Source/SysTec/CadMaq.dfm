inherited CdMaquinas: TCdMaquinas
  Caption = 'CdMaquinas'
  ClientHeight = 505
  ClientWidth = 574
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 574
  end
  inherited ControlBar: TControlBar
    Width = 574
  end
  inherited Painel: TStatusBar
    Top = 486
    Width = 574
  end
  inherited Control: TPageControl
    Width = 574
    Height = 375
    inherited tsDataAware: TTabSheet
      object lPk_Maquinas: TLabel [0]
        Left = 69
        Top = 19
        Width = 80
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Maquinas'
        FocusControl = ePk_Maquinas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lDsc_Maq: TLabel [1]
        Left = 92
        Top = 115
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Maq'
        FocusControl = eDsc_Maq
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lFk_Vw_Fornecedores: TLabel [2]
        Left = 23
        Top = 139
        Width = 126
        Height = 13
        Alignment = taRightJustify
        Caption = 'lFk_Vw_Fornecedores'
        FocusControl = eFk_Vw_Fornecedores
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lDta_Aqu: TLabel [3]
        Left = 96
        Top = 163
        Width = 53
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDta_Aqu'
        FocusControl = eDta_Aqu
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lPot_Maq: TLabel [4]
        Left = 375
        Top = 163
        Width = 54
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPot_Maq'
        FocusControl = ePot_Maq
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        PopupMenu = pmFields
        OnDblClick = ComponentDblClick
      end
      object lNum_Ope: TLabel [5]
        Left = 90
        Top = 188
        Width = 59
        Height = 13
        Alignment = taRightJustify
        Caption = 'lNum_Ope'
        FocusControl = eNum_Ope
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lDta_URvs: TLabel [6]
        Left = 367
        Top = 188
        Width = 62
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDta_URvs'
        FocusControl = eDta_URvs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lTmmp_Maq: TLabel [7]
        Left = 81
        Top = 212
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'lTmmp_Maq'
        FocusControl = eTmmp_Maq
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lMtbf_Maq: TLabel [8]
        Left = 369
        Top = 212
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'lMtbf_Maq'
        FocusControl = eMtbf_Maq
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lFk_Secoes: TLabel [9]
        Left = 82
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
        OnDblClick = ComponentDblClick
      end
      object lFk_Grupos: TLabel [10]
        Left = 84
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
        OnDblClick = ComponentDblClick
      end
      object lFk_SubGrupos: TLabel [11]
        Left = 62
        Top = 91
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
        OnDblClick = ComponentDblClick
      end
      object lCod_Ref: TLabel [12]
        Left = 352
        Top = 19
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
      object sbGetRef: TSpeedButton [13]
        Left = 528
        Top = 16
        Width = 23
        Height = 22
        Flat = True
        OnClick = sbGetRefClick
      end
      object ePk_Maquinas: TDBEdit
        Left = 152
        Top = 16
        Width = 113
        Height = 21
        Color = clTeal
        DataField = 'PK_MAQUINAS'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 1
        OnDblClick = ComponentDblClick
      end
      object eDsc_Maq: TDBEdit
        Left = 152
        Top = 112
        Width = 401
        Height = 21
        CharCase = ecUpperCase
        DataField = 'DSC_MAQ'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 2
        OnDblClick = ComponentDblClick
      end
      object eFk_Vw_Fornecedores: TDBLookupComboBox
        Tag = 2
        Left = 152
        Top = 136
        Width = 401
        Height = 21
        DataField = 'FK_VW_FORNECEDORES'
        DataSource = dsMain
        KeyField = 'PK_CADASTROS'
        ListField = 'RAZ_SOC'
        ListSource = Fornecedores
        PopupMenu = pmFields
        TabOrder = 3
      end
      object eDta_Aqu: TJvDBDateEdit
        Tag = 1
        Left = 152
        Top = 160
        Width = 121
        Height = 21
        DataField = 'DTA_AQU'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 4
      end
      object ePot_Maq: TJvDBCalcEdit
        Left = 432
        Top = 160
        Width = 121
        Height = 21
        DataField = 'POT_MAQ'
        DataSource = dsMain
        DecimalPlaces = 4
        DisplayFormat = ',0.####'
        NumGlyphs = 2
        PopupMenu = pmFields
        TabOrder = 5
        OnDblClick = ComponentDblClick
      end
      object eNum_Ope: TJvDBCalcEdit
        Tag = 1
        Left = 152
        Top = 184
        Width = 121
        Height = 21
        DataField = 'NUM_OPE'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ButtonWidth = 0
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 6
        ZeroEmpty = False
      end
      object eDta_URvs: TJvDBDateEdit
        Tag = 1
        Left = 432
        Top = 184
        Width = 121
        Height = 21
        DataField = 'DTA_URVS'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 7
      end
      object eTmmp_Maq: TJvDBCalcEdit
        Tag = 1
        Left = 152
        Top = 208
        Width = 121
        Height = 21
        DataField = 'TMMP_MAQ'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ButtonWidth = 0
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 8
        ZeroEmpty = False
      end
      object eMtbf_Maq: TJvDBCalcEdit
        Tag = 1
        Left = 432
        Top = 208
        Width = 121
        Height = 21
        DataField = 'MTBF_MAQ'
        DataSource = dsMain
        DecimalPlaces = 0
        DisplayFormat = ',0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ButtonWidth = 0
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 9
        ZeroEmpty = False
      end
      object eFk_Secoes: TDBLookupComboBox
        Tag = 2
        Left = 152
        Top = 40
        Width = 401
        Height = 21
        DataField = 'FK_SECOES'
        DataSource = dsMain
        KeyField = 'PK_SECOES'
        ListField = 'DSC_SEC'
        ListSource = Secoes
        PopupMenu = pmFields
        TabOrder = 10
      end
      object eFk_Grupos: TDBLookupComboBox
        Tag = 2
        Left = 152
        Top = 64
        Width = 401
        Height = 21
        DataField = 'FK_GRUPOS'
        DataSource = dsMain
        KeyField = 'PK_GRUPOS'
        ListField = 'DSC_GRU'
        ListSource = Grupos
        PopupMenu = pmFields
        TabOrder = 11
      end
      object eFk_SubGrupos: TDBLookupComboBox
        Tag = 2
        Left = 152
        Top = 88
        Width = 401
        Height = 21
        DataField = 'FK_SUBGRUPOS'
        DataSource = dsMain
        KeyField = 'PK_SUBGRUPOS'
        ListField = 'DSC_SGRU'
        ListSource = SubGrupos
        PopupMenu = pmFields
        TabOrder = 12
      end
      object eCod_Ref: TDBEdit
        Left = 408
        Top = 16
        Width = 121
        Height = 21
        DataField = 'COD_REF'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 13
        OnDblClick = ComponentDblClick
      end
      object lObs_Maq: TStaticText
        Left = 0
        Top = 231
        Width = 566
        Height = 17
        Align = alBottom
        Alignment = taCenter
        BorderStyle = sbsSunken
        Caption = 'lObs_Maq'
        TabOrder = 14
      end
      object eObs_Maq: TDBMemo
        Left = 0
        Top = 248
        Width = 566
        Height = 95
        Align = alBottom
        DataField = 'OBS_MAQ'
        DataSource = dsMain
        TabOrder = 15
      end
    end
  end
  inherited Panel1: TPanel
    Width = 574
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 133
    end
  end
  inherited pCompany: TPanel
    Width = 574
    inherited lNameCompany: TLabel
      Width = 552
    end
    inherited Panel2: TPanel
      Left = 554
    end
  end
  object Fornecedores: TDataSource
    DataSet = dmSysCosts.Fornecedores
    Left = 264
    Top = 64
  end
  object Secoes: TDataSource
    DataSet = dmSysCosts.Secoes
    Left = 296
    Top = 64
  end
  object Grupos: TDataSource
    DataSet = dmSysCosts.Grupos
    Left = 328
    Top = 64
  end
  object SubGrupos: TDataSource
    DataSet = dmSysCosts.SubGrupos
    Left = 360
    Top = 64
  end
end
