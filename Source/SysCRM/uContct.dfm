object frmContact: TfrmContact
  Left = 445
  Top = 120
  BorderStyle = bsNone
  Caption = 'frmContact'
  ClientHeight = 467
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pManContact: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clInfoBk
    TabOrder = 0
  end
  object vpContactGrid: TVpContactGrid
    Left = 0
    Top = 41
    Width = 329
    Height = 426
    Color = clWindow
    Align = alClient
    TabStop = True
    TabOrder = 1
    AllowInPlaceEditing = True
    BarWidth = 3
    BarColor = clSilver
    ColumnWidth = 145
    ContactHeadAttributes.Color = clSilver
    ContactHeadAttributes.Font.Charset = DEFAULT_CHARSET
    ContactHeadAttributes.Font.Color = clWindowText
    ContactHeadAttributes.Font.Height = -11
    ContactHeadAttributes.Font.Name = 'MS Sans Serif'
    ContactHeadAttributes.Font.Style = []
    ContactHeadAttributes.Bordered = True
    DrawingStyle = dsFlat
    SortBy = csFirstLast
  end
  object cbbContacts: TVpContactButtonBar
    Left = 329
    Top = 41
    Width = 40
    Height = 426
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
