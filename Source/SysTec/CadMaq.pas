unit CadMaq;

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
  Mask, JvCurrEdit, JvDBCtrl, JvToolEdit;

type
  TCdMaquinas = class(TCdModelo)
    Fornecedores: TDataSource;
    lPk_Maquinas: TLabel;
    ePk_Maquinas: TDBEdit;
    eDsc_Maq: TDBEdit;
    lDsc_Maq: TLabel;
    lFk_Vw_Fornecedores: TLabel;
    eFk_Vw_Fornecedores: TDBLookupComboBox;
    lDta_Aqu: TLabel;
    eDta_Aqu: TJvDBDateEdit;
    lPot_Maq: TLabel;
    ePot_Maq: TJvDBCalcEdit;
    eNum_Ope: TJvDBCalcEdit;
    lNum_Ope: TLabel;
    eDta_URvs: TJvDBDateEdit;
    lDta_URvs: TLabel;
    lTmmp_Maq: TLabel;
    eTmmp_Maq: TJvDBCalcEdit;
    lMtbf_Maq: TLabel;
    eMtbf_Maq: TJvDBCalcEdit;
    lFk_Secoes: TLabel;
    eFk_Secoes: TDBLookupComboBox;
    lFk_Grupos: TLabel;
    eFk_Grupos: TDBLookupComboBox;
    lFk_SubGrupos: TLabel;
    eFk_SubGrupos: TDBLookupComboBox;
    Secoes: TDataSource;
    Grupos: TDataSource;
    SubGrupos: TDataSource;
    eCod_Ref: TDBEdit;
    lCod_Ref: TLabel;
    sbGetRef: TSpeedButton;
    lObs_Maq: TStaticText;
    eObs_Maq: TDBMemo;
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
  CdMaquinas: TCdMaquinas;

implementation

uses mSysCosts, ArqSql, FuncoesDB, ProcType, Dado;

const
  SYNC_FROM   =
  '  from MAQUINAS Maq                                    ' + #13 +
  '  left outer join VW_FORNECEDORES Frn                  ' + #13 +
  '       on    Frn.PK_CADASTROS = Maq.FK_VW_FORNECEDORES ' + #13 +
  '  left outer join SECOES          Sec                  ' + #13 +
  '       on    Sec.PK_SECOES    = Maq.FK_SECOES          ' + #13 +
  '  left outer join GRUPOS          Gru                  ' + #13 +
  '       on    Gru.FK_SECOES    = Maq.FK_SECOES          ' + #13 +
  '      and    Gru.PK_GRUPOS    = Maq.FK_GRUPOS          ' + #13 +
  '  left outer join SUBGRUPOS       Sgr                  ' + #13 +
  '       on    Sgr.FK_SECOES    = Maq.FK_SECOES          ' + #13 +
  '      and    Sgr.FK_GRUPOS    = Maq.FK_GRUPOS          ' + #13 +
  '      and    Sgr.PK_SUBGRUPOS = Maq.FK_SUBGRUPOS       ';

{$R *.dfm}

procedure TCdMaquinas.FormCreate(Sender: TObject);
begin
  MoveCampos       := True;
  inherited;
  eSearch.CharCase := ecUpperCase;
  dsMain.DataSet   := dmSysCosts.Maquina;
  MainFileName     := 'MAQUINAS';
  MainPrefix       := 'Maq';
  NullSql          := 'PK_MAQUINAS is null';
  DefControl       := eDSC_MAQ;
  VisibleEntrp     := False;
  PrimaryKey       := 'PK_MAQUINAS';
  SyncFrom.Add(SYNC_FROM);
  SyncFields.Add('FK_VW_FORNECEDORES=Frn.RAZ_SOC');
  SyncFields.Add('FK_SECOES=Sec.DSC_SEC');
  SyncFields.Add('FK_GRUPOS=Gru.DSC_GRU');
  SyncFields.Add('FK_SUBGRUPOS=Sgr.DSC_SGRU');
  Dados.Image16.GetBitmap(30, sbGetRef.Glyph);
  dmSysCosts.AFindRecord := False;
end;

procedure TCdMaquinas.FechaArquivos(DS: TDataSource);
begin
  with dmSysCosts do
  begin
    if Fornecedores.Active then Fornecedores.Close;
    if Secoes.Active       then Secoes.Close;
    if Grupos.Active       then Grupos.Close;
    if SubGrupos.Active    then SubGrupos.Close;
  end;
  inherited;
end;

procedure TCdMaquinas.PesquisaRegistros;
begin
  inherited;
  with dmSysCosts do
  begin
    if not Fornecedores.Active then
    begin
      Fornecedores.SQL.Clear;
      Fornecedores.SQL.Add(SqlFornecedores);
      Fornecedores.Open;
    end;
    if not Secoes.Active then
    begin
      Secoes.SQL.Clear;
      Secoes.SQL.Add(SqlSecoesMaquinas);
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
end;

procedure TCdMaquinas.sbGetRefClick(Sender: TObject);
begin
  if not (DBStatus in [dbmInsert, dbmEdit]) then
    if dsMain.DataSet.IsEmpty then
      DBSTatus := dbmInsert
    else
      DBSTatus := dbmEdit;
  with dmSysCosts do
    dsMain.DataSet.FieldByName('COD_REF').AsString :=
      GetTypedReference(dsMain.DataSet.FieldByName('FK_SECOES').AsInteger,
                        dsMain.DataSet.FieldByName('FK_GRUPOS').AsInteger,
                        dsMain.DataSet.FieldByName('FK_SUBGRUPOS').AsInteger);
end;

procedure TCdMaquinas.miFindClick(Sender: TObject);
begin
  inherited;
  dmSysCosts.AFindRecord := (DBStatus <> dbmFind);
end;

end.
