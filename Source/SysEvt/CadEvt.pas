unit CadEvt;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
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
  Dialogs, CadMod, DB, Enter, ImgList, Menus, StdCtrls, DBCtrls, ExtCtrls,
  Grids, DBGrids, ComCtrls, ToolWin, Mask, Buttons, QExportDialog,
  SyncSource, Encryp, JvToolEdit, JvDBCtrl, JvCurrEdit, CheckLst;

type
  TCdEventos = class(TCdModelo)
    TipoEventos: TDataSource;
    Eventos: TDataSource;
    Segmentos: TDataSource;
    pcControl: TPageControl;
    tsEvents: TTabSheet;
    tsPrices: TTabSheet;
    Bevel1: TBevel;
    lFk_Tipo_Eventos: TLabel;
    eFk_Tipo_Eventos: TDBLookupComboBox;
    ePk_Eventos: TDBEdit;
    lPk_Eventos: TLabel;
    lDta_Fin: TLabel;
    lNum_Cat: TLabel;
    lNum_Exp: TLabel;
    lPre_Seg: TLabel;
    ePre_Seg: TJvDBCalcEdit;
    eDta_Ini: TJvDBDateEdit;
    eDta_Fin: TJvDBDateEdit;
    eNum_Cat: TJvDBCalcEdit;
    eNum_Exp: TJvDBCalcEdit;
    lNum_Ins: TLabel;
    eNum_Ins: TJvDBCalcEdit;
    lVlr_Mt2: TLabel;
    eVlr_Mt2: TJvDBCalcEdit;
    lDta_Ini: TLabel;
    pNameEvent: TPanel;
    Panel4: TPanel;
    lViewSeg: TLabel;
    clbSegments: TCheckListBox;
    lFk_Segmentos: TLabel;
    eFk_Segmentos: TDBLookupComboBox;
    lDta_Cr_Exp: TLabel;
    eDta_Cr_Exp: TJvDBDateEdit;
    lDta_Cr_Mont: TLabel;
    eDta_Cr_Mont: TJvDBDateEdit;
    lDta_Conv: TLabel;
    eDta_Conv: TJvDBDateEdit;
    lDta_Es_Merc: TLabel;
    eDta_Es_Merc: TJvDBDateEdit;
    lDta_Srv: TLabel;
    eDta_Srv: TJvDBDateEdit;
    eDta_Equip: TJvDBDateEdit;
    lDta_Equip: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure pcControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pcControlChange(Sender: TObject);
    procedure EventosAfterOpen(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure tbPostClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure clbSegmentsClick(Sender: TObject);
  private
    { Private declarations }
    FFillBK   : Boolean;
    FBKEvents : TBookmark;
    FSqlEvents: string;
    procedure ConfigEvents;
    procedure ConfigPrices;
    procedure HndEvtReportBeforeOpen(DataSet: TDataSet);
    procedure HndSegReportBeforeOpen(DataSet: TDataSet);
    procedure HndEvtSegmentsAfterScroll(DataSet: TDataSet);
    procedure FreeDataclbSegments;
    procedure FillclbSegments;
    procedure FindListIndex;
  protected
    procedure FechaArquivos(DS: TDataSource); override;
    procedure PesquisaRegistros; override;
  public
    { Public declarations }
  end;

var
  CdEventos: TCdEventos;

implementation

uses mSysEvt, ArqSql, Dado, CmmConst, ProcType;

{$R *.dfm}

procedure TCdEventos.FormCreate(Sender: TObject);
begin
  FFillBK           := False;
  MoveCampos        := True;
  inherited;
  eSearch.CharCase  := ecUpperCase;
  VisibleEntrp      := False;
  tsEvents.Caption  := Dados.GetStringMessage(LANGUAGE, 'stsEvents', 'Edições dos &Eventos');
  tsPrices.Caption  := Dados.GetStringMessage(LANGUAGE, 'stsPrices', '&Seleção e Preços de Categorias');
  lViewSeg.Caption  := Dados.GetStringMessage(LANGUAGE, 'slViewSeg', '&Tipos de Segmentos');
  AfterOpen         := EventosAfterOpen;
  if pcControl.ActivePageIndex <> 0 then
    pcControl.ActivePageIndex := 0;
  ConfigEvents;
end;

procedure TCdEventos.FechaArquivos(DS: TDataSource);
begin
  with dmSysEvt do
  begin
    if TipoEventos.Active then TipoEventos.Close;
    if Segmentos.Active   then Segmentos.Close;
    TrEvt.Commit;
  end;
  inherited;
end;

procedure TCdEventos.PesquisaRegistros;
begin
  inherited;
  with dmSysEvt do
  begin
    if not TrEvt.InTransaction then TrEvt.StartTransaction;
    if not TipoEventos.Active then
    begin
      TipoEventos.SQL.Clear;
      TipoEventos.SQL.Add(SqlTipoEventos);
      TipoEventos.Open;
    end;
  end;
end;

procedure TCdEventos.pcControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange := not (DBStatus in [dbmInsert, dbmFind, dbmEdit]);
  if AllowChange then
    SetDataAwareLink(nil, pcControl.ActivePageIndex);
end;

procedure TCdEventos.pcControlChange(Sender: TObject);
begin
  inherited;
  Fields.Clear;
  if pcControl.ActivePageIndex = 1 then
  begin
    FBkEvents          := dmSysEvt.Evento.GetBookmark;
    pNameEvent.Caption := dmSysEvt.TipoEventos.FieldByName('DSC_TEVT').AsString +
                          ' - ' + dmSysEvt.Evento.FieldByName('PK_EVENTOS').AsString;
  end;
  if FFillBK then
    FreeDataclbSegments;
  inherited FechaArquivos(dsMain);
  case pcControl.ActivePageIndex of
    0 :
    begin
      if FSqlEvents <> '' then
        DefaultSql := FSqlEvents;
      FSqlEvents := '';
      ConfigEvents;
    end;
    1 : ConfigPrices;
  end;
  SetDataAwareLink(@dsMain, pcControl.ActivePageIndex);
  if pcControl.ActivePageIndex = 1 then
    FillclbSegments;
  if (dsMain.DataSet <> nil) then
    inherited ChangeDataSet;
  if pcControl.ActivePageIndex = 0 then
    DefaultSql := '';
//  else
//    FillclbSegments;
end;

procedure TCdEventos.ConfigEvents;
const
  SYNC_WHERE  =
  ' where FK_EMPRESAS = :Empresa ';
  SYNC_FROM   =
  '  from EVENTOS Evt                                                              ' + #13 +
  '  left outer join TIPO_EVENTOS Tev on Tev.PK_TIPO_EVENTOS = Evt.FK_TIPO_EVENTOS ';

begin
  dsMain.DataSet := dmSysEvt.Evento;
  MainFileName   := 'EVENTOS';
  MainPrefix     := 'Evt';
  NullSql        := 'Evt.FK_EMPRESAS is null';
  DefControl     := eDta_Ini;
  VisibleEntrp   := False;
  PrimaryKey     := 'FK_EMPRESAS;FK_TIPO_EVENTOS;PK_EVENTOS';
  SyncFrom.Clear;
  SyncFrom.Add(SYNC_FROM);
  SyncWhere.Clear;
  SyncWhere.Add(SYNC_WHERE);
  SyncFields.Clear;
  SyncFields.Add('FK_TIPO_EVENTOS=Tev.DSC_TEVT|1');
  with dmSysEvt do
  begin
    RegKeys.Evento     := 0;
    RegKeys.TipoEvento := 0;
    RegKeys.Segmento   := 0;
  end;
  Dados.Report.BeforeOpen := HndEvtReportBeforeOpen;
end;

procedure TCdEventos.ConfigPrices;
const
  SYNC_WHERE  =
  ' where Psg.FK_EMPRESAS     = :Empresa    ' + #13 +
  '   and Psg.FK_TIPO_EVENTOS = :TipoEvento ' + #13 +
  '   and Psg.FK_EVENTOS      = :Evento     ';
  SYNC_FROM   =
  '  from PRECO_SEGMENTOS Psg                                                      ' + #13 +
  '  left outer join TIPO_EVENTOS Tev on Tev.PK_TIPO_EVENTOS = Psg.FK_TIPO_EVENTOS ' + #13 +
  '  left outer join EVENTOS      Evt on Evt.FK_EMPRESAS     = Psg.FK_EMPRESAS     ' + #13 +
  '                                  and Evt.PK_EVENTOS      = Psg.FK_EVENTOS      ' + #13 +
  '  left outer join SEGMENTOS    Seg on Seg.PK_SEGMENTOS    = Psg.FK_SEGMENTOS    ';
begin
  dsMain.DataSet := dmSysEvt.PrecoSeg;
  MainFileName   := 'PRECO_SEGMENTOS';
  MainPrefix     := 'Psg';
  NullSql        := 'FK_EMPRESAS is null';
  DefControl     := ePre_Seg;
  PrimaryKey     := 'FK_EMPRESAS;FK_TIPO_EVENTOS;FK_EVENTOS;FK_SEGMENTOS';
  Search         := False;
  SyncFrom.Clear;
  SyncFrom.Add(SYNC_FROM);
  SyncWhere.Clear;
  SyncWhere.Add(SYNC_WHERE);
  SyncFields.Clear;
  SyncFields.Add('FK_TIPO_EVENTOS=Tev.DSC_TEVT|2');
  SyncFields.Add('FK_EVENTOS=Evt.PK_EVENTOS|3');
  SyncFields.Add('FK_SEGMENTOS=Seg.DSC_SEG');
  Dados.Report.BeforeOpen := HndSegReportBeforeOpen;
end;

procedure TCdEventos.HndEvtReportBeforeOpen(DataSet: TDataSet);
begin
  with Dados do
    if Report.Params.Count > 0 then
      Report.Params.ParamByName('Empresa').AsInteger := Dados.Parametros.EmpresaAtiva;
end;

procedure TCdEventos.HndEvtSegmentsAfterScroll(DataSet: TDataSet);
begin
  FindListIndex;
  with dmSysEvt do
    RegKeys.Segmento := Segmentos.FieldByName('PK_SEGMENTOS').AsInteger;
end;

procedure TCdEventos.HndSegReportBeforeOpen(DataSet: TDataSet);
begin
  with Dados do
    if Report.Params.Count > 0 then
    begin
      Report.Params.ParamByName('Empresa').AsInteger    := Dados.Parametros.EmpresaAtiva;
      Report.Params.ParamByName('TipoEvento').AsInteger := dmSysEvt.RegKeys.TipoEvento;
      Report.Params.ParamByName('Evento').AsInteger     := dmSysEvt.RegKeys.Evento;
    end;
end;

procedure TCdEventos.EventosAfterOpen(Sender: TObject);
begin
  if pcControl.ActivePageIndex = 0 then
    if FBKEvents <> nil then
    begin
      try
        dmSysEvt.Evento.GotoBookMark(FBKEvents);
        dmSysEvt.Evento.FreeBookMark(FBKEvents);
      except
        FBKEvents := nil;
      end;
    end
    else
  else
    FSqlEvents := dmSysEvt.Evento.CommandText;
end;

procedure TCdEventos.FillclbSegments;
var
  i: Integer;
  Check: Boolean;
  BK: TBookMark;
begin
  with dmSysEvt do
  begin
    if not Segmentos.Active then
    begin
      Segmentos.SQL.Clear;
      Segmentos.SQL.Add(SqlSegmentos);
      Segmentos.Open;
    end;
    Segmentos.First;
    while not Segmentos.Eof do
    begin
      BK := Segmentos.GetBookmark;
      clbSegments.AddItem(Segmentos.FieldByName('DSC_SEG').AsString, BK);
      i                          := clbSegments.Items.Count - 1;
      RegKeys.Segmento           := Segmentos.FieldByName('PK_SEGMENTOS').AsInteger;
      Check                      := LocalizaPrecoSegmentos;
      clbSegments.Checked[i]     := Check;
      clbSegments.ItemEnabled[i] := not Check;
      Segmentos.Next;
    end;
  end;
  FFillBK := True;
  dmSysEvt.Segmentos.AfterScroll := HndEvtSegmentsAfterScroll;
end;

procedure TCdEventos.FreeDataclbSegments;
var
  i : Integer;
  BK: TBookMark;
begin
  dmSysEvt.Segmentos.AfterScroll := nil;
  with dmSysEvt do
  begin
    clbSegments.ItemIndex := 0;
    for i := 0 to clbSegments.Items.Count - 1 do
    begin
      BK := clbSegments.Items.Objects[i];
      try
        Segmentos.GotoBookmark(BK);
        Segmentos.FreeBookmark(BK);
      except
        Continue;
      end;
    end;
  end;
  clbSegments.Clear;
end;

procedure TCdEventos.tbCancelClick(Sender: TObject);
var
  Check: Boolean;
begin
  inherited;
  if pcControl.ActivePageIndex = 1 then
  begin
    Check := dmSysEvt.LocalizaPrecoSegmentos;
    clbSegments.Checked[clbSegments.ItemIndex]     := Check;
    clbSegments.ItemEnabled[clbSegments.ItemIndex] := not Check;
  end;
end;


procedure TCdEventos.tbPostClick(Sender: TObject);
begin
  if pcControl.ActivePageIndex = 1 then
  begin
    with dmSysEvt do
    begin
      try
       RegKeys.Segmento           := Segmentos.FieldByName('PK_SEGMENTOS').AsInteger;
       PrecoSeg.FieldByName('FK_SEGMENTOS').AsInteger := RegKeys.Segmento;
       clbSegments.ItemEnabled[clbSegments.ItemIndex] := False;
      except on E:Exception do
        begin
          Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE,
            'sPostError', 'Erro: Ocorreu um erro ao gravar o registro na tabela %s '),
            [dsMain.DataSet.Name]) + #13 + E.Message), PAnsiChar(Application.Title),
           MB_OK + MB_ICONSTOP);
          exit;
        end;
      end;
    end;
  end;
  inherited;
end;

procedure TCdEventos.tbDeleteClick(Sender: TObject);
begin
  FindListIndex;
  clbSegments.ItemEnabled[clbSegments.ItemIndex] := True;
  clbSegments.Checked[clbSegments.ItemIndex]     := False;
  inherited;
end;

procedure TCdEventos.clbSegmentsClick(Sender: TObject);
var
  i: Integer;
  KeyValue: Variant;
begin
  inherited;
  if DBStatus = dbmBrowse then
  begin
    i := clbSegments.ItemIndex;
    if (clbSegments.Items.Objects[i] <> nil) and
       (not clbSegments.ItemEnabled[i])      then
    begin
      dmSysEvt.Segmentos.GotoBookmark(clbSegments.Items.Objects[i]);
      KeyValue := dmSysEvt.Segmentos.FieldByName('PK_SEGMENTOS').Value;
      dmSysEvt.PrecoSeg.Locate('FK_SEGMENTOS', KeyValue, []);
    end
    else
      if (clbSegments.Checked[i])     and
         (clbSegments.ItemEnabled[i]) then
      begin
        DBStatus := dbmInsert;
        clbSegments.Selected[i] := True;
        with dmSysEvt do
        begin
          Segmentos.GotoBookmark(clbSegments.Items.Objects[i]);
          RegKeys.Segmento := Segmentos.FieldByName('PK_SEGMENTOS').AsInteger;
          PrecoSeg.FieldByName('FK_SEGMENTOS').AsInteger := RegKeys.Segmento;
        end;
      end;
  end;
end;

procedure TCdEventos.FindListIndex;
var
  i: Integer;
begin
  inherited;
  for i := 0 to clbSegments.Count - 1 do
    if AnsiCompareStr(PAnsiChar(clbSegments.Items.Objects[i])^,
                      dmSysEvt.Segmentos.Bookmark)              = 0 then
      break;
  if (i > -1) and (i < clbSegments.Count) then
    clbSegments.Selected[i] := True;
end;

end.
