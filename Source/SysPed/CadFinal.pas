unit CadFinal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Menus, DataManager, Encryp, Enter, ComCtrls, ToolWin,
  VirtualTrees, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit;

type
  TCdFinaliza = class(TCdModelo)
    lDsc_MPgt: TStaticText;
    eDsc_MPgt: TEdit;
    lPk_Finalizadoras: TStaticText;
    ePk_Finalizadoras: TEdit;
    lFlag_TFin: TRadioGroup;
    lCod_Tecla: TStaticText;
    gbParams: TGroupBox;
    lFlag_Cli: TCheckBox;
    lFlag_Bnc: TCheckBox;
    lFlag_Trc: TCheckBox;
    eCod_Tecla: TCurrencyEdit;
    lFlag_Tef: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CdFinaliza: TCdFinaliza;

implementation

uses mSysPed, CmmConst, ModelTyp, PedArqSql;

{$R *.dfm}

procedure TCdFinaliza.FormCreate(Sender: TObject);
begin
  dsMain.DataSet       := dmSysPed.Finalizadora;
  dsMain.TableName     := 'FINALIZADORAS';
  dsMain.MethodExecSql := dmSysPed.Finalizadora.ExecSQL;
  dsMain.MainPrefix    := 'Fin';
  dsMain.PrimaryKey.Add('PK_FINALIZADORAS');
  dsMain.GeneratorSql.Add(SqlGenFinalizadora);
  inherited;
end;

initialization
  RegisterClass(TCdFinaliza);

end.
