unit uReadTxt;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2006 by Alcindo Schleder. All rights reserved.           *}
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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, TSysMan, ProcUtils, VirtualTrees, StdCtrls,
  Mask, ToolEdit, PrcCombo, TSysSrvAux, Buttons, ProcType, DB, TextData,
  Menus, CurrEdit, GridRow;

type
  TErrorRecord = record
    FileName : string[100];
    PathFile : string[255];
    TypeOcc  : Integer;
    Line     : Integer;
    Error    : string[100];
    ErrorCode: Integer;
  end;

  TfrmMvReadTxt = class(TForm)
    pgMain: TPageControl;
    tsParameters: TTabSheet;
    tsSummary: TTabSheet;
    sbStatus: TStatusBar;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbClose: TToolButton;
    tbSepClose: TToolButton;
    tbNew: TToolButton;
    tbSepRead: TToolButton;
    tbRead: TToolButton;
    tbSepGen: TToolButton;
    tbProcess: TToolButton;
    lFkTypeOccurs: TStaticText;
    eFkTypeOccurs: TPrcComboBox;
    lSelDirectory: TStaticText;
    pgRead: TPageControl;
    tsProgress: TTabSheet;
    tsErrors: TTabSheet;
    lbSelFiles: TListBox;
    gbProcess: TGroupBox;
    lFilesProgress: TLabel;
    lRecordProgress: TLabel;
    lTotalRecords: TLabel;
    pbFiles: TProgressBar;
    pbRecords: TProgressBar;
    pbTotalRecords: TProgressBar;
    vtErrors: TVirtualStringTree;
    eSelDirectory: TDirectoryEdit;
    lStatus: TLabel;
    lFk_Squares: TStaticText;
    eFk_Squares: TPrcComboBox;
    lDtaIni: TStaticText;
    lDtaFin: TStaticText;
    eDtaIni: TDateEdit;
    eDtaFin: TDateEdit;
    bbFilter: TBitBtn;
    tsDetailLine: TTabSheet;
    vtLineDetail: TVirtualStringTree;
    pmLoadErrors: TPopupMenu;
    CarregarErrosdoDisco1: TMenuItem;
    eHorIni: TDateTimePicker;
    eHorFin: TDateTimePicker;
    lTotPer: TStaticText;
    eTotPer: TCurrencyEdit;
    pgSummary: TPageControl;
    tsAllData: TTabSheet;
    tsLanca: TTabSheet;
    vtSummary: TVirtualStringTree;
    vtLaunch: TVirtualStringTree;
    lTotLan: TStaticText;
    eTotLan: TCurrencyEdit;
    lAccounts: TStaticText;
    eAccounts: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pgReadChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tbCloseClick(Sender: TObject);
    procedure eFkTypeOccursSelect(Sender: TObject);
    procedure eSelDirectoryAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure tbReadClick(Sender: TObject);
    procedure tbNewClick(Sender: TObject);
    procedure eFk_SquaresSelect(Sender: TObject);
    procedure vtErrorsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtSummaryGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure pgMainChange(Sender: TObject);
    procedure eDtaIniAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure bbFilterClick(Sender: TObject);
    procedure pgMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tbProcessClick(Sender: TObject);
    procedure vtSummaryGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure eDtaFinAcceptDate(Sender: TObject; var ADate: TDateTime;
      var Action: Boolean);
    procedure vtErrorsExpanded(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtErrorsCollapsed(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vtErrorsDblClick(Sender: TObject);
    procedure vtLineDetailGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtSummaryBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure CarregarErrosdoDisco1Click(Sender: TObject);
    procedure pgReadChange(Sender: TObject);
    procedure vtLaunchNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure vtLaunchInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtLaunchEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vtLaunchChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtLaunchChecking(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var NewState: TCheckState; var Allowed: Boolean);
    procedure vtLaunchGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtLaunchGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vtLaunchBeforeItemErase(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure eAccountsSelect(Sender: TObject);
    procedure pgSummaryChanging(Sender: TObject; var AllowChange: Boolean);
  private
    { Private declarations }
    FActiveCompany: TCompany;
    FCompanyClick : Boolean;
    FRect         : TRect;
    FScrMode      : TDBMode;
    FTypeFiles    : string;
    FPathFiles    : string;
    FOccurs       : TTypeOccurs;
    FFkPracas     : Integer;
    FTotalErrors  : Integer;
    FProcessFile  : string;
    FDataLanCta   : TDataRow;
    procedure CreateDataIntoGridError(ALine: string; AErrorCode: Integer);
    procedure CreateDataIntoGridSummary;
    procedure CreateDataIntoGridLaunch;
    procedure SetScrMode(const Value: TDBMode);
    procedure SaveOccPas(ALine: string);
    procedure SaveChangeShift(ALine: string);
    procedure SaveMagneticCard(ALine: string);
    procedure SaveOther(ALine: string);
    procedure SaveCollect(ALine: string);
    function  GetDtaFin: TDateTime;
    function  GetDtaIni: TDateTime;
    procedure SetDataFin(const Value: TDateTime);
    procedure SetDataIni(const Value: TDateTime);
    function  InvoiceFinishAccount(const ADtaIni, ADtaFin: TDateTime;
                const AVlrLan: Double; const AFinalizer, ATypeAccount,
                AAccount: Integer): Integer;
    procedure SetGenerateFinance(const AFinalizer: Integer;
                const ADtaIni, ADtaFin: TDateTime);
    procedure SetStateParameters(AState: Boolean);
  public
    { Public declarations }
    property  ScrMode: TDBMode  read FScrMode  write SetScrMode;
    property  DtaIni: TDateTime read GetDtaIni write SetDataIni;
    property  DtaFin: TDateTime read GetDtaFin write SetDataFin;
  end;

var
  frmMvReadTxt: TfrmMvReadTxt;

implementation

{$R *.dfm}

uses Dado, SelEmpr, mSysBr, ArqSqlBr, FuncoesDB, DateUtils, TSysBcCx, Funcoes,
  Math, SqlExpr;

const
  STRING_ERRORS: array [0..8] of string =
    ('Linha convertida com Sucesso!', 'Tipo de ocorrência (%d) não encontrada!',
     'Praça (%d) não encontrada!', 'Pista (%d) não encontrada!',
     'Campo tipo de ocorrências (flag %d) inválido', 'Turno (%d) não encontrado!',
     'Operador (%d) não encontrado!', 'Valor da categoria (%s) não encontrada!',
     'Forma de Pagamento (%d) não encontrada!');

  COLLECT_COLUMNS: array [0..14] of string =
    ('id_trans', 'Instante', 'Pista', 'CatClass', 'EXClass', 'RDClass',
     'VEClass', 'FPag', 'CatDet', 'EF', 'ER', 'RD', 'VE', 'TTrans', 'NRec');

  MAGNETIC_CARD_COLUMNS: array [0..6] of string =
    ('id_trans', 'id_CrtMag', 'Pista', 'Instante', 'Status', 'Valor', 'Desconto');

  INVOICE_ERRORS: array [0..4] of string =
    ('Faturado!', 'Parâmetros inválidos!', 'Parâmetros do módulo não encontados!',
     'Erro na geração do número do documento!', 'Erro lendo deltalhes do produto');

  NAME_FOLDERS: array [0..2] of string =
    ('Lançamento de Dinheiro', 'Lançamento de Tickets Pós Pagos',
     'Lançamento de Tickets Pré Pagos');

function ConvertDateTime(S: string): TDateTime;
var
  aDay, aMonth,
  aYear: Word;
  aTime: TTime;
begin
  aDay   := StrToIntDef(Copy(S, 2, 2), 0);
  aMonth := StrToIntDef(Copy(S, 5, 2), 0);
  if (Length(S) > 19) then
    aYear  := StrToIntDef(Copy(S, 8, 4), 0)
  else
    aYear  := StrToIntDef('20' + Copy(S, 8, 2), 0);
  if (Length(S) > 19) then
    aTime  := StrToTimeDef(Copy(S, 13, 8), 0)
  else
    aTime  := StrToTimeDef(Copy(S, 11, 8), 0);
  Result := EncodeDate(aYear, aMonth, aDay);
  ReplaceTime(Result, aTime);
end;

procedure TfrmMvReadTxt.FormCreate(Sender: TObject);
begin
  FFkPracas                  := 0;
  FTypeFiles                 := '';
  tbTools.Images             := Dados.Image16;
  cbTools.Images             := Dados.Image16;
  FActiveCompany             := TCompany.Create;
  FActiveCompany.PkCompany   := Dados.PkCompany;
  FActiveCompany.DscEmp      := Dados.NameCompany;
  ScrMode                    := dbmBrowse;
  vtErrors.NodeDataSize      := SizeOf(TGridData);
  vtErrors.Images            := Dados.Image16;
  vtErrors.Header.Images     := Dados.Image16;
  vtSummary.NodeDataSize     := SizeOf(TGridData);
  vtSummary.Images           := Dados.Image16;
  vtSummary.Header.Images    := Dados.Image16;
  vtLaunch.NodeDataSize      := SizeOf(TGridData);
  vtLaunch.Images            := Dados.Image16;
  vtLaunch.Header.Images     := Dados.Image16;
  vtLineDetail.NodeDataSize  := SizeOf(TGridData);
  vtLineDetail.Images        := Dados.Image16;
  vtLineDetail.Header.Images := Dados.Image16;
  Caption                    := Application.Title;
  pgMain.ActivePageIndex     := 0;
  pgRead.ActivePageIndex     := 0;
  pgSummary.ActivePageIndex  := 0;
  tbRead.Enabled             := False;
  tbProcess.Enabled          := False;
  FOccurs                    := TTypeOccurs.Create;
  Dados.Image16.GetBitmap(38, bbFilter.Glyph);
end;

procedure TfrmMvReadTxt.FormDestroy(Sender: TObject);
begin
  FDataLanCta := nil;
  eFk_Squares.ReleaseObjects;
  eFkTypeOccurs.ReleaseObjects;
  ReleaseCombos(eAccounts, toObject);
  ReleaseTreeNodes(vtErrors);
  ReleaseTreeNodes(vtSummary);
  ReleaseTreeNodes(vtLineDetail);
  ReleaseTreeNodes(vtLaunch);
  if Assigned(FOccurs) then FreeAndNil(FOccurs);
end;

procedure TfrmMvReadTxt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (FScrMode in UPDATE_MODE) and (Dados.DisplayMessage('Há alterações não ' +
      'salvas. Deseja abandonar as alterações?', hiQuestion,
      [mbYes, mbNo]) = mrNo) then
    Action := caNone;
end;

procedure TfrmMvReadTxt.FormShow(Sender: TObject);
begin
  eFk_Squares.Items.AddStrings(dmSysBr.LoadSquares);
  eFkTypeOccurs.Items.AddStrings(dmSysBr.LoadTypeOccurs);
  eAccounts.Items.AddStrings(dmSysBr.LoadAccounts(atCash));
end;

procedure TfrmMvReadTxt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    Key := 0;
    Close;
  end;
end;

procedure TfrmMvReadTxt.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
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
  sbStatus.Repaint;
end;

procedure TfrmMvReadTxt.sbStatusDrawPanel(StatusBar: TStatusBar;
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
      IntToStr(FActiveCompany.PkCompany) + ' / ' + FActiveCompany.DscEmp);
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

procedure TfrmMvReadTxt.sbStatusMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TfrmMvReadTxt.SetScrMode(const Value: TDBMode);
begin
  if (FScrMode <> Value) then
  begin
    FScrMode := Value;
    sbStatus.Repaint;
  end;
end;

procedure TfrmMvReadTxt.pgReadChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (vtErrors.RootNodeCount > 0)
end;

procedure TfrmMvReadTxt.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMvReadTxt.eFkTypeOccursSelect(Sender: TObject);
var
  aIdx: Integer;
begin
  aIdx := eFkTypeOccurs.ItemIndex;
  if (aIdx > -1) and (eFkTypeOccurs.Items.Objects[aIdx] <> nil) then
  begin
    FOccurs.Assign(TTypeOccurs(eFkTypeOccurs.Items.Objects[aIdx]));
    FTypeFiles := FOccurs.PrefixFile + '*.*';
    eSelDirectory.Enabled := (FTypeFiles <> '') and (FFkPracas > 0);
  end;
end;

procedure TfrmMvReadTxt.eSelDirectoryAfterDialog(Sender: TObject;
  var Name: string; var Action: Boolean);
var
  aPesq  : TSearchRec;
  aTotLn ,
  aResult,
  aTotal : Integer;
  F      : TStrings;
begin
  try
    if (Name <> '') then
    begin
      if (Copy(Name, Length(Name), 1) <> '\') then
        Name := Name + '\';
      FPathFiles := Name;
      eSelDirectory.InitialDir := FPathFiles;
      Name := Name + FTypeFiles;
      aResult := FindFirst(Name, faAnyFile, aPesq);
      aTotal := 0;
      aTotLn := 0;
      while aResult = 0 do
      begin
        Inc(aTotal, 1);
        lbSelFiles.Items.Add(aPesq.Name);
        F := TStringList.Create;
        try
          F.LoadFromFile(FPathFiles + aPesq.Name);
          aTotLn := aTotLn + F.Count;
        finally
          FreeAndNil(F);
        end;
        aResult := FindNext(aPesq);
      end;
      lStatus.Font.Color := clWindowText;
      lStatus.Caption := 'Total de Arquivos: ' + IntToStr(aTotal) + ' com ' +
                           IntToStr(aTotLn) + ' registros.';
      pbTotalRecords.Max := aTotLn;
      pbFiles.Max        := aTotal;
    end;
  finally
    FindClose(aPesq);
  end;
  tbRead.Enabled := True;
end;

procedure TfrmMvReadTxt.tbReadClick(Sender: TObject);
var
  i, j   : Integer;
  F      : TStrings;
  aHorIni,
  aHorFin: TTime;
  aFS    : TFileStream;
  aRec   : TErrorRecord;
  Node   : PVirtualNode;
  Data   : PGridData;
  aFn    : string;
  aPath  : string;
begin
  pbFiles.Position        := 0;
  pbRecords.Position      := 0;
  pbTotalRecords.Position := 0;
  DtaIni                  := Now - 1;
  DtaFin                  := Now;
  aHorIni                 := Time;
  FProcessFile            := '';
  FTotalErrors            := 0;
  Cursor                  := crHourGlass;
  with dmSysBr do
  begin
    if qrOccurrency.Active then qrOccurrency.Close;
    qrOccurrency.SQL.Clear;
    qrOccurrency.SQL.Add(SqlInsOccurence);
    Dados.StartTransaction(qrOccurrency);
  end;
  try
    for i := 0 to lbSelFiles.Items.Count - 1 do
    begin
      lbSelFiles.ItemIndex := i;
      F := TStringList.Create;
      try
        F.LoadFromFile(FPathFiles + lbSelFiles.Items[i]);
        pbRecords.Max := F.Count;
        for j := 0 to F.Count - 1 do
        begin
          pbRecords.Position      := pbRecords.Position + 1;
          pbTotalRecords.Position := pbTotalRecords.Position + 1;
          case FOccurs.FlagTOcr of
            otOccPass     : SaveOccPas(F.Strings[j]);
            otChangeShift : SaveChangeShift(F.Strings[j]);
            otMagneticCard: SaveMagneticCard(F.Strings[j]);
            otOther       : SaveOther(F.Strings[j]);
            otCollect     : SaveCollect(F.Strings[j]);
          end;
          pbRecords.Refresh;
          pbTotalRecords.Refresh;
        end;
      finally
        FreeAndNil(F);
        pbRecords.Position := 0;
        pbFiles.Position   := pbFiles.Position + 1;
        pbFiles.Refresh;
        lbSelFiles.Refresh;
      end;
    end;
    aHorFin := Time;
    aHorIni := aHorFin - aHorIni;
    lStatus.Font.Color := clWindowText;
    lStatus.Caption := IntToStr(pbTotalRecords.Position) + ' linhas lidas ' +
      ' em ' + IntToStr(pbFiles.Position) + ' arquivos, com um tempo de ' +
      TimeToStr(aHorIni);
    if (FTotalErrors > 0) then
      lStatus.Caption := lStatus.Caption + NL +
                         Format('Encontrados %d erros!', [FTotalErrors]);
    tbRead.Enabled := False;
  finally
    Cursor := crDefault;
    if dmSysBr.qrOccurrency.Active then dmSysBr.qrOccurrency.Close;
    Dados.CommitTransaction(dmSysBr.qrOccurrency);
  end;
  CreateDataIntoGridSummary;
  lFk_Squares.Enabled   := False;
  eFk_Squares.Enabled   := False;
  lFkTypeOccurs.Enabled := False;
  eFkTypeOccurs.Enabled := False;
  lSelDirectory.Enabled := False;
  eSelDirectory.Enabled := False;
  if (vtErrors.RootNodeCount > 0) then
  begin
    if (not DirectoryExists('.\Temp\')) then
      MkDir('.\Temp\');
    aFS := TFileStream.Create('.\Temp\' + FormatDateTime('dd_mm_yyyy_hh_mm_ss_', Now) +
      'errors.dat', fmCreate);
    try
      Node := vtErrors.GetFirst;
      while (Node <> nil) do
      begin
        Data := vtErrors.GetNodeData(Node);
        if (Data <> nil) and (Data^.DataRow <> nil) then
        begin
          FillChar(aRec, SizeOf(TErrorRecord), 0);
          if (vtErrors.GetNodeLevel(Node) = 0) then
          begin
            aFN            := Data^.DataRow.FieldByName['FILE_NAME'].AsString;
            aPath          := Data^.DataRow.FieldByName['PATH_FILE'].AsString;
          end
          else
          begin
            aRec.TypeOcc   := Integer(FOccurs.FlagTOcr);
            aRec.FileName  := aFN;
            aRec.PathFile  := aPath;
            aRec.Error     := Data^.DataRow.FieldByName['ERROR'].AsString;
            aRec.ErrorCode := Data^.DataRow.FieldByName['ERROR_CODE'].AsInteger;
            aRec.Line      := Data^.DataRow.FieldByName['LINE'].AsInteger;
            aFS.WriteBuffer(aRec, SizeOf(TErrorRecord));
          end;
        end;
        Node := vtErrors.GetNext(Node);
      end;
    finally
      FreeAndNil(aFS);
    end;
  end;
end;

procedure TfrmMvReadTxt.tbNewClick(Sender: TObject);
begin
  pbFiles.Position        := 0;
  pbRecords.Position      := 0;
  pbTotalRecords.Position := 0;
  pbFiles.Max             := 0;
  pbRecords.Max           := 0;
  pbTotalRecords.Max      := 0;
  lFk_Squares.Enabled     := True;
  eFk_Squares.Enabled     := True;
  lFkTypeOccurs.Enabled   := True;
  eFkTypeOccurs.Enabled   := True;
  lSelDirectory.Enabled   := True;
  eSelDirectory.Enabled   := True;
  eFk_Squares.ItemIndex   := -1;
  eFkTypeOccurs.ItemIndex := -1;
  eSelDirectory.Text      := '';
  lbSelFiles.Items.Clear;
end;

procedure TfrmMvReadTxt.CreateDataIntoGridError(ALine: string; AErrorCode: Integer);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (FProcessFile <> lbSelFiles.Items[lbSelFiles.ItemIndex]) then
  begin
    FProcessFile := lbSelFiles.Items[lbSelFiles.ItemIndex];
    Node := vtErrors.AddChild(nil);
    if (Node <> nil) then
    begin
      Data          := vtErrors.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Node    := Node;
        Data^.Level   := vtErrors.GetNodeLevel(Node);
        Data^.DataRow := TDataRow.Create(nil);
        Data^.DataRow.AddAs('FILE_NAME', FProcessFile, ftString, SizeOf(FProcessFile));
        Data^.DataRow.AddAs('PATH_FILE', FPathFiles, ftString, SizeOf(FPathFiles));
      end;
    end;
    vtErrors.FocusedNode := Node;
   end;
   if (vtErrors.FocusedNode <> nil) then
   begin
    Node := vtErrors.AddChild(vtErrors.FocusedNode);
    if (Node <> nil) then
    begin
      Data := vtErrors.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Node    := Node;
        Data^.Level   := vtErrors.GetNodeLevel(Node);
        Data^.DataRow := TDataRow.Create(nil);
        Data^.DataRow.AddAs('LINE', pbRecords.Position, ftInteger, SizeOf(Integer));
        Data^.DataRow.AddAs('ERROR', ALine, ftString, SizeOf(ALine));
        Data^.DataRow.AddAs('ERROR_CODE', AErrorCode, ftInteger, SizeOf(Integer));
        Inc(FTotalErrors);
      end;
    end;
  end;
end;

procedure TfrmMvReadTxt.SaveChangeShift(ALine: string);
begin

end;

procedure TfrmMvReadTxt.SaveCollect(ALine: string);
var
  S, F: string;
  i   ,
  aPst: Integer;
  aFpg: Integer;
  aDta: TDateTime;
  aCat: string;
begin
  if (ALine = 'BOF') or (ALine = 'EOF') or (Pos('Pista;', ALine) > 0) then
    exit;
// id_trans;Instante;           Pista;CatClass;EXClass;RDClass;VEClass;FPag;CatDet;EF;ER;RD;VE;TTrans;NRec;
// 3654373; '08/12/05 19:03:41';1    ;1       ;0      ;0      ;1      ;1   ;1     ;0 ;0 ;0 ;1 ;43    ;0   ;
  with dmSysBr do
  begin
    F := ALine;
    S := Copy(ALine, 1, Pos(';', ALine) - 1);
    Delete(ALine, 1, Pos(';', ALine));
    qrOccurrency.ParamByName('FkTipoOcorrencias').AsInteger    := FOccurs.PkTypeOccurs;
    qrOccurrency.ParamByName('PkPracasOcorrencias').AsInteger  := StrToIntDef(S, 0);
    qrOccurrency.ParamByName('FkEmpresas').AsInteger           := Dados.PkCompany;
    qrOccurrency.ParamByName('FkPracas').AsInteger             := FFkPracas;
    S := Copy(ALine, 1, Pos(';', ALine) - 1);
    Delete(ALine, 1, Pos(';', ALine));
    S := StringReplace(S, '''', '', [rfReplaceAll]);
    ShortDateFormat := 'mm/dd/yy';
    aDta := StrToDateTime(S);
    ShortDateFormat := 'dd/mm/yyyy';
    if (DtaIni < aDta) then DtaIni := aDta;
    if (DtaFin > aDta) then DtaFin := aDta;
    qrOccurrency.ParamByName('DthrOcr').AsDateTime             := aDta;
    S := Copy(ALine, 1, Pos(';', ALine) - 1);
    Delete(ALine, 1, Pos(';', ALine));
    aPst := StrToIntDef(S, 0);
    qrOccurrency.ParamByName('FkPracasPistas').AsInteger       := aPst;
    qrOccurrency.ParamByName('FkTipoTurnos').AsInteger         := 0;
    qrOccurrency.ParamByName('FkPracasOperadores').AsInteger   := 0;
    S := Copy(ALine, 1, Pos(';', ALine) -1);
    Delete(ALine, 1, Pos(';', ALine));
    aCat := S;
    qrOccurrency.ParamByName('FkCategoriasProdutos').AsInteger := StrToIntDef(S, 0);
    for i := 1 to 3 do
      Delete(ALine, 1, Pos(';', ALine));
    S := Copy(ALine, 1, Pos(';', ALine) -1);
    Delete(ALine, 1, Pos(';', ALine));
    aFpg := StrToIntDef(S, 0);
    qrOccurrency.ParamByName('FkFinalizadoras').AsInteger      := aFpg;
    qrOccurrency.ParamByName('FlagTOcr').AsInteger             := Ord(FOccurs.FlagTOcr);
    qrOccurrency.ParamByName('SttPas').AsInteger               := 0;
    qrOccurrency.ParamByName('VlrOcc').AsFloat                 := 0.0;
    qrOccurrency.ParamByName('DsctPass').AsFloat               := 0.0;
    try
      if (not qrOccurrency.Active) then qrOccurrency.Open;
      if (qrOccurrency.FieldByName('R_STATUS').AsInteger <> 0) then
      begin
        lStatus.Font.Color := clRed;
        i := qrOccurrency.FieldByName('R_STATUS').AsInteger;
        case i of
          1: S := Format(STRING_ERRORS[i], [FOccurs.PkTypeOccurs]);
          2: S := Format(STRING_ERRORS[i], [FFkPracas]);
          3: S := Format(STRING_ERRORS[i], [aPst]);
          4: S := Format(STRING_ERRORS[i], [Ord(FOccurs.FlagTOcr)]);
          5: S := Format(STRING_ERRORS[i], [0]);
          6: S := Format(STRING_ERRORS[i], [0]);
          7: S := Format(STRING_ERRORS[i], [aCat]);
          8: S := Format(STRING_ERRORS[i], [aFpg]);
        end;
        lStatus.Caption := Format('Erro (%d): %s ', [i, S]);
        lStatus.Refresh;
        CreateDataIntoGridError(lStatus.Caption, i);
      end;
      if (qrOccurrency.Active) then qrOccurrency.Close;
    except on E:Exception do
      begin
        lStatus.Font.Color := clRed;
        lStatus.Caption := 'Erro (-9): ' + E.Message;
        lStatus.Refresh;
        CreateDataIntoGridError(lStatus.Caption, -9);
      end;
    end;
  end;
end;

procedure TfrmMvReadTxt.SaveMagneticCard(ALine: string);
begin

end;

procedure TfrmMvReadTxt.SaveOccPas(ALine: string);
begin

end;

procedure TfrmMvReadTxt.SaveOther(ALine: string);
begin

end;

procedure TfrmMvReadTxt.eFk_SquaresSelect(Sender: TObject);
begin
  SetStateParameters(False);
  FFkPracas := 0;
  with eFk_Squares do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      FFkPracas := Integer(Items.Objects[ItemIndex]);
    eSelDirectory.Enabled := (FTypeFiles <> '') and (FFkPracas > 0);
  end;
  lFk_Squares.Caption := 'Selecione a Praca: ';
  if (FFkPracas > 0) then
    lFk_Squares.Caption := lFk_Squares.Caption + Format('(%d) ', [FFkPracas]);
end;

procedure TfrmMvReadTxt.vtErrorsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := 'Arquivo: ' + Data^.DataRow.FieldByName['FILE_NAME'].AsString;
    1: CellText := 'Linha '  + Data^.DataRow.FieldByName['LINE'].AsString + ':' +
                   Data^.DataRow.FieldByName['ERROR'].AsString
  end;
end;

procedure TfrmMvReadTxt.CreateDataIntoGridSummary;
var
  Node   : PVirtualNode;
  Data   : PGridData;
  aDtaIni: TDateTime;
  aDtaFin: TDateTime;
begin
  eTotPer.Value := 0;
  ReleaseTreeNodes(vtSummary);
  with dmSysBr, vtSummary do
  begin
    if qrOccurrency.Active then qrOccurrency.Close;
    qrOccurrency.SQL.Clear;
    qrOccurrency.SQL.Add(SqlShowFinance);
    Dados.StartTransaction(qrOccurrency);
    BeginUpdate;
    try
      qrOccurrency.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      qrOccurrency.ParamByName('FkPracas').AsInteger   := FFkPracas;
      aDtaIni := DtaIni;
      aDtaFin := DtaFin;
      ReplaceTime(aDtaIni, eHorIni.Time);
      ReplaceTime(aDtaFin, eHorFin.Time);
      qrOccurrency.ParamByName('DtaIni').AsDateTime    := aDtaIni;
      qrOccurrency.ParamByName('DtaFin').AsDateTime    := aDtaFin;
      if (not qrOccurrency.Active) then qrOccurrency.Open;
      if (not qrOccurrency.IsEmpty) then
      begin
        eDtaIni.Date := DateOf(qrOccurrency.FieldByName('DTHR_INI').AsDateTime);
        eDtaFin.Date := DateOf(qrOccurrency.FieldByName('DTHR_FIN').AsDateTime);
      end;
      while (not qrOccurrency.Eof) do
      begin
        Node := AddChild(nil);
        if (Node <> nil) then
        begin
          Data := GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Node    := Node;
            Data^.Level   := GetNodeLevel(Node);
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrOccurrency, True);
          end;
        end;
        eTotPer.Value := eTotPer.Value + qrOccurrency.FieldByName('VLR_OCC').AsFloat;
        qrOccurrency.Next;
      end;
    finally
      EndUpdate;
      if qrOccurrency.Active then qrOccurrency.Close;
      Dados.CommitTransaction(qrOccurrency);
    end;
  end;
end;

procedure TfrmMvReadTxt.CreateDataIntoGridLaunch;
var
  PNode: PVirtualNode;
  PData: PGridData;
  aTRow: Integer;
  aFlag: Integer;
  function AddNode(ANode: PVirtualNode; const AType: TTypeNode): PVirtualNode;
  begin
    Result := vtLaunch.AddChild(ANode);
    if (Result <> nil) then
    begin
      PData := vtLaunch.GetNodeData(Result);
      if (PData <> nil) then
      begin
        PData^.Level    := vtLaunch.GetNodeLevel(Result);
        PData^.Node     := Result;
        PData^.NodeType := AType;
        PData^.DataRow  := TDataRow.CreateFromDataSet(nil, dmSysBr.qrSqlAux, True);
        if (aTRow = 0) then
          PData^.DataRow.FieldByName['DSC_TROW'].AsString := NAME_FOLDERS[0];
        if (aTRow = 9) then
          PData^.DataRow.FieldByName['DSC_TROW'].AsString := NAME_FOLDERS[aFlag + 1];
      end;
    end;
  end;
begin
  PNode := nil;
  ReleaseTreeNodes(vtLaunch);
  with dmSysBr do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlAccounts);
    aTRow := -1;
    aFlag := -1;
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      if not qrSqlAux.Active then qrSqlAux.Open;
      while not qrSqlAux.Eof do
      begin
        if (aTRow <> qrSqlAux.FieldByName('ROW_TYPE').AsInteger) or
           ((aTRow = 9) and (aFlag <> qrSqlAux.FieldByName('FLAG_TTICKET').AsInteger)) then
        begin
          aTRow := qrSqlAux.FieldByName('ROW_TYPE').AsInteger;
          if (aTRow = 9) and (aFlag <> qrSqlAux.FieldByName('FLAG_TTICKET').AsInteger) then
            aFlag := qrSqlAux.FieldByName('FLAG_TTICKET').AsInteger;
          PNode := AddNode(nil, tnFolder);
        end;
        if (PNode <> nil) then
          AddNode(PNode, tnData);
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
  if (vtLaunch.RootNodeCount > 0) then
  begin
    PNode := vtLaunch.GetFirst;
    if (PNode <> nil) then
    begin
      PNode := vtLaunch.GetFirstChild(PNode);
      if (PNode <> nil) then
      begin
        vtLaunch.FocusedNode     := PNode;
        vtLaunch.Selected[PNode] := True;
      end;
    end;
  end;
  vtLaunch.FullExpand;
end;

procedure TfrmMvReadTxt.vtSummaryGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Format('%s de: %s até: %s',
                   [Data^.DataRow.FieldByName['DSC_PRC'].AsString,
                    DateTimeToStr(Data^.DataRow.FieldByName['DTHR_INI'].AsDateTime),
                    DateTimeToStr(Data^.DataRow.FieldByName['DTHR_FIN'].AsDateTime)]);
    1: CellText := Data^.DataRow.FieldByName['DSC_MPGT'].AsString;
    2: CellText := FloatToStrF(Data^.DataRow.FieldByName['VLR_OCC'].AsFloat,
                     ffNumber, 7, Dados.DecimalPlaces);
  end;
end;

procedure TfrmMvReadTxt.pgMainChange(Sender: TObject);
begin
  if (DtaIni = 0) then DtaIni := Now - 1;
  if (DtaFin = 0) then DtaFin := Now;
end;

procedure TfrmMvReadTxt.eDtaIniAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
  if (ADate > DtaFin) then ADate := DtaFin;
end;

procedure TfrmMvReadTxt.bbFilterClick(Sender: TObject);
begin
  CreateDataIntoGridSummary;
  if (vtSummary.RootNodeCount > 0) then
    CreateDataIntoGridLaunch;
end;

procedure TfrmMvReadTxt.pgMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (FFkPracas = 0) then
  begin
    AllowChange := False;
    Dados.DisplayHint(eFk_Squares, 'Para visualizar o financeiro deve selecionar ' +
      'uma praça antes!');
  end;
end;

procedure TfrmMvReadTxt.tbProcessClick(Sender: TObject);
var
  Node    : PVirtualNode;
  Data    : PGridData;
  aDtaIni : TDateTime;
  aDtaFin : TDateTime;
  aResult : Integer;
  aFinish : Integer;
  aHdlChd : Boolean;
  aValue  : Double;
begin
  // Set records of summary as launch into finance module
  aHdlChd           := False;
  tbProcess.Enabled := False;
  if (vtSummary.RootNodeCount = 0) then exit;
  with vtSummary do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data <> nil) or (Data^.DataRow <> nil) then
      begin
        if (Data^.Level = 0) and (Node.CheckState = csCheckedNormal) and
           (Data^.DataRow.FieldByName['STATUS'].AsInteger = Ord(dbmEdit)) then
        begin
          aDtaIni := Data^.DataRow.FieldByName['DTHR_INI'].AsDateTime;
          aDtaFin := Data^.DataRow.FieldByName['DTHR_FIN'].AsDateTime;
          aFinish := Data^.DataRow.FieldByName['FK_FINALIZADORAS'].AsInteger;
          Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmDelete); // Set Delete Status
          aValue := 0;
          // looping to get all childs
          Node := GetFirstChild(Node);
          while ((Node <> nil) and (GetNodeLevel(Node) > 0)) do
          begin
            aHdlChd := True;
            Data := GetNodeData(Node);
            if (GetNodeLevel(Node) = 2) and
               (Node.CheckState = csCheckedNormal) and
               (Data <> nil) and (Data^.DataRow <> nil) and
               (Data^.DataRow.FieldByName['STATUS'].AsInteger = Ord(dbmEdit)) and
               (Data^.DataRow.FieldByName['VLR_LAN'].AsFloat > 0) then
            begin
              aValue := aValue + Data^.DataRow.FieldByName['VLR_LAN'].AsFloat;
              aResult := InvoiceFinishAccount(aDtaIni, aDtaFin,
                           Data^.DataRow.FieldByName['VLR_LAN'].AsFloat, aFinish,
                           Data^.DataRow.FieldByName['PK_TIPO_CONTAS'].AsInteger,
                           Data^.DataRow.FieldByName['PK_CONTAS'].AsInteger);
              if (aResult <> 0) then
              begin
                Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmCancel); // Set Cancel Status
                Data^.DataRow.AddAs('R_STATUS', aResult, ftInteger, SizeOf(Integer)); // Set Result Status into Node
                Data^.DataRow.FieldByName['DSC_CTA'].AsString :=
                  Format('(%d - %s) %s', [Data^.DataRow.FieldByName['R_STATUS'].AsInteger,
                    INVOICE_ERRORS[Data^.DataRow.FieldByName['R_STATUS'].AsInteger],
                    Data^.DataRow.FieldByName['DSC_PRC'].AsString]);
                if (RootNode <> nil) then
                begin
                  Data := GetNodeData(RootNode);
                  if (Data <> nil) and (Data^.DataRow <> nil) then
                  begin
                    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmCancel);
                    Data^.DataRow.AddAs('R_STATUS', aResult, ftInteger, SizeOf(Integer)); // Set Result Status into Node
                    Data^.DataRow.FieldByName['DSC_PRC'].AsString :=
                      Format('(%d - %s) %s', [Data^.DataRow.FieldByName['R_STATUS'].AsInteger,
                        INVOICE_ERRORS[Data^.DataRow.FieldByName['R_STATUS'].AsInteger],
                        Data^.DataRow.FieldByName['DSC_PRC'].AsInteger]);
                  end;
                end;
                exit;
              end // end of Result test
              else
              begin
                Data^.DataRow.AddAs('R_STATUS', aResult, ftInteger, SizeOf(Integer)); // Set Result Status into Node
                Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmDelete);  // Set Delete Status
                Data^.DataRow.FieldByName['DSC_CTA'].AsString :=
                  Format('%s(%s)', [Data^.DataRow.FieldByName['DSC_PRC'].AsString,
                    INVOICE_ERRORS[Data^.DataRow.FieldByName['R_STATUS'].AsInteger]]);
              end;
            end // end of handler node level 2
            else
              if (GetNodeLevel(Node) = 2) and
                 (Data <> nil) and (Data^.DataRow <> nil) and
                 (Data^.DataRow.FieldByName['STATUS'].AsInteger = Ord(dbmEdit)) then
              begin
                Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmDelete);  // Set Delete Status
                aValue := aValue + Data^.DataRow.FieldByName['VLR_LAN'].AsFloat;
              end;
            Node := GetNext(Node);
          end; // end of while child node
          if (aValue = 0) then
            SetGenerateFinance(aFinish, aDtaIni, aDtaFin);
        end; // end of handler node level 0
      end; // end of Data test
      if (not aHdlChd) then
        Node := GetNext(Node);
      aHdlChd := False;
    end; // end of while grid
  end; // end of with
  vtSummary.Refresh;
end;

function TfrmMvReadTxt.InvoiceFinishAccount(const ADtaIni, ADtaFin: TDateTime;
  const AVlrLan: Double; const AFinalizer, ATypeAccount, AAccount: Integer): Integer;
begin
  Result := 0;
  with dmSysBr do
  begin
    if qrOccurrency.Active then qrOccurrency.Close;
    qrOccurrency.SQL.Clear;
    qrOccurrency.SQL.Add(SqlGenFinance);
    Dados.StartTransaction(qrOccurrency);
    try
      qrOccurrency.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
      qrOccurrency.ParamByName('FkPracas').AsInteger        := FFkPracas;
      qrOccurrency.ParamByName('FkFinalizadoras').AsInteger := AFinalizer;
      qrOccurrency.ParamByName('FkTipoContas').AsInteger    := ATypeAccount;
      qrOccurrency.ParamByName('FkContas').AsInteger        := AAccount;
      qrOccurrency.ParamByName('DtaIni').AsDateTime         := ADtaIni;
      qrOccurrency.ParamByName('DtaFin').AsDateTime         := ADtaFin;
      qrOccurrency.ParamByName('VlrOcc').AsFloat            := AVlrLan;
      if (not qrOccurrency.Active) then qrOccurrency.Open;
      Result := qrOccurrency.FieldByName('R_STATUS').AsInteger;
    finally
      if qrOccurrency.Active then qrOccurrency.Close;
      if (Result = 0) then
        Dados.CommitTransaction(qrOccurrency)
      else
        Dados.RollbackTransaction(qrOccurrency);
    end;
  end;
end;

procedure TfrmMvReadTxt.SetGenerateFinance(const AFinalizer: Integer;
                const ADtaIni, ADtaFin: TDateTime);
begin
  with dmSysBr do
  begin
    if qrOccurrency.Active then qrOccurrency.Close;
    qrOccurrency.SQL.Clear;
    qrOccurrency.SQL.Add(SqlUpdateOcc);
    Dados.StartTransaction(qrOccurrency);
    try
      qrOccurrency.ParamByName('FkEmpresas').AsInteger      := Dados.PkCompany;
      qrOccurrency.ParamByName('FkPracas').AsInteger        := FFkPracas;
      qrOccurrency.ParamByName('FkFinalizadoras').AsInteger := AFinalizer;
      qrOccurrency.ParamByName('DtHrIni').AsDateTime        := ADtaIni;
      qrOccurrency.ParamByName('DtHrFin').AsDateTime        := ADtaFin;
      qrOccurrency.ExecSQL;
      Dados.CommitTransaction(qrOccurrency);
    except on E:Exception do
      begin
        if qrOccurrency.Active then qrOccurrency.Close;
        Dados.RollbackTransaction(qrOccurrency);
        raise Exception.Create('SetGenerateFinance: Erro ao atualizar as ocorrências' + NL +
          E.Message);
      end;
    end;
  end;
end;

procedure TfrmMvReadTxt.vtSummaryGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if (Node = nil) or (Column > 0) then exit;
  if (Kind in [ikSelected, ikNormal]) then
    ImageIndex := 47;
end;

procedure TfrmMvReadTxt.eDtaFinAcceptDate(Sender: TObject;
  var ADate: TDateTime; var Action: Boolean);
begin
  if (ADate < DtaIni) then ADate := DtaIni;
end;

function TfrmMvReadTxt.GetDtaFin: TDateTime;
begin
  Result := eDtaFin.Date;
end;

function TfrmMvReadTxt.GetDtaIni: TDateTime;
begin
  Result := eDtaIni.Date;
end;

procedure TfrmMvReadTxt.SetDataFin(const Value: TDateTime);
begin
  eDtaIni.Date := Value;
end;

procedure TfrmMvReadTxt.SetDataIni(const Value: TDateTime);
begin
  eDtaFin.Date := Value;
end;

procedure TfrmMvReadTxt.vtErrorsExpanded(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  Sender.FullExpand;
end;

procedure TfrmMvReadTxt.vtErrorsCollapsed(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  Sender.FullCollapse;
end;

procedure TfrmMvReadTxt.vtErrorsDblClick(Sender: TObject);
var
  aRot : Boolean;
  aFN  : string;
  aPath: string;
  aFile: TStrings;
  aLin : Integer;
  aCode: Integer;
  Data : PGridData;
  Node : PVirtualNode;
  S    : string;
  procedure SetGridHeader(const AColumns: array of string);
  var
    i: Integer;
  begin
    with vtLineDetail.Header do
    begin
      Columns.Clear;
      for i := Low(AColumns) to High(AColumns) do
        with Columns.Add do
        begin
          Text := AColumns[i];
          if ((Canvas.TextWidth(AColumns[i]) + 20) > 50) then
            Width := Canvas.TextWidth(AColumns[i]) + 20;
        end;
    end;
  end;

  function  AddLine(const AColumns: array of string; ALine: string): PVirtualNode;
  var
    AData: PGridData;
    i    : Integer;
  begin
    with vtLineDetail do
    begin
      Result := AddChild(nil);
      if (Result = nil) then exit;
      AData := GetNodeData(Result);
      if (AData = nil) then exit;
      AData^.DataRow := TDataRow.Create(nil);
      AData^.Level   := 0;
      AData^.Node    := Result;
      for i := Low(AColumns) to HIGH(AColumns) do
      begin
        S := Copy(ALine, 1, Pos(';', ALine) - 1);
        Delete(ALine, 1, Pos(';', ALine));
        AData^.DataRow.AddAs(AColumns[i], S, ftString, Length(S) + 1)
      end;
    end;
  end;

  procedure GetDataAndSetDetail;
  begin
    with vtErrors do
    begin
      Data := GetNodeData(Node);
      if (Data <> nil) or (Data^.DataRow <> nil) then
      begin
        aLin  := Data^.DataRow.FieldByName['LINE'].AsInteger;
        aCode := Data^.DataRow.FieldByName['ERROR_CODE'].AsInteger;
        case FOccurs.FlagTOcr of
          otOccPass     : ;
          otChangeShift : ;
          otMagneticCard: AddLine(MAGNETIC_CARD_COLUMNS, aFile.Strings[aLin - 1]);
          otOther       : ;
          otCollect     : AddLine(COLLECT_COLUMNS, aFile.Strings[aLin - 1]);
        end;
      end;
    end;
  end;

begin
  ReleaseTreeNodes(vtLineDetail);
  with vtErrors do
  begin
    if (FocusedNode = nil) then exit;
    case FOccurs.FlagTOcr of
      otOccPass     : ;
      otChangeShift : ;
      otMagneticCard: SetGridHeader(MAGNETIC_CARD_COLUMNS);
      otOther       : ;
      otCollect     : SetGridHeader(COLLECT_COLUMNS);
    end;
    if (GetNodeLevel(FocusedNode) = 0) then
    begin
      Data := GetNodeData(FocusedNode);
      if (Data = nil) or (Data^.DataRow = nil) then exit;
      aFN   := Data^.DataRow.FieldByName['FILE_NAME'].AsString;
      aPath := Data^.DataRow.FieldByName['PATH_FILE'].AsString;
      tsDetailLine.Caption := Format('Detalhamento do arquivo %s', [aFN]);
      aRot := True;
    end
    else
    begin
      if (FocusedNode.Parent = nil) then exit;
      Data := GetNodeData(FocusedNode.Parent);
      if (Data = nil) or (Data^.DataRow = nil) then exit;
      aFN := Data^.DataRow.FieldByName['FILE_NAME'].AsString;
      aPath := Data^.DataRow.FieldByName['PATH_FILE'].AsString;
      Data := GetNodeData(FocusedNode);
      if (Data = nil) or (Data^.DataRow = nil) then exit;
      aLin := Data^.DataRow.FieldByName['LINE'].AsInteger;
      tsDetailLine.Caption := Format('Detalhamento da linha %d do arquivo %s', [aLin, aFN]);
      aRot := False;
    end;
    tsDetailLine.TabVisible := True;
    aFile := TStringList.Create;
    vtLineDetail.BeginUpdate;
    try
      aFile.LoadFromFile(aPath + aFN);
      if aRot then
      begin
        Node := GetFirstChild(FocusedNode);
        while ((Node <> nil) and (GetNodeLevel(Node) > 0)) do
        begin
          GetDataAndSetDetail;
          Node := GetNext(Node);
        end;
      end
      else
      begin
        Node := FocusedNode;
        if (Node <> nil) then
          GetDataAndSetDetail;
      end;
    finally
      vtLineDetail.EndUpdate;
      aFile.Clear;
      FreeAndNil(aFile);
    end;
  end;
end;

procedure TfrmMvReadTxt.vtLineDetailGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.Fields[Column].AsString;
end;

procedure TfrmMvReadTxt.vtSummaryBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if (Node = nil) then exit;
  if Odd(vtSummary.AbsoluteIndex(Node)) then
    ItemColor := clInfoBk
  else
    ItemColor := clMoneyGreen;
  EraseAction := eaColor;
end;

procedure TfrmMvReadTxt.CarregarErrosdoDisco1Click(Sender: TObject);
var
  aFS : TFileStream;
  Node: PVirtualNode;
  Data: PGridData;
  aPos: Integer;
  aRec: TErrorRecord;
  aFN : string;
  aFD : TOpenDialog;
  function AddDataNode(Node: PVirtualNode): PVirtualNode;
  begin
    Result := vtErrors.AddChild(Node);
    if (Result <> nil) then
    begin
      Data := vtErrors.GetNodeData(Result);
      if (Data <> nil) then
      begin
        Data^.Node    := Result;
        Data^.Level   := vtErrors.GetNodeLevel(Result);
        Data^.DataRow := TDataRow.Create(nil);
        if (Data^.Level = 0) then
        begin
          Data^.DataRow.AddAs('FILE_NAME', aRec.FileName, ftString, SizeOf(aRec.FileName));
          Data^.DataRow.AddAs('PATH_FILE', aRec.PathFile, ftString, SizeOf(aRec.PathFile));
        end
        else
        begin
          Data^.DataRow.AddAs('LINE', aRec.Line, ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('ERROR', aRec.Error, ftString, SizeOf(aRec.Error));
          Data^.DataRow.AddAs('ERROR_CODE', aRec.ErrorCode, ftInteger, SizeOf(Integer));
        end
      end;
    end;
  end;
begin
  aFN := '';
  Node := nil;
  aFD := TOpenDialog.Create(Self);
  try
    aFD.Filter := 'arquivos de dados|*.dat';
    if aFD.Execute then
      aFS := TFileStream.Create(aFD.FileName, fmOpenRead);
  finally
    FreeandNil(aFD);
  end;
  if (aFS = nil) then exit;
  vtErrors.BeginUpdate;
  try
    aPos := 0;
    aFS.Position := 0;
    while (aPos < aFS.Size) do
    begin
      aPos := aPos + aFS.Read(aRec, SizeOf(TErrorRecord));
      if (aFN <> aRec.FileName) then
        Node := AddDataNode(nil);
      AddDataNode(Node);
      aFN := aRec.FileName;
    end;
    if (FOccurs = nil) then
      FOccurs        := TTypeOccurs.Create;
    FOccurs.FlagTOcr := TOccurrenceType(aRec.TypeOcc);
  finally
    vtErrors.EndUpdate;
    FreeAndNil(aFS);
  end;
end;

procedure TfrmMvReadTxt.pgReadChange(Sender: TObject);
begin
  if (pgRead.ActivePageIndex <> 2) and (tsDetailLine.TabVisible) then
  begin
    tsDetailLine.TabVisible := False;
    ReleaseTreeNodes(vtLineDetail);
  end;
end;

procedure TfrmMvReadTxt.vtLaunchNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  PData: PGridData;
  S    : string;
  aVlr : Double;
  aQtd : Integer;
  R    : TRect;
begin
  if (Node = nil) or (Sender.GetNodeLevel(Node) = 0) and
     (not (Column in [1, 3])) then
    exit;
  PData := Sender.GetNodeData(Node);
  if (PData = nil) or (PData^.DataRow = nil) then exit;
  R := Sender.GetDisplayRect(Node, Column, False);
  R.BottomRight.Y := R.BottomRight.Y + (ClientHeight - vtSummary.Height -
                     Integer(vtSummary.DefaultNodeHeight));
  R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
  aVlr := 0;
  aQtd := 0;
  Sender.BeginUpdate;
  try
    if (Column = 1) then
    begin
      aQtd := StrToIntDef(NewText, 0);
      if (aQtd <= 0) then
        S := 'Valor informado inválido! Você deve digitar um valor ' + NL +
             'inteiro > 0 (ex: 1234)!';
      aVlr := aQtd * PData^.DataRow.FieldByName['VLR_UNIT'].AsFloat;
      if (PData^.DataRow.FieldByName['VLR_LAN'].AsFloat > 0) then
      begin
        if (not SameValue(aVlr, PData^.DataRow.FieldByName['VLR_LAN'].AsFloat,
            Dados.DecimalPlaces * -1)) then
        begin
          S := 'Valor do Lançamento não confere com a quantidade de tickets informados!';
          if (Dados.DisplayMessage(S + NL + 'Deseja Corrigir isto?',
             hiQuestion, [mbYes, mbNo]) = mrYes) then
          begin
            PData^.DataRow.FieldByName['VLR_LAN'].AsFloat := aVlr;
            S := '';
          end;
        end;
      end
      else
        PData^.DataRow.FieldByName['VLR_LAN'].AsFloat := aVlr;
    end;
    if (Column = 3) then
    begin
      aVlr := StrToFloatDef(NewText, -1);
      if (aVlr < 0) then
        S := 'Valor informado inválido! Você deve digitar um valor ' + NL +
             'de ponto flutuante > 0 (ex: 1234,56)!';
      if (aVlr > eTotPer.Value) then
        S := 'Valor informado não pode ser maior que o valor do lançamento!';
      if ((eTotPer.Value - aVlr) < 0) then
        S := 'Soma dos lançamentos não pode ultrapassar o valor total apurado!';
    end;
    if (S <> '') then
    begin
      Dados.DisplayHint(Self, R.BottomRight, S);
      exit;
    end;
    if (Column = 1) then
      PData^.DataRow.FieldByName['QTD_TCK'].AsInteger := aQtd;
    if (Column = 3) then
      PData^.DataRow.FieldByName['VLR_LAN'].AsFloat := aVlr;
    eTotLan.Value := eTotLan.Value + aVlr;
    FDataLanCta.FieldByName['VLR_LAN'].AsFloat := eTotPer.Value - eTotLan.Value;
  finally
    Sender.EndUpdate;
  end;
  aVlr := FDataLanCta.FieldByName['VLR_LAN'].AsFloat + eTotLan.Value;
  tbProcess.Enabled := SameValue(aVlr, eTotPer.Value);
end;

procedure TfrmMvReadTxt.vtLaunchInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  PData: PGridData;
begin
  if (Node = nil) or (Sender.GetNodeLevel(Node) = 0) then exit;
  PData := Sender.GetNodeData(Node);
  if (PData^.DataRow.FieldByName['PK_CONTAS'].AsInteger > 0) then
    Node.CheckType := ctRadioButton
  else
    Node.CheckType := ctCheckBox;
  Node.CheckState := csUncheckedNormal;
end;

procedure TfrmMvReadTxt.vtLaunchEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  PData: PGridData;
begin
  if (Node = nil) then exit;
  PData := Sender.GetNodeData(Node);
  if (PData = nil) or (PData^.DataRow = nil) then exit;
  Allowed := ((Sender.GetNodeLevel(Node) = 1) and
             (Node.CheckState = csCheckedNormal) and
             (PData^.DataRow.FieldByName['PK_CONTAS'].AsInteger = 0) and
             (Column in [1, 3]));
end;

procedure TfrmMvReadTxt.vtLaunchChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  PData : PGridData;
  PNode : PVirtualNode;
begin
  if (Node = nil) and (Sender.GetNodeLevel(Node) = 0) then exit;
  PData := Sender.GetNodeData(Node);
  if (PData = nil) or (PData^.DataRow = nil) then exit;
  Sender.BeginUpdate;
  try
    if (PData^.DataRow.FieldByName['PK_CONTAS'].AsInteger > 0) then
    begin
      PNode := Sender.GetFirst;
      while (PNode <> nil) do
      begin
        if (PNode <> Node) then
        begin
          PNode.CheckState := csUncheckedNormal;
          PData := Sender.GetNodeData(PNode);
          if (PData <> nil) and (PData^.DataRow <> nil) then
            PData^.DataRow.FieldByName['VLR_LAN'].AsFloat := 0;
        end;
        PNode := Sender.GetNext(PNode);
      end;
    end;
    PData := Sender.GetNodeData(Node);
    if (Node.CheckState = csCheckedNormal) and
       (PData^.DataRow.FieldByName['PK_CONTAS'].AsInteger > 0) then
    begin
      FDataLanCta := PData^.DataRow;
      FDataLanCta.FieldByName['VLR_LAN'].AsFloat := eTotPer.Value;
    end;
    Sender.FocusedNode    := Node;
    Sender.Selected[Node] := True;
  finally
    Sender.EndUpdate;
  end;
end;

procedure TfrmMvReadTxt.vtLaunchChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
begin
  if (Node = nil) or (Sender.GetNodeLevel(Node) = 0) then exit;
  Allowed := (eTotPer.Value > 0);
end;

procedure TfrmMvReadTxt.vtLaunchGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  PData: PGridData;
  aTRow: Integer;
begin
  if (Node = nil) then exit;
  PData := Sender.GetNodeData(Node);
  if (PData = nil) or (PData^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    case Column of
      0: CellText := PData^.DataRow.FieldByName['DSC_TROW'].AsString;
      1: CellText := ' ';
      2: CellText := ' ';
      3: CellText := ' ';
    end;
  end;
  if (Sender.GetNodeLevel(Node) = 1) then
  begin
    aTRow := PData^.DataRow.FieldByName['ROW_TYPE'].AsInteger;
    case Column of
      0: if (aTRow = 0) then
           CellText := PData^.DataRow.FieldByName['DSC_AGE'].AsString + ' - C/C:' +
                       PData^.DataRow.FieldByName['COD_CTA'].AsString
         else
           CellText := PData^.DataRow.FieldByName['DSC_TCTA'].AsString;
      1: if (aTRow = 0) then
           CellText := ' '
         else
           CellText := FloatToStrF(PData^.DataRow.FieldByName['QTD_TCK'].AsInteger,
                         ffNumber, 18, 0);
      2: if (aTRow = 0) then
           CellText := ' '
         else
           CellText := FloatToStrF(PData^.DataRow.FieldByName['VLR_UNIT'].AsFloat,
                       ffCurrency, 18, Dados.DecimalPlaces);
      3: if (PData^.DataRow.FieldByName['PK_CONTAS'].AsInteger > 0) then
           CellText := FloatToStrF(PData^.DataRow.FieldByName['VLR_LAN'].AsFloat,
                       ffCurrency, 18, Dados.DecimalPlaces)
         else
           CellText := FloatToStrF(PData^.DataRow.FieldByName['VLR_LAN'].AsFloat,
                       ffNumber, 18, Dados.DecimalPlaces);
    end;
  end;
end;

procedure TfrmMvReadTxt.vtLaunchGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if (Node = nil) or (Column > 0) then exit;
  if (Kind in [ikSelected, ikNormal]) then
    if Sender.GetNodeLevel(Node) = 0 then
      ImageIndex := 22
    else
      ImageIndex := 38;
end;

procedure TfrmMvReadTxt.vtLaunchBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if (Node = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    ItemColor := clMoneyGreen
  else
    ItemColor := clInfoBk;
  EraseAction := eaColor;
end;

procedure TfrmMvReadTxt.eAccountsSelect(Sender: TObject);
begin
  with eAccounts do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      SetStateParameters(True);
end;

procedure TfrmMvReadTxt.SetStateParameters(AState: Boolean);
begin
  bbFilter.Enabled := AState;
  lDtaIni.Enabled  := AState;
  eDtaIni.Enabled  := AState;
  eHorIni.Enabled  := AState;
  lDtaFin.Enabled  := AState;
  eDtaFin.Enabled  := AState;
  eHorFin.Enabled  := AState;
  lTotPer.Enabled  := AState;
  eTotPer.Enabled  := AState;
  lTotLan.Enabled  := AState;
  eTotLan.Enabled  := AState;
end;

procedure TfrmMvReadTxt.pgSummaryChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (vtLaunch.RootNodeCount > 0);
end;

initialization
  RegisterClass(TfrmMvReadTxt);
end.
