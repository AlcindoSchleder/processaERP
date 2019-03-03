unit PrcSysTypes;

interface

uses
  SysUtils, Classes, ProcUtils, GridRow, Variants;

type
  TOnVerifyIDEvent = procedure (Sender: TObject; const Value: Integer; var 
          Allowed: Boolean) of object;
  TOnUpdateRow = procedure (Sender: TObject; Row: TDataRow) of object;
  TOnCheckRecord = function (const OldState, NewState: TDbMode): Boolean of 
          object;
  TSysProc = class (TPersistent)
  private
    FcbIndex: Integer;
    FPk: Variant;
  protected
    FClass: TClass;
    procedure AssignFields(Source: TPersistent); virtual; abstract;
  public
    constructor Create(AClass: TClass); reintroduce;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual; abstract;
    function GetFields: TStrings; virtual; abstract;
    property cbIndex: Integer read FcbIndex write FcbIndex;
    property Pk: Variant read FPk write FPk;
  published
    function ComparePk(const AValue: Variant): Integer;
    function GetPkValue: Variant;
  end;
  

implementation

{
*********************************** TSysProc ***********************************
}
constructor TSysProc.Create(AClass: TClass);
begin
  inherited Create;
  FClass := AClass;
  Clear;
end;

destructor TSysProc.Destroy;
begin
  inherited Destroy;
end;

procedure TSysProc.Assign(Source: TPersistent);
begin
  if (Source <> nil) and (not Source.InheritsFrom(TSysProc)) and
     (Source.ClassType <> FClass) then
    inherited Assign(Source)
  else
    AssignFields(Source);
end;

function TSysProc.ComparePk(const AValue: Variant): Integer;
begin
  Result := -1;
  if VarIsArray(Pk) and (not VarIsArray(AValue)) then exit;
  if (AValue = Pk) then
    Result := FcbIndex;
end;

function TSysProc.GetPkValue: Variant;
begin
  Result := Pk;
end;


end.
