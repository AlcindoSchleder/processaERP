unit DlgWeekView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSchedule, VpBase, VpBaseDS, VpWeekView, ComCtrls;

type
  TfrmWeekView = class(TfrmSchedule)
    vpWeekView: TVpWeekView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDefaults; override;
    property NumDays;
    property DataLink;
  end;

var
  frmWeekView: TfrmWeekView;

implementation

{$R *.dfm}

procedure TfrmWeekView.FormCreate(Sender: TObject);
begin
  inherited;
  NumDays := 7;
end;

procedure TfrmWeekView.SetDefaults;
begin
  if (DataLink <> nil) then
    vpWeekView.ControlLink := DataLink;
end;

end.
