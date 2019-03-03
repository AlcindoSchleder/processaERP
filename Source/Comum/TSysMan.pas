unit TSysMan;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 22/04/2003 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for datails                *}
{* Contact  : (alcindo@sistemaprocessa.com.br)                           *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  SysUtils, Classes;

type

// 0 ==> Nota Fiscal
// 1 ==> Boleto Bancário
// 2 ==> Ordem de Serviços 
// 3 ==> Recibos
// 4 ==> Requisições
// 5 ==> Cheques
// 6 ==> Pedidos
// 7 ==> Ordens de Produção
// 8 ==> Controle Interno
  TDocumentType = (dtNF, dtBoleto, dtOS, dtRecibo, dtRequisicao, dtCheque, 
                   dtPedido, dtOP, dtCI, dtAll); 

  TTypeDocument = class (TPersistent)
  private
    FcbIndex: Integer;
    FDscTDoc: string;
    FFlagExt: Boolean;
    FFlagTDoc: TDocumentType;
    FObsDoc: TStrings;
    FPkTypeDocument: Integer;
    FQtdItem: Integer;
    procedure SetDscTDoc(AValue: string);
    procedure SetObsDoc(AValue: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; overload;
    function GetFields: TStrings;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property DscTDoc: string read FDscTDoc write SetDscTDoc;
    property FlagExt: Boolean read FFlagExt write FFlagExt default True;
    property FlagTDoc: TDocumentType read FFlagTDoc write FFlagTDoc default 
            dtPedido;
    property ObsDoc: TStrings read FObsDoc write SetObsDoc;
    property PkTypeDocument: Integer read FPkTypeDocument write FPkTypeDocument;
    property QtdItem: Integer read FQtdItem write FQtdItem;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  
  TCompany = class (TPersistent)
  private
    FDscEmp: string;
    FFkCountry: Integer;
    FPkCompany: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DscEmp: string read FDscEmp write FDscEmp;
    property FkCountry: Integer read FFkCountry write FFkCountry;
    property PkCompany: Integer read FPkCompany write FPkCompany default 0;
  published
    function GetPkValue: Variant;
  end;
  

implementation

{
******************************** TTypeDocument *********************************
}
constructor TTypeDocument.Create;
begin
  inherited Create;
  FObsDoc := TStringList.Create;
  Clear;
end;

destructor TTypeDocument.Destroy;
begin
  Clear;
  if Assigned(FObsDoc) then
    FObsDoc.Free;
  FObsDoc := nil;
  inherited Destroy;
end;

procedure TTypeDocument.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (Source is TTypeDocument) then
  begin
    DscTDoc   := TTypeDocument(Source).DscTDoc;
    FFlagExt  := TTypeDocument(Source).FlagExt;
    FFlagTDoc := TTypeDocument(Source).FlagTDoc;
    if Assigned(FObsDoc) then
      ObsDoc  := TTypeDocument(Source).ObsDoc;
    FPkTypeDocument := TTypeDocument(Source).PkTypeDocument;
    FQtdItem  := TTypeDocument(Source).QtdItem;
    FcbIndex  := TTypeDocument(Source).cbIndex;
  end
  else
    inherited Assign(Source);
end;

procedure TTypeDocument.Clear;
begin
  FDscTDoc  := '';
  FFlagExt  := True;
  FFlagTDoc := dtPedido;
  if Assigned(FObsDoc) then
    FObsDoc.Clear;
  FPkTypeDocument := 0;
  FQtdItem  := 0;
  cbIndex   := 0;
end;

function TTypeDocument.ComparePk(const AValue: Variant): Integer;
var
  aPk: Integer;
begin
  Result := -1;
  try
    aPk := AValue;
  except
    aPk := 0;
  end;
  if (aPk = FPkTypeDocument) then
    Result := FcbIndex;
end;

function TTypeDocument.GetFields: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('PK_TIPO_DOCUMENTOS');
  Result.Add('DSC_TDOC');
  Result.Add('FLAG_EXT');
  Result.Add('FLAG_TDOC');
  if (ObsDoc.Text <> '') then
    Result.Add('OBS_TDOC');
  if (QtdItem > 0) then
    Result.Add('QTD_ITM');
end;

function TTypeDocument.GetPkValue: Variant;
begin
  Result := FPkTypeDocument;
end;

procedure TTypeDocument.SetDscTDoc(AValue: string);
begin
  FDscTDoc := Copy(AValue, 1, 50);
end;

procedure TTypeDocument.SetObsDoc(AValue: TStrings);
begin
  if (AValue = nil) then
    FObsDoc.Clear
  else
    FObsDoc.Assign(AValue);
end;

{
*********************************** TCompany ***********************************
}
constructor TCompany.Create;
begin
  inherited Create;
  Clear;
end;

destructor TCompany.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TCompany.Assign(Source: TPersistent);
begin
  if (Source is TCompany) then
  begin
    FDscEmp    := TCompany(Source).DscEmp;
    FFkCountry := TCompany(Source).FkCountry;
    FPkCompany := TCompany(Source).PkCompany;
  end
  else
    inherited Assign(Source);
end;

procedure TCompany.Clear;
begin
  FDscEmp    := '';
  FFkCountry := 0;
  FPkCompany := 0;
end;

function TCompany.GetPkValue: Variant;
begin
  Result := FPkCompany;
end;


end.
