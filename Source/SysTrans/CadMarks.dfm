inherited CdMarks: TCdMarks
  Left = 470
  Top = 141
  Caption = 'CdMarks'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 8
    Top = 8
    Width = 431
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 15
    Width = 417
    Height = 20
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Tabela de Marcas de Ve'#237'culos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lPk_Veiculos_Marcas: TStaticText
    Left = 8
    Top = 56
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object lDsc_Mrc: TStaticText
    Left = 8
    Top = 88
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Mrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object eDsc_Mrc: TEdit
    Left = 152
    Top = 88
    Width = 252
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object vtSuppliers: TVirtualStringTree
    Left = 8
    Top = 120
    Width = 433
    Height = 124
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clBlue
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoVisible]
    Header.Style = hsXPStyle
    TabOrder = 3
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toThemeAware, toUseBlendedImages]
    OnChecked = vtSuppliersChecked
    OnChecking = vtSuppliersChecking
    OnGetText = vtSuppliersGetText
    OnPaintText = vtSuppliersPaintText
    OnGetNodeDataSize = vtSuppliersGetNodeDataSize
    Columns = <
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible]
        Position = 0
        Width = 429
        WideText = 'Selecione os Fornecedores para esta marca'
      end>
  end
  object ePk_Veiculos_Marcas: TEdit
    Left = 152
    Top = 56
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
end
