unit CadTEvt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Enter, DB, ImgList, Menus, Buttons, StdCtrls, DBCtrls,
  ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin, Mask, SyncSource,
  QExportDialog, Encryp, CheckLst, JvPlacemnt, ProcType, JvToolEdit,
  JvCurrEdit, JvDBCtrl;

type
  TCdTipoEventos = class(TCdModelo)
    dsCategorias: TDataSource;
    pData: TPanel;
    pnCategories: TPanel;
    lAreas: TLabel;
    clbAreas: TCheckListBox;
    lDsc_TEvt: TLabel;
    eDsc_TEvt: TDBEdit;
    ePk_Tipo_Eventos: TDBEdit;
    lPk_Tipo_Eventos: TLabel;
    miTAreasAct: TMenuItem;
    eMtrg_Prom: TJvDBCalcEdit;
    lMtrg_Prom: TLabel;
    lQtd_Bonus: TLabel;
    eQtd_Bonus: TJvDBCalcEdit;
    lEMail_Evt: TLabel;
    eEMail_Evt: TDBEdit;
    lFk_Categorias: TLabel;
    eFk_Categorias: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tbPostClick(Sender: TObject);
    procedure miTAreasActClick(Sender: TObject);
    procedure clbAreasClickCheck(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConfigRecord;
    procedure VerifyAreas(Status: TDBMode);
    procedure DeleteVinculo;
    procedure InsertVinculo;
  protected
    { Protected declarations }
    procedure FechaArquivos(DS: TDataSource); override;
    procedure PesquisaRegistros; override;
  public
    procedure BuildSql(NilSql: Boolean; Mode: TDBMode); override;
    { Public declarations }
  end;

var
  CdTipoEventos: TCdTipoEventos;

implementation

uses mSysEvt, ArqSql, Dado, CmmConst, CadTArea, ModFields;

{$R *.dfm}

procedure TCdTipoEventos.FormCreate(Sender: TObject);
begin
  MoveCampos          := True;
  inherited;
  dsMain.DataSet      := dmSysEvt.TipoEvento;
  MainFileName        := 'TIPO_EVENTOS';
  MainPrefix          := 'Tev';
  NullSql             := 'Tev.PK_TIPO_EVENTOS is null';
  PrimaryKey          := 'PK_TIPO_EVENTOS';
  DefControl          := eDsc_TEvt;
  miTAreasAct.Caption := Dados.GetStringMessage(LANGUAGE, 'slAreas', 'Á&reas Direcionadas');
  lAreas.Caption      := miTAreasAct.Caption;
  miTAreasAct.Enabled := Dados.LocalizaAcessos('CdTipoAreas');
  dmSysEvt.MethodWOutPar := ConfigRecord;
end;

procedure TCdTipoEventos.FechaArquivos(DS: TDataSource);
begin
  with dmSysEvt do
  begin
    if CloseAll then
      if Categorias.Active   then Categorias.Close;
    RegKeys.TipoEvento := 0;
    if not NoInherit then
      MethodWOutPar := nil;
  end;
  inherited;
end;

procedure TCdTipoEventos.PesquisaRegistros;
begin
  inherited;
  with dmSysEvt do
  begin
    if not Categorias.Active then
    begin
      Categorias.SQL.Clear;
      Categorias.SQL.Add(SqlCategorias);
      Categorias.Open;
    end;
  end;
end;

procedure TCdTipoEventos.FormActivate(Sender: TObject);
var
  StrAux: string;
begin
  StrAux := miTAreasAct.Caption;
  if Pos('&', StrAux) > 0 then
    System.Delete(StrAux, Pos('&', StrAux), 1);
  clbAreas.Items.Clear;
  clbAreas.Items.Add(StrAux);
  clbAreas.Header[0] := True;
  with dmSysEvt do
  begin
    if TAreasAct.Active then TAreasAct.Close;
    TAreasAct.SQL.Clear;
    TAreasAct.SQL.Add(SqlTAreasAct);
    TAreasAct.Open;
    TAreasAct.First;
    while not TAreasAct.Eof do
    begin
      ClbAreas.AddItem(TAreasAct.FieldByName('DSC_TARA').AsString,
        TObject(TAreasAct.FieldByName('PK_TIPO_AREAS_ATUACAO').AsInteger));
      TAreasAct.Next;
    end;
    TAreasAct.Close;
  end;
  inherited;
end;

procedure TCdTipoEventos.tbPostClick(Sender: TObject);
var
  dbStatusAnt: TDBMode;
  q, i: Integer;
begin
  q := 0;
  for i := 0 to clbAreas.Count - 1 do
    if clbAreas.State[i] <> cbUnchecked then Inc(q);
  if q = 0 then
  begin
    clbAreas.SetFocus;
    Application.MessageBox(PChar(Dados.GetStringMessage(LANGUAGE, 'sNoSelArea',
      'Erro: Áreas de Direcionamento não selecionadas')),
       ParamGlobal^.ProgramTitle, MB_OK + MB_ICONERROR);
    exit;
  end;
  dbStatusAnt := DBStatus;
  dsMain.DataSet.AfterScroll := nil;
  inherited;
  VerifyAreas(dbStatusAnt);
  dsMain.DataSet.AfterScroll := dmSysEvt.TipoEventoAfterScroll;
end;

procedure TCdTipoEventos.ConfigRecord;
var
  i: Integer;
begin
  with dmSysEvt do
  begin
//  Marca as áreas de atuação do evento
    for i := 0 to clbAreas.Count - 1 do
    begin
      if clbAreas.items.Objects[i] <> nil then
      begin
        RegKeys.TipoEvento      := TipoEvento.FieldByName('PK_TIPO_EVENTOS').AsInteger;
        RegKeys.TipoAreaAtuacao := Integer(clbAreas.Items.Objects[i]);
        clbAreas.State[i]       := LocalizaVincEvtArea;
      end;
    end;
    if VincAreas.Active then VincAreas.Close;
  end;
end;

procedure TCdTipoEventos.miTAreasActClick(Sender: TObject);
var
  PT: string;
begin
  inherited;
  PT := StrPas(ParamGlobal^.ProgramTitle);
  ParamGlobal^.ProgramTitle := PAnsiChar(Dados.FindProgramTitle('CdTipoAreas'));
  Application.CreateForm(TCdTipoAreas, CdTipoAreas);
  try
    CdTipoAreas.ShowModal;
  finally
    CdTipoAreas.Free;
  end;
  ParamGlobal^.ProgramTitle := PAnsiChar(PT);
end;

procedure TCdTipoEventos.VerifyAreas(Status: TDBMode);
var
  i: Integer;
begin
  with dmSysEvt do
    for i := 0 to clbAreas.Count - 1 do
      if clbAreas.items.Objects[i] <> nil then
      begin
        RegKeys.TipoEvento      := TipoEvento.FieldByName('PK_TIPO_EVENTOS').AsInteger;
        RegKeys.TipoAreaAtuacao := Integer(clbAreas.Items.Objects[i]);
        if (Status = dbmInsert) and (clbAreas.State[i] <> cbUnchecked) then
          InsertVinculo;
        if (Status = dbmEdit) then
          case clbAreas.State[i] of
            cbChecked  : if LocalizaVincEvtArea = cbUnchecked then InsertVinculo;
            cbUnChecked: if LocalizaVincEvtArea = cbChecked   then DeleteVinculo;
          end;
      end;
end;

procedure TCdTipoEventos.DeleteVinculo;
begin
  with dmSysEvt do
  begin
    if VincEvtArea.Active then VincEvtArea.Close;
    VincEvtArea.CommandText := SqlVincEvtArea;
    if not VincEvtArea.Active then VincEvtArea.Open;
    VincEvtArea.Delete;
    VincEvtArea.ApplyUpdates(-1);
    if VincEvtArea.Active then VincEvtArea.Close;
  end;
end;

procedure TCdTipoEventos.InsertVinculo;
begin
  with dmSysEvt do
  begin
    if VincEvtArea.Active then VincEvtArea.Close;
    VincEvtArea.CommandText := SqlVincEvtArea;
    if not VincEvtArea.Active then VincEvtArea.Open;
    VincEvtArea.Insert;
    VincEvtArea.FieldByName('FK_TIPO_EVENTOS').AsInteger       := RegKeys.TipoEvento;
    VincEvtArea.FieldByName('FK_TIPO_AREAS_ATUACAO').AsInteger := RegKeys.TipoAreaAtuacao;
    VincEvtArea.Post;
    VincEvtArea.ApplyUpdates(-1);
    if VincEvtArea.Active then VincEvtArea.Close;
  end;
end;

procedure TCdTipoEventos.BuildSql(NilSql: Boolean; Mode: TDBMode);
var
  i, Index: Integer;
  StrAux, CatAux: string;
begin
  StrAux := '(select Tev.PK_TIPO_EVENTOS from TIPO_EVENTOS Tev, TIPO_EVENTOS_AREA_VINC Tea ' +
            'where Tev.PK_TIPO_EVENTOS = Tea.PK_TIPO_EVENTOS and ' + #13 +
            'Tea.FK_TIPO_AREAS_ATUACAO in ';
  CatAux := '';
  for i := 0 to clbAreas.Count - 1 do
  begin
    if clbAreas.Checked[i] and (clbAreas.Items.Objects[i] <> nil) then
    begin
      if i < clbAreas.Count - 1 then
        CatAux := CatAux + IntToStr(Integer(clbAreas.Items.Objects[i]))
      else
        CatAux := CatAux + IntToStr(Integer(clbAreas.Items.Objects[i])) + ', ';
    end;
  end;
  if (CatAux <> '') and (Fields.IndexOfName('PK_INSCRICOES') <> nil) then
  begin
    Index := Fields.IndexOfName('PK_INSCRICOES').Index;
    if Fields.Items[Index].CanFilter then
      if (ffFilter in Fields.Items[Index].FieldFlags) then
        Fields.Items[Index].FilterValue := Fields.Items[Index].FilterValue +
          ' and PK_INSCRICOES in ' + StrAux + '(' + CatAux + '))'
      else
        Fields.Items[Index].FilterValue := ' and PK_INSCRICOES in ' + StrAux +
          '(' + CatAux + '))';
  end;
  inherited;
end;

procedure TCdTipoEventos.clbAreasClickCheck(Sender: TObject);
begin
  if not (DBStatus in [dbmFind, dbmInsert, dbmEdit]) then
    if dsMain.DataSet.IsEmpty then
      DBStatus := dbmInsert
    else
      DBStatus := dbmEdit;
end;

procedure TCdTipoEventos.tbCancelClick(Sender: TObject);
begin
  inherited;
  ConfigRecord;
end;

end.
