inherited frmPriceTable: TfrmPriceTable
  Left = 285
  Top = 163
  Width = 668
  Height = 398
  ActiveControl = eIniFractionalTax
  Caption = 'frmPriceTable'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 256
    Top = 40
    Width = 393
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 264
    Top = 46
    Width = 377
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Tabelas de Pre'#231'os'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited cbTools: TCoolBar
    Width = 652
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 648
      end>
    inherited tbTools: TToolBar
      Width = 571
      ButtonWidth = 89
      inherited tbCancel: TToolButton
        Left = 89
      end
      inherited tbDelete: TToolButton
        Left = 178
      end
      inherited tbSepSave: TToolButton
        Left = 267
      end
      inherited tbSave: TToolButton
        Left = 275
      end
      inherited tbSepClose: TToolButton
        Left = 364
      end
      inherited tbClose: TToolButton
        Left = 372
      end
      object tbSepNewTab: TToolButton
        Left = 461
        Top = 0
        Width = 8
        Caption = 'tbSepNewTab'
        ImageIndex = 42
        Style = tbsSeparator
        Visible = False
      end
      object tbNewTab: TToolButton
        Left = 469
        Top = 0
        Caption = 'Nova Tabela'
        ImageIndex = 11
        Visible = False
      end
    end
  end
  inherited sbStatus: TStatusBar
    Top = 341
    Width = 652
  end
  inherited vtList: TVirtualStringTree
    Height = 308
    TabOrder = 6
  end
  object lPkPriceTable: TStaticText
    Left = 256
    Top = 88
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePkPriceTable
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object ePkPriceTable: TSpinEdit
    Left = 400
    Top = 88
    Width = 57
    Height = 22
    MaxValue = 0
    MinValue = 0
    ReadOnly = True
    TabOrder = 0
    Value = 0
  end
  object lFkDomains: TStaticText
    Left = 256
    Top = 112
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Dom'#237'nio Propriet'#225'rio: '
    Enabled = False
    FocusControl = eFkDomains
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object eFkDomains: TComboBox
    Left = 400
    Top = 112
    Width = 241
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 2
  end
  object lDscTab: TStaticText
    Left = 256
    Top = 136
    Width = 137
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDscTab
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object eDscTab: TEdit
    Left = 400
    Top = 136
    Width = 241
    Height = 21
    MaxLength = 30
    TabOrder = 3
  end
  object gbVigency: TGroupBox
    Left = 256
    Top = 160
    Width = 385
    Height = 57
    Caption = 
      'Vig'#234'ncia da Tabela - Deixe a data final em branco para tabela pe' +
      'rmanente'
    TabOrder = 10
    object lDtaFin: TStaticText
      Left = 192
      Top = 24
      Width = 73
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Data Final: '
      FocusControl = eDtaFin
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object lDtaIni: TStaticText
      Left = 8
      Top = 24
      Width = 81
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Data Inicial: '
      FocusControl = eDtaIni
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object eDtaFin: TDateTimePicker
      Left = 272
      Top = 24
      Width = 105
      Height = 21
      Date = 40514.362064548610000000
      Time = 40514.362064548610000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 1
    end
    object eDtaIni: TDateTimePicker
      Left = 96
      Top = 24
      Width = 89
      Height = 21
      Date = 40514.362064548610000000
      Time = 40514.362064548610000000
      TabOrder = 0
    end
  end
  object gbTariffs: TGroupBox
    Left = 256
    Top = 224
    Width = 385
    Height = 105
    Caption = 'Dados da Tarifa'#231#227'o'
    TabOrder = 11
    object lIniFractionalTax: TStaticText
      Left = 8
      Top = 24
      Width = 73
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = '1'#186' Minuto: '
      Enabled = False
      FocusControl = eIniFractionalTax
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object eIniFractionalTax: TSpinEdit
      Left = 88
      Top = 24
      Width = 41
      Height = 22
      MaxValue = 0
      MinValue = 1
      ReadOnly = True
      TabOrder = 0
      Value = 60
    end
    object eFractionalTax: TSpinEdit
      Left = 200
      Top = 24
      Width = 41
      Height = 22
      MaxValue = 60
      MinValue = 1
      ReadOnly = True
      TabOrder = 1
      Value = 60
    end
    object lFractionalTax: TStaticText
      Left = 136
      Top = 24
      Width = 57
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Fra'#231#227'o: '
      Enabled = False
      FocusControl = eFractionalTax
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object lIniPaySec: TStaticText
      Left = 248
      Top = 24
      Width = 81
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Toler'#226'ncia: '
      Enabled = False
      FocusControl = eIniPaySec
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object eIniPaySec: TSpinEdit
      Left = 336
      Top = 24
      Width = 41
      Height = 22
      MaxValue = 20
      MinValue = 1
      ReadOnly = True
      TabOrder = 2
      Value = 3
    end
    object eFlagTab: TRadioGroup
      Left = 96
      Top = 56
      Width = 185
      Height = 41
      Caption = 'Tipo de Tabela de Pre'#231'os'
      Columns = 2
      Items.Strings = (
        'Pr'#233' Pago'
        'P'#243's Pago')
      TabOrder = 3
    end
  end
  object eFlagDefault: TCheckBox
    Left = 496
    Top = 88
    Width = 129
    Height = 17
    Caption = 'Tabela Default'
    TabOrder = 1
  end
end
