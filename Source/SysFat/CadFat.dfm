object frmFatura: TfrmFatura
  Left = 192
  Top = 114
  Width = 800
  Height = 600
  Caption = 'frmFatura'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pgFaturamento: TPageControl
    Left = 0
    Top = 177
    Width = 792
    Height = 369
    ActivePage = tsFat
    Align = alClient
    TabOrder = 0
    object tsSearch: TTabSheet
      Caption = 'tsSearch'
      ImageIndex = 1
      object pgDocuments: TPageControl
        Left = 0
        Top = 0
        Width = 784
        Height = 341
        ActivePage = tsDocuments
        Align = alClient
        TabOrder = 0
        object tsDocuments: TTabSheet
          Caption = 'tsDocuments'
          TabVisible = False
          object CSDVirtualStringTree1: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 776
            Height = 331
            Align = alClient
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.MainColumn = -1
            Header.Options = [hoColumnResize, hoDrag, hoVisible]
            Header.Style = hsFlatButtons
            HintAnimation = hatNone
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            Columns = <>
          end
        end
        object tsItens: TTabSheet
          Caption = 'tsItens'
          ImageIndex = 19
          TabVisible = False
          object stDocument: TStaticText
            Left = 0
            Top = 0
            Width = 101
            Height = 24
            Align = alTop
            Alignment = taCenter
            BorderStyle = sbsSunken
            Caption = 'stDocument'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object CSDVirtualStringTree2: TVirtualStringTree
            Left = 0
            Top = 24
            Width = 776
            Height = 306
            Align = alClient
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.MainColumn = -1
            Header.Options = [hoColumnResize, hoDrag, hoVisible]
            Header.Style = hsFlatButtons
            HintAnimation = hatNone
            TabOrder = 1
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            Columns = <>
          end
        end
      end
    end
    object tsFat: TTabSheet
      Caption = 'tsFat'
      ImageIndex = 39
      object Panel2: TPanel
        Left = 0
        Top = 29
        Width = 784
        Height = 196
        Align = alTop
        ParentColor = True
        TabOrder = 0
        DesignSize = (
          784
          196)
        object Shape3: TShape
          Left = 6
          Top = 135
          Width = 771
          Height = 58
          Brush.Style = bsClear
        end
        object Shape1: TShape
          Left = 538
          Top = 18
          Width = 241
          Height = 104
          Brush.Style = bsClear
        end
        object Label3: TLabel
          Left = 3
          Top = 3
          Width = 189
          Height = 13
          Caption = 'Grupo Movimento / Tipo de Documento'
        end
        object Label4: TLabel
          Left = 5
          Top = 44
          Width = 80
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Data da Emiss'#227'o'
        end
        object Label5: TLabel
          Left = 426
          Top = 44
          Width = 87
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'No do Documento'
        end
        object Label6: TLabel
          Left = 3
          Top = 87
          Width = 41
          Height = 13
          Caption = 'Empresa'
        end
        object Label7: TLabel
          Left = 615
          Top = 31
          Width = 43
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'SubTotal'
        end
        object Label8: TLabel
          Left = 542
          Top = 55
          Width = 116
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Acr'#233'scimos / Descontos'
        end
        object Label9: TLabel
          Left = 607
          Top = 78
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Valor Total'
        end
        object Label10: TLabel
          Left = 543
          Top = 4
          Width = 103
          Height = 13
          Anchors = [akTop, akRight]
          Caption = ' Valor do Documento '
        end
        object Label11: TLabel
          Left = 21
          Top = 128
          Width = 69
          Height = 13
          Caption = ' Observa'#231#245'es '
        end
        object cbGrupoMovimento: TComboBox
          Left = 3
          Top = 19
          Width = 510
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 0
        end
        object edNUM_DOC: TCurrencyEdit
          Left = 357
          Top = 60
          Width = 156
          Height = 21
          AutoSize = False
          DecimalPlaces = 0
          DisplayFormat = '0;-0'
          Enabled = False
          Anchors = [akTop, akRight]
          MaxLength = 10
          TabOrder = 1
        end
        object cbFK_CADASTROS: TComboBox
          Left = 3
          Top = 102
          Width = 510
          Height = 21
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 2
        end
        object edVLR_STOT: TCurrencyEdit
          Left = 664
          Top = 27
          Width = 109
          Height = 21
          AutoSize = False
          TabOrder = 3
        end
        object edVLR_ACR_DSCT: TCurrencyEdit
          Left = 664
          Top = 51
          Width = 109
          Height = 21
          AutoSize = False
          TabOrder = 4
        end
        object edVAL_TOT: TCurrencyEdit
          Left = 664
          Top = 74
          Width = 109
          Height = 21
          TabStop = False
          AutoSize = False
          ReadOnly = True
          TabOrder = 5
        end
        object edOBS_DOC: TMemo
          Left = 11
          Top = 144
          Width = 758
          Height = 41
          TabOrder = 8
        end
        object chkFLAG_BXAC: TCheckBox
          Left = 149
          Top = 50
          Width = 204
          Height = 17
          Caption = 'Documento Liquidado'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object chkFLAG_CANC: TCheckBox
          Left = 149
          Top = 66
          Width = 204
          Height = 17
          Caption = 'Documento Cancelado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object dtDATA_EMISSAO: TDateEdit
          Left = 3
          Top = 60
          Width = 145
          Height = 21
          NumGlyphs = 2
          TabOrder = 9
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 784
        Height = 29
        Align = alTop
        TabOrder = 1
        object Label12: TLabel
          Left = 1
          Top = 1
          Width = 782
          Height = 27
          Align = alClient
          Caption = 'Documento'
          Color = clWindow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 225
        Width = 784
        Height = 29
        Align = alTop
        TabOrder = 2
        object Label13: TLabel
          Left = 1
          Top = 1
          Width = 782
          Height = 27
          Align = alClient
          Caption = 'Duplicatas'
          Color = clWindow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
      end
      object stDuplicatas: TVirtualStringTree
        Left = 0
        Top = 254
        Width = 784
        Height = 87
        Align = alClient
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        TabOrder = 3
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
        Columns = <
          item
            Position = 0
            Width = 82
            WideText = 'Vencimento'
          end
          item
            Position = 1
            Width = 382
            WideText = 'Hist'#243'rico'
          end
          item
            Alignment = taRightJustify
            Position = 2
            Width = 84
            WideText = 'Valor'
          end>
      end
    end
  end
  object pSearch: TPanel
    Left = 0
    Top = 49
    Width = 792
    Height = 128
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object lDtaDoc: TLabel
      Left = 18
      Top = 11
      Width = 99
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data do Documento:'
    end
    object Label1: TLabel
      Left = 283
      Top = 11
      Width = 106
      Height = 13
      Alignment = taRightJustify
      Caption = 'Status do Documento:'
    end
    object lTipoDoc: TLabel
      Left = 292
      Top = 43
      Width = 97
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tipo do Documento:'
    end
    object lFkCadastros: TLabel
      Left = 238
      Top = 75
      Width = 151
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sele'#231#227'o de Cliente/Fornecedor:'
    end
    object Label2: TLabel
      Left = 4
      Top = 43
      Width = 113
      Height = 13
      Alignment = taRightJustify
      Caption = 'N'#250'mero do Documento:'
    end
    object lFkClassificacao: TLabel
      Left = 251
      Top = 107
      Width = 138
      Height = 13
      Alignment = taRightJustify
      Caption = 'Classifica'#231#227'o do Documento:'
    end
    object eDtaDoc: TDateEdit
      Left = 120
      Top = 8
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 0
    end
    object cbStatusDoc: TComboBox
      Left = 392
      Top = 8
      Width = 385
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 392
      Top = 40
      Width = 385
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
    end
    object ComboBox2: TComboBox
      Left = 392
      Top = 72
      Width = 385
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
    object eNumDoc: TCurrencyEdit
      Left = 120
      Top = 40
      Width = 121
      Height = 21
      AutoSize = False
      DecimalPlaces = 0
      DisplayFormat = ',0;-,0'
      TabOrder = 4
    end
    object ComboBox3: TComboBox
      Left = 392
      Top = 104
      Width = 385
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
    end
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 49
    Bands = <
      item
        Break = False
        Control = tbOperations
        ImageIndex = 78
        MinHeight = 40
        Text = 'Opera'#231#245'es'
        Width = 788
      end>
    object tbOperations: TToolBar
      Left = 67
      Top = 0
      Width = 717
      Height = 40
      ButtonHeight = 21
      ButtonWidth = 72
      Caption = 'tbOperations'
      Flat = True
      ShowCaptions = True
      TabOrder = 0
      object tbClose: TToolButton
        Left = 0
        Top = 0
        Caption = '&Sair'
        ImageIndex = 41
      end
      object ToolButton2: TToolButton
        Left = 72
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object tbSearch: TToolButton
        Left = 80
        Top = 0
        Caption = '&Busca'
        ImageIndex = 35
      end
      object ToolButton9: TToolButton
        Left = 152
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object tbOS: TToolButton
        Left = 160
        Top = 0
        Caption = '&Servi'#231'os'
        ImageIndex = 45
      end
      object tbRequest: TToolButton
        Left = 232
        Top = 0
        Caption = '&Requisi'#231#245'es'
        ImageIndex = 20
      end
      object tbOrder: TToolButton
        Left = 304
        Top = 0
        Caption = '&Pedidos'
        ImageIndex = 26
      end
      object ToolButton4: TToolButton
        Left = 376
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object tbSelItens: TToolButton
        Left = 384
        Top = 0
        Caption = '&Sel. Itens'
        ImageIndex = 16
      end
      object ToolButton7: TToolButton
        Left = 456
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object tbFatura: TToolButton
        Left = 464
        Top = 0
        Caption = '&Gerar Fatura'
        ImageIndex = 79
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 248
    Top = 56
    object Faturamento1: TMenuItem
      Caption = '&Opera'#231#245'es'
      ImageIndex = 78
      object miSearch: TMenuItem
        Caption = '&Busca'
        ImageIndex = 35
        ShortCut = 114
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object miOS: TMenuItem
        Caption = '&Servi'#231'os'
        ImageIndex = 45
      end
      object miRequest: TMenuItem
        Caption = '&Requisi'#231#245'es'
        ImageIndex = 20
      end
      object miOrder: TMenuItem
        Caption = '&Pedidos'
        ImageIndex = 26
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miSelItems: TMenuItem
        Caption = '&Selecionar '#205'tens'
        ImageIndex = 16
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miInvoice: TMenuItem
        Caption = '&Gerar Faturar'
        ImageIndex = 79
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miClose: TMenuItem
        Caption = '&Sair'
        ImageIndex = 41
        OnClick = miCloseClick
      end
    end
  end
end
