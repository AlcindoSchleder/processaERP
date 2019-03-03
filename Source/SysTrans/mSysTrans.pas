unit mSysTrans;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 10/07/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
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

uses Windows, SysUtils, DB, Encryp, ProcType, FMTBcd, SqlExpr, Classes, Forms,
  GridRow, ProcUtils, TSysFatAux, TSysBcCx, TSysPedAux, TSysTrans, TSysCadAux,
  Dialogs, TSysCad, TSysPed, Graphics;

type
  TTypeEmployee  = (teDriver, tePorter, teSurveyor);

  TDocumentType  = (dtSimulator, dtDocument, dtOrderToDoc);
  TDocumentTypes = set of TDocumentType;

  TVehicleImage  = record
    Image: TPicture;
    Name : string;
    State: TDBMode;
    Pk   : Integer;
  end;
  PVehicleImage = ^TVehicleImage;

  TCarrierPrice = packed record
    Status    : Integer;
    PercDsct  : Double;
    FlagDefTab: Boolean;
    VlrFrePeso: Double;
    FreVlr    : Double;
    VlrSecat  : Double;
    VlrGris   : Double;
    VlrPedg   : Double;
    VlrDifAcc : Double;
    RedBasc   : Double;
    AlqtICMS  : Double;
    BasICMS   : Double;
    VlrICMS   : Double;
    SubTot    : Double;
    VlrAcrDsct: Double;
    DsctItem  : Double;
    TotDoc    : Double;
  end;

  TdmSysTrans = class(TDataModule)
    qrCarrierOrder: TSQLQuery;
    qrSqlAux: TSQLQuery;
    qrOrders: TSQLQuery;
    qrTypeDiscount: TSQLQuery;
    qrOrderMessage: TSQLQuery;
    qrInstallments: TSQLQuery;
    qrCarrierWeight: TSQLQuery;
    qrCarrierPartner: TSQLQuery;
    qrOrderItems: TSQLQuery;
    qrCarrierOrDt: TSQLQuery;
    qrTypeManifest: TSQLQuery;
    qrMark: TSQLQuery;
    qrModel: TSQLQuery;
    qrVehicle: TSQLQuery;
    qrManifestStatus: TSQLQuery;
    qrManifest: TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FFkStatusPedidos: Integer;
    FFkGroupMovement: Integer;
    FFkTypeDocument : Integer;
    FFkTypeMovement : Integer;
    FFkTypePayment  : Integer;
    FFkCadastros    : Integer;
    FIdxConv        : Double;
    FFkConsignee    : Integer;
    FFkShipper      : Integer;
    FFkAddressee    : Integer;
    FFkTypeVehicle  : Integer;
    FFkModel: Integer;
    FFkMark: Integer;
    FFkOccSurveyors: Integer;
    FFkOccPorters: Integer;
    FFkOccDriver: Integer;
    function  GetCarrierDocument(APk: Integer): TCarrierOrder;
    function  GetCarrierOrder(APk: Integer): TCarrierOrder;
    function  GetDocument(APk: Integer): TOrder;
    function  GetOrder(APk: Integer): TOrder;
    function  GetOrderToDocument(APk: Integer): TCarrierOrder;
    function  GetDiscounts(AType: TDocumentType; APk: Integer): TDiscounts;
    function  GetInstallments(AType: TDocumentType;
      APk: Integer): TInstallments;
    function  GetOrderMessages(AType: TDocumentType;
      APk: Integer): TOrderMessages;
    function  GetCarrierPartner(AType: TDocumentType; APk: Integer): TCarrierPartner;
    function  GetCarrierWeights(AType: TDocumentType; APk: Integer): TCarrierWeights;
    function  GetVehicles(APk: Integer): TDataRow;
    function  GetCarrierOrgmDstn(APk, AOD: Integer): TCity;
    function  GetMarkSuppliers(APk: Integer): TList;
    function  GetTypeManifest(APk: Integer): TDataRow;
    function  GetMarks(APk: Integer): TDataRow;
    function  GetModels(APk: Integer): TDataRow;
    function  GetOrderItems(AType: TDocumentType;
      APk: Integer): TOrderItems;
    function  GetVehiclesCarrier(APk: Integer): TDataRow;
    function  GetVehiclesImg(APk: Integer; AMode: TDBMode): TList;
    function  GetVehiclesObs(APk: Integer; AMode: TDBMode): TStrings;
    function  GetVehiclesProd(APk: Integer): TDataRow;
    procedure SetCarrierOrder(APk: Integer; const Value: TCarrierOrder);
    procedure SetDocument(APk: Integer; const Value: TOrder);
    procedure SetOrder(APk: Integer; const Value: TOrder);
    procedure SetOrderToDocument(APk: Integer; const Value: TCarrierOrder);
    procedure SetCarrierDocument(APk: Integer; const Value: TCarrierOrder);
    procedure SetDiscounts(AType: TDocumentType; APk: Integer;
      const Value: TDiscounts);
    procedure SetInstallments(AType: TDocumentType; APk: Integer;
      const Value: TInstallments);
    procedure SetOrderMessages(AType: TDocumentType; APk: Integer;
      const Value: TOrderMessages);
    procedure SetCarrierPartner(AType: TDocumentType; APk: Integer;
      const Value: TCarrierPartner);
    procedure SetCarrierWeights(AType: TDocumentType; APk: Integer;
      const Value: TCarrierWeights);
    procedure SetCarrierOrgmDstn(APk, AOD: Integer; const Value: TCity);
    procedure SetTypeManifest(APk: Integer; const Value: TDataRow);
    procedure SetMarks(APk: Integer; const Value: TDataRow);
    procedure SetMarkSuppliers(APk: Integer; const Value: TList);
    procedure SetModels(APk: Integer; const Value: TDataRow);
    procedure SetVehicles(APk: Integer; const Value: TDataRow);
    procedure SetVehiclesCarrier(APk: Integer; const Value: TDataRow);
    procedure SetVehiclesImg(APk: Integer; AMode: TDBMode; const Value: TList);
    procedure SetVehiclesObs(APk: Integer; AMode: TDBMode; const Value: TStrings);
    procedure SetVehiclesProd(APk: Integer; const Value: TDataRow);
    function GetManifestStatus(APk: Integer): TDataRow;
    procedure SetManifestStatus(APk: Integer; const Value: TDataRow);
    function GetManifest(APk: Integer): TDataRow;
    procedure SetManifest(APk: Integer; const Value: TDataRow);
    function GetManifestDocs(APk: Integer): TList;
    procedure SetManifestDocs(APk: Integer; const Value: TList);
    { Private declarations }
  public
    { Public declarations }
    function  LoadCarrierPrice(const FkProducts, FkTablePrice, FkCalcOrgmDstn,
                FkTipoFractionTable, FkAddressee, FkCustomer, TypeCstm: Integer;
                const VlrAcrDsct, QtdProd, VlrNF: Double): TCarrierPrice;
    function  LoadCity(const AFkCountry: Integer; const AFkState: string): TStrings;
    function  LoadCountry: TStrings;
    function  LoadCostCenter: TStrings;
    function  LoadEmployees(const AType: TTypeEmployee): TStrings;
    function  LoadCarriers: TStrings;
    function  LoadCustomerFromDoc(const ADoc: string; ATypeOwner: ShortInt = 0;
                ACustomer: Boolean = True): TOwner; overload;
    function  LoadCustomerFromDoc(const APk: Integer): TOwner; overload;
    function  LoadPartners: TStrings;
    function  LoadPriceTable(const AFkOrigin, AFkDestination: Integer;
                ALoadAll: Integer = 1; AFkPriceTable: Integer = 0): TStrings;
    procedure LoadOrderParams;
    function  LoadOriginDestination(const AFkOwner, AFkDestination,
                AFkPriceTable, ALoadAll: Integer): Integer;
    function  LoadProductGroups: TStrings;
    function  LoadProducts: TStrings;
    function  LoadSalers: TStrings;
    function  LoadState(const AFkCountry: Integer): TStrings;
    function  LoadRegion(AFkRegion: Integer): string;
    function  LoadTypeDocument: TStrings;
    function  LoadTypeManifest: TStrings;
    function  LoadUnits: TStrings;
    function  LoadVehicleMarks: TStrings;
    function  LoadVehicleModel(const AMark: Integer): TStrings;
    function  LoadVehicle(const AMark, AModel: Integer): TList;
    procedure SetMarkSupplier(const AFkMark, AFkOwner: Integer; const AState: TDBMode);
    property  FkMark                        : Integer         read FFkMark            write FFkMark;
    property  FkModel                       : Integer         read FFkModel           write FFkModel;
    property  FkShipper                     : Integer         read FFkShipper;
    property  FkAddressee                   : Integer         read FFkAddressee;
    property  FkConsignee                   : Integer         read FFkConsignee;
    property  FkOccDriver                   : Integer         read FFkOccDriver;
    property  FkOccPorters                  : Integer         read FFkOccPorters;
    property  FkOccSurveyors                : Integer         read FFkOccSurveyors;
    property  FkTypeDocument                : Integer         read FFkTypeDocument    write FFkTypeDocument;
    property  FkTypeVehicle                 : Integer         read FFkTypeVehicle     write FFkTypeVehicle;
    property  FkCadastros                   : Integer         read FFkCadastros       write FFkCadastros;
    property  IdxConv                       : Double          read FIdxConv           write FIdxConv;
    property  CarrierOrder    [APk: Integer]: TCarrierOrder   read GetCarrierOrder    write SetCarrierOrder;
    property  CarrierOrderOrDt[APk, AOD: Integer]: TCity      read GetCarrierOrgmDstn write SetCarrierOrgmDstn;
    property  CarrierDocument [APk: Integer]: TCarrierOrder   read GetCarrierDocument write SetCarrierDocument;
    property  Marks           [APk: Integer]: TDataRow        read GetMarks           write SetMarks;
    property  MarkSuppliers   [APk: Integer]: TList           read GetMarkSuppliers   write SetMarkSuppliers;
    property  Models          [APk: Integer]: TDataRow        read GetModels          write SetModels;
    property  Order           [APk: Integer]: TOrder          read GetOrder           write SetOrder;
    property  Document        [APk: Integer]: TOrder          read GetDocument        write SetDocument;
    property  OrderToDocument [APk: Integer]: TCarrierOrder   read GetOrderToDocument write SetOrderToDocument;
    property  Manifest        [APk: Integer]: TDataRow        read GetManifest        write SetManifest;
    property  ManifestStatus  [APk: Integer]: TDataRow        read GetManifestStatus  write SetManifestStatus;
    property  TypeManifest    [APk: Integer]: TDataRow        read GetTypeManifest    write SetTypeManifest;
    property  Vehicles        [APk: Integer]: TDataRow        read GetVehicles        write SetVehicles;
    property  VehiclesObs     [APk: Integer; AMode: TDBMode]: TStrings        read GetVehiclesObs     write SetVehiclesObs;
    property  ManifestDocs    [APk: Integer]: TList           read GetManifestDocs    write SetManifestDocs;
    property  VehiclesImg     [APk: Integer; AMode: TDBMode]: TList           read GetVehiclesImg     write SetVehiclesImg;
    property  VehiclesProd    [APk: Integer]: TDataRow        read GetVehiclesProd    write SetVehiclesProd;
    property  VehiclesCarrier [APk: Integer]: TDataRow        read GetVehiclesCarrier write SetVehiclesCarrier;
    property  CarrierOrderWght[AType: TDocumentType; APk: Integer]: TCarrierWeights read GetCarrierWeights  write SetCarrierWeights;
    property  CarrierOrderPrnt[AType: TDocumentType; APk: Integer]: TCarrierPartner read GetCarrierPartner  write SetCarrierPartner;
    property  Discounts       [AType: TDocumentType; APk: Integer]: TDiscounts      read GetDiscounts     write SetDiscounts;
    property  Installments    [AType: TDocumentType; APk: Integer]: TInstallments   read GetInstallments  write SetInstallments;
    property  OrderItems      [AType: TDocumentType; APk: Integer]: TOrderItems     read GetOrderItems;
    property  OrderMessages   [AType: TDocumentType; APk: Integer]: TOrderMessages  read GetOrderMessages write SetOrderMessages;
  end;

var
  dmSysTrans: TdmSysTrans;
const
  NAME_TDOC: array [TDocumentType] of string = ('Simulações', 'Conhecimentos', 'Gerar Conhec.');

  NAME_TVEI: array [TTypeVehicle]  of string = ('Veículos Próprios', 'Veículos Tercerizados', '');

implementation

uses FuncoesDB, Dado, CmmConst, SqlComm, ArqSqlTrans, ArqCnstTrans, TypInfo,
  Funcoes, TSysEstq, TSysMan, jpeg;

{$R *.DFM}

procedure TdmSysTrans.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
  LoadOrderParams;
end;

procedure TdmSysTrans.DataModuleDestroy(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].InheritsFrom(TDataSet)) and
       (TDataSet(Components[i]).Active)       then
      TDataSet(Components[i]).Close;
  end;
end;


function TdmSysTrans.GetCarrierDocument(APk: Integer): TCarrierOrder;
begin
  Result := TCarrierOrder.Create(Dados.DecimalPlaces);
  if (APk = 0) then exit;
  if (qrCarrierOrder.Active) then qrCarrierOrder.Close;
  qrCarrierOrder.SQL.Clear;
  qrCarrierOrder.SQL.Add(SqlCarrierDocument);
  Dados.StartTransaction(qrCarrierOrder);
  try
    qrCarrierOrder.ParamByName('FkEmpresas').AsInteger        := Dados.PkCompany;
    qrCarrierOrder.ParamByName('FkTipoDocumentos').AsInteger  := FFkTypeDocument;
    qrCarrierOrder.ParamByName('FkCadastros').AsInteger       := FFkCadastros;
    qrCarrierOrder.ParamByName('FkDocumentos').AsInteger      := APk;
    if (not qrCarrierOrder.Active) then qrCarrierOrder.Open;
    Result.FkShipper                := qrCarrierOrder.FieldByName('FK_REMETENTE').AsInteger;
    Result.FkAddressee              := qrCarrierOrder.FieldByName('FK_DESTINATARIO').AsInteger;
    Result.FkConsignee              := qrCarrierOrder.FieldByName('FK_CONSIGNATARIO').AsInteger;
    Result.TypeTable.PkTypeFraction := qrCarrierOrder.FieldByName('FK_TIPO_TABELA_FRACAO').AsInteger;
    Result.TypeTable.PkCalcOrgmDstn := qrCarrierOrder.FieldByName('FK_TABELA_ORIGEM_DESTINO').AsInteger;
    Result.FkProduct.PkProducts     := qrCarrierOrder.FieldByName('FK_PRODUTOS_FRETES').AsInteger;
    Result.FlagES                   := TInOut(qrCarrierOrder.FieldByName('FLAG_ES').AsInteger);
    Result.FlagRemb                 := Boolean(qrCarrierOrder.FieldByName('FLAG_REMB').AsInteger);
    with Result.FkProduct.ProductService do
      ProductCarrier.FlagTCarrier   := TTypeCarrier(qrCarrierOrder.FieldByName('FLAG_TP_FRE').AsInteger);
    Result.NumNF                    := qrCarrierOrder.FieldByName('NUM_NF').AsInteger;
    Result.VlrNF                    := qrCarrierOrder.FieldByName('VLR_NF').AsFloat;
    Result.VlrFrePeso               := qrCarrierOrder.FieldByName('VLR_FRE_PESO').AsFloat;
    Result.FreVlr                   := qrCarrierOrder.FieldByName('FRE_VLR').AsFloat;
    Result.VlrSecat                 := qrCarrierOrder.FieldByName('VLR_SECAT').AsFloat;
    Result.VlrGris                  := qrCarrierOrder.FieldByName('VLR_GRIS').AsFloat;
    Result.VlrPedg                  := qrCarrierOrder.FieldByName('VLR_PEDG').AsFloat;
    Result.VlrDifAcc                := qrCarrierOrder.FieldByName('VLR_DIF_ACC').AsFloat;
    Result.AlqtIcms                 := qrCarrierOrder.FieldByName('ALQT_ICMS').AsFloat;
    Result.QtdProd                  := qrCarrierOrder.FieldByName('QTD_PROD').AsFloat;
    Result.Order                    := Document[APk];
    Result.TypeTable.PkPriceTable   := Result.Order.FkPriceTable.PkPriceTable;
    Result.CarrierWeights           := CarrierOrderWght[dtDocument, APk];
    Result.CarrierPartner           := CarrierOrderPrnt[dtDocument, APk];
  finally
    if (qrCarrierOrder.Active) then qrCarrierOrder.Close;
    Dados.CommitTransaction(qrCarrierOrder);
  end;
  FFkShipper   := Result.FkShipper;
  FFkAddressee := Result.FkAddressee;
  FFkConsignee := Result.FkConsignee;
end;

function TdmSysTrans.GetCarrierOrder(APk: Integer): TCarrierOrder;
  procedure SetLocality(ACity: TCity);
  begin
    ACity.FkState.FkCountry.PKCountry := qrCarrierOrder.FieldByName('FK_PAISES').AsInteger;
    ACity.FkState.PkState             := qrCarrierOrder.FieldByName('FK_ESTADOS').AsString;
    ACity.PkCity                      := qrCarrierOrder.FieldByName('FK_MUNICIPIOS').AsInteger;
    ACity.DscMun                      := qrCarrierOrder.FieldByName('DSC_REG').AsString;
  end;
begin
  Result := TCarrierOrder.Create(Dados.DecimalPlaces);
  if (APk = 0) then exit;
  if (qrCarrierOrder.Active) then qrCarrierOrder.Close;
  qrCarrierOrder.SQL.Clear;
  qrCarrierOrder.SQL.Add(SqlCarrierOrder);
  Dados.StartTransaction(qrCarrierOrder);
  try
    qrCarrierOrder.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrCarrierOrder.ParamByName('FkPedidos').AsInteger  := APk;
    if (not qrCarrierOrder.Active) then qrCarrierOrder.Open;
    Result.FkShipper                := qrCarrierOrder.FieldByName('FK_REMETENTE').AsInteger;
    Result.FkAddressee              := qrCarrierOrder.FieldByName('FK_DESTINATARIO').AsInteger;
    Result.FkConsignee              := qrCarrierOrder.FieldByName('FK_CONSIGNATARIO').AsInteger;
    Result.TypeTable.PkTypeFraction := qrCarrierOrder.FieldByName('FK_TIPO_TABELA_FRACAO').AsInteger;
    Result.TypeTable.PkPriceTable   := qrCarrierOrder.FieldByName('FK_TABELA_PRECOS').AsInteger;
    Result.TypeTable.PkCalcOrgmDstn := qrCarrierOrder.FieldByName('FK_TABELA_ORIGEM_DESTINO').AsInteger;
    Result.FkProduct.PkProducts     := qrCarrierOrder.FieldByName('FK_PRODUTOS_FRETES').AsInteger;
    Result.FlagES                   := TInOut(qrCarrierOrder.FieldByName('FLAG_ES').AsInteger);
    Result.FlagRemb                 := Boolean(qrCarrierOrder.FieldByName('FLAG_REMB').AsInteger);
    with Result.FkProduct.ProductService do
      ProductCarrier.FlagTCarrier   := TTypeCarrier(qrCarrierOrder.FieldByName('FLAG_TP_FRE').AsInteger);
    Result.NumNF                    := qrCarrierOrder.FieldByName('NUM_NF').AsInteger;
    Result.VlrNF                    := qrCarrierOrder.FieldByName('VLR_NF').AsFloat;
    Result.VlrFrePeso               := qrCarrierOrder.FieldByName('VLR_FRE_PESO').AsFloat;
    Result.FreVlr                   := qrCarrierOrder.FieldByName('FRE_VLR').AsFloat;
    Result.VlrSecat                 := qrCarrierOrder.FieldByName('VLR_SECAT').AsFloat;
    Result.VlrGris                  := qrCarrierOrder.FieldByName('VLR_GRIS').AsFloat;
    Result.VlrPedg                  := qrCarrierOrder.FieldByName('VLR_PEDG').AsFloat;
    Result.VlrDifAcc                := qrCarrierOrder.FieldByName('VLR_DIF_ACC').AsFloat;
    Result.AlqtIcms                 := qrCarrierOrder.FieldByName('ALQT_ICMS').AsFloat;
    Result.Order                    := Order[APk];
    Result.CarrierWeights           := CarrierOrderWght[dtSimulator, APk];
    Result.CarrierPartner           := CarrierOrderPrnt[dtSimulator, APk];
    Result.CityOrigim               := CarrierOrderOrDt[APk, 0];
    Result.CityDestination          := CarrierOrderOrDt[APk, 1];
    while (not qrCarrierOrder.Eof) do
    begin
      if (qrCarrierOrder.FieldByName('PK_PEDIDOS_FRETES_LOCAL').AsInteger = 0) then
        SetLocality(Result.CityOrigim)
      else
        SetLocality(Result.CityDestination);
      qrCarrierOrder.Next;
    end;
  finally
    if (qrCarrierOrder.Active) then qrCarrierOrder.Close;
    Dados.CommitTransaction(qrCarrierOrder);
  end;
end;

function TdmSysTrans.GetCarrierOrgmDstn(APk, AOD: Integer): TCity;
begin
  Result := TCity.Create;
  if qrCarrierOrDt.Active then qrCarrierOrDt.Close;
  qrCarrierOrDt.SQL.Clear;
  qrCarrierOrDt.SQL.Add(SqlSelCarrierOrdOrDt);
  try
    qrCarrierOrDt.ParamByName('FkEmpresas').AsInteger           := Dados.PkCompany;
    qrCarrierOrDt.ParamByName('FkPedidos').AsInteger            := APk;
    qrCarrierOrDt.ParamByName('PkPedidosFretesLocal').AsInteger := AOD;
    if (not qrCarrierOrDt.Active) then qrCarrierOrDt.Open;
    Result.FkState.FkCountry.PKCountry       := qrCarrierOrDt.FieldByName('FK_PAISES').AsInteger;
    Result.FkState.PkState                   := qrCarrierOrDt.FieldByName('FK_ESTADOS').AsString;
    Result.PkCity                            := qrCarrierOrDt.FieldByName('FK_MUNICIPIOS').AsInteger;
    Result.DscMun                            := qrCarrierOrDt.FieldByName('DSC_REG').AsString;
  finally
    if qrCarrierOrDt.Active then qrCarrierOrDt.Close;
  end;
end;

function TdmSysTrans.GetCarrierPartner(AType: TDocumentType; APk: Integer): TCarrierPartner;
begin
  Result := TCarrierPartner.Create;
  if qrCarrierPartner.Active then qrCarrierPartner.Close;
  qrCarrierPartner.SQL.Clear;
  qrCarrierPartner.SQL.Add(SqlSelCarrierOrdPrtn);
  try
    qrCarrierPartner.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrCarrierPartner.ParamByName('FkPedidos').AsInteger  := APk;
    if (not qrCarrierPartner.Active) then qrCarrierPartner.Open;
    Result.FKPartner  := qrCarrierPartner.FieldByName('FK_PARCEIRO').AsInteger;
    Result.FreVlr     := qrCarrierPartner.FieldByName('FRE_VLR').AsFloat;
    Result.VlrFrePeso := qrCarrierPartner.FieldByName('VLR_FRE_PESO').AsFloat;
    Result.VlrSecat   := qrCarrierPartner.FieldByName('VLR_SECAT').AsFloat;
    Result.VlrGris    := qrCarrierPartner.FieldByName('VLR_GRIS').AsFloat;
    Result.VlrPedg    := qrCarrierPartner.FieldByName('VLR_PEDG').AsFloat;
    Result.VlrDifAcc  := qrCarrierPartner.FieldByName('VLR_DIF_ACC').AsFloat;
  finally
    if qrCarrierPartner.Active then qrCarrierPartner.Close;
  end;
end;

function TdmSysTrans.GetCarrierWeights(AType: TDocumentType; APk: Integer): TCarrierWeights;
begin
  Result := TCarrierWeights.Create(nil);
  if qrCarrierWeight.Active then qrCarrierWeight.Close;
  qrCarrierWeight.SQL.Clear;
  qrCarrierWeight.SQL.Add(SqlSelCarrierOrdWght);
  try
    qrCarrierWeight.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
    qrCarrierWeight.ParamByName('FkPedidosFretes').AsInteger := APk;
    if (not qrCarrierWeight.Active) then qrCarrierWeight.Open;
    while (not qrCarrierWeight.EOF) do
    begin
      with Result.Add do
      begin
        AltVol  := qrCarrierOrder.FieldByName('ALT_VOL').AsFloat;
        LargVol := qrCarrierOrder.FieldByName('LARG_VOL').AsFloat;
        ProfVol := qrCarrierOrder.FieldByName('PROF_VOL').AsFloat;
      end;
      qrCarrierWeight.Next;
    end;
  finally
    if qrCarrierWeight.Active then qrCarrierWeight.Close;
  end;
end;

function TdmSysTrans.GetDiscounts(AType: TDocumentType;
  APk: Integer): TDiscounts;
begin
  Result := TDiscounts.Create(Self);
  if (AType = dtDocument) then exit;
  if qrTypeDiscount.Active then qrTypeDiscount.Close;
  qrTypeDiscount.SQL.Clear;
  qrTypeDiscount.SQL.Add(SqlSelectOrderDsct);
  try
    qrTypeDiscount.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrTypeDiscount.ParamByName('FkPedidos').AsInteger  := APk;
    if (not qrTypeDiscount.Active) then qrTypeDiscount.Open;
    while (not qrTypeDiscount.Eof) do
    begin
      with Result.Add do
      begin
        DscDsct   := qrTypeDiscount.FieldByName('DSC_DSCT').AsString;
        IdxDsct   := qrTypeDiscount.FieldByName('IDX_DSCT').AsFloat;
        FlagTDsct := TTypeOperation(qrTypeDiscount.FieldByName('FLAG_TDSCT').AsInteger);
        FlagDstq  := Boolean(qrTypeDiscount.FieldByName('FLAG_DSTQ').AsInteger);
      end;
      qrTypeDiscount.Next;
    end;
  finally
    if qrTypeDiscount.Active then qrTypeDiscount.Close;
  end;
end;

function TdmSysTrans.GetDocument(APk: Integer): TOrder;
begin
  Result := TOrder.Create(Dados.DecimalPlaces);
  if qrOrders.Active then qrOrders.Close;
  qrOrders.SQL.Clear;
  qrOrders.SQL.Add(SqlDocument);
  try
    qrOrders.ParamByName('FkEmpresas').AsInteger          := Dados.PkCompany;
    qrOrders.ParamByName('FkTipoDocumentos').AsInteger    := FFkTypeDocument;
    qrOrders.ParamByName('FkCadastros').AsInteger         := FFkCadastros;
    qrOrders.ParamByName('PkDocumentos').AsInteger        := APk;
    if (not qrOrders.Active) then qrOrders.Open;
    Result.PkOrder                       := APk;
    Result.FkMovement.PkGroupMovement    := qrOrders.FieldByName('FK_GRUPOS_MOVIMENTOS').AsInteger;
//    Result.FkMovement.PkTypeMovement     := qrOrders.FieldByName('FK_TIPO_MOVIMENTOS').AsInteger;
    Result.FkOwner.PkCadastros           := qrOrders.FieldByName('FK_CADASTROS').AsInteger;
    Result.DtaPed                        := qrOrders.FieldByName('DATA_DOC').AsDateTime;
    Result.NumVol                        := qrOrders.FieldByName('NUM_VOL').AsInteger;
    Result.TipoVol                       := qrOrders.FieldByName('TIPO_VOL').AsString;
    Result.QtdVol                        := qrOrders.FieldByName('QTD_VOL').AsInteger;
    Result.VlrSeg                        := qrOrders.FieldByName('VLR_SEG').AsFloat;
    Result.VlrEntr                       := qrOrders.FieldByName('VLR_ENTR').AsFloat;
    Result.DspAces                       := qrOrders.FieldByName('VLR_DSP_ACES').AsFloat;
    Result.VlrFret                       := qrOrders.FieldByName('VAL_TOT').AsFloat;
    Result.DsctFret                      := qrOrders.FieldByName('VLR_ACR_DSCT').AsFloat;
    Result.PesLiq                        := qrOrders.FieldByName('PES_LIQ').AsFloat;
    Result.PesBru                        := qrOrders.FieldByName('PES_BRU').AsFloat;
    Result.NumExtr                       := qrOrders.FieldByName('NUM_EXTR').AsString;
    Result.NumProForma                   := qrOrders.FieldByName('NUM_PRO_FORMA').AsInteger;
//    Result.FkDeliveryPeriod              := qrOrders.FieldByName('FK_TIPO_PRAZO_ENTREGA').AsInteger;
    Result.FkTypePayment.PkTypePgto      := qrOrders.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
    Result.FkVendor.PkCadastros          := qrOrders.FieldByName('FK_VW_VENDEDORES').AsInteger;
    Result.FkRepresentant.PkCadastros    := qrOrders.FieldByName('FK_VW_REPRESENTANTES').AsInteger;
    Result.FkCarrier.PkCadastros         := qrOrders.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
    Result.FkAgent.PkCadastros           := qrOrders.FieldByName('FK_VW_AGENTE').AsInteger;
    Result.FkPortoDst                    := qrOrders.FieldByName('FK_PORTOS_DST').AsInteger;
    Result.FkPortoEmb                    := qrOrders.FieldByName('FK_PORTOS_EMB').AsInteger;
    Result.FkPurchaseOrder               := qrOrders.FieldByName('FK_ORDEM_COMPRA').AsInteger;
    Result.FkPriceTable.PkPriceTable     := qrOrders.FieldByName('FK_TABELA_PRECOS').AsInteger;
    Result.OrderItems                    := OrderItems[dtDocument, APk];
    Result.OrderMessages                 := OrderMessages[dtDocument, APk];
  finally
    if qrOrders.Active then qrOrders.Close;
  end;
end;

function TdmSysTrans.GetInstallments(AType: TDocumentType;
  APk: Integer): TInstallments;
begin
  Result := TInstallments.Create(nil);
  if (AType = dtDocument) then exit;
  if qrInstallments.Active then qrInstallments.Close;
  qrInstallments.SQL.Clear;
  qrInstallments.SQL.Add(SqlSelectPayOrder);
  try
    qrInstallments.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrInstallments.ParamByName('FkPedidos').AsInteger  := APk;
    while (not qrInstallments.Eof) do
    begin
      if (not qrInstallments.Active) then qrInstallments.Open;
      with Result.Add do
      begin
        DtaVenc := qrInstallments.FieldByName('PK_PEDIDOS_PARCELAS').AsDateTime;
        VlrParc := qrInstallments.FieldByName('VLR_PARC').AsFloat;
      end;
      qrInstallments.Next;
    end;
  finally
    if qrInstallments.Active then qrInstallments.Close;
  end;
end;

function TdmSysTrans.GetMarks(APk: Integer): TDataRow;
begin
  if (qrMark.Active) then qrMark.Close;
  qrMark.SQL.Clear;
  qrMark.SQL.Add(SqlSelectMark);
  Dados.StartTransaction(qrMark);
  try
    qrMark.ParamByName('PkVeiculosMarcas').AsInteger := APk;
    if (not qrMark.Active) then qrMark.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrMark, True);
  finally
    if (qrMark.Active) then qrMark.Close;
    Dados.CommitTransaction(qrMark);
  end;
end;

function TdmSysTrans.GetMarkSuppliers(APk: Integer): TList;
begin
  Result := TList.Create;
  if (qrMark.Active) then qrMark.Close;
  qrMark.SQL.Clear;
  qrMark.SQL.Add(SqlSelectMarkSupplier);
  Dados.StartTransaction(qrMark);
  try
    qrMark.ParamByName('FkVeiculosMarcas').AsInteger := APk;
    if (not qrMark.Active) then qrMark.Open;
    while (not qrMark.Eof) do
    begin
      Result.Add(TDataRow.CreateFromDataSet(nil, qrMark, True));
      qrMark.Next;
    end;
  finally
    if (qrMark.Active) then qrMark.Close;
    Dados.CommitTransaction(qrMark);
  end;
  Result := TList.Create;
end;

function TdmSysTrans.GetOrder(APk: Integer): TOrder;
begin
  Result := TOrder.Create(Dados.DecimalPlaces);
  if qrOrders.Active then qrOrders.Close;
  qrOrders.SQL.Clear;
  qrOrders.SQL.Add(SqlOrder);
  try
    qrOrders.ParamByName('FkEmpresas').AsInteger          := Dados.PkCompany;
    qrOrders.ParamByName('PkPedidos').AsInteger           := APk;
    if (not qrOrders.Active) then qrOrders.Open;
    Result.PkOrder                       := APk;
    Result.FkMovement.PkGroupMovement    := qrOrders.FieldByName('FK_GRUPOS_MOVIMENTOS').AsInteger;
    Result.FkMovement.PkTypeMovement     := qrOrders.FieldByName('FK_TIPO_MOVIMENTOS').AsInteger;
    Result.FkOwner.PkCadastros           := qrOrders.FieldByName('FK_CADASTROS').AsInteger;
    Result.FkOrderStatus.PkOrderStatus   := qrOrders.FieldByName('FK_TIPO_STATUS_PEDIDOS').AsInteger;
    Result.NumVol                        := qrOrders.FieldByName('NUM_VOL').AsInteger;
    Result.TipoVol                       := qrOrders.FieldByName('TIPO_VOL').AsString;
    Result.FlagEntrParc                  := Boolean(qrOrders.FieldByName('FLAG_ENTR_PARC').AsInteger);
    Result.FlagCPrvE                     := Boolean(qrOrders.FieldByName('FLAG_CPRVE').AsInteger);
    Result.FlagImp                       := Boolean(qrOrders.FieldByName('FLAG_IMP').AsInteger);
    Result.FlagProd                      := Boolean(qrOrders.FieldByName('FLAG_PROD').AsInteger);
    Result.FlagDtaBas                    := TBaseDate(qrOrders.FieldByName('FLAG_DTABAS').AsInteger);
    Result.QtdVol                        := qrOrders.FieldByName('QTD_VOL').AsInteger;
    Result.VlrSeg                        := qrOrders.FieldByName('VLR_SEG').AsFloat;
    Result.VlrEntr                       := qrOrders.FieldByName('VLR_ENTR').AsFloat;
    Result.DspAces                       := qrOrders.FieldByName('DSP_ACES').AsFloat;
    Result.VlrFret                       := qrOrders.FieldByName('TOT_PED').AsFloat;
    Result.DsctFret                      := qrOrders.FieldByName('VLR_ACR_DSCT').AsFloat;
//    Result.SubTot                        := qrOrders.FieldByName('SUB_TOT').AsFloat;
    Result.PesLiq                        := qrOrders.FieldByName('PES_LIQ').AsFloat;
    Result.PesBru                        := qrOrders.FieldByName('PES_BRU').AsFloat;
    Result.DtaRecb                       := qrOrders.FieldByName('DTA_RECB').AsDateTime;
    Result.DtaLib                        := qrOrders.FieldByName('DTA_LIB').AsDateTime;
    Result.DtaEntr                       := qrOrders.FieldByName('DTA_ENTR').AsDateTime;
    Result.DtaCanc                       := qrOrders.FieldByName('DTA_CANC').AsDateTime;
    Result.DtaBas                        := qrOrders.FieldByName('DTA_BAS').AsDateTime;
    Result.DtaFat                        := qrOrders.FieldByName('DTA_FAT').AsDateTime;
    Result.MesPrevEntr                   := qrOrders.FieldByName('MES_PREV_ENTR').AsInteger;
    Result.AnoPrevEntr                   := qrOrders.FieldByName('ANO_PREV_ENTR').AsInteger;
    Result.NomCad                        := qrOrders.FieldByName('NOM_CAD').AsString;
    Result.NumExtr                       := qrOrders.FieldByName('NUM_EXTR').AsString;
    Result.NumProForma                   := qrOrders.FieldByName('NUM_PRO_FORMA').AsInteger;
    Result.FkDeliveryPeriod              := qrOrders.FieldByName('FK_TIPO_PRAZO_ENTREGA').AsInteger;
    Result.FkTypePayment.PkTypePgto      := qrOrders.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
    Result.FkTypeDiscount.PkTypeDiscount := qrOrders.FieldByName('FK_TIPO_DESCONTOS').AsInteger;
    Result.FkVendor.PkCadastros          := qrOrders.FieldByName('FK_VW_VENDEDORES').AsInteger;
    Result.FkRepresentant.PkCadastros    := qrOrders.FieldByName('FK_VW_REPRESENTANTES').AsInteger;
    Result.FkCarrier.PkCadastros         := qrOrders.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
    Result.FkAgent.PkCadastros           := qrOrders.FieldByName('FK_VW_AGENTE').AsInteger;
    Result.FkPortoDst                    := qrOrders.FieldByName('FK_PORTOS_DST').AsInteger;
    Result.FkPortoEmb                    := qrOrders.FieldByName('FK_PORTOS_EMB').AsInteger;
    Result.FkPurchaseOrder               := qrOrders.FieldByName('FK_ORDEM_COMPRA').AsInteger;
    Result.FkPriceTable.PkPriceTable     := qrOrders.FieldByName('FK_TABELA_PRECOS').AsInteger;
    Result.Discounts                     := Discounts[dtSimulator, APk];
    Result.OrderInstallments             := Installments[dtSimulator, APk];
    Result.OrderItems                    := OrderItems[dtSimulator, APk];
    Result.OrderMessages                 := OrderMessages[dtSimulator, APk];
  finally
    if qrOrders.Active then qrOrders.Close;
  end;
end;

function TdmSysTrans.GetOrderItems(AType: TDocumentType;
  APk: Integer): TOrderItems;
var
  aAlqt: TTaxDescription;
begin
  Result := TOrderItems.Create(nil);
  if (AType = dtDocument) then exit;
  if qrOrderItems.Active then qrOrderItems.Close;
  qrOrderItems.SQL.Clear;
  if (AType = dtSimulator) then
    qrOrderItems.SQL.Add(SqlSelectOrderItm)
  else
    qrOrderItems.SQL.Add(SqlSelectDocumentItem);
  try
    qrOrderItems.ParamByName('FkEmpresas').AsInteger    := Dados.PkCompany;
    if (AType = dtSimulator) then
      qrOrderItems.ParamByName('FkPedidos').AsInteger     := APk
    else
    begin
      qrOrderItems.ParamByName('FkTipoDocumentos').AsInteger := FFkTypeDocument;
      qrOrderItems.ParamByName('FkCadastros').AsInteger      := FFkCadastros;
      qrOrderItems.ParamByName('FkDocumentos').AsInteger     := APk;
    end;
    if (not qrOrderItems.Active) then qrOrderItems.Open;
    while (not qrOrderItems.Eof) do
    begin
      with Result.Add do
      begin
        aAlqt.TaxCode        := 0;
        aAlqt.TaxPercent     := qrOrderItems.FieldByName('ALQ_ICMS').AsFloat;
        AlqIcms              := aAlqt;
        FkProduct.PkProducts := qrOrderItems.FieldByName('FK_PRODUTOS').AsInteger;;
        QtdItem              := qrOrderItems.FieldByName('QTD_ITEM').AsFloat;
      end;
      qrOrderItems.Next;
    end;
  finally
    if qrOrderItems.Active then qrOrderItems.Close;
  end;
end;

function TdmSysTrans.GetOrderMessages(AType: TDocumentType;
  APk: Integer): TOrderMessages;
var
  M: TMemoryStream;
begin
  Result := TOrderMessages.Create(nil);
  if qrOrderMessage.Active then qrOrderMessage.Close;
  qrOrderMessage.SQL.Clear;
  case AType of
    dtSimulator: qrOrderMessage.SQL.Add(SqlSelectOrderMsg);
    dtDocument : qrOrderMessage.SQL.Add(SqlSelectDocMsg);
  end;
  try
    qrOrderMessage.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
    if (AType = dtSimulator) then
      qrOrderMessage.ParamByName('FkPedidos').AsInteger    := APk
    else
    begin
      qrOrderMessage.ParamByName('FkTipoDocumentos').AsInteger := FFkTypeDocument;
      qrOrderMessage.ParamByName('FkCadastros').AsInteger      := FFkCadastros;
      qrOrderMessage.ParamByName('FkDocumentos').AsInteger     := APk;
    end;
    if (not qrOrderMessage.Active) then qrOrderMessage.Open;
    while (not qrOrderMessage.Eof) do
    begin
      with Result.Add do
      begin
        if (AType = dtSimulator) then
        begin
          FkDepartament := qrOrderMessage.FieldByName('FK_DEPARTAMENTOS').AsInteger;
          DtHrMsg       := qrOrderMessage.FieldByName('DTHR_MSG').AsDateTime;
          DtHrRcbm      := qrOrderMessage.FieldByName('DTHR_RCBM').AsDateTime;
          M := TMemoryStream.Create;
          try
            M.Position := 0;
            TBlobField(qrOrderMessage.FieldByName('TEXT_MSG')).SaveToStream(M);
            M.Position := 0;
            TextMsg.LoadFromStream(M);
          finally
            FreeAndNil(M);
          end;
        end
        else
        begin
          M := TMemoryStream.Create;
          try
            M.Position := 0;
            TBlobField(qrOrderMessage.FieldByName('OBS_DOC')).SaveToStream(M);
            M.Position := 0;
            TextMsg.LoadFromStream(M);
          finally
            FreeAndNil(M);
          end;
        end;
      end;
      qrOrderMessage.Next;
    end;
  finally
    if qrOrderMessage.Active then qrOrderMessage.Close;
  end;
end;

function TdmSysTrans.GetOrderToDocument(APk: Integer): TCarrierOrder;
begin
  Result := TCarrierOrder.Create(Dados.DecimalPlaces);
end;

function TdmSysTrans.GetTypeManifest(APk: Integer): TDataRow;
begin
  if (qrTypeManifest.Active) then qrTypeManifest.Close;
  qrTypeManifest.SQL.Clear;
  qrTypeManifest.SQL.Add(SqlTypeManifest);
  try
    qrTypeManifest.ParamByName('PkTipoManifestos').AsInteger := APk;
    if (not qrTypeManifest.Active) then qrTypeManifest.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTypeManifest, True);
  finally
    if (qrTypeManifest.Active) then qrTypeManifest.Close;
  end;
end;

function TdmSysTrans.LoadCarrierPrice(const FkProducts, FkTablePrice,
  FkCalcOrgmDstn, FkTipoFractionTable, FkAddressee, FkCustomer, TypeCstm: Integer;
  const VlrAcrDsct, QtdProd, VlrNF: Double): TCarrierPrice;
begin
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlGetCarrierPrices);
  Dados.StartTransaction(qrSqlAux);
  try
//    ShowMessage('Empresa: ' + IntToStr(Dados.PkCompany) + NL +
//                'Produto: ' + IntToStr(FkProducts) + NL +
//                'FkTablePrice: ' + IntToStr(FkTablePrice) + NL +
//                'FkCalcOrgmDstn: ' + IntToStr(FkCalcOrgmDstn) + NL +
//                'FkTipoFractionTable: ' + IntToStr(FkTipoFractionTable) + NL +
//                'FkAddressee: ' + IntToStr(FkAddressee) + NL +
//                'FkCustomer: ' + IntToStr(FkCustomer) + NL +
//                'TypeCstm: ' + IntToStr(TypeCstm) + NL +
//                'VlrAcrDsct: ' + FloatToStrF(VlrAcrDsct, ffNumber, 7, 2) + NL +
//                'QtdProd: ' + FloatToStrF(QtdProd, ffNumber, 7, 2) + NL +
//                'VlrNF: ' + FloatToStrF(VlrNF, ffNumber, 7, 2));
    qrSqlAux.ParamByName('FkCompany').AsInteger           := Dados.PkCompany;
    qrSqlAux.ParamByName('FkProducts').AsInteger          := FkProducts;
    qrSqlAux.ParamByName('FkTablePrice').AsInteger        := FkTablePrice;
    qrSqlAux.ParamByName('FkTableOrgmDstn').AsInteger     := FkCalcOrgmDstn;
    qrSqlAux.ParamByName('FkTipoFractionTable').AsInteger := FkTipoFractionTable;
    qrSqlAux.ParamByName('FkAddressee').AsInteger         := FkAddressee;
    qrSqlAux.ParamByName('FkCustomer').AsInteger          := FkCustomer;
    qrSqlAux.ParamByName('TypeCstm').AsInteger            := TypeCstm;
    qrSqlAux.ParamByName('VlrAcrDsct').AsFloat            := VlrAcrDsct;
    qrSqlAux.ParamByName('QtdProd').AsFloat               := QtdProd;
    qrSqlAux.ParamByName('VlrNF').AsFloat                 := VlrNF;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Status     := qrSqlAux.FieldByName('R_STATUS').AsInteger;
    Result.PercDsct   := qrSqlAux.FieldByName('R_PERC_DSCT').AsFloat;
    Result.FlagDefTab := Boolean(qrSqlAux.FieldByName('R_FLAG_DEFTAB').AsInteger);
    Result.VlrFrePeso := qrSqlAux.FieldByName('R_VLR_FRE_PESO').AsFloat;
    Result.FreVlr     := qrSqlAux.FieldByName('R_FRE_VLR').AsFloat;
    Result.VlrSecat   := qrSqlAux.FieldByName('R_VLR_SECAT').AsFloat;
    Result.VlrGris    := qrSqlAux.FieldByName('R_VLR_GRIS').AsFloat;
    Result.VlrPedg    := qrSqlAux.FieldByName('R_VLR_PEDG').AsFloat;
    Result.VlrDifAcc  := qrSqlAux.FieldByName('R_VLR_DIF_ACC').AsFloat;
    Result.RedBasc    := qrSqlAux.FieldByName('R_RED_BASC').AsFloat;
    Result.AlqtICMS   := qrSqlAux.FieldByName('R_ALQT_ICMS').AsFloat;
    Result.BasICMS    := qrSqlAux.FieldByName('R_BAS_CALC').AsFloat;
    Result.VlrICMS    := qrSqlAux.FieldByName('R_VLR_ICMS').AsFloat;
    Result.SubTot     := qrSqlAux.FieldByName('R_SUB_TOT').AsFloat;
    Result.VlrAcrDsct := qrSqlAux.FieldByName('R_VLR_ACR_DSCT').AsFloat;
    Result.DsctItem   := qrSqlAux.FieldByName('R_DSCT_ITEM').AsFloat;
    Result.TotDoc     := qrSqlAux.FieldByName('R_TOT_DOC').AsFloat;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysTrans.LoadCity(const AFkCountry: Integer;
  const AFkState: string): TStrings;
var
  aData: TCity;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlCities);
  try
    qrSqlAux.ParamByName('FkPaises').AsInteger := AFkCountry;
    qrSqlAux.ParamByName('FkEstados').AsString := AFkState;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      aData := TCity.Create;
      aData.FkState.FkCountry.PKCountry  := qrSqlAux.FieldByName('PK_PAISES').AsInteger;
      aData.FkState.FkCountry.DscPais    := qrSqlAux.FieldByName('DSC_PAIS').AsString;
      aData.FkState.PkState              := qrSqlAux.FieldByName('PK_ESTADOS').AsString;
      aData.FkState.DscUF                := qrSqlAux.FieldByName('DSC_UF').AsString;
      aData.FkState.FkRegions            := qrSqlAux.FieldByName('FK_CARGAS_REGIOES_EST').AsInteger;
      aData.PkCity                       := qrSqlAux.FieldByName('PK_MUNICIPIOS').AsInteger;
      aData.DscMun                       := qrSqlAux.FieldByName('DSC_MUN').AsString;
      aData.FkRegions                    := qrSqlAux.FieldByName('FK_CARGAS_REGIOES_MUN').AsInteger;
      Result.AddObject(aData.DscMun, aData);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

function  TdmSysTrans.LoadCountry: TStrings;
var
  aData: TCountry;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlCountries);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      aData := TCountry.Create;
      aData.PKCountry  := qrSqlAux.FieldByName('PK_PAISES').AsInteger;
      aData.DscPais    := qrSqlAux.FieldByName('DSC_PAIS').AsString;
      Result.AddObject(aData.DscPais, aData);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

function TdmSysTrans.LoadCustomerFromDoc(const ADoc: string; ATypeOwner: ShortInt = 0;
  ACustomer: Boolean = True): TOwner;
begin
  Result := TOwner.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  if (ACustomer) then
    qrSqlAux.SQL.Add(SqlCustomerFromDoc)
  else
    qrSqlAux.SQL.Add(SqlSupplierFromDoc);
  try
    qrSqlAux.ParamByName('FlagTCad').AsInteger := ATypeOwner;
    qrSqlAux.ParamByName('DocPri').AsString    := ADoc;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    with Result.Address do
    begin
      EndAdd := qrSqlAux.FieldByName('END_CAD').AsString;
      CmpEnd := qrSqlAux.FieldByName('CMP_END').AsString;
      NumAdd := qrSqlAux.FieldByName('NUM_END').AsInteger;
      CepAdd := qrSqlAux.FieldByName('CEP_CAD').AsInteger;
      CxpAdd := qrSqlAux.FieldByName('CXP_CAD').AsString;
      FkCity.FkState.FkCountry.PKCountry := qrSqlAux.FieldByName('FK_PAISES').AsInteger;
      FkCity.FkState.FkCountry.DscPais   := qrSqlAux.FieldByName('DSC_PAIS').AsString;
      FkCity.FkState.PkState   := qrSqlAux.FieldByName('FK_ESTADOS').AsString;
      FkCity.FkState.DscUF     := qrSqlAux.FieldByName('DSC_UF').AsString;
      FkCity.FkState.FkRegions := qrSqlAux.FieldByName('FK_REGION_UF').AsInteger;
      FkCity.PkCity    := qrSqlAux.FieldByName('FK_MUNICIPIOS').AsInteger;
      FkCity.DscMun    := qrSqlAux.FieldByName('DSC_MUN').AsString;
      FkCity.FkRegions := qrSqlAux.FieldByName('FK_REGION_MUN').AsInteger;
    end;
    Result.AreaAtu      := qrSqlAux.FieldByName('AREA_ATU').AsString;
    Result.DocPri       := qrSqlAux.FieldByName('DOC_PRI').AsString;
    Result.DocSec       := qrSqlAux.FieldByName('DOC_SEQ').AsString;
    Result.FkContacts   := qrSqlAux.FieldByName('FK_CONTATOS').AsInteger;
    Result.FlagEtq      := Boolean(qrSqlAux.FieldByName('FLAG_ETQ').AsInteger);
    Result.FlagTCad     := TTypeOwner(qrSqlAux.FieldByName('FLAG_TCAD').AsInteger);
//    Result.FkAlias      := qrSqlAux.FieldByName('FK_TIPO_ALIAS').AsInteger;
//    Result.NomFan       := qrSqlAux.FieldByName('DSC_ALIAS').AsString;
    Result.PkCadastros  := qrSqlAux.FieldByName('PK_CADASTROS').AsInteger;
    Result.RazSoc       := qrSqlAux.FieldByName('RAZ_SOC').AsString;
    Result.Title        := qrSqlAux.FieldByName('TRT_CNT').AsString;
    if (ACustomer) then
    begin
      with Result.Customer do
      begin
        if (qrSqlAux.FieldByName('FK_CADASTROS').IsNull) or
           (qrSqlAux.FieldByName('FK_CADASTROS').AsInteger = 0) then
          Modified       := True
        else
          Modified       := False;
        FkBank.PkBank    := qrSqlAux.FieldByName('FK_BANCOS').AsInteger;
        FkDeliveryPeriod := qrSqlAux.FieldByName('FK_TIPO_PRAZO_ENTREGA').AsInteger;
        FlagCnsm         := Boolean(qrSqlAux.FieldByName('FLAG_CNSM').AsInteger);
        FlagDtaBas       := TBaseDate(qrSqlAux.FieldByName('FLAG_DTABAS').AsInteger);
        FlagPAbr         := Boolean(qrSqlAux.FieldByName('FLAG_PABR').AsInteger);
        FlagPend         := Boolean(qrSqlAux.FieldByName('FLAG_PENP').AsInteger);
        FlagFobDirigido  := Boolean(qrSqlAux.FieldByName('FLAG_FOB_DIRIGIDO').AsInteger);
        FlagSameRegion   := Boolean(qrSqlAux.FieldByName('FLAG_SAME_REGION').AsInteger);
        FlagDifAcc       := qrSqlAux.FieldByName('FLAG_DIFACC').AsInteger;
        LimCred          := qrSqlAux.FieldByName('LIM_CRD').AsFloat;
        DsctAtc          := qrSqlAux.FieldByName('DSCT_ATC').AsFloat;
        DsctAut          := qrSqlAux.FieldByName('DSCT_AUT').AsFloat;
        TaxAccess        := qrSqlAux.FieldByName('TAX_ACCESS').AsFloat;
        MinAccess        := qrSqlAux.FieldByName('MIN_ACCESS').AsFloat;
        IdxConv          := qrSqlAux.FieldByName('IDX_CONV').AsFloat;
        OpeAut           := qrSqlAux.FieldByName('OPE_AUT').AsString;
        OpeLib           := qrSqlAux.FieldByName('OPE_LIB').AsString;
        CodCtb           := qrSqlAux.FieldByName('COD_CTB').AsInteger;
        FkCarrier        := qrSqlAux.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
        FkRepresentant   := qrSqlAux.FieldByName('FK_VW_REPRESENTANTES').AsInteger;
        FkVendor         := qrSqlAux.FieldByName('FK_VW_VENDEDORES').AsInteger;
        FkPaymentWay.PkPaymentWay     := qrSqlAux.FieldByName('FK_FINALIZADORAS').AsInteger;
        FkTypePayment.PkTypePgto      := qrSqlAux.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
        FkPriceTable.PkPriceTable     := qrSqlAux.FieldByName('FK_TABELA_PRECOS').AsInteger;
        FkTypeDiscount.PkTypeDiscount := qrSqlAux.FieldByName('FK_TIPO_DESCONTOS').AsInteger;
        FkTypeEstablishment           := qrSqlAux.FieldByName('FK_TIPO_ESTABELECIMENTOS').AsInteger;
        FkTypeFraction                := qrSqlAux.FieldByName('FK_TIPO_TABELA_FRACAO').AsInteger;
      end;
    end;
    if (not ACustomer) then
    begin
      with Result.Supplier do
      begin
        FkPortDst                 := qrSqlAux.FieldByName('FK_PORTOS__DST').AsInteger;
        FkPortEmb                 := qrSqlAux.FieldByName('FK_PORTOS__EMB').AsInteger;
        FkTypeDiscount            := qrSqlAux.FieldByName('FK_DESCONTOS').AsInteger;
        FkTypePayment.PkTypePgto  := qrSqlAux.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
        FkAgent                   := qrSqlAux.FieldByName('FK_VW_CADASTROS').AsInteger;
        FkCarrier                 := qrSqlAux.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
        FkPriceTable              := qrSqlAux.FieldByName('FK_TABELA_PRECOS').AsInteger;
        FkTypeFraction            := qrSqlAux.FieldByName('FK_TIPO_TABELA_FRACAO').AsInteger;
        FlagProdDef               := (qrSqlAux.FieldByName('FLAG_PROD_DEF').AsInteger = 1);
        FlagTrn                   := (qrSqlAux.FieldByName('FLAG_TRN').AsInteger = 1);
        FkTypeFraction            := qrSqlAux.FieldByName('FK_TIPO_TABELA_FRACAO').AsInteger;
        NomVnd                    := qrSqlAux.FieldByName('NOM_VND').AsString;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

function TdmSysTrans.LoadCustomerFromDoc(const APk: Integer): TOwner;
begin
  Result := TOwner.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlCustomerFromPk);
  try
    qrSqlAux.ParamByName('PkCadastros').AsInteger := APk;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    with Result.Address do
    begin
      EndAdd := qrSqlAux.FieldByName('END_CAD').AsString;
      CmpEnd := qrSqlAux.FieldByName('CMP_END').AsString;
      NumAdd := qrSqlAux.FieldByName('NUM_END').AsInteger;
      CepAdd := qrSqlAux.FieldByName('CEP_CAD').AsInteger;
      CxpAdd := qrSqlAux.FieldByName('CXP_CAD').AsString;
      FkCity.FkState.FkCountry.PKCountry := qrSqlAux.FieldByName('FK_PAISES').AsInteger;
      FkCity.FkState.FkCountry.DscPais   := qrSqlAux.FieldByName('DSC_PAIS').AsString;
      FkCity.FkState.PkState   := qrSqlAux.FieldByName('FK_ESTADOS').AsString;
      FkCity.FkState.DscUF     := qrSqlAux.FieldByName('DSC_UF').AsString;
      FkCity.FkState.FkRegions := qrSqlAux.FieldByName('FK_REGION_UF').AsInteger;
      FkCity.PkCity    := qrSqlAux.FieldByName('FK_MUNICIPIOS').AsInteger;
      FkCity.DscMun    := qrSqlAux.FieldByName('DSC_MUN').AsString;
      FkCity.FkRegions := qrSqlAux.FieldByName('FK_REGION_MUN').AsInteger;
    end;
    Result.AreaAtu      := qrSqlAux.FieldByName('AREA_ATU').AsString;
    Result.DocPri       := qrSqlAux.FieldByName('DOC_PRI').AsString;
    Result.DocSec       := qrSqlAux.FieldByName('DOC_SEQ').AsString;
    Result.FkContacts   := qrSqlAux.FieldByName('FK_CONTATOS').AsInteger;
    Result.FlagEtq      := Boolean(qrSqlAux.FieldByName('FLAG_ETQ').AsInteger);
    Result.FlagTCad     := TTypeOwner(qrSqlAux.FieldByName('FLAG_TCAD').AsInteger);
//    Result.FkAlias      := qrSqlAux.FieldByName('FK_TIPO_ALIAS').AsInteger;
//    Result.NomFan       := qrSqlAux.FieldByName('DSC_ALIAS').AsString;
    Result.PkCadastros  := qrSqlAux.FieldByName('PK_CADASTROS').AsInteger;
    Result.RazSoc       := qrSqlAux.FieldByName('RAZ_SOC').AsString;
    Result.Title        := qrSqlAux.FieldByName('TRT_CNT').AsString;
    with Result.Customer do
    begin
      if (qrSqlAux.FieldByName('FK_CADASTROS').IsNull) or
         (qrSqlAux.FieldByName('FK_CADASTROS').AsInteger = 0) then
        Modified       := True
      else
        Modified       := False;
      FkBank.PkBank    := qrSqlAux.FieldByName('FK_BANCOS').AsInteger;
      FkDeliveryPeriod := qrSqlAux.FieldByName('FK_TIPO_PRAZO_ENTREGA').AsInteger;
      FlagCnsm         := Boolean(qrSqlAux.FieldByName('FLAG_CNSM').AsInteger);
      FlagDtaBas       := TBaseDate(qrSqlAux.FieldByName('FLAG_DTABAS').AsInteger);
      FlagPAbr         := Boolean(qrSqlAux.FieldByName('FLAG_PABR').AsInteger);
      FlagPend         := Boolean(qrSqlAux.FieldByName('FLAG_PENP').AsInteger);
      FlagFobDirigido  := Boolean(qrSqlAux.FieldByName('FLAG_FOB_DIRIGIDO').AsInteger);
      FlagSameRegion   := Boolean(qrSqlAux.FieldByName('FLAG_SAME_REGION').AsInteger);
      FlagDifAcc       := qrSqlAux.FieldByName('FLAG_DIFACC').AsInteger;
      LimCred          := qrSqlAux.FieldByName('LIM_CRD').AsFloat;
      DsctAtc          := qrSqlAux.FieldByName('DSCT_ATC').AsFloat;
      DsctAut          := qrSqlAux.FieldByName('DSCT_AUT').AsFloat;
      TaxAccess        := qrSqlAux.FieldByName('TAX_ACCESS').AsFloat;
      MinAccess        := qrSqlAux.FieldByName('MIN_ACCESS').AsFloat;
      IdxConv          := qrSqlAux.FieldByName('IDX_CONV').AsFloat;
      OpeAut           := qrSqlAux.FieldByName('OPE_AUT').AsString;
      OpeLib           := qrSqlAux.FieldByName('OPE_LIB').AsString;
      CodCtb           := qrSqlAux.FieldByName('COD_CTB').AsInteger;
      FkCarrier        := qrSqlAux.FieldByName('FK_VW_TRANSPORTADORAS').AsInteger;
      FkRepresentant   := qrSqlAux.FieldByName('FK_VW_REPRESENTANTES').AsInteger;
      FkVendor         := qrSqlAux.FieldByName('FK_VW_VENDEDORES').AsInteger;
      FkPaymentWay.PkPaymentWay     := qrSqlAux.FieldByName('FK_FINALIZADORAS').AsInteger;
      FkTypePayment.PkTypePgto      := qrSqlAux.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
      FkPriceTable.PkPriceTable     := qrSqlAux.FieldByName('FK_TABELA_PRECOS').AsInteger;
      FkTypeDiscount.PkTypeDiscount := qrSqlAux.FieldByName('FK_TIPO_DESCONTOS').AsInteger;
      FkTypeEstablishment           := qrSqlAux.FieldByName('FK_TIPO_ESTABELECIMENTOS').AsInteger;
      FkTypeFraction                := qrSqlAux.FieldByName('FK_TIPO_TABELA_FRACAO').AsInteger;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

procedure TdmSysTrans.LoadOrderParams;
begin
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlModuleParams);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
    qrSqlAux.ParamByName('PkParametrosPed').AsInteger := 1;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    FFkTypeDocument  := qrSqlAux.FieldByName('FK_TIPO_DOCUMENTOS').AsInteger;
    FFkStatusPedidos := qrSqlAux.FieldByName('FK_TIPO_STATUS_PEDIDOS').AsInteger;
    FFkGroupMovement := qrSqlAux.FieldByName('FK_GRUPOS_MOVIMENTOS').AsInteger;
    FFkTypeMovement  := qrSqlAux.FieldByName('FK_TIPO_MOVIMENTOS').AsInteger;
    FFkTypePayment   := qrSqlAux.FieldByName('FK_TIPO_PAGAMENTOS').AsInteger;
    FFkOccDriver     := qrSqlAux.FieldByName('FK_CARGOS_MOTORISTAS').AsInteger;
    FFkOccPorters    := qrSqlAux.FieldByName('FK_CARGOS_CONFERENTES').AsInteger;
    FFkOccSurveyors  := qrSqlAux.FieldByName('FK_CARGOS_CARREGADORES').AsInteger;
    FFkCadastros     := qrSqlAux.FieldByName('FK_CLIENTES').AsInteger;
    FIdxConv         := qrSqlAux.FieldByName('IDX_CONV').AsFloat;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysTrans.LoadOriginDestination(const AFkOwner, AFkDestination,
  AFkPriceTable, ALoadAll: Integer): Integer;
var
  aStr: TStrings;
  aRegion: Integer;
begin
  Result := 0;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlOwnerRegion);
  try
    qrSqlAux.ParamByName('FkCadastros').AsInteger := AFkOwner;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    aRegion := qrSqlAux.FieldByName('FK_REGIOES_UF').AsInteger;
    if (qrSqlAux.FieldByName('FK_REGIOES_MUN').AsInteger > 0) then
      aRegion := qrSqlAux.FieldByName('FK_REGIOES_MUN').AsInteger;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
  aStr := LoadPriceTable(aRegion, AFkDestination, ALoadAll, AFkPriceTable);
  try
    if (aStr.Count > 1) and (aStr.Objects[1] <> nil) then
      Result := TTypeTable(aStr.Objects[1]).PkCalcOrgmDstn;
  finally
    FreeAndNil(aStr);
  end;
end;

function TdmSysTrans.LoadPartners: TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlPartners);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        aItem             := TOwner.Create;
        aItem.PkCadastros := qrSqlAux.FindField('PK_CADASTROS').AsInteger;
        aItem.RazSoc      := qrSqlAux.FindField('RAZ_SOC').AsString;
        aItem.FlagTCad    := TTypeOwner(qrSqlAux.FindField('FLAG_TCAD').AsInteger);
        aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysTrans.LoadPriceTable(const AFkOrigin, AFkDestination: Integer;
  ALoadAll: Integer = 1; AFkPriceTable: Integer = 0): TStrings;
var
  aData: TTypeTable;
begin
  if (ALoadAll < -1) and (ALoadAll > 1) then ALoadAll := 1;
  if (AFkPriceTable < 0) then AFkPriceTable := 0;
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlPriceTables1);
  qrSqlAux.SQL.Add(SqlPriceTables2);
//  qrSqlAux.SQL.Add(SqlPriceTables3);
  try
    qrSqlAux.ParamByName('FlagDefTab').AsInteger         := ALoadAll;
    qrSqlAux.ParamByName('FkCargasRegioesOrg').AsInteger := AFkOrigin;
    qrSqlAux.ParamByName('FkCargasRegioesDst').AsInteger := AFkDestination;
    qrSqlAux.ParamByName('FkTabelaPrecos').AsInteger     := AFkPriceTable;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      aData                := TTypeTable.Create;
      aData.DscFrac        := qrSqlAux.FieldByName('DSC_FRAC').AsString;
      aData.DscTab         := qrSqlAux.FieldByName('DSC_TAB').AsString;
      aData.FlagType       := TTypeFraction(qrSqlAux.FieldByName('FLAG_TIPO').AsInteger);
      aData.PercDsct       := qrSqlAux.FieldByName('PERC_DSCT').AsFloat;
      aData.PkCalcOrgmDstn := qrSqlAux.FieldByName('PK_TABELA_ORIGEM_DESTINO').AsInteger;
      aData.PkPriceTable   := qrSqlAux.FieldByName('PK_TABELA_PRECOS').AsInteger;
      aData.PkTypeFraction := qrSqlAux.FieldByName('PK_TIPO_TABELA_FRACAO').AsInteger;
      Result.AddObject(aData.Description, aData);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

function TdmSysTrans.LoadProducts: TStrings;
var
  aData: TProducts;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlProducts);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      aData := TProducts.Create;
      aData.DscProd              := qrSqlAux.FieldByName('DSC_PROD').AsString;
      with aData.ProductCodes.Add do
        CodRef                   := qrSqlAux.FieldByName('COD_REF').AsString;
      aData.FkUnit.PkUnit        := qrSqlAux.FieldByName('PK_UNIDADES').AsInteger;
      aData.FkUnit.MnmoUni       := qrSqlAux.FieldByName('MNMO_UNI').AsString;
      aData.FkUnit.DscUni        := qrSqlAux.FieldByName('MNMO_UNI').AsString;
      with aData.ProductService.ProductCarrier do
      begin
        FlagTCarrier             := TTypeCarrier(qrSqlAux.FieldByName('FLAG_TP_FRE').AsInteger);
        FlagRdsp                 := Boolean(qrSqlAux.FieldByName('FLAG_RDSP').AsInteger);
      end;
      aData.PkProducts           := qrSqlAux.FieldByName('PK_PRODUTOS').AsInteger;
      Result.AddObject(IntToStr(aData.PkProducts) + ' - ' + aData.DscProd, aData);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

function TdmSysTrans.LoadRegion(AFkRegion: Integer): string;
begin
  Result := '';
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlRegions);
  try
    qrSqlAux.ParamByName('FkCargasRegioes').AsInteger := AFkRegion;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result := qrSqlAux.FieldByName('DSC_REG').AsString;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

function TdmSysTrans.LoadSalers: TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlSalers);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        aItem             := TOwner.Create;
        aItem.PkCadastros := qrSqlAux.FindField('PK_CADASTROS').AsInteger;
        aItem.RazSoc      := qrSqlAux.FindField('RAZ_SOC').AsString;
        aItem.FlagTCad    := TTypeOwner(qrSqlAux.FindField('FLAG_TCAD').AsInteger);
        aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysTrans.LoadState(const AFkCountry: Integer): TStrings;
var
  aData: TState;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlStates);
  try
    qrSqlAux.ParamByName('FkPaises').AsInteger := AFkCountry;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      aData := TState.Create;
      aData.FkCountry.PKCountry  := qrSqlAux.FieldByName('PK_PAISES').AsInteger;
      aData.FkCountry.DscPais    := qrSqlAux.FieldByName('DSC_PAIS').AsString;
      aData.PkState              := qrSqlAux.FieldByName('PK_ESTADOS').AsString;
      aData.DscUF                := qrSqlAux.FieldByName('DSC_UF').AsString;
      aData.FkRegions            := qrSqlAux.FieldByName('FK_CARGAS_REGIOES').AsInteger;
      Result.AddObject(aData.DscUF, aData);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

function TdmSysTrans.LoadTypeDocument: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeDocument);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_TDOC').AsString,
        TObject(qrSqlAux.FieldByName('PK_TIPO_DOCUMENTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

procedure TdmSysTrans.SetCarrierDocument(APk: Integer;
  const Value: TCarrierOrder);
begin
  if (Value = nil) or (Value.Order = nil) or (TDBMode(APk) <> dbmInsert) then exit;
  FFkCadastros    := Value.Order.FkOwner.PkCadastros;
  if (qrCarrierOrder.Active) then qrCarrierOrder.Close;
  qrCarrierOrder.SQL.Clear;
  qrCarrierOrder.SQL.Add(SqlInsertCarrierDoc);
  if (Value.FkConsignee = 0) then
    qrCarrierOrder.SQL.Text := StringReplace(qrCarrierOrder.SQL.Text, ':FkConsignatario', 'null', [rfReplaceAll]);
  Dados.StartTransaction(qrCarrierOrder);
  try
    Document[APk] := Value.Order;
    qrCarrierOrder.ParamByName('FkEmpresas').AsInteger            := Dados.PkCompany;
    qrCarrierOrder.ParamByName('FkDocumentos').AsInteger          := Value.Order.PkOrder;
    qrCarrierOrder.ParamByName('FkTipoDocumentos').AsInteger      := FFkTypeDocument;
    qrCarrierOrder.ParamByName('FkCadastros').AsInteger           := FFkCadastros;
    qrCarrierOrder.ParamByName('FkGruposMovimentos').AsInteger    := FFkGroupMovement;
    qrCarrierOrder.ParamByName('FkTipoMovimentos').AsInteger      := FFkTypeMovement;
    qrCarrierOrder.ParamByName('FkRemetente').AsInteger           := Value.FkShipper;
    qrCarrierOrder.ParamByName('FkDestinatario').AsInteger        := Value.FkAddressee;
    qrCarrierOrder.ParamByName('FkProdutosFretes').AsInteger      := Value.FkProduct.PkProducts;
    qrCarrierOrder.ParamByName('FkTipoTabelaFracao').AsInteger    := Value.TypeTable.PkTypeFraction;
    qrCarrierOrder.ParamByName('FkTabelaOrigemDestino').AsInteger := Value.TypeTable.PkCalcOrgmDstn;
    qrCarrierOrder.ParamByName('FlagES').AsInteger                := Ord(Value.FlagES);
    qrCarrierOrder.ParamByName('FlagRemb').AsInteger              := Ord(Value.FlagRemb);
    qrCarrierOrder.ParamByName('FlagTpFre').AsInteger             := Ord(Value.FlagTpFre);
    qrCarrierOrder.ParamByName('VlrFre').AsFloat                  := Value.Order.VlrFret;
    qrCarrierOrder.ParamByName('PlcVei').AsString                 := Value.Order.PlcVei;
    qrCarrierOrder.ParamByName('QtdVol').AsInteger                := Value.Order.QtdVol;
    qrCarrierOrder.ParamByName('PesLiq').AsFloat                  := Value.Order.PesLiq;
    qrCarrierOrder.ParamByName('PesBru').AsFloat                  := Value.Order.PesBru;
    qrCarrierOrder.ParamByName('NumVol').AsInteger                := Value.Order.NumVol;
    qrCarrierOrder.ParamByName('TipoVol').AsString                := Value.Order.TipoVol;
    qrCarrierOrder.ParamByName('MarcaVol').AsString               := Value.Order.TipoVol;
    qrCarrierOrder.ParamByName('NumNF').AsInteger                 := Value.NumNF;
    qrCarrierOrder.ParamByName('VlrNF').AsFloat                   := Value.VlrNF;
    qrCarrierOrder.ParamByName('VlrFrePeso').AsFloat              := Value.VlrFrePeso;
    qrCarrierOrder.ParamByName('FreVlr').AsFloat                  := Value.FreVlr;
    qrCarrierOrder.ParamByName('VlrSecat').AsFloat                := Value.VlrSecat;
    qrCarrierOrder.ParamByName('VlrGris').AsFloat                 := Value.VlrGris;
    qrCarrierOrder.ParamByName('VlrPedg').AsFloat                 := Value.VlrPedg;
    qrCarrierOrder.ParamByName('VlrDifAcc').AsFloat               := Value.VlrDifAcc;
    qrCarrierOrder.ParamByName('AlqtIcms').AsFloat                := Value.AlqtIcms;
    qrCarrierOrder.ParamByName('QtdProd').AsFloat                 := Value.QtdProd;
    if (qrCarrierOrder.Params.FindParam('FkConsignatario')       <> nil) then
      qrCarrierOrder.ParamByName('FkConsignatario').AsInteger     := Value.FkConsignee;
    qrCarrierOrder.ExecSQL;
    if (qrCarrierOrder.Active) then qrCarrierOrder.Close;
    qrCarrierOrder.SQL.Text := qrCarrierWeight.SQL.Text;
    CarrierOrderWght[dtDocument, Value.Order.PkOrder] := Value.CarrierWeights;
    qrCarrierOrder.SQL.Text := qrCarrierPartner.SQL.Text;
    CarrierOrderPrnt[dtDocument, Value.Order.PkOrder] := Value.CarrierPartner;
    Dados.CommitTransaction(qrCarrierOrder);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrCarrierOrder);
      raise Exception.Create('SetCarrierDocument: Erro na gravação do Documento' + NL +
        E.Message + NL + qrCarrierOrder.SQL.Text);
    end;
  end;
  FFkShipper   := Value.FkShipper;
  FFkAddressee := Value.FkAddressee;
  FFkConsignee := Value.FkConsignee;
end;

procedure TdmSysTrans.SetCarrierOrder(APk: Integer; const Value: TCarrierOrder);
begin
  if (Value = nil) or (Value.Order = nil) then exit;
  if (qrCarrierOrder.Active) then qrCarrierOrder.Close;
  qrCarrierOrder.SQL.Clear;
  case TDBMode(APk) of
    dbmInsert: qrCarrierOrder.SQL.Add(SqlInsertCarrierOrder);
    dbmEdit  : qrCarrierOrder.SQL.Add(SqlUpdateCarrierOrder);
  end;
  if (Value.FkConsignee = 0) then
    qrCarrierOrder.SQL.Text := StringReplace(qrCarrierOrder.SQL.Text, ':FkConsignatario', 'null', [rfReplaceAll]);
  if (Value.FkAddressee = 0) then
    qrCarrierOrder.SQL.Text := StringReplace(qrCarrierOrder.SQL.Text, ':FkDestinatario', 'null', [rfReplaceAll]);
  if (Value.FkShipper = 0) then
    qrCarrierOrder.SQL.Text := StringReplace(qrCarrierOrder.SQL.Text, ':FkRemetente', 'null', [rfReplaceAll]);
  Dados.StartTransaction(qrCarrierOrder);
  try
    Order[APk] := Value.Order;
    if (TDBMode(APk) = dbmDelete) then exit;
    qrCarrierOrder.ParamByName('FkEmpresas').AsInteger              := Dados.PkCompany;
    qrCarrierOrder.ParamByName('FkPedidos').AsInteger               := Value.Order.PkOrder;
    if (qrCarrierOrder.Params.FindParam('FkRemetente')           <> nil) then
      qrCarrierOrder.ParamByName('FkRemetente').AsInteger           := Value.FkShipper;
    if (qrCarrierOrder.Params.FindParam('FkDestinatario')        <> nil) then
      qrCarrierOrder.ParamByName('FkDestinatario').AsInteger        := Value.FkAddressee;
    if (qrCarrierOrder.Params.FindParam('FkConsignatario')       <> nil) then
      qrCarrierOrder.ParamByName('FkConsignatario').AsInteger       := Value.FkConsignee;
    if (qrCarrierOrder.Params.FindParam('FkTipoTabelaFracao')    <> nil) then
      qrCarrierOrder.ParamByName('FkTipoTabelaFracao').AsInteger    := Value.TypeTable.PkTypeFraction;
    if (qrCarrierOrder.Params.FindParam('FkTabelaPrecos')        <> nil) then
      qrCarrierOrder.ParamByName('FkTabelaPrecos').AsInteger        := Value.TypeTable.PkPriceTable;
    if (qrCarrierOrder.Params.FindParam('FkTabelaOrigemDestino') <> nil) then
      qrCarrierOrder.ParamByName('FkTabelaOrigemDestino').AsInteger := Value.TypeTable.PkCalcOrgmDstn;
    if (qrCarrierOrder.Params.FindParam('FkProdutosFretes')      <> nil) then
      qrCarrierOrder.ParamByName('FkProdutosFretes').AsInteger      := Value.FkProduct.PkProducts;
    if (qrCarrierOrder.Params.FindParam('FlagES')                <> nil) then
      qrCarrierOrder.ParamByName('FlagES').AsInteger                := Ord(Value.FlagES);
    if (qrCarrierOrder.Params.FindParam('FlagRemb')              <> nil) then
      qrCarrierOrder.ParamByName('FlagRemb').AsInteger              := Ord(Value.FlagRemb);
    if (qrCarrierOrder.Params.FindParam('FlagTpFre')             <> nil) then
      qrCarrierOrder.ParamByName('FlagTpFre').AsInteger             := Ord(Value.FlagTpFre);
    if (qrCarrierOrder.Params.FindParam('NumNF')                 <> nil) then
      qrCarrierOrder.ParamByName('NumNF').AsInteger                 := Value.NumNF;
    if (qrCarrierOrder.Params.FindParam('VlrNF')                 <> nil) then
      qrCarrierOrder.ParamByName('VlrNF').AsFloat                   := Value.VlrNF;
    if (qrCarrierOrder.Params.FindParam('VlrFrePeso')            <> nil) then
      qrCarrierOrder.ParamByName('VlrFrePeso').AsFloat              := Value.VlrFrePeso;
    if (qrCarrierOrder.Params.FindParam('FreVlr')                <> nil) then
      qrCarrierOrder.ParamByName('FreVlr').AsFloat                  := Value.FreVlr;
    if (qrCarrierOrder.Params.FindParam('VlrSecat')              <> nil) then
      qrCarrierOrder.ParamByName('VlrSecat').AsFloat                := Value.VlrSecat;
    if (qrCarrierOrder.Params.FindParam('VlrGris')               <> nil) then
      qrCarrierOrder.ParamByName('VlrGris').AsFloat                 := Value.VlrGris;
    if (qrCarrierOrder.Params.FindParam('VlrPedg')               <> nil) then
      qrCarrierOrder.ParamByName('VlrPedg').AsFloat                 := Value.VlrPedg;
    if (qrCarrierOrder.Params.FindParam('VlrDifAcc')             <> nil) then
      qrCarrierOrder.ParamByName('VlrDifAcc').AsFloat               := Value.VlrDifAcc;
    if (qrCarrierOrder.Params.FindParam('AlqtIcms')              <> nil) then
      qrCarrierOrder.ParamByName('AlqtIcms').AsFloat                := Value.AlqtIcms;
    if (qrCarrierOrder.Params.FindParam('QtdProd')              <> nil) then
      qrCarrierOrder.ParamByName('QtdProd').AsFloat                 := Value.QtdProd;
    qrCarrierOrder.ExecSQL;
    CarrierOrderWght[dtSimulator, Value.Order.PkOrder]    := Value.CarrierWeights;
    CarrierOrderPrnt[dtSimulator, Value.Order.PkOrder]    := Value.CarrierPartner;
    CarrierOrderOrDt[Value.Order.PkOrder, 0]              := Value.CityOrigim;
    CarrierOrderOrDt[Value.Order.PkOrder, 1]              := Value.CityDestination;
    Dados.CommitTransaction(qrCarrierOrder);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrCarrierOrder);
      raise Exception.Create('SetCarrierOrder: Erro na gravação do Orçamento' + NL +
        E.Message + NL + qrCarrierOrder.SQL.Text);
    end;
  end;
end;

procedure TdmSysTrans.SetCarrierOrgmDstn(APk, AOD: Integer;
  const Value: TCity);
begin
  if qrCarrierOrDt.Active then qrCarrierOrDt.Close;
  qrCarrierOrDt.SQL.Clear;
  qrCarrierOrDt.SQL.Add(SqlDelCarrierOrdOrDt);
  try
    qrCarrierOrDt.ParamByName('FkEmpresas').AsInteger           := Dados.PkCompany;
    qrCarrierOrDt.ParamByName('FkPedidos').AsInteger            := APk;
    qrCarrierOrDt.ParamByName('PkPedidosFretesLocal').AsInteger := AOD;
    qrCarrierOrDt.ExecSQL;
    qrCarrierOrDt.SQL.Clear;
    qrCarrierOrDt.SQL.Add(SqlInsCarrierOrdOrDt);
    qrCarrierOrDt.ParamByName('FkEmpresas').AsInteger           := Dados.PkCompany;
    qrCarrierOrDt.ParamByName('FkPedidos').AsInteger            := APk;
    qrCarrierOrDt.ParamByName('PkPedidosFretesLocal').AsInteger := AOD;
    qrCarrierOrDt.ParamByName('FkPaises').AsInteger             := Value.FkState.FkCountry.PKCountry;
    qrCarrierOrDt.ParamByName('FkEstados').AsString             := Value.FkState.PkState;
    qrCarrierOrDt.ParamByName('FkMunicipios').AsInteger         := Value.PkCity;
    qrCarrierOrDt.ParamByName('DscReg').AsString                := Value.DscMun;
    qrCarrierOrDt.ExecSQL;
  finally
    if qrCarrierOrDt.Active then qrCarrierOrDt.Close;
  end;
end;

procedure TdmSysTrans.SetCarrierPartner(AType: TDocumentType; APk: Integer;
  const Value: TCarrierPartner);
begin
  if qrCarrierPartner.Active then qrCarrierPartner.Close;
  qrCarrierPartner.SQL.Clear;
  if (AType = dtSimulator) then
    qrCarrierPartner.SQL.Add(SqlDelCarrierOrdPrtn)
  else
    qrCarrierPartner.SQL.Add(SqlDelCarrierDocPrtn);
  try
    qrCarrierPartner.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    if (AType = dtSimulator) then
      qrCarrierPartner.ParamByName('FkPedidos').AsInteger  := APk
    else
    begin
      qrCarrierPartner.ParamByName('FkTipoDocumentos').AsInteger := FFkTypeDocument;
      qrCarrierPartner.ParamByName('FkCadastros').AsInteger      := FFkCadastros;
      qrCarrierPartner.ParamByName('FkDocumentos').AsInteger     := APk;
    end;
    qrCarrierPartner.ExecSQL;
    if (Value.FKPartner = 0) then exit;
    qrCarrierPartner.SQL.Clear;
    if (AType = dtSimulator) then
      qrCarrierPartner.SQL.Add(SqlInsCarrierOrdPrtn)
    else
      qrCarrierPartner.SQL.Add(SqlInsCarrierDocPrtn);
    qrCarrierPartner.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    if (AType = dtSimulator) then
      qrCarrierPartner.ParamByName('FkPedidos').AsInteger  := APk
    else
    begin
      qrCarrierPartner.ParamByName('FkTipoDocumentos').AsInteger := FFkTypeDocument;
      qrCarrierPartner.ParamByName('FkCadastros').AsInteger      := FFkCadastros;
      qrCarrierPartner.ParamByName('FkDocumentos').AsInteger     := APk;
    end;
    qrCarrierPartner.ParamByName('FkParceiro').AsInteger := Value.FKPartner;
    qrCarrierPartner.ParamByName('FreVlr').AsFloat       := Value.FreVlr;
    qrCarrierPartner.ParamByName('VlrFrePeso').AsFloat   := Value.VlrFrePeso;
    qrCarrierPartner.ParamByName('VlrSecat').AsFloat     := Value.VlrSecat;
    qrCarrierPartner.ParamByName('VlrGris').AsFloat      := Value.VlrGris;
    qrCarrierPartner.ParamByName('VlrPedg').AsFloat      := Value.VlrPedg;
    qrCarrierPartner.ParamByName('VlrDifAcc').AsFloat    := Value.VlrDifAcc;
    qrCarrierPartner.ExecSQL;
  finally
    if qrCarrierWeight.Active then qrCarrierWeight.Close;
  end;
end;

procedure TdmSysTrans.SetCarrierWeights(AType: TDocumentType; APk: Integer;
  const Value: TCarrierWeights);
var
  i: Integer;
begin
  if qrCarrierWeight.Active then qrCarrierWeight.Close;
  qrCarrierWeight.SQL.Clear;
  if (AType = dtSimulator) then
    qrCarrierWeight.SQL.Add(SqlDelCarrierOrdWght)
  else
    qrCarrierWeight.SQL.Add(SqlDelCarrierDocWght);
  try
    qrCarrierWeight.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
    if (AType = dtSimulator) then
      qrCarrierWeight.ParamByName('FkPedidosFretes').AsInteger := APk
    else
    begin
      qrCarrierWeight.ParamByName('FkTipoDocumentos').AsInteger := FFkTypeDocument;
      qrCarrierWeight.ParamByName('FkCadastros').AsInteger      := FFkCadastros;
      qrCarrierWeight.ParamByName('FkDocumentos').AsInteger     := APk;
    end;
    qrCarrierWeight.ExecSQL;
    qrCarrierWeight.SQL.Clear;
    if (AType = dtSimulator) then
      qrCarrierWeight.SQL.Add(SqlInsCarrierOrdWght)
    else
      qrCarrierWeight.SQL.Add(SqlInsCarrierDocWght);
    for i := 0 to Value.Count - 1 do
    begin
      qrCarrierWeight.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
      if (AType = dtSimulator) then
      begin
        qrCarrierWeight.ParamByName('FkPedidosFretes').AsInteger  := APk;
        qrCarrierWeight.ParamByName('PkFretesMedidas').AsInteger  := i + 1;
      end
      else
      begin
        qrCarrierWeight.ParamByName('FkTipoDocumentos').AsInteger := FFkTypeDocument;
        qrCarrierWeight.ParamByName('FkCadastros').AsInteger      := FFkCadastros;
        qrCarrierWeight.ParamByName('FkDocumentos').AsInteger     := APk;
        qrCarrierWeight.ParamByName('PkConhecimentosMedidas').AsInteger     := i + 1;
      end;
      qrCarrierWeight.ParamByName('AltVol').AsFloat               := Value.Items[i].AltVol;
      qrCarrierWeight.ParamByName('LargVol').AsFloat              := Value.Items[i].LargVol;
      qrCarrierWeight.ParamByName('ProfVol').AsFloat              := Value.Items[i].ProfVol;
      qrCarrierWeight.ExecSQL;
    end;
  finally
    if qrCarrierWeight.Active then qrCarrierWeight.Close;
  end;
end;

procedure TdmSysTrans.SetDiscounts(AType: TDocumentType; APk: Integer;
  const Value: TDiscounts);
var
  i: Integer;
begin
  if (AType = dtDocument) then exit;
  try
    if qrTypeDiscount.Active then qrTypeDiscount.Close;
    qrTypeDiscount.SQL.Clear;
    qrTypeDiscount.SQL.Add(SqlDelOrderDsct);
    qrTypeDiscount.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrTypeDiscount.ParamByName('FkPedidos').AsInteger  := APk;
    qrTypeDiscount.ExecSQL;
    for i := 0 to Value.Count - 1 do
    begin
      if qrTypeDiscount.Active then qrTypeDiscount.Close;
      qrTypeDiscount.SQL.Clear;
      qrTypeDiscount.SQL.Add(SqlInsOrderDsct);
      qrTypeDiscount.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
      qrTypeDiscount.ParamByName('FkPedidos').AsInteger          := APk;
      qrTypeDiscount.ParamByName('PkPedidosDescontos').AsInteger := i + 1;
      qrTypeDiscount.ParamByName('DscDsct').AsString             := Value.Items[i].DscDsct;
      qrTypeDiscount.ParamByName('IdxDsct').AsFloat              := Value.Items[i].IdxDsct;
      qrTypeDiscount.ParamByName('FlagTDsct').AsInteger          := Ord(Value.Items[i].FlagTDsct);
      qrTypeDiscount.ParamByName('FlagDstq').AsInteger           := Ord(Value.Items[i].FlagDstq);
      qrTypeDiscount.ExecSQL;
    end;
  finally
    if qrTypeDiscount.Active then qrTypeDiscount.Close;
  end;
end;

procedure TdmSysTrans.SetDocument(APk: Integer; const Value: TOrder);
  function GetPkOrder: Integer;
  begin
    Result := 0;
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGetPkCarrierDoc);
    qrSqlAux.ParamByName('FkEmpresas').AsInteger       := Dados.PkCompany;
    qrSqlAux.ParamByName('FkTipoDocumentos').AsInteger := FFkTypeDocument;
    if not qrSqlAux.Active then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
      Result := qrSqlAux.FieldByName('PK_DOCUMENTOS').AsInteger;
    if qrSqlAux.Active then qrSqlAux.Close;
  end;
begin
  if (Value = nil) then exit;
  if qrOrders.Active then qrOrders.Close;
  qrOrders.SQL.Clear;
  if (TDBMode(APk) <> dbmInsert) then
    raise Exception.Create('SetDocument: Can´t execute this operation (' +
      ModeTypes[TDBMode(APk)] + ') on this dataset!');
  qrOrders.SQL.AddStrings(GetInsertSQL(Value.GetDocFields, 'DOCUMENTOS'));
  if (qrOrders.SQL.Text = '') then
    raise Exception.Create('SetDocument: Can´t build SQL from this dataset!');
  try
    qrOrders.ParamByName('FkEmpresas').AsInteger          := Dados.PkCompany;
    qrOrders.ParamByName('FkTipoDocumentos').AsInteger    := FFkTypeDocument;
    qrOrders.ParamByName('FkCadastros').AsInteger         := FFkCadastros;
    if (TDBMode(APk) = dbmInsert) or (Value.PkOrder = 0) then
      Value.PkOrder                                       := GetPkOrder;
    qrOrders.ParamByName('PkDocumentos').AsInteger        := Value.PkOrder;
    qrOrders.ParamByName('FkGruposMovimentos').AsInteger  := FFkGroupMovement;
    if (Value.FkTypePayment <> nil) and (Value.FkTypePayment.PkTypePgto > 0) then
      qrOrders.ParamByName('FkTipoPagamentos').AsInteger  := Value.FkTypePayment.PkTypePgto
    else
      qrOrders.ParamByName('FkTipoPagamentos').AsInteger  := FFkTypePayment;
    if (qrOrders.Params.FindParam('FkTipoPrazoEntrega') <> nil) then
      qrOrders.ParamByName('FkTipoPrazoEntrega').AsInteger:= Value.FkDeliveryPeriod;
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
    if (qrOrders.Params.FindParam('NumVol') <> nil) then
      qrOrders.ParamByName('NumVol').AsInteger            := Value.NumVol;
    if (qrOrders.Params.FindParam('TipoVol') <> nil) then
      qrOrders.ParamByName('TipoVol').AsString            := Value.TipoVol;
    if (qrOrders.Params.FindParam('FlagCanc') <> nil) then
      qrOrders.ParamByName('FlagCanc').AsInteger          := Ord(Value.FlagBxaC);
    if (qrOrders.Params.FindParam('FlagBxaC') <> nil) then
      qrOrders.ParamByName('FlagBxaC').AsInteger          := Ord(Value.FlagBxaC);
    if (qrOrders.Params.FindParam('FlagCtb') <> nil) then
      qrOrders.ParamByName('FlagCtb').AsInteger           := Ord(Value.FlagCtb);
    if (qrOrders.Params.FindParam('FlagCPrve') <> nil) then
      qrOrders.ParamByName('FlagCPrve').AsInteger         := Ord(Value.FlagCPrvE);
    if (qrOrders.Params.FindParam('FlagDtaBas') <> nil) then
      qrOrders.ParamByName('FlagDtaBas').AsInteger        := Ord(Value.FlagDtaBas);
    if (qrOrders.Params.FindParam('QtdVol') <> nil) then
      qrOrders.ParamByName('QtdVol').AsInteger            := Value.QtdVol;
    if (qrOrders.Params.FindParam('VlrFre') <> nil) then
      qrOrders.ParamByName('VlrFre').AsFloat             := 0;
    if (qrOrders.Params.FindParam('VlrSeg') <> nil) then
      qrOrders.ParamByName('VlrSeg').AsFloat              := Value.VlrSeg;
    if (qrOrders.Params.FindParam('VlrEntr') <> nil) then
      qrOrders.ParamByName('VlrEntr').AsFloat             := Value.VlrEntr;
    if (qrOrders.Params.FindParam('VlrDspAces') <> nil) then
      qrOrders.ParamByName('VlrDspAces').AsFloat          := Value.DspAces;
    if (qrOrders.Params.FindParam('VlrAcrDsct') <> nil) then
      qrOrders.ParamByName('VlrAcrDsct').AsFloat          := Value.VlrAcrDsct;
    if (qrOrders.Params.FindParam('VlrSTot') <> nil) then
      qrOrders.ParamByName('VlrSTot').AsFloat             := Value.VlrFret;
    if (qrOrders.Params.FindParam('ValTot') <> nil) then
      qrOrders.ParamByName('ValTot').AsFloat              := Value.VlrFret + Value.VlrAcrDsct;
    if (qrOrders.Params.FindParam('PesLiq') <> nil) then
      qrOrders.ParamByName('PesLiq').AsFloat              := Value.PesLiq;
    if (qrOrders.Params.FindParam('PesBru') <> nil) then
      qrOrders.ParamByName('PesBru').AsFloat              := Value.PesBru;
    if (qrOrders.Params.FindParam('DataDoc') <> nil) then
      qrOrders.ParamByName('DataDoc').AsDate              := Value.DtaPed;
    if (qrOrders.Params.FindParam('DtaLiq') <> nil) then
      qrOrders.ParamByName('DtaLiq').AsDate               := Value.DtaLiq;
    if (qrOrders.Params.FindParam('DtaCanc') <> nil) then
      qrOrders.ParamByName('DtaCanc').AsDate              := Value.DtaCanc;
    if (qrOrders.Params.FindParam('DtaBas') <> nil) then
      qrOrders.ParamByName('DtaBas').AsDate               := Value.DtaBas;
    if (qrOrders.Params.FindParam('DtaEmb') <> nil) then
      qrOrders.ParamByName('DtaEmb').AsDate               := Value.DtaEmb;
    if (qrOrders.Params.FindParam('DtaEmbExt') <> nil) then
      qrOrders.ParamByName('DtaEmbExt').AsDate            := Value.DtaEmb;
    if (qrOrders.Params.FindParam('NumExtr') <> nil) then
      qrOrders.ParamByName('NumExtr').AsString            := Value.NumExtr;
    if (qrOrders.Params.FindParam('NumProForma') <> nil) then
      qrOrders.ParamByName('NumProForma').AsInteger       := Value.NumProForma;
    if (qrOrders.Params.FindParam('VlrBICMS') <> nil) then
      qrOrders.ParamByName('VlrBICMS').AsFloat            := Value.BasIcms;
    if (qrOrders.Params.FindParam('VlrICMS') <> nil) then
      qrOrders.ParamByName('VlrICMS').AsFloat             := Value.VlrIcms;
    if (qrOrders.Params.FindParam('VlrBICMSS') <> nil) then
      qrOrders.ParamByName('VlrBICMSS').AsFloat           := Value.BasIcmss;
    if (qrOrders.Params.FindParam('VlrICMSS') <> nil) then
      qrOrders.ParamByName('VlrICMSS').AsFloat            := Value.VlrIcmss;
    if (qrOrders.Params.FindParam('VlrBIsnt') <> nil) then
      qrOrders.ParamByName('VlrBIsnt').AsFloat            := Value.BasIsnt;
    if (qrOrders.Params.FindParam('VlrBIPI') <> nil) then
      qrOrders.ParamByName('VlrBIPI').AsFloat             := Value.BasIpi;
    if (qrOrders.Params.FindParam('ValIPI') <> nil) then
      qrOrders.ParamByName('ValIPI').AsFloat              := Value.VlrIpi;
    if (qrOrders.Params.FindParam('VlrBISS') <> nil) then
      qrOrders.ParamByName('VlrBISS').AsFloat             := Value.BasIss;
    if (qrOrders.Params.FindParam('VlrISS') <> nil) then
      qrOrders.ParamByName('VlrISS').AsFloat              := Value.VlrIss;
    qrOrders.ExecSQL;
    if (TDBMode(APk) <> dbmDelete) then
      OrderMessages[dtSimulator, Value.PkOrder] := Value.OrderMessages;
    if qrOrders.Active then qrOrders.Close;
  except on E:Exception do
    begin
      if qrOrders.Active then qrOrders.Close;
      raise Exception.Create('SetDocument Exception:' + E.Message);
    end;
  end;
end;

procedure TdmSysTrans.SetMarkSupplier(const AFkMark, AFkOwner: Integer; const AState: TDBMode);
begin
  if qrMark.Active then qrMark.Close;
  qrMark.SQL.Clear;
  case TDBMode(AState) of
    dbmDelete : qrMark.SQL.Add(SqlDeleteMarkSupplier);
    dbmInsert : qrMark.SQL.Add(SqlInsertMarkSupplier);
  end;
  Dados.StartTransaction(qrMark);
  try
    qrMark.ParamByName('FkVeiculosMarcas').AsInteger := AFkMark;
    if qrMark.Params.FindParam('FkCadastros') <> nil then
      qrMark.ParamByName('FkCadastros').AsInteger    := AFkOwner;
    qrMark.ExecSQL;
    Dados.CommitTransaction(qrMark);
  except on E:Exception do
    begin
      if qrMark.Active then qrMark.Close;
      Dados.RollbackTransaction(qrMark);
      raise Exception.Create('SetMarkSupplier: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrMark.SQL.Text);
    end;
  end;
end;

procedure TdmSysTrans.SetInstallments(AType: TDocumentType; APk: Integer;
  const Value: TInstallments);
var
  i: Integer;
begin
  if (AType = dtDocument) then exit;
  try
    if qrInstallments.Active then qrInstallments.Close;
    qrInstallments.SQL.Clear;
    qrInstallments.SQL.Add(SqlDelPayOrder);
    qrInstallments.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    qrInstallments.ParamByName('FkPedidos').AsInteger  := APk;
    qrInstallments.ExecSQL;
    for i := 0 to Value.Count - 1 do
    begin
      if qrInstallments.Active then qrInstallments.Close;
      qrInstallments.SQL.Clear;
      qrInstallments.SQL.Add(SqlInsPayOrder);
      qrInstallments.ParamByName('FkEmpresas').AsInteger     := Dados.PkCompany;
      qrInstallments.ParamByName('FkPedidos').AsInteger      := APk;
      qrInstallments.ParamByName('PkPedidosParcelas').AsDate := Value.Items[i].DtaVenc;
      qrInstallments.ParamByName('NumParc').AsInteger        := Value.Items[i].Index + 1;
      qrInstallments.ParamByName('VlrParc').AsFloat          := Value.Items[i].VlrParc;
      qrInstallments.ExecSQL;
    end;
  finally
    if qrInstallments.Active then qrInstallments.Close;
  end;
end;

procedure TdmSysTrans.SetMarks(APk: Integer; const Value: TDataRow);
  function GetPkMark: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlPkGeneratorMark);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_VEICULOS_MARCAS').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrMark.Active then qrMark.Close;
  qrMark.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrMark.SQL.Add(SqlDeleteMark);
    dbmInsert : qrMark.SQL.Add(SqlInsertMark);
    dbmEdit   : qrMark.SQL.Add(SqlUpdateMark);
  end;
  Dados.StartTransaction(qrMark);
  try
    if (Value.FieldByName['PK_VEICULOS_MARCAS'].AsInteger = 0) then
      Value.FieldByName['PK_VEICULOS_MARCAS'].AsInteger := GetPkMark;
    qrMark.ParamByName('PkVeiculosMarcas').AsInteger := Value.FieldByName['PK_VEICULOS_MARCAS'].AsInteger;
    if qrMark.Params.FindParam('DscMrc') <> nil then
      qrMark.ParamByName('DscMrc').AsString := Value.FieldByName['DSC_MRC'].AsString;
    qrMark.ExecSQL;
    Dados.CommitTransaction(qrMark);
  except on E:Exception do
    begin
      if qrMark.Active then qrMark.Close;
      Dados.RollbackTransaction(qrMark);
      raise Exception.Create('SetMarks: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrMark.SQL.Text);
    end;
  end;
end;

procedure TdmSysTrans.SetMarkSuppliers(APk: Integer; const Value: TList);
var
  i: Integer;
  aData: TDataRow;
  aStt : TDBMode;
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  for i := 0 to Value.Count - 1 do
  begin
    aData := TDataRow(Value.Items[i]);
    if (aData <> nil) and (aData.Count > 0) then
    begin
      aStt := TDBMode(aData.FieldByName['STATUS'].AsInteger);
      if (aStt in UPDATE_MODE) then
        SetMarkSupplier(APk, aData.FieldByName['FK_CADASTROS'].AsInteger, aStt);
    end;
  end;
end;

procedure TdmSysTrans.SetOrder(APk: Integer; const Value: TOrder);
var
  aStr: TStrings;
  function GetPkOrder: Integer;
  begin
    Result := 0;
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGetPkOrder);
    qrSqlAux.ParamByName('FkEmpresas').AsInteger          := Dados.PkCompany;
    qrSqlAux.ParamByName('FkTipoStatusPedidos').AsInteger := FFkStatusPedidos;
    if not qrSqlAux.Active then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
      Result := qrSqlAux.FieldByName('PK_PEDIDOS').AsInteger;
    if qrSqlAux.Active then qrSqlAux.Close;
  end;
begin
  if (Value = nil) then exit;
  try
    if qrOrders.Active then qrOrders.Close;
    qrOrders.SQL.Clear;
    case TDBMode(APk) of
      dbmDelete: qrOrders.SQL.Add(SqlDeleteOrder);
      dbmInsert: qrOrders.SQL.AddStrings(GetInsertSQL(Value.GetFields, 'PEDIDOS'));
      dbmEdit  : begin
                   aStr := TStringList.Create;
                   try
                     aStr.Add('FK_EMPRESAS');
                     aStr.Add('PK_PEDIDOS');
                     qrOrders.SQL.AddStrings(GetUpdateSQL(Value.GetFields, aStr, 'PEDIDOS'));
                   finally
                     aStr.Free;
                   end;
                 end;
    end;
    qrOrders.ParamByName('FkEmpresas').AsInteger            := Dados.PkCompany;
    if (TDBMode(APk) = dbmInsert) or (Value.PkOrder = 0) then
      Value.PkOrder                                         := GetPkOrder;
    qrOrders.ParamByName('PkPedidos').AsInteger             := Value.PkOrder;
    if (qrOrders.Params.FindParam('OldFkEmpresas') <> nil) then
      qrOrders.ParamByName('OldFkEmpresas').AsInteger       := Dados.PkCompany;
    if (qrOrders.Params.FindParam('OldPkPedidos') <> nil) then
      qrOrders.ParamByName('OldPkPedidos').AsInteger        := Value.PkOrder;
    if (TDBMode(APk) <> dbmDelete) then
    begin
      qrOrders.ParamByName('FkGruposMovimentos').AsInteger  := FFkGroupMovement;
      qrOrders.ParamByName('FkTipoMovimentos').AsInteger    := FFkTypeMovement;
      if (Value.FkOwner.PkCadastros = 0) then
        qrOrders.ParamByName('FkCadastros').AsInteger       := FFkCadastros
      else
        qrOrders.ParamByName('FkCadastros').AsInteger       := Value.FkOwner.PkCadastros;
      qrOrders.ParamByName('FkTipoStatusPedidos').AsInteger := FFkStatusPedidos;
      if (Value.FkTypePayment <> nil) and (Value.FkTypePayment.PkTypePgto > 0) then
        qrOrders.ParamByName('FkTipoPagamentos').AsInteger  := Value.FkTypePayment.PkTypePgto
      else
        qrOrders.ParamByName('FkTipoPagamentos').AsInteger  := FFkTypePayment;
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
      qrOrders.ParamByName('FlagEdrtRdsp').AsInteger        := Ord(Value.FlagEDrtRdsp);
      qrOrders.ParamByName('FlagDtaBas').AsInteger          := Ord(Value.FlagDtaBas);
      qrOrders.ParamByName('QtdDupl').AsInteger             := Value.FkTypePayment.Installments.Count;
      qrOrders.ParamByName('QtdVol').AsInteger              := Value.QtdVol;
      qrOrders.ParamByName('QtdItem').AsInteger             := Value.OrderItems.Count;
      qrOrders.ParamByName('VlrFret').AsFloat               := 0;
      qrOrders.ParamByName('VlrSeg').AsFloat                := Value.VlrSeg;
      qrOrders.ParamByName('VlrEntr').AsFloat               := Value.VlrEntr;
      qrOrders.ParamByName('DspAces').AsFloat               := Value.DspAces;
      qrOrders.ParamByName('VlrAcrDsct').AsFloat            := Value.VlrAcrDsct;
      qrOrders.ParamByName('SubTot').AsFloat                := Value.VlrFret;
      qrOrders.ParamByName('TotPed').AsFloat                := Value.VlrFret + Value.VlrAcrDsct;
      qrOrders.ParamByName('PesLiq').AsFloat                := Value.PesLiq;
      qrOrders.ParamByName('PesBru').AsFloat                := Value.PesBru;
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
      if (qrOrders.Params.FindParam('NomCad') <> nil) then
        qrOrders.ParamByName('NomCad').AsString             := Value.NomCad;
      if (qrOrders.Params.FindParam('NumExtr') <> nil) then
        qrOrders.ParamByName('NumExtr').AsString            := Value.NumExtr;
      if (qrOrders.Params.FindParam('NumProForma') <> nil) then
        qrOrders.ParamByName('NumProForma').AsInteger       := Value.NumProForma;
      if (qrOrders.Params.FindParam('FkTipoPrazoEntrega') <> nil) then
        qrOrders.ParamByName('FkTipoPrazoEntrega').AsInteger:= Value.FkDeliveryPeriod;
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
    end;
    qrOrders.ExecSQL;
    if (TDBMode(APk) <> dbmDelete) then
    begin
      Discounts[dtSimulator, Value.PkOrder]     := Value.Discounts;
      OrderMessages[dtSimulator, Value.PkOrder] := Value.OrderMessages;
    end;
  finally
    if qrOrders.Active then qrOrders.Close;
  end;
end;

procedure TdmSysTrans.SetOrderMessages(AType: TDocumentType; APk: Integer;
  const Value: TOrderMessages);
var
  M: TMemoryStream;
  i: Integer;
begin
  if (AType = dtDocument) then exit;
  try
    if qrOrderMessage.Active then qrOrderMessage.Close;
    qrOrderMessage.SQL.Clear;
    qrOrderMessage.SQL.Add(SqlDelOrderMsg);
    qrOrderMessage.ParamByName('FkEmpresas').AsInteger    := Dados.PkCompany;
    qrOrderMessage.ParamByName('FkPedidos').AsInteger     := APk;
    qrOrderMessage.ExecSQL;
    if qrOrderMessage.Active then qrOrderMessage.Close;
    qrOrderMessage.SQL.Clear;
    qrOrderMessage.SQL.Add(SqlInsOrderMsg);
    for i := 0 to Value.Count - 1 do
    begin
      qrOrderMessage.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
      qrOrderMessage.ParamByName('FkPedidos').AsInteger          := APk;
      qrOrderMessage.ParamByName('PkPedidosMensagens').AsInteger := i + 1;
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
  finally
    if qrOrderMessage.Active then qrOrderMessage.Close;
  end;
end;

procedure TdmSysTrans.SetOrderToDocument(APk: Integer;
  const Value: TCarrierOrder);
begin

end;

procedure TdmSysTrans.SetTypeManifest(APk: Integer; const Value: TDataRow);
  function GetPKTypeManifest: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkTypeManifest);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_TIPO_MANIFESTOS').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrTypeManifest.Active then qrTypeManifest.Close;
  qrTypeManifest.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrTypeManifest.SQL.Add(SqlDeleteTypeManifest);
    dbmInsert : qrTypeManifest.SQL.Add(SqlInsertTypeManifest);
    dbmEdit   : qrTypeManifest.SQL.Add(SqlUpdateTypeManifest);
  end;
  Dados.StartTransaction(qrTypeManifest);
  try
    if (Value.FieldByName['PK_TIPO_MANIFESTOS'].AsInteger = 0) then
      Value.FieldByName['PK_TIPO_MANIFESTOS'].AsInteger := GetPKTypeManifest;
    qrTypeManifest.ParamByName('PkTipoManifestos').AsInteger := Value.FieldByName['PK_TIPO_MANIFESTOS'].AsInteger;
    if qrTypeManifest.Params.FindParam('DscTMnf') <> nil then
      qrTypeManifest.ParamByName('DscTMnf').AsString := Value.FieldByName['DSC_TMNF'].AsString;
    if qrTypeManifest.Params.FindParam('FlagTCnh') <> nil then
      qrTypeManifest.ParamByName('FlagTCnh').AsInteger := Value.FieldByName['FLAG_TCNH'].AsInteger;
    if qrTypeManifest.Params.FindParam('FkTipoDocumentos') <> nil then
      qrTypeManifest.ParamByName('FkTipoDocumentos').AsInteger := Value.FieldByName['FK_TIPO_DOCUMENTOS'].AsInteger;
    qrTypeManifest.ExecSQL;
    Dados.CommitTransaction(qrTypeManifest);
  except on E:Exception do
    begin
      if qrTypeManifest.Active then qrTypeManifest.Close;
      Dados.RollbackTransaction(qrTypeManifest);
      raise Exception.Create('SetTypeManifest: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrTypeManifest.SQL.Text);
    end;
  end;
end;

function TdmSysTrans.GetModels(APk: Integer): TDataRow;
begin
  if (qrModel.Active) then qrModel.Close;
  qrModel.SQL.Clear;
  qrModel.SQL.Add(SqlSelectModel);
  Dados.StartTransaction(qrModel);
  try
    qrModel.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
    qrModel.ParamByName('PkVeiculosModelos').AsInteger := APk;
    if (not qrModel.Active) then qrModel.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrModel, True);
  finally
    if (qrModel.Active) then qrModel.Close;
    Dados.CommitTransaction(qrModel);
  end;
end;

procedure TdmSysTrans.SetModels(APk: Integer; const Value: TDataRow);
  function GetPkModel: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlPkGeneratorModel);
    try
      qrSqlAux.ParamByName('FkVeiculosMarcas').AsInteger := FFkMark;
      if not qrSqlAux.Active then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_VEICULOS_MODELOS').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrModel.Active then qrModel.Close;
  qrModel.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrModel.SQL.Add(SqlDeleteModel);
    dbmInsert : qrModel.SQL.Add(SqlInsertModel);
    dbmEdit   : qrModel.SQL.Add(SqlUpdateModel);
  end;
  Dados.StartTransaction(qrModel);
  try
    if (Value.FieldByName['PK_VEICULOS_MODELOS'].AsInteger = 0) then
      Value.FieldByName['PK_VEICULOS_MODELOS'].AsInteger := GetPkModel;
    qrModel.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
    qrModel.ParamByName('PkVeiculosModelos').AsInteger := Value.FieldByName['PK_VEICULOS_MODELOS'].AsInteger;
    if qrModel.Params.FindParam('DscMod') <> nil then
      qrModel.ParamByName('DscMod').AsString := Value.FieldByName['DSC_MOD'].AsString;
    if qrModel.Params.FindParam('AnoFIni') <> nil then
      qrModel.ParamByName('AnoFIni').AsInteger := Value.FieldByName['ANO_FINI'].AsInteger;
    if qrModel.Params.FindParam('AnoFFin') <> nil then
      qrModel.ParamByName('AnoFFin').AsInteger := Value.FieldByName['ANO_FFIN'].AsInteger;
    qrModel.ExecSQL;
    Dados.CommitTransaction(qrModel);
  except on E:Exception do
    begin
      if qrModel.Active then qrModel.Close;
      Dados.RollbackTransaction(qrModel);
      raise Exception.Create('SetModels: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrModel.SQL.Text);
    end;
  end;
end;

function TdmSysTrans.LoadCostCenter: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlCostsCenter);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while (not qrSqlAux.Eof) do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_CCST').AsString,
        TObject(qrSqlAux.FieldByName('PK_CENTRO_CUSTOS').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

function TdmSysTrans.LoadProductGroups: TStrings;
var
  aObj: TClassification;
begin
  Result := TStringList.Create;
  with qrSqlAux do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlSelectGroups);
    Dados.StartTransaction(qrSqlAux);
    try
      if not Active then Open;
      Result.Add('<Nenhum>');
      while not (Eof) do
      begin
        aObj               := TClassification.Create;
        aObj.Pk            := FieldByName('R_PK_PRODUTOS_GRUPOS').AsInteger;
        aObj.FkAccountPlan := FieldByName('R_FK_PRODUTOS_GRUPOS').AsInteger;
        aObj.MaskCta       := FieldByName('R_MASK_CLASS').AsString;
        aObj.DscClass      := FieldByName('R_DSC_PGRU').AsString;
        aObj.NivCta        := FieldByName('R_LEV_CLASS').AsInteger;
        aObj.SeqCta        := FieldByName('R_SEQ_CLASS').AsInteger;
        aObj.FlagAnlSnt    := Boolean(FieldByName('R_FLAG_LAST_LEVEL').AsInteger);
        aObj.cbIndex       := Result.AddObject(InsereSpc(aObj.DscClass, 50) +
                                ' | ' + aObj.MaskCta, aObj);
        Next;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

function TdmSysTrans.LoadUnits: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlUnidades);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    Result.Add('<Nenhum>');
    while not qrSqlAux.Eof do
    begin
      Result.AddObject(qrSqlAux.FieldByName('DSC_UNI').AsString,
        TObject(qrSqlAux.FieldByName('PK_UNIDADES').AsInteger));
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
  end;
end;

function TdmSysTrans.LoadCarriers: TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlCarriers);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        aItem             := TOwner.Create;
        aItem.PkCadastros := qrSqlAux.FindField('PK_CADASTROS').AsInteger;
        aItem.RazSoc      := qrSqlAux.FindField('RAZ_SOC').AsString;
        aItem.FlagTCad    := TTypeOwner(qrSqlAux.FindField('FLAG_TCAD').AsInteger);
        aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysTrans.GetVehicles(APk: Integer): TDataRow;
begin
  if (qrVehicle.Active) then qrVehicle.Close;
  qrVehicle.SQL.Clear;
  qrVehicle.SQL.Add(SqlSelectVehicle);
  Dados.StartTransaction(qrVehicle);
  try
    qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
    qrVehicle.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
    qrVehicle.ParamByName('PkVeiculos').AsInteger        := APk;
    if (not qrVehicle.Active) then qrVehicle.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrVehicle, True);
  finally
    if (qrVehicle.Active) then qrVehicle.Close;
    Dados.CommitTransaction(qrVehicle);
  end;
end;

procedure TdmSysTrans.SetVehicles(APk: Integer; const Value: TDataRow);
var
  aPkAux: Integer;
  function GetPkVehicle: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlPkGeneratorVehicle);
    try
      qrSqlAux.ParamByName('FkVeiculosMarcas').AsInteger := FFkMark;
      qrSqlAux.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
      if not qrSqlAux.Active then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_VEICULOS').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrVehicle.Active then qrVehicle.Close;
  qrVehicle.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrVehicle.SQL.Add(SqlDeleteVehicle);
    dbmInsert : qrVehicle.SQL.Add(SqlInsertVehicle);
    dbmEdit   : qrVehicle.SQL.Add(SqlUpdateVehicle);
  end;
  Dados.StartTransaction(qrVehicle);
  try
    if (Value.FieldByName['PK_VEICULOS'].AsInteger = 0) then
      Value.FieldByName['PK_VEICULOS'].AsInteger := GetPkVehicle;
    qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
    qrVehicle.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
    qrVehicle.ParamByName('PkVeiculos').AsInteger        := Value.FieldByName['PK_VEICULOS'].AsInteger;
    if qrVehicle.Params.FindParam('PlacaVcl') <> nil then
      qrVehicle.ParamByName('PlacaVcl').AsString := Value.FieldByName['PLACA_VCL'].AsString;
    if qrVehicle.Params.FindParam('AnoVcl') <> nil then
      qrVehicle.ParamByName('AnoVcl').AsInteger := Value.FieldByName['ANO_VCL'].AsInteger;
    if qrVehicle.Params.FindParam('CpCdVcl') <> nil then
      qrVehicle.ParamByName('CpCdVcl').AsFloat := Value.FieldByName['CPCD_VCL'].AsFloat;
    qrVehicle.ExecSQL;
    aPkAux := Value.FieldByName['PK_VEICULOS'].AsInteger;
    if (TTypeVehicle(Value.FieldByName['TYPE_VEHICLE'].AsInteger) = tvOwner) then
      dmSysTrans.VehiclesProd[aPkAux] := Value;
    if (TTypeVehicle(Value.FieldByName['TYPE_VEHICLE'].AsInteger) = tvAgregates) then
      dmSysTrans.VehiclesCarrier[aPkAux] := Value;
    Dados.CommitTransaction(qrVehicle);
  except on E:Exception do
    begin
      if qrVehicle.Active then qrVehicle.Close;
      Dados.RollbackTransaction(qrVehicle);
      raise Exception.Create('SetVehicles: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrVehicle.SQL.Text);
    end;
  end;
end;

function TdmSysTrans.GetVehiclesCarrier(APk: Integer): TDataRow;
begin
  if (qrVehicle.Active) then qrVehicle.Close;
  qrVehicle.SQL.Clear;
  qrVehicle.SQL.Add(SqlSelectOwnerVehicle);
  Dados.StartTransaction(qrVehicle);
  try
    qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
    qrVehicle.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
    qrVehicle.ParamByName('FkVeiculos').AsInteger        := APk;
    if (not qrVehicle.Active) then qrVehicle.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrVehicle, True);
  finally
    if (qrVehicle.Active) then qrVehicle.Close;
    Dados.CommitTransaction(qrVehicle);
  end;
end;

function TdmSysTrans.GetVehiclesImg(APk: Integer; AMode: TDBMode): TList;
var
  aItem: PVehicleImage;
  aStrm: TStream;
begin
  Result := TList.Create;
  if (qrVehicle.Active) then qrVehicle.Close;
  qrVehicle.SQL.Clear;
  qrVehicle.SQL.Add(SqlSelectVehicleImage);
  Dados.StartTransaction(qrVehicle);
  try
    qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
    qrVehicle.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
    qrVehicle.ParamByName('FkVeiculos').AsInteger        := APk;
    if (not qrVehicle.Active) then qrVehicle.Open;
    while (not qrVehicle.Eof) do
    begin
      GetMem(aItem, SizeOf(TVehicleImage));
      if (aItem <> nil) then
      begin
        aItem^.State := dbmBrowse;
        if (not qrVehicle.FieldByName('IMG_VCL').IsNull) then
        begin
          aItem^.Name := 'Img-' + InsereZer(qrVehicle.FieldByName('PK_VEICULOS_IMAGENS').AsString, 4);
          aItem^.Pk   := qrVehicle.FieldByName('PK_VEICULOS_IMAGENS').AsInteger;
          aStrm := TMemoryStream.Create;
          try
            TBlobField(qrVehicle.FieldByName('IMG_VCL')).SaveToStream(aStrm);
            case GetTypeImage(aStrm) of
              tiWmf: aItem.Image.Graphic := TMetafile.Create;
              tiBmp: aItem.Image.Graphic := TBitmap.Create;
              tiJpg: aItem.Image.Graphic := TJPEGImage.Create;
            else
              aItem^.Name := 'desconhecida';
            end;
            if (aItem^.Name <> 'desconhecida') then
            begin
              aStrm.Position := 0;
              aItem^.Image.Graphic.LoadFromStream(aStrm);
            end;
          finally
            FreeAndNil(aStrm);
          end;
        end
        else
          aItem^.Name := 'desconhecida';
        Result.Add(aItem);
      end;
    end;
  finally
    if (qrVehicle.Active) then qrVehicle.Close;
    Dados.CommitTransaction(qrVehicle);
  end;
end;

function TdmSysTrans.GetVehiclesObs(APk: Integer; AMode: TDBMode): TStrings;
var
 aStrm: TStream;
begin
  Result := TStringList.Create;
  if (qrVehicle.Active) then qrVehicle.Close;
  qrVehicle.SQL.Clear;
  qrVehicle.SQL.Add(SqlSelectVehicleObs);
  Dados.StartTransaction(qrVehicle);
  try
    qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
    qrVehicle.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
    qrVehicle.ParamByName('FkVeiculos').AsInteger        := APk;
    if (not qrVehicle.Active) then qrVehicle.Open;
    if (not qrVehicle.FieldByName('OBS_VCL').IsNull) then
    begin
      aStrm := TMemoryStream.Create;
      try
        TBlobField(qrVehicle.FieldByName('OBS_VCL')).SaveToStream(aStrm);
        aStrm.Position := 0;
        Result.LoadFromStream(aStrm);
      finally
        FreeAndNil(aStrm);
      end;
    end;
  finally
    if (qrVehicle.Active) then qrVehicle.Close;
    Dados.CommitTransaction(qrVehicle);
  end;
end;

function TdmSysTrans.GetVehiclesProd(APk: Integer): TDataRow;
begin
  if (qrVehicle.Active) then qrVehicle.Close;
  qrVehicle.SQL.Clear;
  qrVehicle.SQL.Add(SqlSelectPropVehicle);
  Dados.StartTransaction(qrVehicle);
  try
    qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
    qrVehicle.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
    qrVehicle.ParamByName('FkVeiculos').AsInteger        := APk;
    if (not qrVehicle.Active) then qrVehicle.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrVehicle, True);
  finally
    if (qrVehicle.Active) then qrVehicle.Close;
    Dados.CommitTransaction(qrVehicle);
  end;
end;

procedure TdmSysTrans.SetVehiclesCarrier(APk: Integer; const Value: TDataRow);
begin
  if qrVehicle.Active then qrVehicle.Close;
  qrVehicle.SQL.Clear;
  case TDBMode(Value.FieldByName['STATUS'].AsInteger) of
    dbmDelete : qrVehicle.SQL.Add(SqlDeleteOwnerVehicle);
    dbmInsert : qrVehicle.SQL.Add(SqlInsertOwnerVehicle);
  end;
  try
    qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
    qrVehicle.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
    qrVehicle.ParamByName('FkVeiculos').AsInteger        := APk;
    if qrVehicle.Params.FindParam('FkCadastros') <> nil then
      qrVehicle.ParamByName('FkCadastros').AsInteger := Value.FieldByName['FK_CADASTROS'].AsInteger;
    qrVehicle.ExecSQL;
  except on E:Exception do
    begin
      if qrVehicle.Active then qrVehicle.Close;
      raise Exception.Create('SetVehiclesCarrier: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrVehicle.SQL.Text);
    end;
  end;
end;

procedure TdmSysTrans.SetVehiclesImg(APk: Integer; AMode: TDBMode; const Value: TList);
var
  i: Integer;
  aStm: TStream;
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  for i := 0 to Value.Count - 1 do
  begin
    if (Value.Items[i] <> nil) then
    begin
      if qrVehicle.Active then qrVehicle.Close;
      qrVehicle.SQL.Clear;
      case AMode of
        dbmDelete : qrVehicle.SQL.Add(SqlDeleteVehicleImage);
        dbmInsert : qrVehicle.SQL.Add(SqlInsertVehicleImage);
        dbmEdit   : qrVehicle.SQL.Add(SqlUpdateVehicleImage);
      end;
      Dados.StartTransaction(qrVehicle);
      try
        qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
        qrVehicle.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
        qrVehicle.ParamByName('FkVeiculos').AsInteger        := APk;
        qrVehicle.ParamByName('PkVeiculosImagens').AsInteger := PVehicleImage(Value.Items[i])^.Pk;
        if (qrVehicle.Params.FindParam('ImgVcl') <> nil) and
           (PVehicleImage(Value.Items[i])^.Image <> nil) then
        begin
          aStm := TMemoryStream.Create;
          try
            PVehicleImage(Value.Items[i])^.Image.Graphic.SaveToStream(aStm);
            qrVehicle.ParamByName('ImgVcl').LoadFromStream(aStm, ftBlob);
          finally
            FreeAndNil(aStm);
          end;
          qrVehicle.ExecSQL;
        end;
        Dados.CommitTransaction(qrVehicle);
      except on E:Exception do
        begin
          if qrVehicle.Active then qrVehicle.Close;
          Dados.RollbackTransaction(qrVehicle);
          raise Exception.Create('SetVehiclesImg: Erro ao gravar ao registro!' + NL +
              E.Message + NL + qrVehicle.SQL.Text);
        end;
      end;
    end;
  end;
end;

procedure TdmSysTrans.SetVehiclesObs(APk: Integer; AMode: TDBMode; const Value: TStrings);
var
  aStm: TStream;
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  if qrVehicle.Active then qrVehicle.Close;
  qrVehicle.SQL.Clear;
  case AMode of
    dbmDelete : qrVehicle.SQL.Add(SqlDeleteVehicleObs);
    dbmInsert : qrVehicle.SQL.Add(SqlInsertVehicleObs);
    dbmEdit   : qrVehicle.SQL.Add(SqlUpdateVehicleObs);
  end;
  Dados.StartTransaction(qrVehicle);
  try
    qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger   := FFkMark;
    qrVehicle.ParamByName('FkVeiculosModelos').AsInteger  := FFkModel;
    qrVehicle.ParamByName('FkVeiculos').AsInteger         := APk;
    if qrVehicle.Params.FindParam('ObsVcl') <> nil then
    begin
      aStm := TMemoryStream.Create;
      try
        Value.SaveToStream(aStm);
        qrVehicle.ParamByName('ObsVcl').LoadFromStream(aStm, ftBlob);
      finally
        FreeAndNil(aStm);
      end;
      qrVehicle.ExecSQL;
    end;
    Dados.CommitTransaction(qrVehicle);
  except on E:Exception do
    begin
      if qrVehicle.Active then qrVehicle.Close;
      Dados.RollbackTransaction(qrVehicle);
      raise Exception.Create('SetVehiclesObs: Erro ao gravar ao registro!' + NL +
          E.Message + NL + qrVehicle.SQL.Text);
    end;
  end;
end;

procedure TdmSysTrans.SetVehiclesProd(APk: Integer; const Value: TDataRow);
  function GetPKProductCode: Integer;
  begin
    Result := 0;
    qrSqlAux.SQL.Clear;
    qrSqlAux.Params.Clear;
    qrSqlAux.SQL.Add(SqlGeneratePkProduct);
    try
      if not qrSqlAux.Active then qrSqlAux.Open;
      if not qrSqlAux.IsEmpty then
        Result := qrSqlAux.FieldByName('PK_PRODUTOS').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrVehicle.Active then qrVehicle.Close;
  qrVehicle.SQL.Clear;
  case TDBMode(Value.FieldByName['STATUS'].AsInteger) of
    dbmDelete : qrVehicle.SQL.Add(SqlDeleteProduct);
    dbmEdit   : qrVehicle.SQL.Add(SqlUpdateProduct);
    dbmInsert : qrVehicle.SQL.Add(SqlInsertProduct);
  end;
  try
    if (TDBMode(Value.FieldByName['STATUS'].AsInteger) = dbmInsert) then
      Value.FieldByName['PK_PRODUTOS'].AsInteger := GetPkProductCode;
    qrVehicle.ParamByName('PkProdutos').AsInteger := Value.FieldByName['PK_PRODUTOS'].AsInteger;
    if qrVehicle.Params.FindParam('DscProd') <> nil then
      qrVehicle.ParamByName('DscProd').AsString := Value.FieldByName['DSC_PROD'].AsString;
    if qrVehicle.Params.FindParam('FkProdutosGrupos') <> nil then
      qrVehicle.ParamByName('FkProdutosGrupos').AsInteger := Value.FieldByName['FK_PRODUTOS_GRUPOS'].AsInteger;
    if qrVehicle.Params.FindParam('FkUnidades') <> nil then
      qrVehicle.ParamByName('FkUnidades').AsInteger := Value.FieldByName['FK_UNIDADES'].AsInteger;
    if qrVehicle.Params.FindParam('FlagAtv') <> nil then
      qrVehicle.ParamByName('FlagAtv').AsInteger := Value.FieldByName['FLAG_ATV'].AsInteger;
    qrVehicle.ExecSQL;
    if (TDBMode(Value.FieldByName['STATUS'].AsInteger) = dbmInsert) then
    begin
      if qrVehicle.Active then qrVehicle.Close;
      qrVehicle.SQL.Clear;
      qrVehicle.SQL.Add(SqlInsertPropVehicle);
      qrVehicle.ParamByName('FkVeiculosMarcas').AsInteger  := FFkMark;
      qrVehicle.ParamByName('FkVeiculosModelos').AsInteger := FFkModel;
      qrVehicle.ParamByName('FkVeiculos').AsInteger        := APk;
      qrVehicle.ParamByName('FkProdutos').AsInteger        := Value.FieldByName['PK_PRODUTOS'].AsInteger;
      qrVehicle.ExecSQL;
    end;
  except on E:Exception do
    begin
      if qrVehicle.Active then qrVehicle.Close;
      raise Exception.Create('SetVehiclesProd: Erro ao gravar ao registro!' + NL +
          E.Message + NL + qrVehicle.SQL.Text);
    end;
  end;
end;

function TdmSysTrans.GetManifestStatus(APk: Integer): TDataRow;
begin
  if (qrManifestStatus.Active) then qrManifestStatus.Close;
  qrManifestStatus.SQL.Clear;
  qrManifestStatus.SQL.Add(SqlManifestStatus);
  try
    qrManifestStatus.ParamByName('PkManifestosStatus').AsInteger := APk;
    if (not qrManifestStatus.Active) then qrManifestStatus.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrManifestStatus, True);
  finally
    if (qrManifestStatus.Active) then qrManifestStatus.Close;
  end;
end;

procedure TdmSysTrans.SetManifestStatus(APk: Integer;
  const Value: TDataRow);
  function GetPKManifestStatus: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkManifestStt);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_MANIFESTOS_STATUS').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrManifestStatus.Active then qrManifestStatus.Close;
  qrManifestStatus.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrManifestStatus.SQL.Add(SqlDeleteManifestStt);
    dbmInsert : qrManifestStatus.SQL.Add(SqlInsertManifestStt);
    dbmEdit   : qrManifestStatus.SQL.Add(SqlUpdateManifestStt);
  end;
  Dados.StartTransaction(qrManifestStatus);
  try
    if (Value.FieldByName['PK_MANIFESTOS_STATUS'].AsInteger = 0) then
      Value.FieldByName['PK_MANIFESTOS_STATUS'].AsInteger := GetPKManifestStatus;
    qrManifestStatus.ParamByName('PkManifestosStatus').AsInteger := Value.FieldByName['PK_MANIFESTOS_STATUS'].AsInteger;
    if qrManifestStatus.Params.FindParam('DscMStt') <> nil then
      qrManifestStatus.ParamByName('DscMStt').AsString := Value.FieldByName['DSC_MSTT'].AsString;
    if qrManifestStatus.Params.FindParam('FlagNivOcc') <> nil then
      qrManifestStatus.ParamByName('FlagNivOcc').AsInteger := Value.FieldByName['FLAG_NIV_OCC'].AsInteger;
    qrManifestStatus.ExecSQL;
    Dados.CommitTransaction(qrManifestStatus);
  except on E:Exception do
    begin
      if qrManifestStatus.Active then qrManifestStatus.Close;
      Dados.RollbackTransaction(qrManifestStatus);
      raise Exception.Create('SetManifestStatus: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrManifestStatus.SQL.Text);
    end;
  end;
end;

function TdmSysTrans.LoadTypeManifest: TStrings;
var
  aItem: TTypeManifest;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeManifests);
  Dados.StartTransaction(qrSqlAux);
  if (not qrSqlAux.Active) then qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        aItem                := TTypeManifest.Create;
        aItem.PkTypeManifest := qrSqlAux.FieldByName('PK_TIPO_MANIFESTOS').AsInteger;
        aItem.FkTypeDocument := qrSqlAux.FieldByName('FK_TIPO_DOCUMENTOS').AsInteger;
        aItem.DscTMnf        := qrSqlAux.FieldByName('DSC_TMNF').AsString;
        aItem.FlagTCnh       := TTypeCarrierDoc(qrSqlAux.FindField('FLAG_TCNH').AsInteger);
        Result.AddObject(aItem.DscTMnf, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysTrans.GetManifest(APk: Integer): TDataRow;
begin
  if (qrManifest.Active) then qrManifest.Close;
  qrManifest.SQL.Clear;
  qrManifest.SQL.Add(SqlManifest);
  Dados.StartTransaction(qrManifest);
  try
    qrManifest.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
    qrManifest.ParamByName('PkManifestos').AsInteger := APk;
    if (not qrManifest.Active) then qrManifest.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrManifest, True);
  finally
    if (qrManifest.Active) then qrManifest.Close;
    Dados.CommitTransaction(qrManifest);
  end;
end;

procedure TdmSysTrans.SetManifest(APk: Integer; const Value: TDataRow);
var
  aStrAux: string;
  function GetPkManifest: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkManifest);
    if not qrSqlAux.Active then qrSqlAux.Open;
    try
      Result := qrSqlAux.FieldByName('PK_MANIFESTOS').asInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrManifest.Active then qrManifest.Close;
  qrManifest.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete : qrManifest.SQL.Add(SqlDeleteManifest);
    dbmInsert : qrManifest.SQL.Add(SqlInsertManifest);
    dbmEdit   : qrManifest.SQL.Add(SqlUpdateManifest);
  end;
  aStrAux := qrManifest.SQL.Text;
  if (Value.FieldByName['FK_AGREGADO'].AsInteger = 0) then
    qrManifest.SQL.Text := StringReplace(aStrAux, ':FkAgregado', 'null', []);
  Dados.StartTransaction(qrManifest);
  try
    if (Value.FieldByName['PK_MANIFESTOS'].AsInteger = 0) then
      Value.FieldByName['PK_MANIFESTOS'].AsInteger := GetPkManifest;
    qrManifest.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
    qrManifest.ParamByName('PkManifestos').AsInteger := Value.FieldByName['PK_MANIFESTOS'].AsInteger;
    if qrManifest.Params.FindParam('FkTipoManifestos') <> nil then
      qrManifest.ParamByName('FkTipoManifestos').AsInteger := Value.FieldByName['FK_TIPO_MANIFESTOS'].AsInteger;
    if qrManifest.Params.FindParam('FkVeiculosMarcas') <> nil then
      qrManifest.ParamByName('FkVeiculosMarcas').AsInteger := Value.FieldByName['FK_VEICULOS_MARCAS'].AsInteger;
    if qrManifest.Params.FindParam('FkVeiculosModelos') <> nil then
      qrManifest.ParamByName('FkVeiculosModelos').AsInteger := Value.FieldByName['FK_VEICULOS_MODELOS'].AsInteger;
    if qrManifest.Params.FindParam('FkVeiculos') <> nil then
      qrManifest.ParamByName('FkVeiculos').AsInteger := Value.FieldByName['FK_VEICULOS'].AsInteger;
    if qrManifest.Params.FindParam('FkFuncionariosMotorista') <> nil then
      qrManifest.ParamByName('FkFuncionariosMotorista').AsInteger := Value.FieldByName['FK_FUNCIONARIOS__MOTORISTA'].AsInteger;
    if qrManifest.Params.FindParam('FkAgregado') <> nil then
      qrManifest.ParamByName('FkAgregado').AsInteger := Value.FieldByName['FK_AGREGADO'].AsInteger;
    if qrManifest.Params.FindParam('FkFuncionariosConferencia') <> nil then
      qrManifest.ParamByName('FkFuncionariosConferencia').AsInteger := Value.FieldByName['FK_FUNCIONARIOS__CONFERENCIA'].AsInteger;
    if qrManifest.Params.FindParam('DtaEmi') <> nil then
      qrManifest.ParamByName('DtaEmi').AsDate := Value.FieldByName['DTA_EMI'].AsDateTime;
    if qrManifest.Params.FindParam('DtaSai') <> nil then
      qrManifest.ParamByName('DtaSai').AsDateTime := Value.FieldByName['DTA_SAI'].AsDateTime;
    if qrManifest.Params.FindParam('FlagTot') <> nil then
      qrManifest.ParamByName('FlagTot').AsInteger := Value.FieldByName['FLAG_TOT'].AsInteger;
    if qrManifest.Params.FindParam('TotCnh') <> nil then
      qrManifest.ParamByName('TotCnh').AsFloat := Value.FieldByName['TOT_CNH'].AsFloat;
    if qrManifest.Params.FindParam('VlrPdg') <> nil then
      qrManifest.ParamByName('VlrPdg').AsFloat := Value.FieldByName['VLR_PDG'].AsFloat;
    if qrManifest.Params.FindParam('VlrMrc') <> nil then
      qrManifest.ParamByName('VlrMrc').AsFloat := Value.FieldByName['VLR_MRC'].AsFloat;
    if qrManifest.Params.FindParam('VlrFrtVst') <> nil then
      qrManifest.ParamByName('VlrFrtVst').AsFloat := Value.FieldByName['VLR_FRT_VST'].AsFloat;
    if qrManifest.Params.FindParam('VlrRemb') <> nil then
      qrManifest.ParamByName('VlrRemb').AsFloat := Value.FieldByName['VLR_REMB'].AsFloat;
    qrManifest.ExecSQL;
    Dados.CommitTransaction(qrManifest);
  except on E:Exception do
    begin
      if qrManifest.Active then qrManifest.Close;
      Dados.RollbackTransaction(qrManifest);
      raise Exception.Create('SetManifestStatus: Erro ao gravar ao registro!' + NL +
            E.Message + NL + qrManifest.SQL.Text);
    end;
  end;
end;

function TdmSysTrans.GetManifestDocs(APk: Integer): TList;
begin
  Result := TList.Create;
  if (qrManifest.Active) then qrManifest.Close;
  qrManifest.SQL.Clear;
  qrManifest.SQL.Add(SqlManifestDocs);
  Dados.StartTransaction(qrManifest);
  try
    qrManifest.ParamByName('FkEmpresas').AsInteger   := Dados.PkCompany;
    qrManifest.ParamByName('FkManifestos').AsInteger := APk;
    if (not qrManifest.Active) then qrManifest.Open;
    while (not qrManifest.Eof) do
      Result.Add(TDataRow.CreateFromDataSet(nil, qrManifest, True));
  finally
    if (qrManifest.Active) then qrManifest.Close;
    Dados.CommitTransaction(qrManifest);
  end;
end;

procedure TdmSysTrans.SetManifestDocs(APk: Integer; const Value: TList);
begin

end;

function TdmSysTrans.LoadEmployees(const AType: TTypeEmployee): TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlEmployees);
  Dados.StartTransaction(qrSqlAux);
  try
    case AType of
      teDriver  : qrSqlAux.ParamByName('FkTipoCargos').AsInteger := FFkOccDriver;
      tePorter  : qrSqlAux.ParamByName('FkTipoCargos').AsInteger := FFkOccPorters;
      teSurveyor: qrSqlAux.ParamByName('FkTipoCargos').AsInteger := FFkOccSurveyors;
    end;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FieldByName('RAZ_SOC').AsString,
          TObject(qrSqlAux.FieldByName('PK_CADASTROS').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysTrans.LoadVehicle(const AMark, AModel: Integer): TList;
var
  aItem: TVehicle;
begin
  Result := TList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlSelectVehicles1);
  qrSqlAux.SQL.Add(SqlSelectVehicles2);
  qrSqlAux.SQL.Add(SqlSelectVehicles3);
  qrSqlAux.SQL.Add(SqlSelectVehicles4);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkVeiculosMarcas').AsInteger := AMark;
    qrSqlAux.ParamByName('FkVeiculosModelos').AsInteger := AModel;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      while not qrSqlAux.Eof do
      begin
        aItem          := TVehicle.Create;
        aItem.CpCdVcl  := qrSqlAux.FieldByName('CPCD_VCL').AsFloat;
        aItem.DscMark  := qrSqlAux.FieldByName('DSC_MRC').AsString;
        aItem.DscModel := qrSqlAux.FieldByName('DSC_MOD').AsString;
        aItem.DscTVcl  := qrSqlAux.FieldByName('DSC_TVEI').AsString;
        aItem.DscVcl   := qrSqlAux.FieldByName('DSC_VEI').AsString;
        aItem.FkMark   := qrSqlAux.FieldByName('PK_VEICULOS_MARCAS').AsInteger;
        aItem.FkModel  := qrSqlAux.FieldByName('PK_VEICULOS_MODELOS').AsInteger;
        aItem.FkOwner  := qrSqlAux.FieldByName('PK_OWNER').AsInteger;
        aItem.FlagTOwn := TTypeVehicle(qrSqlAux.FieldByName('PK_TYPE_VEHICLE').AsInteger);
        aItem.Pk       := qrSqlAux.FieldByName('PK_VEICULOS').AsInteger;
        aItem.PlcVcl   := qrSqlAux.FieldByName('PLACA_VCL').AsString;
        aItem.YearVcl  := qrSqlAux.FieldByName('ANO_VCL').AsInteger;
        Result.Add(aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysTrans.LoadVehicleMarks: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlSelectMarks);
  Dados.StartTransaction(qrSqlAux);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FieldByName('DSC_MRC').AsString,
          TObject(qrSqlAux.FieldByName('PK_VEICULOS_MARCAS').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysTrans.LoadVehicleModel(const AMark: Integer): TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlSelectModels);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.ParamByName('FkVeiculosMarcas').AsInteger := AMark;
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FieldByName('DSC_MOD').AsString,
          TObject(qrSqlAux.FieldByName('PK_VEICULOS_MODELOS').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

initialization
  Application.CreateForm(TdmSysTrans, dmSysTrans);
finalization
  if Assigned(dmSysTrans) then dmSysTrans.Free;
  dmSysTrans := nil;

end.
