inherited CdTypeStatus: TCdTypeStatus
  Left = 395
  Top = 296
  Width = 628
  Height = 320
  Caption = 'CdTypeStatus'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape [0]
    Left = 248
    Top = 40
    Width = 365
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 256
    Top = 47
    Width = 353
    Height = 20
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Tabela de Tipos de Status'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited spSplitter: TSplitter
    Height = 240
  end
  inherited cbTools: TCoolBar
    Width = 620
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 616
      end>
    inherited tbTools: TToolBar
      Width = 539
    end
  end
  inherited sbStatus: TStatusBar
    Top = 273
    Width = 620
  end
  inherited vtList: TVirtualStringTree
    Height = 240
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    Width = 374
    Height = 240
    TabOrder = 8
  end
  object lPk_Manifestos_Status: TStaticText
    Left = 248
    Top = 96
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Enabled = False
    FocusControl = ePk_Manifestos_Status
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ePk_Manifestos_Status: TEdit
    Left = 360
    Top = 96
    Width = 141
    Height = 21
    Anchors = [akLeft, akRight]
    Color = 8421440
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
  end
  object eDsc_MStt: TEdit
    Left = 360
    Top = 128
    Width = 252
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lFlag_Niv_Occ: TRadioGroup
    Left = 248
    Top = 160
    Width = 365
    Height = 89
    Anchors = [akLeft, akRight]
    Caption = 'Tipos de Conhecimentos'
    Columns = 2
    Items.Strings = (
      'Nenhum'
      'Atraso'
      'Erro do Remetente'
      'Erro do Destin'#225'rio'
      'Erro do Funcion'#225'rio'
      'Erro da Empresa')
    TabOrder = 6
    OnClick = ChangeGlobal
  end
  object lDsc_MStt: TStaticText
    Left = 248
    Top = 128
    Width = 105
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_MStt
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
end
