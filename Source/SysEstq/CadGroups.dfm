inherited CdGroups: TCdGroups
  Left = 195
  Top = 169
  Width = 800
  Height = 550
  Caption = 'CdGroups'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object sDiv: TSplitter [0]
    Left = 374
    Top = 41
    Width = 5
    Height = 462
    Beveled = True
  end
  inherited spSplitter: TSplitter
    Left = 369
    Top = 41
    Height = 462
  end
  inherited cbTools: TCoolBar
    Width = 792
    Height = 41
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        MinHeight = 33
        Text = 'Ferramentas'
        Width = 788
      end>
    inherited tbTools: TToolBar
      Width = 711
      Height = 33
      inherited tbInsert: TToolButton
        DropdownMenu = pmGrid
        Style = tbsDropDown
      end
      inherited tbCancel: TToolButton
        Left = 67
      end
      inherited tbDelete: TToolButton
        Left = 121
      end
      inherited tbSepSave: TToolButton
        Left = 175
      end
      inherited tbSave: TToolButton
        Left = 183
      end
      inherited tbSepClose: TToolButton
        Left = 237
      end
      inherited tbClose: TToolButton
        Left = 245
      end
    end
  end
  inherited sbStatus: TStatusBar
    Top = 503
    Width = 792
  end
  inherited vtList: TVirtualStringTree
    Top = 41
    Width = 369
    Height = 462
    Header.AutoSizeIndex = 1
    PopupMenu = pmGrid
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    Columns = <
      item
        Position = 0
        Width = 150
        WideText = 'C'#243'digo'
      end
      item
        Position = 1
        Width = 215
        WideText = 'Descri'#231#227'o'
      end>
  end
  inherited pMain: TPanel
    Left = 379
    Top = 41
    Width = 413
    Height = 462
    TabOrder = 4
  end
  object pData: TPanel
    Left = 379
    Top = 41
    Width = 413
    Height = 462
    Align = alClient
    ParentColor = True
    TabOrder = 3
    DesignSize = (
      413
      462)
    object shTitle: TShape
      Left = 8
      Top = 8
      Width = 401
      Height = 33
      Anchors = [akLeft, akTop, akRight]
    end
    object lTitle: TLabel
      Left = 16
      Top = 14
      Width = 385
      Height = 21
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Cadastro de Classifica'#231#227'o de Produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lSeq_Class: TStaticText
      Left = 8
      Top = 72
      Width = 121
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Sequ'#234'ncia: '
      Enabled = False
      FocusControl = eSeq_Class
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object lMask_Class: TStaticText
      Left = 8
      Top = 117
      Width = 123
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'C'#243'd. Classif.: '
      Enabled = False
      FocusControl = eMask_Class
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object lDsc_PGru: TStaticText
      Left = 8
      Top = 162
      Width = 123
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Descri'#231#227'o: '
      FocusControl = eDsc_PGru
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object eDsc_PGru: TEdit
      Left = 136
      Top = 162
      Width = 273
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 3
      OnChange = ChangeGlobal
    end
    object eMask_Class: TEdit
      Left = 136
      Top = 117
      Width = 273
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Enabled = False
      MaxLength = 50
      TabOrder = 2
      OnChange = ChangeGlobal
    end
    object eSeq_Class: TCurrencyEdit
      Left = 136
      Top = 72
      Width = 57
      Height = 21
      AutoSize = False
      DecimalPlaces = 0
      DisplayFormat = '0;-,0'
      Enabled = False
      MaxLength = 5
      TabOrder = 0
      OnChange = ChangeGlobal
    end
    object lLev_Class: TStaticText
      Left = 224
      Top = 72
      Width = 121
      Height = 20
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'N'#237'vel: '
      Enabled = False
      FocusControl = eLev_Class
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object eLev_Class: TCurrencyEdit
      Left = 352
      Top = 72
      Width = 57
      Height = 21
      AutoSize = False
      DecimalPlaces = 0
      DisplayFormat = '0;-,0'
      Enabled = False
      Anchors = [akTop, akRight]
      MaxLength = 5
      TabOrder = 1
      OnChange = ChangeGlobal
    end
    object pgFlagLastLevel: TPageControl
      Left = 8
      Top = 200
      Width = 401
      Height = 249
      ActivePage = tsList
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 8
      OnChanging = pgFlagLastLevelChanging
      object tsDataLevel: TTabSheet
        Caption = #218'ltimo N'#237'vel'
        ImageIndex = 2
        DesignSize = (
          393
          221)
        object lDsct_Prod: TStaticText
          Left = 8
          Top = 16
          Width = 123
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Desc. do Grupo: '
          FocusControl = eDsct_Prod
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object eDsct_Prod: TCurrencyEdit
          Left = 136
          Top = 16
          Width = 97
          Height = 21
          AutoSize = False
          DisplayFormat = '0.00 %;-,0.00 %'
          MaxLength = 5
          TabOrder = 1
          OnChange = ChangeGlobal
        end
        object lMrgm_Ref: TStaticText
          Left = 8
          Top = 56
          Width = 123
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Margem de Lucro: '
          FocusControl = eMrgm_Ref
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object eMrgm_Ref: TCurrencyEdit
          Left = 136
          Top = 56
          Width = 97
          Height = 21
          AutoSize = False
          DecimalPlaces = 4
          DisplayFormat = '0.0000;-,0.0000'
          MaxLength = 5
          TabOrder = 3
          OnChange = ChangeGlobal
        end
        object eCom_SGru: TCurrencyEdit
          Left = 136
          Top = 96
          Width = 97
          Height = 21
          AutoSize = False
          DecimalPlaces = 4
          DisplayFormat = '0.0000;-,0.0000'
          MaxLength = 5
          TabOrder = 4
          OnChange = ChangeGlobal
        end
        object lCom_SGru: TStaticText
          Left = 8
          Top = 96
          Width = 123
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Comis. do Grupo: '
          FocusControl = eCom_SGru
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object eCod_GRef: TEdit
          Left = 136
          Top = 136
          Width = 97
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          MaxLength = 3
          TabOrder = 6
          OnChange = ChangeGlobal
        end
        object lCod_GRef: TStaticText
          Left = 8
          Top = 136
          Width = 123
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Padr'#227'o da Refer.: '
          FocusControl = eCod_GRef
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object eSeq_Ref: TCurrencyEdit
          Left = 136
          Top = 176
          Width = 57
          Height = 21
          AutoSize = False
          DecimalPlaces = 0
          DisplayFormat = '0;-,0'
          MaxLength = 5
          TabOrder = 8
          OnChange = ChangeGlobal
        end
        object lSeq_Ref: TStaticText
          Left = 8
          Top = 176
          Width = 123
          Height = 20
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Sequ'#234'ncia: '
          FocusControl = eSeq_Ref
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
      end
      object tsList: TTabSheet
        Caption = 'Lista das Contas Financeiras'
        TabVisible = False
        object pgAccounts: TPageControl
          Left = 0
          Top = 0
          Width = 393
          Height = 221
          ActivePage = tsData
          Align = alClient
          TabOrder = 0
          object tsGridList: TTabSheet
            Caption = 'tsGridList'
            TabVisible = False
            DesignSize = (
              385
              211)
            object vtGroupAccount: TVirtualStringTree
              Left = 0
              Top = 0
              Width = 385
              Height = 207
              Anchors = [akLeft, akTop, akRight, akBottom]
              Colors.FocusedSelectionColor = clSilver
              Header.AutoSizeIndex = -1
              Header.Font.Charset = DEFAULT_CHARSET
              Header.Font.Color = clWindowText
              Header.Font.Height = -11
              Header.Font.Name = 'MS Sans Serif'
              Header.Font.Style = []
              Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
              Header.Style = hsXPStyle
              PopupMenu = pmAccMenu
              SelectionCurveRadius = 10
              TabOrder = 0
              TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoTristateTracking, toAutoDeleteMovedNodes]
              TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
              TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
              TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toRightClickSelect]
              OnDblClick = vtGroupAccountDblClick
              OnFocusChanged = vtGroupAccountFocusChanged
              OnGetText = vtGroupAccountGetText
              OnPaintText = vtGroupAccountPaintText
              Columns = <
                item
                  Position = 0
                  Width = 385
                  WideText = 'Descri'#231#227'o das Contas'
                end>
            end
          end
          object tsData: TTabSheet
            Caption = 'tsData'
            ImageIndex = 1
            TabVisible = False
            object stOk: TSpeedButton
              Left = 136
              Top = 144
              Width = 105
              Height = 22
              Caption = 'Ok'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FF033B8A033D90013D95023B91033A89033A89FF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0357D30147B20051D0035CE007
                63E3035CE0004ED30042B7023A8F023A8FFF00FFFF00FFFF00FFFF00FFFF00FF
                0650BA0357D32781F278B4F7CAE2FCE9F4FFDCEDFF9CC7FA3F8FF20155DD0140
                A404367DFF00FFFF00FFFF00FF075DD70762E155A0F7F3F8FEFFFFFFE9F3FCC6
                DEFAD9E9FCFFFFFFFFFFFF99C5F8055DE70040A302398BFF00FFFF00FF075DD7
                529EF7FEFEFFF0F7FE5CA3F31E78EBA1C9F70D65E32D7AE9BAD7F8FFFFFF9CC9
                F80355DE02398BFF00FF0455C9207DF0E1EFFEFFFFFF358CF30F6EEEC7E0FBFF
                FFFF2F83EA004ADE0559E1BAD8F8FFFFFF3E8FF20043B7033E96085FDA56A1FA
                FFFFFF9ECBFB2D88F4D4E9FCFCFEFED7E9FC8ABDF60058E2004FE02A7BE7FFFF
                FF9FCBFA0050D4033E960F6BE68BC1FCFFFFFF56A4FC97C7FCF8FBFF4B9AF628
                82F2D9EAFC1975EB005AE5015AE2D9E9FBDEEFFF0560E202409C1B76EDA4CFFC
                FFFFFF50A0FF2586FE358FFA0E70F6096AF289BFFA6AABF6025FEA0159E5C7E1
                FAEBF6FF0C68E60141A1207AEBA5CFFEFFFFFF75B6FF1278FF1A7DFE187AFB11
                73F71979F482BBFA0E6CEE0E6CEBEFF6FECEE5FE0763E203419E146FE79ACAFC
                FFFFFFD8EBFF1F81FF1B7EFF1E81FF1A7BFC1173F7368EF72983F463A9F6FFFF
                FF81BAF80258D8033E96FF00FF237BEBEDF6FFFFFFFF98CAFF1F81FF1379FF16
                7AFF1276FB0A6EF854A0F8F0F8FFF2F8FE3089F4024FC0FF00FFFF00FF237BEB
                BFDEFFF3F8FFFFFFFFD7EAFF74B6FF53A3FE5EA9FFA3CFFEFFFFFFFFFFFF5DA6
                F70860DE024FC0FF00FFFF00FFFF00FF4997F3C7E3FFF7FBFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFE0EFFE5CA5F80E6BE70552C2FF00FFFF00FFFF00FFFF00FF
                FF00FF2D82EB91C5FBCCE6FFD9EDFFDCEDFEC4E0FE86BFFC348BF40A65E10A65
                E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF247BEB4696F34A
                98F42F87F0116CE6075FDCFF00FFFF00FFFF00FFFF00FFFF00FF}
              OnClick = stOkClick
            end
            object stCancel: TSpeedButton
              Left = 272
              Top = 144
              Width = 105
              Height = 22
              Caption = 'Cancelar'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FF033B8A033D90013D95023B91033A89033A89FF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0357D30147B20051D0035CE007
                63E3035CE0004ED30042B7023A8F023A8FFF00FFFF00FFFF00FFFF00FFFF00FF
                0650BA0357D32781F278B4F7CAE2FCE9F4FFDCEDFF9CC7FA3F8FF20155DD0140
                A404367DFF00FFFF00FFFF00FF075DD70762E155A0F7F3F8FEFFFFFFE9F3FCC6
                DEFAD9E9FCFFFFFFFFFFFF99C5F8055DE70040A302398BFF00FFFF00FF075DD7
                529EF7FEFEFFE2EFFC0F65EB0558E70959E50250E20454E16FA6F0DEEBFC9CC9
                F80355DE02398BFF00FF0455C9207DF0E1EFFEFFFFFF6FA7F076AFF7176CED06
                5AE9075AE60F5EE66AA1F06FA7F0FFFFFF3E8FF20043B7033E96085FDA56A1FA
                FFFFFF9ECBFB1573F779B4FACFE3FC1C72EF2274EECBE1FB6DA5F20556E3DEEB
                FC9FCBFA0050D4033E960F6BE68BC1FCFFFFFF2987FC1F7DFA1674F779B5FADE
                EDFEDDEDFC6EAAF4065AE90455E5A0C5F6DEEFFF0560E202409C1B76EDA4CFFC
                FFFFFF2988FF1C7EFE1C7BFB2D87FBEDF6FEEDF6FE2279F20B63ED085DEA88BA
                F4EBF6FF0C68E60141A1207AEBA5CFFEFFFFFF3F97FF1F81FF3B93FEE1EFFF6B
                ADFC69ABFBE0EEFE2C80F30C65EEC6DEFBCEE5FE0763E203419E146FE79ACAFC
                FFFFFFB2D8FF318EFFE7F3FF67AFFF1D7EFE1A7AFB60A7FCE5F2FE3F8FF6E2EF
                FE81BAF80258D8033E96FF00FF237BEBEDF6FFFAFCFF5DA9FF469AFF1F81FF1F
                81FF1E80FF1C7DFC4D9CFBF0F8FFF2F8FE3089F4024FC0FF00FFFF00FF237BEB
                BFDEFFF3F8FFFAFCFFB0D5FF3E96FF2B89FF308CFF6AB0FEFAFCFFFFFFFF5DA6
                F70860DE024FC0FF00FFFF00FFFF00FF4997F3C7E3FFF7FBFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFE0EFFE5CA5F80E6BE70552C2FF00FFFF00FFFF00FFFF00FF
                FF00FF2D82EB91C5FBCCE6FFD9EDFFDCEDFEC4E0FE86BFFC348BF40A65E10A65
                E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF247BEB4696F34A
                98F42F87F0116CE6075FDCFF00FFFF00FFFF00FFFF00FFFF00FF}
              OnClick = stCancelClick
            end
            object lFk_Natureza_Operacoes: TStaticText
              Left = 8
              Top = 32
              Width = 123
              Height = 20
              Alignment = taRightJustify
              AutoSize = False
              BorderStyle = sbsSingle
              Caption = 'Cfop: '
              FocusControl = eFk_Natureza_Operacoes
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object eFk_Natureza_Operacoes: TComboBox
              Left = 136
              Top = 32
              Width = 241
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 1
              OnSelect = ChangeGlobal
            end
            object lFk_Financeiro_Contas: TStaticText
              Left = 8
              Top = 88
              Width = 123
              Height = 20
              Alignment = taRightJustify
              AutoSize = False
              BorderStyle = sbsSingle
              Caption = 'Conta Financeira: '
              FocusControl = eFk_Financeiro_Contas
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object eFk_Financeiro_Contas: TComboBox
              Left = 136
              Top = 88
              Width = 241
              Height = 22
              Style = csOwnerDrawFixed
              ItemHeight = 16
              TabOrder = 3
              OnDrawItem = eFk_Financeiro_ContasDrawItem
              OnSelect = eFk_Financeiro_ContasSelect
            end
          end
        end
      end
    end
  end
  object pmGrid: TPopupMenu
    Left = 128
    Top = 112
    object pmNewLevel: TMenuItem
      Caption = 'Inserir N'#237'vel - [Ctrl+Ins]'
      OnClick = pmNewLevelClick
    end
  end
  object pmAccMenu: TPopupMenu
    Left = 526
    Top = 335
    object pmNewAcc: TMenuItem
      Caption = 'Inserir &Conta'
      OnClick = pmNewAccClick
    end
  end
end
