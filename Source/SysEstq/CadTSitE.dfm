inherited CdTSitEstq: TCdTSitEstq
  Caption = 'CdTSitEstq'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited vtList: TVirtualStringTree
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    TabOrder = 8
  end
  object lPk_Tipo_Situacao_Estoques: TStaticText
    Left = 248
    Top = 64
    Width = 113
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Situacao_Estoques
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Tipo_Situacao_Estoques: TEdit
    Left = 368
    Top = 64
    Width = 89
    Height = 21
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
  object eDsc_Tse: TEdit
    Left = 368
    Top = 128
    Width = 273
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lDsc_Tse: TStaticText
    Left = 248
    Top = 128
    Width = 113
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Tse
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lFlag_Bloq: TCheckBox
    Left = 368
    Top = 192
    Width = 273
    Height = 17
    Caption = 'Bloquear Movimenta'#231#227'o do Estoque'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = ChangeGlobal
  end
end
