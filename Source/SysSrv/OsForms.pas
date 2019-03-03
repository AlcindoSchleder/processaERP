unit OsForms;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 06/03/2003 - DD/MM/YYYY                                      *}
{* Modified: 06/03/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TSysSrv, ProcType, TSysMan, ProcUtils, StdCtrls;

type
  TChangeCompanyEvent = procedure (Sender: TObject; var Allowed, Reload: Boolean) of object;

  TCompareObject  = function (const AValue: Variant): Integer of object;

  TOSForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChangeGlobal(Sender: TObject);
  private
    FActiveOS      : TServiceOrder;
    FActiveCompany : TCompany;
    FAllowExit     : Boolean;
    FCountSearch   : Integer;
    FdbMode        : TdbMode;
    FPkServiceOrder: Integer;
    FChangeCompany : TChangeCompanyEvent;
    FOnChangeMode  : TNotifyEvent;
    FOnChangePKOS  : TNotifyEvent;
    FOnChangeOS    : TNotifyEvent;
    procedure SetPkServiceOrder(AValue: Integer);
    procedure SetActiveCompany(AValue: TCompany);
    procedure SetDbMode(AValue: TDbMode);
  public
    function  SetActiveObjectIndex(AControl: TControl; const AFldName: string;
                const APk: Integer): Integer; overload;
    function  SetActiveObjectIndex(AList: TComboBox;
                const AFldValue: Variant): TPersistent; overload;
    procedure SetActiveOS(AValue: TServiceOrder);
    property  ActiveCompany : TCompany      read FActiveCompany  write SetActiveCompany;
    property  ActiveOS      : TServiceOrder read FActiveOS       write SetActiveOS;
    property  AllowExit     : Boolean       read FAllowExit      write FAllowExit      default True;
    property  CountSearch   : Integer       read FCountSearch    write FCountSearch    default 0;
    property  dbMode        : TDbMode       read FDbMode         write SetDbMode;
    property  PkServiceOrder: Integer       read FPkServiceOrder write SetPkServiceOrder;
    // Events
    property  OnChangeCompany: TChangeCompanyEvent read FChangeCompany write FChangeCompany;
    property  OnChangeMode   : TNotifyEvent        read FOnChangeMode  write FOnChangeMode;
    property  OnChangePKOS   : TNotifyEvent        read FOnChangePKOS  write FOnChangePKOS;
    property  OnChangeOS     : TNotifyEvent        read FOnChangeOS    write FOnChangeOS;
  end;

implementation

uses Dado, TypInfo, mSysSrv;

{$R *.dfm}

procedure TOSForm.FormCreate(Sender: TObject);
begin
  FActiveCompany           := TCompany.Create;
  FActiveCompany.PkCompany := Dados.PkCompany;
  FActiveCompany.DscEmp    := Dados.NameCompany;
  FActiveOS                := TServiceOrder.Create(Self);
  FActiveOS.FkEmpresas     := FActiveCompany;
  FAllowExit               := True;
  FChangeCompany           := nil;
  FCountSearch             := 0;
  FPkServiceOrder          := 0;
  FdbMode                  := dbmBrowse;
end;

procedure TOSForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FActiveOS) then
    FActiveOS.Free;
  if Assigned(FActiveCompany) then
    FActiveCompany.Free;
  FActiveOS      := nil;
  FOnChangeMode  := nil;
  FChangeCompany := nil;
  FOnChangePKOS  := nil;
  FActiveCompany := nil;
  Tag            := 0;
end;

procedure TOSForm.ChangeGlobal(Sender: TObject);
begin
  if (DBMode in LOADING_MODE) then exit;
  begin
    if (dbMode = dbmBrowse) then
      if (ActiveOS.PkOS > 0) then
        dbMode := dbmEdit
      else
        dbMode := dbmInsert;
  end;
end;

procedure TOSForm.SetActiveCompany(AValue: TCompany);
var
  aAllowed: Boolean;
  aReload: Boolean;
begin
  if not Focused then exit;
  aAllowed := (dbMode in LOADING_MODE);
  aReload  := False;
  if Assigned(FChangeCompany) then
    FChangeCompany(Self, aAllowed, aReload);
  if not aAllowed then exit;
  if aReload then
    SetPkServiceOrder(ActiveOS.PkOS);
  if (AValue = nil) then
    FActiveCompany.Clear
  else
    FActiveCompany.Assign(AValue);
end;

procedure TOSForm.SetActiveOS(AValue: TServiceOrder);
begin
  if (AValue = nil) then
    FActiveOS.Clear
  else
    FActiveOS.Assign(AValue);
  FPkServiceOrder := FActiveOS.PkOS;
  if Assigned(OnChangeOS) then
    OnChangeOS(Self);
end;

procedure TOSForm.SetPkServiceOrder(AValue: Integer);
begin
  dbMode := dbmExecute;
  FPkServiceOrder       := AValue;
  dmSysSrv.GetServiceOrder(FActiveOS, ActiveCompany.PkCompany, PkServiceOrder);
  FActiveOS.FkEmpresas  := FActiveCompany;
  if Assigned(FOnChangePKOS) then
    FOnChangePKOS(Self);
  dbMode := dbmBrowse;
end;

procedure TOSForm.SetDbMode(AValue: TDbMode);
begin
  if (FDbMode = AValue) or // dbMode must be different of value or
     ((AValue <> dbmBrowse) and (FDbMode in [dbmEdit, dbmInsert])) then // if dbMode in insert or edit only change to dbmBrowse
    exit;
  begin
    FDbMode := AValue;
    if Assigned(FOnChangeMode) then
      FOnChangeMode(Self);
  end;
end;

function  TOSForm.SetActiveObjectIndex(AControl: TControl;
  const AFldName: string; const APk: Integer): Integer;
var
  aIdx : Integer;
  aList: TStrings;
begin
  Result := -1;
  if (AControl = nil) or (AFldName = '') or
     (not GetProperty(AControl, 'ItemIndex')) and
     (not GetProperty(AControl, 'Items')) then
    exit;
  AList := TStrings(GetObjectProp(AControl, 'Items'));
  for aIdx := 0 to AList.Count - 1 do
  begin
    if (AList.Objects[aIdx] <> nil) then
    begin
      Result := Integer(AList.Objects[aIdx]);
      if Result = APk then
      begin
        Result := aIdx;
        break;
      end;
    end;
  end;
  SetPropValue(AControl, 'ItemIndex', Result);
end;

function  TOSForm.SetActiveObjectIndex(AList: TComboBox;
  const AFldValue: Variant): TPersistent;
var
  Func      : TMethod;
  CompValue : TCompareObject;
  aIdx, aRet: Integer;
  aObj      : TPersistent;
begin
  aRet   := -1;
  Result := nil;
  aObj   := nil;
  if VarIsNull(AFldValue) then exit;
  try
    for aIdx := 0 to AList.Items.Count - 1 do
    begin
      if (AList.Items.Objects[aIdx] <> nil) then
      begin
        aObj := TPersistent(AList.Items.Objects[aIdx]);
        Func.Data := Pointer(aObj);
        Func.Code := aObj.MethodAddress('ComparePk'); // Get Addres of function 'ComparePk' of Object stored in the list
        if Func.Code = nil then exit;
        CompValue := TCompareObject(Func);
        aRet := CompValue(AFldValue);
        if aRet = aIdx then break;
      end;
    end;
  finally
    Result    := aObj;
    CompValue := nil; // Frees the function Pointer
    Func.Code := nil;
    Func.Data := nil;
  end;
  SetPropValue(AList, 'ItemIndex', aRet);
end;

end.

