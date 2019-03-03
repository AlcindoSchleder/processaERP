unit CadTableMv;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 18/04/2006 - DD/MM/YYYY                                    *}
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
  Dialogs, CadMultiModel, ComCtrls, VirtualTrees, ToolWin, ExtCtrls, GridRow,
  ProcType, ProcUtils, ImgList, DB, PrcSysTypes, TSysPedAux;

type
  TScreenForms = (tdGroup, tdTypeMov, tdStatus, tdTypePgt, tdTypeDsc);

  TCdTablesMoviment = class(TfrmMultiModel)
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FGroupMovement: Integer;
    FFlagES       : TInOut;
    FDscGMov      : string;
    procedure AddTreeNodes(AData: PGridData);
    procedure LoadDataFromDataBase(AData: PGridData; AType: TScreenForms);
  protected
    { Protected declarations }
    procedure SetActiveRow(Index: Integer; const Value: TDataRow); override;
    procedure LoadList(Sender: TObject);
    procedure LoadPages(Sender: TObject);
    procedure UpdateRecord(Sender: TObject; Row: TDataRow);
    property  ActiveRow;
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysPed, PedArqSql, CadTDesc, CadTPgto, CadGrMov, CadTMov, CadStt,
  TSysManAux;

{$R *.dfm}

const
  FORMS_CAPTIONS: array [TScreenForms] of string =
    ('Grupos Movimentos', 'Tipos de Movimentos', 'Status dos Pedidos',
     'Condições de Pagamento', 'Tipos de Descontos');

procedure TCdTablesMoviment.LoadList(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  inherited;
//  FTypeData := tdGroup;
  Data := nil;
  with dmSysPed do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGruposMov);
    vtList.BeginUpdate;
    Dados.StartTransaction(qrSqlAux);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        Node := AddDataNode(nil, qrSqlAux, Data);
        if (Node <> nil) and (vtList.GetNodeLevel(Node) = 0) and
           (Data <> nil) then
          AddTreeNodes(Data);
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
      vtList.EndUpdate;
    end;
  end;
end;

procedure TCdTablesMoviment.AddTreeNodes(AData: PGridData);
var
  i   : TScreenForms;
  j   : Integer;
  Data: PGridData;
  Node: PVirtualNode;
begin
  for i := Low(TScreenForms) to High(TScreenForms) do
  begin
    Node           := vtList.AddChild(AData^.Node);
    if (Node <> nil) then
    begin
      Data           := vtList.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level    := vtList.GetNodeLevel(Node);
        Data^.Node     := Node;
        Data^.NodeType := tnFolder;
        Data^.DataRow  := TDataRow.CreateAs(nil, AData^.DataRow);
        Data^.DataRow.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger :=
          AData^.DataRow.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
        for j := 0 to Data^.DataRow.Count - 1 do
          Data^.DataRow.Fields[j].TypeBuffer := buValue;
        Data^.DataRow.FieldByName['TYPE_DATA'].AsInteger := Ord(i);
        Data^.DataRow.FieldByName['TYPE_NODE'].AsInteger := Ord(tnFolder);
        Data^.DataRow.FieldByName['DSC_TDATA'].AsString  := FORMS_CAPTIONS[i];
        LoadDataFromDataBase(Data, i);
      end;
    end;
  end;
end;

procedure TCdTablesMoviment.LoadDataFromDataBase(AData: PGridData; AType: TScreenForms);
var
  Data: PGridData;
begin
  if (AData = nil) or (AData^.DataRow = nil) then exit;
  Data := nil;
  with dmSysPed do
  begin
    if qrParamPed.Active then qrParamPed.Close;
    qrParamPed.SQL.Clear;
    case AType of
      tdTypeMov: qrParamPed.SQL.Add(SqlMoviments);
      tdStatus : qrParamPed.SQL.Add(SqlTipoStatus);
      tdTypePgt: qrParamPed.SQL.Add(SqlTypePayments);
      tdTypeDsc: qrParamPed.SQL.Add(SqlTipoDescontos);
    end;
    Dados.StartTransaction(qrParamPed);
    try
      qrParamPed.ParamByName('FkGruposMovimentos').AsInteger :=
        AData^.DataRow.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
      if (not qrParamPed.Active) then qrParamPed.Open;
      AData^.DataRow.AddFieldsFromDataSet(qrParamPed, False);
      while (not qrParamPed.Eof) do
      begin
        AddDataNode(AData^.Node, qrParamPed, Data);
        if (Data <> nil) then
        begin
          Data^.DataRow.AddAs('PK_GRUPOS_MOVIMENTOS', AData^.DataRow.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('DSC_GMOV', AData^.DataRow.FieldByName['DSC_GMOV'].AsString, ftString, Length(AData^.DataRow.FindField['DSC_GMOV'].AsString) + 1);
          Data^.DataRow.AddAS('FLAG_ES', AData^.DataRow.FieldByName['FLAG_ES'].AsInteger, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('TYPE_DATA', Ord(AType), ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('DSC_TDATA', FORMS_CAPTIONS[AType], ftString, 31);
        end;
        qrParamPed.Next;
      end;
    finally
      if qrParamPed.Active then qrParamPed.Close;
      Dados.CommitTransaction(qrParamPed);
    end;
  end;
end;

procedure TCdTablesMoviment.LoadPages(Sender: TObject);
var
  i: TScreenForms;
const
  FORMS_NAMES        : array [TScreenForms] of string      =
    ('tsGroups', 'tsMovements', 'tsSttOrder', 'tsPayCond', 'tsDisconts');
  FORMS_OF_PAGES     : array [TScreenForms] of TPageClass =
    (TCdGruposMovim, TCdTypeMovim, TCdTipoStatus, TCdTipoPgtos, TCdTypeDiscount);
  FORMS_IMAGES_SEL   : array [TScreenForms] of Integer     =
    (11, 16, 61, 45, 21);
  FORMS_IMAGES_NORMAL: array [TScreenForms] of Integer     =
    (19, 83, 37, 54, 12);
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

procedure TCdTablesMoviment.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['DSC_GMOV'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DSC_TDATA'].AsString;
    2:
      case TScreenForms(Data^.DataRow.FieldByName['TYPE_DATA'].AsInteger) of
        tdTypeMov: CellText := Data^.DataRow.FieldByName['DSC_TMOV'].AsString;
        tdStatus : CellText := Data^.DataRow.FieldByName['DSC_STT'].AsString;
        tdTypePgt: CellText := Data^.DataRow.FieldByName['DSC_TPG'].AsString;
        tdTypeDsc: CellText := Data^.DataRow.FieldByName['DSC_TDSCT'].AsString;
      end;
  end;
end;

procedure TCdTablesMoviment.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data  : PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  FGroupMovement  := Data^.DataRow.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
  FFlagES         := TInOut(Data^.DataRow.FieldByName['FLAG_ES'].AsInteger);
  FDscGMov        := Data^.DataRow.FieldByName['DSC_GMOV'].AsString;
  Pages.ItemIndex := Data^.DataRow.FieldByName['TYPE_DATA'].AsInteger;
  ActiveRow[Pages.ItemIndex] := Data^.DataRow;
end;

procedure TCdTablesMoviment.UpdateRecord(Sender: TObject; Row: TDataRow);
begin
  with ActiveRow[Pages.ItemIndex] do
  begin
    FieldByName['DSC_TDATA'].AsString             := FORMS_CAPTIONS[TScreenForms(Pages.ItemIndex)];
    FieldByName['TYPE_DATA'].AsInteger            := Pages.ItemIndex;
    case TScreenForms(Pages.ItemIndex) of
      tdGroup  :
        begin
          FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_GMOV'].AsString := Row.FieldByName['DSC'].AsString;
          if (vtList.GetFirstChild(vtList.FocusedNode) = nil) then
            AddTreeNodes(vtList.GetNodeData(vtList.FocusedNode));
        end;
      tdTypeMov:
        begin
          FieldByName['PK_TIPO_MOVIMENTOS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_TMOV'].AsString   := Row.FieldByName['DSC'].AsString;
        end;
      tdStatus:
        begin
          FieldByName['PK_TIPO_STATUS_PEDIDOS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_STT'].AsString := Row.FieldByName['DSC'].AsString;
        end;
      tdTypePgt:
        begin
          FieldByName['PK_TIPO_PAGAMENTOS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_TPG'].AsString  := Row.FieldByName['DSC'].AsString;
        end;
      tdTypeDsc:
        begin
          FieldByName['PK_TIPO_DESCONTOS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_TDSCT'].AsString := Row.FieldByName['DSC'].AsString;
        end;
    end;
    FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger := FGroupMovement;
    FieldByName['FLAG_ES'].AsInteger              := Ord(FFlagES);
    FieldByName['DSC_GMOV'].AsString              := FDscGMov;
  end;
end;

procedure TCdTablesMoviment.vtListGetImageIndexEx(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
begin
  inherited;
  if (Node = Sender.FocusedNode) and (ScrState in UPDATE_MODE) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    ImageIndex := 61;
  if (Sender.GetNodeLevel(Node) = 1) then
    ImageIndex := 22;
  if (Sender.GetNodeLevel(Node) = 2) then
    ImageIndex := 19;
end;

procedure TCdTablesMoviment.SetActiveRow(Index: Integer; const Value: TDataRow);
begin
  if (not pgMain.Pages[Index].TabVisible) then
    Pages.ItemIndex := Index;
  RowModel                          := Value;
  case TScreenForms(Index) of
    tdGroup  :
      with TCdGruposMovim(Pages.ActiveForm) do
        Pk := Value.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
    tdTypeMov:
      with TCdTypeMovim(Pages.ActiveForm) do
      begin
        FkGroupMovim := Value.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
        FlagES       := TInOut(Value.FieldByName['FLAG_ES'].AsInteger);
        DscGMov      := Value.FieldByName['DSC_GMOV'].AsString;
        Pk           := Value.FieldByName['PK_TIPO_MOVIMENTOS'].AsInteger;
      end;
    tdStatus :
      with TCdTipoStatus(Pages.ActiveForm) do
      begin
        FkGroupMovim := Value.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
        FlagES       := TInOut(Value.FieldByName['FLAG_ES'].AsInteger);
        DscGMov      := Value.FieldByName['DSC_GMOV'].AsString;
        Pk           := Value.FieldByName['PK_TIPO_STATUS_PEDIDOS'].AsInteger;
      end;
    tdTypePgt:
      with TCdTipoPgtos(Pages.ActiveForm) do
      begin
        FkGroupMovim := Value.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
        DscGMov      := Value.FieldByName['DSC_GMOV'].AsString;
        Pk           := Value.FieldByName['PK_TIPO_PAGAMENTOS'].AsInteger;
      end;
    tdTypeDsc:
      with TCdTypeDiscount(Pages.ActiveForm) do
      begin
        FkGroupMovim := Value.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
        DscGMov      := Value.FieldByName['DSC_GMOV'].AsString;
        Pk           := Value.FieldByName['PK_TIPO_DESCONTOS'].AsInteger;
//        Pages.ActiveForm.Show;
      end;
  end;
end;

procedure TCdTablesMoviment.FormCreate(Sender: TObject);
begin
  OnLoadList  := LoadList;
  OnLoadPages := LoadPages;
  inherited;
  HasFolders := True;
end;

initialization
  RegisterClass(TCdTablesMoviment);

end.
