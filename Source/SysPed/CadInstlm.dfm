object CdInstallments: TCdInstallments
  Left = 332
  Top = 160
  Width = 259
  Height = 123
  Caption = 'CdInstallments'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgPayments: TPageControl
    Left = 0
    Top = 0
    Width = 251
    Height = 95
    ActivePage = tsList
    Align = alClient
    MultiLine = True
    TabOrder = 0
    TabPosition = tpLeft
    OnChange = pgPaymentsChange
    OnChanging = pgPaymentsChanging
    object tsList: TTabSheet
      Caption = 'Lista'
      object vtPayments: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 224
        Height = 87
        Align = alClient
        CheckImageKind = ckXP
        Ctl3D = False
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoDrag, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        ParentCtl3D = False
        PopupMenu = pmInstallments
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnFocusChanged = vtPaymentsFocusChanged
        OnGetText = vtPaymentsGetText
        OnPaintText = vtPaymentsPaintText
        Columns = <
          item
            ImageIndex = 75
            Position = 0
            Width = 100
            WideText = 'Data Venc.'
          end
          item
            Alignment = taRightJustify
            ImageIndex = 39
            Position = 1
            Width = 100
            WideText = 'Valor'
          end>
      end
    end
    object tsData: TTabSheet
      Caption = 'Datas'
      ImageIndex = 1
      object lDtaVenc: TStaticText
        Left = 8
        Top = 32
        Width = 85
        Height = 20
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Data:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eDtaVenc: TDateEdit
        Left = 104
        Top = 32
        Width = 89
        Height = 21
        BevelKind = bkFlat
        BorderStyle = bsNone
        NumGlyphs = 2
        TabOrder = 1
      end
      object lVlrParc: TStaticText
        Left = 8
        Top = 56
        Width = 85
        Height = 20
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object eVlrParc: TCurrencyEdit
        Left = 104
        Top = 56
        Width = 90
        Height = 21
        AutoSize = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Enabled = False
        TabOrder = 3
      end
      object stTitle: TStaticText
        Left = 0
        Top = 0
        Width = 224
        Height = 21
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        BorderStyle = sbsSunken
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
  end
  object pmInstallments: TPopupMenu
    Left = 127
    Top = 5
    object pmInsert: TMenuItem
      Caption = '&Inserir Parcela'
      OnClick = pmInsertClick
    end
    object ExcluirParcel1: TMenuItem
      Caption = '&Excluir Parcela'
      OnClick = ExcluirParcel1Click
    end
  end
end
