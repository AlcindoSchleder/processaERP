unit CadMun;

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
  Dialogs, CadModel, Mask, ToolEdit, CurrEdit, StdCtrls, ExtCtrls, ProcUtils,
  ComCtrls, Buttons, VirtualTrees, mSysCad;

type
  TCdMunicipios = class(TfrmModel)
    lPk_Municipios: TStaticText;
    ePk_Municipios: TEdit;
    eDsc_Mun: TEdit;
    lDsc_Mun: TStaticText;
    lCep_Mun: TStaticText;
    eCep_Mun: TCurrencyEdit;
    shTitle: TShape;
    lTitle: TLabel;
    StaticText1: TStaticText;
    eAlq_Iss: TCurrencyEdit;
    eFk_Cargas_Regioes: TComboBox;
    lFk_Cargas_Regioes: TStaticText;
    lFlag_Cap: TCheckBox;
    vtPrinters: TVirtualStringTree;
    sbNewRegion: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure vtPrintersGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtPrintersNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure vtPrintersEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure sbNewRegionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FFkCountry: Integer;
    FFkState: string;
    { Private declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetAlqtIss: Double;
    function  GetCepCity: Integer;
    function  GetDscCity: string;
    function  GetFlagCap: Boolean;
    function  GetPkCity: Integer;
    function  GetRegions: Integer;
    function  GetRegsCount: Integer;
    function  GetCityTax(Index: Cardinal): TCityTax;
    procedure ClearPrinters;
    procedure LoadPrinters(AGetUpdateData: Boolean);
    procedure SavePrinters;
    procedure SetAlqtIss(const Value: Double);
    procedure SetCepCity(const Value: Integer);
    procedure SetDscCity(const Value: string);
    procedure SetFlagCap(const Value: Boolean);
    procedure SetPkCity(const Value: Integer);
    procedure SetRegions(const Value: Integer);
    procedure ReleaseRegions;
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    property  PkCity   : Integer                     read GetPkCity    write SetPkCity;
    property  CepCity  : Integer                     read GetCepCity   write SetCepCity;
    property  AlqtIss  : Double                      read GetAlqtIss   write SetAlqtIss;
    property  FkRegions: Integer                     read GetRegions   write SetRegions;
    property  FlagCap  : Boolean                     read GetFlagCap   write SetFlagCap;
    property  FkCityTaxes[Index: Cardinal]: TCityTax read GetCityTax;
    property  RegsCount: Integer                     read GetRegsCount;
  public
    { Public declarations }
    property  FkCountry: Integer read FFkCountry write FFkCountry;
    property  FkState  : string  read FFkState   write FFkState;
    property  DscCity  : string  read GetDscCity write SetDscCity;
  end;

var
  CdMunicipios: TCdMunicipios;

implementation

uses Dado, ProcType, GridRow, CadArqSql, TSysCadAux, DB, CadReg;

{$R *.dfm}

function TCdMunicipios.CheckRecord(const OldState,
  NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (DscCity = '') then
  begin
    C := eDsc_Mun;
    S := 'Campo Descrição deve ser preenchido';
  end;
  if (S <> '') then
  begin
    Dados.DisplayHint(C, S);
    Result := False;
  end;
end;

procedure TCdMunicipios.ClearControls;
begin
  Loading := True;
  try
    ClearPrinters;
    PkCity    := 0;
    CepCity   := 0;
    AlqtIss   := 0.0;
    FkRegions := 0;
    FlagCap   := False;
    DscCity   := '';
  finally
    Loading := True;
  end;
end;

procedure TCdMunicipios.ClearPrinters;
begin
  vtPrinters.Clear;
end;

procedure TCdMunicipios.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord := CheckRecord;
  vtPrinters.NodeDataSize := SizeOf(TCityTax);
end;

function TCdMunicipios.GetAlqtIss: Double;
begin
  Result := eAlq_Iss.Value;
end;

function TCdMunicipios.GetCepCity: Integer;
begin
  Result := eCep_Mun.AsInteger;
end;

function TCdMunicipios.GetCityTax(Index: Cardinal): TCityTax;
var
  Node: PVirtualNode;
begin
  if (vtPrinters.RootNodeCount > Index) then
  begin
    Node := vtPrinters.GetFirst;
    while (Node <> nil) do
    begin
      if (vtPrinters.AbsoluteIndex(Node) = Index) then
      begin
        Result := TCityTax(vtPrinters.GetNodeData(Node)^);
      end;
      Node := vtPrinters.GetNext(Node);
    end;
  end;
end;

function TCdMunicipios.GetDscCity: string;
begin
  Result := eDsc_Mun.Text;
end;

function TCdMunicipios.GetFlagCap: Boolean;
begin
  Result := lFlag_Cap.Checked;
end;

function TCdMunicipios.GetPkCity: Integer;
begin
  Result := Pk;
end;

function TCdMunicipios.GetRegions: Integer;
begin
  Result := 0;
  with eFk_Cargas_Regioes do
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
end;

function TCdMunicipios.GetRegsCount: Integer;
begin
  Result := vtPrinters.RootNodeCount;
end;

procedure TCdMunicipios.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    ListLoaded := True;
    eFk_Cargas_Regioes.Items.AddStrings(dmSysCad.LoadRegions(False));
    LoadPrinters(False);
  end;
end;

procedure TCdMunicipios.LoadPrinters(AGetUpdateData: Boolean);
var
  Node: PVirtualNode;
  Data: PCityTax;
begin
  ClearPrinters;
  with dmSysCad, vtPrinters do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    if (AGetUpdateData) then
    begin
      qrSqlAux.SQL.Add(SqlPrinterTaxes);
      qrSqlAux.ParamByName('FkPaises').AsInteger     := FkCountry;
      qrSqlAux.ParamByName('FkEstados').AsString     := FkState;
      qrSqlAux.ParamByName('FkMunicipios').AsInteger := Pk;
    end
    else
      qrSqlAux.SQL.Add(SqlSupportedPrinters);
    vtPrinters.BeginUpdate;
    try
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.Eof) do
      begin
        Node := AddChild(nil);
        if (Node <> nil) then
        begin
          Data := GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.PkSportedPrinter := qrSqlAux.FieldByName('PK_SUPORTED_PRINTERS').AsInteger;
            Data^.DscPrinter       := qrSqlAux.FieldByName('DSC_IMP').AsString;
            Data^.CodAlqt          := qrSqlAux.FieldByName('COD_ISS_ECF').AsInteger;
          end;
        end;
        qrSqlAux.Next;
      end;
    finally
      vtPrinters.EndUpdate;
      if qrSqlAux.Active then qrSqlAux.Close;
    end;
  end;
end;

procedure TCdMunicipios.MoveDataToControls;
var
  Data: TCity;
  aKeys: TLocalKeys;
begin
  Loading := True;
  try
    aKeys.PkCountry    := FkCountry;
    aKeys.PkState      := FkState;
    aKeys.PkCity       := Pk;
    dmSysCad.LocalKeys := aKeys;
    Data               := dmSysCad.City[Pk];
    PkCity             := Data.PkCity;
    CepCity            := Data.CepMun;
    AlqtIss            := Data.AlqtIss;
    FkRegions          := Data.FkRegions;
    FlagCap            := Data.FlagCap;
    FkCountry          := Data.FkState.FkCountry.PKCountry;
    FkState            := Data.FkState.PkState;
    DscCity            := Data.DscMun;
    if (Pk > 0) then
      LoadPrinters(True)
    else
      LoadPrinters(False);
  finally
    Loading := False;
  end;
end;

procedure TCdMunicipios.SaveIntoDB;
var
  Data: TCity;
  aRow: TDataRow;
begin
  Data := TCity.Create;
  aRow := TDataRow.Create(nil);
  try
    Data.PkCity                      := PkCity;
    Data.CepMun                      := CepCity;
    Data.AlqtIss                     := AlqtIss;
    Data.FkRegions                   := FkRegions;
    Data.FlagCap                     := FlagCap;
    Data.FkState.FkCountry.PKCountry := FkCountry;
    Data.FkState.PkState             := FkState;
    Data.DscMun                      := DscCity;
    dmSysCad.City[Ord(ScrState)]     := Data;
    SavePrinters;
    aRow.AddAs('PK', Data.PkCity, ftInteger, SizeOf(Integer));
    aRow.AddAs('DSC', Data.DscMun, ftString, 51);
    if Assigned(OnUpdateRow) then
      OnUpdateRow(Self, aRow);
    Pk := Data.PkCity;
  finally
    FreeAndNil(Data);
    FreeAndNil(Data);
  end;
end;

procedure TCdMunicipios.SavePrinters;
var
  i: Integer;
begin
  for i := 0 to RegsCount - 1 do
  begin
    if FkCityTaxes[i].CodAlqt > 0 then
      dmSysCad.CitTaxes[Ord(ScrState)] := FkCityTaxes[i];
  end;
end;

procedure TCdMunicipios.SetAlqtIss(const Value: Double);
begin
  eAlq_Iss.Value := Value;
end;

procedure TCdMunicipios.SetCepCity(const Value: Integer);
begin
  eCep_Mun.AsInteger := Value;
end;

procedure TCdMunicipios.SetDscCity(const Value: string);
begin
  eDsc_Mun.Text := Value;
end;

procedure TCdMunicipios.SetFlagCap(const Value: Boolean);
begin
  lFlag_Cap.Checked := Value;
end;

procedure TCdMunicipios.SetPkCity(const Value: Integer);
begin
  ePk_Municipios.Text := IntToStr(Value);
end;

procedure TCdMunicipios.SetRegions(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Cargas_Regioes do
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

procedure TCdMunicipios.vtPrintersGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PCityTax;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) then exit;
  case Column of
    0: CellText := Data^.DscPrinter;
    1: CellText := IntToStr(Data^.CodAlqt);
  end;
end;

procedure TCdMunicipios.vtPrintersNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PCityTax;
  S   : string;
  procedure DisplayColumnWarning;
  var
    R: TRect;
  begin
    R := Sender.GetDisplayRect(Node, Column, False);
    R.BottomRight.Y := R.BottomRight.Y + (ClientHeight - Sender.Height -
                       Integer(TVirtualStringTree(Sender).DefaultNodeHeight));
    R.BottomRight.X := R.BottomRight.X + ((R.TopLeft.X - R.BottomRight.X) div 2);
    Dados.DisplayHint(Self, R.BottomRight, S);
  end;
begin
  if (Node = nil) or (Column < 1) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) then exit;
  if (StrToIntDef(NewText, -1) < 0) or (StrToIntDef(NewText, -1) > 99) then
  begin
    S := 'O valor neste campo deve ser um código entre 01 e 99';
    DisplayColumnWarning;
    exit;
  end;
  Data^.CodAlqt := StrToInt(NewText);
  if (ScrState in SCROLL_MODE) then
    ScrState := dbmEdit;
end;

procedure TCdMunicipios.vtPrintersEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  Allowed := (Column = 1);
end;

procedure TCdMunicipios.sbNewRegionClick(Sender: TObject);
var
  aForm: TCdRegions;
  aPk  : Integer;
begin
  aForm := TCdRegions.Create(Application);
  try
    aForm.ShowModal;
    aPk := aForm.Pk;
  finally
    FreeAndNil(aForm);
  end;
  ReleaseRegions;
  ListLoaded := False;
  LoadDefaults;
  if (aPk > 0) then
    FkRegions := aPk;
end;

procedure TCdMunicipios.ReleaseRegions;
begin
  eFk_Cargas_Regioes.Items.Clear;
end;

procedure TCdMunicipios.FormDestroy(Sender: TObject);
begin
  ReleaseRegions;
  inherited;
end;

end.
