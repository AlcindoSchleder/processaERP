unit EditPeca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Mask, ToolEdit, CurrEdit, StdCtrls, ExtCtrls;

type
  TUpdateComponenteEvent=procedure (Sender:TObject;afkPeca,afkFichaTecnica,afkPecaMontagem,afkFichaTecnicaMontagem:Integer;aDescPecaMontagem:String) of object;
  TfmEditPeca = class(TForm)
    Label2: TLabel;
    edQTD_PEC: TCurrencyEdit;
    cbSecoes: TComboBox;
    lFk_Secoes: TLabel;
    cbGrupos: TComboBox;
    lFk_Grupos: TLabel;
    cbSubGrupos: TComboBox;
    Label1: TLabel;
    cbPecas: TComboBox;
    Label3: TLabel;
    Shape1: TShape;
    laPecaPaiTitle: TLabel;
    laPecaPai: TLabel;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    cmdNew: TBitBtn;
    chkAtiva: TCheckBox;
    edQTD_GER: TCurrencyEdit;
    Label4: TLabel;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbSecoesClick(Sender: TObject);
    procedure cbGruposClick(Sender: TObject);
    procedure cbSubGruposClick(Sender: TObject);
    procedure cmdUpdateClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edQTD_PECChange(Sender: TObject);
    procedure edQTD_GERChange(Sender: TObject);
  private
    { Private declarations }
    FfkPecaMontagem       : Integer;
    FfkPeca               : Integer;
    FfkFichaTecnica       : Integer;
    FfkFichaTecnicaMontagem:Integer;
    FUpdateAllowed,
    FPecaMontagemUpdated  : Boolean;
    FLastfkPecaMontagem   : Integer;
    FOnInsertComponente   : TUpdateComponenteEvent;
    FOnUpdateComponente   : TUpdateComponenteEvent;
    FslParents            : TList;
    FslPecas              : TStringList;
    FfkFichaTecnicaMontagerm: Integer;
    procedure LoadSecoes;
    procedure LoadGrupos(fkGrupoToSelect:Integer=-1);
    procedure LoadSubGrupos(fkSubGrupoToSelect:Integer=-1);
    procedure ClearPecas;
    procedure LoadPecas(fkPecaToSelect:Integer=-1);
    procedure ClearPeca;
    procedure LoadPeca;
    procedure SetfkPecaMontagem(const Value: Integer);
    procedure EnableControls(MustEnable:Boolean);
  public
    { Public declarations }                                  // 0 insumo 1 peca 2 Estrutura 3 ProdutoLista 4 ProdutoAcabado 5 Servico
    property fkPeca:Integer read FfkPeca write FfkPeca;
    property fkFichaTecnica:Integer read FfkFichaTecnica write FfkFichaTecnica;
    property fkPecaMontagem:Integer read FfkPecaMontagem write SetfkPecaMontagem;
    property fkFichaTecnicaMontagem:Integer read FfkFichaTecnicaMontagerm write FfkFichaTecnicaMontagem;
    property LastfkPecaMontagem:Integer read FLastfkPecaMontagem;
    property PecaMontagemUpdated:Boolean read FPecaMontagemUpdated;
    property OnInsertComponente:TUpdateComponenteEvent read FOnInsertComponente write FOnInsertComponente;
    property OnUpdateComponente:TUpdateComponenteEvent read FOnUpdateComponente write FOnUpdateComponente;
    property UpdateAllowed:Boolean read FUpdateAllowed write FUpdateAllowed;
    property slParents:TList read FslParents;
  end;

var
  fmEditPeca: TfmEditPeca;

implementation

uses IBQuery, dbObjects, udmFichaTecnica;

{$R *.dfm}

procedure TfmEditPeca.EnableControls(MustEnable:Boolean);
begin
  cbSecoes.Enabled    :=MustEnable;
  cbGrupos.Enabled    :=MustEnable;
  cbSubGrupos.Enabled :=MustEnable;
  cbPecas.Enabled     :=MustEnable;
  edQTD_PEC.Enabled   :=((FfkPeca<>FfkPecaMontagem)And(FfkPeca>0)And(FUpdateAllowed));
  edQTD_GER.Enabled   :=edQTD_PEC.Enabled;
  //cmdUpdate.Visible   :=edQTD_PEC.Enabled;
  cmdNew.Visible      :=FUpdateAllowed;
  if cmdNew.Visible Then
     if cmdUpdate.Visible Then
        cmdNew.Left:=cmdUpdate.Left-cmdNew.Width-4
     else
        cmdNew.Left:=cmdCancel.Left-cmdNew.Width-4;
end;

procedure TfmEditPeca.ClearPeca;
begin
  laPecaPai.Caption   :='';
  edQTD_PEC.AsInteger :=1;
  edQTD_GER.AsInteger :=1;
  chkAtiva.Checked    :=False;
  chkAtiva.Visible    :=False;
  EnableControls(True);
end;

procedure TfmEditPeca.LoadPeca;
var S:String;
    I,
    Ix:Integer;
    aRow:TdbRow;
begin
  ClearPeca;
  S:='';
  try
    if FfkPeca<1 Then
       begin
         S:='Erro: A Peça "Pai" deve ser informada !';
         Exit;
       end;
    with dmFichaTecnica.qrPeca do
         try
           ParamByName('pk_pecas').AsInteger        :=FfkPeca;
           ParamByName('fk_ficha_tecnica').AsInteger:=FfkFichaTecnica;
           Open;
           if EOF Then
              begin
                S:='Erro: Peça "Pai" com pk_pecas='+IntToStr(FfkPeca)+' não foi encontrada !';
                Exit;
              end;
           laPecaPai.Caption:=FieldByName('COD_REF').AsString+' - '+FieldByName('DSC_PEC').AsString;
         finally
           Close;
         end;
    if FfkPecaMontagem<1 Then
       begin
         cmdUpdate.Caption:='&Incluir';
         Caption:='Novo SubComponente de '+laPecaPai.Caption;
         Exit;
       end;
    chkAtiva.Visible:=(FfkPeca=FfkPecaMontagem);
    cmdUpdate.Caption:='&Alterar';
    Caption:='Alteração';
    with dmFichaTecnica.qrPecaComponente do
         try
           ParamByName('fk_pecas').AsInteger                    :=FfkPeca;
           ParamByName('fk_ficha_tecnica').AsInteger            :=FfkFichaTecnica;
           ParamByName('fk_pecas_montagem').AsInteger           :=FfkPecaMontagem;
           ParamByName('fk_ficha_tecnica_montagem').AsInteger   :=FfkFichaTecnicaMontagem;
           Open;
           if EOF Then
              begin
                S:='Erro: Peça Componente com fk_pecas_montagem='+IntToStr(FfkPecaMontagem)+' não encontrada !';
                Exit;
              end;
           edQTD_PEC.AsInteger:=FieldByName('QTD_PEC').AsInteger;
           edQTD_GER.AsInteger:=FieldByName('QTD_GER').AsInteger;
         finally
           Close;
         end;
    if edQTD_PEC.AsInteger<1 Then edQTD_PEC.AsInteger:=1
    else if edQTD_PEC.ASInteger>1 Then edQTD_GER.AsInteger:=1;
    if edQTD_GER.AsInteger<1 Then edQTD_GER.AsInteger:=1
    else if edQTD_GER.AsInteger>1 Then edQTD_PEC.AsInteger:=1;
    with dmFichaTecnica.qrPeca do
         try
           ParamByName('pk_pecas').AsInteger:=FfkPecaMontagem;
           ParamByName('fk_ficha_tecnica').AsInteger:=FfkFichaTecnicaMontagem;
           Open;
           if EOF Then
              begin
                S:='Erro: Peça com chave='+IntToStr(FfkPecaMontagem)+' não encontrada !';
                Exit;
              end;
           Ix:=cbSecoes.Items.IndexOfObject(TObject(FieldByName('fk_secoes').AsInteger));
           if Ix<0 Then
              begin
                S:='Seção com chave='+IntToStr(FieldByName('fk_secoes').AsInteger)+' da peça "'+FieldByName('DSC_PEC').AsString+'" não foi encontrada !';
                Exit;
              end;
           cbSecoes.ItemIndex:=Ix;
           if Assigned(cbSecoes.OnClick) Then cbSecoes.OnClick(Self);
           cbSecoes.Enabled:=False;
           Ix:=cbGrupos.Items.IndexOfObject(TObject(FieldByName('fk_grupos').AsInteger));
           if Ix<0 Then
              begin
                S:='Grupo com chave='+IntToStr(FieldByName('fk_grupos').AsInteger)+' da peça "'+FieldByName('DSC_PEC').AsString+'" não foi encontrada !';
                Exit;
              end;
           cbGrupos.ItemIndex:=Ix;
           if Assigned(cbGrupos.OnClick) Then cbGrupos.OnClick(Self);
           cbGrupos.Enabled:=False;
           Ix:=cbSubGrupos.Items.IndexOfObject(TObject(FieldByName('fk_subgrupos').AsInteger));
           if Ix<0 Then
              begin
                S:='SubGrupo com chave='+IntToStr(FieldByName('fk_subgrupos').AsInteger)+' da peça "'+FieldByName('DSC_PEC').AsString+'" não foi encontrada !';
                Exit;
              end;
           cbSubGrupos.ItemIndex:=Ix;
           if Assigned(cbSubGrupos.OnClick) Then cbSubGrupos.OnClick(Self);
           cbSubGrupos.Enabled:=False;
           Ix:=-1;
           For I:=0 to cbPecas.Items.Count-1 do
               begin
                 aRow:=TdbRow(cbPecas.Items.Objects[I]);
                 if ((aRow<>Nil)And(aRow['pk_pecas'].AsInteger=FieldByName('pk_pecas').AsInteger)) Then
                    begin
                      Ix:=I;
                      break;
                    end;
               end;
           //Ix:=cbPecas.Items.IndexOfObject(TObject(FieldByName('pk_pecas').AsInteger));
           if Ix<0 Then
              begin
                S:='Peça Componente com chave='+IntToStr(FieldByName('pk_pecas').AsInteger)+' ('+FieldByName('DSC_PEC').AsString+') não encontrada no SubGrupo "'+cbSubGrupos.Text+'" !';
                Exit;
              end;
           cbPecas.ItemIndex:=Ix;
           chkAtiva.Checked:=(FieldByName('FLAG_ATV').AsInteger=1);
           if Assigned(cbPecas.OnClick) Then cbPecas.OnClick(Self);
           cbPecas.Enabled:=False;
         finally
           Close;
         end;
    EnableControls(False);
    if FfkPeca=FfkPecaMontagem Then
       Caption:=laPecaPai.Caption+' - Alteração'
    else
       Caption:='SubComponente '+cbPecas.Text+' - Alteração';
  finally
    if S<>'' Then
       begin
         MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONSTOP);
         PostMessage(Self.Handle,WM_CLOSE,0,0);
       end;
  end;
end;

procedure TfmEditPeca.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmEditPeca.LoadSecoes;
var S:String;
begin
  cbPecas.Items.Clear;
  cbSubGrupos.Items.Clear;
  cbGrupos.Items.Clear;
  cbSecoes.Items.Clear;
  with dmFichaTecnica.qrSecoes do
  try
    S:=Sql.Text;
    Sql.Insert(Sql.Count-1,'Where FLAG_TMAT=1');
    Open;
    while not(EOF) do
    begin
      cbSecoes.Items.AddObject(FieldByName('DSC_SEC').AsString,
        TObject(FieldByName('PK_SECOES').AsInteger));
      Next;
    end;
  finally
    Close;
    Sql.Text:=S;
  end;
end;

procedure TfmEditPeca.LoadGrupos(fkGrupoToSelect:Integer=-1);
var Ix,IxToSelect:Integer;
begin
  cbPecas.Items.Clear;
  cbSubGrupos.Items.Clear;
  cbGrupos.Items.Clear;
  if cbSecoes.ItemIndex<0 Then Exit;
  IxToSelect:=0;
  with dmFichaTecnica.qrGrupos do
  try
    ParamByName('fk_secoes').AsInteger:=LongInt(cbSecoes.Items.Objects[cbSecoes.ItemIndex]);
    Open;
    while not(EOF) do
    begin
      Ix:=cbGrupos.Items.AddObject(FieldByName('DSC_GRU').AsString,
        TObject(FieldByName('PK_GRUPOS').AsInteger));
      if FieldByName('PK_GRUPOS').AsInteger=fkGrupoToSelect Then IxToSelect:=Ix;
      Next;
    end;
  finally
    Close;
  end;
  if IxToSelect<cbGrupos.Items.Count Then
     begin
       cbGrupos.ItemIndex:=IxToSelect;
       if Assigned(cbGrupos.OnClick) Then cbGrupos.OnClick(Self);
     end;
end;

procedure TfmEditPeca.LoadSubGrupos(fkSubGrupoToSelect:Integer=-1);
var Ix,IxToSelect:Integer;
begin
  cbPecas.Items.Clear;
  cbSubGrupos.Items.Clear;
  if ((cbSecoes.ItemIndex<0)And(cbGrupos.ItemIndex<0)) Then Exit;
  IxToSelect:=0;
  with dmFichaTecnica.qrSubGrupos do
  try
    ParamByName('fk_secoes').AsInteger:=LongInt(cbSecoes.Items.Objects[cbSecoes.ItemIndex]);
    ParamByName('fk_grupos').AsInteger:=LongInt(cbGrupos.Items.Objects[cbGrupos.ItemIndex]);
    Open;
    while not(EOF) do
    begin
      Ix:=cbSubGrupos.Items.AddObject(FieldByName('DSC_SGRU').AsString,
        TObject(FieldByName('PK_SUBGRUPOS').AsInteger));
      if FieldByName('PK_SUBGRUPOS').AsInteger=fkSubGrupoToSelect Then IxToSelect:=Ix;
      Next;
    end;
  finally
    Close;
  end;
  if IxToSelect<cbSubGrupos.Items.Count Then
     begin
       cbSubGrupos.ItemIndex:=IxToSelect;
       if Assigned(cbSubGrupos.OnClick) Then cbSubGrupos.OnClick(Self);
     end;
end;

procedure TfmEditPeca.ClearPecas;
var I:Integer;
    aRow:TdbRow;
begin
  FslPecas.Clear;
  if cbPecas.Items.Count<1 Then Exit;
  For I:=0 to cbPecas.Items.Count-1 do
      begin
        aRow:=TdbRow(cbPecas.Items.Objects[I]);
        if aRow<>Nil Then
           begin
             aRow.Free;
             cbPecas.Items.Objects[I]:=Nil;
           end;
      end;
  cbPecas.Items.Clear;
end;

procedure TfmEditPeca.LoadPecas(fkPecaToSelect:Integer=-1);
var Ix,
    afkSecoes,
    afkGrupos,
    afkSubGrupos,
    I,
    IxToSelect:Integer;
    aRow:TdbRow;
begin
  ClearPecas;
  if ((cbSecoes.ItemIndex<0)And(cbGrupos.ItemIndex<0)Or(cbSubGrupos.ItemIndex<0)) Then Exit;
  afkSecoes     :=LongInt(cbSecoes.Items.Objects[cbSecoes.ItemIndex]);
  afkGrupos     :=LongInt(cbGrupos.Items.Objects[cbGrupos.ItemIndex]);
  afkSubGrupos  :=LongInt(cbSubGrupos.Items.Objects[cbSubGrupos.ItemIndex]);
  IxToSelect:=0;
  FslPecas.Clear;
  with dmFichaTecnica.qrPecasAtivas do
  try
    ParamByName('fk_secoes').AsInteger      :=afkSecoes;
    ParamByName('fk_grupos').AsInteger      :=afkGrupos;
    ParamByName('fk_subgrupos').AsInteger   :=afkSubGrupos;
    if FfkPeca=FfkPecaMontagem Then
       ParamByName('fk_pecas').AsInteger:=FfkPeca
    else ParamByName('fk_pecas').AsInteger:=0;
    Open;
    while not(EOF) do
    begin
      aRow:=TdbRow.CreateFromDs(dmFichaTecnica.qrPecasAtivas,True);
      FslPecas.AddObject(Format('%-20s',[FieldByName('COD_REF').AsString]),aRow);
      Next;
    end;
  finally
    Close;
  end;
  FslPecas.Sort;
  For I:=0 to FslPecas.Count-1 do
      begin
        aRow:=TdbRow(FslPecas.Objects[I]);
        Ix:=cbPecas.Items.AddObject(aRow['COD_REF'].AsString+' - '+aRow['DSC_PEC'].AsString,aRow);
        if aRow['PK_PECAS'].AsInteger=fkPecaToSelect Then IxToSelect:=Ix;
      end;
  if IxToSelect<cbPecas.Items.Count Then
     begin
       cbPecas.ItemIndex:=IxToSelect;
       if Assigned(cbPecas.OnClick) Then cbPecas.OnClick(Self);
     end;
end;

procedure TfmEditPeca.FormCreate(Sender: TObject);
begin
  FslParents:=TList.Create;
  FslPecas  :=TStringList.Create;
  LoadSecoes;
end;

procedure TfmEditPeca.cbSecoesClick(Sender: TObject);
begin
  LoadGrupos;
end;

procedure TfmEditPeca.cbGruposClick(Sender: TObject);
begin
  LoadSubGrupos;
end;

procedure TfmEditPeca.cbSubGruposClick(Sender: TObject);
begin
  LoadPecas;
end;

procedure TfmEditPeca.cmdUpdateClick(Sender: TObject);
var afkPecaMontagem,
    fkFichaAtiva,
    MajVer,MinVer,
    afkFichaTecnicaMontagem :Integer;
    IsInclusao:Boolean;
    aQuery:TIBQuery;
    aRow:TdbRow;
    S:String;
begin
  if edQTD_PEC.AsInteger<1 Then
     begin
       if edQTD_PEC.CanFocus Then edQTD_PEC.SetFocus;
       MessageBox(Self.Handle,'A Quantidade de Peças deve ser informada !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if edQTD_GER.AsInteger<1 Then edQTD_GER.AsInteger:=1
  else
     if edQTD_GER.AsInteger>1 Then edQTD_PEC.AsInteger:=1;
  if cbPecas.ItemIndex<0 Then
     begin
       if cbPecas.CanFocus Then cbPecas.SetFocus;
       MessageBox(Self.Handle,'A Peça deve ser selecionada !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  aRow:=TdbRow(cbPecas.Items.Objects[cbPecas.ItemIndex]);
  if aRow=Nil Then Exit;
  afkPecaMontagem:=aRow['pk_pecas'].AsInteger;
  afkFichaTecnicaMontagem:=aRow['fk_ficha_tecnica'].AsInteger;
  if FfkPeca=FfkPecaMontagem Then
     begin
       if chkAtiva.Checked Then
          begin
            fkFichaAtiva:=0;
            with dmFichaTecnica.qrCheckFichaAtiva do
                 try
                   ParamByName('fk_pecas').AsInteger            :=FfkPeca;
                   Open;
                   if Not(EOF) Then
                      begin
                        fkFichaAtiva:=FieldByName('pk_ficha_tecnica').AsInteger;
                        MajVer:=FieldByName('maj_ver').AsInteger;
                        MinVer:=FieldByName('min_ver').AsInteger;
                      end;
                 finally
                   Close;
                 end;
            if ((fkFichaAtiva<>FfkFichaTecnica)And(fkFichaAtiva>0)) Then
               begin
                 S:='Já existe outra ficha técnica (versão '+IntToStr(MajVer)+'.'+IntToStr(MinVer)+') ativa para esta peça !';
                 MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONSTOP);
                 Exit;
               end;
          end;
       with dmFichaTecnica.qrUpdateFlagAtvFichaTecnica do
            try
              ParamByName('fk_pecas').AsInteger            :=FfkPeca;
              ParamByName('pk_ficha_tecnica').AsInteger    :=FfkFichaTecnica;
              ParamByName('flag_atv').AsInteger            :=Integer(chkAtiva.Checked);
              ExecSql;
            finally
              Close;
            end;
       if Assigned(FOnUpdateComponente) Then FOnUpdateComponente(Self,FfkPeca,FfkFichaTecnica,FfkPecaMontagem,FfkFichaTecnicaMontagem,cbPecas.Items[cbPecas.ItemIndex]);
       MessageBox(Self.Handle,'Ficha Técnica Alterada',PChar(Caption),MB_ICONINFORMATION);
       Exit;
     end;
  if FfkPeca=afkPecaMontagem Then
     begin
       MessageBox(Self.Handle,'Erro: Uma peça não pode ser SubComponente de si própria !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if FslParents.IndexOf(TObject(afkPecaMontagem))>-1 Then
     begin
       MessageBox(Self.Handle,'Erro: Esta peça já está cadastrada em um nível superior da hierarquia de componentes !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  IsInclusao:=(FfkPecaMontagem<1);
  if FfkPecaMontagem<1 Then
     begin
       if dmFichaTecnica.PecaIsParentOf(afkPecaMontagem,FfkPeca) Then
          begin
            S:='Erro: Esta peça ('+cbPecas.Text+') já usa "'+laPecaPai.Caption+'" como sub-componente em sua ficha técnica !';
            MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONSTOP);
            Exit;
          end;
       aQuery:=dmFichaTecnica.qrInsertPecaComponente;
       with dmFichaTecnica.qrPecaComponente do
            try
              ParamByName('fk_pecas').AsInteger                   :=Ffkpeca;
              ParamByName('fk_ficha_tecnica').AsInteger           :=FfkFichaTecnica;
              ParamByName('fk_pecas_montagem').AsInteger          :=afkpecamontagem;
              ParamByName('fk_ficha_tecnica_montagem').AsInteger  :=afkFichaTecnicaMontagem;
              Open;
              if Not(EOF) Then
                 begin
                   S:='Erro: Esta Peça já foi cadastrada como sub-componente de "'+laPecaPai.Caption+' !';
                   MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONSTOP);
                   Exit;
                 end;
            finally
              Close;
            end;
     end
  else aQuery:=dmFichaTecnica.qrUpdatePecaComponente;
  with aQuery do
       try
         ParamByName('fk_pecas').AsInteger                   :=Ffkpeca;
         ParamByName('fk_ficha_tecnica').AsInteger           :=FfkFichaTecnica;
         ParamByName('fk_pecas_montagem').AsInteger          :=afkpecamontagem;
         ParamByName('fk_ficha_tecnica_montagem').AsInteger  :=afkFichaTecnicaMontagem;
         ParamByName('qtd_pec').AsInteger                    :=edQTD_PEC.AsInteger;
         ParamByName('qtd_ger').AsInteger                    :=edQTD_GER.AsInteger;
         ExecSql;
       finally
         Close;
       end;
  FfkPecaMontagem:=afkPecaMontagem;
  FfkFichaTecnicaMontagem:=afkFichaTecnicaMontagem;
  if IsInclusao Then
     begin
       MessageBox(Self.Handle,'Componente Incluído com sucesso !',PChar(Caption),MB_ICONINFORMATION);
       if Assigned(FOnInsertComponente) Then FOnInsertComponente(Self,FfkPeca,FfkFichaTecnica,FfkPecaMontagem,FfkFichaTecnicaMontagem,cbPecas.Items[cbPecas.ItemIndex]);
     end
  else
     begin
       MessageBox(Self.Handle,'Componente Alterado com sucesso !',PChar(Caption),MB_ICONINFORMATION);
       if Assigned(FOnUpdateComponente) Then FOnUpdateComponente(Self,FfkPeca,FfkFichaTecnica,FfkPecaMontagem,FfkFichaTecnicaMontagem,cbPecas.Items[cbPecas.ItemIndex]);
     end;
  if dmFichaTecnica.tr.InTransaction then
    dmFichaTecnica.tr.Commit;
  FPecaMontagemUpdated:=True;
  FLastfkPecaMontagem:=afkPecaMontagem;
  EnableControls(False);
  cmdUpdate.Caption:='&Gravar';
  if FfkPeca=FfkPecaMontagem Then
     Caption:=laPecaPai.Caption+' - Alteração'
  else
    Caption:='SubComponente '+cbPecas.Text+' - Alteração';
end;

procedure TfmEditPeca.SetfkPecaMontagem(const Value: Integer);
begin
  FfkPecaMontagem := Value;
  LoadPeca;
end;

procedure TfmEditPeca.cmdNewClick(Sender: TObject);
begin
  fkPecaMontagem:=0;
end;

procedure TfmEditPeca.FormDestroy(Sender: TObject);
begin
  ClearPecas;
  FslParents.Free;
  FslParents:=Nil;
  FslPecas.Free;
  FslPecas:=Nil;
end;

procedure TfmEditPeca.edQTD_PECChange(Sender: TObject);
begin
  if edQTD_PEC.AsInteger>1 Then edQTD_GER.AsInteger:=1
  else if edQTD_PEC.AsInteger<1 Then edQTD_PEC.AsInteger:=1;
end;

procedure TfmEditPeca.edQTD_GERChange(Sender: TObject);
begin
  if edQTD_GER.AsInteger>1 Then edQTD_PEC.AsInteger:=1
  else if edQTD_GER.AsInteger<1 Then edQTD_GER.AsInteger:=1;
end;

end.
