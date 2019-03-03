unit CadRot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadListMod, StdCtrls;

type
  TfrmRotine = class(TfrmModel)
    lPk_Rotinas: TStaticText;
    ePk_Rotinas: TEdit;
    eDsc_Rot: TEdit;
    lDsc_Rot: TStaticText;
    stTitle: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRotine: TfrmRotine;

implementation

{$R *.dfm}

end.
