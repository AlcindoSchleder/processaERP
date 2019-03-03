unit uGeneral;

interface

uses ToolEdit, INIFIles, Forms, Windows, SysUtils;

var
  oDinheiroLocal, PathINIConfig: string;
  LogoTipo:String;
  ChecarVale:Boolean;
  {Utilizado no Controle de Exclusão dos Arquivos XML utilizados no Momento da Venda}
  LimparXML: Integer;
  ZerarXML:Integer;
  RoundPDV:Integer;
  {Variaveis utilizada na Carga dos Equipamentos do ECF/PDV}
  ECFModelo, ECFPorta, ECFPrefixo, ECFPrefixoTxt, ECFSufixo, ECFSufixoTxt: string;
  ECFParidade: Char;
  ECFVelocidade, ECFDataBits, ECFStopBits, ECFPooling: string;
  ECFSoftFlow, ECFHardFlow: Boolean;
  RelModelo, Rodape1, Rodape2, Rodape3, Rodape4: string;
  //Variaveis utilizadas para o Scanner
  SCANModelo, SCANPorta, SCANPrefixo, SCANPrefixoTxt, SCANSufixo,
  SCANSufixoTxt: string;
  SCANParidade: Char;
  SCANVelocidade, SCANDataBits, SCANStopBits, SCANPooling: string;
  SCANSoftFlow, SCANHardFlow: Boolean;
  //Variaveis utilizadas para a Gaveta
  GavModelo, GavPorta, GavPrefixo, GavPrefixoTxt, GavSufixo,
  GavSufixoTxt: string;
  GavParidade: Char;
  GavVelocidade, GavDataBits, GavStopBits, GavPooling: string;
  GavSoftFlow, GavHardFlow: Boolean;
  //Variaveis Utilizada para Autenticador
  AutModelo, AutPorta, AutPrefixo, AutPrefixoTxt, AutSufixo,
  AutSufixoTxt: string;
  AutParidade: Char;
  AutVelocidade, AutDataBits, AutStopBits, AutPooling: string;
  AutSoftFlow, AutHardFlow: Boolean;
  //Variaveis Utilizada para Cheque
  ChqModelo, ChqPorta, ChqPrefixo, ChqPrefixoTxt, ChqSufixo,
  ChqSufixoTxt: string;
  ChqParidade: Char;
  ChqVelocidade, ChqDataBits, ChqStopBits, ChqPooling: string;
  ChqSoftFlow, ChqHardFlow: Boolean;
  //Variaveis utilizadas para a Balança
  //Modelo da Balança
  BalModelo, BalPorta: string;
  //Posiçao Inicial de Checagem do Codigo de Barra
  BalVerificadorInicial,
    //Numero de Caracter para a Checagem Inicial
  BalVerificadorTamanho: Integer;
  //Valor de Comparação da Checagem Inicial
  BalVerificadorValor: string;
  //Tamanho do Codigo de Barra
  BalTamBarra,
    //Posicao Inicial do Codigo do Produto
  BalProdutoInicial,
    //Numero de Caracter do Codigo do Produto
  BalProdutoTamanho,
    //Posição Inicial do Preço Antes da Virgula
  BalPrecoInicial,
    //Numero de Caracter do Preco Antes da Virgula
  BalPrecoTamanho,
    //Posição Inicial do Preço Apos a Virgula
  BalPrecoInicialV,
    //Numero de Caracter do Preco Apos a Virgula
  BalPrecoTamanhoV: Integer;

procedure WriteGeneralINIConfig;
procedure ReadGeneralINIConfig;
function allTrim(Text: string): string;
function RemoveChar(const Text: string): string;
function Formatar(texto: string; TamanhoDesejado: Integer; AcrescentarADireita:
  Boolean = True; CaracterAcrescentar: Char = ' '): string;
procedure WriteRodapeECFINIConfig;
procedure ReadRodapeECFINIConfig;
procedure WriteECFINIConfig;
procedure ReadECFINIConfig;
procedure WriteGavetaINIConfig;
procedure ReadGavetaINIConfig;
procedure WriteAutenticadorINIConfig;
procedure ReadAutenticadorINIConfig;
procedure WriteChequeECFINIConfig;
procedure ReadChequeECFINIConfig;
procedure WriteScannerECFINIConfig;
procedure ReadScannerECFINIConfig;
procedure WriteBalancaINIConfig;
procedure ReadBalancaINIConfig;
function RoundNum(Valor: Extended; Decimais: Integer): Extended;

implementation


{Esse procedimento grava as configurações gerais no arquivo .INI}

procedure WriteGeneralINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    WriteString('Geral', 'Logotipo', LogoTipo);
    WriteInteger('Geral', 'LimparXML', LimparXML);
    WriteInteger('Geral', 'ZerarXML', ZerarXML);
    WriteBool('Empresa', 'ChecarVale', ChecarVale);
    WriteFloat('Empresa', 'RoundPDV', RoundPDV);
    Free;
  end;
end;

{Esse procedimento lê as configurações gerais no arquivo .INI}

procedure ReadGeneralINIConfig;
var
  ArquivoIni: TIniFile;
begin
  PathINIConfig := ExtractFilePath(Application.ExeName) + 'Configuracao.ini';
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    LogoTipo   := ReadString('Geral', 'Logotipo', '');
    LimparXML  := ReadInteger('Geral', 'LimparXML', 3);
    ZerarXML   := ReadInteger('Geral', 'ZerarXML', 1);
    ChecarVale := ReadBool('Empresa', 'ChecarVale', True);
    RoundPDV   := ReadInteger('Empresa', 'RoundPDV', 2);
    Free;
  end;
end;

{** Função que retorna uma string removido os caracteres em brancos da direita e da esquerda
    @param   Text    Texto que será removido os caracteres
    @return  Retorna o texto sem os caracteres em brancos}

function allTrim(Text: string): string;
begin
  while Pos(' ', Text) > 0 do
    Delete(Text, Pos(' ', Text), 1);
  Result := Text;
end;

{** Função para remove caracteres de uma string deixando apenas numeros
    @param   Text    Sigla da Unidade Federativa;
    @return  Retorna string contendo somente numero}

function RemoveChar(const Text: string): string;
var
  I: Integer;
  S: string;
begin
  S := '';
  for I := 1 to Length(Text) do
  begin
    if (Text[I] in ['0'..'9']) then
    begin
      S := S + Copy(Text, I, 1);
    end;
  end;
  Result := S;
end;

{** Função para formatar um valor para 1.234,00
    @param   Valor    Valor a ser convertido
    @return  Retorna string com o valor formatado }

function vlrSTR(Valor: string): string;
var
  texto: string;
begin
  texto := Format('%n', [strtocurr(stringReplace(Trim(Valor), '.', '',
      [rfReplaceAll]))]);
  Result := (texto); //formata valor p/ 1.234,00
end;

{** Função para formatar um valor para 1234.00
    @param   text    valor a ser convertido
    @return  Retorna string com o valor formatado }

function vlrIB(Text: string): string;
begin
  Text := (stringReplace(Trim(Text), '.', '', [rfReplaceAll]));
  Text := (stringReplace(Trim(Text), ',', '.', [rfReplaceAll]));
  Result := Text; //formata p/ 1234.00
end;

{** Função para formatar um valor para 1234,00
    @param   text    valor a ser convertido
    @return  Retorna valor formatado }

function vlrCAL(Text: string): Currency;
begin
  Text := (stringReplace(Trim(Text), '.', '', [rfReplaceAll]));
  Result := strtocurr(Text); //formata p/ 1234,00
end;

{** Função para Eliminar caracteres inválidos e acrescentar caracteres à esquerda ou à direita do texto original para que a string resultante fique com o tamanho desejado
    @param   texto    Texto Original
    @param   TamanhoDesejado Tamanho que a string resultante deverá ter
    @param   AcrescentarADireita Indica se o carácter será acrescentado à direita ou à esquerda
    @param   TRUE - Se o tamanho do texto for MENOR que o desejado, acrescentar carácter à direita
    @param   Se o tamanho do texto for MAIOR que o desejado, eliminar últimos caracteres do texto
    @param   FALSE - Se o tamanho do texto for MENOR que o desejado, acrescentar carácter à esquerda
    @param   Se o tamanho do texto for MAIOR que o desejado, eliminar primeiros caracteres do texto
    @param   CaracterAcrescentar Carácter que deverá ser acrescentado
    @return  Retorna string formatada }

function Formatar(texto: string; TamanhoDesejado: Integer; AcrescentarADireita:
  Boolean = True; CaracterAcrescentar: Char = ' '): string;
{
   OBJETIVO: Eliminar caracteres inválidos e acrescentar caracteres à esquerda ou à direita do texto original para que a string resultante fique com o tamanho desejado

   Texto : Texto original
   TamanhoDesejado: Tamanho que a string resultante deverá ter
   AcrescentarADireita: Indica se o carácter será acrescentado à direita ou à esquerda
      TRUE - Se o tamanho do texto for MENOR que o desejado, acrescentar carácter à direita
             Se o tamanho do texto for MAIOR que o desejado, eliminar últimos caracteres do texto
      FALSE - Se o tamanho do texto for MENOR que o desejado, acrescentar carácter à esquerda
             Se o tamanho do texto for MAIOR que o desejado, eliminar primeiros caracteres do texto
   CaracterAcrescentar: Carácter que deverá ser acrescentado
}
var
  QuantidadeAcrescentar,
    TamanhoTexto,
    PosicaoInicial,
    I: Integer;

begin
  case CaracterAcrescentar of
    '0'..'9', 'a'..'z', 'A'..'Z', '*': ; {Não faz nada}
  else
    CaracterAcrescentar := ' ';
  end;

  texto := Trim(AnsiUpperCase(texto));
  TamanhoTexto := Length(texto);
  for I := 1 to (TamanhoTexto) do
  begin
    if Pos(texto[I],
      ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~''"!@#$%^&*()_-+=|/\{}[]:;,.<>') =
      0 then
    begin
      case texto[I] of
        'Á', 'À', 'Â', 'Ä', 'Ã': texto[I] := 'A';
        'É', 'È', 'Ê', 'Ë': texto[I] := 'E';
        'Í', 'Ì', 'Î', 'Ï': texto[I] := 'I';
        'Ó', 'Ò', 'Ô', 'Ö', 'Õ': texto[I] := 'O';
        'Ú', 'Ù', 'Û', 'Ü': texto[I] := 'U';
        'Ç': texto[I] := 'C';
        'Ñ': texto[I] := 'N';
      else
        texto[I] := ' ';
      end;
    end;
  end;

  QuantidadeAcrescentar := TamanhoDesejado - TamanhoTexto;
  if QuantidadeAcrescentar < 0 then
    QuantidadeAcrescentar := 0;
  if CaracterAcrescentar = '' then
    CaracterAcrescentar := ' ';
  if TamanhoTexto >= TamanhoDesejado then
    PosicaoInicial := TamanhoTexto - TamanhoDesejado + 1
  else
    PosicaoInicial := 1;

  if AcrescentarADireita then
    texto := Copy(texto, 1, TamanhoDesejado) +
      StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar)
  else
    texto := StringOfChar(CaracterAcrescentar, QuantidadeAcrescentar) +
      Copy(texto, PosicaoInicial, TamanhoDesejado);

  Result := AnsiUpperCase(texto);
end;

{** Funcao que acrescenta zeros a esquerda dos numeros para fechar as casas decimais
    @param   text    Texto original
    @param   Tamanho Tamanho a ser acrescido de zero a esquerda
    @return  Retorna string formatada}

function AjustaZero(Text: string; Tamanho: Integer): string;
begin
  while Length(Text) < Tamanho do
    Text := '0' + Text;
  if Length(Text) > Tamanho then
    Text := Copy(Text, 1, Tamanho);
  Result := Text;
end;

{Esse procedimento grava as configurações do Rodape e do Relatorio no arquivo .INI}

procedure WriteRodapeECFINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    WriteString('RodapeECF', 'Rodape1', Rodape1);
    WriteString('RodapeECF', 'Rodape2', Rodape2);
    WriteString('RodapeECF', 'Rodape3', Rodape3);
    WriteString('RodapeECF', 'Rodape4', Rodape4);
    WriteString('RelatorioECF', 'Modelo', RelModelo);
    Free;
  end;
end;

{Esse procedimento lê as configurações do Rodape e do Relatorio no arquivo .INI}

procedure ReadRodapeECFINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    Rodape1 := ReadString('RodapeECF', 'Rodape1', 'GRATO PELA PREFERENCIA');
    Rodape2 := ReadString('RodapeECF', 'Rodape2', '');
    Rodape3 := ReadString('RodapeECF', 'Rodape3', '');
    Rodape4 := ReadString('RodapeECF', 'Rodape4', '');
    RelModelo := ReadString('RelatorioECF', 'Modelo', '');
    Free;
  end;
end;

{Esse procedimento grava as configurações do ECF/PDV no arquivo .INI}

procedure WriteECFINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    WriteString('ECF', 'Modelo', ECFModelo);
    WriteString('ECF', 'Porta', ECFPorta);
    WriteString('ECF', 'Paridade', ECFParidade);
    WriteString('ECF', 'Velocidade', ECFVelocidade);
    WriteString('ECF', 'DataBits', ECFDataBits);
    WriteString('ECF', 'StopBits', ECFStopBits);
    WriteString('ECF', 'Pooling', ECFPooling);
    WriteBool('ECF', 'SoftFlow', ECFSoftFlow);
    WriteBool('ECF', 'HardFlow', ECFHardFlow);
    Free;
  end;
end;

{Esse procedimento lê as configurações do ECF/PDV no arquivo .INI}

procedure ReadECFINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    ECFModelo := ReadString('ECF', 'Modelo', '');
    ECFPorta := ReadString('ECF', 'Porta', 'COM1');
    ECFParidade := ReadString('ECF', 'Paridade', '0')[1];
    ECFVelocidade := ReadString('ECF', 'Velocidade', '9600');
    ECFDataBits := ReadString('ECF', 'DataBits', '7');
    ECFStopBits := ReadString('ECF', 'StopBits', '1');
    ECFPooling := ReadString('ECF', 'Pooling', '1000');
    ECFSoftFlow := ReadBool('ECF', 'SoftFlow', True);
    ECFHardFlow := ReadBool('ECF', 'HardFlow', True);
    FreeAndNil(ArquivoIni);
  end;
end;

{Esse procedimento grava as configurações da Gaveta no arquivo .INI}

procedure WriteGavetaINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    WriteString('Gaveta', 'Modelo', GavModelo);
    WriteString('Gaveta', 'Porta', GavPorta);
    WriteString('Gaveta', 'Paridade', GavParidade);
    WriteString('Gaveta', 'Velocidade', GavVelocidade);
    WriteString('Gaveta', 'DataBits', GavDataBits);
    WriteString('Gaveta', 'StopBits', GavStopBits);
    WriteString('Gaveta', 'Pooling', GavPooling);
    WriteBool('Gaveta', 'SoftFlow', GavSoftFlow);
    WriteBool('Gaveta', 'HardFlow', GavHardFlow);
    Free;
  end;
end;

{Esse procedimento lê as configurações da Gaveta no arquivo .INI}

procedure ReadGavetaINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    GavModelo := ReadString('Gaveta', 'Modelo', '');
    GavPorta := ReadString('Gaveta', 'Porta', 'COM1');
    GavParidade := ReadString('Gaveta', 'Paridade', '0')[1];
    GavVelocidade := ReadString('Gaveta', 'Velocidade', '9600');
    GavDataBits := ReadString('Gaveta', 'DataBits', '7');
    GavStopBits := ReadString('Gaveta', 'StopBits', '1');
    GavPooling := ReadString('Gaveta', 'Pooling', '1000');
    GavSoftFlow := ReadBool('Gaveta', 'SoftFlow', True);
    GavHardFlow := ReadBool('Gaveta', 'HardFlow', True);
    Free;
  end;
end;

{Esse procedimento grava as configurações do Autenticador no arquivo .INI}

procedure WriteAutenticadorINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    WriteString('Autenticador', 'Modelo', AutModelo);
    WriteString('Autenticador', 'Porta', AutPorta);
    WriteString('Autenticador', 'Paridade', AutParidade);
    WriteString('Autenticador', 'Velocidade', AutVelocidade);
    WriteString('Autenticador', 'DataBits', AutDataBits);
    WriteString('Autenticador', 'StopBits', AutStopBits);
    WriteString('Autenticador', 'Pooling', AutPooling);
    WriteBool('Autenticador', 'SoftFlow', AutSoftFlow);
    WriteBool('Autenticador', 'HardFlow', AutHardFlow);
    Free;
  end;
end;

{Esse procedimento lê as configurações do Autenticador no arquivo .INI}

procedure ReadAutenticadorINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    AutModelo := ReadString('Autenticador', 'Modelo', '');
    AutPorta := ReadString('Autenticador', 'Porta', 'COM1');
    AutParidade := ReadString('Autenticador', 'Paridade', '0')[1];
    AutVelocidade := ReadString('Autenticador', 'Velocidade', '9600');
    AutDataBits := ReadString('Autenticador', 'DataBits', '7');
    AutStopBits := ReadString('Autenticador', 'StopBits', '1');
    AutPooling := ReadString('Autenticador', 'Pooling', '1000');
    AutSoftFlow := ReadBool('Autenticador', 'SoftFlow', True);
    AutHardFlow := ReadBool('Autenticador', 'HardFlow', True);
    Free;
  end;
end;

{Esse procedimento grava as configurações do Autenticador no arquivo .INI}

procedure WriteChequeECFINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    WriteString('ChequeECF', 'Modelo', ChqModelo);
    WriteString('ChequeECF', 'Porta', ChqPorta);
    WriteString('ChequeECF', 'Paridade', ChqParidade);
    WriteString('ChequeECF', 'Velocidade', ChqVelocidade);
    WriteString('ChequeECF', 'DataBits', ChqDataBits);
    WriteString('ChequeECF', 'StopBits', ChqStopBits);
    WriteString('ChequeECF', 'Pooling', ChqPooling);
    WriteBool('ChequeECF', 'SoftFlow', ChqSoftFlow);
    WriteBool('ChequeECF', 'HardFlow', ChqHardFlow);
    Free;
  end;
end;

{Esse procedimento lê as configurações do Autenticador no arquivo .INI}

procedure ReadChequeECFINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    ChqModelo := ReadString('ChequeECF', 'Modelo', '');
    ChqPorta := ReadString('ChequeECF', 'Porta', 'COM1');
    ChqParidade := ReadString('ChequeECF', 'Paridade', '0')[1];
    ChqVelocidade := ReadString('ChequeECF', 'Velocidade', '9600');
    ChqDataBits := ReadString('ChequeECF', 'DataBits', '7');
    ChqStopBits := ReadString('ChequeECF', 'StopBits', '1');
    ChqPooling := ReadString('ChequeECF', 'Pooling', '1000');
    ChqSoftFlow := ReadBool('ChequeECF', 'SoftFlow', True);
    ChqHardFlow := ReadBool('ChequeECF', 'HardFlow', True);
    Free;
  end;
end;

{Esse procedimento grava as configurações do Autenticador no arquivo .INI}

procedure WriteScannerECFINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    WriteString('ScannerECF', 'Modelo', SCANModelo);
    WriteString('ScannerECF', 'Porta', SCANPorta);
    WriteString('ScannerECF', 'Paridade', SCANParidade);
    WriteString('ScannerECF', 'Velocidade', SCANVelocidade);
    WriteString('ScannerECF', 'DataBits', SCANDataBits);
    WriteString('ScannerECF', 'StopBits', SCANStopBits);
    WriteString('ScannerECF', 'Pooling', SCANPooling);
    WriteString('ScannerECF', 'Prefixo', SCANPrefixo);
    WriteString('ScannerECF', 'PrefixoTxt', SCANPrefixoTxt);
    WriteString('ScannerECF', 'Sufixo', SCANSufixo);
    WriteString('ScannerECF', 'SufixoTxt', SCANSufixoTxt);
    WriteBool('ScannerECF', 'SoftFlow', SCANSoftFlow);
    WriteBool('ScannerECF', 'HardFlow', SCANHardFlow);
    Free;
  end;
end;

{Esse procedimento lê as configurações do Autenticador no arquivo .INI}

procedure ReadScannerECFINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    SCANModelo := ReadString('ScannerECF', 'Modelo', '');
    SCANPorta := ReadString('ScannerECF', 'Porta', 'COM1');
    SCANParidade := ReadString('ScannerECF', 'Paridade', '0')[1];
    SCANVelocidade := ReadString('ScannerECF', 'Velocidade', '9600');
    SCANDataBits := ReadString('ScannerECF', 'DataBits', '7');
    SCANStopBits := ReadString('ScannerECF', 'StopBits', '1');
    SCANPooling := ReadString('ScannerECF', 'Pooling', '1000');
    SCANPrefixo := ReadString('ScannerECF', 'Prefixo', '');
    SCANPrefixoTxt := ReadString('ScannerECF', 'PrefixoTxt', '');
    SCANSufixo := ReadString('ScannerECF', 'Sufixo', '');
    SCANSufixoTxt := ReadString('ScannerECF', 'SufixoTxt', '');
    SCANSoftFlow := ReadBool('ScannerECF', 'SoftFlow', True);
    SCANHardFlow := ReadBool('ScannerECF', 'HardFlow', True);
    Free;
  end;
end;

{Esse procedimento grava as configurações da Balança no arquivo .INI}

procedure WriteBalancaINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    WriteString('BALANCA', 'Modelo', BalModelo);
    WriteString('BALANCA', 'Porta', BalPorta);
    WriteInteger('BALANCA', 'VerificadorInicial', BalVerificadorInicial);
    WriteInteger('BALANCA', 'VerificadorTamanho', BalVerificadorTamanho);
    WriteString('BALANCA', 'VerificadorValor', BalVerificadorValor);
    WriteInteger('BALANCA', 'TamanhoBarra', BalTamBarra);
    WriteInteger('BALANCA', 'ProdutoInicial', BalProdutoInicial);
    WriteInteger('BALANCA', 'ProdutoTamanho', BalProdutoTamanho);
    WriteInteger('BALANCA', 'PrecoInicial', BalPrecoInicial);
    WriteInteger('BALANCA', 'PrecoTamanho', BalPrecoTamanho);
    WriteInteger('BALANCA', 'PrecoInicialVirgula', BalPrecoInicialV);
    WriteInteger('BALANCA', 'PrecoTamanhoVirgula', BalPrecoTamanhoV);
    Free;
  end;
end;

{Esse procedimento lê as configurações do ECF/PDV no arquivo .INI}

procedure ReadBalancaINIConfig;
var
  ArquivoIni: TIniFile;
begin
  ArquivoIni := TIniFile.Create(PathINIConfig);
  with ArquivoIni do
  begin
    BalModelo := ReadString('BALANCA', 'Modelo', '');
    BalPorta := ReadString('BALANCA', 'Porta', 'COM1');
    BalVerificadorInicial := ReadInteger('BALANCA', 'VerificadorInicial', 1);
    BalVerificadorTamanho := ReadInteger('BALANCA', 'VerificadorTamanho', 1);
    BalVerificadorValor := ReadString('BALANCA', 'VerificadorValor', '2');
    BalTamBarra := ReadInteger('BALANCA', 'TamanhoBarra', 13);
    BalProdutoInicial := ReadInteger('BALANCA', 'ProdutoInicial', 2);
    BalProdutoTamanho := ReadInteger('BALANCA', 'ProdutoTamanho', 4);
    BalPrecoInicial := ReadInteger('BALANCA', 'PrecoInicial', 7);
    BalPrecoTamanho := ReadInteger('BALANCA', 'PrecoTamanho', 4);
    BalPrecoInicialV := ReadInteger('BALANCA', 'PrecoInicialVirgula', 11);
    BalPrecoTamanhoV := ReadInteger('BALANCA', 'PrecoTamanhoVirgula', 2);
    Free;
  end;
end;

function RoundNum(Valor: Extended; Decimais: Integer): Extended;
{Quando houver,Arredonda uma possivel terceira casa decimal em uma variável}
var
  I: Integer;
  Multiplicador: Integer;
begin
  if Decimais > 15 then
  begin
    Decimais := 15;
  end
  else
    if Decimais < 0 then
    begin
      Decimais := 0;
    end;
  Multiplicador := 1;
  for I := 1 to Decimais do
  begin
    Multiplicador := Multiplicador * 10;
  end;
  Result := round(Valor * Multiplicador) / Multiplicador;
end;

end.