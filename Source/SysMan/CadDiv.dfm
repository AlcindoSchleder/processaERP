inherited CdDivisoes: TCdDivisoes
  Left = 193
  Top = 110
  Width = 570
  Height = 526
  Caption = 'CdDivisoes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 562
  end
  inherited sbStatus: TStatusBar
    Top = 453
    Width = 562
  end
  inherited pgControl: TPageControl
    Width = 562
    Height = 396
    inherited tsData: TTabSheet
      object lSql_Div: TLabel
        Tag = 99
        Left = 0
        Top = 133
        Width = 554
        Height = 20
        Align = alBottom
        Alignment = taCenter
        Caption = 'lSql_Div'
        Color = clBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object pgDiv: TPageControl
        Left = 0
        Top = 0
        Width = 554
        Height = 133
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
      end
      object lFk_Tipo_Documentos: TStaticText
        Left = 0
        Top = 8
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
        PopupMenu = pmFields
        TabOrder = 1
        OnDblClick = ComponentDblClick
      end
      object eFk_Tipo_Documentos: TComboBox
        Left = 160
        Top = 8
        Width = 386
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 13
        PopupMenu = pmFields
        TabOrder = 2
        OnDblClick = ComponentDblClick
      end
      object lPk_Divisoes: TStaticText
        Left = 0
        Top = 32
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lPk_Divisoes'
        FocusControl = ePk_Divisoes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 3
        OnDblClick = ComponentDblClick
      end
      object ePk_Divisoes: TEdit
        Left = 160
        Top = 32
        Width = 73
        Height = 21
        TabStop = False
        Anchors = [akLeft]
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        PopupMenu = pmFields
        ReadOnly = True
        TabOrder = 4
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object eDsc_Div: TEdit
        Left = 160
        Top = 56
        Width = 386
        Height = 21
        Anchors = [akLeft, akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 5
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object lDsc_Div: TStaticText
        Left = 0
        Top = 56
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lDsc_Div'
        FocusControl = eDsc_Div
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 6
        OnDblClick = ComponentDblClick
      end
      object lMin_Line: TStaticText
        Left = 0
        Top = 80
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lMin_Line'
        FocusControl = eMin_Line
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 7
        OnDblClick = ComponentDblClick
      end
      object eMin_Line: TEdit
        Left = 160
        Top = 80
        Width = 73
        Height = 21
        Anchors = [akLeft]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 8
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object lMax_Line: TStaticText
        Left = 329
        Top = 80
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lMax_Line'
        FocusControl = eMax_Line
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 9
        OnDblClick = ComponentDblClick
      end
      object eMax_Line: TEdit
        Left = 489
        Top = 80
        Width = 57
        Height = 21
        Anchors = [akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 10
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object eNiv_Div: TEdit
        Left = 489
        Top = 32
        Width = 57
        Height = 21
        Anchors = [akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 11
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object lNiv_Div: TStaticText
        Left = 329
        Top = 32
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lNiv_Div'
        FocusControl = eNiv_Div
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 13
        OnDblClick = ComponentDblClick
      end
      object eSql_Div: TMemo
        Left = 0
        Top = 153
        Width = 554
        Height = 215
        Align = alBottom
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 12
        OnChange = ChangeGlobal
      end
    end
    inherited tsList: TTabSheet
      inherited SearchPanel: TPanel
        Width = 554
      end
      inherited vtGrid: TVirtualStringTree
        Width = 554
        Height = 339
        WideDefaultText = 'vtGrid'
      end
    end
  end
  inherited cbTools: TCoolBar
    Width = 562
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
        Width = 420
      end>
    inherited tbOperations: TToolBar
      Width = 343
    end
  end
  inherited dsMain: TDataManager
    AfterPost = dsMainAfterPost
  end
end
