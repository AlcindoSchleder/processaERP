inherited CdPedItem: TCdPedItem
  Left = 205
  Top = 280
  Caption = 'CdPedItem'
  ClientHeight = 222
  ClientWidth = 770
  Color = clWindow
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgItems: TPageControl
    Left = 0
    Top = 25
    Width = 770
    Height = 197
    ActivePage = tsGrid
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object tsGrid: TTabSheet
      Caption = 'tsGrid'
      TabVisible = False
      object vtItems: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 762
        Height = 187
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        Ctl3D = True
        EditDelay = 0
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        ParentCtl3D = False
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMiddleClickSelect, toRightClickSelect]
        WantTabs = True
        OnGetText = vtItemsGetText
        Columns = <
          item
            ImageIndex = 19
            Position = 0
            Width = 55
            WideText = 'Item'
          end
          item
            ImageIndex = 38
            Position = 1
            Width = 80
            WideText = 'Refer.'
          end
          item
            ImageIndex = 47
            Position = 2
            Width = 280
            WideText = 'Descri'#231#227'o'
          end
          item
            Alignment = taRightJustify
            ImageIndex = 12
            Position = 3
            Width = 70
            WideText = 'Quant.'
          end
          item
            Position = 4
            Width = 35
            WideText = 'UN'
          end
          item
            Alignment = taRightJustify
            ImageIndex = 39
            Position = 5
            Width = 80
            WideText = 'ValorUnit'
          end
          item
            Alignment = taRightJustify
            ImageIndex = 50
            Position = 6
            Width = 70
            WideText = 'Acr./Desc.'
          end
          item
            Alignment = taRightJustify
            ImageIndex = 39
            Position = 7
            Width = 80
            WideText = 'Total'
          end>
      end
    end
    object tsItems: TTabSheet
      Caption = 'tsItems'
      ImageIndex = 1
      TabVisible = False
      DesignSize = (
        762
        187)
      object sbSearchProd: TSpeedButton
        Left = 568
        Top = 0
        Width = 23
        Height = 21
        Hint = 'Ativa Busca de Produtos'
        Anchors = [akTop, akRight]
        Flat = True
        OnClick = sbSearchProdClick
      end
      object stProdTitle: TStaticText
        Left = 240
        Top = 0
        Width = 321
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
        OnDblClick = stProdTitleDblClick
      end
      object lFk_Produtos: TStaticText
        Left = 0
        Top = 0
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Produto: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object eProd_Ref: TEdit
        Left = 120
        Top = 0
        Width = 113
        Height = 21
        Anchors = [akLeft]
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 30
        TabOrder = 0
        OnChange = ChangeGlobal
        OnExit = eProd_RefExit
        OnKeyUp = eProd_RefKeyDown
      end
      object eQtd_Prod: TCurrencyEdit
        Left = 120
        Top = 32
        Width = 113
        Height = 21
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Anchors = [akLeft]
        TabOrder = 3
        OnChange = eQtd_ProdChange
      end
      object eVlr_Unit: TCurrencyEdit
        Left = 120
        Top = 64
        Width = 113
        Height = 21
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Anchors = [akLeft]
        TabOrder = 4
        OnChange = eVlr_UnitChange
      end
      object lQtd_Prod: TStaticText
        Left = 0
        Top = 32
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Quantidade: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object lVlr_Unit: TStaticText
        Left = 0
        Top = 64
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Valor Unit'#225'rio: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object eLot_Item: TEdit
        Left = 648
        Top = 0
        Width = 113
        Height = 21
        TabStop = False
        Anchors = [akTop, akRight]
        BevelKind = bkFlat
        BorderStyle = bsNone
        MaxLength = 20
        TabOrder = 2
        OnChange = ChangeGlobal
      end
      object lSub_Tot: TStaticText
        Left = 0
        Top = 96
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'SubTotal: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object eSub_Tot: TCurrencyEdit
        Left = 120
        Top = 96
        Width = 113
        Height = 21
        TabStop = False
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Anchors = [akLeft]
        ReadOnly = True
        TabOrder = 5
      end
      object lVlr_Acr_Dsct: TStaticText
        Left = 0
        Top = 128
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Acr'#233'sc./Desc.: '
        FocusControl = eVlr_Acr_Dsct
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
      end
      object eVlr_Acr_Dsct: TCurrencyEdit
        Left = 120
        Top = 128
        Width = 113
        Height = 21
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Anchors = [akLeft]
        TabOrder = 6
        OnChange = eVlr_Acr_DsctChange
      end
      object eTot_Item: TCurrencyEdit
        Left = 120
        Top = 160
        Width = 113
        Height = 21
        TabStop = False
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Anchors = [akLeft]
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
      end
      object lTot_Item: TStaticText
        Left = 0
        Top = 160
        Width = 113
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Total: '
        FocusControl = eTot_Item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 16
      end
      object lFk_Tipo_Movimentos: TStaticText
        Left = 240
        Top = 64
        Width = 321
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Tipo de Movim.: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object lFk_Tabela_Precos: TStaticText
        Left = 240
        Top = 128
        Width = 321
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Tabela de Pre'#231'os: '
        FocusControl = eFk_Tabela_Precos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object lFk_Unidades: TStaticText
        Left = 240
        Top = 32
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Unidade: '
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
      end
      object eFk_Produtos: TPrcComboBox
        Left = 240
        Top = 0
        Width = 321
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnChange = ChangeGlobal
        OnSelect = eFk_ProdutosSelect
        TabOrder = 1
        TabStop = False
        TypeObject = toObject
      end
      object eFk_Unidades: TPrcComboBox
        Left = 360
        Top = 32
        Width = 201
        Height = 21
        Anchors = [akLeft, akRight]
        CompareMethod = 'ComparePk'
        Enabled = False
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        TabOrder = 8
        TabStop = False
        TypeObject = toObject
      end
      object eFk_Tipo_Movimentos: TPrcComboBox
        Left = 240
        Top = 96
        Width = 321
        Height = 21
        Anchors = [akLeft, akRight]
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnChange = ChangeGlobal
        TabOrder = 9
        TabStop = False
        TypeObject = toObject
      end
      object eFk_Tabela_Precos: TPrcComboBox
        Left = 240
        Top = 160
        Width = 321
        Height = 21
        Anchors = [akLeft, akRight]
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnChange = ChangeGlobal
        OnSelect = eFk_Tabela_PrecosSelect
        TabOrder = 10
        TabStop = False
        TypeObject = toObject
      end
      object pTaxes: TPanel
        Left = 568
        Top = 24
        Width = 193
        Height = 160
        Anchors = [akRight]
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 20
        DesignSize = (
          193
          160)
        object imImpst: TImage
          Left = 0
          Top = 0
          Width = 29
          Height = 160
          Align = alLeft
          Picture.Data = {
            0A544A504547496D616765160F0000FFD8FFE000104A46494600010101009600
            960000FFDB0043000302020302020303030304030304050805050404050A0707
            06080C0A0C0C0B0A0B0B0D0E12100D0E110E0B0B1016101113141515150C0F17
            1816141812141514FFDB00430103040405040509050509140D0B0D1414141414
            1414141414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC000110800A0001D03012200021101031101
            FFC4001F0000010501010101010100000000000000000102030405060708090A
            0BFFC400B5100002010303020403050504040000017D01020300041105122131
            410613516107227114328191A1082342B1C11552D1F02433627282090A161718
            191A25262728292A3435363738393A434445464748494A535455565758595A63
            6465666768696A737475767778797A838485868788898A92939495969798999A
            A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
            D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
            01010101010101010000000000000102030405060708090A0BFFC400B5110002
            0102040403040705040400010277000102031104052131061241510761711322
            328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
            292A35363738393A434445464748494A535455565758595A636465666768696A
            737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
            A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
            E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FD53
            A2BCFF00E3CFC588FE077C28D73C6D369E7548F4B1096B412F965FCC9922FBDB
            5B18F333D0F4C57CB71FFC1527C292468DFD9FA721600956BDBBC8F6E2CC8FD6
            BAA8E1AA574DC2DF3697E6D1E3E3736C2E5F350AEE577AE909CBFF00498BB7CC
            FB928AF870FF00C1523C2A118AE9DA74840C854BDBBCB7B0CD9815F567C15F89
            91FC62F85FA0F8CA2B23A747AAC4D2ADB193CCD803B27DEC2E7EEE7A0EB456C3
            54A0939DBE4D3FC9B160B36C2E61374E8395D2BEB09C7FF4A8ABFC8DAF1BF8B7
            4CF02F85EF75CD644C74DB5086516F6CF70FF33AA8C4680B372C3A0E3AF6AE1E
            CBE3F7806FED63B88A5658DC64096D0C6C3EAAC011F88AED3C7FE33B6F87BE0F
            D4FC437763A86A56D611891ED74BB66B8B870580F9235E4E3393E80127815F1B
            C9FF000516FF0084EFC531E81E0DB0B4B2B999CC5143756B73757B330CFCAB1A
            A2223707EF31031C903A7461282ADA38FCDC947F33C9CF71F53056953ABCAEDB
            2A52A8DFFE02D5BE67D1D77FB43F806CA069DD2E9E0404BC90E9CF22A81D492A
            0D7A17843C55A3F8DBC3965AD683771DF69376A5A09E2040382548C100820820
            82320820D7C6FE20F81DFB457ED09284D7BC567E1CF869F72BC26E84F7B32EEF
            959A1B72B1282B8F97792092096CD7D51F04FE1369FF00043E1A68FE0DD32F2E
            750B6D3C484DDDE3032CD2492348EC71D32CE703B0C0E7AD3C5C70D04A345DDF
            5D6EBE5A263C92B66B5E4EA6362941AD2F1E595FCD29496DE6CBBF14FE25691F
            083C09A9F8B75E131D274FF2FCEFB3AAB3FCF22C6B80C40FBCE3A91C57CBBE38
            FDA43F66EF8A83778A7C2DA7EB1330DA2EAECE9BE7A8F6905C875FC08AF76F10
            7C70F83FE25D2A7D2F5BF11681AA69B3E04D677E166864C10C3723020E080791
            D40AE34CDFB2F13CE91F0F33EFA45B7FF1BA7429F227ED28C9BF2BAFD0798623
            EB2D7D5B194E31B6AA4A32BFE28F0AD43F698F853F08FC3BB3C13E32F13E9304
            6BB2CF4A4BAB6D52DE12371C05333B80738CBB30000000E87EB1FD9AFE246AFF
            0016FE0AF86FC59AE58369F7FA8C723F96D1F965E312BAC726DEDBD155BD0EEC
            8E08AE1EDEF3F663B59D25874BF87F0CD19DCAE9A4DB2B291DC1F2F8AF74F0EE
            B7A5F88F45B4D4745BB82FB4B9D3304F6CC0C6CA0E3E523B0208FC2AB195A552
            118BA7CA9757BFA5FA9864782861ABCE6B14AA392D631768EFBF2DDA4FBB5B9F
            277C65FD8FF40F0878026D4747F14F8D5EF52F6C20513EBF2BAAC725E43149C1
            FF00A66EF8F4E3D2BB85FD873C1C00C78B3C78A3D0788E6C0AF66F893E0F3E3E
            F01EB9E1F4BB6B09EFAD9A382F1064DBCDD63940EFB5C2B63BE2BE3B8BF6B5F8
            9FF0935487C23F10746B4D17568E45B682F756B599ECAF8F406DEEE33B594E32
            038DC320316606B4A13C46263C90ABEFDF66ED7F46F4BFF48E0CC30794E555BD
            A627069D1715AC61CDCB24DDEE926ECD356693D9DEC7ACDD7EC37E086B5985CF
            8AFC7325BEC3E62CDE2394A15C739CF6AEEFF65CF0F9F0AFC09F0BE9258B8B45
            9E3562DB895FB449839EFC639AF9860FDA07E2CFED2D7D3783FC10968D6D3C9E
            45F78834ED3658B4DB08B71590C934CC4CCE00F9634015F70C9650CA7EDBF07F
            85ECBC11E14D1FC3FA7065B0D2ED22B38379CB148D4282C7B938E4F735962D4E
            9C153AD3E695EFBDEDFF0005FE876E491C356C43C4E5F87F654545ABF2F2B9B6
            D3BDB46924BAABBBEC9257B7AD6B167E1ED22F354D46E12D6C2CE169E79DFEEA
            228CB13F80AF837C73FB58FC65F8C1A84A7E0D784F549F428E4658AF20D2C491
            48158A9F32E251B092403B23C601FBED835F537ED4325A2FC249E3D504A743B8
            D4F4EB7D4FC8665616B25E429272B82061B923B66BD2B41834DB6D1ACA1D1E3B
            68B4B48556D52CC28856303E5081780B8C631C5614A4A8D3F69CB76DDB5E96B7
            CAE7A98BA7531F89784555C23149B49D9CAF75BEF656E9BBD19F03F84BF6B8F8
            CBF08AF203F15FC23AB5B693E688A79AF74A10DB853B40F2AE625081B249DAFB
            8607DE19C8FBDFC3FAF58F8A342B0D634D9C5CE9F7D025C412AFF1230041F6E0
            F4A35F8F4C9745BD8F595B67D2DE265B94BC0A6168C8C3070DC118F5AF39FD97
            ACA1D3BE0BE936D649B3498EEEFD74C1BF78FB0FDB26FB310D939062F2C839E8
            4515A6ABD3F69CA934EDA689FE970C150A980C4FD57DB39C649B4A4EEE36696F
            BD9DFADED6D0F41F15F8634DF1AF86B53D0758B65BBD2F52B77B5B9818E37C6E
            A4119EA0F3C11C8EB5F0BF897F67BFDA13E126B3345E10BEBCF881E182C4DBBE
            9DAFFF0063EA4AB81B45C06222948C1CB00CCE492719C57D81F1C751934AF869
            A8DC4727943CFB48E472701636B989643FF7CB3552F8F3F186D7E0F7C35BCD75
            0C575A94CA20D32D99BE59A761F293FEC28CBB1FEEA9EE4569869D6A715ECB5E
            676B5AEB4B77D3A9CD9A50C062EACD63172BA5052E752719252724D26ACD7C3D
            1EB73E5BF04FECF5F197E2D6AF6D17C44BEBFF000678583092EAC6FF00C42755
            D4EEB19DC91329F2E0460402C06F1B78E0F1F72695A5DA687A65A69D616F1DA5
            8DA429041044BB5238D4055503B000015F9EDF02FE0478FBF683F0DEABF1064F
            1C5C68FE6DD492E8B7F3DAF993EA13270D72EE4878A2DEA55153690074C280DF
            6D7C0FF18DF78FBE13785F5DD4E3116A97564BF6C45E8275CA4B8F6DEAD5AE3E
            5CD65ED39B974B25649F95B4B79E871F0E538D152FDC3839AE652949CE524B4F
            79BD53575A36F7DCDEF1B78474FF001F783F59F0DEAA8CFA76AB692D9CE10E18
            23A95254F6233907B102BE3BB0FD807C73A9EA89A6F8A3E2DBEA5E0D8D7C868A
            D74D48AFE7B7EF1198E4A6E030CC0B6E19C839AFA8FE39E8FE30D7BE166B763E
            01BD8B4FF16CA21FB15C4F29891713217CB0048CA071F8D7CC56FF000F3F6AD5
            8904D75A349201F332F89AED413F4D871538393519255FD9DFD75FB9336CF29D
            3A9569BA981788E5D535CBA6BB7BCD764F43EC8D03C3FA7785740B0D1749B48E
            C74BB0B74B5B6B688616289142AA8F6000AC0F849A6691A37C3CD1EC34196EA7
            D2AD91E28A4BDDBE731123062FB4019DDBBA015F2DFF00C201FB54A92567D1D4
            ED3866F13DD3807B646C19FA57BB7EC992EA13FECFDE1493557126A6CB706E5D
            4E4193ED32EE39FAD675E8D2A54EF0A8A6DB5B5FCF7BA474E071D89C5E2E31AB
            869514A32F8B96EF58EDCADE8BAFC8F59BAB986CADA5B8B8952182242F24B230
            55450324927A002BE24F8A5FF050A98F886E349F8756116A890120C896336A17
            330DC54B2451B22C6011FF002D1F71047CA335F45FED352C6DF09EEAC2E2FA4D
            32C355BFB1D2EEEF622034304F751C4E41208E43EDE463E6AED3C0DE01F0E7C3
            9F0EDAE89E18D22D347D2A0502382D630A0F1F798F5663DD8924F524D45274E8
            C3DA4E1CCDE8AFB7E06F8C8E271B5DE1685574A3149B6927277BD92BECB4D5EE
            7C71F0E3FE0A25326BF6BA5F8EECADEDC4CDB248C58CF617B6C376D0CD1485D2
            4C920ED470D8CF048C57DA7E17B2D22C740B28F418ADA1D21D3CEB65B3004455
            CEFDCB8E307713F8D52F1CF807C37F117C3D73A3F89F47B3D634B9948786EE30
            C178FBCA7AAB0ECC0823B1AE33F661B77D3FE0CE93A779F3DD5B69B777FA75A5
            C5CB6E925B782F268A16638E7288BF8628AD3A75A1CF0872B5BDAF67F7F5160A
            96270788587C456F6A9A6E2DA5CCACD5D696BAD57DDABD8ECFE21781F4FF0089
            3E0AD63C33AA798B65A95BB42D24271244DD52443D99582B03D8A8AF87F5BD7F
            F694F807A8B68F7B61E21F116830FC96BADF8474E8B548EE1001B77DAB86780F
            DEDD8654078504006BECFF008BFAE5D7877C037B79672B43399ED60122315282
            4B88E36208E980E68F8B9F1374FF00849E00D4BC4B7E3CE36E812DAD54E1EE67
            6E23897DD9B193D864F406AF0F52A528A514A4A4ED66AFAAB7F99866585C362E
            BC9D49CA9CE9413E78CACD293969E6BDDBD9E87C83E14B8FDA0BF688BB8F4A98
            F893C2FE1498817FACF8974F874C9638F9DF1C16B1A869588DBB5DC941F36474
            35F6E7857C33A7F833C35A5E83A4C02DB4DD36DA3B5B7881CED4450A327B9C0E
            49EA6BE0EF85573FB407C7AB5D73C67E1FF144305B585DBFD966B8BB9A382FE7
            5037436D1A66310A1F9373870C4753F311F6BFC23F1C9F895F0CFC37E267B736
            93EA5651CD3DB9FF009652E31227E0E187E15B63EFA479934BA455927FAFA9C3
            C3AA179CE509F34D5D4EA3E6728A7FF92DAFF0D95AFEA5AF893E0A87E22F80B5
            EF0D4D71259AEA76925BADD45F7EDDC8F9255FF691B6B0F702BE2CBEFD997F68
            FF00891756DE18F1A7883C3B1F86ED8791FDBB1CF35CCE23C6D6921858ED12B2
            E464AAEDDC7691C57DF1457151C555A09AA6ED7FEB4EC7BD8ECA30998CA33C44
            6F6F3B5D5EF67DD5FA3D0E7BC03E05D23E1AF82B48F0B6836FF65D274BB65B68
            23EA48039663DD98E589EE493DEA0F865E09FF008573E05D27C3BF6CFED06B14
            656BAF2BCAF3599D999B6E4E3963C64D7514573F33B58F51528292925AA565E8
            EDFE48FFD9}
          Stretch = True
        end
        object lAlq_ICMS: TStaticText
          Left = 32
          Top = 8
          Width = 89
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'ICMS: '
          FocusControl = eAlq_ICMS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object eAlq_ICMS: TCurrencyEdit
          Left = 128
          Top = 8
          Width = 65
          Height = 21
          TabStop = False
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          DisplayFormat = ',0.00 %;-,0.00 %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Anchors = [akRight]
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object lAlq_ICMSS: TStaticText
          Left = 32
          Top = 40
          Width = 89
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'ICMS Subst.: '
          FocusControl = eAlq_ICMSS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object eAlq_ICMSS: TCurrencyEdit
          Left = 128
          Top = 40
          Width = 65
          Height = 21
          TabStop = False
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          DisplayFormat = ',0.00 %;-,0.00 %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Anchors = [akRight]
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object lAlq_ISS: TStaticText
          Left = 32
          Top = 72
          Width = 89
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'ISSQN: '
          FocusControl = eAlq_ISS
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object eAlq_ISS: TCurrencyEdit
          Left = 128
          Top = 72
          Width = 65
          Height = 21
          TabStop = False
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          DisplayFormat = ',0.00 %;-,0.00 %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Anchors = [akRight]
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object StaticText1: TStaticText
          Left = 32
          Top = 104
          Width = 89
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'IPI: '
          FocusControl = eAlq_Otr
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object eAlq_IPI: TCurrencyEdit
          Left = 128
          Top = 104
          Width = 65
          Height = 21
          TabStop = False
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          DisplayFormat = ',0.00 %;-,0.00 %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Anchors = [akRight]
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object lAlq_Otr: TStaticText
          Left = 32
          Top = 136
          Width = 89
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Outros: '
          FocusControl = eAlq_Otr
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object eAlq_Otr: TCurrencyEdit
          Left = 128
          Top = 136
          Width = 65
          Height = 21
          TabStop = False
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          DisplayFormat = ',0.00 %;-,0.00 %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Anchors = [akRight]
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
      end
      object lLot_Item: TStaticText
        Left = 600
        Top = 0
        Width = 41
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Lot.: '
        FocusControl = eAlq_ICMS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
      end
    end
    object tsConfig: TTabSheet
      Caption = 'tsConfig'
      ImageIndex = 2
      TabVisible = False
      object vtConfig: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 366
        Height = 187
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        EditDelay = 0
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toMiddleClickSelect, toRightClickSelect]
        WantTabs = True
        OnGetText = vtConfigGetText
        Columns = <
          item
            ImageIndex = 46
            Position = 0
            Width = 280
            WideText = 'Configura'#231#227'o'
          end
          item
            Alignment = taRightJustify
            ImageIndex = 39
            Position = 1
            Width = 70
            WideText = 'Valor'
          end>
      end
      object pConfig: TPanel
        Left = 366
        Top = 0
        Width = 396
        Height = 187
        Align = alRight
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Ctl3D = False
        ParentColor = True
        ParentCtl3D = False
        TabOrder = 1
        DesignSize = (
          394
          185)
        object eQtd_Comp_Tot: TCurrencyEdit
          Left = 320
          Top = 104
          Width = 65
          Height = 21
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          DecimalPlaces = 0
          DisplayFormat = ' ,0;- ,0'
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 2
          OnChange = ChangeGlobal
        end
        object eQtd_Parcial: TCurrencyEdit
          Left = 128
          Top = 104
          Width = 49
          Height = 21
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          DecimalPlaces = 0
          DisplayFormat = ' ,0;- ,0'
          ParentCtl3D = False
          TabOrder = 1
          OnChange = ChangeGlobal
        end
        object eQtd_Pec: TCurrencyEdit
          Left = 128
          Top = 128
          Width = 65
          Height = 21
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          DecimalPlaces = 0
          DisplayFormat = ' ,0;- ,0'
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
          OnChange = ChangeGlobal
        end
        object lFk_Componentes: TStaticText
          Left = 8
          Top = 16
          Width = 113
          Height = 21
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Componente: '
          FocusControl = eFk_Componentes
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object lFk_Tipo_Refernecias: TStaticText
          Left = 8
          Top = 48
          Width = 113
          Height = 21
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Acabamentos: '
          FocusControl = eFk_Tipo_Referencias
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object lFk_Insumos: TStaticText
          Left = 8
          Top = 80
          Width = 113
          Height = 21
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Material: '
          FocusControl = eFk_Insumos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object lQtd_Pec: TStaticText
          Left = 8
          Top = 128
          Width = 113
          Height = 21
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Quant. de Pe'#231'as: '
          FocusControl = eQtd_Pec
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object lQtd_Parcial: TStaticText
          Left = 8
          Top = 104
          Width = 113
          Height = 21
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Quant. Config.: '
          FocusControl = eQtd_Parcial
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object lQtd_Comp_Ref: TStaticText
          Left = 200
          Top = 104
          Width = 113
          Height = 21
          Alignment = taRightJustify
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Total Comp.: '
          FocusControl = eQtd_Comp_Tot
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object eFk_Componentes: TPrcComboBox
          Left = 128
          Top = 16
          Width = 257
          Height = 21
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 0
          OnChange = ChangeGlobal
          OnSelect = eFk_ComponentesSelect
          TabOrder = 9
          TypeObject = toObject
        end
        object eFk_Tipo_Referencias: TPrcComboBox
          Left = 128
          Top = 48
          Width = 257
          Height = 21
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 0
          OnChange = ChangeGlobal
          OnSelect = eFk_Tipo_ReferenciasSelect
          TabOrder = 10
          TypeObject = toObject
        end
        object eFk_Insumos: TPrcComboBox
          Left = 128
          Top = 80
          Width = 257
          Height = 21
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 0
          OnChange = ChangeGlobal
          TabOrder = 11
          TypeObject = toObject
        end
        object udQtdPec: TUpDown
          Left = 177
          Top = 104
          Width = 16
          Height = 21
          Associate = eQtd_Parcial
          TabOrder = 12
        end
        object lTot_Config: TStaticText
          Left = 8
          Top = 160
          Width = 113
          Height = 21
          Alignment = taCenter
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Total: '
          FocusControl = eTot_Config
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 13
        end
        object eTot_Config: TCurrencyEdit
          Left = 128
          Top = 160
          Width = 257
          Height = 21
          TabStop = False
          AutoSize = False
          BevelKind = bkFlat
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akLeft]
          ParentFont = False
          ReadOnly = True
          TabOrder = 14
        end
      end
    end
  end
  object cbItems: TCoolBar
    Left = 0
    Top = 0
    Width = 770
    Height = 25
    Bands = <
      item
        Control = tbTools
        ImageIndex = 83
        Text = 'Sele'#231#227'o de '#205'tens'
        Width = 324
      end
      item
        Break = False
        Control = tbNavigation
        ImageIndex = 31
        Text = 'Navega'#231#227'o'
        Width = 444
      end>
    EdgeBorders = []
    object tbTools: TToolBar
      Left = 95
      Top = 0
      Width = 225
      Height = 25
      Caption = 'tbTools'
      EdgeBorders = []
      Flat = True
      TabOrder = 0
      object tbInsert: TToolButton
        Left = 0
        Top = 0
        Caption = 'tbInsert'
        ImageIndex = 34
        OnClick = tbInsertClick
      end
      object tbCancel: TToolButton
        Left = 23
        Top = 0
        Caption = 'tbCancel'
        Enabled = False
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbDelete: TToolButton
        Left = 46
        Top = 0
        Caption = 'tbDelete'
        ImageIndex = 33
        OnClick = tbDeleteClick
      end
      object tbToolSep: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'tbToolSep'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 77
        Top = 0
        Enabled = False
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object tbGridSep: TToolButton
        Left = 100
        Top = 0
        Width = 8
        Caption = 'tbGridSep'
        ImageIndex = 37
        Style = tbsSeparator
      end
      object tbContract: TToolButton
        Left = 108
        Top = 0
        Hint = 'Contrair Todos'
        Caption = 'tbContract'
        ImageIndex = 68
        OnClick = tbContractClick
      end
      object tbExpand: TToolButton
        Left = 131
        Top = 0
        Hint = 'Expandir Todos'
        Caption = 'tbExpand'
        ImageIndex = 53
        OnClick = tbExpandClick
      end
    end
    object tbNavigation: TToolBar
      Left = 397
      Top = 0
      Width = 369
      Height = 25
      Caption = 'tbNavigation'
      EdgeBorders = []
      Flat = True
      TabOrder = 1
      object tbPrior: TToolButton
        Left = 0
        Top = 0
        Caption = 'tbPrior'
        ImageIndex = 30
      end
      object tbNext: TToolButton
        Left = 23
        Top = 0
        Caption = 'tbNext'
        ImageIndex = 32
      end
    end
  end
end
