unit DlgTaskView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSchedule, ComCtrls, VpBase, VpBaseDS, VpTaskList, VpData, ProcUtils;

type
  TfrmTasksView = class(TfrmSchedule)
    VpTaskList: TVpTaskList;
    procedure FormCreate(Sender: TObject);
    procedure VpTaskListOwnerEditTask(Sender: TObject; Task: TVpTask;
      Resource: TVpResource; var AllowIt: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDefaults; override;
    property NumDays;
    property DataLink;
  end;

implementation

uses CadTask;

{$R *.dfm}

procedure TfrmTasksView.FormCreate(Sender: TObject);
begin
  inherited;
  NumDays := 30;
end;

procedure TfrmTasksView.FormDestroy(Sender: TObject);
begin
  if Assigned(CdTasks) then
    CdTasks.Free;
  CdTasks := nil;
  inherited;
end;

procedure TfrmTasksView.SetDefaults;
begin
  if (DataLink <> nil) then
  begin
    VpTaskList.DataStore   := DataLink.DataStore;
    VpTaskList.ControlLink := DataLink;
  end;
end;

procedure TfrmTasksView.VpTaskListOwnerEditTask(Sender: TObject;
  Task: TVpTask; Resource: TVpResource; var AllowIt: Boolean);
begin
  pgMain.ActivePageIndex := 1;
  CdTasks         := TCdTasks.Create(tsData, Task, Resource, dbmBrowse);
  CdTasks.Parent  := tsData;
  CdTasks.Align   := alClient;
  CdTasks.OnClose := FormClose;
  CdTasks.Show;
end;

procedure TfrmTasksView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (DataLink <> nil) then DataLink.DataStore.LoadEvents;
  pgMain.ActivePageIndex := 0;
end;

end.
