inherited CdPlanAccount: TCdPlanAccount
  Left = 195
  Top = 169
  Width = 800
  Height = 550
  Caption = 'CdPlanAccount'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object sDiv: TSplitter [0]
    Left = 374
    Top = 41
    Width = 5
    Height = 462
    Beveled = True
  end
  inherited spSplitter: TSplitter
    Left = 369
    Top = 41
    Height = 462
  end
  inherited cbTools: TCoolBar
    Width = 792
    Height = 41
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        MinHeight = 33
        Text = 'Ferramentas'
        Width = 788
      end>
    inherited tbTools: TToolBar
      Width = 711
      Height = 33
      inherited tbInsert: TToolButton
        DropdownMenu = pmGrid
        Style = tbsDropDown
      end
      inherited tbCancel: TToolButton
        Left = 67
      end
      inherited tbDelete: TToolButton
        Left = 121
      end
      inherited tbSepSave: TToolButton
        Left = 175
      end
      inherited tbSave: TToolButton
        Left = 183
      end
      inherited tbSepClose: TToolButton
        Left = 237
      end
      inherited tbClose: TToolButton
        Left = 245
      end
    end
  end
  inherited sbStatus: TStatusBar
    Top = 503
    Width = 792
  end
  inherited vtList: TVirtualStringTree
    Top = 41
    Width = 369
    Height = 462
    Header.AutoSizeIndex = 1
    PopupMenu = pmGrid
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScroll, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    OnBeforeItemErase = vtListBeforeItemErase
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    Columns = <
      item
        Position = 0
        Width = 150
        WideText = 'Conta'
      end
      item
        Position = 1
        Width = 215
        WideText = 'Descri'#231#227'o'
      end>
  end
  inherited pMain: TPanel
    Left = 379
    Top = 41
    Width = 413
    Height = 462
    TabOrder = 4
  end
  object pData: TPanel
    Left = 379
    Top = 41
    Width = 413
    Height = 462
    Align = alClient
    ParentColor = True
    TabOrder = 3
    DesignSize = (
      413
      462)
    object shTitle: TShape
      Left = 8
      Top = 8
      Width = 401
      Height = 33
      Anchors = [akLeft, akTop, akRight]
    end
    object lTitle: TLabel
      Left = 16
      Top = 14
      Width = 385
      Height = 21
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Cadastro do Plano de Contas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lFlag_TCta: TRadioGroup
      Left = 8
      Top = 84
      Width = 193
      Height = 65
      Anchors = [akLeft, akRight]
      Caption = 'Natureza da Conta'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Ativo'
        'Passivo'
        'Receitas'
        'Despesas'
        'ARE')
      ParentFont = False
      TabOrder = 0
      OnClick = lFlag_TCtaClick
    end
    object lFlag_ID: TRadioGroup
      Left = 216
      Top = 84
      Width = 193
      Height = 65
      Anchors = [akRight]
      Caption = 'Identifica'#231#227'o da Conta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Outras'
        'Conta Caixa'
        'Conta Banc'#225'ria')
      ParentFont = False
      TabOrder = 1
      OnClick = ChangeGlobal
    end
    object lFlag_Anl_Snt: TRadioGroup
      Left = 8
      Top = 175
      Width = 401
      Height = 41
      Anchors = [akLeft, akRight]
      Caption = 'Tipo da Conta'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 1
      Items.Strings = (
        'Sint'#233'tica'
        'Anal'#237'tica')
      ParentFont = False
      TabOrder = 2
      OnClick = lFlag_Anl_SntClick
    end
    object lSeq_Cta: TStaticText
      Left = 8
      Top = 256
      Width = 121
      Height = 20
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Sequ'#234'ncia: '
      Enabled = False
      FocusControl = eSeq_Cta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object lMask_Cta: TStaticText
      Left = 8
      Top = 309
      Width = 123
      Height = 20
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'C'#243'd. Classif.: '
      Enabled = False
      FocusControl = eMask_Cta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object lDsc_Cta: TStaticText
      Left = 8
      Top = 362
      Width = 123
      Height = 20
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Descri'#231#227'o: '
      FocusControl = eDsc_Cta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object eDsc_Cta: TEdit
      Left = 136
      Top = 362
      Width = 273
      Height = 21
      Anchors = [akLeft, akRight]
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 6
      OnChange = ChangeGlobal
    end
    object eMask_Cta: TEdit
      Left = 136
      Top = 309
      Width = 273
      Height = 21
      TabStop = False
      Anchors = [akLeft, akRight]
      Enabled = False
      MaxLength = 50
      TabOrder = 5
      OnChange = ChangeGlobal
    end
    object eSeq_Cta: TCurrencyEdit
      Left = 136
      Top = 256
      Width = 57
      Height = 21
      AutoSize = False
      DecimalPlaces = 0
      DisplayFormat = '0;-,0'
      Enabled = False
      Anchors = [akLeft]
      MaxLength = 5
      TabOrder = 3
      OnChange = ChangeGlobal
    end
    object lGrau_Cta: TStaticText
      Left = 224
      Top = 256
      Width = 121
      Height = 20
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'N'#237'vel: '
      Enabled = False
      FocusControl = eGrau_Cta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object eGrau_Cta: TCurrencyEdit
      Left = 352
      Top = 256
      Width = 57
      Height = 21
      AutoSize = False
      DecimalPlaces = 0
      DisplayFormat = '0;-,0'
      Enabled = False
      Anchors = [akRight]
      MaxLength = 5
      TabOrder = 4
      OnChange = ChangeGlobal
    end
  end
  object pmGrid: TPopupMenu
    Left = 128
    Top = 112
    object pmNewLevel: TMenuItem
      Caption = 'Inserir N'#237'vel - [Ctrl+Ins]'
      OnClick = pmNewLevelClick
    end
  end
end
