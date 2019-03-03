unit CadParGlb;

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
  Dialogs, ProcUtils, VirtualTrees, ComCtrls, ToolWin, ImgList, GridRow,
  PrcSysTypes, ExtCtrls, Mask, ToolEdit, CurrEdit, StdCtrls, TSysCad;

type
  THandleInsertEvent = procedure (Sender: TObject; var Row: TDataRow) of object;

  TCdParamGlobal = class(TForm)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    sbStatus: TStatusBar;
    tbCancel: TToolButton;
    tbDelete: TToolButton;
    tbSave: TToolButton;
    ToolButton5: TToolButton;
    ToolButton1: TToolButton;
    tbClose: TToolButton;
    lFk_Clientes: TStaticText;
    eFk_Clientes: TComboBox;
    lDias_Atr: TStaticText;
    lPer_CvMed: TStaticText;
    lQtd_DvMed: TStaticText;
    lQtd_DTol: TStaticText;
    lNum_Cas_Dec: TStaticText;
    eNum_Cas_Dec: TCurrencyEdit;
    lQtd_DcMed: TStaticText;
    shTitle: TShape;
    lTitle: TLabel;
    lFlag_Lan_Parc: TCheckBox;
    lFlag_Multi: TCheckBox;
    eQtd_DTol: TCurrencyEdit;
    ePer_CvMed: TCurrencyEdit;
    eDias_Atr: TCurrencyEdit;
    eQtd_DvMed: TCurrencyEdit;
    eQtd_DcMed: TCurrencyEdit;
    lNum_Cas_Dec_Qtd: TStaticText;
    eNum_Cas_Dec_Qtd: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChangeGlobal(Sender: TObject);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbCancelClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbCloseClick(Sender: TObject);
  private
    { Private declarations }
    FListLoaded     : Boolean;
    FLoading        : Boolean;
    FPk             : Integer;
    FRect           : TRect;
    FScrState       : TDBMode;
    function  CheckRecord: Boolean;
    procedure SetPk(const Value: Integer);
    procedure SetScrState(const Value: TDBMode);
    function GetDiasAtr: Integer;
    function GetFkCustomer: Integer;
    function GetFlagLanParc: Boolean;
    function GetFlagMulti: Boolean;
    function GetNumCasDec: Integer;
    function GetPerCvMed: Integer;
    function GetQtdDcMed: Integer;
    function GetQtdDTol: Integer;
    function GetQtdDvMed: Integer;
    procedure SetDiasAtr(const Value: Integer);
    procedure SetFkCustomer(const Value: Integer);
    procedure SetFlagLanParc(const Value: Boolean);
    procedure SetFlagMulti(const Value: Boolean);
    procedure SetNumCasDec(const Value: Integer);
    procedure SetPerCvMed(const Value: Integer);
    procedure SetQtdDcMed(const Value: Integer);
    procedure SetQtdDTol(const Value: Integer);
    procedure SetQtdDvMed(const Value: Integer);
    function GetDataRow: TDataRow;
    procedure SetDataRow(const Value: TDataRow);
    function GetNumCasDecQt: Integer;
    procedure SetNumCasDecQt(const Value: Integer);
  protected
    { Protected declarations }
    FCompanyClick: Boolean;
    procedure ClearControls;
    procedure LoadDefaults;
    procedure MoveDataToControls;
    procedure SaveIntoDB;
  public
    { Public declarations }
    property  DataRow    : TDataRow read GetDataRow    write SetDataRow;
    property  FkCustomer : Integer  read GetFkCustomer  write SetFkCustomer;
    property  DiasAtr    : Integer  read GetDiasAtr     write SetDiasAtr;
    property  PerCvMed   : Integer  read GetPerCvMed    write SetPerCvMed;
    property  QtdDTol    : Integer  read GetQtdDTol     write SetQtdDTol;
    property  QtdDvMed   : Integer  read GetQtdDvMed    write SetQtdDvMed;
    property  QtdDcMed   : Integer  read GetQtdDcMed    write SetQtdDcMed;
    property  FlagLanParc: Boolean  read GetFlagLanParc write SetFlagLanParc;
    property  FlagMulti  : Boolean  read GetFlagMulti   write SetFlagMulti;
    property  NumCasDec  : Integer  read GetNumCasDec   write SetNumCasDec;
    property  NumCasDecQt: Integer  read GetNumCasDecQt write SetNumCasDecQt;
    property  Loading    : Boolean  read FLoading       write FLoading;
    property  Pk         : Integer  read FPk            write SetPk;
    property  ScrState   : TDBMode  read FScrState      write SetScrState;
  end;

implementation

{$R *.dfm}

{ TfrmModel }

uses Dado, SelEmpr, ProcType, Funcoes, FuncoesDB, mSysMan, DB, SqlComm,
  ManArqSql;

procedure TCdParamGlobal.FormCreate(Sender: TObject);
begin
  cbTools.Images       := Dados.Image16;
  tbTools.Images       := Dados.Image16;
  FScrState            := dbmBrowse;
  ClearControls;
end;

procedure TCdParamGlobal.FormDestroy(Sender: TObject);
begin
  ReleaseCombos(eFk_Clientes, toObject);
end;

procedure TCdParamGlobal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (FScrState in UPDATE_MODE) then
    if (Dados.DisplayMessage('Há alterações na tela. Deseja sair e abandonar ' +
          'as alterações?', hiQuestion, [mbYes, mbNo]) = mrNo) then
      Action := caNone;
end;

procedure TCdParamGlobal.FormShow(Sender: TObject);
begin
  Caption := Application.Title + ' - ' + Dados.Parametros.soProgramTitle;
  LoadDefaults;
  ScrState := dbmBrowse;
  Pk       := 1;
end;

procedure TCdParamGlobal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
  end;
end;

procedure TCdParamGlobal.ChangeGlobal(Sender: TObject);
begin
  if (Loading) or (FScrState in UPDATE_MODE) then exit;
  if (FScrState = dbmBrowse) and (PK = 0) then
    ScrState := dbmInsert
  else
    ScrState := dbmEdit;
end;

procedure TCdParamGlobal.SetScrState(const Value: TDBMode);
begin
  if (FScrState <> Value) then
  begin
    if (Value = dbmPost) and (not CheckRecord) then Abort;
    if (Value <> dbmPost) then
      FScrState := Value;
    case Value of
      dbmPost  : SaveIntoDB;
      dbmCancel: MoveDataToControls;
      dbmBrowse: MoveDataToControls;
    end;
    FScrState := Value;
  end;
  tbCancel.Enabled := (FScrState in UPDATE_MODE);
  tbSave.Enabled   := (FScrState in UPDATE_MODE);
  tbClose.Enabled  := (FScrState in SCROLL_MODE);
  sbStatus.Repaint;
end;

procedure TCdParamGlobal.SetPk(const Value: Integer);
begin
  if (Value <> FPk) then
  begin
    FPk := Value;
    MoveDataToControls;
  end;
end;

procedure TCdParamGlobal.sbStatusClick(Sender: TObject);
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
  sbStatus.Repaint;
end;

procedure TCdParamGlobal.sbStatusDrawPanel(StatusBar: TStatusBar;
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
    StatusBar.Canvas.Font.Color  := FontColorMode[FScrState];
    StatusBar.Canvas.Brush.Color :=     ColorMode[FScrState];
    X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
         (Canvas.TextWidth(ModeTypes[FScrState]) div 2);
    StatusBar.Canvas.TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
  end;
end;

procedure TCdParamGlobal.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TCdParamGlobal.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmCancel;
  ScrState := dbmBrowse;
end;

procedure TCdParamGlobal.tbSaveClick(Sender: TObject);
begin
  ScrState := dbmPost;
  ScrState := dbmBrowse;
end;

procedure TCdParamGlobal.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCdParamGlobal.ClearControls;
begin
  FLoading := True;
  try
    FkCustomer  := 0;
    DiasAtr     := 5;
    PerCvMed    := 365;
    QtdDTol     := 7;
    QtdDvMed    := 30;
    QtdDcMed    := 30;
    FlagLanParc := False;
    FlagMulti   := False;
    NumCasDec   := 2;
  finally
    FLoading := False;
  end;
end;


function TCdParamGlobal.CheckRecord: Boolean;
var
  C: TControl;
  S: string;
begin
  Result := True;
  C := Self;
  S := '';
  if (FkCustomer <= 0) then
  begin
    S := 'Campo Cliente Default deve ser preenchido';
    C := eFk_Clientes;
  end;
  if (DiasAtr < 0) then
  begin
    S := 'Campo Tolerância de Atrasos deve ser zero ou um número positivo';
    C := eDias_Atr;
  end;
  if (QtdDTol < 0) then
  begin
    S := 'Campo Dias de Tolerância Tabela Preços deve ser zero ou um número positivo';
    C := eQtd_DTol;
  end;
  if (QtdDcMed < 0) then
  begin
    S := 'Campo Dias p/Cálc. do Cons. Médio deve ser zero ou um número positivo';
    C := eQtd_DcMed;
  end;
  if (QtdDvMed < 0) then
  begin
    S := 'Campo Dias p/Cálc. da Venda Média deve ser zero ou um número positivo';
    C := eQtd_DvMed;
  end;
  if (PerCvMed < 0) then
  begin
    S := 'Campo Quant.dias p/Soma de I/O deve ser zero ou um número positivo';
    C := ePer_CvMed;
  end;
  if (NumCasDec < 0) or  (NumCasDec > 4) then
  begin
    S := 'Campo Número de Casas decimais deve ser um número entre 0 e 4';
    C := eNum_Cas_Dec;
  end;
  if (NumCasDecQt < 0) or (NumCasDecQt > 4) then
  begin
    S := 'Campo Número de Casas decimais deve ser um número entre 0 e 4';
    C := eNum_Cas_Dec_Qtd;
  end;
  if (S <> '') then
  begin
    Result := False;
    Dados.DisplayHint(C, S);
  end;
end;

function TCdParamGlobal.GetDiasAtr: Integer;
begin
  Result := eDias_Atr.AsInteger;
end;

function TCdParamGlobal.GetFkCustomer: Integer;
begin
  with eFk_Clientes do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TOwner(Items.Objects[ItemIndex]).PkCadastros;
  end;
end;

function TCdParamGlobal.GetFlagLanParc: Boolean;
begin
  Result := lFlag_Lan_Parc.Checked;
end;

function TCdParamGlobal.GetFlagMulti: Boolean;
begin
  Result := lFlag_Multi.Checked;
end;

function TCdParamGlobal.GetNumCasDec: Integer;
begin
  Result := eNum_Cas_Dec.AsInteger;
end;

function TCdParamGlobal.GetPerCvMed: Integer;
begin
  Result := ePer_CvMed.AsInteger;
end;

function TCdParamGlobal.GetQtdDcMed: Integer;
begin
  Result := eQtd_DcMed.AsInteger;
end;

function TCdParamGlobal.GetQtdDTol: Integer;
begin
  Result := eQtd_DTol.AsInteger;
end;

function TCdParamGlobal.GetQtdDvMed: Integer;
begin
  Result := eQtd_DvMed.AsInteger;
end;

procedure TCdParamGlobal.LoadDefaults;
begin
  if (not FListLoaded) then
  begin
    eFk_Clientes.Items.AddStrings(dmSysMan.LoadOwners(SqlRealClients));
    FListLoaded := True;
  end;
end;

procedure TCdParamGlobal.MoveDataToControls;
begin
  Loading := True;
  try
    DataRow := dmSysMan.GetGlobalParams(Pk);
  finally
    Loading := False;
  end;
end;

procedure TCdParamGlobal.SaveIntoDB;
begin
  dmSysMan.SaveGlobalParams(DataRow, ScrState);
end;

procedure TCdParamGlobal.SetDiasAtr(const Value: Integer);
begin
  eDias_Atr.AsInteger := Value;
end;

procedure TCdParamGlobal.SetFkCustomer(const Value: Integer);
var
  i: Integer;
begin
  eFk_Clientes.ItemIndex := -1;
  if (Value <= 0) then exit;
  with eFk_Clientes do
    for i := 0 to Items.Count do
      if (Items.Objects[i] <> nil) and
         (TOwner(Items.Objects[i]).PkCadastros = Value) then
      begin
        ItemIndex := i;
        break;
      end;
end;

procedure TCdParamGlobal.SetFlagLanParc(const Value: Boolean);
begin
  lFlag_Lan_Parc.Checked := Value;
end;

procedure TCdParamGlobal.SetFlagMulti(const Value: Boolean);
begin
  lFlag_Multi.Checked := Value;
end;

procedure TCdParamGlobal.SetNumCasDec(const Value: Integer);
begin
  eNum_Cas_Dec.AsInteger := Value;
end;

procedure TCdParamGlobal.SetPerCvMed(const Value: Integer);
begin
  ePer_CvMed.AsInteger := Value;
end;

procedure TCdParamGlobal.SetQtdDcMed(const Value: Integer);
begin
  eQtd_DcMed.AsInteger := Value;
end;

procedure TCdParamGlobal.SetQtdDTol(const Value: Integer);
begin
  eQtd_DTol.AsInteger := Value;
end;

procedure TCdParamGlobal.SetQtdDvMed(const Value: Integer);
begin
  eQtd_DvMed.AsInteger := Value;
end;

function TCdParamGlobal.GetDataRow: TDataRow;
begin
  Result := TDataRow.Create(nil);
  Result.AddAs('FK_CLIENTES', FkCustomer, ftInteger, SizeOf(Integer));
  Result.AddAs('DIAS_ATR', DiasAtr, ftInteger, SizeOf(Integer));
  Result.AddAs('PER_CVMED', PerCvMed, ftInteger, SizeOf(Integer));
  Result.AddAs('QTD_DTOL', QtdDTol, ftInteger, SizeOf(Integer));
  Result.AddAs('QTD_DVMED', QtdDvMed, ftInteger, SizeOf(Integer));
  Result.AddAs('QTD_DCMED', QtdDcMed, ftInteger, SizeOf(Integer));
  Result.AddAs('FLAG_LAN_PARC', Ord(FlagLanParc), ftInteger, SizeOf(Integer));
  Result.AddAs('FLAG_MULTI', Ord(FlagMulti), ftInteger, SizeOf(Integer));
  Result.AddAs('NUM_CAS_DEC', NumCasDec, ftInteger, SizeOf(Integer));
  Result.AddAs('NUM_CAS_DEC_QTD', NumCasDecQt, ftInteger, SizeOf(Integer));
end;

procedure TCdParamGlobal.SetDataRow(const Value: TDataRow);
begin
  if (Value = nil) then exit;
  FkCustomer  := Value.FieldByName['FK_CLIENTES'].AsInteger;
  DiasAtr     := Value.FieldByName['DIAS_ATR'].AsInteger;
  PerCvMed    := Value.FieldByName['PER_CVMED'].AsInteger;
  QtdDTol     := Value.FieldByName['QTD_DTOL'].AsInteger;
  QtdDvMed    := Value.FieldByName['QTD_DVMED'].AsInteger;
  QtdDcMed    := Value.FieldByName['QTD_DCMED'].AsInteger;
  FlagLanParc := Boolean(Value.FieldByName['FLAG_LAN_PARC'].AsInteger);
  FlagMulti   := Boolean(Value.FieldByName['FLAG_MULTI'].AsInteger);
  NumCasDec   := Value.FieldByName['NUM_CAS_DEC'].AsInteger;
  NumCasDecQt := Value.FieldByName['NUM_CAS_DEC_QTD'].AsInteger;
end;

function TCdParamGlobal.GetNumCasDecQt: Integer;
begin
  Result := eNum_Cas_Dec_Qtd.AsInteger;
end;

procedure TCdParamGlobal.SetNumCasDecQt(const Value: Integer);
begin
  eNum_Cas_Dec_Qtd.AsInteger := Value;
end;

initialization
   RegisterClass(TCdParamGlobal);

end.
