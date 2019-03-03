inherited CdLinguagem: TCdLinguagem
  Width = 670
  Height = 301
  Caption = 'CdLinguagem'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 662
  end
  inherited sbStatus: TStatusBar
    Top = 228
    Width = 662
  end
  inherited pgControl: TPageControl
    Width = 662
    Height = 171
    inherited tsData: TTabSheet
      object ePk_Linguagens: TEdit
        Left = 160
        Top = 17
        Width = 154
        Height = 21
        Anchors = [akLeft, akRight]
        PopupMenu = pmFields
        TabOrder = 0
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object eDsc_Lang: TEdit
        Left = 160
        Top = 70
        Width = 482
        Height = 21
        Anchors = [akLeft, akRight, akBottom]
        PopupMenu = pmFields
        TabOrder = 1
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object lPk_Linguagens: TStaticText
        Left = 0
        Top = 17
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lPk_Linguagens'
        FocusControl = ePk_Linguagens
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnDblClick = ComponentDblClick
      end
      object lDsc_Lang: TStaticText
        Left = 0
        Top = 70
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lDsc_Lang'
        FocusControl = eDsc_Lang
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnDblClick = ComponentDblClick
      end
    end
    inherited tsList: TTabSheet
      inherited vtGrid: TVirtualStringTree
        WideDefaultText = 'vtGrid'
      end
    end
  end
  inherited cbTools: TCoolBar
    Width = 662
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
        Width = 520
      end>
    inherited tbOperations: TToolBar
      Width = 443
    end
  end
end
