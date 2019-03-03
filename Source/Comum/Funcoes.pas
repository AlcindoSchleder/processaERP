unit Funcoes;

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

uses SysUtils, Classes, Math, ProcType, ProcUtils,
   {$IFNDEF LINUX}
     Windows, Controls, Graphics, Forms, Dialogs, ComCtrls, ToolWin, Buttons,
     Menus, StdCtrls, ExtCtrls, Registry
   {$ELSE}
     Qt, QControls, QGraphics, QForms, QDialogs, QComCtrls, QToolWin, QButtons,
     QMenus, QStdCtrls, QExtCtrls
   {$ENDIF};

type
  TSubTotalType = (stSubTotal, stDiscount);

  procedure SetColor(AComponent: TComponent; APropertyName: string;
    AColor: TColor);
  function  GetProperty(AComponent: TComponent; const Propr: string): Boolean;
  function  GetValueProperty(AComponent: TObject; const Propr: string): string;
  function  GetMethod(AComponent: TComponent; const Propr: string): TMethod;
  procedure SetProperty(AComponent: TComponent; const Propr: string;
              const AValue: Pointer = nil);
  function  PosPalavra(const AWord, AString: string): Integer;
  function  PathDoPrograma(Path: string): string;
  function  MoveVarGlobal(var Variavel: SmallInt; const StrAux: string): Boolean;
  function  VerCgc(Snrcgc: string): Boolean;
  function  VerCpf(Snrcpf: string): Boolean;
  function  CalcDig(Numero: string; Tipo: Boolean): string;
  function  Digito(Numero: string): Boolean;
  function  AnoBisexto(Ano: Integer): Boolean;
  function  AdicionaDia(data: TDateTime; Valor: Integer): TDateTime;
  function  AdicionaMes(data: TDateTime; Valor: Integer): TDateTime;
  function  AdicionaAno(data: TDateTime; Valor: Integer): TDateTime;
  function  SubtraiDia(data: TDateTime; Valor: Integer): TDateTime;
  function  SubtraiMes(data: TDateTime; Valor: Integer): TDateTime;
  function  SubtraiAno(data: TDateTime; Valor: Integer): TDateTime;
  function  InsereSpc(palavra: string; Qtd: Integer): string;
  function  InsPosSpc(palavra: string; Qtd: Integer): string;
  function  CalculaDias(Valor: Double; DataI, DataF: TDateTime; Calc: Integer): Double;
  function  VerificaNivel(const Nivel: Integer; Operacao: TOperation): Boolean;
  function  VerificaDiaUtil(Data: TDateTime): TDateTime;
  function  TiraPonto(Numero: Double): Double;
  function  DeletaCurrency(NumStr: string): string;
  function  PontoDecimal(Valor: string): Double;
  function  DeletaPonto(Valor: string): string;
  {$IFDEF WIN32}
    function  GetWindowsUser: AnsiString;
  {$ENDIF}
  function  SetPercent(const APercent, ABaseValue: Double;
              ASign: Char = '+'): Double;
  function  GetPercent(const ASubTot, ATotal: Double;
              AForeverPositive: Boolean = False;
              ATypeSubTotal: TSubTotalType = stSubTotal): Double;
  function  PercentToIndex(const APercent: Double): Double;
  function  CalculaFatorial(Refer: Double; Fator: Integer): Double;
  function  CalculaJuros(const Valor: Double; const DataIni, DataFin: TDateTime;
              Taxa: Double): Double;
  function  CalculaLista(const Preco, Taxa: Double; const Lista: TStringList;
              Flag: string): Double;
  function  SomaDias(const Lista: TStringList): Integer;
  procedure Liberar(Sender: TObject; Status: Boolean);
  procedure MudaInsEd(Status: Boolean; Form: TComponent);
  procedure DesabilitaOperacoes(Status: Boolean; Form: TComponent);
  function  CalculaDigito(const Banco: string; const BcoCob: Integer): String;
  function  CalculaSoma(const StrBco: string; const Vlri: Integer): Integer;
  function  Soundex(const s: string): string;
  function  NomeEstacao: AnsiString;
  function  VerificaCondicao(Condicao: PBoolean; const Campo: string): string;
  function  PegaMaquina: string;
  function  CriaMascara(const Valor: Smallint; const Mascara: string): string;
  function  VerificaMatriz(Bits: array of Byte): Boolean;
  function  TiraDecimalStr(Numero: Double): string;
  function  PegaPosicao(var Ini, Fim, TipoDado: SmallInt;
              const Campo, Tamanho: string): Boolean;
  function  Mascara_Inscricao(Estado: string): string;
  function  CalculaEAN13(CodigoC: string): string;
  function  CalculaEAN8(CodigoC: string): string;
  function  CalculaUPC(CodigoC: string): string;
  function  FormataListStr(List: array of string): string;
  function  ClearChar(Str, Chr: string): string;
  function  GeneratePassword(Len: Integer): string;
  function  GetBooleanData(AValue: Integer): string;
  procedure ReleaseCombos(ACombo: TComboBox; aTypeObject: TTypeObject);
  function  RemoveAcentos(Str: string): string;
  function  ReadRegistry(AKey, AValue: string): string;
  function  WriteRegistry(AKey, AName, AValue: string): Boolean;
  function  GetUpdateSQL(const AFields, AWhereFields: TStrings;
              const ATableName: string): TStrings;
  function  GetInsertSQL(const AFields: TStrings; const ATableName: string): TStrings;
  function  GetWhereSQL(const AFields: TStrings; const AWhereFields: TStrings): TStrings;
  procedure ChangeControlColors(AForm: TForm; const AColor, AFontColor: TColor);
  function  GetListValue(var AList: string): Integer;
  function  CheckPeriodList(const AList: string; var AQtdParc: Integer): string;
  function  Capitalize(const ALine: string): string;

implementation

uses TypInfo, StrUtils, CmmConst;

procedure SetColor(AComponent: TComponent; APropertyName: string;
  AColor: TColor);
var
  PropInfo: PPropInfo;

  procedure SetObject;
  var
    FObject: TObject;
    FFont: TFont;
  begin
    FObject := GetObjectProp(AComponent, PropInfo);
    if FObject <> nil then
    begin
      FFont       := TFont.Create;
      SetSetProp(FFont, 'Style', GetSetProp(FObject, 'Style'));
      FFont.Size  := GetPropValue(FObject, 'Size');
      FFont.Name  := GetPropValue(FObject, 'Name');
      FFont.Color := AColor;
      SetObjectProp(AComponent, PropInfo, FFont);
    end;
  end;

begin
  if (AComponent = nil) or (APropertyName = '') then exit;
  PropInfo := GetPropInfo(AComponent.ClassInfo, APropertyName);
  if PropInfo <> nil then
  begin
    case PropInfo^.PropType^.Kind of
      tkClass      : SetObject;
      tkInteger    : SetOrdProp(AComponent, PropInfo, AColor);
    end;
  end;
  PropInfo := nil;
end;

function  GetProperty(AComponent: TComponent; const Propr: string): Boolean;
begin
  Result := GetPropInfo(AComponent.ClassInfo, Propr) <> nil;
end;


function  GetValueProperty(AComponent: TObject; const Propr: string): string;
var
  PropInfo: PPropInfo;
begin
  Result := '';
  PropInfo := GetPropInfo(AComponent.ClassInfo, Propr);
  if (PropInfo <> nil) then
    case PropInfo^.PropType^.Kind of
      tkEnumeration: Result := GetEnumProp(AComponent, PropInfo);
      tkString     : Result := GetStrProp(AComponent, PropInfo);
      tkInt64,
      tkInteger    : Result := IntToStr(GetInt64Prop(AComponent, PropInfo));
    end;
end;

function  GetMethod(AComponent: TComponent; const Propr: string): TMethod;
var
  PropInfo: PPropInfo;
begin
  Result.Code := nil;
  Result.Data := nil;
  PropInfo := GetPropInfo(AComponent.ClassInfo, Propr);
  if (PropInfo <> nil) and
     (PropInfo^.PropType^.Kind = tkMethod) then
    Result := GetMethodProp(AComponent, PropInfo);
end;

procedure SetProperty(AComponent: TComponent; const Propr: string;
  const AValue: Pointer = nil);
var
  PropInfo: PPropInfo;
begin
  if AValue <> nil then
  begin
    PropInfo := GetPropInfo(AComponent.ClassInfo, Propr);
    if PropInfo <> nil then
    begin
      case PropInfo^.PropType^.Kind of
        tkEnumeration      : SetOrdProp(AComponent, PropInfo, Integer(AValue^));
        tkString, tkLString: SetStrProp(AComponent, PropInfo, string(AValue^));
        tkClass            : SetObjectProp(AComponent, PropInfo, TObject(AValue^));
        tkMethod           : SetMethodProp(AComponent, PropInfo, TMethod(AValue^));
      end;
    end;
  end
  else
  begin
    PropInfo := GetPropInfo(AComponent.ClassInfo, Propr);
    if PropInfo <> nil then
    begin
      case PropInfo^.PropType^.Kind of
        tkEnumeration      : SetOrdProp(AComponent, PropInfo, 0);
        tkString, tkLString: SetStrProp(AComponent, PropInfo, '');
        tkClass            : SetObjectProp(AComponent, PropInfo, nil);
      end;
    end;
  end;
end;

function PosPalavra(const AWord, AString: string): Integer;
var s: string;
    i, p: Integer;
begin
  s := ' ' + AnsiUpperCase(AString) + ' ';   // do not localize
  for i := 1 to Length(s) do if not (s[i] in Identificadores) then s[i] := ' ';  {do not localize}
  p := Pos(' ' + AnsiUpperCase(AWord) + ' ', s);    // do not localize
  Result := p;
end;

function  PathDoPrograma(Path: string): string;
begin
  Path := ExtractFilePath(ParamStr(0));
  if (Length(Path) > 0) then
    {$IFDEF WIN32}
      if Path[Length(Path)] <> '\' then
        Path := Path + '\';
    {$ENDIF}
    {$IFDEF LINUX}
      if Path[Length(Path)] <> '/' then
        Path := Path + '/';
    {$ENDIF}
  Result := Path;
end;

function  MoveVarGlobal(var Variavel: SmallInt; const StrAux: string): Boolean;
begin
  Result := True;
  try
    Variavel := StrToInt(StrAux);
  except
    Result := False;
  end;
end;

function  VerCgc(Snrcgc : String) : Boolean;
var
   WcgcCalc : String;
   WsomaCgc : Integer;
   Wsx1     : ShortInt;
   WcgcDigt : Integer;
begin
  Result := False;
  if (snrCGC <> '  .   .   /    -') and
     (snrCGC <> '') and
     (snrCGC <> '00000000000000') then
  begin
    try
      Snrcgc := Copy(Snrcgc, 1, 2) + Copy(Snrcgc, 3, 3)+
      Copy(Snrcgc, 6, 3) + Copy(Snrcgc, 9, 4) + Copy(Snrcgc, 13, 2);
      WcgcCalc := Copy(Snrcgc,1,12);
      WsomaCgc := 0;
      for Wsx1 := 1 to 4 do
      WsomaCgc := WsomaCgc + StrToInt(Copy(WcgcCalc, Wsx1, 1)) * (6 - Wsx1);
      for Wsx1 := 1 to 8 do
        WsomaCgc := WsomaCgc + StrToInt(Copy(WcgcCalc, Wsx1 + 4, 1)) * (10 - Wsx1);
      WcgcDigt := 11 - WsomaCgc mod 11;
      if wcgcdigt in [10,11] then
        WcgcCalc := WcgcCalc + '0'
      else
        WcgcCalc := WcgcCalc +  IntToStr(WcgcDigt);
      WsomaCgc := 0;
      for Wsx1 := 1 to 5 do
        WsomaCgc:= WsomaCgc + StrToInt(Copy(WcgcCalc, Wsx1, 1)) * (7 - Wsx1);
      for Wsx1 := 1 to 8 do
        WsomaCgc := Wsomacgc + StrToInt(Copy(WcgcCalc, Wsx1 + 5, 1)) * (10 - Wsx1);
      WcgcDigt := 11 - WsomaCgc mod 11;
      if WcgcDigt in [10, 11] then
        WcgcCalc := WcgcCalc + '0'
      else
        WcgcCalc := WcgcCalc +  IntToStr(WcgcDigt);
      if  Snrcgc <> WcgcCalc then
        Result := False
      else
        Result := True ;
    except on EconvertError do
      Result := False;
    end;
  end;
end;

function  VerCpf(Snrcpf:string):Boolean;
var
   WCpfCalc : String;
   WSomaCpf : Integer;
   Wsx1     : ShortInt;
   WCpfDigt : Integer;
begin
  Result := False;
  if (Snrcpf <> '   .   .   -  ') and
     (Snrcpf <> '') and
     (Snrcpf <> '00000000000') then
  begin
    try
      Snrcpf := Copy(Snrcpf,1,3)+Copy(Snrcpf,4,3)+
      Copy(Snrcpf,7,3)+Copy(Snrcpf,10,2);
      WCpfCalc := Copy(Snrcpf, 1, 9);
      WSomaCpf := 0;
      for Wsx1:= 1 to 9 do
        WSomaCpf := WSomaCpf + StrtoInt(Copy(WCpfCalc, Wsx1, 1)) * (11 - Wsx1);
      WCpfDigt:= 11 - WSomaCpf mod 11;
      if WCpfDigt in [10,11] then
        WCpfCalc:= WCpfCalc + '0'
      else
        WCpfCalc := WCpfCalc +  IntToStr(WCpfDigt);
      WSomaCpf:= 0;
      for Wsx1:= 1 to 10 do
        WSomaCpf := WSomaCpf + StrToInt(Copy(WCpfCalc, Wsx1, 1)) * (12 - Wsx1);
      WCpfDigt:= 11 - WSomaCpf mod 11;
      if WCpfDigt in [10,11] then
        WCpfCalc:= WCpfCalc + '0'
      else
        WCpfCalc := WCpfCalc +  IntToStr(WCpfDigt);
      if  Snrcpf <> WCpfCalc then
        Result := False
      else
        Result := True;
    except on EConvertError do
      Result := False;
    end;
  end;
end;

function  CalcDig(Numero: string; Tipo: Boolean): string;
var
  i, j, Soma, Dig: Integer;
begin
  Soma := 0;
  j := 1;
  for i := Length(Numero) downto 1 do
  begin
    Inc(j);
    if j > 7 then
      j := 2;
    Soma := Soma + (StrToInt(Numero[i]) * j);
  end;
  Dig := 11 - (Soma mod 11);
  if Tipo then
    if Dig  = 10 then
      Numero := Numero + 'P'
    else
      Numero := Numero + IntToStr(Dig)
  else
    if Dig  = 10 then
      Numero := Numero + '0'
    else
      Numero := Numero + IntToStr(Dig);
  Result := Numero;
end;

function  Digito(Numero: string): Boolean;
var
  Number, Anterior: string;
  i, j, Soma, Dig: Integer;
begin
  Anterior := Numero;
  Number := Copy(Anterior, 0, Length(Anterior) - 1);
  Soma := 0;
  j := 1;
  for i := Length(Number) downto 1 do
  begin
    Inc(j);
    if j > 7 then
      j := 2;
    Soma := Soma + (StrToInt(Number[i]) * j);
  end;
  Dig := 11 - (Soma mod 11);
  if Dig = 10 then
    Dig := 0;
  Number := Number + IntToStr(Dig);
  if Number <> Anterior then
    Result := False
  else
    Result := True;
end;

function  AnoBisexto(Ano: Integer): Boolean;
begin
// funÁ„o que faz a verificaÁ„o do Ano bisexto
  Result := (Ano mod 4 = 0) and ((Ano mod 100 <> 0) or (Ano mod 400 = 0));
end;

function  AdicionaDia(data: TDateTime; Valor: Integer): TDateTime;
var
  Dia, Mes, Ano: Word;
  DiasDoMes, Dias: Integer;
  Datas: TDateTime;
begin
  DecodeDate(data, Ano, Mes, Dia);
  Dias := Dia + Valor;
  repeat
    if AnoBIsexto(Ano) and (Mes = 2) then
      DiasDoMes := DiaDoMes[Mes] + 1
    else
      DiasDoMes := DiaDoMes[Mes];
    if Dias > DiasDoMes then
    begin
      Dias := Dias - DiasDoMes;
      Datas := AdicionaMes(EncodeDate(Ano, Mes, Dia), 1);
      DecodeDate(datas, Ano, Mes, Dia);
      DiasDoMes := DiaDoMes[Mes];
    end;
  until  Dias <= DiasDoMes;
  Dia := Dias;
  Result := EncodeDate(Ano, Mes, Dia);
end;

function  AdicionaMes(data: TDateTime; Valor: Integer): TDateTime;
var
  Dia, Mes, Ano: Word;
  Meses: Integer;
  Datas: TDateTime;
begin
  DecodeDate(data, Ano, Mes, Dia);
  Meses := Mes + Valor;
  repeat
    if Meses > 12 then
    begin
      Datas := AdicionaAno(EncodeDate(Ano, Mes, Dia), 1);
      DecodeDate(datas, Ano, Mes, Dia);
      Meses := Meses - 12;
    end;
  until  Meses <= 12;
  Mes := Meses;
//  if Dia > DiaDoMes[Mes] then
//    Dia := 1;
  while Dia > DiaDoMes[Mes] do
    Dec(Dia);
  Result := EncodeDate(Ano, Mes, Dia);
end;

function  AdicionaAno(data: TDateTime; Valor: Integer): TDateTime;
var
  Dia, Mes, Ano: Word;
begin
  DecodeDate(data, Ano, Mes, Dia);
  Ano := Ano + Valor;
  Result := EncodeDate(Ano, Mes, Dia);
end;

function  SubtraiDia(data: TDateTime; Valor: Integer): TDateTime;
var
  Dia, Mes, Ano: Word;
  DiasDoMes, Dias: Integer;
  Datas: TDateTime;
begin
  DecodeDate(data, Ano, Mes, Dia);
  Dias := Dia - Valor;
  repeat
    if AnoBisexto(Ano) and (Mes = 2) then
      DiasDoMes := DiaDoMes[Mes] + 1
    else
      DiasDoMes := DiaDoMes[Mes];
    if Dias <= 0 then
    begin
      Datas := SubtraiMes(EncodeDate(Ano, Mes, Dia), 1);
      DecodeDate(datas, Ano, Mes, Dia);
      DiasDoMes := DiaDoMes[Mes];
      Dias := Dias + DiasDoMes;
    end;
  until  Dias <= DiasDoMes;
  Dia := Dias;
  Result := EncodeDate(Ano, Mes, Dia);
end;

function  SubtraiMes(data: TDateTime; Valor: Integer): TDateTime;
var
  Dia, Mes, Ano: Word;
  Meses: Integer;
  Datas: TDateTime;
begin
  DecodeDate(data, Ano, Mes, Dia);
  Meses := Mes - Valor;
  repeat
    if Meses <= 0 then
    begin
      Datas := SubtraiAno(EncodeDate(Ano, Mes, Dia), 1);
      DecodeDate(datas, Ano, Mes, Dia);
      Meses := Meses + 12;
    end;
  until  Meses <= 12;
  Mes := Meses;
  Result := EncodeDate(Ano, Mes, Dia);
end;

function  SubtraiAno(data: TDateTime; Valor: Integer): TDateTime;
var
  Dia, Mes, Ano: Word;
begin
  DecodeDate(data, Ano, Mes, Dia);
  Ano := Ano - Valor;
  Result := EncodeDate(Ano, Mes, Dia);
end;

function  InsereSpc(palavra: string; Qtd: Integer): string;
var
  i: Integer;
begin
  for i := (Length(palavra) + 1) to Qtd do
    Insert(' ', palavra, i);
  Result := palavra;
end;

function  InsPosSpc(palavra: string; Qtd: Integer): string;
var
  i: Integer;
begin
  i := 1;
  while Length(palavra) < Qtd do
  begin
    Insert(' ', palavra, i);
    Inc(i);
  end;
  Result := palavra;
end;

function  CalculaDias(Valor: Double; DataI, DataF: TDateTime; Calc: Integer): Double;
var
  Dia, Mes, Ano: Word;
  Dias: Double;
begin
  DecodeDate(DataI, Dia, Mes, Ano);
  Dias := DataF - DataI;
  if Calc = 1 then
    if Dias < DiaDoMes[Mes] then
      Result := (Dias / 30) * Valor
    else
      Result := Valor
  else
    Result := Dias * Valor
end;

function  VerificaNivel(const Nivel: Integer; Operacao: TOperation): Boolean;
begin
  Result := True;
  if Nivel < 15 then
    case Operacao of
      ALT : if Nivel < 10 then Result := False;
      EXC : if Nivel < 15 then Result := False;
      INS : if Nivel < 05 then Result := False;
    end;
end;

function  VerificaDiaUtil(Data: TDateTime): TDateTime;
begin
  while DayOfWeek(Data) in [1, 7] do
    Data := AdicionaDia(Data, 1);
  Result := Data;
end;

function  TiraPonto(Numero: Double): Double;
var
  NumStr: string;
begin
  NumStr := FloatToStrF(Numero, ffNumber, 7, 2);
  while Pos(ThousandSeparator, NumStr) > 0 do
     Delete(NumStr, Pos(ThousandSeparator, NumStr), 1);
  NumStr := DeletaCurrency(NumStr);
  Result := StrToFloat(NumStr);
end;

function  DeletaCurrency(NumStr: string): string;
begin
  if Pos(CurrencyString, NumStr) > 0 then
    Delete(NumStr, Pos(CurrencyString, NumStr), Length(CurrencyString));
  Result := NumStr;
end;

function  PontoDecimal(Valor: string): Double;
var
  PosDecimal: Integer;
begin
  PosDecimal := Pos(DecimalSeparator, Valor);
  if DecimalSeparator = ',' then
    if PosDecimal = 0 then
    begin
      Delete(Valor, Pos('.', Valor), 1);
      Insert(',', Valor, PosDecimal);
    end
  else
    if PosDecimal = 0 then
    begin
      Delete(Valor, Pos(',', Valor), 1);
      Insert('.', Valor, PosDecimal);
    end;
  try
    Result := StrToFloat(Valor);
  except
    Result := 0;
  end;
end;

function  DeletaPonto(Valor: string): string;
begin
  while Pos(ThousandSeparator, Valor) > 0 do
    Delete(Valor, Pos(ThousandSeparator, Valor), 1);
  if Pos(CurrencyString, Valor) > 0 then
    Delete(Valor, Pos(CurrencyString, Valor), Length(CurrencyString));
  Result := Valor;
end;

function  GetWindowsUser: AnsiString;
var
  nTam: Cardinal;  // Outras versıes do delphi deve-se usar Integer
begin
  nTam := 256;
  SetLength(Result, nTam);
  GetUserName(PAnsiChar(Result), nTam);
  SetLength(Result, nTam);
  AnsiUpperCase(Result);
end;

function  SetPercent(const APercent, ABaseValue: Double;
  ASign: Char = '+'): Double;
begin
  Result := 0;
  if ASign = '+' then
    Result := ABaseValue + (ABaseValue * APercent / 100);
  if ASign = '-' then
    Result := ABaseValue - (ABaseValue * APercent / 100);
end;

function  GetPercent(const ASubTot, ATotal: Double;
  AForeverPositive: Boolean = False;
  ATypeSubTotal: TSubTotalType = stSubTotal): Double;
begin
  if (ATotal = 0) then
    raise Exception.Create('Error: CalcPercent: Total value can not be 0');
  if (ATypeSubTotal = stSubTotal) then
    Result := (1 - (ASubTot / ATotal)) * 100
  else
    Result := ASubTot / ATotal * 100;
  if (AForeverPositive) and (Result < 0) then
    Result := Result * (-1);
end;

function  PercentToIndex(const APercent: Double): Double;
begin
  Result := 1 - (APercent / 100);
end;

function  CalculaFatorial(Refer: Double; Fator: Integer): Double;
var
  Decimal: Double;
begin
  Decimal := Refer - Trunc(Refer);
  if Decimal <> 0 then
    Decimal := (Decimal * 100) / Fator;
  Result := Trunc(Refer) + Decimal;
end;

function  CalculaJuros(const Valor: Double; const DataIni, DataFin: TDateTime;
  Taxa: Double): Double;
var
  Dias: Double;
  Meses: Integer;
  Dia, Mes, Ano: Word;
  Juros: Double;
begin
   Juros := 0;
   Meses := 0;
   DecodeDate(DataIni, Ano, Mes, Dia);
   if DataFin > DataIni then
     Dias := DataFin - DataIni
   else
     Dias := 0;
   while Dias > DiaDoMes[Mes] do
   begin
     Dias := Dias - DiaDoMes[Mes];
     Inc(Meses);
   end;
   while Meses > 0 do
   begin
     Juros := Juros + ((Valor * Taxa) /100);
     Dec(Meses);
   end;
   DecodeDate(DataFin, Ano, Mes, Dia);
   if Dias > 0 then
   begin
     Taxa := Taxa / DiaDoMes[Mes];
     Taxa := Taxa * Dias;
     Juros := Juros + ((Valor * Taxa) / 100);
   end;
   Result := Valor + Juros;
end;

function  CalculaLista(const Preco, Taxa: Double; const Lista: TStringList;
  Flag: string): Double;
var
  Media, Divisor, i: Integer;
  Juros: Double;
begin
  Result := 0;
  Divisor := 0;
  for i := 0 to Lista.Count -1 do
    if Lista[i] <> '' then
      Inc(Divisor);
  if Divisor > 0 then
  begin
    if (SomaDias(Lista) mod Divisor) > 0 then
      Media := (SomaDias(Lista) div Divisor) + 1
    else
      Media := SomaDias(Lista) div Divisor;
    if Flag = 'S' then
    begin
      Juros := Taxa / 30;
      Juros := Media * Juros;
      Result := SetPercent(Juros, Preco);
    end
    else
      Result := Preco;
  end;
end;

function  SomaDias(const Lista: TStringList): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Lista.Count - 1 do
    if Trim(Lista[i]) <> '' then
      Result := Result + StrToInt(Trim(Lista[i]));
end;

procedure Liberar(Sender: TObject; Status: Boolean);
begin
  if Sender <> nil then
  begin
    if Sender.ClassType = TMenuItem then
      TMenuItem(Sender).Enabled := Status;
    if Sender.ClassType = TSpeedButton then
      TSpeedButton(Sender).Enabled := Status;
    if Sender.ClassType = TToolButton then
      TToolButton(Sender).Enabled := Status;
    if Sender.ClassType = TToolButton then
      TToolButton(Sender).Enabled := Status;
  end;
end;

procedure MudaInsEd(Status: Boolean; Form: TComponent);
begin
  Liberar(TToolButton(Form.FindComponent('Sair')), Status);
  Liberar(TToolButton(Form.FindComponent('Imprime')), Status);
  Liberar(TToolButton(Form.FindComponent('Ferramentas')), Status);
  Liberar(TToolButton(Form.FindComponent('Movimento')), Status);
  Liberar(TMenuItem(Form.FindComponent('mLocalizar')), Status);
  Liberar(TMenuItem(Form.FindComponent('mImprime')), Status);
  Liberar(TMenuItem(Form.FindComponent('mSair')), Status);
  Liberar(TMenuItem(Form.FindComponent('mConsulta')), Status);
  Liberar(TMenuItem(Form.FindComponent('mFerramentas')), Status);
  Liberar(TMenuItem(Form.FindComponent('mMovimento')), Status);
  Liberar(TMenuItem(Form.FindComponent('mNavegacao')), Status);
  Liberar(TMenuItem(Form.FindComponent('mDelete')), Status);
  Liberar(TMenuItem(Form.FindComponent('mEdit')), Status);
  Liberar(TMenuItem(Form.FindComponent('mInsert')), Status);
  Liberar(TMenuItem(Form.FindComponent('mCancel')), not Status);
  Liberar(TMenuItem(Form.FindComponent('mClose')), Status);
  Liberar(TMenuItem(Form.FindComponent('mPost')), not Status);
  Liberar(TSpeedButton(Form.FindComponent('sbCod')), Status);
  Liberar(TSpeedButton(Form.FindComponent('sbDsc')), Status);
  Liberar(TToolButton(Form.FindComponent('bDelete')), Status);
  Liberar(TToolButton(Form.FindComponent('bDelete')), Status);
  Liberar(TToolButton(Form.FindComponent('bEdit')), Status);
  Liberar(TToolButton(Form.FindComponent('bInsert')), Status);
  Liberar(TToolButton(Form.FindComponent('bCancel')), not Status);
  Liberar(TToolButton(Form.FindComponent('bClose')), Status);
  Liberar(TToolButton(Form.FindComponent('bPost')), not Status);
  Liberar(TToolButton(Form.FindComponent('bSearch')), Status);
end;

procedure DesabilitaOperacoes(Status: Boolean; Form: TComponent);
begin
  Liberar(TToolButton(Form.FindComponent('Imprime')), Status);
  Liberar(TToolButton(Form.FindComponent('Ferramentas')), Status);
  Liberar(TToolButton(Form.FindComponent('Movimento')), Status);
  Liberar(TToolButton(Form.FindComponent('Consulta')), Status);
  Liberar(TMenuItem(Form.FindComponent('mFerramentas')), Status);
  Liberar(TMenuItem(Form.FindComponent('mMovimento')), Status);
  Liberar(TMenuItem(Form.FindComponent('mNavegacao')), Status);
  Liberar(TMenuItem(Form.FindComponent('mImprime')), Status);
  Liberar(TMenuItem(Form.FindComponent('mConsulta')), Status);
  Liberar(TMenuItem(Form.FindComponent('mDelete')), Status);
  Liberar(TMenuItem(Form.FindComponent('mCancel')), Status);
  Liberar(TMenuItem(Form.FindComponent('mClose')), Status);
  Liberar(TMenuItem(Form.FindComponent('mPost')), Status);
  Liberar(TToolButton(Form.FindComponent('bDelete')), Status);
  Liberar(TToolButton(Form.FindComponent('bCancel')), Status);
  Liberar(TToolButton(Form.FindComponent('bClose')), Status);
  Liberar(TToolButton(Form.FindComponent('bPost')), Status);
end;

function  CalculaDigito(const Banco: string; const BcoCob: Integer): String;
var
  Soma: Integer;
begin
  case BcoCob of
      1:
      begin
        Soma := CalculaSoma(Banco,9);
        if Soma = 10 then
          Result := 'X'
        else
          if Soma = 11 then
            Result := '0'
          else
            Result := IntToStr(Soma);
      end;
    237:
    begin
      Soma := CalculaSoma(Banco,7);
      if Soma = 10 then
        Result := 'P'
      else
        if Soma = 11 then
          Result := '0'
        else
          Result := IntToStr(Soma);
    end;
    399:
    begin
      Soma := CalculaSoma(Banco,7);
      if Soma = 10 then
        Result := '0'
      else
        if Soma = 11 then
          Result := '1'
        else
          Result := IntToStr(Soma);
    end;
  end;
end;

function  CalculaSoma(const StrBco: String; const Vlri: Integer): Integer;
var
  i, Aux, Rst: integer;
begin
  Rst := 0;
  Aux := 2;
  i:=Length(StrBco);
  while i<>0 do
  begin
    Rst := Rst + (StrToInt(Copy(StrBco,i,1)) * Aux);
    if Aux = Vlri then
      Aux := 2
    else
      Aux := Aux + 1;
    i := i-1
  end;
  Result := 11 - (Rst Mod 11);
end;

function Soundex(const s: string): string;
  procedure Subs(var s: string; x, y: string);
  var
    i, j: integer;
  begin
    while pos(x, s) <> 0 do
      if length(x) = length(y) then
      begin
        j := pos(x, s);
        for i := 1 to length(x) do
          s[j+i-1] := y[i];
      end
      else
        s := copy(s, 1, pos(x, s)-1) + y +
        copy(s, pos(x, s)+length(x), length(s)-pos(x, s)-length(x)+1);
  end;
const
  vogais = ['A', 'E', 'I', 'O', 'U'];
var
  z: string;
  p: integer;
begin
  z := AnsiUpperCase(s);
  for p := 1 to length(z) do
    if (z[p] = 'S')and (z[p-1] in vogais) and (
    (z[p+1] in vogais) or (z[p+1] = ' ') or (z[p+1] = '')) then
      z[p] := 'Z';
  subs(z, 'CA', 'KA');
  subs(z, 'QUE', 'KE');
  subs(z, 'QUI', 'KI');
  subs(z, 'CO', 'KO');
  subs(z, 'CU', 'KU');
  subs(z, 'CE', 'SE');
  subs(z, 'CI', 'SI');
  subs(z, 'CK', 'K');
  subs(z, 'LL', 'L');
  subs(z, 'MM', 'M');
  subs(z, 'NN', 'N');
  subs(z, 'CC', 'C');
  subs(z, 'PH', 'F');
  subs(z, 'GE', 'JE');
  subs(z, 'GI', 'JI');
  subs(z, 'SS', 'S');
  subs(z, 'CH', 'SCH');
  subs(z, 'SH', 'SCH');
  subs(z, '«', 'S');
  subs(z, 'LH', 'LI');
  subs(z, 'NH', '@');
  subs(z, 'CH', 'X');
  subs(z, 'M ', 'N ');
  subs(z, 'L ', 'U ');
  subs(z, 'W', 'V');
  subs(z, 'Y', 'I');
  subs(z, 'HA', 'A');
  subs(z, 'HE', 'E');
  subs(z, 'HI', 'I');
  subs(z, 'HO', 'O');
  subs(z, 'HU', 'U');
  subs(z, '@', 'NH');
  if length(z) > 0 then
  begin
    if z[length(z)] = 'S' then z[length(z)] := 'Z';
    if z[length(z)] = 'M' then z[length(z)] := 'N';
    if z[length(z)] = 'L' then z[length(z)] := 'U';
  end;
  result := z;
end;

function  NomeEstacao: AnsiString;
var
  nTam: Cardinal;
begin
  nTam := 256;
  SetLength(Result, nTam);
  GetComputerName(PAnsiChar(Result), nTam);
  SetLength(Result, nTam);
end;

function  VerificaCondicao(Condicao: PBoolean; const Campo: string): string;
begin
  if not Condicao^ then
  begin
    Condicao^ := True;
    Result := 'where ';
  end
  else
    Result := 'and ';
  Result := Result + Campo;
end;

function PegaMaquina: string;
var
  Reg : TRegistry;
begin
  Reg := TRegistry.create;
  Result := '(N/A)';
  with Reg do
  begin
    try
      RootKey := HKEY_LOCAL_MACHINE;
      if OpenKey('System\CurrentControlSet\Services\VxD\VNETSUP', false) then
        Result := UpperCase(ReadString('ComputerName'));
    finally
      CloseKey;
      free;
    end;
  end;
end;

function  CriaMascara(const Valor: Smallint; const Mascara: string): string;
var
  i: Integer;
begin
  Result := Mascara;
  if Valor > 0 then
  begin
    if Length(Mascara) > 0 then
      Result := Mascara + '\.';
    for i := 1 to Valor do
      Result := Result + '9';
  end;
end;

function  VerificaMatriz(Bits: array of Byte): Boolean;
var
  Numero, i, b, a: Integer;
begin
  // A funÁ„o Ldexp est· na unit Math do Delphi È sÛ incluir no uses
  Numero := 0;
  for i := 0 to 9 do
  begin
    a := (High(Bits) + 1) - i; // calcula o exponecial do primeiro bit
    b := Trunc(Ldexp(1 , a)); // calcula o valor do expoente do primeiro bit
    Numero := Numero + (Bits[i] * b); // multiplica o valor do bit (0 ou 1) por b
  end;
  // verifico os resultados decimais para obter a comunicaÁ„o da serial
  case Numero of
    2046: Result := True;
    2044: Result := True;
    2040: Result := True;
    2032: Result := True;
    2016: Result := True;
    1984: Result := True;
    1920: Result := True;
    1792: Result := True;
    1536: Result := True;
    1024: Result := True;
  else
    Result := False;
  end;
end;

function  TiraDecimalStr(Numero: Double): string;
var
  NumStr: string;
begin
  NumStr := FloatToStrF(Numero, ffCurrency, 7, 2);
  while Pos(DecimalSeparator, NumStr) > 0 do
     Delete(NumStr, Pos(DecimalSeparator, NumStr), 1);
  NumStr := DeletaCurrency(NumStr);
  Result := NumStr;
end;

function  PegaPosicao(var Ini, Fim, TipoDado: SmallInt;
  const Campo, Tamanho: string): Boolean;
var
  Pos_: SmallInt;
begin
  Result := False;
  Pos_ := Pos('-', Tamanho);
  if not Pos_ > 0 then exit;
  try
    Ini := StrToInt(Copy(Tamanho, 1, (Pos_ - 1)));
    Fim := StrToInt(Copy(Tamanho, (Pos_ + 1), (Pos(';', Tamanho) - (Pos_ + 1))));
    Pos_ := Pos(';', Tamanho);
    if not Pos_ > 0 then exit;
    TipoDado := StrToInt(Copy(Tamanho, (Pos_ + 1), (Length(Tamanho) - Pos_)));
  except
    exit;
  end;
  Fim := Fim - (Ini - 1);
  Result := True;
end;

function Mascara_Inscricao(Estado: string): string;
const
  Estados    : array [0..27] of string[02] =
   ('SP', 'MG', 'RJ', 'RS', 'SC', 'PR', 'ES', 'DF', 'MT', 'MS', 'GO', 'TO', 'BA',
    'SE', 'AL', 'PB', 'PE', 'MA', 'RN', 'CE', 'PI', 'PA', 'AM', 'AP', 'FN', 'AC',
    'RR', 'RO');
  Mascaras   : array [0..27] of string[20] =
   ('###.###.###.###', '###.###.###-####', '##.###.##-#', '###/#######',
    '###.###.###', '########-##', '###########', '###########-##', '##########-#',
    '##.###.###-#', '##.###.###-#', '###########', '>######-##aa', '#########-#',
    '###########', '########-#', '##.#.###.#######-#', '###########',
    '##.###.###-#', '########-#', '###########', '##-######-#', '##.###.###-#',
    '###########', '###########', '##.###.###/###-##', '########-#', '###.#####-#');
var
  i: Integer;
begin
  Result := '';
  for i := 0 to 27 do
    if Estados[i] = Estado then
      Result := Mascaras[i];
  if Result <> '' then
    Result := Result + ';0; ';
end;

function CalculaEAN13(CodigoC: string):string;
var
   Soma1     : integer;
   Soma2     : integer;
   Soma      : integer;
   Digi      : integer;
   i         : integer;
begin
  Result     := 'Erro';
  for i      := 1 to length(CodigoC) do
    if not (CodigoC[I] in ['0'..'9']) then
      exit;
   if Length(CodigoC) < 12 then
     CodigoC := InsereZer(CodigoC, 12);
  Soma1      := StrToInt(CodigoC[ 2]) +
                StrToInt(CodigoC[ 4]) +
                StrToInt(CodigoC[ 6]) +
                StrToInt(CodigoC[ 8]) +
                StrToInt(CodigoC[10]) +
                StrToInt(CodigoC[12]);
  Soma2      := StrToInt(CodigoC[ 1]) +
                StrToInt(CodigoC[ 3]) +
                StrToInt(CodigoC[ 5]) +
                StrToInt(CodigoC[ 7]) +
                StrToInt(CodigoC[ 9]) +
                StrToInt(CodigoC[11]);
  Soma1      := Soma1 * 3;
  Soma       := Soma1 + Soma2;
  Digi       := Trunc(10 * (Int(Soma / 10.0) + 1) - Soma);
  if Digi     = 10 then Digi := 0;
  Result     := CodigoC + IntToStr(Digi);
end;

function CalculaEAN8(CodigoC: string):string;
var
  Soma1     : integer;
  Soma2     : integer;
  Soma      : integer;
  Digi      : integer;
  i         : integer;
begin
  Result    := 'Erro';
  for i     := 1 to length(CodigoC) do
    if not (CodigoC[I] in ['0'..'9']) then
      exit;
  if Length(CodigoC) < 7 then
    CodigoC := InsereZer(CodigoC, 7);
  Soma1     := StrToInt(CodigoC[1])+
               StrToInt(CodigoC[3])+
               StrToInt(CodigoC[5])+
               StrToInt(CodigoC[7]);
  Soma2     := StrToInt(CodigoC[2])+
               StrToInt(CodigoC[4])+
               StrToInt(CodigoC[6]);
  Soma1     := Soma1 * 3;
  Soma      := Soma1 + Soma2;
  Digi      := Trunc(10 * (Int(Soma / 10.0) + 1) - Soma);
  if Digi    = 10 then Digi := 0;
  Result    := CodigoC + IntToStr(Digi);
end;

function CalculaUPC(CodigoC: string):string;
var
  Soma1     : integer;
  Soma2     : integer;
  Soma      : integer;
  Digi      : integer;
  i         : integer;
begin
  Result    := 'Erro';
  for i     := 1 to length(CodigoC) do
    if not (CodigoC[I] in ['0'..'9']) then
      exit;
  if Length(CodigoC) < 11 then
    CodigoC := InsereZer(CodigoC, 11);
  { Calcula digito Verificador }
  Soma1     := StrToInt(CodigoC[ 1])+
               StrToInt(CodigoC[ 3])+
               StrToInt(CodigoC[ 5])+
               StrToInt(CodigoC[ 7])+
               StrToInt(CodigoC[ 9])+
               StrToInt(CodigoC[11]);
  Soma2     := StrToInt(CodigoC[ 2])+
               StrToInt(CodigoC[ 4])+
               StrToInt(CodigoC[ 6])+
               StrToInt(CodigoC[ 8])+
               StrToInt(CodigoC[10]);
  Soma1     := Soma1 * 3;
  Soma      := Soma1 + Soma2;
  Digi      := Trunc(10 * (Int(Soma / 10.0) + 1) - Soma);
  if Digi    = 10 then Digi := 0;
  Result    := CodigoC + IntToStr(Digi);
end;

function  FormataListStr(List: array of string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to High(List) do
    Result := Result + List[i] + #13;
end;

function  ClearChar(Str, Chr: string): string;
begin
  while Pos(Chr, Str) > 0 do
   Delete(Str, Pos(Chr, Str), Length(Chr));
  Result := Str;
end;

function  GeneratePassword(Len: Integer): string;
const
  WordsStr: array[1..52] of string =
    ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
     'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D',
     'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
     'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
begin
  Result := '';
  while Length(Result) < Len do
  begin
    if Odd(RandomRange(0, Len)) then
      Result := Result + RandomFrom(WordsStr)
    else
      Result := Result + IntToStr(RandomRange(0, 100));
  end;
  Result := Copy(Result, 1, Len);
end;

function  GetBooleanData(AValue: Integer): string;
const
  Values: array [-1..1] of string = ('Null', 'N„o', 'Sim');
begin
  if (AValue > High(Values)) or
     (AValue < Low(Values)) then
    AValue := -1;
  Result := Values[AValue];
end;

procedure ReleaseCombos(ACombo: TComboBox; aTypeObject: TTypeObject);
var
  i  : Integer;
  Obj: TObject;
  P  : PAnsiChar;
begin
  if ACombo.Items.Count = 0 then exit;
  for i := 0 to ACombo.Items.Count - 1 do
  begin
    if (aTypeObject > toNone) and (ACombo.Items.Objects[i] <> nil) then
    begin
      if (aTypeObject = toObject) then
      begin
        Obj := ACombo.Items.Objects[i];
        Obj.Free;
        Obj := nil;
        if (Obj = nil) then ACombo.Items.Objects[i] := nil;
      end;
      if (aTypeObject = toString) then
      begin
        P := PAnsiChar(ACombo.Items.Objects[i]);
        FreeMem(P, StrCharLength(P));
      end;
    end;
    ACombo.Items.Objects[i] := nil;
  end;
  ACombo.Clear;
end;

function RemoveAcentos(Str: string): string;
{Remove caracteres acentuados de uma string}
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
var
  x : Integer;
begin
  for x := 1 to Length(Str) do
    if Pos(Str[x], ComAcento) <> 0 Then
      Str[x] := SemAcento[Pos(Str[x], ComAcento)];
  Result := Str;
end;

function  ReadRegistry(AKey, AValue: string): string;
var
  Registry: TRegistry;
const
  KEY_NAME = '\SOFTWARE\OSProcessaERP\';
begin
  Result := '';
  Registry := TRegistry.Create(KEY_READ);
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    // False because we do not want to create it if it doesn't exist
    if Registry.OpenKey(KEY_NAME + AKey, False) then
    begin
      Result := Registry.ReadString(AValue);
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

function  WriteRegistry(AKey, AName, AValue: string): Boolean;
var
  Registry: TRegistry;
const
  KEY_NAME = '\SOFTWARE\OSProcessaERP\';
begin
  Result := True;
  Registry := TRegistry.Create(KEY_WRITE);
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    try
      if Registry.OpenKey(KEY_NAME + AKey, True) then
        Registry.WriteString(AName, AValue);
    except on E:Exception do
      begin
        Result := False;
        Registry.CloseKey;
        raise Exception.Create(E.Message);
      end;
    end;
    Registry.CloseKey;
  finally
    Registry.Free;
  end;
end;

function  GetUpdateSQL(const AFields, AWhereFields: TStrings;
            const ATableName: string): TStrings;
const
  S_UPDATE   = 'update %s set ';
  S_OPERATOR = '%s = %s ';
  S_SPC      = '       ';
var
  i: Integer;
  S, S1: string;
begin
  Result := TStringList.Create;
  if (AFields = nil) or (AFields.Count = 0) or (ATableName = '') then exit;
  Result.Add(Format(S_UPDATE, [ATableName]));
  for i := 0 to AFields.Count - 1 do
  begin
    if (AFields[i] <> '') then
    begin
      S1 := ':' + LowerCase(StringReplace(AFields.Strings[i], '_', '', [rfReplaceAll]));
      S  := AFields.Strings[i];
      S  := Format(S_OPERATOR, [S, S1]);
      if i < AFields.Count - 1 then
        S := S + ', ';
      Result.Add(S_SPC + S);
    end;
  end;
  S := Result.Strings[Result.Count - 1];
  if (S <> '') and (S[(Length(S) - 1)] = ',') then
  begin
    S[(Length(S) - 1)] := ' ';
    Result.Strings[Result.Count - 1] := S;
  end;
  if (AWhereFields <> nil) and (AWhereFields.Count > 0) then
    Result.AddStrings(GetWhereSQL(Result, AWhereFields));
end;

function  GetInsertSQL(const AFields: TStrings; const ATableName: string): TStrings;
const
  S_INSERT = 'insert into %s ';
  S_VALUES = 'values ';
var
  aFieldsLine: string;
  aValuesLine: string;
  aValues    : TStrings;
  i: Integer;
begin
  Result := TStringList.Create;
  if (AFields = nil) or (AFields.Count = 0) or (ATableName = '') then exit;
  Result.Add(Format(S_INSERT, [ATableName]));
  aFieldsLine := '  (';
  aValuesLine := '  (';
  aValues := TStringList.Create;
  try
    for i := 0 to AFields.Count - 1 do
    begin
      if (AFields.Strings[i] <> '') then
      begin
        aFieldsLine := aFieldsLine + AFields.Strings[i];
        aValuesLine := aValuesLine + ':' +
          LowerCase(StringReplace(AFields.Strings[i], '_', '', [rfReplaceAll]));
        if i < AFields.Count - 1 then
        begin
          aFieldsLine := aFieldsLine + ', ';
          aValuesLine := aValuesLine + ', ';
        end;
        if (Length(aFieldsLine) > 70) then
        begin
          Result.Add(aFieldsLine);
          aValues.Add(aValuesLine);
          aFieldsLine := '';
          aValuesLine := '';
        end;
      end;
    end;
    if (Trim(aFieldsLine) <> '') and (Trim(aValuesLine) <> '') then
    begin
      aFieldsLine := aFieldsLine + ')';
      aValuesLine := aValuesLine + ')';
      Result.Add(aFieldsLine);
      aValues.Add(aValuesLine);
    end;
    i := Result.Count -1;
    aFieldsLine := Result.Strings[i];
    if Pos(')', aFieldsLine) = 0 then
      aFieldsLine := aFieldsLine + ')';
    if Pos(', )', aFieldsLine) > 0 then
      aFieldsLine := StringReplace(aFieldsLine, ', )', ')', [rfReplaceAll]);
    Result.Strings[i] := aFieldsLine;
    i := aValues.Count -1;
    aValuesLine := aValues.Strings[i];
    if Pos(')', aValuesLine) = 0 then
      aValuesLine := aValuesLine + ')';
    if Pos(', )', aValuesLine) > 0 then
      aValuesLine := StringReplace(aValuesLine, ', )', ')', [rfReplaceAll]);
    aValues.Strings[i] := aValuesLine;
    Result.Add(S_VALUES);
    for i := 0 to aValues.Count - 1 do
      Result.Add(aValues.Strings[i]);
    if Pos(', )', Result.Text) > 0 then
      Result.Text := StringReplace(Result.Text, ', )', ' )', [rfReplaceAll]);
  finally
    aValues.Free;
  end;
end;

function  GetWhereSQL(const AFields: TStrings; const AWhereFields: TStrings): TStrings;
const
  S_WHERE = ' where ';
  S_AND   = '   and ';
var
  i: Integer;
  aField : string;
  aOldFld: Boolean;
begin
  Result := TStringList.Create;
  if (AWhereFields = nil) or (AWhereFields.Count = 0) then exit;
  for i := 0 to AWhereFields.Count - 1 do
  begin
    if AWhereFields.Strings[i] <> '' then
    begin
      aOldFld := AnsiContainsStr(AFields.Text, AnsiUpperCase(AWhereFields.Strings[i]));
      aField := AWhereFields.Strings[i];
      if i = 0 then
        if (aOldFld) then
          Result.Add(S_WHERE + aField + ' = :Old' +
            LowerCase(StringReplace(AWhereFields.Strings[i], '_', '', [rfReplaceAll])))
        else
          Result.Add(S_WHERE + aField + ' = :' +
            LowerCase(StringReplace(AWhereFields.Strings[i], '_', '', [rfReplaceAll])))
      else
        if (aOldFld) then
          Result.Add(S_AND + aField + ' = :Old' +
            LowerCase(StringReplace(AWhereFields.Strings[i], '_', '', [rfReplaceAll])))
        else
          Result.Add(S_AND + aField + ' = :' +
            LowerCase(StringReplace(AWhereFields.Strings[i], '_', '', [rfReplaceAll])));
    end;
  end;
end;

procedure ChangeControlColors(AForm: TForm; const AColor, AFontColor: TColor);
var
  i: Integer;
  function  ComponentInList(AControl: TControl): Boolean;
  const
    ListControls: array [0..9] of string = ('TEdit', 'TComboBox', 'TPrcComboBox',
      'TCurrencyEdit', 'TRxCalcEdit', 'TDateEdit', 'TMaskEdit', 'TRxLookupEdit',
      'TJvDateEdit', 'TJvCalcEdit');
  var
    j: Integer;
  begin
    Result := False;
    for j := 0 to High(ListControls) do
      if CompareText(AControl.ClassName, ListControls[j]) = 0 then
      begin
        Result := True;
        break;
      end;
  end;
begin
  with AForm do
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i].InheritsFrom(TControl) and
         ComponentInList(TControl(Components[i])) then
      begin
         SetColor(Components[i], 'Color', AColor);
         SetColor(Components[i], 'Font', AFontColor);
      end;
    end;
  end;
end;

function  GetListValue(var AList: string): Integer;
var
  i: Integer;
begin
  i := Pos('+', AList);
  if i = 0 then
    i := Length(AList)
  else
    Dec(i);
  Result := StrToIntDef(Copy(AList, 1, i), 0);
  if (Length(AList) <> i) and (AList <> '') then
    Inc(i)
  else
    AList := '';
  if AList <> '' then
    Delete(AList, 1, i);
end;

function  CheckPeriodList(const AList: string; var AQtdParc: Integer): string;
var
  j, aPeriod, aPeriodAnt: Integer;
  aListAux     : string;
begin
  Result := '';
  if (AList = '') then
  begin
    Result := 'Lista definida pelo usu·rio inv·lida';
    exit;
  end;
  aListAux := AList;
  aPeriodAnt := 0;
  j := 0;
  while (aListAux <> '') do
  begin
    aPeriod := GetListValue(aListAux);
    if (aPeriod = 0) and (aPeriod < aPeriodAnt) then
    begin
      Result := Format('Lista de prazos inv·lida. VocÍ deve informar os ' +
        'prazos com intervalos crescentes (Lista Completa: %s ==> Calculando: ' +
        '%s). Ex: 10+25+35', [AList, aListAux]);
      break;
    end;
    Inc(j);
    aPeriodAnt := aPeriod;
  end;
  AQtdParc := j;
end;

function Capitalize(const ALine: string): string;
{ Func to capitalize the first char of every word.        }
{ Code adapted from Sanford Aranoff <SAranoff@nusinc.com> }
const
  period = '.';
  comma = ',';
  slash = '/';
  bslash = '\';
  blank = ' ';
  set_let_next = [period,'-'];
  set_let_prev = [period,slash,bslash,'-',comma,'"'];
var
  let: char;
  i, j: integer;
  test: boolean;

  function LineIsNull(const Source: string): boolean;
  {Determine if a string contains only char. 0-32.}
  asm
    Push ESI //save the important stuff
    Mov @Result,true
    Or EAX,EAX
    Jz @Done //abort if nil address
    Mov ESI,EAX //put address into read register
    Mov ECX,[EAX-4] //put length into count register
    Jecxz @NG //bail out if zero length
    Cld //make sure we go forward
  @Start:
    Lodsb //get a byte
    Cmp AL,32 //greater than space?
    Ja @NG //yes, then abort
    Dec ECX //do it again
    Jnz @Start
    Mov EAX,-1 //if we make it here, it's a null string
    Jmp @Done
  @NG:
    xor EAX,EAX
    Mov @Result,false
  @Done:
    Pop ESI //restore the important stuff
  end;

begin
  if LineIsNull(ALine) then
    begin
      Result:= '';
      Exit;
    end;

  Result := Trim(ALine);
  i := Length(Result);
  if i = 1 then
    begin
      Result[1] := UpCase(Result[1]);
      Exit;
    end;

  Result := LowerCase(Result);
  Result[1] := UpCase(Result[1]);
  j := 1;
  repeat
    Let := Result[j];
    inc(j);
    Test := (Let <= blank) or (Let in set_let_prev);
    if not test then
      begin
        if j > 2 then
          Let := Result[j-2]
        else
          Let := Blank;
        Test := (Let <= blank) or (Let in set_let_prev);
        if test then
          begin
            if j < i then
              begin
                if j <= 2 then
                  Test := Result[j+1] in [Period ,'-', Blank]
                else
                  Test := Result[j+1] in set_let_next;
              end
            else
              Test := False;
          end;
      end;
    if Test then
      Result[j] := UpCase(Result[j]);
  until
    j = i;
end;

end.


