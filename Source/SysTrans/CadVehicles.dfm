inherited CdVehicles: TCdVehicles
  Left = 374
  Top = 114
  Width = 799
  Height = 488
  Caption = 'CdVehicles'
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Left = 325
    Top = 41
    Height = 400
  end
  inherited cbTools: TCoolBar
    Width = 791
    Height = 41
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        MinHeight = 33
        Text = 'Ferramentas'
        Width = 787
      end>
    inherited tbTools: TToolBar
      Width = 710
      Height = 33
      ButtonWidth = 78
      inherited tbInsert: TToolButton
        Hint = ''
        Caption = 'Inserir Marcas'
        DropdownMenu = pmMenu
        ImageIndex = 11
        MenuItem = pmMark
        Style = tbsDropDown
      end
      inherited tbCancel: TToolButton
        Left = 91
      end
      inherited tbDelete: TToolButton
        Left = 169
      end
      inherited tbSepSave: TToolButton
        Left = 247
      end
      inherited tbSave: TToolButton
        Left = 255
      end
      inherited tbSepClose: TToolButton
        Left = 333
      end
      inherited tbClose: TToolButton
        Left = 341
      end
    end
  end
  inherited sbStatus: TStatusBar
    Top = 441
    Width = 791
  end
  inherited vtList: TVirtualStringTree
    Top = 41
    Width = 325
    Height = 400
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    Columns = <
      item
        Position = 0
        Width = 321
        WideText = 'Descri'#231#227'o'
      end>
  end
  inherited pMain: TPanel
    Left = 330
    Top = 41
    Width = 461
    Height = 400
    inherited pgMain: TPageControl
      Width = 461
      Height = 400
      object tsModels: TTabSheet
        Caption = 'tsModels'
        ImageIndex = 1
        TabVisible = False
      end
      object tsVehicles: TTabSheet
        Caption = 'tsVehicles'
        ImageIndex = 2
        TabVisible = False
      end
    end
  end
  object pmMenu: TPopupMenu
    Left = 400
    Top = 135
    object pmMark: TMenuItem
      Caption = 'Inserir Marcas'
      ImageIndex = 11
      OnClick = pmInsertGeneralClick
    end
    object pmModel: TMenuItem
      Tag = 1
      Caption = 'Inserir Modelos'
      ImageIndex = 16
      Visible = False
      OnClick = pmInsertGeneralClick
    end
    object pmVehicle: TMenuItem
      Tag = 2
      Caption = 'Inserir Ve'#237'culos'
      ImageIndex = 61
      Visible = False
      OnClick = pmInsertGeneralClick
    end
  end
end
