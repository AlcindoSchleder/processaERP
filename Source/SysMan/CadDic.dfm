inherited CdDictionary: TCdDictionary
  Left = 265
  Top = 100
  Width = 677
  Height = 571
  Caption = 'CdDictionary'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 669
  end
  inherited sbStatus: TStatusBar
    Top = 498
    Width = 669
  end
  inherited pgControl: TPageControl
    Width = 669
    Height = 441
    inherited tsData: TTabSheet
      object sbGetMask: TSpeedButton
        Left = 629
        Top = 176
        Width = 21
        Height = 21
        Anchors = [akRight]
        Flat = True
        OnClick = sbGetMaskClick
      end
      object eMsk_Fld: TEdit
        Left = 168
        Top = 176
        Width = 460
        Height = 21
        Anchors = [akLeft, akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 6
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object eMaskFld: TComboBox
        Left = 168
        Top = 176
        Width = 460
        Height = 21
        Anchors = [akLeft, akRight]
        ItemHeight = 13
        PopupMenu = pmFields
        TabOrder = 17
        Visible = False
        OnChange = eMaskFldChange
        OnDblClick = ComponentDblClick
      end
      object eDsc_Fld: TEdit
        Left = 168
        Top = 104
        Width = 484
        Height = 21
        Anchors = [akLeft, akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 3
        OnChange = eDsc_FldChange
        OnDblClick = ComponentDblClick
      end
      object ePk_Dicionarios__Na: TComboBox
        Left = 168
        Top = 32
        Width = 484
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        ItemHeight = 13
        PopupMenu = pmFields
        TabOrder = 0
        OnDblClick = ComponentDblClick
        OnSelect = ePk_Dicionarios__NaSelect
      end
      object ePk_Dicionarios__Nc: TComboBox
        Left = 168
        Top = 56
        Width = 484
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        ItemHeight = 13
        PopupMenu = pmFields
        TabOrder = 1
        OnDblClick = ComponentDblClick
        OnSelect = ePk_Dicionarios__NcSelect
      end
      object eDsc_Lbl: TEdit
        Left = 168
        Top = 128
        Width = 484
        Height = 21
        Anchors = [akLeft, akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 4
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object eNom_Obj: TEdit
        Left = 168
        Top = 80
        Width = 484
        Height = 21
        Anchors = [akLeft, akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 2
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object eDsc_Frgn: TEdit
        Left = 168
        Top = 152
        Width = 484
        Height = 21
        Anchors = [akLeft, akRight]
        Ctl3D = True
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 5
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object lFk_Linguagens: TStaticText
        Left = 8
        Top = 8
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lFk_Linguagens'
        FocusControl = eFk_Linguagens
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
      object eFk_Linguagens: TComboBox
        Left = 168
        Top = 8
        Width = 284
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 13
        PopupMenu = pmFields
        TabOrder = 8
        OnDblClick = ComponentDblClick
        OnSelect = ChangeGlobal
      end
      object lPk_Dicionarios__Na: TStaticText
        Left = 8
        Top = 32
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lPk_Dicionarios__Na'
        FocusControl = ePk_Dicionarios__Na
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
      object lPk_Dicionarios__Nc: TStaticText
        Left = 8
        Top = 56
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lPk_Dicionarios__Nc'
        FocusControl = ePk_Dicionarios__Nc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 10
        OnDblClick = ComponentDblClick
      end
      object lNom_Obj: TStaticText
        Left = 8
        Top = 80
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lNom_Obj'
        FocusControl = eNom_Obj
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 11
        OnDblClick = ComponentDblClick
      end
      object lDsc_Fld: TStaticText
        Left = 8
        Top = 104
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lDsc_Fld'
        FocusControl = eDsc_Fld
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 12
        OnDblClick = ComponentDblClick
      end
      object lDsc_Lbl: TStaticText
        Left = 8
        Top = 128
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lDsc_Lbl'
        FocusControl = eDsc_Lbl
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
      object lDsc_Frgn: TStaticText
        Left = 8
        Top = 152
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lDsc_Frgn'
        FocusControl = eDsc_Frgn
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 14
        OnDblClick = ComponentDblClick
      end
      object lMsk_Fld: TStaticText
        Left = 8
        Top = 176
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lMsk_Fld'
        FocusControl = eMsk_Fld
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 15
        OnDblClick = ComponentDblClick
      end
      object lPos_Fld: TStaticText
        Left = 461
        Top = 8
        Width = 121
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lPos_Fld'
        FocusControl = ePos_Fld
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmFields
        TabOrder = 16
        OnDblClick = ComponentDblClick
      end
      object ePos_Fld: TCurrencyEdit
        Left = 589
        Top = 8
        Width = 65
        Height = 21
        AutoSize = False
        CheckOnExit = True
        Ctl3D = True
        DecimalPlaces = 0
        DisplayFormat = ',0;-,0'
        Anchors = [akRight]
        ParentCtl3D = False
        PopupMenu = pmFields
        TabOrder = 19
        ZeroEmpty = False
        OnChange = ChangeGlobal
        OnDblClick = ComponentDblClick
      end
      object pgDicData: TPageControl
        Left = 0
        Top = 222
        Width = 661
        Height = 191
        ActivePage = tsBasicData
        Align = alBottom
        TabOrder = 18
        OnChange = pgDicDataChange
        object tsBasicData: TTabSheet
          Caption = 'Dados B'#225'sicos'
          DesignSize = (
            653
            163)
          object lMaskTest: TStaticText
            Left = 0
            Top = 11
            Width = 121
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'lMaskTest'
            FocusControl = eMaskTest
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnDblClick = ComponentDblClick
          end
          object eMaskTest: TMaskEdit
            Left = 128
            Top = 11
            Width = 516
            Height = 21
            Anchors = [akLeft, akRight]
            Ctl3D = True
            Enabled = False
            ParentCtl3D = False
            TabOrder = 1
          end
          object lFlag_Frgn: TCheckBox
            Left = 20
            Top = 65
            Width = 241
            Height = 17
            Anchors = []
            Caption = 'lFlag_Frgn'
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
          object lFlag_Key: TCheckBox
            Left = 20
            Top = 41
            Width = 241
            Height = 17
            Anchors = []
            Caption = 'lFlag_Key'
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 3
            OnClick = ChangeGlobal
          end
          object lFlag_Qry: TCheckBox
            Left = 20
            Top = 88
            Width = 241
            Height = 17
            Anchors = []
            Caption = 'lFlag_Qry'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 4
            OnClick = ChangeGlobal
          end
          object lFlag_Find: TCheckBox
            Left = 20
            Top = 112
            Width = 241
            Height = 17
            Anchors = []
            Caption = 'lFlag_Find'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 5
            OnClick = ChangeGlobal
          end
          object lFlag_Edit: TCheckBox
            Left = 397
            Top = 41
            Width = 241
            Height = 17
            Anchors = [akRight]
            Caption = 'lFlag_Edit'
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
          object lFlag_Vis: TCheckBox
            Left = 397
            Top = 65
            Width = 241
            Height = 17
            Anchors = [akRight]
            Caption = 'lFlag_Vis'
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 7
            OnClick = ChangeGlobal
          end
          object lFlag_ObjV: TCheckBox
            Left = 397
            Top = 88
            Width = 241
            Height = 17
            Anchors = [akRight]
            Caption = 'lFlag_ObjV'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 8
            OnClick = ChangeGlobal
          end
          object lFlag_Val: TCheckBox
            Left = 397
            Top = 112
            Width = 241
            Height = 17
            Anchors = [akRight]
            Caption = 'lFlag_Val'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 9
            OnClick = lFlag_ValClick
          end
          object lFlag_Flag: TCheckBox
            Left = 397
            Top = 137
            Width = 241
            Height = 17
            Anchors = [akRight]
            Caption = 'lFlag_Flag'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            PopupMenu = pmFields
            TabOrder = 10
            OnClick = ChangeGlobal
          end
        end
        object tsDicValues: TTabSheet
          Caption = 'Valores do Campo'
          ImageIndex = 19
          object pgFields: TPageControl
            Left = 0
            Top = 0
            Width = 653
            Height = 163
            ActivePage = tsListFiels
            Align = alClient
            Style = tsFlatButtons
            TabOrder = 0
            object tsListFiels: TTabSheet
              Caption = 'tsListFiels'
              TabVisible = False
              object cbToolsVal: TCoolBar
                Left = 0
                Top = 0
                Width = 645
                Height = 25
                Bands = <
                  item
                    Control = tbValueTools
                    ImageIndex = 0
                    Text = 'Manuten'#231#227'o dos Valores'
                    Width = 645
                  end>
                EdgeBorders = []
                object tbValueTools: TToolBar
                  Left = 133
                  Top = 0
                  Width = 508
                  Height = 25
                  Caption = 'tbValueTools'
                  EdgeBorders = []
                  Flat = True
                  TabOrder = 0
                  object tbInsVal: TToolButton
                    Left = 0
                    Top = 0
                    Caption = 'tbInsVal'
                    ImageIndex = 34
                    OnClick = tbInsValClick
                  end
                  object tbDelVal: TToolButton
                    Left = 23
                    Top = 0
                    Caption = 'tbDelVal'
                    ImageIndex = 33
                    OnClick = tbDelValClick
                  end
                  object tbSepVal: TToolButton
                    Left = 46
                    Top = 0
                    Width = 8
                    Caption = 'tbSepVal'
                    ImageIndex = 3
                    Style = tbsSeparator
                  end
                  object tbCancelVal: TToolButton
                    Left = 54
                    Top = 0
                    Caption = 'tbCancelVal'
                    ImageIndex = 28
                    OnClick = tbCancelValClick
                  end
                  object tbSaveVal: TToolButton
                    Left = 77
                    Top = 0
                    Caption = 'tbSaveVal'
                    ImageIndex = 36
                    OnClick = tbSaveValClick
                  end
                end
              end
              object pgValues: TPageControl
                Left = 0
                Top = 25
                Width = 645
                Height = 128
                ActivePage = tsListValue
                Align = alClient
                Style = tsFlatButtons
                TabOrder = 1
                object tsListValue: TTabSheet
                  Caption = 'tsListValue'
                  TabVisible = False
                  object vtDicValues: TVirtualStringTree
                    Left = 0
                    Top = 0
                    Width = 637
                    Height = 118
                    Align = alClient
                    BorderStyle = bsSingle
                    CheckImageKind = ckXP
                    Colors.FocusedSelectionColor = 6730751
                    Colors.FocusedSelectionBorderColor = clBtnShadow
                    Colors.GridLineColor = clSilver
                    Colors.SelectionRectangleBlendColor = 6730751
                    Colors.UnfocusedSelectionColor = 6730751
                    EditDelay = 0
                    Header.AutoSizeIndex = -1
                    Header.Font.Charset = DEFAULT_CHARSET
                    Header.Font.Color = clBlue
                    Header.Font.Height = -11
                    Header.Font.Name = 'MS Sans Serif'
                    Header.Font.Style = []
                    Header.Options = [hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
                    Header.Style = hsXPStyle
                    HintAnimation = hatNone
                    HintMode = hmDefault
                    HotCursor = crHandPoint
                    IncrementalSearchDirection = sdForward
                    SelectionCurveRadius = 20
                    TabOrder = 0
                    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
                    TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
                    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
                    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
                    OnDblClick = vtDicValuesDblClick
                    OnFocusChanged = vtDicValuesFocusChanged
                    Columns = <
                      item
                        ImageIndex = 0
                        Position = 0
                        Width = 200
                        WideText = 'Valor do Campo'
                      end
                      item
                        ImageIndex = 45
                        Position = 1
                        Width = 300
                        WideText = 'Descri'#231#227'o do Valor'
                      end>
                    WideDefaultText = 'vtGrid'
                  end
                end
                object tsDataValue: TTabSheet
                  Caption = 'tsDataValue'
                  ImageIndex = 1
                  TabVisible = False
                  DesignSize = (
                    637
                    118)
                  object eCmp_Val: TEdit
                    Left = 160
                    Top = 19
                    Width = 166
                    Height = 21
                    Anchors = [akLeft, akRight]
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Ctl3D = True
                    MaxLength = 10
                    ParentCtl3D = False
                    TabOrder = 0
                  end
                  object lCmp_Val: TStaticText
                    Left = 0
                    Top = 19
                    Width = 153
                    Height = 21
                    Alignment = taRightJustify
                    Anchors = [akLeft]
                    AutoSize = False
                    BorderStyle = sbsSingle
                    Caption = 'Valor do Campo:'
                    FocusControl = lCmp_Val
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                  end
                  object lDsc_Val: TStaticText
                    Left = 0
                    Top = 72
                    Width = 153
                    Height = 21
                    Alignment = taRightJustify
                    Anchors = [akLeft]
                    AutoSize = False
                    BorderStyle = sbsSingle
                    Caption = 'Descri'#231#227'o do Campo:'
                    FocusControl = eDsc_Val
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'MS Sans Serif'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 2
                  end
                  object eDsc_Val: TEdit
                    Left = 160
                    Top = 72
                    Width = 358
                    Height = 21
                    Anchors = [akLeft, akRight]
                    BevelKind = bkFlat
                    BorderStyle = bsNone
                    Ctl3D = True
                    MaxLength = 30
                    ParentCtl3D = False
                    TabOrder = 3
                  end
                end
              end
            end
            object tsDataFields: TTabSheet
              Caption = 'tsDataFields'
              ImageIndex = 1
              TabVisible = False
            end
          end
        end
      end
    end
    inherited tsList: TTabSheet
      inherited SearchPanel: TPanel
        Width = 661
        inherited eSearch: TEdit
          Width = 413
        end
      end
      inherited vtGrid: TVirtualStringTree
        Width = 661
        Height = 384
        WideDefaultText = 'vtGrid'
      end
    end
  end
  inherited cbTools: TCoolBar
    Width = 669
    Bands = <
      item
        Break = False
        Control = tbNavigation
        ImageIndex = 82
        Width = 149
      end
      item
        Break = False
        Control = tbOperations
        HorizontalOnly = True
        ImageIndex = 91
        Text = 'Ferramentas'
        Width = 514
      end>
    inherited tbOperations: TToolBar
      Left = 224
      Width = 437
    end
    inherited tbNavigation: TToolBar
      Width = 132
    end
  end
  inherited dsMain: TDataManager
    OnSetFieldEditor = dsMainSetFieldEditor
  end
end
