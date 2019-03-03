program Pdv;

uses
  Forms,
  MovPdv      in 'MovPdv.pas' {fMovPdv},
  MovFunction in 'MovFunction.pas' {fMoveFunction},
  uGeneral    in 'uGeneral.pas',
  mSysPdv     in 'mSysPdv.pas' {dmSysPdv: TDataModule},
  uPdvConfig  in 'uPdvConfig.pas' {frmPDVConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Sistema Processa E.R.P. Open Source  - PDV';
  ReadGeneralINIConfig;
  Application.CreateForm(TfMovPdv, fMovPdv);
  Application.Run;
end.
