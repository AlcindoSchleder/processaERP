unit CadStt;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 18/04/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
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
  Dialogs, VirtualTrees, StdCtrls, Mask, ToolEdit, CurrEdit, TSysPedAux,
  ProcUtils, ExtCtrls, CadModel;

type
  TCdTipoStatus = class(TfrmModel)
    gbParams: TGroupBox;
    lFlagOpen: TCheckBox;
    lFlagRecb: TCheckBox;
    lFlagLib: TCheckBox;
    lFlagCanc: TCheckBox;
    lFlagProd: TCheckBox;
    lFlagFat: TCheckBox;
    lFlagLiq: TCheckBox;
    eFk_Tipo_Movim_Estq: TComboBox;
    lFk_Tipo_Movim_Estq: TStaticText;
    eDsc_Stt: TEdit;
    lDsc_Stt: TStaticText;
    lPk_Tipo_Status_Pedidos: TStaticText;
    ePk_Tipo_Status_Pedidos: TCurrencyEdit;
    lQtd_Days_Next: TStaticText;
    eQtd_Days_Next: TCurrencyEdit;
    pTitle: TPanel;
    lFk_Tipo_Documentos: TStaticText;
    eFk_Tipo_Documentos: TComboBox;
    lFk_Financeiro_Cenarios: TStaticText;
    eFk_Financeiro_Cenarios: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FFkGroupMovim: Integer;
    FDscGmov: string;
    FFlagES: TInOut;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscStt: string;
    function  GetFkTypeMovEstq: Integer;
    function  GetFkTypeDocument: Integer;
    function  GetFlagCanc: Boolean;
    function  GetFlagFat: Boolean;
    function  GetFlagLib: Boolean;
    function  GetFlagLiq: Boolean;
    function  GetFlagOpen: Boolean;
    function  GetFlagProd: Boolean;
    function  GetFlagRecb: Boolean;
    function  GetPkTypeStatus: Integer;
    function  GetQtdDaysNext: Integer;
    procedure SetDscGmov(const Value: string);
    procedure SetDscStt(const Value: string);
    procedure SetFkGroupMovim(const Value: Integer);
    procedure SetFkTypeMovEstq(const Value: Integer);
    procedure SetFkTypeDocument(const Value: Integer);
    procedure SetFlagCanc(const Value: Boolean);
    procedure SetFlagES(const Value: TInOut);
    procedure SetFlagFat(const Value: Boolean);
    procedure SetFlagLib(const Value: Boolean);
    procedure SetFlagLiq(const Value: Boolean);
    procedure SetFlagOpen(const Value: Boolean);
    procedure SetFlagProd(const Value: Boolean);
    procedure SetFlagRecb(const Value: Boolean);
    procedure SetPkTypeStatus(const Value: Integer);
    procedure SetQtdDaysNext(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  FkGroupMovim  : Integer    read FFkGroupMovim     write SetFkGroupMovim;
    property  DscGmov       : string     read FDscGmov          write SetDscGmov;
    property  FlagES        : TInOut     read FFlagES           write SetFlagES;
    property  PkTypeStatus  : Integer    read GetPkTypeStatus   write SetPkTypeStatus;
    property  FkTypeMovEstq : Integer    read GetFkTypeMovEstq  write SetFkTypeMovEstq;
    property  FkTypeDocument: Integer    read GetFkTypeDocument write SetFkTypeDocument;
    property  DscStt        : string     read GetDscStt         write SetDscStt;
    property  QtdDaysNext   : Integer    read GetQtdDaysNext    write SetQtdDaysNext;
    property  FlagOpen      : Boolean    read GetFlagOpen       write SetFlagOpen;
    property  FlagRecb      : Boolean    read GetFlagRecb       write SetFlagRecb;
    property  FlagLib       : Boolean    read GetFlagLib        write SetFlagLib;
    property  FlagCanc      : Boolean    read GetFlagCanc       write SetFlagCanc;
    property  FlagProd      : Boolean    read GetFlagProd       write SetFlagProd;
    property  FlagFat       : Boolean    read GetFlagFat        write SetFlagFat;
    property  FlagLiq       : Boolean    read GetFlagLiq        write SetFlagLiq;
  end;

var
  CdTipoStatus: TCdTipoStatus;

implementation

uses Dado, mSysPed, GridRow, DB, Funcoes, TSysMan;

{$R *.dfm}

const
  IN_DOCUMENTS : set of TOrderType = [otPurchaseOrder, otAssistance];
  OUT_DOCUMENTS: set of TOrderType =
    [otBudget, otRepresentant, otExportation, otBranch, otInternet];
  IN_OUT       : array [TInOut] of string = ('Entradas', 'Saídas');

function TCdTipoStatus.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  S := '';
  C := nil;
  Result := True;
  if (DscStt = '') then
  begin
    S := 'Campo Descrição deve ser preenchido';
    C := eDsc_Stt;
  end;
  if (not FlagOpen) and (not FlagRecb) and (not FlagLib) and (not FlagCanc) and
     (not FlagProd) and (not FlagFat) and (not FlagLiq) then
  begin
    S := 'Status deve conter uma função';
    C := gbParams;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTipoStatus.ClearControls;
begin
  Loading := True;
  try
    PkTypeStatus   := 0;
    FkTypeMovEstq  := 0;
    DscStt         := '';
    QtdDaysNext    := 0;
    FlagOpen       := False;
    FlagRecb       := False;
    FlagLib        := False;
    FlagCanc       := False;
    FlagProd       := False;
    FlagFat        := False;
    FlagLiq        := False;
    FkTypeDocument := 0;
  finally
    Loading := False;
  end;
end;

function TCdTipoStatus.GetDscStt: string;
begin
  Result := eDsc_Stt.Text;
end;

function TCdTipoStatus.GetFkTypeMovEstq: Integer;
begin
  Result := 0;
  with eFk_Tipo_Movim_Estq do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdTipoStatus.GetFkTypeDocument: Integer;
begin
  Result := 0;
  with eFk_Tipo_Documentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdTipoStatus.GetFlagCanc: Boolean;
begin
  Result := lFlagCanc.Checked;
end;

function TCdTipoStatus.GetFlagFat: Boolean;
begin
  Result := lFlagFat.Checked;
end;

function TCdTipoStatus.GetFlagLib: Boolean;
begin
  Result := lFlagLib.Checked;
end;

function TCdTipoStatus.GetFlagLiq: Boolean;
begin
  Result := lFlagLiq.Checked;
end;

function TCdTipoStatus.GetFlagOpen: Boolean;
begin
  Result := lFlagOpen.Checked;
end;

function TCdTipoStatus.GetFlagProd: Boolean;
begin
  Result := lFlagProd.Checked;
end;

function TCdTipoStatus.GetFlagRecb: Boolean;
begin
  Result := lFlagRecb.Checked;
end;

function TCdTipoStatus.GetPkTypeStatus: Integer;
begin
  Result := ePk_Tipo_Status_Pedidos.AsInteger;
end;

function TCdTipoStatus.GetQtdDaysNext: Integer;
begin
  Result := eQtd_Days_Next.AsInteger;
end;

procedure TCdTipoStatus.LoadDefaults;
begin
  ReleaseCombos(eFk_Tipo_Documentos, toObject);
  eFk_Tipo_Documentos.Items.AddStrings(dmSysPed.LoadTypeDocuments(dtPedido));
end;

procedure TCdTipoStatus.MoveDataToControls;
var
  aItem: TDataRow;
begin
  Loading := True;
  try
    aItem          := dmSysPed.TypeStatusOrd[Pk];
    PkTypeStatus   := aItem.FieldByName['PK_TIPO_STATUS_PEDIDOS'].AsInteger;
    FkTypeMovEstq  := aItem.FieldByName['FK_TIPO_MOVIM_ESTQ'].AsInteger;
    DscStt         := aItem.FieldByName['DSC_STT'].AsString;
    QtdDaysNext    := aItem.FieldByName['QTD_DAYS_NEXT'].AsInteger;
    FlagOpen       := Boolean(aItem.FieldByName['FLAG_OPEN'].AsInteger);
    FlagRecb       := Boolean(aItem.FieldByName['FLAG_RECB'].AsInteger);
    FlagLib        := Boolean(aItem.FieldByName['FLAG_LIB'].AsInteger);
    FlagCanc       := Boolean(aItem.FieldByName['FLAG_CANC'].AsInteger);
    FlagProd       := Boolean(aItem.FieldByName['FLAG_PROD'].AsInteger);
    FlagFat        := Boolean(aItem.FieldByName['FLAG_FAT'].AsInteger);
    FlagLiq        := Boolean(aItem.FieldByName['FLAG_LIQ'].AsInteger);
    FkTypeDocument := aItem.FieldByName['FK_TIPO_DOCUMENTOS'].AsInteger;
  finally
    FreeAndNil(aItem);
    Loading := False;
  end;
end;

procedure TCdTipoStatus.SaveIntoDB;
var
  aItem: TDataRow;
  aRow : TDataRow;
begin
  aItem := TDataRow.Create(Self);
  aRow  := TDataRow.Create(Self);
  try
    aItem.AddAs('PK_TIPO_STATUS_PEDIDOS', PkTypeStatus, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_TIPO_MOVIM_ESTQ', FkTypeMovEstq, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_TIPO_DOCUMENTOS', FkTypeDocument, ftInteger, SizeOf(Integer));
    aItem.AddAs('DSC_STT', DscStt, ftString, 31);
    aItem.AddAs('QTD_DAYS_NEXT', QtdDaysNext, ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_OPEN', Ord(FlagOpen), ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_RECB', Ord(FlagRecb), ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_LIB', Ord(FlagLib), ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_LIQ', Ord(FlagLiq), ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_CANC', Ord(FlagCanc), ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_PROD', Ord(FlagProd), ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_FAT', Ord(FlagFat), ftInteger, SizeOf(Integer));
    dmSysPed.TypeStatusOrd[Ord(ScrState)] := aItem;
    aRow.AddAs('PK', aItem.FieldByName['PK_TIPO_STATUS_PEDIDOS'].AsInteger,
      ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', aItem.FieldByName['DSC_STT'].AsString, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := aItem.FieldByName['PK_TIPO_STATUS_PEDIDOS'].AsInteger;
  finally
    FreeAndNil(aItem);
    FreeAndNil(aRow);
  end;
end;

procedure TCdTipoStatus.SetDscGmov(const Value: string);
begin
  FDscGmov := Value;
  pTitle.Caption := 'Tipo de Status';
  if (FDscGmov <> '') then
    pTitle.Caption := pTitle.Caption + ' - ' + DscGMov;
end;

procedure TCdTipoStatus.SetDscStt(const Value: string);
begin
  eDsc_Stt.Text := Value;
end;

procedure TCdTipoStatus.SetFkGroupMovim(const Value: Integer);
begin
  FFkGroupMovim := Value;
  dmSysPed.PkGroupMoviment := Value;
end;

procedure TCdTipoStatus.SetFkTypeMovEstq(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Movim_Estq do
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

procedure TCdTipoStatus.SetFkTypeDocument(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Documentos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (TTypeDocument(Items.Objects[i]).PkTypeDocument = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTipoStatus.SetFlagCanc(const Value: Boolean);
begin
  lFlagCanc.Checked := Value;
end;

procedure TCdTipoStatus.SetFlagES(const Value: TInOut);
begin
  Loading := True;
  try
    if (FFlagES <> Value) or (eFk_Tipo_Movim_Estq.Items.Count = 0) then
    begin
      FFlagEs := Value;
      ReleaseCombos(eFk_Tipo_Movim_Estq, toInteger);
      eFk_Tipo_Movim_Estq.Items.AddStrings(dmSysPed.LoadMovimentEstq(FlagES));
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdTipoStatus.SetFlagFat(const Value: Boolean);
begin
  lFlagFat.Checked := Value;
end;

procedure TCdTipoStatus.SetFlagLib(const Value: Boolean);
begin
  lFlagLib.Checked := Value;
end;

procedure TCdTipoStatus.SetFlagLiq(const Value: Boolean);
begin
  lFlagLiq.Checked := Value;
end;

procedure TCdTipoStatus.SetFlagOpen(const Value: Boolean);
begin
  lFlagOpen.Checked := Value;
end;

procedure TCdTipoStatus.SetFlagProd(const Value: Boolean);
begin
  lFlagProd.Checked := Value;
end;

procedure TCdTipoStatus.SetFlagRecb(const Value: Boolean);
begin
  lFlagRecb.Checked := Value;
end;

procedure TCdTipoStatus.SetPkTypeStatus(const Value: Integer);
begin
  ePk_Tipo_Status_Pedidos.AsInteger := Value;
end;

procedure TCdTipoStatus.SetQtdDaysNext(const Value: Integer);
begin
  eQtd_Days_Next.AsInteger := Value;
end;

procedure TCdTipoStatus.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

procedure TCdTipoStatus.FormDestroy(Sender: TObject);
begin
  ReleaseCombos(eFk_Tipo_Movim_Estq, toInteger);
  ReleaseCombos(eFk_Tipo_Documentos, toInteger);
  ReleaseCombos(eFk_Financeiro_Cenarios, toInteger);
end;

end.
