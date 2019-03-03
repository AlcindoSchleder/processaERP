unit DlgMonthView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSchedule, VpBase, VpBaseDS, VpMonthView, ComCtrls, ExtCtrls,
  SsResourceAllocationChart, StdCtrls, Mask, ToolEdit;

type
  TfrmChartView = class(TfrmSchedule)
    raChart: TResourceAllocationChart;
    pSelection: TPanel;
    stDtaIni: TStaticText;
    eDtaIni: TDateEdit;
    stDtaFin: TStaticText;
    eDtaFin: TDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDefaults; override;
    property NumDays;
    property DataLink;
  end;

var
  frmChartView: TfrmChartView;

implementation

uses mSysCrm;

{$R *.dfm}

procedure TfrmChartView.FormCreate(Sender: TObject);
begin
  inherited;
  NumDays := 30;
end;

procedure TfrmChartView.SetDefaults;
var
  i    : Integer;
  aRes : TResource;
//  aAllc: TResourceAllocation;
  TwelveOclock: TDateTime;
begin
  TwelveOclock := EncodeTime(12, 0, 0, 0);
  if (DataLink <> nil) then
  begin
    raChart.Clear;
    with DataLink.DataStore.Resources do
    begin
      for i := 0 to Count - 1 do
      begin
        raChart.BeginUpdate;
        try
          // show two weeks of data
          raChart.SetDateTime(eDtaIni.Date, eDtaFin.Date);

          // label the dates in the middle, with lines every 1 day
          raChart.ChartAppearance.DateLineBase := eDtaIni.Date;
          raChart.ChartAppearance.DateLineInterval := 1;
          raChart.ChartAppearance.DateLabelBase := eDtaIni.Date + TwelveOclock;
          raChart.ChartAppearance.DateTimeStyle := dtDateOnly;
          raChart.ChartAppearance.DateFormat := 'd MMM';

          // shade alternate days
          raChart.ChartAppearance.PlotBackAlternateColor := $EDE9E4;
          raChart.ChartAppearance.PlotBackAlternateInterval := 1;

          // we will enforce a midday start and end time, but let the chart round to the nearest hour
          raChart.RoundTo := EncodeTime(1, 0, 0, 0);

          // show the default hint
          raChart.Options   := raChart.Options + [racAutoHint, racScrollbarOnlyIfNecessary];
          raChart.ShowHint  := true;
          raChart.HintStyle := dtDateOnly;

          // add some resources and allocations
          aRes := raChart.AddResource(Items[i].Description, clBlue, rsRoundRect);
          if dmSysCrm.qrEvent.Active then dmSysCrm.qrEvent.Close;
          dmSysCrm.qrEvent.SQL.Clear;
//          dmSysCrm.qrEvent.SQL.Add(
          while (not dmSysCrm.qrEvent.EOF) do
          begin
            aRes.AddSlot(dmSysCrm.qrEvent.FieldByName('START_DATE').AsDateTime +
                        TwelveOclock, dmSysCrm.qrEvent.FieldByName('START_DATE').AsDateTime +
                        2 + TwelveOclock);
          // allow the allocation to delete this object when the allocation is freed
//            aAllc.OwnsAnyObject := true;
//            aAllc.AnyObject := TEvent.Create(dmSysCrm.qrEvent.FieldByName('DSC_EVT').AsString,
//              dmSysCrm.qrEvent.FieldByName('DSC_EVT').AsString);
          end;
        finally
          raChart.EndUpdate;
        end;
      end;
    end;
  end;
end;

procedure TfrmChartView.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  AKey: Word;
begin
  AKey := Key;
  Key := 0;
  case Key of
    VK_ESCAPE: Close;
  else
    Key := AKey;
  end
end;

end.
