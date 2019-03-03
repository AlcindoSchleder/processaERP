unit CadTickt;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created  : 02/06/2003                                                 *}
{* Modified :                                                            *}
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
  Dialogs, VirtualTrees, ComCtrls, ToolWin, ProcUtils, StdCtrls, ImgList,
  Buttons, CadListModel, ExtCtrls;

type
  TCdTickets = class(TfrmModelList)
    lPk_Tickets: TStaticText;
    ePk_Tickets: TEdit;
    eDsc_Ticket: TEdit;
    lDsc_Ticket: TStaticText;
    lFk_Cadastros: TStaticText;
    eFk_Cadastros: TComboBox;
    eFk_Finalizadoras: TComboBox;
    lFk_Finalizadoras: TStaticText;
    lFk_Classificacao: TStaticText;
    eFk_Classificacao: TComboBox;
    pgProducts: TPageControl;
    tsList: TTabSheet;
    tsData: TTabSheet;
    lFk_Produtos: TStaticText;
    eFk_Produtos: TComboBox;
    VirtualStringTree1: TVirtualStringTree;
    bbNew: TSpeedButton;
    bbModify: TBitBtn;
    bbCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer;
      var ImageList: TCustomImageList);
    procedure eFk_CadastrosDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure eFk_ClassificacaoSelect(Sender: TObject);
    procedure pgProductsChanging(Sender: TObject;
      var AllowChange: Boolean);
  private
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetDscTicket: string;
    function  GetFkClassification: Integer;
    function  GetFkFinalization: Integer;
    function  GetFkOwner: Integer;
    function  GetFkProduct: Integer;
    function  GetFlagTTicket: Integer;
    function  GetPkTickets: Integer;
    procedure SetDscTicket(const Value: string);
    procedure SetFkClassification(const Value: Integer);
    procedure SetFkFinalization(const Value: Integer);
    procedure SetFkOwner(const Value: Integer);
    procedure SetFkProduct(const Value: Integer);
    procedure SetPkTickets(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkTickets       : Integer read GetPkTickets        write SetPkTickets;
    property  FkProduct       : Integer read GetFkProduct        write SetFkProduct;
    property  FkOwner         : Integer read GetFkOwner          write SetFkOwner;
    property  FkFinalization  : Integer read GetFkFinalization   write SetFkFinalization;
    property  FkClassification: Integer read GetFkClassification write SetFkClassification;
    property  DscTicket       : string  read GetDscTicket        write SetDscTicket;
    property  FlagTTicket     : Integer read GetFlagTTicket;
  public
    { Public declarations }
  end;

implementation

uses Dado, mSysBcCx, TSysFatAux, ProcType, GridRow, TSysPedAux, ArqSqlBcCx, DB;

const
  DESCR_FLAG_TTICKET: array [0..1] of string =
    ('Ticket Pós Pago',  'Ticket Pré Pago');

{$R *.dfm}

{ TCdTickets }

function TCdTickets.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (FkClassification = 0) then
  begin
    S := 'Campo Classificação Financeira deve ser preenchido';
    C := eFk_Classificacao;
  end;
  if (FkFinalization = 0) then
  begin
    S := 'Campo Finalizadora deve ser preenchido';
    C := eFk_Finalizadoras;
  end;
  if (DscTicket = '') then
  begin
    S := 'Campo Descrição deve ser preenchido';
    C := eDsc_Ticket;
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdTickets.ClearControls;
begin
  Loading := True;
  try
    PkTickets        := 0;
    FkOwner          := 0;
    FkProduct        := 0;
    FkFinalization   := 0;
    FkClassification := 0;
    DscTicket        := '';
  finally
    Loading := False;
  end;
end;

function TCdTickets.GetDscTicket: string;
begin
  Result := eDsc_Ticket.Text;
end;

function TCdTickets.GetFkClassification: Integer;
begin
  Result := 0;
  with eFk_Classificacao do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
end;

function TCdTickets.GetFkFinalization: Integer;
begin
  Result := 0;
  with eFk_Finalizadoras do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdTickets.GetFkOwner: Integer;
begin
  Result := 0;
  with eFk_Cadastros do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdTickets.GetFkProduct: Integer;
begin
  Result := 0;
  with eFk_Produtos do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdTickets.GetFlagTTicket: Integer;
var
  Data: PGridData;
begin
  Result := -1;
  with vtList do
  begin
    if (FocusedNode <> nil) then
    begin
      if (FocusedNode.Parent <> nil) then
        Data := GetNodeData(FocusedNode.Parent)
      else
        Data := GetNodeData(FocusedNode);
      if (Data <> nil) and (Data^.DataRow <> nil) then
        Result := Data^.DataRow.FieldByName['FLAG_TTICKET'].AsInteger;
    end;
  end;
end;

function TCdTickets.GetPkTickets: Integer;
begin
  Result := StrToIntDef(ePk_Tickets.Text, 0);
end;

procedure TCdTickets.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Produtos.Items.AddStrings(dmSysBcCx.LoadProducts);
    eFk_Cadastros.Items.AddStrings(dmSysBcCx.LoadOwners(tlCredit));
    eFk_Classificacao.Items.AddStrings(dmSysBcCx.LoadClassifications(tlCredit));
    eFk_Finalizadoras.Items.AddStrings(dmSysBcCx.LoadFinalizations(fnTicket));
    ListLoaded := True;
  end;
end;

procedure TCdTickets.LoadList(Sender: TObject);
var
  Data     : PGridData;
  NodePos  : PVirtualNode;
  NodePre  : PVirtualNode;
  aFlag    : Integer;
  function AddFolderNode(Node: PVirtualNode; const AIdx: Integer;
    const AType: TTypeNode): PVirtualNode;
  begin
    Result := AddDataNode(Node, dmSysBcCx.qrSqlAux);
    if (Result <> nil) then
    begin
      Data := vtList.GetNodeData(Result);
      if (Data <> nil) then
      begin
        Data^.NodeType := AType;
        if (aType = tnFolder) then
        begin
          Data^.DataRow.FieldByName['PK_TICKETS'].AsInteger   := 0;
          Data^.DataRow.FieldByName['FLAG_TTICKET'].AsInteger := AIdx;
        end;
        if (Data^.DataRow <> nil) then
          Data^.DataRow.AddAs('DSC_FLD', DESCR_FLAG_TTICKET[AIdx], ftString, 31);
      end;
    end;
  end;
begin
  inherited;
  with dmSysBcCx do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlTickets);
    vtList.BeginUpdate;
    Dados.StartTransaction(qrSqlAux);
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      if (RowModel = nil) then
      begin
        RowModel := TDataRow.CreateFromDataSet(Self, qrSqlAux, False);
        RowModel.AddAs('DSC_FLD', '', ftString, 31);
      end;
      NodePos := AddFolderNode(nil, 0, tnFolder);
      NodePre := AddFolderNode(nil, 1, tnFolder);
      while (not qrSqlAux.Eof) do
      begin
        aFlag := qrSqlAux.FieldByName('FLAG_TTICKET').AsInteger;
        if (aFlag = 0) then
          AddFolderNode(NodePos, aFlag, tnData)
        else
          AddFolderNode(NodePre, aFlag, tnData);
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
      vtList.EndUpdate;
    end;
    if (vtList.RootNodeCount > 0) then
    begin
      vtList.FocusedNode                  := vtList.GetFirst;
      vtList.Selected[vtList.FocusedNode] := True;
    end;
  end;
end;

procedure TCdTickets.MoveDataToControls;
begin
  Loading := True;
  try
    with dmSysBcCx.Tickets[Pk] do
    begin
      PkTickets        := FieldByName['PK_TICKETS'].AsInteger;
      FkOwner          := FieldByName['FK_CADASTROS'].AsInteger;
      FkProduct        := FieldByName['FK_PRODUTOS'].AsInteger;
      FkFinalization   := FieldByName['FK_FINALIZADORAS'].AsInteger;
      FkClassification := FieldByName['FK_CLASSIFICACAO'].AsInteger;
      DscTicket        := FieldByName['DSC_TICKET'].AsString;
    end;
  finally
    Loading := False;
  end;
end;

procedure TCdTickets.SaveIntoDB;
var
  AData: TDataRow;
  PData: PGridData;
begin
  AData := TDataRow.Create(nil);
  try
    AData.AddAs('PK_TICKETS', Pk, ftInteger, SizeOf(Integer));
    AData.AddAs('FK_CADASTROS', FkOwner, ftInteger, SizeOf(Integer));
    AData.AddAs('FK_PRODUTOS', FkProduct, ftInteger, SizeOf(Integer));
    AData.AddAs('FK_FINALIZADORAS', FkFinalization, ftInteger, SizeOf(Integer));
    AData.AddAs('FK_CLASSIFICACAO', FkClassification, ftInteger, SizeOf(Integer));
    AData.AddAs('DSC_TICKET', DscTicket, ftString, 31);
    AData.AddAs('FLAG_TTICKET', FlagTTicket, ftInteger, SizeOf(Integer));
    dmSysBcCx.Tickets[Ord(ScrState)] := AData;
    with vtList do
    begin
      BeginUpdate;
      try
        if (FocusedNode <> nil) then
        begin
          PData := GetNodeData(FocusedNode);
          if (PData <> nil) and (PData^.DataRow <> nil) then
          begin
            with PData^.DataRow do
            begin
              PData^.NodeType := tnData;
              PData^.Level    := 1;
              FieldByName['PK_TICKETS'].AsInteger   := AData.FieldByName['PK_TICKETS'].AsInteger;
              FieldByName['FLAG_TTICKET'].AsInteger := AData.FieldByName['FLAG_TTICKET'].AsInteger;
              FieldByName['DSC_TICKET'].AsString    := AData.FieldByName['DSC_TICKET'].AsString;
              FieldByName['DSC_FLD'].AsString       := DESCR_FLAG_TTICKET[FlagTTicket];
            end;
          end;
        end;
      finally
        EndUpdate;
      end;
    end;
    Pk := AData.FieldByName['PK_TICKETS'].AsInteger;
  finally
    FreeAndNil(AData);
  end;
end;

procedure TCdTickets.SetDscTicket(const Value: string);
begin
  eDsc_Ticket.Text := Value;
end;

procedure TCdTickets.SetFkClassification(const Value: Integer);
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

procedure TCdTickets.SetFkFinalization(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Finalizadoras do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTickets.SetFkOwner(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Cadastros do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTickets.SetFkProduct(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Produtos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
      if (Items.Objects[i] <> nil) and
         (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdTickets.SetPkTickets(const Value: Integer);
begin
  ePk_Tickets.Text := IntToStr(Value);
end;

procedure TCdTickets.FormCreate(Sender: TObject);
begin
  OnCheckRecord := CheckRecord;
  OnListLoad    := LoadList;
  inherited;
end;

procedure TCdTickets.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  PData: PGridData;
begin
  if (Node = nil) then exit;
  PData := Sender.GetNodeData(Node);
  if (PData = nil) or (PData^.DataRow = nil) then exit;
  Pk := PData^.DataRow.FieldByName['PK_TICKETS'].AsInteger;
end;

procedure TCdTickets.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  PData: PGridData;
begin
  if (Node = nil) then exit;
  PData := Sender.GetNodeData(Node);
  if (PData = nil) or (PData^.DataRow = nil) then exit;
  case PData^.Level of
    0: CellText := PData^.DataRow.FieldByName['DSC_FLD'].AsString;
    1: CellText := PData^.DataRow.FieldByName['PK_TICKETS'].AsString + '/' +
                   PData^.DataRow.FieldByName['DSC_TICKET'].AsString;
  end;
end;

procedure TCdTickets.vtListGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer;
  var ImageList: TCustomImageList);
var
  PData: PGridData;
begin
  inherited;
  if (Node = nil) then exit;
  PData := Sender.GetNodeData(Node);
  if (PData = nil) or (PData^.DataRow = nil) then exit;
  if (Node = Sender.FocusedNode) and (ScrState in UPDATE_MODE) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    ImageIndex := 22;
end;

procedure TCdTickets.eFk_CadastrosDrawItem(Control: TWinControl;
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
    TextOut(Rect.Left + 200, Rect.Top, aStr);
  end;
end;

procedure TCdTickets.eFk_ClassificacaoSelect(Sender: TObject);
begin
  with eFk_Classificacao do
    if (ItemIndex < 0) or (Items.Objects[ItemIndex] = nil) or
       (not TClassification(Items.Objects[ItemIndex]).FlagAnlSnt) then
    begin
      ItemIndex := -1;
      exit;
    end;
  ChangeGlobal(Sender);
end;

procedure TCdTickets.pgProductsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := False;
end;

initialization
  RegisterClass(TCdTickets);
end.
