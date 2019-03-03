unit CadInscr;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 17/07/2003 - DD/MM/YYYY                                      *}
{* Modified: 17/07/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: You can freely to use and distribute the included code       *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, QExportDialog, Enter, DB, ImgList, Menus, Buttons, ProcType,
  StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin, Mask,
  CheckLst, SyncSource, JvEdit, Encryp, JvToolEdit, JvCurrEdit, JvDBCtrl,
  JvPlacemnt, JvLookup, TreeFunc, IBEvents, Gauges, VirtualTrees,
  CSDVirtualStringTree;

type
  TTipoCadastro = (tcJuridica, tcFisica, tcEstrangeira);

  TCdInscricoes = class(TCdModelo)
    Paises: TDataSource;
    Estados: TDataSource;
    Municipios: TDataSource;
    Localidades: TDataSource;
    Bairros: TDataSource;
    pnCategories: TPanel;
    lEvents: TLabel;
    Cargos: TDataSource;
    pData: TPanel;
    pcControle: TPageControl;
    tsData: TTabSheet;
    lPk_Inscricoes: TLabel;
    lDoc_Sec: TLabel;
    lDoc_Pri: TLabel;
    lNom_Ins: TLabel;
    lNom_Fan: TLabel;
    lFk_Paises: TLabel;
    lFk_Estados: TLabel;
    lFk_Municipios: TLabel;
    lEnd_Cad: TLabel;
    lNum_End: TLabel;
    lCmp_End: TLabel;
    lCep_Cad: TLabel;
    sbFindBai: TSpeedButton;
    sbFindCep: TSpeedButton;
    sbFindLocal: TSpeedButton;
    lCrg_Ins: TLabel;
    lFon_Cad: TLabel;
    lVlr_Ins: TLabel;
    lFax_Cad: TLabel;
    ePk_Inscricoes: TDBEdit;
    lFlag_Cad: TDBRadioGroup;
    eDoc_Sec: TDBEdit;
    eDoc_Pri: TDBEdit;
    eNom_Ins: TDBEdit;
    eNom_Fan: TDBEdit;
    eFk_Paises: TDBLookupComboBox;
    eFk_Estados: TDBLookupComboBox;
    eFk_Municipios: TDBLookupComboBox;
    eEnd_Cad: TDBEdit;
    eCod_Loc: TDBLookupComboBox;
    eCmp_End: TDBEdit;
    eCod_Bai: TDBLookupComboBox;
    eCrg_Ins: TDBEdit;
    eFon_Cad: TDBEdit;
    eFax_Cad: TDBEdit;
    eNum_End: TJvDBCalcEdit;
    eCep_Cad: TJvDBCalcEdit;
    tsComplement: TTabSheet;
    lEmail_Cad: TLabel;
    lFk_Tipo_Status: TLabel;
    sbSendMail: TSpeedButton;
    lFlag_Exp: TDBCheckBox;
    eEmail_Cad: TDBEdit;
    clbCategories: TCheckListBox;
    eVlr_Ins: TJvDBCalcEdit;
    lFlag_Etq: TDBCheckBox;
    eFk_Tipo_Status: TJvDBLookupCombo;
    TiposStatus: TDataSource;
    lDta_Uac: TLabel;
    eDta_Uac: TJvDBDateEdit;
    fsCadIns: TJvFormStorage;
    vtEvents: TCSDVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tbPostClick(Sender: TObject);
    procedure sbSendMailClick(Sender: TObject);
    procedure clbCategoriesClickCheck(Sender: TObject);
    procedure sbFindLocalClick(Sender: TObject);
    procedure sbFindCepClick(Sender: TObject);
    procedure eCod_LocCloseUp(Sender: TObject);
    procedure sbFindBaiClick(Sender: TObject);
    procedure eCod_BaiCloseUp(Sender: TObject);
    procedure miFindClick(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbRefreshClick(Sender: TObject);
    procedure vtEventsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtEventsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtEventsEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vtEventsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtEventsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
  private
    { Private declarations }
    FTipoCadastro: TTipoCadastro;
    FSqlCadastro: string;
    procedure ConfigRecord;
    procedure VerifyCategories(Status: TDBMode);
    procedure DeleteVincInsSeg;
    procedure InsertVincInsSeg;
  protected
    { Protected declarations }
    procedure FechaArquivos(DS: TDataSource); override;
    procedure PesquisaRegistros; override;
    procedure HandleRptBeforeOpen(DataSet: TDataSet);
  public
    { Public declarations }
    procedure BuildSql(NilSql: Boolean; Mode: TDBMode); override;
  published
    { Public declarations }
  end;

var
  CdInscricoes: TCdInscricoes;

implementation

uses mSysEvt, ArqSql, Dado, Funcoes, CmmConst, UrlMon, DBClient, prcConsts,
  FuncoesDB, ModelTyp, ModFields, dbObjects;

{$R *.dfm}

procedure TCdInscricoes.FormCreate(Sender: TObject);
const
  SYNC_WHERE  = 'where PK_INSCRICOES in (select FK_INSCRICOES                 ' + #13 +
                '                          from INSCRICOES_EVENTOS_VINC       ' + #13 +
                '                         where FK_EMPRESAS     = :Empresa    ' + #13 +
                '                           and FK_TIPO_EVENTOS = :TipoEvento ' + #13 +
                '                           and FK_EVENTOS      = :Evento)    ';
  SYNC_FROM   =
  '  from INSCRICOES Ins                                                        ' + #13 +
  '  left outer join TIPO_STATUS Stt on Stt.PK_TIPO_STATUS = Ins.FK_TIPO_STATUS ' + #13 +
  '  left outer join PAISES Pais     on Pais.PK_PAISES     = Ins.FK_PAISES      ' + #13 +
  '  left outer join ESTADOS Est     on Est.FK_PAISES      = Ins.FK_PAISES      ' + #13 +
  '                                 and Est.PK_ESTADOS     = Ins.FK_ESTADOS     ' + #13 +
  '  left outer join MUNICIPIOS Mun  on Mun.FK_PAISES      = Ins.FK_PAISES      ' + #13 +
  '                                 and Mun.FK_ESTADOS     = Ins.FK_ESTADOS     ' + #13 +
  '                                 and Mun.PK_MUNICIPIOS  = Ins.FK_MUNICIPIOS  ';
begin
  MoveCampos       := True;
  inherited;
  eSearch.CharCase := ecUpperCase;
  VisibleEntrp     := False;
  clbCategories.Enabled := True;
  dsMain.DataSet   := dmSysEvt.Inscricao;
  MainFileName     := 'INSCRICOES';
  MainPrefix       := 'Ins';
  NullSql          := 'Ins.PK_INSCRICOES is null';
  PrimaryKey       := 'PK_INSCRICOES';
  DefControl       := lFlag_Cad;
  pcControle.ActivePage     := tsData;
  dmSysEvt.MethodWOutPar    := ConfigRecord;
  clbCategories.MultiSelect := True;
  SyncFrom.Clear;
  SyncFrom.Add(SYNC_FROM);
  SyncFields.Clear;
  SyncFields.Add('FK_PAISES=Pais.DSC_PAIS|10');
  SyncFields.Add('FK_ESTADOS=Est.DSC_UF|11');
  SyncFields.Add('FK_MUNICIPIOS=Mun.DSC_MUN|12');
  SyncFields.Add('FK_TIPO_STATUS=Stt.DSC_STT');
  SyncWhere.Clear;
  SyncWhere.Add(SYNC_WHERE);
  Dados.Report.BeforeOpen := nil;
  Dados.Image16.GetBitmap(10, sbFindCep.Glyph);
  Dados.Image16.GetBitmap(01, sbFindLocal.Glyph);
  Dados.Image16.GetBitmap(01, sbFindBai.Glyph);
  Dados.Image16.GetBitmap(58, sbSendMail.Glyph);
  lEvents.Caption         := Dados.GetStringMessage(LANGUAGE, 'sEvents', 'E&ventos');
  tsData.Caption          := Dados.GetStringMessage(LANGUAGE, 'stsData', 'Dado&s');
  tsComplement.Caption    := Dados.GetStringMessage(LANGUAGE, 'stsComplement', 'Comple&mento');
  Dados.Report.BeforeOpen := HandleRptBeforeOpen;
  vtEvents.NodeDataSize   := SizeOf(TGridData);
  vtEvents.RootNodeCount  := 0;
  SetTreeEvents(vtEvents, [vteFocusChanging, vtePaintText]);
end;

procedure TCdInscricoes.FormActivate(Sender: TObject);
var
  StrAux  : string;
  Node    : PVirtualNode;
  Data    : PGridData;
  HasWhere: Boolean;
begin
  HasWhere := False;
  StrAux := Dados.GetStringMessage(LANGUAGE, 'smiCategory', 'Ca&tegorias');
  if Pos('&', StrAux) > 0 then
    System.Delete(StrAux, Pos('&', StrAux), 1);
  clbCategories.Items.Clear;
  clbCategories.Items.Add(StrAux);
  clbCategories.Header[0] := True;
  with dmSysEvt do
  begin
    if Segmentos.Active then Segmentos.Close;
    Segmentos.SQL.Clear;
    Segmentos.SQL.Add(SqlSegmentos);
    Segmentos.Open;
    Segmentos.First;
    while not Segmentos.Eof do
    begin
      ClbCategories.AddItem(Segmentos.FieldByName('DSC_SEG').AsString,
        TObject(Segmentos.FieldByName('PK_SEGMENTOS').AsInteger));
      Segmentos.Next;
    end;
    if not Eventos.Active then
    begin
      Eventos.AfterScroll := EventosAfterScroll;
      Eventos.SQL.Clear;
      Eventos.SQL.Add(SqlAllEvents);
      Eventos.Open;
    end;
    FillVirtualTreeView(vtEvents, Eventos, SqlAllEvents, False, True, 1);
    vtEvents.FullExpand;
    vtEvents.OnChange := nil;
    Node := vtEvents.GetFirst;
    if not VarIsNull(fsCadIns.StoredValue['SelectedNode']) then
    begin
      while Node <> nil do
      begin
        Data := vtEvents.GetNodeData(Node);
        StrAux := Data^.Row.FieldByName['PK_TIPO_EVENTOS'].AsString +
          Data^.Row.FieldByName['PK_EVENTOS'].AsString;
        if (fsCadIns.StoredValue['SelectedNode'] = StrAux) and
           (vtEvents.GetNodeLevel(Node) = 1) then
        begin
          HasWhere := True;
          RegKeys.TipoEvento := Data^.Row.FieldByName['PK_TIPO_EVENTOS'].AsInteger;
          RegKeys.Evento     := Data^.Row.FieldByName['PK_EVENTOS'].AsInteger;
          vtEvents.Selected[Node] := True;
          break
        end;
        Node := vtEvents.GetNext(Node);
      end;
    end;
  end;
  vtEvents.OnChange := vtEventsChange;
  if not HasWhere then
    SyncWhere.Clear;
  inherited;
end;

procedure TCdInscricoes.FechaArquivos(DS: TDataSource);
begin
  with dmSysEvt do
  begin
    if Paises.Active      then Paises.Close;
    if Estados.Active     then Estados.Close;
    if Municipios.Active  then Municipios.Close;
    if Bairros.Active     then Bairros.Close;
    if Logradouros.Active then Logradouros.Close;
    if Segmentos.Active   then Segmentos.Close;
    if Eventos.Active     then Eventos.Close;
    Eventos.AfterScroll := nil;
    RegKeys.TipoEvento  := 0;
    RegKeys.Evento      := 0;
    RegKeys.Inscricao   := 0;
    RegKeys.Segmento    := 0;
  end;
  if not NoInherit then
  begin
    dmSysEvt.MethodWOutPar   := nil;
    Dados.Report.AfterScroll := nil;
  end;
  inherited;
end;

procedure TCdInscricoes.PesquisaRegistros;
begin
  inherited;
  with dmSysEvt do
  begin
    if not Paises.Active then
    begin
      Paises.SQL.Clear;
      Paises.SQL.Add(SqlPaises);
      Paises.Open;
    end;
    if not Estados.Active then
    begin
      Estados.SQL.Clear;
      Estados.SQL.Add(SqlEstados);
      Estados.Open;
    end;
    if not Municipios.Active then
    begin
      Municipios.SQL.Clear;
      Municipios.SQL.Add(SqlMunicipio);
      Municipios.Open;
    end;
    if not TiposStatus.Active then
    begin
      TiposStatus.SQL.Clear;
      TiposStatus.SQL.Add(SqlTiposStatus);
      TiposStatus.Open;
    end;
  end;
end;

procedure TCdInscricoes.tbPostClick(Sender: TObject);
var
  dbStatusAnt: TDBMode;
  q, i: Integer;
begin
  if pcControle.ActivePageIndex = 1 then
    pcControle.ActivePageIndex := 0;
  q := 0;
  for i := 0 to clbCategories.Count - 1 do
    if clbCategories.State[i] <> cbUnchecked then Inc(q);
  if q = 0 then
  begin
    clbCategories.SetFocus;
    raise Exception.Create(Dados.GetStringMessage(LANGUAGE, 'sNoSelCategory',
      'Erro: Categoria não selecionada'));
  end;
  if pcControle.ActivePage = tsComplement then
    pcControle.ActivePage := tsData;
  dbStatusAnt := DBStatus;
  dsMain.DataSet.AfterScroll := nil;
  inherited;
  VerifyCategories(dbStatusAnt);
  dsMain.DataSet.AfterScroll := dmSysEvt.InscricaoAfterScroll;
end;

procedure TCdInscricoes.ConfigRecord;
var
  i: Integer;
begin
  with dmSysEvt do
  begin
//  Close the table to start a new transaction, if it´s open
    if VincInsSegs.Active then VincInsSegs.Close;
//  set the maks and caption to the fields DOC_PRI e DOC_SEC
    if Inscricao.FieldByName('FK_PAISES').AsInteger <> Dados.Parametros.EmpresaPais then
      FTipoCadastro := tcEstrangeira
    else
      if (Length(Inscricao.FieldByName('DOC_PRI').AsString) = 14) or
         (Inscricao.FieldByName('FLAG_CAD').AsInteger = FLAG_TCAD_JURIDICA) then
        FTipoCadastro := tcJuridica
      else
        if (Length(Inscricao.FieldByName('DOC_PRI').AsString) = 11) or
           (Inscricao.FieldByName('FLAG_CAD').AsInteger = FLAG_TCAD_FISICA) then
          FTipoCadastro := tcFisica
        else
          FTipoCadastro := tcJuridica;
    Inscricao.FieldByName('DOC_SEC').EditMask := '';
    case FTipoCadastro of
      tcEstrangeira: begin
                       lDoc_Pri.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadEstrnDocPri', '&Passaporte:');
                       lDoc_Sec.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadEstrnDocSeq', '&Outro Documento:');
                       lNom_Ins.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadEstrnRazSoc', '&Nome:');
                       lNom_Fan.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadEstrnNomFan', '&Empresa:');
                       Inscricao.FieldByName('DOC_PRI').EditMask := MASK_NO_CNPJ_CPF;
                     end;
      tcJuridica   : begin
                       lDoc_Pri.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadJrdcDocPri', 'C.N.&P.J.:');
                       lDoc_Sec.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadJrdcDocSeq', '&Inscrição Estadual:');
                       lNom_Ins.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadJrdcRazSoc', '&Razão Social:');
                       lNom_Fan.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadJrdcNomFan', 'Nome &Fantasia:');
                       Inscricao.FieldByName('DOC_PRI').EditMask := MASK_CNPJ;
                     end;             
      tcFisica     : begin
                       lDoc_Pri.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadFscDocPri', 'C.&P.F.');
                       lDoc_Sec.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadFscDocSeq', 'R.&G.');
                       lNom_Ins.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadFscRazSoc', '&Nome:');
                       lNom_Fan.Caption := Dados.GetStringMessage(LANGUAGE,
                         'sCadFscNomFan', '&Empresa:');
                       Inscricao.FieldByName('DOC_PRI').EditMask := MASK_CPF;
                     end;
    end;
//  verify the Mask of the field DOC_SEC to respective State
    if (FTipoCadastro = tcJuridica) and (Inscricao.FieldByName('FK_ESTADOS').AsString <> '') then
      Inscricao.FieldByName('DOC_SEC').EditMask :=
        Mascara_Inscricao(Inscricao.FieldByName('FK_ESTADOS').AsString);
//  Set the segments of then record of inscription
    for i := 0 to clbCategories.Count - 1 do
    begin
      if clbCategories.items.Objects[i] <> nil then
      begin
        RegKeys.Segmento   := Integer(clbCategories.items.Objects[i]);
        clbCategories.Checked[i] := LocalizaVincInsSegs;
      end;
    end;
    if VincInsSegs.Active then VincInsSegs.Close;
  end;
end;

procedure TCdInscricoes.sbSendMailClick(Sender: TObject);
begin
  inherited;
  SendMail(dmSysEvt.Inscricao.FieldByName('EMAIL_CAD').AsString);
end;

procedure TCdInscricoes.VerifyCategories(Status: TDBMode);
var
  i: Integer;
begin
  with dmSysEvt do
    for i := 0 to clbCategories.Count - 1 do
      if clbCategories.items.Objects[i] <> nil then
      begin
        Segmentos.GotoBookmark(clbCategories.items.Objects[i]);
        RegKeys.Inscricao := Inscricao.FieldByName('PK_INSCRICOES').AsInteger;
        RegKeys.Segmento := Segmentos.FieldByName('PK_SEGMENTOS').AsInteger;
        if (Status = dbmInsert) and (clbCategories.State[i] <> cbUnchecked) then
          InsertVincInsSeg;
        if (Status = dbmEdit) then
          case clbCategories.State[i] of
            cbChecked  : InsertVincInsSeg;
            cbUnChecked: DeleteVincInsSeg;
          end;
      end;
end;

procedure TCdInscricoes.DeleteVincInsSeg;
begin
  with dmSysEvt do
  begin
    if VincInsSeg.Active then VincInsSeg.Close;
    VincInsSeg.CommandText := SqlVincInsSegs;
    if not VincInsSeg.Active then VincInsSeg.Open;
    if not VincInsSeg.IsEmpty then
    begin
      VincInsSeg.Delete;
      VincInsSeg.ApplyUpdates(-1);
    end;
    if VincInsSeg.Active then VincInsSeg.Close;
  end;
end;

procedure TCdInscricoes.InsertVincInsSeg;
begin
  with dmSysEvt do
  begin
    if VincInsSeg.Active then VincInsSeg.Close;
    VincInsSeg.CommandText := SqlVincInsSegs;
    if not VincInsSeg.Active then VincInsSeg.Open;
    if VincInsSeg.IsEmpty then
    begin
      VincInsSeg.Insert;
      VincInsSeg.FieldByName('FK_INSCRICOES').AsInteger   := RegKeys.Inscricao;
      VincInsSeg.FieldByName('FK_SEGMENTOS').AsInteger    := RegKeys.Segmento;
      VincInsSeg.Post;
      VincInsSeg.ApplyUpdates(-1);
    end;
    if VincInsSeg.Active then VincInsSeg.Close;
  end;
end;

procedure TCdInscricoes.clbCategoriesClickCheck(Sender: TObject);
begin
  inherited;
  if not (DBStatus in [dbmFind, dbmInsert, dbmEdit]) then
    if dsMain.DataSet.IsEmpty then
      DBStatus := dbmInsert
    else
      DBStatus := dbmEdit;
end;

procedure TCdInscricoes.BuildSql(NilSql: Boolean; Mode: TDBMode);
var
  i, q, f, Index: Integer;
  StrAux, CatAux, aPrefix: string;
begin
  q := 0;
  f := 0;
  if (pcControle.ActivePageIndex = 0) and (FSqlCadastro = '') and
     (DBStatus = dbmExecute) then
  begin
    StrAux := '(select Ins.PK_INSCRICOES from INSCRICOES Ins, VINCULOS_SEG_INS Vsi ' +
              'where Ins.PK_INSCRICOES = Vsi.FK_INSCRICOES and Vsi.FK_SEGMENTOS in ';
    CatAux := '';
// find qtd of categories seleted
    for i := 0 to clbCategories.Count - 1 do
      if clbCategories.Checked[i] and (clbCategories.Items.Objects[i] <> nil) then
        Inc(q);
    for i := 0 to clbCategories.Count - 1 do
    begin
      if clbCategories.Checked[i] and (clbCategories.Items.Objects[i] <> nil) then
      begin
        inc(f);
        dmSysEvt.Segmentos.GotoBookmark(clbCategories.items.Objects[i]);
// verify if is the last categorie to don´t insert a comma
        if f = q then
          CatAux := CatAux + dmSysEvt.Segmentos.FieldByName('PK_SEGMENTOS').AsString
        else
          CatAux := CatAux + dmSysEvt.Segmentos.FieldByName('PK_SEGMENTOS').AsString + ', ';
      end;
    end;
    if (CatAux <> '') and (Fields.IndexOfName('PK_INSCRICOES') <> nil) then
    begin
      if MainPrefix <> '' then
        aPrefix := MainPrefix + '.'
      else
        aPrefix := '';
      Index := Fields.IndexOfName('PK_INSCRICOES').Index;
      if (ffFilter in Fields.Items[Index].FieldFlags) then
        Fields.Items[Index].FilterValue := Fields.Items[Index].FilterValue +
          ' and ' + aPrefix + 'PK_INSCRICOES in ' + StrAux + '(' + CatAux + '))'
      else
      begin
        Fields.Items[Index].FilterValue := 'PK_INSCRICOES in ' + StrAux +
          '(' + CatAux + '))';
        Fields.Items[Index].FieldFlags  := Fields.Items[Index].FieldFlags + [ffFilter, ffIn];
      end;
    end;
  end;
  inherited;
end;

procedure TCdInscricoes.sbFindLocalClick(Sender: TObject);
begin
  inherited;
  eCod_Loc.Visible := True;
  sbFindLocal.Enabled := False;
  dmSysEvt.LocalizaLocalidade;
end;

procedure TCdInscricoes.sbFindCepClick(Sender: TObject);
begin
  inherited;
  with dmSysEvt do
  begin
    if not (Inscricao.State in [dsInsert, dsEdit]) then
      Inscricao.Edit;
    if LocalizaCepMunicipio(Inscricao.FieldByName('CEP_CAD').AsInteger) then
    begin
      Inscricao.FieldByName('FK_ESTADOS').AsString     := SqlAux.FieldByName('FK_ESTADOS').AsString;
      Inscricao.FieldByName('FK_MUNICIPIOS').AsInteger := SqlAux.FieldByName('FK_MUNICIPIOS').AsInteger;
    end
    else
    begin
      SqlAux.Close;
      SqlAux.Transaction.Commit;
      if LocalizaCepLocalidade(Inscricao.FieldByName('CEP_CAD').AsInteger) then
      begin
        Inscricao.FieldByName('FK_PAISES').AsInteger     := SqlAux.FieldByName('FK_PAISES').AsInteger;
        Inscricao.FieldByName('FK_ESTADOS').AsString     := SqlAux.FieldByName('FK_ESTADOS').AsString;
        Inscricao.FieldByName('FK_MUNICIPIOS').AsInteger := SqlAux.FieldByName('FK_MUNICIPIOS').AsInteger;
        Inscricao.FieldByName('END_CAD').AsString := SqlAux.FieldByName('DSC_TPE').AsString +
                                                     SqlAux.FieldByName('DSC_LOC').AsString;
        Inscricao.FieldByName('CMP_END').AsString := SqlAux.FieldByName('CMP_LOC').AsString;
      end;
    end;
    SqlAux.Close;
    SqlAux.Transaction.Commit;
    InscricaoAfterScroll(Inscricao);
  end;
end;

procedure TCdInscricoes.eCod_LocCloseUp(Sender: TObject);
begin
  inherited;
  eCod_Loc.Visible := False;
  sbFindLocal.Enabled := True;
  with dmSysEvt do
  begin
    Inscricao.FieldByName('END_CAD').AsString := Logradouros.FieldByName('DSC_TPE').AsString +
                                                 Logradouros.FieldByName('DSC_LOC').AsString;
    Inscricao.FieldByName('CMP_END').AsString := Logradouros.FieldByName('DSC_BAI').AsString +
                                                 Logradouros.FieldByName('CMP_LOC').AsString;
    Inscricao.FieldByName('CEP_CAD').AsString := Logradouros.FieldByName('CEP_LOC').AsString;
    Logradouros.Close;
  end;
end;

procedure TCdInscricoes.sbFindBaiClick(Sender: TObject);
begin
  inherited;
  eCod_Bai.Visible := True;
  sbFindBai.Enabled := False;
  dmSysEvt.LocalizaBairro;
end;

procedure TCdInscricoes.eCod_BaiCloseUp(Sender: TObject);
begin
  inherited;
  eCod_Bai.Visible := False;
  sbFindBai.Enabled := True;
  with dmSysEvt do
  begin
    Inscricao.FieldByName('CMP_END').AsString := Bairros.FieldByName('DSC_BAI').AsString;
    if not SqlAux.FieldByName('CEP_BAI').IsNull and
      (SqlAux.FieldByName('CEP_BAI').AsInteger > 0) and
      (Inscricao.FieldByName('CEP_CAD').AsInteger = 0) then
      Inscricao.FieldByName('CEP_CAD').AsInteger  := Bairros.FieldByName('CEP_BAI').AsInteger;
    Bairros.Close;
  end;
end;

procedure TCdInscricoes.HandleRptBeforeOpen(DataSet: TDataSet);
begin
  with Dados do
    if Report.ParamCount > 0 then
    begin
      Report.ParamByName('Empresa').AsInteger    := Parametros.EmpresaAtiva;
      Report.ParamByName('TipoEvento').AsInteger := dmSysEvt.RegKeys.TipoEvento;
      Report.ParamByName('Evento').AsInteger     := dmSysEvt.RegKeys.Evento;
    end;
end;

procedure TCdInscricoes.miFindClick(Sender: TObject);
begin
  if pcControle.ActivePageIndex = 1 then
    pcControle.ActivePageIndex := 0;
  inherited;
end;

procedure TCdInscricoes.tbInsertClick(Sender: TObject);
begin
  if pcControle.ActivePageIndex = 1 then
    pcControle.ActivePageIndex := 0;
  inherited;
end;

procedure TCdInscricoes.tbDeleteClick(Sender: TObject);
begin
  if pcControle.ActivePageIndex = 1 then
    pcControle.ActivePageIndex := 0;
  inherited;
end;

procedure TCdInscricoes.tbCancelClick(Sender: TObject);
begin
  if pcControle.ActivePageIndex = 1 then
    pcControle.ActivePageIndex := 0;
  inherited;
end;

procedure TCdInscricoes.tbRefreshClick(Sender: TObject);
begin
  if pcControle.ActivePageIndex = 1 then
    pcControle.ActivePageIndex := 0;
  inherited;
end;

procedure TCdInscricoes.vtEventsInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
begin
  if Sender.GetNodeLevel(Node) = 1 then
  begin
    Node.CheckType  := ctCheckBox;
    Node.CheckState := csUncheckedNormal;
  end;
end;

procedure TCdInscricoes.vtEventsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  Data := vtEvents.GetNodeData(Node);
  if (Data <> nil) then
  begin
    with dmSysEvt do
    begin
      RegKeys.TipoEvento := Data^.Row.FieldByName['PK_TIPO_EVENTOS'].AsInteger;
      RegKeys.Evento     := Data^.Row.FieldByName['PK_EVENTOS'].AsInteger;
      fsCadIns.StoredValue['SelectedNode'] :=
        Data^.Row.FieldByName['PK_TIPO_EVENTOS'].AsString +
        Data^.Row.FieldByName['PK_EVENTOS'].AsString;
      Search := False;
      ChangeDataSet;
      Search := True;
    end;
  end;
end;

procedure TCdInscricoes.vtEventsEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TCdInscricoes.vtEventsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  Data     := Sender.GetNodeData(Node);
  if Sender.GetNodeLevel(Node) = 0 then
    CellText := Data^.Row.Fields[0].AsString
  else
    CellText := Data^.Row.Fields[1].AsString
end;

procedure TCdInscricoes.vtEventsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if ((Node = nil) or (not(Kind in [ikNormal, ikSelected]))) then exit;
  Ghosted := False;
  case Sender.GetNodeLevel(Node) of
    0: ImageIndex := 42;
    1: ImageIndex := 53;
  end;
end;

end.
