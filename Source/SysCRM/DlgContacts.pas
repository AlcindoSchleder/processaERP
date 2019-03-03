unit DlgContacts;

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
  Dialogs, uSchedule, ComCtrls, VirtualTrees, StdCtrls, Buttons, ExtCtrls;

type
  TfrmSelection = class(TfrmSchedule)
    pContacts: TPanel;
    iBarContatos: TImage;
    sbFilter: TSpeedButton;
    eFilter: TEdit;
    vtEventos: TVirtualStringTree;
    iBarEventos: TImage;
    vtContatos: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDefaults; override;
    property NumDays;
    property DataLink;
  end;

implementation

{$R *.dfm}

procedure TfrmSelection.FormCreate(Sender: TObject);
begin
  inherited;
  NumDays := 1;
end;

procedure TfrmSelection.SetDefaults;
begin
  
end;

end.
