inherited CdTabelaPrecos: TCdTabelaPrecos
  Left = 224
  Top = 135
  Height = 594
  Caption = 'CdTabelaPrecos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Left = 263
    Top = 41
    Height = 506
  end
  inherited cbTools: TCoolBar
    Height = 41
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        MinHeight = 33
        Text = 'Ferramentas'
        Width = 788
      end>
    inherited tbTools: TToolBar
      Height = 33
      inherited tbInsert: TToolButton
        Hint = ''
        DropdownMenu = pmInsert
        Style = tbsDropDown
      end
      inherited tbCancel: TToolButton
        Left = 67
      end
      inherited tbDelete: TToolButton
        Left = 121
      end
      inherited tbSepSave: TToolButton
        Left = 175
      end
      inherited tbSave: TToolButton
        Left = 183
      end
      inherited tbSepClose: TToolButton
        Left = 237
      end
      inherited tbClose: TToolButton
        Left = 245
      end
    end
  end
  inherited sbStatus: TStatusBar
    Top = 547
  end
  inherited vtList: TVirtualStringTree
    Top = 41
    Width = 263
    Height = 506
    PopupMenu = pmInsert
    OnChecked = vtListChecked
    OnChecking = vtListChecking
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    Columns = <
      item
        Position = 0
        Width = 259
        WideText = 'Descri'#231#227'o'
      end>
  end
  inherited pMain: TPanel
    Left = 268
    Top = 41
    Width = 524
    Height = 506
    inherited pgMain: TPageControl
      Width = 524
      Height = 506
      ActivePage = tsRoot
      object tsRegionsMatrix: TTabSheet
        ImageIndex = 38
        TabVisible = False
      end
      object tsRoot: TTabSheet
        Caption = 'tsRoot'
        TabVisible = False
      end
    end
  end
  object pmInsert: TPopupMenu
    Left = 308
    Top = 71
    object pmInsPriceTable: TMenuItem
      Caption = 'Tabela de Pre'#231'os'
      OnClick = tbInsertClick
    end
    object pmInsCalcRegion: TMenuItem
      Tag = 1
      Caption = 'Regi'#245'es de C'#225'lculo'
      OnClick = tbInsertClick
    end
  end
end
