unit CadLocais;

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
  Dialogs, CadMultiModel, ComCtrls, VirtualTrees, ToolWin, ExtCtrls, CadModel,
  ProcType, GridRow, Menus, Math;

type
  TScreenForms = (ltCountry, ltState, ltCity, ltDistrict, ltAddress);

  TPagesClass = class of TfrmModel;

  TCdLocales  = class(TfrmMultiModel)
    pmMenu: TPopupMenu;
    pmCountry: TMenuItem;
    pmState: TMenuItem;
    pmCity: TMenuItem;
    pmDistrict: TMenuItem;
    pmAddress: TMenuItem;
    procedure vtListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vtListGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure pmInsertGeneral(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFkCity     : Integer;
    FFkCountry  : Integer;
    FFkDistrict : Integer;
    FFkState    : string;
    procedure LoadDataFromDataBase(AData: PGridData; AType: TScreenForms);
  protected
    { Protected declarations }
    procedure SetActiveRow(Index: Integer; const Value: TDataRow); override;
    procedure LoadList(Sender: TObject);
    procedure LoadPages(Sender: TObject);
    procedure UpdateRecord(Sender: TObject; Row: TDataRow);
    property  ActiveRow;
  public
    { Public declarations }
  end;

implementation

uses Dado, CadPais, CadMun, CadBai, CadUf, CadLoc, mSysCad, CadArqSql, DB,
  TSysCadAux, ProcUtils;

{$R *.dfm}

{ TCdLocales }

const
  FORMS_CAPTIONS     : array [TScreenForms] of string          =
    ('Cadastro de Paises', 'Cadastro de Estados', 'Cadastro de Municípios',
     'Cadastro de Bairros', 'Cadastro de Logradouros');

procedure TCdLocales.LoadDataFromDataBase(AData: PGridData;
  AType: TScreenForms);
var
  Data: PGridData;
  i   : TScreenForms;
const
  PK_FIELD_NAME: array [TScreenForms] of  string =
    ('PK_PAISES', 'PK_ESTADOS', 'PK_MUNICIPIOS', 'PK_BAIRROS', 'PK_LOGRADOUROS');
  FK_FIELD_NAME: array [TScreenForms] of  string =
    ('FK_PAISES', 'FK_ESTADOS', 'FK_MUNICIPIOS', 'FK_BAIRROS', 'FK_LOGRADOUROS');
  PK_PARAM_NAME: array [TScreenForms] of  string =
    ('PkPaises', 'PkEstados', 'PkMunicipios', 'PkBairros', 'PkLograduros');
  FK_PARAM_NAME: array [TScreenForms] of  string =
    ('FkPaises', 'FkEstados', 'FkMunicipios', 'FkBairros', 'FkLograduros');
  procedure MoveParams(AParam: string);
  begin
    with dmSysCad do
    begin
      if (AData^.DataRow.FindField[PK_FIELD_NAME[i]] <> nil) then
        qrSqlAux.ParamByName(AParam).AsString :=  AData^.DataRow.FieldByName[PK_FIELD_NAME[i]].AsString;
      if (AData^.DataRow.FindField[FK_FIELD_NAME[i]] <> nil) then
        qrSqlAux.ParamByName(AParam).AsString :=  AData^.DataRow.FieldByName[FK_FIELD_NAME[i]].AsString;
    end;
  end;
begin
  Data := nil;
  if (AType = ltAddress) or (AData = nil) or (AData^.DataRow = nil) then exit;
  with dmSysCad, AData^.DataRow do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    case AType of
      ltCountry : qrSqlAux.SQL.Add(SqlStates);
      ltState   : qrSqlAux.SQL.Add(SqlCities);
      ltCity    : qrSqlAux.SQL.Add(SqlBairros);
      ltDistrict: qrSqlAux.SQL.Add(SqlLogradouros);
    end;
    Dados.StartTransaction(qrSqlAux);
    try
      for i := ltCountry to ltAddress do // move params
      begin
        if (qrSqlAux.Params.FindParam(PK_PARAM_NAME[i]) <> nil) then
          MoveParams(PK_PARAM_NAME[i]);
        if (qrSqlAux.Params.FindParam(FK_PARAM_NAME[i]) <> nil) then
          MoveParams(FK_PARAM_NAME[i]);
      end;
      Inc(AType);
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while (not qrSqlAux.Eof) do
      begin
        AddDataNode(AData^.Node, qrSqlAux, Data);
        if (Data <> nil) then
        begin
          Data^.DataRow.AddAs('TYPE_DATA', Ord(AType), ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('DSC_TDATA', FORMS_CAPTIONS[AType], ftString, 31);
        end;
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
end;

procedure TCdLocales.LoadList(Sender: TObject);
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Node := nil;
  Data := nil;
  inherited;
  with dmSysCad do
  begin
    if (qrSqlAux.Active) then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlCountries);
    Dados.StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('FlagAtu').AsInteger := -1;
      if (not qrSqlAux.Active) then qrSqlAux.Open;
      while not qrSqlAux.Eof do
      begin
        AddDataNode(Node, qrSqlAux, Data);
        if (Data <> nil) then
        begin
          Data^.DataRow.AddAs('TYPE_DATA', Ord(ltCountry), ftInteger, SizeOf(Integer));
          Data^.DataRow.AddAs('DSC_TDATA', FORMS_CAPTIONS[ltCountry], ftString, 31);
        end;
        qrSqlAux.Next;
      end;
    finally
      if (qrSqlAux.Active) then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
    end;
  end;
  if (vtList.RootNodeCount > 0) then
  begin
    vtList.FocusedNode := vtList.GetFirst;
    vtList.Selected[vtList.FocusedNode] := True;
  end;
end;

procedure TCdLocales.LoadPages(Sender: TObject);
var
  i: TScreenForms;
const
  FORMS_OF_PAGES     : array [TScreenForms] of TPagesClass =
    (TCdPaises, TCdEstados, TCdMunicipios, TCdBairros, TCdLogradouros);
  FORMS_NAMES        : array [TScreenForms] of string          =
    ('tsCountries', 'tsStates', 'tsCities', 'ts', 'tsLocales');
  FORMS_IMAGES_SEL   : array [TScreenForms] of Integer     =
    (11, 16, 61, 34, 56);
  FORMS_IMAGES_NORMAL: array [TScreenForms] of Integer     =
    (19, 83, 37, 43, 65);
begin
  for i := Low(TScreenForms) to High(TScreenForms) do
  begin
    with Pages.Add do
    begin
      DisplayImage  := FORMS_IMAGES_NORMAL[i];
      FormName      := FORMS_NAMES[i];
      PageCaption   := FORMS_CAPTIONS[i];
      PageControl   := pgMain;
      SelectedImage := FORMS_IMAGES_SEL[i];
      FormClass     := FORMS_OF_PAGES[i];
    end;
  end;
end;

procedure TCdLocales.SetActiveRow(Index: Integer; const Value: TDataRow);
begin
  case TScreenForms(Index) of
    ltCountry : tbInsert.MenuItem := pmCountry;
    ltState   : tbInsert.MenuItem := pmState;
    ltCity    : tbInsert.MenuItem := pmCity;
    ltDistrict: tbInsert.MenuItem := pmDistrict;
    ltAddress : tbInsert.MenuItem := pmAddress;
  end;
  pmCountry.Visible  := (TScreenForms(Index) = ltCountry);
  pmState.Visible    := (TScreenForms(Index) in [ltCountry, ltState]);
  pmCity.Visible     := (TScreenForms(Index) in [ltState, ltCity]);
  pmDistrict.Visible := (TScreenForms(Index) in [ltCity, ltDistrict]);
  pmAddress.Visible  := (TScreenForms(Index) in [ltDistrict, ltAddress]);
  if (not pgMain.Pages[Index].TabVisible) then
    Pages.ItemIndex := Index;
  RowModel   := Value;
  case TScreenForms(Index) of
    ltCountry  :
      with TCdPaises(Pages.Items[Index].Form) do
      begin
        FFkCountry   := Value.FieldByName['PK_PAISES'].AsInteger;
        Pk           := Value.FieldByName['PK_PAISES'].AsInteger;
      end;
    ltState:
      with TCdEstados(Pages.Items[Index].Form) do
      begin
        FkCountry  := Value.FieldByName['FK_PAISES'].AsInteger;
        PkState    := Value.FieldByName['PK_ESTADOS'].AsString;
      end;
    ltCity:
      with TCdMunicipios(Pages.Items[Index].Form) do
      begin
        FFkCountry   := Value.FieldByName['FK_PAISES'].AsInteger;
        FFkState     := Value.FieldByName['FK_ESTADOS'].AsString;

        FkCountry    := Value.FieldByName['FK_PAISES'].AsInteger;
        FkState      := Value.FieldByName['FK_ESTADOS'].AsString;
        Pk           := Value.FieldByName['PK_MUNICIPIOS'].AsInteger;
      end;
    ltDistrict:
      with TCdBairros(Pages.Items[Index].Form) do
      begin
        FFkCountry   := Value.FieldByName['FK_PAISES'].AsInteger;
        FFkState     := Value.FieldByName['FK_ESTADOS'].AsString;
        FFkCity      := Value.FieldByName['FK_MUNICIPIOS'].AsInteger;

        FkCountry    := Value.FieldByName['FK_PAISES'].AsInteger;
        FkState      := Value.FieldByName['FK_ESTADOS'].AsString;
        FkCity       := Value.FieldByName['FK_MUNICIPIOS'].AsInteger;
        Pk           := Value.FieldByName['PK_BAIRROS'].AsInteger;
      end;
    ltAddress:
      with TCdLogradouros(Pages.Items[Index].Form) do
      begin
        FFkCountry   := Value.FieldByName['FK_PAISES'].AsInteger;
        FFkState     := Value.FieldByName['FK_ESTADOS'].AsString;
        FFkCity      := Value.FieldByName['FK_MUNICIPIOS'].AsInteger;
        FFkDistrict  := Value.FieldByName['FK_BAIRROS'].AsInteger;

        FkCountry    := Value.FieldByName['FK_PAISES'].AsInteger;
        FkState      := Value.FieldByName['FK_ESTADOS'].AsString;
        FkCity       := Value.FieldByName['FK_MUNICIPIOS'].AsInteger;
        FkDistrict   := Value.FieldByName['FK_BAIRROS'].AsInteger;
        Pk           := Value.FieldByName['PK_LOGRADOUROS'].AsInteger;
      end;
  end;
end;

procedure TCdLocales.UpdateRecord(Sender: TObject; Row: TDataRow);
begin
  with ActiveRow[Pages.ItemIndex] do
  begin
    FieldByName['DSC_TDATA'].AsString             := FORMS_CAPTIONS[TScreenForms(Pages.ItemIndex)];
    FieldByName['TYPE_DATA'].AsInteger            := Pages.ItemIndex;
    case TScreenForms(Pages.Items[Pages.ItemIndex].TypeData) of
      ltCountry :
        begin
          FieldByName['PK_PAISES'].AsInteger      := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_PAIS'].AsString        := Row.FieldByName['DSC'].AsString;
        end;
      ltState   :
        begin
          FieldByName['FK_PAISES'].AsInteger      := FFkCountry;
          FieldByName['PK_ESTADOS'].AsString      := Row.FieldByName['PK'].AsString;
          FieldByName['DSC_UF'].AsString          := Row.FieldByName['DSC'].AsString;
        end;
      ltCity    :
        begin
          FieldByName['FK_PAISES'].AsInteger      := FFkCountry;
          FieldByName['FK_ESTADOS'].AsString      := FFkState;
          FieldByName['PK_MUNICIPIOS'].AsInteger  := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_MUN'].AsString         := Row.FieldByName['DSC'].AsString;
        end;
      ltDistrict:
        begin
          FieldByName['FK_PAISES'].AsInteger      := FFkCountry;
          FieldByName['FK_ESTADOS'].AsString      := FFkState;
          FieldByName['FK_MUNICIPIOS'].AsInteger  := FFkCity;
          FieldByName['PK_BAIRROS'].AsInteger     := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_BAI'].AsString         := Row.FieldByName['DSC'].AsString;
        end;
      ltAddress :
        begin
          FieldByName['FK_PAISES'].AsInteger      := FFkCountry;
          FieldByName['FK_ESTADOS'].AsString      := FFkState;
          FieldByName['FK_MUNICIPIOS'].AsInteger  := FFkCity;
          FieldByName['FK_BAIRROS'].AsInteger     := FFkDistrict;
          FieldByName['PK_LOGRADOUROS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_LOG'].AsString         := Row.FieldByName['DSC'].AsString;
        end;
    end;
  end;
end;

procedure TCdLocales.vtListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: CellText := Data^.DataRow.FieldByName['DSC_PAIS'].AsString;
    1: CellText := Data^.DataRow.FieldByName['DSC_UF'].AsString;
    2: CellText := Data^.DataRow.FieldByName['DSC_MUN'].AsString;
    3: CellText := Data^.DataRow.FieldByName['DSC_BAI'].AsString;
    4: CellText := Data^.DataRow.FieldByName['DSC_LOC'].AsString;
  end;
end;

procedure TCdLocales.vtListFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data  : PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  case Sender.GetNodeLevel(Node) of
    0: SearchField := 'DSC_PAIS';
    1: SearchField := 'DSC_UF';
    2: SearchField := 'DSC_MUN';
    3: SearchField := 'DSC_BAI';
    4: SearchField := 'DSC_LOC';
  end;
  Pages.ItemIndex := Data^.DataRow.FieldByName['TYPE_DATA'].AsInteger;
  ActiveRow[Pages.ItemIndex] := Data^.DataRow;
  if (Sender.GetNodeLevel(Node) < 4) and (Sender.GetFirstChild(Node) = nil) then
    LoadDataFromDataBase(Data, TScreenForms(Pages.ItemIndex));
end;

procedure TCdLocales.vtListGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if (Node = nil) or
     ((Node = Sender.FocusedNode) and (ScrState in UPDATE_MODE)) then
    exit;
  case Sender.GetNodeLevel(Node) of
    0: ImageIndex := 61;
    1: ImageIndex := 22;
    2: ImageIndex := 19;
    3: ImageIndex := 26;
    4: ImageIndex := 56;
  end;
end;

procedure TCdLocales.pmInsertGeneral(Sender: TObject);
begin
  if (not (Sender is TMenuItem)) then exit;
  case TScreenForms(TMenuItem(Sender).Tag) of
    ltCountry : ;
    ltState   : ;
    ltCity    : ;
    ltDistrict: ;
    ltAddress : ;
  end;
end;

procedure TCdLocales.FormCreate(Sender: TObject);
begin
  OnLoadList  := LoadList;
  OnLoadPages := LoadPages;
  inherited;
end;

initialization
  RegisterClass(TCdLocales);

end.
