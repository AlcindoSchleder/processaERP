inherited CdTablesMoviment: TCdTablesMoviment
  Left = 170
  Top = 127
  Caption = 'CdTablesMoviment'
  PixelsPerInch = 96
  TextHeight = 13
  inherited spSplitter: TSplitter
    Left = 229
  end
  inherited vtList: TVirtualStringTree
    Width = 229
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
    Columns = <
      item
        Position = 0
        Width = 225
        WideText = 'Descri'#231#227'o'
      end>
    WideDefaultText = ''
  end
  inherited pMain: TPanel
    Left = 234
    Width = 558
    inherited pgMain: TPageControl
      Width = 558
    end
  end
end
