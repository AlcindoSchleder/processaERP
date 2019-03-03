object fmSearchOrder: TfmSearchOrder
  Left = 205
  Top = 126
  BorderStyle = bsNone
  Caption = 'fmSearchOrder'
  ClientHeight = 453
  ClientWidth = 774
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pSelectSearch: TPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 185
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      774
      185)
    object sbSearchOwner: TSpeedButton
      Left = 452
      Top = 128
      Width = 21
      Height = 21
      Hint = 'Busca Clientes'
      Anchors = [akRight]
      OnClick = sbSearchOwnerClick
    end
    object cbOrderOwner: TComboBox
      Left = 144
      Top = 128
      Width = 305
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      PopupMenu = pmFields
      TabOrder = 6
      Visible = False
    end
    object lOrderDate: TStaticText
      Left = 480
      Top = 80
      Width = 97
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Data de:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object lin: TStaticText
      Left = 674
      Top = 80
      Width = 21
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'em'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
    object lOrderVendor: TStaticText
      Left = 8
      Top = 152
      Width = 129
      Height = 21
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Representante:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
    end
    object lOrderMoviment: TStaticText
      Left = 8
      Top = 80
      Width = 129
      Height = 21
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Tipo de Movimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
    end
    object lOrderPay: TStaticText
      Left = 480
      Top = 104
      Width = 97
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Forma de Pgto.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
    end
    object lOrderNumber: TStaticText
      Left = 480
      Top = 152
      Width = 97
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'N'#250'mero:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
    end
    object lPurchaseOrder: TStaticText
      Left = 480
      Top = 48
      Width = 97
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Ordem Compra:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      Visible = False
    end
    object eOrderDate: TDateEdit
      Left = 696
      Top = 80
      Width = 73
      Height = 21
      Anchors = [akRight]
      NumGlyphs = 2
      PopupMenu = pmFields
      TabOrder = 4
    end
    object cbTypeDate: TComboBox
      Left = 584
      Top = 80
      Width = 89
      Height = 21
      Style = csDropDownList
      Anchors = [akRight]
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 3
      Text = 'Aberta '
      Items.Strings = (
        'Aberta '
        'Recebidas'
        'Liberadas'
        'Liquidadas'
        'Canceladas'
        'Em Produ'#231#227'o'
        'Faturadas')
    end
    object rgFlags: TRadioGroup
      Left = 8
      Top = 32
      Width = 465
      Height = 41
      Anchors = [akLeft]
      Caption = 'Selecionar Pedidos:'
      Columns = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Todos'
        'Pendentes'
        'Em Aberto'
        'Em Produ'#231#227'o')
      ParentFont = False
      PopupMenu = pmFields
      TabOrder = 1
    end
    object cbOrderVendor: TComboBox
      Left = 144
      Top = 152
      Width = 329
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      PopupMenu = pmFields
      TabOrder = 8
    end
    object cbOrderMoviment: TComboBox
      Left = 144
      Top = 80
      Width = 329
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      PopupMenu = pmFields
      TabOrder = 10
      OnChange = cbOrderMovimentChange
    end
    object cbOrderPay: TComboBox
      Left = 584
      Top = 104
      Width = 185
      Height = 21
      Style = csDropDownList
      Anchors = [akRight]
      ItemHeight = 13
      PopupMenu = pmFields
      TabOrder = 7
    end
    object eOrderNumber: TCurrencyEdit
      Left = 696
      Top = 152
      Width = 73
      Height = 21
      AutoSize = False
      DecimalPlaces = 0
      DisplayFormat = '0'
      Anchors = [akRight]
      PopupMenu = pmFields
      TabOrder = 12
    end
    object cbPurchaseOrder: TComboBox
      Left = 584
      Top = 48
      Width = 185
      Height = 21
      Style = csDropDownList
      Anchors = [akRight]
      ItemHeight = 13
      PopupMenu = pmFields
      TabOrder = 2
      Visible = False
    end
    object cbSearch: TCoolBar
      Left = 0
      Top = 0
      Width = 774
      Height = 33
      Bands = <
        item
          Break = False
          Control = tbStatusBar
          ImageIndex = 43
          Text = 'Status da Pesquisa'
          Width = 432
        end
        item
          Break = False
          Control = tbTools
          ImageIndex = 19
          MinHeight = 24
          Text = 'Selecionar:'
          Width = 336
        end>
      object tbStatusBar: TToolBar
        Left = 106
        Top = 0
        Width = 322
        Height = 25
        ButtonHeight = 19
        ButtonWidth = 72
        Flat = True
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbSepStt0: TToolButton
          Left = 0
          Top = 0
          Width = 8
          Caption = 'tbSepStt0'
          ImageIndex = 17
          Style = tbsSeparator
        end
        object tbSearch: TToolButton
          Left = 8
          Top = 0
          Hint = 'Buscar Pedidos'
          AllowAllUp = True
          Caption = 'Busca - F3'
          Grouped = True
          ImageIndex = 35
          Style = tbsCheck
          OnClick = tbSearchClick
        end
        object tbSepStt1: TToolButton
          Left = 80
          Top = 0
          Width = 8
          Caption = 'tbSepStt1'
          ImageIndex = 17
          Style = tbsSeparator
        end
        object tbCheck: TToolButton
          Left = 88
          Top = 0
          Hint = 'Alterar o Status dos Pedidos Marcados'
          Caption = 'Altera Status'
          Enabled = False
          ImageIndex = 16
          OnClick = tbCheckClick
        end
        object tbSepStt2: TToolButton
          Left = 160
          Top = 0
          Width = 8
          Caption = 'tbSepStt2'
          ImageIndex = 17
          Style = tbsSeparator
        end
        object tbInsert: TToolButton
          Left = 168
          Top = 0
          Hint = 'Inserir - <Ins> | Insere um novo pedido'
          Caption = 'Inserir - Ins'
          ImageIndex = 34
          OnClick = tbInsertClick
        end
      end
      object tbTools: TToolBar
        Left = 502
        Top = 0
        Width = 264
        Height = 24
        ButtonHeight = 19
        ButtonWidth = 82
        Caption = 'tbTools'
        Flat = True
        List = True
        ShowCaptions = True
        TabOrder = 1
        object tbSepVnd0: TToolButton
          Left = 0
          Top = 0
          Width = 8
          Caption = 'tbSepVnd0'
          ImageIndex = 2
          Style = tbsSeparator
        end
        object tbRepresentant: TToolButton
          Left = 8
          Top = 0
          Hint = 'Seleciona Representantes'
          AllowAllUp = True
          Caption = 'Representante'
          Down = True
          Grouped = True
          ImageIndex = 0
          Style = tbsCheck
          OnClick = tbRepresentantClick
        end
        object tbSepVnd1: TToolButton
          Left = 90
          Top = 0
          Width = 8
          Caption = 'tbSepVnd1'
          ImageIndex = 1
          Style = tbsSeparator
        end
        object tbVendor: TToolButton
          Left = 98
          Top = 0
          Hint = 'Seleciona Vendedores'
          AllowAllUp = True
          Caption = 'Vendedor'
          Grouped = True
          ImageIndex = 1
          Style = tbsCheck
          OnClick = tbVendorClick
        end
      end
    end
    object eSearchOwner: TEdit
      Left = 144
      Top = 128
      Width = 305
      Height = 21
      Anchors = [akLeft, akRight]
      CharCase = ecUpperCase
      TabOrder = 5
    end
    object cbOrderStatus: TComboBox
      Left = 144
      Top = 104
      Width = 329
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akRight]
      ItemHeight = 13
      PopupMenu = pmFields
      TabOrder = 9
    end
    object lOrderStatus: TStaticText
      Left = 8
      Top = 104
      Width = 129
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Status:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
    end
    object cbSelNumber: TComboBox
      Left = 584
      Top = 152
      Width = 105
      Height = 21
      Style = csDropDownList
      Anchors = [akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 11
      Text = 'do Cliente'
      Items.Strings = (
        'do Cliente'
        'do Pedido')
    end
    object cbVisibleEntrp: TCheckBox
      Left = 256
      Top = 32
      Width = 209
      Height = 17
      Anchors = [akLeft]
      Caption = 'Pesquisar todas as Empresas'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
    end
    object cbOwnerName: TComboBox
      Left = 8
      Top = 128
      Width = 129
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 22
      Text = 'Raz'#227'o Social'
      Items.Strings = (
        'Raz'#227'o Social'
        'Nome Fantasia')
    end
  end
  object vtSearch: TVirtualStringTree
    Left = 0
    Top = 185
    Width = 774
    Height = 268
    HelpType = htKeyword
    Align = alClient
    CheckImageKind = ckFlat
    EditDelay = 0
    Header.AutoSizeIndex = -1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    PopupMenu = pmFields
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
    OnDblClick = vtSearchDblClick
    OnGetText = vtSearchGetText
    OnPaintText = vtSearchPaintText
    OnInitNode = vtSearchInitNode
    Columns = <
      item
        ImageIndex = 16
        Position = 0
        Width = 120
        WideText = 'N'#250'm.Pedido'
      end
      item
        ImageIndex = 15
        Position = 1
        Width = 100
        WideText = 'Data'
      end
      item
        ImageIndex = 67
        Position = 2
        Width = 150
        WideText = 'Status'
      end
      item
        ImageIndex = 52
        Position = 3
        Width = 300
        WideText = 'Cliente / Produto'
      end
      item
        ImageIndex = 39
        Position = 4
        Width = 100
        WideText = 'Data Fat.'
      end
      item
        ImageIndex = 41
        Position = 5
        Width = 100
        WideText = 'Data Liquida'#231#227'o'
      end
      item
        ImageIndex = 28
        Position = 6
        Width = 100
        WideText = 'Data Cancel.'
      end>
    WideDefaultText = ''
  end
  object pmFields: TPopupMenu
    OnPopup = pmFieldsPopup
    Left = 688
    Top = 224
    object pmAddOrder: TMenuItem
      Tag = -1
      Caption = 'Inserir Pedido'
      ImageIndex = 34
      OnClick = tbInsertClick
    end
    object pmOrderSql: TMenuItem
      Tag = -1
      Caption = 'Exibir SQL'
      Enabled = False
      ImageIndex = 78
      OnClick = pmOrderSqlClick
    end
    object pmFlagFilter: TMenuItem
      Tag = -1
      Caption = 'Filtros'
      ImageIndex = 1
      object pmEqual: TMenuItem
        Caption = 'igual a (=)'
        Checked = True
        ImageIndex = 1
        Visible = False
        OnClick = pmFlagFilterClick
      end
      object pmNoEqual: TMenuItem
        Tag = 1
        Caption = 'diferente de (<>)'
        ImageIndex = 1
        Visible = False
        OnClick = pmFlagFilterClick
      end
      object pmLessThan: TMenuItem
        Tag = 2
        Caption = 'Menor que (<)'
        ImageIndex = 1
        Visible = False
        OnClick = pmFlagFilterClick
      end
      object pmLessEQ: TMenuItem
        Tag = 3
        Caption = 'Menor ou igual a (<=)'
        ImageIndex = 1
        Visible = False
        OnClick = pmFlagFilterClick
      end
      object pmGreaterThan: TMenuItem
        Tag = 4
        Caption = 'Maior que (>)'
        ImageIndex = 1
        Visible = False
        OnClick = pmFlagFilterClick
      end
      object pmGreaterEQ: TMenuItem
        Tag = 5
        Caption = 'Maior ou igual a (>=)'
        ImageIndex = 1
        Visible = False
        OnClick = pmFlagFilterClick
      end
      object N2: TMenuItem
        Caption = '-'
        Visible = False
      end
      object pmDates: TMenuItem
        Tag = -1
        Caption = 'Filtros de Datas'
        Hint = 'pmDates'
        ImageIndex = 15
        Visible = False
        object pmComplete: TMenuItem
          Tag = 12
          Caption = 'Data Completa'
          Checked = True
          ImageIndex = 10
          OnClick = pmFlagFilterClick
        end
        object pmDay: TMenuItem
          Tag = 13
          Caption = 'Seleciona o Dia'
          ImageIndex = 10
          OnClick = pmFlagFilterClick
        end
        object pmMonth: TMenuItem
          Tag = 14
          Caption = 'Seleciona o M'#234's'
          ImageIndex = 10
          OnClick = pmFlagFilterClick
        end
        object pmYear: TMenuItem
          Tag = 15
          Caption = 'Seleciona o Ano'
          ImageIndex = 10
          OnClick = pmFlagFilterClick
        end
      end
    end
  end
end
