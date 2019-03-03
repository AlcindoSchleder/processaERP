unit FichaTecnica;

 {*************************************************************************}
 {*                                                                       *}
 {* Author: CSD Informatica Ltda.                                         *}
 {* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
 {* Created: 02/06/2003                                                   *}
 {* Modified: 02/06/2003                                                  *}
 {* Version: 1.2.1.0                                                      *}
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
  Dialogs, DB, IBCustomDataSet, IBQuery, IBDatabase, StdCtrls, VirtualTrees,
  CSDVirtualStringTree, dbObjects, Menus, ComCtrls, ExtCtrls, ImgList, ProcType,
  Buttons, CopyFicha, EditOperacao, jpeg, ToolWin;

type
  TRowData = class(TObject)
    Node: PVirtualNode;
    dbRow: TdbRow;
    Level: Integer;
    constructor Create;
    destructor Destroy; override;
  end;

  PRowData = ^TRowData;

  TTreeData = record
    RowData: TRowData;
  end;
  PTreeData = ^TTreeData;

  TfmFichaTecnica = class(TForm)
    pop: TPopupMenu;
    cmDelete: TMenuItem;
    cmDelimiter2: TMenuItem;
    cmProperties: TMenuItem;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    MainMenu: TMainMenu;
    miFile: TMenuItem;
    miPrint: TMenuItem;
    miSepFile: TMenuItem;
    miClose: TMenuItem;
    miOperations: TMenuItem;
    miTools: TMenuItem;
    miVisibleEntrp: TMenuItem;
    miSepTools2: TMenuItem;
    miHelp: TMenuItem;
    miTopics: TMenuItem;
    miContent: TMenuItem;
    miSepHelp: TMenuItem;
    miAbout: TMenuItem;
    miSepHelp1: TMenuItem;
    miSendMail: TMenuItem;
    miCopyFichaTo: TMenuItem;
    cmInsert: TMenuItem;
    cmDelimiter1: TMenuItem;
    popOperacoes: TPopupMenu;
    cmNovaOperacao: TMenuItem;
    cmPropriedadesOperacao: TMenuItem;
    cmDeleteOperacao: TMenuItem;
    cmNovaFase: TMenuItem;
    paConfiguracaoTitle: TPanel;
    pCompany: TPanel;
    lNameCompany: TLabel;
    Panel2: TPanel;
    sbCompany: TSpeedButton;
    pgFicha: TPageControl;
    tbPesquisa: TTabSheet;
    gbSubGrupo: TGroupBox;
    lFk_Secoes: TLabel;
    lFk_SubGrupos: TLabel;
    lFk_Grupos: TLabel;
    cbSecoes: TComboBox;
    cbSubGrupos: TComboBox;
    cbGrupos: TComboBox;
    optSubGrupo: TRadioButton;
    gbReferencia: TGroupBox;
    cmdSearchReferencia: TSpeedButton;
    edReferencia: TEdit;
    optReferencia: TRadioButton;
    gbDescricao: TGroupBox;
    cmdSearchDescricao: TSpeedButton;
    edDescricao: TEdit;
    optDescricao: TRadioButton;
    tbFicha: TTabSheet;
    Splitter2: TSplitter;
    paImg: TPanel;
    imPeca: TImage;
    Splitter3: TSplitter;
    stFases: TCSDVirtualStringTree;
    stComponentes: TCSDVirtualStringTree;
    stPecas: TCSDVirtualStringTree;
    Panel3: TPanel;
    cmdCollapsePeca: TSpeedButton;
    cmdExpandPeca: TSpeedButton;
    lFicha: TLabel;
    cmdSearchSubGrupo: TSpeedButton;
    cmdShowFicha: TBitBtn;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    tbProdutosPeca: TTabSheet;
    stProdutos: TCSDVirtualStringTree;
    laProdutoTitle: TLabel;
    cmdRetrieveFichaProduto: TBitBtn;
    ImageList2: TImageList;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    cmdAddComponente: TToolButton;
    cmdDeleteComponente: TToolButton;
    cmdPropertiesComponente: TToolButton;
    ToolButton4: TToolButton;
    cmdAddFase: TToolButton;
    cmdDeleteFase: TToolButton;
    cmdPropertiesFase: TToolButton;
    ToolButton9: TToolButton;
    cmdAddOperacao: TToolButton;
    cmdDeleteOperacao: TToolButton;
    cmdPropertiesOperacao: TToolButton;
    miComponents: TMenuItem;
    miFases: TMenuItem;
    miOperators: TMenuItem;
    miAddComponent: TMenuItem;
    miDeleteComponent: TMenuItem;
    miPropertiesComponent: TMenuItem;
    miAddFase: TMenuItem;
    miDeleteFase: TMenuItem;
    miPropertiesFase: TMenuItem;
    miAddOperation: TMenuItem;
    miDeleteOperation: TMenuItem;
    miPropertiesOperation: TMenuItem;
    procedure cbGruposClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure stComponentesGetText(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
      var CellText : WideString);
    procedure popPopup(Sender : TObject);
    procedure cmDeleteClick(Sender : TObject);
    procedure cmPropertiesClick(Sender : TObject);
    procedure stComponentesEditing(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex; var Allowed : Boolean);
    procedure stComponentesResize(Sender : TObject);
    procedure stComponentesGetImageIndex(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
      var Ghosted : Boolean; var ImageIndex : Integer);
    procedure cmdExpandPecaClick(Sender : TObject);
    procedure cmdCollapsePecaClick(Sender : TObject);
    procedure cbSubGruposClick(Sender : TObject);
    procedure mCloseClick(Sender : TObject);
    procedure miCloseClick(Sender : TObject);
    procedure sbCompanyClick(Sender : TObject);
    procedure miVisibleEntrpClick(Sender : TObject);
    procedure miSendMailClick(Sender : TObject);
    procedure miAboutClick(Sender : TObject);
    procedure cbSecoesClick(Sender : TObject);
    procedure miOperationsClick(Sender : TObject);
    procedure miCopyFichaToClick(Sender : TObject);
    procedure cmInsertClick(Sender : TObject);
    procedure stFasesGetText(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; TextType : TVSTTextType; var CellText : WideString);
    procedure stFasesResize(Sender : TObject);
    procedure stComponentesChange(Sender : TBaseVirtualTree; Node : PVirtualNode);
    procedure popOperacoesPopup(Sender : TObject);
    procedure cmPropriedadesOperacaoClick(Sender : TObject);
    procedure cmNovaOperacaoClick(Sender : TObject);
    procedure cmDeleteOperacaoClick(Sender : TObject);
    procedure cmNovaFaseClick(Sender : TObject);
    procedure stFasesDblClick(Sender : TObject);
    procedure stPecasResize(Sender : TObject);
    procedure optSubGrupoClick(Sender : TObject);
    procedure stPecasColumnDefs1GetPickItems(Sender : TColumnDef; slItems : TStrings);
    procedure stPecasGetText(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; TextType : TVSTTextType; var CellText : WideString);
    procedure stPecasNewText(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; NewText : WideString);
    procedure cmdSearchSubGrupoClick(Sender : TObject);
    procedure cmdSearchReferenciaClick(Sender : TObject);
    procedure cmdSearchDescricaoClick(Sender : TObject);
    procedure stPecasEditing(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; var Allowed : Boolean);
    procedure cbSecoesKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure edReferenciaKeyDown(Sender : TObject; var Key : Word;
      Shift : TShiftState);
    procedure edDescricaoKeyDown(Sender : TObject; var Key : Word;
      Shift : TShiftState);
    procedure stPecasDblClick(Sender : TObject);
    procedure cmdShowFichaClick(Sender : TObject);
    procedure stPecasPaintText(Sender : TBaseVirtualTree;
      const TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex;
      TextType : TVSTTextType);
    procedure stPecasCompareNodes(Sender : TBaseVirtualTree;
      Node1, Node2 : PVirtualNode; Column : TColumnIndex; var Result : Integer);
    procedure stProdutosResize(Sender : TObject);
    procedure stProdutosDblClick(Sender : TObject);
    procedure stProdutosGetText(Sender : TBaseVirtualTree; Node : PVirtualNode;
      Column : TColumnIndex; TextType : TVSTTextType; var CellText : WideString);
    procedure stProdutosCompareNodes(Sender : TBaseVirtualTree;
      Node1, Node2 : PVirtualNode; Column : TColumnIndex; var Result : Integer);
    procedure pgFichaChanging(Sender : TObject; var AllowChange : Boolean);
    procedure pgFichaChange(Sender : TObject);
    procedure cmdRetrieveFichaProdutoClick(Sender : TObject);
    procedure stFasesChange(Sender : TBaseVirtualTree; Node : PVirtualNode);
  private
    { Private declarations }
    Ffk_empresas: Integer;
    Ffk_secoes: Integer;
    Ffk_grupos: Integer;
    Ffk_subgrupos: Integer;
    Fpk_pecas: Integer;
    Ffk_ficha_tecnica: Integer;
    FslProdutos: TList;
    FslPecas: TList;
    FslComponentes: TList;
    FslFases: TList;
    FInsideMove: Boolean;
    RodaPrograma: TRodaPrograma;
    FFirstDymMainMenuItem: Integer;
    FMaincmDelete: TMenuItem;
    FMaincmProperties: TMenuItem;
    FMaincmDelimiter1: TMenuItem;
    FMaincmDelimiter2: TMenuItem;
    FLastReferencia: String;
    FCurrentOperacaoParentNode, FCurrentOperacaoNode, FCurrentNode,
    FCurrentParentNode: PVirtualNode;
    FfkPecaProduto: Integer;
    FfkFichaTecnicaProduto: Integer;
    FLastfkPecaProduto: Integer;
    FLastfkFichaTecnicaProduto: Integer;
    FDescricaoPecaProduto: String;
    FFromPage: TTabSheet;
    function TotalPecasParents(aNode : PVirtualNode; Qtd : Double): Double;
    procedure EnableComponentCommands(Node : PVirtualNode);
    procedure EnableFaseCommands(Node : PVirtualNode);
    procedure ClearProdutos;
    procedure LoadProdutos;
    procedure GetFichaTecnicaSelectedPeca(var afkPecas : Integer;
      var afkFichaTecnica : Integer; var aDescricaoPeca : String);
    procedure HandleNewComponente(Sender : TObject;
      afkPeca, afkFichaTecnica, afkPecaMontagem,
      afkFichaTecnicaMontagem : Integer;
      aDescPecaMontagem : String);
    procedure HandleUpdateComponente(Sender : TObject;
      afkPeca, afkFichaTecnica, afkPecaMontagem,
      afkFichaTecnicaMontagem : Integer;
      aDescPecaMontagem : String);
    procedure HandleNewClick(Sender : TObject);
    procedure ClearSecoes;
    procedure LoadSecoes;
    procedure ClearGrupos;
    procedure LoadGrupos;
    procedure ClearSubGrupos;
    procedure LoadSubGrupos;
    procedure ClearPecas;
    procedure LoadPecas;
    procedure ClearComponentes;
    procedure LoadComponentes;
    procedure ClearFases;
    procedure LoadFases;
    procedure ClearImage;
    procedure LoadImage;
    function ComponenteDeleted(aRow : TdbRow): Boolean;
    procedure LocateFichaByReferencia;
    procedure CopyFichaTecnica(fkPecasFrom, fkFichaTecnicaFrom,
      fkPecasTo, MajVerTo, MinVerTo : Integer);
    procedure OpenFormLibrary(Form, LIB : String);
    function AddAComponente(ParentNode : PVirtualNode; aRow : TdbRow): PVirtualNode;
    procedure RetrieveSubComponentes(ParentNode : PVirtualNode;
      fkPeca, fkFichaTecnica : Integer);
    procedure AddParentsToList(sl : TList; aNode : PVirtualNode);
    procedure HandleNewOperacao(Sender : TObject;
      afkPeca, afkFichaTecnica, afkFaseProducao, afkOperacao : Integer);
    procedure HandleUpdateOperacao(Sender : TObject;
      afkPeca, afkFichaTecnica, afkFaseProducao, afkOperacao : Integer);
    procedure PropriedadesFase;
    procedure PropriedadesOperacao;
    procedure ExcluirFase;
    procedure ExcluirOperacao;
    procedure HandleNewFaseProducao(Sender : TObject;
      afkPecas, afkFichaTecnica, afkFaseProducao : Integer);
    procedure HandleUpdateFaseProducao(Sender : TObject;
      afkPecas, afkFichaTecnica, afkFaseProducao : Integer);
  public
    { Public declarations }
  end;

var
  fmFichaTecnica: TfmFichaTecnica;

implementation

uses udmFichaTecnica, EditPeca, Dado, SelEmpr, CmmConst, Sobre, Funcoes,
  EditFaseProducao, FuncoesDB;

{$R *.dfm}

var
  NEW_CAPTION:    String = '&Novo SubComponente';
  DELETE_CAPTION: String = 'E&xcluir';
  PROPERTIES_CAPTION: String = '&Propriedades';

{ TRowData }

constructor TRowData.Create;
begin
  inherited Create;
end;

destructor TRowData.Destroy;
begin
  if dbRow <> nil then
  begin
    dbRow.Free;
    dbRow := nil;
  end;
  inherited Destroy;
end;

{ TfmFichaTecnica }

procedure TfmFichaTecnica.ClearSecoes;
begin
  ClearGrupos;
  Ffk_Secoes := -1;
  cbSecoes.Items.Clear;
end;

procedure TfmFichaTecnica.LoadSecoes;
var
  S: String;
begin
  ClearSecoes;
  with dmFichaTecnica.qrSecoes do
    try
      S := SQL.Text;
      Sql.Insert(Sql.Count - 1, 'Where FLAG_TMAT=1');
      Open;
      while not (EOF) do
      begin
        cbSecoes.Items.AddObject(FieldByName('DSC_SEC').AsString,
          TObject(FieldByName('PK_SECOES').AsInteger));
        Next;
      end;
    finally
      Close;
      SQL.Text := S;
    end;
end;

procedure TfmFichaTecnica.ClearGrupos;
begin
  ClearSubGrupos;
  Ffk_Grupos := -1;
  cbGrupos.Items.Clear;
end;

procedure TfmFichaTecnica.LoadGrupos;
begin
  ClearGrupos;
  cbGrupos.Items.AddObject('<TODOS>', nil);
  if Ffk_Secoes < 1 then
    exit;
  with dmFichaTecnica.qrGrupos do
    try
      ParamByName('fk_secoes').AsInteger := Ffk_secoes;
      Open;
      while not (EOF) do
      begin
        cbGrupos.Items.AddObject(FieldByName('DSC_GRU').AsString,
          TObject(FieldByName('PK_GRUPOS').AsInteger));
        Next;
      end;
    finally
      Close;
    end;
end;

procedure TfmFichaTecnica.ClearSubGrupos;
begin
  Ffk_SubGrupos := -1;
  cbSubGrupos.Items.Clear;
end;

procedure TfmFichaTecnica.LoadSubGrupos;
begin
  ClearSubGrupos;
  cbSubGrupos.Items.AddObject('<TODOS>', nil);
  if Ffk_Secoes < 1 then
    exit;
  with dmFichaTecnica.qrSubGrupos do
    try
      ParamByName('fk_secoes').AsInteger := Ffk_secoes;
      ParamByName('fk_grupos').AsInteger := Ffk_grupos;
      Open;
      while not (EOF) do
      begin
        cbSubGrupos.Items.AddObject(FieldByName('DSC_SGRU').AsString,
          TObject(FieldByName('PK_SUBGRUPOS').AsInteger));
        Next;
      end;
    finally
      Close;
    end;
end;

procedure TfmFichaTecnica.ClearProdutos;
var
  I: Integer;
  RowData: TRowData;
begin
  for I := 0 to FslProdutos.Count - 1 do
  begin
    RowData := TRowData(FslProdutos[I]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslProdutos[I] := nil;
    end;
  end;
  FslProdutos.Clear;
  stProdutos.Clear;
end;

procedure TfmFichaTecnica.ClearPecas;
var
  I: Integer;
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
  FPK_Pecas := -1;
  Ffk_Ficha_Tecnica := -1;
  miCopyFichaTo.Visible := False;
  ClearComponentes;
end;

procedure TfmFichaTecnica.LoadPecas;
var
  S, SqlSaved, VersoesStr, MaiorVersao, VersaoAtiva,
  CurrVersao, WhereClause: String;
  LastfkPeca: Integer;
  Data:      PTreeData;
  RowData:   TRowData;
  Node:      PVirtualNode;
  LastDbRow: TdbRow;

  procedure SetUpNovaPeca;
  begin
    LastDbRow   := TdbRow.CreateFromDs(dmFichaTecnica.qrPecas, True);
    LastfkPeca  := dmFichaTecnica.qrPecas.FieldByName('fk_pecas').AsInteger;
    MaiorVersao := '';
    VersoesStr  := '';
    VersaoAtiva := '';
  end;

  procedure AddAPeca;
  begin
    if LastDbRow = nil then
      exit;
    RowData := TRowData.Create;
    RowData.Level := 0;
    LastdbRow['Versoes'].AsString := VersoesStr;
    LastdbRow['VersaoAtiva'].AsString := VersaoAtiva;
    LastdbRow['MaiorVersao'].AsString := MaiorVersao;
    LastdbRow['CurrVersao'].AsString := MaiorVersao;
    RowData.dbRow := LastDbRow;
    Node    := stPecas.AddChild(nil);
    Data    := stPecas.GetNodeData(Node);
    Data.RowData := RowData;
    Data.RowData.Node := Node;
    FslPecas.Add(Data.RowData);
  end;

begin
  WhereClause := '';
  if optSubGrupo.Checked then
  begin
    WhereClause := 'And F.fk_Secoes=' + IntToStr(Ffk_secoes);
    if Ffk_Grupos > 0 then
    begin
      WhereClause := WhereClause + ' And F.fk_Grupos=' + IntToStr(Ffk_grupos);
      if Ffk_SubGrupos > 0 then
        WhereClause := WhereClause + ' And F.fk_SubGrupos=' + IntToStr(Ffk_SubGrupos);
    end;
  end
  else
  if optReferencia.Checked then
  begin
    S := edReferencia.Text;
    if Pos('%', S) < 1 then
      S := S + '%';
    WhereClause := 'And F.COD_REF Like ''' + S + '''';
        //WhereClause:='And F.COD_REF='''+edReferencia.Text+''''
  end
  else
  begin
    S := edDescricao.Text;
    if Pos('%', S) < 1 then
      S := S + '%';
    WhereClause := 'And F.Dsc_pec like ''' + S + '''';
  end;
  stPecas.BeginUpdate;
  Screen.Cursor := crHourGlass;
  with dmFichaTecnica.qrPecas do
    try
      ClearPecas;
      SqlSaved := Sql.Text;
      Sql.Insert(Sql.Count - 1, WhereClause);
      Open;
      if not (EOF) then
      begin
        SetUpNovaPeca;
        while not (EOF) do
        begin
          if FieldByName('fk_pecas').AsInteger <> LastfkPeca then
          begin
            AddAPeca;
            SetUpNovaPeca;
          end;
          CurrVersao :=
            IntToStr(FieldByName('maj_ver').AsInteger) + '.' + IntToStr(
            FieldByName('min_ver').AsInteger);
          if VersoesStr <> '' then
            VersoesStr := VersoesStr + ',';
          VersoesStr := VersoesStr + CurrVersao;
          if CurrVersao > MaiorVersao then
            MaiorVersao := CurrVersao;
          if dmFichaTecnica.qrPecas.FieldByName('flag_atv').AsInteger = 1 then
            VersaoAtiva := CurrVersao;
          Next;
        end;
        AddAPeca;
      end;
    finally
      Close;
      Sql.Text := SqlSaved;
      stPecas.SortTree(0, sdAscending, False);
      Screen.Cursor := crDefault;
      stPecas.EndUpdate;
    end;
end;

procedure TfmFichaTecnica.LoadProdutos;
var
  Data:    PTreeData;
  RowData: TRowData;
  Node:    PVirtualNode;

  procedure AddAProduto;
  begin
    RowData := TRowData.Create;
    RowData.Level := 0;
    RowData.dbRow :=
      TdbRow.CreateFromDs(dmFichaTecnica.qrProdutosPeca, True);
    Node    := stProdutos.AddChild(nil);
    Data    := stProdutos.GetNodeData(Node);
    Data.RowData := RowData;
    Data.RowData.Node := Node;
    FslProdutos.Add(Data.RowData);
  end;

begin
  if ((FfkPecaProduto < 1) or (FfkFichaTecnicaProduto < 1) or
    ((FfkPecaProduto = FLastfkPecaProduto) and
    (FfkFichaTecnicaProduto = FLastfkFichaTecnicaProduto))) then
    exit;
  laProdutoTitle.Caption := FDescricaoPecaProduto;
  stProdutos.BeginUpdate;
  Screen.Cursor := crHourGlass;
  with dmFichaTecnica.qrProdutosPeca do
    try
      ClearProdutos;
      ParamByName('P_fk_pecas').AsInteger := FfkPecaProduto;
      ParamByName('P_fk_ficha_tecnica').AsInteger := FfkFichaTecnicaProduto;
      Open;
      while not (EOF) do
      begin
        if ((FieldByName('fk_pecas').AsInteger <> FfkPecaProduto) or
          (FieldByName('fk_ficha_tecnica').AsInteger <> FfkFichaTecnicaProduto)) then
          AddAProduto;
        Next;
      end;
    finally
      Close;
      FLastfkPecaProduto := FfkPecaProduto;
      FLastfkFichaTecnicaProduto := FfkFichaTecnicaProduto;
      stProdutos.SortTree(0, sdAscending, False);
      Screen.Cursor := crDefault;
      stProdutos.EndUpdate;
    end;
end;


procedure TfmFichaTecnica.cbGruposClick(Sender : TObject);
begin
  if cbGrupos.ItemIndex < 0 then
    exit;
  Ffk_Grupos := LongInt(cbGrupos.Items.Objects[cbGrupos.ItemIndex]);
  LoadSubGrupos;
  if cbSubGrupos.Items.Count < 1 then
    exit;
  cbSubGrupos.ItemIndex := 0;
  if Assigned(cbSubGrupos.OnClick) then
    cbSubGrupos.OnClick(Self);
end;

procedure TfmFichaTecnica.HandleNewClick(Sender : TObject);
var
  aNode: PVirtualNode;
  Data:  PTreeData;
  afkFichaTecnica, afkPeca: Integer;
begin
  FCurrentParentNode := nil;
  FCurrentNode := nil;
  //if ((Sender = nil) or (not(Sender is TMenuItem))Or(Fpk_pecas<1)Or(Ffk_Ficha_Tecnica<1)) then exit;
  if ((Fpk_pecas < 1) or (Ffk_Ficha_Tecnica < 1)) then
    exit;
  aNode := stComponentes.FocusedNode;
  if aNode = nil then
    exit;
  Data := stComponentes.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  FCurrentParentNode := aNode;
  FCurrentNode := nil;
  afkPeca      := Data.RowData.dbRow['fk_pecas'].AsInteger;
  afkFichaTecnica := Data.RowData.dbRow['fk_ficha_tecnica'].AsInteger;
  with TfmEditPeca.Create(Self) do
    try
      UpdateAllowed := True;
      fkPeca := afkPeca;
      fkFichaTecnica := afkFichaTecnica;
      fkFichaTecnicaMontagem := 0;
      fkPecaMontagem := 0;
      OnInsertComponente := HandleNewComponente;
      OnUpdateComponente := HandleUpdateComponente;
      AddParentsToList(slParents, aNode);
      ShowModal;
    finally
      Release;
      FCurrentParentNode := nil;
      FCurrentNode := nil;
    end;
end;

procedure TfmFichaTecnica.FormCreate(Sender : TObject);
var
  NewItem: TMenuItem;
  I: Integer;
begin
  if pgFicha.ActivePage <> tbPesquisa then
    pgFicha.ActivePage := tbPesquisa;

  Caption := StrPas(ParamGlobal^.SystemTitle) + ' - ' +
    StrPas(ParamGlobal^.ProgramTitle);
  miFile.Caption := Dados.GetStringMessage(LANGUAGE, 'smiFile', '&Arquivo');
  miOperations.Caption := Dados.GetStringMessage(LANGUAGE, 'smiOperations',
    '&Operações');
  miOperators.Caption := Dados.GetStringMessage(LANGUAGE, 'smiOperations',
    '&Operações');
  miComponents.Caption := Dados.GetStringMessage(LANGUAGE, 'smiComponents',
    '&Componentes');
  miTools.Caption := Dados.GetStringMessage(LANGUAGE, 'smiTools', '&Ferramentas');
  miHelp.Caption := Dados.GetStringMessage(LANGUAGE, 'smiHelp', 'Aj&uda');
  miPrint.Caption := Dados.GetStringMessage(LANGUAGE, 'smiPrint', 'Im&primir');
  miClose.Caption := Dados.GetStringMessage(LANGUAGE, 'smiClose', 'Sai&r');
  miVisibleEntrp.Caption :=
    Dados.GetStringMessage(LANGUAGE, 'smiVisibleEntrp', '&Exibir Empresa Ativa');
  miCopyFichaTo.Caption :=
    Dados.GetStringMessage(LANGUAGE, 'smiCopyFichaTo', '&Copiar a Estrutura para:');
  miTopics.Caption := Dados.GetStringMessage(LANGUAGE, 'smiTopics', '&Tópicos');
  miContent.Caption := Dados.GetStringMessage(LANGUAGE, 'smiContent', 'Co&nteúdo');
  miAbout.Caption := Dados.GetStringMessage(LANGUAGE, 'smiAbout', '&Sobre');
  miSendMail.Caption := Dados.GetStringMessage(LANGUAGE,
    'smiSendMail', 'Enviar E-&Mail');
  lFk_Secoes.Caption := Dados.GetStringMessage(LANGUAGE, 'sFkSecoes', '&Seções:');
  lFk_Grupos.Caption := Dados.GetStringMessage(LANGUAGE, 'sFkGrupos', '&Grupos:');
  lFk_SubGrupos.Caption := Dados.GetStringMessage(LANGUAGE,
    'sFkSubGrupos', '&SubGrupos:');
  stPecas.Header.Columns[0].Text :=
    Dados.GetStringMessage(LANGUAGE, 'sPecaCaption1', 'Peça');
  stPecas.Header.Columns[1].Text :=
    Dados.GetStringMessage(LANGUAGE, 'sPecaCaption2', 'Versão');
  stComponentes.Header.Columns[0].Text :=
    Dados.GetStringMessage(LANGUAGE, 'sFichaCaption1', 'Peça');
  stComponentes.Header.Columns[1].Text :=
    Dados.GetStringMessage(LANGUAGE, 'sFichaCaption2', 'Qtde');
  stComponentes.Header.Columns[2].Text :=
    Dados.GetStringMessage(LANGUAGE, 'sFichaCaption3', 'Custo');
  stFases.Header.Columns[0].Text :=
    Dados.GetStringMessage(LANGUAGE, 'sFaseCaption1', 'Fase Produção');
  //NEW_CAPTION          := Dados.GetStringMessage(LANGUAGE, 'sNEW_CAPTION', NEW_CAPTION);
  //DELETE_CAPTION       := Dados.GetStringMessage(LANGUAGE, 'sDELETE_CAPTION', DELETE_CAPTION);
  //PROPERTIES_CAPTION   := Dados.GetStringMessage(LANGUAGE, 'sPROPERTIES_CAPTION', PROPERTIES_CAPTION);

  cmInsert.Caption     := NEW_CAPTION;
  cmDelete.Caption     := DELETE_CAPTION;
  cmProperties.Caption := PROPERTIES_CAPTION;

  miAddComponent.Caption    := Dados.GetStringMessage(LANGUAGE,
    'smiAddComponent', '&Novo Componente');
  miDeleteComponent.Caption :=
    Dados.GetStringMessage(LANGUAGE, 'smiDeleteComponent', '&Excluir Componente');
  miPropertiesComponent.Caption :=
    Dados.GetStringMessage(LANGUAGE, 'smiPropertiesComponent',
    '&Propriedades do Componente');

  miAddFase.Caption    := Dados.GetStringMessage(LANGUAGE, 'smiAddFase', '&Nova Fase');
  miDeleteFase.Caption := Dados.GetStringMessage(LANGUAGE, 'smiDeleteFase',
    '&Excluir Fase');
  miPropertiesFase.Caption := Dados.GetStringMessage(LANGUAGE,
    'smiPropertiesFase', '&Propriedades da Fase');

  miAddOperation.Caption    := Dados.GetStringMessage(LANGUAGE,
    'smiAddOperation', '&Nova Operação');
  miDeleteOperation.Caption :=
    Dados.GetStringMessage(LANGUAGE, 'smiDeleteOperation', '&Excluir Operação');
  miPropertiesOperation.Caption :=
    Dados.GetStringMessage(LANGUAGE, 'smiPropertiesOperation', '&Propriedades da Operação');

  lNameCompany.Hint := Dados.GetStringMessage(LANGUAGE, 'sHintlNameEntrp',
    'Empresa Ativa');
// Enterprise Strings
  lNameCompany.Caption := Dados.GetStringMessage(LANGUAGE, 'sCampanyName',
    'Nome da Empresa:') + InsereZer(IntToStr(ParamGlobal^.ActiveCompany), 3) +
    ' - ' + StrPas(ParamGlobal^.NameCompany);
  sbCompany.Hint := Dados.GetStringMessage(LANGUAGE, 'sHintbEntrp');
  Dados.Image16.GetBitmap(26, sbCompany.Glyph);
  FslPecas      := TList.Create;
  FslComponentes := TList.Create;
  FslFases      := TList.Create;
  FslProdutos   := TList.Create;
  stPecas.NodeDataSize := SizeOf(TTreeData);
  stPecas.RootNodeCount := 0;
  stComponentes.NodeDataSize := SizeOf(TTreeData);
  stComponentes.RootNodeCount := 0;
  stFases.NodeDataSize := SizeOf(TTreeData);
  stFases.RootNodeCount := 0;
  stProdutos.NodeDataSize := SizeOf(TTreeData);
  stProdutos.RootNodeCount := 0;
  // Adding Insert Items to main menu also
  FMaincmDelete := nil;
  FMaincmProperties := nil;
  FMaincmDelimiter1 := nil;
  FMaincmDelimiter2 := nil;
  FFirstDymMainMenuItem := miOperations.Count;
  for I := 0 to pop.Items.Count - 1 do
  begin
    NewItem := TMenuItem.Create(miOperations);
    miOperations.Add(NewItem);
    NewItem.Caption := pop.Items[I].Caption;
    NewItem.Tag     := pop.Items[I].Tag;
    NewItem.OnClick := pop.Items[I].OnClick;
    NewItem.Visible := False;//pop.Items[I].Visible;
    if pop.Items[I] = cmDelete then
      FMaincmDelete := NewItem
    else
    if pop.Items[I] = cmProperties then
      FMaincmProperties := NewItem
    else
    if pop.Items[I] = cmDelimiter1 then
      FMaincmDelimiter1 := NewItem
    else
    if pop.Items[I] = cmDelimiter2 then
      FMaincmDelimiter2 := NewItem;
  end;
  Ffk_Empresas := Dados.Parametros.EmpresaAtiva;
  LoadSecoes;
  if cbSecoes.Items.Count > 0 then
  begin
    cbSecoes.ItemIndex := 0;
    if Assigned(cbSecoes.OnClick) then
      cbSecoes.OnClick(Self);
  end;
end;

procedure TfmFichaTecnica.FormDestroy(Sender : TObject);
begin
  ClearPecas;
  FslPecas.Free;
  FslPecas := nil;
  ClearComponentes;
  FslComponentes.Free;
  FslComponentes := nil;
  ClearFases;
  FslFases.Free;
  FslFases := nil;
  ClearProdutos;
  FslProdutos := nil;
end;

procedure TfmFichaTecnica.ClearFases;
var
  I: Integer;
  RowData: TRowData;
begin
  for I := 0 to FslFases.Count - 1 do
  begin
    RowData := TRowData(FslFases[I]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslFases[I] := nil;
    end;
  end;
  FslFases.Clear;
  stFases.Clear;
  cmdAddFase.Enabled     := False;
  cmdDeleteFase.Enabled  := False;
  cmdPropertiesFase.Enabled := False;
  cmdAddOperacao.Enabled := False;
  cmdDeleteOperacao.Enabled := False;
  cmdPropertiesOperacao.Enabled := False;
end;

procedure TfmFichaTecnica.LoadFases;
var
  RowData: TRowData;
  Data:    PTreeData;
  FaseNode, CurrNode: PVirtualNode;
  Fase:    TdbRow;
  LastfkFaseProducao: Integer;

  procedure AddFase(aParentNode : PVirtualNode);
  begin
    Fase     := TdbRow.CreateFromDs(dmFichaTecnica.qrOperacoes, True);
    LastfkFaseProducao := Fase['pk_fases_producao'].AsInteger;
    RowData  := TRowData.Create;
    RowData.Level := Integer(aParentNode <> nil);
    RowData.dbRow := Fase;
    CurrNode := stFases.AddChild(aParentNode);
    Data     := stFases.GetNodeData(CurrNode);
    Data.RowData := RowData;
    RowData.Node := CurrNode;
    FslFases.Add(RowData);
    if RowData.Level = 0 then
      FaseNode := CurrNode;
  end;

begin
  CurrNode := stComponentes.FocusedNode;
  if CurrNode = nil then
    exit;
  Data := stComponentes.GetNodeData(CurrNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  LastfkFaseProducao := 0;
  FaseNode      := nil;
  Screen.Cursor := crHourGlass;
  stFases.BeginUpdate;
  FInsideMove := True;
  try
    ClearFases;
    with dmFichaTecnica.qrOperacoes do
      try
        ParamByName('fk_pecas').AsInteger :=
          Data.RowData.dbRow['fk_pecas_montagem'].AsInteger;
        ParamByName('fk_ficha_tecnica').AsInteger :=
          Data.RowData.dbRow['fk_ficha_tecnica_montagem'].AsInteger;
        Open;
        while not (EOF) do
        begin
          if FieldByName('pk_fases_producao').AsInteger <> LastfkFaseProducao then
            AddFase(nil);
          if FieldByName('pk_operacoes').AsInteger > 0 then
            AddFase(FaseNode);
          Next;
        end;
      finally
        Close;
      end;
  finally
    stFases.FullExpand;
    stFases.EndUpdate;
    Screen.Cursor := crDefault;
    FInsideMove   := False;
  end;
end;

procedure TfmFichaTecnica.ClearComponentes;
var
  I: Integer;
  RowData: TRowData;
begin
  for I := 0 to FslComponentes.Count - 1 do
  begin
    RowData := TRowData(FslComponentes[I]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslComponentes[I] := nil;
    end;
  end;
  FslComponentes.Clear;
  stComponentes.Clear;
  cmdAddComponente.Enabled    := False;
  cmdDeleteComponente.Enabled := False;
  cmdDEleteComponente.Enabled := False;
  ClearFases;
  ClearImage;
  FCurrentParentNode := nil;
  FCurrentNode := nil;
end;

function TfmFichaTecnica.AddAComponente(ParentNode : PVirtualNode;
  aRow : TdbRow): PVirtualNode;
var
  RowData: TRowData;
  Data:    PTreeData;
  aNode:   PVirtualNode;
begin
  Result := nil;
  if aRow = nil then
    exit;
  if aRow['QTD_PEC'].AsInteger < 1 then
    aRow['QTD_PEC'].AsInteger := 1
  else
  if aRow['QTD_PEC'].AsInteger > 1 then
    aRow['QTD_GER'].AsInteger := 1;
  if aRow['QTD_GER'].AsInteger < 1 then
    aRow['QTD_GER'].AsInteger := 1
  else
  if aRow['QTD_GER'].AsInteger > 1 then
    aRow['QTD_PEC'].AsInteger := 1;
  RowData := TRowData.Create;
  if ParentNode = nil then
    RowData.Level := 0
  else
    RowData.Level := stComponentes.GetNodeLevel(ParentNode) + 1;
  RowData.dbRow := aRow;
  aNode := stComponentes.AddChild(ParentNode);
  Data  := stComponentes.GetNodeData(aNode);
  Data.RowData := RowData;
  RowData.Node := aNode;
  FslComponentes.Add(RowData);
  Result := aNode;
end;

procedure TfmFichaTecnica.RetrieveSubComponentes(ParentNode : PVirtualNode;
  fkPeca, fkFichaTecnica : Integer);
var
  sl:    TList;
  I:     Integer;
  aNode: PVirtualNode;
begin
  sl := TList.Create;
  try
    with dmFichaTecnica.qrPecasComponentes do
      try
        ParamByName('fk_pecas').AsInteger := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        Open;
        while not (EOF) do
        begin
          sl.Add(TdbRow.CreateFromDs(dmFichaTecnica.qrPecasComponentes, True));
          Next;
        end;
      finally
        Close;
      end;
    for I := 0 to sl.Count - 1 do
    begin
      aNode := AddAComponente(ParentNode, sl[I]);
      RetrieveSubComponentes(aNode, TdbRow(sl[I])
        ['fk_pecas_montagem'].AsInteger, TdbRow(sl[I])['fk_ficha_tecnica_montagem'].AsInteger);
    end;
  finally
    sl.Free;
  end;
end;

procedure TfmFichaTecnica.LoadComponentes;
var
  SavedSQL: String;
begin
  if ((Fpk_pecas < 1) or (Ffk_Ficha_Tecnica < 1)) then
    exit;
  Screen.Cursor := crHourGlass;
  stComponentes.BeginUpdate;
  SavedSQL := dmFichaTecnica.qrPecasComponentes.SQL.Text;
  try
    ClearComponentes;
    // Carregando o Root, caso especial em que fk_pecas=fk_pecas_montagem
    with dmFichaTecnica.qrPecasComponentes do
      try
        Sql.Add('And PCOMP.fk_pecas_montagem=' + IntToStr(Fpk_pecas));
        ParamByName('fk_pecas').AsInteger := Fpk_pecas;
        ParamByName('fk_ficha_tecnica').AsInteger := Ffk_Ficha_Tecnica;
        Open;
        if EOF then
          exit;
        AddAComponente(nil, TdbRow.CreateFromDs(dmFichaTecnica.qrPecasComponentes, True));
      finally
        Close;
        // Excluindo clausula para carga do root
        Sql.Delete(Sql.Count - 1);
        // Adicionando clausula para não permitir recuperação do Root
        //Sql.Add('And PCOMP.fk_pecas_montagem<>'+IntToStr(afkPeca));
        Sql.Add('And PCOMP.fk_pecas_montagem<>PCOMP.fk_pecas');
      end;
    // Recuperando SubPecas a partir do Root
    RetrieveSubComponentes(stComponentes.GetFirst, Fpk_pecas, Ffk_Ficha_Tecnica);
  finally
    dmFichaTecnica.qrPecasComponentes.SQL.Text := SavedSQL;
    stComponentes.EndUpdate;
    stComponentes.FullExpand;
    Screen.Cursor := crDefault;
    if stComponentes.RootNodeCount > 0 then
      miCopyFichaTo.Visible := True;
  end;
end;

function TfmFichaTecnica.TotalPecasParents(aNode : PVirtualNode; Qtd : Double): Double;
var
  aParentNode: PVirtualNode;
  Data: PTreeData;
begin
  if Qtd <= 0 then
    Qtd := 1;
  Result := Qtd;
  if ((aNode = nil) or (stComponentes.GetNodeLevel(aNode) < 1)) then
    exit;
  aParentNode := aNode.Parent;
  if aParentNode = nil then
    exit;
  Data := stComponentes.GetNodeData(aParentNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  Result := Result * (Data.RowData.dbRow['QTD_PEC'].AsInteger /
    Data.RowData.dbRow['QTD_GER'].AsInteger);
  Result := TotalPecasParents(aParentNode, Result);
end;

procedure TfmFichaTecnica.stComponentesGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data:   PTreeData;
  QtdDiv: Double;
begin
  if Node = nil then
    exit;
  Data := stComponentes.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  with Data.RowData do
    case Column of
      0: CellText := dbRow['COD_REF'].AsString + ' - ' + dbRow['DSC_PEC'].AsString;
      1:
      begin
        QtdDiv := (dbRow['QTD_PEC'].AsInteger / dbRow['QTD_GER'].AsInteger);
        QtdDiv := TotalPecasParents(Node, QtdDiv);
        if Frac(QtdDiv) <> 0 then
          CellText := FormatFloat('0.0000', QtdDiv)
        else
          CellText := FormatFloat('0', QtdDiv);
      end;
      2: CellText := '';
    end;
end;

procedure TfmFichaTecnica.popPopup(Sender : TObject);
var
  CurrNode:  PVirtualNode;
  CurrLevel: Integer;
  Data:      PTreeData;

  procedure MakeAllInvisible;
  var
    I: Integer;
  begin
    for I := 0 to pop.Items.Count - 1 do
      pop.Items[I].Visible := False;
  end;

begin
  CurrNode := stComponentes.FocusedNode;
  if CurrNode = nil then
  begin
    MakeAllInvisible;
    exit;
  end;
  CurrLevel := stComponentes.GetNodeLevel(CurrNode);
  Data      := stComponentes.GetNodeData(CurrNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
  begin
    MakeAllInvisible;
    exit;
  end;
  cmInsert.Visible     := ((CurrLevel = 0) and (Data.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
  cmDelete.Visible     := ((CurrLevel = 1) and (Data.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
  cmDelimiter1.Visible := cmDelete.Visible;
  cmDelimiter2.Visible := cmDelimiter1.Visible;
end;

procedure TfmFichaTecnica.cmDeleteClick(Sender : TObject);
var
  aNode, CurrNode: PVirtualNode;
  S:    String;
  Data: PTreeData;
  Ix:   Integer;
  CurrLevel: Cardinal;

  procedure DeleteNodeData(NodeToDelete : PVirtualNode);
  begin
    if NodeToDelete = nil then
      exit;
    Data := stComponentes.GetNodeData(NodeToDelete);
    if ((Data <> nil) and (Data.RowData <> nil)) then
    begin
      Ix := FslComponentes.IndexOf(Data.RowData);
      if Ix > -1 then
      begin
        if Data.RowData.Level < 2 then
          if not (ComponenteDeleted(Data.RowData.dbRow)) then
            raise Exception.Create(
              'Erro ocorrido durante a exclusão de SubComponente');
        FslComponentes.Delete(Ix);
        Data.RowData.Free;
        Data.RowData := nil;
      end;
    end;
  end;

begin
  CurrNode := stComponentes.FocusedNode;
  if ((CurrNode = nil) or (stComponentes.GetNodeLevel(CurrNode) < 1)) then
    exit;
  Data := stComponentes.GetNodeData(CurrNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  S := 'Por favor, confirme a exclusão do Componente "' + // sConfirmExlusionOf
    stComponentes.Text[CurrNode, 0] + '" !';
  if MessageBox(Self.Handle, PChar(S), PChar(Caption), MB_ICONQUESTION or MB_YESNO) <>
    idYes then
    exit;
  if dmFichaTecnica.tr.InTransaction then
    dmFichaTecnica.tr.Commit;
  dmFichaTecnica.tr.StartTransaction;
  try
    CurrLevel := stComponentes.GetNodeLevel(CurrNode);
    aNode     := stComponentes.GetFirstChild(CurrNode);
    while ((aNode <> nil) and (stComponentes.GetNodeLevel(aNode) > CurrLevel)) do
    begin
      DeleteNodeData(aNode);
      aNode := stComponentes.GetNext(aNode);
    end;
    aNode := stComponentes.GetPrevious(CurrNode);
    DeleteNodeData(CurrNode);
    stComponentes.DeleteNode(CurrNode);
    if aNode <> nil then
    begin
      stComponentes.FocusedNode     := aNode;
      stComponentes.Selected[aNode] := True;
    end;
    dmFichaTecnica.tr.Commit;
  except
    on E : Exception do
    begin
      dmFichaTecnica.tr.RollBack;
      MessageBox(Self.Handle, PChar(E.Message), PChar(Caption), MB_ICONSTOP);
    end;
  end;
end;

procedure TfmFichaTecnica.cmPropertiesClick(Sender : TObject);
var
  CurrNode: PVirtualNode;
  Data:     PTreeData;
begin
  FCurrentParentNode := nil;
  FCurrentNode := nil;
  CurrNode     := stComponentes.FocusedNode;
  if CurrNode = nil then
    exit;
  Data := stComponentes.GetNodeData(CurrNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  if Data.RowData.Level > 0 then
    FCurrentParentNode := CurrNode.Parent
  else
    FCurrentParentNode := CurrNode;
  FCurrentNode := CurrNode;
  with TfmEditPeca.Create(Self) do
    try
      UpdateAllowed := (Data.RowData.Level < 2);
      fkPeca :=
        Data.RowData.dbRow['fk_pecas'].AsInteger;
      fkFichaTecnica :=
        Data.RowData.dbRow['fk_Ficha_Tecnica'].AsInteger;
      fkFichaTecnicaMontagem :=
        Data.RowData.dbRow['fk_Ficha_Tecnica_Montagem'].AsInteger;
      fkPecaMontagem :=
        Data.RowData.dbRow['fk_pecas_montagem'].AsInteger;
      OnInsertComponente := HandleNewComponente;
      OnUpdateComponente := HandleUpdateComponente;
      AddParentsToList(slParents, CurrNode);
      ShowModal;
    finally
      Release;
      FCurrentParentNode := nil;
      FCurrentNode := nil;
    end;
end;

procedure TfmFichaTecnica.stComponentesEditing(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; var Allowed : Boolean);
begin
  Allowed := False;
end;

function TfmFichaTecnica.ComponenteDeleted(aRow : TdbRow): Boolean;
begin
  Result := False;
  if aRow = nil then
    exit;

  // Não permitir exclusão do Root
  if aRow['fk_pecas'].AsInteger = aRow['fk_pecas_montagem'].AsInteger then
    exit;

  with dmFichaTecnica.qrDelPecasCompoOper do
    try
      ParamByName('fk_pecas').AsInteger := aRow['fk_pecas'].AsInteger;
      ParamByName('fk_pecas_montagem').AsInteger :=
        aRow['fk_pecas_montagem'].AsInteger;
      ExecSql;
    finally
      Close;
    end;
  with dmFichaTecnica.qrDelPecasComponentes do
    try
      ParamByName('fk_pecas').AsInteger := aRow['fk_pecas'].AsInteger;
      ParamByName('fk_pecas_montagem').AsInteger :=
        aRow['fk_pecas_montagem'].AsInteger;
      ExecSql;
    finally
      Close;
    end;
 //    with dmFichaTecnica.qrDelPecas do
 //      try
//        ParamByName('pk_pecas').AsInteger            := dbRow['fk_pecas_montagem'].AsInteger;
 //        ExecSql;
 //      finally
 //        Close;
 //      end;
  Result := True;
end;

procedure TfmFichaTecnica.stComponentesResize(Sender : TObject);
begin
  stComponentes.Header.Columns[0].Width := stComponentes.Width -
    stComponentes.Header.Columns[1].Width -
    stComponentes.Header.Columns[2].Width -
    25;
end;

procedure TfmFichaTecnica.stComponentesGetImageIndex(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Kind : TVTImageKind; Column : TColumnIndex;
  var Ghosted : Boolean; var ImageIndex : Integer);
begin
  if ((Node = nil) or ( not (Kind in [ikNormal, ikSelected])) or (Column <> 0)) then
    exit;
  Ghosted := False;
  if stComponentes.GetNodeLevel(Node) = 0 then
    ImageIndex := Integer(Sender.Expanded[Node])
  else
  if Sender.HasChildren[Node] then
    ImageIndex := 2 + Integer(Sender.Expanded[Node])
  else
    ImageIndex := 4;
end;

procedure TfmFichaTecnica.cmdExpandPecaClick(Sender : TObject);
begin
  stComponentes.FullExpand;
end;

procedure TfmFichaTecnica.cmdCollapsePecaClick(Sender : TObject);
begin
  stComponentes.FullCollapse;
end;

procedure TfmFichaTecnica.cbSubGruposClick(Sender : TObject);
begin
  if cbSubGrupos.ItemIndex < 0 then
    exit;
  Ffk_SubGrupos := LongInt(cbSubGrupos.Items.Objects[cbSubGrupos.ItemIndex]);
end;

procedure TfmFichaTecnica.ClearImage;
begin
  imPeca.Picture := nil;
end;

procedure TfmFichaTecnica.LoadImage;
var
  M        : TMemoryStream;
  aNode    : PVirtualNode;
  Data     : PTreeData;
  TypeImage: TTypeImage;
  JpgImg   : TJpegImage;
begin
  ClearImage;
  aNode := stComponentes.FocusedNode;
  if aNode = nil then
    exit;
  Data := stComponentes.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  M := TMemoryStream.Create;
  try
    with dmFichaTecnica.qrPeca do
      try
        ParamByName('pk_pecas').AsInteger :=
          Data.RowData.dbRow['fk_pecas_montagem'].AsInteger;
        ParamByName('fk_ficha_tecnica').AsInteger :=
          Data.RowData.dbRow['fk_ficha_tecnica_montagem'].AsInteger;
        Open;
        if ((EOF) or (FieldByName('IMG_PEC').IsNull)) then
          exit;
        TBlobField(FieldByName('IMG_PEC')).SaveToStream(M);
      finally
        Close;
      end;
    if M.Size < 1 then
      exit;
    TypeImage  := GetTypeImage(M);
    M.Position := 0;
    case TypeImage of
      tiBmp: imPeca.Picture.BitMap.LoadFromStream(M);
      tiWmf: imPeca.Picture.MetaFile.LoadFromStream(M);
      tiJpg:
      begin
        JpgImg := TJpegImage.Create;
        try
          JpgImg.LoadFromStream(M);
          imPeca.Picture.Assign(JpgImg);
        finally
          JpgImg.Free;
        end;
      end;
    end;
  finally
    M.Free;
  end;
end;

procedure TfmFichaTecnica.mCloseClick(Sender : TObject);
begin
  Close;
end;

procedure TfmFichaTecnica.miCloseClick(Sender : TObject);
begin
  Close;
end;

procedure TfmFichaTecnica.sbCompanyClick(Sender : TObject);
begin
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    SelEmpresa.Free;
  end;
end;

procedure TfmFichaTecnica.miVisibleEntrpClick(Sender : TObject);
begin
  pCompany.Visible := not pCompany.Visible;
end;

procedure TfmFichaTecnica.miSendMailClick(Sender : TObject);
var
  eMail, NameForm, EM, PT, Lib: String;
begin
  inherited;
  NameForm := StrPas(ParamGlobal^.NameForm);
  PT    := StrPas(ParamGlobal^.ProgramTitle);
  EM    := StrPas(ParamGlobal^.ToMail);
  eMail := StrPas(ParamGlobal^.ToMail);
  ParamGlobal^.ToMail := PChar(eMail);
  ParamGlobal^.ProgramTitle := PChar(Dados.FindProgramTitle('SendMail'));
  ParamGlobal^.NameForm := PAnsiChar('fSendMail');
  Lib   := sDoth + sPathSep + 'SysGen' + sLibExt;
  OpenFormLibrary('fSendMail', Lib);
  ParamGlobal^.ProgramTitle := PAnsiChar(PT);
  ParamGlobal^.ToMail   := PAnsiChar(EM);
  ParamGlobal^.NameForm := PAnsiChar(NameForm);
end;

procedure TfmFichaTecnica.OpenFormLibrary(Form, LIB : String);
var
  hHandle: Integer;
begin
// Grava Histórico da abertura do relatório
  if FileExists(LIB) then
  begin
    hHandle := LoadLibrary(PAnsiChar(LIB));
    if hHandle <> 0 then
    begin
      @RodaPrograma := GetProcAddress(hHandle, FUNCPRG);
      try
        if @RodaPrograma <> nil then
          RodaPrograma(Application.Handle, ParamGlobal);
      finally
        FreeLibrary(hHandle);
      end;
    end
    else
      raise Exception.CreateFmt(Dados.GetStringMessage(LANGUAGE,
        'sNoLibRept', 'Biblioteca %s não encontrada'), [LIB]);
  end
  else
    raise Exception.CreateFmt(Dados.GetStringMessage(LANGUAGE,
      'sNoLibRept', 'Biblioteca %s não encontrada'), [LIB]);
end;

procedure TfmFichaTecnica.miAboutClick(Sender : TObject);
begin
  Application.CreateForm(TSobreProcessa, SobreProcessa);
  try
    SobreProcessa.ShowModal;
  finally
    SobreProcessa.Free;
  end;
end;

procedure TfmFichaTecnica.cbSecoesClick(Sender : TObject);
begin
  if cbSecoes.ItemIndex < 0 then
    exit;
  Ffk_Secoes := LongInt(cbSecoes.Items.Objects[cbSecoes.ItemIndex]);
  LoadGrupos;
  if cbGrupos.Items.Count < 1 then
    exit;
  cbGrupos.ItemIndex := 0;
  if Assigned(cbGrupos.OnClick) then
    cbGrupos.OnClick(Self);
end;

procedure TfmFichaTecnica.miOperationsClick(Sender : TObject);
var
  CurrNode: PVirtualNode;
  I: Integer;
begin
  CurrNode := stComponentes.FocusedNode;
  if CurrNode = nil then
  begin
    for I := FFirstDymMainMenuItem to miOperations.Count - 1 do
      miOperations.Items[I].Visible := False;
    exit;
  end;
  if FMaincmDelete <> nil then
    FMaincmDelete.Visible := (stComponentes.GetNodeLevel(CurrNode) > 0);
  if FMaincmDelimiter1 <> nil then
    FMaincmDelimiter1.Visible := ((FMaincmDelete <> nil) and (FMaincmDelete.Visible));
  if FMaincmDelimiter2 <> nil then
    FMaincmDelimiter2.Visible :=
      ((FMaincmDelimiter1 <> nil) and (FMaincmDelimiter1.Visible));
end;

procedure TfmFichaTecnica.CopyFichaTecnica(fkPecasFrom, fkFichaTecnicaFrom,
  fkPecasTo, MajVerTo, MinVerTo : Integer);
var
//  FasesCopied: Integer;
  PecasCopied: Integer;
begin
  PecasCopied := 0;
  if dmFichaTecnica.tr.InTransaction then
    dmFichaTecnica.tr.Commit;
  dmFichaTecnica.tr.StartTransaction;
  try
    with dmFichaTecnica.qrCopyFichaTecnica do
      try
        ParamByName('fkPecasFrom').AsInteger := fkPecasFrom;
        ParamByName('fkFichaTecnicaFrom').AsInteger := fkFichaTecnicaFrom;
        ParamByName('fkPecasTo').AsInteger   := fkPecasTo;
        ParamByName('MajVerTo').AsInteger    := MajVerTo;
        ParamByName('MinVerTo').AsInteger    := MinVerTo;
        Open;
        if not (EOF) then
        begin
          PecasCopied := FieldByName('r_total_componentes_incluidos').AsInteger;
//             FasesCopied := FieldByName('total_fases_incluidas').AsInteger;
        end;
      finally
        Close;
      end;
    dmFichaTecnica.tr.Commit;
    case PecasCopied of
         //-1:MessageBox(Self.Handle,'As Fichas Técnicas de Origem e Destino devem ser diferentes !',PChar(Caption),MB_ICONWARNING);
         //-2:MessageBox(Self.Handle,'A Peça de Destino já possui Ficha Técnica !',PChar(Caption),MB_ICONWARNING);
         //-3:MessageBox(Self.Handle,'Estrutura Inválida da Peça de Destino (pecas_componentes) !',PChar(Caption),MB_ICONWARNING);
         //-4:MessageBox(Self.Handle,'Estrutura Inválida da Peça de Origem (pecas_componentes) !',PChar(Caption),MB_ICONWARNING);
         //-5:MessageBox(Self.Handle,'A Peça de Destino já possui Ficha Técnica !',PChar(Caption),MB_ICONWARNING);
      -6: MessageBox(Self.Handle, 'A Ficha Técnica da Peca de Origem está Vazia !',
          PChar(Caption), MB_ICONWARNING);
      -7: MessageBox(Self.Handle, 'A Peça Destino não Existe !',
          PChar(Caption), MB_ICONWARNING);
      -8: MessageBox(Self.Handle, 'A Peça Destino já é Filha da Peça Origem !',
          PChar(Caption), MB_ICONWARNING);
      -9: MessageBox(Self.Handle, 'A Peça Destino Não possui nenhuma Ficha Técnica !',
          PChar(Caption), MB_ICONWARNING);
      -10: MessageBox(Self.Handle, 'A Peça Destino Não possui nenhuma Ficha Técnica !',
          PChar(Caption), MB_ICONWARNING);
      -11: MessageBox(Self.Handle, 'A Peça Destino Não possui nenhuma Ficha Técnica !',
          PChar(Caption), MB_ICONWARNING);
      -12: MessageBox(Self.Handle, 'A Peça Destino Não possui nenhuma Ficha Técnica !',
          PChar(Caption), MB_ICONWARNING);
      else
        MessageBox(Self.Handle, 'Ficha Técnica Copiada com Sucesso !', PChar(
          Caption), MB_ICONINFORMATION);
    end;
  except
    on Exception do
    begin
      dmFichaTecnica.tr.Rollback;
      raise;
    end;
  end;
end;

procedure TfmFichaTecnica.LocateFichaByReferencia;
var
  afkPecas, aMajVer, aMinVer: Integer;
begin
  with TfmCopyFicha.Create(Self) do
    try
      Referencia := FLastReferencia;
      fkPecas    := Self.Fpk_Pecas;
      fkFichaTecnicaOrigem := Self.Ffk_ficha_tecnica;
      if ShowModal <> mrOk then
        exit;
      FLastReferencia := Referencia;
      afkPecas := fkPecasDestino;
      aMajVer  := MajVerDestino;
      aMinVer  := MinVerDestino;
    finally
      Release;
    end;
  CopyFichaTecnica(Fpk_Pecas, Ffk_Ficha_Tecnica, afkPecas, aMajVer, aMinVer);
end;

procedure TfmFichaTecnica.miCopyFichaToClick(Sender : TObject);
begin
  if ((Fpk_Pecas < 1) or (Ffk_Ficha_Tecnica < 1)) then
    exit;
  LocateFichaByReferencia;
end;

procedure TfmFichaTecnica.cmInsertClick(Sender : TObject);
begin
  HandleNewClick(Sender);
end;

procedure TfmFichaTecnica.stFasesGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data: PTreeData;
begin
  if ((Sender = nil) or (Node = nil)) then
    exit;
  Data := Sender.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or (Column <> 0)) then
    exit;
  with Data.RowData do
    case Level of
      0: CellText := dbRow['DSC_FASE'].AsString;
      1: CellText := dbRow['DSC_OPE'].AsString;
    end;
end;

procedure TfmFichaTecnica.stFasesResize(Sender : TObject);
begin
  stFases.Header.Columns[0].Width := stFases.Width - 25;
end;

procedure TfmFichaTecnica.HandleNewComponente(Sender : TObject;
  afkPeca, afkFichaTecnica, afkPecaMontagem, afkFichaTecnicaMontagem : Integer;
  aDescPecaMontagem : String);
var
  aNode: PVirtualNode;
begin
  if ((Sender = nil) or (afkPeca < 1) or (afkPecaMontagem < 1) or (FCurrentParentNode = nil)) then
    exit;
  with dmFichaTecnica.qrPecaComponente do
    try
      ParamByName('fk_pecas').AsInteger := afkpeca;
      ParamByName('fk_ficha_tecnica').AsInteger := afkFichaTecnica;
      ParamByName('fk_pecas_montagem').AsInteger := afkpecamontagem;
      ParamByName('fk_ficha_tecnica_montagem').AsInteger := afkFichaTecnicaMontagem;
      Open;
      if EOF then
        exit;
      aNode := AddAComponente(FCurrentParentNode, TdbRow.CreateFromDs(
        dmFichaTecnica.qrPecaComponente, True));
    finally
      Close;
    end;
  if aNode <> nil then
  begin
    stComponentes.FocusedNode     := aNode;
    stComponentes.Selected[aNode] := True;
  end;
end;

procedure TfmFichaTecnica.HandleUpdateComponente(Sender : TObject;
  afkPeca, afkFichaTecnica, afkPecaMontagem, afkFichaTecnicaMontagem : Integer;
  aDescPecaMontagem : String);
var
  Data:     PTreeData;
  NewDBRow: TdbRow;
begin
  if ((Sender = nil) or (afkPeca < 1) or (afkPecaMontagem < 1) or (FCurrentNode = nil)) then
    exit;
  Data := stComponentes.GetNodeData(FCurrentNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  with dmFichaTecnica.qrPecaComponente do
    try
      ParamByName('fk_pecas').AsInteger := afkpeca;
      ParamByName('fk_ficha_tecnica').AsInteger := afkFichaTecnica;
      ParamByName('fk_pecas_montagem').AsInteger := afkpecamontagem;
      ParamByName('fk_ficha_tecnica_montagem').AsInteger := afkFichaTecnicaMontagem;
      Open;
      if EOF then
        exit;
      NewDbRow := TdbRow.CreateFromDs(dmFichaTecnica.qrPecaComponente, True);
    finally
      Close;
    end;
  Data.RowData.dbRow.Free;
  Data.RowData.dbRow := NewDbRow;
  stComponentes.InvalidateNode(FCurrentNode);
end;

procedure TfmFichaTecnica.EnableComponentCommands(Node : PVirtualNode);
var
  CurrLevel: Integer;
  Data:      PTreeData;

  procedure DisableAll;
  begin
    cmdAddComponente.Enabled        := False;
    cmdDeleteComponente.Enabled     := False;
    cmdPropertiesComponente.Enabled := False;
    miAddComponent.Enabled          := False;
    miDeleteComponent.Enabled       := False;
    miPropertiesComponent.Enabled   := False;
  end;

begin
  if ((Node = nil) or (pgFicha.ActivePage <> tbFicha)) then
  begin
    DisableAll;
    exit;
  end;
  CurrLevel := stComponentes.GetNodeLevel(Node);
  Data      := stComponentes.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
  begin
    DisableAll;
    exit;
  end;
  cmdAddComponente.Enabled        :=
    ((CurrLevel = 0) and (Data.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
  cmdDeleteComponente.Enabled     :=
    ((CurrLevel = 1) and (Data.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
  cmdPropertiesComponente.Enabled := True;
  miAddComponent.Enabled          := cmdAddComponente.Enabled;
  miDeleteComponent.Enabled       := cmdDeleteComponente.Enabled;
  miPropertiesComponent.Enabled   := True;
end;

procedure TfmFichaTecnica.stComponentesChange(Sender : TBaseVirtualTree;
  Node : PVirtualNode);
begin
  EnableComponentCommands(Node);
  if Node = nil then
    exit;
  LoadFases;
  LoadImage;
end;

procedure TfmFichaTecnica.AddParentsToList(sl : TList; aNode : PVirtualNode);
var
  Data: PTreeData;
begin
  if ((sl = nil) or (aNode = nil) or (stComponentes.GetNodeLevel(aNode) < 1)) then
    exit;
  sl.Clear;
  aNode := aNode.Parent;
  while aNode <> nil do
  begin
    Data := stComponentes.GetNodeData(aNode);
    if ((Data <> nil) and (Data.RowData <> nil) and (Data.RowData.dbRow <> nil)) then
      sl.Add(TObject(Data.RowData.dbRow['fk_pecas'].AsInteger));
    if stComponentes.GetNodeLevel(aNode) < 1 then
      exit;
    aNode := aNode.Parent;
  end;
end;

procedure TfmFichaTecnica.popOperacoesPopup(Sender : TObject);
var
  ComponenteNode, CurrNode: PVirtualNode;
  I, CurrLevelPeca: Integer;
//  CurrLevelOperacao : Integer;
  DataOperacao, DataComponente: PTreeData;
begin
  ComponenteNode := stComponentes.FocusedNode;
  if ComponenteNode <> nil then
    DataComponente := stComponentes.GetNodeData(ComponenteNode)
  else
    DataComponente := nil;
  if ((ComponenteNode = nil) or (DataComponente = nil) or (DataComponente.RowData = nil) or
    (DataComponente.RowData.dbRow = nil)) then
  begin
    for I := 0 to popOperacoes.Items.Count - 1 do
      popOperacoes.Items[I].Visible := False;
    exit;
  end;
  CurrNode := stFases.FocusedNode;
  if CurrNode <> nil then
    DataOperacao := stFases.GetNodeData(CurrNode)
  else
    DataOperacao := nil;
  CurrLevelPeca := stComponentes.GetNodeLevel(ComponenteNode);
//  CurrLevelOperacao             :=stFases.GetNodeLevel(CurrNode);
  cmNovaFase.Visible     :=
    ((CurrLevelPeca = 0) and (DataComponente.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
  cmNovaOperacao.Visible :=
    ((CurrLevelPeca = 0) and (CurrNode <> nil) and
    (DataComponente.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
  cmPropriedadesOperacao.Visible :=
    ((CurrNode <> nil) and (DataOperacao <> nil) and (DataOperacao.RowData <> nil) and
    (DataOperacao.RowData.dbRow <> nil));
  cmDeleteOperacao.Visible :=
    ((CurrLevelPeca = 0) and (cmPropriedadesOperacao.Visible) and
    (DataComponente.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
end;

procedure TfmFichaTecnica.PropriedadesFase;
var
  PecaNode, CurrNode:   PVirtualNode;
  DataComponente, Data: PTreeData;
begin
  PecaNode := stComponentes.FocusedNode;
  if PecaNode = nil then
    exit;
  DataComponente := stComponentes.GetNodeData(PecaNode);
  if ((DataComponente = nil) or (DataComponente.RowData = nil) or
    (DataComponente.RowData.dbRow = nil)) then
    exit;
  FCurrentOperacaoNode := nil;
  FCurrentOperacaoParentNode := nil;
  CurrNode := stFases.FocusedNode;
  if ((CurrNode = nil) or (stFases.GetNodeLevel(CurrNode) <> 0)) then
    exit;
  Data := stFases.GetNodeData(CurrNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  FCurrentOperacaoNode := CurrNode;
  with TfmEditFaseProducao.Create(Self) do
    try
      fkPecas :=
        Data.RowData.dbRow['fk_pecas'].AsInteger;
      fkFichaTecnica :=
        Data.RowData.dbRow['fk_ficha_tecnica'].AsInteger;
      fkFaseProducao :=
        Data.RowData.dbRow['pk_fases_producao'].AsInteger;
      OnInsertFaseProducao := HandleNewFaseProducao;
      OnUpdateFaseProducao := HandleUpdateFaseProducao;
      UpdateAllowed :=
        ((Self.stComponentes.GetNodeLevel(PecaNode) = 0) and
        (DataComponente.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
      ShowModal;
    finally
      Release;
      FCurrentOperacaoNode := nil;
      FCurrentOperacaoParentNode := nil;
    end;
end;

procedure TfmFichaTecnica.PropriedadesOperacao;
var
  PecaNode, CurrNode:   PVirtualNode;
  DataComponente, Data: PTreeData;
begin
  PecaNode := stComponentes.FocusedNode;
  if PecaNode = nil then
    exit;
  DataComponente := stComponentes.GetNodeData(PecaNode);
  if ((DataComponente = nil) or (DataComponente.RowData = nil) or
    (DataComponente.RowData.dbRow = nil)) then
    exit;
  FCurrentOperacaoNode := nil;
  FCurrentOperacaoParentNode := nil;
  CurrNode := stFases.FocusedNode;
  if ((CurrNode = nil) or (stFases.GetNodeLevel(CurrNode) <> 1)) then
    exit;
  Data := stFases.GetNodeData(CurrNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  FCurrentOperacaoNode := CurrNode;
  FCurrentOperacaoParentNode := FCurrentOperacaoNode.Parent;
  with TfmEditOperacao.Create(Self) do
    try
      fkPeca     :=
        Data.RowData.dbRow['fk_pecas'].AsInteger;
      fkFichaTecnica :=
        Data.RowData.dbRow['fk_ficha_tecnica'].AsInteger;
      fkFaseProducao :=
        Data.RowData.dbRow['fk_fases_producao'].AsInteger;
      fkOperacao :=
        Data.RowData.dbRow['pk_operacoes'].AsInteger;
      OnInsertOperacao := HandleNewOperacao;
      OnUpdateOperacao := HandleUpdateOperacao;
      UpdateAllowed :=
        ((Self.stComponentes.GetNodeLevel(PecaNode) = 0) and
        (DataComponente.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
      ;
      ShowModal;
    finally
      Release;
      FCurrentOperacaoNode := nil;
      FCurrentOperacaoParentNode := nil;
    end;
end;

procedure TfmFichaTecnica.cmPropriedadesOperacaoClick(Sender : TObject);
var
  aNode: PVirtualNode;
begin
  aNode := stFases.FocusedNode;
  if aNode = nil then
    exit;
  if stFases.GetNodeLevel(aNode) < 1 then
    PropriedadesFase
  else
    PropriedadesOperacao;
end;

procedure TfmFichaTecnica.HandleNewOperacao(Sender : TObject;
  afkPeca, afkFichaTecnica, afkFaseProducao, afkOperacao : Integer);
var
  PecaNode, aNode: PVirtualNode;
  Fase:    TdbRow;
  Data:    PTreeData;
  RowData: TRowData;
begin
  PecaNode := stComponentes.FocusedNode;
  if ((PecaNode = nil) or (stComponentes.GetNodeLevel(PecaNode) <> 0)) then
    exit;
  if ((Sender = nil) or (afkPeca < 1) or (afkFichaTecnica < 1) or (afkFaseProducao < 1) or
    (afkOperacao < 1) or (FCurrentOperacaoParentNode = nil)) then
    exit;
  with dmFichaTecnica.qrOperacao do
    try
      ParamByName('fk_pecas').AsInteger     := afkPeca;
      ParamByName('fk_ficha_tecnica').AsInteger := afkFichaTecnica;
      ParamByName('pk_operacoes').AsInteger := afkOperacao;
      ParamByName('pk_fases_producao').AsInteger := afkFaseProducao;
      Open;
      if EOF then
        exit;
      Fase    := TdbRow.CreateFromDs(dmFichaTecnica.qrOperacao, True);
      RowData := TRowData.Create;
      RowData.Level := 1;
      RowData.dbRow := Fase;
      aNode   := stFases.AddChild(FCurrentOperacaoParentNode);
      Data    := stFases.GetNodeData(aNode);
      Data.RowData := RowData;
      RowData.Node := aNode;
      FslFases.Add(RowData);
    finally
      Close;
    end;
  if aNode <> nil then
  begin
    stFases.FocusedNode     := aNode;
    stFases.Selected[aNode] := True;
  end;
end;

procedure TfmFichaTecnica.HandleUpdateOperacao(Sender : TObject;
  afkPeca, afkFichaTecnica, afkFaseProducao, afkOperacao : Integer);
var
  Data: PTreeData;
  NewDBRow: TdbRow;
  Ix: Integer;
begin
  if ((Sender = nil) or (afkPeca < 1) or (afkFichaTecnica < 1) or (afkFaseProducao < 1) or
    (afkOperacao < 1) or (FCurrentOperacaoNode = nil) or (FCurrentOperacaoParentNode = nil)) then
    exit;
  Data := stFases.GetNodeData(FCurrentOperacaoNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  Ix := FslFases.IndexOf(Data.RowData);
  if Ix < 0 then
    exit;
  with dmFichaTecnica.qrOperacao do
    try
      ParamByName('fk_pecas').AsInteger     := afkPeca;
      ParamByName('fk_ficha_tecnica').AsInteger := afkFichaTecnica;
      ParamByName('pk_operacoes').AsInteger := afkOperacao;
      ParamByName('pk_fases_producao').AsInteger := afkFaseProducao;
      Open;
      if EOF then
        exit;
      NewDbRow := TdbRow.CreateFromDs(dmFichaTecnica.qrOperacao, True);
    finally
      Close;
    end;
  Data.RowData.dbRow.Free;
  Data.RowData.dbRow := NewDbRow;
  stFases.InvalidateNode(FCurrentOperacaoNode);
end;

procedure TfmFichaTecnica.cmNovaOperacaoClick(Sender : TObject);
var
  ParentOperacaoNode, PecaNode: PVirtualNode;
  DataOperacao, Data: PTreeData;
  afkPeca, afkFichaTecnica, afkFaseProducao: Integer;
begin
  FCurrentOperacaoParentNode := nil;
  FCurrentOperacaoNode := nil;
  PecaNode := stComponentes.FocusedNode;
  if PecaNode = nil then
    exit;
  Data := stComponentes.GetNodeData(PecaNode);
  ParentOperacaoNode := stFases.FocusedNode;
  while ((ParentOperacaoNode <> nil) and (stFases.GetNodeLevel(ParentOperacaoNode) > 0)) do
    ParentOperacaoNode := ParentOperacaoNode.Parent;
  if ParentOperacaoNode = nil then
    exit;
  DataOperacao := stFases.GetNodeData(ParentOperacaoNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
    (stComponentes.GetNodeLevel(PecaNode) <> 0) or (ParentOperacaoNode = nil) or
    (DataOperacao = nil) or (DataOperacao.RowData = nil) or
    (DataOperacao.RowData.dbRow = nil)) then
    exit;
  FCurrentOperacaoParentNode := ParentOperacaoNode;
  FCurrentOperacaoNode := stFases.FocusedNode;
  afkPeca := Data.RowData.dbRow['fk_pecas'].AsInteger;
  afkFichaTecnica := Data.RowData.dbRow['fk_ficha_tecnica'].AsInteger;
  afkFaseProducao :=
    DataOperacao.RowData.dbRow['pk_fases_producao'].AsInteger;
  with TfmEditOperacao.Create(Self) do
    try
      fkPeca := afkPeca;
      fkFichaTecnica := afkFichaTecnica;
      fkFaseProducao := afkFaseProducao;
      OnInsertOperacao := HandleNewOperacao;
      OnUpdateOperacao := HandleUpdateOperacao;
      UpdateAllowed := True;
      ShowModal;
    finally
      Release;
      FCurrentOperacaoNode := nil;
      FCurrentOperacaoParentNode := nil;
    end;
end;

procedure TfmFichaTecnica.ExcluirFase;
var
  PecaNode, FaseNode, OperacaoNode: PVirtualNode;
  PecaData, OperacaoData: PTreeData;
  fkPeca, fkFichaTecnica, fkFaseProducao, CurrLevel: Cardinal;
  Ix: Integer;
  S:  String;

  procedure DeleteNodeData(NodeToDelete : PVirtualNode);
  var
    Data: PTreeData;
  begin
    if NodeToDelete = nil then
      exit;
    Data := stFases.GetNodeData(NodeToDelete);
    if ((Data <> nil) and (Data.RowData <> nil)) then
    begin
      Ix := FslFases.IndexOf(Data.RowData);
      if Ix > -1 then
      begin
        FslFases.Delete(Ix);
        Data.RowData.Free;
        Data.RowData := nil;
      end;
    end;
  end;

begin
  PecaNode := stComponentes.FocusedNode;
  FaseNode := stFases.FocusedNode;
  if ((PecaNode = nil) or (FaseNode = nil) or (stFases.GetNodeLevel(FaseNode) <> 0) or
    (stComponentes.GetNodeLevel(PecaNode) <> 0)) then
    exit;
  PecaData     := stComponentes.GetNodeData(PecaNode);
  OperacaoData := stFases.GetNodeData(FaseNode);
  if ((PecaData = nil) or (PecaData.RowData = nil) or (PecaData.RowData.dbRow = nil) or
    (OperacaoData = nil) or (OperacaoData.RowData = nil) or
    (OperacaoData.RowData.dbRow = nil)) then
    exit;
  Ix := FslFases.IndexOf(OperacaoData.RowData);
  if Ix < 0 then
    exit;
  S := 'Por favor confirme a exclusão da Fase de Produção !';
  if MessageBox(Self.Handle, PChar(S), PChar(Caption), MB_ICONSTOP or MB_YESNO) <> idYes then
    exit;
  fkPeca := OperacaoData.RowData.dbRow['fk_pecas'].AsInteger;
  fkFaseProducao := OperacaoData.RowData.dbRow['pk_fases_producao'].AsInteger;
  fkFichaTecnica := OperacaoData.RowData.dbRow['fk_ficha_tecnica'].AsInteger;
  if dmFichaTecnica.tr.InTransaction then
    dmFichaTecnica.tr.Commit;
  dmFichaTecnica.tr.StartTransaction;
  try
    with dmFichaTecnica.qrDeleteComponentesFaseProducao do
      try
        ParamByName('fk_pecas').AsInteger := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteOperacoesDetalhesFaseProducao do
      try
        ParamByName('fk_pecas').AsInteger := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteFerramentasOperacaoFaseProducao do
      try
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_pecas').AsInteger := fkPeca;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteMaquinasOperacaoFaseProducao do
      try
        ParamByName('fk_pecas').AsInteger := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteOperacoesFaseProducao do
      try
        ParamByName('fk_pecas').AsInteger := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteFaseProducao do
      try
        ParamByName('fk_pecas').AsInteger := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('pk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;

    CurrLevel    := stFases.GetNodeLevel(FaseNode);
    OperacaoNode := stFases.GetFirstChild(FaseNode);
    while ((OperacaoNode <> nil) and (stFases.GetNodeLevel(OperacaoNode) > CurrLevel)) do
    begin
      DeleteNodeData(OperacaoNode);
      OperacaoNode := stFases.GetNext(OperacaoNode);
    end;
    OperacaoNode := stFases.GetPrevious(FaseNode);
    DeleteNodeData(FaseNode);
    stFases.DeleteNode(FaseNode);
    if OperacaoNode <> nil then
    begin
      stFases.FocusedNode := OperacaoNode;
      stFases.Selected[OperacaoNode] := True;
    end;
    dmFichaTecnica.tr.Commit;
  except
    On Exception do
    begin
      dmFichaTecnica.tr.Rollback;
      raise;
    end;
  end;
end;

procedure TfmFichaTecnica.ExcluirOperacao;
var
  PecaNode, OperacaoNode: PVirtualNode;
  PecaData, OperacaoData: PTreeData;
  fkPeca, fkFichaTecnica, fkFaseProducao, fkOperacao,
  Ix: Integer;
  S:  String;
begin
  PecaNode     := stComponentes.FocusedNode;
  OperacaoNode := stFases.FocusedNode;
  if ((PecaNode = nil) or (OperacaoNode = nil) or (stFases.GetNodeLevel(OperacaoNode) <> 1) or
    (stComponentes.GetNodeLevel(PecaNode) <> 0)) then
    exit;
  PecaData     := stComponentes.GetNodeData(PecaNode);
  OperacaoData := stFases.GetNodeData(OperacaoNode);
  if ((PecaData = nil) or (PecaData.RowData = nil) or (PecaData.RowData.dbRow = nil) or
    (OperacaoData = nil) or (OperacaoData.RowData = nil) or
    (OperacaoData.RowData.dbRow = nil)) then
    exit;
  Ix := FslFases.IndexOf(OperacaoData.RowData);
  if Ix < 0 then
    exit;
  S := 'Por favor confirme a exclusão da operação !';
  if MessageBox(Self.Handle, PChar(S), PChar(Caption), MB_ICONSTOP or MB_YESNO) <> idYes then
    exit;
  fkPeca     := OperacaoData.RowData.dbRow['fk_pecas'].AsInteger;
  fkFichaTecnica := OperacaoData.RowData.dbRow['fk_ficha_tecnica'].AsInteger;
  fkFaseProducao := OperacaoData.RowData.dbRow['pk_fases_producao'].AsInteger;
  fkOperacao := OperacaoData.RowData.dbRow['pk_operacoes'].AsInteger;
  if dmFichaTecnica.tr.InTransaction then
    dmFichaTecnica.tr.Commit;
  dmFichaTecnica.tr.StartTransaction;
  try
    with dmFichaTecnica.qrDeleteComponentesOperacao do
      try
        ParamByName('fk_operacoes').AsInteger := fkOperacao;
        ParamByName('fk_pecas').AsInteger     := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteOperacoesDetalhes do
      try
        ParamByName('fk_operacoes').AsInteger := fkOperacao;
        ParamByName('fk_pecas').AsInteger     := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteFerramentasOperacao do
      try
        ParamByName('fk_operacoes').AsInteger := fkOperacao;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_pecas').AsInteger := fkPeca;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteMaquinasOperacao do
      try
        ParamByName('fk_operacoes').AsInteger := fkOperacao;
        ParamByName('fk_pecas').AsInteger     := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    with dmFichaTecnica.qrDeleteOperacao do
      try
        ParamByName('pk_operacoes').AsInteger := fkOperacao;
        ParamByName('fk_pecas').AsInteger     := fkPeca;
        ParamByName('fk_ficha_tecnica').AsInteger := fkFichaTecnica;
        ParamByName('fk_fases_producao').AsInteger := fkFaseProducao;
        ExecSql;
      finally
        Close;
      end;
    dmFichaTecnica.tr.Commit;
    FslFases.Delete(Ix);
    OperacaoData.RowData.Free;
    OperacaoData.RowData := nil;
    stFases.DeleteNode(OperacaoNode);
  except
    On Exception do
    begin
      dmFichaTecnica.tr.Rollback;
      raise;
    end;
  end;
end;

procedure TfmFichaTecnica.cmDeleteOperacaoClick(Sender : TObject);
var
  aNode: PVirtualNode;
begin
  aNode := stFases.FocusedNode;
  if aNode = nil then
    exit;
  if stFases.GetNodeLevel(aNode) < 1 then
    ExcluirFase
  else
    ExcluirOperacao;
end;

procedure TfmFichaTecnica.cmNovaFaseClick(Sender : TObject);
var
  PecaNode: PVirtualNode;
  Data:     PTreeData;
  afkFichaTecnica, afkPeca: Integer;
begin
  FCurrentOperacaoNode := nil;
  FCurrentOperacaoParentNode := nil;
  PecaNode := stComponentes.FocusedNode;
  if PecaNode = nil then
    exit;
  Data := stComponentes.GetNodeData(PecaNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  FCurrentOperacaoNode := stFases.FocusedNode;
  if ((FCurrentOperacaoNode <> nil) and (stFases.GetNodeLevel(FCurrentOperacaoNode) > 0)) then
    FCurrentOperacaoParentNode := FCurrentOperacaoNode.Parent;
  afkPeca := Data.RowData.dbRow['fk_pecas'].AsInteger;
  afkFichaTecnica := Data.RowData.dbRow['fk_ficha_tecnica'].AsInteger;
  with TfmEditFaseProducao.Create(Self) do
    try
      fkPecas := afkPeca;
      fkFichaTecnica := afkFichaTecnica;
      OnInsertFaseProducao := HandleNewFaseProducao;
      OnUpdateFaseProducao := HandleUpdateFaseProducao;
      UpdateAllowed := True;
      ShowModal;
    finally
      Release;
      FCurrentOperacaoNode := nil;
      FCurrentOperacaoParentNode := nil;
    end;
end;

procedure TfmFichaTecnica.HandleNewFaseProducao(Sender : TObject;
  afkPecas, afkFichaTecnica, afkFaseProducao : Integer);
var
  PecaNode, aNode: PVirtualNode;
  Fase:    TdbRow;
  Data:    PTreeData;
  RowData: TRowData;
begin
  PecaNode := stComponentes.FocusedNode;
  if ((PecaNode = nil) or (stComponentes.GetNodeLevel(PecaNode) <> 0)) then
    exit;
  if ((Sender = nil) or (afkPecas < 1) or (afkFaseProducao < 1) or (afkFichaTecnica < 1)) then
    exit;
  with dmFichaTecnica.qrOperacao do
    try
      ParamByName('fk_pecas').AsInteger     := afkPecas;
      ParamByName('fk_ficha_tecnica').AsInteger := afkFichaTecnica;
      ParamByName('pk_operacoes').AsInteger := 0;
      ParamByName('pk_fases_producao').AsInteger := afkFaseProducao;
      Open;
      if EOF then
        exit;
      Fase    := TdbRow.CreateFromDs(dmFichaTecnica.qrOperacao, True);
      RowData := TRowData.Create;
      RowData.Level := 0;
      RowData.dbRow := Fase;
      aNode   := stFases.AddChild(nil);
      Data    := stFases.GetNodeData(aNode);
      Data.RowData := RowData;
      RowData.Node := aNode;
      FslFases.Add(RowData);
    finally
      Close;
    end;
  if aNode <> nil then
  begin
    stFases.FocusedNode     := aNode;
    stFases.Selected[aNode] := True;
  end;
end;

procedure TfmFichaTecnica.HandleUpdateFaseProducao(Sender : TObject;
  afkPecas, afkFichaTecnica, afkFaseProducao : Integer);
var
  Data: PTreeData;
  NewDBRow: TdbRow;
  Ix: Integer;
begin
  if ((Sender = nil) or (afkPecas < 1) or (afkFichaTecnica < 1) or (afkFaseProducao < 1) or
    (FCurrentOperacaoNode = nil)) then
    exit;
  Data := stFases.GetNodeData(FCurrentOperacaoNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  Ix := FslFases.IndexOf(Data.RowData);
  if Ix < 0 then
    exit;
  with dmFichaTecnica.qrOperacao do
    try
      ParamByName('fk_pecas').AsInteger     := afkPecas;
      ParamByName('fk_ficha_tecnica').AsInteger := afkFichaTecnica;
      ParamByName('pk_operacoes').AsInteger := 0;
      ParamByName('pk_fases_producao').AsInteger := afkFaseProducao;
      Open;
      if EOF then
        exit;
      NewDbRow := TdbRow.CreateFromDs(dmFichaTecnica.qrOperacao, True);
    finally
      Close;
    end;
  Data.RowData.dbRow.Free;
  Data.RowData.dbRow := NewDbRow;
  stFases.InvalidateNode(FCurrentOperacaoNode);
end;

procedure TfmFichaTecnica.stFasesDblClick(Sender : TObject);
begin
  if ((stFases.FocusedNode <> nil) and (cmPropriedadesOperacao.Visible) and
    (cmPropriedadesOperacao.Enabled) and (Assigned(cmPropriedadesOperacao.OnClick))) then
    cmPropriedadesOperacao.OnClick(Self);
end;

procedure TfmFichaTecnica.stPecasResize(Sender : TObject);
begin
  stPecas.Header.Columns[0].Width := stPecas.Width - stPecas.Header.Columns[1].Width - 25;
end;

procedure TfmFichaTecnica.optSubGrupoClick(Sender : TObject);
begin
  gbSubGrupo.Enabled   := optSubGrupo.Checked;
  gbReferencia.Enabled := optReferencia.Checked;
  gbDescricao.Enabled  := optDescricao.Checked;
end;

procedure TfmFichaTecnica.stPecasColumnDefs1GetPickItems(Sender : TColumnDef;
  slItems : TStrings);
var
  aNode: PVirtualNode;
  Data:  PTreeData;
begin
  if ((Sender = nil) or (stPecas.RootNodeCount < 1) or (slItems = nil)) then
    exit;
  aNode := stPecas.FocusedNode;
  if aNode = nil then
    exit;
  Data := stPecas.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  TStringList(slItems).CommaText := Data.RowData.dbRow['Versoes'].AsString;
end;

procedure TfmFichaTecnica.stPecasGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data: PTreeData;
begin
  if ((Sender <> stPecas) or (Node = nil)) then
    exit;
  Data := stPecas.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  with Data.RowData do
    case Column of
      0: CellText := dbRow['COD_REF'].AsString + ' - ' + DbRow['DSC_PEC'].AsString;
      1: CellText := dbRow['CurrVersao'].AsString;
    end;
end;

procedure TfmFichaTecnica.stPecasNewText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; NewText : WideString);
var
  Data: PTreeData;
begin
  if ((Sender <> stPecas) or (Node = nil) or (Column <> 1)) then
    exit;
  Data := stPecas.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  with Data.RowData do
    case Column of
      1: dbRow['CurrVersao'].AsString := NewText;
    end;
end;

procedure TfmFichaTecnica.cmdSearchSubGrupoClick(Sender : TObject);
begin
  if cbSecoes.ItemIndex < 0 then
  begin
    if pgFicha.ActivePage <> tbFicha then
      pgFicha.ActivePage := tbFicha;
    if cbSecoes.CanFocus then
      cbSecoes.SetFocus;
    MessageBox(Self.Handle, 'Ao menos a seção deve ser selecionada !',
      PChar(Caption), MB_ICONSTOP);
    exit;
  end;
  LoadPecas;
end;

procedure TfmFichaTecnica.cmdSearchReferenciaClick(Sender : TObject);
begin
  edReferencia.Text := Trim(edReferencia.Text);
  if edReferencia.Text = '' then
  begin
    if pgFicha.ActivePage <> tbFicha then
      pgFicha.ActivePage := tbFicha;
    if edReferencia.CanFocus then
      edReferencia.SetFocus;
    MessageBox(Self.Handle, 'A Referência deve ser preenchida !',
      PChar(Caption), MB_ICONSTOP);
    exit;
  end;
  LoadPecas;
end;

procedure TfmFichaTecnica.cmdSearchDescricaoClick(Sender : TObject);
begin
  edDescricao.Text := Trim(edDescricao.Text);
  edDescricao.Text := StringReplace(edDescricao.Text, '*', '%', [rfReplaceAll]);
  if StringReplace(edDescricao.Text, '%', '', [rfReplaceAll]) = '' then
  begin
    if pgFicha.ActivePage <> tbFicha then
      pgFicha.ActivePage := tbFicha;
    if edDescricao.CanFocus then
      edDescricao.SetFocus;
    MessageBox(Self.Handle, 'A Descrição deve ser preenchida !',
      PChar(Caption), MB_ICONSTOP);
    exit;
  end;
  LoadPecas;
end;

procedure TfmFichaTecnica.stPecasEditing(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; var Allowed : Boolean);
begin
  Allowed := ((Node <> nil) and (Column = 1));
end;

procedure TfmFichaTecnica.cbSecoesKeyDown(Sender : TObject; var Key : Word;
  Shift : TShiftState);
begin
  if Key = vk_Return then
    if Assigned(cmdSearchSubGrupo.OnClick) then
      cmdSearchSubGrupo.OnClick(Self);
end;

procedure TfmFichaTecnica.edReferenciaKeyDown(Sender : TObject;
  var Key : Word; Shift : TShiftState);
begin
  if Key = vk_Return then
    if Assigned(cmdSearchReferencia.OnClick) then
      cmdSearchReferencia.OnClick(Self);
end;

procedure TfmFichaTecnica.edDescricaoKeyDown(Sender : TObject;
  var Key : Word; Shift : TShiftState);
begin
  if Key = vk_Return then
    if Assigned(cmdSearchDescricao.OnClick) then
      cmdSearchDescricao.OnClick(Self);
end;

procedure TfmFichaTecnica.stPecasDblClick(Sender : TObject);
begin
  if Assigned(cmdShowFicha.OnClick) then
    cmdShowFicha.OnClick(Self);
end;

procedure TfmFichaTecnica.GetFichaTecnicaSelectedPeca(var afkPecas : Integer;
  var afkFichaTecnica : Integer; var aDescricaoPeca : String);
var
  aNode: PVirtualNode;
  P, MajVer, MinVer: Integer;
  CurrVersao: String;
  Data: PTreeData;
begin
  afkPecas := -1;
  afkFichaTecnica := -1;
  aDescricaoPeca := '';
  aNode    := stPecas.FocusedNode;
  if aNode = nil then
    exit;
  Data := stPecas.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  CurrVersao := Data.RowData.dbRow['CurrVersao'].AsString;
  P := Pos('.', CurrVersao);
  if P < 1 then
    exit;
  MajVer := StrToIntDef(Copy(CurrVersao, 1, P - 1), 0);
  MinVer := StrToIntDef(Copy(CurrVersao, P + 1, 255), 0);
  with dmFichaTecnica.qrChaveFichaTecnica do
    try
      ParamByName('fk_pecas').AsInteger := Data.RowData.dbRow['fk_pecas'].AsInteger;
      ParamByName('maj_ver').AsInteger  := MajVer;
      ParamByName('min_ver').AsInteger  := MinVer;
      Open;
      if EOF then
        exit;
      afkFichaTecnica := FieldByName('pk_ficha_tecnica').AsInteger;
    finally
      Close;
    end;
  afkPecas := Data.RowData.dbRow['fk_pecas'].AsInteger;
  aDescricaoPeca := Data.RowData.dbRow['COD_REF'].AsString + ' - ' +
    Data.RowData.dbRow['DSC_PEC'].AsString;
end;

procedure TfmFichaTecnica.cmdShowFichaClick(Sender : TObject);
var
  afkPecas, afkFichaTecnica: Integer;
  aDescricao: String;
begin
  GetFichaTecnicaSelectedPeca(afkPecas, afkFichaTecnica, aDescricao);
  if ((afkPecas < 1) or (afkFichaTecnica < 1)) then
    exit;
  Fpk_pecas := afkPecas;
  Ffk_Ficha_Tecnica := afkFichaTecnica;
  pgFicha.ActivePage := tbFicha;
  LoadComponentes;
end;

procedure TfmFichaTecnica.stPecasPaintText(Sender : TBaseVirtualTree;
  const TargetCanvas : TCanvas; Node : PVirtualNode; Column : TColumnIndex;
  TextType : TVSTTextType);
var
  Data: PTreeData;
begin
  if Node = nil then
    exit;
  Data := stPecas.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  if Data.RowData.dbRow['TotalComponentes'].AsInteger > 0 then
    if ((Node = Sender.FocusedNode) and (Column = Sender.FocusedColumn)) then
      TargetCanvas.Font.Color := clWhite
    else
      TargetCanvas.Font.Color := clBlue
  else
    TargetCanvas.Font.Color := clBlack;
end;

procedure TfmFichaTecnica.stPecasCompareNodes(Sender : TBaseVirtualTree;
  Node1, Node2 : PVirtualNode; Column : TColumnIndex; var Result : Integer);
var
  Data1, Data2: PTreeData;
  S1, S2: String;
begin
  Result := -1;
  if ((Node1 = nil) or (Node2 = nil) or ( not (Sender is TCSDVirtualStringTree))) then
    exit;
  Data1 := Sender.GetNodeData(Node1);
  if ((Data1 = nil) or (Data1.RowData = nil) or (Data1.RowData.dbRow = nil)) then
    exit;
  Data2 := Sender.GetNodeData(Node2);
  if ((Data2 = nil) or (Data2.RowData = nil) or (Data2.RowData.dbRow = nil)) then
    exit;
  S1     := Format('%20s', [Data1.RowData.dbRow['COD_REF'].AsString]);
  S2     := Format('%20s', [Data2.RowData.dbRow['COD_REF'].AsString]);
  Result := AnsiCompareText(S1, S2);
end;

procedure TfmFichaTecnica.stProdutosResize(Sender : TObject);
begin
  stProdutos.Header.Columns[0].Width :=
    stProdutos.Width - stProdutos.Header.Columns[
    1].Width - stProdutos.Header.Columns[2].Width -
    25;
end;

procedure TfmFichaTecnica.stProdutosDblClick(Sender : TObject);
begin
  if Assigned(cmdRetrieveFichaProduto.OnClick) then
    cmdRetrieveFichaProduto.OnClick(Self);
end;

procedure TfmFichaTecnica.stProdutosGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data: PTreeData;
begin
  if ((Sender <> stProdutos) or (Node = nil)) then
    exit;
  Data := stProdutos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  with Data.RowData do
    case Column of
      0: CellText := dbRow['COD_REF'].AsString + ' - ' + DbRow['DSC_PEC'].AsString;
      1: CellText := IntToStr(dbRow['MAJ_VER'].AsInteger) + '.' +
          IntToStr(dbRow['MAJ_VER'].AsInteger);
      2: if Frac(dbRow['QTD_PEC'].AsFloat) <> 0 then
          CellText := FormatFloat('0.0000', dbRow['QTD_PEC'].AsFloat)
        else
          CellText := FormatFloat('0', dbRow['QTD_PEC'].AsFloat);
    end;
end;

procedure TfmFichaTecnica.stProdutosCompareNodes(Sender : TBaseVirtualTree;
  Node1, Node2 : PVirtualNode; Column : TColumnIndex; var Result : Integer);
var
  Data1, Data2: PTreeData;
  S1, S2: String;
begin
  Result := -1;
  if ((Node1 = nil) or (Node2 = nil) or ( not (Sender is TCSDVirtualStringTree))) then
    exit;
  Data1 := Sender.GetNodeData(Node1);
  if ((Data1 = nil) or (Data1.RowData = nil) or (Data1.RowData.dbRow = nil)) then
    exit;
  Data2 := Sender.GetNodeData(Node2);
  if ((Data2 = nil) or (Data2.RowData = nil) or (Data2.RowData.dbRow = nil)) then
    exit;
  S1     := Format('%20s', [Data1.RowData.dbRow['COD_REF'].AsString]);
  S2     := Format('%20s', [Data2.RowData.dbRow['COD_REF'].AsString]);
  Result := AnsiCompareText(S1, S2);
end;

procedure TfmFichaTecnica.pgFichaChanging(Sender : TObject; var AllowChange : Boolean);
begin
  FFromPage := pgFicha.ActivePage;
end;

procedure TfmFichaTecnica.pgFichaChange(Sender : TObject);
var
  Node: PVirtualNode;
  Data: PTreeData;
  afkPeca, afkFichaTecnica: Integer;
  aDescricao: String;
begin
  EnableComponentCommands(stComponentes.FocusedNode);
  EnableFaseCommands(stFases.FocusedNode);
  if ((pgFicha.ActivePage <> tbProdutosPeca) or (FFromPage = nil) or
    (FFromPage = pgFicha.ActivePage)) then
    exit;
  if FFromPage = tbPesquisa then
  begin
    GetFichaTecnicaSelectedPeca(afkPeca, afkFichaTecnica, aDescricao);
    if ((afkPeca < 1) or (afkFichaTecnica < 1)) then
      exit;
    FDescricaoPecaProduto := aDescricao;
    FfkPecaProduto := afkPeca;
    FfkFichaTecnicaProduto := afkFichaTecnica;
  end
  else
  if FFromPage = tbFicha then
  begin
    Node := stComponentes.FocusedNode;
    if Node = nil then
      exit;
    Data := stComponentes.GetNodeData(Node);
    if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
      exit;
    FDescricaoPecaProduto :=
      Data.RowData.dbRow['COD_REF'].AsString + ' - ' + Data.RowData.dbRow['DSC_PEC'].AsString;
    FfkPecaProduto := Data.RowData.dbRow['FK_PECAS_MONTAGEM'].AsInteger;
    FfkFichaTecnicaProduto :=
      Data.RowData.dbRow['FK_FICHA_TECNICA_MONTAGEM'].AsInteger;
  end
  else
    exit;
  LoadProdutos;
end;

procedure TfmFichaTecnica.cmdRetrieveFichaProdutoClick(Sender : TObject);
var
  Node: PVirtualNode;
  Data: PTreeData;
begin
  Node := stProdutos.FocusedNode;
  if Node = nil then
    exit;
  Data := stProdutos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  Fpk_pecas := Data.RowData.dbRow['fk_pecas'].AsInteger;
  Ffk_Ficha_Tecnica := Data.RowData.dbRow['fk_ficha_tecnica'].AsInteger;
  pgFicha.ActivePage := tbFicha;
  LoadComponentes;
end;

procedure TfmFichaTecnica.EnableFaseCommands(Node : PVirtualNode);
var
  ComponenteNode: PVirtualNode;
  CurrLevelFase, CurrLevelPeca: Integer;
  DataFase, DataComponente: PTreeData;

  procedure DisableAllFase;
  begin
    cmdAddFase.Enabled    := False;
    cmdDeleteFase.Enabled := False;
    cmdPropertiesFase.Enabled := False;
    miAddFase.Enabled     := False;
    miDeleteFase.Enabled  := False;
    miPropertiesFase.Enabled := False;
  end;

  procedure DisableAllOperacao;
  begin
    cmdAddOperacao.Enabled    := False;
    cmdDeleteOperacao.Enabled := False;
    cmdPropertiesOperacao.Enabled := False;
    miAddOperation.Enabled    := False;
    miDeleteOperation.Enabled := False;
    miPropertiesOperation.Enabled := False;
  end;

begin
  ComponenteNode := stComponentes.FocusedNode;
  if ComponenteNode <> nil then
    DataComponente := stComponentes.GetNodeData(ComponenteNode)
  else
    DataComponente := nil;
  if Node <> nil then
    DataFase := stFases.GetNodeData(Node)
  else
    DataFase := nil;
  if ((pgFicha.ActivePage <> tbFicha) or (ComponenteNode = nil) or
    (DataComponente = nil) or (DataComponente.RowData = nil) or
    (DataComponente.RowData.dbRow = nil)) then
  begin
    DisableAllFase;
    DisableAllOperacao;
    exit;
  end;
  CurrLevelPeca := stComponentes.GetNodeLevel(ComponenteNode);
  if Node <> nil then
    CurrLevelFase := stFases.GetNodeLevel(Node)
  else
    CurrLevelFase := -1;
  cmdAddFase.Enabled :=
    ((CurrLevelPeca = 0) and (DataComponente.RowData.dbRow['FLAG_ATV'].AsInteger = 0));
  cmdDeleteFase.Enabled  :=
    ((cmdAddFase.Enabled) and (Node <> nil) and (DataFase <> nil) and (DataFase.RowData <> nil) and
    (DataFase.RowData.dbRow <> nil) and (CurrLevelFase = 0));
  cmdPropertiesFase.Enabled :=
    ((Node <> nil) and (DataFase <> nil) and (DataFase.RowData <> nil) and
    (DataFase.RowData.dbRow <> nil) and (CurrLevelFase = 0));
  cmdAddOperacao.Enabled :=
    ((cmdAddFase.Enabled) and (Node <> nil) and (DataFase <> nil) and (DataFase.RowData <> nil) and
    (DataFase.RowData.dbRow <> nil) and ((CurrLevelFase = 0) or
    (CurrLevelFase = 1)));
  cmdDeleteOperacao.Enabled :=
    ((cmdAddFase.Enabled) and (Node <> nil) and (DataFase <> nil) and (DataFase.RowData <> nil) and
    (DataFase.RowData.dbRow <> nil) and (CurrLevelFase = 1));
  cmdPropertiesOperacao.Enabled :=
    ((Node <> nil) and (DataFase <> nil) and (DataFase.RowData <> nil) and
    (DataFase.RowData.dbRow <> nil) and (CurrLevelFase = 1));
  miAddFase.Enabled      := cmdAddFase.Enabled;
  miDeleteFase.Enabled   := cmdDeleteFase.Enabled;
  miPropertiesFase.Enabled := cmdPropertiesFase.Enabled;
  miAddOperation.Enabled := cmdAddOperacao.Enabled;
  miDeleteOperation.Enabled := cmdDeleteOperacao.Enabled;
  miPropertiesOperation.Enabled := cmdPropertiesOperacao.Enabled;
end;

procedure TfmFichaTecnica.stFasesChange(Sender : TBaseVirtualTree; Node : PVirtualNode);
begin
  EnableFaseCommands(Node);
end;

end.

