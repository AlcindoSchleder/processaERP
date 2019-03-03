unit Sobre;

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

uses SysUtils, Classes, ProcType,
  {$IFNDEF LINUX}
    Forms, Controls, StdCtrls, ExtCtrls, ComCtrls, jpeg, Buttons
  {$ELSE}
    QForms, QControls, QStdCtrls, QExtCtrls, QComCtrls
  {$ENDIF};

type
  TfrmAboutProcessa = class(TForm)
    mDscInfo: TMemo;
    lvUsers : TListView;
    imHeader: TImage;
    imFooter: TImage;
    pUsers: TPanel;
    stUsers: TStaticText;
    sbConn: TSpeedButton;
    sbAllUsers: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbConnClick(Sender: TObject);
    procedure sbAllUsersClick(Sender: TObject);
  private
    { Private declarations }
    FEggKey: string;
    procedure AddvtUsers(AList: TStrings);
    procedure DatabaseInfo;
  public
    { Public declarations }
  end;

var
  frmAboutProcessa: TfrmAboutProcessa;

implementation

uses Dado, Ovo, PrcDBInfo;

{$R *.dfm}

procedure TfrmAboutProcessa.FormCreate(Sender: TObject);
begin
  frmAboutProcessa.Icon := Application.Icon;
  lvUsers.SmallImages  := Dados.Image16;
  Caption := Application.Title + ' - Sobre o PROCESSA';
  Dados.Image16.GetBitmap(89, sbConn.Glyph);
  Dados.Image16.GetBitmap(84, sbAllUsers.Glyph);
end;

procedure TfrmAboutProcessa.FormActivate(Sender: TObject);
begin
  FEggKey := '';
  mDscInfo.Lines.Clear;
  sbConn.Click;
  DatabaseInfo;
end;

procedure TfrmAboutProcessa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
  S_KEY = 'f60dA58';
var
  aSafeStr: string;
  aSafeKey: Word;
begin
  aSafeKey := Key;
  Key := 0;
  if aSafeKey = 13 then
    Close;
  if aSafeKey = 27 then
    FEggKey := '';
  if (aSafeKey >= 48) and (aSafeKey <= 90) then
    FEggKey := FEggKey + Chr(aSafeKey);
  if CompareStr(FEggKey, S_KEY) = 0 then
  begin
    Application.CreateForm(TfrmEgg, frmEgg);
    try
      frmEgg.ShowModal;
    finally
      if Assigned(frmEgg) then
        frmEgg.Free;
      frmEgg := nil;
    end;
    FEggKey := '';
  end;
  if Length(FEggKey) > Length(S_KEY) then
  begin
    aSafeStr := stUsers.Caption;
    stUsers.Caption := 'Chave inválida';
    FEggKey := '';
    Sleep(500);
    stUsers.Caption := aSafeStr;
  end;
end;

procedure TfrmAboutProcessa.sbConnClick(Sender: TObject);
begin
  stUsers.Caption := 'Usuários conectados ao Banco';
  AddvtUsers(Dados.PrcDBInfo.GetConectedUserNames);
end;

procedure TfrmAboutProcessa.sbAllUsersClick(Sender: TObject);
begin
  stUsers.Caption := 'Lista de Usuários do Banco';
  Dados.GetDBAUser;
  AddvtUsers(Dados.PrcDBInfo.GetUserNames);
end;

procedure TfrmAboutProcessa.AddvtUsers(AList: TStrings);
var
  i: Integer;
begin
  lvUsers.Items.Clear;
  for i := 0 to AList.Count - 1 do
    with lvUsers.Items.Add do
    begin
      Caption    := AList.Strings[i];
      ImageIndex := 84;
    end;
end;

procedure TfrmAboutProcessa.DatabaseInfo;
  function GetDataBaseVersion: string;
    const
      SQL_DB_VERSION = 'select VERSAO from PARAMETROS_GLOBAIS';
  begin
    with Dados do
    begin
      if qrSqlAux.Active then qrSqlAux.Close;
      qrSqlAux.SQL.Clear;
      qrSqlAux.SQL.Add(SQL_DB_VERSION);
      try
        if (not qrSqlAux.Active) then qrSqlAux.Open;
        Result := qrSqlAux.fieldByName('VERSAO').AsString;
      finally
        if qrSqlAux.Active then qrSqlAux.Close;
      end;
    end;
  end;
begin
  mDscInfo.Lines.Add('Licenciado para: ' + Dados.NameCompany);
  mDscInfo.Lines.Add('Sistema:'          + Application.Title);
  mDscInfo.Lines.Add('Arquivo: '         + Dados.Conexao.Params.Values['DataBase']);
  mDscInfo.Lines.Add('Driver do Banco: ' + Dados.Conexao.DriverName);
  mDscInfo.Lines.Add('Versão do Banco de dados do Procesa: ' + GetDataBaseVersion);
  mDscInfo.Lines.AddStrings(Dados.PrcDBInfo.DataBaseInfo);
end;

end.

