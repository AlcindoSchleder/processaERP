unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvCreateProcess, StdCtrls, ComCtrls, ExtCtrls,
  RestTp;

type
  TfrmRestore = class(TForm)
    mResult: TMemo;
    cpRestore: TJvCreateProcess;
    tTimer: TTimer;
    procedure cpRestoreRead(Sender: TObject; const S: String;
      const StartsOnNewLine: Boolean);
    procedure cpRestoreTerminate(Sender: TObject; ExitCode: Cardinal);
    procedure FormShow(Sender: TObject);
    procedure tTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FAppPath : string;
    FAppRes  : Integer;
    FDBName  : string;
    FPasswd  : string;
    FDBBackup: string;
    FTypeProc: TTypeProc;
  public
    { Public declarations }
    property AppPath : string                   write FAppPath;
    property AppRes  : Integer   read  FAppRes;
    property DBBackup: string                   write FDBBackup;
    property DBName  : string                   write FDBName;
    property Passwd  : string                   write FPasswd;
    property TypeProc: TTypeProc                write FTypeProc;
  end;

var
  frmRestore: TfrmRestore;

implementation

{$R *.dfm}

procedure TfrmRestore.cpRestoreRead(Sender: TObject; const S: String;
  const StartsOnNewLine: Boolean);
begin
  mResult.Lines.Add(S);
end;

procedure TfrmRestore.cpRestoreTerminate(Sender: TObject;
  ExitCode: Cardinal);
begin
  FAppRes := ExitCode;
  tTimer.Enabled := True;
end;

procedure TfrmRestore.FormShow(Sender: TObject);
const
  COMMAND_LINE = 'C:\Arquivos de programas\Firebird\bin\gbak.exe';
  DB_PARAMS    : array[TTypeProc] of string =
      (' -V -P 4096 -R %s %s -user %s -pass %s',
       ' -V  %s %s -user %s -pass %s');
begin
  FAppRes := Handle;
  cpRestore.ApplicationName  := COMMAND_LINE;
  cpRestore.CurrentDirectory := FAppPath;
  cpRestore.CommandLine      := '"' + COMMAND_LINE + '"' +
    Format(DB_PARAMS[FTypeProc], [FDBName, FDBBackup, 'SYSDBA', FPasswd]);
  mResult.Lines.Add('Nome da Aplicação: ' + cpRestore.ApplicationName);
  mResult.Lines.Add('Executando: ' + cpRestore.CommandLine);
  mResult.Lines.Add('Diretório: ' + cpRestore.CurrentDirectory);
  mResult.Refresh;
  try
    cpRestore.Run;
  except
    Close;
  end;
end;

procedure TfrmRestore.tTimerTimer(Sender: TObject);
begin
  tTimer.Enabled := False;
  mResult.Refresh;
  Close;
end;

end.


