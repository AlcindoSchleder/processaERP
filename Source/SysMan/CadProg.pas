unit CadProg;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 23/01/2003 - DD/MM/YYYY                                      *}
{* Modified: 23/01/2003 - DD/MM/YYYY                                     *}
{* Version: 2.0.0.0                                                      *}
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
  Dialogs, CadModel, VirtualTrees, Buttons, StdCtrls, ComCtrls, TSysManAux,
  PrcCombo;

type
  TfrmPrograms = class(TfrmModel)
    stTitle: TLabel;
    lPk_Programas: TStaticText;
    ePk_Programas: TEdit;
    lFlag_Vis: TCheckBox;
    lDsc_Prg: TStaticText;
    eDsc_Prg: TEdit;
    lNom_Lib: TStaticText;
    eNom_Lib: TEdit;
    lNom_Frm: TStaticText;
    eNom_Frm: TEdit;
    lFk_Relatorios: TStaticText;
    stParamTitle: TLabel;
    vtParams: TVirtualStringTree;
    lFlag_Rel: TCheckBox;
    eFk_Relatorios: TPrcComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtParamsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtParamsDblClick(Sender: TObject);
    procedure vtParamsNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
    procedure vtParamsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vtParamsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
  private
    FFkModule: Integer;
    FFkRotine: Integer;
    FFkLanguage: string;
    { Private declarations }
    function  GetDscPrg: string;
    function  GetFkReport: Integer;
    function  GetFlagVis: Boolean;
    function  GetFlagRel: Boolean;
    function  GetNameFrm: string;
    function  GetNameLib: string;
    function  GetPkProgram: Integer;
    function  GetPrograma: TProgram;
    function  LoadParamData: Boolean;
    procedure SetDscPrg(const Value: string);
    procedure SetFkLanguage(const Value: string);
    procedure SetFkModule(const Value: Integer);
    procedure SetFkReport(const Value: Integer);
    procedure SetFkRotine(const Value: Integer);
    procedure SetFlagVis(const Value: Boolean);
    procedure SetFlagRel(const Value: Boolean);
    procedure SetNameFrm(const Value: string);
    procedure SetNameLib(const Value: string);
    procedure SetPkProgram(const Value: Integer);
    procedure SetPrograma(const Value: TProgram);
    procedure SetTitle(const Value: string);
    procedure CreateNewNode;
    procedure DeleteNode(Node: PVirtualNode);
  protected
    { Private declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property Title    : string                    write SetTitle;
    property Programa : TProgram read GetPrograma write SetPrograma;
    property PkProgram: Integer  read GetPkProgram write SetPkProgram;
    property FlagVis  : Boolean  read GetFlagVis   write SetFlagVis;
    property FlagRel  : Boolean  read GetFlagRel   write SetFlagRel;
    property DscPrg   : string   read GetDscPrg    write SetDscPrg;
    property NameLib  : string   read GetNameLib   write SetNameLib;
    property NameFrm  : string   read GetNameFrm   write SetNameFrm;
    property FkReport : Integer  read GetFkReport  write SetFkReport;
  public
    { Public declarations }
    property FkLanguage: string  read FFkLanguage write SetFkLanguage;
    property FkModule  : Integer read FFkModule   write SetFkModule;
    property FkRotine  : Integer read FFkRotine   write SetFkRotine;
    property Pk;
  end;

var
  frmPrograms: TfrmPrograms;

implementation

{$R *.dfm}

uses Dado, ProcType, FuncoesDB, GridRow, mSysMan, ManArqSql, DB, ProcUtils;

procedure TfrmPrograms.ClearControls;
begin
  Loading   := True;
  PkProgram := 0;
  FlagVis   := True;
  FlagRel   := False;
  DscPrg    := '';
  NameLib   := '';
  NameFrm   := '';
  FkReport  := 0;
  Loading   := False;
end;

procedure TfrmPrograms.FormCreate(Sender: TObject);
begin
  vtParams.NodeDataSize  := SizeOf(TGridData);
  vtParams.Header.Images := Dados.Image16;
  vtParams.Images        := Dados.Image16;
  inherited;
end;

procedure TfrmPrograms.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtParams);
  eFk_Relatorios.ReleaseObjects;
  inherited;
end;

function TfrmPrograms.GetDscPrg: string;
begin
  Result := eDsc_Prg.Text;
end;

function TfrmPrograms.GetFkReport: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Relatorios.ItemIndex;
  if (aIdx > -1) and (eFk_Relatorios.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Relatorios.Items.Objects[aIdx]);
end;

function TfrmPrograms.GetFlagVis: Boolean;
begin
  Result := lFlag_Vis.Checked;
end;

function TfrmPrograms.GetFlagRel: Boolean;
begin
  Result := lFlag_Rel.Checked;
end;

function TfrmPrograms.GetNameFrm: string;
begin
  Result := eNom_Frm.Text;
end;

function TfrmPrograms.GetNameLib: string;
begin
  Result := eNom_Lib.Text;
end;

function TfrmPrograms.GetPkProgram: Integer;
begin
  Result := StrToInt(ePk_Programas.Text);
end;

function TfrmPrograms.GetPrograma: TProgram;
begin
  Result    := dmSysMan.GetProgram(FkLanguage, FFkModule, FFkRotine, Pk);
  if (Result = nil) then exit;
  Loading   := True;
  FlagVis   := Result.FlagVis;
  FlagRel   := Result.FlagRel;
  DscPrg    := Result.DscPrg;
  NameLib   := Result.NomLib;
  NameFrm   := Result.NomForm;
  FkReport  := Result.FkReport;
  PkProgram := Pk;
  Loading   := False;
end;

procedure TfrmPrograms.LoadDefaults;
begin
  if (GetPrograma <> nil) then
  begin
    if (not ListLoaded) then
    begin
      eFk_Relatorios.ReleaseObjects;
      eFk_Relatorios.Items.AddStrings(dmSysMan.LoadReports(FFkLanguage, FFkModule));
      if (eFk_Relatorios.Items.Count > 0) then
        ListLoaded := True;
    end;
    LoadParamData;
  end;
end;

function  TfrmPrograms.LoadParamData: Boolean;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := False;
  if (vtParams.RootNodeCount > 0) then
    ReleaseTreeNodes(vtParams);
  with dmSysMan do
  begin
    if Programa.Active then Programa.Close;
    Programa.SQL.Clear;
    Programa.SQL.Add(SqlParamPrg);
    Dados.StartTransaction(Programa);
    Programa.ParamByName('FkModulos').AsInteger   := FFkModule;
    Programa.ParamByName('FkRotinas').AsInteger   := FFkRotine;
    Programa.ParamByName('FkProgramas').AsInteger := Pk;
    if not Programa.Active then Programa.Open;
    vtParams.BeginUpdate;
    try
      Programa.First;
      while not Programa.Eof do
      begin
        Node          := vtParams.AddChild(nil);
        if (Node <> nil) then
        begin
          Data          := vtParams.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, Programa, True);
            Data^.DataRow.AddAs('STATUS', Ord(dbmBrowse), ftInteger, SizeOf(Integer));
          end;
        end;
        Programa.Next;
      end;
    finally
      vtParams.EndUpdate;
      if Programa.Active then Programa.Close;
      Dados.CommitTransaction(Programa);
    end;
  end;
  if (vtParams.RootNodeCount = 0) then exit;
  Result                  := True;
  Node                    := vtParams.GetFirst;
  vtParams.FocusedNode    := Node;
  vtParams.Selected[Node] := True;
end;

procedure TfrmPrograms.MoveDataToControls;
begin
  LoadDefaults;
end;

procedure TfrmPrograms.SaveIntoDB;
begin
  SetPrograma(TProgram.Create);
end;

procedure TfrmPrograms.SetDscPrg(const Value: string);
begin
  eDsc_Prg.Text := Value;
end;

procedure TfrmPrograms.SetFkLanguage(const Value: string);
begin
  if (FFkLanguage <> Value) then
  begin
    FFkLanguage := Value;
    LoadDefaults;
  end;
end;

procedure TfrmPrograms.SetFkModule(const Value: Integer);
begin
  if (FFkModule <> Value) then
  begin
    FFkModule := Value;
    LoadDefaults;
  end;
end;

procedure TfrmPrograms.SetFkReport(const Value: Integer);
begin
  if (eFk_Relatorios.Items.Count > 0) then
    eFk_Relatorios.ItemIndex := 0
  else
    eFk_Relatorios.ItemIndex := -1;
  eFk_Relatorios.SetIndexFromIntegerValue(Value);
end;

procedure TfrmPrograms.SetFkRotine(const Value: Integer);
begin
  if (FFkRotine <> Value) then
  begin
    FFkRotine := Value;
    LoadDefaults;
  end;
end;

procedure TfrmPrograms.SetFlagVis(const Value: Boolean);
begin
  lFlag_Vis.Checked := Value;
end;

procedure TfrmPrograms.SetFlagRel(const Value: Boolean);
begin
  lFlag_Rel.Checked := Value;
end;

procedure TfrmPrograms.SetNameFrm(const Value: string);
begin
  eNom_Frm.Text := Value;
end;

procedure TfrmPrograms.SetNameLib(const Value: string);
begin
  eNom_Lib.Text := Value;
end;

procedure TfrmPrograms.SetPkProgram(const Value: Integer);
begin
  ePk_Programas.Text := IntToStr(Value);
end;

procedure TfrmPrograms.SetPrograma(const Value: TProgram);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  if (Value = nil) then exit;
  Value.PkLanguage := FFkLanguage;
  Value.PkModule   := FFkModule;
  Value.PkRotine   := FFkRotine;
  Value.PkProgram  := Pk;
  Value.FlagVis    := FlagVis ;
  Value.FlagRel    := FlagRel ;
  Value.DscPrg     := DscPrg  ;
  Value.NomLib     := NameLib ;
  Value.NomForm    := NameFrm ;
  Value.FkReport   := FkReport;
  if (Value.PkLanguage = '') then
    raise Exception.Create('Salvar Programa: Campo Código da Linguagem deve ser informado');
  if (Value.PkModule = 0) then
    raise Exception.Create('Salvar Programa: Campo Código do Módulo deve ser informado');
  if (Value.PkRotine = 0) then
    raise Exception.Create('Salvar Programa: Campo Código da Rotina deve ser informado');
  if (Value.DscPrg = '') then
  begin
    Dados.DisplayHint(eDsc_Prg, 'Salvar Programa: Campo Descrição do Programa deve ser informado');
    exit;
  end;
  if (Value.NomLib = '') then
  begin
    Dados.DisplayHint(eNom_Lib, 'Salvar Programa: Campo Nome da Biblioteca deve ser informado');
    exit;
  end;
  if (Value.NomForm = '') then
  begin
    Dados.DisplayHint(eNom_Frm, 'Salvar Programa: Campo Nome do Fromulário deve ser informado');
    exit;
  end;
  if (Value.FlagRel = True) and (Value.FkReport = 0) then
  begin
    Dados.DisplayHint(eFk_Relatorios, 'Salvar Programa: Campo Código do Relatório deve ser informado');
    exit;
  end;
  Node := vtParams.GetFirst;
  while (Node <> nil) do
  begin
    Data := vtParams.GetNodeData(Node);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      with Value.ProgramParams.Add do
      begin
        DscParam := Data^.DataRow.FieldByName['DSC_PARAM'].AsString;
        ValProp  := Data^.DataRow.FieldByName['VAL_PROP'].AsString;
        NomProp  := Data^.DataRow.FieldByName['NOM_PROP'].AsString;
      end;
    end;
    Node := vtParams.GetNext(Node);
  end;
  dmSysMan.SaveProgram(Value, ScrState);
end;

procedure TfrmPrograms.SetTitle(const Value: string);
begin
  stTitle.Caption := Value;
end;

procedure TfrmPrograms.vtParamsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Column of
    0: CellText := Data^.DataRow.FieldByName['DSC_PARAM'].AsString;
    1: CellText := Data^.DataRow.FieldByName['NOM_PROP'].AsString;
    2: CellText := Data^.DataRow.FieldByName['VAL_PROP'].AsString;
  end;
end;

procedure TfrmPrograms.CreateNewNode;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ChangeGlobal(Self);
  vtParams.BeginUpdate;
  try
    Node := vtParams.AddChild(nil);
    if (Node <> nil) then
    begin
      Data := vtParams.GetNodeData(Node);
      if (Data <> nil) then
      begin
        Data^.Level   := 0;
        Data^.Node    := Node;
        Data^.DataRow := TDataRow.Create(nil);
        Data^.DataRow.AddAs('FK_MODULOS', FkModule, ftInteger, SizeOf(Integer));
        Data^.DataRow.AddAs('FK_ROTINAS', FkRotine, ftInteger, SizeOf(Integer));
        Data^.DataRow.AddAs('FK_PROGRAMAS', Pk, ftInteger, SizeOf(Integer));
        Data^.DataRow.AddAs('PK_PARAMETROS_PRG', vtParams.AbsoluteIndex(Node), ftInteger, SizeOf(Integer));
        Data^.DataRow.AddAs('DSC_PARAM', ' ', ftString, 31);
        Data^.DataRow.AddAs('NOM_PROP', ' ', ftString, 31);
        Data^.DataRow.AddAs('VAL_PROP', ' ', ftString, 31);
        Data^.DataRow.AddAs('STATUS', Ord(ScrState), ftInteger, SizeOf(Integer));
      end;
    end;
  finally
    vtParams.EndUpdate;
  end;
  vtParams.FocusedNode    := Node;
  vtParams.Selected[Node] := True;
end;

procedure TfrmPrograms.vtParamsDblClick(Sender: TObject);
begin
  if (vtParams.RootNodeCount = 0) then
    CreateNewNode;
end;

procedure TfrmPrograms.vtParamsNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data   : PGridData;
  R      : TRect;
  aStrLen: Integer;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  ChangeGlobal(Sender);
  if (Column = 2) then
    aStrLen := 255
  else
    aStrLen := 30;
  case Column of
    0: Data^.DataRow.FieldByName['DSC_PARAM'].AsString := Copy(NewText, 1, 30);
    1: Data^.DataRow.FieldByName['NOM_PROP'].AsString  := Copy(NewText, 1, 30);
    2: Data^.DataRow.FieldByName['VAL_PROP'].AsString  := Copy(NewText, 1, 30);
  end;
  Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(ScrState);
  if (NewText <> '') and (Length(NewText) > aStrLen) then
  begin
    R := Sender.GetDisplayRect(Node, Column, False);
    R.BottomRight.Y := R.BottomRight.Y + Integer(vtParams.DefaultNodeHeight);
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight, 'Tamanho máximo do campo é de 30 caracteres');
  end;
end;

procedure TfrmPrograms.DeleteNode(Node: PVirtualNode);
var
  Data: PGridData;
begin
  ChangeGlobal(Self);
  if (Node = nil) then exit;
  Data := vtParams.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if vtParams.IsEditing then vtParams.EndEditNode;
  Data^.Node := nil;
  Data^.DataRow.Free;
  Data^.DataRow := nil;
  vtParams.DeleteNode(Node);
end;

procedure TfrmPrograms.vtParamsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := vtParams.FocusedNode;
  if (Node = nil) then exit;
  Data := vtParams.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  case Key of
    VK_UP   : if (Data^.DataRow.FieldByName['DSC_PARAM'].AsString = ' ') then
                DeleteNode(Node);
    VK_DOWN : if (vtParams.GetLast = Node) then
                CreateNewNode;
  else
    if (ssCtrl in Shift) and (Key = VK_DELETE) then DeleteNode(Node);
  end;
end;

procedure TfrmPrograms.vtParamsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node <> nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in UPDATE_MODE) then
    TargetCanvas.Font.Color := clRed
  else
    TargetCanvas.Font.Color := clWindowText;
end;

end.
