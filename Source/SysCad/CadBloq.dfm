inherited CdBloqueio: TCdBloqueio
  Left = 260
  Top = 214
  Width = 635
  Caption = 'CdBloqueio'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited cbTools: TCoolBar
    Width = 627
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 623
      end>
    inherited tbTools: TToolBar
      Width = 546
    end
  end
  inherited sbStatus: TStatusBar
    Width = 627
  end
  inherited vtList: TVirtualStringTree
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Width = 381
    TabOrder = 9
  end
  object gbParams: TGroupBox
    Left = 364
    Top = 112
    Width = 253
    Height = 105
    Caption = 'Tipos de Bloqueio '
    TabOrder = 3
    object lFlag_VaVs: TCheckBox
      Left = 8
      Top = 16
      Width = 185
      Height = 17
      Caption = 'Compra Somente '#224' Vista'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = ChangeGlobal
    end
    object lFlag_MPgt: TCheckBox
      Left = 8
      Top = 32
      Width = 225
      Height = 17
      Caption = 'Bloquear Tipo de Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = ChangeGlobal
    end
    object lFlag_DtaBas: TCheckBox
      Left = 8
      Top = 48
      Width = 177
      Height = 17
      Caption = 'Bloquear DataBase'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = ChangeGlobal
    end
    object lFlag_CondP: TCheckBox
      Left = 8
      Top = 64
      Width = 233
      Height = 17
      Caption = 'Bloquear Condi'#231#227'o de Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ChangeGlobal
    end
    object lFlag_LimCr: TCheckBox
      Left = 8
      Top = 80
      Width = 193
      Height = 17
      Caption = 'Bloquear Limite de Cr'#233'dito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = ChangeGlobal
    end
  end
  object eDsc_Blk: TEdit
    Left = 365
    Top = 82
    Width = 236
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object ePk_Tipo_Bloqueios: TEdit
    Left = 365
    Top = 50
    Width = 113
    Height = 21
    TabOrder = 5
  end
  object lPk_Tipo_Bloqueios: TStaticText
    Left = 253
    Top = 50
    Width = 108
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Bloqueios
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object lDsc_Blk: TStaticText
    Left = 253
    Top = 82
    Width = 108
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Blk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object lFlag_Blq: TCheckBox
    Left = 489
    Top = 53
    Width = 128
    Height = 17
    Caption = 'Cliente Bloqueado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = ChangeGlobal
  end
end
