inherited CdOrdersHist: TCdOrdersHist
  Left = 246
  Top = 141
  Caption = 'CdOrdersHist'
  ClientHeight = 453
  ClientWidth = 770
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object vtHistoric: TVirtualStringTree
    Left = 0
    Top = 153
    Width = 770
    Height = 300
    Align = alClient
    EditDelay = 0
    Header.AutoSizeIndex = 3
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMiddleClickSelect, toRightClickSelect]
    WantTabs = True
    OnFocusChanged = vtHistoricFocusChanged
    OnGetText = vtHistoricGetText
    Columns = <
      item
        ImageIndex = 19
        Position = 0
        Width = 70
        WideText = #205'tem'
      end
      item
        Alignment = taCenter
        ImageIndex = 21
        Position = 1
        Width = 150
        WideText = 'Data/Hora'
      end
      item
        ImageIndex = 47
        Position = 2
        Width = 380
        WideText = 'Descri'#231#227'o'
      end
      item
        Alignment = taCenter
        ImageIndex = 82
        Position = 3
        Width = 166
        WideText = 'Status'
      end>
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 770
    Height = 33
    Bands = <
      item
        Control = tbTools
        ImageIndex = 82
        Text = 'Ferramentas'
        Width = 766
      end>
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 689
      Height = 25
      ButtonHeight = 23
      Caption = 'tbTools'
      Flat = True
      TabOrder = 0
      object tbInsert: TToolButton
        Left = 0
        Top = 0
        Hint = 'Inserir | Insere um novo registro no Hist'#243'rico'
        Caption = 'tbInsert'
        ImageIndex = 34
        OnClick = tbInsertClick
      end
      object tbCancel: TToolButton
        Left = 23
        Top = 0
        Hint = 'Cancelar | Cancela as alera'#231#245'es feitas no Hist'#243'rico'
        Caption = 'tbCancel'
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbDelete: TToolButton
        Left = 46
        Top = 0
        Hint = 'Excluir | Exclui um registro do Hist'#243'rico'
        Caption = 'tbDelete'
        ImageIndex = 33
        OnClick = tbDeleteClick
      end
      object ToolButton1: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 30
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 77
        Top = 0
        Hint = 'Salvar | Salva as Altera'#231#245'es do Hist'#243'rico'
        Caption = 'tbSave'
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object ToolButton6: TToolButton
        Left = 100
        Top = 0
        Width = 8
        Caption = 'ToolButton6'
        ImageIndex = 31
        Style = tbsSeparator
      end
      object tbFirst: TToolButton
        Left = 108
        Top = 0
        Hint = 'In'#237'cio | Vai para o primeiro registro'
        Caption = 'tbFirst'
        ImageIndex = 31
        OnClick = tbFirstClick
      end
      object tbPrior: TToolButton
        Left = 131
        Top = 0
        Hint = 'Anterior | Vai para o registro anterior'
        Caption = 'tbPrior'
        ImageIndex = 30
        OnClick = tbPriorClick
      end
      object tbNext: TToolButton
        Left = 154
        Top = 0
        Hint = 'Pr'#243'ximo | Vai para o pr'#243'ximo registro'
        Caption = 'tbNext'
        ImageIndex = 32
        OnClick = tbNextClick
      end
      object tbLast: TToolButton
        Left = 177
        Top = 0
        Hint = #218'ltimo | Vai para o '#250'ltimo registro'
        Caption = 'tbLast'
        ImageIndex = 29
        OnClick = tbLastClick
      end
      object ToolButton2: TToolButton
        Left = 200
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 30
        Style = tbsSeparator
      end
      object tbStatistics: TToolButton
        Left = 208
        Top = 0
        Hint = 'Ver datas do Status'
        Caption = 'tbStatistics'
        ImageIndex = 78
        OnClick = tbStatisticsClick
      end
    end
  end
  object pData: TPanel
    Left = 0
    Top = 33
    Width = 770
    Height = 120
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object pImage: TPanel
      Left = 0
      Top = 0
      Width = 169
      Height = 120
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object imDecorative: TImage
        Left = 0
        Top = 0
        Width = 169
        Height = 120
        Align = alClient
        Center = True
        Picture.Data = {
          0A544A504547496D616765C00A0000FFD8FFE000104A46494600010101004800
          480000FFDB0043000302020302020303030304030304050805050404050A0707
          06080C0A0C0C0B0A0B0B0D0E12100D0E110E0B0B1016101113141515150C0F17
          1816141812141514FFDB00430103040405040509050509140D0B0D1414141414
          1414141414141414141414141414141414141414141414141414141414141414
          14141414141414141414141414FFC0001108003E004103012200021101031101
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
          A28A2800AE36C7E30F83F52F121D02DB5B866D601947D9151F77EEC12FDB1C6D
          3F957655F1B782BE11E95E19FDA7EE7C4975F146CAF6E3CFD4447E1EFECE789D
          0C91C8597CD2E41D8BB89E39DA6BBB0F1C34A9D475DB52B7BB6EAFCF4D8F3317
          2C646AD15865170BFBEDEE9796AB5FBCF67D7BC7BF097E26596A76BAA35BEA82
          C2D8DCDC096CE58E6862DE1372B6D0C3E6207CA735F347887E1DEABA7D8EA9E2
          DF825E30D5FC45A1E9737977DA3C924A2F2D0ED0E4C2C706501483B482D8E858
          F15D27C38F819A5437DF10AF2F7E2CD8EB36FA8688D692FF0067D99592C23332
          BF9A72EDBB95C6315EB5FB24F807C2BF0EF42F1369DE19F1A4BE3369EFD6EAEE
          69E358DA066895553000E084CD7AF84C6CF2BA4D5E4AADD7BAFE171B754D6E78
          38DCBA96775A32B42541C5FBF1F8D4AFA72C93D97E67827C34FDB67C53A27909
          AEAC7E22D34E32CF849C0F671C1FC47E35F647C37F8A7E1EF8ABA2FF0068E837
          826098135BC9F2CB037A3AF6FAF435F12FED7BF09EDBE1E7C49FED4D2E110695
          AFA35DF92830B1DC06C4C14760772363D59ABCCFE1AFC4CD5BE13F8AED75FD2A
          463E4902E6DB3F2DCC39F9A361EE3A1EC706BEDB13936133AC1471B838724DAB
          D96CDF54D6DBF547E7184CFF001FC39994B2EC7CDD4A5176BBD5A4F669EFB35A
          3F958FD54A2BC3C7ED8FF0D481FF001356FF00BE28AFCC3EA788FF009F6FEE3F
          66FED2C1FF00CFD5F79EE14565789FC51A6F83F469F54D56E56D6D211CB1E4B1
          ECAA3A927D057C71F15BF6D0D6754B89ECBC2AA349B219517180D3B0F5CF45FA
          0FCEBD1CB325C5E6ADFB1568ADE4F45FF05F923C8CEB8930191A51C436E6F68C
          757EBD92F36FD2E7DA979A85AE9F1992EAE62B68C7F14AE147E66BE3E9FE196A
          127ED02FE2EBEF1DF83D3404B9BE916DC6A04DCA2CD04B1A02A405C8320279EC
          6BE7BF0BDA7C4AFDA3FC5D3E91E19926BF78180D435BD4657369620F666E4B3E
          3A22E4FD0735F5A7C36FD833C0FE1848AEFC5D757BE3DD631977D46431DA29FF
          0062DD0EDC7FBE5ABBF1B9765F96CBD9D4AEE751748A565F36CF3B2ECD736CE2
          3ED69E1A34E93D9CA4DB6BD124729F03FF00674D53C3EBE3855F899A06BB79AF
          E98B6368DA726F36C4396DEC3CC25B83DB1D2BD5FF00668F803AB7C0D5F1436A
          FE2183C413EB3710CCAD05A980442342B8C166CE739AF54D03C1BA0785215874
          5D174FD2625180B656A908F4FE102B3BE217C48D17E1B68926A1AB5CA23E0F93
          6C1809266F403D3D4F415E2D69D6CCB15CD1BCE72FBDFDC7D151861B25C15A6E
          30A705E897DED9F377EDEDAA40F0F8634F186B88BCD99BFD90DB40FCF637E55F
          1B5E5C25ADA4D348C15110B313D8015DF7C6AF8AB37C46F14DCEAB772AADBA93
          B7270A3E99EC00007D33D49A9BF673F80DA97ED1FE28B6BBB8B696D7E1C584C2
          4BEBF914A8D4D94FFC7B427F894918771C0191D4F1FB251A94B87F2B84310FDE
          8A7A776DB765F79FCFB5A9D7E2BCE6A55C345F2C9AD7B4524AEFCECAFEA7CD3F
          D89E253FF307BEFF00BF668AFDC31E18D200C7F65D9FFDF85FF0A2BF33FF0058
          2B7F2A3F64FF0055B0FF00CCCF86FF006AFF008C7378B3C5B73A3585C1FECFB2
          76857637071C311EEC73CFF7401DCE7E7CB0D0751F186BDA3F86B48609AA6B57
          91D8C1230C88B71F9A423D154331FF0076B67C75A45DF87BC65ACE937E317B63
          74F04A3D483C1FA11823D8D763FB2ECB6D6DFB4678267BA2AA9BEE6242C3FE5A
          3DB48ABF8E4E3F1AFD52A28E5F9449E1368C2EBEEDFF0053F10A2A598E7C963F
          79D4B4AFEBB7A2D9791FA0BF0BFE1A687F08FC13A6F863C3F6AB6D6166982D8F
          9E790FDF9643FC4EC7927FA62B5F5ED4EFF4CB7125869136AEFDE28268E361F8
          BB01FAD6A57C5E3E2278F2E3F69C6D0ECC78A0E89F6BD451F7C7706D0AADB4C6
          3C123663784DB8EF8C57E0AA5CD3BCB5BF73FA81C7961CB0D2DD8F44F1F7C4FF
          008ED7504907857E13C9664E409EEB54B37703D47EF703F106BE7DD47F66DFDA
          2FE2C6A6D75AF45A4E89E6905E6D5753F3DD47A6D88374F4C815D97C20F167C5
          AD5F4EF8952789742F17DBC16FA327F67457B6F3C6F34DE61C887B96C63A735E
          8BFB17EABE31D553C70DE2BB4D7ACE38EEEDD2CA3D752656DBE59DE53CDE719C
          6715F4F5332AD9554950C1B82FEF456FF37767C550C9B0F9DD2862B318D46FF9
          672DBFEDD8A51FC0E6BE1A7FC13B3C35A55CC1A87C42D72E7C7177190C34E54F
          B2E9EA7DE304B49FF026C1EEB5F59E9BA6DA68D61058D85AC365676E82386DED
          E3091C6A3A2AA8E001E82ACD15F3B88C4D6C54F9EBCDC9F99F5D85C1E1F050F6
          787828AF20A28A2B98EC3E51FDB07F66DD47C5D31F1DF83ED4DE6B70C41352D2
          E3FBF7B1A8F95E3F5954718FE218039001F8B743F114961AADADF58CCD69AA69
          F70B320752B2412A3640653C8208E41AFD80AF21F8C1FB2BFC3FF8CF2B5EEADA
          63E9DAE1181ACE94FF0067B9F6DE40DB27FC0C37B62BEDB28E249E0A9FD5B131
          E7A7B79A5DBCD1F9DE7DC234F32ADF5CC24BD9D5DFC9BEFE4FCCD9F827F19B4A
          F8C5E1486FAD644875585156FAC09F9A1931C903BA9EC7FAD7837803F682F1CF
          883F69997C2179F6CFF847A197515959F4ED918112B98F126C1DC2E39E7DEB9D
          6FD8AFE23FC2AD606B9E03F88F6937D9F951AA5B3C12E33F759E3DC1C7D5403E
          95DCFC31FDABB5F7BAB2D1FC69A1D8CB7F2B7942F748B86DAC4719647418FC0F
          E15CB386152ABF50B4D4D6D25EF43D2FA7CEF73AA9CB1CDD0FED4E6A6E9BBF34
          1FB93E9EF24EEBD2D6F4D8E07C0BFB4678EBC6575F116D6DEEF5ABF834AD0DAE
          ED71A7ED97CF1708A047B23058EDDDC0CD7ADFEC5DE36F19F8E7C2BE29BCF194
          1ACDBCD16AA22B35D6ADA4824F2BC98CFCA1C0257716E7D735F442804020019E
          69718AF0638A71C2BC372AD5DEFD7D2FD8FA8960A33C6471BCEEEA3CB6BFBBAB
          BDEDDC5A28A2B84F4828A28A00FFD9}
        Proportional = True
      end
    end
    object pgHistoric: TPageControl
      Left = 169
      Top = 0
      Width = 601
      Height = 120
      ActivePage = tsHistoric
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 1
      object tsHistoric: TTabSheet
        TabVisible = False
        DesignSize = (
          593
          110)
        object lFk_Tipo_Status_Pedidos: TStaticText
          Left = 16
          Top = 8
          Width = 153
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Status: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object lDsc_Hist: TStaticText
          Left = 16
          Top = 40
          Width = 153
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Descri'#231#227'o: '
          FocusControl = eDsc_Hist
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object eDsc_Hist: TEdit
          Left = 176
          Top = 40
          Width = 740
          Height = 21
          Anchors = [akLeft, akRight]
          Ctl3D = True
          MaxLength = 100
          ParentCtl3D = False
          TabOrder = 2
          OnChange = ChangeGlobal
        end
        object lDta_Msg: TStaticText
          Left = 16
          Top = 72
          Width = 153
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data/Hora: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object eFk_Tipo_Status_Pedidos: TPrcComboBox
          Left = 176
          Top = 8
          Width = 740
          Height = 21
          Anchors = [akLeft, akRight]
          BevelKind = bkNone
          CompareMethod = 'ComparePk'
          Enabled = False
          GetPkMethod = 'GetPkValue'
          ItemHeight = 13
          OnSelect = ChangeGlobal
          TabOrder = 4
          TypeObject = toObject
        end
        object eDtHr_Hist: TEdit
          Left = 176
          Top = 72
          Width = 241
          Height = 21
          ReadOnly = True
          TabOrder = 5
        end
      end
      object tsStatus: TTabSheet
        Caption = 'tsStatus'
        ImageIndex = 2
        TabVisible = False
        DesignSize = (
          593
          110)
        object eDta_Recb: TDateEdit
          Left = 168
          Top = 40
          Width = 121
          Height = 21
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akLeft]
          NumGlyphs = 2
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object eDta_Fat: TDateEdit
          Left = 779
          Top = 8
          Width = 121
          Height = 21
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akRight]
          NumGlyphs = 2
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object eDta_Lib: TDateEdit
          Left = 168
          Top = 72
          Width = 121
          Height = 21
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akLeft]
          NumGlyphs = 2
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object eDta_Liq: TDateEdit
          Left = 779
          Top = 40
          Width = 121
          Height = 21
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akRight]
          NumGlyphs = 2
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object eDta_Canc: TDateEdit
          Left = 779
          Top = 72
          Width = 121
          Height = 21
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akRight]
          NumGlyphs = 2
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object lDta_Recb: TStaticText
          Left = 8
          Top = 40
          Width = 153
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data de Recebimento: '
          FocusControl = eDta_Recb
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object lDta_Fat: TStaticText
          Left = 619
          Top = 8
          Width = 153
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data de Faturamento: '
          FocusControl = eDta_Fat
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object lDta_Lib: TStaticText
          Left = 8
          Top = 72
          Width = 153
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data de Libera'#231#227'o: '
          FocusControl = eDta_Lib
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object lDta_Ped: TStaticText
          Left = 8
          Top = 8
          Width = 153
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data do Pedido: '
          FocusControl = eDta_Ped
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object eDta_Ped: TDateEdit
          Left = 168
          Top = 8
          Width = 121
          Height = 21
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akLeft]
          NumGlyphs = 2
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
        object lDta_Liq: TStaticText
          Left = 619
          Top = 40
          Width = 153
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data da Finaliza'#231#227'o: '
          FocusControl = eDta_Liq
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object lDta_Canc: TStaticText
          Left = 619
          Top = 72
          Width = 153
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data de Cancelamento: '
          FocusControl = eDta_Canc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
      end
    end
  end
end
