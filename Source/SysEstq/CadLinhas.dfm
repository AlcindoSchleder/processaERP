inherited CdLines: TCdLines
  Left = 227
  Top = 195
  Height = 435
  Caption = 'CdLines'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape [0]
    Left = 248
    Top = 40
    Width = 401
    Height = 41
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 256
    Top = 48
    Width = 385
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = 'Tabela de Linhas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited spSplitter: TSplitter
    Height = 355
  end
  inherited sbStatus: TStatusBar
    Top = 388
  end
  inherited vtList: TVirtualStringTree
    Height = 355
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 355
    TabOrder = 9
  end
  object lPk_Linhas: TStaticText
    Left = 248
    Top = 128
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Linhas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Linhas: TEdit
    Left = 408
    Top = 128
    Width = 113
    Height = 21
    Anchors = [akLeft, akRight]
    Color = 8421440
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object eDsc_Lin: TEdit
    Left = 408
    Top = 208
    Width = 241
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lDsc_Lin: TStaticText
    Left = 248
    Top = 208
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Lin
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lFk_Tipo_Comissao: TStaticText
    Left = 248
    Top = 296
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Comiss'#227'o: '
    FocusControl = eFk_Tipo_Comissao
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eFk_Tipo_Comissao: TComboBox
    Left = 408
    Top = 296
    Width = 241
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 8
  end
end
