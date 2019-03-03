unit CadTDesc;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 18/04/2006 - DD/MM/YYYY                                      *}
{* Modified:                                                             *}
{* Version: 2.0.0.0                                                      *}
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
  Dialogs, CadModel, StdCtrls, ProcUtils, ExtCtrls, VirtualTrees, GridRow,
  ComCtrls, Mask, ToolEdit, CurrEdit, TSysPedAux, Buttons;

type
  TCdTypeDiscount = class(TfrmModel)
    lDsc_TDsct: TStaticText;
    eDsc_TDsct: TEdit;
    ePk_Tipo_Descontos: TEdit;
    lPk_Tipo_Descontos: TStaticText;
    pTitle: TPanel;
    pgMain: TPageControl;
    tsList: TTabSheet;
    tsDetail: TTabSheet;
    vtList: TVirtualStringTree;
    lFlag_TDsct: TRadioGroup;
    eFk_Categorias: TComboBox;
    lFk_Categorias: TStaticText;
    lFk_Paises: TStaticText;
    eFk_Paises: TComboBox;
    lFk_Estados: TStaticText;
    eFk_Estados: TComboBox;
    lIdx_Dsct: TStaticText;
    eIdx_Dsct: TCurrencyEdit;
    lFlag_Dstq: TCheckBox;
    gbTools: TGroupBox;
    sbSave: TSpeedButton;
    sbCancel: TSpeedButton;
    sbDelete: TSpeedButton;
    sbInsert: TSpeedButton;
    lTitleIdx: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure sbInsertClick(Sender: TObject);
    procedure vtListDblClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure sbCancelClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
  private
    { Private declarations }
    FFkGroupMovim: Integer;
    FDscGmov     : string;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscTDsct: string;
    function  GetPkTypeDiscount: Integer;
    procedure SetDscTDsct(const Value: string);
    procedure SetPkTypeDiscount(const Value: Integer);
    procedure SetDscGmov(const Value: string);
    procedure SetFkGroupMovim(const Value: Integer);
    function  GetDiscounts: TDiscounts;
    function  GetDscCat: string;
    function  GetDscCountry: string;
    function  GetDscState: string;
    function  GetDscType: string;
    function  GetFkCategory: Integer;
    function  GetFkCountry: Integer;
    function  GetFkState: string;
    function  GetFlagDstq: Boolean;
    function  GetFlagTDsct: TTypeOperation;
    function  GetIdxDsct: Double;
    function  VerifyDiscounts(var J: Integer; IncludeScreen: Boolean = False): Boolean;
    procedure SetDiscounts(const Value: TDiscounts);
    procedure SetFkCategory(const Value: Integer);
    procedure SetFkCountry(const Value: Integer);
    procedure SetFkState(const Value: string);
    procedure SetFlagDstq(const Value: Boolean);
    procedure SetFlagTDsct(const Value: TTypeOperation);
    procedure SetIdxDsct(const Value: Double);
    procedure GetDataFromRow(AItem: TDiscount; const AData: TDataRow);
    procedure ClearListControls;
    procedure GetDataRowToControls(AData: TDataRow);
    procedure SetDataRowFromControls(AData: TDataRow);
    procedure ConfigButtons;
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property FkGroupMovim  : Integer        read FFkGroupMovim     write SetFkGroupMovim;
    property DscGmov       : string         read FDscGmov          write SetDscGmov;
    property PkTypeDiscount: Integer        read GetPkTypeDiscount write SetPkTypeDiscount;
    property DscTDsct      : string         read GetDscTDsct       write SetDscTDsct;
    property DscCat        : string         read GetDscCat;
    property DscCountry    : string         read GetDscCountry;
    property DscState      : string         read GetDscState;
    property DscType       : string         read GetDscType;
    property Discounts     : TDiscounts     read GetDiscounts      write SetDiscounts;
    property FkCategory    : Integer        read GetFkCategory     write SetFkCategory;
    property FkCountry     : Integer        read GetFkCountry      write SetFkCountry;
    property FkState       : string         read GetFkState        write SetFkState;
    property IdxDsct       : Double         read GetIdxDsct        write SetIdxDsct;
    property FlagDstq      : Boolean        read GetFlagDstq       write SetFlagDstq;
    property FlagTDsct     : TTypeOperation read GetFlagTDsct      write SetFlagTDsct;
  end;

implementation

uses Dado, mSysPed, ProcType, DB, FuncoesDB;

{$R *.dfm}

{ TCdTypeDiscount }

function TCdTypeDiscount.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
  i: Integer;
begin
  Result := True;
  C := nil;
  S := '';
  if (DscTDsct = '') then
  begin
    S := 'Campo Descrição deve conter um valor';
    C := eDsc_TDsct;
  end;
  if VerifyDiscounts(i) then
  begin
     S := Format('Campo Índice do ítem %d deve ser preenchido', [i]);
     C := vtList;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

function  TCdTypeDiscount.VerifyDiscounts(var J: Integer; IncludeScreen: Boolean = False): Boolean;
var
  i: Integer;
begin
  Result := True;
  with Discounts do
    for i := 0 to Count - 1 do
       if (Items[i].IdxDsct <= 0) then
       begin
         Result := False;
         J := i;
       end;
  if (IncludeScreen) and (IdxDsct <= 0) then Result := False;
end;

procedure TCdTypeDiscount.ClearControls;
begin
  Loading := True;
  try
    PkTypeDiscount := 0;
    DscTDsct       := '';
    ReleaseTreeNodes(vtList);
  finally
    Loading := False;
  end;
end;

procedure TCdTypeDiscount.LoadDefaults;
begin
  DscGmov := '';
end;

procedure TCdTypeDiscount.MoveDataToControls;
var
  aItem: TTypeDiscount;
begin
  Loading := True;
  aItem            := dmSysPed.TypeDiscount[Pk];
  try
    PkTypeDiscount := aItem.PkTypeDiscount;
    DscTDsct       := aItem.DscDsct;
    Discounts      := aItem.Discounts;
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
  ConfigButtons;
end;

procedure TCdTypeDiscount.SaveIntoDB;
var
  aItem: TTypeDiscount;
  aRow : TDataRow;
begin
  aItem                   := TTypeDiscount.Create;
  aRow                    := TDataRow.Create(nil);
  try
    aItem.PkTypeDiscount  := PkTypeDiscount;
    aItem.DscDsct         := DscTDsct;
    aItem.Discounts       := Discounts;
    dmSysPed.TypeDiscount[Ord(ScrState)] := aItem;
    aRow.AddAs('PK', aItem.PkTypeDiscount, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', aItem.DscDsct, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := aItem.PkTypeDiscount;
  finally
    FreeAndNil(aItem);
    FreeAndNil(aRow);
  end;
end;

procedure TCdTypeDiscount.FormCreate(Sender: TObject);
begin
  inherited;
  Dados.Image16.GetBitmap(34, sbInsert.Glyph);
  Dados.Image16.GetBitmap(33, sbDelete.Glyph);
  Dados.Image16.GetBitmap(28, sbCancel.Glyph);
  Dados.Image16.GetBitmap(36, sbSave.Glyph);
  OnCheckRecord := CheckRecord;
  vtList.NodeDataSize := SizeOf(TGridData);
  pgMain.ActivePageIndex := 0;
end;

function TCdTypeDiscount.GetDscTDsct: string;
begin
  Result := eDsc_TDsct.Text;
end;

function TCdTypeDiscount.GetPkTypeDiscount: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Descontos.Text, 0);
end;

procedure TCdTypeDiscount.SetDscTDsct(const Value: string);
begin
  eDsc_TDsct.Text := Value;
end;

procedure TCdTypeDiscount.SetPkTypeDiscount(const Value: Integer);
begin
  ePk_Tipo_Descontos.Text := IntToStr(Value);
end;

procedure TCdTypeDiscount.SetDscGmov(const Value: string);
begin
  FDscGmov := Value;
  pTitle.Caption := 'Tipo de Descontos';
  if (DscGMov <> '') then
    pTitle.Caption := pTitle.Caption + ' - ' + DscGMov;
end;

procedure TCdTypeDiscount.SetFkGroupMovim(const Value: Integer);
begin
  FFkGroupMovim := Value;
  dmSysPed.PkGroupMoviment := Value;
end;

function TCdTypeDiscount.GetDiscounts: TDiscounts;
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  if (pgMain.ActivePageIndex = 0) then
    sbSave.Click;
  Result := TDiscounts.Create(Self);
  with vtList do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data <> nil) and (Data^.DataRow <> nil) then
        GetDataFromRow(Result.Add, Data^.DataRow);
      Node := GetNext(Node);
    end;
  end;
end;

function TCdTypeDiscount.GetFkCategory: Integer;
begin
  Result := 0;
  with eFk_Categorias do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdTypeDiscount.GetFkCountry: Integer;
begin
  Result := 0;
  with eFk_Paises do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdTypeDiscount.GetFkState: string;
begin
  Result := '';
  with eFk_Paises do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := StrPas(PAnsiChar(Items.Objects[ItemIndex]));
end;

function TCdTypeDiscount.GetFlagDstq: Boolean;
begin
  Result := lFlag_Dstq.Checked;
end;

function TCdTypeDiscount.GetFlagTDsct: TTypeOperation;
begin
  Result := TTypeOperation(lFlag_TDsct.ItemIndex);
end;

function TCdTypeDiscount.GetIdxDsct: Double;
begin
  Result := eIdx_Dsct.Value;
end;

procedure TCdTypeDiscount.SetDiscounts(const Value: TDiscounts);
var
  Node: PVirtualNode;
  Data: PGridData;
  i   : Integer;
begin
  ReleaseTreeNodes(vtList);
  if (Value = nil) then exit;
  with vtList do
  begin
    for i := 0 to Value.Count -1 do
    begin
      Node := AddChild(nil);
      if (Node <> nil) then
      begin
        Data := GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.NodeType := tnData;
          Data^.DataRow  := TDataRow.Create(nil);
          Data^.Level    := 0;
          Data^.Node     := Node;
          with Data^.DataRow, Value do
          begin
            AddAs('FK_CATEGORIAS', Items[i].FkCategory.PkCategory, ftInteger, SizeOf(Integer));
            AddAs('FK_PAISES',     Items[i].FkState.FkCountry.PKCountry, ftInteger, SizeOf(Integer));
            AddAs('FK_ESTADOS',    Items[i].FkState.PkState, ftString, 3);
            AddAs('IDX_DSCT',      Items[i].IdxDsct, ftFloat, SizeOf(Double));
            AddAs('FLAG_DSTQ',     Items[i].FlagDstq, ftInteger, SizeOf(Integer));
            AddAs('FLAG_TDSCT',    Items[i].FlagTDsct, ftInteger, SizeOf(Integer));
            AddAs('DSC_CAT',       Items[i].FkState.DscUF, ftString, 31);
            AddAs('DSC_PAIS',      Items[i].FkState.FkCountry.DscPais, ftString, 51);
            AddAs('DSC_UF',        Items[i].FkCategory.DscCat, ftString, 31);
          end;
        end;
      end;
    end;
  end;
end;

procedure TCdTypeDiscount.SetFkCategory(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Categorias do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTypeDiscount.SetFkCountry(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Paises do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTypeDiscount.SetFkState(const Value: string);
var
  i: Integer;
begin
  with eFk_Estados do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (StrPas(PAnsiChar(Items.Objects[i])) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTypeDiscount.SetFlagDstq(const Value: Boolean);
begin
  lFlag_Dstq.Checked := Value;
end;

procedure TCdTypeDiscount.SetFlagTDsct(const Value: TTypeOperation);
begin
  lFlag_TDsct.ItemIndex := Ord(Value);
end;

procedure TCdTypeDiscount.SetIdxDsct(const Value: Double);
begin
  eIdx_Dsct.Value := Value;
end;

procedure TCdTypeDiscount.GetDataFromRow(AItem: TDiscount; const AData: TDataRow);
begin
  AItem.FkCategory.PkCategory       := AData.FieldByName['FK_CATEGORIAS'].AsInteger;
  AItem.FkCategory.DscCat           := AData.FieldByName['DSC_CAT'].AsString;
  AItem.FkState.FkCountry.PKCountry := AData.FieldByName['FK_PAISES'].AsInteger;
  AItem.FkState.PkState             := AData.FieldByName['FK_ESTADOS'].AsString;
  AItem.FkCategory.DscCat           := AData.FieldByName['DSC_CAT'].AsString;
  AItem.FkState.FkCountry.DscPais   := AData.FieldByName['DSC_PAIS'].AsString;
  AItem.FkState.DscUF               := AData.FieldByName['DSC_UF'].AsString;
  AItem.IdxDsct                     := AData.FieldByName['IDX_DSCT'].AsFloat;
  AItem.FlagDstq                    := Boolean(AData.FieldByName['FLAG_DSTQ'].AsInteger);
  AItem.FlagTDsct                   := TTypeOperation(AData.FieldByName['FLAG_TDSCT'].AsInteger);
end;

procedure TCdTypeDiscount.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
  aStr: string;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  with Data^.DataRow do
  begin
    if (Column = 0) then
    begin
      aStr := DscType;
      if (FieldByName['DSC_CAT'].AsString <> '') then
        aStr := aStr + '/' + FieldByName['DSC_CAT'].AsString;
      if (FieldByName['DSC_PAIS'].AsString <> '') then
        aStr := aStr + '/' + FieldByName['DSC_PAIS'].AsString;
      if (FieldByName['DSC_UF'].AsString <> '') then
        aStr := aStr + '/' + FieldByName['DSC_UF'].AsString;
      CellText := aStr;
    end;
    if (Column = 1) then
      CellText := FloatToStrF(FieldByName['IDX_DSCT'].AsFloat, ffNumber, 7, 4);
  end;
end;

procedure TCdTypeDiscount.sbInsertClick(Sender: TObject);
begin
  if (pgMain.ActivePageIndex = 0) then
  begin
    ClearListControls;
    pgMain.ActivePageIndex := 1;
  end;
  ConfigButtons;
end;

procedure TCdTypeDiscount.ClearListControls;
begin
  Loading := True;
  try
    FkCategory := 0;
    FkCountry  := 0;
    FkState    := '';
    IdxDsct    := 0.0;
    FlagDstq   := True;
    FlagTDsct  := toPercent;
  finally
    Loading := False;
  end;
end;

procedure TCdTypeDiscount.vtListDblClick(Sender: TObject);
var
  Data: PGridData;
begin
  if (Pk = 0) then exit;
  if (vtList.RootNodeCount = 0) then
    sbInsert.Click
  else
  begin
    if (vtList.FocusedNode <> nil) then
    begin
      Data := vtList.GetNodeData(vtList.FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
        GetDataRowToControls(Data^.DataRow);
    end;
  end;
end;

procedure TCdTypeDiscount.GetDataRowToControls(AData: TDataRow);
begin
  Loading := True;
  try
    FkCategory := AData.FieldByName['FK_CATEGORIAS'].AsInteger;
    FkCountry  := AData.FieldByName['FK_PAISES'].AsInteger;
    FkState    := AData.FieldByName['FK_ESTADOS'].AsString;
    IdxDsct    := AData.FieldByName['IDX_DSCT'].AsFloat;
    FlagDstq   := Boolean(AData.FieldByName['FLAG_DSTQ'].AsInteger);
    FlagTDsct  := TTypeOperation(AData.FieldByName['FLAG_TDSCT'].AsInteger);
  finally
    Loading := False;
  end;
end;

procedure TCdTypeDiscount.SetDataRowFromControls(AData: TDataRow);
begin
  if (AData.FindField['FK_CATEGORIAS'] = nil) then
    AData.AddAs('FK_CATEGORIAS', FkCategory, ftInteger, SizeOf(Integer))
  else
    AData.FieldByName['FK_CATEGORIAS'].AsInteger := FkCategory;
  if (AData.FindField['DSC_CAT'] = nil) then
    AData.AddAs('DSC_CAT', DscCat, ftString, 31)
  else
    AData.FieldByName['DSC_CAT'].AsString        := DscCat;
  if (AData.FindField['FK_PAISES'] = nil) then
    AData.AddAs('FK_PAISES', FkCountry, ftInteger, SizeOf(Integer))
  else
    AData.FieldByName['FK_PAISES'].AsInteger     := FkCountry;
  if (AData.FindField['DSC_PAIS'] = nil) then
    AData.AddAs('DSC_PAIS', DscCountry, ftString, 51)
  else
    AData.FieldByName['DSC_PAIS'].AsString       := DscCountry;
  if (AData.FindField['FK_ESTADOS'] = nil) then
    AData.AddAs('FK_ESTADOS', FkState, ftString, 3)
  else
    AData.FieldByName['FK_ESTADOS'].AsString     := FkState;
  if (AData.FindField['FK_CATEGORIAS'] = nil) then
    AData.AddAs('FK_CATEGORIAS', FkCategory, ftInteger, SizeOf(Integer))
  else
    AData.FieldByName['DSC_UF'].AsString         := DscState;
  if (AData.FindField['IDX_DSCT'] = nil) then
    AData.AddAs('IDX_DSCT', IdxDsct, ftFloat, SizeOf(Double))
  else
    AData.FieldByName['IDX_DSCT'].AsFloat        := IdxDsct;
  if (AData.FindField['FLAG_DSTQ'] = nil) then
    AData.AddAs('FLAG_DSTQ', Ord(FlagDstq), ftInteger, SizeOf(Integer))
  else
    AData.FieldByName['FLAG_DSTQ'].AsInteger     := Ord(FlagDstq);
  if (AData.FindField['FLAG_TDSCT'] = nil) then
    AData.AddAs('FLAG_TDSCT', Ord(FlagTDsct), ftInteger, SizeOf(Integer))
  else
    AData.FieldByName['FLAG_TDSCT'].AsInteger    := Ord(FlagTDsct);
end;

procedure TCdTypeDiscount.sbDeleteClick(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  Node := vtList.FocusedNode;
  if (Node <> nil) then
  begin
    Data := vtList.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      Data^.DataRow.Free;
      Data^.Node := nil;
      if (vtList.GetNext(vtList.FocusedNode) <> Node) then
        Node := vtList.GetNext(vtList.FocusedNode)
      else
        if (vtList.GetPrevious(vtList.FocusedNode) <> Node) then
          Node := vtList.GetPrevious(vtList.FocusedNode)
        else
          Node := nil;
      vtList.DeleteNode(vtList.FocusedNode);
    end;
  end;
  if (Node <> nil) then
  begin
    vtList.FocusedNode    := Node;
    vtList.Selected[Node] := True;
  end;
  ConfigButtons;
end;

procedure TCdTypeDiscount.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  GetDataRowToControls(Data^.DataRow);
end;

function TCdTypeDiscount.GetDscCat: string;
begin
  Result := eFk_Categorias.Text;
end;

function TCdTypeDiscount.GetDscCountry: string;
begin
  Result := eFk_Paises.Text;
end;

function TCdTypeDiscount.GetDscState: string;
begin
  Result := eFk_Estados.Text;
end;

function TCdTypeDiscount.GetDscType: string;
begin
  with lFlag_TDsct do
  begin
    Result := '';
    if (ItemIndex > -1) then
      Result := Items[ItemIndex];
  end;
end;

procedure TCdTypeDiscount.sbCancelClick(Sender: TObject);
begin
  if (pgMain.ActivePageIndex = 1) then
    pgMain.ActivePageIndex := 0;
  if (vtList.RootNodeCount > 0) then
    vtListFocusChanged(vtList, vtList.FocusedNode, 0);
  ConfigButtons;
end;

procedure TCdTypeDiscount.sbSaveClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtList.AddChild(nil);
  if (Node <> nil) then
  begin
    Data := vtList.GetNodeData(Node);
    if (Data <> nil) then
    begin
      Data^.DataRow := TDataRow.Create(nil);
      if (Data^.DataRow <> nil) then
      begin
        SetDataRowFromControls(Data^.DataRow);
        Data^.Level    := 0;
        Data^.NodeType := tnData;
        Data^.Node     := Node;
      end;
    end;
  end;
  pgMain.ActivePageIndex := 0;
  if (Node <> nil) then
  begin
    vtList.FocusedNode    := Node;
    vtList.Selected[Node] := True;
  end;
  ConfigButtons;
end;

procedure TCdTypeDiscount.ConfigButtons;
var
  i: Integer;
begin
  sbInsert.Enabled := (pgMain.ActivePageIndex = 0) and (Pk > 0);
  sbDelete.Enabled := (vtList.RootNodeCount   > 0) and (vtList.FocusedNode <> nil) and (Pk > 0);
  sbCancel.Enabled := (pgMain.ActivePageIndex > 0);
  sbSave.Enabled   := (pgMain.ActivePageIndex > 0) and (VerifyDiscounts(i, True));
end;

end.


