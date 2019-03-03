unit BemType;

interface

type
// funções da Impressora Fiscal bematech MP20FI32
  TLe_Variaveis  = function  (Retorno_var: string): integer; stdcall;
  TIniPortaStr   = function  (Porta: string): integer; stdcall;
  TStatus_Mp20FI = function  (var Ret: integer; var ACK: integer; var ST1: integer;
    var ST2: Integer): integer; stdcall;
  TFormataTX     = function  (BUFFER: PChar): integer; stdcall;
  TFechaPorta    = function  : integer; stdcall;

function  extLe_Variaveis(Retorno_var: string): integer;
function  extIniPortaStr(Porta: string): integer;
function  extStatus_Mp20FI(var Ret: integer; var ACK: integer; var ST1: integer;
  var ST2: Integer): integer;
function  extFormataTX(BUFFER: PAnsiChar): integer;
function  extFechaPorta: integer;

implementation

function  extLe_Variaveis(Retorno_var: string): integer;
var
  hHandle: Integer;
  Le_Variaveis: TLe_Variaveis;
const
  extFunction = 'Le_Variaveis';
begin
  Result := 1;
  hHandle := LoadLibrary(BEMLIB);
  if hHandle <> 0 then
  begin
    @Le_Variaveis := GetProcAddress(hHandle, extFunction);
    if @Le_Variaveis <> nil then
      Result := Le_Variaveis(Retorno_var);
    FreeLibrary(hHandle);
  end;
end;

function  extIniPortaStr(Porta: string): integer;
var
  hHandle: Integer;
  IniPortaStr: TIniPortaStr;
const
  extFunction = 'IniPortaStr';
begin
  Result := 1;
  hHandle := LoadLibrary(BEMLIB);
  if hHandle <> 0 then
  begin
    @IniPortaStr := GetProcAddress(hHandle, extFunction);
    if @IniPortaStr <> nil then
      Result := IniPortaStr(Porta);
    FreeLibrary(hHandle);
  end;
end;

function  extStatus_Mp20FI(var Ret: integer; var ACK: integer; var ST1: integer;
  var ST2: Integer): integer;
var
  hHandle: Integer;
  Status_Mp20FI: TStatus_Mp20FI;
const
  extFunction = 'Status_Mp20FI';
begin
  Result := 1;
  hHandle := LoadLibrary(BEMLIB);
  if hHandle <> 0 then
  begin
    @Status_Mp20FI := GetProcAddress(hHandle, extFunction);
    if @Status_Mp20FI <> nil then
      Result := Status_Mp20FI(Ret, ACK, ST1, ST2);
    FreeLibrary(hHandle);
  end;
end;

function  extFormataTX(BUFFER: PAnsiChar): integer;
var
  hHandle: Integer;
  FormataTX: TFormataTX;
const
  extFunction = 'FormataTX';
begin
  Result := 1;
  hHandle := LoadLibrary(BEMLIB);
  if hHandle <> 0 then
  begin
    @FormataTX := GetProcAddress(hHandle, extFunction);
    if @FormataTX <> nil then
      Result := FormataTX(BUFFER);
    FreeLibrary(hHandle);
  end;
end;

function  extFechaPorta: integer;
var
  hHandle: Integer;
  FechaPorta: TFechaPorta;
const
  extFunction = 'FechaPorta';
begin
  Result := 1;
  hHandle := LoadLibrary(BEMLIB);
  if hHandle <> 0 then
  begin
    @FechaPorta := GetProcAddress(hHandle, extFunction);
    if @FechaPorta <> nil then
      Result := FechaPorta;
    FreeLibrary(hHandle);
  end;
end;

end.
