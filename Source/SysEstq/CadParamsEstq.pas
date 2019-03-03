unit CadParamsEstq;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 18/04/2003 - DD/MM/YYYY                                    *}
{* Modified : 18/05/2003 - DD/MM/YYYY                                    *}
{* Version  : 1.0.0.0                                                    *}
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
  Dialogs, CadListModel, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ProcUtils,
  Mask, ToolEdit, CurrEdit, ExtCtrls;

type
  TCdParamsEstq = class(TfrmModelList)
    eFk_Almoxarifados: TComboBox;
    eFk_Tipo_Movim_Estq_In: TComboBox;
    eFk_Tipo_Movim_Estq_Out: TComboBox;
    gbTitle: TGroupBox;
    lTitle: TLabel;
    lFk_Almoxarifados: TStaticText;
    lFk_Tipo_Movim_Estq_In: TStaticText;
    lFk_Tipo_Movim_Estq_Out: TStaticText;
    lPrz_Entr: TStaticText;
    eMrg_Def: TCurrencyEdit;
    lFlag_TMrgm: TRadioGroup;
    lFlag_TCost: TRadioGroup;
    lFlag_TAcabm: TRadioGroup;
    lFk_Tabela_Precos: TStaticText;
    eFk_Tabela_Precos: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure lFlag_TMrgmClick(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetFkAlmox: Integer;
    function  GetFkPriceTable: Integer;
    function  GetFkTypeMovInput: Integer;
    function  GetFkTypeMovOutPut: Integer;
    function  GetFlagTMrgm: Integer;
    function  GetFlagTCost: Integer;
    function  GetFlagTAcabm: Integer;
    function  GetMrgDef: Double;
    procedure SetFkAlmox(const Value: Integer);
    procedure SetFkPriceTable(const Value: Integer);
    procedure SetFkTypeMovInput(const Value: Integer);
    procedure SetFkTypeMovOutPut(const Value: Integer);
    procedure SetFlagTMrgm(const Value: Integer);
    procedure SetFlagTCost(const Value: Integer);
    procedure SetFlagTAcabm(const Value: Integer);
    procedure SetMrgDef(const Value: Double);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property FkAlmox        : Integer read GetFkAlmox         write SetFkAlmox;
    property FkTypeMovInput : Integer read GetFkTypeMovInput  write SetFkTypeMovInput;
    property FkTypeMovOutPut: Integer read GetFkTypeMovOutPut write SetFkTypeMovOutPut;
    property FkPriceTable   : Integer read GetFkPriceTable    write SetFkPriceTable;
    property FlagTMrgm      : Integer read GetFlagTMrgm       write SetFlagTMrgm;
    property FlagTCost      : Integer read GetFlagTCost       write SetFlagTCost;
    property FlagTAcabm     : Integer read GetFlagTAcabm      write SetFlagTAcabm;
    property MrgDef         : Double  read GetMrgDef          write SetMrgDef;
  end;

var
  CdParamsEstq: TCdParamsEstq;

implementation

uses Dado, mSysEstq, GridRow, DB, ProcType, EstqArqSql, TSysEstqAux;

{$R *.dfm}

{ TCdParams }

function TCdParamsEstq.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  S := '';
  C := nil;
  Result := True;
  if (FkPriceTable = 0) then
  begin
    C := eFk_Tabela_Precos;
    S := 'Campo Tabela de Preços default deve ser preenchido';
  end;
  if (FkTypeMovInput = 0) then
  begin
    C := eFk_Tipo_Movim_Estq_In;
    S := 'Campo Tipo de Movimento de estoques de entrada default deve ser preenchido';
  end;
  if (FkTypeMovOutPut = 0) then
  begin
    C := eFk_Tipo_Movim_Estq_Out;
    S := 'Campo Tipo de Movimento de estoques de saída default deve ser preenchido';
  end;
  if (MrgDef = 0) then
  begin
    C := eMrg_Def;
    S := 'Campo Margem de lucro default deve ser preenchido';
  end;
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdParamsEstq.ClearControls;
begin
  Loading := True;
  try
    FkAlmox         := 0;
    FkPriceTable    := 0;
    FkTypeMovInput  := 0;
    FkTypeMovOutPut := 0;
    MrgDef          := 0.0;
    FlagTAcabm      := 0;
    FlagTCost       := 0;
    FlagTMrgm       := 0;
  finally
    Loading := False;
  end;
end;

function TCdParamsEstq.GetFkAlmox: Integer;
begin
  Result := 0;
  with eFk_Almoxarifados do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdParamsEstq.GetFkPriceTable: Integer;
begin
  Result := 0;
  with eFk_Tabela_Precos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdParamsEstq.GetFkTypeMovInput: Integer;
begin
  Result := 0;
  with eFk_Tipo_Movim_Estq_In do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdParamsEstq.GetFkTypeMovOutPut: Integer;
begin
  Result := 0;
  with eFk_Tipo_Movim_Estq_Out do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdParamsEstq.GetFlagTMrgm: Integer;
begin
  Result := lFlag_TMrgm.ItemIndex;
end;

function TCdParamsEstq.GetFlagTCost: Integer;
begin
  Result := lFlag_TCost.ItemIndex;
end;

function TCdParamsEstq.GetFlagTAcabm: Integer;
begin
  Result := lFlag_TAcabm.ItemIndex;
end;

function TCdParamsEstq.GetMrgDef: Double;
begin
  Result := eMrg_Def.Value;
end;

procedure TCdParamsEstq.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Almoxarifados.Items.AddStrings(dmSysEstq.LoadAlmox);
    eFk_Tipo_Movim_Estq_In.Items.AddStrings(dmSysEstq.LoadTypeMovement(0));
    eFk_Tipo_Movim_Estq_Out.Items.AddStrings(dmSysEstq.LoadTypeMovement(1));
    eFk_Tabela_Precos.Items.AddStrings(dmSysEstq.LoadPriceTable);
    ListLoaded := True;
  end;
end;

procedure TCdParamsEstq.LoadList(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  inherited;
  with dmSysEstq, vtList do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlAllEstqParams);
    BeginUpdate;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    try
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(nil, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        Node := AddChild(nil);
        if (Node <> nil) then
        begin
          Data := GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
            Data^.Level   := 0;
            Data^.Node    := Node;
          end;
        end;
        qrSqlAux.Next;
      end;
    finally
      EndUpdate;
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
    if (RootNodeCount > 0) then
    begin
      FocusedNode         := GetFirst;
      Selected[FocusedNode] := True;
    end;
  end;
end;

procedure TCdParamsEstq.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysEstq.ParamEstq[Pk] do
    begin
      FkAlmox         := FieldByName['FK_ALMOXARIFADOS'].AsInteger;
      FkTypeMovInput  := FieldByName['FK_TIPO_MOVIM_ESTQ__ENTR'].AsInteger;
      FkTypeMovOutPut := FieldByName['FK_TIPO_MOVIM_ESTQ__SAI'].AsInteger;
      FkPriceTable    := FieldByName['FK_TABELA_PRECOS'].AsInteger;
      MrgDef          := FieldByName['MRG_DEF'].AsFloat;
      FlagTAcabm      := FieldByName['FLAG_TACABM'].AsInteger;
      FlagTCost       := FieldByName['FLAG_TCUSTO'].AsInteger;
      FlagTMrgm       := FieldByName['FLAG_TMRGM'].AsInteger;
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdParamsEstq.SaveIntoDB;
var
  aData: TDataRow;
  Data : PGridData;
  APk  : Integer;
begin
  if (vtList.FocusedNode = nil) then exit;
  Data := vtList.GetNodeData(vtList.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  APk := Data^.DataRow.FieldByName['PK_EMPRESAS'].AsInteger;
  if (APk = 0) then exit;
  aData := TDataRow.Create(nil);
  try
    aData.AddAs('FK_EMPRESAS', APk, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_ALMOXARIFADOS', FkAlmox, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_TIPO_MOVIM_ESTQ__ENTR', FkTypeMovInput, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_TIPO_MOVIM_ESTQ__SAI', FkTypeMovOutPut, ftInteger, SizeOf(Integer));
    aData.AddAs('FK_TABELA_PRECOS', FkPriceTable, ftInteger, SizeOf(Integer));
    aData.AddAs('MRG_DEF', MrgDef, ftFloat, SizeOf(Double));
    aData.AddAs('FLAG_TACABM', FlagTAcabm, ftInteger, SizeOf(Integer));
    aData.AddAs('FLAG_TCUSTO', FlagTCost, ftInteger, SizeOf(Integer));
    aData.AddAs('FLAG_TMRGM', FlagTMrgm, ftInteger, SizeOf(Integer));
    dmSysEstq.ParamEstq[Ord(ScrState)] := aData;
    Pk := APk;
  finally
    FreeAndNil(aData);
  end;
end;

procedure TCdParamsEstq.SetFkAlmox(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Almoxarifados do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParamsEstq.SetFkPriceTable(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tabela_Precos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (TPriceTable(Items.Objects[i]).PkPriceTable = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParamsEstq.SetFkTypeMovInput(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Movim_Estq_In do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (TTypeMoviment(Items.Objects[i]).PkTypeMoviment = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParamsEstq.SetFkTypeMovOutPut(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Movim_Estq_Out do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (TTypeMoviment(Items.Objects[i]).PkTypeMoviment = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdParamsEstq.SetMrgDef(const Value: Double);
begin
  eMrg_Def.Value := Value
end;

procedure TCdParamsEstq.SetFlagTMrgm(const Value: Integer);
begin
  lFlag_TMrgm.ItemIndex := Value;
end;

procedure TCdParamsEstq.SetFlagTCost(const Value: Integer);
begin
  lFlag_TCost.ItemIndex := Value;
end;

procedure TCdParamsEstq.SetFlagTAcabm(const Value: Integer);
begin
  lFlag_TAcabm.ItemIndex := Value;
end;

procedure TCdParamsEstq.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
  CanInsertNode := False;
end;

procedure TCdParamsEstq.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
end;

procedure TCdParamsEstq.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['FK_EMPRESAS'].AsInteger;
end;

procedure TCdParamsEstq.lFlag_TMrgmClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  case lFlag_TMrgm.ItemIndex of
    0:
      begin
        eMrg_Def.DecimalPlaces := 4;
        eMrg_Def.DisplayFormat := ',0.0000;- ,0.0000';
      end;
    1:
      begin
        eMrg_Def.DecimalPlaces := 2;
        eMrg_Def.DisplayFormat := ',0.00 %;- ,0.00 %';
      end;
  end;
end;

initialization
  RegisterClass(TCdParamsEstq);

end.
