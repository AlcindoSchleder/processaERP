unit CadPrCode;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/03/2006                                                   *}
{* Modified:                                                             *}
{* Version: 1.0.0.0                                                      *}
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
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, VirtualTrees,
  ComCtrls, ToolWin, Buttons, StdCtrls, ProcUtils, TSysEstq, ProcType, CadModel, 
  TSysEstqAux, Menus;

type
  TfmProductCode = class(TfrmModel)
    pgCodes: TPageControl;
    tsReferenceEdit: TTabSheet;
    lFlagTCode: TStaticText;
    eFlagTCode: TComboBox;
    eCod_Ref: TEdit;
    lCod_Ref: TStaticText;
    lFlagTBarCode: TStaticText;
    eFlagTBarCode: TComboBox;
    StaticText1: TStaticText;
    lDsc_Code: TStaticText;
    eDsc_Code: TEdit;
    tsReferenceList: TTabSheet;
    vtCodes: TVirtualStringTree;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbInsert: TToolButton;
    tbSep: TToolButton;
    tbDelete: TToolButton;
    sbNewRef: TSpeedButton;
    procedure vtCodesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure FormDestroy(Sender: TObject);
    procedure eFlagTCodeSelect(Sender: TObject);
    procedure vtCodesDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure vtCodesFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure tbInsertClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure pgCodesChanging(Sender: TObject; var AllowChange: Boolean);
    procedure ChangeGlobal(Sender: TObject);
    procedure sbNewRefClick(Sender: TObject);
  private
    { Private declarations }
    FFkProductGroup: Integer;
    FPkProduct: Integer;
    procedure FillTreeView;
    procedure FillDataRow(ANode: PVirtualNode; AData: PGridData; APk: Integer);
    procedure ChangePk(Sender: TObject);
    function  GetCodRef: string;
    function  GetDscCode: string;
    function  GetFlagTBarCode: TBarCode;
    function  GetFlagTCode: TCodeTypes;
    procedure SetCodRef(const Value: string);
    procedure SetDscCode(const Value: string);
    procedure SetFlagTBarCode(const Value: TBarCode);
    procedure SetFlagTCode(const Value: TCodeTypes);
    procedure SetItemToGrid;
    procedure SetFkProductGroup(const Value: Integer);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    procedure DeleteFromDB;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
  public
    { Public declarations }
    property  PKProduct     : Integer    read FPkProduct      write FPkProduct;
    property  FkProductGroup: Integer    read FFkProductGroup write SetFkProductGroup;
    property  FlagTCode     : TCodeTypes read GetFlagTCode    write SetFlagTCode;
    property  FlagTBarCode  : TBarCode   read GetFlagTBarCode write SetFlagTBarCode;
    property  CodRef        : string     read GetCodRef       write SetCodRef;
    property  DscCode       : string     read GetDscCode      write SetDscCode;
  end;

var
  fmProductCode: TfmProductCode;

implementation

uses Windows, FuncoesDB, GridRow, DB, Dado, mSysEstq;

{$R *.dfm}

// 0 ==> Referência do Produto
// 1 ==> Código do Produto
// 2 ==> Código de Barras
// 3 ==> Código do Fornecedor
const
   NAME_CODE_TYPES: array [pcReference..PcSupplier] of string =
     ('Referência', 'Produto', 'Cód.Barras', 'Fornecedor');

procedure TfmProductCode.FormCreate(Sender: TObject);
begin
  inherited;
  vtCodes.NodeDataSize  := SizeOf(TGridData);
  pgCodes.Images        := Dados.Image16;
  vtCodes.Images        := Dados.Image16;
  vtCodes.Header.Images := Dados.Image16;
  tbTools.Images        := Dados.Image16;
  OnChangePK            := ChangePk;
  OnCheckRecord         := CheckRecord;
  ScrState              := dbmBrowse;
end;

procedure TfmProductCode.FormDestroy(Sender: TObject);
begin
  if (vtCodes.RootNodeCount > 0) then ReleaseTreeNodes(vtCodes);
  inherited;
end;

procedure TfmProductCode.FillTreeView;
var
  Node: PVirtualNode;
  Data: PGridData;
  i   : integer;
  aPrd: TProductCodes;
begin
  if vtCodes.RootNodeCount > 0 then
    ReleaseTreeNodes(vtCodes);
  aPrd := dmSysEstq.GetProductCodes(Pk);
  vtCodes.BeginUpdate;
  try
    for i := 0 to aPrd.Count - 1 do
    begin
      Node := vtCodes.AddChild(nil);
      if (Node <> nil) then
      begin
        Data := vtCodes.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Loading := True;
          try
            FlagTCode    := aPrd.Items[i].FlagTCode;
            FlagTBarCode := aPrd.Items[i].FlagTBarCode;
            CodRef       := aPrd.Items[i].CodRef;
            DscCode      := aPrd.Items[i].DscCode;
          finally
            Loading := False;
          end;
          FillDataRow(Node, Data, aPrd.Items[i].PkProductCode);
        end;
      end;
    end;
  finally
    aPrd.Clear;
    FreeAndNil(aPrd);
    vtCodes.EndUpdate;
  end;
  with vtCodes do
    if (RootNodeCount > 0) then
    begin
      FocusedNode := GetFirst;
      Selected[FocusedNode] := True;
      pgCodes.ActivePageIndex := 1;
    end
    else
      pgCodes.ActivePageIndex := 0;
end;

procedure TfmProductCode.FillDataRow(ANode: PVirtualNode; AData: PGridData; APk: Integer);
begin
  AData^.Node  := ANode;
  AData^.Level := vtCodes.GetNodeLevel(ANode);
  AData^.DataRow := TDataRow.Create(nil);
  // Save Field CodRef
  if AData^.DataRow.FindField['COD_REF'] = nil then
    AData^.DataRow.AddAs('COD_REF', CodRef, ftString, 31)
  else
    AData^.DataRow.FieldByName['COD_REF'].AsString := CodRef;
  // Save Field FlagTCode
  if AData^.DataRow.FindField['FLAG_TCODE'] = nil then
    AData^.DataRow.AddAs('FLAG_TCODE', Integer(FlagTCode), ftInteger, SizeOf(Integer))
  else
    AData^.DataRow.FieldByName['FLAG_TCODE'].AsInteger := Integer(FlagTCode);
  // Save Field DscCode
  if AData^.DataRow.FindField['DSC_CODE'] = nil then
    AData^.DataRow.AddAs('DSC_CODE', DscCode, ftString, 31)
  else
    AData^.DataRow.FieldByName['DSC_CODE'].AsString := DscCode;
  // Save Field FlagTBarCode
  if AData^.DataRow.FindField['FLAG_TBARCODE'] = nil then
    AData^.DataRow.AddAs('FLAG_TBARCODE', Integer(FlagTBarCode), ftInteger, SizeOf(Integer))
  else
    AData^.DataRow.FieldByName['FLAG_TBARCODE'].AsInteger := Integer(FlagTBarCode);
  // Save Field PkProductCode
  if AData^.DataRow.FindField['PK_PRODUTOS_CODIGOS'] = nil then
    AData^.DataRow.AddAs('PK_PRODUTOS_CODIGOS', APk, ftInteger, SizeOf(Integer))
  else
    AData^.DataRow.FieldByName['PK_PRODUTOS_CODIGOS'].AsInteger := APk;
  // Save Field FkProduct
  if AData^.DataRow.FindField['FK_PRODUTOS'] = nil then
    AData^.DataRow.AddAs('FK_PRODUTOS', PKProduct, ftInteger, SizeOf(Integer))
  else
    AData^.DataRow.FieldByName['FK_PRODUTOS'].AsInteger := PKProduct;
  // Save Status of TProductCode
  if AData^.DataRow.FindField['STATUS'] = nil then
    AData^.DataRow.AddAs('STATUS', Integer(ScrState), ftInteger, SizeOf(Integer))
  else
    AData^.DataRow.FieldByName['STATUS'].AsInteger := Integer(ScrState);
end;

procedure TfmProductCode.vtCodesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Column = 0) then
    CellText := Data^.DataRow.FindField['COD_REF'].AsString;
  if (Column = 1) then
    if Data^.DataRow.FindField['DSC_CODE'].AsString  = '' then
       CellText := NAME_CODE_TYPES[TCodeTypes(Data^.DataRow.FindField['FLAG_TCODE'].AsInteger)]
     else
       CellText := Data^.DataRow.FindField['DSC_CODE'].AsString;
end;

procedure TfmProductCode.vtCodesFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  MoveDataToControls;
end;

procedure TfmProductCode.LoadDefaults;
begin
  // nothing to do
end;

procedure TfmProductCode.MoveDataToControls;
var
  Data: PGridData;
begin
  if (vtCodes.FocusedNode = nil) then exit;
  Data := vtCodes.GetNodeData(vtCodes.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Loading := True;
  try
    with Data^.DataRow do
    begin
      FlagTCode    := TCodeTypes(FieldByName['FLAG_TCODE'].AsInteger);
      FlagTBarCode := TBarCode(FieldByName['FLAG_TBARCODE'].AsInteger);
      CodRef       := FieldByName['COD_REF'].AsString;
      DscCode      := FieldByName['DSC_CODE'].AsString;
    end;
  finally
    Loading := False;
  end;
end;

procedure TfmProductCode.ClearControls;
begin
  Loading := True;
  try
    FlagTCode    := pcReference;
    FlagTBarCode := bcNone;
    CodRef       := '';
    DscCode      := eFlagTCode.Text;
  finally
    Loading := False;
  end;
end;

procedure TfmProductCode.eFlagTCodeSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  lFlagTBarCode.Enabled := FlagTCode = pcBarCode;
  eFlagTBarCode.Enabled := lFlagTBarCode.Enabled;
  if (not Loading) and (eDsc_Code.Text = '') then
    eDsc_Code.Text := eFlagTCode.Text;
end;

procedure TfmProductCode.vtCodesDblClick(Sender: TObject);
begin
  pgCodes.ActivePageIndex := 0;
end;

procedure TfmProductCode.SaveIntoDB;
var
  Node  : PVirtualNode;
  Data  : PGridData;
  aPrd  : TProductCodes;
  aItem : TProductCode;
  aState: TDBMode;
begin
  if (ScrState = dbmDelete) then
  begin
    DeleteFromDB;
    exit;
  end;
  aPrd := TProductCodes.Create(nil);
  try
    Node := vtCodes.GetFirst;
    while (Node <> nil) do
    begin
      Data := vtCodes.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        aState := TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger);
        with Data^.DataRow do
        begin
          if (aState in UPDATE_MODE) then
          begin
            aItem               := aPrd.Add;
            aItem.PkProductCode := FieldByName['PK_PRODUTOS_CODIGOS'].AsInteger;
            aItem.FlagTCode     := TCodeTypes(FieldByName['FLAG_TCODE'].AsInteger);
            aItem.FlagTBarCode  := TBarCode(FieldByName['FLAG_TBARCODE'].AsInteger);
            aItem.CodRef        := FieldByName['COD_REF'].AsString;
            aItem.DscCode       := FieldByName['DSC_CODE'].AsString;
            dmSysEstq.UpdateProductCode(PkProduct, aItem, AState);
            FieldByName['STATUS'].AsInteger := Integer(dbmBrowse);
          end;
        end;
      end;
      Node := vtCodes.GetNext(Node);
    end;
  finally
    FreeAndNil(aPrd);
  end;
end;

procedure TfmProductCode.ChangePk(Sender: TObject);
begin
  if (Pk = 0) then
    ClearControls
  else
    FillTreeView;
end;

function TfmProductCode.GetCodRef: string;
begin
  Result := eCod_Ref.Text;
end;

function TfmProductCode.GetDscCode: string;
begin
  Result := eDsc_Code.Text;
end;

function TfmProductCode.GetFlagTBarCode: TBarCode;
begin
  Result := TBarCode(eFlagTBarCode.ItemIndex);
end;

function TfmProductCode.GetFlagTCode: TCodeTypes;
begin
  Result := TCodeTypes(eFlagTCode.ItemIndex);
end;

procedure TfmProductCode.SetCodRef(const Value: string);
begin
  eCod_Ref.Text := Value;
end;

procedure TfmProductCode.SetDscCode(const Value: string);
begin
  eDsc_Code.Text := Value;
end;

procedure TfmProductCode.SetFlagTBarCode(const Value: TBarCode);
begin
  eFlagTBarCode.ItemIndex := Ord(Value);
end;

procedure TfmProductCode.SetFlagTCode(const Value: TCodeTypes);
begin
  eFlagTCode.ItemIndex := Ord(Value);
end;

function TfmProductCode.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S     : string;
  Node  : PVirtualNode;
  Data  : PGridData;
  C     : TControl;
  aState: TDBMode;
begin
  if (pgCodes.ActivePageIndex = 0) then
    SetItemToGrid;
  Node := vtCodes.GetFirst;
  S := '';
  C := nil;
  while (Node <> nil) do
  begin
    Data := vtCodes.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      aState := TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger);
      if (aState in UPDATE_MODE) then
      begin
        if (FlagTCode = pcBarCode) and (FlagTBarCode = bcNone) then
        begin
          S := 'Atenção para concluir deve selecionar um tipo de código de barras!';
          C := eFlagTBarCode;
          break;
        end;
        if (CodRef = '') then
        begin
          S := 'Atenção: Você deve informar um código!';
          C := eCod_Ref;
          break;
        end;
        if (DscCode = '') then
          DscCode := eFlagTCode.Text;
      end;
    end;
    Node := vtCodes.GetNext(Node);
  end;
  Result := (S = '');
  if (S <> '') then
  begin
    if (C <> nil) then
    begin
      vtCodes.FocusedNode := Node;
      if (pgCodes.ActivePageIndex = 1) then
        pgCodes.ActivePageIndex := 0;
    end
    else
      C := vtCodes;
    Dados.DisplayHint(C, S, hiWarning);
  end;
end;

procedure TfmProductCode.tbInsertClick(Sender: TObject);
begin
  ScrState := dbmInsert;
  pgCodes.ActivePageIndex := 0;
end;

procedure TfmProductCode.tbDeleteClick(Sender: TObject);
begin
  if (vtCodes.FocusedNode = nil) then exit;
  ScrState := dbmDelete;
  ScrState := dbmBrowse;
end;

procedure TfmProductCode.DeleteFromDB;
var
  Data: PGridData;
  Node: PVirtualNode;
  procedure DeleteNode;
  var
    FocusNode: PVirtualNode;
  begin
    with vtCodes do
    begin
      FocusNode := GetNext(Node);
      if (FocusNode = nil) then
        FocusNode := GetPrevious(Node);
      Data^.Node    := nil;
      Data^.DataRow.Free;
      Data^.DataRow := nil;
      DeleteNode(Node);
      if (FocusNode = nil) then
      begin
        FocusedNode         := FocusNode;
        Selected[FocusNode] := True;
      end;
    end;
  end;
begin
  if (Dados.DisplayMessage('Deseja realmente excluir este registro?', hiQuestion,
       [mbYes, mbNo]) = mrNo) then
    exit;
  Node := vtCodes.FocusedNode;
  if (Node = nil) then exit;
  Data := vtCodes.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  vtCodes.BeginUpdate;
  try
    if (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) = dbmInsert) or
       (Data^.DataRow.FieldByName['PK_PRODUTOS_CODIGOS'].AsInteger = 0) then
      DeleteNode
    else
    begin
      dmSysEstq.DeleteProductCode(Data^.DataRow.FieldByName['FK_PRODUTOS'].AsInteger,
        Data^.DataRow.FindField['PK_PRODUTOS_CODIGOS'].AsInteger);
      DeleteNode;
    end;
  finally
    vtCodes.EndUpdate;
  end;
end;

procedure TfmProductCode.pgCodesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (pgCodes.ActivePageIndex = 0) then
    SetItemToGrid;
  AllowChange := True;
end;

procedure TfmProductCode.SetItemToGrid;
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  if (ScrState in UPDATE_MODE) then
  begin
    if (ScrState = dbmInsert) then
      Node := vtCodes.AddChild(nil)
    else
      Node := vtCodes.FocusedNode;
    if (Node <> nil) then
    begin
      Data := vtCodes.GetNodeData(Node);
      if (Data <> nil) then
      begin
        if (Data^.DataRow = nil) then
          FillDataRow(Node, Data, 0)
        else
        begin
          Data^.DataRow.FieldByName['FLAG_TCODE'].AsInteger    := Ord(FlagTCode);
          Data^.DataRow.FieldByName['FLAG_TBARCODE'].AsInteger := Ord(FlagTBarCode);
          Data^.DataRow.FieldByName['COD_REF'].AsString        := CodRef;
          Data^.DataRow.FieldByName['DSC_CODE'].AsString       := DscCode;
          Data^.DataRow.FieldByName['STATUS'].AsInteger        := Ord(ScrState);
        end;
      end;
    end;
  end;
end;

procedure TfmProductCode.ChangeGlobal(Sender: TObject);
begin
  inherited;
//  nothing to do
end;

procedure TfmProductCode.sbNewRefClick(Sender: TObject);
begin
  CodRef := dmSysEstq.GetNewProductReference(FkProductGroup);
end;

procedure TfmProductCode.SetFkProductGroup(const Value: Integer);
begin
  FFkProductGroup := Value;
  sbNewRef.Enabled := (FFkProductGroup > 0);
end;

end.
