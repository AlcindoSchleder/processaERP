unit CadTMnfst;

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
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ExtCtrls,
  ProcUtils;

type
  TCdTypeManifest = class(TfrmModelList)
    lPk_Tipo_Manifestos: TStaticText;
    ePk_Tipo_Manifestos: TEdit;
    lDsc_TMnf: TStaticText;
    eDsc_TMnf: TEdit;
    shTitle: TShape;
    lTitle: TLabel;
    lFlag_TCnh: TRadioGroup;
    eFk_Tipo_Documentos: TComboBox;
    lFk_Tipo_Documentos: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscTMnf: string;
    function  GetFkTypeDocument: Integer;
    function  GetFlagTCnh: Integer;
    function  GetPkTypeManifest: Integer;
    procedure SetDscTMnf(const Value: string);
    procedure SetFkTypeDocument(const Value: Integer);
    procedure SetFlagTCnh(const Value: Integer);
    procedure SetPkTypeManifest(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  PkTypeManifest: Integer read GetPkTypeManifest write SetPkTypeManifest;
    property  DscTMnf       : string  read GetDscTMnf        write SetDscTMnf;
    property  FkTypeDocument: Integer read GetFkTypeDocument write SetFkTypeDocument;
    property  FlagTCnh      : Integer read GetFlagTCnh       write SetFlagTCnh;
  end;

implementation

uses Dado, mSysTrans, GridRow, DB, ArqSqlTrans, ProcType;

{$R *.dfm}

{ TCdTypeManifest }

function TCdTypeManifest.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C : TControl;
  S : String;
begin
  Result := True;
  C := nil;
  if DscTMnf = '' then
  begin
    S := 'Campo Descrição deve ser preenchido!';
    C := eDsc_TMnf;
  end;
  if (FkTypeDocument < 0) then
    begin
      C := eFk_Tipo_Documentos;
      S := 'Campo Tipo de Documento deve ser preenchido!';
    end;
  if S <> '' then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTypeManifest.ClearControls;
begin
  Loading := True;
  try
    PkTypeManifest := 0;
    DscTMnf        := '';
    FkTypeDocument := 0;
    FlagTCnh       := 0;
  finally
    Loading := False;
  end;
end;

function TCdTypeManifest.GetDscTMnf: string;
begin
  Result := eDsc_TMnf.Text;
end;

function TCdTypeManifest.GetFkTypeDocument: Integer;
begin
  with eFk_Tipo_Documentos do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdTypeManifest.GetFlagTCnh: Integer;
begin
  Result := lFlag_TCnh.ItemIndex;
end;

function TCdTypeManifest.GetPkTypeManifest: Integer;
begin
  Result := Pk;
end;

procedure TCdTypeManifest.LoadDefaults;
begin
  if (not ListLoaded) then
    eFk_Tipo_Documentos.Items.AddStrings(dmSysTrans.LoadTypeDocument);
end;

procedure TCdTypeManifest.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysTrans do
  begin
    if qrTypeManifest.Active then qrTypeManifest.Close;
    qrTypeManifest.SQL.Clear;
    qrTypeManifest.SQL.Add(SqlTypeManifests);
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

procedure TCdTypeManifest.MoveDataToControls;
var
  aItem: TDataRow;
begin
  Loading := True;
  try
    aItem := dmSysTrans.TypeManifest[Pk];
    PkTypeManifest := aItem.FieldByName['PK_TIPO_MANIFESTOS'].AsInteger;
    DscTMnf        := aItem.FieldByName['DSC_TMNF'].AsString;
    FkTypeDocument := aItem.FieldByName['FK_TIPO_DOCUMENTOS'].AsInteger;
    FlagTCnh       := aItem.FieldByName['FLAG_TCNH'].AsInteger;
  finally
    Loading := False;
  end;
end;

procedure TCdTypeManifest.SaveIntoDB;
var
  aItem: TDataRow;
begin
  Loading := True;
  aItem   := TDataRow.Create(Self);
  try
    aItem.AddAs('PK_TIPO_MANIFESTOS', PkTypeManifest, ftInteger, SizeOf(Integer));
    aItem.AddAs('DSC_TMNF', DscTMnf, ftString, 31);
    aItem.AddAs('FK_TIPO_DOCUMENTOS', FkTypeDocument, ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_TCNH', FlagTCnh, ftInteger, SizeOf(Integer));
    dmSysTrans.TypeManifest[Ord(ScrState)] := aItem;
    if (FocusedRow <> nil) then
    begin
      FocusedRow.FieldByName['PK_TIPO_MANIFESTOS'].AsInteger := aItem.FieldByName['PK_TIPO_MANIFESTOS'].AsInteger;
      FocusedRow.FieldByName['DSC_TMNF'].AsString            := DscTMnf;
    end;
    Pk := aItem.FieldByName['PK_TIPO_MANIFESTOS'].AsInteger;
  finally
    FreeAndNil(aItem);
    Loading := False;
  end;
end;

procedure TCdTypeManifest.SetDscTMnf(const Value: string);
begin
  eDsc_TMnf.Text := Value;
end;

procedure TCdTypeManifest.SetFkTypeDocument(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Documentos do
  begin
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTypeManifest.SetFlagTCnh(const Value: Integer);
begin
  lFlag_TCnh.ItemIndex := Value;
end;

procedure TCdTypeManifest.SetPkTypeManifest(const Value: Integer);
begin
  ePk_Tipo_Manifestos.Text := IntToStr(Value);
end;

procedure TCdTypeManifest.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdTypeManifest.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data : PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then Exit;
  SearchField := 'DSC_TMNF';
  PK := Data^.DataRow.FieldByName['PK_TIPO_MANIFESTOS'].AsInteger;
end;

procedure TCdTypeManifest.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data : PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Column <> 0) then Exit;
  CellText := Data^.DataRow.FieldByName['DSC_TMNF'].AsString;
end;

initialization
  RegisterClass(TCdTypeManifest);

end.
