inherited CdTipoPgtos: TCdTipoPgtos
  Left = 389
  Top = 181
  Anchors = [akRight]
  Caption = 'CdTipoPgtos'
  ClientHeight = 380
  ClientWidth = 541
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pTitle: TPanel
    Left = 8
    Top = 8
    Width = 520
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
  object eDsc_TPg: TEdit
    Left = 136
    Top = 72
    Width = 392
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    TabOrder = 1
    OnChange = ChangeGlobal
  end
  object lDsp_Fin: TStaticText
    Left = 368
    Top = 96
    Width = 97
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Desp. Financ.: '
    FocusControl = eDsp_Fin
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object ePk_Tipo_Pagamentos: TEdit
    Left = 136
    Top = 48
    Width = 105
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
    TabOrder = 0
    Text = '0'
    OnChange = ChangeGlobal
  end
  object lPk_Tipo_Pagamentos: TStaticText
    Left = 8
    Top = 48
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Pagamentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lDsc_TPg: TStaticText
    Left = 8
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TPg
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object lQtd_Par: TStaticText
    Left = 8
    Top = 96
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Quant. de Parc.: '
    FocusControl = eQtd_Par
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object eQtd_Par: TCurrencyEdit
    Left = 136
    Top = 96
    Width = 57
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object eDsp_Fin: TCurrencyEdit
    Left = 472
    Top = 96
    Width = 57
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = ',0.0000;- ,0.0000'
    Anchors = [akTop, akRight]
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object vtIntervals: TVirtualStringTree
    Left = 8
    Top = 128
    Width = 257
    Height = 244
    Anchors = [akLeft, akTop, akRight, akBottom]
    CheckImageKind = ckXP
    Colors.FocusedSelectionColor = 6730751
    Colors.FocusedSelectionBorderColor = clBtnShadow
    Colors.GridLineColor = clSilver
    Colors.SelectionRectangleBlendColor = 6730751
    Colors.UnfocusedSelectionColor = 6730751
    Ctl3D = True
    EditDelay = 0
    Header.AutoSizeIndex = 2
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
    TabOrder = 9
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus]
    OnEditing = vtIntervalsEditing
    OnGetText = vtIntervalsGetText
    OnKeyDown = vtIntervalsKeyDown
    OnNewText = vtIntervalsNewText
    Columns = <
      item
        Position = 0
        Width = 76
        WideText = 'Quantidade'
      end
      item
        Alignment = taCenter
        Position = 1
        Width = 76
        WideText = 'Operador'
      end
      item
        Position = 2
        Width = 101
        WideText = #205'ndice'
      end>
    WideDefaultText = '...'
  end
  object pgParameters: TPageControl
    Left = 272
    Top = 128
    Width = 265
    Height = 249
    ActivePage = tsParams
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 10
    object tsParams: TTabSheet
      Caption = 'Par'#226'metros'
      DesignSize = (
        257
        221)
      object lFlag_TVda: TRadioGroup
        Left = 0
        Top = 0
        Width = 257
        Height = 65
        Anchors = [akLeft, akRight]
        Caption = 'Tipo de Opera'#231#227'o'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'A Vista'
          'A Prazo '
          'Acerto Futuro'
          'Permuta')
        ParentFont = False
        TabOrder = 0
        OnClick = ChangeGlobal
      end
      object lFlag_TInt: TRadioGroup
        Left = 0
        Top = 68
        Width = 257
        Height = 57
        Anchors = [akLeft, akRight]
        Caption = 'Tipo de Intervalo'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Dias'
          'Semanas'
          'Meses'
          'Anos')
        ParentFont = False
        TabOrder = 1
        OnClick = ChangeGlobal
      end
      object lFlag_Data_Base: TRadioGroup
        Left = 0
        Top = 132
        Width = 257
        Height = 57
        Anchors = [akLeft, akRight]
        Caption = 'Data Base do Parcelamento'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Faturamento'
          'Pedido'
          'Embarque'
          'Informada')
        ParentFont = False
        TabOrder = 2
        OnClick = ChangeGlobal
      end
      object lFlag_Bloq: TCheckBox
        Left = 1
        Top = 196
        Width = 256
        Height = 17
        Anchors = [akLeft, akRight]
        Caption = 'Exigir senha ao alterar parcelas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = ChangeGlobal
      end
    end
    object tsPaymentWays: TTabSheet
      Caption = 'Formas de Pagamentos'
      ImageIndex = 91
      object vtPaymentWay: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 257
        Height = 221
        Align = alClient
        CheckImageKind = ckXP
        Colors.FocusedSelectionColor = 6730751
        Colors.FocusedSelectionBorderColor = clBtnShadow
        Colors.GridLineColor = clSilver
        Colors.SelectionRectangleBlendColor = 6730751
        Colors.UnfocusedSelectionColor = 6730751
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
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        OnBeforeItemErase = vtPaymentWayBeforeItemErase
        OnChecked = vtPaymentWayChecked
        OnChecking = vtPaymentWayChecking
        OnEditing = vtPaymentWayEditing
        OnGetText = vtPaymentWayGetText
        OnPaintText = vtPaymentWayPaintText
        OnGetNodeDataSize = vtPaymentWayGetNodeDataSize
        OnInitNode = vtPaymentWayInitNode
        Columns = <
          item
            ImageIndex = 91
            Position = 0
            Width = 257
            WideText = 'Tipos de Pagamentos'
          end>
        WideDefaultText = '...'
      end
    end
    object tsPgtWayDetail: TTabSheet
      Caption = 'tsPgtWayDetail'
      ImageIndex = 2
      TabVisible = False
      DesignSize = (
        257
        221)
      object sbPgtWayOk: TSpeedButton
        Left = 88
        Top = 176
        Width = 89
        Height = 22
        Caption = 'Ok'
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF033B8A033D90013D95023B91033A89033A89FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0357D30147B20051D0035CE007
          63E3035CE0004ED30042B7023A8F023A8FFF00FFFF00FFFF00FFFF00FFFF00FF
          0650BA0357D32781F278B4F7CAE2FCE9F4FFDCEDFF9CC7FA3F8FF20155DD0140
          A404367DFF00FFFF00FFFF00FF075DD70762E155A0F7F3F8FEFFFFFFE9F3FCC6
          DEFAD9E9FCFFFFFFFFFFFF99C5F8055DE70040A302398BFF00FFFF00FF075DD7
          529EF7FEFEFFF0F7FE5CA3F31E78EBA1C9F70D65E32D7AE9BAD7F8FFFFFF9CC9
          F80355DE02398BFF00FF0455C9207DF0E1EFFEFFFFFF358CF30F6EEEC7E0FBFF
          FFFF2F83EA004ADE0559E1BAD8F8FFFFFF3E8FF20043B7033E96085FDA56A1FA
          FFFFFF9ECBFB2D88F4D4E9FCFCFEFED7E9FC8ABDF60058E2004FE02A7BE7FFFF
          FF9FCBFA0050D4033E960F6BE68BC1FCFFFFFF56A4FC97C7FCF8FBFF4B9AF628
          82F2D9EAFC1975EB005AE5015AE2D9E9FBDEEFFF0560E202409C1B76EDA4CFFC
          FFFFFF50A0FF2586FE358FFA0E70F6096AF289BFFA6AABF6025FEA0159E5C7E1
          FAEBF6FF0C68E60141A1207AEBA5CFFEFFFFFF75B6FF1278FF1A7DFE187AFB11
          73F71979F482BBFA0E6CEE0E6CEBEFF6FECEE5FE0763E203419E146FE79ACAFC
          FFFFFFD8EBFF1F81FF1B7EFF1E81FF1A7BFC1173F7368EF72983F463A9F6FFFF
          FF81BAF80258D8033E96FF00FF237BEBEDF6FFFFFFFF98CAFF1F81FF1379FF16
          7AFF1276FB0A6EF854A0F8F0F8FFF2F8FE3089F4024FC0FF00FFFF00FF237BEB
          BFDEFFF3F8FFFFFFFFD7EAFF74B6FF53A3FE5EA9FFA3CFFEFFFFFFFFFFFF5DA6
          F70860DE024FC0FF00FFFF00FFFF00FF4997F3C7E3FFF7FBFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFE0EFFE5CA5F80E6BE70552C2FF00FFFF00FFFF00FFFF00FF
          FF00FF2D82EB91C5FBCCE6FFD9EDFFDCEDFEC4E0FE86BFFC348BF40A65E10A65
          E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF247BEB4696F34A
          98F42F87F0116CE6075FDCFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = sbPgtWayOkClick
      end
      object eFk_Finalizadoras: TPanel
        Left = 0
        Top = 48
        Width = 257
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        BevelInner = bvLowered
        Caption = 'eFk_Finalizadoras'
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object lFk_Financeiro_Contas: TStaticText
        Left = 0
        Top = 104
        Width = 257
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Conta do Financeiro:'
        FocusControl = eFk_Financeiro_Contas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object lFk_Finalizadoras: TStaticText
        Left = 0
        Top = 24
        Width = 257
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Forma de Pagamento:'
        FocusControl = eFk_Finalizadoras
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object eFk_Financeiro_Contas: TComboBox
        Left = 0
        Top = 128
        Width = 257
        Height = 22
        HelpType = htKeyword
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 3
        OnDrawItem = eFk_Financeiro_ContasDrawItem
      end
    end
  end
end
