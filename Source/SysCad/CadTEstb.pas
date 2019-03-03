unit CadTEstb;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
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
  Dialogs, CadListModel, StdCtrls, VirtualTrees, ComCtrls, ToolWin, TSysCadAux,
  ProcUtils, GridRow, ExtCtrls;

type
  TCdEstabelecimentos = class(TfrmModelList)
    lPk_Tipo_Estabelecimento: TStaticText;
    ePk_Tipo_Estabelecimento: TEdit;
    eDsc_Test: TEdit;
    lDsc_Test: TStaticText;
    shTitle: TShape;
    lTitle: TLabel;
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    function  GetTypeEstablishment   : TDataRow;
    function  GetPKTypeEstablishment : Integer;
    function  GetDscTest             : String;
    procedure SetTypeEstablishment      (const Value :TDataRow);
    procedure SetPKTypeEstablishment    (const Value :Integer);
    procedure SetDscTest                (const Value :String );
    procedure InsertNewData(Sender: TObject; var Row: TDataRow);
  protected
    { Protected declarations }
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
  public
    { Public declarations }
    property TypeEstablishment   : TDataRow read GetTypeEstablishment    write  SetTypeEstablishment;
    property PKTypeEstablishment : Integer  read GetPKTypeEstablishment  write  SetPKTypeEstablishment;
    property DscTest             : String   read GetDscTest              write  SetDscTest;
  end;

var
  CdEstabelecimentos: TCdEstabelecimentos;

implementation

uses Dado, ProcType, DB, mSysCad, CadArqSql;

{$R *.dfm}

{ TCdEstabelecimentos }

procedure TCdEstabelecimentos.ClearControls;
begin
  Loading := True;
  try
    PkTypeEstablishment := 0;
    DscTest            := '';
  finally
    Loading := False;
  end;
end;

function TCdEstabelecimentos.GetPkTypeEstablishment: Integer;
begin
  Result := StrToIntDef(ePK_Tipo_Estabelecimento.Text,0);
end;

function TCdEstabelecimentos.GetDscTest: String;
begin
  Result := eDsc_Test.Text;
end;

function TCdEstabelecimentos.GetTypeEstablishment : TDataRow;
begin
  Result := TDataRow.Create(nil);
  Result.AddAs('PK_TIPO_ESTABELECIMENTOS', PkTypeEstablishment, ftInteger, SizeOf(Integer));
  Result.AddAs('DSC_TEST', DscTest, ftString, 31);
end;

procedure TCdEstabelecimentos.SetTypeEstablishment(const Value: TDataRow);
begin
  if Value = nil then exit;
  PkTypeEstablishment  := Value.FieldByName['PK_TIPO_ESTABELECIMENTOS'].asInteger;
  DscTest              := Value.FieldByName['DSC_TEST'].asString;
end;

procedure TCdEstabelecimentos.SetPKTypeEstablishment(const Value: Integer);
begin
  ePk_Tipo_Estabelecimento.Text := IntToStr(Value);
end;

procedure TCdEstabelecimentos.SetDscTest(const Value: String);
begin
  eDsc_Test.Text := Value;
end;

procedure TCdEstabelecimentos.LoadDefaults;
begin
  // nothing to do
end;

procedure TCdEstabelecimentos.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysCad do
  begin
    if qrTipoEstblc.Active then qrTipoEstblc.Close;
    qrTipoEstblc.SQL.Clear;
    qrTipoEstblc.SQL.Add(SqlEstabelecimentos);
    Dados.StartTransaction(qrTipoEstblc);
    try
      if not qrTipoEstblc.Active then qrTipoEstblc.Open;
      RowModel := TDataRow.CreateFromDataSet(Self, qrTipoEstblc, False);
      while not qrTipoEstblc.Eof do
      begin
        AddDataNode(nil, qrTipoEstblc);
        qrTipoEstblc.Next;
      end;
    finally
      if qrTipoEstblc.Active then qrTipoEstblc.Close;
      Dados.CommitTransaction(qrTipoEstblc);
    end;
  end;
  if vtList.RootNodeCount > 0 then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.GetFirst] := True;
  end;
end;

procedure TCdEstabelecimentos.MoveDataToControls;
begin
  Loading := True;
  try
    TypeEstablishment := dmSysCad.GetEstablishment(PK);
  finally
    Loading := False;
  end;
end;

procedure TCdEstabelecimentos.SaveIntoDB;
var
  aPK : Integer;
begin
  aPK := dmSysCad.SaveTypeEstablishment(TypeEstablishment, ScrState);
  if FocusedRow <> nil then
  begin
    FocusedRow.FieldByName['PK_TIPO_ESTABELECIMENTOS'].AsInteger := aPK;
    FocusedRow.FieldByName['DSC_TEST'].asString                  := DscTest;
  end;
  Pk := aPK;
end;

function TCdEstabelecimentos.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C : TControl;
  S : String;
begin
  Result := True;
  C := nil;
  if DscTest = '' then
  begin
    S := 'Campo Descrição deve ser preenchido!';
    C := eDsc_Test;
  end;
  if S <> '' then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdEstabelecimentos.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data : PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then Exit;
  PK := Data^.DataRow.FieldByName['PK_TIPO_ESTABELECIMENTOS'].AsInteger;
end;

procedure TCdEstabelecimentos.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data : PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Column <> 0) then Exit;
  CellText := Data^.DataRow.FieldByName['DSC_TEST'].AsString;
end;

procedure TCdEstabelecimentos.InsertNewData(Sender: TObject;
  var Row: TDataRow);
begin
  Row.AddAs('PK_TIPO_ESTABELECIMENTOS', PkTypeEstablishment, ftInteger, SizeOf(Integer));
  Row.AddAs('DSC_TEST', DscTest, ftString, 31);
end;

procedure TCdEstabelecimentos.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnInsert      := InsertNewData;
  OnListLoad    := LoadList;
  inherited;
end;

initialization
  RegisterClass(TCdEstabelecimentos);

end.
