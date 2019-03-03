object fmFichaTecnica: TfmFichaTecnica
  Left = 199
  Top = 106
  BorderStyle = bsToolWindow
  Caption = 'Ficha T'#233'cnica'
  ClientHeight = 546
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 527
    Width = 790
    Height = 19
    Panels = <>
  end
  object paConfiguracaoTitle: TPanel
    Left = 0
    Top = 37
    Width = 790
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object pCompany: TPanel
      Left = 0
      Top = 0
      Width = 790
      Height = 20
      Align = alClient
      Alignment = taLeftJustify
      BevelInner = bvLowered
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object lNameCompany: TLabel
        Left = 2
        Top = 2
        Width = 768
        Height = 16
        Align = alClient
        Alignment = taCenter
        Caption = 'lNameCompany'
      end
      object Panel2: TPanel
        Left = 770
        Top = 2
        Width = 18
        Height = 16
        Align = alRight
        BevelOuter = bvNone
        Color = 10930928
        TabOrder = 0
        object sbCompany: TSpeedButton
          Left = 1
          Top = 0
          Width = 16
          Height = 16
          Flat = True
          OnClick = sbCompanyClick
        end
      end
    end
  end
  object pgFicha: TPageControl
    Left = 0
    Top = 57
    Width = 790
    Height = 470
    ActivePage = tbFicha
    Align = alClient
    TabOrder = 2
    OnChange = pgFichaChange
    OnChanging = pgFichaChanging
    object tbPesquisa: TTabSheet
      Caption = 'Pesquisa'
      DesignSize = (
        782
        442)
      object Shape1: TShape
        Left = 6
        Top = 460
        Width = 10
        Height = 10
        Brush.Color = clBlue
      end
      object Label1: TLabel
        Left = 20
        Top = 458
        Width = 156
        Height = 13
        Caption = 'com sub-componentes cadastros'
      end
      object Shape2: TShape
        Left = 192
        Top = 460
        Width = 10
        Height = 10
        Brush.Color = clBlack
      end
      object Label2: TLabel
        Left = 206
        Top = 458
        Width = 155
        Height = 13
        Caption = 'sem sub-componentes cadastros'
      end
      object gbSubGrupo: TGroupBox
        Left = 4
        Top = 12
        Width = 384
        Height = 146
        TabOrder = 0
        object lFk_Secoes: TLabel
          Left = 41
          Top = 19
          Width = 56
          Height = 13
          Caption = 'lFk_Secoes'
          FocusControl = cbSecoes
        end
        object lFk_SubGrupos: TLabel
          Left = 41
          Top = 99
          Width = 73
          Height = 13
          Caption = 'lFk_SubGrupos'
          FocusControl = cbSubGrupos
        end
        object lFk_Grupos: TLabel
          Left = 41
          Top = 59
          Width = 54
          Height = 13
          Caption = 'lFk_Grupos'
          FocusControl = cbGrupos
        end
        object cmdSearchSubGrupo: TSpeedButton
          Left = 352
          Top = 114
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FF4A667C
            BE9596FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF6B9CC31E89E84B7AA3C89693FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4BB4FE51B5FF
            2089E94B7AA2C69592FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF51B7FE51B3FF1D87E64E7AA0CA9792FF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            51B7FE4EB2FF1F89E64E7BA2B99497FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF52B8FE4BB1FF2787D95F6A76FF
            00FFB0857FC09F94C09F96BC988EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF55BDFFB5D6EDBF9D92BB9B8CE7DAC2FFFFE3FFFFE5FDFADAD8C3
            B3B58D85FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA795FD
            EEBEFFFFD8FFFFDAFFFFDBFFFFE6FFFFFBEADDDCAE837FFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFC1A091FBDCA8FEF7D0FFFFDBFFFFE3FFFFF8FFFF
            FDFFFFFDC6A99CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1A091FEE3ACF1
            C491FCF2CAFFFFDDFFFFE4FFFFF7FFFFF7FFFFE9EEE5CBB9948CFF00FFFF00FF
            FF00FFFF00FFFF00FFC2A191FFE6AEEEB581F7DCAEFEFDD8FFFFDFFFFFE3FFFF
            E4FFFFE0F3ECD2BB968EFF00FFFF00FFFF00FFFF00FFFF00FFBC978CFBE7B7F4
            C791F2C994F8E5B9FEFCD8FFFFDDFFFFDCFFFFE0E2D2BAB68E86FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFD9C3A9FFFEE5F7DCB8F2C994F5D4A5FAE8BDFDF4
            C9FDFBD6B69089FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB58D85E8
            DEDDFFFEF2F9D8A3F4C48CF9D49FFDEAB8D0B49FB89086FF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFAD827FC9AA9EEFE0B7EFDFB2E7CEACB890
            86B89086FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFBA968ABB988CB79188FF00FFFF00FFFF00FFFF00FF}
          OnClick = cmdSearchSubGrupoClick
        end
        object cbSecoes: TComboBox
          Left = 41
          Top = 34
          Width = 334
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
          OnClick = cbSecoesClick
          OnKeyDown = cbSecoesKeyDown
        end
        object cbSubGrupos: TComboBox
          Left = 41
          Top = 114
          Width = 307
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnClick = cbSubGruposClick
          OnKeyDown = cbSecoesKeyDown
        end
        object cbGrupos: TComboBox
          Left = 41
          Top = 74
          Width = 334
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
          OnClick = cbGruposClick
          OnKeyDown = cbSecoesKeyDown
        end
      end
      object optSubGrupo: TRadioButton
        Left = 16
        Top = 10
        Width = 115
        Height = 17
        Caption = 'por SubGrupo'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = True
        OnClick = optSubGrupoClick
      end
      object gbReferencia: TGroupBox
        Left = 393
        Top = 12
        Width = 384
        Height = 68
        Anchors = [akLeft, akTop, akRight]
        Enabled = False
        TabOrder = 2
        object cmdSearchReferencia: TSpeedButton
          Left = 174
          Top = 27
          Width = 23
          Height = 22
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FF4A667C
            BE9596FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF6B9CC31E89E84B7AA3C89693FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4BB4FE51B5FF
            2089E94B7AA2C69592FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF51B7FE51B3FF1D87E64E7AA0CA9792FF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            51B7FE4EB2FF1F89E64E7BA2B99497FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF52B8FE4BB1FF2787D95F6A76FF
            00FFB0857FC09F94C09F96BC988EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF55BDFFB5D6EDBF9D92BB9B8CE7DAC2FFFFE3FFFFE5FDFADAD8C3
            B3B58D85FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA795FD
            EEBEFFFFD8FFFFDAFFFFDBFFFFE6FFFFFBEADDDCAE837FFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFC1A091FBDCA8FEF7D0FFFFDBFFFFE3FFFFF8FFFF
            FDFFFFFDC6A99CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1A091FEE3ACF1
            C491FCF2CAFFFFDDFFFFE4FFFFF7FFFFF7FFFFE9EEE5CBB9948CFF00FFFF00FF
            FF00FFFF00FFFF00FFC2A191FFE6AEEEB581F7DCAEFEFDD8FFFFDFFFFFE3FFFF
            E4FFFFE0F3ECD2BB968EFF00FFFF00FFFF00FFFF00FFFF00FFBC978CFBE7B7F4
            C791F2C994F8E5B9FEFCD8FFFFDDFFFFDCFFFFE0E2D2BAB68E86FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFD9C3A9FFFEE5F7DCB8F2C994F5D4A5FAE8BDFDF4
            C9FDFBD6B69089FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB58D85E8
            DEDDFFFEF2F9D8A3F4C48CF9D49FFDEAB8D0B49FB89086FF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFAD827FC9AA9EEFE0B7EFDFB2E7CEACB890
            86B89086FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFBA968ABB988CB79188FF00FFFF00FFFF00FFFF00FF}
          OnClick = cmdSearchReferenciaClick
        end
        object edReferencia: TEdit
          Left = 41
          Top = 27
          Width = 130
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 0
          OnKeyDown = edReferenciaKeyDown
        end
      end
      object optReferencia: TRadioButton
        Left = 406
        Top = 10
        Width = 115
        Height = 17
        Caption = 'por Refer'#234'ncia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = optSubGrupoClick
      end
      object gbDescricao: TGroupBox
        Left = 393
        Top = 90
        Width = 384
        Height = 68
        Anchors = [akLeft, akTop, akRight]
        Enabled = False
        TabOrder = 4
        DesignSize = (
          384
          68)
        object cmdSearchDescricao: TSpeedButton
          Left = 351
          Top = 26
          Width = 23
          Height = 22
          Anchors = [akTop, akRight]
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FF4A667C
            BE9596FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FF6B9CC31E89E84B7AA3C89693FF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4BB4FE51B5FF
            2089E94B7AA2C69592FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FF51B7FE51B3FF1D87E64E7AA0CA9792FF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            51B7FE4EB2FF1F89E64E7BA2B99497FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF52B8FE4BB1FF2787D95F6A76FF
            00FFB0857FC09F94C09F96BC988EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF55BDFFB5D6EDBF9D92BB9B8CE7DAC2FFFFE3FFFFE5FDFADAD8C3
            B3B58D85FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA795FD
            EEBEFFFFD8FFFFDAFFFFDBFFFFE6FFFFFBEADDDCAE837FFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFC1A091FBDCA8FEF7D0FFFFDBFFFFE3FFFFF8FFFF
            FDFFFFFDC6A99CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1A091FEE3ACF1
            C491FCF2CAFFFFDDFFFFE4FFFFF7FFFFF7FFFFE9EEE5CBB9948CFF00FFFF00FF
            FF00FFFF00FFFF00FFC2A191FFE6AEEEB581F7DCAEFEFDD8FFFFDFFFFFE3FFFF
            E4FFFFE0F3ECD2BB968EFF00FFFF00FFFF00FFFF00FFFF00FFBC978CFBE7B7F4
            C791F2C994F8E5B9FEFCD8FFFFDDFFFFDCFFFFE0E2D2BAB68E86FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFD9C3A9FFFEE5F7DCB8F2C994F5D4A5FAE8BDFDF4
            C9FDFBD6B69089FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB58D85E8
            DEDDFFFEF2F9D8A3F4C48CF9D49FFDEAB8D0B49FB89086FF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFAD827FC9AA9EEFE0B7EFDFB2E7CEACB890
            86B89086FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFBA968ABB988CB79188FF00FFFF00FFFF00FFFF00FF}
          OnClick = cmdSearchDescricaoClick
        end
        object edDescricao: TEdit
          Left = 41
          Top = 26
          Width = 306
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          TabOrder = 0
          OnKeyDown = edDescricaoKeyDown
        end
      end
      object optDescricao: TRadioButton
        Left = 406
        Top = 87
        Width = 115
        Height = 17
        Caption = 'por Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = optSubGrupoClick
      end
      object stPecas: TCSDVirtualStringTree
        Left = 6
        Top = 162
        Width = 774
        Height = 250
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsSingle
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsFlatButtons
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        TabOrder = 6
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
        OnCompareNodes = stPecasCompareNodes
        OnDblClick = stPecasDblClick
        OnEditing = stPecasEditing
        OnGetText = stPecasGetText
        OnPaintText = stPecasPaintText
        OnNewText = stPecasNewText
        OnResize = stPecasResize
        AutoEdit = True
        ColumnDefs = <
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end
          item
            OnGetPickItems = stPecasColumnDefs1GetPickItems
            FldType = ctDropDownList
            MaxLength = 0
            ReadOnly = False
            CustomFldType = 6
          end>
        MustBlockBoundaryEditExit = True
        Columns = <
          item
            Position = 0
            Width = 676
            WideText = 'Pe'#231'a'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 76
            WideText = 'Vers'#227'o'
          end>
      end
      object cmdShowFicha: TBitBtn
        Left = 462
        Top = 424
        Width = 316
        Height = 25
        Caption = '&Recuperar Ficha T'#233'cnica da Pe'#231'a Selecionada'
        TabOrder = 7
        OnClick = cmdShowFichaClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460FEEBF82E98E3593460FFF00FF00000000000000
          0000000000000000000000000000000000000000000000FF00FF93460F5DD270
          F7DAB793460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      end
    end
    object tbFicha: TTabSheet
      Caption = 'Ficha T'#233'cnica'
      ImageIndex = 1
      object Splitter2: TSplitter
        Left = 431
        Top = 21
        Width = 4
        Height = 421
        Align = alRight
      end
      object paImg: TPanel
        Left = 435
        Top = 21
        Width = 347
        Height = 421
        Align = alRight
        BevelInner = bvLowered
        Color = clWhite
        TabOrder = 0
        object imPeca: TImage
          Left = 2
          Top = 242
          Width = 343
          Height = 177
          Align = alBottom
          Center = True
          Proportional = True
        end
        object Splitter3: TSplitter
          Left = 2
          Top = 238
          Width = 343
          Height = 4
          Cursor = crVSplit
          Align = alBottom
          Color = clBtnFace
          ParentColor = False
        end
        object stFases: TCSDVirtualStringTree
          Left = 2
          Top = 2
          Width = 343
          Height = 236
          Align = alClient
          BorderStyle = bsSingle
          Header.AutoSizeIndex = -1
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoColumnResize, hoDrag, hoVisible]
          Header.Style = hsFlatButtons
          HintAnimation = hatNone
          HintMode = hmDefault
          IncrementalSearchDirection = sdForward
          PopupMenu = popOperacoes
          TabOrder = 0
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
          OnChange = stFasesChange
          OnDblClick = stFasesDblClick
          OnEditing = stComponentesEditing
          OnGetText = stFasesGetText
          OnResize = stFasesResize
          AutoEdit = False
          ColumnDefs = <
            item
              FldType = ctString
              MaxLength = 0
              ReadOnly = True
            end>
          MustBlockBoundaryEditExit = True
          Columns = <
            item
              Position = 0
              Width = 320
              WideText = 'Opera'#231#245'es'
            end>
        end
      end
      object stComponentes: TCSDVirtualStringTree
        Left = 0
        Top = 21
        Width = 431
        Height = 421
        Align = alClient
        BorderStyle = bsSingle
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsFlatButtons
        HintAnimation = hatNone
        HintMode = hmDefault
        Images = ImageList1
        IncrementalSearchDirection = sdForward
        PopupMenu = pop
        TabOrder = 1
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
        OnChange = stComponentesChange
        OnDblClick = cmPropertiesClick
        OnEditing = stComponentesEditing
        OnGetText = stComponentesGetText
        OnGetImageIndex = stComponentesGetImageIndex
        OnResize = stComponentesResize
        AutoEdit = False
        ColumnDefs = <
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end
          item
            FldType = ctFloat
            MaxLength = 0
            ReadOnly = True
            CustomFldType = 2
          end
          item
            FldType = ctFloat
            MaxLength = 0
            ReadOnly = True
            CustomFldType = 2
          end>
        MustBlockBoundaryEditExit = True
        Columns = <
          item
            Position = 0
            Width = 296
            WideText = 'clPeca'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 56
            WideText = 'clQtde'
          end
          item
            Alignment = taRightJustify
            Position = 2
            Width = 56
            WideText = 'clCusto'
          end>
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 782
        Height = 21
        Align = alTop
        BevelInner = bvLowered
        TabOrder = 2
        object cmdCollapsePeca: TSpeedButton
          Left = 97
          Top = 3
          Width = 18
          Height = 15
          Hint = 'Contrair Todos'
          Flat = True
          Glyph.Data = {
            86050000424DC605000000000000B60000002800000012000000120000000100
            2000000000001005000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000808080008080800080808000808080008080
            8000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C00080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF0080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000FFFFFF000000000000000000000000000000
            000000000000FFFFFF0080808000C0C0C00080808000C0C0C00080808000C0C0
            C00080808000C0C0C000C0C0C000C0C0C00080808000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C00080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF0080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000808080008080800080808000808080008080
            8000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000}
          ParentShowHint = False
          ShowHint = True
          OnClick = cmdCollapsePecaClick
        end
        object cmdExpandPeca: TSpeedButton
          Left = 77
          Top = 3
          Width = 18
          Height = 15
          Hint = 'Expandir Todos'
          Flat = True
          Glyph.Data = {
            86050000424DC605000000000000B60000002800000012000000120000000100
            2000000000001005000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000808080008080800080808000808080008080
            8000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFFFF00FFFFFF00FFFF
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFF
            FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0080808000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C00080808000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
            FF0080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000FFFFFF000000000000000000000000000000
            000000000000FFFFFF0080808000C0C0C00080808000C0C0C00080808000C0C0
            C00080808000C0C0C000C0C0C000C0C0C00080808000FFFFFF00FFFFFF00FFFF
            FF0000000000FFFFFF00FFFFFF00FFFFFF0080808000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000FFFF
            FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0080808000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C00080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
            FF0080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000808080008080800080808000808080008080
            8000808080008080800080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00080808000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000}
          ParentShowHint = False
          ShowHint = True
          OnClick = cmdExpandPecaClick
        end
        object lFicha: TLabel
          Left = 5
          Top = 4
          Width = 68
          Height = 13
          Caption = 'Ficha T'#233'cnica'
        end
      end
    end
    object tbProdutosPeca: TTabSheet
      Caption = 'Produtos Pe'#231'a'
      ImageIndex = 2
      DesignSize = (
        782
        442)
      object laProdutoTitle: TLabel
        Left = 0
        Top = 0
        Width = 782
        Height = 31
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -24
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object stProdutos: TCSDVirtualStringTree
        Left = 4
        Top = 33
        Width = 774
        Height = 377
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsSingle
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsFlatButtons
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
        OnCompareNodes = stProdutosCompareNodes
        OnDblClick = stProdutosDblClick
        OnGetText = stProdutosGetText
        OnResize = stProdutosResize
        AutoEdit = True
        ColumnDefs = <
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end>
        MustBlockBoundaryEditExit = True
        Columns = <
          item
            Position = 0
            Width = 620
            WideText = 'Produto'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 64
            WideText = 'Vers'#227'o'
          end
          item
            Alignment = taRightJustify
            Position = 2
            Width = 64
            WideText = 'Qtde'
          end>
      end
      object cmdRetrieveFichaProduto: TBitBtn
        Left = 462
        Top = 423
        Width = 316
        Height = 25
        Caption = '&Recuperar Ficha T'#233'cnica do Produto Selecionado'
        TabOrder = 1
        OnClick = cmdRetrieveFichaProdutoClick
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460FEEBF82E98E3593460FFF00FF00000000000000
          0000000000000000000000000000000000000000000000FF00FF93460F5DD270
          F7DAB793460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF93460F93460F93460F93460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460FEEBF82
          E98E3593460FFF00FF0000000000000000000000000000000000000000000000
          00000000000000FF00FF93460F5DD270F7DAB793460FFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF93460F93460F
          93460F93460FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      end
    end
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 790
    Height = 37
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 29
        Width = 786
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 773
      Height = 29
      Caption = 'tbTools'
      DisabledImages = ImageList2
      EdgeBorders = []
      Flat = True
      Images = ImageList1
      TabOrder = 0
      object cmdAddComponente: TToolButton
        Left = 0
        Top = 0
        Hint = 'Incluir Pe'#231'a'
        Caption = 'cmdAddComponente'
        Enabled = False
        ImageIndex = 6
        OnClick = cmInsertClick
      end
      object cmdDeleteComponente: TToolButton
        Left = 23
        Top = 0
        Hint = 'Excluir Pe'#231'a'
        Caption = 'cmdDeleteComponente'
        Enabled = False
        ImageIndex = 9
        OnClick = cmDeleteClick
      end
      object cmdPropertiesComponente: TToolButton
        Left = 46
        Top = 0
        Hint = 'Propriedades da Pe'#231'a'
        Caption = 'cmdPropertiesComponente'
        Enabled = False
        ImageIndex = 5
        OnClick = cmPropertiesClick
      end
      object ToolButton4: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object cmdAddFase: TToolButton
        Left = 77
        Top = 0
        Hint = 'Incluir Fase de Produ'#231#227'o'
        Caption = 'cmdAddFase'
        Enabled = False
        ImageIndex = 8
        OnClick = cmNovaFaseClick
      end
      object cmdDeleteFase: TToolButton
        Left = 100
        Top = 0
        Hint = 'Excluir Fase de Produ'#231#227'o'
        Caption = 'cmdDeleteFase'
        Enabled = False
        ImageIndex = 24
        OnClick = cmDeleteOperacaoClick
      end
      object cmdPropertiesFase: TToolButton
        Left = 123
        Top = 0
        Hint = 'Propriedades da Fase de Produ'#231#227'o'
        Caption = 'cmdPropertiesFase'
        Enabled = False
        ImageIndex = 16
        OnClick = cmPropriedadesOperacaoClick
      end
      object ToolButton9: TToolButton
        Left = 146
        Top = 0
        Width = 6
        Caption = 'ToolButton9'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object cmdAddOperacao: TToolButton
        Left = 152
        Top = 0
        Hint = 'Incluir Opera'#231#227'o'
        Caption = 'cmdAddOperacao'
        Enabled = False
        ImageIndex = 18
        OnClick = cmNovaOperacaoClick
      end
      object cmdDeleteOperacao: TToolButton
        Left = 175
        Top = 0
        Hint = 'Excluir Opera'#231#227'o'
        Caption = 'cmdDeleteOperacao'
        Enabled = False
        ImageIndex = 19
        OnClick = cmDeleteOperacaoClick
      end
      object cmdPropertiesOperacao: TToolButton
        Left = 198
        Top = 0
        Hint = 'Propriedades da Opera'#231#227'o'
        Caption = 'cmdPropertiesOperacao'
        Enabled = False
        ImageIndex = 22
        OnClick = cmPropriedadesOperacaoClick
      end
    end
  end
  object pop: TPopupMenu
    OnPopup = popPopup
    Left = 506
    Top = 10
    object cmDelimiter1: TMenuItem
      Caption = '-'
    end
    object cmInsert: TMenuItem
      Caption = '&Incluir'
      OnClick = cmInsertClick
    end
    object cmDelete: TMenuItem
      Caption = 'E&xcluir'
      OnClick = cmDeleteClick
    end
    object cmDelimiter2: TMenuItem
      Caption = '-'
    end
    object cmProperties: TMenuItem
      Caption = '&Propriedades'
      OnClick = cmPropertiesClick
    end
  end
  object ImageList1: TImageList
    Left = 470
    Top = 10
    Bitmap = {
      494C010119001D00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000008000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000732DE000732DE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000732DE000732DE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000732DE000732DE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000732DE000732DE000732
      DE00000000000000000000000000000000000000000000000000000000000000
      00000732DE000732DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000732DE000732DD000732
      DE000732DE000000000000000000000000000000000000000000000000000732
      DE000732DE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000534ED000732
      DF000732DE000732DE00000000000000000000000000000000000732DE000732
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000732DE000732DE000732DD00000000000732DD000732DE000732DE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000732DD000633E6000633E6000633E9000732DC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000633E3000732E3000534EF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000732DD000534ED000533E9000434EF000434F500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000434F4000534EF000533EB0000000000000000000434F4000335F8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000335
      FC000534EF000434F800000000000000000000000000000000000335FC000335
      FB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000335FB000335
      FB000335FC000000000000000000000000000000000000000000000000000335
      FB000335FB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000335FB000335FB000335
      FB00000000000000000000000000000000000000000000000000000000000000
      0000000000000335FB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000335FB000335FB000335FB000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000335FB000335FB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000020A1C9002CAACF001082AC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      0000000000000000000000000000000000000000000000000000000000002BA3
      C90024A5CC000F84AE00149AC30024AED60033B1D500188BB4001787AF0043AB
      CC003DA8CB000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093460F0093460F0093460F009346
      0F000000000000000000000000000000000093460F0093460F0093460F009346
      0F0000000000000000000000000000000000A67A7500F1E1D600EEDBCD00ECD6
      C500EAD1BD00E7CCB500E5C8AD00E3C3A500E0BF9D00A67A7500000000000000
      0000000000000335FB00000000000000000000000000000000000000000032A5
      C90037B8DC0014AED90011A1CB001DC7F00048D7F80034A6CA005CC1DD0067C4
      DE003FA4C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093460F00B2CFB100BEA469009346
      0F000000000000000000000000000000000093460F00B2CFB100BEA469009346
      0F0000000000000000000000000000000000A67A7500FCF7F200FAF1E700F9EC
      DC00F7E7D200F5E2C800F4DDBE00F3D8B400F1D4A900A67A7500000000000000
      00000335FB000335FB00000000000000000000000000208CB4002C98BD004EB5
      D50085DBEF0051C0DE0039C8EC001ED7FF003ADBFF005FD4F10075C6DF00B0E1
      EC0090CEE1001B8BB5000000000000000000000000000000000093460F009346
      0F0093460F0093460F0093460F00000000000000000093460F0093460F009346
      0F0093460F0093460F00000000000000000093460F0092C16300EDB172009346
      0F000000000000000000000000000000000093460F0092C16300EDB172009346
      0F0000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      000000000000000000000330E200000000000000000060BAD70048B0D20053BE
      E00095EDFF008DEFFF005AE5FF0027DAFF001CD8FF0052E2FF0079E8FF007DEB
      FF003FCBEE0031B1D9002CA4CE0000000000000000000000000093460F003AFA
      FF005AE0ED0060DEDF0093460F00000000000000000093460F003AFAFF005AE0
      ED0060DEDF0093460F00000000000000000093460F0093460F0093460F009346
      0F000000000000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000335FB00000000001391C00022A6D7004EC3
      EA0081DFF70092EFFF0071D3E8005CB8CC0050B2C9002AC7EB0007D1FF0004CF
      FE0009D0FE0008C9F5000EB4E10000000000000000000000000093460F00D5C6
      9B00DC9B5200D981260093460F00000000000000000093460F00D5C69B00DC9B
      5200D981260093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      000000000000000000000000000000000000000000001C8EB80028ADDE003FBB
      E7006DD7F60091C7D3009796960097969600979696009796960045BCD80002D2
      FF0014D3FE001ED2FB000C9ECB0000000000000000000000000093460F007FB8
      5400DBA96200EF9F540093460F00000000000000000093460F007FB85400DBA9
      6200EF9F540093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500F1E1D600EEDBCD00ECD6
      C500EAD1BD00E7CCB500E5C8AD00E3C3A500E0BF9D00A67A7500000000000000
      0000000000000335FB000000000000000000000000001E92BC0027ADDF0031B4
      E3005ACFF40097969600E9E3E200B2B3B300ACA2A200E1B7B5009796960059DC
      FA009CF0FF00B5EFFC003D9BBD0000000000000000000000000093460F009346
      0F0093460F0093460F0093460F00000000000000000093460F0093460F009346
      0F0093460F0093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500FCF7F200FAF1E700F9EC
      DC00F7E7D200F5E2C800F4DDBE00F3D8B400F1D4A900A67A7500000000000000
      00000335FB000335FB00000000000000000000000000148CB8001F9DCD0027AC
      DD0047C5EF0097969600E9E2E000B1B2B200ACA2A200DCB5B400979696007CE4
      FB00ACECF9008ACBE00048A5C400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      000000000000000000000330E2000000000000000000000000000E80AA0020A2
      D30036BCEB0097969600E9E2E000B1B2B200ACA2A200DDB6B4009796960065E1
      FD0068CAE6000579A40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093460F0093460F0093460F009346
      0F000000000000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000335FB000000000000000000000000001389
      B4000D8FBE0097969600ECE5E200B1B2B200ACA2A200E0B8B600979696001E9A
      C1002293BA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093460F00B2CFB100BEA469009346
      0F000000000000000000000000000000000093460F00B2CFB100BEA469009346
      0F0000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000097969600E5E3E200AEAFAF00ABA1A100D8B6B600979696000000
      000000000000000000000000000000000000000000000000000093460F009346
      0F0093460F0093460F0093460F00000000000000000093460F0093460F009346
      0F0093460F0093460F00000000000000000093460F0092C16300EDB172009346
      0F000000000000000000000000000000000093460F0092C16300EDB172009346
      0F0000000000000000000000000000000000A67A7500F1E1D600EEDBCD00ECD6
      C500EAD1BD00E7CCB500E5C8AD00E3C3A500E0BF9D00A67A7500000000000000
      0000000000000335FB0000000000000000000000000000000000000000000000
      00000000000097969600B2B2B200A0A0A00099969600ABA0A000979696000000
      000000000000000000000000000000000000000000000000000093460F003AFA
      FF005AE0ED0060DEDF0093460F00000000000000000093460F003AFAFF005AE0
      ED0060DEDF0093460F00000000000000000093460F0093460F0093460F009346
      0F000000000000000000000000000000000093460F0093460F0093460F009346
      0F0000000000000000000000000000000000A67A7500FCF7F200FAF1E700F9EC
      DC00F7E7D200F5E2C800F4DDBE00F3D8B400F1D4A900A67A7500000000000000
      00000335FB000335FB0000000000000000000000000000000000000000000000
      00000000000097969600E1E0E000C6C7C700A5A3A300B3A5A500979696000000
      000000000000000000000000000000000000000000000000000093460F00D5C6
      9B00DC9B5200D981260093460F00000000000000000093460F00D5C69B00DC9B
      5200D981260093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      000000000000000000000330E200000000000000000000000000000000000000
      00000000000097969600E5E4E400EAE9E900BCBCBC00A39E9E00979696000000
      000000000000000000000000000000000000000000000000000093460F007FB8
      5400DBA96200EF9F540093460F00000000000000000093460F007FB85400DBA9
      6200EF9F540093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000335FB000000000000000000000000000000
      0000000000000000000097969600979696009796960097969600000000000000
      000000000000000000000000000000000000000000000000000093460F009346
      0F0093460F0093460F0093460F00000000000000000093460F0093460F009346
      0F0093460F0093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000005710A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000005710A00000000000000
      000000000000000000000000000000000000B7818300B7818300B7818300B781
      8300B7818300B7818300B7818300B7818300B7818300B7818300B7818300B781
      8300B781830000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000005710A0005710A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000005710A0005710A000000
      000000000000000000000000000000000000B7818300FDEFD900F4E1C900E4CF
      B400D1BCA000CDB79800DAC09A00E4C59900E9C89600EDCB9600EECC9700F3D1
      9900B781830000000000000000000000000093460F00EEBF8200E98E35009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000005710A0076F9A70005710A0005710A0005710A000571
      0A0005710A0005710A0000000000000000000000000000000000000000000000
      000005710A0005710A0005710A0005710A0005710A0005710A0020B335000571
      0A0000000000000000000000000000000000B4817600FEF3E300F8E7D3004946
      4500373C3E0051606100AE9C8200BFA88900D0B48D00E4C39300EDCB9600F3D1
      9900B781830000000000000000000000000093460F005DD27000F7DAB7009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000005710A0076F9A70076F9A7006FF39E005BE3830042CE610028B9
      3F0014A8240005710A0000000000000000000000000000000000000000000000
      000005710A0076F9A70076F9A70076F9A7006BF0970051DA750033C24D0019AC
      2A0005710A00000000000000000000000000B4817600FFF7EB00F9EBDA00B0A5
      98001B617D00097CA80018556F0066625B00A7947900C5AC8600DCBD8D00EECD
      9500B781830000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000005710A0076F9A70005710A0005710A0005710A000571
      0A0005710A0005710A0000000000000000000000000000000000000000000000
      000005710A0005710A0005710A0005710A0005710A0005710A0047D368000571
      0A0000000000000000000000000000000000BA8E8500FFFCF400FAEFE400F2E5
      D6003872860029799A008D787F00956D6F00795953009D8B7300BAA38000D9BC
      8C00B47F81000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001C78D5001C78D5001C78
      D5001C78D5001C5996000000000005710A0005710A000000000000000000E4F0
      FC001C78D5001C78D5001C78D5001C78D500000000001C78D5001C78D5001C78
      D5001C78D5001C59960000000000000000000000000005710A0005710A00E4F0
      FC001C78D5001C78D5001C78D5001C78D500BA8E8500FFFFFD00FBF4EC00FAEF
      E300A5B3B1007C707800E5A6A300C8929200A47272007657510095856C00AF99
      7800A877790000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C78D50082C6F90057BCFF004EB5
      FF004DB4FF001C599600000000000000000005710A000000000000000000E4F0
      FC002A95FF00369BFF00379CFF001C78D5001C78D50082C6F90057BCFF004EB5
      FF004DB4FF001C59960000000000000000000000000005710A0000000000E4F0
      FC002A95FF00369BFF00379CFF001C78D500CB9A8200FFFFFF00FEF9F500FBF3
      EC00F4EBDF0085787C00EEB7B500DAA6A600C38E8E009E6E6E0073564F009383
      6B00996E6F0000000000000000000000000093460F00EEBF8200E98E35009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C78D5007DC3F70056BCFF004EB4
      FE004DB3FF001C5996000000000000000000000000000000000000000000E4F0
      FC002893FF003499FF00359AFF001C78D5001C78D5007DC3F70056BCFF004EB4
      FE004DB3FF001C5996000000000000000000000000000000000000000000E4F0
      FC002893FF003499FF00359AFF001C78D500CB9A8200FFFFFF00FFFEFD00FDF8
      F400FBF3EC00F0E4D900A3797800E9B5B500D9A5A500C48F8F009D6D6D007759
      52008F67690000000000000000000000000093460F005DD27000F7DAB7009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C78D50080C6F9005BC1FF0053BA
      FF0052B8FF001C5996000000000000000000000000000000000000000000E4F0
      FC001F8EFF002B95FF002C96FF001C78D5001C78D50080C6F9005BC1FF0053BA
      FF0052B8FF001C5996000000000000000000000000000000000000000000E4F0
      FC001F8EFF002B95FF002C96FF001C78D500DCA88700FFFFFF00FFFFFF00FFFE
      FD00FEF9F400FBF3EB00E8D9CE009E747300E8B5B500D8A4A400C18D8D009D6C
      6C007D55560000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C78D50080C6F9005BC1FF0053BA
      FF0052B8FF001C5996000000000000000000000000000000000000000000E4F0
      FC00E4F0FC00E4F0FC00E4F0FC00E4F0FC001C78D50080C6F9005BC1FF0053BA
      FF0052B8FF001C5996000000000000000000000000000000000000000000E4F0
      FC00E4F0FC00E4F0FC00E4F0FC00E4F0FC00DCA88700FFFFFF00FFFFFF00FFFF
      FF00FFFEFD00FDF9F400FBF3EB00E0CFC500A1767600ECB9B900D6A2A200C68E
      8E00965F5D00585C600000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C78D500629DCF003589CF003589
      CF003589CF001C5996001C5996001C5996001C5996001C5996001C5996000000
      0000000000000000000000000000000000001C78D500629DCF003589CF003589
      CF003589CF001C5996001C5996001C5996001C5996001C5996001C5996000000
      000000000000000000000000000000000000E3B18E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFEFD00FDF8F300FDF6EC00DAC5BC00AC808000F3BCBB00A387
      8C003392B30019ADCC0019ADCC000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C78D50086CCF90065CBFF005DC3
      FF005CC4FF003589CF0053BAFF0053BAFF004EB4FF004DB4FF001C78D5000000
      0000000000000000000000000000000000001C78D50086CCF90065CBFF005DC3
      FF005CC4FF003589CF0053BAFF0053BAFF004EB4FF004DB4FF001C78D5000000
      000000000000000000000000000000000000E3B18E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFEFC00FFFEF900E3CFC900AA7A7100B2787300469C
      BA000FCAF40000A4E600021EAA000000990093460F00EEBF8200E98E35009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C78D50084C9F70065CAFF005EC3
      FE005EC4FF003589CF0053BAFF0054BAFF004FB4FE004FB4FF001C78D5000000
      0000000000000000000000000000000000001C78D50084C9F70065CAFF005EC3
      FE005EC4FF003589CF0053BAFF0054BAFF004FB4FE004FB4FF001C78D5000000
      000000000000000000000000000000000000EDBD9200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4D4D200B8857A00DCA76A0010A5
      CF0004A8E6000936C900092CC3000318AE0093460F005DD27000F7DAB7009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C78D50085CBF80064CBFF005EC6
      FF005EC7FF003589CF0053BAFF0055BDFF0050B7FF0050B7FF001C78D5000000
      0000000000000000000000000000000000001C78D50085CBF80064CBFF005EC6
      FF005EC7FF003589CF0053BAFF0055BDFF0050B7FF0050B7FF001C78D5000000
      000000000000000000000000000000000000EDBD9200FCF7F400FCF7F300FBF6
      F300FBF6F300FAF5F300F9F5F300F9F5F300E1D0CE00B8857A00CF9B86000000
      0000077DCD004860F100204ADD000416AA0093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C78D5009ECFF50092D7FD0088D2
      FC008CD5FD00629DCF0085CEFD0085CEFD0080C9FC0084CBFD001C78D5000000
      0000000000000000000000000000000000001C78D5009ECFF50092D7FD0088D2
      FC008CD5FD00629DCF0085CEFD0085CEFD0080C9FC0084CBFD001C78D5000000
      000000000000000000000000000000000000EDBD9200DCA88700DCA88700DCA8
      8700DCA88700DCA88700DCA88700DCA88700DCA88700B8857A00000000000000
      0000000000003E4BDB00192DC400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001C78D5001C78D5001C78
      D5001C78D5001C78D5001C78D5001C78D5001C78D5001C78D500000000000000
      000000000000000000000000000000000000000000001C78D5001C78D5001C78
      D5001C78D5001C78D5001C78D5001C78D5001C78D5001C78D500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE0000000000000000000000000000000000000000000000
      00000000000000000000000000002B90EF00278DE70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000000000000000078DBE0063CBF800078DBE00A3E1
      FB0066CDF90065CDF80065CDF90065CDF90065CDF80065CDF90065CDF80066CD
      F8003AADD800ACE7F500078DBE00000000000000000000000000000000000000
      000000000000000000002A8FEC00278CED002489E4002388DD001E84D5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C000000000000000000000000000078DBE006AD1F900078DBE00A8E5
      FC006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4FA006FD4FA006ED4
      F9003EB1D900B1EAF500078DBE00000000000000000000000000000000000000
      000000000000298FD6003DA2EB003EA3F000379CEA002186DA001A81D100187E
      CA00157CC4001177BB0000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF008000000080000000FFFFFF0080000000800000008000000080000000FFFF
      FF00C0C0C000000000000000000000000000078DBE0072D6FA00078DBE00AEEA
      FC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADCFB0079DCFA0079DC
      FA0044B5D900B6EEF600078DBE00000000000000000000000000000000000000
      0000000000003CA2E10058BDF20060C4F9003D9EE50057BCF7003398DF001E83
      CD001076BC000B73B4000B72AF00086FAA000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C000000000000000000000000000078DBE0079DDFB00078DBE00B5EE
      FD0083E4FB0084E4FB0083E4FC0083E4FC0084E4FC0083E4FC0083E4FB0084E5
      FC0048B9DA00BBF2F600078DBE00000000000000000000000000000000000000
      0000046B16004AB0F90053B7F7002F87D10063C7FB003D9EE5005BBFFB0055BA
      FA003499DE002D93D8000F76B300066DA7000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF008000000080000000FFFFFF0080000000800000008000000080000000FFFF
      FF00C0C0C000000000000000000000000000078DBE0082E3FC00078DBE00BAF3
      FD008DEBFC009933000099330000993300009933000099330000993300009933
      000099330000BEF4F700078DBE0000000000000000000000000000000000187D
      5F002B7A8300046B16002884DE003C99D900227BCE0040A0EA005ABEFE004FB2
      F50056B9FF0056B9FF0046AAF300000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C000000000000000000000000000078DBE008AEAFC00078DBE00FFFF
      FF00C9F7FE0099330000FEFEFE00FEFEFE00FEFEFE008EA4FD00B8C6FD00FEFE
      FE0099330000DEF9FB00078DBE000000000000000000000000000F7D15003CBE
      610031C6480031C6480031C64800046B1600046B16002D87B6003998E80044A5
      F00052B6FF0052B5FF0000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00C0C0C000000000000000000000000000078DBE0093F0FE00078DBE00078D
      BE00078DBE0099330000FEFEFE00FAFBFE007E98FC000335FB00597AFC00FEFE
      FE0099330000078DBE00078DBE0000000000000000001587220031AF4A0062F9
      920050EB6F0031C648001DA746002398760031C6480031C64800046B1600046B
      1600000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000FFFF000000
      0000C0C0C000000000000000000000000000078DBE009BF5FE009AF6FE009AF6
      FE009BF5FD0099330000D6DEFE004368FC000335FB004066FC000436FB00D9E0
      FE00993300000000000000000000000000000000000030AD48002BA641004FE7
      780037D053001AB42700029D0100009B000010A41E0032B9720046A7AC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF0000000000FFFFFF0000000000FFFFFF000000000000FFFF0000000000FFFF
      FF0000000000000000000000000000000000078DBE00FEFEFE00A0FBFF00A0FB
      FE00A0FBFE00993300005274FC001442FB00BCC9FD00EFF2FE001A47FB004F72
      FC009733040000000000000000000000000000000000000000000A7510002AAE
      3F0022BC3200049A0600009400000CA118000278040002780400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F00000000007F7F7F00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF000000000000FFFF000000000000FFFF0000000000FFFFFF000000
      0000FFFFFF0000FFFF00FFFFFF000000000000000000078DBE00FEFEFE00A5FE
      FF00A5FEFF0099330000E4EAFE00D9E0FE00FEFEFE00FEFEFE0098ACFD000335
      FB00643459000000000000000000000000000000000000000000259E390042DC
      64000B9F110000770000027804000B8717000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000078DBE00078D
      BE00078DBE0099330000FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE005677
      FC000335FB00000000000000000000000000000000001D912C0044DE68000FA3
      1500006F00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BFBFBF00BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000000000000000000000
      0000000000009933000099330000993300009933000099330000993300008F33
      11002235C8000335FB00000000000000000013831D0043D9640012AB1C000073
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000335FB000335FB000335FB001C9A2A001AB12700007900000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F7F007F7F7F007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000335FB0018A02400027F0400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A87D7800B7818300B7818300B7818300B7818300B781
      8300B7818300B7818300B7818300B78183000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000008080
      8000FFFFFF00C0C0C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C0008080
      8000C0C0C0008080800000000000000000000000000000000000000000000000
      00000000000000000000AB7F7900FFFCDC00FBE6C400FAE2B900F7DCAC00F6D7
      A100F4D49900F4D49900FDDF9D00B3897B000000000000000000000000000000
      0000F5CA9900F6D1A100F5CB9900F3C18B00F2C08800F3C38E00000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007F7F7F007F7F7F007F7F7F0000FFFF0000FFFF007F7F7F007F7F7F007F7F
      7F007F7F7F0000FFFF0000FFFF00000000000000000000000000000000008080
      8000FFFFFF0000000000C0C0C000FFFFFF0000000000C0C0C000C0C0C0000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      00000000000000000000AF827900FFF6E200F5E2CA00F5DEC000F2D8B5000470
      0900EFCEA000EDCB9800F6D59A00B3897B00000000000000000000000000FCF0
      CC00FEF6D500FCE6BE00F6D5A600FCC69600FFC49500FDD6AE00FFE2BF00FEE2
      BA00F4C59000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000FFFFFF00C0C0C00000000000C0C0C000C0C0C0000000
      0000C0C0C0008080800000000000000000000000000000000000000000000000
      00000000000000000000B3867A00FFFCEE00F7E7D300F6E3C9000470090044D2
      730004700900EFCF9E00F6D69900B3897B00000000000000000000000000FEFB
      DD00FEF9D800FCE4BB00F0D6A700BBC888009CBD6F0043A7360072BA5E00EFF6
      D400FDEECC00F2BF890000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000C0C0C000FFFFFF0000000000C0C0C000C0C0C0000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      00000000000000000000B88A7B00FFFFFA00F9EBDE000470090049CC72005CE7
      8E0038C6580004700900F7D9A100B3897B000000000000000000F1B87F00F6D0
      A100FDF4D100FDEBC500FCDBB30044AB3800009402000E9A0F0010970B0057B6
      4E00FEF5DB00F4C28C0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000FFFFFF00C0C0C00000000000C0C0C000C0C0C0000000
      0000C0C0C0008080800000000000000000000000000000000000000000000000
      00000000000000000000BE8E7C00FFFFFF0004700900109726002EA848003ECA
      600026AF3D00199F290004700900B3897B000000000000000000F2BD8700F1BA
      8100F3C18A00F8D5A600FFE1BE0047AD3A000088000084CD8500FFF4EF0063B5
      5200B6C07900FDC08D0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000C0C0C000FFFFFF0000000000C0C0C000C0C0C0000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      00000000000000000000C4937D00FFFFFF00FDF9F500FBF2EA000370080027B8
      400004700900F5DDBE00FCE4BA00B3897B000000000000000000F5C49200F5C7
      9600F4C39000F4BE8900FCC5960093C47B005CB95C0089CB8300FFFFFF00F7FE
      FC00CBCA9200F6BC850000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000FFFFFF00C0C0C00000000000C0C0C000C0C0C0000000
      0000C0C0C0008080800000000000000000000000000000000000000000000000
      00000000000000000000CA977E00FFFFFF00FFFEFE00FEF9F500097B110014AB
      250004700900FCECD100F2E4C300B3897B000000000000000000F9D0A800FBD2
      AD00FAD0A900FACEA600F6CDA100D0DFB800FFFFFF00E2F2DF0071C26E0066C0
      6600C8CB9200FAC18E00000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF00000000000000000000000000000000008080
      8000FFFFFF000000000000000000FFFFFF000000000000000000C0C0C0000000
      000000000000C0C0C000000000000000000000000000A87D7800B7818300B781
      8300B7818300B7818300B7818300B7818300FFFFFF000A8812000C9116000EA3
      1B0004700900D7B9A900BEA49C00B585870000000000F8D4A800FDDEBF00FDDE
      BE00FDDBBB00FDDBBB00FFDEC50078BB610098D49800E7F5E6003EAD3B00008A
      00009AC17600FFCCA600F2BE8700000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF000000000000000000000000008080
      8000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0
      C000C0C0C00080808000000000000000000000000000AC817900FFF0D100F9E4
      C400F7E0BC00F7DEB600ECCCA9000470090004700900049012000D9C19000780
      0F00E3CFCA00BB846F00E2A15A00B381760000000000F8D4A800FFEFD100FEEA
      CB00FEE9C900FEE7C800FFE7C900E2E2BE00169A14002BA12900089708000092
      000090C47800FFD9BC00F2BE8700000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000000000000000000000000000B4877B00FCEFD900E5AB
      5F00E5AB5F00E5AB5F00E9CCAE00B7818300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E1D2D400B3817600E7AF76000000000000000000FBE5BD00FFFCDF00FFF7
      D800FFF6D600FFF4D500FFF3D200FFF5DC00C5DFAD0042AB3B0043AE3B00AFD7
      9E00C5DCAA00FFE7C900F5C79300000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BC8D7C00FDF4E400F8E9
      D600F7E5CE00F7E2C700ECD0B700B7818300DAA48200DAA48200DAA48200DAA4
      8200DAA48200B3817600000000000000000000000000FDF3D100FFFFE100FFFC
      DD00FFFDDE00FFFCDD00FFFCDE00FFFDDE00FFFFE800FFFFF000FFFFED00FFFF
      E700FFFAE000FFF7D700F6CE9D00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF0000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000808080000000000000000000C5947E00FEF9F000E5AB
      5F00E5AB5F00FCEED800EAD6C200B78183000000000000000000000000000000
      00000000000000000000000000000000000000000000FEF7D700FFFFE500FFFF
      E200FFFFE200FFFFE300FFFEE000FEF8D800FAE3B600F7CE9500F7CF9700F9E1
      B600FEF5D200FFFFE500F6D5A700000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000808080000000000000000000CE9A8000FFFEFA00FCF4
      EB00FBF3E600B7818300B7818300B78183000000000000000000000000000000
      00000000000000000000000000000000000000000000F7D8AB00FAE6C000FAE5
      BE00F9E1B900F8DAAE00F6CD9800F3BE8000F0B16A00F0B06700F0B37000F4BE
      8800FBCE9E00FDDDB400FBCEA00000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      000000000000000000008080800000000000C0C0C000C0C0C000808080000000
      00000000000000000000000000000000000000000000D5A08100FFFFFF00FFFF
      FE00FEFCF900B7818300E7AF7600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F1B66F00F3BD8200F9CB
      9B00FBCD9F00FBCB9B00FBCB9B00000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      00000000000000000000000000000000000000000000DAA48200DAA48200DAA4
      8200DAA48200B781830000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBCE
      9F00FBCE9F00FBCE9F00000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B7818300B781
      8300B7818300B7818300B7818300B7818300B7818300B7818300B7818300B781
      8300B7818300B7818300B7818300000000000000000000000000000000000000
      00000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000000000000000000000000000CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC670100CC67010000000000B7818300A4787400A478
      7400A4787400A4787400A4787400A4787400A4787400A4787400A4787400A478
      7400A4787400986B660000000000000000000000000000000000C7A79C00FEEE
      D400F7E3C500F6DFBC00F5DBB400F3D7AB00F3D3A200F1CF9A00F0CF9700F0CF
      9800F0CF9800F5D49A00B7818300000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFAF500FFF3E600FEEBD500FEE3C300FEDCB500FED7AB00FED7AB00FED7
      AB00FED7AB00FED7AB00FED7AB00CC67010000000000B7818300FDEFD900F6E3
      CB00F5DFC200F4DBBA00F2D7B200F1D4A900F1D0A200EECC9900EECC9700EECC
      9700F3D19900986B660000000000000000000000000000000000C7A79E00FDEF
      D900F6E3CB00F5DFC200F4DBBA00F2D7B200F1D4A900F1D0A200EECC9900EECC
      9700EECC9700F3D19900B7818300000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFAF500FFF3E600FEEBD500FEE3C400FEDCB500FED7AB00FED7
      AB00FED7AB00FED7AB00FED7AB00CC67010000000000B4817600FEF3E3009933
      000099330000993300009933000099330000993300009933000099330000EECC
      9700F3D19900986B660000000000000000000000000000000000C7A9A100FEF3
      E300F8E7D300F5E3CB00F5DFC300F3DBBB00F2D7B200F1D4AB00F0D0A300EECC
      9A00EECC9700F3D19900B7818300000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF004571
      FA004571FA004571FA00FFFBF500A23F0800A23F0800A23F0800FEDBB500059A
      CD00059ACD00059ACD00FED7AB00CC67010000000000B4817600FFF7EB009933
      0000FEFEFE00FEFEFE00FEFEFE008EA4FD00B8C6FD00FEFEFE0099330000EFCD
      9900F3D19800986B660000000000000000000000000000000000C9ACA500FFF7
      EB00F9EBDA00F7E7D200F6E3CA00F5DFC200F4DBB900F2D7B200F1D4AA00F0D0
      A100EFCD9900F3D19800B7818300000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF004571
      FA004571FA004571FA00FFFFFF00A23F0800A23F0800A23F0800FEE3C400059A
      CD00059ACD00059ACD00FED7AB00CC67010000000000BA8E8500FFFCF4009933
      0000FEFEFE00FAFBFE007E98FC000335FB00597AFC00FEFEFE0099330000F0D0
      A100F3D29B00986B660000000000000000000000000000000000CEB2AA00FFFC
      F400FAEFE400F8EADA00F7E7D300F5E2CB00F5DFC200F4DBBB00F1D7B200F1D3
      AA00F0D0A100F3D29B00B7818300000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF004571
      FA004571FA004571FA00FFFFFF00A23F0800A23F0800A23F0800FFEBD500059A
      CD00059ACD00059ACD00FED7AB00CC67010000000000BA8E8500FFFFFD009933
      0000D6DEFE004368FC000335FB004066FC000436FB00D9E0FE0099330000F0D4
      A900F5D5A300986B660000000000000000000000000000000000D3B7AF00FFFF
      FD00FBF4EC00FAEFE300F9EBDA00F7E7D200F5E3C900F5DFC200F4DBBA00F2D7
      B100F0D4A900F5D5A300B7818300000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFAF500FEF3E700FEEB
      D500FFE3C300FEDCB500FED7AB00CC67010000000000CB9A8200FFFFFF009933
      00005274FC001442FB00BCC9FD00EFF2FE001A47FB004F72FC0097330400F2D8
      B200F6D9AC00986B660000000000000000000000000000000000D7BBB200FFFF
      FF00FEF9F500FBF3EC00FAEFE200F9EADA00F8E7D200F5E3CA00F5DEC200F4DB
      BA00F2D8B200F6D9AC00B7818300000000000000000000000000FFFFFF000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF00CC9A
      9900CC9A9900CC9A9900FFFFFF00E27E0300E27E0300E27E0300FFFAF400029A
      0300029A0300029A0300FEDCB500CC67010000000000CB9A8200FFFFFF009933
      0000E4EAFE00D9E0FE00FEFEFE00FEFEFE0098ACFD000335FB0064345900F4DB
      B900F8DDB400986B660000000000000000000000000000000000DABEB300FFFF
      FF00FFFEFD00FDF8F400FBF3EC00F9EFE300F8EADA00F7E7D200F6E2CA00F6DE
      C100F4DBB900F8DDB400B781830000000000000000000000000080808000FFFF
      FF008080800080808000FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00CC9A
      9900CC9A9900CC9A9900FFFFFF00E27E0300E27E0300E27E0300FFFFFF00029A
      0300029A0300029A0300FEE3C400CC67010000000000DCA88700FFFFFF009933
      0000FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE005677FC000335FB00F7E1
      C200F0DAB700986B660000000000000000000000000000000000DEC1B500FFFF
      FF00FFFFFF00FFFEFD00FEF9F400FBF3EB00FAEFE200F9EBD900F8E6D100F6E2
      C800F7E1C200F0DAB700B7818300000000000000000000000000000000008080
      800000FFFF0080808000FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF0080808000000000000000000000000000CC670100FFFFFF00CC9A
      9900CC9A9900CC9A9900FFFFFF00E27E0300E27E0300E27E0300FFFFFF00029A
      0300029A0300029A0300FFEBD500CC67010000000000DCA88700FFFFFF009933
      000099330000993300009933000099330000993300008F3311002235C8000335
      FB00C6BCA900986B660000000000000000000000000000000000E2C5B500FFFF
      FF00FFFFFF00FFFFFF00FFFEFD00FDF9F400FBF3EB00FAEEE200FAEDDC00FCEF
      D900E6D9C400C6BCA900B7818300000000000000000000000000FFFFFF00FFFF
      FF0080808000FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C0008080800000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFAF500FFF3E600CC67010000000000E3B18E00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFEFD00FDF8F300FDF6EC00F1E1D500B48176000335
      FB000335FB000335FB0000000000000000000000000000000000E5C7B700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFEFD00FDF8F300FDF6EC00F1E1D500C6A1
      9400B5948900B08F8100B7818300000000000000000000000000000000008080
      80008080800000FFFF00FFFFFF00FFFFFF008080800080808000808080008080
      80000000000000000000000000000000000000000000CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC670100CC67010000000000E3B18E00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFEFC00FFFEF900E3CFC900B4817600E8B2
      7000ECA54A000335FB0000000000000000000000000000000000E9CBB800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFEFC00FFFEF900E3CFC900BF8C
      7600E8B27000ECA54A00C5876800000000000000000000000000000000008080
      800000FFFF008080800000FFFF0080808000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC6701000000000000000000EDBD9200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4D4D200B4817600FAC5
      7700CD9377000000000000000000000000000000000000000000ECCDBA00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4D4D200C89A
      7F00FAC57700CD9377000000000000000000000000000000000080808000FFFF
      FF000000000080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDBD9200FCF7F400FCF7
      F300FBF6F300FBF6F300FAF5F300F9F5F300F9F5F300E1D0CE00B4817600CF9B
      8600000000000000000000000000000000000000000000000000EACAB600FCF7
      F400FCF7F300FBF6F300FBF6F300FAF5F300F9F5F300F9F5F300E1D0CE00C797
      7C00CF9B86000000000000000000000000000000000000000000FFFFFF000000
      00000000000080808000FFFFFF00000000000000000080808000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDBD9200DAA48200DAA4
      8200DAA48200DAA48200DAA48200DAA48200DAA48200DAA48200B48176000000
      0000000000000000000000000000000000000000000000000000E9C6B100EBCC
      B800EBCCB800EBCCB800EBCBB800EACBB800EACBB800EACCB900DABBB000B885
      7A00000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE00000000000000000000000000078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE0063CBF800078DBE00A3E1
      FB0066CDF90065CDF80065CDF90065CDF90065CDF80065CDF90065CDF80066CD
      F8003AADD800ACE7F500078DBE0000000000078DBE0025A1D10071C6E80084D7
      FA0066CDF90065CDF90065CDF90065CDF90065CDF80065CDF90065CDF80066CE
      F9003AADD8001999C90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE006AD1F900078DBE00A8E5
      FC006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4FA006FD4FA006ED4
      F9003EB1D900B1EAF500078DBE0000000000078DBE004CBCE70039A8D100A0E2
      FB006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4FA006FD4FA006ED4
      F9003EB1D900C9F0F300078DBE00000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE0072D6FA00078DBE00AEEA
      FC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADCFB0079DCFA0079DC
      FA0044B5D900B6EEF600078DBE0000000000078DBE0072D6FA00078DBE00AEE9
      FC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADCFB0079DCFA0079DC
      FA0044B5D900C9F0F300078DBE0000000000000000000000000080808000FFFF
      FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
      FF00C0C0C00000FFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE0079DDFB00078DBE00B5EE
      FD0083E4FB0084E4FB0083E4FC0083E4FC0084E4FC0083E4FC0083E4FB0084E5
      FC0048B9DA00BBF2F600078DBE0000000000078DBE0079DDFB001899C7009ADF
      F30092E7FC0084E4FB0083E4FC0083E4FC0084E4FC0083E4FC0083E4FB0084E5
      FC0048B9DA00C9F0F3001496C40000000000000000000000000080808000FFFF
      FF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF00C0C0C00080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE0082E3FC00078DBE00BAF3
      FD008DEBFC008DEBFC008DEBFC008DEBFD008DEBFD008DEBFC008DEBFD008DEB
      FC004CBBDA00BEF4F700078DBE0000000000078DBE0082E3FC0043B7DC0065C2
      E000ABF0FC008DEBFC008DEBFC008DEBFD008DEBFD008DEBFC008DEBFD008DEB
      FC004CBBDA00C9F0F300C9F0F300078DBE00000000000000000080808000FFFF
      FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
      FF00C0C0C00000FFFF00808080000000000000000000000000000000000000FF
      FF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FF
      FF0000000000000000000000000000000000078DBE008AEAFC00078DBE00FFFF
      FF00C9F7FE00C8F7FE00C9F7FE00C9F7FE00C9F7FE00C8F7FE00C9F7FE00C8F7
      FE009BD5E700DEF9FB00078DBE0000000000078DBE008AEAFC0077DCF300219C
      C700FEFFFF00C8F7FD00C9F7FD00C9F7FD00C9F7FE00C8F7FE00C9F7FD00C8F7
      FE009BD5E600EAFEFE00D2F3F800078DBE00000000000000000080808000FFFF
      FF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF00C0C0C00080808000000000000000000000000000FFFFFF000000
      000000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBF
      BF0000FFFF00000000000000000000000000078DBE0093F0FE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE0000000000078DBE0093F0FE0093F0FD001697
      C500078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00000000000000000080808000FFFF
      FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
      FF00C0C0C00000FFFF008080800000000000000000000000000000FFFF00FFFF
      FF000000000000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FF
      FF00BFBFBF0000FFFF000000000000000000078DBE009BF5FE009AF6FE009AF6
      FE009BF5FD009BF6FE009AF6FE009BF5FE009AF6FD009BF5FE009AF6FE009AF6
      FE000989BA00000000000000000000000000078DBE009BF5FE009AF6FE009AF6
      FE009BF5FD009BF6FE009AF6FE009BF5FE009AF6FD009BF5FE009AF6FE009AF6
      FE000989BA00000000000000000000000000000000000000000080808000FFFF
      FF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF00C0C0C00080808000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE00FEFEFE00A0FBFF00A0FB
      FE00A0FBFE00A1FAFE00A1FBFE00A0FAFE00A1FBFE00A1FBFF00A0FBFF00A1FB
      FF000989BA00000000000000000000000000078DBE00FEFEFE00A0FBFF00A0FB
      FE00A0FBFE00A1FAFE00A1FBFE00A0FAFE00A1FBFE00A1FBFF00A0FBFF00A1FB
      FF000989BA00000000000000000000000000000000000000000080808000FFFF
      FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
      FF00C0C0C00000FFFF008080800000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000078DBE00FEFEFE00A5FE
      FF00A5FEFF00A5FEFF00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE000000000000000000000000000000000000000000078DBE00FEFEFE00A5FE
      FF00A5FEFF00A5FEFF00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE0000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000078DBE00078D
      BE00078DBE00078DBE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000078DBE00078D
      BE00078DBE00078DBE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF0080808000808080008080
      800080808000808080008080800000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000C0C0C00000FFFF00C0C0C00000FFFF008080800000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      00000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000800000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFC0000000000009FF9000000000000
      8FF300000000000087E7000000000000C3CF000000000000F11F000000000000
      F83F000000000000FC7F000000000000F83F000000000000F19F000000000000
      E3CF000000000000C7E70000000000008FFB0000000000001FFF000000000000
      3FFF000000000000FFFF000000000000FFFFFFFFFE3FFFFFFFFF0021E007C183
      0F0F0029E007FFFF090900218003C1830F0F00218001C1830F0FFFFE8001C183
      FFFF00218001C183FFFF00298001C183FFFF00218001FFFFFFFF0021C003C183
      0F0FFFFEE007FFFF09090021F81FC1830F0F0029F81FC1830F0F0021F81FC183
      FFFF0021F81FC183FFFFFFFEFC3FC183FFFFFFFFFF7FFFBF00070FFFFE7FFF9F
      00070801FC03F00F00070FFFF803F00700070FFFFC03F00F0007FFFF82608380
      00070FFF036003A00007080103E003E000070FFF03E003E000070FFF03E003E0
      0003FFFF001F001F00010FFF001F001F00000801001F001F00000FFF001F001F
      00100FFF001F001F0039FFFF803F803FE00FC0038003FE7FE00FC0030001FC1F
      E00FC0030001F803E00FC0030001F800E00FC0030001F000E00FC0030001E001
      E00FC0030001C003A00BC0030001800FC007C0030007801FE00FC0010007C03F
      E00FC0008007C0FFC007C000C00787FFC007FE00F8030FFFC007FF00FFF81FFF
      F83FFF81FFFE3FFFF83FFFFFFFFFFFFFFC00FFFFFF7EE001FC00F03F9001E001
      FC00E007C003E001FC00E003E003E001FC00C003E003E001FC00C003E003E001
      FC00C003E003E001FC00C0030001E001800080018000E00180008001E007E001
      80018001E00FC00080038001E00FC00080FF8001E027E00180FF8001C073FC0F
      81FFFF819E79FE1F83FFFFE37EFEFFFFFFFFFFFFC001F80180008003C001F801
      80008003C001F80180008003C001F80180008003C001F80180008003C001F801
      80008003C001F80180008003C001D80180008003C001C00180008003C001E003
      80008003C001C00780008003C001E00F80008003C001E07FC0018007C003C9FF
      FFFF800FC007D99FFFFF801FC00FF9FF80038007FFFFFFFF00010003E000FFFF
      00010001C000FFFF00010001C000FFFF00010001C000C00F00010000C0008007
      00010000C000800300010000C000800100070007C000800100070007C000800F
      800F800FC000800FC3FFC3FFC001801FFFFFFFFFE07FC0FFFFFFFFFFF0FFC0FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object MainMenu: TMainMenu
    Images = Dados.Image16
    Left = 534
    Top = 10
    object miFile: TMenuItem
      Caption = 'miFile'
      object miPrint: TMenuItem
        Caption = 'miPrint'
        ImageIndex = 6
        ShortCut = 16464
      end
      object miSepFile: TMenuItem
        Caption = '-'
      end
      object miClose: TMenuItem
        Caption = 'miClose'
        ImageIndex = 41
        ShortCut = 27
        OnClick = miCloseClick
      end
    end
    object miOperations: TMenuItem
      Caption = 'miOperations'
      OnClick = miOperationsClick
      object miComponents: TMenuItem
        Caption = 'miComponents'
        SubMenuImages = ImageList1
        ImageIndex = 45
        object miAddComponent: TMenuItem
          Caption = 'miAddComponent'
          Enabled = False
          ImageIndex = 6
          ShortCut = 16449
          OnClick = cmInsertClick
        end
        object miDeleteComponent: TMenuItem
          Caption = 'miDeleteComponent'
          Enabled = False
          ImageIndex = 9
          ShortCut = 16452
          OnClick = cmDeleteClick
        end
        object miPropertiesComponent: TMenuItem
          Caption = 'miPropertiesComponent'
          Enabled = False
          ImageIndex = 5
          ShortCut = 49232
          OnClick = cmPropertiesClick
        end
      end
      object miFases: TMenuItem
        Caption = 'miFases'
        SubMenuImages = ImageList1
        ImageIndex = 38
        object miAddFase: TMenuItem
          Caption = 'miAddFase'
          Enabled = False
          ImageIndex = 8
          ShortCut = 49217
          OnClick = cmNovaFaseClick
        end
        object miDeleteFase: TMenuItem
          Caption = 'miDeleteFase'
          Enabled = False
          ImageIndex = 24
          ShortCut = 49220
          OnClick = cmDeleteOperacaoClick
        end
        object miPropertiesFase: TMenuItem
          Caption = 'miPropertiesFase'
          Enabled = False
          ImageIndex = 16
          ShortCut = 49231
          OnClick = cmPropriedadesOperacaoClick
        end
      end
      object miOperators: TMenuItem
        Caption = 'miOperators'
        SubMenuImages = ImageList1
        ImageIndex = 34
        object miAddOperation: TMenuItem
          Caption = 'miAddOperation'
          Enabled = False
          ImageIndex = 18
          ShortCut = 24641
          OnClick = cmNovaOperacaoClick
        end
        object miDeleteOperation: TMenuItem
          Caption = 'miDeleteOperation'
          Enabled = False
          ImageIndex = 19
          ShortCut = 24644
          OnClick = cmDeleteOperacaoClick
        end
        object miPropertiesOperation: TMenuItem
          Caption = 'miPropertiesOperation'
          Enabled = False
          ImageIndex = 22
          ShortCut = 24656
          OnClick = cmPropriedadesOperacaoClick
        end
      end
    end
    object miTools: TMenuItem
      Caption = 'miTools'
      object miVisibleEntrp: TMenuItem
        Caption = 'miVisibleEntrp'
        ImageIndex = 53
        ShortCut = 16453
        OnClick = miVisibleEntrpClick
      end
      object miSepTools2: TMenuItem
        Caption = '-'
      end
      object miCopyFichaTo: TMenuItem
        Caption = 'miCopyFichaTo'
        ImageIndex = 19
        ShortCut = 49219
        OnClick = miCopyFichaToClick
      end
    end
    object miHelp: TMenuItem
      Caption = 'miHelp'
      object miTopics: TMenuItem
        Caption = 'miTopics'
        ImageIndex = 25
      end
      object miContent: TMenuItem
        Caption = 'miContent'
        ImageIndex = 25
      end
      object miSepHelp: TMenuItem
        Caption = '-'
      end
      object miAbout: TMenuItem
        Caption = 'miAbout'
        ImageIndex = 17
        OnClick = miAboutClick
      end
      object miSepHelp1: TMenuItem
        Caption = '-'
      end
      object miSendMail: TMenuItem
        Caption = 'miSendMail'
        ImageIndex = 58
        ShortCut = 16461
        OnClick = miSendMailClick
      end
    end
  end
  object popOperacoes: TPopupMenu
    OnPopup = popOperacoesPopup
    Left = 538
    Top = 221
    object cmNovaFase: TMenuItem
      Caption = 'Nova &Fase'
      OnClick = cmNovaFaseClick
    end
    object cmNovaOperacao: TMenuItem
      Caption = 'Nova &Opera'#231#227'o'
      OnClick = cmNovaOperacaoClick
    end
    object cmPropriedadesOperacao: TMenuItem
      Caption = '&Propriedades'
      OnClick = cmPropriedadesOperacaoClick
    end
    object cmDeleteOperacao: TMenuItem
      Caption = 'E&xcluir'
      OnClick = cmDeleteOperacaoClick
    end
  end
  object ImageList2: TImageList
    Left = 396
    Top = 38
    Bitmap = {
      494C010119001D00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000008000000001002000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000081818100818181000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000081818100818181000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008181810081818100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000081818100818181008181
      8100000000000000000000000000000000000000000000000000000000000000
      0000818181008181810000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000081818100818181008181
      8100818181000000000000000000000000000000000000000000000000008181
      8100818181000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000888888008282
      8200818181008181810000000000000000000000000000000000818181008181
      8100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000818181008181810081818100000000008181810081818100818181000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008181810085858500858585008686860080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000083838300848484008989890000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000818181008888880086868600888888008B8B8B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008B8B8B00898989008787870000000000000000008B8B8B008C8C8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008E8E
      8E00898989008D8D8D00000000000000000000000000000000008E8E8E008E8E
      8E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008E8E8E008E8E
      8E008E8E8E000000000000000000000000000000000000000000000000008E8E
      8E008E8E8E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008E8E8E008E8E8E008E8E
      8E00000000000000000000000000000000000000000000000000000000000000
      0000000000008E8E8E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008E8E8E008E8E8E008E8E8E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008E8E8E008E8E8E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000949494009B9B9B0083838300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      0000000000000000000000000000000000000000000000000000000000009898
      980097979700838383008D8D8D009B9B9B00A0A0A0008989890086868600A2A2
      A200A0A0A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093460F0093460F0093460F009346
      0F000000000000000000000000000000000093460F0093460F0093460F009346
      0F0000000000000000000000000000000000A67A7500F1E1D600EEDBCD00ECD6
      C500EAD1BD00E7CCB500E5C8AD00E3C3A500E0BF9D00A67A7500000000000000
      0000000000000335FB0000000000000000000000000000000000000000009B9B
      9B00A4A4A400959595008F8F8F00A2A2A200B6B6B6009C9C9C00B3B3B300B7B7
      B7009E9E9E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093460F00B2CFB100BEA469009346
      0F000000000000000000000000000000000093460F00B2CFB100BEA469009346
      0F0000000000000000000000000000000000A67A7500FCF7F200FAF1E700F9EC
      DC00F7E7D200F5E2C800F4DDBE00F3D8B400F1D4A900A67A7500000000000000
      00000335FB000335FB000000000000000000000000008C8C8C0094949400AAAA
      AA00CACACA00AFAFAF00ABABAB00A8A8A800B3B3B300BCBCBC00BDBDBD00D9D9
      D900C8C8C8008A8A8A000000000000000000000000000000000093460F009346
      0F0093460F0093460F0093460F00000000000000000093460F0093460F009346
      0F0093460F0093460F00000000000000000093460F0092C16300EDB172009346
      0F000000000000000000000000000000000093460F0092C16300EDB172009346
      0F0000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      000000000000000000000330E2000000000000000000B2B2B200A7A7A700B0B0
      B000D6D6D600D3D3D300BFBFBF00ACACAC00A7A7A700BCBCBC00CBCBCB00CDCD
      CD00AEAEAE00A1A1A1009B9B9B0000000000000000000000000093460F003AFA
      FF005AE0ED0060DEDF0093460F00000000000000000093460F003AFAFF005AE0
      ED0060DEDF0093460F00000000000000000093460F0093460F0093460F009346
      0F000000000000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000335FB00000000008B8B8B009A9A9A00B3B3
      B300CBCBCB00D5D5D500BFBFBF00ACACAC00A6A6A600A5A5A5009F9F9F009E9E
      9E009F9F9F009B9B9B009696960000000000000000000000000093460F00D5C6
      9B00DC9B5200D981260093460F00000000000000000093460F00D5C69B00DC9B
      5200D981260093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      000000000000000000000000000000000000000000008C8C8C009F9F9F00ACAC
      AC00C3C3C300C4C4C400AEAEAE00AEAEAE00AEAEAE00AEAEAE00A8A8A8009D9D
      9D00A4A4A400A6A6A6008D8D8D0000000000000000000000000093460F007FB8
      5400DBA96200EF9F540093460F00000000000000000093460F007FB85400DBA9
      6200EF9F540093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500F1E1D600EEDBCD00ECD6
      C500EAD1BD00E7CCB500E5C8AD00E3C3A500E0BF9D00A67A7500000000000000
      0000000000000335FB000000000000000000000000008E8E8E009F9F9F00A5A5
      A500BBBBBB00AEAEAE00EBEBEB00C4C4C400BBBBBB00D7D7D700AEAEAE00BDBD
      BD00D8D8D800E1E1E1009B9B9B0000000000000000000000000093460F009346
      0F0093460F0093460F0093460F00000000000000000093460F0093460F009346
      0F0093460F0093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500FCF7F200FAF1E700F9EC
      DC00F7E7D200F5E2C800F4DDBE00F3D8B400F1D4A900A67A7500000000000000
      00000335FB000335FB0000000000000000000000000089898900959595009E9E
      9E00B2B2B200AEAEAE00EAEAEA00C3C3C300BBBBBB00D5D5D500AEAEAE00CACA
      CA00DCDCDC00C6C6C600A2A2A200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      000000000000000000000330E200000000000000000000000000818181009797
      9700A9A9A900AEAEAE00EAEAEA00C3C3C300BBBBBB00D5D5D500AEAEAE00C3C3
      C300BBBBBB007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093460F0093460F0093460F009346
      0F000000000000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000335FB000000000000000000000000008686
      860088888800AEAEAE00ECECEC00C3C3C300BBBBBB00D7D7D700AEAEAE009090
      90008F8F8F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000093460F00B2CFB100BEA469009346
      0F000000000000000000000000000000000093460F00B2CFB100BEA469009346
      0F0000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AEAEAE00E9E9E900C0C0C000BABABA00D4D4D400AEAEAE000000
      000000000000000000000000000000000000000000000000000093460F009346
      0F0093460F0093460F0093460F00000000000000000093460F0093460F009346
      0F0093460F0093460F00000000000000000093460F0092C16300EDB172009346
      0F000000000000000000000000000000000093460F0092C16300EDB172009346
      0F0000000000000000000000000000000000A67A7500F1E1D600EEDBCD00ECD6
      C500EAD1BD00E7CCB500E5C8AD00E3C3A500E0BF9D00A67A7500000000000000
      0000000000000335FB0000000000000000000000000000000000000000000000
      000000000000AEAEAE00C4C4C400B6B6B600AFAFAF00B9B9B900AEAEAE000000
      000000000000000000000000000000000000000000000000000093460F003AFA
      FF005AE0ED0060DEDF0093460F00000000000000000093460F003AFAFF005AE0
      ED0060DEDF0093460F00000000000000000093460F0093460F0093460F009346
      0F000000000000000000000000000000000093460F0093460F0093460F009346
      0F0000000000000000000000000000000000A67A7500FCF7F200FAF1E700F9EC
      DC00F7E7D200F5E2C800F4DDBE00F3D8B400F1D4A900A67A7500000000000000
      00000335FB000335FB0000000000000000000000000000000000000000000000
      000000000000AEAEAE00E7E7E700D3D3D300B9B9B900BFBFBF00AEAEAE000000
      000000000000000000000000000000000000000000000000000093460F00D5C6
      9B00DC9B5200D981260093460F00000000000000000093460F00D5C69B00DC9B
      5200D981260093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A67A7500A67A7500A67A7500A67A
      7500A67A7500A67A7500A67A7500A67A7500A67A7500A67A7500000000000000
      000000000000000000000330E200000000000000000000000000000000000000
      000000000000AEAEAE00EAEAEA00EEEEEE00CBCBCB00B6B6B600AEAEAE000000
      000000000000000000000000000000000000000000000000000093460F007FB8
      5400DBA96200EF9F540093460F00000000000000000093460F007FB85400DBA9
      6200EF9F540093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000335FB000000000000000000000000000000
      00000000000000000000AEAEAE00AEAEAE00AEAEAE00AEAEAE00000000000000
      000000000000000000000000000000000000000000000000000093460F009346
      0F0093460F0093460F0093460F00000000000000000093460F0093460F009346
      0F0093460F0093460F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063636300000000000000
      0000000000000000000000000000000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C0000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000636363006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063636300636363000000
      0000000000000000000000000000000000009C9C9C00EBEBEB00DEDEDE00CCCC
      CC00B8B8B800B2B2B200BABABA00BEBEBE00BFBFBF00C1C1C100C2C2C200C6C6
      C6009C9C9C0000000000000000000000000093460F00EEBF8200E98E35009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063636300989898006363630063636300636363006363
      6300636363006363630000000000000000000000000000000000000000000000
      00006363630063636300636363006363630063636300636363008F8F8F006363
      63000000000000000000000000000000000095959500F0F0F000E5E5E5006565
      6500585858007777770098989800A4A4A400AEAEAE00BBBBBB00C1C1C100C6C6
      C6009C9C9C0000000000000000000000000093460F005DD27000F7DAB7009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063636300B3B3B300ACACAC009F9F9F0091919100828282007272
      7200676767006363630000000000000000000000000000000000000000000000
      000063636300D4D4D400D4D4D400D4D4D400CBCBCB00B6B6B600A2A2A2008A8A
      8A006363630000000000000000000000000095959500F5F5F500E9E9E900A4A4
      A4006A6A6A0076767600616161007E7E7E0090909000A5A5A500B4B4B400C1C1
      C1009C9C9C0000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063636300B3B3B3006363630063636300636363006363
      6300636363006363630000000000000000000000000000000000000000000000
      0000636363006363630063636300636363006363630063636300B5B5B5006363
      6300000000000000000000000000000000009F9F9F00F9F9F900EFEFEF00E4E4
      E4007D7D7D007F7F7F00828282008181810066666600888888009D9D9D00B2B2
      B200999999000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000082828200828282008282
      820082828200636363000000000063636300636363000000000000000000FAFA
      FA00828282008282820082828200828282000000000082828200828282008282
      820082828200636363000000000000000000000000006363630063636300FCFC
      FC00828282008282820082828200828282009F9F9F00FEFEFE00F3F3F300EEEE
      EE00ACACAC0094949400C4C4C400ADADAD008B8B8B0063636300808080009393
      93008F8F8F0000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200C7C7C700B5B5B500B0B0
      B000B0B0B000636363000000000000000000636363000000000000000000FAFA
      FA009E9E9E00A4A4A400A5A5A5008282820082828200C7C7C700B5B5B500B0B0
      B000B0B0B000636363000000000000000000000000006363630000000000FCFC
      FC009E9E9E00A4A4A400A5A5A50082828200A6A6A600FFFFFF00F9F9F900F3F3
      F300E9E9E9007E7E7E00D1D1D100C0C0C000A8A8A80086868600616161007F7F
      7F008383830000000000000000000000000093460F00EEBF8200E98E35009346
      0F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200C4C4C400B4B4B400B0B0
      B000B0B0B000636363000000000000000000000000000000000000000000FAFA
      FA009D9D9D00A3A3A300A4A4A4008282820082828200C4C4C400B4B4B400B0B0
      B000B0B0B000636363000000000000000000000000000000000000000000FAFA
      FA009D9D9D00A3A3A300A4A4A40082828200A6A6A600FFFFFF00FEFEFE00F8F8
      F800F3F3F300E4E4E4008D8D8D00CFCFCF00BFBFBF00A9A9A900858585006464
      64007B7B7B0000000000000000000000000093460F005DD27000F7DAB7009346
      0F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200C6C6C600B7B7B700B3B3
      B300B2B2B200636363000000000000000000000000000000000000000000FAFA
      FA00999999009F9F9F009F9F9F008282820082828200C6C6C600B7B7B700B3B3
      B300B2B2B200636363000000000000000000000000000000000000000000FAFA
      FA00999999009F9F9F009F9F9F0082828200B1B1B100FFFFFF00FFFFFF00FEFE
      FE00F9F9F900F3F3F300DBDBDB0088888800CECECE00BEBEBE00A7A7A7008484
      84006969690000000000000000000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200C6C6C600B7B7B700B3B3
      B300B2B2B200636363000000000000000000000000000000000000000000FAFA
      FA00FAFAFA00FAFAFA00FAFAFA00FAFAFA0082828200C6C6C600B7B7B700B3B3
      B300B2B2B200636363000000000000000000000000000000000000000000FAFA
      FA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00B1B1B100FFFFFF00FFFFFF00FFFF
      FF00FEFEFE00F8F8F800F3F3F300D2D2D2008B8B8B00D2D2D200BCBCBC00AAAA
      AA00797979005C5C5C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200A2A2A2008C8C8C008C8C
      8C008C8C8C006363630063636300636363006363630063636300636363000000
      00000000000000000000000000000000000082828200A2A2A2008C8C8C008C8C
      8C008C8C8C006363630063636300636363006363630063636300636363000000
      000000000000000000000000000000000000B8B8B800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FEFEFE00F8F8F800F4F4F400CBCBCB0096969600D7D7D7009595
      95009191910090909000909090000000000093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200C9C9C900BCBCBC00B8B8
      B800B7B7B7008C8C8C00B3B3B300B3B3B300B0B0B000B0B0B000828282000000
      00000000000000000000000000000000000082828200C9C9C900BCBCBC00B8B8
      B800B7B7B7008C8C8C00B3B3B300B3B3B300B0B0B000B0B0B000828282000000
      000000000000000000000000000000000000B8B8B800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FDFDFD00FCFCFC00D6D6D6008D8D8D00929292009E9E
      9E009F9F9F0091919100747474006A6A6A0093460F00EEBF8200E98E35009346
      0F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200C7C7C700BCBCBC00B8B8
      B800B8B8B8008C8C8C00B3B3B300B3B3B300B0B0B000B1B1B100828282000000
      00000000000000000000000000000000000082828200C7C7C700BCBCBC00B8B8
      B800B8B8B8008C8C8C00B3B3B300B3B3B300B0B0B000B1B1B100828282000000
      000000000000000000000000000000000000BFBFBF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DBDBDB0099999900A3A3A3008D8D
      8D00928F920087878700848484007676760093460F005DD27000F7DAB7009346
      0F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200C8C8C800BBBBBB00B8B8
      B800B8B8B8008C8C8C00B3B3B300B4B4B400B1B1B100B1B1B100828282000000
      00000000000000000000000000000000000082828200C8C8C800BBBBBB00B8B8
      B800B8B8B8008C8C8C00B3B3B300B4B4B400B1B1B100B1B1B100828282000000
      000000000000000000000000000000000000BFBFBF00F8F8F800F7F7F700F7F7
      F700F7F7F700F6F6F600F6F6F600F6F6F600D7D7D70099999900AAAAAA000000
      000088888800BABABA009C9C9C007575750093460F0093460F0093460F009346
      0F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000082828200D3D3D300D1D1D100CCCC
      CC00CECECE00A2A2A200CBCBCB00CBCBCB00C8C8C800CACACA00828282000000
      00000000000000000000000000000000000082828200D3D3D300D1D1D100CCCC
      CC00CECECE00A2A2A200CBCBCB00CBCBCB00C8C8C800CACACA00828282000000
      000000000000000000000000000000000000BFBFBF00B1B1B100B1B1B100B1B1
      B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1B10099999900000000000000
      000000000000AAAAAA008C8C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000082828200828282008282
      8200828282008282820082828200828282008282820082828200000000000000
      0000000000000000000000000000000000000000000082828200828282008282
      8200828282008282820082828200828282008282820082828200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE0000000000000000000000000000000000000000000000
      00000000000000000000000000002B90EF00278DE70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000000000000000078DBE0063CBF800078DBE00A3E1
      FB0066CDF90065CDF80065CDF90065CDF90065CDF80065CDF90065CDF80066CD
      F8003AADD800ACE7F500078DBE00000000000000000000000000000000000000
      000000000000000000002A8FEC00278CED002489E4002388DD001E84D5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C000000000000000000000000000078DBE006AD1F900078DBE00A8E5
      FC006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4FA006FD4FA006ED4
      F9003EB1D900B1EAF500078DBE00000000000000000000000000000000000000
      000000000000298FD6003DA2EB003EA3F000379CEA002186DA001A81D100187E
      CA00157CC4001177BB0000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF008000000080000000FFFFFF0080000000800000008000000080000000FFFF
      FF00C0C0C000000000000000000000000000078DBE0072D6FA00078DBE00AEEA
      FC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADCFB0079DCFA0079DC
      FA0044B5D900B6EEF600078DBE00000000000000000000000000000000000000
      0000000000003CA2E10058BDF20060C4F9003D9EE50057BCF7003398DF001E83
      CD001076BC000B73B4000B72AF00086FAA000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C000000000000000000000000000078DBE0079DDFB00078DBE00B5EE
      FD0083E4FB0084E4FB0083E4FC0083E4FC0084E4FC0083E4FC0083E4FB0084E5
      FC0048B9DA00BBF2F600078DBE00000000000000000000000000000000000000
      0000046B16004AB0F90053B7F7002F87D10063C7FB003D9EE5005BBFFB0055BA
      FA003499DE002D93D8000F76B300066DA7000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF008000000080000000FFFFFF0080000000800000008000000080000000FFFF
      FF00C0C0C000000000000000000000000000078DBE0082E3FC00078DBE00BAF3
      FD008DEBFC009933000099330000993300009933000099330000993300009933
      000099330000BEF4F700078DBE0000000000000000000000000000000000187D
      5F002B7A8300046B16002884DE003C99D900227BCE0040A0EA005ABEFE004FB2
      F50056B9FF0056B9FF0046AAF300000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C000000000000000000000000000078DBE008AEAFC00078DBE00FFFF
      FF00C9F7FE0099330000FEFEFE00FEFEFE00FEFEFE008EA4FD00B8C6FD00FEFE
      FE0099330000DEF9FB00078DBE000000000000000000000000000F7D15003CBE
      610031C6480031C6480031C64800046B1600046B16002D87B6003998E80044A5
      F00052B6FF0052B5FF0000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00C0C0C000000000000000000000000000078DBE0093F0FE00078DBE00078D
      BE00078DBE0099330000FEFEFE00FAFBFE007E98FC000335FB00597AFC00FEFE
      FE0099330000078DBE00078DBE0000000000000000001587220031AF4A0062F9
      920050EB6F0031C648001DA746002398760031C6480031C64800046B1600046B
      1600000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF0000000000BFBFBF00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF000000000000000000FFFFFF00FFFFFF00FFFFFF000000000000FFFF000000
      0000C0C0C000000000000000000000000000078DBE009BF5FE009AF6FE009AF6
      FE009BF5FD0099330000D6DEFE004368FC000335FB004066FC000436FB00D9E0
      FE00993300000000000000000000000000000000000030AD48002BA641004FE7
      780037D053001AB42700029D0100009B000010A41E0032B9720046A7AC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BFBFBF00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF0000000000FFFFFF0000000000FFFFFF000000000000FFFF0000000000FFFF
      FF0000000000000000000000000000000000078DBE00FEFEFE00A0FBFF00A0FB
      FE00A0FBFE00993300005274FC001442FB00BCC9FD00EFF2FE001A47FB004F72
      FC009733040000000000000000000000000000000000000000000A7510002AAE
      3F0022BC3200049A0600009400000CA118000278040002780400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F00000000007F7F7F00000000007F7F7F00000000007F7F7F000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF000000000000FFFF000000000000FFFF0000000000FFFFFF000000
      0000FFFFFF0000FFFF00FFFFFF000000000000000000078DBE00FEFEFE00A5FE
      FF00A5FEFF0099330000E4EAFE00D9E0FE00FEFEFE00FEFEFE0098ACFD000335
      FB00643459000000000000000000000000000000000000000000259E390042DC
      64000B9F110000770000027804000B8717000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800000000000FFFFFF0000000000FFFFFF0000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000078DBE00078D
      BE00078DBE0099330000FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE005677
      FC000335FB00000000000000000000000000000000001D912C0044DE68000FA3
      1500006F00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00BFBFBF00BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000000000000000000000
      0000000000009933000099330000993300009933000099330000993300008F33
      11002235C8000335FB00000000000000000013831D0043D9640012AB1C000073
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000335FB000335FB000335FB001C9A2A001AB12700007900000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F7F007F7F7F007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000335FB0018A02400027F0400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009A9A9A00A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000008080
      8000FFFFFF00C0C0C000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C0008080
      8000C0C0C0008080800000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00F7F7F700E9E9E900E3E3E300DBDBDB00D5D5
      D500D0D0D000D0D0D000D7D7D700A1A1A1000000000000000000000000000000
      0000A0A0A000A4A4A400A0A0A000989898009696960099999900000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007F7F7F007F7F7F007F7F7F0000FFFF0000FFFF007F7F7F007F7F7F007F7F
      7F007F7F7F0000FFFF0000FFFF00000000000000000000000000000000008080
      8000FFFFFF0000000000C0C0C000FFFFFF0000000000C0C0C000C0C0C0000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      000000000000000000009E9E9E00FAFAFA00E9E9E900E4E4E400DDDDDD006C6C
      6C00D1D1D100CCCCCC00D2D2D200A1A1A100000000000000000000000000BDBD
      BD00C2C2C200B6B6B600A7A7A700A2A2A200A3A3A300AEAEAE00B8B8B800B5B5
      B5009B9B9B00000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000FFFFFF00C0C0C00000000000C0C0C000C0C0C0000000
      0000C0C0C0008080800000000000000000000000000000000000000000000000
      00000000000000000000A0A0A000FFFFFF00EFEFEF00E9E9E9006C6C6C00BDBD
      BD006C6C6C00D0D0D000D1D1D100A1A1A100000000000000000000000000C6C6
      C600C4C4C400B4B4B400A4A4A40092929200898989007474740084848400BEBE
      BE00BDBDBD009696960000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000C0C0C000FFFFFF0000000000C0C0C000C0C0C0000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      00000000000000000000A3A3A300FFFFFF00F5F5F5006C6C6C00BCBCBC00D3D3
      D300B1B1B1006C6C6C00D6D6D600A1A1A100000000000000000091919100A4A4
      A400C0C0C000BABABA00B0B0B00075757500525252005C5C5C00595959007F7F
      7F00C5C5C5009999990000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000FFFFFF00C0C0C00000000000C0C0C000C0C0C0000000
      0000C0C0C0008080800000000000000000000000000000000000000000000000
      00000000000000000000A7A7A700FFFFFF006C6C6C00858585009D9D9D00B6B6
      B6009C9C9C008E8E8E006C6C6C00A1A1A1000000000000000000959595009292
      920097979700A8A8A800B7B7B700767676004C4C4C0092929200D0D0D0007E7E
      7E00757575009E9E9E0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000C0C0C000FFFFFF0000000000C0C0C000C0C0C0000000
      000080808000C0C0C00000000000000000000000000000000000000000000000
      00000000000000000000AAAAAA00FFFFFF00FFFFFF00FCFCFC006B6B6B00A1A1
      A1006C6C6C00E3E3E300E5E5E500A1A1A10000000000000000009C9C9C009E9E
      9E009B9B9B0097979700A2A2A2008D8D8D008383830091919100D8D8D800D3D3
      D300878787009696960000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007F7F7F0000000000000000000000000000000000000000008080
      8000FFFFFF0000000000FFFFFF00C0C0C00000000000C0C0C000C0C0C0000000
      0000C0C0C0008080800000000000000000000000000000000000000000000000
      00000000000000000000AEAEAE00FFFFFF00FFFFFF00FFFFFF00747474009191
      91006C6C6C00F0F0F000E4E4E400A1A1A1000000000000000000A9A9A900ADAD
      AD00AAAAAA00A9A9A900A4A4A400A4A4A400D8D8D800C1C1C100909090008D8D
      8D009D9D9D009D9D9D00000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF00000000000000000000000000000000008080
      8000FFFFFF000000000000000000FFFFFF000000000000000000C0C0C0000000
      000000000000C0C0C000000000000000000000000000909090009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C00FFFFFF007B7B7B00808080008A8A
      8A006C6C6C00CACACA00B7B7B700A7A7A70000000000A9A9A900B7B7B700B6B6
      B600B5B5B500B5B5B500BBBBBB008A8A8A00A2A2A200C6C6C6007A7A7A004D4D
      4D0092929200ABABAB0095959500000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF000000000000000000000000008080
      8000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0
      C000C0C0C0008080800000000000000000000000000092929200E8E8E800DEDE
      DE00D9D9D900D6D6D600CACACA006C6C6C006C6C6C007C7C7C00868686007575
      7500E0E0E0009F9F9F00A8A8A8009E9E9E0000000000A9A9A900C1C1C100BDBD
      BD00BCBCBC00BCBCBC00BDBDBD00B2B2B2005F5F5F006D6D6D00575757005151
      510094949400B6B6B60095959500000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000097979700EAEAEA00A3A3
      A300A3A3A300A3A3A300CBCBCB009C9C9C00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E3E3E3009E9E9E00B8B8B8000000000000000000B5B5B500C8C8C800C4C4
      C400C3C3C300C3C3C300C1C1C100C6C6C600ACACAC007A7A7A007A7A7A00A5A5
      A500ABABAB00BDBDBD009D9D9D00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C9C9C00F0F0F000E7E7
      E700E2E2E200DFDFDF00D1D1D1009C9C9C00B8B8B800B8B8B800B8B8B800B8B8
      B800B8B8B8009E9E9E00000000000000000000000000C0C0C000C9C9C900C7C7
      C700C7C7C700C7C7C700C7C7C700C7C7C700CCCCCC00D0D0D000CFCFCF00CCCC
      CC00C8C8C800C4C4C400A2A2A200000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF0000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000808080000000000000000000A1A1A100F5F5F500A3A3
      A300A3A3A300EAEAEA00D6D6D6009C9C9C000000000000000000000000000000
      00000000000000000000000000000000000000000000C3C3C300CBCBCB00C9C9
      C900C9C9C900CACACA00C8C8C800C4C4C400B1B1B1009F9F9F00A0A0A000B0B0
      B000C1C1C100CBCBCB00A7A7A700000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      80008080800080808000808080000000000000000000A7A7A700F5F5F500F3F3
      F300F0F0F0009C9C9C009C9C9C009C9C9C000000000000000000000000000000
      00000000000000000000000000000000000000000000AAAAAA00B6B6B600B5B5
      B500B2B2B200ACACAC00A0A0A000929292008686860084848400898989009797
      9700A5A5A500B1B1B100A6A6A60000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      000000000000000000008080800000000000C0C0C000C0C0C000808080000000
      00000000000000000000000000000000000000000000ABABAB00F5F5F500F5F5
      F500F5F5F5009C9C9C00AEAEAE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008989890093939300A3A3
      A300A6A6A600A4A4A400A4A4A400000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      00000000000000000000000000000000000000000000AEAEAE00AEAEAE00AEAE
      AE00AEAEAE009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A6A6
      A600A6A6A600A6A6A600000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00000000000000000000000000000000000000
      00000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000000000000000000000000000CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100000000009C9C9C008C8C8C008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C007F7F7F00000000000000000000000000000000009C9C9C00E9E9
      E900DEDEDE00D9D9D900D4D4D400CFCFCF00CACACA00C5C5C500C3C3C300C4C4
      C400C4C4C400C7C7C7009C9C9C00000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFAF500FFF3E600FEEBD500FEE3C300FEDCB500FED7AB00FED7AB00FED7
      AB00FED7AB00FED7AB00FED7AB00CC670100000000009C9C9C00EBEBEB00E0E0
      E000DBDBDB00D7D7D700D2D2D200CDCDCD00C9C9C900C3C3C300C2C2C200C2C2
      C200C6C6C6007F7F7F00000000000000000000000000000000009C9C9C00EBEB
      EB00E0E0E000DBDBDB00D7D7D700D2D2D200CDCDCD00C9C9C900C3C3C300C2C2
      C200C2C2C200C6C6C6009C9C9C00000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFAF500FFF3E600FEEBD500FEE3C400FEDCB500FED7AB00FED7
      AB00FED7AB00FED7AB00FED7AB00CC6701000000000095959500F0F0F0008484
      840084848400848484008484840084848400848484008484840084848400C2C2
      C200C6C6C6007F7F7F000000000000000000000000000000000095959500F0F0
      F000E5E5E500E0E0E000DCDCDC00D7D7D700D2D2D200CECECE00C9C9C900C4C4
      C400C2C2C200C6C6C6009C9C9C00000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF004571
      FA004571FA004571FA00FFFBF500A23F0800A23F0800A23F0800FEDBB500059A
      CD00059ACD00059ACD00FED7AB00CC6701000000000095959500F5F5F5008484
      8400FEFEFE00FEFEFE00FEFEFE00C5C5C500DADADA00FEFEFE0084848400C4C4
      C400C5C5C5007F7F7F000000000000000000000000000000000095959500F5F5
      F500E9E9E900E4E4E400E0E0E000DBDBDB00D6D6D600D2D2D200CDCDCD00C8C8
      C800C4C4C400C5C5C5009C9C9C00000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF004571
      FA004571FA004571FA00FFFFFF00A23F0800A23F0800A23F0800FEE3C400059A
      CD00059ACD00059ACD00FED7AB00CC670100000000009F9F9F00F9F9F9008484
      8400FEFEFE00FCFCFC00BDBDBD007F7F7F00AAAAAA00FEFEFE0084848400C8C8
      C800C7C7C7007F7F7F00000000000000000000000000000000009F9F9F00F9F9
      F900EFEFEF00E9E9E900E5E5E500E0E0E000DBDBDB00D7D7D700D1D1D100CDCD
      CD00C8C8C800C7C7C7009C9C9C00000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF004571
      FA004571FA004571FA00FFFFFF00A23F0800A23F0800A23F0800FFEBD500059A
      CD00059ACD00059ACD00FED7AB00CC670100000000009F9F9F00FEFEFE008484
      8400EAEAEA009F9F9F007F7F7F009E9E9E007F7F7F00EBEBEB0084848400CCCC
      CC00CCCCCC007F7F7F00000000000000000000000000000000009F9F9F00FEFE
      FE00F3F3F300EEEEEE00E9E9E900E4E4E400DFDFDF00DBDBDB00D7D7D700D1D1
      D100CCCCCC00CCCCCC009C9C9C00000000000000000000000000000000000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFAF500FEF3E700FEEB
      D500FFE3C300FEDCB500FED7AB00CC67010000000000A6A6A600FFFFFF008484
      8400A7A7A70087878700DCDCDC00F6F6F6008A8A8A00A5A5A50084848400D2D2
      D200D1D1D1007F7F7F0000000000000000000000000000000000A6A6A600FFFF
      FF00F9F9F900F3F3F300EEEEEE00E9E9E900E5E5E500DFDFDF00DBDBDB00D7D7
      D700D2D2D200D1D1D1009C9C9C00000000000000000000000000FFFFFF000000
      00000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000CC670100FFFFFF00CC9A
      9900CC9A9900CC9A9900FFFFFF00E27E0300E27E0300E27E0300FFFAF400029A
      0300029A0300029A0300FEDCB500CC67010000000000A6A6A600FFFFFF008484
      8400F1F1F100EBEBEB00FEFEFE00FEFEFE00CACACA007F7F7F0084848400D6D6
      D600D6D6D6007F7F7F0000000000000000000000000000000000A6A6A600FFFF
      FF00FEFEFE00F8F8F800F3F3F300EEEEEE00E9E9E900E4E4E400E0E0E000DBDB
      DB00D6D6D600D6D6D6009C9C9C0000000000000000000000000080808000FFFF
      FF008080800080808000FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00CC9A
      9900CC9A9900CC9A9900FFFFFF00E27E0300E27E0300E27E0300FFFFFF00029A
      0300029A0300029A0300FEE3C400CC67010000000000B1B1B100FFFFFF008484
      8400FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00A9A9A9007F7F7F00DCDC
      DC00D3D3D3007F7F7F0000000000000000000000000000000000B1B1B100FFFF
      FF00FFFFFF00FEFEFE00F9F9F900F3F3F300EEEEEE00E9E9E900E4E4E400DFDF
      DF00DCDCDC00D3D3D3009C9C9C00000000000000000000000000000000008080
      800000FFFF0080808000FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00C0C0
      C000FFFFFF0080808000000000000000000000000000CC670100FFFFFF00CC9A
      9900CC9A9900CC9A9900FFFFFF00E27E0300E27E0300E27E0300FFFFFF00029A
      0300029A0300029A0300FFEBD500CC67010000000000B1B1B100FFFFFF008484
      8400848484008484840084848400848484008484840084848400757575007F7F
      7F00B7B7B7007F7F7F0000000000000000000000000000000000B1B1B100FFFF
      FF00FFFFFF00FFFFFF00FEFEFE00F8F8F800F3F3F300EEEEEE00EBEBEB00EAEA
      EA00D5D5D500B7B7B7009C9C9C00000000000000000000000000FFFFFF00FFFF
      FF0080808000FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C0008080800000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFAF500FFF3E600CC67010000000000B8B8B800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE00F8F8F800F4F4F400E3E3E300959595007F7F
      7F007F7F7F007F7F7F0000000000000000000000000000000000B8B8B800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00F8F8F800F4F4F400E3E3E3009999
      990099999900999999009C9C9C00000000000000000000000000000000008080
      80008080800000FFFF00FFFFFF00FFFFFF008080800080808000808080008080
      80000000000000000000000000000000000000000000CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC670100CC67010000000000B8B8B800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00FCFCFC00D6D6D60095959500ACAC
      AC009B9B9B007F7F7F0000000000000000000000000000000000B8B8B800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00FCFCFC00D6D6D6009999
      9900ACACAC009B9B9B0096969600000000000000000000000000000000008080
      800000FFFF008080800000FFFF0080808000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC6701000000000000000000BFBFBF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DBDBDB0095959500B8B8
      B800A2A2A2000000000000000000000000000000000000000000BFBFBF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DBDBDB009999
      9900B8B8B800A2A2A2000000000000000000000000000000000080808000FFFF
      FF000000000080808000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF00F8F8F800F7F7
      F700F7F7F700F7F7F700F6F6F600F6F6F600F6F6F600D7D7D70095959500AAAA
      AA00000000000000000000000000000000000000000000000000BFBFBF00F8F8
      F800F7F7F700F7F7F700F7F7F700F6F6F600F6F6F600F6F6F600D7D7D7009999
      9900AAAAAA000000000000000000000000000000000000000000FFFFFF000000
      00000000000080808000FFFFFF00000000000000000080808000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF00AEAEAE00AEAE
      AE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00959595000000
      0000000000000000000000000000000000000000000000000000BFBFBF00B1B1
      B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1B1009999
      9900000000000000000000000000000000000000000000000000000000000000
      00000000000080808000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE00000000000000000000000000078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE0063CBF800078DBE00A3E1
      FB0066CDF90065CDF80065CDF90065CDF90065CDF80065CDF90065CDF80066CD
      F8003AADD800ACE7F500078DBE0000000000078DBE0025A1D10071C6E80084D7
      FA0066CDF90065CDF90065CDF90065CDF90065CDF80065CDF90065CDF80066CE
      F9003AADD8001999C90000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE006AD1F900078DBE00A8E5
      FC006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4FA006FD4FA006ED4
      F9003EB1D900B1EAF500078DBE0000000000078DBE004CBCE70039A8D100A0E2
      FB006FD4FA006FD4F9006ED4FA006FD4F9006FD4FA006FD4FA006FD4FA006ED4
      F9003EB1D900C9F0F300078DBE00000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE0072D6FA00078DBE00AEEA
      FC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADCFB0079DCFA0079DC
      FA0044B5D900B6EEF600078DBE0000000000078DBE0072D6FA00078DBE00AEE9
      FC0079DCFB0079DCFB0079DCFB0079DCFB0079DCFB007ADCFB0079DCFA0079DC
      FA0044B5D900C9F0F300078DBE0000000000000000000000000080808000FFFF
      FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
      FF00C0C0C00000FFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE0079DDFB00078DBE00B5EE
      FD0083E4FB0084E4FB0083E4FC0083E4FC0084E4FC0083E4FC0083E4FB0084E5
      FC0048B9DA00BBF2F600078DBE0000000000078DBE0079DDFB001899C7009ADF
      F30092E7FC0084E4FB0083E4FC0083E4FC0084E4FC0083E4FC0083E4FB0084E5
      FC0048B9DA00C9F0F3001496C40000000000000000000000000080808000FFFF
      FF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF00C0C0C00080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE0082E3FC00078DBE00BAF3
      FD008DEBFC008DEBFC008DEBFC008DEBFD008DEBFD008DEBFC008DEBFD008DEB
      FC004CBBDA00BEF4F700078DBE0000000000078DBE0082E3FC0043B7DC0065C2
      E000ABF0FC008DEBFC008DEBFC008DEBFD008DEBFD008DEBFC008DEBFD008DEB
      FC004CBBDA00C9F0F300C9F0F300078DBE00000000000000000080808000FFFF
      FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
      FF00C0C0C00000FFFF00808080000000000000000000000000000000000000FF
      FF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FF
      FF0000000000000000000000000000000000078DBE008AEAFC00078DBE00FFFF
      FF00C9F7FE00C8F7FE00C9F7FE00C9F7FE00C9F7FE00C8F7FE00C9F7FE00C8F7
      FE009BD5E700DEF9FB00078DBE0000000000078DBE008AEAFC0077DCF300219C
      C700FEFFFF00C8F7FD00C9F7FD00C9F7FD00C9F7FE00C8F7FE00C9F7FD00C8F7
      FE009BD5E600EAFEFE00D2F3F800078DBE00000000000000000080808000FFFF
      FF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF00C0C0C00080808000000000000000000000000000FFFFFF000000
      000000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBF
      BF0000FFFF00000000000000000000000000078DBE0093F0FE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE0000000000078DBE0093F0FE0093F0FD001697
      C500078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBE00078DBE00000000000000000080808000FFFF
      FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
      FF00C0C0C00000FFFF008080800000000000000000000000000000FFFF00FFFF
      FF000000000000FFFF00BFBFBF0000FFFF00BFBFBF0000FFFF00BFBFBF0000FF
      FF00BFBFBF0000FFFF000000000000000000078DBE009BF5FE009AF6FE009AF6
      FE009BF5FD009BF6FE009AF6FE009BF5FE009AF6FD009BF5FE009AF6FE009AF6
      FE000989BA00000000000000000000000000078DBE009BF5FE009AF6FE009AF6
      FE009BF5FD009BF6FE009AF6FE009BF5FE009AF6FD009BF5FE009AF6FE009AF6
      FE000989BA00000000000000000000000000000000000000000080808000FFFF
      FF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
      C00000FFFF00C0C0C00080808000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000078DBE00FEFEFE00A0FBFF00A0FB
      FE00A0FBFE00A1FAFE00A1FBFE00A0FAFE00A1FBFE00A1FBFF00A0FBFF00A1FB
      FF000989BA00000000000000000000000000078DBE00FEFEFE00A0FBFF00A0FB
      FE00A0FBFE00A1FAFE00A1FBFE00A0FAFE00A1FBFE00A1FBFF00A0FBFF00A1FB
      FF000989BA00000000000000000000000000000000000000000080808000FFFF
      FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
      FF00C0C0C00000FFFF008080800000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000078DBE00FEFEFE00A5FE
      FF00A5FEFF00A5FEFF00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE000000000000000000000000000000000000000000078DBE00FEFEFE00A5FE
      FF00A5FEFF00A5FEFF00078DBE00078DBE00078DBE00078DBE00078DBE00078D
      BE0000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000078DBE00078D
      BE00078DBE00078DBE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000078DBE00078D
      BE00078DBE00078DBE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF0080808000808080008080
      800080808000808080008080800000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000C0C0C00000FFFF00C0C0C00000FFFF008080800000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00FFFFFF0000FFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      00000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000800000000100010000000000000400000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFC0000000000009FF9000000000000
      8FF300000000000087E7000000000000C3CF000000000000F11F000000000000
      F83F000000000000FC7F000000000000F83F000000000000F19F000000000000
      E3CF000000000000C7E70000000000008FFB0000000000001FFF000000000000
      3FFF000000000000FFFF000000000000FFFFFFFFFE3FFFFFFFFF0021E007C183
      0F0F0029E007FFFF090900218003C1830F0F00218001C1830F0FFFFE8001C183
      FFFF00218001C183FFFF00298001C183FFFF00218001FFFFFFFF0021C003C183
      0F0FFFFEE007FFFF09090021F81FC1830F0F0029F81FC1830F0F0021F81FC183
      FFFF0021F81FC183FFFFFFFEFC3FC183FFFFFFFFFF7FFFBF00070FFFFE7FFF9F
      00070801FC03F00F00070FFFF803F00700070FFFFC03F00F0007FFFF82608380
      00070FFF036003A00007080103E003E000070FFF03E003E000070FFF03E003E0
      0003FFFF001F001F00010FFF001F001F00000801001F001F00000FFF001F001F
      00100FFF001F001F0039FFFF803F803FE00FC0038003FE7FE00FC0030001FC1F
      E00FC0030001F803E00FC0030001F800E00FC0030001F000E00FC0030001E001
      E00FC0030001C003A00BC0030001800FC007C0030007801FE00FC0010007C03F
      E00FC0008007C0FFC007C000C00787FFC007FE00F8030FFFC007FF00FFF81FFF
      F83FFF81FFFE3FFFF83FFFFFFFFFFFFFFC00FFFFFF7EE001FC00F03F9001E001
      FC00E007C003E001FC00E003E003E001FC00C003E003E001FC00C003E003E001
      FC00C003E003E001FC00C0030001E001800080018000E00180008001E007E001
      80018001E00FC00080038001E00FC00080FF8001E027E00180FF8001C073FC0F
      81FFFF819E79FE1F83FFFFE37EFEFFFFFFFFFFFFC001F80180008003C001F801
      80008003C001F80180008003C001F80180008003C001F80180008003C001F801
      80008003C001F80180008003C001D80180008003C001C00180008003C001E003
      80008003C001C00780008003C001E00F80008003C001E07FC0018007C003C9FF
      FFFF800FC007D99FFFFF801FC00FF9FF80038007FFFFFFFF00010003E000FFFF
      00010001C000FFFF00010001C000FFFF00010001C000C00F00010000C0008007
      00010000C000800300010000C000800100070007C000800100070007C000800F
      800F800FC000800FC3FFC3FFC001801FFFFFFFFFE07FC0FFFFFFFFFFF0FFC0FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
