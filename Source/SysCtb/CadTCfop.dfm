inherited CdTipoCfop: TCdTipoCfop
  Caption = 'CdTipoCfop'
  ClientHeight = 194
  ClientWidth = 396
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lPk_Tipo_Cfop: TStaticText
    Left = 8
    Top = 56
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Cfop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object lDsc_Tmrc: TStaticText
    Left = 8
    Top = 120
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Tmrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object eDsc_Tmrc: TEdit
    Left = 136
    Top = 120
    Width = 257
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object ePk_Tipo_Cfop: TCurrencyEdit
    Left = 136
    Top = 56
    Width = 121
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akRight]
    TabOrder = 3
    OnChange = ChangeGlobal
  end
end
