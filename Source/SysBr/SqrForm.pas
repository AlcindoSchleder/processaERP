unit SqrForm;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2006 by Alcindo Schleder. All rights reserved.           *}
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
  Dialogs, TSysMan, ProcUtils, GridRow;

type
  TfrmSquareForms = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FDataRecord: TDataRow;
    FFkCompany : TCompany;
    FListLoaded: Boolean;
    FPkSquare  : Integer;
    FScrMode   : TDBMode;
    FTitle     : string;
    procedure SetFKCompany(const Value: TCompany);
    procedure SetPkSquare(const Value: Integer);
    procedure SetScrMode(const Value: TDBMode);
  protected
    { Protected declarations }
    procedure LoadDefaults; virtual; abstract;
    procedure ClearControls; virtual; abstract;
    procedure MoveObjectToControls; virtual; abstract;
  public
    { Public declarations }
    procedure SaveIntoDB; virtual; abstract;
    property DataRecord: TDataRow read FDataRecord write FDataRecord;
    property FkCompany : TCompany read FFkCompany  write SetFkCompany;
    property ListLoaded: Boolean  read FListLoaded write FListLoaded;
    property PkSquare  : Integer  read FPkSquare   write SetPkSquare;
    property Title     : string   read FTitle      write FTitle;
    property ScrMode   : TDBMode  read FScrMode    write SetScrMode;
  end;

implementation

{$R *.dfm}

procedure TfrmSquareForms.FormCreate(Sender: TObject);
begin
  FFkCompany  := TCompany.Create;
  FDataRecord := TDataRow.Create(Self);
end;

procedure TfrmSquareForms.FormDestroy(Sender: TObject);
begin
  if Assigned(FFkCompany)  then FFkCompany.Free;
  FFkCompany  := nil;
  FDataRecord := nil;
end;

procedure TfrmSquareForms.FormShow(Sender: TObject);
begin
  LoadDefaults;
end;

procedure TfrmSquareForms.SetFKCompany(const Value: TCompany);
begin
  if (FFkCompany = nil) then exit;
  FFkCompany.Clear;
  if (Value <> nil) then
    FFkCompany.Assign(Value);
end;

procedure TfrmSquareForms.SetPkSquare(const Value: Integer);
begin
  if FPkSquare <> Value then
  begin
    FPkSquare := Value;
  end;
end;

procedure TfrmSquareForms.SetScrMode(const Value: TDBMode);
begin
  if (FScrMode <> Value) then
  begin
    FScrMode := Value;
    case FScrMode of
      dbmInsert: ClearControls;
      dbmEdit  : MoveObjectToControls;
      dbmPost  : SaveIntoDB;
    end;
  end;
end;

end.
