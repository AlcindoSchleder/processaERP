object fMoveFunction: TfMoveFunction
  Left = 361
  Top = 230
  BorderStyle = bsNone
  ClientHeight = 145
  ClientWidth = 290
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PGFunction: TPageControl
    Left = 0
    Top = 0
    Width = 289
    Height = 145
    ActivePage = tsLogin
    OwnerDraw = True
    TabOrder = 0
    object tsLogin: TTabSheet
      Caption = 'tsLogin'
      TabVisible = False
      object sbEntra: TSpeedButton
        Left = 48
        Top = 104
        Width = 89
        Height = 21
        Caption = '&Entrar'
        OnClick = sbEntraClick
      end
      object sbCancelLogin: TSpeedButton
        Left = 152
        Top = 104
        Width = 89
        Height = 21
        Caption = '&Sair'
        OnClick = CancelFunction
      end
      object eSenha: TEdit
        Left = 102
        Top = 67
        Width = 169
        Height = 21
        Hint = 'Digite sua senha'
        PasswordChar = '*'
        TabOrder = 2
      end
      object lPassword: TStaticText
        Left = 38
        Top = 67
        Width = 59
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Senha:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object StaticText3: TStaticText
        Left = 6
        Top = 19
        Width = 91
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Supervisor :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object eSupervisor: TEdit
        Left = 102
        Top = 19
        Width = 169
        Height = 21
        TabOrder = 0
      end
    end
    object tsOut: TTabSheet
      Caption = 'tsOut'
      ImageIndex = 1
      TabVisible = False
      object sbOut: TSpeedButton
        Left = 40
        Top = 88
        Width = 89
        Height = 21
        Caption = '&Entrar'
        OnClick = sbOutClick
      end
      object sbCancelOut: TSpeedButton
        Left = 136
        Top = 88
        Width = 89
        Height = 21
        Caption = '&Sair'
        OnClick = CancelFunction
      end
      object StaticText1: TStaticText
        Left = 14
        Top = 39
        Width = 70
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Sangria:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object eSangriaValue: TEdit
        Left = 86
        Top = 39
        Width = 169
        Height = 21
        TabOrder = 1
      end
    end
    object tsIn: TTabSheet
      Caption = 'tsIn'
      ImageIndex = 2
      TabVisible = False
      object sbIn: TSpeedButton
        Left = 48
        Top = 88
        Width = 89
        Height = 21
        Caption = '&Entrar'
        OnClick = sbInClick
      end
      object sbCancelIn: TSpeedButton
        Left = 144
        Top = 88
        Width = 89
        Height = 21
        Caption = '&Sair'
        OnClick = CancelFunction
      end
      object StaticText2: TStaticText
        Left = 14
        Top = 43
        Width = 83
        Height = 21
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Numer'#225'rio:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object eNumValue: TEdit
        Left = 102
        Top = 43
        Width = 163
        Height = 21
        TabOrder = 1
      end
    end
  end
end
