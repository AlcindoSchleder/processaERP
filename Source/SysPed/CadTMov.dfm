inherited CdTypeMovim: TCdTypeMovim
  Left = 338
  Top = 149
  Caption = 'CdTypeMovim'
  ClientHeight = 298
  ClientWidth = 540
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pTitle: TPanel
    Left = 8
    Top = 8
    Width = 521
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    Caption = 'pTitle'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object lFlag_Exp: TCheckBox
    Left = 136
    Top = 240
    Width = 393
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Movimenta'#231#227'o de exporta'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ChangeGlobal
  end
  object lFlag_Ldv: TCheckBox
    Tag = 1
    Left = 136
    Top = 216
    Width = 393
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Liberar digita'#231#227'o do Valor do '#237'tem'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ChangeGlobal
  end
  object eNat_Ope_Ex: TComboBox
    Tag = 1
    Left = 136
    Top = 176
    Width = 393
    Height = 21
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 3
    OnSelect = ChangeGlobal
  end
  object lNat_Ope_Ex: TStaticText
    Left = 8
    Top = 176
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Nat. Oper. Export.: '
    FocusControl = eNat_Ope_Ex
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object lNat_Ope_Fe: TStaticText
    Left = 8
    Top = 144
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Nat. Oper. Externa: '
    FocusControl = eNat_Ope_Fe
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eNat_Ope_Fe: TComboBox
    Tag = 1
    Left = 136
    Top = 144
    Width = 393
    Height = 21
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 6
    OnSelect = ChangeGlobal
  end
  object eNat_Ope_De: TComboBox
    Tag = 1
    Left = 136
    Top = 112
    Width = 393
    Height = 21
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 7
    OnSelect = ChangeGlobal
  end
  object lNat_Ope_De: TStaticText
    Left = 8
    Top = 112
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Nat. Oper. Interna: '
    FocusControl = eNat_Ope_De
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object eDsc_TMov: TEdit
    Tag = 1
    Left = 136
    Top = 80
    Width = 393
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 9
    OnChange = ChangeGlobal
  end
  object lDsc_TMov: TStaticText
    Left = 8
    Top = 80
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TMov
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object ePk_Tipo_Movimentos: TEdit
    Tag = 1
    Left = 136
    Top = 48
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
    TabOrder = 11
    Text = '0'
  end
  object lPk_Tipo_Movimentos: TStaticText
    Left = 8
    Top = 48
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Movimentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object lFlag_Cns: TCheckBox
    Left = 136
    Top = 264
    Width = 393
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Movimenta'#231#227'o para consumidor Final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnClick = ChangeGlobal
  end
end
