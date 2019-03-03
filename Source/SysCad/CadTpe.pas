unit CadTpe;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 28/12/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 2.0.0.0                                                    *}
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
  Dialogs, CadModel, StdCtrls, VirtualTrees, ComCtrls, ToolWin, ProcUtils,
  ExtCtrls, CadListModel;

type
  TCdTipoEnd = class(TfrmModelList)
    lPk_Tipo_Enderecos: TStaticText;
    ePk_Tipo_Enderecos: TEdit;
    lDsc_Tpe: TStaticText;
    eDsc_Tpe: TEdit;
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
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function  GetDscAddress: string;
    function  GetPkTypeAddress: Integer;
    procedure SetDscAddress(const Value: string);
    procedure SetPkTypeAddress(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
  public
    { Public declarations }
    property PkTypeAddress: Integer  read GetPkTypeAddress write  SetPkTypeAddress;
    property DscAddress   : string   read GetDscAddress    write  SetDscAddress;
  end;

implementation

uses Dado, mSysCad, GridRow, CadArqSql, TSysCadAux, ProcType;

{$R *.dfm}

function TCdTipoEnd.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C : TControl;
  S : String;
begin
  Result := True;
  S      := '';
  C      := nil;
  if (DscAddress = '') then
  begin
    S := 'Campo Descrição deve ser preenchido!';
    C := eDsc_Tpe;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTipoEnd.ClearControls;
begin
  Loading := True;
  try
    PkTypeAddress := 0;
    DscAddress    := '';
  finally
    loading := False;
  end;
end;

procedure TCdTipoEnd.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

function TCdTipoEnd.GetDscAddress: string;
begin
  Result := eDsc_Tpe.Text;
end;

function TCdTipoEnd.GetPkTypeAddress: Integer;
begin
  Result := Pk;
end;

procedure TCdTipoEnd.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdTipoEnd.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysCad, vtList do
  begin
    if (qrTypeAddr.Active) then qrTypeAddr.Close;
    qrTypeAddr.SQL.Clear;
    qrTypeAddr.SQL.Add(SqlTypeAddresses);
    Dados.StartTransaction(qrTypeAddr);
    if (not qrTypeAddr.Active) then qrTypeAddr.Open;
    try
      RowModel := TDataRow.CreateFromDataSet(Self, qrTypeAddr, False);
      while not qrTypeAddr.Eof do
      begin
        AddDataNode(nil, qrTypeAddr);
        qrTypeAddr.Next;
      end;
    finally
      if (qrTypeAddr.Active) then qrTypeAddr.Close;
      Dados.CommitTransaction(qrTypeAddr);
    end;
  end;
  if vtList.RootNodeCount > 0 then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.GetFirst] := True;
  end;
end;

procedure TCdTipoEnd.MoveDataToControls;
var
  Data: TAddressType;
begin
  Loading := True;
  try
    Data          := dmSysCad.AddrType[Pk];
    PkTypeAddress := Data.PkAddressType;
    DscAddress    := Data.DscTEnd;
  finally
    Loading := False;
  end;
end;

procedure TCdTipoEnd.SaveIntoDB;
var
  Recd: TAddressType;
  Data: PGridData;
begin
  Recd := TAddressType.Create;
  try
    Recd.PkAddressType    := PkTypeAddress;
    Recd.DscTEnd          := DscAddress;
    dmSysCad.AddrType[Ord(ScrState)] := Recd;
    if (vtList.FocusedNode <> nil) then
    begin
      Data                := vtList.GetNodeData(vtList.FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['PK_TIPO_ENDERECOS'].AsInteger := Recd.PkAddressType;
        Data^.DataRow.FieldByName['DSC_TPE'].AsString            := Recd.DscTEnd;
      end;
    end;
    Pk                    := Recd.PkAddressType;
  finally
    FreeAndNil(Recd);                                              
  end;
end;

procedure TCdTipoEnd.SetDscAddress(const Value: string);
begin
  eDsc_Tpe.Text := Value;
end;

procedure TCdTipoEnd.SetPkTypeAddress(const Value: Integer);
begin
  ePk_Tipo_Enderecos.Text := IntToStr(Value);
end;

procedure TCdTipoEnd.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['PK_TIPO_ENDERECOS'].AsString + ' / ' +
              Data^.DataRow.FieldByName['DSC_TPE'].AsString;
end;

procedure TCdTipoEnd.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_ENDERECOS'].AsInteger;
end;

initialization
  RegisterClass(TCdTipoEnd);

end.
