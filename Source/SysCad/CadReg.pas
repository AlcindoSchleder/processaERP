unit CadReg;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 22/01/2007 - DD/MM/YYYY                                    *}
{* Modified : 22/01/2007 - DD/MM/YYYY                                    *}
{* Version  : 1.0.0.0                                                    *}
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
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ExtCtrls,
  ProcUtils;

type
  TCdRegions = class(TfrmModelList)
    shTitle: TShape;
    lTitle: TLabel;
    lPk_Cargas_Regioes: TStaticText;
    ePk_Cargas_Regioes: TEdit;
    lDsc_Reg: TStaticText;
    eDsc_Reg: TEdit;
    lRef_Reg: TStaticText;
    eRef_Reg: TEdit;
    lFlag_Generic: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function GetDscReg: string;
    function GetFlagGen: Boolean;
    function GetPkRegions: Integer;
    function GetRefReg: string;
    procedure SetDscReg(const Value: string);
    procedure SetFlagGen(const Value: Boolean);
    procedure SetPkRegions(const Value: Integer);
    procedure SetRefReg(const Value: string);
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
  public
    { Public declarations }
    property PkRegions: Integer read GetPkRegions write SetPkRegions;
    property DscReg   : string  read GetDscReg    write SetDscReg;
    property RefReg   : string  read GetRefReg    write SetRefReg;
    property FlagGen  : Boolean read GetFlagGen   write SetFlagGen;
  end;

var
  CdRegions: TCdRegions;

implementation

uses Dado, mSysCad, GridRow, ProcType, CadArqSql, DB;

{$R *.dfm}

function TCdRegions.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C : TControl;
  S : String;
begin
  Result := True;
  S      := '';
  C      := nil;
  if (DscReg = '') then
  begin
    S := 'Campo Descrição deve ser preenchido!';
    C := eDsc_Reg;
  end;
  if (RefReg = '') then
  begin
    S := 'Campo Referência deve ser preenchido!';
    C := eRef_Reg;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdRegions.ClearControls;
begin
  Loading := True;
  try
    PkRegions := 0;
    DscReg    := '';
    RefReg    := '';
    FlagGen   := True;
  finally
    Loading := False;
  end;
end;

procedure TCdRegions.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

function TCdRegions.GetDscReg: string;
begin
  Result := eDsc_Reg.Text;
end;

function TCdRegions.GetFlagGen: Boolean;
begin
  Result := lFlag_Generic.Checked;
end;

function TCdRegions.GetPkRegions: Integer;
begin
  Result := Pk;
end;

function TCdRegions.GetRefReg: string;
begin
  Result := eRef_Reg.Text;
end;

procedure TCdRegions.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdRegions.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysCad, vtList do
  begin
    if (qrRegions.Active) then qrRegions.Close;
    qrRegions.SQL.Clear;
    qrRegions.SQL.Add(SqlRegions);
    Dados.StartTransaction(qrRegions);
    if (not qrRegions.Active) then qrRegions.Open;
    try
      RowModel := TDataRow.CreateFromDataSet(Self, qrRegions, False);
      while not qrRegions.Eof do
      begin
        AddDataNode(nil, qrRegions);
        qrRegions.Next;
      end;
    finally
      if (qrRegions.Active) then qrRegions.Close;
      Dados.CommitTransaction(qrRegions);
    end;
  end;
  if vtList.RootNodeCount > 0 then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.GetFirst] := True;
  end;
end;

procedure TCdRegions.MoveDataToControls;
var
  Data: TDataRow;
begin
  Loading := True;
  try
    Data      := dmSysCad.Regions[Pk];
    PkRegions := Pk;
    if (Data = nil) then exit;
    if (Data.FindField['DSC_REG'] <> nil) then
      DscReg    := Data.FieldByName['DSC_REG'].AsString;
    if (Data.FindField['REF_REG'] <> nil) then
      RefReg    := Data.FieldByName['REF_REG'].AsString;;
    if (Data.FindField['FLAG_GENERIC'] <> nil) then
      FlagGen   := Boolean(Data.FieldByName['FLAG_GENERIC'].AsInteger);
  finally
    Loading := False;
  end;
end;

procedure TCdRegions.SaveIntoDB;
var
  Recd: TDataRow;
  Data: PGridData;
begin
  Recd := TDataRow.Create(Self);
  try
    Recd.AddAs('PK_CARGAS_REGIOES', Pk, ftInteger, SizeOf(Integer));
    Recd.AddAs('DSC_REG', DscReg, ftString, 31);
    Recd.AddAs('REF_REG', RefReg, ftString, 11);
    Recd.AddAs('FLAG_GENERIC', Ord(FlagGen), ftInteger, SizeOf(Integer));
    dmSysCad.Regions[Ord(ScrState)] := Recd;
    if (vtList.FocusedNode <> nil) then
    begin
      Data                := vtList.GetNodeData(vtList.FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['PK_CARGAS_REGIOES'].AsInteger :=
          Recd.FieldByName['PK_CARGAS_REGIOES'].AsInteger;
        Data^.DataRow.FieldByName['DSC_REG'].AsString            :=
          Recd.FieldByName['DSC_REG'].AsString;
      end;
    end;
    Pk := Recd.FieldByName['PK_CARGAS_REGIOES'].AsInteger;
  finally
    FreeAndNil(Recd);
  end;
end;

procedure TCdRegions.SetDscReg(const Value: string);
begin
  eDsc_Reg.Text := Value;
end;

procedure TCdRegions.SetFlagGen(const Value: Boolean);
begin
  lFlag_Generic.Checked := Value;
end;

procedure TCdRegions.SetPkRegions(const Value: Integer);
begin
  ePk_Cargas_Regioes.Text := IntToStr(Value);
end;

procedure TCdRegions.SetRefReg(const Value: string);
begin
  eRef_Reg.Text := Value;
end;

procedure TCdRegions.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['PK_CARGAS_REGIOES'].AsString + ' / ' +
              Data^.DataRow.FieldByName['DSC_REG'].AsString;
end;

procedure TCdRegions.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_CARGAS_REGIOES'].AsInteger;
end;

initialization
  RegisterClass(TCdRegions);

end.
