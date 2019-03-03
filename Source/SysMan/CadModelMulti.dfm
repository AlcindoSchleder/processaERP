object frmModelMulti: TfrmModelMulti
  Left = 223
  Top = 161
  Width = 660
  Height = 290
  Caption = 'frmModelMulti'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spSplitter: TSplitter
    Left = 237
    Top = 33
    Height = 200
    Align = alRight
  end
  object cbTools: TCoolBar
    Left = 0
    Top = 0
    Width = 644
    Height = 33
    Bands = <
      item
        Control = tbTools
        ImageIndex = 18
        Text = 'Ferramentas'
        Width = 640
      end>
    object tbTools: TToolBar
      Left = 73
      Top = 0
      Width = 563
      Height = 25
      ButtonWidth = 69
      Caption = 'tbTools'
      Flat = True
      Images = dmMain.Image16
      List = True
      ShowCaptions = True
      TabOrder = 0
      object tbInsert: TToolButton
        Left = 0
        Top = 0
        Hint = 'Inserir | Insere um novo registro'
        Caption = 'Inserir'
        ImageIndex = 34
        OnClick = tbInsertClick
      end
      object tbCancel: TToolButton
        Left = 69
        Top = 0
        Hint = 'Cancelar | Cancela as altera'#231#245'es atuais'
        Caption = 'Cancelar'
        ImageIndex = 28
        OnClick = tbCancelClick
      end
      object tbDelete: TToolButton
        Left = 138
        Top = 0
        Hint = 'Excluir | Exclui o registro atual'
        Caption = 'Excluir'
        ImageIndex = 33
        OnClick = tbDeleteClick
      end
      object tbSepSave: TToolButton
        Left = 207
        Top = 0
        Width = 8
        Caption = 'tbSepSave'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbSave: TToolButton
        Left = 215
        Top = 0
        Hint = 'Salvar | Sava as altera'#231#245'es efetuadas'
        Caption = 'Salvar'
        ImageIndex = 36
        OnClick = tbSaveClick
      end
      object tbSelClose: TToolButton
        Left = 284
        Top = 0
        Width = 8
        Caption = 'tbSelClose'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbClose: TToolButton
        Left = 292
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
    Top = 233
    Width = 644
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
    OnMouseDown = sbStatusMouseDown
    OnDrawPanel = sbStatusDrawPanel
  end
  object vtList: TVirtualStringTree
    Left = 0
    Top = 33
    Width = 237
    Height = 200
    Align = alClient
    Colors.FocusedSelectionColor = clSilver
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsXPStyle
    IncrementalSearch = isVisibleOnly
    SelectionCurveRadius = 10
    TabOrder = 2
    TreeOptions.SelectionOptions = [toExtendedFocus, toFullRowSelect, toRightClickSelect]
    OnFocusChanging = vtListFocusChanging
    OnGetImageIndexEx = vtListGetImageIndexEx
    OnIncrementalSearch = vtListIncrementalSearch
    OnStateChange = vtListStateChange
    Columns = <
      item
        Position = 0
        Width = 233
        WideText = 'Descri'#231#227'o'
      end>
  end
  object pgControl: TPageControl
    Left = 240
    Top = 33
    Width = 404
    Height = 200
    Align = alRight
    TabOrder = 3
    object tsRoot: TTabSheet
      TabVisible = False
    end
  end
end
