unit CadCota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Encryp, SyncSource, QExportDialog, Enter, DB, Menus,
  Buttons, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  VirtualTrees, CSDVirtualStringTree, Mask, ToolEdit, RXDBCtrl;

type
  TCdCotacoes = class(TCdModelo)
    pgQuotation: TPageControl;
    tsCotation: TTabSheet;
    tsMissingProducts: TTabSheet;
    tsRanking: TTabSheet;
    vtSupplier: TCSDVirtualStringTree;
    pQuotation: TPanel;
    pSupplier: TPanel;
    pFilter: TPanel;
    vtProducts: TCSDVirtualStringTree;
    vtRanking: TCSDVirtualStringTree;
    lPk_Insumos: TLabel;
    ePk_Insumos: TDBEdit;
    lDsc_Ins: TLabel;
    eDsc_Ins: TDBEdit;
    lDta_UCmp: TLabel;
    lFk_Secoes: TLabel;
    lFk_Grupos: TLabel;
    lFk_SubGrupos: TLabel;
    Label1: TLabel;
    sbSearch: TSpeedButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Edit2: TEdit;
    Label2: TLabel;
    eDta_UCmp: TDBDateEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdCotacoes: TCdCotacoes;

implementation

uses Dado;

{$R *.dfm}

end.
