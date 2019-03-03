inherited CdMunicipios: TCdMunicipios
  Caption = 'CdMunicipios'
  ClientHeight = 398
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 15
    Top = 8
    Width = 426
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 23
    Top = 14
    Width = 410
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Munic'#237'pios'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object sbNewRegion: TSpeedButton
    Left = 424
    Top = 183
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
    OnClick = sbNewRegionClick
  end
  object lPk_Municipios: TStaticText
    Left = 8
    Top = 56
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Municipios
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Municipios: TEdit
    Left = 168
    Top = 56
    Width = 95
    Height = 21
    Anchors = [akLeft, akRight]
    Enabled = False
    TabOrder = 1
  end
  object eDsc_Mun: TEdit
    Left = 168
    Top = 88
    Width = 273
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object lDsc_Mun: TStaticText
    Left = 8
    Top = 88
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '* Descri'#231#227'o: '
    FocusControl = eDsc_Mun
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object lCep_Mun: TStaticText
    Left = 8
    Top = 120
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C.E.P.: '
    FocusControl = eCep_Mun
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eCep_Mun: TCurrencyEdit
    Left = 168
    Top = 120
    Width = 95
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0;-,0'
    Anchors = [akLeft, akRight]
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 152
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Al'#237'quota de ISS: '
    FocusControl = eAlq_Iss
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eAlq_Iss: TCurrencyEdit
    Left = 168
    Top = 152
    Width = 95
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    Anchors = [akLeft, akRight]
    TabOrder = 7
    OnChange = ChangeGlobal
  end
  object eFk_Cargas_Regioes: TComboBox
    Left = 168
    Top = 184
    Width = 257
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    ItemHeight = 13
    TabOrder = 8
    OnSelect = ChangeGlobal
  end
  object lFk_Cargas_Regioes: TStaticText
    Left = 8
    Top = 184
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Regi'#245'es: '
    FocusControl = eFk_Cargas_Regioes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object lFlag_Cap: TCheckBox
    Left = 168
    Top = 216
    Width = 281
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Munic'#237'pio pertence a Capital'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = ChangeGlobal
  end
  object vtPrinters: TVirtualStringTree
    Left = 8
    Top = 240
    Width = 439
    Height = 153
    Anchors = [akLeft, akRight, akBottom]
    Colors.FocusedSelectionColor = clSilver
    EditDelay = 0
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    SelectionCurveRadius = 10
    TabOrder = 11
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.SelectionOptions = [toExtendedFocus]
    OnEditing = vtPrintersEditing
    OnGetText = vtPrintersGetText
    OnNewText = vtPrintersNewText
    Columns = <
      item
        Position = 0
        Width = 285
        WideText = 'Impressora Fiscal Suportadas'
      end
      item
        Position = 1
        Width = 150
        WideText = 'C'#243'digo do ISS na ECF'
      end>
  end
end
