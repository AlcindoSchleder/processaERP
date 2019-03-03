unit ConsultaMovimentacao;

{*************************************************************************}
{*                                                                       *}
{* Author: CSD Informatica Ltda.                                         *}
{* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
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
  Dialogs, Mask, ToolEdit, StdCtrls, Buttons, jpeg, ExtCtrls, VirtualTrees,
  ProcType, GridRow;

type
  TfmConsultaMovimentacao = class(TForm)
    stItems: TVirtualStringTree;
    paDetails: TPanel;
    Shape1: TShape;
    im: TImage;
    cmdSearchReferencia: TSpeedButton;
    cmdSearchMaterial: TSpeedButton;
    edReferencia: TEdit;
    StaticText1: TStaticText;
    edDescricao: TEdit;
    cbMaterial: TComboBox;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    cbAlmoxarifado: TComboBox;
    StaticText4: TStaticText;
    dtDe: TDateEdit;
    dtAte: TDateEdit;
    Label1: TLabel;
    StaticText5: TStaticText;
    procedure optInsumoClick(Sender : TObject);
    procedure edReferenciaKeyDown(Sender : TObject; var Key : Word;
      Shift : TShiftState);
    procedure cbMaterialKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure cmdSearchReferenciaClick(Sender : TObject);
    procedure cmdSearchMaterialClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure stItemsGetText(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; TextType : TVSTTextType; var CellText : WideString);
    procedure FormDestroy(Sender : TObject);
    procedure stItemsBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure stItemsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure imDblClick(Sender: TObject);
  private
    { Private declarations }
    FslItems: TList;
    FfkEmpresa: Integer;
    procedure ClearItems;
    procedure LoadItems;
    procedure ClearMateriais;
    procedure LoadMateriais;
    procedure LoadAlmoxarifados;
  public
    { Public declarations }
    property fkEmpresa: Integer Read FfkEmpresa Write FfkEmpresa;
  end;

var
  fmConsultaMovimentacao: TfmConsultaMovimentacao;

implementation

uses Dado, mSysEstq, EstqArqSql, CmmConst;

{$R *.dfm}

procedure TfmConsultaMovimentacao.ClearMateriais;
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

procedure TfmConsultaMovimentacao.LoadMateriais;
var
  TipoPesquisa: Integer;
  S           : string;
  aRow        : TDataRow;
  aLastProd   : Integer;
begin
  aLastProd         := 0;
  TipoPesquisa      := -1;
  edReferencia.Text := Trim(edReferencia.Text);
  edDescricao.Text  := Trim(edDescricao.Text);
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
      qrProduct.ParamByName('CodRef').AsString := '';
      if TipoPesquisa = 0 then
        qrProduct.ParamByName('CodRef').AsString := S
      else
        qrProduct.Sql.Add('   and DSC_PROD Like ''' + S + '''');
      if not qrProduct.Active then qrProduct.Open;
      while not (qrProduct.EOF) do
      begin
        if qrProduct.FieldByName('PK_PRODUTOS').AsInteger <> aLastProd then
        begin
          aRow := TDataRow.CreateFromDataSet(nil, qrProduct, TRUE);
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
  if cbMaterial.Items.Count < 1 then
  begin
    Dados.DisplayHint(cmdSearchReferencia, 'Nenhum produto encontrado!');
    exit;
  end;
  cbMaterial.ItemIndex := 0;
  if Assigned(cbMaterial.OnClick) then
    cbMaterial.OnClick(Self);
end;

procedure TfmConsultaMovimentacao.ClearItems;
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

procedure TfmConsultaMovimentacao.LoadItems;
var
  aRow  : TDataRow;
  Data  : PGridData;
  Node  : PVirtualNode;
  adtDe ,
  adtAte: TDateTime;
begin
  if cbMaterial.ItemIndex < 0 then exit;
  aRow   := TDataRow(cbMaterial.Items.Objects[cbMaterial.ItemIndex]);
  if aRow = nil then exit;
  adtDe  := StrToDateDef(dtDe.Text, 0);
  adtAte := StrToDateDef(dtAte.Text, 0);
  ClearItems;
  with dmSysEstq do
  begin
    if qrMovimEstq.Active then qrMovimEstq.Close;
    qrMovimEstq.SQL.Clear;
    if cbAlmoxarifado.ItemIndex > 0 then
      qrMovimEstq.SQL.Add(SqlProdMovAlmox)
    else
      qrMovimEstq.SQL.Add(SqlProdMoviment);
    if cbAlmoxarifado.ItemIndex > 0 then
      qrMovimEstq.ParamByName('FkAlmoxarifados').AsInteger :=
        LongInt(cbAlmoxarifado.items.objects[cbAlmoxarifado.ItemIndex]);
    qrMovimEstq.ParamByName('FkProdutos').AsInteger := aRow.FieldByName['PK_PRODUTOS'].AsInteger;
    if adtDe > 0 then
      qrMovimEstq.SQL.Add('and DTHR_SLD >=''' +
        FormatDateTime('yyyy-mm-dd', adtDe) + ' 00:00:00''');
    if adtAte > 0 then
      qrMovimEstq.SQL.Add('and DTHR_SLD <=''' +
        FormatDateTime('yyyy-mm-dd', adtAte) + ' 23:59:59''');
    qrMovimEstq.SQL.Add(SqlProdMovOrder);
    stItems.BeginUpdate;
    Dados.StartTransaction(qrMovimEstq);
    try
      qrMovimEstq.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      try
        if (not qrMovimEstq.Active) then qrMovimEstq.Open;
      except on E:Exception do
        raise Exception.Create('Erro na Seleção: ' + E.Message + NL +
          qrMovimEstq.SQL.Text);
      end;
      while not (qrMovimEstq.EOF) do
      begin
        Node          := stItems.AddChild(nil);
        Data          := stItems.GetNodeData(Node);
        Data^.Level   := 0;
        Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrMovimEstq, True);
        Data^.Node    := Node;
        FslItems.Add(Data^.DataRow);
        qrMovimEstq.Next;
      end;
    finally
      if qrMovimEstq.Active then qrMovimEstq.Close;
      Dados.CommitTransaction(qrMovimEstq);
      stItems.FullExpand;
      stItems.EndUpdate;
    end;
  end;
  if (stItems.RootNodeCount = 0) then
    Dados.DisplayHint(cbMaterial, 'Nenhuma movimentação encontrada para o produto!');
end;

procedure TfmConsultaMovimentacao.optInsumoClick(Sender : TObject);
begin
  ClearMateriais;
end;

procedure TfmConsultaMovimentacao.edReferenciaKeyDown(Sender : TObject;
  var Key : Word; Shift : TShiftState);
begin
  if Key = vk_Return then
    if Assigned(cmdSearchReferencia.OnClick) then
      cmdSearchReferencia.OnClick(Sender);
end;

procedure TfmConsultaMovimentacao.cbMaterialKeyDown(Sender : TObject;
  var Key : Word; Shift : TShiftState);
begin
  if Key = vk_Return then
    if Assigned(cmdSearchMaterial.OnClick) then
      cmdSearchMaterial.OnClick(Sender);
end;

procedure TfmConsultaMovimentacao.cmdSearchReferenciaClick(Sender : TObject);
begin
  LoadMateriais;
end;

procedure TfmConsultaMovimentacao.cmdSearchMaterialClick(Sender : TObject);
begin
  LoadItems;
end;

procedure TfmConsultaMovimentacao.FormCreate(Sender : TObject);
begin
  FslItems   := TList.Create;
  stItems.RootNodeCount := 0;
  stItems.NodeDataSize := SizeOf(TGridData);
  FfkEmpresa := Dados.PkCompany;
  LoadAlmoxarifados;
end;

procedure TfmConsultaMovimentacao.stItemsGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data: PGridData;
begin
  CellText := '';
  if Node = nil then
    Exit;
  Data := stItems.GetNodeData(Node);
  if ((Data = nil) or (Data.DataRow = nil) or (Data.DataRow = nil)) then
    exit;
  with Data.DataRow do
    case Column of
      0: CellText := FormatDateTime('dd/mm/yyyy hh:nn:ss', FieldByName['DTHR_SLD'].AsDateTime);
      1: CellText := FieldByName['DSC_TMOV'].AsString;
      2: CellText := FloatToStrF(FieldByName['QTD_ENTRADA'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd);
      3: CellText := FloatToStrF(FieldByName['QTD_SAIDA'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd);
      4: CellText := FieldByName['NUM_DOC'].AsString;
      5: CellText := FloatToStrF(FieldByName['QTD_SLD'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd);
    end;
end;

procedure TfmConsultaMovimentacao.FormDestroy(Sender : TObject);
begin
  ClearItems;
  ClearMateriais;
  FslItems.Free;
  FslItems := nil;
end;

procedure TfmConsultaMovimentacao.LoadAlmoxarifados;
begin
  cbAlmoxarifado.Items.Clear;
  cbAlmoxarifado.Items.AddObject('<Nenhum>', nil);
  with dmSysEstq.qrAlmoxarifados do
    try
      Open;
      while not (EOF) do
      begin
        cbAlmoxarifado.Items.AddObject(FieldByName('dsc_almx').AsString,
          TObject(FieldByName('pk_almoxarifados').AsInteger));
        Next;
      end;
    finally
      Close;
    end;
  cbAlmoxarifado.ItemIndex := 0;
end;

procedure TfmConsultaMovimentacao.stItemsBeforeItemErase(
  Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  ItemRect: TRect; var ItemColor: TColor;
  var EraseAction: TItemEraseAction);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['QTD_ENTRADA'].AsFloat > 0) then
  begin
    Canvas.Brush.Color := clInfoBk;
    ItemColor          := clInfoBk;
  end
  else
  begin
    Canvas.Brush.Color := clInfoBk;
    ItemColor          := clMoneyGreen;
  end;
  EraseAction := eaColor;
end;

procedure TfmConsultaMovimentacao.stItemsPaintText(
  Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  with Data^.DataRow do
    if (FieldByName['QTD_SLD'].AsFloat < 0) then
      TargetCanvas.Font.Color := clRed
    else
      TargetCanvas.Font.Color := clBlue;
end;

procedure TfmConsultaMovimentacao.imDblClick(Sender: TObject);
begin
  ShowMessage(dmSysEstq.qrMovimEstq.SQL.Text);
end;

end.

