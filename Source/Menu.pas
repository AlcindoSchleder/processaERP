unit Menu;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.1.0.0                                                      *}
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
  SysUtils, Classes, Graphics, Controls, Forms, Windows, Dialogs, Buttons,
  Menus, StdCtrls, ExtCtrls, ComCtrls, ToolWin, shForm, ProcType, FuncoesDB,
  Messages, VirtualTrees, PrcPrgms, JvXPCore, JvXPBar, JvXPContainer,
  JvExControls, JvComponent, ClientMsg;

type

  { TAgentThread }

  TAgentAction = (aaCreate, aaDestroy);

  TAgentThread = class(TThread)
  private
    FLibName       : string;
    FAgentAction   : TAgentAction;
    LibAgentHandle : LongWord;
    FFormAgent     : TForm;
    procedure LoadAgentLib;
    procedure UnLoadAgentLib;
  protected
    procedure Execute; override;
  public
    constructor Create(ALibName: string);
    destructor  Destroy; override;
    property  LibName    : string       read FLibName     write FLibName;
    property  AgentAction: TAgentAction read FAgentAction write FAgentAction;
    property  FormAgent  : TForm        read FFormAgent   write FFormAgent;
  end;

  { TfProcessa }

  TfProcessa = class(TForm)
    mAjuda: TPopupMenu;
    mTopicos: TMenuItem;
    mConteudo: TMenuItem;
    N2: TMenuItem;
    mSobre: TMenuItem;
    sbStatus: TStatusBar;
    pLeft: TPanel;
    Splitter1: TSplitter;
    vtModulos: TVirtualStringTree;
    pClient: TPanel;
    vtProgramas: TVirtualStringTree;
    Menu: TMenuProcess;
    mmMenu: TMainMenu;
    miSystem: TMenuItem;
    xpContainer: TJvXPContainer;
    xpTools: TJvXPBar;
    imLogo: TImage;
    miTools: TMenuItem;
    miSchedulle: TMenuItem;
    miSelCompany: TMenuItem;
    miHelp: TMenuItem;
    miTopic: TMenuItem;
    miContent: TMenuItem;
    N1: TMenuItem;
    miAbout: TMenuItem;
    xpMessages: TJvXPBar;
    lbMessage: TListBox;
    xpHelp: TJvXPBar;
    miMessages: TMenuItem;
    N3: TMenuItem;
    miClose: TMenuItem;
    procedure tbEmpresaClick(Sender: TObject);
    procedure tbMinimizeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mSobreClick(Sender: TObject);
    procedure mTopicosClick(Sender: TObject);
    procedure mConteudoClick(Sender: TObject);
    procedure sbSairClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tbActiveSchelduleClick(Sender: TObject);
    procedure WMGetMsgUser(var Msg: TMessage); message WM_USER;
    procedure MenuBeforeExecLib(const ALibName,
      AEntryPointName: String; var AParameters: Pointer);
    procedure MenuPressExitKey(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuSelectProgram(ASender: TObject; AProgram: TProgram);
    procedure MenuAfterExecLib(const ALibName, AEntryPointName: String;
      var AParameters: Pointer);
    procedure bCloseClick(Sender: TObject);
    procedure MenuBeforeShowFrm(Sender: TObject; AProgram: TProgram;
      AForm: TForm);
    procedure MenuAfterShowFrm(Sender: TObject; AProgram: TProgram;
      AForm: TForm);
    procedure xpMessagesCollapsedChange(Sender: TObject;
      Collapsing: Boolean);
    procedure miMessagesClick(Sender: TObject);
    procedure lbMessageDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ChatClientRcv(Sender: TObject; Buf: PAnsiChar;
                var DataLen: Integer);
  private
    { Private declarations }
    FAgentThread   : TAgentThread;
    FMenuData      : TMenuData;
    FMonitorPasswd : string;
    FOperator      : string;
    FPassword      : string;
    frmClientChat  : TfrmClientChat;
    FPrograma      : Integer;
    FReport        : Integer;
    procedure LoadPrograms(AProgramList: TProgramList; AModule, ARotine: Integer);
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure GetLogoEmpresa;
    procedure CreateChatForm;
  public
    { Public declarations }
    MsgHandle      : Cardinal;
    RodaPrograma   : TRodaPrograma;
    function  SetMemoryParams : Pointer;
    function  FreeMemoryParams: Pointer;
    property Operator: string read FOperator write FOperator;
    property Password: string read FPassword write FPassword;
  end;

var
  fProcessa: TfProcessa;

implementation

{$R *.dfm}

uses Senha, Funcoes, Sobre, CmmConst, SelEmpr, mArqSql,
  mMenu, Dado, DB, SqlComm, TypInfo;

constructor TAgentThread.Create(ALibName: string);
begin
  FLibName     := sDoth + sPathSep + ALibName + SPCKEXT;
  FAgentAction := aaCreate;
  inherited Create(False);
end;

destructor  TAgentThread.Destroy;
begin
  FAgentAction := aaDestroy;
  Execute;
  inherited Destroy;
end;

procedure TAgentThread.Execute;
begin
  case FAgentAction of
    aaCreate : Synchronize(LoadAgentLib);
    aaDestroy: Synchronize(UnloadAgentLib);
  end;
end;

procedure TAgentThread.LoadAgentLib;
var
  aError: Boolean;
  aClass: TClass;
begin
  LibAgentHandle := LoadPackage(FLibName);
  FFormAgent := nil;
  if LibAgentHandle <> 0 then
  begin
    aClass := GetClass('TCdAgenda');
    aError := (aClass = nil);
    if (not aError) then
    begin
      Application.CreateForm(TFormClass(aClass), FFormAgent);
//      FFormAgent := TFormClass(aClass).Create(Application);
      SetPropValue(FFormAgent, 'ActiveTrayIcon', True);
    end;
    if aError then
      Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE,
        'sNoProgram'), [dmMenu.qrProgramas.FindField('DSC_PRG').AsString,
        dmMenu.qrProgramas.FindField('NOM_FRM').AsString,
        FLibName])), PAnsiChar(fProcessa.Caption), MB_OK + MB_ICONERROR);
  end
  else
    raise Exception.CreateFmt('Menu: Package %s not found', [FLibName]);
end;

procedure TAgentThread.UnLoadAgentLib;
begin
  if Assigned(FFormAgent) then
     FFormAgent.Free;
  FFormAgent := nil;
  if (LibAgentHandle <> 0) then
    UnloadPackage(LibAgentHandle);
end;

{ TfProcessa }

procedure TfProcessa.FormCreate(Sender: TObject);
begin
  xpTools.ImageList         := Dados.Image16;
  xpHelp.ImageList          := Dados.Image16;
  xpMessages.ImageList      := Dados.Image16;
  vtModulos.Images          := Dados.Image16;
  vtModulos.Header.Images   := Dados.Image16;
  vtProgramas.Images        := Dados.Image16;
  vtProgramas.Header.Images := Dados.Image16;
  mmMenu.Images             := Dados.Image16;
  mAjuda.Images             := Dados.Image16;
  CreateChatForm;
  MsgHandle := RegisterWindowMessage(PChar(Application.Title));
  DBOptions.dboLoginPrompt  := True;
end;

procedure TfProcessa.tbEmpresaClick(Sender: TObject);
begin
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    SelEmpresa.Free;
  end;
  GetLogoEmpresa;
end;

procedure TfProcessa.tbMinimizeClick(Sender: TObject);
begin
  Application.Minimize;
end;

function TfProcessa.SetMemoryParams: Pointer;
begin
  Result := nil;
  with Dados do
  begin
    Parametros.soUserOperation := AchaNivel(fProcessa.FMenuData);
    Parametros.soPkModule      := Menu.ActiveProgram.Module;
    Parametros.soPkRotine      := Menu.ActiveProgram.Rotine;
    Parametros.soPkProgram     := FPrograma;
    Parametros.soProgramReport := Menu.ActiveProgram.Report;
    Parametros.soProgramTitle  := Menu.ActiveProgram.ProgramName;
    Parametros.soProgramForm   := Menu.ActiveProgram.FormName;
    Parametros.soToMail        := 'alcindo@sistemaprocessa.com.br';
  end;
end;

function  TfProcessa.FreeMemoryParams: Pointer;
begin
  Result := nil;
end;

procedure TfProcessa.LoadPrograms(AProgramList: TProgramList; AModule, ARotine: Integer);
var
  IdxPrg: Integer;
begin
  if (AProgramList = nil) then exit;
  with dmMenu do
  begin
    Dados.Parametros.soPkModule := AModule;
    Dados.Parametros.soPkRotine := ARotine;
    if qrProgramas.Active     then qrProgramas.Close;
    qrProgramas.SQL.Clear;
    qrProgramas.SQL.Add(SqlProgram);
    if not qrProgramas.Active then qrProgramas.Open;
    if qrProgramas.IsEmpty then exit;
    qrProgramas.First;
    if fProcessa.Menu.Operator = '' then
    begin
      fProcessa.Menu.Operator     := qrProgramas.FindField('FK_OPERADORES').AsString;
      fProcessa.Menu.OperatorMail := qrProgramas.FindField('EMAIL_OPE').AsString;
      fProcessa.Menu.OperatorID   := qrProgramas.FindField('FK_CADASTROS').AsInteger;
    end;
    while not qrProgramas.Eof do
    begin
      IdxPrg := AProgramList.Add.Index;
      AProgramList.Items[IdxPrg].Module := AModule;
      AProgramList.Items[IdxPrg].Rotine := ARotine;
      with AProgramList.Items[IdxPrg] do
      begin
        ProgramID   := qrProgramas.FindField('PK_PROGRAMAS').AsInteger;
        ProgramName := qrProgramas.FindField('DSC_PRG').AsString;
        FlagBrw     := Boolean(qrProgramas.FindField('FLAG_BRW').AsInteger);
        FlagIns     := Boolean(qrProgramas.FindField('FLAG_INS').AsInteger);
        FlagUpd     := Boolean(qrProgramas.FindField('FLAG_UPD').AsInteger);
        FlagFnd     := Boolean(qrProgramas.FindField('FLAG_FND').AsInteger);
        FlagDel     := Boolean(qrProgramas.FindField('FLAG_DEL').AsInteger);
        ShowMenu    := Boolean(qrProgramas.FindField('FLAG_VIS').AsInteger);
        FormName    := qrProgramas.FindField('NOM_FRM').AsString;
        LibraryName := qrProgramas.FindField('NOM_LIB').AsString;
        Report      := qrProgramas.FindField('FK_RELATORIOS').AsInteger;
        ReportName  := qrProgramas.FindField('DSC_PRG').AsString;
        IsReport    := False;
        ShowModal   := True;
      end;
      qrProgramas.Next;
    end;
  end;
end;

procedure TfProcessa.FormActivate(Sender: TObject);
var
  ModAnt   : string;
  Idx, Idx2: Integer;
begin
  if vtModulos.RootNodeCount > 0 then exit;
  ModAnt    := '';
  Idx       := -1;
  with dmMenu do
  begin
    qrModulos.First;
    while not qrModulos.Eof do
    begin
      if qrModulos.FindField('DSC_MOD').AsString = ModAnt then
      begin
        if Idx > -1 then
        begin
          with Menu.ModuleList.Items[Idx].RotineList do
          begin
            Idx2 := Add.Index;
            Items[Idx2].Module := Menu.ModuleList.Items[Idx].Module;
            Items[Idx2].Rotine := qrModulos.FindField('FK_ROTINAS').AsInteger;
            Items[Idx2].RotineName := qrModulos.FindField('DSC_ROT').AsString;
            LoadPrograms(Items[idx2].ProgramList, Items[Idx2].Module, Items[Idx2].Rotine);
          end;
        end;
      end
      else
      begin
        Idx := Menu.ModuleList.Add.Index;
        Menu.ModuleList.Items[idx].Module     := qrModulos.FindField('FK_MODULOS').AsInteger;
        Menu.ModuleList.Items[idx].ModuleName := qrModulos.FindField('DSC_MOD').AsString;
        if Idx > -1 then
        begin
          with Menu.ModuleList.Items[Idx].RotineList do
          begin
            Idx2 := Add.Index;
            Items[Idx2].Module := Menu.ModuleList.Items[Idx].Module;
            Items[Idx2].Rotine := qrModulos.FindField('FK_ROTINAS').AsInteger;
            Items[Idx2].RotineName := qrModulos.FindField('DSC_ROT').AsString;
            LoadPrograms(Items[idx2].ProgramList, Items[Idx2].Module, Items[Idx2].Rotine);
          end;
        end;
      end;
      ModAnt := qrModulos.FindField('DSC_MOD').AsString;
      qrModulos.Next;
    end; // while
  end; //with
  Menu.LoadMenus;
  if vtProgramas.RootNodeCount > 0 then
    vtProgramas.SetFocus;
  if not vtModulos.RootNodeCount > 0 then
  begin
    vtModulos.Selected[vtModulos.GetFirst] := True;
    vtModulos.Expanded[vtModulos.GetFirst] := True;
  end;
  Dados.Parametros.soTitle := Dados.GetStringMessage(LANGUAGE, 'sProcCaption') + ProgramVersion;
  Caption := Dados.Parametros.soTitle;
  with dmMenu do
  begin
    if qrModulos.Active   then qrModulos.Close;
    if qrProgramas.Active then qrProgramas.Close;
    if qrParametros.Active then qrParametros.Close;
    if qrParamGlb.Active  then qrParamGlb.Close;
  end;
  GetLogoEmpresa;
  xpTools.Items[0].Enabled := dmMenu.GetUserResources(Dados.Parametros.soUser);
  if (xpTools.Items[0].Enabled) and (DBOptions.dboLoginPrompt) then
    tbActiveSchelduleClick(xpTools.Items[0])
end;

procedure TfProcessa.mSobreClick(Sender: TObject);
begin
  Application.CreateForm(TfrmAboutProcessa, frmAboutProcessa);
  try
    frmAboutProcessa.ShowModal;
  finally
    frmAboutProcessa.Free;
  end;
end;

procedure TfProcessa.mTopicosClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TfProcessa.mConteudoClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TfProcessa.sbSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfProcessa.WMSysCommand(var Message: TWMSysCommand);
begin
  if (Message.CmdType and $FFF0 = SC_MINIMIZE) then
    Application.Minimize
  else
    inherited;
end;

procedure TfProcessa.FormDestroy(Sender: TObject);
begin
  Menu.ClearMenuPrograms;
  Menu.ClearMenuModules;
  Menu.Free;
  if Assigned(FAgentThread) then
  begin
    FAgentThread.Free;
    FAgentThread := nil;
  end;
  frmClientChat.Free;
  frmClientChat := nil;
end;

procedure TfProcessa.tbActiveSchelduleClick(Sender: TObject);
begin
  if TJvXPBarItem(Sender).Tag = 0 then
  begin
    FAgentThread := TAgentThread.Create(AGENTLIB);
    TJvXPBarItem(Sender).Tag := 1;
    TJvXPBarItem(Sender).Caption := 'Desativar Agenda';
  end
  else
  begin
    if Assigned(FAgentThread) then
      FAgentThread.Free;
    FAgentThread := nil;
    TJvXPBarItem(Sender).Tag := 0;
    TJvXPBarItem(Sender).Caption := 'Ativar Agenda';
  end;
  if TJvXPBarItem(Sender).Tag = 2 then
    mSobre.Click;
end;

procedure TfProcessa.WMGetMsgUser(var Msg: TMessage);
begin
  if (Msg.WParam = -1) and (xpTools.Items[0].Tag <> 0) then
  begin
    Msg.WParam := 0;
    tbActiveSchelduleClick(xpTools.Items[0])
  end;
end;

procedure TfProcessa.MenuBeforeExecLib(const ALibName,
  AEntryPointName: string; var AParameters: Pointer);
begin
  AParameters := SetMemoryParams;
end;

procedure TfProcessa.MenuPressExitKey(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Close;
end;

procedure TfProcessa.MenuSelectProgram(ASender: TObject;
  AProgram: TProgram);
begin
  if AProgram = nil then exit;
  FPrograma := AProgram.ProgramID;
  FReport   := AProgram.Report;
  FMenuData.FlagBrw := AProgram.FlagBrw;
  FMenuData.FlagFnd := AProgram.FlagFnd;
  FMenuData.FlagIns := AProgram.FlagIns;
  FMenuData.FlagUpd := AProgram.FlagUpd;
  FMenuData.FlagDel := AProgram.FlagDel;
  vtProgramas.Hint  := Format('Programa %s na biblioteca %s',
    [AProgram.ProgramName, AProgram.LibraryName]);
end;

procedure TfProcessa.MenuAfterExecLib(const ALibName,
  AEntryPointName: string; var AParameters: Pointer);
begin
  if Assigned(AParameters) then
    AParameters := FreeMemoryParams;
end;

procedure TfProcessa.GetLogoEmpresa;
begin
  with Dados do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlEmpresa);
    qrSqlAux.ParamByName('PkEmpresas').AsInteger := Parametros.soActiveCompany;
    try
      if not qrSqlAux.Active then qrSqlAux.Open;
      if (not qrSqlAux.IsEmpty) then
        GetImage_FromStream(TBlobField(qrSqlAux.FieldByName('LOGO_EMP')), imLogo);
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
end;

procedure TfProcessa.bCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfProcessa.MenuBeforeShowFrm(Sender: TObject; AProgram: TProgram;
  AForm: TForm);
var
  aProp : string;
  aValue: Variant;
begin
  SetMemoryParams;
  if (Assigned(AForm)) then
  begin
    with dmMenu do
    begin
      if qrParamPrg.Active then qrParamPrg.Close;
      qrParamPrg.SQL.Clear;
      qrParamPrg.SQL.Add('select * from PARAMETROS_PRG');
      qrParamPrg.SQL.Add(' where FK_MODULOS   = :FkModulos');
      qrParamPrg.SQL.Add('   and FK_ROTINAS   = :FkRotinas');
      qrParamPrg.SQL.Add('   and FK_PROGRAMAS = :FkProgramas');
      if qrParamPrg.Params.FindParam('FkModulos') <> nil then
        qrParamPrg.ParamByName('FkModulos').AsInteger := Menu.ActiveProgram.Module;
      if qrParamPrg.Params.FindParam('FkRotinas') <> nil then
        qrParamPrg.ParamByName('FkRotinas').AsInteger := Menu.ActiveProgram.Rotine;
      if qrParamPrg.Params.FindParam('FkProgramas') <> nil then
        qrParamPrg.ParamByName('FkProgramas').AsInteger := FPrograma;
      if not qrParamPrg.Active then qrParamPrg.Open;
      while (not qrParamPrg.Eof) do
      begin
        aProp  := qrParamPrg.FieldByName('NOM_PROP').AsString;
        aValue := qrParamPrg.FieldByName('VAL_PROP').AsString;
        if GetProperty(AForm, aProp) then
          SetPropValue(AForm, aProp, aValue);
        qrParamPrg.Next;
      end;
      if qrParamPrg.Active then qrParamPrg.Close;
    end;
  end;
end;

procedure TfProcessa.MenuAfterShowFrm(Sender: TObject; AProgram: TProgram;
  AForm: TForm);
begin
  if Assigned(AForm) then
    AForm.Tag := 0;
  FreeMemoryParams;
end;

procedure TfProcessa.xpMessagesCollapsedChange(Sender: TObject;
  Collapsing: Boolean);
begin
  lbMessage.Visible := Collapsing;
end;

procedure TfProcessa.miMessagesClick(Sender: TObject);
begin
  if not Assigned(frmClientChat) then
    CreateChatForm;
//  FSenha.SkinData.SkinForm(frmClientChat.Handle);
//  frmClientChat.ShowModal;
end;

procedure TfProcessa.CreateChatForm;
begin
{  frmClientChat := TfrmClientChat.Create(Self);
  frmClientChat.Hide;
  with frmClientChat do
  begin
    ChatClient.OnReceive := ChatClientRcv;
    try
      if not ChatClient.Active then
        ChatClient.Open;
    except on E:Exception do
      begin
        lstClientActivity.Items.Add('Client: Error: ' + E.Message);
      end;
    end;
  end;}
end;

procedure TfProcessa.ChatClientRcv(Sender: TObject;
  Buf: PAnsiChar; var DataLen: Integer);
var
  ReadText : string;
const
  StatusDateTimeFormat = 'mm/dd/yyyy" - "hh:nn:ss:zzz AM/PM';
begin
  ReadText := frmClientChat.ChatClient.Receiveln;
  frmClientChat.lstClientActivity.Items.Add('Client: Read ' +
    FormatDateTime(StatusDateTimeFormat, Now));
  if (not (ReadText[1] in ['"', '*'])) then
    lbMessage.Items.Append(ReadText);
end;

procedure TfProcessa.lbMessageDblClick(Sender: TObject);
var
  aIdx: Integer;
begin
  aIdx := lbMessage.ItemIndex;
  if (aIdx > -1) and (lbMessage.Items.Count > aIdx) then
    ShowMessage(lbMessage.Items[aIdx]);
end;

procedure TfProcessa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Key := 0;
    Close;
  end;
end;

procedure TfProcessa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z', 'A'..'Z'] then
   FMonitorPasswd := FMonitorPasswd + Key;
  if Length(FMonitorPasswd) > Length('ProcMonitor') then
    FMonitorPasswd := '';
  if (FMonitorPasswd = 'ProcMonitor') then
    Dados.ShowMonitor;
  sbStatus.Panels[2].Text := FMonitorPasswd;
end;

end.
