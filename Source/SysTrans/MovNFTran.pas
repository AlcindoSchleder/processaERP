unit MovNFTran;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created  : 14/02/2007                                                 *}
{* Modified :                                                            *}
{* Version  : 1.2.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ProcUtils, StdCtrls, PrcSysTypes, ExtCtrls, Dado,
  mSysTrans, CadModel;

type
  TFormsClass   = class of TfrmModel;

  TScreenForms  = (sfSearch, sfSimulator);

  TCdNFTrans = class(TForm)
    pgMain: TPageControl;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbClose: TToolButton;
    sbStatus: TStatusBar;
    tbSearch: TToolButton;
    tbNew: TToolButton;
    tbCancel: TToolButton;
    tbSepFind: TToolButton;
    tbSepClose: TToolButton;
    tbDelete: TToolButton;
    tbSave: TToolButton;
    tbSepSave: TToolButton;
    cbTypeDoc: TComboBox;
    tbCalc: TToolButton;
    tbSepCal: TToolButton;
    tbPrint: TToolButton;
    tbSepPrn: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pgMainChange(Sender: TObject);
    procedure tbCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbTypeDocSelect(Sender: TObject);
    procedure tbSearchClick(Sender: TObject);
    procedure tbCancelClick(Sender: TObject);
    procedure pgMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tbCalcClick(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbNewClick(Sender: TObject);
    procedure tbPrintClick(Sender: TObject);
  private
    { Private declarations }
    FSelectedPk  : Integer;
    FScrState    : TDBMode;
    FCompanyClick: Boolean;
    FRect        : TRect;
    FFormsArray  : array [0..Ord(High(TScreenForms))] of TScreenForms;
    function  GetDocumentType: TDocumentType;
    procedure SetScrState(const Value: TDBMode);
    procedure ClearPages;
    procedure LoadPages;
    procedure ShowAPage(AIdx: Integer);
    procedure ChangeState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
    procedure ChangePk(Sender: TObject);
    procedure SetSearchFormState   (AForm: TfrmModel);
    procedure SetSimulatorFormState(AForm: TfrmModel);
    procedure LoadTypeDocument(ATypes: TDocumentTypes);
    procedure BeforePrintDocument(AForm: TForm; const AParams: TParamsForm);
  public
    { Public declarations }
    property ScrState    : TDBMode       read FScrState       write SetScrState;
    property DocumentType: TDocumentType read GetDocumentType;
  end;

implementation

{$R *.dfm}

uses SelEmpr, ProcType, FuncoesDB, CnsSearchDocs, CadSimul, TypInfo, GridRow,
  SqlComm, DB, ArqSqlTrans;

var
  DocsFormClass  : array [TScreenForms] of TFormsClass =
    (TfrmSearch, TCdSimulator);
  DocsFormCaption: array [TScreenForms] of string      =
    ('Consulta de Documentos', 'Simulador e Gerador de Conhecimentos');
  DocPageImageIdx: array [TScreenForms] of Integer     =
    (35, 81);

procedure TCdNFTrans.FormCreate(Sender: TObject);
begin
  cbTools.Images    := Dados.Image16;
  tbTools.Images    := Dados.Image16;
  pgMain.Images     := Dados.Image16;
  FScrState         := dbmFind;
  FSelectedPk       := 0;
  LoadTypeDocument([dtSimulator, dtDocument]);
  LoadPages;
  if (pgMain.PageCount > 0) then
  begin
    pgMain.ActivePageIndex := 0;
    ShowAPage(0);
  end;
end;

procedure TCdNFTrans.SetScrState(const Value: TDBMode);
var
  aForm: TfrmModel;
begin
  if (FScrState <> Value) then
  begin
    aForm := TFrmModel(pgMain.ActivePage.Tag);
    FScrState := Value;
    if (aForm <> nil) then
      aForm.ScrState := Value;
    ChangeState(Self, FScrState);
  end;
end;

procedure TCdNFTrans.sbStatusClick(Sender: TObject);
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

procedure TCdNFTrans.sbStatusDrawPanel(StatusBar: TStatusBar;
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

procedure TCdNFTrans.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TCdNFTrans.LoadPages;
var
  aTabSheet: TTabSheet;
  PageType:  TScreenForms;
begin
  if (pgMain.PageCount > 0) then
    ClearPages;
  for PageType := Low(TScreenForms) to High(TScreenForms) do
  begin
    aTabSheet             := TTabSheet.Create(pgMain);
    aTabSheet.PageControl := pgMain;
    aTabSheet.Caption     := DocsFormCaption[PageType];
    aTabSheet.ImageIndex  := DocPageImageIdx[PageType];
    FFormsArray[aTabSheet.PageIndex] := PageType;
    aTabSheet.Tag         := 0;
  end;
end;

function TCdNFTrans.GetDocumentType: TDocumentType;
begin
  Result := dtSimulator;
  with cbTypeDoc do
    if ((ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil)) then
      Result := TDocumentType(Integer(Items.Objects[ItemIndex]));
end;

procedure TCdNFTrans.ClearPages;
var
  i        : Integer;
  aForm    : TfrmModel;
  aTabSheet: TTabSheet;
begin
  i := Ord(High(TScreenForms));
  while i > -1 do
  begin
    aTabSheet := pgMain.Pages[i];
    aForm     := TfrmModel(aTabSheet.Tag);
    if ((aForm <> nil) and (aForm is DocsFormClass[TScreenForms(i)])) then
    begin
      FreeAndNil(aForm);
      aTabSheet.Tag := 0;
    end;
    pgMain.RemoveControl(aTabSheet);
    FreeAndNil(aTabSheet);
    Dec(i);
  end;
  FillChar(FFormsArray, Ord(High(TScreenForms)) + 1, 0);
end;

procedure TCdNFTrans.ShowAPage(AIdx: Integer);
var
  aForm    : TfrmModel;
  aTabSheet: TTabSheet;
  PageType : TScreenForms;
begin
  if ((AIdx < 0) or (AIdx > Ord(High(TScreenForms))) or
     (AIdx >= pgMain.PageCount)) then
    exit;
  aTabSheet := pgMain.Pages[AIdx];
  if (aTabSheet = nil) then exit;
  PageType  := FFormsArray[AIdx];
  Caption := Application.Title + ' << ' + Dados.Parametros.soProgramTitle +
     ' ' + aTabSheet.Caption + ' >>';
  aForm   := TfrmModel(aTabSheet.Tag);
  if (aForm = nil) then
  begin
    aForm                 := DocsFormClass[PageType].Create(Self);
    aForm.Parent          := aTabSheet;
    aForm.Align           := alClient;
    aForm.OnKeyDown       := FormKeyDown;
    aTabSheet.Tag         := LongInt(aForm);
    if (PageType = sfSearch) then
    begin
      aForm.ScrState      := dbmFind;
      aForm.OnChangePK    := ChangePk;
    end
    else
      aForm.ScrState      := dbmBrowse;
    aForm.OnChangeState   := ChangeState;
  end;
  aForm.Show;
  cbTypeDocSelect(Self);
end;

procedure TCdNFTrans.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  aControl: TComponent;
  aExit   : Boolean;
begin
  aControl := Screen.ActiveControl.Owner;
  aExit    := (Key = VK_ESCAPE) and (ScrState in SCROLL_MODE);
  if (not (aControl is TfrmModel)) then
    aControl := TfrmModel(pgMain.ActivePage.Tag);
  if (Shift = []) then
  begin
    with TfrmModel(aControl) do
    begin
      case Key of
        VK_ESCAPE: if (TfrmModel(aControl).ScrState in UPDATE_MODE) then
                     TfrmModel(aControl).ScrState := dbmCancel;
        VK_F3    : if (TfrmModel(aControl).ScrState = dbmFind) then
                     TfrmModel(aControl).ScrState := dbmExecute
                   else
                     TfrmModel(aControl).ScrState := dbmFind;
        VK_F10   : TfrmModel(aControl).ScrState := dbmPost;
        VK_INSERT: TfrmModel(aControl).ScrState := dbmInsert;
        VK_DELETE: TfrmModel(aControl).ScrState := dbmDelete;
      end;
    end;
  end;
  if ((Shift = []) and (Key = VK_ESCAPE)) or
     ((Shift = []) and (Key = VK_F5)) or
     ((Shift = []) and (Key = VK_INSERT)) or
     ((ssCtrl in Shift) and (Key = VK_DELETE)) or
     ((Shift = []) and (Key = VK_F10)) then
    Key := 0;
  if (aExit) then Close;
end;

procedure TCdNFTrans.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
var
  aPrinted: Boolean;
begin
  FScrState := AState;
  if (pgMain.ActivePageIndex > 0) and (pgMain.PageCount > 1) and (pgMain.Pages[1].Tag > 0) and
     (TfrmModel(pgMain.Pages[1].Tag) <> nil) and (TfrmModel(pgMain.Pages[1].Tag).Pk > 0) then
    aPrinted := True
  else
    aPrinted := False;
  tbCancel.Enabled   := (AState in UPDATE_MODE) and (pgMain.ActivePageIndex > 0);
  tbSave.Enabled     := (AState in UPDATE_MODE) and (pgMain.ActivePageIndex > 0);
  tbPrint.Enabled    := (AState in SCROLL_MODE) and (pgMain.ActivePageIndex > 0) and (aPrinted);
  tbDelete.Enabled   := (AState in SCROLL_MODE) and (pgMain.ActivePageIndex > 0);
  if (FScrState = dbmFind) then
    tbSearch.Enabled := (pgMain.ActivePageIndex = 0)
  else
    tbSearch.Enabled := (pgMain.ActivePageIndex = 0);
  tbClose.Enabled    := (AState in SCROLL_MODE + LOADING_MODE);
  tbNew.Enabled      := (AState in SCROLL_MODE + LOADING_MODE) and (pgMain.ActivePageIndex > 0);
  tbCalc.Enabled     := (pgMain.ActivePageIndex > 0);
  sbStatus.Repaint;
end;

procedure TCdNFTrans.pgMainChange(Sender: TObject);
var
  aForm: TfrmModel;
  aIdx : Integer;
begin
  aIdx  := pgMain.ActivePageIndex;
  if (aIdx = -1) then exit;
  if (aIdx = 0) then
    LoadTypeDocument([dtSimulator, dtDocument]);
  if (aIdx = 1) and (DocumentType = dtDocument) then
    LoadTypeDocument([dtDocument]);
  if (aIdx = 1) and (DocumentType = dtSimulator) then
    if (FSelectedPk = 0) then
      LoadTypeDocument([dtSimulator, dtDocument])
    else
      LoadTypeDocument([dtSimulator, dtOrderToDoc]);
  ShowAPage(pgMain.TabIndex);
  aForm := TfrmModel(pgMain.Pages[aIdx].Tag);
  if (aForm <> nil) and (aForm is TfrmModel) then
    aForm.Pk := FSelectedPk;
  if (FScrState in LOADING_MODE) and (pgMain.ActivePageIndex = 1) then
  begin
    ScrState       := dbmBrowse;
    aForm.ScrState := FScrState;
  end;
  ChangeState(Self, FScrState);
end;

procedure TCdNFTrans.ChangePk(Sender: TObject);
begin
  if (Sender is TfrmModel) then
  begin
    FSelectedPk := TfrmModel(Sender).Pk;
  end;
end;

procedure TCdNFTrans.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCdNFTrans.FormDestroy(Sender: TObject);
begin
  ClearPages;
end;

procedure TCdNFTrans.cbTypeDocSelect(Sender: TObject);
begin
  case pgMain.ActivePageIndex of
    0: SetSearchFormState(TfrmModel(pgMain.ActivePage.Tag));
    1: SetSimulatorFormState(TfrmModel(pgMain.ActivePage.Tag));
  end;
end;

procedure TCdNFTrans.SetSearchFormState(AForm: TfrmModel);
begin
  with TfrmSearch(AForm) do
    DocumentType := GetDocumentType;
end;

procedure TCdNFTrans.SetSimulatorFormState(AForm: TfrmModel);
begin
  with TCdSimulator(AForm) do
    DocumentType := GetDocumentType;
end;

procedure TCdNFTrans.tbSearchClick(Sender: TObject);
begin
  if (ScrState = dbmFind) then
  begin
    ScrState            := dbmExecute;
    tbSearch.ImageIndex := 90;
    tbSearch.Caption    := 'Filtrar';
    ScrState            := dbmBrowse;
  end
  else
  begin
    ScrState            := dbmFind;
    tbSearch.ImageIndex := 38;
    tbSearch.Caption    := 'Buscar';
  end;
end;

procedure TCdNFTrans.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmCancel;
  ScrState := dbmBrowse;
end;

procedure TCdNFTrans.pgMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (ScrState in SCROLL_MODE + LOADING_MODE);
end;

procedure TCdNFTrans.tbCalcClick(Sender: TObject);
var
  aForm: TfrmModel;
begin
  aForm := TfrmModel(PgMain.ActivePage.Tag);
  if (aForm <> nil) then
    TCdSimulator(aForm).CalcOrder := True;
end;

procedure TCdNFTrans.tbSaveClick(Sender: TObject);
begin
  ScrState := dbmPost;
  ScrState := dbmBrowse;
end;

procedure TCdNFTrans.tbDeleteClick(Sender: TObject);
begin
  ScrState := dbmDelete;
  ScrState := dbmBrowse;
end;

procedure TCdNFTrans.tbNewClick(Sender: TObject);
begin
  ScrState := dbmInsert;
end;

procedure TCdNFTrans.LoadTypeDocument(ATypes: TDocumentTypes);
var
  aTp, i: TDocumentType;
  aIdx  : Integer;
begin
  aIdx := 0; 
  aTp := DocumentType;
  cbTypeDoc.Items.Clear;
  for i := Low(TDocumentType) to High(TDocumentType) do
    if (i in ATypes) then
    begin
      if (i = aTp) then
        aIdx := cbTypeDoc.Items.AddObject(NAME_TDOC[i], TObject(Integer(i)))
      else
        cbTypeDoc.Items.AddObject(NAME_TDOC[i], TObject(Integer(i)));
    end;
  if (cbTypeDoc.Items.Count > 0) then
    cbTypeDoc.ItemIndex := aIdx;
end;

procedure TCdNFTrans.tbPrintClick(Sender: TObject);
begin
  Dados.ShowFormFromLib('SysRel', 'TfrmScreenReport', BeforePrintDocument);
end;

procedure TCdNFTrans.BeforePrintDocument(AForm: TForm; const AParams: TParamsForm);
var
  aData: TDataRow;
begin
  // Set all Properties to form
  if (AForm = nil) then
    raise Exception.Create('Impressão do Documento: Formulário de impressão não encontrado');
  aData := TDataRow.Create(Self);
  try
    // Set PkReport to load a Report and Main DataSet to not open it
    SetPropValue (AForm, 'PkReport', AParams.PkReport);
    SetPropValue (AForm, 'MainDataSet', 'qrDocument');
    // Set of Document data
    aData.Clear;
    aData.DataSetName := 'qrDocument';
    aData.AddAs('FkEmpresas', Dados.PkCompany, ftInteger, SizeOf(Integer));
    aData.AddAs('FkTipoDocumentos', dmSysTrans.FkTypeDocument, ftInteger, SizeOf(Integer));
    aData.AddAs('FkCadastros', dmSysTrans.FkCadastros, ftInteger, SizeOf(Integer));
    aData.AddAs('PkDocumentos', FSelectedPk, ftInteger, SizeOf(Integer));
    SetObjectProp(AForm, 'DataSetParams', aData);
    // Set of Company data
    aData.Clear;
    aData.DataSetName := 'qrCompany';
    aData.AddAs('PkEmpresas', Dados.PkCompany, ftInteger, SizeOf(Integer));
    SetObjectProp(AForm, 'DataSetParams', aData);
    // Set of Shipper Data data
    aData.Clear;
    aData.DataSetName := 'qrShipper';
    aData.AddAs('PkCadastros', dmSysTrans.FkShipper, ftInteger, SizeOf(Integer));
    SetObjectProp(AForm, 'DataSetParams', aData);
    // Set of Addressee Data data
    aData.Clear;
    aData.DataSetName := 'qrAddressee';
    aData.AddAs('PkCadastros', dmSysTrans.FkAddressee, ftInteger, SizeOf(Integer));
    SetObjectProp(AForm, 'DataSetParams', aData);
    // Set of Consignee Data data
    aData.Clear;
    aData.DataSetName := 'qrConsignee';
    aData.AddAs('PkCadastros', dmSysTrans.FkConsignee, ftInteger, SizeOf(Integer));
    SetObjectProp(AForm, 'DataSetParams', aData);
  finally
    FreeAndNil(aData);
  end;
end;

initialization
  RegisterClass(TCdNFTrans);

end.
