inherited CdMessage: TCdMessage
  Left = 241
  Top = 170
  Height = 355
  Caption = 'CdMessage'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 275
  end
  inherited sbStatus: TStatusBar
    Top = 308
  end
  inherited vtList: TVirtualStringTree
    Height = 275
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Height = 275
    TabOrder = 9
  end
  object lPK_Mensagens: TStaticText
    Left = 256
    Top = 64
    Width = 137
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePK_Mensagens
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePK_Mensagens: TEdit
    Left = 400
    Top = 64
    Width = 81
    Height = 21
    Anchors = [akLeft, akRight]
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Text = '0'
  end
  object lNom_Cnst: TStaticText
    Left = 256
    Top = 144
    Width = 137
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Nome da Constante: '
    FocusControl = eNom_Cnst
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object eNom_Cnst: TEdit
    Left = 400
    Top = 144
    Width = 177
    Height = 21
    Anchors = [akLeft, akRight]
    MaxLength = 20
    TabOrder = 6
    OnChange = ChangeGlobal
  end
  object eDsc_Cnst: TEdit
    Left = 256
    Top = 224
    Width = 393
    Height = 21
    Anchors = [akLeft, akRight]
    MaxLength = 100
    TabOrder = 7
    OnChange = ChangeGlobal
  end
  object lDsc_Cnst: TStaticText
    Left = 256
    Top = 200
    Width = 393
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o da Constante'
    FocusControl = eDsc_Cnst
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
end
