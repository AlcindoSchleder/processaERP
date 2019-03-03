inherited CdTipoProd: TCdTipoProd
  Left = 225
  Top = 158
  Height = 550
  Caption = 'CdTipoProd'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 248
    Top = 168
    Width = 393
    Height = 25
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 256
    Top = 173
    Width = 377
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Sele'#231#227'o das Opera'#231#245'es Permitidas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited spSplitter: TSplitter
    Height = 470
  end
  inherited sbStatus: TStatusBar
    Top = 503
  end
  inherited vtList: TVirtualStringTree
    Height = 470
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 470
    TabOrder = 9
  end
  object lPk_Tipo_Produtos: TStaticText
    Left = 248
    Top = 48
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Produtos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Tipo_Produtos: TEdit
    Left = 376
    Top = 48
    Width = 81
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
    TabOrder = 4
    Text = '0'
  end
  object lDsc_TPrd: TStaticText
    Left = 248
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TPrd
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eDsc_TPrd: TEdit
    Left = 376
    Top = 72
    Width = 265
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    TabOrder = 6
    OnChange = ChangeGlobal
  end
  object lFlag_TProd: TRadioGroup
    Left = 248
    Top = 96
    Width = 393
    Height = 65
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Categoria do Produto'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Produtos p/ Venda'
      'Produtos p/ Compra'
      'Presta'#231#227'o de Servi'#231'os'
      'Componentes de Produ'#231#227'o'
      'Patrim'#244'nio')
    ParentFont = False
    TabOrder = 7
    OnClick = ChangeGlobal
  end
  object vtCfop: TVirtualStringTree
    Left = 248
    Top = 200
    Width = 393
    Height = 293
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clBlue
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.Style = hsXPStyle
    SelectionCurveRadius = 10
    TabOrder = 8
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnBeforeItemErase = vtCfopBeforeItemErase
    OnChecked = vtCfopChecked
    OnChecking = vtCfopChecking
    OnGetText = vtCfopGetText
    OnPaintText = vtCfopPaintText
    OnInitNode = vtCfopInitNode
    Columns = <
      item
        Position = 0
        Width = 100
        WideText = 'C'#243'digo'
      end
      item
        Position = 1
        Width = 289
        WideText = 'Descri'#231#227'o'
      end>
  end
end
