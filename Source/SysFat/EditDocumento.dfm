object fmEditDocumento: TfmEditDocumento
  Left = 209
  Top = 140
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Documento'
  ClientHeight = 499
  ClientWidth = 784
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 29
    Align = alTop
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      784
      29)
    object cmdNew: TSpeedButton
      Left = 732
      Top = 3
      Width = 22
      Height = 22
      Hint = 'Incluir Novo Documento'
      Anchors = [akTop, akRight]
      Flat = True
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
      ParentShowHint = False
      ShowHint = True
      OnClick = cmdNewClick
    end
    object cmdUpdate: TSpeedButton
      Left = 759
      Top = 3
      Width = 22
      Height = 22
      Hint = 'Gravar Documento'
      Anchors = [akTop, akRight]
      Flat = True
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
      ParentShowHint = False
      ShowHint = True
      OnClick = cmdUpdateClick
    end
    object Label9: TStaticText
      Left = 8
      Top = 3
      Width = 96
      Height = 24
      Caption = 'Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 29
    Width = 784
    Height = 220
    Align = alTop
    ParentColor = True
    TabOrder = 1
    DesignSize = (
      784
      220)
    object Label2: TStaticText
      Left = 8
      Top = 8
      Width = 163
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Tipo de Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object Label3: TStaticText
      Left = 8
      Top = 32
      Width = 163
      Height = 21
      Anchors = [akTop, akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Data da Emiss'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object Label5: TStaticText
      Left = 320
      Top = 32
      Width = 121
      Height = 21
      Anchors = [akTop, akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'No do Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object Label1: TStaticText
      Left = 8
      Top = 56
      Width = 163
      Height = 21
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object Label11: TStaticText
      Left = 8
      Top = 128
      Width = 769
      Height = 21
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = ' Observa'#231#245'es '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object cbGrupoMovimento: TComboBox
      Left = 176
      Top = 8
      Width = 359
      Height = 21
      BevelKind = bkFlat
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 0
      OnClick = cbGrupoMovimentoClick
    end
    object edNUM_DOC: TCurrencyEdit
      Left = 448
      Top = 32
      Width = 84
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      DecimalPlaces = 0
      DisplayFormat = '0;-0'
      Enabled = False
      Anchors = [akTop, akRight]
      MaxLength = 10
      TabOrder = 1
      OnChange = signalizeChange
    end
    object cbFK_CADASTROS: TComboBox
      Left = 176
      Top = 56
      Width = 359
      Height = 21
      BevelKind = bkFlat
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 2
      OnClick = signalizeChange
    end
    object edOBS_DOC: TMemo
      Left = 8
      Top = 152
      Width = 769
      Height = 60
      BevelKind = bkFlat
      BorderStyle = bsNone
      TabOrder = 3
      OnChange = signalizeChange
    end
    object dtDATA_EMISSAO: TDateEdit
      Left = 176
      Top = 32
      Width = 137
      Height = 21
      BevelKind = bkFlat
      BorderStyle = bsNone
      NumGlyphs = 2
      TabOrder = 4
    end
    object GroupBox1: TGroupBox
      Left = 544
      Top = 8
      Width = 233
      Height = 113
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Valores'
      TabOrder = 5
      DesignSize = (
        233
        113)
      object Label4: TStaticText
        Left = 8
        Top = 16
        Width = 115
        Height = 21
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'SubTotal: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object Label6: TStaticText
        Left = 8
        Top = 48
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Acr'#233'sc./Desc: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object Label7: TStaticText
        Left = 8
        Top = 80
        Width = 113
        Height = 21
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Valor Total: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object edVLR_STOT: TCurrencyEdit
        Left = 128
        Top = 16
        Width = 97
        Height = 21
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 0
        OnChange = edVLR_ACR_DSCTChange
      end
      object edVLR_ACR_DSCT: TCurrencyEdit
        Left = 128
        Top = 48
        Width = 97
        Height = 21
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 1
        OnChange = edVLR_ACR_DSCTChange
      end
      object edVAL_TOT: TCurrencyEdit
        Left = 128
        Top = 80
        Width = 97
        Height = 21
        TabStop = False
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 2
      end
    end
    object gbFlags: TGroupBox
      Left = 8
      Top = 80
      Width = 529
      Height = 41
      TabOrder = 11
      object chkFLAG_BXAC: TCheckBox
        Left = 13
        Top = 16
        Width = 217
        Height = 17
        Caption = 'Documento Liquidado'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object chkFLAG_CANC: TCheckBox
        Left = 299
        Top = 16
        Width = 217
        Height = 17
        Caption = 'Documento Cancelado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object pDupl: TPanel
    Left = 0
    Top = 249
    Width = 784
    Height = 250
    Align = alClient
    ParentColor = True
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 782
      Height = 29
      Align = alTop
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        782
        29)
      object cmdNewDuplicata: TSpeedButton
        Left = 705
        Top = 3
        Width = 22
        Height = 22
        Hint = 'Incluir Nova Duplicata'
        Anchors = [akTop, akRight]
        Flat = True
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
        ParentShowHint = False
        ShowHint = True
        OnClick = cmdNewDuplicataClick
      end
      object cmdEditDuplicata: TSpeedButton
        Left = 730
        Top = 3
        Width = 22
        Height = 22
        Hint = 'Consultar Duplicata Selecionada'
        Anchors = [akTop, akRight]
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFB78183B78183B78183B78183B78183B78183B78183B7
          8183B78183B78183B78183B78183B78183FF00FFFF00FFFF00FFB78183FDEFD9
          F4E1C9E4CFB4D1BCA0CDB798DAC09AE4C599E9C896EDCB96EECC97F3D199B781
          83FF00FFFF00FFFF00FFB48176FEF3E3F8E7D3494645373C3E516061AE9C82BF
          A889D0B48DE4C393EDCB96F3D199B78183FF00FFFF00FFFF00FFB48176FFF7EB
          F9EBDAB0A5981B617D097CA818556F66625BA79479C5AC86DCBD8DEECD95B781
          83FF00FFFF00FFFF00FFBA8E85FFFCF4FAEFE4F2E5D638728629799A8D787F95
          6D6F7959539D8B73BAA380D9BC8CB47F81FF00FFFF00FFFF00FFBA8E85FFFFFD
          FBF4ECFAEFE3A5B3B17C7078E5A6A3C89292A4727276575195856CAF9978A877
          79FF00FFFF00FFFF00FFCB9A82FFFFFFFEF9F5FBF3ECF4EBDF85787CEEB7B5DA
          A6A6C38E8E9E6E6E73564F93836B996E6FFF00FFFF00FFFF00FFCB9A82FFFFFF
          FFFEFDFDF8F4FBF3ECF0E4D9A37978E9B5B5D9A5A5C48F8F9D6D6D7759528F67
          69FF00FFFF00FFFF00FFDCA887FFFFFFFFFFFFFFFEFDFEF9F4FBF3EBE8D9CE9E
          7473E8B5B5D8A4A4C18D8D9D6C6C7D5556FF00FFFF00FFFF00FFDCA887FFFFFF
          FFFFFFFFFFFFFFFEFDFDF9F4FBF3EBE0CFC5A17676ECB9B9D6A2A2C68E8E965F
          5D585C60FF00FFFF00FFE3B18EFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDF8F3FD
          F6ECDAC5BCAC8080F3BCBBA3878C3392B319ADCC19ADCCFF00FFE3B18EFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFFFEF9E3CFC9AA7A71B27873469CBA0FCA
          F400A4E6021EAA000099EDBD92FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFE4D4D2B8857ADCA76A10A5CF04A8E60936C9092CC30318AEEDBD92FCF7F4
          FCF7F3FBF6F3FBF6F3FAF5F3F9F5F3F9F5F3E1D0CEB8857ACF9B86FF00FF077D
          CD4860F1204ADD0416AAEDBD92DCA887DCA887DCA887DCA887DCA887DCA887DC
          A887DCA887B8857AFF00FFFF00FFFF00FF3E4BDB192DC4FF00FF}
        ParentShowHint = False
        ShowHint = True
        OnClick = cmdEditDuplicataClick
      end
      object cmdDeleteDuplicata: TSpeedButton
        Left = 755
        Top = 3
        Width = 22
        Height = 22
        Hint = 'Cancelar o Duplicata Selecionada'
        Anchors = [akTop, akRight]
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00F5CA9900F6D1A100F5CB9900F3C18B00F2C08800F3C3
          8E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FCF0CC00FEF6D500FCE6BE00F6D5A600FCC69600FFC49500FDD6
          AE00FFE2BF00FEE2BA00F4C59000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FEFBDD00FEF9D800FCE4BB00F0D6A700BBC888009CBD6F0043A7
          360072BA5E00EFF6D400FDEECC00F2BF8900FF00FF00FF00FF00FF00FF00FF00
          FF00F1B87F00F6D0A100FDF4D100FDEBC500FCDBB30044AB3800009402000E9A
          0F0010970B0057B64E00FEF5DB00F4C28C00FF00FF00FF00FF00FF00FF00FF00
          FF00F2BD8700F1BA8100F3C18A00F8D5A600FFE1BE0047AD3A000088000084CD
          8500FFF4EF0063B55200B6C07900FDC08D00FF00FF00FF00FF00FF00FF00FF00
          FF00F5C49200F5C79600F4C39000F4BE8900FCC5960093C47B005CB95C0089CB
          8300FFFFFF00F7FEFC00CBCA9200F6BC8500FF00FF00FF00FF00FF00FF00FF00
          FF00F9D0A800FBD2AD00FAD0A900FACEA600F6CDA100D0DFB800FFFFFF00E2F2
          DF0071C26E0066C06600C8CB9200FAC18E00FF00FF00FF00FF00FF00FF00F8D4
          A800FDDEBF00FDDEBE00FDDBBB00FDDBBB00FFDEC50078BB610098D49800E7F5
          E6003EAD3B00008A00009AC17600FFCCA600F2BE8700FF00FF00FF00FF00F8D4
          A800FFEFD100FEEACB00FEE9C900FEE7C800FFE7C900E2E2BE00169A14002BA1
          2900089708000092000090C47800FFD9BC00F2BE8700FF00FF00FF00FF00FBE5
          BD00FFFCDF00FFF7D800FFF6D600FFF4D500FFF3D200FFF5DC00C5DFAD0042AB
          3B0043AE3B00AFD79E00C5DCAA00FFE7C900F5C79300FF00FF00FF00FF00FDF3
          D100FFFFE100FFFCDD00FFFDDE00FFFCDD00FFFCDE00FFFDDE00FFFFE800FFFF
          F000FFFFED00FFFFE700FFFAE000FFF7D700F6CE9D00FF00FF00FF00FF00FEF7
          D700FFFFE500FFFFE200FFFFE200FFFFE300FFFEE000FEF8D800FAE3B600F7CE
          9500F7CF9700F9E1B600FEF5D200FFFFE500F6D5A700FF00FF00FF00FF00F7D8
          AB00FAE6C000FAE5BE00F9E1B900F8DAAE00F6CD9800F3BE8000F0B16A00F0B0
          6700F0B37000F4BE8800FBCE9E00FDDDB400FBCEA000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F1B6
          6F00F3BD8200F9CB9B00FBCD9F00FBCB9B00FBCB9B00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FBCE9F00FBCE9F00FBCE9F00FF00FF00FF00FF00}
        ParentShowHint = False
        ShowHint = True
        OnClick = cmdDeleteDuplicataClick
      end
      object Label10: TStaticText
        Left = 6
        Top = 2
        Width = 89
        Height = 24
        Caption = 'Duplicatas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object sbMsg: TStatusBar
      Left = 1
      Top = 230
      Width = 782
      Height = 19
      Panels = <>
      SimplePanel = True
      SimpleText = 
        'Utilize o bot'#227'o direito do Mouse para realizar opera'#231#245'es na Dupl' +
        'icata Selecionada...'
    end
    object pgDupl: TPageControl
      Left = 1
      Top = 30
      Width = 782
      Height = 200
      ActivePage = tsList
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 2
      object tsList: TTabSheet
        Caption = 'tsList'
        TabVisible = False
        object stDuplicatas: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 774
          Height = 190
          Align = alClient
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = True
          Header.AutoSizeIndex = -1
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'MS Sans Serif'
          Header.Font.Style = []
          Header.Options = [hoColumnResize, hoDrag, hoVisible]
          Header.Style = hsXPStyle
          HintAnimation = hatNone
          ParentCtl3D = False
          TabOrder = 0
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
          OnDblClick = stDuplicatasDblClick
          OnGetText = stDuplicatasGetText
          OnResize = stDuplicatasResize
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
      object tsMananger: TTabSheet
        Caption = 'tsMananger'
        ImageIndex = 1
        TabVisible = False
      end
    end
  end
end
