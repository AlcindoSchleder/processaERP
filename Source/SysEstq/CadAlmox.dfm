inherited CdAlmox: TCdAlmox
  Left = 431
  Top = 184
  Caption = 'CdAlmox'
  ClientHeight = 176
  ClientWidth = 396
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lPk_Almoxarifados: TStaticText
    Left = 8
    Top = 40
    Width = 89
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Almox: TCurrencyEdit
    Left = 104
    Top = 40
    Width = 113
    Height = 21
    AutoSize = False
    Color = clTeal
    DecimalPlaces = 0
    DisplayFormat = ',0;- ,0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Anchors = [akLeft, akRight]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object eDsc_Almx: TEdit
    Left = 104
    Top = 72
    Width = 289
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 1
    OnChange = ChangeGlobal
  end
  object lDsc_Almx: TStaticText
    Left = 8
    Top = 72
    Width = 89
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Almx
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object lLocal_Almx: TStaticText
    Left = 8
    Top = 104
    Width = 89
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Localiza'#231#227'o: '
    FocusControl = eLocal_Almx
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eLocal_Almx: TMemo
    Left = 104
    Top = 104
    Width = 289
    Height = 65
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object pTitle: TPanel
    Left = 8
    Top = 8
    Width = 385
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    Caption = 'Cadastro de Almoxarifados'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
end
