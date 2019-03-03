unit EditMaquinaOperacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, CurrEdit, Buttons, dbObjects,VirtualTrees;

type
  TUpdateMaquinaEvent=procedure (Sender:TObject;afkMaquina:Integer;aDescMaquina:String;aTmpStp:Double;aTmpOper:Double;aIsDefault:Boolean) of object;
  TfmEditMaquinaOperacao = class(TForm)
    Label1: TLabel;
    cbMaquina: TComboBox;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    cmdNew: TBitBtn;
    Label2: TLabel;
    edTmp_Stp: TCurrencyEdit;
    Label3: TLabel;
    edTmp_Oper: TCurrencyEdit;
    chkFlag_Def: TCheckBox;
    edCOD_REF: TEdit;
    Label4: TLabel;
    cmdSearch: TSpeedButton;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCOD_REFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdSearchClick(Sender: TObject);
  private
    { Private declarations }
    FfkMaquina          : Integer;
    FOnInsertMaquina    : TUpdateMaquinaEvent;
    FOnUpdateMaquina    : TUpdateMaquinaEvent;
    FslMaquinasOperacao : TList;
    procedure EnableControls;
    procedure LoadMaquinas;
    procedure ClearMaquina;
    procedure LoadMaquina;
    procedure SetfkMaquina(const Value: Integer);
    procedure SetIsDefault(const Value: Boolean);
    procedure SetTmpOper(const Value: Double);
    procedure SetTmpStp(const Value: Double);
    function GetIsDefault: Boolean;
    function GetTmpOper: Double;
    function GetTmpStp: Double;
  public
    { Public declarations }
    property fkMaquina:Integer read FfkMaquina write SetfkMaquina;
    property IsDefault:Boolean read GetIsDefault write SetIsDefault;
    property TmpStp:Double read GetTmpStp write SetTmpStp;
    property TmpOper:Double read GetTmpOper write SetTmpOper;
    property OnInsertMaquina:TUpdateMaquinaEvent read FOnInsertMaquina write FOnInsertMaquina;
    property OnUpdateMaquina:TUpdateMaquinaEvent read FOnUpdateMaquina write FOnUpdateMaquina;
    property slMaquinasOperacao:TList read FslMaquinasOperacao;
  end;

var
  fmEditMaquinaOperacao: TfmEditMaquinaOperacao;

implementation

uses udmFichaTecnica;

{$R *.dfm}

procedure TfmEditMaquinaOperacao.ClearMaquina;
begin
  edTmp_Stp.Value     :=0;
  edTmp_Oper.Value    :=0;
  chkFLAG_DEF.Checked :=False;
  EnableControls;
end;

procedure TfmEditMaquinaOperacao.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmEditMaquinaOperacao.EnableControls;
begin
  cbMaquina.Enabled   :=(FfkMaquina<1);
  edCOD_REF.Enabled   :=cbMaquina.Enabled;
  cmdSearch.Visible   :=cbMaquina.Enabled;
  if FfkMaquina<1 Then
     begin
       cmdUpdate.Caption:='&Incluir';
       Caption:='Nova Máquina';
     end
  else
     begin
       cmdUpdate.Caption:='&Alterar';
       Caption:='Máquina: '+cbMaquina.Text;
     end;

end;

procedure TfmEditMaquinaOperacao.LoadMaquina;
begin
  if FfkMaquina<1 Then
     begin
       ClearMaquina;
       Exit;
     end;
  EnableControls;
  cbMaquina.ItemIndex :=cbMaquina.Items.IndexOfObject(TObject(FfkMaquina));
  edTmp_Stp.Value     :=TmpStp;
  edTmp_Oper.Value    :=TmpOper;
  chkFLAG_DEF.Checked :=IsDefault;
end;

procedure TfmEditMaquinaOperacao.LoadMaquinas;
begin
  cbMaquina.Items.Clear;
  with dmFichaTecnica.qrMaquinas do
       try
         Open;
         While Not(EOF) do
               begin
                 cbMaquina.Items.AddObject(FieldByName('COD_REF').AsString+' - '+FieldByName('dsc_maq').AsString,TObject(FieldByName('pk_maquinas').AsInteger));
                 Next;
               end;
       finally
         Close;
       end;
end;

procedure TfmEditMaquinaOperacao.SetfkMaquina(const Value: Integer);
begin
  FfkMaquina := Value;
end;

procedure TfmEditMaquinaOperacao.SetIsDefault(const Value: Boolean);
begin
  ChkFLAG_DEF.Checked:=Value;
end;

procedure TfmEditMaquinaOperacao.SetTmpOper(const Value: Double);
begin
  edTmp_Oper.Value  :=Value;
end;

procedure TfmEditMaquinaOperacao.SetTmpStp(const Value: Double);
begin
  edTmp_Stp.Value :=Value;
end;

procedure TfmEditMaquinaOperacao.FormCreate(Sender: TObject);
begin
  FslMaquinasOperacao :=TList.Create;
  LoadMaquinas;
end;

procedure TfmEditMaquinaOperacao.FormDestroy(Sender: TObject);
begin
  FslMaquinasOperacao.Free;
  FslMaquinasOperacao :=Nil;
end;

procedure TfmEditMaquinaOperacao.cmdNewClick(Sender: TObject);
begin
  FfkMaquina  :=0;
  LoadMaquina;
end;

procedure TfmEditMaquinaOperacao.cmdUpdateClick(Sender: TObject);
var IsNew:Boolean;
     I,Rc:Integer;
        S:String;
begin
  if cbMaquina.ItemIndex<0 Then
     begin
       if cbMaquina.CanFocus Then cbMaquina.SetFocus;
       MessageBox(Self.Handle,'A Máquina deve ser selecionada !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  IsNew       :=(FfkMaquina<1);
//  if ((IsNew)And(FslMaquinasOperacao<>Nil)And(FslMaquinasOperacao.IndexOf(cbMaquina.Items.Objects[cbMaquina.ItemIndex])>-1)) Then
  if FslMaquinasOperacao<>Nil Then
     begin
       if IsNew Then
          For I:=0 to FslMaquinasOperacao.Count-1 do
              if ((FslMaquinasOperacao[I]<>Nil)And(TRowData(FslMaquinasOperacao[I]).dbRow['fk_maquinas'].AsInteger=LongInt(cbMaquina.Items.Objects[cbMaquina.ItemIndex]))) Then
                  begin
                    MessageBox(Self.Handle,'Esta Máquina já foi cadastrada para esta operação !',PChar(Caption),MB_ICONSTOP);
                    Exit;
                  end;
       if chkflag_def.checked Then
          begin
            Rc:=IDCONTINUE;
            For I:=0 to FslMaquinasOperacao.Count-1 do
                if ((FslMaquinasOperacao[I]<>Nil)And
                    (TRowData(FslMaquinasOperacao[I]).dbRow['fk_maquinas'].AsInteger<>LongInt(cbMaquina.Items.Objects[cbMaquina.ItemIndex]))And
                    (TRowData(FslMaquinasOperacao[I]).dbRow['flag_def'].AsInteger<>0)) Then
                    begin
                      if Rc=IDCONTINUE Then
                         begin
                           S:='Já existe outra máquina definida como padrão ('+TRowData(FslMaquinasOperacao[I]).dbRow['dsc_maq'].AsString+')'+#13#10+
                              'Deseja alterar a máquina padrão para a atual ?';
                           Rc:=MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONQUESTION Or MB_YESNOCANCEL);
                           case Rc of
                                IDCANCEL:Exit;
                                IDNO    :begin
                                           chkflag_def.Checked:=False;
                                           Break;
                                         end;
                           end;
                         end;
                      TRowData(FslMaquinasOperacao[I]).dbRow['flag_def'].AsInteger:=0;
                      TRowData(FslMaquinasOperacao[I]).Node.CheckState:=csUnCheckedNormal;
                    end;
          end;
     end;
  FfkMaquina  :=LongInt(cbMaquina.Items.Objects[cbMaquina.ItemIndex]);
  if IsNew Then
     if Assigned(FOnInsertMaquina) Then
        FOnInsertMaquina(Self,FfkMaquina,cbMaquina.Text,edTmp_Stp.Value,edTmp_Oper.Value,chkFLAG_DEF.Checked)
     else
  else
     if Assigned(FOnUpdateMaquina) Then
        FOnUpdateMaquina(Self,FfkMaquina,cbMaquina.Text,edTmp_Stp.Value,edTmp_Oper.Value,chkFLAG_DEF.Checked);
  EnableControls;
end;

function TfmEditMaquinaOperacao.GetIsDefault: Boolean;
begin
  Result:=chkFLAG_DEF.Checked;
end;

function TfmEditMaquinaOperacao.GetTmpOper: Double;
begin
  Result:=edTmp_Oper.Value;
end;

function TfmEditMaquinaOperacao.GetTmpStp: Double;
begin
  Result:=edTmp_Stp.Value;
end;

procedure TfmEditMaquinaOperacao.FormShow(Sender: TObject);
begin
  LoadMaquina;
end;

procedure TfmEditMaquinaOperacao.edCOD_REFKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=vk_Return Then
     if Assigned(cmdSearch.OnClick) Then cmdSearch.OnClick(Self);
end;

procedure TfmEditMaquinaOperacao.cmdSearchClick(Sender: TObject);
var Ix,afkMaquinas : Integer;
begin
  if Not((cbMaquina.Enabled)And(cmdSearch.Visible)) Then Exit;
  edCOD_REF.Text:=Trim(edCOD_REF.Text);
  if edCOD_REF.Text='' Then Exit;
  with dmFichaTecnica.qrReferenciaMaquina do
       try
         ParamByName('cod_ref').AsString    := edCOD_REF.Text;
         Open;
         if EOF Then Exit;
         afkMaquinas:=FieldByName('pk_maquinas').AsInteger;
       finally
         Close;
       end;
  Ix:=cbMaquina.Items.IndexOfObject(TObject(afkMaquinas));
  if Ix<0 Then Exit;
  cbMaquina.ItemIndex:=Ix;
  if Assigned(cbMaquina.OnClick) Then cbMaquina.OnClick(Self);
end;

end.
