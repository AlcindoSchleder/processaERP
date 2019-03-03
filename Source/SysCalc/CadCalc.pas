unit CadCalc;

interface

// erro na exlusão de motores e cancelamento
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadMod, Encryp, SyncSource, QExportDialog, Enter, DB, Menus,
  Buttons, StdCtrls, DBCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  Mask, ToolEdit, RXDBCtrl, VirtualTrees, CSDVirtualStringTree;

type
  TRegMotor = class(TObject)
  private
    PkTiposMotores: Integer;
    QtdPolo       : Integer;
    PotMotor      : Double;
    RotMotor      : Integer;
  public
    constructor Create;
  end;

  TCdCalculos = class(TCdModelo)
    pgCalc: TPageControl;
    tsBasicData: TTabSheet;
    tsCalc: TTabSheet;
    vtCalc: TCSDVirtualStringTree;
    TiposMotores: TDataSource;
    TipoMotoresVenda: TDataSource;
    Clientes: TDataSource;
    Parametros: TDataSource;
    vtMotors: TCSDVirtualStringTree;
    pData: TPanel;
    eDta_Calc: TDBDateEdit;
    lDta_Calc: TLabel;
    lFk_Parametros_Calc: TLabel;
    eFk_Parametros_Calc: TDBLookupComboBox;
    eFk_Cadastros: TDBLookupComboBox;
    lFk_Cadastros: TLabel;
    eDsc_Calc: TDBEdit;
    lDsc_Calc: TLabel;
    ePk_Calculos: TDBEdit;
    lPk_Calculos: TLabel;
    pMotors: TPanel;
    sbSave: TSpeedButton;
    sbDelete: TSpeedButton;
    sbCancel: TSpeedButton;
    stTabSheetName: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure pgCalcChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pgCalcChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbSaveClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure tbCloseClick(Sender: TObject);
    procedure vtMotorsColumnDefs1GetPickItems(Sender: TColumnDef;
      slItems: TStrings);
  private
    { Private declarations }
    FRegMotor : TRegMotor;
    FMotValues: TStrings;
    procedure ConfigTreeView;
    procedure HandleCalculoScroll;
    procedure ConfigTreeButtons(ASaveBtn, aCancelBtn, ADelBtn: TSpeedButton;
      Tree: TCSDVirtualStringTree);
    function  SaveRecords(DataSetName: string): Boolean;
  protected
    { Protected declarations }
    procedure FechaArquivos(DS: TDataSource); override;
    procedure PesquisaRegistros; override;
  public
    { Public declarations }
    procedure vtTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString); override;
    procedure vtTreeNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString); override;
    procedure vtTreeEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean); override;
  end;

var
  CdCalculos: TCdCalculos;

implementation

uses mSysCalc, Dado, ArqSql, ProcType, FuncoesDB, CmmConst, ModelTyp,
  dbObjects;

{$R *.dfm}

constructor TRegMotor.Create;
begin
  inherited Create;
  PkTiposMotores := 0;
  PotMotor       := 0.0;
  QtdPolo        := 0;
  RotMotor       := 0;
end;

procedure TCdCalculos.FormCreate(Sender: TObject);
begin
  pMotors.Caption        := Dados.GetStringMessage(LANGUAGE, 'sLstMotors', 'Lista de Motores');
  Dados.Image16.GetBitmap(36, sbSave.Glyph);
  Dados.Image16.GetBitmap(33, sbDelete.Glyph);
  Dados.Image16.GetBitmap(28, sbCancel.Glyph);
  MoveCampos             := True;
  inherited;
  vtMotors.RootNodeCount := 0;
  eSearch.CharCase       := ecUpperCase;
  dsMain.DataSet := dmSysCalc.Calculo;
  FMotValues     := TStringList.Create;
  MainFileName   := 'CALCULOS';
  MainPrefix     := 'Cal';
  NullSql        := 'FK_EMPRESAS is null';
  DefControl     := eDsc_Calc;
  VisibleEntrp   := True;
  PrimaryKey     := 'FK_EMPRESAS;PK_CALCULOS';
  with dmSysCalc do
  begin
    if not Tipos_Motores.Active then
    begin
      Tipos_Motores.SQL.Clear;
      Tipos_Motores.SQL.Add(SqlTiposMotores);
      Tipos_Motores.Open;
      Tipos_Motores.First;
      while not Tipos_Motores.EOF do
      begin
        if (Tipos_Motores.FindField('DSC_MOT') <> nil) and
           (Tipos_Motores.FindField('QTD_POLO') <> nil) and
           (Tipos_Motores.FindField('CV_MOT') <> nil) and
           (Tipos_Motores.FindField('PK_TIPOS_MOTORES') <> nil) then
        begin
            FRegMotor                := TRegMotor.Create;
            FRegMotor.PkTiposMotores := Tipos_Motores.FindField('PK_TIPOS_MOTORES').AsInteger;
            FRegMotor.PotMotor       := Tipos_Motores.FindField('CV_MOT').AsFloat;
            FRegMotor.QtdPolo        := Tipos_Motores.FindField('QTD_POLO').AsInteger;
            FRegMotor.RotMotor       := Tipos_Motores.FindField('RPM_MOT').AsInteger;
            FMotValues.AddObject(Tipos_Motores.FindField('DSC_MOT').AsString +
              ' - ' + Tipos_Motores.FindField('CV_MOT').AsString +
              ' - ' + Tipos_Motores.FindField('QTD_POLO').AsString, FRegMotor);
        end;
        Tipos_Motores.Next;
      end;
      Tipos_Motores.Close;
    end;
  end;
  MayInsertTree := True;
  AllowEditTree := True;
  EditMain      := False;
  dmSysCalc.MethodWOutPar := HandleCalculoScroll;
end;

procedure TCdCalculos.FechaArquivos(DS: TDataSource);
begin
  with dmSysCalc do
  begin
    if Clientes.Active            then Clientes.Close;
    if Tipos_Motores.Active       then Tipos_Motores.Close;
    if Parametros.Active          then Parametros.Close;
    if TrCalc.InTransaction       then TrCalc.Commit;
  end;
  inherited;
end;

procedure TCdCalculos.PesquisaRegistros;
begin
  inherited;
  with dmSysCalc do
  begin
    if not TrCalc.InTransaction then TrCalc.StartTransaction;
    if not Clientes.Active then
    begin
      Clientes.SQL.Clear;
      Clientes.SQL.Add(SqlClientes);
      Clientes.Open;
    end;
    if not Parametros.Active then
    begin
      Parametros.SQL.Clear;
      Parametros.SQL.Add(SqlParametros);
      Parametros.Open;
    end;
  end;
end;

procedure TCdCalculos.HandleCalculoScroll;
begin
  vtMotors.Enabled := (not (dsMain.DataSet.State in [dsEdit, dsInsert]));
  if vtMotors.Enabled then
  begin
    if (not Assigned(vtMotors.OnFocusChanging)) then
      SetTreeEvents(vtMotors, [vteFocusChanging, vteNewText,
        vteEdited, vteEditing, vteGetText, vtePaintText]);
    FillVirtualTreeView(vtMotors, dmSysCalc.Motores, SqlMotores, MayInsertTree);
    sbDelete.Visible := (vtMotors.RootNodeCount > 1);
  end;
end;

procedure TCdCalculos.pgCalcChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (not dmSysCalc.Calculo.IsEmpty) and (dsMain.State = dsBrowse) and
                 (not sbSave.Visible);
end;

procedure TCdCalculos.pgCalcChange(Sender: TObject);
begin
  MayInsertTree := True;
  AllowEditTree := True;
  case pgCalc.ActivePageIndex of
    0: ChangeScreenControl([taDataControl], True); // Turn on Screen Controls
    1: ConfigTreeView;
  end;
  with dmSysCalc do
  begin
    if Calculos.Active      then Calculos.Close;
    if TrCalc.InTransaction then TrCalc.CommitRetaining;
  end;
end;

procedure TCdCalculos.ConfigTreeView;
begin
// Turn off Screen Controls and set treeview to show calcs from STP_CALC_MOTORS
  MayInsertTree := False;
  AllowEditTree := False;
  ChangeScreenControl([taDisableAll], False);
  if (not Assigned(vtCalc.OnPaintText)) then
    SetTreeEvents(vtCalc, [vteGetText, vtePaintText]);
  with dmSysCalc do
  begin
    if Calculos.Active then Calculos.Close;
    Calculos.SQL.Clear;
    FillVirtualTreeView(vtCalc, Calculos, SqlCalculos, MayInsertTree);
  end;
end;

procedure TCdCalculos.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  inherited;
  for i := 0 to FMotValues.Count - 1 do
  begin
    FRegMotor := TRegMotor(FMotValues.Objects[i]);
    FRegMotor.Free;
  end;
  FMotValues.Clear;
  FMotValues.Free;
end;

procedure TCdCalculos.sbSaveClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  vtMotors.EndEditNode;
  vtMotors.AutoEdit := False;
  vtMotors.FocusedColumn := 0;
// Delete all lines of vtMotors from database and reopen dataSet to insert records
  with dmSysCalc do
  begin
    if InsMotors.Active then InsMotors.Close;
    if InsMotors.Transaction.InTransaction then
      InsMotors.Transaction.Commit;
    InsMotors.Sql.Clear;
    InsMotors.Sql.Add(SqlDeleteInsMotors);
    if not InsMotors.Transaction.InTransaction then InsMotors.Transaction.StartTransaction;
    if not InsMotors.Prepared then InsMotors.Prepare;
    InsMotors.ParamByName('Empresa').AsInteger := Calculo.FindField('FK_EMPRESAS').AsInteger;
    InsMotors.ParamByName('Calculo').AsInteger := Calculo.FindField('PK_CALCULOS').AsInteger;
    if not InsMotors.Active then InsMotors.ExecSQL;
    if InsMotors.Transaction.InTransaction then InsMotors.Transaction.Commit;
    InsMotors.Sql.Clear;
    InsMotors.Sql.Add(SqlInsertInsMotors);
    if not InsMotors.Transaction.InTransaction then
      InsMotors.Transaction.StartTransaction;
  end;
// Save all lines of vtMotors into database
  Node := vtMotors.GetFirst;
  while Node <> nil do
  begin
    Data := vtMotors.GetNodeData(Node);
    if not Data^.Row.FieldByName['PK_MOTORES'].IsNull then
    begin
      with dmSysCalc do
      begin
        if not InsMotors.Prepared then InsMotors.Prepare;
        InsMotors.ParamByName('FkEmpresas').AsInteger     := Calculo.FindField('FK_EMPRESAS').AsInteger;
        InsMotors.ParamByName('FkCalculos').AsInteger     := Calculo.FindField('PK_CALCULOS').AsInteger;
        InsMotors.ParamByName('FkTiposMotores').AsInteger := Data^.Row.FieldByName['FK_TIPOS_MOTORES'].AsInteger;
        InsMotors.ParamByName('DscMot').AsString          := Data^.Row.FieldByName['DSC_MOT'].AsString;
        InsMotors.ParamByName('QtdPolos').AsInteger       := Data^.Row.FieldByName['QTD_POLOS'].AsInteger;
        InsMotors.ParamByName('PotMot').AsFloat           := Data^.Row.FieldByName['POT_MOT'].AsFloat;
        InsMotors.ParamByName('RotMot').AsInteger         := Data^.Row.FieldByName['ROT_MOT'].AsInteger;
        InsMotors.ParamByName('CrrMed').AsFloat           := Data^.Row.FieldByName['CRR_MED'].AsFloat;
        InsMotors.ParamByName('CrrTrc').AsFloat           := Data^.Row.FieldByName['CRR_TRC'].AsFloat;
        InsMotors.ParamByName('QtdMot').AsInteger         := Data^.Row.FieldByName['QTD_MOT'].AsInteger;
        try
          InsMotors.ExecSQL;
          if InsMotors.Transaction.InTransaction then InsMotors.Transaction.CommitRetaining;
        except on E:Exception do
          begin
            Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
              'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
              ['Insumos_Barras']) + #13 + E.Message), PAnsiChar(Application.Title),
              MB_OK + MB_ICONSTOP);
            vtMotors.Selected[Node] := True;
            exit;
          end; // begin exception
        end; // try
      end; // with dmSysCalc
    end; // if
    if Assigned(Data^.Row.UserData) then Data^.Row.UserData := nil;
    Node := vtMotors.GetNext(Node);
  end; // while
  with dmSysCalc do
  begin
    if InsMotors.Active then InsMotors.Close;
    try
      if InsMotors.Transaction.InTransaction then
        InsMotors.Transaction.Commit;
    except on E:Exception do
      Application.MessageBox(PAnsiChar(Format(Dados.GetStringMessage(LANGUAGE, 'sDataSetInsError',
        'Erro: Ocorreu um erro na inserção dos registros na tabela %s '),
        ['Insumos_Barras']) + #13 + E.Message), PAnsiChar(Application.Title),
        MB_OK + MB_ICONSTOP);
    end; // try
  end; // with
  if sbSave.Visible   then sbSave.Visible   := False;
  if sbCancel.Visible then sbCancel.Visible := False;
  if not sbSave.Visible then
    ChangeScreenControl([taDataControl], True);
end;

procedure TCdCalculos.sbDeleteClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  vtMotors.EndEditNode;
  vtMotors.FocusedColumn := 0;
  Node := vtMotors.GetFirstSelected;
  Data := vtMotors.GetNodeData(Node);
  if (Data^.Row.FieldByName['PK_MOTORES'].AsInteger > 0) then
    vtMotors.DeleteNode(Node);
  Node := vtMotors.GetFirst;
  Data := vtMotors.GetNodeData(Node);
  sbDelete.Visible := (Data^.Row.FieldByName['PK_MOTORES'].AsInteger > 0) and
                      (vtMotors.RootNodeCount > 0);
  if not sbSave.Visible then sbSave.Visible := True;
  ChangeScreenControl([taDisableAll], False);
end;

procedure TCdCalculos.sbCancelClick(Sender: TObject);
begin
  if sbSave.Visible then
    if SaveRecords(Dados.GetStringMessage(LANGUAGE, 'sSaveBarComp',
       'Código de Barras ou Composições')) then
      exit;
  vtMotors.EndEditNode;
  ReleaseTreeNodes(vtMotors);
  if sbSave.Visible    then sbSave.Visible    := False;
  if sbDelete.Visible  then sbDelete.Visible  := False;
  if sbCancel.Visible  then sbCancel.Visible  := False;
  ChangeScreenControl([taDataControl], True);
  FillVirtualTreeView(vtMotors, dmSysCalc.Motores, SqlMotores, MayInsertTree);
  sbDelete.Visible := (vtMotors.RootNodeCount > 1);
end;

procedure TCdCalculos.vtTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data  : PGridData;
  Idx, i: Integer;
  RegMot: TRegMotor;
begin
  inherited;
  if Sender.Name = 'vtCalc' then exit;
  Data    := Sender.GetNodeData(Node);
  if (Column = 1) and (FMotValues.Count > 0) then
  begin
    Idx   := -1;
    for i := 0 to FMotValues.Count - 1 do
    begin
      RegMot := TRegMotor(FMotValues.Objects[i]);
      if Assigned(FRegMotor) and
         (Data^.Row.FieldByName['FK_TIPOS_MOTORES'].AsInteger = RegMot.PkTiposMotores) then
      begin
        Idx := i;
        break;
      end;
    end;
    if Idx > -1 then
      CellText := FMotValues.Strings[Idx]
    else
      CellText := '';
  end;
end;

procedure TCdCalculos.vtTreeNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PGridData;
  Idx: Integer;
  RegMot: TRegMotor;
begin
  inherited;
  if Sender.Name = 'vtCalc' then exit;
  Data := Sender.GetNodeData(Node);
  if (Column = 1) and (FMotValues.Count > 0) then
    if FMotValues.IndexOf(NewText) <> -1 then
    begin
      Idx := FMotValues.IndexOf(NewText);
      if Idx > -1 then
      begin
        RegMot := TRegMotor(FMotValues.Objects[Idx]);
        if Assigned(RegMot) then
        begin
          Data^.Row.FieldByName['FK_TIPOS_MOTORES'].AsInteger := RegMot.PkTiposMotores;
          Data^.Row.FieldByName['POT_MOT'].AsFloat            := RegMot.PotMotor;
          Data^.Row.FieldByName['ROT_MOT'].AsInteger          := RegMot.RotMotor;
          Data^.Row.FieldByName['QTD_POLOS'].AsInteger        := RegMot.QtdPolo;
        end
        else
          Data^.Row.Fields[Column].Clear;
      end
      else
        Data^.Row.Fields[Column].Clear;
    end
    else
      Data^.Row.Fields[Column].Clear;
end;

procedure TCdCalculos.vtTreeEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  Data: PGridData;
begin
  inherited;
  if Sender.Name = 'vtCalc' then exit;
  Data := Sender.GetNodeData(Node);
  if Data^.Row.FieldByName['QTD_MOT'].AsInteger <= 0 then
    Data^.Row.FieldByName['QTD_MOT'].AsInteger := 1;
  Data^.Row.FieldByName['PK_MOTORES'].AsInteger := Node^.Index + 1;
  ChangeScreenControl([taDisableAll], False);
  ConfigTreeButtons(sbSave, sbCancel, sbDelete, vtMotors);
end;

procedure TCdCalculos.ConfigTreeButtons(ASaveBtn, aCancelBtn, ADelBtn: TSpeedButton;
  Tree: TCSDVirtualStringTree);
begin
  if ASaveBtn <> nil then
    ASaveBtn.Visible := True;
  if ACancelBtn <> nil then
    ACancelBtn.Visible := True;
  if (Tree.RootNodeCount > 1) and (ADelBtn <> nil) then
    ADelBtn.Visible := True;
end;

function  TCdCalculos.SaveRecords(DataSetName: string): Boolean;
begin
  if Application.MessageBox(PAnsiChar(VarModel[Integer(tcModFile1)] +
     ' ' + DataSetName + ' ' + VarModel[Integer(tcModFile2)]),
     PAnsiChar(Application.Title), MB_ICONWARNING + MB_YESNO +
     MB_DEFBUTTON2) = IDNO then
    Result := True
  else
    Result := False;
end;

procedure TCdCalculos.tbCloseClick(Sender: TObject);
begin
  if sbSave.Visible then
    if SaveRecords(Dados.GetStringMessage(LANGUAGE, 'sSaveBarComp',
       'Planilha de Cálculos')) then
      exit;
  inherited;
end;

procedure TCdCalculos.vtMotorsColumnDefs1GetPickItems(Sender: TColumnDef;
  slItems: TStrings);
begin
  if (FMotValues <> nil) and (Sender.Index = 1) and (slItems.Count = 0) then
    slItems.AddStrings(FMotValues);
end;

end.
