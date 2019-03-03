inherited CdEmployee: TCdEmployee
  Left = 196
  Top = 184
  Caption = 'CdEmployee'
  ClientHeight = 169
  ClientWidth = 766
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgControlEmployee: TPageControl
    Left = 0
    Top = 0
    Width = 766
    Height = 169
    ActivePage = tsE_Data
    Align = alClient
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    object tsE_Data: TTabSheet
      Caption = 'Dados do Funcion'#225'rio'
      DesignSize = (
        758
        141)
      object Shape1: TShape
        Left = 0
        Top = 48
        Width = 121
        Height = 45
        Anchors = [akLeft]
      end
      object lNatural: TLabel
        Left = 8
        Top = 62
        Width = 112
        Height = 16
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        Caption = 'Natural de: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lRaca_Cor: TStaticText
        Left = 504
        Top = 24
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Ra'#231'a: '
        FocusControl = eRaca_Cor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object eRaca_Cor: TEdit
        Tag = 9
        Left = 624
        Top = 24
        Width = 129
        Height = 21
        Anchors = [akRight]
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 7
        OnChange = ChangeGlobal
      end
      object lNum_Tit: TStaticText
        Left = 504
        Top = 48
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'T'#237'tulo Eleitoral: '
        FocusControl = eNum_Tit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object eNum_Tit: TEdit
        Tag = 9
        Left = 624
        Top = 48
        Width = 129
        Height = 21
        Anchors = [akRight]
        MaxLength = 30
        TabOrder = 8
        OnChange = ChangeGlobal
      end
      object lZona_Tit: TStaticText
        Left = 504
        Top = 96
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Zona: '
        FocusControl = eZona_Tit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object eZona_Tit: TEdit
        Tag = 9
        Left = 624
        Top = 96
        Width = 129
        Height = 21
        Anchors = [akRight]
        MaxLength = 10
        TabOrder = 10
        OnChange = ChangeGlobal
      end
      object eSecao_Tit: TEdit
        Tag = 9
        Left = 624
        Top = 72
        Width = 129
        Height = 21
        Anchors = [akRight]
        MaxLength = 10
        TabOrder = 9
        OnChange = ChangeGlobal
      end
      object lSecao_Tit: TStaticText
        Left = 504
        Top = 72
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Se'#231#227'o: '
        FocusControl = eSecao_Tit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
      end
      object lDta_Emi_Rg: TStaticText
        Left = 504
        Top = 120
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Emis. R.G.: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
      end
      object eDta_Emi_Rg: TDateEdit
        Tag = 9
        Left = 624
        Top = 120
        Width = 129
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        TabOrder = 11
        OnChange = ChangeGlobal
      end
      object eNom_Pai: TEdit
        Tag = 9
        Left = 128
        Top = 0
        Width = 369
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 0
        OnChange = ChangeGlobal
      end
      object lNom_Pai: TStaticText
        Left = 0
        Top = 0
        Width = 121
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Nome do Pai: '
        FocusControl = eNom_Pai
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object lNom_Mae: TStaticText
        Left = 0
        Top = 24
        Width = 121
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Nome da M'#227'e: '
        FocusControl = eNom_Mae
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object eNom_Mae: TEdit
        Tag = 9
        Left = 128
        Top = 24
        Width = 369
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 1
        OnChange = ChangeGlobal
      end
      object eFk_Country: TPrcComboBox
        Tag = 9
        Left = 128
        Top = 48
        Width = 185
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        Ctl3D = True
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        OnSelect = eFk_CountrySelect
        ParentCtl3D = False
        TabOrder = 2
        TypeObject = toObject
      end
      object lDta_Nasc__emp: TStaticText
        Left = 504
        Top = 0
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data de Nascim.: '
        FocusControl = eDta_Nasc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
      end
      object eDta_Nasc: TDateEdit
        Tag = 9
        Left = 624
        Top = 0
        Width = 129
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        TabOrder = 6
        OnChange = ChangeGlobal
      end
      object eFlag_Estcv: TPrcComboBox
        Tag = 9
        Left = 128
        Top = 96
        Width = 121
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        ItemIndex = 0
        Items.Strings = (
          'Solteiro'
          'Casado'
          'Divorciado'
          'Amasiado')
        OnSelect = ChangeGlobal
        Style = csDropDownList
        TabOrder = 3
        Text = 'Solteiro'
      end
      object lFlag_Estcv: TStaticText
        Left = 0
        Top = 96
        Width = 121
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Estado Civil: '
        FocusControl = eFlag_Estcv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
      end
      object lFlag_GrInstr: TStaticText
        Left = 0
        Top = 120
        Width = 121
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Forma'#231#227'o: '
        FocusControl = eFlag_GrInstr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
      end
      object eFlag_GrInstr: TPrcComboBox
        Tag = 9
        Left = 128
        Top = 120
        Width = 369
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        ItemIndex = 0
        Items.Strings = (
          'Primeiro Grau'
          'Segundo Grau'
          'Terceiro Grau'
          'Doutorado'
          'Outros')
        OnSelect = ChangeGlobal
        Style = csDropDownList
        TabOrder = 5
        Text = 'Primeiro Grau'
      end
      object lFlag_Sexo: TStaticText
        Left = 256
        Top = 96
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Sexo: '
        FocusControl = eFlag_Sexo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
      end
      object eFlag_Sexo: TPrcComboBox
        Tag = 9
        Left = 376
        Top = 96
        Width = 121
        Height = 21
        Anchors = [akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        ItemIndex = 0
        Items.Strings = (
          'Masculino'
          'Feminino'
          'Transexual')
        OnSelect = ChangeGlobal
        Style = csDropDownList
        TabOrder = 4
        Text = 'Masculino'
      end
      object eFk_State: TPrcComboBox
        Tag = 9
        Left = 312
        Top = 48
        Width = 185
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        Ctl3D = True
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        OnSelect = eFk_StateSelect
        ParentCtl3D = False
        TabOrder = 23
        TypeObject = toObject
      end
      object eFk_City: TPrcComboBox
        Tag = 9
        Left = 128
        Top = 72
        Width = 369
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        Ctl3D = True
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        OnSelect = ChangeGlobal
        ParentCtl3D = False
        TabOrder = 24
        TypeObject = toObject
      end
    end
    object tsE_Complement: TTabSheet
      Caption = 'Dados do Cargo'
      ImageIndex = 1
      DesignSize = (
        758
        141)
      object lFk_Tipo_Comissoes: TStaticText
        Left = 512
        Top = 32
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Tipo de Comis.: '
        FocusControl = eFk_Tipo_Comissoes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object eFk_Tipo_Comissoes: TPrcComboBox
        Tag = 9
        Left = 632
        Top = 32
        Width = 121
        Height = 21
        Anchors = [akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 2
      end
      object lCom_Vnd: TStaticText
        Left = 512
        Top = 56
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Comiss'#227'o: '
        FocusControl = eCom_Vnd
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object eCom_Vnd: TCurrencyEdit
        Tag = 9
        Left = 632
        Top = 56
        Width = 121
        Height = 21
        AutoSize = False
        DisplayFormat = ',0.00 %;- ,0.00 %'
        Anchors = [akRight]
        TabOrder = 3
        OnChange = ChangeGlobal
      end
      object lNum_Func: TStaticText
        Left = 512
        Top = 8
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Matr'#237'cula: '
        FocusControl = eNum_Func
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object lDsct_Max: TStaticText
        Left = 512
        Top = 80
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Desconto M'#225'x.: '
        FocusControl = eDsct_Max
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object eDsct_Max: TCurrencyEdit
        Tag = 9
        Left = 632
        Top = 80
        Width = 121
        Height = 21
        AutoSize = False
        DisplayFormat = ',0.00 %;- ,0.00 %'
        Anchors = [akRight]
        TabOrder = 4
        OnChange = ChangeGlobal
      end
      object lFlag_Crg: TRadioGroup
        Tag = 9
        Left = 0
        Top = 0
        Width = 505
        Height = 49
        Anchors = [akLeft, akRight]
        Caption = 'Tipo de Cargo:'
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Administra'#231#227'o'
          'Ger'#234'ncia'
          'Vendedor'
          'Representante'
          'T'#233'cnico'
          'Outros')
        ParentFont = False
        TabOrder = 0
        OnClick = ChangeGlobal
      end
      object lFk_Departamentos: TStaticText
        Left = 0
        Top = 56
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Departamento: '
        FocusControl = eFk_Departamentos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object eFk_Departamentos: TPrcComboBox
        Tag = 9
        Left = 176
        Top = 56
        Width = 329
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 5
        TypeObject = toInteger
      end
      object eFk_Setor: TPrcComboBox
        Tag = 9
        Left = 176
        Top = 80
        Width = 329
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 6
        TypeObject = toInteger
      end
      object lFk_Setor: TStaticText
        Left = 0
        Top = 80
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Setor: '
        FocusControl = eFk_Setor
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object lFk_Centro_Custos: TStaticText
        Left = 0
        Top = 104
        Width = 169
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Centro de Custos / Cargo: '
        FocusControl = eFk_Centro_Custos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
      end
      object eFk_Centro_Custos: TPrcComboBox
        Tag = 9
        Left = 176
        Top = 104
        Width = 329
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        Ctl3D = True
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        ParentCtl3D = False
        TabOrder = 7
        TypeObject = toInteger
      end
      object eFk_Cargos: TPrcComboBox
        Tag = 9
        Left = 512
        Top = 104
        Width = 241
        Height = 21
        Anchors = [akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 8
        TypeObject = toInteger
      end
      object eNum_Func: TCurrencyEdit
        Tag = 9
        Left = 632
        Top = 8
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akRight]
        TabOrder = 1
        OnChange = ChangeGlobal
      end
    end
    object tsE_Complement2: TTabSheet
      Caption = 'Dados de Registro'
      ImageIndex = 1
      DesignSize = (
        758
        141)
      object lAno_Cheg: TStaticText
        Left = 0
        Top = 24
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Ano Migra'#231#227'o: '
        FocusControl = eAno_Cheg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
      end
      object lTipo_Visto: TStaticText
        Left = 0
        Top = 48
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Tipo de Visto: '
        FocusControl = eTipo_Visto
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object eTipo_Visto: TEdit
        Tag = 9
        Left = 112
        Top = 48
        Width = 129
        Height = 21
        Anchors = [akLeft]
        CharCase = ecUpperCase
        MaxLength = 20
        TabOrder = 4
        OnChange = ChangeGlobal
      end
      object lDta_Apst: TStaticText
        Left = 504
        Top = 24
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Aposent.: '
        FocusControl = eDta_Apst
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object eDta_Apst: TDateEdit
        Tag = 9
        Left = 624
        Top = 24
        Width = 129
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        TabOrder = 7
        OnChange = ChangeGlobal
      end
      object lSit_Apst: TStaticText
        Left = 504
        Top = 48
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Sit. Aposent.: '
        FocusControl = eSit_Apst
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
      end
      object eSit_Apst: TEdit
        Tag = 9
        Left = 624
        Top = 48
        Width = 129
        Height = 21
        Anchors = [akRight]
        CharCase = ecUpperCase
        MaxLength = 20
        TabOrder = 8
        OnChange = ChangeGlobal
      end
      object lFlag_Apst: TCheckBox
        Tag = 9
        Left = 368
        Top = 24
        Width = 129
        Height = 17
        Anchors = [akLeft, akRight]
        Caption = 'Aposentado? '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = ChangeGlobal
      end
      object lFlag_Def: TCheckBox
        Tag = 9
        Left = 248
        Top = 23
        Width = 113
        Height = 17
        Anchors = [akLeft]
        Caption = 'Padr'#227'o?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = ChangeGlobal
      end
      object lNom_Conslh: TStaticText
        Left = 0
        Top = 0
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Conselho Reg.: '
        FocusControl = eNom_Conslh
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
      end
      object eNom_Conslh: TEdit
        Tag = 9
        Left = 112
        Top = 0
        Width = 129
        Height = 21
        Anchors = [akLeft]
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 0
        OnChange = ChangeGlobal
      end
      object lHab_Prof: TStaticText
        Left = 248
        Top = 0
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Habil. Profis.: '
        FocusControl = eHab_Prof
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
      end
      object eHab_Prof: TEdit
        Tag = 9
        Left = 368
        Top = 0
        Width = 129
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 1
        OnChange = ChangeGlobal
      end
      object lNum_Reg: TStaticText
        Left = 504
        Top = 0
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'm. do Reg.: '
        FocusControl = eNum_Reg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
      end
      object eNum_Reg: TEdit
        Tag = 9
        Left = 624
        Top = 0
        Width = 129
        Height = 21
        Anchors = [akRight]
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 2
        OnChange = ChangeGlobal
      end
      object eAno_Cheg: TCurrencyEdit
        Tag = 9
        Left = 112
        Top = 24
        Width = 129
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akLeft]
        TabOrder = 3
        OnChange = ChangeGlobal
      end
      object lRef_Livro: TStaticText
        Left = 248
        Top = 48
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'm. no Livro: '
        FocusControl = eRef_Livro
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 23
      end
      object lNum_Ctps: TStaticText
        Left = 0
        Top = 72
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'm. C.T.P.S.: '
        FocusControl = eNum_Ctps
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 24
      end
      object lSer_Ctps: TStaticText
        Left = 248
        Top = 72
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'S'#233'rie C.T.P.S.: '
        FocusControl = eSer_Ctps
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
      end
      object eSer_Ctps: TEdit
        Tag = 9
        Left = 368
        Top = 72
        Width = 129
        Height = 21
        Anchors = [akLeft, akRight]
        MaxLength = 10
        TabOrder = 11
        OnChange = ChangeGlobal
      end
      object lDta_Exp__emp: TStaticText
        Left = 504
        Top = 72
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data de Exp.: '
        FocusControl = eDta_Exp
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 26
      end
      object eDta_Exp: TDateEdit
        Tag = 9
        Left = 624
        Top = 72
        Width = 129
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        TabOrder = 12
        OnChange = ChangeGlobal
      end
      object lUf_Ctps: TStaticText
        Left = 0
        Top = 96
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Estado C.T.P.S.: '
        FocusControl = eUf_Ctps
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 27
      end
      object eUf_Ctps: TPrcComboBox
        Tag = 10
        Left = 112
        Top = 96
        Width = 385
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 13
        TypeObject = toObject
      end
      object lPis_Func: TStaticText
        Left = 504
        Top = 120
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'mero do P.I.S.: '
        FocusControl = ePis_Func
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 28
      end
      object ePis_Func: TEdit
        Tag = 9
        Left = 624
        Top = 120
        Width = 129
        Height = 21
        Anchors = [akRight]
        MaxLength = 30
        TabOrder = 15
        OnChange = ChangeGlobal
      end
      object lDta_Cad: TStaticText
        Left = 504
        Top = 96
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data de Cad. PIS: '
        FocusControl = eDta_Cad
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 29
      end
      object eDta_Cad: TDateEdit
        Tag = 9
        Left = 624
        Top = 96
        Width = 129
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        TabOrder = 14
        OnChange = ChangeGlobal
      end
      object eNum_Ctps: TCurrencyEdit
        Tag = 9
        Left = 112
        Top = 72
        Width = 129
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akLeft]
        TabOrder = 10
        OnChange = ChangeGlobal
      end
      object eRef_Livro: TCurrencyEdit
        Tag = 9
        Left = 368
        Top = 48
        Width = 129
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akLeft]
        TabOrder = 9
        OnChange = ChangeGlobal
      end
    end
    object tsE_Complement3: TTabSheet
      Caption = 'Dados da Folha'
      ImageIndex = 3
      DesignSize = (
        758
        141)
      object lPerc_Ins: TStaticText
        Left = 0
        Top = 96
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = '% de Insalubr.: '
        FocusControl = ePerc_Ins
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object ePerc_Ins: TCurrencyEdit
        Tag = 9
        Left = 112
        Top = 96
        Width = 113
        Height = 21
        AutoSize = False
        DisplayFormat = ',0.00 %;- ,0.00 %'
        Anchors = [akLeft]
        TabOrder = 5
        OnChange = ChangeGlobal
      end
      object lNom_Sind: TStaticText
        Left = 232
        Top = 0
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Sindicato: '
        FocusControl = eNom_Sind
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object eNom_Sind: TEdit
        Tag = 9
        Left = 344
        Top = 0
        Width = 409
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 30
        TabOrder = 1
        OnChange = ChangeGlobal
      end
      object eVal_Sal: TCurrencyEdit
        Tag = 9
        Left = 112
        Top = 72
        Width = 113
        Height = 21
        AutoSize = False
        Anchors = [akLeft]
        TabOrder = 4
        OnChange = ChangeGlobal
      end
      object lVlr_Sal: TStaticText
        Left = 0
        Top = 72
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Valor Sal'#225'rio: '
        FocusControl = eVal_Sal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
      end
      object lQtd_Horas: TStaticText
        Left = 0
        Top = 48
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Quant. Horas: '
        FocusControl = eQtd_Horas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
      end
      object lNum_Dep_IR: TStaticText
        Left = 528
        Top = 72
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Qtd. Dep. I.R.: '
        FocusControl = eNum_Dep_IR
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
      end
      object lDta_Nasc_Filho: TStaticText
        Left = 528
        Top = 120
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Nas. Filho: '
        FocusControl = eDta_Nasc_Filho
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
      end
      object eDta_Nasc_Filho: TDateEdit
        Tag = 9
        Left = 640
        Top = 120
        Width = 113
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        TabOrder = 13
        OnChange = ChangeGlobal
      end
      object lQtd_Filho: TStaticText
        Left = 528
        Top = 96
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Qtd. Filhos: '
        FocusControl = eQtd_Filho
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 23
      end
      object lFlag_Tempr: TCheckBox
        Tag = 9
        Left = 344
        Top = 96
        Width = 177
        Height = 17
        Anchors = [akLeft, akRight]
        Caption = 'Tempor'#225'rio? '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = ChangeGlobal
      end
      object lFlag_Opprv: TCheckBox
        Tag = 9
        Left = 344
        Top = 112
        Width = 177
        Height = 17
        Anchors = [akLeft, akRight]
        Caption = 'Optante Previd'#234'ncia?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnClick = ChangeGlobal
      end
      object lCod_Ctb: TStaticText
        Left = 232
        Top = 72
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C'#243'd. Cont'#225'bil: '
        FocusControl = eCod_Ctb
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 24
      end
      object eCod_Ctb: TCurrencyEdit
        Tag = 9
        Left = 344
        Top = 72
        Width = 113
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akLeft, akRight]
        TabOrder = 14
        OnChange = ChangeGlobal
      end
      object lFk_Bancos__FGTS: TStaticText
        Left = 232
        Top = 48
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Banco F.G.T.S.: '
        FocusControl = eFk_Bancos_FGTS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
      end
      object eFk_Bancos_FGTS: TPrcComboBox
        Tag = 9
        Left = 344
        Top = 48
        Width = 177
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 9
        TypeObject = toObject
      end
      object eConta_Vinc: TEdit
        Tag = 9
        Left = 640
        Top = 48
        Width = 113
        Height = 21
        Anchors = [akRight]
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 10
        OnChange = ChangeGlobal
      end
      object lDta_Adm__emp: TStaticText
        Left = 0
        Top = 0
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data Admiss.: '
        FocusControl = eDta_Adm
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 26
      end
      object eDta_Adm: TDateEdit
        Tag = 9
        Left = 112
        Top = 0
        Width = 113
        Height = 21
        Anchors = [akLeft]
        NumGlyphs = 2
        TabOrder = 0
        OnChange = ChangeGlobal
      end
      object lFlag_TSal: TStaticText
        Left = 0
        Top = 24
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Tipo de Sal'#225'rio: '
        FocusControl = eFlag_TSal
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 27
      end
      object eFlag_TSal: TPrcComboBox
        Tag = 9
        Left = 112
        Top = 24
        Width = 113
        Height = 21
        Anchors = [akLeft]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        ItemIndex = 0
        Items.Strings = (
          'Mensal'
          'Semanal'
          'Quinzena'
          'Bimestral'
          'Trimestral'
          'Semestral'
          'Anual')
        OnSelect = ChangeGlobal
        Style = csDropDownList
        TabOrder = 2
        Text = 'Mensal'
      end
      object lPerc_Peric: TStaticText
        Left = 0
        Top = 120
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = '% de Periculos.: '
        FocusControl = ePerc_Peric
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 28
      end
      object ePerc_Peric: TCurrencyEdit
        Tag = 9
        Left = 112
        Top = 120
        Width = 113
        Height = 21
        AutoSize = False
        DisplayFormat = ',0.00 %;- ,0.00 %'
        Anchors = [akLeft]
        TabOrder = 6
        OnChange = ChangeGlobal
      end
      object eFk_Bancos: TPrcComboBox
        Tag = 9
        Left = 344
        Top = 24
        Width = 177
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 7
        TypeObject = toObject
      end
      object lConta_Vinc: TStaticText
        Left = 528
        Top = 48
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Conta F.G.T.S.: '
        FocusControl = eConta_Vinc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 29
      end
      object eConta: TEdit
        Tag = 9
        Left = 640
        Top = 24
        Width = 113
        Height = 21
        Anchors = [akRight]
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 8
        OnChange = ChangeGlobal
      end
      object lConta: TStaticText
        Left = 528
        Top = 24
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Conta: '
        FocusControl = eConta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 30
      end
      object lFk_Bancos__emp: TStaticText
        Left = 232
        Top = 24
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Banco: '
        FocusControl = eFk_Bancos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 31
      end
      object eQtd_Horas: TCurrencyEdit
        Tag = 9
        Left = 112
        Top = 48
        Width = 113
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akLeft]
        TabOrder = 3
        OnChange = ChangeGlobal
      end
      object eNum_Dep_IR: TCurrencyEdit
        Tag = 9
        Left = 640
        Top = 72
        Width = 113
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akRight]
        TabOrder = 11
        OnChange = ChangeGlobal
      end
      object eQtd_Filho: TCurrencyEdit
        Tag = 9
        Left = 640
        Top = 96
        Width = 113
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Anchors = [akRight]
        TabOrder = 12
        OnChange = ChangeGlobal
      end
    end
  end
end
