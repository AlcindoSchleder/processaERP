inherited CdTipoEnd: TCdTipoEnd
  Caption = 'CdTipoEnd'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 248
    Top = 48
    Width = 392
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 256
    Top = 54
    Width = 376
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Tipos de Endere'#231'os'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
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
  object lPk_Tipo_Enderecos: TStaticText
    Left = 256
    Top = 120
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Tipo_Enderecos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Tipo_Enderecos: TEdit
    Left = 384
    Top = 120
    Width = 113
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object lDsc_Tpe: TStaticText
    Left = 256
    Top = 168
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o'
    FocusControl = eDsc_Tpe
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eDsc_Tpe: TEdit
    Left = 384
    Top = 168
    Width = 257
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 6
    OnChange = ChangeGlobal
  end
end
