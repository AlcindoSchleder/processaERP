unit CnsSearchDocs;

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
  Dialogs, PrcSysTypes, StdCtrls, Mask, ComCtrls, ToolEdit, CurrEdit, ExtCtrls,
  VirtualTrees, mSysTrans, ProcUtils, CadModel;

type
  TfrmSearch = class(TfrmModel)
    vtSearch: TVirtualStringTree;
    pParams: TPanel;
    eNumNF: TCurrencyEdit;
    eNumDoc: TCurrencyEdit;
    pgSeacrh: TPageControl;
    tsSimulator: TTabSheet;
    tsDocument: TTabSheet;
    eNomCli: TEdit;
    eCnpjRem: TMaskEdit;
    eCnpjDstn: TMaskEdit;
    eTypeRem: TComboBox;
    eTypeDstn: TComboBox;
    lNomCli: TStaticText;
    lCnpjRem: TStaticText;
    lCnpjDstn: TStaticText;
    lNumNF: TStaticText;
    lNumDoc: TStaticText;
    gbPeriod: TGroupBox;
    lDtaIni: TStaticText;
    eDtaIni: TDateEdit;
    lDtaFin: TStaticText;
    eDtaFin: TDateEdit;
    shRazSocRem: TShape;
    shRazSocDstn: TShape;
    lRazSocRem: TLabel;
    lRazSocDstn: TLabel;
    procedure eTypeRemSelect(Sender: TObject);
    procedure eTypeDstnSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure vtSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtSearchFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtSearchGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FOnSelectedDocument: TOnVerifyIDEvent;
    FDocumentType: TDocumentType;
    function  GetCnpjDstn: string;
    function  GetCnpjRem: string;
    function  GetNomCli: string;
    function  GetNumDoc: Integer;
    function  GetNumNF: Integer;
    procedure SetCnpjDstn(const Value: string);
    procedure SetCnpjRem(const Value: string);
    procedure SetNomCli(const Value: string);
    procedure SetNumDoc(const Value: Integer);
    procedure SetNumNF(const Value: Integer);
    procedure SetDocumentType(const Value: TDocumentType);
    procedure SetMaskToControl(ALabel: TStaticText; const AIdx, AField: Integer);
    procedure ChangeState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure BuildSql;
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    property  NomCli      : string        read GetNomCli     write SetNomCli;
    property  CnpjRem     : string        read GetCnpjRem    write SetCnpjRem;
    property  CnpjDstn    : string        read GetCnpjDstn   write SetCnpjDstn;
    property  NumNF       : Integer       read GetNumNF      write SetNumNF;
    property  NumDoc      : Integer       read GetNumDoc     write SetNumDoc;
  public
    { Public declarations }
    property  OnSelectedDocument: TOnVerifyIDEvent read FOnSelectedDocument write FOnSelectedDocument;
    property  DocumentType      : TDocumentType    read FDocumentType       write SetDocumentType;
  end;

var
  frmSearch: TfrmSearch;

implementation

uses Dado, ProcType, GridRow, FuncoesDB;

{$R *.dfm}

{ TfrmSearch }

procedure TfrmSearch.ClearControls;
begin
  Loading := True;
  try
    NomCli   := '';
    CnpjRem  := '';
    CnpjDstn := '';
    NumNF    := 0;
    NumDoc   := 0;
  finally
    Loading := False;
  end;
end;

function TfrmSearch.GetCnpjDstn: string;
begin
  Result := eCnpjDstn.EditText;
end;

function TfrmSearch.GetCnpjRem: string;
begin
  Result := eCnpjRem.EditText;
end;

function TfrmSearch.GetNomCli: string;
begin
  Result := eNomCli.Text;
end;

function TfrmSearch.GetNumDoc: Integer;
begin
  Result := eNumDoc.AsInteger;
end;

function TfrmSearch.GetNumNF: Integer;
begin
  Result := eNumNF.AsInteger;
end;

procedure TfrmSearch.LoadDefaults;
begin
  // Nothing to do;
end;

procedure TfrmSearch.MoveDataToControls;
begin
  // Nothing to do
end;

procedure TfrmSearch.SaveIntoDB;
begin
  // Nothing to do
end;

procedure TfrmSearch.SetCnpjDstn(const Value: string);
begin
  eCnpjDstn.EditText := Value;
end;

procedure TfrmSearch.SetCnpjRem(const Value: string);
begin
  eCnpjRem.EditText := Value;
end;

procedure TfrmSearch.SetDocumentType(const Value: TDocumentType);
begin
  FDocumentType := Value;
  pgSeacrh.ActivePageIndex := Ord(Value);
end;

procedure TfrmSearch.SetMaskToControl(ALabel: TStaticText; const AIdx, AField: Integer);
const
  FIELD_MASK   : array[0..1] of string = ('00.000.000\/0000\-00;0; ', '000.000.000\-00;0; ');
  LABEL_CAPTION: array[0..1] of string = ('C.N.P.J. ', 'C.P.F. ');
  TYPE_FIELD   : array[0..1] of string = ('do Remetente: ', 'do Destinatário: ');
begin
  ALabel.Caption := LABEL_CAPTION[AIdx] + TYPE_FIELD[AField];
  if (ALabel.FocusControl <> nil) then
    TMaskEdit(ALabel.FocusControl).EditMask := FIELD_MASK[AIdx];
end;

procedure TfrmSearch.SetNomCli(const Value: string);
begin
  eNomCli.Text := Value;
end;

procedure TfrmSearch.SetNumDoc(const Value: Integer);
begin
  eNumDoc.AsInteger := Value;
end;

procedure TfrmSearch.SetNumNF(const Value: Integer);
begin
  eNumNF.AsInteger := Value;
end;

procedure TfrmSearch.eTypeRemSelect(Sender: TObject);
begin
  SetMaskToControl(lCnpjRem, eTypeRem.ItemIndex, 0);
end;

procedure TfrmSearch.eTypeDstnSelect(Sender: TObject);
begin
  SetMaskToControl(lCnpjDstn, eTypeDstn.ItemIndex, 1);
end;

procedure TfrmSearch.FormCreate(Sender: TObject);
begin
  inherited;
  pgSeacrh.ActivePageIndex := 0;
  OnInternalState          := ChangeState;
end;

procedure TfrmSearch.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  case AState of
    dbmExecute: BuildSql;
    dbmFind   : ClearControls;
  end;
end;

procedure TfrmSearch.BuildSql;
var
  Node: PVirtualNode;
  Data: PGridData;
const
  SQL_ORDER    = 'select Ped.FK_EMPRESAS, Ped.PK_PEDIDOS as NUM_DOC, Ped.DTA_PED as DTA_DOC, ' + NL +
                 '       Ped.NOM_CAD as RAZ_SOC, Ped.FK_CADASTROS, Cor.DSC_REG as DSC_ORG, ' + NL +
                 '       Cds.DSC_REG as DSC_DST, ' + NL +
                 '       Rem.RAZ_SOC as NOM_REM, Dst.RAZ_SOC as NOM_DST ' + NL +
                 '  from PEDIDOS Ped, PEDIDOS_FRETES Pfr, CADASTROS Cad, ' + NL +
                 '       CARGAS_REGIOES Cds, CARGAS_REGIOES Cor, ' + NL +
                 '       TABELA_ORIGEM_DESTINO Tod, ' + NL +
                 '       CADASTROS Rem, CADASTROS Dst ' + NL +
                 ' where Ped.FK_EMPRESAS              = :FkEmpresas ' + NL +
//                 '   and Ped.DTA_PED                  > (current_date - :ValPed) ' + NL +
                 '   and Pfr.FK_EMPRESAS              = Ped.FK_EMPRESAS ' + NL +
                 '   and Pfr.FK_PEDIDOS               = Ped.PK_PEDIDOS ' + NL +
                 '   and Tod.PK_TABELA_ORIGEM_DESTINO = Pfr.FK_TABELA_ORIGEM_DESTINO ' + NL +
                 '   and Cor.PK_CARGAS_REGIOES        = Tod.FK_CARGAS_REGIOES__ORG ' + NL +
                 '   and Cds.PK_CARGAS_REGIOES        = Tod.FK_CARGAS_REGIOES__DST ' + NL +
                 '   and Cad.PK_CADASTROS             = Ped.FK_CADASTROS ' + NL +
                 '   and Rem.PK_CADASTROS             = Pfr.FK_REMETENTE ' + NL +
                 '   and Dst.PK_CADASTROS             = Pfr.FK_DESTINATARIO';

  SQL_DOCUMENT = 'select Doc.FK_EMPRESAS, Doc.PK_DOCUMENTOS as NUM_DOC, Doc.DATA_DOC as DTA_DOC, ' + NL +
                 '       Cad.RAZ_SOC, Doc.FK_CADASTROS, Cor.DSC_REG as DSC_ORG, ' + NL +
                 '       Cds.DSC_REG as DSC_DST, Doc.FK_TIPO_DOCUMENTOS, ' + NL +
                 '       Rem.RAZ_SOC as NOM_REM, Dst.RAZ_SOC as NOM_DST ' + NL +
                 '  from DOCUMENTOS Doc, DOCUMENTOS_CONHECIMENTOS Dch, ' + NL +
                 '       CADASTROS Cad, TABELA_ORIGEM_DESTINO Tod, ' + NL +
                 '       CARGAS_REGIOES Cds, CARGAS_REGIOES Cor, ' + NL +
                 '       CADASTROS Rem, CADASTROS Dst ' + NL +
                 ' where Doc.FK_EMPRESAS        = :FkEmpresas ' + NL +
                 '   and Dch.FK_EMPRESAS        = Doc.FK_EMPRESAS ' + NL +
                 '   and Dch.FK_TIPO_DOCUMENTOS = Doc.FK_TIPO_DOCUMENTOS ' + NL +
                 '   and Dch.FK_CADASTROS       = Doc.FK_CADASTROS ' + NL +
                 '   and Dch.FK_DOCUMENTOS      = Doc.PK_DOCUMENTOS ' + NL +
                 '   and Cad.PK_CADASTROS       = Doc.FK_CADASTROS ' + NL +
                 '   and Tod.PK_TABELA_ORIGEM_DESTINO = Dch.FK_TABELA_ORIGEM_DESTINO ' + NL +
                 '   and Cor.PK_CARGAS_REGIOES        = Tod.FK_CARGAS_REGIOES__ORG ' + NL +
                 '   and Cds.PK_CARGAS_REGIOES        = Tod.FK_CARGAS_REGIOES__DST ' + NL +
                 '   and Rem.PK_CADASTROS             = Dch.FK_REMETENTE ' + NL +
                 '   and Dst.PK_CADASTROS             = Dch.FK_DESTINATARIO';

  SEARCH_VARS  : array[0..4, dtSimulator..dtDocument] of string =
               (('   and Ped.NOM_CAD = :NomCli '   , '   and Cad.RAZ_SOC = :NomCli '),
                ('   and Rem.DOC_PRI = :CnpjRem '  , '   and Rem.DOC_PRI = :CnpjRem '),
                ('   and Dst.DOC_PRI = :CnpjDstn ' , '   and Dst.DOC_PRI = :CnpjDstn '),
                ('   and Pfr.NUM_NF  = :NumNF '    , '   and Dch.NUM_NF  = :NumNF '),
                ('   and Ped.PK_PEDIDOS = :NumDoc ', '   and Doc.PK_DOCUMENTOS = :NumDoc '));

begin
  with dmSysTrans, vtSearch do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    case DocumentType of
      dtSimulator: qrSqlAux.SQL.Add(SQL_ORDER);
      dtDocument : qrSqlAux.SQL.Add(SQL_DOCUMENT);
    end;
    if (NomCli <> '') then
      qrSqlAux.SQL.Add(SEARCH_VARS[0, DocumentType]);
    if (CnpjRem <> '') then
      qrSqlAux.SQL.Add(SEARCH_VARS[1, DocumentType]);
    if (CnpjDstn <> '') then
      qrSqlAux.SQL.Add(SEARCH_VARS[1, DocumentType]);
    if (NumNF > 0) then
      qrSqlAux.SQL.Add(SEARCH_VARS[1, DocumentType]);
    if (NumDoc > 0) then
      qrSqlAux.SQL.Add(SEARCH_VARS[1, DocumentType]);
    Dados.StartTransaction(qrSqlAux);
    BeginUpdate;
    Screen.Cursor := crSQLWait;
    try
      qrSqlAux.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
//      qrSqlAux.ParamByName('ValPed').AsInteger     := 15;
      if (NomCli <> '') then
        qrSqlAux.ParamByName('NomCli').AsString := NomCli;
      if (CnpjRem <> '') then
        qrSqlAux.ParamByName('CnpjRem').AsString := CnpjRem;
      if (CnpjDstn <> '') then
        qrSqlAux.ParamByName('CnpjDstn').AsString := CnpjDstn;
      if (NumNF > 0) then
        qrSqlAux.ParamByName('NumNF').AsInteger := NumNF;
      if (NumDoc > 0) then
        qrSqlAux.ParamByName('NumDoc').AsInteger := NumDoc;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.Eof) do
      begin
        Node := AddChild(nil);
        if (Node <> nil) then
        begin
          Data := GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.DataRow  := TDataRow.CreateFromDataSet(vtSearch, qrSqlAux, True);
            Data^.Level    := 0;
            Data^.Node     := Node;
            Data^.NodeType := tnData;
          end;
        end;
        qrSqlAux.Next;
      end;
    finally
      Screen.Cursor := crDefault;
      EndUpdate;
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

procedure TfrmSearch.vtSearchGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['NUM_DOC'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DTA_DOC'].AsString;
    2: CellText := Data^.DataRow.FieldByName['NOM_REM'].AsString;
    3: CellText := Data^.DataRow.FieldByName['NOM_DST'].AsString;
    4: CellText := Data^.DataRow.FieldByName['DSC_ORG'].AsString;
    5: CellText := Data^.DataRow.FieldByName['DSC_DST'].AsString;
  end;
end;

procedure TfrmSearch.vtSearchFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['NUM_DOC'].AsInteger;
  if (DocumentType = dtDocument) then
  begin
    dmSysTrans.FkCadastros    := Data^.DataRow.FieldByName['FK_CADASTROS'].AsInteger;
    dmSysTrans.FkTypeDocument := Data^.DataRow.FieldByName['FK_TIPO_DOCUMENTOS'].AsInteger;
  end;
end;

procedure TfrmSearch.vtSearchGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TGridData);
end;

procedure TfrmSearch.FormDestroy(Sender: TObject);
begin
  inherited;
  ReleaseTreeNodes(vtSearch);
end;

end.
