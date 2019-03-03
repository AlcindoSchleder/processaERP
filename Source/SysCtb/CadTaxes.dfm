inherited CdTaxes: TCdTaxes
  Left = 226
  Top = 156
  Width = 666
  Height = 519
  Caption = 'CdTaxes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Left = 251
    Top = 41
    Height = 431
  end
  inherited cbTools: TCoolBar
    Width = 658
    Height = 41
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        MinHeight = 33
        Text = 'Ferramentas'
        Width = 654
      end>
    inherited tbTools: TToolBar
      Width = 577
      Height = 33
      ButtonWidth = 84
      inherited tbInsert: TToolButton
        Hint = ''
        Caption = 'Novo &Imposto'
        DropdownMenu = pmMenu
        ImageIndex = 86
        MenuItem = pmNewTypeTax
        Style = tbsDropDown
      end
      inherited tbCancel: TToolButton
        Left = 97
      end
      inherited tbDelete: TToolButton
        Left = 181
      end
      inherited tbSepSave: TToolButton
        Left = 265
      end
      inherited tbSave: TToolButton
        Left = 273
      end
      inherited tbSepClose: TToolButton
        Left = 357
      end
      inherited tbClose: TToolButton
        Left = 365
      end
    end
  end
  inherited sbStatus: TStatusBar
    Top = 472
    Width = 658
  end
  inherited vtList: TVirtualStringTree
    Top = 41
    Width = 251
    Height = 431
    PopupMenu = pmMenu
    OnBeforeItemErase = vtListBeforeItemErase
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    Columns = <
      item
        Position = 0
        Width = 247
        WideText = 'Impostos'
      end>
  end
  inherited pMain: TPanel
    Left = 256
    Top = 41
    Width = 402
    Height = 431
    inherited pgMain: TPageControl
      Width = 402
      Height = 431
    end
  end
  object pmMenu: TPopupMenu
    Left = 88
    Top = 80
    object pmNewTypeTax: TMenuItem
      Caption = 'Novo &Imposto'
      ImageIndex = 86
      OnClick = pmNewClick
    end
    object pmNewTax: TMenuItem
      Tag = 1
      Caption = 'Nova &Al'#237'quota'
      ImageIndex = 19
      OnClick = pmNewClick
    end
    object pmNewTaxPrinter: TMenuItem
      Tag = 2
      Caption = 'Impr. &Fiscal'
      ImageIndex = 6
      OnClick = pmNewClick
    end
  end
end
