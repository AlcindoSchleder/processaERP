var
  APkTabelaPrecos : Integer;
  ADtaTabPrice    : TDate;
  APkLinhas       : Integer;
  APkProduto      : Integer;
  AShowGroup      : Boolean;
  ADefault        : Boolean;
  ALine           : string;

procedure ParamDlgOnActivate(Sender: TfrxComponent);
begin
  with ParamDlg, Engine do
  begin
    qrTabelas.Open;
    while not qrTabelas.EOF do
    begin
      eFkTabelaPrecos.Items.AddObject(<qrTabelas."DSC TAB">,
        TObject(<qrTabelas."PK TABELA PRECOS">));
      qrTabelas.Next;
    end;
    qrTabelas.Close;
    qrLinhas.Open;
    while not qrLinhas.EOF do
    begin
      eFkLinhas.Items.AddObject(<qrLinhas."DSC_LIN">,
        TObject(<qrLinhas."PK LINHAS">));
      qrLinhas.Next;
    end;
    qrLinhas.Close;
    cbShowGroup.Checked := False;
    rbDefault.Checked   := True;
  end
end;

procedure sbOkOnClick(Sender: TfrxComponent);
begin
  with sbOk, Engine do
  begin
    if rbDefault.Checked then
    begin
      if qrReport.Active then qrReport.Close;
      qrReport.SQL.Add(' order by Lin.DSC_LIN, Pcd.PK_PRODUTOS_CODIGOS, Prd.DSC_PROD ');
      if not qrReport.Active then qrReport.Open;
    end;
    if rbGrouped.Checked then
    begin
      if qrReport.Active then qrReport.Close;
      qrReport.SQL.Add(' order by Lin.DSC_LIN, Gru.DSC_GRU, Sgr.DSC_SGRU, ' +
        'Pcd.PK_PRODUTOS_CODIGOS, Prd.DSC_PROD');
      if not qrReport.Active then qrReport.Open;
    end;
  end;
  AShowGroup           := cbShowGroup.Checked;
  ADefault             := rbDefault.Checked;
  ParamDlg.ModalResult := mrOk;
end;

procedure bMasterOnBeforePrint(Sender: TfrxComponent);
begin
  with bMaster, Engine do
  begin
    if qrConfigs.Active then qrConfigs.Close;
    APkProduto := <qrReport."PK_PRODUTOS">;
    if not qrConfigs.Active then qrConfigs.Open;
  end;
end;

procedure bGroupHeaderOnBeforePrint(Sender: TfrxComponent);
begin
  with bGroupHeader, Engine do
  begin
    Visible := cbShowGroup.Checked;
  end
end;

procedure gLineOnBeforePrint(Sender: TfrxComponent);
begin
  with gLine, Engine do
  begin
    if ALine <> <qrReport."DSC_LIN"> then
      NewPage;
    ALine := <qrReport."DSC_LIN">;
  end
end;

procedure Page2OnBeforePrint(Sender: TfrxComponent);
begin
  ALine := '';
end;

procedure sbCancelOnClick(Sender: TfrxComponent);
begin
  ParamDlg.ModalResult := mrOk;
end;

procedure eFkTabelaPrecosOnChange(Sender: TfrxComponent);
var
  i: Integer;
begin
  i := eFkTabelaPrecos.ItemIndex;
  if (i > -1) and (eFkTabelaPrecos.Items.Count > i) then
    APkTabelaPrecos := <LongInt(eFkTabelaPrecos.Items.Objects[i])>;
end;

procedure eFkLinhasOnChange(Sender: TfrxComponent);
var
  i: Integer;
begin
  i := eFkTabelaPrecos.ItemIndex;
  if (i > -1) and (eFkLinhas.Items.Count > i) then
    APkLinhas := <LongInt(eFkLinhas.Items.Objects[i])>;
end;

begin

end.
