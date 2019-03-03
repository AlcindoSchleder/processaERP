unit EditDocumento;

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
  Dialogs, ToolEdit, CurrEdit, StdCtrls, Mask, Buttons, VirtualTrees,
  ExtCtrls, ComCtrls, DB, SqlExpr, GridRow;

type
  TUpdateDocumentoEvent = procedure(afkEmpresas, afkCadastros, apkDocumentos : Integer) of
    object;

  TRowData = class(TObject)
    Node: PVirtualNode;
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

  TfmEditDocumento = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    cmdNew: TSpeedButton;
    cmdUpdate: TSpeedButton;
    Label2: TStaticText;
    cbGrupoMovimento: TComboBox;
    Label3: TStaticText;
    Label5: TStaticText;
    edNUM_DOC: TCurrencyEdit;
    Label1: TStaticText;
    cbFK_CADASTROS: TComboBox;
    pDupl: TPanel;
    Panel4: TPanel;
    Label9: TStaticText;
    Label10: TStaticText;
    sbMsg: TStatusBar;
    cmdNewDuplicata: TSpeedButton;
    cmdEditDuplicata: TSpeedButton;
    cmdDeleteDuplicata: TSpeedButton;
    Label11: TStaticText;
    edOBS_DOC: TMemo;
    dtDATA_EMISSAO: TDateEdit;
    GroupBox1: TGroupBox;
    Label4: TStaticText;
    edVLR_STOT: TCurrencyEdit;
    edVLR_ACR_DSCT: TCurrencyEdit;
    Label6: TStaticText;
    Label7: TStaticText;
    edVAL_TOT: TCurrencyEdit;
    gbFlags: TGroupBox;
    chkFLAG_BXAC: TCheckBox;
    chkFLAG_CANC: TCheckBox;
    pgDupl: TPageControl;
    tsList: TTabSheet;
    tsMananger: TTabSheet;
    stDuplicatas: TVirtualStringTree;
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure cbGrupoMovimentoClick(Sender : TObject);
    procedure stDuplicatasGetText(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
      var CellText : WideString);
    procedure stDuplicatasResize(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure stDuplicatasDblClick(Sender : TObject);
    procedure cmdEditDuplicataClick(Sender : TObject);
    procedure signalizeChange(Sender : TObject);
    procedure cmdNewDuplicataClick(Sender : TObject);
    procedure cmdDeleteDuplicataClick(Sender : TObject);
    procedure edVLR_ACR_DSCTChange(Sender : TObject);
    procedure cmdNewClick(Sender : TObject);
    procedure cmdUpdateClick(Sender : TObject);
    procedure FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
  private
    { Private declarations }
    FslDuplicatas: TList;
    FpkDocumentos: Integer;
    FfkCadastros: Integer;
    FfkEmpresas: Integer;
    FCurrentDuplicataNode: PVirtualNode;
    FCurrFlagES: Integer;
    FInsideMove: Boolean;
    FOnInsertDocumento: TUpdateDocumentoEvent;
    FOnUpdateDocumento: TUpdateDocumentoEvent;
    procedure ClearDuplicatas;
    procedure LoadDuplicatas;
    procedure ClearGruposMovimentos;
    procedure LoadGruposMovimentos;
    procedure LoadEmpresas;
    procedure EnableFields;
    procedure HandleInsertDuplicata(adbRow : TDataRow);
    procedure HandleUpdateDuplicata(adbRow : TDataRow);
    procedure ClearDocumento;
    function DocumentoSaved: Boolean;
    procedure LoadDocumento;
    procedure SelectGrupoMovimento(apkGrupoMovimento : Integer);
  public
    { Public declarations }
    property fkEmpresas: Integer Read FfkEmpresas Write FfkEmpresas;
    property fkCadastros: Integer Read FfkCadastros Write FfkCadastros;
    property pkDocumentos: Integer Read FpkDocumentos Write FpkDocumentos;
    property OnInsertDocumento: TUpdateDocumentoEvent
      Read FOnInsertDocumento Write FOnInsertDocumento;
    property OnUpdateDocumento: TUpdateDocumentoEvent
      Read FOnUpdateDocumento Write FOnUpdateDocumento;
  end;

var
  fmEditDocumento: TfmEditDocumento;

implementation

uses Dado, EditDuplicata, mSysFat, ArqSqlFat, SqlComm;

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

procedure TfmEditDocumento.FormCreate(Sender : TObject);
begin
  FslDuplicatas := TList.Create;
  stDuplicatas.NodeDataSize := SizeOf(TTreeData);
  stDuplicatas.RootNodeCount := 0;
  LoadGruposMovimentos;
end;

procedure TfmEditDocumento.FormDestroy(Sender : TObject);
begin
  ClearGruposMovimentos;
  ClearDuplicatas;
  FslDuplicatas.Free;
  FslDuplicatas := nil;
  if Assigned(fmEditDuplicata) then
    fmEditDuplicata.Free;
  fmEditDuplicata := nil;
end;

procedure TfmEditDocumento.ClearGruposMovimentos;
var
  I: Integer;
begin
  FCurrFlagES := -1;
  if cbGrupoMovimento.Items.Count < 1 then
    Exit;
  for I := 0 to cbGrupoMovimento.Items.Count - 1 do
    if cbGrupoMovimento.Items.Objects[I] <> nil then
    begin
      TDataRow(cbGrupoMovimento.Items.Objects[I]).Free;
      cbGrupoMovimento.Items.Objects[I] := nil;
    end;
  cbGrupoMovimento.Items.Clear;
  cbfk_CADASTROS.Items.Clear;
end;

procedure TfmEditDocumento.LoadGruposMovimentos;
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
end;

procedure TfmEditDocumento.LoadEmpresas;
var
  aRow:   TDataRow;
begin
  if cbGrupoMovimento.ItemIndex < 0 then
    Exit;
  aRow := TDataRow(cbGrupoMovimento.Items.Objects[cbGrupoMovimento.ItemIndex]);
  if aRow = nil then exit;
  FCurrFlagES := aRow.FieldByName['flag_es'].AsInteger;
  with dmSysFat do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    if aRow.FieldByName['flag_es'].AsInteger = 1 then
      qrSqlAux.SQL.Add(SqlClientes)
    else
      qrSqlAux.SQL.Add(SqlFornecedores);
  end;
  Dados.StartTransaction(dmSysFat.qrSqlAux);
  cbFK_CADASTROS.Items.Clear;
  cbFK_CADASTROS.Items.AddObject('<TODAS>', nil);
  with dmSysFat.qrSqlAux do
    try
      if not Active then Open;
      while not (EOF) do
      begin
        cbFK_CADASTROS.Items.AddObject(
          FieldByName('Raz_Soc').AsString, TObject(FieldByName('pk_cadastros').AsInteger));
        Next;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(dmSysFat.qrSqlAux);
    end;
  cbFK_CADASTROS.ItemIndex := 0;
  if Assigned(cbFK_CADASTROS.OnClick) then
    cbFK_CADASTROS.OnClick(Self);
end;

procedure TfmEditDocumento.cbGrupoMovimentoClick(Sender : TObject);
begin
  LoadEmpresas;
  edNum_Doc.Enabled := ((cbGrupoMovimento.Enabled) and (FCurrFlagES = 0));
  SignalizeChange(Self);
end;

procedure TfmEditDocumento.stDuplicatasGetText(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; TextType : TVSTTextType;
  var CellText : WideString);
var
  Data: PTreeData;
begin
  if Node = nil then
    exit;
  Data := stDuplicatas.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    Exit;
  case Column of
    0: CellText := FormatDateTime('dd/mm/yyyy', Data.RowData.dbRow.FieldByName['DTA_VENC'].AsDateTime);
    1: CellText := Data.RowData.dbRow.FieldByName['HIST_LAN'].AsString;
    2: CellText := FormatFloat('#,##0.00', Data.RowData.dbRow.FieldByName['VLR_VENC'].AsFloat +
        Data.RowData.dbRow.FieldByName['VLR_ACR_DSCT'].AsFloat);
  end;
end;

procedure TfmEditDocumento.stDuplicatasResize(Sender : TObject);
begin
  stDuplicatas.Header.Columns[1].Width :=
    stDuplicatas.Width -
    stDuplicatas.Header.Columns[0].Width -
    stDuplicatas.Header.Columns[2].Width - 25;
end;

procedure TfmEditDocumento.ClearDuplicatas;
var
  I: Integer;
  RowData: TRowData;
begin
  FCurrentDuplicataNode := nil;
  for I := 0 to FslDuplicatas.Count - 1 do
  begin
    RowData := TRowData(FslDuplicatas[I]);
    if RowData <> nil then
    begin
      RowData.Free;
      FslDuplicatas[I] := nil;
    end;
  end;
  FslDuplicatas.Clear;
  stDuplicatas.Clear;
end;

procedure TfmEditDocumento.LoadDuplicatas;
var
  RowData: TRowData;
  Data:    PTreeData;
begin
  stDuplicatas.BeginUpdate;
  try
    ClearDuplicatas;
    with dmSysFat.qrDuplicata do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Add(SqlDuplicatas);
      Dados.StartTransaction(dmSysFat.qrDuplicata);
      try
        ParamByName('FK_EMPRESAS').AsInteger   := FfkEmpresas;
        ParamByName('FK_CADASTROS').AsInteger  := FfkCadastros;
        ParamByName('FK_DOCUMENTOS').AsInteger := FpkDocumentos;
        Open;
        while not (EOF) do
        begin
          RowData := TRowData.Create;
          RowData.dbRow := TDataRow.CreateFromDataSet(nil, dmSysFat.qrDuplicata, True);
          RowData.Level := 0;
          RowData.Node := stDuplicatas.AddChild(nil);
          Data := stDuplicatas.GetNodeData(RowData.Node);
          Data.RowData := RowData;
          FslDuplicatas.Add(RowData);
          Next;
        end;
      finally
        Close;
        Dados.CommitTransaction(dmSysFat.qrDuplicata);
      end;
    end;
  finally
    stDuplicatas.EndUpdate;
  end;
end;

procedure TfmEditDocumento.ClearDocumento;
begin
  dtDATA_EMISSAO.Date := Date;
  edVLR_STOT.Value := 0;
  edVLR_ACR_DSCT.Value := 0;
  edVAL_TOT.Value := 0;
  edNUM_DOC.Value := 0;
  chkFLAG_BXAC.Checked := False;
  chkFLAG_CANC.Checked := False;
  edOBS_DOC.Text := '';
  chkFLAG_BXAC.Checked := False;
  chkFLAG_CANC.Checked := False;
  ClearDuplicatas;
end;

procedure TfmEditDocumento.EnableFields;
begin
  cbGrupoMovimento.Enabled := not ((FfkEmpresas > 0) and (FfkCadastros > 0) and
    (FpkDocumentos > 0));
  edNum_Doc.Enabled      := ((cbGrupoMovimento.Enabled) and (FCurrFlagES = 0));
//  dtDATA_EMISSAO.Enabled        :=cbGrupoMovimento.Enabled;
  cbfk_CADASTROS.Enabled := cbGrupoMovimento.Enabled;
  edVLR_STOT.Enabled     := cbGrupoMovimento.Enabled;
  edVLR_ACR_DSCT.Enabled := cbGrupoMovimento.Enabled;
  cmdNewDuplicata.Visible := cbGrupoMovimento.Enabled;
  cmdDeleteDuplicata.Visible := cbGrupoMovimento.Enabled;
  edOBS_DOC.Enabled      :=
    ((cbGrupoMovimento.Enabled) or ( not ((chkFLAG_CANC.Checked) or (chkFLAG_BXAC.Checked))));
  cmdUpdate.Enabled      := False;
end;

procedure TfmEditDocumento.SelectGrupoMovimento(apkGrupoMovimento : Integer);
var
  I: Integer;
begin
  for I := 0 to cbGrupoMovimento.Items.Count - 1 do
    if cbGrupoMovimento.Items.Objects[I] <> nil then
      if (TDataRow(cbGrupoMovimento.Items.Objects[I]).FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger =
           apkGrupoMovimento) then
      begin
        cbGrupoMovimento.ItemIndex := I;
        exit;
      end;
end;

procedure TfmEditDocumento.LoadDocumento;
var
  S: String;
  M: TMemoryStream;
begin
  if FfkEmpresas < 1 then
    FfkEmpresas := Dados.PkCompany;
  S := '';
  ClearDocumento;
  if ((FfkEmpresas > 0) and (FfkCadastros > 0) and (FpkDocumentos > 0)) then
    with dmSysFat.qrDocumento do
      try
        ParamByName('FK_EMPRESAS').AsInteger   := FfkEmpresas;
        ParamByName('FK_CADASTROS').AsInteger  := FfkCadastros;
        ParamByName('PK_DOCUMENTOS').AsInteger := FpkDocumentos;
        Open;
        if EOF then
        begin
          S := 'Erro Documento com fk_empresas=' + IntToStr(FfkEmpresas) +
            ', fk_cadastros=' + IntToStr(FfkCadastros) +
            ' e pk_documentos=' + IntToStr(FpkDocumentos) + ' não foi encontrado !';
          Exit;
        end;
        SelectGrupoMovimento(FieldByName('fk_grupos_movimentos').AsInteger);
        if Assigned(cbGrupoMovimento.OnClick) then
          cbGrupoMovimento.OnClick(Self);
        cbFK_CADASTROS.ItemIndex :=
          cbFK_CADASTROS.Items.IndexOfObject(TObject(FieldByName('FK_CADASTROS').AsInteger));
        dtDATA_EMISSAO.Date := FieldByName('DATA_EMISSAO').AsDateTime;
        edVLR_STOT.Value := FieldByName('VLR_STOT').AsFloat;
        edVLR_ACR_DSCT.Value := FieldByName('VLR_ACR_DSCT').AsFloat;
        edVAL_TOT.Value := FieldByName('VAL_TOT').AsFloat;
        M := TMemoryStream.Create;
        try
          TBlobField(FieldByName('OBS_DOC')).SaveToStream(M);
          M.Position := 0;
          edOBS_DOC.Lines.LoadFromStream(M);
        finally
          FreeAndnil(M);
        end;
      finally
        Close;
        if S <> '' then
        begin
          MessageBox(Self.Handle, PChar(S), PChar(Caption), MB_ICONSTOP);
          PostMessage(Self.Handle, WM_CLOSE, 0, 0);
        end;
        LoadDuplicatas;
      end;
  EnableFields;
end;

procedure TfmEditDocumento.FormShow(Sender : TObject);
begin
  LoadDocumento;
end;

procedure TfmEditDocumento.stDuplicatasDblClick(Sender : TObject);
begin
  if Assigned(cmdEditDuplicata.OnClick) then
    cmdEditDuplicata.OnClick(Self);
end;

procedure TfmEditDocumento.cmdEditDuplicataClick(Sender : TObject);
var
  Node: PVirtualNode;
  Data: PTreeData;
begin
  if not (cmdEditDuplicata.Visible) then
    Exit;
  stDuplicatas.EndEditNode;
  Node := stDuplicatas.FocusedNode;
  if Node = nil then
    Exit;
  Data := stDuplicatas.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    Exit;
  FCurrentDuplicataNode := Node;
  if (not Assigned(fmEditDuplicata)) then
  begin
    fmEditDuplicata                   := TfmEditDuplicata.Create(Application);
    fmEditDuplicata.BorderStyle       := bsNone;
    fmEditDuplicata.Parent            := tsMananger;
    fmEditDuplicata.Align             := alClient;
    fmEditDuplicata.DbRowToEdit       := nil;
    fmEditDuplicata.OnUpdateDuplicata := HandleUpdateDuplicata;
    fmEditDuplicata.OnInsertDuplicata := HandleInsertDuplicata;
    fmEditDuplicata.Show;
  end;
  pgDupl.ActivePageIndex            := 1;
end;

procedure TfmEditDocumento.signalizeChange(Sender : TObject);
begin
  if FInsideMove then
    Exit;
  if not (cmdUpdate.Enabled) then
    cmdUpdate.Enabled := True;
end;

procedure TfmEditDocumento.cmdNewDuplicataClick(Sender : TObject);
begin
  if not (cmdNewDuplicata.Visible) then exit;
  if (not Assigned(fmEditDuplicata)) then
  begin
    fmEditDuplicata                   := TfmEditDuplicata.Create(Application);
    fmEditDuplicata.BorderStyle       := bsNone;
    fmEditDuplicata.Parent            := tsMananger;
    fmEditDuplicata.Align             := alClient;
    fmEditDuplicata.DbRowToEdit       := nil;
    fmEditDuplicata.OnUpdateDuplicata := HandleUpdateDuplicata;
    fmEditDuplicata.OnInsertDuplicata := HandleInsertDuplicata;
    fmEditDuplicata.Show;
  end;
  pgDupl.ActivePageIndex            := 1;
end;

procedure TfmEditDocumento.cmdDeleteDuplicataClick(Sender : TObject);
var
  Node: PVirtualNode;
  Data: PTreeData;
  Ix:   Integer;
begin
  pgDupl.ActivePageIndex            := 0;
  if not (cmdDeleteDuplicata.Visible) then exit;
  Node := stDuplicatas.FocusedNode;
  if Node = nil then exit;
  Data := stDuplicatas.GetNodeData(Node);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    exit;
  Ix := FslDuplicatas.IndexOf(Data.RowData);
  if Ix < 0 then exit;
  Data.RowData.Free;
  Data.RowData := nil;
  FslDuplicatas.Delete(Ix);
  stDuplicatas.DeleteNode(Node);
  FCurrentDuplicataNode := nil;
  SignalizeChange(Self);
end;

procedure TfmEditDocumento.edVLR_ACR_DSCTChange(Sender : TObject);
begin
  edVAL_TOT.Value := edVLR_STOT.Value + edVLR_ACR_DSCT.Value;
  SignalizeChange(Sender);
end;

procedure TfmEditDocumento.cmdNewClick(Sender : TObject);
begin
  FpkDocumentos := 0;
  LoadDocumento;
end;

function TfmEditDocumento.DocumentoSaved: Boolean;
var
  dt: TDateTime;
  I, apkDocumentos, aNumDoc, afkCadastros: Integer;
  GrupoMovimento: TDataRow;
  RowData: TRowData;
  M: TMemoryStream;
  vlTotalDuplicatas: Double;
begin
  Result := False;
  if cbGrupoMovimento.ItemIndex < 0 then
  begin
    if cbGrupoMovimento.CanFocus then
      cbGrupoMovimento.SetFocus;
    MessageBox(Self.Handle, 'O Grupo de Movimento deve ser especificado !',
      PChar(Caption), MB_ICONSTOP);
    Exit;
  end;
  GrupoMovimento := TDataRow(cbGrupoMovimento.Items.Objects[cbGrupoMovimento.ItemIndex]);
  if GrupoMovimento = nil then
    Exit;
  if cbFK_CADASTROS.ItemIndex < 0 then
  begin
    if cbFK_CADASTROS.CanFocus then
      cbFK_CADASTROS.SetFocus;
    MessageBox(Self.Handle, 'A Empresa deve ser especificada !',
      PChar(Caption), MB_ICONSTOP);
    Exit;
  end;
  afkCadastros := LongInt(cbFK_CADASTROS.Items.Objects[cbFK_CADASTROS.ItemIndex]);
  dt := StrToDateDef(dtDATA_EMISSAO.Text, 0);
  if dt = 0 then
  begin
    if dtDATA_EMISSAO.CanFocus then
      dtDATA_EMISSAO.SetFocus;
    MessageBox(Self.Handle, 'A Data de Emissão deve ser especificada !',
      PChar(Caption), MB_ICONSTOP);
    Exit;
  end;
  if ((edNum_Doc.Enabled) and (edNUM_DOC.AsInteger < 1)) then
  begin
    if edNUM_DOC.CanFocus then
      edNUM_DOC.SetFocus;
    MessageBox(Self.Handle, 'O Número do Documento deve ser especificado !',
      PChar(Caption), MB_ICONSTOP);
    Exit;
  end;
  if edVLR_STOT.Value < 0.009 then
  begin
    if edVLR_STOT.CanFocus then
      edVLR_STOT.SetFocus;
    MessageBox(Self.Handle, 'O Valor do Documento deve ser especificado !',
      PChar(Caption), MB_ICONSTOP);
    Exit;
  end;
  vlTotalDuplicatas := 0;
  for I := 0 to FslDuplicatas.Count - 1 do
  begin
    RowData := TRowData(FslDuplicatas[I]);
    if ((RowData <> nil) and (RowData.dbRow <> nil)) then
      vlTotalDuplicatas :=
        vlTotalDuplicatas + RowData.dbRow.FieldByName['VLR_VENC'].AsFloat +
        RowData.dbRow.FieldByName['VLR_ACR_DSCT'].AsFloat;
  end;
  if Abs(vlTotalDuplicatas - edVAL_TOT.Value) > 0.009 then
  begin
    MessageBox(Self.Handle,
      'A Soma do valores das duplicatas deve ser igual ao valor total do documento !',
      PChar(Caption), MB_ICONSTOP);
    Exit;
  end;
  try
    with dmSysFat.qrDocumento do
    begin
      if Active then Close;
      SQL.Clear;
      if FpkDocumentos > 0 then
        SQL.Add(SqlUpdDocumento)
      else
        SQL.Add(SqlInsDocumento);
      Dados.StartTransaction(dmSysFat.qrDocumento);
      try
        ParamByName('FK_EMPRESAS').AsInteger  := FfkEmpresas;
        ParamByName('FK_CADASTROS').AsInteger := afkCadastros;
        if FpkDocumentos > 0 then
          ParamByName('PK_DOCUMENTOS').AsInteger := FpkDocumentos
        else
        begin
          ParamByName('FK_GRUPOS_MOVIMENTOS').AsInteger :=
            GrupoMovimento.FieldByName['PK_GRUPOS_MOVIMENTOS'].AsInteger;
          ParamByName('FK_TIPO_DOCUMENTOS').AsInteger :=
            GrupoMovimento.FieldByName['PK_TIPO_DOCUMENTOS'].AsInteger;
          ParamByName('DATA_EMISSAO').AsDateTime := dt;
          ParamByName('VLR_STOT').AsFloat     := edVLR_STOT.Value;
          ParamByName('VLR_ACR_DSCT').AsFloat := edVLR_ACR_DSCT.Value;
          ParamByName('VAL_TOT').AsFloat      := edVAL_TOT.Value;
          if FCurrFlagES = 0 then
            ParamByName('NUM_DOC').AsInteger := edNUM_DOC.AsInteger
          else
            ParamByName('NUM_DOC').Clear;
          ParamByName('QTD_DUPL').AsInteger :=
            stDuplicatas.RootNodeCount;
        end; // if ... else
        ParamByName('FLAG_CANC').AsInteger := Integer(chkFLAG_CANC.Checked);
        M := TMemoryStream.Create;
        try
          edOBS_DOC.Lines.SaveToStream(M);
          M.Position := 0;
          ParamByName('OBS_DOC').LoadFromStream(M, ftMemo);
        finally
          FreeAndnil(M);
        end; // try
        ExecSql;
      finally
        Close;
      end; // try
      apkDocumentos := FpkDocumentos;
      aNumDoc := edNUM_DOC.AsInteger;
      if FpkDocumentos < 1 then
      begin
        with dmSysFat.qrDocumento do
        begin
          if Active then Close;
          SQL.Clear;
          SQL.Add(SqlMaxDocumento);
          try
            ParamByName('FK_EMPRESAS').AsInteger  := FfkEmpresas;
            ParamByName('FK_CADASTROS').AsInteger := afkCadastros;
            Open;
            if not (EOF) then
              apkDocumentos := FieldByName('PK_DOCUMENTOS').AsInteger;
          finally
            Close;
          end;
        end; // dmSysFat.qrMaxDocumento
        with dmSysFat.qrDocumento do
        begin
          if Active then Close;
          SQL.Clear;
          SQL.Add(SqlDocument);
          try
            ParamByName('FK_EMPRESAS').AsInteger   := FfkEmpresas;
            ParamByName('FK_CADASTROS').AsInteger  := afkCadastros;
            ParamByName('PK_DOCUMENTOS').AsInteger := apkDocumentos;
            Open;
            if not (EOF) then
              aNumDoc := FieldByName('NUM_DOC').AsInteger;
          finally
            Close;
          end; // try
        end; // dmSysFat.qrDocumento
      end; // if FpkDocumentos < 1
      for I := 0 to FslDuplicatas.Count - 1 do
      begin
        RowData := TRowData(FslDuplicatas[I]);
        if ((RowData <> nil) and (RowData.dbRow <> nil)) then
        begin
          with dmSysFat.qrDocumento do
          begin
            if Active then Close;
            SQL.Clear;
            if RowData.dbRow.FieldByName['PK_DUPLICATAS'].AsInteger > 0 then
              SQL.Add(SqlUpdDuplicata)
            else
              SQL.Add(SqlInsDuplicata);
            try
              ParamByName('FK_EMPRESAS').AsInteger   := FfkEmpresas;
              ParamByName('FK_CADASTROS').AsInteger  := afkCadastros;
              ParamByName('FK_DOCUMENTOS').AsInteger := apkDocumentos;
              if RowData.dbRow.FieldByName['PK_DUPLICATAS'].AsInteger > 1 then
                ParamByName('PK_DUPLICATAS').AsInteger :=
                  RowData.dbRow.FieldByName['PK_DUPLICATAS'].AsInteger
              else
              begin
                ParamByName('DTA_VENC').AsDateTime :=
                  RowData.dbRow.FieldByName['DTA_VENC'].AsDateTime;
                ParamByName('VLR_VENC').AsFloat    :=
                  RowData.dbRow.FieldByName['VLR_VENC'].AsFloat;
                ParamByName('FLAG_CBR_JUR').AsInteger :=
                  RowData.dbRow.FieldByName['FLAG_CBR_JUR'].AsInteger;
                RowData.dbRow.FieldByName['FK_EMPRESAS'].AsInteger := FfkEmpresas;
                RowData.dbRow.FieldByName['FK_CADASTROS'].AsInteger := afkCadastros;
                RowData.dbRow.FieldByName['FK_DOCUMENTOS'].AsInteger := apkDocumentos;
              end;
              ParamByName('VLR_ACR_DSCT').AsFloat :=
                RowData.dbRow.FieldByName['VLR_ACR_DSCT'].AsFloat;
              ParamByName('VLR_DSP_CBR').AsFloat  :=
                RowData.dbRow.FieldByName['VLR_DSP_CBR'].AsFloat;
              ParamByName('VLR_ODSP').AsFloat     :=
                RowData.dbRow.FieldByName['VLR_ODSP'].AsFloat;
              if ((RowData.dbRow.FieldByName['VLR_PGTO'].AsFloat > 0.009) and
                (RowData.dbRow.FieldByName['DTA_PGTO'].AsDateTime > 0)) then
              begin
                ParamByName('DTA_PGTO').AsDateTime :=
                  RowData.dbRow.FieldByName['DTA_PGTO'].AsDateTime;
                ParamByName('VLR_PGTO').AsFloat    :=
                  RowData.dbRow.FieldByName['VLR_PGTO'].AsFloat;
              end
              else
              begin
                ParamByName('DTA_PGTO').Clear;
                ParamByName('VLR_PGTO').Clear;
              end;
              ParamByName('HIST_LAN').AsString    :=
                RowData.dbRow.FieldByName['HIST_LAN'].AsString;
              ParamByName('FLAG_BAIXA').AsInteger :=
                RowData.dbRow.FieldByName['FLAG_BAIXA'].AsInteger;
                        //ParamByName('FLAG_PRE').AsInteger     :=RowData.dbRow['FLAG_PRE'].AsInteger;
              ExecSql;
            finally
              Close;
            end; // try
          end; // with dmSysFat.qrDocumento do
          if RowData.dbRow.FieldByName['PK_DUPLICATAS'].AsInteger < 1 then
          begin
            with dmSysFat.qrDuplicata do
            begin
              if Active then Close;
              SQL.Clear;
              SQL.Add(SqlDuplicata);
              try
                ParamByName('FK_EMPRESAS').AsInteger   := FfkEmpresas;
                ParamByName('FK_CADASTROS').AsInteger  := afkCadastros;
                ParamByName('FK_DOCUMENTOS').AsInteger := apkDocumentos;
                Open;
                if not (EOF) then
                  RowData.dbRow.FieldByName['PK_DUPLICATAS'].AsInteger :=
                    FieldByName('PK_DUPLICATAS').AsInteger;
              finally
                Close;
              end; // try
            end; // with
          end; // if PK_DUPLICATAS > 1
        end; // if ((RowData <> nil) and (RowData.dbRow <> nil)) then
      end; // for
    end;
    if FpkDocumentos < 1 then
      if Assigned(FOnInsertDocumento) then
        FOnInsertDocumento(FfkEmpresas, afkCadastros, apkDocumentos)
      else
    else
      if Assigned(FOnUpdateDocumento) then
        FOnUpdateDocumento(FfkEmpresas, afkCadastros, apkDocumentos);
    FpkDocumentos := apkDocumentos;
    FfkCadastros := afkCadastros;
    edNUM_DOC.AsInteger := aNumDoc;
    Result := True;
    EnableFields;
    Dados.CommitTransaction(dmSysFat.qrDocumento);
  except on Exception do
    begin
      Dados.RollbackTransaction(dmSysFat.qrDocumento);
      raise;
    end;
  end;
end;

procedure TfmEditDocumento.cmdUpdateClick(Sender : TObject);
begin
  if DocumentoSaved then;
end;

procedure TfmEditDocumento.HandleInsertDuplicata(adbRow : TDataRow);
var
  RowData: TRowData;
  Data:    PTreeData;
  Node:    PVirtualNode;
begin
  if adbRow = nil then
    Exit;
  RowData := TRowData.Create;
  RowData.dbRow := TDataRow.CreateAs(nil, adbRow);
  RowData.dbRow.CopyRowValues(adbRow);
  Node := stDuplicatas.AddChild(nil);
  Data := stDuplicatas.GetNodeData(Node);
  Data.RowData := RowData;
  RowData.Level := 0;
  RowData.Node := Node;
  FslDuplicatas.Add(RowData);
  stDuplicatas.FocusedNode := Node;
  FCurrentDuplicataNode    := Node;
  SignalizeChange(Self);
end;

procedure TfmEditDocumento.HandleUpdateDuplicata(adbRow : TDataRow);
var
  Data: PTreeData;
begin
  if ((adbRow = nil) or (FCurrentDuplicataNode = nil)) then
    Exit;
  Data := stDuplicatas.GetNodeData(FCurrentDuplicataNode);
  if ((Data = nil) or (Data.RowData = nil) or (Data.RowData.dbRow = nil)) then
    Exit;
  with Data.RowData do
    if ((dbRow.FieldByName['FK_EMPRESAS'].AsInteger <> adbRow.FieldByName['FK_EMPRESAS'].AsInteger) or
      (dbRow.FieldByName['FK_CADASTROS'].AsInteger <> adbRow.FieldByName['FK_CADASTROS'].AsInteger) or
      (dbRow.FieldByName['FK_DOCUMENTOS'].AsInteger <> dbRow.FieldByName['FK_DOCUMENTOS'].AsInteger) or
      (dbRow.FieldByName['PK_DUPLICATAS'].AsInteger <> dbRow.FieldByName['PK_DUPLICATAS'].AsInteger)) then
      Exit;
  Data.RowData.dbRow.CopyRowValues(adbRow);
  stDuplicatas.InvalidateNode(FCurrentDuplicataNode);
  SignalizeChange(Self);
end;

procedure TfmEditDocumento.FormKeyDown(Sender : TObject; var Key : Word;
  Shift : TShiftState);
begin
  if Key = vk_Escape then
    Close;
end;

end.
