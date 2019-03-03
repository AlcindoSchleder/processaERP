unit CadTOcr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SqrForm, StdCtrls, ExtCtrls, ToolEdit, Mask, CurrEdit;

type
  TCdTypeOccurs = class(TfrmSquareForms)
    lPk_Tipo_Ocorrencias: TStaticText;
    ePk_Tipo_Ocorrencias: TCurrencyEdit;
    eDsc_TOcr: TEdit;
    lDsc_TOcr: TStaticText;
    lPrefix_File: TStaticText;
    ePrefix_File: TEdit;
    lFlag_GFin: TCheckBox;
    eDta_LRead: TDateEdit;
    lDta_LRead: TStaticText;
    stTitle: TStaticText;
    lFlag_TOcr: TRadioGroup;
  private
    function GetDscTOcr: string;
    function GetDtaLRead: TDate;
    function GetFlagGFin: Boolean;
    function GetFlagTOcr: Integer;
    function GetPkTypeOccurs: Integer;
    function GetPrefixFile: string;
    procedure SetDscTOcr(const Value: string);
    procedure SetDtaLRead(const Value: TDate);
    procedure SetFlagGFin(const Value: Boolean);
    procedure SetFlagTOcr(const Value: Integer);
    procedure SetPkTypeOccurs(const Value: Integer);
    procedure SetPrefixFile(const Value: string);
    { Private declarations }
  protected
    { Protected declarations }
    procedure LoadDefaults; override;
    procedure ClearControls; override;
    procedure MoveObjectToControls; override;
  public
    { Public declarations }
    procedure SaveIntoDB; override;
    property DataRecord;
    property FkCompany;
    property ListLoaded;
    property PkSquare;
    property ScrMode;
    property DscTOcr     : string  read GetDscTOcr      write SetDscTOcr;
    property DtaLRead    : TDate   read GetDtaLRead     write SetDtaLRead;
    property FlagTOcr    : Integer read GetFlagTOcr     write SetFlagTOcr;
    property FlagGFin    : Boolean read GetFlagGFin     write SetFlagGFin;
    property PkTypeOccurs: Integer read GetPkTypeOccurs write SetPkTypeOccurs;
    property PrefixFile  : string  read GetPrefixFile   write SetPrefixFile;
  end;

var
  CdTypeOccurs: TCdTypeOccurs;

implementation

uses GridRow, mSysBr, ProcUtils;

{$R *.dfm}

{ TCdTypeOccurs }

procedure TCdTypeOccurs.ClearControls;
begin
  DscTOcr      := '';
  DtaLRead     := 0;
  FlagTOcr     := 0;
  FlagGFin     := True;
  PkTypeOccurs := 0;
  PrefixFile   := '';
end;

procedure TCdTypeOccurs.LoadDefaults;
begin
  // nothing to load
end;

procedure TCdTypeOccurs.MoveObjectToControls;
begin
  DscTOcr      := DataRecord.FieldByName['DSC_TOCR'].AsString;
  DtaLRead     := DataRecord.FieldByName['DTA_LREAD'].AsDateTime;
  FlagTOcr     := DataRecord.FieldByName['FLAG_TOCR'].AsInteger;
  FlagGFin     := Boolean(DataRecord.FieldByName['FLAG_GFIN'].AsInteger);
  PkTypeOccurs := DataRecord.FieldByName['PK_TIPO_OCORRENCIAS'].AsInteger;
  PrefixFile   := DataRecord.FieldByName['PREFIX_FILE'].AsString;
end;

procedure TCdTypeOccurs.SaveIntoDB;
begin
  DataRecord.FieldByName['DSC_TOCR'].AsString             := DscTOcr;
  DataRecord.FieldByName['DTA_LREAD'].AsDateTime          := DtaLRead;
  DataRecord.FieldByName['FLAG_TOCR'].AsInteger           := FlagTOcr;
  DataRecord.FieldByName['FLAG_GFIN'].AsInteger           := Ord(FlagGFin);
  DataRecord.FieldByName['PK_TIPO_OCORRENCIAS'].AsInteger := PkTypeOccurs;
  DataRecord.FieldByName['PREFIX_FILE'].AsString          := PrefixFile;
  dmSysBr.SaveTypeOccurs(ScrMode, DataRecord);
  ScrMode := dbmBrowse;
end;

function TCdTypeOccurs.GetDscTOcr: string;
begin
  Result := eDsc_TOcr.Text;
end;

function TCdTypeOccurs.GetDtaLRead: TDate;
begin
  Result := eDta_LRead.Date;
end;

function TCdTypeOccurs.GetFlagGFin: Boolean;
begin
  Result := lFlag_GFin.Checked;
end;

function TCdTypeOccurs.GetFlagTOcr: Integer;
begin
  Result := lFlag_TOcr.ItemIndex;
end;

function TCdTypeOccurs.GetPkTypeOccurs: Integer;
begin
  Result := ePk_Tipo_Ocorrencias.AsInteger;
end;

function TCdTypeOccurs.GetPrefixFile: string;
begin
  Result := ePrefix_File.Text;
end;

procedure TCdTypeOccurs.SetDscTOcr(const Value: string);
begin
  eDsc_TOcr.Text := Value;
end;

procedure TCdTypeOccurs.SetDtaLRead(const Value: TDate);
begin
  eDta_LRead.Date := Value;
end;

procedure TCdTypeOccurs.SetFlagGFin(const Value: Boolean);
begin
  lFlag_GFin.Checked := Value;
end;

procedure TCdTypeOccurs.SetFlagTOcr(const Value: Integer);
begin
  lFlag_TOcr.ItemIndex := Value;
end;

procedure TCdTypeOccurs.SetPkTypeOccurs(const Value: Integer);
begin
  ePk_Tipo_Ocorrencias.AsInteger := Value;
end;

procedure TCdTypeOccurs.SetPrefixFile(const Value: string);
begin
  ePrefix_File.Text := Value;
end;

end.
