unit PopUpText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmMemo = class(TForm)
    pCommand: TPanel;
    sbClose: TSpeedButton;
    procedure sbCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMemo: TfrmMemo;

implementation

{$R *.dfm}

procedure TfrmMemo.sbCloseClick(Sender: TObject);
begin
  Close;
end;

end.
