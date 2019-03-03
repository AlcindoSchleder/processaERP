unit PrcIBFBInfo;

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

uses
  SysUtils, Classes, PrcDBInfo, SqlExpr, DBXpress;

const
{$IFDEF MSWINDOWS}
  IBASE_DLL    = 'gds32.dll';
  FIREBIRD_DLL = 'fbclient.dll';
{$ENDIF}
{$IFDEF LINUX}
  IBASE_DLL    = 'libgds.so.0';
  FIREBIRD_DLL = 'fbclient.so.0';
{$ENDIF}

  BUFFER_LEN          = 512;
  BIG_BUFFER_LEN      = BUFFER_LEN     * 2;
  HUGE_BUFFER_LEN     = BIG_BUFFER_LEN * 20;
  HUGE_32K_BUFFER_LEN = BIG_BUFFER_LEN * 32;

(******************************)
(** Common, structural codes **)
(******************************)

  isc_info_end                   = 1;
  isc_info_truncated             = 2;
  isc_info_error                 = 3;
  isc_info_data_not_ready	       = 4;
  isc_info_flag_end	          	 = 127;

(********************************)
(** Database information items **)
(********************************)

  isc_info_db_id                 =          4;
  isc_info_version               =         12;
  isc_info_page_size             =         14;
  isc_info_current_memory        =         17;
  isc_info_max_memory            =         18;
  isc_info_insert_count          =         25;
  isc_info_update_count          =         26;
  isc_info_delete_count          =         27;
  isc_info_sweep_interval        =         31;
  isc_info_forced_writes         =         52;
  isc_info_user_names            =         53;
  isc_info_db_SQL_dialect        =         62;
  isc_info_db_read_only          =         63;
//  isc_info_att_charset		       =         70;

(*****************************************)
(* Service action items                 **)
(*****************************************)

  isc_action_svc_backup         = 1; (* Starts database backup process on the server *)
  isc_action_svc_restore        = 2; (* Starts database restore process on the server *)
  isc_action_svc_repair         = 3; (* Starts database repair process on the server *)
  isc_action_svc_add_user       = 4; (* Adds a new user to the security database *)
  isc_action_svc_delete_user    = 5; (* Deletes a user record from the security database *)
  isc_action_svc_modify_user    = 6; (* Modifies a user record in the security database *)
  isc_action_svc_display_user   = 7; (* Displays a user record from the security database *)
  isc_action_svc_properties     = 8; (* Sets database properties *)

(************************************)
(** Database parameter block stuff **)
(************************************)

  isc_dpb_version1               =          1;
//  isc_dpb_cdd_pathname           =          1;
//  isc_dpb_allocation             =          2;
//  isc_dpb_journal                =          3;
  isc_dpb_page_size              =          4;
  isc_dpb_num_buffers            =          5;
  isc_dpb_buffer_length          =          6;
  isc_dpb_debug                  =          7;
  isc_dpb_garbage_collect        =          8;
  isc_dpb_verify                 =          9;
//  isc_dpb_sweep                  =         10;
//  isc_dpb_enable_journal         =         11;
//  isc_dpb_disable_journal        =         12;
//  isc_dpb_dbkey_scope            =         13;
  isc_dpb_number_of_users        =         14;
//  isc_dpb_trace                  =         15;
//  isc_dpb_no_garbage_collect     =         16;
//  isc_dpb_damaged                =         17;
//  isc_dpb_license                =         18;
  isc_dpb_sys_user_name          =         19;
//  isc_dpb_encrypt_key            =         20;
//  isc_dpb_activate_shadow        =         21;
//  isc_dpb_sweep_interval         =         22;
//  isc_dpb_delete_shadow          =         23;
//  isc_dpb_force_write            =         24;
//  isc_dpb_begin_log              =         25;
//  isc_dpb_quit_log               =         26;
//  isc_dpb_no_reserve             =         27;
  isc_dpb_user_name              =         28;
  isc_dpb_password               =         29;
  isc_dpb_password_enc           =         30;
  isc_dpb_sys_user_name_enc      =         31;
//  isc_dpb_interp                 =         32;
//  isc_dpb_online_dump            =         33;
//  isc_dpb_old_file_size          =         34;
//  isc_dpb_old_num_files          =         35;
//  isc_dpb_old_file               =         36;
//  isc_dpb_old_start_page         =         37;
//  isc_dpb_old_start_seqno        =         38;
//  isc_dpb_old_start_file         =         39;
//  isc_dpb_drop_walfile           =         40;
//  isc_dpb_old_dump_id            =         41;
//  isc_dpb_wal_backup_dir         =         42;
//  isc_dpb_wal_chkptlen           =         43;
//  isc_dpb_wal_numbufs            =         44;
//  isc_dpb_wal_bufsize            =         45;
//  isc_dpb_wal_grp_cmt_wait       =         46;
//  isc_dpb_lc_messages            =         47;
//  isc_dpb_lc_ctype               =         48;
//  isc_dpb_cache_manager          =         49;
//  isc_dpb_shutdown               =         50;
//  isc_dpb_online                 =         51;
//  isc_dpb_shutdown_delay         =         52;
//  isc_dpb_reserved               =         53;
//  isc_dpb_overwrite              =         54;
//  isc_dpb_sec_attach             =         55;
//  isc_dpb_disable_wal            =         56;
  isc_dpb_connect_timeout        =         57;
  isc_dpb_dummy_packet_interval  =         58;
//  isc_dpb_gbak_attach            =         59;
  isc_dpb_sql_role_name          =         60;
//  isc_dpb_set_page_buffers       =         61;
//  isc_dpb_working_directory      =         62;
//  isc_dpb_SQL_dialect            =         63;
//  isc_dpb_set_db_readonly        =         64;
//  isc_dpb_set_db_SQL_dialect     =         65;
//  isc_dpb_gfix_attach		 =         66;
//  isc_dpb_gstat_attach		 =         67;
//  isc_dpb_last_dpb_constant      =         isc_dpb_gstat_attach;
//  isc_dpb_gbak_ods_version       =         68;
//  isc_dpb_gbak_ods_minor_version =         69;
//  isc_dpb_set_group_commit	     =         70;
//  isc_dpb_gbak_validate          =         71;

(***********************************)
(** isc_dpb_verify specific flags **)
(***********************************)

//  isc_dpb_pages                  =          1;
//  isc_dpb_records                =          2;
//  isc_dpb_indices                =          4;
//  isc_dpb_transactions           =          8;
//  isc_dpb_no_update              =         16;
//  isc_dpb_repair                 =         32;
//  isc_dpb_ignore                 =         64;

(*************************************)
(** isc_dpb_shutdown specific flags **)
(*************************************)

//  isc_dpb_shut_cache             =          1;
//  isc_dpb_shut_attachment        =          2;
//  isc_dpb_shut_transaction       =          4;
//  isc_dpb_shut_force             =          8;

(****************************************)
(** Bit assignments in RDB$SYSTEM_FLAG **)
(****************************************)

//  RDB_system                     =          1;
//  RDB_id_assigned                =          2;

(***************************************)
(** Transaction parameter block stuff **)
(***************************************)

//  isc_tpb_version1               =          1;
//  isc_tpb_version3               =          3;
//  isc_tpb_consistency            =          1;
//  isc_tpb_concurrency            =          2;
//  isc_tpb_shared                 =          3;
//  isc_tpb_protected              =          4;
//  isc_tpb_exclusive              =          5;
//  isc_tpb_wait                   =          6;
//  isc_tpb_nowait                 =          7;
//  isc_tpb_read                   =          8;
//  isc_tpb_write                  =          9;
//  isc_tpb_lock_read              =         10;
//  isc_tpb_lock_write             =         11;
//  isc_tpb_verb_time              =         12;
//  isc_tpb_commit_time            =         13;
//  isc_tpb_ignore_limbo           =         14;
//  isc_tpb_read_committed         =         15;
//  isc_tpb_autocommit             =         16;
//  isc_tpb_rec_version            =         17;
//  isc_tpb_no_rec_version         =         18;
//  isc_tpb_restart_requests       =         19;
//  isc_tpb_no_auto_undo           =         20;
//  isc_tpb_last_tpb_constant      =         isc_tpb_no_auto_undo;

(***********************************)
(** Service parameter block stuff **)
(***********************************)

  isc_spb_user_name              =          1;
//  isc_spb_sys_user_name          =          2;
//  isc_spb_sys_user_name_enc      =          3;
  isc_spb_password               =          4;
//  isc_spb_password_enc           =          5;
//  isc_spb_command_line           =          6;
//  isc_spb_dbname                 =          7;
//  isc_spb_verbose                =          8;
//  isc_spb_options                =          9;
//  isc_spb_connect_timeout        =          10;
//  isc_spb_dummy_packet_interval  =          11;
  isc_spb_sql_role_name          =          12;
  isc_spb_last_spb_constant      =          isc_spb_sql_role_name;
  isc_spb_current_version                         = 2;
  isc_spb_version		                              = isc_spb_current_version;
  isc_spb_user_name_mapped_to_server              = isc_dpb_user_name;
  isc_spb_sys_user_name_mapped_to_server          = isc_dpb_sys_user_name;
  isc_spb_sys_user_name_enc_mapped_to_server      = isc_dpb_sys_user_name_enc;
  isc_spb_password_mapped_to_server               = isc_dpb_password;
  isc_spb_password_enc_mapped_to_server           = isc_dpb_password_enc;
  isc_spb_command_line_mapped_to_server           = 105;
  isc_spb_dbname_mapped_to_server                 = 106;
  isc_spb_verbose_mapped_to_server                = 107;
  isc_spb_options_mapped_to_server                = 108;
  isc_spb_connect_timeout_mapped_to_server        = isc_dpb_connect_timeout;
  isc_spb_dummy_packet_interval_mapped_to_server  = isc_dpb_dummy_packet_interval;
  isc_spb_sql_role_name_mapped_to_server          = isc_dpb_sql_role_name;

(*****************************************)
(** Service information items           **)
(*****************************************)
  isc_info_svc_get_users	= 68; (* Returns the user information from isc_action_svc_display_users *)

(******************************************************)
(* Parameters for isc_action_{add|delete|modify)_user *)
(******************************************************)

  isc_spb_sec_userid            = 5;
  isc_spb_sec_groupid           = 6;
  isc_spb_sec_username          = 7;
  isc_spb_sec_password          = 8;
  isc_spb_sec_groupname         = 9;
  isc_spb_sec_firstname         = 10;
  isc_spb_sec_middlename        = 11;
  isc_spb_sec_lastname          = 12;

  SPBPrefix = 'isc_spb_';
  SPBConstantNames: array[1..isc_spb_last_spb_constant] of String = (
    'user_name',
    'sys_user_name',
    'sys_user_name_enc',
    'password',
    'password_enc',
    'command_line',
    'db_name',
    'verbose',
    'options',
    'connect_timeout',
    'dummy_packet_interval',
    'sql_role_name'
  );

  SPBConstantValues: array[1..isc_spb_last_spb_constant] of Integer = (
    isc_spb_user_name_mapped_to_server,
    isc_spb_sys_user_name_mapped_to_server,
    isc_spb_sys_user_name_enc_mapped_to_server,
    isc_spb_password_mapped_to_server,
    isc_spb_password_enc_mapped_to_server,
    isc_spb_command_line_mapped_to_server,
    isc_spb_dbname_mapped_to_server,
    isc_spb_verbose_mapped_to_server,
    isc_spb_options_mapped_to_server,
    isc_spb_connect_timeout_mapped_to_server,
    isc_spb_dummy_packet_interval_mapped_to_server,
    isc_spb_sql_role_name_mapped_to_server
  );

type
  { IIBFB_DBInfo }

  TBackupOptions  = set of (boIgnoreChecksums, boIgnoreLimbo, boMetadaOnly,
                            boNoGarbageCollection, boOldMetadataDesc,
                            boNonTransportable, boConvertExtTables, boVerbose);

  TRestoreOptions = set of (roDeactivateIndexes, roNoShadow, roValidityCheck,
                            roOneRelationAtATime, roReplace, roCreateNewDB,
                            roUseAllSpace, roValidationCheck, oVerbose);

  TPageSize       = (ps1024, ps2038, ps4096, ps8192);

  TGlobalAction   = (gaCommitGlobal, gaNoGlobalAction, gaRecoverTwoPhaseGlobal,
                     gaRollbackGlobal);

  TValidationOpts = set of (voLimboTransactions, voCheckDB, voIgoreChecksum,
                            voKillShadows, voMendDB, voSweepDB, voValidateDB,
                            voValidateFull);

  TISC_SVC_HANDLE               = Pointer;
  PISC_SVC_HANDLE               = ^TISC_SVC_HANDLE;

  ISC_STATUS           = LongInt;    { 32 bit signed }
  PISC_STATUS          = ^ISC_STATUS;

  TStatusVector              = array[0..19] of ISC_STATUS;
  PStatusVector              = ^TStatusVector;

  TDatabaseType = (dtInterbase, dtFirebird);

  // Interbase and Firebird Functions

  Tisc_service_attach = function  (status_vector             : PISC_STATUS;
                                   isc_arg2                  : Word;
                                   isc_arg3                  : PChar;
                                   service_handle            : PISC_SVC_HANDLE;
                                   isc_arg5                  : Word;
                                   isc_arg6                  : PChar): ISC_STATUS;
                                  {$IFDEF LINUX} cdecl; {$ELSE} stdcall; {$ENDIF}

  Tisc_service_detach = function (status_vector             : PISC_STATUS;
                                  service_handle            : PISC_SVC_HANDLE): ISC_STATUS;
                                  {$IFDEF LINUX} cdecl; {$ELSE} stdcall; {$ENDIF}

  Tisc_service_start  = function  (status_vector             : PISC_STATUS;
                                   service_handle            : PISC_SVC_HANDLE;
                                   recv_handle               : PISC_SVC_HANDLE;
                                   isc_arg4                  : Smallint;
                                   isc_arg5                  : PChar): ISC_STATUS;
                                  {$IFDEF LINUX} cdecl; {$ELSE} stdcall; {$ENDIF}

  Tisc_service_query = function   (status_vector             : PISC_STATUS;
                                   service_handle            : PISC_SVC_HANDLE;
                                   recv_handle               : PISC_SVC_HANDLE;
                                   isc_arg4                  : Word;
                                   isc_arg5                  : PAnsiChar;
                                   isc_arg6                  : Word;
                                   isc_arg7                  : PAnsiChar;
                                   isc_arg8                  : Word;
                                   isc_arg9                  : PAnsiChar): ISC_STATUS;
                                  {$IFDEF LINUX} cdecl; {$ELSE} stdcall; {$ENDIF}

  Tisc_vax_integer = function     (buffer                    : PAnsiChar;
	                                 length                    : SmallInt): LongInt;
                                  {$IFDEF LINUX} cdecl; {$ELSE} stdcall; {$ENDIF}

  Tisc_database_info = function   (status_vector            : PISC_STATUS;
	                                 db_handle                : PISC_SVC_HANDLE;
                                   item_list_buffer_length  : SmallInt;
                                   item_list_buffer         : PAnsiChar;
                                   result_buffer_length     : SmallInt;
                                   result_buffer            : PAnsiChar): ISC_STATUS;
                                  {$IFDEF LINUX} cdecl; {$ELSE} stdcall; {$ENDIF}

  IIBFB_DBInfo = interface(IDBInfo)
    ['{78E8F3CC-013D-4FB8-83C0-8FA49F074AE7}']
    // Component methods
    function  StatusVector: PISC_STATUS;
    function  GenerateSPB(AParams: TStrings; var ASPBLength: SmallInt): string;
    function  StartService(AParams: string): Boolean;
    function  GetBackupOptions: TBackupOptions;
    procedure SetBackupOptions(AValue: TBackupOptions);
    function  GetDataBaseType: TDataBaseType;
    procedure SetDataBaseType(AValue: TDataBaseType);
    function  GetRestoreOptions: TRestoreOptions;
    procedure SetRestoreOptions(AValue: TRestoreOptions);
    function  GetPageSize: TPageSize;
    procedure SetPageSize(AValue: TPageSize);
    function  GetValidationOpts: TValidationOpts;
    procedure SetValidationOpts(AValue: TValidationOpts);
    function  ServiceStartAddParam (AValue: string; AParam: Integer): string; overload;
    function  ServiceStartAddParam (AValue: Integer; AParam: Integer): string; overload;
    function  GetDBFileName: string;
    function  GetDBSiteName: string;
    function  GetInfoPageSize: LongInt;
    function  GetVersion: string;
    function  GetCurrentMemory: LongInt;
    function  GetForcedWrites: Boolean;
    function  GetMaxMemory: LongInt;
    function  GetSweepInterval: LongInt;
    function  GetDeleteCount: Integer;
    function  GetInsertCount: Integer;
    function  GetUpdateCount: Integer;
    function  GetDeleteList: TStrings;
    function  GetInsertList: TStrings;
    function  GetUpdateList: TStrings;
    function  GetDBSQLDialect: LongInt;
    function  GetReadOnly: Boolean;
    function  GetLongDatabaseInfo(ACommand: Integer): LongInt;
    function  GetOperationCounts(ACommand: Integer; AOperation: TStrings): TStrings;
    function  GetDataBaseInfo: TStrings;
    property  DataBaseType  : TDataBaseType   read GetDataBaseType   write SetDataBaseType;
    property  BackupOptions : TBackupOptions  read GetBackupOptions  write SetBackupOptions;
    property  RestoreOptions: TRestoreOptions read GetRestoreOptions write SetRestoreOptions;
    property  PageSize      : TPageSize       read GetPageSize       write SetPageSize;
    property  ValidationOpts: TValidationOpts read GetValidationOpts write SetValidationOpts;
    property  DBFileName    : string          read GetDBFileName;
    property  DBSiteName    : string          read GetDBSiteName;
    property  InfoPageSize  : LongInt         read GetInfoPageSize;
    property  Version       : string          read GetVersion;
    property  CurrentMemory : LongInt         read GetCurrentMemory;
    property  ForcedWrites  : Boolean         read GetForcedWrites;
    property  MaxMemory     : LongInt         read GetMaxMemory;
    property  SweepInterval : LongInt         read GetSweepInterval;
    property  DeleteCount   : Integer         read GetDeleteCount;
    property  InsertCount   : Integer         read GetInsertCount;
    property  UpdateCount   : Integer         read GetUpdateCount;
    property  DeleteList    : TStrings        read GetDeleteList;
    property  InsertList    : TStrings        read GetInsertList;
    property  UpdateList    : TStrings        read GetUpdateList;
    property  DBSQLDialect  : LongInt         read GetDBSQLDialect;
    property  ReadOnly      : Boolean         read GetReadOnly;
    property  DataBaseInfo  : TStrings        read GetDataBaseInfo;
  end;

  { TPrcIBInfo }

  TPrcIBInfo = class(TPrcDBInfo, IIBFB_DBInfo)
  protected
    { protected declarations }
    procedure Attach; override;
    procedure Detach; override;
  private
    { private declarations }
    FDataBaseType : TDatabaseType;
    FHandle       : TISC_SVC_HANDLE;
    FInfoHandle   : TISC_SVC_HANDLE;
    FOutputBuffer : PAnsiChar;
    FServiceAttach: Tisc_service_attach;
    FServiceDetach: Tisc_service_detach;
    FServiceStart : Tisc_service_start;
    FServiceQuery : Tisc_service_query;
    FVaxInteger   : Tisc_vax_integer;
    FDatabaseInfo : Tisc_database_info;
    function  StatusVector: PISC_STATUS;
    function  GenerateSPB(AParams: TStrings; var ASPBLength: Smallint): string;
    function  StartService(AParams: string): Boolean;
    function  GetBackupOptions: TBackupOptions;
    procedure SetBackupOptions(AValue: TBackupOptions);
    function  GetDataBaseType: TDataBaseType;
    procedure SetDataBaseType(AValue: TDataBaseType);
    function  GetRestoreOptions: TRestoreOptions;
    procedure SetRestoreOptions(AValue: TRestoreOptions);
    function  GetPageSize: TPageSize;
    procedure SetPageSize(AValue: TPageSize);
    function  GetValidationOpts: TValidationOpts;
    procedure SetValidationOpts(AValue: TValidationOpts);
    function  ServiceStartAddParam (AValue: string; AParam: Integer): string; overload;
    function  ServiceStartAddParam (AValue: Integer; AParam: Integer): string; overload;
    procedure InternalServiceQuery(const AQryParam: string);
    function  FetchUserInfo: TStrings;
    function  ParseString(var RunLen: Integer): string;
    function  ParseInteger(var RunLen: Integer; const ASize: Word): Integer;
    function  GetDBFileName: string;
    function  GetDBSiteName: string;
    function  GetInfoPageSize: LongInt;
    function  GetVersion: string;
    function  GetCurrentMemory: LongInt;
    function  GetForcedWrites: Boolean;
    function  GetMaxMemory: LongInt;
    function  GetSweepInterval: LongInt;
    function  GetDeleteCount: Integer;
    function  GetInsertCount: Integer;
    function  GetUpdateCount: Integer;
    function  GetDeleteList: TStrings;
    function  GetInsertList: TStrings;
    function  GetUpdateList: TStrings;
    function  GetDBSQLDialect: LongInt;
    function  GetReadOnly: Boolean;
    function  GetLongDatabaseInfo(ACommand: Integer): LongInt;
    function  GetOperationCounts(ACommand: Integer; AOperation: TStrings): TStrings;
  public
    { public declarations }
    constructor Create(ADataBase: TSqlConnection; const ADataBaseName, ASysDBA,
                  APassword: string); override;
    destructor  Destroy; override;
    function  AddUser(const AUserName, APassword, AFirstName, AMiddleName,
                ALastName, ARole: string): Boolean; override;
    function  BackupDataBase(const ANameFile: string): Boolean; override;
    function  DeleteUser(const AUserName: string): Boolean; override;
    function  GetConectedUserNames: TStrings; override;
    function  GetUserNames: TStrings; override;
    function  ModifyUser(const AUserName, APassword, AFirstName, AMiddleName,
                ALastName, ARole: string): Boolean; override;
    function  RestoreDataBase(const ANameFile: string): Boolean; override;
    function  ValidationDataBase: Boolean; override;
    function  GetDataBaseInfo: TStrings; override;
    property  DataBaseName;
    property  Password;
    property  LibName;
    property  ServerName;
    property  User;
    property  DataBaseType  : TDataBaseType   read GetDataBaseType   write SetDataBaseType;
    property  BackupOptions : TBackupOptions  read GetBackupOptions  write SetBackupOptions;
    property  RestoreOptions: TRestoreOptions read GetRestoreOptions write SetRestoreOptions;
    property  PageSize      : TPageSize       read GetPageSize       write SetPageSize;
    property  ValidationOpts: TValidationOpts read GetValidationOpts write SetValidationOpts;
    property  DBFileName    : string          read GetDBFileName;
    property  DBSiteName    : string          read GetDBSiteName;
    property  InfoPageSize  : LongInt         read GetInfoPageSize;
    property  Version       : string          read GetVersion;
    property  CurrentMemory : LongInt         read GetCurrentMemory;
    property  ForcedWrites  : Boolean         read GetForcedWrites;
    property  MaxMemory     : LongInt         read GetMaxMemory;
    property  SweepInterval : LongInt         read GetSweepInterval;
    property  DeleteCount   : Integer         read GetDeleteCount;
    property  InsertCount   : Integer         read GetInsertCount;
    property  UpdateCount   : Integer         read GetUpdateCount;
    property  DeleteList    : TStrings        read GetDeleteList;
    property  InsertList    : TStrings        read GetInsertList;
    property  UpdateList    : TStrings        read GetUpdateList;
    property  DBSQLDialect  : LongInt         read GetDBSQLDialect;
    property  ReadOnly      : Boolean         read GetReadOnly;
    property  DataBaseInfo  : TStrings        read GetDataBaseInfo;
  published
    { published declareations }
  end;


implementation

threadvar
  FStatusVector : TStatusVector;

  { TPrcIBInfo }

constructor TPrcIBInfo.Create(ADataBase: TSqlConnection; const ADataBaseName,
              ASysDBA, APassword: string);
var
  i: smallint;
begin
  inherited Create(ADataBase, ADataBaseName, ASysDba, APassword);
  DataBaseType := dtFirebird;
  FHandle      := nil;
  GetMem(FInfoHandle, SizeOf(TISC_SVC_HANDLE));
  ADataBase.SQLConnection.GetOption(eConnNativeHandle, FInfoHandle, 0, i);
end;

destructor  TPrcIBInfo.Destroy;
begin
  if (FInfoHandle <> nil) then
    FreeMem(FInfoHandle);
  FInfoHandle := nil;
  inherited Destroy;
end;

function TPrcIBInfo.StatusVector: PISC_STATUS;
begin
  result := @FStatusVector;
end;


procedure TPrcIBInfo.Attach;
const
  S_PROC_NAME = 'isc_service_attach';
var
  aSPB          : string;
  aConnectString: string;
  aSPBLength    : SmallInt;
  aParams       : TStrings;
  aCodeReturned : LongInt;
begin
  if (ServerName = '') or (User = '') or (Password = '') then exit;
  aParams := TStringList.Create;
  aParams.Add('user_name=' + User);
  aParams.Add('password='  + Password);
  try
    aSPB := GenerateSPB(aParams, aSPBLength);
    if (ServerName = 'localhost') then
      aConnectString := 'service_mgr'
    else
      aConnectString := ServerName + ':service_mgr';
    if (not Assigned(FServiceAttach)) and
       (not GetLibraryProc(@FServiceAttach, S_PROC_NAME)) then
      raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
          [S_PROC_NAME, LibName]));
    aCodeReturned := FServiceAttach(StatusVector, Length(aConnectString),
      PAnsiChar(aConnectString), @FHandle, aSPBLength, PAnsiChar(aSPB));
    if (aCodeReturned > 0) then
    begin
      FHandle := nil;
      raise Exception.CreateFmt('Erro ao conectar ao serviço do Banco de ' +
        'Dados (Code: %d)', [aCodeReturned]);
    end;
  finally
    aParams.Clear;
    aParams.Free;
  end;
end;

procedure TPrcIBInfo.Detach;
const
  S_PROC_NAME = 'isc_service_detach';
begin
  if (FHandle = nil) then exit;
  if (not Assigned(FServiceDetach)) and
     (not GetLibraryProc(@FServiceDetach, S_PROC_NAME)) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
        [S_PROC_NAME, LibName]));
  if (FServiceDetach(StatusVector, @FHandle) > 0) then
  begin
    FHandle := nil;
    raise Exception.Create('Erro ao desconectar do serviço do Banco de Dados');
  end
  else
    FHandle := nil;
end;

// this function was created based in then GenerateSPB from unit IBService of Borland
function TPrcIBInfo.GenerateSPB(AParams: TStrings; var ASPBLength: SmallInt): string;
var
  i, j : Integer;
  aSPBVal, aSPBServerVal: Word;
  aParamName, aParamValue: string;
begin
  { The SPB is initially empty, with the exception that
   the SPB version must be the first byte of the string.
  }
  ASPBLength := 2;
  Result := Char(isc_spb_version);
  Result := Result + Char(isc_spb_current_version);
  { Iterate through the textual service parameters, constructing
   a SPB on-the-fly}
  for i := 0 to AParams.Count - 1 do
  begin
   { Get the parameter's name and value from the list,
     and make sure that the name is all lowercase with
     no leading 'isc_spb_' prefix }
    if (Trim(AParams.Names[i]) = '') then
      continue;
    aParamName := LowerCase(AParams.Names[i]); {mbcs ok}
    aParamValue := Copy(AParams[i], Pos('=', AParams[i]) + 1, Length(AParams[i])); {mbcs ok}
    if (Pos(SPBPrefix, aParamName) = 1) then {mbcs ok}
      Delete(aParamName, 1, Length(SPBPrefix));
    { We want to translate the parameter name to some integer
      value. We do this by scanning through a list of known
      service parameter names (SPBConstantNames, defined above). }
    aSPBVal := 0;
    aSPBServerVal := 0;
    { Find the parameter }
    for j := 1 to isc_spb_last_spb_constant do
      if (aParamName = SPBConstantNames[j]) then
      begin
        aSPBVal := j;
        aSPBServerVal := SPBConstantValues[j];
        break;
      end;
    case aSPBVal of
      isc_spb_user_name, isc_spb_password:
      begin
        Result := Result +
               Char(aSPBServerVal) +
               Char(Length(aParamValue)) +
               aParamValue;
        Inc(ASPBLength, 2 + Length(aParamValue));
      end;
    end;
  end;
end;

function  TPrcIBInfo.StartService(AParams: string): Boolean;
const
  S_PROC_NAME = 'isc_service_start';
var
  aLen: Integer;
  aSPB: PAnsiChar;
begin
  aLen := Length(AParams);
  if aLen = 0 then
    raise Exception.Create('Erro: Não posso chamar um serviço sem parâmetros');
  GetMem(aSPB, aLen);
  try
    Move(AParams[1], aSPB[0], aLen);
    if (not Assigned(FServiceStart)) and
       (not GetLibraryProc(@FServiceStart, S_PROC_NAME)) then
      raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
        [S_PROC_NAME, LibName]));
    if FServiceStart(StatusVector, @FHandle, nil, aLen, aSPB) > 0 then
    begin
      FHandle := nil;
      raise Exception.Create('Erro: Erro ao executar o serviço no banco de dados');
    end;
  finally
    FreeMem(aSPB);
    aSPB    := nil;
    if (aSPB = nil) then AParams := '';
  end;
  Result := True;
end;

function  TPrcIBInfo.AddUser(const AUserName, APassword, AFirstName, AMiddleName,
            ALastName, ARole: string): Boolean;
var
  aStartParams: string;
  aLen        : Integer;
begin
  Attach;
  if (Pos(' ', AUserName) > 0 ) then
    raise Exception.Create('Erro: Nome não pode conter espaços');
  aLen := Length(AUserName);
  if (aLen = 0) then
    raise Exception.Create('Erro: Nome está nulo');
  aStartParams  := Char(isc_action_svc_add_user);
  aStartParams  := aStartParams + ServiceStartAddParam(AUserName, isc_spb_sec_username);
  aStartParams  := aStartParams + ServiceStartAddParam(0, isc_spb_sec_userid);
  aStartParams  := aStartParams + ServiceStartAddParam(0, isc_spb_sec_groupid);
  aStartParams  := aStartParams + ServiceStartAddParam(APassword, isc_spb_sec_password);
  aStartParams  := aStartParams + ServiceStartAddParam(AFirstName, isc_spb_sec_firstname);
  aStartParams  := aStartParams + ServiceStartAddParam(AMiddleName, isc_spb_sec_middlename);
  aStartParams  := aStartParams + ServiceStartAddParam(ALastName, isc_spb_sec_lastname);
  aStartParams  := aStartParams + ServiceStartAddParam(ARole, SPBConstantValues[isc_spb_sql_role_name]);
  Result := StartService(aStartParams);
  Detach;
end;

function  TPrcIBInfo.BackupDataBase(const ANameFile: string): Boolean;
begin
  Result := True;
end;

function  TPrcIBInfo.DeleteUser(const AUserName: string): Boolean;
var
  aLen: Integer;
  aStartParams: string;
begin
  Attach;
  if (Pos(' ', AUserName) > 0 ) then
    raise Exception.Create('Erro: Nome não pode conter espaços');
  aLen := Length(AUserName);
  if (aLen = 0) then
    raise Exception.Create('Erro: Nome está nulo');
  aStartParams  := Char(isc_action_svc_delete_user);
  aStartParams  := aStartParams + ServiceStartAddParam(AUserName, isc_spb_sec_username);
  aStartParams  := aStartParams + ServiceStartAddParam(0, isc_spb_sec_userid);
  aStartParams  := aStartParams + ServiceStartAddParam(0, isc_spb_sec_groupid);
  aStartParams  := aStartParams + ServiceStartAddParam('', isc_spb_sec_password);
  aStartParams  := aStartParams + ServiceStartAddParam('', isc_spb_sec_firstname);
  aStartParams  := aStartParams + ServiceStartAddParam('', isc_spb_sec_middlename);
  aStartParams  := aStartParams + ServiceStartAddParam('', isc_spb_sec_lastname);
  aStartParams  := aStartParams + ServiceStartAddParam('', SPBConstantValues[isc_spb_sql_role_name]);
  Result := StartService(aStartParams);
  Detach;
end;

function  TPrcIBInfo.GetConectedUserNames: TStrings;
const
  S_PROC_NAME   = 'isc_database_info';
var
  aLocalBuffer: array[0..HUGE_BUFFER_LEN - 1] of Char;
  aTempBuffer : array[0..BUFFER_LEN      - 2] of Char;
  aCommand    : Char;
  i, aUserLen : Integer;
begin
  Result   := TStringList.Create;
  aCommand := Char(isc_info_user_names);
  if (FInfoHandle = nil) or ((not Assigned(FDatabaseInfo)) and
     (not GetLibraryProc(@FDatabaseInfo, S_PROC_NAME))) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_PROC_NAME, LibName]));
  FDatabaseInfo(StatusVector, FInfoHandle, 1, @aCommand, (HUGE_BUFFER_LEN - 1), aLocalBuffer);
  i := 0;
  while aLocalBuffer[i] = Char(isc_info_user_names) do
  begin
    Inc(i, 3); { skip "isc_info_user_names byte" & two unknown bytes of structure (see below) }
    aUserLen := LongInt(aLocalBuffer[i]);
    Inc(i, 1);
    Move(aLocalBuffer[i], aTempBuffer[0], aUserLen);
    Inc(i, aUserLen);
    aTempBuffer[aUserLen] := #0;
    Result.Add(string(aTempBuffer));
  end;
end;

function  TPrcIBInfo.GetUserNames: TStrings;
var
  i: Integer;
begin
  Result := TStringList.Create;
  try
    Attach;
    StartService(Char(isc_action_svc_display_user));
    Result.Assign(FetchUserInfo);
    for i := 0 to Result.Count - 1 do
      Result.Strings[i] := Copy(Result.Strings[i], 1, Pos('|', Result.Strings[i]) - 1);
  except on E:Exception do
    begin
      Detach;
      raise Exception.Create(E.Message);
    end;
  end;
  Detach;
end;

function  TPrcIBInfo.ModifyUser(const AUserName, APassword, AFirstName, AMiddleName,
            ALastName, ARole: string): Boolean;
var
  aLen: Integer;
  aStartParams: string;
begin
  Attach;
  if (Pos(' ', AUserName) > 0 ) then
    raise Exception.Create('Erro: Nome não pode conter espaços');
  aLen := Length(AUserName);
  if (aLen = 0) then
    raise Exception.Create('Erro: Nome está nulo');
  aStartParams  := Char(isc_action_svc_modify_user);
  aStartParams  := aStartParams + ServiceStartAddParam(AUserName, isc_spb_sec_username);
  aStartParams  := aStartParams + ServiceStartAddParam(0, isc_spb_sec_userid);
  aStartParams  := aStartParams + ServiceStartAddParam(0, isc_spb_sec_groupid);
  aStartParams  := aStartParams + ServiceStartAddParam(APassword, isc_spb_sec_password);
  aStartParams  := aStartParams + ServiceStartAddParam(AFirstName,  isc_spb_sec_firstname);
  aStartParams  := aStartParams + ServiceStartAddParam(AMiddleName, isc_spb_sec_middlename);
  aStartParams  := aStartParams + ServiceStartAddParam(ALastName,   isc_spb_sec_lastname);
  aStartParams  := aStartParams + ServiceStartAddParam(ARole, SPBConstantValues[isc_spb_sql_role_name]);
  Result := StartService(aStartParams);
  Detach;
end;

function  TPrcIBInfo.RestoreDataBase(const ANameFile: string): Boolean;
begin
  Result := True;
end;

function  TPrcIBInfo.ValidationDataBase: Boolean;
begin
  Result := True;
end;

function  TPrcIBInfo.GetBackupOptions: TBackupOptions;
begin
  Result := [];
end;

procedure TPrcIBInfo.SetBackupOptions(AValue: TBackupOptions);
begin
end;

function  TPrcIBInfo.GetDataBaseType: TDataBaseType;
begin
  Result := FDataBaseType;
end;

procedure TPrcIBInfo.SetDataBaseType(AValue: TDataBaseType);
begin
  FDataBaseType := AValue;
  case FDatabaseType of
    dtFirebird : LibName := FIREBIRD_DLL;
    dtInterbase: LibName := IBASE_DLL;
  end;
end;

function  TPrcIBInfo.GetRestoreOptions: TRestoreOptions;
begin
  Result := [];
end;

procedure TPrcIBInfo.SetRestoreOptions(AValue: TRestoreOptions);
begin
end;

function  TPrcIBInfo.GetPageSize: TPageSize;
begin
  Result := ps4096;
end;

procedure TPrcIBInfo.SetPageSize(AValue: TPageSize);
begin

end;

function  TPrcIBInfo.GetValidationOpts: TValidationOpts;
begin
  Result := [];
end;

procedure TPrcIBInfo.SetValidationOpts(AValue: TValidationOpts);
begin
end;

function  TPrcIBInfo.ServiceStartAddParam (AValue: string; AParam: Integer): string;
var
  aLen: SmallInt;
begin
  aLen := Length(AValue);
  if aLen > 0 then
  begin
    Result  := Char(AParam)        +
               PAnsiChar(@aLen)[0] +
               PAnsiChar(@aLen)[1] +
               AValue;
  end;
end;

function TPrcIBInfo.ServiceStartAddParam (AValue: Integer; AParam: Integer): string;
begin
  Result  := Char(AParam)          +
             PAnsiChar(@AValue)[0] +
             PAnsiChar(@AValue)[1] +
             PAnsiChar(@AValue)[2] +
             PAnsiChar(@AValue)[3];
end;

procedure TPrcIBInfo.InternalServiceQuery(const AQryParam: string);
const
  S_PROC_NAME   = 'isc_service_query';
var
  aLen    : Integer;
  aSPB    : PAnsiChar;
begin
  aLen := Length(AQryParam);
  if aLen = 0 then
    raise Exception.Create('Erro: Não posso chamar um serviço sem parâmetros');
  GetMem(FOutputBuffer, HUGE_32K_BUFFER_LEN);
  GetMem(aSPB, aLen);
  try
    Move(AQryParam[1], aSPB[0], aLen);
    if (not Assigned(FServiceQuery)) and
       (not GetLibraryProc(@FServiceQuery, S_PROC_NAME)) then
      raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
        [S_PROC_NAME, LibName]));
    if FServiceQuery(StatusVector, @FHandle, nil, 0, nil, aLen, aSPB, HUGE_32K_BUFFER_LEN,
       FOutputBuffer) > 0 then
    begin
      FHandle := nil;
      raise Exception.Create('Erro: Erro ao executar o serviço no banco de dados');
    end;
  finally
    FreeMem(aSPB);
  end;
end;

function  TPrcIBInfo.FetchUserInfo: TStrings;
var
  RunLen : Integer;
  StrAux    : string;
begin
  Result := TStringList.Create;
  InternalServiceQuery(Char(isc_info_svc_get_users));
  RunLen := 0;
  if (FOutputBuffer[RunLen] <> Char(isc_info_svc_get_users)) then
    raise Exception.Create('Erro: Usuários não encontrados');
  { Don't have any use for the combined length
   so increment past by 2 }
  Inc(RunLen, 3);
  while (FOutputBuffer[RunLen] <> Char(isc_info_end)) do
  begin
    if (FOutputBuffer[RunLen] <> Char(isc_spb_sec_username)) then
      raise Exception.CreateFmt('Erro: Nome do usuário inválido ' +
        '(Buf: %d, Len: %d)', [Ord(FOutputBuffer[RunLen]), RunLen]);
    Inc(RunLen);
    StrAux := ParseString(RunLen) + '|';
    if (FOutputBuffer[RunLen] <> Char(isc_spb_sec_firstname)) then
      raise Exception.CreateFmt('Erro: Primeiro Nome do usuário inválido ' +
        '(Buf: %d, Len: %d)', [Ord(FOutputBuffer[RunLen]), RunLen]);
    Inc(RunLen);
    StrAux := StrAux + ParseString(RunLen) + '|';
    if (FOutputBuffer[RunLen] <> Char(isc_spb_sec_middlename)) then
      raise Exception.CreateFmt('Erro: Segundo Nome do usuário inválido ' +
        '(Buf: %d, Len: %d)', [Ord(FOutputBuffer[RunLen]), RunLen]);
    Inc(RunLen);
    StrAux := StrAux + ParseString(RunLen) + '|';
    if (FOutputBuffer[RunLen] <> Char(isc_spb_sec_lastname)) then
      raise Exception.CreateFmt('Erro: Sobrenome do usuário inválido ' +
        '(Buf: %d, Len: %d)', [Ord(FOutputBuffer[RunLen]), RunLen]);
    Inc(RunLen);
    StrAux := StrAux + ParseString(RunLen) + '|';
    if (FOutputBuffer[RunLen] <> Char(isc_spb_sec_userId)) then
      raise Exception.CreateFmt('Erro: Código do usuário inválido ' +
        '(Buf: %d, Len: %d)', [Ord(FOutputBuffer[RunLen]), RunLen]);
    Inc(RunLen);
    StrAux := StrAux + IntToStr(ParseInteger(RunLen, 4)) + '|';
    if (FOutputBuffer[RunLen] <> Char(isc_spb_sec_groupid)) then
      raise Exception.CreateFmt('Erro: Código do grupo do usuário inválido '+
        '(Buf: %d, Len: %d)', [Ord(FOutputBuffer[RunLen]), RunLen]);
    Inc(RunLen);
    StrAux := StrAux + IntToStr(ParseInteger(RunLen, 4));
    Result.Add(StrAux);
  end;
end;

function TPrcIBInfo.ParseString(var RunLen: Integer): string;
const
  S_PROC_NAME   = 'isc_vax_integer';
var
  aLen: Word;
  aTmp: Char;
begin
  if (not Assigned(FVaxInteger)) and
     (not GetLibraryProc(@FVaxInteger, S_PROC_NAME)) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_PROC_NAME, LibName]));
  aLen := FVaxInteger(FOutputBuffer + RunLen, 2);
  Inc(RunLen, 2);
  if (aLen <> 0) then
  begin
    aTmp := FOutputBuffer[RunLen + aLen];
    FOutputBuffer[RunLen + aLen] := #0;
    Result := string(PChar(@FOutputBuffer[RunLen]));
    FOutputBuffer[RunLen + aLen] := aTmp;
    RunLen := RunLen + aLen;
  end
  else
    result := '';
end;

function TPrcIBInfo.ParseInteger(var RunLen: Integer; const ASize: Word): Integer;
const
  S_PROC_NAME   = 'isc_vax_integer';
begin
  if (not Assigned(FVaxInteger)) and
     (not GetLibraryProc(@FVaxInteger, S_PROC_NAME)) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_PROC_NAME, LibName]));
  Result := FVaxInteger(FOutputBuffer + RunLen, ASize);
  Inc(RunLen, ASize);
end;

function  TPrcIBInfo.GetDBFileName: string;
const
  S_PROC_NAME   = 'isc_database_info';
var
  aBuffer : array[0..BUFFER_LEN - 1] of Char;
  aCommand: Char;
begin
  aCommand := Char(isc_info_db_id);
  if (FInfoHandle = nil) or ((not Assigned(FDatabaseInfo)) and
     (not GetLibraryProc(@FDatabaseInfo, S_PROC_NAME))) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_PROC_NAME, LibName]));
  FDatabaseInfo(StatusVector, FInfoHandle, 1, @aCommand, (BUFFER_LEN - 1), aBuffer);
  aBuffer[5 + Integer(aBuffer[4])] := #0;
  Result := string(PAnsiChar(@aBuffer[5]));
end;

function  TPrcIBInfo.GetDBSiteName: string;
const
  S_PROC_NAME   = 'isc_database_info';
var
  aBuffer : array[0..BIG_BUFFER_LEN - 1] of Char;
  p       : PAnsiChar;
  aCommand: Char;
begin
  aCommand := Char(isc_info_db_id);
  if (FInfoHandle = nil) or ((not Assigned(FDatabaseInfo)) and
     (not GetLibraryProc(@FDatabaseInfo, S_PROC_NAME))) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_PROC_NAME, LibName]));
  FDatabaseInfo(StatusVector, FInfoHandle, 1, @aCommand, (BIG_BUFFER_LEN - 1), aBuffer);
  p := @aBuffer[5 + Integer(aBuffer[4])]; { DBSiteName Length }
  p := p + Integer(p^) + 1;                    { End of DBSiteName }
  p^ := #0;                                    { Null it }
  Result := string(PAnsiChar(@aBuffer[6 + Integer(aBuffer[4])]));
end;

function  TPrcIBInfo.GetInfoPageSize: LongInt;
begin
  Result := GetLongDatabaseInfo(isc_info_page_size);
end;

function  TPrcIBInfo.GetVersion: string;
const
  S_PROC_NAME   = 'isc_database_info';
var
  aBuffer: array[0..BIG_BUFFER_LEN - 1] of Char;
  aCommand: Char;
begin
  aCommand := Char(isc_info_version);
  if (FInfoHandle = nil) or ((not Assigned(FDatabaseInfo)) and
     (not GetLibraryProc(@FDatabaseInfo, S_PROC_NAME))) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_PROC_NAME, LibName]));
  FDatabaseInfo(StatusVector, FInfoHandle, 1, @aCommand, (BIG_BUFFER_LEN - 1), aBuffer);
  aBuffer[5 + Integer(aBuffer[4])] := #0;
  Result := string(PAnsiChar(@aBuffer[5]));
end;

function  TPrcIBInfo.GetCurrentMemory: LongInt;
begin
  Result := GetLongDatabaseInfo(isc_info_current_memory);
end;

function  TPrcIBInfo.GetForcedWrites: Boolean;
begin
  Result := (GetLongDatabaseInfo(isc_info_forced_writes) = 0);
end;

function  TPrcIBInfo.GetMaxMemory: LongInt;
begin
  Result := GetLongDatabaseInfo(isc_info_max_memory);
end;

function  TPrcIBInfo.GetSweepInterval: LongInt;
begin
  Result := GetLongDatabaseInfo(isc_info_sweep_interval);
end;

function  TPrcIBInfo.GetDeleteCount: Integer;
var
  aList: TStrings;
  i    : Integer;
begin
  Result := 0;
  aList := TStringList.Create;
  try
    GetOperationCounts(isc_info_delete_count, aList);
    for i := 0 to aList.Count - 1 do
      Result := Result + StrToIntDef(aList.ValueFromIndex[i], 0);
  finally
    aList.Free;
  end;
end;

function  TPrcIBInfo.GetInsertCount: Integer;
var
  aList: TStrings;
  i    : Integer;
begin
  Result := 0;
  aList := TStringList.Create;
  try
    GetOperationCounts(isc_info_insert_count, aList);
    for i := 0 to aList.Count - 1 do
      Result := Result + StrToIntDef(aList.ValueFromIndex[i], 0);
  finally
    aList.Free;
  end;
end;

function  TPrcIBInfo.GetUpdateCount: Integer;
var
  aList: TStrings;
  i    : Integer;
begin
  Result := 0;
  aList := TStringList.Create;
  try
    GetOperationCounts(isc_info_update_count, aList);
    for i := 0 to aList.Count - 1 do
      Result := Result + StrToIntDef(aList.ValueFromIndex[i], 0);
  finally
    aList.Free;
  end;
end;

function  TPrcIBInfo.GetDeleteList: TStrings;
begin
  Result := TStringList.Create;
  GetOperationCounts(isc_info_delete_count, Result);
end;

function  TPrcIBInfo.GetInsertList: TStrings;
begin
  Result := TStringList.Create;
  GetOperationCounts(isc_info_insert_count, Result);
end;

function  TPrcIBInfo.GetUpdateList: TStrings;
begin
  Result := TStringList.Create;
  GetOperationCounts(isc_info_update_count, Result);
end;

function  TPrcIBInfo.GetDBSQLDialect: LongInt;
const
  S_PROC_NAME   = 'isc_database_info';
  S_VAX_NAME    = 'isc_vax_integer';
var
  aBuffer : array[0..BUFFER_LEN - 1] of Char;
  aCommand: Char;
  aLen    : Integer;
begin
  aCommand := Char(isc_info_db_SQL_Dialect);
  if (FInfoHandle = nil) or ((not Assigned(FDatabaseInfo)) and
     (not GetLibraryProc(@FDatabaseInfo, S_PROC_NAME))) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_PROC_NAME, LibName]));
  FDatabaseInfo(StatusVector, FInfoHandle, 1, @aCommand, (BUFFER_LEN - 1), aBuffer);
  if (aBuffer[0] <> Char(isc_info_db_SQL_dialect)) then
    Result := 1
  else
  begin
    if (not Assigned(FVaxInteger)) and
       (not GetLibraryProc(@FVaxInteger, S_VAX_NAME)) then
      raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
        [S_VAX_NAME, LibName]));
    aLen   := FVaxInteger(@aBuffer[1], 2);
    Result := FVaxInteger(@aBuffer[3], aLen);
  end;
end;

function  TPrcIBInfo.GetReadOnly: Boolean;
begin
  Result := (GetLongDatabaseInfo(isc_info_db_read_only) = 0)
end;

function  TPrcIBInfo.GetLongDatabaseInfo(ACommand: Integer): LongInt;
const
  S_PROC_NAME   = 'isc_database_info';
  S_VAX_NAME    = 'isc_vax_integer';
var
  aBuffer : array[0..BUFFER_LEN - 1] of Char;
  aLen    : Integer;
begin
  if (FInfoHandle = nil) or ((not Assigned(FDatabaseInfo)) and
     (not GetLibraryProc(@FDatabaseInfo, S_PROC_NAME))) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_PROC_NAME, LibName]));
  FDatabaseInfo(StatusVector, FInfoHandle, 1, @ACommand, (BUFFER_LEN - 1), aBuffer);
  if (not Assigned(FVaxInteger)) and
     (not GetLibraryProc(@FVaxInteger, S_VAX_NAME)) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_VAX_NAME, LibName]));
  aLen   := FVaxInteger(@aBuffer[1], 2);
  Result := FVaxInteger(@aBuffer[3], aLen);
end;

function TPrcIBInfo.GetOperationCounts(ACommand: Integer; AOperation: TStrings): TStrings;
const
  S_PROC_NAME   = 'isc_database_info';
  S_VAX_NAME    = 'isc_vax_integer';
var
  aBuffer : array[0..HUGE_BUFFER_LEN - 1] of Char;
  i, aQtdTables, aIdTable, aQtdOperations: Integer;
begin
  if AOperation = nil then AOperation := TStringList.Create;
  Result := AOperation;
  if (FInfoHandle = nil) or ((not Assigned(FDatabaseInfo)) and
     (not GetLibraryProc(@FDatabaseInfo, S_PROC_NAME))) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_PROC_NAME, LibName]));
  FDatabaseInfo(StatusVector, FInfoHandle, 1, @ACommand, (HUGE_BUFFER_LEN - 1), aBuffer);
  AOperation.Clear;
  { 1. 1 byte specifying the item type requested (e.g., isc_info_insert_count).
    2. 2 bytes telling how many bytes compose the subsequent value pairs.
    3. A pair of values for each table in the database on wich the requested
      type of operation has occurred since the database was last attached.
    Each pair consists of:
    1. 2 bytes specifying the table ID.
    2. 4 bytes listing the number of operations (e.g., inserts) done on that table.
  }
  if (not Assigned(FVaxInteger)) and
     (not GetLibraryProc(@FVaxInteger, S_VAX_NAME)) then
    raise Exception.Create(Format('Não posso encontrar a funcão %s na biblioteca %s',
      [S_VAX_NAME, LibName]));
  aQtdTables := FVaxInteger(@aBuffer[1], 2) div 6;
  for i := 0 to aQtdTables - 1 do
  begin
    aIdTable       := FVaxInteger(@aBuffer[3 + (i * 6)], 2);
    aQtdOperations := FVaxInteger(@aBuffer[5 + (i * 6)], 4);
    AOperation.Add(IntToStr(aIdTable) + '=' + IntToStr(aQtdOperations));
  end;
end;

function  TPrcIBInfo.GetDataBaseInfo: TStrings;
const
  C_BOOLEAN_STRING: array [0..1] of string = ('Sim', 'Não');
begin
  Result := TStringList.Create;
  Result.Add('Nome: '                       + DBFileName);
  Result.Add('Localização: '                + DBSiteName);
  Result.Add('Tamanho da Página: '          + IntToStr(InfoPageSize));
  Result.Add('Versão do SGDB: '             + Version);
  Result.Add('Memória Usada: '              + IntToStr(CurrentMemory div BIG_BUFFER_LEN) + 'kb');
  Result.Add('Gravação sem Cache: '         + C_BOOLEAN_STRING[Ord(ForcedWrites)]);
  Result.Add('Máximo de Memória Usada: '    + IntToStr(MaxMemory div BIG_BUFFER_LEN) + 'kb');
  Result.Add('Intervalo para Limpeza: '     + IntToStr(SweepInterval));
  Result.Add('Quantidade de Exclusões: '    + IntToStr(DeleteCount));
  Result.Add('Quantidade de Inserções: '    + IntToStr(InsertCount));
  Result.Add('Quantidade de Atualizações: ' + IntToStr(UpdateCount));
  Result.Add('Modo Leitura/Gravação: '      + C_BOOLEAN_STRING[Ord(not ReadOnly)]);
end;

initialization
  RegisterClass(TPrcIBInfo);

end.
