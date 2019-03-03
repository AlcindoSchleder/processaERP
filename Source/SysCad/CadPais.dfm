inherited CdPaises: TCdPaises
  Caption = 'CdPaises'
  ClientHeight = 247
  ClientWidth = 480
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 31
    Top = 8
    Width = 417
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 39
    Top = 14
    Width = 401
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Pa'#237'ses'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lPk_Paises: TStaticText
    Left = 8
    Top = 64
    Width = 153
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Paises
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Paises: TEdit
    Left = 168
    Top = 64
    Width = 113
    Height = 21
    Anchors = [akLeft, akRight]
    Enabled = False
    TabOrder = 1
  end
  object lDsc_Pais: TStaticText
    Left = 8
    Top = 96
    Width = 153
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* Descri'#231#227'o: '
    FocusControl = eDsc_Pais
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eDsc_Pais: TEdit
    Left = 168
    Top = 96
    Width = 305
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lFk_Linguagens: TStaticText
    Left = 8
    Top = 160
    Width = 153
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* L'#237'nguagem: '
    FocusControl = eFk_Linguagens
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eFk_Linguagens: TComboBox
    Left = 168
    Top = 160
    Width = 306
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 5
    OnSelect = ChangeGlobal
  end
  object lFk_Tipo_Moedas: TStaticText
    Left = 8
    Top = 192
    Width = 153
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* Moeda do Pa'#237's: '
    FocusControl = eFk_Tipo_Moedas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eFk_Tipo_Moedas: TComboBox
    Left = 168
    Top = 192
    Width = 306
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    ItemHeight = 13
    TabOrder = 7
    OnSelect = ChangeGlobal
  end
  object lNac_Pais: TStaticText
    Left = 8
    Top = 128
    Width = 153
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* Nacionalidade: '
    FocusControl = eNac_Pais
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object eNac_Pais: TEdit
    Left = 168
    Top = 128
    Width = 305
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 9
    OnChange = ChangeGlobal
  end
  object lFlag_Acm: TCheckBox
    Left = 168
    Top = 224
    Width = 305
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Acumular exporta'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = ChangeGlobal
  end
end
