unit ConsultaAlmoxarifado;

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
  Dialogs, Buttons, StdCtrls, jpeg, ExtCtrls, VirtualTrees, GridRow,
  ProcType;

type
  TfmConsultaAlmoxarifado = class(TForm)
    stItems: TVirtualStringTree;
    paDetails: TPanel;
    Shape1: TShape;
    im: TImage;
    Label1: TLabel;
    edReferencia: TEdit;
    StaticText1: TStaticText;
    edDescricao: TEdit;
    cbMaterial: TComboBox;
    cmdSearchReferencia: TSpeedButton;
    StaticText2: TStaticText;
    cmdSearchMaterial: TSpeedButton;
    procedure edReferenciaKeyDown(Sender : TObject; var Key : Word;
      Shift : TShiftState);
    procedure cbMaterialKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure optInsumoClick(Sender : TObject);
    procedure cmdSearchReferenciaClick(Sender : TObject);
    procedure cmdSearchMaterialClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure stItemsGetText(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; TextType : TVSTTextType; var CellText : WideString);
    procedure FormDestroy(Sender : TObject);
    procedure stItemsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure stItemsBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
  private
    { Private declarations }
    FslItems: TList;
    procedure ClearItems;
    procedure LoadItems;
    procedure ClearMateriais;
    procedure LoadMateriais;
  public
    { Public declarations }
  end;

var
  fmConsultaAlmoxarifado: TfmConsultaAlmoxarifado;

implementation

uses Dado, mSysEstq, EstqArqSql, CmmConst;

{$R *.dfm}

procedure TfmConsultaAlmoxarifado.ClearMateriais;
var
  I:    Integer;
  aRow: TDataRow;
begin
  for I := 0 to cbMaterial.Items.Count - 1 do
  begin
    aRow := TDataRow(cbMaterial.Items.Objects[I]);
    if aRow <> nil then
    begin
      aRow.Free;
      cbMaterial.Items.Objects[I] := nil;
    end;
  end;
  cbMaterial.Items.Clear;
end;

procedure TfmConsultaAlmoxarifado.LoadMateriais;
var
  TipoPesquisa: Integer;
  S           : string;
  aRow        : TDataRow;
  aLastProd   : Integer;
begin
  aLastProd    := 0;
  TipoPesquisa := -1;
  edReferencia.Text := Trim(edReferencia.Text);
  edDescricao.Text := Trim(edDescricao.Text);
  if ((Screen.ActiveControl = edReferencia) and (edReferencia.Text <> '')) then
    TipoPesquisa := 0
  else
    if ((Screen.ActiveControl = edDescricao) and (edDescricao.Text <> '')) then
      TipoPesquisa := 1
    else
      if edReferencia.Text <> '' then
        TipoPesquisa := 0
      else
        if edDescricao.Text <> '' then
          TipoPesquisa := 1;
  if TipoPesquisa < 0 then exit;
  ClearMateriais;
  if TipoPesquisa = 0 then
    S := edReferencia.Text
  else
    S := edDescricao.Text;
  if (TipoPesquisa = 1) then
  begin
    S := StringReplace(S, '*', '%', [rfReplaceAll]);
    if Pos(S, '%') < 1 then
      S := S + '%';
  end;
  with dmSysEstq do
  begin
    if qrProduct.Active then qrProduct.Close;
    qrProduct.SQL.Clear;
    qrProduct.SQL.Add(SqlProdutosReq);
    try
      qrProduct.ParamByName('TypeCode').AsInteger := 0;
      qrProduct.ParamByName('CodRef').AsString    := '';
      if TipoPesquisa = 0 then
        qrProduct.ParamByName('CodRef').AsString := S
      else
        qrProduct.Sql.Add('   and DSC_PROD Like ''' + S + '''');
      if not qrProduct.Active then qrProduct.Open;
      while not (qrProduct.EOF) do
      begin
        if qrProduct.FieldByName('PK_PRODUTOS').AsInteger <> aLastProd then
        begin
          aRow := TDataRow.CreateFromDataSet(nil, qrProduct, True);
          S    := aRow.FieldByName['COD_REF'].AsString + '-' +
                  aRow.FieldByName['DSC_PROD'].AsString;
          cbMaterial.Items.AddObject(S, aRow);
          aLastProd := qrProduct.FieldByName('PK_PRODUTOS').AsInteger;
        end;
        qrProduct.Next;
      end;
    finally
      if qrProduct.Active then qrProduct.Close;
    end;
  end;
  if (cbMaterial.Items.Count = 0) then
  begin
    Dados.DisplayHint(cmdSearchReferencia, 'Nenhum produto encontrado!');
    exit;
  end;
  cbMaterial.ItemIndex := 0;
  if Assigned(cbMaterial.OnClick) then
    cbMaterial.OnClick(Self);
end;

procedure TfmConsultaAlmoxarifado.ClearItems;
var
  I:    Integer;
  aRow: TDataRow;
begin
  stItems.EndEditNode;
  for I := 0 to FslItems.Count - 1 do
  begin
    aRow := TDataRow(FslItems[I]);
    if aRow <> nil then
    begin
      aRow.Free;
      FslItems[I] := nil;
    end;
  end;
  FslItems.Clear;
  stItems.Clear;
end;

procedure TfmConsultaAlmoxarifado.LoadItems;
var
  aRow:    TDataRow;
  RowData: TDataRow;
  Data:    PGridData;
  ParentNode, Node: PVirtualNode;
  LastfkAlmoxarifado: Integer;
begin
  if cbMaterial.ItemIndex < 0 then exit;
  aRow := TDataRow(cbMaterial.Items.Objects[cbMaterial.ItemIndex]);
  if aRow = nil then exit;
  LastfkAlmoxarifado := 0;
  ParentNode := nil;
  stItems.BeginUpdate;
  try
    ClearItems;
    with dmSysEstq do
    begin
      if qrProdAlmx.Active then qrProdAlmx.Close;
      qrProdAlmx.SQL.Clear;
      qrProdAlmx.SQL.Add(SqlProdMovimAlmox);
      try
        qrProdAlmx.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
        qrProdAlmx.ParamByName('FkProdutos').AsInteger := aRow.FieldByName['PK_PRODUTOS'].AsInteger;
        if (not qrProdAlmx.Active) then qrProdAlmx.Open;
        while (not qrProdAlmx.EOF) do
        begin
          Data := nil;
          if LastfkAlmoxarifado <> qrProdAlmx.FieldByName('PK_ALMOXARIFADOS').AsInteger then
          begin
            LastfkAlmoxarifado := qrProdAlmx.FieldByName('PK_ALMOXARIFADOS').AsInteger;
            RowData := TDataRow.CreateFromDataSet(nil, qrProdAlmx, True);
            ParentNode := stItems.AddChild(nil);
            Data := stItems.GetNodeData(ParentNode);
            Data.Level := 0;
            Data.DataRow := RowData;
            Data.Node := ParentNode;
            FslItems.Add(RowData);
          end;
          if (Data <> nil) and (Data.DataRow.FieldByName['RUA_LOT'].AsString <> '') then
          begin
            RowData := TDataRow.CreateFromDataSet(nil, qrProdAlmx, True);
            Node    := stItems.AddChild(ParentNode);
            Data    := stItems.GetNodeData(Node);
            Data.DataRow := RowData;
            Data.Level := 1;
            Data.Node := Node;
            FslItems.Add(RowData);
          end;
          qrProdAlmx.Next;
        end;
      finally
        if qrProdAlmx.Active then qrProdAlmx.Close;
      end;
    end;
  finally
    stItems.FullExpand;
    stItems.EndUpdate;
  end;
  if (stItems.RootNodeCount = 0) then
    Dados.DisplayHint(cbMaterial, 'Nenhum almoxarifado encontrado para o produto!');
end;

procedure TfmConsultaAlmoxarifado.edReferenciaKeyDown(Sender : TObject;
  var Key : Word; Shift : TShiftState);
begin
  if Key = vk_Return then
    if Assigned(cmdSearchReferencia.OnClick) then
      cmdSearchReferencia.OnClick(Sender);
end;

procedure TfmConsultaAlmoxarifado.cbMaterialKeyDown(Sender : TObject;
  var Key : Word; Shift : TShiftState);
begin
  if Key = vk_Return then
    if Assigned(cmdSearchMaterial.OnClick) then
      cmdSearchMaterial.OnClick(Sender);
end;

procedure TfmConsultaAlmoxarifado.optInsumoClick(Sender : TObject);
begin
  ClearMateriais;
end;

procedure TfmConsultaAlmoxarifado.cmdSearchReferenciaClick(Sender : TObject);
begin
  LoadMateriais;
end;

procedure TfmConsultaAlmoxarifado.cmdSearchMaterialClick(Sender : TObject);
begin
  LoadItems;
end;

procedure TfmConsultaAlmoxarifado.FormCreate(Sender : TObject);
begin
  FslItems := TList.Create;
  stItems.RootNodeCount := 0;
  stItems.NodeDataSize := SizeOf(TGridData);
end;

procedure TfmConsultaAlmoxarifado.stItemsGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data: PGridData;
  V:    Double;
begin
  CellText := '';
  if Node = nil then
    Exit;
  Data := stItems.GetNodeData(Node);
  if ((Data = nil) or (Data.DataRow = nil)) then
    Exit;
  with Data.DataRow do
    case Column of
      0: if Data.Level = 0 then
          CellText := FieldByName['DSC_ALMX'].AsString;
      1: if Data.Level = 1 then
          CellText := FieldByName['RUA_LOT'].AsString + '-' +
            FieldByName['NIVEL_LOT'].AsString + '-' +
            FieldByName['BOX_LOT'].AsString;
      2: if (Data.Level = 0) then
           CellText := FloatToStrF(FieldByName['QTD_RSRV'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd);
      3: if (Data.Level = 0) then
           CellText := FloatToStrF(FieldByName['QTD_PEDF'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd);
      4: if (Data.Level = 0)  then
           CellText := FloatToStrF(FieldByName['QTD_ESTQ_QR'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd);
      5: if (Data.Level = 0) then
           CellText := FloatToStrF(FieldByName['QTD_GRNT'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd);
      6: if (Data.Level = 0) then
           CellText := FloatToStrF(FieldByName['QTD_ESTQ'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd)
         else
           CellText := FloatToStrF(FieldByName['QTD_LOT'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd);
      7: if Data.Level = 0 then
         begin
           V := FieldByName['QTD_ESTQ'].AsFloat      -
                 (FieldByName['QTD_GRNT'].AsFloat    +
                  FieldByName['QTD_ESTQ_QR'].AsFloat +
                  FieldByName['QTD_RSRV'].AsFloat);
           CellText := FloatToStrF(V, ffNumber, 18, Dados.DecimalPlacesQtd);
         end;
    end;
end;

procedure TfmConsultaAlmoxarifado.FormDestroy(Sender : TObject);
begin
  ClearItems;
  ClearMateriais;
  FslItems.Free;
  FslItems := nil;
end;

procedure TfmConsultaAlmoxarifado.stItemsPaintText(
  Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    TargetCanvas.Font.Style := [fsBold];
    Data := Sender.GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    with Data^.DataRow do
      if ((FieldByName['QTD_ESTQ'].AsFloat -
          (FieldByName['QTD_GRNT'].AsFloat + FieldByName['QTD_ESTQ_QR'].AsFloat +
           FieldByName['QTD_RSRV'].AsFloat)) < 0) then
        TargetCanvas.Font.Color := clRed
      else
        TargetCanvas.Font.Color := clBlue;
  end;
end;

procedure TfmConsultaAlmoxarifado.stItemsBeforeItemErase(
  Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  ItemRect: TRect; var ItemColor: TColor;
  var EraseAction: TItemEraseAction);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    Canvas.Brush.Color := clInfoBk;
    ItemColor          := clMoneyGreen;
  end
  else
  begin
    Canvas.Brush.Color := clSkyBlue;
    ItemColor          := clSkyBlue;
  end;
  EraseAction := eaColor;
end;

end.

