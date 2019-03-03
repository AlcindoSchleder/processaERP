inherited CdCalcRegion: TCdCalcRegion
  Caption = 'CdCalcRegion'
  ClientHeight = 445
  ClientWidth = 523
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object shTitle: TShape
    Left = 8
    Top = 8
    Width = 505
    Height = 33
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 14
    Width = 489
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Cadastro das Fra'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object sbNewRegion: TSpeedButton
    Left = 488
    Top = 88
    Width = 25
    Height = 21
    Hint = 'Gerenciar Regi'#245'es'
    Anchors = [akTop, akRight]
    Flat = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      9868639868639868639868639868639868639868639868639868639868639868
      63986863A66D68FF00FFFF00FFFF00FFA0756BFCE7C4FADEB7F6D8A9F4D39EF3
      CE93F0C988EFC581EFC581EFC581EFC581F3CA82986863FF00FFFF00FFFF00FF
      9F746CF7E2C7F3DABBF2D3AFEFCFA5EDCA9AEDC591EBC087E9BD7FE9BD7FE9BD
      7FEDC180986863FF00FFFF00FFFF00FFA0756EFAE7D3FFEBCFFCE2C1FCDDB7FB
      D9ACEFCB9CEDC591EAC087E9BD7FE9BD7FEDC180986863FF00FFFF00FFFF00FF
      A17772FCF3E2908F8E908F8E908F8E908F8EE6C69EEFCB9CEDC591EBC086E9BD
      7FEDC180986863FF00FFFF00FFFF00FFA77E74FFFFF435322D6E7091122AA621
      243BD3B78EF4D3A9EDCA9AEDC590EBC086EDC180986863FF00FFFF00FFFF00FF
      AF8378FFFFFB37373C687EE97B90FE102598DDC49EFCDDB5EFCEA4EDCB9AEBC5
      90EDC487986863FF00FFFF00FFFF00FFB6897BFFFFFF414141514C4A5D55491A
      2D956074D1C2B099FADAB2EFCEA4EECA9AEFC791986863FF00FFFF00FFFF00FF
      BC8F7DFFFFFFFFFFFFF6EFE7F3E9DCF7E7D56479E5465DE0E0CBBCF6D5ADEFCF
      A4F3CF9C986863FF00FFFF00FFFF00FFC2937FFFFFFF908F8E908F8E908F8E90
      8F8EEFE0CAC1BDD8E9D4C4F6D9B7F6D7B0E7C99F977569FF00FFFF00FFFF00FF
      CA9881FFFFFF2F2F2EA7A6A45164AF2D3041D7CBBDFFF4DCFBE9D0FAE9CCDAC9
      AFB0A48E826C66FF00FFFF00FFFF00FFD09E83FFFFFF44454A7A96FF4068FF1E
      2D79E5DAC4FEF8EBE9D1C1A5686BA5686BA5686BA5686BFF00FFFF00FFFF00FF
      D7A484FFFFFF2A2B2F626986898E9D0920A6BDC7F0FFFFFAD1B5ADA5686BE79F
      4EE18931A5686BFF00FFFF00FFFF00FFD9A687FFFFFFADB0B19697969898918C
      98C44267FF99B0FFD0B7BAA5686BF0AC58A5686BFF00FFFF00FFFF00FFFF00FF
      D9A383FAF2EDFFFCF7FFFBF7FFFBF7FFFBEFCECFEA5D74EBB6A1B2A5686BA568
      6BFF00FFFF00FFFF00FFFF00FFFF00FFD3936ED59C78D59C78D39878CB9275C4
      8C73C08B72C68F70AD7768A5686BFF00FFFF00FFFF00FFFF00FF}
    OnClick = sbNewRegionClick
  end
  object sbNewFraction: TSpeedButton
    Left = 488
    Top = 56
    Width = 25
    Height = 21
    Hint = 'Gerenciar Tipo de Tabelas Fracionadas'
    Anchors = [akTop, akRight]
    Flat = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      9868639868639868639868639868639868639868639868639868639868639868
      63986863A66D68FF00FFFF00FFFF00FFA0756BFCE7C4FADEB7F6D8A9F4D39EF3
      CE93F0C988EFC581EFC581EFC581EFC581F3CA82986863FF00FFFF00FFFF00FF
      9F746CF7E2C7F3DABBF2D3AFEFCFA5EDCA9AEDC591EBC087E9BD7FE9BD7FE9BD
      7FEDC180986863FF00FFFF00FFFF00FFA0756EFAE7D3FFEBCFFCE2C1FCDDB7FB
      D9ACEFCB9CEDC591EAC087E9BD7FE9BD7FEDC180986863FF00FFFF00FFFF00FF
      A17772FCF3E2908F8E908F8E908F8E908F8EE6C69EEFCB9CEDC591EBC086E9BD
      7FEDC180986863FF00FFFF00FFFF00FFA77E74FFFFF435322D6E7091122AA621
      243BD3B78EF4D3A9EDCA9AEDC590EBC086EDC180986863FF00FFFF00FFFF00FF
      AF8378FFFFFB37373C687EE97B90FE102598DDC49EFCDDB5EFCEA4EDCB9AEBC5
      90EDC487986863FF00FFFF00FFFF00FFB6897BFFFFFF414141514C4A5D55491A
      2D956074D1C2B099FADAB2EFCEA4EECA9AEFC791986863FF00FFFF00FFFF00FF
      BC8F7DFFFFFFFFFFFFF6EFE7F3E9DCF7E7D56479E5465DE0E0CBBCF6D5ADEFCF
      A4F3CF9C986863FF00FFFF00FFFF00FFC2937FFFFFFF908F8E908F8E908F8E90
      8F8EEFE0CAC1BDD8E9D4C4F6D9B7F6D7B0E7C99F977569FF00FFFF00FFFF00FF
      CA9881FFFFFF2F2F2EA7A6A45164AF2D3041D7CBBDFFF4DCFBE9D0FAE9CCDAC9
      AFB0A48E826C66FF00FFFF00FFFF00FFD09E83FFFFFF44454A7A96FF4068FF1E
      2D79E5DAC4FEF8EBE9D1C1A5686BA5686BA5686BA5686BFF00FFFF00FFFF00FF
      D7A484FFFFFF2A2B2F626986898E9D0920A6BDC7F0FFFFFAD1B5ADA5686BE79F
      4EE18931A5686BFF00FFFF00FFFF00FFD9A687FFFFFFADB0B19697969898918C
      98C44267FF99B0FFD0B7BAA5686BF0AC58A5686BFF00FFFF00FFFF00FFFF00FF
      D9A383FAF2EDFFFCF7FFFBF7FFFBF7FFFBEFCECFEA5D74EBB6A1B2A5686BA568
      6BFF00FFFF00FFFF00FFFF00FFFF00FFD3936ED59C78D59C78D39878CB9275C4
      8C73C08B72C68F70AD7768A5686BFF00FFFF00FFFF00FFFF00FF}
    OnClick = sbNewFractionClick
  end
  object lFk_Tabela_Origem_Destino: TStaticText
    Left = 8
    Top = 88
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Regi'#227'o: '
    FocusControl = eFk_Tabela_Origem_Destino
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object eFk_Tabela_Origem_Destino: TComboBox
    Left = 136
    Top = 88
    Width = 353
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 1
    TabStop = False
    OnSelect = ChangeGlobal
  end
  object lVlr_Exd: TStaticText
    Left = 8
    Top = 120
    Width = 121
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Mutiplic. Exced.: '
    Enabled = False
    FocusControl = eVlr_Exd
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object lFlag_Exd: TCheckBox
    Left = 12
    Top = 122
    Width = 13
    Height = 17
    TabOrder = 3
    OnClick = ChangeGlobal
  end
  object eVlr_Exd: TCurrencyEdit
    Left = 136
    Top = 120
    Width = 105
    Height = 21
    AutoSize = False
    CheckOnExit = True
    Enabled = False
    TabOrder = 4
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object lPerc_Gris: TStaticText
    Left = 280
    Top = 120
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Percentual Gris: '
    FocusControl = ePerc_Gris
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object ePerc_Gris: TCurrencyEdit
    Left = 408
    Top = 120
    Width = 105
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00 %;-,0.00 %'
    Anchors = [akTop, akRight]
    TabOrder = 6
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object eVlr_Min_Gris: TCurrencyEdit
    Left = 408
    Top = 152
    Width = 105
    Height = 21
    AutoSize = False
    Anchors = [akTop, akRight]
    TabOrder = 7
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object lVlr_Min_Gris: TStaticText
    Left = 280
    Top = 152
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Valor M'#237'n. Gris: '
    FocusControl = eVlr_Min_Gris
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object eDiv_Ped: TCurrencyEdit
    Left = 136
    Top = 152
    Width = 105
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.00;-,0.00'
    TabOrder = 9
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object lDiv_Ped: TStaticText
    Left = 8
    Top = 152
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Div. do Ped'#225'gio: '
    FocusControl = eDiv_Ped
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object lVlr_Ped: TStaticText
    Left = 8
    Top = 184
    Width = 121
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Valor do Ped'#225'gio: '
    FocusControl = eVlr_Ped
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object eVlr_Ped: TCurrencyEdit
    Left = 136
    Top = 184
    Width = 105
    Height = 21
    AutoSize = False
    CheckOnExit = True
    TabOrder = 12
    ZeroEmpty = False
    OnChange = ChangeGlobal
  end
  object lFlag_TOper: TRadioGroup
    Left = 8
    Top = 208
    Width = 505
    Height = 33
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Tipo Opera'#231#227'o'
    Columns = 4
    Items.Strings = (
      'Nenhum'
      'Percentual'
      'Multimplicador'
      'Divisor')
    TabOrder = 13
    OnClick = ChangeGlobal
  end
  object vtList: TVirtualStringTree
    Left = 8
    Top = 248
    Width = 505
    Height = 185
    Anchors = [akLeft, akTop, akRight, akBottom]
    Colors.FocusedSelectionColor = clSilver
    EditDelay = 0
    Header.AutoSizeIndex = -1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    SelectionCurveRadius = 10
    TabOrder = 14
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages, toFullVertGridLines]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toRightClickSelect]
    OnBeforeItemErase = vtListBeforeItemErase
    OnChecked = vtListChecked
    OnChecking = vtListChecking
    OnEdited = vtListEdited
    OnEditing = vtListEditing
    OnGetText = vtListGetText
    OnInitNode = vtListInitNode
    OnKeyDown = vtListKeyDown
    OnNewText = vtListNewText
    Columns = <
      item
        Position = 0
        Width = 90
        WideText = 'Inicial'
      end
      item
        Position = 1
        Width = 90
        WideText = 'Final'
      end
      item
        Position = 2
        Width = 90
        WideText = #205'ndice'
      end
      item
        Position = 3
        Width = 90
        WideText = '% Ad Valoren'
      end
      item
        Position = 4
        Width = 90
        WideText = 'Taxa da Tabela'
      end>
  end
  object lFk_Tipo_Tabela_Fracao: TStaticText
    Left = 8
    Top = 56
    Width = 121
    Height = 21
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Tipo de Fra'#231#227'o: '
    FocusControl = eFk_Tipo_Tabela_Fracao
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
  end
  object eFk_Tipo_Tabela_Fracao: TComboBox
    Left = 136
    Top = 56
    Width = 353
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 16
    TabStop = False
    OnSelect = ChangeGlobal
  end
end
