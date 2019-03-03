object frmProducts: TfrmProducts
  Left = 260
  Top = 95
  Width = 800
  Height = 555
  Caption = 'frmProducts'
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
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 33
    Bands = <
      item
        Break = False
        Control = tbTools
        HorizontalOnly = True
        ImageIndex = 46
        Text = 'Opera'#231#245'es'
        Width = 788
      end>
    Ctl3D = False
    object tbTools: TToolBar
      Left = 67
      Top = 0
      Width = 717
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 60
      Flat = True
      List = True
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      Transparent = True
      object tbInsert: TToolButton
        Left = 0
        Top = 0
        Hint = 'Inserir | Insere Nova Ordem de Servi'#231'os'
        Caption = '&Inserir'
        ImageIndex = 34
        OnClick = tbInsertClick
      end
      object tbDelete: TToolButton
        Left = 60
        Top = 0
        Caption = '&Excluir'
        ImageIndex = 33
        OnClick = tbDeleteClick
      end
      object tbCancel: TToolButton
        Left = 120
        Top = 0
        Hint = 'Cancelar | Cancela as Altera'#231#245'es feitas na Ordem de Servi'#231'os'
        Caption = '&Cancelar'
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbSepOper: TToolButton
        Left = 180
        Top = 0
        Width = 8
        Caption = 'tbSepOper'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbPrior: TToolButton
        Left = 188
        Top = 0
        Hint = 'Anterior | Mostra Sele'#231#227'o Anterior'
        Caption = '&Anterior'
        ImageIndex = 30
        OnClick = tbPriorClick
      end
      object tbNext: TToolButton
        Left = 248
        Top = 0
        Hint = 'Pr'#243'ximo | Mostra Pr'#243'xima Sele'#231#227'o'
        Caption = '&Pr'#243'ximo'
        ImageIndex = 32
        OnClick = tbNextClick
      end
      object tbSepSave: TToolButton
        Left = 308
        Top = 0
        Width = 8
        ImageIndex = 34
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 316
        Top = 0
        Hint = 'Salvar | Salva as Altera'#231#245'es Feitas na Ordem de Servi'#231'os Atual'
        Caption = '&Salvar'
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object tbSepFind: TToolButton
        Left = 376
        Top = 0
        Width = 8
        Caption = 'tbSepFind'
        ImageIndex = 38
        Style = tbsSeparator
      end
      object tbFound: TToolButton
        Left = 384
        Top = 0
        Caption = 'Filtrar'
        Enabled = False
        ImageIndex = 38
        OnClick = tbFoundClick
      end
      object tbFind: TToolButton
        Left = 444
        Top = 0
        Caption = 'Buscar'
        ImageIndex = 90
        OnClick = tbFindClick
      end
      object tbSepClose: TToolButton
        Left = 504
        Top = 0
        Width = 8
        Caption = 'tbSepClose'
        ImageIndex = 91
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 512
        Top = 0
        Caption = 'Sair'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
    end
  end
  object pgControl: TPageControl
    Left = 0
    Top = 33
    Width = 792
    Height = 475
    ActivePage = tsData
    Align = alClient
    TabOrder = 1
    OnChanging = pgControlChanging
    object tsData: TTabSheet
      Caption = 'Dados do Produto'
      object pAllData: TPanel
        Left = 193
        Top = 0
        Width = 591
        Height = 447
        Align = alClient
        Ctl3D = True
        ParentColor = True
        ParentCtl3D = False
        TabOrder = 0
        object pProduct: TPanel
          Left = 1
          Top = 1
          Width = 589
          Height = 153
          Align = alTop
          ParentColor = True
          TabOrder = 0
          DesignSize = (
            589
            153)
          object lPk_Produtos: TStaticText
            Left = 8
            Top = 8
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' C'#243'digo:'
            Enabled = False
            FocusControl = ePk_Produtos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object eFk_Unidades: TComboBox
            Left = 96
            Top = 104
            Width = 143
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 1
            OnSelect = eFk_UnidadesSelect
          end
          object lFk_Unidades: TStaticText
            Left = 8
            Top = 104
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Unidade:'
            FocusControl = eFk_Unidades
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object lFk_Produtos_Grupos: TStaticText
            Left = 8
            Top = 32
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Classif.:'
            FocusControl = eFk_Produtos_Grupos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object lDsc_Prod: TStaticText
            Left = 8
            Top = 128
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Descri'#231#227'o:'
            FocusControl = eDsc_Prod
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object eDsc_Prod: TEdit
            Left = 96
            Top = 128
            Width = 489
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            MaxLength = 50
            TabOrder = 5
            OnChange = ChangeGlobal
          end
          object vtProdType: TVirtualStringTree
            Left = 406
            Top = 0
            Width = 185
            Height = 121
            Anchors = [akTop, akRight]
            CheckImageKind = ckXP
            Ctl3D = True
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoDrag, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            ParentCtl3D = False
            TabOrder = 6
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnChecked = vtProdTypeChecked
            OnChecking = vtProdTypeChecking
            OnGetText = vtProdTypeGetText
            OnInitNode = vtProdTypeInitNode
            Columns = <
              item
                ImageIndex = 83
                Position = 0
                Width = 160
                WideText = 'Tipos'
              end>
          end
          object lFlag_Atv: TCheckBox
            Left = 280
            Top = 8
            Width = 111
            Height = 17
            Alignment = taLeftJustify
            Anchors = [akLeft, akRight]
            Caption = 'Produto Ativo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnClick = ChangeGlobal
          end
          object lQtd_Uni: TStaticText
            Left = 246
            Top = 104
            Width = 81
            Height = 21
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Qtd. Uso:'
            FocusControl = eQtd_Uni
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object eQtd_Uni: TCurrencyEdit
            Left = 334
            Top = 104
            Width = 65
            Height = 21
            AutoSize = False
            DecimalPlaces = 4
            DisplayFormat = ',0.000;- ,0.0000'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akRight]
            ParentFont = False
            TabOrder = 9
            OnChange = eQtd_UniChange
          end
          object ePk_Produtos: TEdit
            Left = 96
            Top = 8
            Width = 121
            Height = 21
            PopupMenu = pmCodes
            TabOrder = 10
            OnChange = ChangeGlobal
          end
          object eFk_Produtos_Grupos: TComboBox
            Left = 96
            Top = 32
            Width = 305
            Height = 22
            Style = csOwnerDrawFixed
            Anchors = [akLeft, akRight]
            ItemHeight = 16
            TabOrder = 11
            OnDrawItem = eFk_Produtos_GruposDrawItem
            OnSelect = eFk_Produtos_GruposSelect
          end
        end
        object pgData: TPageControl
          Left = 1
          Top = 154
          Width = 589
          Height = 292
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object pDataAux: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 447
        Align = alLeft
        ParentColor = True
        TabOrder = 1
        object pCodes: TPanel
          Left = 1
          Top = 177
          Width = 191
          Height = 269
          Align = alClient
          UseDockManager = False
          ParentBackground = True
          ParentColor = True
          TabOrder = 0
        end
        object stCodeTitle: TStaticText
          Left = 1
          Top = 153
          Width = 191
          Height = 24
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'C'#243'digos do Produto'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object pgBlobs: TPageControl
          Left = 1
          Top = 1
          Width = 191
          Height = 152
          ActivePage = tsPicture
          Align = alTop
          TabOrder = 2
          object tsPicture: TTabSheet
            Caption = 'Imagem'
            object iImgProd: TImage
              Left = 0
              Top = 0
              Width = 183
              Height = 124
              Align = alClient
              Center = True
              Proportional = True
              OnDblClick = iImgProdDblClick
            end
          end
          object tsObservations: TTabSheet
            Caption = 'Caracter'#237'stricas'
            ImageIndex = 1
            object eObs_Prod: TMemo
              Left = 0
              Top = 0
              Width = 183
              Height = 124
              Align = alClient
              ScrollBars = ssBoth
              TabOrder = 0
              OnChange = ChangeGlobal
            end
          end
        end
      end
    end
    object tsList: TTabSheet
      Caption = 'Listagem dos Produtos'
      ImageIndex = 1
      object vtSearch: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 784
        Height = 441
        Align = alClient
        CheckImageKind = ckXP
        Ctl3D = True
        Header.AutoSizeIndex = 6
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
        Header.SortColumn = 2
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        IncrementalSearch = isVisibleOnly
        ParentCtl3D = False
        SelectionCurveRadius = 10
        TabOrder = 0
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes]
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
        OnAfterCellPaint = vtSearchAfterCellPaint
        OnBeforeCellPaint = vtSearchBeforeCellPaint
        OnCompareNodes = vtSearchCompareNodes
        OnDblClick = vtSearchDblClick
        OnEditing = vtSearchEditing
        OnFocusChanged = vtSearchFocusChanged
        OnGetText = vtSearchGetText
        OnHeaderClick = vtSearchHeaderClick
        OnIncrementalSearch = vtSearchIncrementalSearch
        OnStateChange = vtSearchStateChange
        Columns = <
          item
            ImageIndex = 8
            Position = 0
            Width = 70
            WideText = 'C'#243'digo'
          end
          item
            ImageIndex = 52
            Position = 1
            Width = 100
            WideText = 'Refer'#234'ncia'
          end
          item
            ImageIndex = 47
            Position = 2
            Width = 230
            WideText = 'Descri'#231#227'o'
          end
          item
            Alignment = taRightJustify
            Position = 3
            Width = 90
            WideText = 'Pre'#231'o'
          end
          item
            Position = 4
            Width = 110
            WideText = 'Data da Compra'
          end
          item
            Position = 5
            Width = 90
            WideText = 'Data da Venda'
          end
          item
            Alignment = taCenter
            ImageIndex = 28
            Position = 6
            Width = 94
            WideText = 'Ativo'
          end>
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 508
    Width = 792
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Style = psOwnerDraw
        Text = 'Empresa'
        Width = 300
      end
      item
        Style = psOwnerDraw
        Width = 100
      end>
    OnClick = sbStatusClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
  object pmCodes: TPopupMenu
    Left = 22
    Top = 106
    object pmReference: TMenuItem
      Caption = 'Refer'#234'ncia'
      Checked = True
      OnClick = pmCodesItemClick
    end
    object pmPk: TMenuItem
      Caption = 'C'#243'digo do Produto'
      OnClick = pmCodesItemClick
    end
    object pmBarCode: TMenuItem
      AutoCheck = True
      Caption = 'C'#243'digo de Barras'
      OnClick = pmCodesItemClick
    end
    object pmSupplier: TMenuItem
      Caption = 'C'#243'digo do Fornecedor'
      OnClick = pmCodesItemClick
    end
  end
  object opImage: TOpenPictureDialog
    DefaultExt = '*.jpg'
    Filter = 
      'All (*.gif;*.gif;*.pcx;*.ani;*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wm' +
      'f)|*.jpg;*.jpeg;*.bmp;*.emf;*.wmf|JPEG Image File (*.jpg)|*.jpg|' +
      'JPEG Image File (*.jpeg)|*.jpeg|Bitmaps (*.bmp)|*.bmp|Enhanced M' +
      'etafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf'
    InitialDir = '.'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofNoNetworkButton, ofEnableSizing]
    Left = 57
    Top = 106
  end
end
