inherited CdTickets: TCdTickets
  Left = 245
  Top = 96
  Height = 425
  Caption = 'CdTickets'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 345
  end
  inherited sbStatus: TStatusBar
    Top = 378
  end
  inherited vtList: TVirtualStringTree
    Height = 345
    TabOrder = 7
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 345
    TabOrder = 14
  end
  object lPk_Tickets: TStaticText
    Left = 248
    Top = 56
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tickets
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object ePk_Tickets: TEdit
    Left = 376
    Top = 56
    Width = 97
    Height = 21
    Anchors = [akLeft, akRight]
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    Text = '0'
  end
  object eDsc_Ticket: TEdit
    Left = 376
    Top = 88
    Width = 265
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 1
    OnChange = ChangeGlobal
  end
  object lDsc_Ticket: TStaticText
    Left = 248
    Top = 88
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Ticket
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object lFk_Cadastros: TStaticText
    Left = 248
    Top = 120
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Operadora: '
    FocusControl = eFk_Cadastros
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object eFk_Cadastros: TComboBox
    Left = 376
    Top = 120
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 2
    OnSelect = ChangeGlobal
  end
  object eFk_Finalizadoras: TComboBox
    Left = 376
    Top = 152
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 3
    OnSelect = ChangeGlobal
  end
  object lFk_Finalizadoras: TStaticText
    Left = 248
    Top = 152
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Finalizadora: '
    FocusControl = eFk_Finalizadoras
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object lFk_Classificacao: TStaticText
    Left = 248
    Top = 184
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Classific. Financ.: '
    FocusControl = eFk_Classificacao
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object eFk_Classificacao: TComboBox
    Left = 376
    Top = 184
    Width = 265
    Height = 19
    Style = csOwnerDrawFixed
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 4
    OnDrawItem = eFk_CadastrosDrawItem
    OnSelect = eFk_ClassificacaoSelect
  end
  object pgProducts: TPageControl
    Left = 248
    Top = 216
    Width = 394
    Height = 169
    ActivePage = tsList
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 13
    OnChanging = pgProductsChanging
    object tsList: TTabSheet
      Caption = 'Lista dos Produtos'
      DesignSize = (
        386
        141)
      object VirtualStringTree1: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 386
        Height = 137
        Anchors = [akLeft, akTop, akRight, akBottom]
        Colors.FocusedSelectionColor = clSilver
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        SelectionCurveRadius = 10
        TabOrder = 0
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toRightClickSelect]
        OnFocusChanged = vtListFocusChanged
        OnFocusChanging = vtListFocusChanging
        OnGetText = vtListGetText
        OnGetImageIndexEx = vtListGetImageIndexEx
        Columns = <
          item
            Position = 0
            Width = 382
            WideText = 'Descri'#231#227'o'
          end>
      end
    end
    object tsData: TTabSheet
      Caption = 'Dados do Produto'
      ImageIndex = 1
      DesignSize = (
        386
        141)
      object bbNew: TSpeedButton
        Left = 8
        Top = 88
        Width = 81
        Height = 22
        Anchors = [akLeft]
        Caption = 'Novo'
        Enabled = False
      end
      object lFk_Produtos: TStaticText
        Left = 8
        Top = 16
        Width = 121
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Produto: '
        FocusControl = eFk_Produtos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object eFk_Produtos: TComboBox
        Left = 136
        Top = 16
        Width = 250
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 0
        TabOrder = 0
        OnSelect = ChangeGlobal
      end
      object bbModify: TBitBtn
        Left = 144
        Top = 88
        Width = 98
        Height = 25
        Anchors = [akLeft, akRight]
        Caption = 'Inserir'
        Enabled = False
        TabOrder = 2
      end
      object bbCancel: TBitBtn
        Left = 297
        Top = 88
        Width = 81
        Height = 25
        Anchors = [akRight]
        Caption = 'Cancelar'
        Enabled = False
        TabOrder = 3
      end
    end
  end
end
