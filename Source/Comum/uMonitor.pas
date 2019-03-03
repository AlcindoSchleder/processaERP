unit uMonitor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit, SqlExpr, Buttons, ExtCtrls;

type
  TfrmMonitor = class(TForm)
    vlListMonitor: TValueListEditor;
    pBar: TPanel;
    sbClose: TSpeedButton;
    procedure vlListMonitorSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMonitor: TfrmMonitor;

implementation

uses Dado, PopUpText;

{$R *.dfm}

procedure TfrmMonitor.vlListMonitorSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if not Assigned(frmMemo) then
    frmMemo := TfrmMemo.Create(Self);
  with frmMemo do
  begin
    pCommand.Caption := vlListMonitor.Strings.ValueFromIndex[ARow - 1];
    frmMemo.Top  := 42 + (ARow * 18);
    frmMemo.Left := 135;
    ShowModal;
  end;
end;

procedure TfrmMonitor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(frmMemo) then
  begin
    frmMemo.Close;
    frmMemo.Free;
  end;
  frmMemo := nil;
end;

procedure TfrmMonitor.sbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMonitor.FormCreate(Sender: TObject);
begin
  Top  := 0;
  Left := 0;
end;

procedure TfrmMonitor.FormShow(Sender: TObject);
begin
  vlListMonitor.Strings.Add(DateTimeToStr(Now) + '=' + 'Monitor do Banco de Dados Ativado');
end;

initialization
  RegisterClass(TfrmMonitor);

end.
