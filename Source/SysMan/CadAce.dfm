object CdAcessos: TCdAcessos
  Left = 223
  Top = 107
  Width = 651
  Height = 550
  Caption = 'CdAcessos'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object spOpeAccess: TSplitter
    Left = 137
    Top = 41
    Width = 5
    Height = 462
    Beveled = True
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 643
    Height = 41
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        MinHeight = 33
        Text = 'Ferramentas'
        Width = 639
      end>
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 562
      Height = 33
      ButtonHeight = 19
      ButtonWidth = 60
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbSep: TToolButton
        Left = 0
        Top = 0
        Width = 8
        Caption = 'tbSep'
        ImageIndex = 42
        Style = tbsSeparator
      end
      object tbPriorMod: TToolButton
        Left = 8
        Top = 0
        Hint = 'M'#243'dulo Anterior | Seleciona o M'#243'dulo Anterior'
        Enabled = False
        ImageIndex = 31
        OnClick = tbPriorModClick
      end
      object tbPriorPrg: TToolButton
        Left = 68
        Top = 0
        Hint = 'Programa Anterior | Seleciona o programa anterior'
        Enabled = False
        ImageIndex = 30
        OnClick = tbPriorPrgClick
      end
      object tbNextPrg: TToolButton
        Left = 128
        Top = 0
        Hint = 'Pr'#243'ximo Programa | Seleciona o pr'#243'ximo programa'
        Enabled = False
        ImageIndex = 32
        OnClick = tbNextPrgClick
      end
      object tbNextMod: TToolButton
        Left = 188
        Top = 0
        Hint = 'Pr'#243'ximo M'#243'dulo | Seleciona o Pr'#243'ximo M'#243'dulo'
        Enabled = False
        ImageIndex = 29
        OnClick = tbNextModClick
      end
      object tbSepSearch: TToolButton
        Left = 248
        Top = 0
        Width = 8
        Caption = 'tbSepSearch'
        ImageIndex = 42
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 256
        Top = 0
        Hint = 'Fechar | Fecha o programa'
        Caption = 'Sai&r'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
      object ToolButton1: TToolButton
        Left = 316
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 42
        Style = tbsSeparator
      end
      object tbLegend: TToolButton
        Left = 324
        Top = 0
        Caption = 'Lengenda'
        DropdownMenu = pmLegend
        ImageIndex = 42
        Style = tbsDropDown
      end
    end
  end
  object vtOperator: TVirtualStringTree
    Left = 0
    Top = 41
    Width = 137
    Height = 462
    Align = alLeft
    CheckImageKind = ckXP
    Colors.FocusedSelectionColor = 6730751
    Colors.FocusedSelectionBorderColor = clBtnShadow
    Colors.GridLineColor = clSilver
    Colors.SelectionRectangleBlendColor = 6730751
    Colors.UnfocusedSelectionColor = 6730751
    EditDelay = 0
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clBlue
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = [fsBold]
    Header.Options = [hoAutoResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    HotCursor = crHandPoint
    SelectionCurveRadius = 20
    TabOrder = 1
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus]
    OnFocusChanged = vtOperatorFocusChanged
    OnGetText = vtOperatorGetText
    OnGetImageIndex = vtOperatorGetImageIndex
    Columns = <
      item
        ImageIndex = 84
        Options = [coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible]
        Position = 0
        Width = 133
        WideText = 'Operadores'
      end>
    WideDefaultText = ''
  end
  object pgControl: TPageControl
    Left = 142
    Top = 41
    Width = 501
    Height = 462
    ActivePage = tsAccess
    Align = alClient
    TabOrder = 2
    OnChange = pgControlChange
    object tsAccess: TTabSheet
      Caption = 'Acessos'
      object vtGrid: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 493
        Height = 434
        Align = alClient
        CheckImageKind = ckXP
        Colors.FocusedSelectionColor = 6730751
        Colors.FocusedSelectionBorderColor = clBtnShadow
        Colors.GridLineColor = clSilver
        Colors.SelectionRectangleBlendColor = 6730751
        Colors.UnfocusedSelectionColor = 6730751
        EditDelay = 0
        Header.AutoSizeIndex = 6
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clBlue
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = [fsBold]
        Header.Options = [hoAutoResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HotCursor = crHandPoint
        SelectionCurveRadius = 20
        TabOrder = 0
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
        TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        OnAfterCellPaint = vtGridBeforeCellPaint
        OnBeforeCellPaint = vtGridBeforeCellPaint
        OnChecked = vtGridChecked
        OnColumnClick = vtGridColumnClick
        OnFocusChanged = vtGridFocusChanged
        OnFocusChanging = vtGridFocusChanging
        OnGetText = vtGridGetText
        OnGetImageIndex = vtGridGetImageIndex
        OnInitNode = vtGridInitNode
        Columns = <
          item
            Alignment = taCenter
            Color = 16776176
            ImageIndex = 7
            Options = [coEnabled, coParentBidiMode, coVisible]
            Position = 0
            Width = 25
          end
          item
            Alignment = taCenter
            Color = clMoneyGreen
            ImageIndex = 90
            Options = [coEnabled, coParentBidiMode, coVisible]
            Position = 1
            Width = 25
          end
          item
            Alignment = taCenter
            Color = cl3DLight
            ImageIndex = 23
            Options = [coEnabled, coParentBidiMode, coVisible]
            Position = 2
            Width = 25
          end
          item
            Alignment = taCenter
            Color = clInfoBk
            ImageIndex = 34
            Options = [coEnabled, coParentBidiMode, coVisible]
            Position = 3
            Width = 25
          end
          item
            Alignment = taCenter
            Color = 10930928
            ImageIndex = 81
            Options = [coEnabled, coParentBidiMode, coVisible]
            Position = 4
            Width = 25
          end
          item
            Alignment = taCenter
            Color = clSilver
            ImageIndex = 33
            Options = [coEnabled, coParentBidiMode, coVisible]
            Position = 5
            Width = 25
          end
          item
            ImageIndex = 75
            Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coVisible]
            Position = 6
            Width = 339
            WideText = 'Programas'
          end>
        WideDefaultText = ''
      end
    end
    object tsOperator: TTabSheet
      Caption = 'Operador'
      ImageIndex = 1
      DesignSize = (
        493
        434)
      object sbAltPasswd: TSpeedButton
        Tag = 1
        Left = 359
        Top = 8
        Width = 130
        Height = 22
        Anchors = [akTop, akRight]
        Caption = 'Senha de Lib.'
        Enabled = False
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = sbAltPasswdClick
      end
      object sbAltPwdDB: TSpeedButton
        Left = 359
        Top = 32
        Width = 130
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Senha de Acesso'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = sbAltPasswdClick
      end
      object sbNew: TSpeedButton
        Left = 392
        Top = 176
        Width = 89
        Height = 22
        Caption = '&Novo'
        Flat = True
        OnClick = sbNewClick
      end
      object sbCancel: TSpeedButton
        Left = 392
        Top = 248
        Width = 89
        Height = 22
        Caption = '&Cancelar'
        Flat = True
        OnClick = sbCancelClick
      end
      object sbDelete: TSpeedButton
        Left = 392
        Top = 328
        Width = 89
        Height = 22
        Caption = '&Excluir'
        Flat = True
        OnClick = sbDeleteClick
      end
      object sbSave: TSpeedButton
        Left = 392
        Top = 400
        Width = 89
        Height = 22
        Caption = '&Salvar'
        Flat = True
        OnClick = sbSaveClick
      end
      object lPk_Operadores: TStaticText
        Left = 0
        Top = 8
        Width = 145
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = '* Nome do Operador: '
        FocusControl = ePk_Operadores
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object ePk_Operadores: TEdit
        Left = 152
        Top = 8
        Width = 200
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        TabOrder = 1
        OnChange = ChangeGlobal
      end
      object eDsct_Max: TCurrencyEdit
        Left = 152
        Top = 32
        Width = 200
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0;-,0'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        OnChange = ChangeGlobal
      end
      object lDsct_Max: TStaticText
        Left = 0
        Top = 32
        Width = 145
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Desconto M'#225'ximo: '
        FocusControl = eDsct_Max
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object lFk_Linguagens: TStaticText
        Left = 0
        Top = 56
        Width = 145
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = '* Linguagem: '
        FocusControl = eFk_Linguagens
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object lFlag_LSen: TCheckBox
        Left = 0
        Top = 152
        Width = 261
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = '* Libera'#231#227'o por Senha'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = ChangeGlobal
      end
      object lFk_Cadastros: TStaticText
        Left = 0
        Top = 80
        Width = 145
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Cadastro: '
        FocusControl = eFk_Cadastros
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object lEmail_Ope: TStaticText
        Left = 0
        Top = 104
        Width = 489
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'e-Mail do Operador'
        FocusControl = eEmail_Ope
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object eEmail_Ope: TEdit
        Left = 0
        Top = 128
        Width = 489
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 8
        OnChange = ChangeGlobal
      end
      object gbActions: TGroupBox
        Left = 0
        Top = 168
        Width = 377
        Height = 257
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'A'#231'oes que o usu'#225'rio pode executar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        DesignSize = (
          377
          257)
        object lFlag_Fnd: TCheckBox
          Tag = 99
          Left = 16
          Top = 88
          Width = 345
          Height = 17
          Anchors = [akLeft, akRight]
          Caption = '* Busca'
          TabOrder = 1
          OnClick = ChangeGlobal
        end
        object lFlag_Ins: TCheckBox
          Tag = 99
          Left = 16
          Top = 170
          Width = 345
          Height = 17
          Anchors = [akLeft, akRight]
          Caption = '* Inser'#231#227'o'
          TabOrder = 2
          OnClick = ChangeGlobal
        end
        object lFlag_Upd: TCheckBox
          Tag = 99
          Left = 16
          Top = 131
          Width = 345
          Height = 17
          Anchors = [akLeft, akRight]
          Caption = '* Edi'#231#227'o'
          TabOrder = 3
          OnClick = ChangeGlobal
        end
        object lFlag_Del: TCheckBox
          Tag = 99
          Left = 16
          Top = 213
          Width = 345
          Height = 17
          Anchors = [akLeft, akRight]
          Caption = '* Exclus'#227'o'
          TabOrder = 4
          OnClick = ChangeGlobal
        end
        object lFlag_Brw: TCheckBox
          Tag = 99
          Left = 16
          Top = 44
          Width = 337
          Height = 17
          Anchors = [akLeft, akRight]
          Caption = '* Navega'#231#227'o'
          TabOrder = 0
          OnClick = ChangeGlobal
        end
      end
      object eFk_Linguagens: TPrcComboBox
        Left = 152
        Top = 56
        Width = 337
        Height = 21
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 10
        TypeObject = toObject
      end
      object eFk_Cadastros: TPrcComboBox
        Left = 152
        Top = 80
        Width = 337
        Height = 21
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = eFk_CadastrosSelect
        TabOrder = 11
        TypeObject = toInteger
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 503
    Width = 643
    Height = 19
    Panels = <
      item
        Width = 270
      end
      item
        Style = psOwnerDraw
        Width = 250
      end
      item
        Style = psOwnerDraw
        Width = 80
      end>
    ParentColor = True
    ParentShowHint = False
    ShowHint = True
    OnClick = sbStatusClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
  object Crypto: TCrypto
    Left = 544
  end
  object pmLegend: TPopupMenu
    AutoHotkeys = maManual
    OwnerDraw = True
    Left = 432
    Top = 40
    object pmShow: TMenuItem
      Caption = 'Vis'#237'vel'
      ImageIndex = 7
      OnDrawItem = pmShowDrawItem
    end
    object pmFind: TMenuItem
      Caption = 'Busca'
      ImageIndex = 90
      OnDrawItem = pmShowDrawItem
    end
    object pmBrowse: TMenuItem
      Caption = 'Navegar'
      ImageIndex = 23
      OnDrawItem = pmShowDrawItem
    end
    object pmInsert: TMenuItem
      Caption = 'Inserir'
      ImageIndex = 34
      OnDrawItem = pmShowDrawItem
    end
    object pmEdit: TMenuItem
      Caption = 'Edi'#231#227'o'
      ImageIndex = 81
      OnDrawItem = pmShowDrawItem
    end
    object pmDelete: TMenuItem
      Caption = 'Exclus'#227'o'
      ImageIndex = 33
      OnDrawItem = pmShowDrawItem
    end
  end
end
