unit Configurador;

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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, VirtualTrees, Menus, ComCtrls, ExtCtrls, ImgList, ProcType,
  Buttons, SearchReferencia, ProcUtils, GridRow;

type
  TComponenteLevelType = (ltComponente, ltAcabamento, ltReferencia);

  TPrecoLevelType = (pltAcabamento, pltReferencia, pltTabela);

  TDeleteFunc = function(aRow: TDataRow): Boolean of object;

  PRowData = ^TRowData;
  TRowData = class(TObject)
    Node : PVirtualNode;
    dbRow: TDataRow;
    Level: Integer;
    constructor Create;
    destructor  Destroy;override;
  end;

  PTreeData = ^TTreeData;
  TTreeData = record
    RowData: TRowData;
  end;

  TAcabamentoTotals = class(TObject)
  private
    FQtdTotal   : Double;
    FTotalEntries: Integer;
  public
    constructor Create(ATotalEntries: Integer; AQtdTotal: Double);
    destructor Destroy; override;
    property TotalEntries: Integer read FTotalEntries write FTotalEntries;
    property QtdTotal    : Double  read FQtdTotal     write FQtdTotal;
  end;

  TfmConfigurador = class(TForm)
    pop: TPopupMenu;
    cmDelimiter1: TMenuItem;
    cmDelete: TMenuItem;
    cmDelimiter2: TMenuItem;
    cmProperties: TMenuItem;
    paProduto: TPanel;
    lFk_Produtos: TLabel;
    cbProdutos: TComboBox;
    sbStatus: TStatusBar;
    ImageList1: TImageList;
    cbGrupos: TComboBox;
    lFk_Grupos: TLabel;
    paConfiguracao: TPanel;
    stComponentes: TVirtualStringTree;
    Splitter1: TSplitter;
    paPrecos: TPanel;
    stPrecos: TVirtualStringTree;
    paPrecosTitle: TPanel;
    lEndPrice: TLabel;
    cmdUpdateAcabamentos: TSpeedButton;
    cmdExpandPreco: TSpeedButton;
    cmdCollapsePreco: TSpeedButton;
    paImg: TPanel;
    imProduto: TImage;
    Splitter2: TSplitter;
    cbFk_Linhas: TComboBox;
    lFk_Linhas: TLabel;
    MainMenu: TMainMenu;
    miFile: TMenuItem;
    miPrint: TMenuItem;
    miSepFile: TMenuItem;
    miClose: TMenuItem;
    miOperations: TMenuItem;
    miSearchByReference: TMenuItem;
    miTools: TMenuItem;
    miVisibleEntrp: TMenuItem;
    miSepTools2: TMenuItem;
    miHelp: TMenuItem;
    miTopics: TMenuItem;
    miContent: TMenuItem;
    miSepHelp: TMenuItem;
    miAbout: TMenuItem;
    miSepHelp1: TMenuItem;
    miCopyStructTo: TMenuItem;
    N1: TMenuItem;
    Panel1: TPanel;
    cmdCollapseComponente: TSpeedButton;
    cmdExpandComponente: TSpeedButton;
    lConfiguration: TLabel;
    procedure cbProdutosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure stComponentesGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure popPopup(Sender: TObject);
    procedure cmDeleteClick(Sender: TObject);
    procedure cmPropertiesClick(Sender: TObject);
    procedure stComponentesEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure stComponentesResize(Sender: TObject);
    procedure stComponentesGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure stPrecosResize(Sender: TObject);
    procedure stPrecosGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure stPrecosGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure stPrecosEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure stPrecosNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure cmdUpdateAcabamentosClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure stPrecosChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure cmdExpandComponenteClick(Sender: TObject);
    procedure cmdCollapseComponenteClick(Sender: TObject);
    procedure cbGruposClick(Sender: TObject);
    procedure mCloseClick(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure sbCompanyClick(Sender: TObject);
    procedure miAboutClick(Sender: TObject);
    procedure cbFk_LinhasClick(Sender: TObject);
    procedure miOperationsClick(Sender: TObject);
    procedure miSearchByReferenceClick(Sender: TObject);
    procedure miCopyStructToClick(Sender: TObject);
    procedure stComponentesInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure stComponentesChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FFkLinhas             : Integer;
    FFkSecoes             : Integer;
    FFkGrupos             : Integer;
    FFkProdutos           : Integer;
    FFkEmpresas           : Integer;
    FslComponentes        : TList;
    FslPrecos             : TList;
    FInsideMove           : Boolean;
    FslAcabamentos        : TStringList;
    FslReferencias        : TStringList;
    FFirstDymMainMenuItem : Integer;
    FMaincmDelete         : TMenuItem;
    FMaincmProperties     : TMenuItem;
    FMaincmDelimiter1     : TMenuItem;
    FMaincmDelimiter2     : TMenuItem;
    FLastReferencia       : string;
    FCompanyClick         : Boolean;
    FRect                 : TRect;
    procedure HandleNewClick(Sender:TObject);
    procedure SetFkEmpresas(const Value: Integer);
    procedure SetFkProdutos(const Value: Integer);
    { Private declarations }
    procedure ClearLinhas;
    procedure LoadLinhas;
    procedure ClearGrupos;
    procedure LoadGrupos;
    procedure ClearProdutos;
    procedure LoadProdutos;
    procedure ClearPrecos;
    procedure LoadPrecos;
    procedure ClearComponentes;
    procedure LoadComponentes;
    procedure ClearImage;
    procedure LoadImage;
    function  ComponenteDeleted(aRow: TDataRow): Boolean;
    function  AcabamentoDeleted(aRow: TDataRow): Boolean;
    function  ReferenciaDeleted(aRow: TDataRow): Boolean;
    function  GetNodeToInsertBefore(ANode: PVirtualNode; AText: string): PVirtualNode;
    function  AcabamentosUpdated(DestFkProdutos: Integer = 0):Boolean;
    function  MayChangeProduto: Boolean;
    procedure RefreshVisibility;
    procedure LocateAndShowProduto(AFkProduto, AFkLinhas, AFkSecoes, AFkGrupos: Integer);
    procedure SearchReferencia(ASearchType: TReferenciaSearchType = stSearch);
    procedure CopyComponentStruct(FkProdutosFrom, FkProdutosTo: Integer);
    procedure ClearAcabamentos;
  public
    { Public declarations }
    property FkEmpresas: Integer read FFkEmpresas write SetFkEmpresas;
    property FkProdutos: Integer read FFkProdutos write SetFkProdutos;
  end;

var
  fmConfigurador: TfmConfigurador;

implementation

uses mSysConf, EditComponente, EditAcabamento, EditReferencia, Dado, SelEmpr,
     CmmConst, Sobre, Funcoes, FuncoesDB, ConfArqSql, DB;

{$R *.dfm}

const
  KeyFieldName       : array[TComponenteLevelType] of string =
              ('fk_tipo_componentes', 'fk_tipo_acabamentos', 'fk_tipo_referencias');
  DescFieldName      : array[TComponenteLevelType] of string =
              ('dsc_tcomp', 'dsc_acabm', 'dsc_ref');
  PrecoKeyFieldName  : array[TPrecoLevelType] of string =
              ('fk_tipo_acabamentos', 'fk_tipo_referencias', 'fk_tabela_precos');
  PrecoDescFieldName : array[TPrecoLevelType] of string =
              ('dsc_acabm', 'dsc_ref', 'descricao_preco');
var
  DeleteFunc         : array[TComponenteLevelType] of TDeleteFunc;
  LevelCaption       : array[TComponenteLevelType] of string =
              ('Componente', 'Acabamento', 'Referência');
  LevelSuffix        : array[TComponenteLevelType] of string =
              ('o','o','a');
  PrecoLevelCaption  : array[TPrecoLevelType] of string =
              ('Acabamento', 'Referência', 'Tabela');
  PrecoLevelSuffix   : array[TPrecoLevelType] of string =
              ('o','a','a');
  NEW_CAPTION        : string = 'Nov';
  DELETE_CAPTION     : string = 'E&xcluir';
  PROPERTIES_CAPTION : string = '&Propriedades';

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

{ TfmConfigurador }

procedure TfmConfigurador.ClearLinhas;
begin
  ClearProdutos;
  FFkLinhas := -1;
  cbFk_Linhas.Items.Clear;
end;

procedure TfmConfigurador.LoadLinhas;
begin
  ClearLinhas;
  cbFk_Linhas.Items.AddObject('<TODAS>', nil);
  with dmSysConf do
  begin
    if Linhas.Active then Linhas.Close;
    Linhas.SQL.Clear;
    Linhas.SQL.Add(SqlLinhas);
    try
      if not Linhas.Active then Linhas.Open;
      while not (Linhas.EOF) do
      begin
        cbFk_Linhas.Items.AddObject(Linhas.FieldByName('DSC_LIN').AsString,
          TObject(Linhas.FieldByName('PK_LINHAS').AsInteger));
        Linhas.Next;
      end;
    finally
      if Linhas.Active then Linhas.Close;
    end;
  end;
end;

procedure TfmConfigurador.ClearGrupos;
begin
  ClearProdutos;
  FFkGrupos := -1;
  cbGrupos.Items.Clear;
end;

procedure TfmConfigurador.LoadGrupos;
begin
  ClearGrupos;
  cbGrupos.Items.AddObject('<TODOS>',Nil);
  if FFkSecoes < 1 then exit;
  with dmSysConf do
  begin
    if Grupos.Active then Grupos.Close;
    Grupos.SQL.Clear;
    Grupos.SQL.Add(SqlGrupos);
    try
      Grupos.ParamByName('FkSecoes').AsInteger := FFkSecoes;
      if not Grupos.Active then Grupos.Open;
      while not (Grupos.EOF) do
      begin
        cbGrupos.Items.AddObject(Grupos.FieldByName('DSC_GRU').AsString,
          TObject(Grupos.FieldByName('PK_GRUPOS').AsInteger));
        Grupos.Next;
      end;
    finally
      if Grupos.Active then Grupos.Close;
    end;
  end;
end;

procedure TfmConfigurador.ClearProdutos;
begin
  FFkProdutos            := -1;
  miCopyStructTo.Visible := False;
  cbProdutos.Items.Clear;
  ClearComponentes;
  ClearPrecos;
  ClearImage;
end;

procedure TfmConfigurador.LoadProdutos;
begin
  ClearProdutos;
  if ((FFkLinhas < 1) and (FFkSecoes < 1)) then exit;
  with dmSysConf do
  begin
    if Produtos.Active then Produtos.Close;
    Produtos.SQL.Clear;
    Produtos.SQL.Add(SqlProdutos);
    try
      Produtos.ParamByName('FkLinhas').AsInteger   := FFkLinhas;
      Produtos.ParamByName('FkSecoes').AsInteger   := FFkSecoes;
      Produtos.ParamByName('FkGrupos').AsInteger   := FFkGrupos;
      if not Produtos.Active then Produtos.Open;
      while not (Produtos.EOF) do
      begin
        cbProdutos.Items.AddObject(Produtos.FieldByName('COD_REF').AsString + ' - ' +
          Produtos.FieldByName('DSC_PROD').AsString,
          TObject(Produtos.FieldByName('PK_PRODUTOS').AsInteger));
        Produtos.Next;
      end;
    finally
      if Produtos.Active then Produtos.Close;
    end;
  end;
end;

procedure TfmConfigurador.SetFkEmpresas(const Value: Integer);
begin
  if FFkEmpresas = Value then exit;
  FFkEmpresas   := Value;
  LoadProdutos;
end;

procedure TfmConfigurador.LocateAndShowProduto(AFkProduto, AFkLinhas, AFkSecoes,
            AFkGrupos:Integer);
var
  Ix: Integer;
begin
  if ((cbfk_Linhas.ItemIndex < 0) or
     (LongInt(cbfk_Linhas.Items.Objects[cbfk_Linhas.ItemIndex]) <> AFkLinhas)) then
  begin
    Ix := cbfk_Linhas.Items.IndexOfObject(TObject(AFkLinhas));
    if Ix < 0 then exit;
    cbfk_Linhas.ItemIndex := Ix;
    FFkLinhas := AFkLinhas;
  end;
  if ((cbGrupos.ItemIndex < 0) or
      (LongInt(cbGrupos.Items.Objects[cbGrupos.ItemIndex]) <> AFkGrupos)) then
  begin
    if cbGrupos.Items.Count < 2 then LoadGrupos;
    Ix := cbGrupos.Items.IndexOfObject(TObject(AFkGrupos));
    if Ix < 0 then exit;
    cbGrupos.ItemIndex := Ix;
    FFkGrupos := AFkGrupos;
    LoadProdutos;
  end;
  Ix := cbProdutos.Items.IndexOfObject(TObject(AFkProduto));
  if Ix < 0 then
     begin
       LoadProdutos;
       Ix := cbProdutos.Items.IndexOfObject(TObject(AFkProduto));
     end;
  If Ix<0 Then Exit;
  cbProdutos.ItemIndex := Ix;
  FFkProdutos         := AFkProduto;
  //mCopyStructFrom.Visible := True;
  if Assigned(cbProdutos.OnChange) then cbProdutos.OnChange(Self);
end;

procedure TfmConfigurador.SetFkProdutos(const Value: Integer);
var
  aFkLinhas, aFkSecoes, aFkGrupos: Integer;
begin
  aFkLinhas := 0;
  aFkSecoes := 0;
  aFkGrupos := 0;
  if FFkProdutos = Value then exit;
  with dmSysConf do
  begin
    if Produtos.Active then Produtos.Close;
    Produtos.SQL.Clear;
    Produtos.SQL.Add(SqlPkProdutos);
    try
      Produtos.ParamByName('FkProduto').AsInteger  := Value;
      if not Produtos.Active then Produtos.Open;
      if not Produtos.IsEmpty then
      begin
        aFkLinhas := Produtos.FieldByName('FK_LINHAS').AsInteger;
        aFkSecoes := Produtos.FieldByName('FK_SECOES').AsInteger;
        aFkGrupos := Produtos.FieldByName('FK_GRUPOS').AsInteger;
      end;
    finally
      if Produtos.Active then Produtos.Close;
    end;
  end;
  LocateAndShowProduto(Value, aFkLinhas, aFkSecoes, aFkGrupos);
end;

function TfmConfigurador.MayChangeProduto:Boolean;
var
  Rc: Integer;
begin
  Result := not (cmdUpdateAcabamentos.Enabled);
  if Result then exit;
  Rc := MessageBox(Self.Handle, PChar(Dados.GetStringMessage(LANGUAGE, 'sSavePrices',
          'Deseja salvar as alterações nos preços dos acabamentos ?')),
          PChar(Caption), MB_ICONQUESTION or MB_YESNOCANCEL);
  case Rc of
    IDYES   : Result := AcabamentosUpdated;
    IDNO    : Result := True;
    IDCANCEL: Result := False;
  end;
  if Result then exit;
  cbFk_Linhas.ItemIndex := cbfk_Linhas.Items.IndexOfObject(TObject(FFkLinhas));
  cbGrupos.ItemIndex    := cbGrupos.Items.IndexOfObject(TObject(FFkGrupos));
  cbProdutos.ItemIndex  := cbProdutos.Items.IndexOfObject(TObject(FFkProdutos));
end;

procedure TfmConfigurador.cbProdutosClick(Sender: TObject);
begin
  if not (MayChangeProduto)   then exit;
  if cbProdutos.ItemIndex < 0 then exit;
  FFkProdutos := LongInt(cbProdutos.Items.Objects[cbProdutos.ItemIndex]);
  LoadImage;
  LoadComponentes;
  LoadPrecos;
  miCopyStructTo.Visible := True;
end;

function TfmConfigurador.GetNodeToInsertBefore(ANode: PVirtualNode;
           AText: string): PVirtualNode;
begin
  Result  := nil;
  if ANode = nil then exit;
  Result  := ANode;
  while ((Result <> nil) and
        (CompareStr(stComponentes.Text[Result,0], AText) <= 0)) do
    Result := stComponentes.GetNextSibling(Result);
end;

procedure TfmConfigurador.HandleNewClick(Sender:TObject);
var
  TotalAcabamento:TAcabamentoTotals;
  ComponenteLevel: TComponenteLevelType;
  ReferenceNode  ,
  ComponenteNode ,
  AcabamentoNode ,
  CurrNode       : PVirtualNode;
  RowData        : TRowData;
  dbRow          : TDataRow;
  AcabamentoData ,
  ComponenteData ,
  Data           : PTreeData;
  S              : string;
  C, Ix          : Integer;
begin
  if ((Sender = nil) or (not(Sender is TMenuItem))) then exit;
  if ((TMenuItem(Sender).Tag < 0) or
     (TMenuItem(Sender).Tag > Ord(High(TComponenteLevelType)))) then exit;
  ComponenteLevel := TComponenteLevelType(TMenuItem(Sender).Tag);
  CurrNode := stComponentes.FocusedNode;
  dmSysConf.Componente.SQL.Clear;
  dmSysConf.Componente.SQL.Add(SqlComponentes1);
  dmSysConf.Componente.SQL.Add(SqlComponentes2);
  case ComponenteLevel of
    ltComponente:
      begin
        with TfmEditComponente.Create(Self) do
          try
            fkProduto    := FFkProdutos;
            fkComponente := 0;
            if ShowModal <> mrOk then exit;
            dmSysConf.Componente.SQL.Clear;
            dmSysConf.Componente.SQL.Add(SqlComponentes1);
            dmSysConf.Componente.SQL.Add(SqlComponentes2);
            dmSysConf.Componente.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
            dmSysConf.Componente.ParamByName('FkProdutos').AsInteger := FFkProdutos;
            dmSysConf.Componente.ParamByName('FkTipoComponentes').AsInteger := fkTipoComponente;
            dbRow := TDataRow.CreateFromDataSet(nil, dmSysConf.Componente, False);
            dbRow.FieldByName['qtd_comp'].AsFloat              := Quantidade;
            dbRow.FieldByName['fk_tipo_componentes'].AsInteger := fkTipoComponente;
            dbRow.FieldByName['dsc_tcomp'].AsString            := DescricaoTipoComponente;
            dbRow.FromDb                           := True;
            RowData                                := TRowData.Create;
            RowData.Level                          := Ord(ComponenteLevel);
            RowData.dbRow                          := dbRow;
            ReferenceNode                          :=
              GetNodeToInsertBefore(stComponentes.GetFirst, dbRow.FieldByName['dsc_tcomp'].AsString);
            if ReferenceNode = nil then
              CurrNode := stComponentes.AddChild(nil)
            else
              CurrNode := stComponentes.InsertNode(ReferenceNode, amInsertBefore);
            Data := stComponentes.GetNodeData(CurrNode);
            Data.RowData              := RowData;
            RowData.Node              := CurrNode;
            stComponentes.FocusedNode := CurrNode;
            stComponentes.Selected[CurrNode] := True;
            FslComponentes.Add(RowData);
          finally
            Release;
          end;
      end;
    ltAcabamento:
      begin
        ComponenteNode := CurrNode;
        while ((ComponenteNode <> nil) and
              (stComponentes.GetNodeLevel(ComponenteNode) > Cardinal(Ord(ltComponente)))) do
          ComponenteNode := ComponenteNode.Parent;
        if ComponenteNode = nil then exit;
        ComponenteData := stComponentes.GetNodeData(ComponenteNode);
        if ((ComponenteData = nil)              or
           (ComponenteData.RowData = nil)       or
           (ComponenteData.RowData.dbRow = nil) or
           (ComponenteData.RowData.Level <> Ord(ltComponente))) then exit;
        with TfmEditAcabamento.Create(Self) do
        try
          Caption := 'Componente ' +
            ComponenteData.RowData.dbRow.FieldByName['dsc_tcomp'].AsString + ': Novo Acabamento';
          fkProduto := FFkProdutos;
          fkComponente := ComponenteData.RowData.dbRow.FieldByName['fk_tipo_componentes'].AsInteger;
          fkAcabamento := 0;
          if ShowModal <> mrOk then exit;
          dmSysConf.Componente.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
          dmSysConf.Componente.ParamByName('FkProdutos').AsInteger := FFkProdutos;
          dmSysConf.Componente.ParamByName('FkTipoComponentes').AsInteger := fkComponente;
          dbRow := TDataRow.CreateFromDataSet(nil, dmSysConf.Componente, False);
          dbRow.FieldByName['qtd_comp'].AsFloat              := ComponenteData.RowData.dbRow.FieldByName['qtd_comp'].AsFloat;
          dbRow.FieldByName['fk_tipo_componentes'].AsInteger := ComponenteData.RowData.dbRow.FieldByName['fk_tipo_componentes'].AsInteger;
          dbRow.FieldByName['dsc_tcomp'].Asstring            := ComponenteData.RowData.dbRow.FieldByName['dsc_tcomp'].AsString;
          dbRow.FieldByName['dsc_acabm'].AsString            := DescricaoTipoAcabamento;
          dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger := fkTipoAcabamento;
          dbRow.FieldByName['qtd_pdr'].AsFloat               := QuantidadePadrao;
          dbRow.FieldByName['qtd_pers'].AsFloat              := QuantidadePersonalizada;
          dbRow.FromDb  := True;
          RowData       := TRowData.Create;
          RowData.Level := Ord(ComponenteLevel);
          RowData.dbRow := dbRow;
          ReferenceNode := GetNodeToInsertBefore(stComponentes.GetFirstChild(ComponenteNode),dbRow.FieldByName['dsc_acabm'].AsString);
          if ReferenceNode = nil then
            CurrNode := stComponentes.AddChild(ComponenteNode)
          else
            CurrNode := stComponentes.InsertNode(ReferenceNode,amInsertBefore);
          Data         := stComponentes.GetNodeData(CurrNode);
          Data.RowData := RowData;
          RowData.Node := CurrNode;
          stComponentes.FocusedNode := CurrNode;
          stComponentes.Selected[CurrNode] := True;
          FslComponentes.Add(RowData);
          S  := FormatFloat('00000000',dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger);
          Ix := FslAcabamentos.IndexOf(S);
          if Ix < 0 then
          begin
            TotalAcabamento := TAcabamentoTotals.Create(1,
              dbRow.FieldByName['QTD_COMP'].AsFloat * dbRow.FieldByName['QTD_PDR'].AsFloat);
            FslAcabamentos.AddObject(S,TotalAcabamento);
            RefreshVisibility;
          end
          else
          begin
            TotalAcabamento := TAcabamentoTotals(FslAcabamentos.Objects[Ix]);
            if TotalAcabamento <> nil then
            begin
              TotalAcabamento.QtdTotal     := TotalAcabamento.QtdTotal +
                dbRow.FieldByName['QTD_COMP'].AsFloat * dbRow.FieldByName['qtd_pdr'].AsFloat;
              TotalAcabamento.TotalEntries := TotalAcabamento.TotalEntries + 1;
            end;
          end;
        finally
          Release;
        end;
      end;
    ltReferencia:
    begin
        AcabamentoNode:=CurrNode;
        while ((AcabamentoNode <> nil) and
              (stComponentes.GetNodeLevel(AcabamentoNode) > Cardinal(Ord(ltAcabamento)))) do
          AcabamentoNode:=AcabamentoNode.Parent;
        if AcabamentoNode = nil then exit;
        AcabamentoData := stComponentes.GetNodeData(AcabamentoNode);
        if ((AcabamentoData = nil)              or
           (AcabamentoData.RowData = nil)       or
           (AcabamentoData.RowData.dbRow = nil) or
           (AcabamentoData.RowData.Level <> Ord(ltAcabamento))) then
          exit;
        with TfmEditReferencia.Create(Self) do
          try
            Caption  := 'Acabamento ' + AcabamentoData.RowData.dbRow.FieldByName['dsc_acabm'].AsString + ': Nova Referencia';
            fkEmpresa := FFkEmpresas;
            fkProduto := FFkProdutos;
            fkComponente := AcabamentoData.RowData.dbRow.FieldByName['fk_tipo_componentes'].AsInteger;
            fkAcabamento := AcabamentoData.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
            fkReferencia := 0;
            if ShowModal <> mrOk then exit;
            dmSysConf.Componente.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
            dmSysConf.Componente.ParamByName('FkProdutos').AsInteger := FFkProdutos;
            dmSysConf.Componente.ParamByName('FkTipoComponentes').AsInteger := fkComponente;
            dbRow := TDataRow.CreateFromDataSet(nil, dmSysConf.Componente, False);
            dbRow.FieldByName['qtd_comp'].AsFloat              := AcabamentoData.RowData.dbRow.FieldByName['qtd_comp'].AsFloat;
            dbRow.FieldByName['fk_tipo_componentes'].AsInteger := AcabamentoData.RowData.dbRow.FieldByName['fk_tipo_componentes'].AsInteger;
            dbRow.FieldByName['dsc_tcomp'].AsString            := AcabamentoData.RowData.dbRow.FieldByName['dsc_tcomp'].AsString;
            dbRow.FieldByName['dsc_acabm'].AsString            := AcabamentoData.RowData.dbRow.FieldByName['dsc_acabm'].AsString;
            dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger := AcabamentoData.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
            dbRow.FieldByName['dsc_ref'].AsString              := DescricaoTipoReferencia;
            dbRow.FieldByName['fk_tipo_referencias'].AsInteger := fkTipoReferencia;
            dbRow.FieldByName['FLAG_ATIVO'].AsInteger          := Integer(ReferenciaAtiva);
            dbRow.FromDb  := True;
            RowData       := TRowData.Create;
            RowData.Level := Ord(ComponenteLevel);
            RowData.dbRow := dbRow;
            ReferenceNode := GetNodeToInsertBefore(stComponentes.GetFirstChild(AcabamentoNode),dbRow.FieldByName['dsc_ref'].AsString);
            if ReferenceNode = nil then
              CurrNode := stComponentes.AddChild(AcabamentoNode)
            else
              CurrNode := stComponentes.InsertNode(ReferenceNode,amInsertBefore);
            if dbRow.FieldByName['FLAG_ATIVO'].AsInteger<>0 Then stComponentes.CheckState[CurrNode]:=csCheckedNormal
            else stComponentes.CheckState[CurrNode]:=csUnCheckedNormal;
            Data := stComponentes.GetNodeData(CurrNode);
            Data.RowData := RowData;
            RowData.Node := CurrNode;
            stComponentes.FocusedNode := CurrNode;
            stComponentes.Selected[CurrNode] := True;
            FslComponentes.Add(RowData);
            S := FormatFloat('00000000',dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger)+
                 FormatFloat('00000000',dbRow.FieldByName['fk_tipo_referencias'].AsInteger);
            Ix := FslReferencias.IndexOf(S);
            if Ix < 0 then
            begin
              FslReferencias.AddObject(S,TObject(LongInt(1)));
              RefreshVisibility;
            end
            else
            begin
               C := LongInt(FslReferencias.Objects[Ix]);
               Inc(C);
               FslReferencias.Objects[Ix]:=TObject(C);
            end;
          finally
            Release;
          end;
      end;
  end;
end;

procedure TfmConfigurador.FormCreate(Sender: TObject);
var
  ComponenteLevel: TComponenteLevelType;
  NewItem        : TMenuItem;
  I              : Integer;
begin
  MainMenu.Images      := Dados.Image16;
  Caption              := Application.Title;
  miFile.Caption       := Dados.GetStringMessage(LANGUAGE, 'smiFile', '&Arquivo');
  miOperations.Caption := Dados.GetStringMessage(LANGUAGE, 'smiOperations', '&Operações');
  miTools.Caption      := Dados.GetStringMessage(LANGUAGE, 'smiTools', '&Ferramentas');
  miHelp.Caption       := Dados.GetStringMessage(LANGUAGE, 'smiHelp', 'Aj&uda');
  miPrint.Caption      := Dados.GetStringMessage(LANGUAGE, 'smiPrint', 'Im&primir');
  miClose.Caption      := Dados.GetStringMessage(LANGUAGE, 'smiClose', 'Sai&r');
  miSearchByReference.Caption := Dados.GetStringMessage(LANGUAGE, 'smiSearchByReference', '&Busca pela Referência');
  miVisibleEntrp.Caption      := Dados.GetStringMessage(LANGUAGE, 'smiVisibleEntrp', '&Exibir Empresa Ativa');
  miCopyStructTo.Caption      := Dados.GetStringMessage(LANGUAGE, 'smiCopyStructTo', '&Copiar a Estrutura para:');
  miTopics.Caption     := Dados.GetStringMessage(LANGUAGE, 'smiTopics', '&Tópicos');
  miContent.Caption    := Dados.GetStringMessage(LANGUAGE, 'smiContent', 'Co&nteúdo');
  miAbout.Caption      := Dados.GetStringMessage(LANGUAGE, 'smiAbout', '&Sobre');
  lFk_Linhas.Caption     := Dados.GetStringMessage(LANGUAGE, 'sFkLinhas', '&Linha:');
  lFk_Produtos.Caption   := Dados.GetStringMessage(LANGUAGE, 'sFkProdutos', '&Produtos:');
  lFk_Grupos.Caption     := Dados.GetStringMessage(LANGUAGE, 'sFkGrupos', '&Grupos:');
  lConfiguration.Caption := Dados.GetStringMessage(LANGUAGE, 'slConfiguration', 'Configurações:');
  lEndPrice.Caption      := Dados.GetStringMessage(LANGUAGE, 'slEndPrice', 'Preços dos Acabamentos:');
  stComponentes.Header.Columns[0].Text := Dados.GetStringMessage(LANGUAGE, 'sLevelCaption0', 'Componente');
  stPrecos.Header.Columns[0].Text      := Dados.GetStringMessage(LANGUAGE, 'sLevelCaption2', 'Referência');
  stPrecos.Header.Columns[1].Text      := Dados.GetStringMessage(LANGUAGE, 'sclPrice', 'Preço');
  LevelCaption[ltComponente] := Dados.GetStringMessage(LANGUAGE, 'sLevelCaption0', 'Componente');
  LevelCaption[ltAcabamento] := Dados.GetStringMessage(LANGUAGE, 'sLevelCaption1', 'Acabamento');
  LevelCaption[ltReferencia] := Dados.GetStringMessage(LANGUAGE, 'sLevelCaption2', 'Referência');
  PrecoLevelCaption[pltAcabamento] := Dados.GetStringMessage(LANGUAGE, 'sPrecoLevelCaption0', 'Acabamento');
  PrecoLevelCaption[pltReferencia] := Dados.GetStringMessage(LANGUAGE, 'sPrecoLevelCaption1', 'Referência');
  PrecoLevelCaption[pltTabela]     := Dados.GetStringMessage(LANGUAGE, 'sPrecoLevelCaption2', 'Tabela');
  NEW_CAPTION          := Dados.GetStringMessage(LANGUAGE, 'sNEW_CAPTION', 'Nov');
  DELETE_CAPTION       := Dados.GetStringMessage(LANGUAGE, 'sDELETE_CAPTION', 'E&xcluir');
  PROPERTIES_CAPTION   := Dados.GetStringMessage(LANGUAGE, 'sPROPERTIES_CAPTION', 'Proprie&dades');
  FslAcabamentos := TStringList.Create;
  FslReferencias := TStringList.Create;
  FslComponentes := TList.Create;
  stComponentes.NodeDataSize  := SizeOf(TTreeData);
  stComponentes.RootNodeCount := 0;
  FslPrecos := TList.Create;
  stPrecos.NodeDataSize := SizeOf(TTreeData);
  stPrecos.RootNodeCount := 0;
  FillChar(DeleteFunc,SizeOf(DeleteFunc),0);
  DeleteFunc[ltComponente] := ComponenteDeleted;
  DeleteFunc[ltAcabamento] := AcabamentoDeleted;
  DeleteFunc[ltReferencia] := ReferenciaDeleted;
  for ComponenteLevel := High(TComponenteLevelType) downto Low(TComponenteLevelType) do
  begin
    NewItem := TMenuItem.Create(pop);
    pop.Items.Insert(0,NewItem);
    NewItem.Caption := NEW_CAPTION + LevelSuffix[ComponenteLevel] + ' &' +
                       LevelCaption[ComponenteLevel];
    NewItem.Tag     := Ord(ComponenteLevel);
    NewItem.OnClick := HandleNewClick;
    NewItem.Visible := True;
  end;
  // Adding Insert Items to main menu also
  FMaincmDelete     := nil;
  FMaincmProperties := nil;
  FMaincmDelimiter1 := nil;
  FMaincmDelimiter2 := nil;
  FFirstDymMainMenuItem := miOperations.Count;
  for I := 0 to pop.Items.Count-1 do
  begin
    NewItem := TMenuItem.Create(miOperations);
    miOperations.Add(NewItem);
    NewItem.Caption := pop.Items[I].Caption;
    NewItem.Tag     := pop.Items[I].Tag;
    NewItem.OnClick := pop.Items[I].OnClick;
    NewItem.Visible := False;//pop.Items[I].Visible;
    if pop.Items[I] =  cmDelete then
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
  FFkEmpresas := Dados.PkCompany;
  LoadLinhas;
  if cbfk_Linhas.Items.Count > 0 then
  begin
    cbfk_Linhas.ItemIndex := 0;
    if Assigned(cbfk_Linhas.OnClick) then cbfk_Linhas.OnClick(Self);
  end;
  LoadGrupos;
  if cbGrupos.Items.Count > 0 then
  begin
    cbGrupos.ItemIndex := 0;
    if Assigned(cbGrupos.OnClick) then cbGrupos.OnClick(Self);
  end;
end;

procedure TfmConfigurador.FormDestroy(Sender: TObject);
begin
  ClearComponentes;
  FslComponentes.Free;
  FslComponentes := nil;
  ClearPrecos;
  FslPrecos.Free;
  FslPrecos      := nil;
  FslReferencias.Clear;
  FslReferencias.Free;
  FslReferencias := nil;
  ClearAcabamentos;
  FslAcabamentos.Free;
  FslAcabamentos := nil;
end;

procedure TfmConfigurador.ClearPrecos;
var
  I       :Integer;
  RowData : TRowData;
begin
  for I := 0 to FslPrecos.Count - 1 do
  begin
    RowData := TRowData(FslPrecos[I]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslPrecos[I] := nil;
    end;
  end;
  FslPrecos.Clear;
  stPrecos.Clear;
  cmdUpdateAcabamentos.Enabled := False;
end;

procedure TfmConfigurador.LoadPrecos;
var
  RowData   : TRowData;
  DataParent,
  Data      : PTreeData;
  dbRow     : TDataRow;
  CurrNode  : array[TPrecoLevelType] of PVirtualNode;
  CurrKey   ,
  LastKey   : array[TPrecoLevelType] of Integer;
  KeyChanged: array[TPrecoLevelType] of Boolean;
  PrecoLevel: TPrecoLevelType;
  S         : string;
begin
  FillChar(LastKey, SizeOf(LastKey), 0);
  FillChar(CurrNode, SizeOf(CurrNode), 0);
  Screen.Cursor := crHourGlass;
  stPrecos.BeginUpdate;
  FInsideMove := True;
  try
    ClearPrecos;
    with dmSysConf do
    begin
      if Precos.Active then Precos.Close;
      Precos.SQL.Clear;
      Precos.SQL.Add(SqlPrecosReferencia);
      try
        if not Precos.Active then Precos.Open;
        while not (Precos.EOF) do
        begin
          FillChar(KeyChanged,SizeOf(KeyChanged), 0);
          for PrecoLevel := Low(TPrecoLevelType) to High(TPrecoLevelType) do
          begin
            CurrKey[PrecoLevel] := Precos.FieldByName(PrecoKeyFieldName[PrecoLevel]).AsInteger;
            KeyChanged[PrecoLevel] := (CurrKey[PrecoLevel]<>LastKey[PrecoLevel]);
            if ((not (KeyChanged[PrecoLevel])) and
               (PrecoLevel > Low(TPrecoLevelType))) then
              KeyChanged[PrecoLevel] := ((KeyChanged[PrecoLevel]) or (KeyChanged[Pred(PrecoLevel)]));
            if ((KeyChanged[PrecoLevel])) then
            begin
              dbRow   := TDataRow.CreateFromDataSet(nil, dmSysConf.Precos, True);
              RowData := TRowData.Create;
              RowData.Level := Ord(PrecoLevel);
              RowData.dbRow := dbRow;
              if PrecoLevel > Low(TPrecoLevelType) then
                CurrNode[PrecoLevel] := stPrecos.AddChild(CurrNode[Pred(PrecoLevel)])
              else
                CurrNode[PrecoLevel] := stPrecos.AddChild(nil);
              Data := stPrecos.GetNodeData(CurrNode[PrecoLevel]);
              Data.RowData := RowData;
              RowData.Node := CurrNode[PrecoLevel];
              LastKey[PrecoLevel] := CurrKey[PrecoLevel];
              FslPrecos.Add(RowData);
              case PrecoLevel of
                pltAcabamento:
                begin
                  S := FormatFloat('00000000', dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger);
                  stPrecos.IsVisible[CurrNode[PrecoLevel]] := (FslAcabamentos.IndexOf(S) > -1);
                end;
                pltReferencia:
                begin
                  // JOP 08.09.03 CurrNode[PrecoLevel].CheckType:=ctCheckBox;
                  // JOP 08.09.03 stPrecos.CheckState[CurrNode[PrecoLevel]]:=csUnCheckedNormal;
                  S := FormatFloat('00000000', dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger)+
                       FormatFloat('00000000', dbRow.FieldByName['fk_tipo_referencias'].AsInteger);
                  stPrecos.IsVisible[CurrNode[PrecoLevel]] := (FslReferencias.IndexOf(S) > -1);
                end;
                pltTabela    :
                begin
                  if Preco.Active then Preco.Close;
                  Preco.SQL.Clear;
                  Preco.Params.Clear;
                  if dbRow.FieldByName['fk_tabela_precos'].AsInteger = 0 then
                    Preco.SQL.Add(SqlPrecoSugestao)
                  else
                  begin
                    Preco.SQL.Add(SqlPrecoAcabamento);
                    Preco.ParamByName('FkTabelaPrecos').AsInteger := dbRow.FieldByName['fk_tabela_precos'].AsInteger;
                  end;
                  stPrecos.IsVisible[CurrNode[PrecoLevel]] := (dbRow.FieldByName['fk_tabela_precos'].AsInteger > 0); // JOP 08.09.03
                  try
                    Preco.ParamByName('FkEmpresas').AsInteger := FFkEmpresas;
                    Preco.ParamByName('FkProdutos').AsInteger := FFkProdutos;
                    Preco.ParamByName('FkTipoAcabamentos').AsInteger := dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
                    Preco.ParamByName('FkTipoReferencias').AsInteger := dbRow.FieldByName['fk_tipo_referencias'].AsInteger;
                    if not Preco.Active then Preco.Open;
                    if not (Preco.EOF) then
                    begin
                      dbRow.FieldByName['Preco'].AsFloat := Preco.FieldByName('Preco').AsFloat;
                      if ((dbRow.FieldByName['fk_tabela_precos'].AsInteger = 0) and
                         (CurrNode[pltReferencia] <> nil)) then // JOP 08.09.03
                      begin                                                                          // JOP 08.09.03
                        DataParent := stPrecos.GetNodeData(CurrNode[pltReferencia]);                 // JOP 08.09.03
                        if ((DataParent <> nil) and
                           (DataParent.RowData <> nil) and
                           (DataParent.RowData.dbRow <> nil)) then  // JOP 08.09.03
                          DataParent.RowData.dbRow.FieldByName['Preco'].AsFloat := dbRow.FieldByName['Preco'].AsFloat;         // JOP 08.09.03
                      end;                                                                           // JOP 08.09.03
                      // JOP 08.09.03 stPrecos.CheckState[CurrNode[pltReferencia]]:=csCheckedNormal;
                    end;
                  finally
                    if Preco.Active then Preco.Close;
                  end;
                end;
              end;
            end;
          end;
          Precos.Next;
        end;
      finally
        if Precos.Active then Precos.Close;
      end;
    end;
  finally
    stPrecos.EndUpdate;
    //stPrecos.FullExpand;
    Screen.Cursor := crDefault;
    FInsideMove   := False;
  end;
end;

procedure TfmConfigurador.ClearComponentes;
var
  I      : Integer;
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
  FslReferencias.Clear;
  ClearAcabamentos;
end;

procedure TfmConfigurador.LoadComponentes;
var
  RowData        : TRowData;
  Data           : PTreeData;
  dbRow          : TDataRow;
  CurrNode       : array[TComponenteLevelType] of PVirtualNode;
  CurrKey,
  LastKey        : array[TComponenteLevelType] of Integer;
  KeyChanged     : array[TComponenteLevelType] of Boolean;
  ComponenteLevel: TComponenteLevelType;
  C,Ix           : Integer;
  S              : string;
  TotalAcabamento: TAcabamentoTotals;
begin
  FillChar(LastKey, SizeOf(LastKey), 0);
  FillChar(CurrNode, SizeOf(CurrNode), 0);
  Screen.Cursor := crHourGlass;
  stComponentes.BeginUpdate;
  try
    ClearComponentes;
    with dmSysConf do
    begin
      if Componente.Active then Componente.Close;
      Componente.SQL.Clear;
      Componente.Params.Clear;
      Componente.SQL.Add(SqlComponentes1);
      Componente.SQL.Add(SqlComponentes2);
//      ShowMessage(Componente.SQl.Text);
      try
        Componente.ParamByName('FkEmpresas').AsInteger := FFkEmpresas;
        Componente.ParamByName('FkProdutos').AsInteger := FFkProdutos;
        Componente.ParamByName('FkTipoComponentes').AsInteger := 0;
        if not Componente.Active then Componente.Open;
        while not (Componente.EOF) do
        begin
          FillChar(KeyChanged, SizeOf(KeyChanged), 0);
          for ComponenteLevel := Low(TComponenteLevelType) to High(TComponenteLevelType) do
          begin
            CurrKey[ComponenteLevel]    := Componente.FieldByName(KeyFieldName[ComponenteLevel]).AsInteger;
            KeyChanged[ComponenteLevel] := (CurrKey[ComponenteLevel]<>LastKey[ComponenteLevel]);
            if ((not(KeyChanged[ComponenteLevel])) and
               (ComponenteLevel>Low(TComponenteLevelType))) then
              KeyChanged[ComponenteLevel] := ((KeyChanged[ComponenteLevel]) or (KeyChanged[Pred(ComponenteLevel)]));
            if ((KeyChanged[ComponenteLevel]) and
               (CurrKey[ComponenteLevel] > 0)) then
            begin
              dbRow   := TDataRow.CreateFromDataSet(nil, Componente, True);
              RowData := TRowData.Create;
              RowData.Level := Ord(ComponenteLevel);
              RowData.dbRow := dbRow;
              if ComponenteLevel > Low(TComponenteLevelType) then
                CurrNode[ComponenteLevel] := stComponentes.AddChild(CurrNode[Pred(ComponenteLevel)])
              else
                CurrNode[ComponenteLevel] := stComponentes.AddChild(nil);
              Data := stComponentes.GetNodeData(CurrNode[ComponenteLevel]);
              Data.RowData := RowData;
              RowData.Node := CurrNode[ComponenteLevel];
              LastKey[ComponenteLevel] := CurrKey[ComponenteLevel];
              FslComponentes.Add(RowData);
              case ComponenteLevel of
                ltAcabamento:
                begin
                  S  := FormatFloat('00000000', dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger);
                  Ix := FslAcabamentos.IndexOf(S);
                  if Ix < 0 then
                  begin
                    TotalAcabamento := TAcabamentoTotals.Create(1,
                      dbRow.FieldByName['QTD_COMP'].AsFloat * dbRow.FieldByName['qtd_pdr'].AsFloat);
                    FslAcabamentos.AddObject(S, TotalAcabamento);
                  end
                  else
                   begin
                     TotalAcabamento := TAcabamentoTotals(FslAcabamentos.Objects[Ix]);
                     if TotalAcabamento <> nil then
                     begin
                       TotalAcabamento.QtdTotal := TotalAcabamento.QtdTotal +
                         dbRow.FieldByName['QTD_COMP'].AsFloat * dbRow.FieldByName['qtd_pdr'].AsFloat;
                       TotalAcabamento.TotalEntries := TotalAcabamento.TotalEntries + 1;
                     end;
                   end;
                end;
              ltReferencia :
                begin
                  S  := FormatFloat('00000000',dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger) +
                        FormatFloat('00000000',dbRow.FieldByName['fk_tipo_referencias'].AsInteger);
                  Ix := FslReferencias.IndexOf(S);
                  if Ix < 0 then
                    FslReferencias.AddObject(S,TObject(LongInt(1)))
                  else
                  begin
                    C := LongInt(FslReferencias.Objects[Ix]);
                    Inc(C);
                    FslReferencias.Objects[Ix] := TObject(C);
                  end;
                  if Data.RowData.dbRow.FieldByName['FLAG_ATIVO'].AsInteger <> 0 then
                    stComponentes.CheckState[CurrNode[ComponenteLevel]] := csCheckedNormal
                  else
                    stComponentes.CheckState[CurrNode[ComponenteLevel]] := csUnCheckedNormal;
                end;
              end;
            end;
          end;
          Componente.Next;
        end;
      finally
        if Componente.Active then Componente.Close;
      end;
    end;
  finally
    stComponentes.EndUpdate;
    //stComponentes.FullExpand;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfmConfigurador.stComponentesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PTreeData;
  lt  : TComponenteLevelType;
begin
  if Node = nil then exit;
  Data := stComponentes.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
     (Data.RowData.Level>Ord(High(TComponenteLevelType)))) then
    exit;
  lt:=TComponenteLevelType(Data.RowData.Level);
  Case Column of
       0:CellText := Data.RowData.dbRow.FieldByName[DescFieldName[lt]].AsString;
       1:case lt of
              ltComponente  :CellText:=FormatFloat('#,##0.00',Data.RowData.dbRow.FieldByName['QTD_COMP'].AsFloat);
              ltAcabamento  :CellText:=FormatFloat('#,##0.00',Data.RowData.dbRow.FieldByName['QTD_PDR'].AsFloat);
              ltReferencia  :CellText:='';
         end;
       2:case lt of
              ltComponente  :CellText:=FormatFloat('#,##0.00',Data.RowData.dbRow.FieldByName['QTD_COMP'].AsFloat);
              ltAcabamento  :CellText:=FormatFloat('#,##0.00',Data.RowData.dbRow.FieldByName['QTD_COMP'].AsFloat*Data.RowData.dbRow.FieldByName['QTD_PDR'].AsFloat);
              ltReferencia  :CellText:='';
         end;
  end;
end;

procedure TfmConfigurador.popPopup(Sender: TObject);
var
  CurrNode       : PVirtualNode;
  ComponenteLevel: TComponenteLevelType;
  CurrLevel      : Integer;
begin
  CurrNode := stComponentes.FocusedNode;
  if CurrNode <> nil then
    CurrLevel := stComponentes.GetNodeLevel(CurrNode)
  else
    CurrLevel := -1;
  Pop.Items[0].Visible := (cbProdutos.ItemIndex > -1);
  for ComponenteLevel := Succ(Low(TComponenteLevelType)) to High(TComponenteLevelType) do
    Pop.Items[Ord(ComponenteLevel)].Visible :=
      ((Pop.Items[Ord(Pred(ComponenteLevel))].Visible) and (CurrNode <> nil) and
      (CurrLevel >= Ord(Pred(ComponenteLevel))));
  cmDelete.Visible := (CurrNode <> nil);
  if cmDelete.Visible then
    cmDelete.Caption     := DELETE_CAPTION + ' ' +
                              LevelCaption[TComponenteLevelType(CurrLevel)];
  cmProperties.Visible   := cmDelete.Visible;
  if cmProperties.Visible then
    cmProperties.Caption := PROPERTIES_CAPTION + ' ' +
                              LevelCaption[TComponenteLevelType(CurrLevel)];
  cmDelimiter1.Visible   := cmDelete.Visible;
  cmDelimiter2.Visible   := cmDelimiter1.Visible;
end;

procedure TfmConfigurador.cmDeleteClick(Sender: TObject);
var
  aNode,CurrNode       : PVirtualNode;
  S                    : string;
  Data                 : PTreeData;
  Ix,Ix2,C             : Integer;
  CurrLevel            : Cardinal;
  MustUpdateAcabamentos: Boolean;
  TotalAcabamento      : TAcabamentoTotals;

  procedure DeleteNodeData(NodeToDelete: PVirtualNode);
  begin
    if NodeToDelete = nil then exit;
    Data := stComponentes.GetNodeData(NodeToDelete);
    if ((Data <> nil) and (Data.RowData <> nil)) then
    begin
      Ix := FslComponentes.IndexOf(Data.RowData);
      if Ix > -1 then
      begin
        if ((Data.RowData.Level>Ord(ltComponente)) and
           (Data.RowData.Level<=Ord(ltReferencia)) and
           (Data.RowData.dbRow <> nil)) then
           case TComponenteLevelType(Data.RowData.Level) of
             ltAcabamento:
               begin
                 S   := FormatFloat('00000000',Data.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger);
                 Ix2 := FslAcabamentos.IndexOf(S);
                 if Ix2 > -1 then
                 begin
                   TotalAcabamento:=TAcabamentoTotals(FslAcabamentos.Objects[Ix2]);
                    if TotalAcabamento <> nil then
                    begin
                      TotalAcabamento.QtdTotal := TotalAcabamento.QtdTotal -
                        Data.RowData.dbRow.FieldByName['QTD_COMP'].AsFloat *
                        Data.RowData.dbRow.FieldByName['QTD_PDR'].AsFloat;
                      TotalAcabamento.TotalEntries := TotalAcabamento.TotalEntries - 1;
                      if TotalAcabamento.TotalEntries < 1 then
                      begin
                        TotalAcabamento.Free;
                        TotalAcabamento := nil;
                        FslAcabamentos.Delete(Ix2);
                        MustUpdateAcabamentos:=True;
                      end;
                    end;
                  end;
                end;
              ltReferencia:
                begin
                  S   := FormatFloat('00000000', Data.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger) +
                         FormatFloat('00000000', Data.RowData.dbRow.FieldByName['fk_tipo_referencias'].AsInteger);
                  Ix2 := FslReferencias.IndexOf(S);
                  if Ix2 > -1 then
                  begin
                    C := LongInt(FslReferencias.Objects[Ix2]);
                    Dec(C);
                    if C < 1 then
                    begin
                      FslReferencias.Delete(Ix2);
                      MustUpdateAcabamentos:=True;
                    end
                    else
                      FslReferencias.Objects[Ix2]:=TObject(C);
                  end;
                end;
           end;
           FslComponentes.Delete(Ix);
           Data.RowData.Free;
           Data.RowData := nil;
      end;
    end;
  end;
begin
  CurrNode := stComponentes.FocusedNode;
  if CurrNode = nil then exit;
  MustUpdateAcabamentos := False;
  Data := stComponentes.GetNodeData(CurrNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  S := 'Por favor, confirme a exclusão d' + // sConfirmExlusionOf
         LevelSuffix[TComponenteLevelType(Data.RowData.Level)]  + ' '  +
         LevelCaption[TComponenteLevelType(Data.RowData.Level)] + ' "' +
         stComponentes.Text[CurrNode,0] + '" !';
  if MessageBox(Self.Handle,PChar(S), PChar(Caption),
     MB_ICONQUESTION or MB_YESNO) <> IDYES then
    exit;
  CurrLevel := stComponentes.GetNodeLevel(CurrNode);
  if Assigned(DeleteFunc[TComponenteLevelType(CurrLevel)]) then
    if not(DeleteFunc[TComponenteLevelType(CurrLevel)](Data.RowData.dbRow)) then
      exit
    else
  else
    exit;
  {case TComponenteLevelType(CurrLevel) of
     ltComponente: if not(ComponenteDeleted(Data.RowData.dbRow)) then exit;
     ltAcabamento: if not(AcabamentoDeleted(Data.RowData.dbRow)) then exit;
     ltReferencia: if not(ReferenciaDeleted(Data.RowData.dbRow)) then exit;
  end;}
  aNode := stComponentes.GetFirstChild(CurrNode);
  while ((aNode <> nil) and (stComponentes.GetNodeLevel(aNode) > CurrLevel)) do
  begin
    DeleteNodeData(aNode);
    aNode := stComponentes.GetNext(aNode);
  end;
  DeleteNodeData(CurrNode);
  stComponentes.DeleteNode(CurrNode);
  RefreshVisibility;
  if MustUpdateAcabamentos then
    if AcabamentosUpdated then ;
end;

procedure TfmConfigurador.cmPropertiesClick(Sender: TObject);
var
  ChildNode,
  CurrNode          : PVirtualNode;
  DataChild,
  Data              : PTreeData;
  Ix                : Integer;
  CurrLevel         : Cardinal;
  TotalAcabamento   : TAcabamentoTotals;
  S                 : String;
  DeltaQtdPdr,
  OldqtdPdr         : Double;
begin
  CurrNode  := stComponentes.FocusedNode;
  if CurrNode = nil then exit;
  Data      := stComponentes.GetNodeData(CurrNode);
  if ((Data  = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then exit;
  CurrLevel := stComponentes.GetNodeLevel(CurrNode);
  case TComponenteLevelType(CurrLevel) of
    ltComponente:
      begin
        with TfmEditComponente.Create(Self) do
        begin
          try
            fkProduto    := FFkProdutos;
            fkComponente := Data.RowData.dbRow.FieldByName['fk_tipo_componentes'].AsInteger;
            if ShowModal <> mrOk then exit;
            Data.RowData.dbRow.FieldByName['QTD_COMP'].AsFloat           := Quantidade;
            Data.RowData.dbRow.FromDb                        := True;
          finally
            Release;
          end;
        end;
        stComponentes.BeginUpdate;
        stPrecos.BeginUpdate;
        try
          ChildNode:=stComponentes.GetFirstChild(CurrNode);
          while ((ChildNode <> nil) and
                (stComponentes.GetNodeLevel(ChildNode) > CurrLevel)) do
          begin
            DataChild:=stComponentes.GetNodeData(ChildNode);
            if ((DataChild <> nil) and (DataChild.RowData <> nil) and
                (DataChild.RowData.dbRow <> nil)) then
            begin
              DeltaQtdPdr := (Data.RowData.dbRow.FieldByName['qtd_comp'].AsFloat -
                              DataChild.RowData.dbRow.FieldByName['QTD_COMP'].AsFloat) *
                              DataChild.RowData.dbRow.FieldByName['qtd_pdr'].AsFloat;
              DataChild.RowData.dbRow.FieldByName['qtd_comp'].AsFloat :=
                  Data.RowData.dbRow.FieldByName['qtd_comp'].AsFloat;
              if TComponenteLevelType(stComponentes.GetNodeLevel(ChildNode)) = ltAcabamento then
              begin
                S  := FormatFloat('00000000', DataChild.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger);
                Ix := FslAcabamentos.IndexOf(S);
                if Ix > -1 then
                begin
                  TotalAcabamento := TAcabamentoTotals(FslAcabamentos.Objects[Ix]);
                  if TotalAcabamento <> nil then
                    TotalAcabamento.QtdTotal := TotalAcabamento.QtdTotal + DeltaQtdPdr;
                end;
              end;
            end;
            ChildNode:=stComponentes.GetNext(ChildNode);
          end;
        finally
          stComponentes.InvalidateNode(CurrNode);
          stComponentes.EndUpdate;
          stPrecos.Invalidate;
          stPrecos.EndUpdate;
        end;
      end;
    ltAcabamento:
      begin
        OldQtdPdr:=Data.RowData.dbRow.FieldByName['QTD_COMP'].AsFloat*Data.RowData.dbRow.FieldByName['qtd_pdr'].AsFloat;
        with TfmEditAcabamento.Create(Self) do
        begin
          try
            Caption      := Data.RowData.dbRow.FieldByName['dsc_tcomp'].AsString + ': ' +
                            Data.RowData.dbRow.FieldByName['dsc_acabm'].AsString;
            fkProduto    := FFkProdutos;
            fkComponente := Data.RowData.dbRow.FieldByName['fk_tipo_componentes'].AsInteger;
            fkAcabamento := Data.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
            if ShowModal <> mrOk then exit;
            Data.RowData.dbRow.FieldByName['dsc_acabm'].AsString            := DescricaoTipoAcabamento;
            Data.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger := fkTipoAcabamento;
            Data.RowData.dbRow.FieldByName['qtd_pdr'].AsFloat               := QuantidadePadrao;
            Data.RowData.dbRow.FieldByName['qtd_pers'].AsFloat              := QuantidadePersonalizada;
            Data.RowData.dbRow.FromDb                           := True;
            //Data.RowData.dbRow.FieldByName['fk_Unidades'].AsString := fkUnidade;
            //Data.RowData.dbRow.FieldByName['qtd_pdr'].AsFloat      := QuantidadePadrao;
            //Data.RowData.dbRow.FieldByName['qtd_pers'].AsFloat     := QuantidadePersonalizada;
            //Data.RowData.dbRow.FieldByName['flag_tacbm'].AsInteger := Integer(AcabamentoOpcional);
            //Data.RowData.dbRow.FromDb                  := True;
          finally
            Release;
          end;
        end;
        S  := FormatFloat('00000000', Data.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger);
        Ix := FslAcabamentos.IndexOf(S);
        if Ix > -1 then
        begin
          TotalAcabamento := TAcabamentoTotals(FslAcabamentos.Objects[Ix]);
          if TotalAcabamento <> nil then
             TotalAcabamento.QtdTotal := TotalAcabamento.QtdTotal -
               OldQtdPdr + Data.RowData.dbRow.FieldByName['QTD_COMP'].AsFloat *
               Data.RowData.dbRow.FieldByName['qtd_pdr'].AsFloat;
        end;
      end;
    ltReferencia:
      begin
        with TfmEditReferencia.Create(Self) do
        begin
          try
            Caption      := Data.RowData.dbRow.FieldByName['dsc_acabm'].AsString + ': ' +
                            Data.RowData.dbRow.FieldByName['dsc_ref'].AsString;
            fkEmpresa    := FFkEmpresas;
            fkProduto    := FFkProdutos;
            fkComponente := Data.RowData.dbRow.FieldByName['fk_tipo_componentes'].AsInteger;
            fkAcabamento := Data.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
            fkReferencia := Data.RowData.dbRow.FieldByName['fk_tipo_referencias'].AsInteger;
            if ShowModal <> mrOk then exit;
            Data.RowData.dbRow.FieldByName['FLAG_ATIVO'].AsInteger    :=Integer(ReferenciaAtiva);
            if Data.RowData.dbRow.FieldByName['FLAG_ATIVO'].AsInteger<>0 Then stComponentes.CheckState[CurrNode]:=csCheckedNormal
            else stComponentes.CheckState[CurrNode]:=csUnCheckedNormal;
            //Data.RowData.dbRow.FieldByName['fk_Unidades'].AsString := fkUnidade;
            //Data.RowData.dbRow.FieldByName['qtd_pdr'].AsFloat      := QuantidadePadrao;
            //Data.RowData.dbRow.FieldByName['qtd_pers'].AsFloat     := QuantidadePersonalizada;
            //Data.RowData.dbRow.FieldByName['flag_tacbm'].AsInteger := Integer(AcabamentoOpcional);
            //Data.RowData.dbRow.FromDb                  := True;
          finally
            Release;
          end;
        end;
      end;
  end;
end;

procedure TfmConfigurador.stComponentesEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
end;

function TfmConfigurador.AcabamentoDeleted(aRow: TDataRow): Boolean;
begin
  Result := False;
  if aRow = nil then exit;
  try
    with dmSysConf do
    begin
      if Referencia.Active then Referencia.Close;
      Referencia.SQL.Clear;
      Referencia.SQL.Add(SqlDeleteReferencia);
      Dados.StartTransaction(Referencia);
      Referencia.ParamByName('FkEmpresas').AsInteger        := FFkEmpresas;
      Referencia.ParamByName('FkProdutos').AsInteger        := FFkProdutos;
      Referencia.ParamByName('FkTipoComponentes').AsInteger := aRow.FieldByName['fk_tipo_componentes'].AsInteger;
      Referencia.ParamByName('FkTipoAcabamentos').AsInteger := aRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
      Referencia.ExecSql;
      if Acabamento.Active then Acabamento.Close;
      Acabamento.SQL.Clear;
      Acabamento.Params.Clear;
      Acabamento.SQL.Add(SqlDeleteAcabamentos);
      Acabamento.ParamByName('FkProdutos').AsInteger        := FFkProdutos;
      Acabamento.ParamByName('FkComponentes').AsInteger     := aRow.FieldByName['fk_tipo_componentes'].AsInteger;
      Acabamento.ParamByName('FkTipoAcabamentos').AsInteger := aRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
      Acabamento.ExecSql;
      Result := True;
      Dados.CommitTransaction(Referencia);
    end;
  except on E:Exception do
    begin
      Dados.RollbackTransaction(dmSysConf.Referencia);
      MessageBox(Self.Handle, PChar(E.Message), PChar(Caption), MB_ICONSTOP);
    end;
  end;
end;

function TfmConfigurador.ComponenteDeleted(aRow: TDataRow): Boolean;
begin
  Result := False;
  if aRow = nil then exit;
  try
    with dmSysConf do
    begin
      if Componente.Active then Componente.Close;
      Componente.SQL.Clear;
      Componente.SQL.Add(SqlDeleteRefComp);
      Dados.StartTransaction(Componente);
      Componente.ParamByName('FkEmpresas').AsInteger    := FFkEmpresas;
      Componente.ParamByName('FkProdutos').AsInteger    := FFkProdutos;
      Componente.ParamByName('FkComponentes').AsInteger := aRow.FieldByName['fk_tipo_componentes'].AsInteger;
      Componente.ExecSql;
      if Acabamento.Active then Acabamento.Close;
      Acabamento.SQL.Clear;
      Acabamento.SQL.Add(SqlDeleteCompAcabam);
      Acabamento.ParamByName('FkProdutos').AsInteger    := FFkProdutos;
      Acabamento.ParamByName('FkComponentes').AsInteger := aRow.FieldByName['fk_tipo_componentes'].AsInteger;
      Acabamento.ExecSql;
      if Componente.Active then Componente.Close;
      Componente.SQL.Clear;
      Componente.SQL.Add(SqlDeleteComponente);
      Componente.ParamByName('FkProdutos').AsInteger         := FFkProdutos;
      Componente.ParamByName('FkTipoComponentes').AsInteger := aRow.FieldByName['fk_tipo_componentes'].AsInteger;
      Componente.ExecSql;
      Result := True;
      Dados.CommitTransaction(Componente);
    end;
  except on E:Exception do
    begin
      Dados.RollbackTransaction(dmSysConf.Componente);
      MessageBox(Self.Handle, PChar(E.Message), PChar(Caption), MB_ICONSTOP);
    end;
  end;
end;

function TfmConfigurador.ReferenciaDeleted(aRow: TDataRow): Boolean;
begin
  Result := False;
  if aRow = nil then exit;
  try
    with dmSysConf do
    begin
      if Referencia.Active then Referencia.Close;
      Referencia.SQL.Clear;
      Referencia.SQL.Add(SqlDeleteRefCompleta);
      Dados.StartTransaction(Referencia);
      Referencia.ParamByName('FkEmpresas').AsInteger        := FFkEmpresas;
      Referencia.ParamByName('FkProdutos').AsInteger        := FFkProdutos;
      Referencia.ParamByName('FkComponentes').AsInteger     := aRow.FieldByName['fk_tipo_componentes'].AsInteger;
      Referencia.ParamByName('FkAcabamentos').AsInteger     := aRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
      Referencia.ParamByName('FkTipoReferencias').AsInteger := aRow.FieldByName['fk_tipo_referencias'].AsInteger;
      Referencia.ExecSql;
      Result := True;
      Dados.CommitTransaction(Referencia);
    end;
  except on E:Exception do
    begin
      Dados.RollbackTransaction(dmSysConf.Referencia);
      MessageBox(Self.Handle, PChar(E.Message), PChar(Caption), MB_ICONSTOP);
    end;
  end;
end;

procedure TfmConfigurador.stComponentesResize(Sender: TObject);
begin
  stComponentes.Header.Columns[0].Width := stComponentes.Width -
                                           stComponentes.Header.Columns[1].Width-
                                           stComponentes.Header.Columns[2].Width-25;
end;

procedure TfmConfigurador.stComponentesGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if ((Column<>0)Or(Node = nil) or (not(Kind in [ikNormal,ikSelected]))) then exit;
  Ghosted := False;
  case stComponentes.GetNodeLevel(Node) of
    0: ImageIndex := Integer(Sender.Expanded[Node]);
    1: ImageIndex := 2 + Integer(Sender.Expanded[Node]);
    2: ImageIndex := 4;
  end;
end;

procedure TfmConfigurador.stPrecosResize(Sender: TObject);
begin
  stPrecos.Header.Columns[0].Width := stPrecos.Width-stPrecos.Header.Columns[1].Width - stPrecos.Header.Columns[2].Width - 25;
end;

procedure TfmConfigurador.stPrecosGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data              : PTreeData;
  TotalAcabamento   : TAcabamentoTotals;
  S                 : String;
  Ix                : Integer;
begin
  if Node = nil then exit;
  Data := stPrecos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
     (Data.RowData.Level>Ord(High(TPrecoLevelType)))) then exit;
  case Column of
    0: CellText := Data.RowData.dbRow.FieldByName[PrecoDescFieldName[TPrecoLevelType(Data.RowData.Level)]].AsString;
    1: if Data.RowData.Level = Ord(pltTabela) then
         CellText:=FormatFloat('#,##0.00',Data.RowData.dbRow.FieldByName['Preco'].AsFloat)
        // JOP 08.09.03 else CellText:='';
       else
          CellText := FormatFloat('#,##0.00',Data.RowData.dbRow.FieldByName['Preco'].AsFloat);
    2:if Data.RowData.Level<1 Then
         begin
          S  := FormatFloat('00000000',Data.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger);
          Ix := FslAcabamentos.IndexOf(S);
          if Ix > -1 then
             begin
               TotalAcabamento:=TAcabamentoTotals(FslAcabamentos.Objects[Ix]);
               if TotalAcabamento<>Nil Then
                  CellText:=FormatFloat('#,##0.00',TotalAcabamento.QtdTotal)
               else CellText:='';
             end
          else CellText:='';
         end
      else CellText:='';
  end;
end;

procedure TfmConfigurador.stPrecosGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if ((Node = nil) or (not(Kind in [ikNormal,ikSelected])) or (Column<>0)) then exit;
  Ghosted := False;
  case stPrecos.GetNodeLevel(Node) of
    0: ImageIndex := Integer(Sender.Expanded[Node]);
    1: ImageIndex := 2 + Integer(Sender.Expanded[Node]);
    2: ImageIndex := 5;
  end;
end;

procedure TfmConfigurador.stPrecosEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  Data: PTreeData;
begin
// JOP 08.09.03   Allowed:=((Node <> nil) and (Column=1) and (stPrecos.GetNodeLevel(Node)=Cardinal(Ord(pltTabela))) and (Node.Parent <> nil) and (stPrecos.CheckState[Node.Parent]=csCheckedNormal));
  Allowed := ((Node <> nil) and (Column=1) and
             (stPrecos.GetNodeLevel(Node) = Cardinal(Ord(pltTabela))) and
             (Node.Parent <> nil));
  if not(Allowed) then exit;
  Data := stPrecos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
     (Data.RowData.dbRow.FieldByName['fk_tabela_precos'].AsInteger < 1)) then
    Allowed := False;
end;

procedure TfmConfigurador.stPrecosNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  V   : Double;
  Data: PTreeData;
begin
  if ((Node = nil) or (Column <> 1) or
     (stPrecos.GetNodeLevel(Node) <> Cardinal(Ord(pltTabela)))) then
    exit;
  Data := stPrecos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil) or
     (Data.RowData.Level <> Ord(pltTabela))) then
    exit;
  V := StrToFloatDef(NewText, 0);
  if V < 0 then V := 0;
  if V = Data.RowData.dbRow.FieldByName['Preco'].AsFloat then exit;
  Data.RowData.dbRow.FieldByName['Preco'].AsFloat := V;
  cmdUpdateAcabamentos.Enabled := True;
end;

function TfmConfigurador.AcabamentosUpdated(DestFkProdutos:Integer=0):Boolean;
var
  I              : Integer;
  RowData        : TRowData;
  fkProdutosToUse: Integer;
begin
  Result := False;
  stPrecos.EndEditNode;
  if DestfkProdutos > 0 then
    fkProdutosToUse := DestfkProdutos
  else
    fkProdutosToUse := FFkProdutos;
  if fkProdutosToUse < 1 then exit;
  Dados.StartTransaction(dmSysConf.Precos);
  try
    with dmSysConf do
    begin
      if Precos.Active then Precos.Close;
      Precos.SQL.Clear;
      Precos.SQL.Add(SqlDeleteAcabamPreco);
      Precos.ParamByName('FkEmpresas').AsInteger := FFkEmpresas;
      Precos.ParamByName('FkProdutos').AsInteger := fkProdutosToUse;
      Precos.ExecSql;
    end;
    for I := 0 to FslPrecos.Count - 1 do
    begin
      RowData := TRowData(FslPrecos[I]);
      if ((RowData <> nil)                    and (RowData.Level=Ord(pltTabela)) and
         (RowData.dbRow <> nil)               and (RowData.Node <> nil)          and
         (stPrecos.IsVisible[RowData.Node])   and (RowData.Node.Parent <> nil)   and
         (RowData.dbRow.FieldByName['Preco'].AsFloat > 0) and (stPrecos.IsVisible[RowData.Node.Parent])) then
      begin
        if RowData.dbRow.FieldByName['fk_tabela_precos'].AsInteger < 1 then
        else
        begin
          with dmSysConf do
          begin
            if Precos.Active then Precos.Close;
            Precos.SQL.Clear;
            Precos.Params.Clear;
            Precos.SQL.Add(SqlInsertAcabamentos);
            Precos.ParamByName('FkEmpresas').AsInteger        := FFkEmpresas;
            Precos.ParamByName('FkProdutos').AsInteger        := fkProdutosToUse;
            Precos.ParamByName('FkTipoAcabamentos').AsInteger := RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
            Precos.ParamByName('FkTipoReferencias').AsInteger := RowData.dbRow.FieldByName['fk_tipo_referencias'].AsInteger;
            Precos.ParamByName('FkTabelaPrecos').AsInteger    := RowData.dbRow.FieldByName['fk_tabela_precos'].AsInteger;
            Precos.ParamByName('PreVda').AsFloat              := RowData.dbRow.FieldByName['preco'].AsFloat;
            Precos.ExecSql;
          end;
        end;
      end;
    end;
    cmdUpdateAcabamentos.Enabled := False;
    Result := True;
    Dados.CommitTransaction(dmSysConf.Precos);
  except on E:Exception do
    begin
      Dados.RollbackTransaction(dmSysConf.Precos);
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TfmConfigurador.cmdUpdateAcabamentosClick(Sender: TObject);
begin
  if AcabamentosUpdated then ;
end;

procedure TfmConfigurador.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  stPrecos.EndEditNode;
  CanClose := MayChangeProduto;
end;

procedure TfmConfigurador.stPrecosChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  if FInsideMove then exit;
  cmdUpdateAcabamentos.Enabled := True;
end;

procedure TfmConfigurador.RefreshVisibility;
var
  I      : Integer;
  S      : string;
  RowData: TRowData;
begin
  for I := 0 to FslPrecos.Count - 1 do
  begin
    RowData := TRowData(FslPrecos[I]);
    if ((RowData <> nil) and (RowData.Level > -1) and
       (RowData.Level <= Ord(pltTabela))          and
       (RowData.dbRow <> nil) and (RowData.Node <> nil)) then
      case TPrecoLevelType(RowData.Level) of
        pltAcabamento:
          begin
            S := FormatFloat('00000000',RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger);
            stPrecos.IsVisible[RowData.Node] := (FslAcabamentos.IndexOf(S)>-1);
          end;
        pltReferencia :
          begin
            S := FormatFloat('00000000',RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger)+
            FormatFloat('00000000',RowData.dbRow.FieldByName['fk_tipo_referencias'].AsInteger);
            stPrecos.IsVisible[RowData.Node] := (FslReferencias.IndexOf(S) > -1);
            // JOP 08.09.03 if not(stPrecos.IsVisible[RowData.Node]) then
            // JOP 08.09.03    stPrecos.CheckState[RowData.Node]:=csUnCheckedNormal;
          end;
        pltTabela    :
          begin
            if ((RowData.dbRow.FieldByName['fk_Tabela_Precos'].AsInteger > 0) and
               (RowData.Node.Parent <> nil)                       and
               (not ((stPrecos.IsVisible[RowData.Node])           and
               (stPrecos.IsVisible[RowData.Node.Parent]))))       then
              RowData.dbRow.FieldByName['Preco'].AsFloat := 0;
          end;
      end;
  end;
end;

procedure TfmConfigurador.cmdExpandComponenteClick(Sender: TObject);
var
  tr: TVirtualStringTree;
begin
  if Sender = cmdExpandComponente then
    tr := stComponentes
  else
    tr := stPrecos;
  tr.FullExpand;
end;

procedure TfmConfigurador.cmdCollapseComponenteClick(Sender: TObject);
var
  tr: TVirtualStringTree;
begin
  if Sender = cmdCollapseComponente then
    tr := stComponentes
  else
    tr := stPrecos;
  tr.FullCollapse;
end;

procedure TfmConfigurador.cbGruposClick(Sender: TObject);
begin
  if not(MayChangeProduto) then exit;
  if cbGrupos.ItemIndex < 0 then exit;
  FFkGrupos := LongInt(cbGrupos.Items.Objects[cbGrupos.ItemIndex]);
  LoadProdutos;
  if cbProdutos.Items.Count < 1 then exit;
  cbProdutos.ItemIndex := 0;
  if Assigned(cbProdutos.OnClick) then cbProdutos.OnClick(Self);
end;

procedure TfmConfigurador.ClearImage;
begin
  imProduto.Picture := nil;
end;

procedure TfmConfigurador.LoadImage;
const
  NAME_BLOB = 'IMG_PROD';
begin
  ClearImage;
  if FFkProdutos < 1 then exit;
  with dmSysConf do
  begin
    if Produtos.Active then Produtos.Close;
    Produtos.SQL.Clear;
    Produtos.SQL.Add(SqlPkProdutos);
    try
      Produtos.ParamByName('FkProdutos').AsInteger  := FFkProdutos;
      if not Produtos.Active then Produtos.Open;
      if Produtos.IsEmpty then exit;
      if (Produtos.FindField(NAME_BLOB) <> nil) then
        if (Produtos.FindField(NAME_BLOB).IsBlob) then
          if (not Produtos.FindField(NAME_BLOB).IsNull) then
        GetImage_FromStream(TBlobField(Produtos.FindField(NAME_BLOB)), imProduto);
    finally
      if Produtos.Active then Produtos.Close;
    end;
  end;
end;

procedure TfmConfigurador.mCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmConfigurador.miCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmConfigurador.sbCompanyClick(Sender: TObject);
begin
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    SelEmpresa.Free;
  end;
  FkEmpresas := Dados.PkCompany;
end;

procedure TfmConfigurador.miAboutClick(Sender: TObject);
begin
  Application.CreateForm(TfrmAboutProcessa, frmAboutProcessa);
  try
    frmAboutProcessa.ShowModal;
  finally
    if Assigned(frmAboutProcessa) then
      frmAboutProcessa.Free;
    frmAboutProcessa := nil;
  end;
end;

procedure TfmConfigurador.cbFk_LinhasClick(Sender: TObject);
begin
  if not(MayChangeProduto) then exit;
  if cbfk_Linhas.ItemIndex < 0 then exit;
  FFkLinhas := LongInt(cbfk_Linhas.Items.Objects[cbfk_Linhas.ItemIndex]);
  LoadProdutos;
  if cbProdutos.Items.Count < 1 then exit;
  cbProdutos.ItemIndex := 0;
  if Assigned(cbProdutos.OnClick) then cbProdutos.OnClick(Self);
end;

procedure TfmConfigurador.miOperationsClick(Sender: TObject);
var
  CurrNode       : PVirtualNode;
  ComponenteLevel: TComponenteLevelType;
  Ix             ,
  CurrLevel      : Integer;
begin
  CurrNode := stComponentes.FocusedNode;
  if CurrNode <> nil then CurrLevel := stComponentes.GetNodeLevel(CurrNode)
  else CurrLevel := -1;
  miOperations.Items[FFirstDymMainMenuItem].Visible := (cbProdutos.ItemIndex>-1);
  for ComponenteLevel:=Succ(Low(TComponenteLevelType)) to High(TComponenteLevelType) do
  begin
    Ix := FFirstDymMainMenuItem + Ord(ComponenteLevel);
    miOperations.Items[Ix].Visible := ((miOperations.Items[Ix-1].Visible) and
                                      (CurrNode <> nil)                    and
                                      (CurrLevel >= Ord(Pred(ComponenteLevel))));
  end;
  if FMaincmDelete <> nil then
  begin
    FMaincmDelete.Visible := (CurrNode <> nil);
    if FMaincmDelete.Visible then
      FMaincmDelete.Caption := DELETE_CAPTION + ' ' +
                               LevelCaption[TComponenteLevelType(CurrLevel)];
  end;
  if FMaincmProperties <> nil then
  begin
    FMaincmProperties.Visible := ((FMaincmDelete <> nil) and (FMaincmDelete.Visible));
    if FMaincmProperties.Visible then
      FMaincmProperties.Caption := PROPERTIES_CAPTION + ' ' +
                                   LevelCaption[TComponenteLevelType(CurrLevel)];
  end;
  if FMaincmDelimiter1 <> nil then
    FMaincmDelimiter1.Visible := ((FMaincmDelete <> nil) and (FMaincmDelete.Visible));
  if FMaincmDelimiter2 <> nil then
    FMaincmDelimiter2.Visible := ((FMaincmDelimiter1 <> nil) and (FMaincmDelimiter1.Visible));
end;

procedure TfmConfigurador.CopyComponentStruct(fkProdutosFrom, fkProdutosTo:Integer);
var
  ComponentsCopied: Integer;
begin
  ComponentsCopied := -2;
  try
    with dmSysConf do
    begin
      if CopyStruct.Active then CopyStruct.Close;
      CopyStruct.SQL.Clear;
      CopyStruct.SQL.Add(SqlCopyStruct);
      Dados.StartTransaction(CopyStruct);
      try
        CopyStruct.ParamByName('fk_empresas').AsInteger    := FFkEmpresas;
        CopyStruct.ParamByName('fkProdutosFrom').AsInteger := fkProdutosFrom;
        CopyStruct.ParamByName('fkProdutosTo').AsInteger   := fkProdutosTo;
        if CopyStruct.Active then CopyStruct.Open;
        if not (CopyStruct.EOF) then
          ComponentsCopied := CopyStruct.FieldByName('TOTAL_COMPONENTES_INCLUIDOS').AsInteger;
      finally
        if CopyStruct.Active then CopyStruct.Close;
        Dados.CommitTransaction(CopyStruct);
      end;
      if ComponentsCopied > 0 then
        MessageBox(Self.Handle, PChar(Dados.GetStringMessage(LANGUAGE,
          'sStructCopy', 'Estrutura copiada com sucesso !')),
          PChar(Caption), MB_ICONINFORMATION)
      else
        if ComponentsCopied = 0 then
          MessageBox(Self.Handle, PChar(Dados.GetStringMessage(LANGUAGE,
            'sStructEmpty', 'A Estrutura a ser copiada estava vazia !')),
            PChar(Caption),MB_ICONWARNING)
        else
          MessageBox(Self.Handle, PChar(Dados.GetStringMessage(LANGUAGE,
            'sProductFuly', 'O Produto de Destino já possui componentes !')),
            PChar(Caption),MB_ICONSTOP);
    end;
  except on exception do
    begin
      Dados.RollbackTransaction(dmSysCOnf.CopyStruct);
      raise;
    end;
  end;
end;

procedure TfmConfigurador.SearchReferencia(aSearchType: TReferenciaSearchType = stSearch);
var
  aFkProdutos,
  aFkLinhas  ,
  aFkSecoes  ,
  aFkGrupos  : Integer;
begin
  with TfmSearchReferencia.Create(Self) do
    try
      SearchType := aSearchType;
      fkEmpresas := Self.FFkEmpresas;
      Referencia := FLastReferencia;
      fkProdutos := Self.FFkProdutos;
      if ShowModal <> mrOk then exit;
      FLastReferencia := Referencia;
      aFkLinhas   := FkLinhas;
      aFkSecoes   := FkSecoes;
      aFkGrupos   := FkGrupos;
      aFkProdutos := FkProdutos;
    finally
      Release;
    end;
  if aSearchType = stSearch then
    LocateAndShowProduto(aFkProdutos, aFkLinhas, aFkSecoes, aFkGrupos)
  else
  begin
    CopyComponentStruct(FFkProdutos, aFkProdutos);
    if AcabamentosUpdated(aFkProdutos) then ;
  end;
end;

procedure TfmConfigurador.miSearchByReferenceClick(Sender: TObject);
begin
  SearchReferencia;
end;

procedure TfmConfigurador.miCopyStructToClick(Sender: TObject);
begin
  if cbProdutos.ItemIndex < 0 then exit;
  if not(MayChangeProduto) then exit;
  SearchReferencia(stCopy);
end;

procedure TfmConfigurador.ClearAcabamentos;
var
  I: Integer;
begin
  if ((FslAcabamentos = nil) or (FslAcabamentos.Count < 1)) then exit;
  for I := 0 to FslAcabamentos.Count-1 do
    if FslAcabamentos.Objects[I] <> nil then
    begin
      TAcabamentoTotals(FslAcabamentos.Objects[I]).Free;
      FslAcabamentos.Objects[I] := nil;
    end;
  FslAcabamentos.Clear;
end;

{ TAcabamentoTotals }

constructor TAcabamentoTotals.Create(ATotalEntries: Integer; AQtdTotal:Double);
begin
  inherited Create;
  FTotalEntries := ATotalEntries;
  FQtdTotal    := AQtdTotal;
end;

destructor TAcabamentoTotals.Destroy;
begin
  inherited Destroy;
end;

procedure TfmConfigurador.stComponentesInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
  if ((Node<>Nil)And(stComponentes.GetNodeLevel(Node)=2)) Then
     Node.CheckType:=ctCheckBox;
end;

procedure TfmConfigurador.stComponentesChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var Data        : PTreeData;
begin
  if ((Node = nil) or (Sender = nil) or (Sender.GetNodeLevel(Node) <> 2)) then exit;
  Data := Sender.GetNodeData(Node);
  Data.RowData.dbRow.FieldByName['flag_ativo'].AsInteger := Integer(Node.CheckState = csCheckedNormal);
  Screen.Cursor := crHourGlass;
  with dmSysConf do
  begin
    if Referencia.Active then Referencia.Close;
    Referencia.SQL.Clear;
    Referencia.Params.Clear;
    Referencia.SQL.Add(SqlUpdateReferencias);
    Dados.StartTransaction(Referencia);
    try
      Referencia.ParamByName('FkEmpresas').AsInteger         := FFkEmpresas;
      Referencia.ParamByName('FkProdutos').AsInteger         := FFkProdutos;
      Referencia.ParamByName('FkTipoComponentes').AsInteger  := Data.RowData.dbRow.FieldByName['fk_tipo_componentes'].AsInteger;
      Referencia.ParamByName('FkTipoAcabamentos').AsInteger  := Data.RowData.dbRow.FieldByName['fk_tipo_acabamentos'].AsInteger;
      Referencia.ParamByName('FkTipoReferencias').AsInteger  := Data.RowData.dbRow.FieldByName['fk_tipo_referencias'].AsInteger;
      Referencia.ParamByName('FlagAtivo').AsInteger          := Data.RowData.dbRow.FieldByName['flag_ativo'].AsInteger;
      Referencia.ExecSql;
    finally
      if Referencia.Active then Referencia.Close;
      Dados.CommitTransaction(Referencia);
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TfmConfigurador.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    FCompanyClick := False;
    SelEmpresa.Free;
    SelEmpresa := nil;
  end;
  sbStatus.Repaint;
end;

procedure TfmConfigurador.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  if (not (Panel.Index in [1, 2])) then exit;
  StatusBar.Canvas.Brush.Color := clBtnFace;
  StatusBar.Canvas.Font.Style  := [fsBold];
  StatusBar.Canvas.Font.Name := 'Arial';
  StatusBar.Canvas.FillRect(Rect);
  if (Panel.Index = 1) then
  begin
    FRect := Rect;
    StatusBar.Canvas.Font.Color := ClNavy;
    Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
    StatusBar.Canvas.TextOut(Rect.Left + 22, Rect.Top + 1,'Empresa: ' +
      IntToStr(Dados.PkCompany) + ' / ' + Dados.NameCompany);
  end;
  if Panel.Index = 2 then
  begin
//    StatusBar.Canvas.Font.Color  := FontColorMode[FScrState];
//    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[dbmBrowse]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[dbmBrowse]);
  end;
end;

procedure TfmConfigurador.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

initialization
  RegisterClass(TfmConfigurador);
end.
