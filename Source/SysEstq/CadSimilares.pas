unit CadSimilares;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created  : 02/06/2003                                                 *}
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ProcUtils,
  ExtCtrls;

type
  TCdSimilares = class(TfrmModelList)
    lPk_Similares: TStaticText;
    ePk_Similares: TEdit;
    eDsc_Sim: TEdit;
    lDsc_Sim: TStaticText;
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure FormCreate(Sender: TObject);
  private
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    procedure CreateModel;
    function  GetDscSim: string;
    function  GetPkSimilar: Integer;
    procedure SetDscSim(const Value: string);
    procedure SetPkSimilar(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  PkSimilar: Integer read GetPkSimilar write SetPkSimilar;
    property  DscSim   : string  read GetDscSim    write SetDscSim;
  end;

var
  CdSimilares: TCdSimilares;

implementation

uses Dado, mSysEstq, DB, ProcType, GridRow, TSysEstqAux;

{$R *.dfm}

{ TCdSimilares }

procedure TCdSimilares.ClearControls;
begin
  Loading := True;
  try
    PkSimilar := 0;
    DscSim    := '';
  finally
    Loading := False;
  end;
end;

procedure TCdSimilares.CreateModel;
begin
  if (RowModel = nil) or (RowModel.Count = 0) then
  begin
    if (RowModel = nil) then
      RowModel := TDataRow.Create(Self);
    RowModel.AddAs('PK_SIMILARES', 0, ftInteger, SizeOf(Integer));
    RowModel.AddAs('DSC_SIM', '', ftString, 31);
  end;
end;

function TCdSimilares.GetDscSim: string;
begin
  Result := eDsc_Sim.Text;
end;

function TCdSimilares.GetPkSimilar: Integer;
begin
  Result := StrToIntDef(ePk_Similares.Text, 0);
end;

procedure TCdSimilares.LoadDefaults;
begin
// nothing to do
end;

procedure TCdSimilares.LoadList(Sender: TObject);
var
  aStr: TStrings;
  Node: PVirtualNode;
  Data: PGridData;
  i   : Integer;
begin
  inherited;
  CreateModel;
  aStr := dmSysEstq.LoadSimilar(False);
  vtList.BeginUpdate;
  try
    for i := 0 to aStr.Count -1 do
    begin
      if (aStr.Objects[i] <> nil) then
      begin
        Node := vtList.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtList.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.Create(nil);
            Data^.DataRow.AddAs('PK_SIMILARES', TSimilar(aStr.Objects[i]).PkSimilar, ftInteger, SizeOf(Integer));
            Data^.DataRow.AddAs('DSC_SIM', TSimilar(aStr.Objects[i]).DscSim, ftString, 31);
          end;
        end;
      end;
    end;
  finally
    vtList.EndUpdate;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdSimilares.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysEstq.Similar[Pk] do
    begin
      PkSimilar := FieldByName['PK_SIMILARES'].AsInteger;
      DscSim    := FieldByName['DSC_SIM'].AsString;
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdSimilares.SaveIntoDB;
var
  aRow: TDataRow;
  Data: PGridData;
begin
  if (RowModel = nil) then CreateModel;
  aRow := TDataRow.Create(nil);
  try
    aRow.AddAs('PK_SIMILARES', PkSimilar, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC_SIM', DscSim, ftString, 31);
    dmSysEstq.Similar[Ord(ScrState)]           := aRow;
    PkSimilar := aRow.FieldByName['PK_SIMILARES'].AsInteger;
  finally
    FreeAndNil(aRow);
  end;
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['PK_SIMILARES'].AsInteger := PkSimilar;
        Data^.DataRow.FieldByName['DSC_SIM'].AsString       := DscSim;
      end;
    end;
  end;
  Pk := PkSimilar;
end;

procedure TCdSimilares.SetDscSim(const Value: string);
begin
  eDsc_Sim.Text := Value;
end;

procedure TCdSimilares.SetPkSimilar(const Value: Integer);
begin
  ePk_Similares.Text := IntToStr(Value);
end;

procedure TCdSimilares.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.Node = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_SIM'].AsString;
end;

procedure TCdSimilares.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.Node = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_SIMILARES'].AsInteger;
end;

procedure TCdSimilares.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

function TCdSimilares.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscSim = '') then
  begin
    Dados.DisplayHint(eDsc_Sim, 'Campo descrição deve conter um valor');
    Result := False;
  end;
end;

initialization
  RegisterClass(TCdSimilares);

end.
