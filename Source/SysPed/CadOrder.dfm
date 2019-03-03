inherited CdOrder: TCdOrder
  Left = 374
  Top = 159
  Caption = 'CdOrder'
  ClientHeight = 488
  ClientWidth = 780
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cbStatus: TCoolBar
    Left = 0
    Top = 0
    Width = 780
    Height = 25
    Bands = <
      item
        Break = False
        Control = tbTools
        ImageIndex = 19
        MinHeight = 23
        Text = 'Opera'#231#245'es'
        Width = 780
      end>
    EdgeBorders = []
    object tbTools: TToolBar
      Left = 67
      Top = 0
      Width = 709
      Height = 23
      ButtonHeight = 19
      ButtonWidth = 107
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbCancel: TToolButton
        Left = 0
        Top = 0
        Hint = 'Cancelar | Cancela as altera'#231#245'es realizadas'
        Caption = 'Cancelar Altera'#231#245'es'
        Enabled = False
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbInsert: TToolButton
        Left = 107
        Top = 0
        Hint = 'Inserir - <Ins> | Insere um novo pedido'
        Caption = 'Novo Pedido'
        ImageIndex = 34
        OnClick = tbInsertClick
      end
      object tbTooSep: TToolButton
        Left = 214
        Top = 0
        Width = 8
        Caption = 'tbTooSep'
        ImageIndex = 29
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 222
        Top = 0
        Hint = 'Salvar - F12 | Salva as altera'#231#245'es realizadas no pedido'
        Caption = 'Salvar Pedido'
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object ToolButton1: TToolButton
        Left = 329
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 38
        Style = tbsSeparator
      end
      object tbSelScreen: TToolButton
        Left = 337
        Top = 0
        Hint = 'Hist'#243'ricos | Mostrar Tela de Hist'#243'ricos do Pedido'
        Caption = 'Visualizar Hist'#243'ricos'
        ImageIndex = 38
        OnClick = tbSelScreenClick
      end
      object lFlag_TPed: TLabel
        Left = 444
        Top = 0
        Width = 43
        Height = 19
        Caption = '   Tipo: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object eFlag_TPed: TComboBox
        Left = 487
        Top = 0
        Width = 104
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnSelect = eFlag_TPedSelect
      end
    end
  end
  object pgOrders: TPageControl
    Left = 0
    Top = 25
    Width = 780
    Height = 463
    ActivePage = tsPedidos
    Align = alClient
    TabOrder = 1
    object tsPedidos: TTabSheet
      Caption = 'tsPedidos'
      TabVisible = False
      object pOrderHeader: TPanel
        Left = 0
        Top = 0
        Width = 772
        Height = 97
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        DesignSize = (
          772
          97)
        object lFk_Grupos_Movimentos: TStaticText
          Left = 8
          Top = 0
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Movimenta'#231#227'o: '
          FocusControl = eFk_Grupos_Movimentos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object lFk_Cadastros: TStaticText
          Left = 8
          Top = 24
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Cliente: '
          FocusControl = eFk_Cadastros
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object lFk_Ordens_Compra: TStaticText
          Left = 528
          Top = 72
          Width = 123
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Ordem de Compra: '
          FocusControl = eFk_Ordens_Compra
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Visible = False
        end
        object lFk_Tabela_Precos: TStaticText
          Left = 528
          Top = 48
          Width = 123
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
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
          TabOrder = 5
        end
        object eDta_Ped: TDateEdit
          Left = 658
          Top = 24
          Width = 114
          Height = 21
          Anchors = [akRight]
          NumGlyphs = 2
          TabOrder = 1
          OnChange = ChangeGlobal
        end
        object lDta_Ped: TStaticText
          Left = 528
          Top = 24
          Width = 123
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data de Abertura: '
          FocusControl = eDta_Ped
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object ePk_Pedidos: TCurrencyEdit
          Left = 658
          Top = 0
          Width = 114
          Height = 21
          AutoSize = False
          DecimalPlaces = 0
          DisplayFormat = '0'
          Anchors = [akRight]
          TabOrder = 0
          OnChange = ChangeGlobal
        end
        object lPk_Pedidos: TStaticText
          Left = 528
          Top = 0
          Width = 123
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'N'#250'mero do Pedido: '
          FocusControl = ePk_Pedidos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object eFk_Grupos_Movimentos: TComboBox
          Left = 120
          Top = 0
          Width = 402
          Height = 21
          Anchors = [akLeft, akRight]
          ItemHeight = 13
          TabOrder = 8
          OnSelect = eFk_Grupos_MovimentosSelect
        end
        object eFk_Cadastros: TComboBox
          Left = 120
          Top = 24
          Width = 402
          Height = 21
          Anchors = [akLeft, akRight]
          ItemHeight = 13
          TabOrder = 9
          OnSelect = eFk_CadastrosSelect
        end
        object eFk_Tabela_Precos: TComboBox
          Left = 658
          Top = 48
          Width = 113
          Height = 21
          Anchors = [akRight]
          ItemHeight = 13
          TabOrder = 10
          OnSelect = eFk_Tabela_PrecosSelect
        end
        object eFk_Ordens_Compra: TComboBox
          Left = 658
          Top = 72
          Width = 113
          Height = 21
          Anchors = [akRight]
          ItemHeight = 13
          TabOrder = 11
          Visible = False
        end
        object lFk_Tipo_Pagamentos: TStaticText
          Left = 8
          Top = 48
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Cond. de Pgto.: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object lFk_Finalizadoras: TStaticText
          Left = 8
          Top = 72
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Forma de Pgto.: '
          FocusControl = eFk_Finalizadoras
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object eFk_Finalizadoras: TComboBox
          Left = 120
          Top = 72
          Width = 403
          Height = 21
          Anchors = [akLeft, akRight]
          ItemHeight = 13
          TabOrder = 14
        end
        object eFk_Tipo_Pagamentos: TComboBox
          Left = 120
          Top = 48
          Width = 403
          Height = 21
          Anchors = [akLeft, akRight]
          ItemHeight = 13
          TabOrder = 15
          OnSelect = eFk_Tipo_PagamentosSelect
        end
      end
      object pItems: TPanel
        Left = 0
        Top = 97
        Width = 772
        Height = 222
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
      end
      object pgFooter: TPageControl
        Left = 0
        Top = 319
        Width = 772
        Height = 134
        ActivePage = tsOrder
        Align = alBottom
        TabOrder = 2
        object tsOrder: TTabSheet
          Caption = 'Dados B'#225'sicos'
          ImageIndex = 23
          DesignSize = (
            764
            106)
          object lFk_Tipo_Descontos: TStaticText
            Left = 0
            Top = 40
            Width = 137
            Height = 21
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
            TabOrder = 2
          end
          object lDsp_Aces: TStaticText
            Left = 250
            Top = 72
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Despesas Acess'#243'rias: '
            FocusControl = eDsp_Aces
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object eDsp_Aces: TCurrencyEdit
            Left = 410
            Top = 72
            Width = 81
            Height = 21
            AutoSize = False
            Anchors = [akRight]
            TabOrder = 1
          end
          object eVlr_Entr: TCurrencyEdit
            Left = 144
            Top = 72
            Width = 85
            Height = 21
            AutoSize = False
            Anchors = [akLeft, akRight]
            TabOrder = 0
          end
          object lVlr_Entr: TStaticText
            Left = 0
            Top = 72
            Width = 137
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Entrada: '
            FocusControl = eVlr_Entr
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object pgValues: TPageControl
            Left = 490
            Top = 0
            Width = 274
            Height = 106
            ActivePage = tsList
            Align = alRight
            PopupMenu = pmDiscounts
            Style = tsFlatButtons
            TabOrder = 5
            object tsValues: TTabSheet
              Caption = 'Valores'
              ImageIndex = 39
              TabVisible = False
              DesignSize = (
                266
                96)
              object lSub_Tot: TStaticText
                Left = 0
                Top = 0
                Width = 153
                Height = 21
                Alignment = taRightJustify
                Anchors = [akLeft]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = 'Sub Total: '
                FocusControl = eSub_Tot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object eSub_Tot: TCurrencyEdit
                Left = 160
                Top = 0
                Width = 105
                Height = 21
                AutoSize = False
                Anchors = [akLeft, akRight, akBottom]
                ReadOnly = True
                TabOrder = 1
                ZeroEmpty = False
              end
              object eVlr_Acr_Dsct: TCurrencyEdit
                Left = 160
                Top = 32
                Width = 105
                Height = 21
                AutoSize = False
                Anchors = [akLeft, akRight, akBottom]
                TabOrder = 2
                ZeroEmpty = False
              end
              object lVlr_Acr_Dsct: TStaticText
                Left = 0
                Top = 32
                Width = 153
                Height = 21
                Hint = 
                  'Deltalhar Descontos | Com dois cliques voc'#234' v'#234' o detalhamento do' +
                  's descontos'
                Alignment = taRightJustify
                Anchors = [akLeft]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = 'Acr'#233'scimo/Desconto: '
                FocusControl = eVlr_Acr_Dsct
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
                OnClick = lVlr_Acr_DsctClick
              end
              object lTot_Ped: TStaticText
                Left = 0
                Top = 64
                Width = 153
                Height = 25
                Alignment = taRightJustify
                Anchors = [akLeft]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = 'Total do Pedido: '
                FocusControl = eTot_Ped
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -16
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
              end
              object eTot_Ped: TCurrencyEdit
                Left = 160
                Top = 64
                Width = 105
                Height = 25
                AutoSize = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clRed
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                Anchors = [akLeft, akRight, akBottom]
                ParentFont = False
                ReadOnly = True
                TabOrder = 5
                ZeroEmpty = False
              end
            end
            object tsList: TTabSheet
              Caption = 'tsList'
              ImageIndex = 2
              TabVisible = False
              object vtDiscounts: TVirtualStringTree
                Left = 0
                Top = 0
                Width = 266
                Height = 96
                Hint = 'Tecle (Ctrl + Barra de Espa'#231'os) para sair'
                Align = alClient
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
                TabOrder = 0
                TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
                TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
                TreeOptions.SelectionOptions = [toExtendedFocus, toMiddleClickSelect, toRightClickSelect]
                WantTabs = True
                OnDblClick = vtDiscountsDblClick
                OnGetText = vtDiscountsGetText
                OnKeyDown = vtDiscountsKeyDown
                Columns = <
                  item
                    ImageIndex = 46
                    Position = 0
                    Width = 80
                    WideText = 'Tipo'
                  end
                  item
                    Alignment = taRightJustify
                    ImageIndex = 86
                    Position = 1
                    Width = 70
                    WideText = 'Valor'
                  end
                  item
                    ImageIndex = 16
                    Position = 2
                    Width = 150
                    WideText = 'Motivo'
                  end>
              end
            end
            object tsDiscounts: TTabSheet
              Hint = 'Tecle (Ctrl + Barra de Espa'#231'os) para sair'
              Caption = 'Descontos'
              ImageIndex = 56
              TabVisible = False
              DesignSize = (
                266
                96)
              object sbSaveDsct: TSpeedButton
                Left = 0
                Top = 74
                Width = 21
                Height = 21
                Anchors = [akLeft]
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
                Layout = blGlyphTop
                OnClick = sbSaveDsctClick
              end
              object sbNewDsct: TSpeedButton
                Left = 0
                Top = 47
                Width = 21
                Height = 21
                Anchors = [akLeft]
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                  A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
                  69A46769A46769FF00FFFF00FFFF00FFB79184FEE9C7F4DAB5F3D5AAF2D0A0EF
                  CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
                  B79187FCEACEF3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
                  7FEFC481A46769FF00FFFF00FFFF00FFB7938AFEEFDAF6E0C6F2DABCF2D5B2EF
                  D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
                  BA978FFFF4E5F7E5CFF4E0C5F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
                  81EFC480A46769FF00FFFF00FFFF00FFC09E95FFFBF0F8EADCF6E3CFF4E0C6F2
                  D9BCF2D5B1F0D0A9EDCB9EEDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
                  C6A49AFFFFFCFAF0E6F8EADAF7E5CFF4E0C5F2DABAF2D5B1F0D0A7EECB9DEBC7
                  93F2C98CA46769FF00FFFF00FFFF00FFCBA99EFFFFFFFEF7F2FAEFE6F8EAD9F7
                  E3CFF6E0C5F2DABBF2D4B1F0D0A7EECC9EF3CE97A46769FF00FFFF00FFFF00FF
                  CFAC9FFFFFFFFFFEFCFCF6F0FAEFE6F7EADAF6E3CFF4E0C5F3D9BBF3D4B0F0D0
                  A6F6D3A0A46769FF00FFFF00FFFF00FFD4B0A1FFFFFFFFFFFFFFFEFCFEF7F0FA
                  EFE5F8EAD9F7E5CEF6DEC4F3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
                  D9B5A1FFFFFFFFFFFFFFFFFFFFFEFCFCF7F0FAEFE5F8E9D9F8E7D1FBEACEDECE
                  B4B6AA93A46769FF00FFFF00FFFF00FFDDB7A4FFFFFFFFFFFFFFFFFFFFFFFFFF
                  FEFCFCF6EFFCF3E6EDD8C9B68A7BA17B6F9C7667A46769FF00FFFF00FFFF00FF
                  E2BCA5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAAD735BE19E
                  55E68F31B56D4DFF00FFFF00FFFF00FFE6BFA7FFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFDCC7C5B88265F8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
                  E4BCA4FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0B77F62C183
                  6CFF00FFFF00FFFF00FFFF00FFFF00FFE8C4ADEBCBB7EBCBB7EACBB7EACAB6EA
                  CAB6EACAB6EACAB6E3C2B1A56B5FFF00FFFF00FFFF00FFFF00FF}
                Layout = blGlyphTop
                OnClick = sbNewDsctClick
              end
              object stTypeDiscounts: TStaticText
                Left = 24
                Top = 47
                Width = 129
                Height = 21
                Hint = 'Tecle (Ctrl + Barra de Espa'#231'os) para sair'
                Alignment = taRightJustify
                Anchors = [akLeft]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = 'Tipo de Descontos: '
                FocusControl = eIdx_Dsct
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object eTypeDiscounts: TComboBox
                Left = 160
                Top = 47
                Width = 105
                Height = 21
                Hint = 'Tecle (Ctrl + Barra de Espa'#231'os) para sair'
                Style = csDropDownList
                Anchors = [akLeft, akRight]
                ItemHeight = 13
                ItemIndex = 0
                TabOrder = 1
                Text = 'Percentual'
                OnSelect = eTypeDiscountsSelect
                Items.Strings = (
                  'Percentual'
                  'Multiplicador'
                  'Divisor'
                  'Valor')
              end
              object lVlr_Dsct: TStaticText
                Left = 24
                Top = 74
                Width = 129
                Height = 21
                Hint = 'Tecle (Ctrl + Barra de Espa'#231'os) para sair'
                Alignment = taRightJustify
                Anchors = [akLeft]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = 'Acr'#233'scimo/Desc.: '
                FocusControl = eIdx_Dsct
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
              end
              object eIdx_Dsct: TCurrencyEdit
                Left = 160
                Top = 74
                Width = 107
                Height = 21
                Hint = 'Tecle (Ctrl + Barra de Espa'#231'os) para sair'
                AutoSize = False
                DecimalPlaces = 4
                DisplayFormat = ',0.0000 %;-,0.0000 %'
                Anchors = [akLeft, akRight]
                TabOrder = 3
                ZeroEmpty = False
              end
              object lDsc_Dsct: TStaticText
                Left = 0
                Top = 19
                Width = 65
                Height = 21
                Hint = 'Tecle (Ctrl + Barra de Espa'#231'os) para sair'
                Alignment = taRightJustify
                Anchors = [akLeft]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = 'Motivo: '
                FocusControl = eIdx_Dsct
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 4
              end
              object eDsc_Dsct: TEdit
                Left = 72
                Top = 19
                Width = 193
                Height = 21
                Hint = 'Tecle (Ctrl + Barra de Espa'#231'os) para sair'
                Anchors = [akLeft, akRight]
                CharCase = ecUpperCase
                MaxLength = 30
                TabOrder = 5
              end
              object lFlag_Dstq: TCheckBox
                Left = 0
                Top = -1
                Width = 265
                Height = 17
                Hint = 'Tecle (Ctrl + Barra de Espa'#231'os) para sair'
                Anchors = [akLeft, akRight]
                Caption = 'Destacar o desconto na impress'#227'o do documento'
                TabOrder = 6
              end
            end
          end
          object eFk_Tipo_Descontos: TComboBox
            Left = 144
            Top = 40
            Width = 347
            Height = 21
            Anchors = [akLeft, akRight]
            ItemHeight = 13
            TabOrder = 6
          end
          object lFk_Tipo_Status_Pedidos: TStaticText
            Left = 0
            Top = 8
            Width = 137
            Height = 20
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Status do Pedido:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object eFk_Tipo_Status_Pedidos: TComboBox
            Left = 144
            Top = 8
            Width = 346
            Height = 21
            Anchors = [akLeft, akRight]
            ItemHeight = 13
            TabOrder = 8
          end
        end
        object tsVendor: TTabSheet
          Caption = 'Dados do Vendedor'
          ImageIndex = 51
          DesignSize = (
            764
            106)
          object sbShowInstallments: TSpeedButton
            Left = 410
            Top = 48
            Width = 105
            Height = 21
            AllowAllUp = True
            Anchors = [akRight]
            GroupIndex = 1
            Caption = 'Mostrar Parcelas'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FF075507075507FF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0755079D
              D9AD47AA22035300FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF135F129DD9AD47AA22095B00FF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF115E1191
              CE9F41A31F085A00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FF0F5A0E82CB953CA420075800FF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF12842325
              BD5014A628047407FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF138A242BD15E19B8420DA12304910B006800FF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF18922B3AE76F27CB5918
              B23C0C9E1D038A06008200006900FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF1C992F4DFF8839E97225CB5816B53A0A9E1A018A03008300008700006A
              00FF00FFFF00FFFF00FFFF00FFFF00FF168E2836DA672CC6551BA1380F8E2707
              7F12047304006A00006900006E00007400006400FF00FFFF00FFFF00FF005200
              0466061566001468010176082A9A3A3ACCCB00C4CE05817F20963521A7371996
              2D067A0E045D08FF00FF004C00005E00748904EB9F22E796117D8F0A0AAA2755
              D48136EBFF00D8FF0D9AA440D7762CD85178C79E12811E004C00FF00FF004C00
              D7A560F3E39EE7CC62D08A0A005303005102468C4D38EDFF005F4F0044004370
              44F75FF43C1339FF00FFFF00FFFF00FFD7B48CFFFFEEF0DD8FD19212FF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF9EFFFF03FFAB00AB790179FF00FFFF00FF
              FF00FFC2A072C49541FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFBD3
              FBFA2FFA8B008BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFA98FAFF00FFFF00FF}
            OnClick = sbShowInstallmentsClick
          end
          object lFk_Vw_Vendedores: TStaticText
            Left = 8
            Top = 0
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Representante: '
            FocusControl = eFk_Vw_Vendedores
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object lFk_Tipo_Prazo_Entrega: TStaticText
            Left = 8
            Top = 24
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Prazo de Entrega: '
            FocusControl = eFk_Tipo_Prazo_Entrega
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object lFlag_DtaBas: TStaticText
            Left = 8
            Top = 48
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Tipo de Data Base: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object eFk_Vw_Vendedores: TComboBox
            Left = 168
            Top = 0
            Width = 347
            Height = 21
            Anchors = [akLeft, akRight]
            ItemHeight = 0
            TabOrder = 0
          end
          object eFk_Tipo_Prazo_Entrega: TComboBox
            Left = 168
            Top = 24
            Width = 347
            Height = 21
            Anchors = [akLeft, akRight]
            ItemHeight = 0
            TabOrder = 1
          end
          object eFlag_DtaBas: TComboBox
            Left = 168
            Top = 48
            Width = 235
            Height = 21
            Anchors = [akLeft, akRight]
            ItemHeight = 0
            TabOrder = 2
            OnSelect = eFlag_DtaBasSelect
          end
          object pgPgtos: TPageControl
            Left = 514
            Top = 0
            Width = 250
            Height = 106
            ActivePage = tsNormal
            Align = alRight
            Style = tsFlatButtons
            TabOrder = 8
            object tsNormal: TTabSheet
              Caption = 'tsNormal'
              TabVisible = False
              DesignSize = (
                242
                96)
              object eCom_Vda: TCurrencyEdit
                Left = 152
                Top = 56
                Width = 90
                Height = 21
                AutoSize = False
                DisplayFormat = '0.00'
                Anchors = [akRight]
                ReadOnly = True
                TabOrder = 2
              end
              object lCom_Vda: TStaticText
                Left = 0
                Top = 56
                Width = 145
                Height = 21
                Alignment = taRightJustify
                Anchors = [akRight]
                AutoSize = False
                BorderStyle = sbsSingle
                Caption = 'Comiss'#227'o: '
                FocusControl = eCom_Vda
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
              end
              object lFlag_CPrvE: TCheckBox
                Left = 1
                Top = 28
                Width = 217
                Height = 17
                Anchors = [akRight]
                Caption = 'Confirmar antes da Entrega'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
              end
              object lFlag_Vinc_Ped: TCheckBox
                Left = 1
                Top = 4
                Width = 201
                Height = 17
                Anchors = [akRight]
                Caption = 'Vincular outros Pedidos'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                OnClick = lFlag_Vinc_PedClick
              end
            end
            object tsPgtos: TTabSheet
              Caption = 'tsPgtos'
              ImageIndex = 1
              TabVisible = False
            end
          end
          object lDta_Bas: TStaticText
            Left = 274
            Top = 72
            Width = 145
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Data Base p/ Fat.: '
            FocusControl = eDta_Bas
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object eDta_Bas: TDateEdit
            Left = 426
            Top = 72
            Width = 90
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akRight]
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 4
          end
          object lNum_Extr: TStaticText
            Left = 8
            Top = 72
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'N'#250'mero do Cliente: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object eNum_Extr: TEdit
            Left = 168
            Top = 72
            Width = 100
            Height = 21
            Anchors = [akLeft, akRight]
            TabOrder = 3
            OnChange = eNum_ExtrChange
          end
        end
        object tsPack: TTabSheet
          Caption = 'Dados da Entrega'
          ImageIndex = 6
          DesignSize = (
            764
            106)
          object lFk_Vw_Transportadoras: TStaticText
            Left = 0
            Top = 0
            Width = 129
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
            TabOrder = 10
          end
          object lVlr_Fret: TStaticText
            Left = 530
            Top = 0
            Width = 145
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Valor do Frete: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object eVlr_Fre: TCurrencyEdit
            Left = 682
            Top = 0
            Width = 81
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00'
            Anchors = [akRight]
            TabOrder = 0
          end
          object lQtd_Vol: TStaticText
            Left = 272
            Top = 24
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Quant. de Volumes: '
            FocusControl = eQtd_Vol
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
          object eQtd_Vol: TCurrencyEdit
            Left = 432
            Top = 24
            Width = 92
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = '0'
            Anchors = [akLeft, akRight]
            TabOrder = 3
          end
          object ePes_Liq: TCurrencyEdit
            Left = 432
            Top = 48
            Width = 91
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00'
            Anchors = [akLeft, akRight]
            TabOrder = 5
          end
          object lPes_Liq: TStaticText
            Left = 272
            Top = 48
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Peso L'#237'quido: '
            FocusControl = ePes_Liq
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object lPes_Bru: TStaticText
            Left = 272
            Top = 72
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Peso Bruto: '
            FocusControl = ePes_Bru
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
          end
          object ePes_Bru: TCurrencyEdit
            Left = 432
            Top = 72
            Width = 91
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00'
            Anchors = [akLeft, akRight]
            TabOrder = 6
          end
          object lNum_Vol: TStaticText
            Left = 530
            Top = 24
            Width = 145
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'N'#250'mero dos Volumes: '
            FocusControl = eNum_Vol
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object eNum_Vol: TCurrencyEdit
            Left = 682
            Top = 24
            Width = 81
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = '0.'
            Anchors = [akRight]
            TabOrder = 4
          end
          object eVlr_Seg: TCurrencyEdit
            Left = 682
            Top = 48
            Width = 81
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00'
            Anchors = [akRight]
            TabOrder = 7
          end
          object lVlr_Seg: TStaticText
            Left = 530
            Top = 48
            Width = 145
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Valor do Seguro: '
            FocusControl = eVlr_Seg
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
          end
          object lFlag_EDrt_Rdsp: TCheckBox
            Left = 0
            Top = 88
            Width = 263
            Height = 17
            Alignment = taLeftJustify
            Anchors = [akLeft]
            Caption = 'Redespachar Pedido'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 17
            OnClick = lFlag_EDrt_RdspClick
          end
          object lFlag_Entr_Parc: TCheckBox
            Left = 0
            Top = 72
            Width = 263
            Height = 17
            Alignment = taLeftJustify
            Anchors = [akLeft]
            Caption = 'Permitir Entrega Parcial do Pedido(s)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 18
          end
          object lDta_Entr: TStaticText
            Left = 0
            Top = 24
            Width = 129
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Data da Entrega: '
            FocusControl = eDta_Entr
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 19
          end
          object eDta_Entr: TDateEdit
            Left = 136
            Top = 24
            Width = 128
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akLeft]
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 1
            OnChange = eDta_EntrChange
          end
          object eTipo_Vol: TEdit
            Left = 136
            Top = 48
            Width = 129
            Height = 21
            Anchors = [akLeft]
            MaxLength = 20
            TabOrder = 2
          end
          object lTipo_Vol: TStaticText
            Left = 0
            Top = 48
            Width = 129
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Tipo de Volume: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 20
          end
          object lMes_Prev_Entr: TStaticText
            Left = 530
            Top = 72
            Width = 145
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Mes/Ano de Entrega: '
            FocusControl = eMes_Prev_Entr
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 21
          end
          object eMes_Prev_Entr: TCurrencyEdit
            Left = 682
            Top = 72
            Width = 33
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = '0'
            Anchors = [akRight]
            ReadOnly = True
            TabOrder = 8
          end
          object eAno_Prev_Entr: TCurrencyEdit
            Left = 722
            Top = 72
            Width = 41
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = '0'
            Anchors = [akRight]
            ReadOnly = True
            TabOrder = 9
          end
          object eFk_Vw_Transportadoras: TComboBox
            Left = 136
            Top = 0
            Width = 387
            Height = 21
            Anchors = [akLeft, akRight]
            ItemHeight = 0
            TabOrder = 22
          end
        end
        object tsTaxes: TTabSheet
          Caption = 'Impostos'
          ImageIndex = 8
          DesignSize = (
            764
            106)
          object lBas_ICMS: TStaticText
            Left = 0
            Top = 0
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Base do ICMS: '
            FocusControl = eBas_ICMS
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object lVlr_ICMS: TStaticText
            Left = 264
            Top = 0
            Width = 145
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Valor do ICMS: '
            FocusControl = eVlr_ICMS
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object lBas_ICMSS: TStaticText
            Left = 0
            Top = 24
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Base do ICMS Subst.: '
            FocusControl = eBas_ICMSS
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
          object lVlr_ICMSS: TStaticText
            Left = 264
            Top = 24
            Width = 145
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Valor do ICMS Subst.: '
            FocusControl = eVlr_ICMSS
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object lBas_ISS: TStaticText
            Left = 0
            Top = 48
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Base do ISS: '
            FocusControl = eBas_ISS
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
          end
          object lVlr_ISS: TStaticText
            Left = 264
            Top = 48
            Width = 145
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Valor do ISS: '
            FocusControl = eVlr_ISS
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object lBas_IPI: TStaticText
            Left = 0
            Top = 72
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Base do IPI: '
            FocusControl = eBas_IPI
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 16
          end
          object lVlr_IPI: TStaticText
            Left = 264
            Top = 72
            Width = 145
            Height = 21
            Alignment = taRightJustify
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Valor do IPI: '
            FocusControl = eVlr_IPI
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 17
          end
          object lBas_Otr: TStaticText
            Left = 522
            Top = 0
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Base de Outros: '
            FocusControl = eBas_Otr
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 18
          end
          object lVlr_Otr: TStaticText
            Left = 522
            Top = 24
            Width = 153
            Height = 21
            Alignment = taRightJustify
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = 'Valor de Outros: '
            FocusControl = eVlr_Otr
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 19
          end
          object eBas_ICMS: TCurrencyEdit
            Left = 160
            Top = 0
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akLeft]
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object eVlr_ICMS: TCurrencyEdit
            Left = 416
            Top = 0
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akLeft]
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object eBas_ICMSS: TCurrencyEdit
            Left = 160
            Top = 24
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akLeft]
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object eVlr_ICMSS: TCurrencyEdit
            Left = 416
            Top = 24
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akLeft]
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object eVlr_IPI: TCurrencyEdit
            Left = 416
            Top = 72
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akLeft]
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
          end
          object eBas_IPI: TCurrencyEdit
            Left = 160
            Top = 72
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akLeft]
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object eVlr_ISS: TCurrencyEdit
            Left = 416
            Top = 48
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akLeft]
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
          object eBas_ISS: TCurrencyEdit
            Left = 160
            Top = 48
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akLeft]
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object eBas_Otr: TCurrencyEdit
            Left = 682
            Top = 0
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akRight]
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
          end
          object eVlr_Otr: TCurrencyEdit
            Left = 682
            Top = 24
            Width = 81
            Height = 21
            AutoSize = False
            Color = clTeal
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akRight]
            ParentFont = False
            ReadOnly = True
            TabOrder = 9
          end
        end
        object tsExport: TTabSheet
          Caption = 'Exporta'#231#227'o'
          ImageIndex = 7
          TabVisible = False
        end
        object tsVincPed: TTabSheet
          Caption = 'V'#237'ncular Pedidos'
          ImageIndex = 42
          TabVisible = False
        end
        object tsDelivery: TTabSheet
          Caption = 'Endere'#231'o de Entrega'
          ImageIndex = 61
          TabVisible = False
        end
        object tsMessages: TTabSheet
          Caption = 'Observa'#231#245'es'
          ImageIndex = 7
        end
      end
    end
    object tsHistorics: TTabSheet
      Caption = 'tsHistorics'
      ImageIndex = 1
      TabVisible = False
    end
  end
  object pmDiscounts: TPopupMenu
    Left = 308
    Top = 199
    object pmExit: TMenuItem
      Caption = '&Sair'
      OnClick = pmExitClick
    end
  end
end
