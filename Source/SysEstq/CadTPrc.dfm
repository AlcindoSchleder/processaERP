inherited CdTablePrice: TCdTablePrice
  Caption = 'CdTablePrice'
  ClientHeight = 260
  ClientWidth = 390
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 8
    Top = 8
    Width = 377
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 14
    Width = 361
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Tabelas de Pre'#231'os'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lPk_Tabela_Precos: TStaticText
    Left = 8
    Top = 56
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tabela_Precos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object ePk_Tabela_Precos: TEdit
    Left = 136
    Top = 56
    Width = 121
    Height = 21
    Anchors = [akLeft, akRight]
    Enabled = False
    TabOrder = 0
  end
  object lDsc_Tab: TStaticText
    Left = 8
    Top = 96
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o'
    FocusControl = eDsc_Tab
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eDsc_Tab: TEdit
    Left = 136
    Top = 96
    Width = 249
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object lDta_Ini: TStaticText
    Left = 8
    Top = 136
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'In'#237'cio: '
    FocusControl = eDta_Ini
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object eDta_Ini: TDateEdit
    Left = 136
    Top = 136
    Width = 121
    Height = 21
    Anchors = [akLeft, akRight]
    NumGlyphs = 2
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lDta_Fin: TStaticText
    Left = 8
    Top = 176
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Fim: '
    FocusControl = eDta_Fin
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eDta_Fin: TDateEdit
    Left = 136
    Top = 176
    Width = 121
    Height = 21
    Anchors = [akLeft, akRight]
    NumGlyphs = 2
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object lPerc_Dsct: TStaticText
    Left = 8
    Top = 215
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Perc. Desconto: '
    FocusControl = ePerc_Dsct
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object ePerc_Dsct: TCurrencyEdit
    Left = 136
    Top = 215
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00 %;-,0.00 %'
    Anchors = [akLeft, akRight]
    TabOrder = 5
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object lFlag_Def: TCheckBox
    Left = 272
    Top = 56
    Width = 113
    Height = 17
    Caption = 'Tabela Padr'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = lFlag_DefClick
  end
end
