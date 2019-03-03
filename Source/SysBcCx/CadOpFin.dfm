object CdOperFin: TCdOperFin
  Left = 213
  Top = 175
  Width = 661
  Height = 487
  Caption = 'CdOperFin'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  DesignSize = (
    653
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 653
    Height = 33
    Bands = <
      item
        Control = tbTools
        ImageIndex = 91
        Text = 'Ferramentas'
        Width = 649
      end>
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 572
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 60
      Caption = 'tbTools'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbInsert: TToolButton
        Left = 0
        Top = 0
        Caption = '&Inserir'
        ImageIndex = 34
        OnClick = tbInsertClick
      end
      object tbCancel: TToolButton
        Left = 60
        Top = 0
        Caption = '&Cancelar'
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbDelete: TToolButton
        Left = 120
        Top = 0
        Caption = '&Excluir'
        ImageIndex = 33
        OnClick = tbDeleteClick
      end
      object tbSepTools: TToolButton
        Left = 180
        Top = 0
        Width = 8
        Caption = 'tbSepTools'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 188
        Top = 0
        Caption = '&Salvar'
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object tbSepFile: TToolButton
        Left = 248
        Top = 0
        Width = 8
        Caption = 'tbSepFile'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 256
        Top = 0
        Caption = 'Sai&r'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
    end
  end
  object vtOperations: TVirtualStringTree
    Left = 0
    Top = 33
    Width = 249
    Height = 401
    Align = alLeft
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clBlue
    Header.Font.Height = -13
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = [fsBold]
    Header.Height = 25
    Header.Options = [hoAutoResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
    OnFocusChanged = vtOperationsFocusChanged
    OnFocusChanging = vtOperationsFocusChanging
    OnGetText = vtOperationsGetText
    Columns = <
      item
        Position = 0
        Width = 245
        WideText = 'Lista das Opera'#231#245'es'
      end>
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 434
    Width = 653
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Style = psOwnerDraw
        Width = 250
      end
      item
        Style = psOwnerDraw
        Width = 100
      end>
    OnClick = sbStatusClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
  object lPk_Operacoes_Financeiras: TStaticText
    Left = 264
    Top = 48
    Width = 161
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo da Opera'#231#227'o: '
    FocusControl = ePk_Operacoes_Financeiras
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Operacoes_Financeiras: TCurrencyEdit
    Left = 432
    Top = 48
    Width = 73
    Height = 21
    AutoSize = False
    Color = clTeal
    DecimalPlaces = 0
    DisplayFormat = ',0.;'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object eDsc_Ope: TEdit
    Left = 432
    Top = 72
    Width = 217
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lDsc_Ope: TStaticText
    Left = 264
    Top = 72
    Width = 161
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o da Opera'#231#227'o: '
    FocusControl = eDsc_Ope
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object vtDocuments: TVirtualStringTree
    Left = 264
    Top = 224
    Width = 381
    Height = 206
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clBlue
    Header.Font.Height = -13
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = [fsBold]
    Header.Height = 25
    Header.Options = [hoAutoResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    SelectionCurveRadius = 10
    TabOrder = 7
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toHotTrack, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
    OnAfterCellPaint = vtDocumentsBeforeCellPaint
    OnBeforeCellPaint = vtDocumentsBeforeCellPaint
    OnChecked = vtDocumentsChecked
    OnColumnClick = vtDocumentsColumnClick
    OnGetText = vtDocumentsGetText
    OnHotChange = vtDocumentsHotChange
    OnInitNode = vtDocumentsInitNode
    OnKeyDown = vtDocumentsKeyDown
    Columns = <
      item
        Position = 0
        Width = 297
        WideText = 'Tipos de Documentos'
      end
      item
        Alignment = taCenter
        Position = 1
        Style = vsOwnerDraw
        Width = 80
        WideText = 'Padr'#227'o'
      end>
  end
end
