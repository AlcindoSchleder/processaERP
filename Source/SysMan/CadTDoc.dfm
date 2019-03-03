inherited CdTypeDocs: TCdTypeDocs
  Height = 477
  Caption = 'CdTypeDocs'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 397
  end
  inherited sbStatus: TStatusBar
    Top = 430
  end
  inherited vtList: TVirtualStringTree
    Height = 397
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 397
    TabOrder = 13
  end
  object lPk_Tipo_Documentos: TStaticText
    Left = 248
    Top = 48
    Width = 137
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Documentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Tipo_Documentos: TEdit
    Left = 392
    Top = 48
    Width = 81
    Height = 21
    Anchors = [akLeft]
    Color = clTeal
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Text = '0'
  end
  object lQtd_Itm: TStaticText
    Left = 480
    Top = 48
    Width = 97
    Height = 21
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Quant. de '#205'tens: '
    FocusControl = eQtd_Itm
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eDsc_TDoc: TEdit
    Left = 392
    Top = 72
    Width = 249
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 6
    OnChange = ChangeGlobal
  end
  object lDsc_TDoc: TStaticText
    Left = 248
    Top = 72
    Width = 137
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o'
    FocusControl = eDsc_TDoc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object lFlag_TDoc: TRadioGroup
    Left = 248
    Top = 96
    Width = 393
    Height = 73
    Anchors = [akLeft, akRight]
    Caption = 'Tipo de Documento'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Nota Fiscal'
      'Boleto Banc'#225'rio'
      'Ord. de Servi'#231'os '
      'Recibos'
      'Requisi'#231#245'es'
      'Cheques'
      'Pedidos'
      'Ord. de Produ'#231#227'o'
      'Controle Interno')
    ParentFont = False
    TabOrder = 8
    OnClick = lFlag_TDocClick
  end
  object lObs_TDoc: TStaticText
    Left = 248
    Top = 176
    Width = 393
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Observa'#231#245'es'
    FocusControl = eObs_TDoc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eObs_TDoc: TMemo
    Left = 248
    Top = 200
    Width = 393
    Height = 82
    Anchors = [akLeft, akRight]
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 10
    OnChange = ChangeGlobal
  end
  object eQtd_Itm: TCurrencyEdit
    Left = 584
    Top = 48
    Width = 57
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akRight]
    TabOrder = 11
    OnChange = ChangeGlobal
  end
  object vtDocNumber: TVirtualStringTree
    Left = 248
    Top = 288
    Width = 393
    Height = 129
    Anchors = [akLeft, akTop, akRight, akBottom]
    Colors.FocusedSelectionColor = clSilver
    EditDelay = 0
    Header.AutoSizeIndex = 1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    SelectionCurveRadius = 10
    TabOrder = 12
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toRightClickSelect]
    OnGetText = vtDocNumberGetText
    OnPaintText = vtDocNumberPaintText
    Columns = <
      item
        Position = 0
        Width = 280
        WideText = 'Empresa'
      end
      item
        Alignment = taRightJustify
        Position = 1
        Width = 109
        WideText = 'N'#250'mero'
      end>
  end
end
