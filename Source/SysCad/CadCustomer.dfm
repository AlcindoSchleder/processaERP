inherited CdCustomer: TCdCustomer
  Left = 226
  Top = 94
  Caption = 'CdCustomer'
  ClientHeight = 162
  ClientWidth = 766
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgControl: TPageControl
    Left = 0
    Top = 0
    Width = 766
    Height = 162
    ActivePage = tsCustumerData
    Align = alClient
    ParentShowHint = False
    ShowHint = False
    Style = tsFlatButtons
    TabOrder = 0
    TabStop = False
    OnChange = pgControlChange
    object tsCustumerData: TTabSheet
      Caption = 'Dados do Cliente'
      ImageIndex = 51
      object pgControlCust: TPageControl
        Left = 0
        Top = 0
        Width = 758
        Height = 131
        ActivePage = tsData_cli
        Align = alClient
        HotTrack = True
        Style = tsFlatButtons
        TabOrder = 0
        object tsData_cli: TTabSheet
          Caption = 'Padr'#245'es da Venda'
          DesignSize = (
            750
            100)
          object lFk_Vw_Vendedores: TStaticText
            Left = 0
            Top = 8
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Vendedor: '
            FocusControl = eFk_Vw_Vendedores
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object lFk_Vw_Representantes: TStaticText
            Left = 0
            Top = 32
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Representante: '
            FocusControl = eFk_Vw_Representantes
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object lFk_Tipo_Pagamentos: TStaticText
            Left = 376
            Top = 8
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Cond. de Pagto. Padr'#227'o: '
            FocusControl = eFk_Tipo_Pagamentos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object lFk_Tipo_Descontos: TStaticText
            Left = 376
            Top = 56
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Desconto Padr'#227'o: '
            FocusControl = eFk_Tipo_Descontos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object lFk_Tabela_Precos: TStaticText
            Left = 0
            Top = 80
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Tab. de Pre'#231'os Padr'#227'o: '
            FocusControl = eFk_Tabela_Precos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
          object lFk_Meios_Pagamento: TStaticText
            Left = 376
            Top = 32
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Forma de Pgto.:'
            FocusControl = eFk_Meios_Pagamento
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object lFk_Tipo_Bloqueios: TStaticText
            Left = 0
            Top = 56
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Bloqueio: '
            FocusControl = eFk_Tipo_Bloqueios
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
          end
          object eFk_Tipo_Pagamentos: TPrcComboBox
            Tag = 2
            Left = 552
            Top = 8
            Width = 193
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            Ctl3D = True
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = eFk_Tipo_PagamentosSelect
            ParentCtl3D = False
            TabOrder = 4
          end
          object eFk_Vw_Vendedores: TPrcComboBox
            Tag = 2
            Left = 176
            Top = 8
            Width = 193
            Height = 21
            Anchors = [akLeft]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = ChangeGlobal
            TabOrder = 0
          end
          object eFk_Vw_Representantes: TPrcComboBox
            Tag = 2
            Left = 176
            Top = 32
            Width = 193
            Height = 21
            Anchors = [akLeft]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = ChangeGlobal
            TabOrder = 1
          end
          object eFk_Tipo_Descontos: TPrcComboBox
            Tag = 2
            Left = 552
            Top = 56
            Width = 193
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            Ctl3D = True
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = ChangeGlobal
            ParentCtl3D = False
            TabOrder = 6
          end
          object eFk_Tabela_Precos: TPrcComboBox
            Tag = 2
            Left = 176
            Top = 80
            Width = 193
            Height = 21
            Anchors = [akLeft]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            Ctl3D = True
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = eFk_Tabela_PrecosSelect
            ParentCtl3D = False
            TabOrder = 3
          end
          object eFk_Meios_Pagamento: TPrcComboBox
            Tag = 2
            Left = 552
            Top = 32
            Width = 193
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            Ctl3D = True
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = ChangeGlobal
            ParentCtl3D = False
            TabOrder = 5
          end
          object eFk_Tipo_Bloqueios: TPrcComboBox
            Tag = 2
            Left = 176
            Top = 56
            Width = 193
            Height = 21
            Anchors = [akLeft]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            Ctl3D = True
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = ChangeGlobal
            ParentCtl3D = False
            TabOrder = 2
          end
          object lFk_Vw_Transportadoras: TStaticText
            Left = 376
            Top = 80
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Transportadora: '
            FocusControl = eFk_Vw_Transportadoras
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object eFk_Vw_Transportadoras: TPrcComboBox
            Tag = 2
            Left = 552
            Top = 80
            Width = 193
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = ChangeGlobal
            TabOrder = 7
          end
        end
        object tsComplement_cli: TTabSheet
          Caption = 'Complementos dos Padr'#245'es'
          ImageIndex = 1
          DesignSize = (
            750
            100)
          object lFk_Bancos: TStaticText
            Left = 0
            Top = 24
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Banco: '
            FocusControl = eFk_Bancos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object lFk_Tipo_Estabelecimentos: TStaticText
            Left = 376
            Top = 24
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Tipo de Estabelecimento: '
            FocusControl = eFk_Tipo_Estabelecimentos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object lFk_Vw_Cadastros: TStaticText
            Left = 0
            Top = 48
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Agente Portu'#225'rio: '
            FocusControl = eFk_Vw_Cadastros
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object lFk_Portos__Emb: TStaticText
            Left = 0
            Top = 72
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Porto de Embarque: '
            FocusControl = eFk_Portos__Emb
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object lFk_Portos__Dst: TStaticText
            Left = 376
            Top = 72
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Porto de Destino: '
            FocusControl = eFk_Portos__Dst
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object eFk_Tipo_Estabelecimentos: TPrcComboBox
            Tag = 2
            Left = 552
            Top = 24
            Width = 193
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = ChangeGlobal
            TabOrder = 1
            TypeObject = toInteger
          end
          object eFk_Vw_Cadastros: TPrcComboBox
            Tag = 2
            Left = 176
            Top = 48
            Width = 569
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = ChangeGlobal
            TabOrder = 2
          end
          object eFk_Portos__Emb: TPrcComboBox
            Tag = 2
            Left = 176
            Top = 72
            Width = 193
            Height = 21
            Anchors = [akLeft]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = ChangeGlobal
            TabOrder = 3
          end
          object eFk_Portos__Dst: TPrcComboBox
            Tag = 2
            Left = 552
            Top = 72
            Width = 193
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = ChangeGlobal
            TabOrder = 4
          end
          object eFk_Bancos: TPrcComboBox
            Tag = 2
            Left = 176
            Top = 24
            Width = 193
            Height = 21
            Anchors = [akLeft]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = ChangeGlobal
            TabOrder = 0
          end
          object lFlag_DtaBas: TStaticText
            Left = 0
            Top = 0
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Data Base de Faturam.: '
            FocusControl = eFlag_DtaBas
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object eFlag_DtaBas: TPrcComboBox
            Left = 176
            Top = 0
            Width = 193
            Height = 21
            Anchors = [akLeft]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = ChangeGlobal
            TabOrder = 5
          end
          object lDia_Ems: TStaticText
            Left = 376
            Top = 0
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Dia de Emis. das Faturas: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
          object eDia_Ems: TCurrencyEdit
            Left = 552
            Top = 0
            Width = 49
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = ',0.;- ,0.'
            Anchors = [akLeft, akRight]
            MaxLength = 1
            MaxValue = 31.000000000000000000
            TabOrder = 13
            OnChange = ChangeGlobal
          end
        end
        object tsParams: TTabSheet
          Caption = 'Par'#226'metros'
          ImageIndex = 2
          DesignSize = (
            750
            100)
          object sbGetPasswd: TSpeedButton
            Left = 728
            Top = 77
            Width = 21
            Height = 21
            Anchors = [akRight]
            Flat = True
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5000555555555555577755555555555550B0555555555555F7F7555555555550
              00B05555555555577757555555555550B3B05555555555F7F557555555555000
              3B0555555555577755755555555500B3B0555555555577555755555555550B3B
              055555FFFF5F7F5575555700050003B05555577775777557555570BBB00B3B05
              555577555775557555550BBBBBB3B05555557F555555575555550BBBBBBB0555
              55557F55FF557F5555550BB003BB075555557F577F5575F5555577B003BBB055
              555575F7755557F5555550BB33BBB0555555575F555557F555555507BBBB0755
              55555575FFFF7755555555570000755555555557777775555555}
            NumGlyphs = 2
            OnClick = sbGetPasswdClick
          end
          object lFlag_DifAcc: TRadioGroup
            Left = 0
            Top = 0
            Width = 337
            Height = 41
            Anchors = [akLeft]
            Caption = 'Forma de Cobran'#231'a do Dif'#237'cil Acesso'
            Columns = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'Sempre Cobrar'
              'Somente Destinat'#225'rios')
            ParentFont = False
            TabOrder = 10
            OnClick = lFlag_DifAccClick
          end
          object lFlag_Cnsm: TCheckBox
            Tag = 2
            Left = 0
            Top = 54
            Width = 337
            Height = 17
            Anchors = [akLeft]
            Caption = 'Consumidor Final'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ChangeGlobal
          end
          object lLim_Crd: TStaticText
            Left = 432
            Top = 29
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Limite de Cr'#233'dito: '
            FocusControl = eLim_Crd
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object eLim_Crd: TCurrencyEdit
            Tag = 2
            Left = 608
            Top = 29
            Width = 121
            Height = 21
            AutoSize = False
            Anchors = [akLeft, akRight]
            TabOrder = 2
            OnChange = ChangeGlobal
          end
          object lPwd_Access: TStaticText
            Left = 432
            Top = 77
            Width = 169
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Senha Acesso: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object lDsc_Aut: TStaticText
            Left = 432
            Top = 5
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Desconto Autom'#225'tico: '
            FocusControl = eDsct_Aut
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object eDsct_Aut: TCurrencyEdit
            Tag = 2
            Left = 608
            Top = 5
            Width = 121
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00 %;- ,0.00 %'
            Anchors = [akLeft, akRight]
            TabOrder = 1
            OnChange = ChangeGlobal
          end
          object lDsct_Atc: TStaticText
            Left = 432
            Top = 53
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Desconto p/ Atacado: '
            FocusControl = eDsct_Atc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object eDsct_Atc: TCurrencyEdit
            Tag = 2
            Left = 608
            Top = 53
            Width = 121
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00 %;- ,0.00 %'
            Anchors = [akLeft, akRight]
            TabOrder = 3
            OnChange = ChangeGlobal
          end
          object lFlagFobDirigido: TCheckBox
            Tag = 2
            Left = 0
            Top = 68
            Width = 337
            Height = 17
            Anchors = [akLeft]
            Caption = 'FOB Dirigido'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnClick = ChangeGlobal
          end
          object lFlagSameRegion: TCheckBox
            Tag = 2
            Left = 0
            Top = 83
            Width = 337
            Height = 17
            Anchors = [akLeft]
            Caption = 'Considerar regi'#227'o de origem da empresa geradora'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            OnClick = ChangeGlobal
          end
          object bbClearFLagDiffAcc: TBitBtn
            Left = 232
            Top = 0
            Width = 17
            Height = 17
            Anchors = [akRight]
            TabOrder = 11
            OnClick = bbClearFLagDiffAccClick
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              04000000000080000000CE0E0000C40E00001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00222222222222
              2222222222222222222222222222222222222800000082222222207777770022
              2222207777770802222228077777088022222207F7F7F088022222207F7F7F08
              8022222207F7F7F088822222207F7F7F080222222207F7F7F802222222207F7F
              7702222222228000088222222222222222222222222222222222}
          end
          object ePwd_Access: TEdit
            Left = 608
            Top = 77
            Width = 121
            Height = 21
            Anchors = [akLeft, akRight]
            MaxLength = 30
            TabOrder = 12
            OnChange = ChangeGlobal
          end
        end
        object tsParamsCmpl: TTabSheet
          Caption = 'Par'#226'metros de Movimenta'#231#227'o'
          ImageIndex = 3
          DesignSize = (
            750
            100)
          object lFkTipoTabelaFracao: TStaticText
            Left = 360
            Top = 0
            Width = 177
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Tab. de Pre'#231'os Fracionada: '
            FocusControl = eFkTipoTabelaFracao
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object eFkTipoTabelaFracao: TPrcComboBox
            Tag = 2
            Left = 544
            Top = 0
            Width = 201
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            Ctl3D = True
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = ChangeGlobal
            ParentCtl3D = False
            TabOrder = 1
            TypeObject = toInteger
          end
          object eFk_Tipo_Prazo_Entrega: TPrcComboBox
            Tag = 2
            Left = 544
            Top = 24
            Width = 201
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            Ctl3D = True
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = ChangeGlobal
            ParentCtl3D = False
            TabOrder = 2
            TypeObject = toInteger
          end
          object lFk_Tipo_Prazo_Entrega: TStaticText
            Left = 360
            Top = 24
            Width = 177
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Prazo de entrega: '
            FocusControl = eFk_Tipo_Prazo_Entrega
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object vtMovement: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 353
            Height = 97
            Anchors = [akLeft, akTop, akBottom]
            CheckImageKind = ckXP
            Ctl3D = True
            EditDelay = 0
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clBlue
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HotCursor = crHandPoint
            ParentCtl3D = False
            SelectionCurveRadius = 20
            TabOrder = 4
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnBeforeItemErase = vtMovementBeforeItemErase
            OnChecked = vtMovementChecked
            OnChecking = vtMovementChecking
            OnFocusChanged = vtMovementFocusChanged
            OnFocusChanging = vtMovementFocusChanging
            OnGetText = vtMovementGetText
            OnPaintText = vtMovementPaintText
            OnGetNodeDataSize = vtMovementGetNodeDataSize
            OnInitNode = vtMovementInitNode
            Columns = <
              item
                ImageIndex = 9
                Position = 0
                Width = 353
                WideText = 'Tipo de Movimenta'#231#227'o'
              end>
            WideDefaultText = '...'
          end
          object lIdx_Conv: TStaticText
            Left = 360
            Top = 48
            Width = 177
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Fator de Convers'#227'o: '
            FocusControl = eIdx_Conv
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object eIdx_Conv: TCurrencyEdit
            Tag = 2
            Left = 544
            Top = 48
            Width = 97
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00;- ,0.00'
            Anchors = [akLeft, akRight]
            TabOrder = 6
            OnChange = ChangeGlobal
          end
          object lTax_Access: TStaticText
            Left = 360
            Top = 72
            Width = 177
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Taxa m'#237'n. e idx dif. acesso: '
            FocusControl = eMin_Access
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object eMin_Access: TCurrencyEdit
            Tag = 2
            Left = 544
            Top = 72
            Width = 97
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00;- ,0.00'
            Anchors = [akLeft, akRight]
            TabOrder = 8
            OnChange = ChangeGlobal
          end
          object eTax_Access: TCurrencyEdit
            Tag = 2
            Left = 648
            Top = 72
            Width = 97
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00;- ,0.00'
            Anchors = [akRight]
            TabOrder = 9
            OnChange = ChangeGlobal
          end
        end
      end
    end
    object tsCollectionAddress: TTabSheet
      Caption = 'Endere'#231'o de Cobran'#231'a'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 54
      ParentFont = False
      DesignSize = (
        758
        131)
      object lFk_Paises__ca: TStaticText
        Left = 8
        Top = 8
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Pa'#237's: '
        FocusControl = eFk_Paises__ca
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object eFk_Paises__ca: TPrcComboBox
        Tag = 3
        Left = 168
        Top = 8
        Width = 197
        Height = 21
        Anchors = [akLeft]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = eFk_Paises__caSelect
        TabOrder = 0
      end
      object lFk_Estados__ca: TStaticText
        Left = 368
        Top = 8
        Width = 169
        Height = 20
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Estados: '
        FocusControl = eFk_Estados__ca
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object eFk_Estados__ca: TPrcComboBox
        Tag = 3
        Left = 544
        Top = 8
        Width = 205
        Height = 21
        Anchors = [akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = eFk_Estados__caSelect
        TabOrder = 1
      end
      object eFk_Municipios__ca: TPrcComboBox
        Tag = 3
        Left = 168
        Top = 32
        Width = 581
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 2
      end
      object lFk_Municipios__ca: TStaticText
        Left = 8
        Top = 32
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Munic'#237'pio: '
        FocusControl = eFk_Municipios__ca
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object lEnd_Cbr: TStaticText
        Left = 8
        Top = 56
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Endere'#231'o: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object eEnd_Cbr: TEdit
        Tag = 3
        Left = 168
        Top = 56
        Width = 369
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        TabOrder = 4
        OnChange = ChangeGlobal
      end
      object lCmp_Cbr: TStaticText
        Left = 8
        Top = 80
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Complemento: '
        FocusControl = eCmp_Cbr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object eCmp_Cbr: TEdit
        Tag = 3
        Left = 168
        Top = 80
        Width = 369
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        TabOrder = 6
        OnChange = ChangeGlobal
      end
      object eCxp_Cbr: TEdit
        Tag = 3
        Left = 168
        Top = 104
        Width = 89
        Height = 21
        Anchors = [akLeft]
        CharCase = ecUpperCase
        TabOrder = 8
        OnChange = ChangeGlobal
      end
      object lCxp_Cbr: TStaticText
        Left = 8
        Top = 104
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Caixa Postal: '
        FocusControl = eCxp_Cbr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
      end
      object lFon_Cbr: TStaticText
        Left = 336
        Top = 104
        Width = 89
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Telefone: '
        FocusControl = eFon_Cbr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
      end
      object eFon_Cbr: TMaskEdit
        Left = 432
        Top = 104
        Width = 105
        Height = 21
        Anchors = [akLeft, akRight]
        EditMask = '!\(\0xx99\)9000-0000;0; '
        MaxLength = 16
        TabOrder = 9
        OnChange = ChangeGlobal
      end
      object lFax_Cbr: TStaticText
        Left = 544
        Top = 104
        Width = 87
        Height = 20
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Fax: '
        FocusControl = eFax_Cbr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object eFax_Cbr: TMaskEdit
        Left = 640
        Top = 104
        Width = 105
        Height = 21
        Anchors = [akRight]
        EditMask = '!\(\0xx99\)9000-0000;0; '
        MaxLength = 16
        TabOrder = 10
        OnChange = ChangeGlobal
      end
      object eCep_Cbr: TCurrencyEdit
        Left = 640
        Top = 80
        Width = 105
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akRight]
        TabOrder = 7
        OnChange = ChangeGlobal
      end
      object lCep_Cbr: TStaticText
        Left = 544
        Top = 80
        Width = 89
        Height = 20
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C.E.P.: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object lNum_Cbr: TStaticText
        Left = 544
        Top = 56
        Width = 89
        Height = 20
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'mero: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
      end
      object eNum_Cbr: TCurrencyEdit
        Left = 640
        Top = 56
        Width = 105
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akRight]
        TabOrder = 5
        OnChange = ChangeGlobal
      end
    end
    object tsDeliveryAddress: TTabSheet
      Caption = 'Endere'#231'o de Entrega'
      ImageIndex = 61
      DesignSize = (
        758
        131)
      object sbAddCmpEnt: TSpeedButton
        Left = 528
        Top = 82
        Width = 17
        Height = 17
        Anchors = [akRight]
        Flat = True
        Glyph.Data = {
          E6000000424DE60000000000000076000000280000000F0000000E0000000100
          04000000000070000000130B0000130B00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8880888888888888888088888888888888808888880008888880888888070888
          8880888888070888888088800007000088808880777777708880888000070000
          8880888888070888888088888807088888808888880008888880888888888888
          88808888888888888880}
      end
      object eCmp_Ent: TEdit
        Tag = 4
        Left = 176
        Top = 80
        Width = 351
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        TabOrder = 6
        OnChange = ChangeGlobal
      end
      object eNum_Ent: TCurrencyEdit
        Left = 632
        Top = 56
        Width = 120
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akRight]
        TabOrder = 5
        OnChange = ChangeGlobal
      end
      object lFax_Ent: TStaticText
        Left = 328
        Top = 104
        Width = 73
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Fax: '
        FocusControl = eFax_Ent
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object lCxp_Ent: TStaticText
        Left = 552
        Top = 104
        Width = 73
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C. Postal: '
        FocusControl = eCxp_Ent
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object eCep_Ent: TCurrencyEdit
        Left = 632
        Top = 80
        Width = 120
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akRight]
        TabOrder = 7
        OnChange = ChangeGlobal
      end
      object eCxp_Ent: TEdit
        Tag = 4
        Left = 632
        Top = 104
        Width = 120
        Height = 21
        Anchors = [akRight]
        CharCase = ecUpperCase
        TabOrder = 10
        OnChange = ChangeGlobal
      end
      object lCep_Ent: TStaticText
        Left = 552
        Top = 56
        Width = 73
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C.E.P.: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object lNum_Ent: TStaticText
        Left = 552
        Top = 80
        Width = 73
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'mero: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object eEnd_Ent: TEdit
        Tag = 4
        Left = 176
        Top = 80
        Width = 351
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        TabOrder = 15
        OnChange = ChangeGlobal
      end
      object lFon_Ent: TStaticText
        Left = 0
        Top = 104
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Telefone: '
        FocusControl = eFon_Ent
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
      end
      object lEnd_Ent: TStaticText
        Left = 0
        Top = 80
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Endere'#231'o: '
        FocusControl = eEnd_Ent
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object lFk_Municipios_ent: TStaticText
        Left = 0
        Top = 56
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Munic'#237'pio: '
        FocusControl = eFk_Municipios_ent
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object lFk_Paises_ent: TStaticText
        Left = 0
        Top = 32
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Pa'#237's: '
        FocusControl = eFk_Paises_ent
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
      end
      object eFk_Paises_ent: TPrcComboBox
        Tag = 4
        Left = 176
        Top = 32
        Width = 191
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = eFk_Paises_entSelect
        TabOrder = 2
      end
      object lCnpj_Entr: TStaticText
        Left = 0
        Top = 8
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C.N.P.J.: '
        FocusControl = eCnpj_Entr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
      end
      object eCnpj_Entr: TEdit
        Tag = 4
        Left = 176
        Top = 8
        Width = 191
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        TabOrder = 0
        OnChange = ChangeGlobal
      end
      object lIe_Entr: TStaticText
        Left = 376
        Top = 8
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Inscri'#231#227'o Estadual: '
        FocusControl = eIe_Entr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
      end
      object lFk_Estados_ent: TStaticText
        Left = 376
        Top = 32
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Estado: '
        FocusControl = eFk_Estados_ent
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
      end
      object eFk_Estados_ent: TPrcComboBox
        Tag = 4
        Left = 552
        Top = 32
        Width = 201
        Height = 21
        Anchors = [akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = eFk_Estados_entSelect
        TabOrder = 3
      end
      object eIe_Entr: TEdit
        Tag = 4
        Left = 552
        Top = 8
        Width = 201
        Height = 21
        Anchors = [akRight]
        CharCase = ecUpperCase
        TabOrder = 1
        OnChange = ChangeGlobal
      end
      object eFk_Municipios_ent: TPrcComboBox
        Tag = 4
        Left = 176
        Top = 56
        Width = 369
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 4
      end
      object eFon_Ent: TMaskEdit
        Left = 176
        Top = 104
        Width = 121
        Height = 21
        Anchors = [akLeft]
        EditMask = '!\(\0xx99\)9000-0000;0; '
        MaxLength = 16
        TabOrder = 8
        OnChange = ChangeGlobal
      end
      object eFax_Ent: TMaskEdit
        Left = 408
        Top = 104
        Width = 119
        Height = 21
        Anchors = [akLeft, akRight]
        EditMask = '!\(\0xx99\)9000-0000;0; '
        MaxLength = 16
        TabOrder = 9
        OnChange = ChangeGlobal
      end
    end
    object tsComercialReferences: TTabSheet
      Caption = 'Refer'#234'ncias Comerciais'
      ImageIndex = 46
      object pgRefCom: TPageControl
        Left = 0
        Top = 0
        Width = 758
        Height = 131
        ActivePage = tsListRefCom
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        object tsListRefCom: TTabSheet
          Caption = 'tsListRefCom'
          TabVisible = False
          object vtReferences: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 750
            Height = 121
            Align = alClient
            CheckImageKind = ckXP
            Colors.FocusedSelectionColor = 6730751
            Colors.FocusedSelectionBorderColor = clBtnShadow
            Colors.GridLineColor = clSilver
            Colors.SelectionRectangleBlendColor = 6730751
            Colors.UnfocusedSelectionColor = 6730751
            Ctl3D = True
            EditDelay = 0
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clBlue
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HotCursor = crHandPoint
            ParentCtl3D = False
            SelectionCurveRadius = 20
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
            OnDblClick = TreeViewDblClick
            OnFocusChanged = TreeViewFocusChanged
            OnGetText = TreeViewGetText
            OnKeyDown = TreeViewKeyDown
            Columns = <
              item
                ImageIndex = 9
                Position = 0
                Width = 350
                WideText = 'Nome'
              end
              item
                Position = 1
                Width = 100
                WideText = 'Telefone'
              end
              item
                ImageIndex = 84
                Position = 2
                Width = 300
                WideText = 'e-Mail'
              end>
            WideDefaultText = '...'
          end
        end
        object tsDataRefCom: TTabSheet
          Caption = 'Refer'#234'ncias'
          ImageIndex = 1
          TabVisible = False
          DesignSize = (
            750
            121)
          object sbSaveRef: TSpeedButton
            Left = 608
            Top = 93
            Width = 129
            Height = 22
            Anchors = [akRight]
            Caption = 'Ok'
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
            OnClick = sbSaveRefClick
          end
          object sbCancelRef: TSpeedButton
            Left = 608
            Top = 70
            Width = 129
            Height = 22
            Anchors = [akRight]
            Caption = 'Cancel'
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
            OnClick = sbCancelRefClick
          end
          object sbInsertRef: TSpeedButton
            Left = 608
            Top = 47
            Width = 129
            Height = 22
            Anchors = [akRight]
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
            OnClick = sbInsertRefClick
          end
          object lFon_Ref: TStaticText
            Left = 440
            Top = 0
            Width = 153
            Height = 20
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Telefone: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object lNom_Ref: TStaticText
            Left = 0
            Top = 0
            Width = 161
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Nome: '
            FocusControl = eNom_Ref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object eNom_Ref: TEdit
            Tag = 5
            Left = 168
            Top = 0
            Width = 264
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            TabOrder = 0
            OnChange = ChangeGlobal
          end
          object lFlag_Cnf: TCheckBox
            Tag = 5
            Left = 600
            Top = 23
            Width = 105
            Height = 17
            Anchors = [akRight]
            Caption = 'Conferido?'
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 4
            OnClick = ChangeGlobal
          end
          object eMail_Ref: TEdit
            Tag = 5
            Left = 168
            Top = 23
            Width = 425
            Height = 21
            Anchors = [akLeft, akRight]
            TabOrder = 2
            OnChange = ChangeGlobal
          end
          object lMail_Ref: TStaticText
            Left = 0
            Top = 23
            Width = 161
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'e_Mail: '
            FocusControl = eMail_Ref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object lObs_Ref: TStaticText
            Left = 0
            Top = 47
            Width = 593
            Height = 20
            Alignment = taCenter
            Anchors = [akLeft, akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Observa'#231#245'es'
            FocusControl = eObs_Ref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object eObs_Ref: TMemo
            Tag = 5
            Left = 0
            Top = 69
            Width = 593
            Height = 50
            Anchors = [akLeft, akRight, akBottom]
            TabOrder = 3
            OnChange = ChangeGlobal
          end
          object eFon_Ref: TMaskEdit
            Left = 600
            Top = 0
            Width = 151
            Height = 21
            EditMask = '!\(\0xx99\)9000-0000;0; '
            MaxLength = 16
            TabOrder = 1
            OnChange = ChangeGlobal
          end
        end
      end
    end
    object tsCompanyPartners: TTabSheet
      Caption = 'S'#243'cios da Empresa'
      ImageIndex = 26
      object sbSendMail_soc: TSpeedButton
        Left = 730
        Top = 192
        Width = 23
        Height = 22
        Flat = True
      end
      object pgPartners: TPageControl
        Left = 0
        Top = 0
        Width = 758
        Height = 131
        ActivePage = tsPartnerData
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        object tsPartnerList: TTabSheet
          Caption = 'tsPartnerList'
          TabVisible = False
          object vtPartners: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 750
            Height = 121
            Align = alClient
            CheckImageKind = ckXP
            Colors.FocusedSelectionColor = 6730751
            Colors.FocusedSelectionBorderColor = clBtnShadow
            Colors.GridLineColor = clSilver
            Colors.SelectionRectangleBlendColor = 6730751
            Colors.UnfocusedSelectionColor = 6730751
            Ctl3D = True
            EditDelay = 0
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clBlue
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HotCursor = crHandPoint
            ParentCtl3D = False
            SelectionCurveRadius = 20
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
            OnDblClick = TreeViewDblClick
            OnFocusChanged = TreeViewFocusChanged
            OnGetText = TreeViewGetText
            Columns = <
              item
                ImageIndex = 9
                Position = 0
                Width = 374
                WideText = 'Nome'
              end
              item
                ImageIndex = 84
                Position = 1
                Width = 376
                WideText = 'e-Mail'
              end>
            WideDefaultText = '...'
          end
        end
        object tsPartnerData: TTabSheet
          ImageIndex = 1
          TabVisible = False
          DesignSize = (
            750
            121)
          object sbAddCmpSoc: TSpeedButton
            Left = 433
            Top = 72
            Width = 14
            Height = 17
            Anchors = [akRight]
            GroupIndex = 1
            Flat = True
            Glyph.Data = {
              E6000000424DE60000000000000076000000280000000F0000000E0000000100
              04000000000070000000130B0000130B00001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              8880888888888888888088888888888888808888880008888880888888070888
              8880888888070888888088800007000088808880777777708880888000070000
              8880888888070888888088888807088888808888880008888880888888888888
              88808888888888888880}
          end
          object sbInsertSoc: TSpeedButton
            Left = 456
            Top = 93
            Width = 73
            Height = 22
            Anchors = [akRight]
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
            OnClick = sbInsertSocClick
          end
          object sbCancelSoc: TSpeedButton
            Left = 568
            Top = 93
            Width = 73
            Height = 22
            Anchors = [akRight]
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
            OnClick = sbCancelSocClick
          end
          object sbSaveSoc: TSpeedButton
            Left = 672
            Top = 93
            Width = 73
            Height = 22
            Anchors = [akRight]
            Caption = 'Ok'
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
              F80355DE02398BFF00FF0455C9207DF0E1EFFEFFFFFF116BF25198F4C2DCFBDA
              EAFCC4DCFA478BEE014EE16FA7F0FFFFFF3E8FF20043B7033E96085FDA56A1FA
              FFFFFF9ECBFB1573F7EDF4FE5199F4186EEE5297F2EAF3FE357FED0556E3DEEB
              FC9FCBFA0050D4033E960F6BE68BC1FCFFFFFF2987FCB6D8FE72B0FB1774F40F
              6AF20C65EF6EAAF4B0D0FA0455E5A0C5F6DEEFFF0560E202409C1B76EDA4CFFC
              FFFFFF2988FFCEE6FF4D9DFC1877FA60A6FA116CF31872F24690F2085DEA88BA
              F4EBF6FF0C68E60141A1207AEBA5CFFEFFFFFF3F97FF95C7FFA4D0FF1C7DFCFF
              FFFFB5D7FC378AF70F6AF00C65EEC6DEFBCEE5FE0763E203419E146FE79ACAFC
              FFFFFFB2D8FF2F8CFFCEE6FFD8EBFFFFFFFFFFFFFFFFFFFF64A7FA2C82F4E2EF
              FE81BAF80258D8033E96FF00FF237BEBEDF6FFFAFCFF5DA9FF1F81FF1F81FFFF
              FFFFF0F7FF84BDFE2782FAF0F8FFF2F8FE3089F4024FC0FF00FFFF00FF237BEB
              BFDEFFF3F8FFFAFCFFB0D5FF3E96FFB6D9FF308CFF6AB0FEFAFCFFFFFFFF5DA6
              F70860DE024FC0FF00FFFF00FFFF00FF4997F3C7E3FFF7FBFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFE0EFFE5CA5F80E6BE70552C2FF00FFFF00FFFF00FFFF00FF
              FF00FF2D82EB91C5FBCCE6FFD9EDFFDCEDFEC4E0FE86BFFC348BF40A65E10A65
              E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF247BEB4696F34A
              98F42F87F0116CE6075FDCFF00FFFF00FFFF00FFFF00FFFF00FF}
            OnClick = sbSaveSocClick
          end
          object eCmp_Soc: TEdit
            Tag = 6
            Left = 96
            Top = 70
            Width = 337
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            TabOrder = 10
            OnChange = ChangeGlobal
          end
          object lDta_Nas: TStaticText
            Left = 656
            Top = 47
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Data Nasc.: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object eDta_Nasc_Soc: TDateEdit
            Tag = 6
            Left = 656
            Top = 70
            Width = 89
            Height = 21
            Anchors = [akRight]
            NumGlyphs = 2
            TabOrder = 8
            OnChange = ChangeGlobal
          end
          object eNom_Soc: TEdit
            Tag = 6
            Left = 96
            Top = 0
            Width = 353
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            TabOrder = 0
            OnChange = ChangeGlobal
          end
          object lNom_Soc: TStaticText
            Left = 0
            Top = 0
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Nome: '
            FocusControl = eNom_Soc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
          object lFk_Paises_soc: TStaticText
            Left = 0
            Top = 23
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Pa'#237's: '
            FocusControl = eFk_Paises_soc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object eFk_Paises_soc: TPrcComboBox
            Tag = 6
            Left = 96
            Top = 23
            Width = 353
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = eFk_Paises_socSelect
            TabOrder = 2
          end
          object lFk_Estados_Soc: TStaticText
            Left = 456
            Top = 23
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Estado: '
            FocusControl = eFk_Estados_soc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
          end
          object eFk_Estados_soc: TPrcComboBox
            Tag = 6
            Left = 552
            Top = 23
            Width = 193
            Height = 21
            Anchors = [akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = eFk_Estados_socSelect
            TabOrder = 3
          end
          object eFk_Municipios_soc: TPrcComboBox
            Tag = 6
            Left = 96
            Top = 47
            Width = 353
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = ChangeGlobal
            TabOrder = 4
          end
          object lFk_Municipios_soc: TStaticText
            Left = 0
            Top = 47
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Munic'#237'pio: '
            FocusControl = eFk_Municipios_soc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object lEnd_Soc: TStaticText
            Left = 0
            Top = 70
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Endere'#231'o: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
          end
          object eEnd_Soc: TEdit
            Tag = 6
            Left = 96
            Top = 70
            Width = 337
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            TabOrder = 6
            OnChange = ChangeGlobal
          end
          object lNum_Soc: TStaticText
            Left = 456
            Top = 70
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'N'#250'mero: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 17
          end
          object lCep_Soc: TStaticText
            Left = 456
            Top = 47
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Cep: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 18
          end
          object StaticText1: TStaticText
            Left = 0
            Top = 93
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'lMail_Soc'
            FocusControl = eMail_Soc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 19
          end
          object eMail_Soc: TEdit
            Tag = 6
            Left = 96
            Top = 93
            Width = 353
            Height = 21
            Anchors = [akLeft, akRight]
            TabOrder = 9
            OnChange = ChangeGlobal
          end
          object eCep_Soc: TCurrencyEdit
            Left = 552
            Top = 47
            Width = 96
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = ',0.;- ,0.'
            Anchors = [akRight]
            TabOrder = 5
            OnChange = ChangeGlobal
          end
          object eNum_Soc: TCurrencyEdit
            Left = 552
            Top = 70
            Width = 96
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = ',0.;- ,0.'
            Anchors = [akRight]
            TabOrder = 7
            OnChange = ChangeGlobal
          end
          object lPk_Socios: TStaticText
            Left = 456
            Top = 0
            Width = 89
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'C.P.F.: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 20
          end
          object ePk_Socios: TMaskEdit
            Left = 552
            Top = 0
            Width = 192
            Height = 21
            Anchors = [akRight]
            EditMask = '000.000.000\-00;0; '
            MaxLength = 14
            TabOrder = 1
            OnChange = ChangeGlobal
          end
        end
      end
    end
    object tsDataPersonal: TTabSheet
      Caption = 'Dados Pessoais'
      ImageIndex = 38
      object pgPersonalData: TPageControl
        Left = 0
        Top = 0
        Width = 758
        Height = 131
        ActivePage = tsData_dps
        Align = alClient
        HotTrack = True
        Style = tsFlatButtons
        TabOrder = 0
        object tsData_dps: TTabSheet
          Caption = 'Dados do Cliente'
          DesignSize = (
            750
            100)
          object lEmp_Trb: TStaticText
            Left = 0
            Top = 0
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Empresa que Trabalha: '
            FocusControl = eEmp_Trb
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object lDta_Adm: TStaticText
            Left = 0
            Top = 72
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Data de Admiss'#227'o: '
            FocusControl = eDta_Adm
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object lCrg_Cli: TStaticText
            Left = 0
            Top = 24
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Cargo: '
            FocusControl = eCrg_Cli
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object lFon_Emp: TStaticText
            Left = 512
            Top = 24
            Width = 81
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Telefone: '
            FocusControl = eFon_Emp
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object lPrf_Cli: TStaticText
            Left = 0
            Top = 48
            Width = 169
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Profiss'#227'o: '
            FocusControl = ePrf_Cli
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object ePrf_Cli: TEdit
            Tag = 7
            Left = 176
            Top = 48
            Width = 201
            Height = 21
            Anchors = [akLeft]
            TabOrder = 2
            OnChange = ChangeGlobal
          end
          object eCrg_Cli: TEdit
            Tag = 7
            Left = 176
            Top = 24
            Width = 329
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            TabOrder = 1
            OnChange = ChangeGlobal
          end
          object eEmp_Trb: TEdit
            Tag = 7
            Left = 176
            Top = 0
            Width = 569
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            TabOrder = 0
            OnChange = ChangeGlobal
          end
          object eDta_Adm: TDateEdit
            Tag = 7
            Left = 176
            Top = 72
            Width = 201
            Height = 21
            Anchors = [akLeft]
            NumGlyphs = 2
            TabOrder = 3
            OnChange = ChangeGlobal
          end
          object lFlag_Sex: TRadioGroup
            Tag = 7
            Left = 384
            Top = 48
            Width = 359
            Height = 49
            Anchors = [akLeft, akRight]
            Caption = 'Sexo'
            Columns = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'Masculino'
              'Feminino'
              'Transexual')
            ParentFont = False
            TabOrder = 4
            OnClick = ChangeGlobal
          end
          object eFon_Emp: TMaskEdit
            Left = 600
            Top = 24
            Width = 145
            Height = 21
            Anchors = [akRight]
            EditMask = '!\(\0xx99\)9000-0000;0; '
            MaxLength = 16
            TabOrder = 10
            OnChange = ChangeGlobal
          end
        end
        object tsComplement_dps: TTabSheet
          Caption = 'Complemento'
          ImageIndex = 1
          DesignSize = (
            750
            100)
          object lNum_Cnh: TStaticText
            Left = 0
            Top = 0
            Width = 137
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'N'#250'mero da C.N.H.: '
            FocusControl = eNum_Cnh
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object lDta_Exp: TStaticText
            Left = 256
            Top = 0
            Width = 137
            Height = 21
            Alignment = taRightJustify
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Data de Exped.: '
            FocusControl = eDta_Exp
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object lVal_Cnh: TStaticText
            Left = 504
            Top = 0
            Width = 137
            Height = 21
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Validade da C.N.H.: '
            FocusControl = eVal_Cnh
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object eNum_Cnh: TEdit
            Tag = 7
            Left = 144
            Top = 0
            Width = 105
            Height = 21
            TabOrder = 0
            OnChange = ChangeGlobal
          end
          object eDta_Exp: TDateEdit
            Tag = 7
            Left = 400
            Top = 0
            Width = 95
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            NumGlyphs = 2
            TabOrder = 1
            OnChange = ChangeGlobal
          end
          object eVal_Cnh: TDateEdit
            Tag = 7
            Left = 648
            Top = 0
            Width = 97
            Height = 21
            Anchors = [akTop, akRight]
            NumGlyphs = 2
            TabOrder = 2
            OnChange = ChangeGlobal
          end
          object lSal_Cli: TStaticText
            Left = 368
            Top = 48
            Width = 185
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Valor do Sal'#225'rio: '
            FocusControl = eSal_Cli
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object eSal_Cli: TCurrencyEdit
            Tag = 7
            Left = 560
            Top = 48
            Width = 185
            Height = 21
            AutoSize = False
            Anchors = [akRight]
            TabOrder = 5
            OnChange = ChangeGlobal
          end
          object lCmp_Sal: TStaticText
            Left = 560
            Top = 72
            Width = 81
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Compl. Sal.: '
            FocusControl = eCmp_Sal
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
          object eVlr_Alg: TCurrencyEdit
            Tag = 7
            Left = 648
            Top = 72
            Width = 97
            Height = 21
            AutoSize = False
            Anchors = [akRight]
            TabOrder = 7
            OnChange = ChangeGlobal
          end
          object eCmp_Sal: TCurrencyEdit
            Tag = 7
            Left = 456
            Top = 72
            Width = 97
            Height = 21
            AutoSize = False
            Anchors = [akRight]
            TabOrder = 6
            OnChange = ChangeGlobal
          end
          object lVlr_Alg: TStaticText
            Left = 368
            Top = 72
            Width = 81
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Aluguel: '
            FocusControl = eVlr_Alg
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object eObs_Pes: TMemo
            Tag = 7
            Left = 0
            Top = 48
            Width = 359
            Height = 49
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 3
            OnChange = ChangeGlobal
          end
          object lObs_Cad: TStaticText
            Left = 0
            Top = 24
            Width = 359
            Height = 21
            Alignment = taCenter
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Observa'#231#245'es:'
            FocusControl = eSal_Cli
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
          end
          object lEsc_Cad: TStaticText
            Left = 368
            Top = 24
            Width = 185
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Escolaridade: '
            FocusControl = eEsc_Cad
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object eEsc_Cad: TEdit
            Tag = 7
            Left = 560
            Top = 24
            Width = 185
            Height = 21
            Anchors = [akRight]
            TabOrder = 4
            OnChange = ChangeGlobal
          end
        end
        object tsPersObs: TTabSheet
          Caption = 'Naturalidade'
          ImageIndex = 2
          object gbNatural: TGroupBox
            Left = 0
            Top = 0
            Width = 750
            Height = 100
            Align = alClient
            Caption = 'Naturalidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              750
              100)
            object lNom_Pai: TStaticText
              Left = 8
              Top = 16
              Width = 169
              Height = 21
              Alignment = taRightJustify
              Anchors = [akLeft]
              AutoSize = False
              BorderStyle = sbsSingle
              Caption = 'Nome do Pai: '
              FocusControl = eNom_Pai
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
            object lNom_Mae: TStaticText
              Left = 376
              Top = 16
              Width = 169
              Height = 21
              Alignment = taRightJustify
              Anchors = [akRight]
              AutoSize = False
              BorderStyle = sbsSingle
              Caption = 'Nome da M'#227'e: '
              FocusControl = eNom_Mae
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object lFk_Paises_dps: TStaticText
              Left = 8
              Top = 40
              Width = 169
              Height = 21
              Alignment = taRightJustify
              Anchors = [akLeft]
              AutoSize = False
              BorderStyle = sbsSingle
              Caption = 'Pa'#237's: '
              FocusControl = eFk_Paises_dps
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object lFk_Estados_dps: TStaticText
              Left = 376
              Top = 40
              Width = 169
              Height = 21
              Alignment = taRightJustify
              Anchors = [akRight]
              AutoSize = False
              BorderStyle = sbsSingle
              Caption = 'Estado: '
              FocusControl = eFk_Estados_dps
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object lFk_Municipios_dps: TStaticText
              Left = 8
              Top = 64
              Width = 169
              Height = 21
              Alignment = taRightJustify
              Anchors = [akLeft]
              AutoSize = False
              BorderStyle = sbsSingle
              Caption = 'Munic'#237'pio: '
              FocusControl = eFk_Municipios_dps
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
            object eFk_Paises_dps: TPrcComboBox
              Tag = 7
              Left = 184
              Top = 40
              Width = 183
              Height = 21
              Anchors = [akLeft, akRight]
              BevelKind = bkNone
              CompareMethod = 'ComparePk'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              GetPkMethod = 'GetPkValue'
              ItemHeight = 0
              OnSelect = eFk_Paises_dpsSelect
              ParentFont = False
              TabOrder = 2
            end
            object eFk_Estados_dps: TPrcComboBox
              Tag = 7
              Left = 552
              Top = 40
              Width = 193
              Height = 21
              Anchors = [akRight]
              BevelKind = bkNone
              CompareMethod = 'ComparePk'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              GetPkMethod = 'GetPkValue'
              ItemHeight = 0
              OnSelect = eFk_Estados_dpsSelect
              ParentFont = False
              TabOrder = 3
            end
            object eFk_Municipios_dps: TPrcComboBox
              Tag = 7
              Left = 184
              Top = 64
              Width = 561
              Height = 21
              Anchors = [akLeft, akRight]
              BevelKind = bkNone
              CompareMethod = 'ComparePk'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              GetPkMethod = 'GetPkValue'
              ItemHeight = 0
              OnSelect = ChangeGlobal
              ParentFont = False
              TabOrder = 4
            end
            object eNom_Mae: TEdit
              Tag = 7
              Left = 552
              Top = 16
              Width = 193
              Height = 21
              Anchors = [akRight]
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnChange = ChangeGlobal
            end
            object eNom_Pai: TEdit
              Tag = 7
              Left = 184
              Top = 16
              Width = 183
              Height = 21
              Anchors = [akLeft, akRight]
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = ChangeGlobal
            end
          end
        end
      end
    end
  end
end
