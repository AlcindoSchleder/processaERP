unit CadEmpr;

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
  Dialogs, CadListModel, ExtCtrls, StdCtrls, Buttons, ToolEdit, CurrEdit, Mask,
  VirtualTrees, ComCtrls, ToolWin, TSysCadAux, ProcUtils;

type
  TCdEmpresa = class(TfrmModelList)
    pgControl: TPageControl;
    tsCompany: TTabSheet;
    tsParams: TTabSheet;
    pPanel: TPanel;
    eLogo_Emp: TImage;
    lPk_Empresas: TStaticText;
    ePk_Empresas: TCurrencyEdit;
    eCnpj_Emp: TMaskEdit;
    lCnpj_Emp: TStaticText;
    lInscr_Est: TStaticText;
    eInscr_Est: TMaskEdit;
    eRaz_Soc: TEdit;
    lRaz_Soc: TStaticText;
    lNom_Fan: TStaticText;
    eNom_Fan: TEdit;
    eFk_Paises: TComboBox;
    lFk_Paises: TStaticText;
    lFk_Estados: TStaticText;
    eFk_Estados: TComboBox;
    eFk_Municipios: TComboBox;
    lFk_Municipios: TStaticText;
    lEnd_Emp: TStaticText;
    eEnd_Emp: TEdit;
    eCmp_Emp: TEdit;
    lCmp_Emp: TStaticText;
    lCep_Emp: TStaticText;
    eCep_Emp: TCurrencyEdit;
    lCod_Atv: TStaticText;
    eCod_Atv: TEdit;
    eFon_Cmcl: TMaskEdit;
    lFon_Cmcl: TStaticText;
    lFon_Fax: TStaticText;
    eFon_Fax: TMaskEdit;
    lTip_Emp: TRadioGroup;
    sbCep: TSpeedButton;
    eNum_End: TCurrencyEdit;
    procedure eFk_PaisesSelect(Sender: TObject);
    procedure eFk_EstadosSelect(Sender: TObject);
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure eLogo_EmpDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure pgControlChange(Sender: TObject);
  private
    { Private declarations }
    function  GetCepEmp: Integer;
    function  GetCmpEmp: string;
    function  GetCnpjEmp: string;
    function  GetCodAtv: string;
    function  GetEndEmp: string;
    function  GetFkCity: Integer;
    function  GetFkCountry: Integer;
    function  GetFkState: string;
    function  GetFonCmcl: string;
    function  GetFonFax: string;
    function  GetInscrEst: string;
    function  GetLogoEmp: TGraphic;
    function  GetNomFan: string;
    function  GetNumEnd: Integer;
    function  GetPkCompany: Integer;
    function  GetRazSoc: string;
    function  GetTipEmp: Integer;
    procedure SetCepEmp(const Value: Integer);
    procedure SetCmpEmp(const Value: string);
    procedure SetCodAtv(const Value: string);
    procedure SetEndEmp(const Value: string);
    procedure SetFkCity(const Value: Integer);
    procedure SetFkCountry(const Value: Integer);
    procedure SetFkState(const Value: string);
    procedure SetFonCmcl(const Value: string);
    procedure SetFonFax(const Value: string);
    procedure SetInscrEst(const Value: string);
    procedure SetLogoEmp(const Value: TGraphic);
    procedure SetNomFan(const Value: string);
    procedure SetNumEnd(const Value: Integer);
    procedure SetPkCompany(const Value: Integer);
    procedure SetRazSoc(const Value: string);
    procedure SetTipEmp(const Value: Integer);
    procedure SetCnpjEmp(const Value: string);
    procedure LoadCities(AIdx: Integer);
    procedure LoadStates(AIdx: Integer);
  protected
    { Protected declarations }
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    procedure ChangeState(Sender: TObject; AState: TDBMode;
                AErrorCode: Integer = 0; AMsg: string = '');
  public
    { Public declarations }
    property PkCompany: Integer  read GetPkCompany write SetPkCompany;
    property CnpjEmp  : string   read GetCnpjEmp   write SetCnpjEmp;
    property InscrEst : string   read GetInscrEst  write SetInscrEst;
    property RazSoc   : string   read GetRazSoc    write SetRazSoc;
    property NomFan   : string   read GetNomFan    write SetNomFan;
    property FkCountry: Integer  read GetFkCountry write SetFkCountry;
    property FkState  : string   read GetFkState   write SetFkState;
    property FkCity   : Integer  read GetFkCity    write SetFkCity;
    property CepEmp   : Integer  read GetCepEmp    write SetCepEmp;
    property EndEmp   : string   read GetEndEmp    write SetEndEmp;
    property NumEnd   : Integer  read GetNumEnd    write SetNumEnd;
    property CmpEmp   : string   read GetCmpEmp    write SetCmpEmp;
    property CodAtv   : string   read GetCodAtv    write SetCodAtv;
    property FonCmcl  : string   read GetFonCmcl   write SetFonCmcl;
    property FonFax   : string   read GetFonFax    write SetFonFax;
    property TipEmp   : Integer  read GetTipEmp    write SetTipEmp;
    property LogoEmp  : TGraphic read GetLogoEmp   write SetLogoEmp;
    property OnListLoad;
  end;

var
  CdEmpresa: TCdEmpresa;

implementation

uses Dado, mSysMan, ProcType, Funcoes, GridRow, FuncoesDB, DB, CadParEmpr,
  ProcIE;

{$R *.dfm}

{ TfrmModelList1 }

procedure TCdEmpresa.ClearControls;
begin
  Loading := True;
  try
    PkCompany := 0;
    CnpjEmp   := '';
    InscrEst  := '';
    RazSoc    := '';
    NomFan    := '';
    FkCountry := 0 ;
    FkState   := '';
    FkCity    := 0;
    CepEmp    := 0;
    EndEmp    := '';
    NumEnd    := 0;
    CmpEmp    := '';
    CodAtv    := '';
    FonCmcl   := '';
    FonFax    := '';
    TipEmp    := 0;
    LogoEmp   := nil;
  finally
    Loading := False;
  end
end;

function TCdEmpresa.GetCepEmp: Integer;
begin
  Result := eCep_Emp.AsInteger;
end;

function TCdEmpresa.GetCmpEmp: string;
begin
  Result := eCmp_Emp.Text;
end;

function TCdEmpresa.GetCnpjEmp: string;
begin
  Result := eCnpj_Emp.Text;
end;

function TCdEmpresa.GetCodAtv: string;
begin
  Result := eCod_Atv.Text;
end;

function TCdEmpresa.GetEndEmp: string;
begin
  Result := eEnd_Emp.Text;
end;

function TCdEmpresa.GetFkCity: Integer;
begin
  Result := 0;
  with eFk_Municipios do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TCity(Items.Objects[ItemIndex]).PkCity;
  end;
end;

function TCdEmpresa.GetFkCountry: Integer;
begin
  Result := 0;
  with eFk_Paises do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TCountry(Items.Objects[ItemIndex]).PKCountry;
  end;
end;

function TCdEmpresa.GetFkState: string;
begin
  Result := '';
  with eFk_Estados do
  begin
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TState(Items.Objects[ItemIndex]).PkState;
  end;
end;

function TCdEmpresa.GetFonCmcl: string;
begin
  Result := eFon_Cmcl.Text;
end;

function TCdEmpresa.GetFonFax: string;
begin
  Result := eFon_Fax.Text;
end;

function TCdEmpresa.GetInscrEst: string;
begin
  Result := eInscr_Est.Text;
end;

function TCdEmpresa.GetLogoEmp: TGraphic;
begin
  Result := nil;
  if (eLogo_Emp.Picture.Graphic <> nil) then
    Result := eLogo_Emp.Picture.Graphic;
end;

function TCdEmpresa.GetNomFan: string;
begin
  Result := eNom_Fan.Text;
end;

function TCdEmpresa.GetNumEnd: Integer;
begin
  Result := eNum_End.AsInteger;
end;

function TCdEmpresa.GetPkCompany: Integer;
begin
  Result := ePk_Empresas.AsInteger;
end;

function TCdEmpresa.GetRazSoc: string;
begin
  Result := eRaz_Soc.Text;
end;

function TCdEmpresa.GetTipEmp: Integer;
begin
  Result := lTip_Emp.ItemIndex;
end;

procedure TCdEmpresa.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Paises.Items.AddStrings(dmSysMan.LoadCountries);
    ListLoaded := True;
  end;
end;

procedure TCdEmpresa.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
const
  SQL_COMPANIES = 'select PK_EMPRESAS, RAZ_SOC from EMPRESAS order by RAZ_SOC';
begin
  inherited;
  with dmSysMan do
  begin
    if Empresa.Active then Empresa.Close;
    Empresa.SQL.Clear;
    Empresa.SQL.Add(SQL_COMPANIES);
    if (not Empresa.Active) then Empresa.Open;
    if (RowModel = nil) then
      RowModel := TDataRow.CreateFromDataSet(nil, Empresa, False);
    try
      while (not Empresa.Eof) do
      begin
        Node := vtList.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtList.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level := 0;
            Data^.Node  := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, Empresa, True);
          end;
        end;
        Empresa.Next;
      end;
    finally
      if Empresa.Active then Empresa.Close;
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdEmpresa.MoveDataToControls;
const
  SQL_COMPANIES = 'select * from EMPRESAS where PK_EMPRESAS = :PkEmpresas';
begin
  with dmSysMan do
  begin
    if Empresa.Active then Empresa.Close;
    Empresa.SQL.Clear;
    Empresa.SQL.Add(SQL_COMPANIES);
    Loading := True;
    try
      Empresa.ParamByName('PkEmpresas').AsInteger := Pk;
      if (not Empresa.Active) then Empresa.Open;
      PkCompany := Empresa.FieldByName('PK_EMPRESAS').AsInteger;
      CnpjEmp   := Empresa.FieldByName('CNPJ_EMP').AsString;
      InscrEst  := Empresa.FieldByName('INSCR_EST').AsString;
      RazSoc    := Empresa.FieldByName('RAZ_SOC').AsString;
      NomFan    := Empresa.FieldByName('NOM_FAN').AsString;
      FkCountry := Empresa.FieldByName('FK_PAISES').AsInteger;
      FkState   := Empresa.FieldByName('FK_ESTADOS').AsString;
      FkCity    := Empresa.FieldByName('FK_MUNICIPIOS').AsInteger;
      CepEmp    := Empresa.FieldByName('CEP_EMP').AsInteger;
      EndEmp    := Empresa.FieldByName('END_EMP').AsString;
      NumEnd    := Empresa.FieldByName('NUM_END').AsInteger;
      CmpEmp    := Empresa.FieldByName('CMP_EMP').AsString;
      CodAtv    := Empresa.FieldByName('COD_ATV').AsString;
      FonCmcl   := Empresa.FieldByName('FON_CMCL').AsString;
      FonFax    := Empresa.FieldByName('FON_FAX').AsString;
      TipEmp    := Empresa.FieldByName('TIP_EMP').AsInteger;
      GetImage_FromStream(TBlobField(Empresa.FieldByName('LOGO_EMP')), eLogo_Emp);
    finally
      if Empresa.Active then Empresa.Close;
      Loading := False;
    end
  end;
end;

procedure TCdEmpresa.SaveIntoDB;
var
  aFld,
  aWhr: TStrings;
  M   : TStream;
begin
  aFld := TStringList.Create;
  aWhr := TStringList.Create;
  try
    if (PkCompany <> Pk) then
      aFld.Add('PK_EMPRESAS');
    aFld.Add('CNPJ_EMP');
    aFld.Add('INSCR_EST');
    aFld.Add('RAZ_SOC');
    aFld.Add('NOM_FAN');
    aFld.Add('FK_PAISES');
    aFld.Add('FK_ESTADOS');
    aFld.Add('FK_MUNICIPIOS');
    aFld.Add('CEP_EMP');
    aFld.Add('END_EMP');
    aFld.Add('NUM_END');
    aFld.Add('TIP_EMP');
    if (CmpEmp <> '') then
      aFld.Add('CMP_EMP');
    if (CodAtv <> '') then
      aFld.Add('COD_ATV');
    if (FonCmcl <> '') then
      aFld.Add('FON_CMCL');
    if (FonFax <> '') then
      aFld.Add('FON_FAX');
    if (LogoEmp <> nil) then
      aFld.Add('LOGO_EMP');
    if dmSysMan.Empresa.Active then dmSysMan.Empresa.Close;
    dmSysMan.Empresa.SQL.Clear;
    if (ScrState = dbmInsert) then
      dmSysMan.Empresa.SQL.AddStrings(GetInsertSQL(aFld, 'EMPRESAS'));
    if (ScrState = dbmEdit)   then
    begin
      aWhr.Add('PK_EMPRESAS');
      dmSysMan.Empresa.SQL.AddStrings(GetUpdateSQL(aFld, aWhr, 'EMPRESAS'));
    end;
  finally
    FreeAndNil(aWhr);
    FreeAndNil(aFld);
  end;
  with dmSysMan do
  begin
    Dados.StartTransaction(Empresa);
    try
      Empresa.ParamByName('PkEmpresas').AsInteger      := PkCompany;
      Empresa.ParamByName('CnpjEmp').AsString          := CnpjEmp;
      Empresa.ParamByName('InscrEst').AsString         := InscrEst;
      Empresa.ParamByName('RazSoc').AsString           := RazSoc;
      Empresa.ParamByName('NomFan').AsString           := NomFan;
      Empresa.ParamByName('FkPaises').AsInteger        := FkCountry;
      Empresa.ParamByName('FkEstados').AsString        := FkState;
      Empresa.ParamByName('FkMunicipios').AsInteger    := FkCity;
      Empresa.ParamByName('CepEmp').AsInteger          := CepEmp;
      Empresa.ParamByName('EndEmp').AsString           := EndEmp;
      Empresa.ParamByName('NumEnd').AsInteger          := NumEnd;
      Empresa.ParamByName('TipEmp').AsInteger          := TipEmp;
      if (Empresa.Params.FindParam('OldPkEmpresas') <> nil) then
        Empresa.ParamByName('OldPkEmpresas').AsInteger := Pk;
      if (Empresa.Params.FindParam('CmpEmp') <> nil) then
        Empresa.ParamByName('CmpEmp').AsString         := CmpEmp;
      if (Empresa.Params.FindParam('CodAtv') <> nil) then
        Empresa.ParamByName('CodAtv').AsString         := CodAtv;
      if (Empresa.Params.FindParam('FonCmcl') <> nil) then
        Empresa.ParamByName('FonCmcl').AsString        := FonCmcl;
      if (Empresa.Params.FindParam('FonFax') <> nil) then
        Empresa.ParamByName('FonFax').AsString         := FonFax;
      if (Empresa.Params.FindParam('LogoEmp') <> nil) and
         (eLogo_Emp.Picture.Graphic <> nil) then
      begin
        M := TMemoryStream.Create;
        try
          M.Position := 0;
          eLogo_Emp.Picture.Graphic.SaveToStream(M);
          M.Position := 0;
          Empresa.ParamByName('LogoEmp').LoadFromStream(M, ftBlob);
        finally
          FreeAndNil(M);
        end;
      end;
      Empresa.ExecSql;
      if Empresa.Active then Empresa.Close;
      Dados.CommitTransaction(Empresa);
    except on E:Exception do
      begin
        if Empresa.Active then Empresa.Close;
        Dados.RollbackTransaction(Empresa);
        raise Exception.Create('SaveRecord: Não posso salvar o registro ' + NL +
          E.Message + NL + Empresa.SQL.Text);
      end;
    end;
  end;
end;

procedure TCdEmpresa.SetCepEmp(const Value: Integer);
begin
  eCep_Emp.AsInteger := Value;
end;

procedure TCdEmpresa.SetCmpEmp(const Value: string);
begin
  eCmp_Emp.Text := Value;
end;

procedure TCdEmpresa.SetCodAtv(const Value: string);
begin
  eCod_Atv.Text := Value;
end;

procedure TCdEmpresa.SetEndEmp(const Value: string);
begin
  eEnd_Emp.Text := Value;
end;

procedure TCdEmpresa.SetFkCity(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Municipios do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count -1 do
      if (Items.Objects[i] <> nil) and
         (TCity(Items.Objects[i]).PkCity = Value) then
      begin
        ItemIndex := i;
        break;
      end;
  end;
end;

procedure TCdEmpresa.SetFkCountry(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Paises do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count -1 do
      if (Items.Objects[i] <> nil) and
         (TCountry(Items.Objects[i]).PKCountry = Value) then
      begin
        ItemIndex := i;
        LoadStates(i);
        break;
      end;
  end;
end;

procedure TCdEmpresa.SetFkState(const Value: string);
var
  i: Integer;
begin
  with eFk_Estados do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count -1 do
      if (Items.Objects[i] <> nil) and
         (TState(Items.Objects[i]).PkState = Value) then
      begin
        ItemIndex := i;
        eInscr_Est.EditMask := Mascara_Inscricao(TState(Items.Objects[i]).PkState);
        LoadCities(i);
        break;
      end;
  end;
end;

procedure TCdEmpresa.SetFonCmcl(const Value: string);
begin
  eFon_Cmcl.Text := Value;
end;

procedure TCdEmpresa.SetFonFax(const Value: string);
begin
  eFon_Fax.Text := Value;
end;

procedure TCdEmpresa.SetInscrEst(const Value: string);
begin
  eInscr_Est.Text := Value;
end;

procedure TCdEmpresa.SetLogoEmp(const Value: TGraphic);
begin
  eLogo_Emp.Picture.Graphic := nil;
  if (Value <> nil) then
    eLogo_Emp.Picture.Assign(Value);
end;

procedure TCdEmpresa.SetNomFan(const Value: string);
begin
  eNom_Fan.Text := Value;
end;

procedure TCdEmpresa.SetNumEnd(const Value: Integer);
begin
  eNum_End.AsInteger := Value;
end;

procedure TCdEmpresa.SetPkCompany(const Value: Integer);
begin
  ePk_Empresas.AsInteger := Value;
end;

procedure TCdEmpresa.SetRazSoc(const Value: string);
begin
  eRaz_Soc.Text := Value;
end;

procedure TCdEmpresa.SetTipEmp(const Value: Integer);
begin
  lTip_Emp.ItemIndex := Value;
end;

procedure TCdEmpresa.eFk_PaisesSelect(Sender: TObject);
var
  aIdx: Integer;
begin
  ChangeGlobal(Sender);
  aIdx := eFk_Paises.ItemIndex;
  if (aIdx > -1) and (eFk_Paises.Items.Objects[aIdx] <> nil) then
    LoadStates(aIdx);
end;

procedure TCdEmpresa.eFk_EstadosSelect(Sender: TObject);
var
  aIdx: Integer;
begin
  ChangeGlobal(Sender);
  aIdx := eFk_Estados.ItemIndex;
  if (aIdx > -1) and (eFk_Estados.Items.Objects[aIdx] <> nil) then
  begin
    LoadCities(aIdx);
    eInscr_Est.EditMask := Mascara_Inscricao(FkState);
  end;
end;

procedure TCdEmpresa.SetCnpjEmp(const Value: string);
begin
  eCnpj_Emp.Text := Value;
end;

function  TCdEmpresa.CheckRecord(const OldState, NewState: TDbMode): Boolean;
var
  S: string;
  C: TControl;
begin
  Result := True;
  S := '';
  C := nil;
  if (not VerCgc(CnpjEmp)) then
  begin
    S := 'Atenção: Campo C.N.P.J. da Empresa deve conter um valor válido';
    C := eCnpj_Emp;
  end;
  if (not VerificaInscricao(InscrEst, FkState)) then
  begin
    S := 'Atenção: Campo Inscrição Estadual da Empresa deve conter um ' + NL +
         'valor válido para a UF ' + FkState + '/' + InscrEst;
    C := eInscr_Est;
  end;
  if (RazSoc = '') then
  begin
    S := 'Atenção: Campo Razão Social deve conter um valor';
    C := eRaz_Soc;
  end;
  if (NomFan = '') then
  begin
    S := 'Atenção: Campo Nome Fantasia deve conter um valor';
    C := eNom_Fan;
  end;
  if (FkCountry = 0) then
  begin
    S := 'Atenção: Campo País deve conter um valor';
    C := eFk_Paises;
  end;
  if (FkState = '') then
  begin
    S := 'Atenção: Campo Estado deve conter um valor';
    C := eFk_Estados;
  end;
  if (FkCity = 0) then
  begin
    S := 'Atenção: Campo Município deve conter um valor';
    C := eFk_Municipios;
  end;
  if (CepEmp = 0) then
  begin
    S := 'Atenção: Campo C.E.P. deve conter um valor';
    C := eCep_Emp;
  end;
  if (EndEmp = '') then
  begin
    S := 'Atenção: Campo Endereço da Empresa deve conter um valor';
    C := eEnd_Emp;
  end;
  if (NumEnd = 0) then
  begin
    S := 'Atenção: Campo Número do Endereço deve conter um valor';
    C := eNum_End;
  end;
  if (TipEmp < 0) or (TipEmp > 2) then
  begin
    S := 'Atenção: Campo Tipo da Empresa deve conter um valor válido';
    C := lTip_Emp;
  end;
  if (S <> '') then
  begin
    Result := False;
    if (C = nil) then C := Self;
    Dados.DisplayHint(C, S);
  end;
end;

procedure TCdEmpresa.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data <> nil) and (Data^.DataRow <> nil) then
  CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
end;

procedure TCdEmpresa.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data <> nil) and (Data^.DataRow <> nil) then
  Pk := Data^.DataRow.FieldByName['PK_EMPRESAS'].AsInteger;
  if Assigned(CdParametros) then
    CdParametros.Pk := Pk;
end;

procedure TCdEmpresa.eLogo_EmpDblClick(Sender: TObject);
var
  M: TStream;
begin
  M := TMemoryStream.Create;
  try
    SelectImageFromFile(M, eLogo_Emp);
    if (M.Size > 0) then
    begin
      M.Position := 0;
      eLogo_Emp.Picture.Graphic.LoadFromStream(M);
      ChangeGlobal(Sender);
    end;
  finally
    FreeAndNil(M);
  end;
end;

procedure TCdEmpresa.LoadCities(AIdx: Integer);
begin
  ReleaseCombos(eFk_Municipios, toObject);
  with eFk_Municipios do
    Items.AddStrings(dmSysMan.LoadCities(TState(eFk_Estados.Items.Objects[AIdx])));
end;

procedure TCdEmpresa.LoadStates(AIdx: Integer);
begin
  ReleaseCombos(eFk_Estados, toObject);
  with eFk_Estados do
    Items.AddStrings(dmSysMan.LoadStates(TCountry(eFk_Paises.Items.Objects[AIdx])));
end;

procedure TCdEmpresa.FormCreate(Sender: TObject);
begin
  pgControl.Images := Dados.Image16;
  OnCheckRecord    := CheckRecord;
  OnListLoad       := LoadList;
  inherited;
end;

procedure TCdEmpresa.FormDestroy(Sender: TObject);
begin
  if Assigned(CdParametros) then
    CdParametros.Free;
  CdParametros := nil;
end;

procedure TCdEmpresa.ChangeState(Sender: TObject; AState: TDBMode;
  AErrorCode: Integer = 0; AMsg: string = '');
begin
  if (AState in UPDATE_MODE) and (ScrState in UPDATE_MODE) then exit;
  if (Sender is TCdParametros) and (AState in UPDATE_MODE) then
    if (AState = dbmInsert) and (Pk > 0) then
      ScrState := dbmEdit
    else
      ScrState := AState;
end;

procedure TCdEmpresa.tbSaveClick(Sender: TObject);
begin
  if (Assigned(CdParametros)) and (CdParametros.ScrState in UPDATE_MODE) then
  begin
    CdParametros.ScrState := dbmPost;
    CdParametros.ScrState := dbmBrowse;
  end;
  inherited;
end;

procedure TCdEmpresa.pgControlChange(Sender: TObject);
begin
  CanInsertNode := (pgControl.ActivePageIndex = 0);
  if (not Assigned(CdParametros)) then
  begin
    CdParametros               := TCdParametros.Create(Application);
    CdParametros.Parent        := tsParams;
    CdParametros.BorderStyle   := bsNone;
    CdParametros.Align         := alClient;
    CdParametros.OnChangeState := ChangeState;
    CdParametros.Show;
  end;
  CdParametros.Pk := Pk;
end;

initialization
   Classes.RegisterClass(TCdEmpresa);

end.

