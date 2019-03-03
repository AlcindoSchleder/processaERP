unit CadRegs;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 06/03/2003 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : (alcindo@sistemaprocessa.com.br)                           *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadModel, StdCtrls, Mask, ToolEdit, CurrEdit, VirtualTrees,
  ComCtrls, ToolWin, GridRow, ProcUtils;

type
  TCdRegioes = class(TfrmModelList)
    lPk_Regioes_Dsct: TStaticText;
    ePk_Regioes_Dsct: TEdit;
    lDsct_Max: TStaticText;
    eDsct_Max: TCurrencyEdit;
    eFk_Paises: TComboBox;
    lFk_Paises: TStaticText;
    lDsc_RegD: TStaticText;
    eDsc_RegD: TEdit;
    vtStates: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure vtStatesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtStatesChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure vtStatesInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscRegD: string;
    function  GetDsctMax: Double;
    function  GetFkCountry: Double;
    function  GetFkStates: TDataRow;
    function  GetPkRegionDsct: Integer;
    procedure SetDscRegD(const Value: string);
    procedure SetDsctMax(const Value: Double);
    procedure SetFkCountry(const Value: Double);
    procedure SetFkStates(const Value: TDataRow);
    procedure SetPkRegionDsct(const Value: Integer);
    procedure SaveStateData;
    procedure HandleRegDsctAfterScroll;
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure DeleteFromDB; override;
    procedure LoadDefaults; override;
    procedure LoadList; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkRegionsDsct: Integer  read GetPkRegionDsct write SetPkRegionDsct;
    property  DscRegD      : string   read GetDscRegD      write SetDscRegD;
    property  DsctMax      : Double   read GetDsctMax      write SetDsctMax;
    property  FkCountry    : Double   read GetFkCountry    write SetFkCountry;
    property  FkStates     : TDataRow read GetFkStates     write SetFkStates;
  public
    { Public declarations }
  end;

var
  CdRegioes: TCdRegioes;

implementation

uses Dado, mSysPed, DB, ProcType, PedArqSql, FuncoesDB;

{$R *.dfm}

{ TfrmModelList1 }

function TCdRegioes.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin

end;

procedure TCdRegioes.ClearControls;
begin
  inherited;

end;

procedure TCdRegioes.DeleteFromDB;
begin
  inherited;

end;

function TCdRegioes.GetDscRegD: string;
begin

end;

function TCdRegioes.GetDsctMax: Double;
begin

end;

function TCdRegioes.GetFkCountry: Double;
begin

end;

function TCdRegioes.GetFkStates: TDataRow;
begin
  Result := FkStates;
end;

function TCdRegioes.GetPkRegionDsct: Integer;
begin

end;

procedure TCdRegioes.LoadDefaults;
begin
  inherited;

end;

procedure TCdRegioes.LoadList;
begin
  inherited;

end;

procedure TCdRegioes.MoveDataToControls;
begin
  inherited;

end;

procedure TCdRegioes.SaveIntoDB;
begin
  inherited;

end;

procedure TCdRegioes.SetDscRegD(const Value: string);
begin

end;

procedure TCdRegioes.SetDsctMax(const Value: Double);
begin

end;

procedure TCdRegioes.SetFkCountry(const Value: Double);
begin

end;

procedure TCdRegioes.SetPkRegionDsct(const Value: Integer);
begin

end;

procedure TCdRegioes.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

procedure TCdRegioes.vtStatesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data     := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Data^.Level = 1 then
    CellText := Data^.DataRow.Fields[1].AsString
  else
    CellText := Data^.DataRow.Fields[0].AsString;
  if (Data^.DataRow.FindField['FK_REGIOES_DSCT'] <> nil) and
     (not Data^.DataRow.FindField['FK_REGIOES_DSCT'].IsNull) then
    Node.CheckState := csCheckedNormal
  else
    Node.CheckState := csUnCheckedNormal;
end;

procedure TCdRegioes.vtStatesChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Allowed := (vtStates.Enabled);
  if (Allowed) and (Node.CheckState <> NewState) then
  begin
    Data := Sender.GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) or
       (Data^.DataRow.FindField['FK_REGIOES_DSCT'] = nil) then
      exit;
    Data^.DataRow.FindField['FK_REGIOES_DSCT'].Clear;
  end;
end;

procedure TCdRegioes.vtStatesInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
  if ParentNode <> nil then
  begin
    Node.CheckType  := ctCheckBox;
    Node.CheckState := csUncheckedNormal;
  end;
end;

procedure TCdRegioes.SaveStateData;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  vtStates.EndEditNode;
  vtStates.FocusedColumn := 0;
// Delete all lines of vtStates from database and reopen dataSet to insert records
  with dmSysPed do
  begin
    if InsStateRegs.Active then InsStateRegs.Close;
    InsStateRegs.Sql.Clear;
    InsStateRegs.Sql.Add(SqlDeleteStateRegs);
    if (not InsStateRegs.Active) then InsStateRegs.ExecSQL;
      InsStateRegs.Sql.Clear;
      InsStateRegs.Sql.Add(SqlInsertStateRegs);
      // Save all lines of vtStates into database
      Node := vtStates.GetFirst;
      while Node <> nil do
      begin
        if Node.CheckState = csCheckedNormal then
        begin
          Data := vtStates.GetNodeData(Node);
          if (not Data^.DataRow.FieldByName['FK_REGIOES_DSCT'].IsNull) and
             (InsStateRegs.Params.FindParam('FkRegioesDsct') <> nil) and
             (Node.CheckState = csCheckedNormal) then
          begin
            InsStateRegs.Params.FindParam('FkPaises').AsInteger      := Data^.DataRow.FieldByName['PK_PAISES'].AsInteger;
            InsStateRegs.Params.FindParam('FkEstados').AsString      := Data^.DataRow.FieldByName['PK_ESTADOS'].AsString;
            try
              InsStateRegs.ExecSQL;
            except on E:Exception do
              begin
                vtStates.Selected[Node] := True;
                exit;
              end; // begin exception
            end; // try
          end; // if Field.IsNull
        end; // if Node.State
        Node := vtStates.GetNext(Node);
      end; // while
      if InsStateRegs.Active then dmSysPed.InsStateRegs.Close;
  end; // if of delete records
end;

procedure TCdRegioes.HandleRegDsctAfterScroll;
var
  Node      ,
  ParentNode: PVirtualNode;
  Data      : PGridData;
  AFkPaises : Integer;
begin
  AFkPaises  := 0;
  ParentNode := nil;
  if vtStates.RootNodeCount > 0 then
    ReleaseTreeNodes(vtStates);
  with dmSysPed do
  begin
    if InsStateRegs.Active then InsStateRegs.Close;
    InsStateRegs.SQL.Clear;
    InsStateRegs.SQL.Add(SqlVincRegDsctEst);
    if not InsStateRegs.Active then InsStateRegs.Open;
    vtStates.BeginUpdate;
    vtStates.NodeDataSize := SizeOf(TGridData);;
    try
      if not InsStateRegs.IsEmpty then
      begin
        InsStateRegs.First;
        if InsStateRegs.FindField('PK_PAISES') <> nil then
        begin
          while not InsStateRegs.Eof do
          begin
            if InsStateRegs.FindField('PK_PAISES').AsInteger <> AFkPaises then
            begin
              Node       := vtStates.AddChild(nil);
              ParentNode := Node;
              if Node <> nil then
              begin
                Data           := vtStates.GetNodeData(Node);
                Data^.Level    := vtStates.GetNodeLevel(Node);
                Data^.Node     := Node;
                Data^.DataRow  := TDataRow.CreateFromDataSet(nil, InsStateRegs, True);
              end;
            end;
            Node := vtStates.AddChild(ParentNode);
            if Node <> nil then
            begin
              Data           := vtStates.GetNodeData(Node);
              Data^.Level    := vtStates.GetNodeLevel(Node);
              Data^.Node     := Node;
              Data^.DataRow  := TDataRow.CreateFromDataSet(nil, InsStateRegs, True);
            end;
            AFkPaises := InsStateRegs.FindField('PK_PAISES').AsInteger;
            InsStateRegs.Next;
          end;
        end;
      end;
    finally
      if InsStateRegs.Active then InsStateRegs.Close;
      vtStates.EndUpdate;
      vtStates.FullExpand;
    end;
  end;
end;

procedure TCdRegioes.SetFkStates(const Value: TDataRow);
begin

end;

initialization
  RegisterClass(TCdRegioes);
end.
