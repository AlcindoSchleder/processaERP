unit EditFerramentaOperacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, CurrEdit, Buttons;

type
  TUpdateFerramentaEvent=procedure (Sender:TObject;afkFerramenta:Integer;aDescFerramenta:String) of object;
  TfmEditFerramentaOperacao = class(TForm)
    Label1: TLabel;
    cbFerramenta: TComboBox;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    cmdNew: TBitBtn;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FfkFerramenta           : Integer;
    FOnInsertFerramenta     : TUpdateFerramentaEvent;
    FOnUpdateFerramenta     : TUpdateFerramentaEvent;
    FslFerramentasDaMaquina: TList;
    procedure EnableControls;
    procedure LoadFerramentas;
    procedure ClearFerramenta;
    procedure LoadFerramenta;
  public
    { Public declarations }
    property fkFerramenta:Integer read FfkFerramenta write FfkFerramenta;
    property OnInsertFerramenta:TUpdateFerramentaEvent read FOnInsertFerramenta write FOnInsertFerramenta;
    property OnUpdateFerramenta:TUpdateFerramentaEvent read FOnUpdateFerramenta write FOnUpdateFerramenta;
    property slFerramentasDaMaquina:TList read FslFerramentasDaMaquina;
  end;

var
  fmEditFerramentaOperacao: TfmEditFerramentaOperacao;

implementation

uses udmFichaTecnica;

{$R *.dfm}

procedure TfmEditFerramentaOperacao.LoadFerramentas;
begin
  cbFerramenta.Items.Clear;
  with dmFichaTecnica.qrFerramentas do
       try
         Open;
         While Not(EOF) do
               begin
                 cbFerramenta.Items.AddObject(FieldByName('COD_REF').AsString+' - '+FieldByName('DSC_INS').AsString,TObject(FieldByName('PK_INSUMOS').AsInteger));
                 Next;
               end;
       finally
         Close;
       end;
end;

procedure TfmEditFerramentaOperacao.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmEditFerramentaOperacao.EnableControls;
begin
  cbFerramenta.Enabled    :=(FfkFerramenta<1);
  if FfkFerramenta<1 Then
     begin
       cmdUpdate.Caption:='&Incluir';
       Caption:='Nova Ferramenta';
     end
  else
     begin
       cmdUpdate.Caption:='&Alterar';
       Caption:='Ferramenta: '+cbFerramenta.Text;
     end;
end;

procedure TfmEditFerramentaOperacao.ClearFerramenta;
begin
  EnableControls;
end;

procedure TfmEditFerramentaOperacao.LoadFerramenta;
begin
  ClearFerramenta;
  if FfkFerramenta<1 Then Exit;
  cbFerramenta.ItemIndex:=cbFerramenta.Items.IndexOfObject(TObject(FfkFerramenta));
end;

procedure TfmEditFerramentaOperacao.cmdUpdateClick(Sender: TObject);
var IsNew         :Boolean;
begin
  if cbFerramenta.ItemIndex<0 Then
     begin
       if cbFerramenta.CanFocus Then cbFerramenta.SetFocus;
       MessageBox(Self.Handle,'A Ferramenta deve ser selecionada !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  IsNew         :=(FFkFerramenta<1);
  if ((IsNew)And(FslFerramentasDaMaquina<>Nil)And(FslFerramentasDaMaquina.IndexOf(cbFerramenta.Items.Objects[cbFerramenta.ItemIndex])>-1)) Then
     begin
       MessageBox(Self.Handle,'Esta Ferramenta já foi cadastrada para esta Máquina !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  FfkFerramenta:=LongInt(cbFerramenta.Items.Objects[cbFerramenta.ItemIndex]);
  if IsNew Then
     if Assigned(FOnInsertFerramenta) Then FOnInsertFerramenta(Self,FfkFerramenta,cbFerramenta.Text)
     else
  else
     if Assigned(FOnUpdateFerramenta) Then FOnUpdateFerramenta(Self,FfkFerramenta,cbFerramenta.Text);
  EnableControls;
end;

procedure TfmEditFerramentaOperacao.cmdNewClick(Sender: TObject);
begin
  FfkFerramenta:=0;
  LoadFerramenta;
end;

procedure TfmEditFerramentaOperacao.FormCreate(Sender: TObject);
begin
  FslFerramentasDaMaquina:=TList.Create;
  LoadFerramentas;
end;

procedure TfmEditFerramentaOperacao.FormDestroy(Sender: TObject);
begin
  FslFerramentasDaMaquina.Free;
  FslFerramentasDaMaquina:=Nil;
end;

end.
