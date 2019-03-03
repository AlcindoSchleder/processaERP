inherited frmMultiModel: TfrmMultiModel
  Width = 800
  Height = 550
  Caption = 'frmMultiModel'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Left = 297
    Height = 470
  end
  inherited cbTools: TCoolBar
    Width = 792
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 788
      end>
    inherited tbTools: TToolBar
      Width = 711
    end
  end
  inherited sbStatus: TStatusBar
    Top = 503
    Width = 792
  end
  inherited vtList: TVirtualStringTree
    Width = 297
    Height = 470
    Columns = <
      item
        Position = 0
        Width = 293
        WideText = 'Descri'#231#227'o'
      end>
  end
  inherited pMain: TPanel
    Left = 302
    Width = 490
    Height = 470
    object pgMain: TPageControl
      Left = 0
      Top = 0
      Width = 490
      Height = 470
      Align = alClient
      TabOrder = 0
    end
  end
end
