unit UTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VpBase, VpBaseDS, VpTaskList;

type
  TfrmTasks = class(TForm)
    VpTaskList: TVpTaskList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTasks: TfrmTasks;

implementation

{$R *.dfm}

end.
