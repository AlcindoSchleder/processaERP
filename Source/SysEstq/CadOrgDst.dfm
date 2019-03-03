inherited CdOrgmDstn: TCdOrgmDstn
  Height = 313
  Caption = 'CdOrgmDstn'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 248
    Top = 40
    Width = 393
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 256
    Top = 46
    Width = 377
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro das Fra'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited spSplitter: TSplitter
    Height = 233
  end
  inherited sbStatus: TStatusBar
    Top = 266
  end
  inherited vtList: TVirtualStringTree
    Height = 233
    TabOrder = 12
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 233
    TabOrder = 13
  end
  object lPk_Tabela_Origem_Destino: TStaticText
    Left = 248
    Top = 95
    Width = 129
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Tabela_Origem_Destino
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object ePk_Tabela_Origem_Destino: TEdit
    Left = 384
    Top = 95
    Width = 73
    Height = 21
    Anchors = [akLeft, akRight]
    Enabled = False
    TabOrder = 0
  end
  object lFk_Cargas_Regioes__Org: TStaticText
    Left = 248
    Top = 127
    Width = 129
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Regi'#227'o de Origem: '
    FocusControl = eFk_Cargas_Regioes__Org
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object eFk_Cargas_Regioes__Org: TComboBox
    Left = 384
    Top = 127
    Width = 257
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 1
    TabStop = False
  end
  object lFk_Cargas_Regioes__Dst: TStaticText
    Left = 248
    Top = 159
    Width = 129
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Regi'#227'o de Destino: '
    FocusControl = eFk_Cargas_Regioes__Dst
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eFk_Cargas_Regioes__Dst: TComboBox
    Left = 384
    Top = 159
    Width = 257
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 2
    TabStop = False
  end
  object lFk_Pazo_Entrega: TStaticText
    Left = 248
    Top = 192
    Width = 129
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Prazo de Entrega: '
    FocusControl = eFk_Prazo_Entrega
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eFk_Prazo_Entrega: TComboBox
    Left = 384
    Top = 192
    Width = 257
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 3
    TabStop = False
  end
  object lVlr_Min: TStaticText
    Left = 248
    Top = 221
    Width = 129
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Valor do M'#237'nimo: '
    FocusControl = eVlr_Min
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object eVlr_Min: TCurrencyEdit
    Left = 384
    Top = 221
    Width = 105
    Height = 21
    AutoSize = False
    CheckOnExit = True
    Anchors = [akLeft]
    TabOrder = 4
    ZeroEmpty = False
  end
end
