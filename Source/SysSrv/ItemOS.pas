unit ItemOS;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 06/03/2003 - DD/MM/YYYY                                      *}
{* Modified: 06/03/2003 - DD/MM/YYYY                                     *}
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
  Dialogs, TSysSrv, ExtCtrls, ComCtrls, VirtualTrees, ToolWin, ProcType,
  StdCtrls, Mask, ToolEdit, CurrEdit, jpeg, OSForms, ProcUtils, TSysSrvAux;

type
  TItemEvent    = procedure (AItem: TServiceOrderItem; const AChildItem: Integer;
                             const AMode: TDBMode) of object;

  TScrollItems  = procedure (ADirection: TDirectionScroll; var Enabled: Boolean;
                               const ChildItem: Boolean) of object;

  TfrmItemOS = class(TOSForm)
    pgInsumos: TPageControl;
    tsInsumos: TTabSheet;
    tsServices: TTabSheet;
    cbControlBar: TCoolBar;
    tbFile: TToolBar;
    lFk_Tipo_Composiscoes: TStaticText;
    eFk_Tipo_Composiscoes: TComboBox;
    lQtd_Srv: TStaticText;
    lTot_Srv: TStaticText;
    eQtd_Srv: TCurrencyEdit;
    lVlr_Unit: TStaticText;
    eVlr_Unit: TCurrencyEdit;
    lLoc_Ini: TStaticText;
    eLoc_Ini: TCurrencyEdit;
    lLoc_Fin: TStaticText;
    lFlag_Side: TStaticText;
    eLoc_Fin: TCurrencyEdit;
    eFlag_Side: TComboBox;
    im: TImage;
    sImage: TShape;
    lFk_Insumos: TStaticText;
    eFk_Insumos: TComboBox;
    lQtd_Ins: TStaticText;
    eQtd_Ins: TCurrencyEdit;
    lComp_Ins: TStaticText;
    eComp_Ins: TCurrencyEdit;
    lSeq_Item: TStaticText;
    eFlag_TIns: TComboBox;
    lFlag_TIns: TStaticText;
    eLarg_Ins: TCurrencyEdit;
    lLarg_Ins: TStaticText;
    eAlt_Ins: TCurrencyEdit;
    lAlt_Ins: TStaticText;
    eSeq_Item: TCurrencyEdit;
    lFk_Classificacao: TStaticText;
    eFk_Classificacao: TComboBox;
    tbSave: TToolButton;
    ldbMode: TLabel;
    ToolButton3: TToolButton;
    tbClose: TToolButton;
    lFlag_Frn: TCheckBox;
    stRodovia: TStaticText;
    lComp_Srv: TStaticText;
    eComp_Srv: TCurrencyEdit;
    lLarg_Srv: TStaticText;
    eLarg_Srv: TCurrencyEdit;
    lAlt_Srv: TStaticText;
    eAlt_Srv: TCurrencyEdit;
    lTot_Ins: TStaticText;
    lVlr_Ins: TStaticText;
    eVlr_Ins: TCurrencyEdit;
    eTot_Ins: TCurrencyEdit;
    eTot_Srv: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChangeGlobal(Sender: TObject);
    procedure eFk_Tipo_ComposiscoesChange(Sender: TObject);
    procedure eFk_ClassificacaoChange(Sender: TObject);
    procedure eQtd_SrvChange(Sender: TObject);
    procedure eVlr_UnitChange(Sender: TObject);
    procedure eLoc_IniChange(Sender: TObject);
    procedure eLoc_FinChange(Sender: TObject);
    procedure eFlag_SideChange(Sender: TObject);
    procedure eFlag_TInsChange(Sender: TObject);
    procedure eQtd_InsChange(Sender: TObject);
    procedure eFk_InsumosChange(Sender: TObject);
    procedure eAlt_InsChange(Sender: TObject);
    procedure eLarg_InsChange(Sender: TObject);
    procedure eComp_InsChange(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure eFk_ClassificacaoDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure tbCloseClick(Sender: TObject);
    procedure eComp_SrvChange(Sender: TObject);
    procedure eLarg_SrvChange(Sender: TObject);
    procedure eAlt_SrvChange(Sender: TObject);
    procedure eVlr_InsChange(Sender: TObject);
    procedure lFlag_FrnClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FDelClose      : Boolean;
    FEntryData     : TEntryData;
    FFlagEdtValAbrt: Boolean;
    FFlagEdtComp   : Boolean;
    FFlagEdtSrv    : Boolean;
    FOnUpdateItem  : TItemEvent;
    FOnScrollItem  : TScrollItems;
    FOnUpdateOS    : TNotifyEvent;
    FOnCloseItems  : TNotifyEvent;
    FViewItem      : Boolean;
    procedure SetEntryData(AValue: TEntryData);
    procedure SetActivity;
    procedure SetService;
    // Events of the ítem
    procedure LoadTypeCompositions;
    procedure LoadClassifications;
    procedure LoadInsumos(AType: Integer);
    procedure MoveItemDataToControls(const AIdx: Integer);
    procedure MoveInsumoDataToControls(const AItx, AInx: Integer);
    procedure DisableActivityCtr(AIdx, AInx: Integer; AFlags: TFlagQtd);
    function  GetFkServiceIndex(APkTypeComp: Integer): Integer;
    function  GetFkClassificationIndex(APkClass: Integer): Integer;
    function  GetFkInsumosIndex(APkInsumo: Integer): Integer;
    procedure ChangeMode(Sender: TObject);
    procedure ChangeOS(Sender: TObject);
  protected
    { Protected declarations }
  public
    { Public declarations }
    ServiceOrder: TServiceOrder;
    procedure ClearItemControls;
    procedure ClearInsumoControls;
    property DelClose      : Boolean       read FDelClose       write FDelClose       default True;
    property EntryData     : TEntryData    read FEntryData      write SetEntryData    default edService;
    property FlagEdtValAbrt: Boolean       read FFlagEdtValAbrt write FFlagEdtValAbrt default True;
    property FlagEdtComp   : Boolean       read FFlagEdtComp    write FFlagEdtComp    default False;
    property FlagEdtSrv    : Boolean       read FFlagEdtSrv     write FFlagEdtSrv     default False;
    // Events
    property OnScrollItem: TScrollItems read FOnScrollItem write FOnScrollItem;
    property OnUpdateItem: TItemEvent   read FOnUpdateItem write FOnUpdateItem;
    property OnUpdateOS  : TNotifyEvent read FOnUpdateOS   write FOnUpdateOS;
    property OnCloseItems: TNotifyEvent read FOnCloseItems write FOnCloseItems;
  end;

var
  frmItemOS: TfrmItemOS;

implementation

uses Dado, mSysSrv, Funcoes, SrvArqSql, TSysFatAux, TSysEstqAux;

{$R *.dfm}

procedure TfrmItemOS.FormCreate(Sender: TObject);
begin
  inherited;
  cbControlBar.Images := Dados.Image16;
  tbFile.Images       := Dados.Image16;
  dbMode          := dbmBrowse;
  FDelClose       := True;
  FEntryData      := edService;
  FFlagEdtValAbrt := True;
  FFlagEdtComp    := False;
  FFlagEdtSrv     := False;
  FViewItem       := True;
  OnChangeOS      := ChangeOS;
  OnChangeMode    := ChangeMode;
end;

procedure TfrmItemOS.FormDestroy(Sender: TObject);
begin
  OnChangeOS      := nil;
  OnChangeMode    := nil;
  OnUpdateItem    := nil;
  OnScrollItem    := nil;
  OnUpdateOS      := nil;
  ServiceOrder    := nil;
  inherited;
end;

procedure TfrmItemOS.ChangeOS(Sender: TObject);
var
  aIdx: Integer;
begin
  if (ServiceOrder = nil) then exit;
  FDelClose := True;
  eFk_Tipo_Composiscoes.Enabled := True;
  if ServiceOrder.ActiveItem = -1 then exit;
  aIdx := ServiceOrder.ActiveItem;
  eFk_Tipo_Composiscoes.Enabled := (ServiceOrder.ServiceOrderItems.Items[aIdx].Node = nil);
  if (ServiceOrder.FkTypeServiceOrder <> nil) then
  begin
    lLoc_Ini.Visible   := (ServiceOrder.FkTypeServiceOrder.FlagTOS = tuMetric);
    eLoc_Ini.Visible   := (ServiceOrder.FkTypeServiceOrder.FlagTOS = tuMetric);
    lLoc_Fin.Visible   := (ServiceOrder.FkTypeServiceOrder.FlagTOS = tuMetric);
    eLoc_Fin.Visible   := (ServiceOrder.FkTypeServiceOrder.FlagTOS = tuMetric);
    lFlag_Side.Visible := (ServiceOrder.FkTypeServiceOrder.FlagTOS = tuMetric);
    eFlag_Side.Visible := (ServiceOrder.FkTypeServiceOrder.FlagTOS = tuMetric);
  end;
end;

procedure TfrmItemOS.ChangeMode(Sender: TObject);
begin
  ldbMode.Caption    := ModeTypes[dbMode];
  ldbMode.Font.Color := ColorMode[dbMode];
  tbSave.Enabled     := (dbMode in [dbmInsert, dbmEdit]);
end;

procedure TfrmItemOS.SetEntryData(AValue: TEntryData);
begin
  FEntryData := AValue;
  case FEntryData of
    edService  : SetService;
    edActivity : SetActivity;
  end;
end;

procedure TfrmItemOS.SetActivity;
var
  aItx, aInx: Integer;
  aItem     : TInsumo;
  aFlags    : TFlagQtd;
begin
  pgInsumos.ActivePageIndex := 1;
  aItx     := ServiceOrder.ActiveItem;
  if (aItx < 0) or (ServiceOrder.ServiceOrderItems.Count <= aItx) or
     (ServiceOrder.ServiceOrderItems.Items[aItx] = nil) then
    raise Exception.CreateFmt('Erro OS: Não posso %s ítem sem instanciar os ' +
      'objetos (Serviços)', [ModeTypes[dbMode]]);
  if dbMode <> dbmInsert then
  begin
    aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
    with ServiceOrder.ServiceOrderItems.Items[aItx] do
    begin
      if (aInx < 0) or (FkInsumos = nil) or (FkInsumos.Count <= aInx) or
         (FkInsumos.Items[aInx] = nil) then
        raise Exception.CreateFmt('Erro: Não posso %s ítem sem instanciar os ' +
          'objetos (Atividades)', [ModeTypes[dbMode]]);
    end;
  end
  else
  begin
    aItem := ServiceOrder.ServiceOrderItems.Items[AItx].FkInsumos.Add;
    ServiceOrder.ServiceOrderItems.Items[AItx].ActiveInsumo := aItem.Index;
    aInx  := aItem.Index;
  end;
  with ServiceOrder.ServiceOrderItems.Items[aItx] do
    aFlags := FkInsumos.Items[aInx].FlagTQtd;
  MoveInsumoDataToControls(aItx, aInx);
  DisableActivityCtr(aItx, aInx, aFlags);
  if dbMode <> dbmInsert then
  begin
    eFlag_TIns.Enabled  := FFlagEdtSrv;
    eSeq_Item.Enabled   := FFlagEdtSrv;
    eFk_Insumos.Enabled := FFlagEdtSrv;
  end
  else
  begin
    eFlag_TIns.Enabled  := True;
    eSeq_Item.Enabled   := True;
    eFk_Insumos.Enabled := True;
  end
end;

procedure TfrmItemOS.SetService;
var
  aItem: TServiceOrderItem;
  aItx : Integer;
begin
  pgInsumos.ActivePageIndex := 0;
  if dbMode <> dbmInsert then
  begin
    aItx := ServiceOrder.ActiveItem;
    if (ServiceOrder.ServiceOrderItems.Count <= aItx) or
       (ServiceOrder.ServiceOrderItems.Items[aItx] = nil) then
    begin
      Application.MessageBox(PAnsiChar('Erro: Não posso inserir ítem sem ' +
        'instanciar os objetos (Serviços)'), PAnsiChar(Application.Title),
        MB_ICONERROR + MB_OK);
      Close;
    end;
  end
  else
  begin
    aItem                   := ServiceOrder.ServiceOrderItems.Add;
    ServiceOrder.ActiveItem := aItem.Index;
    aItx                    := aItem.Index;
  end;
  stRodovia.Caption :=
    IntToStr(ServiceOrder.FkRodovias.PkRodovias) + ' / ' + ServiceOrder.FkRodovias.DscRod +
    ' ==> Km Ini: ' + FloatToStrF(ServiceOrder.FKRodovias.KmIni, ffNumber, 7, 4) +
    ' ==> Km Fin: ' + FloatToStrF(ServiceOrder.FKRodovias.KmFin, ffNumber, 7, 4);
  // load Type compositions
  eLoc_Ini.MinValue := ServiceOrder.FKRodovias.KmIni;
  eLoc_Ini.MaxValue := ServiceOrder.FKRodovias.KmFin;
  eLoc_Fin.MinValue := ServiceOrder.FKRodovias.KmIni;
  eLoc_Fin.MaxValue := ServiceOrder.FKRodovias.KmFin;
  LoadTypeCompositions;
  // load Classifications
  LoadClassifications;
  MoveItemDataToControls(aItx);
  DisableActivityCtr(aItx, -1, ServiceOrder.ServiceOrderItems.Items[aItx].FlagTQtd);
  if dbMode <> dbmInsert then
  begin
    eFk_Tipo_Composiscoes.Enabled := FFlagEdtComp;
    eFk_Classificacao.Enabled     := FFlagEdtComp;
    if FFlagEdtValAbrt then
      eVlr_Unit.Enabled           := (ServiceOrder.FkStatusOS.FlagStt = stOpened);
  end
  else
  begin
    eFk_Tipo_Composiscoes.Enabled := True;
    eFk_Classificacao.Enabled     := True;
    eVlr_Unit.Enabled             := True;
  end;
end;

procedure TfrmItemOS.DisableActivityCtr(AIdx, AInx: Integer; AFlags: TFlagQtd);
begin
  with ServiceOrder.ServiceOrderItems.Items[AIdx] do
  begin
    lQtd_Ins.Enabled  := (fqQtd in AFlags);
    eQtd_Ins.Enabled  := (fqQtd in AFlags);
    lAlt_Srv.Visible  := (fqAlt in AFlags);
    eAlt_Srv.Visible  := (fqAlt in AFlags);
    lAlt_Ins.Visible  := (fqAlt in AFlags);
    eAlt_Ins.Visible  := (fqAlt in AFlags);
    lLarg_Srv.Visible := (fqLarg in AFlags);
    eLarg_Srv.Visible := (fqLarg in AFlags);
    lLarg_Ins.Visible := (fqLarg in AFlags);
    eLarg_Ins.Visible := (fqLarg in AFlags);
    lComp_Srv.Visible := (fqComp in AFlags);
    eComp_Srv.Visible := (fqComp in AFlags);
    lComp_Ins.Visible := (fqComp in AFlags);
    eComp_Ins.Visible := (fqComp in AFlags);
    lFlag_Frn.Visible := (AInx > -1);
  end;
end;

procedure TfrmItemOS.LoadTypeCompositions;
begin
  ReleaseCombos(eFk_Tipo_Composiscoes, toObject);
  eFk_Tipo_Composiscoes.Items.AddStrings(dmSysSrv.GetTypeCompositions);
end;

procedure TfrmItemOS.LoadClassifications;
begin
  ReleaseCombos(eFk_Classificacao, toObject);
  eFk_Classificacao.Items.AddStrings(dmSysSRv.GetClassifications(
    Integer(ServiceOrder.FkTypeServiceOrder.FlagES)));
end;

procedure TfrmItemOS.LoadInsumos(AType: Integer);
begin
  ReleaseCombos(eFk_Insumos, toObject);
  eFk_Insumos.Items.AddStrings(dmSysSRv.GetInsumos(AType));
end;

procedure TfrmItemOS.MoveItemDataToControls(const AIdx: Integer);
begin
  if (AIdx < 0) and (ServiceOrder.ServiceOrderItems = nil) and
     (ServiceOrder.ServiceOrderItems.Count > AIdx) and
     (ServiceOrder.ServiceOrderItems.Items[AIdx] = nil) then
    exit;
  FViewItem := True;
  with ServiceOrder.ServiceOrderItems.Items[AIdx] do
  begin
    if (PkProduct > 0) then
      eFk_Tipo_Composiscoes.ItemIndex :=
        GetFkServiceIndex(PkProduct)
    else
      eFk_Tipo_Composiscoes.ItemIndex := 0;
    if FkClassification > 0 then
      eFk_Classificacao.ItemIndex := GetFkClassificationIndex(FkClassification)
    else
      if FkClassification > 0 then
        eFk_Classificacao.ItemIndex :=
          GetFkClassificationIndex(FkClassification)
      else
        eFk_Classificacao.ItemIndex := 0;
    eQtd_Srv.Value  := QtdSrv;
    eVlr_Unit.Value := VlrUnit;
    eTot_Srv.Caption   := FloatToStrF(TotSrv, ffCurrency, 7, Dados.DecimalPlaces);
    eComp_Srv.Value := CompSrv;
    eLarg_Srv.Value := LargSrv;
    eAlt_Srv.Value  := AltSrv;
    ValueType := TSysSrv.vtNone;
    if (ServiceOrder.FkTypeServiceOrder.FlagTOS = tuMetric) and
       (FkMetricItem <> nil) then
    begin
      eLoc_Ini.Value       := FkMetricItem.KmIni;
      eLoc_Fin.Value       := FkMetricItem.KmFin;
      eFlag_Side.ItemIndex := Ord(FkMetricItem.FlagSide);
    end;
  end;
  FViewItem := False;
end;

function  TfrmItemOS.GetFkServiceIndex(APkTypeComp: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to eFk_Tipo_Composiscoes.Items.Count - 1 do
  begin
    if (eFk_Tipo_Composiscoes.Items.Objects[i] <> nil) and
       (eFk_Tipo_Composiscoes.Items.Objects[i] is TServiceOrderItem) then
      if (TServiceOrderItem(eFk_Tipo_Composiscoes.Items.Objects[i]).PkProduct =
          APkTypeComp) then
      begin
        Result := i;
        break;
      end;
  end;
end;

function  TfrmItemOS.GetFkClassificationIndex(APkClass: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to eFk_Classificacao.Items.Count - 1 do
  begin
    if (eFk_Classificacao.Items.Objects[i] <> nil) and
       (eFk_Classificacao.Items.Objects[i] is TClassification) then
      if (TClassification(eFk_Classificacao.Items.Objects[i]).Pk = APkClass) then
      begin
        Result := i;
        break;
      end;
  end;
end;

procedure TfrmItemOS.MoveInsumoDataToControls(const AItx, AInx: Integer);
begin
  FViewItem := True;
  with ServiceOrder.ServiceOrderItems.Items[AItx].FkInsumos.Items[AInx] do
  begin
    case FlagTIns of
      tiService : eFlag_TIns.ItemIndex := 0;
      tiPurchase: eFlag_TIns.ItemIndex := 1;
    end;
    LoadInsumos(eFlag_TIns.ItemIndex);
    eFk_Insumos.ItemIndex := GetFkInsumosIndex(FkProduct);
    eSeq_Item.Value       := SeqIns;
    eQtd_Ins.Value        := QtdIns;
    eAlt_Ins.Value        := AltIns;
    eLarg_Ins.Value       := LargIns;
    eComp_Ins.Value       := CompIns;
    eVlr_Ins.Value        := VlrUnit;
    eTot_Ins.Value        := TotIns;
    lFlag_Frn.Checked     := FlagFrn;
  end;
  FViewItem := False;
end;

function  TfrmItemOS.GetFkInsumosIndex(APkInsumo: Integer): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to eFk_Insumos.Items.Count - 1 do
  begin
    if (eFk_Insumos.Items.Objects[i] <> nil) and
       (eFk_Insumos.Items.Objects[i] is TInsumo) then
      if (TInsumo(eFk_Insumos.Items.Objects[i]).FkProduct =
          APkInsumo) then
      begin
        Result := i;
        break;
      end;
  end;
end;

procedure TfrmItemOS.ClearItemControls;
begin
  eFk_Tipo_Composiscoes.ItemIndex := 0;
  eFk_Classificacao.ItemIndex     := 0;
  eQtd_Srv.Value                  := 0;
  eVlr_Unit.Value                 := 0;
  eTot_Srv.Caption                := FloatToStrF(0.0, ffCurrency, 7, Dados.DecimalPlaces);
  eLoc_Ini.Value                  := 0;
  eLoc_Fin.Value                  := 0;
  eFlag_Side.ItemIndex            := -1;
end;

procedure TfrmItemOS.ClearInsumoControls;
begin
  eFlag_TIns.ItemIndex  := -1;
  ReleaseCombos(eFk_Insumos, toObject);
  eFk_Insumos.ItemIndex := -1;
  eSeq_Item.Value       := 0;
  eQtd_Ins.Value        := 0;
  eAlt_Srv.Value        := 0;
  eLarg_Srv.Value       := 0;
  eComp_Srv.Value       := 0;
end;

procedure TfrmItemOS.ChangeGlobal(Sender: TObject);
begin
  if FViewItem then exit;
  if (dbMode = dbmBrowse) then
    if (ServiceOrder.PkOS > 0) then
      DbMode := dbmInsert
    else
      DbMode := dbmEdit;
end;

procedure TfrmItemOS.eFk_Tipo_ComposiscoesChange(Sender: TObject);
var
  aIdx, i: Integer;
begin
  if FViewItem then exit;
  if (ServiceOrder = nil) then
    raise Exception.Create('Ordens de Serviços: Objeto ServiceOrder nulo');
  aIdx := ServiceOrder.ActiveItem;
  i := eFk_Tipo_Composiscoes.ItemIndex;
  if (i < 0) or (aIdx < 0) then exit;
  if (eFk_Tipo_Composiscoes.Items.Objects[i] <> nil) and
     (eFk_Tipo_Composiscoes.Items.Objects[i] is TServiceOrderItem)  then
  begin
    ServiceOrder.ServiceOrderItems.Items[aIdx].Assign(
      TServiceOrderItem(eFk_Tipo_Composiscoes.Items.Objects[i]));
    MoveItemDataToControls(aIdx);
    DisableActivityCtr(aIdx, -1, ServiceOrder.ServiceOrderItems.Items[aIdx].FlagTQtd);
    ChangeGlobal(Sender);
  end;
end;

procedure TfrmItemOS.eFk_ClassificacaoChange(Sender: TObject);
var
  aIdx, i: Integer;
begin
  if FViewItem then exit;
  aIdx := ServiceOrder.ActiveItem;
  i    := eFk_Classificacao.ItemIndex;
  if (i < 0) or (aIdx < 0) then exit;
  if (eFk_Classificacao.Items.Objects[i] <> nil) and
     (eFk_Classificacao.Items.Objects[i] is TClassification)    then
  begin
    with ServiceOrder.ServiceOrderItems.Items[aIdx] do
    begin
      if TClassification(eFk_Classificacao.Items.Objects[i]).FlagAnlSnt then
        FkClassification := TClassification(eFk_Classificacao.Items.Objects[i]).Pk
      else
      begin
        Application.MessageBox(PAnsiChar('Atenção: Esta conta não pode ser ' +
          'usada para Lançamentos'), PAnsiChar(Application.Title),
          MB_ICONWARNING + MB_OK);
        eFk_Classificacao.ItemIndex :=
          TClassification(eFk_Classificacao.Items.Objects[i]).cbIndex;
      end;
    end;
    ChangeGlobal(Sender);
  end;
end;

procedure TfrmItemOS.eQtd_SrvChange(Sender: TObject);
var
  aIdx: Integer;
begin
  if FViewItem then exit;
  aIdx := ServiceOrder.ActiveItem;
  if aIdx < 0 then exit;
  with ServiceOrder.ServiceOrderItems.Items[aIdx] do
  begin
    QtdSrv := eQtd_Srv.Value;
    eTot_Srv.Caption := FloatToStrF(TotSrv, ffCurrency, 7, Dados.DecimalPlaces);
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eVlr_UnitChange(Sender: TObject);
var
  aIdx: Integer;
begin
  if FViewItem then exit;
  aIdx := ServiceOrder.ActiveItem;
  if aIdx < 0 then exit;
  with ServiceOrder.ServiceOrderItems.Items[aIdx] do
  begin
    VlrUnit := eVlr_Unit.Value;
    eTot_Srv.Caption := FloatToStrF(TotSrv, ffCurrency, 7, Dados.DecimalPlaces);
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eLoc_IniChange(Sender: TObject);
var
  aIdx: Integer;
begin
  if FViewItem then exit;
  ChangeGlobal(Sender);
  eLoc_Fin.Value := eLoc_Ini.Value;
  aIdx := ServiceOrder.ActiveItem;
  if aIdx < 0 then exit;
  ServiceOrder.ServiceOrderItems.Items[aIdx].FkMetricItem.KmIni := eLoc_Ini.Value;
end;

procedure TfrmItemOS.eLoc_FinChange(Sender: TObject);
var
  aIdx: Integer;
begin
  if FViewItem then exit;
  ChangeGlobal(Sender);
  aIdx := ServiceOrder.ActiveItem;
  if aIdx < 0 then exit;
  ServiceOrder.ServiceOrderItems.Items[aIdx].FkMetricItem.KmFin := eLoc_Fin.Value;
end;

procedure TfrmItemOS.eFlag_SideChange(Sender: TObject);
var
  aIdx: Integer;
begin
  if FViewItem then exit;
  aIdx := ServiceOrder.ActiveItem;
  if aIdx < 0 then exit;
  with ServiceOrder.ServiceOrderItems.Items[aIdx].FkMetricItem do
    FlagSide := TSide(eFlag_Side.ItemIndex);
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eFlag_TInsChange(Sender: TObject);
var
  aItx, aInx: Integer;
begin
  if FViewItem then exit;
  aItx := ServiceOrder.ActiveItem;
  if aItx < 0 then exit;
  aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
  if (aInx < 0) or
     (ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos = nil) then
    exit;
  with ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos do
  begin
    case eFlag_TIns.ItemIndex of
      0: Items[aInx].FlagTIns := tiService;
      1: Items[aInx].FlagTIns := tiPurchase;
    end;
    LoadInsumos(eFlag_TIns.ItemIndex);
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eQtd_InsChange(Sender: TObject);
var
  aItx, aInx: Integer;
begin
  if FViewItem and (not eQtd_Ins.Enabled) then exit;
  aItx := ServiceOrder.ActiveItem;
  if aItx < 0 then exit;
  aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
  if (aInx < 0) or
     (ServiceOrder.ServiceOrderItems.Items[aItx] = nil) or
     (ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos = nil) then
    exit;
  with ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos do
  begin
    Items[aInx].QtdIns := eQtd_Ins.Value;
    eTot_Ins.Value := Items[aInx].TotIns;
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eFk_InsumosChange(Sender: TObject);
var
  aItx, aInx, i: Integer;
begin
  if FViewItem then exit;
  aItx := ServiceOrder.ActiveItem;
  i    := eFk_Insumos.ItemIndex;
  if (i < 0) or (aItx < 0) then exit;
  aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
  if (aInx < 0) or
     (ServiceOrder.ServiceOrderItems.Items[aItx] = nil) or
     (ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos = nil) then
    exit;
  if (eFk_Insumos.Items.Objects[i] <> nil) and
     (eFk_Insumos.Items.Objects[i] is TInsumo)  then
    with ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos do
      Items[aInx].Assign(TInsumo(eFk_Insumos.Items.Objects[i]));
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eAlt_InsChange(Sender: TObject);
var
  aItx, aInx: Integer;
begin
  if FViewItem then exit;
  aItx := ServiceOrder.ActiveItem;
  if aItx < 0 then exit;
  aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
  if (aInx < 0) or
     (ServiceOrder.ServiceOrderItems.Items[aItx] = nil) or
     (ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos = nil) then
    exit;
  with ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos do
  begin
    Items[aInx].AltIns := eAlt_Ins.Value;
    eTot_Ins.Value := Items[aInx].TotIns;
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eLarg_InsChange(Sender: TObject);
var
  aItx, aInx: Integer;
begin
  if FViewItem then exit;
  aItx := ServiceOrder.ActiveItem;
  if aItx < 0 then exit;
  aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
  if (aInx < 0) or
     (ServiceOrder.ServiceOrderItems.Items[aItx] = nil) or
     (ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos = nil) then
    exit;
  with ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos do
  begin
    Items[aInx].LargIns := eLarg_Ins.Value;
    eTot_Ins.Value := Items[aInx].TotIns;
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eComp_InsChange(Sender: TObject);
var
  aItx, aInx: Integer;
begin
  if FViewItem then exit;
  aItx := ServiceOrder.ActiveItem;
  if aItx < 0 then exit;
  aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
  if (aInx < 0) or
     (ServiceOrder.ServiceOrderItems.Items[aItx] = nil) or
     (ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos = nil) then
    exit;
  with ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos do
  begin
    Items[aInx].CompIns := eComp_Ins.Value;
    eTot_Ins.Value := Items[aInx].TotIns;
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eVlr_InsChange(Sender: TObject);
var
  aItx, aInx: Integer;
begin
  if FViewItem then exit;
  aItx := ServiceOrder.ActiveItem;
  if aItx < 0 then exit;
  aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
  if (aInx < 0) or
     (ServiceOrder.ServiceOrderItems.Items[aItx] = nil) or
     (ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos = nil) then
    exit;
  with ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos do
  begin
    Items[aInx].VlrUnit := eVlr_Ins.Value;
    eTot_Ins.Value := Items[aInx].TotIns;
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.tbSaveClick(Sender: TObject);
var
  aItx, aInx: Integer;
begin
  aItx := ServiceOrder.ActiveItem;
  if (aItx = -1) or (ServiceOrder.ServiceOrderItems.Count = 0) then exit;
  if Assigned(FOnUpdateItem) then
  begin
    if ServiceOrder.ServiceOrderItems.Items[aItx].FlagCalcVlrIns then
      ServiceOrder.ServiceOrderItems.Items[aItx].CalcVlrUnitFromIns;
    if (FEntryData = edService) then
    begin
      ServiceOrder.ServiceOrderItems.Items[aItx].CheckRules;
      FOnUpdateItem(ServiceOrder.ServiceOrderItems.Items[aItx], -1, dbMode);
      eFk_Tipo_Composiscoes.Enabled := (ServiceOrder.ServiceOrderItems.Items[aItx].Node = nil);
    end;
    if FEntryData = edActivity then
    begin
      aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
      with ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos do
      begin
        if (aInx = -1) and (Count = 0) then exit;
        if (Items[aInx].FkProduct = 0) then
          Delete(aInx)
        else
          FOnUpdateItem(ServiceOrder.ServiceOrderItems.Items[aItx], -1, dbMode);
      end;
    end;
  end;
  dbMode := dbmBrowse;
  if Assigned(FOnCloseItems) then
    FOnCloseItems(Self);
  Close;
end;

procedure TfrmItemOS.eFk_ClassificacaoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aClass : TClassification;
  aColor : TColor;
  aOffSet: Integer;
  aStr   ,
  aItmStr: string;
begin
  if (Index > TComboBox(Control).Items.Count) or
     (TComboBox(Control).Items.Objects[Index] = nil) or
     (not (TComboBox(Control).Items.Objects[Index] is TClassification)) then
  begin
    TComboBox(Control).Canvas.TextOut(Rect.Left, Rect.Top,
      TComboBox(Control).Items.Strings[Index]);
    exit;
  end;
  aClass  := TClassification(TComboBox(Control).Items.Objects[Index]);
  aColor  := clGray;
  aOffSet := aClass.NivCta * 10;
  if aClass.FlagAnlSnt then
  begin
    aColor  := clWindowText;
  end;
  with (Control as TComboBox).Canvas do
  begin
    Font.Color := aColor;
    aStr       := TComboBox(Control).Items.Strings[Index];
    aItmStr    := Copy(aStr, 1, Pos('|', aStr) - 1);
    Delete(aStr, 1, Pos('|', aStr));
    TextOut(Rect.Left + aOffSet, Rect.Top, aItmStr);
    TextOut(Rect.Left + 400, Rect.Top, aStr);
  end;
end;

procedure TfrmItemOS.tbCloseClick(Sender: TObject);
begin
  eLoc_IniChange(eLoc_Ini);
  eLoc_FinChange(eLoc_Fin);
  if dbMode in [dbmEdit, dbmInsert] then
    dbMode := dbmCancel;
  if Assigned(FOnCloseItems) then
    FOnCloseItems(Self);
  Close;
end;

procedure TfrmItemOS.eComp_SrvChange(Sender: TObject);
var
  aIdx: Integer;
begin
  if FViewItem then exit;
  aIdx := ServiceOrder.ActiveItem;
  if aIdx < 0 then exit;
  with ServiceOrder.ServiceOrderItems.Items[aIdx] do
  begin
    if CompSrv <> eComp_Srv.Value then
    begin
      CompSrv := eComp_Srv.Value;
      if not FlagCalcVlrIns then
        QtdSrv := CompSrv * LargSrv * AltSrv;
      eQtd_Srv.Value := QtdSrv;
    end;
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eLarg_SrvChange(Sender: TObject);
var
  aIdx: Integer;
begin
  if FViewItem then exit;
  aIdx := ServiceOrder.ActiveItem;
  if aIdx < 0 then exit;
  with ServiceOrder.ServiceOrderItems.Items[aIdx] do
  begin
    LargSrv := eLarg_Srv.Value;
    if not FlagCalcVlrIns then
      QtdSrv := CompSrv * LargSrv * AltSrv;
    eQtd_Srv.Value := QtdSrv;
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.eAlt_SrvChange(Sender: TObject);
var
  aIdx: Integer;
begin
  if FViewItem then exit;
  aIdx := ServiceOrder.ActiveItem;
  if aIdx < 0 then exit;
  with ServiceOrder.ServiceOrderItems.Items[aIdx] do
  begin
    AltSrv := eAlt_Srv.Value;
    if not FlagCalcVlrIns then
      QtdSrv := CompSrv * LargSrv * AltSrv;
    eQtd_Srv.Value := QtdSrv;
  end;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.lFlag_FrnClick(Sender: TObject);
var
  aItx, aInx: Integer;
begin
  if FViewItem then exit;
  aItx := ServiceOrder.ActiveItem;
  if aItx < 0 then exit;
  aInx := ServiceOrder.ServiceOrderItems.Items[aItx].ActiveInsumo;
  if (aInx < 0) or
     (ServiceOrder.ServiceOrderItems.Items[aItx] = nil) or
     (ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos = nil) then
    exit;
  with ServiceOrder.ServiceOrderItems.Items[aItx].FkInsumos do
    Items[aInx].FlagFrn := lFlag_Frn.Checked;
  ChangeGlobal(Sender);
end;

procedure TfrmItemOS.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F12 then
    tbSave.Click;
  if Key = VK_ESCAPE then
    tbClose.Click;
end;

end.
