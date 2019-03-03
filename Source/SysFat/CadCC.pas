unit CadCC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Menus, DataManager, Encryp, Enter, ComCtrls, ToolWin,
  VirtualTrees, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit;

type
  TCdCentroCustos = class(TCdModelo)
    lDsc_CCst: TStaticText;
    eDsc_CCst: TEdit;
    lPk_Centro_Custos: TStaticText;
    ePk_Centro_Custos: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdCentroCustos: TCdCentroCustos;

implementation

uses mSysFat;

{$R *.dfm}

procedure TCdCentroCustos.FormCreate(Sender: TObject);
begin
  dsMain.DataSet   := dmSysFat.qrCenterCost;
  dsMain.TableName  := 'CENTRO_CUSTOS';
  dsMain.MainPrefix := 'Cct';
  dsMain.PrimaryKey.Add('PK_CENTRO_CUSTOS');
  inherited;
end;

initialization
  RegisterClass(TCdCentroCustos);
  
end.
