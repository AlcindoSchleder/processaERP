inherited CdSupplier: TCdSupplier
  Left = 202
  Top = 94
  Caption = 'CdSupplier'
  ClientHeight = 159
  ClientWidth = 768
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgMain: TPageControl
    Left = 0
    Top = 0
    Width = 768
    Height = 159
    ActivePage = tbCarrierData
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object tbDefaultSupplier: TTabSheet
      Caption = 'Fornecedores'
      DesignSize = (
        760
        128)
      object lNom_Vnd: TStaticText
        Left = 8
        Top = 8
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Nome do Vendedor: '
        FocusControl = eNom_Vnd
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eNom_Vnd: TEdit
        Left = 168
        Top = 8
        Width = 209
        Height = 21
        Anchors = [akLeft]
        CharCase = ecUpperCase
        TabOrder = 1
        OnChange = ChangeGlobal
      end
      object eFk_Tipo_Pagamentos: TPrcComboBox
        Left = 168
        Top = 31
        Width = 209
        Height = 21
        Anchors = [akLeft]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 2
        TypeObject = toObject
      end
      object lFk_Tipo_Pagamentos: TStaticText
        Left = 8
        Top = 31
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Cond. de Pagamento'
        FocusControl = eFk_Tipo_Pagamentos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object lFlag_Prod_Def: TCheckBox
        Left = 384
        Top = 9
        Width = 369
        Height = 17
        Anchors = [akRight]
        Caption = 'Empresa com produto padr'#227'o'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = ChangeGlobal
      end
      object lFk_Vw_Cadastros: TStaticText
        Left = 384
        Top = 55
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Agente Portu'#225'rio: '
        FocusControl = eFk_Vw_Cadastros
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object eFk_Vw_Cadastros: TPrcComboBox
        Left = 544
        Top = 55
        Width = 209
        Height = 21
        Anchors = [akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 6
      end
      object eFk_Portos_Emb: TPrcComboBox
        Left = 544
        Top = 78
        Width = 209
        Height = 21
        Anchors = [akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 7
      end
      object lFk_Portos_Emb: TStaticText
        Left = 384
        Top = 78
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Porto de Embarque: '
        FocusControl = eFk_Portos_Emb
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object lFk_Portos_Dst: TStaticText
        Left = 384
        Top = 102
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Porto de Destino: '
        FocusControl = eFk_Portos_Dst
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object eFk_Portos_Dst: TPrcComboBox
        Left = 544
        Top = 102
        Width = 209
        Height = 21
        Anchors = [akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 10
      end
      object eFk_Tipo_Descontos: TPrcComboBox
        Left = 168
        Top = 101
        Width = 209
        Height = 21
        Anchors = [akLeft]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 11
      end
      object eFk_Vw_Transportadoras: TPrcComboBox
        Left = 168
        Top = 78
        Width = 209
        Height = 21
        Anchors = [akLeft]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 12
      end
      object lFk_Vw_Transportadoras: TStaticText
        Left = 8
        Top = 78
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Transportadora: '
        FocusControl = eFk_Vw_Transportadoras
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object lFk_Tipo_Descontos: TStaticText
        Left = 8
        Top = 101
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Descontos Padr'#227'o: '
        FocusControl = eFk_Tipo_Descontos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object lFk_Tabela_Precos: TStaticText
        Left = 8
        Top = 54
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Tabela de Pre'#231'os: '
        FocusControl = eFk_Tabela_Precos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
      end
      object eFk_Tabela_Precos: TPrcComboBox
        Left = 168
        Top = 54
        Width = 209
        Height = 21
        Anchors = [akLeft]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        TabOrder = 16
      end
      object lFlag_Trn: TCheckBox
        Left = 384
        Top = 33
        Width = 369
        Height = 17
        Anchors = [akRight]
        Caption = 'Fornecedor '#233' uma transportadora?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnClick = lFlag_TrnClick
      end
    end
    object tbCarrierData: TTabSheet
      Caption = 'Transportadoras'
      ImageIndex = 1
      TabVisible = False
      DesignSize = (
        760
        128)
      object lFk_Tipo_Tabela_Fracao: TStaticText
        Left = 8
        Top = 31
        Width = 153
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Tipo de Fra'#231#227'o: '
        FocusControl = eFk_Tipo_Tabela_Fracao
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eFk_Tipo_Tabela_Fracao: TPrcComboBox
        Left = 168
        Top = 31
        Width = 209
        Height = 21
        Anchors = [akLeft, akRight]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 13
        OnSelect = ChangeGlobal
        TabOrder = 1
        TypeObject = toInteger
      end
      object vtRegions: TVirtualStringTree
        Left = 400
        Top = 8
        Width = 353
        Height = 118
        Anchors = [akTop, akRight, akBottom]
        CheckImageKind = ckXP
        Ctl3D = True
        EditDelay = 0
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clBlue
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        HotCursor = crHandPoint
        ParentCtl3D = False
        SelectionCurveRadius = 20
        TabOrder = 2
        TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
        TreeOptions.MiscOptions = [toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        Columns = <
          item
            ImageIndex = 9
            Position = 0
            Width = 349
            WideText = 'Regi'#245'es atendidas'
          end>
        WideDefaultText = '...'
      end
    end
  end
end
