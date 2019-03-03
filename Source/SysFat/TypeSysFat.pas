unit TypeSysFat;

{*************************************************************************}
{*                                                                       *}
{* Author: CSD Informatica                                               *}
{* Copyright: © 2003 by CSD Informatica. All rights reserved.            *}
{* Created: 03/06/2003 - DD/MM/YYYY                                      *}
{* Modified: 03/06/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (jorge@csd.com.br)                                           *}
{*         http://www.csd.com.br                                         *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type

  TTypeDoc = (tdOSSale, tdRequestSale, tdOrderSale, 
              tdOSBuy,  tdRequestBuy,  tdOrderBuy);
              
  TChangeTypeDoc = procedure (Sender: TObject; ATypeDoc: TTypeDoc; var 
          ATableName, AItemTableName: string) of object;
          
  TDocs = class (TPersistent)
  private
    FOnChangeTypeDoc: TChangeTypeDoc;
    FTypeDoc: TTypeDoc;
    procedure SetTypeDoc(Value: TTypeDoc);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property TypeDoc: TTypeDoc read FTypeDoc write SetTypeDoc;
  published
    property OnChangeTypeDoc: TChangeTypeDoc read FOnChangeTypeDoc write 
            FOnChangeTypeDoc;
  end;
  

implementation

{
************************************ TDocs *************************************
}
constructor TDocs.Create;
begin
  inherited Create;
  FTypeDoc := tdOSBuy;
end;

destructor TDocs.Destroy;
begin
  inherited Destroy;
end;

procedure TDocs.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

procedure TDocs.SetTypeDoc(Value: TTypeDoc);
begin
end;


end.
