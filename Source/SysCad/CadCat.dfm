inherited CdCategoria: TCdCategoria
  Height = 399
  Caption = 'CdCategoria'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 319
  end
  inherited sbStatus: TStatusBar
    Top = 352
  end
  inherited vtList: TVirtualStringTree
    Height = 319
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 319
    TabOrder = 12
  end
  object lPk_Categorias: TStaticText
    Left = 256
    Top = 72
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Categorias
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Categorias: TEdit
    Left = 384
    Top = 72
    Width = 113
    Height = 21
    Anchors = [akLeft, akRight]
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Text = '0'
  end
  object eDsc_Cat: TEdit
    Left = 384
    Top = 112
    Width = 257
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lDsc_Cat: TStaticText
    Left = 256
    Top = 112
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Cat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lFlag_Cat: TRadioGroup
    Left = 256
    Top = 232
    Width = 377
    Height = 81
    Anchors = [akLeft, akRight]
    Caption = 'Tipo da Categoria'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Clientes'
      'Fornecedores'
      'Funcion'#225'rios'
      'Representantes'
      'Agentes'
      'Outros')
    ParentFont = False
    TabOrder = 7
    TabStop = True
    OnClick = lFlag_CatClick
  end
  object lFk_Financeiro_Contas: TStaticText
    Left = 256
    Top = 152
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Conta Financeiro: '
    FocusControl = eFk_Financeiro_Contas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object eFk_Financeiro_Contas: TComboBox
    Left = 384
    Top = 152
    Width = 257
    Height = 22
    Style = csOwnerDrawFixed
    Anchors = [akLeft, akRight]
    ItemHeight = 16
    TabOrder = 9
    OnDrawItem = eFk_Financeiro_ContasDrawItem
    OnSelect = eFk_Financeiro_ContasSelect
  end
  object lFk_Financeiro_Contas_Acm: TStaticText
    Left = 256
    Top = 192
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Conta Carteira: '
    FocusControl = eFk_Financeiro_Contas_Acm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object eFk_Financeiro_Contas_Acm: TComboBox
    Left = 384
    Top = 192
    Width = 257
    Height = 22
    Style = csOwnerDrawFixed
    Anchors = [akLeft, akRight]
    ItemHeight = 16
    TabOrder = 11
    OnDrawItem = eFk_Financeiro_ContasDrawItem
    OnSelect = eFk_Financeiro_ContasSelect
  end
end
