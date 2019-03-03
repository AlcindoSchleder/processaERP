unit DlgDayView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSchedule, VpBase, VpBaseDS, VpDayView, ComCtrls, VpData, ProcUtils;

type
  TfrmDayView = class(TfrmSchedule)
    vpDayView: TVpDayView;
    procedure FormCreate(Sender: TObject);
    procedure vpDayViewOwnerEditEvent(Sender: TObject; Event: TVpEvent;
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
    property FlagSuper;
  end;

implementation

uses CadEvent;

{$R *.dfm}

procedure TfrmDayView.FormCreate(Sender: TObject);
begin
  inherited;
  NumDays := vpDayView.NumDays;
end;

procedure TfrmDayView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (DataLink <> nil) then DataLink.DataStore.LoadEvents;
  pgMain.ActivePageIndex := 0;
end;

procedure TfrmDayView.FormDestroy(Sender: TObject);
begin
  if Assigned(CdEvents) then
    CdEvents.Free;
  CdEvents := nil;
  inherited;
end;

procedure TfrmDayView.SetDefaults;
begin
  if (DataLink <> nil) then
  begin
    vpDayView.DataStore   := DataLink.DataStore;
    vpDayView.ControlLink := DataLink;
  end;
end;

procedure TfrmDayView.vpDayViewOwnerEditEvent(Sender: TObject;
  Event: TVpEvent; Resource: TVpResource; var AllowIt: Boolean);
begin
  pgMain.ActivePageIndex := 1;
  CdEvents := TCdEvents.Create(tsData, Event, Resource, dbmBrowse,
    vpDayView.DataStore.CategoryColorMap, tf24Hour, FlagSuper);
  CdEvents.Parent  := tsData;
  CdEvents.Align   := alClient;
  CdEvents.OnClose := FormClose;
  CdEvents.Show;
end;

end.
