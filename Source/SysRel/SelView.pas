unit SelView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, StdCtrls, ExtCtrls;

type
  TfrmDataView = class(TForm)
    pOptions: TPanel;
    rgPrintOpt: TRadioGroup;
    vtListData: TVirtualStringTree;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDataView: TfrmDataView;

implementation

{$R *.dfm}

end.
