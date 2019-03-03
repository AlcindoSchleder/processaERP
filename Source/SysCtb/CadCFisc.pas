unit CadCFisc;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 10/07/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadListModel, StdCtrls, VirtualTrees, ComCtrls, ToolWin, ProcUtils,
  ExtCtrls;

type
  TCdClassFisc = class(TfrmModelList)
    lPk_Classificacao_Fiscal: TStaticText;
    ePk_Classificacao_Fiscal: TEdit;
    lDsc_ClsF: TStaticText;
    eDsc_ClsF: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function  GetDscClsF: string;
    function  GetPkFiscalClass: string;
    procedure SetDscClsF(const Value: string);
    procedure SetPkFiscalClass(const Value: string);
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
    property  PkFiscalClass: string read GetPkFiscalClass write SetPkFiscalClass;
    property  DscClsF      : string read GetDscClsF       write SetDscClsF;
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysCtb, CtbArqSql, GridRow, ProcType;

{$R *.dfm}

{ TCdClassFisc }

function TCdClassFisc.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C: TControl;
  S: string;
begin
  Result := True;
  C := nil;
  S := '';
  if (PkFiscalClass = '') or (StrToIntDef(PkFiscalClass, -1) = -1) then
  begin
    C := ePk_Classificacao_Fiscal;
    S := 'Campo Código Fiscal deve ser preenchido com um número ' + NL +
         'positivo representando o código fiscal do produto';
  end;
  if (DscClsF = '') then
  begin
    C := eDsc_ClsF;
    S := 'Campo Descrição deve ser preenchido';
  end;
  if (C = nil) and (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdClassFisc.ClearControls;
begin
  Loading := True;
  try
    PkFiscalClass := '';
    DscClsF       := '';
  finally
    Loading := False;
  end;
  ePk_Classificacao_Fiscal.Enabled := (Pk = 0);
  lPk_Classificacao_Fiscal.Enabled := (Pk = 0);
end;

function TCdClassFisc.GetDscClsF: string;
begin
  Result := eDsc_ClsF.Text;
end;

function TCdClassFisc.GetPkFiscalClass: string;
begin
  Result := ePk_Classificacao_Fiscal.Text;
end;

procedure TCdClassFisc.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdClassFisc.LoadList(Sender: TObject);
begin
  inherited;
  vtList.BeginUpdate;
  with dmSysCtb do
  begin
    Dados.StartTransaction(qrSqlAux);
    try
      if qrSqlAux.Active then qrSqlAux.Close;
      qrSqlAux.SQL.Clear;
      qrSqlAux.SQL.Add(SqlGetFiscalClass);
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(nil, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        AddDataNode(nil, qrSqlAux);
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
      vtList.EndUpdate;
    end;
  end;
  ePk_Classificacao_Fiscal.Enabled := (Pk = 0);
  lPk_Classificacao_Fiscal.Enabled := (Pk = 0);
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdClassFisc.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysCtb.FiscalClass[Pk] do
    begin
      PkFiscalClass := FieldByName['PK_CLASSIFICACAO_FISCAL'].AsString;
      DscClsF       := FieldByName['DSC_CLSF'].AsString;
    end;
  finally
    Loading := False;
  end;
  ePk_Classificacao_Fiscal.Enabled := (Pk = 0);
  lPk_Classificacao_Fiscal.Enabled := (Pk = 0);
end;

procedure TCdClassFisc.SaveIntoDB;
var
  aItem: TDataRow;
  Data : PGridData;
begin
  aItem := dmSysCtb.FiscalClass[0];
  aItem.FieldByName['PK_CLASSIFICACAO_FISCAL'].AsString := PkFiscalClass;
  aItem.FieldByName['DSC_CLSF'].AsString                := DscClsF;
  dmSysCtb.FiscalClass[Ord(ScrState)] := aItem;
  if (vtList.FocusedNode <> nil) then
  begin
    Data := vtList.GetNodeData(vtList.FocusedNode);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      Data^.DataRow.FieldByName['PK_CLASSIFICACAO_FISCAL'].AsString := PkFiscalClass;
      Data^.DataRow.FieldByName['DSC_CLSF'].AsString                := DscClsF;
    end;
  end;
  Pk := StrToInt(PkFiscalClass);
end;

procedure TCdClassFisc.SetDscClsF(const Value: string);
begin
  eDsc_ClsF.Text := Value;
end;

procedure TCdClassFisc.SetPkFiscalClass(const Value: string);
begin
  ePk_Classificacao_Fiscal.Text := Value;
end;

procedure TCdClassFisc.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdClassFisc.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := StrToIntDef(Data^.DataRow.FieldByName['PK_CLASSIFICACAO_FISCAL'].AsString, 0);
  ePk_Classificacao_Fiscal.Enabled := (Pk = 0);
  lPk_Classificacao_Fiscal.Enabled := (Pk = 0);
end;

procedure TCdClassFisc.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['PK_CLASSIFICACAO_FISCAL'].AsString + ' : ' +
              Data^.DataRow.FieldByName['DSC_CLSF'].AsString;
end;

initialization
  RegisterClass(TCdClassFisc);

end.
