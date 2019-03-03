unit SelCad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, DB, shForm, StdCtrls, Buttons, ExtCtrls, ProcType;

type
  TValueType = (vtNone, vtString, vtPickString, vtNumber, vtPickNumber, vtMemo,
    vtDate, vtTime, vtTimeStamp, vtCheck);



  PGridData = ^TGridData;
  TGridData = record
    ValueType: array [0..5] of TValueType; // one for each column
    Value: array [0..5] of string;
    Changed: Boolean;
    Bk: Pointer;
  end;

  TSelCadastro = class(TForm)
    vtGrid: TVirtualStringTree;
    sbOk: TSpeedButton;
    sbCancel: TSpeedButton;
    lTitle: TLabel;
    lStatus: TLabel;
    eSearch: TEdit;
    lSearch: TLabel;
    procedure vtGridGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure vtGridChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtGridGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure eSearchChange(Sender: TObject);
    procedure eSearchEnter(Sender: TObject);
    procedure vtGridHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vtGridCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
  private
    { Private declarations }
    procedure GetDictionary;
    function  AscendingResult(Str1, Str2: string): integer;
    function  DescendingResult(Str1, Str2: string): integer;
  public
    { Public declarations }
    FSearchField: Integer;
    Tabela: TDataSet;
    TableName: string;
  end;

var
  SelCadastro: TSelCadastro;

const
  ArrayType: array [ftString..ftFMTBcd] of TValueType =
    (vtString, vtNumber, vtNumber, vtNumber, vtCheck, vtPickNumber, vtPickNumber,
     vtPickNumber, vtDate, vtDate, vtDate, vtNumber, vtNumber, vtNumber, vtMemo,
     vtMemo, vtMemo, vtMemo, vtNone, vtNone, vtMemo, vtNone, vtString, vtString,
     vtNumber, vtNone, vtNone, vtNone, vtNone, vtNone, vtNone, vtNone, vtNone,
     vtNone, vtNone, vtTimeStamp, vtPickNumber);

implementation

uses Dado, CmmConst, Clipbrd;

{$R *.dfm}

{procedure TSelCadastro.vtGridCreateEditor(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
begin
// use unit Editors
  EditLink := TGridEditLink.Create;
end;}

procedure TSelCadastro.FormCreate(Sender: TObject);
begin
  lTitle.Caption  := Dados.GetStringMessage(LANGUAGE, 'sSelCliTitle', 'Seleção de Clientes');
  lSearch.Caption := Dados.GetStringMessage(LANGUAGE, 'sSelCadSearch', 'Procura:');
  Dados.Image16.GetBitmap(16, sbOk.Glyph);
  Dados.Image16.GetBitmap(55, sbCancel.Glyph);
  vtGrid.NodeDataSize  := SizeOf(TGridData);
  vtGrid.RootNodeCount := 0;
end;

procedure TSelCadastro.FormActivate(Sender: TObject);
var
  Column: TVirtualTreeColumn;
  i, Size: Integer;
  Node: PVirtualNode;
  Data: PGridData;
begin
  if Tabela <> nil then
  begin
    if not Tabela.Active then Tabela.Open;
    if Tabela.FieldCount > 5 then
      raise Exception.CreateFmt(Dados.GetStringMessage(LANGUAGE, 'sMaxSelNumField',
           'Erro: Número máximo de Campos para seleção é %d campos'), [5]);
    GetDictionary;
    vtGrid.BeginUpdate;
    try
      vtGrid.Header.Columns.Clear;
      Column         := vtGrid.Header.Columns.Add;
      Column.Options := [coAllowClick,coEnabled,coParentBidiMode,
                         coResizable,coVisible];
      Column.Text    := '';
      Column.Width   := 25;
      Column.Color   := clSkyBlue;
      for i := 0 to Tabela.FieldCount - 1 do
      begin
        Column         := vtGrid.Header.Columns.Add;
        Column.Options := [coAllowClick,coEnabled,coParentBidiMode,
                           coResizable,coVisible];
        Column.Text    := Tabela.Fields[i].DisplayName;
        Size           := Tabela.Fields[i].Size * 5;
        if Size < 50 then
          Size := 50;
        Column.Width   := Size;
        if i > 0 then
          Column.ImageIndex := 55;
        Column.Color   := clWindow;
      end;
      vtGrid.Header.MainColumn := 1;
      Tabela.First;
      while not Tabela.Eof do
      begin
        Node := vtGrid.AddChild(nil);
        Data := vtGrid.GetNodeData(Node);
        for i := 0 to Tabela.FieldCount - 1 do
        begin
          Data^.ValueType[i] := ArrayType[Tabela.Fields[i].DataType];
          Data^.Value[i]     := Tabela.Fields[i].AsString;
        end;
        Data^.Bk := Tabela.GetBookmark;
        Tabela.Next;
      end;
    finally
      vtGrid.EndUpdate;
    end;
    vtGrid.FocusedNode := vtGrid.GetFirst;
    if FSearchField > 0 then
    begin
      vtGrid.Header.SortColumn    := FSearchField;
      Dec(FSearchField);
      vtGrid.Header.SortDirection := sdAscending;
      vtGrid.SortTree(FSearchField, vtGrid.Header.SortDirection);
    end;
  end;
end;

procedure TSelCadastro.sbCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSelCadastro.GetDictionary;
var
  DscField,
  FieldName: string;
  FieldsAux: TStrings;
  Field    : TField;
begin
  with Dados do
  begin
    FieldsAux := TStringList.Create;
    try
      Tabela.GetFieldNames(FieldsAux);
      if FindDictionary(TableName) then
      begin
        while not qrDicAux.Eof do
        begin
          FieldName := qrDicAux.FieldByName('PK_DICIONARIOS__NC').AsString;
          DscField  := qrDicAux.FieldByName('DSC_FLD').AsString;
          Field     := Tabela.FindField(FieldName);
          if Field  <> nil then
            Field.DisplayLabel := DscField;
          qrDicAux.Next;
        end;
        if qrDicAux.Active  then qrDicAux.Close;
      end;
    finally
      FieldsAux.Free;
    end;
  end;
end;

procedure TSelCadastro.sbOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TSelCadastro.vtGridGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if Column > 0 then
  begin
    Data := Sender.GetNodeData(Node);
    CellText := Data^.Value[Column - 1];
  end;
end;

procedure TSelCadastro.vtGridChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PGridData;
begin
  LStatus.Caption := '';
  Data := vtGrid.GetNodeData(Node);
  if (Data <> nil) then
    if (Data^.Bk <> nil) then
      Tabela.GotoBookmark(Data^.Bk)
    else
      LStatus.Caption := Format('Erro: BookMark é nulo Tabela %s',
        [TableName])
  else
    LStatus.Caption := Format('Erro: Data é nula %s',
      [TableName]);
end;

procedure TSelCadastro.vtGridGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if Kind in [ikNormal, ikSelected] then
    if (Column = 0) and (vtGrid.FocusedNode = Node) then
      ImageIndex := 4
    else
      ImageIndex := -1;
end;

procedure TSelCadastro.eSearchChange(Sender: TObject);
var
  i: Integer;
  Node: PVirtualNode;
  Data: PGridData;
  SubStr, StrAux: string;
begin
  if eSearch.Text = '' then exit;
  if (FSearchField > 0) or (FSearchField <= 5) then
  begin
    Node := vtGrid.FocusedNode;
//    ShowMessage(IntToStr(vtGrid.RootNodeCount) + ' - ' + IntToStr(VtGrid.AbsoluteIndex(Node))
//      + ' = ' + IntToStr(vtGrid.RootNodeCount - VtGrid.AbsoluteIndex(Node)));
    for i := 1 to vtGrid.RootNodeCount - VtGrid.AbsoluteIndex(Node) do
    begin
      if Node = nil then break;
      Data := vtGrid.GetNodeData(Node);
      StrAux := Data^.Value[FSearchField];
      StrAux := UpperCase(StrAux);
      SubStr := UpperCase(eSearch.Text);
      if Pos(SubStr, StrAux) = 1 then
      begin
        vtGrid.FocusedNode := Node;
        Tabela.GotoBookmark(Data^.Bk);
        break;
      end;
      try
        Node := vtGrid.GetNext(Node);
      except
        break;
      end;
    end;
  end
  else
    Application.MessageBox(PAnsiChar(Dados.GetStringMessage(LANGUAGE, 'sSelectColumn',
     'Selecione uma coluna para iniciar a pesquisa')), PAnsiChar(Application.Title),
     MB_OK + MB_ICONINFORMATION)
end;

procedure TSelCadastro.eSearchEnter(Sender: TObject);
begin
  eSearch.OnChange := nil;
  eSearch.Text     := '';
  eSearch.OnChange := eSearchChange;
end;

procedure TSelCadastro.vtGridHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Column > 0 then
  begin
    if Column - 1 <> FSearchField then
    begin
      FSearchField := Column - 1;
      vtGrid.Header.SortColumn    := Column;
      vtGrid.Header.SortDirection := sdAscending;
    end
    else
    begin
      if vtGrid.Header.SortDirection = sdDescending then
        vtGrid.Header.SortDirection := sdAscending
      else
        vtGrid.Header.SortDirection := sdDescending;
    end;
    vtGrid.SortTree(Column, vtGrid.Header.SortDirection);
  end;
end;

procedure TSelCadastro.vtGridCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data: PGridData;
  Str1, Str2: string;
begin
  Data := vtGrid.GetNodeData(Node1);
  Str1 := Data^.Value[FSearchField - 1];
  Data := vtGrid.GetNodeData(Node2);
  Str2 := Data^.Value[FSearchField - 1];
  case vtGrid.Header.SortDirection of
    sdAscending : Result := AscendingResult(Str1, Str2);
    sdDescending: Result := DescendingResult(Str1, Str2);
  end;
end;

function TSelCadastro.AscendingResult(Str1, Str2: string): Integer;
begin
  if Str1 = Str2 then
    Result := 0
  else
    if Str1 > Str2 then
      Result := 1
    else
      Result := -1;
end;

function TSelCadastro.DescendingResult(Str1, Str2: string): Integer;
begin
  if Str1 = Str2 then
    Result := -1
  else
    if Str2 > Str1 then
      Result := 1
    else
      Result := 0;
end;

end.
