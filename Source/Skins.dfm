object ProcSkins: TProcSkins
  Left = 435
  Top = 214
  Width = 395
  Height = 171
  Caption = 'ProcSkins'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    387
    137)
  PixelsPerInch = 96
  TextHeight = 13
  object sbOk: TSpeedButton
    Left = 136
    Top = 95
    Width = 105
    Height = 22
    Anchors = [akLeft]
    Caption = 'Ok'
    Flat = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FF044906055B09066C0C066C0C055E0A044C06FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF05600905600908911309B01809
      B31A09B31909B11907961405680C05680CFF00FFFF00FFFF00FFFF00FFFF00FF
      0A6A150A7F150BB61C09B91A08B41807B21609B31909B41909B81A09B91A0783
      10044D06FF00FFFF00FFFF00FF0B6A150F852216BD3411B7270BB21C07B11608
      B11709B21909B21909B21909B41909BA1A07841006670CFF00FFFF00FF0B6A15
      20BE491BBD4014B7300AB21F28BC36DFF5E1EEFAEF63CE6D09B21909B21909B3
      1909BA1A06670CFF00FF0872101B9A3A2AC65B1DBB450EB4250BB31B11B4219A
      DFA0FFFFFFF7FDF85ACB6509B21909B21909B81A089413045D090872102AB65B
      2CC56522BD4D0FB4220AB21A0CB31C0AB2198DDB95FDFEFDF6FCF758CB6309B2
      1909B51A08AB17045D090F821C37C26C33C76CCDF1DAC9EFD3C7EED0C8EFD2C5
      EED0C7EECFF8FDF9FFFFFFF2FBF36FD27908B41909B31905650B138D2358CC83
      42C977FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFDFFFFFFFFFFFFBCEA
      C10AB41A09B319066D0D0F911D6FD2935FD38D6DD49572D69971D69872D69964
      D28C92DFA8FBFEFBFFFFFFACE5B82EBF4C11B82B08B11905610A0F911D67CC83
      9BE5BA38C67030C36938C56F38C56F70D697E8F8EEFFFFFF9FE2B120BD481AB9
      3E10BA2908A31705610AFF00FF37B650BCEDD282DBA428C0632FC26753CD82F7
      FDF9FFFFFF9CE2B222BC4B1DBA4118B73614C0300A8517FF00FFFF00FF37B650
      71D28CD2F4E180DAA336C46D39C56FBCECCEABE6C22DC26324BE5623BC4D1FC1
      4616AE340A8517FF00FFFF00FFFF00FF25AE3984D89FDBF7EAAFE8C66BD49352
      CC8144C97849CA7B48CB7839CB6A21B6490F7C1FFF00FFFF00FFFF00FFFF00FF
      FF00FF66CD8166CD81ADE8C5CCF2DEBAEDD1A6E7C291E2B364D4922FB1572FB1
      57FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF32B74E52C46F61
      CB805DC87D43B96424A342FF00FFFF00FFFF00FFFF00FFFF00FF}
    OnClick = sbOkClick
  end
  object cbSkins: TComboBox
    Left = 48
    Top = 56
    Width = 293
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    Anchors = [akLeft, akRight]
    ItemHeight = 13
    TabOrder = 0
    OnClick = cbSkinsClick
  end
  object stTitle: TStaticText
    Left = 48
    Top = 16
    Width = 289
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = 'Sele'#231#227'o da Apresenta'#231#227'o da Tela'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object cbDeactivate: TCheckBox
    Left = 48
    Top = 96
    Width = 73
    Height = 17
    Caption = 'Desativar'
    TabOrder = 2
    OnClick = cbDeactivateClick
  end
end