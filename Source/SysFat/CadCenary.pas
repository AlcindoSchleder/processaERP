unit CadCenary;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 28/12/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 2.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, ToolEdit, ProcUtils, CurrEdit, VirtualTrees,
  ComCtrls, ToolWin, DB, CadListModel;

type
  TfrmCdCenary = class(TfrmModelList)
    lPk_Cenarios_Financeiros: TStaticText;
    ePk_Cenarios_Financeiros: TCurrencyEdit;
    lDsc_Cen: TStaticText;
    eDsc_Cen: TEdit;
    lFlag_TpCen: TRadioGroup;
    lTitle: TLabel;
    shTitle: TShape;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscCen: string;
    function  GetPkCenariosFinanceiros: Integer;
    function  GetFlagTpCen: Integer;
    procedure SetDscCen(const Value: string);
    procedure SetPkCenariosFinanceiros(const Value: Integer);
    procedure SetFlagTpCen(const Value: Integer);
  protected
    { Proteted declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkCenariosFinanceiros: Integer read GetPkCenariosFinanceiros write SetPkCenariosFinanceiros;
    property  DscCen               : string  read GetDscCen                write SetDscCen;
    property  FlagTpCen            : Integer read GetFlagTpCen             write SetFlagTpCen;
  public
    { Public declarations }
  end;

var
  frmCdCenary: TfrmCdCenary;

implementation

uses Dado, mSysFat, ArqSqlFat, GridRow, ProcType, FuncoesDB, Funcoes;

{$R *.dfm}

function TfrmCdCenary.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscCen = '') then
  begin
    Dados.DisplayHint(eDsc_Cen, 'Campo Descrição deve ser preenchido');
    Result := False;
  end;
end;

procedure TfrmCdCenary.ClearControls;
begin
  Loading := True;
  try
    PkCenariosFinanceiros := 0;
    DscCen                := '';
    FlagTpCen             := 1;
  finally
    Loading := False;
  end;
end;

procedure TfrmCdCenary.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

function TfrmCdCenary.GetDscCen: string;
begin
  Result := eDsc_Cen.Text;
end;

function TfrmCdCenary.GetPkCenariosFinanceiros: Integer;
begin
  Result := ePk_Cenarios_Financeiros.AsInteger;
end;

function TfrmCdCenary.GetFlagTpCen: Integer;
begin
  Result := lFlag_TpCen.ItemIndex;
end;

procedure TfrmCdCenary.LoadDefaults;
begin
// nothing to do
end;

procedure TfrmCdCenary.LoadList(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  vtList.BeginUpdate;
  with dmSysFat.qrCenary do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlCenaries);
    Dados.StartTransaction(dmSysFat.qrCenary);
    try
      ParamByName('FkEmpresas').AsInteger := Dados.Parametros.soActiveCompany;
      if not Active then Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, dmSysFat.qrCenary, False);
      while not EOF do
      begin
        AddDataNode(nil, dmSysFat.qrCenary);
        Next;
      end;
    finally
      if Active then Close;
      Dados.CommitTransaction(dmSysFat.qrCenary);
      vtList.EndUpdate;
      Screen.Cursor := crDefault;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FullExpand;
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TfrmCdCenary.MoveDataToControls;
var
  Data: TDataRow;
begin
  Loading := True;
  try
    Data                  := dmSysFat.Cenary[Pk];
    PkCenariosFinanceiros := Pk;
    DscCen                := Data.FieldByName['DSC_CEN'].AsString;
    FlagTpCen             := Data.FieldByName['FLAG_TPCEN'].AsInteger;
  finally
    Loading := False;
  end;
end;

procedure TfrmCdCenary.SaveIntoDB;
var
  Data: TDataRow;
  APk : Integer;
  ADt : PGridData;
begin
  Data := TDataRow.Create(nil);
  try
    Data.AddAs('PK_CENARIOS_FINANCEIROS', Pk, ftInteger, SizeOf(Integer));
    Data.AddAs('DSC_CEN', DscCen, ftString, 51);
    Data.AddAs('FLAG_TPCEN', FlagTpCen, ftInteger, SizeOf(Integer));
    dmSysFat.Cenary[Ord(ScrState)] := Data;
    APk := Data.FieldByName['PK_CENARIOS_FINANCEIROS'].AsInteger;
    with vtList do
    begin
      if (FocusedNode <> nil) then
      begin
        ADt := GetNodeData(FocusedNode);
        if (ADt <> nil) and (ADt.DataRow <> nil) then
        begin
          ADt.DataRow.FieldByName['PK_CENARIOS_FINANCEIROS'].AsInteger := APk;
          ADt.DataRow.FieldByName['DSC_CEN'].AsString     :=
            Data.FieldByName['DSC_CEN'].AsString;
          ADt.DataRow.FieldByName['FLAG_TPCEN'].AsInteger :=
            Data.FieldByName['FLAG_TPCEN'].AsInteger
        end;
      end;
    end;
  finally
    FreeAndNil(Data);
  end;
  Pk := APk;
end;

procedure TfrmCdCenary.SetDscCen(const Value: string);
begin
  eDsc_Cen.Text := Value;
end;

procedure TfrmCdCenary.SetPkCenariosFinanceiros(const Value: Integer);
begin
  ePk_Cenarios_Financeiros.AsInteger := Value;
end;

procedure TfrmCdCenary.SetFlagTpCen(const Value: Integer);
begin
  if (Value < lFlag_TpCen.Items.Count) then
    lFlag_TpCen.ItemIndex := Value
  else
    raise Exception.CreateFmt('Erro: Valor (%d) atribuído ao campo tipo de senha inválido', [Value]);
end;

procedure TfrmCdCenary.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['PK_CENARIOS_FINANCEIROS'].AsString + ' / ' +
              Data^.DataRow.FieldByName['DSC_CEN'].AsString;
end;

procedure TfrmCdCenary.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_CENARIOS_FINANCEIROS'].AsInteger;
end;

initialization
  RegisterClass(TfrmCdCenary);

end.
