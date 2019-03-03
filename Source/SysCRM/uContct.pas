unit uContct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, VpContactButtons, VpBase, VpBaseDS, VpContactGrid;

type
  TfrmContact = class(TForm)
    pManContact: TPanel;
    vpContactGrid: TVpContactGrid;
    cbbContacts: TVpContactButtonBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContact: TfrmContact;

implementation

{$R *.dfm}

end.
