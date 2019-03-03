inherited CdDelivery: TCdDelivery
  Caption = 'CdDelivery'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited vtList: TVirtualStringTree
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    TabOrder = 9
  end
  object lPk_Tipo_Prazo_Entrega: TStaticText
    Left = 248
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Prazo_Entrega
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object eDsc_PrzE: TEdit
    Left = 376
    Top = 128
    Width = 265
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object lDsc_PrzE: TStaticText
    Left = 248
    Top = 128
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_PrzE
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object lQtd_Prv: TStaticText
    Left = 248
    Top = 184
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Dias Previstos: '
    FocusControl = eQtd_Prv
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eQtd_Prv: TCurrencyEdit
    Left = 376
    Top = 184
    Width = 81
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    TabOrder = 7
    OnChange = ChangeGlobal
  end
  object ePk_Tipo_Prazo_Entrega: TCurrencyEdit
    Left = 376
    Top = 72
    Width = 81
    Height = 21
    AutoSize = False
    Color = clTeal
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
  end
end
