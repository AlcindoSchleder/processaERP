unit CadRCalc;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 02/06/2003 - DD/MM/YYYY                                    *}
{* Modified : 22/01/2007 - DD/MM/YYYY                                    *}
{* Version  : 1.5.0.0                                                    *}
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
  Dialogs, CadModel, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, ProcUtils,
  VirtualTrees, ComCtrls, Buttons;

type
  TDscOrgmDstn = record
    DscOrgm: string;
    DscDstn: string;
  end;

  TCdCalcRegion = class(TfrmModel)
    shTitle: TShape;
    lTitle: TLabel;
    lFk_Tabela_Origem_Destino: TStaticText;
    eFk_Tabela_Origem_Destino: TComboBox;
    sbNewRegion: TSpeedButton;
    lVlr_Exd: TStaticText;
    lFlag_Exd: TCheckBox;
    eVlr_Exd: TCurrencyEdit;
    lPerc_Gris: TStaticText;
    ePerc_Gris: TCurrencyEdit;
    eVlr_Min_Gris: TCurrencyEdit;
    lVlr_Min_Gris: TStaticText;
    eDiv_Ped: TCurrencyEdit;
    lDiv_Ped: TStaticText;
    lVlr_Ped: TStaticText;
    eVlr_Ped: TCurrencyEdit;
    lFlag_TOper: TRadioGroup;
    vtList: TVirtualStringTree;
    lFk_Tipo_Tabela_Fracao: TStaticText;
    eFk_Tipo_Tabela_Fracao: TComboBox;
    sbNewFraction: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtListInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtListChecking(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var NewState: TCheckState; var Allowed: Boolean);
    procedure vtListChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtListEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vtListNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure vtListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtListEdited(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure sbNewRegionClick(Sender: TObject);
    procedure sbNewFractionClick(Sender: TObject);
  private
    { Private declarations }
    FFkTablePrice: Integer;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDivPed: Double;
    function  GetFlagTOper: Integer;
    function  GetFlagVExd: Boolean;
    function  GetFractions: TList;
    function  GetPercGris: Double;
    function  GetVlrExd: Double;
    function  GetVlrMinGris: Double;
    function  GetVlrPed: Double;
    function  GetFkTableOrgDst: Integer;
    function  GetDscOrgmDstn: TDscOrgmDstn;
    function  GetFkTypeFraction: Integer;
    procedure SetDivPed(const Value: Double);
    procedure SetFkTablePrice(const Value: Integer);
    procedure SetFlagTOper(const Value: Integer);
    procedure SetFlagVExd(const Value: Boolean);
    procedure SetFractions(const Value: TList);
    procedure SetPercGris(const Value: Double);
    procedure SetVlrExd(const Value: Double);
    procedure SetVlrMinGris(const Value: Double);
    procedure SetVlrPed(const Value: Double);
    procedure SetFkTypeFraction(const Value: Integer);
    procedure SetFkTableOrgDst(const Value: Integer);
    procedure InsertBlankNode;
    function GetDscTFrac: string;
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  FkTableOrgDst : Integer      read GetFkTableOrgDst  write SetFkTableOrgDst;
    property  FlagTPOper    : Integer      read GetFlagTOper      write SetFlagTOper;
    property  VlrExd        : Double       read GetVlrExd         write SetVlrExd;
    property  FlagVExd      : Boolean      read GetFlagVExd       write SetFlagVExd;
    property  PercGris      : Double       read GetPercGris       write SetPercGris;
    property  VlrMinGris    : Double       read GetVlrMinGris     write SetVlrMinGris;
    property  DivPed        : Double       read GetDivPed         write SetDivPed;
    property  VlrPed        : Double       read GetVlrPed         write SetVlrPed;
    property  Fractions     : TList        read GetFractions      write SetFractions;
  public
    { Public declarations }
    property  DscOrgmDstn   : TDscOrgmDstn read GetDscOrgmDstn;
    property  DscTFrac      : string       read GetDscTFrac;
    property  FkTablePrice  : Integer      read FFkTablePrice     write SetFkTablePrice;
    property  FkTypeFraction: Integer      read GetFkTypeFraction write SetFkTypeFraction;
  end;

var
  CdCalcRegion: TCdCalcRegion;

implementation

uses Dado, mSysEstq, GridRow, DB, ProcType, FuncoesDB, CadOrgDst, Funcoes,
  CadTFrac;

{$R *.dfm}

function TCdCalcRegion.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
end;

procedure TCdCalcRegion.ClearControls;
begin
  Loading := True;
  try
    FkTableOrgDst  := 0;
//    FkTypeFraction := 0;
    FlagTPOper     := 0;
    VlrExd         := 0.0;
    FlagVExd       := False;
    PercGris       := 0.0;
    VlrMinGris     := 0.0;
    DivPed         := 0.0;
    VlrPed         := 0.0;
    Fractions      := nil;
  finally
    Loading      := False;
  end;
end;

procedure TCdCalcRegion.FormCreate(Sender: TObject);
begin
  vtList.NodeDataSize    := SizeOf(TGridData);
  inherited;
  OnCheckRecord          := CheckRecord;
end;

procedure TCdCalcRegion.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Tabela_Origem_Destino.Items.AddStrings(dmSysEstq.LoadTableRegions);
    eFk_Tipo_Tabela_Fracao.Items.AddStrings(dmSysEstq.LoadTypeFractions);
    ListLoaded := True;
  end;
end;

procedure TCdCalcRegion.MoveDataToControls;
var
  Data: TDataRow;
begin
  Loading        := True;
  try
    Data             := dmSysEstq.TableFraction[Pk];
    if (Data = nil) or (Data.Count = 0) then exit;
    FkTableOrgDst    := Data.FieldByName['FK_TABELA_ORIGEM_DESTINO'].AsInteger;
    FkTypeFraction   := Data.FieldByName['FK_TIPO_TABELA_FRACAO'].AsInteger;
    FlagTPOper       := Data.FieldByName['FLAG_TPOPER'].AsInteger;
    VlrExd           := Data.FieldByName['VLR_EXD'].AsFloat;
    FlagVExd         := Boolean(Data.FieldByName['FLAG_VEXD'].AsInteger);
    PercGris         := Data.FieldByName['PERC_GRIS'].AsFloat;
    VlrMinGris       := Data.FieldByName['VLR_MIN_GRIS'].AsFloat;
    DivPed           := Data.FieldByName['DIV_PED'].AsFloat;
    VlrPed           := Data.FieldByName['VLR_PED'].AsFloat;
    Fractions        := dmSysEstq.Fractions[Pk];
  finally
    FreeAndNil(Data);
    Loading      := False;
  end;
end;

procedure TCdCalcRegion.SaveIntoDB;
var
  Data: TDataRow;
begin
  Data           := TDataRow.Create(Self);
  if (Data = nil) then exit;
  try
    Data.AddAs('FK_TABELA_PRECOS', FkTablePrice, ftInteger, SizeOf(Integer));
    Data.AddAs('FK_TIPO_TABELA_FRACAO', FkTypeFraction, ftInteger, SizeOf(Integer));
    Data.AddAs('FK_TABELA_ORIGEM_DESTINO', FkTableOrgDst, ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_TPOPER', FlagTPOper, ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_VEXD', FlagVExd, ftInteger, SizeOf(Integer));
    Data.AddAs('VLR_EXD', VlrExd, ftFloat, SizeOf(Double));
    Data.AddAs('PERC_GRIS', PercGris, ftFloat, SizeOf(Double));
    Data.AddAs('VLR_MIN_GRIS', VlrMinGris, ftFloat, SizeOf(Double));
    Data.AddAs('DIV_PED', DivPed, ftFloat, SizeOf(Double));
    Data.AddAs('VLR_PED', VlrPed, ftFloat, SizeOf(Double));
    dmSysEstq.TableFraction[Ord(ScrState)] := Data;
    dmSysEstq.Fractions[FkTableOrgDst] := Fractions;
    Data.AddAs('PK', FkTableOrgDst, ftInteger, SizeOf(Integer));
    Data.AddAs('REF_ORG', DscOrgmDstn.DscOrgm, ftString, Length(DscOrgmDstn.DscOrgm) + 1);
    Data.AddAs('REF_DST', DscOrgmDstn.DscDstn, ftString, Length(DscOrgmDstn.DscDstn) + 1);
    Data.AddAs('PK_TFRAC', FkTypeFraction, ftInteger, SizeOf(Integer));
    Data.AddAs('DSC_TAB', DscTFrac, ftString, Length(DscTFrac) + 1);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, Data);
    Pk := Data.FieldByName['FK_TABELA_ORIGEM_DESTINO'].AsInteger;
  finally
    FreeAndNil(Data);
  end;
end;

procedure TCdCalcRegion.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtList);
  inherited;
end;

function TCdCalcRegion.GetDivPed: Double;
begin
  Result := eDiv_Ped.Value;
end;

function TCdCalcRegion.GetFlagTOper: Integer;
begin
  Result := lFlag_TOper.ItemIndex;
end;

function TCdCalcRegion.GetFlagVExd: Boolean;
begin
  Result := lFlag_Exd.Checked;
end;

function TCdCalcRegion.GetFractions: TList;
var
  Node: PVirtualNode;
begin
  Result := TList.Create;
  with vtList do
  begin
    if (RootNodeCount = 0) then exit;
    Node := GetFirst;
    while Node <> nil do
    begin
      if (GetNodeData(Node) <> nil) and (PGridData(GetNodeData(Node))^.DataRow <> nil) then
        Result.Add(PGridData(GetNodeData(Node))^.DataRow);
      Node := GetNext(Node);
    end;
  end;
end;

function TCdCalcRegion.GetPercGris: Double;
begin
  Result := ePerc_Gris.Value;
end;

function TCdCalcRegion.GetVlrExd: Double;
begin
  Result := eVlr_Exd.Value;
end;

function TCdCalcRegion.GetVlrMinGris: Double;
begin
  Result := eVlr_Min_Gris.Value;
end;

function TCdCalcRegion.GetVlrPed: Double;
begin
  Result := eVlr_Ped.Value;
end;

procedure TCdCalcRegion.SetDivPed(const Value: Double);
begin
  eDiv_Ped.Value := Value;
end;

procedure TCdCalcRegion.SetFkTablePrice(const Value: Integer);
begin
  FFkTablePrice          := Value;
  dmSysEstq.FkTablePrice := FFkTablePrice;
end;

procedure TCdCalcRegion.SetFlagTOper(const Value: Integer);
begin
  lFlag_TOper.ItemIndex := Value;
end;

procedure TCdCalcRegion.SetFlagVExd(const Value: Boolean);
begin
  lFlag_Exd.Checked := Value;
end;

procedure TCdCalcRegion.SetFractions(const Value: TList);
var
  i: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtList);
  if (Value = nil) or (Value.Count = 0) then
  begin
    InsertBlankNode;
    exit;
  end;
  for i := 0 to Value.Count - 1 do
  begin
    Node := vtList.AddChild(nil);
    if (Node <> nil) then
    begin
      Data := vtList.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Node     := Node;
        Data^.Level    := vtList.GetNodeLevel(Node);
        Data^.NodeType := tnData;
        Data^.DataRow  := TDataRow.CreateAs(vtList, TDataRow(Value.Items[i]));
      end;
    end;
  end;
  if (vtList.RootNodeCount = 0) then
    InsertBlankNode;
end;

procedure TCdCalcRegion.SetPercGris(const Value: Double);
begin
  ePerc_Gris.Value := Value;
end;

procedure TCdCalcRegion.SetVlrExd(const Value: Double);
begin
  eVlr_Exd.Value := Value;
end;

procedure TCdCalcRegion.SetVlrMinGris(const Value: Double);
begin
  eVlr_Min_Gris.Value := Value;
end;

procedure TCdCalcRegion.SetVlrPed(const Value: Double);
begin
  eVlr_Ped.Value := Value;
end;

procedure TCdCalcRegion.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_INI'].AsFloat, ffNumber, 7, Dados.DecimalPlaces);
    1: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_FIN'].AsFloat, ffNumber, 7, Dados.DecimalPlaces);
    2: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_IDX'].AsFloat, ffNumber, 7, Dados.DecimalPlaces);
    3: CellText := FloatToStrF(Data^.DataRow.FieldByName['PERC_ADV'].AsFloat, ffNumber, 7, 2);
    4: CellText := FloatToStrF(Data^.DataRow.FieldByName['TAX_TAB'].AsFloat, ffNumber, 7, Dados.DecimalPlaces);
  end;
end;

procedure TCdCalcRegion.vtListBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if (Node = nil) then exit;
  if (Odd(Sender.AbsoluteIndex(Node))) then
    ItemColor := clSkyBlue
  else
    ItemColor := clInfoBk;
  EraseAction := eaColor;
end;

procedure TCdCalcRegion.vtListInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Node.CheckType  := ctCheckBox;
  Node.CheckState := csUncheckedNormal;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FLAG_MFINAL'].AsInteger = 1) then
    Node.CheckState := csCheckedNormal;
end;

procedure TCdCalcRegion.vtListChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
begin
  if (Node = nil) then exit;
  if (NewState = csCheckedNormal) then
    Allowed := (Sender.AbsoluteIndex(Node) = (vtList.RootNodeCount - 1));
end;

procedure TCdCalcRegion.vtListChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Node.CheckState = csUncheckedNormal) then
    Data^.DataRow.FieldByName['FLAG_MFINAL'].AsInteger := 0
  else
    Data^.DataRow.FieldByName['FLAG_MFINAL'].AsInteger := 1;
  if (not Loading) and (ScrState in SCROLL_MODE) then
    ScrState := dbmEdit;
end;

procedure TCdCalcRegion.vtListEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  Data: PGridData;
begin
  Allowed := False;
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Allowed := True;
end;

procedure TCdCalcRegion.vtListNewText(Sender: TBaseVirtualTree;
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
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (((Column = 2) and (FlagTPOper = 1)) or (Column = 3)) and
     ((StrToFloatDef(NewText, -1) < 0) or (StrToFloatDef(NewText, -1) > 99.9999)) then
  begin
    S := 'O valor neste campo deve ser um percentual entre 0,00 e 99,9999';
    DisplayColumnWarning;
    exit;
  end
  else
    if (StrToFloatDef(NewText, -1) < 0) then
    begin
      S := 'O valor neste campo deve ser um número positivo > 0';
      DisplayColumnWarning;
      exit;
    end;
  Value := StrToFloat(NewText);
  case Column of
    0: Data^.DataRow.FieldByName['VLR_INI'].AsFloat  := Value;
    1: Data^.DataRow.FieldByName['VLR_FIN'].AsFloat  := Value;
    2: Data^.DataRow.FieldByName['VLR_IDX'].AsFloat  := Value;
    3: Data^.DataRow.FieldByName['PERC_ADV'].AsFloat := Value;
    4: Data^.DataRow.FieldByName['TAX_TAB'].AsFloat  := Value;
  end;
end;

procedure TCdCalcRegion.InsertBlankNode;
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
      Data^.Node     := Node;
      Data^.Level    := vtList.GetNodeLevel(Node);
      Data^.NodeType := tnData;
      Data^.DataRow  := TDataRow.Create(vtList);
      Data^.DataRow.AddAs('FK_TABELA_PRECOS', FFkTablePrice, ftInteger, SizeOf(Integer));
      Data^.DataRow.AddAs('FK_TIPO_TABELA_FRACAO', dmSysEstq.FkTypeFraction, ftInteger, SizeOf(Integer));
      Data^.DataRow.AddAs('FK_TABELA_ORIGEM_DSTINO', Pk, ftInteger, SizeOf(Integer));
      Data^.DataRow.AddAs('VLR_INI', 0.0, ftFloat, SizeOf(Double));
      Data^.DataRow.AddAs('VLR_FIN', 0.0, ftFloat, SizeOf(Double));
      Data^.DataRow.AddAs('FLAG_MFINAL', 0, ftInteger, SizeOf(Integer));
      Data^.DataRow.AddAs('VLR_IDX', 0.0, ftFloat, SizeOf(Double));
      Data^.DataRow.AddAs('PERC_ADV', 0.0, ftFloat, SizeOf(Double));
      Data^.DataRow.AddAs('TAX_TAB', 0.0, ftFloat, SizeOf(Double));
    end;
  end;
  vtList.FocusedColumn := 0;
end;

procedure TCdCalcRegion.vtListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node: PVirtualNode;
  Data: PGridData;
  aCol: Integer;
  procedure DeleteANode;
  begin
    if (Node = nil) then exit;
    Data := TVirtualStringTree(Sender).GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    Data^.Level := 0;
    Data^.Node  := nil;
    FreeAndNil(Data^.DataRow);
    TVirtualStringTree(Sender).DeleteNode(Node);
  end;
begin
  with TVirtualStringTree(Sender) do
  begin
    Node := FocusedNode;
    if (Node = nil) then exit;
    Data := GetNodeData(Node);
    if (Data = nil) and (Data^.DataRow = nil) then exit;
    aCol := vtList.FocusedColumn;
    if (aCol = 4) and (Key = VK_RETURN) then
      Key := VK_DOWN;
    case Key of
      VK_UP   : if (RootNodeCount > 1) then
                  if (GetFirst = Node) then
                    FocusedNode := GetLast
                  else
                    if (Data^.DataRow.FieldByName['VLR_INI'].AsFloat = 0) and
                       (Data^.DataRow.FieldByName['VLR_FIN'].AsFloat = 0) and
                       (Data^.DataRow.FieldByName['VLR_IDX'].AsFloat = 0) and
                       (Data^.DataRow.FieldByName['TAX_TAB'].AsFloat = 0) then
                      DeleteANode;
      VK_DOWN : if (Data^.DataRow.FieldByName['VLR_INI'].AsFloat = 0) and
                   (Data^.DataRow.FieldByName['VLR_FIN'].AsFloat = 0) and
                   (Data^.DataRow.FieldByName['VLR_IDX'].AsFloat = 0) and
                   (Data^.DataRow.FieldByName['TAX_TAB'].AsFloat = 0) then
                  if (RootNodeCount > 1) then
                    DeleteANode
                  else
                    Data^.DataRow.ClearFieldValues
                else
                  if (GetLast = Node) then
                    InsertBlankNode;
      VK_RETURN: begin
                   if (FocusedColumn < 4) then
                     FocusedColumn := FocusedColumn + 1
                   else
                     FocusedColumn := 0;
                   EditNode(FocusedNode, FocusedColumn);
                 end;
    else
      if (not (ssShift in Shift)) and (ssCtrl in Shift) and (Key = VK_DELETE) then
        DeleteANode;
    end;
  end;
end;

procedure TCdCalcRegion.vtListEdited(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  if (not Loading) and (ScrState in SCROLL_MODE) then
    ScrState := dbmEdit;
end;

procedure TCdCalcRegion.SetFkTypeFraction(const Value: Integer);
var
  i: Integer;
begin
  if (Value > 0) then
    dmSysEstq.FkTypeFraction := Value;
  with eFk_Tipo_Tabela_Fracao do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

function TCdCalcRegion.GetFkTableOrgDst: Integer;
begin
  Result := 0;
  with eFk_Tabela_Origem_Destino do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

procedure TCdCalcRegion.SetFkTableOrgDst(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tabela_Origem_Destino do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdCalcRegion.sbNewRegionClick(Sender: TObject);
var
  aForm: TCdOrgmDstn;
  aFkOD: Integer;
begin
  aFkOD := FkTableOrgDst;
  aForm := TCdOrgmDstn.Create(Application);
  try
    aForm.ShowModal;
    ReleaseCombos(eFk_Tabela_Origem_Destino, toInteger);
    ListLoaded := False;
    LoadDefaults;
    if (aFkOD > 0) then FkTableOrgDst := aFkOD;
  finally
    FreeAndNil(aForm);
  end;
end;

function TCdCalcRegion.GetDscOrgmDstn: TDscOrgmDstn;
var
  Data: TDataRow;
begin
  Result.DscDstn := '';
  Result.DscOrgm := '';
  if (FkTableOrgDst > 0) then
  begin
    Data := dmSysEstq.LoadDscTableRegion(FkTableOrgDst);
    if (Data <> nil) and (Data.Count > 0) then
    begin
      Result.DscDstn := Data.FieldByName['DSC_DSTN'].AsString;
      Result.DscOrgm := Data.FieldByName['DSC_ORGM'].AsString;
    end;
  end;
end;

function TCdCalcRegion.GetFkTypeFraction: Integer;
begin
  Result := 0;
  with eFk_Tipo_Tabela_Fracao do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

procedure TCdCalcRegion.sbNewFractionClick(Sender: TObject);
var
  aForm: TCdTypeFraction;
  aFkTF: Integer;
begin
  aFkTF := FkTypeFraction;
  aForm := TCdTypeFraction.Create(Application);
  try
    aForm.ShowModal;
    ReleaseCombos(eFk_Tabela_Origem_Destino, toInteger);
    ListLoaded := False;
    LoadDefaults;
    if (aFkTF > 0) then FkTypeFraction := aFkTF;
  finally
    FreeAndNil(aForm);
  end;
end;

function TCdCalcRegion.GetDscTFrac: string;
begin
  Result := eFk_Tipo_Tabela_Fracao.Text;
end;

end.
