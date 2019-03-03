unit mSysPed;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 06/03/2003 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : (alcindo@sistemaprocessa.com.br)                           *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Encryp, ProcType, ProcUtils, FMTBcd, SqlExpr, TSysCad, TSysPed, GridRow,
  TSysPedAux, TSysConfAux, TSysEstqAux, TSysCadAux, TSysFatAux, TSysMan;

type
  TOrgmNatOpe = (onDE, onFE, onEX);

  TDefaultRecord = record
    PrzEntr     : Integer;
    FlagES      : TInOut;
    FkGroupMov  : Integer;
    FkTypeMov   : Integer;
    TypeDelivery: Integer;
    StatusOrder : Integer;
    FlagItmDsct : Boolean;
    FlagTPed    : TOrderType;
  end;

  TdmSysPed = class(TDataModule)
    qrTypeOrder: TSQLQuery;
    qrSqlAux: TSQLQuery;
    qrInsumos: TSQLQuery;
    qrTypeDiscount: TSQLQuery;
    qrTypePayment: TSQLQuery;
    qrTypeFreight: TSQLQuery;
    qrParamPed: TSQLQuery;
    qrOrderItems: TSQLQuery;
    qrOrderItConfig: TSQLQuery;
    qrPurchaseOrder: TSQLQuery;
    qrProducts: TSQLQuery;
    qrStatusOrder: TSQLQuery;
    qrTypeMovement: TSQLQuery;
    qrDeliveryPeriod: TSQLQuery;
    qrComponents: TSQLQuery;
    qrFinish: TSQLQuery;
    qrOrders: TSQLQuery;
    qrPayOrder: TSQLQuery;
    qrOrderPending: TSQLQuery;
    qrOrderMessage: TSQLQuery;
    qrOrderLink: TSQLQuery;
    qrOrderHistoric: TSQLQuery;
    qrPgtWay: TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FPkGroupMoviment: Integer;
    FMultiCompany: Boolean;
    function  GetParamsPed(APk: Integer): TDataRow;
    function  GetGroupMovement(APk: Integer): TMovement;
    function  GetTypeMovement(APk: Integer): TMovement;
    function  GetTypePayment(APk: Integer): TTypePayment;
    function  GetTypeDiscount(APk: Integer): TTypeDiscount;
    function  GetTypeStatusOrd(APk: Integer): TDataRow;
    function  GetDeliveryPeriod(APk: Integer): TDataRow;
    function  GetTypeFreight(APk: Integer): TDataRow;
    function  GetOrder(APk: Integer): TOrder;
    function  GetOrderItems(APk: Integer): TOrderItems;
    function  GetOrderMessages(APk: Integer): TOrderMessages;
    function  GetOrderHistorics(APk: Integer): TOrderHistorics;
    function  GetOrderLinks(APk: Integer): TOrderLinks;
    function  GetOrderDiscounts(APk: Integer): TDiscounts;
    function  GetOrderInstallments(APk: Integer): TInstallments;
    procedure GetOrderDelivery(var Value: TOrder);
    procedure SetGroupMovement(APk: Integer; const Value: TMovement);
    procedure SetTypeMovement(APk: Integer; const Value: TMovement);
    procedure SetTypePayment(APk: Integer; const Value: TTypePayment);
    procedure SetTypeDiscount(APk: Integer; const Value: TTypeDiscount);
    procedure SetTypeStatusOrd(APk: Integer; const Value: TDataRow);
    procedure SetDeliveryPeriod(APk: Integer; const Value: TDataRow);
    procedure SetTypeFreight(APk: Integer; const Value: TDataRow);
    procedure SetParamsPed(APk: Integer; const Value: TDataRow);
    procedure SetPaymentWay(APk: Integer; const Value: TDataRow);
    procedure SetOrder(APk: Integer; const Value: TOrder);
    procedure SetOrderItems(APk: Integer; const Value: TOrderItems);
    procedure SetOrderMessages(APk: Integer; const Value: TOrderMessages);
    procedure SetOrderHistorics(APk: Integer; const Value: TOrderHistorics);
    procedure SetOrderLinks(APk: Integer; const Value: TOrderLinks);
    procedure SetOrderDiscounts(APk: Integer; const Value: TDiscounts);
    procedure SetOrderInstallments(APk: Integer; const Value: TInstallments);
    procedure SetOrderDelivery(APk: Integer; const Value: TOrder);

//    function SaveAllOrders(AOrder: TOrder; AMode: TDBMode;
//      AMulti: Boolean): TOrderLinks;
  public
    { Public declarations }
    dsStatus     : TDBMode;
    function  GetProdRef(const ACompanyID, AOwnerID: Integer;
                const AProductID: string; const APriceTabID, AGrMovID, ATpMovID,
                ATypeVol, ATypeCode: SmallInt; const AQtdProd: Double): TStrings;
    function  LoadParamsOrders(var ARec: TDefaultRecord): Boolean;
    function  LoadTypeDocuments(ATypeDoc: TDocumentType): TStrings;
    function  LoadStates(ACountry: TCountry): TStrings;
    function  LoadCities(AState: TState): TStrings;
    function  LoadClassifications(AType: Integer): TStrings;
    function  LoadCarrier: TStrings;
    function  LoadGroupMov: TStrings;
    function  LoadMovimentEstq(const AType: TInOut): TStrings;
    function  LoadNatureOperation(const AType: TInOut; const AOrgm: TOrgmNatOpe): TStrings;
    function  LoadTabPrices: TStrings;
    function  LoadTypeDelivery: TStrings;
    function  LoadMovement(AOrderTypes: TOrderTypes; APkGMov: Integer;
                ANatOpe: Boolean = False): TStrings;
    function  LoadOwner(AOrderType: TOrderType; const AName: string;
                ATCad: TTypeOwner = toAll; ATName: Boolean = False): TStrings;
    function  LoadVendors(ARep: Boolean): TStrings;
    function  LoadAgents: TStrings;
    function  LoadPorts(APkCountry: Integer): TStrings;
    function  LoadDepartament: TStrings;
    function  LoadStatusType(AFkGMov: Integer): TStrings;
    function  LoadDiscounts(AFkGMov: Integer): TStrings;
    function  LoadFinalizers(const AFkTPgto: Integer): TStrings;
    function  LoadUnits: TStrings;
    function  LoadComponents(APkProd: Integer): TStrings;
    function  LoadFinish(APkCompany, APkProd: Integer; AComponent: TComponentType): TStrings;
    function  LoadMaterial(APkFinish, APkReference: Integer): TStrings;
    function  LoadPurchaseOrders(const AFkSupplier: Integer): TStrings;
    function  LoadTypePayment(APkGMov: Integer): TStrings;
    property  MultiCompany                : Boolean            read FMultiCompany        write FMultiCompany;
    property  PkGroupMoviment             : Integer            read FPkGroupMoviment     write FPkGroupMoviment;
    property  DeliveryPeriod   [APk: Integer]: TDataRow        read GetDeliveryPeriod    write SetDeliveryPeriod;
    property  GroupMoviment    [APk: Integer]: TMovement       read GetGroupMovement     write SetGroupMovement;
    property  Order            [APk: Integer]: TOrder          read GetOrder             write SetOrder;
    property  OrderHistorics   [APk: Integer]: TOrderHistorics read GetOrderHistorics    write SetOrderHistorics;
    property  OrderItems       [APk: Integer]: TOrderItems     read GetOrderItems        write SetOrderItems;
    property  OrderInstallments[APk: Integer]: TInstallments   read GetOrderInstallments write SetOrderInstallments;
    property  OrderLinks       [APk: Integer]: TOrderLinks     read GetOrderLinks        write SetOrderLinks;
    property  OrderMessages    [APk: Integer]: TOrderMessages  read GetOrderMessages     write SetOrderMessages;
    property  OrderDiscounts   [APk: Integer]: TDiscounts      read GetOrderDiscounts    write SetOrderDiscounts;
    property  ParamsPed        [APk: Integer]: TDataRow        read GetParamsPed         write SetParamsPed;
    property  PaymentWay       [APk: Integer]: TDataRow                                  write SetPaymentWay;
    property  TypeDiscount     [APk: Integer]: TTypeDiscount   read GetTypeDiscount      write SetTypeDiscount;
    property  TypeFreight      [APk: Integer]: TDataRow        read GetTypeFreight       write SetTypeFreight;
    property  TypeMoviment     [APk: Integer]: TMovement       read GetTypeMovement      write SetTypeMovement;
    property  TypePayment      [APk: Integer]: TTypePayment    read GetTypePayment       write SetTypePayment;
    property  TypeStatusOrd    [APk: Integer]: TDataRow        read GetTypeStatusOrd     write SetTypeStatusOrd;
  end;

var
  dmSysPed: TdmSysPed;

implementation

uses AltPass, Funcoes, Autor, FuncoesDB, ModelTyp, PedArqSql, Dado,
  CmmConst, SqlComm, ArqCnst, Math, TSysEstq, TypInfo;

{$R *.DFM}

procedure TdmSysPed.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

procedure TdmSysPed.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i].InheritsFrom(TDataSet) then
    begin
      if TDataSet(Components[i]).Active then
        TDataSet(Components[i]).Close;
    end
  end;
end;

// functions to load data into TStrings

function  TdmSysPed.LoadTypeDocuments(ATypeDoc: TDocumentType): TStrings;
var
  aItem: TTypeDocument;
  aMS  : TMemoryStream;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTipoDocumentos);
  Dados.StartTransaction(qrSqlAux);
  aMS := TMemoryStream.Create;
  try
    if (ATypeDoc = dtAll) then
      qrSqlAux.ParamByName('FlagTDoc').AsInteger := -1
    else
      qrSqlAux.ParamByName('FlagTDoc').AsInteger := Ord(ATypeDoc);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    qrSqlAux.First;
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      aItem                := TTypeDocument.Create;
      aItem.PkTypeDocument := qrSqlAux.FieldByName('PK_TIPO_DOCUMENTOS').AsInteger;
      aItem.DscTDoc        := qrSqlAux.FieldByName('DSC_TDOC').AsString;
      aItem.FlagExt        := Boolean(qrSqlAux.FieldByName('FLAG_EXT').AsInteger);
      aItem.FlagTDoc       := TDocumentType(qrSqlAux.FieldByName('FLAG_TDOC').AsInteger);
      aItem.QtdItem        := qrSqlAux.FieldByName('QTD_ITM').AsInteger;
      aMS.Position         := 0;
      TBlobField(qrSqlAux.FieldByName('OBS_TDOC')).SaveToStream(aMS);
      aMS.Position         := 0;
      aItem.ObsDoc.LoadFromStream(aMS);
      aMS.Clear;
      aItem.cbIndex        := Result.AddObject(aItem.DscTDoc, aItem);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
    FreeAndNil(aMS);
  end;
end;

function  TdmSysPed.LoadStates(ACountry: TCountry): TStrings;
var
  aItem: TState;
begin
  Result := TStringList.Create;
  if ACountry = nil then exit;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlEstados);
  Dados.StartTransaction(qrSqlAux);
  if qrSqlAux.Params.FindParam('FkPaises') <> nil then
    qrSqlAux.Params.FindParam('FkPaises').AsInteger := ACountry.PKCountry;
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        aItem         := TState.Create;
        aItem.FkCountry.Assign(ACountry);
        aItem.PkState := qrSqlAux.FindField('PK_ESTADOS').AsString;
        aItem.DscUF   := qrSqlAux.FindField('DSC_UF').AsString;
        aItem.cbIndex := Result.AddObject(aItem.DscUF, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysPed.LoadCities(AState: TState): TStrings;
var
  aItem: TCity;
begin
  Result := TStringList.Create;
  if AState = nil then exit;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlMunicipios);
  Dados.StartTransaction(qrSqlAux);
  if qrSqlAux.Params.FindParam('FkPaises') <> nil then
    qrSqlAux.Params.FindParam('FkPaises').AsInteger  := AState.FkCountry.PkCountry;
  if qrSqlAux.Params.FindParam('FkEstados') <> nil then
    qrSqlAux.Params.FindParam('FkEstados').AsString := AState.PkState;
  if not qrSqlAux.Active then qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        aItem         := TCity.Create;
        aItem.FkState.Assign(AState);
        aItem.PkCity  := qrSqlAux.FieldByName('PK_MUNICIPIOS').AsInteger;
        aItem.DscMun  := qrSqlAux.FieldByName('DSC_MUN').AsString;
        aItem.CepMun  := qrSqlAux.FieldByName('CEP_MUN').AsInteger;
        aItem.cbIndex := Result.AddObject(aItem.DscMun, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysPed.LoadCarrier: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTransportadoras);
  Dados.StartTransaction(qrSqlAux);
  try
    if not qrSqlAux.Active then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while not qrSqlAux.EOF do
    begin
      Result.AddObject(qrSqlAux.FieldByName('RAZ_SOC').AsString,
        TObject(qrSqlAux.FieldByName('PK_CADASTROS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysPed.LoadGroupMov: TStrings;
var
  aItem: TMovement;
begin
  Result := TStringList.Create;
  if qrTypeMovement.Active then qrTypeMovement.Close;
  qrTypeMovement.SQL.Clear;
  qrTypeMovement.SQL.Add(SqlGruposMovements);
  if not qrTypeMovement.Active then qrTypeMovement.Open;
  Result.Add('<Nenhum>');
  while not (qrTypeMovement.Eof) do
  begin
    aItem                  := TMovement.Create;
    aItem.DscMov           := qrTypeMovement.FieldByName('DSC_GMOV').AsString;
    aItem.FlagCns          := False;
    aItem.FlagCod          := TCodeType(qrTypeMovement.FieldByName('FLAG_COD').AsInteger);
    aItem.FlagDev          := Boolean(qrTypeMovement.FieldByName('FLAG_DEV').AsInteger);
    aItem.FlagDspa         := Boolean(qrTypeMovement.FieldByName('FLAG_DSPA').AsInteger);
    aItem.FlagDsti         := TOrigimDestination(qrTypeMovement.FieldByName('FLAG_ORGM').AsInteger);
    aItem.FlagES           := TInOut(qrTypeMovement.FieldByName('FLAG_ES').AsInteger);
    aItem.FlagEstq         := Boolean(qrTypeMovement.FieldByName('FLAG_ESTQ').AsInteger);
    aItem.FlagGFin         := Boolean(qrTypeMovement.FieldByName('FLAG_GFIN').AsInteger);
    aItem.FlagGrnt         := TTypeGuarantee(qrTypeMovement.FieldByName('FLAG_GRNT').AsInteger);
    aItem.FlagOrgm         := TOrigimDestination(qrTypeMovement.FieldByName('FLAG_DSTI').AsInteger);
    aItem.PkGroupMovement  := qrTypeMovement.FieldByName('PK_GRUPOS_MOVIMENTOS').AsInteger;
    aItem.cbIndex          := Result.AddObject(aItem.DscMov, aItem);
    qrTypeMovement.Next;
  end;
  if qrTypeMovement.Active then qrTypeMovement.Close;
end;

function TdmSysPed.LoadTabPrices: TStrings;
var
  aItem: TPriceTable;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTabPrecos);
  if not qrSqlAux.Active then qrSqlAux.Open;
  Result.Add('<Nenhum>');
  while not (qrSqlAux.Eof) do
  begin
    aItem := TPriceTable.Create(nil);
    aItem.PkPriceTable := qrSqlAux.FieldByName('PK_TABELA_PRECOS').AsInteger;
    aItem.DscTab       := qrSqlAux.FieldByName('DSC_TAB').AsString;
    aItem.DtaIni       := qrSqlAux.FieldByName('DTA_INI').AsDateTime;
    aItem.DtaFin       := qrSqlAux.FieldByName('DTA_FIN').AsDateTime;
    aItem.FlagDefTab   := Boolean(qrSqlAux.FieldByName('FLAG_DEFTAB').AsInteger);
    aItem.FlagPrm      := False;
    aItem.PercDsct     := qrSqlAux.FieldByName('PERC_DSCT').AsFloat;
    aItem.cbIndex      := Result.AddObject(aItem.DscTab, aItem);
    qrSqlAux.Next;
  end;
  if qrSqlAux.Active then qrSqlAux.Close;
end;

function TdmSysPed.LoadTypeDelivery: TStrings;
begin
  Result := TStringList.Create;
  if qrDeliveryPeriod.Active then qrDeliveryPeriod.Close;
  qrDeliveryPeriod.SQL.Clear;
  qrDeliveryPeriod.SQL.Add(SqlTipoEntrega);
  if not qrDeliveryPeriod.Active then qrDeliveryPeriod.Open;
  Result.Add('<Nenhum>');
  while not (qrDeliveryPeriod.Eof) do
  begin
    Result.AddObject(qrDeliveryPeriod.FieldByName('DSC_PRZE').AsString,
      TObject(qrDeliveryPeriod.FieldByName('PK_TIPO_PRAZO_ENTREGA').AsInteger));
    qrDeliveryPeriod.Next;
  end;
  if qrDeliveryPeriod.Active then qrDeliveryPeriod.Close;
end;

function TdmSysPed.GetOrder(APk: Integer): TOrder;
begin
  Result := TOrder.Create(Dados.DecimalPlaces);
  if (qrOrders.Active) then qrOrders.Close;
  qrOrders.SQL.Clear;
  qrOrders.SQL.Add(SqlPedidos);
  Dados.StartTransaction(qrOrders);
  try
    qrOrders.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
    qrOrders.ParamByName('PkPedidos').AsInteger      := APk;
    if (not qrOrders.Active) then qrOrders.Open;
    with Result do
    begin
      Loading                                := True;
      FkCompany.PkCompany                    := Dados.PkCompany;
      PkOrder                                := APk;
      FkOrderStatus.PkOrderStatus            := qrOrders.FieldByName('FK_TIPO_STATUS_PEDIDOS').AsInteger;
      FkOrderStatus.FkMovement.PkTypeMovement := qrOrders.FieldByName('FK_TIPO_MOVIMENTOS').AsInteger;
      FkMovement.PkGroupMovement             := qrOrders.FieldByName('FK_GRUPOS_MOVIMENTOS').AsInteger;
      FkMovement.PkTypeMovement              := qrOrders.FieldByName('FK_TIPO_MOVIMENTOS').AsInteger;
      FkOwner.PkCadastros                    := qrOrders.FieldByName('FK_CADASTROS').AsInteger;
      NumVol                                 := qrOrders.FieldByName('NUM_VOL').AsInteger;
      TipoVol                                := qrOrders.FieldByName('TIPO_VOL').AsString;
      FlagEntrParc                           := Boolean(qrOrders.FieldByName('FLAG_ENTR_PARC').AsInteger);
      FlagEntrParc                           := Boolean(qrOrders.FieldByName('FLAG_ENTR_PARC').AsInteger);
      FlagCPrvE                              := Boolean(qrOrders.FieldByName('FLAG_CPRVE').AsInteger);
      FlagImp                                := Boolean(qrOrders.FieldByName('FLAG_IMP').AsInteger);
      FlagProd                               := Boolean(qrOrders.FieldByName('FLAG_PROD').AsInteger);
      FlagDtaBas                             := TBaseDate(qrOrders.FieldByName('FLAG_DTABAS').AsInteger);
      QtdVol                                 := qrOrders.FieldByName('QTD_VOL').AsInteger;
      DtaPed                                 := qrOrders.FieldByName('DTA_PED').AsDateTime;
      DtaRecb                                := qrOrders.FieldByName('DTA_RECB').AsDateTime;
      DtaLib                                 := qrOrders.FieldByName('DTA_LIB').AsDateTime;
      DtaEntr                                := qrOrders.FieldByName('DTA_ENTR').AsDateTime;
      DtaCanc                                := qrOrders.FieldByName('DTA_CANC').AsDateTime;
      DtaBas                                 := qrOrders.FieldByName('DTA_BAS').AsDateTime;
      DtaFat                                 := qrOrders.FieldByName('DTA_FAT').AsDateTime;
      MesPrevEntr                            := qrOrders.FieldByName('MES_PREV_ENTR').AsInteger;
      AnoPrevEntr                            := qrOrders.FieldByName('ANO_PREV_ENTR').AsInteger;
      NumExtr                                := qrOrders.FieldByName('NUM_EXTR').AsString;
      NumProForma                            := qrOrders.FieldByName('NUM_PRO_FORMA').AsInteger;
      FkTypePayment.PkTypePgto               := qrOrders.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
      FkTypeDiscount.PkTypeDiscount          := qrOrders.FieldByName('FK_TIPO_DESCONTOS').AsInteger;
      FkVendor.PkCadastros                   := qrOrders.FieldByName('FK_VW_VENDEDORES').AsInteger;
      FkRepresentant.PkCadastros             := qrOrders.FieldByName('FK_VW_REPRESENTANTES').AsInteger;
      FkCarrier.PkCadastros                  := qrOrders.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
      FkAgent.PkCadastros                    := qrOrders.FieldByName('FK_VW_AGENTE').AsInteger;
      FkPortoDst                             := qrOrders.FieldByName('FK_PORTOS_DST').AsInteger;
      FkPortoEmb                             := qrOrders.FieldByName('FK_PORTOS_EMB').AsInteger;
      FkPurchaseOrder                        := qrOrders.FieldByName('FK_ORDEM_COMPRA').AsInteger;
      FkPriceTable.PkPriceTable              := qrOrders.FieldByName('FK_TABELA_PRECOS').AsInteger;
      FkDeliveryPeriod                       := qrOrders.FieldByName('FK_TIPO_PRAZO_ENTREGA').AsInteger;
      FkPaymentWay.PkPaymentWay              := qrOrders.FieldByName('FK_FINALIZADORAS').AsInteger;
      VlrFret                                := qrOrders.FieldByName('VLR_FRET').AsFloat;
      VlrSeg                                 := qrOrders.FieldByName('VLR_SEG').AsFloat;
      VlrEntr                                := qrOrders.FieldByName('VLR_ENTR').AsFloat;
      DspAces                                := qrOrders.FieldByName('DSP_ACES').AsFloat;
      PesLiq                                 := qrOrders.FieldByName('PES_LIQ').AsFloat;
      PesBru                                 := qrOrders.FieldByName('PES_BRU').AsFloat;
      OrderItems                             := dmSysPed.OrderItems[APk];
      OrderMessages                          := dmSysPed.OrderMessages[APk];
      OrderHistorics                         := dmSysPed.OrderHistorics[APk];
      OrderLinks                             := dmSysPed.OrderLinks[APk];
      Discounts                              := dmSysPed.OrderDiscounts[APk];
      OrderInstallments                      := dmSysPed.OrderInstallments[APk];
      GetOrderDelivery(Result);
      Loading                                := False;
    end;
  finally
    if (qrOrders.Active) then qrOrders.Close;
    Dados.CommitTransaction(qrOrders);
  end;
end;

function  TdmSysPed.GetOrderItems(APk: Integer): TOrderItems;
var
  aItem: TOrderItem;
  aConf: TConfItem;
  aTax : TTaxDescription;
begin
  Result := TOrderItems.Create(nil);
  if qrOrderItems.Active then qrOrderItems.Close;
  qrOrderItems.SQL.Clear;
  qrOrderItems.SQL.Add(SqlPedidosItems);
  qrOrderItems.ParamByName('FkEmpresas').AsInteger    := Dados.PkCompany;
  qrOrderItems.ParamByName('FkPedidos').AsInteger     := APk;
  if not qrOrderItems.Active then qrOrderItems.Open;
  try
  // move data to Result
    while (not qrOrderItems.Eof) do
    begin
      aItem                            := Result.Add;
      aItem.FkProduct.ProductCost.FkCompany.PkCompany := Dados.PkCompany;
      aItem.FkProduct.PkProducts       := qrOrderItems.FieldByName('R_FK_PRODUTOS').AsInteger;
      aItem.FkClassification           := qrOrderItems.FieldByName('R_FK_CLASSIFICACAO').AsInteger;
      aItem.FkProductionLoad           := qrOrderItems.FieldByName('R_FK_CARGAS_PRODUCAO').AsInteger;
      aItem.FkLotacao                  := qrOrderItems.FieldByName('R_FK_LOTACOES').AsInteger;
      aItem.FkAlmox                    := qrOrderItems.FieldByName('R_FK_ALMOXARIFADOS').AsInteger;
      aItem.FkPriceTable.PkPriceTable  := qrOrderItems.FieldByName('R_FK_TABELA_PRECOS').AsInteger;
      aItem.FKUnit.PkUnit              := qrOrderItems.FieldByName('R_FK_UNIDADES').AsInteger;
      aItem.FkMovement.PkGroupMovement := qrOrderItems.FieldByName('R_FK_GRUPOS_MOVIMENTOS').AsInteger;
      aItem.FkMovement.PkTypeMovement  := qrOrderItems.FieldByName('R_FK_TIPO_MOVIMENTOS').AsInteger;
      aItem.FlagConf                   := Boolean(qrOrderItems.FieldByName('R_FLAG_CONF').AsInteger);
      aItem.FlagSrv                    := Boolean(qrOrderItems.FieldByName('R_FLAG_SRV').AsInteger);
      aItem.CodRef                     := qrOrderItems.FieldByName('R_REF_PRODUTO').AsString;
      aItem.FkProduct.DscProd          := qrOrderItems.FieldByName('R_DSC_PROD').AsString;
      aItem.FKUnit.MnmoUni             := qrOrderItems.FieldByName('R_MNMO_UNI').AsString;
      aItem.FkPriceTable.DscTab        := qrOrderItems.FieldByName('R_DSC_TAB').AsString;
      aItem.FKUnit.DscUni              := qrOrderItems.FieldByName('R_DSC_UNI').AsString;
      aItem.FkMovement.DscMov          := qrOrderItems.FieldByName('R_DSC_TMOV').AsString + ' - ' +
                                          qrOrderItems.FieldByName('R_DSC_GMOV').AsString;
      aItem.LotItem                    := qrOrderItems.FieldByName('R_DSC_ALMX').AsString + ' - ' +
                                          qrOrderItems.FieldByName('R_LOT_ITEM').AsString;
      aItem.SitTrib                    := qrOrderItems.FieldByName('R_SIT_TRIB').AsString;
      aItem.NumExtr                    := qrOrderItems.FieldByName('R_NUM_EXT').AsString;
      aItem.QtdItem                    := RoundTo(qrOrderItems.FieldByName('R_QTD_ITEM').AsFloat,
                                            (Dados.DecimalPlacesQtd * -1));
      with aItem.FkProduct.ProductPrices.Add do
        PreVda                         := RoundTo(qrOrderItems.FieldByName('R_VLR_TAB').AsFloat,
                                            (Dados.DecimalPlaces * -1));
      aItem.VlrUnit                    := RoundTo(qrOrderItems.FieldByName('R_VLR_UNIT').AsFloat,
                                            (Dados.DecimalPlaces * -1));
      aTax.TaxCode                     := qrOrderItems.FieldByName('R_COD_ISS_ECF').AsInteger;
      aTax.TaxPercent                  := qrOrderItems.FieldByName('R_ALQ_ISS').AsFloat;
      aItem.AlqIss                     := aTax;
      aTax.TaxCode                     := qrOrderItems.FieldByName('R_COD_ICMS_ECF').AsInteger;
      aTax.TaxPercent                  := qrOrderItems.FieldByName('R_ALQ_ICMS').AsFloat;
      aItem.AlqIcms                     := aTax;
      aTax.TaxCode                     := qrOrderItems.FieldByName('R_COD_ICMSS_ECF').AsInteger;
      aTax.TaxPercent                  := qrOrderItems.FieldByName('R_ALQ_ICMSS').AsFloat;
      aItem.AlqIcmss                     := aTax;
      aTax.TaxCode                     := qrOrderItems.FieldByName('R_COD_IPI_ECF').AsInteger;
      aTax.TaxPercent                  := qrOrderItems.FieldByName('R_ALQ_IPI').AsFloat;
      aItem.AlqIpi                     := aTax;
      aTax.TaxCode                     := qrOrderItems.FieldByName('R_COD_OTR_ECF').AsInteger;
      aTax.TaxPercent                  := qrOrderItems.FieldByName('R_ALQ_OTR').AsFloat;
      aItem.AlqOtr                     := aTax;
      aItem.VlrAcrDsct                 := qrOrderItems.FieldByName('R_VLR_ACR_DSCT').AsFloat;
      aItem.DtaLiq                     := qrOrderItems.FieldByName('R_DTA_LIQ').AsDateTime;
      aItem.DtaFat                     := qrOrderItems.FieldByName('R_DTA_FAT').AsDateTime;
      qrOrderItems.Next;
      if aItem.FlagConf then
      begin
        aConf                                 := aItem.ConfigItems.Add;
        aConf.FkComponentType.PkComponent     := qrOrderItems.FieldByName('R_FK_COMPONENTES').AsInteger;
        aConf.FkFinishType.PkFinishType       := qrOrderItems.FieldByName('R_FK_ACABAMENTOS').AsInteger;
        aConf.FkReferenceType.PkReferenceType := qrOrderItems.FieldByName('R_FK_TIPO_REFERENCIAS').AsInteger;
        aConf.FkComponentType.QtdComp         := qrOrderItems.FieldByName('R_QTD_COMP').AsInteger;
        aConf.FlagFrnCli                      := Boolean(qrOrderItems.FieldByName('R_FLAG_FRNCLI').AsInteger);
        aConf.FlagPend                        := Boolean(qrOrderItems.FieldByName('R_FLAG_PEND_C').AsInteger);
        aConf.FlagCntr                        := Boolean(qrOrderItems.FieldByName('R_FLAG_CNTR').AsInteger);
        aConf.FlagBxaStt                      := Boolean(qrOrderItems.FieldByName('R_FLAG_BXASTT_C').AsInteger);
        aConf.FkProduct.PkProducts            := qrOrderItems.FieldByName('R_FK_INSUMOS').AsInteger;
        aConf.CodRef                          := qrOrderItems.FieldByName('R_COD_REF').AsString;
        aConf.DscConf                         := qrOrderItems.FieldByName('R_DSC_CONF').AsString + ' - ' +
                                                 qrOrderItems.FieldByName('R_DSC_INS').AsString;
        aConf.FkFinishType.PreVda             := RoundTo(qrOrderItems.FieldByName('R_VLR_ITM').AsFloat,
                                                  (Dados.DecimalPlaces * -1));
        aConf.FkFinishType.QtdPdr             := qrOrderItems.FieldByName('R_QTD_INS').AsFloat;
        aConf.QtdParcial                      := qrOrderItems.FieldByName('R_QTD_COMP_TOT').AsInteger;
        aConf.PerDsctIns                      := qrOrderItems.FieldByName('R_PER_DSCT_INS').AsFloat;
        qrOrderItems.Next
      end;
    end;
  finally
    if qrOrderItems.Active then qrOrderItems.Close;
  end;
end;

function  TdmSysPed.GetOrderDiscounts(APk: Integer): TDiscounts;
begin
  Result := TDiscounts.Create(nil);
  if qrTypeDiscount.Active then qrTypeDiscount.Close;
  qrTypeDiscount.SQL.Clear;
  qrTypeDiscount.SQL.Add(SqlSelOrderDsct);
  qrTypeDiscount.ParamByName('FkEmpresas').AsInteger    := Dados.PkCompany;
  qrTypeDiscount.ParamByName('FkPedidos').AsInteger     := APk;
  if not qrTypeDiscount.Active then qrTypeDiscount.Open;
  try
  // move data to Result
    while (not qrTypeDiscount.Eof) do
    begin
      with Result.Add do
      begin
        DscDsct    := qrTypeDiscount.FieldByName('DSC_DSCT').AsString;
//        FkCategory := ;
//        FkCountry  := ;
//        FkState    := ;
        FlagDstq   := Boolean(qrTypeDiscount.FieldByName('FLAG_DSTQ').AsInteger);
        FlagTDsct  := TTypeOperation(qrTypeDiscount.FieldByName('FLAG_TDSCT').AsInteger);
        IdxDsct    := qrTypeDiscount.FieldByName('IDX_DSCT').AsFloat;
      end;
      qrTypeDiscount.Next;
    end;
  finally
    if qrTypeDiscount.Active then qrTypeDiscount.Close;
  end;
end;

function  TdmSysPed.GetOrderInstallments(APk: Integer): TInstallments;
begin
  Result := TInstallments.Create(nil);
  if qrPayOrder.Active then qrPayOrder.Close;
  qrPayOrder.SQL.Clear;
  qrPayOrder.SQL.Add(SqlSelPayOrder);
  qrPayOrder.ParamByName('FkEmpresas').AsInteger    := Dados.PkCompany;
  qrPayOrder.ParamByName('FkPedidos').AsInteger     := APk;
  if not qrPayOrder.Active then qrPayOrder.Open;
  try
  // move data to Result
    while (not qrPayOrder.Eof) do
    begin
      with Result.Add do
      begin
        DtaVenc := qrPayOrder.FieldByName('PK_PEDIDOS_PARCELAS').AsDateTime;
        VlrParc := RoundTo(qrPayOrder.FieldByName('VLR_PARC').AsFloat,
                    (Dados.DecimalPlaces * -2));
      end;
      qrPayOrder.Next;
    end;
  finally
    if qrPayOrder.Active then qrPayOrder.Close;
  end;
end;

function  TdmSysPed.GetOrderMessages(APk: Integer): TOrderMessages;
var
  aMS: TMemoryStream;
begin
  Result := TOrderMessages.Create(nil);
  if qrOrderMessage.Active then qrOrderMessage.Close;
  qrOrderMessage.SQL.Clear;
  qrOrderMessage.SQL.Add(SqlSelOrderMsg);
  qrOrderMessage.ParamByName('FkEmpresas').AsInteger    := Dados.PkCompany;
  qrOrderMessage.ParamByName('FkPedidos').AsInteger     := APk;
  if not qrOrderMessage.Active then qrOrderMessage.Open;
  aMS := TMemoryStream.Create;
  try
  // move data to Result
    while (not qrOrderMessage.Eof) do
    begin
      with Result.Add do
      begin
        DtHrMsg       := qrOrderMessage.FieldByName('DTHR_MSG').AsDateTime;
        DtHrRcbm      := qrOrderMessage.FieldByName('DTHR_RCBM').AsDateTime;
        FkDepartament := qrOrderMessage.FieldByName('FK_DEPARTAMENTOS').AsInteger;
        DscDpto       := qrOrderMessage.FieldByName('DSC_DPTO').AsString;
        aMS.Position := 0;
        TBlobField(qrOrderMessage.FieldByName('TEXT_MSG')).SaveToStream(aMS);
        aMS.Position := 0;
        TextMsg.LoadFromStream(aMS);
        aMS.Clear;
      end;
      qrOrderMessage.Next;
    end;
  finally
    if qrOrderMessage.Active then qrOrderMessage.Close;
    aMS.Free;
  end;
end;

function  TdmSysPed.GetOrderHistorics(APk: Integer): TOrderHistorics;
begin
  Result := TOrderHistorics.Create(nil);
  if qrOrderHistoric.Active then qrOrderHistoric.Close;
  qrOrderHistoric.SQL.Clear;
  qrOrderHistoric.SQL.Add(SqlSelOrderHist);
  qrOrderHistoric.ParamByName('FkEmpresas').AsInteger    := Dados.PkCompany;
  qrOrderHistoric.ParamByName('FkPedidos').AsInteger     := APk;
  if not qrOrderHistoric.Active then qrOrderHistoric.Open;
  try
  // move data to Result
    while (not qrOrderHistoric.Eof) do
    begin
      with Result.Add do
      begin
        DscHist    := qrOrderHistoric.FieldByName('DSC_HIST').AsString;
        DtHrHist   := qrOrderHistoric.FieldByName('DTHR_HIST').AsDateTime;
        FlagBxaStt := Boolean(qrOrderHistoric.FieldByName('FLAG_BXASTT').AsInteger);
        FkOrderStatus.PkOrderStatus := qrOrderHistoric.FieldByName('FK_TIPO_STATUS_PEDIDOS').AsInteger;
        FkOrderStatus.DscStt        := qrOrderHistoric.FieldByName('DSC_STT').AsString;
      end;
      qrOrderHistoric.Next;
    end;
  finally
    if qrOrderHistoric.Active then qrOrderHistoric.Close;
  end;
end;

function  TdmSysPed.GetOrderLinks(APk: Integer): TOrderLinks;
begin
  Result := TOrderLinks.Create(nil);
  if qrOrderLink.Active then qrOrderLink.Close;
  qrOrderLink.SQL.Clear;
  qrOrderLink.SQL.Add(SqlSelOrderLinks);
  qrOrderLink.ParamByName('FkEmpresas').AsInteger    := Dados.PkCompany;
  qrOrderLink.ParamByName('FkPedidos').AsInteger     := APk;
  if not qrOrderLink.Active then qrOrderLink.Open;
  try
  // move data to Result
    while (not qrOrderLink.Eof) do
    begin
      with Result.Add do
      begin
        FkCompany   := qrOrderLink.FieldByName('FK_EMPRESAS_VINC').AsInteger;
        FkDocument  := qrOrderLink.FieldByName('FK_PEDIDOS_VINC').AsInteger;
      end;
      qrOrderLink.Next;
    end;
  finally
    if qrOrderLink.Active then qrOrderLink.Close;
  end;
end;

procedure TdmSysPed.GetOrderDelivery(var Value: TOrder);
var
  aMS: TMemoryStream;
begin
  if qrDeliveryPeriod.Active then qrDeliveryPeriod.Close;
  qrDeliveryPeriod.SQL.Clear;
  qrDeliveryPeriod.SQL.Add(SqlPedidosEntrega);
  qrDeliveryPeriod.ParamByName('FkEmpresas').AsInteger    := Value.FkCompany.PkCompany;
  qrDeliveryPeriod.ParamByName('PkPedidos').AsInteger     := Value.PkOrder;
  aMS := TMemoryStream.Create;
  if not qrDeliveryPeriod.Active then qrDeliveryPeriod.Open;
  try
    Value.UfEntr  := qrDeliveryPeriod.FieldByName('UF_ENTR').AsString;
    Value.MunEntr := qrDeliveryPeriod.FieldByName('MUN_ENTR').AsInteger;
    aMS.Position   := 0;
    TBlobField(qrDeliveryPeriod.FieldByName('END_ENTR')).SaveToStream(aMS);
    aMS.Position   := 0;
    Value.EndEntr.LoadFromStream(aMS);
  finally
    if qrDeliveryPeriod.Active then qrDeliveryPeriod.Close;
    FreeAndNil(aMS);
  end;
end;

function TdmSysPed.LoadMovement(AOrderTypes: TOrderTypes; APkGMov: Integer;
  ANatOpe: Boolean = False): TStrings;
var
  aItem: TMovement;
begin
  if qrTypeMovement.Active then qrTypeMovement.Close;
  qrTypeMovement.SQL.Clear;
  qrTypeMovement.SQL.Add(SqlMovimentos);
  Result := TStringList.Create;
  if qrTypeMovement.Params.FindParam('FlagES') <> nil then
    if (otAll in AOrderTypes) then
      qrTypeMovement.ParamByName('FlagES').AsInteger := FLAG_ALL
    else
      if (otPurchaseOrder in AOrderTypes) then
        qrTypeMovement.ParamByName('FlagES').AsInteger := FLAG_ENTRADAS
      else
        qrTypeMovement.ParamByName('FlagES').AsInteger := FLAG_SAIDAS;
  if qrTypeMovement.Params.FindParam('FlagDev') <> nil then
    qrTypeMovement.ParamByName('FlagDev').AsInteger := -1;
  if qrTypeMovement.Params.FindParam('PkGruposMovimentos') <> nil then
    qrTypeMovement.ParamByName('PkGruposMovimentos').AsInteger := APkGMov;
  if not qrTypeMovement.Active then qrTypeMovement.Open;
  Result.Add('<Nenhum>');
  while not (qrTypeMovement.EOF) do
  begin
    aItem                  := TMovement.Create;
    aItem.DscMov           := qrTypeMovement.FieldByName('DSC_GMOV').AsString + ' ==> ' +
                              qrTypeMovement.FieldByName('DSC_TMOV').AsString;
    aItem.FlagCns          := False;
    aItem.FlagCod          := TCodeType(qrTypeMovement.FieldByName('FLAG_COD').AsInteger);
    aItem.FlagDev          := Boolean(qrTypeMovement.FieldByName('FLAG_DEV').AsInteger);
    aItem.FlagDspa         := Boolean(qrTypeMovement.FieldByName('FLAG_DSPA').AsInteger);
    aItem.FlagDsti         := TOrigimDestination(qrTypeMovement.FieldByName('FLAG_ORGM').AsInteger);
    aItem.FlagES           := TInOut(qrTypeMovement.FieldByName('FLAG_ES').AsInteger);
    aItem.FlagEstq         := Boolean(qrTypeMovement.FieldByName('FLAG_ESTQ').AsInteger);
    aItem.FlagGFin         := Boolean(qrTypeMovement.FieldByName('FLAG_GFIN').AsInteger);
    aItem.FlagGrnt         := TTypeGuarantee(qrTypeMovement.FieldByName('FLAG_GRNT').AsInteger);
    aItem.FlagLdv          := Boolean(qrTypeMovement.FieldByName('FLAG_LDV').AsInteger);
    aItem.FlagCns          := Boolean(qrTypeMovement.FieldByName('FLAG_CNS').AsInteger);
    aItem.FlagOrgm         := TOrigimDestination(qrTypeMovement.FieldByName('FLAG_DSTI').AsInteger);
    aItem.NatOpeDe         := qrTypeMovement.FieldByName('NAT_OPE_DE').AsString;
    aItem.NatOpeEx         := qrTypeMovement.FieldByName('NAT_OPE_EX').AsString;
    aItem.NatOpeFe         := qrTypeMovement.FieldByName('NAT_OPE_FE').AsString;
    aItem.PkGroupMovement  := qrTypeMovement.FieldByName('PK_GRUPOS_MOVIMENTOS').AsInteger;
    aItem.PkTypeMovement   := qrTypeMovement.FieldByName('PK_TIPO_MOVIMENTOS').AsInteger;
    if ANatOpe then
      aItem.cbIndex        := Result.AddObject(aItem.DscMov + ' - ' + aItem.NatOpeDe +
                                '/' + aItem.NatOpeFe + '/' + aItem.NatOpeEx, aItem)
    else
      aItem.cbIndex        := Result.AddObject(aItem.DscMov, aItem);
    qrTypeMovement.Next;
  end;
  if qrTypeMovement.Active then qrTypeMovement.Close;
end;

function TdmSysPed.LoadOwner(AOrderType: TOrderType; const AName: string;
  ATCad: TTypeOwner = toAll; ATName: Boolean = False): TStrings;
var
  ASql : string;
  aItem: TOwner;
  aRpt : Boolean;
const
  SqlJuridica  = 'select * from VW_CLIENTES ' + NL +
                 ' where FLAG_TCAD = 0 ';

  SqlFisica    = 'select * from VW_CLIENTES ' + NL +
                 ' where FLAG_TCAD = 1 ';

  SqlAll       = 'select * from VW_CLIENTES';

  SqlOrder     = ' order by PK_CATEGORIAS, DSC_ALIAS, RAZ_SOC';

  SqlSupplier  = 'select * from VW_FORNECEDORES';

  SqlExport    = 'select * from VW_CLIENTES_EXPORTACAO ' + NL +
                 ' where PK_EMPRESAS = :PkEmpresas     ';
begin
  Result := TStringList.Create;
  Result.Add('<Nenhum>');
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  case ATCad of
    toCompany: ASql := SqlJuridica;
    toPeople : ASql := SqlFisica;
    toAll    : ASql := SqlAll;
  end;
  if (otPurchaseOrder = AOrderType) then
    qrSqlAux.SQL.Add(SqlSupplier)
  else
    if (otExportation = AOrderType) then
      qrSqlAux.SQL.Add(SqlExport)
    else
      qrSqlAux.SQL.Add(ASql);
  if AName <> '' then
    if Pos('where', qrSqlAux.SQL.Text) > 0 then
      qrSqlAux.SQL.Add('   and RAZ_SOC like :RazSoc')
    else
      qrSqlAux.SQL.Add(' where RAZ_SOC like :RazSoc');
  qrSqlAux.SQL.Add(SqlOrder);
  Dados.CommitTransaction(qrSqlAux);
  try
    if (qrSqlAux.Params.FindParam('RazSoc') <> nil) then
      qrSqlAux.ParamByName('RazSoc').AsString := '%' + AName + '%';
    if (qrSqlAux.Params.FindParam('PkEmpresas') <> nil) then
      qrSqlAux.ParamByName('PkEmpresas').AsInteger := Dados.PkCompany;
    if not qrSqlAux.Active then qrSqlAux.Open;
    while not qrSqlAux.Eof do
    begin
      aItem       := TOwner.Create;
      with aItem.Address do
      begin
        CepAdd           := qrSqlAux.FieldByName('CEP_CAD').AsInteger;
        CmpEnd           := qrSqlAux.FieldByName('CMP_END').AsString;
        CxpAdd           := qrSqlAux.FieldByName('CXP_CAD').AsString;
        EndAdd           := qrSqlAux.FieldByName('END_CAD').AsString;
        with aItem.Address.FkCity do
          PkCity         := qrSqlAux.FieldByName('FK_MUNICIPIOS').AsInteger;
        with aItem.Address.FkCity.FkState do
          PkState        := qrSqlAux.FieldByName('FK_ESTADOS').AsString;
        with aItem.Address.FkCity.FkState.FkCountry do
          PKCountry      := qrSqlAux.FieldByName('FK_PAISES').AsInteger;
        NumAdd           := qrSqlAux.FieldByName('NUM_END').AsInteger;
      end;
      aItem.AreaAtu      := qrSqlAux.FieldByName('AREA_ATU').AsString;
      if (otPurchaseOrder <> AOrderType) then
      begin
        with aItem.Customer do
        begin
          DsctAtc          := qrSqlAux.FieldByName('DSCT_ATC').AsFloat;
          DsctAut          := qrSqlAux.FieldByName('DSCT_AUT').AsFloat;
          FkBank.PkBank    := qrSqlAux.FieldByName('FK_BANCOS').AsInteger;
          FkDeliveryPeriod := qrSqlAux.FieldByName('FK_BANCOS').AsInteger;
          FlagCnsm         := Boolean(qrSqlAux.FieldByName('FLAG_CNSM').AsInteger);
          FlagDtaBas       := TBaseDate(qrSqlAux.FieldByName('FLAG_DTABAS').AsInteger);
          FlagPAbr         := Boolean(qrSqlAux.FieldByName('FLAG_PABR').AsInteger);
          FlagPend         := Boolean(qrSqlAux.FieldByName('FLAG_PENP').AsInteger);
          LimCred          := qrSqlAux.FieldByName('LIM_CRD').AsFloat;
          OpeAut           := qrSqlAux.FieldByName('OPE_AUT').AsString;
          OpeLib           := qrSqlAux.FieldByName('OPE_LIB').AsString;
          DiaEms           := qrSqlAux.FieldByName('DIA_EMS').AsInteger;
          FkCarrier        := qrSqlAux.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
          FkRepresentant   := qrSqlAux.FieldByName('FK_VW_REPRESENTANTES').AsInteger;
          FkVendor         := qrSqlAux.FieldByName('FK_VW_VENDEDORES').AsInteger;
          FkPaymentWay.PkPaymentWay     := qrSqlAux.FieldByName('FK_FINALIZADORAS').AsInteger;
          FkTypePayment.PkTypePgto      := qrSqlAux.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
          FkPriceTable.PkPriceTable     := qrSqlAux.FieldByName('FK_TABELA_PRECOS').AsInteger;
          FkTypeDiscount.PkTypeDiscount := qrSqlAux.FieldByName('FK_TIPO_DESCONTOS').AsInteger;
        end;
      end;
      aItem.DocPri       := qrSqlAux.FieldByName('DOC_PRI').AsString;
      aItem.DocSec       := qrSqlAux.FieldByName('DOC_SEQ').AsString;
      aItem.FlagEtq      := Boolean(qrSqlAux.FieldByName('FLAG_ETQ').AsInteger);
      aItem.FlagTCad     := TTypeOwner(qrSqlAux.FieldByName('FLAG_TCAD').AsInteger);
      aItem.NomFan       := qrSqlAux.FieldByName('DSC_ALIAS').AsString;
      aItem.FkAlias      := qrSqlAux.FieldByName('FK_TIPO_ALIAS').AsInteger;
      aItem.PkCadastros  := qrSqlAux.FieldByName('PK_CADASTROS').AsInteger;
      aItem.RazSoc       := qrSqlAux.FieldByName('RAZ_SOC').AsString;
      if (otPurchaseOrder = AOrderType) then
      begin
        with aItem.Supplier do
        begin
          FkAgent        := qrSqlAux.FieldByName('FK_VW_CADASTROS').AsInteger;
          FkCarrier      := qrSqlAux.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
          FkPortDst      := qrSqlAux.FieldByName('FK_PORTOS__DST').AsInteger;
          FkPortEmb      := qrSqlAux.FieldByName('FK_PORTOS__EMB').AsInteger;
          FkTypeDiscount := qrSqlAux.FieldByName('FK_DESCONTOS').AsInteger;
          FkTypePayment.PkTypePgto := qrSqlAux.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
          FlagProdDef    := Boolean(qrSqlAux.FieldByName('FLAG_PROD_DEF').AsInteger);
          FlagTrn        := Boolean(qrSqlAux.FieldByName('FLAG_TRN').AsInteger);
          FkTypeFraction := qrSqlAux.FieldByName('FK_TIPO_TABELA_FRACOES').AsInteger;
          NomVnd         := qrSqlAux.FieldByName('NOM_VND').AsString;
        end; // with
      end; // if
      if (aItem.NomFan = '') then
        if (ATName) then
          aItem.Clear
        else
          aItem.cbIndex      := Result.AddObject(aItem.RazSoc, aItem)
      else
        if (ATName) then
          aItem.cbIndex    := Result.AddObject(aItem.NomFan, aItem)
        else
          aItem.cbIndex    := Result.AddObject(aItem.NomFan + ' - ' + aItem.RazSoc, aItem);
      aRpt := ATName; // if is to show Nick Name only
      repeat
        qrSqlAux.Next;
        // if is to show Nick Name only then to verify if DSC_ALIAS is null or
        // DSC_ALIAS equal to prior nick name storing result in aRcp variable
        if aRpt then aRpt := ((qrSqlAux.FieldByName('DSC_ALIAS').AsString = '') or
                              (aItem.NomFan = qrSqlAux.FieldByName('DSC_ALIAS').AsString));
      until ((not aRpt) or (qrSqlAux.Eof)); // True show next record
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.StartTransaction(qrSqlAux);
  end;
end;

function TdmSysPed.LoadVendors(ARep: Boolean): TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  if ARep then
    qrSqlAux.SQL.Add(SqlRepresentantes)
  else
    qrSqlAux.SQL.Add(SqlVendedores);
  Dados.StartTransaction(qrSqlAux);
  try
    if not qrSqlAux.Active then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while not qrSqlAux.EOF do
    begin
      Result.AddObject(qrSqlAux.FieldByName('RAZ_SOC').AsString,
        TObject(qrSqlAux.FieldByName('PK_CADASTROS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysPed.LoadAgents: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlAgentes);
  if not qrSqlAux.Active then qrSqlAux.Open;
  Result.Add('<Nenhum>');
  while not qrSqlAux.EOF do
  begin
    Result.AddObject(qrSqlAux.FieldByName('RAZ_SOC').AsString,
      TObject(qrSqlAux.FieldByName('PK_CADASTROS').AsInteger));
    qrSqlAux.Next;
  end;
  if qrSqlAux.Active then qrSqlAux.Close;
end;

function TdmSysPed.LoadPorts(APkCountry: Integer): TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlPortos);
  qrSqlAux.ParamByName('FkPaises').AsInteger := APkCountry;
  if not qrSqlAux.Active then qrSqlAux.Open;
  Result.Add('<Nenhum>');
  while not qrSqlAux.EOF do
  begin
    Result.AddObject(qrSqlAux.FieldByName('DSC_PORTO').AsString,
      TObject(qrSqlAux.FieldByName('PK_PORTOS').AsInteger));
    qrSqlAux.Next;
  end;
  if qrSqlAux.Active then qrSqlAux.Close;
end;

function TdmSysPed.LoadDepartament: TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlDepartamentos);
  if not qrSqlAux.Active then qrSqlAux.Open;
  Result.Add('<Nenhum>');
  while not qrSqlAux.EOF do
  begin
    Result.AddObject(qrSqlAux.FieldByName('DSC_DPTO').AsString,
      TObject(qrSqlAux.FieldByName('PK_DEPARTAMENTOS').AsInteger));
    qrSqlAux.Next;
  end;
  if qrSqlAux.Active then qrSqlAux.Close;
end;

function TdmSysPed.LoadTypePayment(APkGMov: Integer): TStrings;
var
  aItem: TTypePayment;
begin
  Result := TStringList.Create;
  if qrTypePayment.Active then qrTypePayment.Close;
  qrTypePayment.SQL.Clear;
  qrTypePayment.SQL.Add(SqlTypePayments);
  if qrTypePayment.Params.FindParam('FkGruposMovimentos') <> nil then
    qrTypePayment.ParamByName('FkGruposMovimentos').AsInteger := APkGMov;
  if not qrTypePayment.Active then qrTypePayment.Open;
  Result.Add('<Nenhum>');
  while not qrTypePayment.EOF do
  begin
    aItem              := TTypePayment.Create;
    aItem.PkTypePgto   := qrTypePayment.FieldByName('PK_TIPO_PAGAMENTOS').AsInteger;
    aItem.DscTPgt      := qrTypePayment.FieldByName('DSC_TPG').AsString;
    aItem.FlagBaseDate := TBaseDate(qrTypePayment.FieldByName('FLAG_BDATE').AsInteger);
    aItem.FlagBlock    := Boolean(qrTypePayment.FieldByName('FLAG_BLOQ').AsInteger);
    aItem.FlagTInt     := TIntervalPay(qrTypePayment.FieldByName('FLAG_TINTV').AsInteger);
    aItem.FlagTVda     := TTypeSale(qrTypePayment.FieldByName('FLAG_TVDA').AsInteger);
    aItem.cbIndex      := Result.AddObject(aItem.DscTPgt, aItem);
    qrTypePayment.Next;
  end;
  if qrTypePayment.Active then qrTypePayment.Close;
end;

function TdmSysPed.LoadStatusType(AFkGMov: Integer): TStrings;
var
  aItem: TOrderStatus;
begin
  Result := TStringList.Create;
  if qrTypeOrder.Active then qrTypeOrder.Close;
  qrTypeOrder.SQL.Clear;
  qrTypeOrder.SQL.Add(SqlTipoStatus);
  qrTypeOrder.Params.FindParam('FkGruposMovimentos').AsInteger := AFkGMov;
  if not qrTypeOrder.Active then qrTypeOrder.Open;
  Result.Add('<Nenhum>');
  while not qrTypeOrder.Eof do
  begin
    aItem := TOrderStatus.Create;
    aItem.DscStt        := qrTypeOrder.FieldByName('DSC_STT').AsString;
    with aItem.FkTipoMovEstq do
      PkTypeMoviment    := qrTypeOrder.FieldByName('FK_TIPO_MOVIM_ESTQ').AsInteger;
    aItem.FlagStatus    := [];
    if qrTypeOrder.FieldByName('FLAG_OPEN').AsInteger = 1 then
      aItem.FlagStatus  := aItem.FlagStatus + [osOpened];
    if qrTypeOrder.FieldByName('FLAG_RECB').AsInteger = 1 then
      aItem.FlagStatus  := aItem.FlagStatus + [osReceived];
    if qrTypeOrder.FieldByName('FLAG_LIB').AsInteger = 1 then
      aItem.FlagStatus  := aItem.FlagStatus + [osLiberated];
    if qrTypeOrder.FieldByName('FLAG_LIQ').AsInteger = 1 then
      aItem.FlagStatus  := aItem.FlagStatus + [osEliminated];
    if qrTypeOrder.FieldByName('FLAG_CANC').AsInteger = 1 then
      aItem.FlagStatus  := aItem.FlagStatus + [osCanceled];
    if qrTypeOrder.FieldByName('FLAG_PROD').AsInteger = 1 then
      aItem.FlagStatus  := aItem.FlagStatus + [osProduced];
    if qrTypeOrder.FieldByName('FLAG_FAT').AsInteger = 1 then
      aItem.FlagStatus  := aItem.FlagStatus + [osInvoiced];
    aItem.PkOrderStatus := qrTypeOrder.FieldByName('PK_TIPO_STATUS_PEDIDOS').AsInteger;
    aItem.QtdDaysNext   := qrTypeOrder.FieldByName('QTD_DAYS_NEXT').AsInteger;
    aItem.cbIndex       := Result.AddObject(aItem.DscStt, aItem);
    qrTypeOrder.Next;
  end;
  if qrTypeOrder.Active then qrTypeOrder.Close;
end;

function TdmSysPed.LoadPurchaseOrders(const AFkSupplier: Integer): TStrings;
begin
  Result := TStringList.Create;
  if qrPurchaseOrder.Active then qrPurchaseOrder.Close;
  qrPurchaseOrder.SQL.Clear;
  qrPurchaseOrder.SQL.Add(SqlPurchaseOrders);
  Dados.StartTransaction(qrPurchaseOrder);
  qrPurchaseOrder.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
  qrPurchaseOrder.ParamByName('FkFornecedores').AsInteger := AFkSupplier;
  if not qrPurchaseOrder.Active then qrPurchaseOrder.Open;
  try
    Result.AddObject('<Nenhum>', nil);
    while not qrPurchaseOrder.Eof do
    begin
      Result.AddObject(qrPurchaseOrder.FieldByName('DSC_TCOT').AsString,
        TDataRow.CreateFromDataSet(nil, qrPurchaseOrder, True));
      qrPurchaseOrder.Next;
    end;
  finally
    if qrPurchaseOrder.Active then qrPurchaseOrder.Close;
    Dados.CommitTransaction(qrPurchaseOrder);
  end;
end;

function TdmSysPed.LoadDiscounts(AFkGMov: Integer): TStrings;
var
  aItem: TTypeDiscount;
  aDsct: TDiscount;
  aStr : string;
begin
  Result := TStringList.Create;
  if qrTypeDiscount.Active then qrTypeDiscount.Close;
  qrTypeDiscount.SQL.Clear;
  qrTypeDiscount.SQL.Add(SqlDescontos);
  if qrTypeDiscount.Params.FindParam('FkGruposMovimentos') <> nil then
    qrTypeDiscount.ParamByName('FkGruposMovimentos').AsInteger := AFkGMov;
  if not qrTypeDiscount.Active then qrTypeDiscount.Open;
  Result.Add('<Nenhum>');
  aStr  := '';
  while not (qrTypeDiscount.Eof) do
  begin
    aItem                  := TTypeDiscount.Create;
    if aStr <> qrTypeDiscount.FieldByName('DSC_TDSCT').AsString then
    begin
      aItem.PkTypeDiscount := qrTypeDiscount.FieldByName('PK_TIPO_DESCONTOS').AsInteger;
      aItem.DscDsct        := qrTypeDiscount.FieldByName('DSC_TDSCT').AsString;
      aItem.cbIndex        := Result.AddObject(aItem.DscDsct, aItem);
    end;
    aDsct                       := aItem.Discounts.Add;
    aDsct.FkCategory.PkCategory := qrTypeDiscount.FieldByName('FK_CATEGORIAS').AsInteger;
    aDsct.FkState.FkCountry.PKCountry := qrTypeDiscount.FieldByName('FK_PAISES').AsInteger;
    aDsct.FkState.PkState := qrTypeDiscount.FieldByName('FK_ESTADOS').AsString;
    aDsct.FlagTDsct       := TTypeOperation(qrTypeDiscount.FieldByName('FLAG_TDSCT').AsInteger);
    aDsct.FlagDstq        := Boolean(qrTypeDiscount.FieldByName('FLAG_DSTQ').AsInteger);
    aDsct.IdxDsct         := qrTypeDiscount.FieldByName('IDX_DSCT').AsFloat;
    aStr                  := qrTypeDiscount.FieldByName('DSC_TDSCT').AsString;
    qrTypeDiscount.Next;
  end;
  if qrTypeDiscount.Active then qrTypeDiscount.Close;
end;

function TdmSysPed.LoadFinalizers(const AFkTPgto: Integer): TStrings;
var
  aItem: TPaymentWay;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlGetTypePayWays);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkTipoPagamentos').AsInteger := AFkTPgto;
    if not qrSqlAux.Active then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while not (qrSqlAux.Eof) do
    begin
      aItem                := TPaymentWay.Create(nil);
      aItem.PkPaymentWay   := qrSqlAux.FieldByName('PK_FINALIZADORAS').AsInteger;
      aItem.DscMPgt        := qrSqlAux.FieldByName('DSC_MPGT').AsString;
      aItem.FlagBnc        := Boolean(qrSqlAux.FieldByName('FLAG_BNC').AsInteger);
      aItem.FlagCli        := Boolean(qrSqlAux.FieldByName('FLAG_CLI').AsInteger);
      aItem.FlagTef        := Boolean(qrSqlAux.FieldByName('FLAG_TEF').AsInteger);
      aItem.FlagTrc        := Boolean(qrSqlAux.FieldByName('FLAG_TRC').AsInteger);
      aItem.FlagTFin       := TTypeFinalization(qrSqlAux.FieldByName('FLAG_TFIN').AsInteger);
      Result.AddObject(aItem.DscMPgt, aItem);
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysPed.LoadParamsOrders(var ARec: TDefaultRecord): Boolean;
begin
  Result := False;
  if qrParamPed.Active then qrParamPed.Close;
  qrParamPed.SQL.Clear;
  qrParamPed.SQL.Add(SqlParamPed);
  try
    qrParamPed.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    if not qrParamPed.Active then qrParamPed.Open;
    ARec.FkGroupMov   := qrParamPed.FieldByName('FK_GRUPOS_MOVIMENTOS').AsInteger;
    ARec.FkTypeMov    := qrParamPed.FieldByName('FK_TIPO_MOVIMENTOS').AsInteger;
    ARec.TypeDelivery := qrParamPed.FieldByName('FK_TIPO_PRAZO_ENTREGA').AsInteger;
    ARec.StatusOrder  := qrParamPed.FieldByName('FK_TIPO_STATUS_PEDIDOS').AsInteger;
    ARec.PrzEntr      := qrParamPed.FieldByName('PRZ_ENTR').AsInteger;
    ARec.FlagTPed     := TOrderType(qrParamPed.FieldByName('FLAG_TPED').AsInteger);
    ARec.FlagItmDsct  := Boolean(qrParamPed.FieldByName('FLAG_ITM_DSCT').AsInteger);
  finally
    if qrParamPed.Active then qrParamPed.Close;
  end;
end;

function TdmSysPed.LoadUnits: TStrings;
var
  aItem: TUnit;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlUnits);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        aItem           := TUnit.Create;
        aItem.PkUnit    := qrSqlAux.FindField('PK_UNIDADES').AsInteger;
        aItem.DscUni    := qrSqlAux.FindField('DSC_UNI').AsString;
        aItem.MnmoUni   := qrSqlAux.FindField('MNMO_UNI').AsString;
        aItem.cbIndex   := Result.AddObject(aItem.DscUni, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysPed.GetProdRef(const ACompanyID, AOwnerID: Integer;
            const AProductID: string; const APriceTabID, AGrMovID, ATpMovID,
            ATypeVol, ATypeCode: SmallInt; const AQtdProd: Double): TStrings;
var
  aItem: TOrderItem;
  aTax : TTaxDescription;
begin
  Result := TStringList.Create;
  if ((AOwnerID < 1) or (AProductID = '') or (AGrMovID < 1) or
     ( ATpMovID < 1) or (ATypeCode < 0)) then
    exit;
  if qrProducts.Active then qrProducts.Close;
  qrProducts.SQL.Clear;
  qrProducts.SQL.Add(SqlStpGetProduct);
  Dados.StartTransaction(qrProducts);
  try
{    ShowMessage('Campos:' + NL +
      Format('ACompanyID: %d', [ACompanyID]) + NL +
      Format('AOwnerID: %d', [AOwnerID]) + NL +
      Format('APriceTabID: %d', [APriceTabID]) + NL +
      Format('AGrMovID: %d', [AGrMovID]) + NL +
      Format('ATpMovID: %d', [ATpMovID]) + NL +
      Format('AProductID: %s', [AProductID]) + NL +
      Format('ATypeVol: %d', [ATypeVol]) + NL +
      Format('ATypeCode: %d', [ATypeCode]));}
    qrProducts.ParamByName('FkEmpresa').AsInteger          := ACompanyID;
    qrProducts.ParamByName('FkCadastro').AsInteger         := AOwnerID;
    qrProducts.ParamByName('FkProduto').AsString           := AProductID;
    qrProducts.ParamByName('CodeType').AsInteger           := ATypeCode;
    qrProducts.ParamByName('FkTabelaPrecos').AsInteger     := APriceTabID;
    qrProducts.ParamByName('FkGruposMovimentos').AsInteger := AGrMovID;
    qrProducts.ParamByName('FkTipoMovimentos').AsInteger   := ATpMovID;
    qrProducts.ParamByName('TypeVol').AsInteger            := ATypeVol;
    qrProducts.ParamByName('QtdProd').AsFloat              := AQtdProd;
    if not qrProducts.Active then qrProducts.Open;
    while not qrProducts.Eof do
    begin
      aItem             := TOrderItem.Create(nil);
      with aItem.FkProduct do
      begin
        DscProd         := qrProducts.FieldByName('R_DSC_PROD').AsString;
        PkProducts      := qrProducts.FieldByName('R_PK_PRODUTOS').AsInteger;
        with ProductCodes.Add do
        begin
          if qrProducts.FieldByName('R_COD_REF').AsString <> '' then
          begin
            CodRef      := qrProducts.FieldByName('R_COD_REF').AsString;
            FlagTCode   := pcReference;
          end;
          if qrProducts.FieldByName('R_COD_BARRA').AsString <> '' then
          begin
            CodRef      := qrProducts.FieldByName('R_COD_BARRA').AsString;
            FlagTCode   := pcBarCode;
          end;
        end;
        with ProductCost do
        begin
          QtdEstq             := qrProducts.FieldByName('R_QTD_ESTQ').AsFloat;
          FkCompany.PkCompany := qrProducts.FieldByName('R_FK_EMPRESAS').AsInteger;
          FKCompany.DscEmp    := qrProducts.FieldByName('R_NOM_EMP').AsString;
        end;
        with ProductSale do
        begin
          PesLiq        := qrProducts.FieldByName('R_PES_LIQ').AsFloat;
          PesBru        := qrProducts.FieldByName('R_PES_BRU').AsFloat;
        end;
        with FkUnit do
        begin
          MnmoUni       := qrProducts.FieldByName('R_MNM_UNI').AsString;
          PkUnit        := qrProducts.FieldByName('R_FK_UNIDADES').AsInteger;
          FlagFrac      := Boolean(qrProducts.FieldByName('R_FLAG_FRAC').AsInteger);
        end;
        with ProductPrices.Add do
          PreVda        := RoundTo(qrProducts.FieldByName('R_VLR_TAB').AsFloat,
                             (Dados.DecimalPlaces * -1));
      end;
      with aItem.FkPriceTable do
      begin
        PkPriceTable    := qrProducts.FieldByName('R_FK_TABELA_PRECOS').AsInteger;
        DscTab          := qrProducts.FieldByName('R_DSC_TAB').AsString;
      end;
      aItem.CodRef      := qrProducts.FieldByName('R_COD_REF').AsString;
      aItem.LotItem     := qrProducts.FieldByName('R_LOT_PROD').AsString;
      aItem.SitTrib     := qrProducts.FieldByName('R_SIT_TRIB').AsString;
      aItem.VolProd     := qrProducts.FieldByName('R_VOL_PROD').AsFloat;
      aItem.ClassFiscal := qrProducts.FieldByName('R_CLASS_FISCAL').AsString;
      aItem.QtdItem     := RoundTo(qrProducts.FieldByName('R_QTD_ITEM').AsFloat,
                             (Dados.DecimalPlacesQtd * -1));
      aItem.VlrAcrDsct  := RoundTo((qrProducts.FieldByName('R_VLR_DSCT').AsFloat +
                             qrProducts.FieldByName('R_DSCT_ITEM').AsFloat) * -1,
                             (Dados.DecimalPlaces * -1));
      aItem.FlagSrv     := Boolean(qrProducts.FieldByName('R_FLAG_SRV').AsInteger);
      aItem.FlagDefTab  := Boolean(qrProducts.FieldByName('R_FLAG_DEFTAB').AsInteger);
      aItem.ComProd     := qrProducts.FieldByName('R_COM_PROD').AsFloat;
      aItem.RedBas      := qrProducts.FieldByName('R_RED_BASC').AsFloat;
      aItem.FlagConf    := Boolean(qrProducts.FieldByName('R_FLAG_CONF').AsInteger);
      aItem.Status      := qrProducts.FieldByName('R_STATUS').AsInteger;
      aItem.PerDsct     := qrProducts.FieldByName('R_PERC_DSCT').AsFloat;
      aTax.TaxPercent   := qrProducts.FieldByName('R_ALQ_ICMS').AsFloat;
      if qrProducts.FieldByName('R_COD_ICMS_ECF').IsNull then
        aTax.TaxCode    := 0
      else
        aTax.TaxCode    := qrProducts.FieldByName('R_COD_ICMS_ECF').AsInteger;
      aItem.AlqIcms     := aTax;
      aTax.TaxPercent   := qrProducts.FieldByName('R_ALQ_ICMSS').AsFloat;
      if qrProducts.FieldByName('R_COD_ICMSS_ECF').IsNull then
        aTax.TaxCode    := 0
      else
        aTax.TaxCode    := qrProducts.FieldByName('R_COD_ICMSS_ECF').AsInteger;
      aItem.AlqIcmss    := aTax;
      aTax.TaxPercent   := qrProducts.FieldByName('R_ALQ_IPI').AsFloat;
      if qrProducts.FieldByName('R_COD_IPI_ECF').IsNull then
        aTax.TaxCode    := 0
      else
        aTax.TaxCode    := qrProducts.FieldByName('R_COD_IPI_ECF').AsInteger;
      aItem.AlqIpi      := aTax;
      aTax.TaxPercent   := qrProducts.FieldByName('R_ALQ_ISS').AsFloat;
      if qrProducts.FieldByName('R_COD_ISS_ECF').IsNull then
        aTax.TaxCode    := 0
      else
        aTax.TaxCode    := qrProducts.FieldByName('R_COD_ISS_ECF').AsInteger;
      aItem.AlqIss      := aTax;
      aTax.TaxPercent   := qrProducts.FieldByName('R_ALQ_OTR').AsFloat;
      if qrProducts.FieldByName('R_COD_OTR_ECF').IsNull then
        aTax.TaxCode    := 0
      else
        aTax.TaxCode    := qrProducts.FieldByName('R_COD_OTR_ECF').AsInteger;
      aItem.AlqOtr      := aTax;
      aItem.VlrUnit     := RoundTo(qrProducts.FieldByName('R_VLR_UNIT').AsFloat,
                             (Dados.DecimalPlaces * -1));
      aItem.VlrAcrDsct  := RoundTo(qrProducts.FieldByName('R_DSCT_ITEM').AsFloat,
                             (Dados.DecimalPlaces * -1));
      aItem.FkAlmox     := qrProducts.FieldByName('R_FK_ALMOXARIFADOS').AsInteger;
      aItem.FkLotacao   := qrProducts.FieldByName('R_FK_LOTACOES').AsInteger;
//      aItem.FlagTab     := Boolean(qrProducts.FieldByName('R_FLAG_TAB').AsInteger);
//    R_DSC_RED VARCHAR(30),
//    R_QTD_ESTQ_ALMX NUMERIC(9,4),
//    R_QTD_ESTQ_LOT NUMERIC(9,4),
      Result.AddObject(aItem.FkProduct.DscProd + ' - ' +
        aItem.FkProduct.ProductCost.FkCompany.DscEmp, aItem);
      qrProducts.Next;
    end;
  finally
    if qrProducts.Active then qrProducts.Close;
    Dados.CommitTransaction(qrProducts);
  end;
end;

function TdmSysPed.LoadComponents(APkProd: Integer): TStrings;
var
  aItem: TComponentType;
begin
  Result := TStringList.Create;
  if (aPkProd = 0) then exit;
  if qrComponents.Active then qrComponents.Close;
  qrComponents.SQL.Clear;
  qrComponents.SQL.Add(SqlComponents);
  Dados.StartTransaction(qrComponents);
  try
    if qrComponents.Params.FindParam('FkProdutos') <> nil then
      qrComponents.Params.FindParam('FkProdutos').AsInteger := APkProd;
    if not qrComponents.Active then qrComponents.Open;
    while (not qrComponents.Eof) do
    begin
      aItem             := TComponentType.Create;
      aItem.PkComponent := qrComponents.FindField('FK_TIPO_COMPONENTES').AsInteger;
      aItem.DscTComp    := qrComponents.FindField('DSC_TCOMP').AsString;
      aItem.QtdComp     := qrComponents.FindField('QTD_COMP').AsFloat;
      Result.AddObject(aItem.DscTComp, aItem);
      qrComponents.Next;
    end;
  finally
    if qrComponents.Active then qrComponents.Close;
    Dados.CommitTransaction(qrComponents);
  end;
end;

function TdmSysPed.LoadFinish(APkCompany, APkProd: Integer;
           AComponent: TComponentType): TStrings;
var
  aItem: TReferenceType;
begin
  Result := TStringList.Create;
  if (APkCompany <= 0) or (APkProd <= 0) or (AComponent = nil) or
     (AComponent.PkComponent <= 0 ) then exit;
  if qrFinish.Active then qrFinish.Close;
  qrFinish.SQL.Clear;
  qrFinish.SQL.Add(SqlFinishes);
  Dados.StartTransaction(qrFinish);
  try
    if qrFinish.Params.FindParam('FkEmpresas') <> nil then
      qrFinish.Params.FindParam('FkEmpresas').AsInteger := APkCompany;
    if qrFinish.Params.FindParam('FkProdutos') <> nil then
      qrFinish.Params.FindParam('FkProdutos').AsInteger := APkProd;
    if qrFinish.Params.FindParam('FkComponentes') <> nil then
      qrFinish.Params.FindParam('FkComponentes').AsInteger := AComponent.PkComponent;
    if not qrFinish.Active then qrFinish.Open;
    Result.Add('<Nenhum>');
    while (not qrFinish.Eof) do
    begin
      aItem := TReferenceType.Create;
      aItem.FkFinishType.PkFinishType := qrFinish.FieldByName('PK_TIPO_ACABAMENTOS').AsInteger;
      aItem.FkFinishType.DscAcbm      := qrFinish.FieldByName('DSC_ACABM').AsString;
      aItem.FkFinishType.QtdPdr       := qrFinish.FieldByName('QTD_PDR').AsFloat;
      aItem.FkFinishType.QtdPers      := qrFinish.FieldByName('QTD_PERS').AsFloat;
      aItem.FkFinishType.PreVda       := RoundTo(qrFinish.FieldByName('PRE_VDA').AsFloat,
                                            (Dados.DecimalPlaces * -1));
      aItem.PkReferenceType           := qrFinish.FieldByName('FK_TIPO_REFERENCIAS').AsInteger;
      aItem.DscRef                    := qrFinish.FieldByName('DSC_REF').AsString;
      aItem.cbIndex                   := Result.AddObject(aItem.FkFinishType.DscAcbm + '/' +
                                           aItem.DscRef, aItem);
      qrFinish.Next;
    end;
  finally
    if qrFinish.Active then qrFinish.Close;
    Dados.CommitTransaction(qrFinish);
  end;
end;

function TdmSysPed.LoadMaterial(APkFinish, APkReference: Integer): TStrings;
var
  aItem: TProducts;
begin
  Result := TStringList.Create;
  if qrInsumos.Active then qrInsumos.Close;
  qrInsumos.SQL.Clear;
  qrInsumos.SQL.Add(SqlInsumos);
  Dados.StartTransaction(qrInsumos);
  try
    if qrInsumos.Params.FindParam('FkTipoAcabamentos') <> nil then
      qrInsumos.Params.FindParam('FkTipoAcabamentos').AsInteger := APkFinish;
    if qrInsumos.Params.FindParam('FkTipoReferencias') <> nil then
      qrInsumos.Params.FindParam('FkTipoReferencias').AsInteger := APkReference;
    if not qrInsumos.Active then qrInsumos.Open;
    Result.Add('<Nenhum>');
    while (not qrInsumos.Eof) do
    begin
      aItem := TProducts.Create;
      aItem.PkProducts := qrInsumos.FieldByName('PK_PRODUTOS').AsInteger;
      aItem.DscProd    := qrInsumos.FindField('DSC_PROD').AsString;
      aItem.cbIndex    := Result.AddObject(aItem.DscProd, aItem);
      qrInsumos.Next;
    end;
  finally
    if qrInsumos.Active then qrInsumos.Close;
    Dados.CommitTransaction(qrInsumos);
  end;
end;

{function TdmSysPed.SaveAllOrders(AOrder: TOrder; AMode: TDBMode;
  AMulti: Boolean = False): TOrderLinks;
var
  aCompany  ,
  aQtd      ,
  aBeginItem,
  aEndItem  : Integer;
  function GetEndItem(aBeginItem: Integer): Boolean;
  var
    j, h: Integer;
  begin
    for j := aBeginItem to AOrder.OrderItems.Count - 1 do
    begin
      if (AOrder.OrderItems.Items[j].PkCompany <> aCompany) then
      begin
        aCompany := AOrder.OrderItems.Items[j].PkCompany;
        aEndItem := j;
        for h := j to AOrder.OrderItems.Count - 1 do
          if (AOrder.OrderItems.Items[h].PkCompany <> aCompany) or
             (h = AOrder.OrderItems.Count - 1) then
          begin
            if (h = AOrder.OrderItems.Count - 1) then
              aEndItem := h
            else
              aEndItem := h - 1;
            Result := (aEndItem <= (AOrder.OrderItems.Count - 1));
            exit;
          end;
      end;
    end;
    Result := False;
  end;
begin
  if (AOrder = nil) or (not (AMode in UPDATE_MODE)) or
     (AOrder.OrderItems.Count = 0) then
    exit;
  if AMulti then
  begin
    aCompany   := 0;
    aEndItem   := 0;
    aBeginItem := 0;
    aQtd       := 0;
    while GetEndItem(aBeginItem) do
    begin
      Inc(aQtd);
      Result := SaveOrder(AOrder, AMode, aCompany, aBeginItem, aEndItem, aQtd);
      aBeginItem := aEndItem + 1;
    end;
  end
  else
    Result := SaveOrder(AOrder, AMode, Dados.PkCompany, 0, -1, 1);
end;
}
procedure TdmSysPed.SetOrder(APk: Integer; const Value: TOrder);
var
  aStr: TStrings;
  aStatus: Integer;
  aPercDsct, VlrSeg,  VlrEntr,
  DspAces, VlrAcrDsct, SubTot,
  TotPed, PesLiq, PesBru,
  VlrFret: Double;
  function GetPkOrder: Integer;
  begin
    Result := 0;
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGetPkOrder);
    qrSqlAux.ParamByName('FkEmpresas').AsInteger    := Dados.PkCompany;
    if not qrSqlAux.Active then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
      Result := qrSqlAux.FieldByName('PK_PEDIDOS').AsInteger;
    if qrSqlAux.Active then qrSqlAux.Close;
  end;
begin
  aPercDsct := 0;
//  AOrder.FkCompany.PkCompany := ACompany;
  if qrOrders.Active then qrOrders.Close;
  qrOrders.SQL.Clear;
  if TDBMode(APk) = dbmInsert then
    qrOrders.SQL.AddStrings(GetInsertSQL(Value.GetFields, 'PEDIDOS'));
  if TDBMode(APk) = dbmEdit then
  begin
    aStr := TStringList.Create;
    try
      aStr.Add('FK_EMPRESAS');
      aStr.Add('PK_PEDIDOS');
      qrOrders.SQL.AddStrings(GetUpdateSQL(Value.GetFields, aStr, 'PEDIDOS'));
    finally
      aStr.Free;
    end;
  end;
  Dados.StartTransaction(qrOrders);
  try
    qrOrders.ParamByName('FkEmpresas').AsInteger          := Dados.PkCompany;
    if (TDBMode(APk) = dbmInsert) then Value.PkOrder      := GetPkOrder;
    qrOrders.ParamByName('PkPedidos').AsInteger           := Value.PkOrder;
    if (qrOrders.Params.FindParam('OldFkEmpresas') <> nil) then
      qrOrders.ParamByName('OldFkEmpresas').AsInteger     := Value.FkCompany.PkCompany;
    if (qrOrders.Params.FindParam('OldPkPedidos') <> nil) then
      qrOrders.ParamByName('OldPkPedidos').AsInteger      := Value.PkOrder;
    qrOrders.ParamByName('FkGruposMovimentos').AsInteger  := Value.FkMovement.PkGroupMovement;
    qrOrders.ParamByName('FkTipoMovimentos').AsInteger    := Value.FkMovement.PkTypeMovement;
    qrOrders.ParamByName('FkCadastros').AsInteger         := Value.FkOwner.PkCadastros;
    qrOrders.ParamByName('FkTipoStatusPedidos').AsInteger := Value.FkOrderStatus.PkOrderStatus;
    qrOrders.ParamByName('KcPedidosHistoricos').AsInteger := Value.OrderHistorics.Count;
    qrOrders.ParamByName('KcPedidosMensagens').AsInteger  := 0;
    qrOrders.ParamByName('KcPedidosDescontos').AsInteger  := Value.Discounts.Count;
    qrOrders.ParamByName('NumVol').AsInteger              := Value.NumVol;
    qrOrders.ParamByName('TipoVol').AsString              := Value.TipoVol;
    qrOrders.ParamByName('FlagEntrParc').AsInteger        := Ord(Value.FlagEntrParc);
    qrOrders.ParamByName('FlagVincPed').AsInteger         := Ord(Value.FlagVincPed);
    qrOrders.ParamByName('FlagPend').AsInteger            := Ord(Value.FlagPend);
    qrOrders.ParamByName('FlagCPrve').AsInteger           := Ord(Value.FlagCPrvE);
    qrOrders.ParamByName('FlagImp').AsInteger             := Ord(Value.FlagImp);
    qrOrders.ParamByName('FlagProd').AsInteger            := Ord(Value.FlagProd);
    qrOrders.ParamByName('FlagTPed').AsInteger            := Ord(Value.FlagTPed);
    qrOrders.ParamByName('FlagEdrtRdsp').AsInteger        := Ord(Value.FlagEDrtRdsp);
    qrOrders.ParamByName('FlagDtaBas').AsInteger          := Ord(Value.FlagDtaBas);
    qrOrders.ParamByName('QtdDupl').AsInteger             := Value.FkTypePayment.Installments.Count;
    qrOrders.ParamByName('QtdVol').AsInteger              := Value.QtdVol;
//    if (AEndItem > -1) then
//      qrOrders.ParamByName('QtdItem').AsInteger           := AEndItem + 1
//    else
      qrOrders.ParamByName('QtdItem').AsInteger           := Value.OrderItems.Count;
    if (qrOrders.Params.FindParam('DtaRecb') <> nil) then
      qrOrders.ParamByName('DtaRecb').AsDate              := Value.DtaRecb;
    if (qrOrders.Params.FindParam('DtaLib') <> nil) then
      qrOrders.ParamByName('DtaLib').AsDate               := Value.DtaLib;
    if (qrOrders.Params.FindParam('DtaEntr') <> nil) then
      qrOrders.ParamByName('DtaEntr').AsDate              := Value.DtaEntr;
    if (qrOrders.Params.FindParam('DtaCanc') <> nil) then
      qrOrders.ParamByName('DtaCanc').AsDate              := Value.DtaCanc;
    if (qrOrders.Params.FindParam('DtaBas') <> nil) then
      qrOrders.ParamByName('DtaBas').AsDate               := Value.DtaBas;
    if (qrOrders.Params.FindParam('DtaFat') <> nil) then
      qrOrders.ParamByName('DtaFat').AsDate               := Value.DtaFat;
    if (qrOrders.Params.FindParam('MesPrevEntr') <> nil) then
      qrOrders.ParamByName('MesPrevEntr').AsInteger       := Value.MesPrevEntr;
    if (qrOrders.Params.FindParam('AnoPrevEntr') <> nil) then
      qrOrders.ParamByName('AnoPrevEntr').AsInteger       := Value.AnoPrevEntr;
    if (qrOrders.Params.FindParam('NumExtr') <> nil) then
      qrOrders.ParamByName('NumExtr').AsString            := Value.NumExtr;
    if (qrOrders.Params.FindParam('NumProForma') <> nil) then
      qrOrders.ParamByName('NumProForma').AsInteger       := Value.NumProForma;
    if (qrOrders.Params.FindParam('FkTipoPrazoEntrega') <> nil) then
      qrOrders.ParamByName('FkTipoPrazoEntrega').AsInteger:= Value.FkDeliveryPeriod;
    if (qrOrders.Params.FindParam('FkTipoPagamentos') <> nil) then
      qrOrders.ParamByName('FkTipoPagamentos').AsInteger  := Value.FkTypePayment.PkTypePgto;
    if (qrOrders.Params.FindParam('FkTipoDescontos') <> nil) then
      qrOrders.ParamByName('FkTipoDescontos').AsInteger   := Value.FkTypeDiscount.PkTypeDiscount;
    if (qrOrders.Params.FindParam('FkVwVendedores') <> nil) then
      qrOrders.ParamByName('FkVwVendedores').AsInteger    := Value.FkVendor.PkCadastros;
    if (qrOrders.Params.FindParam('FkVwRepresentantes') <> nil) then
      qrOrders.ParamByName('FkVwRepresentantes').AsInteger  := Value.FkRepresentant.PkCadastros;
    if (qrOrders.Params.FindParam('FkVwTransportadoras') <> nil) then
      qrOrders.ParamByName('FkVwTransportadoras').AsInteger := Value.FkCarrier.PkCadastros;
    if (qrOrders.Params.FindParam('FkVwAgentes') <> nil) then
      qrOrders.ParamByName('FkVwAgentes').AsInteger       := Value.FkAgent.PkCadastros;
    if (qrOrders.Params.FindParam('FkPortosDst') <> nil) then
      qrOrders.ParamByName('FkPortosDst').AsInteger       := Value.FkPortoDst;
    if (qrOrders.Params.FindParam('FkPortosEmb') <> nil) then
      qrOrders.ParamByName('FkPortosEmb').AsInteger       := Value.FkPortoEmb;
    if (qrOrders.Params.FindParam('FkOrdemCompra') <> nil) then
      qrOrders.ParamByName('FkOrdemCompra').AsInteger     := Value.FkPurchaseOrder;
    if (qrOrders.Params.FindParam('FkTabelaPrecos') <> nil) then
      qrOrders.ParamByName('FkTabelaPrecos').AsInteger    := Value.FkPriceTable.PkPriceTable;
    if (qrOrders.Params.FindParam('FkTipoPazoEntrega') <> nil) then
      qrOrders.ParamByName('FkTipoPazoEntrega').AsInteger := Value.FkDeliveryPeriod;
    if (qrOrders.Params.FindParam('FkFinalizadoras') <> nil) then
      qrOrders.ParamByName('FkFinalizadoras').AsInteger   := Value.FkPaymentWay.PkPaymentWay;
//    if (AEndItem > -1) and (AOrder.VlrAcrDsct > 0) then
//    begin
//      aPercDsct := Value.TotPed / Value.VlrAcrDsct;
//      if (aPercDsct < 0) then
//        aPercDsct := aPercDsct * -1;
//    end;
    VlrFret := Value.VlrFret;
    if (aPercDsct > 0) then
      VlrFret := Value.VlrFret + ((Value.VlrFret * aPercDsct) / 100);
    VlrSeg := Value.VlrSeg;
    if (aPercDsct > 0) then
      VlrSeg := Value.VlrSeg + ((Value.VlrSeg * aPercDsct) / 100);
    VlrEntr := Value.VlrEntr;
    if (aPercDsct > 0) then
      VlrEntr := Value.VlrEntr + ((Value.VlrEntr * aPercDsct) / 100);
    DspAces := Value.DspAces;
    if (aPercDsct > 0) then
      DspAces := Value.DspAces + ((Value.DspAces * aPercDsct) / 100);
    VlrAcrDsct := Value.VlrAcrDsct;
    if (aPercDsct > 0) then
      VlrAcrDsct := Value.VlrAcrDsct + ((Value.VlrAcrDsct * aPercDsct) / 100);
    SubTot := Value.SubTot;
    if (aPercDsct > 0) then
      SubTot := Value.SubTot + ((Value.SubTot * aPercDsct) / 100);
    TotPed := Value.TotPed;
    if (aPercDsct > 0) then
      TotPed := Value.TotPed + ((Value.TotPed * aPercDsct) / 100);
    PesLiq := Value.PesLiq;
    if (aPercDsct > 0) then
      PesLiq := Value.PesLiq + ((Value.PesLiq * aPercDsct) / 100);
    PesBru := Value.PesBru;
    if (aPercDsct > 0) then
      PesBru := Value.PesBru + ((Value.PesBru * aPercDsct) / 100);
    qrOrders.ParamByName('VlrFret').AsFloat     := VlrFret;
    qrOrders.ParamByName('VlrSeg').AsFloat      := VlrSeg;
    qrOrders.ParamByName('VlrEntr').AsFloat     := VlrEntr;
    qrOrders.ParamByName('DspAces').AsFloat     := DspAces;
    qrOrders.ParamByName('VlrAcrDsct').AsFloat  := VlrAcrDsct;
    qrOrders.ParamByName('SubTot').AsFloat      := SubTot;
    qrOrders.ParamByName('TotPed').AsFloat      := TotPed;
    qrOrders.ParamByName('PesLiq').AsFloat      := PesLiq;
    qrOrders.ParamByName('PesBru').AsFloat      := PesBru;
    qrOrders.ExecSQL;
// delete all items from order
// Não pode ser assim senão vai dar furo nos estoques
// tem que gravar o status em cada ítem e somente salvar os que estão
// em UPDATE_MODE
//    if qrOrderItems.Active then qrOrderItems.Close;
//    qrOrderItems.SQL.Clear;
//    qrOrderItems.SQL.Add(SqlDelOrderItems);
//    qrOrderItems.ParamByName('FkEmpresas').AsInteger    := AOrder.FkCompany.PkCompany;
//    qrOrderItems.ParamByName('FkTipoPedidos').AsInteger := AOrder.FkTypeOrder.PkTypeOrder;
//    qrOrderItems.ParamByName('FkPedidos').AsInteger     := AOrder.PkOrder;
//    qrOrderItems.ExecSQL;
//    if (AEndItem = -1) then
//    else
//    begin
//      j := 1;
//      for i := ABeginItem to AEndItem do
//      begin
//        InsertItem(Value.OrderItems.Items[i], Value.FkCompany.PkCompany,
//          Value.PkOrder, j);
//        Inc(j);
//      end;
//    end;
//  Delete all installments from the Order and save all then
    if qrPayOrder.Active then qrPayOrder.Close;
    qrPayOrder.SQL.Clear;
    qrPayOrder.SQL.Add(SqlDeletePayOrder);
    qrPayOrder.ParamByName('FkEmpresas').AsInteger    := Value.FkCompany.PkCompany;
    qrPayOrder.ParamByName('FkPedidos').AsInteger     := Value.PkOrder;
    qrPayOrder.ExecSQL;
//  Delete all Discounts from the Order and save all then
    if qrTypeDiscount.Active then qrTypeDiscount.Close;
    qrTypeDiscount.SQL.Clear;
    qrTypeDiscount.SQL.Add(SqlDelOrderDsct);
    qrTypeDiscount.ParamByName('FkEmpresas').AsInteger    := Value.FkCompany.PkCompany;
    qrTypeDiscount.ParamByName('FkPedidos').AsInteger     := Value.PkOrder;
    qrTypeDiscount.ExecSQL;
//  Delete all Messages from the Order and save all then
    if qrOrderMessage.Active then qrOrderMessage.Close;
    qrOrderMessage.SQL.Clear;
    qrOrderMessage.SQL.Add(SqlDelOrderMsg);
    qrOrderMessage.ParamByName('FkEmpresas').AsInteger    := Value.FkCompany.PkCompany;
    qrOrderMessage.ParamByName('FkPedidos').AsInteger     := Value.PkOrder;
    qrOrderMessage.ExecSQL;
//  Delete all Links from the Order and save all then
    if qrOrderLink.Active then qrOrderLink.Close;
    qrOrderLink.SQL.Clear;
    qrOrderLink.SQL.Add(SqlDelOrderLinks);
    qrOrderLink.ParamByName('FkEmpresas').AsInteger    := Value.FkCompany.PkCompany;
    qrOrderLink.ParamByName('FkPedidos').AsInteger     := Value.PkOrder;
    qrOrderLink.ExecSQL;
//  Delete all Historics from the Order and Save all then
    if qrOrderHistoric.Active then qrOrderHistoric.Close;
    qrOrderHistoric.SQL.Clear;
    qrOrderHistoric.SQL.Add(SqlDelOrderHist);
    qrOrderHistoric.ParamByName('FkEmpresas').AsInteger    := Value.FkCompany.PkCompany;
    qrOrderHistoric.ParamByName('FkPedidos').AsInteger     := Value.PkOrder;
    qrOrderHistoric.ExecSQL;
//  Save all complement tables
    OrderItems[Value.PkOrder] := Value.OrderItems;
    OrderInstallments[Value.PkOrder] := Value.FkTypePayment.Installments;
    OrderDiscounts[Value.PkOrder]    := Value.Discounts;
    OrderMessages[Value.PkOrder]     := Value.OrderMessages;
    OrderLinks[Value.PkOrder]        := Value.OrderLinks;
    OrderHistorics[Value.PkOrder]    := Value.OrderHistorics;
//  Save DeliveryAddress
    SetOrderDelivery(APk, Value);
// Update order status...
    if qrOrders.Active then qrOrders.Close;
    qrOrders.SQL.Clear;
    qrOrders.SQL.Add(SqlSetStatusOrder);
    qrOrders.ParamByName('FkEmpresas').AsInteger     := Value.FkCompany.PkCompany;
    qrOrders.ParamByName('PkPedidos').AsInteger      := Value.PkOrder;
    qrOrders.ParamByName('PkPedidosItens').AsInteger := 0;
    qrOrders.ParamByName('QtdProd').AsInteger        := 0;
    qrOrders.ParamByName('FkTipoContas').AsInteger   := 0;
    qrOrders.ParamByName('FkContas').AsInteger       := 0;
    if (not qrOrders.Active) then qrOrders.Open;
    with Value.GenDocs.Add do
    begin
      ResultStatus          := qrOrders.FieldByName('R_STATUS').AsInteger;
      aStatus               := ResultStatus;
      FkCompany             := qrOrders.FieldByName('R_FK_EMPRESAS').AsInteger;
      FkTypeDocument        := qrOrders.FieldByName('R_FK_TIPO_DOCUMENTOS').AsInteger;
      FkOwner               := qrOrders.FieldByName('R_FK_CADASTROS').AsInteger;
      FkDocument            := qrOrders.FieldByName('R_PK_DOCUMENTOS').AsInteger;
    end;
    if qrOrders.Active        then qrOrders.Close;
    if qrOrderItems.Active    then qrOrderItems.Close;
    if qrOrderItConfig.Active then qrOrderItConfig.Close;
    if (aStatus = 0) then
      Dados.CommitTransaction(qrOrders)
    else
      Dados.RollbackTransaction(qrOrders);
  except on E:Exception do
    begin
      if qrOrders.Active        then qrOrders.Close;
      if qrOrderItems.Active    then qrOrderItems.Close;
      if qrOrderItConfig.Active then qrOrderItConfig.Close;
      Dados.RollbackTransaction(qrOrders);
      raise Exception.Create('SetOrder: Erro na gravação do pedido' + NL +
        E.Message);
    end;
  end;
end;

procedure TdmSysPed.SetOrderItems(APk: Integer; const Value: TOrderItems);
var
  i, j: Integer;
  AStr: TStrings;
begin
  //    ShowMessage('Campos:' + NL +
  //      Format('ACompany: %d', [ACompany]) + NL +
  //      Format('AFkTypeOrder: %d', [AFkTypeOrder]) + NL +
  //      Format('AFkOrder: %d', [AFkOrder]) + NL +
  //      Format('APkItem: %d', [APkItem]));
  for j := 0 to Value.Count - 1 do
  begin
    if qrOrderItems.Active then qrOrderItems.Close;
    qrOrderItems.SQL.Clear;
    qrOrderItems.SQL.AddStrings(GetInsertSQL(Value.Items[j].GetFields, 'PEDIDOS_ITENS'));
    qrOrderItems.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
    qrOrderItems.ParamByName('FkPedidos').AsInteger          := APk;
    qrOrderItems.ParamByName('PkPedidosItens').AsInteger     := j + 1;
    qrOrderItems.ParamByName('FkGruposMovimentos').AsInteger := Value.Items[j].FkMovement.PkGroupMovement;
    qrOrderItems.ParamByName('FkTipoMovimentos').AsInteger   := Value.Items[j].FkMovement.PkTypeMovement;
    if qrOrderItems.Params.FindParam('FkTabelaPrecos') <> nil then
      qrOrderItems.ParamByName('FkTabelaPrecos').AsInteger   := Value.Items[j].FkPriceTable.PkPriceTable;
    qrOrderItems.ParamByName('FkUnidades').AsInteger         := Value.Items[j].FkUnit.PkUnit;
    qrOrderItems.ParamByName('FkProdutos').AsInteger         := Value.Items[j].FkProduct.PkProducts;
    if qrOrderItems.Params.FindParam('FkCargasProducao') <> nil then
      qrOrderItems.ParamByName('FkCargasProducao').AsInteger := Value.Items[j].FkProductionLoad;
    qrOrderItems.ParamByName('RefProduto').AsString          := Value.Items[j].CodRef;
    qrOrderItems.ParamByName('QtdItem').AsFloat              := Value.Items[j].QtdItem;
    qrOrderItems.ParamByName('VlrTab').AsFloat               := Value.Items[j].VlrTab;
    qrOrderItems.ParamByName('VlrUnit').AsFloat              := Value.Items[j].VlrUnit;
    qrOrderItems.ParamByName('SubTot').AsFloat               := Value.Items[j].SubTot;
    qrOrderItems.ParamByName('VlrAcrDsct').AsFloat           := Value.Items[j].VlrAcrDsct;
    qrOrderItems.ParamByName('TotItem').AsFloat              := Value.Items[j].TotItem;
    qrOrderItems.ParamByName('SitTrib').AsString             := Value.Items[j].SitTrib;
    qrOrderItems.ParamByName('AlqIss').AsFloat               := Value.Items[j].AlqIss.TaxPercent;
    qrOrderItems.ParamByName('AlqIcms').AsFloat              := Value.Items[j].AlqIcms.TaxPercent;
    qrOrderItems.ParamByName('AlqIcmss').AsFloat             := Value.Items[j].AlqIcmss.TaxPercent;
    qrOrderItems.ParamByName('AlqIpi').AsFloat               := Value.Items[j].AlqIpi.TaxPercent;
    qrOrderItems.ParamByName('AlqOtr').AsFloat               := Value.Items[j].AlqOtr.TaxPercent;
    qrOrderItems.ParamByName('CodIssEcf').AsString           := InsereZer(IntToStr(Value.Items[j].AlqIss.TaxCode), 3);
    qrOrderItems.ParamByName('CodIcmsEcf').AsString          := InsereZer(IntToStr(Value.Items[j].AlqIcms.TaxCode), 3);
    qrOrderItems.ParamByName('CodIcmssEcf').AsString         := InsereZer(IntToStr(Value.Items[j].AlqIcmss.TaxCode), 3);
    qrOrderItems.ParamByName('CodIpiEcf').AsString           := InsereZer(IntToStr(Value.Items[j].AlqIpi.TaxCode), 3);
    qrOrderItems.ParamByName('CodOtrEcf').AsString           := InsereZer(IntToStr(Value.Items[j].AlqOtr.TaxCode), 3);
    qrOrderItems.ParamByName('FlagPrm').AsInteger            := Ord(Value.Items[j].FlagPrm);
    qrOrderItems.ParamByName('FlagPend').AsInteger           := Ord(Value.Items[j].FlagPend);
    qrOrderItems.ParamByName('FlagBxaStt').AsInteger         := Ord(Value.Items[j].FlagBxaStt);
    qrOrderItems.ParamByName('FlagConf').AsInteger           := Ord(Value.Items[j].FlagConf);
    qrOrderItems.ParamByName('FlagSrv').AsInteger            := Ord(Value.Items[j].FlagSrv);
    if (qrOrderItems.Params.FindParam('NumExt') <> nil) then
      qrOrderItems.ParamByName('NumExt').AsString            := Value.Items[j].NumExtr;
    if (qrOrderItems.Params.FindParam('LotItem') <> nil) then
      qrOrderItems.ParamByName('LotItem').AsString           := Value.Items[j].LotItem;
    if (qrOrderItems.Params.FindParam('DtaLiq') <> nil) then
      qrOrderItems.ParamByName('DtaLiq').AsDate              := Value.Items[j].DtaLiq;
    if (qrOrderItems.Params.FindParam('DtaFat') <> nil) then
      qrOrderItems.ParamByName('DtaFat').AsDate              := Value.Items[j].DtaFat;
    if (qrOrderItems.Params.FindParam('FkAlmoxarifados') <> nil) then
      qrOrderItems.ParamByName('FkAlmoxarifados').AsInteger  := Value.Items[j].FkAlmox;
    if (qrOrderItems.Params.FindParam('FkClassificacao') <> nil) then
      qrOrderItems.ParamByName('FkClassificacao').AsInteger  := Value.Items[j].FkClassification;
    if (qrOrderItems.Params.FindParam('FkLotacoes') <> nil) then
      qrOrderItems.ParamByName('FkLotacoes').AsInteger       := Value.Items[j].FkLotacao;
    qrOrderItems.SQL.SaveToFile('sqlPedItens.sql');
    aStr := TStringList.Create;
    try
      qrOrderItems.Sql.SaveToFile('sqlPedItens.sql');
      for i := 0 to qrOrderItems.Params.Count - 1 do
        aStr.Add(qrOrderItems.Params[i].Name + '=' + qrOrderItems.Params[I].AsString);
      aStr.SaveToFile('sqlPedItensParams.txt');
    finally
      FreeAndNil(aStr);
    end;
    qrOrderItems.ExecSQL;
  // save all configuration of Item;
    if (Value.Items[j].HasConfig) then
    begin
      if (qrOrderItConfig.Active) then qrOrderItConfig.Close;
      qrOrderItConfig.SQL.Clear;
      qrOrderItConfig.SQL.Add(SqlInsOrderItmConf);
      for i := 0 to Value.Items[j].ConfigItems.Count - 1 do
      begin
        with Value.Items[j].ConfigItems do
        begin
          qrOrderItConfig.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
          qrOrderItConfig.ParamByName('FkPedidos').AsInteger          := APk;
          qrOrderItConfig.ParamByName('FkPedidosItens').AsInteger     := j + 1;
          qrOrderItConfig.ParamByName('FkPedidosItensConf').AsInteger := Items[i].PkItemConf;
          qrOrderItConfig.ParamByName('FkProdutos').AsInteger         := Value.Items[j].FkProduct.PkProducts;
          qrOrderItConfig.ParamByName('FkComponentes').AsInteger      := Items[i].FkComponentType.PkComponent;
          qrOrderItConfig.ParamByName('FkAcabamentos').AsInteger      := Items[i].FkFinishType.PkFinishType;
          qrOrderItConfig.ParamByName('FkTipoReferencias').AsInteger  := Items[i].FkReferenceType.PkReferenceType;
          qrOrderItConfig.ParamByName('FkInsumos').AsInteger          := Items[i].FkProduct.PkProducts;
          qrOrderItConfig.ParamByName('CodRef').AsString              := Items[i].CodRef;
          qrOrderItConfig.ParamByName('VlrItm').AsFloat               := Items[i].VlrItem;
          qrOrderItConfig.ParamByName('FlagFrnCli').AsInteger         := Ord(Items[i].FlagFrnCli);
          qrOrderItConfig.ParamByName('FlagPend').AsInteger           := Ord(Items[i].FlagPend);
          qrOrderItConfig.ParamByName('FlagCntr').AsInteger           := Ord(Items[i].FlagCntr);
          qrOrderItConfig.ParamByName('FlagBxaStt').AsInteger         := Ord(Items[i].FlagBxaStt);
          qrOrderItConfig.ParamByName('NumDocLib').AsInteger          := 0;
          qrOrderItConfig.ParamByName('QtdComp').AsInteger            := Items[i].QtdComp;
          qrOrderItConfig.ParamByName('QtdCompTot').AsInteger         := Items[i].QtdCompTot;
          qrOrderItConfig.ParamByName('QtdIns').AsFloat               := Items[i].QtdInsTot;
          qrOrderItConfig.ParamByName('PerDsctIns').AsFloat           := Items[i].PerDsctIns;
          qrOrderItConfig.ExecSQL;
        end;
      end;
    end;
  // save all Pedings of Item;
    if (Value.Items[j].FlagPend) and (Value.Items[j].OrderPendings.Count > 0) then
    begin
      if (qrOrderPending.Active) then qrOrderPending.Close;
      qrOrderPending.SQL.Clear;
      qrOrderPending.SQL.Add(SqlInsOrderPend);
      for i := 0 to Value.Items[j].OrderPendings.Count - 1 do
      begin
        with Value.Items[j].OrderPendings do
        begin
          qrOrderPending.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
          qrOrderPending.ParamByName('FkPedidos').AsInteger      := APk;
          qrOrderPending.ParamByName('FkPedidosItens').AsInteger := j + 1;
          qrOrderPending.ParamByName('FkProdutos').AsInteger     := Value.Items[j].FkProduct.PkProducts;
          qrOrderPending.ParamByName('QtdPend').AsFloat          := Items[i].QtdPend;
          qrOrderPending.ParamByName('QtdPend').AsFloat          := Items[i].VlrUnit;
          qrOrderPending.ExecSQL;
        end;
      end;
    end;
  end;
end;

procedure TdmSysPed.SetOrderInstallments(APk: Integer; const Value: TInstallments);
var
  i: Integer;
begin
  if qrPayOrder.Active then qrPayOrder.Close;
  qrPayOrder.SQL.Clear;
  qrPayOrder.SQL.Add(SqlInsPayOrder);
  for i := 0 to Value.Count - 1 do
  begin
    qrPayOrder.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
    qrPayOrder.ParamByName('FkPedidos').AsInteger      := APk;
    qrPayOrder.ParamByName('PkPedidosParcelas').AsDate := Value.Items[i].DtaVenc;
    qrPayOrder.ParamByName('NumParc').AsInteger        := Value.Items[i].Index + 1;
    qrPayOrder.ParamByName('VlrParc').AsFloat          := Value.Items[i].VlrParc;
//    if (APercDsct > 0) then
//      qrPayOrder.ParamByName('VlrParc').AsFloat        := Value.Items[i].VlrParc +
//        ((AInstallment.VlrParc * APercDsct) / 100);
    qrPayOrder.ExecSQL;
  end;
end;

procedure TdmSysPed.SetOrderDiscounts(APk: Integer; const Value: TDiscounts);
var
  i: Integer;
begin
  if qrTypeDiscount.Active then qrTypeDiscount.Close;
  qrTypeDiscount.SQL.Clear;
  qrTypeDiscount.SQL.Add(SqlInsOrderDsct);
  for i := 0 to Value.Count - 1 do
  begin
    qrTypeDiscount.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
    qrTypeDiscount.ParamByName('FkPedidos').AsInteger          := APk;
    qrTypeDiscount.ParamByName('PkPedidosDescontos').AsInteger := i + 1;
    qrTypeDiscount.ParamByName('DscDsct').AsString             := Value.Items[i].DscDsct;
    qrTypeDiscount.ParamByName('IdxDsct').AsFloat              := Value.Items[i].IdxDsct;
//    if (APercDsct > 0) and (ADiscount.FlagTDsct = toValue) then
//      qrTypeDiscount.ParamByName('IdxDsct').AsFloat            := ADiscount.IdxDsct +
//        ((ADiscount.IdxDsct * APercDsct) / 100);
    qrTypeDiscount.ParamByName('FlagTDsct').AsInteger          := Ord(Value.Items[i].FlagTDsct);
    qrTypeDiscount.ParamByName('FlagDstq').AsInteger           := Ord(Value.Items[i].FlagDstq);
    qrTypeDiscount.ExecSQL;
  end;
end;

procedure TdmSysPed.SetOrderMessages(APk: Integer; const Value: TOrderMessages);
var
  M: TMemoryStream;
  i: Integer;
begin
  if qrOrderMessage.Active then qrOrderMessage.Close;
  qrOrderMessage.SQL.Clear;
  qrOrderMessage.SQL.Add(SqlInsOrderMsg);
  for i := 0 to Value.Count - 1 do
  begin
    qrOrderMessage.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
    qrOrderMessage.ParamByName('FkPedidos').AsInteger          := APk;
    qrOrderMessage.ParamByName('PkPedidosMensagens').AsInteger := i + 1;
    qrOrderMessage.ParamByName('FkDepartamentos').AsInteger    := Value.Items[i].FkDepartament;
    qrOrderMessage.ParamByName('DtHrMsg').AsDateTime           := Value.Items[i].DtHrMsg;
    qrOrderMessage.ParamByName('DtHrRcbm').AsDateTime          := Value.Items[i].DtHrRcbm;
    M := TMemoryStream.Create;
    try
      M.Position := 0;
      Value.Items[i].TextMsg.SaveToStream(M);
      M.Position := 0;
      qrOrderMessage.ParamByName('TextMsg').LoadFromStream(M, ftMemo);
    finally
      FreeAndNil(M);
    end;
    qrOrderMessage.ExecSQL;
  end;
end;

procedure TdmSysPed.SetOrderLinks(APk: Integer; const Value: TOrderLinks);
var
  i: Integer;
begin
  if qrOrderLink.Active then qrOrderLink.Close;
  qrOrderLink.SQL.Clear;
  qrOrderLink.SQL.Add(SqlInsOrderLinks);
  for i := 0 to Value.Count - 1 do
  begin
    qrOrderLink.ParamByName('FkEmpresas').AsInteger        := Dados.PkCompany;
    qrOrderLink.ParamByName('FkPedidos').AsInteger         := APk;
    qrOrderLink.ParamByName('FkEmpresasVinc').AsInteger    := Value.Items[i].FkCompany;
    qrOrderLink.ParamByName('FkPedidosVinc').AsInteger     := Value.Items[i].FkDocument;
    qrOrderLink.ExecSQL;
  end;
end;

procedure TdmSysPed.SetOrderHistorics(APk: Integer; const Value: TOrderHistorics);
var
  i: Integer;
begin
  if qrOrderHistoric.Active then qrOrderHistoric.Close;
  qrOrderHistoric.SQL.Clear;
  qrOrderHistoric.SQL.Add(SqlInsOrderHist);
  for i := 0 to Value.Count - 1 do
  begin
    qrOrderHistoric.ParamByName('FkEmpresas').AsInteger          := Dados.PkCompany;
    qrOrderHistoric.ParamByName('FkPedidos').AsInteger           := APk;
    qrOrderHistoric.ParamByName('PkPedidosHistoricos').AsInteger := i + 1;
    qrOrderHistoric.ParamByName('FkTipoStatusPedidos').AsInteger := Value.Items[i].FkOrderStatus.PkOrderStatus;
    qrOrderHistoric.ParamByName('FlagBxaStt').AsInteger          := Ord(Value.Items[i].FlagBxaStt);
    qrOrderHistoric.ParamByName('DscHist').AsString              := Value.Items[i].DscHist;
    qrOrderHistoric.ParamByName('DtHrHist').AsDateTime           := Value.Items[i].DtHrHist;
    qrOrderHistoric.ExecSQL;
  end;
end;

procedure TdmSysPed.SetOrderDelivery(APk: Integer; const Value: TOrder);
var
  M: TMemoryStream;
begin
  if qrDeliveryPeriod.Active then qrDeliveryPeriod.Close;
  qrDeliveryPeriod.SQL.Clear;
  if (Value.UfEntr = '') or (Value.MunEntr <= 0) or
     (Value.EndEntr.Text = '') then
      qrDeliveryPeriod.SQL.Add(SqlDeletePedEntr)
  else
    if (TDbMode(APk) = dbmInsert) then
      qrDeliveryPeriod.SQL.Add(SqlInsertPedEntr)
    else
      if (TDbMode(APk) = dbmEdit) then
        qrDeliveryPeriod.SQL.Add(SqlUpdatePedEntr);
  if qrDeliveryPeriod.SQL.Text = '' then exit;
  qrDeliveryPeriod.ParamByName('FkEmpresas').AsInteger         := Value.FkCompany.PkCompany;
  qrDeliveryPeriod.ParamByName('FkPedidos').AsInteger          := Value.PkOrder;
  if (qrDeliveryPeriod.Params.FindParam('UfEntr') <> nil) then
    qrDeliveryPeriod.ParamByName('UfEntr').AsString            := Value.UfEntr;
  if (qrDeliveryPeriod.Params.FindParam('FkMunicipios') <> nil) then
    qrDeliveryPeriod.ParamByName('FkMunicipios').AsInteger     := Value.MunEntr;
  if (qrDeliveryPeriod.Params.FindParam('EndEntr') <> nil) then
  begin
    M := TMemoryStream.Create;
    try
      M.Position := 0;
      Value.EndEntr.SaveToStream(M);
      M.Position := 0;
      qrDeliveryPeriod.ParamByName('EndEntr').LoadFromStream(M, ftMemo);
    finally
      FreeAndNil(M);
    end;
  end;
  qrDeliveryPeriod.ExecSQL;
end;

function TdmSysPed.GetGroupMovement(APk: Integer): TMovement;
begin
  if qrTypeMovement.Active then qrTypeMovement.Close;
  qrTypeMovement.SQL.Clear;
  qrTypeMovement.SQL.Add(SqlGroupMovement);
  Dados.StartTransaction(qrTypeMovement);
  try
    qrTypeMovement.ParamByName('PkGruposMovimentos').AsInteger := APk;
    if not qrTypeMovement.Active then qrTypeMovement.Open;
    Result                 := TMovement.Create;
    with Result do
    begin
      DscMov          := qrTypeMovement.FieldByName('DSC_GMOV').AsString;
      FlagCns         := False;
      FlagCod         := TCodeType(qrTypeMovement.FieldByName('FLAG_COD').AsInteger);
      FlagDev         := Boolean(qrTypeMovement.FieldByName('FLAG_DEV').AsInteger);
      FlagDspa        := Boolean(qrTypeMovement.FieldByName('FLAG_DSPA').AsInteger);
      FlagDsti        := TOrigimDestination(qrTypeMovement.FieldByName('FLAG_ORGM').AsInteger);
      FlagES          := TInOut(qrTypeMovement.FieldByName('FLAG_ES').AsInteger);
      FlagEstq        := Boolean(qrTypeMovement.FieldByName('FLAG_ESTQ').AsInteger);
      FlagGFin        := Boolean(qrTypeMovement.FieldByName('FLAG_GFIN').AsInteger);
      FlagGrnt        := TTypeGuarantee(qrTypeMovement.FieldByName('FLAG_GRNT').AsInteger);
      FlagOrgm        := TOrigimDestination(qrTypeMovement.FieldByName('FLAG_DSTI').AsInteger);
      PkGroupMovement := qrTypeMovement.FieldByName('PK_GRUPOS_MOVIMENTOS').AsInteger;
    end;
  finally
    if qrTypeMovement.Active then qrTypeMovement.Close;
    Dados.CommitTransaction(qrTypeMovement);
  end;
end;

procedure TdmSysPed.SetGroupMovement(APk: Integer; const Value: TMovement);
  function GetPkGroupMovement: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkGrMovement);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_GRUPOS_MOVIMENTOS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrTypeMovement.Active then qrTypeMovement.Close;
  qrTypeMovement.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTypeMovement.SQL.Add(SqlDelGrMovement);
    dbmEdit  : qrTypeMovement.SQL.Add(SqlUpdGrMovement);
    dbmInsert: qrTypeMovement.SQL.Add(SqlInsGrMovement);
  end;
  Dados.StartTransaction(qrTypeMovement);
  try
    with Value do
    begin
      if (PkGroupMovement = 0) then
        PkGroupMovement := GetPkGroupMovement;
      qrTypeMovement.ParamByName('PkGruposMovimentos').AsInteger := PkGroupMovement;
      if (qrTypeMovement.Params.FindParam('DscGMov') <> nil) then
        qrTypeMovement.ParamByName('DscGMov').AsString             := DscMov;
      if (qrTypeMovement.Params.FindParam('FlagCod') <> nil) then
        qrTypeMovement.ParamByName('FlagCod').AsInteger            := Ord(FlagCod);
      if (qrTypeMovement.Params.FindParam('FlagDev') <> nil) then
        qrTypeMovement.ParamByName('FlagDev').AsInteger            := Ord(FlagDev);
      if (qrTypeMovement.Params.FindParam('FlagDspa') <> nil) then
        qrTypeMovement.ParamByName('FlagDspa').AsInteger           := Ord(FlagDspa);
      if (qrTypeMovement.Params.FindParam('FlagOrgm') <> nil) then
        qrTypeMovement.ParamByName('FlagOrgm').AsInteger           := Ord(FlagDsti);
      if (qrTypeMovement.Params.FindParam('FlagES') <> nil) then
        qrTypeMovement.ParamByName('FlagES').AsInteger             := Ord(FlagES);
      if (qrTypeMovement.Params.FindParam('FlagEstq') <> nil) then
        qrTypeMovement.ParamByName('FlagEstq').AsInteger           := Ord(FlagEstq);
      if (qrTypeMovement.Params.FindParam('FlagGFin') <> nil) then
        qrTypeMovement.ParamByName('FlagGFin').AsInteger           := Ord(FlagGFin);
      if (qrTypeMovement.Params.FindParam('FlagGrnt') <> nil) then
        qrTypeMovement.ParamByName('FlagGrnt').AsInteger           := Ord(FlagGrnt);
      if (qrTypeMovement.Params.FindParam('FlagDsti') <> nil) then
        qrTypeMovement.ParamByName('FlagDsti').AsInteger           := Ord(FlagOrgm);
    end;
    qrTypeMovement.ExecSQL;
    Dados.CommitTransaction(qrTypeMovement);
  except on E:Exception do
    begin
      if qrTypeMovement.Active then qrTypeMovement.Close;
      Dados.RollbackTransaction(qrTypeMovement);
      raise Exception.Create('SetGroupMovement: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrTypeMovement.SQL.Text);
    end;
  end;
end;

function TdmSysPed.LoadNatureOperation(const AType: TInOut;
  const AOrgm: TOrgmNatOpe): TStrings;
var
  S: PAnsiChar;
  Str: string;
const
  PK_VALUES_ADD: array [TInOut, TOrgmNatOpe] of integer =
    ((1, 2, 3), (5, 6, 7));
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlNatureOperation);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkTipoCfop').AsInteger := PK_VALUES_ADD[AType, AOrgm];
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    while (not qrSqlAux.Eof) do
    begin
      GetMem(S, 6);
      Str := qrSqlAux.FieldByName('COD_CFOP').AsString;
      StrCopy(S, PAnsiChar(Str));
      Result.AddObject(qrSqlAux.FieldByName('COD_CFOP').AsString + ' | ' +
        qrSqlAux.FieldByName('DSC_NTOP').AsString, TObject(S));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysPed.LoadClassifications(AType: Integer): TStrings;
var
  aClass: TClassification;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlClassDBCR);
  Dados.StartTransaction(qrSqlAux);
  try
    if qrSqlAux.Params.FindParam('FlagTCta') <> nil then
      qrSqlAux.Params.FindParam('FlagTCta').AsInteger := AType;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.AddObject('<Nenhum>', nil);
      while not qrSqlAux.Eof do
      begin
        aClass               := TClassification.Create;
        aClass.Pk            := qrSqlAux.FieldByName('R_PK_FINANCEIRO_CONTAS').AsInteger;
        aClass.FkAccountPlan := qrSqlAux.FieldByName('R_FK_FINANCEIRO_CONTAS').AsInteger;
        aClass.MaskCta       := qrSqlAux.FieldByName('R_MASK_CTA').AsString;
        aClass.DscClass      := qrSqlAux.FieldByName('R_DSC_CTA').AsString;
        aClass.NivCta        := qrSqlAux.FieldByName('R_GRAU_CTA').AsInteger;
        aClass.SeqCta        := qrSqlAux.FieldByName('R_SEQ_CTA').AsInteger;
        aClass.FlagAnlSnt    := Boolean(qrSqlAux.FieldByName('R_FLAG_ANL_SNT').AsInteger);
        aClass.FlagTCta      := TAccountNat(qrSqlAux.FieldByName('R_FLAG_TCTA').AsInteger);
        aClass.cbIndex       := Result.AddObject(InsereSpc(aClass.DscClass, 50) +
                                ' | ' + aClass.MaskCta, aClass);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysPed.GetTypeMovement(APk: Integer): TMovement;
begin
  if qrTypeMovement.Active then qrTypeMovement.Close;
  qrTypeMovement.SQL.Clear;
  qrTypeMovement.SQL.Add(SqlTypeMovement);
  Dados.StartTransaction(qrTypeMovement);
  try
    qrTypeMovement.ParamByName('FkGruposMovimentos').AsInteger := FPkGroupMoviment;
    qrTypeMovement.ParamByName('PkTipoMovimentos').AsInteger   := APk;
    if not qrTypeMovement.Active then qrTypeMovement.Open;
    Result                 := TMovement.Create;
    with Result do
    begin
      DscMov          := qrTypeMovement.FieldByName('DSC_TMOV').AsString;
      FlagCns         := Boolean(qrTypeMovement.FieldByName('FLAG_CNS').AsInteger);
      FlagLdv         := Boolean(qrTypeMovement.FieldByName('FLAG_LDV').AsInteger);
      FlagExp         := Boolean(qrTypeMovement.FieldByName('FLAG_EXP').AsInteger);
      NatOpeDe        := qrTypeMovement.FieldByName('NAT_OPE_DE').AsString;
      NatOpeFe        := qrTypeMovement.FieldByName('NAT_OPE_FE').AsString;
      NatOpeEx        := qrTypeMovement.FieldByName('NAT_OPE_EX').AsString;
      PkGroupMovement := qrTypeMovement.FieldByName('FK_GRUPOS_MOVIMENTOS').AsInteger;
      PkTypeMovement  := qrTypeMovement.FieldByName('PK_TIPO_MOVIMENTOS').AsInteger;
    end;
  finally
    if qrTypeMovement.Active then qrTypeMovement.Close;
    Dados.CommitTransaction(qrTypeMovement);
  end;
end;

procedure TdmSysPed.SetTypeMovement(APk: Integer; const Value: TMovement);
  function GetPkTypeMovement(const AFk: Integer): Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkTypeMov);
    try
      qrSqlAux.ParamByName('FkGruposMovimentos').AsInteger := AFk;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_TIPO_MOVIMENTOS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrTypeMovement.Active then qrTypeMovement.Close;
  qrTypeMovement.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTypeMovement.SQL.Add(SqlDelTpMovement);
    dbmEdit  : qrTypeMovement.SQL.Add(SqlUpdTpMovement);
    dbmInsert: qrTypeMovement.SQL.Add(SqlInsTpMovement);
  end;
  Dados.StartTransaction(qrTypeMovement);
  try
    with Value do
    begin
      if (PkTypeMovement = 0) then
        PkTypeMovement := GetPkTypeMovement(PkGroupMovement);
      qrTypeMovement.ParamByName('FkGruposMovimentos').AsInteger := PkGroupMovement;
      qrTypeMovement.ParamByName('PkTipoMovimentos').AsInteger   := PkTypeMovement;
      if (qrTypeMovement.Params.FindParam('DscTMov') <> nil) then
        qrTypeMovement.ParamByName('DscTMov').AsString             := DscMov;
      if (qrTypeMovement.Params.FindParam('FlagCns') <> nil) then
        qrTypeMovement.ParamByName('FlagCns').AsInteger            := Ord(FlagCns);
      if (qrTypeMovement.Params.FindParam('FlagExp') <> nil) then
        qrTypeMovement.ParamByName('FlagExp').AsInteger            := Ord(FlagExp);
      if (qrTypeMovement.Params.FindParam('FlagLdv') <> nil) then
        qrTypeMovement.ParamByName('FlagLdv').AsInteger            := Ord(FlagLdv);
      if (qrTypeMovement.Params.FindParam('NatOpeDe') <> nil) then
        qrTypeMovement.ParamByName('NatOpeDe').AsString            := NatOpeDe;
      if (qrTypeMovement.Params.FindParam('NatOpeFe') <> nil) then
        qrTypeMovement.ParamByName('NatOpeFe').AsString            := NatOpeFe;
      if (qrTypeMovement.Params.FindParam('NatOpeEx') <> nil) then
        qrTypeMovement.ParamByName('NatOpeEx').AsString            := NatOpeEx;
    end;
    qrTypeMovement.ExecSQL;
    Dados.CommitTransaction(qrTypeMovement);
  except on E:Exception do
    begin
      if qrTypeMovement.Active then qrTypeMovement.Close;
      Dados.RollbackTransaction(qrTypeMovement);
      raise Exception.Create('SetTypeMovement: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrTypeMovement.SQL.Text);
    end;
  end;
end;

function TdmSysPed.GetTypePayment(APk: Integer): TTypePayment;
begin
  if qrTypePayment.Active then qrTypePayment.Close;
  qrTypePayment.SQL.Clear;
  qrTypePayment.SQL.Add(SqlTypePayment);
  Dados.StartTransaction(qrTypePayment);
  try
    qrTypePayment.ParamByName('FkGruposMovimentos').AsInteger := FPkGroupMoviment;
    qrTypePayment.ParamByName('PkTipoPagamentos').AsInteger   := APk;
    if not qrTypePayment.Active then qrTypePayment.Open;
    Result       := TTypePayment.Create;
    with Result do
    begin
      PkTypePgto      := qrTypePayment.FieldByName('PK_TIPO_PAGAMENTOS').AsInteger;
      FkGroupMovement := qrTypePayment.FieldByName('FK_GRUPOS_MOVIMENTOS').AsInteger;
      DscTPgt         := qrTypePayment.FieldByName('DSC_TPG').AsString;
      QtdParc         := qrTypePayment.FieldByName('QTD_PARC').AsInteger;
      FlagBaseDate    := TBaseDate(qrTypePayment.FieldByName('FLAG_BDATE').AsInteger);
      FlagTInt        := TIntervalPay(qrTypePayment.FieldByName('FLAG_TINTV').AsInteger);
      FlagBlock       := Boolean(qrTypePayment.FieldByName('FLAG_BLOQ').AsInteger);
      FlagTVda        := TTypeSale(qrTypePayment.FieldByName('FLAG_TVDA').AsInteger);
      DspFin          := qrTypePayment.FieldByName('DSP_FIN').AsFloat;
    end;
  finally
    if qrTypePayment.Active then qrTypePayment.Close;
    Dados.CommitTransaction(qrTypePayment);
  end;
end;

procedure TdmSysPed.SetTypePayment(APk: Integer; const Value: TTypePayment);
var
  aWhr: TStrings;
  function GetPkTypePayment: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenTypePayment);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_TIPO_PAGAMENTOS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrTypePayment.Active then qrTypePayment.Close;
  qrTypePayment.SQL.Clear;
  aWhr := TStringList.Create;
  try
    aWhr.Add('PK_TIPO_PAGAMENTOS');
    aWhr.Add('FK_GRUPOS_MOVIMENTOS');
    case TDBMode(APk) of
      dbmDelete: qrTypePayment.SQL.Add(SqlDeleteTypePgto);
      dbmEdit  : qrTypePayment.SQL.AddStrings(GetUpdateSQL(Value.GetFields, aWhr, 'TIPO_PAGAMENTOS'));
      dbmInsert: qrTypePayment.SQL.AddStrings(GetInsertSQL(Value.GetFields, 'TIPO_PAGAMENTOS'));
    end;
  finally
    FreeAndNil(aWhr);
  end;
  Dados.StartTransaction(qrTypePayment);
  try
    with Value do
    begin
      if (PkTypePgto = 0) then
        PkTypePgto := GetPkTypePayment;
      qrTypePayment.ParamByName('FkGruposMovimentos').AsInteger  := FPkGroupMoviment;
      qrTypePayment.ParamByName('PkTipoPagamentos').AsInteger    := PkTypePgto;
      if (qrTypePayment.Params.FindParam('OldFkGruposMovimentos') <> nil) then
        qrTypePayment.ParamByName('OldFkGruposMovimentos').AsInteger := FPkGroupMoviment;
      if (qrTypePayment.Params.FindParam('OldPkTipoPagamentos') <> nil) then
        qrTypePayment.ParamByName('OldPkTipoPagamentos').AsInteger := PkTypePgto;
      if (qrTypePayment.Params.FindParam('DscTPg') <> nil) then
        qrTypePayment.ParamByName('DscTPg').AsString             := DscTPgt;
      if (qrTypePayment.Params.FindParam('QtdParc') <> nil) then
        qrTypePayment.ParamByName('QtdParc').AsInteger           := QtdParc;
      if (qrTypePayment.Params.FindParam('FlagBDate') <> nil) then
        qrTypePayment.ParamByName('FlagBDate').AsInteger         := Ord(FlagBaseDate);
      if (qrTypePayment.Params.FindParam('FlagTIntv') <> nil) then
        qrTypePayment.ParamByName('FlagTIntv').AsInteger         := Ord(FlagTInt);
      if (qrTypePayment.Params.FindParam('FlagBloq') <> nil) then
        qrTypePayment.ParamByName('FlagBloq').AsInteger          := Ord(FlagBlock);
      if (qrTypePayment.Params.FindParam('FlagTVda') <> nil) then
        qrTypePayment.ParamByName('FlagTVda').AsInteger          := Ord(FlagTVda);
      if (qrTypePayment.Params.FindParam('DspFin') <> nil) then
        qrTypePayment.ParamByName('DspFin').AsFloat              := DspFin;
    end;
    qrTypePayment.ExecSQL;
    Dados.CommitTransaction(qrTypePayment);
  except on E:Exception do
    begin
      if qrTypePayment.Active then qrTypePayment.Close;
      Dados.RollbackTransaction(qrTypePayment);
      raise Exception.Create('SetTypeOrder: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrTypePayment.SQL.Text);
    end;
  end;
end;

function TdmSysPed.GetTypeDiscount(APk: Integer): TTypeDiscount;
begin
  with qrTypeDiscount do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlTypeDiscount);
    Dados.StartTransaction(qrTypeDiscount);
    try
      ParamByName('FkGruposMovimentos').AsInteger := FPkGroupMoviment;
      ParamByName('PkTipoDescontos').AsInteger    := APk;
      if (not Active) then Open;
      Result := TTypeDiscount.Create;
      Result.PkTypeDiscount := FieldByName('PK_TIPO_DESCONTOS').AsInteger;
      Result.DscDsct        := FieldByName('DSC_TDSCT').AsString;
      if (not FieldByName('PK_DESCONTOS').IsNull) then
      begin
        while (not EOF) do
        begin
          with Result.Discounts.Add do
          begin
            FkState.FkCountry.PKCountry := FieldByName('FK_PAISES').AsInteger;
            FkState.FkCountry.DscPais   := FieldByName('DSC_PAIS').AsString;
            FkState.PkState             := FieldByName('FK_ESTADOS').AsString;
            FkState.DscUF               := FieldByName('DSC_UF').AsString;
            FkCategory.PkCategory       := FieldByName('FK_CATEGORIAS').AsInteger;
            FkCategory.DscCat           := FieldByName('DSC_CAT').AsString;
            IdxDsct                     := FieldByName('IDX_DSCT').AsFloat;
            FlagTDsct                   := TTypeOperation(FieldByName('FLAG_TDSCT').AsInteger);
            FlagDstq                    := Boolean(FieldByName('FLAG_DSTQ').AsInteger);
          end;
          Next;
        end;
      end;
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrTypeDiscount);
    end;
  end;
end;

procedure TdmSysPed.SetTypeDiscount(APk: Integer; const Value: TTypeDiscount);
var
  i: Integer;
  S: string;
  function GetPkTypeDiscount: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenTypeDiscount);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_TIPO_DESCONTOS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (Value = nil) or (not (TDBMode(APk) in UPDATE_MODE)) then exit;
  with qrTypeDiscount do
  begin
    if (Active) then Close;
    SQL.Clear;
    case TDBMode(APk) of
      dbmInsert: SQL.Add(SqlInsTypeDiscount);
      dbmEdit  : SQL.Add(SqlUpdTypeDiscount);
      dbmDelete: SQL.Add(SqlDelTypeDiscount);
    end;
    Dados.StartTransaction(qrTypeDiscount);
    try
      if (Value.PkTypeDiscount = 0) then
        Value.PkTypeDiscount := GetPkTypeDiscount;
      FieldByName('FkGruposMovimentos').AsInteger := FPkGroupMoviment;
      FieldByName('PkTipoDescontos').AsInteger    := Value.PkTypeDiscount;
      if (FindField('DscTDsct') <> nil) then
        FieldByName('DscTDsct').AsString     := Value.DscDsct;
      if (FindField('KcDescontos') <> nil) then
        FieldByName('KcDescontos').AsInteger := 0;
      ExecSql;
      // delete all Indexes
      for i := 0 to Value.Discounts.Count - 1 do
      begin
        SQL.Clear;
        S := SqlInsertDiscounts;
        if (Value.Discounts.Items[i].FkCategory.PkCategory = 0) then
          S := StringReplace(S, ':FkCategorias', 'null', [rfReplaceAll]);
        if (Value.Discounts.Items[i].FkState.FkCountry.PKCountry = 0) then
          S := StringReplace(S, ':FkPaises', 'null', [rfReplaceAll]);
        if (Value.Discounts.Items[i].FkState.FkCountry.PKCountry = 0) then
          S := StringReplace(S, ':FkEstados', 'null', [rfReplaceAll]);
        Sql.Add(S);
        ParamByName('FkTipoDescontos').AsInteger := Value.PkTypeDiscount;
        with Value.Discounts.Items[i] do
        begin
          ParamByName('PkDescontos').AsInteger    := Index;
          if (Params.FindParam('FkCategorias') <> nil) then
            ParamByName('FkCategorias').AsInteger := FkCategory.PkCategory;
          if (Params.FindParam('FkPaises') <> nil) then
            ParamByName('FkPaises').AsInteger     := FkState.FkCountry.PKCountry;
          if (Params.FindParam('FkEstados') <> nil) then
            ParamByName('FkEstados').AsString     := FkState.PkState;
          ParamByName('IdxDsct').AsFloat          := IdxDsct;
          ParamByName('FlagDstq').AsInteger       := Ord(FlagDstq);
          ParamByName('FlagTDsct').AsInteger      := Ord(FlagTDsct);
        end;
        ExecSQL;
      end;
      Dados.CommitTransaction(qrTypeDiscount);
    except on E:Exception do
      begin
        if (Active) then Close;
        Dados.RollbackTransaction(qrTypeDiscount);
        raise Exception.Create('SetTypeDiscount: Erro ao gravar o registro!' + NL +
          E.Message + NL + SQL.Text);
      end;
    end;
  end;
end;

function TdmSysPed.GetTypeStatusOrd(APk: Integer): TDataRow;
begin
  with qrStatusOrder do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlTypeStatus);
    Dados.StartTransaction(qrStatusOrder);
    try
      ParamByName('FkGruposMovimentos').AsInteger  := FPkGroupMoviment;
      ParamByName('PkTipoStatusPedidos').AsInteger := APk;
      if (not Active) then Open;
      Result := TDataRow.CreateFromDataSet(nil, qrStatusOrder, True);
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrStatusOrder);
    end;
  end;
end;

procedure TdmSysPed.SetTypeStatusOrd(APk: Integer; const Value: TDataRow);
var
  aStr: string;
  function GetPkSttOrder: Integer;
  begin
    with qrSqlAux do
    begin
      if (Active) then Close;
      SQL.Clear;
      SQL.Add(SqlGenTypeStatus);
      if (not Active) then Open;
      try
        Result := FieldByName('PK_TIPO_STATUS_PEDIDOS').AsInteger;
        if (Result = 0) then Result := 1;
      finally
        if (Active) then Close;
      end;
    end;
  end;
begin
  with qrStatusOrder do
  begin
    if (Active) then Close;
    SQL.Clear;
    case TDBMode(APk) of
      dbmInsert: aStr := SqlInsertTypeStt;
      dbmEdit  : aStr := SqlUpdateTypeStt;
      dbmDelete: aStr := SqlDeleteTypeStt;
    end;
    if (Value.FieldByName['FK_TIPO_MOVIM_ESTQ'].AsInteger <= 0) then
      aStr := StringReplace(aStr, ':FkTipoMovimEstq', 'null', [rfReplaceAll]);
    SQL.Add(aStr);
    Dados.StartTransaction(qrStatusOrder);
    try
      if (Value.FieldByName['PK_TIPO_STATUS_PEDIDOS'].AsInteger = 0) then
        Value.FieldByName['PK_TIPO_STATUS_PEDIDOS'].AsInteger := GetPkSttOrder;
      ParamByName('FkGruposMovimentos').AsInteger  := FPkGroupMoviment;
      ParamByName('PkTipoStatusPedidos').AsInteger := Value.FieldByName['PK_TIPO_STATUS_PEDIDOS'].AsInteger;
      if (Params.FindParam('FkTipoMovimEstq') <> nil) then
        ParamByName('FkTipoMovimEstq').AsInteger := Value.FieldByName['FK_TIPO_MOVIM_ESTQ'].AsInteger;
      if (Params.FindParam('DscStt') <> nil) then
        ParamByName('DscStt').AsString           := Value.FieldByName['DSC_STT'].AsString;
      if (Params.FindParam('QtdDaysNext') <> nil) then
        ParamByName('QtdDaysNext').AsInteger     := Value.FieldByName['QTD_DAYS_NEXT'].AsInteger;
      if (Params.FindParam('FlagOpen') <> nil) then
        ParamByName('FlagOpen').AsInteger        := Value.FieldByName['FLAG_OPEN'].AsInteger;
      if (Params.FindParam('FlagRecb') <> nil) then
        ParamByName('FlagRecb').AsInteger        := Value.FieldByName['FLAG_RECB'].AsInteger;
      if (Params.FindParam('FlagLib') <> nil) then
        ParamByName('FlagLib').AsInteger         := Value.FieldByName['FLAG_LIB'].AsInteger;
      if (Params.FindParam('FlagCanc') <> nil) then
        ParamByName('FlagCanc').AsInteger        := Value.FieldByName['FLAG_CANC'].AsInteger;
      if (Params.FindParam('FlagProd') <> nil) then
        ParamByName('FlagProd').AsInteger        := Value.FieldByName['FLAG_PROD'].AsInteger;
      if (Params.FindParam('FlagFat') <> nil) then
        ParamByName('FlagFat').AsInteger         := Value.FieldByName['FLAG_FAT'].AsInteger;
      if (Params.FindParam('FlagLiq') <> nil) then
        ParamByName('FlagLiq').AsInteger         := Value.FieldByName['FLAG_LIQ'].AsInteger;
      if (Params.FindParam('FlagTPed') <> nil) then
        ParamByName('FlagTPed').AsInteger        := Value.FieldByName['FLAG_TPED'].AsInteger;
      ExecSql;
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrStatusOrder);
    end;
  end;
end;

function  TdmSysPed.GetDeliveryPeriod(APk: Integer): TDataRow;
begin
  with qrDeliveryPeriod do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlDeliveryPeriod);
    Dados.StartTransaction(qrDeliveryPeriod);
    try
      ParamByName('PkTipoPrazoEntrega').AsInteger := APk;
      if (not Active) then Open;
      Result := TDataRow.CreateFromDataSet(nil, qrDeliveryPeriod, True);
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrDeliveryPeriod);
    end;
  end;
end;

function  TdmSysPed.GetTypeFreight(APk: Integer): TDataRow;
begin
  with qrTypeFreight do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlTypeFreight);
    Dados.StartTransaction(qrTypeFreight);
    try
      ParamByName('PkTipoFretes').AsInteger := APk;
      if (not Active) then Open;
      Result := TDataRow.CreateFromDataSet(nil, qrTypeFreight, True);
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrTypeFreight);
    end;
  end;
end;

procedure TdmSysPed.SetDeliveryPeriod(APk: Integer; const Value: TDataRow);
  function GetDeliveryPk: Integer;
  begin
    with qrSqlAux do
    begin
      if (Active) then Close;
      SQL.Clear;
      SQL.Add(SqlGenPkDelivery);
      try
        if (not Active) then Open;
        Result := FieldByName('PK_TIPO_PRAZO_ENTREGA').AsInteger;
        if (Result = 0) then Result := 1;
      finally
        if (Active) then Close;
      end;
    end;
  end;
begin
  with qrDeliveryPeriod do
  begin
    if (Active) then Close;
    SQL.Clear;
    case TDBMode(APk) of
      dbmInsert: SQL.Add(SqlInsertDelivery);
      dbmEdit  : SQL.Add(SqlUpdateDelivery);
      dbmDelete: SQL.Add(SqlDeleteDelivery);
    end;
    Dados.StartTransaction(qrDeliveryPeriod);
    try
      if (Value.FieldByName['PK_TIPO_PRAZO_ENTREGA'].AsInteger = 0) then
        Value.FieldByName['PK_TIPO_PRAZO_ENTREGA'].AsInteger := GetDeliveryPk;
      ParamByName('PkTipoPrazoEntrega').AsInteger := Value.FieldByName['PK_TIPO_PRAZO_ENTREGA'].AsInteger;
      if (Params.FindParam('DscPrzE') <> nil) then
        ParamByName('DscPrzE').AsString := Value.FieldByName['DSC_PRZE'].AsString;
      if (Params.FindParam('QtdPrv') <> nil) then
        ParamByName('QtdPrv').AsInteger := Value.FieldByName['QTD_PRV'].AsInteger;
      ExecSQL;
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrDeliveryPeriod);
    end;
  end;
end;

procedure TdmSysPed.SetTypeFreight(APk: Integer; const Value: TDataRow);
var
  aStr: string;
  function GetTypeFreighyPk: Integer;
  begin
    with qrSqlAux do
    begin
      if (Active) then Close;
      SQL.Clear;
      SQL.Add(SqlGenPkTpFreight);
      try
        if (not Active) then Open;
        Result := FieldByName('PK_TIPO_FRETES').AsInteger;
        if (Result = 0) then Result := 1;
      finally
        if (Active) then Close;
      end;
    end;
  end;
begin
  with qrTypeFreight do
  begin
    if (Active) then Close;
    SQL.Clear;
    case TDBMode(APk) of
      dbmInsert: aStr := SqlInsTypeFreight;
      dbmEdit  : aStr := SqlUpdTypeFreight;
      dbmDelete: aStr := SqlDelTypeFreight;
    end;
    if (Value.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger = 0) then
      aStr := StringReplace(aStr, ':FkTipoPagamentos', 'null', [rfReplaceAll]);
    if (Value.FieldByName['FK_CLASSIFICACAO'].AsInteger = 0) then
      aStr := StringReplace(aStr, ':FkClassificacao', 'null', [rfReplaceAll]);
    SQL.Add(aStr);
    Dados.StartTransaction(qrTypeFreight);
    try
      if (Value.FieldByName['PK_TIPO_FRETES'].AsInteger = 0) then
        Value.FieldByName['PK_TIPO_FRETES'].AsInteger := GetTypeFreighyPk;
      ParamByName('PkTipoFretes').AsInteger := Value.FieldByName['PK_TIPO_FRETES'].AsInteger;
      if (Params.FindParam('FkTipoPagamentos') <> nil) then
        ParamByName('FkTipoPagamentos').AsInteger := Value.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger;
      if (Params.FindParam('FkClassificacao') <> nil) then
        ParamByName('FkClassificacao').AsInteger := Value.FieldByName['FK_CLASSIFICACAO'].AsInteger;
      if (Params.FindParam('DscTpFre') <> nil) then
        ParamByName('DscTpFre').AsString := Value.FieldByName['DSC_TPFRE'].AsString;
      if (Params.FindParam('FlagTpFre') <> nil) then
        ParamByName('FlagTpFre').AsInteger := Value.FieldByName['FLAG_TP_FRE'].AsInteger;
      if (Params.FindParam('FlagFin') <> nil) then
        ParamByName('FlagFin').AsInteger := Value.FieldByName['FLAG_FIN'].AsInteger;
      if (Params.FindParam('FlagAcu') <> nil) then
        ParamByName('FlagAcu').AsInteger := Value.FieldByName['FLAG_ACU'].AsInteger;
      if (Params.FindParam('FlagNf') <> nil) then
        ParamByName('FlagNf').AsInteger := Value.FieldByName['FLAG_NF'].AsInteger;
      ExecSQL;
      Dados.CommitTransaction(qrTypeFreight);
    except on E:Exception do
      begin
        if (Active) then Close;
        Dados.RollbackTransaction(qrTypeFreight);
        raise Exception.Create('SetTypeFreight: Erro ao gravar registro!' + NL +
          E.Message + NL + Sql.Text);
      end;
    end;
  end;
end;

function TdmSysPed.LoadMovimentEstq(const AType: TInOut): TStrings;
begin
  Result := TStringList.Create;
  if qrSqlAux.Active then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlMovimEstq);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FlagTMov').AsInteger := Ord(AType);
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_TMOV').AsString,
        TObject(qrSqlAux.FieldByName('PK_TIPO_MOVIM_ESTQ').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if qrSqlAux.Active then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysPed.GetParamsPed(APk: Integer): TDataRow;
begin
  with qrParamPed do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlParamPed);
    Dados.StartTransaction(qrParamPed);
    try
      ParamByName('FkEmpresas').AsInteger := APk;
      if (not Active) then Open;
      Result := TDataRow.CreateFromDataSet(nil, qrParamPed, True);
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrParamPed);
    end;
  end;
end;

procedure TdmSysPed.SetParamsPed(APk: Integer; const Value: TDataRow);
begin
  with qrParamPed do
  begin
    if (Active) then Close;
    SQL.Clear;
    case TDBMode(APk) of
      dbmInsert: SQL.Add(SqlInsertParamPed);
      dbmEdit  : SQL.Add(SqlUpdateParamPed);
      dbmDelete: SQL.Add(SqlDeleteParamPed);
    end;
    Dados.StartTransaction(qrParamPed);
    try
      ParamByName('FkEmpresas').AsInteger           := Value.FieldByName['FK_EMPRESAS'].AsInteger;
      if (Params.FindParam('FkTipoPedidos') <> nil) then
        ParamByName('FkTipoPedidos').AsInteger      := Value.FieldByName['FK_TIPO_PEDIDOS'].AsInteger;
      if (Params.FindParam('FkTipoPrazoEntrega') <> nil) then
        ParamByName('FkTipoPrazoEntrega').AsInteger := Value.FieldByName['FK_TIPO_PRAZO_ENTREGA'].AsInteger;
      if (Params.FindParam('FkStatusPedidos') <> nil) then
        ParamByName('FkStatusPedidos').AsInteger    := Value.FieldByName['FK_TIPO_STATUS_PEDIDOS'].AsInteger;
      if (Params.FindParam('PrzValOrc') <> nil) then
        ParamByName('PrzValOrc').AsInteger          := Value.FieldByName['PRZ_VAL_ORC'].AsInteger;
      if (Params.FindParam('PrzEntr') <> nil) then
        ParamByName('PrzEntr').AsInteger            := Value.FieldByName['PRZ_ENTR'].AsInteger;
      if (Params.FindParam('FlagItmDsct') <> nil) then
        ParamByName('FlagItmDsct').AsInteger        := Value.FieldByName['FLAG_ITM_DSCT'].AsInteger;
      ExecSQL;
      Dados.CommitTransaction(qrParamPed);
    except on E:Exception do
      begin
        if (Active) then Close;
        Dados.RollbackTransaction(qrParamPed);
        raise Exception.Create('SetParamsPed: Erro ao gravar registro!' + NL +
          E.Message + NL + Sql.Text);
      end;
    end;
  end;
end;

procedure TdmSysPed.SetPaymentWay(APk: Integer; const Value: TDataRow);
begin
  if (qrPgtWay.Active) then qrPgtWay.Close;
  qrPgtWay.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrPgtWay.SQL.Add(SqlDeletePgtWay);
    dbmInsert: qrPgtWay.SQL.Add(SqlInsertPgtWay);
    dbmEdit  : qrPgtWay.SQL.Add(SqlUpdatePgtWay);
  end;
  Dados.StartTransaction(qrPgtWay);
  try
    qrPgtWay.ParamByName('FkTipoPagamentos').AsInteger     := Value.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger;
    qrPgtWay.ParamByName('FkFinalizadoras').AsInteger      := Value.FieldByName['PK_FINALIZADORAS'].AsInteger;
    if (qrPgtWay.Params.FindParam('FkFinanceiroContas') <> nil) then
      qrPgtWay.ParamByName('FkFinanceiroContas').AsInteger := Value.FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger;
    qrPgtWay.ExecSQL;
    Dados.CommitTransaction(qrPgtWay);
  except on E:Exception do
    begin
      if (qrPgtWay.Active) then qrPgtWay.Close;
      Dados.RollbackTransaction(qrPgtWay);
      raise Exception.Create('SetPaymentWay: Erro ao gravar registro!' + NL +
        E.Message + NL + qrPgtWay.Sql.Text);
    end;
  end;
end;

initialization
  Application.CreateForm(TdmSysPed, dmSysPed);
finalization
  if Assigned(dmSysPed) then dmSysPed.Free;
  dmSysPed := nil;
end.
