unit CadTFrac;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by CSD Informatica Ltda.. All rights reserved.      *}
{* Created  : 02/06/2003 - DD/MM/YYYY                                    *}
{* Modified : 22/01/2007 - DD/MM/YYYY                                    *}
{* Version  : 2.0.0.0                                                    *}
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
  Dialogs, CadListModel, StdCtrls, ExtCtrls, VirtualTrees, ComCtrls, ToolWin,
  ProcUtils;

type
  TCdTypeFraction = class(TfrmModelList)
    lTitle: TLabel;
    shTitle: TShape;
    lPk_Tabela_Precos: TStaticText;
    lFlag_Tipo: TRadioGroup;
    eDsc_Tab: TEdit;
    lPkTipoTabelaFracao: TStaticText;
    ePkTipoTabelaFracao: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function GetDscFrac: string;
    function GetFlagType: Integer;
    function GetPkTypeFraction: Integer;
    procedure SetDscFrac(const Value: string);
    procedure SetFlagType(const Value: Integer);
    procedure SetPkTypeFraction(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls     ; override;
    procedure LoadDefaults      ; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB        ; override;
    property  DscFrac       : string  read GetDscFrac        write SetDscFrac;
    property  FlagType      : Integer read GetFlagType       write SetFlagType;
    property  PkTypeFraction: Integer read GetPkTypeFraction write SetPkTypeFraction;
  public
    { Public declarations }
  end;

var
  CdTypeFraction: TCdTypeFraction;

implementation

uses Dado, mSysEstq, GridRow, DB, ProcType, EstqArqSql;

{$R *.dfm}

{ TfrmModelList1 }

function TCdTypeFraction.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscFrac = '') then
  begin
    Dados.DisplayHint(eDsc_Tab, 'Campo Descrição deve conter um valor');
    Result := False;
  end;
end;

procedure TCdTypeFraction.ClearControls;
begin
  Loading := True;
  try
    DscFrac        := '';
    FlagType       := 0;
    PkTypeFraction := 0;
  finally
    Loading := False;
  end;
end;

function TCdTypeFraction.GetDscFrac: string;
begin
  Result := eDsc_Tab.Text;
end;

function TCdTypeFraction.GetFlagType: Integer;
begin
  Result := lFlag_Tipo.ItemIndex;
end;

function TCdTypeFraction.GetPkTypeFraction: Integer;
begin
  Result := StrToIntDef(ePkTipoTabelaFracao.Text, 0);
end;

procedure TCdTypeFraction.LoadDefaults;
begin
  ListLoaded := True;
end;

procedure TCdTypeFraction.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  inherited;
  with dmSysEstq do
  begin
    if qrTypeFraction.Active then qrTypeFraction.Close;
    qrTypeFraction.SQL.Clear;
    qrTypeFraction.SQL.Add(SqlTypeFractions);
    Dados.StartTransaction(qrTypeFraction);
    try
      if (not qrTypeFraction.Active) then qrTypeFraction.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrTypeFraction, False)
      else
        if (RowModel.Count = 0) then
          RowModel.AddFieldsFromDataSet(qrTypeFraction, False);
      while (not qrTypeFraction.EOF) do
      begin
        Node := vtList.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtList.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrTypeFraction, True);
          end;
        end;
        qrTypeFraction.Next;
      end;
    finally
      if qrTypeFraction.Active then qrTypeFraction.Close;
      Dados.CommitTransaction(qrTypeFraction);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode                  := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdTypeFraction.MoveDataToControls;
var
  Data: TDataRow;
begin
  Data          := dmSysEstq.TypeFraction[Pk];
  if (Data = nil) or (Data.Count = 0) then exit;
  Loading := True;
  try
    DscFrac        := Data.FieldByName['DSC_TAB'].AsString;
    FlagType       := Data.FieldByName['FLAG_TIPO'].AsInteger;
    PkTypeFraction := Data.FieldByName['PK_TIPO_TABELA_FRACAO'].AsInteger;
  finally
    Loading := False;
  end;
end;

procedure TCdTypeFraction.SaveIntoDB;
var
  Data: TDataRow;
  aDta: PGridData;
begin
  Data                       := TDataRow.Create(Self);
  if (Data = nil) then exit;
  try
    Data.AddAs('PK_TIPO_TABELA_FRACAO', Pk, ftInteger, SizeOf(Integer));
    Data.AddAs('DSC_TAB', DscFrac, ftString, 51);
    Data.AddAs('FLAG_TIPO', FlagType, ftInteger, SizeOf(Integer));
    dmSysEstq.TypeFraction[Ord(ScrState)] := Data;
    PkTypeFraction := Data.FieldByName['PK_TIPO_TABELA_FRACAO'].AsInteger;
    ListLoaded := False;
  finally
    FreeAndNil(Data);
  end;
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      aDta := GetNodeData(FocusedNode);
      if (aDta <> nil) and (aDta^.DataRow <> nil) then
      begin
        aDta^.DataRow.FieldByName['PK_TIPO_TABELA_FRACAO'].AsInteger := PkTypeFraction;
        aDta^.DataRow.FieldByName['DSC_TAB'].AsString                := DscFrac;
      end;
    end;
  end;
  Pk := PkTypeFraction;
end;

procedure TCdTypeFraction.SetDscFrac(const Value: string);
begin
  eDsc_Tab.Text := Value;
end;

procedure TCdTypeFraction.SetFlagType(const Value: Integer);
begin
  lFlag_Tipo.ItemIndex := Value;
end;

procedure TCdTypeFraction.SetPkTypeFraction(const Value: Integer);
begin
  ePkTipoTabelaFracao.Text := IntToStr(Value);
  dmSysEstq.FkTablePrice   := Value;
end;

procedure TCdTypeFraction.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdTypeFraction.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_TAB'].AsString;
end;

procedure TCdTypeFraction.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_TABELA_FRACAO'].AsInteger;
end;

end.
