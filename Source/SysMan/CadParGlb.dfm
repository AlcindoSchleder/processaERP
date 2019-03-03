object CdParamGlobal: TCdParamGlobal
  Left = 320
  Top = 198
  Width = 660
  Height = 368
  Caption = 'CdParamGlobal'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    652
    340)
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 8
    Top = 40
    Width = 633
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 48
    Width = 617
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro de Par'#226'metros Globais'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 652
    Height = 33
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 648
      end>
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 571
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 54
      Caption = 'tbTools'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbCancel: TToolButton
        Left = 0
        Top = 0
        Hint = 'Cancelar | Cancela as altera'#231#245'es atuais'
        Caption = 'Cancelar'
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbDelete: TToolButton
        Left = 54
        Top = 0
        Hint = 'Excluir | Exclui o registro atual'
        Caption = 'Excluir'
        ImageIndex = 33
      end
      object ToolButton5: TToolButton
        Left = 108
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 116
        Top = 0
        Hint = 'Salvar | Sava as altera'#231#245'es efetuadas'
        Caption = 'Salvar'
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object ToolButton1: TToolButton
        Left = 170
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 178
        Top = 0
        Hint = 'Sair | Fecha a janela'
        Caption = 'Sair'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 321
    Width = 652
    Height = 19
    Panels = <
      item
        Width = 200
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
    OnClick = sbStatusClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
  object lFk_Clientes: TStaticText
    Left = 8
    Top = 96
    Width = 201
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Cliente Default: '
    FocusControl = eFk_Clientes
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object eFk_Clientes: TComboBox
    Left = 216
    Top = 96
    Width = 425
    Height = 21
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 0
    OnSelect = ChangeGlobal
  end
  object lDias_Atr: TStaticText
    Left = 8
    Top = 128
    Width = 201
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Toler'#226'ncia de Atrasos: '
    FocusControl = eDias_Atr
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
  end
  object lPer_CvMed: TStaticText
    Left = 336
    Top = 128
    Width = 201
    Height = 20
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Quant.dias p/Soma de I/O: '
    FocusControl = ePer_CvMed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object lQtd_DvMed: TStaticText
    Left = 336
    Top = 160
    Width = 201
    Height = 20
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Dias p/C'#225'lc. da Venda M'#233'dia: '
    FocusControl = eQtd_DvMed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object lQtd_DTol: TStaticText
    Left = 8
    Top = 160
    Width = 201
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Dias de Tol. Tab. Pre'#231'os: '
    FocusControl = eQtd_DTol
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
  end
  object lNum_Cas_Dec: TStaticText
    Left = 8
    Top = 192
    Width = 201
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Casas Decimais p/ Valores: '
    FocusControl = eNum_Cas_Dec
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
  end
  object eNum_Cas_Dec: TCurrencyEdit
    Left = 216
    Top = 192
    Width = 97
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft]
    MaxValue = 4.000000000000000000
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object lQtd_DcMed: TStaticText
    Left = 336
    Top = 192
    Width = 201
    Height = 20
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Dias p/C'#225'lc. do Cons. M'#233'dio: '
    FocusControl = eQtd_DcMed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
  end
  object lFlag_Lan_Parc: TCheckBox
    Left = 8
    Top = 256
    Width = 633
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 
      'Lan'#231'amentos da Classifica'#231#227'o financeira '#233' dividido para cada pro' +
      'duto em vendas a prazo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = ChangeGlobal
  end
  object lFlag_Multi: TCheckBox
    Left = 8
    Top = 288
    Width = 633
    Height = 17
    Anchors = [akLeft, akRight]
    Caption = 
      'Pedidos s'#227'o comuns a todas as empresas cadastradas (Multi-Empres' +
      'as)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = ChangeGlobal
  end
  object eQtd_DTol: TCurrencyEdit
    Left = 216
    Top = 160
    Width = 97
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft]
    TabOrder = 3
    OnChange = ChangeGlobal
  end
  object ePer_CvMed: TCurrencyEdit
    Left = 544
    Top = 128
    Width = 97
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft]
    TabOrder = 2
    OnChange = ChangeGlobal
  end
  object eDias_Atr: TCurrencyEdit
    Left = 216
    Top = 128
    Width = 97
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft]
    TabOrder = 1
    OnChange = ChangeGlobal
  end
  object eQtd_DvMed: TCurrencyEdit
    Left = 544
    Top = 160
    Width = 97
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft]
    TabOrder = 4
    OnChange = ChangeGlobal
  end
  object eQtd_DcMed: TCurrencyEdit
    Left = 544
    Top = 192
    Width = 97
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft]
    TabOrder = 6
    OnChange = ChangeGlobal
  end
  object lNum_Cas_Dec_Qtd: TStaticText
    Left = 8
    Top = 224
    Width = 201
    Height = 20
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Casas Decimais p/ Quant.: '
    FocusControl = eNum_Cas_Dec_Qtd
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 18
  end
  object eNum_Cas_Dec_Qtd: TCurrencyEdit
    Left = 216
    Top = 224
    Width = 97
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft]
    MaxValue = 4.000000000000000000
    TabOrder = 19
    OnChange = ChangeGlobal
  end
end
