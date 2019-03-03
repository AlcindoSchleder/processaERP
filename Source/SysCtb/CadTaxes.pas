unit CadTaxes;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 10/07/2006 - DD/MM/YYYY                                    *}
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
  Dialogs, CadMultiModel, ComCtrls, VirtualTrees, ToolWin, ExtCtrls, GridRow,
  ImgList, Menus;

type
  TScreenForms = (tdTypeTax, tdTax, tdTaxPrinter);

  TCdTaxes = class(TfrmMultiModel)
    pmMenu: TPopupMenu;
    pmNewTypeTax: TMenuItem;
    pmNewTax: TMenuItem;
    pmNewTaxPrinter: TMenuItem;
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure vtListBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure FormCreate(Sender: TObject);
    procedure pmNewClick(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure tbInsertClick(Sender: TObject);
  private
    { Private declarations }
    FFocusedLevel : Integer;
    FItemImgSelIdx: Integer;
    FItemImgNrmIdx: Integer;
  protected
    { Protected declarations }
    procedure LoadList(Sender: TObject);
    procedure LoadPages(Sender: TObject);
    procedure UpdateRecord(Sender: TObject; Row: TDataRow);
    procedure SetActiveRow(Index: Integer; const Value: TDataRow); override;
    property  ItemImgNrmIdx: Integer            read FItemImgNrmIdx write FItemImgNrmIdx;
    property  ItemImgSelIdx: Integer            read FItemImgSelIdx write FItemImgSelIdx;
  public
    { Public declarations }
    property  ActiveRow;
    property  OnChangeState;
    property  OnUpdateRow;
  end;

implementation

uses Dado, mSysCtb, ProcType, CtbArqSql, CadTImp, CadAlqt, CadTaxPr, TSysPedAux,
  ProcUtils, TSysManAux;

{$R *.dfm}

{ TCdTaxes }

const
  FORMS_CAPTIONS     : array [TScreenForms] of string      =
    ('Tipo de Impostos', 'Alíquotas dos Impostos',
     'Código das Alíqutoas para Impressora');

procedure TCdTaxes.LoadList(Sender: TObject);
var
  RNode   : PVirtualNode;
  TaxNd   : PVirtualNode;
  AlqtNode: PVirtualNode;
  PData   : PGridData;
  aType   : Smallint;
  aTTax   : Smallint;
begin
  inherited;
  aType    := -1;
  aTTax    := 0;
  RNode    := nil;
  TaxNd    := nil;
  AlqtNode := nil;
  PData    := nil;
  with dmSysCtb do
  begin
    if qrTypeTax.Active then qrTypeTax.Close;
    qrTypeTax.SQL.Clear;
    qrTypeTax.SQL.Add(SqlAllTaxes);
    Dados.StartTransaction(qrTypeTax);
    try
      qrTypeTax.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      if (not qrTypeTax.Active) then qrTypeTax.Open;
      RowModel := TDataRow.CreateFromDataSet(Self, qrTypeTax, False);
      while (not qrTypeTax.Eof) do
      begin
        if (aType <> qrTypeTax.FieldByName('FLAG_ES').AsInteger) then
        begin
          RNode := AddDataNode(nil, qrTypeTax, PData);
          PData^.NodeType := tnFolder;
        end;
        if (aTTax <> qrTypeTax.FieldByName('PK_TIPO_IMPOSTOS').AsInteger) then
          TaxNd := AddDataNode(RNode, qrTypeTax, PData);
        if (not qrTypeTax.FieldByName('FK_PAISES').IsNull) and
           (qrTypeTax.FieldByName('FK_PAISES').AsInteger > 0) and
           (qrTypeTax.FieldByName('FK_ESTADOS').AsString <> '') then
          AlqtNode := AddDataNode(TaxNd, qrTypeTax, PData);
        if (not qrTypeTax.FieldByName('PK_SUPORTED_PRINTERS').IsNull) and
           (qrTypeTax.FieldByName('PK_SUPORTED_PRINTERS').AsInteger > 0) then
          AddDataNode(AlqtNode, qrTypeTax, PData);
        aType    := qrTypeTax.FieldByName('FLAG_ES').AsInteger;
        aTTax    := qrTypeTax.FieldByName('PK_TIPO_IMPOSTOS').AsInteger;
        qrTypeTax.Next;
      end;
    finally
      if qrTypeTax.Active then qrTypeTax.Close;
      Dados.CommitTransaction(qrTypeTax);
    end;
  end;
end;

procedure TCdTaxes.LoadPages(Sender: TObject);
var
  i: TScreenForms;
const
  FORMS_OF_PAGES     : array [TScreenForms] of TPageClass =
    (TCdTypeTax, TCdTax, TCdTaxPrinter);
  FORMS_NAMES        : array [TScreenForms] of string      =
    ('tsTypeTaxes', 'tsTaxes', 'tsPrinterTaxes');
  FORMS_IMAGES_SEL   : array [TScreenForms] of Integer     =
    (11, 16, 61);
  FORMS_IMAGES_NORMAL: array [TScreenForms] of Integer     =
    (19, 83, 37);
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

procedure TCdTaxes.SetActiveRow(Index: Integer; const Value: TDataRow);
begin
  inherited;
  case TScreenForms(Index) of
    tdTypeTax:
      with TCdTypeTax(Pages.Items[Index].Form) do
        Pk := Value.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
    tdTax    :
      with TCdTax(Pages.Items[Index].Form) do
      begin
        FlagES    := TInOut(Value.FieldByName['FLAG_ES'].AsInteger);
        FkTypeTax := Value.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
        Pk        := Value.FieldByName['FK_PAISES'].AsInteger;
      end;
    tdTaxPrinter:
      with TCdTaxPrinter(Pages.Items[Index].Form) do
      begin
        FkTypeTax := Value.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
        FkCountry := Value.FieldByName['FK_PAISES'].AsInteger;
        FkState   := Value.FieldByName['FK_ESTADOS'].AsString;
        FlagES    := TInOut(Value.FieldByName['FLAG_ES'].AsInteger);
        Pk        := Value.FieldByName['PK_ALIQUOTAS_IMP_FISCAL'].AsInteger;
      end;
  end;
end;

procedure TCdTaxes.UpdateRecord(Sender: TObject; Row: TDataRow);
begin
  with ActiveRow[Pages.ItemIndex] do
  begin
    FieldByName['FLAG_ES'].AsInteger := Ord(dmSysCtb.FlagES);
    if (Row.FindField['FK_PAISES'] <> nil) then
      dmSysCtb.FkCountry := Row.FieldByName['FK_PAISES'].AsInteger;
    if (Row.FindField['FK_ESTADOS'] <> nil) then
      dmSysCtb.FkState   := Row.FieldByName['FK_ESTADOS'].AsString;
    if (Row.FindField['PK_ALIQUOTAS'] <> nil) then
      dmSysCtb.FkTax     := Row.FieldByName['PK_ALIQUOTAS'].AsInteger;
    if (Row.FindField['PK_TIPO_IMPOSTOS'] <> nil) then
      dmSysCtb.FkTypeTax := Row.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
    case TScreenForms(Pages.ItemIndex) of
      tdTypeTax:
        begin
          FieldByName['PK_TIPO_IMPOSTOS'].AsInteger := Row.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
          FieldByName['DSC_IMPS'].AsString          := Row.FieldByName['DSC_IMPS'].AsString;
        end;
      tdTax:
        begin
          FieldByName['PK_ALIQUOTAS'].AsInteger := Row.FieldByName['PK_ALIQUOTAS'].AsInteger;
          FieldByName['FK_PAISES'].AsInteger    := Row.FieldByName['FK_PAISES'].AsInteger;
          FieldByName['FK_ESTADOS'].AsString    := Row.FieldByName['FK_ESTADOS'].AsString;
          FieldByName['ALQT_IMPST'].AsFloat     := Row.FieldByName['ALQT_IMPST'].AsFloat;
          FieldByName['DSC_PAIS'].AsString      := TCdTax(Pages.Items[Pages.ItemIndex].Form).DscCountry;
        end;
      tdTaxPrinter:
        begin
          FieldByName['PK_SUPORTED_PRINTERS'].AsInteger    := Row.FieldByName['PK_ALIQUOTAS_IMP_FISCAL'].AsInteger;
          FieldByName['PK_ALIQUOTAS_IMP_FISCAL'].AsInteger := Row.FieldByName['PK_ALIQUOTAS_IMP_FISCAL'].AsInteger;
          FieldByName['DSC_IMP'].AsString       := TCdTaxPrinter(Pages.Items[Pages.ItemIndex].Form).DscPrinter;
          FieldByName['PK_ALIQUOTAS'].AsInteger := dmSysCtb.FkTax;
          FieldByName['FK_PAISES'].AsInteger    := dmSysCtb.FkCountry;
          FieldByName['FK_ESTADOS'].AsString    := dmSysCtb.FkState;
        end;
    end;
  end;
end;

procedure TCdTaxes.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['DSC_TIMP'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DSC_IMPS'].AsString;
    2: CellText := Data^.DataRow.FieldByName['DSC_PAIS'].AsString + ' / ' +
                   Data^.DataRow.FieldByName['FK_ESTADOS'].AsString + ':' +
                   FloatToStrF(Data^.DataRow.FieldByName['ALQT_IMPST'].AsFloat, ffNumber, 7, 4);
    3: CellText := Data^.DataRow.FieldByName['DSC_IMP'].AsString;
  end;
end;

procedure TCdTaxes.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
var
  Data: PGridData;
begin
  if (Node = nil) or (Kind in [ikState, ikOverlay]) or (Column > 0) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (FItemImgNrmIdx = 0) then FItemImgNrmIdx := 11;
  if (FItemImgSelIdx = 0) then FItemImgSelIdx := 19;
  if (Kind = ikSelected) and (ScrState in UPDATE_MODE) then
    ImageIndex := 0
  else
    case Sender.GetNodeLevel(Node) of
      0: if (Data^.DataRow.FieldByName['FLAG_ES'].AsInteger = 0) then
           ImageIndex := 3
         else
           ImageIndex := 4;
      1: ImageIndex := 86;
      2: ImageIndex := FItemImgSelIdx;
      3: ImageIndex := 6;
    end
end;

procedure TCdTaxes.vtListBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if (Node = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: ItemColor := clWhite;
    1: ItemColor := clSkyBlue;
    2: ItemColor := clCream;
    3: ItemColor := clInfoBk;
  end;
  EraseAction := eaColor;
end;

procedure TCdTaxes.FormCreate(Sender: TObject);
begin
  OnLoadList    := LoadList;
  OnLoadPages   := LoadPages;
  pmMenu.Images := Dados.Image16;
  inherited;
  HasFolders    := True;
end;

procedure TCdTaxes.pmNewClick(Sender: TObject);
begin
  if (TMenuItem(Sender).Visible) then
  begin
    tbInsert.MenuItem := TMenuItem(Sender);
    Pages.ItemIndex := TMenuItem(Sender).Tag;
    tbInsert.Click;
  end;
end;

procedure TCdTaxes.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data  : PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  dmSysCtb.FlagES    := TInOut(Data^.DataRow.FieldByName['FLAG_ES'].AsInteger);
  dmSysCtb.FkTypeTax := Data^.DataRow.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
  dmSysCtb.FkCountry := Data^.DataRow.FieldByName['FK_PAISES'].AsInteger;
  dmSysCtb.FkState   := Data^.DataRow.FieldByName['FK_ESTADOS'].AsString;
  dmSysCtb.FkTax     := Data^.DataRow.FieldByName['PK_ALIQUOTAS'].AsInteger;
  FFocusedLevel      := Sender.GetNodeLevel(Node);
  if (FFocusedLevel = 0) then
    Pages.ItemIndex := Ord(tdTypeTax)
  else
    Pages.ItemIndex := FFocusedLevel - 1;
  ActiveRow[Pages.ItemIndex] := Data^.DataRow;
  if (Pages.ItemIndex >= Ord(tdTax)) and (Assigned(Pages.Items[Pages.ItemIndex].Form)) then
    TCdTax(Pages.Items[Ord(tdTax)].Form).EnabledCtrls := (TScreenForms(Pages.ItemIndex) = tdTax);
  if (Pages.ItemIndex >= Ord(tdTaxPrinter)) and
     (Assigned(Pages.Items[Pages.ItemIndex].Form)) then
    TCdTaxPrinter(Pages.Items[Pages.ItemIndex].Form).EnabledCtrls := (TScreenForms(Pages.ItemIndex) = tdTaxPrinter);
  pmNewTypeTax.Visible        := (TScreenForms(Pages.ItemIndex) = tdTypeTax);
  pmNewTax.Visible            := ((TScreenForms(Pages.ItemIndex) in [tdTypeTax, tdTax])    and (FFocusedLevel > 0));
  pmNewTaxPrinter.Visible     := ((TScreenForms(Pages.ItemIndex) in [tdTax, tdTaxPrinter]) and (FFocusedLevel > 1));
  case TScreenForms(Pages.ItemIndex) of
    tdTypeTax   : tbInsert.MenuItem := pmNewTypeTax;
    tdTax       : tbInsert.MenuItem := pmNewTax;
    tdTaxPrinter: tbInsert.MenuItem := pmNewTaxPrinter;
  end;
end;

procedure TCdTaxes.tbInsertClick(Sender: TObject);
var
  Data: PGridData;
begin
  Data := nil;
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data <> nil) then
      begin
        if (TScreenForms(Pages.ItemIndex) = tdTypeTax) and (FFocusedLevel = 0) then
          Data^.NodeType := tnFolder;
        if (TScreenForms(Pages.ItemIndex) = tdTax) and (FFocusedLevel = 1) then
          Data^.NodeType := tnFolder;
        if (TScreenForms(Pages.ItemIndex) = tdTaxPrinter) and (FFocusedLevel = 2) then
          Data^.NodeType := tnFolder;
      end;
    end;
  end;
  Pages.ItemIndex := FFocusedLevel;
  inherited;
  if (Data <> nil) then
    Data^.NodeType := tnData;
end;

initialization
  RegisterClass(TCdTaxes);

end.
