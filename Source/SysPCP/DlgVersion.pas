unit DlgVersion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, StdCtrls, ExtCtrls, Spin;

type
  TTypeMod  = (tmNew, tmVersion);

  TdgVersion = class(TForm)
    rgTypeMod: TRadioGroup;
    Painel: TStatusBar;
    lRefPart: TLabel;
    lVersion: TLabel;
    seMajVer: TSpinEdit;
    seMinVer: TSpinEdit;
    eRefPart: TEdit;
    sbCancel: TSpeedButton;
    sbOk: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure rgTypeModClick(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
  private
    { Private declarations }
    FTypeMod : TTypeMod;
    FCodPart : Integer;
    FCodFicha: Integer;
    FFlagOp  : Integer;
    FFlagAtv : Integer;
    FMajVer  : Integer;
    FMinVer  : Integer;
    FRefPart : string;
    procedure SetTypeMod(AValue: TTypeMod);
    function  VerifyNewVersion: Boolean;
  public
    { Public declarations }
    property TypeMod : TTypeMod read FTypeMod  write SetTypeMod default tmNew;
    property CodPart : Integer  read FCodPart  write FCodPart   default 0;
    property CodFicha: Integer  read FCodFicha write FCodFicha  default 0;
    property FlagOp  : Integer  read FFlagOp   write FFlagOp    default 0;
    property FlagAtv : Integer  read FFlagAtv  write FFlagAtv   default 0;
    property MajVer  : Integer  read FMajVer   write FMajVer    default 0;
    property MinVer  : Integer  read FMinVer   write FMinVer    default 0;
    property RefPart : string   read FRefPart  write FRefPart;
  end;

var
  dgVersion: TdgVersion;

implementation

uses mSysPCP, Dado, ArqSql, CmmConst;

{$R *.dfm}

procedure TdgVersion.FormCreate(Sender: TObject);
begin
  eRefPart.Text  := '';
  seMajVer.Value := 1;
  seMinVer.Value := 0;
  FTypeMod       := TTypeMod(rgTypeMod.ItemIndex);
  Dados.Image16.GetBitmap(16, sbOk.Glyph);
  Dados.Image16.GetBitmap(56, sbCancel.Glyph);
  rgTypeMod.Caption := Dados.GetStringMessage(LANGUAGE, 'srgTypeMod', 'Tipo de Operação');
  lVersion.Caption  := Dados.GetStringMessage(LANGUAGE, 'slVersion', 'Versão:');
  FCodPart          := 0;
  FCodFicha         := 0;
  FFlagOp           := 0;
  FFlagAtv          := 0;
  FMajVer           := 1;
  FMinVer           := 0;
  FRefPart          := '';
end;

procedure TdgVersion.rgTypeModClick(Sender: TObject);
begin
  TypeMod := TTypeMod(rgTypeMod.ItemIndex);
end;

procedure TdgVersion.SetTypeMod(AValue: TTypeMod);
begin
  if AValue <> FTypeMod then
  begin
    FTypeMod         := AValue;
    eRefPart.Visible := (FTypeMod = tmVersion);
    lRefPart.Visible := (FTypeMod = tmVersion);
    if FTypeMod = tmVersion then
    begin
      eRefPart.Text  := RefPart;
      dmSysPCP.LocateNewVersion(FCodPart, FMajVer, FMinVer);
      if FMinVer = 9 then
      begin
        FMajVer := MajVer + 1;
        FMinVer := 0;
      end
      else
        FMinVer := FMinVer + 1;
      seMajVer.Value := FMajVer;
      seMinVer.Value := FMinVer;
    end;
  end;
end;

procedure TdgVersion.sbOkClick(Sender: TObject);
begin
  // Verify informations
  FRefPart := eRefPart.Text;
  FMajVer  := seMajVer.Value;
  FMinVer  := seMinVer.Value;
  if (TypeMod = tmVersion) then
  begin
    if VerifyNewVersion then
      ModalResult := mrOk
    else
      if eRefPart.CanFocus then
        eRefPart.SetFocus;
  end
  else
    ModalResult := mrOk
end;

procedure TdgVersion.sbCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function  TdgVersion.VerifyNewVersion: Boolean;
begin
  Result   := not dmSysPCP.LocateVersion(FRefPart, FMajVer, FMinVer);
  if not Result then
    Application.MessageBox(PChar(Format(Dados.GetStringMessage(LANGUAGE, 'sErrNewVersion',
      'Erro: Versão "%d.%d" da Peça %s já existe'), [FMajVer, FMinVer, FRefPart])),
      PChar(Caption), MB_ICONINFORMATION + MB_OK);
end;

end.
