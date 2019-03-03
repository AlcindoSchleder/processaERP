inherited CdParams: TCdParams
  Left = 305
  Top = 146
  Height = 298
  Caption = 'CdParams'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 218
  end
  inherited sbStatus: TStatusBar
    Top = 251
  end
  inherited vtList: TVirtualStringTree
    Height = 218
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 218
    TabOrder = 14
  end
  object eFk_Tipo_Documentos: TComboBox
    Left = 384
    Top = 88
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 3
    OnSelect = ChangeGlobal
  end
  object eFk_Cadastros: TComboBox
    Left = 384
    Top = 120
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 4
    OnSelect = ChangeGlobal
  end
  object eFk_Grupos_Movimentos: TComboBox
    Left = 384
    Top = 152
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 5
    OnSelect = eFk_Grupos_MovimentosSelect
  end
  object eFk_Tipo_Movimentos: TComboBox
    Left = 384
    Top = 184
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 6
    OnSelect = ChangeGlobal
  end
  object gbTitle: TGroupBox
    Left = 248
    Top = 32
    Width = 401
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
    DesignSize = (
      401
      41)
    object lTitle: TLabel
      Left = 8
      Top = 10
      Width = 385
      Height = 24
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = 'Parametros do M'#243'dulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object lFk_Tipo_Documentos: TStaticText
    Left = 256
    Top = 88
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tipo de Doc.: '
    FocusControl = eFk_Tipo_Documentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object lFk_Cadastros: TStaticText
    Left = 256
    Top = 120
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Cliente Default: '
    FocusControl = eFk_Cadastros
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object lFk_Grupos_Movimentos: TStaticText
    Left = 256
    Top = 152
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Grupo de Venda: '
    FocusControl = eFk_Grupos_Movimentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object lFk_Tipo_Movimentos: TStaticText
    Left = 256
    Top = 184
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Venda a Vista: '
    FocusControl = eFk_Tipo_Movimentos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object eFk_Finalizadoras: TComboBox
    Left = 384
    Top = 216
    Width = 265
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 12
    OnSelect = ChangeGlobal
  end
  object lFk_Finalizadoras: TStaticText
    Left = 256
    Top = 216
    Width = 121
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Finalizadora Def.: '
    FocusControl = eFk_Finalizadoras
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
end
