unit mSysEstq;

{*************************************************************************}
{*                                                                       *}
{* Author: CSD Informatica Ltda.                                         *}
{* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses SysUtils, Classes, ProcType, Forms, Windows, FMTBcd, SqlExpr, DB, TSysEstq,
     TSysEstqAux, Graphics, ProcUtils, TSysConfAux, Dialogs, TSysCad, Controls,
     GridRow, TSysFatAux;

type
  TGroups = record
    Group   : TClassification;
    DsctProd: Double;
    MrgmRef : Double;
    ComSGru : Double;
    CodGRef : string;
    SeqRef  : Integer;
  end;

  TdmSysEstq = class(TDataModule)
    qrSimilar: TSQLQuery;
    qrLinha: TSQLQuery;
    qrUnit: TSQLQuery;
    ProdutoPreco: TSQLQuery;
    qrTypeComp: TSQLQuery;
    qrAlmox: TSQLQuery;
    qrGroup: TSQLQuery;
    qrProduct: TSQLQuery;
    qrProductCode: TSQLQuery;
    qrTypeDsct: TSQLQuery;
    ProdutoVnd: TSQLQuery;
    Linguagens: TSQLQuery;
    ProdDscLang: TSQLQuery;
    qrTableFraction: TSQLQuery;
    qrTypeFraction: TSQLQuery;
    qrFractions: TSQLQuery;
    ProdutoImg: TSQLQuery;
    ProdImposto: TSQLQuery;
    qrSupplier: TSQLQuery;
    OrigensTrib: TSQLQuery;
    SitTribs: TSQLQuery;
    ProdPurchase: TSQLQuery;
    TipoReferencia: TSQLQuery;
    qrProdMargem: TSQLQuery;
    ProdPatrim: TSQLQuery;
    qrTableRegion: TSQLQuery;
    qrProdSrv: TSQLQuery;
    TipoAcabm: TSQLQuery;
    TSitEstq: TSQLQuery;
    qrTipoProd: TSQLQuery;
    ProdCostHist: TSQLQuery;
    ProdHistoric: TSQLQuery;
    qrProdCusto: TSQLQuery;
    qrTipoMovim: TSQLQuery;
    qrRequisicao: TSQLQuery;
    qrReqItems: TSQLQuery;
    qrGrpAcc: TSQLQuery;
    qrTSitProd: TSQLQuery;
    qrFuncionarios: TSQLQuery;
    qrAlmoxarifados: TSQLQuery;
    qrLotacao: TSQLQuery;
    qrProdAlmx: TSQLQuery;
    qrMovimEstq: TSQLQuery;
    qrSqlAux: TSQLQuery;
    qrTabPrice: TSQLQuery;
    qrProdCarrier: TSQLQuery;
    ProdSupp: TSQLQuery;
    qrSubGroup: TSQLQuery;
    qrParamEstq: TSQLQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FFkTablePrice  : Integer;
    FFkTypeFraction: Integer;
    FFkTableRegion : Integer;
    { Private declarations }
    function  GetSimilar(APk: Integer): TDataRow;
    function  GetTypeSitSupply(APk: Integer): TDataRow;
    function  GetTypeProduct(APk: Integer): TDataRow;
    function  GetUnits(APk: Integer): TUnit;
    function  GetParamEstq(APk: Integer): TDataRow;
    function  GetGroups(APk: Integer): TGroups;
    function  GetAccounts(APk: Integer): TDataRow;
    function  GetPriceTable(APk: Integer): TPriceTable;
    function  GetTypeFraction(APk: Integer): TDataRow;
    function  GetTableRegion(APk: Integer): TDataRow;
    function  GetFractions(APk: Integer): TList;
    procedure SetTableRegion(APk: Integer; const Value: TDataRow);
    procedure SetParamEstq(APk: Integer; const Value: TDataRow);
    procedure SetUnits(APk: Integer; const Value: TUnit);
    procedure SetTypeProduct(APk: Integer; const Value: TDataRow);
    procedure SetTypeSitSupply(APk: Integer; const Value: TDataRow);
    procedure SetSimilar(APk: Integer; const Value: TDataRow);
    procedure SetGroups(APk: Integer; const Value: TGroups);
    procedure SetGroup(APk: Integer; const Value: TClassification);
    procedure SetAccounts(APk: Integer; const Value: TDataRow);
    procedure SetPriceTable(APk: Integer; const Value: TPriceTable);
    procedure SetTypeFraction(APk: Integer; const Value: TDataRow);
    procedure SetFractions(APk: Integer; const Value: TList);
    function  GetProductService(APk: Integer): TProductService;
    procedure SetProductService(APk: Integer;
      const Value: TProductService);
    function  GetProductComps(APk: Integer): TList;
    procedure SetProductComps(APk: Integer; const Value: TList);
    function  GetProductCarrier(APk: Integer): TProductCarrier;
    procedure SetProductCarrier(APk: Integer;
      const Value: TProductCarrier);
    function GetTableFraction(APk: Integer): TDataRow;
    procedure SetTableFraction(APk: Integer; const Value: TDataRow);
  public
    { Public declarations }
    function  GetAlmox(const Pk: Integer): TDataRow;
    function  GetLotacao(const FkAlmox, Pk: Integer): TDataRow;
    function  SaveLine(const AItem: TLines; AState: TDBMode): Integer;
    function  GetLine(const APk: Integer): TLines;
    function  GetProductPrices(APkPrd: Integer): TList;
    function  ExistProductCosts(APk: Integer): Boolean;
    function  GetProductCosts(APk: Integer): TProductCost;
    function  GetProductSale(APk: Integer): TProductSale;
    function  GetProductPurchase(APk: Integer): TProductPurchase;
    function  GetProductSuppliers(APk: Integer): TProductSuppliers;
    function  GetProduct(APk: Integer): TProducts;
    function  GetProductCodes(AFk: Integer): TProductCodes;
    function  GetNewProductReference(const AProductGroup: Integer): string;
    function  GetTypeMovement(aPk: Integer): TTypeMoviment;
    function  LoadAlmox: TStrings;
    function  LoadTypeMovement(const AFlagTMov: Integer): TStrings;
    function  LoadPriceTable(AddNone: Boolean = True; All: Boolean = False): TStrings;
    function  LoadSitTrib: TStrings;
    function  LoadOrigimTrib: TStrings;
    function  LoadNatureOper: TStrings;
    function  LoadClassFisc: TStrings;
    function  LoadDeliveryPeriod: TStrings;
    function  LoadFinanceAccounts(AAccountNat: Integer): TStrings;
    function  LoadProductGroups: TStrings;
    function  LoadInsumos(AType: TTypeInsumos): TStrings;
    function  LoadTypeFinishes: TStrings;
    function  LoadTypeReferences(AFinishType: TFinishType): TStrings;
    function  LoadSimilar(AddNone: Boolean = True): TStrings;
    function  LoadLinhas(AddNone: Boolean = True): TStrings;
    function  LoadDscTableRegion(APk: Integer): TDataRow;
    function  LoadTypeDocs: TStrings;
    function  LoadUnits(AddNone: Boolean = True): TStrings;
    function  LoadProductImage(APk: Integer; var APkFound: Integer): TPicture;
    function  LoadProductDescription(APk: Integer; var APkFound: Integer): TStrings;
    function  LoadSuppliers: TStrings;
    function  LoadTypeDiscounts: TStrings;
    function  LoadRegions: TStrings;
    function  LoadTypeFractions: TStrings;
    function  LoadTableRegions: TStrings;
    function  UpdateProduct(var APrd: TProducts; AMode: TDBMode): Boolean;
    procedure SaveAlmox(var ARow: TDataRow; AState: TDBMode);
    procedure SaveLotacao(var ARow: TDataRow; AState: TDBMode);
    procedure DeleteProductSupplier(const AFkEmpr, APkPrd, AFkSupp: Integer);
    procedure DeleteProductMargim(const APkEmpr, APkPrd: Integer);
    procedure DeleteProduct(APrd: Integer);
    procedure DeleteProductCode(const APkPrd, APkCode: Integer);
    procedure UpdateProductPrice(const APkPrd: Integer;
                APrdPrice: TProductPrice; AMode: TDBMode);
    procedure UpdateProductPurchase(const APkPrd: Integer;
                APrdPurchase: TProductPurchase; AMode: TDBMode);
    procedure UpdateProductCost(const APkPrd: Integer;
                APrdCost: TProductCost);
    procedure UpdateProductMargin(const APkPrd: Integer;
                APrdPrice: TProductPrices; AMode: TDBMode);
    procedure UpdateProductSale(const APkPrd: Integer; APrdSale: TProductSale;
                AMode: TDBMode);
    procedure UpdateProductCode(const APkPrd: Integer; APrdCode: TProductCode;
                AMode: TDBMode);
    procedure UpdateProductImage(APk: Integer; APicture: TGraphic; AState: TDBMode);
    procedure UpdateProductObs(APk: Integer; ALines: TStrings; AState: TDBMode);
    procedure UpdateProductSuppliers(const APkPrd, AOldSupp: Integer;
                APrdSupplier: TProductSupplier; AMode: TDBMode);
    procedure SaveTypeMov(var AItem: TTypeMoviment; const AState: TDBMode);
    procedure SetTipoProdNatOper(var AData: TDataRow);
    property  Similar       [APk: Integer]: TDataRow        read GetSimilar         write SetSimilar;
    property  TypeSitSupply [APk: Integer]: TDataRow        read GetTypeSitSupply   write SetTypeSitSupply;
    property  TypeProduct   [APk: Integer]: TDataRow        read GetTypeProduct     write SetTypeProduct;
    property  Units         [APk: Integer]: TUnit           read GetUnits           write SetUnits;
    property  ParamEstq     [APk: Integer]: TDataRow        read GetParamEstq       write SetParamEstq;
    property  Groups        [APk: Integer]: TGroups         read GetGroups          write SetGroups;
    property  Group         [APk: Integer]: TClassification                         write SetGroup;
    property  Accounts      [APk: Integer]: TDataRow        read GetAccounts        write SetAccounts;
    property  TablePrice    [APk: Integer]: TPriceTable     read GetPriceTable      write SetPriceTable;
    property  TypeFraction  [APk: Integer]: TDataRow        read GetTypeFraction    write SetTypeFraction;
    property  TableFraction [APk: Integer]: TDataRow        read GetTableFraction   write SetTableFraction;
    property  TableRegion   [APk: Integer]: TDataRow        read GetTableRegion     write SetTableRegion;
    property  Fractions     [APk: Integer]: TList           read GetFractions       write SetFractions;
    property  ProductSrv    [APk: Integer]: TProductService read GetProductService  write SetProductService;
    property  ProductComps  [APk: Integer]: TList           read GetProductComps    write SetProductComps;
    property  ProductCarrier[APk: Integer]: TProductCarrier read GetProductCarrier  write SetProductCarrier;
    property  FkTablePrice                : Integer         read FFkTablePrice      write FFkTablePrice;
    property  FkTypeFraction              : Integer         read FFkTypeFraction    write FFkTypeFraction;
    property  FkTableRegion               : Integer         read FFkTableRegion     write FFkTableRegion;
  end;

var
  dmSysEstq: TdmSysEstq;

implementation

uses Dado, CmmConst, Funcoes, EstqArqSql, FuncoesDB, TSysCtbAux, TypInfo,
  TSysPedAux, TSysMan, SqlComm;

{$R *.dfm}

procedure TdmSysEstq.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i].InheritsFrom(TDataSet)) and
       (GetProperty(Components[i], 'SqlConnection')) then
      SetObjectProp(Components[i], 'SqlConnection', Dados.Conexao);
end;

procedure TdmSysEstq.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i].InheritsFrom(TDataSet)) and
       (TDataSet(Components[i]).Active)       then
      TDataSet(Components[i]).Close;
  end;
end;

function  TdmSysEstq.GetAlmox(const Pk: Integer): TDataRow;
begin
  if qrAlmox.Active then qrAlmox.Close;
  qrAlmox.SQL.Clear;
  qrAlmox.SQL.Add(SqlAlmoxarifado);
  Dados.StartTransaction(qrAlmox);
  try
    qrAlmox.ParamByName('PkAlmoxarifados').AsInteger := Pk;
    if (not qrAlmox.Active) then qrAlmox.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrAlmox, True);
  finally
    if qrAlmox.Active then qrAlmox.Close;
    Dados.CommitTransaction(qrAlmox);
  end;
end;

procedure TdmSysEstq.SaveAlmox(var ARow: TDataRow; AState: TDBMode);
var
  i: Integer;
  S: TStrings;
  W: TStrings;
  M: TStream;
  function GetPkAlmox: integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkAlmox);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_ALMOXARIFADOS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  S := TStringList.Create;
  W := TStringList.Create;
  try
    if (AState = dbmInsert) then
      ARow.FieldByName['PK_ALMOXARIFADOS'].AsInteger := 1;
    for i := 0 to ARow.Count - 1 do
    begin
      if (not ARow.Fields[i].IsNull) or ((ARow.Fields[i].IsBlob) and
         (ARow.Fields[i].DataSize > 0)) then
        S.Add(ARow.Fields[i].FieldName);
    end;
    if qrAlmox.Active then qrAlmox.Close;
    qrAlmox.SQL.Clear;
    W.Add('PK_ALMOXARIFADOS');
    case AState of
      dbmDelete: qrAlmox.SQL.Add(SqlDeleteAlmox);
      dbmEdit  : qrAlmox.SQL.AddStrings(GetUpdateSQL(S, W, 'ALMOXARIFADOS'));
      dbmInsert: qrAlmox.SQL.AddStrings(GetInsertSQL(S, 'ALMOXARIFADOS'));
    end;
  finally
    FreeAndNil(W);
    FreeAndNil(S);
  end;
  Dados.StartTransaction(qrAlmox);
  try
    if (AState = dbmInsert) then
      ARow.FieldByName['PK_ALMOXARIFADOS'].AsInteger := GetPkAlmox;
    qrAlmox.ParamByName('PkAlmoxarifados').AsInteger := ARow.FieldByName['PK_ALMOXARIFADOS'].AsInteger;
    if (qrAlmox.Params.FindParam('OldPkAlmoxarifados') <> nil) then
      qrAlmox.ParamByName('OldPkAlmoxarifados').AsInteger  := ARow.FieldByName['PK_ALMOXARIFADOS'].AsInteger;
    if (qrAlmox.Params.FindParam('DscAlmx') <> nil) then
      qrAlmox.ParamByName('DscAlmx').AsString         := ARow.FieldByName['DSC_ALMX'].AsString;
    if (qrAlmox.Params.FindParam('LocalAmlx') <> nil) then
    begin
      M := TMemoryStream.Create;
      try
        ARow.FieldByName['LOCAL_AMLX'].SaveToStream(M, buValue);
        M.Position := 0;
        qrAlmox.ParamByName('LocalAmlx').LoadFromStream(M, ftBlob);
      finally
        FreeAndNil(M);
      end;
    end;
    if (qrAlmox.Params.FindParam('OpeInc') <> nil) then
      qrAlmox.ParamByName('OpeInc').AsString   := ARow.FieldByName['OPE_INC'].AsString;
    if (qrAlmox.Params.FindParam('DtHrInc') <> nil) then
      qrAlmox.ParamByName('DtHrInc').AsDateTime := ARow.FieldByName['DTHR_INC'].AsDateTime;
    if (qrAlmox.Params.FindParam('OpeAlt') <> nil) then
      qrAlmox.ParamByName('OpeAlt').AsString    := ARow.FieldByName['OPE_ALT'].AsString;
    if (qrAlmox.Params.FindParam('DtHrAlt') <> nil) then
      qrAlmox.ParamByName('DtHrAlt').AsDateTime := ARow.FieldByName['DTHR_ALT'].AsDateTime;
    qrAlmox.ExecSQL;
    if qrAlmox.Active then qrAlmox.Close;
    Dados.CommitTransaction(qrAlmox);
  except on E:Exception do
    begin
      if qrAlmox.Active then qrAlmox.Close;
      Dados.RollbackTransaction(qrAlmox);
      raise Exception.Create('SaveAlmox: Erro ao salvar o registro!' + NL +
        E.Message);
    end;
  end;
end;

function  TdmSysEstq.GetLotacao(const FkAlmox, Pk: Integer): TDataRow;
begin
  if qrLotacao.Active then qrLotacao.Close;
  qrLotacao.SQL.Clear;
  qrLotacao.SQL.Add(SqlLotacao);
  Dados.StartTransaction(qrLotacao);
  try
    qrLotacao.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
    qrLotacao.ParamByName('FkAlmoxarifados').AsInteger := FkAlmox;
    qrLotacao.ParamByName('PkLotacoes').AsInteger      := Pk;
    if (not qrLotacao.Active) then qrLotacao.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrLotacao, True);
  finally
    if qrLotacao.Active then qrLotacao.Close;
    Dados.CommitTransaction(qrLotacao);
  end;
end;

procedure TdmSysEstq.SaveLotacao(var ARow: TDataRow; AState: TDBMode);
  function GetPkLotacao: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkLotacao);
    try
      qrSqlAux.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
      qrSqlAux.ParamByName('FkAlmoxarifados').AsInteger := ARow.FieldByName['FK_ALMOXARIFADOS'].AsInteger;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_LOTACOES').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if qrLotacao.Active then qrLotacao.Close;
  qrLotacao.SQL.Clear;
  case AState of
    dbmDelete: qrLotacao.SQL.Add(SqlDeleteLotacao);
    dbmEdit  : qrLotacao.SQL.Add(SqlUpdateLotacao);
    dbmInsert: qrLotacao.SQL.Add(SqlInsertLotacao);
  end;
  Dados.StartTransaction(qrLotacao);
  try
    if (AState = dbmInsert) then
      ARow.FieldByName['PK_LOTACOES'].AsInteger        := GetPkLotacao;
    qrLotacao.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
    qrLotacao.ParamByName('FkAlmoxarifados').AsInteger := ARow.FieldByName['FK_ALMOXARIFADOS'].AsInteger;
    qrLotacao.ParamByName('PkLotacoes').AsInteger      := ARow.FieldByName['PK_LOTACOES'].AsInteger;
    if (qrLotacao.Params.FindParam('RuaLot') <> nil) then
      qrLotacao.ParamByName('RuaLot').AsString   := InsereZer(ARow.FieldByName['RUA_LOT'].AsString, 2);
    if (qrLotacao.Params.FindParam('NivelLot') <> nil) then
      qrLotacao.ParamByName('NivelLot').AsString := InsereZer(ARow.FieldByName['NIVEL_LOT'].AsString, 2);
    if (qrLotacao.Params.FindParam('BoxLot') <> nil) then
      qrLotacao.ParamByName('BoxLot').AsString   := ARow.FieldByName['BOX_LOT'].AsString;
    qrLotacao.ExecSQL;
    if qrLotacao.Active then qrLotacao.Close;
    Dados.CommitTransaction(qrLotacao);
  except on E:Exception do
    begin
      if qrLotacao.Active then qrLotacao.Close;
      Dados.RollbackTransaction(qrLotacao);
      raise Exception.Create('SaveLotacao: Erro ao salvar o registro!' + NL +
        E.Message);
    end;
  end;
end;

procedure TdmSysEstq.DeleteProductSupplier(const AFkEmpr, APkPrd, AFkSupp: Integer);
begin
  if (AFkEmpr <= 0) or (APkPrd <= 0) or (AFkSupp <= 0) then exit;
  if ProdSupp.Active then ProdSupp.Close;
  ProdSupp.SQL.Clear;
  ProdSupp.SQL.Add(SqlDeletePrdSupplier);
  Dados.StartTransaction(ProdSupp);
  try
    ProdSupp.ParamByName('FkEmpresas').AsInteger        := AFkEmpr;
    ProdSupp.ParamByName('FkProdutos').AsInteger        := APkPrd;
    ProdSupp.ParamByName('FkVwForncecedores').AsInteger := AFkSupp;
    ProdSupp.ExecSQL;
    Dados.CommitTransaction(ProdSupp);
  except on E:Exception do
    begin
      if ProdSupp.Active then ProdSupp.Close;
      Dados.RollbackTransaction(ProdSupp);
      raise Exception.Create('DeleteProductSupplier: ' + E.Message + NL +
        ProdSupp.SQL.Text);
    end;
  end;
end;

procedure TdmSysEstq.DeleteProductMargim(const APkEmpr, APkPrd: Integer);
begin
  if (APkEmpr <= 0) or (APkPrd <= 0) then exit;
  if ProdutoPreco.Active then ProdutoPreco.Close;
  ProdutoPreco.SQL.Clear;
  ProdutoPreco.SQL.Add(SqlDeletePrdMargim);
  Dados.StartTransaction(ProdutoPreco);
  try
    ProdutoPreco.ParamByName('FkEmpresas').AsInteger := APkEmpr;
    ProdutoPreco.ParamByName('FkProdutos').AsInteger := APkPrd;
    ProdutoPreco.ExecSQL;
    Dados.CommitTransaction(ProdutoPreco);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(ProdutoPreco);
      raise Exception.Create('DeleteProductMargim: ' + E.Message + NL +
        ProdutoPreco.SQL.Text);
    end;
  end;
end;

procedure TdmSysEstq.UpdateProductPrice(const APkPrd: Integer;
  APrdPrice: TProductPrice; AMode: TDBMode);
begin
  if (APkPrd <= 0) or (APrdPrice = nil) or
     (not (AMode in UPDATE_MODE)) then exit;
  if ProdutoPreco.Active then ProdutoPreco.Close;
  ProdutoPreco.SQL.Clear;
  if AMode = dbmInsert then
    ProdutoPreco.SQL.Add(SqlInsertPrdPrices)
  else
    ProdutoPreco.SQL.Add(SqlUpdatePrdPrices);
  try
    ProdutoPreco.ParamByName('FkEmpresas').AsInteger := APrdPrice.FkCompany.PkCompany;
    ProdutoPreco.ParamByName('FkProdutos').AsInteger := APkPrd;
    if ProdutoPreco.Params.FindParam('FkTabelaPrecos') <> nil then
      ProdutoPreco.ParamByName('FkTabelaPrecos').AsInteger := APrdPrice.FkPriceTable.PkPriceTable;
    if ProdutoPreco.Params.FindParam('FlagFix') <> nil then
      ProdutoPreco.ParamByName('FlagFix').AsInteger := Integer(APrdPrice.FlagFix);
    if ProdutoPreco.Params.FindParam('PreVda') <> nil then
      ProdutoPreco.ParamByName('PreVda').AsFloat := APrdPrice.PreVda;
    ProdutoPreco.ExecSQL;
  except on E:Exception do
      raise Exception.Create('UpdateProductPrice: ' + E.Message + NL +
        ProdutoPreco.SQL.Text);
  end;
end;

procedure TdmSysEstq.UpdateProductMargin(const APkPrd: Integer;
  APrdPrice: TProductPrices; AMode: TDBMode);
var
  aPk: TStrings;
begin
  if (APkPrd <= 0) or (APrdPrice = nil) or
     (not (AMode in UPDATE_MODE)) then exit;
  if ProdutoPreco.Active then ProdutoPreco.Close;
  ProdutoPreco.SQL.Clear;
  if AMode = dbmInsert then
    ProdutoPreco.SQL.AddStrings(GetInsertSQL(APrdPrice.GetFields, 'PRODUTOS_MARGEM'));
  if AMode = dbmEdit then
  begin
    aPk := TStringList.Create;
    try
      aPk.Add('FK_EMPRESAS');
      aPk.Add('FK_PRODUTOS');
      ProdutoPreco.SQL.AddStrings(GetUpdateSQL(APrdPrice.GetFields, aPk, 'PRODUTOS_MARGEM'));
    finally
      aPk.Free;
    end;
  end;
  try
    ProdutoPreco.ParamByName('FkEmpresas').AsInteger              := APrdPrice.FkCompany.PkCompany;
    ProdutoPreco.ParamByName('FkProdutos').AsInteger              := APkPrd;
    if (ProdutoPreco.Params.FindParam('OldFkEmpresas') <> nil) then
      ProdutoPreco.ParamByName('OldFkEmpresas').AsInteger         := APrdPrice.FkCompany.PkCompany;
    if (ProdutoPreco.Params.FindParam('OldFkProdutos') <> nil) then
      ProdutoPreco.ParamByName('OldFkProdutos').AsInteger         := APkPrd;
    if (ProdutoPreco.Params.FindParam('SitTrib') <> nil) then
      ProdutoPreco.ParamByName('SitTrib').AsString                := APrdPrice.SitTrb;
    if (ProdutoPreco.Params.FindParam('MrgLcr') <> nil) then
      ProdutoPreco.ParamByName('MrgLcr').AsFloat                  := APrdPrice.MrgLcr;
    if (ProdutoPreco.Params.FindParam('FkSituacaoTributarias') <> nil) then
      ProdutoPreco.ParamByName('FkSituacaoTributarias').AsInteger := APrdPrice.FkSitTrib.PkSituacaoTributaria;
    if (ProdutoPreco.Params.FindParam('FkOrigensTributarias') <> nil) then
      ProdutoPreco.ParamByName('FkOrigensTributarias').AsInteger  := APrdPrice.FkOrigimTrib.PkOrigensTributarias;
    if ProdutoPreco.Params.FindParam('FkClassificacaoFiscal') <> nil then
      ProdutoPreco.ParamByName('FkClassificacaoFiscal').AsString  := APrdPrice.FkClassFisc.PkClassificacaoFiscal;
    ProdutoPreco.ExecSQL;
  except on E:Exception do
    begin
      raise Exception.Create('UpdateProductMargin: ' + E.Message + NL +
        ProdutoPreco.SQL.Text);
    end;
  end;
end;

procedure TdmSysEstq.UpdateProductPurchase(const APkPrd: Integer;
            APrdPurchase: TProductPurchase; AMode: TDBMode);
begin
  if (APkPrd <= 0) or (APrdPurchase = nil) or
     (not (AMode in UPDATE_MODE)) then exit;
  if ProdPurchase.Active then ProdPurchase.Close;
  ProdPurchase.SQL.Clear;
  if AMode = dbmInsert then
    ProdPurchase.SQL.Add(SqlInsProdPurchase)
  else
    ProdPurchase.SQL.Add(SqlUpdProdPurchase);
  try
    ProdPurchase.ParamByName('FkProdutos').AsInteger := APkPrd;
    if ProdPurchase.Params.FindParam('VlrUnit') <> nil then
      ProdPurchase.ParamByName('VlrUnit').AsFloat := APrdPurchase.VlrUnit;
    if ProdPurchase.Params.FindParam('FlagCmpr') <> nil then
      ProdPurchase.ParamByName('FlagCmpr').AsInteger := Integer(APrdPurchase.FlagCmpr);
    if ProdPurchase.Params.FindParam('FlagEmp') <> nil then
      ProdPurchase.ParamByName('FlagEmp').AsInteger := Integer(APrdPurchase.FlagEmp);
    if ProdPurchase.Params.FindParam('FlagTMat') <> nil then
      ProdPurchase.ParamByName('FlagTMat').AsInteger := Integer(APrdPurchase.FlagTMat);
    if ProdPurchase.Params.FindParam('FkTipoAcabamentos') <> nil then
      if APrdPurchase.FkReferenceType.FkFinishType.PkFinishType > 0 then
        ProdPurchase.ParamByName('FkTipoAcabamentos').AsInteger :=
          APrdPurchase.FkReferenceType.FkFinishType.PkFinishType
      else
        ProdPurchase.Params.Delete(ProdPurchase.ParamByName('FkTipoAcabamentos').Index);
    if ProdPurchase.Params.FindParam('FkTipoReferencias') <> nil then
      if APrdPurchase.FkReferenceType.PkReferenceType > 0 then
        ProdPurchase.ParamByName('FkTipoReferencias').AsInteger :=
          APrdPurchase.FkReferenceType.PkReferenceType
      else
        ProdPurchase.Params.Delete(ProdPurchase.ParamByName('FkTipoReferencias').Index);
    ProdPurchase.ExecSQL;
  except on E:Exception do
    raise Exception.Create('UpdateProductPurchase: ' + E.Message + NL +
      ProdPurchase.SQL.Text);
  end;
end;

procedure TdmSysEstq.UpdateProductCost(const APkPrd: Integer;
  APrdCost: TProductCost);
var
  aState: TDBMode;
begin
  if ExistProductCosts(APkPrd) then
    aState := dbmEdit
  else
    aState := dbmInsert;
  if (APkPrd <= 0) or (APrdCost = nil) then exit;
  if qrProdCusto.Active then qrProdCusto.Close;
  qrProdCusto.SQL.Clear;
  if aState = dbmInsert then
    qrProdCusto.SQL.Add(SqlInsertPrdCost)
  else
    qrProdCusto.SQL.Add(SqlUpdatePrdCost);
  try
    qrProdCusto.ParamByName('FkProdutos').AsInteger := APkPrd;
    qrProdCusto.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    if qrProdCusto.Params.FindParam('CustFinal') <> nil then
      qrProdCusto.ParamByName('CustFinal').AsFloat := APrdCost.CustFinal;
    if qrProdCusto.Params.FindParam('CustRjst') <> nil then
      qrProdCusto.ParamByName('CustRjst').AsFloat := APrdCost.CustRjst;
    if qrProdCusto.Params.FindParam('QtdDiasRep') <> nil then
      qrProdCusto.ParamByName('QtdDiasRep').AsInteger := APrdCost.QtdDiasRep;
    if qrProdCusto.Params.FindParam('QtdDiasEntr') <> nil then
      qrProdCusto.ParamByName('QtdDiasEntr').AsInteger := APrdCost.QtdDiasEntr;
    if qrProdCusto.Params.FindParam('FlagRjst') <> nil then
      qrProdCusto.ParamByName('FlagRjst').AsInteger := Integer(APrdCost.FlagRjst);
    if qrProdCusto.Params.FindParam('QtdEMin') <> nil then
      qrProdCusto.ParamByName('QtdEMin').AsFloat := APrdCost.QtdEMin;
    if qrProdCusto.Params.FindParam('QtdEMax') <> nil then
      qrProdCusto.ParamByName('QtdEMax').AsFloat := APrdCost.QtdEMax;
    if qrProdCusto.Params.FindParam('DtaUCmp') <> nil then
      qrProdCusto.ParamByName('DtaUCmp').AsDate := APrdCost.DtaUCmp;
    if qrProdCusto.Params.FindParam('DtaUMov') <> nil then
      qrProdCusto.ParamByName('DtaUMov').AsDate := APrdCost.DtaUMov;
    if qrProdCusto.Params.FindParam('DtaPrvEntrCompra') <> nil then
      qrProdCusto.ParamByName('DtaPrvEntrCompra').AsDateTime := APrdCost.DtaPrvEntrCompra;
    qrProdCusto.ExecSQL;
  except on E:Exception do
    raise Exception.Create('UpdateProductCost: ' + E.Message +
      qrProdCusto.SQL.Text);
  end;
end;

function  TdmSysEstq.ExistProductCosts(APk: Integer): Boolean;
begin
  if qrProdCusto.Active then qrProdCusto.Close;
  qrProdCusto.SQL.Clear;
  qrProdCusto.SQL.Add(SqlProductCustos);
  try
    if qrProdCusto.Params.FindParam('FkProdutos') <> nil then
      qrProdCusto.Params.FindParam('FkProdutos').AsInteger := APk;
    if qrProdCusto.Params.FindParam('FkEmpresas') <> nil then
      qrProdCusto.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
    if not qrProdCusto.Active then qrProdCusto.Open;
    Result := (not qrProdCusto.IsEmpty);
  finally
    if qrProdCusto.Active then qrProdCusto.Close;
  end;
end;

function  TdmSysEstq.GetProductCosts(APk: Integer): TProductCost;
begin
  Result := TProductCost.Create;
  if qrProdCusto.Active then qrProdCusto.Close;
  qrProdCusto.SQL.Clear;
  qrProdCusto.SQL.Add(SqlProductCustos);
  Dados.StartTransaction(qrProdCusto);
  try
    if qrProdCusto.Params.FindParam('FkProdutos') <> nil then
      qrProdCusto.Params.FindParam('FkProdutos').AsInteger := APk;
    if qrProdCusto.Params.FindParam('FkEmpresas') <> nil then
      qrProdCusto.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
    if not qrProdCusto.Active then qrProdCusto.Open;
    with Result do
    begin
      CustFinal   := qrProdCusto.FieldByName('CUST_FINAL').AsFloat;
      CustForn    := qrProdCusto.FieldByName('CUST_FORN').AsFloat;
      CustMed     := qrProdCusto.FieldByName('CUST_MED').AsFloat;
      CustReal    := qrProdCusto.FieldByName('CUST_REAL').AsFloat;
      CustRjst    := qrProdCusto.FieldByName('CUST_RJST').AsFloat;
      CustUFrn    := qrProdCusto.FieldByName('CUST_UFRN').AsFloat;
      DtaPrvEntrCompra := qrProdCusto.FieldByName('DTA_PRV_ENTR_COMPRA').AsDateTime;
      DtaUCmp     := qrProdCusto.FieldByName('DTA_UCMP').AsDateTime;
      DtaUInv     := qrProdCusto.FieldByName('DTA_UINV').AsDateTime;
      DtaUMov     := qrProdCusto.FieldByName('DTA_UMOV').AsDateTime;
      DtaURsv     := qrProdCusto.FieldByName('DTA_URSV').AsDateTime;
      DtaUSld     := qrProdCusto.FieldByName('DTA_USLD').AsDateTime;
      FlagRjst    := Boolean(qrProdCusto.FieldByName('FLAG_RJST').AsInteger);
      FkSupplier.PkCadastros  := qrProdCusto.FieldByName('FK_VW_FORNECEDORES').AsInteger;
      FkSupplier.RazSoc       := qrProdCusto.FieldByName('RAZ_SOC').AsString;
      FkCompany.PkCompany    := qrProdCusto.FieldByName('FK_EMPRESAS').AsInteger;
      QtdCnsMed   := qrProdCusto.FieldByName('QTD_CNS_MED').AsFloat;
      QtdCmpMed   := qrProdCusto.FieldByName('QTD_CMP_MED').AsFloat;
      QtdDiasEntr := qrProdCusto.FieldByName('QTD_DIAS_ENTR').AsInteger;
      QtdDiasEstq := qrProdCusto.FieldByName('QTD_DIAS_ESTQ').AsInteger;
      QtdDiasRep  := qrProdCusto.FieldByName('QTD_DIAS_REP').AsInteger;
      QtdEstq     := qrProdCusto.FieldByName('QTD_ESTQ').AsFloat;
      QtdEMax     := qrProdCusto.FieldByName('QTD_EMAX').AsFloat;
      QtdEMin     := qrProdCusto.FieldByName('QTD_EMIN').AsFloat;
      QtdEstqQR   := qrProdCusto.FieldByName('QTD_ESTQ_QR').AsFloat;
      QtdGrnt     := qrProdCusto.FieldByName('QTD_GRNT').AsFloat;
      QtdPedF     := qrProdCusto.FieldByName('QTD_PEDF').AsFloat;
      QtdRsrv     := qrProdCusto.FieldByName('QTD_RSRV').AsFloat;
    end;
  finally
    if qrProdCusto.Active then qrProdCusto.Close;
    Dados.CommitTransaction(qrProdCusto);
  end;
end;

function  TdmSysEstq.GetProductPrices(APkPrd: Integer): TList;
begin
  Result := TList.Create;
  if ProdutoPreco.Active then ProdutoPreco.Close;
  ProdutoPreco.SQL.Clear;
  ProdutoPreco.SQL.Add(SelectProductPrices);
  Dados.StartTransaction(ProdutoPreco);
  try
    ProdutoPreco.Params.FindParam('FkProdutos').AsInteger := APkPrd;
    if not ProdutoPreco.Active then ProdutoPreco.Open;
    while not ProdutoPreco.EOF do
    begin
      Result.Add(TDataRow.CreateFromDataSet(nil, ProdutoPreco, True));
      ProdutoPreco.Next;
    end;
  finally
    if ProdutoPreco.Active then ProdutoPreco.Close;
    Dados.CommitTransaction(ProdutoPreco);
  end;
end;

function  TdmSysEstq.LoadPriceTable(AddNone: Boolean = True; All: Boolean = False): TStrings;
var
  aItem: TPriceTable;
begin
  Result := TStringList.Create;
  if (qrTabPrice.Active) then qrTabPrice.Close;
  qrTabPrice.SQL.Clear;
  case All of
    False: qrTabPrice.SQL.Add(SqlTabelaPrecos);
    True : qrTabPrice.SQL.Add(SqlPriceTables);
  end;
  Dados.StartTransaction(qrTabPrice);
  qrTabPrice.Open;
  try
    if (not qrTabPrice.IsEmpty) then
    begin
      qrTabPrice.First;
      if (AddNone) then Result.Add('<Nenhuma>');
      while not qrTabPrice.Eof do
      begin
        aItem              := TPriceTable.Create(nil);
        aItem.PkPriceTable := qrTabPrice.FindField('PK_TABELA_PRECOS').AsInteger;
        aItem.DscTab       := qrTabPrice.FindField('DSC_TAB').AsString;
        aItem.DtaIni       := qrTabPrice.FindField('DTA_INI').AsDateTime;
        aItem.DtaFin       := qrTabPrice.FindField('DTA_FIN').AsDateTime;
        aItem.FlagDefTab   := Boolean(qrTabPrice.FindField('FLAG_DEFTAB').AsInteger);
        aItem.PercDsct     := qrTabPrice.FindField('PERC_DSCT').AsFloat;
        aItem.cbIndex      := Result.AddObject(aItem.DscTab, aItem);
        qrTabPrice.Next;
      end;
    end;
  finally
    if (qrTabPrice.Active) then qrTabPrice.Close;
    Dados.CommitTransaction(qrTabPrice);
  end;
end;

function  TdmSysEstq.LoadTypeMovement(const AFlagTMov: Integer): TStrings;
var
  aItem: TTypeMoviment;
begin
  Result := TStringList.Create;
  if (qrTipoMovim.Active) then qrTipoMovim.Close;
  qrTipoMovim.SQL.Clear;
  qrTipoMovim.SQL.Add(SqlTiposMovim);
  Dados.StartTransaction(qrTipoMovim);
  try
    qrTipoMovim.ParamByName('FlagTMov').AsInteger := AFlagTMov;
    if (not qrTipoMovim.Active) then qrTipoMovim.Open;
    while (not qrTipoMovim.Eof) do
    begin
      aItem                        := TTypeMoviment.Create;
      aItem.PkTypeMoviment         := qrTipoMovim.FieldByName('PK_TIPO_MOVIM_ESTQ').AsInteger;
      aItem.FkTypeMoviment         := qrTipoMovim.FieldByName('FK_TIPO_MOVIM_ESTQ').AsInteger;
      aItem.DscMov                 := qrTipoMovim.FieldByName('DSC_TMOV').AsString;
      aItem.FlagGenHst             := Boolean(qrTipoMovim.FieldByName('FLAG_GENHST').AsInteger);
      aItem.FlagCode               := TCodeTypes(qrTipoMovim.FieldByName('FLAG_TCOD').AsInteger);
      aItem.FlagLocMov             := TLocalMoviment(qrTipoMovim.FieldByName('FLAG_TBAIXA').AsInteger);
      aItem.FlagTMov               := TMovimentations(qrTipoMovim.FieldByName('FLAG_TMOV').AsInteger);
      aItem.FlagMov[etReal]        := Boolean(qrTipoMovim.FieldByName('FLAG_MVESTQ').AsInteger);
      aItem.FlagMov[etReserved]    := Boolean(qrTipoMovim.FieldByName('FLAG_MVRSRV').AsInteger);
      aItem.FlagMov[etQuarentine]  := Boolean(qrTipoMovim.FieldByName('FLAG_MVQRNT').AsInteger);
      aItem.FlagMov[etGiveBack]    := Boolean(qrTipoMovim.FieldByName('FLAG_MVGRNT').AsInteger);
      aItem.FlagOper[etReal]       := TTypeOper(qrTipoMovim.FieldByName('FLAG_OPESTQ').AsInteger + 1);
      aItem.FlagOper[etReserved]   := TTypeOper(qrTipoMovim.FieldByName('FLAG_OPRSRV').AsInteger + 1);
      aItem.FlagOper[etQuarentine] := TTypeOper(qrTipoMovim.FieldByName('FLAG_OPQRNT').AsInteger + 1);
      aItem.FlagOper[etGiveBack]   := TTypeOper(qrTipoMovim.FieldByName('FLAG_OPGRNT').AsInteger + 1);
      aItem.cbIndex := Result.AddObject(aItem.DscMov, aItem);
      qrTipoMovim.Next;
    end;
  finally
    if (qrTipoMovim.Active) then qrTipoMovim.Close;
    Dados.CommitTransaction(qrTipoMovim);
  end;
end;

function  TdmSysEstq.LoadSitTrib: TStrings;
var
  aItem: TSitTrib;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlSituacaoTrb);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('... Nenhuma ...');
      while not qrSqlAux.Eof do
      begin
        aItem           := TSitTrib.Create;
        aItem.PkSituacaoTributaria := qrSqlAux.FindField('PK_SITUACAO_TRIBUTARIAS').AsInteger;
        aItem.DscSitTrb := qrSqlAux.FindField('DSC_IMPST').AsString;
        aItem.cbIndex   := Result.AddObject(aItem.DscSitTrb, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysEstq.LoadOrigimTrib: TStrings;
var
  aItem: TOrigimTrib;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlOrigemTrb);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('... Nenhum ...');
      while not qrSqlAux.Eof do
      begin
        aItem           := TOrigimTrib.Create;
        aItem.PkOrigensTributarias := qrSqlAux.FindField('PK_ORIGENS_TRIBUTARIAS').AsInteger;
        aItem.DscOrgm   := qrSqlAux.FindField('DSC_ORGM').AsString;
        aItem.cbIndex   := Result.AddObject(aItem.DscOrgm, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysEstq.LoadNatureOper: TStrings;
var
  aItem: TNatureOperation;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlNatureOperation);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('<Nenhum>');
      while not qrSqlAux.Eof do
      begin
        aItem             := TNatureOperation.Create;
        aItem.Pk          := qrSqlAux.FindField('PK_NATUREZA_OPERACOES').AsInteger;
        aItem.TypeCfop.Pk := qrSqlAux.FindField('FK_TIPO_CFOP').AsInteger;
        aItem.DscNtOp     := qrSqlAux.FindField('DSC_NTOP').AsString;
        aItem.CodCfop     := qrSqlAux.FindField('COD_CFOP').AsString;
        aItem.cbIndex     := Result.AddObject(aItem.CodCfop + ' : ' + aItem.DscNtOp, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysEstq.LoadClassFisc: TStrings;
var
  aItem: TClassFisc;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlClassFiscal);
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('... Nenhum ...');
      while not qrSqlAux.Eof do
      begin
        aItem           := TClassFisc.Create;
        aItem.PkClassificacaoFiscal := qrSqlAux.FindField('PK_CLASSIFICACAO_FISCAL').AsString;
        aItem.DscClsf   := qrSqlAux.FindField('DSC_CLSF').AsString;
        aItem.cbIndex   := Result.AddObject(aItem.DscClsf, aItem);
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function  TdmSysEstq.LoadFinanceAccounts(AAccountNat: Integer): TStrings;
var
  aObj: TClassification;
begin
  Result := TStringList.Create;
  with qrSqlAux do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlFinanceAccounts);
    Dados.StartTransaction(qrSqlAux);
    try
      ParamByName('FlagTCta').AsInteger := AAccountNat;
      if not Active then Open;
      Result.Add('<Nenhum>');
      while not (Eof) do
      begin
        aObj               := TClassification.Create;
        aObj.Pk            := FieldByName('R_PK_FINANCEIRO_CONTAS').AsInteger;
        aObj.FkAccountPlan := FieldByName('R_FK_FINANCEIRO_CONTAS').AsInteger;
        aObj.MaskCta       := FieldByName('R_MASK_CTA').AsString;
        aObj.DscClass      := FieldByName('R_DSC_CTA').AsString;
        aObj.NivCta        := FieldByName('R_GRAU_CTA').AsInteger;
        aObj.SeqCta        := FieldByName('R_SEQ_CTA').AsInteger;
        aObj.FlagAnlSnt    := Boolean(FieldByName('R_FLAG_ANL_SNT').AsInteger);
        aObj.FlagTCta      := TAccountNat(FieldByName('R_FLAG_TCTA').AsInteger);
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

function  TdmSysEstq.LoadProductGroups: TStrings;
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

function  TdmSysEstq.LoadInsumos(AType: TTypeInsumos): TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  case AType of
    tiSale     : ;
    tiPurchase : qrSqlAux.SQL.Add(SqlMaterials);
    tiService  : qrSqlAux.SQL.Add(SqlActivity);
    tiPart     : ;
    tiPatrimony: ;
  end;
  if (qrSqlAux.Text = '') then exit;
  Dados.StartTransaction(qrSqlAux);
  qrSqlAux.Open;
  try
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.Add('... Nenhum ...');
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FindField('DSC_PROD').AsString,
          TObject(qrSqlAux.FindField('PK_PRODUTOS').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

procedure TdmSysEstq.DeleteProduct(APrd: Integer);
begin
  if (APrd <= 0) then exit;
  if qrProduct.Active then qrProduct.Close;
  qrProduct.SQL.Clear;
  qrProduct.SQL.Add(SqlDeleteProduto);
  Dados.StartTransaction(qrProduct);
  try
    qrProduct.ParamByName('PkProdutos').AsInteger := APrd;
    qrProduct.ExecSQL;
    Dados.CommitTransaction(qrProduct);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrProduct);
      raise Exception.Create(E.Message);
    end;
  end;
end;

function  TdmSysEstq.UpdateProduct(var APrd: TProducts; AMode: TDBMode): Boolean;
  function GetPKProductCode: Integer;
  begin
    Result := 0;
    qrSqlAux.SQL.Clear;
    qrSqlAux.Params.Clear;
    qrSqlAux.SQL.Add(SqlSelectPkProduto);
    try
      if not qrSqlAux.Active then qrSqlAux.Open;
      if not qrSqlAux.IsEmpty then
        Result := qrSqlAux.FieldByName('PK_PRODUTOS').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  Result := False;
  if (APrd = nil) or (not (AMode in UPDATE_MODE)) then exit;
  if qrProduct.Active then qrProduct.Close;
  qrProduct.SQL.Clear;
  if AMode = dbmInsert then
    qrProduct.SQL.Add(SqlInsertProduto)
  else
    qrProduct.SQL.Add(SqlUpdateProduto);
  try
    if AMode = dbmInsert then
    begin
      APrd.PkProducts := GetPkProductCode;
      if APrd.PkProducts = 0 then
        raise Exception.Create('Erro: Não posso achar a Chave Primária para a ' +
          'tabela Produtos Códigos');
    end;
    qrProduct.ParamByName('PkProdutos').AsInteger := APrd.PkProducts;
    if qrProduct.Params.FindParam('DscProd') <> nil then
      qrProduct.ParamByName('DscProd').AsString := APrd.DscProd;
    if qrProduct.Params.FindParam('FkProdutosGrupos') <> nil then
      qrProduct.ParamByName('FkProdutosGrupos').AsInteger := APrd.FkProductGroup;
    if qrProduct.Params.FindParam('FkUnidades') <> nil then
      qrProduct.ParamByName('FkUnidades').AsInteger := APrd.FkUnit.PkUnit;
    if qrProduct.Params.FindParam('FlagAtv') <> nil then
      qrProduct.ParamByName('FlagAtv').AsInteger := Integer(APrd.FlagAtv);
    qrProduct.ExecSQL;
    Result := True;
  except on E:Exception do
      raise Exception.Create('UpdateProduct: ' + E.Message +
        qrProduct.SQL.Text);
  end;
end;

procedure TdmSysEstq.UpdateProductSale(const APkPrd: Integer;
  APrdSale: TProductSale; AMode: TDBMode);
begin
  if (APkPrd <= 0) or (APrdSale = nil) or
     (not (AMode in UPDATE_MODE)) then exit;
  if ProdutoVnd.Active then ProdutoVnd.Close;
  ProdutoVnd.SQL.Clear;
  if AMode = dbmInsert then
    ProdutoVnd.SQL.Add(SqlInsertPrdSale)
  else
    ProdutoVnd.SQL.Add(SqlUpdatePrdSale);
  try
    if ProdutoVnd.Params.FindParam('FkProdutos') <> nil then
      ProdutoVnd.ParamByName('FkProdutos').AsInteger := APkPrd;
    if ProdutoVnd.Params.FindParam('DscProdRed') <> nil then
      ProdutoVnd.ParamByName('DscProdRed').AsString := APrdSale.DscRed;
    if ProdutoVnd.Params.FindParam('FlagImp') <> nil then
      ProdutoVnd.ParamByName('FlagImp').AsInteger := Integer(APrdSale.FlagImp);
    if ProdutoVnd.Params.FindParam('PesBru') <> nil then
      ProdutoVnd.ParamByName('PesBru').AsFloat := APrdSale.PesBru;
    if ProdutoVnd.Params.FindParam('PesLiq') <> nil then
      ProdutoVnd.ParamByName('PesLiq').AsFloat := APrdSale.PesLiq;
    if ProdutoVnd.Params.FindParam('AltProd') <> nil then
      ProdutoVnd.ParamByName('AltProd').AsFloat := APrdSale.AltProd;
    if ProdutoVnd.Params.FindParam('ProfProd') <> nil then
      ProdutoVnd.ParamByName('ProfProd').AsFloat := APrdSale.ProfProd;
    if ProdutoVnd.Params.FindParam('LargProd') <> nil then
      ProdutoVnd.ParamByName('LargProd').AsFloat := APrdSale.LargProd;
    if ProdutoVnd.Params.FindParam('AltEProd') <> nil then
      ProdutoVnd.ParamByName('AltEProd').AsFloat := APrdSale.EmbAltProd;
    if ProdutoVnd.Params.FindParam('ProfEProd') <> nil then
      ProdutoVnd.ParamByName('ProfEProd').AsFloat := APrdSale.EmbProfProd;
    if ProdutoVnd.Params.FindParam('LargEProd') <> nil then
      ProdutoVnd.ParamByName('LargEProd').AsFloat := APrdSale.EmbLargProd;
    if ProdutoVnd.Params.FindParam('AltIProd') <> nil then
      ProdutoVnd.ParamByName('AltIProd').AsFloat := APrdSale.IntAltProd;
    if ProdutoVnd.Params.FindParam('ProfIProd') <> nil then
      ProdutoVnd.ParamByName('ProfIProd').AsFloat := APrdSale.IntProfProd;
    if ProdutoVnd.Params.FindParam('LargIProd') <> nil then
      ProdutoVnd.ParamByName('LargIProd').AsFloat := APrdSale.IntLargProd;
    if ProdutoVnd.Params.FindParam('FatConvCub') <> nil then
      ProdutoVnd.ParamByName('FatConvCub').AsFloat := APrdSale.FatConvCub;
    if (APrdSale.FkLines.PkLines > 0) and
       (ProdutoVnd.Params.FindParam('FkLinhas') <> nil) then
      ProdutoVnd.ParamByName('FkLinhas').AsFloat := APrdSale.FkLines.PkLines
    else
      DeleteDataSetParams(ProdutoVnd, 'FkLinhas');
    if (APrdSale.FkSimilar.PkSimilar > 0) and
       (ProdutoVnd.Params.FindParam('FkSimilares') <> nil) then
      ProdutoVnd.ParamByName('FkSimilares').AsFloat := APrdSale.FkSimilar.PkSimilar
    else
      DeleteDataSetParams(ProdutoVnd, 'FkSimilares');
    ProdutoVnd.ExecSQL;
  except on E:Exception do
      raise Exception.Create('UpdateProductSale: ' + E.Message +
        ProdutoVnd.SQL.Text);
  end;
end;

function TdmSysEstq.GetProductSale(APk: Integer): TProductSale;
begin
  Result := TProductSale.Create(nil);
  if ProdutoVnd.Active then ProdutoVnd.Close;
  ProdutoVnd.SQL.Clear;
  ProdutoVnd.SQL.Add(SqlProdutoVnd);
  Dados.StartTransaction(ProdutoVnd);
  try
    ProdutoVnd.Params.FindParam('FkProdutos').AsInteger := APk;
    if (not ProdutoVnd.Active) then ProdutoVnd.Open;
    if (not ProdutoVnd.IsEmpty) then
    begin
      with Result do
      begin
        DscRed              := ProdutoVnd.FieldByName('DSC_PROD_RED').AsString;
        FlagImp             := Boolean(ProdutoVnd.FieldByName('FLAG_IMP').AsInteger);
        PesBru              := ProdutoVnd.FieldByName('PES_BRU').AsFloat;
        PesLiq              := ProdutoVnd.FieldByName('PES_LIQ').AsFloat;
        AltProd             := ProdutoVnd.FieldByName('ALT_PROD').AsFloat;
        ProfProd            := ProdutoVnd.FieldByName('PROF_PROD').AsFloat;
        LargProd            := ProdutoVnd.FieldByName('LARG_PROD').AsFloat;
        EmbAltProd          := ProdutoVnd.FieldByName('ALT_EPROD').AsFloat;
        EmbProfProd         := ProdutoVnd.FieldByName('PROF_EPROD').AsFloat;
        EmbLargProd         := ProdutoVnd.FieldByName('LARG_EPROD').AsFloat;
        IntAltProd          := ProdutoVnd.FieldByName('ALT_IPROD').AsFloat;
        IntProfProd         := ProdutoVnd.FieldByName('PROF_IPROD').AsFloat;
        IntLargProd         := ProdutoVnd.FieldByName('LARG_IPROD').AsFloat;
        FatConvCub          := ProdutoVnd.FieldByName('FAT_CONV_CUB').AsFloat;
        FkLines.PkLines     := ProdutoVnd.FieldByName('FK_LINHAS').AsInteger;
        FkSimilar.PkSimilar := ProdutoVnd.FieldByName('FK_SIMILARES').AsInteger;
      end;
    end;
  finally
    if ProdutoVnd.Active then ProdutoVnd.Close;
    Dados.CommitTransaction(ProdutoVnd);
  end;
end;

function TdmSysEstq.GetProductPurchase(APk: Integer): TProductPurchase;
begin
  Result := TProductPurchase.Create(nil);
  if ProdPurchase.Active then ProdPurchase.Close;
  ProdPurchase.SQL.Clear;
  ProdPurchase.SQL.Add(SqlProdPurchase);
  Dados.StartTransaction(ProdPurchase);
  try
    ProdPurchase.Params.FindParam('FkProdutos').AsInteger := APk;
    if not ProdPurchase.Active then ProdPurchase.Open;
    if (not ProdPurchase.IsEmpty) then
    begin
      with Result do
      begin
        FkReferenceType.FkFinishType.PkFinishType := ProdPurchase.FieldByName('FK_TIPO_ACABAMENTOS').AsInteger;
        FkReferenceType.PkReferenceType := ProdPurchase.FieldByName('FK_TIPO_REFERENCIAS').AsInteger;
        VlrUnit  := ProdPurchase.FieldByName('VLR_UNIT').AsFloat;
        FLagCmpr := Boolean(ProdPurchase.FieldByName('FLAG_CMPR').AsInteger);
        FlagEmp  := Boolean(ProdPurchase.FieldByName('FLAG_EMP').AsInteger);
        FlagTMat := TMaterialType(ProdPurchase.FieldByName('FLAG_TMAT').AsInteger);
      end;
    end;
  finally
    if ProdPurchase.Active then ProdPurchase.Close;
    Dados.CommitTransaction(ProdPurchase);
  end;
end;

function TdmSysEstq.GetProductSuppliers(APk: Integer): TProductSuppliers;
var
  stM: TMemoryStream;
begin
  Result := TProductSuppliers.Create(nil);
  if ProdSupp.Active then ProdSupp.Close;
  ProdSupp.SQL.Clear;
  ProdSupp.SQL.Add(SqlProdSuppliers);
  Dados.StartTransaction(ProdSupp);
  try
    ProdSupp.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
    ProdSupp.Params.FindParam('FkProdutos').AsInteger := APk;
    if not ProdSupp.Active then ProdSupp.Open;
    while (not ProdSupp.Eof) do
    begin
      with Result.Add do
      begin
        FkCompany.PkCompany       := Dados.PkCompany;
        FkCompany.DscEmp          := Dados.NameCompany;
        FkSupplier.PkCadastros    := ProdSupp.FieldByName('FK_VW_FORNECEDORES').AsInteger;
        FkSupplier.RazSoc         := ProdSupp.FieldByName('RAZ_SOC').AsString;
        FkTypeDsct.PkTypeDiscount := ProdSupp.FieldByName('FK_TIPO_DESCONTOS').AsInteger;
        FkTypeDsct.DscDsct        := ProdSupp.FieldByName('DSC_TDSCT').AsString;
        FkUnit.PkUnit             := ProdSupp.FieldByName('FK_UNIDADES').AsInteger;
        FkUnit.MnmoUni            := ProdSupp.FieldByName('MNMO_UNI').AsString;
        DtaGrnt                   := ProdSupp.FieldByName('DTA_GRNT').AsDateTime;
        FlagInsp                  := TInspectionType(ProdSupp.FieldByName('FLAG_INSP').AsInteger);
        FlagRjst                  := Boolean(ProdSupp.FieldByName('FLAG_RJST').AsInteger);
        FreteIns                  := ProdSupp.FieldByName('FRETE_INS').AsFloat;
        if (not ProdSupp.FieldByName('OBS_FORN').IsNull) then
        begin
          stM                     := TMemoryStream.Create;
          try
            stM.Position            := 0;
            TBlobField(ProdSupp.FieldByName('OBS_FORN')).SaveToStream(stM);
            stM.Position            := 0;
            ObsForn.LoadFromStream(stM);
          finally
            stM.Free;
          end;
        end;
        PreFinal                  := ProdSupp.FieldByName('PRE_FINAL').AsFloat;
        PreTab                    := ProdSupp.FieldByName('PRE_TAB').AsFloat;
        QtdDiasEntr               := ProdSupp.FieldByName('QTD_DIAS_ENTR').AsInteger;
        QtdGrnt                   := ProdSupp.FieldByName('QTD_GRNT').AsFloat;
        QtdUni                    := ProdSupp.FieldByName('QTD_UNI').AsFloat;
        SitTrib                   := ProdSupp.FieldByName('SIT_TRIB').AsString;
      end;
      ProdSupp.Next;
    end;
  finally
    if ProdSupp.Active then ProdSupp.Close;
    Dados.CommitTransaction(ProdSupp);
  end;
end;

function  TdmSysEstq.LoadTypeFinishes: TStrings;
var
  aItem: TFinishType;
begin
  Result := TStringList.Create;
  if (TipoAcabm.Active) then TipoAcabm.Close;
  TipoAcabm.SQL.Clear;
  TipoAcabm.SQL.Add(SqlTipoAcabamentos);
  Dados.StartTransaction(TipoAcabm);
  TipoAcabm.Open;
  try
    if (not TipoAcabm.IsEmpty) then
    begin
      TipoAcabm.First;
      Result.Add('... Nenhum ...');
      while not TipoAcabm.Eof do
      begin
        aItem              := TFinishType.Create;
        aItem.PkFinishType := TipoAcabm.FieldbyName('PK_TIPO_ACABAMENTOS').AsInteger;
        aItem.DscAcbm      := TipoAcabm.FieldbyName('DSC_ACABM').AsString;
        aItem.cbIndex      := Result.AddObject(aItem.DscAcbm, aItem);
        TipoAcabm.Next;
      end;
    end;
  finally
    if (TipoAcabm.Active) then TipoAcabm.Close;
    Dados.CommitTransaction(TipoAcabm);
  end;
end;

function  TdmSysEstq.LoadTypeReferences(AFinishType: TFinishType): TStrings;
var
  aItem: TReferenceType;
begin
  Result := TStringList.Create;
  if (AFinishType = nil) then exit;
  if (TipoReferencia.Active) then TipoReferencia.Close;
  TipoReferencia.SQL.Clear;
  TipoReferencia.SQL.Add(SqlTipoReferencias);
  Dados.StartTransaction(TipoReferencia);
  if (TipoReferencia.Params.FindParam('FkTipoAcabamentos') <> nil) then
    TipoReferencia.ParamByName('FkTipoAcabamentos').AsInteger := AFinishType.PkFinishType;
  TipoReferencia.Open;
  try
    if (not TipoReferencia.IsEmpty) then
    begin
      TipoReferencia.First;
      Result.Add('... Nenhum ...');
      while not TipoReferencia.Eof do
      begin
        aItem                 := TReferenceType.Create;
        aItem.PkReferenceType := TipoReferencia.FindField('PK_TIPO_REFERENCIAS').AsInteger;
        aItem.DscRef          := TipoReferencia.FindField('DSC_REF').AsString;
        aItem.FkFinishType    := AFinishType;
        aItem.cbIndex         := Result.AddObject(aItem.DscRef, aItem);
        TipoReferencia.Next;
      end;
    end;
  finally
    if (TipoReferencia.Active) then TipoReferencia.Close;
    Dados.CommitTransaction(TipoReferencia);
  end;
end;

function  TdmSysEstq.LoadSimilar(AddNone: Boolean = True): TStrings;
var
  aItem: TSimilar;
begin
  Result := TStringList.Create;
  qrSimilar.SQL.Clear;
  qrSimilar.SQL.Add(SqlSimilares);
  Dados.StartTransaction(qrSimilar);
  try
    if (not qrSimilar.Active) then qrSimilar.Open;
    if (not qrSimilar.IsEmpty) then
    begin
      qrSimilar.First;
      if (AddNone) then Result.Add('<Nenhum>');
      while not qrSimilar.Eof do
      begin
        aItem           := TSimilar.Create;
        aItem.PkSimilar := qrSimilar.FindField('PK_SIMILARES').AsInteger;
        aItem.DscSim    := qrSimilar.FindField('DSC_SIM').AsString;
        aItem.cbIndex   := Result.AddObject(aItem.DscSim, aItem);
        qrSimilar.Next;
      end;
    end;
  finally
    if (qrSimilar.Active) then qrSimilar.Close;
    Dados.CommitTransaction(qrSimilar);
  end;
end;

function TdmSysEstq.LoadLinhas(AddNone: Boolean = True): TStrings;
var
  aItem: TLines;
begin
  Result := TStringList.Create;
  if (qrLinha.Active) then qrLinha.Close;
  qrLinha.SQL.Clear;
  qrLinha.SQL.Add(SqlLinhas);
  Dados.StartTransaction(qrLinha);
  try
    if (not qrLinha.Active) then qrLinha.Open;
    if (not qrLinha.IsEmpty) then
    begin
      qrLinha.First;
      if AddNone then Result.Add('<Nenhuma>');
      while not qrLinha.Eof do
      begin
        aItem                 := TLines.Create;
        aItem.PkLines         := qrLinha.FindField('PK_LINHAS').AsInteger;
        aItem.DscLin          := qrLinha.FindField('DSC_LIN').AsString;
        aItem.FkTypeComission := qrLinha.FindField('FK_TIPO_COMISSOES').AsInteger;
        aItem.FontLin         := qrLinha.FindField('FONT_LIN').AsString;
        aItem.cbIndex         := Result.AddObject(aItem.DscLin, aItem);
        qrLinha.Next;
      end;
    end;
  finally
    if (qrLinha.Active) then qrLinha.Close;
    Dados.CommitTransaction(qrLinha);
  end;
end;

function  TdmSysEstq.LoadTypeDocs: TStrings;
var
  aItem: TTypeDocument;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTipoDocumentos);
  Dados.StartTransaction(qrSqlAux);
  try
    if (not qrSqlAux.Active) then qrSqlAux.Open;
    while not qrSqlAux.Eof do
    begin
      aItem := TTypeDocument.Create;
      aItem.PkTypeDocument := qrSqlAux.FindField('PK_TIPO_DOCUMENTOS').AsInteger;
      aItem.DscTDoc        := qrSqlAux.FindField('DSC_TDOC').AsString;
      aItem.FlagTDoc       := TDocumentType(qrSqlAux.FindField('FLAG_TDOC').AsInteger);
      aItem.cbIndex        := Result.AddObject(aItem.DscTDoc, aItem);
      qrSqlAux.Next;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysEstq.LoadUnits(AddNone: Boolean = True): TStrings;
var
  aItem: TUnit;
begin
  Result := TStringList.Create;
  if (qrUnit.Active) then qrUnit.Close;
  qrUnit.SQL.Clear;
  qrUnit.SQL.Add(SqlUnidades);
  Dados.StartTransaction(qrUnit);
  try
    if (not qrUnit.Active) then qrUnit.Open;
    if (not qrUnit.IsEmpty) then
    begin
      qrUnit.First;
      if AddNone then Result.Add('<Nenhum>');
      while not qrUnit.Eof do
      begin
        aItem          := TUnit.Create;
        aItem.PkUnit   := qrUnit.FieldByName('PK_UNIDADES').AsInteger;
        aItem.DscUni   := qrUnit.FieldByName('DSC_UNI').AsString;
        aItem.MnmoUni  := qrUnit.FieldByName('MNMO_UNI').AsString;
        aItem.FlagFrac := (qrUnit.FieldByName('FLAG_FRAC').AsInteger = 1);
        aItem.FlagAlt  := (qrUnit.FieldByName('FLAG_ALT').AsInteger = 1);
        aItem.FlagLarg := (qrUnit.FieldByName('FLAG_LARG').AsInteger = 1);
        aItem.FlagComp := (qrUnit.FieldByName('FLAG_COMP').AsInteger = 1);
        aItem.FlagQtd  := (qrUnit.FieldByName('FLAG_QTD').AsInteger = 1);
        aItem.FlagFUni := qrUnit.FieldByName('FLAG_FUNI').AsInteger;
        aItem.FlagTUni := qrUnit.FieldByName('FLAG_TUNI').AsInteger;
        aItem.cbIndex  := Result.AddObject(aItem.DscUni, aItem);
        qrUnit.Next;
      end;
    end;
  finally
    if (qrUnit.Active) then qrUnit.Close;
    Dados.CommitTransaction(qrUnit);
  end;
end;

function  TdmSysEstq.LoadProductImage(APk: Integer; var APkFound: Integer): TPicture;
begin
  APkFound := 0;
  Result := TPicture.Create;
  if (APk <= 0) then exit;
  if ProdutoImg.Active then ProdutoImg.Close;
  ProdutoImg.SQL.Clear;
  ProdutoImg.SQL.Add(SqlProdutoImg);
  Dados.StartTransaction(ProdutoImg);
  try
    ProdutoImg.Params.FindParam('FkProdutos').AsInteger := APk;
    if not ProdutoImg.Active then ProdutoImg.Open;
    if (not ProdutoImg.IsEmpty) then
    begin
      GetImage_FromStream(TBlobField(ProdutoImg.FindField('IMG_PROD')), Result);
      APkFound := APk;
    end;
  finally
    if ProdutoImg.Active then ProdutoImg.Close;
    Dados.CommitTransaction(ProdutoImg);
  end;
end;

function  TdmSysEstq.LoadProductDescription(APk: Integer; var APkFound: Integer): TStrings;
var
  M: TStream;
begin
  APkFound := 0;
  Result := TStringList.Create;
  if (APk <= 0) then exit;
  if ProdutoImg.Active then ProdutoImg.Close;
  ProdutoImg.SQL.Clear;
  ProdutoImg.SQL.Add(SqlProdutoObs);
  Dados.StartTransaction(ProdutoImg);
  M := TMemoryStream.Create;
  try
    if ProdutoImg.Params.FindParam('FkProdutos') <> nil then
      ProdutoImg.Params.FindParam('FkProdutos').AsInteger := APk;
    if not ProdutoImg.Active then ProdutoImg.Open;
    if (not ProdutoImg.IsEmpty) then
    begin
      TBlobField(ProdutoImg.FindField('CRT_PROD')).SaveToStream(M);
      M.Position := 0;
      Result.LoadFromStream(M);
      APkFound := APk;
    end;
  finally
    if ProdutoImg.Active then ProdutoImg.Close;
    Dados.CommitTransaction(ProdutoImg);
    FreeAndNil(M);
  end;
end;

function  TdmSysEstq.GetProduct(APk: Integer): TProducts;
begin
  Result := TProducts.Create;
  if qrProduct.Active then qrProduct.Close;
  qrProduct.SQL.Clear;
  qrProduct.SQL.Add(SqlProduto);
  Dados.StartTransaction(qrProduct);
  try
    if qrProduct.Params.FindParam('PkProdutos') <> nil then
      qrProduct.Params.FindParam('PkProdutos').AsInteger := APk;
    if not qrProduct.Active then qrProduct.Open;
    if (not qrProduct.IsEmpty) then
    begin
      Result.DscProd        := qrProduct.FieldByName('DSC_PROD').AsString;
      Result.FlagAtv        := Boolean(qrProduct.FieldByName('FLAG_ATV').AsInteger);
      Result.QtdUni         := qrProduct.FieldByName('FLAG_ATV').AsFloat;
      Result.FkProductGroup := qrProduct.FieldByName('FK_PRODUTOS_GRUPOS').AsInteger;
      with Result.FkUnit do
      begin
        PkUnit  := qrProduct.FieldByName('FK_UNIDADES').AsInteger;
        DscUni  := qrProduct.FieldByName('DSC_UNI').AsString;
        MnmoUni := qrProduct.FieldByName('MNMO_UNI').AsString;
      end;
    end;
  finally
    if qrProduct.Active then qrProduct.Close;
    Dados.CommitTransaction(qrProduct);
  end;
end;

function TdmSysEstq.GetProductCodes(AFk: Integer): TProductCodes;
begin
  Result := TProductCodes.Create(nil);
  if (AFk <= 0) then exit;
  if qrProductCode.Active then qrProductCode.Close;
  qrProductCode.SQL.Clear;
  qrProductCode.SQL.Add(SqlProdutoCod);
  Dados.StartTransaction(qrProductCode);
  try
    qrProductCode.Params.FindParam('FkProdutos').AsInteger := AFk;
    if not qrProductCode.Active then qrProductCode.Open;
    while not qrProductCode.Eof do
    begin
      with Result.Add do
      begin
        PkProductCode := qrProductCode.FieldByName('PK_PRODUTOS_CODIGOS').AsInteger;
        CodRef        := qrProductCode.FieldByName('COD_REF').AsString;
        DscCode       := qrProductCode.FieldByName('DSC_CODE').AsString;
        FlagTBarCode  := TBarCode(qrProductCode.FieldByName('FLAG_TBARCODE').AsInteger);
        FlagTCode     := TCodeTypes(qrProductCode.FieldByName('FLAG_TCODE').AsInteger);
      end;
      qrProductCode.Next;
    end;
  finally
    if qrProductCode.Active then qrProductCode.Close;
    Dados.CommitTransaction(qrProductCode);
  end;
end;

procedure TdmSysEstq.DeleteProductCode(const APkPrd, APkCode: Integer);
begin
  if (APkPrd <= 0) or (APkCode <= 0) then exit;
  if qrProductCode.Active then qrProductCode.Close;
  qrProductCode.SQL.Clear;
  qrProductCode.SQL.Add(SqlDeletePrdCode);
  Dados.StartTransaction(qrProductCode);
  try
    qrProductCode.ParamByName('FkProdutos').AsInteger := APkPrd;
    qrProductCode.ParamByName('PkProdutosCodigos').AsInteger := APkCode;
    qrProductCode.ExecSQL;
    Dados.CommitTransaction(qrProductCode);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(qrProductCode);
      raise Exception.Create('DeleteProductCode: Erro ao excluir o registro!' +
        NL + E.Message + NL + qrProductCode.SQL.Text);
    end;
  end;
end;

procedure TdmSysEstq.UpdateProductCode(const APkPrd: Integer;
  APrdCode: TProductCode; AMode: TDBMode);
  function GetPKProductCode: Integer;
  begin
    qrSqlAux.SQL.Clear;
    qrSqlAux.Params.Clear;
    qrSqlAux.SQL.Add(SqlSelectPkPrdCode);
    if (qrSqlAux.Params.FindParam('FkProdutos') <> nil) then
      qrSqlAux.ParamByName('FkProdutos').AsInteger := APkPrd;
    try
      if not qrSqlAux.Active then qrSqlAux.Open;
      if qrSqlAux.FieldByName('PK_PRODUTOS_CODIGOS').IsNull then
        Result := 1
      else
        Result := qrSqlAux.FieldByName('PK_PRODUTOS_CODIGOS').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (APkPrd <= 0) or (APrdCode = nil) or
     (not (AMode in UPDATE_MODE)) then
    exit;
  if qrProductCode.Active then qrProductCode.Close;
  qrProductCode.SQL.Clear;
  try
    if AMode = dbmInsert then
    begin
      APrdCode.PkProductCode := GetPkProductCode;
      qrProductCode.SQL.Add(SqlInsertPrdCode)
    end
    else
      qrProductCode.SQL.Add(SqlUpdatePrdCode);
    if APrdCode.PkProductCode = 0 then
    begin
      raise Exception.Create('Erro: Não posso achar a Chave Primária para a ' +
        'tabela Produtos Códigos');
      exit;
    end;
    if qrProductCode.Params.FindParam('FkProdutos') <> nil then
      qrProductCode.ParamByName('FkProdutos').AsInteger := APkPrd;
    if qrProductCode.Params.FindParam('PkProdutosCodigos') <> nil then
      qrProductCode.ParamByName('PkProdutosCodigos').AsInteger := APrdCode.PkProductCode;
    if qrProductCode.Params.FindParam('CodRef') <> nil then
      qrProductCode.ParamByName('CodRef').AsString := APrdCode.CodRef;
    if qrProductCode.Params.FindParam('DscCode') <> nil then
      qrProductCode.ParamByName('DscCode').AsString := APrdCode.DscCode;
    if qrProductCode.Params.FindParam('FlagTCode') <> nil then
      qrProductCode.ParamByName('FlagTCode').AsInteger := Integer(APrdCode.FlagTCode);
    if qrProductCode.Params.FindParam('FlagTBarCode') <> nil then
      qrProductCode.ParamByName('FlagTBarCode').AsInteger := Integer(APrdCode.FlagTBarCode);
    qrProductCode.ExecSQL;
  except on E:Exception do
    raise Exception.Create('UpdateProductCode: ' + E.Message +
      qrProductCode.SQL.Text);
  end;
end;

function TdmSysEstq.LoadSuppliers: TStrings;
var
  aItem: TOwner;
begin
  Result := TStringList.Create;
  if (qrSupplier.Active) then qrSupplier.Close;
  qrSupplier.SQL.Clear;
  qrSupplier.SQL.Add(SqlFornecedores);
  Dados.StartTransaction(qrSupplier);
  try
    if (not qrSupplier.Active) then qrSupplier.Open;
    Result.Add('<Nenhum>');
    qrSupplier.First;
    while not qrSupplier.Eof do
    begin
      aItem             := TOwner.Create;
      aItem.PkCadastros := qrSupplier.FindField('PK_CADASTROS').AsInteger;
      aItem.RazSoc      := qrSupplier.FindField('RAZ_SOC').AsString;
      aItem.cbIndex     := Result.AddObject(aItem.RazSoc, aItem);
      qrSupplier.Next;
    end;
  finally
    if (qrSupplier.Active) then qrSupplier.Close;
    Dados.CommitTransaction(qrSupplier);
  end;
end;

function TdmSysEstq.LoadTypeDiscounts: TStrings;
var
  aItem: TTypeDiscount;
  aDsct: TDiscount;
  aStr : string;
  aPkGrMov: Integer;
  function GetGroupMovPurchase: Integer;
  begin
    if qrTypeDsct.Active then qrTypeDsct.Close;
    qrTypeDsct.SQL.Clear;
    qrTypeDsct.SQL.Add(SqlGroupMovPurch);
    Dados.StartTransaction(qrTypeDsct);
    try
      if not qrTypeDsct.Active then qrTypeDsct.Open;
      Result := qrTypeDsct.FieldByName('PK_GRUPOS_MOVIMENTOS').AsInteger;
    finally
      if qrTypeDsct.Active then qrTypeDsct.Close;
      Dados.CommitTransaction(qrTypeDsct);
    end;
  end;
begin
  aPkGrMov := GetGroupMovPurchase;
  Result := TStringList.Create;
  if qrTypeDsct.Active then qrTypeDsct.Close;
  qrTypeDsct.SQL.Clear;
  qrTypeDsct.SQL.Add(SqlTipoDescontos);
  Dados.StartTransaction(qrTypeDsct);
  try
    qrTypeDsct.ParamByName('FkGruposMovimentos').AsInteger := aPkGrMov;
    if not qrTypeDsct.Active then qrTypeDsct.Open;
    Result.Add('<Nenhum>');
    aStr  := '';
    aItem := nil;
    while not (qrTypeDsct.Eof) do
    begin
      if aStr <> qrTypeDsct.FieldByName('DSC_TDSCT').AsString then
      begin
        aItem                := TTypeDiscount.Create;
        aItem.PkTypeDiscount := qrTypeDsct.FieldByName('PK_TIPO_DESCONTOS').AsInteger;
        aItem.DscDsct        := qrTypeDsct.FieldByName('DSC_TDSCT').AsString;
        aItem.cbIndex        := Result.AddObject(aItem.DscDsct, aItem);
      end;
      aDsct                       := aItem.Discounts.Add;
      aDsct.FkCategory.PkCategory := qrTypeDsct.FieldByName('FK_CATEGORIAS').AsInteger;
      aDsct.FkState.FkCountry.PKCountry := qrTypeDsct.FieldByName('FK_PAISES').AsInteger;
      aDsct.FkState.PkState := qrTypeDsct.FieldByName('FK_ESTADOS').AsString;
      aDsct.FlagTDsct       := TTypeOperation(qrTypeDsct.FieldByName('FLAG_TDSCT').AsInteger);
      aDsct.FlagDstq        := Boolean(qrTypeDsct.FieldByName('FLAG_DSTQ').AsInteger);
      aDsct.IdxDsct         := qrTypeDsct.FieldByName('IDX_DSCT').AsFloat;
      aStr                  := qrTypeDsct.FieldByName('DSC_TDSCT').AsString;
      qrTypeDsct.Next;
    end;
  finally
    if qrTypeDsct.Active then qrTypeDsct.Close;
    Dados.CommitTransaction(qrTypeDsct);
  end;
end;

procedure TdmSysEstq.UpdateProductSuppliers(const APkPrd, AOldSupp: Integer;
            APrdSupplier: TProductSupplier; AMode: TDBMode);
var
  aPk: TStrings;
  stM: TMemoryStream;
begin
  if (APkPrd <= 0) or (APrdSupplier = nil) or
     (not (AMode in UPDATE_MODE)) then exit;
  if ProdSupp.Active then ProdSupp.Close;
  ProdSupp.SQL.Clear;
  if AMode = dbmInsert then
    ProdSupp.SQL.AddStrings(GetInsertSQL(APrdSupplier.GetFields,
      'PRODUTOS_FORNECEDORES'));
  if AMode = dbmEdit then
  begin
    aPk := TStringList.Create;
    try
      aPk.Add('FK_EMPRESAS');
      aPk.Add('FK_PRODUTOS');
      aPk.Add('FK_VW_FORNECEDORES');
      ProdSupp.SQL.AddStrings(GetUpdateSQL(APrdSupplier.GetFields, aPk,
        'PRODUTOS_FORNECEDORES'));
    finally
      aPk.Free;
    end;
  end;
  try
    ProdSupp.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
    ProdSupp.ParamByName('FkProdutos').AsInteger := APkPrd;
    ProdSupp.ParamByName('FkVwFornecedores').AsInteger := APrdSupplier.FkSupplier.PkCadastros;
    if ProdSupp.Params.FindParam('OldFkEmpresas') <> nil then
      ProdSupp.ParamByName('OldFkEmpresas').AsInteger := Dados.PkCompany;
    if ProdSupp.Params.FindParam('OldFkProdutos') <> nil then
      ProdSupp.ParamByName('OldFkProdutos').AsInteger := APkPrd;
    if ProdSupp.Params.FindParam('OldFkVwFornecedores') <> nil then
      ProdSupp.ParamByName('OldFkVwFornecedores').AsInteger := AOldSupp;
    ProdSupp.ParamByName('FkUnidades').AsInteger := APrdSupplier.FkUnit.PkUnit;
    if ProdSupp.Params.FindParam('FkTipoDescontos') <> nil then
      ProdSupp.ParamByName('FkTipoDescontos').AsInteger := APrdSupplier.FkTypeDsct.PkTypeDiscount;
    if ProdSupp.Params.FindParam('SitTrib') <> nil then
      ProdSupp.ParamByName('SitTrib').AsString := APrdSupplier.SitTrib;
    ProdSupp.ParamByName('QtdUni').AsFloat     := APrdSupplier.QtdUni;
    ProdSupp.ParamByName('QtdGrnt').AsFloat    := APrdSupplier.QtdGrnt;
    ProdSupp.ParamByName('FlagRjst').AsInteger := Ord(APrdSupplier.FlagRjst);
    ProdSupp.ParamByName('FlagInsp').AsInteger := Ord(APrdSupplier.FlagInsp);
    ProdSupp.ParamByName('PreTab').AsFloat     := APrdSupplier.PreTab;
    ProdSupp.ParamByName('PreFinal').AsFloat   := APrdSupplier.PreFinal;
    ProdSupp.ParamByName('FreteIns').AsFloat   := APrdSupplier.FreteIns;
    ProdSupp.ParamByName('QtdDiasEntr').AsInteger := APrdSupplier.QtdDiasEntr;
    if ProdSupp.Params.FindParam('ObsForn') <> nil then
    begin
      stM := TMemoryStream.Create;
      stM.Position := 0;
      APrdSupplier.ObsForn.SaveToStream(stM);
      stM.Position := 0;
      ProdSupp.ParamByName('ObsForn').LoadFromStream(stM, ftMemo);
    end;
    if ProdSupp.Params.FindParam('DtaGrnt') <> nil then
      ProdSupp.ParamByName('DtaGrnt').AsDate := APrdSupplier.DtaGrnt;
    ProdSupp.ParamByName('KcProdutosFonecedoresComp').AsInteger := 0;
    ProdSupp.ExecSQL;
  except on E:Exception do
    raise Exception.Create('UpdateProductSuppliers: ' + E.Message +
      ProdSupp.SQL.Text);
  end;
end;

function TdmSysEstq.GetNewProductReference(const AProductGroup: Integer): string;
var
  aGru, aSGru, aSeq: string;
  aValidate: Boolean;
begin
  aValidate := True;
  if (AProductGroup = 0) then exit;
  Result := '';
  if (qrProductCode.Active) then qrProductCode.Close;
  qrProductCode.SQL.Clear;
  qrProductCode.SQL.Add(SqlGenereteReference);
  Dados.StartTransaction(qrProductCode);
  try
    qrProductCode.ParamByName('FkProdutosGrupos').AsInteger := AProductGroup;
    if (not qrProductCode.Active) then qrProductCode.Open;
    aGru  := InsereZer(qrProductCode.FieldByName('R_FK_PRODUTOS_GRUPOS').AsString, 2);
    aSGru := qrProductCode.FieldByName('R_COD_GREF').AsString;
    aSeq  := InsereZer(qrProductCode.FieldByName('R_SEQUENCE').AsString, 4);
    Result := aGru + '-' + aSGru + '-' + aSeq;
  finally
    if (qrProductCode.Active) then qrProductCode.Close;
    Dados.CommitTransaction(qrProductCode);
  end;
  if (Result <> '') then
  begin
    if (qrProductCode.Active) then qrProductCode.Close;
    qrProductCode.SQL.Clear;
    qrProductCode.SQL.Add(SqlCountCodes);
    Dados.StartTransaction(qrProductCode);
    try
      qrProductCode.ParamByName('CodRef').AsString := Result;
      if (not qrProductCode.Active) then qrProductCode.Open;
      aValidate := (qrProductCode.FieldByName('QTD_ROWS').AsInteger = 0);
    finally
      if (qrProductCode.Active) then qrProductCode.Close;
      Dados.CommitTransaction(qrProductCode);
    end;
  end;
  if (not aValidate) then
    GetNewProductReference(AProductGroup);
end;

function  TdmSysEstq.GetTypeMovement(aPk: Integer): TTypeMoviment;
begin
  Result := nil;
  if (qrTipoMovim.Active) then qrTipoMovim.Close;
  qrTipoMovim.SQL.Clear;
  qrTipoMovim.SQL.Add(SqlTipoMovim);
  Dados.StartTransaction(qrTipoMovim);
  try
    qrTipoMovim.ParamByName('PkTipoMovimEstq').AsInteger := APk;
    if (not qrTipoMovim.Active) then qrTipoMovim.Open;
    if (not qrTipoMovim.IsEmpty) then
    begin
      Result                        := TTypeMoviment.Create;
      Result.PkTypeMoviment         := qrTipoMovim.FieldByName('PK_TIPO_MOVIM_ESTQ').AsInteger;
      Result.FkTypeMoviment         := qrTipoMovim.FieldByName('FK_TIPO_MOVIM_ESTQ').AsInteger;
      Result.DscMov                 := qrTipoMovim.FieldByName('DSC_TMOV').AsString;
      Result.FlagGenHst             := Boolean(qrTipoMovim.FieldByName('FLAG_GENHST').AsInteger);
      Result.FlagCode               := TCodeTypes(qrTipoMovim.FieldByName('FLAG_TCOD').AsInteger);
      Result.FlagLocMov             := TLocalMoviment(qrTipoMovim.FieldByName('FLAG_TBAIXA').AsInteger);
      Result.FlagTMov               := TMovimentations(qrTipoMovim.FieldByName('FLAG_TMOV').AsInteger);
      Result.FlagMov[etReal]        := Boolean(qrTipoMovim.FieldByName('FLAG_MVESTQ').AsInteger);
      Result.FlagMov[etReserved]    := Boolean(qrTipoMovim.FieldByName('FLAG_MVRSRV').AsInteger);
      Result.FlagMov[etGiveBack]    := Boolean(qrTipoMovim.FieldByName('FLAG_MVGRNT').AsInteger);
      Result.FlagMov[etQuarentine]  := Boolean(qrTipoMovim.FieldByName('FLAG_MVQRNT').AsInteger);
      Result.FlagOper[etReal]       := TTypeOper(qrTipoMovim.FieldByName('FLAG_OPESTQ').AsInteger);
      Result.FlagOper[etReserved]   := TTypeOper(qrTipoMovim.FieldByName('FLAG_OPRSRV').AsInteger);
      Result.FlagOper[etGiveBack]   := TTypeOper(qrTipoMovim.FieldByName('FLAG_OPGRNT').AsInteger);
      Result.FlagOper[etQuarentine] := TTypeOper(qrTipoMovim.FieldByName('FLAG_OPQRNT').AsInteger);
    end;
  finally
    if (qrTipoMovim.Active) then qrTipoMovim.Close;
    Dados.CommitTransaction(qrTipoMovim);
  end;
end;

procedure TdmSysEstq.SaveTypeMov(var AItem: TTypeMoviment;
  const AState: TDBMode);
  procedure GetPkMoviment;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkTipoMovim);
    if (not qrSqlAux.Active) then (qrSqlAux.Open);
    try
      if (not qrSqlAux.IsEmpty) then
        AItem.PkTypeMoviment := qrSqlAux.FieldByName('PK_TIPO_MOVIM_ESTQ').AsInteger;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (AItem = nil) or (not (AState in UPDATE_MODE)) then exit;
  if qrTipoMovim.Active then qrTipoMovim.Close;
  qrTipoMovim.SQL.Clear;
  case AState of
    dbmInsert: qrTipoMovim.SQL.Add(SqlInsertTipoMovim);
    dbmEdit  : qrTipoMovim.SQL.Add(SqlUpdateTipoMovim);
    dbmDelete: qrTipoMovim.SQL.Add(SqlDeleteTipoMovim);
  end;
  if (AItem.FkTypeMoviment = 0) and
     (Pos(':FkTipoMovimEstq', qrTipoMovim.SQL.Text) > 0) then
    qrTipoMovim.SQL.Text := StringReplace(qrTipoMovim.SQL.Text, ':FkTipoMovimEstq', 'null', [rfReplaceAll]);
  Dados.StartTransaction(qrTipoMovim);
  try
    if (AState = dbmInsert) and (AItem.PkTypeMoviment = 0) then
      GetPkMoviment;
    qrTipoMovim.ParamByName('PkTipoMovimEstq').AsInteger := AItem.PkTypeMoviment;
    if qrTipoMovim.Params.FindParam('FkTipoMovimEstq') <> nil then
      qrTipoMovim.ParamByName('FkTipoMovimEstq').AsInteger := AItem.FkTypeMoviment;
    if qrTipoMovim.Params.FindParam('DscTMov') <> nil then
      qrTipoMovim.ParamByName('DscTMov').AsString := AItem.DscMov;
    if qrTipoMovim.Params.FindParam('FlagTBaixa') <> nil then
      qrTipoMovim.ParamByName('FlagTBaixa').AsInteger := Ord(AItem.FlagLocMov);
    if qrTipoMovim.Params.FindParam('FlagTMov') <> nil then
      qrTipoMovim.ParamByName('FlagTMov').AsInteger := Ord(AItem.FlagTMov);
    if qrTipoMovim.Params.FindParam('FlagTCod') <> nil then
      qrTipoMovim.ParamByName('FlagTCod').AsInteger := Ord(AItem.FlagCode);
    if qrTipoMovim.Params.FindParam('FlagGenHst') <> nil then
      qrTipoMovim.ParamByName('FlagGenHst').AsInteger := Ord(AItem.FlagGenHst);
    if qrTipoMovim.Params.FindParam('FlagOpEstq') <> nil then
      qrTipoMovim.ParamByName('FlagOpEstq').AsInteger := Ord(AItem.FlagOper[etReal]);
    if qrTipoMovim.Params.FindParam('FlagMvEstq') <> nil then
      qrTipoMovim.ParamByName('FlagMvEstq').AsInteger := Ord(AItem.FlagMov[etReal]);
    if qrTipoMovim.Params.FindParam('FlagOpRsrv') <> nil then
      qrTipoMovim.ParamByName('FlagOpRsrv').AsInteger := Ord(AItem.FlagOper[etReserved]);
    if qrTipoMovim.Params.FindParam('FlagMvRsrv') <> nil then
      qrTipoMovim.ParamByName('FlagMvRsrv').AsInteger := Ord(AItem.FlagMov[etReserved]);
    if qrTipoMovim.Params.FindParam('FlagOpGrnt') <> nil then
      qrTipoMovim.ParamByName('FlagOpGrnt').AsInteger := Ord(AItem.FlagOper[etGiveBack]);
    if qrTipoMovim.Params.FindParam('FlagMvGrnt') <> nil then
      qrTipoMovim.ParamByName('FlagMvGrnt').AsInteger := Ord(AItem.FlagMov[etGiveBack]);
    if qrTipoMovim.Params.FindParam('FlagOpQrnt') <> nil then
      qrTipoMovim.ParamByName('FlagOpQrnt').AsInteger := Ord(AItem.FlagOper[etQuarentine]);
    if qrTipoMovim.Params.FindParam('FlagMvQrnt') <> nil then
      qrTipoMovim.ParamByName('FlagMvQrnt').AsInteger := Ord(AItem.FlagMov[etQuarentine]);
    qrTipoMovim.ExecSQL;
    Dados.CommitTransaction(qrTipoMovim);
  except on E:Exception do
    begin
      if qrTipoMovim.Active then qrTipoMovim.Close;
      Dados.RollbackTransaction(qrTipoMovim);
      raise Exception.Create('UpdateProductSuppliers: ' + E.Message +
        qrTipoMovim.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.LoadAlmox: TStrings;
begin
  Result := TStringList.Create;
  if (qrAlmox.Active) then qrAlmox.Close;
  qrAlmox.SQL.Clear;
  qrAlmox.SQL.Add(SqlAlmoxarifados);
  Dados.StartTransaction(qrAlmox);
  qrAlmox.Open;
  try
    qrAlmox.First;
    Result.Add('<Nenhum>');
    while (not qrAlmox.Eof) do
    begin
      Result.AddObject(qrAlmox.FindField('DSC_ALMX').AsString,
        TObject(qrAlmox.FindField('PK_ALMOXARIFADOS').AsInteger));
      qrAlmox.Next;
    end;
  finally
    if (qrAlmox.Active) then qrAlmox.Close;
    Dados.CommitTransaction(qrAlmox);
  end;
end;

procedure TdmSysEstq.UpdateProductImage(APk: Integer; APicture: TGraphic; AState: TDBMode);
var
  M: TMemoryStream;
begin
  if (APk <= 0) then exit;
  if ProdutoImg.Active then ProdutoImg.Close;
  ProdutoImg.SQL.Clear;
  if (AState = dbmInsert) then
    ProdutoImg.SQL.Add(SqlPrdInsertImg)
  else
    ProdutoImg.SQL.Add(SqlPrdUpdateImg);
  M := TMemoryStream.Create;
  try
    ProdutoImg.Params.FindParam('FkProdutos').AsInteger := APk;
    APicture.SaveToStream(M);
    M.Position := 0;
    ProdutoImg.ParamByName('FlagTImg').AsInteger := Ord(GetTypeImage(M));
    M.Position := 0;
    ProdutoImg.ParamByName('ImgProd').LoadFromStream(M, ftBlob);
    ProdutoImg.ExecSQL;
  finally
    if ProdutoImg.Active then ProdutoImg.Close;
    FreeAndNil(M);
  end;
end;

procedure TdmSysEstq.UpdateProductObs(APk: Integer; ALines: TStrings; AState: TDBMode);
var
  M: TStream;
begin
  if (APk <= 0) then exit;
  if ProdutoImg.Active then ProdutoImg.Close;
  ProdutoImg.SQL.Clear;
  if (AState = dbmInsert) then
    ProdutoImg.SQL.Add(SqlPrdInsertObs)
  else
    ProdutoImg.SQL.Add(SqlPrdUpdateObs);
  M := TMemoryStream.Create;
  try
    ProdutoImg.Params.FindParam('FkProdutos').AsInteger := APk;
    ALines.SaveToStream(M);
    M.Position := 0;
    ProdutoImg.ParamByName('CrtProd').LoadFromStream(M, ftBlob);
    ProdutoImg.ExecSQL;
  finally
    if ProdutoImg.Active then ProdutoImg.Close;
    FreeAndNil(M);
  end;
end;

function TdmSysEstq.GetLine(const APk: Integer): TLines;
begin
  Result := TLines.Create;
  if (APk = 0) then exit;
  if (qrLinha.Active) then qrLinha.Close;
  qrLinha.SQL.Clear;
  qrLinha.SQL.Add(SqlLinha);
  Dados.StartTransaction(qrLinha);
  try
    qrLinha.ParamByName('PkLinhas').AsInteger := APk;
    if (not qrLinha.Active) then qrLinha.Open;
    Result.PkLines         := APk;
    Result.DscLin          := qrLinha.FieldByName('DSC_LIN').AsString;
    Result.FkTypeComission := qrLinha.FieldByName('FK_TIPO_COMISSOES').AsInteger;
  finally
    if (qrLinha.Active) then qrLinha.Close;
    Dados.CommitTransaction(qrLinha);
  end;
end;

function  TdmSysEstq.SaveLine(const AItem: TLines; AState: TDBMode): Integer;
  function GetPkLine: Integer;
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkLine);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_LINHAS').AsInteger;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
    end;
  end;
begin
  Result := 0;
  if (AItem = nil) then exit;
  if (qrLinha.Active) then qrLinha.Close;
  qrLinha.SQL.Clear;
  case AState of
    dbmInsert: qrLinha.SQL.Add(SqlInsertLinha);
    dbmEdit  : qrLinha.SQL.Add(SqlUpdateLinha);
    dbmDelete: qrLinha.SQL.Add(SqlDeleteLinha);
  end;
  
  Dados.StartTransaction(qrLinha);
  try
    if (AItem.PkLines = 0) then
      Result := GetPkLine
    else
      Result := AItem.PkLines;
    qrLinha.ParamByName('PkLinhas').AsInteger := Result;
    if (qrLinha.Params.FindParam('DscLin') <> nil) then
      qrLinha.ParamByName('DscLin').AsString  := AItem.DscLin;
    if (qrLinha.Params.FindParam('FkTipoComissoes') <> nil) then
      qrLinha.ParamByName('FkTipoComissoes').AsFloat := AItem.FkTypeComission;
    qrLinha.ExecSQL;
    Dados.CommitTransaction(qrLinha);
  except on E:Exception do
    begin
      if (qrLinha.Active) then qrLinha.Close;
      Dados.RollbackTransaction(qrLinha);
      raise Exception.Create('SaveLine: Erro ao salvar o registro ' + NL +
        E.Message + NL + qrLinha.SQL.Text);
    end;
  end;
end;

function  TdmSysEstq.GetSimilar(APk: Integer): TDataRow;
begin
  if (qrSimilar.Active) then qrSimilar.Close;
  qrSimilar.SQL.Clear;
  qrSimilar.SQL.Add(SqlSimilar);
  Dados.StartTransaction(qrSimilar);
  try
    qrSimilar.ParamByName('PkSimilares').AsInteger := APk;
    if (not qrSimilar.Active) then qrSimilar.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrSimilar, True);
  finally
    if (qrSimilar.Active) then qrSimilar.Close;
    Dados.CommitTransaction(qrSimilar);
  end;
end;

procedure TdmSysEstq.SetSimilar(APk: Integer; const Value: TDataRow);
  function GetPkSimilar: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkSimilar);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_SIMILARES').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (qrSimilar.Active) then qrSimilar.Close;
  qrSimilar.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrSimilar.SQL.Add(SqlDeleteSimilar);
    dbmInsert: qrSimilar.SQL.Add(SqlInsertSimilar);
    dbmEdit  : qrSimilar.SQL.Add(SqlUpdateSimilar);
  end;
  Dados.StartTransaction(qrSimilar);
  try
    if (Value.FieldByName['PK_SIMILARES'].AsInteger <= 0) then
      Value.FieldByName['PK_SIMILARES'].AsInteger := GetPkSimilar;
    qrSimilar.ParamByName('PkSimilares').AsInteger := Value.FieldByName['PK_SIMILARES'].AsInteger;
    if (qrSimilar.Params.FindParam('DscSim') <> nil) then
      qrSimilar.ParamByName('DscSim').AsString     := Value.FieldByName['DSC_SIM'].AsString;
    qrSimilar.ExecSQL;
    Dados.CommitTransaction(qrSimilar);
  except on E:Exception do
    begin
      if (qrSimilar.Active) then qrSimilar.Close;
      Dados.RollbackTransaction(qrSimilar);
      raise Exception.Create('SetSimilar: Erro ao gravar registro ' + NL +
        E.Message + NL + qrSimilar.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.GetTypeSitSupply(APk: Integer): TDataRow;
begin
  if qrTSitProd.Active then qrTSitProd.Close;
  qrTSitProd.SQL.Clear;
  qrTSitProd.SQL.Add(SqlTipoSitEstq);
  Dados.StartTransaction(qrTSitProd);
  try
    qrTSitProd.ParamByName('PkTipoSituacaoEstoques').AsInteger := APk;
    if (not qrTSitProd.Active) then qrTSitProd.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTSitProd, True);
  finally
    if qrTSitProd.Active then qrTSitProd.Close;
    Dados.CommitTransaction(qrTSitProd);
  end;
end;

procedure TdmSysEstq.SetTypeSitSupply(APk: Integer; const Value: TDataRow);
  function GetPkTypeSitSupply: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkTypeSitSupply);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_TIPO_SITUACAO_ESTOQUES').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (qrTSitProd.Active) then qrTSitProd.Close;
  qrTSitProd.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTSitProd.SQL.Add(SqlDeleteTSitProd);
    dbmInsert: qrTSitProd.SQL.Add(SqlInsertTSitProd);
    dbmEdit  : qrTSitProd.SQL.Add(SqlUpdateTSitProd);
  end;
  Dados.StartTransaction(qrTSitProd);
  try
    if (Value.FieldByName['PK_TIPO_SITUACAO_ESTOQUES'].AsInteger <= 0) then
      Value.FieldByName['PK_TIPO_SITUACAO_ESTOQUES'].AsInteger := GetPkTypeSitSupply;
    qrTSitProd.ParamByName('PkTipoSituacaoEstoques').AsInteger := Value.FieldByName['PK_TIPO_SITUACAO_ESTOQUES'].AsInteger;
    if (qrTSitProd.Params.FindParam('DscTse') <> nil) then
      qrTSitProd.ParamByName('DscTse').AsString     := Value.FieldByName['DSC_TSE'].AsString;
    if (qrTSitProd.Params.FindParam('FlagBloq') <> nil) then
      qrTSitProd.ParamByName('FlagBloq').AsInteger  := Value.FieldByName['FLAG_BLOQ'].AsInteger;
    qrTSitProd.ExecSQL;
    Dados.CommitTransaction(qrTSitProd);
  except on E:Exception do
    begin
      if (qrTSitProd.Active) then qrTSitProd.Close;
      Dados.RollbackTransaction(qrTSitProd);
      raise Exception.Create('SetTypeSitSupply: Erro ao gravar registro ' + NL +
        E.Message + NL + qrTSitProd.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.GetTypeProduct(APk: Integer): TDataRow;
begin
  if qrTipoProd.Active then qrTipoProd.Close;
  qrTipoProd.SQL.Clear;
  qrTipoProd.SQL.Add(SqlTypeProduct);
  Dados.StartTransaction(qrTipoProd);
  try
    qrTipoProd.ParamByName('PkTipoProdutos').AsInteger := APk;
    if (not qrTipoProd.Active) then qrTipoProd.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTipoProd, True);
  finally
    if qrTipoProd.Active then qrTipoProd.Close;
    Dados.CommitTransaction(qrTipoProd);
  end;
end;

procedure TdmSysEstq.SetTypeProduct(APk: Integer; const Value: TDataRow);
  function GetPkTypeProduct: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkTipoProd);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_TIPO_PRODUTOS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (qrTipoProd.Active) then qrTipoProd.Close;
  qrTipoProd.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTipoProd.SQL.Add(SqlDeleteTypeProduct);
    dbmInsert: qrTipoProd.SQL.Add(SqlInsertTypeProduct);
    dbmEdit  : qrTipoProd.SQL.Add(SqlUpdateTypeProduct);
  end;
  Dados.StartTransaction(qrTipoProd);
  try
    if (Value.FieldByName['PK_TIPO_PRODUTOS'].AsInteger <= 0) then
      Value.FieldByName['PK_TIPO_PRODUTOS'].AsInteger := GetPkTypeProduct;
    qrTipoProd.ParamByName('PkTipoProdutos').AsInteger := Value.FieldByName['PK_TIPO_PRODUTOS'].AsInteger;
    if (qrTipoProd.Params.FindParam('DscTPrd') <> nil) then
      qrTipoProd.ParamByName('DscTPrd').AsString     := Value.FieldByName['DSC_TPRD'].AsString;
    if (qrTipoProd.Params.FindParam('FlagTProd') <> nil) then
      qrTipoProd.ParamByName('FlagTProd').AsInteger  := Value.FieldByName['FLAG_TPROD'].AsInteger;
    if (qrTipoProd.Params.FindParam('FkFinanceiroContasSaidas') <> nil) then
      qrTipoProd.ParamByName('FkFinanceiroContasSaidas').AsInteger  := Value.FieldByName['FK_FINANCEIRO_CONTAS_SAIDAS'].AsInteger;
    if (qrTipoProd.Params.FindParam('FkFinanceiroContasEntradas') <> nil) then
      qrTipoProd.ParamByName('FkFinanceiroContasEntradas').AsInteger  := Value.FieldByName['FK_FINANCEIRO_CONTAS_ENTRADAS'].AsInteger;
    qrTipoProd.ExecSQL;
    Dados.CommitTransaction(qrTipoProd);
  except on E:Exception do
    begin
      if (qrTipoProd.Active) then qrTipoProd.Close;
      Dados.RollbackTransaction(qrTipoProd);
      raise Exception.Create('SetTypeProduct: Erro ao gravar registro ' + NL +
        E.Message + NL + qrTipoProd.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.GetUnits(APk: Integer): TUnit;
begin
  if qrUnit.Active then qrUnit.Close;
  qrUnit.SQL.Clear;
  qrUnit.SQL.Add(SqlUnidade);
  Dados.StartTransaction(qrUnit);
  try
    qrUnit.ParamByName('PkUnidades').AsInteger := APk;
    if (not qrUnit.Active) then qrUnit.Open;
    Result          := TUnit.Create;
    Result.PkUnit   := qrUnit.FieldByName('PK_UNIDADES').AsInteger;
    Result.DscUni   := qrUnit.FieldByName('DSC_UNI').AsString;
    Result.MnmoUni  := qrUnit.FieldByName('MNMO_UNI').AsString;
    Result.FlagFrac := (qrUnit.FieldByName('FLAG_FRAC').AsInteger = 1);
    Result.FlagAlt  := (qrUnit.FieldByName('FLAG_ALT').AsInteger = 1);
    Result.FlagLarg := (qrUnit.FieldByName('FLAG_LARG').AsInteger = 1);
    Result.FlagComp := (qrUnit.FieldByName('FLAG_COMP').AsInteger = 1);
    Result.FlagQtd  := (qrUnit.FieldByName('FLAG_QTD').AsInteger = 1);
    Result.FlagFUni := qrUnit.FieldByName('FLAG_FUNI').AsInteger;
    Result.FlagTUni := qrUnit.FieldByName('FLAG_TUNI').AsInteger;
  finally
    if qrUnit.Active then qrUnit.Close;
    Dados.CommitTransaction(qrUnit);
  end;
end;

procedure TdmSysEstq.SetUnits(APk: Integer; const Value: TUnit);
  function GetPkUnit: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkUnit);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_UNIDADES').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (qrTipoProd.Active) then qrTipoProd.Close;
  qrTipoProd.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTipoProd.SQL.Add(SqlDeleteUnit);
    dbmInsert: qrTipoProd.SQL.Add(SqlInsertUnit);
    dbmEdit  : qrTipoProd.SQL.Add(SqlUpdateUnit);
  end;
  Dados.StartTransaction(qrUnit);
  try
    if (Value.PkUnit <= 0) then Value.PkUnit := GetPkUnit;
    qrTipoProd.ParamByName('PkUnidades').AsInteger := Value.PkUnit;
    if (qrTipoProd.Params.FindParam('DscUni') <> nil) then
      qrTipoProd.ParamByName('DscUni').AsString     := Value.DscUni;
    if (qrTipoProd.Params.FindParam('MnmoUni') <> nil) then
      qrTipoProd.ParamByName('MnmoUni').AsString    := Value.MnmoUni;
    if (qrTipoProd.Params.FindParam('FlagFrac') <> nil) then
      qrTipoProd.ParamByName('FlagFrac').AsInteger  := Ord(Value.FlagFrac);
    if (qrTipoProd.Params.FindParam('FlagAlt') <> nil) then
      qrTipoProd.ParamByName('FlagAlt').AsInteger   := Ord(Value.FlagAlt);
    if (qrTipoProd.Params.FindParam('FlagLarg') <> nil) then
      qrTipoProd.ParamByName('FlagLarg').AsInteger  := Ord(Value.FlagLarg);
    if (qrTipoProd.Params.FindParam('FlagComp') <> nil) then
      qrTipoProd.ParamByName('FlagComp').AsInteger  := Ord(Value.FlagComp);
    if (qrTipoProd.Params.FindParam('FlagQtd') <> nil) then
      qrTipoProd.ParamByName('FlagQtd').AsInteger   := Ord(Value.FlagQtd);
    if (qrTipoProd.Params.FindParam('FlagFUni') <> nil) then
      qrTipoProd.ParamByName('FlagFUni').AsInteger  := Value.FlagFUni;
    if (qrTipoProd.Params.FindParam('FlagTUni') <> nil) then
      qrTipoProd.ParamByName('FlagTUni').AsInteger  := Value.FlagTUni;
    qrTipoProd.ExecSQL;
    Dados.CommitTransaction(qrUnit);
  except on E:Exception do
    begin
      if (qrTipoProd.Active) then qrTipoProd.Close;
      Dados.RollbackTransaction(qrUnit);
      raise Exception.Create('SetTypeProduct: Erro ao gravar registro ' + NL +
        E.Message + NL + qrTipoProd.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.GetParamEstq(APk: Integer): TDataRow;
begin
  with qrParamEstq do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlParamEstq);
    Dados.StartTransaction(qrParamEstq);
    try
      ParamByName('FkEmpresas').AsInteger := APk;
      if (not Active) then Open;
      Result := TDataRow.CreateFromDataSet(nil, qrParamEstq, True);
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrParamEstq);
    end;
  end;
end;

procedure TdmSysEstq.SetParamEstq(APk: Integer; const Value: TDataRow);
var
  aStr: string;
begin
  with qrParamEstq do
  begin
    if (Active) then Close;
    SQL.Clear;
    case TDBMode(APk) of
      dbmInsert: aStr := SqlInsertParamEstq;
      dbmEdit  : aStr := SqlUpdateParamEstq;
      dbmDelete: aStr := SqlDeleteParamEstq;
    end;
    if (Value.FieldByName['FK_ALMOXARIFADOS'].AsInteger = 0) then
      aStr := StringReplace(aStr, ':FkAlmoxarifados', 'null', [rfReplaceAll]);
    SQL.Add(aStr);
    Dados.StartTransaction(qrParamEstq);
    try
      ParamByName('FkEmpresas').AsInteger           := Value.FieldByName['FK_EMPRESAS'].AsInteger;
      if (Params.FindParam('FkAlmoxarifados') <> nil) then
        ParamByName('FkAlmoxarifados').AsInteger    := Value.FieldByName['FK_ALMOXARIFADOS'].AsInteger;
      if (Params.FindParam('FkTipoMovmEstqEntr') <> nil) then
        ParamByName('FkTipoMovmEstqEntr').AsInteger := Value.FieldByName['FK_TIPO_MOVIM_ESTQ__ENTR'].AsInteger;
      if (Params.FindParam('FkTipoMovmEstqSai') <> nil) then
        ParamByName('FkTipoMovmEstqSai').AsInteger  := Value.FieldByName['FK_TIPO_MOVIM_ESTQ__SAI'].AsInteger;
      if (Params.FindParam('FkTabelaPrecos') <> nil) then
        ParamByName('FkTabelaPrecos').AsInteger     := Value.FieldByName['FK_TABELA_PRECOS'].AsInteger;
      if (Params.FindParam('FlagTMrgm') <> nil) then
        ParamByName('FlagTMrgm').AsInteger          := Value.FieldByName['FLAG_TMRGM'].AsInteger;
      if (Params.FindParam('FlagTCusto') <> nil) then
        ParamByName('FlagTCusto').AsInteger         := Value.FieldByName['FLAG_TCUSTO'].AsInteger;
      if (Params.FindParam('FlagTAcabm') <> nil) then
        ParamByName('FlagTAcabm').AsInteger         := Value.FieldByName['FLAG_TACABM'].AsInteger;
      if (Params.FindParam('MrgDef') <> nil) then
        ParamByName('MrgDef').AsFloat               := Value.FieldByName['MRG_DEF'].AsFloat;
      ExecSQL;
      Dados.CommitTransaction(qrParamEstq);
    except on E:Exception do
      begin
        if (Active) then Close;
        Dados.RollbackTransaction(qrParamEstq);
        raise Exception.Create('SetParamsPed: Erro ao gravar registro!' + NL +
          E.Message + NL + Sql.Text);
      end;
    end;
  end;
end;

function TdmSysEstq.GetGroups(APk: Integer): TGroups;
begin
  with qrGroup do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlSelectGroup);
    Dados.StartTransaction(qrGroup);
    try
      ParamByName('PkProdutosGrupos').AsInteger := APk;
      if (not Active) then Open;
      Result.Group               := TClassification.Create;
      Result.Group.Pk            := FieldByName('PK_PRODUTOS_GRUPOS').AsInteger;
      Result.Group.FkAccountPlan := FieldByName('FK_PRODUTOS_GRUPOS').AsInteger;
      Result.Group.DscClass      := FieldByName('DSC_PGRU').AsString;
      Result.Group.SeqCta        := FieldByName('SEQ_CLASS').AsInteger;
      Result.Group.FlagAnlSnt    := Boolean(FieldByName('FLAG_LAST_LEVEL').AsInteger);
      Result.Group.MaskCta       := FieldByName('MASK_CLASS').AsString;
      Result.Group.NivCta        := FieldByName('LEV_CLASS').AsInteger;
      Result.DsctProd            := FieldByName('DSCT_PROD').AsFloat;
      Result.MrgmRef             := FieldByName('MRGM_REF').AsFloat;
      Result.ComSGru             := FieldByName('COM_SGRU').AsFloat;
      Result.CodGRef             := FieldByName('COD_GREF').AsString;
      Result.SeqRef              := FieldByName('SEQ_REF').AsInteger;
    finally
      if (Active) then Close;
      Dados.CommitTransaction(qrGroup);
    end;
  end;
end;

procedure TdmSysEstq.SetGroups(APk: Integer; const Value: TGroups);
begin
  if (Value.Group <> nil) then Group[APk] := Value.Group;
  if qrSubGroup.Active then qrSubGroup.Close;
  qrSubGroup.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrSubGroup.SQL.Add(SqlDeleteProdRef);
    dbmEdit  : qrSubGroup.SQL.Add(SqlUpdateProdRef);
    dbmInsert: qrSubGroup.SQL.Add(SqlInsertProdRef);
  end;
  Dados.StartTransaction(qrSubGroup);
  try
    with qrSubGroup, Value do
    begin
      ParamByName('FkProdutosGrupos').AsInteger := Group.Pk;
      if (Params.FindParam('DsctProd')          <> nil) then
        ParamByName('DsctProd').AsFloat         := DsctProd;
      if (Params.FindParam('MrgmRef')           <> nil) then
        ParamByName('MrgmRef').AsFloat          := MrgmRef;
      if (Params.FindParam('ComSGru')           <> nil) then
        ParamByName('ComSGru').AsFloat          := ComSGru;
      if (Params.FindParam('CodGRef')           <> nil) then
        ParamByName('CodGRef').AsString         := CodGRef;
      if (Params.FindParam('SeqRef')            <> nil) then
        ParamByName('SeqRef').AsInteger         := SeqRef;
    end;
    qrSubGroup.ExecSQL;
    Dados.CommitTransaction(qrSubGroup);
  except on E:Exception do
    begin
      if qrSubGroup.Active then qrSubGroup.Close;
      Dados.RollbackTransaction(qrSubGroup);
      raise Exception.Create('SetSubGroup: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrSubGroup.SQL.Text);
    end;
  end;
end;

procedure TdmSysEstq.SetGroup(APk: Integer; const Value: TClassification);
begin
  if qrGroup.Active then qrGroup.Close;
  qrGroup.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrGroup.SQL.Add(SqlDeleteGroup);
    dbmEdit  : qrGroup.SQL.Add(SqlUpdateGroup);
    dbmInsert: qrGroup.SQL.Add(SqlInsertGroup);
  end;
  Dados.StartTransaction(qrGroup);
  try
    with qrGroup, Value do
    begin
      if (Pk = 0) then
        Pk := Dados.GetPk(SqlGenPkGroup, nil).FieldByName['PK_PRODUTOS_GRUPOS'].AsInteger;
      ParamByName('PkProdutosGrupos').AsInteger   := Pk;
      if (NivCta = 1) then
        FkAccountPlan := Pk;
      if (Params.FindParam('FkProdutosGrupos')    <> nil) then
        ParamByName('FkProdutosGrupos').AsInteger := FkFinanceAccount;
      if (Params.FindParam('DscPGru')             <> nil) then
        ParamByName('DscPGru').AsString           := DscClass;
      if (Params.FindParam('FlagLastLevel')       <> nil) then
        ParamByName('FlagLastLevel').AsInteger    := Ord(FlagAnlSnt);
      if (Params.FindParam('MaskClass')           <> nil) then
        ParamByName('MaskClass').AsString         := MaskCta;
      if (Params.FindParam('LevClass')            <> nil) then
        ParamByName('LevClass').AsInteger         := NivCta;
      if (Params.FindParam('SeqClass')            <> nil) then
        ParamByName('SeqClass').AsInteger         := SeqCta;
    end;
    qrGroup.ExecSQL;
    Dados.CommitTransaction(qrGroup);
  except on E:Exception do
    begin
      if qrGroup.Active then qrGroup.Close;
      Dados.RollbackTransaction(qrGroup);
      raise Exception.Create('SetGroup: Erro ao gravar o registro!' + NL +
        E.Message + NL + qrGroup.SQL.Text);
    end;
  end;
end;

procedure TdmSysEstq.SetTipoProdNatOper(var AData: TDataRow);
begin
  if (AData = nil) or (AData.FieldByName['STATE'].AsInteger = -1) then exit;
  with qrTipoProd do
  begin
    if (Active) then Close;
    SQL.Clear;
    case TDBMode(AData.FieldByName['STATE'].AsInteger) of
      dbmInsert: SQL.Add(SqlInsertCfops);
      dbmDelete: SQL.Add(SqlDeleteCfops);
    end;
    Dados.StartTransaction(qrTipoProd);
    try
      ParamByName('FkTipoProdutos').AsInteger      := AData.FieldByName['FK_TIPO_PRODUTOS'].AsInteger;
      ParamByName('FkTipoCfop').AsInteger          := AData.FieldByName['PK_TIPO_CFOP'].AsInteger;
      ParamByName('FkNaturezaOperacoes').AsInteger := AData.FieldByName['PK_NATUREZA_OPERACOES'].AsInteger;
      ExecSQL;
      Dados.CommitTransaction(qrTipoProd);
      AData.FieldByName['STATE'].AsInteger         := -1;
    except on E:Exception do
      begin
        if (Active) then Close;
        Dados.RollbackTransaction(qrTipoProd);
        raise Exception.Create('SetTipoProdNatOper: Erro ao gravar o registro!' + NL +
          E.Message + NL + SQL.Text);
      end;
    end;
  end;
end;

procedure TdmSysEstq.SetAccounts(APk: Integer; const Value: TDataRow);
begin
  with qrGrpAcc do
  begin
    if (Active) then Close;
    SQL.Clear;
    if (Value = nil) then
      SQL.Add(SqlDeleteAccounts)
    else
      SQL.Add(SqlInsertAccounts);
    Dados.StartTransaction(qrGrpAcc);
    try
      if (Value = nil) then
        ParamByName('FkProdutosGrupos').AsInteger    := APk
      else
        ParamByName('FkProdutosGrupos').AsInteger    := Value.FieldByName['FK_PRODUTOS_GRUPOS'].AsInteger;
      if (Params.FindParam('FkTipoCfop') <> nil) then
        ParamByName('FkTipoCfop').AsInteger          := Value.FieldByName['FK_TIPO_CFOP'].AsInteger;
      if (Params.FindParam('FkNaturezaOperacoes') <> nil) then
        ParamByName('FkNaturezaOperacoes').AsInteger := Value.FieldByName['PK_NATUREZA_OPERACOES'].AsInteger;
      if (Params.FindParam('FkFinanceiroContas') <> nil) then
        ParamByName('FkFinanceiroContas').AsInteger  := Value.FieldByName['PK_FINANCEIRO_CONTAS'].AsInteger;
      ExecSQL;
      if (Active) then Close;
      Dados.CommitTransaction(qrGrpAcc);
    except on E:Exception do
      begin
        if (Active) then Close;
        Dados.RollbackTransaction(qrGrpAcc);
        raise Exception.Create('SetAccounts: Erro ao gravar o registro!' + NL +
          E.Message + NL + SQL.Text);
      end;
    end;
  end;
end;

function TdmSysEstq.GetAccounts(APk: Integer): TDataRow;
begin
  with qrGrpAcc do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlGroupAccounts);
    try
      ParamByName('FkProdutosGrupos').AsInteger := APk;
      if (not Active) then Open;
      Result := TDataRow.CreateFromDataSet(nil, qrGrpAcc, True);
    finally
      if Active then Close;
    end
  end;
end;

function TdmSysEstq.GetPriceTable(APk: Integer): TPriceTable;
begin
  Result := TPriceTable.Create(nil);
  if (APk <= 0) then exit;
  if (qrTabPrice.Active) then qrTabPrice.Close;
  qrTabPrice.SQL.Clear;
  qrTabPrice.SQL.Add(SqlPriceTable);
  Dados.StartTransaction(qrTabPrice);
  try
    qrTabPrice.ParamByName('PkTabelaPrecos').AsInteger := APk;
    if (not qrTabPrice.Active) then qrTabPrice.Open;
    if (not qrTabPrice.IsEmpty) then
    begin
      Result.PkPriceTable := APk;
      Result.DscTab       := qrTabPrice.FieldByName('DSC_TAB').AsString;
      Result.DtaIni       := qrTabPrice.FieldByName('DTA_INI').AsDateTime;
      Result.DtaFin       := qrTabPrice.FieldByName('DTA_FIN').AsDateTime;
      Result.PercDsct     := qrTabPrice.FieldByName('PERC_DSCT').AsFloat;
      Result.FlagDefTab   := (qrTabPrice.FieldByName('FLAG_DEFTAB').AsInteger = 1);
    end;
  finally
    if (qrTabPrice.Active) then qrTabPrice.Close;
    Dados.CommitTransaction(qrTabPrice);
  end;
end;

procedure TdmSysEstq.SetPriceTable(APk: Integer; const Value: TPriceTable);
  function GetPkTabPrice: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenPkTabPrice);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_TABELA_PRECOS').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (Value = nil) then exit;
  if (qrTabPrice.Active) then qrTabPrice.Close;
  qrTabPrice.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTabPrice.SQL.Add(SqlDeletePriceTable);
    dbmInsert: qrTabPrice.SQL.Add(SqlInsertPriceTable);
    dbmEdit  : qrTabPrice.SQL.Add(SqlUpdatePriceTable);
  end;
  Dados.StartTransaction(qrTabPrice);
  try
    if (Value.PkPriceTable = 0) then
      Value.PkPriceTable := GetPkTabPrice;
    qrTabPrice.ParamByName('PkTabelaPrecos').AsInteger := Value.PkPriceTable;
    if (qrTabPrice.Params.FindParam('DscTab') <> nil) then
      qrTabPrice.ParamByName('DscTab').AsString        := Value.DscTab;
    if (qrTabPrice.Params.FindParam('DtaIni') <> nil) then
      qrTabPrice.ParamByName('DtaIni').AsDate          := Value.DtaIni;
    if (qrTabPrice.Params.FindParam('DtaFin') <> nil) then
      qrTabPrice.ParamByName('DtaFin').AsDate          := Value.DtaFin;
    if (qrTabPrice.Params.FindParam('FlagDefTab') <> nil) then
      qrTabPrice.ParamByName('FlagDefTab').AsInteger   := Ord(Value.FlagDefTab);
    if (qrTabPrice.Params.FindParam('PercDsct') <> nil) then
      qrTabPrice.ParamByName('PercDsct').AsFloat       := Value.PercDsct;
    qrTabPrice.ExecSQL;
    Dados.CommitTransaction(qrTabPrice);
  except on E:Exception do
    begin
      if (qrTabPrice.Active) then qrTabPrice.Close;
      Dados.RollbackTransaction(qrTabPrice);
      raise Exception.Create('SetPriceTable: Erro ao gravar registro ' + NL +
        E.Message + NL + qrTabPrice.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.GetTableRegion(APk: Integer): TDataRow;
begin
  Result := nil;
  if (APk <= 0) then exit;
  if (qrTableRegion.Active) then qrTableRegion.Close;
  qrTableRegion.SQL.Clear;
  qrTableRegion.SQL.Add(SqlTableRegion);
  Dados.StartTransaction(qrTableRegion);
  try
    qrTableRegion.ParamByName('PkTabelaOrigemDestino').AsInteger := APk;
    if (not qrTableRegion.Active) then qrTableRegion.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTableRegion, True);
  finally
    if (qrTableRegion.Active) then qrTableRegion.Close;
    Dados.CommitTransaction(qrTableRegion);
  end;
end;

procedure TdmSysEstq.SetTableRegion(APk: Integer; const Value: TDataRow);
  function GetPkCalcRegion: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenTableRegion);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_TABELA_ORIGEM_DESTINO').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  if (qrTableRegion.Active) then qrTableRegion.Close;
  qrTableRegion.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTableRegion.SQL.Add(SqlDeleteTableRegion);
    dbmInsert: qrTableRegion.SQL.Add(SqlInsertTableRegion);
    dbmEdit  : qrTableRegion.SQL.Add(SqlUpdateTableRegion);
  end;
  Dados.StartTransaction(qrTableRegion);
  try
    if (Value.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger = 0) and
       (TDBMode(APK) = dbmInsert) then
      Value.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger   := GetPkCalcRegion;
    qrTableRegion.ParamByName('PkTabelaOrigemDestino').AsInteger  := Value.FieldByName['PK_TABELA_ORIGEM_DESTINO'].AsInteger;
    if (qrTableRegion.Params.FindParam('FkCargasRegioesOrg') <> nil) then
      qrTableRegion.ParamByName('FkCargasRegioesOrg').AsInteger   := Value.FieldByName['FK_CARGAS_REGIOES__ORG'].AsInteger;
    if (qrTableRegion.Params.FindParam('FkCargasRegioesDst') <> nil) then
      qrTableRegion.ParamByName('FkCargasRegioesDst').AsInteger   := Value.FieldByName['FK_CARGAS_REGIOES__DST'].AsInteger;
    if (qrTableRegion.Params.FindParam('FkTipoTabelaFracao') <> nil) then
      qrTableRegion.ParamByName('FkTipoTabelaFracao').AsInteger   := Value.FieldByName['FK_TIPO_TABELA_FRACAO'].AsInteger;
    if (qrTableRegion.Params.FindParam('FkTipoPrazoEntrega') <> nil) then
      qrTableRegion.ParamByName('FkTipoPrazoEntrega').AsInteger   := Value.FieldByName['FK_TIPO_PRAZO_ENTREGA'].AsInteger;
    if (qrTableRegion.Params.FindParam('VlrMin') <> nil) then
      qrTableRegion.ParamByName('VlrMin').AsFloat                 := Value.FieldByName['VLR_MIN'].AsFloat;
    qrTableRegion.ExecSQL;
    Dados.CommitTransaction(qrTableRegion);
  except on E:Exception do
    begin
      if (qrTableRegion.Active) then qrTableRegion.Close;
      Dados.RollbackTransaction(qrTableRegion);
      raise Exception.Create('SetCalcRegion: Erro ao gravar registro ' + NL +
        E.Message + NL + qrTableRegion.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.GetTypeFraction(APk: Integer): TDataRow;
begin
  Result := nil;
  if (APk <= 0) then exit;
  if (qrTypeFraction.Active) then qrTypeFraction.Close;
  qrTypeFraction.SQL.Clear;
  qrTypeFraction.SQL.Add(SqlTypeFraction);
  Dados.StartTransaction(qrTypeFraction);
  try
    qrTypeFraction.ParamByName('PkTipoTabelaFracao').AsInteger := APk;
    if (not qrTypeFraction.Active) then qrTypeFraction.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTypeFraction, True);
  finally
    if (qrTypeFraction.Active) then qrTypeFraction.Close;
    Dados.CommitTransaction(qrTypeFraction);
  end;
end;

procedure TdmSysEstq.SetTypeFraction(APk: Integer; const Value: TDataRow);
  function GetPkTypeFraction: Integer;
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGenTypeFraction);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := qrSqlAux.FieldByName('PK_TIPO_TABELA_FRACAO').AsInteger;
      if (Result = 0) then Result := 1;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  if (qrTypeFraction.Active) then qrTypeFraction.Close;
  qrTypeFraction.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTypeFraction.SQL.Add(SqlDeleteTypeFraction);
    dbmInsert: qrTypeFraction.SQL.Add(SqlInsertTypeFraction);
    dbmEdit  : qrTypeFraction.SQL.Add(SqlUpdateTypeFraction);
  end;
  Dados.StartTransaction(qrTypeFraction);
  try
    if (Value.FieldByName['PK_TIPO_TABELA_FRACAO'].AsInteger = 0) then
      Value.FieldByName['PK_TIPO_TABELA_FRACAO'].AsInteger     := GetPkTypeFraction;
    qrTypeFraction.ParamByName('PkTipoTabelaFracao').AsInteger := Value.FieldByName['PK_TIPO_TABELA_FRACAO'].AsInteger;
    if (qrTypeFraction.Params.FindParam('DscTab') <> nil) then
      qrTypeFraction.ParamByName('DscTab').AsString            := Value.FieldByName['DSC_TAB'].AsString;
    if (qrTypeFraction.Params.FindParam('FlagTipo') <> nil) then
      qrTypeFraction.ParamByName('FlagTipo').AsInteger         := Value.FieldByName['FLAG_TIPO'].AsInteger;
    qrTypeFraction.ExecSQL;
    Dados.CommitTransaction(qrTypeFraction);
  except on E:Exception do
    begin
      if (qrTypeFraction.Active) then qrTypeFraction.Close;
      Dados.RollbackTransaction(qrTypeFraction);
      raise Exception.Create('SetTypeFraction: Erro ao gravar registro ' + NL +
        E.Message + NL + qrTypeFraction.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.LoadRegions: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlRegions);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.AddObject('<Nenhuma>', nil);
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FindField('REF_REG').AsString,
          TObject(qrSqlAux.FindField('PK_CARGAS_REGIOES').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysEstq.LoadTableRegions: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTableRegions);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.AddObject('<Nenhuma>', nil);
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FindField('DSC_ORDS').AsString,
          TObject(qrSqlAux.FindField('PK_TABELA_ORIGEM_DESTINO').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysEstq.GetFractions(APk: Integer): TList;
begin
  Result := TList.Create;
  if (qrFractions.Active) then qrFractions.Close;
  qrFractions.SQL.Clear;
  qrFractions.SQL.Add(SqlGetTableFraction);
  Dados.StartTransaction(qrFractions);
  try
    qrFractions.ParamByName('FkTabelaPrecos').AsInteger        := FFkTablePrice;
    qrFractions.ParamByName('FkTipoTabelaFracao').AsInteger    := FFkTypeFraction;
    qrFractions.ParamByName('FkTabelaOrigemDestino').AsInteger := APk;
    if (not qrFractions.Active) then qrFractions.Open;
    while not qrFractions.Eof do
    begin
      Result.Add(TDataRow.CreateFromDataSet(nil, qrFractions, True));
      qrFractions.Next;
    end;
  finally
    if (qrFractions.Active) then qrFractions.Close;
    Dados.CommitTransaction(qrFractions);
  end;
end;

procedure TdmSysEstq.SetFractions(APk: Integer; const Value: TList);
var
  i: Integer;
begin
  if (qrFractions.Active) then qrFractions.Close;
  qrFractions.SQL.Clear;
  qrFractions.SQL.Add(SqlDeleteTableFract);
  Dados.StartTransaction(qrFractions);
  try
    qrFractions.ParamByName('FkTabelaPrecos').AsInteger        := FFkTablePrice;
    qrFractions.ParamByName('FkTipoTabelaFracao').AsInteger    := FFkTypeFraction;
    qrFractions.ParamByName('FkTabelaOrigemDestino').AsInteger := APk;
    qrFractions.ExecSQL;
    if (Value <> nil) and (Value.Count <> 0) then
    begin
      qrFractions.SQL.Clear;
      qrFractions.SQL.Add(SqlInsertTableFract);
      for i := 0 to Value.Count - 1 do
      begin
        qrFractions.ParamByName('FkTabelaPrecos').AsInteger        := FFkTablePrice;
        qrFractions.ParamByName('FkTipoTabelaFracao').AsInteger    := FFkTypeFraction;
        qrFractions.ParamByName('FkTabelaOrigemDestino').AsInteger := APk;
        qrFractions.ParamByName('PkTabelaFracoes').AsInteger       := i + 1;
        qrFractions.ParamByName('VlrIni').AsFloat                  := TDataRow(Value.Items[i]).FieldByName['VLR_INI'].AsFloat;
        qrFractions.ParamByName('VlrFin').AsFloat                  := TDataRow(Value.Items[i]).FieldByName['VLR_FIN'].AsFloat;
        qrFractions.ParamByName('VlrIdx').AsFloat                  := TDataRow(Value.Items[i]).FieldByName['VLR_IDX'].AsFloat;
        qrFractions.ParamByName('FlagMFinal').AsInteger            := TDataRow(Value.Items[i]).FieldByName['FLAG_MFINAL'].AsInteger;
        qrFractions.ParamByName('PercAdv').AsFloat                 := TDataRow(Value.Items[i]).FieldByName['PERC_ADV'].AsFloat;
        qrFractions.ParamByName('TaxTab').AsFloat                  := TDataRow(Value.Items[i]).FieldByName['TAX_TAB'].AsFloat;
        qrFractions.ExecSQL;
      end;
    end;
    Dados.CommitTransaction(qrFractions);
  except on E:Exception do
    begin
      if (qrFractions.Active) then qrFractions.Close;
      Dados.RollbackTransaction(qrFractions);
      raise Exception.Create('SetTypeFraction: Erro ao gravar registro ' + NL +
        E.Message + NL + qrFractions.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.GetProductService(APk: Integer): TProductService;
begin
  Result := TProductService.Create(APk);
  if qrProdSrv.Active then qrProdSrv.Close;
  qrProdSrv.SQL.Clear;
  qrProdSrv.SQL.Add(SqlProductService);
  Dados.StartTransaction(qrProdSrv);
  try
    qrProdSrv.Params.FindParam('FkProdutos').AsInteger := APk;
    if (not qrProdSrv.Active) then qrProdSrv.Open;
    if (not qrProdSrv.IsEmpty) then
    begin
      with Result do
      begin
        VlrUnit := qrProdSrv.FieldByName('VLR_UNIT').AsFloat;
        FlagAtv := Boolean(qrProdSrv.FieldByName('FLAG_ATV').AsInteger);
      end;
    end;
  finally
    if qrProdSrv.Active then qrProdSrv.Close;
    Dados.CommitTransaction(qrProdSrv);
  end;
end;

procedure TdmSysEstq.SetProductService(APk: Integer;
  const Value: TProductService);
begin
  if (Value = nil) then exit;
  if (qrProdSrv.Active) then qrProdSrv.Close;
  qrProdSrv.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrProdSrv.SQL.Add(SqlDeleteProductSrv);
    dbmInsert: qrProdSrv.SQL.Add(SqlInsertProductSrv);
    dbmEdit  : qrProdSrv.SQL.Add(SqlUpdateProductSrv);
  end;
  if (qrProdSrv.SQL.Text = '') then exit;
  try
    qrProdSrv.ParamByName('FkProdutos').AsInteger := Value.FkProduct;
    if (qrProdSrv.Params.FindParam('FlagAtv') <> nil) then
      qrProdSrv.ParamByName('FlagAtv').AsInteger  := Ord(Value.FlagAtv);
    if (qrProdSrv.Params.FindParam('VlrUnit') <> nil) then
      qrProdSrv.ParamByName('VlrUnit').AsFloat    := Value.VlrUnit;
    qrProdSrv.ExecSQL;
  except on E:Exception do
    begin
      if (qrProdSrv.Active) then qrProdSrv.Close;
      raise Exception.Create('SetProductService: Erro ao gravar registro ' + NL +
        E.Message + NL + qrProdSrv.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.GetProductComps(APk: Integer): TList;
begin
  Result := TList.Create;
  if qrTypeComp.Active  then qrTypeComp.Close;
end;

procedure TdmSysEstq.SetProductComps(APk: Integer; const Value: TList);
begin

end;

function TdmSysEstq.GetProductCarrier(APk: Integer): TProductCarrier;
begin
  Result := TProductCarrier.Create(APk);
  if qrProdCarrier.Active then qrProdCarrier.Close;
  qrProdCarrier.SQL.Clear;
  qrProdCarrier.SQL.Add(SqlProductCarrier);
  Dados.StartTransaction(qrProdCarrier);
  try
    qrProdCarrier.Params.FindParam('FkProdutos').AsInteger := APk;
    if (not qrProdCarrier.Active) then qrProdCarrier.Open;
    if (not qrProdCarrier.IsEmpty) then
    begin
      with Result do
      begin
        FlagTCarrier := TTypeCarrier(qrProdCarrier.FieldByName('FLAG_TP_FRE').AsInteger);
        FlagRdsp     := Boolean(qrProdCarrier.FieldByName('FLAG_RDSP').AsInteger);
      end;
    end;
  finally
    if qrProdCarrier.Active then qrProdCarrier.Close;
    Dados.CommitTransaction(qrProdCarrier);
  end;
end;

procedure TdmSysEstq.SetProductCarrier(APk: Integer;
  const Value: TProductCarrier);
begin
  if (Value = nil) then exit;
  if (qrProdCarrier.Active) then qrProdCarrier.Close;
  qrProdCarrier.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrProdCarrier.SQL.Add(SqlDeleteProdCarrier);
    dbmInsert: qrProdCarrier.SQL.Add(SqlInsertProdCarrier);
    dbmEdit  : qrProdCarrier.SQL.Add(SqlUpdateProdCarrier);
  end;
  try
    qrProdCarrier.ParamByName('FkProdutos').AsInteger  := Value.FkProduct;
    if (qrProdCarrier.Params.FindParam('FlagRdsp')  <> nil) then
      qrProdCarrier.ParamByName('FlagRdsp').AsInteger  := Ord(Value.FlagRdsp);
    if (qrProdCarrier.Params.FindParam('FlagTpFre') <> nil) then
      qrProdCarrier.ParamByName('FlagTpFre').AsInteger := Ord(Value.FlagTCarrier);
    qrProdCarrier.ExecSQL;
  except on E:Exception do
    begin
      if (qrProdCarrier.Active) then qrProdCarrier.Close;
      raise Exception.Create('SetCalcFraction: Erro ao gravar registro ' + NL +
        E.Message + NL + qrProdCarrier.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.LoadDeliveryPeriod: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlDeliveryPeriod);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.AddObject('<Nenhum>', nil);
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FindField('DSC_PRZE').AsString,
          TObject(qrSqlAux.FindField('PK_TIPO_PRAZO_ENTREGA').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

function TdmSysEstq.GetTableFraction(APk: Integer): TDataRow;
begin
  Result := nil;
  if (APk <= 0) then exit;
  if (qrTableFraction.Active) then qrTableFraction.Close;
  qrTableFraction.SQL.Clear;
  qrTableFraction.SQL.Add(SqlTableFraction);
  Dados.StartTransaction(qrTableFraction);
  try
    qrTableFraction.ParamByName('FkTabelaPrecos').AsInteger        := FFkTablePrice;
    qrTableFraction.ParamByName('FkTipoTabelaFracao').AsInteger    := FFkTypeFraction;
    qrTableFraction.ParamByName('FkTabelaOrigemDestino').AsInteger := APk;
    if (not qrTableFraction.Active) then qrTableFraction.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTableFraction, True);
  finally
    if (qrTableFraction.Active) then qrTableFraction.Close;
    Dados.CommitTransaction(qrTableFraction);
  end;
end;

procedure TdmSysEstq.SetTableFraction(APk: Integer; const Value: TDataRow);
begin
  if (Value = nil) or (Value.Count = 0) then exit;
  if (qrTableFraction.Active) then qrTableFraction.Close;
  qrTableFraction.SQL.Clear;
  case TDBMode(APk) of
    dbmDelete: qrTableFraction.SQL.Add(SqlDelTableFraction);
    dbmInsert: qrTableFraction.SQL.Add(SqlInsTableFraction);
    dbmEdit  : qrTableFraction.SQL.Add(SqlUpdTableFraction);
  end;
  Dados.StartTransaction(qrTableFraction);
  try
    qrTableFraction.ParamByName('FkTabelaPrecos').AsInteger        := Value.FieldByName['FK_TABELA_PRECOS'].AsInteger;
    qrTableFraction.ParamByName('FkTipoTabelaFracao').AsInteger    := Value.FieldByName['FK_TIPO_TABELA_FRACAO'].AsInteger;
    qrTableFraction.ParamByName('FkTabelaOrigemDestino').AsInteger := Value.FieldByName['FK_TABELA_ORIGEM_DESTINO'].AsInteger;
    if (qrTableFraction.Params.FindParam('FlagVExd')   <> nil) then
      qrTableFraction.ParamByName('FlagVExd').AsInteger      := Value.FieldByName['FLAG_VEXD'].AsInteger;
    if (qrTableFraction.Params.FindParam('FlagTpOper') <> nil) then
      qrTableFraction.ParamByName('FlagTpOper').AsInteger    := Value.FieldByName['FLAG_TPOPER'].AsInteger;
    if (qrTableFraction.Params.FindParam('VlrExd')     <> nil) then
      qrTableFraction.ParamByName('VlrExd').AsFloat          := Value.FieldByName['VLR_EXD'].AsFloat;
    if (qrTableFraction.Params.FindParam('PercGris')   <> nil) then
      qrTableFraction.ParamByName('PercGris').AsFloat        := Value.FieldByName['PERC_GRIS'].AsFloat;
    if (qrTableFraction.Params.FindParam('VlrMinGris') <> nil) then
      qrTableFraction.ParamByName('VlrMinGris').AsFloat      := Value.FieldByName['VLR_MIN_GRIS'].AsFloat;
    if (qrTableFraction.Params.FindParam('DivPed')     <> nil) then
      qrTableFraction.ParamByName('DivPed').AsFloat          := Value.FieldByName['DIV_PED'].AsFloat;
    if (qrTableFraction.Params.FindParam('Vlr_Ped')    <> nil) then
      qrTableFraction.ParamByName('Vlr_Ped').AsFloat         := Value.FieldByName['VLR_PED'].AsFloat;
    qrTableFraction.ExecSQL;
    Dados.CommitTransaction(qrTableFraction);
  except on E:Exception do
    begin
      if (qrTableFraction.Active) then qrTableFraction.Close;
      Dados.RollbackTransaction(qrTableFraction);
      raise Exception.Create('SetTableFraction: Erro ao gravar registro ' + NL +
        E.Message + NL + qrTableFraction.SQL.Text);
    end;
  end;
end;

function TdmSysEstq.LoadDscTableRegion(APk: Integer): TDataRow;
begin
  Result := nil;
  if (APk <= 0) then exit;
  if (qrTableRegion.Active) then qrTableRegion.Close;
  qrTableRegion.SQL.Clear;
  qrTableRegion.SQL.Add(SqlDscTableRegion);
  Dados.StartTransaction(qrTableRegion);
  try
    qrTableRegion.ParamByName('PkTabelaOrigemDestino').AsInteger := APk;
    if (not qrTableRegion.Active) then qrTableRegion.Open;
    Result := TDataRow.CreateFromDataSet(nil, qrTableRegion, True);
  finally
    if (qrTableRegion.Active) then qrTableRegion.Close;
    Dados.CommitTransaction(qrTableRegion);
  end;
end;

function TdmSysEstq.LoadTypeFractions: TStrings;
begin
  Result := TStringList.Create;
  if (qrSqlAux.Active) then qrSqlAux.Close;
  qrSqlAux.SQL.Clear;
  qrSqlAux.SQL.Add(SqlTypeFractions);
  Dados.StartTransaction(qrSqlAux);
  try
    qrSqlAux.Open;
    if (not qrSqlAux.IsEmpty) then
    begin
      qrSqlAux.First;
      Result.AddObject('<Nenhuma>', nil);
      while not qrSqlAux.Eof do
      begin
        Result.AddObject(qrSqlAux.FindField('DSC_TAB').AsString,
          TObject(qrSqlAux.FindField('PK_TIPO_TABELA_FRACAO').AsInteger));
        qrSqlAux.Next;
      end;
    end;
  finally
    if (qrSqlAux.Active) then qrSqlAux.Close;
    Dados.CommitTransaction(qrSqlAux);
  end;
end;

initialization
  Application.CreateForm(TdmSysEstq, dmSysEstq);
finalization
  if Assigned(dmSysEstq) then dmSysEstq.Free;
  dmSysEstq := nil;
end.
