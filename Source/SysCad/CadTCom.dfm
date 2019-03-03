inherited CdTypeCom: TCdTypeCom
  Height = 560
  Caption = 'CdTypeCom'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 248
    Top = 48
    Width = 392
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 256
    Top = 54
    Width = 376
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Tipos de Comiss'#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited spSplitter: TSplitter
    Height = 480
  end
  inherited sbStatus: TStatusBar
    Top = 513
  end
  inherited vtList: TVirtualStringTree
    Height = 480
    TabOrder = 9
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 480
    TabOrder = 15
  end
  object lPk_Tipo_Comisoes: TStaticText
    Left = 256
    Top = 104
    Width = 113
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Comisoes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object ePk_Tipo_Comisoes: TEdit
    Left = 376
    Top = 104
    Width = 49
    Height = 21
    Anchors = [akLeft, akTop, akRight]
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
  object eDsc_TCom: TEdit
    Left = 376
    Top = 136
    Width = 265
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object lDsc_TCom: TStaticText
    Left = 256
    Top = 136
    Width = 113
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TCom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object lFk_Financeiro_Contas__CR: TStaticText
    Left = 256
    Top = 200
    Width = 113
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Conta de Cr'#233'dito: '
    FocusControl = eFk_Financeiro_Contas__CR
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object eFk_Financeiro_Contas__CR: TComboBox
    Left = 376
    Top = 200
    Width = 265
    Height = 22
    Style = csOwnerDrawFixed
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 16
    TabOrder = 4
    OnDrawItem = TreeComboDrawItem
    OnSelect = eFk_Financeiro_Contas__CRSelect
  end
  object lPerc_Com: TStaticText
    Left = 256
    Top = 232
    Width = 113
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Percentual: '
    FocusControl = ePerc_Com
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object ePerc_Com: TCurrencyEdit
    Left = 376
    Top = 232
    Width = 113
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00 %'
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 99.990000000000000000
    MinValue = 0.010000000000000000
    TabOrder = 6
    Value = 0.010000000000000000
    OnChange = ChangeGlobal
  end
  object vtRanges: TVirtualStringTree
    Left = 256
    Top = 264
    Width = 385
    Height = 233
    Anchors = [akLeft, akTop, akRight, akBottom]
    Colors.FocusedSelectionColor = clSilver
    Header.AutoSizeIndex = 2
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    IncrementalSearch = isVisibleOnly
    SelectionCurveRadius = 10
    TabOrder = 7
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus]
    OnBeforeItemErase = vtRangesBeforeItemErase
    OnChecked = vtRangesChecked
    OnChecking = vtRangesChecking
    OnEditing = vtRangesEditing
    OnFocusChanging = vtRangesFocusChanging
    OnGetText = vtRangesGetText
    OnGetNodeDataSize = vtRangesGetNodeDataSize
    OnInitNode = vtRangesInitNode
    OnKeyDown = vtRangesKeyDown
    OnNewText = vtRangesNewText
    Columns = <
      item
        Position = 0
        Width = 150
        WideText = 'Valor Inicial'
      end
      item
        Position = 1
        Width = 115
        WideText = 'Valor Final'
      end
      item
        Position = 2
        Width = 116
        WideText = '% Redu'#231#227'o'
      end>
  end
  object eFk_Financeiro_Contas__DB: TComboBox
    Left = 376
    Top = 168
    Width = 265
    Height = 22
    Style = csOwnerDrawFixed
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 16
    TabOrder = 3
    OnDrawItem = TreeComboDrawItem
    OnSelect = eFk_Financeiro_Contas__DBSelect
  end
  object lFk_Financeiro_Contas__DB: TStaticText
    Left = 256
    Top = 168
    Width = 113
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Conta de D'#233'bito:'
    FocusControl = eFk_Financeiro_Contas__DB
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object lFlagTCad: TRadioGroup
    Left = 432
    Top = 88
    Width = 209
    Height = 41
    Caption = 'Tipo de Comiss'#227'o para:'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Representantes'
      'Vendedores')
    TabOrder = 1
  end
end
