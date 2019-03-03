unit CadRes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Encryp, QExportDialog, Enter, DB, Menus,
  Buttons, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  Mask;

type
  TCdResources = class(TCdModelo)
    lPk_Resources: TLabel;
    ePk_Resources: TDBEdit;
    lFk_Operadores: TLabel;
    eFk_Operadores: TDBLookupComboBox;
    lDsc_Res: TLabel;
    pNotes: TPanel;
    pCaptions: TPanel;
    eObs_Res: TDBMemo;
    eObs_User: TDBMemo;
    lObs_User: TStaticText;
    lObs_Res: TStaticText;
    lFlag_Atv: TDBCheckBox;
    Operadores: TDataSource;
    eDsc_Res: TDBMemo;
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
  CdResources: TCdResources;

implementation

uses mSysCrm, ArqSql;

const
  SYNC_FROM   =
  '  from RESOURCES Res                                                      ' + #13 +
  '  left outer join OPERADORES Ope on Ope.PK_OPERADORES = Res.FK_OPERADORES ';

{$R *.dfm}

procedure TCdResources.FormCreate(Sender: TObject);
begin
  MoveCampos     := True;
  inherited;
  eSearch.CharCase := ecUpperCase;
  dsMain.DataSet := dmSysCrm.Resource;
  MainFileName   := 'RESOURCES';
  MainPrefix     := 'Res';
  NullSql        := 'PK_RESOURCES is null';
  DefControl     := eFk_Operadores;
  VisibleEntrp   := False;
  PrimaryKey     := 'PK_RESOURCES';
  SyncFrom.Add(SYNC_FROM);
  SyncFields.Add('FK_OPERADORES=Ope.PK_OPERADORES');
end;

procedure TCdResources.FechaArquivos(DS: TDataSource);
begin
  with dmSysCrm do
    if Operadores.Active then Operadores.Close;
  inherited;
end;

procedure TCdResources.PesquisaRegistros;
begin
  inherited;
  with dmSysCrm do
  begin
    if not Operadores.Active then
    begin
      Operadores.SQL.Clear;
      Operadores.SQL.Add(SqlOperadores);
      Operadores.Open;
    end;
  end;
end;

end.
