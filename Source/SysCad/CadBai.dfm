inherited CdBairros: TCdBairros
  Caption = 'CdBairros'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 15
    Top = 8
    Width = 417
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 23
    Top = 14
    Width = 401
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Bairros'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lPk_Bairros: TStaticText
    Left = 8
    Top = 80
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Bairros
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Bairros: TEdit
    Left = 168
    Top = 80
    Width = 141
    Height = 21
    Anchors = [akLeft, akRight]
    Enabled = False
    TabOrder = 1
  end
  object lCep_Bai: TStaticText
    Left = 8
    Top = 192
    Width = 153
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
    TabOrder = 2
  end
  object eCep_Bai: TCurrencyEdit
    Left = 168
    Top = 192
    Width = 113
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0'
    Anchors = [akRight]
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object eDsc_Bai: TEdit
    Left = 168
    Top = 136
    Width = 271
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object lDsc_Bai: TStaticText
    Left = 8
    Top = 136
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* Descri'#231#227'o: '
    FocusControl = eDsc_Bai
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
end
