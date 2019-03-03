unit CadManifest;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created  : 14/02/2007                                                 *}
{* Modified :                                                            *}
{* Version  : 1.2.0.0                                                    *}
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
  Dialogs, ExtCtrls, VirtualTrees, StdCtrls, ComCtrls, Mask, ToolEdit, CurrEdit,
  ProcUtils, TSysCadAux, TSysTrans, mSysTrans, PrcCombo, Buttons, TSysCad,
  TSysEstq, ToolWin, Menus, CadModel;

type
  TTypeLocale = (toCountry, toState, toCity);

  TCdManifest = class(TfrmModel)
    gbVehicle: TGroupBox;
    lFk_Veiculos_Marcas: TStaticText;
    eFk_Veiculos_Marcas: TComboBox;
    gbManifest: TGroupBox;
    lFk_Veiculos_Modelos: TStaticText;
    eFk_Veiculos_Modelos: TComboBox;
    lFk_Veiculos: TStaticText;
    eFk_Veiculos: TComboBox;
    gbEmployee: TGroupBox;
    lFk_Motorista: TStaticText;
    eFk_Motorista: TComboBox;
    lFk_Carregadores: TStaticText;
    eFk_Carregadores: TComboBox;
    lFk_Conferente: TStaticText;
    eFk_Conferente: TComboBox;
    gbManifestDetail: TGroupBox;
    gbFilterDocuments: TGroupBox;
    lFlag_Tot: TCheckBox;
    lTot_Cnh: TStaticText;
    eTot_Cnh: TCurrencyEdit;
    lTot_Pdg: TStaticText;
    eTot_Pdg: TCurrencyEdit;
    lTot_Mrc: TStaticText;
    eTot_Mrc: TCurrencyEdit;
    lVlr_Frt_Vst: TStaticText;
    eVlr_Frt_Vst: TCurrencyEdit;
    lVlr_Remb: TStaticText;
    eTot_Remb: TCurrencyEdit;
    bbGenerateDocuments: TBitBtn;
    pFilter: TPanel;
    vtDocuments: TVirtualStringTree;
    lNumDoc: TStaticText;
    eNumDoc: TCurrencyEdit;
    lNumNF: TStaticText;
    eNumNF: TCurrencyEdit;
    eDtaIni: TDateEdit;
    lDtaIni: TStaticText;
    lDtaFin: TStaticText;
    eDtaFin: TDateEdit;
    bbSearch: TBitBtn;
    ePk_Manifestos: TEdit;
    lPk_Manifestos: TStaticText;
    lDta_Sai: TStaticText;
    lFk_Tipo_Manifestos: TStaticText;
    eFk_Tipo_Manifestos: TComboBox;
    lFk_Parceiros: TStaticText;
    eFk_Parceiros: TComboBox;
    eDta_Sai: TDateEdit;
    eHor_Sai: TDateTimePicker;
    pmGrid: TPopupMenu;
    pmDeleteDoc: TMenuItem;
    pmClearrAllDocs: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure vtDocumentsGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtDocumentsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtDocumentsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtDocumentsBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtDocumentsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure eFk_Tipo_ManifestosSelect(Sender: TObject);
    procedure eFk_Veiculos_MarcasSelect(Sender: TObject);
    procedure eFk_Veiculos_ModelosSelect(Sender: TObject);
    procedure eFk_VeiculosSelect(Sender: TObject);
    procedure pmDeleteDocClick(Sender: TObject);
    procedure pmClearrAllDocsClick(Sender: TObject);
    procedure bbSearchClick(Sender: TObject);
    procedure eFk_VeiculosDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    FDtaEmi: TDateTime;
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDtaSai: TDateTime;
    function  GetDtaFin: TDate;
    function  GetDtaIni: TDate;
    function  GetFkDriver: Integer;
    function  GetFkPartners: Integer;
    function  GetFkPorters: Integer;
    function  GetFkSurveyors: Integer;
    function  GetTypeManifest: TTypeManifest;
    function  GetFkTypeManifest: Integer;
    function  GetFkVehicle: Integer;
    function  GetFkVehicleMark: Integer;
    function  GetFkVehicleModels: Integer;
    function  GetFlagTot: Boolean;
    function  GetNumDoc: Integer;
    function  GetNumNF: Integer;
    function  GetPkManifest: Integer;
    function  GetTotCnh: Double;
    function  GetTotMrc: Double;
    function  GetTotPdg: Double;
    function  GetTotRemb: Double;
    function  GetVlrFrtVst: Double;
    procedure SetDocuments(const Value: TList);
    procedure SetDtaSai(const Value: TDateTime);
    procedure SetDtaFin(const Value: TDate);
    procedure SetDtaIni(const Value: TDate);
    procedure SetFkDriver(const Value: Integer);
    procedure SetFkPartners(const Value: Integer);
    procedure SetFkPorters(const Value: Integer);
    procedure SetFkSurveyors(const Value: Integer);
    procedure SetTypeManifest(const Value: TTypeManifest);
    procedure SetFkVehicle(const Value: Integer);
    procedure SetFkVehicleMark(const Value: Integer);
    procedure SetFkVehicleModels(const Value: Integer);
    procedure SetFlagTot(const Value: Boolean);
    procedure SetNumDoc(const Value: Integer);
    procedure SetNumNF(const Value: Integer);
    procedure SetPkManifest(const Value: Integer);
    procedure SetTotCnh(const Value: Double);
    procedure SetTotMrc(const Value: Double);
    procedure SetTotPdg(const Value: Double);
    procedure SetTotRemb(const Value: Double);
    procedure SetVlrFrtVst(const Value: Double);
    procedure SetFkTypeManifest(const Value: Integer);
    procedure SetScreenMode(AType: TTypeCarrierDoc);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  Documents      : TList                                 write SetDocuments;
    property  DtaEmi         : TDateTime     read FDtaEmi            write FDtaEmi;
    property  DtaSai         : TDateTime     read GetDtaSai          write SetDtaSai;
    property  DtaFin         : TDate         read GetDtaFin          write SetDtaFin;
    property  DtaIni         : TDate         read GetDtaIni          write SetDtaIni;
    property  FkPorters      : Integer       read GetFkPorters       write SetFkPorters;
    property  FkSurveyors    : Integer       read GetFkSurveyors     write SetFkSurveyors;
    property  FkDriver       : Integer       read GetFkDriver        write SetFkDriver;
    property  FkPartners     : Integer       read GetFkPartners      write SetFkPartners;
    property  TypeManifest   : TTypeManifest read GetTypeManifest    write SetTypeManifest;
    property  FkTypeManifest : Integer       read GetFkTypeManifest  write SetFkTypeManifest;
    property  FkVehicle      : Integer       read GetFkVehicle       write SetFkVehicle;
    property  FkVehicleMark  : Integer       read GetFkVehicleMark   write SetFkVehicleMark;
    property  FkVehicleModels: Integer       read GetFkVehicleModels write SetFkVehicleModels;
    property  FlagTot        : Boolean       read GetFlagTot         write SetFlagTot;
    property  NumDoc         : Integer       read GetNumDoc          write SetNumDoc;
    property  NumNF          : Integer       read GetNumNF           write SetNumNF;
    property  PkManifest     : Integer       read GetPkManifest      write SetPkManifest;
    property  TotCnh         : Double        read GetTotCnh          write SetTotCnh;
    property  TotMrc         : Double        read GetTotMrc          write SetTotMrc;
    property  TotPdg         : Double        read GetTotPdg          write SetTotPdg;
    property  TotRemb        : Double        read GetTotRemb         write SetTotRemb;
    property  VlrFrtVst      : Double        read GetVlrFrtVst       write SetVlrFrtVst;
  end;

var
  CdManifest: TCdManifest;

implementation

{$R *.dfm}

uses Dado, GridRow, ProcType, Funcoes, FuncoesDB, DB, ArqSqlTrans, Math,
  TSysPed, DateUtils;

{ TfrmSimulator }

const
  LABEL_CAPTION: array[0..1] of string = ('C.N.P.J.', 'C.P.F.');

function TCdManifest.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  C: TControl;
  S: string;
begin
  Result := True;
  C := nil;
  S := '';
  if (S <> '') and (C <> nil) then
  begin
    Dados.DisplayHint(C, S, hiError);
    Result := False;
  end;
end;

procedure TCdManifest.ClearControls;
begin
  Loading := True;
  try
    Documents       := nil;
    DtaEmi          := Date;
    DtaSai          := Now;
    DtaFin          := Date;
    DtaIni          := Date;
    FkTypeManifest  := 0;
    FkPorters       := 0;
    FkSurveyors     := 0;
    FkDriver        := 0;
    FkPartners      := 0;
    FkVehicle       := 0;
    FkVehicleMark   := 0;
    FkVehicleModels := 0;
    FlagTot         := True;
    NumDoc          := 0;
    NumNF           := 0;
    PkManifest      := 0;
    TotCnh          := 0;
    TotMrc          := 0;
    TotPdg          := 0;
    TotRemb         := 0;
    VlrFrtVst       := 0;
  finally
    Loading := False;
  end;
end;

function TCdManifest.GetDtaSai: TDateTime;
var
  aTime: TDateTime;
begin
  Result := eDta_Sai.Date;
  aTime  := TimeOf(eHor_Sai.Time);
  ReplaceTime(Result, aTime);
end;

function TCdManifest.GetDtaFin: TDate;
begin
  Result := eDtaFin.Date;
end;

function TCdManifest.GetDtaIni: TDate;
begin
  Result := eDtaIni.Date;
end;

function TCdManifest.GetFkDriver: Integer;
begin
  with eFk_Motorista do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdManifest.GetFkPartners: Integer;
begin
  with eFk_Parceiros do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOwner(Items.Objects[ItemIndex]).PkCadastros;
  end;
end;

function TCdManifest.GetFkPorters: Integer;
begin
  with eFk_Carregadores do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdManifest.GetFkSurveyors: Integer;
begin
  with eFk_Conferente do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdManifest.GetFkTypeManifest: Integer;
begin
  with eFk_Tipo_Manifestos do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypeManifest(Items.Objects[ItemIndex]).PkTypeManifest;
  end;
end;

function TCdManifest.GetFkVehicle: Integer;
begin
  with eFk_Veiculos do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdManifest.GetFkVehicleMark: Integer;
begin
  with eFk_Veiculos_Marcas do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdManifest.GetFkVehicleModels: Integer;
begin
  with eFk_Veiculos_Modelos do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdManifest.GetFlagTot: Boolean;
begin
  Result := lFlag_Tot.Checked;
end;

function TCdManifest.GetNumDoc: Integer;
begin
  Result := eNumDoc.AsInteger;
end;

function TCdManifest.GetNumNF: Integer;
begin
  Result := eNumNF.AsInteger;
end;

function TCdManifest.GetPkManifest: Integer;
begin
  Result := StrToIntDef(ePk_Manifestos.Text, 0);
end;

function TCdManifest.GetTotCnh: Double;
begin
  Result := eTot_Cnh.Value;
end;

function TCdManifest.GetTotMrc: Double;
begin
  Result := eTot_Mrc.Value;
end;

function TCdManifest.GetTotPdg: Double;
begin
  Result := eTot_Pdg.Value;
end;

function TCdManifest.GetTotRemb: Double;
begin
  Result := eTot_Remb.Value;
end;

function TCdManifest.GetVlrFrtVst: Double;
begin
  Result := eVlr_Frt_Vst.Value;
end;

procedure TCdManifest.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Tipo_Manifestos.Items.AddStrings(dmSysTrans.LoadTypeManifest);
    eFk_Carregadores.Items.AddStrings(dmSysTrans.LoadEmployees(tePorter));
    eFk_Conferente.Items.AddStrings(dmSysTrans.LoadEmployees(teSurveyor));
    eFk_Veiculos_Marcas.Items.AddStrings(dmSysTrans.LoadVehicleMarks);
    ListLoaded := True;
  end;
end;

procedure TCdManifest.MoveDataToControls;
var
  aItem: TDataRow;
begin
  Loading := True;
  try
    aItem           := dmSysTrans.Manifest[Pk];
    DtaEmi          := aItem.FieldByName['DTA_EMI'].AsDateTime;
    DtaSai          := aItem.FieldByName['DTA_SAI'].AsDateTime;
    FkTypeManifest  := aItem.FieldByName['FK_TIPO_MANIFESTOS'].AsInteger;
    FkPorters       := aItem.FieldByName['FK_FUNCIONARIOS__CONFERENCIA'].AsInteger;
    FkSurveyors     := aItem.FieldByName['FK_FUNCIONARIOS__CARGA'].AsInteger;
    FkDriver        := aItem.FieldByName['FK_FUNCIONARIOS__MOTORISTA'].AsInteger;
    FkPartners      := aItem.FieldByName['FK_AGREGADO'].AsInteger;
    FkVehicleMark   := aItem.FieldByName['FK_VEICULOS_MARCAS'].AsInteger;
    FkVehicleModels := aItem.FieldByName['FK_VEICULOS_MODELOS'].AsInteger;
    FkVehicle       := aItem.FieldByName['FK_VEICULOS'].AsInteger;
    FlagTot         := Boolean(aItem.FieldByName['FLAG_TOT'].AsInteger);
    NumDoc          := 0;
    NumNF           := 0;
    PkManifest      := Pk;
    TotCnh          := aItem.FieldByName['TOT_CNH'].AsFloat;
    TotMrc          := aItem.FieldByName['VLR_MRC'].AsFloat;
    TotPdg          := aItem.FieldByName['VLR_PDG'].AsFloat;
    TotRemb         := aItem.FieldByName['VLR_REMB'].AsFloat;
    VlrFrtVst       := aItem.FieldByName['VLR_FRT_VST'].AsFloat;
    Documents       := dmSysTrans.ManifestDocs[Pk];
  finally
    Loading := False;
  end;
end;

procedure TCdManifest.SaveIntoDB;
var
  aItem: TDataRow;
begin
  try
    aItem           := TDataRow.Create(Self);
    aItem.AddAs('DTA_EMI', Date, ftDateTime, SizeOf(TDateTime));
    aItem.AddAs('DTA_SAI', DtaSai, ftDateTime, SizeOf(TDateTime));
    aItem.AddAs('FK_TIPO_MANIFESTOS', FkTypeManifest, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_FUNCIONARIOS__CONFERENCIA', FkPorters, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_FUNCIONARIOS__CARGA', FkSurveyors, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_FUNCIONARIOS__MOTOTRISTA', FkDriver, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_AGREGADO', FkPartners, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_VEICULOS_MARCAS', FkVehicleMark, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_VEICULOS_MODELOS', FkVehicleModels, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_VEICULOS', FkVehicle, ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_TOT', FlagTot, ftInteger, SizeOf(Integer));
    aItem.AddAs('PK_MANIFESTOS', PkManifest, ftInteger, SizeOf(Integer));
    aItem.AddAs('TOT_CNH', TotCnh, ftFloat, SizeOf(Double));
    aItem.AddAs('TOT_MRC', TotMrc, ftFloat, SizeOf(Double));
    aItem.AddAs('TOT_PDG', TotPdg, ftFloat, SizeOf(Double));
    aItem.AddAs('TOT_REMB', TotRemb, ftFloat, SizeOf(Double));
    aItem.AddAs('VLR_FRE_VST', VlrFrtVst, ftFloat, SizeOf(Double));
    dmSysTrans.Manifest[Pk] := aItem;
  finally
    FreeAndNil(aItem);
  end;
end;

procedure TCdManifest.SetDocuments(const Value: TList);
var
  i: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (Value = nil) or (Value.Count = 0) then
    gbFilterDocuments.Enabled := False
  else
    gbFilterDocuments.Enabled := True;
  if (not gbFilterDocuments.Enabled) then exit;
  with vtDocuments do
  begin
    for i := 0 to Value.Count - 1 do
    begin
      Node := AddChild(nil);
      if (Node <> nil) then
      begin
        Data := GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.DataRow  := TDataRow.CreateAs(vtDocuments, TDataRow(Value.Items[i]));
          Data^.Level    := 0;
          Data^.Node     := Node;
          Data^.NodeType := tnData;
        end;
      end;
    end;
  end;
end;

procedure TCdManifest.SetDtaSai(const Value: TDateTime);
begin
  eDta_Sai.Date := DateOf(Value);
  eHor_Sai.Time := TimeOf(Value);
end;

procedure TCdManifest.SetDtaFin(const Value: TDate);
begin
  eDtaFin.Date := Value;
end;

procedure TCdManifest.SetDtaIni(const Value: TDate);
begin
  eDtaIni.Date := Value;
end;

procedure TCdManifest.SetFkDriver(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Motorista do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdManifest.SetFkPartners(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Parceiros do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Value = TOwner(Items.Objects[i]).PkCadastros) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdManifest.SetFkPorters(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Carregadores do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdManifest.SetFkSurveyors(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Conferente do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdManifest.SetFkTypeManifest(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Motorista do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (Value = TTypeManifest(Items.Objects[i]).PkTypeManifest) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdManifest.SetFkVehicle(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Veiculos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdManifest.SetFkVehicleMark(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Veiculos_Marcas do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdManifest.SetFkVehicleModels(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Veiculos_Modelos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Value = Integer(Items.Objects[i])) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdManifest.SetFlagTot(const Value: Boolean);
begin
  lFlag_Tot.Checked := Value;
end;

procedure TCdManifest.SetNumDoc(const Value: Integer);
begin
  eNumDoc.AsInteger := Value;
end;

procedure TCdManifest.SetNumNF(const Value: Integer);
begin
  eNumNF.AsInteger := Value;
end;

procedure TCdManifest.SetPkManifest(const Value: Integer);
begin
  ePk_Manifestos.Text := IntToStr(Value);
end;

procedure TCdManifest.SetTotCnh(const Value: Double);
begin
  eTot_Cnh.Value := Value;
end;

procedure TCdManifest.SetTotMrc(const Value: Double);
begin
  eTot_Mrc.Value := Value;
end;

procedure TCdManifest.SetTotPdg(const Value: Double);
begin
  eTot_Pdg.Value := Value;
end;

procedure TCdManifest.SetTotRemb(const Value: Double);
begin
  eTot_Remb.Value := Value;
end;

procedure TCdManifest.SetVlrFrtVst(const Value: Double);
begin
  eVlr_Frt_Vst.Value := Value;
end;

procedure TCdManifest.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
end;

procedure TCdManifest.vtDocumentsGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDatasize := SizeOf(TGridData);
end;

procedure TCdManifest.vtDocumentsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['FK_DOCUMENTOS'].AsString;
    1: CellText := FormatDateTime('dd/mm/yyyy', Data^.DataRow.FieldByName['DATA_DOC'].AsDateTime);
    2: CellText := Data^.DataRow.FieldByName['DSC_ORGM'].AsString;
    3: CellText := Data^.DataRow.FieldByName['DSC_DSTN'].AsString;
    4: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_FRE'].AsFloat, ffCurrency, 7, Dados.DecimalPlaces);
  end;
end;

procedure TCdManifest.vtDocumentsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Node^.CheckType := ctCheckBox;
  Node^.CheckState := csUncheckedNormal;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FK_MANIFESTOS'].AsInteger > 0) then
    Node^.CheckState := csCheckedNormal;
end;

procedure TCdManifest.vtDocumentsBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FK_MANIFESTOS'].AsInteger > 0) then
    ItemColor := clMoneyGreen
  else
    ItemColor := clWindow;
  EraseAction := eaColor;
end;

procedure TCdManifest.vtDocumentsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Data^.DataRow.FieldByName['FLAG_REMB'].AsInteger > 0) then
    TargetCanvas.Font.Color := $000080FF
  else
    if (Data^.DataRow.FieldByName['FLAG_TP_FRE'].AsInteger = 0) and (Column = 2) then
      TargetCanvas.Font.Color := clBlue
    else
      if (Data^.DataRow.FieldByName['FLAG_TP_FRE'].AsInteger = 1) and (Column = 3) then
        TargetCanvas.Font.Color := clBlue
      else
        TargetCanvas.Font.Color := clWindowText;
end;

function TCdManifest.GetTypeManifest: TTypeManifest;
begin
  with eFk_Tipo_Manifestos do
  begin
    Result := nil;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypeManifest(Items.Objects[ItemIndex]);
  end;
end;

procedure TCdManifest.SetTypeManifest(const Value: TTypeManifest);
var
  i: Integer;
begin
  with eFk_Motorista do
  begin
    ItemIndex := -1;
    if (Value = nil) then exit;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and
         (Value.PkTypeManifest = TTypeManifest(Items.Objects[i]).PkTypeManifest) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdManifest.eFk_Tipo_ManifestosSelect(Sender: TObject);
var
  aItem: TTypeManifest;
begin
  ChangeGlobal(Sender);
  with eFk_Tipo_Manifestos do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
    begin
      aItem := TTypeManifest(Items.Objects[ItemIndex]);
      SetScreenMode(aItem.FlagTCnh);
    end
  end;
end;

procedure TCdManifest.SetScreenMode(AType: TTypeCarrierDoc);
begin
  lFk_Parceiros.Visible := (AType = cdOther);
  eFk_Parceiros.Visible := (AType = cdOther);
  lFlag_Tot.Checked     := (AType = cdOwner);
  lFlag_Tot.Enabled     := (AType = cdOwner);
end;

procedure TCdManifest.eFk_Veiculos_MarcasSelect(Sender: TObject);
begin
  ChangeGlobal(Sender);
  with eFk_Veiculos_Marcas do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
    begin
      dmSysTrans.FkMark := Integer(Items.Objects[ItemIndex]);
      eFk_Veiculos_Modelos.Items.Clear;
      eFk_Veiculos_Modelos.Items.AddStrings(dmSysTrans.LoadVehicleModel(dmSysTrans.FkMark));
    end;
end;

procedure TCdManifest.eFk_Veiculos_ModelosSelect(Sender: TObject);
var
  aItems: TList;
  i     : Integer;
  aFlag : TTypeVehicle;
  aItem : TVehicle;
begin
  aItems := nil;
  ChangeGlobal(Sender);
  with eFk_Veiculos_Modelos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
    begin
      eFk_Veiculos.Items.Clear;
      dmSysTrans.FkModel := Integer(Items.Objects[ItemIndex]);
      aItems := dmSysTrans.LoadVehicle(dmSysTrans.FkMark, dmSysTrans.FkModel);
    end;
  aFlag := tvNone;
  if (aItems <> nil) and (aItems.Count > 0) then
  begin
    with eFk_Veiculos do
      for i := 0 to aItems.Count - 1 do
      begin
        if (TVehicle(aItems.Items[i]).FlagTOwn <> aFlag) and (TVehicle(aItems.Items[i]).Pk > 0) then
        begin
          aItem := TVehicle.Create;
          aItem.Assign(TVehicle(aItems.Items[i]));
          aItem.Pk := 0;
          Items.AddObject(aItem.DscTVcl, aItem)
        end;
        if (TVehicle(aItems.Items[i]).Pk > 0) then
        begin
          aItem := TVehicle.Create;
          aItem.Assign(TVehicle(aItems.Items[i]));
          Items.AddObject(aItem.PlcVcl + ' - ' + aItem.DscVcl, aItem);
        end;
        aFlag := TVehicle(aItems.Items[i]).FlagTOwn;
      end;
  end;
end;

procedure TCdManifest.eFk_VeiculosSelect(Sender: TObject);
begin
  if (TypeManifest <> nil) and (TypeManifest.FlagTCnh = cdOwner) and
     (eFk_Motorista.Items.Count = 0) then
    eFk_Motorista.Items.AddStrings(dmSysTrans.LoadEmployees(teDriver))
  else
    eFk_Motorista.Items.Clear;
end;

procedure TCdManifest.pmDeleteDocClick(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  with vtDocuments do
  begin
    if (FocusedNode = nil) then
    begin
      Dados.DisplayMessage('Excluir Documento: Você deve selecionar um documento antes');
      exit;
    end;
    Data := GetNodeData(FocusedNode);
    if (Data = nil) or (Data^.DataRow = nil) then
    begin
      Dados.DisplayMessage('Excluir Documento: Erro interno no sistema (-500: VirtualTree Data = nil)', hiError);
      exit;
    end;
    if (FocusedNode.CheckState = csCheckedNormal) then
    begin
      Dados.DisplayMessage('Excluir Documento: Não posso excluir um documento selecionado', hiError);
      exit;
    end;
    BeginUpdate;
    try
      Data^.DataRow.Free;
      Data^.Node := nil;
      Node := FocusedNode;
      if (GetNext(Node) <> nil) then
        FocusedNode := GetNext(Node)
      else
        if (GetPrevious(Node) <> nil) then
          FocusedNode := GetPrevious(Node)
        else
          if (RootNodeCount > 0) then
            FocusedNode := GetFirst;
      DeleteNode(Node);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCdManifest.pmClearrAllDocsClick(Sender: TObject);
var
  NextNode: PVirtualNode;
  Node: PVirtualNode;
  Data: PGridData;
begin
  with vtDocuments do
  begin
    BeginUpdate;
    try
      Node := GetFirst;
      while (Node <> nil) do
      begin
        NextNode := Node;
        if (Node.CheckState = csCheckedNormal) then
        begin
          Data := GetNodeData(Node);
          if (Data <> nil) then
          begin
            if (Data^.DataRow <> nil) then
              Data^.DataRow.Free;
            Data^.Node := nil;
          end;
          NextNode := GetNext(Node);
          DeleteNode(Node);
        end;
        Node := GetNext(NextNode);
      end;
    finally
      EndUpdate;
    end;
    if (RootNodeCount > 0) then
      FocusedNode := GetFirst;
  end;
end;

procedure TCdManifest.bbSearchClick(Sender: TObject);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  with dmSysTrans, vtDocuments do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlSearchCarrierDocs);
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
      qrSqlAux.ParamByName('FkDocumentos').AsInteger := 0;
      qrSqlAux.ParamByName('NumNf').AsInteger        := 0;
      qrSqlAux.ParamByName('StartDate').AsDate       := 0;
      qrSqlAux.ParamByName('EndDate').AsDate         := 0;
      if (NumDoc > 0) then
        qrSqlAux.ParamByName('FkDocumentos').AsInteger := NumDoc;
      if (NumNF > 0) then
        qrSqlAux.ParamByName('NumNf').AsInteger        := NumNF;
      if (DtaIni > 0) then
        qrSqlAux.ParamByName('StartDate').AsDate       := DtaIni;
      if (DtaFin > 0) then
        qrSqlAux.ParamByName('EndDate').AsDate         := DtaFin;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.Eof) do
      begin
        Node := AddChild(nil);
        if (Node <> nil) then
        begin
          Data := GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.DataRow  := TDataRow.CreateFromDataSet(vtDocuments, qrSqlAux, True);
            Data^.Level    := 0;
            Data^.Node     := Node;
            Data^.NodeType := tnData;
          end;
        end;
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

procedure TCdManifest.eFk_VeiculosDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aClass : TVehicle;
  aColor : TColor;
  aOffSet: Integer;
  aItmStr: string;
begin
  if (Index > TComboBox(Control).Items.Count) or
     (TComboBox(Control).Items.Objects[Index] = nil) or
     (not (TComboBox(Control).Items.Objects[Index] is TVehicle)) then
  begin
    TComboBox(Control).Canvas.TextOut(Rect.Left, Rect.Top,
      TComboBox(Control).Items.Strings[Index]);
    TComboBox(Control).Canvas.Brush.Style := bsClear;
    TComboBox(Control).Canvas.DrawFocusRect(Rect);
    TComboBox(Control).Canvas.FrameRect(Rect);
    exit;
  end;
  aClass  := TVehicle(TComboBox(Control).Items.Objects[Index]);
  if (aClass.Pk = 0) then
    aOffSet := 0
  else
    aOffSet := 10;
  if (aClass.Pk = 0) then
      aColor  := clGray
  else
    if (aClass.FlagTOwn = tvOwner) then
      aColor  := clBlue
    else
      aColor  := clGreen;
  with (Control as TComboBox).Canvas do
  begin
    if (odSelected in State) then
      Font.Color := clWhite
    else
      Font.Color := aColor;
    aItmStr := TComboBox(Control).Items.Strings[Index];
    if ((TextWidth(Trim(aItmStr)) + Rect.Left + aOffSet) > TComboBox(Control).Width) then
    begin
      while ((TextWidth(Trim(aItmStr) + '...') + Rect.Left + aOffSet) > TComboBox(Control).Width) do
        Delete(aItmStr, Length(aItmStr), 1);
      aItmStr := aItmStr + '...'
    end;
    TextOut(Rect.Left + aOffSet, Rect.Top + 1, aItmStr);
    if (odSelected in State) or
       (odFocused  in State) or
       (odHotLight in State) then
    begin
      TComboBox(Control).Canvas.Brush.Style := bsClear;
      TComboBox(Control).Canvas.DrawFocusRect(Rect);
      TComboBox(Control).Canvas.FrameRect(Rect);
    end;
  end;
end;

end.
