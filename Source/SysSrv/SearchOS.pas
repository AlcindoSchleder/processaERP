unit SearchOS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, StdCtrls, Buttons, TSysSrvAux, TSysSrv, ExtCtrls,
  ComCtrls, OsForms, TSysMan, TSysCad;

type
  TfmSearchOS = class(TOSForm)
    paDetails  : TPanel;
    Shape1     : TShape;
    im         : TImage;
    Label1     : TLabel;
    cmdSearchOS: TSpeedButton;
    stOwner    : TStaticText;
    stTypeOS   : TStaticText;
    eStatusOS  : TComboBox;
    stStatusOS : TStaticText;
    vtSearch   : TVirtualStringTree;
    eTypeOS    : TComboBox;
    stPkOS     : TStaticText;
    ePkOS      : TEdit;
    eFkOwners  : TComboBox;
    stFkRoads  : TStaticText;
    eFkRoads   : TComboBox;
    sbChangeAllStatus: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure eTypeOSChange(Sender: TObject);
    procedure eStatusOSChange(Sender: TObject);
    procedure eFkOwnersChange(Sender: TObject);
    procedure eFkRoadsChange(Sender: TObject);
    procedure cmdSearchOSClick(Sender: TObject);
    procedure vtSearchChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtSearchDblClick(Sender: TObject);
    procedure vtSearchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure sbChangeAllStatusClick(Sender: TObject);
  private
    { Private declarations }
    FCheckCount    : Integer;
    FActiveCompany : TCompany;
    FActiveTypeOS  : TTypeServiceOrder;
    FTypeES        : TTypeES;
    FActiveOwner   : TOwner;
    FActiveStatusOS: TStatusOS;
    FActiveRodovia : TRodovias;
    FServiceOrder  : TServiceOrder;
    procedure LoadTypeOS;
    procedure LoadStatusOS;
    procedure LoadRoads;
    procedure LoadOwners;
    procedure SetTypeES(AValue: TTypeES);
    procedure GetServiceOrderItens(ANode: PVirtualNode; APkOS: Integer);
    procedure SetCheckCount(AValue: Integer);
    procedure ClearControls(Sender: TObject);
    procedure ChangeFkEmpresas(Sender: TObject; const Value: Integer;
                var Allowed: Boolean);
    procedure ChangeFkTypeOS(Sender: TObject; const Value: Integer;
                var Allowed: Boolean);
    procedure ChangeFkCadastros(Sender: TObject; const Value: Integer;
                var Allowed: Boolean);
    procedure ChangeFkRodovias(Sender: TObject; const Value: Integer;
                var Allowed: Boolean);
    procedure ChangeFkStatusOS(Sender: TObject; const Value: Integer;
                var Allowed: Boolean);
    procedure CheckError(Sender: TObject; AError: TCheckErrorType; var AMsg: string);
    procedure SetActiveTypeOS  (AFkTypeServiceOrder: Integer);
    procedure SetActiveOwner   (AFkOwner           : Integer);
    procedure SetActiveStatusOS(AFkStatusOS        : Integer);
    procedure SetActiveRodovia (AFkRodovias        : Integer);
    procedure ActiveControls(AEnable: Boolean);
  protected
    { Protected declarations }
    property  TypeES    : TTypeES read FTypeES     write SetTypeES     default esSaida;
    property  CheckCount: Integer read FCheckCount write SetCheckCount default 0;
  public
    { Public declarations }
    procedure ChangeCompany(Sender: TObject; var Allowed: Boolean;
                const AFocused: Boolean);
    procedure ScrollOS(Sender: TForm; var APkOS: Integer;
                const ADirection: TDirectionScroll; var AEnabled: Boolean);
    property  ActiveCompany;
    property  PkServiceOrder;
  end;

implementation

uses CmmConst, Dado, mSysSrv, SrvArqSql, DB, FuncoesDB, Funcoes, ProcType,
  GridRow, ProcUtils;

{$R *.dfm}

const
  DscrAux: array [esEntrada..esBoth] of string = ('Fornecedor', 'Cliente',
    'Fornecedor/Cliente');

procedure TfmSearchOS.FormCreate(Sender: TObject);
begin
  inherited;
  vtSearch.Images := Dados.Image16;
  vtSearch.Header.Images := Dados.Image16;
  AllowExit   := True;
  CountSearch := 0;
  Dados.Image16.GetBitmap(35, cmdSearchOS.Glyph);
  cmdSearchOS.Down := False;
  cmdSearchOS.Hint := 'Pesquisar | Pesquisa o arquivo com os parâmetros informados';
  Dados.Image16.GetBitmap(56, sbChangeAllStatus.Glyph);
//  OnChangeCompany := ChangeCompany;
  FActiveCompany := TCompany.Create;
  FCheckCount := 0;
  LoadTypeOS;
  LoadStatusOS;
  LoadRoads;
  TypeES := esBoth;
  ActiveControls(True);
end;

procedure TfmSearchOS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FActiveCompany.Free;
  FActiveCompany  := nil;
  FActiveTypeOS   := nil;
  FActiveOwner    := nil;
  FActiveStatusOS := nil;
  FActiveRodovia  := nil;
  ReleaseTreeNodes(vtSearch);
  ReleaseCombos(eTypeOS, toObject);
  ReleaseCombos(eStatusOS, toObject);
  ReleaseCombos(eFkRoads, toObject);
  ReleaseCombos(eFkOwners, toObject);
end;

procedure TfmSearchOS.LoadTypeOS;
begin
  ReleaseCombos(eTypeOS, toObject);
  eTypeOS.Items.AddStrings(dmSysSrv.GetTypeServiceOrder);
end;

procedure TfmSearchOS.LoadStatusOS;
begin
  ReleaseCombos(eStatusOS, toObject);
  eStatusOS.Items.AddStrings(dmSysSrv.GetStatusServiceOrder);
end;

procedure TfmSearchOS.LoadRoads;
begin
  ReleaseCombos(eFkRoads, toObject);
  eFkRoads.Items.AddStrings(dmSysSrv.GetHighWay);
end;

procedure TfmSearchOS.LoadOwners;
begin
  ReleaseCombos(eFkOwners, toObject);
  eFkOwners.Items.AddStrings(dmSysSrv.GetOwners(FTypeES));
end;

procedure TfmSearchOS.eTypeOSChange(Sender: TObject);
var
  Idx: Integer;
begin
  FActiveTypeOS := nil;
  TypeES        := esBoth;
  Idx := eTypeOS.ItemIndex;
  if (Idx > 0) and (eTypeOS.Items.Objects[Idx] <> nil) then
  begin
    FActiveTypeOS := TTypeServiceOrder(eTypeOS.Items.Objects[Idx]);
    TypeES        := FActiveTypeOS.FlagES;
  end;
end;

procedure TfmSearchOS.SetTypeES(AValue: TTypeES);
begin
  if (AValue <> FTypeES) then
  begin
    FTypeES := AValue;
    if (vtSearch.Header.Columns.Count > 2) then
      vtSearch.Header.Columns.Items[1].Text := DscrAux[FTypeES];
    LoadOwners;
  end;
end;

procedure TfmSearchOS.eStatusOSChange(Sender: TObject);
var
  Idx, IdxAnt: Integer;
begin
  if (FActiveStatusOS <> nil) then
    IdxAnt := FActiveStatusOS.Index
  else
    IdxAnt := 0;
  FActiveStatusOS := nil;
  Idx := eStatusOS.ItemIndex;
  if (Idx > 0) and (eStatusOS.Items.Objects[Idx] <> nil) then
    FActiveStatusOS := TStatusOS(eStatusOS.Items.Objects[Idx]);
  if (FActiveStatusOS <> nil) and (cmdSearchOS.Down) and
     (FActiveStatusOS.FlagStt in [stParcialFinished, stFinished]) then
  begin
    eStatusOS.ItemIndex := IdxAnt;
    if IdxAnt > 0 then
      FActiveStatusOS := TStatusOS(eStatusOS.Items.Objects[IdxAnt])
    else
      FActiveStatusOS := nil;
  end;
end;

procedure TfmSearchOS.eFkOwnersChange(Sender: TObject);
var
  Idx: Integer;
begin
  FActiveOwner := nil;
  Idx := eFkOwners.ItemIndex;
  if (Idx > 0) and (eFkOwners.Items.Objects[Idx] <> nil) then
    FActiveOwner := TOwner(eFkOwners.Items.Objects[Idx]);
end;

procedure TfmSearchOS.eFkRoadsChange(Sender: TObject);
var
  Idx: Integer;
begin
  FActiveRodovia := nil;
  Idx := eFkRoads.ItemIndex;
  if (Idx > 0) and (eFkRoads.Items.Objects[Idx] <> nil) then
    FActiveRodovia := TRodovias(eFkRoads.Items.Objects[Idx]);
end;

procedure TfmSearchOS.cmdSearchOSClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  cmdSearchOS.Glyph := nil;
  Dados.Image16.GetBitmap(43, cmdSearchOS.Glyph);
  cmdSearchOS.Hint    := 'Nova pesquisa | Limpa os controles para realizar uma nova pesquisa';
  cmdSearchOS.OnClick := ClearControls;
  cmdSearchOS.Repaint;
  ActiveControls(False);
  if vtSearch.RootNodeCount > 0 then
    ReleaseTreeNodes(vtSearch);
  with dmSysSrv do
  begin
    if SqlAux.Active then SqlAux.Close;
    SqlAux.SQL.Clear;
    SqlAux.SQL.Add(SqlOS);
    if FActiveTypeOS <> nil then
      SqlAux.SQL.Add(SqlAnd + 'Ors.FK_TIPO_ORDENS_SERVICOS = :FkTipoOrdensServicos ' + NL);
    if FActiveOwner <> nil then
      SqlAux.SQL.Add(SqlAnd + 'Ors.FK_CADASTROS = :FkCadastros ' + NL);
    if FActiveStatusOS <> nil then
      SqlAux.SQL.Add(SqlAnd + 'Ors.FK_TIPO_STATUS_OS = :FkTipoStatusOS ' + NL);
    if FActiveRodovia <> nil then
      SqlAux.SQL.Add(SqlAnd + 'Ors.FK_RODOVIAS = :FkRodovias ' + NL);
    SqlAux.SQL.Add(SqlOrderOS);
    if (SqlAux.Params.FindParam('FkEmpresas') <> nil) then
      SqlAux.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
    if (SqlAux.Params.FindParam('FkTipoOrdensServicos') <> nil) then
      SqlAux.Params.FindParam('FkTipoOrdensServicos').AsInteger := FActiveTypeOS.PkTipoOrdensServicos;
    if (SqlAux.Params.FindParam('FkCadastros') <> nil) then
      SqlAux.Params.FindParam('FkCadastros').AsInteger := FActiveOwner.PkCadastros;
    if (SqlAux.Params.FindParam('FkTipoStatusOS') <> nil) then
      SqlAux.Params.FindParam('FkTipoStatusOS').AsInteger := FActiveStatusOS.PkStatusOS;
    if (SqlAux.Params.FindParam('FkRodovias') <> nil) then
      SqlAux.Params.FindParam('FkRodovias').AsInteger := FActiveRodovia.PkRodovias;
    if not SqlAux.Active then SqlAux.Open;
    vtSearch.NodeDataSize := SizeOf(TGridData);
    vtSearch.BeginUpdate;
    try
      if not SqlAux.IsEmpty then
      begin
        SqlAux.First;
        while not SqlAux.Eof do
        begin
          Node := vtSearch.AddChild(nil);
          if Node <> nil then
          begin
            Data           := vtSearch.GetNodeData(Node);
            Data^.Level    := vtSearch.GetNodeLevel(Node);
            Data^.Node     := Node;
            Data^.DataRow  := TDataRow.CreateFromDataSet(nil, SqlAux, True);
            GetServiceOrderItens(Node, SqlAux.FindField('PK_ORDENS_SERVICOS').AsInteger);
          end;
          SqlAux.Next;
        end;
      end
      else
        Application.MessageBox(PAnsiChar('Busca OS: Nenhum Documento Encontrado'),
          PAnsiChar(Application.Name), MB_ICONWARNING + MB_OK);
    finally
      vtSearch.EndUpdate;
      CountSearch := vtSearch.RootNodeCount;
      if SqlAux.Active then SqlAux.Close;
    end;
  end;
end;

procedure TfmSearchOS.GetServiceOrderItens(ANode: PVirtualNode; APkOS: Integer);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (ANode = nil) or (APkOS <= 0) then exit;
  with dmSysSrv do
  begin
    if SqlKey.Active then SqlKey.Close;
    SqlKey.SQL.Clear;
    SqlKey.SQL.Add(SqlOSItens);
    try
      if (SqlKey.Params.FindParam('FkEmpresas') <> nil) then
        SqlKey.Params.FindParam('FkEmpresas').AsInteger := Dados.PkCompany;
      if (SqlKey.Params.FindParam('FkOrdensServicos') <> nil) then
        SqlKey.Params.FindParam('FkOrdensServicos').AsInteger := APkOS;
      if not SqlKey.Active then SqlKey.Open;
      if not SqlKey.IsEmpty then
      begin
        SqlKey.First;
        while not SqlKey.Eof do
        begin
          Node := vtSearch.AddChild(ANode);
          if Node <> nil then
          begin
            Data           := vtSearch.GetNodeData(Node);
            Data^.Level    := vtSearch.GetNodeLevel(Node);
            Data^.Node     := Node;
            Data^.DataRow  := TDataRow.CreateFromDataSet(nil, SqlKey, True);
          end;
          SqlKey.Next;
        end;
      end;
    finally
      if SqlKey.Active then SqlKey.Close;
    end;
  end;
end;

procedure TfmSearchOS.vtSearchChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  if (Node = nil) or (vtSearch.GetNodeLevel(Node) > 0) then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data <> nil) and (Data.DataRow <> nil) and
     (Data.DataRow.FindField['PK_ORDENS_SERVICOS'] <> nil) then
    PkServiceOrder := Data.DataRow.FieldByName['PK_ORDENS_SERVICOS'].AsInteger;
end;

procedure TfmSearchOS.vtSearchDblClick(Sender: TObject);
var
  Node : PVirtualNode;
  Data : PGridData;
  aForm: TOSForm;
begin
  if (Parent is TTabSheet) then
  begin
    Node := vtSearch.FocusedNode;
    if (Node = nil) then exit;
    Data := vtSearch.GetNodeData(Node);
    if (Data = nil) and (Data^.DataRow = nil) then exit;
    TTabSheet(Parent).PageControl.TabIndex := 0;
    if Assigned(TTabSheet(Parent).PageControl.OnChange) then
      TTabSheet(Parent).PageControl.OnChange(Self);
    aForm := TOSForm(TTabSheet(Parent).PageControl.Pages[0].Tag);
    if (aForm = nil) or (not (aForm is TOSForm)) then exit;
    if (Data^.DataRow.FindField['PK_ORDENS_SERVICOS'] <> nil) then
      aForm.PkServiceOrder := Data^.DataRow.FieldByName['PK_ORDENS_SERVICOS'].AsInteger;
  end;
end;

procedure TfmSearchOS.vtSearchGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data     := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Column >= Data.DataRow.Count) then
    exit;
  CellText := Data^.DataRow.Fields[Column].AsString;
end;

procedure TfmSearchOS.SetCheckCount(AValue: Integer);
begin
  FCheckCount := AValue;
  if FCheckCount < 0 then
    FCheckCount := 0;
  sbChangeAllStatus.Enabled := (FCheckCount > 0);
  eStatusOS.Enabled         := (FCheckCount = 0);
end;

procedure TfmSearchOS.sbChangeAllStatusClick(Sender: TObject);
var
  Node  : PVirtualNode;
  Data  : PGridData;
  aStatus: TStatusOS;
  aCodAut: Integer;
begin
  aCodAut := 0;
  FServiceOrder := TServiceOrder.Create(Self);
  FServiceOrder.OnChangeFkEmpresas  := ChangeFkEmpresas;
  FServiceOrder.OnChangeFkTypeOS    := ChangeFkTypeOS;
  FServiceOrder.OnChangeFkCadastros := ChangeFkCadastros;
  FServiceOrder.OnChangeRodovias    := ChangeFkRodovias;
  FServiceOrder.OnChangeStatus      := ChangeFkStatusOS;
  FServiceOrder.OnCheckError        := CheckError;
  try
    if ActiveCompany = nil then
    begin
      ActiveCompany := TCompany.Create;
      ActiveCompany.PkCompany := Dados.PkCompany;
      ActiveCompany.DscEmp    := Dados.NameCompany;
    end;
    FServiceOrder.FkEmpresas := ActiveCompany;
    if (FActiveStatusOS.FlagAut = 1) then
      aCodAut := Dados.PegaAutoriza('Ordens de Serviços: Atualização para o Status ' +
         'selecionado requer autorização');
    if aCodAut > 0 then
    begin
      Node := vtSearch.GetFirst;
      while Node <> nil do
      begin
        if (vtSearch.GetNodeLevel(Node) = 0) and
           (Node.CheckState = csCheckedNormal) then
        begin
          Data := vtSearch.GetNodeData(Node);
          if (Data <> nil) and (Data^.DataRow <> nil) and
             (Data^.DataRow.FindField['PK_ORDENS_SERVICOS'] <> nil) then
          begin
            aStatus := TStatusOS(eStatusOS.Items.Objects[FActiveStatusOS.Index]);
            FServiceOrder.PkOS := Data^.DataRow.FieldByName['PK_ORDENS_SERVICOS'].AsInteger;
            if dmSysSrv.GetServiceOrder(FServiceOrder, FServiceOrder.FkEmpresas.PkCompany,
               FServiceOrder.PkOS) then
            begin
              if aCodAut > 0 then
                FServiceOrder.CodAut := aCodAut;
              FServiceOrder.FkStatusOS := aStatus;
              case aStatus.FlagStt of
                stFinished: FServiceOrder.DtaLiq  := Date;
                stCanceled: FServiceOrder.DtaCanc := Date;
                stBlocked : FServiceOrder.DtaBlq  := Date;
                stApproved: FServiceOrder.DtaAprv := Date;
              end;
              FServiceOrder.CheckRules(True);
              FServiceOrder.CodAut := 0;
              dmSysSrv.MoveObject2Data(FServiceOrder, dbmEdit);
              if Data^.DataRow.FindField['DSC_STT'] <> nil then
                Data^.DataRow.FieldByName['DSC_STT'].AsString := aStatus.DscStt;
            end;
          end;
        end;
        Node := vtSearch.GetNext(Node);
      end;
    end
    else
      Application.MessageBox(PAnsiChar('Erro: Não autorizado a executar esta operação'),
        PAnsiChar(Application.Title), MB_ICONERROR + MB_OK);
  finally
    FServiceOrder.Free;
    FServiceOrder := nil;
  end;
end;

procedure TfmSearchOS.ScrollOS(Sender: TForm; var APkOS: Integer;
             const ADirection: TDirectionScroll; var AEnabled: Boolean);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtSearch.GetFirstSelected;
  while Node <> nil do
  begin
    case ADirection of
      dsPrior: Node := vtSearch.GetPrevious(Node);
      dsNext : Node := vtSearch.GetNext(Node)
    end;
    if (Node <> nil) and (vtSearch.GetNodeLevel(Node) = 0) then
      Break;
  end;
  aEnabled := (Node <> nil);
  if Node = nil then exit;
  Data := vtSearch.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or
     (Data^.DataRow.FindField['PK_ORDENS_SERVICOS'] = nil) then
    exit;
  APkOS := Data^.DataRow.FieldByName['PK_ORDENS_SERVICOS'].AsInteger;
end;

procedure TfmSearchOS.ChangeCompany(Sender: TObject; var Allowed: Boolean;
            const AFocused: Boolean);
begin
  if (vtSearch.RootNodeCount > 0) then
  begin
    if AFocused then
      Allowed := (Application.MessageBox(PAnsiChar('Atenção: A seleção de nova ' +
        'empresa exige nova pesquisa. Deseja continuar'),
        PAnsiChar(Application.Title), MB_ICONQUESTION + MB_YESNO) = mrYes);
    if Allowed then
      ClearControls(self);
  end;
end;

procedure TfmSearchOS.ClearControls(Sender: TObject);
begin
  cmdSearchOS.Glyph := nil;
  Dados.Image16.GetBitmap(35, cmdSearchOS.Glyph);
  cmdSearchOS.Hint := 'Pesquisar | Pesquisa o arquivo com os parâmetros informados';
  cmdSearchOS.OnClick := cmdSearchOSClick;
  cmdSearchOS.Repaint;
  ActiveControls(True);
  ReleaseTreeNodes(vtSearch);
  CheckCount := 0;
  ReleaseCombos(eFkOwners, toObject);
  ePkOS.Text      := '';
  FActiveOwner    := nil;
  FActiveRodovia  := nil;
  FActiveStatusOS := nil;
  FActiveTypeOS   := nil;
  if eTypeOS.Items.Count > 0 then
    eTypeOS.ItemIndex := 0
  else
    eTypeOS.ItemIndex := -1;
  if eStatusOS.Items.Count > 0 then
    eStatusOS.ItemIndex := 0
  else
    eStatusOS.ItemIndex := -1;
  if eFkRoads.Items.Count > 0 then
    eFkRoads.ItemIndex := 0
  else
    eFkRoads.ItemIndex := -1;
end;

procedure TfmSearchOS.ChangeFkEmpresas(Sender: TObject; const Value: Integer;
            var Allowed: Boolean);
begin
  if (FServiceOrder.FkEmpresas = nil) or
     (FServiceOrder.FkEmpresas.PkCompany = 0) or
     (FServiceOrder.FkEmpresas.PkCompany = Value) then
    Allowed := True
  else
    Allowed := False;
  if (Allowed) and (FServiceOrder.FkEmpresas = nil) and
     (ActiveCompany <> nil) and (Value = 0) then
    FServiceOrder.FkEmpresas := ActiveCompany;
end;

procedure TfmSearchOS.ChangeFkTypeOS(Sender: TObject; const Value: Integer;
            var Allowed: Boolean);
begin
  if (FServiceOrder.FkTypeServiceOrder = nil) then
    SetActiveTypeOS(Value);
  if Assigned(FActiveTypeOS) and (not Allowed) then
    FServiceOrder.FkTypeServiceOrder := FActiveTypeOS;
  if not Assigned(FActiveTypeOS) then
    Allowed := False;
end;

procedure TfmSearchOS.ChangeFkCadastros(Sender: TObject; const Value: Integer;
            var Allowed: Boolean);
begin
  if (FServiceOrder.FkCadastros = nil) then
    SetActiveOwner(Value);
  if Assigned(FActiveOwner) and (not Allowed) then
    FServiceOrder.FkCadastros := FActiveOwner;
  if not Assigned(FActiveOwner) then
    Allowed := False;
end;

procedure TfmSearchOS.ChangeFkRodovias(Sender: TObject; const Value: Integer;
            var Allowed: Boolean);
begin
  if (FServiceOrder.FkRodovias = nil) then
    SetActiveRodovia(Value);
  if Assigned(FActiveRodovia) and (not Allowed) then
    FServiceOrder.FkRodovias := FActiveRodovia;
  if not Assigned(FActiveRodovia) then
    Allowed := False;
end;

procedure TfmSearchOS.ChangeFkStatusOS(Sender: TObject; const Value: Integer;
            var Allowed: Boolean);
begin
  if FServiceOrder.FkStatusOS = nil then
    SetActiveStatusOS(Value);
  if Assigned(FActiveStatusOS) and (not Allowed) then
    FServiceOrder.FkStatusOS := FActiveStatusOS;
  if not Assigned(FActiveStatusOS) then
    Allowed := False;
end;

procedure TfmSearchOS.CheckError(Sender: TObject; AError: TCheckErrorType;
  var AMsg: string);
const
  Msg: array [ceNullDtaOS..ceNullTotal] of string =
    ('Erro: Falta a Data da Ordem de Serviços',
     'Erro: Data Inicial da Ordem de Servicos Inválida',
     'Erro: Data Final da Ordem de Servicos Inválida',
     'Erro: Falta o emitente da Ordem de Serviços',
     'Erro: Falta a Empresa da Ordem de Serviços',
     'Erro: Falta Condição de Pagamento da Ordem de Serviços',
     'Erro: Falta o Status da Ordem de Serviços',
     'Erro: Falta a Data de Finalização da Ordem de Serviços',
     'Erro: Falta a Data de Cancelamento da Ordem de Serviços',
     'Erro: Falta a Data de Bloqueio da Ordem de Serviços',
     'Erro: Falta a Data de Aprovação da Ordem de Serviços',
     'Erro: Autorização negada para este status',
     'Erro: Falta o Tipo da Ordem de Serviços',
     'Erro: Falta o número da Ordem de Serviços',
     'Erro: Não posso usar o status escolhido nesta Ordem de Serviços',
     'Erro: Ordem de Serviços deve ter pelo menos um serviço descriminado',
     'Erro: Total da Ordem de Serviços = 0 ou nulo');
begin
  AMsg := Msg[AError];
end;

procedure TfmSearchOS.SetActiveTypeOS(AFkTypeServiceOrder: Integer);
var
  i: Integer;
begin
  if (AFkTypeServiceOrder <= 0) or (eTypeOS.Items.Count < 2) then
    exit;
  for i := 0 to eTypeOS.Items.Count - 1 do
  begin
    with eTypeOS.Items do
    begin
      if (Assigned(Objects[i]))            and
         (Objects[i] is TTypeServiceOrder) and
         (TTypeServiceOrder(Objects[i]).PkTipoOrdensServicos = AFkTypeServiceOrder) then
      begin
        FActiveTypeOS          := TTypeServiceOrder(Objects[i]);
        TypeES                 := FActiveTypeOS.FlagES;
      end;
    end;
  end;
end;

procedure TfmSearchOS.SetActiveOwner(AFkOwner: Integer);
var
  i: Integer;
begin
  if (AFkOwner <= 0) or (eFkOwners.Items.Count < 2) then
    exit;
  for i := 0 to eFkOwners.Items.Count - 1 do
  begin
    with eFkOwners.Items do
    begin
      if (Assigned(Objects[i])) and
         (Objects[i] is TOwner) and
         (TOwner(Objects[i]).PkCadastros = AFkOwner) then
        FActiveOwner := TOwner(Objects[i]);
    end;
  end;
end;

procedure TfmSearchOS.SetActiveStatusOS(AFkStatusOS: Integer);
var
  i: Integer;
begin
  if (AFkStatusOS <= 0) or (eStatusOS.Items.Count <= 0) then
    exit;
  for i := 0 to eStatusOS.Items.Count - 1 do
  begin
    with eStatusOS.Items do
    begin
      if (Assigned(Objects[i]))    and
         (Objects[i] is TStatusOS) and
         (TStatusOS(Objects[i]).PkStatusOS = AFkStatusOS) then
        FActiveStatusOS := TStatusOS(Objects[i]);
    end;
  end;
end;

procedure TfmSearchOS.SetActiveRodovia(AFkRodovias: Integer);
var
  i: Integer;
begin
  if (AFkRodovias <= 0) or (eFkRoads.Items.Count <= 0) then
    exit;
  for i := 0 to eFkRoads.Items.Count - 1 do
  begin
    with eFkRoads.Items do
    begin
      if (Assigned(Objects[i]))    and
         (Objects[i] is TRodovias) and
         (TRodovias(Objects[i]).PkRodovias = AFkRodovias) then
        FActiveRodovia := TRodovias(Objects[i]);
    end;
  end;
end;

procedure TfmSearchOS.ActiveControls(AEnable: Boolean);
begin
  ePkOS.Enabled     := AEnable;
  eTypeOS.Enabled   := AEnable;
  eFkOwners.Enabled := AEnable;
//  eStatusOS.Enabled := AEnable;
  eFkRoads.Enabled  := AEnable;
end;

end.
