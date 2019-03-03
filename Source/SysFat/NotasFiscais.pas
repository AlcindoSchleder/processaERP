unit NotasFiscais;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, JvToolEdit, ToolEdit, CurrEdit,
  JvExMask;

type
  TfmNotasFiscais = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    cbEmpresa: TComboBox;
    Label2: TLabel;
    cbGrupoMovimento: TComboBox;
    dtDe: TJvDateEdit;
    dtAte: TJvDateEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edNumero: TCurrencyEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNotasFiscais: TfmNotasFiscais;

implementation

{$R *.dfm}

end.
