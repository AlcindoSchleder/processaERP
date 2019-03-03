inherited CdEmpresa: TCdEmpresa
  Left = 161
  Top = 127
  Width = 800
  Height = 501
  Caption = 'CdEmpresa'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 421
  end
  inherited cbTools: TCoolBar
    Width = 792
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 788
      end>
    inherited tbTools: TToolBar
      Width = 711
    end
  end
  inherited sbStatus: TStatusBar
    Top = 454
    Width = 792
  end
  inherited vtList: TVirtualStringTree
    Height = 421
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Width = 546
    Height = 421
    TabOrder = 4
  end
  object pgControl: TPageControl
    Left = 246
    Top = 33
    Width = 546
    Height = 421
    ActivePage = tsCompany
    Align = alClient
    TabOrder = 3
    OnChange = pgControlChange
    object tsCompany: TTabSheet
      Caption = 'Empresas'
      DesignSize = (
        538
        393)
      object sbCep: TSpeedButton
        Left = 315
        Top = 289
        Width = 21
        Height = 22
        Anchors = [akLeft]
        Flat = True
      end
      object pPanel: TPanel
        Left = 405
        Top = 0
        Width = 109
        Height = 113
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvLowered
        BevelOuter = bvNone
        BevelWidth = 2
        Color = clWindow
        TabOrder = 0
        object eLogo_Emp: TImage
          Left = 2
          Top = 2
          Width = 105
          Height = 109
          Align = alClient
          Stretch = True
          OnDblClick = eLogo_EmpDblClick
        end
      end
      object lPk_Empresas: TStaticText
        Left = 8
        Top = 8
        Width = 148
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C'#243'digo: '
        FocusControl = ePk_Empresas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object ePk_Empresas: TCurrencyEdit
        Left = 168
        Top = 8
        Width = 69
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0'
        Anchors = [akLeft]
        TabOrder = 2
        OnChange = ChangeGlobal
      end
      object eCnpj_Emp: TMaskEdit
        Left = 168
        Top = 48
        Width = 181
        Height = 21
        Anchors = [akLeft]
        EditMask = '00.000.000/0000-00;0; '
        MaxLength = 18
        TabOrder = 3
        OnChange = ChangeGlobal
      end
      object lCnpj_Emp: TStaticText
        Left = 8
        Top = 48
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C.N.P.J.: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object lInscr_Est: TStaticText
        Left = 8
        Top = 88
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Inscri'#231#227'o Estadual: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object eInscr_Est: TMaskEdit
        Left = 168
        Top = 88
        Width = 178
        Height = 21
        Anchors = [akLeft]
        TabOrder = 6
        OnChange = ChangeGlobal
      end
      object eRaz_Soc: TEdit
        Left = 168
        Top = 120
        Width = 365
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        TabOrder = 7
        OnChange = ChangeGlobal
      end
      object lRaz_Soc: TStaticText
        Left = 8
        Top = 120
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Raz'#227'o Social: '
        FocusControl = eRaz_Soc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object lNom_Fan: TStaticText
        Left = 8
        Top = 144
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Nome Fantasia: '
        FocusControl = eNom_Fan
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object eNom_Fan: TEdit
        Left = 168
        Top = 144
        Width = 365
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        TabOrder = 10
        OnChange = ChangeGlobal
      end
      object eFk_Paises: TComboBox
        Left = 168
        Top = 168
        Width = 365
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        ItemHeight = 13
        TabOrder = 11
        OnSelect = eFk_PaisesSelect
      end
      object lFk_Paises: TStaticText
        Left = 8
        Top = 168
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Pa'#237's: '
        FocusControl = eFk_Paises
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object lFk_Estados: TStaticText
        Left = 8
        Top = 192
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Estado: '
        FocusControl = eFk_Estados
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object eFk_Estados: TComboBox
        Left = 168
        Top = 192
        Width = 365
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        ItemHeight = 13
        TabOrder = 14
        OnSelect = eFk_EstadosSelect
      end
      object eFk_Municipios: TComboBox
        Left = 168
        Top = 217
        Width = 365
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        ItemHeight = 13
        TabOrder = 15
        OnSelect = ChangeGlobal
      end
      object lFk_Municipios: TStaticText
        Left = 8
        Top = 217
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Munici'#237'pio: '
        FocusControl = eFk_Municipios
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
      end
      object lEnd_Emp: TStaticText
        Left = 8
        Top = 241
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Endere'#231'o: '
        FocusControl = eEnd_Emp
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object eEnd_Emp: TEdit
        Left = 168
        Top = 241
        Width = 298
        Height = 21
        Anchors = [akLeft]
        CharCase = ecUpperCase
        TabOrder = 18
        OnChange = ChangeGlobal
      end
      object eCmp_Emp: TEdit
        Left = 168
        Top = 265
        Width = 365
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        TabOrder = 19
        OnChange = ChangeGlobal
      end
      object lCmp_Emp: TStaticText
        Left = 8
        Top = 265
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Complemento do End.: '
        FocusControl = eCmp_Emp
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
      end
      object lCep_Emp: TStaticText
        Left = 8
        Top = 289
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Cep: '
        FocusControl = eCep_Emp
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
      end
      object eCep_Emp: TCurrencyEdit
        Left = 168
        Top = 289
        Width = 141
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0'
        Anchors = [akLeft]
        TabOrder = 22
        OnChange = ChangeGlobal
      end
      object lCod_Atv: TStaticText
        Left = 8
        Top = 313
        Width = 149
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C'#243'digo da Atividade: '
        FocusControl = eCod_Atv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 23
      end
      object eCod_Atv: TEdit
        Left = 168
        Top = 313
        Width = 165
        Height = 21
        Anchors = [akLeft]
        CharCase = ecUpperCase
        TabOrder = 24
        OnChange = ChangeGlobal
      end
      object eFon_Cmcl: TMaskEdit
        Left = 168
        Top = 337
        Width = 167
        Height = 21
        Anchors = [akLeft]
        EditMask = '!\(\0\x\x99\)0000-0000;0; '
        MaxLength = 16
        TabOrder = 25
        OnChange = ChangeGlobal
      end
      object lFon_Cmcl: TStaticText
        Left = 8
        Top = 337
        Width = 150
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Telefone Comercial: '
        FocusControl = eFon_Cmcl
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 26
      end
      object lFon_Fax: TStaticText
        Left = 8
        Top = 361
        Width = 151
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Fax: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 27
      end
      object eFon_Fax: TMaskEdit
        Left = 168
        Top = 361
        Width = 169
        Height = 21
        Anchors = [akLeft]
        EditMask = '!\(\0\x\x99\)0000-0000;0; '
        MaxLength = 16
        TabOrder = 28
        OnChange = ChangeGlobal
      end
      object lTip_Emp: TRadioGroup
        Left = 344
        Top = 289
        Width = 192
        Height = 97
        Anchors = [akTop, akBottom]
        Caption = 'Tipo de Empresa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Matriz'
          'Filial'
          'Dep'#243'sito')
        ParentFont = False
        TabOrder = 29
        OnClick = ChangeGlobal
      end
      object eNum_End: TCurrencyEdit
        Left = 472
        Top = 241
        Width = 65
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0'
        Anchors = [akRight]
        TabOrder = 30
        OnChange = ChangeGlobal
      end
    end
    object tsParams: TTabSheet
      Caption = 'Par'#226'metros'
      ImageIndex = 1
    end
  end
end
