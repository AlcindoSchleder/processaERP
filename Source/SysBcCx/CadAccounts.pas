unit CadAccounts;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 03/01/2006 - DD/MM/YYYY                                    *}
{* Modified : 09/11/2008 - DD/MM/YYYY                                    *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : (alcindo@sistemaprocessa.com.br)                           *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CurrEdit, Mask, ToolEdit, StdCtrls, VirtualTrees, ComCtrls, ToolWin,
  ExtCtrls, Buttons, CadMultiModel, CadListModel, GridRow, DB, ProcType;

type
  TScreenForms  = (sfTypeAccounts, sfBanks, sfAccounts);

  TCdTypeAccounts = class(TfrmMultiModel)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure SetActiveRow(Index: Integer; const Value: TDataRow); override;
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure LoadList(Sender: TObject);
    procedure LoadPages(Sender: TObject);
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
    function  AddDataNode(ANode: PVirtualNode; ADataSet: TDataSet;
                var AData: PGridData): PVirtualNode; override;
  public
    { Public declarations }
  published
    { published declaretions }
    procedure UpdateRecord(Sender: TObject; Row: TDataRow);
//    property  ActiveRow;
    property  PageIndex;
    property  CanInsertNode;
    property  CheckRecord;
    property  Debug;
    property  FocusedRow;
    property  FocusedLevel;
    property  HasFolders;
    property  ItemImgNrmIdx;
    property  ItemImgSelIdx;
    property  ListLoaded;
    property  Loading;
    property  Pages;
    property  Pk;
    property  PkAux;
    property  RowModel;
    property  ScrState;
    property  SearchCol;
    property  SearchField;
    property  OnCancel;
    property  OnChangePK;
    property  OnChangeState;
    property  OnCheckRecord;
    property  OnInsert;
    property  OnInternalState;
    property  OnLoadPages;
    property  OnLoadList;
    property  OnUpdateRow;
  end;

var
  CdTypeAccounts: TCdTypeAccounts;

implementation

uses mSysBcCx, ArqSqlBcCx, Dado, TSysBcCx, CadTAcc, CadBank, CadAcc, TSysManAux;

{$R *.dfm}

{ TCdLancamentos }

const
  FORMS_CAPTIONS     : array [TScreenForms] of string      =
    ('Tabela Tipos de Contas', 'Tabela Bancos e Agências', 'Tabela de Contas/Caixas');

function TCdTypeAccounts.AddDataNode(ANode: PVirtualNode;
  ADataSet: TDataSet; var AData: PGridData): PVirtualNode;
begin
  Result := inherited AddDataNode(ANode, ADataSet, AData);
  if (AData <> nil) then
    AData^.NodeType := tnData;
end;

procedure TCdTypeAccounts.ClearControls;
begin
  inherited;
end;

procedure TCdTypeAccounts.LoadDefaults;
begin
  inherited;
end;

procedure TCdTypeAccounts.LoadList(Sender: TObject);
var
  PkTAcc,
  PkBank  : Integer;
  PkAgency,
  CodCta  : string;
  aTANode ,
  aBANode ,
  aAGNode ,
  aACNode : PVirtualNode;
begin
  PkTAcc   := 0;
  PkBank   := 0;
  PkAgency := '';
  CodCta   := '';
  aTANode  := nil;
  aBANode  := nil;
//  aAGNode  := nil;
  aACNode  := nil;
  inherited;
  with dmSysBcCx.qrSqlAux do
  begin
    if (Active) then Close;
    SQL.Clear;
    SQL.Add(SqlSelectAcc1);
    SQL.Add(SqlSelectAcc2);
    Dados.StartTransaction(dmSysBcCx.qrSqlAux);
    try
      ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      if (not Active) then Open;
      RowModel := TDataRow.CreateFromDataSet(Self, dmSysBcCx.qrSqlAux, False);
      while (not Eof) do
      begin
        if (PkTAcc <> FieldByName('PK_TIPO_CONTAS').AsInteger) then
          aTANode := AddDataNode(aTANode, dmSysBcCx.qrSqlAux);
        if (FieldByName('FLAG_TCTA').AsInteger = Ord(atBank)) then
        begin
          if (PkBank <> FieldByName('PK_BANCOS').AsInteger) and (aTANode <> nil) then
            aBANode := AddDataNode(aTANode, dmSysBcCx.qrSqlAux);
          if (PkAgency <> FieldByName('PK_AGENCIAS').AsString) and (aBANode <> nil) then
          begin
            aAGNode := AddDataNode(aBANode, dmSysBcCx.qrSqlAux);
            aACNode := aAGNode;
          end;
        end
        else
          aACNode := aTANode;
        if (CodCta <> FieldByName('COD_CTA').AsString) and (aACNode <> nil) then
          AddDataNode(aACNode, dmSysBcCx.qrSqlAux);
        PkTAcc   := FieldByName('PK_TIPO_CONTAS').AsInteger;
        PkBank   := FieldByName('PK_BANCOS').AsInteger;
        PkAgency := FieldByName('PK_AGENCIAS').AsString;
        CodCta   := FieldByName('COD_CTA').AsString;
        Next;
      end;
    finally
      if (Active) then Close;
      Dados.CommitTransaction(dmSysBcCx.qrSqlAux);
    end;
  end;
end;

procedure TCdTypeAccounts.MoveDataToControls;
begin
  inherited;
end;

procedure TCdTypeAccounts.SaveIntoDB;
begin
  inherited;
end;

procedure TCdTypeAccounts.SetActiveRow(Index: Integer; const Value: TDataRow);
begin
  inherited;
  if (Value = nil) then exit;
  case TScreenForms(Index) of
    sfTypeAccounts:
      with TCdTypeAccount(Pages.ActiveForm) do
        Pk := Value.FieldByName['PK_TIPO_CONTAS'].AsInteger;
    sfBanks       :
      with TCdBank(Pages.ActiveForm) do
        Pk := Value.FieldByName['PK_BANCOS'].AsInteger;
    sfAccounts    :
      with TCdAccount(Pages.ActiveForm) do
      begin
        FkTypeAccount := Value.FieldByName['PK_TIPO_CONTAS'].AsInteger;
        Pk            := Value.FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger;
      end;
  end;
end;

procedure TCdTypeAccounts.FormCreate(Sender: TObject);
begin
  OnLoadList  := LoadList;
  OnLoadPages := LoadPages;
  Debug       := True;
  inherited;
end;

procedure TCdTypeAccounts.UpdateRecord(Sender: TObject; Row: TDataRow);
begin
  with ActiveRow[Pages.ItemIndex] do
  begin
    FieldByName['TYPE_DATA'].AsInteger            := Pages.ItemIndex;
    case TScreenForms(Pages.Items[Pages.ItemIndex].TypeData) of
      sfTypeAccounts:
        begin
          FieldByName['FK_TIPO_CONTAS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_TCTA'].AsString        := Row.FieldByName['DSC'].AsString;
        end;
      sfBanks       :
        begin
          FieldByName['PK_BANKS'].AsInteger := Row.FieldByName['PK'].AsInteger;
          FieldByName['DSC_BCO'].AsString   := Row.FieldByName['DSC'].AsString;
        end;
      sfAccounts    :
        begin
          FieldByName['FK_EMPRESAS'].AsInteger          := Dados.PkCompany;
          FieldByName['FK_TIPO_CONTAS'].AsInteger       := Row.FieldByName['FK_TIPO_CONTAS'].AsInteger;
          FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger := Row.FieldByName['FK_FINANCEIRO_CONTAS'].AsInteger;
          FieldByName['DSC_CTA'].AsString               := Row.FieldByName['DSC'].AsString;
        end;
    end;
  end;
end;

procedure TCdTypeAccounts.LoadPages(Sender: TObject);
var
  i: TScreenForms;
const
  FORMS_OF_PAGES     : array [TScreenForms] of TPageClass =
    (TCdTypeAccount, TCdBank, TCdAccount);
  FORMS_NAMES        : array [TScreenForms] of string      =
    ('tsTypeAccounts', 'tsBanks', 'tsAccounts');
  FORMS_IMAGES_SEL   : array [TScreenForms] of Integer     =
    (11, 16, 61);
  FORMS_IMAGES_NORMAL: array [TScreenForms] of Integer     =
    (19, 83, 37);
begin
  if (Debug) then
    ShowMessage('Start LoadPages');
  for i := Low(TScreenForms) to High(TScreenForms) do
  begin
    with Pages.Add do
    begin
      if (Debug) then
        ShowMessage('Creating Page ' + FORMS_CAPTIONS[i] + ' with index ' + IntToStr(Ord(i)));
      DisplayImage  := FORMS_IMAGES_NORMAL[i];
      FormName      := FORMS_NAMES[i];
      PageCaption   := FORMS_CAPTIONS[i];
      PageControl   := pgMain;
      SelectedImage := FORMS_IMAGES_SEL[i];
      FormClass     := FORMS_OF_PAGES[i];
    end;
  end;
end;

initialization
  RegisterClass(TCdTypeAccounts);

end.
