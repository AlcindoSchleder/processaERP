unit SearchItem;

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
  Dialogs, VirtualTrees, StdCtrls, Buttons, ExtCtrls, ComCtrls, TSysEstqAux,
  ProcUtils, GridRow, TSysEstq, ToolWin, jpeg;

type
  TfmSearchProd = class(TForm)
    paDetails  : TPanel;
    vtSearch   : TVirtualStringTree;
    gbParamSel: TGroupBox;
    stDscription: TStaticText;
    stPkProd: TStaticText;
    stFkProductsGroups: TStaticText;
    eCodProd: TEdit;
    eDscProd: TEdit;
    eTypeCode: TComboBox;
    cmdSearch: TSpeedButton;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbInsert: TToolButton;
    sImage: TShape;
    Image1: TImage;
    tbSep: TToolButton;
    stStatus: TStaticText;
    eFkProductsGroups: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdSearchClick(Sender: TObject);
    procedure vtSearchChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtSearchDblClick(Sender: TObject);
    procedure vtSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure eTypeCodeChange(Sender: TObject);
    procedure eDscProdChange(Sender: TObject);
    procedure eCodProdChange(Sender: TObject);
    procedure vtSearchBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure tbInsertClick(Sender: TObject);
    procedure eCodProdKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FProductCode: TCodeTypes;
    FPkProduct  : Integer;
    FRefProduct : string;
    FDscProd    : string;
    FCodProd    : string;
    FCountSearch: Integer;
    FFkSecoes   : Integer;
    FFkGrupos   : Integer;
    FFkSubGrupos: Integer;
    procedure ActiveControls(AEnable: Boolean);
  public
    { Public declarations }
    procedure ClearControls(Sender: TObject);
    function  DeleteProduct(Sender: TProducts): TSetModes;
    procedure ScrollProd(Sender: TForm; var APkProduct: Integer;
                const ADirection: TDBMode; var AEnabled: Boolean);
    property  ProductCode: TCodeTypes    read FProductCode write FProductCode;
    property  PkProduct  : Integer       read FPkProduct   write FPkProduct;
    property  RefProduct : string        read FRefProduct  write FRefProduct;
    property  CountSearch: Integer       read FCountSearch write FCountSearch;
  end;

implementation

uses CmmConst, Dado, mSysPed, PedArqSql, DB, FuncoesDB, Funcoes, ProcType,
  SqlComm;

{$R *.dfm}

procedure TfmSearchProd.FormCreate(Sender: TObject);
begin
  vtSearch.Images        := Dados.Image16;
  vtSearch.Header.Images := Dados.Image16;
  cbTools.Images         := Dados.Image16;
  tbTools.Images         := Dados.Image16;
  inherited;
  CountSearch := 0;
  Dados.Image16.GetBitmap(35, cmdSearch.Glyph);
  cmdSearch.Down := False;
  stStatus.Caption := 'Pesquisar produtos com os parâmetros informados';
  cmdSearch.Hint := 'Pesquisar | Pesquisa produtos com os parâmetros informados';
  FProductCode := pcReference;
  ActiveControls(True);
//  eFkProductsGroups.Items.AddStrings(dmSysPed.LoadSections);
end;

procedure TfmSearchProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ReleaseTreeNodes(vtSearch);
  ReleaseCombos(eFkProductsGroups, toObject);
end;

procedure TfmSearchProd.eDscProdChange(Sender: TObject);
begin
  FDscProd := eDscProd.Text;
end;

procedure TfmSearchProd.eTypeCodeChange(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := eTypeCode.ItemIndex;
  if (Idx > -1) and (Idx < 3) then
  begin
    ProductCode := TCodeTypes(Idx);
    eCodProdChange(eCodProd);
  end;
end;

procedure TfmSearchProd.eCodProdChange(Sender: TObject);
begin
  FCodProd  := eCodProd.Text;
  if eCodProd.Text = '' then exit;
  try
    if (ProductCode = pcPK) then
    begin
      PkProduct := StrToInt(FCodProd);
      FCodProd  := '';
    end;
  except
    eCodProd.SetFocus;
    eCodProd.Text := '';
    Dados.DisplayHint(eCodProd, 'Código do produto deve ser Numérico',
      hiError);
  end;
end;

procedure TfmSearchProd.eCodProdKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key < ' ') then exit;
  if (ProductCode = pcPK) and (not (Key in ['0'..'9'])) then
    Key := #0;
end;

procedure TfmSearchProd.cmdSearchClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  cmdSearch.Glyph   := nil;
  Dados.Image16.GetBitmap(43, cmdSearch.Glyph);
  cmdSearch.Hint    := 'Nova pesquisa | Limpa os controles para realizar uma nova pesquisa';
  cmdSearch.OnClick := ClearControls;
  cmdSearch.Repaint;
  ActiveControls(False);
  if vtSearch.RootNodeCount > 0 then
    ReleaseTreeNodes(vtSearch);
  with dmSysPed do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlSearchProdutos0);
    if (FCodProd <> '') and (ProductCode <> pcPK) then
      qrSqlAux.SQL.Add(SqlAnd + 'Pcd.COD_REF = :CodRef ');
    qrSqlAux.SQL.Add(SqlSearchProdutos1);
    if (PkProduct > 0) and (ProductCode = pcPK) then
      qrSqlAux.SQL.Add(SqlAnd + 'Prd.PK_PRODUTOS = :PkProdutos ');
    if FDscProd <> '' then
      qrSqlAux.SQL.Add(SqlAnd + 'Prd.DSC_PROD like :DscProd ');
    if FFkSecoes > 0 then
      qrSqlAux.SQL.Add(SqlAnd + 'Prd.FK_SECOES = :FkSecoes ');
    if FFkGrupos > 0 then
      qrSqlAux.SQL.Add(SqlAnd + 'Prd.FK_GRUPOS = :FkGrupos ');
    if FFkSubGrupos > 0 then
      qrSqlAux.SQL.Add(SqlAnd + 'Prd.FK_SUBGRUPOS = :FkSubGrupos ');
    qrSqlAux.SQL.Add(SqlSearchProdutos2);
    qrSqlAux.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
    if (qrSqlAux.Params.FindParam('FlagTCode')         <> nil) then
      if (FCodProd = '') then
        qrSqlAux.ParamByName('FlagTCode').AsInteger := -1
      else
        qrSqlAux.ParamByName('FlagTCode').AsInteger := Integer(FProductCode);
    if (FCodProd <> '') and (ProductCode <> pcPK)            and
       (qrSqlAux.Params.FindParam('CodRef') <> nil) then
      qrSqlAux.ParamByName('CodRef').AsString       := FCodProd;
    if (qrSqlAux.Params.FindParam('FlagAtv')     <> nil) then
      qrSqlAux.ParamByName('FlagAtv').AsInteger     := 1;
    if (qrSqlAux.Params.FindParam('PkProdutos')  <> nil) then
      qrSqlAux.ParamByName('PkProdutos').AsInteger  := PkProduct;
    if (qrSqlAux.Params.FindParam('DscProd')     <> nil) then
      qrSqlAux.ParamByName('DscProd').AsString      := '%' + FDscProd + '%';
    if (qrSqlAux.Params.FindParam('FkSecoes')    <> nil) then
      qrSqlAux.ParamByName('FkSecoes').AsInteger    := FFkSecoes;
    if (qrSqlAux.Params.FindParam('FkGrupos')    <> nil) then
      qrSqlAux.ParamByName('FkGrupos').AsInteger    := FFkGrupos;
    if (qrSqlAux.Params.FindParam('FkSubGrupos') <> nil) then
      qrSqlAux.ParamByName('FkSubGrupos').AsInteger := FFkSubGrupos;
    try
      if not qrSqlAux.Active then qrSqlAux.Open;
    except on E:Exception do
      raise Exception.Create(E.Message + NL + qrSqlAux.SQL.Text);
    end;
    vtSearch.NodeDataSize := SizeOf(TGridData);
    vtSearch.BeginUpdate;
    try
      if not qrSqlAux.IsEmpty then
      begin
        qrSqlAux.First;
        while not qrSqlAux.Eof do
        begin
          Node := vtSearch.AddChild(nil);
          if Node <> nil then
          begin
            Data          := vtSearch.GetNodeData(Node);
            Data^.Level   := vtSearch.GetNodeLevel(Node);
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
          end;
          qrSqlAux.Next;
        end;
      end
      else
        Application.MessageBox(PAnsiChar('Busca: Nenhum Produto Encontrado'),
          PAnsiChar(Application.Name), MB_ICONWARNING + MB_OK);
    finally
      vtSearch.EndUpdate;
      Node := vtSearch.GetFirst;
      if Node <> nil then
      begin
        vtSearch.FocusedNode    := Node;
        vtSearch.Selected[Node] := True;
      end;
      CountSearch := vtSearch.RootNodeCount;
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
  stStatus.Caption := Format('Encontrados %d registros', [CountSearch]);
  tbInsert.Enabled := (CountSearch = 0);
end;

procedure TfmSearchProd.vtSearchChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if (Node = nil) or (vtSearch.GetNodeLevel(Node) > 0) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data <> nil) and (Data.DataRow <> nil) and
     (Data.DataRow.FindField['PK_PRODUTOS'] <> nil) then
    PkProduct := Data.DataRow.FieldByName['PK_PRODUTOS'].AsInteger;
end;

procedure TfmSearchProd.vtSearchDblClick(Sender: TObject);
var
  Node : PVirtualNode;
  Data : PGridData;
begin
  Node := vtSearch.FocusedNode;
  if (Node <> nil) then
  begin
    Data := vtSearch.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      FPkProduct  := Data.DataRow.FieldByName['PK_PRODUTOS'].AsInteger;
      FRefProduct := Data.DataRow.FieldByName['COD_REF'].AsString;
    end;
  end;
  Close;
end;

procedure TfmSearchProd.vtSearchGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data     := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Column >= Data.DataRow.Count) then
    exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['PK_PRODUTOS'].AsString;
    1: CellText := Data^.DataRow.FieldByName['COD_REF'].AsString;
    2: CellText := Data^.DataRow.FieldByName['DSC_PROD'].AsString;
    3: CellText := Data^.DataRow.FieldByName['DSC_UNI'].AsString;
    4: CellText := ' ';
    5: CellText := FloatToStrF(Data^.DataRow.FieldByName['QTD_ESTQ'].AsFloat,
        ffNumber, 18, Dados.DecimalPlacesQtd);
  end;
end;

procedure TfmSearchProd.ScrollProd(Sender: TForm; var APkProduct: Integer;
             const ADirection: TDBMode; var AEnabled: Boolean);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtSearch.GetFirstSelected;
  while Node <> nil do
  begin
    case ADirection of
      dbmPrior: Node := vtSearch.GetPrevious(Node);
      dbmNext : Node := vtSearch.GetNext(Node)
    end;
    if (Node <> nil) and (vtSearch.GetNodeLevel(Node) = 0) then
      Break;
  end;
  aEnabled := (Node <> nil);
  if Node = nil then exit;
  vtSearch.Selected[Node] := True;
  vtSearch.FocusedNode    := Node;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Data^.DataRow.FindField['PK_PRODUTOS'] = nil) then
    exit;
  APkProduct := Data^.DataRow.FieldByName['PK_PRODUTOS'].AsInteger;
end;

procedure TfmSearchProd.ClearControls(Sender: TObject);
begin
  CountSearch := 0;
  cmdSearch.Glyph := nil;
  Dados.Image16.GetBitmap(35, cmdSearch.Glyph);
  stStatus.Caption := 'Pesquisar produtos com os parâmetros informados';
  cmdSearch.Hint := 'Pesquisar | Pesquisa o arquivo com os parâmetros informados';
  cmdSearch.OnClick := cmdSearchClick;
  cmdSearch.Repaint;
  ActiveControls(True);
  ReleaseTreeNodes(vtSearch);
  eDscProd.Text         := '';
  eTypeCode.ItemIndex   := 0;
  ProductCode           := pcReference;
  eCodProd.Text         := '';
  FCodProd              := '';
  eFkProductsGroups.ItemIndex := -1;
end;

procedure TfmSearchProd.ActiveControls(AEnable: Boolean);
begin
  eDscProd.Enabled     := AEnable;
  eTypeCode.Enabled    := AEnable;
  eCodProd.Enabled     := AEnable;
  eFkProductsGroups.Enabled  := AEnable;
end;

procedure TfmSearchProd.vtSearchBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) or
     (Column <> 4) then exit;
  vtSearch.Header.Columns[Column].Alignment := taCenter;
  Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 63);
  if Data^.DataRow.FieldByName['FLAG_ATV'].AsInteger = 1 then
    Dados.Image16.Draw(TargetCanvas, CellRect.Left + 2, CellRect.Top + 1, 83);
end;

function TfmSearchProd.DeleteProduct(Sender: TProducts): TSetModes;
var
  NewNode,
  Node   : PVirtualNode;
  Data   : PGridData;
begin
  Result := [];
  Node := vtSearch.GetFirstSelected;
  if (Node = nil) then exit;
  NewNode := nil;
  if (Node <> vtSearch.GetFirst) and (vtSearch.GetPrevious(Node) <> nil) then
    Result := [dbmPrior];
  if (Node <> vtSearch.GetLast) and (vtSearch.GetNext(Node) <> nil) then
    Result := Result + [dbmNext];
  if dbmNext in Result then
    NewNode := vtSearch.GetNext(Node);
  if (dbmPrior in Result) and (not (dbmNext in Result)) then
    NewNode := vtSearch.GetPrevious(Node);
  vtSearch.DeleteNode(Node);
  if NewNode <> nil then
  begin
    vtSearch.Selected[NewNode] := True;
    vtSearch.FocusedNode       := NewNode;
    Data := vtSearch.GetNodeData(NewNode);
    if (Data = nil) or (Data^.DataRow = nil) or
       (Data^.DataRow.FindField['PK_PRODUTOS'] = nil) then
      exit;
    Sender.PkProducts := Data^.DataRow.FieldByName['PK_PRODUTOS'].AsInteger;
  end
  else
    Sender.Clear;
end;

procedure TfmSearchProd.tbInsertClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (vtSearch.RootNodeCount > 0) then
  begin
    Node := vtSearch.FocusedNode;
    if Node <> nil then
    begin
      Data := vtSearch.GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow.FindField['PK_PRODUTOS'] <> nil) then
        FPkProduct := Data^.DataRow.FieldByName['PK_PRODUTOS'].AsInteger;
    end;
  end;
end;

procedure TfmSearchProd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F3) then
    cmdSearch.Click;
  if (Key = VK_RETURN) and (vtSearch.Focused) and
     (vtSearch.RootNodeCount > 0) and (vtSearch.FocusedNode <> nil) then
    vtSearchDblClick(Sender);
end;

procedure TfmSearchProd.FormActivate(Sender: TObject);
begin
  if (eDscProd.CanFocus) then
    eDscProd.SetFocus;
end;

end.
