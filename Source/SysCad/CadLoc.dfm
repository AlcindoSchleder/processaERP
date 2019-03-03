inherited CdLogradouros: TCdLogradouros
  Caption = 'CdLogradouros'
  ClientHeight = 339
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
    Caption = 'Cadastro de Logradouros'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object sbNewTAdd: TSpeedButton
    Left = 424
    Top = 103
    Width = 21
    Height = 21
    Hint = 'Criar Nova Regi'#227'o'
    Anchors = [akRight]
    Flat = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FF00004300004300003C000037000036000036FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000930000930002841518892B
      2D8C2A2A830F0F6200004000003A00003AFF00FFFF00FFFF00FFFF00FFFF00FF
      0004B30104A73D45C3B3B7EAFFFFFFFFFFFFFFFFFFFFFFFFA0A2CC2D2D740000
      3A00004EFF00FFFF00FFFF00FF0005CC0107BA7F89E2FFFFFFFFFFFF9B9CDB5E
      5EB75F5FB6ADADDDFFFFFFFFFFFF5E5E9B00003A000043FF00FFFF00FF0005CC
      6472E5FFFFFFD7DAF52427B300008300007200006800006A31319CE6E6F7FFFF
      FF36367D000043FF00FF0007E80B1BD8F8F8FFF2F3FC1621C400009F04079C89
      8FD8797BCD010275000061262695FFFFFFC3C3DB01015000004B0007E84358F0
      FFFFFF6476ED0002C40001B60407AEE8EDFDCACFF000018000006E0000668484
      C9FFFFFF27278800004B0009F37F94FAFFFFFF1932F00512E07587EA979CE8F3
      F5FDEBEDF89194DB6A6DC70202782D2E9EFFFFFF5558BE00004A0218FDA6B4FD
      FFFFFF112CFD0B20F5F7FAFFFFFFFFFFFFFFFFFFFFFFFFFFDFE0F504058B2024
      A0FFFFFF6267C30000781735FFA4B6FFFFFFFF2C4AFF000FFF142FF82B3EEDE6
      EBFDD2D7F7232DCA121EB9000093464DBEFFFFFF4A4EBD00007F0318FF91A6FF
      FFFFFFA9B9FF000EFF0008FF0515F8EBF0FFCFD5F70108C70001B30206AEC3C7
      EFFCFCFD1017AA00007FFF00FF5F7AFFFFFFFFFFFFFF5C75FF000BFF000EFF1E
      3BFF1A35F30007DB0006CC7684E8FFFFFF8F97E2000198FF00FFFF00FF425FFF
      C4CFFFFFFFFFFFFFFF8B9FFF162FFF0414FF0515FD2037F39FADF7FFFFFFE2E5
      FA101ABA000198FF00FFFF00FFFF00FF5975FFD7DFFFFFFFFFFFFFFFFCFCFFD1
      DBFFD4DFFFFFFFFFFFFFFFC6CDF71825CD0001B0FF00FFFF00FFFF00FFFF00FF
      FF00FF5C76FF97A9FDDAE0FFFFFFFFFFFFFFFFFFFFD4DBFD596FF00514D70001
      B0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5C75FF5C79FF62
      7DFF4A66FD203CF50619E5FF00FFFF00FFFF00FFFF00FFFF00FF}
    OnClick = sbNewTAddClick
  end
  object lPk_Logradouros: TStaticText
    Left = 8
    Top = 72
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Logradouros
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Logradouros: TEdit
    Left = 168
    Top = 72
    Width = 113
    Height = 21
    Anchors = [akLeft, akRight]
    Enabled = False
    TabOrder = 1
  end
  object lCep_Loc: TStaticText
    Left = 8
    Top = 168
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* C.E.P.: '
    FocusControl = eCep_Loc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eCep_Loc: TCurrencyEdit
    Left = 168
    Top = 168
    Width = 113
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0'
    Anchors = [akRight]
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object eDsc_Loc: TEdit
    Left = 168
    Top = 136
    Width = 279
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object lDsc_Loc: TStaticText
    Left = 8
    Top = 136
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* Descri'#231#227'o: '
    FocusControl = eDsc_Loc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object lFk_Tipo_Enderecos: TStaticText
    Left = 8
    Top = 104
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* Tipo de Endere'#231'o: '
    FocusControl = eFk_Tipo_Enderecos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eFk_Tipo_Enderecos: TComboBox
    Left = 168
    Top = 104
    Width = 257
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    ItemHeight = 13
    TabOrder = 7
    OnSelect = ChangeGlobal
  end
  object lNum_Ini: TStaticText
    Left = 8
    Top = 200
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* N'#250'mero Inicial: '
    FocusControl = eNum_Ini
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object eNum_Ini: TCurrencyEdit
    Left = 168
    Top = 200
    Width = 113
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0'
    Anchors = [akLeft, akRight]
    TabOrder = 9
    OnChange = ChangeGlobal
  end
  object lNum_Fin: TStaticText
    Left = 8
    Top = 232
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* N'#250'mero Final: '
    FocusControl = eNum_Fin
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object eNum_Fin: TCurrencyEdit
    Left = 168
    Top = 232
    Width = 113
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0'
    Anchors = [akRight]
    TabOrder = 11
    OnChange = ChangeGlobal
  end
  object lFlag_Lado: TRadioGroup
    Left = 8
    Top = 264
    Width = 441
    Height = 41
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Lado da Rua: '
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Direito'
      'Esquerdo')
    ParentFont = False
    TabOrder = 12
    OnClick = ChangeGlobal
  end
end
