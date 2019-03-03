unit ProcIE;

{*************************************************************************}
{*                     Cálculo do Digito Verificador                     *}
{*                                                                       *}
{* Author   : Nelson Campos Filho                                        *}
{* Copyright: © 2000, 2001  by Nelson Campos Filho. All rights reserved. *}
{* Created  : 10/04/2000 - DD/MM/YYYY                                    *}
{* Modified : 04/01/2007 - DD/MM/YYYY                                    *}
{* Version  : 1.2.6.1                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : (ncampos@sef.mg.gov.br)                                    *}
{*            (alcindo@processa.org)                                     *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses SysUtils;

function  VerificaInscricao(const AIE, AUF: string): Boolean;

implementation

const OrdZero = Ord('0');

function AllTrim(const S: string): string;
{-Return a string with leading and trailing white space removed}
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do
    Inc(I);
  if I > L then
    Result := ''
  else
  begin
    while S[L] <= ' ' do
      Dec(L);
    Result := Copy(S, I, L - I + 1);
  end;
end; { AllTrim }

function Empty(const S: string) : Boolean;
var
  aux: string;
begin
  aux := AllTrim(S);
  if Length(aux) = 0 then
    Result := true
  else Result := false;
end;

function IsNumero(const s: string): boolean;
var
  i: byte;
begin
  Result := false;
  for i := 1 to length(s) do
    if (not (s[i] in ['0'..'9'])) then exit;
  Result := true;
end; { IsNumero }

{ chInt - Converte um caracter numérico para o valor inteiro correspondente. }
function CharToInt( ch: Char ): ShortInt;
begin
  Result := Ord ( ch ) - OrdZero;
end;
{ intCh = Converte um valor inteiro (de 0 a 9) para o caracter numérico correspondente. }

function IntToChar (int: ShortInt ): Char;
begin
  Result := Chr ( int + OrdZero);
end;

function CheckIE_MG(const AIE: string): boolean;
var
  npos  ,
  i     : byte;
  ptotal,
  psoma : Integer;
  dig1  ,
  dig2  : string[1];
  ie    ,
  insc  : string;
  nresto: SmallInt;
  begin
    Result := true;
    ie := Trim(AIE);
    if (empty(ie)) then exit;
    if copy(ie, 1, 2) = 'PR' then exit;
    if copy(ie, 1, 5) = 'ISENT' then exit;
    Result := false;
    if (Trim(AIE) = '.')  then exit;
    if (length(ie) <> 13) then exit;
    if (not IsNumero(ie)) then exit;
    dig1   := copy(ie, 12, 1);
    dig2   := copy(ie, 13, 1);
    insc   := copy(ie, 1, 3) + '0' + copy(ie, 4, 8);
    //  CALCULA DIGITO1
    npos   := 12;
    i      := 1;
    ptotal := 0;
    while npos > 0 do
    begin
      inc(i);
      psoma := CharToInt(insc[npos]) * i;
      if (psoma >= 10) then
        psoma := psoma - 9;
      inc(ptotal, psoma);
      if (i = 2) then
        i := 0;
      dec(npos);
    end;
    nResto := ptotal mod 10;
    if (nResto = 0) then
      nResto := 10;
    nResto := 10 - nResto;
    if (nResto <> CharToInt(dig1[1])) then
      exit;
    // CALCULA DIGITO2
    npos   := 12;
    i      := 1;
    ptotal := 0;
    while (npos > 0) do
    begin
      inc(i);
      if (i = 12) then
        i := 2;
      inc(ptotal, CharToInt(ie[npos]) * i);
      dec(npos);
    end;
    nResto := ptotal mod 11;
    if (nResto = 0) or (nResto = 1) then
      nResto := 11;
    nResto := 11 - nResto;
    if (nResto <> CharToInt(dig2[1])) then
      exit;
    Result := true;
end; // CheckIE_MG

function CheckIE_AC(const AIE: string) : Boolean;  // 99.999.999/999-99
var
  b    ,
  i    ,
  soma : Integer;
  dig  : SmallInt;
begin
  Result := False;
  if (length(AIE) <> 13) then exit;
  if not IsNumero(AIE) then exit;
  b    := 4;
  soma := 0;
  for i := 1 to 11 do
  begin
    Inc(soma, CharToInt(AIE[i]) * b);
    dec(b);
    if (b = 1) then b := 9;
  end;
  dig := 11 - (soma mod 11);
  if (dig >= 10) then dig := 0;
  Result := (IntToChar(dig) = AIE[12]);
  if (not Result) then exit;
  b    := 5;
  soma := 0;
  for i := 1 to 12 do
  begin
    inc(soma,CharToInt(AIE[i]) * b);
    dec(b);
    if (b = 1) then b := 9;
  end;
  dig := 11 - (soma mod 11);
  if (dig >= 10) then dig := 0;
  Result := (IntToChar(dig) = AIE[13]);
end; // CheckIE_AC

function CheckIE_AL(const AIE: string) :Boolean; // 24XNNNNND
var
  b   ,
  i   ,
  soma: Integer;
  dig : SmallInt;
begin
  Result := false;
  if (length(AIE) <> 9) then exit;
  if (not IsNumero(AIE)) then exit;
  if (Copy(AIE, 1, 2) <> '24') then exit;
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, CharToInt(AIE[i]) * b);
    dec(b);
  end;
  soma := soma * 10;
  dig := soma - trunc(soma / 11) * 11;
  if (dig = 10) then dig := 0;
  Result := (IntToChar(dig) = AIE[09]);
end; // CheckIE_AL

function CheckIE_AM(const AIE: string):Boolean;  // 99.999.999-9
var
  b   ,
  i   ,
  soma: Integer;
  dig : SmallInt;
begin
  Result := false;
  if (length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  b    := 9;
  soma := 0;
  for i := 1 to 8 do
  begin
    inc(soma, CharToInt(AIE[i]) * b);
    dec(b);
  end;
  if (soma < 11) then
    dig := 11 - soma
  else
  begin
    i := (soma mod 11);
    if (i <= 1) then
      dig := 0
    else
      dig := 11 - i;
  end;
  Result := (IntToChar(dig) = AIE[09]);
end; // CheckIE_AM

function CheckIE_AP(const AIE: string) : Boolean; // 999999999
var
  p, d,
  b, i,
  soma: Integer;
  dig : SmallInt;
begin
  Result := false;
  if (length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  p := 0;
  d := 0;
  i := StrToInt(copy(AIE, 1, 8));
  if (i >= 03000001) and (i <= 03017000) then
  begin
    p := 5;
    d := 0;
  end
  else
    if (i >= 03017001) and (i <= 03019022) then
    begin
      p := 9;
      d := 1;
    end;
  b    := 9;
  soma := p;
  for i := 1 to 08 do
  begin
   inc(soma, CharToInt(AIE[i]) * b);
   dec(b);
  end;
  dig := 11 - (soma mod 11);
  if (dig = 10) then
    dig := 0
  else
    if dig = 11 then dig := d;
  Result := (IntToChar(dig) = AIE[09]);
end; //CheckIE_AP

function CheckIE_BA(const AIE: string) : Boolean; // 999999-99
var
  b, i  ,
  soma  : Integer;
  nro   : array[1..8] of byte;
  NumMod: word;
  dig   : SmallInt;
  die   : string;
begin
  Result := false;
  if (length(AIE) <> 8) then exit;
  die := copy(AIE, 1, 8);
  if (not IsNumero(die)) then exit;
  for i := 1 to 8 do
    nro[i] := CharToInt(die[i]);
  if nro[1] in [0, 1, 2, 3, 4, 5, 8] then
    NumMod := 10
  else
    NumMod := 11; // calculo segundo
  b := 7; soma := 0;
  for i := 1 to 06 do
  begin
    inc(soma, (nro[i] * b));
    dec(b);
  end;
  i := soma mod NumMod;
  if (NumMod = 10) then
  begin
    if i = 0 then
      dig := 0
    else
      dig := NumMod - i;
  end
  else
  begin
    if i <= 1 then
      dig := 0
    else
      dig := NumMod - i;
  end;
  Result := (dig = nro[8]);
  if (not Result) then exit; // calculo segundo
  b := 8;
  soma := 0;
  for i := 1 to 06 do
  begin
    inc(soma, (nro[i] * b));
    dec(b);
  end;
  inc(soma, (nro[8] * 2));
  i := soma mod NumMod;
  if (NumMod = 10) then
  begin
    if (i = 0) then
      dig := 0
    else
      dig := NumMod - i;
  end
  else
  begin
    if (i <= 1) then
      dig := 0
    else
      dig := NumMod - i;
    end;
  Result := (dig = nro[7]);
end; // CheckIE_BA

function CheckIE_CE(const AIE: string): Boolean; // 999999999
var
  b, i,
  soma: Integer;
  nro : array[1..9] of byte;
  dig : SmallInt;
  die : string;
begin
  Result := false;
  if (Length(AIE) > 09) then exit;
  if (not IsNumero(AIE)) then exit;
  die := AIE;
  if (Length(AIE) < 9) then
  begin
    repeat
      die := '0' + die;
    until (Length(die) = 9);
  end;
  for i := 1 to 9 do
    nro[i] := CharToInt(die[i]);
    b      := 9;
    soma   := 0;
    for i := 1 to 08 do
    begin
      inc(soma, (nro[i] * b));
      dec(b);
    end;
    dig := 11 - (soma mod 11);
    if (dig >= 10) then dig := 0;
    Result := (dig = nro[9]);
end; // CheckIE_CE

function CheckIE_DF(const AIE: string): Boolean;  // 999.99999.999.99
var
  b, i,
  soma: Integer;
  nro : array[1..13] of byte;
  dig : smallInt;
begin
  Result := false;
  if (length(AIE) <> 13) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 13 do
    nro[i] := CharToInt(AIE[i]);
  b    := 4;
  soma := 0;
  for i := 1 to 11 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
    if b = 1 then b := 9;
  end;
  dig := 11 - (soma mod 11);
  if (dig >= 10) then
    dig := 0;
  Result := (dig = nro[12]);
  if not Result then exit;
  b    := 5;
  soma := 0;
  for i := 1 to 12 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
    if (b = 1) then b := 9;
  end;
  dig := 11 - (soma mod 11);
  if (dig >= 10) then dig := 0;
  Result := (dig = nro[13]);
end; // CheckIE_DF

function CheckIE_ES(const AIE: string): Boolean;  // 99999999-9
var
  b, i,
  soma: Integer;
  nro : array[1..9] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 9 do
    nro[i] := CharToInt(AIE[i]);
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
  end;
  i := soma mod 11;
  if i < 2 then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[9]);
end; // CheckIE_ES

function CheckIE_GO(const AIE : string): Boolean; // 99.999.999.9
var
  n, b,
  i   ,
  soma: Integer;
  nro : array[1..9] of byte;
  dig : SmallInt;
  s : string;
begin
  Result := false;
  if (Length(AIE) <> 9) then exit;
  if (not IsNumero(AIE)) then exit;
  s := Copy(AIE, 1, 2);
  if (s = '10') or (s = '11') or (s = '15') then
  begin
    for i := 1 to 9 do
      nro[i] := CharToInt(AIE[i]);
    n := trunc(StrToFloat(AIE) / 10);
    if (n = 11094402) then
    begin
      if (nro[9] = 0) or (nro[9] = 1) then
      begin
        Result := true;
        exit;
      end;
    end;
    b    := 9;
    soma := 0;
    for i := 1 to 08 do
    begin
      inc(soma, nro[i] * b);
      dec(b);
    end;
    i := (soma mod 11);
    if (i = 0) then
      dig := 0
    else
      if (i = 1) then
      begin
        if (n >= 10103105) and (n <= 10119997) then
          dig := 1
        else
          dig := 0;
      end
      else
      begin
       dig := 11 - i;
      end;
    Result := (dig = nro[9]);
  end;
end; // CheckIE_GO

function CheckIE_MA(const AIE: string): Boolean; // 999999999
var
  b, i,
  soma: Integer;
  nro : array[1..9] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 9 do
    nro[i] := CharToInt(AIE[i]);
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[9]);
end; // CheckIE_MA

function CheckIE_MT(const AIE: string): Boolean;  // 9999999999-9
var
  b, i,
  soma: Integer;
  nro : array[1..11] of byte;
  dig : SmallInt;
  die : string;
begin
  Result := false;
  if (Length(AIE) < 9) then exit;
  die := AIE;
  if (Length(die) < 11) then
  begin
    repeat
      die := '0' + die;
    until (Length(die) = 11);
  end;
  if (not IsNumero(die)) then exit;
  for i := 1 to 11 do
    nro[i] := CharToInt(die[i]);
  b    := 3;
  soma := 0;
  for i := 1 to 10 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
    if (b = 1) then
      b := 9;
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[11]);
end; // CheckIE_MT

function CheckIE_MS(const AIE: string): Boolean; // 999999999
var
  b, i,
  soma: Integer;
  nro : array[1..09] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  if (Copy(AIE, 1, 2) <> '28') then exit;
  for i := 1 to 09 do
    nro[i] := CharToInt(AIE[i]);
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[09]);
end; // CheckIE_MS

function CheckIE_PA(const AIE: string): Boolean; // 99.999999-9
var
  b, i,
  soma: Integer;
  nro : array[1..09] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 9) then exit;
  if (not IsNumero(AIE)) then exit;
  if (copy(AIE,1,2) <> '15') then exit;
  for i := 1 to 09 do
    nro[i] := CharToInt(AIE[i]);
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[09]);
end; // CheckIE_PA

function CheckIE_PB(const AIE: string): Boolean; // 99999999-9
var
  b, i,
  soma: Integer;
  nro : array[1..09] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 09 do
    nro[i] := CharToInt(AIE[i]);
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[09]);
end; // CheckIE_PB

function CheckIE_PR(const AIE: string): Boolean; //  99999999-99
var
  b, i,
  soma: Integer;
  nro : array[1..10] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 10) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 10 do
    nro[i] := CharToInt(AIE[i]);
  b    := 3;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
    if (b = 1) then b := 7;
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[09]);
  if not result then exit;
  b    := 4;
  soma := 0;
  for i := 1 to 09 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
    if (b = 1) then b := 7;
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[10]);
end; // CheckIE_PR

function CheckIE_PE(const AIE: string): Boolean; // 99.9.999.9999999-9
var
  b, i,
  soma: Integer;
  nro : array[1..14] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 14) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 14 do
    nro[i] := CharToInt(AIE[i]);
  b    := 5;
  soma := 0;
  for i := 1 to 13 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
    if (b = 0) then b := 9;
  end;
  dig := 11 - (soma mod 11);
  if (dig > 9) then dig := dig - 10;
  Result := (dig = nro[14]);
end; // CheckIE_PE

function CheckIE_PI(const AIE: string): Boolean; // 999999999
var
  b, i,
  soma: Integer;
  nro : array[1..09] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 09 do
    nro[i] := CharToInt(AIE[i]);
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[09]);
end; // CheckIE_PI

function CheckIE_RJ(const AIE: string): Boolean; // 99.999.99-9
var
  b, i,
  soma: Integer;
  nro : array[1..08] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 08) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 08 do
    nro[i] := CharToInt(AIE[i]);
  b    := 2;
  soma := 0;
  for i := 1 to 07 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
    if (b = 1) then b := 7;
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[08]);
end; // CheckIE_RJ

function CheckIE_RN(const AIE: string): Boolean; // 99.999.999-9
var
  b, i,
  soma: Integer;
  nro : array[1..09] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 09 do
    nro[i] := CharToInt(AIE[i]);
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
  end;
  soma := soma * 10;
  dig := (soma mod 11);
  if (dig = 10) then dig := 0;
  Result := (dig = nro[09]);
end; // ChexkIE_RN

function CheckIE_RS(const AIE: string): Boolean;  // 999/999999-9
var
  b, i,
  soma: Integer;
  nro : array[1..10] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 10) then exit;
  if (not IsNumero(AIE)) then exit;
  i := StrToInt(Copy(AIE, 1, 3));
  if (i >= 1) and (i <= 467) then
  begin
    for i := 1 to 10 do
      nro[i] := CharToInt(AIE[i]);
    b    := 2;
    soma := 0;
    for i := 1 to 09 do
    begin
      inc(soma, nro[i] * b);
      dec(b);
      if (b = 1) then b := 9;
    end;
    dig := 11 - (soma mod 11);
    if (dig >= 10) then dig := 0;
    Result := (dig = nro[10]);
  end;
end; // CheckIE_RS

// Rondônia - versão antiga

function CheckIE_RO(const AIE: string): Boolean;  overload; // 999.99999-9
var
  b, i,
  soma: Integer;
  nro : array[1..09] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 09 do
    nro[i] := CharToInt(AIE[i]);
  b    := 6;
  soma := 0;
  for i := 4 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b)
  end;
  dig := 11 - (soma mod 11);
  if (dig >= 10) then dig := dig - 10;
  Result := (dig = nro[09]);
end; // CheckIE_RO

// Rondônia - versão nova

function CheckIE_RO(AIE: PAnsiChar): boolean; overload; // 999.99999-9
var
  i, x,
  y, z,
  j   : integer;
  s   : string;
  sie : string;
begin
  y := 6;
  z := 0;
  sie := StrPas(AIE);
  for j := 1 to Length(Trim(AIE)) do
    if sie[j] in ['0','1','2','3','4','5','6','7','8','9','0'] then
      s := s + sie[j];
  if (not (Length(s) <> 14)) then
  begin
    for i := 1 to (14 - Length(Trim(s))) do
      s := '0' + Trim(s)
  end;
  for i := 1 to (length(s) - 1) do
  begin
    x := StrToInt(s[i])* y;
    z := z + x;
    if (y  > 2) then
      dec(y)
    else
      y := 9;
  end;
  x := z mod 11;
  y := 11 - x;
  if (IntToStr(y) = s[14]) then
    Result := true
  else
    Result := false;
end; // CheckIE_RO

function CheckIE_RR(const AIE: string): Boolean; // 99.999999-9
var
  i    ,
  soma : Integer;
  nro : array[1..09] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  if (Copy(AIE, 1, 2) <> '24') then exit;
  for i := 1 to 09 do
    nro[i] := CharToInt(AIE[i]);
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * i);
  end;
  dig := (soma mod 09);
  Result := (dig = nro[09]);
end; // ChckIE_RR

function CheckIE_SC(const AIE: string): Boolean;  // 999.999.999
var
  b, i,
  soma: Integer;
  nro : array[1..09] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 09 do
    nro[i] := CharToInt(AIE[i]);
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
  end;
  i := (soma mod 11);
  if (i <= 1) then
    dig := 0
  else
    dig := 11 - i;
  Result := (dig = nro[09]);
end; // CheckIE_SC

function CheckIE_SP(const AIE: string): Boolean;
var
  i   ,
  soma: Integer;
  nro : array[1..12] of byte;
  dig : SmallInt;
  s   : string;
begin
  Result := false;
  if UpperCase(Copy(AIE, 1, 1)) = 'P' then
  begin
    s := Copy(AIE, 2, 9);
    if (not IsNumero(s)) then exit;
    for i := 1 to 8 do
      nro[i] := CharToInt(s[i]);
    soma := (nro[1] * 1) + (nro[2] * 3) + (nro[3] * 4) + (nro[4] * 5) +
            (nro[5] * 6) + (nro[6] * 7) + (nro[7] * 8) + (nro[8] * 10);
    dig := (soma mod 11);
    if (dig >= 10) then dig := 0;
    Result := (dig = nro[09]);
    if (not Result) then exit;
  end
  else
  begin
    if (Length(AIE) < 12)  then exit;
    if (not IsNumero(AIE)) then exit;
    for i := 1 to 12 do
      nro[i] := CharToInt(AIE[i]);
    soma := (nro[1] * 1) + (nro[2] * 3) + (nro[3] * 4) + (nro[4] * 5) +
            (nro[5] * 6) + (nro[6] * 7) + (nro[7] * 8) + (nro[8] * 10);
    dig := (soma mod 11);
    if (dig >= 10) then dig := 0;
    Result := (dig = nro[09]);
    if not Result then exit;
    soma := (nro[1] * 3) + (nro[2] * 2)  + (nro[3]  * 10) + (nro[4] * 9) +
            (nro[5] * 8) + (nro[6] * 7)  + (nro[7]  * 6)  + (nro[8] * 5) +
            (nro[9] * 4) + (nro[10] * 3) + (nro[11] * 2);
    dig := (soma mod 11);
    if (dig >= 10) then dig := 0;
    Result := (dig = nro[12]);
  end;
end; // CheckIE_SP

function CheckIE_SE(const AIE: string): Boolean; // 99999999-9
var
  b, i,
  soma: Integer;
  nro : array[1..09] of byte;
  dig : SmallInt;
begin
  Result := false;
  if (Length(AIE) <> 09) then exit;
  if (not IsNumero(AIE)) then exit;
  for i := 1 to 09 do
    nro[i] := CharToInt(AIE[i]);
  b    := 9;
  soma := 0;
  for i := 1 to 08 do
  begin
    inc(soma, nro[i] * b);
    dec(b);
  end;
  dig := 11 - (soma mod 11);
  if (dig >= 10) then dig := 0;
  Result := (dig = nro[09]);
end; // CheckIE_SE

function CheckIE_TO(const AIE: string): Boolean; // 99.99.999999-9
var
  b, i,
  soma: Integer;
  nro : array[1..11] of byte;
  dig : SmallInt;
  s   : string;
begin
  Result := false;
  if (Length(AIE) <> 11) then exit;
  if (not IsNumero(AIE)) then exit;
  s := Copy(AIE, 3, 2);
  if (s = '01') or (s = '02') or (s = '03') or (s = '99') then
  begin
    for i := 1 to 11 do
      nro[i] := CharToInt(AIE[i]);
    b    := 9;
    soma := 0;
    for i := 1 to 10 do
    begin
      if (i <> 3) and (i <> 4) then
      begin
        inc(soma, nro[i] * b);
        dec(b);
      end;
    end;
    i := (soma mod 11);
    if (i <= 1) then
      dig := 0
    else
      dig := 11 - i;
    Result := (dig = nro[11]);
  end;
end; // CheckIE_TO

//--------------------------------------------------------------f

function  VerificaInscricao(const AIE, AUF: string): Boolean;
var
  duf,
  die: string;
begin
  Result := False;
  if (Trim(AIE) = '.') then exit;
  duf := UpperCase(AUF);
  die := UpperCase(AllTrim(AIE));
  Result := (Copy(die, 1, 5) = 'ISENT') or (die = '');
  if (Result) then exit;
  if duf = 'AC' then Result := CheckIE_AC(die);
  if duf = 'AL' then Result := CheckIE_AL(die);
  if duf = 'AP' then Result := CheckIE_AP(die);
  if duf = 'AM' then Result := CheckIE_AM(die);
  if duf = 'BA' then Result := CheckIE_BA(die);
  if duf = 'CE' then Result := CheckIE_CE(die);
  if duf = 'DF' then Result := CheckIE_DF(die);
  if duf = 'ES' then Result := CheckIE_ES(die);
  if duf = 'GO' then Result := CheckIE_GO(die);
  if duf = 'MA' then Result := CheckIE_MA(die);
  if duf = 'MG' then Result := CheckIE_MG(die);
  if duf = 'MT' then Result := CheckIE_MT(die);
  if duf = 'MS' then Result := CheckIE_MS(die);
  if duf = 'PA' then Result := CheckIE_PA(die);
  if duf = 'PB' then Result := CheckIE_PB(die);
  if duf = 'PR' then Result := CheckIE_PR(die);
  if duf = 'PE' then Result := CheckIE_PE(die);
  if duf = 'PI' then Result := CheckIE_PI(die);
  if duf = 'RJ' then Result := CheckIE_RJ(die);
  if duf = 'RN' then Result := CheckIE_RN(die);
  if duf = 'RS' then Result := CheckIE_RS(die);
  if duf = 'RO' then Result := (CheckIE_RO(die) or CheckIE_RO(PAnsiChar(die)));
  if duf = 'RR' then Result := CheckIE_RR(die);
  if duf = 'SC' then Result := CheckIE_SC(die);
  if duf = 'SP' then Result := CheckIE_SP(die);
  if duf = 'SE' then Result := CheckIE_SE(die);
  if duf = 'TO' then Result := CheckIE_TO(die);
end; // VerificaInscricao.

end.
