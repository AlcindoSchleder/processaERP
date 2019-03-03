unit uSelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, VirtualTrees;

type
  TfrmSelection = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelection: TfrmSelection;

implementation

{$R *.dfm}

uses Dado;

procedure TfrmSelection.FormCreate(Sender: TObject);
begin
  Dados.Image16.GetBitmap(66, sbFilter.Glyph);
  iBarEventos.Visible       := Dados.Parametros.FlagEvent;
  vtEventos.Visible         := iBarEventos.Visible;
end;

end.
