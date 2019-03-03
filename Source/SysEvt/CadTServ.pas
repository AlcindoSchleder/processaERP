unit CadTServ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Enter, DB, ImgList, Menus, Buttons, StdCtrls, DBCtrls,
  ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin, Mask, SyncSource,
  QExportDialog, Encryp, JvToolEdit, JvCurrEdit, JvDBCtrl;

type
  TCdTipoServicos = class(TCdModelo)
    lDsc_TSrv: TLabel;
    eDsc_TSrv: TDBEdit;
    lPk_Tipo_Servicos: TLabel;
    ePk_Tipo_Servicos: TDBEdit;
    eFk_Unidades: TDBLookupComboBox;
    lFk_Unidades: TLabel;
    Unidades: TDataSource;
    lVlr_TSrv: TLabel;
    eVlr_TSrv: TJvDBCalcEdit;
    procedure FormCreate(Sender: TObject);
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
  CdTipoServicos: TCdTipoServicos;

implementation

uses mSysEvt, ArqSql;

{$R *.dfm}

const
  SYNC_FROM   =
  '  from TIPO_SERVICOS Tsr                                            ' + #13 +
  '  left outer join UNIDADES Uni on Uni.PK_UNIDADES = Tsr.FK_UNIDADES ';

procedure TCdTipoServicos.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  dsMain.DataSet := dmSysEvt.TipoServico;
  MainFileName   := 'TIPO_SERVICOS';
  MainPrefix     := 'Tsr';
  NullSql        := 'Tsr.PK_TIPO_SERVICOS is null';
  PrimaryKey     := 'PK_TIPO_SERVICOS';
  DefControl     := eDsc_TSrv;
  VisibleEntrp   := False;
  SyncFrom.Add(SYNC_FROM);
  SyncFields.Add('FK_UNIDADES=Uni.DSC_UNI');
end;

procedure TCdTipoServicos.FechaArquivos(DS: TDataSource);
begin
  with dmSysEvt do
    if Unidades.Active    then Unidades.Close;
  inherited;
end;

procedure TCdTipoServicos.PesquisaRegistros;
begin
  inherited;
  with dmSysEvt do
    if not Unidades.Active then
    begin
      Unidades.SQL.Clear;
      Unidades.SQL.Add(SqlUnidades);
      Unidades.Open;
    end;
end;

end.
