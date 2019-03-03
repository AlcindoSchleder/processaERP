inherited frmModules: TfrmModules
  Left = 424
  Top = 120
  Caption = 'frmModules'
  ClientHeight = 462
  ClientWidth = 385
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object stTitle: TLabel
    Left = 8
    Top = 24
    Width = 369
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Dados do M'#243'dulo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object lPk_Modulos: TStaticText
    Left = 8
    Top = 128
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Modulos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object lDsc_Mod: TStaticText
    Left = 8
    Top = 176
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Mod
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object eDsc_Mod: TEdit
    Left = 128
    Top = 176
    Width = 249
    Height = 21
    Anchors = [akLeft, akRight]
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object lVer_1: TStaticText
    Left = 8
    Top = 224
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Vers'#227'o Maior: '
    FocusControl = eVer_1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object eVer_1: TCurrencyEdit
    Left = 128
    Top = 224
    Width = 40
    Height = 21
    AutoSize = False
    CheckOnExit = True
    Ctl3D = True
    DecimalPlaces = 0
    DisplayFormat = ',0;-,0'
    Anchors = [akLeft, akRight]
    ParentCtl3D = False
    TabOrder = 4
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object lVer_2: TStaticText
    Left = 8
    Top = 272
    Width = 112
    Height = 21
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Vers'#227'o Menor: '
    FocusControl = eVer_2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eVer_2: TCurrencyEdit
    Left = 128
    Top = 272
    Width = 41
    Height = 21
    AutoSize = False
    CheckOnExit = True
    Ctl3D = True
    DecimalPlaces = 0
    DisplayFormat = ',0;-,0'
    Anchors = [akRight]
    ParentCtl3D = False
    TabOrder = 6
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object lVer_3: TStaticText
    Left = 216
    Top = 224
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Construtor: '
    FocusControl = eVer_3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eVer_3: TCurrencyEdit
    Left = 336
    Top = 224
    Width = 41
    Height = 21
    AutoSize = False
    CheckOnExit = True
    Ctl3D = True
    DecimalPlaces = 0
    DisplayFormat = ',0;-,0'
    Anchors = [akRight]
    ParentCtl3D = False
    TabOrder = 8
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object lVer_4: TStaticText
    Left = 216
    Top = 272
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Compila'#231#227'o: '
    FocusControl = eVer_4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eVer_4: TCurrencyEdit
    Left = 336
    Top = 272
    Width = 41
    Height = 21
    AutoSize = False
    CheckOnExit = True
    Ctl3D = True
    DecimalPlaces = 0
    DisplayFormat = ',0;-,0'
    Anchors = [akRight]
    ParentCtl3D = False
    TabOrder = 10
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object eVersao: TEdit
    Left = 128
    Top = 320
    Width = 128
    Height = 21
    Anchors = [akLeft, akRight]
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 11
    OnChange = ChangeGlobal
  end
  object lVersao: TStaticText
    Left = 8
    Top = 320
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Vers'#227'o'
    FocusControl = eVersao
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object ePk_Modulos: TCurrencyEdit
    Left = 128
    Top = 128
    Width = 89
    Height = 21
    AutoSize = False
    CheckOnExit = True
    Ctl3D = True
    DecimalPlaces = 0
    DisplayFormat = ',0;-,0'
    Anchors = [akLeft, akRight]
    ParentCtl3D = False
    TabOrder = 13
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
end
