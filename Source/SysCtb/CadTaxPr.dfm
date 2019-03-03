inherited CdTaxPrinter: TCdTaxPrinter
  Left = 551
  Top = 254
  Caption = 'CdTaxPrinter'
  ClientHeight = 205
  ClientWidth = 396
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 0
    Top = 0
    Width = 396
    Height = 25
    Align = alTop
  end
  object lTitle: TLabel
    Left = 3
    Top = 5
    Width = 390
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'C'#243'digo da Al'#237'quota na Impressora Fiscal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lFk_Suported_Printers: TStaticText
    Left = 8
    Top = 56
    Width = 153
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Impressora Fiscal: '
    FocusControl = eFk_Suported_Printers
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object eFk_Suported_Printers: TComboBox
    Left = 168
    Top = 56
    Width = 217
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 1
    OnSelect = ChangeGlobal
  end
  object lCod_Alqt_Cnsf: TStaticText
    Left = 8
    Top = 96
    Width = 153
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Al'#237'q. Consumidor Final: '
    FocusControl = eCod_Alqt_Cnsf
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object eCod_Alqt_Cnsf: TCurrencyEdit
    Left = 168
    Top = 96
    Width = 105
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0;- ,0'
    Anchors = [akLeft, akRight]
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lCod_Alqt: TStaticText
    Left = 8
    Top = 136
    Width = 153
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Al'#237'quota para Revendas: '
    FocusControl = eCod_Alqt
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eCod_Alqt: TCurrencyEdit
    Left = 168
    Top = 136
    Width = 105
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0;- ,0'
    Anchors = [akLeft, akRight]
    TabOrder = 5
    OnChange = ChangeGlobal
  end
end
