inherited CdSitTrib: TCdSitTrib
  Caption = 'CdSitTrib'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object sTitle: TShape [0]
    Left = 248
    Top = 40
    Width = 401
    Height = 25
    Anchors = [akLeft, akTop, akRight]
  end
  object lTitle: TLabel [1]
    Left = 254
    Top = 45
    Width = 387
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lTitle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited vtList: TVirtualStringTree
    OnFocusChanged = vtListFocusChanged
    OnGetText = vtListGetText
  end
  inherited pMain: TPanel
    TabOrder = 7
  end
  object lCode: TStaticText
    Left = 248
    Top = 104
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'C'#243'digo: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object lDescription: TStaticText
    Left = 248
    Top = 168
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Descri'#231#227'o: '
    FocusControl = eDescription
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object eDescription: TEdit
    Left = 376
    Top = 168
    Width = 265
    Height = 21
    Anchors = [akLeft, akRight]
    CharCase = ecUpperCase
    TabOrder = 5
    OnChange = ChangeGlobal
  end
  object eCode: TCurrencyEdit
    Left = 376
    Top = 104
    Width = 81
    Height = 21
    AutoSize = False
    DecimalPlaces = 0
    DisplayFormat = ',0.;- ,0.'
    Anchors = [akLeft, akRight]
    TabOrder = 6
    OnChange = ChangeGlobal
  end
end
