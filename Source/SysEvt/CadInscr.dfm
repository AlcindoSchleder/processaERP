inherited CdInscricoes: TCdInscricoes
  Left = 211
  Top = 121
  Width = 800
  Height = 600
  Caption = 'CdInscricoes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 792
  end
  inherited ControlBar: TControlBar
    Width = 792
  end
  inherited Painel: TStatusBar
    Top = 527
    Width = 792
  end
  inherited Control: TPageControl
    Width = 792
    Height = 416
    inherited tsDataAware: TTabSheet
      inherited pbModel: TProgressBar
        TabOrder = 2
      end
      object pnCategories: TPanel
        Left = 592
        Top = 0
        Width = 192
        Height = 384
        Align = alRight
        BevelInner = bvLowered
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 0
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
        object vtEvents: TCSDVirtualStringTree
          Left = 2
          Top = 22
          Width = 188
          Height = 360
          Align = alClient
          BorderStyle = bsSingle
          CheckImageKind = ckXP
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
          RootNodeCount = 2
          TabOrder = 0
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware]
          TreeOptions.SelectionOptions = [toExtendedFocus]
          OnChange = vtEventsChange
          OnEditing = vtEventsEditing
          OnGetText = vtEventsGetText
          OnGetImageIndex = vtEventsGetImageIndex
          OnInitNode = vtEventsInitNode
          AutoEdit = False
          ColumnDefs = <
            item
              FldType = ctString
              MaxLength = 30
              ReadOnly = True
              CustomMaxLength = 30
            end>
          MustBlockBoundaryEditExit = True
          Columns = <
            item
              ImageIndex = 42
              Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
              Position = 0
              Style = vsOwnerDraw
              Width = 180
              WideText = 'Evento'
            end>
        end
      end
      object pData: TPanel
        Left = 0
        Top = 0
        Width = 592
        Height = 384
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pData'
        TabOrder = 1
        object pcControle: TPageControl
          Left = 0
          Top = 50
          Width = 592
          Height = 334
          ActivePage = tsData
          Align = alClient
          Images = Dados.Image16
          Style = tsFlatButtons
          TabOrder = 0
          object tsData: TTabSheet
            Caption = 'tsData'
            ImageIndex = 60
            object lPk_Inscricoes: TLabel
              Left = 65
              Top = 19
              Width = 84
              Height = 13
              Alignment = taRightJustify
              Caption = 'lPk_Inscricoes'
              FocusControl = ePk_Inscricoes
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lDoc_Sec: TLabel
              Left = 381
              Top = 43
              Width = 56
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDoc_Sec'
              FocusControl = eDoc_Sec
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lDoc_Pri: TLabel
              Left = 100
              Top = 43
              Width = 49
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDoc_Pri'
              FocusControl = eDoc_Pri
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lNom_Ins: TLabel
              Left = 96
              Top = 67
              Width = 53
              Height = 13
              Alignment = taRightJustify
              Caption = 'lNom_Ins'
              FocusControl = eNom_Ins
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lNom_Fan: TLabel
              Left = 92
              Top = 91
              Width = 57
              Height = 13
              Alignment = taRightJustify
              Caption = 'lNom_Fan'
              FocusControl = eNom_Fan
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lFk_Paises: TLabel
              Left = 87
              Top = 115
              Width = 62
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFk_Paises'
              FocusControl = eFk_Paises
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lFk_Estados: TLabel
              Left = 79
              Top = 139
              Width = 70
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFk_Estados'
              FocusControl = eFk_Estados
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lFk_Municipios: TLabel
              Left = 64
              Top = 163
              Width = 85
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFk_Municipios'
              FocusControl = eFk_Municipios
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lEnd_Cad: TLabel
              Left = 94
              Top = 187
              Width = 55
              Height = 13
              Alignment = taRightJustify
              Caption = 'lEnd_Cad'
              FocusControl = eEnd_Cad
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lNum_End: TLabel
              Left = 91
              Top = 211
              Width = 58
              Height = 13
              Alignment = taRightJustify
              Caption = 'lNum_End'
              FocusControl = eNum_End
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lCmp_End: TLabel
              Left = 92
              Top = 235
              Width = 57
              Height = 13
              Alignment = taRightJustify
              Caption = 'lCmp_End'
              FocusControl = eCmp_End
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lCep_Cad: TLabel
              Left = 382
              Top = 211
              Width = 55
              Height = 13
              Alignment = taRightJustify
              Caption = 'lCep_Cad'
              FocusControl = eCep_Cad
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object sbFindBai: TSpeedButton
              Left = 560
              Top = 232
              Width = 23
              Height = 22
              Flat = True
              OnClick = sbFindBaiClick
            end
            object sbFindCep: TSpeedButton
              Left = 560
              Top = 208
              Width = 23
              Height = 22
              Flat = True
              OnClick = sbFindCepClick
            end
            object sbFindLocal: TSpeedButton
              Left = 560
              Top = 184
              Width = 23
              Height = 22
              Flat = True
              OnClick = sbFindLocalClick
            end
            object lCrg_Ins: TLabel
              Left = 102
              Top = 259
              Width = 47
              Height = 13
              Alignment = taRightJustify
              Caption = 'lCrg_Ins'
              FocusControl = eCrg_Ins
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lFon_Cad: TLabel
              Left = 95
              Top = 283
              Width = 54
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFon_Cad'
              FocusControl = eFon_Cad
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lVlr_Ins: TLabel
              Left = 378
              Top = 283
              Width = 43
              Height = 13
              Alignment = taRightJustify
              Caption = 'lVlr_Ins'
              FocusControl = eVlr_Ins
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lFax_Cad: TLabel
              Left = 368
              Top = 259
              Width = 53
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFax_Cad'
              FocusControl = eFax_Cad
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object ePk_Inscricoes: TDBEdit
              Left = 152
              Top = 16
              Width = 113
              Height = 21
              Color = clTeal
              DataField = 'PK_INSCRICOES'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 0
              OnDblClick = ComponentDblClick
            end
            object lFlag_Cad: TDBRadioGroup
              Left = 272
              Top = 3
              Width = 313
              Height = 33
              Caption = 'lFlag_Cad'
              Columns = 2
              DataField = 'FLAG_CAD'
              DataSource = dsMain
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              Items.Strings = (
                'J'
                'F')
              ParentFont = False
              PopupMenu = pmFields
              TabOrder = 1
              Values.Strings = (
                '0'
                '1'
                '')
            end
            object eDoc_Sec: TDBEdit
              Left = 440
              Top = 40
              Width = 145
              Height = 21
              CharCase = ecUpperCase
              DataField = 'DOC_SEC'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 3
              OnDblClick = ComponentDblClick
            end
            object eDoc_Pri: TDBEdit
              Left = 152
              Top = 40
              Width = 145
              Height = 21
              CharCase = ecUpperCase
              DataField = 'DOC_PRI'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 2
              OnDblClick = ComponentDblClick
            end
            object eNom_Ins: TDBEdit
              Left = 152
              Top = 64
              Width = 433
              Height = 21
              CharCase = ecUpperCase
              DataField = 'NOM_INS'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 4
              OnDblClick = ComponentDblClick
            end
            object eNom_Fan: TDBEdit
              Left = 152
              Top = 88
              Width = 433
              Height = 21
              CharCase = ecUpperCase
              DataField = 'NOM_FAN'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 5
              OnDblClick = ComponentDblClick
            end
            object eFk_Paises: TDBLookupComboBox
              Left = 152
              Top = 112
              Width = 433
              Height = 21
              DataField = 'FK_PAISES'
              DataSource = dsMain
              KeyField = 'PK_PAISES'
              ListField = 'DSC_PAIS'
              ListSource = Paises
              PopupMenu = pmFields
              TabOrder = 6
            end
            object eFk_Estados: TDBLookupComboBox
              Left = 152
              Top = 136
              Width = 433
              Height = 21
              DataField = 'FK_ESTADOS'
              DataSource = dsMain
              KeyField = 'PK_ESTADOS'
              ListField = 'DSC_UF'
              ListSource = Estados
              PopupMenu = pmFields
              TabOrder = 7
            end
            object eFk_Municipios: TDBLookupComboBox
              Left = 152
              Top = 160
              Width = 433
              Height = 21
              DataField = 'FK_MUNICIPIOS'
              DataSource = dsMain
              KeyField = 'PK_MUNICIPIOS'
              ListField = 'DSC_MUN'
              ListSource = Municipios
              PopupMenu = pmFields
              TabOrder = 8
            end
            object eEnd_Cad: TDBEdit
              Left = 152
              Top = 184
              Width = 409
              Height = 21
              CharCase = ecUpperCase
              DataField = 'END_CAD'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 9
              OnDblClick = ComponentDblClick
            end
            object eCod_Loc: TDBLookupComboBox
              Left = 152
              Top = 184
              Width = 409
              Height = 21
              DataField = 'END_CAD'
              DataSource = dsMain
              KeyField = 'DSC_LOC'
              ListField = 'DSC_LOC'
              ListSource = Localidades
              PopupMenu = pmFields
              TabOrder = 10
              Visible = False
              OnCloseUp = eCod_LocCloseUp
            end
            object eCmp_End: TDBEdit
              Left = 152
              Top = 232
              Width = 409
              Height = 21
              CharCase = ecUpperCase
              DataField = 'CMP_END'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 13
              OnDblClick = ComponentDblClick
            end
            object eCod_Bai: TDBLookupComboBox
              Left = 152
              Top = 232
              Width = 409
              Height = 21
              DataField = 'CMP_END'
              DataSource = dsMain
              KeyField = 'DSC_BAI'
              ListField = 'DSC_BAI'
              ListSource = Bairros
              PopupMenu = pmFields
              TabOrder = 14
              Visible = False
              OnCloseUp = eCod_BaiCloseUp
            end
            object eCrg_Ins: TDBEdit
              Left = 152
              Top = 256
              Width = 137
              Height = 21
              CharCase = ecUpperCase
              DataField = 'CRG_INS'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 15
              OnDblClick = ComponentDblClick
            end
            object eFon_Cad: TDBEdit
              Left = 152
              Top = 280
              Width = 137
              Height = 21
              CharCase = ecUpperCase
              DataField = 'FON_CAD'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 16
              OnDblClick = ComponentDblClick
            end
            object eFax_Cad: TDBEdit
              Left = 424
              Top = 256
              Width = 161
              Height = 21
              CharCase = ecUpperCase
              DataField = 'FAX_CAD'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 17
              OnDblClick = ComponentDblClick
            end
            object eNum_End: TJvDBCalcEdit
              Left = 152
              Top = 208
              Width = 121
              Height = 21
              DataField = 'NUM_END'
              DataSource = dsMain
              ClickKey = 0
              DecimalPlaces = 0
              DisplayFormat = ',0.'
              FormatOnEditing = True
              GlyphKind = gkCustom
              Glyph.Data = {
                4E000000424D4E000000000000003E0000002800000001000000040000000100
                010000000000100000000000000000000000020000000200000000000000FFFF
                FF0080000000000000000000000080000000}
              ButtonWidth = 0
              NumGlyphs = 1
              PopupMenu = pmFields
              TabOrder = 11
            end
            object eCep_Cad: TJvDBCalcEdit
              Left = 440
              Top = 208
              Width = 121
              Height = 21
              DataField = 'CEP_CAD'
              DataSource = dsMain
              ClickKey = 0
              DecimalPlaces = 0
              DisplayFormat = ',#'
              FormatOnEditing = True
              GlyphKind = gkCustom
              Glyph.Data = {
                4E000000424D4E000000000000003E0000002800000001000000040000000100
                010000000000100000000000000000000000020000000200000000000000FFFF
                FF0080000000000000000000000080000000}
              ButtonWidth = 0
              NumGlyphs = 1
              PopupMenu = pmFields
              TabOrder = 12
              ZeroEmpty = False
            end
            object eVlr_Ins: TJvDBCalcEdit
              Left = 424
              Top = 280
              Width = 161
              Height = 21
              DataField = 'VLR_INS'
              DataSource = dsMain
              DecimalPlaces = 4
              DisplayFormat = ',0.####'
              NumGlyphs = 2
              TabOrder = 18
            end
          end
          object tsComplement: TTabSheet
            Caption = 'tsComplement'
            object lEmail_Cad: TLabel
              Left = 86
              Top = 59
              Width = 63
              Height = 13
              Alignment = taRightJustify
              Caption = 'lEmail_Cad'
              FocusControl = eEmail_Cad
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lFk_Tipo_Status: TLabel
              Left = 56
              Top = 91
              Width = 93
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFk_Tipo_Status'
              FocusControl = eFk_Tipo_Status
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object sbSendMail: TSpeedButton
              Left = 552
              Top = 56
              Width = 23
              Height = 22
              Flat = True
              OnClick = sbSendMailClick
            end
            object lDta_Uac: TLabel
              Left = 95
              Top = 123
              Width = 54
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDta_Uac'
              FocusControl = eDta_Uac
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              OnDblClick = ComponentDblClick
            end
            object lFlag_Exp: TDBCheckBox
              Left = 152
              Top = 26
              Width = 209
              Height = 17
              Caption = 'lFlag_Exp'
              DataField = 'FLAG_EXP'
              DataSource = dsMain
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object eEmail_Cad: TDBEdit
              Left = 152
              Top = 56
              Width = 401
              Height = 21
              DataField = 'EMAIL_CAD'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 1
              OnDblClick = ComponentDblClick
            end
            object lFlag_Etq: TDBCheckBox
              Left = 152
              Top = 2
              Width = 209
              Height = 17
              Caption = 'lFlag_Etq'
              DataField = 'FLAG_ETQ'
              DataSource = dsMain
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object eFk_Tipo_Status: TJvDBLookupCombo
              Left = 152
              Top = 88
              Width = 401
              Height = 21
              DropDownCount = 8
              DataField = 'FK_TIPO_STATUS'
              DataSource = dsMain
              LookupField = 'PK_TIPO_STATUS'
              LookupDisplay = 'DSC_STT'
              LookupSource = TiposStatus
              TabOrder = 3
            end
            object eDta_Uac: TJvDBDateEdit
              Left = 152
              Top = 120
              Width = 121
              Height = 21
              DataField = 'DTA_UAC'
              DataSource = dsMain
              NumGlyphs = 2
              TabOrder = 4
            end
          end
        end
        object clbCategories: TCheckListBox
          Left = 0
          Top = 0
          Width = 592
          Height = 50
          OnClickCheck = clbCategoriesClickCheck
          Align = alTop
          Columns = 4
          ItemHeight = 13
          Items.Strings = (
            'item 1'
            'item 2')
          TabOrder = 1
        end
      end
    end
    inherited tsTable: TTabSheet
      inherited dbgGrid: TDBGrid
        Width = 760
        Height = 334
      end
      inherited SearchPanel: TPanel
        Width = 760
      end
    end
  end
  inherited Panel1: TPanel
    Width = 792
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 351
    end
  end
  inherited pCompany: TPanel
    Width = 792
    inherited lNameCompany: TLabel
      Width = 770
    end
    inherited Panel2: TPanel
      Left = 772
    end
  end
  object Paises: TDataSource
    DataSet = dmSysEvt.Paises
    Left = 264
    Top = 64
  end
  object Estados: TDataSource
    DataSet = dmSysEvt.Estados
    Left = 296
    Top = 64
  end
  object Municipios: TDataSource
    DataSet = dmSysEvt.Municipios
    Left = 328
    Top = 64
  end
  object Localidades: TDataSource
    DataSet = dmSysEvt.Logradouros
    Left = 360
    Top = 64
  end
  object Bairros: TDataSource
    DataSet = dmSysEvt.Bairros
    Left = 392
    Top = 64
  end
  object Cargos: TDataSource
    Left = 424
    Top = 64
  end
  object TiposStatus: TDataSource
    DataSet = dmSysEvt.TiposStatus
    Left = 456
    Top = 64
  end
  object fsCadIns: TJvFormStorage
    IniFileName = '.\SysConfig.ini'
    IniSection = 'SysEvtCadIns'
    StoredValues = <
      item
        Name = 'SelectedNode'
        KeyString = 'SelectedNode'
      end>
    Left = 488
    Top = 64
  end
end
