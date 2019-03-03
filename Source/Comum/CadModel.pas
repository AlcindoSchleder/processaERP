unit CadModel;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 03/01/2006 - DD/MM/YYYY                                    *}
{* Modified : 22/10/2008 - DD/MM/YYYY                                    *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcUtils, VirtualTrees, ComCtrls, ToolWin, PrcSysTypes;

type
  TfrmModel = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChangeGlobal(Sender: TObject);
  private
    { Private declarations }
    FCheckRecord    : Boolean;
    FDebug          : Boolean;
    FLoading        : Boolean;
    FScrState       : TDBMode;
    FListLoaded     : Boolean;
    FPk             : LongInt;
    FOnChangePk     : TNotifyEvent;
    FOnChangeState  : TChangeStateEvent;
    FOnCheckRecord  : TOnCheckRecord;
    FOnInternalState: TChangeStateEvent;
    FOnUpdateRow    : TOnUpdateRow;
    FPkAux          : Integer;
  protected
    { Protected declarations }
    procedure SetListLoaded(const Value: Boolean); virtual;
    procedure SetScrState(const Value: TDBMode); virtual;
    procedure SetPk(const Value: LongInt);
    procedure SetPkAux(const Value: Integer);
    procedure LoadDefaults; virtual;
    procedure ClearControls; dynamic;
    procedure MoveDataToControls; dynamic;
    procedure SaveIntoDB; dynamic;
    procedure CancelRecord; dynamic;
    procedure InsertRecord; dynamic;
  public
    { Public declarations }
    property  CheckRecord    : Boolean           read FCheckRecord;
    property  Debug          : Boolean           read FDebug           write FDebug;
  published
    { published declaretions }
    property  ListLoaded     : Boolean           read FListLoaded      write SetListLoaded;
    property  Loading        : Boolean           read FLoading         write FLoading;
    property  Pk             : Integer           read FPk              write SetPk;
    property  PkAux          : Integer           read FPkAux           write SetPkAux;
    property  ScrState       : TDBMode           read FScrState        write SetScrState;
    property  OnChangePK     : TNotifyEvent      read FOnChangePk      write FOnChangePk;
    property  OnChangeState  : TChangeStateEvent read FOnChangeState   write FOnChangeState;
    property  OnCheckRecord  : TOnCheckRecord    read FOnCheckRecord   write FOnCheckRecord;
    property  OnInternalState: TChangeStateEvent read FOnInternalState write FOnInternalState;
    property  OnUpdateRow    : TOnUpdateRow      read FOnUpdateRow     write FOnUpdateRow;
  end;

implementation

{$R *.dfm}

{ TfrmModel }

uses Dado, SelEmpr, ProcType;

procedure TfrmModel.SetScrState(const Value: TDBMode);
begin
  FCheckRecord := True;
  if (FScrState <> Value) then
  begin
    if (Value = dbmCancel) then
      CancelRecord;
    if (Value <> dbmPost) then
        FScrState := Value
    else
      if ((Value = dbmCheck) or (FScrState in UPDATE_MODE)) and
         (Assigned(FOnCheckRecord)) then
        if (not FOnCheckRecord(FScrState, Value)) then exit;
    if (Value = dbmCheck) then exit;
    case Value of
      dbmInsert: InsertRecord;
      dbmDelete: SaveIntoDB;
      dbmPost  : SaveIntoDB;
      dbmCancel: MoveDataToControls;
      dbmBrowse: MoveDataToControls;
    end;
    if Assigned(FOnChangeState) then
      FOnChangeState(Self, Value);
    if Assigned(FOnInternalState) then
      FOnInternalState(Self, Value);
    FScrState := Value;
  end;
end;

procedure TfrmModel.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    ListLoaded := False;
    FScrState  := dbmBrowse;
    ClearControls;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmModel.FormDestroy(Sender: TObject);
begin
  FOnChangePk      := nil;
  FOnChangeState   := nil;
  FOnCheckRecord   := nil;
  FOnInternalState := nil;
  FOnUpdateRow     := nil;
end;

procedure TfrmModel.ChangeGlobal(Sender: TObject);
begin
  if (Loading) or (FScrState in (UPDATE_MODE + LOADING_MODE)) then exit;
  if (FScrState = dbmBrowse) and (PK = 0) then
    ScrState := dbmInsert
  else
    ScrState := dbmEdit;
end;

procedure TfrmModel.SetPk(const Value: LongInt);
begin
  if (Value <> FPk) then
  begin
    LoadDefaults;
    FScrState := dbmBrowse;
    ClearControls;
    FPk := Value;
    MoveDataToControls;
    if Assigned(FOnChangePk) then
      FOnChangePk(Self);
  end;
end;

procedure TfrmModel.SetPkAux(const Value: Integer);
begin
  FPkAux := Value;
  FPk    := Value;
end;

procedure TfrmModel.CancelRecord;
begin

end;

procedure TfrmModel.InsertRecord;
begin
  if (FPk > 0) then ClearControls;
end;

procedure TfrmModel.SetListLoaded(const Value: Boolean);
begin
  FListLoaded := Value;
end;

procedure TfrmModel.ClearControls;
begin

end;

procedure TfrmModel.LoadDefaults;
begin

end;

procedure TfrmModel.MoveDataToControls;
begin

end;

procedure TfrmModel.SaveIntoDB;
begin

end;

end.

