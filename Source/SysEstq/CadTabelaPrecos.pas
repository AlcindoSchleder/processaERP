unit CadTabelaPrecos;

{*************************************************************************}
{*                                                                       *}
{* Author   : CSD Informatica Ltda.                                      *}
{* Copyright: © 2003 by CSD Informatica Ltda.. All rights reserved.      *}
{* Created  : 02/06/2003 - DD/MM/YYYY                                    *}
{* Modified : 22/01/2007 - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
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
  Dialogs, CadMultiModel, ComCtrls, VirtualTrees, ToolWin, ExtCtrls, ProcType,
  GridRow, CadListModel, Menus, ImgList;

type
  TScreenForms   = (tdTablePrice, tdCalcRegion);

  TCdTabelaPrecos = class(TfrmMultiModel)
    tsRegionsMatrix: TTabSheet;
    pmInsert: TPopupMenu;
    pmInsPriceTable: TMenuItem;
    pmInsCalcRegion: TMenuItem;
    tsRoot: TTabSheet;
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure FormDestroy(Sender: TObject);
    procedure vtListChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtListChecking(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var NewState: TCheckState; var Allowed: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure tbInsertClick(Sender: TObject);
  private
    { Private declarations }
    FDscTab        : string;
    FFkTablePrice  : Integer;
    FFkTypeFraction: Integer;
    FFkTableRegion : Integer;
    FOnCheckDefault: TNotifyEvent;
  protected
    { Protected declarations }
    procedure SetActiveRow(Index: Integer; const Value: TDataRow); override;
    procedure LoadList(Sender: TObject);
    procedure LoadPages(Sender: TObject);
    procedure UpdateRecord(Sender: TObject; Row: TDataRow);
    procedure CheckDefault(Sender: TObject; const Checked: Boolean;
                var Allowed: Boolean);
    property  ActiveRow;
  public
    { Public declarations }
  end;

implementation

uses Dado, DB, mSysEstq, EstqArqSql, ProcUtils, CadTPrc, CadRCalc, TSysManAux;

{$R *.dfm}

const
  FORMS_CAPTIONS: array [TScreenForms] of string      =
    ('Tabela de Preços', 'Regiões da Tabela');

{ TCdTabelaPrecos }

procedure TCdTabelaPrecos.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
  aPk : Integer;
  procedure SetDataType(AType: TScreenForms);
  begin
    if (Data <> nil) then
    begin
      Data^.DataRow.AddAs('TYPE_DATA', AType, ftInteger, SizeOf(Integer));
      Data^.DataRow.AddAs('DSC_TDATA', FORMS_CAPTIONS[AType], ftString, 31);
    end;
  end;
begin
  Node := nil;
  Data := nil;
  aPk  := 0;
  inherited;
  with dmSysEstq do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlTabPriceAndRegions);
    Dados.StartTransaction(qrSqlAux);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    try
      while not qrSqlAux.Eof do
      begin
        if (aPk <> qrSqlAux.FieldByName('PK_TABELA_PRECOS').AsInteger) then
        begin
          Node := AddDataNode(nil, qrSqlAux, Data);
          SetDataType(TScreenForms(vtList.GetNodeLevel(Data^.Node)));
        end;
        if (qrSqlAux.FieldByName('PK_TABELA_ORIGEM_DESTINO').AsInteger  > 0) then
        begin
          AddDataNode(Node, qrSqlAux, Data);
          SetDataType(TScreenForms(vtList.GetNodeLevel(Data^.Node)));
        end;
        aPk  := qrSqlAux.FieldByName('PK_TABELA_PRECOS').AsInteger;
        qrSqlAux.Next;
      end;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
    vtList.FullExpand;
  end;
end;

procedure TCdTabelaPrecos.LoadPages(Sender: TObject);
var
  i: TScreenForms;
const
  FORMS_OF_PAGES     : array [TScreenForms] of TPageClass =
    (TCdTablePrice, TCdCalcRegion);
  FORMS_NAMES        : array [TScreenForms] of string      =
    ('tsPriceTable', 'tsClagRegion');
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

procedure TCdTabelaPrecos.SetActiveRow(Index: Integer; const Value: TDataRow);
begin
  pmInsPriceTable.Visible   := (TScreenForms(Index) = tdTablePrice)                   or (vtList.RootNodeCount = 0);
  pmInsCalcRegion.Visible   := (TScreenForms(Index) in [tdTablePrice, tdCalcRegion]) and (vtList.RootNodeCount > 0);
  FDscTab                   := Value.FieldByName['DSC_TAB'].AsString;
  FFkTablePrice             := Value.FieldByName['PK_TABELA_PRECOS'].AsInteger;
  FFkTypeFraction           := Value.FieldByName['PK_TIPO_TABELA_FRACAO'].AsInteger;
  FFkTableRegion            := Value.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger;
  Pages.ItemIndex           := Index;
  pgMain.ActivePage.Caption := FORMS_CAPTIONS[TScreenForms(Index)];
  case TScreenForms(Index) of
    tdTablePrice  :
      with TCdTablePrice(Pages.Items[Index].Form) do
      begin
        Pk                  := FFkTablePrice;
        tbInsert.MenuItem   := pmInsPriceTable;
      end;
    tdCalcRegion  :
      with TCdCalcRegion(Pages.Items[Index].Form) do
      begin
        FkTablePrice        := FFkTablePrice;
        FkTypeFraction      := FFkTypeFraction;
        Pk                  := Value.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger;
        tbInsert.MenuItem   := pmInsCalcRegion;
      end;
  end;
  if (RowModel = nil) then
    RowModel                := Value;
end;

procedure TCdTabelaPrecos.UpdateRecord(Sender: TObject; Row: TDataRow);
begin
  with ActiveRow[Pages.ItemIndex] do
  begin
    FieldByName['DSC_TDATA'].AsString                        := FORMS_CAPTIONS[TScreenForms(Pages.ItemIndex)];
    FieldByName['TYPE_DATA'].AsInteger                       := Pages.ItemIndex;
    case TScreenForms(Pages.ItemIndex) of
      tdTablePrice  :
        begin
          FFkTablePrice                                      := Row.FieldByName['PK'].AsInteger;
          FDscTab                                            := Row.FieldByName['DSC'].AsString;
        end;
      tdCalcRegion  :
        begin
          FieldByName['PK_TABELA_PRECOS'].AsInteger         := FFkTablePrice;
          FieldByName['PK_TIPO_TABELA_FRACAO'].AsInteger    := Row.FieldByName['PK_TFRAC'].AsInteger;
          FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['REF_ORG'].AsString                   := Row.FieldByName['REF_ORG'].AsString;
          FieldByName['REF_DST'].AsString                   := Row.FieldByName['REF_DST'].AsString;
          FieldByName['DSC_FRAC'].AsString                  := Row.FieldByName['DSC_TAB'].AsString;
        end;
    end;
    FieldByName['PK_TABELA_PRECOS'].AsInteger     := FFkTablePrice;
    FieldByName['DSC_TAB'].AsString               := FDscTab;
  end;
end;

procedure TCdTabelaPrecos.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data  : PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pages.ItemIndex := Sender.GetNodeLevel(Node);
  SetActiveRow(Pages.ItemIndex, Data^.DataRow);
end;

procedure TCdTabelaPrecos.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['PK_TABELA_PRECOS'].AsString + ' / ' +
                   Data^.DataRow.FieldByName['DSC_TAB'].AsString;
    1: CellText := Data^.DataRow.FieldByName['PK_TIPO_TABELA_FRACAO'].AsString + ' / ' +
                   Data^.DataRow.FieldByName['DSC_FRAC'].AsString + ': ' +
                   Data^.DataRow.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsString + ' / ' +
                   Data^.DataRow.FieldByName['REF_ORG'].AsString + ' / ' +
                   Data^.DataRow.FieldByName['REF_DST'].AsString;
  end;
end;

procedure TCdTabelaPrecos.FormDestroy(Sender: TObject);
begin
  FOnCheckDefault := nil;
  inherited;
end;

procedure TCdTabelaPrecos.CheckDefault(Sender: TObject; const Checked: Boolean;
  var Allowed: Boolean);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Allowed := True;
  if (Checked) then
  begin
    with vtList do
    begin
      if (FocusedNode = nil) then
      begin
        Allowed := False;
        exit;
      end;
      Node := GetFirst;
      while (Node <> nil) do
      begin
        if (GetNodeLevel(Node) = 0) and (Node.CheckState = csCheckedNormal) then
          Allowed := False;
        Node := GetNext(Node);
      end;
    end;
  end;
  if Allowed then
  begin
    with vtList do
    begin
      Data := GetNodeData(FocusedNode);
      if (Data = nil) or (Data^.DataRow = nil) then
      begin
        Allowed := False;
        exit;
      end;
      Data^.DataRow.FieldByName['FLAG_DEFTAB'].AsInteger := Ord(Checked);
      OnChecked  := nil;
      OnChecking := nil;
      if Checked then
        FocusedNode.CheckState := csCheckedNormal
      else
        FocusedNode.CheckState := csUnCheckedNormal;
      OnChecked  := vtListChecked;
      OnChecking := vtListChecking;
    end;
  end;
end;

procedure TCdTabelaPrecos.vtListChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  if (Node.CheckState = csUncheckedNormal) and
     (Data^.DataRow.FieldByName['FLAG_DEFTAB'].AsInteger = 1) then
    Data^.DataRow.FieldByName['FLAG_DEFTAB'].AsInteger := 0;
  if (Node.CheckState = csCheckedNormal) and
     (Data^.DataRow.FieldByName['FLAG_DEFTAB'].AsInteger = 0) then
    Data^.DataRow.FieldByName['FLAG_DEFTAB'].AsInteger := 1;
  if Assigned(Pages.Items[0].Form) then
    with TCdTablePrice(Pages.Items[0].Form) do
      FlagDef := (Node.CheckState = csCheckedNormal);
end;

procedure TCdTabelaPrecos.vtListChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
var
  aNode: PVirtualNode;
begin
  if (Node = nil) then exit;
  if (NewState = csCheckedNormal) then
  begin
    with TVirtualStringTree(Sender) do
    begin
      aNode := GetFirst;
      while (aNode <> nil) do
      begin
        if (aNode <> Node) and (aNode.CheckState = csCheckedNormal) then
          Allowed := False;
        aNode := GetNext(ANode);
      end;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode    := Node;
    vtList.Selected[Node] := True;
  end;
end;

procedure TCdTabelaPrecos.FormCreate(Sender: TObject);
begin
  OnLoadList                 := LoadList;
  OnLoadPages                := LoadPages;
  inherited;
  pgMain.Images              := Dados.Image16;
  tsRoot.ImageIndex          := 11;
  tsRegionsMatrix.ImageIndex := 38;
  pmInsert.Images            := Dados.Image16;
  pmInsPriceTable.ImageIndex := 11;
  pmInsCalcRegion.ImageIndex := 38;
  tbInsert.MenuItem          := pmInsPriceTable;
end;

procedure TCdTabelaPrecos.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
begin
  if (Node = nil) then exit;
  if (ScrState in UPDATE_MODE) then
    inherited
  else
    case Sender.GetNodeLevel(Node) of
      0: ImageIndex := 11;
      1: ImageIndex := 38;
    end;
end;

procedure TCdTabelaPrecos.tbInsertClick(Sender: TObject);
var
  Data   : PGridData;
  aDscTab: string;
  aPk    : Integer;
begin
  if (not (Sender is TMenuItem)) then exit;
  tbInsert.MenuItem     := TMenuItem(Sender);
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aDscTab := Data^.DataRow.FieldByName['DSC_TAB'].AsString;
  aPk     := Data^.DataRow.FieldByName['PK_TABELA_PRECOS'].AsInteger;
  Pages.ItemIndex       := TMenuItem(Sender).Tag;
  vtList.OnFocusChanged := nil;
  inherited;
  vtList.OnFocusChanged := vtListFocusChanged;
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Data^.DataRow.FieldByName['DSC_TAB'].AsString                    := aDscTab;
  Data^.DataRow.FieldByName['PK_TABELA_PRECOS'].AsInteger          := aPk;
  Data^.DataRow.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger := FFkTableRegion;
  case TScreenForms(Pages.ItemIndex) of
    tdTablePrice  : Data^.DataRow.FieldByName['PK_TABELA_PRECOS'].AsInteger         := 0;
    tdCalcRegion  : Data^.DataRow.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger := 0;
  end;
  ActiveRow[Pages.ItemIndex] := Data^.DataRow;
end;

initialization
  RegisterClass(TCdTabelaPrecos);

end.

