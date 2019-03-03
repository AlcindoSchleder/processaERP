unit CadPedVinc;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder.                                             *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created: 02/06/2003                                                   *}
{* Modified: 02/06/2003                                                  *}
{* Version: 1.2.0.0                                                      *}
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
  Dialogs, ExtCtrls, VirtualTrees, Mask, ToolEdit, CurrEdit, Buttons, StdCtrls,
  ProcType, CadModel;

type
  TCdPedVinc = class(TfrmModel)
    vtItems: TVirtualStringTree;
    procedure vtItemsEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure vtItemsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtItemsNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: WideString);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
  end;

implementation

{$R *.dfm}

procedure TCdPedVinc.LoadDefaults;
begin
end;

procedure TCdPedVinc.MoveDataToControls;
begin
end;

procedure TCdPedVinc.ClearControls;
begin
end;

procedure TCdPedVinc.SaveIntoDB;
begin
end;

procedure TCdPedVinc.vtItemsEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  if (Node = nil) then exit;
  Allowed := (Column = 0);
end;

procedure TCdPedVinc.vtItemsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data.DataRow = nil) then exit;
  CellText := Data.DataRow.Fields[Column].AsString;
end;

procedure TCdPedVinc.vtItemsNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
var
  Data: PGridData;
  aNum: Integer;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data.DataRow = nil) then exit;
  aNum := StrToIntDef(NewText, 0);
  if aNum > 0 then
    Data^.DataRow.FieldByName['PK_PEDIDOS'].AsInteger := aNum
  else
    NewText := Data^.DataRow.FieldByName['PK_PEDIDOS'].AsString;
end;

end.
