unit MvInscr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Menus, DB, IBDatabase, IBCustomDataSet,
  IBQuery, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Buttons, IBExtract,
  IBScript;

type
  TMovCnstNames = (tcFile, tcClose, tcConnect, tcDisconnect, tcSearch, tcPrint);

  TMovInscricao = class(TForm)
    MainMenu1: TMainMenu;
    miFile: TMenuItem;
    miConnect: TMenuItem;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbClose: TToolButton;
    miClose: TMenuItem;
    miSep1: TMenuItem;
    miDisconnect: TMenuItem;
    tbConnect: TToolButton;
    tbDisconnect: TToolButton;
    tbSearch: TToolButton;
    tbPrint: TToolButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Report: TMemo;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    miSep0: TMenuItem;
    miSearch: TMenuItem;
    miPrint: TMenuItem;
    procedure tbCloseClick(Sender: TObject);
    procedure tbConnectClick(Sender: TObject);
    procedure tbDisconnectClick(Sender: TObject);
    procedure tbSearchClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure FreeButtons(Status: Boolean);
    procedure MakeRecordsRead;
    procedure RetrieveRegistrations;
    procedure SaveRegistrations;
    procedure RetrieveCategories;
    procedure SaveCategories;
    procedure DeleteRemoteRecords;
  public
    { Public declarations }
  end;

var
  MovInscricao: TMovInscricao;

implementation

uses CadMod, mSysEvt, Dado, CmmConst, ProcType;

{$R *.dfm}

const
  MovConstants: array [0..Integer(High(TMovCnstNames))] of string =
    ('sFile', 'sClose', 'sConnect', 'sDisconnect', 'sSearch', 'sPrint');

procedure TMovInscricao.FreeButtons;
begin
  tbClose.Enabled      := not Status;
  miClose.Enabled      := not Status;
  tbConnect.Enabled    := not Status;
  miConnect.Enabled    := not Status;
  tbDisconnect.Enabled :=     Status;
  miDisconnect.Enabled :=     Status;
  tbSearch.Enabled     :=     Status;
  miSearch.Enabled     :=     Status;
  tbPrint.Enabled      :=     Status;
  miPrint.Enabled      :=     Status;
end;

procedure TMovInscricao.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMovInscricao.tbConnectClick(Sender: TObject);
begin
  with dmSysEvt do
  begin
    if not ibdRemote.Connected     then ibdRemote.Open;
    if not ibtRemote.InTransaction then ibtRemote.StartTransaction;
    FreeButtons(ibdRemote.Connected);
  end;
end;

procedure TMovInscricao.tbDisconnectClick(Sender: TObject);
begin
  with dmSysEvt do
  begin
    if ibtRemote.InTransaction then ibtRemote.Commit;
    if ibdRemote.Connected     then ibdRemote.Close;
    FreeButtons(ibdRemote.Connected);
  end;
end;

procedure TMovInscricao.tbSearchClick(Sender: TObject);
begin
  dmSysEvt.ibeRemote.DateFormat := dfMDY;
  tbSearch.Enabled := False;
  Report.Lines.Clear;
  Report.Lines.Add('************  Início das Transações  ***********');
  Report.Lines.Add('Marcando todos os registros das inscrições e categorias como lidos');
  try
    MakeRecordsRead;
    RetrieveRegistrations;
    SaveRegistrations;
    RetrieveCategories;
    SaveCategories;
    DeleteRemoteRecords;
  except on E:Exception do
    begin
      if dmSysEvt.ibtRemote.InTransaction then dmSysEvt.ibtRemote.Rollback;
      if Dados.Tr.InTransaction             then Dados.Tr.Rollback;
      raise Exception.Create(Dados.GetStringMessage('pt_br', 'sError', 'Erro:') +
        E.Message);
    end;
  end;
  if dmSysEvt.ibtRemote.InTransaction then dmSysEvt.ibtRemote.Commit;
  if Dados.Tr.InTransaction then Dados.Tr.Commit;
  Report.Lines.Add('');
  Report.Lines.Add('************  FINAL DAS TRANSAÇÕES  ***********');
end;

procedure TMovInscricao.MakeRecordsRead;
begin
  with dmSysEvt do
  begin
    if not ibtRemote.InTransaction then ibtRemote.StartTransaction;
    ibsRemote.Script.Clear;
    ibsRemote.Script.Add('update inscricoes set');
    ibsRemote.Script.Add(' FLAG_EXP = ''S'';');
    ibsRemote.Script.Add('update categorias_ins set');
    ibsRemote.Script.Add(' FLAG_EXP = ''S'';');
    ibsRemote.ExecuteScript;
    Report.Lines.Add('Script Executado');
    Report.Lines.Add(ibsRemote.Script.Text);
    Report.Lines.Add('');
  end;
end;

procedure TMovInscricao.RetrieveRegistrations;
var
  i: Integer;
begin
  with dmSysEvt do
  begin
    Report.Lines.Add('Buscando Dados das Inscrições');
    ibeRemote.ExtractObject(eoData, 'INSCRICOES', [etData]);
    Report.Lines.Add(ibeRemote.Items.Text);
    for i := ibeRemote.Items.Count - 1 downto 0  do
      if Pos('''N'');', ibeRemote.Items.Strings[i]) > 0 then
      begin
        Report.Lines.Add('Deletando registro: ' + IntToStr(i) + ' ==> ' +
          ibeRemote.Items.Strings[i]);
        ibeRemote.Items.Delete(i);
      end;
    Report.Lines.Add('');
  end;
end;

procedure TMovInscricao.SaveRegistrations;
var
  i: Integer;
  StrAux: string;
begin
  with dmSysEvt do
  begin
    Report.Lines.Add('Gravando os dados no Banco Local');
    if not Dados.Tr.InTransaction then Dados.Tr.StartTransaction;
    ibsLocal.Script.Clear;
    for i := 0 to ibeRemote.Items.Count - 1 do
    begin
       StrAux := ibeRemote.Items[i];
       StrAux := StringReplace(StrAux, 'INSCRICOES', 'INSCRICOES_TMP', []);
       ibsLocal.Script.Add(StrAux);
       Report.Lines.Add(StrAux);
    end;
    ibsLocal.ExecuteScript;
    Report.Lines.Add('Script Executado');
    Report.Lines.Add(ibsLocal.Script.Text);
    Report.Lines.Add('');
    Report.Lines.Add('************  FINAL DAS INSCRIÇÕES  ***********');
    Report.Lines.Add('');
  end;
end;

procedure TMovInscricao.RetrieveCategories;
var
  i: Integer;
begin
  with dmSysEvt do
  begin
    Report.Lines.Add('************  Início das Categorias  ***********');
    Report.Lines.Add('Buscando Dados das categorias');
    ibeRemote.ExtractObject(eoData, 'CATEGORIAS_INS', [etData]);
    Report.Lines.Add(ibeRemote.Items.Text);
    Report.Lines.Add('');
    for i := ibeRemote.Items.Count - 1 downto 0  do
      if Pos('''N'');', ibeRemote.Items.Strings[i]) > 0 then
      begin
        Report.Lines.Add('Deletando registro: ' + IntToStr(i) + ' ==> ' +
          ibeRemote.Items.Strings[i]);
        ibeRemote.Items.Delete(i);
      end;
    Report.Lines.Add('');
  end;
end;

procedure TMovInscricao.SaveCategories;
var
  i: Integer;
  StrAux: string;
begin
  with dmSysEvt do
  begin
    Report.Lines.Add('Gravando os dados no Banco Local');
    if not Dados.Tr.InTransaction then Dados.Tr.StartTransaction;
    ibsLocal.Script.Clear;
    for i := 0 to ibeRemote.Items.Count - 1 do
    begin
       StrAux := ibeRemote.Items[i];
       StrAux := StringReplace(StrAux, 'CATEGORIAS_INS', 'CATEGORIAS_INS_TMP', []);
       ibsLocal.Script.Add(StrAux);
    end;
    ibsLocal.Script.Add('');
    ibsLocal.Script.Add('execute procedure SAVE_TMP_DATA;');
    ibsLocal.ExecuteScript;
    Report.Lines.Add('Script Executado');
    Report.Lines.Add(ibsLocal.Script.Text);
    Report.Lines.Add('');
    Report.Lines.Add('************  FINAL DAS CATEGORIAS  ***********');
    Report.Lines.Add('');
  end;
end;

procedure TMovInscricao.DeleteRemoteRecords;
begin
  with dmSysEvt do
  begin
    Report.Lines.Add('Excluindo Inscrições e Categorias do Banco de Dados Remoto');
    ibsRemote.Script.Clear;
    ibsRemote.Script.Add('delete from categorias_ins');
    ibsRemote.Script.Add(' where FLAG_EXP = ''S'';');
    ibsRemote.Script.Add('');
    ibsRemote.Script.Add('delete from inscricoes');
    ibsRemote.Script.Add(' where FLAG_EXP = ''S'';');
    ibsRemote.Script.Add('');
    ibsRemote.ExecuteScript;
    Report.Lines.Add(ibsRemote.Script.Text);
    Report.Lines.Add('Script Executado');
  end;
end;

procedure TMovInscricao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  with dmSysEvt do
  begin
    if dsLocal.Active          then dsLocal.Close;
    if dsRemote.Active         then dsRemote.Close;
    if ibtRemote.InTransaction then ibtRemote.Commit;
    if ibdRemote.Connected     then ibdRemote.Close;
  end;
  with Dados do
  begin
    if Tr.InTransaction  then Tr.Commit;
    if Conexao.Connected then Conexao.Close;
  end;
end;

procedure TMovInscricao.FormCreate(Sender: TObject);
var
  VarMov: array of string;
  procedure FillStrings;
  begin
    miFile.Caption       := VarMov[Integer(tcFile)];
    tbClose.Caption      := VarMov[Integer(tcClose)];
    miClose.Caption      := VarMov[Integer(tcClose)];
    tbConnect.Caption    := VarMov[Integer(tcConnect)];
    miConnect.Caption    := VarMov[Integer(tcConnect)];
    tbDisconnect.Caption := VarMov[Integer(tcDisconnect)];
    miDisconnect.Caption := VarMov[Integer(tcDisconnect)];
    tbSearch.Caption     := VarMov[Integer(tcSearch)];
    miSearch.Caption     := VarMov[Integer(tcSearch)];
    tbPrint.Caption      := VarMov[Integer(tcPrint)];
    miPrint.Caption      := VarMov[Integer(tcPrint)];
  end;
begin
  SetLength(VarMov, Integer(High(TMovCnstNames)) + 1);
  Dados.GetAllStringsMessage(ParamGlobal^.LANGUAGE, ParamGlobal^.MD, ParamGlobal^.RT,
    ParamGlobal^.PR, VarMov, MovConstants);
  FillStrings;
end;

end.
