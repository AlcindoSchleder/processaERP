inherited CdTypeFraction: TCdTypeFraction
  Caption = 'CdTypeFraction'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 248
    Top = 40
    Width = 397
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 256
    Top = 46
    Width = 381
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Tipos de Tabelas Fracionadas'
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
    TabOrder = 8
  end
  object lPk_Tabela_Precos: TStaticText
    Left = 248
    Top = 110
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tabela: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object lFlag_Tipo: TRadioGroup
    Left = 248
    Top = 143
    Width = 397
    Height = 82
    Anchors = [akLeft, akRight]
    Caption = 'Tipo de Tabela'
    Columns = 2
    Items.Strings = (
      'Sem Fra'#231#227'o'
      'Fra'#231#245'es de peso'
      'Fra'#231#245'es de Percentual Nota Fiscal'
      'Fra'#231#245'es de Volume (m3)'
      'Fra'#231#245'es de Quantidade de Volumes')
    TabOrder = 4
  end
  object eDsc_Tab: TEdit
    Left = 376
    Top = 110
    Width = 269
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 5
  end
  object lPkTipoTabelaFracao: TStaticText
    Left = 248
    Top = 86
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Codigo: '
    FocusControl = ePkTipoTabelaFracao
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object ePkTipoTabelaFracao: TEdit
    Left = 376
    Top = 86
    Width = 81
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    Enabled = False
    MaxLength = 30
    TabOrder = 7
  end
end
