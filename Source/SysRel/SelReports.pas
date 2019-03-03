unit SelReports;

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
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, ProcUtils;

type
  TOnChangeRptEvt = procedure (Sender: TObject; AReport: TMemoryStream) of object;

  TfrmPrgReports = class(TForm)
    vtReportList: TVirtualStringTree;
    procedure FormShow(Sender: TObject);
    procedure vtReportListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtReportListGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    { Private declarations }
    FModule        : Integer;
    FRotine        : Integer;
    FProgram       : Integer;
    FOnChangeReport: TOnChangeRptEvt;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; const AModule, ARotine,
                  AProgram: Integer); reintroduce;
    property  OnChangeReport: TOnChangeRptEvt read FOnChangeReport write FOnChangeReport;
  end;

var
  frmPrgReports: TfrmPrgReports;

implementation

{$R *.dfm}

uses Dado, mSysRel, ArqSqlRel, ProcType, GridRow, Db;

constructor TfrmPrgReports.Create(AOwner: TComponent; const AModule, ARotine,
  AProgram: Integer);
begin
  inherited Create(AOwner);
  FModule  := AModule;
  FRotine  := ARotine;
  FProgram := AProgram;
  vtReportList.Header.Columns[0].Text := Dados.Parametros.soProgramTitle;
end;

procedure TfrmPrgReports.FormShow(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
  i   : Integer;
begin
  with dmSysRel do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlPrgReports);
    i := 0;
    Dados.StartTransaction(qrReport);
    try
      qrSqlAux.ParamByName('FkModulos').AsInteger   := FModule;
      qrSqlAux.ParamByName('FkRotinas').AsInteger   := FRotine;
      qrSqlAux.ParamByName('FkProgramas').AsInteger := FProgram;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.Eof) do
      begin
        Node := vtReportList.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtReportList.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Node  := Node;
            Data^.Level := 0;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
            Inc(i);
            Data^.DataRow.AddAs('ITM', i, ftInteger, SizeOf(Integer));
          end;
        end;
        qrSqlAux.Next;
      end;
    finally
      qrSqlAux.Close;
      Dados.CommitTransaction(qrReport);
    end;
  end;
end;

procedure TfrmPrgReports.vtReportListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
  MS: TStream;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Assigned(FOnChangeReport)) then
  begin
    MS := TMemoryStream.Create;
    try
      MS.Position := 0;
      Data^.DataRow.FieldByName['REL_SYS'].SaveToStream(MS, buValue);
      FOnChangeReport(Self, MS as TMemoryStream);
    finally
      FreeAndNil(MS);
    end;
  end;
end;

procedure TfrmPrgReports.vtReportListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['ITM'].AsString     + ' / ' +
              Data^.DataRow.FieldByName['DSC_PRG'].AsString + ' / ' +
              Data^.DataRow.FieldByName['DSC_REL'].AsString;
end;

end.
