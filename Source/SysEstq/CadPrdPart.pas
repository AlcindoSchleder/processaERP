unit CadPrdPart;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/03/2006                                                   *}
{* Modified:                                                             *}
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
  Dialogs, CadModel;

type
  TfrmPart = class(TfrmModel)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
  end;

var
  frmPart: TfrmPart;

implementation

uses mSysEstq, ProcUtils;

{$R *.dfm}

{ TfrmPart }

procedure TfrmPart.ClearControls;
begin
  inherited;

end;

procedure TfrmPart.LoadDefaults;
begin
  inherited;

end;

procedure TfrmPart.MoveDataToControls;
begin
  inherited;

end;

procedure TfrmPart.SaveIntoDB;
begin
end;

end.
