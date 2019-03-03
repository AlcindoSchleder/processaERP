object fmNotasFiscais: TfmNotasFiscais
  Left = 206
  Top = 171
  Width = 538
  Height = 447
  Caption = 'Notas Fiscais'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 530
    Height = 87
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 4
      Width = 41
      Height = 13
      Caption = 'Empresa'
    end
    object Label2: TLabel
      Left = 6
      Top = 44
      Width = 189
      Height = 13
      Caption = 'Grupo Movimento / Tipo de Documento'
    end
    object Label3: TLabel
      Left = 386
      Top = 4
      Width = 80
      Height = 13
      Caption = 'Data da Emiss'#227'o'
    end
    object Label4: TLabel
      Left = 422
      Top = 22
      Width = 6
      Height = 13
      Caption = 'a'
    end
    object Label5: TLabel
      Left = 432
      Top = 44
      Width = 87
      Height = 13
      Caption = 'No do Documento'
    end
    object cbEmpresa: TComboBox
      Left = 6
      Top = 20
      Width = 321
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object cbGrupoMovimento: TComboBox
      Left = 6
      Top = 60
      Width = 323
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
    object dtDe: TJvDateEdit
      Left = 332
      Top = 20
      Width = 87
      Height = 21
      ImageKind = ikDropDown
      TabOrder = 1
    end
    object dtAte: TJvDateEdit
      Left = 436
      Top = 20
      Width = 87
      Height = 21
      ImageKind = ikDropDown
      TabOrder = 2
    end
    object edNumero: TCurrencyEdit
      Left = 330
      Top = 60
      Width = 193
      Height = 21
      AutoSize = False
      DecimalPlaces = 0
      DisplayFormat = '0;-0'
      MaxLength = 10
      TabOrder = 4
    end
  end
end
