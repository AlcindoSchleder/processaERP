unit CadTipoComponentes;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 18/04/2006 - DD/MM/YYYY                                      *}
{* Modified:                                                             *}
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
  Dialogs, CadListModel, StdCtrls, VirtualTrees, ComCtrls, ToolWin, ExtCtrls,
  ProcUtils;

type
  TCdTipoComponentes = class(TfrmModelList)
    lDsc_TComp: TStaticText;
    eDsc_TComp: TEdit;
    ePk_Tipo_Componentes: TEdit;
    lPk_Tipo_Componentes: TStaticText;
    shTitle: TShape;
    lTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function GetDscComp: string;
    function GetPkTypeComponent: Integer;
    procedure SetDscComp(const Value: string);
    procedure SetPkTypeComponent(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkTypeComponent: Integer read GetPkTypeComponent write SetPkTypeComponent;
    property  DscComp        : string  read GetDscComp         write SetDscComp;
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysConf, TSysConfAux, ConfArqSql, ProcType, GridRow;

{$R *.dfm}

{ TCdTipoComponentes }

function TCdTipoComponentes.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscComp = '') then
  begin
    Dados.DisplayHint(eDsc_TComp, 'Campo descrição deve ser preenchido');
    Result := False;
  end;
end;

procedure TCdTipoComponentes.ClearControls;
begin
  Loading := True;
  try
    PkTypeComponent := 0;
    DscComp         := '';
  finally
    Loading := False;
  end;
end;

function TCdTipoComponentes.GetDscComp: string;
begin
  Result := eDsc_TComp.Text;
end;

function TCdTipoComponentes.GetPkTypeComponent: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Componentes.Text, 0);
end;

procedure TCdTipoComponentes.LoadDefaults;
begin
// nothing to do
end;

procedure TCdTipoComponentes.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysConf do
  begin
    if (qrTypeCmpnt.Active) then qrTypeCmpnt.Close;
    qrTypeCmpnt.SQL.Clear;
    qrTypeCmpnt.SQL.Add(SqlTypeComponents);
    Dados.StartTransaction(qrTypeCmpnt);
    vtList.BeginUpdate;
    try
      if (not qrTypeCmpnt.Active) then qrTypeCmpnt.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrTypeCmpnt, False);
      while (not qrTypeCmpnt.Eof) do
      begin
        AddDataNode(nil, qrTypeCmpnt);
        qrTypeCmpnt.Next;
      end;
    finally
      vtList.EndUpdate;
      if (qrTypeCmpnt.Active) then qrTypeCmpnt.Close;
      Dados.CommitTransaction(qrTypeCmpnt);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdTipoComponentes.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysConf.TypeComponent[Pk] do
    begin
      PkTypeComponent := PkComponent;
      DscComp         := DscTComp;
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdTipoComponentes.SaveIntoDB;
var
  aItem: TComponentType;
  Data : PGridData;
begin
  Loading := True;
  try
    aItem             := TComponentType.Create;
    aItem.PkComponent := PkTypeComponent;
    aItem.DscTComp    := DscComp;
    dmSysConf.TypeComponent[Ord(ScrState)] := aItem;
    PkTypeComponent   := aItem.PkComponent;
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['PK_TIPO_COMPONENTES'].AsInteger := PkTypeComponent;
        Data^.DataRow.FieldByName['DSC_TCOMP'].AsString            := DscComp;
      end;
    end;
  end;
  Pk := PkTypeComponent;
end;

procedure TCdTipoComponentes.SetDscComp(const Value: string);
begin
  eDsc_TComp.Text := Value;
end;

procedure TCdTipoComponentes.SetPkTypeComponent(const Value: Integer);
begin
  ePk_Tipo_Componentes.Text := IntToStr(Value);
end;

procedure TCdTipoComponentes.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdTipoComponentes.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.Node = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_TCOMP'].AsString;
end;

procedure TCdTipoComponentes.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.Node = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_COMPONENTES'].AsInteger;
end;

initialization
  RegisterClass(TCdTipoComponentes);

end.
