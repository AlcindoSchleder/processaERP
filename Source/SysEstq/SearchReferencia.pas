unit SearchReferencia;

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
  Dialogs, StdCtrls, Buttons, VirtualTrees, ExtCtrls, ProcType, GridRow,
  TSysEstqAux;

type
  TfmSearchReferencia = class(TForm)
    paBtn: TPanel;
    paSearch: TPanel;
    stItems: TVirtualStringTree;
    edReferencia: TEdit;
    Label1: TLabel;
    cmdSearch: TBitBtn;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    edDescricao: TEdit;
    procedure stItemsDblClick(Sender : TObject);
    procedure cmdCancelClick(Sender : TObject);
    procedure cmdUpdateClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure cmdSearchClick(Sender : TObject);
    procedure stItemsGetText(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; TextType : TVSTTextType; var CellText : WideString);
    procedure FormShow(Sender : TObject);
  private
    { Private declarations }
    FslItems: TList;
    FSelectedReferencia: string;
    FCodeType: TCodeTypes;
    procedure ClearItems;
    procedure LoadItems;
  public
    { Public declarations }
    property CodeType          : TCodeTypes read FCodeType           write FCodeType;
    property SelectedReferencia: string     read FSelectedReferencia write FSelectedReferencia;
  end;

var
  fmSearchReferencia: TfmSearchReferencia;

implementation

uses mSysEstq, EstqArqSql;

{$R *.dfm}

procedure TfmSearchReferencia.ClearItems;
var
  i:    Integer;
  aRow: TDataRow;
begin
  stItems.EndEditNode;
  for i := 0 to FslItems.Count - 1 do
  begin
    aRow := TDataRow(FslItems[i]);
    if aRow <> nil then
    begin
      aRow.Free;
      FslItems[i] := nil;
    end;
  end;
  FslItems.Clear;
  stItems.Clear;
end;

procedure TfmSearchReferencia.stItemsDblClick(Sender : TObject);
begin
  if Assigned(cmdUpdate.OnClick) then
    cmdUpdate.OnClick(Self);
end;

procedure TfmSearchReferencia.cmdCancelClick(Sender : TObject);
begin
  Close;
end;

procedure TfmSearchReferencia.cmdUpdateClick(Sender : TObject);
var
  aNode: PVirtualNode;
  Data:  PGridData;
begin
  aNode := stItems.FocusedNode;
  if aNode = nil then
    exit;
  Data := stItems.GetNodeData(aNode);
  if ((Data = nil) or (Data^.DataRow = nil) or (Data.DataRow = nil)) then
    exit;
  FSelectedReferencia := Data.DataRow.FieldByName['COD_REF'].AsString;
  ModalResult := mrOk;
end;

procedure TfmSearchReferencia.FormCreate(Sender : TObject);
begin
  FslItems := TList.Create;
  stItems.RootNodeCount := 0;
  stItems.NodeDataSize := SizeOf(TGridData);
end;

procedure TfmSearchReferencia.FormDestroy(Sender : TObject);
begin
  ClearItems;
  FslItems.Free;
  FslItems := nil;
end;

procedure TfmSearchReferencia.LoadItems;
var
  S: string;
  aLastProd: Integer;
  RowData: TDataRow;
  Data: PGridData;
  Node: PVirtualNode;
  TipoPesquisa: Integer;
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
  if TipoPesquisa < 0 then
    exit;
  if TipoPesquisa = 0 then
    S := edReferencia.Text
  else
    S := edDescricao.Text;
  S := StringReplace(S, '*', '%', [rfReplaceAll]);
  if Pos(S, '%') < 1 then
    S := S + '%';
  stItems.BeginUpdate;
  try
    ClearItems;
    with dmSysEstq do
    begin
      if qrProduct.Active then qrProduct.Close;
      qrProduct.SQL.Clear;
      qrProduct.SQL.Add(SqlProdutosReq);
      try
       qrProduct.ParamByName('TypeCode').AsInteger := Ord(FCodeType);
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
            RowData   := TDataRow.CreateFromDataSet(nil, qrProduct, TRUE);
            Node      := stItems.AddChild(nil);
            Data      := stItems.GetNodeData(Node);
            Data.DataRow := RowData;
            Data.Node := Node;
            FslItems.Add(Data.DataRow);
            aLastProd := qrProduct.FieldByName('PK_PRODUTOS').AsInteger;
          end;
          qrProduct.Next;
        end;
      finally
        qrProduct.Close;
      end;
    end;
  finally
    stItems.EndUpdate;
  end;
end;

procedure TfmSearchReferencia.cmdSearchClick(Sender : TObject);
begin
  LoadItems;
end;

procedure TfmSearchReferencia.stItemsGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data: PGridData;
begin
  if Node = nil then
    exit;
  Data := stItems.GetNodeData(Node);
  if ((Data = nil) or (Data.DataRow = nil) or (Data.DataRow = nil)) then
    exit;
  with Data.DataRow do
    case Column of
      0: CellText := FieldByName['COD_REF'].AsString;
      1: CellText := FieldByName['DSC_PROD'].AsString;
    end;
end;

procedure TfmSearchReferencia.FormShow(Sender : TObject);
begin
  if FSelectedReferencia <> '' then
  begin
    edReferencia.Text := FSelectedReferencia;
    if Assigned(cmdSearch.OnClick) then
      cmdSearch.OnClick(Self);
  end;
end;

end.
