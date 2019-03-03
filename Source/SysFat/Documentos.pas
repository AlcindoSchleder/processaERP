unit Documentos;

{*************************************************************************}
{*                                                                       *}
{* Author: CSD Informatica                                               *}
{* Copyright: © 2003 by CSD Informatica. All rights reserved.            *}
{* Created: 03/06/2003 - DD/MM/YYYY                                      *}
{* Modified: 03/06/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (jorge@csd.com.br)                                           *}
{*         http://www.csd.com.br                                         *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, ToolEdit, CurrEdit, GridRow, SqlExpr,
  Buttons, ComCtrls, VirtualTrees, ProcUtils, jpeg, ToolWin;

type
  TRowData = class(TObject)
    Node : PVirtualNode;
    dbRow: TDataRow;
    Level: Integer;
    constructor Create;
    destructor Destroy; override;
  end;

  PRowData = ^TRowData;

  TTreeData = record
    RowData: TRowData;
  end;
  PTreeData = ^TTreeData;

  TfmDocumentos = class(TForm)
    pgMain: TPageControl;
    tsBusca: TTabSheet;
    pSearch: TPanel;
    Label1: TStaticText;
    Label2: TStaticText;
    Label3: TStaticText;
    Label4: TStaticText;
    Label5: TStaticText;
    cbEmpresa: TComboBox;
    cbGrupoMovimento: TComboBox;
    edNumero: TCurrencyEdit;
    cmdSearch: TSpeedButton;
    dtDe: TDateEdit;
    dtAte: TDateEdit;
    pgSearch: TPageControl;
    tsDocuments: TTabSheet;
    tsMoviment: TTabSheet;
    stDocumentos: TVirtualStringTree;
    tsDocument: TTabSheet;
    sbStatus: TStatusBar;
    imLogo: TImage;
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbNew: TToolButton;
    tbEdit: TToolButton;
    tbDelete: TToolButton;
    stTitle: TStaticText;
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure cbGrupoMovimentoClick(Sender : TObject);
    procedure cbGrupoMovimentoKeyDown(Sender : TObject; var Key : Word;
      Shift : TShiftState);
    procedure cmdSearchClick(Sender : TObject);
    procedure stDocumentosGetText(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
      var CellText : WideString);
    procedure stDocumentosResize(Sender : TObject);
    procedure tbEditClick(Sender : TObject);
    procedure tbNewClick(Sender : TObject);
    procedure tbDeleteClick(Sender : TObject);
    procedure FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure stDocumentosDblClick(Sender : TObject);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCompanyClick: Boolean;
    FCurrentNode : PVirtualNode;
    FRect        : TRect;
    FScrMode     : TDBMode;
    FslDocumentos: TList;
    procedure ClearGruposMovimentos;
    procedure LoadGruposMovimentos;
    procedure LoadEmpresas;
    procedure ClearDocumentos;
    procedure LoadDocumentos;
    procedure HandleInsertDocumento(afkEmpresas, afkCadastros, apkDocumentos : Integer);
    procedure HandleUpdateDocumento(afkEmpresas, afkCadastros, apkDocumentos : Integer);
  public
    { Public declarations }
  end;

implementation

uses mSysFat, EditDocumento, Dado, SelEmpr, ArqSqlFat, SqlComm, CnsMov;

{$R *.dfm}

{ TRowData }

constructor TRowData.Create;
begin
  inherited Create;
end;

destructor TRowData.Destroy;
begin
  if dbRow <> nil then
  begin
    dbRow.Free;
    dbRow := nil;
  end;
  inherited Destroy;
end;

{ TfmDocumentos }

procedure TfmDocumentos.ClearDocumentos;
var
  I: Integer;
  RowData: TRowData;
begin
  FCurrentNode := nil;
  for I := 0 to FslDocumentos.Count - 1 do
  begin
    RowData := TRowData(FslDocumentos[I]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslDocumentos[I] := nil;
    end;
  end;
  FslDocumentos.Clear;
  stDocumentos.Clear;
end;

procedure TfmDocumentos.ClearGruposMovimentos;
var
  I: Integer;
begin
  if cbGrupoMovimento.Items.Count < 1 then
    Exit;
  for I := 0 to cbGrupoMovimento.Items.Count - 1 do
    if cbGrupoMovimento.Items.Objects[I] <> nil then
    begin
      TDataRow(cbGrupoMovimento.Items.Objects[I]).Free;
      cbGrupoMovimento.Items.Objects[I] := nil;
    end;
  cbGrupoMovimento.Items.Clear;
  cbEmpresa.Items.Clear;
end;

procedure TfmDocumentos.LoadGruposMovimentos;
var
  aRow: TDataRow;
begin
  ClearGruposMovimentos;
  with dmSysFat.qrSqlAux do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlGroupMov);
    Dados.StartTransaction(dmSysFat.qrSqlAux);
    try
      if not Active then Open;
      while not (EOF) do
      begin
        aRow := TDataRow.CreateFromDataSet(nil, dmSysFat.qrSqlAux, True);
        cbGrupoMovimento.Items.AddObject(Trim(aRow.FieldByName['DSC_GMOV'].AsString) +
          ' / ' + Trim(aRow.FieldByName['DSC_TDOC'].AsString), aRow);
        Next;
      end;
    finally
      Close;
      Dados.CommitTransaction(dmSysFat.qrSqlAux);
    end;
  end;
  if (cbGrupoMovimento.Items.Count < 1) then exit;
  cbGrupoMovimento.ItemIndex := 0;
  if Assigned(cbGrupoMovimento.OnClick) then
    cbGrupoMovimento.OnClick(Self);
end;

procedure TfmDocumentos.FormCreate(Sender : TObject);
begin
  cbTools.Images             := Dados.Image16;
  tbTools.Images             := Dados.Image16;
  stDocumentos.Images        := Dados.Image16;
  stDocumentos.Header.Images := Dados.Image16;
  FslDocumentos              := TList.Create;
  stDocumentos.NodeDataSize  := SizeOf(TTreeData);
  stDocumentos.RootNodeCount := 0;
  dtDe.Date                  := Date;
  dtAte.Date                 := dtDe.Date;
  FScrMode                   := dbmFind;
  LoadGruposMovimentos;
  fmEditDocumento             := TfmEditDocumento.Create(Application);
  fmEditDocumento.Parent      := tsDocument;
  fmEditDocumento.Align       := alClient;
  fmEditDocumento.BorderStyle := bsNone;
  frmContas                   := TfrmContas.Create(Application);
  frmContas.Parent            := tsMoviment;
  frmContas.Align             := alClient;
  frmContas.BorderStyle       := bsNone;
end;

procedure TfmDocumentos.FormDestroy(Sender : TObject);
begin
  ClearGruposMovimentos;
  ClearDocumentos;
  FslDocumentos.Free;
  FslDocumentos := nil;
  if Assigned(fmEditDocumento) then
    fmEditDocumento.Free;
  fmEditDocumento := nil;
  if Assigned(frmContas) then
    frmContas.Free;
  frmContas := nil;
end;

procedure TfmDocumentos.LoadEmpresas;
var
  aRow:   TDataRow;
begin
  if cbGrupoMovimento.ItemIndex < 0 then
    Exit;
  aRow := TDataRow(cbGrupoMovimento.Items.Objects[cbGrupoMovimento.ItemIndex]);
  if aRow = nil then exit;
  with dmSysFat do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    if aRow.FieldByName['FLAG_ES'].AsInteger = 1 then
      qrSqlAux.SQL.Add(SqlClientes)
    else
      qrSqlAux.SQL.Add(SqlFornecedores);
  end;
  Dados.StartTransaction(dmSysFat.qrSqlAux);
  cbEmpresa.Items.Clear;
  cbEmpresa.Items.AddObject('<TODAS>', nil);
  with dmSysFat.qrSqlAux do
    try
      if not Active then Open;
      while not (EOF) do
      begin
        cbEmpresa.Items.AddObject(FieldByName('Raz_Soc').AsString,
          TObject(FieldByName('pk_cadastros').AsInteger));
        Next;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(dmSysFat.qrSqlAux);
    end;
  cbEmpresa.ItemIndex := 0;
  if Assigned(cbEmpresa.OnClick) then
    cbEmpresa.OnClick(Self);
end;

procedure TfmDocumentos.cbGrupoMovimentoClick(Sender : TObject);
begin
  LoadEmpresas;
end;

procedure TfmDocumentos.cbGrupoMovimentoKeyDown(Sender : TObject;
  var Key : Word; Shift : TShiftState);
begin
  if ((Key = vk_return) and (Assigned(cmdSearch.OnClick))) then
    cmdSearch.OnClick(Self);
end;

procedure TfmDocumentos.LoadDocumentos;
var
  adtDe, adtAte: TDateTime;
  SqlSaved: String;
  aRow:    TDataRow;
  aNode:   PVirtualNode;
  Data:    PTreeData;
  RowData: TRowData;
begin
  if ((edNumero.AsInteger < 1) and (cbGrupoMovimento.ItemIndex < 0)) then
  begin
    MessageBox(Self.Handle, 'O Grupo de Movimento deve ser especificado !',
      PChar(Caption), MB_ICONSTOP);
    if cbGrupoMovimento.CanFocus then
      cbGrupoMovimento.SetFocus;
    exit;
  end;
  stDocumentos.BeginUpdate;
  Screen.Cursor := crHourGlass;
  try
    ClearDocumentos;
    adtDe  := StrToDateDef(dtDe.Text, 0);
    adtAte := StrToDateDef(dtAte.Text, 0);
    with dmSysFat.qrDocumento do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Text := SqlDocuments;
      Dados.StartTransaction(dmSysFat.qrDocumento);
      try
        SqlSaved := Sql.Text;
        if edNumero.AsInteger > 0 then
          Sql.Insert(Sql.Count - 1, '   and NUM_DOC = ' + IntToStr(edNumero.AsInteger))
        else
        begin
          if cbGrupoMovimento.ItemIndex > -1 then
          begin
            aRow := TDataRow(cbGrupoMovimento.Items.Objects[cbGrupoMovimento.ItemIndex]);
            if aRow <> nil then
              Sql.Insert(Sql.Count - 1, '   and FK_GRUPOS_MOVIMENTOS = ' +
                IntToStr(aRow.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger));
          end;
          if adtDe > 0 then
            Sql.Insert(Sql.Count - 1, '   and DATA_EMISSAO >= ''' +
              FormatDateTime('yyyy-mm-dd', adtDe) + '''');
          if adtAte > 0 then
            Sql.Insert(Sql.Count - 1, '   and DATA_EMISSAO <= ''' +
              FormatDateTime('yyyy-mm-dd', adtAte) + '''');
          if cbEmpresa.ItemIndex > 0 then
            Sql.Insert(Sql.Count - 1, '   and FK_CADASTROS = ' +
              IntToStr(LongInt(cbEmpresa.Items.Objects[cbEmpresa.ItemIndex])));
        end;
        if not Active then Open;
        while not (EOF) do
        begin
          aRow          := TDataRow.CreateFromDataSet(nil, dmSysFat.qrDocumento, True);
          RowData       := TRowData.Create;
          RowData.dbRow := aRow;
          RowData.Level := 0;
          aNode         := stDocumentos.AddChild(nil);
          Data          := stDocumentos.GetNodeData(aNode);
          Data.RowData  := RowData;
          RowData.Node  := aNode;
          FslDocumentos.Add(RowData);
          Next;
        end;
      finally
        Close;
        Dados.CommitTransaction(dmSysFat.qrDocumento);
        Sql.Text := SqlSaved;
      end;
    end;
  finally
    stDocumentos.EndUpdate;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfmDocumentos.cmdSearchClick(Sender : TObject);
begin
  LoadDocumentos;
end;

procedure TfmDocumentos.stDocumentosGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data: PTreeData;
begin
  if Node = nil then exit;
  Data := stDocumentos.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  case Column of
    0: CellText := Data.RowData.dbRow.FieldByName['RAZ_SOC'].AsString;
    1: CellText := FormatDateTime('dd/mm/yyyy',
                     Data.RowData.dbRow.FieldByName['DATA_EMISSAO'].AsDateTime);
    2: CellText := IntToStr(Data.RowData.dbRow.FieldByName['NUM_DOC'].AsInteger);
    3: CellText := FormatFloat('#,##0.00', Data.RowData.dbRow.FieldByName['VAL_TOT'].AsFloat);
  end;
end;

procedure TfmDocumentos.stDocumentosResize(Sender : TObject);
begin
  stDocumentos.Header.Columns[0].Width :=
    stDocumentos.Width -
    stDocumentos.Header.Columns[1].Width -
    stDocumentos.Header.Columns[2].Width -
    stDocumentos.Header.Columns[3].Width - 25;
end;

procedure TfmDocumentos.tbEditClick(Sender : TObject);
var
  aNode: PVirtualNode;
  Data:  PTreeData;
begin
  aNode := stDocumentos.FocusedNode;
  if aNode = nil then
    Exit;
  Data := stDocumentos.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    Exit;
  FCurrentNode := aNode;
  with TfmEditDocumento.Create(Self) do
    try
      fkEmpresas   := Data.RowData.dbRow.FieldByName['FK_EMPRESAS'].AsInteger;
      fkCadastros  := Data.RowData.dbRow.FieldByName['FK_CADASTROS'].AsInteger;
      pkDocumentos := Data.RowData.dbRow.FieldByName['PK_DOCUMENTOS'].AsInteger;
      OnInsertDocumento := HandleInsertDocumento;
      OnUpdateDocumento := HandleUpdateDocumento;
      ShowModal;
    finally
      Release;
    end;
end;

procedure TfmDocumentos.HandleInsertDocumento(afkEmpresas, afkCadastros,
  apkDocumentos : Integer);
var
  aNode:   PVirtualNode;
  Data:    PTreeData;
  RowData: TRowData;
begin
  if ((afkEmpresas < 1) or (afkCadastros < 1) or (apkDocumentos < 1)) then
    exit;
  RowData := nil;
  with dmSysFat.qrDocumento do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlDocument);
    Dados.StartTransaction(dmSysFat.qrDocumento);
    try
      ParamByName('FK_EMPRESAS').AsInteger   := afkEmpresas;
      ParamByName('FK_CADASTROS').AsInteger  := afkCadastros;
      ParamByName('PK_DOCUMENTOS').AsInteger := apkDocumentos;
      if not Active then Open;
      if (not EOF) then
      begin
        RowData       := TRowData.Create;
        RowData.dbRow := TDataRow.CreateFromDataSet(nil, dmSysFat.qrDocumento, True);
      end;
    finally
      Close;
      Dados.CommitTransaction(dmSysFat.qrDocumento);
    end;
  end;
  if RowData = nil then exit;
  RowData.Level := 0;
  aNode := stDocumentos.AddChild(nil);
  Data  := stDocumentos.GetNodeData(aNode);
  Data.RowData := RowData;
  RowData.Node := aNode;
  FslDocumentos.Add(RowData);
  stDocumentos.FocusedNode := aNode;
  FCurrentNode := aNode;
end;

procedure TfmDocumentos.HandleUpdateDocumento(afkEmpresas, afkCadastros,
  apkDocumentos : Integer);
var
  aNode: PVirtualNode;
  Data:  PTreeData;
  aRow:  TDataRow;
begin
  if ((afkEmpresas < 1) or (afkCadastros < 1) or (apkDocumentos < 1)) then
    exit;
  aRow  := nil;
  aNode := stDocumentos.FocusedNode;
  if ((aNode = nil) or (aNode <> FCurrentNode)) then exit;
  Data := stDocumentos.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  with Data.RowData do
    if ((dbRow.FieldByName['FK_EMPRESAS'].AsInteger <> afkEmpresas) or
       (dbRow.FieldByName['FK_CADASTROS'].AsInteger <> afkCadastros) or
       (dbRow.FieldByName['PK_DOCUMENTOS'].AsInteger <> apkDocumentos)) then
      exit;
  with dmSysFat.qrDocumento do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlDocument);
    Dados.StartTransaction(dmSysFat.qrDocumento);
    try
      ParamByName('FK_EMPRESAS').AsInteger   := afkEmpresas;
      ParamByName('FK_CADASTROS').AsInteger  := afkCadastros;
      ParamByName('PK_DOCUMENTOS').AsInteger := apkDocumentos;
      Open;
      if (not EOF) then
        aRow := TDataRow.CreateFromDataSet(nil, dmSysFat.qrDocumento, True);
    finally
      Close;
      Dados.CommitTransaction(dmSysFat.qrDocumento);
    end;
  end;
  if aRow = nil then exit;
  Data.RowData.dbRow.Free;
  Data.RowData.dbRow       := aRow;
  stDocumentos.FocusedNode := aNode;
  FCurrentNode             := aNode;
  stDocumentos.InvalidateNode(aNode);
end;

procedure TfmDocumentos.tbNewClick(Sender : TObject);
begin
  with TfmEditDocumento.Create(Self) do
    try
      fkEmpresas   := Dados.PkCompany;
      fkCadastros  := 0;
      pkDocumentos := 0;
      OnInsertDocumento := HandleInsertDocumento;
      OnUpdateDocumento := HandleUpdateDocumento;
      ShowModal;
    finally
      Release;
    end;
end;

procedure TfmDocumentos.tbDeleteClick(Sender : TObject);
var
  aNode: PVirtualNode;
  Data:  PTreeData;
  S:     String;
begin
  aNode := stDocumentos.FocusedNode;
  if (aNode = nil) then exit;
  Data := stDocumentos.GetNodeData(aNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  if Data.RowData.dbRow.FieldByName['FLAG_CANC'].AsInteger <> 0 then
  begin
    Dados.DisplayMessage('Este documento já está cancelado !', hiError, [mbOk]);
    exit;
  end;
  if Data.RowData.dbRow.FieldByName['FLAG_BXAC'].AsInteger <> 0 then
  begin
    Dados.DisplayMessage('Este documento já foi liquidado !', hiError, [mbOk]);
    exit;
  end;
  S := 'Por favor confirme o cancelamento do Documento ' + IntToStr(
    Data.RowData.dbRow.FieldByName['NUM_DOC'].AsInteger) + ' da empresa ' +
    Data.RowData.dbRow.FieldByName['RAZ_SOC'].AsString + ' !';
  if Dados.DisplayMessage(S, hiQuestion, [mbYes, mbNo]) <> idYes then exit;
  with dmSysFat.qrDocumento do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlCancelDoc);
    Dados.StartTransaction(dmSysFat.qrDocumento);
    try
      ParamByName('FkRmpresas').AsInteger   := Data.RowData.dbRow.FieldByName['FK_EMPRESAS'].AsInteger;
      ParamByName('FkCadastros').AsInteger  := Data.RowData.dbRow.FieldByName['FK_CADASTROS'].AsInteger;
      ParamByName('PkDocumentos').AsInteger := Data.RowData.dbRow.FieldByName['PK_DOCUMENTOS'].AsInteger;
      if not Active then ExecSql;
    finally
      if Active then Close;
      Dados.CommitTransaction(dmSysFat.qrDocumento);
    end;
  end;
  Data.RowData.dbRow.FieldByName['FLAG_CANC'].AsInteger := 1;
  stDocumentos.InvalidateNode(aNode);
end;

procedure TfmDocumentos.FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
begin
  if Key = vk_Escape then Close;
end;

procedure TfmDocumentos.stDocumentosDblClick(Sender : TObject);
begin
  if Assigned(tbEdit.OnClick) then
    tbEdit.OnClick(Sender);
end;

procedure TfmDocumentos.sbStatusClick(Sender: TObject);
var
  aChange: Boolean;
  aIdx   : Integer;
begin
  if (not FCompanyClick) then exit;
  // Change the company...
  aChange := True;
  aIdx  := pgMain.ActivePageIndex;
  if aIdx < 0 then exit;
  if not aChange then exit;
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    FCompanyClick := False;
    SelEmpresa.Free;
  end;
  sbStatus.Repaint;
end;

procedure TfmDocumentos.sbStatusDrawPanel(StatusBar: TStatusBar;
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

procedure TfmDocumentos.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (X <= (FRect.TopLeft.X + 22)) and
                   (Y >= FRect.TopLeft.Y) and (Y <= (FRect.TopLeft.Y + 16));
end;

procedure TfmDocumentos.FormShow(Sender: TObject);
begin
  if Assigned(fmEditDocumento) then
    fmEditDocumento.Show;
  if Assigned(frmContas) then
    frmContas.Show;
end;

initialization
  RegisterClass(TfmDocumentos);

end.

