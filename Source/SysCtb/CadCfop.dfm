inherited CdCfops: TCdCfops
  Left = 212
  Top = 104
  Width = 760
  Height = 549
  Caption = 'CdCfops'
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Left = 345
    Height = 469
  end
  inherited cbTools: TCoolBar
    Width = 752
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 748
      end>
    inherited tbTools: TToolBar
      Width = 671
    end
  end
  inherited sbStatus: TStatusBar
    Top = 502
    Width = 752
  end
  inherited vtList: TVirtualStringTree
    Width = 345
    Height = 469
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    Columns = <
      item
        Position = 0
        Width = 341
        WideText = 'Descri'#231#227'o'
      end>
  end
  inherited pMain: TPanel
    Left = 350
    Width = 402
    Height = 469
    inherited pgMain: TPageControl
      Width = 402
      Height = 469
    end
  end
end
