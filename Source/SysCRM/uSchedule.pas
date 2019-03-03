unit uSchedule;

interface

uses
  SysUtils, Classes, Controls, Forms, Dialogs, vpBaseDS, VirtualDS, ComCtrls;

type
  TfrmSchedule = class(TForm)
    pgMain: TPageControl;
    tsVisual: TTabSheet;
    tsData: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDataLink : TvpControlLink;
    FNumDays  : Cardinal;
    FFlagSuper: Boolean;
    procedure SetDataLink(AValue: TVpControlLink);
    procedure SetNumDays(AValue: Cardinal);
  public
    { Public declarations }
    procedure SetDefaults; virtual; abstract;
    property NumDays  : Cardinal       read FNumDays   write SetNumDays  default 1;
    property DataLink : TVpControlLink read FDataLink  write SetDataLink;
    property FlagSuper: Boolean        read FFlagSuper write FFlagSuper default False;
  end;

implementation

{$R *.dfm}

uses ProcUtils, TypInfo;

procedure TfrmSchedule.FormCreate(Sender: TObject);
begin
  FNumDays  := 1;
  FDataLink := nil;
end;

procedure TfrmSchedule.FormDestroy(Sender: TObject);
begin
  FDataLink := nil;
end;

procedure TfrmSchedule.SetDataLink(AValue: TVpControlLink);
var
  i: Integer;
begin
  FDataLink := AValue;
  for i := 0 to Self.ComponentCount - 1 do
  begin
    if GetProperty(Self.Components[i], 'DataStore') then
      SetObjectProp(Self.Components[i], 'DataStore', FDataLink.DataStore);
    if GetProperty(Self.Components[i], 'ControlLink') then
      SetObjectProp(Self.Components[i], 'ControlLink', FDataLink);
  end;
end;

procedure TfrmSchedule.SetNumDays(AValue: Cardinal);
begin
  FNumDays := AValue;
{  if (FDataLink.DataStore.Connected) and
     (FDataLink.DataStore.Resource <> nil) and
     (FDataLink.DataStore is TVirtualData) then
    TVirtualData(FDataLink.DataStore).EndDate := FDataLink.DataStore.Date +
      FNumDays;}
end;

end.
