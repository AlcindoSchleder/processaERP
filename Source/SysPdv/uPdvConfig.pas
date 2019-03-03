{ 21/11/2005 15:08:43 (GMT-3:00) > [sysdba on NEUMANN] checked out /}
{===============================================================================
Projeto Sultan
Biblioteca de componentes para conexão com periféricos de Automação Comercial.
Site: http://www.sultan.welter.pro.br

Direitos Autorais Reservados (c) 2004 Marcelo Welter

Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la sob
os termos da Licença Pública Geral Menor do GNU conforme publicada pela Free
Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) qualquer
versão posterior.

Esta biblioteca é distribuído na expectativa de que seja útil, porém, SEM
NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU
ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor do
GNU para mais detalhes.

Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto com
esta biblioteca; se não, escreva para a Free Software Foundation, Inc., no
endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.
================================================================================
Contato:
          Autor...: Marcelo Welter
          Email...: marcelo@welter.pro.br
          Endereço: Rua Bolivia, 393 apto.25
                    CEP 89050-300
                    Blumenau/SC - Brasil
===============================================================================}

unit uPdvConfig;

interface

uses
  Windows, SysUtils, Forms, stdCtrls, Buttons, ExtCtrls, Controls, ComCtrls,
  Classes, Mask, ToolEdit, CurrEdit;

type
  TfrmPDVConfig = class(TForm)
    PageControl1: TPageControl;
    TabSheetECF: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    cbecfPorta: TComboBox;
    cbecfVelocidade: TComboBox;
    rgecfDatabits: TRadioGroup;
    rgecfParidade: TRadioGroup;
    rgecfStopBits: TRadioGroup;
    FlowControl: TGroupBox;
    cbecfsoftflow: TCheckBox;
    cbecfhardflow: TCheckBox;
    TabSheetScan: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    scnPorta: TComboBox;
    Label4: TLabel;
    ScnVelocidade: TComboBox;
    ScnDataBits: TRadioGroup;
    ScnParidade: TRadioGroup;
    ScnStopBits: TRadioGroup;
    GroupBox1: TGroupBox;
    ScnSoftflow: TCheckBox;
    ScnHardFlow: TCheckBox;
    Label5: TLabel;
    cbecfModelo: TComboBox;
    TabSheet1: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GavtPorta: TComboBox;
    GavtVelocidade: TComboBox;
    GavtDataBits: TRadioGroup;
    GavtParidade: TRadioGroup;
    GavtStopBits: TRadioGroup;
    GroupBox2: TGroupBox;
    GavtSoftFlow: TCheckBox;
    GavtHardFlow: TCheckBox;
    GavtModelo: TComboBox;
    Label9: TLabel;
    ScnModelo: TComboBox;
    scnPrefixo: TRadioGroup;
    scnSufixo: TRadioGroup;
    ScnPrefixoTxt: TEdit;
    ScnSufixoTxt: TEdit;
    TabSheet2: TTabSheet;
    Label10: TLabel;
    Linha1: TEdit;
    Linha2: TEdit;
    Linha3: TEdit;
    Linha4: TEdit;
    Label16: TLabel;
    ScnPooling: TEdit;
    edecfPooling: TEdit;
    Label17: TLabel;
    GavtPooling: TEdit;
    Label18: TLabel;
    TabSheet3: TTabSheet;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    auteporta: TComboBox;
    autevelocidade: TComboBox;
    auteDataBits: TRadioGroup;
    auteParidade: TRadioGroup;
    autestopbits: TRadioGroup;
    GroupBox3: TGroupBox;
    autesoftflow: TCheckBox;
    autehardflow: TCheckBox;
    auteModelo: TComboBox;
    autepooling: TEdit;
    TabSheet4: TTabSheet;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    chqeporta: TComboBox;
    chqeVelocidade: TComboBox;
    chqeDatabits: TRadioGroup;
    chqeParidade: TRadioGroup;
    chqeStopBits: TRadioGroup;
    GroupBox4: TGroupBox;
    chqesoftflow: TCheckBox;
    chqehardflow: TCheckBox;
    chqemodelo: TComboBox;
    chqepooling: TEdit;
    Label27: TLabel;
    CbRelModelo: TComboBox;
    FEdLogotipo: TFilenameEdit;
    Label11: TLabel;
    tsBalanca: TTabSheet;
    Label12: TLabel;
    cbbalModelo: TComboBox;
    cbbalPorta: TComboBox;
    Label13: TLabel;
    gbBalanca: TGroupBox;
    gbProduto: TGroupBox;
    gbBalPreco: TGroupBox;
    edbalVerificadorInicial: TEdit;
    Label14: TLabel;
    edbalVerificadorTamanho: TEdit;
    Label15: TLabel;
    edbalVerificadorValor: TEdit;
    Label28: TLabel;
    edbalTamanhoBarra: TEdit;
    Label29: TLabel;
    edbalProdutoInicial: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    edbalProdutoTamanho: TEdit;
    Label32: TLabel;
    edbalPrecoInicialVirgula: TEdit;
    Label33: TLabel;
    edbalPrecoTamanhoVirgula: TEdit;
    Label34: TLabel;
    edbalPrecoInicial: TEdit;
    Label35: TLabel;
    edbalPrecoTamanho: TEdit;
    Label36: TLabel;
    Label37: TLabel;
    tsPersonal: TTabSheet;
    Label38: TLabel;
    fEditLogotipo: TFilenameEdit;
    cbChecarVale: TCheckBox;
    Label39: TLabel;
    RxCalcEdtRoundPDV: TRxCalcEdit;
    Label40: TLabel;
    RxCalcEdtCupomValor: TRxCalcEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPDVConfig: TfrmPDVConfig;

implementation

uses uGeneral;

{$R *.dfm}

procedure TfrmPDVConfig.BitBtn1Click(Sender: TObject);
begin
    //Grava Configuração do ECF/PDV
  ECFModelo := cbecfModelo.Text;
  ECFPorta := cbecfPorta.Text;
  ECFVelocidade := cbecfVelocidade.Text;
  ECFDataBits := rgecfDatabits.Items[rgecfDatabits.itemindex];
  if rgecfParidade.itemindex = -1 then
    rgecfParidade.itemindex := 0;
  ECFParidade := rgecfParidade.Items[rgecfParidade.itemindex][1];
  ECFStopBits := intToStr(rgecfStopBits.itemindex);
  ECFSoftFlow := cbecfsoftflow.Checked;
  ECFHardFlow := cbecfhardflow.Checked;
  ECFPooling := edecfPooling.Text;
  WriteECFINIConfig;

    //Grava Configuração do Scanner
  ScanModelo := ScnModelo.Text;
  ScanPorta := ScnPorta.Text;
  ScanVelocidade := ScnVelocidade.Text;
  ScanDataBits := ScnDataBits.Items[ScnDataBits.itemindex];
  ScanParidade := ScnParidade.Items[ScnParidade.itemindex][1];
  ScanStopBits := IntToStr(ScnStopBits.itemindex);
  ScanSoftFlow := ScnSoftflow.Checked;
  ScanHardFlow := ScnHardFlow.Checked;
  case scnPrefixo.itemindex of
    0: ScanPrefixo := 'STX';
    1: ScanPrefixo := 'TAB';
    2: ScanPrefixo := '';
    3: ScanPrefixo := ScnPrefixoTxt.Text;
  end;
  ScanPrefixoTxt := ScnPrefixoTxt.Text;
  case scnSufixo.itemindex of
    0: ScanSufixo := 'CR';
    1: ScanSufixo := 'LF';
    2: ScanSufixo := 'CR+LF';
    3: ScanSufixo := 'ETX';
    4: ScanSufixo := '';
    5: ScanSufixo := ScnSufixoTxt.Text;
  end;
  ScanSufixoTxt := ScnSufixoTxt.Text;
  ScanPooling := ScnPooling.Text;
  WriteScannerECFINIConfig;

    //Grava Configuração da Gaveta
  GavModelo := GavtModelo.Text;
  GavPorta := GavtPorta.Text;
  GavVelocidade := GavtVelocidade.Text;
  GavDataBits := GavtDataBits.Items[GavtDataBits.itemindex];
  GavParidade := GavtParidade.Items[GavtParidade.itemindex][1];
  GavStopBits := IntToStr(GavtStopBits.itemindex);
  GavSoftFlow := GavtSoftFlow.Checked;
  GavHardFlow := GavtHardFlow.Checked;
  GavPooling := GavtPooling.Text;
  WriteGavetaINIConfig;

    //Grava Configuração do Autenticador de Documentos
  AutModelo := auteModelo.Text;
  AutPorta := auteporta.Text;
  AutVelocidade := autevelocidade.Text;
  AutDataBits := auteDataBits.Items[auteDataBits.itemindex];
  AutParidade := auteParidade.Items[auteParidade.itemindex][1];
  AutStopBits := autestopbits.Items[autestopbits.itemindex];
  AutSoftFlow := autesoftflow.Checked;
  AutHardFlow := autehardflow.Checked;
  AutPooling := autepooling.Text;
  WriteAutenticadorINIConfig;

    //Grava Configuração do Cheque
  ChqModelo := chqemodelo.Text;
  ChqPorta := chqeporta.Text;
  ChqVelocidade := chqeVelocidade.Text;
  ChqDataBits := chqeDatabits.Items[chqeDatabits.itemindex];
  ChqParidade := chqeParidade.Items[chqeParidade.itemindex][1];
  ChqStopBits := chqeStopBits.Items[chqeStopBits.itemindex];
  ChqSoftFlow := chqesoftflow.Checked;
  ChqHardFlow := chqehardflow.Checked;
  ChqPooling := chqepooling.Text;
  WriteChequeECFINIConfig;

  //Grava Configuração do Rodape e do Tipo de Relatorio
  Rodape1 := Linha1.Text;
  Rodape2 := Linha2.Text;
  Rodape3 := Linha3.Text;
  Rodape4 := Linha4.Text;
  RelModelo := CbRelModelo.Text;
  WriteRodapeECFINIConfig;
  Logotipo:=fEditLogotipo.Text;
  ChecarVale:=cbChecarVale.Checked;
  RoundPDV:=StrToInt(RxCalcEdtRoundPDV.Text);
  WriteGeneralINIConfig;

    //Grava Configuração da Balança
  BalModelo := cbBalModelo.Text;
  BalPorta := cbBalPorta.Text;
  BalVerificadorInicial := StrToInt(edBalVerificadorInicial.Text);
  BalVerificadorTamanho := StrToInt(edBalVerificadorTamanho.Text);
  BalVerificadorValor := edBalVerificadorValor.Text;
  BalTamBarra := StrToInt(edBalTamanhoBarra.Text);
  BalProdutoInicial := StrToInt(edBalProdutoInicial.Text);
  BalProdutoTamanho := StrToInt(edBalProdutoTamanho.Text);
  BalPrecoInicial := StrToInt(edBalPrecoInicial.Text);
  BalPrecoTamanho := StrToInt(edBalPrecoTamanho.Text);
  BalPrecoInicialV := StrToInt(edBalPrecoInicialVirgula.Text);
  BalPrecoTamanhoV := StrToInt(edBalPrecoTamanhoVirgula.Text);
  WriteBalancaINIConfig;
end;

procedure TfrmPDVConfig.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  PageControl1.ActivePageIndex := 0;
  //Le Configuração do ECF/PDV
  ReadECFINIConfig;
  cbecfModelo.Text        := ECFModelo;
  cbecfPorta.Text         := ECFPorta;
  cbecfVelocidade.Text    := ECFVelocidade;
  rgecfDatabits.itemindex := rgecfDatabits.Items.IndexOf(ECFDataBits);
  for I := 0 to 4 do
    if rgecfParidade.Items[I][1] = ECFParidade then
      rgecfParidade.itemindex := I;
  rgecfStopBits.itemindex := StrToInt(ECFStopBits);
  cbecfsoftflow.Checked := ECFSoftFlow;
  cbecfhardflow.Checked := ECFHardFlow;
  edecfPooling.Text := ECFPooling;

  //Le Configuração da Gaveta
  ReadGavetaINIConfig;
  GavtModelo.Text := GavModelo;
  GavtPorta.Text := GavPorta;
  GavtVelocidade.Text := GavVelocidade;
  GavtDataBits.itemindex := GavtDataBits.Items.IndexOf(GavDataBits);
  for I := 0 to 4 do
    if GavtParidade.Items[I][1] = GavParidade then
      GavtParidade.itemindex := I;
  GavtStopBits.itemindex := StrToInt(GavStopBits);
  GavtSoftFlow.Checked := GavSoftFlow;
  GavtHardFlow.Checked := GavHardFlow;
  GavtPooling.Text := GavPooling;

  //Le Configuração do Scanner
  ReadScannerECFINIConfig;
  ScnModelo.Text := ScanModelo;
  ScnPorta.Text := ScanPorta;
  ScnVelocidade.Text := ScanVelocidade;
  ScnDataBits.itemindex := ScnDataBits.Items.IndexOf(ScanDataBits);
  for I := 0 to 4 do
    if ScnParidade.Items[I][1] = ScanParidade then
      ScnParidade.itemindex := I;
  ScnStopBits.itemindex := StrToInt(ScanStopBits);
  ScnSoftflow.Checked := ScanSoftFlow;
  ScnHardFlow.Checked := ScanHardFlow;
  if ScanPrefixo = 'STX' then
    scnPrefixo.itemindex := 0
  else
    if ScanPrefixo = 'TAB' then
      scnPrefixo.itemindex := 1
    else
      if ScanPrefixo = '' then
        scnPrefixo.itemindex := 2
      else
        scnPrefixo.itemindex := 3;
  ScnPrefixoTxt.Text := ScanPrefixoTxt;
  if ScanSufixo = 'CR' then
    scnSufixo.itemindex := 0
  else
    if ScanSufixo = 'LF' then
      scnSufixo.itemindex := 1
    else
      if ScanSufixo = 'CR+LF' then
        scnSufixo.itemindex := 2
      else
        if ScanSufixo = 'ETX' then
          scnSufixo.itemindex := 3
        else
          if ScanSufixo = '' then
            scnSufixo.itemindex := 4
          else
            scnSufixo.itemindex := 5;
  ScnSufixoTxt.Text := ScanSufixoTxt;
  ScnPooling.Text := ScanPooling;

  //Le Configuração do Autenticador
  ReadAutenticadorINIConfig;
  auteModelo.Text := AutModelo;
  auteporta.Text := AutPorta;
  autevelocidade.Text := AutVelocidade;
  auteDataBits.itemindex := auteDataBits.Items.IndexOf(AutDataBits);
  for I := 0 to 4 do
    if auteParidade.Items[I][1] = AutParidade then
      auteParidade.itemindex := I;
  autestopbits.itemindex := autestopbits.Items.IndexOf(AutStopBits);
  autesoftflow.Checked := AutSoftFlow;
  autehardflow.Checked := AutHardFlow;
  autepooling.Text := AutPooling;

  //Le Configuração do Cheque
  ReadChequeECFINIConfig;
  chqemodelo.Text := ChqModelo;
  chqeporta.Text := ChqPorta;
  chqeVelocidade.Text := ChqVelocidade;
  chqeDatabits.itemindex := chqeDatabits.Items.IndexOf(ChqDataBits);
  for I := 0 to 4 do
    if chqeParidade.Items[I][1] = ChqParidade then
      chqeParidade.itemindex := I;
  chqeStopBits.itemindex := chqeStopBits.Items.IndexOf(ChqStopBits);
  chqesoftflow.Checked := ChqSoftFlow;
  chqehardflow.Checked := ChqHardFlow;
  chqepooling.Text := ChqPooling;

  //Le Configuração do Rodape e do Tipo de Relatorio
  ReadRodapeECFINIConfig;
  Linha1.Text := Rodape1;
  Linha2.Text := Rodape2;
  Linha3.Text := Rodape3;
  Linha4.Text := Rodape4;
  cbRelModelo.Text := RelModelo;

  ReadGeneralINIConfig;
  fEditLogotipo.text:=Logotipo;
  cbChecarVale.Checked:=ChecarVale;
  RxCalcEdtRoundPDV.Value:=RoundPDV;

  //Le Configuração da Balança
  ReadBalancaINIConfig;
  cbBalModelo.Text := BalModelo;
  cbBalPorta.Text := BalPorta;
  edBalVerificadorinicial.Text := IntToStr(BalVerificadorInicial);
  edBalVerificadorTamanho.Text := IntToStr(BalVerificadorTamanho);
  edBalVerificadorValor.text := BalVerificadorValor;
  edBalTamanhoBarra.Text := IntToStr(BalTamBarra);
  edBalProdutoInicial.Text := IntToStr(BalProdutoInicial);
  edBalProdutoTamanho.text := IntToStr(BalProdutoTamanho);
  edBalPrecoInicial.Text := IntToStr(BalPrecoInicial);
  edBalPrecoTamanho.text := IntToStr(BalPrecoTamanho);
  edBalPrecoInicialVirgula.Text := IntToStr(BalPrecoInicialV);
  edBalPrecoTamanhoVirgula.Text := IntToStr(BalPrecoTamanhoV);
end;

initialization
  RegisterClass(TfrmPDVConfig);
end.

