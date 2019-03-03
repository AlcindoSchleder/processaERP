inherited CdCalculos: TCdCalculos
  Width = 730
  Height = 558
  Caption = 'CdCalculos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 722
  end
  inherited ControlBar: TControlBar
    Width = 722
  end
  inherited Painel: TStatusBar
    Top = 485
    Width = 722
  end
  inherited Control: TPageControl
    Width = 722
    Height = 374
    inherited tsDataAware: TTabSheet
      object pgCalc: TPageControl
        Left = 0
        Top = 0
        Width = 714
        Height = 342
        ActivePage = tsBasicData
        Align = alClient
        Images = Dados.Image16
        TabOrder = 1
        TabPosition = tpBottom
        OnChange = pgCalcChange
        OnChanging = pgCalcChanging
        object tsBasicData: TTabSheet
          Caption = 'tsBasicData'
          object vtMotors: TCSDVirtualStringTree
            Left = 0
            Top = 143
            Width = 706
            Height = 172
            Align = alClient
            BorderStyle = bsNone
            Ctl3D = True
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Images = Dados.Image16
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            HintMode = hmDefault
            Images = Dados.Image16
            IncrementalSearchDirection = sdForward
            ParentCtl3D = False
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus]
            AutoEdit = False
            ColumnDefs = <
              item
                FldType = ctInteger
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 1
              end
              item
                OnGetPickItems = vtMotorsColumnDefs1GetPickItems
                FldType = ctDropDownList
                MaxLength = 0
                ReadOnly = False
                CustomFldType = 6
              end
              item
                FldType = ctString
                MaxLength = 0
                ReadOnly = False
              end
              item
                FldType = ctInteger
                MaxLength = 30
                ReadOnly = False
                CustomFldType = 1
                CustomMaxLength = 30
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = False
                CustomFldType = 2
              end
              item
                FldType = ctInteger
                MaxLength = 0
                ReadOnly = False
                CustomFldType = 1
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = False
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = False
                CustomFldType = 2
              end
              item
                FldType = ctInteger
                MaxLength = 0
                ReadOnly = False
                CustomFldType = 1
              end>
            MustBlockBoundaryEditExit = True
            Columns = <
              item
                Position = 0
                Width = 35
                WideText = #205'tem'
              end
              item
                ImageIndex = 13
                Position = 1
                Width = 190
                WideText = 'Motor Proposto'
              end
              item
                ImageIndex = 46
                Position = 2
                Width = 180
                WideText = 'Descri'#231#227'o do Motor do Cliente'
              end
              item
                ImageIndex = 43
                Position = 3
                Width = 80
                WideText = 'Qtd.Polos'
              end
              item
                ImageIndex = 61
                Position = 4
                WideText = 'CV'
              end
              item
                ImageIndex = 0
                Position = 5
                Width = 75
                WideText = 'Rota'#231#227'o'
              end
              item
                ImageIndex = 70
                Position = 6
                Width = 100
                WideText = 'Corrente Med.'
              end
              item
                ImageIndex = 71
                Position = 7
                Width = 100
                WideText = 'Corrente Te'#243'rica'
              end
              item
                ImageIndex = 12
                Position = 8
                Width = 70
                WideText = 'Quant.'
              end>
          end
          object pData: TPanel
            Left = 0
            Top = 0
            Width = 706
            Height = 121
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lDta_Calc: TLabel
              Left = 468
              Top = 12
              Width = 56
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDta_Calc'
              FocusControl = eFk_Parametros_Calc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lFk_Parametros_Calc: TLabel
              Left = 28
              Top = 92
              Width = 120
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFk_Parametros_Calc'
              FocusControl = eFk_Parametros_Calc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lFk_Cadastros: TLabel
              Left = 67
              Top = 67
              Width = 81
              Height = 13
              Alignment = taRightJustify
              Caption = 'lFk_Cadastros'
              FocusControl = eFk_Cadastros
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lDsc_Calc: TLabel
              Left = 90
              Top = 44
              Width = 58
              Height = 13
              Alignment = taRightJustify
              Caption = 'lDsc_Calc'
              FocusControl = eDsc_Calc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object lPk_Calculos: TLabel
              Left = 75
              Top = 11
              Width = 74
              Height = 13
              Alignment = taRightJustify
              Caption = 'lPk_Calculos'
              FocusControl = ePk_Calculos
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              PopupMenu = pmFields
              OnDblClick = ComponentDblClick
            end
            object eDta_Calc: TDBDateEdit
              Left = 528
              Top = 8
              Width = 121
              Height = 21
              DataField = 'DTA_CALC'
              DataSource = dsMain
              NumGlyphs = 2
              TabOrder = 0
            end
            object eFk_Parametros_Calc: TDBLookupComboBox
              Left = 152
              Top = 88
              Width = 497
              Height = 21
              DataField = 'FK_PARAMETROS_CALC'
              DataSource = dsMain
              KeyField = 'PK_PARAMETROS_CALC'
              ListField = 'DSC_PARAM'
              ListSource = Parametros
              PopupMenu = pmFields
              TabOrder = 1
            end
            object eFk_Cadastros: TDBLookupComboBox
              Left = 152
              Top = 64
              Width = 497
              Height = 21
              DataField = 'FK_CADASTROS'
              DataSource = dsMain
              KeyField = 'PK_CADASTROS'
              ListField = 'RAZ_SOC'
              ListSource = Clientes
              PopupMenu = pmFields
              TabOrder = 2
            end
            object eDsc_Calc: TDBEdit
              Left = 152
              Top = 40
              Width = 497
              Height = 21
              CharCase = ecUpperCase
              DataField = 'DSC_CALC'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 3
              OnDblClick = ComponentDblClick
            end
            object ePk_Calculos: TDBEdit
              Left = 152
              Top = 8
              Width = 97
              Height = 21
              Color = clTeal
              DataField = 'PK_CALCULOS'
              DataSource = dsMain
              PopupMenu = pmFields
              TabOrder = 4
              OnDblClick = ComponentDblClick
            end
          end
          object pMotors: TPanel
            Left = 0
            Top = 121
            Width = 706
            Height = 22
            Align = alTop
            Alignment = taLeftJustify
            BevelInner = bvLowered
            Caption = 'pMotors'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            DesignSize = (
              706
              22)
            object sbSave: TSpeedButton
              Left = 680
              Top = 2
              Width = 18
              Height = 18
              Anchors = [akLeft, akTop, akRight]
              Flat = True
              Visible = False
              OnClick = sbSaveClick
            end
            object sbDelete: TSpeedButton
              Left = 660
              Top = 2
              Width = 18
              Height = 18
              Anchors = [akLeft, akTop, akRight]
              Flat = True
              Visible = False
              OnClick = sbDeleteClick
            end
            object sbCancel: TSpeedButton
              Left = 641
              Top = 2
              Width = 18
              Height = 18
              Anchors = [akLeft, akTop, akRight]
              Flat = True
              Visible = False
              OnClick = sbCancelClick
            end
          end
        end
        object tsCalc: TTabSheet
          Caption = 'tsCalc'
          ImageIndex = 66
          object vtCalc: TCSDVirtualStringTree
            Left = 0
            Top = 24
            Width = 706
            Height = 291
            Align = alClient
            BorderStyle = bsSingle
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Images = Dados.Image16
            Header.Options = [hoColumnResize, hoDrag, hoShowImages, hoVisible]
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
                MaxLength = 50
                ReadOnly = True
                CustomMaxLength = 50
              end
              item
                FldType = ctString
                MaxLength = 20
                ReadOnly = True
                CustomMaxLength = 20
              end
              item
                FldType = ctString
                MaxLength = 50
                ReadOnly = True
                CustomMaxLength = 50
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctInteger
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 1
              end
              item
                FldType = ctString
                MaxLength = 30
                ReadOnly = True
                CustomMaxLength = 30
              end
              item
                FldType = ctString
                MaxLength = 50
                ReadOnly = True
                CustomMaxLength = 50
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end
              item
                FldType = ctFloat
                MaxLength = 0
                ReadOnly = True
                CustomFldType = 2
              end>
            MustBlockBoundaryEditExit = True
            Columns = <
              item
                ImageIndex = 51
                Position = 0
                Width = 250
                WideText = 'Nome do Cliente'
              end
              item
                Position = 1
                Width = 90
                WideText = 'Telefone'
              end
              item
                Position = 2
                Width = 150
                WideText = 'Motor Atual'
              end
              item
                Position = 3
                Width = 70
                WideText = 'Pot'#234'ncia'
              end
              item
                Position = 4
                Width = 70
                WideText = 'Rota'#231#227'o'
              end
              item
                Position = 5
                Width = 100
                WideText = 'Localiza'#231#227'o'
              end
              item
                Position = 6
                Width = 150
                WideText = 'Motor Proposto'
              end
              item
                Position = 7
                Width = 80
                WideText = 'Cons. Ponta'
              end
              item
                Position = 8
                Width = 80
                WideText = 'Cons. Fora'
              end
              item
                Position = 9
                Width = 80
                WideText = 'Cons. Total'
              end
              item
                Position = 10
                Width = 80
                WideText = 'Cons. Ponta'
              end
              item
                Position = 11
                Width = 80
                WideText = 'Cons. Fora'
              end
              item
                Position = 12
                Width = 80
                WideText = 'Cons.Total'
              end
              item
                Position = 13
                Width = 80
                WideText = 'Econ. Energ.'
              end
              item
                Position = 14
                Width = 80
                WideText = 'Econ. E. Fora'
              end
              item
                Position = 15
                Width = 100
                WideText = 'Econ. Energ. R$'
              end
              item
                Position = 16
                Width = 100
                WideText = 'Econ. E. Fora R$'
              end
              item
                Position = 17
                Width = 80
                WideText = 'Total Econ. R$'
              end
              item
                Position = 18
                Width = 100
                WideText = 'Ret. Inv. (Anos)'
              end
              item
                Position = 19
                Width = 100
                WideText = 'Ret. Inv. (Meses)'
              end
              item
                Position = 20
                Width = 100
                WideText = 'Ret. Inv. Troca (Anos)'
              end
              item
                Position = 21
                Width = 100
                WideText = 'Ret. Inv. Troca (Meses)'
              end>
          end
          object stTabSheetName: TStaticText
            Left = 0
            Top = 0
            Width = 143
            Height = 24
            Align = alTop
            Alignment = taCenter
            BorderStyle = sbsSunken
            Caption = 'stTabSheetName'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
          end
        end
      end
    end
  end
  inherited Panel1: TPanel
    Width = 722
    inherited dbnNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited dsStatus: TStaticText
      Width = 281
    end
  end
  inherited pCompany: TPanel
    Width = 722
    inherited lNameCompany: TLabel
      Width = 700
    end
    inherited Panel2: TPanel
      Left = 702
    end
  end
  object TiposMotores: TDataSource
    DataSet = dmSysCalc.Tipos_Motores
    Left = 264
    Top = 64
  end
  object TipoMotoresVenda: TDataSource
    Left = 296
    Top = 64
  end
  object Clientes: TDataSource
    DataSet = dmSysCalc.Clientes
    Left = 328
    Top = 64
  end
  object Parametros: TDataSource
    DataSet = dmSysCalc.Parametros
    Left = 360
    Top = 64
  end
end
