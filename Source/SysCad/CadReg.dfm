inherited CdRegions: TCdRegions
  Height = 358
  Caption = 'CdRegions'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 248
    Top = 48
    Width = 392
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 256
    Top = 54
    Width = 376
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Regi'#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited spSplitter: TSplitter
    Height = 278
  end
  inherited sbStatus: TStatusBar
    Top = 311
  end
  inherited vtList: TVirtualStringTree
    Height = 278
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 278
    TabOrder = 10
  end
  object lPk_Cargas_Regioes: TStaticText
    Left = 256
    Top = 120
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Cargas_Regioes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Cargas_Regioes: TEdit
    Left = 384
    Top = 120
    Width = 113
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object lDsc_Reg: TStaticText
    Left = 256
    Top = 168
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_Reg
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eDsc_Reg: TEdit
    Left = 384
    Top = 168
    Width = 257
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 6
    OnChange = ChangeGlobal
  end
  object lRef_Reg: TStaticText
    Left = 256
    Top = 216
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Refer'#234'ncia: '
    FocusControl = eRef_Reg
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object eRef_Reg: TEdit
    Left = 384
    Top = 216
    Width = 113
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 10
    TabOrder = 8
    OnChange = ChangeGlobal
  end
  object lFlag_Generic: TCheckBox
    Left = 384
    Top = 264
    Width = 257
    Height = 17
    Caption = 'Regi'#227'o Gen'#233'rica'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = ChangeGlobal
  end
end
