unit PrntGen;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 01/12/2005 - DD/MM/YYYY                                      *}
{* Modified: 01/12/2005 - DD/MM/YYYY                                     *}
{* Version: 2.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvWizard, JvWizardRouteMapNodes, JvExControls, JvComponent,
  VirtualTrees, Buttons, ExtCtrls, StdCtrls, TeEngine, Series, TeeProcs,
  Chart, ComCtrls, GridRow;

type
  TWizScreens = (wsSelReports, wsPrnOpt, wsSelFields, wsSelFilters, wsSelGroups,
                 wsSelDataEntry, wsSelView);

  TDualScreen = (dsFields, dsFilters, dsGroups);

  TfrmPrintGenerator = class(TForm)
    wzReport: TJvWizard;
    wzWelcome: TJvWizardWelcomePage;
    wzSelFields: TJvWizardInteriorPage;
    wzPrinterOptions: TJvWizardInteriorPage;
    wzFilters: TJvWizardInteriorPage;
    wzDataEntry: TJvWizardInteriorPage;
    wzView: TJvWizardInteriorPage;
    wzGroups: TJvWizardInteriorPage;
    rtReport: TJvWizardRouteMapNodes;
    wzOrder: TJvWizardInteriorPage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wzReportNextButtonClick(Sender: TObject);
  private
    { Private declarations }
    FModule   : Integer;
    FProgram  : Integer;
    FRotine   : Integer;
    FSQL      : TStrings;
    FSQLParams: TDataRow;
    FReportStm: TMemoryStream;
    FWizScreen: TWizScreens;
    function  TestParams: Boolean;
    procedure SetSQL(const Value: TStrings);
    procedure SetSQLParams(const Value: TDataRow);
    procedure SetReportStm(const Value: TMemoryStream);
    procedure ChangeReport(Sender: TObject; AReport: TMemoryStream);
    procedure SetWizScreen(const Value: TWizScreens);
    procedure SetPrinterOptions;
    procedure SetDualSelect(AValue: TDualScreen);
    procedure SetDataEntry;
    procedure SetView;
  public
    { Public declarations }
  published
    { Published declarations }
    property SQL      : TStrings      read FSQL       write SetSQL;
    property SQLParams: TDataRow      read FSQLParams write SetSQLParams;
    property ReportStm: TMemoryStream read FReportStm write SetReportStm;
    property WizScreen: TWizScreens   read FWizScreen write SetWizScreen default wsSelReports;
  end;

implementation

uses SelReports, Dado, ProcType, mSysRel;

{$R *.dfm}

procedure TfrmPrintGenerator.FormCreate(Sender: TObject);
begin
  FSQL          := TStringList.Create;
  FSQLParams    := TDataRow.Create(Self);
  FReportStm    := TMemoryStream.Create;
  Caption       := Application.Title;
  FModule       := Dados.Parametros.soPkModule;
  FRotine       := Dados.Parametros.soPkRotine;
  FProgram      := Dados.Parametros.soPkProgram;
  wzWelcome.VisibleButtons := wzWelcome.VisibleButtons - [bkFinish];
  WizScreen     := wsSelReports;
end;

procedure TfrmPrintGenerator.FormShow(Sender: TObject);
begin
  if (Assigned(frmPrgReports)) then
  begin
    frmPrgReports := TfrmPrgReports.Create(Application, FModule, FRotine, FProgram);
    frmPrgReports.Parent         := wzWelcome;
    frmPrgReports.BorderStyle    := bsNone;
    frmPrgReports.Align          := alClient;
    frmPrgReports.OnChangeReport := ChangeReport;
    frmPrgReports.Show;
  end;
end;

procedure TfrmPrintGenerator.FormDestroy(Sender: TObject);
begin
  if (Assigned(frmPrgReports)) then
    frmPrgReports.Free;
  frmPrgReports := nil;
end;

procedure TfrmPrintGenerator.SetSQL(const Value: TStrings);
begin
  FSQL.Clear;
  if (Value <> nil) then
  begin
    FSQL.Assign(Value);
    if (TestParams) then
    begin
      wzWelcome.EnableButton(bkNext, (FSQL.Text <> ''));
      if (not (bkFinish in wzWelcome.VisibleButtons)) and (FReportStm.Size > 0) then
        wzWelcome.VisibleButtons := wzWelcome.VisibleButtons + [bkFinish];
    end;
  end;
end;

procedure TfrmPrintGenerator.SetSQLParams(const Value: TDataRow);
begin
  FSQLParams.Clear;
  if (Value <> nil) then
  begin
    FSQLParams.Assign(Value);
    if (TestParams) then
    begin
      wzWelcome.EnableButton(bkNext, (FSQL.Text <> ''));
      if (not (bkFinish in wzWelcome.VisibleButtons)) and (FReportStm.Size > 0) then
        wzWelcome.VisibleButtons := wzWelcome.VisibleButtons + [bkFinish];
    end;
  end;
end;

function TfrmPrintGenerator.TestParams: Boolean;
begin
  Result := False;
  if (FSQL.Text = '') then exit;
  with dmSysRel do
  begin
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Assign(FSQL);
    Result := (qrSqlAux.Params.Count = FSQLParams.Count);
  end;
end;

procedure TfrmPrintGenerator.SetReportStm(const Value: TMemoryStream);
begin
  FReportStm.Clear;
  if (Value <> nil) then
    FReportStm.LoadFromStream(Value);
end;

procedure TfrmPrintGenerator.ChangeReport(Sender: TObject;
  AReport: TMemoryStream);
begin
  ReportStm := AReport;
  if (TestParams)  and (not (bkFinish in wzWelcome.VisibleButtons)) and
     (FReportStm.Size > 0) then
    wzWelcome.VisibleButtons := wzWelcome.VisibleButtons + [bkFinish];
end;

procedure TfrmPrintGenerator.wzReportNextButtonClick(Sender: TObject);
begin
  // Set correct page of wizard
  WizScreen := TWizScreens(wzReport.ActivePageIndex);
end;

procedure TfrmPrintGenerator.SetWizScreen(const Value: TWizScreens);
begin
  if (Value <> FWizScreen) then
  begin
    FWizScreen               := Value;
    wzReport.ActivePageIndex := Ord(FWizScreen);
    case FWizScreen of
      wsSelReports  : FormShow(Self);
      wsPrnOpt      : SetPrinterOptions;
      wsSelFields   : SetDualSelect(dsFields);
      wsSelFilters  : SetDualSelect(dsFilters);
      wsSelGroups   : SetDualSelect(dsGroups);
      wsSelDataEntry: SetDataEntry;
      wsSelView     : SetView;
    end;
  end;
end;

procedure TfrmPrintGenerator.SetDataEntry;
begin
// Show Form of Data Entry
end;

procedure TfrmPrintGenerator.SetDualSelect(AValue: TDualScreen);
begin
// Show Form of Dual Screen as instruct TDualScreen
end;

procedure TfrmPrintGenerator.SetPrinterOptions;
begin
// Show Printer Page Options of FastReport with system default and
// wzPrinterOptions parented
end;

procedure TfrmPrintGenerator.SetView;
begin
// Show View Data of Report
end;

initialization
  RegisterClass(TfrmPrintGenerator);

end.
