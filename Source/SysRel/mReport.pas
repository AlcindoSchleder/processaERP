unit mReport;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder based in the TdbObjects from CSD Informática *}
{* Copyright: © 2004 by Alcindo Schleder. All rights reserved.           *}
{* Created: 09/09/2004 - DD/MM/YYYY                                      *}
{* Modified: 09/02/2006 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails.                  *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  SysUtils, Classes, Dado, frxExportPDF, frxExportImage, frxExportRTF,
  frxExportXML, frxExportXLS, frxExportHTML, frxExportTXT, frxClass,
  frxGZip, frxDMPExport, frxOLE, frxChart, frxGradient, frxChBox, frxRich,
  frxCross, frxDCtrl, frxBarcode, frxDBSet, frxDBXComponents, Forms,
  frxExportCSV, frxExportMail, fs_iinterpreter;

type
  TSaveReport = function (M: TMemoryStream): Boolean of object;

  TdmReport = class(TDataModule)
    frBarCode: TfrxBarCodeObject;
    fDialogs: TfrxDialogControls;
    frCrossObject: TfrxCrossObject;
    frRichText: TfrxRichObject;
    frCheckBox: TfrxCheckBoxObject;
    frGradient: TfrxGradientObject;
    frChart: TfrxChartObject;
    frOLE: TfrxOLEObject;
    frDotMatrix: TfrxDotMatrixExport;
    frCompressor: TfrxGZipCompressor;
    frTXT: TfrxTXTExport;
    frHTML: TfrxHTMLExport;
    frXLS: TfrxXLSExport;
    frXML: TfrxXMLExport;
    frRTF: TfrxRTFExport;
    frBMP: TfrxBMPExport;
    frJPEG: TfrxJPEGExport;
    frTIFF: TfrxTIFFExport;
    frPDF: TfrxPDFExport;
    frDBX: TfrxDBXComponents;
    frDataset: TfrxDBDataset;
    frUserDataSet: TfrxUserDataSet;
    frReport: TfrxReport;
    frxMail: TfrxMailExport;
    frxCSV: TfrxCSVExport;
    frxGIF: TfrxGIFExport;
    fsScript: TfsScript;
    procedure DataModuleCreate(Sender: TObject);
    procedure frReportBeginDoc(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure frReportProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure frReportProgressStop(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure frReportProgress(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
  private
    { Private declarations }
    FFkLng          : string;
    FFkMod          : Integer;
    FPkRel          : Integer;
    FOnSaveReport   : TSaveReport;
    FOnProgress     : TfrxProgressEvent;
    FOnProgressStart: TfrxProgressEvent;
    FOnProgressStop : TfrxProgressEvent;
  public
    { Public declarations }
    procedure CreateNewReport;
    property FkLng          : string            read FFkLng           write FFkLng;
    property FkMod          : Integer           read FFkMod           write FFkMod;
    property PkRel          : Integer           read FPkRel           write FPkRel;
    property OnSaveReport   : TSaveReport       read FOnSaveReport    write FOnSaveReport;
    property OnProgress     : TfrxProgressEvent read FOnProgress      write FOnProgress;
    property OnProgressStart: TfrxProgressEvent read FOnProgressStart write FOnProgressStart;
    property OnProgressStop : TfrxProgressEvent read FOnProgressStop  write FOnProgressStop;
  end;

var
  dmReport: TdmReport;

implementation

uses mSysRel, Dialogs, SqlComm, Printers;

{$R *.dfm}

procedure TdmReport.DataModuleCreate(Sender: TObject);
begin
  frDBX.DefaultDatabase := Dados.Conexao;
  frDataSet.DataSet     := Dados.qrEmpresa;
  with Dados do
  begin
    if qrEmpresa.Active then qrEmpresa.Close;
    qrEmpresa.SQL.Clear;
    qrEmpresa.SQL.Add(SqlEmpresa);
    if qrEmpresa.Params.FindParam('PkEmpresas') <> nil then
      qrEmpresa.Params.FindParam('PkEmpresas').AsInteger := PkCompany;
    if not qrEmpresa.Active then qrEmpresa.Open;
  end;
end;

procedure TdmReport.frReportBeginDoc(Sender: TObject);
begin
  frDataSet.Open;
end;

procedure TdmReport.DataModuleDestroy(Sender: TObject);
begin
  if frDataSet.DataSet.Active then frDataSet.Close;
  with Dados do
    if qrEmpresa.Active then qrEmpresa.Close;
end;

procedure TdmReport.CreateNewReport;
var
  aPage    : TfrxReportPage;
  aBand    : TfrxBand;
  aDataBand: TfrxMasterData;
  aDataSet : TfrxDBXQuery;
begin
  frReport.Clear;
  aDataSet := TfrxDBXQuery.Create(nil);
  aDataSet.Name := 'qrReport';
  frReport.DataSets.Add(aDataSet);
  { add a page }
  aPage := TfrxReportPage.Create(frReport);
  { create a unique name }
  aPage.CreateUniqueName;
  { set sizes of fields, paper and orientation by default }
  aPage.SetDefaults;
  { modify paper’s orientation }
  aPage.Orientation := poLandscape;
  { add a report title band}
  aBand := TfrxPageHeader.Create(aPage);
  aBand.CreateUniqueName;
  { it is sufficient to set the «Top» coordinate and height for a band }
  { both coordinates are in pixels }
  aBand.Top := 0;
  aBand.Height := 20;
  aDataBand := TfrxMasterData.Create(aPage);
  aDataBand.CreateUniqueName;
  aDataBand.DataSet := aDataSet;
  aDataBand.Top := 100;
  aDataBand.Height := 20;
  { add a report Footer band}
  aBand := TfrxPageFooter.Create(aPage);
  aBand.CreateUniqueName;
  { the Top coordinate should be greater than the previously added band’s
  top + height}
  aBand.Top := 200;
  aBand.Height := 20;
end;

procedure TdmReport.frReportProgressStart(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if Assigned(FOnProgressStart) then
    FOnProgressStart(Sender, ProgressType, Progress);
end;

procedure TdmReport.frReportProgressStop(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if Assigned(FOnProgressStop) then
    FOnProgressStop(Sender, ProgressType, Progress);
end;

procedure TdmReport.frReportProgress(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if Assigned(FOnProgress) then
    FOnProgress(Sender, ProgressType, Progress);
end;

initialization
  Application.CreateForm(TdmReport, dmReport);

finalization
  if Assigned(dmReport) then dmReport.Free;
  dmReport := nil;

end.
