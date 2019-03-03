object TfrmProducts: TTfrmProducts
  Left = 152
  Top = 122
  BorderStyle = bsNone
  Caption = 'TfrmProducts'
  ClientHeight = 521
  ClientWidth = 792
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 33
    Bands = <
      item
        Break = False
        Control = tbTools
        HorizontalOnly = True
        ImageIndex = 46
        MinHeight = 22
        Text = 'Opera'#231#245'es'
        Width = 788
      end>
    Ctl3D = False
    object tbTools: TToolBar
      Left = 67
      Top = 0
      Width = 717
      Height = 22
      ButtonHeight = 19
      ButtonWidth = 60
      Flat = True
      List = True
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      Transparent = True
      object tbNew: TToolButton
        Left = 0
        Top = 0
        Hint = 'Inserir | Insere Nova Ordem de Servi'#231'os'
        Caption = '&Inserir'
        ImageIndex = 34
        OnClick = tbNewClick
      end
      object tbDelete: TToolButton
        Left = 60
        Top = 0
        Caption = '&Excluir'
        ImageIndex = 33
        OnClick = tbDeleteClick
      end
      object tbCancel: TToolButton
        Left = 120
        Top = 0
        Hint = 'Cancelar | Cancela as Altera'#231#245'es feitas na Ordem de Servi'#231'os'
        Caption = '&Cancelar'
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbSepOper: TToolButton
        Left = 180
        Top = 0
        Width = 8
        Caption = 'tbSepOper'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbPrior: TToolButton
        Left = 188
        Top = 0
        Hint = 'Anterior | Mostra Sele'#231#227'o Anterior'
        Caption = '&Anterior'
        ImageIndex = 30
        OnClick = tbPriorClick
      end
      object tbNext: TToolButton
        Left = 248
        Top = 0
        Hint = 'Pr'#243'ximo | Mostra Pr'#243'xima Sele'#231#227'o'
        Caption = '&Pr'#243'ximo'
        ImageIndex = 32
        OnClick = tbNextClick
      end
      object tbSepSave: TToolButton
        Left = 308
        Top = 0
        Width = 8
        ImageIndex = 34
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 316
        Top = 0
        Hint = 'Salvar | Salva as Altera'#231#245'es Feitas na Ordem de Servi'#231'os Atual'
        Caption = '&Salvar'
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object tbSepFind: TToolButton
        Left = 376
        Top = 0
        Width = 8
        Caption = 'tbSepFind'
        ImageIndex = 38
        Style = tbsSeparator
      end
      object tbFind: TToolButton
        Left = 384
        Top = 0
        Caption = 'Pesquisar'
        ImageIndex = 90
        OnClick = tbFindClick
      end
      object tbSepClose: TToolButton
        Left = 444
        Top = 0
        Width = 8
        Caption = 'tbSepClose'
        ImageIndex = 91
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 452
        Top = 0
        Caption = 'Sair'
        ImageIndex = 43
      end
    end
  end
  object pgControl: TPageControl
    Left = 0
    Top = 33
    Width = 792
    Height = 488
    ActivePage = tsData
    Align = alClient
    TabOrder = 1
    object tsData: TTabSheet
      Caption = 'tsData'
      object pAllData: TPanel
        Left = 193
        Top = 0
        Width = 591
        Height = 460
        Align = alClient
        ParentColor = True
        TabOrder = 0
        object pProduct: TPanel
          Left = 1
          Top = 1
          Width = 589
          Height = 153
          Align = alTop
          ParentColor = True
          TabOrder = 0
          DesignSize = (
            589
            153)
          object lPk_Produtos: TStaticText
            Left = 8
            Top = 8
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' C'#243'digo:'
            Enabled = False
            FocusControl = ePk_Produtos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object eFk_Secoes: TComboBox
            Left = 96
            Top = 32
            Width = 303
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 1
            OnSelect = eFk_SecoesSelect
          end
          object eFk_Grupos: TComboBox
            Left = 96
            Top = 56
            Width = 303
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 2
            OnSelect = eFk_GruposSelect
          end
          object eFk_SubGrupos: TComboBox
            Left = 96
            Top = 80
            Width = 303
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 3
          end
          object eFk_Unidades: TComboBox
            Left = 96
            Top = 104
            Width = 143
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            TabOrder = 4
          end
          object lFk_Unidades: TStaticText
            Left = 8
            Top = 104
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Unidade:'
            FocusControl = eFk_Unidades
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object lFk_SubGrupos: TStaticText
            Left = 8
            Top = 80
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' SubGrupo:'
            FocusControl = eFk_SubGrupos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object lFk_Grupos: TStaticText
            Left = 8
            Top = 56
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Grupo:'
            FocusControl = eFk_Grupos
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
          end
          object lFk_Secoes: TStaticText
            Left = 8
            Top = 32
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Se'#231#227'o:'
            FocusControl = eFk_Secoes
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object lDsc_Prod: TStaticText
            Left = 8
            Top = 128
            Width = 81
            Height = 21
            Anchors = [akLeft]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Descri'#231#227'o:'
            FocusControl = eDsc_Prod
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object eDsc_Prod: TEdit
            Left = 96
            Top = 128
            Width = 495
            Height = 21
            Anchors = [akLeft, akRight]
            CharCase = ecUpperCase
            MaxLength = 50
            TabOrder = 10
          end
          object vtProdType: TVirtualStringTree
            Left = 406
            Top = 0
            Width = 185
            Height = 121
            Anchors = [akTop, akRight]
            CheckImageKind = ckXP
            Ctl3D = True
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoDrag, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            ParentCtl3D = False
            TabOrder = 11
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnChecked = vtProdTypeChecked
            OnChecking = vtProdTypeChecking
            OnGetText = vtProdTypeGetText
            OnInitNode = vtProdTypeInitNode
            Columns = <
              item
                ImageIndex = 83
                Position = 0
                Width = 160
                WideText = 'Tipos'
              end>
          end
          object lFlag_Atv: TCheckBox
            Left = 280
            Top = 8
            Width = 111
            Height = 17
            Alignment = taLeftJustify
            Anchors = [akLeft, akRight]
            Caption = 'Produto Ativo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
          end
          object lQtd_Uni: TStaticText
            Left = 246
            Top = 104
            Width = 81
            Height = 21
            Anchors = [akRight]
            AutoSize = False
            BorderStyle = sbsSingle
            Caption = ' Qtd. Uso:'
            FocusControl = eQtd_Uni
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object eQtd_Uni: TCurrencyEdit
            Left = 334
            Top = 104
            Width = 65
            Height = 21
            AutoSize = False
            DecimalPlaces = 4
            DisplayFormat = ',0.000;- ,0.0000'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Anchors = [akRight]
            ParentFont = False
            TabOrder = 14
          end
          object ePk_Produtos: TEdit
            Left = 96
            Top = 8
            Width = 121
            Height = 21
            TabOrder = 15
            Text = '0'
          end
        end
        object pgData: TPageControl
          Left = 1
          Top = 154
          Width = 589
          Height = 305
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object pDaraAux: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 460
        Align = alLeft
        Caption = 'pDataAux'
        ParentColor = True
        TabOrder = 1
        object pCodes: TPanel
          Left = 1
          Top = 177
          Width = 191
          Height = 282
          Align = alClient
          UseDockManager = False
          ParentBackground = True
          ParentColor = True
          TabOrder = 0
        end
        object stCodeTitle: TStaticText
          Left = 1
          Top = 153
          Width = 191
          Height = 24
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'C'#243'digos do Produto'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object pgBlobs: TPageControl
          Left = 1
          Top = 1
          Width = 191
          Height = 152
          ActivePage = tsPicture
          Align = alTop
          TabOrder = 2
          object tsPicture: TTabSheet
            Caption = 'Figura'
            object iImgProd: TImage
              Left = 0
              Top = 0
              Width = 183
              Height = 124
              Align = alClient
              Center = True
              Proportional = True
            end
          end
          object tsObservations: TTabSheet
            Caption = 'tsObservations'
            ImageIndex = 1
            object eObs_Prod: TMemo
              Left = 0
              Top = 0
              Width = 183
              Height = 124
              Align = alClient
              TabOrder = 0
            end
          end
        end
      end
    end
    object tsList: TTabSheet
      Caption = 'tsList'
      ImageIndex = 1
      object vtSearch: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 784
        Height = 460
        Align = alClient
        CheckImageKind = ckXP
        Ctl3D = True
        Header.AutoSizeIndex = 6
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoHotTrack, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        ParentCtl3D = False
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnBeforeCellPaint = vtSearchBeforeCellPaint
        OnDblClick = vtSearchDblClick
        OnEditing = vtSearchEditing
        OnFocusChanged = vtSearchFocusChanged
        OnGetText = vtSearchGetText
        Columns = <
          item
            ImageIndex = 8
            Position = 0
            Width = 70
            WideText = 'C'#243'digo'
          end
          item
            ImageIndex = 52
            Position = 1
            Width = 100
            WideText = 'Refer'#234'ncia'
          end
          item
            ImageIndex = 47
            Position = 2
            Width = 230
            WideText = 'Descri'#231#227'o'
          end
          item
            Alignment = taRightJustify
            Position = 3
            Width = 90
            WideText = 'Pre'#231'o'
          end
          item
            Position = 4
            Width = 110
            WideText = 'Data da Compra'
          end
          item
            Position = 5
            Width = 90
            WideText = 'Data da Venda'
          end
          item
            Alignment = taCenter
            ImageIndex = 28
            Position = 6
            Width = 90
            WideText = 'Ativo'
          end>
      end
    end
  end
  object pmCodes: TPopupMenu
    Left = 22
    Top = 90
    object pmReference: TMenuItem
      Caption = 'Refer'#234'ncia'
    end
    object pmPk: TMenuItem
      Caption = 'C'#243'digo do Produto'
    end
    object pmBarCode: TMenuItem
      Caption = 'C'#243'digo de Barras'
    end
    object pmSupplier: TMenuItem
      Caption = 'C'#243'digo do Fornecedor'
    end
  end
end
