unit ScrReport;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 12/05/2007 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, GridRow, frxClass, StdCtrls, ExtCtrls, DB, Variants;

type
  TfrmScreenReport = class(TForm)
    pbProgress: TProgressBar;
    sbStatus: TStatusBar;
    sbPrint: TSpeedButton;
    sbCancel: TSpeedButton;
    Shape1: TShape;
    lTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbPrintClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
  private
    { Private declarations }
    FParamList    : TList;
    FPkReport     : Integer;
    FDscReport    : string;
    FMainDataSet: string;
    function  GetDraftMode: Boolean;
    function  LoadReport: Boolean;
    procedure SetPkReport(const Value: Integer);
    procedure SetDataSetParams(const Value: TDataRow);
    procedure SetDraftMode(const Value: Boolean);
    procedure ReportProgressStart(Sender: TfrxReport;
                ProgressType: TfrxProgressType; Progress: Integer);
    procedure ReportProgress(Sender: TfrxReport;
                ProgressType: TfrxProgressType; Progress: Integer);
    procedure ReportProgressStop(Sender: TfrxReport;
                ProgressType: TfrxProgressType; Progress: Integer);
    procedure SetDscReport(const Value: string);
    procedure OpenActiveDataSet(AParams: TDataRow);
    procedure frReportBeginDoc(Sender: TObject);
  public
    { Public declarations }
  published
    { Published declarations }
    property MainDataSet  : string      read FMainDataSet     write FMainDataSet;
    property DscReport    : string      read FDscReport       write SetDscReport;
    property PkReport     : Integer     read FPkReport        write SetPkReport;
    property DataSetParams: TDataRow                          write SetDataSetParams;
    property DraftMode    : Boolean     read GetDraftMode     write SetDraftMode;
  end;

var
  frmScreenReport: TfrmScreenReport;

implementation

uses mReport, Dado, mSysRel, SqlComm, CmmConst, frxDBXComponents, ProcUtils,
  ArqSqlRel, ProcType;

{$R *.dfm}

{ TfrmScreenReport }

function  TfrmScreenReport.LoadReport: Boolean;
var
  MS: TMemoryStream;
begin
  Result := True;
  with dmSysRel do
  begin
    if qrReport.Active then qrReport.Close;
    qrReport.SQL.Clear;
    qrReport.SQL.Add(SqlReport);
    qrReport.Params.ParamByName('FkLinguagens').AsString  := LANGUAGE;
    qrReport.Params.ParamByName('FkModulos').AsInteger    := Dados.Parametros.soPkModule;
    qrReport.Params.ParamByName('PkRelatorios').AsInteger := FPkReport;
    if not qrReport.Active then qrReport.Open;
    if (not qrReport.IsEmpty) then
    begin
      DscReport := qrReport.FieldByName('DSC_REL').AsString;
      with dmReport do
      begin
        MS := TMemoryStream.Create;
        try
          if qrReport.FieldByName('REL_SYS').IsBlob then
            TBlobField(qrReport.FieldByName('REL_SYS')).SaveToStream(MS);
          MS.Position := 0;
          frReport.LoadFromStream(MS);
          frReport.ReportOptions.Name           := qrReport.FieldByName('DSC_REL').AsString;
          frReport.ReportOptions.VersionMajor   := IntToStr(Dados.Parametros.soMajorVer);
          frReport.ReportOptions.VersionMinor   := IntToStr(Dados.Parametros.soMinorVer);
          frReport.ReportOptions.VersionBuild   := IntToStr(Dados.Parametros.soBuildVer);
          frReport.ReportOptions.VersionRelease := IntToStr(Dados.Parametros.soReleaseVer);
          frReport.ScriptLanguage := 'PascalScript';
        finally
          FreeAndNil(MS);
        end;
        frReport.PrepareReport;
      end;
    end
    else
    begin
      Dados.DisplayMessage(Format('LoadReport: O relatório %d/%d não foi ' +
        'encontrado no banco de dados', [Dados.Parametros.soPkModule, FPkReport]), hiError);
      Result := False;
    end;
  end;
end;

procedure TfrmScreenReport.SetPkReport(const Value: Integer);
begin
  FPkReport := Value;
  LoadReport;
end;

procedure TfrmScreenReport.SetDataSetParams(const Value: TDataRow);
var
  aItem: TDataRow;
begin
  if (MainDataSet = '') then raise Exception.Create('Erro: Fonte de dados principal não definida');
  if (Value = nil) then
    FParamList.Clear
  else
  begin
    aItem := TDataRow.Create(Self);
    aItem.Assign(Value);
    aItem.CopyRowValues(Value, True);
    FParamList.Add(aItem);
  end;
end;

procedure TfrmScreenReport.FormCreate(Sender: TObject);
begin
  FParamList     := TList.Create;
  Dados.Image16.GetBitmap(6, sbPrint.Glyph);
  Dados.Image16.GetBitmap(41, sbCancel.Glyph);
  DraftMode := False;
  pbProgress.Position := 0;
  pbProgress.Max      := 0;
  dmReport.frReport.ShowProgress := False;
  dmReport.OnProgressStart := ReportProgressStart;
  dmReport.OnProgress      := ReportProgress;
  dmReport.OnProgressStop  := ReportProgressStop;
end;

procedure TfrmScreenReport.SetDraftMode(const Value: Boolean);
begin
  dmReport.frReport.DotMatrixReport := False;
end;

function TfrmScreenReport.GetDraftMode: Boolean;
begin
  Result := dmReport.frReport.DotMatrixReport;
end;

procedure TfrmScreenReport.ReportProgressStart(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  pbProgress.Position := Progress;
end;

procedure TfrmScreenReport.ReportProgress(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if (pbProgress.Max <= (Progress + 1)) then pbProgress.Max := Progress + 1;
  pbProgress.Position := Progress;
end;

procedure TfrmScreenReport.ReportProgressStop(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if (pbProgress.Max > Progress) then pbProgress.Max := Progress;
  pbProgress.Position := Progress;
end;

procedure TfrmScreenReport.FormDestroy(Sender: TObject);
begin
  FParamList.Clear;
  FParamList.Free;
  FParamList := nil;
end;

procedure TfrmScreenReport.sbPrintClick(Sender: TObject);
begin
  dmReport.frReport.OnBeginDoc := frReportBeginDoc;
  dmReport.frReport.PrepareReport;
//  dmReport.frReport.ShowReport;
  dmReport.frReport.Print;
  Close;
end;

procedure TfrmScreenReport.sbCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmScreenReport.SetDscReport(const Value: string);
begin
  FDscReport := Value;
  LTitle.Caption := Value;
end;

procedure TfrmScreenReport.OpenActiveDataSet(AParams: TDataRow);
var
  i: Integer;
  aDS: TfrxDataSet;
begin
  aDs := nil;
  with dmReport.frReport do
  begin
    for i := 0 to DataSets.Count - 1 do
      if (DataSets.Items[i].DataSetName = AParams.DataSetName) then
        aDS := DataSets.Items[i].DataSet;
    if (aDS = nil) then
      raise Exception.CreateFmt('SetDataSetName: O componente de acesso a ' + NL +
        'tabela %s não pode ser encontrado', [AParams.DataSetName]);
  end;
  if (aDS = nil) or (not (aDS is TfrxDBXQuery)) then exit;
  if (AParams.UserData <> nil) and (AParams.UserData is TStrings) and
     (TStrings(AParams.UserData).Count > 0) then
  begin
    if TfrxDBXQuery(aDS).Active then TfrxDBXQuery(aDS).Close;
    TfrxDBXQuery(aDS).SQL.Clear;
    TfrxDBXQuery(aDS).SQL.Assign(TStrings(AParams.UserData));
  end;
  if (TfrxDBXQuery(aDS).Params.Count > 0) then
  begin
    if (AParams <> nil) and (AParams.Count > 0) and
       (TfrxDBXQuery(aDS).Name = AParams.DataSetName) and
       (TfrxDBXQuery(aDS).Params.Count = AParams.Count) then
    begin
      for i := 0 to TfrxDBXQuery(aDS).Params.Count - 1 do
        if (AParams.FindField[TfrxDBXQuery(aDS).Params.Items[i].Name] <> nil) then
        begin
          TfrxDBXQuery(aDS).Params.Items[i].Expression := '';
          TfrxDBXQuery(aDS).Params.Items[i].Value := AParams.Fields[i].Value;
        end;
    end;
  end
  else
    if (not TfrxDBXQuery(aDS).Active)  then TfrxDBXQuery(aDS).Open;
end;

procedure TfrmScreenReport.frReportBeginDoc(Sender: TObject);
var
  i: Integer;
  aParams: TDataRow;
begin
  for i := 0 to FParamList.Count - 1 do
  begin
    if (FParamList.Items[i] <> nil) then
    begin
      aParams := TDataRow(FParamList.Items[i]);
      OpenActiveDataSet(aParams);
    end;
  end;
  dmReport.frDataset.Open;
end;

initialization
  RegisterClass(TfrmScreenReport);

end.
