unit SelFields;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, VirtualTrees, StdCtrls;

type
  TfrmDualSelect = class(TForm)
    stSelFields: TStaticText;
    vtSelTableFields: TVirtualStringTree;
    pFieldsBtns: TPanel;
    sbGetField: TSpeedButton;
    sbRetAllField: TSpeedButton;
    sbGetAllField: TSpeedButton;
    sbRetField: TSpeedButton;
    shLine: TShape;
    vtvtSelectedFields: TVirtualStringTree;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDualSelect: TfrmDualSelect;

implementation

{$R *.dfm}

end.
