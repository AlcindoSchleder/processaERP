object frmOwners: TfrmOwners
  Left = 190
  Top = 113
  Width = 800
  Height = 575
  Caption = 'frmOwners'
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
    Height = 495
    ActivePage = tsData
    Align = alClient
    TabOrder = 1
    OnChanging = pgControlChanging
    object tsData: TTabSheet
      Caption = 'Dados do Contato'
      object pgCategory: TPageControl
        Left = 0
        Top = 267
        Width = 784
        Height = 200
        Align = alBottom
        TabOrder = 3
      end
      object pOwnerData: TPanel
        Left = 0
        Top = 0
        Width = 784
        Height = 89
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        DesignSize = (
          784
          89)
        object eCrg_Cad: TEdit
          Left = 496
          Top = 64
          Width = 281
          Height = 21
          Anchors = [akLeft, akRight]
          CharCase = ecUpperCase
          MaxLength = 30
          TabOrder = 7
          OnChange = ChangeGlobal
        end
        object lCrg_Cad: TStaticText
          Left = 400
          Top = 64
          Width = 90
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = ' Cargo:'
          FocusControl = eCrg_Cad
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object lFk_Contatos: TStaticText
          Left = 8
          Top = 64
          Width = 90
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = ' Empresa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object lRaz_Soc: TStaticText
          Left = 8
          Top = 40
          Width = 90
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = ' Nome:'
          FocusControl = eRaz_Soc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object eRaz_Soc: TEdit
          Left = 104
          Top = 40
          Width = 289
          Height = 21
          Anchors = [akLeft]
          CharCase = ecUpperCase
          MaxLength = 50
          TabOrder = 4
          OnChange = ChangeGlobal
        end
        object lFk_Tipo_Alias: TStaticText
          Left = 400
          Top = 40
          Width = 90
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = ' Alias:'
          FocusControl = eFk_Tipo_Alias
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object eDoc_Sec: TMaskEdit
          Left = 496
          Top = 8
          Width = 121
          Height = 21
          Anchors = [akRight]
          TabOrder = 2
          OnChange = ChangeGlobal
          OnExit = eDoc_SecExit
        end
        object lDoc_Sec: TStaticText
          Left = 422
          Top = 8
          Width = 66
          Height = 21
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Doc. Sec.:'
          FocusControl = eDoc_Sec
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object eDoc_Pri: TMaskEdit
          Left = 296
          Top = 8
          Width = 119
          Height = 21
          Anchors = [akLeft, akRight]
          TabOrder = 1
          OnChange = ChangeGlobal
          OnExit = eDoc_PriExit
        end
        object lDoc_Pri: TStaticText
          Left = 200
          Top = 8
          Width = 90
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Doc. Prim.:'
          FocusControl = eDoc_Pri
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object eTrt_Cnt: TEdit
          Left = 688
          Top = 8
          Width = 89
          Height = 21
          Anchors = [akLeft]
          MaxLength = 20
          TabOrder = 3
          OnChange = ChangeGlobal
        end
        object lTrt_Cnt: TStaticText
          Left = 624
          Top = 8
          Width = 58
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Tratam.:'
          FocusControl = eTrt_Cnt
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object eFk_Tipo_Alias: TComboBox
          Left = 496
          Top = 40
          Width = 281
          Height = 21
          AutoDropDown = True
          Anchors = [akLeft, akRight]
          CharCase = ecUpperCase
          ItemHeight = 13
          TabOrder = 5
          OnExit = eFk_Tipo_AliasExit
          OnSelect = ChangeGlobal
        end
        object eFlag_TCad: TComboBox
          Left = 104
          Top = 8
          Width = 89
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 3
          TabOrder = 0
          Text = 'Todos'
          OnSelect = eFlag_TCadSelect
          Items.Strings = (
            'Empresa'
            'Pessoa'
            'Estrangeiro'
            'Todos')
        end
        object StaticText1: TStaticText
          Left = 8
          Top = 8
          Width = 89
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = ' Tipo:'
          FocusControl = eTrt_Cnt
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object eFk_Contatos: TPrcComboBox
          Left = 104
          Top = 64
          Width = 289
          Height = 21
          BevelKind = bkNone
          CompareMethod = 'ComparePk'
          GetPkMethod = 'GetPkValue'
          ItemHeight = 13
          OnDblClick = eFk_ContatosDblClick
          OnSelect = ChangeGlobal
          TabOrder = 6
          TypeObject = toObject
        end
      end
      object pgComplement: TPageControl
        Left = 0
        Top = 89
        Width = 418
        Height = 178
        ActivePage = tsAddress
        Align = alClient
        TabOrder = 1
        object tsAddress: TTabSheet
          Caption = 'Endere'#231'o'
          DesignSize = (
            410
            150)
          object lFk_Paises: TStaticText
            Left = 0
            Top = 0
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Pa'#237's:'
            FocusControl = eFk_Paises
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object eFk_Paises: TPrcComboBox
            Left = 96
            Top = 0
            Width = 313
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = eFk_PaisesSelect
            TabOrder = 0
            TypeObject = toObject
          end
          object lFk_Estados: TStaticText
            Left = 0
            Top = 25
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Estado:'
            FocusControl = eFk_Estados
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object eFk_Estados: TPrcComboBox
            Left = 95
            Top = 25
            Width = 314
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = eFk_EstadosSelect
            TabOrder = 1
            TypeObject = toObject
          end
          object eFk_Municipios: TPrcComboBox
            Left = 95
            Top = 48
            Width = 314
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = ChangeGlobal
            TabOrder = 2
            TypeObject = toObject
          end
          object lFk_Municipios: TStaticText
            Left = 0
            Top = 48
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Cidade:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object lEnd_Cad: TStaticText
            Left = 0
            Top = 74
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Endere'#231'o:'
            FocusControl = eEnd_Cad
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object eEnd_Cad: TEdit
            Left = 95
            Top = 74
            Width = 314
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            MaxLength = 50
            TabOrder = 3
            OnChange = ChangeGlobal
          end
          object eNum_End: TCurrencyEdit
            Left = 96
            Top = 98
            Width = 57
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = ',0;'
            Anchors = [akLeft]
            TabOrder = 4
            OnChange = ChangeGlobal
          end
          object lNum_End: TStaticText
            Left = 0
            Top = 98
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' N'#250'mero:'
            FocusControl = eNum_End
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
          object lCmp_End: TStaticText
            Left = 0
            Top = 122
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Complem.:'
            FocusControl = eCmp_End
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object eCmp_End: TEdit
            Left = 96
            Top = 122
            Width = 313
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            MaxLength = 50
            TabOrder = 7
            OnChange = ChangeGlobal
          end
          object eCxp_Cad: TEdit
            Left = 344
            Top = 98
            Width = 65
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            MaxLength = 10
            TabOrder = 6
            OnChange = ChangeGlobal
          end
          object lCxp_Cad: TStaticText
            Left = 296
            Top = 98
            Width = 41
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' C.P.'
            FocusControl = eCxp_Cad
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
          end
          object lCep_Cad: TStaticText
            Left = 160
            Top = 98
            Width = 57
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' C.E.P.:'
            FocusControl = eCep_Cad
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object eCep_Cad: TCurrencyEdit
            Left = 223
            Top = 98
            Width = 66
            Height = 21
            AutoSize = False
            DecimalPlaces = 0
            DisplayFormat = ',0;'
            Anchors = [akLeft]
            TabOrder = 5
            OnChange = ChangeGlobal
          end
        end
        object tsObservations: TTabSheet
          Caption = 'Observa'#231#245'es'
          ImageIndex = 1
          DesignSize = (
            410
            150)
          object Shape2: TShape
            Left = 266
            Top = 0
            Width = 144
            Height = 16
            Brush.Color = 6730751
          end
          object iImg_Cad: TImage
            Left = 266
            Top = 16
            Width = 144
            Height = 128
            Anchors = [akTop, akRight, akBottom]
            Center = True
            Proportional = True
            OnClick = iImgCadDblClick
          end
          object Shape1: TShape
            Left = 0
            Top = 0
            Width = 265
            Height = 16
            Brush.Color = 6730751
          end
          object lObs_Cad: TLabel
            Left = 4
            Top = 1
            Width = 257
            Height = 14
            Alignment = taCenter
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Observa'#231#245'es'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object lImg_Cad: TLabel
            Left = 272
            Top = 1
            Width = 129
            Height = 13
            Alignment = taCenter
            Anchors = [akTop, akRight]
            AutoSize = False
            Caption = 'Imagem'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
          end
          object eObs_Cad: TMemo
            Left = 0
            Top = 16
            Width = 265
            Height = 136
            Anchors = [akLeft, akTop, akRight, akBottom]
            ScrollBars = ssVertical
            TabOrder = 0
            OnChange = ChangeGlobal
          end
        end
        object tsEvents: TTabSheet
          Caption = 'Eventos'
          ImageIndex = 3
          object vtEvents: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 410
            Height = 144
            Align = alClient
            CheckImageKind = ckXP
            EditDelay = 0
            Header.AutoSizeIndex = 1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            TabOrder = 0
            TreeOptions.MiscOptions = [toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            OnChecked = vtEventsChecked
            OnGetText = vtEventsGetText
            OnInitNode = vtEventsInitNode
            OnKeyDown = TreeKeyDown
            OnNewText = vtEventsNewText
            Columns = <
              item
                ImageIndex = 52
                Position = 0
                Width = 150
                WideText = 'Data'
              end
              item
                Position = 1
                Width = 260
                WideText = 'Descri'#231#227'o'
              end>
            WideDefaultText = ''
          end
        end
      end
      object pgContactData: TPageControl
        Left = 418
        Top = 89
        Width = 366
        Height = 178
        ActivePage = tsCategories
        Align = alRight
        TabOrder = 2
        object tsCategories: TTabSheet
          Caption = 'Categorias'
          ImageIndex = 52
          object vtCategory: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 358
            Height = 150
            Align = alClient
            CheckImageKind = ckXP
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            TabOrder = 0
            TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            OnChecked = vtCategoryChecked
            OnChecking = vtCategoryChecking
            OnGetText = vtCategoryGetText
            OnInitNode = vtCategoryInitNode
            Columns = <
              item
                ImageIndex = 52
                Position = 0
                Width = 354
                WideText = 'Categorias do Contato'
              end>
          end
        end
        object tsPhones: TTabSheet
          Caption = 'Telefones'
          ImageIndex = 60
          object vtPhones: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 358
            Height = 150
            Align = alClient
            CheckImageKind = ckXP
            EditDelay = 0
            Header.AutoSizeIndex = 1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.MainColumn = 1
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            TabOrder = 0
            TreeOptions.MiscOptions = [toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            OnChecked = vtPhonesChecked
            OnGetText = vtPhonesGetText
            OnInitNode = vtPhonesInitNode
            OnKeyDown = TreeKeyDown
            OnNewText = vtPhonesNewText
            Columns = <
              item
                ImageIndex = 45
                Position = 0
                Width = 150
                WideText = 'Tipo'
              end
              item
                ImageIndex = 52
                Position = 1
                Width = 208
                WideText = 'N'#250'mero'
              end>
            WideDefaultText = ''
          end
        end
        object tsInternet: TTabSheet
          Caption = 'Endere'#231'os de Internet'
          ImageIndex = 4
          object vtInternet: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 358
            Height = 150
            Align = alClient
            CheckImageKind = ckXP
            EditDelay = 0
            Header.AutoSizeIndex = 1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            TabOrder = 0
            TreeOptions.MiscOptions = [toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            OnChecked = vtInternetChecked
            OnGetText = vtInternetGetText
            OnInitNode = vtInternetInitNode
            OnKeyDown = TreeKeyDown
            OnNewText = vtInternetNewText
            Columns = <
              item
                Position = 0
                Width = 150
                WideText = 'Tipo'
              end
              item
                ImageIndex = 52
                Position = 1
                Width = 208
                WideText = 'Endere'#231'o'
              end>
          end
        end
        object tsContactList: TTabSheet
          Caption = 'Lista de Contatos'
          ImageIndex = 3
          object vtPhoneList: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 358
            Height = 150
            Align = alClient
            Colors.FocusedSelectionColor = clGrayText
            Colors.SelectionRectangleBlendColor = clGrayText
            Colors.SelectionRectangleBorderColor = clGrayText
            Header.AutoSizeIndex = 1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            SelectionCurveRadius = 10
            TabOrder = 0
            TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
            OnDblClick = vtPhoneListDblClick
            OnGetText = vtPhoneListGetText
            OnPaintText = vtPhoneListPaintText
            Columns = <
              item
                ImageIndex = 1
                Position = 0
                Width = 200
                WideText = 'Nome'
              end
              item
                ImageIndex = 52
                Position = 1
                Width = 158
                WideText = 'N'#250'mero'
              end>
            WideDefaultText = ''
          end
        end
      end
    end
    object tsList: TTabSheet
      Caption = 'Listagem dos Contatos'
      ImageIndex = 1
      object vtSearch: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 784
        Height = 467
        Align = alClient
        CheckImageKind = ckXP
        Colors.FocusedSelectionColor = 6730751
        Colors.FocusedSelectionBorderColor = clBtnShadow
        Colors.GridLineColor = clSilver
        Colors.SelectionRectangleBlendColor = 6730751
        Colors.UnfocusedSelectionColor = 6730751
        Ctl3D = True
        EditDelay = 0
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clBlue
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
        Header.SortColumn = 1
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HotCursor = crHandPoint
        IncrementalSearch = isVisibleOnly
        IncrementalSearchTimeout = 3000
        ParentCtl3D = False
        SelectionCurveRadius = 20
        TabOrder = 0
        TreeOptions.AnimationOptions = [toAnimatedToggle]
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus]
        TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
        OnBeforeItemErase = vtSearchBeforeItemErase
        OnCompareNodes = vtSearchCompareNodes
        OnDblClick = vtSearchDblClick
        OnEditing = vtSearchEditing
        OnFocusChanged = vtSearchFocusChanged
        OnFocusChanging = vtSearchFocusChanging
        OnGetText = vtSearchGetText
        OnPaintText = vtSearchPaintText
        OnHeaderClick = vtSearchHeaderClick
        OnIncrementalSearch = vtSearchIncrementalSearch
        OnStateChange = vtSearchStateChange
        Columns = <
          item
            ImageIndex = 9
            Position = 0
            Width = 100
            WideText = 'C'#243'digo'
          end
          item
            ImageIndex = 84
            Position = 1
            Width = 300
            WideText = 'Nome'
          end
          item
            ImageIndex = 84
            Position = 2
            Width = 250
            WideText = 'Alias'
          end
          item
            Position = 3
            Width = 130
            WideText = 'C.N.P.J. / C.P.F.'
          end>
        WideDefaultText = '...'
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 528
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
  object opImage: TOpenPictureDialog
    DefaultExt = '*.jpg'
    Filter = 
      'All (*.gif;*.gif;*.pcx;*.ani;*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wm' +
      'f)|*.jpg;*.jpeg;*.bmp;*.emf;*.wmf|JPEG Image File (*.jpg)|*.jpg|' +
      'JPEG Image File (*.jpeg)|*.jpeg|Bitmaps (*.bmp)|*.bmp|Enhanced M' +
      'etafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf'
    InitialDir = '.'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofNoNetworkButton, ofEnableSizing]
    Left = 128
    Top = 368
  end
end
