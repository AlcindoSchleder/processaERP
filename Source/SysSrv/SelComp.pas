unit SelComp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, jpeg;

type
  TfrmCompositions = class(TForm)
    Shape1: TShape;
    stTitle: TStaticText;
    imLogo: TImage;
    eDsc_Comp: TStaticText;
    eCod_Comp: TEdit;
    Edit1: TEdit;
    sbSearchComp: TSpeedButton;
    lCod_Rod: TStaticText;
    eCod_Rod: TComboBox;
    StaticText1: TStaticText;
    lLoc_Ini: TStaticText;
    eDsc_Mun: TEdit;
    eLoc_Ini: TEdit;
    Edit2: TEdit;
    lComp_Srv: TStaticText;
    eComp_Srv: TEdit;
    lLarg_Srv: TStaticText;
    eLarg_Srv: TEdit;
    lAlt_Srv: TStaticText;
    eAlt_Srv: TEdit;
    sbSave: TSpeedButton;
    sbCancel: TSpeedButton;
    sbNew: TSpeedButton;
    lPersonalize: TCheckBox;
    procedure eLoc_IniKeyPress(Sender: TObject; var Key: Char);
    procedure sbCancelClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ATop, ALeft, AItemsWidth,
                  AItemsHeight: Integer); reintroduce;
  end;

var
  frmCompositions: TfrmCompositions;

implementation

{$R *.dfm}

constructor TfrmCompositions.Create(AOwner: TComponent; ATop, ALeft, AItemsWidth,
  AItemsHeight: Integer);
begin
  inherited Create(AOwner);
  BorderStyle       := bsNone;
  Top  := ATop + (AItemsHeight - 207);
  Left := ALeft + ((AItemsWidth - 689) div 2);
end;

procedure TfrmCompositions.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if Owner <> nil then
    Params.WndParent := TWinControl(Owner).Handle
end;

procedure TfrmCompositions.eLoc_IniKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmCompositions.sbCancelClick(Sender: TObject);
begin
  Close;
end;

end.
