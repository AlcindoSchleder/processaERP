inherited CdPedExp: TCdPedExp
  Caption = 'CdPedExp'
  ClientHeight = 96
  ClientWidth = 770
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lFk_Vw_Agentes: TStaticText
    Left = 8
    Top = 8
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Agente: '
    FocusControl = eFk_Portos__Emb
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eFk_Vw_Agentes: TPrcComboBox
    Left = 167
    Top = 8
    Width = 330
    Height = 21
    Anchors = [akLeft, akRight]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    OnSelect = ChangeGlobal
    Style = csDropDownList
    TabOrder = 0
    TypeObject = toInteger
  end
  object lNum_Pro_Forma: TStaticText
    Left = 504
    Top = 8
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'N'#250'mero da Pr'#243'-Forma: '
    FocusControl = eNum_Pro_Forma
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eNum_Pro_Forma: TCurrencyEdit
    Left = 664
    Top = 8
    Width = 96
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = '0'
    Anchors = [akRight]
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object eFk_Portos__Emb: TPrcComboBox
    Left = 167
    Top = 40
    Width = 330
    Height = 21
    Anchors = [akLeft, akRight]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    OnSelect = ChangeGlobal
    Style = csDropDownList
    TabOrder = 1
    TypeObject = toInteger
  end
  object lFk_Portos__Emb: TStaticText
    Left = 8
    Top = 40
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Porto de Embarque: '
    FocusControl = eFk_Vw_Agentes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lFk_Portos__Dst: TStaticText
    Left = 8
    Top = 72
    Width = 153
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Porto de Destino: '
    FocusControl = eFk_Vw_Agentes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eFk_Portos__Dst: TPrcComboBox
    Left = 167
    Top = 72
    Width = 330
    Height = 21
    Anchors = [akLeft, akRight]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    OnSelect = ChangeGlobal
    Style = csDropDownList
    TabOrder = 2
    TypeObject = toInteger
  end
end
