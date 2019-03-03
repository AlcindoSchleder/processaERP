inherited CdClassFisc: TCdClassFisc
  Caption = 'CdClassFisc'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited vtList: TVirtualStringTree
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    TabOrder = 7
  end
  object lPk_Classificacao_Fiscal: TStaticText
    Left = 248
    Top = 88
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo Fiscal: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Classificacao_Fiscal: TEdit
    Left = 376
    Top = 88
    Width = 113
    Height = 21
    Anchors = [akLeft, akRight]
    TabOrder = 4
  end
  object lDsc_ClsF: TStaticText
    Left = 248
    Top = 160
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_ClsF
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eDsc_ClsF: TEdit
    Left = 375
    Top = 160
    Width = 266
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 6
  end
end
