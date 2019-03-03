unit CadTFre;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 18/04/2006 - DD/MM/YYYY                                    *}
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
  Dialogs, CadListModel, StdCtrls, ExtCtrls, VirtualTrees, ComCtrls, ToolWin,
  Mask, ToolEdit, CurrEdit, TSysFatAux, TSysPedAux, ProcUtils;

type
  TCdTipoFretes = class(TfrmModelList)
    lPk_Tipo_Fretes: TStaticText;
    eFk_Tipo_Pagamentos: TComboBox;
    lFk_Tipo_Pagamentos: TStaticText;
    lFk_Classificacao: TStaticText;
    eFk_Classificacao: TComboBox;
    eDsc_TpFre: TEdit;
    lDsc_TpFre: TStaticText;
    lFlag_Tp_Fre: TRadioGroup;
    lFlag_Acu: TCheckBox;
    lFlag_Fin: TCheckBox;
    lFlag_NF: TCheckBox;
    ePk_Tipo_Fretes: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure eFk_ClassificacaoDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscTpFre: string;
    function  GetFkClassificacao: Integer;
    function  GetFkTipoPagamentos: Integer;
    function  GetFlagAcu: Boolean;
    function  GetFlagFin: Boolean;
    function  GetFlagNF: Boolean;
    function  GetFlagTpFre: Integer;
    function  GetPkTipoFretes: Integer;
    procedure SetDscTpFre(const Value: string);
    procedure SetFkClassificacao(const Value: Integer);
    procedure SetFkTipoPagamentos(const Value: Integer);
    procedure SetFlagAcu(const Value: Boolean);
    procedure SetFlagFin(const Value: Boolean);
    procedure SetFlagNF(const Value: Boolean);
    procedure SetFlagTpFre(const Value: Integer);
    procedure SetPkTipoFretes(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkTipoFretes    : Integer read GetPkTipoFretes     write SetPkTipoFretes;
    property  FkTipoPagamentos: Integer read GetFkTipoPagamentos write SetFkTipoPagamentos;
    property  FkClassificacao : Integer read GetFkClassificacao  write SetFkClassificacao;
    property  DscTpFre        : string  read GetDscTpFre         write SetDscTpFre;
    property  FlagTpFre       : Integer read GetFlagTpFre        write SetFlagTpFre;
    property  FlagFin         : Boolean read GetFlagFin          write SetFlagFin;
    property  FlagAcu         : Boolean read GetFlagAcu          write SetFlagAcu;
    property  FlagNF          : Boolean read GetFlagNF           write SetFlagNF;
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysPed, GridRow, DB, PedArqSql, ProcType;

{$R *.dfm}

{ TCdTipoFretes }

function TCdTipoFretes.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
begin
  Result := True;
  if (DscTpFre = '') then
  begin
    Dados.DisplayHint(eDsc_TpFre, 'Campo descrição deve ser preenchido');
    Result := False;
  end;
end;

procedure TCdTipoFretes.ClearControls;
begin
  Loading := True;
  try
    PkTipoFretes     := 0;
    FkTipoPagamentos := 0;
    FkClassificacao  := 0;
    DscTpFre         := '';
    FlagTpFre        := 1;
    FlagFin          := False;
    FlagAcu          := False;
    FlagNF           := False;
  finally
    Loading := False;
  end;
end;

function TCdTipoFretes.GetDscTpFre: string;
begin
  Result := eDsc_TpFre.Text;
end;

function TCdTipoFretes.GetFkClassificacao: Integer;
begin
  Result := 0;
  with eFk_Classificacao do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
end;

function TCdTipoFretes.GetFkTipoPagamentos: Integer;
begin
  Result := 0;
  with eFk_Tipo_Pagamentos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TTypePayment(Items.Objects[ItemIndex]).PkTypePgto;
end;

function TCdTipoFretes.GetFlagAcu: Boolean;
begin
  Result := lFlag_Acu.Checked;
end;

function TCdTipoFretes.GetFlagFin: Boolean;
begin
  Result := lFlag_Fin.Checked;
end;

function TCdTipoFretes.GetFlagNF: Boolean;
begin
  Result := lFlag_NF.Checked;
end;

function TCdTipoFretes.GetFlagTpFre: Integer;
begin
  Result := lFlag_Tp_Fre.ItemIndex + 1;
end;

function TCdTipoFretes.GetPkTipoFretes: Integer;
begin
  Result := ePk_Tipo_Fretes.AsInteger;
end;

procedure TCdTipoFretes.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Classificacao.Items.AddStrings(dmSysPed.LoadClassifications(0));
    eFk_Tipo_Pagamentos.Items.AddStrings(dmSysPed.LoadTypePayment(1));
  end;
end;

procedure TCdTipoFretes.LoadList(Sender: TObject);
begin
  inherited;
  with dmSysPed, vtList do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlTypeFreights);
    Dados.StartTransaction(qrSqlAux);
    BeginUpdate;
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
        RowModel := TDataRow.CreateFromDataSet(Self, qrSqlAux, False);
      while (not qrSqlAux.Eof) do
      begin
        AddDataNode(nil, qrSqlAux);
        qrSqlAux.Next;
      end;
    finally
      EndUpdate;
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
    if (RootNodeCount > 0) then
    begin
      FocusedNode           := GetFirst;
      Selected[FocusedNode] := True;
    end;
  end;
end;

procedure TCdTipoFretes.MoveDataToControls;
var
  aItem: TDataRow;
begin
  Loading := True;
  try
    aItem            := dmSysPed.TypeFreight[Pk];
    PkTipoFretes     := aItem.FieldByName['PK_TIPO_FRETES'].AsInteger;
    FkTipoPagamentos := aItem.FieldByName['FK_TIPO_PAGAMENTOS'].AsInteger;
    FkClassificacao  := aItem.FieldByName['FK_CLASSIFICACAO'].AsInteger;
    DscTpFre         := aItem.FieldByName['DSC_TPFRE'].AsString;
    FlagTpFre        := aItem.FieldByName['FLAG_TP_FRE'].AsInteger;
    FlagFin          := Boolean(aItem.FieldByName['FLAG_FIN'].AsInteger);
    FlagAcu          := Boolean(aItem.FieldByName['FLAG_ACU'].AsInteger);
    FlagNF           := Boolean(aItem.FieldByName['FLAG_NF'].AsInteger);
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
end;

procedure TCdTipoFretes.SaveIntoDB;
var
  aItem: TDataRow;
  Data : PGridData;
begin
  aItem := TDataRow.Create(nil);
  try
    aItem.AddAs('PK_TIPO_FRETES', PkTipoFretes, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_TIPO_PAGAMENTOS', FkTipoPagamentos, ftInteger, SizeOf(Integer));
    aItem.AddAs('FK_CLASSIFICACAO', FkClassificacao, ftInteger, SizeOf(Integer));
    aItem.AddAs('DSC_TPFRE', DscTpFre, ftString, 31);
    aItem.AddAs('FLAG_TP_FRE', FlagTpFre, ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_FIN', Ord(FlagFin), ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_ACU', Ord(FlagAcu), ftInteger, SizeOf(Integer));
    aItem.AddAs('FLAG_NF', Ord(FlagNF), ftInteger, SizeOf(Integer));
    dmSysPed.TypeFreight[Ord(ScrState)] := aItem;
    with vtList do
    begin
      if (FocusedNode <> nil) then
      begin
        Data := GetNodeData(FocusedNode);
        if (Data <> nil) or (Data^.DataRow <> nil) then
        begin
          Data^.DataRow.FieldByName['PK_TIPO_FRETES'].AsInteger :=
            aItem.FieldByName['PK_TIPO_FRETES'].AsInteger;
          Data^.DataRow.FieldByName['DSC_TPFRE'].AsString :=
            aItem.FieldByName['DSC_TPFRE'].AsString;
        end;
      end;
    end;
    Pk := aItem.FieldByName['PK_TIPO_FRETES'].AsInteger;
  finally
    FreeAndNil(aItem);
  end;
end;

procedure TCdTipoFretes.SetDscTpFre(const Value: string);
begin
  eDsc_TpFre.Text := Value;
end;

procedure TCdTipoFretes.SetFkClassificacao(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Classificacao do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (TClassification(Items.Objects[i]).Pk = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTipoFretes.SetFkTipoPagamentos(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Tipo_Pagamentos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (TTypePayment(Items.Objects[i]).PkTypePgto = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTipoFretes.SetFlagAcu(const Value: Boolean);
begin
  lFlag_Acu.Checked := Value;
end;

procedure TCdTipoFretes.SetFlagFin(const Value: Boolean);
begin
  lFlag_Fin.Checked := Value;
end;

procedure TCdTipoFretes.SetFlagNF(const Value: Boolean);
begin
  lFlag_NF.Checked := Value;
end;

procedure TCdTipoFretes.SetFlagTpFre(const Value: Integer);
begin
  lFlag_Tp_Fre.ItemIndex := Value - 1;
end;

procedure TCdTipoFretes.SetPkTipoFretes(const Value: Integer);
begin
  ePk_Tipo_Fretes.AsInteger := Value;
end;

procedure TCdTipoFretes.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdTipoFretes.eFk_ClassificacaoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aClass : TClassification;
  aColor : TColor;
  aOffSet: Integer;
  aStr   ,
  aItmStr: string;
begin
  if (Index > TComboBox(Control).Items.Count) or
     (TComboBox(Control).Items.Objects[Index] = nil) or
     (not (TComboBox(Control).Items.Objects[Index] is TClassification)) then
  begin
    TComboBox(Control).Canvas.TextOut(Rect.Left, Rect.Top,
      TComboBox(Control).Items.Strings[Index]);
    exit;
  end;
  aClass  := TClassification(TComboBox(Control).Items.Objects[Index]);
  aColor  := clGray;
  aOffSet := aClass.NivCta * 10;
  if aClass.FlagAnlSnt then
    aColor  := clWindowText;
  with (Control as TComboBox).Canvas do
  begin
    if (odSelected in State) then
      Font.Color := clWhite
    else
      Font.Color := aColor;
    aStr       := TComboBox(Control).Items.Strings[Index];
    aItmStr    := Copy(aStr, 1, Pos('|', aStr) - 1);
    Delete(aStr, 1, Pos('|', aStr));
    TextOut(Rect.Left + aOffSet, Rect.Top, aItmStr);
    TextOut(Rect.Left + 300, Rect.Top, aStr);
  end;
end;

procedure TCdTipoFretes.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Pk := Data^.DataRow.FieldByName['PK_TIPO_FRETES'].AsInteger;
end;

procedure TCdTipoFretes.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  with Data^.DataRow do
    CellText := FieldByName['PK_TIPO_FRETES'].AsString + ' / ' +
                FieldByName['DSC_TPFRE'].AsString;
end;

initialization
  RegisterClass(TCdTipoFretes);

end.
