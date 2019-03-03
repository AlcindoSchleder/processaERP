unit CadPrdTax;

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
  Dialogs, CadModel, VirtualTrees;

type
  TfmPrdTaxes = class(TfrmModel)
    vtTaxes: TVirtualStringTree;
    procedure vtTaxesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtTaxesInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtTaxesChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure FillTreeView;
    procedure DeleteRecordFromDB(AFkCompany, AFkProduct, AFkTax: Integer);
    procedure InsertRecordIntoDB(AFkCompany, AFkProduct, AFkTax: Integer);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
  end;

var
  fmPrdTaxes: TfmPrdTaxes;

implementation

uses FuncoesDB, Dado, mSysEstq, EstqArqSql, GridRow, ProcType, ProcUtils;

{$R *.dfm}

{ TfmPrdTaxes }

procedure TfmPrdTaxes.ClearControls;
begin
// Nothing to do
end;

procedure TfmPrdTaxes.DeleteRecordFromDB(AFkCompany, AFkProduct,
  AFkTax: Integer);
begin
  with dmSysEstq do
  begin
    if ProdImposto.Active then ProdImposto.Close;
    ProdImposto.SQL.Clear;
    ProdImposto.SQL.Add(SqlDeletePrdImpostos);
    Dados.StartTransaction(ProdImposto);
    try
      ProdImposto.Params.ParamByName('FkEmpresas').AsInteger := AFkCompany;
      ProdImposto.Params.ParamByName('FkProdutos').AsInteger := AFkProduct;
      ProdImposto.Params.ParamByName('FkTipoImpostos').AsInteger := AFkTax;
      ProdImposto.ExecSQL;
      Dados.CommitTransaction(ProdImposto);
    except on E:Exception do
      begin
        if (ProdImposto.Active) then ProdImposto.Close;
        Dados.RollbackTransaction(ProdImposto);
        raise Exception.Create('DeleteRecordFromDB: Erro na exclusão dos ' +
           'Registros! ' + NL + E.Message + NL + ProdImposto.SQL.Text);
      end;
    end
  end;
end;

procedure TfmPrdTaxes.FillTreeView;
var
  NameEmp : string;
  RootNode,
  Node    : PVirtualNode;
  Data    : PGridData;
  ImpsAnt ,
  EmprAnt : Integer;
  function CreateDataFromNode(ANode: PVirtualnode): Boolean;
  begin
    Result := False;
    if (ANode = nil) then exit;
    Data := vtTaxes.GetNodeData(ANode);
    if (Data = nil) then exit;
    Data^.Level   := vtTaxes.GetNodeLevel(ANode);
    Data^.Node    := ANode;
    Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysEstq.ProdImposto, True);
    Result := True;
  end;
begin
  if vtTaxes.RootNodeCount > 0 then
    ReleaseTreeNodes(vtTaxes);
  with dmSysEstq do
  begin
    if ProdImposto.Active then ProdImposto.Close;
    ProdImposto.SQL.Clear;
    ProdImposto.SQL.Add(SqlSelectPrdImpostos);
    vtTaxes.BeginUpdate;
    Dados.StartTransaction(ProdImposto);
    try
      ProdImposto.Params.ParamByName('FkProdutos').AsInteger := Pk;
      if not ProdImposto.Active then ProdImposto.Open;
      NameEmp  := '';
      RootNode := nil;
      EmprAnt := 0;
      ImpsAnt := 0;
      while (not ProdImposto.Eof) do
      begin
        if NameEmp <> ProdImposto.FieldByName('R_RAZ_SOC').AsString then
        begin
          RootNode := vtTaxes.AddChild(nil);
          if not CreateDataFromNode(RootNode) then exit;
          EmprAnt := ProdImposto.FieldByName('R_FK_EMPRESAS').AsInteger;
        end;
        Node := vtTaxes.AddChild(RootNode);
        if (EmprAnt = ProdImposto.FieldByName('R_FK_EMPRESAS').AsInteger) and
           (ImpsAnt <> ProdImposto.FieldByName('R_FK_TIPO_IMPOSTOS').AsInteger) then
          if not CreateDataFromNode(Node) then exit;
        ImpsAnt := ProdImposto.FieldByName('R_FK_TIPO_IMPOSTOS').AsInteger;
        NameEmp := ProdImposto.FieldByName('R_RAZ_SOC').AsString;
        ProdImposto.Next;
      end;
    finally
      if ProdImposto.Active then ProdImposto.Close;
      Dados.CommitTransaction(ProdImposto);
      vtTaxes.EndUpdate;
    end;
  end;
  vtTaxes.FullExpand;
end;

procedure TfmPrdTaxes.InsertRecordIntoDB(AFkCompany, AFkProduct,
  AFkTax: Integer);
begin
  with dmSysEstq do
  begin
    if ProdImposto.Active then ProdImposto.Close;
    ProdImposto.SQL.Clear;
    ProdImposto.SQL.Add(SqlInsertPrdImpostos);
    Dados.StartTransaction(ProdImposto);
    try
      ProdImposto.Params.ParamByName('FkEmpresas').AsInteger := AFkCompany;
      ProdImposto.Params.ParamByName('FkProdutos').AsInteger := AFkProduct;
      ProdImposto.Params.ParamByName('FkTipoImpostos').AsInteger := AFkTax;
      ProdImposto.ExecSQL;
      Dados.CommitTransaction(ProdImposto);
    except on E:Exception do
      begin
        if ProdImposto.Active then ProdImposto.Close;
        Dados.RollbackTransaction(ProdImposto);
        raise Exception.Create('InsertRecordIntoDB: Erro na inserção dos ' +
           'Registros! ' + NL + E.Message + NL + ProdImposto.SQL.Text);
      end;
    end;
  end;
end;

procedure TfmPrdTaxes.LoadDefaults;
begin
// Nothing to do
end;

procedure TfmPrdTaxes.MoveDataToControls;
begin
  Loading := True;
  try
    if (ScrState in SCROLL_MODE) then
      FillTreeView;
  finally
    Loading := False;
  end;
end;

procedure TfmPrdTaxes.SaveIntoDB;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtTaxes.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtTaxes.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) and
       (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in UPDATE_MODE) then
    begin
      if (Node.CheckState = csUncheckedNormal) and
         (Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger > 0) and
         (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) = dbmDelete) then
      begin
        Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger := 0;
        Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmBrowse);
        DeleteRecordFromDB(Data^.DataRow.FieldByName['R_FK_EMPRESAS'].AsInteger,
                           Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger,
                           Data^.DataRow.FieldByName['R_FK_TIPO_IMPOSTOS'].AsInteger)
      end;
      if (Node.CheckState = csCheckedNormal) and
         (Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger = 0) and
         (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) = dbmInsert) then
      begin
        Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmBrowse);
        Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger := Pk;
        InsertRecordIntoDB(Data^.DataRow.FieldByName['R_FK_EMPRESAS'].AsInteger,
                           Pk, Data^.DataRow.FieldByName['R_FK_TIPO_IMPOSTOS'].AsInteger);
      end;
    end;
    Node := vtTaxes.GetNext(Node);
  end;
end;

procedure TfmPrdTaxes.vtTaxesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Sender.GetNodeLevel(Node) = 1 then
    CellText := Data^.DataRow.FieldByName['R_DSC_IMPS'].AsString
  else
    CellText := Data^.DataRow.FieldByName['R_RAZ_SOC'].AsString;
end;

procedure TfmPrdTaxes.vtTaxesInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  if Sender.GetNodeLevel(Node) = 1 then
    Node.CheckType := ctCheckBox
  else
    Node.CheckType := ctNone;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if Sender.GetNodeLevel(Node) = 1 then
    if Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger = 0 then
      Node.CheckState := csUncheckedNormal
    else
      Node.CheckState := csCheckedNormal;
end;

procedure TfmPrdTaxes.vtTaxesChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Node.CheckState = csUncheckedNormal) and
     (Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger > 0)  then
  begin
    if (Pk > 0) then
      DeleteRecordFromDB(Data^.DataRow.FieldByName['R_FK_EMPRESAS'].AsInteger,
                         Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger,
                         Data^.DataRow.FieldByName['R_FK_TIPO_IMPOSTOS'].AsInteger)
    else
      Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmBrowse);
    Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger := 0;
  end;
  if (Node.CheckState = csCheckedNormal) and
     (Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger = 0)  then
  begin
    if (Pk > 0) then
    begin
      Data^.DataRow.FieldByName['R_FK_PRODUTOS'].AsInteger := Pk;
      InsertRecordIntoDB(Data^.DataRow.FieldByName['R_FK_EMPRESAS'].AsInteger,
                         Pk, Data^.DataRow.FieldByName['R_FK_TIPO_IMPOSTOS'].AsInteger);
    end
    else
    begin
      ScrState := dbmInsert;
      Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmInsert);
    end;
  end;
end;

procedure TfmPrdTaxes.FormCreate(Sender: TObject);
begin
  inherited;
  vtTaxes.Images        := Dados.Image16;
  vtTaxes.Header.Images := Dados.Image16;
  vtTaxes.NodeDataSize  := SizeOf(TGridData);
end;

procedure TfmPrdTaxes.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtTaxes);
  inherited;
end;

end.
