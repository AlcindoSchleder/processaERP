inherited CdTipoComponentes: TCdTipoComponentes
  Caption = 'CdTipoComponentes'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 248
    Top = 37
    Width = 393
    Height = 25
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 256
    Top = 42
    Width = 377
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Tipos de Componentes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited vtList: TVirtualStringTree
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    TabOrder = 7
  end
  object lDsc_TComp: TStaticText
    Left = 256
    Top = 160
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TComp
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object eDsc_TComp: TEdit
    Left = 384
    Top = 160
    Width = 257
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object ePk_Tipo_Componentes: TEdit
    Left = 384
    Top = 96
    Width = 113
    Height = 21
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    Text = '0'
  end
  object lPk_Tipo_Componentes: TStaticText
    Left = 256
    Top = 96
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Componentes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
end
