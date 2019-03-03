unit PrcDBInfo;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses SysUtils, Classes, SqlExpr,
  {$IFDEF LINUX}
    Libc
  {$ELSE}
    Windows
  {$ENDIF};

type
  IDBInfo = interface(IInterface)
    ['{4B9681EE-C5B5-477A-91E4-1AD3AED14DA1}']
    // Functions to get database info
    procedure Attach;
    procedure Detach;
    function  AddUser(const AUserName, APassword, AFirstName, AMiddleName,
                        ALastName, ARole: string): Boolean;
    function  BackupDataBase(const ANameFile: string): Boolean;
    function  DeleteUser(const AUserName: string): Boolean;
    function  GetConectedUserNames: TStrings;
    function  GetUserNames: TStrings;
    function  ModifyUser(const AUserName, APassword, AFirstName, AMiddleName,
                           ALastName, ARole: string): Boolean;
    function  RestoreDataBase(const ANameFile: string): Boolean;
    function  ValidationDataBase: Boolean;
    function  GetLibraryProc(var X: Pointer; const AProcName: string): Boolean;
    function  GetDataBaseInfo: TStrings;
    property  DataBaseInfo: TStrings read GetDataBaseInfo;
  end;

  TServiceAction     = (saAddUser, saBackupDataBase, saDeleteUser, saModifyUser,
                        saRestoreDataBase, saValidationDataBase);

  TListServiceAction = (lsaUsers, lsaConnectedUsers);

    { TPrcDBInfo }

  TPrcDBInfo = class(TInterfacedPersistent, IDBInfo)
  protected
    { protected declarations }
    procedure Attach; virtual; abstract;
    procedure Detach; virtual; abstract;
  private
    { private declarations }
    FDataBaseName: string;
    FLibHandle   : Cardinal;
    FLibName     : string;
    FPassword    : string;
    FUser        : string;
    function  GetDataBaseName: string;
    function  GetServerName: string;
  public
    { public declarations }
    constructor Create(ADataBase: TSqlConnection; const ADataBaseName, ASysDBA,
                  APassword: string); reintroduce; dynamic;
    destructor  Destroy; override;
    function  AddUser(const AUserName, APassword, AFirstName, AMiddleName,
                ALastName, ARole: string): Boolean; virtual; abstract;
    function  BackupDataBase(const ANameFile: string): Boolean; virtual; abstract;
    function  DeleteUser(const AUserName: string): Boolean; virtual; abstract;
    function  GetConectedUserNames: TStrings; virtual; abstract;
    function  GetUserNames: TStrings; virtual; abstract;
    function  ModifyUser(const AUserName, APassword, AFirstName, AMiddleName,
                ALastName, ARole: string): Boolean; virtual; abstract;
    function  RestoreDataBase(const ANameFile: string): Boolean; virtual; abstract;
    function  ValidationDataBase: Boolean; virtual; abstract;
    function  GetLibraryProc(var X: Pointer; const AProcName: string): Boolean;
    function  GetDataBaseInfo: TStrings; virtual; abstract;
    property  DataBaseName: string   read GetDataBaseName;
    property  LibName     : string   read FLibName      write FLibName;
    property  LibHandle   : Cardinal read FLibHandle;
    property  Password    : string   read FPassword     write FPassword;
    property  ServerName  : string   read GetServerName;
    property  User        : string   read FUser         write FUser;
    property  DataBaseInfo: TStrings read GetDataBaseInfo;
  published
    { published declareations }
  end;

implementation

  { TPrcDBInfo }

constructor TPrcDBInfo.Create(ADataBase: TSqlConnection; const ADataBaseName,
              ASysDBA, APassword: string);
begin
  inherited Create;
  FUser         := ASysDba;
  FPassword     := APassword;
  if (ADataBase = nil) then
    FDataBaseName := ADataBaseName
  else
    FDataBaseName := ADataBase.Params.Values['DataBase'];
  FLibHandle      := 0;
  FLibName        := '';
end;

destructor  TPrcDBInfo.Destroy;
begin
  inherited Destroy;
end;

function  TPrcDBInfo.GetDataBaseName: string;
begin
  Result := FDataBaseName;
end;

function  TPrcDBInfo.GetServerName: string;
begin
  Result := Copy(FDataBaseName, 1, Pos(':', FDataBaseName) - 1);
  if (Result = '') or (Length(Result) = 1) then
    Result := 'localhost';
end;

function  TPrcDBInfo.GetLibraryProc(var X: Pointer; const AProcName: string): Boolean;
begin
  if (FLibName = '') then
    raise Exception.Create('Erro: Nome da Biblioteca nula');
  FLibHandle := LoadLibrary(PAnsiChar(FLibName));
  if FLibHandle <> 0 then
    X := GetProcAddress(FLibHandle, PAnsiChar(AProcName));
  Result := Assigned(X);
end;

end.
