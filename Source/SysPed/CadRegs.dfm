inherited CdRegioes: TCdRegioes
  Height = 399
  Caption = 'CdRegioes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited sbStatus: TStatusBar
    Top = 346
  end
  inherited vtList: TVirtualStringTree
    Height = 313
  end
  object lPk_Regioes_Dsct: TStaticText
    Left = 248
    Top = 40
    Width = 121
    Height = 21
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Regioes_Dsct
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Regioes_Dsct: TEdit
    Left = 376
    Top = 40
    Width = 81
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object lDsct_Max: TStaticText
    Left = 464
    Top = 40
    Width = 89
    Height = 21
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Desc. Max.:'
    FocusControl = eDsct_Max
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eDsct_Max: TCurrencyEdit
    Left = 560
    Top = 40
    Width = 89
    Height = 21
    AutoSize = False
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object eFk_Paises: TComboBox
    Left = 376
    Top = 64
    Width = 273
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 7
  end
  object lFk_Paises: TStaticText
    Left = 248
    Top = 64
    Width = 121
    Height = 21
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Pa'#237's: '
    FocusControl = eFk_Paises
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object lDsc_RegD: TStaticText
    Left = 248
    Top = 88
    Width = 121
    Height = 21
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_RegD
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eDsc_RegD: TEdit
    Left = 376
    Top = 88
    Width = 273
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    TabOrder = 10
  end
  object vtStates: TVirtualStringTree
    Left = 248
    Top = 112
    Width = 401
    Height = 230
    Anchors = [akLeft, akTop, akRight, akBottom]
    CheckImageKind = ckXP
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsFlatButtons
    HintAnimation = hatNone
    Images = Dados.Image16
    StateImages = Dados.Image16
    TabOrder = 11
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus]
    OnChecking = vtStatesChecking
    OnGetText = vtStatesGetText
    OnInitNode = vtStatesInitNode
    Columns = <
      item
        ImageIndex = 59
        Position = 0
        Width = 397
        WideText = 'Estados'
      end>
  end
end
