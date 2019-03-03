inherited CdTypeTax: TCdTypeTax
  Left = 484
  Top = 194
  Caption = 'CdTypeTax'
  ClientHeight = 415
  ClientWidth = 396
  OldCreateOrder = True
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pgMain: TPageControl
    Left = 0
    Top = 278
    Width = 396
    Height = 137
    ActivePage = tsMessage
    Align = alBottom
    TabOrder = 1
    object tsMessage: TTabSheet
      Caption = 'Mensagem a ser Impressa'
      object eMsg_Imp: TMemo
        Left = 0
        Top = 0
        Width = 388
        Height = 109
        Align = alClient
        TabOrder = 0
        OnChange = ChangeGlobal
      end
    end
    object tsFinance: TTabSheet
      Caption = 'Gera'#231#227'o do Financeiro'
      ImageIndex = 1
      DesignSize = (
        388
        109)
      object lFkPlanoContas__SalesCR: TStaticText
        Left = 0
        Top = 8
        Width = 129
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Conta Vendas CR: '
        FocusControl = eFkPlanoContas__SalesCR
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object lFkPlanoContas__SalesDB: TStaticText
        Left = 0
        Top = 32
        Width = 129
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Conta Vendas DB: '
        FocusControl = eFkPlanoContas__SalesDB
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object lFkPlanoContas__PurchCR: TStaticText
        Left = 0
        Top = 56
        Width = 129
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Conta Compras CR: '
        FocusControl = eFkPlanoContas__PurchCR
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object lFkPlanoContas__PurchDB: TStaticText
        Left = 0
        Top = 80
        Width = 129
        Height = 20
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Conta Compras DB: '
        FocusControl = eFkPlanoContas__PurchDB
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object eFkPlanoContas__SalesCR: TComboBox
        Left = 136
        Top = 8
        Width = 249
        Height = 22
        Style = csOwnerDrawFixed
        Anchors = [akLeft, akRight]
        ItemHeight = 16
        TabOrder = 4
        OnDrawItem = FkPlanoContasDrawItem
        OnSelect = eFkPlanoContasSelect
      end
      object eFkPlanoContas__SalesDB: TComboBox
        Left = 136
        Top = 32
        Width = 249
        Height = 22
        Style = csOwnerDrawFixed
        Anchors = [akLeft, akRight]
        ItemHeight = 16
        TabOrder = 5
        OnDrawItem = FkPlanoContasDrawItem
        OnSelect = eFkPlanoContasSelect
      end
      object eFkPlanoContas__PurchCR: TComboBox
        Left = 136
        Top = 56
        Width = 249
        Height = 22
        Style = csOwnerDrawFixed
        Anchors = [akLeft, akRight]
        ItemHeight = 16
        TabOrder = 6
        OnDrawItem = FkPlanoContasDrawItem
        OnSelect = eFkPlanoContasSelect
      end
      object eFkPlanoContas__PurchDB: TComboBox
        Left = 136
        Top = 80
        Width = 249
        Height = 22
        Style = csOwnerDrawFixed
        Anchors = [akLeft, akRight]
        ItemHeight = 16
        TabOrder = 7
        OnDrawItem = FkPlanoContasDrawItem
        OnSelect = eFkPlanoContasSelect
      end
    end
    object tsRanges: TTabSheet
      Caption = 'Faixa de Valores'
      ImageIndex = 2
      TabVisible = False
      object vtList: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 388
        Height = 109
        Align = alClient
        Colors.FocusedSelectionColor = clSilver
        EditDelay = 0
        Header.AutoSizeIndex = 2
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        ScrollBarOptions.AlwaysVisible = True
        ScrollBarOptions.ScrollBars = ssVertical
        SelectionCurveRadius = 10
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus]
        OnDblClick = vtListDblClick
        OnGetText = vtListGetText
        OnKeyDown = vtListKeyDown
        OnNewText = vtListNewText
        Columns = <
          item
            Alignment = taRightJustify
            Position = 0
            Width = 130
            WideText = 'In'#237'cio'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 130
            WideText = 'Fim'
          end
          item
            Alignment = taRightJustify
            Position = 2
            Width = 128
            WideText = 'Al'#237'quota'
          end>
        WideDefaultText = ''
      end
    end
  end
  object pData: TPanel
    Left = 0
    Top = 0
    Width = 396
    Height = 278
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      396
      278)
    object lFlag_Impst: TRadioGroup
      Left = 8
      Top = 168
      Width = 376
      Height = 105
      Anchors = [akLeft, akRight]
      Caption = 'Tipo do Imposto'
      Columns = 2
      Items.Strings = (
        'ICMS'
        'ICMS Substitui'#231#227'o'
        'ICMS Isento'
        'IPI'
        'ISSQN'
        'INSS'
        'IRRF'
        'PIS/COFINS/Contribui'#231#227'o Social'
        'Outros')
      TabOrder = 8
      OnClick = ChangeGlobal
    end
    object lFlag_Dstc: TCheckBox
      Left = 8
      Top = 104
      Width = 376
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Imposto deve ser destacado no corpo do Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = ChangeGlobal
    end
    object lFlag_Ret: TCheckBox
      Left = 8
      Top = 88
      Width = 376
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Imposto deve ser Retido na Fonte'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = ChangeGlobal
    end
    object lFlag_Calc: TCheckBox
      Left = 8
      Top = 72
      Width = 376
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Destacar imposto como base de c'#225'lculo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ChangeGlobal
    end
    object lDsc_Imps: TStaticText
      Left = 8
      Top = 40
      Width = 97
      Height = 20
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Descri'#231#227'o: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object eDsc_Imps: TEdit
      Left = 112
      Top = 40
      Width = 272
      Height = 21
      Anchors = [akLeft, akRight]
      CharCase = ecUpperCase
      MaxLength = 30
      TabOrder = 2
      Text = 'EDSC_IMPS'
      OnChange = ChangeGlobal
    end
    object lPk_Tipo_Impostos: TStaticText
      Left = 8
      Top = 8
      Width = 97
      Height = 20
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'C'#243'digo: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object ePk_Tipo_Impostos: TEdit
      Left = 112
      Top = 8
      Width = 73
      Height = 21
      Anchors = [akLeft]
      Color = clTeal
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = '0'
    end
    object lRed_BasC: TStaticText
      Left = 192
      Top = 8
      Width = 129
      Height = 20
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Red. Base de C'#225'lc.: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object eRed_BasC: TCurrencyEdit
      Left = 328
      Top = 8
      Width = 56
      Height = 21
      AutoSize = False
      DecimalPlaces = 4
      DisplayFormat = ',0.0000'
      Anchors = [akLeft, akRight]
      MaxValue = 99.999900000000000000
      TabOrder = 1
      OnChange = ChangeGlobal
    end
    object lFlag_Alqt_Unica: TCheckBox
      Left = 8
      Top = 120
      Width = 376
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Imposto deve conter uma '#250'nica al'#237'quota'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = ChangeGlobal
    end
    object lFlag_Range: TCheckBox
      Left = 8
      Top = 136
      Width = 376
      Height = 17
      Anchors = [akLeft, akRight]
      Caption = 'Al'#237'quotas do Imposto por faixas de valores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = lFlag_RangeClick
    end
  end
end
