unit CadPrdMrg;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadModel, VirtualTrees, StdCtrls, Mask, ToolEdit, CurrEdit,
  TSysEstq, ProcType, GridRow, ProcUtils;

type
  TfmProdMargins = class(TfrmModel)
    vtPrices: TVirtualStringTree;
    procedure vtPricesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure FormCreate(Sender: TObject);
    procedure vtPricesEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vtPricesFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtPricesNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure vtPricesPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtPricesFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure vtPricesColumnClick(Sender: TBaseVirtualTree;
      Column: TColumnIndex; Shift: TShiftState);
    procedure vtPricesBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
  private
    procedure FillTreeView;
    function  ValidateClassFiscal(AClassFisc: string): Boolean;
    function  ValidateSitTrib(ASitTrb: string): Boolean;
    { Private declarations }
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
  fmProdMargins: TfmProdMargins;

implementation

uses Funcoes, mSysEstq, TSysCtbAux, FuncoesDB, DB, Dado, Types, CmmConst;

{$R *.dfm}

{ TfmProdMargins }

procedure TfmProdMargins.ClearControls;
begin
  inherited;

end;

procedure TfmProdMargins.LoadDefaults;
begin
end;

procedure TfmProdMargins.MoveDataToControls;
begin
  FillTreeView;
end;

procedure TfmProdMargins.SaveIntoDB;
var
  Node: PVirtualNode;
  Data: PGridData;
  aPrd: TProductPrices;
  aItm: TProductPrice;
  aStt: TDBMode;
begin
  Node := vtPrices.GetFirst;
  while Node <> nil do
  begin
    if (vtPrices.GetNodeLevel(Node) > 0) then
    begin
      Data := vtPrices.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) and
         (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in UPDATE_MODE) then
      begin
        aStt := TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger);
        aPrd := TProductPrices.Create(nil);
        try
          // Set Fields to Product Margim
          aPrd.FkCompany.PkCompany := Data^.DataRow.FieldByName['PK_EMPRESAS'].AsInteger;
          aPrd.FkClassFisc.PkClassificacaoFiscal :=
            Data^.DataRow.FieldByName['FK_CLASSIFICACAO_FISCAL'].AsString;
          aPrd.FkOrigimTrib.PkOrigensTributarias :=
           Data^.DataRow.FindField['FK_ORIGENS_TRIBUTARIAS'].AsInteger;
          aPrd.FkSitTrib.PkSituacaoTributaria :=
           Data^.DataRow.FindField['FK_SITUACAO_TRIBUTARIAS'].AsInteger;
          aPrd.MrgLcr := Data^.DataRow.FindField['MRG_LCR'].AsFloat;
          dmSysEstq.UpdateProductMargin(Pk, aPrd, aStt);
          // Set Fields to Product Prices
          aItm := aPrd.Add;
          aItm.FkCompany := aPrd.FkCompany;
          aItm.FkPriceTable.PkPriceTable :=
            Data^.DataRow.FindField['PK_TABELA_PRECOS'].AsInteger;
          aItm.PreVda := Data^.DataRow.FieldByName['PRE_VDA'].AsFloat;
          aItm.FlagFix := Boolean(Data^.DataRow.FieldByName['FLAG_FIX'].AsInteger);
          dmSysEstq.UpdateProductPrice(Pk, aItm, aStt);
          Data^.DataRow.FindField['STATUS'].AsInteger := 3; // Return to browse Mode
        finally
          FreeAndNil(aPrd);
        end;
      end;
    end;
    Node := vtPrices.GetNext(Node);
  end;
end;

procedure TfmProdMargins.FillTreeView;
var
  Node: PVirtualNode;
  ChNd: PVirtualNode;
  Data: PGridData;
  i   : integer;
  aList: TList;
  aPkTab: Integer;
  procedure AddData(ANode: PVirtualNode; A: Integer);
  begin
    Data := vtPrices.GetNodeData(ANode);
    Data^.Level := vtPrices.GetNodeLevel(ANode);
    Data^.Node  := ANode;
    Data^.DataRow := TDataRow.CreateAs(nil, TDataRow(aList.Items[A]));
  end;
begin
  aList := dmSysEstq.GetProductPrices(Pk);
  if vtPrices.RootNodeCount > 0 then
    ReleaseTreeNodes(vtPrices);
  aPkTab := 0;
  Node := nil;
  vtPrices.BeginUpdate;
  try
    for i := 0 to aList.Count - 1 do
    begin
      with TDataRow(aList.Items[i]) do
      begin
        if (aPkTab <> FieldByName['PK_TABELA_PRECOS'].AsInteger) then
        begin
          Node := vtPrices.AddChild(nil);
          if (Node <> nil) then AddData(Node, i);
        end;
        if (Node <> nil) then
        begin
          ChNd := vtPrices.AddChild(Node);
          if (ChNd <> nil) then AddData(ChNd, i);
        end;
        aPkTab := FieldByName['PK_TABELA_PRECOS'].AsInteger;
      end;
    end;
  finally
    vtPrices.EndUpdate;
  end;
  if vtPrices.RootNodeCount > 0 then
  begin
    vtPrices.FullExpand;
    Node := vtPrices.GetFirst;
    while ((Node <> nil) and (vtPrices.GetNodeLevel(Node) = 0)) do
      Node := vtPrices.GetNext(Node);
    if (Node <> nil) then
    begin
      vtPrices.FocusedNode := Node;
      vtPrices.Selected[Node] := True;
    end;
  end
end;

procedure TfmProdMargins.vtPricesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := '';
  case Column of
    0: if (Sender.GetNodeLevel(Node) = 0) then
         CellText := Data^.DataRow.FindField['DSC_TAB'].AsString
       else
         CellText := Data^.DataRow.FieldByName['PK_EMPRESAS'].AsString + ' / ' +
                     Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
    1: if (Sender.GetNodeLevel(Node) = 1) then
         CellText := FloatToStrF(Data^.DataRow.FindField['PRE_VDA'].AsFloat, ffNumber, 18,
                     Dados.DecimalPlaces);
    3: if (Sender.GetNodeLevel(Node) = 1) then
         CellText := Data^.DataRow.FindField['SIT_TRIB'].AsString;
    4: if (Sender.GetNodeLevel(Node) = 1) then
         CellText := Data^.DataRow.FindField['FK_CLASSIFICACAO_FISCAL'].AsString;
    5: if (Sender.GetNodeLevel(Node) = 1) then
         CellText := FloatToStrF(Data^.DataRow.FindField['MRG_LCR'].AsFloat, ffNumber, 6, 4);
  end;
end;

procedure TfmProdMargins.FormCreate(Sender: TObject);
begin
  vtPrices.Images        := Dados.Image16;
  vtPrices.Header.Images := Dados.Image16;
  vtPrices.NodeDataSize  := SizeOf(TGridData);
  inherited;
end;

procedure TfmProdMargins.vtPricesEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := (Node <> nil) and (Sender.GetNodeLevel(Node) = 1) and
             (Column in [1, 3, 4, 5]);
end;

procedure TfmProdMargins.vtPricesFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  if (Node = nil) then exit;
  if (Column in [1, 3, 4, 5]) then Sender.EditNode(Node, Column);
end;

procedure TfmProdMargins.vtPricesNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PGridData;
  S   : string;
  R   : TRect;
begin
  if (Node = nil) or (Column in [0, 2]) or (Sender.GetNodeLevel(Node) = 0) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  S := '';
  case Column of
    1: if (NewText <> '') and (StrToFloatDef(NewText, 0) < 0) then
        S := 'Preço deve ser 0 ou um valor numérico positivo com casas decimais ' + NL +
             'separadas por vírgula!';
    3: if (not ValidateSitTrib(Copy(NewText, 1, 3))) then
         S := 'Situação Tributária não cadastrada';
    4: if (not ValidateClassFiscal(Copy(NewText, 1, 20))) then
         S := 'Classificação Fiscal não cadastrada';
    5: if (NewText <> '') and (StrToFloatDef(NewText, 0) <= 0) then
         S := 'Margem de lucro deve ser um valor numérico positivo com casas ' + NL +
              'decimais separadas por vírgula que representa um índice ' + NL +
              '(0,0000) ou um percentual (0,00 %)!';
  end;
  if (S <> '') then
  begin
    R := Sender.GetDisplayRect(Node, Column, False);
    R.BottomRight.Y := R.BottomRight.Y + Integer(vtPrices.DefaultNodeHeight);
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight, S);
    exit;
  end;
  case Column of
    1: Data^.DataRow.FindField['PRE_VDA'].AsFloat := StrToFloat(NewText);
    3: begin
         S := Copy(NewText, 1, 3);
         if (Data^.DataRow.FindField['SIT_TRIB'].AsString  = S) then exit;
         Data^.DataRow.FindField['FK_SITUACAO_TRIBUTARIAS'].AsInteger := StrToIntDef(Copy(S, 1, 2), 0);
         Data^.DataRow.FindField['FK_ORIGENS_TRIBUTARIAS'].AsInteger := StrToIntDef(Copy(S, 3, 1), 0);
         Data^.DataRow.FindField['SIT_TRIB'].AsString  := S;
       end;
    4: if Data^.DataRow.FindField['FK_CLASSIFICACAO_FISCAL'].AsString = NewText then
         exit
       else
         Data^.DataRow.FindField['FK_CLASSIFICACAO_FISCAL'].AsString := NewText;
    5: if (Data^.DataRow.FindField['MRG_LCR'].AsFloat = StrToFloat(NewText)) then
         exit
       else
         Data^.DataRow.FindField['MRG_LCR'].AsFloat := StrToFloat(NewText);
  end;
  if (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in UPDATE_MODE) then
    exit;
  if (Data^.DataRow.FieldByName['FK_PRODUTOS'].AsInteger = 0) then
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmInsert)
  else
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmEdit);
  ScrState := TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger);
end;

function TfmProdMargins.ValidateClassFiscal(AClassFisc: string): Boolean;
begin
  with dmSysEstq do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add('select PK_CLASSIFICACAO_FISCAL from CLASSIFICACAO_FISCAL');
    qrSqlAux.SQL.Add(' where PK_CLASSIFICACAO_FISCAL = :PkClassificacaoFiscal');
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('PkClassificacaoFiscal').AsString := AClassFisc;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := (not qrSqlAux.IsEmpty);
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

function TfmProdMargins.ValidateSitTrib(ASitTrb: string): Boolean;
var
  aPkSit,
  aPkOrg: Integer;
begin
  aPkSit := StrToIntDef(Copy(ASitTrb, 1, 2), 0);
  aPkOrg := StrToIntDef(Copy(ASitTrb, 3, 1), 0);
  with dmSysEstq do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add('select PK_SITUACAO_TRIBUTARIAS from SITUACAO_TRIBUTARIAS');
    qrSqlAux.SQL.Add(' where PK_SITUACAO_TRIBUTARIAS = :PkSituacaoTributarias');
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('PkSituacaoTributarias').AsInteger := aPkSit;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := (not qrSqlAux.IsEmpty);
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
    if (not Result) then exit;
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add('select PK_ORIGENS_TRIBUTARIAS from ORIGENS_TRIBUTARIAS');
    qrSqlAux.SQL.Add(' where PK_ORIGENS_TRIBUTARIAS = :PkOrigensTributarias');
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('PkOrigensTributarias').AsInteger := aPkOrg;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := (not qrSqlAux.IsEmpty);
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

procedure TfmProdMargins.vtPricesPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    TargetCanvas.Font.Color := clGreen;
    TargetCanvas.Font.Style := [fsBold];
  end
  else
    if (Data^.DataRow.FieldByName['STATUS'].AsInteger <> 3) then // Node edited
      TargetCanvas.Font.Color := clRed
    else
      if (Data^.DataRow.FieldByName['PRE_VDA'].AsFloat = 0) then
        TargetCanvas.Font.Color := clGray
      else
        TargetCanvas.Font.Color := clBlue;
end;

procedure TfmProdMargins.vtPricesFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  Allowed := (NewNode <> nil) and (Sender.GetNodeLevel(NewNode) > 0);
end;

procedure TfmProdMargins.FormDestroy(Sender: TObject);
begin
  if vtPrices.IsEditing then vtPrices.EndEditNode;
  ReleaseTreeNodes(vtPrices);
  inherited;
end;

procedure TfmProdMargins.vtPricesColumnClick(Sender: TBaseVirtualTree;
  Column: TColumnIndex; Shift: TShiftState);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := Sender.FocusedNode;
  if (Node = nil) or (Column <> 2) or (Sender.GetNodeLevel(Node) = 0) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FLAG_FIX'].AsInteger = 0) then
    Data^.DataRow.FieldByName['FLAG_FIX'].AsInteger := 1
  else
    Data^.DataRow.FieldByName['FLAG_FIX'].AsInteger := 0;
  Sender.Refresh;
  if (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in UPDATE_MODE) then exit;
  if (Data^.DataRow.FieldByName['FK_PRODUTOS'].AsInteger = 0) then
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmInsert)
  else
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmEdit);
  if (ScrState in SCROLL_MODE) then ScrState := dbmEdit;
end;

procedure TfmProdMargins.vtPricesBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  Data: PGridData;
begin
  if (Node = nil) or (Column <> 2) or (Sender.GetNodeLevel(Node) = 0) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  with CellRect do
    Left := BottomRight.X + (((TopLeft.X - BottomRight.X) div 2) - 8);
  Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 63);
  if (Data^.DataRow.FieldByName['FLAG_FIX'].AsInteger = 1) then
    Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 83);
end;

end.
