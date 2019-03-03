inherited frmPrdService: TfrmPrdService
  Left = 300
  Top = 172
  Caption = 'frmPrdService'
  ClientHeight = 285
  ClientWidth = 591
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgServices: TPageControl
    Left = 0
    Top = 0
    Width = 591
    Height = 285
    ActivePage = tsComps
    Align = alClient
    TabOrder = 0
    object tsComps: TTabSheet
      Caption = 'Composi'#231#245'es de Servi'#231'os'
      object pgData: TPageControl
        Left = 0
        Top = 33
        Width = 583
        Height = 224
        ActivePage = tsService
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        object tsService: TTabSheet
          Caption = 'tsService'
          ImageIndex = 1
          TabVisible = False
          DesignSize = (
            575
            214)
          object vtCompositions: TVirtualStringTree
            Left = 0
            Top = 32
            Width = 577
            Height = 177
            Anchors = [akLeft, akTop, akRight, akBottom]
            CheckImageKind = ckXP
            Ctl3D = True
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clBlue
            Header.Font.Height = -13
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = [fsBold]
            Header.Options = [hoAutoResize, hoDrag, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            ParentCtl3D = False
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnChecked = vtCompositionsChecked
            OnDblClick = vtCompositionsDblClick
            OnGetText = vtCompositionsGetText
            OnInitNode = vtCompositionsInitNode
            Columns = <
              item
                ImageIndex = 83
                Position = 0
                Width = 573
                WideText = 'Selecione a Composi'#231#227'o'
              end>
          end
          object cbTools: TCoolBar
            Left = 0
            Top = 0
            Width = 577
            Height = 30
            Align = alNone
            Anchors = [akLeft, akTop, akRight, akBottom]
            BandBorderStyle = bsNone
            Bands = <
              item
                Control = tbTools
                ImageIndex = 18
                Text = 'Composi'#231#245'es'
                Width = 573
              end>
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            object tbTools: TToolBar
              Left = 90
              Top = 0
              Width = 479
              Height = 25
              Caption = 'tbTools'
              EdgeBorders = []
              EdgeInner = esNone
              Flat = True
              TabOrder = 0
              Transparent = True
              object tbNew: TToolButton
                Left = 0
                Top = 0
                Caption = 'tbNew'
                ImageIndex = 43
              end
              object tbSepComp: TToolButton
                Left = 23
                Top = 0
                Width = 8
                Caption = 'tbSepComp'
                ImageIndex = 45
                Style = tbsSeparator
              end
              object tbDelete: TToolButton
                Left = 31
                Top = 0
                Caption = 'tbDelete'
                ImageIndex = 33
              end
            end
          end
        end
        object tsCompositions: TTabSheet
          Caption = 'tsCompositions'
          ImageIndex = 1
          TabVisible = False
          DesignSize = (
            575
            214)
          object pgParts: TPageControl
            Left = 0
            Top = 24
            Width = 569
            Height = 185
            ActivePage = tsListParts
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 2
            OnChanging = pgPartsChanging
            object tsListParts: TTabSheet
              Caption = 'Lista de Insumos'
              DesignSize = (
                561
                157)
              object vtInsumos: TVirtualStringTree
                Left = 0
                Top = 4
                Width = 553
                Height = 149
                Anchors = [akLeft, akTop, akRight, akBottom]
                CheckImageKind = ckXP
                Ctl3D = True
                Header.AutoSizeIndex = 0
                Header.Font.Charset = DEFAULT_CHARSET
                Header.Font.Color = clBlue
                Header.Font.Height = -13
                Header.Font.Name = 'MS Sans Serif'
                Header.Font.Style = [fsBold]
                Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoVisible]
                Header.Style = hsXPStyle
                HintAnimation = hatNone
                ParentCtl3D = False
                TabOrder = 0
                TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
                TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
                TreeOptions.SelectionOptions = [toFullRowSelect]
                Columns = <
                  item
                    ImageIndex = 83
                    MaxWidth = 300
                    MinWidth = 190
                    Position = 0
                    Width = 300
                    WideText = 'Insumo'
                  end
                  item
                    Alignment = taRightJustify
                    MaxWidth = 100
                    MinWidth = 85
                    Position = 1
                    Width = 85
                    WideText = 'Quant.'
                  end
                  item
                    Alignment = taRightJustify
                    MaxWidth = 100
                    MinWidth = 85
                    Position = 2
                    Width = 85
                    WideText = 'Seq.'
                  end>
              end
            end
            object tsDetailPart: TTabSheet
              Caption = 'Detalhes do Insumo'
              ImageIndex = 1
              DesignSize = (
                561
                157)
              object sbSavePart: TSpeedButton
                Left = 440
                Top = 128
                Width = 113
                Height = 22
                Anchors = [akLeft]
                Caption = 'Salvar'
                Flat = True
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                  98403F953A3A8B3435957D7DB0B8B7BDBCBBC0BCBBBBB8B7B6BBBAA487878028
                  29812C2C903737FF00FFFF00FFAA5D56C14B4BC54D4DA64041836666AC8A89D9
                  C2C0FEF7F2FFFCF8EEF3F0C59F9F7E1918811D1DB141419C3E3FFF00FFA95D56
                  BC4A4AC04C4CA54242876062862B2BA45B5AE0D5D3FCFAF7FEFFFCCEA7A67E1A
                  1A811E1EAF40409A3E3FFF00FFA95D56BC4A4AC04B4CA54242926A6981232383
                  2020BFAAA9EEEBE9FFFFFFD9B2B07E1919801E1EAF40409A3E3FFF00FFA95D56
                  BC4A4AC04B4BA441419E7675882F2F7B1D1D908282C9D0CCF8FFFEDEBAB87A18
                  187E1C1CAD3F3F9A3E3FFF00FFA95D56BC4A4AC14B4BA94141B27776B17E7D9F
                  6C6C957475A78B8AD8BBB8D193938C23238E2727B24242993D3EFF00FFA95D56
                  BD4A4BBC4949BC4949BC4849BD4C4CBF4C4CBD4949B84141BA4343BB4646BD4A
                  4ABF4B4BC14D4D973C3DFF00FFAA5E57A439379E413DB66C6AC58E8BC99695C9
                  9593C99695C98F8EC99291C99593CA9997C68484BF4B4B973B3CFF00FFAA5D56
                  9D3533DCBFBCF8F4F4F6F0EFF7F2F0F7F2F0F7F2F0F7F3F2F7F2F0F7F2F0FAFA
                  F8D4ACABB44142983C3DFF00FFAA5D569F3735E5CBCAFBFAF8F4EBEAF4EDEBF4
                  EDEBF4EDEBF4EDEBF4EDEBF3EDEBFAF7F6D4AAA9B24141983C3DFF00FFAA5D56
                  9F3735E5CBC7EBEAEACCC9C7CFCBCBCFCBCBCFCBCBCFCBCBCFCBCBCCC9C9E6E6
                  E5D7ABAAB14141983C3DFF00FFAA5D569F3735E5CBC9EFEDEDD4CFCED5D0D0D5
                  D0D0D5D0D0D5D0D0D5D0D0D3CFCEE9E9E9D7ABAAB24141983C3DFF00FFAA5D56
                  9F3735E3CBC9F2F0EFDCD5D4DDD8D7DDD8D7DDD8D7DDD8D7DDD8D7DCD5D5EEED
                  EBD5ABA9B24141983C3DFF00FFAA5D569F3735E5CBCAEDEBEACEC9C9CFCCCBCF
                  CCCBCFCCCBCFCCCBCFCCCBCCC9C9E7E6E5D8ACABB24141983C3DFF00FFAA5D55
                  9F3735E2CAC7FEFAFAF8EFEEF8EFEEF8EFEEF8EFEEF8EFEEF8EFEEF8EFEEFCF8
                  F7D4AAA9B24141983C3DFF00FFFF00FF923633BAA3A1C6C9C7C4C0C0C4C0C0C4
                  C0C0C4C0C0C4C0C0C4C0C0C4C0C0C6C7C7BC99988C3435FF00FF}
              end
              object sbDelete: TSpeedButton
                Left = 152
                Top = 128
                Width = 113
                Height = 22
                Anchors = [akRight]
                Caption = 'Excluir'
                Flat = True
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                  FF00FFFF00FFFF00FF00004300004300003C000037000036000036FF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000930000930002841518892B
                  2D8C2A2A830F0F6200004000003A00003AFF00FFFF00FFFF00FFFF00FFFF00FF
                  0004B30104A73D45C3B3B7EAFFFFFFFFFFFFFFFFFFFFFFFFA0A2CC2D2D740000
                  3A00004EFF00FFFF00FFFF00FF0005CC0107BA7F89E2FFFFFFFFFFFF9B9CDB5E
                  5EB75F5FB6ADADDDFFFFFFFFFFFF5E5E9B00003A000043FF00FFFF00FF0005CC
                  6472E5FFFFFFD7DAF52427B300008304079C06068B00006A31319CE6E6F7FFFF
                  FF36367D000043FF00FF0007E80B1BD8F8F8FFF2F3FC1621C400009F04079C04
                  058F010276010174000061262695FFFFFFC3C3DB01015000004B0007E84358F0
                  FFFFFF6476ED0002C40001B60407AE07078702027500017E00006E0000668484
                  C9FFFFFF27278800004B0009F37F94FAFFFFFF1932F00512E0F3F5FDF3F5FDF3
                  F5FDEBEDF8EBEDF8EBEDF80202782D2E9EFFFFFF5558BE00004A0218FDA6B4FD
                  FFFFFF112CFD0B20F5A6B4FCFFFFFFFFFFFFFFFFFFFFFFFFDFE0F504058B2024
                  A0FFFFFF6267C30000781735FFA4B6FFFFFFFF2C4AFF000FFF0316FD030FDF02
                  0AD10105C30205B7000093000093464DBEFFFFFF4A4EBD00007F0318FF91A6FF
                  FFFFFFA9B9FF000EFF0008FF010CFD0410DF0005D10005C30103B60206AEC3C7
                  EFFCFCFD1017AA00007FFF00FF5F7AFFFFFFFFFFFFFF5C75FF000BFF000EFF00
                  0AFF0618F80007DB0006CC7684E8FFFFFF8F97E2000198FF00FFFF00FF425FFF
                  C4CFFFFFFFFFFFFFFF8B9FFF162FFF0414FF0515FD2037F39FADF7FFFFFFE2E5
                  FA101ABA000198FF00FFFF00FFFF00FF5975FFD7DFFFFFFFFFFFFFFFFCFCFFD1
                  DBFFD4DFFFFFFFFFFFFFFFC6CDF71825CD0001B0FF00FFFF00FFFF00FFFF00FF
                  FF00FF5C76FF97A9FDDAE0FFFFFFFFFFFFFFFFFFFFD4DBFD596FF00514D70001
                  B0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5C75FF5C79FF62
                  7DFF4A66FD203CF50619E5FF00FFFF00FFFF00FFFF00FFFF00FF}
              end
              object sbCancel: TSpeedButton
                Left = 296
                Top = 128
                Width = 113
                Height = 22
                Anchors = [akLeft, akRight]
                Caption = 'Cancelar'
                Flat = True
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
              end
              object sbNew: TSpeedButton
                Left = 8
                Top = 128
                Width = 113
                Height = 22
                Anchors = [akLeft]
                Caption = 'Novo'
                Flat = True
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                  FF00FFFF00FFFF00FF00004300004300003C000037000036000036FF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000930000930002841518892B
                  2D8C2A2A830F0F6200004000003A00003AFF00FFFF00FFFF00FFFF00FFFF00FF
                  0004B30104A73D45C3B3B7EAFFFFFFFFFFFFFFFFFFFFFFFFA0A2CC2D2D740000
                  3A00004EFF00FFFF00FFFF00FF0005CC0107BA7F89E2FFFFFFFFFFFF9B9CDB5E
                  5EB75F5FB6ADADDDFFFFFFFFFFFF5E5E9B00003A000043FF00FFFF00FF0005CC
                  6472E5FFFFFFD7DAF52427B300008300007200006800006A31319CE6E6F7FFFF
                  FF36367D000043FF00FF0007E80B1BD8F8F8FFF2F3FC1621C400009F04079C89
                  8FD8797BCD010275000061262695FFFFFFC3C3DB01015000004B0007E84358F0
                  FFFFFF6476ED0002C40001B60407AEE8EDFDCACFF000018000006E0000668484
                  C9FFFFFF27278800004B0009F37F94FAFFFFFF1932F00512E07587EA979CE8F3
                  F5FDEBEDF89194DB6A6DC70202782D2E9EFFFFFF5558BE00004A0218FDA6B4FD
                  FFFFFF112CFD0B20F5F7FAFFFFFFFFFFFFFFFFFFFFFFFFFFDFE0F504058B2024
                  A0FFFFFF6267C30000781735FFA4B6FFFFFFFF2C4AFF000FFF142FF82B3EEDE6
                  EBFDD2D7F7232DCA121EB9000093464DBEFFFFFF4A4EBD00007F0318FF91A6FF
                  FFFFFFA9B9FF000EFF0008FF0515F8EBF0FFCFD5F70108C70001B30206AEC3C7
                  EFFCFCFD1017AA00007FFF00FF5F7AFFFFFFFFFFFFFF5C75FF000BFF000EFF1E
                  3BFF1A35F30007DB0006CC7684E8FFFFFF8F97E2000198FF00FFFF00FF425FFF
                  C4CFFFFFFFFFFFFFFF8B9FFF162FFF0414FF0515FD2037F39FADF7FFFFFFE2E5
                  FA101ABA000198FF00FFFF00FFFF00FF5975FFD7DFFFFFFFFFFFFFFFFCFCFFD1
                  DBFFD4DFFFFFFFFFFFFFFFC6CDF71825CD0001B0FF00FFFF00FFFF00FFFF00FF
                  FF00FF5C76FF97A9FDDAE0FFFFFFFFFFFFFFFFFFFFD4DBFD596FF00514D70001
                  B0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5C75FF5C79FF62
                  7DFF4A66FD203CF50619E5FF00FFFF00FFFF00FFFF00FFFF00FF}
              end
              object lSeq_Comp: TStaticText
                Left = 8
                Top = 16
                Width = 113
                Height = 21
                Anchors = [akLeft]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = ' Seq'#252#234'ncia:'
                FocusControl = eSeq_Comp
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object eSeq_Comp: TCurrencyEdit
                Left = 128
                Top = 16
                Width = 81
                Height = 21
                AutoSize = False
                DecimalPlaces = 0
                DisplayFormat = ',0.;- ,0.'
                Anchors = [akLeft]
                TabOrder = 1
              end
              object lMed_Def: TStaticText
                Left = 352
                Top = 16
                Width = 113
                Height = 21
                Alignment = taCenter
                Anchors = [akLeft, akRight]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = 'Med. Def.:'
                FocusControl = eMed_Def
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object eQtd_Prod: TCurrencyEdit
                Left = 128
                Top = 56
                Width = 81
                Height = 21
                AutoSize = False
                DecimalPlaces = 4
                DisplayFormat = ',0.0000;- ,0.0000'
                Anchors = [akLeft, akRight]
                TabOrder = 3
              end
              object lQtd_Prod: TStaticText
                Left = 8
                Top = 56
                Width = 113
                Height = 21
                Anchors = [akLeft]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = ' Quantidade:'
                FocusControl = eQtd_Prod
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
              end
              object eMed_Def: TCurrencyEdit
                Left = 472
                Top = 16
                Width = 81
                Height = 21
                AutoSize = False
                DecimalPlaces = 4
                DisplayFormat = ',0.0000;- ,0.0000'
                Anchors = [akLeft]
                TabOrder = 5
              end
              object eFk_Insumos: TComboBox
                Left = 128
                Top = 96
                Width = 425
                Height = 21
                Style = csDropDownList
                Anchors = [akLeft, akRight]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemHeight = 0
                ParentFont = False
                TabOrder = 6
              end
              object lFk_Insumos: TStaticText
                Left = 8
                Top = 96
                Width = 113
                Height = 21
                Anchors = [akLeft]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = ' Insumo:'
                FocusControl = eFk_Insumos
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 7
              end
              object lFlag_Def: TCheckBox
                Left = 100
                Top = 97
                Width = 17
                Height = 17
                Hint = 'Insumo Default'
                Anchors = [akLeft]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 8
              end
              object eFlag_TMat: TComboBox
                Left = 472
                Top = 56
                Width = 81
                Height = 21
                Style = csDropDownList
                Anchors = [akLeft, akRight]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ItemHeight = 13
                ItemIndex = 0
                ParentFont = False
                TabOrder = 9
                Text = 'Atividades'
                Items.Strings = (
                  'Atividades'
                  'Materiais')
              end
              object lFlag_TMat: TStaticText
                Left = 352
                Top = 56
                Width = 113
                Height = 21
                Anchors = [akLeft, akRight]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = ' Tipo de Ins.:'
                FocusControl = eFlag_TMat
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 10
              end
            end
          end
          object lDsc_Comp: TStaticText
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Descri'#231#227'o: '
            FocusControl = eDsc_Comp
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object eDsc_Comp: TEdit
            Left = 104
            Top = 0
            Width = 465
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
      end
      object gbProductService: TGroupBox
        Left = 0
        Top = 0
        Width = 583
        Height = 33
        Align = alTop
        TabOrder = 1
        DesignSize = (
          583
          33)
        object lFlag_Atv: TCheckBox
          Left = 8
          Top = 9
          Width = 257
          Height = 17
          Anchors = [akLeft]
          Caption = 'Utilizar como uma atividade de servi'#231'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = lFlag_AtvClick
        end
        object lVlr_Unit: TStaticText
          Left = 328
          Top = 8
          Width = 121
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Valor Refer'#234'ncia: '
          FocusControl = eVlr_Unit
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Visible = False
        end
        object eVlr_Unit: TCurrencyEdit
          Left = 456
          Top = 8
          Width = 121
          Height = 21
          AutoSize = False
          Anchors = [akRight]
          TabOrder = 2
          Visible = False
          ZeroEmpty = False
          OnChange = ChangeGlobal
        end
      end
    end
    object tsCarriers: TTabSheet
      Caption = 'Servi'#231'os de Fretes'
      ImageIndex = 1
      DesignSize = (
        583
        257)
      object lFlag_Tp_Frete: TRadioGroup
        Left = 8
        Top = 8
        Width = 225
        Height = 105
        Anchors = [akLeft]
        Caption = 'Tipo do Frete'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Frete pago'
          'Frete a pagar'
          'Frete Consignado de Coleta'
          'Frete Consignado de Entrega')
        ParentFont = False
        TabOrder = 0
        OnClick = ChangeGlobal
      end
      object lFlag_Rdsp: TCheckBox
        Left = 240
        Top = 16
        Width = 337
        Height = 17
        Anchors = [akLeft, akRight]
        Caption = 'Redespacho de Mercadoria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = ChangeGlobal
      end
    end
  end
end
