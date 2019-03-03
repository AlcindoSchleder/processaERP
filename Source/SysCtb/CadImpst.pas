unit CadImpst;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/01/2006 - DD/MM/YYYY                                      *}
{* Modified: 03/01/2006 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcUtils, VirtualTrees, ComCtrls, ToolWin, ImgList, GridRow,
  PrcSysTypes;

type
  THandleInsertEvent = procedure (Sender: TObject; var Row: TDataRow) of object;

  TCdImpostos = class(TForm)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    sbStatus: TStatusBar;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    tbSave: TToolButton;
    ToolButton5: TToolButton;
    ToolButton1: TToolButton;
    tbClose: TToolButton;
    tbInsert: TToolButton;
    vtList: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbCancelClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbCloseClick(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure vtListFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtListEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vtListNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure tbInsertClick(Sender: TObject);
    procedure vtListBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtListDblClick(Sender: TObject);
  private
    { Private declarations }
    FItemImgNrmIdx  : Integer;
    FItemImgSelIdx  : Integer;
    FListLoaded     : Boolean;
    FLoading        : Boolean;
    FRect           : TRect;
    FRowModel       : TDataRow;
    FScrState       : TDBMode;
    procedure SetScrState(const Value: TDBMode);
    function  GetFocusedRow: TDataRow;
    function  GetFocusedLevel: Integer;
    procedure ShowTaxesForm(const APk: Integer; AState: TDBMode = dbmBrowse);
  protected
    { Protected declarations }
    FCompanyClick: Boolean;
    procedure DeleteFromDB;
    procedure LoadList;
    procedure SaveIntoDB;
  public
    { Public declarations }
    property  FocusedLevel : Integer            read GetFocusedLevel;
    property  FocusedRow   : TDataRow           read GetFocusedRow;
    property  ItemImgNrmIdx: Integer            read FItemImgNrmIdx write FItemImgNrmIdx;
    property  ItemImgSelIdx: Integer            read FItemImgSelIdx write FItemImgSelIdx;
    property  ListLoaded   : Boolean            read FListLoaded    write FListLoaded;
    property  Loading      : Boolean            read FLoading       write FLoading;
    property  ScrState     : TDBMode            read FScrState      write SetScrState;
  end;

implementation

{$R *.dfm}

{ TfrmModel }

uses Dado, SelEmpr, ProcType, FuncoesDB, mSysCtb, CtbArqSql, DB, CadTImp;

procedure TCdImpostos.FormCreate(Sender: TObject);
begin
  cbTools.Images       := Dados.Image16;
  tbTools.Images       := Dados.Image16;
  vtList.Images        := Dados.Image16;
  vtList.Header.Images := Dados.Image16;
  vtList.NodeDataSize  := SizeOf(TGridData);
  FScrState            := dbmBrowse;
end;

procedure TCdImpostos.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtList);
  if Assigned(FRowModel) then
    FRowModel.Free;
  FRowModel      := nil;
end;

procedure TCdImpostos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (FScrState in UPDATE_MODE) then
    if (Dados.DisplayMessage('Há alterações na tela. Deseja sair e abandonar ' +
          'as alterações?', hiQuestion, [mbYes, mbNo]) = mrNo) then
      Action := caNone;
end;

procedure TCdImpostos.FormShow(Sender: TObject);
begin
  Caption := Application.Title + ' - ' + Dados.Parametros.ProgramTitle;
  LoadList;
  ScrState := dbmBrowse;
end;

procedure TCdImpostos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
  end;
end;

procedure TCdImpostos.SetScrState(const Value: TDBMode);
begin
  if (FScrState <> Value) then
  begin
    if (Value <> dbmPost) then
      FScrState := Value;
    case Value of
      dbmDelete: DeleteFromDB;
      dbmPost  : SaveIntoDB;
    end;
    FScrState := Value;
  end;
  tbInsert.Enabled := False;
  tbCancel.Enabled := (FScrState in UPDATE_MODE);
  tbDelete.Enabled := (FScrState in SCROLL_MODE) and (vtList.RootNodeCount > 0);
  tbSave.Enabled   := (FScrState in UPDATE_MODE);
  tbClose.Enabled  := (FScrState in SCROLL_MODE);
  sbStatus.Repaint;
  vtList.Refresh;
end;

procedure TCdImpostos.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    FCompanyClick := False;
    SelEmpresa.Free;
  end;
  sbStatus.Repaint;
end;

procedure TCdImpostos.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  if (not (Panel.Index in [1, 2])) then exit;
  StatusBar.Canvas.Brush.Color := clBtnFace;
  StatusBar.Canvas.Font.Style  := [fsBold];
  StatusBar.Canvas.Font.Name := 'Arial';
  StatusBar.Canvas.FillRect(Rect);
  if (Panel.Index = 1) then
  begin
    FRect := Rect;
    StatusBar.Canvas.Font.Color := ClNavy;
    Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
    StatusBar.Canvas.TextOut(Rect.Left + 22, Rect.Top + 1,'Empresa: ' +
      IntToStr(Dados.PkCompany) + ' / ' + Dados.NameCompany);
  end;
  if Panel.Index = 2 then
  begin
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrState];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrState]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
  end;
end;

procedure TCdImpostos.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TCdImpostos.tbInsertClick(Sender: TObject);
begin
  ShowTaxesForm(0, dbmInsert);
  LoadList;
end;

procedure TCdImpostos.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmCancel;
  ScrState := dbmBrowse;
end;

procedure TCdImpostos.tbDeleteClick(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  if (vtList.FocusedNode <> nil) then
  begin
    if (Dados.DisplayMessage('Deseja realmente excluir este registro?', hiQuestion,
        [mbYes, mbNo]) = mrNo) then
      exit;
    Node := vtList.FocusedNode;
    vtList.BeginUpdate;
    try
      ScrState := dbmDelete;
      Data     := vtList.GetNodeData(vtList.FocusedNode);
      if (Data <> nil) then
      begin
        Data^.Node  := nil;
        Data^.Level := 0;
        if (Data^.DataRow <> nil) then Data^.DataRow.Free;
        Data^.DataRow := nil;
      end;
      vtList.DeleteNode(Node);
    finally
      vtList.EndUpdate;
      ScrState := dbmBrowse;
    end;
  end;
end;

procedure TCdImpostos.tbSaveClick(Sender: TObject);
begin
  ScrState := dbmPost;
  ScrState := dbmBrowse;
end;

procedure TCdImpostos.tbCloseClick(Sender: TObject);
begin
  Close;
end;

function TCdImpostos.GetFocusedLevel: Integer;
begin
  Result := -1;
  if (vtList.RootNodeCount > 0) and (vtList.FocusedNode <> nil) then
    Result := vtList.GetNodeLevel(vtList.FocusedNode);
end;

function TCdImpostos.GetFocusedRow: TDataRow;
var
  Data: PGridData;
begin
  Result := nil;
  if (vtList.RootNodeCount > 0) and (vtList.FocusedNode <> nil) then
  begin
    Data := vtList.GetNodeData(vtList.FocusedNode);
    if (Data <> nil) and (Data^.DataRow <> nil) then
      Result := Data^.DataRow;
  end;
end;

procedure TCdImpostos.DeleteFromDB;
begin
  if (FocusedRow.FindField['STATUS'] = nil) or
     (FocusedRow.FieldByName['FK_TIPO_IMPOSTOS'].AsInteger = 0) then
    exit;
  if FocusedLevel = 2 then
//    dmSysCtb.SaveAliquota(FocusedRow,
//      TBMode(FocusedRow.FieldByName['STATUS'].AsInteger));
  if FocusedLevel = 3 then
//    dmSysCtb.SavePrinterAliquota(FocusedRow,
//      TBMode(FocusedRow.FieldByName['STATUS'].AsInteger));
end;

procedure TCdImpostos.LoadList;
var
  RNode: PVirtualNode;
  TaxNd: PVirtualNode;
  aUfNd: PVirtualNode;
  aData: PGridData;
  aType,
  aTTax,
  aEmpr,
  aEstd,
  aPrnt: string;
  function AddNodeData(ANode: PVirtualNode): PVirtualNode;
  begin
    Result := vtList.AddChild(ANode);
    if (Result <> nil) then
    begin
      aData := vtList.GetNodeData(Result);
      if (aData <> nil) then
      begin
        aData^.Level   := vtList.GetNodeLevel(Result);
        aData^.Node    := Result;
        aData^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysCtb.qrTypeTax, True);
        if (aData^.Level > 1) then
          aData^.DataRow.AddAs('STATUS', Ord(dbmBrowse), ftInteger, SizeOf(Integer));
      end;
    end;
  end;
begin
  if (vtList.RootNodeCount > 0) then
    ReleaseTreeNodes(vtList);
  aType := '';
  aTTax := '';
  aEstd := '';
  aEmpr := '';
  aPrnt := '';
  with dmSysCtb do
  begin
    if qrTypeTax.Active then qrTypeTax.Close;
    qrTypeTax.SQL.Clear;
    qrTypeTax.SQL.Add(SqlAllTaxes);
    Dados.StartTransaction(qrTypeTax);
    try
      if (not qrTypeTax.Active) then qrTypeTax.Open;
      FRowModel := TDataRow.CreateFromDataSet(Self, qrTypeTax, False);
      while (not qrTypeTax.Eof) do
      begin
        if (aType <> qrTypeTax.FieldByName('DSC_TYPE').AsString) or
           (aEmpr <> qrTypeTax.FieldByName('RAZ_SOC').AsString) then
          RNode := AddNodeData(nil);
        if (aTTax <> qrTypeTax.FieldByName('DSC_IMPS').AsString) then
          TaxNd := AddNodeData(RNode);
        if (aEstd <> qrTypeTax.FieldByName('PK_ESTADOS').AsString) then
          aUfNd := AddNodeData(TaxNd);
        if (aPrnt <> qrTypeTax.FieldByName('DSC_IMP').AsString) then
          AddNodeData(aUfNd);
        aType := qrTypeTax.FieldByName('DSC_TYPE').AsString;
        aEmpr := qrTypeTax.FieldByName('RAZ_SOC').AsString;
        aTTax := qrTypeTax.FieldByName('DSC_IMPS').AsString;
        aEstd := qrTypeTax.FieldByName('PK_ESTADOS').AsString;
        aPrnt := qrTypeTax.FieldByName('DSC_IMP').AsString;
        qrTypeTax.Next;
      end;
    finally
      if qrTypeTax.Active then qrTypeTax.Close;
      Dados.CommitTransaction(qrTypeTax);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    if (not vtList.Expanded[vtList.FocusedNode]) then
      vtList.Expanded[vtList.FocusedNode] := True;
  end;
end;

procedure TCdImpostos.SaveIntoDB;
begin
end;

procedure TCdImpostos.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: if (Column = 0) then CellText := Data^.DataRow.FieldByName['DSC_TYPE'].AsString +
                                        Data^.DataRow.FieldByName['FK_ESTADOS'].AsString + ' / ' +
                                        Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
    1: if (Column = 0) then CellText := Data^.DataRow.FieldByName['DSC_IMPS'].AsString;
    2:
      case Column of
        0: CellText := Data^.DataRow.FieldByName['DSC_PAIS'].AsString + ' / ' +
                       Data^.DataRow.FieldByName['PK_ESTADOS'].AsString;
        1: CellText := FloatToStrF(Data^.DataRow.FieldByName['ALQT_IMPST'].AsFloat, ffNumber, 7, 4);
        2: CellText := FloatToStrF(Data^.DataRow.FieldByName['ALQT_CNSF'].AsFloat, ffNumber, 7, 4);
        3: CellText := FloatToStrF(Data^.DataRow.FieldByName['ALQT_ARBT'].AsFloat, ffNumber, 7, 4);
      end;
    3:
      case Column of
        0: CellText := Data^.DataRow.FieldByName['DSC_IMP'].AsString;
        1: CellText := InsereZer(IntToStr(Data^.DataRow.FieldByName['COD_ALQT'].AsInteger), 2);
        2: CellText := InsereZer(IntToStr(Data^.DataRow.FieldByName['COD_ALQT_CNSF'].AsInteger), 2);
      end;
  end;
end;

procedure TCdImpostos.vtListPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) or (Sender.GetNodeLevel(Node) < 2) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FindField['STATUS'] <> nil) and
     (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in UPDATE_MODE) then
    TargetCanvas.Font.Color := clRed
  else
    if (Data^.DataRow.FieldByName['FK_TIPO_IMPOSTOS'].AsInteger = 0) then
      TargetCanvas.Font.Color := clGray
    else
      TargetCanvas.Font.Color := clBlue;
end;

procedure TCdImpostos.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
begin
  if (Node = nil) or (Kind in [ikState, ikOverlay]) or (Column > 0) then exit;
  if (FItemImgNrmIdx = 0) then FItemImgNrmIdx := 11;
  if (FItemImgSelIdx = 0) then FItemImgSelIdx := 19;
  if (Kind = ikSelected) then
    if (ScrState in UPDATE_MODE) then
      ImageIndex := 0
    else
      case Sender.GetNodeLevel(Node) of
        0: ImageIndex := 26;
        1: ImageIndex := 86;
        2: ImageIndex := FItemImgSelIdx;
        3: ImageIndex := 6;
      end
  else
    if (Kind = ikNormal) then
      case Sender.GetNodeLevel(Node) of
        0: ImageIndex := 26;
        1: ImageIndex := 86;
        2: ImageIndex := FItemImgNrmIdx;
        3: ImageIndex := 6;
      end;
end;

procedure TCdImpostos.vtListFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
var
  Data: PGridData;
begin
  if (OldNode = nil) then exit;
  if (Sender.IsEditing) then Sender.EndEditNode;
  Data := Sender.GetNodeData(OldNode);
  if (Data = nil) or (Data^.DataRow = nil) or
     ((NewNode = nil) or (OldNode = NewNode)) then
    exit;
  Sender.FullCollapse;
  if (Sender.GetNodeLevel(NewNode) < 3) and (not Sender.Expanded[NewNode]) then
    Sender.Expanded[NewNode] := True;
  Data := Sender.GetNodeData(NewNode);
  tbInsert.Enabled := (Sender.GetNodeLevel(NewNode) <= 1);
  tbCancel.Enabled := (FScrState in UPDATE_MODE) and (Sender.GetNodeLevel(NewNode) > 1);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  tbDelete.Enabled := (FScrState in SCROLL_MODE) and (Sender.GetNodeLevel(NewNode) > 1) and
     (Data^.DataRow.FieldByName['FK_TIPO_IMPOSTOS'].AsInteger > 0) and
     (vtList.RootNodeCount > 0);
end;

procedure TCdImpostos.vtListEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
  if (Node = nil) or (Sender.GetNodeLevel(Node) < 2) then exit;
  Allowed := ((Sender.GetNodeLevel(Node) > 1) and (Column > 0));
  if (Allowed) and (Sender.GetNodeLevel(Node) = 3)then
    Allowed := (Column in [1, 2]);
end;

procedure TCdImpostos.vtListNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data : PGridData;
  S    : string;
  Value: Double;
  procedure DisplayColumnWarning;
  var
    R: TRect;
  begin
    R := Sender.GetDisplayRect(Node, Column, False);
    R.BottomRight.Y := R.BottomRight.Y + (ClientHeight - vtList.Height -
                       Integer(TVirtualStringTree(Sender).DefaultNodeHeight));
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight, S);
  end;
begin
  if (Node = nil) or (Sender.GetNodeLevel(Node) < 2) or (Column < 1) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 2) then
  begin
    if (StrToFloatDef(NewText, -1) < 0) or (StrToFloatDef(NewText, -1) > 99.9999) then
    begin
      S := 'O valor neste campo deve ser um percentual entre 0,00 e 99,9999';
      DisplayColumnWarning;
      exit;
    end;
    Value := StrToFloat(NewText);
    case Column of
      1: Data^.DataRow.FieldByName['ALQT_IMPST'].AsFloat := Value;
      2: Data^.DataRow.FieldByName['ALQT_CNSF'].AsFloat  := Value;
      3: Data^.DataRow.FieldByName['ALQT_ARBT'].AsFloat  := Value;
    end;
  end;
  if (Sender.GetNodeLevel(Node) = 3) then
  begin
    if (StrToIntDef(NewText, 0) = 0) then
    begin
      S := 'Este campo deve conter o código da alíquota na impressora';
      DisplayColumnWarning;
      exit;
    end;
    Value := StrToInt(NewText);
    case Column of
      1: Data^.DataRow.FieldByName['COD_ALQT_'].AsInteger      := Trunc(Value);
      2: Data^.DataRow.FieldByName['COD_ALQT_CNSF'].AsInteger  := Trunc(Value);
    end;
  end;
  if (Data^.DataRow.FieldByName['FK_TIPO_IMPOSTOS'].AsInteger = 0) then
  begin
    Data^.DataRow.FieldByName['FK_TIPO_IMPOSTOS'].AsInteger :=
      Data^.DataRow.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger;
    if (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in SCROLL_MODE) then
      Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmInsert);
  end
  else
    if (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in SCROLL_MODE) then
      Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmEdit);
  if (Data^.DataRow.FieldByName['STATUS'].AsInteger <> Ord(ScrState)) then
    ScrState := TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger);
end;

procedure TCdImpostos.vtListBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FLAG_ES'].AsInteger = 0) then
    if (Sender.GetNodeLevel(Node) > 1) then
      if (Sender.GetNodeLevel(Node) = 3) then
        ItemColor := clWhite
      else
        ItemColor := clInfoBk
    else
      ItemColor := clSkyBlue
  else
    if (Sender.GetNodeLevel(Node) > 1) then
      if (Sender.GetNodeLevel(Node) = 3) then
        ItemColor := clWhite
      else
        ItemColor := clInfoBk
    else
      ItemColor := clMoneyGreen;
  EraseAction := eaColor;
end;

procedure TCdImpostos.vtListDblClick(Sender: TObject);
var
  Data: PGridData;
begin
  with TVirtualStringTree(Sender) do
  begin
    if (FocusedNode = nil) or (GetNodeLevel(FocusedNode) <> 1) then exit;
    Data := GetNodeData(FocusedNode);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    ShowTaxesForm(Data^.DataRow.FieldByName['PK_TIPO_IMPOSTOS'].AsInteger);
  end;
end;

procedure TCdImpostos.ShowTaxesForm(const APk: Integer; AState: TDBMode = dbmBrowse);
begin
  CdTypeTax := TCdTypeTax.Create(Application);
  try
    CdTypeTax.BorderStyle := bsSizeable;
    CdTypeTax.Position    := poDesktopCenter;
    CdTypeTax.Pk          := APk;
    CdTypeTax.ScrState    := AState;
    CdTypeTax.ShowModal;
  finally
    CdTypeTax.Free;
    CdTypeTax := nil;
  end;
end;

end.
