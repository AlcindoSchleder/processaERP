unit CadPed;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
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
  Dialogs, ComCtrls, ProcType, TSysMan, TSysPedAux, ProcUtils, VirtualTrees,
  CadModel;

type
  TOrderFormClass = class of TfrmModel;

  TOrderPageType  = (optSearchOrder, optEditOrder);

  TScreenOrder    = (soSalesOrder, soPurchaseOrder, soSales, soPurchase);

  TCdPedidos = class(TForm)
    sbStatus: TStatusBar;
    pgMain: TPageControl;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pgMainChange(Sender: TObject);
    procedure pgMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbStatusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FActiveCompany: TCompany;
    FCountSearch  : Integer;
    FOrderCompany : Integer;
    FSelectedOrder: Integer;
    FRect         : TRect;
    FCompanyClick : Boolean;
    FMultiCompany : Boolean;
    FScrState      : TDBMode;
    FScreenOrder  : TScreenOrder;
    FFormsArray   : array [0..Ord(High(TOrderPageType))] of TOrderPageType;
    procedure LoadPages;
    procedure ClearPages;
    procedure ShowAPage(Ix: Integer);
    procedure SetScrState(AValue: TDBMode);
    procedure SetMultiCompany(AValue: Boolean);
    procedure ChangeMode(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure SetScreenOrder(const Value: TScreenOrder);
  public
    { Public declarations }
    property  ScrState     : TDBMode      read FScrState      write SetScrState;
    property  MultiCompany: Boolean      read FMultiCompany write SetMultiCompany;
  published
    { Published declarations }
    property  ScreenOrder : TScreenOrder read FScreenOrder  write SetScreenOrder;
  end;

var
  frmOrder: TCdPedidos;

implementation

{$R *.dfm}

uses Dado, SearchOrder, CadOrder, SelEmpr, TypInfo;

var
  OrderFormClass: array [TOrderPageType] of TOrderFormClass =
    (TfmSearchOrder, TCdOrder);
  OrderPageTitle: array [TOrderPageType] of string          =
    ('Seleção dos Pedidos', 'Edição dos Pedidos');
  OrderPageImage: array [0..1] of Integer = (35, 81);

procedure TCdPedidos.FormCreate(Sender: TObject);
begin
  MultiCompany              := Dados.MultiCompany;
  FillChar(FFormsArray, 2, 0);
end;

procedure TCdPedidos.FormShow(Sender: TObject);
begin
  pgMain.Images             := Dados.Image16;
  Caption                   := Application.Title + ' - ' + Dados.Parametros.soProgramTitle;
  FCountSearch              := 0;
  PgMain.Align              := alClient;
  FActiveCompany            := TCompany.Create;
  FActiveCompany.PkCompany  := Dados.PkCompany;
  FActiveCompany.DscEmp     := Dados.NameCompany;
  FSelectedOrder            := 0;
  LoadPages;
  pgMain.ActivePageIndex    := 0;
  pgMainChange(pgMain);
end;

procedure TCdPedidos.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Scr  : Integer;
  aForm: TForm;
begin
  for Scr := 0 to Screen.FormCount - 1 do
  begin
    aForm := Screen.Forms[Scr];
    if CanClose then
      CanClose := (not (TfrmModel(aForm).ScrState in UPDATE_MODE));
  end;
  if not CanClose then
  begin
    CanClose := Application.MessageBox(PanSiChar('Atenção: Há alterações ' +
                  'na tela. Deseja sair mesmo assim?'), PAnsiChar(Application.Title),
                  MB_ICONWARNING + MB_YESNO) = mrYes;
  end;
end;

procedure TCdPedidos.FormDestroy(Sender: TObject);
begin
  ClearPages;
  if Assigned(FActiveCompany) then
    FActiveCompany.Free;
  FActiveCompany := nil;
end;

procedure TCdPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = []) and (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
    exit;
  end;
end;

procedure TCdPedidos.LoadPages;
var
  aTabSheet: TTabSheet;
  PageType:  TOrderPageType;
begin
  ClearPages;
  for PageType := Low(TOrderPageType) to High(TOrderPageType) do
  begin
    if (FScreenOrder > soPurchaseOrder) and (PageType = optSearchOrder) then Continue;
    aTabSheet             := TTabSheet.Create(pgMain);
    aTabSheet.PageControl := pgMain;
    aTabSheet.Caption     := OrderPageTitle[PageType];
    aTabSheet.ImageIndex  := OrderPageImage[Integer(PageType)];
    FFormsArray[aTabSheet.PageIndex] := PageType;
    aTabSheet.Tag         := 0;
  end;
end;

procedure TCdPedidos.ClearPages;
var
  i        : Integer;
  aForm    : TForm;
  aTabSheet: TTabSheet;
begin
  i := Ord(High(TOrderPageType));
  if i > pgMain.PageCount - 1 then i := pgMain.PageCount - 1;
  while i > -1 do
  begin
    aTabSheet := pgMain.Pages[i];
    aForm     := TForm(aTabSheet.Tag);
    if ((aForm <> nil) and (aForm is OrderFormClass[TOrderPageType(i)])) then
    begin
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
  FillChar(FFormsArray, 2, 0);
end;

procedure TCdPedidos.ShowAPage(Ix: Integer);
var
  aForm    : TfrmModel;
  aTabSheet: TTabSheet;
  PageType : TOrderPageType;
begin
  if ((Ix < 0) or (Ix > Ord(High(TOrderPageType))) or
     (Ix >= pgMain.PageCount)) then
    exit;
  aTabSheet := pgMain.Pages[Ix];
  if (aTabSheet = nil) then exit;
  PageType  := FFormsArray[Ix];
  Caption := Application.Title + ' << ' + Dados.Parametros.soProgramTitle +
     ' ' + aTabSheet.Caption + ' >>';
  aForm   := TfrmModel(aTabSheet.Tag);
  if aForm = nil then
  begin
    aForm               := OrderFormClass[PageType].Create(Application);
    aForm.Hide;
    aForm.Parent        := aTabSheet;
    aForm.Align         := alClient;
    aForm.OnKeyDown     := FormKeyDown;
    if (ScreenOrder in [soSalesOrder, soSales]) then
      SetSetProp(aForm, 'OrderTypes', '[otAssistance, otBudget, otRepresentant, otExportation, otBranch, otInternet]')
    else
      SetSetProp(aForm, 'OrderTypes', '[otPurchaseOrder]');
    aTabSheet.Tag       := LongInt(aForm);
    aForm.ScrState      := FScrState;
    aForm.OnChangeState := ChangeMode;
  end;
  aForm.Show;
end;

procedure TCdPedidos.pgMainChange(Sender: TObject);
var
  aForm: TfrmModel;
  aIdx : Integer;
begin
  ShowAPage(pgMain.TabIndex);
  aIdx  := pgMain.ActivePageIndex;
  if (aIdx = -1) then exit;
  aForm := TfrmModel(pgMain.Pages[aIdx].Tag);
  if (aForm <> nil) and (aForm is TfrmModel) then
    aForm.Pk    := FSelectedOrder;
  if (FScrState in LOADING_MODE) and (pgMain.ActivePageIndex = 1) then
  begin
    ScrState := dbmBrowse;
    if (FSelectedOrder = 0) then
      aForm.ScrState := dbmInsert
    else
      aForm.ScrState := FScrState;
  end;
  ChangeMode(Self, FScrState);
end;

procedure TCdPedidos.pgMainChanging(Sender: TObject; var AllowChange: Boolean);
var
  aForm: TfrmModel;
  aIdx : Integer;
begin
  aIdx  := pgMain.ActivePageIndex;
  if aIdx = -1 then exit;
  aForm := TfrmModel(pgMain.Pages[aIdx].Tag);
  if (aForm <> nil) and (aForm is TfrmModel) then
  begin
    if aIdx = 0 then
    begin
      FOrderCompany  := aForm.PkAux;
      FSelectedOrder := aForm.Pk;
    end
    else
      FCountSearch := 0;
  end;
end;

procedure TCdPedidos.sbStatusDrawPanel(StatusBar: TStatusBar;
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
    if (FMultiCompany) then
      StatusBar.Canvas.TextOut(Rect.Left + 22, Rect.Top + 1,' Multi Empresa ')
    else
      StatusBar.Canvas.TextOut(Rect.Left + 22, Rect.Top + 1,'Empresa: ' +
        IntToStr(FActiveCompany.PkCompany) + ' / ' + FActiveCompany.DscEmp);
  end;
  if Panel.Index = 2 then
  begin
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrState];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrState]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
  end;
end;

procedure TCdPedidos.sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TCdPedidos.sbStatusClick(Sender: TObject);
var
  aChange: Boolean;
//  aForm  : TfrmModel;
  aIdx   : Integer;
begin
  if ((FMultiCompany) or (not FCompanyClick)) then
    exit;
  aChange := True;
  aIdx  := pgMain.ActivePageIndex;
  if aIdx < 0 then exit;
//  aForm := TfrmModel(pgMain.Pages[aIdx].Tag);
//  if (aForm <> nil) and (aForm.InheritsFrom(TfrmModel)) then
//    aForm.ChangeCompany(Sender, aChange, True);
  if not aChange then exit;
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    FCompanyClick := False;
    SelEmpresa.Free;
  end;
  if (FActiveCompany <> nil) then
    FActiveCompany          := TCompany.Create;
  if (FActiveCompany.PkCompany = Dados.PkCompany) then exit;
  FActiveCompany.PkCompany := Dados.PkCompany;
  FActiveCompany.DscEmp    := Dados.NameCompany;
//  if (aForm <> nil) and (aForm.InheritsFrom(TfrmModel)) then
//    aForm.ActiveCompany := FActiveCompany;
  sbStatus.Repaint;
end;

procedure TCdPedidos.SetScrState(AValue: TDBMode);
begin
  FScrState := AValue;
  sbStatus.Repaint;
end;

procedure TCdPedidos.SetMultiCompany(AValue: Boolean);
begin
  FMultiCompany := AValue;
  sbStatus.Repaint;
end;

procedure TCdPedidos.ChangeMode(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  if (pgMain.ActivePageIndex = 0) then
    ScrState := dbmFind;
  if (pgMain.ActivePageIndex = 1) then
    ScrState := AState;
end;

procedure TCdPedidos.SetScreenOrder(const Value: TScreenOrder);
begin
  FScreenOrder := Value;
  if (FScreenOrder < soSales) then
    FScrState                := dbmFind
  else
    FScrState                := dbmBrowse;
  LoadPages;
end;

initialization
  RegisterClass(TCdPedidos);
end.
