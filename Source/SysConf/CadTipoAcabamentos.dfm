inherited CdTipoAcabamentos: TCdTipoAcabamentos
  Left = 225
  Top = 183
  Width = 726
  Height = 420
  Caption = 'CdTipoAcabamentos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Left = 261
    Height = 340
  end
  inherited cbTools: TCoolBar
    Width = 718
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 714
      end>
    inherited tbTools: TToolBar
      Width = 637
    end
  end
  inherited sbStatus: TStatusBar
    Top = 373
    Width = 718
  end
  inherited vtList: TVirtualStringTree
    Width = 261
    Height = 340
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    Columns = <
      item
        Position = 0
        Width = 257
        WideText = 'Descri'#231#227'o'
      end>
  end
  inherited pMain: TPanel
    Left = 266
    Width = 452
    Height = 340
    inherited pgMain: TPageControl
      Width = 452
      Height = 340
    end
  end
end
