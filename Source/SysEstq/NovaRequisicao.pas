unit NovaRequisicao;

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

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, ToolEdit, StdCtrls, Mask, CurrEdit, VirtualTrees,
  jpeg, ComCtrls, ToolWin, ImgList, ProcType, GridRow, FMTBcd, DB, SqlExpr,
  ProcUtils, TSysMan, TSysEstqAux;

type
  TLotacaoMaterialField = (lmfRua, lmfNivel, lmfBox, lmffkLotacao, lmfIcLot, lmfDescricao);

//  TTypeDocuments = (tdNF, tdRequest, tdOrder, tdOther, tdNone);

  TfmNovaRequisicao = class(TForm)
    paDetails: TPanel;
    stItems: TVirtualStringTree;
    lPk_Requisicoes: TStaticText;
    lFk_Tipo_Movim_Estq: TStaticText;
    lDta_Req: TStaticText;
    eDta_Req: TDateEdit;
    eFk_Tipo_Movim_Estq: TComboBox;
    imLogo: TImage;
    shImage: TShape;
    ilEnabled: TImageList;
    ilDisabled: TImageList;
    shTitle: TShape;
    lTitle: TLabel;
    paMsg: TPanel;
    paVersion: TPanel;
    eVersion: TComboBox;
    lVersion: TLabel;
    laMsg: TLabel;
    StaticText1: TStaticText;
    eFk_Tipo_Documentos: TComboBox;
    spGrid: TSplitter;
    pgReqData: TPageControl;
    tsReqData: TTabSheet;
    tsLotacao: TTabSheet;
    eObs_Req: TMemo;
    lObs_Req: TStaticText;
    eFk_Almoxarifados_Orgm: TComboBox;
    lFk_Almoxarifados_Orgm: TStaticText;
    lFk_Almoxarifados_Dstn: TStaticText;
    eFk_Almoxarifados_Dstn: TComboBox;
    eFk_Funcionario: TComboBox;
    lFk_Funcionario: TStaticText;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    cmdNovaRequisicao: TToolButton;
    cmdUpdateRequisicao: TToolButton;
    tbSep: TToolButton;
    cmdLotacoes: TToolButton;
    StaticText2: TStaticText;
    lDta_Doc: TStaticText;
    eDta_Doc: TDateEdit;
    ePk_Requisicoes: TCurrencyEdit;
    eNum_Doc: TCurrencyEdit;
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure SignalizeChange(Sender : TObject);
    procedure cmdAddItemClick(Sender : TObject);
    procedure cmdDeleteItemClick(Sender : TObject);
    procedure cmdUpdateRequisicaoClick(Sender : TObject);
    procedure eFk_FuncionarioClick(Sender : TObject);
    procedure ePk_RequisicoesKeyPress(Sender : TObject; var Key : Char);
    procedure stItemsKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure stItemsEditing(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; var Allowed : Boolean);
    procedure stItemsGetText(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; TextType : TVSTTextType; var CellText : WideString);
    procedure stItemsPaintText(Sender : TBaseVirtualTree;
      const TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex;
      TextType : TVSTTextType);
    procedure cmdNovaRequisicaoClick(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure optInsumoClick(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure eFk_Almoxarifados_OrgmClick(Sender : TObject);
    procedure eFk_Almoxarifados_DstnClick(Sender : TObject);
    procedure cmdLotacoesClick(Sender : TObject);
    procedure stItemsFocusChanged(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex);
    procedure eVersionClick(Sender : TObject);
    procedure stItemsNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure eFk_Tipo_Movim_EstqSelect(Sender: TObject);
  private
    { Private declarations }
    FInsideMove        : Boolean;
    FslItems           : TList;
    FfkAlmoxarifados   : Integer;
    FfkAlmoxarifadosDst: Integer;
    FOnChangeState     : TChangeStateEvent;
    procedure ClearTipoMovimEstq;
    procedure LoadTipoMovimEstq;
    procedure ClearFuncionarios;
    procedure LoadFuncionarios(const ASql: string);
    procedure ClearAlmoxarifados;
    procedure LoadAlmoxarifados;
    procedure ClearItems;
    procedure ClearRequisicao;
    function  GroupItems: Integer;
    procedure AddItem;
    function  VerifyReq: Boolean;
    function  GetSecondaryPK: Boolean;
    function  RequisicaoSaved: Boolean;
    function  LotacoesOk: Boolean;
    procedure SearchReferencia;
    procedure CheckLotacao(aRow : TDataRow);
    procedure RevalidateLotacoes;
    function  GetAlmoxDstn: Integer;
    function  GetAlmoxOrgm: Integer;
    function  GetDtaDoc: TDate;
    function  GetEmployee: Integer;
    function  GetNumDoc: Integer;
    function  GetObsReq: TStrings;
    function  GetDtaReq: TDate;
    function  GetFkTypeMov: Integer;
    function  GetFkTypeDoc: Integer;
    function  GetPkRequest: Integer;
    function  GetProductReq(ARow: TDataRow; ACodRef: string): Boolean;
    procedure SetAlmoxDstn(const Value: Integer);
    procedure SetAlmoxOrgm(const Value: Integer);
    procedure SetDtaDoc(const Value: TDate);
    procedure SetEmployee(const Value: Integer);
    procedure SetNumDoc(const Value: Integer);
    procedure SetObsReq(const Value: TStrings);
    procedure SetFkTypeMov(const Value: Integer);
    procedure SetFkTypeDoc(const Value: Integer);
    procedure SetDtaReq(const Value: TDate);
    procedure SetPkRequest(const Value: Integer);
    procedure LotacaoOnClose(Sender : TObject; var Action : TCloseAction);
    function  GetDocumentType: TDocumentType;
    function  GetFlagCode: TCodeTypes;
    function  GetFlagES: TMovimentations;
  protected
    { Protected declarations }
    property PkRequest : Integer  read GetPkRequest write SetPkRequest;
    property DtaReq    : TDate    read GetDtaReq    write SetDtaReq;
    property FkTypeDoc : Integer  read GetFkTypeDoc write SetFkTypeDoc;
    property FkTypeMov : Integer  read GetFkTypeMov write SetFkTypeMov;
    property NumDoc    : Integer  read GetNumDoc    write SetNumDoc;
    property DtaDoc    : TDate    read GetDtaDoc    write SetDtaDoc;
    property AlmoxOrgm : Integer  read GetAlmoxOrgm write SetAlmoxOrgm;
    property AlmoxDstn : Integer  read GetAlmoxDstn write SetAlmoxDstn;
    property Employee  : Integer  read GetEmployee  write SetEmployee;
    property ObsReq    : TStrings read GetObsReq    write SetObsReq;
  public
    { Public declarations }
    property  OnChangeState: TChangeStateEvent read FOnChangeState write FOnChangeState;
  end;

var
  fmNovaRequisicao: TfmNovaRequisicao;

implementation

uses NovaLotacao, SearchReferencia, Dado, mSysEstq, EstqArqSql, Funcoes,
  CmmConst, SqlComm;

{$R *.dfm}

var
  LotacaoMaterialField: array[TLotacaoMaterialField, Boolean] of string =
   (('rua_lot_orgm'   , 'rua_lot_dstn'   ),
    ('nivel_lot_orgm' , 'nivel_lot_dstn' ),
    ('box_lot_orgm'   , 'box_lot_dstn'   ),
    ('fk_lotacao_orgm', 'fk_lotacao_dstn'),
    ('IcLotOrgm'      , 'IcLotDstn'      ),
    ('dsc_lot_orgm'   , 'dsc_lot_dstn'   ));

procedure TfmNovaRequisicao.ClearTipoMovimEstq;
var
  i:    Integer;
  aRow: TTypeMoviment;
begin
  for i := 0 to eFk_Tipo_Movim_Estq.Items.Count - 1 do
  begin
    aRow := TTypeMoviment(eFk_Tipo_Movim_Estq.Items.Objects[i]);
    if aRow <> nil then
    begin
      aRow.Free;
      eFk_Tipo_Movim_Estq.Items.Objects[i] := nil;
    end;
  end;
  eFk_Tipo_Movim_Estq.Items.Clear;
end;

procedure TfmNovaRequisicao.LoadTipoMovimEstq;
begin
  ClearTipoMovimEstq;
  eFk_Tipo_Movim_Estq.Items.AddStrings(dmSysEstq.LoadTypeMovement(-1));
  if eFk_Tipo_Movim_Estq.Items.Count < 1 then exit;
  eFk_Tipo_Movim_Estq.ItemIndex := 0;
  if Assigned(eFk_Tipo_Movim_Estq.OnSelect) then
    eFk_Tipo_Movim_Estq.OnSelect(Self);
end;

procedure TfmNovaRequisicao.FormCreate(Sender : TObject);
begin
  FslItems    := TList.Create;
  stItems.RootNodeCount := 0;
  stItems.NodeDataSize := SizeOf(TGridData);
  eFk_Tipo_Documentos.Items.AddStrings(dmSysEstq.LoadTypeDocs);
  LoadTipoMovimEstq;
  LoadAlmoxarifados;
  DtaReq := Now;
  DtaDoc := Now;
end;

procedure TfmNovaRequisicao.FormDestroy(Sender : TObject);
begin
  stItems.EndEditNode;
  ReleaseCombos(eFk_Tipo_Documentos, toObject);
  ClearTipoMovimEstq;
  ClearFuncionarios;
  ClearAlmoxarifados;
  ClearItems;
  FslItems.Free;
  FslItems := nil;
  if Assigned(fmNovaLotacao) then
    fmNovaLotacao.Free;
  fmNovaLotacao := nil;
end;

procedure TfmNovaRequisicao.ClearFuncionarios;
var
  i   : Integer;
  aRow: TDataRow;
begin
  for i := 0 to eFk_Funcionario.Items.Count - 1 do
  begin
    aRow := TDataRow(eFk_Funcionario.Items.Objects[i]);
    if aRow <> nil then
    begin
      aRow.Free;
      eFk_Funcionario.Items.Objects[i] := nil;
    end;
  end;
  eFk_Funcionario.Items.Clear;
end;

procedure TfmNovaRequisicao.LoadFuncionarios(const ASql: string);
begin
  ClearFuncionarios;
  with dmSysEstq.qrFuncionarios do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(ASql);
    Dados.StartTransaction(dmSysEstq.qrFuncionarios);
    try
      if not Active then Open;
      while not (EOF) do
      begin
        eFk_Funcionario.Items.AddObject(FieldByName('raz_soc').AsString,
          TDataRow.CreateFromDataSet(nil,
          dmSysEstq.qrFuncionarios, True));
        Next;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(dmSysEstq.qrFuncionarios);
    end;
  end;
end;

procedure TfmNovaRequisicao.ClearAlmoxarifados;
begin
  FfkAlmoxarifados    := 0;
  FfkAlmoxarifadosDst := 0;
  eFk_Almoxarifados_Orgm.Items.Clear;
  eFk_Almoxarifados_Dstn.Items.Clear;
end;

procedure TfmNovaRequisicao.LoadAlmoxarifados;
begin
  ClearAlmoxarifados;
  with dmSysEstq.qrAlmoxarifados do
    try
      Open;
      while not (EOF) do
      begin
        eFk_Almoxarifados_Orgm.Items.AddObject(FieldByName('dsc_almx').AsString,
          TObject(FieldByName('pk_almoxarifados').AsInteger));
        eFk_Almoxarifados_Dstn.Items.AddObject(FieldByName('dsc_almx').AsString,
          TObject(FieldByName('pk_almoxarifados').AsInteger));
        Next;
      end;
    finally
      Close;
    end;
end;

procedure TfmNovaRequisicao.ClearRequisicao;
begin
  ClearItems;
  ePk_Requisicoes.Value := 0;
  eNum_Doc.Value := 0;
  eObs_Req.Lines.Clear;
  if (eFk_Tipo_Documentos.Items.Count > 0) then
    eFk_Tipo_Documentos.ItemIndex := 0;
  cmdUpdateRequisicao.Enabled := False;
  AddItem;
  SignalizeChange(ePk_Requisicoes);
  if Assigned(FOnChangeState) then FOnChangeState(Self, dbmBrowse);
end;

procedure TfmNovaRequisicao.ClearItems;
var
  I:    Integer;
  aRow: TDataRow;
begin
  paVersion.Visible := False;
  stItems.EndEditNode;
  for I := 0 to FslItems.Count - 1 do
  begin
    aRow := TDataRow(FslItems[I]);
    if aRow <> nil then
    begin
      aRow.Free;
      FslItems[I] := nil;
    end;
  end;
  FslItems.Clear;
  stItems.Clear;
end;

procedure TfmNovaRequisicao.SignalizeChange(Sender : TObject);
begin
  if FInsideMove then exit;
  if not (cmdUpdateRequisicao.Enabled) then
    cmdUpdateRequisicao.Enabled := True;
  if Assigned(FOnChangeState) then
    if (NumDoc > 0) then
      FOnChangeState(Sender, dbmEdit)
    else
      FOnChangeState(Sender, dbmInsert);
end;

procedure TfmNovaRequisicao.cmdAddItemClick(Sender : TObject);
begin
  SignalizeChange(Sender);
end;

procedure TfmNovaRequisicao.cmdDeleteItemClick(Sender : TObject);
begin
  SignalizeChange(Sender);
end;

function TfmNovaRequisicao.LotacoesOk: Boolean;
var
  TemOrigem, TemDestino: Boolean;
  aNode: PVirtualNode;
  Data:  PGridData;
  S:     string;
begin
  Result := True;
  stItems.EndEditNode;
  TemOrigem  := eFk_Almoxarifados_Orgm.Visible;
  TemDestino := eFk_Almoxarifados_Dstn.Visible;
  aNode      := stItems.GetFirst;
  while aNode <> nil do
  begin
    Data := stItems.GetNodeData(aNode);
    if ((Data <> nil) and (Data.DataRow <> nil)) then
    begin
      if ((TemOrigem) and (Data.DataRow.FieldByName['IcLotOrgm'].AsInteger < 2)) then
      begin
        if Trim(StringReplace(
          Data.DataRow.FieldByName['dsc_lot_orgm'].AsString, '-', '', [rfReplaceAll])) = '' then
          S := 'A Lotação deve ser informada !'
        else
        if Data.DataRow.FieldByName['IcLotOrgm'].AsInteger = 0 then
          S := 'Lotação não Cadastrada !'
        else
          S := 'Lotação não cadastrada para este produto !';
        stItems.FocusedNode := aNode;
        stItems.FocusedColumn := 5;
        Dados.DisplayHint(stItems, S);
        Result := False;
        exit;
      end
      else
      if ((TemDestino) and (Data.DataRow.FieldByName['IcLotDstn'].AsInteger < 2)) then
      begin
        if Trim(
          stringReplace(Data.DataRow.FieldByName['dsc_lot_dstn'].AsString, '-', '', [rfReplaceAll])) = '' then
          S := 'A Lotação deve ser informada !'
        else
        if Data.DataRow.FieldByName['IcLotDstn'].AsInteger = 0 then
          S := 'Lotação não Cadastrada !'
        else
          S := 'Lotação não cadastrada para este insumo !';
        stItems.FocusedNode := aNode;
        stItems.FocusedColumn := 6;
        Dados.DisplayHint(spGrid, S);
        Result := False;
        exit;
      end;
    end;
    aNode := stItems.GetNext(aNode);
  end;
end;

function TfmNovaRequisicao.VerifyReq: Boolean;
var
  S: string;
begin
  Result := True;
  if (FkTypeDoc = 0) then
  begin
    Dados.DisplayHint(eFk_Tipo_Documentos, 'O Tipo de Requisição deve ser informado !');
    Result := False;
    exit;
  end;
  if (FkTypeMov = 0) then
  begin
    Dados.DisplayHint(eFk_Tipo_Movim_Estq, 'O Tipo de Movimentação deve ser informado !');
    Result := False;
    exit;
  end;
  if (DtaReq = 0) then
    S := 'A Data da Requisição deve ser informada !'
  else
    if (DtaReq > Now) then
      S := 'A Data da Requisição não pode ser maior que a data corrente !'
    else
      S := '';
  if (S <> '') then
  begin
    Dados.DisplayHint(eDta_Req, S);
    Result := False;
    exit;
  end;
  if (DtaDoc = 0) then
  begin
    Dados.DisplayHint(eDta_Doc, 'Data do Documento de Origem inválida!');
    Result := False;
    exit;
  end;
  if (Employee = 0) then
  begin
    Dados.DisplayHint(eFk_Funcionario, 'O Funcionário deve ser selecionado !');
    Result := False;
    exit;
  end;
  if (GroupItems = 0) then
  begin
    Dados.DisplayHint(spGrid, 'A Requisição deve conter ao menos 1 ítem !');
    Result := False;
    exit;
  end;
  if (GetSecondaryPK) then
  begin
    Dados.DisplayHint(eNum_Doc, 'Número de documento já utilizado em outra requisição!');
    Result := False;
    exit;
  end;
  if (LotacoesOk) then
  begin
    if (eFk_Almoxarifados_Orgm.Visible) and (AlmoxOrgm = 0) then
    begin
      Dados.DisplayHint(eFk_Almoxarifados_Orgm, 'O Almoxarifado Origem deve ser informado !');
      Result := False;
      exit;
    end;
    if eFk_Almoxarifados_Dstn.Visible and (AlmoxDstn < 1) then
    begin
      Dados.DisplayHint(eFk_Almoxarifados_Orgm, 'O Almoxarifado Destino deve ser informado !');
      Result := False;
      exit;
    end;
  end
  else
  begin
//    Dados.DisplayHint(spGrid, 'Erro ao verificar as Lotações!');
    Result := False;
  end;
end;

function TfmNovaRequisicao.GetSecondaryPK: Boolean;
begin
  with dmSysEstq do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlGetNumberDocument);
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('FkEmpresas').AsInteger       := Dados.PkCompany;
      qrSqlAux.ParamByName('FkTipoDocumentos').AsInteger := FkTypeDoc;
      qrSqlAux.ParamByName('NumDoc').AsInteger           := NumDoc;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      Result := (qrSqlAux.FieldByName('PK_REQUISICOES').AsInteger > 0);
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

function TfmNovaRequisicao.RequisicaoSaved: Boolean;
var
  M      : TMemoryStream;
  i, aPk : Integer;
  aFields: TStrings;
  RowData: TDataRow;
  function GetPkReq: Integer;
  begin
    Result := 0;
    with dmSysEstq do
    begin
      if qrSqlAux.Active then qrSqlAux.Close;
      qrSqlAux.SQL.Clear;
      qrSqlAux.SQL.Add(SqlGetPkDocument);
      try
        qrSqlAux.ParamByName('FkEmpresas').AsInteger       := Dados.PkCompany;
        qrSqlAux.ParamByName('FkTipoDocumentos').AsInteger := FkTypeDoc;
        if (not qrSqlAux.Active) then qrSqlAux.Open;
        if (not qrSqlAux.IsEmpty) then
          Result := qrSqlAux.FieldByName('R_PK_DOCUMENT').AsInteger;
      finally
        if qrSqlAux.Active then qrSqlAux.Close;
      end;
    end;
  end;
begin
  Result := False;
  stItems.EndEditNode;
  if (not VerifyReq) then exit;
  aFields := TStringList.Create;
  aFields.Add('FK_EMPRESAS');
  aFields.Add('PK_REQUISICOES');
  aFields.Add('FK_TIPO_MOVIM_ESTQ');
  aFields.Add('FK_TIPO_DOCUMENTOS');
  aFields.Add('FK_FUNCIONARIOS');
  aFields.Add('FLAG_BXA');
  aFields.Add('DTA_REQ');
  aFields.Add('QTD_ITEMS');
  aFields.Add('DTA_DOC');
  aFields.Add('NUM_DOC');
  if ObsReq.Text <> '' then
    aFields.Add('OBS_REQ');
  eObs_Req.Text := Trim(eObs_Req.Text);
  if (eFk_Almoxarifados_Orgm.Visible) then
    aFields.Add('FK_ALMOXARIFADOS');
  if eFk_Almoxarifados_Dstn.Visible then
    aFields.Add('FK_ALMOXARIFADOS__DST');
  with dmSysEstq do
  begin
    if qrRequisicao.Active then qrRequisicao.Close;
    qrRequisicao.SQL.Clear;
    qrRequisicao.SQL.AddStrings(GetInsertSQL(aFields, 'REQUISICOES'));
    Dados.StartTransaction(qrRequisicao);
    try
      aPk := GetPkReq;
      if (aPk > 0) then
      begin
        qrRequisicao.ParamByName('FkEmpresas').AsInteger       := Dados.PkCompany;
        qrRequisicao.ParamByName('PkRequisicoes').AsInteger    := aPk;
        qrRequisicao.ParamByName('FkTipoMovimEstq').AsInteger  := FkTypeMov;
        qrRequisicao.ParamByName('FkTipoDocumentos').AsInteger := FkTypeDoc;
        qrRequisicao.ParamByName('FkFuncionarios').AsInteger   := Employee;
        qrRequisicao.ParamByName('FlagBxa').AsInteger          := 0;
        qrRequisicao.ParamByName('DtaReq').AsDate              := Date;
        qrRequisicao.ParamByName('QtdItems').AsInteger         := GroupItems;
        qrRequisicao.ParamByName('DtaDoc').AsDate              := DtaDoc;
        if (NumDoc = 0) then NumDoc := aPk;
        qrRequisicao.ParamByName('NumDoc').AsInteger           := NumDoc;
        if qrRequisicao.Params.FindParam('ObsReq') <> nil then
        begin
          M := TMemoryStream.Create;
          try
            ObsReq.SaveToStream(M);
            M.Position := 0;
            qrRequisicao.ParamByName('ObsReq').LoadFromStream(M, ftBlob);
          finally
            FreeAndNil(M);
          end;
        end;
        if (qrRequisicao.Params.FindParam('FkAlmoxarifados') <> nil) then
          qrRequisicao.ParamByName('FkAlmoxarifados').AsInteger := AlmoxOrgm;
        if (qrRequisicao.Params.FindParam('FkAlmoxarifadosDst') <> nil) then
          qrRequisicao.ParamByName('FkAlmoxarifadosDst').AsInteger := AlmoxDstn;
        qrRequisicao.ExecSql;
        for i := 0 to FslItems.Count - 1 do
        begin
          RowData := TDataRow(FslItems[i]);
          if ((RowData <> nil) and (RowData <> nil)) then
          begin
            if qrReqItems.Active then qrReqItems.Close;
            qrReqItems.SQL.Clear;
            qrReqItems.SQL.Add(SqlInsReqItems);
            qrReqItems.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
            qrReqItems.ParamByName('FkRequisicoes').AsInteger      := aPk;
            qrReqItems.ParamByName('PkRequisicoesItems').AsInteger := i + 1;
            qrReqItems.ParamByName('FkProdutos').AsInteger         :=
              RowData.FieldByName['FK_PRODUTOS'].AsInteger;
            qrReqItems.ParamByName('CodProd').AsString             :=
              RowData.FieldByName['COD_PROD'].AsString;
            qrReqItems.ParamByName('QtdItm').AsFloat               :=
              RowData.FieldByName['QTD_ITM'].AsFloat;
            qrReqItems.ParamByName('FkLotacaoOrgm').AsInteger      :=
              RowData.FieldByName['FK_LOTACAO_ORGM'].AsInteger;
            qrReqItems.ParamByName('FkLotacaoDstn').AsInteger      :=
              RowData.FieldByName['FK_LOTACAO_DSTN'].AsInteger;
            qrReqItems.ParamByName('SttBxa').AsInteger             := 0;
            qrReqItems.ExecSql;
            if qrReqItems.Active then qrReqItems.Close;
          end;
        end;
      end;
      Dados.CommitTransaction(qrRequisicao);
    except on E:Exception do
      begin
        if qrRequisicao.Active then qrRequisicao.Close;
        if qrReqItems.Active then qrReqItems.Close;
        Dados.RollbackTransaction(qrRequisicao);
        raise Exception.Create('SaveReq: Erro ao salvar registro' + NL +
          E.Message);
      end;
    end;
  end;
  cmdUpdateRequisicao.Enabled := False;
  Result := True;
  Dados.DisplayHint(cmdUpdateRequisicao, 'Requisição ' + IntToStr(aPk) +
    ' incluída com sucesso !');
  if Assigned(FOnChangeState) then FOnChangeState(Self, dbmBrowse);
end;

procedure TfmNovaRequisicao.cmdUpdateRequisicaoClick(Sender : TObject);
begin
  if RequisicaoSaved then
    if Assigned(cmdNovaRequisicao.OnClick) then
      cmdNovaRequisicao.OnClick(Self);
end;

procedure TfmNovaRequisicao.eFk_FuncionarioClick(Sender : TObject);
var
  aRow: TDataRow;
begin
  if eFk_Funcionario.ItemIndex < 0 then
    exit;
  aRow := TDataRow(eFk_Funcionario.Items.Objects[eFk_Funcionario.ItemIndex]);
  if aRow = nil then
    exit;
  SignalizeChange(Sender);
end;

procedure TfmNovaRequisicao.ePk_RequisicoesKeyPress(Sender : TObject; var Key : Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

function TfmNovaRequisicao.GroupItems: Integer;
var
  sl:    TStringList;
  I, Ix: Integer;
  OtherRowData, RowData: TDataRow;
  S:     string;
begin
  Result := 0;
  stItems.EndEditNode;
  if ((FslItems = nil) or (FslItems.Count < 1)) then
    exit;
  sl := TStringList.Create;
  try
    for I := 0 to FslItems.Count - 1 do
    begin
      RowData := TDataRow(FslItems[I]);
      if ((RowData <> nil) and (RowData <> nil) and
        (RowData.FieldByName['FK_PRODUTOS'].AsInteger > 0) and
        (RowData.FieldByName['QTD_ITM'].AsFloat > 0.00009)) then
      begin
        S  := FormatFloat('00000000', RowData.FieldByName['FK_PRODUTOS'].AsInteger) +
          FormatFloat('00000000', RowData.FieldByName['FK_LOTACAO_ORGM'].AsInteger) +
          FormatFloat('00000000', RowData.FieldByName['FK_LOTACAO_DSTN'].AsInteger);
        Ix := sl.IndexOf(S);
        if Ix > -1 then
        begin
          OtherRowData := TDataRow(sl.Objects[Ix]);
          OtherRowData.FieldByName['QTD_ITM'].AsFloat :=
            OtherRowData.FieldByName['QTD_ITM'].AsFloat +
            RowData.FieldByName['QTD_ITM'].AsFloat;
        end
        else
          sl.AddObject(S, RowData);
      end;
    end;
    stItems.BeginUpdate;
    try
      I := 0;
      while I < FslItems.Count do
      begin
        RowData := TDataRow(FslItems[I]);
        if RowData <> nil then
        begin
          Ix := sl.IndexOfObject(RowData);
          if Ix < 0 then
          begin
            FslItems.Delete(I);
//            stItems.DeleteNode(Node);
            RowData.Free;
            RowData := nil;
            if RowData <> nil then;
          end
          else
            Inc(I);
        end
        else
          Inc(I);
      end;
    finally
      if stItems.RootNodeCount < 1 then
        AddItem;
      stItems.EndUpdate;
    end;
  finally
    Result := sl.Count;
    sl.Free;
    sl := nil;
    if sl <> nil then;
  end;
end;

procedure TfmNovaRequisicao.AddItem;
var
  RowData: TDataRow;
  Data:    PGridData;
  aNode:   PVirtualNode;
begin
  with dmSysEstq do
  begin
    if qrReqItems.Active then qrReqItems.Close;
    qrReqItems.SQL.Clear;
    qrReqItems.SQL.Add(SqlRequisicoesItems);
    qrReqItems.ParamByName('FkEmpresas').AsInteger         := Dados.PkCompany;
    qrReqItems.ParamByName('FkRequisicoes').AsInteger      := 0;
    qrReqItems.ParamByName('PkRequisicoesItems').AsInteger := 0;
    RowData := TDataRow.CreateFromDataSet(nil, qrReqItems, False);
  end;
  aNode   := stItems.AddChild(nil);
  Data    := stItems.GetNodeData(aNode);
  Data.Level := 0;
  Data.DataRow := RowData;
  Data.Node := aNode;
  FslItems.Add(RowData);
end;

procedure TfmNovaRequisicao.stItemsKeyDown(Sender : TObject; var Key : Word;
  Shift : TShiftState);
var
  Data: PGridData;
  OtherNode, aNode: PVirtualNode;
  Ix:   Integer;
begin
  aNode := stItems.FocusedNode;
  if aNode = nil then exit;
  if ((Key = vk_F3) and (stItems.FocusedColumn = 1)) then
  begin
    if (stItems.IsEditing) then stItems.EndEditNode;
    SearchReferencia;
    Key := 0;
    exit;
  end;
  if (((Key = vk_down) or ((Key = vk_right) and
     (stItems.FocusedColumn = stItems.Header.Columns.Count - 1))) and
     (aNode = stItems.GetLast)) then
  begin
    Data := stItems.GetNodeData(aNode);
    if ((Data <> nil) and (Data.DataRow <> nil) and
      (Data.DataRow.FieldByName['QTD_ITM'].AsFloat > 0.00009) and
      (Data.DataRow.FieldByName['FK_PRODUTOS'].AsInteger > 0)) then
    begin
      AddItem;
      stItems.FocusedColumn := 1;
    end
  end
  else
  if ((Key = vk_up) or ((Key = vk_left) and (stItems.FocusedColumn = 0))) then
    if ((aNode = stItems.GetLast) and (aNode <> stItems.GetFirst)) then
    begin
      Data := stItems.GetNodeData(aNode);
      if ((Data <> nil) and (Data.DataRow <> nil) and
         ((Data.DataRow.FieldByName['QTD_ITM'].AsFloat < 0.0001) or
         (Data.DataRow.FieldByName['FK_PRODUTOS'].AsInteger < 1))) then
      begin
        Key := 0;
        stItems.EndEditNode;
        OtherNode := aNode.PrevSibling;
        if OtherNode <> nil then
        begin
          stItems.FocusedNode := OtherNode;
          stItems.Selected[OtherNode] := True;
          if aNode <> stItems.FocusedNode then
          begin
            Ix := FslItems.IndexOf(Data.DataRow);
            if Ix > -1 then
            begin
              FslItems.Delete(Ix);
              Data.DataRow.Free;
              Data.DataRow := nil;
              stItems.DeleteNode(aNode);
            end;
          end;
        end;
      end;
    end
    else
    if aNode = stItems.GetFirst then
      Key := 0;
end;

procedure TfmNovaRequisicao.stItemsEditing(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; var Allowed : Boolean);
begin
  Allowed := ((Node <> nil) and ((Column = 1) or (Column = 3) or
    ((Column = 5) and (eFk_Almoxarifados_Orgm.Visible)) or
    ((Column = 6) and (eFk_Almoxarifados_Dstn.Visible))));
end;

procedure TfmNovaRequisicao.stItemsGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data: PGridData;
begin
  if Node = nil then
    exit;
  Data := stItems.GetNodeData(Node);
  if ((Data = nil) or (Data.DataRow = nil)) then
    exit;
  with Data.DataRow do
    case Column of
      0: CellText := IntToStr(Node.Index + 1);
      1: CellText := FieldByName['COD_PROD'].AsString;
      2: CellText := FieldByName['DSC_PROD'].AsString;
      3: CellText := FloatToStrF(FieldByName['QTD_ITM'].AsFloat, ffNumber, 18, Dados.DecimalPlacesQtd);
      4: CellText := FieldByName['DSC_UNI'].AsString;
      5: CellText := FieldByName['DSC_LOT_ORGM'].AsString;
      6: CellText := FieldByName['DSC_LOT_DSTN'].AsString;
    end;
end;

procedure TfmNovaRequisicao.stItemsPaintText(Sender : TBaseVirtualTree;
  const TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex;
  TextType : TVSTTextType);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if ((Data = nil) or (Data.DataRow = nil) or
    (Data.DataRow.FieldByName['FK_PRODUTOS'].AsInteger > 0)) then
    exit;
  TargetCanvas.Font.Color := clRed;
end;

procedure TfmNovaRequisicao.cmdNovaRequisicaoClick(Sender : TObject);
begin
  ClearRequisicao;
end;

procedure TfmNovaRequisicao.FormShow(Sender : TObject);
begin
  if Assigned(cmdNovaRequisicao.OnClick) then
    cmdNovaRequisicao.OnClick(Self);
end;

procedure TfmNovaRequisicao.optInsumoClick(Sender : TObject);
begin
  ClearItems;
  AddItem;
  SignalizeChange(Self);
end;

procedure TfmNovaRequisicao.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  stItems.EndEditNode;
end;

procedure TfmNovaRequisicao.eFk_Almoxarifados_OrgmClick(Sender : TObject);
begin
  if eFk_Almoxarifados_Orgm.ItemIndex < 0 then
    FfkAlmoxarifados := 0
  else
    FfkAlmoxarifados := LongInt(eFk_Almoxarifados_Orgm.Items.Objects[
      eFk_Almoxarifados_Orgm.ItemIndex]);
  SignalizeChange(Sender);
end;

procedure TfmNovaRequisicao.eFk_Almoxarifados_DstnClick(Sender : TObject);
begin
  if eFk_Almoxarifados_Dstn.ItemIndex < 0 then
    FfkAlmoxarifadosDst := 0
  else
    FfkAlmoxarifadosDst := LongInt(eFk_Almoxarifados_Dstn.Items.Objects[
      eFk_Almoxarifados_Dstn.ItemIndex]);
  SignalizeChange(Sender);
end;

procedure TfmNovaRequisicao.CheckLotacao(aRow : TDataRow);

  procedure ClearALotacao(IsDestino : Boolean);
  begin
    aRow.FieldByName[LotacaoMaterialField[lmfRua, IsDestino]].AsString := '';
    aRow.FieldByName[LotacaoMaterialField[lmfNivel, IsDestino]].AsString := '';
    aRow.FieldByName[LotacaoMaterialField[lmfBox, IsDestino]].AsString := '';
    aRow.FieldByName[LotacaoMaterialField[lmffkLotacao, IsDestino]].AsInteger := 0;
    aRow.FieldByName[LotacaoMaterialField[lmfIcLot, IsDestino]].AsInteger := 0;
  end;

  procedure CheckALotacao(IsDestino : Boolean);
  var
    Rua, Nivel, Box: string;
  begin
    if Trim(StringReplace(
      aRow.FieldByName[LotacaoMaterialField[lmfDescricao, IsDestino]].AsString,
      '-', '', [rfReplaceAll])) = '' then
    begin
      ClearALotacao(IsDestino);
      exit;
    end;
    Rua   := Copy(aRow.FieldByName[LotacaoMaterialField[lmfDescricao, IsDestino]].AsString, 1, 2);
    Nivel := Copy(aRow.FieldByName[LotacaoMaterialField[lmfDescricao, IsDestino]].AsString, 4, 2);
    Box   := Copy(aRow.FieldByName[LotacaoMaterialField[lmfDescricao, IsDestino]].AsString, 7, 2);
    with dmSysEstq do
    begin
      if qrLotacao.Active then qrLotacao.Close;
      qrLotacao.SQL.Clear;
      qrLotacao.SQL.Add(SqlProdutosLotacoes);
      qrLotacao.ParamByName('FkProdutos').AsInteger := aRow.FieldByName['FK_PRODUTOS'].AsInteger;
      try
        qrLotacao.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
        if IsDestino then
          qrLotacao.ParamByName('FkAlmoxarifados').AsInteger := FfkAlmoxarifadosDst
        else
          qrLotacao.ParamByName('FkAlmoxarifados').AsInteger := FfkAlmoxarifados;
        qrLotacao.ParamByName('RuaLot').AsString   := Rua;
        qrLotacao.ParamByName('NivelLot').AsString := Nivel;
        qrLotacao.ParamByName('BoxLot').AsString   := Box;
        if not qrLotacao.Active then qrLotacao.Open;
        if not (qrLotacao.EOF) then
        begin
          aRow.FieldByName[LotacaoMaterialField[lmfRua, IsDestino]].AsString :=
            qrLotacao.FieldByName('RUA_LOT').AsString;
          aRow.FieldByName[LotacaoMaterialField[lmfNivel, IsDestino]].AsString :=
            qrLotacao.FieldByName('NIVEL_LOT').AsString;
          aRow.FieldByName[LotacaoMaterialField[lmfBox, IsDestino]].AsString :=
            qrLotacao.FieldByName('BOX_LOT').AsString;
          aRow.FieldByName[LotacaoMaterialField[lmffkLotacao, IsDestino]].AsInteger :=
            qrLotacao.FieldByName('PK_LOTACOES').AsInteger;
          aRow.FieldByName[LotacaoMaterialField[lmfIcLot, IsDestino]].AsInteger :=
            Integer(qrLotacao.FieldByName('FK_LOTACOES').AsInteger > 0) + 1;
        end
        else
          ClearALotacao(IsDestino);
      finally
        if qrLotacao.Active then qrLotacao.Close;
      end;
    end;
  end;
begin
  if aRow = nil then exit;
  if eFk_Almoxarifados_Orgm.Visible then CheckALotacao(False);
  if eFk_Almoxarifados_Dstn.Visible then CheckALotacao(True);
end;

procedure TfmNovaRequisicao.RevalidateLotacoes;
var
  aNode: PVirtualNode;
  Data:  PGridData;
begin
  aNode := stItems.GetFirst;
  while aNode <> nil do
  begin
    Data := stItems.GetNodeData(aNode);
    if ((Data <> nil) and (Data.DataRow <> nil)) then
      CheckLotacao(Data.DataRow);
    aNode := stItems.GetNext(aNode);
  end;
end;

procedure TfmNovaRequisicao.cmdLotacoesClick(Sender : TObject);
var
  aNode: PVirtualNode;
  Data:  PGridData;
  aRua, aNivel: Integer;
  aCodRef, S, aBox: string;
begin
  aNivel  := 0;
  aCodRef := '';
  aRua    := -1;
  stItems.EndEditNode;
  aNode := stItems.FocusedNode;
  if aNode <> nil then
  begin
    Data := stItems.GetNodeData(aNode);
    if ((Data <> nil) and (Data.DataRow <> nil)) then
    begin
      aCodRef := Data.DataRow.FieldByName['cod_prod'].AsString;
      S := '';
      if stItems.FocusedColumn in [5, 6] then
        S := Data.DataRow.FieldByName[LotacaoMaterialField[lmfDescricao,
          (stItems.FocusedColumn = 6)]].AsString;
      if S = '' then
      begin
        S := Data.DataRow.FieldByName[LotacaoMaterialField[lmfDescricao, False]].AsString;
        if S = '' then
          S := Data.DataRow.FieldByName[LotacaoMaterialField[lmfDescricao, True]].AsString;
      end;
      if S <> '' then
      begin
        aRua   := StrToIntDef(Copy(S, 1, 2), 0);
        aNivel := StrToIntDef(Copy(S, 4, 2), 0);
        aBox   := Copy(S, 7, 2);
      end;
    end;
  end;
  pgReqData.ActivePageIndex := 1;
  if not Assigned(fmNovaLotacao) then
  begin
    fmNovaLotacao             := TfmNovaLotacao.Create(Self);
    fmNovaLotacao.Parent      := tsLotacao;
    fmNovaLotacao.BorderStyle := bsNone;
    fmNovaLotacao.Align       := alClient;
    fmNovaLotacao.OnClose     := LotacaoOnClose;
  end;
  fmNovaLotacao.slAlmoxarifados := Self.eFk_Almoxarifados_Orgm.Items;
  if ((Self.eFk_Almoxarifados_Orgm.Visible) and
    (Self.eFk_Almoxarifados_Orgm.ItemIndex > -1)) then
    fmNovaLotacao.FkAlmoxarifados :=
      LongInt(Self.eFk_Almoxarifados_Orgm.Items.Objects[Self.eFk_Almoxarifados_Orgm.ItemIndex])
  else
  if ((Self.eFk_Almoxarifados_Dstn.Visible) and
    (Self.eFk_Almoxarifados_Dstn.ItemIndex > -1)) then
    fmNovaLotacao.fkAlmoxarifados :=
      LongInt(Self.eFk_Almoxarifados_Dstn.Items.Objects[
      Self.eFk_Almoxarifados_Dstn.ItemIndex]);
  if aRua > -1 then
  begin
    fmNovaLotacao.Rua   := aRua;
    fmNovaLotacao.Nivel := aNivel;
    fmNovaLotacao.Box   := aBox;
  end;
  fmNovaLotacao.CodRef := aCodRef;
  fmNovaLotacao.Show;
end;

procedure TfmNovaRequisicao.SearchReferencia;
var
  aReferencia: string;
  aNode: PVirtualNode;
  Data:  PGridData;
begin
  if stItems.FocusedColumn <> 1 then
    exit;
  aNode := stItems.FocusedNode;
  if aNode = nil then
    exit;
  Data := stItems.GetNodeData(aNode);
  if ((Data = nil) or (Data.DataRow = nil)) then
    exit;
  aReferencia := Data.DataRow.FieldByName['COD_PROD'].AsString;
  with TfmSearchReferencia.Create(Self) do
    try
      SelectedReferencia := aReferencia;
      if ShowModal <> mrOk then
        exit;
      if SelectedReferencia = '' then
        exit;
      aReferencia := SelectedReferencia;
    finally
      Release;
    end;
  if Assigned(stItems.OnNewText) then
  begin
    stItems.OnNewText(stItems, aNode, 1, aReferencia);
    PostMessage(stItems.Handle, wm_keydown, vk_tab, 0);
  end;
end;

procedure TfmNovaRequisicao.stItemsFocusChanged(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex);
var
  Data: PGridData;
  sl:   TStringList;
begin
  if Node = nil then exit;
  Data := stItems.GetNodeData(Node);
  if ((Data = nil) or (Data.DataRow = nil)) then exit;
  eVersion.Items.Clear;
  try
    sl := TStringList(Data.DataRow.UserData);
    if (sl <> nil) then
    begin
      eVersion.Items.Assign(sl);
      eVersion.ItemIndex := eVersion.Items.IndexOfObject(
        TObject(Data.DataRow.FieldByName['fk_ficha_tecnica'].AsInteger));
    end;
  finally
    paVersion.Visible := (eVersion.Items.Count > 0);
    paMsg.Visible     := (paVersion.Visible);
  end;
  if stItems.IsEditing then
    stItems.EndEditNode;
  if ((Column = 1) or (Column = 3) or
     ((Column = 5) and (eFk_Almoxarifados_Orgm.Visible)) or
     ((Column = 6) and (eFk_Almoxarifados_Dstn.Visible))) then
    stItems.EditNode(Node, Column);
end;

procedure TfmNovaRequisicao.eVersionClick(Sender : TObject);
var
  Node: PVirtualNode;
  fkFichaTecnica: Integer;
  S:    string;
  L, P: Integer;
  Data: PGridData;
begin
  if ((eVersion.ItemIndex < 0) or ( not (eVersion.Visible))) then exit;
  Node := stItems.FocusedNode;
  if Node = nil then
    exit;
  Data := stItems.GetNodeData(Node);
  if ((Data = nil) or (Data.DataRow = nil)) then
    exit;
  fkFichaTecnica := LongInt(eVersion.Items.Objects[eVersion.ItemIndex]);
  if fkFichaTecnica = Data.DataRow.FieldByName['fk_ficha_tecnica'].AsInteger then
    exit;
  S := eVersion.Items[eVersion.ItemIndex];
  L := Length(S);
  if L < 1 then
    exit;
  P := Pos('.', S);
  if P < 0 then
    exit;
  if S[L] = '*' then
  begin
    Data.DataRow.FieldByName['flag_atv'].AsInteger := 1;
    Delete(S, L, 1);
  end
  else
    Data.DataRow.FieldByName['flag_atv'].AsInteger := 0;
  Data.DataRow.FieldByName['fk_ficha_tecnica'].AsInteger := fkFichaTecnica;
  Data.DataRow.FieldByName['maj_ver'].AsInteger := StrToIntDef(Copy(S, 1, P - 1), 0);
  Data.DataRow.FieldByName['min_ver'].AsInteger := StrToIntDef(Copy(S, P + 1, 255), 0);
  CheckLotacao(Data.DataRow);
end;

function TfmNovaRequisicao.GetAlmoxDstn: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Almoxarifados_Dstn.ItemIndex;
  if (aIdx > -1) and (eFk_Almoxarifados_Dstn.Items.Objects[aIdx] <> nil) then
    Result := LongInt(eFk_Almoxarifados_Dstn.Items.Objects[aIdx]);
end;

function TfmNovaRequisicao.GetAlmoxOrgm: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Almoxarifados_Orgm.ItemIndex;
  if (aIdx > -1) and (eFk_Almoxarifados_Orgm.Items.Objects[aIdx] <> nil) then
    Result := LongInt(eFk_Almoxarifados_Orgm.Items.Objects[aIdx]);
end;

function TfmNovaRequisicao.GetDtaDoc: TDate;
begin
  Result := eDta_Doc.Date;
end;

function TfmNovaRequisicao.GetEmployee: Integer;
var
  aIdx: Integer;
  aRow: TDataRow;
begin
  Result := 0;
  aIdx := eFk_Funcionario.ItemIndex;
  if (aIdx > -1) and (eFk_Funcionario.Items.Objects[aIdx] <> nil) then
  begin
    aRow   := TDataRow(eFk_Funcionario.Items.Objects[aIdx]);
    Result := aRow.FieldByName['PK_CADASTROS'].AsInteger;
  end;
end;

function TfmNovaRequisicao.GetNumDoc: Integer;
begin
  Result := eNum_Doc.AsInteger;
end;

function TfmNovaRequisicao.GetObsReq: TStrings;
begin
  Result := TStringList.Create;
  if (eObs_Req.Lines.Text <> '') then
    Result.Assign(eObs_Req.Lines);
end;

function TfmNovaRequisicao.GetFkTypeMov: Integer;
begin
  Result := 0;
  with eFk_Tipo_Movim_Estq do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypeMoviment(Items.Objects[ItemIndex]).PkTypeMoviment;
end;

procedure TfmNovaRequisicao.SetAlmoxDstn(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to eFk_Almoxarifados_Dstn.Items.Count - 1 do
    if (eFk_Almoxarifados_Dstn.Items.Objects[i] <> nil) and
       (LongInt(eFk_Almoxarifados_Dstn.Items.Objects[i]) = Value) then
    begin
      eFk_Almoxarifados_Dstn.ItemIndex := i;
      break;
    end;
end;

procedure TfmNovaRequisicao.SetAlmoxOrgm(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to eFk_Almoxarifados_Orgm.Items.Count - 1 do
    if (eFk_Almoxarifados_Orgm.Items.Objects[i] <> nil) and
       (LongInt(eFk_Almoxarifados_Orgm.Items.Objects[i]) = Value) then
    begin
      eFk_Almoxarifados_Orgm.ItemIndex := i;
      break;
    end;
end;

procedure TfmNovaRequisicao.SetDtaDoc(const Value: TDate);
begin
  eDta_Doc.Date := Value;
end;

procedure TfmNovaRequisicao.SetEmployee(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to eFk_Funcionario.Items.Count - 1 do
    if (eFk_Funcionario.Items.Objects[i] <> nil) and
       (TDataRow(eFk_Funcionario.Items.Objects[i]).FieldByName['PK_CADASTROS'].AsInteger = Value) then
    begin
      eFk_Funcionario.ItemIndex := i;
      break;
    end;
end;

procedure TfmNovaRequisicao.SetNumDoc(const Value: Integer);
begin
  eNum_Doc.AsInteger := Value;
end;

procedure TfmNovaRequisicao.SetObsReq(const Value: TStrings);
begin
  eObs_Req.Clear;
  if (Value <> nil) then
    eObs_Req.Lines.Assign(Value);
end;

procedure TfmNovaRequisicao.SetFkTypeMov(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to eFk_Tipo_Movim_Estq.Items.Count - 1 do
    if (eFk_Tipo_Movim_Estq.Items.Objects[i] <> nil) and
       (TTypeMoviment(eFk_Tipo_Movim_Estq.Items.Objects[i]).PkTypeMoviment = Value) then
    begin
      eFk_Tipo_Movim_Estq.ItemIndex := i;
      break;
    end;
end;

function TfmNovaRequisicao.GetFkTypeDoc: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Tipo_Documentos.ItemIndex;
  if (aIdx > -1) and (eFk_Tipo_Documentos.Items.Objects[aIdx] <> nil) then
    Result := TTypeDocument(eFk_Tipo_Documentos.Items.Objects[aIdx]).PkTypeDocument;
end;

procedure TfmNovaRequisicao.SetFkTypeDoc(const Value: Integer);
var
  i: Integer;
begin
  for i := 0 to eFk_Tipo_Documentos.Items.Count - 1 do
    if (eFk_Tipo_Documentos.Items.Objects[i] <> nil) and
       (LongInt(eFk_Tipo_Documentos.Items.Objects[i]) = Value) then
    begin
      eFk_Tipo_Documentos.ItemIndex := i;
      break;
    end;
end;

procedure TfmNovaRequisicao.stItemsNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) or (not (Column in [1, 3, 5, 6])) or (NewText = '') then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Column of
    1: if (not GetProductReq(Data^.DataRow, AnsiUpperCase(NewText))) then
         Dados.DisplayHint(spGrid, 'Produto ' + AnsiUpperCase(NewText) +
           ' não encontrado!');
    3: Data^.DataRow.FieldByName['QTD_ITM'].AsFloat := StrToFloatDef(NewText, 1);
    5:
      if eFk_Almoxarifados_Orgm.Visible then
      begin
        Data^.DataRow.FieldByName['DSC_LOT_ORGM'].AsString := AnsiUpperCase(NewText);
        CheckLotacao(Data^.DataRow);
      end;
    6:
      if eFk_Almoxarifados_Dstn.Visible then
      begin
        Data^.DataRow.FieldByName['DSC_LOT_DSTN'].AsString := AnsiUpperCase(NewText);
        CheckLotacao(Data^.DataRow);
      end;
  end;
end;

function TfmNovaRequisicao.GetProductReq(ARow: TDataRow; ACodRef: string): Boolean;
begin
  // Get Product from Reference and set Data^.DataRow fields
  Result := False;
  if (ARow = nil) or (ACodRef = '') or
     (ARow.FieldByName['COD_PROD'].AsString = ACodRef) then
    exit;
  with dmSysEstq do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlProdutosReq);
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('TypeCode').AsInteger := Ord(GetFlagCode);
      qrSqlAux.ParamByName('CodRef').AsString   := ACodRef;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      ARow.FieldByName['FK_PRODUTOS'].AsInteger := qrSqlAux.FieldByName('PK_PRODUTOS').AsInteger;
      ARow.FieldByName['COD_PROD'].AsString     := qrSqlAux.FieldByName('COD_REF').AsString;
      ARow.FieldByName['DSC_PROD'].AsString     := qrSqlAux.FieldByName('DSC_PROD').AsString;
      ARow.FieldByName['QTD_ITM'].AsFloat       := 1;
      ARow.FieldByName['DSC_UNI'].AsString      := qrSqlAux.FieldByName('DSC_UNI').AsString;
      if (ARow.FindField['FK_UNIDADES'] <> nil) then
        ARow.FieldByName['FK_UNIDADES'].AsInteger := qrSqlAux.FieldByName('FK_UNIDADES').AsInteger
      else
        ARow.AddField(qrSqlAux.FieldByName('FK_UNIDADES'));
      if (ARow.FindField['FLAG_FRAC'] <> nil) then
        ARow.FieldByName['FLAG_FRAC'].AsInteger := qrSqlAux.FieldByName('FLAG_FRAC').AsInteger
      else
        ARow.AddField(qrSqlAux.FieldByName('FLAG_FRAC'));
      if (ARow.FindField['MAJ_VER'] <> nil) then
        ARow.FieldByName['MAJ_VER'].AsInteger := qrSqlAux.FieldByName('MAJ_VER').AsInteger
      else
        ARow.AddField(qrSqlAux.FieldByName('MAJ_VER'));
      if (ARow.FindField['MIN_VER'] <> nil) then
        ARow.FieldByName['MIN_VER'].AsInteger := qrSqlAux.FieldByName('MIN_VER').AsInteger
      else
        ARow.AddField(qrSqlAux.FieldByName('MIN_VER'));
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
  Result := True;
end;

function TfmNovaRequisicao.GetDtaReq: TDate;
begin
  Result := eDta_Req.Date;
end;

function TfmNovaRequisicao.GetPkRequest: Integer;
begin
  Result := ePk_Requisicoes.AsInteger;
end;

procedure TfmNovaRequisicao.SetDtaReq(const Value: TDate);
begin
  eDta_Req.Clear;
  if (Value > 0) then
    eDta_Req.Date := Value;
end;

procedure TfmNovaRequisicao.SetPkRequest(const Value: Integer);
begin
  ePk_Requisicoes.AsInteger := Value;
end;

procedure TfmNovaRequisicao.LotacaoOnClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (fmNovaLotacao.LotacoesUpdated) then
    RevalidateLotacoes;
  pgReqData.ActivePageIndex := 0;
end;

function TfmNovaRequisicao.GetDocumentType: TDocumentType;
begin
  Result := dtCI;
  with eFk_Tipo_Documentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypeDocument(Items.Objects[ItemIndex]).FlagTDoc;
end;

function TfmNovaRequisicao.GetFlagCode: TCodeTypes;
begin
  Result := pcReference;
  with eFk_Tipo_Movim_Estq do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
        Result := TTypeMoviment(Items.Objects[ItemIndex]).FlagCode;
end;

function TfmNovaRequisicao.GetFlagES: TMovimentations;
begin
  Result := mvInput;
  with eFk_Tipo_Movim_Estq do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
        Result := TTypeMoviment(Items.Objects[ItemIndex]).FlagTMov;
end;

procedure TfmNovaRequisicao.eFk_Tipo_Movim_EstqSelect(Sender: TObject);
var
  aRow: TTypeMoviment;
begin
  if eFk_Tipo_Movim_Estq.ItemIndex < 0 then exit;
  with eFk_Tipo_Movim_Estq do
  begin
    aRow := TTypeMoviment(Items.Objects[ItemIndex]);
    if aRow = nil then exit;
    case aRow.FlagLocMov of
      lmGeneral:
      begin
        eFk_Almoxarifados_Orgm.Visible := False;
        eFk_Almoxarifados_Dstn.Visible := False;
      end;
      lmAlmox, lmBoth:
      case aRow.FlagTMov of
        mvInput, mvTransfer:
          begin
            eFk_Almoxarifados_Orgm.Visible := False;
            eFk_Almoxarifados_Dstn.Visible := True;
          end;
        mvOutput:
          begin
            eFk_Almoxarifados_Orgm.Visible := True;
            eFk_Almoxarifados_Dstn.Visible := False;
          end;
        mvAdjustment:
          begin
            eFk_Almoxarifados_Orgm.Visible := True;
            eFk_Almoxarifados_Dstn.Visible := True;
          end;
        end;
    end;
  end;
  if not (eFk_Almoxarifados_Orgm.Visible) then
    eFk_Almoxarifados_Orgm.ItemIndex := -1;
  if not (eFk_Almoxarifados_Dstn.Visible) then
    eFk_Almoxarifados_Dstn.ItemIndex := -1;
  lFk_Almoxarifados_Orgm.Visible := eFk_Almoxarifados_Orgm.Visible;
  lFk_Almoxarifados_Dstn.Visible := eFk_Almoxarifados_Dstn.Visible;
  SignalizeChange(Sender);
  case GetDocumentType of
    dtNF        ,
    dtPedido    ,
    dtOS        :
      case GetFlagES of
        mvInput     : LoadFuncionarios(SqlFornecedores);
        mvOutput    : LoadFuncionarios(SqlClientes);
      end;
    dtCI        :
      case GetFlagES of
        mvInput     : LoadFuncionarios(SqlFornecedores);
        mvOutput    : LoadFuncionarios(SqlClientes);
        mvTransfer  ,
        mvAdjustment: LoadFuncionarios(SqlFuncionarios);
      end;
    dtOP        ,
    dtRequisicao: LoadFuncionarios(SqlFuncionarios);
  end;
end;

end.

