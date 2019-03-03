unit CadRel;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder based in the TdbObjects from CSD Informática *}
{* Copyright: © 2004 by Alcindo Schleder. All rights reserved.           *}
{* Created: 09/09/2004 - DD/MM/YYYY                                      *}
{* Modified: 09/02/2006 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails.                  *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses SysUtils, Classes, VirtualTrees, ProcType, GridRow, ProcUtils, DB, frxClass,
     frxPreview, frxDesgn, frxDMPClass, TeeProcs, TeEngine, Chart, Mask, CurrEdit,
     Series,
  {$IFNDEF LINUX}
    Windows, Graphics, Controls, Forms, Dialogs, ToolWin, ComCtrls, StdCtrls,
    ExtCtrls, Buttons, ToolEdit, Menus
  {$ELSE}
    Qt, QGraphics, QControls, QForms, QDialogs, QToolWin, QComCtrls, QStdCtrls,
    QExtCtrls, QButtons, QToolEdit, QMenus
  {$ENDIF};

type
  TReportKey = record
    Language: string[5];
    Module  : Integer;
    Report  : Integer;
  end;

  TOperatorFlags = record
    FlagBrw: Boolean;
    FlagFnd: Boolean;
    FlagIns: Boolean;
    FlagUpd: Boolean;
    FlagDel: Boolean;
    FlagVis: Boolean;
  end;

  TCdReports = class(TForm)
    cbTools: TCoolBar;
    tbTools: TToolBar;
    tbClose: TToolButton;
    tbSepSave: TToolButton;
    sbStatus: TStatusBar;
    vtGrid: TVirtualStringTree;
    tbSepClose: TToolButton;
    tbDesignEdit: TToolButton;
    tbInsert: TToolButton;
    tbDelete: TToolButton;
    tbCancel: TToolButton;
    tbSepOper: TToolButton;
    tbSave: TToolButton;
    pgReport: TPageControl;
    tsDesigner: TTabSheet;
    tsData: TTabSheet;
    lPk_Produtos: TStaticText;
    ePk_Relatorios: TCurrencyEdit;
    lFlag_Graph: TCheckBox;
    eDsc_Rel: TEdit;
    lDsc_Prod: TStaticText;
    lDsc_Graph: TStaticText;
    eDsc_Graph: TEdit;
    pgGraph: TPageControl;
    tsGraphSql: TTabSheet;
    eSql_Graph: TMemo;
    tsGraph: TTabSheet;
    Chart1: TChart;
    frDesigner: TfrxDesigner;
    Splitter1: TSplitter;
    tbSepDesign: TToolButton;
    tbReportOptions: TToolButton;
    pmReportOpt: TPopupMenu;
    pmPageSettings: TMenuItem;
    pmToolBars: TMenuItem;
    pmStandart: TMenuItem;
    pmText: TMenuItem;
    pmFrame: TMenuItem;
    pmAlignment: TMenuItem;
    pmTools: TMenuItem;
    pmInspector: TMenuItem;
    pmDataTree: TMenuItem;
    pmReportTree: TMenuItem;
    N1: TMenuItem;
    pmShowRulers: TMenuItem;
    pmShowGuides: TMenuItem;
    pmDeleteGuides: TMenuItem;
    pmOptions: TMenuItem;
    N2: TMenuItem;
    sbDesigner: TScrollBox;
    Series1: TBarSeries;
    Series2: TFastLineSeries;
    odReport: TOpenDialog;
    pmSave: TPopupMenu;
    pmSaveAs: TMenuItem;
    pmDesigner: TPopupMenu;
    pmDesignClose: TMenuItem;
    lFlag_Matrix: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtGridGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtGridGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure tbCloseClick(Sender: TObject);
    procedure tbAboutClick(Sender: TObject);
    procedure vtGridFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vtGridFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure tbSaveClick(Sender: TObject);
    procedure tbDeleteClick(Sender: TObject);
    procedure tbDesignEditClick(Sender: TObject);
    procedure pmDesignCloseClick(Sender: TObject);
    function frDesignerSaveReport(Report: TfrxReport;
      SaveAs: Boolean): Boolean;
    procedure pmToolBarsClick(Sender: TObject);
    procedure pmSaveAsClick(Sender: TObject);
    procedure vtGridDblClick(Sender: TObject);
    procedure tbInsertClick(Sender: TObject);
    procedure sbStatusClick(Sender: TObject);
    procedure sbStatusDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure sbStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbCancelClick(Sender: TObject);
    procedure eDsc_RelChange(Sender: TObject);
  private
    { Private declarations }
    FdrReport    : TDataRow;
    FKey         : TReportKey;
    FSecLevel    : TOperationLevel;
    FDesigner    : TfrxDesignerForm;
    FScrState    : TDBMode;
    FCompanyClick: Boolean;
    FRect        : TRect;
    procedure GetModulesData;
    procedure DeleteRecord;
    function  SaveAllData(AState: TDBMode): Boolean;
    procedure SetdrReport(AValue: TDataRow);
    procedure SetScrState(AValue: TDBMode);
  public
    { Public declarations }
    property  drReport: TDataRow read FdrReport write SetdrReport;
    property  ScrState: TDBMode  read FScrState write SetScrState;
  end;

implementation

{$R *.dfm}

uses Sobre, Dado, FuncoesDB, CmmConst, ArqSqlRel, mSysRel, mReport, SelEmpr;

procedure TCdReports.FormCreate(Sender: TObject);
begin
  vtGrid.NodeDataSize      := SizeOf(TGridData);
  cbTools.Images           := Dados.Image16;
  tbTools.Images           := Dados.Image16;
  vtGrid.Images            := Dados.Image16;
  vtGrid.Header.Images     := Dados.Image16;
  ScrState                 := dbmBrowse;
  FKey.Language            := LANGUAGE;
  FKey.Module              := 0;
  FKey.Report              := 0;
end;

procedure TCdReports.FormActivate(Sender: TObject);
begin
  with Dados.Parametros do
  begin
    Caption         := Application.Title + ' - ' + soProgramTitle;
    FSecLevel       := soUserOperation;
  end;
  if vtGrid.RootNodeCount = 0 then
    GetModulesData;
end;

procedure TCdReports.FormDestroy(Sender: TObject);
begin
  dmReport.frReport.Clear;
  OnActivate := nil;
  FDesigner.Free;
  FDesigner := nil;
  ReleaseTreeNodes(vtGrid);
end;

procedure TCdReports.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then Close;
end;

procedure TCdReports.SetScrState(AValue: TDBMode);
begin
  FScrState           := AValue;
  tbSave.Enabled      := (FScrState in UPDATE_MODE);
  tbCancel.Enabled    := (FScrState in UPDATE_MODE);
  tbDelete.Enabled    := (FScrState in SCROLL_MODE);
  tbInsert.Enabled    := (FScrState in SCROLL_MODE);
  sbStatus.Repaint;
end;

procedure TCdReports.SetdrReport(AValue: TDataRow);
var
  MS: TStream;
begin
  if (AValue.Level = 0) then
    FdrReport             := nil
  else
    FdrReport             := AValue;
  dmReport.frReport.Clear;
  tbDesignEdit.Enabled    := (FdrReport <> nil) and (FdrReport.Level > 0) and
                             (FdrReport.FindField['REL_SYS'] <> nil) and
                             (FdrReport.FieldByName['REL_SYS'].IsBlob) and
                             (FdrReport.FieldByName['REL_SYS'].DataSize > 0);
  pmDesignClose.Enabled   := tbDesignEdit.Enabled;
  pmSaveAs.Enabled        := tbDesignEdit.Enabled;
  tbDelete.Enabled        := tbDesignEdit.Enabled;
  tbReportOptions.Enabled := tbDesignEdit.Enabled;
  if (FdrReport = nil) then
  begin
    FKey.Module           := 0;
    FKey.Report           := 0;
    ePk_Relatorios.Value  := 0;
    exit;
  end;
  FKey.Module             := FdrReport.FieldByName['PK_MODULOS'].AsInteger;
  FKey.Report             := FdrReport.FieldByName['PK_RELATORIOS'].AsInteger;
  ePk_Relatorios.Value    := FdrReport.FieldByName['PK_RELATORIOS'].AsInteger;
  lFlag_Graph.Checked     := (FdrReport.FieldByName['FLAG_GRAPH'].AsInteger = 1);
  lFlag_Matrix.Checked    := (FdrReport.FieldByName['FLAG_MATRIX'].AsInteger = 1);
  dmReport.frReport.DotMatrixReport := lFlag_Matrix.Checked;
  eDsc_Rel.Text           := FdrReport.FieldByName['DSC_REL'].AsString;
  if FdrReport.FieldByName['DSC_GRAPH'].AsString = '' then
    eDsc_Graph.Text       := FdrReport.FieldByName['DSC_GRAPH'].AsString
  else
    eDsc_Graph.Text       := ' ';
  if (not tbDesignEdit.Enabled) then exit;
  if (FdrReport.FindField['REL_SYS'] <> nil) and // Show Report at Screen
     (FdrReport.FieldByName['REL_SYS'].IsBlob) and
     (FdrReport.FieldByName['REL_SYS'].DataSize > 0) then
  begin
    MS := TMemoryStream.Create;
    try
      MS.Position := 0;
      FdrReport.FieldByName['REL_SYS'].SaveToStream(MS, buValue);
      MS.Position := 0;
      try
        dmReport.frReport.LoadFromStream(MS);
      except on E:Exception do
        begin
          dmReport.frReport.Clear;
          if (Dados.DisplayMessage('SetdrReport: Erro ao carregar o relatório. ' +
              E.Message + NL + 'Deseja carregar um relatório do disco?', hiError,
              [mbYes, mbNo]) = mrYes) then
          begin
            if (odReport.Execute) and (FileExists(odReport.FileName)) then
            begin
              dmReport.frReport.LoadFromFile(odReport.FileName);
              ScrState := dbmEdit;
            end
          end
          else
            dmReport.CreateNewReport;
        end;
      end;
      if (ScrState <> dbmInsert) then
        tbDesignEdit.Click;
    finally
      FreeAndNil(MS)
    end;
  end;
end;

procedure TCdReports.GetModulesData;
var
  aMod: string;
  NodeLevel0,
  NodeLevel1,
  FirstReport: PVirtualNode;
  Data: PGridData;
begin
  NodeLevel0 := nil;
  ReleaseTreeNodes(vtGrid);
  FirstReport := nil;
  aMod  := '';
  with dmSysRel do
  begin
    if qrReport.Active then qrReport.Close;
    qrReport.SQL.Clear;
    qrReport.SQL.Add(SqlAllReports);
    if (qrReport.Params.FindParam('FkLinguagens') <> nil) then
      qrReport.ParamByName('FkLinguagens').AsString := LANGUAGE;
    if not qrReport.Active then qrReport.Open;
    vtGrid.BeginUpdate;
    try
      qrReport.First;
      while not qrReport.Eof do
      begin
        if (aMod <> qrReport.FieldByName('DSC_MOD').AsString) then
        begin
          NodeLevel0    := vtGrid.AddChild(nil);
          Data          := vtGrid.GetNodeData(NodeLevel0);
          Data^.Level   := 0;
          Data^.Node    := NodeLevel0;
          Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrReport, True);
          Data^.DataRow.Level := Data^.Level;
          aMod          := qrReport.FieldByName('DSC_MOD').AsString;
        end;
        if (qrReport.FieldByName('PK_RELATORIOS').AsInteger > 0) and
           (NodeLevel0 <> nil) then
        begin
          NodeLevel1    := vtGrid.AddChild(NodeLevel0);
          Data          := vtGrid.GetNodeData(NodeLevel1);
          Data^.Level   := 1;
          Data^.Node    := NodeLevel1;
          Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrReport, True);
          Data^.DataRow.Level := Data^.Level;
          if (FirstReport = nil) then FirstReport := NodeLevel1;
        end;
        qrReport.Next;
      end;
    finally
      vtGrid.EndUpdate;
      qrReport.Close;
    end;
  end;
  if VtGrid.RootNodeCount = 0 then exit;
  if (FirstReport = nil) then
    FirstReport                := vtGrid.GetFirst;
  vtGrid.FocusedNode           := FirstReport;
  vtGrid.Selected[FirstReport] := True;
end;

procedure TCdReports.vtGridGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := vtGrid.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := ' ';
  if Column = 0 then
  begin
    case vtGrid.GetNodeLevel(Node) of
      0: CellText := Data^.DataRow.FieldByName['DSC_MOD'].AsString;
      1: CellText := Data^.DataRow.FieldByName['DSC_REL'].AsString;
    end;
  end
end;

procedure TCdReports.vtGridGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PGridData;
begin
  if (Node = nil) or (Column > 0) or (Kind in [ikOverlay, ikState]) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  Ghosted := False;
  case Sender.GetNodeLevel(Node) of
    0: Imageindex := 85;
    1: Imageindex := 6;
  end;
end;

procedure TCdReports.vtGridFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  if (OldNode = nil) or (NewNode = nil) then exit;
  if (vtGrid.GetNodeLevel(OldNode) = 0) and (vtGrid.Expanded[OldNode]) then
    vtGrid.FullCollapse(OldNode);
  if (vtGrid.GetNodeLevel(OldNode) = 0) and (not vtGrid.Expanded[NewNode]) then
    vtGrid.FullExpand(NewNode);
end;

procedure TCdReports.vtGridFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data   : PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data <> nil) and (Data^.DataRow <> nil) then
  begin
    pmDesignClose.Click;
    drReport   := Data^.DataRow;
  end;
end;

procedure TCdReports.tbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCdReports.tbAboutClick(Sender: TObject);
begin
  Application.CreateForm(TfrmAboutProcessa, frmAboutProcessa);
  try
    frmAboutProcessa.ShowModal;
  finally
    frmAboutProcessa.Free;
  end;
end;

procedure TCdReports.DeleteRecord;
begin
  with dmSysRel do
  begin
    Dados.StartTransaction(qrReport);
    if qrReport.Active then qrReport.Close;
    qrReport.SQL.Clear;
    qrReport.SQL.Add(SqlDelReport);
    if qrReport.Params.FindParam('FkLinguagem')  <> nil then
      qrReport.ParamByName('FkLinguagem').AsString   := LANGUAGE;
    if qrReport.Params.FindParam('FkModulos')    <> nil then
      qrReport.ParamByName('FkModulos').AsInteger    := FKey.Module;
    if qrReport.Params.FindParam('PkRelatorios') <> nil then
      qrReport.ParamByName('PkRelatorios').AsInteger := FKey.Report;
    try
      qrReport.ExecSQL;
      Dados.CommitTransaction(qrReport);
    except on E:Exception do
      begin
        Dados.RollbackTransaction(qrReport);
        raise Exception.CreateFmt('CdProgramas Post: Erro na Exclusao do Registro. (%s)',
          [E.Message]);
      end;
    end;
  end;
end;

function  TCdReports.SaveAllData(AState: TDBMode): Boolean;
var
  MS: TStream;
begin
  Result := False;
  if (not (AState in [dbmInsert, dbmEdit])) or (FdrReport = nil) then exit;
  with dmSysRel do
  begin
    // Save Program Data
    Dados.StartTransaction(qrReport);
    if qrReport.Active then qrReport.Close;
    qrReport.SQL.Clear;
    if AState = dbmInsert then
      qrReport.SQL.Add(SqlInsReport);
    if AState = dbmEdit then
      qrReport.SQL.Add(SqlUpdReport);
    if qrReport.Params.FindParam('FkLinguagens') <> nil then
      qrReport.ParamByName('FkLinguagens').AsString := LANGUAGE;
    if qrReport.Params.FindParam('PkRelatorios') <> nil then
    begin
      if (AState = dbmEdit) then
        qrReport.ParamByName('PkRelatorios').AsInteger   := FKey.Report;
      if (AState = dbmInsert) then
        qrReport.ParamByName('PkRelatorios').AsInteger   := 0;
    end;
    if qrReport.Params.FindParam('FkModulos') <> nil then
      qrReport.ParamByName('FkModulos').AsInteger   := FKey.Module;
    if qrReport.Params.FindParam('FlagMatrix') <> nil then
      qrReport.ParamByName('FlagMatrix').AsInteger     := Ord(lFlag_Matrix.Checked);
    if qrReport.Params.FindParam('FlagGraph') <> nil then
      qrReport.ParamByName('FlagGraph').AsInteger     :=
        FdrReport.FieldByName['FLAG_GRAPH'].AsInteger;
    if qrReport.Params.FindParam('DscGraph') <> nil then
      qrReport.ParamByName('DscGraph').AsString := eDsc_Graph.Text;
    if qrReport.Params.FindParam('DscRel') <> nil then
      qrReport.ParamByName('DscRel').AsString := eDsc_Rel.Text;
    if (qrReport.Params.FindParam('RelSys') <> nil) then
    begin
      MS := TMemoryStream.Create;
      try
        MS.Position := 0;
        FdrReport.FieldByName['REL_SYS'].SaveToStream(MS, buValue);
        MS.Position := 0;
        qrReport.ParamByName('RelSys').LoadFromStream(MS,
          FdrReport.FieldByName['REL_SYS'].DataType);
      finally
        FreeAndNil(MS);
      end;
    end;
    try
      qrReport.ExecSQL;
      Dados.CommitTransaction(qrReport);
    except on E:Exception do
      begin
        Dados.RollbackTransaction(qrReport);
        raise Exception.CreateFmt('CdProgramas Post: Erro na Gravação do Registro. (%s)',
          [E.Message]);
      end;
    end;
  end;
end;

procedure TCdReports.vtGridDblClick(Sender: TObject);
begin
  if (FdrReport = nil) or (FdrReport.Level = 0) or
     (FdrReport.FieldByName['PK_RELATORIOS'].AsInteger = 0) then
    exit;
  ePk_Relatorios.Value := FdrReport.FieldByName['PK_RELATORIOS'].AsInteger;
  lFlag_Graph.Checked  := (FdrReport.FieldByName['FLAG_GRAPH'].AsInteger = 1);
  eDsc_Rel.Text        := FdrReport.FieldByName['DSC_REL'].AsString;
  if FdrReport.FieldByName['DSC_GRAPH'].AsString = '' then
    eDsc_Graph.Text      := FdrReport.FieldByName['DSC_GRAPH'].AsString
  else
    eDsc_Graph.Text      := ' ';
  pgGraph.Enabled      := lFlag_Graph.Checked;
  pgReport.ActivePageIndex := 1;
  tbDesignEdit.Enabled := True;
end;

procedure TCdReports.tbSaveClick(Sender: TObject);
begin
  SaveAllData(FScrState);
  pgReport.ActivePage := tsDesigner;
  if (tbDesignEdit.Enabled) then tbDesignEditClick(Self);
  ScrState := dbmBrowse;
end;

procedure TCdReports.tbDeleteClick(Sender: TObject);
begin
  DeleteRecord;
end;

procedure TCdReports.tbDesignEditClick(Sender: TObject);
begin
  pgReport.ActivePageIndex := 0;
  dmReport.frReport.Script.ClearItems(dmReport.frReport);
  dmReport.frReport.Modified     := False;
//  dmReport.frReport.DesignReport := FDesigner;
  if FDesigner = nil then
  begin
    FDesigner := TfrxDesignerForm.CreateDesigner(nil, dmReport.frReport);
    dmReport.frReport.Designer := FDesigner;
    FDesigner.Parent           := sbDesigner;
    FDesigner.BorderStyle      := bsNone;
    FDesigner.Align            := alClient;
    pmToolBars.Caption         := FDesigner.ToolbarsMI.Caption;
    pmPageSettings.Action      := FDesigner.PageSettingsCmd;
    pmPageSettings.OnClick     := FDesigner.PageSettingsCmdExecute;
    pmPageSettings.Caption     := FDesigner.PageSettingsMI.Caption;
{    pmShowRulers.OnClick       := FDesigner.ShowRulersMIClick;
    pmShowRulers.Caption       := FDesigner.ShowRulersMI.Caption;
    pmShowGuides.OnClick       := FDesigner.ShowGuidesMIClick;
    pmShowGuides.Caption       := FDesigner.ShowGuidesMI.Caption;
    pmDeleteGuides.OnClick     := FDesigner.DeleteGuidesMIClick;
    pmDeleteGuides.Caption     := FDesigner.DeleteGuidesMI.Caption;
    pmOptions.OnClick          := FDesigner.OptionsMIClick;
    pmOptions.Caption          := FDesigner.OptionsMI.Caption;
    pmStandart.OnClick         := FDesigner.ToolbarsMIClick;
    pmStandart.Checked         := FDesigner.StandardMI.Checked;
    pmStandart.Caption         := FDesigner.StandardMI.Caption;
    pmText.OnClick             := FDesigner.ToolbarsMIClick;
    pmText.Checked             := FDesigner.TextMI.Checked;
    pmText.Caption             := FDesigner.TextMI.Caption;
    pmFrame.OnClick            := FDesigner.ToolbarsMIClick;
    pmFrame.Checked            := FDesigner.FrameMI.Checked;
    pmFrame.Caption            := FDesigner.FrameMI.Caption;
    pmAlignment.OnClick        := FDesigner.ToolbarsMIClick;
    pmAlignment.Checked        := FDesigner.AlignmentMI.Checked;
    pmAlignment.Caption        := FDesigner.AlignmentMI.Caption;
    pmTools.OnClick            := FDesigner.ToolbarsMIClick;
    pmTools.Checked            := FDesigner.ToolsMI.Checked;
    pmTools.Caption            := FDesigner.ToolsMI.Caption;
    pmInspector.OnClick        := FDesigner.ToolbarsMIClick;
    pmInspector.Checked        := FDesigner.InspectorMI.Checked;
    pmInspector.Caption        := FDesigner.InspectorMI.Caption;
    pmDataTree.OnClick         := FDesigner.ToolbarsMIClick;
    pmDataTree.Checked         := FDesigner.DataTreeMI.Checked;
    pmDataTree.Caption         := FDesigner.DataTreeMI.Caption;
    pmReportTree.OnClick       := FDesigner.ToolbarsMIClick;
    pmReportTree.Checked       := FDesigner.ReportTreeMI.Checked;
    pmReportTree.Caption       := FDesigner.ReportTreeMI.Caption;}
  end;
  FDesigner.Show;
end;

procedure TCdReports.pmDesignCloseClick(Sender: TObject);
begin
  if Assigned(FDesigner) then
  begin
    FDesigner.Close;
    FDesigner.Free;
    FDesigner := nil;
  end;
end;

function TCdReports.frDesignerSaveReport(Report: TfrxReport;
  SaveAs: Boolean): Boolean;
var
  MS: TStream;
begin
  Result := True;
  if SaveAs then
    FDesigner.SaveFile(True, False);
  if Report.Modified then
  begin
    if FScrState = dbmBrowse then
      ScrState := dbmEdit;
    if (FdrReport = nil) or (FdrReport.Level = 0) then exit;
    MS := TMemoryStream.Create;
    try
      MS.Position := 0;
      dmReport.frReport.SaveToStream(MS);
      MS.Position := 0;
      FdrReport.FieldByName['REL_SYS'].LoadFromStream(MS, buValue);
      tbDesignEdit.Click;
    finally
      FreeAndNil(MS);
    end;
  end;
end;

procedure TCdReports.pmToolBarsClick(Sender: TObject);
begin
//  FDesigner.ToolbarsMIClick(Sender);
end;

procedure TCdReports.pmSaveAsClick(Sender: TObject);
begin
  FDesigner.SaveAsCmdExecute(Sender);
end;

procedure TCdReports.tbInsertClick(Sender: TObject);
var
  Node : PVirtualNode;
  Data : PGridData;
  aData: TDataRow;
  M    : TMemoryStream;
  aFt  : TFieldType;
begin
// insert a New Report
  if (odReport.Execute) and (FileExists(odReport.FileName)) then
  begin
    Node    := vtGrid.FocusedNode;
    if (Node = nil) then exit;
    Data    := vtGrid.GetNodeData(Node);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    aData := Data^.DataRow;
    vtGrid.BeginUpdate;
    M := TMemoryStream.Create;
    try
      Node          := vtGrid.AddChild(Node);
      Data          := vtGrid.GetNodeData(Node);
      Data^.Level   := 1;
      Data^.Node    := Node;
      aFt := aData.FieldByName['REL_SYS'].DataType;
      aData.FieldByName['REL_SYS'].Clear;
      Data^.DataRow := TDataRow.CreateAs(nil, aData);
      Data^.DataRow.Level := Data^.Level;
      Data^.DataRow.FieldByName['PK_RELATORIOS'].AsInteger := 0;
      Data^.DataRow.FieldByName['FLAG_GRAPH'].AsInteger    := 0;
      Data^.DataRow.FieldByName['DSC_REL'].AsString        := 'Novo Relatório';
      Data^.DataRow.FieldByName['DSC_GRAPH'].AsString      := ' ';
      M.Position := 0;
      M.LoadFromFile(odReport.FileName);
      M.Position := 0;
      if (Data^.DataRow.FindField['REL_SYS'] = nil) then
        Data^.DataRow.AddAs('REL_SYS', 0, aFt, 0);
      Data^.DataRow.FieldByName['REL_SYS'].LoadFromStream(M, buValue);
    finally
      FreeAndNil(M);
      vtGrid.EndUpdate;
    end;
    pgReport.ActivePage := tsData;
    ScrState := dbmInsert;
    vtGrid.Selected[Node] := True;
    vtGrid.FocusedNode := Node;
  end;
end;

procedure TCdReports.sbStatusClick(Sender: TObject);
begin
  if (not FCompanyClick) then exit;
  Application.CreateForm(TSelEmpresa, SelEmpresa);
  try
    SelEmpresa.ShowModal;
  finally
    SelEmpresa.Free;
  end;
  sbStatus.Canvas.TextOut(FRect.Left + 22, FRect.Top + 1, ' Empresa: ' +
    InsereZer(IntToStr(Dados.PkCompany), 3) + '/' + Dados.NameCompany);
end;

procedure TCdReports.sbStatusDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  X: Integer;
begin
  with StatusBar.Canvas do
  begin
    Font.Style := [FsBold];
    if Panel.Index = 1 then
    begin
        Brush.Color := Self.Color;
        FRect := Rect;
        FillRect(Rect);
        Font.Name := 'Arial';
        Font.Color := ClNavy;
        Dados.Image16.Draw(StatusBar.Canvas, Rect.Left + 1, Rect.Top, 26);
        TextOut(Rect.Left + 22, Rect.Top + 1, ' Empresa: ' +
          InsereZer(IntToStr(Dados.PkCompany), 3) + '/' + Dados.NameCompany);
    end;
    if Panel.Index = 2 then
    begin
      FillRect(Rect);
      Font.Color  := FontColorMode[FScrState];
      Brush.Color :=     ColorMode[FScrState];
      X := (((StatusBar.Width - 20) - Rect.Left) div 2) -
           (TextWidth(ModeTypes[FScrState]) div 2);
      TextRect(Rect, Rect.Left + X, Rect.Top, ModeTypes[FScrState]);
    end;
  end;
end;

procedure TCdReports.sbStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FCompanyClick := (X >= FRect.TopLeft.X) and (Y >= FRect.TopLeft.Y) and
                   (Y <= (FRect.TopLeft.Y + 22));
end;

procedure TCdReports.tbCancelClick(Sender: TObject);
begin
  ScrState := dbmBrowse;
end;

procedure TCdReports.eDsc_RelChange(Sender: TObject);
begin
  if (not tbSave.Enabled) then
    tbSave.Enabled := True;
end;

initialization
  Classes.RegisterClass(TCdReports);

end.
