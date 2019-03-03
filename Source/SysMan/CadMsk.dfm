inherited CdMasks: TCdMasks
  Height = 389
  Caption = 'CdMasks'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 309
  end
  inherited sbStatus: TStatusBar
    Top = 342
  end
  inherited vtList: TVirtualStringTree
    Height = 309
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 309
    TabOrder = 11
  end
  object eMsk_Msk: TEdit
    Left = 400
    Top = 200
    Width = 241
    Height = 21
    Anchors = [akLeft, akRight]
    MaxLength = 30
    TabOrder = 3
    OnChange = eMsk_MskChange
  end
  object lMsk_Msk: TStaticText
    Left = 248
    Top = 200
    Width = 145
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'M'#225'scara: '
    FocusControl = eMsk_Msk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eDsc_Msk: TEdit
    Left = 400
    Top = 144
    Width = 241
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lDsc_Msk: TStaticText
    Left = 248
    Top = 144
    Width = 145
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Msk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lPk_Mascaras: TStaticText
    Left = 248
    Top = 80
    Width = 145
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Mascaras
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object ePk_Mascaras: TEdit
    Left = 400
    Top = 80
    Width = 81
    Height = 21
    Anchors = [akLeft, akRight]
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    Text = '0'
  end
  object lTest: TStaticText
    Left = 248
    Top = 264
    Width = 145
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = #193'rea de Teste: '
    FocusControl = eMsk_Msk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eTest: TMaskEdit
    Left = 400
    Top = 264
    Width = 241
    Height = 21
    TabOrder = 10
  end
end
