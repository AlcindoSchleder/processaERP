inherited CdTypeAccounts: TCdTypeAccounts
  Left = 150
  Top = 108
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = 'CdTypeAccounts'
  ClientHeight = 503
  ClientWidth = 784
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Height = 451
  end
  inherited cbTools: TCoolBar
    Width = 784
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 780
      end>
    inherited tbTools: TToolBar
      Width = 703
    end
  end
  inherited sbStatus: TStatusBar
    Top = 484
    Width = 784
  end
  inherited vtList: TVirtualStringTree
    Height = 451
  end
  inherited pMain: TPanel
    Width = 482
    Height = 451
    inherited pgMain: TPageControl
      Width = 482
      Height = 451
    end
  end
end
