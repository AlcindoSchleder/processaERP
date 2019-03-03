inherited fmProductCode: TfmProductCode
  Caption = 'fmProductCode'
  ClientHeight = 277
  ClientWidth = 198
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgCodes: TPageControl
    Left = 0
    Top = 0
    Width = 198
    Height = 277
    ActivePage = tsReferenceList
    Align = alClient
    TabOrder = 0
    OnChanging = pgCodesChanging
    object tsReferenceEdit: TTabSheet
      Caption = 'Detalhes'
      ImageIndex = 4
      DesignSize = (
        190
        249)
      object sbNewRef: TSpeedButton
        Left = 162
        Top = 79
        Width = 21
        Height = 22
        Anchors = [akRight]
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0005710A00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0005710A0005710A00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0005710A0076F9A70005710A000571
          0A0005710A0005710A0005710A0005710A00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0005710A0076F9A70076F9A7006FF39E005BE3
          830042CE610028B93F0014A8240005710A00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0005710A0076F9A70005710A000571
          0A0005710A0005710A0005710A0005710A00FF00FF00FF00FF00FF00FF001C78
          D5001C78D5001C78D5001C78D5001C599600FF00FF0005710A0005710A00FF00
          FF00FF00FF00E4F0FC001C78D5001C78D5001C78D5001C78D5001C78D50082C6
          F90057BCFF004EB5FF004DB4FF001C599600FF00FF00FF00FF0005710A00FF00
          FF00FF00FF00E4F0FC002A95FF00369BFF00379CFF001C78D5001C78D5007DC3
          F70056BCFF004EB4FE004DB3FF001C599600FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00E4F0FC002893FF003499FF00359AFF001C78D5001C78D50080C6
          F9005BC1FF0053BAFF0052B8FF001C599600FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00E4F0FC001F8EFF002B95FF002C96FF001C78D5001C78D50080C6
          F9005BC1FF0053BAFF0052B8FF001C599600FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00E4F0FC00E4F0FC00E4F0FC00E4F0FC00E4F0FC001C78D500629D
          CF003589CF003589CF003589CF001C5996001C5996001C5996001C5996001C59
          96001C599600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001C78D50086CC
          F90065CBFF005DC3FF005CC4FF003589CF0053BAFF0053BAFF004EB4FF004DB4
          FF001C78D500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001C78D50084C9
          F70065CAFF005EC3FE005EC4FF003589CF0053BAFF0054BAFF004FB4FE004FB4
          FF001C78D500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001C78D50085CB
          F80064CBFF005EC6FF005EC7FF003589CF0053BAFF0055BDFF0050B7FF0050B7
          FF001C78D500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001C78D5009ECF
          F50092D7FD0088D2FC008CD5FD00629DCF0085CEFD0085CEFD0080C9FC0084CB
          FD001C78D500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001C78
          D5001C78D5001C78D5001C78D5001C78D5001C78D5001C78D5001C78D5001C78
          D500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        OnClick = sbNewRefClick
      end
      object lCod_Ref: TStaticText
        Left = 0
        Top = 80
        Width = 161
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' C'#243'digo:'
        FocusControl = eCod_Ref
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object lFlagTCode: TStaticText
        Left = 0
        Top = 48
        Width = 89
        Height = 21
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Tipo C'#243'digo:'
        FocusControl = eFlagTCode
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object eFlagTCode: TComboBox
        Left = 96
        Top = 48
        Width = 89
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Refer'#234'ncia'
        OnSelect = eFlagTCodeSelect
        Items.Strings = (
          'Refer'#234'ncia'
          'C'#243'digo'
          'Barras'
          'Fornecedor')
      end
      object eCod_Ref: TEdit
        Left = 0
        Top = 104
        Width = 185
        Height = 21
        Anchors = [akLeft, akRight]
        CharCase = ecUpperCase
        MaxLength = 30
        TabOrder = 1
        OnChange = ChangeGlobal
      end
      object lFlagTBarCode: TStaticText
        Left = 0
        Top = 192
        Width = 185
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Tipo de C'#243'digo de Barras:'
        Enabled = False
        FocusControl = eFlagTBarCode
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object eFlagTBarCode: TComboBox
        Left = 0
        Top = 216
        Width = 185
        Height = 21
        Style = csDropDownList
        Anchors = [akLeft, akRight]
        Enabled = False
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = 'Nenhum'
        OnSelect = ChangeGlobal
        Items.Strings = (
          'Nenhum'
          'Ean 13'
          'Ean 8'
          'Code 39'
          'UPC'
          'Interleave')
      end
      object StaticText1: TStaticText
        Left = 0
        Top = 8
        Width = 185
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'C'#243'digos do Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object lDsc_Code: TStaticText
        Left = 0
        Top = 136
        Width = 185
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akRight]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Descri'#231#227'o:'
        FocusControl = eDsc_Code
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object eDsc_Code: TEdit
        Left = 0
        Top = 160
        Width = 185
        Height = 21
        Anchors = [akLeft, akRight]
        MaxLength = 30
        TabOrder = 2
        OnChange = ChangeGlobal
      end
    end
    object tsReferenceList: TTabSheet
      Caption = 'Listagem'
      object vtCodes: TVirtualStringTree
        Left = 0
        Top = 33
        Width = 190
        Height = 216
        Align = alClient
        CheckImageKind = ckXP
        Header.AutoSizeIndex = 1
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoDrag, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        SelectionCurveRadius = 10
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        OnDblClick = vtCodesDblClick
        OnFocusChanged = vtCodesFocusChanged
        OnGetText = vtCodesGetText
        Columns = <
          item
            ImageIndex = 52
            Position = 0
            Width = 100
            WideText = 'Refer'#234'ncia'
          end
          item
            ImageIndex = 47
            Position = 1
            Width = 86
            WideText = 'Tipo'
          end>
      end
      object cbTools: TCoolBar
        Left = 0
        Top = 0
        Width = 190
        Height = 33
        Bands = <
          item
            Control = tbTools
            ImageIndex = -1
            Width = 186
          end>
        object tbTools: TToolBar
          Left = 9
          Top = 0
          Width = 173
          Height = 25
          ButtonHeight = 19
          ButtonWidth = 43
          Caption = 'tbTools'
          Flat = True
          List = True
          ShowCaptions = True
          TabOrder = 0
          object tbInsert: TToolButton
            Left = 0
            Top = 0
            Caption = 'Novo'
            ImageIndex = 43
            OnClick = tbInsertClick
          end
          object tbSep: TToolButton
            Left = 43
            Top = 0
            Width = 8
            Caption = 'tbSep'
            ImageIndex = 2
            Style = tbsSeparator
          end
          object tbDelete: TToolButton
            Left = 51
            Top = 0
            Caption = 'Excluir'
            ImageIndex = 33
            OnClick = tbDeleteClick
          end
        end
      end
    end
  end
end
