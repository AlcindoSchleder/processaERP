inherited frmCdCenary: TfrmCdCenary
  Width = 700
  Height = 295
  Caption = 'frmCdCenary'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 264
    Top = 40
    Width = 417
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 272
    Top = 46
    Width = 401
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro dos Cen'#225'rios Financeiros'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited spSplitter: TSplitter
    Height = 215
  end
  inherited cbTools: TCoolBar
    Width = 692
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 688
      end>
    inherited tbTools: TToolBar
      Width = 611
    end
  end
  inherited sbStatus: TStatusBar
    Top = 248
    Width = 692
  end
  inherited vtList: TVirtualStringTree
    Height = 215
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Width = 446
    Height = 215
    TabOrder = 8
  end
  object lPk_Cenarios_Financeiros: TStaticText
    Left = 264
    Top = 88
    Width = 121
    Height = 20
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Cenarios_Financeiros
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Cenarios_Financeiros: TCurrencyEdit
    Left = 392
    Top = 88
    Width = 81
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = '0;-,0'
    Enabled = False
    Anchors = [akLeft]
    MaxLength = 5
    TabOrder = 4
  end
  object lDsc_Cen: TStaticText
    Left = 264
    Top = 136
    Width = 123
    Height = 20
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Cen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eDsc_Cen: TEdit
    Left = 392
    Top = 136
    Width = 289
    Height = 21
    TabStop = False
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 50
    TabOrder = 6
    OnChange = ChangeGlobal
  end
  object lFlag_TpCen: TRadioGroup
    Left = 264
    Top = 184
    Width = 417
    Height = 41
    Anchors = [akLeft, akRight]
    Caption = 'Tipo da Cen'#225'rio'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Base'
      'Simulado')
    ParentFont = False
    TabOrder = 7
    OnClick = ChangeGlobal
  end
end
