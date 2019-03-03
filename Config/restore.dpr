library restore;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  Dialogs,
  Forms,
  Controls,
  Main in 'Main.pas' {frmRestore},
  RestTp in 'RestTp.pas';

{$R *.res}

function RestoreDataBase(AHandle, AType, AWidth, AHeight: Cardinal; APwd, ADB, ADBBck,
           InstallPath: PChar): Integer; stdcall;
const
  TYPE_PROCESS : array[TTypeProc] of string =
      ('Restauração', 'Backup');
begin
  with TfrmRestore.Create(Application) do
  begin
    try
      ParentWindow := AHandle;
      BorderStyle  := bsNone;
      Top          := 0;
      Left         := 0;
      Width        := AWidth;
      Height       := AHeight;
      AppPath      := StrPas(InstallPath);
      DBBackup     := StrPas(ADBBck);
      DBName       := StrPas(ADB);
      Passwd       := StrPas(APwd);
      TypeProc     := TTypeProc(AType);
      ShowModal;
      Result       := AppRes;
    finally
      Free;
    end;
  end;
end;

exports RestoreDataBase;

begin
end.
