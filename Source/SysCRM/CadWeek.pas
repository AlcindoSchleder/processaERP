unit CadWeek;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VpBase, VpBaseDS, VpWeekView;

type
  TfrmWeek = class(TForm)
    vpWeekView: TVpWeekView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWeek: TfrmWeek;

implementation

{$R *.dfm}

end.
