object frmAccount: TfrmAccount
  Left = 199
  Top = 148
  Width = 780
  Height = 344
  Caption = 'frmAccount'
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object vtAccounts: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 309
    Height = 291
    Align = alLeft
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clBlue
    Header.Font.Height = -13
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = [fsBold]
    Header.Height = 25
    Header.Options = [hoAutoResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    HintAnimation = hatNone
    PopupMenu = pmNew
    SelectionCurveRadius = 5
    TabOrder = 0
    TreeOptions.PaintOptions = [toHotTrack, toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toMiddleClickSelect, toRightClickSelect]
    Columns = <
      item
        Position = 0
        Width = 305
        WideText = 'Lista das Contas'
      end>
  end
  object pData: TPanel
    Left = 309
    Top = 0
    Width = 463
    Height = 291
    Align = alClient
    ParentColor = True
    TabOrder = 1
    object cbTools: TCoolBar
      Left = 1
      Top = 1
      Width = 461
      Height = 32
      Bands = <
        item
          Control = tbTools
          ImageIndex = 91
          Text = 'Opera'#231#227'o'
          Width = 457
        end>
      object tbTools: TToolBar
        Left = 62
        Top = 0
        Width = 391
        Height = 25
        ButtonHeight = 19
        ButtonWidth = 60
        Caption = 'tbTools'
        Flat = True
        List = True
        ShowCaptions = True
        TabOrder = 0
        object tbInsert: TToolButton
          Left = 0
          Top = 0
          Caption = '&Inserir'
          ImageIndex = 34
        end
        object tbCancel: TToolButton
          Left = 60
          Top = 0
          Caption = '&Cancelar'
          ImageIndex = 28
        end
        object tbDelete: TToolButton
          Left = 120
          Top = 0
          Caption = '&Excluir'
          ImageIndex = 33
        end
        object tbSepOpe: TToolButton
          Left = 180
          Top = 0
          Width = 8
          Caption = 'tbSepOpe'
          ImageIndex = 3
          Style = tbsSeparator
        end
        object tbSalvar: TToolButton
          Left = 188
          Top = 0
          Caption = '&Salvar'
          ImageIndex = 36
        end
        object tbSepClose: TToolButton
          Left = 248
          Top = 0
          Width = 8
          Caption = 'tbSepClose'
          ImageIndex = 4
          Style = tbsSeparator
        end
        object tbClose: TToolButton
          Left = 256
          Top = 0
          Caption = 'Sai&r'
          ImageIndex = 41
          OnClick = tbCloseClick
        end
      end
    end
    object pgControl: TPageControl
      Left = 1
      Top = 33
      Width = 461
      Height = 257
      ActivePage = tsTypeAccount
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 1
      object tsTypeAccount: TTabSheet
        Caption = 'tsTypeAccount'
        TabVisible = False
      end
      object tsAccounts: TTabSheet
        Caption = 'tsAccounts'
        ImageIndex = 1
        TabVisible = False
      end
      object tsBanks: TTabSheet
        Caption = 'tsBanks'
        ImageIndex = 3
        TabVisible = False
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 291
    Width = 772
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Style = psOwnerDraw
        Width = 250
      end
      item
        Style = psOwnerDraw
        Width = 100
      end>
    OnClick = sbStatusClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
  object pmNew: TPopupMenu
    Left = 88
    Top = 160
    object pmNewTypeAccount: TMenuItem
      Caption = 'Novo &Tipo de Conta'
      ImageIndex = 43
    end
    object pmNewAccount: TMenuItem
      Caption = '&Nova Conta'
      ImageIndex = 55
      Visible = False
    end
    object pmNewBank: TMenuItem
      Caption = 'Novo &Banco'
      ImageIndex = 47
      Visible = False
    end
  end
end
