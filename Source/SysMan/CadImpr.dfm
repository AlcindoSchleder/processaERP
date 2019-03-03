inherited CdImpressoras: TCdImpressoras
  Width = 647
  Height = 476
  Caption = 'CdImpressoras'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 639
  end
  inherited sbStatus: TStatusBar
    Top = 402
    Width = 639
    Height = 20
  end
  inherited pgControl: TPageControl
    Width = 639
    Height = 345
    inherited tsData: TTabSheet
      object eMap_Imp: TEdit
        Left = 160
        Top = 34
        Width = 160
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 1
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object eDsc_Imp: TEdit
        Left = 160
        Top = 59
        Width = 464
        Height = 21
        Anchors = [akLeft, akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 4
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object eUnc_Name: TEdit
        Left = 160
        Top = 84
        Width = 464
        Height = 21
        Anchors = [akLeft, akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 5
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object lFlag_Cpm: TCheckBox
        Left = 399
        Top = 9
        Width = 225
        Height = 17
        Anchors = [akRight]
        Caption = 'lFlag_Cpm'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 2
        OnClick = ChangeGlobal
      end
      object ePk_Impressoras: TEdit
        Left = 160
        Top = 9
        Width = 160
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 0
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object lImp_Fsc: TRadioGroup
        Left = 0
        Top = 162
        Width = 631
        Height = 151
        Anchors = [akLeft, akRight, akBottom]
        Caption = 'lImp_Fsc'
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 6
        OnClick = ChangeGlobal
      end
      object lFlag_IFsc: TCheckBox
        Left = 399
        Top = 34
        Width = 225
        Height = 17
        Anchors = [akRight]
        Caption = 'lFlag_IFsc'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 3
        OnClick = ChangeGlobal
      end
      object eFk_Drivers: TComboBox
        Left = 160
        Top = 109
        Width = 464
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 13
        PopupMenu = pmFields
        TabOrder = 7
        OnDblClick = ComponentDblClick
      end
      object eFk_Tipo_Documentos: TComboBox
        Left = 160
        Top = 134
        Width = 464
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 13
        PopupMenu = pmFields
        TabOrder = 8
        OnDblClick = ComponentDblClick
      end
      object lPk_Impressoras: TStaticText
        Left = 0
        Top = 9
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lPk_Impressoras'
        FocusControl = ePk_Impressoras
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnDblClick = ComponentDblClick
      end
      object lMap_Imp: TStaticText
        Left = 0
        Top = 34
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lMap_Imp'
        FocusControl = eMap_Imp
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnDblClick = ComponentDblClick
      end
      object lDsc_Imp: TStaticText
        Left = 0
        Top = 59
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lDsc_Imp'
        FocusControl = eDsc_Imp
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnDblClick = ComponentDblClick
      end
      object lUnc_Name: TStaticText
        Left = 0
        Top = 84
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lUnc_Name'
        FocusControl = eUnc_Name
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        OnDblClick = ComponentDblClick
      end
      object lFk_Drivers: TStaticText
        Left = 0
        Top = 109
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lFk_Drivers'
        FocusControl = eFk_Drivers
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        OnDblClick = ComponentDblClick
      end
      object lFk_Tipo_Documentos: TStaticText
        Left = 0
        Top = 134
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lFk_Tipo_Documentos'
        FocusControl = eFk_Tipo_Documentos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnDblClick = ComponentDblClick
      end
    end
    inherited tsList: TTabSheet
      inherited SearchPanel: TPanel
        Width = 573
      end
      inherited vtGrid: TVirtualStringTree
        Width = 573
        Height = 263
        WideDefaultText = 'vtGrid'
      end
    end
  end
  inherited cbTools: TCoolBar
    Width = 639
    Bands = <
      item
        Break = False
        Control = tbNavigation
        ImageIndex = 82
        Width = 136
      end
      item
        Break = False
        Control = tbOperations
        HorizontalOnly = True
        ImageIndex = 91
        Text = 'Ferramentas'
        Width = 497
      end>
    inherited tbOperations: TToolBar
      Width = 420
    end
  end
  inherited dsMain: TDataManager
    OnSetFieldEditor = dsMainSetFieldEditor
  end
end
