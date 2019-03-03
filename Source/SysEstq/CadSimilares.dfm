inherited CdSimilares: TCdSimilares
  Caption = 'CdSimilares'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited vtList: TVirtualStringTree
    TabOrder = 4
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  object lPk_Similares: TStaticText
    Left = 256
    Top = 64
    Width = 153
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Similares
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object ePk_Similares: TEdit
    Left = 416
    Top = 64
    Width = 97
    Height = 21
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    Text = '0'
  end
  object eDsc_Sim: TEdit
    Left = 416
    Top = 160
    Width = 225
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
    OnChange = ChangeGlobal
  end
  object lDsc_Sim: TStaticText
    Left = 256
    Top = 160
    Width = 153
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Sim
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
end
