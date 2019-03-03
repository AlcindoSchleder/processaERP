object CdContacts: TCdContacts
  Left = 265
  Top = 176
  BorderStyle = bsNone
  Caption = 'CdContacts'
  ClientHeight = 467
  ClientWidth = 369
  Color = 16776176
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
  object pButtons: TPanel
    Left = 0
    Top = 432
    Width = 369
    Height = 35
    Align = alBottom
    BevelInner = bvLowered
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      369
      35)
    object sbOk: TSpeedButton
      Left = 16
      Top = 8
      Width = 129
      Height = 22
      Anchors = [akTop]
      Caption = 'sbOk'
      Flat = True
      OnClick = sbOkClick
    end
    object sbCancel: TSpeedButton
      Left = 224
      Top = 8
      Width = 129
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      Caption = 'sbCancel'
      Flat = True
      OnClick = sbCancelClick
    end
  end
  object pgEvents: TPageControl
    Left = 0
    Top = 21
    Width = 369
    Height = 411
    ActivePage = tsBasicData
    Align = alClient
    TabOrder = 1
    object tsBasicData: TTabSheet
      Caption = 'tsBasicData'
      ImageIndex = 23
      DesignSize = (
        361
        383)
      object lName: TStaticText
        Left = 8
        Top = 73
        Width = 90
        Height = 21
        Anchors = [akLeft]
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
        TabOrder = 7
      end
      object lTitle: TStaticText
        Left = 8
        Top = 8
        Width = 90
        Height = 21
        Anchors = [akLeft]
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
        TabOrder = 8
      end
      object lCompany: TStaticText
        Left = 8
        Top = 137
        Width = 90
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lCompany'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object lPosition: TStaticText
        Left = 8
        Top = 169
        Width = 90
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lPosition'
        FocusControl = ePosition
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object eName: TEdit
        Left = 104
        Top = 73
        Width = 257
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 4
        OnChange = eGlobalChange
      end
      object eTitle: TEdit
        Left = 104
        Top = 8
        Width = 121
        Height = 21
        Anchors = [akLeft, akRight]
        MaxLength = 20
        TabOrder = 0
        OnChange = eGlobalChange
      end
      object ePosition: TEdit
        Left = 104
        Top = 169
        Width = 257
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 30
        TabOrder = 6
        OnChange = eGlobalChange
      end
      object pgContacts: TPageControl
        Left = 0
        Top = 203
        Width = 361
        Height = 180
        ActivePage = tsPhones
        Align = alBottom
        TabOrder = 11
        OnChange = pgContactsChange
        object tsPhones: TTabSheet
          Caption = 'Lista de Contatos'
          ImageIndex = 60
          object pgList: TPageControl
            Left = 0
            Top = 0
            Width = 353
            Height = 152
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
                Width = 345
                Height = 142
                Align = alClient
                Header.AutoSizeIndex = 0
                Header.Font.Charset = DEFAULT_CHARSET
                Header.Font.Color = clWindowText
                Header.Font.Height = -11
                Header.Font.Name = 'MS Sans Serif'
                Header.Font.Style = []
                Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
                Header.Style = hsXPStyle
                HintAnimation = hatNone
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
                Left = 256
                Top = 71
                Width = 89
                Height = 22
                Caption = 'Excluir'
                Flat = True
                OnClick = sbDeleteClick
              end
              object sbIgnore: TSpeedButton
                Left = 136
                Top = 71
                Width = 89
                Height = 22
                Caption = 'Cancelar'
                Flat = True
                OnClick = sbIgnoreClick
              end
              object sbNew: TSpeedButton
                Left = 0
                Top = 71
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
                Style = csDropDownList
                ItemHeight = 0
                TabOrder = 0
                TabStop = False
                OnSelect = eGlobalChange
              end
              object ePhone: TMaskEdit
                Left = 136
                Top = 16
                Width = 203
                Height = 21
                EditMask = '!\(\0xx99\)9000-0000;0; '
                MaxLength = 16
                TabOrder = 1
                OnChange = eGlobalChange
              end
            end
          end
        end
        object tsPhoneList: TTabSheet
          Caption = 'Lista de Telefones'
          ImageIndex = 3
          object vtPhoneList: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 353
            Height = 152
            Align = alClient
            Header.AutoSizeIndex = 2
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            TabOrder = 0
            TreeOptions.MiscOptions = [toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            OnGetText = vtPhoneListGetText
            Columns = <
              item
                ImageIndex = 1
                Position = 0
                Width = 184
                WideText = 'Nome'
              end
              item
                ImageIndex = 45
                Position = 1
                Width = 70
                WideText = 'Tipo'
              end
              item
                ImageIndex = 52
                Position = 2
                Width = 99
                WideText = 'N'#250'mero'
              end>
            WideDefaultText = ''
          end
        end
        object tsCategories: TTabSheet
          Caption = 'Lista de Categorias'
          ImageIndex = 52
          object vtCategory: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 353
            Height = 152
            Align = alClient
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
        object tsUsers: TTabSheet
          Caption = 'Vincular Contato'
          ImageIndex = 19
          object vtUsers: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 353
            Height = 152
            Align = alClient
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
            TabOrder = 0
            TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            OnChecked = vtUsersChecked
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
      end
      object lTypeCad: TRadioGroup
        Left = 232
        Top = 0
        Width = 129
        Height = 33
        Anchors = [akRight]
        Caption = 'Tipo de Contato'
        Columns = 2
        Items.Strings = (
          'Jur'#237'dica'
          'F'#237'sica')
        TabOrder = 1
        OnClick = lTypeCadClick
      end
      object lDocPri: TStaticText
        Left = 8
        Top = 40
        Width = 90
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' C.P.F.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object eDocPri: TMaskEdit
        Left = 104
        Top = 40
        Width = 88
        Height = 21
        Anchors = [akLeft]
        EditMask = '###.###.###-##;0; '
        MaxLength = 14
        TabOrder = 2
        OnChange = eGlobalChange
      end
      object lDocSec: TStaticText
        Left = 200
        Top = 40
        Width = 66
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' I.E.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object eDocSec: TMaskEdit
        Left = 272
        Top = 40
        Width = 89
        Height = 21
        Anchors = [akLeft, akRight]
        TabOrder = 3
        OnChange = eGlobalChange
      end
      object lNomFan: TStaticText
        Left = 8
        Top = 105
        Width = 90
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Nome Fant.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object cbCompany: TPrcComboBox
        Left = 104
        Top = 137
        Width = 257
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        OnChange = eGlobalChange
        TabOrder = 5
        TypeObject = toObject
      end
      object eNickName: TPrcComboBox
        Left = 104
        Top = 105
        Width = 257
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        DropDownCount = 4
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        OnChange = eGlobalChange
        TabOrder = 15
        TypeObject = toInteger
      end
    end
    object tsAddress: TTabSheet
      Caption = 'tsAddress'
      ImageIndex = 77
      DesignSize = (
        361
        383)
      object lAddress: TStaticText
        Left = 8
        Top = 99
        Width = 90
        Height = 21
        Anchors = [akLeft]
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
        TabOrder = 9
      end
      object eAddress: TEdit
        Left = 104
        Top = 99
        Width = 257
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 3
        OnChange = eGlobalChange
      end
      object lCountry: TStaticText
        Left = 8
        Top = 0
        Width = 90
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lCountry'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object lState: TStaticText
        Left = 8
        Top = 33
        Width = 90
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lState'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object lCity: TStaticText
        Left = 8
        Top = 66
        Width = 90
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'lCity'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object lZipCode: TStaticText
        Left = 192
        Top = 132
        Width = 82
        Height = 21
        Anchors = [akLeft]
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
        TabOrder = 13
      end
      object lNumEnd: TStaticText
        Left = 8
        Top = 132
        Width = 90
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' N'#250'mero:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object eNumEnd: TCurrencyEdit
        Left = 104
        Top = 132
        Width = 81
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0;'
        Anchors = [akLeft]
        TabOrder = 4
        OnChange = eGlobalChange
      end
      object lCmpEnd: TStaticText
        Left = 8
        Top = 163
        Width = 90
        Height = 21
        Anchors = [akLeft]
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
        TabOrder = 15
      end
      object eCmpEnd: TEdit
        Left = 104
        Top = 163
        Width = 257
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 6
        OnChange = eGlobalChange
      end
      object lCxpCad: TStaticText
        Left = 8
        Top = 197
        Width = 89
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Caixa Postal:'
        FocusControl = eCxpCad
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
      end
      object eCxpCad: TEdit
        Left = 104
        Top = 197
        Width = 81
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 7
        OnChange = eGlobalChange
      end
      object mNotes: TMemo
        Left = 0
        Top = 249
        Width = 361
        Height = 134
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 8
        OnChange = eGlobalChange
      end
      object stNotes: TStaticText
        Left = 0
        Top = 228
        Width = 361
        Height = 21
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Observa'#231#245'es'
        FocusControl = eCxpCad
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object eZipCode: TCurrencyEdit
        Left = 280
        Top = 132
        Width = 81
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0;'
        Anchors = [akLeft]
        TabOrder = 5
        OnChange = eGlobalChange
      end
      object cbCountry: TPrcComboBox
        Left = 104
        Top = 0
        Width = 257
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = cbCountrySelect
        TabOrder = 0
        TypeObject = toObject
      end
      object cbState: TPrcComboBox
        Left = 104
        Top = 32
        Width = 257
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = cbStateSelect
        TabOrder = 1
        TypeObject = toObject
      end
      object cbCity: TPrcComboBox
        Left = 104
        Top = 65
        Width = 257
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnChange = eGlobalChange
        TabOrder = 2
        TypeObject = toObject
      end
    end
    object tsComplements: TTabSheet
      Caption = 'Eventos e Internet'
      ImageIndex = 60
      object Splitter1: TSplitter
        Left = 0
        Top = 193
        Width = 361
        Height = 6
        Cursor = crVSplit
        Align = alTop
        Beveled = True
      end
      object pgDataEvents: TPageControl
        Left = 0
        Top = 0
        Width = 361
        Height = 193
        ActivePage = tsEventsGrid
        Align = alTop
        TabOrder = 0
        OnChange = pgDataEventsChange
        object tsEventsGrid: TTabSheet
          Caption = 'Lista'
          object vtEvents: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 353
            Height = 165
            Align = alClient
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
            353
            165)
          object sbNewEvent: TSpeedButton
            Left = 8
            Top = 138
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Inserir'
            Flat = True
            OnClick = sbNewEventClick
          end
          object sbCancelEvent: TSpeedButton
            Left = 144
            Top = 138
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Cancelar'
            Flat = True
            OnClick = sbCancelEventClick
          end
          object sbDeleteEvent: TSpeedButton
            Left = 264
            Top = 138
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Excluir'
            Flat = True
            OnClick = sbDeleteEventClick
          end
          object lDsc_Evt: TStaticText
            Left = 0
            Top = 82
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
            Top = 82
            Width = 257
            Height = 21
            Anchors = [akLeft, akRight]
            MaxLength = 50
            TabOrder = 2
            OnChange = eGlobalChange
          end
          object lPk_Cadastros_Eventos: TStaticText
            Left = 0
            Top = 33
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
            Top = 32
            Width = 121
            Height = 21
            NumGlyphs = 2
            TabOrder = 0
            OnChange = eGlobalChange
          end
          object lFlag_Inc_Evt: TCheckBox
            Left = 232
            Top = 32
            Width = 121
            Height = 17
            Caption = 'Incluir na Agenda'
            TabOrder = 1
            OnClick = lFlag_Inc_EvtClick
          end
        end
      end
      object pgInternetAddress: TPageControl
        Left = 0
        Top = 199
        Width = 361
        Height = 184
        ActivePage = tsAddressGrid
        Align = alClient
        TabOrder = 1
        OnChange = pgInternetAddressChange
        object tsAddressGrid: TTabSheet
          Caption = 'Lista'
          object vtInternet: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 353
            Height = 156
            Align = alClient
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
            353
            156)
          object sbNewAddr: TSpeedButton
            Left = 0
            Top = 125
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Inserir'
            Flat = True
            OnClick = sbNewAddrClick
          end
          object sbCancelAddr: TSpeedButton
            Left = 136
            Top = 125
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Cancelar'
            Flat = True
            OnClick = sbCancelAddrClick
          end
          object sbDeleteAddr: TSpeedButton
            Left = 256
            Top = 125
            Width = 89
            Height = 22
            Anchors = [akBottom]
            Caption = 'Excluir'
            Flat = True
            OnClick = sbDeleteAddrClick
          end
          object lEnd_Cnt: TStaticText
            Left = 0
            Top = 42
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
            Top = 42
            Width = 257
            Height = 21
            Anchors = [akLeft, akRight]
            MaxLength = 100
            TabOrder = 1
            OnChange = eGlobalChange
          end
          object lDsc_End: TStaticText
            Left = 0
            Top = 75
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
            Top = 75
            Width = 257
            Height = 21
            Anchors = [akLeft, akRight]
            MaxLength = 30
            TabOrder = 2
            OnChange = eGlobalChange
          end
          object lFlag_TCnt_Int: TStaticText
            Left = 0
            Top = 9
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
            Top = 9
            Width = 257
            Height = 21
            Anchors = [akLeft, akRight]
            BevelKind = bkNone
            CompareMethod = 'ComparePk'
            GetPkMethod = 'GetPkValue'
            ItemHeight = 0
            OnSelect = eFlag_TCnt_IntSelect
            TabOrder = 0
          end
        end
      end
    end
  end
  object pHeader: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pHeader'
    TabOrder = 2
    object stStatus: TStaticText
      Left = 241
      Top = 0
      Width = 128
      Height = 21
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'stStatus'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object stCaption: TStaticText
      Left = 0
      Top = 0
      Width = 241
      Height = 21
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = 'Cadastro de Eventos '
      Color = clBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 1
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
