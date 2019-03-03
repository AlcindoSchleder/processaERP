unit CadTStt;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 19/05/2007 - DD/MM/YYYY                                    *}
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
  Dialogs, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ExtCtrls, ProcUtils,
  CadListModel;

type
  TCdTypeStatus = class(TfrmModelList)
    lPk_Manifestos_Status: TStaticText;
    ePk_Manifestos_Status: TEdit;
    eDsc_MStt: TEdit;
    shTitle: TShape;
    lTitle: TLabel;
    lFlag_Niv_Occ: TRadioGroup;
    lDsc_MStt: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscMStt: string;
    function  GetFlagNivOcc: Integer;
    function  GetPkManisfestStatus: Integer;
    procedure SetDscMStt(const Value: string);
    procedure SetFlagNivOcc(const Value: Integer);
    procedure SetPkManisfestStatus(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  PkManisfestStatus: Integer read GetPkManisfestStatus write SetPkManisfestStatus;
    property  DscMStt          : string  read GetDscMStt           write SetDscMStt;
    property  FlagNivOcc       : Integer read GetFlagNivOcc        write SetFlagNivOcc;
  end;

implementation

uses Dado, mSysTrans, GridRow, DB, ArqSqlTrans, ProcType;

{$R *.dfm}

{ TCdTypeStatus }

function TCdTypeStatus.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C : TControl;
  S : String;
begin
  Result := True;
  C := nil;
  if DscMStt = '' then
  begin
    S := 'Campo Descrição deve ser preenchido!';
    C := eDsc_MStt;
  end;
  if S <> '' then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTypeStatus.ClearControls;
begin
  Loading := True;
  try
    PkManisfestStatus := 0;
    DscMStt           := '';
    FlagNivOcc        := 0;
  finally
    Loading := False;
  end;
end;

function TCdTypeStatus.GetDscMStt: string;
begin
  Result := eDsc_MStt.Text;
end;

function TCdTypeStatus.GetFlagNivOcc: Integer;
begin
  Result := lFlag_Niv_Occ.ItemIndex;
end;

function TCdTypeStatus.GetPkManisfestStatus: Integer;
begin
  Result := Pk;
end;

procedure TCdTypeStatus.LoadDefaults;
begin
  if (not ListLoaded) then
    ListLoaded := True;
end;

procedure TCdTypeStatus.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysTrans do
  begin
    if qrTypeManifest.Active then qrTypeManifest.Close;
    qrTypeManifest.SQL.Clear;
    qrTypeManifest.SQL.Add(SqlManifestsStatus);
    Dados.StartTransaction(qrTypeManifest);
    try
      if not qrTypeManifest.Active then qrTypeManifest.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(nil, qrTypeManifest, False);
      while not qrTypeManifest.Eof do
      begin
        AddDataNode(nil, qrTypeManifest);
        qrTypeManifest.Next;
      end;
    finally
      if qrTypeManifest.Active then qrTypeManifest.Close;
      Dados.CommitTransaction(qrTypeManifest);
    end;
  end;
  if vtList.RootNodeCount > 0 then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.GetFirst] := True;
  end;
end;

procedure TCdTypeStatus.MoveDataToControls;
var
  aItem: TDataRow;
begin
  Loading := True;
  try
    aItem := dmSysTrans.ManifestStatus[Pk];
    PkManisfestStatus := aItem.FieldByName['PK_MANIFESTOS_STATUS'].AsInteger;
    DscMStt           := aItem.FieldByName['DSC_MSTT'].AsString;
    FlagNivOcc        := aItem.FieldByName['FLAG_NIV_OCC'].AsInteger;
  finally
    Loading := False;
  end;
end;

procedure TCdTypeStatus.SaveIntoDB;
var
  aItem: TDataRow;
begin
  Loading := True;
  aItem   := TDataRow.Create(Self);
  try
    aItem.AddAs('PK_MANIFESTOS_STATUS', PkManisfestStatus, ftInteger, SizeOf(Integer));
    aItem.AddAs('DSC_MSTT', DscMStt, ftString, 31);
    aItem.AddAs('FLAG_NIV_OCC', FlagNivOcc, ftInteger, SizeOf(Integer));
    dmSysTrans.ManifestStatus[Ord(ScrState)] := aItem;
    if (FocusedRow <> nil) then
    begin
      FocusedRow.FieldByName['PK_MANIFESTOS_STATUS'].AsInteger := aItem.FieldByName['PK_MANIFESTOS_STATUS'].AsInteger;
      FocusedRow.FieldByName['DSC_MSTT'].AsString              := DscMStt;
    end;
    Pk := aItem.FieldByName['PK_MANIFESTOS_STATUS'].AsInteger;
  finally
    FreeAndNil(aItem);
    Loading := False;
  end;
end;

procedure TCdTypeStatus.SetDscMStt(const Value: string);
begin
  eDsc_MStt.Text := Value;
end;

procedure TCdTypeStatus.SetFlagNivOcc(const Value: Integer);
begin
  lFlag_Niv_Occ.ItemIndex := Value;
end;

procedure TCdTypeStatus.SetPkManisfestStatus(const Value: Integer);
begin
  ePk_Manifestos_Status.Text := IntToStr(Value);
end;

procedure TCdTypeStatus.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdTypeStatus.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data : PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then Exit;
  SearchField := 'DSC_MSTT';
  PK := Data^.DataRow.FieldByName['PK_MANIFESTOS_STATUS'].AsInteger;
end;

procedure TCdTypeStatus.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data : PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Column <> 0) then Exit;
  CellText := Data^.DataRow.FieldByName['DSC_MSTT'].AsString;
end;

initialization
  RegisterClass(TCdTypeStatus);

end.
