inherited CdUnidades: TCdUnidades
  Left = 265
  Top = 157
  Height = 477
  Caption = 'CdUnidades'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 397
  end
  inherited sbStatus: TStatusBar
    Top = 430
  end
  inherited vtList: TVirtualStringTree
    Height = 397
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 397
    TabOrder = 18
  end
  object lPk_Unidades: TStaticText
    Left = 248
    Top = 64
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Unidades
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Unidades: TEdit
    Left = 376
    Top = 64
    Width = 65
    Height = 21
    Anchors = [akRight]
    CharCase = ecUpperCase
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Text = '0'
  end
  object lMnmo_Uni: TStaticText
    Left = 448
    Top = 64
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Sigla: '
    FocusControl = eMnmo_Uni
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eMnmo_Uni: TEdit
    Left = 576
    Top = 64
    Width = 65
    Height = 21
    Anchors = [akRight]
    CharCase = ecUpperCase
    TabOrder = 6
    OnChange = ChangeGlobal
  end
  object eFlag_FUni: TComboBox
    Left = 376
    Top = 104
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = []
    ItemHeight = 13
    TabOrder = 7
    OnSelect = eFlag_FUniSelect
  end
  object lFlag_FUni: TStaticText
    Left = 248
    Top = 104
    Width = 123
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Fam'#237'lia: '
    FocusControl = eFlag_FUni
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object lFlag_TUni: TStaticText
    Left = 248
    Top = 144
    Width = 123
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tipo da Unidade: '
    FocusControl = eFlag_TUni
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eFlag_TUni: TComboBox
    Left = 376
    Top = 144
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akRight]
    ItemHeight = 13
    TabOrder = 10
    OnSelect = ChangeGlobal
  end
  object eDsc_Uni: TEdit
    Left = 376
    Top = 184
    Width = 265
    Height = 21
    Anchors = [akRight]
    CharCase = ecUpperCase
    TabOrder = 11
    OnChange = ChangeGlobal
  end
  object lDsc_Uni: TStaticText
    Left = 248
    Top = 184
    Width = 123
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Uni
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object lFlag_Frac: TCheckBox
    Left = 376
    Top = 224
    Width = 265
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Permite Quantidades Fracionadas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnClick = ChangeGlobal
  end
  object lFlag_Qtd: TCheckBox
    Left = 376
    Top = 256
    Width = 265
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Usar Campo Quantidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    OnClick = ChangeGlobal
  end
  object lFlag_Comp: TCheckBox
    Left = 376
    Top = 288
    Width = 265
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Usar Campo Comprimento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    OnClick = ChangeGlobal
  end
  object lFlag_Larg: TCheckBox
    Left = 376
    Top = 320
    Width = 265
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Usar Campo Largura'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
    OnClick = ChangeGlobal
  end
  object lFlag_Alt: TCheckBox
    Left = 376
    Top = 352
    Width = 265
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Usar Campo Altura'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
    OnClick = ChangeGlobal
  end
end
