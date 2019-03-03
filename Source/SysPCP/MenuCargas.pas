unit MenuCargas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, StdCtrls, Buttons, VirtualTrees,
  CSDVirtualStringTree, Mask, ToolEdit, jpeg;

type
  TfmMenuCargas = class(TForm)
    paDetails: TPanel;
    Shape2: TShape;
    Shape1: TShape;
    im: TImage;
    cmdSearch: TSpeedButton;
    Label2: TLabel;
    cmdExpandAll: TSpeedButton;
    cmdCollapseAll: TSpeedButton;
    Label1: TLabel;
    StaticText1: TStaticText;
    StaticText9: TStaticText;
    cbCliente: TComboBox;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    cbRegiao: TComboBox;
    StaticText4: TStaticText;
    dtDe: TDateEdit;
    dtAte: TDateEdit;
    cbStatus: TComboBox;
    edReferenciaCarga: TEdit;
    stItems: TCSDVirtualStringTree;
    Panel1: TPanel;
    cmdNew: TBitBtn;
    cmdCancel: TBitBtn;
    ImageList1: TImageList;
    Label3: TLabel;
    StaticText5: TStaticText;
    edReferenciaProduto: TEdit;
    cmdActivate: TBitBtn;
    cmdDelete: TBitBtn;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure stItemsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure cmdExpandAllClick(Sender: TObject);
    procedure cmdCollapseAllClick(Sender: TObject);
    procedure stItemsPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure stItemsChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure cmdActivateClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure stItemsBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure cmdDeleteClick(Sender: TObject);
  private
    { Private declarations }
    FfkEmpresas :Integer;
    FslItems    :TList;
    procedure ClearItems;
    procedure LoadItems;
    procedure LoadStatus;
    procedure LoadRegioes;
    procedure LoadClientes;
  public
    { Public declarations }
  end;

var
  fmMenuCargas: TfmMenuCargas;

implementation

uses Agrupamento, dbObjects, udmCargas;

{$R *.dfm}

procedure TfmMenuCargas.ClearItems;
var I       :Integer;
begin
  cmdActivate.Enabled:=False;
  cmdDelete.Enabled  :=False;
  stItems.Clear;
  For I:=0 to FslItems.Count-1 do
      if FslItems[I]<>Nil Then
         begin
           TRowData(FslItems[I]).Free;
           FslItems[I]:=Nil;
         end;
  FslItems.Clear;
end;

procedure TfmMenuCargas.LoadClientes;
begin
  cbCliente.Items.Clear;
  cbCliente.Items.AddObject('<QUALQUER>',Nil);
  with dmCargas.qrClientes do
       try
         Open;
         While Not(EOF) do
               begin
                 cbCliente.Items.AddObject(FieldByName('raz_soc').AsString,TObject(FieldByName('fk_cadastros').AsInteger));
                 Next;
               end;
       finally
         Close;
       end;
  cbCliente.ItemIndex:=0;
end;

procedure TfmMenuCargas.LoadRegioes;
begin
  cbRegiao.Items.Clear;
  cbRegiao.Items.AddObject('<QUALQUER>',Nil);
  with dmCargas.qrRegioes do
       try
         Open;
         While Not(EOF) do
               begin
                 cbRegiao.Items.AddObject(FieldByName('ref_reg').AsString+'-'+FieldByName('dsc_reg').AsString,TObject(FieldByName('pk_cargas_regioes').AsInteger));
                 Next;
               end;
       finally
         Close;
       end;
  cbRegiao.ItemIndex:=0;
end;

procedure TfmMenuCargas.FormCreate(Sender: TObject);
begin
  FslItems              :=TList.Create;
  stItems.RootNodeCount :=0;
  stItems.NodeDataSize  :=SizeOf(TTreeData);
  FfkEmpresas           :=1;
  LoadStatus;
  LoadRegioes;
  LoadClientes;
end;

procedure TfmMenuCargas.FormDestroy(Sender: TObject);
begin
  ClearItems;
  FslItems.Free;
  FslItems:=Nil;
end;

procedure TfmMenuCargas.LoadItems;
var SqlSaved    :String;
    adtDe,
    adtAte      :TDateTime;
    CargaNode,
    Node        :PVirtualNode;
    RowData     :TRowData;
    Data        :PTreeData;
    TotalItems,
    LastfkCarga :Integer;
    M3, M3Total :Currency;
procedure WhereClauseSetUp;
begin
  with dmCargas.qrItemsCargas do
       begin
         if edReferenciaCarga.Text<>'' Then Sql.Insert(Sql.Count-1,' And cg.ref_crg='''+edReferenciaCarga.Text+'''');
         if ((adtDe>0)Or(adtAte>0)) Then
            begin
              //Sql.Insert(Sql.Count-1,'and ((cg.dta_lim is Null)Or(');
              if adtDe>0 Then Sql.Insert(Sql.Count-1,'and cg.dta_lim>='''+FormatDateTime('yyyy-mm-dd',adtDe)+'''');
              if adtAte>0 Then Sql.Insert(Sql.Count-1,'and cg.dta_lim<='''+FormatDateTime('yyyy-mm-dd',adtDe)+'''');
              //Sql.Insert(Sql.Count-1,'))');
            end;
         if cbStatus.ItemIndex>0 Then
            Sql.Insert(Sql.Count-1,'and cg.flag_ativo='+IntToStr(cbStatus.ItemIndex-1));
         if ((edReferenciaProduto.Text<>'')Or(cbRegiao.ItemIndex>0)Or(cbCliente.ItemIndex>0)) Then
            begin
              Sql.Insert(Sql.Count-1,'and cg.pk_cargas_producao in (select distinct i.fk_cargas_producao');
              Sql.Insert(Sql.Count-1,'from pedidos_itens i, pedidos p, vw_clientes c, municipios m');
              Sql.Insert(Sql.Count-1,'where i.fk_empresas=p.fk_empresas and p.pk_pedidos=i.fk_pedidos');
              Sql.Insert(Sql.Count-1,'and c.pk_cadastros=p.fk_cadastros and m.fk_paises=c.fk_paises');
              Sql.Insert(Sql.Count-1,'and m.fk_estados=c.fk_estados and m.pk_municipios=c.fk_municipios');
              Sql.Insert(Sql.Count-1,'and i.fk_cargas_producao is not null');
              Sql.Insert(Sql.Count-1,'and p.fk_empresas='+IntToStr(FfkEmpresas));
              if cbRegiao.ItemIndex>0 Then
                 Sql.Insert(Sql.Count-1,'and m.fk_cargas_regioes='+IntToStr(LongInt(cbRegiao.Items.Objects[cbRegiao.ItemIndex])));
              if edReferenciaProduto.Text<>'' Then
                 Sql.Insert(Sql.Count-1,'and i.cod_ref_item='''+edReferenciaProduto.Text+'''');
              if cbCliente.ItemIndex>0 Then
                 Sql.Insert(Sql.Count-1,'and c.fk_cadastros='+IntToStr(LongInt(cbCliente.Items.Objects[cbCliente.ItemIndex])));
              Sql.Insert(Sql.Count-1,')');
            end;
       end;
end;
procedure UpdateCargaNode;
begin
  if CargaNode<>Nil Then
     begin
       Data:=stItems.GetNodeData(CargaNode);
       if ((Data<>Nil)And(Data.RowData<>Nil)And(Data.RowData.dbRow<>Nil)) Then
          begin
            Data.RowData.dbRow['M3'].AsFloat          :=M3Total;
            Data.RowData.dbRow['qtd_item'].AsInteger  :=TotalItems;
          end;
       end;
  M3Total                     :=0;
  TotalItems                  :=0;
end;
begin
  edReferenciaCarga.Text:=Trim(edReferenciaCarga.Text);
  adtDe:=StrToDateDef(dtDe.Text,0);
  adtAte:=StrToDateDef(dtAte.Text,0);
  edReferenciaProduto.Text:=Trim(edReferenciaProduto.Text);
  CargaNode:=Nil;
  LastfkCarga:=0;
  M3Total:=0;
  TotalItems:=0;
  stItems.BeginUpdate;
  try
    ClearItems;
    with dmCargas.qrItemsCargas do
         try
           SqlSaved:=Sql.Text;
           ParamByName('fk_empresas').AsInteger :=FfkEmpresas;
           WhereClauseSetUp;
           Open;
           While Not(EOF) do
                 begin
                   M3:=FieldByName('alt_prod').AsFloat*FieldByName('prof_prod').AsFloat*FieldByName('larg_prod').AsFloat;
                   M3:=M3/1000000;
                   if FieldByName('pk_cargas_producao').AsInteger<>LastfkCarga Then
                      begin
                        UpdateCargaNode;
                        LastfkCarga                 :=FieldByName('pk_cargas_producao').AsInteger;
                        RowData                     :=TRowData.Create;
                        RowData.dbRow               :=TdbRow.CreateFromDs(dmCargas.qrItemsCargas,True);
                        RowData.Level               :=0;
                        CargaNode                   :=stItems.AddChild(Nil);
                        RowData.Node                :=CargaNode;
                        Data                        :=stItems.GetNodeData(CargaNode);
                        Data.RowData                :=RowData;
                        RowData.dbRow['M3'].AsFloat :=M3;
                        FslItems.Add(RowData);
                      end;
                   RowData                      :=TRowData.Create;
                   RowData.dbRow                :=TdbRow.CreateFromDs(dmCargas.qrItemsCargas,True);
                   RowData.Level                :=1;
                   Node                         :=stItems.AddChild(CargaNode);
                   RowData.Node                 :=Node;
                   Data                         :=stItems.GetNodeData(Node);
                   Data.RowData                 :=RowData;
                   RowData.dbRow['M3'].AsFloat  :=M3;
                   M3Total                      :=M3Total+(M3*RowData.dbRow['qtd_item'].AsInteger);
                   TotalItems                   :=TotalItems+RowData.dbRow['qtd_item'].AsInteger;
                   FslItems.Add(RowData);
                   Next;
                 end;
           UpdateCargaNode;
         finally
           Close;
           Sql.Text:=SqlSaved;
         end;
  finally
    stItems.EndUpdate;
  end;
end;

procedure TfmMenuCargas.cmdSearchClick(Sender: TObject);
begin
  LoadItems;
end;

procedure TfmMenuCargas.stItemsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var Data:PTreeData;
begin
  CellText:='';
  if Node=Nil Then Exit;
  Data:=stItems.GetNodeData(Node);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.dbRow=Nil)) Then Exit;
  with Data.RowData do
       case Column of
            0:if Level=0 Then CellText:=dbRow['ref_crg'].AsString;
            1:if Level=0 Then
                 if dbRow['dta_lim'].AsDateTime>0 Then
                    CellText:=FormatDateTime('dd/mm/yyyy',dbRow['dta_lim'].AsDateTime);
            2:if Level=1 Then CellText:=IntToStr(dbRow['fk_pedidos'].AsInteger);
            3:if Level=1 Then CellText:=dbRow['raz_soc'].AsString;
            4:if Level=1 Then CellText:=dbRow['ref_reg'].AsString;
            5:if Level=1 Then CellText:=dbRow['cod_ref_item'].AsString;
            6:CellText:=IntToStr(dbRow['qtd_item'].AsInteger);
            7:CellText:=FormatFloat('#,##0.0000',dbRow['M3'].AsFloat);
       end;

end;

procedure TfmMenuCargas.cmdExpandAllClick(Sender: TObject);
begin
  stItems.FullExpand;
end;

procedure TfmMenuCargas.cmdCollapseAllClick(Sender: TObject);
begin
  stItems.FullCollapse;
end;

procedure TfmMenuCargas.stItemsPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var Data:PTreeData;
begin
  if Node=Nil Then Exit;
  Data:=stItems.GetNodeData(Node);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.dbRow=Nil)Or(Data.RowData.dbRow['flag_ativo'].AsInteger<>1)) Then Exit;
  TargetCanvas.Font.Style:=TargetCanvas.Font.Style+[fsBold];
end;

procedure TfmMenuCargas.LoadStatus;
begin
  cbStatus.Items.Clear;
  cbStatus.Items.AddObject('<QUALQUER>',Nil);
  cbStatus.Items.AddObject('Desativada',TObject(LongInt(1)));
  cbStatus.Items.AddObject('Ativa',TObject(LongInt(2)));
  cbStatus.ItemIndex:=0;
end;

procedure TfmMenuCargas.stItemsChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var Data:PTreeData;
begin
  if Node=Nil Then Exit;
  Data:=stItems.GetNodeData(Node);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.dbRow=Nil)) Then Exit;
  cmdActivate.Enabled:=(Data.RowData.dbRow['flag_ativo'].AsInteger<>1);
  cmdDelete.Enabled  :=cmdActivate.Enabled;
end;

procedure TfmMenuCargas.cmdActivateClick(Sender: TObject);
var Node:PVirtualNode;
    Data:PTreeData;
       S:String;
begin
  Node:=stItems.FocusedNode;
  While ((Node<>Nil)And(stItems.GetNodeLevel(Node)>0)) do
        Node:=Node.Parent;
  if Node=Nil Then Exit;
  Data:=stItems.GetNodeData(Node);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.dbRow=Nil)) Then Exit;
  if Data.RowData.dbRow['flag_ativo'].AsInteger=1 Then Exit;
  S:='Por favor, confirme a Ativação da Carga "'+Data.RowData.dbRow['ref_crg'].AsString+'" !';
  if MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONQUESTION OR MB_YESNO)<>IDYES Then Exit;
  if dmCargas.tr.InTransaction Then dmCargas.tr.Commit;
  try
    with dmCargas.qrAtivaCargaProducao do
         try
           ParamByName('fk_empresas').AsInteger         :=FfkEmpresas;
           ParamByName('pk_cargas_producao').AsInteger  :=Data.RowData.dbRow['pk_cargas_producao'].AsInteger;
           ExecSql;
         finally
           Close;
         end;
    dmCargas.tr.Commit;
    Data.RowData.dbRow['flag_ativo'].AsInteger:=1;
    Node:=stItems.GetFirstChild(Node);
    while Node<>Nil do
          begin
            Data:=stItems.GetNodeData(Node);
            if ((Data<>Nil)And(Data.RowData<>Nil)And(Data.RowData.dbRow<>Nil)) Then
               Data.RowData.dbRow['flag_ativo'].AsInteger:=1;
            Node:=stItems.GetNextSibling(Node);
          end;
  except
    On Exception do
       begin
         dmCargas.tr.Rollback;
         raise;
       end;
  end;
  stItems.InvalidateNode(Node);
  stITems.InvalidateChildren(Node,True);
end;

procedure TfmMenuCargas.cmdNewClick(Sender: TObject);
begin
  with TfmAgrupamento.Create(Self) do
       try
         ShowModal;
         if Not(CargasUpdated) Then Exit;
       finally
         Release;
       end;
  if Assigned(cmdSearch.OnClick) Then cmdSearch.OnClick(Self);
end;

procedure TfmMenuCargas.stItemsBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var aParentNode:PVirtualNode;
    OldColor   :TColor;
begin
  OldColor:=TargetCanvas.Brush.Color;
  aParentNode:=Node;
  While ((aParentNode<>Nil)And(stItems.GetNodeLevel(aParentNode)>0)) do
        aParentNode:=aParentNode.Parent;
  if ((aParentNode<>Nil)And(Odd(aParentNode.Index))) Then TargetCanvas.Brush.Color:=$00E1FFFF
  else TargetCanvas.Brush.Color:=clWindow;
  TargetCanvas.FillRect(CellRect);
end;

procedure TfmMenuCargas.cmdDeleteClick(Sender: TObject);
var Node, ChildNode:PVirtualNode;
    Data, DataChild:PTreeData;
       S           :String;
     Ix, IxChild   :Integer;
begin
  Node:=stItems.FocusedNode;
  While ((Node<>Nil)And(stItems.GetNodeLevel(Node)>0)) do
        Node:=Node.Parent;
  if Node=Nil Then Exit;
  Data:=stItems.GetNodeData(Node);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.dbRow=Nil)) Then Exit;
  Ix:=FslItems.IndexOf(Data.RowData);
  if Ix<0 Then Exit;
  if Data.RowData.dbRow['flag_ativo'].AsInteger=1 Then Exit;
  S:='Por favor, confirme a Exclusão da Carga "'+Data.RowData.dbRow['ref_crg'].AsString+'" !';
  if MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONWARNING OR MB_YESNO)<>IDYES Then Exit;
  if dmCargas.tr.InTransaction Then dmCargas.tr.Commit;
  stItems.BeginUpdate;
  try
    try
      with dmCargas.qrClearItemPedidoCargaProducao do
           try
             ParamByName('fk_empresas').AsInteger         :=FfkEmpresas;
             ParamByName('fk_cargas_producao').AsInteger  :=Data.RowData.dbRow['pk_cargas_producao'].AsInteger;
             ExecSql;
           finally
             Close;
           end;
      with dmCargas.qrDeleteCargaProducao do
           try
             ParamByName('fk_empresas').AsInteger         :=FfkEmpresas;
             ParamByName('pk_cargas_producao').AsInteger  :=Data.RowData.dbRow['pk_cargas_producao'].AsInteger;
             ExecSql;
           finally
             Close;
           end;
      ChildNode:=stItems.GetFirstChild(Node);
      while ChildNode<>Nil do
            begin
              DataChild:=stItems.GetNodeData(ChildNode);
              if ((DataChild<>Nil)And(DataChild.RowData<>Nil)And(DataChild.RowData.dbRow<>Nil)) Then
                 begin
                   IxChild:=FslItems.IndexOf(DataChild.RowData);
                   if IxChild>-1 Then
                      begin
                        DataChild.RowData.Free;
                        DataChild.RowData:=Nil;
                        FslItems.Delete(IxChild);
                      end;
                 end;
              ChildNode:=stItems.GetNextSibling(ChildNode);
            end;
      Data.RowData.Free;
      Data.RowData:=Nil;
      FslItems.Delete(Ix);
      stItems.DeleteNode(Node);
      dmCargas.tr.Commit;
    except
      On Exception do
         begin
           dmCargas.tr.Rollback;
           raise;
         end;
    end;
  finally
    stItems.EndUpdate;
  end;
end;

end.
