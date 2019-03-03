inherited CdBank: TCdBank
  Left = 346
  Top = 197
  Caption = 'CdBank'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 8
    Top = 8
    Width = 273
    Height = 25
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 11
    Width = 257
    Height = 19
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lTitle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object vtAgency: TVirtualStringTree
    Left = 288
    Top = 8
    Width = 153
    Height = 241
    Anchors = [akTop, akRight, akBottom]
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clBlue
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    TabOrder = 0
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnGetText = vtAgencyGetText
    Columns = <
      item
        Position = 0
        Width = 149
        WideText = 'Ag'#234'ncias'
      end>
  end
  object pgBanks: TPageControl
    Left = 8
    Top = 40
    Width = 273
    Height = 209
    ActivePage = tsBanks
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    OnChange = pgBanksChange
    OnChanging = pgBanksChanging
    object tsBanks: TTabSheet
      Caption = 'Bancos'
      DesignSize = (
        265
        181)
      object lPk_Bancos: TStaticText
        Left = 8
        Top = 48
        Width = 81
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C'#243'digo: '
        FocusControl = ePk_Bancos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object ePk_Bancos: TCurrencyEdit
        Left = 96
        Top = 48
        Width = 81
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akRight]
        ParentFont = False
        TabOrder = 0
        OnChange = ChangeGlobal
      end
      object lDsc_Bco: TStaticText
        Left = 8
        Top = 96
        Width = 81
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Descri'#231#227'o: '
        FocusControl = eDsc_Bco
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object eDsc_Bco: TEdit
        Left = 96
        Top = 96
        Width = 161
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 1
        OnChange = ChangeGlobal
      end
    end
    object tsAgency: TTabSheet
      Caption = 'Ag'#234'ncias'
      ImageIndex = 1
      DesignSize = (
        265
        181)
      object lPk_Agencias: TStaticText
        Left = 8
        Top = 24
        Width = 89
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C'#243'digo: '
        FocusControl = ePk_Agencias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object lDsc_Age: TStaticText
        Left = 8
        Top = 64
        Width = 89
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Descri'#231#227'o: '
        FocusControl = eDsc_Age
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object eDsc_Age: TEdit
        Left = 104
        Top = 64
        Width = 153
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 2
        OnChange = ChangeGlobal
      end
      object ePk_Agencias: TEdit
        Left = 104
        Top = 24
        Width = 153
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 20
        TabOrder = 3
        OnChange = ChangeGlobal
      end
      object lFk_Cadastros: TStaticText
        Left = 8
        Top = 104
        Width = 249
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Ficha Cadastral: '
        FocusControl = eFk_Cadastros
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object eFk_Cadastros: TPrcComboBox
        Left = 8
        Top = 136
        Width = 249
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnChange = ChangeGlobal
        TabOrder = 5
        TypeObject = toInteger
      end
    end
  end
end
