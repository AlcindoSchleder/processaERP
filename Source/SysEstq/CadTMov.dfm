inherited CdTypeMov: TCdTypeMov
  Left = 199
  Top = 119
  Width = 801
  Height = 515
  Caption = 'CdTMov'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Left = 265
    Height = 435
  end
  inherited cbTools: TCoolBar
    Width = 793
    Bands = <
      item
        Control = tbTools
        ImageIndex = -1
        Text = 'Ferramentas'
        Width = 789
      end>
    inherited tbTools: TToolBar
      Left = 71
      Width = 714
    end
  end
  inherited sbStatus: TStatusBar
    Top = 468
    Width = 793
    Panels = <
      item
        Width = 300
      end
      item
        Style = psOwnerDraw
        Text = 'Empresa'
        Width = 300
      end
      item
        Style = psOwnerDraw
        Width = 100
      end>
  end
  inherited vtList: TVirtualStringTree
    Width = 265
    Height = 435
    Header.Font.Color = clBlue
    Header.Font.Style = [fsBold]
    TabOrder = 1
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    OnPaintText = vtListPaintText
    Columns = <
      item
        ImageIndex = 47
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible]
        Position = 0
        Width = 261
        WideText = 'Descri'#231#227'o'
      end>
  end
  inherited pMain: TPanel
    Left = 270
    Width = 523
    Height = 435
    TabOrder = 9
  end
  object lDsc_TMov: TStaticText
    Left = 280
    Top = 64
    Width = 177
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDsc_TMov
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object lPk_Tipo_Movim_Estq: TStaticText
    Left = 280
    Top = 40
    Width = 177
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    FocusControl = ePk_Tipo_Movim_Estq
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object ePk_Tipo_Movim_Estq: TEdit
    Left = 464
    Top = 40
    Width = 90
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 10
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lFlag_GenHst: TCheckBox
    Left = 592
    Top = 40
    Width = 185
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Gerar hist'#243'ricos para Mov.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = ChangeGlobal
  end
  object dbParams: TGroupBox
    Left = 280
    Top = 88
    Width = 513
    Height = 376
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Par'#226'metros da Movimenta'#231#224'o'
    TabOrder = 7
    DesignSize = (
      513
      376)
    object lFlag_OpQrnt: TRadioGroup
      Left = 8
      Top = 304
      Width = 248
      Height = 57
      Anchors = [akTop, akRight]
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Atribuir'
        'Somar'
        'Subtrair')
      ParentFont = False
      TabOrder = 11
      Visible = False
      OnClick = ChangeGlobal
    end
    object lFlag_TBaixa: TRadioGroup
      Left = 6
      Top = 16
      Width = 243
      Height = 105
      Caption = 'Locais de Movimenta'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Estoque Geral'
        'Estoque Almoxarifados'
        'Estoque Geral e Almoxarifados')
      ParentFont = False
      TabOrder = 0
      OnClick = ChangeGlobal
    end
    object lFlag_TMov: TRadioGroup
      Left = 264
      Top = 16
      Width = 241
      Height = 105
      Anchors = [akTop, akRight]
      Caption = 'Tipo de Movimenta'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Entrada'
        'Sa'#237'da'
        'Transfer'#234'ncia'
        'Ajuste / Inventario')
      ParentFont = False
      TabOrder = 1
      OnClick = lFlag_TMovClick
    end
    object lFk_Tipo_Movim_Estq: TStaticText
      Left = 8
      Top = 128
      Width = 177
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Movimenta'#231#227'o de Transf.: '
      FocusControl = eFk_Tipo_Movim_Estq
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object eFk_Tipo_Movim_Estq: TComboBox
      Left = 192
      Top = 128
      Width = 313
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 2
      OnSelect = ChangeGlobal
    end
    object lFlag_TCod: TRadioGroup
      Left = 8
      Top = 160
      Width = 247
      Height = 129
      Caption = 'Tipo de C'#243'digo do Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Refer'#234'ncia do Produto'
        'C'#243'digo do Produto'
        'C'#243'digo de Barras'
        'C'#243'digo do Fornecedor')
      ParentFont = False
      TabOrder = 3
      OnClick = ChangeGlobal
    end
    object lFlag_OpRsrv: TRadioGroup
      Left = 258
      Top = 232
      Width = 249
      Height = 57
      Anchors = [akTop, akRight]
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Atribuir'
        'Somar'
        'Subtrair')
      ParentFont = False
      TabOrder = 7
      Visible = False
      OnClick = ChangeGlobal
    end
    object lFlag_MvRsrv: TCheckBox
      Left = 264
      Top = 224
      Width = 199
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Movimenta Estoques Reserva'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = lFlag_MvRsrvClick
    end
    object lFlag_MvQrnt: TCheckBox
      Left = 13
      Top = 296
      Width = 220
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Movimenta Estoques Quarentena'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = lFlag_MvQrntClick
    end
    object lFlag_OpEstq: TRadioGroup
      Left = 258
      Top = 160
      Width = 249
      Height = 57
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Atribuir'
        'Somar'
        'Subtrair')
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnClick = ChangeGlobal
    end
    object lFlag_MvEstq: TCheckBox
      Left = 264
      Top = 152
      Width = 177
      Height = 17
      Caption = 'Movimenta Estoques Real'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = lFlag_MvEstqClick
    end
    object lFlag_OpGrnt: TRadioGroup
      Left = 258
      Top = 304
      Width = 250
      Height = 57
      Anchors = [akTop, akRight]
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Atribuir'
        'Somar'
        'Subtrair')
      ParentFont = False
      TabOrder = 9
      Visible = False
      OnClick = ChangeGlobal
    end
    object lFlag_MvGrnt: TCheckBox
      Left = 266
      Top = 296
      Width = 215
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Movimenta Estoques Garantia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = lFlag_MvGrntClick
    end
  end
  object eDsc_TMov: TEdit
    Left = 463
    Top = 64
    Width = 322
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 8
    OnClick = ChangeGlobal
  end
end
