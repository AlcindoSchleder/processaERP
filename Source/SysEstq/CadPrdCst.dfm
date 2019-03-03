inherited fmPrdCost: TfmPrdCost
  Left = 257
  Top = 226
  Caption = 'fmPrdCost'
  ClientHeight = 270
  ClientWidth = 591
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgData: TPageControl
    Left = 0
    Top = 0
    Width = 591
    Height = 270
    ActivePage = tsDatesAndQtd
    Align = alClient
    TabOrder = 0
    object tsValues: TTabSheet
      Caption = 'Informa'#231#245'es dos Custos'
      ImageIndex = 39
      DesignSize = (
        583
        242)
      object lCust_Final: TStaticText
        Left = 0
        Top = 40
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Custo Final:'
        FocusControl = eCust_Final
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eCust_Final: TCurrencyEdit
        Left = 160
        Top = 40
        Width = 121
        Height = 21
        AutoSize = False
        Anchors = [akLeft]
        TabOrder = 1
        OnChange = ChangeGlobal
      end
      object lCust_Forn: TStaticText
        Left = 296
        Top = 41
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Custo Fornecedor:'
        Enabled = False
        FocusControl = eCust_Forn
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object eCust_Forn: TCurrencyEdit
        Left = 456
        Top = 41
        Width = 121
        Height = 21
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object lCust_Rjst: TStaticText
        Left = 0
        Top = 72
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Custo Reajuste:'
        FocusControl = eCust_Rjst
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object eCust_Rjst: TCurrencyEdit
        Left = 160
        Top = 72
        Width = 121
        Height = 21
        AutoSize = False
        Anchors = [akLeft]
        TabOrder = 5
        OnChange = ChangeGlobal
      end
      object lCust_UFrn: TStaticText
        Left = 296
        Top = 73
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Custo '#218'ltimo Fornec.:'
        Enabled = False
        FocusControl = eCust_UFrn
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object eCust_UFrn: TCurrencyEdit
        Left = 456
        Top = 73
        Width = 121
        Height = 21
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
      end
      object lQtd_Dias_Rep: TStaticText
        Left = 0
        Top = 104
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. de dias Reposi'#231#227'o:'
        FocusControl = eQtd_Dias_Rep
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object eQtd_Dias_Rep: TCurrencyEdit
        Left = 160
        Top = 104
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0;- ,0'
        Anchors = [akLeft]
        TabOrder = 9
        OnChange = ChangeGlobal
      end
      object lCust_Real: TStaticText
        Left = 296
        Top = 105
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Custo Real:'
        Enabled = False
        FocusControl = eCust_Real
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object eCust_Real: TCurrencyEdit
        Left = 456
        Top = 105
        Width = 121
        Height = 21
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
      end
      object lCust_Med: TStaticText
        Left = 296
        Top = 138
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Custo M'#233'dio:'
        Enabled = False
        FocusControl = eCust_Med
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object eCust_Med: TCurrencyEdit
        Left = 456
        Top = 138
        Width = 121
        Height = 21
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 13
      end
      object lFk_Vw_Fornecedores: TStaticText
        Left = 0
        Top = 8
        Width = 155
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' '#218'ltimo Fornecedor:'
        FocusControl = eFk_Vw_Fornecedores
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object eFk_Vw_Fornecedores: TEdit
        Left = 160
        Top = 8
        Width = 417
        Height = 21
        Anchors = [akLeft, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 15
      end
      object lFlag_Rjst: TCheckBox
        Left = 160
        Top = 171
        Width = 225
        Height = 17
        Anchors = [akLeft, akRight]
        Caption = 'Reajuste de Pre'#231'os Autom'#225'tico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnClick = ChangeGlobal
      end
      object lQtd_Dias_Entr: TStaticText
        Left = 0
        Top = 136
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. de dias Transporte:'
        FocusControl = eQtd_Dias_Entr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
      end
      object eQtd_Dias_Entr: TCurrencyEdit
        Left = 160
        Top = 136
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0;- ,0'
        Anchors = [akLeft]
        TabOrder = 18
        OnChange = ChangeGlobal
      end
    end
    object tsDatesAndQtd: TTabSheet
      Caption = 'Informa'#231#245'es dos Estoques'
      ImageIndex = 7
      DesignSize = (
        583
        242)
      object lQtd_EMax: TStaticText
        Left = 0
        Top = 8
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. Estoque M'#225'ximo:'
        FocusControl = eQtd_EMax
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eQtd_EMax: TCurrencyEdit
        Left = 160
        Top = 8
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.00;- ,0.00'
        Anchors = [akLeft, akRight]
        TabOrder = 1
        OnChange = ChangeGlobal
      end
      object lDta_Prv_Entr_Compa: TStaticText
        Left = 296
        Top = 178
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Data Previs'#227'o de Entr.:'
        FocusControl = eDta_Prv_Entr_Compra
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object eDta_Prv_Entr_Compra: TDateEdit
        Left = 456
        Top = 178
        Width = 123
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        TabOrder = 3
        OnChange = ChangeGlobal
      end
      object lQtd_EMin: TStaticText
        Left = 0
        Top = 33
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. Estoque M'#237'nimo:'
        FocusControl = eQtd_EMin
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object eQtd_EMin: TCurrencyEdit
        Left = 160
        Top = 33
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.00;- ,0.00'
        Anchors = [akLeft, akRight]
        TabOrder = 5
        OnChange = ChangeGlobal
      end
      object lDta_UCmp: TStaticText
        Left = 296
        Top = 57
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Data da '#218'ltima Compra:'
        Enabled = False
        FocusControl = eDta_UCmp
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object lDta_UMov: TStaticText
        Left = 296
        Top = 81
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Data da '#218'ltima Venda:'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object lDta_URsrv: TStaticText
        Left = 296
        Top = 105
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Data da '#218'lt. Reserva:'
        Enabled = False
        FocusControl = eDta_URsrv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object eDta_URsrv: TMaskEdit
        Left = 456
        Top = 105
        Width = 123
        Height = 21
        Anchors = [akRight]
        EditMask = '!00/00/0000;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
        Text = '  /  /    '
      end
      object lDta_UInv: TStaticText
        Left = 296
        Top = 129
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Data do '#218'lt. Invent'#225'rio:'
        Enabled = False
        FocusControl = eDta_UInv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object eDta_UInv: TMaskEdit
        Left = 456
        Top = 129
        Width = 123
        Height = 21
        Anchors = [akRight]
        EditMask = '!00/00/0000;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
        Text = '  /  /    '
      end
      object lDta_USld: TStaticText
        Left = 296
        Top = 154
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Data do '#218'lt. Saldo:'
        Enabled = False
        FocusControl = eDta_USld
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object eDta_USld: TMaskEdit
        Left = 456
        Top = 154
        Width = 123
        Height = 21
        Anchors = [akRight]
        EditMask = '!00/00/0000;1; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ReadOnly = True
        TabOrder = 13
        Text = '  /  /    '
      end
      object lQtd_Grnt: TStaticText
        Left = 0
        Top = 130
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. em Garantia:'
        Enabled = False
        FocusControl = eQtd_Grnt
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object eQtd_Grnt: TCurrencyEdit
        Left = 160
        Top = 130
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.00;- ,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 15
      end
      object lQtd_Estq: TStaticText
        Left = 0
        Top = 57
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. de Estoques:'
        Enabled = False
        FocusControl = eQtd_Estq
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
      end
      object eQtd_Estq: TCurrencyEdit
        Left = 160
        Top = 57
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.00;- ,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 17
      end
      object lQtd_Rsrv: TStaticText
        Left = 0
        Top = 81
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. Reservada:'
        Enabled = False
        FocusControl = eQtd_Rsrv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
      end
      object eQtd_Rsrv: TCurrencyEdit
        Left = 160
        Top = 81
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.00;- ,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 19
      end
      object lQtd_Estq_Qr: TStaticText
        Left = 0
        Top = 105
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. em Quarentena:'
        Enabled = False
        FocusControl = eQtd_Estq_Qr
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 20
      end
      object eQtd_Estq_Qr: TCurrencyEdit
        Left = 160
        Top = 105
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.00;- ,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 21
      end
      object eEstq_Dspn: TCurrencyEdit
        Left = 160
        Top = 154
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.00;- ,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 22
      end
      object lEstq_Dspn: TStaticText
        Left = 0
        Top = 154
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. de Estoques Disp.:'
        Enabled = False
        FocusControl = eEstq_Dspn
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 23
      end
      object lQtd_Cns_Med: TStaticText
        Left = 296
        Top = 8
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Cons. M'#233'dio e Tempo:'
        Enabled = False
        FocusControl = eQtd_Cns_Med
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 24
      end
      object eQtd_Cns_Med: TCurrencyEdit
        Left = 456
        Top = 8
        Width = 65
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.0000;- ,0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 25
      end
      object eQtd_Dias_Estq: TCurrencyEdit
        Left = 528
        Top = 8
        Width = 49
        Height = 21
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0;- ,0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 26
      end
      object lQtd_PedF: TStaticText
        Left = 0
        Top = 178
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. de Est. Pedido:'
        Enabled = False
        FocusControl = eQtd_PedF
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 27
      end
      object eQtd_PedF: TCurrencyEdit
        Left = 160
        Top = 178
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.00;- ,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 28
      end
      object lEstq_Prev: TStaticText
        Left = 0
        Top = 203
        Width = 153
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Qtd. de Est. Previsto:'
        Enabled = False
        FocusControl = eEstq_Prev
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 29
      end
      object eEstq_Prev: TCurrencyEdit
        Left = 160
        Top = 203
        Width = 121
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.00;- ,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akLeft, akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 30
      end
      object eDta_UCmp: TDateEdit
        Left = 456
        Top = 58
        Width = 121
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        YearDigits = dyFour
        TabOrder = 31
        OnChange = ChangeGlobal
      end
      object eDta_UMov: TDateEdit
        Left = 456
        Top = 80
        Width = 121
        Height = 21
        Anchors = [akRight]
        NumGlyphs = 2
        YearDigits = dyFour
        TabOrder = 32
        OnChange = ChangeGlobal
      end
      object lQtd_Cmp_Med: TStaticText
        Left = 296
        Top = 32
        Width = 153
        Height = 21
        Anchors = [akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Compra M'#233'dia: '
        Enabled = False
        FocusControl = eQtd_Cmp_Med
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 33
      end
      object eQtd_Cmp_Med: TCurrencyEdit
        Left = 456
        Top = 32
        Width = 65
        Height = 21
        AutoSize = False
        DecimalPlaces = 4
        DisplayFormat = ',0.0000;- ,0.0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Anchors = [akRight]
        ParentFont = False
        ReadOnly = True
        TabOrder = 34
      end
    end
    object tsHistoric: TTabSheet
      Caption = 'Hist'#243'ricos das Movimenta'#231#245'es'
      ImageIndex = 19
      object pgHistorics: TPageControl
        Left = 0
        Top = 57
        Width = 583
        Height = 185
        ActivePage = tsCosts
        Align = alClient
        TabOrder = 0
        TabPosition = tpBottom
        OnChange = pgHistoricsChange
        object tsCosts: TTabSheet
          Caption = 'Custos'
          ImageIndex = 39
          object vtCostHist: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 575
            Height = 159
            Align = alClient
            CheckImageKind = ckXP
            Header.AutoSizeIndex = -1
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoDrag, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            HintAnimation = hatNone
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
            TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toFullRowSelect]
            OnGetText = vtCostHistGetText
            Columns = <
              item
                ImageIndex = 15
                Position = 0
                Width = 135
                WideText = 'Data e Hora'
              end
              item
                ImageIndex = 82
                Position = 1
                Width = 150
                WideText = 'Fronecedor'
              end
              item
                Alignment = taRightJustify
                ImageIndex = 39
                Position = 2
                Width = 90
                WideText = 'Custo Forn.'
              end
              item
                Alignment = taRightJustify
                ImageIndex = 39
                Position = 3
                Width = 90
                WideText = 'Custo Real'
              end
              item
                Alignment = taRightJustify
                ImageIndex = 39
                Position = 4
                Width = 90
                WideText = 'Custo M'#233'dio'
              end
              item
                Alignment = taRightJustify
                ImageIndex = 39
                Position = 5
                Width = 70
                WideText = 'CustoFinal'
              end>
          end
        end
        object tsStoks: TTabSheet
          Caption = 'Estoques'
          ImageIndex = 26
          object vtHistorics: TVirtualStringTree
            Left = 0
            Top = 0
            Width = 575
            Height = 159
            Align = alClient
            Header.AutoSizeIndex = 0
            Header.Font.Charset = DEFAULT_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -11
            Header.Font.Name = 'MS Sans Serif'
            Header.Font.Style = []
            Header.Options = [hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
            Header.Style = hsXPStyle
            SelectionCurveRadius = 10
            TabOrder = 0
            TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick]
            TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowVertGridLines, toThemeAware, toUseBlendedImages]
            TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect]
            OnBeforeItemErase = vtHistoricsBeforeItemErase
            OnGetText = vtHistoricsGetText
            Columns = <
              item
                Position = 0
                Width = 135
                WideText = 'Data/Hora'
              end
              item
                Alignment = taRightJustify
                Position = 1
                Width = 90
                WideText = 'Entrada'
              end
              item
                Alignment = taRightJustify
                Position = 2
                Width = 90
                WideText = 'Sa'#237'da'
              end
              item
                Alignment = taRightJustify
                Position = 3
                Width = 90
                WideText = 'Saldo'
              end
              item
                Alignment = taRightJustify
                Position = 4
                Width = 70
                WideText = 'N'#250'm. Doc.'
              end
              item
                Position = 5
                Width = 200
                WideText = 'Cadastro'
              end
              item
                Position = 6
                Width = 150
                WideText = 'Tipo Movim.'
              end
              item
                Position = 7
                Width = 150
                WideText = 'Tipo Docum.'
              end>
          end
        end
      end
      object pHist: TPanel
        Left = 0
        Top = 0
        Width = 583
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        DesignSize = (
          583
          57)
        object lInitialFilter: TStaticText
          Left = 0
          Top = 8
          Width = 81
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = ' Data Inicial:'
          FocusControl = eInitialFilter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object eInitialFilter: TDateEdit
          Left = 88
          Top = 8
          Width = 121
          Height = 21
          Anchors = [akLeft]
          NumGlyphs = 2
          YearDigits = dyFour
          TabOrder = 1
          OnChange = FilterChange
        end
        object eFinalFilter: TDateEdit
          Left = 88
          Top = 32
          Width = 121
          Height = 21
          Anchors = [akLeft]
          NumGlyphs = 2
          YearDigits = dyFour
          TabOrder = 2
          OnChange = FilterChange
        end
        object lFinalFilter: TStaticText
          Left = 0
          Top = 32
          Width = 81
          Height = 21
          Anchors = [akLeft]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = ' Data Final:'
          FocusControl = eFinalFilter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object gbLegend: TGroupBox
          Left = 320
          Top = 0
          Width = 257
          Height = 57
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Legenda'
          TabOrder = 4
          Visible = False
          DesignSize = (
            257
            57)
          object shInPut: TShape
            Left = 8
            Top = 16
            Width = 17
            Height = 33
            Anchors = [akLeft, akTop, akBottom]
            Brush.Color = clInfoBk
          end
          object shOutput: TShape
            Left = 72
            Top = 16
            Width = 17
            Height = 33
            Anchors = [akLeft, akTop, akBottom]
            Brush.Color = clMoneyGreen
          end
          object shTransfer: TShape
            Left = 128
            Top = 16
            Width = 17
            Height = 33
            Anchors = [akTop, akRight, akBottom]
            Brush.Color = 16776176
          end
          object lEntrada: TLabel
            Left = 26
            Top = 27
            Width = 42
            Height = 13
            Anchors = [akLeft]
            Caption = 'Entradas'
          end
          object Label1: TLabel
            Left = 90
            Top = 27
            Width = 34
            Height = 13
            Anchors = [akLeft]
            Caption = 'Sa'#237'das'
          end
          object shAdjust: TShape
            Left = 184
            Top = 16
            Width = 17
            Height = 33
            Anchors = [akTop, akRight, akBottom]
            Brush.Color = clYellow
          end
          object lTransfer: TLabel
            Left = 146
            Top = 27
            Width = 33
            Height = 13
            Anchors = [akRight]
            Caption = 'Transf.'
          end
          object lAdjust: TLabel
            Left = 210
            Top = 27
            Width = 34
            Height = 13
            Anchors = [akRight]
            Caption = 'Ajustes'
          end
        end
      end
    end
  end
end
