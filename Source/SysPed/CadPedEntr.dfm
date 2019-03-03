inherited CdPedEntr: TCdPedEntr
  Left = 225
  Top = 250
  Caption = 'CdPedEntr'
  ClientHeight = 95
  ClientWidth = 770
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object eMun_Entr: TPrcComboBox
    Left = 128
    Top = 72
    Width = 249
    Height = 21
    Anchors = [akLeft]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    OnSelect = ChangeGlobal
    Style = csDropDownList
    TabOrder = 1
    TypeObject = toObject
  end
  object lMun_Entr: TStaticText
    Left = 8
    Top = 72
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Munic'#237'pio: '
    FocusControl = eMun_Entr
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object lUf_Entr: TStaticText
    Left = 8
    Top = 40
    Width = 113
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Estado: '
    FocusControl = eUf_Entr
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object eUf_Entr: TPrcComboBox
    Left = 128
    Top = 40
    Width = 249
    Height = 21
    Anchors = [akLeft]
    BevelKind = bkNone
    CompareMethod = 'ComparePk'
    GetPkMethod = 'GetPkValue'
    ItemHeight = 13
    OnSelect = eUf_EntrSelect
    Style = csDropDownList
    TabOrder = 0
    TypeObject = toObject
  end
  object lEnd_Entr: TStaticText
    Left = 8
    Top = 8
    Width = 753
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Endere'#231'o de Entrega'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eEnd_Entr: TMemo
    Left = 384
    Top = 40
    Width = 377
    Height = 53
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 5
    OnChange = ChangeGlobal
  end
end
