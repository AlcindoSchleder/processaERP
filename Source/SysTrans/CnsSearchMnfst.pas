unit CnsSearchMnfst;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder.                                          *}
{* Copyright: © 2003 by Sistema Processa Ltda. All rights reserved.      *}
{* Created  : 14/02/2007                                                 *}
{* Modified :                                                            *}
{* Version  : 1.2.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PrcSysTypes, StdCtrls, Mask, ComCtrls, ToolEdit, CurrEdit, ExtCtrls,
  VirtualTrees, mSysTrans, CadModel;

type
  TCnManifest = class(TfrmModel)
    vtOrigin: TVirtualStringTree;
    pParams: TPanel;
    eNumNF: TCurrencyEdit;
    eNumDoc: TCurrencyEdit;
    lNumNF: TStaticText;
    lNumDoc: TStaticText;
    gbPeriod: TGroupBox;
    lDtaIni: TStaticText;
    eDtaIni: TDateEdit;
    lDtaFin: TStaticText;
    eDtaFin: TDateEdit;
    eTypeRem: TComboBox;
    eCnpjRem: TMaskEdit;
    lCnpjRem: TStaticText;
    lRazSocRem: TLabel;
    lCnpjDstn: TStaticText;
    eTypeDstn: TComboBox;
    eCnpjDstn: TMaskEdit;
    lRazSocDstn: TLabel;
    shRazSocRem: TShape;
    shRazSocDstn: TShape;
    procedure eTypeRemSelect(Sender: TObject);
    procedure eTypeDstnSelect(Sender: TObject);
  private
    { Private declarations }
    FOnSelectedDocument: TOnVerifyIDEvent;
    FDocumentType: TDocumentType;
    function  GetCnpjDstn: string;
    function  GetCnpjRem: string;
    function  GetNumDoc: Integer;
    function  GetNumNF: Integer;
    procedure SetCnpjDstn(const Value: string);
    procedure SetCnpjRem(const Value: string);
    procedure SetNumDoc(const Value: Integer);
    procedure SetNumNF(const Value: Integer);
    procedure SetDocumentType(const Value: TDocumentType);
    procedure SetMaskToControl(ALabel: TStaticText; const AIdx, AField: Integer);
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure ClearControls; override;
    procedure SaveIntoDB; override;
    property  CnpjRem     : string        read GetCnpjRem    write SetCnpjRem;
    property  CnpjDstn    : string        read GetCnpjDstn   write SetCnpjDstn;
    property  NumNF       : Integer       read GetNumNF      write SetNumNF;
    property  NumDoc      : Integer       read GetNumDoc     write SetNumDoc;
  public
    { Public declarations }
    property  OnSelectedDocument: TOnVerifyIDEvent read FOnSelectedDocument write FOnSelectedDocument;
    property  DocumentType      : TDocumentType    read FDocumentType       write SetDocumentType;
  end;

var
  CnManifest: TCnManifest;

implementation

{$R *.dfm}

{ TfrmSearch }

procedure TCnManifest.ClearControls;
begin
  Loading := True;
  try
    CnpjRem  := '';
    CnpjDstn := '';
    NumNF    := 0;
    NumDoc   := 0;
  finally
    Loading := False;
  end;
end;

function TCnManifest.GetCnpjDstn: string;
begin
  Result := eCnpjDstn.EditText;
end;

function TCnManifest.GetCnpjRem: string;
begin
  Result := eCnpjRem.EditText;
end;

function TCnManifest.GetNumDoc: Integer;
begin
  Result := eNumDoc.AsInteger;
end;

function TCnManifest.GetNumNF: Integer;
begin
  Result := eNumNF.AsInteger;
end;

procedure TCnManifest.LoadDefaults;
begin
  // Nothing to do;
end;

procedure TCnManifest.MoveDataToControls;
begin
  // Nothing to do
end;

procedure TCnManifest.SaveIntoDB;
begin
  // Nothing to do
end;

procedure TCnManifest.SetCnpjDstn(const Value: string);
begin
  eCnpjDstn.EditText := Value;
end;

procedure TCnManifest.SetCnpjRem(const Value: string);
begin
  eCnpjRem.EditText := Value;
end;

procedure TCnManifest.SetDocumentType(const Value: TDocumentType);
begin
  FDocumentType := Value;
end;

procedure TCnManifest.SetMaskToControl(ALabel: TStaticText; const AIdx, AField: Integer);
const
  FIELD_MASK   : array[0..1] of string = ('00.000.000\/0000\-00;0; ', '000.000.000\-00;0; ');
  LABEL_CAPTION: array[0..1] of string = ('C.N.P.J. ', 'C.P.F. ');
  TYPE_FIELD   : array[0..1] of string = ('do Remetente: ', 'do Destinatário: ');
begin
  ALabel.Caption := LABEL_CAPTION[AIdx] + TYPE_FIELD[AField];
  if (ALabel.FocusControl <> nil) then
    TMaskEdit(ALabel.FocusControl).EditMask := FIELD_MASK[AIdx];
end;

procedure TCnManifest.SetNumDoc(const Value: Integer);
begin
  eNumDoc.AsInteger := Value;
end;

procedure TCnManifest.SetNumNF(const Value: Integer);
begin
  eNumNF.AsInteger := Value;
end;

procedure TCnManifest.eTypeRemSelect(Sender: TObject);
begin
  SetMaskToControl(lCnpjRem, eTypeRem.ItemIndex, 0);
end;

procedure TCnManifest.eTypeDstnSelect(Sender: TObject);
begin
  SetMaskToControl(lCnpjDstn, eTypeDstn.ItemIndex, 1);
end;

end.
