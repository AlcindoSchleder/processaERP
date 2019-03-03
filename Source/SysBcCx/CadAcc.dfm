inherited CdAccount: TCdAccount
  Caption = 'CdAccount'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 8
    Top = 8
    Width = 433
    Height = 25
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel
    Left = 16
    Top = 11
    Width = 417
    Height = 19
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lTitle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pgAccount: TPageControl
    Left = 0
    Top = 40
    Width = 453
    Height = 216
    ActivePage = tsAccounts
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object tsAccounts: TTabSheet
      Caption = 'Dados da Conta'
      DesignSize = (
        445
        188)
      object gbSld: TGroupBox
        Left = 8
        Top = 64
        Width = 433
        Height = 121
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Saldos e Datas'
        TabOrder = 0
        DesignSize = (
          433
          121)
        object lSld_Cta: TStaticText
          Left = 8
          Top = 16
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Saldo: '
          FocusControl = eSld_Cta
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object eSld_Cta: TCurrencyEdit
          Left = 120
          Top = 16
          Width = 97
          Height = 21
          AutoSize = False
          Color = clTeal
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akLeft]
          ParentFont = False
          TabOrder = 1
        end
        object lSld_Prev: TStaticText
          Left = 224
          Top = 16
          Width = 97
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Saldo Previsto: '
          FocusControl = eSld_Prev
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object eSld_Prev: TCurrencyEdit
          Left = 328
          Top = 16
          Width = 97
          Height = 21
          AutoSize = False
          Color = clTeal
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Anchors = [akRight]
          ParentFont = False
          TabOrder = 3
        end
        object lDta_Abr: TStaticText
          Left = 8
          Top = 56
          Width = 105
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data de Abert.: '
          FocusControl = eDta_Abr
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object lDta_Fch: TStaticText
          Left = 224
          Top = 56
          Width = 97
          Height = 21
          Alignment = taRightJustify
          Anchors = [akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data de Fech.: '
          FocusControl = eDta_Fch
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object eDta_Abr: TDateEdit
          Left = 120
          Top = 56
          Width = 97
          Height = 21
          Anchors = [akLeft]
          NumGlyphs = 2
          TabOrder = 6
        end
        object eDta_Fch: TDateEdit
          Left = 328
          Top = 56
          Width = 97
          Height = 21
          Anchors = [akRight]
          NumGlyphs = 2
          TabOrder = 7
        end
        object lDta_Sld: TStaticText
          Left = 8
          Top = 96
          Width = 313
          Height = 21
          Alignment = taRightJustify
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = 'Data da '#218'ltima Movimenta'#231#227'o de Saldos: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object eDta_Sld: TEdit
          Left = 328
          Top = 96
          Width = 97
          Height = 21
          Anchors = [akLeft, akRight]
          Color = clTeal
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          Text = '  /  /    '
        end
      end
      object eDsc_Cta: TEdit
        Left = 160
        Top = 40
        Width = 281
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object lDsc_Cta: TStaticText
        Left = 8
        Top = 40
        Width = 145
        Height = 21
        Alignment = taRightJustify
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
        TabOrder = 2
      end
      object lPk_Contas: TStaticText
        Left = 8
        Top = 8
        Width = 145
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C'#243'digo: '
        FocusControl = ePk_Contas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object ePk_Contas: TCurrencyEdit
        Left = 160
        Top = 8
        Width = 65
        Height = 21
        AutoSize = False
        Color = clTeal
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Anchors = [akLeft, akRight]
        ParentFont = False
        TabOrder = 4
      end
      object lSld_Ini: TStaticText
        Left = 232
        Top = 8
        Width = 105
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Saldo Inicial: '
        FocusControl = eSld_Ini
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object eSld_Ini: TCurrencyEdit
        Left = 344
        Top = 8
        Width = 97
        Height = 21
        AutoSize = False
        Color = clTeal
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Anchors = [akRight]
        ParentFont = False
        TabOrder = 6
      end
    end
    object tsBankAccounts: TTabSheet
      Caption = 'Dados da Conta Banc'#225'ria'
      ImageIndex = 1
      DesignSize = (
        445
        188)
      object lNum_Cta: TStaticText
        Left = 0
        Top = 24
        Width = 129
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'mero da Conta: '
        FocusControl = eNum_Cta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eNum_Cta: TEdit
        Left = 136
        Top = 24
        Width = 97
        Height = 21
        Anchors = [akLeft]
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object lNum_IniTl: TStaticText
        Left = 240
        Top = 24
        Width = 129
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'm. Inicial Tal'#227'o: '
        FocusControl = eNum_IniTl
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object eNum_Chq: TCurrencyEdit
        Left = 376
        Top = 104
        Width = 65
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        TabOrder = 3
      end
      object lNum_Chq: TStaticText
        Left = 240
        Top = 104
        Width = 129
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'm. do Cheque: '
        FocusControl = eNum_Chq
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object eNum_IniTl: TCurrencyEdit
        Left = 376
        Top = 24
        Width = 65
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        TabOrder = 5
      end
      object lPag_Num: TStaticText
        Left = 240
        Top = 64
        Width = 129
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Quant. de Folhas: '
        FocusControl = ePag_Num
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object eNum_Rem: TCurrencyEdit
        Left = 376
        Top = 144
        Width = 65
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        TabOrder = 7
      end
      object lNum_Rem: TStaticText
        Left = 240
        Top = 144
        Width = 129
        Height = 21
        Alignment = taRightJustify
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'm.Arq.Remessa: '
        FocusControl = eNum_Rem
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object ePag_Num: TCurrencyEdit
        Left = 376
        Top = 64
        Width = 65
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0.;- ,0.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        TabOrder = 9
      end
      object lNum_Crt: TStaticText
        Left = 0
        Top = 64
        Width = 129
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'N'#250'm. do Contrato: '
        FocusControl = eNum_Crt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object eNum_Crt: TEdit
        Left = 136
        Top = 64
        Width = 97
        Height = 21
        Anchors = [akLeft]
        CharCase = ecUpperCase
        TabOrder = 11
      end
      object lSld_Real: TStaticText
        Left = 0
        Top = 104
        Width = 129
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Saldo: '
        FocusControl = eSld_Real
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object eSld_Real: TCurrencyEdit
        Left = 136
        Top = 104
        Width = 97
        Height = 21
        AutoSize = False
        Color = clTeal
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Anchors = [akLeft]
        ParentFont = False
        TabOrder = 13
      end
      object lSld_Prvst: TStaticText
        Left = 0
        Top = 144
        Width = 129
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Saldo Previsto: '
        FocusControl = eSld_Prvst
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object eSld_Prvst: TCurrencyEdit
        Left = 136
        Top = 144
        Width = 97
        Height = 21
        AutoSize = False
        Color = clTeal
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Anchors = [akLeft]
        ParentFont = False
        TabOrder = 15
      end
    end
  end
end
