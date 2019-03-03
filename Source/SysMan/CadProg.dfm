inherited frmPrograms: TfrmPrograms
  Left = 354
  Top = 134
  Caption = 'frmPrograms'
  ClientHeight = 462
  ClientWidth = 386
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object stTitle: TLabel
    Left = 8
    Top = 8
    Width = 369
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Dados do Programa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object stParamTitle: TLabel
    Left = 8
    Top = 216
    Width = 369
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    Caption = 'Par'#226'metros do Programa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lPk_Programas: TStaticText
    Left = 8
    Top = 40
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo:'
    FocusControl = ePk_Programas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Programas: TEdit
    Left = 120
    Top = 40
    Width = 65
    Height = 21
    Anchors = [akLeft]
    Color = clTeal
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = ' 0'
    OnChange = ChangeGlobal
  end
  object lFlag_Vis: TCheckBox
    Left = 216
    Top = 40
    Width = 153
    Height = 17
    Anchors = [akLeft]
    Caption = 'Vis'#237'vel no menu'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ChangeGlobal
  end
  object lDsc_Prg: TStaticText
    Left = 8
    Top = 72
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o:'
    FocusControl = eDsc_Prg
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object eDsc_Prg: TEdit
    Left = 120
    Top = 72
    Width = 246
    Height = 21
    Anchors = [akLeft, akRight]
    MaxLength = 30
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object lNom_Lib: TStaticText
    Left = 8
    Top = 104
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Nome da Bibl.:'
    FocusControl = eNom_Lib
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eNom_Lib: TEdit
    Left = 120
    Top = 104
    Width = 161
    Height = 21
    Anchors = [akLeft, akRight]
    MaxLength = 20
    TabOrder = 6
    OnChange = ChangeGlobal
  end
  object lNom_Frm: TStaticText
    Left = 8
    Top = 136
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Nome do Form.:'
    FocusControl = eNom_Frm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eNom_Frm: TEdit
    Left = 120
    Top = 136
    Width = 161
    Height = 21
    Anchors = [akLeft, akRight]
    MaxLength = 20
    TabOrder = 8
    OnChange = ChangeGlobal
  end
  object lFk_Relatorios: TStaticText
    Left = 8
    Top = 168
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Relat'#243'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object vtParams: TVirtualStringTree
    Left = 0
    Top = 232
    Width = 386
    Height = 230
    Anchors = [akLeft, akRight, akBottom]
    CheckImageKind = ckXP
    Colors.FocusedSelectionColor = 6730751
    Colors.FocusedSelectionBorderColor = clBtnShadow
    Colors.GridLineColor = clSilver
    Colors.SelectionRectangleBlendColor = 6730751
    Colors.UnfocusedSelectionColor = 6730751
    EditDelay = 0
    Header.AutoSizeIndex = 2
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    HotCursor = crHandPoint
    SelectionCurveRadius = 20
    TabOrder = 10
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
    OnDblClick = vtParamsDblClick
    OnGetText = vtParamsGetText
    OnPaintText = vtParamsPaintText
    OnKeyDown = vtParamsKeyDown
    OnNewText = vtParamsNewText
    Columns = <
      item
        ImageIndex = 47
        Position = 0
        Width = 200
        WideText = 'Descri'#231#227'o'
      end
      item
        ImageIndex = 45
        Position = 1
        Width = 120
        WideText = 'Propriedade'
      end
      item
        ImageIndex = 83
        Position = 2
        Width = 62
        WideText = 'Valor'
      end>
    WideDefaultText = '...'
  end
  object lFlag_Rel: TCheckBox
    Left = 120
    Top = 192
    Width = 241
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 'Programa '#233' somente relat'#243'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = ChangeGlobal
  end
  object eFk_Relatorios: TPrcComboBox
    Left = 120
    Top = 168
    Width = 249
    Height = 21
    Anchors = [akLeft, akRight]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    OnSelect = ChangeGlobal
    TabOrder = 12
    TypeObject = toInteger
  end
end
