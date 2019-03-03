inherited CdPedMsg: TCdPedMsg
  Left = 203
  Top = 188
  Caption = 'CdPedMsg'
  ClientHeight = 95
  ClientWidth = 770
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pgMessages: TPageControl
    Left = 0
    Top = 0
    Width = 770
    Height = 95
    ActivePage = tsList
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object tsData: TTabSheet
      Caption = 'tsData'
      TabVisible = False
      DesignSize = (
        762
        85)
      object lFk_Departamentos: TStaticText
        Left = 8
        Top = 32
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Departamento: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object eFk_Departamentos: TPrcComboBox
        Left = 168
        Top = 32
        Width = 234
        Height = 21
        Anchors = [akLeft]
        BevelKind = bkNone
        CompareMethod = 'ComparePk'
        GetPkMethod = 'GetPkValue'
        ItemHeight = 0
        OnSelect = ChangeGlobal
        Style = csDropDownList
        TabOrder = 1
      end
      object eText_Msg: TMemo
        Left = 416
        Top = 32
        Width = 345
        Height = 53
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 2
        OnChange = ChangeGlobal
      end
      object eHor_Msg: TDateTimePicker
        Left = 288
        Top = 56
        Width = 113
        Height = 21
        Anchors = [akLeft]
        Date = 38635.594364178250000000
        Time = 38635.594364178250000000
        Kind = dtkTime
        TabOrder = 3
        OnChange = ChangeGlobal
      end
      object eDta_Msg: TDateTimePicker
        Left = 168
        Top = 56
        Width = 105
        Height = 21
        Anchors = [akLeft]
        Date = 38635.594364178250000000
        Time = 38635.594364178250000000
        TabOrder = 4
        OnChange = ChangeGlobal
      end
      object lDtHr_Msg: TStaticText
        Left = 8
        Top = 56
        Width = 153
        Height = 21
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Data e Hora: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object cbMessage: TCoolBar
        Left = 0
        Top = 0
        Width = 762
        Height = 25
        Bands = <
          item
            Control = tbTools
            ImageIndex = 83
            MinHeight = 21
            Text = 'Sele'#231#227'o de '#205'tens'
            Width = 429
          end
          item
            Break = False
            Control = tbNavigation
            ImageIndex = 31
            MinHeight = 21
            Text = 'Navega'#231#227'o'
            Width = 327
          end>
        object tbTools: TToolBar
          Left = 95
          Top = 0
          Width = 330
          Height = 21
          ButtonHeight = 20
          ButtonWidth = 20
          Caption = 'tbTools'
          Flat = True
          TabOrder = 0
          object tbInsert: TToolButton
            Left = 0
            Top = 0
            Caption = 'tbInsert'
            ImageIndex = 34
            OnClick = tbInsertClick
          end
          object tbCancel: TToolButton
            Left = 20
            Top = 0
            Caption = 'tbCancel'
            Enabled = False
            ImageIndex = 28
            OnClick = tbCancelClick
          end
          object tbDelete: TToolButton
            Left = 40
            Top = 0
            Caption = 'tbDelete'
            ImageIndex = 33
            OnClick = tbDeleteClick
          end
          object tbToolSep: TToolButton
            Left = 60
            Top = 0
            Width = 8
            Caption = 'tbToolSep'
            ImageIndex = 3
            Style = tbsSeparator
          end
          object tbSave: TToolButton
            Left = 68
            Top = 0
            Enabled = False
            ImageIndex = 36
            OnClick = tbSaveClick
          end
        end
        object tbNavigation: TToolBar
          Left = 502
          Top = 0
          Width = 252
          Height = 21
          ButtonHeight = 29
          ButtonWidth = 20
          Caption = 'tbNavigation'
          Flat = True
          TabOrder = 1
          object tbPrior: TToolButton
            Left = 0
            Top = 0
            Caption = 'tbPrior'
            ImageIndex = 30
            OnClick = tbPriorClick
          end
          object ToolButton1: TToolButton
            Left = 0
            Top = 0
            Width = 8
            Caption = 'ToolButton1'
            ImageIndex = 33
            Wrap = True
            Style = tbsSeparator
          end
          object tbNext: TToolButton
            Left = 0
            Top = 37
            Caption = 'tbNext'
            ImageIndex = 32
            OnClick = tbNextClick
          end
          object eDtHr_Rcbm: TEdit
            Left = 20
            Top = 37
            Width = 233
            Height = 29
            ReadOnly = True
            TabOrder = 0
          end
        end
      end
    end
    object tsList: TTabSheet
      Caption = 'tsList'
      ImageIndex = 1
      TabVisible = False
      object vtMessages: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 762
        Height = 85
        Align = alClient
        EditDelay = 0
        Header.AutoSizeIndex = 3
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'MS Sans Serif'
        Header.Font.Style = []
        Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowImages, hoVisible]
        Header.Style = hsXPStyle
        HintAnimation = hatNone
        TabOrder = 0
        TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toExtendedFocus, toMiddleClickSelect, toRightClickSelect]
        WantTabs = True
        OnDblClick = vtMessagesDblClick
        OnGetText = vtMessagesGetText
        Columns = <
          item
            ImageIndex = 19
            Position = 0
            Width = 150
            WideText = 'Departamento'
          end
          item
            ImageIndex = 21
            Position = 1
            Width = 120
            WideText = 'Data e Hora'
          end
          item
            ImageIndex = 21
            Position = 2
            Width = 120
            WideText = 'Recebida em:'
          end
          item
            ImageIndex = 47
            Position = 3
            Width = 368
            WideText = 'Mensagem'
          end>
      end
    end
  end
end
