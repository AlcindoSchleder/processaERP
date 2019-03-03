unit SelImp;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 07/01/2004 - DD/MM/YYYY                                      *}
{* Modified: 07/01/2004 - DD/MM/YYYY                                     *}
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
  SysUtils, Windows, Messages, Classes, Graphics, Controls, StdCtrls, ExtCtrls,
  Forms, Dialogs, Buttons, ComCtrls, TeeProcs, TeEngine, Chart, DBChart,
  TeeShape, GanttCh, ArrowCha, BubbleCh, Series, CheckLst, Db;

type
  TTypeReport   = (trPrinter, trScreen, trGraph);
  TTypesReports = set of TTypeReport;
  TTypeGraph    = (tgLine, tgBar, tgHorizontalBar, tgArea, tgPoint, tgPie,
                   tgFastLine, tgShape, tgGantt, tgArrow, tgBubble);

  TPrintManager = class(TForm)
    pSelect: TPanel;
    sbExecute      : TSpeedButton;
    sbClose        : TSpeedButton;
    sbHelp         : TSpeedButton;
    rgSelPrinterManager: TRadioGroup;
    eReportTitle   : TEdit;
    pFooter: TPanel;
    pGraph: TPanel;
    eGraphTitle    : TEdit;
    cbGraphType    : TComboBox;
    lGraphTitle    : TLabel;
    tcGraph        : TChart;
    lGraphType     : TLabel;
    sGreen: TBarSeries;
    sYellow: TBarSeries;
    pStatus: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure tcGraphMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure rgSelPrinterManagerClick(Sender: TObject);
    procedure sbCloseClick(Sender: TObject);
    procedure sbExecuteClick(Sender: TObject);
    procedure cbGraphTypeCloseUp(Sender: TObject);
    procedure tcGraphDblClick(Sender: TObject);
  private
    FSelectedChart: TTypeGraph;
    FTypesReports : TTypesReports;
    procedure SetTypesReports(AValue: TTypesReports);
    procedure ClearSeries;
    function  GetReportData: Boolean;
    function  SetGraphData: Boolean;
    function  SetGraphType(const GraphType: TTypeGraph): Boolean;
    function  SetFieldsValuesToSeries(DS: TDataSet): Boolean;
  public
  published
    property TypesReports: TTypesReports read FTypesReports write SetTypesReports;
  end;

var
  PrintManager    : TPrintManager;

implementation

uses Dado, mSysRel, CmmConst, mReport, ProcType, ArqSqlRel, SqlComm;

{$R *.DFM}

procedure TPrintManager.SetTypesReports(AValue: TTypesReports);
begin
  if AValue <> FTypesReports then
  begin
    FTypesReports := AValue;
    with rgSelPrinterManager do
    begin
      Items.Clear;
      if trPrinter in FTypesReports then
        Items.Add(Dados.GetStringMessage(LANGUAGE, 'strPrinter', 'Impressora'));
      if trScreen  in FTypesReports then
        Items.Add(Dados.GetStringMessage(LANGUAGE, 'strScreen',  'Tela'));
      if trGraph   in FTypesReports then
        Items.Add(Dados.GetStringMessage(LANGUAGE, 'strGraph',   'Gráfico'));
      if Items.Count > 0 then
        ItemIndex := 0
      else
        ItemIndex := -1;
    end;
  end;
end;

procedure TPrintManager.FormCreate(Sender: TObject);
begin
  Application.OnException := nil;
  Dados.Image16.GetBitmap(26, sbExecute.Glyph);
  Dados.Image16.GetBitmap(41, sbClose.Glyph);
  Dados.Image16.GetBitmap(02, sbHelp.Glyph);
  sbExecute.Caption  := Dados.GetStringMessage(LANGUAGE, 'sExecute', '&Executar');
  sbClose.Caption    := Dados.GetStringMessage(LANGUAGE, 'stbClose', '&Sair');
  sbHelp.Caption     := Dados.GetStringMessage(LANGUAGE, 'stbHelp', '&Ajuda');
  rgSelPrinterManager.Caption := Dados.GetStringMessage(LANGUAGE, 'srgSelPrinterManager', 'Seleção da &Visualização:');
end;

procedure TPrintManager.FormActivate(Sender: TObject);
begin
  Height       := 199;
  Width        := 273;
  ClientHeight := 172;
  ClientWidth  := 265;
  Left         := (Screen.Width  div 2) - (Width  div 2);
  Top          := (Screen.Height div 2) - (Height div 2);
  if not GetReportData then
  begin
    Dados.DisplayMessage(Format(Dados.GetStringMessage(LANGUAGE,
      'sReportNotFound', 'Erro: Não encontrei o relatório de código %d '),
      [Dados.Parametros.soPkRotine]), hiError);
    Close;
  end;
end;

procedure TPrintManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tcGraph.Visible then
  begin
    ClearSeries;
    pGraph.Visible      := False;
    tcGraph.Visible     := False;
    Height       := 199;
    Width        := 273;
    ClientHeight := 172;
    ClientWidth  := 265;
  end;
end;

function TPrintManager.GetReportData: Boolean;
var
  vTypesReports: TTypesReports;
  MS: TMemoryStream;
begin
  with dmSysRel do
  begin
    if qrReport.Active then qrReport.Close;
    qrReport.SQL.Clear;
    qrReport.SQL.Add(SqlRelProgram);
    qrReport.Params.ParamByName('Linguagem').AsString  := LANGUAGE;
    qrReport.Params.ParamByName('Modulo').AsInteger    := Dados.Parametros.soPkModule;
    qrReport.Params.ParamByName('Relatorio').AsInteger := Dados.Parametros.soProgramReport;
    if not qrReport.Active then qrReport.Open;
    Result := not qrReport.IsEmpty;
    if not Result then exit;
    vTypesReports := [trScreen, trPrinter];
    if (qrReport.FieldByName('FLAG_GRAPH').AsInteger = 1) then
      vTypesReports := [trGraph];
    if qrReport.FieldByName('REL_SYS').IsNull then
      vTypesReports := vTypesReports - [trScreen, trPrinter];
    TypesReports := vTypesReports;
    eReportTitle.Text := qrReport.FieldByName('DSC_REL').AsString;
    eGraphTitle.Text  := qrReport.FieldByName('DSC_GRAPH').AsString;
    if trGraph in vTypesReports then
    begin
      if Graphs.Active then Graphs.Close;
      Graphs.SQL.Clear;
      try
        if not Graphs.Active then Graphs.Open;
      except
        if Graphs.Active then Graphs.Close;
        vTypesReports := vTypesReports - [trGraph];
      end;
      if Odd(Graphs.FieldCount) then
        vTypesReports := vTypesReports - [trGraph];
      if Graphs.Active then Graphs.Close;
    end;
    with dmReport do
    begin
      MS := TMemoryStream.Create;
      try
        if qrReport.FieldByName('REL_SYS').IsBlob then
          TBlobField(qrReport.FieldByName('REL_SYS')).SaveToStream(MS);
        MS.Position := 0;
        frReport.LoadFromStream(MS);
        frReport.ReportOptions.Name   := qrReport.FieldByName('DSC_REL').AsString;
        frReport.ReportOptions.VersionMajor   := IntToStr(Dados.Parametros.soMajorVer);
        frReport.ReportOptions.VersionMinor   := IntToStr(Dados.Parametros.soMinorVer);
        frReport.ReportOptions.VersionBuild   := IntToStr(Dados.Parametros.soBuildVer);
        frReport.ReportOptions.VersionRelease := IntToStr(Dados.Parametros.soReleaseVer);
      finally
        MS.Free;
      end;
    end;
  end;
end;

function TPrintManager.SetGraphData: Boolean;
begin
  Result       := True;
  Height       := 550;
  Width        := 612;
  ClientHeight := 516;
  ClientWidth  := 604;
  Left         := (Screen.Width  div 2) - (Width  div 2);
  Top          := (Screen.Height div 2) - (Height div 2);
  tcGraph.Title.Text.Clear;
  cbGraphType.Items.Clear;
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgLine', 'Gráfico de Linhas 3D'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgBar', 'Gráfico de Barras'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgHorizontalBar', 'Gráfico de Barras Horizontais'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgArea', 'Gráfico de Área'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgPoint', 'Gráfico de Pontos'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgPie', 'Gráfico Pizza'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgFastLine', 'Gráfico de Linhas'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgShape', 'Gráfico de Formas Geométricas'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgGantt', 'Gráfico de Barras Flutuantes'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgArrow', 'Gráfico de Linhas 3D com Setas'));
  cbGraphType.Items.Add(Dados.GetStringMessage(LANGUAGE, 'stgBubble', 'Gráfico de Bolhas'));
  cbGraphType.ItemIndex := Integer(tgFastLine);
  tcGraph.Title.Text.Add(eGraphTitle.Text);
  FSelectedChart  := tgFastLine;
  tcGraph.Visible := True;
  pGraph.Visible  := True;
  cbGraphTypeCloseUp(cbGraphType);
end;

procedure TPrintManager.sbExecuteClick(Sender: TObject);
begin
  with dmReport do
  begin
    frReport.Tag := Dados.PkCompany;
    case  TTypeReport(rgSelPrinterManager.ItemIndex) of
      trPrinter:
        begin
          frReport.PrepareReport;
          frReport.Print;
        end;
      trScreen : frReport.ShowReport;
      trGraph  : tcGraph.Print;
    end;
  end;
end;

procedure TPrintManager.sbCloseClick(Sender: TObject);
begin
  eReportTitle.Text := '';
  eGraphTitle.Text  := '';
  Close;
end;

procedure TPrintManager.rgSelPrinterManagerClick(Sender: TObject);
begin
  if TTypeReport(rgSelPrinterManager.ItemIndex) = trGraph then
    SetGraphData;
end;

procedure TPrintManager.cbGraphTypeCloseUp(Sender: TObject);
begin
  SetGraphType(TTypeGraph(cbGraphType.ItemIndex));
end;

function  TPrintManager.SetGraphType(const GraphType: TTypeGraph): Boolean;
var
  V: Variant;
begin
  Result := True;
  with dmSysRel do
  begin
    if Graphs.Active then Graphs.Close;
    if Graphs.Params.Count > 0 then
      V := '';
    if not Graphs.Active then Graphs.Open;
    FSelectedChart := GraphType;
    SetFieldsValuesToSeries(Graphs);
  end;
end;

procedure TPrintManager.ClearSeries;
var
  i: Integer;
begin
  for i := 0 to tcGraph.SeriesCount - 1 do
    tcGraph.Series[i].Clear;
end;

function  TPrintManager.SetFieldsValuesToSeries(DS: TDataSet): Boolean;
var
  i, Idx, sr: Integer;
  ChartSerie: TChartSeries;
  vColor    : TColor;
  Colors    : array of TColor;
  function IndexOfColors(AColor: TColor): Integer;
  var
    j: Integer;
  begin
    Result := AColor;
    for j := 0 to High(Colors) do
      if Colors[j] = AColor then
        Result := -1;
  end;
begin
  Result := True;
  SetLength(Colors, DS.Fields.Count);
  sr := 0;
  for i := 0 to DS.Fields.Count - 1 do
  begin
    ChartSerie := nil;
    vColor     := Random(High(TColor));
    Idx        := 0;
    if not Odd(i) then
    begin
      case FSelectedChart of
        tgLine         : ChartSerie := TLineSeries.Create(tcGraph);
        tgBar          : ChartSerie := TBarSeries.Create(tcGraph);
        tgHorizontalBar: ChartSerie := THorizBarSeries.Create(tcGraph);
        tgArea         : ChartSerie := TAreaSeries.Create(tcGraph);
        tgPoint        : ChartSerie := TPointSeries.Create(tcGraph);
        tgPie          : ChartSerie := TPieSeries.Create(tcGraph);
        tgFastLine     : ChartSerie := TFastLineSeries.Create(tcGraph);
        tgShape        : ChartSerie := TChartShape.Create(tcGraph);
        tgGantt        : ChartSerie := TGanttSeries.Create(tcGraph);
        tgArrow        : ChartSerie := TArrowSeries.Create(tcGraph);
        tgBubble       : ChartSerie := TBubbleSeries.Create(tcGraph);
      end;
      while ((IndexOfColors(vColor) = -1) or (vColor = clBlue)) do
      begin
        vColor := Random(High(TColor));
        Colors[Idx] := vColor;
        Inc(Idx);
      end;
      if ChartSerie <> nil then
      begin
        tcGraph.AddSeries(ChartSerie);
        tcGraph.Series[sr].AddY(DS.Fields[i].AsFloat, DS.Fields[i].Name, vColor);
        Inc(sr);
      end;
    end
    else
     if (ChartSerie <> nil) and (i < DS.Fields.Count) then
       tcGraph.Series[sr].AddX(DS.Fields[i + 1].AsFloat, DS.Fields[i].Name, vColor);
  end;
  FillChar(Colors, SizeOf(Colors), 0);
  SetLength(Colors, 0);
end;

procedure TPrintManager.tcGraphMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  TmpTask: Longint;
  SerIdx : Integer;
begin
  if (X = 0) and (Y = 0) then exit;
  SerIdx  := tcGraph.SeriesList.IndexOf(tcGraph.GetASeries);
  TmpTask := tcGraph.Series[SerIdx].Clicked(X, Y);
  if tmpTask <> -1 then
    pStatus.Caption := FormatFloat('###,###,##0.00)',
      tcGraph.Series[SerIdx].YValues[tmpTask])
  else
    pStatus.Caption := '';
end;

procedure TPrintManager.tcGraphDblClick(Sender: TObject);
begin
//  Call Chart Editor
end;

initialization
  RegisterClass(TPrintManager);

end.
