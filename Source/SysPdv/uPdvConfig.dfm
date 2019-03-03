object frmPDVConfig: TfrmPDVConfig
  Left = 189
  Top = 141
  Width = 510
  Height = 359
  VertScrollBar.Range = 32
  ActiveControl = PageControl1
  AutoScroll = False
  Caption = 'Configura'#231#227'o'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = 11
  Font.Name = 'MS Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 502
    Height = 293
    ActivePage = tsPersonal
    Align = alClient
    TabOrder = 0
    object TabSheetECF: TTabSheet
      Caption = 'ECF'
      object Label1: TLabel
        Left = 5
        Top = 47
        Width = 108
        Height = 13
        Caption = '&Porta de Comunica'#231#227'o'
      end
      object Label2: TLabel
        Left = 5
        Top = 87
        Width = 53
        Height = 13
        Caption = '&Velocidade'
      end
      object Label5: TLabel
        Left = 5
        Top = 9
        Width = 35
        Height = 13
        Caption = '&Modelo'
      end
      object Label17: TLabel
        Left = 130
        Top = 167
        Width = 35
        Height = 13
        Caption = 'Pooling'
      end
      object cbecfPorta: TComboBox
        Left = 5
        Top = 62
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'COM1'
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6'
          'COM7'
          'COM8'
          'COM9'
          'COM10'
          'LPT1'
          'LPT2')
      end
      object cbecfVelocidade: TComboBox
        Left = 5
        Top = 102
        Width = 111
        Height = 21
        ItemHeight = 13
        ItemIndex = 4
        TabOrder = 2
        Text = '9600'
        Items.Strings = (
          '1200'
          '1800'
          '2400'
          '4800'
          '9600'
          '19200'
          '38400'
          '57600'
          '115200')
      end
      object rgecfDatabits: TRadioGroup
        Left = 5
        Top = 125
        Width = 111
        Height = 34
        Caption = '&Databits'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          '7'
          '8')
        TabOrder = 3
      end
      object rgecfParidade: TRadioGroup
        Left = 130
        Top = 10
        Width = 151
        Height = 66
        Caption = 'P&aridade'
        Columns = 2
        ItemIndex = 4
        Items.Strings = (
          'Odd'
          'Even'
          'Mark'
          'Space'
          'Nenhuma')
        TabOrder = 4
      end
      object rgecfStopBits: TRadioGroup
        Left = 130
        Top = 75
        Width = 151
        Height = 34
        Caption = '&StopBits'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          '1'
          '1.5'
          '2')
        TabOrder = 5
      end
      object FlowControl: TGroupBox
        Left = 130
        Top = 110
        Width = 151
        Height = 51
        Caption = 'Controle de &Fluxo'
        TabOrder = 6
        object cbecfsoftflow: TCheckBox
          Left = 5
          Top = 15
          Width = 141
          Height = 17
          Caption = 'Software (XON/XOFF)'
          TabOrder = 0
        end
        object cbecfhardflow: TCheckBox
          Left = 5
          Top = 30
          Width = 141
          Height = 17
          Caption = 'Hardware (CTS/RTS)'
          TabOrder = 1
        end
      end
      object cbecfModelo: TComboBox
        Left = 5
        Top = 24
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'GenericaArquivo'
          'Bematech_MP20_FI_II'
          'Bematech_MP40_FI_II'
          'Sweda'
          'Daruma_FS345')
      end
      object edecfPooling: TEdit
        Left = 169
        Top = 165
        Width = 47
        Height = 21
        TabOrder = 7
        Text = '1000'
      end
    end
    object TabSheetScan: TTabSheet
      Caption = 'Scanner'
      ImageIndex = 1
      object Label3: TLabel
        Left = 5
        Top = 45
        Width = 108
        Height = 13
        Caption = '&Porta de Comunica'#231#227'o'
      end
      object Label4: TLabel
        Left = 5
        Top = 85
        Width = 53
        Height = 13
        Caption = '&Velocidade'
      end
      object Label9: TLabel
        Left = 5
        Top = 9
        Width = 35
        Height = 13
        Caption = '&Modelo'
      end
      object Label16: TLabel
        Left = 130
        Top = 242
        Width = 35
        Height = 13
        Caption = 'Pooling'
      end
      object scnPorta: TComboBox
        Left = 5
        Top = 60
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6'
          'COM7'
          'COM8'
          'COM9'
          'COM10')
      end
      object ScnVelocidade: TComboBox
        Left = 5
        Top = 100
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          '1200'
          '1800'
          '2400'
          '4800'
          '9600'
          '19200'
          '38400'
          '57600'
          '115200')
      end
      object ScnDataBits: TRadioGroup
        Left = 5
        Top = 125
        Width = 111
        Height = 34
        Caption = '&Databits'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          '7'
          '8')
        TabOrder = 2
      end
      object ScnParidade: TRadioGroup
        Left = 130
        Top = 10
        Width = 141
        Height = 66
        Caption = 'P&aridade'
        Columns = 2
        ItemIndex = 4
        Items.Strings = (
          'Odd'
          'Even'
          'Mark'
          'Space'
          'Nenhuma')
        TabOrder = 3
      end
      object ScnStopBits: TRadioGroup
        Left = 130
        Top = 75
        Width = 141
        Height = 31
        Caption = '&StopBits'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          '1'
          '1.5'
          '2')
        TabOrder = 4
      end
      object GroupBox1: TGroupBox
        Left = 130
        Top = 107
        Width = 141
        Height = 49
        Caption = 'Controle de &Fluxo'
        TabOrder = 5
        object ScnSoftflow: TCheckBox
          Left = 5
          Top = 13
          Width = 131
          Height = 17
          Caption = 'Software (XON/XOFF)'
          TabOrder = 0
        end
        object ScnHardFlow: TCheckBox
          Left = 5
          Top = 28
          Width = 131
          Height = 17
          Caption = 'Hardware (CTS/RTS)'
          TabOrder = 1
        end
      end
      object ScnModelo: TComboBox
        Left = 5
        Top = 24
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 6
        Items.Strings = (
          'Nenhum'
          'Serial')
      end
      object scnPrefixo: TRadioGroup
        Left = 5
        Top = 164
        Width = 111
        Height = 97
        Caption = 'Prefixo'
        ItemIndex = 2
        Items.Strings = (
          'STX'
          'TAB'
          'Nenhum'
          ' ')
        TabOrder = 7
      end
      object scnSufixo: TRadioGroup
        Left = 130
        Top = 155
        Width = 141
        Height = 82
        Caption = 'Sufixo'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'CR'
          'LF'
          'CR+LF'
          'ETX'
          'Nenhum '
          ' ')
        TabOrder = 8
      end
      object ScnPrefixoTxt: TEdit
        Left = 30
        Top = 235
        Width = 76
        Height = 21
        TabOrder = 9
      end
      object ScnSufixoTxt: TEdit
        Left = 220
        Top = 206
        Width = 46
        Height = 21
        TabOrder = 10
      end
      object ScnPooling: TEdit
        Left = 169
        Top = 240
        Width = 47
        Height = 21
        TabOrder = 11
        Text = '1000'
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Gaveta'
      ImageIndex = 2
      object Label6: TLabel
        Left = 5
        Top = 47
        Width = 108
        Height = 13
        Caption = '&Porta de Comunica'#231#227'o'
      end
      object Label7: TLabel
        Left = 5
        Top = 87
        Width = 53
        Height = 13
        Caption = '&Velocidade'
      end
      object Label8: TLabel
        Left = 5
        Top = 9
        Width = 35
        Height = 13
        Caption = '&Modelo'
      end
      object Label18: TLabel
        Left = 130
        Top = 167
        Width = 35
        Height = 13
        Caption = 'Pooling'
      end
      object GavtPorta: TComboBox
        Left = 5
        Top = 62
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6'
          'COM7'
          'COM8'
          'COM9'
          'COM10')
      end
      object GavtVelocidade: TComboBox
        Left = 5
        Top = 102
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          '1200'
          '1800'
          '2400'
          '4800'
          '9600'
          '19200'
          '38400'
          '57600'
          '115200')
      end
      object GavtDataBits: TRadioGroup
        Left = 5
        Top = 125
        Width = 111
        Height = 34
        Caption = '&Databits'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          '7'
          '8')
        TabOrder = 2
      end
      object GavtParidade: TRadioGroup
        Left = 130
        Top = 10
        Width = 151
        Height = 66
        Caption = 'P&aridade'
        Columns = 2
        ItemIndex = 4
        Items.Strings = (
          'Odd'
          'Even'
          'Mark'
          'Space'
          'Nenhuma')
        TabOrder = 3
      end
      object GavtStopBits: TRadioGroup
        Left = 130
        Top = 75
        Width = 151
        Height = 34
        Caption = '&StopBits'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          '1'
          '1.5'
          '2')
        TabOrder = 4
      end
      object GroupBox2: TGroupBox
        Left = 130
        Top = 110
        Width = 151
        Height = 51
        Caption = 'Controle de &Fluxo'
        TabOrder = 5
        object GavtSoftFlow: TCheckBox
          Left = 5
          Top = 15
          Width = 131
          Height = 17
          Caption = 'Software (XON/XOFF)'
          TabOrder = 0
        end
        object GavtHardFlow: TCheckBox
          Left = 5
          Top = 30
          Width = 136
          Height = 17
          Caption = 'Hardware (CTS/RTS)'
          TabOrder = 1
        end
      end
      object GavtModelo: TComboBox
        Left = 5
        Top = 24
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 6
        Items.Strings = (
          'GenericaArquivo'
          'Menno'
          'Gerbo'
          'Bematech_MP20_FI_II'
          'Bematech_MP40_FI_II')
      end
      object GavtPooling: TEdit
        Left = 169
        Top = 165
        Width = 47
        Height = 21
        TabOrder = 7
        Text = '1000'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Autenticador'
      ImageIndex = 4
      object Label19: TLabel
        Left = 5
        Top = 47
        Width = 108
        Height = 13
        Caption = '&Porta de Comunica'#231#227'o'
      end
      object Label20: TLabel
        Left = 5
        Top = 87
        Width = 53
        Height = 13
        Caption = '&Velocidade'
      end
      object Label21: TLabel
        Left = 5
        Top = 9
        Width = 35
        Height = 13
        Caption = '&Modelo'
      end
      object Label22: TLabel
        Left = 130
        Top = 167
        Width = 35
        Height = 13
        Caption = 'Pooling'
      end
      object auteporta: TComboBox
        Left = 5
        Top = 62
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6'
          'COM7'
          'COM8'
          'COM9'
          'COM10')
      end
      object autevelocidade: TComboBox
        Left = 5
        Top = 102
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Items.Strings = (
          '1200'
          '1800'
          '2400'
          '4800'
          '9600'
          '19200'
          '38400'
          '57600'
          '115200')
      end
      object auteDataBits: TRadioGroup
        Left = 5
        Top = 125
        Width = 111
        Height = 34
        Caption = '&Databits'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          '7'
          '8')
        TabOrder = 5
      end
      object auteParidade: TRadioGroup
        Left = 130
        Top = 10
        Width = 151
        Height = 66
        Caption = 'P&aridade'
        Columns = 2
        ItemIndex = 4
        Items.Strings = (
          'Odd'
          'Even'
          'Mark'
          'Space'
          'Nenhuma')
        TabOrder = 7
      end
      object autestopbits: TRadioGroup
        Left = 130
        Top = 75
        Width = 151
        Height = 34
        Caption = '&StopBits'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          '1'
          '1.5'
          '2')
        TabOrder = 0
      end
      object GroupBox3: TGroupBox
        Left = 130
        Top = 110
        Width = 151
        Height = 51
        Caption = 'Controle de &Fluxo'
        TabOrder = 2
        object autesoftflow: TCheckBox
          Left = 5
          Top = 15
          Width = 131
          Height = 17
          Caption = 'Software (XON/XOFF)'
          TabOrder = 0
        end
        object autehardflow: TCheckBox
          Left = 5
          Top = 30
          Width = 136
          Height = 17
          Caption = 'Hardware (CTS/RTS)'
          TabOrder = 1
        end
      end
      object auteModelo: TComboBox
        Left = 5
        Top = 24
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Items.Strings = (
          'GenericaArquivo'
          'Bematech_MP20_FI_II'
          'Bematech_MP40_FI_II')
      end
      object autepooling: TEdit
        Left = 169
        Top = 165
        Width = 47
        Height = 21
        TabOrder = 6
        Text = '1000'
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Imp.Cheque'
      ImageIndex = 5
      object Label23: TLabel
        Left = 5
        Top = 47
        Width = 108
        Height = 13
        Caption = '&Porta de Comunica'#231#227'o'
      end
      object Label24: TLabel
        Left = 5
        Top = 87
        Width = 53
        Height = 13
        Caption = '&Velocidade'
      end
      object Label25: TLabel
        Left = 5
        Top = 9
        Width = 35
        Height = 13
        Caption = '&Modelo'
      end
      object Label26: TLabel
        Left = 130
        Top = 167
        Width = 35
        Height = 13
        Caption = 'Pooling'
      end
      object chqeporta: TComboBox
        Left = 5
        Top = 62
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6'
          'COM7'
          'COM8'
          'COM9'
          'COM10')
      end
      object chqeVelocidade: TComboBox
        Left = 5
        Top = 102
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Items.Strings = (
          '1200'
          '1800'
          '2400'
          '4800'
          '9600'
          '19200'
          '38400'
          '57600'
          '115200')
      end
      object chqeDatabits: TRadioGroup
        Left = 5
        Top = 125
        Width = 111
        Height = 34
        Caption = '&Databits'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          '7'
          '8')
        TabOrder = 5
      end
      object chqeParidade: TRadioGroup
        Left = 130
        Top = 10
        Width = 151
        Height = 66
        Caption = 'P&aridade'
        Columns = 2
        ItemIndex = 4
        Items.Strings = (
          'Odd'
          'Even'
          'Mark'
          'Space'
          'Nenhuma')
        TabOrder = 7
      end
      object chqeStopBits: TRadioGroup
        Left = 130
        Top = 75
        Width = 151
        Height = 34
        Caption = '&StopBits'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          '1'
          '1.5'
          '2')
        TabOrder = 0
      end
      object GroupBox4: TGroupBox
        Left = 130
        Top = 110
        Width = 151
        Height = 51
        Caption = 'Controle de &Fluxo'
        TabOrder = 2
        object chqesoftflow: TCheckBox
          Left = 5
          Top = 15
          Width = 131
          Height = 17
          Caption = 'Software (XON/XOFF)'
          TabOrder = 0
        end
        object chqehardflow: TCheckBox
          Left = 5
          Top = 30
          Width = 136
          Height = 17
          Caption = 'Hardware (CTS/RTS)'
          TabOrder = 1
        end
      end
      object chqemodelo: TComboBox
        Left = 5
        Top = 24
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Items.Strings = (
          'GenericaArquivo'
          'Bematech_MP40_FI_II')
      end
      object chqepooling: TEdit
        Left = 169
        Top = 165
        Width = 47
        Height = 21
        TabOrder = 6
        Text = '1000'
      end
    end
    object tsBalanca: TTabSheet
      Caption = 'Balan'#231'a'
      ImageIndex = 6
      object Label12: TLabel
        Left = 5
        Top = 9
        Width = 35
        Height = 13
        Caption = '&Modelo'
      end
      object Label13: TLabel
        Left = 5
        Top = 47
        Width = 108
        Height = 13
        Caption = '&Porta de Comunica'#231#227'o'
      end
      object cbbalModelo: TComboBox
        Left = 5
        Top = 24
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'Generica'
          'Toledo'
          'Filizola')
      end
      object cbbalPorta: TComboBox
        Left = 5
        Top = 62
        Width = 111
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'COM1'
        Items.Strings = (
          'COM1'
          'COM2'
          'COM3'
          'COM4'
          'COM5'
          'COM6'
          'COM7'
          'COM8'
          'COM9'
          'COM10'
          'LPT1'
          'LPT2')
      end
      object gbBalanca: TGroupBox
        Left = 5
        Top = 96
        Width = 169
        Height = 144
        Caption = 'Dados da Balan'#231'a'
        TabOrder = 2
        object Label14: TLabel
          Left = 5
          Top = 17
          Width = 71
          Height = 13
          Caption = 'Posicao Inicial:'
        end
        object Label15: TLabel
          Left = 104
          Top = 16
          Width = 48
          Height = 13
          Caption = 'Tamanho:'
        end
        object Label28: TLabel
          Left = 5
          Top = 56
          Width = 105
          Height = 13
          Caption = 'Valor de Compara'#231#227'o:'
        end
        object Label29: TLabel
          Left = 5
          Top = 96
          Width = 88
          Height = 13
          Caption = 'Tamanho do EAN:'
        end
        object edbalVerificadorInicial: TEdit
          Left = 5
          Top = 33
          Width = 89
          Height = 21
          TabOrder = 0
        end
        object edbalVerificadorTamanho: TEdit
          Left = 104
          Top = 32
          Width = 56
          Height = 21
          TabOrder = 1
        end
        object edbalVerificadorValor: TEdit
          Left = 5
          Top = 72
          Width = 89
          Height = 21
          TabOrder = 2
        end
        object edbalTamanhoBarra: TEdit
          Left = 5
          Top = 112
          Width = 89
          Height = 21
          TabOrder = 3
        end
      end
      object gbProduto: TGroupBox
        Left = 200
        Top = 13
        Width = 169
        Height = 67
        Caption = 'Dados do Produto'
        TabOrder = 3
        object Label30: TLabel
          Left = 5
          Top = 17
          Width = 71
          Height = 13
          Caption = 'Posi'#231#227'o Inicial:'
        end
        object Label31: TLabel
          Left = 104
          Top = 16
          Width = 48
          Height = 13
          Caption = 'Tamanho:'
        end
        object edbalProdutoInicial: TEdit
          Left = 5
          Top = 33
          Width = 89
          Height = 21
          TabOrder = 0
        end
        object edbalProdutoTamanho: TEdit
          Left = 104
          Top = 32
          Width = 56
          Height = 21
          TabOrder = 1
        end
      end
      object gbBalPreco: TGroupBox
        Left = 200
        Top = 97
        Width = 169
        Height = 143
        Caption = 'Dados do Pre'#231'o do Produto'
        TabOrder = 4
        object Label32: TLabel
          Left = 5
          Top = 97
          Width = 71
          Height = 13
          Caption = 'Posi'#231#227'o Inicial:'
        end
        object Label33: TLabel
          Left = 104
          Top = 96
          Width = 48
          Height = 13
          Caption = 'Tamanho:'
        end
        object Label34: TLabel
          Left = 5
          Top = 35
          Width = 71
          Height = 13
          Caption = 'Posi'#231#227'o Inicial:'
        end
        object Label35: TLabel
          Left = 104
          Top = 34
          Width = 48
          Height = 13
          Caption = 'Tamanho:'
        end
        object Label36: TLabel
          Left = 5
          Top = 18
          Width = 123
          Height = 13
          Caption = 'Antes da Virgula do Pre'#231'o'
        end
        object Label37: TLabel
          Left = 5
          Top = 82
          Width = 114
          Height = 13
          Caption = 'Apos a Virgula do Pre'#231'o'
        end
        object edbalPrecoInicialVirgula: TEdit
          Left = 5
          Top = 113
          Width = 89
          Height = 21
          TabOrder = 2
        end
        object edbalPrecoTamanhoVirgula: TEdit
          Left = 104
          Top = 112
          Width = 56
          Height = 21
          TabOrder = 3
        end
        object edbalPrecoInicial: TEdit
          Left = 5
          Top = 51
          Width = 89
          Height = 21
          TabOrder = 0
        end
        object edbalPrecoTamanho: TEdit
          Left = 104
          Top = 50
          Width = 56
          Height = 21
          TabOrder = 1
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Geral/Rodap'#233
      ImageIndex = 3
      object Label10: TLabel
        Left = 8
        Top = 114
        Width = 158
        Height = 13
        Caption = 'Mensagem do Rodap'#233' do cupom'
      end
      object Label27: TLabel
        Left = 9
        Top = 9
        Width = 98
        Height = 13
        Caption = '&Modelo de Relat'#243'rio:'
      end
      object Label11: TLabel
        Left = 9
        Top = 57
        Width = 123
        Height = 13
        Caption = 'Logotipo da Tela Principal'
      end
      object Linha1: TEdit
        Left = 8
        Top = 131
        Width = 345
        Height = 24
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 48
        ParentFont = False
        TabOrder = 0
        Text = ' '
      end
      object Linha2: TEdit
        Left = 8
        Top = 160
        Width = 345
        Height = 24
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 48
        ParentFont = False
        TabOrder = 1
        Text = ' '
      end
      object Linha3: TEdit
        Left = 8
        Top = 188
        Width = 345
        Height = 24
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 48
        ParentFont = False
        TabOrder = 2
      end
      object Linha4: TEdit
        Left = 8
        Top = 217
        Width = 345
        Height = 24
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 48
        ParentFont = False
        TabOrder = 3
      end
      object CbRelModelo: TComboBox
        Left = 9
        Top = 24
        Width = 184
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Items.Strings = (
          'GenericaArquivo'
          'Bematech_MP20_FI_II'
          'Bematech_MP40_FI_II')
      end
      object FEdLogotipo: TFilenameEdit
        Left = 10
        Top = 72
        Width = 343
        Height = 21
        NumGlyphs = 1
        TabOrder = 5
      end
    end
    object tsPersonal: TTabSheet
      Caption = 'Personalizado'
      ImageIndex = 7
      object Label38: TLabel
        Left = 18
        Top = 25
        Width = 86
        Height = 13
        Caption = 'Logotipo principal:'
      end
      object Label39: TLabel
        Left = 16
        Top = 133
        Width = 136
        Height = 13
        Caption = 'Numero de Arredondamento:'
      end
      object Label40: TLabel
        Left = 16
        Top = 90
        Width = 136
        Height = 13
        Caption = 'Numero de Arredondamento:'
      end
      object fEditLogotipo: TFilenameEdit
        Left = 16
        Top = 40
        Width = 377
        Height = 21
        NumGlyphs = 1
        TabOrder = 0
      end
      object cbChecarVale: TCheckBox
        Left = 16
        Top = 72
        Width = 377
        Height = 17
        Caption = 
          'Checar intervalo de Vale no Momento do fechamento do Cupom a Pra' +
          'zo.'
        TabOrder = 1
      end
      object RxCalcEdtRoundPDV: TRxCalcEdit
        Left = 16
        Top = 149
        Width = 121
        Height = 21
        Hint = 
          'Informe o Numero de Casas ap'#243's a virgula que ser'#227'o consideradas ' +
          'para o Arredondamento de Venda de produtos da balan'#231'a que ser'#227'o ' +
          'registrados no ECF.'
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0'
        MaxValue = 8.000000000000000000
        NumGlyphs = 2
        TabOrder = 2
      end
      object RxCalcEdtCupomValor: TRxCalcEdit
        Left = 16
        Top = 106
        Width = 121
        Height = 21
        Hint = 
          'Informe o Numero de Casas ap'#243's a virgula que ser'#227'o consideradas ' +
          'para o Arredondamento de Venda de produtos da balan'#231'a que ser'#227'o ' +
          'registrados no ECF.'
        AutoSize = False
        DecimalPlaces = 0
        DisplayFormat = ',0'
        MaxValue = 8.000000000000000000
        NumGlyphs = 2
        TabOrder = 3
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 293
    Width = 502
    Height = 32
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object Panel2: TPanel
      Left = 329
      Top = 2
      Width = 171
      Height = 28
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object BitBtn1: TBitBtn
        Left = 10
        Top = 2
        Width = 75
        Height = 25
        Caption = '&OK'
        TabOrder = 0
        OnClick = BitBtn1Click
        Kind = bkOK
      end
      object BitBtn2: TBitBtn
        Left = 90
        Top = 2
        Width = 75
        Height = 25
        Caption = '&Cancelar'
        TabOrder = 1
        Kind = bkCancel
      end
    end
  end
end
