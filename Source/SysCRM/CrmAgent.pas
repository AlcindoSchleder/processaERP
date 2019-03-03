unit CrmAgent;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 15/02/2004 - DD/MM/YYYY                                      *}
{* Modified: 15/02/2004 - DD/MM/YYYY                                     *}
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
  Windows, SysUtils, Classes, Forms, VpBaseDS, VpData;

type
  TEventAction = (eaCreate, eaDestroy);
  TEventType   = (etShowAlert, etNone);

  TEventNotification = class(TThread)
  private
    FEventAction: TEventAction;
    FEventType  : TEventType;
    FEventObject: TObject;
    FSuspended  : Boolean;
    FDS         : TVpCustomDataStore;
    FEvent      : TVpEvent;
    FEventDlg   : TForm;
    procedure ShowAlert;
    procedure LoadEvent;
    procedure UnLoadEvent;
  protected
    procedure Execute; override;
  public
    constructor Create(AEvent: TVpEvent; ADataStore: TVpCustomDataStore;
                  AEventType: TEventType; ASuspended: Boolean = True); reintroduce;
    destructor  Destroy; override;
    property  EventAction: TEventAction read FEventAction write FEventAction;
    property  EventObject: TObject      read FEventObject write FEventObject;
  end;

resourcestring
  S_PHONE_MASK = '!\(\0xx99\)9000-0000;0; ';

implementation

uses CadEvent, CadTask, CadCntct, DlgMsg, DlgAlrm, MMSystem;

constructor TEventNotification.Create(AEvent: TVpEvent; ADataStore: TVpCustomDataStore;
  AEventType: TEventType; ASuspended: Boolean = True);
begin
  FEventAction := eaCreate;
  FEventType   := AEventType;
  FSuspended   := ASuspended;
  FEvent       := AEvent;
  FDS          := ADataStore;
  inherited Create(False);
end;

destructor  TEventNotification.Destroy;
begin
  FEventAction := eaDestroy;
  if not FSuspended then
    Execute;
  FEvent       := nil;
  FDS          := nil;
  inherited Destroy;
end;

procedure TEventNotification.Execute;
begin
  if (FEventAction = eaCreate) then
    case FEventType of
      etNone     : Synchronize(LoadEvent);
      etShowAlert: Synchronize(ShowAlert);
    end
  else
    Synchronize(UnloadEvent);
end;

procedure TEventNotification.ShowAlert;
begin
  if (FDS <> nil) and (FEvent <> nil) and (not FEvent.AlertDisplayed) then
  begin
    with FDS do
    begin
      if PlayEventSounds then
      begin
        if FileExists(FEvent.AlarmWavPath) then
          { if the event has a sound of its own, then play that one. }
          SndPlaySound(PChar(FEvent.AlarmWavPath), snd_Async)
        else
          if FileExists(DefaultEventSound) then
            { otherwise, if there is a default sound assigned, then play that one }
            SndPlaySound(PChar(DefaultEventSound), snd_Async)
          else
            { otherwise just ding }
            MessageBeep(0);
      end;
      FEvent.AlertDisplayed := True;
      FEventDlg := TAlarmDlg.Create(FEvent);
      FEventDlg.Show;
    end;
  end;
end;

procedure TEventNotification.LoadEvent;
begin
end;

procedure TEventNotification.UnLoadEvent;
begin
  if Assigned(FEventDlg) then
    FEventDlg.Free;
  FEventDlg := nil;
end;

end.
