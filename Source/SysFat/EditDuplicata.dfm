object fmEditDuplicata: TfmEditDuplicata
  Left = 192
  Top = 216
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Duplicata'
  ClientHeight = 190
  ClientWidth = 766
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    766
    190)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TStaticText
    Left = 8
    Top = 40
    Width = 163
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Data de Vencimento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object Label5: TStaticText
    Left = 464
    Top = 40
    Width = 163
    Height = 21
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Data de Pagamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object laHIST_LAN: TStaticText
    Left = 8
    Top = 64
    Width = 163
    Height = 21
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Hist'#243'rico do Lan'#231'amento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 766
    Height = 29
    Align = alTop
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      766
      29)
    object cmdNew: TSpeedButton
      Left = 713
      Top = 3
      Width = 22
      Height = 22
      Hint = 'Nova Duplicata'
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
      Left = 738
      Top = 3
      Width = 22
      Height = 22
      Hint = 'Salvar Duplicata'
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
    object Label10: TStaticText
      Left = 6
      Top = 3
      Width = 80
      Height = 24
      Caption = 'Duplicata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object chkFLAG_CBR_JUR: TCheckBox
      Left = 446
      Top = 4
      Width = 139
      Height = 17
      Anchors = [akRight]
      Caption = 'Cobran'#231'a de Juros'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = SignalizeChange
    end
    object chkFLAG_BAIXA: TCheckBox
      Left = 174
      Top = 4
      Width = 139
      Height = 17
      Anchors = [akLeft]
      Caption = 'Duplicata Liquidada'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object edHIST_LAN: TEdit
    Left = 176
    Top = 64
    Width = 577
    Height = 21
    Anchors = [akLeft, akRight]
    BevelKind = bkFlat
    BorderStyle = bsNone
    MaxLength = 50
    TabOrder = 1
    OnChange = SignalizeChange
  end
  object edDTA_VENC: TDateEdit
    Left = 176
    Top = 40
    Width = 121
    Height = 21
    BevelKind = bkFlat
    BorderStyle = bsNone
    Anchors = [akLeft]
    NumGlyphs = 2
    TabOrder = 2
  end
  object edDTA_PGTO: TDateEdit
    Left = 632
    Top = 40
    Width = 121
    Height = 21
    BevelKind = bkFlat
    BorderStyle = bsNone
    Anchors = [akRight]
    NumGlyphs = 2
    TabOrder = 3
  end
  object gbValues: TGroupBox
    Left = 8
    Top = 88
    Width = 753
    Height = 97
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Valores da Duplicata'
    TabOrder = 7
    DesignSize = (
      753
      97)
    object stVLR_VENC: TStaticText
      Left = 8
      Top = 16
      Width = 163
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'SubTotal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object stVLR_ACR_DSCT: TStaticText
      Left = 8
      Top = 40
      Width = 163
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Acr'#233'scimos / Descontos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object stVLR_DSP_CBR: TStaticText
      Left = 464
      Top = 64
      Width = 163
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Despesas de Cobran'#231'a'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object stVLR_ODSP: TStaticText
      Left = 464
      Top = 16
      Width = 163
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Outras Despesas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object stVLR_PGTO: TStaticText
      Left = 8
      Top = 64
      Width = 163
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft]
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'Valor Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object edVLR_VENC: TCurrencyEdit
      Left = 176
      Top = 16
      Width = 109
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Anchors = [akLeft]
      TabOrder = 5
      OnChange = edVLR_VENCChange
    end
    object edVLR_ACR_DSCT: TCurrencyEdit
      Left = 176
      Top = 40
      Width = 109
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Anchors = [akLeft]
      TabOrder = 6
      OnChange = edVLR_VENCChange
    end
    object edVLR_DSP_CBR: TCurrencyEdit
      Left = 632
      Top = 64
      Width = 109
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Anchors = [akRight]
      TabOrder = 7
      OnChange = SignalizeChange
    end
    object edVLR_ODSP: TCurrencyEdit
      Left = 632
      Top = 16
      Width = 109
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Anchors = [akRight]
      TabOrder = 8
      OnChange = SignalizeChange
    end
    object edVLR_PGTO: TCurrencyEdit
      Left = 176
      Top = 64
      Width = 109
      Height = 21
      AutoSize = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Anchors = [akLeft]
      TabOrder = 9
      OnChange = edVLR_PGTOChange
    end
  end
end
