unit CadSrvc;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 08/12/2003 - DD/MM/YYYY                                      *}
{* Modified: 08/12/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
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
  Dialogs, CadMod, Encryp, SyncSource, QExportDialog, Enter, DB, Menus,
  Buttons, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  Mask, JvToolEdit, JvCurrEdit, JvDBCtrl;

type
  TCdServicos = class(TCdModelo)
    lPk_Servicos_Ind: TLabel;
    ePk_Servicos_Ind: TDBEdit;
    eDsc_Srv: TDBEdit;
    lDsc_Srv: TLabel;
    Secoes: TDataSource;
    Grupos: TDataSource;
    SubGrupos: TDataSource;
    Unidades: TDataSource;
    lFk_Secoes: TLabel;
    eFk_Secoes: TDBLookupComboBox;
    eFk_Grupos: TDBLookupComboBox;
    lFk_Grupos: TLabel;
    lFk_SubGrupos: TLabel;
    eFk_SubGrupos: TDBLookupComboBox;
    lFk_Unidades: TLabel;
    eFk_Unidades: TDBLookupComboBox;
    lQtd_Uni: TLabel;
    eQtd_Uni: TJvDBCalcEdit;
    eVlr_Uni: TJvDBCalcEdit;
    lVlr_Uni: TLabel;
    eCod_Ref: TDBEdit;
    lCod_Ref: TLabel;
    lCod_Barra: TLabel;
    eCod_Barra: TDBEdit;
    eObs_Srv: TDBMemo;
    lObs_Srv: TLabel;
    lFlag_Atv: TDBCheckBox;
    sbGetRef: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure sbGetRefClick(Sender: TObject);
    procedure miFindClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure FechaArquivos(DS: TDataSource); override;
    procedure PesquisaRegistros; override;
  public
    { Public declarations }
  end;

var
  CdServicos: TCdServicos;

implementation

uses mSysCosts, ArqSql, Dado, ProcType, FuncoesDB;

const
  SYNC_FROM   =
  '  from SERVICOS_IND Srv                                                 ' + #13 +
  '  left outer join SECOES    Sec  on Sec.PK_SECOES    = Srv.FK_SECOES    ' + #13 +
  '  left outer join GRUPOS    Grp  on Grp.FK_SECOES    = Srv.FK_SECOES    ' + #13 +
  '                                and Grp.PK_GRUPOS    = Srv.FK_GRUPOS    ' + #13 +
  '  left outer join SUBGRUPOS Sgr  on Sgr.FK_SECOES    = Srv.FK_SECOES    ' + #13 +
  '                                and Sgr.FK_GRUPOS    = Srv.FK_GRUPOS    ' + #13 +
  '                                and Sgr.PK_SUBGRUPOS = Srv.FK_SUBGRUPOS ' + #13 +
  '  left outer join UNIDADES  Uni  on Uni.PK_UNIDADES  = Srv.FK_UNIDADES  ';

{$R *.dfm}

procedure TCdServicos.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  eSearch.CharCase := ecUpperCase;
  dsMain.DataSet   := dmSysCosts.Servico;
  MainFileName     := 'SERVICOS_IND';
  MainPrefix       := 'Srv';
  NullSql          := 'PK_SERVICOS_IND is null';
  DefControl       := eDSC_SRV;
  VisibleEntrp     := False;
  PrimaryKey       := 'PK_SERVICOS_IND';
  SyncFrom.Add(SYNC_FROM);
  SyncFields.Add('FK_SECOES=Sec.DSC_SEC');
  SyncFields.Add('FK_GRUPOS=Grp.DSC_GRU');
  SyncFields.Add('FK_SUBGRUPOS=Sgr.DSC_SGRU');
  SyncFields.Add('FK_UNIDADES=Uni.DSC_UNI');
  Dados.Image16.GetBitmap(30, sbGetRef.Glyph);
  dmSysCosts.AFindRecord := False;
end;

procedure TCdServicos.FechaArquivos(DS: TDataSource);
begin
  with dmSysCosts do
  begin
    if Secoes.Active         then Secoes.Close;
    if Grupos.Active         then Grupos.Close;
    if Unidades.Active       then Unidades.Close;
  end;
  inherited;
end;

procedure TCdServicos.PesquisaRegistros;
begin
  inherited;
  with dmSysCosts do
  begin
    if not Secoes.Active then
    begin
      Secoes.SQL.Clear;
      Secoes.SQL.Add(SqlSecoesServ);
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
    if not Unidades.Active then
    begin
      Unidades.SQL.Clear;
      Unidades.SQL.Add(SqlUnidades);
      Unidades.Open;
    end;
  end;
end;

procedure TCdServicos.sbGetRefClick(Sender: TObject);
begin
  if not (DBStatus in [dbmInsert, dbmEdit]) then
    if dsMain.DataSet.IsEmpty then
      DBStatus := dbmInsert
    else
      DBStatus := dbmEdit;
  with dmSysCosts do
    dsMain.DataSet.FieldByName('COD_REF').AsString :=
      GetTypedReference(dsMain.DataSet.FieldByName('FK_SECOES').AsInteger,
                        dsMain.DataSet.FieldByName('FK_GRUPOS').AsInteger,
                        dsMain.DataSet.FieldByName('FK_SUBGRUPOS').AsInteger);
end;

procedure TCdServicos.miFindClick(Sender: TObject);
begin
  inherited;
  dmSysCosts.AFindRecord := (DBStatus <> dbmFind);
end;

end.
