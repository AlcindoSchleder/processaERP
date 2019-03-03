inherited frmRotine: TfrmRotine
  Caption = 'frmRotines'
  ClientHeight = 462
  ClientWidth = 386
  PixelsPerInch = 96
  TextHeight = 13
  object stTitle: TLabel
    Left = 8
    Top = 24
    Width = 369
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Manuten'#231#227'o das Rotinas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object lPk_Rotinas: TStaticText
    Left = 16
    Top = 69
    Width = 128
    Height = 21
    Alignment = taRightJustify
    Anchors = [akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'lPk_Rotinas'
    FocusControl = ePk_Rotinas
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ePk_Rotinas: TEdit
    Left = 155
    Top = 69
    Width = 119
    Height = 21
    Anchors = [akRight]
    BevelKind = bkFlat
    BorderStyle = bsNone
    Ctl3D = False
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 1
  end
  object eDsc_Rot: TEdit
    Left = 152
    Top = 109
    Width = 210
    Height = 21
    Anchors = [akLeft, akRight]
    BevelKind = bkFlat
    BorderStyle = bsNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
  end
  object lDsc_Rot: TStaticText
    Left = 16
    Top = 109
    Width = 129
    Height = 21
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'lDsc_Rot'
    FocusControl = eDsc_Rot
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
end
