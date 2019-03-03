unit CadParams;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 18/04/2003 - DD/MM/YYYY                                    *}
{* Modified : 18/05/2003 - DD/MM/YYYY                                    *}
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
  Dialogs, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ProcUtils, ExtCtrls,
  CadListModel;

type
  TCdParams = class(TfrmModelList)
    eFk_Tipo_Documentos: TComboBox;
    eFk_Cadastros: TComboBox;
    eFk_Grupos_Movimentos: TComboBox;
    eFk_Tipo_Movimentos: TComboBox;
    gbTitle: TGroupBox;
    lTitle: TLabel;
    lFk_Tipo_Documentos: TStaticText;
    lFk_Cadastros: TStaticText;
    lFk_Grupos_Movimentos: TStaticText;
    lFk_Tipo_Movimentos: TStaticText;
    eFk_Finalizadoras: TComboBox;
    lFk_Finalizadoras: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure eFk_Grupos_MovimentosSelect(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetFkGroupMovement: Integer;
    function  GetFkOwner: Integer;
    function  GetFkTipoDocument: Integer;
    function  GetFkTypeMovement: Integer;
    procedure SetFkGroupMovement(const Value: Integer);
    procedure SetFkOwner(const Value: Integer);
    procedure SetFkTipoDocument(const Value: Integer);
    procedure SetFkTypeMovement(const Value: Integer);
    function GetFkFinalizer: Integer;
    procedure SetFkFinalizer(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property FkTipoDocument : Integer read GetFkTipoDocument  write SetFkTipoDocument;
    property FkOwner        : Integer read GetFkOwner         write SetFkOwner;
    property FkGroupMovement: Integer read GetFkGroupMovement write SetFkGroupMovement;
    property FkTypeMovement : Integer read GetFkTypeMovement  write SetFkTypeMovement;
    property FkFinalizer    : Integer read GetFkFinalizer     write SetFkFinalizer;
  end;

var
  CdParams: TCdParams;

implementation

uses Dado, mSysBr, GridRow, DB, ProcType, ArqSqlBr;

{$R *.dfm}

{ TCdParams }

function TCdParams.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  S := '';
  C := nil;
  Result := True;
  if (FkGroupMovement = 0) then
  begin
    C := eFk_Grupos_Movimentos;
    S := 'Campo Grupo de Venda deve ser preenchido';
  end;
  if (FkOwner = 0) then
  begin
    C := eFk_Cadastros;
    S := 'Campo cliente default deve ser preenchido';
  end;
  if (FkFinalizer = 0) then
  begin
    C := eFk_Finalizadoras;
    S := 'Campo Finalizadora default deve ser preenchido';
  end;
  if (FkTipoDocument = 0) then
  begin
    C := eFk_Tipo_Documentos;
    S := 'Campo tipo de documento default deve ser preenchido';
  end;
  if (FkTypeMovement = 0) then
  begin
    C := eFk_Tipo_Movimentos;
    S := 'Campo tipo de movimentação da venda default deve ser preenchido';
  end;
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdParams.ClearControls;
begin
  Loading := True;
  try
    FkTipoDocument  := 0;
    FkOwner         := 0;
    FkGroupMovement := 0;
    FkTypeMovement  := 0;
  finally
    Loading := False;
  end;
end;

function TCdParams.GetFkFinalizer: Integer;
begin
  Result := 0;
  with eFk_Finalizadoras do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdParams.GetFkGroupMovement: Integer;
begin
  Result := 0;
  with eFk_Grupos_Movimentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdParams.GetFkOwner: Integer;
begin
  Result := 0;
  with eFk_Cadastros do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdParams.GetFkTipoDocument: Integer;
begin
  Result := 0;
  with eFk_Tipo_Documentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdParams.GetFkTypeMovement: Integer;
begin
  Result := 0;
  with eFk_Tipo_Movimentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

procedure TCdParams.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Cadastros.Items.AddStrings(dmSysBr.LoadOwners);
    eFk_Tipo_Documentos.Items.AddStrings(dmSysBr.LoadTypeDocuments);
    eFk_Grupos_Movimentos.Items.AddStrings(dmSysBr.LoadGroupMovements);
    eFk_Finalizadoras.Items.AddStrings(dmSysBr.LoadFinalizers);
    ListLoaded := True;
  end;
end;

procedure TCdParams.LoadList(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  inherited;
  with dmSysBr, vtList do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlAllParams);
    BeginUpdate;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    try
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(nil, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        Node := AddChild(nil);
        if (Node <> nil) then
        begin
          Data := GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
            Data^.Level   := 0;
            Data^.Node    := Node;
          end;
        end;
        qrSqlAux.Next;
      end;
    finally
      EndUpdate;
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
    if (RootNodeCount > 0) then
    begin
      FocusedNode         := GetFirst;
      Selected[FocusedNode] := True;
    end;
  end;
end;

procedure TCdParams.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysBr.ParamsBr[Pk] do
    begin
      FkTipoDocument  := FieldByName['FK_TIPO_DOCUMENTOS'].AsInteger;
      FkOwner         := FieldByName['FK_CADASTROS'].AsInteger;
      FkFinalizer     := FieldByName['FK_FINALIZADORAS'].AsInteger;
      FkGroupMovement := FieldByName['FK_GRUPOS_MOVIMENTOS'].AsInteger;
      FkTypeMovement  := FieldByName['FK_TIPO_MOVIMENTOS'].AsInteger;
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdParams.SaveIntoDB;
var
  aData: TDataRow;
  Data : PGridData;
  APk  : Integer;
begin
  if (vtList.FocusedNode = nil) then exit;
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  APk := Data^.DataRow.FieldByName['PK_EMPRESAS'].AsInteger;
  if (APk = 0) then exit;
  aData := TDataRow.Create(nil);
  try
    aData.AddAs('FK_EMPRESAS', APk, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_TIPO_DOCUMENTOS', FkTipoDocument, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_CADASTROS', FkOwner, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_FINALIZADORAS', FkFinalizer, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_GRUPOS_MOVIMENTOS', FkGroupMovement, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_TIPO_MOVIMENTOS', FkTypeMovement, ftInteger, SizeOf(Integer));
    dmSysBr.ParamsBr[Ord(ScrState)] := aData;
  finally
    FreeAndNil(aData);
  end;
end;

procedure TCdParams.SetFkFinalizer(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Finalizadoras do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParams.SetFkGroupMovement(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Grupos_Movimentos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        eFk_Tipo_Movimentos.Items.AddStrings(dmSysBr.LoadTypeMovements(i));
        break;
      end;
  end;
end;

procedure TCdParams.SetFkOwner(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Cadastros do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParams.SetFkTipoDocument(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Documentos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParams.SetFkTypeMovement(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Movimentos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParams.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdParams.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
end;

procedure TCdParams.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['FK_EMPRESAS'].AsInteger;
end;

procedure TCdParams.eFk_Grupos_MovimentosSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Grupos_Movimentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      eFk_Tipo_Movimentos.Items.AddStrings(dmSysBr.LoadTypeMovements(
        Integer(Items.Objects[ItemIndex])));
end;

procedure TCdParams.tbInsertClick(Sender: TObject);
begin
  Dados.DisplayMessage('Não posso inserir registros dependentes da empresa',
    hiError);
  exit;
  inherited;
end;

initialization
  RegisterClass(TCdParams);

end.
