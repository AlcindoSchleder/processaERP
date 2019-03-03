unit mSysRel;

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

uses DB, FMTBcd, SqlExpr, Classes, Forms;

type
  TdmSysRel = class(TDataModule)
    Printers  : TSQLQuery;
    Graphs    : TSQLQuery;
    qrReport: TSQLQuery;
    Modulos   : TSQLQuery;
    Linguagens: TSQLQuery;
    qrSqlAux  : TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FTraceMonitor: TNotifyEvent;
    function  LoadReport(const APkLng: string; M: TStream;
      const APkMod, APkRel: Integer): Boolean;
    function  SaveReport(const APkLng: string; M:TStream;
      const APkMod, APkRel: Integer): Boolean;
  end;

var
  dmSysRel: TdmSysRel;

implementation

uses ArqSqlRel, Dado, SysUtils, Dialogs, ProcUtils, TypInfo;

{$R *.DFM}

procedure TdmSysRel.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

function  TdmSysRel.LoadReport(const APkLng: string; M: TStream;
  const APkMod, APkRel: Integer): Boolean;
begin
  Result := False;
  if (APkLng = '') or (APkMod = 0) or (APkRel = 0) then exit;
  if qrReport.Active then qrReport.Close;
  qrReport.SQL.Clear;
  qrReport.SQL.Add(SqlGetReport);
  Dados.StartTransaction(qrReport);
  qrReport.ParamByName('Language').AsString := APkLng;
  qrReport.ParamByName('Module').AsInteger  := aPkMod;
  qrReport.ParamByName('Report').AsInteger  := APkRel;
  if not qrReport.Active then qrReport.Open;
  if (not qrReport.IsEmpty) and (qrReport.FindField('REL_SYS') <> nil) and
     (not qrReport.FindField('REL_SYS').IsNull) then
  begin
    Result := True;
    TBlobField(qrReport.FindField('REL_SYS')).SaveToStream(M);
  end;
  if qrReport.Active then qrReport.Close;
  Dados.CommitTransaction(qrReport);
end;

function  TdmSysRel.SaveReport(const APkLng: string; M: TStream;
  const APkMod, APkRel: Integer): Boolean;
begin
  Result := False;
  if (APkLng = '') or (APkMod = 0) or (APkRel = 0) or (M.Size = 0) then exit;
  if qrReport.Active then qrReport.Close;
  qrReport.SQL.Clear;
  qrReport.SQL.Add(SqlUpdReport);
  Dados.StartTransaction(qrReport);
  qrReport.ParamByName('FkLinguagens').AsString   := APkLng;
  qrReport.ParamByName('FkModulos').AsInteger     := aPkMod;
  qrReport.ParamByName('PkRelatorios').AsInteger  := APkRel;
  M.Position := 0;
  qrReport.ParamByName('RelSys').LoadFromStream(M, ftBlob);
  try
    Result := (qrReport.ExecSQL > 0);
  except
    Dados.RollbackTransaction(qrReport);
  end;
  Dados.CommitTransaction(qrReport);
end;

procedure TdmSysRel.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].InheritsFrom(TDataSet)) and
       (TDataSet(Components[i]).Active)       then
      TDataSet(Components[i]).Close;
  end;
end;

initialization
  Application.CreateForm(TdmSysRel, dmSysRel);

finalization
  if Assigned(dmSysRel) then dmSysRel.Free;
  dmSysRel := nil;

end.
