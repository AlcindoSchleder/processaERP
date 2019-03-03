unit Autor;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 2.0.0.0                                                      *}
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

uses SysUtils, Classes,
  {$IFNDEF LINUX}
    Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons
  {$ELSE}
    QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons
  {$ENDIF};

type
  TfrmAuthor = class(TForm)
    btnOK: TSpeedButton;
    btnCancel: TSpeedButton;
    btnMsg: TSpeedButton;
    Label1: TStaticText;
    eUserName: TEdit;
    Label2: TStaticText;
    eUserPasswd: TEdit;
    eUserMsg: TMemo;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eUserNameExit(Sender: TObject);
    procedure btnMsgClick(Sender: TObject);
    procedure btnMsgUndo(Sender: TObject);
  private
    { Private declarations }
    function  GetUserName: string;
    procedure SetUserName(AValue: string);
    function  GetUserPasswd: string;
    procedure SetUserPasswd(AValue: string);
    procedure SetUserMsg(AValue: string);
    procedure SetfrmCaption(AValue: string);
  public
    { Public declarations }
    property frmCaption: string                    write SetfrmCaption;
    property UserName  : string read GetUserName   write SetUserName;
    property UserPasswd: string read GetUserPasswd write SetUserPasswd;
    property UserMsg   : string                    write SetUserMsg;
  end;

var
  frmAuthor: TfrmAuthor;

implementation

{$R *.DFM}

procedure TfrmAuthor.FormActivate(Sender: TObject);
begin
  UserName   := '';
  UserPasswd := '';
end;

procedure TfrmAuthor.FormCreate(Sender: TObject);
begin
  btnMsgUndo(Sender);
  frmCaption := Application.Title + ' - Autorização';
end;

function  TfrmAuthor.GetUserName: string;
begin
  Result := eUserName.Text;
end;

procedure TfrmAuthor.SetUserName(AValue: string);
begin
  eUserName.Text := Copy(AValue, 1, 10);
end;

function  TfrmAuthor.GetUserPasswd: string;
begin
  Result := eUserPasswd.Text;
end;

procedure TfrmAuthor.SetUserPasswd(AValue: string);
begin
  eUserPasswd.Text := Copy(AValue, 1, 13);
end;

procedure TfrmAuthor.SetUserMsg(AValue: string);
begin
  if (AValue = '') then
    eUserMsg.Lines.Clear
  else
    eUserMsg.Lines.Text := AValue;
end;

procedure TfrmAuthor.SetfrmCaption(AValue: string);
begin
  Caption := AValue;
end;

procedure TfrmAuthor.btnOKClick(Sender: TObject);
begin
  ModalResult := mrOK
end;

procedure TfrmAuthor.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmAuthor.eUserNameExit(Sender: TObject);
begin
  if (eUserName.Text <> '') and
     (eUserPasswd.Text <> '') then
    btnOkClick(Sender);
end;

procedure TfrmAuthor.btnMsgClick(Sender: TObject);
begin
  Height := 248;
  eUserMsg.Visible := True;
  btnMsg.Caption := '<< &Detalhes';
  btnMsg.OnClick := btnMsgUndo;
end;

procedure TfrmAuthor.btnMsgUndo(Sender: TObject);
begin
  eUserMsg.Visible := False;
  Height := 128;
  btnMsg.Caption := '&Detalhes >>';
  btnMsg.OnClick := btnMsgClick;
end;

end.
