object CdImpostos: TCdImpostos
  Left = 217
  Top = 115
  Width = 800
  Height = 550
  Caption = 'CdImpostos'
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 33
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 788
      end>
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 711
      Height = 25
      ButtonHeight = 19
      ButtonWidth = 54
      Caption = 'tbTools'
      Flat = True
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbInsert: TToolButton
        Left = 0
        Top = 0
        Caption = 'Inserir'
        ImageIndex = 42
        OnClick = tbInsertClick
      end
      object tbCancel: TToolButton
        Left = 54
        Top = 0
        Hint = 'Cancelar | Cancela as altera'#231#245'es atuais'
        Caption = 'Cancelar'
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbDelete: TToolButton
        Left = 108
        Top = 0
        Hint = 'Excluir | Exclui o registro atual'
        Caption = 'Excluir'
        ImageIndex = 33
        OnClick = tbDeleteClick
      end
      object ToolButton5: TToolButton
        Left = 162
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 170
        Top = 0
        Hint = 'Salvar | Sava as altera'#231#245'es efetuadas'
        Caption = 'Salvar'
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object ToolButton1: TToolButton
        Left = 224
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 232
        Top = 0
        Hint = 'Sair | Fecha a janela'
        Caption = 'Sair'
        ImageIndex = 41
        OnClick = tbCloseClick
      end
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 497
    Width = 792
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Style = psOwnerDraw
        Text = 'Empresa'
        Width = 300
      end
      item
        Style = psOwnerDraw
        Width = 100
      end>
    OnClick = sbStatusClick
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
  object vtList: TVirtualStringTree
    Left = 0
    Top = 32
    Width = 697
    Height = 457
    Colors.FocusedSelectionColor = clSilver
    EditDelay = 0
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    ScrollBarOptions.AlwaysVisible = True
    ScrollBarOptions.ScrollBars = ssVertical
    SelectionCurveRadius = 10
    TabOrder = 2
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toEditable, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.SelectionOptions = [toExtendedFocus]
    OnBeforeItemErase = vtListBeforeItemErase
    OnDblClick = vtListDblClick
    OnEditing = vtListEditing
    OnFocusChanging = vtListFocusChanging
    OnGetText = vtListGetText
    OnPaintText = vtListPaintText
    OnGetImageIndexEx = vtListGetImageIndexEx
    OnNewText = vtListNewText
    Columns = <
      item
        Position = 0
        Width = 132
        WideText = 'Imposto'
      end
      item
        Alignment = taRightJustify
        Position = 1
        Width = 100
        WideText = 'Al'#237'q. Imp.'
      end
      item
        Alignment = taRightJustify
        Position = 2
        Width = 100
        WideText = 'Al'#237'q. Cons.'
      end
      item
        Alignment = taRightJustify
        Position = 3
        Width = 344
        WideText = 'Al'#237'q. Arbr.'
      end>
    WideDefaultText = ''
  end
end
