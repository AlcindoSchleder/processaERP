inherited CdAlmoxarifados: TCdAlmoxarifados
  Caption = 'CdAlmoxarifados'
  PixelsPerInch = 96
  TextHeight = 13
  inherited vtList: TVirtualStringTree
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    OnPaintText = vtListPaintText
  end
  inherited pMain: TPanel
    inherited pgMain: TPageControl
      ActivePage = tsRoot
      object tsLocation: TTabSheet
        ImageIndex = 1
        TabVisible = False
      end
      object tsRoot: TTabSheet
        Caption = 'tsRoot'
        TabVisible = False
      end
    end
  end
end
