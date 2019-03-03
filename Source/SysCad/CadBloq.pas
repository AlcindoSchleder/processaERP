unit CadBloq;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 10/07/2006 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
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
  Dialogs, CadListModel, StdCtrls, VirtualTrees, ComCtrls, ToolWin, TSysCadAux,
  ProcUtils, ExtCtrls;

type
  TCdBloqueio = class(TfrmModelList)
    gbParams: TGroupBox;
    lFlag_VaVs: TCheckBox;
    lFlag_MPgt: TCheckBox;
    lFlag_DtaBas: TCheckBox;
    lFlag_CondP: TCheckBox;
    lFlag_LimCr: TCheckBox;
    eDsc_Blk: TEdit;
    ePk_Tipo_Bloqueios: TEdit;
    lPk_Tipo_Bloqueios: TStaticText;
    lDsc_Blk: TStaticText;
    lFlag_Blq: TCheckBox;
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure FormCreate(Sender: TObject);
  private
    function GetBlock: TTypeBlock;
    function GetDscBlock: String;
    function GetFlagBlock: Boolean;
    function GetFlagCndPgt: Boolean;
    function GetFlagDtaBas: Boolean;
    function GetFlagLimCr: Boolean;
    function GetFlagMPgt: Boolean;
    function GetFlagVaVs: Boolean;
    function GetPkBlock: Integer;
    procedure SetBlock(const Value: TTypeBlock);
    procedure SetDscBlock(const Value: String);
    procedure SetFlagBlock(const Value: Boolean);
    procedure SetFlagCndPgt(const Value: Boolean);
    procedure SetFlagDtaBas(const Value: Boolean);
    procedure SetFlagLimCr(const Value: Boolean);
    procedure SetFlagMPgt(const Value: Boolean);
    procedure SetFlagVaVs(const Value: Boolean);
    procedure SetPkBlock(const Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
    function  CheckRecord(const OldState, NewState: TDbMode) : Boolean;
    procedure ClearControls;      override;
    procedure LoadDefaults;       override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB;         override;
  public
    { Public declarations }
    property  Block         : TTypeBlock read GetBlock      write SetBlock;
    property  PkBlock       : Integer    read GetPkBlock    write SetPkBlock;
    property  DscBlock      : String     read GetDscBlock   write SetDscBlock;
    property  FlagBlock     : Boolean    read GetFlagBlock  write SetFlagBlock;
    property  FlagCndPgt    : Boolean    read GetFlagCndPgt write SetFlagCndPgt;
    property  FlagDtaBas    : Boolean    read GetFlagDtaBas write SetFlagDtaBas;
    property  FlagLimCr     : Boolean    read GetFlagLimCr  write SetFlagLimCr;
    property  FlagMPgt      : Boolean    read GetFlagMPgt   write SetFlagMPgt;
    property  FlagVaVs      : Boolean    read GetFlagVaVs   write SetFlagVaVs;
  end;

var
  CdBloqueio: TCdBloqueio;

implementation

uses Dado, mSysCad, GridRow, CadArqSql, ProcType;

{$R *.dfm}

{ TCdBloqueio }

function TCdBloqueio.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscBlock = '') then
  begin
    Dados.DisplayHint(eDsc_Blk, 'Campo Descrição deve ser preenchido');
    Result := False;
  end;
end;

procedure TCdBloqueio.ClearControls;
begin
  Loading := True;
  try
    PkBlock    := 0;
    DscBlock   := '';
    FlagBlock  := False;
    FlagCndPgt := False;
    FlagDtaBas := False;
    FlagLimCr  := False;
    FlagMPgt   := False;
    FlagVaVs   := False;
  finally
    Loading := False;
  end;
end;

function TCdBloqueio.GetBlock: TTypeBlock;
begin
  Result := TTypeBlock.Create;
end;

function TCdBloqueio.GetDscBlock: String;
begin
  Result := eDsc_Blk.Text;
end;

function TCdBloqueio.GetFlagBlock: Boolean;
begin
  Result := lFlag_Blq.Checked;
end;

function TCdBloqueio.GetFlagCndPgt: Boolean;
begin
  Result := lFlag_CondP.Checked;
end;

function TCdBloqueio.GetFlagDtaBas: Boolean;
begin
  Result := lFlag_DtaBas.Checked;
end;

function TCdBloqueio.GetFlagLimCr: Boolean;
begin
  Result := lFlag_LimCr.Checked;
end;

function TCdBloqueio.GetFlagMPgt: Boolean;
begin
  Result := lFlag_MPgt.Checked;
end;

function TCdBloqueio.GetFlagVaVs: Boolean;
begin
  Result := lFlag_VaVs.Checked;
end;

function TCdBloqueio.GetPkBlock: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Bloqueios.Text, 0);
end;

procedure TCdBloqueio.LoadDefaults;
begin
  inherited;
  // nothing to do
end;

procedure TCdBloqueio.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysCad.qrTypeBlock do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlSelectTypeBlocks);
    Dados.StartTransaction(dmSysCad.qrTypeBlock);
    try
      if (not Active) then Open;
      RowModel := TDataRow.CreateFromDataSet(Self, dmSysCad.qrTypeBlock, False);
      while (not Eof) do
      begin
        AddDataNode(nil, dmSysCad.qrTypeBlock);
        Next;
      end;
    finally
      if (Active) then Close;
      Dados.CommitTransaction(dmSysCad.qrTypeBlock);
    end;
  end;
  if vtList.RootNodeCount > 0 then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.GetFirst] := True;
  end;
end;

procedure TCdBloqueio.MoveDataToControls;
var
  aItem: TTypeBlock;
begin
  inherited;
  Loading := True;
  try
    aItem      := dmSysCad.TypeBlock[Pk];
    PkBlock    := aItem.PkTypeBlock;
    DscBlock   := aItem.DscBlock;
    FlagBlock  := aItem.FlagBlq;
    FlagCndPgt := aItem.FlagCndPgt;
    FlagDtaBas := aItem.FlagDtaBas;
    FlagLimCr  := aItem.FlagLimCr;
    FlagMPgt   := aItem.FlagMPgt;
    FlagVaVs   := aItem.FlagVaVs;
  finally
    Loading := False;
  end;
end;

procedure TCdBloqueio.SaveIntoDB;
var
  aItem: TTypeBlock;
  Data : PGridData;
begin
  aItem := TTypeBlock.Create;
  try
    aItem.PkTypeBlock := Pk;
    aItem.DscBlock    := DscBlock;
    aItem.FlagBlq     := FlagBlock;
    aItem.FlagCndPgt  := FlagCndPgt;
    aItem.FlagDtaBas  := FlagDtaBas;
    aItem.FlagLimCr   := FlagLimCr;
    aItem.FlagMPgt    := FlagMPgt;
    aItem.FlagVaVs    := FlagVaVs;
    dmSysCad.TypeBlock[Ord(ScrState)] := aItem;
    with vtList do
    begin
      if (FocusedNode <> nil) then
      begin
        Data := GetNodeData(FocusedNode);
        if (Data <> nil) and (Data^.DataRow <> nil) then
        begin
          Data^.DataRow.FieldByName['PK_TIPO_BLOQUEIOS'].AsInteger := aItem.PkTypeBlock;
          Data^.DataRow.FieldByName['DSC_TBL'].AsString := aItem.DscBlock;
        end;
      end;
    end;
    Pk := aItem.PkTypeBlock;
  finally
    FreeAndNil(aItem);
  end;
end;

procedure TCdBloqueio.SetBlock(const Value: TTypeBlock);
begin

end;

procedure TCdBloqueio.SetDscBlock(const Value: String);
begin
  eDsc_Blk.Text := Value;
end;

procedure TCdBloqueio.SetFlagBlock(const Value: Boolean);
begin
  lFlag_Blq.Checked := Value;
end;

procedure TCdBloqueio.SetFlagCndPgt(const Value: Boolean);
begin
  lFlag_CondP.Checked := Value;
end;

procedure TCdBloqueio.SetFlagDtaBas(const Value: Boolean);
begin
  lFlag_DtaBas.Checked := Value;
end;

procedure TCdBloqueio.SetFlagLimCr(const Value: Boolean);
begin
  lFlag_LimCr.Checked := Value;
end;

procedure TCdBloqueio.SetFlagMPgt(const Value: Boolean);
begin
  lFlag_MPgt.Checked := Value;
end;

procedure TCdBloqueio.SetFlagVaVs(const Value: Boolean);
begin
  lFlag_VaVs.Checked := Value;
end;

procedure TCdBloqueio.SetPkBlock(const Value: Integer);
begin
  ePk_Tipo_Bloqueios.Text := IntToStr(Value);
end;

procedure TCdBloqueio.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_TBL'].AsString;
end;

procedure TCdBloqueio.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_BLOQUEIOS'].AsInteger;
end;

procedure TCdBloqueio.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

initialization
  RegisterClass(TCdBloqueio);

end.
