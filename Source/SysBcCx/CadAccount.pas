unit CadAccount;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/01/2006 - DD/MM/YYYY                                      *}
{* Modified: 03/01/2006 - DD/MM/YYYY                                     *}
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
  Dialogs, ComCtrls, ToolWin, ExtCtrls, VirtualTrees, GridRow, ProcUtils,
  Menus;

type
  TActiveScreen = (asTypeAccount, asAccount, asBank, asBankAccount);

  TfrmAccount = class(TForm)
    vtAccounts: TVirtualStringTree;
    pData: TPanel;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    pgControl: TPageControl;
    tsTypeAccount: TTabSheet;
    tsAccounts: TTabSheet;
    tsBanks: TTabSheet;
    tbInsert: TToolButton;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    tbSepOpe: TToolButton;
    tbSalvar: TToolButton;
    tbSepClose: TToolButton;
    tbClose: TToolButton;
    sbStatus: TStatusBar;
    pmNew: TPopupMenu;
    pmNewTypeAccount: TMenuItem;
    pmNewAccount: TMenuItem;
    pmNewBank: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbCloseClick(Sender: TObject);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FCompanyClick: Boolean;
    FScrMode     : TDBMode;
    FRect        : TRect;
    procedure LoadAccounts;
    procedure SetScrMode(const Value: TDBMode);
    procedure ShowTypeAccount(const APk: Integer);
    procedure ShowAccount(const ADsc: string; const APkTypeAccount, APk: Integer);
    procedure ShowBankAccount(const ADsc, APkAgency: string;
                const APk, APkAccount, APkBank: Integer);
    procedure ShowBank(const ADsc: string; const APk: Integer);
    procedure ChangeScrMode(Sender: TObject; AMode: TDBMode);
    procedure ChangeButtons;
  public
    { Public declarations }
    property ScrMode: TDBMode read FScrMode write SetScrMode;
  end;

var
  frmAccount: TfrmAccount;

implementation

uses Dado, ProcType, FuncoesDB, mSysBcCx, ArqSqlBcCx, SelEmpr;

{$R *.dfm}

procedure TfrmAccount.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtSearch);
end;

procedure TfrmAccount.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (FScrMode in UPDATE_MODE) then
    CanClose := Application.MessageBox(PanSiChar('Atenção: Há alterações ' +
                  'na tela. Deseja sair mesmo assim?'), PAnsiChar(Application.Title),
                  MB_ICONWARNING + MB_YESNO) = mrYes;
end;

procedure TfrmAccount.FormShow(Sender: TObject);
begin
  ScrMode := dbmBrowse;
  Caption := Application.Title + ' - ' + Dados.Parametros.ProgramTitle;
end;

procedure TfrmAccount.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
  end;
end;


procedure TfrmAccount.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAccount.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  // Change the company...
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    FCompanyClick := False;
    SelEmpresa.Free;
  end;
end;

procedure TfrmAccount.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  if (not (Panel.Index in [1, 2])) then exit;
  StatusBar.Canvas.Brush.Color := clBtnFace;
  StatusBar.Canvas.Font.Style  := [fsBold];
  StatusBar.Canvas.Font.Name := 'Arial';
  StatusBar.Canvas.FillRect(Rect);
  if (Panel.Index = 1) then
  begin
    FRect := Rect;
    StatusBar.Canvas.Font.Color := ClNavy;
    Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
    StatusBar.Canvas.TextOut(Rect.Left + 22, Rect.Top + 1,'Empresa: ' +
      IntToStr(Dados.PkCompany) + ' / ' + Dados.NameCompany);
  end;
  if Panel.Index = 2 then
  begin
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrMode];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrMode];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrMode]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrMode]);
  end;
end;

procedure TfrmAccount.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

initialization
  RegisterClass(TfrmAccount);

end.
