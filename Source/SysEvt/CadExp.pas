unit CadExp;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, DB, Enter, ImgList, Menus, StdCtrls, DBCtrls, ExtCtrls,
  Grids, DBGrids, ComCtrls, ToolWin, Mask, Buttons, QExportDialog, TreeFunc,
  SyncSource, Encryp, JvToolEdit, JvDBCtrl, JvCurrEdit, CheckLst, IBEvents,
  Gauges, JvPlacemnt;

type
  TCdExpositores = class(TCdModelo)
    Cadastros: TDataSource;
    TipoServicos: TDataSource;
    pcControl: TPageControl;
    tsExpositors: TTabSheet;
    tsServices: TTabSheet;
    lDta_Ctr: TLabel;
    lPk_Contratos: TLabel;
    lQtd_Srv: TLabel;
    eQtd_Srv: TJvDBCalcEdit;
    eDta_Ctr: TJvDBDateEdit;
    ePk_Contratos: TJvDBCalcEdit;
    lNum_Std: TLabel;
    eNum_Std: TJvDBCalcEdit;
    lVlr_Ctr: TLabel;
    eVlr_Ctr: TJvDBCalcEdit;
    lRua_Std: TLabel;
    Panel4: TPanel;
    lViewService: TLabel;
    clbServices: TCheckListBox;
    lFk_Tipo_Servicos: TLabel;
    eFk_Tipo_Servicos: TDBLookupComboBox;
    pnCategories: TPanel;
    lEvents: TLabel;
    tvEvents: TTreeView;
    lFk_Cadastros: TLabel;
    eFk_Cadastros: TDBLookupComboBox;
    eMtr_Std: TJvDBCalcEdit;
    lMtr_Std: TLabel;
    eRua_Std: TDBEdit;
    lNom_Std: TLabel;
    eNom_Std: TDBEdit;
    eTot_Srv: TJvDBCalcEdit;
    lTot_Srv: TLabel;
    eObs_Ctr: TDBMemo;
    lObs_Ctr: TLabel;
    fsExpSrv: TJvFormStorage;
    eSen_Exp: TDBEdit;
    lSen_Exp: TLabel;
    eLog_Exp: TDBEdit;
    lLog_Exp: TLabel;
    sbGerLog: TSpeedButton;
    eQtd_Conv: TJvDBCalcEdit;
    lQtd_Conv: TLabel;
    sbSendPasswd: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure pcControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pcControlChange(Sender: TObject);
    procedure EventosAfterOpen(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbPostClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure clbServicesClick(Sender: TObject);
    procedure tvEventsChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure tvEventsChange(Sender: TObject; Node: TTreeNode);
    procedure FormActivate(Sender: TObject);
    procedure sbGerLogClick(Sender: TObject);
    procedure sbSendPasswdClick(Sender: TObject);
  private
    { Private declarations }
    FFillBK   : Boolean;
    FBKExpositors : TBookmark;
    FSqlExpositors: string;
    procedure ConfigExpositors;
    procedure ConfigServices;
    procedure HandleTServicesAfterScroll(DataSet: TDataSet);
    procedure FreeDataclbServices;
    procedure FillclbServices;
    procedure FindListIndex;
    procedure FillTreeView(Tree: TTreeView; Table: TDataSet;
        const Fields: array of string; const Select: Boolean);
    procedure HandleReportBeforeOpen(DataSet: TDataSet);
    procedure GetSelectedEvent(Node: TTreeNode);
    procedure VerifyExpositor(Login: string);
    procedure ConfigRecords;
  protected
    procedure FechaArquivos(DS: TDataSource); override;
    procedure PesquisaRegistros; override;
    procedure OnBeforePost(Sender: TObject);
  public
    { Public declarations }
  end;

var
  CdExpositores: TCdExpositores;

implementation

uses mSysEvt, ArqSql, Dado, CmmConst, ProcType, Clipbrd, Funcoes;

{$R *.dfm}

procedure TCdExpositores.FormCreate(Sender: TObject);
begin
  FFillBK              := False;
  MoveCampos           := True;
  inherited;
  eSearch.CharCase     := ecUpperCase;
  VisibleEntrp         := False;
  tsExpositors.Caption := Dados.GetStringMessage(LANGUAGE, 'stsExpositors', 'Dados dos &Expositores no Evento');
  tsServices.Caption   := Dados.GetStringMessage(LANGUAGE, 'stsServices', '&Seleção e Preços de Servicos');
  lViewService.Caption := Dados.GetStringMessage(LANGUAGE, 'slViewService', '&Tipos de Servicos');
  sbSendPasswd.Caption := Dados.GetStringMessage(LANGUAGE, 'sbSendPasswd', '&Envia Senha Expositor');
  Dados.Image16.GetBitmap(24, sbGerLog.Glyph);
  Dados.Image16.GetBitmap(57, sbSendPasswd.Glyph);
  AfterOpen            := EventosAfterOpen;
  if pcControl.ActivePageIndex <> 0 then
    pcControl.ActivePageIndex := 0;
  Dados.Report.BeforeOpen := HandleReportBeforeOpen;
  ConfigExpositors;
end;

procedure TCdExpositores.FormActivate(Sender: TObject);
begin
  with dmSysEvt do
  begin
    if not Eventos.Active then
    begin
      Eventos.AfterScroll := EventosAfterScroll;
      Eventos.SQL.Clear;
      Eventos.SQL.Add(SqlAllEvents);
      Eventos.Open;
    end;
    FillTreeView(tvEvents, Eventos, ['DSC_TEVT=59', 'PK_EVENTOS=21'], True);
  end;
  inherited;
  sbSendPasswd.BringToFront;
end;

procedure TCdExpositores.FechaArquivos(DS: TDataSource);
begin
  with dmSysEvt do
  begin
    if TipoServicos.Active then TipoServicos.Close;
    if TipoEventos.Active  then TipoEventos.Close;
    if Eventos.Active      then Eventos.Close;
    if Cadastros.Active    then Cadastros.Close;
    TrEvt.Commit;
  end;
  inherited;
end;

procedure TCdExpositores.PesquisaRegistros;
begin
  inherited;
  with dmSysEvt do
  begin
    if not TrEvt.InTransaction then TrEvt.StartTransaction;
    if not Cadastros.Active then
    begin
      Cadastros.SQL.Clear;
      Cadastros.SQL.Add(SqlCadastros);
      Cadastros.Open;
    end;
    if not TipoServicos.Active then
    begin
      TipoServicos.SQL.Clear;
      TipoServicos.SQL.Add(SqlTipoServicos);
      TipoServicos.Open;
    end;
  end;
end;

procedure TCdExpositores.pcControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange := not (DBStatus in [dbmInsert, dbmFind, dbmEdit]);
  if AllowChange then
    SetDataAwareLink(nil, pcControl.ActivePageIndex);
end;

procedure TCdExpositores.pcControlChange(Sender: TObject);
begin
  inherited;
  if pcControl.ActivePageIndex = 1 then
    FBKExpositors          := dmSysEvt.Evento.GetBookmark;
  if FFillBK then
    FreeDataclbServices;
  inherited FechaArquivos(dsMain);
  case pcControl.ActivePageIndex of
    0 :
    begin
      if FSqlExpositors <> '' then
        DefaultSql := FSqlExpositors;
      FSqlExpositors := '';
      ConfigExpositors;
    end;
    1 : ConfigServices;
  end;
  SetDataAwareLink(@dsMain, pcControl.ActivePageIndex);
  if pcControl.ActivePageIndex = 1 then
    FillclbServices;
  if (dsMain.DataSet <> nil) then
    inherited ChangeDataSet;
  if pcControl.ActivePageIndex = 0 then
    DefaultSql := '';
end;

procedure TCdExpositores.ConfigExpositors;
const
  SYNC_WHERE  =
  ' where Exp.FK_EMPRESAS     = :Empresa    ' + #13 +
  '   and Exp.FK_TIPO_EVENTOS = :TipoEvento ' + #13 +
  '   and Exp.FK_EVENTOS      = :Evento     ';
  SYNC_FROM   =
  '  from CONTRATOS Exp                                                            ' + #13 +
  '  left outer join TIPO_EVENTOS Tev on Tev.PK_TIPO_EVENTOS = Exp.FK_TIPO_EVENTOS ' + #13 +
  '  left outer join EVENTOS      Evt on Evt.FK_EMPRESAS     = Exp.FK_EMPRESAS     ' + #13 +
  '                                  and Evt.PK_EVENTOS      = Exp.FK_EVENTOS      ' + #13 +
  '  left outer join VW_CLIENTES  Wcl on Wcl.PK_CADASTROS    = Exp.FK_CADASTROS    ';
begin
  tvEvents.Enabled := True;
  dsMain.DataSet := dmSysEvt.Expositor;
  MainFileName   := 'CONTRATOS';
  MainPrefix     := 'Exp';
  NullSql        := 'Exp.FK_EMPRESAS is null';
  DefControl     := eFk_Cadastros;
  VisibleEntrp   := False;
  PrimaryKey     := 'FK_EMPRESAS;FK_CADASTROS;PK_CONTRATOS';
  SyncFrom.Clear;
  SyncFrom.Add(SYNC_FROM);
  SyncWhere.Clear;
  SyncWhere.Add(SYNC_WHERE);
  SyncFields.Clear;
  SyncFields.Add('FK_TIPO_EVENTOS=Tev.DSC_TEVT|2');
  SyncFields.Add('FK_EVENTOS=Evt.PK_EVENTOS|3');
  SyncFields.Add('FK_CADASTROS=Wcl.RAZ_SOC|4');
  dmSysEvt.MethodWOutPar := ConfigRecords;
  with dmSysEvt do
    RegKeys.Cadastro   := 0;
end;

procedure TCdExpositores.ConfigServices;
const
  SYNC_WHERE  =
  ' where Srv.FK_EMPRESAS     = :Empresa  ' + #13 +
  '   and Srv.FK_CONTRATOS    = :Contrato ' + #13 +
  '   and Srv.FK_CADASTROS    = :Cadastro ';
  SYNC_FROM   =
  '  from SERVICOS Srv                                                                ' + #13 +
  '  left outer join VW_CLIENTES   Wcl on Wcl.PK_CADASTROS     = Srv.FK_EXPOSITORES   ' + #13 +
  '  left outer join TIPO_SERVICOS Tsr on Tsr.PK_TIPO_SERVICOS = Srv.FK_TIPO_SERVICOS ';
begin
  tvEvents.Enabled := False;                       
  dsMain.DataSet   := dmSysEvt.Servico;
  MainFileName     := 'SERVICOS';
  MainPrefix       := 'Srv';
  NullSql          := 'Srv.FK_EMPRESAS is null';
  DefControl       := eQtd_Srv;
  PrimaryKey       := 'FK_EMPRESAS;FK_CONTRATOS;FK_CADASTROS;FK_TIPO_SERVICOS';
  Search           := False;
  SyncFrom.Clear;
  SyncFrom.Add(SYNC_FROM);
  SyncWhere.Clear;
  SyncWhere.Add(SYNC_WHERE);
  SyncFields.Clear;
  SyncFields.Add('FK_CADASTROS=Wcl.RAZ_SOC|4');
  SyncFields.Add('FK_TIPO_SERVICOS=Tsr.DSC_TSRV|5');
end;

procedure TCdExpositores.HandleReportBeforeOpen(DataSet: TDataSet);
begin
  with Dados do
    if Report.Params.Count > 0 then
    begin
      if Report.Params.FindParam('Empresa') <> nil then
        Report.Params.ParamByName('Empresa').AsInteger    := Parametros.EmpresaAtiva;
      if Report.Params.FindParam('TipoEvento') <> nil then
        Report.Params.ParamByName('TipoEvento').AsInteger := dmSysEvt.RegKeys.TipoEvento;
      if Report.Params.FindParam('Evento') <> nil then
        Report.Params.ParamByName('Evento').AsInteger := dmSysEvt.RegKeys.Evento;
      if Report.Params.FindParam('Contrato') <> nil then
        Report.Params.ParamByName('Contrato').AsInteger := dmSysEvt.RegKeys.Contrato;
      if Report.Params.FindParam('Expositor') <> nil then
        Report.Params.ParamByName('Expositor').AsInteger := dmSysEvt.RegKeys.Cadastro;
    end;
end;

procedure TCdExpositores.HandleTServicesAfterScroll(DataSet: TDataSet);
begin
  FindListIndex;
  with dmSysEvt do
    RegKeys.TipoServico := TipoServicos.FieldByName('PK_TIPO_SERVICOS').AsInteger;
end;

procedure TCdExpositores.EventosAfterOpen(Sender: TObject);
begin
  if pcControl.ActivePageIndex = 0 then
    if FBKExpositors <> nil then
    begin
      try
        dmSysEvt.Evento.GotoBookMark(FBKExpositors);
        dmSysEvt.Evento.FreeBookMark(FBKExpositors);
      except
        FBKExpositors := nil;
      end;
    end
    else
  else
    FSqlExpositors := dmSysEvt.Expositor.CommandText;
end;

procedure TCdExpositores.FillclbServices;
var
  i: Integer;
  Check: Boolean;
  BK: TBookMark;
begin
  with dmSysEvt do
  begin
    if not TipoServicos.Active then
    begin
      TipoServicos.SQL.Clear;
      TipoServicos.SQL.Add(SqlTipoServicos);
      TipoServicos.Open;
    end;
    TipoServicos.First;
    while not TipoServicos.Eof do
    begin
      BK := TipoServicos.GetBookmark;
      clbServices.AddItem(TipoServicos.FieldByName('DSC_TSRV').AsString, BK);
      i                          := clbServices.Items.Count - 1;
      RegKeys.TipoServico        := TipoServicos.FieldByName('PK_TIPO_SERVICOS').AsInteger;
      Check                      := LocalizaServicos;
      clbServices.Checked[i]     := Check;
      clbServices.ItemEnabled[i] := not Check;
      TipoServicos.Next;
    end;
  end;
  FFillBK := True;
  dmSysEvt.TipoServicos.AfterScroll := HandleTServicesAfterScroll;
end;

procedure TCdExpositores.FreeDataclbServices;
var
  i : Integer;
  BK: TBookMark;
begin
  dmSysEvt.TipoServicos.AfterScroll := nil;
  with dmSysEvt do
  begin
    clbServices.ItemIndex := 0;
    for i := 0 to clbServices.Items.Count - 1 do
    begin
      BK := clbServices.Items.Objects[i];
      try
        TipoServicos.GotoBookmark(BK);
        TipoServicos.FreeBookmark(BK);
      except
        Continue;
      end;
    end;
  end;
  clbServices.Clear;
end;

procedure TCdExpositores.tbCancelClick(Sender: TObject);
var
  Check: Boolean;
begin
  inherited;
  if pcControl.ActivePageIndex = 1 then
  begin
    Check := dmSysEvt.LocalizaServicos;
    clbServices.Checked[clbServices.ItemIndex]     := Check;
    clbServices.ItemEnabled[clbServices.ItemIndex] := not Check;
  end;
end;

procedure TCdExpositores.tbPostClick(Sender: TObject);
begin
  if pcControl.ActivePageIndex = 1 then
  begin
    with dmSysEvt do
    begin
      try
       RegKeys.TipoServico := TipoServicos.FieldByName('PK_TIPO_SERVICOS').AsInteger;
       Servico.FieldByName('FK_TIPO_SERVICOS').AsInteger := RegKeys.TipoServico;
       clbServices.ItemEnabled[clbServices.ItemIndex] := False;
      except on E:Exception do
        begin
          Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE,
            'sPostError', 'Erro: Ocorreu um erro ao gravar o registro na tabela %s '),
            [dsMain.DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
           MB_OK + MB_ICONSTOP);
          exit;
        end;
      end;
    end;
  end;
  inherited;
end;

procedure TCdExpositores.OnBeforePost(Sender: TObject);
begin
  if eRua_Std.ReadOnly then
    ShowMessage('eRua_Str ReadOnly');
  if eNum_Std.ReadOnly then
    ShowMessage('eNum_Str ReadOnly');
end;

procedure TCdExpositores.tbDeleteClick(Sender: TObject);
begin
  if PcControl.ActivePageIndex = 1 then
  begin
    FindListIndex;
    clbServices.ItemEnabled[clbServices.ItemIndex] := True;
    clbServices.Checked[clbServices.ItemIndex]     := False;
  end;
  inherited;
end;

procedure TCdExpositores.clbServicesClick(Sender: TObject);
var
  i: Integer;
  KeyValue: Variant;
begin
  inherited;
  if DBStatus = dbmBrowse then
  begin
    i := clbServices.ItemIndex;
    if (clbServices.Items.Objects[i] <> nil) and
       (not clbServices.ItemEnabled[i])      then
    begin
      dmSysEvt.TipoServicos.GotoBookmark(clbServices.Items.Objects[i]);
      KeyValue := dmSysEvt.TipoServicos.FieldByName('PK_TIPO_SERVICOS').Value;
      dmSysEvt.Servico.Locate('FK_TIPO_SERVICOS', KeyValue, []);
    end
    else
      if (clbServices.Checked[i])     and
         (clbServices.ItemEnabled[i]) then
      begin
        DBStatus := dbmInsert;
        clbServices.Selected[i] := True;
        with dmSysEvt do
        begin
          TipoServicos.GotoBookmark(clbServices.Items.Objects[i]);
          RegKeys.TipoServico := TipoServicos.FieldByName('PK_TIPO_SERVICOS').AsInteger;
          Servico.FieldByName('FK_TIPO_SERVICOS').AsInteger := RegKeys.TipoServico;
        end;
      end;
  end;
end;

procedure TCdExpositores.FindListIndex;
var
  i: Integer;
begin
  inherited;
  for i := 0 to clbServices.Count - 1 do
    if AnsiCompareStr(PAnsiChar(clbServices.Items.Objects[i])^,
                      dmSysEvt.TipoServicos.Bookmark)              = 0 then
      break;
  if (i > -1) and (i < clbServices.Count) then
    clbServices.Selected[i] := True;
end;

procedure TCdExpositores.tvEventsChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange := DBStatus = dbmBrowse;
end;

procedure TCdExpositores.tvEventsChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if (Node.Data <> nil) and (tvEvents.Tag <> TvEvents.Selected.AbsoluteIndex) then
  begin
    tvEvents.Tag := TvEvents.Selected.AbsoluteIndex;
    GetSelectedEvent(Node);
    if dsMain.DataSet.Active then
    begin
      Search := False;
      inherited ChangeDataSet;
    end;
  end;
end;

procedure TCdExpositores.FillTreeView(Tree: TTreeView; Table: TDataSet;
  const Fields: array of string; const Select: Boolean);
begin
  tvEvents.AutoExpand := True;
  Tree.Items.BeginUpdate;
  Tree.Items.Clear;
  Table.First;
  while not Table.Eof do
  begin
    TreeAddItem(Tree, GetFieldList(Table, Fields), Table.GetBookmark, False);
    Table.Next;
  end;
  Tree.Alphasort;
  Tree.Items.EndUpdate;
//  Select last event after close the form (saved in the SysConfig.ini file)
  tvEvents.OnChanging := nil;
  tvEvents.OnChange   := nil;
  if Select then
    if (Tree.Tag > 0) and (Tree.Items.Count >= Tree.Tag) then
      Tree.Items[Tree.Tag].Selected := True
    else
      if Tree.Items.Count > 0 then
        Tree.Items[1].Selected := True;
  tvEvents.OnChanging := tvEventsChanging;
  tvEvents.OnChange   := tvEventsChange;
  tvEvents.AutoExpand := False;
  GetSelectedEvent(Tree.Selected);
end;

procedure TCdExpositores.GetSelectedEvent(Node: TTreeNode);
begin
  with dmSysEvt do
    if Node.Data <> nil then
    begin
      Eventos.GotoBookmark(Node.Data);
      RegKeys.Contrato := Eventos.FieldByName('PK_TIPO_EVENTOS').AsInteger;
      RegKeys.Evento     := Eventos.FieldByName('PK_EVENTOS').AsInteger;
    end;
end;

procedure TCdExpositores.sbGerLogClick(Sender: TObject);
var
  Login : string;
begin
  inherited;
  Login  := dmSysEvt.Cadastros.FieldByName('RAZ_SOC').AsString;
  Login := StrPas(StrLower(PAnsiChar(Login)));
  Login := ClearChar(Login, ' ');
  Login := Trim(Copy(Login, 1, 10));
  if not (DBStatus in [dbmInsert, dbmEdit]) then
  begin
    DBStatus := dbmEdit;
    VerifyExpositor(Login);
  end
  else
    VerifyExpositor(Login);
end;

procedure TCdExpositores.VerifyExpositor(Login: string);
var
  Password: string;
begin
  with dmSysEvt do
  begin
    if Expositor.FieldByName('LOG_EXP').AsString <> '' then
      if Application.MessageBox('Deseja Substituir o Login do Expositor?',
         PAnsiChar(Application.Title), MB_ICONINFORMATION + MB_YESNO) = mrYes then
        Expositor.FieldByName('LOG_EXP').AsString := Login
      else
    else
      Expositor.FieldByName('LOG_EXP').AsString := Login;
    Password := GeneratePassword(6);
    Crypto.Input      := Password;
    Crypto.Key        := Password;
    Crypto.TypeCipher := tcUnix;
    Crypto.Action     := atCrypto;
    Crypto.Execute;
    Expositor.FieldByName('SEN_EXP').AsString      := Password;
    Expositor.FieldByName('SENHA_CRIPTO').AsString := Crypto.Output;
  end;
end;

procedure TCdExpositores.sbSendPasswdClick(Sender: TObject);
begin
  inherited;
  if dmSysEvt.Cadastros.FindField('EMAIL_CAD') <> nil then
  begin
    Clipboard.AsText := Clipboard.AsText + #13 + #10 +
      'Login: ' + dmSysEvt.Expositor.FindField('LOG_EXP').AsString + #13 + #10 +
      'Senha: ' + dmSysEvt.Expositor.FindField('SEN_EXP').AsString;
    SendMail(dmSysEvt.Cadastros.FindField('EMAIL_CAD').AsString);
  end;
end;

procedure TCdExpositores.ConfigRecords;
begin
  sbSendPasswd.Enabled := not (DBStatus in [dbmInsert, dbmEdit, dbmFind]);
end;

end.
