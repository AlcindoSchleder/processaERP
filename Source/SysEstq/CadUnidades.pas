unit CadUnidades;

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
  Dialogs, CadListModel, StdCtrls, VirtualTrees, ComCtrls, ToolWin, ProcUtils,
  ExtCtrls;

type
  TCdUnidades = class(TfrmModelList)
    lPk_Unidades: TStaticText;
    ePk_Unidades: TEdit;
    lMnmo_Uni: TStaticText;
    eMnmo_Uni: TEdit;
    eFlag_FUni: TComboBox;
    lFlag_FUni: TStaticText;
    lFlag_TUni: TStaticText;
    eFlag_TUni: TComboBox;
    eDsc_Uni: TEdit;
    lDsc_Uni: TStaticText;
    lFlag_Frac: TCheckBox;
    lFlag_Qtd: TCheckBox;
    lFlag_Comp: TCheckBox;
    lFlag_Larg: TCheckBox;
    lFlag_Alt: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure eFlag_FUniSelect(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscUni: string;
    function  GetFlagAlt: Boolean;
    function  GetFlagComp: Boolean;
    function  GetFlagFrac: Boolean;
    function  GetFlagFUni: Integer;
    function  GetFlagLarg: Boolean;
    function  GetFlagQtd: Boolean;
    function  GetFlagTUni: Integer;
    function  GetMnmoUni: string;
    function  GetPkUnit: Integer;
    procedure SetDscUni(const Value: string);
    procedure SetFlagAlt(const Value: Boolean);
    procedure SetFlagComp(const Value: Boolean);
    procedure SetFlagFrac(const Value: Boolean);
    procedure SetFlagFUni(const Value: Integer);
    procedure SetFlagLarg(const Value: Boolean);
    procedure SetFlagQtd(const Value: Boolean);
    procedure SetFlagTUni(const Value: Integer);
    procedure SetMnmoUni(const Value: string);
    procedure SetPkUnit(const Value: Integer);
    procedure LoadUnits;
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkUnit  : Integer read GetPkUnit   write SetPkUnit;
    property  MnmoUni : string  read GetMnmoUni  write SetMnmoUni;
    property  DscUni  : string read GetDscUni   write SetDscUni;
    property  FlagFUni: Integer read GetFlagFUni write SetFlagFUni;
    property  FlagTUni: Integer read GetFlagTUni write SetFlagTUni;
    property  FlagFrac: Boolean read GetFlagFrac write SetFlagFrac;
    property  FlagQtd : Boolean read GetFlagQtd  write SetFlagQtd;
    property  FlagComp: Boolean read GetFlagComp write SetFlagComp;
    property  FlagLarg: Boolean read GetFlagLarg write SetFlagLarg;
    property  FlagAlt : Boolean read GetFlagAlt  write SetFlagAlt;
  public
    { Public declarations }
  end;

var
  CdUnidades: TCdUnidades;

implementation

uses Dado, mSysEstq, UnitRsc_pt, ConvUtils, GridRow, ProcType, DB, TSysEstqAux;

{$R *.dfm}

function TCdUnidades.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (DscUni = '') then
  begin
    C := eDsc_Uni;
    S := 'Campo descrição deve ser preenchido';
  end;
  if (MnmoUni = '') then
  begin
    C := eMnmo_Uni;
    S := 'Campo Sigla da Unidade deve ser preenchido';
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdUnidades.ClearControls;
begin
  Loading := True;
  try
    PkUnit   := 0;
    MnmoUni  := '';
    DscUni   := '';
    FlagFUni := 0;
    FlagTUni := 0;
    FlagFrac := False;
    FlagQtd  := True;
    FlagComp := False;
    FlagLarg := False;
    FlagAlt  := False;
  finally
    Loading := False;
  end;
end;

procedure TCdUnidades.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

function TCdUnidades.GetDscUni: string;
begin
  Result := eDsc_Uni.Text;
end;

function TCdUnidades.GetFlagAlt: Boolean;
begin
  Result := lFlag_Alt.Checked;
end;

function TCdUnidades.GetFlagComp: Boolean;
begin
  Result := lFlag_Comp.Checked;
end;

function TCdUnidades.GetFlagFrac: Boolean;
begin
  Result := lFlag_Frac.Checked;
end;

function TCdUnidades.GetFlagFUni: Integer;
begin
  Result := 0;
  with eFlag_FUni do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdUnidades.GetFlagLarg: Boolean;
begin
  Result := lFlag_Larg.Checked;
end;

function TCdUnidades.GetFlagQtd: Boolean;
begin
  Result := lFlag_Qtd.Checked;
end;

function TCdUnidades.GetFlagTUni: Integer;
begin
  Result := 0;
  with eFlag_TUni do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdUnidades.GetMnmoUni: string;
begin
  Result := eMnmo_Uni.Text;
end;

function TCdUnidades.GetPkUnit: Integer;
begin
  Result := StrToIntDef(ePk_Unidades.Text, 0);
end;

procedure TCdUnidades.LoadDefaults;
var
  FamilyList: TConvFamilyArray;
  i: Integer;
begin
  Loading := True;
  try
    eFlag_FUni.Items.AddObject('Quantidade', nil);
    GetConvFamilies(FamilyList);
    for i := 0 to Length(FamilyList) - 1 do
      eFlag_FUni.Items.AddObject(ConvFamilyToDescription(FamilyList[i]),
        TObject(LongInt(FamilyList[i])));
  finally
    Loading := False;
  end;
end;

procedure TCdUnidades.LoadList(Sender: TObject);
var
  aStr: TStrings;
  Node: PVirtualNode;
  Data: PGridData;
  i   : Integer;
begin
  inherited;
  aStr := dmSysEstq.LoadUnits(False);
  if (RowModel = nil) or (RowModel.Count = 0) then
  begin
    if (RowModel = nil) then
      RowModel := TDataRow.Create(Self);
    RowModel.AddAs('PK_UNIDADES', 0, ftInteger, SizeOf(Integer));
    RowModel.AddAs('DSC_UNI', '', ftString, 31);
    RowModel.AddAs('MNMO_UNI', '', ftString, 3);
    RowModel.AddAs('FLAG_FRAC', Ord(False), ftInteger, SizeOf(Integer));
    RowModel.AddAs('FLAG_ALT', Ord(False), ftInteger, SizeOf(Integer));
    RowModel.AddAs('FLAG_LARG', Ord(False), ftInteger, SizeOf(Integer));
    RowModel.AddAs('FLAG_COMP', Ord(False), ftInteger, SizeOf(Integer));
    RowModel.AddAs('FLAG_QTD', Ord(False), ftInteger, SizeOf(Integer));
    RowModel.AddAs('FLAG_FUNI', 0, ftInteger, SizeOf(Integer));
    RowModel.AddAs('FLAG_TUNI', 0, ftInteger, SizeOf(Integer));
  end;
  for i := 0 to aStr.Count -1 do
  begin
    if (aStr.Objects[i] <> nil) then
    begin
      Node := vtList.AddChild(nil);
      if (Node <> nil) then
      begin
        Data := vtList.GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.Level   := 0;
          Data^.Node    := Node;
          Data^.DataRow := TDataRow.Create(nil);
          Data^.DataRow.AddAs('PK_UNIDADES', TUnit(aStr.Objects[i]).PkUnit, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('DSC_UNI', TUnit(aStr.Objects[i]).DscUni, ftString, 31);
          Data^.DataRow.AddAs('MNMO_UNI', TUnit(aStr.Objects[i]).MnmoUni, ftString, 3);
          Data^.DataRow.AddAs('FLAG_FRAC', Ord(TUnit(aStr.Objects[i]).FlagFrac), ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('FLAG_ALT', Ord(TUnit(aStr.Objects[i]).FlagAlt), ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('FLAG_LARG', Ord(TUnit(aStr.Objects[i]).FlagLarg), ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('FLAG_COMP', Ord(TUnit(aStr.Objects[i]).FlagComp), ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('FLAG_QTD', Ord(TUnit(aStr.Objects[i]).FlagQtd), ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('FLAG_FUNI', TUnit(aStr.Objects[i]).FlagFUni, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('FLAG_TUNI', TUnit(aStr.Objects[i]).FlagTUni, ftInteger, SizeOf(Integer));
        end;
      end;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdUnidades.LoadUnits;
var
  TypeList   : TConvTypeArray;
  i          : Integer;
  CurFamily  : TConvFamily;
  Description: string;
  aLoad      : Boolean;
begin
  aLoad := Loading; // save actual state of loading;
  Loading := True;
  try
    eFlag_TUni.Items.Clear;
    Description := eFlag_FUni.Items[eFlag_FUni.ItemIndex];
    if DescriptionToConvFamily(Description, CurFamily) then
    begin
      GetConvTypes(CurFamily, TypeList);
      for i := 0 to Length(TypeList) -1 do
        eFlag_TUni.Items.AddObject(ConvTypeToDescription(TypeList[i]),
          TObject(LongInt(TypeList[i])));
    end;
  finally
    Loading := aLoad; // recoup the original state
  end;
end;

procedure TCdUnidades.MoveDataToControls;
var
  aUnit: TUnit;
begin
  Loading := True;
  try
    aUnit    := dmSysEstq.Units[Pk];
    PkUnit   := aUnit.PkUnit;
    MnmoUni  := aUnit.MnmoUni;
    DscUni   := aUnit.DscUni;
    FlagFUni := aUnit.FlagFUni;
    FlagTUni := aUnit.FlagTUni;
    FlagFrac := aUnit.FlagFrac;
    FlagQtd  := aUnit.FlagQtd;
    FlagComp := aUnit.FlagComp;
    FlagLarg := aUnit.FlagLarg;
    FlagAlt  := aUnit.FlagAlt;
  finally
    FreeAndNil(aUnit);
    Loading := False;
  end;
end;

procedure TCdUnidades.SaveIntoDB;
var
  aUnit: TUnit;
  Data : PGridData;
begin
  Data                  := nil;
  aUnit                 := TUnit.Create;
  try
    aUnit.PkUnit        := PkUnit;
    aUnit.MnmoUni       := MnmoUni;
    aUnit.DscUni        := DscUni;
    aUnit.FlagFUni      := FlagFUni;
    aUnit.FlagTUni      := FlagTUni;
    aUnit.FlagFrac      := FlagFrac;
    aUnit.FlagQtd       := FlagQtd;
    aUnit.FlagComp      := FlagComp;
    aUnit.FlagLarg      := FlagLarg;
    aUnit.FlagAlt       := FlagAlt;
    dmSysEstq.Units[Ord(ScrState)] := aUnit;
    if (vtList.FocusedNode <> nil) then
    begin
      Data := vtList.GetNodeData(vtList.FocusedNode);
      if (Data <> nil) or (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['PK_UNIDADES'].AsInteger := aUnit.PkUnit;
        Data^.DataRow.FieldByName['DSC_UNI'].AsString      := aUnit.DscUni;
      end;
    end;
  finally
    FreeAndNil(aUnit);
  end;
  Pk := Data^.DataRow.FieldByName['PK_UNIDADES'].AsInteger;
end;

procedure TCdUnidades.SetDscUni(const Value: string);
begin
  eDsc_Uni.Text := Value;
end;

procedure TCdUnidades.SetFlagAlt(const Value: Boolean);
begin
  lFlag_Alt.Checked := Value;
end;

procedure TCdUnidades.SetFlagComp(const Value: Boolean);
begin
  lFlag_Comp.Checked := Value;
end;

procedure TCdUnidades.SetFlagFrac(const Value: Boolean);
begin
  lFlag_Frac.Checked := Value;
end;

procedure TCdUnidades.SetFlagFUni(const Value: Integer);
begin
  if (eFlag_FUni.Items.Count > Value) then
  begin
    eFlag_FUni.ItemIndex := Value;
    LoadUnits;
  end;
end;

procedure TCdUnidades.SetFlagLarg(const Value: Boolean);
begin
  lFlag_Larg.Checked := Value;
end;

procedure TCdUnidades.SetFlagQtd(const Value: Boolean);
begin
  lFlag_Qtd.Checked := Value;
end;

procedure TCdUnidades.SetFlagTUni(const Value: Integer);
begin
  if (eFlag_TUni.Items.Count > Value) then
    eFlag_TUni.ItemIndex := Value;
end;

procedure TCdUnidades.SetMnmoUni(const Value: string);
begin
  eMnmo_Uni.Text := Value;
end;

procedure TCdUnidades.SetPkUnit(const Value: Integer);
begin
  ePk_Unidades.Text := IntToStr(Value);
end;

procedure TCdUnidades.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_UNIDADES'].AsInteger;
end;

procedure TCdUnidades.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_UNI'].AsString;
end;

procedure TCdUnidades.eFlag_FUniSelect(Sender: TObject);
begin
  LoadUnits;
  ChangeGlobal(Sender);
end;

initialization
  RegisterClass(TCdUnidades);

end.
