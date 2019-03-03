unit FuncoesDB;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 10/04/2003 - DD/MM/YYYY                                      *}
{* Modified: 10/04/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.3.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for datails                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses Classes, SysUtils, DB, Encryp, VirtualTrees, jpeg, Funcoes, ProcType,
  DataManager, GridRow, ProcUtils,
  {$IFNDEF LINUX}
    Windows, Forms, Dialogs, ExtCtrls, ExtDlgs, Graphics
  {$ELSE}
    Qt, QForms, QDialogs, QExtCtrls, QExtDlgs, QGraphics
  {$ENDIF};

type
  TTypePk = (tpGenerator, tpSql);

  function  AutenticaSys(Sender: TComponent): Boolean;
  function  AchaNivel(AMenuData: TMenuData): TOperationLevel;
{$IFDEF WIN32}
  function  ProgramVersion: string ;
{$ENDIF}
  function  CriptoGrafaSenha(Campo, Senha: string; Acao: TActionType): string;
  function  Ordenar(Tabela: TDataSet; StrSql: string): Boolean;
  procedure GetImage_FromStream(ABlob: TBlobField; var AImage: TImage); overload;
  procedure GetImage_FromStream(ABlob: TBlobField; var AImage: TPicture); overload;
  function  FillVirtualTreeView(Tree: TVirtualStringTree; Table: TDataSet;
    const Sql: string = '';  AClass: TClass = nil; const MayInsert: Boolean = False;
    const AClear: Boolean = True; const ColSort: Integer = -1): Boolean;
  procedure ReleaseTreeNodes(vtTree: TVirtualStringTree);
  function  CalcTreeLinePos(const vtTree: TVirtualStringTree; const Node: PVirtualNode;
    const Column: TColumnIndex; const ClientHeight: Integer): TPoint;
  function  GetNumericStrings(AType: TFieldType): Boolean;
  function  GetStringField(AType: TFieldType): Boolean;
  function  GetDateField(AType: TFieldType): Boolean;
  function  GetPkTable(ATable: TDataSet; AGenName: string; ATypePK: TTypePK;
    ASql: string = ''): Integer;
  function  ClearIdent(Ident: Pointer): Pointer;
  function  QtdRegistros(SqlMain: TStrings; Nome, Prefix: string;
    SqlFrom: Boolean; Params: array of Variant): Integer;
  function  CountRegister(SqlMain: TStrings; Params: array of Variant): Integer;
  function  GetTypedReference(Secao, Grupo, SubGrupo: Integer): string;
  function  SelectImageFromFile(ABlob: TBlobField; AImage: TImage;
              ImgDef: string = 'jpg'): Integer; overload;
  function  SelectImageFromFile(var AStream: TStream; AImage: TImage;
              ImgDef: string = 'jpg'): Integer; overload;

implementation

uses Dado, SqlComm, CmmConst, Types;

{$IFDEF WIN32}
  function  ProgramVersion: string;
  var
    Tamanho,
    TamanhoVersao,
    Nada:         Cardinal;
    NomePrograma,
    DadosStr:     PAnsiChar;
    Versao:       PVSFixedFileInfo;
    Informacao:   Array[0..1] of Char;
  begin
     Result       := '' ;
     NomePrograma := StrAlloc(Length(Application.ExeName) + 1);
     StrPCopy(NomePrograma, Application.ExeName);
     Tamanho      := GetFileVersionInfoSize(NomePrograma, Nada);
     if Tamanho <> 0 then
     begin
       DadosStr := StrAlloc(Tamanho + 1);
       if GetFileVersionInfo(NomePrograma, 0, Tamanho, DadosStr) then
       begin
         StrPCopy(Informacao, '\');
         if VerQueryValue(DadosStr, Informacao, Pointer(Versao), TamanhoVersao) then
         begin
           with Dados do
           begin
             Parametros.soMajorVer   := ((Versao.dwFileVersionMS And $FFFF0000) Shr $10);
             Parametros.soMinorVer   := (Versao.dwFileVersionMS And $0000FFFF);
             Parametros.soReleaseVer := ((Versao.dwFileVersionLS And $FFFF0000) Shr $10);
             Parametros.soBuildVer   := (Versao.dwFileVersionLS And $0000FFFF) ;
           end;
           Result := Concat(IntToStr((Versao.dwFileVersionMS And $FFFF0000) Shr $10),
             '.', IntToStr((Versao.dwFileVersionMS And $0000FFFF)), '.',
             IntToStr((Versao.dwFileVersionLS And $FFFF0000) Shr $10), '.',
             IntToStr((Versao.dwFileVersionLS And $0000FFFF)));
           Dados.Parametros.soVersion := Result;
         end
       end;
       StrDispose(DadosStr);
     end;
     StrDispose(NomePrograma);
  end;
{$ENDIF}

function  QtdRegistros(SqlMain: TStrings; Nome, Prefix: string;
  SqlFrom: Boolean; Params: array of Variant): Integer;
var
  SqlWhere, SqlxFrom, Propt: Boolean;
  i, w, g, p: Integer;
  StrAux1, StrAux2: string;
  sSqlAux: TStrings;
begin
  Result   := 0;
  Propt    := SqlFrom;
  SqlxFrom := False;
  SqlWhere := False;
  sSqlAux   := TStringList.Create;
  with Dados do
  begin
    if (Nome <> '') then
    begin
      if Propt then
        sSqlAux.Add(GlobalSelectCount)
      else
        sSqlAux.Add(GlobalSelectCountF + Nome + ' ' + Prefix);
      for i := 0 to SQLMain.Count - 1 do
      begin
        StrAux1 := SQLMain.Strings[i];
        if Propt then
        begin
          p  := PosPalavra('FROM', StrAux1);
          if p > 0 then SqlxFrom := True;
          if SqlxFrom then
          begin
            StrAux2 := Copy(StrAux1, p, (Length(StrAux1) - p) + 1);
            w := PosPalavra('WHERE', StrAux1);
            g := PosPalavra('GROUP', StrAux2);
            p := PosPalavra('ORDER', StrAux2);
            if (w = 0) and (g = 0) and (p = 0) then
            begin
              if Trim(StrAux2) <> '' then
                sSqlAux.Add(StrAux2);
            end
            else
            begin
              if (w > 0) and (w < g) then
              begin
                w := g;
                if (w > 0) and (w < p) then w := p;
              end;
              StrAux2 := Copy(StrAux2, 1, w - 1);
              if Trim(StrAux2) <> '' then
                sSqlAux.Add(StrAux2);
              SqlxFrom := False;
              Propt  := False;
            end;
          end;
        end;
        p := PosPalavra('WHERE', StrAux1);
        if p > 0 then sqlWhere := True;
        if SqlWhere then
        begin
          StrAux2 := Copy(StrAux1, p, (Length(StrAux1) - p) + 1);
          g := PosPalavra('GROUP', StrAux2);
          p := PosPalavra('ORDER', StrAux2);
          if (p = 0) and (g = 0) then
          begin
            if Trim(StrAux2) <> '' then
              sSqlAux.Add(StrAux2);
          end
          else
          begin
            if (g > 0) and (g < p) then p := g;
            StrAux2 := Copy(StrAux2, 1, p - 1);
            if Trim(StrAux2) <> '' then
              sSqlAux.Add(StrAux2);
            SqlWhere := False;
          end;
        end;
      end;
      StartTransaction(qrSqlAux);
      qrSqlAux.SQL.Assign(sSqlAux);
      if High(Params) > -1 then
      begin
        for i := 0 to High(Params) do
          qrSqlAux.Params[i].Value := Params[i];
      end;
      qrSqlAux.Open;
      if not qrSqlAux.Fields[0].IsNull then
        Result := qrSqlAux.Fields[0].AsInteger;
      qrSqlAux.Close;
      CommitTransaction(qrSqlAux);
    end;
  end;
end;

function  CountRegister(SqlMain: TStrings; Params: array of Variant): Integer;
var
  i: Integer;
begin
  Result   := 0;
  with Dados do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Assign(SqlMain);
    StartTransaction(qrSqlAux);
    try
      if High(Params) > -1 then
      begin
        for i := 0 to High(Params) do
          qrSqlAux.Params[i].Value := Params[i];
      end;
      qrSqlAux.Open;
      if not qrSqlAux.Fields[0].IsNull then
        Result := qrSqlAux.Fields[0].AsInteger;
    finally
      qrSqlAux.Close;
      CommitTransaction(qrSqlAux);
    end;
  end;
end;

function  GetTypedReference(Secao, Grupo, SubGrupo: Integer): string;
var
  S1, S2: string;
begin
  Result := '';
  with Dados do
  begin
    if qrSqlAux.Active       then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add('select * from STP_GERA_REFERENCIA(:Secao, :Grupo, :SubGrupo)');
    StartTransaction(qrSqlAux);
    try
      qrSqlAux.ParamByName('Secao').AsInteger    := Secao;
      qrSqlAux.ParamByName('Grupo').AsInteger    := Grupo;
      qrSqlAux.ParamByName('SubGrupo').AsInteger := SubGrupo;
      qrSqlAux.Open;
      if not qrSqlAux.FieldByName('RGRUPO').IsNull then
      begin
        S1 := InsereZer(qrSqlAux.FieldByName('RGRUPO').AsString, 2);
        S2 := InsereZer(qrSqlAux.FieldByName('RSEQUENCIA').AsString, 4);
        Result := S1 + '-' + qrSqlAux.FieldByName('RSUBGRUPO').AsString + '-' + S2;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      CommitTransaction(qrSqlAux);
    end;
  end;
end;

function SelectImageFromFile(ABlob: TBlobField; AImage: TImage; ImgDef: string = 'jpg'): Integer;
var
  AStream  : TMemoryStream;
  TypeImage: TTypeImage;
  JpgImg   : TJpegImage;
  op       : TOpenPictureDialog;
begin
  Result := -1;
  if (ABlob = nil) or (AImage = nil) then exit;
  op := TOpenPictureDialog.Create(Application);
  try
    op.DefaultExt := ImgDef;
    op.Filter := 'Todos Formatos Suportados|*.wmf;*.bmp;*.jpg|' +
                 'Windows MetaFile(*.wmf)|*.wmf|Windows Bitmap(*.bmp)|'+
                 '*.bmp|Jpeg (*.jpg)|*.jpg';
    op.Options := [ofHideReadOnly, ofNoChangeDir, ofPathMustExist,
                   ofFileMustExist, ofEnableSizing];
    if op.Execute then
    begin
      AImage.Picture.LoadFromFile(op.FileName);
      if AImage.Picture = nil then
        ABlob.Clear
      else
      begin
        AStream := TMemoryStream.Create;
        try
          AImage.Picture.Graphic.SaveToStream(AStream);
          TypeImage := GetTypeImage(AStream);
          AStream.Clear;
          case TypeImage of
            tiBmp: AImage.Picture.BitMap.SaveToStream(AStream);
            tiWmf: AImage.Picture.MetaFile.SaveToStream(AStream);
            tiJpg:
              begin
                JpgImg := TJpegImage.Create;
                try
                  JpgImg.Assign(AImage.Picture);
                  JpgImg.SaveToStream(AStream);
                finally
                  JpgImg.Free;
                end;
              end;
          end;
          Result := Ord(TypeImage);
          if AStream.Size < 1 then
            ABlob.Clear
          else
          begin
            AStream.Position := 0;
            ABlob.LoadFromStream(AStream);
          end;
        finally
          AStream.Free;
        end;
      end;
    end;
  finally
    FreeAndNil(op);
  end;
end;

function SelectImageFromFile(var AStream: TStream; AImage: TImage; ImgDef: string = 'jpg'): Integer;
var
  op: TOpenPictureDialog;
begin
  Result := -1;
  if (AStream = nil) or (AImage = nil) then exit;
  op := TOpenPictureDialog.Create(Application);
  try
    op.DefaultExt := ImgDef;
    op.Filter := 'Todos Formatos Suportados|*.wmf;*.bmp;*.jpg|' +
                 'Windows MetaFile(*.wmf)|*.wmf|Windows Bitmap(*.bmp)|'+
                 '*.bmp|Jpeg (*.jpg)|*.jpg';
    op.Options := [ofHideReadOnly, ofNoChangeDir, ofPathMustExist,
                   ofFileMustExist, ofEnableSizing];
    if op.Execute then
    begin
      AImage.Picture.LoadFromFile(op.FileName);
      TMemoryStream(AStream).Clear;
      AStream.Position := 0;
      AImage.Picture.Graphic.SaveToStream(AStream);
      Result := Ord(GetTypeImage(TMemoryStream(AStream)));
    end;
  finally
    FreeAndNil(op);
  end;
end;

function  AutenticaSys(Sender: TComponent): Boolean;
var
  DataAux, DataPrz: TDateTime;
  StrAux: string;
begin
  Result := True;
  StrAux := CriptografaSenha(Dados.Parametros.soLicenceKey, 'OEFFECDA', atDCrypto);
  try
    DataAux := StrToDate(StrAux);
  except
    Application.MessageBox(PAnsiChar(Dados.GetStringMessage('pt_br', 'sPirateProgram') +
      ' ==> Erro na conversão' + #13 + Dados.Parametros.soLicenceKey + #13 + StrAux),
      PAnsiChar(Application.Title), MB_OK + MB_ICONSTOP);
    Result := False;
    exit;
  end;
  Dados.Parametros.soExpireDate := DataAux;
  DataPrz := DataAux;
  DataPrz := AdicionaDia(DataPrz, 10);
  if (DataAux < Date) and
     (DataPrz > Date) then
    Application.MessageBox(PAnsiChar(Dados.GetStringMessage('pt_br', 'sPirateProgram') +
      ' ==> Programa expirou' + #13 + Dados.Parametros.soLicenceKey + #13 + StrAux),
      PAnsiChar(Application.Title), MB_OK + MB_ICONSTOP)
  else
    if DataPrz < Date then
    begin
      Application.MessageBox(PAnsiChar(Dados.GetStringMessage('pt_br', 'sPirateProgram') +
      ' ==> Data Menor' + #13 + Dados.Parametros.soLicenceKey + #13 + StrAux),
      PAnsiChar(Application.Title), MB_OK + MB_ICONSTOP);
      Result := False;
    end;
end;

procedure GetImage_FromStream(ABlob: TBlobField; var AImage: TImage);
var
  AStream  : TMemoryStream;
  TypeImage: TTypeImage;
  JpgImg   : TJpegImage;
begin
  if ABlob <> nil then
  begin
    AStream := TMemoryStream.Create;
    try
      ABlob.SaveToStream(AStream);
      if AStream.Size < 1 then
        AImage.Picture := nil
      else
      begin
        TypeImage := GetTypeImage(AStream);
        AStream.Position := 0;
        case TypeImage of
          tiBmp: AImage.Picture.BitMap.LoadFromStream(AStream);
          tiWmf: AImage.Picture.MetaFile.LoadFromStream(AStream);
          tiJpg:
            begin
              JpgImg := TJpegImage.Create;
              try
                JpgImg.LoadFromStream(AStream);
                AImage.Picture.Assign(JpgImg);
              finally
                JpgImg.Free;
              end;
            end;
        end;
      end;
    finally
      AStream.Free;
    end;
  end;
end;

procedure GetImage_FromStream(ABlob: TBlobField; var AImage: TPicture);
var
  AStream  : TMemoryStream;
  TypeImage: TTypeImage;
  JpgImg   : TJpegImage;
begin
  if ABlob <> nil then
  begin
    AStream := TMemoryStream.Create;
    try
      ABlob.SaveToStream(AStream);
      if AStream.Size < 1 then
        AImage := nil
      else
      begin
        TypeImage := GetTypeImage(AStream);
        AStream.Position := 0;
        case TypeImage of
          tiBmp: AImage.BitMap.LoadFromStream(AStream);
          tiWmf: AImage.MetaFile.LoadFromStream(AStream);
          tiJpg:
            begin
              JpgImg := TJpegImage.Create;
              try
                JpgImg.LoadFromStream(AStream);
                AImage.Assign(JpgImg);
              finally
                JpgImg.Free;
              end;
            end;
        end;
      end;
    finally
      AStream.Free;
    end;
  end;
end;

function  FillVirtualTreeView(Tree: TVirtualStringTree; Table: TDataSet;
    const Sql: string = '';  AClass: TClass = nil; const MayInsert: Boolean = False;
    const AClear: Boolean = True; const ColSort: Integer = -1): Boolean;
var
  Node     : PVirtualNode;
  Data     : PGridData;
  StrSql   : TStrings;
  WasActive: Boolean;
begin
  StrSql := TStringList.Create;
  Result := True;
  try
    WasActive := Table.Active;
    if (not WasActive) and (Sql <> '') then
    begin
      StrSql.Add(Sql);
      if GetProperty(Table, 'SQL') then
        SetProperty(Table, 'SQL', @StrSql)
      else
        Result := False;
    end;
    if Result then
    begin
      if not WasActive then Table.Open;
      Tree.BeginUpdate;
      if AClear then Tree.Clear;
      Tree.NodeDataSize := SizeOf(TGridData);;
      try
        Table.First;
        while not Table.Eof do
        begin
          Node := Tree.AddChild(nil);
          if Node <> nil then
          begin
            Data := Tree.GetNodeData(Node);
            if Assigned(Data) then
            begin
              Data.Level   := Tree.GetNodeLevel(Node);
              Data.Node    := Node;
              Data.DataRow := TDataRow.CreateFromDataSet(nil, Table, True);
              if Assigned(AClass) then
              Data.DataRow.UserData := AClass.Create;
            end;
          end;
          Table.Next;
        end;
        if MayInsert and Table.IsEmpty then
        begin
          Node := Tree.AddChild(nil);
          if (Node <> nil) then
          begin
            Data := Tree.GetNodeData(Node);
            if (Data <> nil) then
            begin
              Data^.Level   := Tree.GetNodeLevel(Node);
              Data^.Node    := Node;
              Data^.DataRow := TDataRow.CreateFromDataSet(nil, Table, False);
              if Assigned(AClass) then
                Data^.DataRow.UserData := AClass.Create;
            end;
          end;
        end;
        if (ColSort > -1) and (ColSort <= Tree.Header.Columns.Count - 1) then
        begin
          Tree.FocusedNode          := Tree.GetFirst;
          Tree.Header.SortColumn    := ColSort;
          Tree.Header.SortDirection := sdAscending;
          Tree.SortTree(0, Tree.Header.SortDirection);
        end;
      finally
        Tree.EndUpdate;
      end;
      if not WasActive then Table.Close;
    end;
  finally
    StrSql.Free;
  end;
end;

function  CalcTreeLinePos(const vtTree: TVirtualStringTree; const Node: PVirtualNode;
  const Column: TColumnIndex; const ClientHeight: Integer): TPoint;
var
  R: TRect;
begin
  Result.X := 0;
  Result.Y := 0;
  if (Node = nil) or (vtTree = nil) or (Column >= vtTree.Header.Columns.Count) then exit;
  R := vtTree.GetDisplayRect(Node, Column, False);
  Result.Y := R.Bottom + Integer(vtTree.Header.Height) + 
    (ClientHeight - vtTree.Height - (Integer(vtTree.DefaultNodeHeight) div 2));
  Result.X := R.Right + ((R.TopLeft.X - R.BottomRight.X) div 2);
end;

procedure ReleaseTreeNodes(vtTree: TVirtualStringTree);
var
  Data: PGridData;
  Node: PVirtualNode;
begin
  if vtTree.RootNodeCount = 0 then exit;
  vtTree.BeginUpdate;
  try
    Node   := vtTree.GetFirst;
    while Node <> nil do
    begin
      Data  := vtTree.GetNodeData(Node);
      if Data <> nil then
      begin
        if Data^.DataRow <> nil then
          Data^.DataRow.Free;
        Data^.DataRow := nil;
        Data^.Node    := nil;
        Data^.Level   := 0;
      end;
      Data := nil;
      if Data = nil then
        Node := vtTree.GetNext(Node);
    end;
    if vtTree.RootNodeCount > 0 then
      vtTree.Clear;
  finally
    vtTree.EndUpdate;
  end;
end;

function  CriptoGrafaSenha(Campo, Senha: string; Acao: TActionType): string;
var
  Cripto: TCrypto;
begin
  Cripto             := TCrypto.Create(Application.Owner);
  Cripto.Input      := Campo;
  Cripto.Key        := Senha;
  Cripto.Action     := Acao;
  Cripto.TypeCipher := tcHexadecimal;
  Cripto.Execute;
  Result := Cripto.Output;
  Cripto.Free;
end;

function  Ordenar(Tabela: TDataSet; StrSql: string): Boolean;
var
  StrAux: TStrings;
begin
  StrAux := TStringList.Create;
  if Tabela.Active then Tabela.Close;
  if GetProperty(Tabela, 'CommandText') then
    SetProperty(Tabela, 'CommandText', @StrSql)
  else
  begin
    try
      StrAux.Add(StrSql);
      if GetProperty(Tabela, 'SQL') then
        SetProperty(Tabela, 'SQL', @StrAux)
      else
        if GetProperty(Tabela, 'SelectSQL') then
          SetProperty(Tabela, 'SelectSQL', @StrAux);
    finally
      StrAux.Free;
    end;
  end;
  if not Tabela.Active then Tabela.Open;
  Result := not Tabela.IsEmpty;
end;

function GetNumericStrings(AType: TFieldType): Boolean;
const
  NumericAndStrings: array [0..18] of TFieldType =
    (ftString, ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD,
     ftDate, ftTime, ftDateTime, ftBytes, ftVarBytes, ftAutoInc, ftFixedChar,
     ftWideString, ftLargeInt, ftVariant, ftTimeStamp, ftFMTBcd);
var
  i: Integer;
begin
  Result := False;
  for i := 0 to 18 do
  begin
    if AType = NumericAndStrings[i] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function GetStringField(AType: TFieldType): Boolean;
const
  Strings: array [0..2] of TFieldType =
    (ftString, ftFixedChar, ftWideString);
var
  i: Integer;
begin
  Result := False;
  for i := 0 to 2 do
  begin
    if AType = Strings[i] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function GetDateField(AType: TFieldType): Boolean;
const
  Dates: array [0..2] of TFieldType =
    (ftDate, ftDateTime, ftTimeStamp);
var
  i: Integer;
begin
  Result := False;
  for i := 0 to 2 do
  begin
    if AType = Dates[i] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function  GetPkTable(ATable: TDataSet; AGenName: string; ATypePK: TTypePK;
  ASql: string = ''): Integer;
begin
  Result := 0;
  if (ATable = nil) or ((ATypePK = tpGenerator) and (AGenName = '')) or
     ((ATypePK = tpSql) and (ASql = '')) then
    exit;
  if ATypePK = tpGenerator then
    ASql := 'select Gen_Id(' + AGenName + ', 1) as PK from PARAMETRO_GLOBAIS';
  if (Ordenar(ATable, ASql)) and (ATable.FindField('PK') <> nil) then
    Result := ATable.FindField('PK').AsInteger;
  if ATable.Active then ATable.Close;
end;

function  AchaNivel(AMenuData: TMenuData): TOperationLevel;
begin
  Result := [];
  if AMenuData.FlagBrw then
    Result := Result + [olBrowse];
  if AMenuData.FlagFnd then
    Result := Result + [olFind];
  if AMenuData.FlagIns then
    Result := Result + [olInsert];
  if AMenuData.FlagUpd then
    Result := Result + [olEdit];
  if AMenuData.FlagDel then
    Result := Result + [olDelete];
end;

function  ClearIdent(Ident: Pointer): Pointer;
begin
  if Ident <> nil then Ident := nil;
  Result := Ident;
end;

end.
