unit CadPecas;

{*************************************************************************}
{*                                                                       *}
{* Author: CSD Informatica Ltda.                                         *}
{* Copyright: © 2003 by CSD Informatica Ltda. All rights reserved.       *}
{* Created: 02/06/2003                                                   *}
{* Modified: 17/12/2003                                                  *}
{* Author: Alcindo Schleder                                              *}
{* Version: 2.0.0.0                                                      *}
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
  Dialogs, CadMod, SyncSource, QExportDialog, Enter, DB, Menus, Buttons,
  StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin, Mask,
  ExtDlgs, Encryp, JvToolEdit, JvCurrEdit, JvDBCtrl, CheckLst, VirtualTrees,
  CSDVirtualStringTree, ToolEdit, RxLookup, IBQuery, DlgVersion, RXDBCtrl;

type
  TFichaRec = record
    FkPecas       : Integer;
    ObsPec        : WideString;
    DscPec        : string;
    AltPec        : Double;
    LargPec       : Double;
    ProfPec       : Double;
    FlagTImg      : smallint;
    FlagTComp     : smallint;
  end;

  TCdPecas = class(TCdModelo)
    Secoes: TDataSource;
    Grupos: TDataSource;
    popImgIns              : TPopupMenu;
    cmSelectImage          : TMenuItem;
    cmDelImage             : TMenuItem;
    stPartName: TStaticText;
    op: TOpenPictureDialog;
    SubGrupos: TDataSource;
    Almoxarifados: TDataSource;
    Pecas: TDataSource;
    pgControl: TPageControl;
    tsParts: TTabSheet;
    pcMaterials: TPageControl;
    tsDescription: TTabSheet;
    lDsc_Pec: TLabel;
    lFk_Secoes: TLabel;
    lFk_Grupos: TLabel;
    lFk_SubGrupos: TLabel;
    lAlt_Pec: TLabel;
    lProf_Pec: TLabel;
    lLarg_Pec: TLabel;
    lFk_Pecas: TLabel;
    lCod_Ref: TLabel;
    sbGetRef: TSpeedButton;
    eDsc_Pec: TDBEdit;
    eFk_Grupos: TDBLookupComboBox;
    eFk_Secoes: TDBLookupComboBox;
    eFk_SubGrupos: TDBLookupComboBox;
    eAlt_Pec: TJvDBCalcEdit;
    eProf_Pec: TJvDBCalcEdit;
    eLarg_Pec: TJvDBCalcEdit;
    pPanel: TPanel;
    imImg_Pec: TImage;
    lImg_Pec: TStaticText;
    lFlag_TComp: TDBRadioGroup;
    eFk_Pecas: TDBEdit;
    eCod_Ref: TDBEdit;
    tsVersion: TTabSheet;
    lDta_Last_Prd: TLabel;
    lDta_First_Lib: TLabel;
    lDta_Last_Lib: TLabel;
    lMaj_Ver: TLabel;
    lMin_Ver: TLabel;
    lPk_Ficha_Tecnica: TLabel;
    lMot_NVer: TLabel;
    eDta_Last_Prd: TDBDateEdit;
    eDta_First_Lib: TDBDateEdit;
    eDta_Last_Lib: TDBDateEdit;
    lFlag_Atv: TDBCheckBox;
    lFlag_Op: TDBCheckBox;
    eMaj_Ver: TDBEdit;
    eMin_Ver: TDBEdit;
    ePk_Ficha_Tecnica: TDBEdit;
    eMot_NVer: TDBEdit;
    tsComplement: TTabSheet;
    Panel4: TPanel;
    eObs_Pec: TDBMemo;
    lObs_Pec: TStaticText;
    tsCosts: TTabSheet;
    lDta_Prv_Prd: TLabel;
    lQtd_Dias_Estq: TLabel;
    lQtd_Cns_Med: TLabel;
    lQtd_EPrd: TLabel;
    lQtdEstq: TLabel;
    lQtdMin: TLabel;
    lQtdMax: TLabel;
    lQtd_UPrd: TLabel;
    lDtaUInv: TLabel;
    lDtaURsv: TLabel;
    eDta_Prv_Prd: TJvDBDateEdit;
    eQtd_Dias_Estq: TJvDBCalcEdit;
    eQtd_Cns_Med: TJvDBCalcEdit;
    eQtd_EPrd: TJvDBCalcEdit;
    eQtdEstq: TJvDBCalcEdit;
    eQtdMin: TJvDBCalcEdit;
    eQtdMax: TJvDBCalcEdit;
    eDta_UPrd: TJvDBDateEdit;
    eDtaUInv: TJvDBDateEdit;
    eDtaURsv: TJvDBDateEdit;
    pHistoric: TPanel;
    vtHistoric: TCSDVirtualStringTree;
    tsSupply: TTabSheet;
    lFk_Almoxarifados: TLabel;
    gbQuantity: TGroupBox;
    lQtd_EMax: TLabel;
    lQtd_EMin: TLabel;
    lDta_UInv: TLabel;
    lDta_URsv: TLabel;
    lQtd_Estq: TLabel;
    lDta_UMov: TLabel;
    eQtd_EMax: TJvDBCalcEdit;
    eQtd_EMin: TJvDBCalcEdit;
    eDta_UInv: TJvDBDateEdit;
    eDta_URsv: TJvDBDateEdit;
    eQtd_Estq: TJvDBCalcEdit;
    eDta_UMov: TJvDBDateEdit;
    pCapacities: TPanel;
    sbCapSave: TSpeedButton;
    sbCapDelete: TSpeedButton;
    sbCapCancel: TSpeedButton;
    vtCapacities: TCSDVirtualStringTree;
    eFk_Almoxarifados: TDBLookupComboBox;
    lQtd_Rsrv: TLabel;
    eQtd_Rsrv: TJvDBCalcEdit;
    lDta_USld: TLabel;
    eDta_USld: TJvDBDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure imImg_PecDblClick(Sender: TObject);
    procedure cmDelImageClick(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure miFindClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pgControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pgControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure vtTreeEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean); override;
    procedure tbCloseClick(Sender: TObject);
    procedure sbGetRefClick(Sender: TObject);
    procedure PecaAfterOpen(Sender: TObject);
    procedure sbCapCancelClick(Sender: TObject);
    procedure sbCapDeleteClick(Sender: TObject);
    procedure sbCapSaveClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure vtHistoricEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
  private
    { Private declarations }
    FFichaTecnica: TFichaRec;
    FEdit        : Boolean;
    FFkPecas     : Integer;
    FPkFicha     : Integer;
    FCodRef      : string;
    NAME_BLOB    : string;
    FSqlPeca     : string;
    FTypeMod     : TTypeMod;
    procedure ConfigPeca;
    procedure ConfigPecaCusto;
    procedure ConfigPecaEstoque;
    procedure HandleReportBeforeOpen(DataSet:TDataSet);
    procedure HandlePecaAfterScroll;
    procedure HandlePecaEstoquesAfterScroll;
    function  SaveRecords(DataSetName: string): Boolean;
  protected
    { Protected declarations }
    procedure FechaArquivos(DS: TDataSource); override;
    procedure PesquisaRegistros; override;
    procedure DBStatusChange; override;
  public
    { Public declarations }
  end;

var
  CdPecas: TCdPecas;

implementation

uses ArqSql, mSysPCP, Dado, ProcType, CmmConst, Funcoes, FuncoesDB, ModelTyp;

{$R *.dfm}

procedure TCdPecas.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  eSearch.CharCase := ecUpperCase;
  vtCapacities.RootNodeCount := 0;
  CheckFilterCount := True;
  FEdit := False;
end;

procedure TCdPecas.FormActivate(Sender: TObject);
begin
  SetDataAwareLink(nil, 0);
  if pgControl.ActivePage <> tsParts then
    pgControl.ActivePage := tsParts;
  ConfigPeca;
  SetDataAwareLink(@dsMain, 0);
  Search           := True;
  DefaultSQLOnly   := False;
  inherited;
  tsParts.Caption          := Dados.GetStringMessage(LANGUAGE,'stsParts','Peças');
  tsDescription.Caption    := Dados.GetStringMessage(LANGUAGE,'stsDescription','Descrição');
  tsComplement.Caption     := Dados.GetStringMessage(LANGUAGE,'stsComplement','Complemento');
  tsSupply.Caption         := Dados.GetStringMessage(LANGUAGE,'stsSupply','Estoques');
  tsVersion.Caption        := Dados.GetStringMessage(LANGUAGE,'stsVersion','Dados da Versão');
  gbQuantity.Caption       := Dados.GetStringMessage(LANGUAGE,'sgbQuantity','Quantidades');
  pCapacities.Caption      := Dados.GetStringMessage(LANGUAGE,'spCapacities','Lotações:');
  Dados.Image16.GetBitmap(30, sbGetRef.Glyph);
  Dados.Image16.GetBitmap(36, sbCapSave.Glyph);
  Dados.Image16.GetBitmap(33, sbCapDelete.Glyph);
  Dados.Image16.GetBitmap(28, sbCapCancel.Glyph);
  stPartName.Caption   := '...';
  dmSysPCP.AFindRecord := False;
  FFkPecas := 0;
  FPkFicha := 0;
  FCodRef  := '';
  AfterOpen := PecaAfterOpen
end;

procedure TCdPecas.FechaArquivos(DS: TDataSource);
begin
  with dmSysPCP do
  begin
    if Secoes.Active           then Secoes.Close;
    if Grupos.Active           then Grupos.Close;
    if SubGrupos.Active        then SubGrupos.Close;
    if PecLotacoes.Active      then PecLotacoes.Close;
    if Almoxarifados.Active    then Almoxarifados.Close;
  end;
  inherited;
end;

procedure TCdPecas.PesquisaRegistros;
begin
  inherited;
  with dmSysPCP do
  begin
    if pgControl.ActivePageIndex = 0 then
    begin
      if not Secoes.Active then
      begin
        Secoes.SQL.Clear;
        Secoes.SQL.Add(SqlSecoesPec);
        Secoes.Open;
      end;
      if not Grupos.Active then
      begin
        Grupos.SQL.Clear;
        Grupos.SQL.Add(SqlGrupos);
        Grupos.Open;
      end;
      if not SubGrupos.Active then
      begin
        SubGrupos.SQL.Clear;
        SubGrupos.SQL.Add(SqlSubGrupos);
        SubGrupos.Open;
      end;
    end;
    if pgControl.ActivePageIndex = 1 then
    begin
      if not Almoxarifados.Active then
      begin
        Almoxarifados.SQL.Clear;
        Almoxarifados.SQL.Add(SqlAlmoxarifados);
        Almoxarifados.Open;
      end;
    end;
  end;
end;

procedure TCdPecas.DBStatusChange;
begin
  if (DBStatus = dbmEdit) and ((lFlag_Atv.Checked) or (lFlag_Op.Checked))then
  begin
    FEdit := True;
    DBStatus := dbmCancel;
    tbInsert.Click;
  end;
  inherited;
end;

procedure TCdPecas.tbInsertClick(Sender: TObject);
var
  ShowResult: Integer;
begin
  Application.CreateForm(TdgVersion, dgVersion);
  try
    dgVersion.Caption  := Caption;
    dgVersion.CodPart  := dmSysPCP.FkPeca;
    dgVersion.CodFicha := dmSysPCP.FkFichaTecnica;
    dgVersion.RefPart  := dmSysPCP.CodRef;
    dgVersion.MinVer   := dmSysPCP.MinVer;
    dgVersion.MajVer   := dmSysPcp.MajVer;
    dgversion.lRefPart.Caption := lCod_Ref.Caption;
    ShowResult         := dgVersion.ShowModal;
    if FEdit then
    begin
      FFichaTecnica.FkPecas   := dmSysPCP.FichaTecn.FindField('FK_PECAS').AsInteger;
      FFichaTecnica.ObsPec    := dmSysPCP.FichaTecn.FindField('OBS_PEC').AsString;
      FFichaTecnica.DscPec    := dmSysPCP.FichaTecn.FindField('DSC_PEC').AsString;
      FFichaTecnica.AltPec    := dmSysPCP.FichaTecn.FindField('ALT_PEC').AsFloat;
      FFichaTecnica.LargPec   := dmSysPCP.FichaTecn.FindField('LARG_PEC').AsFloat;
      FFichaTecnica.ProfPec   := dmSysPCP.FichaTecn.FindField('PROF_PEC').AsFloat;
      FFichaTecnica.FlagTImg  := dmSysPCP.FichaTecn.FindField('FLAG_TIMG').AsInteger;
      FFichaTecnica.FlagTComp := dmSysPCP.FichaTecn.FindField('FLAG_TCOMP').AsInteger;
      dmSysPCP.CodRef         := dgVersion.RefPart;
    end;
    dmSysPCP.MajVer   := dgVersion.MajVer;
    dmSysPCP.MinVer   := dgVersion.MinVer;
    FTypeMod          := dgVersion.TypeMod;
  finally
    FreeAndNil(dgVersion);
  end;
  if ShowResult = mrCancel then exit;
  inherited;
  if pgControl.ActivePageIndex = 0 then
  begin
    if FEdit then
    begin
      FEdit := False;
      dmSysPCP.FichaTecn.FindField('FK_PECAS').AsInteger   := FFichaTecnica.FkPecas;
      dmSysPCP.FichaTecn.FindField('OBS_PEC').AsString     := FFichaTecnica.ObsPec;
      dmSysPCP.FichaTecn.FindField('DSC_PEC').AsString     := FFichaTecnica.DscPec;
      dmSysPCP.FichaTecn.FindField('ALT_PEC').AsFloat      := FFichaTecnica.AltPec;
      dmSysPCP.FichaTecn.FindField('LARG_PEC').AsFloat     := FFichaTecnica.LargPec;
      dmSysPCP.FichaTecn.FindField('PROF_PEC').AsFloat     := FFichaTecnica.ProfPec;
      dmSysPCP.FichaTecn.FindField('FLAG_TIMG').AsInteger  := FFichaTecnica.FlagTImg;
      dmSysPCP.FichaTecn.FindField('FLAG_TCOMP').AsInteger := FFichaTecnica.FlagTComp;
      GetImageFromStream(TBlobField(dsMain.DataSet.FindField(NAME_BLOB)), imImg_Pec);
    end
    else
      imImg_Pec.Picture   := nil;
    if pcMaterials.ActivePageIndex <> 0 then
      pcMaterials.ActivePageIndex := 0;
  end;
end;

procedure TCdPecas.miFindClick(Sender: TObject);
begin
  inherited;
  dmSysPCP.AFindRecord := (DBStatus <> dbmFind);
  if pgControl.ActivePageIndex = 0 then
  begin
    if DBStatus = dbmFind then
      imImg_Pec.Picture   := nil;
    if pcMaterials.ActivePageIndex <> 0 then
      pcMaterials.ActivePageIndex := 0;
  end;
end;

procedure TCdPecas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dados.Report.BeforeOpen      := nil;
  inherited;
end;

procedure TCdPecas.PecaAfterOpen(Sender: TObject);
var
  V: Variant;
begin
  if pgControl.ActivePageIndex = 0 then
    if (FFkPecas > 0) and (FPkFicha > 0) then
    begin
      V := VarArrayCreate([2, 2], varInteger);
      if VarIsArray(V) then
      begin
        V[0] := FFkPecas;
        V[1] := FPkFicha;
        dmSysPCP.FichaTecn.Locate('FK_PECAS;PK_FICHA_TECNICA', V, [])
      end;
    end
    else
      FSqlPeca := ''
  else
    if FSqlPeca = '' then
      FSqlPeca := dmSysPCP.FichaTecn.CommandText;
end;

procedure TCdPecas.pgControlChange(Sender: TObject);
begin
  Fields.Clear;
  if (pgControl.ActivePageIndex > 0) then
    if (dmSysPCP.FichaTecn.FindField('PK_FICHA_TECNICA') <> nil) then
    begin
      FFkPecas := dmSysPCP.FichaTecn.FindField('FK_PECAS').AsInteger;
      FPkFicha := dmSysPCP.FichaTecn.FindField('PK_FICHA_TECNICA').AsInteger;
      FCodRef  := dmSysPCP.FichaTecn.FindField('COD_REF').AsString;
    end;
  inherited;
  case pgControl.ActivePageIndex of
    0:
    begin
      if FSqlPeca <> '' then
        DefaultSql := FSqlPeca;
      FSqlPeca := '';
      ConfigPeca;
    end;
    1: ConfigPecaCusto;
    2: ConfigPecaEstoque;
  end;
  if not Assigned(Dados.Report.BeforeOpen) then
    Dados.Report.BeforeOpen := HandleReportBeforeOpen;
  SetDataAwareLink(@dsMain, pgControl.ActivePageIndex);
  if (dsMain.DataSet <> nil) then
    inherited ChangeDataSet;
  if pgControl.ActivePageIndex = 0 then
  begin
    DefaultSqlOnly := False;
    DefaultSql     := '';
  end;
end;

procedure TCdPecas.pgControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange := (DBStatus = dbmBrowse);
  if AllowChange then
    SetDataAwareLink(nil, pgControl.ActivePageIndex);
end;

procedure TCdPecas.ConfigPeca;
const
  BLOB_IMG  = 'IMG_PEC';
  SYNC_FROM =
  '  from FICHA_TECNICA Fct                                                                     ' + #13 +
  '  left outer join SECOES           Sec on Sec.PK_SECOES           = Fct.FK_SECOES    ' + #13 +
  '  left outer join GRUPOS           Gru on Gru.FK_SECOES           = Fct.FK_SECOES    ' + #13 +
  '                                      and Gru.PK_GRUPOS           = Fct.FK_GRUPOS    ' + #13 +
  '  left outer join SUBGRUPOS        Sgr on Sgr.FK_SECOES           = Fct.FK_SECOES    ' + #13 +
  '                                      and Sgr.FK_GRUPOS           = Fct.FK_GRUPOS    ' + #13 +
  '                                      and Sgr.PK_SUBGRUPOS        = Fct.FK_SUBGRUPOS ';
begin
  pcMaterials.ActivePageIndex := 0;
  dsMain.DataSet   := dmSysPCP.FichaTecn;
  MainFileName     := 'FICHA_TECNICA';
  MainPrefix       := 'Fct';
  NullSql          := 'Fct.PK_FICHA_TECNICA is null';
  DefControl       := eDsc_Pec;
  VisibleEntrp     := False;
  NAME_BLOB        := BLOB_IMG;
  PrimaryKey       := 'PK_FICHA_TECNICA';
  SyncSelect.Clear;
  SyncFrom.Clear;
  SyncWhere.Clear;
  SyncFields.Clear;
  SyncFrom.Add(SYNC_FROM);
  SyncFields.Add('FK_SECOES=Sec.DSC_SEC');
  SyncFields.Add('FK_GRUPOS=Gru.DSC_GRU');
  SyncFields.Add('FK_SUBGRUPOS=Sgr.DSC_SGRU');
  dmSysPCP.MethodWOutPar := HandlePecaAfterScroll;
end;

procedure TCdPecas.HandlePecaAfterScroll;
var
  BlobField: TBlobField;
begin
//  eCod_Ref.Enabled := (DBStatus = dbmInsert) or (DBStatus = dbmFind);
  if dsMain.DataSet.IsEmpty or
     dsMain.DataSet.FindField('FK_PECAS').IsNull then
    exit;
  stPartName.Caption := dsMain.DataSet.FindField('MAJ_VER').AsString +
    '.'     + dsMain.DataSet.FindField('MIN_VER').AsString + ' - '   +
    'Peça:' + dsMain.DataSet.FindField('FK_PECAS').AsString          +
    ' - '   + dsMain.DataSet.FindField('PK_FICHA_TECNICA').AsString  +
    '/Ref:' + dsMain.DataSet.FindField('COD_REF').AsString + ' ==> ' +
              dsMain.DataSet.FindField('DSC_PEC').AsString;
  EditMain      := False;
  AllowEditTree := False;
  MayInsertTree := False;
  if (dsMain.DataSet.State = dsBrowse) then
  begin
    if dsMain.DataSet.FindField(NAME_BLOB) <> nil then
      if dsMain.DataSet.FindField(NAME_BLOB).IsBlob then
        BlobField := TBlobField(dsMain.DataSet.FindField(NAME_BLOB))
      else
        BlobField := nil
    else
      BlobField := nil;
    if BlobField <> nil then
      GetImageFromStream(BlobField, imImg_Pec);
  end;
end;

procedure TCdPecas.HandleReportBeforeOpen(DataSet:TDataSet);
begin
  if Dados.Report.Params.Count > 0 then
  begin
    Dados.Report.ParamByName('Empresa').AsInteger := Dados.Parametros.EmpresaAtiva;
    if Dados.Report.Params.Count > 1 then
      Dados.Report.ParamByName('Peca').AsInteger         := FFkPecas;
    if Dados.Report.Params.Count > 2 then
      Dados.Report.ParamByName('FichaTecnica').AsInteger := FPkFicha;
  end;
end;

procedure TCdPecas.ConfigPecaCusto;
const
  SYNC_WHERE = 'where Pes.FK_EMPRESAS = :Empresa ' + #13 +
               '  and Pes.FK_PECA     = :Peca  ';
  SYNC_FROM =
  '  from PECAS_CUSTOS Pct '                             + #13 +
  '  left outer join FICHA_TECNICA    Fch '                + #13 +
  '    on Fch.PK_PECAS            = Pct.FK_PECAS         ' + #13 +
  '   and Fch.PK_FICHA_TECNICA    = Pct.FK_FICHA_TECNICA ';
begin
  vtHistoric.Clear;
  Search           := False;
  DefaultSQLOnly   := True;
  DefaultSQL       := SqlPecaCusto;
  VisibleEntrp     := True;
  dsMain.DataSet   := dmSysPCP.PecaCusto;
  MainFileName     := 'PECAS_CUSTOS';
  MainPrefix       := 'Pct';
  NullSql          := 'Pct.FK_EMPRESAS is null';
  DefControl       := eQtdEstq;
  PrimaryKey       := 'FK_EMPRESAS;FK_PECAS;FK_FICHA_TECNICA';
  SyncSelect.Clear;
  SyncFrom.Clear;
  SyncWhere.Clear;
  SyncFields.Clear;
  SyncFrom.Add(SYNC_FROM);
  SyncFields.Add('FK_FICHA_TECNICA=Fhc.DSC_PEC');
  SyncWhere.Add(SYNC_WHERE);
  vtHistoric.Clear;
  if dsMain.DataSet.IsEmpty or (not FFkPecas > 0) or (not FPkFicha > 0) then exit;
  EditMain      := False;
  AllowEditTree := False;
  MayInsertTree := False;
  with dmSysPCP do
  begin
    vtHistoric.Enabled := (not (dsMain.DataSet.State in [dsEdit, dsInsert]));
    pHistoric.Enabled  := (not (dsMain.DataSet.State in [dsEdit, dsInsert]));
    if vtHistoric.Enabled then
    begin
      if qrySearch.Active then qrySearch.Close;
      if qrySearch.Transaction.InTransaction then
        qrySearch.Transaction.Commit;
      qrySearch.SQL.Clear;
      qrySearch.SQL.Add(SqlSaldosGen);
      if not qrySearch.Transaction.InTransaction then
        qrySearch.Transaction.StartTransaction;
      qrySearch.Params.ParamByName('FkEmpresas').AsInteger     := Dados.Parametros.EmpresaAtiva;
      qrySearch.Params.ParamByName('FkPecas').AsInteger        := FFkPecas;
      qrySearch.Params.ParamByName('FkFichaTecnica').AsInteger := FPkFicha;
      if not qrySearch.Active then qrySearch.Open;
      if (not Assigned(vtCapacities.OnGetText)) then
        SetTreeEvents(vtCapacities, [vteGetText]);
      FillVirtualTreeView(vtHistoric, qrySearch, '');
      if qrySearch.Active then qrySearch.Close;
      if qrySearch.Transaction.InTransaction then
        qrySearch.Transaction.Commit;
    end;
  end;
end;

procedure TCdPecas.ConfigPecaEstoque;
const
  SYNC_WHERE = 'where Pes.FK_EMPRESAS = :Empresa ' + #13 +
               '  and Pes.FK_PECA     = :Peca  ';
  SYNC_FROM =
  '  from PECAS_ESTOQUES Pes '                             + #13 +
  '  left outer join ALMOXARIFADOS    Alm '                + #13 +
  '    on Alm.PK_ALMOXARIFADOS    = Pes.FK_ALMOXARIFADOS ' + #13 +
  '  left outer join FICHA_TECNICA    Fch '                + #13 +
  '    on Fch.PK_PECAS            = Pes.FK_PECAS         ' + #13 +
  '   and Fch.PK_FICHA_TECNICA    = Pes.FK_FICHA_TECNICA ';
begin
  vtCapacities.Clear;
  Search           := False;
  DefaultSQLOnly   := True;
  DefaultSQL       := SqlPecaEstoque;
  VisibleEntrp     := True;
  dsMain.DataSet   := dmSysPCP.PecaEstq;
  MainFileName     := 'PECAS_ESTOQUES';
  MainPrefix       := 'Pes';
  NullSql          := 'Pes.FK_EMPRESAS is null';
  DefControl       := eFk_Almoxarifados;
  PrimaryKey       := 'FK_EMPRESAS;FK_PECAS;FK_FICHA_TECNICA;FK_ALMOXARIFADOS;';
  SyncSelect.Clear;
  SyncFrom.Clear;
  SyncWhere.Clear;
  SyncFields.Clear;
  SyncFrom.Add(SYNC_FROM);
  SyncFields.Add('FK_ALMOXARIFADOS=Alm.DSC_ALM');
  SyncFields.Add('FK_FICHA_TECNICA=Fhc.DSC_PEC');
  SyncWhere.Add(SYNC_WHERE);
  dmSysPCP.MethodWOutPar      := HandlePecaEstoquesAfterScroll;
end;

procedure TCdPecas.HandlePecaEstoquesAfterScroll;
begin
  vtCapacities.Clear;
  if dsMain.DataSet.IsEmpty or (not FFkPecas > 0) or (not FPkFicha > 0) then exit;
  EditMain      := False;
  AllowEditTree := True;
  MayInsertTree := True;
  with dmSysPCP do
  begin
    vtCapacities.Enabled := (not (dsMain.DataSet.State in [dsEdit, dsInsert]));
    pCapacities.Enabled  := (not (dsMain.DataSet.State in [dsEdit, dsInsert]));
    if vtCapacities.Enabled then
    begin
      if (not Assigned(vtCapacities.OnFocusChanging)) then
        SetTreeEvents(vtCapacities, [vteFocusChanging, vteNewText,
          vteEdited, vteEditing, vteGetText, vtePaintText]);
      FillVirtualTreeView(vtCapacities, PecLotacoes, SqlPecasLotacoes,
        MayInsertTree);
      sbCapDelete.Visible := (vtCapacities.RootNodeCount > 1);
    end;
  end;
end;

procedure TCdPecas.imImg_PecDblClick(Sender: TObject);
var
  BlobField: TBlobField;
begin
  if DBStatus <> dbmFind then
  begin
    if dmSysPCP.FichaTecn.FindField(NAME_BLOB) <> nil then
      if dmSysPCP.FichaTecn.FindField(NAME_BLOB).IsBlob then
        BlobField := TBlobField(dmSysPCP.FichaTecn.FindField(NAME_BLOB))
      else
        BlobField := nil
    else
      BlobField := nil;
    if BlobField <> nil then
    begin
      if not (dmSysPCP.FichaTecn.State in [dsInsert, dsEdit]) then
        if dmSysPCP.FichaTecn.IsEmpty then
          DBStatus := dbmInsert
        else
          DBStatus := dbmEdit;
      if (not (DBStatus in [dbmInsert, dbmEdit])) then exit;
      dmSysPCP.FichaTecn.FindField('FLAG_TIMG').AsInteger :=
        SelectImageFromFile(BlobField, imImg_Pec);
    end;
  end;
end;

procedure TCdPecas.cmDelImageClick(Sender: TObject);
begin
  inherited;
  if DbStatus <> dbmFind then
  begin
    if not (dmSysPCP.FichaTecn.State in [dsInsert, dsEdit]) then
      if dmSysPCP.FichaTecn.IsEmpty then
        DBStatus := dbmInsert
      else
        DBStatus := dbmEdit;
    if (not (DBStatus in [dbmInsert, dbmEdit])) then exit;
    imImg_Pec.Picture := nil;
    dsMain.DataSet.FieldByName(NAME_BLOB).Clear;
    dsMain.DataSet.FindField('FLAG_TIMG').AsInteger := -1;
  end;
end;

procedure TCdPecas.vtTreeEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  inherited;
  ChangeScreenControl([taDisableAll], False);
  sbCapSave.Visible   := True;
  sbCapCancel.Visible := True;
  sbCapDelete.Visible := vtCapacities.RootNodeCount > 1;
end;

function  TCdPecas.SaveRecords(DataSetName: string): Boolean;
begin
  if Application.MessageBox(PAnsiChar(VarModel[Integer(tcModFile1)] +
     ' ' + DataSetName + ' ' + VarModel[Integer(tcModFile2)]),
     PAnsiChar(Application.Title), MB_ICONWARNING + MB_YESNO +
     MB_DEFBUTTON2) = IDNO then
    Result := True
  else
    Result := False;
end;


procedure TCdPecas.tbCloseClick(Sender: TObject);
begin
  if sbCapSave.Visible then
    if SaveRecords(Dados.GetStringMessage(LANGUAGE, 'sSaveLota',
       'Lotações')) then
      exit;
  inherited;
end;

procedure TCdPecas.sbGetRefClick(Sender: TObject);
begin
  if not (DBStatus in [dbmInsert, dbmEdit]) then
    if dsMain.DataSet.IsEmpty then
      DBSTatus := dbmInsert
    else
      DBSTatus := dbmEdit;
  dsMain.DataSet.FieldByName('COD_REF').AsString :=
    GetTypedReference(dsMain.DataSet.FieldByName('FK_SECOES').AsInteger,
                      dsMain.DataSet.FieldByName('FK_GRUPOS').AsInteger,
                      dsMain.DataSet.FieldByName('FK_SUBGRUPOS').AsInteger);
end;

procedure TCdPecas.sbCapCancelClick(Sender: TObject);
begin
  if sbCapSave.Visible then
    if SaveRecords(Dados.GetStringMessage(LANGUAGE, 'sSaveBarComp',
       'Código de Barras ou Composições')) then
      exit;
  vtCapacities.EndEditNode;
  ReleaseTreeNodes(vtCapacities);
  if sbCapSave.Visible    then sbCapSave.Visible    := False;
  if sbCapDelete.Visible  then sbCapDelete.Visible  := False;
  if sbCapCancel.Visible  then sbCapCancel.Visible  := False;
  if (not sbCapSave.Visible) then
    ChangeScreenControl([taDataControl], True);
  FillVirtualTreeView(vtCapacities, dmSysPCP.PecLotacoes, SqlPecasLotacoes,
    MayInsertTree);
  sbCapDelete.Visible := (vtCapacities.RootNodeCount > 1);
end;

procedure TCdPecas.sbCapDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  vtCapacities.EndEditNode;
  vtCapacities.FocusedColumn := 0;
  Node := vtCapacities.GetFirstSelected;
  Data := vtCapacities.GetNodeData(Node);
  if (Data^.Row.FieldByName['QTD_LOT'].IsNull) then
    vtCapacities.DeleteNode(Node);
  Node := vtCapacities.GetFirst;
  Data := vtCapacities.GetNodeData(Node);
  sbCapDelete.Visible := (Data^.Row.FieldByName['QTD_LOT'].IsNull) and
                         (vtCapacities.RootNodeCount > 0);
  if not sbCapSave.Visible then sbCapSave.Visible := True;
  ChangeScreenControl([taDisableAll], False);
end;

procedure TCdPecas.sbCapSaveClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  vtCapacities.EndEditNode;
  vtCapacities.AutoEdit := False;
  vtCapacities.FocusedColumn := 0;
// Delete all lines of vtCapacities from database and reopen dataSet to insert records
  with dmSysPCP do
  begin
    if PecLotacoes.Active then PecLotacoes.Close;
    if PecLotacoes.Transaction.InTransaction then
      PecLotacoes.Transaction.Commit;
    PecLotacoes.Sql.Clear;
    PecLotacoes.Sql.Add(SqlDeletePecLotacoes);
    if not PecLotacoes.Transaction.InTransaction then PecLotacoes.Transaction.StartTransaction;
    if not PecLotacoes.Prepared then PecLotacoes.Prepare;
    PecLotacoes.Params.FindParam('Empresa').AsInteger      := Dados.Parametros.EmpresaAtiva;
    PecLotacoes.Params.FindParam('Peca').AsInteger         := FFkPecas;
    PecLotacoes.Params.FindParam('FichaTecnica').AsInteger := FPkFicha;
    PecLotacoes.Params.FindParam('Almoxarifado').AsInteger := PecaEstq.FieldByName('FK_ALMOXARIFADOS').AsInteger;
    if not PecLotacoes.Active then PecLotacoes.ExecSQL;
    if PecLotacoes.Transaction.InTransaction then PecLotacoes.Transaction.Commit;
    PecLotacoes.Sql.Clear;
    PecLotacoes.Sql.Add(SqlInsertPecLotacoes);
    if not PecLotacoes.Transaction.InTransaction then
      PecLotacoes.Transaction.StartTransaction;
  end;
// Save all lines of vtCapacities into database
  Node := vtCapacities.GetFirst;
  while Node <> nil do
  begin
    Data := vtCapacities.GetNodeData(Node);
    if not Data^.Row.FieldByName['QTD_LOT'].IsNull then
    begin
      with dmSysPCP do
      begin
        if not PecLotacoes.Prepared then PecLotacoes.Prepare;
        PecLotacoes.Params.FindParam('Empresa').AsInteger      := Dados.Parametros.EmpresaAtiva;
        PecLotacoes.Params.FindParam('Peca').AsInteger         := FFkPecas;
        PecLotacoes.Params.FindParam('FichaTecnica').AsInteger := FPkFicha;
        PecLotacoes.Params.FindParam('Almoxarifado').AsInteger := PecaEstq.FieldByName('FK_ALMOXARIFADOS').AsInteger;
        PecLotacoes.ParamByName('CodRef').AsString             := FCodRef;
        PecLotacoes.ParamByName('QtdLot').AsFloat    := Data^.Row.FieldByName['QTD_LOT'].AsFloat;
        PecLotacoes.ParamByName('RuaIns').AsString   := Data^.Row.FieldByName['RUA_INS'].AsString;
        PecLotacoes.ParamByName('NivelIns').AsString := Data^.Row.FieldByName['NIVEL_INS'].AsString;
        PecLotacoes.ParamByName('BoxIns').AsString   := Data^.Row.FieldByName['BOX_INS'].AsString;
        try
          PecLotacoes.ExecSQL;
          if PecLotacoes.Transaction.InTransaction then
            PecLotacoes.Transaction.CommitRetaining;
        except on E:Exception do
          begin
            Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
              'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
              ['PECAS_LOTACOES']) + #13 + E.Message), PAnsiChar(Application.Title),
              MB_OK + MB_ICONSTOP);
            if PecLotacoes.Transaction.InTransaction then
              PecLotacoes.Transaction.Rollback;
            vtCapacities.Selected[Node] := True;
            exit;
          end; // begin exception
        end; // try
      end; // with dmSysPCP
    end; // if
    Node := vtCapacities.GetNext(Node);
  end; // while
  if dmSysPCP.PecLotacoes.Active then dmSysPCP.PecLotacoes.Close;
  try
    if dmSysPCP.PecLotacoes.Transaction.InTransaction then
      dmSysPCP.PecLotacoes.Transaction.Commit;
  except on E:Exception do
    begin
      Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
        'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
        ['Insumos_Barras']) + #13 + E.Message), PAnsiChar(Application.Title),
        MB_OK + MB_ICONSTOP);
      if dmSysPCP.PecLotacoes.Transaction.InTransaction then
        dmSysPCP.PecLotacoes.Transaction.Rollback;
    end // exception
  end; // try
  if sbCapSave.Visible   then sbCapSave.Visible   := False;
  if sbCapCancel.Visible then sbCapCancel.Visible := False;
  if not sbCapSave.Visible then
    ChangeScreenControl([taDataControl], True);
end;

procedure TCdPecas.tbDeleteClick(Sender: TObject);
var
  Maj, Min: Integer;
  Allowed : Boolean;
begin
  with dmSysPCP do
  begin
    Allowed := LocateNewVersion(FkPeca, Maj, Min);
    if Allowed then
      Allowed := (FlagOP > 0) and (FlagAtv > 0);
    if not Allowed then
    begin
      Application.MessageBox(PChar(Format(Dados.GetStringMessage(LANGUAGE, 'sErrDelVersion',
        'Erro: Versão "%d.%d" da Peça %s não pode ser excluída'), [Maj, Min, CodRef])),
        PChar(Caption), MB_ICONINFORMATION + MB_OK);
      exit;
    end;
  end;
  inherited;
end;

procedure TCdPecas.vtHistoricEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
end;

end.
