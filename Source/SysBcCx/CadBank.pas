unit CadBank;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 03/01/2006 - DD/MM/YYYY                                      *}
{* Modified: 03/01/2006 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CadModel, ComCtrls, StdCtrls, ExtCtrls, VirtualTrees, Mask,
  ToolEdit, CurrEdit, PrcCombo, TSysBcCx;

type
  PGridRecord = ^TGridRecord;
  TGridRecord = record
    Node   : PVirtualNode;
    Level  : Integer;
    DataRow: TAgency;
  end;

  TCdBank = class(TfrmModel)
    vtAgency: TVirtualStringTree;
    Shape1: TShape;
    lTitle: TLabel;
    pgBanks: TPageControl;
    tsBanks: TTabSheet;
    tsAgency: TTabSheet;
    lPk_Bancos: TStaticText;
    ePk_Bancos: TCurrencyEdit;
    lDsc_Bco: TStaticText;
    eDsc_Bco: TEdit;
    lPk_Agencias: TStaticText;
    lDsc_Age: TStaticText;
    eDsc_Age: TEdit;
    ePk_Agencias: TEdit;
    lFk_Cadastros: TStaticText;
    eFk_Cadastros: TPrcComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pgBanksChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pgBanksChange(Sender: TObject);
    procedure vtAgencyGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
  private
    FPkAgency: string;
    FAgencies: TAgencies;
    function  GetAgencies: TAgencies;
    function  GetAgency: TAgency;
    function  GetBank: TBank;
    function  GetDscAge: string;
    function  GetDscBco: string;
    function  GetFkOwner: Integer;
    function  GetPkAgency: string;
    function  GetPkBank: Integer;
    procedure SetAgency(Value: TAgency);
    procedure SetBank(const Value: TBank);
    procedure SetDscAge(const Value: string);
    procedure SetDscBco(const Value: string);
    procedure SetFkOwner(const Value: Integer);
    procedure SetPkAgency(const Value: string);
    procedure SetPkBank(const Value: Integer);
    function  FillAgenciesTree: TAgencies;
    procedure ReleaseTreeNodes;
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property  Agency  : TAgency   read GetAgency   write SetAgency;
    property  Agencies: TAgencies read GetAgencies;
    property  Bank    : TBank     read GetBank     write SetBank;
    property  DscAge  : string    read GetDscAge   write SetDscAge;
    property  DscBco  : string    read GetDscBco   write SetDscBco;
    property  FkOwner : Integer   read GetFkOwner  write SetFkOwner;
    property  PkAgency: string    read GetPkAgency write SetPkAgency;
    property  PkBank  : Integer   read GetPkBank   write SetPkBank;
  end;

var
  CdBank: TCdBank;

implementation

uses Dado, mSysBcCx, ProcUtils;

{$R *.dfm}

{ TCdBank }

procedure TCdBank.FormCreate(Sender: TObject);
begin
  FAgencies              := TAgencies.Create(Self);
  FPkAgency              := '';
  vtAgency.NodeDataSize  := SizeOf(TGridRecord);
  vtAgency.Images        := Dados.Image16;
  vtAgency.Header.Images := Dados.Image16;
  inherited;
end;

procedure TCdBank.FormDestroy(Sender: TObject);
begin
  if Assigned(FAgencies) then FAgencies.Free;
  FAgencies := nil;
  inherited;
end;

procedure TCdBank.ClearControls;
begin
  Loading  := True;
  PkBank   := 0;
  DscBco   := '';
  PkAgency := '';
  DscAge   := '';
  FkOwner  := 0;
  Loading  := False;
end;

function TCdBank.GetAgencies: TAgencies;
begin
  ReleaseTreeNodes;
  Result := FillAgenciesTree;
end;

function TCdBank.GetAgency: TAgency;
var
  Data: PGridRecord;
begin
  Result := nil;
  if (vtAgency.RootNodeCount > 0) then
  begin
    if (vtAgency.FocusedNode = nil) then exit;
    Data := vtAgency.GetNodeData(vtAgency.FocusedNode);
    if (Data = nil) or (Data^.DataRow = nil) then exit;
    Result := Data^.DataRow;
  end;
  if (Result = nil) then exit;
  Loading      := True;
  PkAgency     := Result.PkAgency;
  DscAge       := Result.DscAgency;
  FkOwner      := Result.FkOwner;
  Loading      := False;
end;

function TCdBank.GetBank: TBank;
begin
  Result := dmSysBcCx.GetBank(Pk);
  if (Result = nil) then exit;
  Loading  := True;
  PkBank   := Result.PkBank;
  DscBco   := Result.DscBank;
  GetAgencies;
  Loading  := False;
end;

function TCdBank.GetDscAge: string;
begin
  Result := eDsc_Age.Text;
end;

function TCdBank.GetDscBco: string;
begin
  Result := eDsc_Bco.Text;
end;

function TCdBank.GetFkOwner: Integer;
var
  aIdx: Integer;
begin
  Result := 0;
  aIdx := eFk_Cadastros.ItemIndex;
  if (aIdx > -1) and (eFk_Cadastros.Items.Objects[aIdx] <> nil) then
    Result := Integer(eFk_Cadastros.Items.Objects[aIdx]);
end;

function TCdBank.GetPkAgency: string;
begin
  Result := ePk_Agencias.Text;
end;

function TCdBank.GetPkBank: Integer;
begin
  Result := ePk_Bancos.AsInteger;
end;

procedure TCdBank.LoadDefaults;
begin
  if (not ListLoaded) then
    eFk_Cadastros.Items.AddStrings(dmSysBcCx.LoadOwners(tlDebit));
end;

procedure TCdBank.MoveDataToControls;
begin
  if (pgBanks.ActivePageIndex = 0) then
    GetBank
  else
    GetAgency;
end;

procedure TCdBank.SaveIntoDB;
begin
  if (pgBanks.ActivePageIndex = 0) then
    SetBank(TBank.Create)
  else
    SetAgency(nil);
end;

procedure TCdBank.SetAgency(Value: TAgency);
var
  OldPk: string;
  Data : PGridRecord;
begin
  if (Value = nil) and (vtAgency.FocusedNode = nil) then exit;
  Data := vtAgency.GetNodeData(vtAgency.FocusedNode);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Loading         := True;
  OldPk           := Data^.DataRow.PkAgency;
  Value           := Data^.DataRow;
  Value.PkAgency  := PkAgency;
  Value.DscAgency := DscAge;
  Value.FkOwner   := FkOwner;
  Loading         := False;
  dmSysBcCx.SaveAgency(Pk, OldPk, Value, ScrState);
end;

procedure TCdBank.SetBank(const Value: TBank);
begin
  if (Value = nil) then exit;
  Loading       := True;
  Value.PkBank  := PkBank;
  Value.DscBank := DscBco;
  Loading       := False;
  dmSysBcCx.SaveBank(Pk, Value, ScrState);
end;

procedure TCdBank.SetDscAge(const Value: string);
begin
  eDsc_Age.Text := Value;
end;

procedure TCdBank.SetDscBco(const Value: string);
begin
  eDsc_Bco.Text := Value;
end;

procedure TCdBank.SetFkOwner(const Value: Integer);
begin
  eFk_Cadastros.SetIndexFromIntegerValue(Value);
end;

procedure TCdBank.SetPkAgency(const Value: string);
begin
  ePk_Agencias.Text := Value;
end;

procedure TCdBank.SetPkBank(const Value: Integer);
begin
  ePk_Bancos.AsInteger := Value;
end;

procedure TCdBank.pgBanksChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := (ScrState in UPDATE_MODE);
end;

procedure TCdBank.pgBanksChange(Sender: TObject);
begin
  MoveDataToControls;
end;

function TCdBank.FillAgenciesTree: TAgencies;
var
  i   : Integer;
  Node: PVirtualNode;
  Data: PGridRecord;
begin
  Node := nil;
  if dmSysBcCx.GetAgencies(Self, Pk, FAgencies) then
  begin
    with vtAgency do
    begin
      BeginUpdate;
      try
        for i := 0 to FAgencies.Count - 1 do
        begin
          Node := AddChild(nil);
          if (Node <> nil) then
          begin
            Data := GetNodeData(Node);
            if (Data <> nil) then
            begin
              Data^.Node    := Node;
              Data^.Level   := GetNodeLevel(Node);
              Data^.DataRow := FAgencies.Items[i];
            end;
          end;
        end;
      finally
        EndUpdate;
      end;
    end;
  end;
  if (vtAgency.RootNodeCount > 0) then
  begin
    vtAgency.FocusedNode    := Node;
    vtAgency.Selected[Node] := True;
  end;
  Result := FAgencies;
end;

procedure TCdBank.ReleaseTreeNodes;
var
  Node: PVirtualNode;
  Data: PGridRecord;
begin
  if (vtAgency.RootNodeCount = 0) then exit;
  with vtAgency do
  begin
    BeginUpdate;
    try
      Node := GetFirst;
      while (Node <> nil) do
      begin
        Data := GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.Node    := nil;
          Data^.Level   := 0;
          Data^.DataRow := nil;
        end;
        Node := GetNext(Node);
      end;
    finally
      EndUpdate;
    end;
  end;
  FAgencies.Clear;
end;

procedure TCdBank.vtAgencyGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridRecord;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.DscAgency;
end;

end.
