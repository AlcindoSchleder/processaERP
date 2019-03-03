var
  APkSecoes      : Integer;
  APkGrupos      : Integer;
  APkSubGrupos   : Integer;
  APkTabelaPrecos: Integer;

procedure dlgParamOnActivate(Sender: TfrxComponent);
begin
  if not qrSecoes.Active then qrSecoes.Open;
  while not qrSecoes.Eof do
  begin
    eFkSecoes.Items.Add(qrSecoes.FieldByName('PK_SECOES').AsString + '=' +
                        qrSecoes.FieldByName('DSC_SEC').AsString);
    qrSecoes.Next;
  end;
  if qrSecoes.Active then qrSecoes.Close;
  if not qrTabelaPrecos.Active then qrTabelaPrecos.Open;
  while not qrTabelaPrecos.Eof do
  begin
    eFkTabelaPrecos.Items.Add(qrTabelaPrecos.FieldByName('PK_TABELA_PRECOS').AsString + '=' +
                        qrTabelaPrecos.FieldByName('DSC_TAB').AsString);
    qrTabelaPrecos.Next;
  end;
  if qrTabelaPrecos.Active then qrTabelaPrecos.Close;
end;

procedure eFkSecoesOnChange(Sender: TfrxComponent);
var
  i: Integer;
begin
  i := eFkSecoes.ItemIndex;
  if i = -1 then exit;
  try
    APkSecoes := StrToInt(eFkSecoes.Items.Names[i]);
    qrGrupos.ParamByName('FkSecoes').Value := APkSecoes;
    if not qrGrupos.Active then qrGrupos.Open;
    while not qrGrupos.EOF do
    begin
      eFkGrupos.Items.Add(qrGrupos.FieldByName('PK_GRUPOS').AsString + '=' +
                          qrGrupos.FieldByName('DSC_GRU').AsString);
      qrGrupos.Next;
    end;
  finally
    if qrGrupos.Active then qrGrupos.Close;
  end;
end;

procedure eFkGruposOnChange(Sender: TfrxComponent);
var
  i: Integer;
begin
  i := eFkGrupos.ItemIndex;
  if (i = -1) or (APkSecoes = 0) then exit;
  try
    APkGrupos := StrToInt(eFkGrupos.Items.Names[i]);
    qrSubGrupos.ParamByName('FkSecoes').Value := APkSecoes;
    qrSubGrupos.ParamByName('FkGrupos').Value := APkGrupos;
    if not qrSubGrupos.Active then qrSubGrupos.Open;
    while not qrSubGrupos.EOF do
    begin
      eFkSubGrupos.Items.Add(qrSubGrupos.FieldByName('PK_SUBGRUPOS').AsString + '=' +
                             qrSubGrupos.FieldByName('DSC_SGRU').AsString);
      qrSubGrupos.Next;
    end;
  finally
    if qrSubGrupos.Active then qrSubGrupos.Close;
  end;
end;

procedure eFkSubGruposOnChange(Sender: TfrxComponent);
var
  i: Integer;
begin
  i := eFkSubGrupos.ItemIndex;
  if (i = -1) or (APkSecoes = 0) or (APkGrupos = 0) then exit;
  APkSubGrupos := StrToInt(eFkSubGrupos.Items.Names[i]);
end;

procedure eFkTabelaPrecosOnChange(Sender: TfrxComponent);
var
  i: Integer;
begin
  i := eFkSubGrupos.ItemIndex;
  if (i = -1) then exit;
  APkTabelaPrecos := StrToInt(eFkTabelaPrecos.Items.Names[i]);
end;

procedure sbCancelOnClick(Sender: TfrxComponent);
begin
  dlgParam.ModalResult := mrCancel;
end;

procedure sbPrintOnClick(Sender: TfrxComponent);
begin
  if APkTabelaPrecos = 0 then
    if MessageDlg('Atenção: Você deve selecionar uma Tabela de Preços. ' +
        'Deseja Retornar?', mtInformation, [mbYes, mbNo], 0) = mrYes then
      exit
    else
      dlgParam.ModalResult := mrCancel;

  dlgParam.ModalResult := True;
end;

begin

end.
