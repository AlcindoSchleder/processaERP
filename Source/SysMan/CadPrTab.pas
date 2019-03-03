unit CadPrTab;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2007 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 07/07/2008 - DD/MM/YYYY                                    *}
{* Modified :            - DD/MM/YYYY                                    *}
{* Version  : 0.0.0.1                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@processa.org                                       *}
{*            http://www.processa.org                                    *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadModelList, VirtualTrees, ComCtrls, ToolWin, StdCtrls, ProcUtils,
  ExtCtrls, SipData, Spin;

type
  TfrmPriceTable = class(TfrmModelList)
    lPkPriceTable: TStaticText;
    ePkPriceTable: TSpinEdit;
    lFkDomains: TStaticText;
    eFkDomains: TComboBox;
    lDscTab: TStaticText;
    eDscTab: TEdit;
    shTitle: TShape;
    lTitle: TLabel;
    gbVigency: TGroupBox;
    lDtaIni: TStaticText;
    eDtaFin: TDateTimePicker;
    lDtaFin: TStaticText;
    eDtaIni: TDateTimePicker;
    gbTariffs: TGroupBox;
    lIniFractionalTax: TStaticText;
    eIniFractionalTax: TSpinEdit;
    eFractionalTax: TSpinEdit;
    lFractionalTax: TStaticText;
    lIniPaySec: TStaticText;
    eIniPaySec: TSpinEdit;
    eFlagDefault: TCheckBox;
    eFlagTab: TRadioGroup;
    tbSepNewTab: TToolButton;
    tbNewTab: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscTab: string;
    function  GetDtaFin: TDateTime;
    function  GetDtaIni: TDateTime;
    function  GetFkDomains: string;
    function  GetFlagDefault: Boolean;
    function  GetFlagTab: TTableType;
    function  GetFractionalTax: Integer;
    function  GetIniFractionalTax: Integer;
    function  GetIniPaySec: Integer;
    function  GetPkPriceTable: Integer;
    procedure SetDscTab(const Value: string);
    procedure SetDtaFin(const Value: TDateTime);
    procedure SetDtaIni(const Value: TDateTime);
    procedure SetFkDomains(const Value: string);
    procedure SetFlagDefault(const Value: Boolean);
    procedure SetFlagTab(const Value: TTableType);
    procedure SetFractionalTax(const Value: Integer);
    procedure SetGetIniFractionalTax(const Value: Integer);
    procedure SetIniPaySec(const Value: Integer);
    procedure SetPkPriceTable(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property pkPriceTable    : Integer    read GetPkPriceTable     write SetPkPriceTable;
    property fkDomains       : string     read GetFkDomains        write SetFkDomains;
    property dscTab          : string     read GetDscTab           write SetDscTab;
    property dtaIni          : TDateTime  read GetDtaIni           write SetDtaIni;
    property dtaFin          : TDateTime  read GetDtaFin           write SetDtaFin;
    property iniFractionalTax: Integer    read GetIniFractionalTax write SetGetIniFractionalTax;
    property fractionalTax   : Integer    read GetFractionalTax    write SetFractionalTax;
    property iniPaySec       : Integer    read GetIniPaySec        write SetIniPaySec;
    property flagDefault     : Boolean    read GetFlagDefault      write SetFlagDefault;
    property flagTab         : TTableType read GetFlagTab          write SetFlagTab;
  end;

var
  frmPriceTable: TfrmPriceTable;

implementation

uses MainData, GridRow, ProcType, SipArqSql, Funcoes;

{$R *.dfm}

{ TfrmPriceTable }

function TfrmPriceTable.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  C := nil;
  S := '';
  if (dscTab = '') then
  begin
    C := eDscTab;
    S := 'Campo Descrição da Tabela deve ser preenchido!';
  end;
  if ((S <> '') and (C <> nil)) then
  begin
    dmMain.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TfrmPriceTable.ClearControls;
begin
  pkPriceTable     := 0;
//  fkDomains        := '';
  dscTab           := '';
  dtaIni           := Date;
  dtaFin           := Date;
  iniFractionalTax := 60;
  fractionalTax    := 60;
  iniPaySec        := 3;
  flagDefault      := True;
  flagTab          := ttPre;
end;

function TfrmPriceTable.GetDscTab: string;
begin
  Result := eDscTab.Text;
end;

function TfrmPriceTable.GetDtaFin: TDateTime;
begin
  Result := eDtaFin.DateTime;
end;

function TfrmPriceTable.GetDtaIni: TDateTime;
begin
  Result := eDtaIni.DateTime;
end;

function TfrmPriceTable.GetFkDomains: string;
begin
  Result := '.';
  with eFkDomains do
  begin
    if (Items.Count = 0) then exit;
    if (ItemIndex = -1) then ItemIndex := 0;
    if (Items.Objects[ItemIndex] <> nil) then
      Result := PStr(Items.Objects[ItemIndex])^.S;
  end;
end;

function TfrmPriceTable.GetFlagDefault: Boolean;
begin
  Result := eFlagDefault.Checked;
end;

function TfrmPriceTable.GetFlagTab: TTableType;
begin
  Result := TTableType(eFlagTab.ItemIndex);
end;

function TfrmPriceTable.GetFractionalTax: Integer;
begin
  Result := eFractionalTax.Value;
end;

function TfrmPriceTable.GetIniFractionalTax: Integer;
begin
  Result := eIniFractionalTax.Value;
end;

function TfrmPriceTable.GetIniPaySec: Integer;
begin
  Result := eIniPaySec.Value;
end;

function TfrmPriceTable.GetPkPriceTable: Integer;
begin
  Result := Pk;
end;

procedure TfrmPriceTable.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFkDomains.Items.AddStrings(dmMain.GetDomains);
    ListLoaded := True;
  end;
end;

procedure TfrmPriceTable.LoadList;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  inherited;
  with dmMain, vtList do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlSelectPriceTable);
    dmMain.StartTransaction(qrSqlAux);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      RowModel := TDataRow.CreateFromDataSet(nil, qrSqlAux, False);
      while not qrSqlAux.Eof do
      begin
        Node := AddDataNode(nil, qrSqlAux);
        if (Node <> nil) then
        begin
          Data := GetNodeData(Node);
          if (Data <> nil) then
            Data^.NodeType := tnFolder;
        end;
        qrSqlAux.Next;
      end;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
      dmMain.CommitTransaction(qrSqlAux);
    end;
    if (RootNodeCount > 0) then
    begin
      FocusedNode := GetFirst;
      Selected[FocusedNode] := True;
      FullExpand;
    end;
    sbStatus.Panels[1].Text := 'Encontrado(s) ' + IntToStr(RootNodeCount) + ' registro(s)';
  end;
end;

procedure TfrmPriceTable.MoveDataToControls;
var
  Data: TDataRow;
begin
  Loading := True;
  try
    Data          := dmMain.Menus[Pk];
    pkPriceTable     := Data.FieldByName['pk_price_table'].AsInteger;
    //fkDomains        := Data.FieldByName['fk_domains'].AsString;
    dscTab           := Data.FieldByName['dsc_tab'].AsString;
    dtaIni           := Data.FieldByName['dta_ini'].AsDateTime;
    dtaFin           := Data.FieldByName['dta_fin'].AsDateTime;
    iniFractionalTax := Data.FieldByName['ini_fractional_tab'].AsInteger;
    fractionalTax    := Data.FieldByName['fractional_tab'].AsInteger;
    iniPaySec        := Data.FieldByName['ini_pay_sec'].AsInteger;
    flagDefault      := Boolean(Data.FieldByName['flag_default'].AsInteger);
    flagTab          := TTableType(Data.FieldByName['flag_tab'].AsInteger);
  finally
    Loading := False;
  end;
end;

procedure TfrmPriceTable.SaveIntoDB;
var
  Data: TDataRow;
  aPtr: PGridData;
begin
  Loading := True;
  try
    Data := dmMain.Menus[0];
    Data.FieldByName['pk_price_table'].AsInteger     := pkPriceTable;
    //Data.FieldByName['fk_domains'].AsString          := fkDomains;
    Data.FieldByName['dsc_tab'].AsString             := dscTab;
    Data.FieldByName['dta_ini'].AsDateTime           := dtaIni;
    Data.FieldByName['dta_fin'].AsDateTime           := dtaFin;
    Data.FieldByName['ini_fractional_tab'].AsInteger := iniFractionalTax;
    Data.FieldByName['fractional_tab'].AsInteger     := fractionalTax;
    Data.FieldByName['ini_pay_sec'].AsInteger        := iniPaySec;
    Data.FieldByName['flag_default'].AsInteger       := Ord(flagDefault);
    Data.FieldByName['flag_tab'].AsInteger           := Ord(flagTab);
    dmMain.Menus[Ord(ScrState)] := Data;
    if (vtList.FocusedNode <> nil) then
    begin
      aPtr := vtList.GetNodeData(vtList.FocusedNode);
      if (aPtr <> nil) and (aPtr^.DataRow <> nil) then
      begin
        aPtr^.DataRow.FieldByName['pk_price_table'].AsInteger := Data.FieldByName['pk_price_table'].AsInteger;
        aPtr^.DataRow.FieldByName['dsc_tab'].AsString  := dscTab;
      end;
    end;
    Pk := Data.FieldByName['pk_price_table'].AsInteger;
  finally
    Loading := False;
    FreeAndNil(Data);
  end;
end;

procedure TfrmPriceTable.SetDscTab(const Value: string);
begin
  eDscTab.Text := Value;
end;

procedure TfrmPriceTable.SetDtaFin(const Value: TDateTime);
begin
  eDtaFin.DateTime := Value;
end;

procedure TfrmPriceTable.SetDtaIni(const Value: TDateTime);
begin
  eDtaIni.DateTime := Value;
end;

procedure TfrmPriceTable.SetFkDomains(const Value: string);
var
  i: Integer;
begin
  with eFkDomains do
  begin
    if (Items.Count = 0) then exit;
    ItemIndex := 0;
    for i := 0 to Items.Count - 1 do
      if ((Items.Objects[i] <> nil) and (PStr(Items.Objects[i])^.S = Value)) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TfrmPriceTable.SetFlagDefault(const Value: Boolean);
begin
  eFlagDefault.Checked := Value;
end;

procedure TfrmPriceTable.SetFlagTab(const Value: TTableType);
begin
  eFlagTab.ItemIndex := Ord(Value);
end;

procedure TfrmPriceTable.SetFractionalTax(const Value: Integer);
begin
  eFractionalTax.Value := Value;
end;

procedure TfrmPriceTable.SetGetIniFractionalTax(const Value: Integer);
begin
  eIniFractionalTax.Value := Value;
end;

procedure TfrmPriceTable.SetIniPaySec(const Value: Integer);
begin
  eIniPaySec.Value := Value;
end;

procedure TfrmPriceTable.SetPkPriceTable(const Value: Integer);
begin
  ePkPriceTable.Value := Pk;
end;

procedure TfrmPriceTable.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

procedure TfrmPriceTable.FormDestroy(Sender: TObject);
begin
  ReleaseCombos(eFkDomains, toRecord);
  inherited;
end;

initialization
  Classes.RegisterClass(TfrmPriceTable);

end.
