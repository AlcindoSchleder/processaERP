object fmEditOperacao: TfmEditOperacao
  Left = 319
  Top = 101
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Opera'#231#227'o'
  ClientHeight = 462
  ClientWidth = 477
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    477
    462)
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 2
    Top = 2
    Width = 474
    Height = 45
    Anchors = [akLeft, akTop, akRight]
    Brush.Color = 15397876
  end
  object laPecaPai: TLabel
    Left = 5
    Top = 24
    Width = 469
    Height = 17
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object laPecaPaiTitle: TLabel
    Left = 4
    Top = 4
    Width = 468
    Height = 13
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Opera'#231#227'o Realizada em:'
    Transparent = True
  end
  object Label1: TLabel
    Left = 4
    Top = 52
    Width = 87
    Height = 13
    Caption = 'Fase de Produ'#231#227'o'
  end
  object Label2: TLabel
    Left = 211
    Top = 52
    Width = 86
    Height = 13
    Caption = 'Tipo de Opera'#231#227'o'
  end
  object Label3: TLabel
    Left = 418
    Top = 52
    Width = 51
    Height = 13
    Caption = 'Sequ'#234'ncia'
  end
  object Label4: TLabel
    Left = 212
    Top = 91
    Width = 52
    Height = 13
    Caption = 'Refer'#234'ncia'
  end
  object Label5: TLabel
    Left = 343
    Top = 91
    Width = 81
    Height = 13
    Caption = 'C'#243'digo de Barras'
  end
  object Label6: TLabel
    Left = 239
    Top = 131
    Width = 27
    Height = 13
    Caption = 'Altura'
  end
  object Label7: TLabel
    Left = 84
    Top = 131
    Width = 61
    Height = 13
    Caption = 'Comprimento'
  end
  object Label8: TLabel
    Left = 164
    Top = 131
    Width = 36
    Height = 13
    Caption = 'Largura'
  end
  object Label9: TLabel
    Left = 343
    Top = 147
    Width = 65
    Height = 13
    Alignment = taRightJustify
    Caption = 'Tempo M'#233'dio'
  end
  object Label10: TLabel
    Left = 34
    Top = 149
    Width = 39
    Height = 13
    Alignment = taRightJustify
    Caption = 'M'#225'xima:'
  end
  object Label11: TLabel
    Left = 35
    Top = 173
    Width = 38
    Height = 13
    Alignment = taRightJustify
    Caption = 'M'#237'nima:'
  end
  object Label12: TLabel
    Left = 4
    Top = 91
    Width = 94
    Height = 13
    Caption = 'Tipo de Documento'
  end
  object cbFaseProducao: TComboBox
    Left = 4
    Top = 68
    Width = 205
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 0
    OnClick = signalizeChange
  end
  object cbTipoOperacao: TComboBox
    Left = 211
    Top = 68
    Width = 205
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnClick = signalizeChange
  end
  object edSEQ_OPE: TCurrencyEdit
    Left = 416
    Top = 68
    Width = 57
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = '0;-,0'
    TabOrder = 2
    OnChange = signalizeChange
  end
  object edCOD_REF: TEdit
    Left = 212
    Top = 107
    Width = 130
    Height = 21
    MaxLength = 20
    TabOrder = 4
    OnChange = signalizeChange
  end
  object edCOD_BARRAS: TEdit
    Left = 344
    Top = 107
    Width = 131
    Height = 21
    MaxLength = 20
    TabOrder = 5
    OnChange = signalizeChange
  end
  object edALT_MAX: TCurrencyEdit
    Left = 236
    Top = 146
    Width = 69
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = '0.0000;-,0.0000'
    TabOrder = 8
    OnChange = signalizeChange
  end
  object edLARG_MAX: TCurrencyEdit
    Left = 82
    Top = 146
    Width = 69
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = '0.0000;-,0.0000'
    TabOrder = 6
    OnChange = signalizeChange
  end
  object edPROF_MAX: TCurrencyEdit
    Left = 160
    Top = 146
    Width = 69
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = '0.0000;-,0.0000'
    TabOrder = 7
    OnChange = signalizeChange
  end
  object edTEMPO_MEDIO: TCurrencyEdit
    Left = 341
    Top = 162
    Width = 69
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = '0.0000;-,0.0000'
    TabOrder = 12
    OnChange = signalizeChange
  end
  object cmdUpdate: TBitBtn
    Left = 292
    Top = 422
    Width = 102
    Height = 25
    Caption = '&Gravar'
    Enabled = False
    TabOrder = 15
    OnClick = cmdUpdateClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF97433F97433FB59A9BB59A9BB59A9BB5
      9A9BB59A9BB59A9BB59A9B93303097433FFF00FFFF00FFFF00FFFF00FF97433F
      D66868C66060E5DEDF92292A92292AE4E7E7E0E3E6D9DFE0CCC9CC8F201FAF46
      4697433FFF00FFFF00FFFF00FF97433FD06566C25F5FE9E2E292292A92292AE2
      E1E3E2E6E8DDE2E4CFCCCF8F2222AD464697433FFF00FFFF00FFFF00FF97433F
      D06565C15D5DECE4E492292A92292ADFDDDFE1E6E8E0E5E7D3D0D28A1E1EAB44
      4497433FFF00FFFF00FFFF00FF97433FD06565C15B5CEFE6E6EDE5E5E5DEDFE0
      DDDFDFE0E2E0E1E3D6D0D2962A2AB24A4A97433FFF00FFFF00FFFF00FF97433F
      CD6263C86060C96767CC7272CA7271C66969C46464CC6D6CCA6667C55D5DCD65
      6597433FFF00FFFF00FFFF00FF97433FB65553C27B78D39D9CD7A7A5D8A7A6D8
      A6A5D7A09FD5A09FD7A9A7D8ABABCC666797433FFF00FFFF00FFFF00FF97433F
      CC6667F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC66
      6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
      F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
      CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
      6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
      F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
      CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
      6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
      F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FFFF00FF
      97433FF9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F99743
      3FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object cmdCancel: TBitBtn
    Left = 397
    Top = 422
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Sair'
    TabOrder = 16
    OnClick = cmdCancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object cmdNew: TBitBtn
    Left = 186
    Top = 422
    Width = 102
    Height = 25
    Caption = '&Nova'
    TabOrder = 14
    OnClick = cmdNewClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      B78183B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
      83B78183B78183FF00FFFF00FFFF00FFC7A79CFEEED4F7E3C5F6DFBCF5DBB4F3
      D7ABF3D3A2F1CF9AF0CF97F0CF98F0CF98F5D49AB78183FF00FFFF00FFFF00FF
      C7A79EFDEFD9F6E3CBF5DFC2F4DBBAF2D7B2F1D4A9F1D0A2EECC99EECC97EECC
      97F3D199B78183FF00FFFF00FFFF00FFC7A9A1FEF3E3F8E7D3F5E3CBF5DFC3F3
      DBBBF2D7B2F1D4ABF0D0A3EECC9AEECC97F3D199B78183FF00FFFF00FFFF00FF
      C9ACA5FFF7EBF9EBDAF7E7D2F6E3CAF5DFC2F4DBB9F2D7B2F1D4AAF0D0A1EFCD
      99F3D198B78183FF00FFFF00FFFF00FFCEB2AAFFFCF4FAEFE4F8EADAF7E7D3F5
      E2CBF5DFC2F4DBBBF1D7B2F1D3AAF0D0A1F3D29BB78183FF00FFFF00FFFF00FF
      D3B7AFFFFFFDFBF4ECFAEFE3F9EBDAF7E7D2F5E3C9F5DFC2F4DBBAF2D7B1F0D4
      A9F5D5A3B78183FF00FFFF00FFFF00FFD7BBB2FFFFFFFEF9F5FBF3ECFAEFE2F9
      EADAF8E7D2F5E3CAF5DEC2F4DBBAF2D8B2F6D9ACB78183FF00FFFF00FFFF00FF
      DABEB3FFFFFFFFFEFDFDF8F4FBF3ECF9EFE3F8EADAF7E7D2F6E2CAF6DEC1F4DB
      B9F8DDB4B78183FF00FFFF00FFFF00FFDEC1B5FFFFFFFFFFFFFFFEFDFEF9F4FB
      F3EBFAEFE2F9EBD9F8E6D1F6E2C8F7E1C2F0DAB7B78183FF00FFFF00FFFF00FF
      E2C5B5FFFFFFFFFFFFFFFFFFFFFEFDFDF9F4FBF3EBFAEEE2FAEDDCFCEFD9E6D9
      C4C6BCA9B78183FF00FFFF00FFFF00FFE5C7B7FFFFFFFFFFFFFFFFFFFFFFFFFF
      FEFDFDF8F3FDF6ECF1E1D5C6A194B59489B08F81B78183FF00FFFF00FFFF00FF
      E9CBB8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFFFEF9E3CFC9BF8C76E8B2
      70ECA54AC58768FF00FFFF00FFFF00FFECCDBAFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFE4D4D2C89A7FFAC577CD9377FF00FFFF00FFFF00FFFF00FF
      EACAB6FCF7F4FCF7F3FBF6F3FBF6F3FAF5F3F9F5F3F9F5F3E1D0CEC7977CCF9B
      86FF00FFFF00FFFF00FFFF00FFFF00FFE9C6B1EBCCB8EBCCB8EBCCB8EBCBB8EA
      CBB8EACBB8EACCB9DABBB0B8857AFF00FFFF00FFFF00FFFF00FF}
  end
  object pgDetalhes: TPageControl
    Left = 5
    Top = 198
    Width = 470
    Height = 217
    ActivePage = tbMaquinas
    TabOrder = 13
    object tbPecas: TTabSheet
      Caption = 'Pe'#231'as'
      object stPecas: TCSDVirtualStringTree
        Left = 0
        Top = 0
        Width = 462
        Height = 189
        Align = alClient
        BorderStyle = bsSingle
        CheckImageKind = ckXP
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsFlatButtons
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
        OnChecked = stPecasChecked
        OnChecking = stPecasChecking
        OnEditing = stPecasEditing
        OnGetText = stPecasGetText
        OnNewText = stPecasNewText
        AutoEdit = True
        ColumnDefs = <
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end
          item
            FldType = ctInteger
            MaxLength = 3
            ReadOnly = False
            CustomFldType = 1
            CustomMaxLength = 3
          end>
        MustBlockBoundaryEditExit = True
        Columns = <
          item
            Position = 0
            Width = 380
            WideText = 'Descri'#231#227'o'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 60
            WideText = 'Seq'
          end>
      end
    end
    object tbInsumos: TTabSheet
      Caption = 'Insumos'
      ImageIndex = 1
      object stInsumos: TCSDVirtualStringTree
        Left = 0
        Top = 0
        Width = 462
        Height = 189
        Align = alClient
        BorderStyle = bsSingle
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsFlatButtons
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        PopupMenu = popInsumos
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
        OnEditing = stInsumosEditing
        OnGetText = stInsumosGetText
        OnNewText = stInsumosNewText
        AutoEdit = True
        ColumnDefs = <
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end
          item
            OnPrepareEdit = stInsumosColumnDefs1PrepareEdit
            FldType = ctFloat
            MaxLength = 8
            ReadOnly = False
            CustomFldType = 2
            CustomMaxLength = 8
          end
          item
            FldType = ctFloat
            MaxLength = 5
            ReadOnly = False
            CustomFldType = 2
            CustomMaxLength = 5
          end>
        MustBlockBoundaryEditExit = True
        Columns = <
          item
            Position = 0
            Width = 310
            WideText = 'Descri'#231#227'o'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 60
            WideText = 'Qtd'
          end
          item
            Alignment = taRightJustify
            Position = 2
            Width = 70
            WideText = '% Perda'
          end>
      end
    end
    object tbServicos: TTabSheet
      Caption = 'Servi'#231'os'
      ImageIndex = 2
      object stServicos: TCSDVirtualStringTree
        Left = 0
        Top = 0
        Width = 462
        Height = 189
        Align = alClient
        BorderStyle = bsSingle
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsFlatButtons
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        PopupMenu = popServicos
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
        OnEditing = stPecasEditing
        OnGetText = stServicosGetText
        OnNewText = stServicosNewText
        AutoEdit = True
        ColumnDefs = <
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end
          item
            OnPrepareEdit = stServicosColumnDefs1PrepareEdit
            FldType = ctFloat
            MaxLength = 8
            ReadOnly = False
            CustomFldType = 2
            CustomMaxLength = 8
          end>
        MustBlockBoundaryEditExit = True
        Columns = <
          item
            Position = 0
            Width = 380
            WideText = 'Descri'#231#227'o'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 60
            WideText = 'Qtd'
          end>
      end
    end
    object tbTiposAcabamento: TTabSheet
      Caption = 'Tipos de Acabamento'
      ImageIndex = 3
      object stTiposAcabamento: TCSDVirtualStringTree
        Left = 0
        Top = 0
        Width = 462
        Height = 189
        Align = alClient
        BorderStyle = bsSingle
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsFlatButtons
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        PopupMenu = popTiposAcabamentos
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
        OnEditing = stInsumosEditing
        OnGetText = stTiposAcabamentoGetText
        OnNewText = stTiposAcabamentoNewText
        AutoEdit = True
        ColumnDefs = <
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end
          item
            OnPrepareEdit = stTiposAcabamentoColumnDefs1PrepareEdit
            FldType = ctFloat
            MaxLength = 8
            ReadOnly = False
            CustomFldType = 2
            CustomMaxLength = 8
          end
          item
            FldType = ctFloat
            MaxLength = 5
            ReadOnly = False
            CustomFldType = 2
            CustomMaxLength = 5
          end>
        MustBlockBoundaryEditExit = True
        Columns = <
          item
            Position = 0
            Width = 310
            WideText = 'Descri'#231#227'o'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 60
            WideText = 'Qtd'
          end
          item
            Alignment = taRightJustify
            Position = 2
            Width = 70
            WideText = '% Perda'
          end>
      end
    end
    object tbMaquinas: TTabSheet
      Caption = 'M'#225'quinas e Ferramentas'
      ImageIndex = 4
      object stMaquinas: TCSDVirtualStringTree
        Left = 0
        Top = 0
        Width = 462
        Height = 189
        Align = alClient
        BorderStyle = bsSingle
        CheckImageKind = ckXP
        Header.AutoSizeIndex = -1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoColumnResize, hoDrag, hoVisible]
        Header.Style = hsFlatButtons
        HintAnimation = hatNone
        HintMode = hmDefault
        IncrementalSearchDirection = sdForward
        PopupMenu = popMaquinas
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
        OnChecked = stMaquinasChecked
        OnDblClick = stMaquinasDblClick
        OnEditing = stMaquinasEditing
        OnGetText = stMaquinasGetText
        OnInitNode = stMaquinasInitNode
        OnNewText = stMaquinasNewText
        OnResize = stMaquinasResize
        AutoEdit = True
        ColumnDefs = <
          item
            FldType = ctString
            MaxLength = 0
            ReadOnly = True
          end
          item
            OnPrepareEdit = stMaquinasColumnDefs1PrepareEdit
            FldType = ctFloat
            MaxLength = 8
            ReadOnly = False
            CustomFldType = 2
            CustomMaxLength = 8
          end
          item
            OnPrepareEdit = stMaquinasColumnDefs2PrepareEdit
            FldType = ctFloat
            MaxLength = 8
            ReadOnly = False
            CustomFldType = 2
            CustomMaxLength = 8
          end>
        MustBlockBoundaryEditExit = True
        Columns = <
          item
            Position = 0
            Width = 284
            WideText = 'M'#225'quinas e Ferramentas'
          end
          item
            Alignment = taRightJustify
            Position = 1
            Width = 72
            WideText = 'Tm SetUp'
          end
          item
            Alignment = taRightJustify
            Position = 2
            Width = 80
            WideText = 'Tm Opera'#231#227'o'
          end>
      end
    end
  end
  object edALT_MIN: TCurrencyEdit
    Left = 236
    Top = 170
    Width = 69
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = '0.0000;-,0.0000'
    TabOrder = 11
    OnChange = signalizeChange
  end
  object edLARG_MIN: TCurrencyEdit
    Left = 82
    Top = 170
    Width = 69
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = '0.0000;-,0.0000'
    TabOrder = 9
    OnChange = signalizeChange
  end
  object edPROF_MIN: TCurrencyEdit
    Left = 160
    Top = 170
    Width = 69
    Height = 21
    AutoSize = False
    DecimalPlaces = 4
    DisplayFormat = '0.0000;-,0.0000'
    TabOrder = 10
    OnChange = signalizeChange
  end
  object cbTipoDocumento: TComboBox
    Left = 4
    Top = 107
    Width = 205
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 3
    OnClick = signalizeChange
  end
  object popServicos: TPopupMenu
    OnPopup = popServicosPopup
    Left = 97
    Top = 240
    object cmNewServico: TMenuItem
      Caption = '&Novo Servi'#231'o'
      OnClick = cmNewServicoClick
    end
    object cmDeleteServico: TMenuItem
      Caption = 'E&xcluir Servi'#231'o'
      OnClick = cmDeleteServicoClick
    end
  end
  object popTiposAcabamentos: TPopupMenu
    OnPopup = popTiposAcabamentosPopup
    Left = 63
    Top = 290
    object cmNewTipoAcabamento: TMenuItem
      Caption = '&Novo Tipo de Acabamento'
      OnClick = cmNewTipoAcabamentoClick
    end
    object cmDeleteTipoAcabamento: TMenuItem
      Caption = 'E&xcluir Tipo de Acabamento'
      OnClick = cmDeleteTipoAcabamentoClick
    end
  end
  object popInsumos: TPopupMenu
    OnPopup = popInsumosPopup
    Left = 233
    Top = 266
    object cmNewInsumo: TMenuItem
      Caption = '&Novo Insumo'
      OnClick = cmNewInsumoClick
    end
    object cmDeleteInsumo: TMenuItem
      Caption = 'E&xcluir Insumo'
      OnClick = cmDeleteInsumoClick
    end
  end
  object popMaquinas: TPopupMenu
    OnPopup = popMaquinasPopup
    Left = 316
    Top = 243
    object cmNovaMaquina: TMenuItem
      Caption = 'Nova &M'#225'quina'
      OnClick = cmNovaMaquinaClick
    end
    object cmNovaFerramenta: TMenuItem
      Caption = 'Nova &Ferramenta'
      OnClick = cmNovaFerramentaClick
    end
    object cmPropriedades: TMenuItem
      Caption = '&Propriedades'
      OnClick = cmPropriedadesClick
    end
    object cmDelete: TMenuItem
      Caption = 'E&xcluir'
      OnClick = cmDeleteClick
    end
  end
end
