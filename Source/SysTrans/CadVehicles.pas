unit CadVehicles;

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
  Dialogs, ComCtrls, VirtualTrees, ToolWin, ExtCtrls, GridRow, ImgList, DB,
  ProcType, mSysTrans, Menus, TSysTrans, CadMultiModel;

type
  TScreenForms  = (sfMarks, sfModels, sfVehicles);

  TCdVehicles = class(TfrmMultiModel)
    tsModels: TTabSheet;
    tsVehicles: TTabSheet;
    pmMenu: TPopupMenu;
    pmMark: TMenuItem;
    pmModel: TMenuItem;
    pmVehicle: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure pmInsertGeneralClick(Sender: TObject);
  private
    { Private declarations }
    FTypeVehicle: TTypeVehicle;
    function  GetFocusLevel: Integer;
    procedure SetTypeVehicle(const Value: TTypeVehicle);
    procedure AddCloneNode(ARow: PGridData);
    procedure SetCloneNode(ARow: PGridData);
  protected
    { Protected declarations }
    procedure SetActiveRow(Index: Integer; const Value: TDataRow); override;
    procedure LoadList(Sender: TObject);
    procedure LoadPages(Sender: TObject);
    procedure UpdateRecord(Sender: TObject; Row: TDataRow);
    property  ActiveRow;
    property  TypeVehicle: TTypeVehicle read FTypeVehicle  write SetTypeVehicle;
    property  FocusLevel : Integer      read GetFocusLevel;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses Dado, SelEmpr, FuncoesDB, CnsSearchDocs, CadMarks, CadModVei, CadVei,
  TypInfo, SqlComm, ArqSqlTrans, ProcUtils, TSysManAux;

const
  FORMS_CAPTIONS     : array [TScreenForms] of string  =
    ('Tabela de Marcas de Veículos', 'Tabela de Modelos de Veículos', 'Tabela de Veículos');
  FORMS_IMAGES_SEL   : array [TScreenForms] of Integer =
    (11, 16, 61);
  FORMS_IMAGES_NORMAL: array [TScreenForms] of Integer =
    (19, 83, 37);
  STR_TYPE_VEHICLE   : array [TTypeVehicle] of string  =
    ('tvOwner', 'tvAgregates', '');

procedure TCdVehicles.AddCloneNode(ARow: PGridData);
var
  Node : PVirtualNode;
  Data : PGridData;
  aType: TTypeVehicle;
  procedure AddNodeData(ANode: PVirtualNode; ARowModel: TDataRow);
  var
    PData: PGridData;
  begin
    ANode := vtList.AddChild(ANode);
    if (ANode <> nil) then
    begin
      PData := vtList.GetNodeData(ANode);
      if (PData <> nil) then
      begin
        PData^.DataRow  := TDataRow.CreateAs(vtList, ARowModel);
        PData^.Level    := vtList.GetNodeLevel(ANode);
        PData^.Node     := ANode;
        PData^.NodeType := tnData;
        ShowMessage('Inserindo nó no nível ' + IntToStr(Data^.Level));
      end;
    end
  end;
begin
  if (ARow = nil) or (ARow^.Node = nil) or (ARow^.DataRow = nil) then exit;
  aType := TTypeVehicle(ARow.DataRow.FieldByName['PK_TYPE_VEHICLE'].AsInteger);
  vtList.BeginUpdate;
  try
    Node := vtList.GetFirst;
    while (Node <> nil) do
    begin
      Data := vtList.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (TTypeVehicle(Data^.DataRow.FieldByName['PK_TYPE_VEHICLE'].AsInteger) <> aType) then
      begin
        if (ARow^.Level = 1) then
        begin
          AddNodeData(Data^.Node, ARow^.DataRow);
          break;
        end;
        if (ARow^.Level = 2) and
           (ARow.DataRow.FieldByName['PK_VEICULOS_MARCAS'].AsInteger =
            Data^.DataRow.FieldByName['PK_VEICULOS_MARCAS'].AsInteger) then
        begin
          ShowMessage('Chamando Rotina para Inserir nó');
          AddNodeData(Data^.Node, ARow^.DataRow);
          break;
        end;
      end;
      Node := vtList.GetNext(Node);
    end;
  finally
    vtList.EndUpdate;
  end;
end;

procedure TCdVehicles.FormCreate(Sender: TObject);
begin
  OnLoadList  := LoadList;
  OnLoadPages := LoadPages;
  inherited;
  HasFolders    := True;
  pmMenu.Images := Dados.Image16;
end;

procedure TCdVehicles.LoadList;
var
  Data   : PGridData;
  Node   : PVirtualNode;
  NodeMrc: PVirtualNode;
  NodeMod: PVirtualNode;
  aType  ,
  aMark  ,
  aModel ,
  aVehicle: Integer;
begin
  inherited;
  Node     := nil;
  NodeMrc  := nil;
  NodeMod  := nil;
  Data     := nil;
  aType    := -1;
  aMark    := 0;
  aModel   := 0;
  aVehicle := 0;
  with dmSysTrans do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlSelectAllVehicles1);
    qrSqlAux.SQL.Add(SqlSelectAllVehicles2);
    qrSqlAux.SQL.Add(SqlSelectAllVehicles3);
    qrSqlAux.SQL.Add(SqlSelectAllVehicles4);
    vtList.BeginUpdate;
    Dados.StartTransaction(qrSqlAux);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        if (qrSqlAux.FieldByName('PK_TYPE_VEHICLE').AsInteger <> aType) then
        begin
          Node := AddDataNode(nil, qrSqlAux, Data);
          Data^.NodeType := tnFolder;
        end;
        if (Node <> nil) and (qrSqlAux.FieldByName('PK_VEICULOS_MARCAS').AsInteger <> aMark) then
          NodeMrc := AddDataNode(Node, qrSqlAux, Data);
        if (NodeMrc <> nil) and (qrSqlAux.FieldByName('PK_VEICULOS_MODELOS').AsInteger > 0) and
           (qrSqlAux.FieldByName('PK_VEICULOS_MODELOS').AsInteger <> aModel) then
          NodeMod := AddDataNode(NodeMrc, qrSqlAux, Data);
        if (NodeMod <> nil) and (qrSqlAux.FieldByName('PK_VEICULOS').AsInteger > 0) and
           (qrSqlAux.FieldByName('PK_VEICULOS').AsInteger <> aVehicle) then
          AddDataNode(NodeMod, qrSqlAux, Data);
        aMark    := qrSqlAux.FieldByName('PK_VEICULOS_MARCAS').AsInteger;
        aType    := qrSqlAux.FieldByName('PK_TYPE_VEHICLE').AsInteger;
        aModel   := qrSqlAux.FieldByName('PK_VEICULOS_MODELOS').AsInteger;
        aVehicle := qrSqlAux.FieldByName('PK_VEICULOS').AsInteger;
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
      vtList.EndUpdate;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
    vtList.FullExpand;
  end;
end;

procedure TCdVehicles.LoadPages(Sender: TObject);
var
  i: TScreenForms;
const
  FORMS_OF_PAGES     : array [TScreenForms] of TPageClass =
    (TCdMarks, TCdModels, TCdVehicle);
  FORMS_NAMES        : array [TScreenForms] of string     =
    ('tsMarks', 'tsModels', 'tsVehicle');
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

procedure TCdVehicles.SetActiveRow(Index: Integer; const Value: TDataRow);
begin
  if (Index = -1) then exit;
  if (Index > 0) then Index := Index - 1;
  pmMark.Visible    := (TScreenForms(Index) = sfMarks);
  pmModel.Visible   := (TScreenForms(Index) in [sfMarks, sfModels]) and (FocusLevel > 0);
  pmVehicle.Visible := (TScreenForms(Index) in [sfModels, sfVehicles]);
  case TScreenForms(Index) of
    sfMarks    : tbInsert.MenuItem := pmMark;
    sfModels   : tbInsert.MenuItem := pmModel;
    sfVehicles : tbInsert.MenuItem := pmVehicle;
  end;
  if (not pgMain.Pages[Index].TabVisible) then
    Pages.ItemIndex := Index;
  case TScreenForms(Index) of
    sfMarks  : with TCdMarks(Pages.ActiveForm) do
                 Pk := Value.FieldByName['PK_VEICULOS_MARCAS'].AsInteger;
    sfModels :
      with TCdModels(Pages.ActiveForm) do
      begin
        FkMarks := Value.FieldByName['PK_VEICULOS_MARCAS'].AsInteger;
        Pk      := Value.FieldByName['PK_VEICULOS_MODELOS'].AsInteger;
      end;
    sfVehicles:
      with TCdVehicle(Pages.ActiveForm) do
      begin
        TCdVehicle(Pages.ActiveForm).TypeVehicle := FTypeVehicle;
        FkMarks    := Value.FieldByName['PK_VEICULOS_MARCAS'].AsInteger;
        FkModels   := Value.FieldByName['PK_VEICULOS_MODELOS'].AsInteger;
        Pk         := Value.FieldByName['PK_VEICULOS'].AsInteger;
      end;
  end;
end;

procedure TCdVehicles.SetTypeVehicle(const Value: TTypeVehicle);
begin
  FTypeVehicle := Value;
  dmSysTrans.FkTypeVehicle := Ord(Value);
end;

procedure TCdVehicles.UpdateRecord(Sender: TObject; Row: TDataRow);
var
  aLevel: Integer;
begin
  with ActiveRow[Ord(FTypeVehicle)] do
  begin
    FieldByName['PK_TYPE_VEHICLE'].AsInteger           := Ord(FTypeVehicle);
    aLevel := vtList.GetNodeLevel(vtList.FocusedNode);
    if (aLevel > 0) then Dec(aLevel);
    case TScreenForms(aLevel) of
      sfMarks  :
        begin
          FieldByName['PK_VEICULOS_MARCAS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_MRC'].AsString             := Row.FieldByName['DSC'].AsString;
          case ScrState of
            dbmInsert: AddCloneNode(vtList.GetNodeData(vtList.FocusedNode));
            dbmEdit  : SetCloneNode(vtList.GetNodeData(vtList.FocusedNode));
          end;
        end;
      sfModels :
        begin
          FieldByName['PK_VEICULOS_MARCAS'].AsInteger  := dmSysTrans.FkMark;
          FieldByName['PK_VEICULOS_MODELOS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_MOD'].AsString              := Row.FieldByName['DSC'].AsString;
          case ScrState of
            dbmInsert: AddCloneNode(vtList.GetNodeData(vtList.FocusedNode));
            dbmEdit  : SetCloneNode(vtList.GetNodeData(vtList.FocusedNode));
          end;
        end;
      sfVehicles:
        begin
          FieldByName['PK_VEICULOS_MARCAS'].AsInteger  := dmSysTrans.FkMark;
          FieldByName['PK_VEICULOS_MODELOS'].AsInteger := dmSysTrans.FkModel;
          FieldByName['PK_VEICULOS'].AsInteger         := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_VEI'].AsString              := Row.FieldByName['DSC'].AsString;
        end;
    end;
  end;
end;

procedure TCdVehicles.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data  : PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  FTypeVehicle := TTypeVehicle(Data^.DataRow.FieldByName['PK_TYPE_VEHICLE'].AsInteger);
  ActiveRow[Ord(Data^.Level)] := Data^.DataRow;
end;

procedure TCdVehicles.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['DSC_TVEI'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DSC_MRC'].AsString;
    2: CellText := Data^.DataRow.FieldByName['DSC_MOD'].AsString;
    3: CellText := Data^.DataRow.FieldByName['DSC_VEI'].AsString;
  end;
end;

procedure TCdVehicles.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
var
  aIdx: Integer;
begin
  if (Node = nil) or (Kind in [ikState, ikOverlay]) then exit;
  aIdx := Sender.GetNodeLevel(Node) - 1;
  if (aIdx = -1) then
    if (Sender.HasChildren[Node]) then
      ImageIndex := 22
    else
      ImageIndex := 22
  else
    if (ScrState in UPDATE_MODE) then
      inherited
    else
      if (Kind = ikSelected) then
        ImageIndex := FORMS_IMAGES_SEL[TScreenForms(aIdx)]
      else
        ImageIndex := FORMS_IMAGES_NORMAL[TScreenForms(aIdx)];
end;

procedure TCdVehicles.SetCloneNode(ARow: PGridData);
var
  Node : PVirtualNode;
  Data : PGridData;
  aType: TTypeVehicle;
begin
  if (ARow = nil) or (ARow^.Node = nil) or (ARow^.DataRow = nil) then exit;
  aType := TTypeVehicle(ARow.DataRow.FieldByName['PK_TYPE_VEHICLE'].AsInteger);
  vtList.BeginUpdate;
  try
    Node := vtList.GetFirst;
    while (Node <> nil) do
    begin
      Data := vtList.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (TTypeVehicle(Data^.DataRow.FieldByName['PK_TYPE_VEHICLE'].AsInteger) <> aType) then
      begin
        if (ARow^.Level = 1) and
           (ARow.DataRow.FieldByName['PK_VEICULOS_MARCAS'].AsInteger =
            Data^.DataRow.FieldByName['PK_VEICULOS_MARCAS'].AsInteger) then
        begin
          Data^.DataRow.FieldByName['DSC_MRC'].AsString :=
            ARow.DataRow.FieldByName['DSC_MRC'].AsString;
          break;
        end;
        if (ARow^.Level = 2) and
           (ARow.DataRow.FieldByName['PK_VEICULOS_MARCAS'].AsInteger =
            Data^.DataRow.FieldByName['PK_VEICULOS_MARCAS'].AsInteger) and
           (ARow.DataRow.FieldByName['PK_VEICULOS_MODELOS'].AsInteger =
            Data^.DataRow.FieldByName['PK_VEICULOS_MODELOS'].AsInteger) then
        begin
          Data^.DataRow.FieldByName['DSC_MOD'].AsString :=
            ARow.DataRow.FieldByName['DSC_MOD'].AsString;
          break;
        end;
      end;
      Node := vtList.GetNext(Node);
    end;
  finally
    vtList.EndUpdate;
  end;
end;

procedure TCdVehicles.pmInsertGeneralClick(Sender: TObject);
var
  aLevel: Integer;
  procedure SetTemporaryFolder;
  var
    Node: PVirtualNode;
    Data: PGridData;
  begin
    with vtList do
    begin                                                
      Node := FocusedNode;
      if (Node <> nil) then
      begin
        Data := GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.NodeType := tnFolder;
          tbInsert.Click;
          Data^.NodeType := tnData;
        end;
      end;
    end;
  end;
begin
  if (not (Sender is TMenuItem)) then exit;
  aLevel := FocusLevel;
  if (aLevel = -1) then
    raise Exception.Create('Nenhum registro está selecionado no momento');
  case TScreenForms(TMenuItem(Sender).Tag) of
    sfMarks    : tbInsert.Click;
    sfModels   : if (aLevel = 1) then
                   SetTemporaryFolder
                 else
                   tbInsert.Click;
    sfVehicles : if (aLevel = 2) then
                   SetTemporaryFolder
                 else
                   tbInsert.Click;
  end;
end;

function TCdVehicles.GetFocusLevel: Integer;
begin
  Result := -1;
  with vtList do
  begin
    if (FocusedNode = nil) then exit;
    Result := GetNodeLevel(FocusedNode);
  end;
end;

initialization
  RegisterClass(TCdVehicles);

end.
