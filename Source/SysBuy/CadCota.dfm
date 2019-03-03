inherited CdCotacoes: TCdCotacoes
  Left = 218
  Top = 112
  Caption = 'CdCotacoes'
  ClientHeight = 570
  ClientWidth = 800
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 800
  end
  inherited ControlBar: TControlBar
    Width = 800
  end
  inherited Painel: TStatusBar
    Top = 551
    Width = 800
  end
  inherited Control: TPageControl
    Width = 800
    Height = 440
    inherited tsDataAware: TTabSheet
      inherited pbModel: TProgressBar
        Left = 688
        Top = 384
      end
      object pgQuotation: TPageControl
        Left = 0
        Top = 0
        Width = 792
        Height = 408
        ActivePage = tsCotation
        Align = alClient
        Images = Dados.Image16
        TabOrder = 1
        TabPosition = tpBottom
        object tsCotation: TTabSheet
          Caption = 'tsCotation'
          ImageIndex = 39
          object vtSupplier: TCSDVirtualStringTree
            Left = 0
            Top = 113
            Width = 784
            Height = 268
            Align = alClient
            BorderStyle = bsSingle
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Images = Dados.Image16
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HintMode = hmDefault
            Images = Dados.Image16
            IncrementalSearchDirection = sdForward
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            AutoEdit = False
            ColumnDefs = <
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = True
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = True
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = False
                CustomFldType = 2
              end>
            MustBlockBoundaryEditExit = True
            Columns = <
              item
                ImageIndex = 61
                Position = 0
                Width = 350
                WideText = 'Fornecedor'
              end
              item
                ImageIndex = 26
                Position = 1
                Width = 250
                WideText = 'Produto'
              end
              item
                ImageIndex = 39
                Position = 2
                Width = 150
                WideText = 'Pre'#231'o'
              end>
          end
          object pQuotation: TPanel
            Left = 0
            Top = 0
            Width = 784
            Height = 88
            Align = alTop
            BevelInner = bvLowered
            TabOrder = 1
            object lPk_Insumos: TLabel
              Left = 61
              Top = 19
              Width = 72
              Height = 13
              Alignment = taRightJustify
              Caption = 'lPk_Insumos'
              FocusControl = ePk_Insumos
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lDsc_Ins: TLabel
              Left = 83
              Top = 59
              Width = 50
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDsc_Ins'
              FocusControl = eDsc_Ins
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lDta_UCmp: TLabel
              Left = 517
              Top = 19
              Width = 64
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDta_UCmp'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object ePk_Insumos: TDBEdit
              Left = 136
              Top = 16
              Width = 129
              Height = 21
              DataField = 'PK_INSUMOS'
              PopupMenu = pmFields
              TabOrder = 0
              OnDblClick = ComponentDblClick
            end
            object eDsc_Ins: TDBEdit
              Left = 136
              Top = 56
              Width = 569
              Height = 21
              CharCase = ecUpperCase
              DataField = 'DSC_INS'
              PopupMenu = pmFields
              TabOrder = 1
              OnDblClick = ComponentDblClick
            end
            object eDta_UCmp: TDBDateEdit
              Left = 584
              Top = 16
              Width = 121
              Height = 21
              DataField = 'DTA_UCMP'
              NumGlyphs = 2
              TabOrder = 2
            end
          end
          object pSupplier: TPanel
            Left = 0
            Top = 88
            Width = 784
            Height = 25
            Align = alTop
            Alignment = taLeftJustify
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Caption = 'pSupplier'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
        end
        object tsMissingProducts: TTabSheet
          Caption = 'tsMissingProducts'
          ImageIndex = 38
          object pFilter: TPanel
            Left = 0
            Top = 0
            Width = 784
            Height = 113
            Align = alTop
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 0
            object lFk_Secoes: TLabel
              Left = 58
              Top = 36
              Width = 67
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFk_Secoes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lFk_Grupos: TLabel
              Left = 60
              Top = 60
              Width = 65
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFk_Grupos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lFk_SubGrupos: TLabel
              Left = 38
              Top = 84
              Width = 87
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFk_SubGrupos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label1: TLabel
              Left = 75
              Top = 11
              Width = 50
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDsc_Ins'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object sbSearch: TSpeedButton
              Left = 568
              Top = 8
              Width = 81
              Height = 97
              Caption = 'sbSearch'
              Flat = True
              Layout = blGlyphBottom
            end
            object Label2: TLabel
              Left = 656
              Top = 19
              Width = 50
              Height = 13
              Caption = 'lDsc_Ins'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Edit1: TEdit
              Left = 128
              Top = 8
              Width = 433
              Height = 21
              TabOrder = 0
              Text = 'Edit1'
            end
            object ComboBox1: TComboBox
              Left = 128
              Top = 32
              Width = 433
              Height = 21
              ItemHeight = 13
              TabOrder = 1
              Text = 'ComboBox1'
            end
            object ComboBox2: TComboBox
              Left = 128
              Top = 56
              Width = 433
              Height = 21
              ItemHeight = 13
              TabOrder = 2
              Text = 'ComboBox2'
            end
            object ComboBox3: TComboBox
              Left = 128
              Top = 80
              Width = 433
              Height = 21
              ItemHeight = 13
              TabOrder = 3
              Text = 'ComboBox3'
            end
            object Edit2: TEdit
              Left = 656
              Top = 32
              Width = 121
              Height = 21
              TabOrder = 4
              Text = 'Edit1'
            end
          end
          object vtProducts: TCSDVirtualStringTree
            Left = 0
            Top = 113
            Width = 784
            Height = 268
            Align = alClient
            BorderStyle = bsSingle
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Images = Dados.Image16
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HintMode = hmDefault
            Images = Dados.Image16
            IncrementalSearchDirection = sdForward
            TabOrder = 1
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            AutoEdit = False
            ColumnDefs = <
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = True
              end>
            MustBlockBoundaryEditExit = True
            Columns = <
              item
                ImageIndex = 26
                Position = 0
                Width = 700
                WideText = 'Produto'
              end>
          end
        end
        object tsRanking: TTabSheet
          Caption = 'tsRanking'
          object vtRanking: TCSDVirtualStringTree
            Left = 0
            Top = 0
            Width = 784
            Height = 381
            Align = alClient
            BorderStyle = bsSingle
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Images = Dados.Image16
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoShowSortGlyphs, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HintMode = hmDefault
            Images = Dados.Image16
            IncrementalSearchDirection = sdForward
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            AutoEdit = False
            ColumnDefs = <
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = True
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = True
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = False
                CustomFldType = 2
              end>
            MustBlockBoundaryEditExit = True
            Columns = <
              item
                ImageIndex = 26
                Position = 0
                Width = 250
                WideText = 'Produto'
              end
              item
                ImageIndex = 61
                Position = 1
                Width = 350
                WideText = 'Fornecedor'
              end
              item
                ImageIndex = 39
                Position = 2
                Width = 150
                WideText = 'Pre'#231'o'
              end>
          end
        end
      end
    end
    inherited tsTable: TTabSheet
      inherited dbgGrid: TDBGrid
        Width = 792
        Height = 379
      end
      inherited SearchPanel: TPanel
        Width = 792
      end
    end
  end
  inherited Panel1: TPanel
    Width = 800
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 359
    end
  end
  inherited pCompany: TPanel
    Width = 800
    inherited lNameCompany: TLabel
      Width = 778
    end
    inherited Panel2: TPanel
      Left = 780
    end
  end
end
