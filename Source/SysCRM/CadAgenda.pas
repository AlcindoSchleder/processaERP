unit CadAgenda;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.-           *}
{* Created: 15/02/2004 - DD/MM/YYYY                                      *}
{* Modified: 15/02/2004 - DD/MM/YYYY                                     *}
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
  Dialogs, Menus, Buttons, ComCtrls, StdCtrls, ExtCtrls, RXShell, VpBase, VpDlg,
  VpBaseDS, VirtualDS, VpAlarmDlg, VpDayView, VpClock, VpLEDLabel, VpNavBar,
  VpTaskList, VpData, TSysCrmAux, CrmAgent, VpCalendar;

type
  TVisibleVpControl = (vcDayView, vcWeekView, vcMonthView, vcContact, vcTask,
                       vcSelection);

  TCdAgenda = class(TForm)
    mMain: TMainMenu;
    sbStatus: TStatusBar;
    pTasks: TPanel;
    sSeparator: TSplitter;
    vpTasks: TVpTaskList;
    vpNotification: TVpNotificationDialog;
    miHelp: TMenuItem;
    miAbout: TMenuItem;
    miFolders: TMenuItem;
    miMessages: TMenuItem;
    miDisplay: TMenuItem;
    miContainer: TMenuItem;
    miDayCalendar: TMenuItem;
    miWeekCalendar: TMenuItem;
    miViewContacts: TMenuItem;
    miViewTasks: TMenuItem;
    miSendTo: TMenuItem;
    miGet: TMenuItem;
    miList: TMenuItem;
    miTopics: TMenuItem;
    miContents: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    miSendMail: TMenuItem;
    pOperator: TPanel;
    pWork: TPanel;
    vpNavigator: TVpNavBar;
    vplEvents: TVpLEDLabel;
    lLoadEvents: TLabel;
    lContacts: TLabel;
    vplContacts: TVpLEDLabel;
    lTasks: TLabel;
    vplTasks: TVpLEDLabel;
    vpClock: TVpClock;
    lChooseOperator: TLabel;
    miClose: TMenuItem;
    N3: TMenuItem;
    miChartSchedule: TMenuItem;
    miNew: TMenuItem;
    trIcon: TRxTrayIcon;
    pmTray: TPopupMenu;
    pmiShowSchedule: TMenuItem;
    pmiHideSchedule: TMenuItem;
    pmiCloseLibrary: TMenuItem;
    pmEventos: TPopupMenu;
    pmTypeContact: TPopupMenu;
    miCompany: TMenuItem;
    miPeople: TMenuItem;
    pmFields: TPopupMenu;
    pmEqual: TMenuItem;
    pmNoEqual: TMenuItem;
    pmStartWith: TMenuItem;
    pmNoStartWith: TMenuItem;
    pmFinishWith: TMenuItem;
    pmNoFinishWith: TMenuItem;
    pmContaining: TMenuItem;
    pmNoContaining: TMenuItem;
    miSelAllCustumers: TMenuItem;
    cbResources: TComboBox;
    vpDS: TVirtualData;
    vpLink: TVpControlLink;
    vpCalendar: TVpCalendar;
    miSelection: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miTopicsClick(Sender: TObject);
    procedure miContentsClick(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure miSendMailClick(Sender: TObject);
    procedure vpNavigatorItemClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; Index: Integer);
    procedure miDayCalendarClick(Sender: TObject);
    procedure miWeekCalendarClick(Sender: TObject);
    procedure miViewContactsClick(Sender: TObject);
    procedure miViewTasksClick(Sender: TObject);
    procedure miSendToClick(Sender: TObject);
    procedure miGetClick(Sender: TObject);
    procedure miTasksClick(Sender: TObject);
    procedure miListClick(Sender: TObject);
    procedure miContainerClick(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure cbResourcesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbResourcesMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure pmiShowScheduleClick(Sender: TObject);
    procedure pmiHideScheduleClick(Sender: TObject);
    procedure pmFilterClick(Sender: TObject);
    procedure miCompanyClick(Sender: TObject);
    procedure cbResourcesSelect(Sender: TObject);
    procedure vpDSLoadContacts(Sender: TObject);
    procedure vpDSLoadEvents(Sender: TObject);
    procedure vpDSLoadTasks(Sender: TObject);
    procedure vpDSDateChanged(Sender: TObject; Date: TDateTime);
    procedure vpDSAlert(Sender: TObject; Event: TVpEvent);
    procedure miMonthChartClick(Sender: TObject);
    procedure bLoadDefaultsClick(Sender: TObject);
    procedure vpCalendarDrawItem(Sender: TObject; ADate: TDateTime;
      const Rect: TRect);
    procedure miSelectionClick(Sender: TObject);
    procedure vpTasksOwnerEditTask(Sender: TObject; Task: TVpTask;
      Resource: TVpResource; var AllowIt: Boolean);
  private
    { Private declarations }
    FEventThread     : TEventNotification;
    FActiveDate      : TDate;
    FActiveTrayIcon  : Boolean;
    FActiveUser      : TOperatorRes;
    FConfigured      : Boolean;
    FEndDate         : TDateTime;
    FFlagSuper       : Boolean;
    FStartDate       : TDateTime;
    FVisibleVpControl: TVisibleVpControl;
    procedure WMGetMsgUser(var Msg: TMessage); message WM_USER;
    procedure ConfigScreen;
    procedure SetActiveTrayIcon(AValue: Boolean);
    procedure SetVisibleVpControl(AValue: TVisibleVpControl);
    procedure FreeActiveVisibleControl;
    procedure SendMail(eMail: string);
  public
    { Public declarations }
    property  Configured    : Boolean read FConfigured     write FConfigured;
  published
    { Published declarations }
    property  ActiveTrayIcon  : Boolean           read FActiveTrayIcon   write SetActiveTrayIcon;
    property  VisibleVpControl: TVisibleVpControl read FVisibleVpControl write SetVisibleVpControl;
  end;

var
  CdAgenda: TCdAgenda;
  
implementation

uses Dado, Sobre, CmmConst, mSysCrm, ArqSqlCrm, Funcoes, DateUtils,  Types,
  FuncoesDB, ProcType, DlgDayView, uSchedule, DlgWeekView, DlgCntView,
  DlgTaskView, DlgContacts, DlgMonthView, TSysCad, CadTask, ProcUtils;

{$R *.dfm}

procedure TCdAgenda.FormCreate(Sender: TObject);
var
 aIdx: Integer;
begin
  FActiveDate        := Date;
  FConfigured        := False;
  FFlagSuper         := False;
  ConfigScreen;
  mMain.Images       := Dados.Image16;
  vpNavigator.Images := Dados.Image16;
  pmTray.Images      := Dados.Image16;
  FActiveUser        := TOperatorRes.Create;
  cbResources.Items.AddStrings(dmSysCrm.LoadResources(aIdx));
  if (cbResources.Items.Count = 0) then miCloseClick(Sender);
  if (aIdx > 0) and (aIdx < cbResources.Items.Count) then
  begin
    cbResources.ItemIndex := aIdx;
    if (cbResources.Items.Objects[aIdx] <> nil) then
      FFlagSuper := (TOperatorRes(cbResources.Items.Objects[aIdx]).FlagSuper)
    else
      FFlagSuper := False;
     vpDS.Loading := False;
    cbResourcesSelect(cbResources);
  end;
  vpDS.Loading       := True;
  VisibleVpControl   := vcDayView;
  vpDS.Loading       := False;
end;

procedure TCdAgenda.FormDestroy(Sender: TObject);
var
  i, aObj: LongInt;
  aContact: TVpContact;
begin
  FreeActiveVisibleControl;
  for i := 0 to vpDS.Resource.Contacts.Count - 1 do
  begin
    aContact := TVpContact(vpDS.Resource.Contacts.ContactsList.Items[i]);
    aObj := StrToIntDef(aContact.UserField0, 0);
    if (aObj > 0) and (TObject(aObj) = nil) and (TObject(aObj) is TOwner) then
      TOwner(aObj).Free;
    aContact.UserField0 := '';
    aContact.Changed := False;
  end;
  vpDS.Resource.Tasks.ClearTasks;
  vpDS.Resource.Contacts.ClearContacts;
  vpDS.Resource.Schedule.ClearEvents;
  vpDS.Resources.ClearResources;
  vpDS.Connected := False;
  if Assigned(FActiveUser)  then FActiveUser.Free;
  if Assigned(FEventThread) then FEventThread.Free;
  FEventThread := nil;
  FActiveUser  := nil;
  ReleaseCombos(cbResources, toObject);
end;

procedure TCdAgenda.WMGetMsgUser(var Msg: TMessage);
begin
  if (Msg.WParam = -1) then
    Msg.WParam := 0;
  if (TEventType(Msg.LParam) = etShowAlert) and (Assigned(FEventThread)) then
  begin
    FEventThread.Free;
    FEventThread := nil;
  end;
end;

procedure TCdAgenda.ConfigScreen;
var
  StrAux: string;
begin
  FConfigured               := True;
  Caption                   := Application.Title + ' - Agenda 1.0';
// GetStrings from Messages Table to Captions and Labels
//  pOperator.Visible         := Dados.LocalizaAcessos('CdResources');
  lChooseOperator.Caption   := Dados.GetStringMessage(LANGUAGE, 'slChooseOperator', 'Escolha o &Operador:');
  miFolders.Caption         := Dados.GetStringMessage(LANGUAGE, 'smiFolders', '&Pastas');
  miHelp.Caption            := Dados.GetStringMessage(LANGUAGE, 'smiHelp', 'Aj&uda');
  miDisplay.Caption         := Dados.GetStringMessage(LANGUAGE, 'smiDisplay', '&Visualizar');
  miMessages.Caption        := Dados.GetStringMessage(LANGUAGE, 'smiMessages', '&Lembretes');
  miContainer.Caption       := Dados.GetStringMessage(LANGUAGE, 'smiContainer', 'Sumário da &Agenda');
  miClose.Caption           := Dados.GetStringMessage(LANGUAGE, 'smiClose', '&Sair');
  miDayCalendar.Caption     := Dados.GetStringMessage(LANGUAGE, 'smiDayCalendar', 'Agenda &Diária');
  miWeekCalendar.Caption    := Dados.GetStringMessage(LANGUAGE, 'smiWeekCalendar', 'Agenda &Semanal');
  miViewContacts.Caption    := Dados.GetStringMessage(LANGUAGE, 'smiViewContacts', '&Contatos');
  miChartSchedule.Caption   := Dados.GetStringMessage(LANGUAGE, 'smiChartSchedule', '&Gráfico da Agenda');
  miSelection.Caption       := Dados.GetStringMessage(LANGUAGE, 'smiCustumers', '&Empresas');;
  miViewTasks.Caption       := Dados.GetStringMessage(LANGUAGE, 'smiTasks', '&Tarefas');
  miSendTo.Caption          := Dados.GetStringMessage(LANGUAGE, 'smiSendTo', '&Criar Lembrete para...');
  miGet.Caption             := Dados.GetStringMessage(LANGUAGE, 'smiGet', '&Verificar Lembretes');
  miList.Caption            := Dados.GetStringMessage(LANGUAGE, 'smiList', '&Listar Lembrete');
  miNew.Caption             := Dados.GetStringMessage(LANGUAGE, 'smiNew', '&Novo Lembrete');
  miTopics.Caption          := Dados.GetStringMessage(LANGUAGE, 'smiTopics', '&Tópicos');
  miContents.Caption        := Dados.GetStringMessage(LANGUAGE, 'smiContent', '&Conteúdo');
  miAbout.Caption           := Dados.GetStringMessage(LANGUAGE, 'smiAbout', '&Sobre');
  miSendMail.Caption        := Dados.GetStringMessage(LANGUAGE, 'smiSendMail', '&Enviar e-Mail');
  pmiShowSchedule.Caption   := Dados.GetStringMessage(LANGUAGE, 'spmiShowSchedule', 'Abrir a Agenda');
  pmiHideSchedule.Caption   := Dados.GetStringMessage(LANGUAGE, 'spmiHideSchedule', 'Esconder a Agenda');
  pmiCloseLibrary.Caption   := Dados.GetStringMessage(LANGUAGE, 'spmiCloseLibrary', 'Fechar a Agenda');
  miCompany.Caption         := Dados.GetStringMessage(LANGUAGE, 'smiCompany', 'Filtrar &Empresas');
  miPeople.Caption          := Dados.GetStringMessage(LANGUAGE, 'smiPeople', 'Filtrar &Contatos');
  miSelAllCustumers.Caption := Dados.GetStringMessage(LANGUAGE, 'smiSelAllCustumers', 'Selecionar &Todas as Empresas');
  lLoadEvents.Caption       := Dados.GetStringMessage(LANGUAGE, 'slLoadEvents', 'Quant. de Eventos');
  lContacts.Caption         := Dados.GetStringMessage(LANGUAGE, 'slContactsCount', 'Quant. de Contatos');
  lTasks.Caption            := Dados.GetStringMessage(LANGUAGE, 'slTasksCount', 'Quant. de Tarefas');
  pmEqual.Caption           := Dados.GetStringMessage(LANGUAGE, 'spmEqual', 'Igual (=)');
  pmNoEqual.Caption         := Dados.GetStringMessage(LANGUAGE, 'spmNoEqual', 'Diferente (<>)');
  pmStartWith.Caption       := Dados.GetStringMessage(LANGUAGE, 'spmStartWith', 'Iniciando com (starting with)');
  pmNoStartWith.Caption     := Dados.GetStringMessage(LANGUAGE, 'spmNoStartWith', 'Não Iniciando com (not starting with)');
  pmFinishWith.Caption      := Dados.GetStringMessage(LANGUAGE, 'spmFinishWith', 'Terminando com (like x%)');
  pmNoFinishWith.Caption    := Dados.GetStringMessage(LANGUAGE, 'spmNoFinishWith', 'Não Terminando com (not like x%)');
  pmContaining.Caption      := Dados.GetStringMessage(LANGUAGE, 'spmContaining', 'Contendo (containing)');
  pmNoContaining.Caption    := Dados.GetStringMessage(LANGUAGE, 'spmNoContaining', 'Não Contendo (No containing)');

  StrAux                    := miDisplay.Caption;
  Delete(StrAux, Pos('&', StrAux), 1);
  vpNavigator.Folders[0].Caption := StrAux;

  StrAux                         := miMessages.Caption;
  Delete(StrAux, Pos('&', StrAux), 1);
  vpNavigator.Folders[1].Caption := StrAux;

  StrAux                         := miContainer.Caption;
  Delete(StrAux, Pos('&', StrAux), 1);
  vpNavigator.Folders[2].Caption := StrAux;

  vpNavigator.Folders[0].Items[0].Caption := miDayCalendar.Caption;
  vpNavigator.Folders[0].Items[1].Caption := miWeekCalendar.Caption;
  vpNavigator.Folders[0].Items[2].Caption := miViewContacts.Caption;
  vpNavigator.Folders[0].Items[3].Caption := miViewTasks.Caption;
  vpNavigator.Folders[0].Items[4].Caption := miSelection.Caption;
  vpNavigator.Folders[0].Items[5].Caption := miChartSchedule.Caption;

  vpNavigator.Folders[1].Items[0].Caption := miNew.Caption;
  vpNavigator.Folders[1].Items[1].Caption := miGet.Caption;
  vpNavigator.Folders[1].Items[2].Caption := miList.Caption;
  vpNavigator.Folders[1].Items[3].Caption := miSendTo.Caption;
  vpNavigator.ActiveFolder  := 0;
end;

procedure TCdAgenda.SetActiveTrayIcon(AValue: Boolean);
begin
  FActiveTrayIcon := AValue;
  TrIcon.Active   := FActiveTrayIcon;
end;

procedure TCdAgenda.SetVisibleVpControl(AValue: TVisibleVpControl);
var
  aForm: TForm;
begin
  if (not vpDS.Loading) and (AValue = FVisibleVpControl) then exit;
  FreeActiveVisibleControl;
  FVisibleVpControl := AValue;
  aForm := nil;
  case FVisibleVpControl of
    vcDayView  : aForm := TfrmDayView.Create(pWork);
    vcWeekView : aForm := TfrmWeekView.Create(pWork);
    vcMonthView: aForm := TfrmChartView.Create(pWork);
    vcContact  : aForm := TfrmContactView.Create(pWork, FFlagSuper);
    vcTask     : aForm := TfrmTasksView.Create(pWork);
    vcSelection: aForm := TfrmSelection.Create(pWork);
  end;
  if (aForm <> nil) then
  begin
    aForm.Parent      := pWork;
    aForm.BorderStyle := bsNone;
    aForm.Align       := alClient;
    pWork.Tag         := LongInt(aForm);
    if (FVisiblevpControl <> vcSelection) and
       (aForm.InheritsFrom(TfrmSchedule)) then
    begin
      TfrmSchedule(aForm).FlagSuper := FFlagSuper;
      TfrmSchedule(aForm).DataLink := vpLink;
      case FVisibleVpControl of
        vcDayView  : TfrmSchedule(aForm).NumDays := 1;
        vcWeekView : TfrmSchedule(aForm).NumDays := 7;
        vcMonthView: TfrmSchedule(aForm).NumDays := 30;
        vcTask     : TfrmSchedule(aForm).NumDays := 30;
      end;
    end;
    aForm.Show;
    case FVisibleVpControl of
      vcDayView  ,
      vcWeekView ,
      vcTask     : vpDSDateChanged(vpDS, FActiveDate);
      vcContact  : vpDS.LoadContacts;
      vcSelection: dmSysCrm.LoadContacts(True, nil);
      vcMonthView: ;
    end;
  end
end;

procedure TCdAgenda.FreeActiveVisibleControl;
var
  aForm: TForm;
begin
  if (pWork.Tag > 0) then
  begin
    aForm := TForm(pWork.Tag);
    if (Assigned(aForm)) then
      aForm.Free;
    aForm := nil;
    if aForm = nil then
      pWork.Tag := 0;
  end;
end;

procedure TCdAgenda.cbResourcesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  Offset: Integer;
begin
  with (Control as TComboBox).Canvas do
  begin
    FillRect(Rect);
    Bitmap := TBitMap.Create;
    Dados.Image16.GetBitmap(84, Bitmap);
    BrushCopy(Bounds(Rect.Left + 2, Rect.Top + 2, Bitmap.Width, Bitmap.Height),
      Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height), clRed);
    Offset := Bitmap.Width + 8;
    TextOut(Rect.Left + Offset, Rect.Top, cbResources.Items[index]);
  end;
end;

procedure TCdAgenda.cbResourcesMeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  Height := 20;
end;

procedure TCdAgenda.cbResourcesSelect(Sender: TObject);
var
  aIdx, i: Integer;
  aItem  : TVpResource;
  aObj   : TObject;
begin
  aIdx := cbResources.ItemIndex;
  if (aIdx > 0) and (cbResources.Items.Objects[aIdx] <> nil) then
    FActiveUser.Assign(TOperatorRes(cbResources.Items.Objects[aIdx]));
  if not FFlagSuper then
  begin
    cbResources.Visible         := FActiveUser.FlagSuper;
    lChooseOperator.Visible     := FActiveUser.FlagSuper;
  end;
  if vpDS.Connected then vpDS.Connected := False;
  if vpDS.Resources.Count = 0 then
  begin
    for i := 0 to cbResources.Items.Count - 1 do
    begin
      if (cbResources.Items.Objects[i] <> nil) and
         (TOperatorRes(cbResources.Items.Objects[i]).PkResources > 0) then
      begin
        aObj  := cbResources.Items.Objects[i];
        aItem := vpDS.Resources.AddResource(TOperatorRes(aObj).PkResources);
        aItem.ResourceID  := TOperatorRes(aObj).PkResources;
        aItem.Description := TOperatorRes(aObj).FkOperator.PkOperator;
      end;
    end;
  end;
  vpDS.Resource := vpDS.Resources.GetResource(FActiveUser.PkResources);
  vpDS.Resource.ResourceID  := FActiveUser.PkResources;
  vpDS.Resource.Description := FActiveUser.FkOperator.PkOperator;
  if not vpDS.Connected then vpDS.Connected := True;
end;

procedure TCdAgenda.miCloseClick(Sender: TObject);
var
  WinHandle: HWND;
begin
  Close;
  if Application.MessageBox(PAnsiChar('Deseja desativar a Agenda?'),
     PAnsiChar(Application.Title), MB_ICONINFORMATION + MB_YESNO) = mrYes then
  begin
    trIcon.Active := False;
    WinHandle    := FindWindow('TfProcessa', nil);
    if WinHandle > 0 then
      PostMessage(WinHandle, WM_USER, -1, 0);
  end;
end;

procedure TCdAgenda.miTopicsClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TCdAgenda.miContentsClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TCdAgenda.miAboutClick(Sender: TObject);
begin
  Application.CreateForm(TfrmAboutProcessa, frmAboutProcessa);
  try
    frmAboutProcessa.ShowModal;
  finally
    frmAboutProcessa.Free;
  end;
end;

procedure TCdAgenda.miSendMailClick(Sender: TObject);
begin
  SendMail(Dados.Parametros.soToMail);
end;

procedure TCdAgenda.SendMail(eMail: string);
var
  NameForm, EM, PT, Lib: string;
begin
  inherited;
  NameForm              := Dados.Parametros.soProgramForm;
  PT                    := Dados.Parametros.soProgramTitle;
  EM                    := Dados.Parametros.soToMail;
  Dados.Parametros.soToMail       := eMail;
  Dados.Parametros.soProgramTitle := Dados.FindProgramTitle('SendMail');
  Dados.Parametros.soProgramForm  := 'fSendMail';
  Lib                             := sDoth + sPathSep + 'SysGen' + sLibExt;
  Dados.Parametros.soProgramTitle := PT;
  Dados.Parametros.soToMail       := EM;
  Dados.Parametros.soProgramForm  := NameForm;
end;

procedure TCdAgenda.vpNavigatorItemClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; Index: Integer);
begin
  if vpNavigator.ActiveFolder = 0 then
  begin
    case Index of
      0: miDayCalendar.Click;
      1: miWeekCalendar.Click;
      2: miViewContacts.Click;
      3: miViewTasks.Click;
      4: miSelection.Click;
      5: miChartSchedule.Click;
    end;
  end;
end;

procedure TCdAgenda.miDayCalendarClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 0;
  VisibleVpControl := vcDayView;
end;

procedure TCdAgenda.miWeekCalendarClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 0;
  VisibleVpControl := vcWeekView;
end;

procedure TCdAgenda.miViewContactsClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 0;
  VisibleVpControl := vcContact;
end;

procedure TCdAgenda.miViewTasksClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 0;
  VisibleVpControl := vcTask;
end;

procedure TCdAgenda.miSelectionClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 0;
  VisibleVpControl := vcSelection;
end;

procedure TCdAgenda.miSendToClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 1;
end;

procedure TCdAgenda.miGetClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 1;
end;

procedure TCdAgenda.miTasksClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 1;
end;

procedure TCdAgenda.miListClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 1;
end;

procedure TCdAgenda.miContainerClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 2;
end;

procedure TCdAgenda.pmiShowScheduleClick(Sender: TObject);
begin
  Show;
end;

procedure TCdAgenda.pmiHideScheduleClick(Sender: TObject);
begin
  Hide;
end;

procedure TCdAgenda.pmFilterClick(Sender: TObject);
begin
  if (not (Sender.ClassType = TMenuItem)) and
     (TMenuItem(Sender).Tag < 0)          then
    exit;
  pmEqual.Checked           := False;
  pmNoEqual.Checked         := False;
  pmStartWith.Checked       := False;
  pmNoStartWith.Checked     := False;
  pmFinishWith.Checked      := False;
  pmNoFinishWith.Checked    := False;
  pmContaining.Checked      := False;
  pmNoContaining.Checked    := False;
  TMenuItem(Sender).Checked := True;
end;

procedure TCdAgenda.miCompanyClick(Sender: TObject);
begin
  if (not (Sender.ClassType = TMenuItem)) and
     (TMenuItem(Sender).Tag < 0)          then
    exit;
  miCompany.Checked         := False;
  miPeople.Checked          := False;
  TMenuItem(Sender).Checked := True;
end;

procedure TCdAgenda.vpDSLoadContacts(Sender: TObject);
begin
  dmSysCrm.LoadContacts(FActiveUser.FlagSuper, vpDS.Resource);
end;

procedure TCdAgenda.vpDSLoadEvents(Sender: TObject);
begin
  if (not vpDS.Connected) or (vpDS.Resource = nil) then exit;
  dmSysCrm.LoadEvents(FStartDate, FEndDate, vpDS.Resource);
end;

procedure TCdAgenda.vpDSLoadTasks(Sender: TObject);
begin
  if (FVisibleVpControl = vcTask) then
    dmSysCrm.LoadTasks(True, vpDS.Resource, FStartDate, FEndDate)
  else
    dmSysCrm.LoadTasks(False, vpDS.Resource, FStartDate, FEndDate);
end;

procedure TCdAgenda.vpDSDateChanged(Sender: TObject; Date: TDateTime);
begin
  if (not vpDS.Connected) then exit;
  FActiveDate := vpDS.Date;
  FStartDate := StartOfTheDay(vpDS.Date);
  FEndDate   := EndOfTheDay(vpDS.Date);
  if FVisibleVpControl = vcWeekView then
  begin
    FStartDate := StartOfTheWeek(vpDS.Date);
    FEndDate   := EndOfTheWeek(vpDS.Date);
  end;
  if (FVisibleVpControl in [vcMonthView, vcTask]) then
  begin
    FStartDate := StartOfTheMonth(vpDS.Date);
    FEndDate   := EndOfTheMonth(vpDS.Date);
  end;
  vpDS.LoadEvents;
  vpDS.LoadTasks;
  if (vpDS.Resource <> nil) then
    vplEvents.Caption   := IntToStr(vpDS.Resource.Schedule.EventCount);
  if (vpDS.Resource <> nil) then
    vplContacts.Caption := IntToStr(vpDS.Resource.Contacts.Count);
  if (vpDS.Resource <> nil) then
    vplTasks.Caption    := IntToStr(vpDS.Resource.Tasks.Count);
  vpCalendar.Repaint;
end;

procedure TCdAgenda.vpDSAlert(Sender: TObject; Event: TVpEvent);
begin
  if (not Assigned(FEventThread)) then
    FEventThread := TEventNotification.Create(Event, vpDS, etShowAlert, False);
end;

procedure TCdAgenda.miMonthChartClick(Sender: TObject);
begin
  vpNavigator.ActiveFolder := 0;
  VisibleVpControl := vcMonthView;
end;

procedure TCdAgenda.bLoadDefaultsClick(Sender: TObject);
begin
  if (pWork.Tag > 0) and (TfrmSchedule(pWork.Tag) <> nil) then
    TfrmSchedule(pWork.Tag).SetDefaults;
end;

procedure TCdAgenda.vpCalendarDrawItem(Sender: TObject; ADate: TDateTime;
  const Rect: TRect);
begin
  if (DateOf(ADate) = DateOf(FStartDate)) or
     (DateOf(ADate) = DateOf(FEndDate)) then
  begin
    vpCalendar.Canvas.Font.Color := clBlue;
    vpCalendar.Canvas.Font.Style := [fsBold];
  end
  else
  begin
    vpCalendar.Canvas.Font.Color := vpCalendar.Colors.Days;
    vpCalendar.Canvas.Font.Style := [];
  end;
  if (DateOf(ADate) = DateOf(Date)) then
  begin
    vpCalendar.Canvas.Font.Color := clRed;
    vpCalendar.Canvas.Font.Style := [fsBold];
  end;
  if (DateOf(ADate) = DateOf(FActiveDate)) then
  begin
    vpCalendar.Canvas.Font.Color := clGreen;
    vpCalendar.Canvas.Font.Style := [fsBold];
  end;
  vpCalendar.Canvas.TextRect(Rect, Rect.Left, Rect.Top, IntToStr(DayOf(ADate)));
end;

procedure TCdAgenda.vpTasksOwnerEditTask(Sender: TObject; Task: TVpTask;
  Resource: TVpResource; var AllowIt: Boolean);
begin
  CdTasks := TCdTasks.Create(Application, Task, Resource, dbmBrowse);
  try
    CdTasks.BorderStyle := bsSizeToolWin;
    CdTasks.Height      := CdTasks.Height + 60;
    CdTasks.ShowModal;
  finally
    CdTasks.Free;
    CdTasks := nil;
  end;
end;

initialization
  RegisterClass(TCdAgenda);
end.
