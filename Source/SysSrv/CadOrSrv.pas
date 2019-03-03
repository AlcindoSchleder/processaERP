unit CadOrSrv;    

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
  Dialogs, ComCtrls, VirtualTrees, Buttons, TSysSrv, ExtCtrls, OSForms,
  TSysMan;

type
  TOSFormClass = class of TOSForm;

  TOSPageType = (optEditOS, optSearchOS);

  TfrmServiceOrder = class(TForm)
    pgMain: TPageControl;
    sbStatus: TStatusBar;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pgMainChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure sbChangeCompanyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pgMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FCountSearch  : Integer;
    FRect         : TRect;
    FCompanyClick : Boolean;
    FActiveCompany: TCompany;
    procedure ShowAPage(Ix: Integer);
    procedure ClearPages;
    procedure LoadPages;
  public
    { Public declarations }
  end;

implementation

uses SearchOS, EditOS, Dado, ProcType, SelEmpr, Types, ProcUtils;

{$R *.dfm}

var
  OSFormClass: array [TOSPageType] of TOSFormClass = (TfmEditOS, TfmSearchOS);
  OSPageTitle: array [TOSPageType] of string       = ('Operação', 'Busca');
  OSPageImage: array [0..1] of Integer = (81, 35);

procedure TfrmServiceOrder.ClearPages;
var
  i        : Integer;
  aForm    : TForm;
  aTabSheet: TTabSheet;
begin
  i := Ord(High(TOSPageType));
  if i > pgMain.PageCount - 1 then i := pgMain.PageCount - 1;
  while i > -1 do
  begin
    aTabSheet := pgMain.Pages[i];
    aForm     := TForm(aTabSheet.Tag);
    if ((aForm <> nil) and (aForm is OSFormClass[TOSPageType(i)])) then
    begin
      aForm.Tag := 0;
      aForm.Free;
      aForm := nil;
      if aForm = nil then
        aTabSheet.Tag := 0;
    end;
    pgMain.RemoveControl(aTabSheet);
    aTabSheet.Free;
    aTabSheet := nil;
    if aTabSheet = nil then Dec(i);
  end;
end;

procedure TfrmServiceOrder.ShowAPage(Ix: Integer);
var
  aForm    : TOSForm;
  aTabSheet: TTabSheet;
  PageType : TOSPageType;
begin
  if ((Ix < 0) or (Ix > Ord(High(TOSPageType))) or (Ix >= pgMain.PageCount)) then
    exit;
  PageType  := TOSPageType(Ix);
  aTabSheet := pgMain.Pages[Ix];
  if aTabSheet = nil then
    Exit;
  Caption := Dados.Parametros.soTitle + ' - ' + Dados.Parametros.soProgramTitle +
             ' - ' + aTabSheet.Caption;
  aForm   := TOSForm(aTabSheet.Tag);
  if aForm = nil then
  begin
    aForm           := OSFormClass[PageType].Create(Self);
    if aForm.ActiveCompany <> nil then
      aForm.ActiveCompany.Assign(FActiveCompany);
    aForm.Parent    := aTabSheet;
    aForm.Align     := alClient;
    aForm.OnKeyDown := FormKeyDown;
    aTabSheet.Tag   := LongInt(aForm);
    aForm.Show;
  end;
  aForm.CountSearch := FCountSearch;
end;

procedure TfrmServiceOrder.LoadPages;
var
  aTabSheet: TTabSheet;
  PageType:  TOSPageType;
begin
  ClearPages;
  for PageType := Low(TOSPageType) to High(TOSPageType) do
  begin
    aTabSheet             := TTabSheet.Create(pgMain);
    aTabSheet.Parent      := pgMain;
    aTabSheet.Align       := alClient;
    aTabSheet.PageControl := pgMain;
    aTabSheet.Caption     := OSPageTitle[PageType];
    aTabSheet.ImageIndex  := OSPageImage[Integer(PageType)];
    aTabSheet.Tag         := 0;
  end;
end;


procedure TfrmServiceOrder.FormDestroy(Sender: TObject);
begin
  ClearPages;
end;

procedure TfrmServiceOrder.FormShow(Sender: TObject);
begin
  LoadPages;
  ShowAPage(0);
end;

procedure TfrmServiceOrder.pgMainChange(Sender: TObject);
begin
  ShowAPage(pgMain.TabIndex);
end;

procedure TfrmServiceOrder.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  aControl: TWinControl;
begin
  aControl := Screen.ActiveControl;
  if aControl <> nil then
  begin
    if ((aControl.InheritsFrom(TVirtualStringTree)) and
      (TVirtualStringTree(aControl).IsEditing)) then
      exit;
    aControl := aControl.Parent;
    if ((aControl <> nil) and (aControl.InheritsFrom(TVirtualStringTree)) and
      (TVirtualStringTree(aControl).IsEditing)) then
      exit;
  end;
  if (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
  end;
end;

procedure TfrmServiceOrder.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel.Index <> 1 then exit;
  with StatusBar.Canvas do
  begin
    FRect := Rect;
    FillRect(Rect);
    Font.Name := 'Arial';
    Font.Color := ClNavy;
    Font.Style := [FsBold];
    Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
    TextOut(Rect.Left + 22, Rect.Top + 1,'Empresa: ' +
      IntToStr(FActiveCompany.PkCompany) + ' / ' + FActiveCompany.DscEmp);
  end;
end;

procedure TfrmServiceOrder.sbChangeCompanyClick(Sender: TObject);
var
  aChange: Boolean;
  aReload: Boolean;
  aForm  : TOSForm;
  aIdx   : Integer;
begin
  if (not FCompanyClick) and (pgMain.ActivePageIndex > 0) then exit;
  // Change the company...
  aIdx  := pgMain.ActivePageIndex;
  if aIdx < 0 then exit;
  aForm := TOSForm(pgMain.Pages[aIdx].Tag);
  if (aForm <> nil) and (aForm.InheritsFrom(TOSForm)) then
  begin
    if Assigned(aForm.OnChangeCompany) then
      aForm.OnChangeCompany(Sender, aChange, aReload);
  end;
  if not aChange then exit;
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    aChange := SelEmpresa.ShowModal = mrOk;
  finally
    FCompanyClick := False;
    SelEmpresa.Free;
  end;
  if (FActiveCompany <> nil) then
    FActiveCompany          := TCompany.Create;
  if (FActiveCompany.PkCompany = Dados.PkCompany) or
     (not aChange) then exit;
  FActiveCompany.PkCompany := Dados.PkCompany;
  FActiveCompany.DscEmp    := Dados.NameCompany;
  if (aForm <> nil) and (aForm.InheritsFrom(TOSForm)) then
  begin
    aForm.ActiveCompany.PkCompany := FActiveCompany.PkCompany;
    aForm.ActiveCompany.DscEmp    := Dados.NameCompany;
  end;
  sbStatus.Canvas.TextOut(FRect.Left + 22, FRect.Top + 1,'Empresa: ' +
      IntToStr(FActiveCompany.PkCompany) + '/' + FActiveCompany.DscEmp);
end;

procedure TfrmServiceOrder.FormCreate(Sender: TObject);
begin
  pgMain.Images             := Dados.Image16;
  FCountSearch              := 0;
  PgMain.Align              := alClient;
  FActiveCompany            := TCompany.Create;
  FActiveCompany.PkCompany  := Dados.PkCompany;
  FActiveCompany.DscEmp     := Dados.NameCompany;
end;

procedure TfrmServiceOrder.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (Y >= FRect.TopLeft.Y) and
                   (Y <= (FRect.TopLeft.Y + 22));
end;

procedure TfrmServiceOrder.pgMainChanging(Sender: TObject;
  var AllowChange: Boolean);
var
  aForm: TOSForm;
  aIdx : Integer;
begin
  aIdx  := pgMain.ActivePageIndex;
  if aIdx = -1 then exit;
  aForm := TOSForm(pgMain.Pages[aIdx].Tag);
  if (aForm <> nil) and (aForm is TOsForm) then
  begin
    if aIdx = 0 then
      FCountSearch := aForm.CountSearch
    else
      FCountSearch := 0;
    AllowChange := aForm.AllowExit;
  end;
end;

procedure TfrmServiceOrder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  i, Scr: Integer;
  aForm : TForm;
begin
  i := 0;
  for Scr := 0 to Screen.FormCount - 1 do
  begin
    aForm := Screen.Forms[Scr];
    if (aForm is TOSForm) and (TOSForm(aForm).dbMode <> dbmBrowse) then
      Inc(i);
  end;
  if i > 0 then
  begin
    CanClose := Application.MessageBox(PanSiChar('Atenção: Há alterações ' +
                  'na tela. Deseja sair mesmo assim?'), PAnsiChar(Application.Title),
                  MB_ICONWARNING + MB_YESNO) = mrYes;
  end;
end;

initialization
  RegisterClass(TfrmServiceOrder);
end.
