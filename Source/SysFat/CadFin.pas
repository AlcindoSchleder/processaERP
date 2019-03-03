unit CadFin;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 06/03/2003 - DD/MM/YYYY                                    *}
{* Modified :            - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
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
  Dialogs, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, Menus, VirtualTrees,
  ComCtrls, ToolWin, PrcCombo, ProcUtils, TSysPedAux, ImgList, CadListModel;

type
  TTypeFinalizations = set of TTypeFinalization;

  TCdFinalizadoras = class(TfrmModelList)
    lPk_Finalizadoras: TStaticText;
    eCod_Tecla: THotKey;
    lCod_Tecla: TStaticText;
    lDsc_MPgt: TStaticText;
    eDsc_MPgt: TEdit;
    lFlag_TFin: TRadioGroup;
    gbParamsFin: TGroupBox;
    lFlag_Cli: TCheckBox;
    lFlag_Bnc: TCheckBox;
    lFlag_Trc: TCheckBox;
    lFlag_Tef: TCheckBox;
    gbParamsOp: TGroupBox;
    lFlag_GSld_Cta: TCheckBox;
    lFlag_Est: TCheckBox;
    lFlag_Trf: TCheckBox;
    lFlag_Baixa: TCheckBox;
    lFk_Finalizadoras__DB: TStaticText;
    eFk_Finalizadoras__DB: TPrcComboBox;
    eFk_Finalizadoras__CR: TPrcComboBox;
    lFk_Finalizadoras__CR: TStaticText;
    ePk_Finalizadoras: TCurrencyEdit;
    lFlag_GSld_Fin: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure lFlag_TFinClick(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure lFlag_TrfClick(Sender: TObject);
  private
    { Private declarations }
    function CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function GetFlagCli: Boolean;
    function GetDscMpgt: string;
    function GetFkFinishCR: Integer;
    function GetFkFinishDB: Integer;
    function GetFlagBaixa: Boolean;
    function GetFlagBnc: Boolean;
    function GetFlagEst: Boolean;
    function GetFlagGSldCta: Boolean;
    function GetFlagTef: Boolean;
    function GetFlagTFin: TTypeFinalization;
    function GetFlagTrc: Boolean;
    function GetFlagTrf: Boolean;
    function GetKeyCode: Word;
    function GetPkFinish: Integer;
    procedure SetDscMpgt(const Value: string);
    procedure SetFkFinishCR(const Value: Integer);
    procedure SetFkFinishDB(const Value: Integer);
    procedure SetFlagBaixa(const Value: Boolean);
    procedure SetFlagBnc(const Value: Boolean);
    procedure SetFlagCli(const Value: Boolean);
    procedure SetFlagEst(const Value: Boolean);
    procedure SetFlagGSldCta(const Value: Boolean);
    procedure SetFlagTef(const Value: Boolean);
    procedure SetFlagTFin(const Value: TTypeFinalization);
    procedure SetFlagTrc(const Value: Boolean);
    procedure SetFlagTrf(const Value: Boolean);
    procedure SetKeyCode(const Value: Word);
    procedure SetPkFinish(const Value: Integer);
    function GetFlagGSldFin: Boolean;
    procedure SetFlagGSldFin(const Value: Boolean);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  DscMpgt    : string            read GetDscMpgt     write SetDscMpgt;
    property  FkFinishDB : Integer           read GetFkFinishDB  write SetFkFinishDB;
    property  FkFinishCR : Integer           read GetFkFinishCR  write SetFkFinishCR;
    property  FlagBaixa  : Boolean           read GetFlagBaixa   write SetFlagBaixa;
    property  FlagBnc    : Boolean           read GetFlagBnc     write SetFlagBnc;
    property  FlagCli    : Boolean           read GetFlagCli     write SetFlagCli;
    property  FlagEst    : Boolean           read GetFlagEst     write SetFlagEst;
    property  FlagGSldCta: Boolean           read GetFlagGSldCta write SetFlagGSldCta;
    property  FlagGSldFin: Boolean           read GetFlagGSldFin write SetFlagGSldFin;
    property  FlagTef    : Boolean           read GetFlagTef     write SetFlagTef;
    property  FlagTFin   : TTypeFinalization read GetFlagTFin    write SetFlagTFin;
    property  FlagTrc    : Boolean           read GetFlagTrc     write SetFlagTrc;
    property  FlagTrf    : Boolean           read GetFlagTrf     write SetFlagTrf;
    property  KeyCode    : Word              read GetKeyCode     write SetKeyCode;
    property  PkFinish   : Integer           read GetPkFinish    write SetPkFinish;
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysFat, GridRow, ProcType, ArqSqlFat, DB;

{$R *.dfm}

function  TCdFinalizadoras.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S      := '';
  C      := nil;
  if (DscMpgt = '') then
  begin
    S := 'Campo Descrição deve ser preenchido!';
    C := eDsc_MPgt;
  end;
  if (FlagTFin < fnOperation) and (KeyCode = 0) then
  begin
    S := 'Campo Código da Tecla deve ser preenchido!';
    C := eCod_Tecla;
  end;
  if (KeyCode > 0) and (dmSysFat.GetFinishKeyFromDB(Pk, KeyCode, FlagTFin)) then
  begin
    S := 'Código de tecla informado já utilizado para este tipo de Finalizadora!';
    C := eCod_Tecla;
  end;
  if (FlagTFin = fnOperation) and (FlagTrf) and
     ((FkFinishDB = 0) or (FkFinishCR = 0)) then
  begin
    S := 'Campo Operações de Débito/Crédito devem ser preenchidos para ' + NL +
         'operações de Transferências';
    if (FkFinishDB = 0) then
      C := eFk_Finalizadoras__DB
    else
      C := eFk_Finalizadoras__CR;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdFinalizadoras.ClearControls;
begin
  Loading := True;
  try
    DscMpgt     := '';
    FkFinishDB  := 0;
    FkFinishCR  := 0;
    FlagBaixa   := False;
    FlagBnc     := False;
    FlagCli     := False;
    FlagEst     := False;
    FlagGSldCta := True;
    FlagGSldFin := True;
    FlagTef     := False;
    FlagTFin    := fnMoney;
    FlagTrc     := True;
    FlagTrf     := False;
    KeyCode     := 0;
    PkFinish    := 0;
  finally
    Loading := False;
  end;
end;

procedure TCdFinalizadoras.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

function TCdFinalizadoras.GetFlagCli: Boolean;
begin
  Result := lFLag_Cli.Checked;
end;

function TCdFinalizadoras.GetDscMpgt: string;
begin
  Result := eDsc_MPgt.Text;
end;

function TCdFinalizadoras.GetFkFinishCR: Integer;
begin
  Result := 0;
  with eFk_Finalizadoras__CR do
  begin
    if (not Enabled) then exit;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdFinalizadoras.GetFkFinishDB: Integer;
begin
  Result := 0;
  with eFk_Finalizadoras__DB do
  begin
    if (not Enabled) then exit;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdFinalizadoras.GetFlagBaixa: Boolean;
begin
  Result := lFlag_Baixa.Checked;
end;

function TCdFinalizadoras.GetFlagBnc: Boolean;
begin
  Result := lFlag_Bnc.Checked;
end;

function TCdFinalizadoras.GetFlagEst: Boolean;
begin
  Result := lFlag_Est.Checked;
end;

function TCdFinalizadoras.GetFlagGSldCta: Boolean;
begin
  Result := lFlag_GSld_Cta.Checked;
end;

function TCdFinalizadoras.GetFlagTef: Boolean;
begin
  Result := lFlag_Tef.Checked;
end;

function TCdFinalizadoras.GetFlagTFin: TTypeFinalization;
begin
  Result := TTypeFinalization(lFlag_TFin.ItemIndex);
end;

function TCdFinalizadoras.GetFlagTrc: Boolean;
begin
  Result := lFlag_Trc.Checked;
end;

function TCdFinalizadoras.GetFlagTrf: Boolean;
begin
  Result := lFlag_TrF.Checked;
end;

function TCdFinalizadoras.GetKeyCode: Word;
begin
  Result := eCod_Tecla.HotKey;
end;

function TCdFinalizadoras.GetPkFinish: Integer;
begin
  Result := StrToIntDef(ePk_Finalizadoras.Text, 0);
end;

procedure TCdFinalizadoras.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Finalizadoras__CR.Items.AddStrings(dmSysFat.LoadFinalizers(fnOperation));
    eFk_Finalizadoras__DB.Items.AddStrings(dmSysFat.LoadFinalizers(fnOperation));
  end;
end;

procedure TCdFinalizadoras.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysFat, vtList do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Add(SqlFinalizers);
    Dados.StartTransaction(qrSqlAux);
    BeginUpdate;
    try
      qrSqlAux.ParamByName('FlagTFin').AsInteger := -1;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        AddDataNode(nil, qrSqlAux);
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
      EndUpdate;
    end;
    if (RootNodeCount > 0) then
    begin
      FocusedNode           := GetFirst;
      Selected[FocusedNode] := True;
    end;
  end;
end;

procedure TCdFinalizadoras.MoveDataToControls;
var
  Data: TDataRow;
begin
  Loading       := True;
  Data          := dmSysFat.Finalizations[Pk];
  try
    DscMpgt     := Data.FieldByName['DSC_MPGT'].AsString;
    FkFinishDB  := Data.FieldByName['FK_FINALIZADORAS__DB'].AsInteger;
    FkFinishCR  := Data.FieldByName['FK_FINALIZADORAS__CR'].AsInteger;
    FlagBaixa   := Boolean(Data.FieldByName['FLAG_BAIXA'].AsInteger);
    FlagBnc     := Boolean(Data.FieldByName['FLAG_BNC'].AsInteger);
    FlagCli     := Boolean(Data.FieldByName['FLAG_CLI'].AsInteger);
    FlagEst     := Boolean(Data.FieldByName['FLAG_EST'].AsInteger);
    FlagGSldCta := Boolean(Data.FieldByName['FLAG_GSLD_CTA'].AsInteger);
    FlagGSldFin := Boolean(Data.FieldByName['FLAG_GSLD_FIN'].AsInteger);
    FlagTef     := Boolean(Data.FieldByName['FLAG_TEF'].AsInteger);
    FlagTFin    := TTypeFinalization(Data.FieldByName['FLAG_TFIN'].AsInteger);
    FlagTrc     := Boolean(Data.FieldByName['FLAG_TRC'].AsInteger);
    FlagTrf     := Boolean(Data.FieldByName['FLAG_TRF'].AsInteger);
    KeyCode     := Data.FieldByName['COD_TECLA'].AsInteger;
    PkFinish    := Pk;
  finally
    Loading    := False;
    FreeAndNil(Data);
  end;
end;

procedure TCdFinalizadoras.SaveIntoDB;
var
  Data: TDataRow;
  APk : Integer;
  ADt : PGridData;
begin
  Data       := TDataRow.Create(nil);
  try
    Data.AddAs('DSC_MPGT', DscMpgt, ftString, 31);
    Data.AddAs('PK_FINALIZADORAS', PkFinish, ftInteger, SizeOf(Integer));
    Data.AddAs('FK_FINALIZADORAS__DB', FkFinishDB, ftInteger, SizeOf(Integer));
    Data.AddAs('FK_FINALIZADORAS__CR', FkFinishCR, ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_BAIXA', Ord(FlagBaixa), ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_BNC', Ord(FlagBnc), ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_CLI', Ord(FlagCli), ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_EST', Ord(FlagEst), ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_GSLD_CTA', Ord(FlagGSldCta), ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_GSLD_FIN', Ord(FlagGSldFin), ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_TEF', Ord(FlagTef), ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_TFIN', Ord(FlagTFin), ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_TRC', Ord(FlagTrc), ftInteger, SizeOf(Integer));
    Data.AddAs('FLAG_TRF', Ord(FlagTrf), ftInteger, SizeOf(Integer));
    Data.AddAs('COD_TECLA', KeyCode, ftInteger, SizeOf(Integer));
    dmSysFat.Finalizations[Ord(ScrState)] := Data;
    APk := Data.FieldByName['PK_FINALIZADORAS'].AsInteger;
    with vtList do
    begin
      if (FocusedNode <> nil) then
      begin
        ADt := GetNodeData(FocusedNode);
        if (ADt <> nil) and (ADt.DataRow <> nil) then
        begin
          ADt.DataRow.FieldByName['PK_FINALIZADORAS'].AsInteger := APk;
          ADt.DataRow.FieldByName['DSC_MPGT'].AsString          :=
            Data.FieldByName['DSC_MPGT'].AsString;
          ADt.DataRow.FieldByName['FLAG_TFIN'].AsInteger        :=
            Data.FieldByName['FLAG_TFIN'].AsInteger
        end;
      end;
    end;
  finally
    FreeAndNil(Data);
  end;
  Pk := APk;
end;

procedure TCdFinalizadoras.SetDscMpgt(const Value: string);
begin
  eDsc_MPgt.Text := Value;
end;

procedure TCdFinalizadoras.SetFkFinishCR(const Value: Integer);
begin
  with eFk_Finalizadoras__CR do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromIntegerValue(Value);
  end;
end;

procedure TCdFinalizadoras.SetFkFinishDB(const Value: Integer);
begin
  with eFk_Finalizadoras__DB do
  begin
    ItemIndex := -1;
    if (Value > 0) then SetIndexFromIntegerValue(Value);
  end;
end;

procedure TCdFinalizadoras.SetFlagBaixa(const Value: Boolean);
begin
  lFlag_Baixa.Checked := Value;
end;

procedure TCdFinalizadoras.SetFlagBnc(const Value: Boolean);
begin
  lFlag_Bnc.Checked := Value;
end;

procedure TCdFinalizadoras.SetFlagCli(const Value: Boolean);
begin
  lFlag_Cli.Checked := Value;
end;

procedure TCdFinalizadoras.SetFlagEst(const Value: Boolean);
begin
  lFlag_Est.Checked := Value;
end;

procedure TCdFinalizadoras.SetFlagGSldCta(const Value: Boolean);
begin
  lFlag_GSld_Cta.Checked := Value;
end;

procedure TCdFinalizadoras.SetFlagTef(const Value: Boolean);
begin
  lFlag_Tef.Checked := Value;
end;

procedure TCdFinalizadoras.SetFlagTFin(const Value: TTypeFinalization);
begin
  lFlag_TFin.ItemIndex := Ord(Value);
end;

procedure TCdFinalizadoras.SetFlagTrc(const Value: Boolean);
begin
  lFlag_Trc.Checked := Value;
end;

procedure TCdFinalizadoras.SetFlagTrf(const Value: Boolean);
begin
  lFlag_Trf.Checked := Value;
end;

procedure TCdFinalizadoras.SetKeyCode(const Value: Word);
begin
  eCod_Tecla.HotKey := Value;
end;

procedure TCdFinalizadoras.SetPkFinish(const Value: Integer);
begin
 ePk_Finalizadoras.Text := IntToStr(Value);
end;

procedure TCdFinalizadoras.lFlag_TFinClick(Sender: TObject);
const
//  fnMoney, fnCheck, fnPreCheck, fnCreditCard, fnDebitCard, fnBankCash, fnBoleto,
//  fnInFuture, fnOperation
  RET_MONEY : TTypeFinalizations = [fnMoney, fnCheck, fnPreCheck, fnCreditCard];
  TEF_FINISH: TTypeFinalizations = [fnCheck, fnPreCheck, fnCreditCard, fnDebitCard];
begin
  ChangeGlobal(Sender);
  if (FlagTFin = fnOperation) then
  begin
    lFlag_Trf.Enabled               := True;
    lFk_Finalizadoras__CR.Visible   := True;
    eFk_Finalizadoras__CR.Visible   := True;
    lFk_Finalizadoras__DB.Visible   := True;
    eFk_Finalizadoras__DB.Visible   := True;
    eFk_Finalizadoras__CR.Enabled   := FlagTrf;
    eFk_Finalizadoras__DB.Enabled   := FlagTrf;
    lFlag_Baixa.Enabled             := True;
    lFlag_Est.Enabled               := True;
    lFlag_Trc.Enabled               := False;
    lFlag_Trc.Checked               := False;
    lFlag_Tef.Enabled               := False;
    lFlag_Tef.Checked               := False;
  end
  else
  begin
    lFk_Finalizadoras__CR.Visible   := False;
    eFk_Finalizadoras__CR.Visible   := False;
    eFk_Finalizadoras__CR.ItemIndex := -1;
    lFk_Finalizadoras__DB.Visible   := False;
    eFk_Finalizadoras__DB.Visible   := False;
    eFk_Finalizadoras__DB.ItemIndex := -1;
    lFlag_Baixa.Enabled             := False;
    lFlag_Baixa.Checked             := False;
    lFlag_Trf.Enabled               := False;
    lFlag_Trf.Checked               := False;
    lFlag_Est.Enabled               := False;
    lFlag_Est.Checked               := False;
    lFlag_Trc.Enabled               := (FlagTFin in RET_MONEY);
    lFlag_Tef.Enabled               := (FlagTFin in TEF_FINISH);
  end;
end;

procedure TCdFinalizadoras.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['PK_FINALIZADORAS'].AsString + '/' +
              Data^.DataRow.FieldByName['DSC_MPGT'].AsString
end;

procedure TCdFinalizadoras.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
var
  Data: PGridData;
begin
  inherited;
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  with Data^.DataRow do
  begin
    if (TTypeFinalization(FieldByName['FLAG_TFIN'].AsInteger) = fnOperation) then
      if  (Kind = ikSelected) then
        if (ScrState in UPDATE_MODE) then
          ImageIndex := 0
        else
          ImageIndex := 18
      else
        if (Kind = ikNormal) then
          ImageIndex := 18;
  end;
end;

procedure TCdFinalizadoras.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_FINALIZADORAS'].AsInteger;
end;

procedure TCdFinalizadoras.lFlag_TrfClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (FlagTFin = fnOperation) then
  begin
    eFk_Finalizadoras__CR.Enabled := FlagTrf;
    eFk_Finalizadoras__DB.Enabled := FlagTrf;
  end;
end;

function TCdFinalizadoras.GetFlagGSldFin: Boolean;
begin
  Result := lFlag_GSld_Fin.Checked;
end;

procedure TCdFinalizadoras.SetFlagGSldFin(const Value: Boolean);
begin
  lFlag_GSld_Fin.Checked := Value;
end;

initialization
  RegisterClass(TCdFinalizadoras);

end.
