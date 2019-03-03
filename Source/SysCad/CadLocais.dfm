inherited CdLocales: TCdLocales
  Left = 232
  Top = 185
  Width = 788
  Height = 536
  Caption = 'CdLocales'
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Top = 41
    Height = 448
  end
  inherited cbTools: TCoolBar
    Width = 780
    Height = 41
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        MinHeight = 33
        Text = 'Ferramentas'
        Width = 776
      end>
    inherited tbTools: TToolBar
      Width = 699
      Height = 33
      ButtonWidth = 65
      inherited tbInsert: TToolButton
        Hint = ''
        Caption = 'Inserir Pa'#237's'
        DropdownMenu = pmMenu
        ImageIndex = -1
        MenuItem = pmCountry
        Style = tbsDropDown
      end
      inherited tbCancel: TToolButton
        Left = 78
      end
      inherited tbDelete: TToolButton
        Left = 143
      end
      inherited tbSepSave: TToolButton
        Left = 208
      end
      inherited tbSave: TToolButton
        Left = 216
      end
      inherited tbSepClose: TToolButton
        Left = 281
      end
      inherited tbClose: TToolButton
        Left = 289
      end
    end
  end
  inherited sbStatus: TStatusBar
    Top = 489
    Width = 780
  end
  inherited vtList: TVirtualStringTree
    Top = 41
    Height = 448
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    OnGetImageIndex = vtListGetImageIndex
  end
  inherited pMain: TPanel
    Top = 41
    Width = 478
    Height = 448
    inherited pgMain: TPageControl
      Width = 478
      Height = 448
    end
  end
  object pmMenu: TPopupMenu
    Left = 400
    Top = 135
    object pmCountry: TMenuItem
      Caption = 'Inserir Pa'#237's'
      OnClick = pmInsertGeneral
    end
    object pmState: TMenuItem
      Tag = 1
      Caption = 'Inserir Estado'
      Visible = False
      OnClick = pmInsertGeneral
    end
    object pmCity: TMenuItem
      Tag = 2
      Caption = 'Inserir Cidade'
      Visible = False
      OnClick = pmInsertGeneral
    end
    object pmDistrict: TMenuItem
      Tag = 3
      Caption = 'Inserir Bairro'
      Visible = False
      OnClick = pmInsertGeneral
    end
    object pmAddress: TMenuItem
      Tag = 4
      Caption = 'Inserir Logradouro'
      Visible = False
      OnClick = pmInsertGeneral
    end
  end
end
