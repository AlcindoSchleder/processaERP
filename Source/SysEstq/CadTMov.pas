unit CadTMov;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
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
  Dialogs, CadListModel, StdCtrls, ExtCtrls, ComCtrls, ToolWin, VirtualTrees,
  CadModel, TSysEstqAux, GridRow, ProcUtils;

type
  TCdTypeMov = class(TfrmModelList)
    lDsc_TMov: TStaticText;
    lPk_Tipo_Movim_Estq: TStaticText;
    ePk_Tipo_Movim_Estq: TEdit;
    lFlag_GenHst: TCheckBox;
    dbParams: TGroupBox;
    lFlag_OpQrnt: TRadioGroup;
    lFlag_TBaixa: TRadioGroup;
    lFlag_TMov: TRadioGroup;
    lFk_Tipo_Movim_Estq: TStaticText;
    eFk_Tipo_Movim_Estq: TComboBox;
    lFlag_TCod: TRadioGroup;
    lFlag_OpRsrv: TRadioGroup;
    lFlag_MvRsrv: TCheckBox;
    lFlag_MvQrnt: TCheckBox;
    lFlag_OpEstq: TRadioGroup;
    lFlag_MvEstq: TCheckBox;
    lFlag_OpGrnt: TRadioGroup;
    lFlag_MvGrnt: TCheckBox;
    eDsc_TMov: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure lFlag_MvEstqClick(Sender: TObject);
    procedure lFlag_MvRsrvClick(Sender: TObject);
    procedure lFlag_MvGrntClick(Sender: TObject);
    procedure lFlag_MvQrntClick(Sender: TObject);
    procedure lFlag_TMovClick(Sender: TObject);
  private
    { Private declarations }
    function  GetDscTMov: string;
    function  GetFkTypeTMov: Integer;
    function  GetFlagGenHst: Boolean;
    function  GetFlagTBaixa: TLocalMoviment;
    function  GetFlagTCod: TCodeTypes;
    function  GetFlagTEstq(Index: TTypeEstq): Boolean;
    function  GetFlagTMov: TMovimentations;
    function  GetFlagTOper(Index: TTypeEstq): TTypeOper;
    function  GetPkTypeTMov: Integer;
    procedure SetDscTMov(const Value: string);
    procedure SetFkTypeTMov(const Value: Integer);
    procedure SetFlagGenHst(const Value: Boolean);
    procedure SetFlagTBaixa(const Value: TLocalMoviment);
    procedure SetFlagTCod(const Value: TCodeTypes);
    procedure SetFlagTEstq(Index: TTypeEstq; const Value: Boolean);
    procedure SetFlagTMov(const Value: TMovimentations);
    procedure SetFlagTOper(Index: TTypeEstq; const Value: TTypeOper);
    procedure SetPkTypeTMov(const Value: Integer);
    function  GetTypeMov: TTypeMoviment;
    procedure SetTypeMov(Value: TTypeMoviment);
    procedure CreateModel;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property PkTypeTMov: Integer         read GetPkTypeTMov write SetPkTypeTMov;
    property DscTMov   : string          read GetDscTMov    write SetDscTMov;
    property FlagGenHst: Boolean         read GetFlagGenHst write SetFlagGenHst;
    property FlagTBaixa: TLocalMoviment  read GetFlagTBaixa write SetFlagTBaixa;
    property FlagTMov  : TMovimentations read GetFlagTMov   write SetFlagTMov;
    property FkTypeTMov: Integer         read GetFkTypeTMov write SetFkTypeTMov;
    property FlagTCod  : TCodeTypes       read GetFlagTCod   write SetFlagTCod;
    property FlagTEstq[Index: TTypeEstq]: Boolean   read GetFlagTEstq write SetFlagTEstq;
    property FlagTOper[Index: TTypeEstq]: TTypeOper read GetFlagTOper write SetFlagTOper;
    property TypeMov   : TTypeMoviment   read GetTypeMov    write SetTypeMov;
  public
    { Public declarations }
  end;

var
  CdTypeMov: TCdTypeMov;

implementation

{$R *.dfm}

uses mSysEstq, Dado, ProcType, DB;

{ TTCdTMov }

const
   TYPE_MOV_COLOR: array [TMovimentations] of TColor =
     (clMaroon, clBlue, clGreen, clRed);

procedure TCdTypeMov.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
  ItemImgNrmIdx := 48;
  ItemImgSelIdx := 49;
end;

procedure TCdTypeMov.ClearControls;
var
  i: TTypeEstq;
begin
  Loading    := True;
  PkTypeTMov := 0;
  DscTMov    := '';
  FlagGenHst := True;
  FlagTBaixa := lmBoth;
  FlagTMov   := mvOutput;
  FkTypeTMov := 0;
  FlagTCod   := pcReference;
  for i := Low(TTypeEstq) to High(TTypeEstq) do
  begin
    FlagTEstq[i] := False;
    FlagTOper[i] := opNone;
  end;
  Loading    := False;
end;

function TCdTypeMov.GetDscTMov: string;
begin
  Result := eDsc_TMov.Text;
end;

function TCdTypeMov.GetFkTypeTMov: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Tipo_Movim_Estq.ItemIndex;
  if (aIdx > -1) and (eFk_Tipo_Movim_Estq.Items.Objects[aIdx] <> nil) then
    Result := TTypeMoviment(eFk_Tipo_Movim_Estq.Items.Objects[aIdx]).PkTypeMoviment;
end;

function TCdTypeMov.GetFlagGenHst: Boolean;
begin
  Result := lFlag_GenHst.Checked;
end;

function TCdTypeMov.GetFlagTBaixa: TLocalMoviment;
begin
  Result := TLocalMoviment(lFlag_TBaixa.ItemIndex);
end;

function TCdTypeMov.GetFlagTCod: TCodeTypes;
begin
  Result := TCodeTypes(lFlag_TCod.ItemIndex);
end;

function TCdTypeMov.GetFlagTEstq(Index: TTypeEstq): Boolean;
begin
  Result := False;
  case Index of
    etReal      : Result := lFlag_MvEstq.Checked;
    etReserved  : Result := lFlag_MvRsrv.Checked;
    etQuarentine: Result := lFlag_MvQrnt.Checked;
    etGiveBack  : Result := lFlag_MvGrnt.Checked;
  end;
end;

function TCdTypeMov.GetFlagTMov: TMovimentations;
begin
  Result := TMovimentations(lFlag_TMov.ItemIndex);
end;

function TCdTypeMov.GetFlagTOper(Index: TTypeEstq): TTypeOper;
begin
  Result := opNone;
  case Index of
    etReal      : Result := TTypeOper(lFlag_OpEstq.ItemIndex);
    etReserved  : Result := TTypeOper(lFlag_OpRsrv.ItemIndex);
    etQuarentine: Result := TTypeOper(lFlag_OpQrnt.ItemIndex);
    etGiveBack  : Result := TTypeOper(lFlag_OpGrnt.ItemIndex);
  end;
end;

function TCdTypeMov.GetPkTypeTMov: Integer;
begin
  Result := StrToIntDef(ePk_Tipo_Movim_Estq.Text, 0);
end;

function TCdTypeMov.GetTypeMov: TTypeMoviment;
var
  i: TTypeEstq;
  Data: PGridData;
begin
  Result     := dmSysEstq.GetTypeMovement(Pk);
  if (Result <> nil) then
  begin
    Loading    := True;
    PkTypeTMov := Pk;
    DscTMov    := Result.DscMov;
    FlagGenHst := Result.FlagGenHst;
    FlagTBaixa := Result.FlagLocMov;
    FlagTMov   := Result.FlagTMov;
    FkTypeTMov := Result.FkTypeMoviment;
    FlagTCod   := Result.FlagCode;
    for i := Low(TTypeEstq) to High(TTypeEstq) do
    begin
      FlagTEstq[i] := Result.FlagMov[i];
      FlagTOper[i] := Result.FlagOper[i];
    end;
    Loading    := False;
    if (vtList.FocusedNode <> nil) then
    begin
      Data := vtList.GetNodeData(vtList.FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
      begin
        Data^.DataRow.FieldByName['DSC_TMOV'].AsString   := DscTMov;
        Data^.DataRow.FieldByName['FLAG_TMOV'].AsInteger := Ord(FlagTMov);
      end;
      vtList.Refresh;
    end;
  end;
end;

procedure TCdTypeMov.LoadDefaults;
begin
  eFk_Tipo_Movim_Estq.Items.Add('<Nenhum>');
end;

procedure TCdTypeMov.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
  i   : Integer;
begin
  CreateModel;
  with dmSysEstq.LoadTypeMovement(-1) do
  begin
    for i := 0 to Count - 1 do
    begin
      vtList.BeginUpdate;
      try
        if (Objects[i] <> nil) then
        begin
          Node := vtList.AddChild(nil);
          if (Node <> nil) then
          begin
            Data := vtList.GetNodeData(Node);
            if (Data <> nil) then
            begin
              Data^.Level   := 0;
              Data^.Node    := Node;
              Data^.DataRow := TDataRow.Create(nil);
              Data^.DataRow.AddAs('DSC_TMOV', TTypeMoviment(Objects[i]).DscMov, ftString, 31);
              Data^.DataRow.AddAs('PK_TIPO_MOVIM_ESTQ', TTypeMoviment(Objects[i]).PkTypeMoviment,
                ftInteger, SizeOf(Integer));
              Data^.DataRow.AddAs('FLAG_TMOV', Integer(TTypeMoviment(Objects[i]).FlagTMov),
                ftInteger, SizeOf(Integer));
            end;
          end;
        end;
      finally
        vtList.EndUpdate;
      end;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.GetFirst] := True;
  end;
end;

procedure TCdTypeMov.MoveDataToControls;
begin
  GetTypeMov;
end;

procedure TCdTypeMov.SaveIntoDB;
begin
  if (ScrState in UPDATE_MODE) then
    SetTypeMov(TTypeMoviment.Create);
end;

procedure TCdTypeMov.SetDscTMov(const Value: string);
begin
  eDsc_TMov.Text := Value;
end;

procedure TCdTypeMov.SetFkTypeTMov(const Value: Integer);
var
  i: Integer;
begin
  eFk_Tipo_Movim_Estq.ItemIndex := 0;
  if (Value > 0) then
  begin
    for i := 0 to eFk_Tipo_Movim_Estq.Items.Count - 1 do
      if (eFk_Tipo_Movim_Estq.Items.Objects[i] <> nil) and
         (Value = TTypeMoviment(eFk_Tipo_Movim_Estq.Items.Objects[i]).PkTypeMoviment) then
      begin
        eFk_Tipo_Movim_Estq.ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTypeMov.SetFlagGenHst(const Value: Boolean);
begin
  lFlag_GenHst.Checked := Value;
end;

procedure TCdTypeMov.SetFlagTBaixa(const Value: TLocalMoviment);
begin
  lFlag_TBaixa.ItemIndex := Ord(Value);
end;

procedure TCdTypeMov.SetFlagTCod(const Value: TCodeTypes);
begin
  lFlag_TCod.ItemIndex := Ord(Value);
end;

procedure TCdTypeMov.SetFlagTEstq(Index: TTypeEstq; const Value: Boolean);
begin
  case Index of
    etReal      : lFlag_MvEstq.Checked := Value;
    etReserved  : lFlag_MvRsrv.Checked := Value;
    etQuarentine: lFlag_MvQrnt.Checked := Value;
    etGiveBack  : lFlag_MvGrnt.Checked := Value;
  end;
end;

procedure TCdTypeMov.SetFlagTMov(const Value: TMovimentations);
begin
  lFlag_TMov.ItemIndex := Ord(Value);
end;

procedure TCdTypeMov.SetFlagTOper(Index: TTypeEstq; const Value: TTypeOper);
begin
  case Index of
    etReal      : lFlag_OpEstq.ItemIndex := Ord(Value);
    etReserved  : lFlag_OpRsrv.ItemIndex := Ord(Value);
    etQuarentine: lFlag_OpQrnt.ItemIndex := Ord(Value);
    etGiveBack  : lFlag_OpGrnt.ItemIndex := Ord(Value);
  end;
end;

procedure TCdTypeMov.SetPkTypeTMov(const Value: Integer);
begin
  ePk_Tipo_Movim_Estq.Text := IntToStr(Value);
end;

procedure TCdTypeMov.SetTypeMov(Value: TTypeMoviment);
var
  i: TTypeEstq;
  Data: PGridData;
begin
  Value.PkTypeMoviment   := PkTypeTMov;
  Value.FkTypeMoviment   := FkTypeTMov;
  Value.DscMov           := DscTMov;
  Value.FlagGenHst       := FlagGenHst;
  Value.FlagLocMov       := FlagTBaixa;
  Value.FlagTMov         := FlagTMov;
  Value.FkTypeMoviment   := FkTypeTMov;
  Value.FlagCode         := FlagTCod;
  for i := Low(TTypeEstq) to High(TTypeEstq) do
  begin
    Value.FlagMov[i]     := FlagTEstq[i];
    Value.FlagOper[i]    := FlagTOper[i];
  end;
  dmSysEstq.SaveTypeMov(Value, ScrState);
  if (vtList.FocusedNode <> nil) then
  begin
    Data := vtList.GetNodeData(vtList.FocusedNode);
    if (Data <> nil) and (Data^.DataRow <> nil) then
    begin
      Data^.DataRow.FieldByName['PK_TIPO_MOVIM_ESTQ'].AsInteger := Value.PkTypeMoviment;
      Data^.DataRow.FieldByName['DSC_TMOV'].AsString   := DscTMov;
      Data^.DataRow.FieldByName['FLAG_TMOV'].AsInteger := Ord(FlagTMov);
    end;
    Pk := Value.PkTypeMoviment;
  end;
end;

procedure TCdTypeMov.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Column <> 0) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_TMOV'].AsString;
end;

procedure TCdTypeMov.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Column <> 0) then exit;
  if (Data^.DataRow.FieldByName['PK_TIPO_MOVIM_ESTQ'].AsInteger > 0) then
    Pk := Data^.DataRow.FieldByName['PK_TIPO_MOVIM_ESTQ'].AsInteger;
end;

procedure TCdTypeMov.vtListPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) or (Column <> 0) then exit;
  case TMovimentations(Data^.DataRow.FieldByName['FLAG_TMOV'].AsInteger) of
    mvInput     : TargetCanvas.Font.Color := TYPE_MOV_COLOR[mvInput];
    mvOutput    : TargetCanvas.Font.Color := TYPE_MOV_COLOR[mvOutput];
    mvTransfer  : TargetCanvas.Font.Color := TYPE_MOV_COLOR[mvTransfer];
    mvAdjustment: TargetCanvas.Font.Color := TYPE_MOV_COLOR[mvAdjustment];
  end;
end;

procedure TCdTypeMov.lFlag_MvEstqClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (not lFlag_MvEstq.Checked) then
    lFlag_OpEstq.ItemIndex := 0;
  lFlag_OpEstq.Visible := lFlag_MvEstq.Checked;
end;

procedure TCdTypeMov.lFlag_MvRsrvClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (not lFlag_MvRsrv.Checked) then
    lFlag_OpRsrv.ItemIndex := 0;
  lFlag_OpRsrv.Visible := lFlag_MvRsrv.Checked;
end;

procedure TCdTypeMov.lFlag_MvGrntClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (not lFlag_MvGrnt.Checked) then
    lFlag_OpGrnt.ItemIndex := 0;
  lFlag_OpGrnt.Visible := lFlag_MvGrnt.Checked;
end;

procedure TCdTypeMov.lFlag_MvQrntClick(Sender: TObject);
begin
  ChangeGlobal(Sender);
  if (not lFlag_MvQrnt.Checked) then
    lFlag_OpQrnt.ItemIndex := 0;
  lFlag_OpQrnt.Visible := lFlag_MvQrnt.Checked;
end;

procedure TCdTypeMov.lFlag_TMovClick(Sender: TObject);
var
  i: Integer;
begin
  ChangeGlobal(Sender);
  if (FlagTMov = mvTransfer) then
  begin
    eFk_Tipo_Movim_Estq.Enabled := True;
    lFk_Tipo_Movim_Estq.Enabled := True;
    for i := 0 to eFk_Tipo_Movim_Estq.Items.Count - 1 do
      if (eFk_Tipo_Movim_Estq.Items.Objects[i] <> nil) then
      begin
        TTypeMoviment(eFk_Tipo_Movim_Estq.Items.Objects[i]).Free;
        eFk_Tipo_Movim_Estq.Items.Objects[i] := nil;
      end;
    eFk_Tipo_Movim_Estq.Clear;
    eFk_Tipo_Movim_Estq.Items.Add('<Nenhum>');
    with dmSysEstq.LoadTypeMovement(0) do
      for i := 0 to Count - 1 do
           eFk_Tipo_Movim_Estq.Items.AddObject(TTypeMoviment(Objects[i]).DscMov,
             TTypeMoviment(Objects[i]));
  end
  else
  begin
    eFk_Tipo_Movim_Estq.Enabled := False;
    lFk_Tipo_Movim_Estq.Enabled := False;
  end;
end;

procedure TCdTypeMov.CreateModel;
begin
  if (RowModel = nil) or (RowModel.Count = 0) then
  begin
    if (RowModel = nil) then
      RowModel := TDataRow.Create(nil);
    RowModel.AddAs('DSC_TMOV', '', ftString, 31);
    RowModel.AddAs('PK_TIPO_MOVIM_ESTQ', 0, ftInteger, SizeOf(Integer));
    RowModel.AddAs('FLAG_TMOV', 0, ftInteger, SizeOf(Integer));
  end;
end;

function TCdTypeMov.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (FlagTMov = mvTransfer) and (FkTypeTMov = 0) then
  begin
    Dados.DisplayHint(eFk_Tipo_Movim_Estq, 'Uma movimentação de entrada deve ' +
      'ser informada para este tipo de movimentação');
    Result := False;
  end;
end;

initialization
  RegisterClass(TCdTypeMov);

end.
