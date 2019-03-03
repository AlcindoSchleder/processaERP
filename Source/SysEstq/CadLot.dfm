inherited CdLotacao: TCdLotacao
  Left = 328
  Top = 171
  Anchors = [akLeft]
  Caption = 'CdLotacao'
  ClientHeight = 176
  ClientWidth = 396
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lNivel_Lot: TStaticText
    Left = 8
    Top = 112
    Width = 97
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' N'#237'vel :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object lRua_Lot: TStaticText
    Left = 8
    Top = 80
    Width = 97
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Rua :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object lBox_Lot: TStaticText
    Left = 8
    Top = 144
    Width = 97
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Box :'
    FocusControl = eBox_Lot
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eBox_Lot: TEdit
    Left = 112
    Top = 144
    Width = 81
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 10
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object lPk_Almoxarifados: TStaticText
    Left = 8
    Top = 48
    Width = 97
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
    TabOrder = 7
  end
  object ePk_Lotacoes: TCurrencyEdit
    Left = 112
    Top = 48
    Width = 81
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
  object pTitle: TPanel
    Left = 8
    Top = 8
    Width = 385
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
    TabOrder = 8
  end
  object eNivel_Lot: TEdit
    Left = 112
    Top = 112
    Width = 81
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 10
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object eRua_Lot: TEdit
    Left = 112
    Top = 80
    Width = 81
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 10
    TabOrder = 1
    OnChange = ChangeGlobal
  end
end
