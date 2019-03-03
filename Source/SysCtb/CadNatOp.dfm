inherited CdNatOper: TCdNatOper
  Caption = 'CdNatOper'
  ClientHeight = 194
  ClientWidth = 396
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lPk_Natureza_Operacoes: TStaticText
    Left = 8
    Top = 16
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Natureza_Operacoes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Natureza_Operacoes: TEdit
    Left = 136
    Top = 16
    Width = 49
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
    TabOrder = 1
    Text = '0'
  end
  object lDsc_NtOp: TStaticText
    Left = 8
    Top = 64
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_NtOp
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eDsc_NtOp: TEdit
    Left = 136
    Top = 64
    Width = 257
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 50
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lCod_Cfop: TStaticText
    Left = 8
    Top = 112
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'CFOP: '
    FocusControl = eCod_Cfop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eCod_Cfop: TEdit
    Left = 136
    Top = 112
    Width = 73
    Height = 21
    Anchors = [akLeft, akRight]
    MaxLength = 5
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lCmpl_Cfop: TStaticText
    Left = 216
    Top = 112
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Complemento: '
    FocusControl = eCmpl_Cfop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eCmpl_Cfop: TEdit
    Left = 344
    Top = 112
    Width = 49
    Height = 21
    Anchors = [akRight]
    MaxLength = 3
    TabOrder = 7
    OnChange = ChangeGlobal
  end
  object lFk_Financeiro_Contas: TStaticText
    Left = 8
    Top = 160
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Financeiro: '
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
    Left = 136
    Top = 160
    Width = 257
    Height = 22
    Style = csOwnerDrawFixed
    Anchors = [akLeft, akRight]
    ItemHeight = 16
    TabOrder = 9
    OnDrawItem = eFk_Financeiro_ContasDrawItem
    OnSelect = ChangeGlobal
  end
end
