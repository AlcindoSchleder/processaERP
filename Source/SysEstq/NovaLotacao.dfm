object fmNovaLotacao: TfmNovaLotacao
  Left = 339
  Top = 313
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Cadastramento de Lota'#231#227'o'
  ClientHeight = 127
  ClientWidth = 574
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    574
    127)
  PixelsPerInch = 96
  TextHeight = 13
  object eRua_Lot: TCurrencyEdit
    Left = 152
    Top = 104
    Width = 32
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = '00;-00'
    Anchors = [akLeft]
    MaxLength = 2
    TabOrder = 2
    OnChange = SignalizeChange
  end
  object eNivel_Lot: TCurrencyEdit
    Left = 336
    Top = 104
    Width = 32
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = '00;-00'
    Anchors = [akLeft]
    MaxLength = 2
    TabOrder = 3
    OnChange = SignalizeChange
  end
  object eBox_Lot: TEdit
    Left = 528
    Top = 104
    Width = 32
    Height = 21
    Anchors = [akRight]
    CharCase = ecUpperCase
    MaxLength = 2
    TabOrder = 4
    OnChange = SignalizeChange
  end
  object eFk_Almoxarifados: TComboBox
    Left = 152
    Top = 40
    Width = 409
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 0
    OnClick = eFk_AlmoxarifadosClick
  end
  object eCod_Ref: TEdit
    Left = 152
    Top = 72
    Width = 79
    Height = 21
    Anchors = [akLeft]
    CharCase = ecUpperCase
    TabOrder = 1
    OnExit = eCod_RefExit
  end
  object lFk_Almoxarifados: TStaticText
    Left = 8
    Top = 40
    Width = 137
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Almoxarifado :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object lCod_Ref: TStaticText
    Left = 8
    Top = 72
    Width = 137
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Produto :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lRua_Lot: TStaticText
    Left = 8
    Top = 104
    Width = 137
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Rua :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object lNivel_Lot: TStaticText
    Left = 192
    Top = 104
    Width = 137
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' N'#237'vel :'
    FocusControl = eNivel_Lot
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object lBox_Lot: TStaticText
    Left = 384
    Top = 104
    Width = 137
    Height = 21
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Box :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object stDsc_Prod: TStaticText
    Left = 240
    Top = 72
    Width = 321
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = ' Produto :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 574
    Height = 33
    Bands = <
      item
        Control = tbTools
        ImageIndex = -1
        Text = 'Ferramentas'
        Width = 570
      end>
    object tbTools: TToolBar
      Left = 71
      Top = 0
      Width = 495
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 54
      Caption = 'tbTools'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbNew: TToolButton
        Left = 0
        Top = 0
        Caption = 'Novo'
        ImageIndex = 43
      end
      object tbCancel: TToolButton
        Left = 54
        Top = 0
        Caption = 'Cancelar'
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbSep: TToolButton
        Left = 108
        Top = 0
        Width = 8
        Caption = 'tbSep'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 116
        Top = 0
        Caption = 'Salvar'
        ImageIndex = 35
        OnClick = tbSaveClick
      end
    end
  end
end
