inherited CdResources: TCdResources
  Caption = 'CdResources'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Control: TPageControl
    inherited tsDataAware: TTabSheet
      object lPk_Resources: TLabel [0]
        Left = 47
        Top = 11
        Width = 86
        Height = 13
        Alignment = taRightJustify
        Caption = 'lPk_Resources'
        FocusControl = ePk_Resources
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lFk_Operadores: TLabel [1]
        Left = 43
        Top = 35
        Width = 90
        Height = 13
        Alignment = taRightJustify
        Caption = 'lFk_Operadores'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object lDsc_Res: TLabel [2]
        Left = 77
        Top = 60
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'lDsc_Res'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnDblClick = ComponentDblClick
      end
      object ePk_Resources: TDBEdit
        Left = 136
        Top = 8
        Width = 113
        Height = 21
        DataField = 'PK_RESOURCES'
        DataSource = dsMain
        PopupMenu = pmFields
        TabOrder = 1
        OnDblClick = ComponentDblClick
      end
      object eFk_Operadores: TDBLookupComboBox
        Left = 136
        Top = 32
        Width = 393
        Height = 21
        DataField = 'FK_OPERADORES'
        DataSource = dsMain
        KeyField = 'PK_OPERADORES'
        ListField = 'PK_OPERADORES'
        ListSource = Operadores
        PopupMenu = pmFields
        TabOrder = 2
      end
      object pNotes: TPanel
        Left = 0
        Top = 128
        Width = 544
        Height = 126
        Align = alBottom
        TabOrder = 3
        object pCaptions: TPanel
          Left = 1
          Top = 1
          Width = 542
          Height = 15
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lObs_User: TStaticText
            Left = 271
            Top = 0
            Width = 271
            Height = 15
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            BorderStyle = sbsSunken
            Caption = 'lObs_User'
            TabOrder = 0
          end
          object lObs_Res: TStaticText
            Left = 0
            Top = 0
            Width = 271
            Height = 15
            Align = alLeft
            Alignment = taCenter
            AutoSize = False
            BorderStyle = sbsSunken
            Caption = 'lObs_Res'
            TabOrder = 1
          end
        end
        object eObs_Res: TDBMemo
          Left = 1
          Top = 16
          Width = 271
          Height = 109
          Align = alLeft
          DataField = 'OBS_RES'
          DataSource = dsMain
          TabOrder = 1
        end
        object eObs_User: TDBMemo
          Left = 272
          Top = 16
          Width = 271
          Height = 109
          Align = alClient
          DataField = 'OBS_USER'
          DataSource = dsMain
          TabOrder = 2
        end
      end
      object lFlag_Atv: TDBCheckBox
        Left = 136
        Top = 104
        Width = 393
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
        TabOrder = 4
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object eDsc_Res: TDBMemo
        Left = 136
        Top = 56
        Width = 393
        Height = 46
        DataField = 'DSC_RES'
        DataSource = dsMain
        TabOrder = 5
      end
    end
  end
  inherited Panel1: TPanel
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  object Operadores: TDataSource
    DataSet = dmSysCrm.Operadores
    Left = 264
    Top = 64
  end
end
