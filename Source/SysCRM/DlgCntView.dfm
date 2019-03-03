inherited frmContactView: TfrmContactView
  Caption = 'frmContactView'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgMain: TPageControl
    inherited tsVisual: TTabSheet
      object vpContactGrid: TVpContactGrid
        Left = 0
        Top = 0
        Width = 321
        Height = 457
        Color = clWindow
        Ctl3D = False
        Align = alClient
        TabStop = True
        TabOrder = 0
        AllowInPlaceEditing = False
        BarWidth = 3
        BarColor = clBlue
        ColumnWidth = 300
        ContactHeadAttributes.Color = clSilver
        ContactHeadAttributes.Font.Charset = DEFAULT_CHARSET
        ContactHeadAttributes.Font.Color = clWindowText
        ContactHeadAttributes.Font.Height = -11
        ContactHeadAttributes.Font.Name = 'MS Sans Serif'
        ContactHeadAttributes.Font.Style = []
        ContactHeadAttributes.Bordered = True
        DrawingStyle = dsFlat
        SortBy = csFirstLast
        OnOwnerEditContact = vpContactGridOwnerEditContact
      end
      object cbbContacts: TVpContactButtonBar
        Left = 321
        Top = 0
        Width = 40
        Height = 457
        ButtonColor = 16776176
        ContactGrid = vpContactGrid
        DrawingStyle = dsFlat
        RadioStyle = False
        Align = alRight
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
    end
  end
end
