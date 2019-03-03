object frmMvReadTxt: TfrmMvReadTxt
  Left = 191
  Top = 114
  Width = 696
  Height = 480
  Caption = 'frmMvReadTxt'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgMain: TPageControl
    Left = 0
    Top = 33
    Width = 688
    Height = 400
    ActivePage = tsSummary
    Align = alClient
    TabOrder = 0
    OnChange = pgMainChange
    OnChanging = pgMainChanging
    object tsParameters: TTabSheet
      Caption = 'Par'#226'metros da Leitura'
      DesignSize = (
        680
        372)
      object lFkTypeOccurs: TStaticText
        Left = 8
        Top = 24
        Width = 217
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Selecione o Tipo de Arquivo: '
        FocusControl = eFkTypeOccurs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eFkTypeOccurs: TPrcComboBox
        Left = 232
        Top = 24
        Width = 321
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = eFkTypeOccursSelect
        TabOrder = 1
        TypeObject = toObject
      end
      object eSelDirectory: TDirectoryEdit
        Left = 232
        Top = 48
        Width = 321
        Height = 21
        OnAfterDialog = eSelDirectoryAfterDialog
        DialogKind = dkWin32
        InitialDir = 'C:\Sistemas\gdbs\Brita\files'
        Enabled = False
        NumGlyphs = 1
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
      object lSelDirectory: TStaticText
        Left = 8
        Top = 48
        Width = 217
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Selecione o Diret'#243'rio: '
        FocusControl = eSelDirectory
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object pgRead: TPageControl
        Left = 8
        Top = 72
        Width = 665
        Height = 289
        ActivePage = tsProgress
        Anchors = [akLeft, akTop, akRight, akBottom]
        PopupMenu = pmLoadErrors
        TabOrder = 4
        OnChange = pgReadChange
        OnChanging = pgReadChanging
        object tsProgress: TTabSheet
          Caption = 'Progresso da Leitura'
          DesignSize = (
            657
            261)
          object lbSelFiles: TListBox
            Left = 8
            Top = 12
            Width = 217
            Height = 241
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 13
            TabOrder = 0
          end
          object gbProcess: TGroupBox
            Left = 232
            Top = 12
            Width = 417
            Height = 241
            Anchors = [akTop, akRight, akBottom]
            Caption = 'Progresso da Leitura'
            TabOrder = 1
            DesignSize = (
              417
              241)
            object lFilesProgress: TLabel
              Left = 24
              Top = 40
              Width = 72
              Height = 13
              Caption = 'Arquivos Lidos:'
            end
            object lRecordProgress: TLabel
              Left = 24
              Top = 96
              Width = 75
              Height = 13
              Anchors = [akLeft]
              Caption = 'Registros Lidos:'
            end
            object lTotalRecords: TLabel
              Left = 24
              Top = 152
              Width = 122
              Height = 13
              Anchors = [akLeft, akBottom]
              Caption = 'Total dos Registros Lidos:'
            end
            object lStatus: TLabel
              Left = 24
              Top = 192
              Width = 369
              Height = 41
              Alignment = taCenter
              Anchors = [akLeft, akRight, akBottom]
              AutoSize = False
            end
            object pbFiles: TProgressBar
              Left = 24
              Top = 56
              Width = 369
              Height = 17
              Anchors = [akLeft, akTop, akRight]
              TabOrder = 0
            end
            object pbRecords: TProgressBar
              Left = 24
              Top = 112
              Width = 369
              Height = 17
              Anchors = [akLeft, akRight]
              TabOrder = 1
            end
            object pbTotalRecords: TProgressBar
              Left = 24
              Top = 168
              Width = 369
              Height = 17
              Anchors = [akLeft, akRight, akBottom]
              TabOrder = 2
            end
          end
        end
        object tsErrors: TTabSheet
          Caption = 'Erros Encontrados'
          ImageIndex = 1
          object vtErrors: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 657
            Height = 261
            Align = alClient
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clBlue
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = [fsBold]
            Header.Options = [hoAutoResize, hoHotTrack, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            PopupMenu = pmLoadErrors
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnCollapsed = vtErrorsCollapsed
            OnDblClick = vtErrorsDblClick
            OnExpanded = vtErrorsExpanded
            OnGetText = vtErrorsGetText
            Columns = <
              item
                Options = [coAllowClick, coEnabled, coParentBidiMode, coParentColor, coVisible]
                Position = 0
                Width = 657
                WideText = 'Pra'#231'as e Pistas'
              end>
          end
        end
        object tsDetailLine: TTabSheet
          Caption = 'Detalhamento da linha %d do arquivo %s'
          ImageIndex = 2
          TabVisible = False
          object vtLineDetail: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 657
            Height = 261
            Align = alClient
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clBlue
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = [fsBold]
            Header.MainColumn = -1
            Header.Options = [hoColumnResize, hoHotTrack, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            TabOrder = 0
            TreeOptions.AutoOptions = [toAutoDropExpand, toAutoExpand, toAutoScroll, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
            TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnGetText = vtLineDetailGetText
            Columns = <>
          end
        end
      end
      object lFk_Squares: TStaticText
        Left = 8
        Top = 0
        Width = 217
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Selecione a Praca: '
        FocusControl = eFk_Squares
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object eFk_Squares: TPrcComboBox
        Left = 232
        Top = 0
        Width = 321
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = eFk_SquaresSelect
        TabOrder = 6
        TypeObject = toInteger
      end
    end
    object tsSummary: TTabSheet
      Caption = 'Resumo dos registros Lidos'
      ImageIndex = 1
      DesignSize = (
        680
        372)
      object lDtaIni: TStaticText
        Left = 8
        Top = 32
        Width = 105
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Inicial: '
        Enabled = False
        FocusControl = eDtaIni
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object lDtaFin: TStaticText
        Left = 400
        Top = 32
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Final: '
        Enabled = False
        FocusControl = eSelDirectory
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object eDtaIni: TDateEdit
        Left = 120
        Top = 32
        Width = 89
        Height = 21
        Enabled = False
        NumGlyphs = 2
        TabOrder = 2
        OnAcceptDate = eDtaIniAcceptDate
      end
      object eDtaFin: TDateEdit
        Left = 512
        Top = 32
        Width = 89
        Height = 21
        Enabled = False
        Anchors = [akTop, akRight]
        NumGlyphs = 2
        TabOrder = 3
        OnAcceptDate = eDtaFinAcceptDate
      end
      object bbFilter: TBitBtn
        Left = 288
        Top = 29
        Width = 105
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Buscar Registros'
        Enabled = False
        TabOrder = 4
        OnClick = bbFilterClick
      end
      object eHorIni: TDateTimePicker
        Left = 208
        Top = 32
        Width = 73
        Height = 21
        Date = 38870.291666666660000000
        Time = 38870.291666666660000000
        Enabled = False
        Kind = dtkTime
        TabOrder = 5
      end
      object eHorFin: TDateTimePicker
        Left = 600
        Top = 32
        Width = 73
        Height = 21
        Anchors = [akTop, akRight]
        Date = 38870.291666666660000000
        Time = 38870.291666666660000000
        Enabled = False
        Kind = dtkTime
        TabOrder = 6
      end
      object lTotPer: TStaticText
        Left = 8
        Top = 56
        Width = 105
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Total Apurado: '
        Enabled = False
        FocusControl = eTotPer
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object eTotPer: TCurrencyEdit
        Left = 120
        Top = 56
        Width = 161
        Height = 21
        AutoSize = False
        Color = clInfoBk
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
      end
      object pgSummary: TPageControl
        Left = 8
        Top = 80
        Width = 665
        Height = 281
        ActivePage = tsLanca
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 9
        OnChanging = pgSummaryChanging
        object tsAllData: TTabSheet
          Caption = 'Dados do Resumo'
          DesignSize = (
            657
            253)
          object vtSummary: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 657
            Height = 253
            Anchors = [akLeft, akTop, akRight, akBottom]
            Colors.FocusedSelectionColor = clGrayText
            Colors.FocusedSelectionBorderColor = clGrayText
            Colors.SelectionRectangleBlendColor = clGrayText
            Colors.SelectionRectangleBorderColor = clGrayText
            EditDelay = 0
            Header.AutoSizeIndex = 2
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clBlue
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = [fsBold]
            Header.Options = [hoAutoResize, hoColumnResize, hoHotTrack, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            SelectionCurveRadius = 10
            TabOrder = 0
            TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
            OnBeforeItemErase = vtSummaryBeforeItemErase
            OnGetText = vtSummaryGetText
            OnGetImageIndex = vtSummaryGetImageIndex
            Columns = <
              item
                Position = 0
                Width = 400
                WideText = 'Pra'#231'a'
              end
              item
                Position = 1
                Width = 150
                WideText = 'Forma de Pagamento'
              end
              item
                Alignment = taRightJustify
                Position = 2
                Width = 107
                WideText = 'Total Apurado'
              end>
          end
        end
        object tsLanca: TTabSheet
          Caption = 'Distriui'#231#227'o dos Valores'
          ImageIndex = 1
          DesignSize = (
            657
            253)
          object vtLaunch: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 657
            Height = 253
            Anchors = [akLeft, akTop, akRight, akBottom]
            Colors.FocusedSelectionColor = clGrayText
            Colors.FocusedSelectionBorderColor = clGrayText
            Colors.SelectionRectangleBlendColor = clGrayText
            Colors.SelectionRectangleBorderColor = clGrayText
            EditDelay = 0
            Header.AutoSizeIndex = 3
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clBlue
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = [fsBold]
            Header.Options = [hoAutoResize, hoColumnResize, hoHotTrack, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            SelectionCurveRadius = 10
            TabOrder = 0
            TreeOptions.MiscOptions = [toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
            OnBeforeItemErase = vtLaunchBeforeItemErase
            OnChecked = vtLaunchChecked
            OnChecking = vtLaunchChecking
            OnEditing = vtLaunchEditing
            OnGetText = vtLaunchGetText
            OnGetImageIndex = vtLaunchGetImageIndex
            OnInitNode = vtLaunchInitNode
            OnNewText = vtLaunchNewText
            Columns = <
              item
                Position = 0
                Width = 300
                WideText = 'Contas / Tickets'
              end
              item
                Alignment = taRightJustify
                Position = 1
                Width = 100
                WideText = 'Quant.'
              end
              item
                Alignment = taRightJustify
                Position = 2
                Width = 100
                WideText = 'Valor Unit.'
              end
              item
                Alignment = taRightJustify
                Position = 3
                Width = 153
                WideText = 'Total Lan'#231'ado'
              end>
          end
        end
      end
      object lTotLan: TStaticText
        Left = 400
        Top = 56
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Total Lan'#231'ado: '
        Enabled = False
        FocusControl = eTotLan
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object eTotLan: TCurrencyEdit
        Left = 512
        Top = 56
        Width = 161
        Height = 21
        AutoSize = False
        Color = clInfoBk
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Anchors = [akTop, akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
      end
      object lAccounts: TStaticText
        Left = 8
        Top = 8
        Width = 105
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Caixa da Pra'#231'a: '
        FocusControl = eAccounts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object eAccounts: TComboBox
        Left = 120
        Top = 8
        Width = 553
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 13
        OnSelect = eAccountsSelect
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 433
    Width = 688
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Style = psOwnerDraw
        Width = 300
      end
      item
        Style = psOwnerDraw
        Width = 100
      end>
    OnClick = sbStatusClick
    OnMouseMove = sbStatusMouseMove
    OnDrawPanel = sbStatusDrawPanel
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 688
    Height = 33
    Bands = <
      item
        Control = tbTools
        ImageIndex = 82
        Text = 'Ferramentas'
        Width = 684
      end>
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 607
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 104
      Caption = 'tbTools'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbNew: TToolButton
        Left = 0
        Top = 0
        Caption = '&Nova Leitura'
        Grouped = True
        ImageIndex = 1
        OnClick = tbNewClick
      end
      object tbSepRead: TToolButton
        Left = 104
        Top = 0
        Width = 8
        Caption = 'tbSepRead'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbRead: TToolButton
        Left = 112
        Top = 0
        Caption = 'Processar &Arquivo'
        Enabled = False
        Grouped = True
        ImageIndex = 2
        OnClick = tbReadClick
      end
      object tbSepGen: TToolButton
        Left = 216
        Top = 0
        Width = 8
        Caption = 'tbSepGen'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbProcess: TToolButton
        Left = 224
        Top = 0
        Caption = 'Gerar Financeiro'
        Enabled = False
        ImageIndex = 3
        OnClick = tbProcessClick
      end
      object tbSepClose: TToolButton
        Left = 328
        Top = 0
        Width = 8
        Caption = 'tbSepClose'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 336
        Top = 0
        Caption = '&Sair'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
    end
  end
  object pmLoadErrors: TPopupMenu
    Left = 200
    Top = 193
    object CarregarErrosdoDisco1: TMenuItem
      Caption = 'Carregar Erros do Disco'
      OnClick = CarregarErrosdoDisco1Click
    end
  end
end
