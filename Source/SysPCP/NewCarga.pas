unit NewCarga;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, Buttons, VirtualTrees, CSDVirtualStringTree,
  Mask, ToolEdit, jpeg, ExtCtrls;

type
  TfmNewCarga = class(TForm)
    paDetails: TPanel;
    Shape1: TShape;
    im: TImage;
    StaticText1: TStaticText;
    StaticText9: TStaticText;
    StaticText4: TStaticText;
    dta_lim: TDateEdit;
    edDSC_CRG: TEdit;
    stItems: TCSDVirtualStringTree;
    Panel1: TPanel;
    cmdUpdate: TBitBtn;
    cmdCancel: TBitBtn;
    ImageList1: TImageList;
    edREF_CRG: TEdit;
    Label1: TLabel;
    laTotal: TLabel;
    Shape2: TShape;
    chkFLAG_ATIVO: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure stItemsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdUpdateClick(Sender: TObject);
  private
    { Private declarations }
    FslItemsCarga   :TList;
    FTotalItems     :Integer;
    FTotalM3        :Currency;
    FTotalPecas     :Integer;
    FfkEmpresas     :Integer;
    procedure ClearItems;
    procedure LoadItems;
  public
    { Public declarations }
    property slItemsCarga:TList read FslItemsCarga write FslItemsCarga;
    property fkEmpresas:Integer read FfkEmpresas write FfkEmpresas;
  end;

var
  fmNewCarga: TfmNewCarga;

implementation

uses dbObjects, udmCargas;

{$R *.dfm}

procedure TfmNewCarga.ClearItems;
begin
  FTotalM3:=0;
  FTotalPecas:=0;
  FTotalItems:=0;
  laTotal.Caption:='';
  stItems.Clear;
end;

procedure TfmNewCarga.FormCreate(Sender: TObject);
begin
  stItems.RootNodeCount :=0;
  stItems.NodeDataSize  :=SizeOf(TTreeData);
  FfkEmpresas           :=1;
end;

procedure TfmNewCarga.LoadItems;
var I:Integer;
    RowData:TRowData;
    Data:PTreeData;
    Node:PVirtualNode;
begin
  ClearItems;
  if ((FslItemsCarga=Nil)Or(FslItemsCarga.Count<1)) Then Exit;
  For I:=0 to FslItemsCarga.Count-1 do
      if FslItemsCarga[I]<>Nil Then
         begin
           RowData:=TRowData(FslItemsCarga[I]);
           if ((RowData<>Nil)And(RowData.dbRow<>Nil)) Then
              begin
                Node:=stItems.AddChild(Nil);
                Data:=stItems.GetNodeData(Node);
                Data.RowData:=RowData;
                Inc(FTotalItems);
                FTotalPecas:=FTotalPecas+RowData.dbRow['qtd_item'].AsInteger;
                FTotalM3:=FTotalM3+RowData.dbRow['qtd_item'].AsInteger*RowData.dbRow['M3'].AsFloat;
              end;
         end;
  laTotal.Caption:=Format('Total da Carga: %d ítens, %d peças, %s m3',[FTotalItems,FTotalPecas,FormatFloat('#,##0.0000',FTotalM3)]);
end;

procedure TfmNewCarga.FormDestroy(Sender: TObject);
begin
  ClearItems;
end;

procedure TfmNewCarga.stItemsGetText(Sender: TBaseVirtualTree;
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
            0:CellText:=IntToStr(dbRow['fk_pedidos'].AsInteger);
            1:CellText:=dbRow['raz_soc'].AsString;
            2:CellText:=dbRow['ref_reg'].AsString;
            3:if dbRow['dta_ped'].AsDateTime>0 Then
                 CellText:=FormatDateTime('dd/mm/yyyy',dbRow['dta_ped'].AsDateTime);
            4:CellText:=dbRow['cod_ref_item'].AsString;
            5:CellText:=IntToStr(dbRow['qtd_item'].AsInteger);
            6:CellText:=FormatFloat('#,##0.0000',dbRow['M3'].AsFloat);
       end;
end;

procedure TfmNewCarga.cmdCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmNewCarga.FormShow(Sender: TObject);
begin
  LoadItems;
end;

procedure TfmNewCarga.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Escape Then
     if Assigned(cmdCancel.OnClick) Then cmdCancel.OnClick(Self);
end;

procedure TfmNewCarga.cmdUpdateClick(Sender: TObject);
var dt:TDateTime;
     S:String;
     fkCargaProducao:Integer;
     aNode:PVirtualNode;
     Data:PTreeData;
begin
  if stItems.RootNodeCount<1 Then
     begin
       MessageBox(Self.Handle,'Ao menos um ítem deve estar relacionado para criação da carga !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  edREF_CRG.Text:=Trim(edREF_CRG.Text);
  if edREF_CRG.Text='' Then
     begin
       if edREF_CRG.CanFocus Then edREF_CRG.SetFocus;
       MessageBox(Self.Handle,'A Referência deve ser preenchida !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  edDSC_CRG.Text:=Trim(edDSC_CRG.Text);
  if edDSC_CRG.Text='' Then
     begin
       if edDSC_CRG.CanFocus Then edDSC_CRG.SetFocus;
       MessageBox(Self.Handle,'A Descrição deve ser preenchida !',PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  dt:=StrToDateDef(DTA_LIM.Text,0);
//  if dt=0 Then
//     begin
//       if edREF_CRG.CanFocus Then edREF_CRG.SetFocus;
//       MessageBox(Self.Handle,'A Referência deve ser preenchida !',PChar(Caption),MB_ICONSTOP);
//       Exit;
//     end;
  S:='';
  with dmCargas.qrCheckReferenciaCarga do
       try
         ParamByName('fk_empresas').AsInteger   :=FfkEmpresas;
         ParamByName('ref_crg').AsString        :=edREF_CRG.Text;
         Open;
         if Not(EOF) Then S:='Já foi cadastrada uma carga com esta referência !';
       finally
         Close;
       end;
  if S<>'' Then
     begin
       MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONSTOP);
       Exit;
     end;
  if dmCargas.tr.InTransaction Then dmCargas.tr.Commit;
  try
    with dmCargas.qrInsertCargaProducao do
         try
           ParamByName('fk_empresas').AsInteger   :=FfkEmpresas;
           ParamByName('ref_crg').AsString        :=edREF_CRG.Text;
           ParamByName('dsc_crg').AsString        :=edDSC_CRG.Text;
           ParamByName('flag_ativo').AsInteger    :=Integer(chkflag_ativo.Checked);
           if dt>0 Then ParamByName('dta_lim').AsDateTime:=dt
           else ParamByName('dta_lim').Clear;
           ExecSql;
         finally
           Close;
         end;
    with dmCargas.qrMaxCargaProducao do
         try
           ParamByName('fk_empresas').AsInteger :=FfkEmpresas;
           ParamByName('ref_crg').AsString      :=edREF_CRG.Text;
           Open;
           if Not(EOF) Then FkCargaProducao:=FieldByName('pk_cargas_producao').AsInteger
           else raise Exception.Create('Erro ocorrido durante a inclusão da carga !');
         finally
           Close;
         end;
    aNode:=stItems.GetFirst;
    While aNode<>Nil do
          begin
            Data:=stItems.GetNodeData(aNode);
            if ((Data<>Nil)And(Data.RowData<>Nil)And(Data.RowData.dbRow<>Nil)) Then
               with dmCargas.qrUpdatePedidosItems do
                    try
                      ParamByName('fk_empresas').AsInteger          :=FfkEmpresas;
                      ParamByName('fk_tipo_pedidos').AsInteger      :=Data.RowData.dbRow['fk_tipo_pedidos'].AsInteger;
                      ParamByName('fk_pedidos').AsInteger           :=Data.RowData.dbRow['fk_pedidos'].AsInteger;
                      ParamByName('pk_pedidos_itens').AsInteger     :=Data.RowData.dbRow['pk_pedidos_itens'].AsInteger;
                      ParamByName('fk_cargas_producao').ASInteger   :=fkCargaProducao;
                      ExecSql;
                    finally
                      Close;
                    end;
            aNode:=stItems.GetNext(aNode);
          end;
    dmCargas.tr.Commit;
  except
    On Exception do
       begin
         dmCargas.tr.Rollback;
         raise;
       end;
  end;
  S:='Carga "'+edREF_CRG.Text+'" Inclúida com sucesso !';
  MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONINFORMATION);
  ModalResult:=mrOk;
end;

end.
