unit CadAlmoxarifados;

{*************************************************************************}
{*                                                                       *}
{* Author   : CSD Informatica Ltda.                                      *}
{* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
{* Created  : 02/06/2003                                                 *}
{* Modified : 02/06/2003                                                 *}
{* Version  : 1.2.0.0                                                    *}
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
  Dialogs, CadMultiModel, ComCtrls, VirtualTrees, ToolWin, ExtCtrls, GridRow,
  ImgList;

type
  TScreenForms = (sfAlmox, sfLocation);

  TCdAlmoxarifados = class(TfrmMultiModel)
    tsLocation: TTabSheet;
    tsRoot: TTabSheet;
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure FormCreate(Sender: TObject);
  private
    FPkAlmx: Integer;
    FPkLota: Integer;
    procedure SetPkAlmx(const Value: Integer);
    procedure SetPkLota(const Value: Integer);
  private
    { Private declarations }
    property  PkAlmx: Integer read FPkAlmx write SetPkAlmx;
    property  PkLota: Integer read FPkLota write SetPkLota;
  protected
    { Protected declarations }
    procedure LoadList(Sender: TObject);
    procedure LoadPages(Sender: TObject);
    procedure UpdateRecord(Sender: TObject; Row: TDataRow);
  public
    { Public declarations }
  end;

var
  CdAlmoxarifados: TCdAlmoxarifados;

implementation

uses mSysEstq, Dado, CadAlmox, CadLot, ProcType, FuncoesDB, EstqArqSql,
  ProcUtils, TSysManAux;

{$R *.dfm}

{ TCdMultiModel1 }

const
  FORMS_CAPTIONS     : array [TScreenForms] of string      =
    ('Tabela de Almoxarifados', 'Tabela de Lotações');

procedure TCdAlmoxarifados.LoadList(Sender: TObject);
var
  Node : PVirtualNode;
  Data : PGridData;
  aPkAl: Integer;
  function AddData(ANode: PVirtualNode): PVirtualNode;
  begin
    Result := vtList.AddChild(ANode);
    if (Result <> nil) then
    begin
      Data := vtList.GetNodeData(Result);
      if (Data <> nil) then
      begin
        Data^.Level   := vtList.GetNodeLevel(Result);
        Data^.Node    := ANode;
        Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysEstq.qrAlmox, True);
      end;
    end;
  end;
begin
  Data := nil;
  Node := nil;
  aPkAl := 0;
  with dmSysEstq do
  begin
    if qrAlmox.Active then qrAlmox.Close;
    qrAlmox.SQL.Clear;
    qrAlmox.SQL.Add(SqlAlmoxLotacao);
    Dados.StartTransaction(qrAlmox);
    try
      qrAlmox.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      if (not qrAlmox.Active) then qrAlmox.Open;
      RowModel := TDataRow.CreateFromDataSet(Self, qrAlmox, False);
      while (not qrAlmox.EOF) do
      begin
        if (aPkAl <> qrAlmox.FieldByName('PK_ALMOXARIFADOS').AsInteger) then
          Node := AddData(nil);
        AddData(Node);
        aPkAl := qrAlmox.FieldByName('PK_ALMOXARIFADOS').AsInteger;
        qrAlmox.Next;
      end;
    finally
      if qrAlmox.Active then qrAlmox.Close;
      Dados.CommitTransaction(qrAlmox);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FullExpand;
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdAlmoxarifados.LoadPages(Sender: TObject);
var
  i: TScreenForms;
const
  FORMS_OF_PAGES     : array [TScreenForms] of TPageClass =
    (TCdAlmox, TCdLotacao);
  FORMS_NAMES        : array [TScreenForms] of string      =
    ('tsAlmox', 'tsLotation');
  FORMS_IMAGES_SEL   : array [TScreenForms] of Integer     =
    (11, 16);
  FORMS_IMAGES_NORMAL: array [TScreenForms] of Integer     =
    (19, 83);
begin
  for i := Low(TScreenForms) to High(TScreenForms) do
  begin
    with Pages.Add do
    begin
      DisplayImage  := FORMS_IMAGES_NORMAL[i];
      FormName      := FORMS_NAMES[i];
      PageCaption   := FORMS_CAPTIONS[i];
      PageControl   := pgMain;
      SelectedImage := FORMS_IMAGES_SEL[i];
      FormClass     := FORMS_OF_PAGES[i];
    end;
  end;
end;

procedure TCdAlmoxarifados.SetPkAlmx(const Value: Integer);
begin
  FPkAlmx    := Value;
  CdAlmox.Pk := Value;
end;

procedure TCdAlmoxarifados.SetPkLota(const Value: Integer);
begin
  FPkLota           := Value;
  CdLotacao.FkAlmox := FPkAlmx;
  CdLotacao.Pk      := Value;
end;

procedure TCdAlmoxarifados.UpdateRecord(Sender: TObject; Row: TDataRow);
var
  Data: PGridData;
  Node: PVirtualNode;
  aRow: TDataRow;
  procedure AddDataRow;
  begin
    Node := vtList.AddChild(vtList.FocusedNode);
    if (Node <> nil) then
    begin
      Data := vtList.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level   := vtList.GetNodeLevel(Node);
        Data^.DataRow := TDataRow.CreateAs(nil, aRow);
        Data^.Node    := Node;
      end;
    end;
  end;
begin
  if (vtList.FocusedNode = nil) then exit;
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  vtList.BeginUpdate;
  try
    if (vtList.GetNodeLevel(vtList.FocusedNode) = 0) then
    begin
      Data^.DataRow.FieldByName['PK_ALMOXARIFADOS'].AsInteger := Row.FieldByName['PK_ALMOXARIFADOS'].AsInteger;
      Data^.DataRow.FieldByName['DSC_ALMX'].AsString          := Row.FieldByName['DSC_ALMX'].AsString;
      FPkAlmx := Row.FieldByName['PK_ALMOXARIFADOS'].AsInteger;
      aRow       := Data^.DataRow;
      if (vtList.GetFirstChild(vtList.FocusedNode) = nil) then AddDataRow;
    end;
    if (vtList.GetNodeLevel(vtList.FocusedNode) = 1) then
    begin
      Data^.DataRow.FieldByName['PK_ALMOXARIFADOS'].AsInteger := Row.FieldByName['FK_ALMOXARIFADOS'].AsInteger;
      Data^.DataRow.FieldByName['PK_LOTACOES'].AsInteger      := Row.FieldByName['PK_LOTACOES'].AsInteger;
      Data^.DataRow.FieldByName['RUA_LOT'].AsString           := Row.FieldByName['RUA_LOT'].AsString;
      Data^.DataRow.FieldByName['NIVEL_LOT'].AsString         := Row.FieldByName['NIVEL_LOT'].AsString;
      Data^.DataRow.FieldByName['BOX_LOT'].AsString           := Row.FieldByName['BOX_LOT'].AsString;
      Data^.DataRow.FieldByName['DSC_ALMX'].AsString          := CdLotacao.DscAlmox;
      FPkAlmx := Row.FieldByName['FK_ALMOXARIFADOS'].AsInteger;
      FPkLota := Row.FieldByName['PK_LOTACOES'].AsInteger;
    end;
  finally
    vtList.EndUpdate;
  end;
end;

procedure TCdAlmoxarifados.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    pgMain.ActivePageIndex := 0;
    PkAlmx := Data^.DataRow.FieldByName['PK_ALMOXARIFADOS'].AsInteger;
  end
  else
  begin
    pgMain.ActivePageIndex := 1;
    FPkAlmx   := Data^.DataRow.FieldByName['PK_ALMOXARIFADOS'].AsInteger;
    PkLota    := Data^.DataRow.FieldByName['PK_LOTACOES'].AsInteger;
  end;
end;

procedure TCdAlmoxarifados.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Sender.GetNodeLevel(Node) = 0 then
    CellText := Data^.DataRow.FieldByName['DSC_ALMX'].AsString
  else
    CellText := Copy(InsereZer(Data^.DataRow.FieldByName['RUA_LOT'].AsString, 2), 1, 2) +
                '-' + Copy(InsereZer(Data^.DataRow.FieldByName['NIVEL_LOT'].AsString, 2), 1, 2) +
                '-' + Copy(Data^.DataRow.FieldByName['BOX_LOT'].AsString, 1, 2);
end;

procedure TCdAlmoxarifados.vtListPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 1) and
     (Data^.DataRow.FieldByName['PK_LOTACOES'].AsInteger = 0) then
    TargetCanvas.Font.Color := clSilver;
end;

procedure TCdAlmoxarifados.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
begin
  if (Node = nil) then exit;
  inherited;
  if (Node = Sender.FocusedNode) and (ScrState in UPDATE_MODE) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    ImageIndex := 61
  else
    if (Sender.GetNodeLevel(Node) = 1) then
      ImageIndex := 26;
end;

procedure TCdAlmoxarifados.FormCreate(Sender: TObject);
begin
  OnLoadList  := LoadList;
  OnLoadPages := LoadPages;
  inherited;
end;

initialization
  RegisterClass(TCdAlmoxarifados);

end.
