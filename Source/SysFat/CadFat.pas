unit CadFat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, CurrEdit, StdCtrls, Mask, ToolEdit,
  VirtualTrees, ExtCtrls;

type
  TfrmFatura = class(TForm)
    pgFaturamento: TPageControl;
    tsSearch: TTabSheet;
    tsFat: TTabSheet;
    MainMenu1: TMainMenu;
    Faturamento1: TMenuItem;
    miOS: TMenuItem;
    miRequest: TMenuItem;
    miOrder: TMenuItem;
    N1: TMenuItem;
    miInvoice: TMenuItem;
    miSelItems: TMenuItem;
    N2: TMenuItem;
    pSearch: TPanel;
    pgDocuments: TPageControl;
    tsDocuments: TTabSheet;
    tsItens: TTabSheet;
    CSDVirtualStringTree1: TVirtualStringTree;
    stDocument: TStaticText;
    CSDVirtualStringTree2: TVirtualStringTree;
    lDtaDoc: TLabel;
    eDtaDoc: TDateEdit;
    Label1: TLabel;
    cbStatusDoc: TComboBox;
    lTipoDoc: TLabel;
    ComboBox1: TComboBox;
    lFkCadastros: TLabel;
    ComboBox2: TComboBox;
    Label2: TLabel;
    eNumDoc: TCurrencyEdit;
    lFkClassificacao: TLabel;
    ComboBox3: TComboBox;
    cbTools: TCoolBar;
    tbOperations: TToolBar;
    tbOS: TToolButton;
    tbRequest: TToolButton;
    tbOrder: TToolButton;
    ToolButton4: TToolButton;
    tbSelItens: TToolButton;
    ToolButton7: TToolButton;
    tbFatura: TToolButton;
    ToolButton9: TToolButton;
    tbSearch: TToolButton;
    tbClose: TToolButton;
    ToolButton2: TToolButton;
    N3: TMenuItem;
    miClose: TMenuItem;
    N4: TMenuItem;
    miSearch: TMenuItem;
    Panel2: TPanel;
    Shape3: TShape;
    Shape1: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    cbGrupoMovimento: TComboBox;
    edNUM_DOC: TCurrencyEdit;
    cbFK_CADASTROS: TComboBox;
    edVLR_STOT: TCurrencyEdit;
    edVLR_ACR_DSCT: TCurrencyEdit;
    edVAL_TOT: TCurrencyEdit;
    edOBS_DOC: TMemo;
    chkFLAG_BXAC: TCheckBox;
    chkFLAG_CANC: TCheckBox;
    dtDATA_EMISSAO: TDateEdit;
    Panel1: TPanel;
    Label12: TLabel;
    Panel4: TPanel;
    Label13: TLabel;
    stDuplicatas: TVirtualStringTree;
    procedure miCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFatura: TfrmFatura;

implementation

uses Dado;

{$R *.dfm}

procedure TfrmFatura.miCloseClick(Sender: TObject);
begin
  Close;
end;

end.
