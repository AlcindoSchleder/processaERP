object CdContacts: TCdContacts
  Left = 182
  Top = 121
  BorderStyle = bsNone
  Caption = 'CdContacts'
  ClientHeight = 261
  ClientWidth = 792
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pOwnerData: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      792
      89)
    object ePosition: TEdit
      Left = 496
      Top = 40
      Width = 289
      Height = 21
      Anchors = [akLeft, akRight]
      BevelKind = bkFlat
      BorderStyle = bsNone
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 0
      OnChange = eGlobalChange
    end
    object lPosition: TStaticText
      Left = 400
      Top = 64
      Width = 90
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'lPosition'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cbCompany: TPrcComboBox
      Left = 104
      Top = 64
      Width = 289
      Height = 21
      CompareMethod = 'ComparePk'
      GetPkMethod = 'GetPkValue'
      ItemHeight = 13
      OnChange = eGlobalChange
      TabOrder = 2
      TypeObject = toObject
    end
    object lCompany: TStaticText
      Left = 8
      Top = 64
      Width = 90
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'lCompany'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object lName: TStaticText
      Left = 8
      Top = 40
      Width = 90
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'lName'
      FocusControl = eName
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object eName: TEdit
      Left = 104
      Top = 40
      Width = 289
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 5
      OnChange = eGlobalChange
    end
    object lNomFan: TStaticText
      Left = 400
      Top = 40
      Width = 90
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Nome Fant.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object eNickName: TComboBox
      Left = 496
      Top = 64
      Width = 289
      Height = 21
      BevelKind = bkFlat
      Style = csSimple
      CharCase = ecUpperCase
      ItemHeight = 13
      TabOrder = 7
      OnChange = eNickNameChange
    end
    object eDocSec: TMaskEdit
      Left = 648
      Top = 8
      Width = 129
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 8
      OnChange = eGlobalChange
    end
    object lDocSec: TStaticText
      Left = 576
      Top = 8
      Width = 66
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' I.E.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object eDocPri: TMaskEdit
      Left = 440
      Top = 8
      Width = 88
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      EditMask = '###.###.###-##;0; '
      MaxLength = 14
      TabOrder = 10
      OnChange = eGlobalChange
    end
    object lDocPri: TStaticText
      Left = 344
      Top = 8
      Width = 90
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' C.P.F.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object eTitle: TEdit
      Left = 248
      Top = 8
      Width = 89
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      MaxLength = 20
      TabOrder = 12
      OnChange = eGlobalChange
    end
    object lTitle: TStaticText
      Left = 152
      Top = 8
      Width = 90
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'lTitle'
      FocusControl = eTitle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object lTypeCad: TRadioGroup
      Left = 8
      Top = 0
      Width = 129
      Height = 33
      Caption = 'Tipo de Contato'
      Columns = 2
      Items.Strings = (
        'Jur'#237'dica'
        'F'#237'sica')
      TabOrder = 14
      OnClick = lTypeCadClick
    end
  end
  object pgComplement: TPageControl
    Left = 0
    Top = 89
    Width = 407
    Height = 172
    ActivePage = tsAddress
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object tsAddress: TTabSheet
      Caption = 'Endere'#231'o'
      object lCountry: TStaticText
        Left = 0
        Top = 0
        Width = 90
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lCountry'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object cbCountry: TPrcComboBox
        Left = 96
        Top = 0
        Width = 297
        Height = 21
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        OnSelect = cbCountrySelect
        TabOrder = 1
        TypeObject = toObject
      end
      object lState: TStaticText
        Left = 0
        Top = 24
        Width = 90
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lState'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object cbState: TPrcComboBox
        Left = 95
        Top = 24
        Width = 298
        Height = 21
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        OnSelect = cbStateSelect
        TabOrder = 3
        TypeObject = toObject
      end
      object cbCity: TPrcComboBox
        Left = 95
        Top = 48
        Width = 298
        Height = 21
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        OnChange = eGlobalChange
        TabOrder = 4
        TypeObject = toObject
      end
      object lCity: TStaticText
        Left = 0
        Top = 48
        Width = 90
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lCity'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object lAddress: TStaticText
        Left = 0
        Top = 72
        Width = 90
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lAddress'
        FocusControl = eAddress
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object eAddress: TEdit
        Left = 95
        Top = 72
        Width = 298
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 7
        OnChange = eGlobalChange
      end
      object eNumEnd: TCurrencyEdit
        Left = 96
        Top = 96
        Width = 57
        Height = 21
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        DecimalPlaces = 0
        DisplayFormat = ',0;'
        TabOrder = 8
        OnChange = eGlobalChange
      end
      object lNumEnd: TStaticText
        Left = 0
        Top = 96
        Width = 90
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' N'#250'mero:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object lCmpEnd: TStaticText
        Left = 0
        Top = 120
        Width = 90
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Complem.:'
        FocusControl = eCmpEnd
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object eCmpEnd: TEdit
        Left = 336
        Top = 96
        Width = 57
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 11
        OnChange = eGlobalChange
      end
      object eCxpCad: TEdit
        Left = 95
        Top = 120
        Width = 298
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 12
        OnChange = eGlobalChange
      end
      object lCxpCad: TStaticText
        Left = 288
        Top = 96
        Width = 41
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' C.P.'
        FocusControl = eCxpCad
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object lZipCode: TStaticText
        Left = 160
        Top = 96
        Width = 57
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lZipCode'
        FocusControl = eZipCode
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object eZipCode: TCurrencyEdit
        Left = 223
        Top = 96
        Width = 58
        Height = 21
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        DecimalPlaces = 0
        DisplayFormat = ',0;'
        TabOrder = 15
        OnChange = eGlobalChange
      end
    end
    object tsObservations: TTabSheet
      Caption = 'Observa'#231#245'es'
      ImageIndex = 1
      object mNotes: TMemo
        Left = 0
        Top = 0
        Width = 399
        Height = 141
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = eGlobalChange
      end
    end
  end
  object pgLists: TPageControl
    Left = 407
    Top = 89
    Width = 385
    Height = 172
    ActivePage = tsPhones
    Align = alRight
    Style = tsFlatButtons
    TabOrder = 2
    object tsCategories: TTabSheet
      Caption = 'Lista de Categorias'
      ImageIndex = 52
      object vtCategory: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 377
        Height = 141
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        CheckImageKind = ckXP
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        TabOrder = 0
        TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        OnChecked = vtCategoryChecked
        OnGetText = vtCategoryGetText
        OnInitNode = vtCategoryInitNode
        Columns = <
          item
            ImageIndex = 52
            Position = 0
            Width = 330
            WideText = 'Categorias do Contato'
          end>
      end
    end
    object tsPhones: TTabSheet
      Caption = 'Lista de Contatos'
      ImageIndex = 60
      object pgContacts: TPageControl
        Left = 0
        Top = 0
        Width = 377
        Height = 141
        ActivePage = tsList
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        object tsList: TTabSheet
          Caption = 'tsList'
          TabVisible = False
          object vtPhones: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 369
            Height = 131
            Align = alClient
            BevelKind = bkFlat
            BorderStyle = bsNone
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HintMode = hmDefault
            IncrementalSearchDirection = sdForward
            PopupMenu = pmContacts
            TabOrder = 0
            TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            OnDblClick = vtPhonesDblClick
            OnFocusChanged = vtPhonesFocusChanged
            OnGetText = vtPhonesGetText
            Columns = <
              item
                ImageIndex = 45
                Position = 0
                Width = 100
                WideText = 'Tipo'
              end
              item
                ImageIndex = 52
                Position = 1
                Width = 230
                WideText = 'Meio de Contato'
              end>
          end
        end
        object tsData: TTabSheet
          Caption = 'tsData'
          ImageIndex = 1
          TabVisible = False
          object sbDelete: TSpeedButton
            Left = 272
            Top = 79
            Width = 89
            Height = 22
            Caption = 'Excluir'
            Flat = True
            OnClick = sbDeleteClick
          end
          object sbIgnore: TSpeedButton
            Left = 152
            Top = 79
            Width = 89
            Height = 22
            Caption = 'Cancelar'
            Flat = True
            OnClick = sbIgnoreClick
          end
          object sbNew: TSpeedButton
            Left = 16
            Top = 79
            Width = 89
            Height = 22
            Caption = 'Inserir'
            Flat = True
            OnClick = sbNewClick
          end
          object cbPhone: TComboBox
            Left = 0
            Top = 16
            Width = 129
            Height = 21
            BevelKind = bkFlat
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 0
            TabStop = False
            OnSelect = eGlobalChange
          end
          object ePhone: TMaskEdit
            Left = 136
            Top = 16
            Width = 207
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            CharCase = ecUpperCase
            EditMask = '\(0XX99\)9900-0000;0; '
            MaxLength = 16
            TabOrder = 1
            OnChange = eGlobalChange
          end
        end
      end
    end
    object tsUsers: TTabSheet
      Caption = 'Vincular Contato'
      ImageIndex = 19
      object vtUsers: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 377
        Height = 141
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        CheckImageKind = ckXP
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        TabOrder = 0
        TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        OnGetText = vtUsersGetText
        OnInitNode = vtUsersInitNode
        Columns = <
          item
            ImageIndex = 52
            Position = 0
            Width = 330
            WideText = 'Usu'#225'rios'
          end>
      end
    end
    object tsEvents: TTabSheet
      Caption = 'Eventos'
      ImageIndex = 3
      object pgDataEvents: TPageControl
        Left = 0
        Top = 0
        Width = 377
        Height = 141
        ActivePage = tsEventsGrid
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        OnChange = pgDataEventsChange
        object tsEventsGrid: TTabSheet
          Caption = 'Lista'
          object vtEvents: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 369
            Height = 110
            Align = alClient
            BevelKind = bkFlat
            BorderStyle = bsNone
            CheckImageKind = ckXP
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HintMode = hmDefault
            IncrementalSearchDirection = sdForward
            TabOrder = 0
            TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            OnChecked = vtEventsChecked
            OnGetText = vtEventsGetText
            OnInitNode = vtEventsInitNode
            Columns = <
              item
                ImageIndex = 52
                Position = 0
                Width = 150
                WideText = 'Data'
              end
              item
                Position = 1
                Width = 180
                WideText = 'Descri'#231#227'o'
              end>
          end
        end
        object tsEventsData: TTabSheet
          Caption = 'Dados do Evento'
          ImageIndex = 1
          DesignSize = (
            369
            110)
          object sbNewEvent: TSpeedButton
            Left = 70
            Top = 83
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Inserir'
            Flat = True
            OnClick = sbNewEventClick
          end
          object sbCancelEvent: TSpeedButton
            Left = 370
            Top = 83
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Cancelar'
            Flat = True
            OnClick = sbCancelEventClick
          end
          object sbDeleteEvent: TSpeedButton
            Left = 634
            Top = 83
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Excluir'
            Flat = True
            OnClick = sbDeleteEventClick
          end
          object lDsc_Evt: TStaticText
            Left = 0
            Top = 52
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Descri'#231#227'o:'
            FocusControl = eDsc_Evt
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object eDsc_Evt: TEdit
            Left = 96
            Top = 52
            Width = 681
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkFlat
            BorderStyle = bsNone
            MaxLength = 50
            TabOrder = 2
            OnChange = eGlobalChange
          end
          object lPk_Cadastros_Eventos: TStaticText
            Left = 0
            Top = 19
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Data:'
            FocusControl = ePk_Cadastros_Eventos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object ePk_Cadastros_Eventos: TDateEdit
            Left = 96
            Top = 24
            Width = 121
            Height = 21
            BevelKind = bkFlat
            BorderStyle = bsNone
            NumGlyphs = 2
            TabOrder = 0
            OnChange = eGlobalChange
          end
          object lFlag_Inc_Evt: TCheckBox
            Left = 224
            Top = 24
            Width = 121
            Height = 17
            Caption = 'Incluir na Agenda'
            TabOrder = 1
            OnClick = lFlag_Inc_EvtClick
          end
        end
      end
    end
    object tsInternet: TTabSheet
      Caption = 'Endere'#231'os de Internet'
      ImageIndex = 4
      object pgInternetAddress: TPageControl
        Left = 0
        Top = 0
        Width = 377
        Height = 141
        ActivePage = tsAddressGrid
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        OnChange = pgInternetAddressChange
        object tsAddressGrid: TTabSheet
          Caption = 'Lista'
          object vtInternet: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 369
            Height = 110
            Align = alClient
            BevelKind = bkFlat
            BorderStyle = bsNone
            CheckImageKind = ckXP
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HintMode = hmDefault
            IncrementalSearchDirection = sdForward
            TabOrder = 0
            TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            OnChecked = vtInternetChecked
            OnChecking = vtInternetChecking
            OnGetText = vtInternetGetText
            OnGetImageIndex = vtInternetGetImageIndex
            OnInitNode = vtInternetInitNode
            Columns = <
              item
                Position = 0
                Width = 150
                WideText = 'Tipo'
              end
              item
                ImageIndex = 52
                Position = 1
                Width = 180
                WideText = 'Endere'#231'o'
              end>
          end
        end
        object tsAddressData: TTabSheet
          Caption = 'Dados do Endere'#231'o'
          ImageIndex = 1
          DesignSize = (
            369
            110)
          object sbNewAddr: TSpeedButton
            Left = 53
            Top = 201
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Inserir'
            Flat = True
            OnClick = sbNewAddrClick
          end
          object sbCancelAddr: TSpeedButton
            Left = 352
            Top = 201
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Cancelar'
            Flat = True
            OnClick = sbCancelAddrClick
          end
          object sbDeleteAddr: TSpeedButton
            Left = 616
            Top = 201
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Excluir'
            Flat = True
            OnClick = sbDeleteAddrClick
          end
          object lEnd_Cnt: TStaticText
            Left = 0
            Top = 49
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Endere'#231'o:'
            FocusControl = eEnd_Cnt
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object eEnd_Cnt: TEdit
            Left = 96
            Top = 49
            Width = 273
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkFlat
            BorderStyle = bsNone
            MaxLength = 100
            TabOrder = 1
            OnChange = eGlobalChange
          end
          object lDsc_End: TStaticText
            Left = 0
            Top = 86
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Descri'#231#227'o:'
            FocusControl = eDsc_End
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object eDsc_End: TEdit
            Left = 96
            Top = 86
            Width = 273
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkFlat
            BorderStyle = bsNone
            MaxLength = 30
            TabOrder = 2
            OnChange = eGlobalChange
          end
          object lFlag_TCnt_Int: TStaticText
            Left = 0
            Top = 11
            Width = 90
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Tipo de End.:'
            FocusControl = eFlag_TCnt_Int
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object eFlag_TCnt_Int: TPrcComboBox
            Left = 96
            Top = 11
            Width = 273
            Height = 21
            Anchors = [akLeft, akRight]
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 13
            OnSelect = eFlag_TCnt_IntSelect
            TabOrder = 0
          end
        end
      end
    end
  end
  object pmContacts: TPopupMenu
    Left = 216
    Top = 342
    object pmNew: TMenuItem
      Caption = '&Novo'
      ImageIndex = 34
      OnClick = pmNewClick
    end
    object N1: TMenuItem
      Caption = '-'
      ImageIndex = 69
    end
    object pmMoveUp: TMenuItem
      Caption = 'Mover para Ci&ma'
    end
    object pmMoveDown: TMenuItem
      Caption = 'Mover para &Baixo'
      ImageIndex = 70
    end
  end
end
