inherited CdTypeDiscount: TCdTypeDiscount
  Caption = 'CdTypeDiscount'
  ClientHeight = 298
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lDsc_TDsct: TStaticText
    Left = 8
    Top = 64
    Width = 153
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TDsct
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object eDsc_TDsct: TEdit
    Left = 168
    Top = 64
    Width = 273
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    TabOrder = 1
    OnChange = ChangeGlobal
  end
  object ePk_Tipo_Descontos: TEdit
    Left = 168
    Top = 40
    Width = 97
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Text = '0'
  end
  object lPk_Tipo_Descontos: TStaticText
    Left = 8
    Top = 40
    Width = 153
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Descontos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object pTitle: TPanel
    Left = 8
    Top = 8
    Width = 433
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    Caption = 'pTitle'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object pgMain: TPageControl
    Left = 8
    Top = 128
    Width = 433
    Height = 161
    ActivePage = tsList
    Anchors = [akLeft, akTop, akRight, akBottom]
    MultiLine = True
    TabOrder = 5
    TabPosition = tpBottom
    object tsList: TTabSheet
      Caption = #205'ndices'
      TabVisible = False
      DesignSize = (
        425
        153)
      object vtList: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 425
        Height = 153
        Anchors = [akLeft, akTop, akRight, akBottom]
        Colors.FocusedSelectionColor = clSilver
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        SelectionCurveRadius = 10
        TabOrder = 0
        TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toRightClickSelect]
        OnDblClick = vtListDblClick
        OnFocusChanged = vtListFocusChanged
        OnGetText = vtListGetText
        Columns = <
          item
            Position = 0
            Width = 311
            WideText = 'Categoria'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 110
            WideText = #205'ndice'
          end>
      end
    end
    object tsDetail: TTabSheet
      Caption = 'tsDetail'
      ImageIndex = 1
      TabVisible = False
      DesignSize = (
        425
        153)
      object lFlag_TDsct: TRadioGroup
        Left = 0
        Top = 96
        Width = 425
        Height = 53
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Tipo de Desconto'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Percentual'
          #205'ndice Multiplicador'
          #205'ndice Divisor'
          'Valor')
        ParentFont = False
        TabOrder = 0
        OnClick = ChangeGlobal
      end
      object eFk_Categorias: TComboBox
        Left = 96
        Top = 0
        Width = 329
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 1
        OnSelect = ChangeGlobal
      end
      object lFk_Categorias: TStaticText
        Left = 0
        Top = 0
        Width = 89
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Categoria: '
        FocusControl = eFk_Categorias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object lFk_Paises: TStaticText
        Left = 0
        Top = 24
        Width = 89
        Height = 21
        Alignment = taRightJustify
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
        TabOrder = 3
      end
      object eFk_Paises: TComboBox
        Left = 96
        Top = 24
        Width = 329
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 4
        OnSelect = ChangeGlobal
      end
      object lFk_Estados: TStaticText
        Left = 0
        Top = 48
        Width = 89
        Height = 21
        Alignment = taRightJustify
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
        TabOrder = 5
      end
      object eFk_Estados: TComboBox
        Left = 96
        Top = 48
        Width = 329
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 6
        OnSelect = ChangeGlobal
      end
      object lIdx_Dsct: TStaticText
        Left = 0
        Top = 72
        Width = 89
        Height = 21
        Alignment = taRightJustify
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = #205'ndice: '
        FocusControl = eIdx_Dsct
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object eIdx_Dsct: TCurrencyEdit
        Left = 96
        Top = 72
        Width = 49
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.0000;- ,0.0000'
        TabOrder = 8
        OnChange = ChangeGlobal
      end
      object lFlag_Dstq: TCheckBox
        Left = 152
        Top = 72
        Width = 273
        Height = 17
        Caption = 'Destacar desconto no documento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = ChangeGlobal
      end
    end
  end
  object gbTools: TGroupBox
    Left = 8
    Top = 88
    Width = 433
    Height = 33
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
    DesignSize = (
      433
      33)
    object sbSave: TSpeedButton
      Left = 405
      Top = 8
      Width = 21
      Height = 21
      Hint = 'Confirmar | Confirma as atualiza'#231#245'es'
      Anchors = [akTop, akRight, akBottom]
      Layout = blGlyphTop
      OnClick = sbSaveClick
    end
    object sbCancel: TSpeedButton
      Left = 381
      Top = 8
      Width = 21
      Height = 21
      Hint = 'Cancelar | Cancela as altera'#231#245'es do '#237'ndice'
      Anchors = [akTop, akRight, akBottom]
      Layout = blGlyphTop
      OnClick = sbCancelClick
    end
    object sbDelete: TSpeedButton
      Left = 357
      Top = 8
      Width = 21
      Height = 21
      Hint = 'Exclui '#205'ndice | Exclui  o '#237'ndice selecionado'
      Anchors = [akTop, akRight, akBottom]
      Layout = blGlyphTop
      OnClick = sbDeleteClick
    end
    object sbInsert: TSpeedButton
      Left = 333
      Top = 8
      Width = 21
      Height = 21
      Hint = 'Novo '#205'ndice | Insere novo '#237'ndice para o desconto'
      Anchors = [akTop, akRight, akBottom]
      Layout = blGlyphTop
      OnClick = sbInsertClick
    end
    object lTitleIdx: TLabel
      Left = 7
      Top = 10
      Width = 322
      Height = 16
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = #205'ndices Aplicados no Desconto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
