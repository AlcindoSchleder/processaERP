unit MovPdv;
interface
uses
  SultanPDV, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, ExtCtrls, ActnMan, ActnColorMaps,
  StdCtrls, ImgList, jpeg, XPMan, Mask, MovFunction;
const
  Salto = 5;

type
  TfMovPdv = class(TForm)
    sbStatus: TStatusBar;
    lTitle: TLabel;
    Image: TImage;
    XPManifest1: TXPManifest;
    pgMain: TPageControl;
    tsScreen: TTabSheet;
    lProduct: TLabel;
    lUnitPrice: TLabel;
    lQtd: TLabel;
    lValorTotal: TLabel;
    Shape: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Shape1: TShape;
    Label9: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Memo: TMemo;
    mMsg: TMemo;
    tsClose: TTabSheet;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    PanelClose: TPanel;
    PanelScreen: TPanel;
    Codigo: TEdit;
    Quantidade: TLabel;
    Descricao: TLabel;
    ValorItem: TLabel;
    Total: TLabel;
    Tempo: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CloseCaixa;
    procedure ShowIn;
    procedure ShowOut;
    procedure Help;
    procedure FormDestroy(Sender: TObject);
    procedure CodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TempoTimer(Sender: TObject);
  private
    { Private declarations }
    {Utilizado para o Controle do Caixa Livre}
    ParaDireita, ParaBaixo: Boolean;
    {Utilizado para o Controle da Venda}
    TypeVenda: Char;
    {Utilizado para o Controle do ECF}
    fSultanPDV: TSultanPDV;
    fOperador: ISultanECF_Operador;
    fCancelar: Boolean;
    FaltaValor, Descontando: Boolean;
    fDescontoPerc: Boolean;
    fDescontoValor: Currency;
    fDescontoGeral: Boolean;
    sCaixaLivre: Char;

    aFinalizadoras: ISultanECF_Finalizadoras;
    aFinalizadora: ISultanECF_Finalizadora;
    FinalVenda: Boolean;
    fTotalDesconto: Currency;
    sRodape: TStringList;
    procedure ShowFunction(aType: TFinanceFunction);
    procedure DestroyFunction(Sender: TObject);
    procedure CarregarDriverECF;
    function GetSultanPDV: TSultanPDV;
    function GetOperador: ISultanECF_Operador;
    function GetCaixaLivre: Char;
    procedure VendeItem;
    procedure FinalizarVenda;
    procedure Visualiza(aItem: ISultanECF_ItemVenda);
    function ProcurarItem(aItem: ISultanECF_ItemVenda): Boolean;
    procedure SetCancelar(const Value: Boolean);
    procedure LeituraScanner(Sender: TObject);
    procedure AbrirVenda;
    procedure LimpaCliente;
    procedure SetDescontoValor(const Valor: Currency);
    procedure SetDescontoGeral(const Valor: Boolean);
    procedure SetDescontoPerc(const Valor: Boolean);
    procedure TrataErro(aNumero: Integer; Mensagem: string; var Repetir:
      Boolean);
    procedure AppIdle(Sender: TObject; var Done: Boolean);
    procedure AppMsg(var Msg: TMsg; var Handled: Boolean);

    function CalcularTotal: Currency;
    procedure LimparVenda;
    procedure LimparTela;
    procedure AtualizaEstado;
    procedure SetCaixaLivre(CaixaLivre: Char);
  public
    { Public declarations }
    property SultanPDV: TSultanPDV read GetSultanPDV;
    property Operador: ISultanECF_Operador read GetOperador;
    property Cancelar: Boolean       read fCancelar      write SetCancelar;
    property DescontoValor: Currency read fDescontoValor write SetDescontoValor;
    property DescontoGeral: Boolean  read fDescontoGeral write SetDescontoGeral;
    property DescontoPerc: Boolean   read fDescontoPerc  write SetDescontoPerc;
    property CaixaLivre: Char        read sCaixaLivre    write SetCaixaLivre;
  end;
var
  fMovPdv: TfMovPdv;
  Cliente: ISultanECF_Cliente;
implementation
uses Dado, uGeneral, mSysPdv, uPdvConfig;
{$R *.dfm}

procedure TfMovPdv.FormCreate(Sender: TObject);
begin
  {Form}
  WindowState := wsMaximized;
  Color := clWhite;
  Align := alClient;
  BorderStyle := bsNone;
  //  pgMain.OwnerDraw  := True;
  pgMain.ActivePage := tsClose;
  lTitle.Caption := 'PDV - Sistema Processa E.R.P. Open Source';
  //dmMovtoPDV := TdmMovtoPDV.create(Application);
  //dsVenda.DataSet := dmMovtoPDV.cdsVendaItems;
  //dsVendaTotal.DataSet := dmMovtoPDV.cdsVendaTotal;
  SetCaixaLivre('S');
  FinalVenda := False;
  FaltaValor := False;
  Descontando := False;
  fTotalDesconto := 0;
  //Notebook.PageIndex := 0;
  CarregarDriverECF;
  //Nao Executar ScreenSave durante a Aplicação
  Application.OnMessage := AppMsg;
  Application.OnIdle := AppIdle;
end;

procedure TfMovPdv.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F12: ShowFunction(ffOpen);
    VK_ESCAPE:
      if pgMain.ActivePage = tsClose then
        Close
      else
        CloseCaixa;
    VK_F1: ShowMessage('F1');
    VK_F2: ShowIn;
    VK_F3: ShowOut;
    VK_F4:
      begin
        if not Assigned(frmPDVConfig) then
          frmPDVConfig := TfrmPDVConfig.Create(Application);
        try
          frmPDVConfig.ShowModal;
        finally
          FreeAndNil(frmPDVConfig);
        end;

      end;
    VK_F6:
      begin
        try
          if CalcularTotal > 0 then
          begin
            SultanPDV.ECF.Venda_CancelarAtual(Operador);
            LimparVenda;
            LimparTela;
          end
          else
            SultanPDV.ECF.Venda_CancelarUltima(Operador);
        except
          raise
            Exception.Create('Operação não permitida no meio de uma venda.');
        end;
      end;
    VK_F8:
      if Length(GavModelo) > 0 then
        SultanPDV.Gaveta.AbrirGaveta;
    VK_F9:
      if (CalcularTotal > 0) then
      begin
        //rxCalcEdValor.Visible := True;
        //pnlInformacao.Visible := True;
        //pnlInformacao.Caption := 'Dinheiro:';
        Codigo.Enabled := False;
        //rxCalcEdValor.SetFocus;
      end;
  end;
end;

procedure TfMovPdv.DestroyFunction(Sender: TObject);
begin
  PanelClose.Visible := False;
  PanelScreen.Visible := False;
  pgMain.ActivePage := tsScreen;
  if (Assigned(fMoveFunction)) then
  begin
    // pega os dados do form e armazena na memória
    // salva laçamento
    if (fMoveFunction.Visible) then
      fMoveFunction.Close;
    fMoveFunction.Free;
    fMoveFunction := nil;
  end;
end;

procedure TfMovPdv.ShowFunction(aType: TFinanceFunction);
begin
  if (not Assigned(fMoveFunction)) then
  begin
    PanelClose.Visible := True;
    fMoveFunction := TfMoveFunction.Create(Application);
    fMoveFunction.Parent := PanelClose;
    fMoveFunction.BorderStyle := bsNone;
    fMoveFunction.Align := alClient;
    fMoveFunction.OnOkClick := DestroyFunction;
  end;
  fMoveFunction.Show;
end;

procedure TfMovPdv.ShowIn;
begin
  if (not Assigned(fMoveFunction)) then
  begin
    PanelScreen.Visible := True;
    fMoveFunction := TfMoveFunction.Create(Application);
    fMoveFunction.Parent := PanelScreen;
    fMoveFunction.BorderStyle := bsNone;
    fMoveFunction.Align := alClient;
    fMoveFunction.FinanceFunction := ffIn;
    fMoveFunction.OnCancelClick := DestroyFunction;
    fMoveFunction.OnINClick := DestroyFunction;
  end;
  fMoveFunction.Show;
end;

procedure TfMovPdv.ShowOut;
begin
  if (not Assigned(fMoveFunction)) then
  begin
    fMoveFunction := TfMoveFunction.Create(Application);
    PanelScreen.Visible := True;
    fMoveFunction.Parent := PanelScreen;
    fMoveFunction.BorderStyle := bsNone;
    fMoveFunction.Align := alClient;
    fMoveFunction.FinanceFunction := ffOut;
    fMoveFunction.OnCancelClick := DestroyFunction;
    fMoveFunction.OnOutClick := DestroyFunction;
  end;
  fMoveFunction.Show;
end;

procedure TfMovPdv.CloseCaixa;
begin
  pgMain.ActivePage := tsClose;
end;

procedure TfMovPdv.Help;
begin
  ShowMessage('Help');
end;

procedure TfMovPdv.FormDestroy(Sender: TObject);
begin
  if (Assigned(fMoveFunction)) then fMoveFunction.Free;
  fMoveFunction := nil;
  if (Assigned(Dados)) then Dados.Free;
  Dados := nil;
end;

procedure TfMovPdv.CarregarDriverECF;
begin
  {Reconhecimento de Drivers do PDV}
  ReadECFINIConfig;
  ReadGavetaINIConfig;
  ReadScannerECFINIConfig;
  ReadAutenticadorINIConfig;
  ReadChequeECFINIConfig;
  ReadRodapeECFINIConfig;
  try
    sRodape := TStringList.Create;
    fSultanPDV := TSultanPDV.Create;
    if ECFModelo <> '' then
    begin
      if ECFModelo = 'Bematech_MP20_FI_II' then
        SultanPDV.ModeloECF := ecf_Bematech_MP20_FI_II;
      if ECFModelo = 'Bematech_MP40_FI_II' then
        SultanPDV.ModeloECF := ecf_Bematech_MP40_FI_II;
      if ECFModelo = 'GenericaArquivo' then
      begin
        SultanPDV.ModeloECF := ecf_GenericaArquivo;
        SultanPDV.ECF.Parametros.Values['Saida'] := ECFPorta;
        //ExtractFilePath(Application.ExeName) + 'MyPDV.txt';
      // Imagem do cupom, pode ser LPT e COM
      end;
      if ECFModelo = 'Sweda' then
        SultanPDV.ModeloECF := ecf_Sweda;
      if ECFModelo = 'Daruma_FS345' then
        SultanPDV.ModeloECF := ecf_Daruma_FS345;
      SultanPDV.ECF.Porta := ECFPorta;
      SultanPDV.ECF.Velocidade := StrToInt(ECFVelocidade);
      SultanPDV.ECF.DataBits := StrToInt(ECFDataBits);
      SultanPDV.ECF.Paridade := ECFParidade;
      SultanPDV.ECF.StopBits := StrToInt(ECFStopBits);
      SultanPDV.ECF.SoftFlow := ECFSoftFlow;
      SultanPDV.ECF.HardFlow := ECFHardFlow;
      SultanPDV.ECF.Pooling := StrToInt(ECFPooling);
      SultanPDV.ECF.OnErro := TrataErro;
      SultanPDV.ECF.Inicializar;
    end
    else
    begin
      SultanPDV.ModeloECF := ecf_Nenhuma;
      //MensagemBox('Modelo do ECF não informado',Flag_OK);
    end;

    if GavModelo <> '' then
    begin
      if GavModelo = 'GenericaArquivo' then
        SultanPDV.ModeloGaveta := gav_GenericaArquivo;
      if GavModelo = 'Menno' then
        SultanPDV.ModeloGaveta := gav_Menno;
      if GavModelo = 'Gerbo' then
        SultanPDV.ModeloGaveta := gav_Gerbo;
      if GavModelo = 'Bematech_MP20_FI_II' then
        SultanPDV.ModeloGaveta := gav_Bematech_MP20_FI_II;
      if GavModelo = 'Bematech_MP40_FI_II' then
        SultanPDV.ModeloGaveta := gav_Bematech_MP40_FI_II;
      SultanPDV.Gaveta.Porta := GavPorta;
      SultanPDV.Gaveta.Velocidade := StrToInt(GavVelocidade);
      SultanPDV.Gaveta.DataBits := StrToInt(GavDataBits);
      SultanPDV.Gaveta.Paridade := GavParidade;
      SultanPDV.Gaveta.StopBits := StrToInt(GavStopBits);
      SultanPDV.Gaveta.SoftFlow := GavSoftFlow;
      SultanPDV.Gaveta.HardFlow := GavHardFlow;
      SultanPDV.Gaveta.Pooling := StrToInt(GavPooling);
      SultanPDV.Gaveta.Inicializar;
    end
    else
      SultanPDV.ModeloGaveta := gav_Nenhuma;

    //Le Configuração do Scanner
    if ScanModelo <> '' then
    begin
      if ScanModelo = 'Serial' then
        SultanPDV.ModeloScanner := scn_Serial;
      SultanPDV.Scanner.Porta := ScanPorta;
      SultanPDV.Scanner.Velocidade := StrToInt(ScanVelocidade);
      SultanPDV.Scanner.DataBits := StrToInt(ScanDataBits);
      SultanPDV.Scanner.Paridade := ScanParidade;
      SultanPDV.Scanner.StopBits := StrToInt(ScanStopBits);
      SultanPDV.Scanner.SoftFlow := ScanSoftFlow;
      SultanPDV.Scanner.HardFlow := ScanHardFlow;
      if ScanPrefixo = 'STX' then
        SultanPDV.Scanner.Prefixo := #2
      else
        if ScanPrefixo = 'TAB' then
          SultanPDV.Scanner.Prefixo := #9
        else
          if ScanPrefixo = '' then
            SultanPDV.Scanner.Prefixo := ''
          else
            SultanPDV.Scanner.Prefixo := ScanPrefixoTxt;
      if ScanSufixo = 'CR' then
        SultanPDV.Scanner.Sufixo := #13
      else
        if ScanSufixo = 'LF' then
          SultanPDV.Scanner.Sufixo := #10
        else
          if ScanSufixo = 'CR+LF' then
            SultanPDV.Scanner.Sufixo := #13#10
          else
            if ScanSufixo = 'ETX' then
              SultanPDV.Scanner.Sufixo := #3
            else
              if ScanSufixo = '' then
                SultanPDV.Scanner.Sufixo := ''
              else
                SultanPDV.Scanner.Sufixo := ScanSufixoTxt;
      SultanPDV.Scanner.Pooling := StrToInt(ScanPooling);
      SultanPDV.Scanner.OnCodigoLido := LeituraScanner;
      SultanPDV.Scanner.Inicializar;
    end
    else
      SultanPDV.ModeloScanner := scn_Nenhuma;

    //Le Configuração do Autenticador de Documentos
    if AutModelo <> '' then
    begin
      if AutModelo = 'GenericaArquivo' then
        SultanPDV.ModeloAutenticador := aut_GenericaArquivo;
      if AutModelo = 'Bematech_MP20_FI_II' then
        SultanPDV.ModeloAutenticador := aut_Bematech_MP20_FI_II;
      if AutModelo = 'Bematech_MP40_FI_II' then
        SultanPDV.ModeloAutenticador := aut_Bematech_MP40_FI_II;
      SultanPDV.Autenticador.Porta := AutPorta;
      SultanPDV.Autenticador.Velocidade := StrToInt(AutVelocidade);
      SultanPDV.Autenticador.DataBits := StrToInt(AutDataBits);
      SultanPDV.Autenticador.Paridade := AutParidade;
      SultanPDV.Autenticador.StopBits := StrToInt(AutStopBits);
      SultanPDV.Autenticador.SoftFlow := AutSoftFlow;
      SultanPDV.Autenticador.HardFlow := AutHardFlow;
      SultanPDV.Autenticador.Pooling := StrToInt(AutPooling);
      SultanPDV.Autenticador.Inicializar;
    end
    else
      SultanPDV.ModeloAutenticador := aut_Nenhuma;

    //Le Configuração do Cheque
    if ChqModelo <> '' then
    begin
      if ChqModelo = 'GenericaArquivo' then
        SultanPDV.ModeloImpCheque := chq_GenericaArquivo;
      if ChqModelo = 'Bematech_MP40_FI_II' then
        SultanPDV.ModeloImpCheque := chq_Bematech_MP40_FI_II;
      SultanPDV.Cheque.Porta := ChqPorta;
      SultanPDV.Cheque.Velocidade := StrToInt(ChqVelocidade);
      SultanPDV.Cheque.DataBits := StrToInt(ChqDataBits);
      SultanPDV.Cheque.Paridade := ChqParidade;
      SultanPDV.Cheque.StopBits := StrToInt(ChqStopBits);
      SultanPDV.Cheque.SoftFlow := ChqSoftFlow;
      SultanPDV.Cheque.HardFlow := ChqHardFlow;
      SultanPDV.Cheque.Pooling := StrToInt(ChqPooling);
      SultanPDV.Cheque.Inicializar;
    end
    else
      SultanPDV.ModeloImpCheque := chq_Nenhuma;
    //Le Configuração do Rodape e do Tipo de Relatorio
    if RelModelo <> '' then
    begin
      if RelModelo = 'GenericaArquivo' then
        SultanPDV.ModeloEmissorRelatorio := rel_GenericaArquivo;
      if RelModelo = 'Bematech_MP20_FI_II' then
        SultanPDV.ModeloEmissorRelatorio := rel_Bematech_MP20_FI_II;
      if RelModelo = 'Bematech_MP40_FI_II' then
        SultanPDV.ModeloEmissorRelatorio := rel_Bematech_MP40_FI_II;
    end
    else
      SultanPDV.ModeloEmissorRelatorio := rel_Nenhuma;
    {Final do Reconhecimento}
  except
    raise Exception.Create('Erro no carregamento dos Driver do ECF.');
  end;
end;

procedure TfMovPdv.CodigoKeyPress(Sender: TObject; var Key: Char);
var
  sCodigo: string;
begin
  if Key = #43 {+} then
  begin
    TypeVenda := 'P';
    Key := #13;
  end;
  if Key = #13 {ENTER} then
  begin
    if trim(Codigo.Text) <> '' then
    begin
      {Codigo em Fase de Teste}
  {Codigo em Fase de Teste}
  //Checagem do Codigo de Barra se o Mesmo pertence a Balança
      if Length(BalModelo) <> 0 then
      begin
        if (Copy(Codigo.Text, BalVerificadorInicial,
          BalVerificadorTamanho) = BalVerificadorValor)
          and (Length(Codigo.Text) = BalTamBarra) then
        begin
          sCodigo := Copy(Codigo.Text, BalProdutoInicial, BalProdutoTamanho);
        end
        else
          sCodigo := Codigo.Text;
      end
      else
        sCodigo := Codigo.Text;
      {Fim da Fase de Teste}
      {with dmMovtoPDV.qry_Search, SQL do
      begin
        Close;
        Clear;
        Add('Select PRO_ID, PRO_PRECO, PRO_NOME from TPRODUTOS where PRO_ID=:PRO_ID');
        paramByName('PRO_ID').AsString := sCodigo;
        Open;
        if not IsEmpty then
        begin
          begin
            Codigo.Enabled := False;
            FaltaValor := True;
            Descricao.Caption := FieldByName('PRO_NOME').AsString;
            pnlInformacao.Visible := True;
            pnlInformacao.Caption := 'Valor do Item:';
            if (FieldByName('PRO_PRECO').AsCurrency > 0.00) then
              rxCalcEdValor.Value := FieldByName('PRO_PRECO').AsCurrency;
            rxCalcEdValor.Visible := True;
            rxCalcEdValor.SetFocus;
            Exit;
          end;
        end
        else
        begin
          Descricao.Caption := 'PRODUTO NÃO CADASTRADO!!!';
          if Application.MessageBox(PChar('Codigo do Produto não Encontrado.'
            + #13 + 'Deseja Cadastra-lo?'),
            PChar(Application.Title), MB_YESNO + MB_ICONEXCLAMATION) = mrYes
            then
          begin
            CriaFormComNome('TCadMercadorias');
          end;
        end;
        Codigo.Text := '';
        Quantidade.Caption := '1';
        Quantidade.Font.Color := clBlue;
        CalcularTotal;
      end;}
    end;
  end;

  if Key = #42 {ASTERISCO} then
  begin
    if trim(Codigo.Text) <> '' then
    begin
      Quantidade.Caption := Codigo.Text;
      Quantidade.Font.Color := clRed;
      Codigo.Text := '';
    end;
  end;

  if Key = #27 {ESC} then
  begin
    Codigo.Text := '';
    Quantidade.Caption := '1';
    Quantidade.Font.Color := clBlue;
    Descricao.Caption := '';
    fCancelar := False;
    //pnlMsgDescricao.Caption := '';
    TypeVenda := 'V';
  end;

  //if (Key = #67) or (Key = #99) then {C ou c}
  //  CancelarItem1Click(Sender);

  //if (Key = #68) or (Key = #100) then {D ou d}
  //  mnDescontosClick(Sender);

  if Key = '.' then
    Key := ',';

  if Key = #8 {BackSpace} then
    with Codigo do
    begin
      Text := Copy(Text, 1, Length(Text) - 1);
      SelStart := Length(Text);
    end;

  if not (Key in ['0'..'9', ',']) then
    Key := #0;
end;

procedure TfMovPdv.SetDescontoValor(const Valor: Currency);
begin
  fDescontoValor := Valor;
end;

procedure TfMovPdv.SetDescontoGeral(const Valor: Boolean);
begin
  fDescontoGeral := Valor;
end;

procedure TfMovPdv.SetDescontoPerc(const Valor: Boolean);
begin
  fDescontoPerc := Valor;
end;

procedure TfMovPdv.SetCaixaLivre(CaixaLivre: Char);
begin
  sCaixaLivre := CaixaLivre;
end;

procedure TfMovPdv.LimparVenda;
begin
  fTotalDesconto := 0;
  DescontoValor := 0;
  DescontoGeral := False;
  DescontoPerc := False;
  fCancelar := False;
  FinalVenda := False;
  {while dmMovtoPDV.cdsVendaItems.RecordCount > 0 do
    dmMovtoPDV.cdsVendaItems.Delete;

  while dmMovtoPDV.cdsVendaTotal.RecordCount > 0 do
    dmMovtoPDV.cdsVendaTotal.Delete;

  if ZerarXML = LimparXML then
  begin
    dmMovtoPDV.OrdenarDados;
    ZerarXML := 1;
  end;}
end;

procedure TfMovPdv.LimpaCliente;
begin
  with Cliente do
  begin
    Codigo := 0;
    RaSocial := '';
    CNPJ_CPF := '';
    IE_RG := '';
    Convenio := 0;
    NomeConvenio := '';
    Cartao := '';
    Endereco := '';
    Complemento := '';
    Bairro := '';
    CEP := '';
    Cidade := '';
    UF := '';
    Telefone := '';
    Fax := '';
    Obs := '';
  end;
end;

function TfMovPdv.GetSultanPDV: TSultanPDV;
begin
  Result := fSultanPDV;
end;

procedure TfMovPdv.AtualizaEstado;
begin
  sbStatus.Panels.Items[0].Text := 'Nenhum';
  sbStatus.Panels.Items[1].Text := 'Fechado';
  if SultanPDV.ModeloECF <> ecf_Nenhuma then
  begin
    sbStatus.Panels.Items[2].Text := FormatFloat(' Loja: 0000',
      SultanPDV.ECF.CodLoja);
    sbStatus.Panels.Items[3].Text := FormatFloat(' Caixa: 0000',
      SultanPDV.ECF.ECF);
  end
  else
  begin
    sbStatus.Panels.Items[2].Text := ' Loja: 0000';
    sbStatus.Panels.Items[3].Text := ' Caixa: 0000';
  end;

end;

function TfMovPdv.GetOperador: ISultanECF_Operador;
begin
  if not Assigned(fOperador) then
    fOperador := SultanPDV.ECF.Instancia_ISultanECF_Operador;
  Result := fOperador;
end;

function TfMovPdv.GetCaixaLivre: Char;
begin
  Result := sCaixaLivre;
end;

procedure TfMovPdv.Visualiza(aItem: ISultanECF_ItemVenda);
begin
  Descricao.Caption := aItem.Reduzida;
  ValorItem.Caption := FormatFloat('#0.00', aItem.Valor);
end;

procedure TfMovPdv.AbrirVenda;
begin
  if Length(GavModelo) > 0 then
  begin
    if SultanPDV.Gaveta.GavetaAberta then
      raise Exception.Create('Gaveta Aberta, Feche-a antes de continuar.');
  end;
  SultanPDV.ECF.Venda_Abrir(Operador, nil, Cliente);
end;

procedure TfMovPdv.VendeItem;
var
  Item: ISultanECF_ItemVenda;
  sCodigo, sPreco: string;
  Preco, PrecoCad: Real;
  Resultado, Achou, bPesavel, AtualizarProduto: Boolean;
  function TruncValue(AValue: Real; ADigit: Integer): Real;
  var
    Count: Integer;
    FDigit: Integer;
  begin
    try
      if ADigit = 0 then
        Result := AValue
      else
      begin
        FDigit := 1;
        for Count := 1 to ADigit do
        begin
          FDigit := FDigit * 10;
        end;
        Result := Trunc(AValue * FDigit) / FDigit;
      end;
    except
      Result := AValue;
    end;
  end;
begin
  {Codigo em Fase de Teste}
  Preco := 0.00;
  bPesavel := False;
  AtualizarProduto := False;
  //Checagem do Codigo de Barra se o Mesmo pertence a Balança
  if Length(BalModelo) <> 0 then
  begin
    if (Copy(Codigo.Text, BalVerificadorInicial,
      BalVerificadorTamanho) = BalVerificadorValor)
      and (Length(Codigo.Text) = BalTamBarra) then
    begin
      sCodigo := Copy(Codigo.Text, BalProdutoInicial, BalProdutoTamanho);
      sPreco := Copy(Codigo.Text, BalPrecoInicial, BalPrecoTamanho) + ',' +
        Copy(Codigo.Text, BalPrecoInicialV, BalPrecoTamanhoV);
      Preco := StrToFloat(sPreco);
      bPesavel := True;
    end
    else
      sCodigo := Codigo.Text;
  end
  else
    sCodigo := Codigo.Text;
  {Fim da Fase de Teste}
  with dmSysPdv.SqlAux, SQL do
  begin
    Close;
    Clear;
    Add('Select PRO_ID, PRO_NOME, PRO_PRECO, PRO_UNIDADE, PRO_OFERTA,');
    Add('AL_SIGLA, AL_POSICAOECF');
    Add('from TPRODUTOS P');
    Add('INNER JOIN TALIQUOTAS A ON A.AL_ID=P.AL_ID');
    Add('where PRO_ID=:PRO_ID');
    paramByName('PRO_ID').AsString := sCodigo;
    Open;
    if IsEmpty then
      Descricao.Caption := 'PRODUTO NÃO CADASTRADO!!!'
    else
    begin
      Item := SultanPDV.ECF.Instancia_ISultanECF_ItemVenda;
      Item.Barras := FieldByName('PRO_ID').AsString;
      Item.Descricao := FieldByName('PRO_NOME').AsString;
      Item.Unidade := FieldByName('PRO_UNIDADE').AsString;
      PrecoCad := FieldByName('PRO_PRECO').AsFloat;

      {if TypeVenda <> 'P' then
      begin
      if PrecoCad > 0.00 then
      begin
        if bPesavel then
          Item.Quantia := RoundNum((Preco / PrecoCad), 3)
        else
          Item.Quantia := StrToFloat(Quantidade.Caption);
      end
      else}
      if Preco > 0.00 then
      begin
        Item.Valor := Preco;
        Item.Quantia := StrToFloat(Quantidade.Caption);
      end
      else
      begin
        //Item.Valor := rxCalcEdValor.Value;
        Item.Quantia := StrToFloat(Quantidade.Caption);
      end;
      if PrecoCad <> Item.Valor then
        AtualizarProduto := True;

      //Item.Total := ; Deixar a ECF Calcular o total, Dependendo da legislacao o arredondamento difere
      Item.Pesavel := bPesavel;
      if FieldByName('PRO_OFERTA').AsBoolean then
        Item.Reduzida := '*' + Copy(FieldByName('PRO_NOME').AsString, 1, 28)
      else
        Item.Reduzida := Copy(FieldByName('PRO_NOME').AsString, 1, 29);
      //Item.Sequencia := dmSysPdv.cdsVendaItems.RecordCount + 1;
      //Por Convenção se o Produto For Pesavel, logo deve ter tres casas decimais
      Item.TresDecimais := bPesavel;

      // passa o desconto para o item comforme o tipo escolhido
      if DescontoValor <> 0 then
      begin
        if (Self.DescontoPerc) then
          Item.Desconto.Percentual := Self.DescontoValor
        else
          Item.Desconto.Valor := Self.DescontoValor;

        // Caso o desconto nao seja geral zera o desconto
        if not (DescontoGeral) then
          DescontoValor := 0;
      end;

      Item.Aliquota.Sigla := Alltrim(FieldByName('AL_SIGLA').AsString);
      Item.Aliquota.PosicaoECF := FieldByName('AL_POSICAOECF').AsInteger;

      if CalcularTotal = 0 then
        if SultanPDV.ECF.Estado <> est_VendaAberta then
        begin
          SetCaixaLivre('N');
          AbrirVenda;
        end;

      if fCancelar then
      begin
        Item.Cancelado := True;
        if not ProcurarItem(Item) then
        begin
          fCancelar := False;
          Descricao.Caption := 'Não encontrado o item para cancelar.';
          //pnlMsgDescricao.Caption := '';
          Exit;
        end;

        Resultado := SultanPDV.ECF.Venda_CancelarItem(Item);
        fCancelar := False;
        //pnlMsgDescricao.Caption := '';
        if Resultado then
        begin
          {with dmSysPdv.cdsVendaTotal do
          begin
            First;
            Achou := False;
            repeat
              begin
                if (FieldByName('Cancelado').AsBoolean = False) and
                  (FieldByName('Barra').AsString = Item.Barras) and
                  (FieldByName('Unitario').AsCurrency = Item.Valor) and
                  (FieldByName('Quantia').AsFloat = Item.Quantia) then
                begin
                  Edit;
                  FieldByName('Cancelado').AsBoolean := True;
                  Post;
                  Achou := True;
                end;
                if Eof then
                  Achou := True;
                next;
              end;
            until Achou = True;
          end;}
        end;
      end
      else
      begin
        Visualiza(Item);
        Application.ProcessMessages;
        Resultado := SultanPDV.ECF.Venda_Item(Item);
      end;

      if Resultado then
      begin
        {with dmSysPdv.cdsVendaItems do
        begin
          Append;
          FieldByName('Codigo').AsInteger := Item.Sequencia;
          FieldByName('Barra').AsString := Item.Barras;
          FieldByName('Descricao').AsString := Item.Reduzida;
          FieldByName('Unidade').AsString := Item.Unidade;
          FieldByName('Quantia').AsFloat := Item.Quantia;
          FieldByName('Unitario').AsCurrency := Item.Valor;
          FieldByName('Valor').AsCurrency := Item.total;
          FieldByName('Cancelado').AsBoolean := Item.Cancelado;
          Post;
        end;}
        if Item.Cancelado = False then
        begin
          {with dmSysPdv.cdsVendaTotal do
          begin
            Append;
            FieldByName('Codigo').AsInteger := Item.Sequencia;
            FieldByName('Barra').AsString := Item.Barras;
            FieldByName('Descricao').AsString := Item.Reduzida;
            FieldByName('Unidade').AsString := Item.Unidade;
            FieldByName('Quantia').AsFloat := Item.Quantia;
            FieldByName('Unitario').AsCurrency := Item.Valor;
            FieldByName('Valor').AsCurrency := Item.total;
            FieldByName('Cancelado').AsBoolean := Item.Cancelado;
            Post;
          end;}
        end;
      end;
    end;
    //Rotina Solicitada por Adenilson em 01/03/2005
    if AtualizarProduto = True then
    begin
      with dmSysPdv.SqlAux, SQL do
      begin
        Close;
        Clear;
        Add('update TProdutos set PRO_Preco=:Preco where PRO_ID=:Pro_ID');
        paramByName('Preco').AsFloat := Item.Valor;
        paramByName('PRO_ID').AsString := sCodigo;
        ExecSQL;
      end;
    end;
  end;
end;

procedure TfMovPdv.FinalizarVenda;
var
  dVenda: TDate;
  iNumNotaFiscal: Integer;
  fTroco, TotalVenda, fRestante: Currency;
  Mensagem: string;
begin
  fTroco := 0;
  fRestante := 0;
  dVenda := SultanPDV.ECF.DataAtual;
  if dVenda <= 0 then
  begin
    //MensagemBox('Data do PDV-ECF não Capturada, Operação Finalizada.' + #13 +
    //  'Contacte o Suporte Tecnico.', MB_OK + MB_ICONERROR);
    Exit;
  end;
  try
    Screen.Cursor := crHourGlass;
    TotalVenda := CalcularTotal;
    iNumNotaFiscal := SultanPDV.ECF.ECF;
    if FinalVenda = False then
    begin
      aFinalizadoras :=
        Self.SultanPDV.ECF.Instancia_ISultanECF_Finalizadoras;
      FinalVenda := True;
    end;
    sRodape.Clear;
    Mensagem := trim(Copy(Rodape1, 2, 50));
    if Rodape1 <> '' then
      sRodape.Add(Rodape1);
    if Rodape2 <> '' then
      sRodape.Add(Rodape2);
    if Rodape3 <> '' then
      sRodape.Add(Rodape3);
    if Rodape4 <> '' then
      sRodape.Add(Rodape4);
    //Rodape.Add('Operador: ' + FormatFloat('000', frmMain.Operador.Codigo) + '-'
    //  + frmMain.Operador.Nome);
    aFinalizadora := aFinalizadoras.Add;
    with aFinalizadora do
    begin
      Codigo := 1; //StrToInt(cedFormaPagto.Text);
      Descricao := 'Dinheiro'; //edFormaPagto.Text;
      //Valor := rxCalcEdValor.Value;//Valor Recebido
      PosicaoECF := 1; //StrToInt(cedFormaPagto.Text);

      if (aFinalizadoras.Total - TotalVenda) > 0 then
      begin
        Troco := (aFinalizadoras.Total - TotalVenda);
        fTroco := RoundNum(Troco, 2);
      end;

      if (aFinalizadoras.Total < TotalVenda) then
      begin
        fRestante := TotalVenda - aFinalizadoras.Total;
        Mensagem := 'Faltam ' + FloatToStrF(fRestante, ffCurrency, 10, 2);
        //rxCalcEdValor.Clear; //Valor Recebido
        //rxCalcEdValor.SetFocus; //Valor Recebido
        Exit;
      end;
      if (aFinalizadoras.Total - TotalVenda) > 0 then
      begin
        Troco := (aFinalizadoras.Total - TotalVenda);
        fTroco := Troco;
      end;
    end;
    if fTroco > 0.00 then
      Mensagem := 'Troco: ' + FloatToStrF(fTroco, ffCurrency, 10, 2);
    Application.ProcessMessages;

    if Length(GavModelo) > 0 then
      Self.SultanPDV.Gaveta.AbrirGaveta;
    Self.SultanPDV.ECF.Venda_Fechamento(Self.Operador, TotalVenda,
      fTotalDesconto, 0, aFinalizadoras, Cliente, sRodape);

    //dmSysPdv.GravarNotaFiscal(oCodEmpresa, 1, iNumNotaFiscal, dVenda,
    //  TotalVenda - fTotalDesconto, 0);
  finally
    if fRestante <= 0 then
    begin
      SetCaixaLivre('S');
      LimparVenda;
      LimparTela;
      ZerarXML := ZerarXML + 1;
    end;
    //pnlInformacao.Visible := False;
    //rxCalcEdValor.Visible := False;
    Codigo.Enabled := True;
    Descricao.Caption := Mensagem;
    Codigo.SetFocus;
    Screen.Cursor := crDefault;
  end;
  Application.ProcessMessages;
  ModalResult := mrOk;
end;

function TfMovPdv.CalcularTotal: Currency;
var
  b: string;
  soma: Currency;
begin
  {with dmSysPdv.cdsVendaItems do
  begin
    DisableControls;
    b := Bookmark;
    soma := 0;
    First;
    while not Eof do
    begin
      if FieldByName('Cancelado').AsBoolean then
        soma := soma - FieldByName('Valor').AsCurrency
      else
        soma := soma + (FieldByName('Valor').AsCurrency -
          FieldByName('Desconto').AsCurrency);
      next;
    end;
    Bookmark := b;
    EnableControls;
  end;}
  Result := soma - fTotalDesconto;
  Total.Caption := FormatFloat('#0.00', Result);
end;

function TfMovPdv.ProcurarItem(aItem: ISultanECF_ItemVenda): Boolean;
var
  b: string;
  I: Integer;
begin
  Result := False;
  {with dmSysPdv.cdsVendaTotal do
  begin
    DisableControls;
    b := Bookmark;
    I := 1;
    First;
    while not Eof do
    begin
      if (FieldByName('Cancelado').AsBoolean = False) and
        (FieldByName('Barra').AsString = aItem.Barras) and
        (FieldByName('Unitario').AsCurrency = aItem.Valor) and
        (FieldByName('Quantia').AsFloat = aItem.Quantia) then
      begin
        Result := True;
        aItem.Sequencia := I;
        Break;
      end;
      inc(I);
      next;
    end;
    Bookmark := b;
    EnableControls;
  end;}
end;

procedure TfMovPdv.LimparTela;
begin
  Descricao.Caption := '';
  Codigo.Text := '';
  Quantidade.Caption := '1';
  Quantidade.Font.Color := clBlue;
  ValorItem.Caption := '';
  Total.Caption := '';

  LimpaCliente;
  sbStatus.Panels.Items[4].Text := '';
end;

procedure TfMovPdv.SetCancelar(const Value: Boolean);
begin
  fCancelar := Value;
  if fCancelar then
    Descricao.Caption := 'CANCELAMENTO'
  else
    Descricao.Caption := '';
end;

procedure TfMovPdv.LeituraScanner(Sender: TObject);
begin
  if SultanPDV.ModeloScanner <> scn_Nenhuma then
  begin
    Codigo.Text := SultanPDV.Scanner.UltimoLido;
    VendeItem;
    Codigo.Text := '';
    Quantidade.Caption := '1';
    Quantidade.Font.Color := clBlue;
    CalcularTotal;
  end;
end;

procedure TfMovPdv.TrataErro(aNumero: Integer; Mensagem: string; var Repetir:
  Boolean);
begin
  Repetir := Application.MessageBox(PChar(Mensagem + #13#10 +
    'Tentar Novamente ?'),
    PChar('Erro: ' + IntToStr(aNumero)), MB_YESNO + MB_ICONERROR) = mrYes;
end;

procedure TfMovPdv.AppIdle(Sender: TObject; var Done: Boolean);
begin
  //TimerLivre.Enabled := True;
end;

function GetToggleState(Key: Integer): Boolean;
begin
  Result := Odd(GetKeyState(Key));
end;

procedure TfMovPdv.AppMsg(var Msg: TMsg; var Handled: Boolean);
begin
  if (Msg.Message = wm_SysCommand) and
    (Msg.wParam = sc_ScreenSave) then
    Handled := True;
  case Msg.Message of
    WM_LBUTTONDOWN,
      WM_RBUTTONDOWN,
      WM_KEYDOWN:
      begin
        //TimerLivre.Enabled := False;
        //TimerMovimento.Enabled := False;
        //Notebook.PageIndex := 0;
        //if (pgMain.ActivePageIndex=0) and (Codigo.Enabled = True) then
        //  Codigo.SetFocus;
      end;
  end;
end;

procedure TfMovPdv.FormShow(Sender: TObject);
begin
  if FileExists(Logotipo) then
  begin
    //ImagemLogo.Picture.LoadFromFile(Logotipo);
  end;

  // Cria o cliente para ser usado na venda
  if not Assigned(Cliente) then
    Cliente := SultanPDV.ECF.Instancia_ISultanECF_Cliente;
  LimpaCliente;
  AtualizaEstado;
  CalcularTotal;
  Tempo.Enabled := True;
end;

procedure TfMovPdv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGeneralINIConfig;
  Application.HelpCommand(HELP_QUIT, 0);
  {if dmMovtoPDV.cdsVendaItems.Active then
  begin
    //cdsVendaItems.EmptyDataSet;
    dmMovtoPDV.cdsVendaItems.Close;
  end;
  if dmMovtoPDV.cdsVendaTotal.Active then
  begin
    //cdsVendaTotal.EmptyDataSet;
    dmMovtoPDV.cdsVendaTotal.Close;
  end;}
  Tempo.Enabled := False;
  SultanPDV.Free;
  sRodape.Free;
  //dmMovtoPDV.Free;
  //dmConexao.Free;
end;

procedure TfMovPdv.TempoTimer(Sender: TObject);
begin
  sbStatus.Panels[4].Text := DateToStr(Now) + ' - ' + TimeToStr(Now);
end;

end.

