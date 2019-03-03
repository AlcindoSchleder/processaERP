unit EditOperacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, ToolEdit, CurrEdit, Buttons,
  VirtualTrees, CSDVirtualStringTree, dbObjects, IBQuery, ComCtrls, Menus;

type

  TUpdateOperacaoEvent = procedure (Sender: TObject; afkPeca, afkFichaTecnica,
    afkFaseProducao: Integer; afkOperacao: Integer) of object;

  TfmEditOperacao = class(TForm)
    laPecaPai             : TLabel;
    laPecaPaiTitle        : TLabel;
    Shape1                : TShape;
    Label1                : TLabel;
    cbFaseProducao        : TComboBox;
    Label2                : TLabel;
    cbTipoOperacao        : TComboBox;
    Label3                : TLabel;
    edSEQ_OPE             : TCurrencyEdit;
    edCOD_REF             : TEdit;
    Label4                : TLabel;
    edCOD_BARRAS          : TEdit;
    Label5                : TLabel;
    Label6                : TLabel;
    edALT_MAX: TCurrencyEdit;
    Label7                : TLabel;
    edLARG_MAX: TCurrencyEdit;
    Label8                : TLabel;
    edPROF_MAX: TCurrencyEdit;
    Label9                : TLabel;
    edTEMPO_MEDIO         : TCurrencyEdit;
    cmdUpdate             : TBitBtn;
    cmdCancel             : TBitBtn;
    cmdNew                : TBitBtn;
    pgDetalhes            : TPageControl;
    tbPecas               : TTabSheet;
    stPecas               : TCSDVirtualStringTree;
    tbInsumos             : TTabSheet;
    tbServicos            : TTabSheet;
    tbTiposAcabamento     : TTabSheet;
    stInsumos             : TCSDVirtualStringTree;
    stServicos            : TCSDVirtualStringTree;
    stTiposAcabamento     : TCSDVirtualStringTree;
    popServicos           : TPopupMenu;
    cmNewServico          : TMenuItem;
    cmDeleteServico       : TMenuItem;
    popTiposAcabamentos   : TPopupMenu;
    cmNewTipoAcabamento   : TMenuItem;
    cmDeleteTipoAcabamento: TMenuItem;
    popInsumos            : TPopupMenu;
    cmNewInsumo           : TMenuItem;
    cmDeleteInsumo        : TMenuItem;
    tbMaquinas            : TTabSheet;
    stMaquinas            : TCSDVirtualStringTree;
    popMaquinas           : TPopupMenu;
    cmNovaMaquina         : TMenuItem;
    cmNovaFerramenta      : TMenuItem;
    cmDelete               : TMenuItem;
    cmPropriedades: TMenuItem;
    edALT_MIN: TCurrencyEdit;
    edLARG_MIN: TCurrencyEdit;
    edPROF_MIN: TCurrencyEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    cbTipoDocumento: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure stPecasEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure stPecasGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure stPecasNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure stInsumosGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure stInsumosNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure stServicosGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure stServicosNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure stTiposAcabamentoGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure stTiposAcabamentoNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure popServicosPopup(Sender: TObject);
    procedure cmDeleteServicoClick(Sender: TObject);
    procedure cmNewServicoClick(Sender: TObject);
    procedure popTiposAcabamentosPopup(Sender: TObject);
    procedure cmNewTipoAcabamentoClick(Sender: TObject);
    procedure cmDeleteTipoAcabamentoClick(Sender: TObject);
    procedure stPecasChecking(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var NewState: TCheckState; var Allowed: Boolean);
    procedure popInsumosPopup(Sender: TObject);
    procedure cmNewInsumoClick(Sender: TObject);
    procedure cmDeleteInsumoClick(Sender: TObject);
    procedure popMaquinasPopup(Sender: TObject);
    procedure cmNovaMaquinaClick(Sender: TObject);
    procedure cmPropriedadesClick(Sender: TObject);
    procedure cmDeleteClick(Sender: TObject);
    procedure cmNovaFerramentaClick(Sender: TObject);
    procedure stMaquinasGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure stMaquinasDblClick(Sender: TObject);
    procedure signalizeChange(Sender: TObject);
    procedure stPecasChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure stInsumosEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure stMaquinasNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure stMaquinasResize(Sender: TObject);
    procedure stMaquinasEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure stMaquinasColumnDefs1PrepareEdit(Sender: TColumnDef;
      aEdit: TWinControl);
    procedure stMaquinasColumnDefs2PrepareEdit(Sender: TColumnDef;
      aEdit: TWinControl);
    procedure stMaquinasInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure stMaquinasChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure stInsumosColumnDefs1PrepareEdit(Sender: TColumnDef;
      aEdit: TWinControl);
    procedure stServicosColumnDefs1PrepareEdit(Sender: TColumnDef;
      aEdit: TWinControl);
    procedure stTiposAcabamentoColumnDefs1PrepareEdit(Sender: TColumnDef;
      aEdit: TWinControl);
  private
    { Private declarations }
    FslPecas            : TList;
    FUpdateAllowed      : Boolean;
    FfkTipoFasesProducao,
    FfkOperacao         : Integer;
    FfkPeca             : Integer;
    FfkFichaTecnica     : Integer;
    FfkFaseProducao     : Integer;
    FLastfkPeca         : Integer;
    FOnInsertOperacao   : TUpdateOperacaoEvent;
    FOnUpdateOperacao   : TUpdateOperacaoEvent;
    FInsideMove,
    FOperacaoUpdated    : Boolean;
    FLastfkFaseProducao : Integer;
    FLastfkOperacao     : Integer;
    FslInsumos,
    FslServicos,
    FslTiposAcabamento,
    FslMaquinas         : TList;
    FCurrentFerramentaNode,
    FCurrentMaquinaNode :PVirtualNode;
    function  MayClose  :Boolean;
    function  OperacaoSaved:Boolean;
    procedure HandleInsertMaquina(Sender: TObject; afkMaquina: Integer;
      aDescMaquina: string; aTmpStp: Double; aTmpOper: Double;
      aIsDefault: Boolean);
    procedure HandleUpdateMaquina(Sender: TObject; afkMaquina: Integer;
      aDescMaquina: string; aTmpStp: Double; aTmpOper: Double;
      aIsDefault: Boolean);
    procedure HandleInsertFerramenta(Sender: TObject; afkFerramenta: Integer;
      aDescFerramenta: string);
    procedure HandleUpdateFerramenta(Sender: TObject; afkFerramenta: Integer;
      aDescFerramenta: string);
    procedure DeleteMaquina(aNode: PVirtualNode);
    procedure EditMaquina(aNode: PVirtualNode);
    procedure DeleteFerramenta(aNode: PVirtualNode);
    procedure EditFerramenta(FerramentaNode: PVirtualNode);
    procedure ClearPecas;
    procedure SetUpdateAllowed(const Value: Boolean);
    procedure LoadFasesProducao;
    procedure LoadTiposDocumento;
    procedure LoadTiposOperacao;
    procedure SetfkOperacao(const Value: Integer);
    procedure EnableControls;
    procedure ClearOperacao;
    procedure LoadOperacao;
    procedure LoadPecas;
    procedure ClearInsumos;
    procedure LoadInsumos;
    procedure SaveDetalhes(st: TCSDVirtualStringTree; afkOperacao,
      afkFasesProducao, afkTipoFasesProducao: Integer);
    procedure ClearServicos;
    procedure LoadServicos;
    procedure ClearTiposAcabamento;
    procedure LoadTiposAcabamento;
    procedure ClearMaquinas;
    procedure LoadMaquinas;
    procedure SavePecas(afkOperacao, afkFasesProducao, afkTipoFasesProducao: Integer);
    procedure SaveMaquinas(afkOperacao, afkFasesProducao, afkTipoFasesProducao: Integer);
    procedure SetfkPeca(const Value: Integer);
    procedure SetfkFaseProducao(const Value: Integer);
    function CheckPecaOperacao: Boolean;
  public
    { Public declarations }
    property UpdateAllowed     : Boolean              read FUpdateAllowed      write SetUpdateAllowed;
    property fkPeca            : Integer              read FfkPeca             write SetfkPeca;
    property fkFichaTecnica    : Integer              read FfkFichaTecnica     write FfkFichaTecnica;
    property fkOperacao        : Integer              read FfkOperacao         write SetfkOperacao;
    property fkFaseProducao    : Integer              read FfkFaseProducao     write SetfkFaseProducao;
    property OnInsertOperacao  : TUpdateOperacaoEvent read FOnInsertOperacao   write FOnInsertOperacao;
    property OnUpdateOperacao  : TUpdateOperacaoEvent read FOnUpdateOperacao   write FOnUpdateOperacao;
    property OperacaoUpdated   : Boolean              read FOperacaoUpdated;
    property LastfkOperacao    : Integer              read FLastfkOperacao;
    property LastfkFaseProducao: Integer              read FLastfkFaseProducao;
  end;

var
  fmEditOperacao: TfmEditOperacao;

implementation

uses udmFichaTecnica, NovoServicoOperacao, NovoAcabamentoOperacao,
  NovoInsumoOperacao, EditMaquinaOperacao, EditFerramentaOperacao;

{$R *.dfm}

procedure TfmEditOperacao.ClearPecas;
var
  I      : Integer;
  RowData: TRowData;
begin
  for I := 0 to FslPecas.Count - 1 do
  begin
    RowData := TRowData(FslPecas[I]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslPecas[I] := nil;
    end;
  end;
  FslPecas.Clear;
  stPecas.Clear;
end;


procedure TfmEditOperacao.LoadPecas;
var
  RowData   : TRowData;
  Data      : PTreeData;
  Peca      : TdbRow;
  CurrNode  : PVirtualNode;
begin
  Screen.Cursor := crHourGlass;
  stPecas.BeginUpdate;
  try
    ClearPecas;
    if FfkPeca < 1 then Exit;
    with dmFichaTecnica.qrPecasOperacao do
      try
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        ParamByName('fk_operacoes').AsInteger      := FfkOperacao;
        open;
        while not(EOF) do
        begin
          Peca              := TdbRow.CreateFromDs(dmFichaTecnica.qrPecasOperacao, True);
          RowData           := TRowData.Create;
          RowData.Level     := 0;
          RowData.dbRow     := Peca;
          FslPecas.Add(RowData);
          CurrNode          := stPecas.AddChild(nil);
          Data              := stPecas.GetNodeData(CurrNode);
          Data.RowData      := RowData;
          RowData.Node      := CurrNode;
          CurrNode.CheckType:= ctCheckBox;
          if FieldByName('SEQ_MONT').IsNull Then
             stPecas.CheckState[CurrNode] := csUnCheckedNormal
          else
             stPecas.CheckState[CurrNode] := csCheckedNormal;
          Next;
        end;
      finally
        Close;
      end;
  finally
    stPecas.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfmEditOperacao.ClearInsumos;
var
  i      : Integer;
  RowData: TRowData;
begin
  for i := 0 to FslInsumos.Count - 1 do
  begin
    RowData := TRowData(FslInsumos[i]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslInsumos[i] := nil;
    end;
  end;
  FslInsumos.Clear;
  stInsumos.Clear;
end;


procedure TfmEditOperacao.LoadInsumos;
var
  RowData : TRowData;
  Data    : PTreeData;
  Insumo  : TdbRow;
  CurrNode: PVirtualNode;
begin
  Screen.Cursor := crHourGlass;
  stInsumos.BeginUpdate;
  try
    ClearInsumos;
    if FfkPeca < 1 then exit;
    with dmFichaTecnica.qrInsumosOperacao do
      try
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        ParamByName('fk_operacoes').AsInteger      := FfkOperacao;
        open;
        while not(EOF) do
        begin
          Insumo            := TdbRow.CreateFromDs(dmFichaTecnica.qrInsumosOperacao, True);
          RowData           := TRowData.Create;
          RowData.Level     := 0;
          RowData.dbRow     := Insumo;
          FslInsumos.Add(RowData);
          CurrNode          := stInsumos.AddChild(nil);
          Data              := stInsumos.GetNodeData(CurrNode);
          Data.RowData      := RowData;
          RowData.Node      := CurrNode;
          Next;
        end;
      finally
        Close;
      end;
  finally
    stInsumos.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfmEditOperacao.ClearServicos;
var
  i      : Integer;
  RowData: TRowData;
begin
  for i := 0 to FslServicos.Count - 1 do
  begin
    RowData := TRowData(FslServicos[i]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslServicos[i] := nil;
    end;
  end;
  FslServicos.Clear;
  stServicos.Clear;
end;


procedure TfmEditOperacao.LoadServicos;
var
  RowData : TRowData;
  Data    : PTreeData;
  Servico : TdbRow;
  CurrNode: PVirtualNode;
begin
  Screen.Cursor := crHourGlass;
  stServicos.BeginUpdate;
  try
    ClearServicos;
    if FfkPeca < 1 then exit;
    with dmFichaTecnica.qrServicosOperacao do
      try
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        ParamByName('fk_operacoes').AsInteger      := FfkOperacao;
        open;
        while not(EOF) do
        begin
          Servico       := TdbRow.CreateFromDs(dmFichaTecnica.qrServicosOperacao, True);
          RowData       := TRowData.Create;
          RowData.Level := 0;
          RowData.dbRow := Servico;
          FslServicos.Add(RowData);
          CurrNode      := stServicos.AddChild(nil);
          Data          := stServicos.GetNodeData(CurrNode);
          Data.RowData  := RowData;
          RowData.Node  := CurrNode;
          Next;
        end;
      finally
        Close;
      end;
  finally
    stServicos.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfmEditOperacao.ClearTiposAcabamento;
var
  i      : Integer;
  RowData: TRowData;
begin
  for i := 0 to FslTiposAcabamento.Count - 1 do
  begin
    RowData := TRowData(FslTiposAcabamento[i]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslTiposAcabamento[i] := nil;
    end;
  end;
  FslTiposAcabamento.Clear;
  stTiposAcabamento.Clear;
end;


procedure TfmEditOperacao.LoadTiposAcabamento;
var
  RowData       : TRowData;
  Data          : PTreeData;
  TipoAcabamento: TdbRow;
  CurrNode      : PVirtualNode;
begin
  Screen.Cursor := crHourGlass;
  stTiposAcabamento.BeginUpdate;
  try
    ClearTiposAcabamento;
    if FfkPeca<1 Then Exit;
    with dmFichaTecnica.qrAcabamentosOperacao do
      try
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        ParamByName('fk_operacoes').AsInteger      := FfkOperacao;
        open;
        while not(EOF) do
        begin
          TipoAcabamento := TdbRow.CreateFromDs(dmFichaTecnica.qrAcabamentosOperacao, True);
          RowData        := TRowData.Create;
          RowData.Level  := 0;
          RowData.dbRow  := TipoAcabamento;
          FslTiposAcabamento.Add(RowData);
          CurrNode       := stTiposAcabamento.AddChild(nil);
          Data           := stTiposAcabamento.GetNodeData(CurrNode);
          Data.RowData   := RowData;
          RowData.Node   := CurrNode;
          Next;
        end;
      finally
        Close;
      end;
  finally
    stTiposAcabamento.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfmEditOperacao.ClearMaquinas;
var
  i      : Integer;
  RowData: TRowData;
begin
  for I := 0 to FslMaquinas.Count - 1 do
  begin
    RowData := TRowData(FslMaquinas[i]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslMaquinas[i] := nil;
    end;
  end;
  FslMaquinas.Clear;
  stMaquinas.Clear;
end;


procedure TfmEditOperacao.LoadMaquinas;
var
  RowData      : TRowData;
  Data         : PTreeData;
  Ferramenta   : TdbRow;
  MaquinaNode  ,
  CurrNode     : PVirtualNode;
  LastfkMaquina: Integer;
  procedure AddFerramenta(aParentNode: PVirtualNode);
  begin
    Ferramenta    := TdbRow.CreateFromDs(dmFichaTecnica.qrFerramentasOperacao, True);
    LastfkMaquina := Ferramenta['fk_maquinas'].AsInteger;
    RowData       := TRowData.Create;
    RowData.Level := Integer(aParentNode <> nil);
    RowData.dbRow := Ferramenta;
    CurrNode      := stMaquinas.AddChild(aParentNode);
    if RowData.Level=0 Then
       if RowData.dbRow['flag_def'].AsBoolean Then
          CurrNode.CheckState:=csCheckedNormal
       else
          CurrNode.CheckState:=csUnCheckedNormal;
    Data          := stMaquinas.GetNodeData(CurrNode);
    Data.RowData  := RowData;
    RowData.Node  := CurrNode;
    FslMaquinas.Add(RowData);
    if RowData.Level=0 Then MaquinaNode:=CurrNode;
  end;
begin
  LastfkMaquina := 0;
  MaquinaNode   := nil;
  Screen.Cursor := crHourGlass;
  stTiposAcabamento.BeginUpdate;
  try
    ClearMaquinas;
    if FfkPeca<1 Then Exit;
    with dmFichaTecnica.qrFerramentasOperacao do
      try
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        ParamByName('fk_operacoes').AsInteger      := FfkOperacao;
        open;
        while not(EOF) do
        begin
          if FieldByName('fk_maquinas').AsInteger <> LastfkMaquina then
            AddFerramenta(nil);
          if FieldByName('fk_insumos').AsInteger > 0 then
            AddFerramenta(MaquinaNode);
          Next;
        end;
      finally
        Close;
      end;
  finally
    stMaquinas.FullExpand;
    stMaquinas.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfmEditOperacao.FormCreate(Sender: TObject);
begin
  FslPecas                        := TList.Create;
  FslInsumos                      := TList.Create;
  FslServicos                     := TList.Create;
  FslTiposAcabamento              := TList.Create;
  FslMaquinas                     := TList.Create;
  stPecas.NodeDataSize            := SizeOf(TTreeData);
  stPecas.RootNodeCount           := 0;
  stInsumos.NodeDataSize          := SizeOf(TTreeData);
  stInsumos.RootNodeCount         := 0;
  stServicos.NodeDataSize         := SizeOf(TTreeData);
  stServicos.RootNodeCount        := 0;
  stTiposAcabamento.NodeDataSize  := SizeOf(TTreeData);
  stTiposAcabamento.RootNodeCount := 0;
  stMaquinas.NodeDataSize         := SizeOf(TTreeData);
  stMaquinas.RootNodeCount        := 0;
  LoadFasesProducao;
  LoadTiposOperacao;
  LoadTiposDocumento;
end;

procedure TfmEditOperacao.FormDestroy(Sender: TObject);
begin
  ClearPecas;
  FslPecas.Free;
  FslPecas           := nil;
  ClearInsumos;
  FslInsumos.Free;
  FslInsumos         := nil;
  ClearServicos;
  FslServicos.Free;
  FslServicos        := nil;
  ClearTiposAcabamento;
  FslTiposAcabamento.Free;
  FslTiposAcabamento := nil;
  ClearMaquinas;
  FslMaquinas.Free;
  FslMaquinas        := nil;
end;

procedure TfmEditOperacao.LoadFasesProducao;
begin
  cbFaseProducao.Items.Clear;
  with dmFichaTecnica.qrTipoFasesProducao do
    try
      Open;
      while not(EOF) do
      begin
        cbFaseProducao.Items.AddObject(FieldByName('DSC_FASE').AsString,
          TObject(FieldByName('PK_TIPO_FASES_PRODUCAO').AsInteger));
        Next;
      end;
    finally
      Close;
   end;
end;

procedure TfmEditOperacao.LoadTiposDocumento;
begin
  cbTipoDocumento.Items.Clear;
  with dmFichaTecnica.qrTipoDocumentos do
  begin
    try
      Open;
      while not(EOF) do
      begin
        cbTipoDocumento.Items.AddObject(FieldByName('DSC_TDOC').AsString,
          TObject(FieldByName('PK_TIPO_DOCUMENTOS').AsInteger));
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TfmEditOperacao.LoadTiposOperacao;
begin
  cbTipoOperacao.Items.Clear;
  with dmFichaTecnica.qrTipoOperacoes do
  begin
    try
      Open;
      while not(EOF) do
      begin
        cbTipoOperacao.Items.AddObject(FieldByName('DSC_OPE').AsString,
          TObject(FieldByName('PK_TIPO_OPERACOES').AsInteger));
        Next;
      end;
    finally
      Close;
    end;
  end;
end;

procedure TfmEditOperacao.SetUpdateAllowed(const Value: Boolean);
begin
  FUpdateAllowed := Value;
end;

procedure TfmEditOperacao.stPecasEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := ((Node <> nil) and (Column = 1) and (FUpdateAllowed));
end;

procedure TfmEditOperacao.stPecasGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData;
begin
  if Node = nil then exit;
  Data := stPecas.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then exit;
  with Data.RowData do
    case Column of
      0: CellText := dbRow['COD_REF'].AsString + ' - ' + dbRow['DSC_PEC'].AsString;
      1: if dbRow['SEQ_MONT'].AsInteger > 0 then
           CellText := IntToStr(dbRow['SEQ_MONT'].AsInteger)
    else
      CellText:='';
    end;
end;

procedure TfmEditOperacao.stPecasNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PTreeData;
  Seq : Integer;
begin
  if Node = nil then exit;
  Data := stPecas.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
     (Column <> 1)) then
    exit;
  Seq := StrToIntDef(NewText,0);
  if Seq = Data.RowData.dbRow['SEQ_MONT'].AsInteger then exit;
  Data.RowData.dbRow['SEQ_MONT'].AsInteger := Seq;
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmEditOperacao.SetfkOperacao(const Value: Integer);
begin
  FfkOperacao := Value;
end;

procedure TfmEditOperacao.EnableControls;
begin
  //cbFaseProducao.Enabled  :=((FUpdateAllowed)And((FFkFaseProducao<1)Or(FfkOperacao<1)));
  cbTipoDocumento.Enabled:= FUpdateAllowed;
  cbTipoOperacao.Enabled := FUpdateAllowed;
  edSEQ_OPE.Enabled      := FUpdateAllowed;
  edCOD_REF.Enabled      := FUpdateAllowed;
  edCOD_BARRAS.Enabled   := FUpdateAllowed;
  edALT_MAX.Enabled      := FUpdateAllowed;
  edLARG_MAX.Enabled     := FUpdateAllowed;
  edPROF_MAX.Enabled     := FUpdateAllowed;
  edALT_MIN.Enabled      := FUpdateAllowed;
  edLARG_MIN.Enabled     := FUpdateAllowed;
  edPROF_MIN.Enabled     := FUpdateAllowed;
  edTempo_Medio.Enabled  := FUpdateAllowed;
  cmdUpdate.Visible      := FUpdateAllowed;
  cmdNew.Visible         := FUpdateAllowed;
end;

function TfmEditOperacao.CheckPecaOperacao:Boolean;
var
  S : string;
  Ix: Integer;
begin
  Result := False;
  S := '';
  try
    if FfkPeca < 1 then
    begin
      S := 'Erro: A Peça na qual a operação foi realizada não foi informada !';
      exit;
    end;
    if FfkPeca = FLastfkPeca then exit;
    FLastfkPeca := FfkPeca;
    with dmFichaTecnica.qrPeca do
      try
        ParamByName('pk_pecas').AsInteger := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := FfkFichaTecnica;
        Open;
        if EOF Then
        begin
          S := 'Erro: A Peça na qual a operação será realizada(pk_pecas=' +
                 IntToStr(FfkPeca) + ') não foi encontrada !';
          exit;
        end
        else
          laPecaPai.Caption := FieldByName('COD_REF').AsString + ' - ' +
            FieldByName('DSC_PEC').AsString;
      finally
        Close;
      end;
    FfkTipoFasesProducao := 0;
    if ((FfkPeca > 0) and (FfkFaseProducao > 0)) then
      with dmFichaTecnica.qrFaseProducao do
        try
          ParamByName('fk_pecas').AsInteger          :=FfkPeca;
          ParamByName('fk_ficha_tecnica').AsInteger  :=FfkFichaTecnica;
          ParamByName('pk_fases_producao').AsInteger :=FfkFaseProducao;
          Open;
          if not(EOF) then
            FfkTipoFasesProducao := FieldByName('fk_tipo_fases_producao').AsInteger
          else
          begin
            S := 'Erro: Fase de Produção com fk_pecas=' + IntToStr(FfkPeca) +
                   ' e pk_fases_producao=' + IntToStr(FfkFaseProducao) +
                   ' não encontrada !';
            exit;
          end;
        finally
          Close;
        end;
    if FfkTipoFasesProducao > 0 then
      Ix := cbFaseProducao.Items.IndexOfObject(TObject(FfkTipoFasesProducao))
    else
      Ix := -1;
    if Ix > -1 then
      cbFaseProducao.ItemIndex := Ix
    else
    begin
      S := 'Erro: Tipo Fase de Produção com fk_tipo_fases_producao=' +
             IntToStr(FfkTipoFasesProducao) + ' não encontrada !';
      exit;
    end;
    Result := (S = '');
    Caption := 'Operação em ' + laPecaPai.Caption;
  finally
    if S <> '' Then
    begin
      MessageBox(Self.Handle, PChar(S), PChar(Caption), MB_ICONSTOP);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    end;
  end;
end;

procedure TfmEditOperacao.ClearOperacao;
begin
//  laPecaPai.Caption   := '';
  edSEQ_OPE.AsInteger := 0;
  edCOD_REF.Text      := '';
  edCOD_BARRAS.Text   := '';
  edALT_MAX.Value     := 0;
  edLARG_MAX.Value    := 0;
  edPROF_MAX.Value    := 0;
  edALT_MIN.Value     := 0;
  edLARG_MIN.Value    := 0;
  edPROF_MIN.Value    := 0;
  edTEMPO_MEDIO.Value := 0;
  ClearPecas;
  ClearInsumos;
  ClearServicos;
  ClearTiposAcabamento;
  ClearMaquinas;
  EnableControls;
  if not(CheckPecaOperacao) then exit;
  if cmdUpdate.Visible then cmdUpdate.Enabled := False;
end;

procedure TfmEditOperacao.LoadOperacao;
var
  S : string;
  Ix: Integer;
begin
  FInsideMove := True;
  try
    ClearOperacao;
    if ((FfkOperacao < 1) or (FfkFaseProducao < 1)) then
    begin
      LoadPecas;
      exit;
    end;
    S := '';
    try
      with dmFichaTecnica.qrOperacao do
      begin
        try
          ParamByName('fk_pecas').AsInteger          := FfkPeca;
          ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
          ParamByName('pk_operacoes').AsInteger      := FfkOperacao;
          ParamByName('pk_fases_producao').AsInteger := FfkFaseProducao;
          Open;
          if EOF Then
          begin
            S := 'Erro: Operação não encontrada no Banco de Dados';
            exit;
          end;
          Ix := cbFaseProducao.Items.IndexOfObject(
                  TObject(FieldByName('FK_TIPO_FASES_PRODUCAO').AsInteger));
          if Ix < 0 then
          begin
            S := 'Erro: Tipo Fase de Produção com fk_tipo_fases_producao=' +
                   IntToStr(FieldByName('FK_TIPO_FASES_PRODUCAO').AsInteger) +
                   ' não encontrado !';
            exit;
          end;
          cbFaseProducao.ItemIndex := Ix;
          Ix := cbTipoOperacao.Items.IndexOfObject(TObject(
                  FieldByName('FK_TIPO_OPERACOES').AsInteger));
          if Ix < 0 then
          begin
            S := 'Erro: Tipo Operação com pk_tipo_operacoes=' +
                   IntToStr(FieldByName('FK_TIPO_OPERACOES').AsInteger) +
                   ' não encontrado !';
            Exit;
          end;
          cbTipoOperacao.ItemIndex := Ix;
          Ix := cbTipoDocumento.Items.IndexOfObject(TObject(
                  FieldByName('FK_TIPO_DOCUMENTOS').AsInteger));
          if Ix < 0 then
          begin
            S := 'Erro: Tipo Documento com pk_tipo_documentos=' +
                   IntToStr(FieldByName('FK_TIPO_DOCUMENTOS').AsInteger) +
                   ' não encontrado !';
            Exit;
          end;
          cbTipoDocumento.ItemIndex := Ix;
          edSEQ_OPE.AsInteger      := FieldByName('SEQ_OPE').AsInteger;
          edCOD_REF.Text           := FieldByName('COD_REF').AsString;
          edCOD_BARRAS.Text        := FieldByName('COD_BARRAS').AsString;
          edALT_MAX.Value          := FieldByName('ALT_MAX').AsFloat;
          edLARG_MAX.Value         := FieldByName('LARG_MAX').AsFloat;
          edPROF_MAX.Value         := FieldByName('PROF_MAX').AsFloat;
          edALT_MIN.Value          := FieldByName('ALT_MIN').AsFloat;
          edLARG_MIN.Value         := FieldByName('LARG_MIN').AsFloat;
          edPROF_MIN.Value         := FieldByName('PROF_MIN').AsFloat;
          edTEMPO_MEDIO.Value      := FieldByName('TEMPO_MEDIO').AsFloat;
        finally
          Close;
        end; // try
      end; // with
      LoadPecas;
      LoadInsumos;
      LoadServicos;
      LoadTiposAcabamento;
      LoadMaquinas;
    finally
      if S <> '' then
      begin
        MessageBox(Self.Handle, PChar(S), PChar(Caption), MB_ICONSTOP);
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      end;
    end; // try
  finally
    FInsideMove := False;
  end;
end;

procedure TfmEditOperacao.SavePecas(afkOperacao, afkFasesProducao, afkTipoFasesProducao: Integer);
var
  aNode: PVirtualNode;
  Data : PTreeData;
begin
  if stPecas.RootNodeCount < 1 then exit;
  aNode := stPecas.GetFirst;
  while aNode <> nil do
  begin
    Data := stPecas.GetNodeData(aNode);
    if ((Data <> nil) and (Data.RowData <> nil) and
       (Data.RowData.dbRow <> nil)) then
      if aNode.CheckState = csCheckedNormal then
        with dmFichaTecnica.qrInsertComponenteOperacao do
          try
            ParamByName('fk_pecas').AsInteger                   := FfkPeca;
            ParamByName('fk_ficha_tecnica').AsInteger           := FfkFichaTecnica;
            ParamByName('fk_pecas_montagem').AsInteger          := Data.RowData.dbRow['fk_pecas_montagem'].AsInteger;
            ParamByName('fk_ficha_tecnica_montagem').AsInteger  := Data.RowData.dbRow['fk_ficha_tecnica_montagem'].AsInteger;
            ParamByName('fk_operacoes').AsInteger               := afkOperacao;
            // JOP 20.08.04 ParamByName('fk_tipo_fases_producao').AsInteger     := afkTipoFasesProducao;
            ParamByName('fk_fases_producao').AsInteger          := afkFasesProducao;
            ParamByName('seq_mont').AsInteger                   := Data.RowData.dbRow['seq_mont'].AsInteger;
            ExecSql;
          finally
            Close;
          end;
    aNode:=stPecas.GetNext(aNode);
  end;
end;

procedure TfmEditOperacao.SaveDetalhes(st:TCSDVirtualStringTree;afkOperacao, afkFasesProducao, afkTipoFasesProducao:Integer);
var
  aNode: PVirtualNode;
  Data : PTreeData;
begin
  if ((st = nil) or (st.RootNodeCount < 1)) then exit;
  aNode := st.GetFirst;
  while aNode <> nil do
  begin
    Data := st.GetNodeData(aNode);
    if ((Data <> nil) and (Data.RowData <> nil) and
       (Data.RowData.dbRow <> nil)) then
    begin
      with dmFichaTecnica.qrInsertOperacoesDetalhes do
        try
          ParamByName('fk_pecas').AsInteger                 := FfkPeca;
          ParamByName('fk_ficha_tecnica').AsInteger         := FfkFichaTecnica;
          ParamByName('fk_operacoes').AsInteger             := afkOperacao;
          ParamByName('fk_fases_producao').AsInteger        := afkFasesProducao;
          // JOP 20.08.04 ParamByName('fk_tipo_fases_producao').AsInteger   := afkTipoFasesProducao;
          ParamByName('fk_tipo_detalhe').AsInteger          := Data.RowData.dbRow['fk_tipo_detalhe'].AsInteger;
          ParamByName('flag_tdet').AsInteger                := Data.RowData.dbRow['flag_tdet'].AsInteger;
          ParamByName('qtd_det').AsFloat                    := Data.RowData.dbRow['qtd_det'].AsFloat;
          ParamByName('perc_perda').AsFloat                 := Data.RowData.dbRow['perc_perda'].AsFloat;
          ExecSql;
        finally
          Close;
        end;
      Data.RowData.dbRow['fk_pecas'].AsInteger              := FfkPeca;
      Data.RowData.dbRow['fk_ficha_tecnica'].AsInteger      := FfkFichaTecnica;
      Data.RowData.dbRow['fk_operacoes'].AsInteger          := afkOperacao;
      Data.RowData.dbRow['fk_fases_producao'].AsInteger     := afkFasesProducao;
      // JOP 20.08.04 Data.RowData.dbRow['fk_tipo_fases_producao'].AsInteger:= afkTipoFasesProducao;
    end;
    aNode:=st.GetNext(aNode);
  end;
end;

function TfmEditOperacao.OperacaoSaved:Boolean;
var
  afkOperacao: Integer;
  IsInclusao : Boolean;
  aQuery     : TIBQuery;
begin
  Result := False;
  aFKOperacao := 0;
  if cbFaseProducao.ItemIndex < 0 then
  begin
    if cbFaseProducao.CanFocus then cbFaseProducao.SetFocus;
    MessageBox(Self.Handle, 'A Fase de Produção deve ser selecionada !',
      PChar(Caption), MB_ICONSTOP);
    exit;
  end;
  if cbTipoOperacao.ItemIndex < 0 then
  begin
    if cbTipoOperacao.CanFocus then cbTipoOperacao.SetFocus;
    MessageBox(Self.Handle, 'O Tipo de Operação deve ser selecionado !',
      PChar(Caption), MB_ICONSTOP);
    exit;
  end;
  if cbTipoDocumento.ItemIndex < 0 then
  begin
    if cbTipoDocumento.CanFocus then cbTipoDocumento.SetFocus;
    MessageBox(Self.Handle, 'O Tipo de Documento deve ser selecionado !',
      PChar(Caption), MB_ICONSTOP);
    exit;
  end;
  IsInclusao := (FfkOperacao < 1);
  if dmFichaTecnica.tr.InTransaction then
    dmFichaTecnica.tr.Commit;
  try
    dmFichaTecnica.tr.StartTransaction;
    if IsInclusao then
      aQuery := dmFichaTecnica.qrInsertOperacao
    else
      aQuery := dmFichaTecnica.qrUpdateOperacao;
    with aQuery do
    begin
      try
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        if not (IsInclusao) then
           ParamByName('pk_operacoes').AsInteger   := FfkOperacao
        else ; // JOP 20.08.04 ParamByName('fk_tipo_fases_producao').AsInteger := FfkTipoFasesProducao;
        ParamByName('fk_tipo_operacoes').AsInteger := LongInt(cbTipoOperacao.Items.Objects[cbTipoOperacao.ItemIndex]);
        ParamByName('fk_tipo_documentos').AsInteger:= LongInt(cbTipoDocumento.Items.Objects[cbTipoDocumento.ItemIndex]);
        ParamByName('seq_ope').AsInteger           := edSEQ_OPE.AsInteger;
        ParamByName('COD_REF').AsString            := edCOD_REF.Text;
        ParamByName('COD_BARRAS').AsString         := edCOD_BARRAS.Text;
        ParamByName('ALT_MAX').AsFloat             := edALT_MAX.Value;
        ParamByName('LARG_MAX').AsFloat            := edLARG_MAX.Value;
        ParamByName('PROF_MAX').AsFloat            := edPROF_MAX.Value;
        ParamByName('ALT_MIN').AsFloat             := edALT_MIN.Value;
        ParamByName('LARG_MIN').AsFloat            := edLARG_MIN.Value;
        ParamByName('PROF_MIN').AsFloat            := edPROF_MIN.Value;
        ParamByName('TEMPO_MEDIO').AsFloat         := edTEMPO_MEDIO.Value;
        ExecSql;
      finally
        Close;
      end;
    end;
    if IsInclusao then
    with dmFichaTecnica.qrMaxOperacao do
      try
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        Open;
        if Not(EOF) Then afkOperacao               := FieldByName('fkOperacao').AsInteger;
      finally
        Close;
      end
    else
      afkOperacao := FfkOperacao;
    with dmFichaTecnica.qrDeleteComponentesOperacao do
      try
        ParamByName('fk_operacoes').AsInteger      := afkOperacao;
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteOperacoesDetalhes do
      try
        ParamByName('fk_operacoes').AsInteger      := afkOperacao;
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteFerramentasOperacao do
      try
        ParamByName('fk_operacoes').AsInteger      := afkOperacao;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteMaquinasOperacao do
      try
        ParamByName('fk_operacoes').AsInteger      := afkOperacao;
        ParamByName('fk_pecas').AsInteger          := FfkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger  := FfkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := FfkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    SavePecas(afkOperacao, FfkFaseProducao, FfkTipoFasesProducao);
    SaveDetalhes(stInsumos, afkOperacao, FfkFaseProducao,FfkTipoFasesProducao);
    SaveDetalhes(stServicos, afkOperacao, FfkFaseProducao,FfkTipoFasesProducao);
    SaveDetalhes(stTiposAcabamento, afkOperacao, FfkFaseProducao,FfkTipoFasesProducao);
    SaveMaquinas(afkOperacao, FfkFaseProducao, FfkTipoFasesProducao);
    dmFichaTecnica.tr.Commit;
  except on Exception do
    begin
      dmFichaTecnica.tr.Rollback;
      raise;
    end;
  end;
  FfkOperacao     :=afkOperacao;
  if IsInclusao Then
  begin
    MessageBox(Self.Handle, 'Operação Incluída com sucesso !', PChar(Caption),
      MB_ICONINFORMATION);
    if Assigned(FOnInsertOperacao) then
      FOnInsertOperacao(Self, FfkPeca, FfkFichaTecnica, FfkFaseProducao, FfkOperacao);
  end
  else
  begin
    MessageBox(Self.Handle, 'Operação Atualizada com sucesso !', PChar(Caption),
      MB_ICONINFORMATION);
    if Assigned(FOnUpdateOperacao) Then
      FOnUpdateOperacao(Self, FfkPeca, FfkFichaTecnica, FfkFaseProducao, FfkOperacao);
  end;
  FOperacaoUpdated    := True;
  FLastfkOperacao     := afkOperacao;
  FLastfkFaseProducao := FfkFaseProducao;
  EnableControls;
  cmdUpdate.Enabled   := False;
  Result              := True;
end;

procedure TfmEditOperacao.cmdUpdateClick(Sender: TObject);
begin
  if OperacaoSaved then ;
end;

procedure TfmEditOperacao.cmdNewClick(Sender: TObject);
begin
  pgDetalhes.ActivePage := tbPecas;
  FfkOperacao           := 0;
  LoadOperacao;
end;

procedure TfmEditOperacao.SetfkPeca(const Value: Integer);
begin
  FfkPeca := Value;
end;

procedure TfmEditOperacao.FormShow(Sender: TObject);
begin
  pgDetalhes.ActivePage   := tbPecas;
  LoadOperacao;
end;

procedure TfmEditOperacao.SetfkFaseProducao(const Value: Integer);
begin
  FfkFaseProducao := Value;
end;

procedure TfmEditOperacao.stInsumosGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData;
begin
  if Node = nil then exit;
  Data := stInsumos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  with Data.RowData do
    case Column of
      0: CellText := dbRow['DSC_INS'].AsString;
      1:if dbRow['QTD_DET'].AsFloat > 0 then
          CellText := FormatFloat('0.0000', dbRow['QTD_DET'].AsFloat)
        else
          CellText := '';
      2:if dbRow['PERC_PERDA'].AsFloat > 0 then
          CellText := FormatFloat('0.00', dbRow['PERC_PERDA'].AsFloat)
        else
          CellText := '';
    end;
end;

procedure TfmEditOperacao.stInsumosNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PTreeData;
     V: Double;
begin
  if Node = nil then exit;
  Data := stInsumos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
     (Column < 1) Or (Column >2)) then
    exit;
  V:=StrToFloatDef(NewText,0);
  case Column of
       1:if V=Data.RowData.dbRow['QTD_DET'].AsFloat Then Exit
         else Data.RowData.dbRow['QTD_DET'].AsFloat    := V;
       2:begin
           if V<0 Then V:=0
           else
              if V>99.99 Then V:=99.99;
           if V=Data.RowData.dbRow['PERC_PERDA'].AsFloat Then Exit
           else Data.RowData.dbRow['PERC_PERDA'].AsFloat := V;
         end;
  end;
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.stServicosGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData;
begin
  if Node = nil then exit;
  Data := stServicos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  with Data.RowData do
    case Column of
      0: CellText := dbRow['DSC_SRV'].AsString;
      1: if dbRow['QTD_DET'].AsFloat > 0 then
           CellText := FormatFloat('0.0000',dbRow['QTD_DET'].AsFloat)
         else
           CellText:='';
    end;
end;

procedure TfmEditOperacao.stServicosNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PTreeData;
     V: Double;
begin
  if Node = nil then exit;
  Data := stServicos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
     (Column <> 1)) then
    exit;
  V:=StrToFloatDef(NewText,0);
  if V=Data.RowData.dbRow['QTD_DET'].AsFloat Then Exit;
  Data.RowData.dbRow['QTD_DET'].AsFloat    := V;
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.stTiposAcabamentoGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: WideString);
var
  Data: PTreeData;
begin
  if Node = nil then exit;
  Data := stTiposAcabamento.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then exit;
  with Data.RowData do
    case Column of
      0: CellText := dbRow['DSC_ACABM'].AsString;
      1: if dbRow['QTD_DET'].AsFloat > 0 then
           CellText := FormatFloat('0.0000', dbRow['QTD_DET'].AsFloat)
         else
           CellText := '';
      2:if dbRow['PERC_PERDA'].AsFloat > 0 then
          CellText := FormatFloat('0.00', dbRow['PERC_PERDA'].AsFloat)
        else
          CellText := '';
    end;
end;

procedure TfmEditOperacao.stTiposAcabamentoNewText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  NewText: WideString);
var
  Data: PTreeData;
     V: Double;
begin
  if Node = nil then exit;
  Data := stTiposAcabamento.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
     (Column < 1) Or (Column > 2)) then
    exit;
  V:=StrToFloatDef(NewText,0);
  case Column of
       1:if V=Data.RowData.dbRow['QTD_DET'].AsFloat Then Exit
         else Data.RowData.dbRow['QTD_DET'].AsFloat    := V;
       2:begin
           if V<0 Then V:=0
           else
              if V>99.99 Then V:=99.99;
           if V=Data.RowData.dbRow['PERC_PERDA'].AsFloat Then Exit
           else Data.RowData.dbRow['PERC_PERDA'].AsFloat := V;
         end;
  end;
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.popServicosPopup(Sender: TObject);
begin
  cmNewServico.Visible    := FUpdateAllowed;
  cmDeleteServico.Visible := ((FUpdateAllowed) and (stServicos.FocusedNode <> nil));
end;

procedure TfmEditOperacao.cmDeleteServicoClick(Sender: TObject);
var
  aNode: PVirtualNode;
  Data : PTreeData;
  Ix   : Integer;
begin
  aNode := stServicos.FocusedNode;
  if ((aNode = nil) or (not(FUpdateAllowed))) then exit;
  Data  := stServicos.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  Ix    := FslServicos.IndexOf(Data.RowData);
  if Ix < 0 then exit;
  FslServicos.Delete(Ix);
  Data.RowData.Free;
  Data.RowData := nil;
  stServicos.DeleteNode(aNode);
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.cmNewServicoClick(Sender: TObject);
var
  fkTipoServico,
  I             : Integer;
  sl            : TList;
  Data          : PTreeData;
  RowData       : TRowData;
  DscTipoServico: string;
  Quantidade    : Double;
begin
  if not (FUpdateAllowed) then exit;
  sl := TList.Create;
  try
    for I := 0 to FslServicos.Count - 1 do
    begin
      RowData:=TRowData(FslServicos[I]);
      if ((RowData <> nil) and (RowData.dbRow <> nil)) then
        sl.Add(TObject(RowData.dbRow['fk_tipo_detalhe'].AsInteger));
    end;
    with TfmNovoServicoOperacao.Create(Self) do
      try
        if slServicosInd <> nil then slServicosInd.Assign(sl);
        if ShowModal <> mrOk then exit;
        fkTipoServico  := SelectedfkServicosInd;
        DscTipoServico := SelectedDescServicosInd;
        Quantidade     := Qtde;
      finally
        Release;
      end;
  finally
    sl.Free;
  end;
  RowData                                    := TRowData.Create;
  RowData.Level                              := 0;
  RowData.dbRow                              := TdbRow.CreateFromDs(dmFichaTecnica.qrServicosOperacao, False);
  RowData.dbRow['fk_tipo_detalhe'].AsInteger := fkTipoServico;
  RowData.dbRow['DSC_SRV'].AsString          := DscTipoServico;
  RowData.dbRow['flag_tdet'].AsInteger       := 1;
  RowData.dbRow['qtd_det'].AsFloat           := Quantidade;
  FslServicos.Add(RowData);
  RowData.Node                               := stServicos.AddChild(nil);
  Data                                       := stServicos.GetNodeData(RowData.Node);
  Data.RowData                               := RowData;
  stServicos.FocusedNode                     := RowData.Node;
  stServicos.Selected[RowData.Node]          := True;
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.popTiposAcabamentosPopup(Sender: TObject);
begin
  cmNewTipoAcabamento.Visible    := FUpdateAllowed;
  cmDeleteTipoAcabamento.Visible := ((FUpdateAllowed) and
                                    (stTiposAcabamento.FocusedNode <> nil));
end;

procedure TfmEditOperacao.cmNewTipoAcabamentoClick(Sender: TObject);
var
  fkTipoAcabamento,
  I                 : Integer;
  sl                : TList;
  Data              : PTreeData;
  RowData           : TRowData;
  DscTipoAcabamento : string;
  PercentualPerda,
  Quantidade        : Double;
begin
  if not (FUpdateAllowed) then Exit;
  sl := TList.Create;
  try
    for I := 0 to FslTiposAcabamento.Count - 1 do
    begin
      RowData := TRowData(FslTiposAcabamento[I]);
      if ((RowData <> nil) and (RowData.dbRow <> nil)) then
        sl.Add(TObject(RowData.dbRow['fk_tipo_detalhe'].AsInteger));
    end;
    with TfmNovoAcabamentoOperacao.Create(Self) do
    try
      if slTiposDeAcabamento <> nil then slTiposDeAcabamento.Assign(sl);
      if ShowModal <> mrOk then exit;
      fkTipoAcabamento  := SelectedfkTipoAcabamento;
      DscTipoAcabamento := SelectedDescTipoAcabamento;
      Quantidade        := Qtde;
      PercentualPerda   := PercPerda;
    finally
      Release;
    end;
  finally
    sl.Free;
  end;
  RowData                                    := TRowData.Create;
  RowData.Level                              := 0;
  RowData.dbRow                              := TdbRow.CreateFromDs(dmFichaTecnica.qrAcabamentosOperacao, False);
  RowData.dbRow['fk_tipo_detalhe'].AsInteger := fkTipoAcabamento;
  RowData.dbRow['DSC_ACABM'].AsString        := DscTipoAcabamento;
  RowData.dbRow['flag_tdet'].AsInteger       := 2;
  RowData.dbRow['qtd_det'].AsFloat           := Quantidade;
  RowData.dbRow['perc_perda'].AsFloat        := PercentualPerda;
  FslTiposAcabamento.Add(RowData);
  RowData.Node                               := stTiposAcabamento.AddChild(nil);
  Data                                       := stTiposAcabamento.GetNodeData(RowData.Node);
  Data.RowData                               := RowData;
  stTiposAcabamento.FocusedNode              := RowData.Node;
  stTiposAcabamento.Selected[RowData.Node]   := True;
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.cmDeleteTipoAcabamentoClick(Sender: TObject);
var
  aNode: PVirtualNode;
  Data : PTreeData;
  Ix   : Integer;
begin
  aNode := stTiposAcabamento.FocusedNode;
  if ((aNode = nil) or (not (FUpdateAllowed))) then exit;
  Data  :=stTiposAcabamento.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then exit;
  Ix    := FslTiposAcabamento.IndexOf(Data.RowData);
  if Ix < 0 then exit;
  FslTiposAcabamento.Delete(Ix);
  Data.RowData.Free;
  Data.RowData := nil;
  stTiposAcabamento.DeleteNode(aNode);
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.stPecasChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
begin
  Allowed := ((FUpdateAllowed) or (FInsideMove));
end;

procedure TfmEditOperacao.popInsumosPopup(Sender: TObject);
begin
  cmNewInsumo.Visible    := FUpdateAllowed;
  cmDeleteInsumo.Visible := ((FUpdateAllowed) and (stInsumos.FocusedNode <> nil));
end;

procedure TfmEditOperacao.cmNewInsumoClick(Sender: TObject);
var
  fkInsumo,
  I          : Integer;
  sl         : TList;
  Data       : PTreeData;
  RowData    : TRowData;
  DscInsumo  : string;
  PercentualPerda,
  Quantidade : Double;
begin
  if not (FUpdateAllowed) then exit;
  sl := TList.Create;
  try
    for I := 0 to FslInsumos.Count - 1 do
    begin
      RowData := TRowData(FslInsumos[I]);
      if ((RowData <> nil) and (RowData.dbRow <> nil)) then
        sl.Add(TObject(RowData.dbRow['fk_tipo_detalhe'].AsInteger));
    end;
    with TfmNovoInsumoOperacao.Create(Self) do
      try
        if slInsumosOperacao <> nil  then slInsumosOperacao.Assign(sl);
        if ShowModal         <> mrOk then exit;
        fkInsumo        := SelectedfkInsumo;
        DscInsumo       := SelectedDescInsumo;
        Quantidade      := Qtde;
        PercentualPerda := PercPerda;
      finally
        Release;
      end;
  finally
    sl.Free;
  end;
  RowData                                    := TRowData.Create;
  RowData.Level                              := 0;
  RowData.dbRow                              := TdbRow.CreateFromDs(dmFichaTecnica.qrInsumosOperacao, False);
  RowData.dbRow['fk_tipo_detalhe'].AsInteger := fkInsumo;
  RowData.dbRow['DSC_INS'].AsString          := DscInsumo;
  RowData.dbRow['flag_tdet'].AsInteger       := 0;
  RowData.dbRow['qtd_det'].AsFloat           := Quantidade;
  RowData.dbRow['perc_perda'].AsFloat        := PercentualPerda;
  FslInsumos.Add(RowData);
  RowData.Node                               := stInsumos.AddChild(Nil);
  Data                                       := stInsumos.GetNodeData(RowData.Node);
  Data.RowData                               := RowData;
  stInsumos.FocusedNode                      := RowData.Node;
  stInsumos.Selected[RowData.Node]           := True;
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.cmDeleteInsumoClick(Sender: TObject);
var
  aNode: PVirtualNode;
  Data : PTreeData;
  Ix   : Integer;
begin
  aNode := stInsumos.FocusedNode;
  if ((aNode = nil) or (not(FUpdateAllowed))) then exit;
  Data  := stInsumos.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then exit;
  Ix    := FslInsumos.IndexOf(Data.RowData);
  if Ix < 0 then exit;
  FslInsumos.Delete(Ix);
  Data.RowData.Free;
  Data.RowData := nil;
  stInsumos.DeleteNode(aNode);
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.popMaquinasPopup(Sender: TObject);
var
  CurrNode: PVirtualNode;
begin
  CurrNode                 := stMaquinas.FocusedNode;
  cmPropriedades.Visible   := ((CurrNode <> nil) and (stMaquinas.GetNodeLevel(CurrNode) = 0));
  cmNovaFerramenta.Visible := (CurrNode <> nil);
  cmDelete.Visible         := (CurrNode <> nil);
end;

procedure TfmEditOperacao.HandleInsertMaquina(Sender: TObject; afkMaquina: Integer;
  aDescMaquina: string; aTmpStp: Double; aTmpOper: Double; aIsDefault: Boolean);
var
  aNode  : PVirtualNode;
  Data   : PTreeData;
  RowData: TRowData;
begin
  if ((Sender = nil) or (afkMaquina < 1)) then exit;
  RowData                                := TRowData.Create;
  RowData.Level                          := 0;
  RowData.dbRow                          := TdbRow.CreateFromDs(dmFichaTecnica.qrFerramentasOperacao, False);
  RowData.dbRow['fk_maquinas'].AsInteger := afkMaquina;
  RowData.dbRow['dsc_maq'].AsString      := aDescMaquina;
  RowData.dbRow['tmp_stp'].AsFloat       := aTmpStp;
  RowData.dbRow['tmp_oper'].AsFloat      := aTmpOper;
  RowData.dbRow['flag_def'].AsBoolean    := aIsDefault;
  aNode                                  := stMaquinas.AddChild(nil);
  if RowData.dbRow['flag_def'].AsBoolean Then
     aNode.CheckState:=csCheckedNormal
  else
     aNode.CheckState:=csUnCheckedNormal;
  Data                                   := stMaquinas.GetNodeData(aNode);
  Data.RowData                           := RowData;
  RowData.Node                           := aNode;
  FslMaquinas.Add(RowData);
  stMaquinas.FocusedNode                 := aNode;
  stMaquinas.Selected[aNode]             := True;
  if ((Sender Is TfmEditMaquinaOperacao)And(TfmEditMaquinaOperacao(Sender).slMaquinasOperacao<>Nil)) Then
     TfmEditMaquinaOperacao(Sender).slMaquinasOperacao.Add(RowData);
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.HandleUpdateMaquina(Sender: TObject; afkMaquina: Integer;
  aDescMaquina: string; aTmpStp: Double; aTmpOper: Double; aIsDefault: Boolean);
var
  Data: PTreeData;
  Ix  : Integer;
begin
  if ((Sender = nil) or (afkMaquina < 1) or (FCurrentMaquinaNode = nil)) then exit;
  Data := stMaquinas.GetNodeData(FCurrentMaquinaNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then exit;
  Ix   := FslMaquinas.IndexOf(Data.RowData);
  if Ix < 0 then exit;
  Data.RowData.dbRow['dsc_maq'].AsString   := aDescMaquina;
  Data.RowData.dbRow['tmp_stp'].AsFloat    := aTmpStp;
  Data.RowData.dbRow['tmp_oper'].AsFloat   := aTmpOper;
  Data.RowData.dbRow['flag_def'].AsBoolean := aIsDefault;
  stMaquinas.InvalidateNode(FCurrentMaquinaNode);
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.EditMaquina(aNode:PVirtualNode);
var
  sl                : TList;
  Data              : PTreeData;
  afkMaquina        : Integer;
  aTmpStp   ,
  aTmpOper          : Double;
  aIsDefault        : Boolean;
begin
  if aNode = nil then
  begin
    afkMaquina := 0;
    aTmpStp    := 0;
    aTmpOper   := 0;
    aIsDefault := False;
  end
  else
  begin
    Data := stMaquinas.GetNodeData(aNode);
    if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
       (Data.RowData.Level <> 0)) then exit;
    afkMaquina := Data.RowData.dbRow['fk_maquinas'].AsInteger;
    aTmpStp    := Data.RowData.dbRow['tmp_stp'].AsFloat;
    aTmpOper   := Data.RowData.dbRow['tmp_oper'].AsFloat;
    aIsDefault := (Data.RowData.dbRow['FLAG_DEF'].AsInteger <> 0);
  end;
  FCurrentMaquinaNode := aNode;
  sl := TList.Create;
  try
    aNode := stMaquinas.GetFirst;
    while aNode <> nil do
    begin
      Data := stMaquinas.GetNodeData(aNode);
      if ((Data <> nil) and (Data.RowData <> nil) and
         (Data.RowData.dbRow <> nil)) then
         //sl.Add(TObject(Data.RowData.dbRow['fk_maquinas'].AsInteger));
         sl.Add(Data.RowData);
      aNode := stMaquinas.GetNextSibling(aNode);
    end;
    with TfmEditMaquinaOperacao.Create(Self) do
      try
        if slMaquinasOperacao <> nil then slMaquinasOperacao.Assign(sl);
        fkMaquina       := afkMaquina;
        TmpStp          := aTmpStp;
        TmpOper         := aTmpOper;
        IsDefault       := aIsDefault;
        OnInsertMaquina := HandleInsertMaquina;
        OnUpdateMaquina := HandleUpdateMaquina;
        ShowModal;
      finally
        Release;
      end;
  finally
    FCurrentMaquinaNode := nil;
    sl.Free;
  end;
end;

procedure TfmEditOperacao.cmNovaMaquinaClick(Sender: TObject);
begin
  EditMaquina(nil);
end;

procedure TfmEditOperacao.cmPropriedadesClick(Sender: TObject);
begin
  EditMaquina(stMaquinas.FocusedNode);
end;

procedure TfmEditOperacao.DeleteMaquina(aNode:PVirtualNode);
var
  Data          : PTreeData;
  FerramentaNode: PVirtualNode;
  CurrLevel     : Integer;
  procedure DeleteNodeData(NodeToDelete: PVirtualNode);
  var
    Ix: Integer;
  begin
    if NodeToDelete = nil then exit;
    Data := stMaquinas.GetNodeData(NodeToDelete);
    if ((Data <> nil) and (Data.RowData <> nil)) then
    begin
      Ix := FslMaquinas.IndexOf(Data.RowData);
      if Ix > -1 then
      begin
        FslMaquinas.Delete(Ix);
        Data.RowData.Free;
        Data.RowData := nil;
      end;
    end;
  end;
begin
  if aNode = nil then exit;
  CurrLevel := stMaquinas.GetNodeLevel(aNode);
  Data      := stMaquinas.GetNodeData(aNode);
  if ((CurrLevel <> 0) or (Data = nil) or (Data.RowData = nil) or
     (Data.RowData.dbRow = nil)) then
    exit;
  FerramentaNode := stMaquinas.GetFirstChild(aNode);
  while ((FerramentaNode <> nil) and
        (stMaquinas.GetNodeLevel(FerramentaNode) > Cardinal(CurrLevel))) do
  begin
    DeleteNodeData(FerramentaNode);
    FerramentaNode := stMaquinas.GetNext(FerramentaNode);
  end;
  FerramentaNode := stMaquinas.GetPrevious(aNode);
  DeleteNodeData(aNode);
  stMaquinas.DeleteNode(aNode);
  if FerramentaNode <> nil then
  begin
    stMaquinas.FocusedNode              := FerramentaNode;
    stMaquinas.Selected[FerramentaNode] := True;
  end;
end;

procedure TfmEditOperacao.DeleteFerramenta(aNode:PVirtualNode);
var
  Data    : PTreeData;
  Ix      : Integer;
  prevNode: PVirtualNode;
begin
  if ((aNode = nil) or (stMaquinas.GetNodeLevel(aNode) <> 1)) then exit;
  Data := stMaquinas.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then exit;
  Ix := FslMaquinas.IndexOf(Data.RowData);
  if Ix < 0 then exit;
  PrevNode := stMaquinas.GetPrevious(aNode);
  FslMaquinas.Delete(Ix);
  Data.RowData.Free;
  Data.RowData := nil;
  stMaquinas.DeleteNode(aNode);
  if prevNode <> nil then
  begin
    stMaquinas.FocusedNode        := prevNode;
    stMaquinas.Selected[prevNode] := True;
  end;
end;

procedure TfmEditOperacao.cmDeleteClick(Sender: TObject);
var
  aNode    : PVirtualNode;
  CurrLevel: Integer;
begin
  aNode := stMaquinas.FocusedNode;
  if aNode = nil then exit;
  CurrLevel := stMaquinas.GetNodeLevel(aNode);
  case CurrLevel of
    0: DeleteMaquina(aNode);
    1: DeleteFerramenta(aNode);
  else
    exit;
  end;
end;

procedure TfmEditOperacao.EditFerramenta(FerramentaNode:PVirtualNode);
var
  aNode        : PVirtualNode;
  Data         : PTreeData;
  afkFerramenta: Integer;
  sl           : TList;
begin
  aNode := FerramentaNode;
  if aNode = nil then
    aNode := stMaquinas.FocusedNode;
  while ((aNode <> nil) and (stMaquinas.GetNodeLevel(aNode) <> 0)) do
    aNode:=aNode.Parent;
  if aNode = nil then exit;
  FCurrentMaquinaNode := aNode;
  sl := TList.Create;
  try
    aNode := stMaquinas.GetFirstChild(FCurrentMaquinaNode);
    while aNode<>Nil do
    begin
      Data := stMaquinas.GetNodeData(aNode);
      if ((Data <> nil) and (Data.RowData <> nil) and (Data.RowData.dbRow <> nil)) then
        sl.Add(TObject(Data.RowData.dbRow['fk_insumos'].AsInteger));
      aNode := stMaquinas.GetNextSibling(aNode);
    end;
    if FerramentaNode = nil then
      afkFerramenta := 0
    else
    begin
      Data := stMaquinas.GetNodeData(FerramentaNode);
      if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
         (Data.RowData.Level <> 1)) then
        exit;
      afkFerramenta := Data.RowData.dbRow['fk_ferramentas'].AsInteger;
    end;
    with TfmEditFerramentaOperacao.Create(Self) do
      try
        fkFerramenta       := afkFerramenta;
        OnInsertFerramenta := HandleInsertFerramenta;
        OnUpdateFerramenta := HandleUpdateFerramenta;
        if slFerramentasDaMaquina <> nil then slFerramentasDaMaquina.Assign(sl);
        ShowModal;
      finally
        Release;
        FCurrentMaquinaNode := nil;
      end;
  finally
    sl.Free;
  end;
end;

procedure TfmEditOperacao.cmNovaFerramentaClick(Sender: TObject);
begin
  EditFerramenta(nil);
end;

procedure TfmEditOperacao.HandleInsertFerramenta(Sender: TObject;
  afkFerramenta: Integer; aDescFerramenta: string);
var
  aNode  : PVirtualNode;
  Data   : PTreeData;
  RowData: TRowData;
begin
  if ((Sender = nil) or (afkFerramenta < 1) or (FCurrentMaquinaNode = nil)) then exit;
  RowData                               := TRowData.Create;
  RowData.Level                         := 1;
  RowData.dbRow                         := TdbRow.CreateFromDs(dmFichaTecnica.qrFerramentasOperacao, False);
  RowData.dbRow['fk_insumos'].AsInteger := afkFerramenta;
  RowData.dbRow['dsc_ins'].AsString     := aDescFerramenta;
  aNode                                 := stMaquinas.AddChild(FCurrentMaquinaNode);
  Data                                  := stMaquinas.GetNodeData(aNode);
  Data.RowData                          := RowData;
  RowData.Node                          := aNode;
  FslMaquinas.Add(RowData);
  stMaquinas.FocusedNode                := aNode;
  stMaquinas.Selected[aNode]            := True;
  if ((Sender Is TfmEditFerramentaOperacao)And(TfmEditFerramentaOperacao(Sender).slFerramentasDaMaquina<>Nil)) Then
     TfmEditFerramentaOperacao(Sender).slFerramentasDaMaquina.Add(TObject(RowData.dbRow['fk_insumos'].AsInteger));
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.HandleUpdateFerramenta(Sender: TObject;
  afkFerramenta: Integer; aDescFerramenta: String);
var
  Data: PTreeData;
  Ix  : Integer;
begin
  if ((Sender = nil) or (afkFerramenta < 1) or (FCurrentFerramentaNode = nil)) then exit;
  Data := stMaquinas.GetNodeData(FCurrentFerramentaNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then exit;
  Ix   := FslMaquinas.IndexOf(Data.RowData);
  if Ix < 0 then exit;
  Data.RowData.dbRow['dsc_ins'].AsString := aDescFerramenta;
  stMaquinas.InvalidateNode(FCurrentFerramentaNode);
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.SaveMaquinas(afkOperacao,
  afkFasesProducao, afkTipoFasesProducao: Integer);
var
  MaquinaNode   ,
  FerramentaNode: PVirtualNode;
  DataMaquina   ,
  DataFerramenta: PTreeData;
begin
  MaquinaNode := stMaquinas.GetFirst;
  while MaquinaNode <> nil do
  begin
    DataMaquina := stMaquinas.GetNodeData(MaquinaNode);
    if ((DataMaquina <> nil) and (DataMaquina.RowData <> nil) and
       (DataMaquina.RowData.dbRow <> nil)) then
    begin
      with dmFichaTecnica.qrInsertMaquinaOperacao do
        try
          ParamByName('fk_pecas').AsInteger                 := FfkPeca;
          ParamByName('fk_ficha_tecnica').AsInteger         := FfkFichaTecnica;
          ParamByName('fk_operacoes').AsInteger             := afkOperacao;
          ParamByName('fk_fases_producao').AsInteger        := afkFasesProducao;
          // JOP 20.08.04 ParamByName('fk_tipo_fases_producao').AsInteger   := afkTipoFasesProducao;
          ParamByName('fk_maquinas').AsInteger              := DataMaquina.RowData.dbRow['fk_maquinas'].AsInteger;
          ParamByName('tmp_stp').AsFloat                    := DataMaquina.RowData.dbRow['tmp_stp'].AsFloat;
          ParamByName('tmp_oper').AsFloat                   := DataMaquina.RowData.dbRow['tmp_oper'].AsFloat;
          ParamByName('flag_def').AsInteger                 := DataMaquina.RowData.dbRow['flag_def'].AsInteger;
          ExecSql;
        finally
          Close;
        end;
//      DataMaquina.RowData.dbRow['fk_pecas'].AsInteger          := FfkPeca;
//      DataMaquina.RowData.dbRow['fk_operacoes'].AsInteger      := afkOperacao;
//      DataMaquina.RowData.dbRow['fk_fases_producao'].AsInteger := afkFasesProducao;
      FerramentaNode := stMaquinas.GetFirstChild(MaquinaNode);
      while FerramentaNode <> nil do
      begin
        DataFerramenta := stMaquinas.GetNodeData(FerramentaNode);
        if ((DataFerramenta <> nil) and (DataFerramenta.RowData <> nil) and
           (DataFerramenta.RowData.dbRow <> nil)) then
        begin
          with dmFichaTecnica.qrInsertFerramentaOperacao do
            try
              ParamByName('fk_pecas').AsInteger                 := FfkPeca;
              ParamByName('fk_ficha_tecnica').AsInteger         := FfkFichaTecnica;
              ParamByName('fk_operacoes').AsInteger             := afkOperacao;
              ParamByName('fk_fases_producao').AsInteger        := afkFasesProducao;
              // JOP 20.08.04 ParamByName('fk_tipo_fases_producao').AsInteger   := afkTipoFasesProducao;
              ParamByName('fk_maquinas').AsInteger              := DataMaquina.RowData.dbRow['fk_maquinas'].AsInteger;
              ParamByName('fk_insumos').AsInteger               := DataFerramenta.RowData.dbRow['fk_insumos'].AsInteger;
              ExecSql;
            finally
              Close;
            end;
        end;
//        DataFerramenta.RowData.dbRow['fk_pecas'].AsInteger          := FfkPeca;
//        DataFerramenta.RowData.dbRow['fk_operacoes'].AsInteger      := afkOperacao;
//        DataFerramenta.RowData.dbRow['fk_fases_producao'].AsInteger := afkFasesProducao;
        DataFerramenta.RowData.dbRow['fk_maquinas'].AsInteger := DataMaquina.RowData.dbRow['fk_maquinas'].AsInteger;
        FerramentaNode := stMaquinas.GetNextSibling(FerramentaNode);
      end;
    end;
    MaquinaNode:=stMaquinas.GetNextSibling(MaquinaNode);
  end;
end;

procedure TfmEditOperacao.stMaquinasGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData;
begin
  if Node = nil then exit;
  Data := stMaquinas.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then exit;
  with Data.RowData do
    case Level of
      0: case Column of
              0:CellText := dbRow['dsc_maq'].AsString;
              1:CellText := FormatFloat('#,##0.0000',dbRow['tmp_stp'].AsFloat);
              2:CellText := FormatFloat('#,##0.0000',dbRow['tmp_oper'].AsFloat);
         end;
      1: if Column=0 Then CellText := dbRow['dsc_ins'].AsString
         else CellText:='';
    end;
end;

procedure TfmEditOperacao.stMaquinasDblClick(Sender: TObject);
begin
  if ((cmPropriedades.Visible) and (cmPropriedades.Enabled) and
     (Assigned(cmPropriedades.OnClick))) then
    cmPropriedades.OnClick(Self);
end;

procedure TfmEditOperacao.signalizeChange(Sender: TObject);
begin
  if ((not (FInsideMove)) and (cmdUpdate.Visible) and (not (cmdUpdate.Enabled))) then
    cmdUpdate.Enabled := True;
end;

procedure TfmEditOperacao.stPecasChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  SignalizeChange(Self);
end;

function TfmEditOperacao.MayClose:Boolean;
var
  Rc: Integer;
begin
  Result := not ((cmdUpdate.Visible) and (cmdUpdate.Enabled));
  if Result then exit;
  Rc := MessageBox(Self.Handle, 'Deseja salvar as alterações realizadas na operação ?',
          PChar(Caption), MB_ICONQUESTION or MB_YESNOCANCEL);
  case Rc of
    IDYES    : Result := OperacaoSaved;
    IDNO     : Result := True;
    IDCANCEL : Result := False;
  end;
end;

procedure TfmEditOperacao.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := MayClose;
end;

procedure TfmEditOperacao.stInsumosEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := ((Node <> nil) and ((Column = 1)or(Column=2)) and (FUpdateAllowed));
end;

procedure TfmEditOperacao.stMaquinasNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var Data:PTreeData;
begin
  if ((Node=Nil)Or(Not(Column In [1,2]))) Then Exit;
  Data:=stMaquinas.GetNodeData(Node);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.dbRow=Nil)Or(Data.RowData.Level<>0)) Then Exit;
  case Column of
       1:Data.RowData.dbRow['tmp_stp'].AsFloat :=StrToFloatDef(NewText,0);
       2:Data.RowData.dbRow['tmp_oper'].AsFloat:=StrToFloatDef(NewText,0);
  end;
  SignalizeChange(Self);
end;

procedure TfmEditOperacao.stMaquinasResize(Sender: TObject);
begin
//  stMaquinas.Header.Columns[0].Width    := stMaquinas.Width-
//                                           stMaquinas.Header.Columns[1].Width-
//                                           stMaquinas.Header.Columns[2].Width-50;
end;

procedure TfmEditOperacao.stMaquinasEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed:=((Node<>Nil)And(Column In [1,2])And(stMaquinas.GetNodeLevel(Node)=0));
end;

procedure TfmEditOperacao.stMaquinasColumnDefs1PrepareEdit(
  Sender: TColumnDef; aEdit: TWinControl);
begin
  if ((Sender<>Nil)And(Sender.Index=1)And(aEdit<>Nil)And(aEdit is TCurrencyEdit)) Then
     with TCurrencyEdit(aEdit) do
          begin
            DisplayFormat:=',0.0000;-,0.0000';
            DecimalPlaces:=4;
          end;
end;

procedure TfmEditOperacao.stMaquinasColumnDefs2PrepareEdit(
  Sender: TColumnDef; aEdit: TWinControl);
begin
  if ((Sender<>Nil)And(Sender.Index=2)And(aEdit<>Nil)And(aEdit is TCurrencyEdit)) Then
     with TCurrencyEdit(aEdit) do
          begin
            DisplayFormat:=',0.0000;-,0.0000';
            DecimalPlaces:=4;
          end;
end;

procedure TfmEditOperacao.stMaquinasInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
  if ((Node<>Nil)And(stMaquinas.GetNodeLevel(Node)=0)) Then
     Node.CheckType:=ctCheckBox;
end;

procedure TfmEditOperacao.stMaquinasChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var Data        : PTreeData;
    OtherNode   : PVirtualNode;
begin
  if ((Node=Nil)Or(Sender=Nil)Or(Sender.GetNodeLevel(Node)<>0)) Then Exit;
  Data:=Sender.GetNodeData(Node);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.dbRow=Nil)Or(Data.RowData.Level<>0)) Then Exit;
  Data.RowData.dbRow['flag_def'].AsInteger:=Integer(Node.CheckState=csCheckedNormal);
  if Data.RowData.dbRow['flag_def'].AsInteger=1 Then
     try
       Sender.BeginUpdate;
       OtherNode:=Sender.GetFirst;
       While OtherNode<>Nil do
             begin
               if OtherNode<>Node Then
                  begin
                    Data:=Sender.GetNodeData(OtherNode);
                    if ((Data<>Nil)And(Data.RowData<>Nil)And(Data.RowData.dbRow<>Nil)And(Data.RowData.Level=0)) Then
                       begin
                         Data.RowData.dbRow['flag_def'].AsInteger:=0;
                         OtherNode.CheckState:=csUnCheckedNormal;
                       end;
                  end;
               OtherNode:=Sender.GetNextSibling(OtherNode);
             end;
     finally
       Sender.EndUpdate;
     end;
  SignalizeChange(Sender);
end;

procedure TfmEditOperacao.stInsumosColumnDefs1PrepareEdit(
  Sender: TColumnDef; aEdit: TWinControl);
begin
  if ((Sender<>Nil)And(Sender.Index=1)And(aEdit<>Nil)And(aEdit is TCurrencyEdit)) Then
     with TCurrencyEdit(aEdit) do
          begin
            DisplayFormat:=',0.0000;-,0.0000';
            DecimalPlaces:=4;
          end;
end;

procedure TfmEditOperacao.stServicosColumnDefs1PrepareEdit(
  Sender: TColumnDef; aEdit: TWinControl);
begin
  if ((Sender<>Nil)And(Sender.Index=1)And(aEdit<>Nil)And(aEdit is TCurrencyEdit)) Then
     with TCurrencyEdit(aEdit) do
          begin
            DisplayFormat:=',0.0000;-,0.0000';
            DecimalPlaces:=4;
          end;
end;

procedure TfmEditOperacao.stTiposAcabamentoColumnDefs1PrepareEdit(
  Sender: TColumnDef; aEdit: TWinControl);
begin
  if ((Sender<>Nil)And(Sender.Index=1)And(aEdit<>Nil)And(aEdit is TCurrencyEdit)) Then
     with TCurrencyEdit(aEdit) do
          begin
            DisplayFormat:=',0.0000;-,0.0000';
            DecimalPlaces:=4;
          end;
end;

end.
