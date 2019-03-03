unit Agrupamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, CSDVirtualStringTree, StdCtrls, Mask, ToolEdit,
  Buttons, jpeg, ExtCtrls, dbObjects, ImgList;

type
  TfmAgrupamento = class(TForm)
    paDetails: TPanel;
    Shape1: TShape;
    im: TImage;
    cmdSearch: TSpeedButton;
    Label2: TLabel;
    StaticText1: TStaticText;
    StaticText9: TStaticText;
    cbCliente: TComboBox;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    cbRegiao: TComboBox;
    StaticText4: TStaticText;
    dtDe: TDateEdit;
    dtAte: TDateEdit;
    cbTipoPedido: TComboBox;
    edNumero: TEdit;
    stItems: TCSDVirtualStringTree;
    ImageList1: TImageList;
    cmdExpandAll: TSpeedButton;
    cmdCollapseAll: TSpeedButton;
    Shape2: TShape;
    Label1: TLabel;
    Panel1: TPanel;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure stItemsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure cmdSearchClick(Sender: TObject);
    procedure stItemsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure stItemsAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure cmdExpandAllClick(Sender: TObject);
    procedure cmdCollapseAllClick(Sender: TObject);
    procedure cbClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdCancelClick(Sender: TObject);
    procedure stItemsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure cmdUpdateClick(Sender: TObject);
    procedure stItemsBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
  private
    { Private declarations }
    FfkEmpresas     : Integer;
    FslPedidos      : TStringList;
    FslItems        : TList;
    FslItemsChecked :TList;
    FCargasUpdated  :Boolean;
    function PedidoKeyStr(afkTipoPedido, afkPedido:Integer):String;overload;
    function PedidoKeyStr(dbRow:TdbRow):String;overload;
    procedure ClearItems;
    procedure LoadItems;
    procedure LoadRegioes;
    procedure LoadTiposPedidos;
    procedure LoadClientes;
    procedure LoadVinculos(dbRow:TdbRow);
    procedure BindVinculos;
  public
    { Public declarations }
    property fkEmpresas:Integer read FfkEmpresas write FfkEmpresas;
    property CargasUpdated:Boolean read FCargasUpdated write FCargasUpdated;
  end;

var
  fmAgrupamento: TfmAgrupamento;

implementation
uses udmCargas, NewCarga;
{$R *.dfm}

var CheckStateToUse:Array[Boolean] of TCheckState=(csUnCheckedNormal,csCheckedNormal);

procedure TfmAgrupamento.ClearItems;
var I       :Integer;
    RowData :TRowData;
begin
  FslItemsChecked.Clear;
  FslPedidos.Clear;
  stItems.Clear;
  For I:=0 to FslItems.Count-1 do
      if FslItems[I]<>Nil Then
         begin
           RowData:=TRowData(FslItems[I]);
           if ((RowData.dbRow<>Nil)And(RowData.dbRow.UserData<>Nil)) Then
              begin
                TStringList(RowData.dbRow.UserData).Free;
                RowData.dbRow.UserData:=Nil;
              end;
           RowData.Free;
           FslItems[I]:=Nil;
         end;
  FslItems.Clear;
end;

function TfmAgrupamento.PedidoKeyStr(afkTipoPedido, afkPedido:Integer):String;
begin
  Result:=FormatFloat('00000000',afkTipoPedido)+
          FormatFloat('00000000',afkPedido);
end;

function TfmAgrupamento.PedidoKeyStr(dbRow:TdbRow):String;
begin
  Result:='';
  if dbRow=Nil Then Exit;
  Result:=PedidoKeyStr(dbRow['fk_tipo_pedidos'].AsInteger,dbRow['fk_pedidos'].AsInteger);
end;

procedure TfmAgrupamento.LoadVinculos(dbRow:TdbRow);
var sl      :TStringList;
    IsParent:Boolean;
    S       :String;
begin
  if ((dbRow=Nil)Or(dbRow.UserData<>Nil)) Then Exit;
  IsParent:=(dbRow['flag_vinc_ped'].AsInteger=1);
  with dmCargas.qrVinculosPedido do
       try
         ParamByName('fk_empresas').AsInteger       :=FfkEmpresas;
         ParamByName('fk_tipo_pedidos').AsInteger   :=dbRow['fk_tipo_pedidos'].AsInteger;
         ParamByName('pk_pedidos').AsInteger        :=dbRow['fk_pedidos'].AsInteger;
         Open;
         if EOF Then Exit;
         sl:=TStringList.Create;
         dbRow.UserData:=sl;
         while Not(EOF) do
               begin
                 if IsParent Then S:=PedidoKeyStr(FieldByName('fk_tipo_pedidos_vinc').AsInteger, FieldByName('fk_pedidos_vinc').AsInteger)
                 else S:=PedidoKeyStr(FieldByName('fk_tipo_pedidos').AsInteger, FieldByName('fk_pedidos').AsInteger);
                 sl.Add(S);
                 Next;
               end;
       finally
         Close;
       end;
end;

procedure TfmAgrupamento.BindVinculos;
var aNode:PVirtualNode;
     Data:PTreeData;
     I,Ix:Integer;
       sl:TStringList;
begin
  aNode:=stItems.GetFirst;
  While aNode<>Nil do
        begin
          Data:=stItems.GetNodeData(aNode);
          if ((Data<>Nil)And(Data.RowData<>Nil)And(Data.RowData.dbRow<>Nil)And(Data.RowData.dbRow.UserData<>Nil)) Then
             begin
               sl:=TStringList(Data.RowData.dbRow.UserData);
               For I:=0 to sl.Count-1 do
                   begin
                     Ix:=FslPedidos.IndexOf(sl[I]);
                     if Ix>-1 Then sl.Objects[I]:=FslPedidos.Objects[Ix];
                   end;
             end;
          aNode:=stItems.GetNextSibling(aNode);
        end;
end;

procedure TfmAgrupamento.LoadItems;
var adtDe,
    adtAte          :TDateTime;
    Key,LastKey,
    SqlSaved        :String;
    Node,
    ParentNode      :PVirtualNode;
    Data,
    ParentData      :PTreeData;
    RowData,
    ParentRowData   :TRowData;
    M3              :Currency;
    MustAcceptItemSelection :Boolean;
begin
  edNumero.Text :=Trim(edNumero.Text);
  adtDe         :=StrToDateDef(dtDe.Text,0);
  adtAte        :=StrToDateDef(dtAte.Text,0);
  LastKey       :='';
  ParentNode    :=Nil;
  stItems.BeginUpdate;
  try
    ClearItems;
    with dmCargas.qrItemsPedidos do
         try
           SqlSaved:=Sql.Text;
           if adtDe>0 Then Sql.Insert(Sql.Count-1,'and p.dta_ped>='''+FormatDateTime('yyyy-mm-dd',adtDe)+' 00:00:00''');
           if adtAte>0 Then Sql.Insert(Sql.Count-1,'and p.dta_ped<='''+FormatDateTime('yyyy-mm-dd',adtDe)+' 23:59:59''');
           if cbRegiao.ItemIndex>0 Then Sql.Insert(Sql.Count-1,'and m.fk_cargas_regioes='+IntToStr(LongInt(cbRegiao.Items.Objects[cbRegiao.ItemIndex])));
           if cbTipoPedido.ItemIndex>0 Then Sql.Insert(Sql.Count-1,'and p.fk_tipo_pedidos='+IntToStr(LongInt(cbTipoPedido.Items.Objects[cbTipoPedido.ItemIndex])));
           if edNumero.Text<>'' Then Sql.Insert(Sql.Count-1,'and p.pk_pedidos='+IntToStr(StrToIntDef(edNumero.Text,0)));
           if cbCliente.ItemIndex>0 Then Sql.Insert(Sql.Count-1,'and p.fk_cadastros='+IntToStr(LongInt(cbCliente.Items.Objects[cbCliente.ItemIndex])));
           ParamByName('fk_Empresas').AsInteger:=FfkEmpresas;
           Open;
           while Not(EOF) do
                 begin
                   M3:=FieldByName('alt_prod').AsFloat*FieldByName('prof_prod').AsFloat*FieldByName('larg_prod').AsFloat;
                   M3:=M3/1000000;
                   Key:=PedidoKeyStr(FieldByName('fk_tipo_pedidos').AsInteger,FieldByName('fk_Pedidos').AsInteger);
                   if Key<>LastKey Then
                      begin
                        LastKey                 :=Key;
                        ParentRowData           :=TRowData.Create;
                        ParentRowData.dbRow     :=TdbRow.CreateFromDs(dmCargas.qrItemsPedidos,True);
                        ParentRowData.dbRow['M3'].AsFloat:=M3;
                        ParentRowData.Level     :=0;
                        ParentNode              :=stItems.AddChild(Nil);
                        ParentNode.CheckType    :=ctTriStateCheckBox;
                        ParentData              :=stItems.GetNodeData(ParentNode);
                        ParentData.RowData      :=ParentRowData;
                        ParentData.RowData.Node :=ParentNode;
                        LoadVinculos(ParentRowData.dbRow);
                        FslItems.Add(ParentRowData);
                        FslPedidos.AddObject(Key,TObject(ParentNode));
                        MustAcceptItemSelection :=((ParentRowData.dbRow['flag_entr_parc'].AsInteger<>0)And((ParentRowData.dbRow.UserData=Nil)Or(TStringList(ParentRowData.dbRow.UserData).Count<1)));
                      end;
                   RowData          :=TRowData.Create;
                   RowData.dbRow    :=TdbRow.CreateFromDs(dmCargas.qrItemsPedidos,True);
                   RowData.dbRow['M3'].AsFloat:=M3;
                   RowData.Level    :=1;
                   Node             :=stItems.AddChild(ParentNode);
                   if MustAcceptItemSelection Then
                      //if RowData.dbRow['flag_entr_parc'].AsInteger<>0 Then
                      Node.CheckType:=ctCheckBox;
                   Data             :=stItems.GetNodeData(Node);
                   Data.RowData     :=RowData;
                   Data.RowData.Node:=Node;
                   FslItems.Add(RowData);
                   Next;
                 end;
         finally
           Close;
           Sql.Text:=SqlSaved;
         end;
  finally
    BindVinculos;
    stItems.EndUpdate;
  end;
end;

procedure TfmAgrupamento.FormCreate(Sender: TObject);
begin
  stItems.RootNodeCount :=0;
  stItems.NodeDataSize  :=SizeOf(TTreeData);
  FslItems              :=TList.Create;
  FslPedidos            :=TStringList.Create;
  FslItemsChecked       :=TList.Create;
  FfkEmpresas           :=1;
end;

procedure TfmAgrupamento.FormDestroy(Sender: TObject);
begin
  ClearItems;
  FslItems.Free;
  FslItems:=Nil;
  FslPedidos.Free;
  FslPedidos:=Nil;
  FslItemsChecked.Free;
  FslItemsChecked:=Nil;
end;

procedure TfmAgrupamento.LoadClientes;
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

procedure TfmAgrupamento.LoadRegioes;
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

procedure TfmAgrupamento.LoadTiposPedidos;
begin
  cbTipoPedido.Items.Clear;
  cbTipoPedido.Items.AddObject('<QUALQUER>',Nil);
  with dmCargas.qrTiposPedidos do
       try
         Open;
         While Not(EOF) do
               begin
                 cbTipoPedido.Items.AddObject(FieldByName('dsc_tped').AsString,TObject(FieldByName('pk_tipo_pedidos').AsInteger));
                 Next;
               end;
       finally
         Close;
       end;
  cbTipoPedido.ItemIndex:=0;
end;

procedure TfmAgrupamento.FormShow(Sender: TObject);
begin
  LoadRegioes;
  LoadTiposPedidos;
  LoadClientes;
end;

procedure TfmAgrupamento.stItemsGetText(Sender: TBaseVirtualTree;
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
            0:if Level=0 Then CellText:=IntToStr(dbRow['fk_pedidos'].AsInteger);
            1:if Level=0 Then CellText:=dbRow['raz_soc'].AsString;
            2:if Level=0 Then CellText:=dbRow['ref_reg'].AsString;
            3:if Level=0 Then
                 if dbRow['dta_ped'].AsDateTime>0 Then
                    CellText:=FormatDateTime('dd/mm/yyyy',dbRow['dta_ped'].AsDateTime);
            //4:if Level=0 Then
            //     if dbRow['p.flag_entr_parc'].AsInteger=0 Then CellText:='*';
            5:if Level=1 Then CellText:=dbRow['cod_ref_item'].AsString;
            6:if Level=1 Then CellText:=IntToStr(dbRow['qtd_item'].AsInteger);
            7:if Level=1 Then CellText:=FormatFloat('#,##0.0000',dbRow['M3'].AsFloat);
       end;
end;

procedure TfmAgrupamento.cmdSearchClick(Sender: TObject);
begin
  LoadItems;
end;

procedure TfmAgrupamento.stItemsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var Data:PTreeData;
begin
  Exit;
  if ((Node=Nil)Or(Column<>4)Or((Kind<>ikNormal)And(Kind<>ikSelected))) Then Exit;
  Data:=stItems.GetNodeData(Node);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.Level<>0)Or(Data.RowData.dbRow=Nil)Or(Data.RowData.dbRow['flag_entr_parc'].AsInteger<>0)) Then Exit;
  ImageIndex:=2;
end;

procedure TfmAgrupamento.stItemsAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var Data:PTreeData;
begin
  if ((Node=Nil)Or(Column<>4)) Then Exit;
  Data:=stItems.GetNodeData(Node);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.Level<>0)Or(Data.RowData.dbRow=Nil)Or(Data.RowData.dbRow['flag_entr_parc'].AsInteger<>0)) Then Exit;
  with TargetCanvas do
       begin
         if toShowVertGridLines in stItems.TreeOptions.PaintOptions then
            Inc(CellRect.Right);
         if toShowHorzGridLines in stItems.TreeOptions.PaintOptions then
            Inc(CellRect.Bottom);
         ImageList1.Draw(TargetCanvas, CellRect.Left+(CellRect.Right-CellRect.Left-16) Div 2, CellRect.Top+(CellRect.Bottom-CellRect.Top-16) Div 2, 2+Integer((stItems.FocusedNode=Node)And(stItems.FocusedColumn=Column)));
    end;

end;

procedure TfmAgrupamento.cmdExpandAllClick(Sender: TObject);
begin
  stItems.FullExpand;
end;

procedure TfmAgrupamento.cmdCollapseAllClick(Sender: TObject);
begin
  stItems.FullCollapse;
end;

procedure TfmAgrupamento.cbClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return Then
     if Assigned(cmdSearch.OnClick) Then cmdSearch.OnClick(Self);
end;

procedure TfmAgrupamento.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmAgrupamento.stItemsChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var Data:PTreeData;
    sl  :TStringList;
   VincNode,
   aNode:PVirtualNode;
   isChecked:Boolean;
   I:Integer;
begin
  if Node=Nil Then Exit;
  aNode:=Node;
  While stItems.GetNodeLevel(aNode)>0 do
        Node:=aNode.Parent;
  if aNode=Nil Then Exit;
  Data:=stItems.GetNodeData(aNode);
  if ((Data=Nil)Or(Data.RowData=Nil)Or(Data.RowData.dbRow=Nil)Or(Data.RowData.dbRow.UserData=Nil)) Then Exit;
  IsChecked:=(stItems.CheckState[aNode] In [csMixedPressed, csCheckedNormal]);
  sl:=TStringList(Data.RowData.dbRow.UserData);
  For I:=0 to sl.Count-1 do
      if sl.Objects[I]<>Nil Then
         begin
           VincNode:=PVirtualNode(sl.Objects[I]);
           if ((VincNode<>Nil)And(VincNode<>aNode)) Then
              stItems.CheckState[VincNode]:=CheckStateToUse[IsChecked];
         end;
end;

procedure TfmAgrupamento.cmdUpdateClick(Sender: TObject);
var aParentNode, aNode:PVirtualNode;
    ParentIsChecked:Boolean;
    Data:PTreeData;
begin
  FslItemsChecked.Clear;
  aParentNode:=stItems.GetFirst;
  While aParentNode<>Nil do
        begin
          ParentIsChecked:=(stItems.CheckState[aParentNode] In [csMixedPressed, csCheckedNormal]);
          if ParentIsChecked Then
             begin
               aNode:=stItems.GetFirstChild(aParentNode);
               While aNode<>Nil do
                     begin
                       if ((stItems.CheckType[aNode]=ctNone)Or(stItems.CheckState[aNode] In [csMixedPressed, csCheckedNormal])) Then
                          begin
                            Data:=stItems.GetNodeData(aNode);
                            if ((Data<>Nil)And(Data.RowData<>Nil)And(Data.RowData.dbRow<>Nil)) Then
                               FslItemsChecked.Add(Data.RowData);
                          end;
                       aNode:=stItems.GetNextSibling(aNode);
                     end;
             end;
          aParentNode:=stItems.GetNextSibling(aParentNode);
        end;
  if FslItemsChecked.Count<1 Then
     begin
       MessageBox(Self.Handle,'Ao menos 1 ítem deve estar selecionado !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  with TfmNewCarga.Create(Self) do
       try
         fkEmpresas:=Self.FfkEmpresas;
         slItemsCarga:=Self.FslItemsChecked;
         if ShowModal<>mrOk Then Exit;
       finally
         Release;
       end;
  FCargasUpdated:=True;
  if Assigned(cmdSearch.OnClick) Then cmdSearch.OnClick(Self);     
end;

procedure TfmAgrupamento.stItemsBeforeCellPaint(Sender: TBaseVirtualTree;
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

end.
