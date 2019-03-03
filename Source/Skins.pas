unit Skins;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TProcSkins = class(TForm)
    sbOk: TSpeedButton;
    cbSkins: TComboBox;
    stTitle: TStaticText;
    cbDeactivate: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure cbSkinsClick(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure cbDeactivateClick(Sender: TObject);
  private
    { Private declarations }
    FSkinAnt : string;
    FModified: Boolean;
    FSkinPath: string;
    procedure SaveRegistry;
  public
    { Public declarations }
  end;

var
  ProcSkins: TProcSkins;

implementation

{$R *.dfm}

uses Senha, IniFiles, Funcoes, CmmConst;

procedure TProcSkins.FormCreate(Sender: TObject);
var
  i, aSts: integer;
  ArqIni : TIniFile;
  aSR    : TSearchRec;
  aList  : TStringList;
  procedure AddFile;
  begin
    aList.Add(aSR.Name);
  end;
begin
  FSkinAnt := FSenha.SkinData.SkinFile;
  ArqIni := TIniFile.Create(PathDoPrograma('') + 'Processa.ini');
  FSkinPath  := ArqIni.ReadString('IM', 'SkinPath', 'C:\Sistemas\Skins');
  if FSkinPath[Length(FSkinPath)] <> SPATHSEP then
    FSkinPath := FSkinPath + SPATHSEP;
  if Pos(FSkinPath, FSkinAnt) > 0 then
    Delete(FSkinAnt, 1, Length(FSkinPath));
  try
    aList      := TStringList.Create;
    aSts       := FindFirst(FSkinPath + '*.skn', faAnyFile , aSR);
    if (aSts = 0) then
    begin
      if (aSR.Name <> '.' ) and (aSR.Name <> '..' ) then
        if pos('.', aSR.Name) <> 0 then AddFile;
      while FindNext(aSR) = 0 do
         if (aSR.Name <> '.' ) and (aSR.Name <> '..' ) then
           if Pos('.', aSR.Name) <> 0 then AddFile;
    end;
    FindClose(aSR) ;
    aList.Sort;
    cbSkins.Items.Assign(aList);
    for i := 0 to cbSkins.Items.Count - 1 do
    begin
      if AnsiCompareText(FSkinAnt, cbSkins.Items[i]) = 0 then
        break;
    end;
    cbSkins.ItemIndex := i;
  finally
    aList.Free;
    ArqIni.Free;
  end;
end;

procedure TProcSkins.cbSkinsClick(Sender: TObject);
begin
  FModified := True;
  FSenha.SkinData.SkinFile := FSkinPath + cbSkins.Text;
  if not FSenha.SkinData.Active then FSenha.SkinData.Active := True;
end;

procedure TProcSkins.sbOkClick(Sender: TObject);
var
  QryRes: Word;
begin
  QryRes := MrNo;
  if FModified then
    QryRes := MessageDlg('Gostaria de salvar sua escolha nas preferênicas ' +
                'locais do sistema?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  case QryRes of
    mrYes   : SaveRegistry;
    mrCancel: FSenha.SkinData.SkinFile := FSkinAnt;
  end;
  FSenha.SkinData.Active := not cbDeactivate.Checked;
  Close;
end;

procedure TProcSkins.SaveRegistry;
begin
  WriteRegistry('Skin', 'SkinFile', FSenha.SkinData.SkinFile);
  if (not cbDeactivate.Checked) then
    WriteRegistry('Skin', 'ActiveSkin', 'True')
  else
    WriteRegistry('Skin', 'ActiveSkin', 'False');
end;

procedure TProcSkins.cbDeactivateClick(Sender: TObject);
begin
  FModified := True;
end;

end.
