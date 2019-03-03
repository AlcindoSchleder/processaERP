inherited CdEventos: TCdEventos
  Left = 300
  Top = 113
  Width = 584
  Height = 487
  Caption = 'CdEventos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 576
  end
  inherited ControlBar: TControlBar
    Width = 576
  end
  inherited Painel: TStatusBar
    Top = 414
    Width = 576
  end
  inherited Control: TPageControl
    Width = 576
    Height = 303
    inherited tsDataAware: TTabSheet
      object pcControl: TPageControl
        Left = 0
        Top = 0
        Width = 568
        Height = 271
        ActivePage = tsEvents
        Align = alClient
        Images = Dados.Image16
        TabOrder = 1
        OnChange = pcControlChange
        OnChanging = pcControlChanging
        object tsEvents: TTabSheet
          Caption = 'tsEvents'
          ImageIndex = 19
          object Bevel1: TBevel
            Left = 0
            Top = 0
            Width = 560
            Height = 65
            Align = alTop
          end
          object lFk_Tipo_Eventos: TLabel
            Left = 6
            Top = 11
            Width = 103
            Height = 13
            Alignment = taRightJustify
            Caption = 'lFk_Tipo_Eventos'
            FocusControl = eFk_Tipo_Eventos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lPk_Eventos: TLabel
            Left = 37
            Top = 35
            Width = 72
            Height = 13
            Alignment = taRightJustify
            Caption = 'lPk_Eventos'
            FocusControl = ePk_Eventos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDta_Fin: TLabel
            Left = 381
            Top = 83
            Width = 48
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Fin'
            FocusControl = eDta_Fin
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lNum_Cat: TLabel
            Left = 374
            Top = 107
            Width = 55
            Height = 13
            Alignment = taRightJustify
            Caption = 'lNum_Cat'
            FocusControl = eNum_Cat
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lNum_Exp: TLabel
            Left = 92
            Top = 107
            Width = 57
            Height = 13
            Alignment = taRightJustify
            Caption = 'lNum_Exp'
            FocusControl = eNum_Exp
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lNum_Ins: TLabel
            Left = 96
            Top = 131
            Width = 53
            Height = 13
            Alignment = taRightJustify
            Caption = 'lNum_Ins'
            FocusControl = eNum_Ins
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lVlr_Mt2: TLabel
            Left = 382
            Top = 131
            Width = 47
            Height = 13
            Alignment = taRightJustify
            Caption = 'lVlr_Mt2'
            FocusControl = eVlr_Mt2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDta_Ini: TLabel
            Left = 104
            Top = 83
            Width = 45
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Ini'
            FocusControl = eDta_Ini
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDta_Cr_Exp: TLabel
            Left = 78
            Top = 155
            Width = 71
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Cr_Exp'
            FocusControl = eDta_Cr_Exp
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDta_Cr_Mont: TLabel
            Left = 351
            Top = 155
            Width = 78
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Cr_Mont'
            FocusControl = eDta_Cr_Mont
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDta_Conv: TLabel
            Left = 89
            Top = 179
            Width = 60
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Conv'
            FocusControl = eDta_Conv
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDta_Es_Merc: TLabel
            Left = 349
            Top = 179
            Width = 80
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Es_Merc'
            FocusControl = eDta_Es_Merc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDta_Srv: TLabel
            Left = 99
            Top = 203
            Width = 50
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Srv'
            FocusControl = eDta_Srv
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lDta_Equip: TLabel
            Left = 366
            Top = 203
            Width = 63
            Height = 13
            Alignment = taRightJustify
            Caption = 'lDta_Equip'
            FocusControl = eDta_Equip
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object eFk_Tipo_Eventos: TDBLookupComboBox
            Left = 112
            Top = 8
            Width = 441
            Height = 21
            DataField = 'FK_TIPO_EVENTOS'
            DataSource = dsMain
            KeyField = 'PK_TIPO_EVENTOS'
            ListField = 'DSC_TEVT'
            ListSource = TipoEventos
            PopupMenu = pmFields
            TabOrder = 0
          end
          object ePk_Eventos: TDBEdit
            Left = 112
            Top = 32
            Width = 116
            Height = 21
            DataField = 'PK_EVENTOS'
            DataSource = dsMain
            PopupMenu = pmFields
            TabOrder = 1
            OnDblClick = ComponentDblClick
          end
          object eDta_Ini: TJvDBDateEdit
            Left = 152
            Top = 80
            Width = 121
            Height = 21
            DataField = 'DTA_INI'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 2
            OnDblClick = ComponentDblClick
          end
          object eDta_Fin: TJvDBDateEdit
            Left = 432
            Top = 80
            Width = 121
            Height = 21
            DataField = 'DTA_FIN'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 3
            OnDblClick = ComponentDblClick
          end
          object eNum_Cat: TJvDBCalcEdit
            Left = 432
            Top = 104
            Width = 121
            Height = 21
            DataField = 'NUM_CAT'
            DataSource = dsMain
            DecimalPlaces = 0
            DisplayFormat = ',0.'
            ButtonWidth = 0
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 4
            OnDblClick = ComponentDblClick
          end
          object eNum_Exp: TJvDBCalcEdit
            Left = 152
            Top = 104
            Width = 121
            Height = 21
            DataField = 'NUM_EXP'
            DataSource = dsMain
            DecimalPlaces = 0
            DisplayFormat = ',0.'
            ButtonWidth = 0
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 5
            OnDblClick = ComponentDblClick
          end
          object eNum_Ins: TJvDBCalcEdit
            Left = 152
            Top = 128
            Width = 121
            Height = 21
            DataField = 'NUM_INS'
            DataSource = dsMain
            DecimalPlaces = 0
            DisplayFormat = ',0.'
            ButtonWidth = 0
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 6
            OnDblClick = ComponentDblClick
          end
          object eVlr_Mt2: TJvDBCalcEdit
            Left = 432
            Top = 128
            Width = 121
            Height = 21
            DataField = 'VLR_MT2'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 7
            OnDblClick = ComponentDblClick
          end
          object eDta_Cr_Exp: TJvDBDateEdit
            Left = 152
            Top = 152
            Width = 121
            Height = 21
            DataField = 'DTA_CR_EXP'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 8
            OnDblClick = ComponentDblClick
          end
          object eDta_Cr_Mont: TJvDBDateEdit
            Left = 432
            Top = 152
            Width = 121
            Height = 21
            DataField = 'DTA_CR_MONT'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 9
            OnDblClick = ComponentDblClick
          end
          object eDta_Conv: TJvDBDateEdit
            Left = 152
            Top = 176
            Width = 121
            Height = 21
            DataField = 'DTA_CONV'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 10
            OnDblClick = ComponentDblClick
          end
          object eDta_Es_Merc: TJvDBDateEdit
            Left = 432
            Top = 176
            Width = 121
            Height = 21
            DataField = 'DTA_ES_MERC'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 11
            OnDblClick = ComponentDblClick
          end
          object eDta_Srv: TJvDBDateEdit
            Left = 152
            Top = 200
            Width = 121
            Height = 21
            DataField = 'DTA_CONV'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 12
            OnDblClick = ComponentDblClick
          end
          object eDta_Equip: TJvDBDateEdit
            Left = 432
            Top = 200
            Width = 121
            Height = 21
            DataField = 'DTA_CONV'
            DataSource = dsMain
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 13
            OnDblClick = ComponentDblClick
          end
        end
        object tsPrices: TTabSheet
          Caption = 'tsPrices'
          ImageIndex = 11
          object lPre_Seg: TLabel
            Left = 361
            Top = 131
            Width = 52
            Height = 13
            Alignment = taRightJustify
            Caption = 'lPre_Seg'
            FocusControl = ePre_Seg
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object lFk_Segmentos: TLabel
            Left = 230
            Top = 51
            Width = 87
            Height = 13
            Alignment = taRightJustify
            Caption = 'lFk_Segmentos'
            FocusControl = eFk_Segmentos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            PopupMenu = pmFields
            OnDblClick = ComponentDblClick
          end
          object ePre_Seg: TJvDBCalcEdit
            Tag = 1
            Left = 416
            Top = 128
            Width = 121
            Height = 21
            DataField = 'PRE_SEG'
            NumGlyphs = 2
            PopupMenu = pmFields
            TabOrder = 0
            OnDblClick = ComponentDblClick
          end
          object pNameEvent: TPanel
            Left = 0
            Top = 0
            Width = 560
            Height = 25
            Align = alTop
            BevelInner = bvLowered
            Caption = 'pNameEvent'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
          end
          object Panel4: TPanel
            Left = 0
            Top = 25
            Width = 209
            Height = 217
            Align = alLeft
            BevelInner = bvLowered
            TabOrder = 2
            object lViewSeg: TLabel
              Left = 2
              Top = 2
              Width = 205
              Height = 16
              Align = alTop
              Alignment = taCenter
              Caption = 'lViewSeg'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object clbSegments: TCheckListBox
              Left = 2
              Top = 18
              Width = 205
              Height = 197
              Align = alClient
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsNone
              Ctl3D = False
              ItemHeight = 13
              ParentCtl3D = False
              TabOrder = 0
              OnClick = clbSegmentsClick
            end
          end
          object eFk_Segmentos: TDBLookupComboBox
            Tag = 1
            Left = 320
            Top = 48
            Width = 217
            Height = 21
            DataField = 'FK_SEGMENTOS'
            KeyField = 'PK_SEGMENTOS'
            ListField = 'DSC_SEG'
            ListSource = Segmentos
            PopupMenu = pmFields
            TabOrder = 3
          end
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
    Width = 576
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 135
    end
  end
  inherited pCompany: TPanel
    Width = 576
    inherited lNameCompany: TLabel
      Width = 554
    end
    inherited Panel2: TPanel
      Left = 556
    end
  end
  object TipoEventos: TDataSource
    DataSet = dmSysEvt.TipoEventos
    Left = 264
    Top = 64
  end
  object Eventos: TDataSource
    DataSet = dmSysEvt.Eventos
    Left = 296
    Top = 64
  end
  object Segmentos: TDataSource
    DataSet = dmSysEvt.Segmentos
    Left = 328
    Top = 64
  end
end
