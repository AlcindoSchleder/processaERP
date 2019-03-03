unit DlgCntView;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSchedule, VpContactButtons, VpBase, VpBaseDS, VpContactGrid,
  ExtCtrls, ComCtrls, vpData, StdCtrls, ProcUtils;

type
  TfrmContactView = class(TfrmSchedule)
    vpContactGrid : TVpContactGrid;
    cbbContacts   : TVpContactButtonBar;
    procedure vpContactGridOwnerEditContact(Sender: TObject;
      Contact: TVpContact; Resource: TVpResource; var AllowIt: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FFlagSuper: Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ASuper: Boolean); reintroduce;
    procedure SetDefaults; override;
    property NumDays;
    property DataLink;
    property FlagSuper: Boolean read FFlagSuper write FFlagSuper default False;
  end;

implementation

uses Dado, CadCntct;

{$R *.dfm}

constructor TfrmContactView.Create(AOwner: TComponent; ASuper: Boolean);
begin
  inherited Create(AOwner);
  FlagSuper := ASuper;
end;

procedure TfrmContactView.SetDefaults;
begin
  if (DataLink <> nil) then
  begin
    vpContactGrid.DataStore   := DataLink.DataStore;
    vpContactGrid.ControlLink := DataLink;
  end;
end;

procedure TfrmContactView.vpContactGridOwnerEditContact(Sender: TObject;
  Contact: TVpContact; Resource: TVpResource; var AllowIt: Boolean);
var
  Mode: TDBMode;
begin
// Show Custom Form
  if (Contact = nil) or (Contact.RecordID > 0) then
    Mode := dbmBrowse
  else
    Mode := dbmInsert;
  CdContacts := TCdContacts.Create(tsData, Mode, Contact, Resource, FFlagSuper);
  if (CdContacts <> nil) then
  begin
    CdContacts.Align       := alClient;
    CdContacts.Parent      := tsData;
    CdContacts.BorderStyle := bsNone;
    CdContacts.OnClose     := FormClose;
    pgMain.ActivePageIndex := 1;
    CdContacts.Show;
  end;
end;

procedure TfrmContactView.FormDestroy(Sender: TObject);
begin
  if Assigned(CdContacts) then
    CdContacts.Free;
  CdContacts := nil;
  inherited;
end;

procedure TfrmContactView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  pgMain.ActivePageIndex := 0;
end;

end.
