inherited CdOperador: TCdOperador
  Width = 559
  Height = 407
  Caption = 'CdOperador'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lTitle: TLabel
    Width = 551
  end
  inherited sbStatus: TStatusBar
    Top = 334
    Width = 551
  end
  inherited pgControl: TPageControl
    Width = 551
    Height = 277
    inherited tsList: TTabSheet
      inherited vtGrid: TVirtualStringTree
        WideDefaultText = 'vtGrid'
      end
    end
  end
  inherited cbTools: TCoolBar
    Width = 551
    Bands = <
      item
        Break = False
        Control = tbNavigation
        ImageIndex = 82
        Width = 136
      end
      item
        Break = False
        Control = tbOperations
        HorizontalOnly = True
        ImageIndex = 91
        Text = 'Ferramentas'
        Width = 409
      end>
    inherited tbOperations: TToolBar
      Width = 332
    end
  end
end
