inherited CdPecas: TCdPecas
  Left = 297
  Top = 95
  Width = 595
  Height = 597
  Caption = 'CdPecas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 587
  end
  inherited ControlBar: TControlBar
    Width = 587
  end
  inherited Painel: TStatusBar
    Top = 524
    Width = 587
  end
  inherited Control: TPageControl
    Width = 587
    Height = 413
    inherited tsDataAware: TTabSheet
      object stPartName: TStaticText
        Left = 0
        Top = 0
        Width = 579
        Height = 24
        Align = alTop
        Alignment = taCenter
        BorderStyle = sbsSunken
        Caption = 'stPartName'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object pgControl: TPageControl
        Left = 0
        Top = 24
        Width = 579
        Height = 357
        ActivePage = tsParts
        Align = alClient
        Images = Dados.Image16
        TabOrder = 2
        OnChange = pgControlChange
        OnChanging = pgControlChanging
        object tsParts: TTabSheet
          Caption = 'tsParts'
          ImageIndex = 26
          object pcMaterials: TPageControl
            Left = 0
            Top = 0
            Width = 571
            Height = 328
            ActivePage = tsDescription
            Align = alClient
            Images = Dados.Image16
            Style = tsFlatButtons
            TabOrder = 0
            object tsDescription: TTabSheet
              Caption = 'tsDescription'
              object lDsc_Pec: TLabel
                Left = 78
                Top = 27
                Width = 55
                Height = 13
                Alignment = taRightJustify
                Caption = 'lDsc_Pec'
                FocusControl = eDsc_Pec
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lFk_Secoes: TLabel
                Left = 66
                Top = 52
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
              object lFk_Grupos: TLabel
                Left = 68
                Top = 76
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
              object lFk_SubGrupos: TLabel
                Left = 46
                Top = 100
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
              object lAlt_Pec: TLabel
                Left = 85
                Top = 171
                Width = 48
                Height = 13
                Alignment = taRightJustify
                Caption = 'lAlt_Pec'
                FocusControl = eAlt_Pec
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lProf_Pec: TLabel
                Left = 77
                Top = 148
                Width = 56
                Height = 13
                Alignment = taRightJustify
                Caption = 'lProf_Pec'
                FocusControl = eProf_Pec
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lLarg_Pec: TLabel
                Left = 75
                Top = 123
                Width = 58
                Height = 13
                Alignment = taRightJustify
                Caption = 'lLarg_Pec'
                FocusControl = eLarg_Pec
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lFk_Pecas: TLabel
                Left = 73
                Top = 3
                Width = 60
                Height = 13
                Alignment = taRightJustify
                Caption = 'lFk_Pecas'
                FocusControl = eFk_Pecas
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lCod_Ref: TLabel
                Left = 344
                Top = 3
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
              object sbGetRef: TSpeedButton
                Left = 528
                Top = 0
                Width = 23
                Height = 22
                Flat = True
                OnClick = sbGetRefClick
              end
              object eDsc_Pec: TDBEdit
                Left = 136
                Top = 24
                Width = 417
                Height = 21
                CharCase = ecUpperCase
                DataField = 'DSC_PEC'
                PopupMenu = pmFields
                TabOrder = 2
                OnDblClick = ComponentDblClick
              end
              object eFk_Grupos: TDBLookupComboBox
                Left = 136
                Top = 72
                Width = 420
                Height = 21
                DataField = 'FK_GRUPOS'
                KeyField = 'PK_GRUPOS'
                ListField = 'DSC_GRU'
                ListSource = Grupos
                PopupMenu = pmFields
                TabOrder = 4
              end
              object eFk_Secoes: TDBLookupComboBox
                Left = 136
                Top = 48
                Width = 420
                Height = 21
                DataField = 'FK_SECOES'
                KeyField = 'PK_SECOES'
                ListField = 'DSC_SEC'
                ListSource = Secoes
                PopupMenu = pmFields
                TabOrder = 3
              end
              object eFk_SubGrupos: TDBLookupComboBox
                Left = 136
                Top = 96
                Width = 420
                Height = 21
                DataField = 'FK_SUBGRUPOS'
                KeyField = 'PK_SUBGRUPOS'
                ListField = 'DSC_SGRU'
                ListSource = SubGrupos
                PopupMenu = pmFields
                TabOrder = 5
              end
              object eAlt_Pec: TJvDBCalcEdit
                Left = 136
                Top = 168
                Width = 129
                Height = 21
                DataField = 'ALT_PEC'
                DecimalPlaces = 4
                DisplayFormat = ',0.####'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                NumGlyphs = 2
                ParentFont = False
                PopupMenu = pmFields
                TabOrder = 8
                OnDblClick = ComponentDblClick
              end
              object eProf_Pec: TJvDBCalcEdit
                Left = 136
                Top = 144
                Width = 129
                Height = 21
                DataField = 'PROF_PEC'
                DecimalPlaces = 4
                DisplayFormat = ',0.####'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                NumGlyphs = 2
                ParentFont = False
                PopupMenu = pmFields
                TabOrder = 7
                OnDblClick = ComponentDblClick
              end
              object eLarg_Pec: TJvDBCalcEdit
                Left = 136
                Top = 120
                Width = 129
                Height = 21
                DataField = 'LARG_PEC'
                DecimalPlaces = 4
                DisplayFormat = ',0.####'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                NumGlyphs = 2
                ParentFont = False
                PopupMenu = pmFields
                TabOrder = 6
                OnDblClick = ComponentDblClick
              end
              object pPanel: TPanel
                Left = 296
                Top = 120
                Width = 257
                Height = 177
                BevelInner = bvLowered
                BevelOuter = bvNone
                BevelWidth = 2
                Color = clWindow
                TabOrder = 10
                object imImg_Pec: TImage
                  Left = 2
                  Top = 23
                  Width = 253
                  Height = 152
                  Align = alClient
                  Center = True
                  PopupMenu = popImgIns
                  Proportional = True
                  OnDblClick = imImg_PecDblClick
                end
                object lImg_Pec: TStaticText
                  Left = 2
                  Top = 2
                  Width = 253
                  Height = 21
                  Align = alTop
                  Alignment = taCenter
                  AutoSize = False
                  BevelKind = bkSoft
                  Caption = 'lImg_Pec'
                  Color = clBtnFace
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -11
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentColor = False
                  ParentFont = False
                  TabOrder = 0
                end
              end
              object lFlag_TComp: TDBRadioGroup
                Left = 0
                Top = 208
                Width = 289
                Height = 89
                Caption = 'lFlag_TComp'
                Columns = 2
                DataField = 'FLAG_TCOMP'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                Items.Strings = (
                  'Pe'#231'a'
                  'Componente'
                  'Produo Semi-Acabado'
                  'Produto Lista'
                  'Produto Acabados')
                ParentFont = False
                TabOrder = 9
                Values.Strings = (
                  '0'
                  '1'
                  '2'
                  '3'
                  '4')
              end
              object eFk_Pecas: TDBEdit
                Left = 136
                Top = 0
                Width = 129
                Height = 21
                DataField = 'FK_PECAS'
                PopupMenu = pmFields
                TabOrder = 0
                OnDblClick = ComponentDblClick
              end
              object eCod_Ref: TDBEdit
                Left = 400
                Top = 0
                Width = 129
                Height = 21
                CharCase = ecUpperCase
                DataField = 'COD_REF'
                PopupMenu = pmFields
                TabOrder = 1
                OnDblClick = ComponentDblClick
              end
            end
            object tsVersion: TTabSheet
              Caption = 'tsVersion'
              ImageIndex = 38
              object lDta_Last_Prd: TLabel
                Left = 68
                Top = 44
                Width = 81
                Height = 13
                Alignment = taRightJustify
                Caption = 'lDta_Last_Prd'
                FocusControl = eDta_Last_Prd
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lDta_First_Lib: TLabel
                Left = 70
                Top = 76
                Width = 79
                Height = 13
                Alignment = taRightJustify
                Caption = 'lDta_First_Lib'
                FocusControl = eDta_First_Lib
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lDta_Last_Lib: TLabel
                Left = 70
                Top = 109
                Width = 79
                Height = 13
                Alignment = taRightJustify
                Caption = 'lDta_Last_Lib'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lMaj_Ver: TLabel
                Left = 99
                Top = 195
                Width = 50
                Height = 13
                Alignment = taRightJustify
                Caption = 'lMaj_Ver'
                FocusControl = eMaj_Ver
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lMin_Ver: TLabel
                Left = 99
                Top = 219
                Width = 50
                Height = 13
                Alignment = taRightJustify
                Caption = 'lMin_Ver'
                FocusControl = eMin_Ver
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lPk_Ficha_Tecnica: TLabel
                Left = 39
                Top = 11
                Width = 110
                Height = 13
                Alignment = taRightJustify
                Caption = 'lPk_Ficha_Tecnica'
                FocusControl = ePk_Ficha_Tecnica
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object lMot_NVer: TLabel
                Left = 89
                Top = 243
                Width = 60
                Height = 13
                Alignment = taRightJustify
                Caption = 'lMot_NVer'
                FocusControl = eMot_NVer
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                PopupMenu = pmFields
                OnDblClick = ComponentDblClick
              end
              object eDta_Last_Prd: TDBDateEdit
                Left = 152
                Top = 40
                Width = 121
                Height = 21
                DataField = 'DTA_LAST_PRD'
                NumGlyphs = 2
                TabOrder = 1
              end
              object eDta_First_Lib: TDBDateEdit
                Left = 152
                Top = 72
                Width = 121
                Height = 21
                DataField = 'DTA_FIRST_LIB'
                NumGlyphs = 2
                TabOrder = 2
              end
              object eDta_Last_Lib: TDBDateEdit
                Left = 152
                Top = 104
                Width = 121
                Height = 21
                DataField = 'DTA_LAST_LIB'
                NumGlyphs = 2
                TabOrder = 3
              end
              object lFlag_Atv: TDBCheckBox
                Left = 152
                Top = 136
                Width = 377
                Height = 17
                Caption = 'lFlag_Atv'
                DataField = 'FLAG_ATV'
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
              object lFlag_Op: TDBCheckBox
                Left = 152
                Top = 160
                Width = 377
                Height = 17
                Caption = 'lFlag_Op'
                DataField = 'FLAG_OP'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 5
                ValueChecked = '1'
                ValueUnchecked = '0'
              end
              object eMaj_Ver: TDBEdit
                Left = 152
                Top = 192
                Width = 129
                Height = 21
                DataField = 'MAJ_VER'
                PopupMenu = pmFields
                TabOrder = 6
                OnDblClick = ComponentDblClick
              end
              object eMin_Ver: TDBEdit
                Left = 152
                Top = 216
                Width = 129
                Height = 21
                DataField = 'MIN_VER'
                PopupMenu = pmFields
                TabOrder = 7
                OnDblClick = ComponentDblClick
              end
              object ePk_Ficha_Tecnica: TDBEdit
                Left = 152
                Top = 8
                Width = 129
                Height = 21
                DataField = 'PK_FICHA_TECNICA'
                PopupMenu = pmFields
                TabOrder = 0
                OnDblClick = ComponentDblClick
              end
              object eMot_NVer: TDBEdit
                Left = 152
                Top = 240
                Width = 393
                Height = 21
                CharCase = ecUpperCase
                DataField = 'MOT_NVER'
                PopupMenu = pmFields
                TabOrder = 8
                OnDblClick = ComponentDblClick
              end
            end
            object tsComplement: TTabSheet
              Caption = 'tsComplement'
              ImageIndex = 60
              object Panel4: TPanel
                Left = 0
                Top = 0
                Width = 563
                Height = 296
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object eObs_Pec: TDBMemo
                  Left = 0
                  Top = 21
                  Width = 563
                  Height = 275
                  Align = alClient
                  DataField = 'OBS_PEC'
                  PopupMenu = pmFields
                  TabOrder = 0
                  OnDblClick = ComponentDblClick
                end
                object lObs_Pec: TStaticText
                  Left = 0
                  Top = 0
                  Width = 563
                  Height = 21
                  Align = alTop
                  Alignment = taCenter
                  AutoSize = False
                  BorderStyle = sbsSunken
                  Caption = 'lObs_Pec'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlue
                  Font.Height = -16
                  Font.Name = 'MS Sans Serif'
                  Font.Style = [fsBold]
                  ParentFont = False
                  PopupMenu = pmFields
                  TabOrder = 1
                  OnDblClick = ComponentDblClick
                end
              end
            end
          end
        end
        object tsCosts: TTabSheet
          Caption = 'tsCosts'
          ImageIndex = 39
          object lDta_Prv_Prd: TLabel
            Left = 353
            Top = 93
            Width = 76
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Prv_Prd'
            FocusControl = eDta_Prv_Prd
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lQtd_Dias_Estq: TLabel
            Left = 36
            Top = 116
            Width = 88
            Height = 13
            Alignment = taRightJustify
            Caption = 'lQtd_Dias_Estq'
            FocusControl = eQtd_Dias_Estq
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lQtd_Cns_Med: TLabel
            Left = 346
            Top = 116
            Width = 83
            Height = 13
            Alignment = taRightJustify
            Caption = 'lQtd_Cns_Med'
            FocusControl = eQtd_Cns_Med
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lQtd_EPrd: TLabel
            Left = 66
            Top = 92
            Width = 58
            Height = 13
            Alignment = taRightJustify
            Caption = 'lQtd_EPrd'
            FocusControl = eQtd_EPrd
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lQtdEstq: TLabel
            Left = 69
            Top = 20
            Width = 56
            Height = 13
            Alignment = taRightJustify
            Caption = 'lQtd_Estq'
            FocusControl = eQtdEstq
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lQtdMin: TLabel
            Left = 66
            Top = 44
            Width = 59
            Height = 13
            Alignment = taRightJustify
            Caption = 'lQtd_EMin'
            FocusControl = eQtdMin
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lQtdMax: TLabel
            Left = 62
            Top = 68
            Width = 62
            Height = 13
            Alignment = taRightJustify
            Caption = 'lQtd_EMax'
            FocusControl = eQtdMax
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lQtd_UPrd: TLabel
            Left = 370
            Top = 20
            Width = 59
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_UPrd'
            FocusControl = eDta_UPrd
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDtaUInv: TLabel
            Left = 371
            Top = 44
            Width = 58
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_UInv'
            FocusControl = eDtaUInv
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDtaURsv: TLabel
            Left = 367
            Top = 69
            Width = 62
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_URsv'
            FocusControl = eDtaURsv
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object eDta_Prv_Prd: TJvDBDateEdit
            Tag = 1
            Left = 432
            Top = 88
            Width = 121
            Height = 21
            DataField = 'DTA_PRV_PRD'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 7
            OnDblClick = ComponentDblClick
          end
          object eQtd_Dias_Estq: TJvDBCalcEdit
            Tag = 1
            Left = 128
            Top = 112
            Width = 121
            Height = 21
            DataField = 'QTD_DIAS_ESTQ'
            DecimalPlaces = 4
            DisplayFormat = ',0.####'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ButtonWidth = 0
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 8
            OnDblClick = ComponentDblClick
          end
          object eQtd_Cns_Med: TJvDBCalcEdit
            Tag = 1
            Left = 432
            Top = 112
            Width = 121
            Height = 21
            DataField = 'QTD_CNS_MED'
            DecimalPlaces = 4
            DisplayFormat = ',0.####'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ButtonWidth = 0
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 9
            OnDblClick = ComponentDblClick
          end
          object eQtd_EPrd: TJvDBCalcEdit
            Tag = 1
            Left = 128
            Top = 88
            Width = 121
            Height = 21
            DataField = 'QTD_EPRD'
            DecimalPlaces = 4
            DisplayFormat = ',0.####'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ButtonWidth = 0
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 3
            OnDblClick = ComponentDblClick
          end
          object eQtdEstq: TJvDBCalcEdit
            Tag = 1
            Left = 128
            Top = 16
            Width = 121
            Height = 21
            DataField = 'QTD_ESTQ'
            DecimalPlaces = 4
            DisplayFormat = ',0.####'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ButtonWidth = 0
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 0
            OnDblClick = ComponentDblClick
          end
          object eQtdMin: TJvDBCalcEdit
            Tag = 1
            Left = 128
            Top = 40
            Width = 121
            Height = 21
            DataField = 'QTD_EMIN'
            DecimalPlaces = 4
            DisplayFormat = ',0.####'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ButtonWidth = 0
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 1
            OnDblClick = ComponentDblClick
          end
          object eQtdMax: TJvDBCalcEdit
            Tag = 1
            Left = 128
            Top = 64
            Width = 121
            Height = 21
            DataField = 'QTD_EMAX'
            DecimalPlaces = 4
            DisplayFormat = ',0.####'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ButtonWidth = 0
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 2
            OnDblClick = ComponentDblClick
          end
          object eDta_UPrd: TJvDBDateEdit
            Tag = 1
            Left = 432
            Top = 16
            Width = 121
            Height = 21
            DataField = 'DTA_UPRD'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 4
            OnDblClick = ComponentDblClick
          end
          object eDtaUInv: TJvDBDateEdit
            Tag = 1
            Left = 432
            Top = 40
            Width = 121
            Height = 21
            DataField = 'DTA_UINV'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 5
            OnDblClick = ComponentDblClick
          end
          object eDtaURsv: TJvDBDateEdit
            Tag = 1
            Left = 432
            Top = 64
            Width = 121
            Height = 21
            DataField = 'DTA_URSV'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 6
            OnDblClick = ComponentDblClick
          end
          object pHistoric: TPanel
            Left = 0
            Top = 138
            Width = 571
            Height = 22
            Align = alBottom
            Alignment = taLeftJustify
            BevelOuter = bvLowered
            Caption = 'pHistoric'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 10
          end
          object vtHistoric: TCSDVirtualStringTree
            Left = 0
            Top = 160
            Width = 571
            Height = 168
            Align = alBottom
            BorderStyle = bsSingle
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Images = Dados.Image16
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HintMode = hmDefault
            Images = Dados.Image16
            IncrementalSearchDirection = sdForward
            LineMode = lmBands
            RootNodeCount = 4
            TabOrder = 11
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            OnEditing = vtHistoricEditing
            AutoEdit = False
            ColumnDefs = <
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end>
            MustBlockBoundaryEditExit = True
            Columns = <
              item
                ImageIndex = 60
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 0
                Width = 100
                WideText = 'Data / Hora'
              end
              item
                ImageIndex = 47
                Position = 1
                Width = 100
                WideText = 'Num.Doc.'
              end
              item
                ImageIndex = 53
                Position = 2
                Width = 100
                WideText = 'Entrada'
              end
              item
                ImageIndex = 68
                Position = 3
                Width = 100
                WideText = 'Sa'#237'da'
              end
              item
                ImageIndex = 42
                Position = 4
                Width = 100
                WideText = 'Saldo'
              end
              item
                ImageIndex = 52
                Position = 5
                Width = 300
                WideText = 'Cadastro'
              end
              item
                ImageIndex = 38
                Position = 6
                Width = 300
                WideText = 'Tipo de Movimento'
              end>
          end
        end
        object tsSupply: TTabSheet
          Caption = 'tsSupply'
          ImageIndex = 26
          object lFk_Almoxarifados: TLabel
            Left = 78
            Top = 20
            Width = 103
            Height = 13
            Alignment = taRightJustify
            Caption = 'lFk_Almoxarifados'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            OnDblClick = ComponentDblClick
          end
          object gbQuantity: TGroupBox
            Left = 0
            Top = 48
            Width = 571
            Height = 114
            Align = alBottom
            Caption = 'gbQuantity'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object lQtd_EMax: TLabel
              Left = 62
              Top = 68
              Width = 62
              Height = 13
              Alignment = taRightJustify
              Caption = 'lQtd_EMax'
              FocusControl = eQtd_EMax
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lQtd_EMin: TLabel
              Left = 66
              Top = 44
              Width = 59
              Height = 13
              Alignment = taRightJustify
              Caption = 'lQtd_EMin'
              FocusControl = eQtd_EMin
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lDta_UInv: TLabel
              Left = 371
              Top = 44
              Width = 58
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDta_UInv'
              FocusControl = eDta_UInv
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lDta_URsv: TLabel
              Left = 367
              Top = 69
              Width = 62
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDta_URsv'
              FocusControl = eDta_URsv
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lQtd_Estq: TLabel
              Left = 69
              Top = 20
              Width = 56
              Height = 13
              Alignment = taRightJustify
              Caption = 'lQtd_Estq'
              FocusControl = eQtd_Estq
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lDta_UMov: TLabel
              Left = 365
              Top = 20
              Width = 64
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDta_UMov'
              FocusControl = eDta_UMov
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lQtd_Rsrv: TLabel
              Left = 68
              Top = 92
              Width = 57
              Height = 13
              Alignment = taRightJustify
              Caption = 'lQtd_Rsrv'
              FocusControl = eQtd_Rsrv
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lDta_USld: TLabel
              Left = 371
              Top = 93
              Width = 58
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDta_USld'
              FocusControl = eDta_USld
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object eQtd_EMax: TJvDBCalcEdit
              Tag = 2
              Left = 128
              Top = 64
              Width = 121
              Height = 21
              DataField = 'QTD_EMAX'
              DecimalPlaces = 4
              DisplayFormat = ',0.####'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ButtonWidth = 0
              NumGlyphs = 2
              ParentFont = False
              PopupMenu = pmFields
              TabOrder = 2
              OnDblClick = ComponentDblClick
            end
            object eQtd_EMin: TJvDBCalcEdit
              Tag = 2
              Left = 128
              Top = 40
              Width = 121
              Height = 21
              DataField = 'QTD_EMIN'
              DecimalPlaces = 4
              DisplayFormat = ',0.####'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ButtonWidth = 0
              NumGlyphs = 2
              ParentFont = False
              PopupMenu = pmFields
              TabOrder = 1
              OnDblClick = ComponentDblClick
            end
            object eDta_UInv: TJvDBDateEdit
              Tag = 2
              Left = 432
              Top = 40
              Width = 121
              Height = 21
              DataField = 'DTA_UINV'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              NumGlyphs = 2
              ParentFont = False
              PopupMenu = pmFields
              TabOrder = 4
              OnDblClick = ComponentDblClick
            end
            object eDta_URsv: TJvDBDateEdit
              Tag = 2
              Left = 432
              Top = 64
              Width = 121
              Height = 21
              DataField = 'DTA_URSV'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              NumGlyphs = 2
              ParentFont = False
              PopupMenu = pmFields
              TabOrder = 5
              OnDblClick = ComponentDblClick
            end
            object eQtd_Estq: TJvDBCalcEdit
              Tag = 2
              Left = 128
              Top = 16
              Width = 121
              Height = 21
              DataField = 'QTD_ESTQ'
              DecimalPlaces = 4
              DisplayFormat = ',0.####'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ButtonWidth = 0
              NumGlyphs = 2
              ParentFont = False
              PopupMenu = pmFields
              TabOrder = 0
              OnDblClick = ComponentDblClick
            end
            object eDta_UMov: TJvDBDateEdit
              Tag = 2
              Left = 432
              Top = 16
              Width = 121
              Height = 21
              DataField = 'DTA_UMOV'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              NumGlyphs = 2
              ParentFont = False
              PopupMenu = pmFields
              TabOrder = 3
              OnDblClick = ComponentDblClick
            end
            object eQtd_Rsrv: TJvDBCalcEdit
              Tag = 2
              Left = 128
              Top = 88
              Width = 121
              Height = 21
              DataField = 'QTD_RSRV'
              DecimalPlaces = 4
              DisplayFormat = ',0.####'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ButtonWidth = 0
              NumGlyphs = 2
              ParentFont = False
              PopupMenu = pmFields
              TabOrder = 6
              OnDblClick = ComponentDblClick
            end
            object eDta_USld: TJvDBDateEdit
              Tag = 2
              Left = 432
              Top = 88
              Width = 121
              Height = 21
              DataField = 'DTA_USLD'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              NumGlyphs = 2
              ParentFont = False
              PopupMenu = pmFields
              TabOrder = 7
              OnDblClick = ComponentDblClick
            end
          end
          object pCapacities: TPanel
            Left = 0
            Top = 162
            Width = 571
            Height = 22
            Align = alBottom
            Alignment = taLeftJustify
            BevelOuter = bvLowered
            Caption = 'pCapacities'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object sbCapSave: TSpeedButton
              Left = 542
              Top = 2
              Width = 18
              Height = 18
              Flat = True
              Visible = False
              OnClick = sbCapSaveClick
            end
            object sbCapDelete: TSpeedButton
              Left = 522
              Top = 2
              Width = 18
              Height = 18
              Flat = True
              Visible = False
              OnClick = sbCapDeleteClick
            end
            object sbCapCancel: TSpeedButton
              Left = 502
              Top = 2
              Width = 18
              Height = 18
              Flat = True
              Visible = False
              OnClick = sbCapCancelClick
            end
          end
          object vtCapacities: TCSDVirtualStringTree
            Left = 0
            Top = 184
            Width = 571
            Height = 144
            Align = alBottom
            BorderStyle = bsSingle
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Images = Dados.Image16
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HintMode = hmDefault
            Images = Dados.Image16
            IncrementalSearchDirection = sdForward
            LineMode = lmBands
            RootNodeCount = 4
            TabOrder = 3
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            AutoEdit = False
            ColumnDefs = <
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = False
                CustomFldType = 2
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end>
            MustBlockBoundaryEditExit = True
            Columns = <
              item
                Alignment = taRightJustify
                ImageIndex = 60
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
                Position = 0
                Width = 150
                WideText = 'Quantidade'
              end
              item
                ImageIndex = 12
                Position = 1
                Width = 100
                WideText = 'Rua'
              end
              item
                ImageIndex = 19
                Position = 2
                Width = 100
                WideText = 'N'#237'vel'
              end
              item
                ImageIndex = 38
                Position = 3
                Width = 100
                WideText = 'Box'
              end>
          end
          object eFk_Almoxarifados: TDBLookupComboBox
            Tag = 2
            Left = 184
            Top = 16
            Width = 369
            Height = 21
            DataField = 'FK_ALMOXARIFADOS'
            KeyField = 'PK_ALMOXARIFADOS'
            ListField = 'DSC_ALMX'
            ListSource = Almoxarifados
            PopupMenu = pmFields
            TabOrder = 0
          end
        end
      end
    end
    inherited tsTable: TTabSheet
      inherited dbgGrid: TDBGrid
        Width = 580
        Height = 353
      end
      inherited SearchPanel: TPanel
        Width = 580
      end
    end
  end
  inherited Panel1: TPanel
    Width = 587
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 146
    end
  end
  inherited pCompany: TPanel
    Width = 587
    inherited lNameCompany: TLabel
      Width = 565
    end
    inherited Panel2: TPanel
      Left = 567
    end
  end
  object Secoes: TDataSource
    DataSet = dmSysPCP.Secoes
    Left = 264
    Top = 64
  end
  object Grupos: TDataSource
    DataSet = dmSysPCP.Grupos
    Left = 296
    Top = 64
  end
  object popImgIns: TPopupMenu
    Left = 424
    Top = 64
    object cmSelectImage: TMenuItem
      Caption = '&Selecionar Imagem'
      OnClick = imImg_PecDblClick
    end
    object cmDelImage: TMenuItem
      Caption = 'E&xcluir Imagem'
      OnClick = cmDelImageClick
    end
  end
  object op: TOpenPictureDialog
    DefaultExt = 'jpg'
    Filter = 'Windows MetaFile(*.wmf)|*.wmf'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 392
    Top = 64
  end
  object SubGrupos: TDataSource
    DataSet = dmSysPCP.SubGrupos
    Left = 328
    Top = 64
  end
  object Almoxarifados: TDataSource
    DataSet = dmSysPCP.Almoxarifados
    Left = 360
    Top = 64
  end
  object Pecas: TDataSource
    Left = 456
    Top = 64
  end
end
