unit CadVei;

{*************************************************************************}
{*                                                                       *}
{* Author   : Alcindo Schleder                                           *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created  : 19/05/2007 - DD/MM/YYYY                                    *}
{* Modified :                                                            *}
{* Version  : 1.0.0.0                                                    *}
{* License  : you can freely use and distribute the included code        *}
{*            for any purpouse, but you cannot remove this copyright     *}
{*            notice. Send me any comments and updates, they are really  *}
{*            appreciated. This software is licensed under MPL License,  *}
{*            see http://www.mozilla.org/MPL/ for details                *}
{* Contact  : alcindo@sistemaprocessa.com.br                             *}
{*            http://www.sistemaprocessa.com.br                          *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, StdCtrls, Mask, ToolEdit, CurrEdit, ComCtrls, ExtCtrls,
  ProcUtils, mSysTrans, Menus, ExtDlgs, TSysTrans, CadModel;

type
  TCdVehicle = class(TfrmModel)
    shTitle: TShape;
    lTitle: TLabel;
    lPk_Veiculos: TStaticText;
    ePk_Veiculos: TEdit;
    lDsc_Vei: TStaticText;
    eDsc_Vei: TEdit;
    pgTypeVei: TPageControl;
    tsSpecialData: TTabSheet;
    tsOwnerVehicle: TTabSheet;
    lFk_Centro_Custos: TStaticText;
    eFk_Centro_Custos: TComboBox;
    lAno_Vcl: TStaticText;
    eAno_Vcl: TCurrencyEdit;
    lPlaca_Vcl: TStaticText;
    eCpcd_Vcl: TCurrencyEdit;
    lCpcd_Vcl: TStaticText;
    ePlaca_Vcl: TEdit;
    eObs_Vei: TMemo;
    lFk_Produtos_Grupos: TStaticText;
    eFk_Produtos_Grupos: TComboBox;
    lFlag_Atv: TCheckBox;
    vtProdType: TVirtualStringTree;
    eFk_Unidades: TComboBox;
    lFk_Unidades: TStaticText;
    tsOtherOwner: TTabSheet;
    lFk_Fornecedores: TStaticText;
    eFk_Fornecedores: TComboBox;
    lNom_Mot: TStaticText;
    eNom_Mot: TEdit;
    pmImages: TPopupMenu;
    pmInsert: TMenuItem;
    pmDelete: TMenuItem;
    vtImages: TVirtualDrawTree;
    opImage: TOpenPictureDialog;
    ePk_Produtos: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtImagesGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtImagesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtImagesDrawHint(Sender: TBaseVirtualTree;
      HintCanvas: TCanvas; Node: PVirtualNode; R: TRect;
      Column: TColumnIndex);
    procedure vtImagesGetHintSize(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var R: TRect);
    procedure vtImagesGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vtImagesDrawNode(Sender: TBaseVirtualTree;
      const PaintInfo: TVTPaintInfo);
    procedure vtProdTypeGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtProdTypeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure vtProdTypeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtProdTypeFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure eFk_Produtos_GruposDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    FFkModels: Integer;
    FFkMarks: Integer;
    FTypeVehicle: TTypeVehicle;
    function  CheckRecord(const OldState, NewState: TDbMode): Boolean;
    function  GetCpcdVei: Double;
    function  GetDriverName: string;
    function  GetDscVei: string;
    function  GetFactYear: Integer;
    function  GetFkCostCenter: Integer;
    function  GetFkGroupVei: Integer;
    function  GetFkUnity: Integer;
    function  GetFkVehicleOwner: Integer;
    function  GetFlagActive: Boolean;
    function  GetIdVei: string;
    function  GetImgVei: TList;
    function  GetObsVei: TStrings;
    function  GetPkVehicle: Integer;
    function  GetProductType: TList;
    procedure ClearvtImages;
    procedure LoadTypeProds;
    procedure SetCpcdVei(const Value: Double);
    procedure SetDriverName(const Value: string);
    procedure SetDscVei(const Value: string);
    procedure SetFactYear(const Value: Integer);
    procedure SetFkCostCenter(const Value: Integer);
    procedure SetFkGroupVei(const Value: Integer);
    procedure SetFkMarks(const Value: Integer);
    procedure SetFkModels(const Value: Integer);
    procedure SetFkUnit(const Value: Integer);
    procedure SetFkVehicleOwner(const Value: Integer);
    procedure SetFlagActive(const Value: Boolean);
    procedure SetIdVei(const Value: string);
    procedure SetImgVei(const Value: TList);
    procedure SetObsVei(const Value: TStrings);
    procedure SetPkVehicle(const Value: Integer);
    procedure SetTypeVehicle(const Value: TTypeVehicle);
    function GetPkProduct: Integer;
    procedure SetPkProduct(const Value: Integer);
  protected
    { Protected declarations }
    procedure ClearControls; override;
    procedure LoadDefaults; override;
    procedure MoveDataToControls; override;
    procedure SaveIntoDB; override;
  public
    { Public declarations }
    property TypeVehicle   : TTypeVehicle read FTypeVehicle      write SetTypeVehicle;
    property FkMarks       : Integer      read FFkMarks          write SetFkMarks;
    property FkModels      : Integer      read FFkModels         write SetFkModels;
    property PkVehicle     : Integer      read GetPkVehicle      write SetPkVehicle;
    property CpcdVei       : Double       read GetCpcdVei        write SetCpcdVei;
    property DscVei        : string       read GetDscVei         write SetDscVei;
    property FkCostCenter  : Integer      read GetFkCostCenter   write SetFkCostCenter;
    property FactYear      : Integer      read GetFactYear       write SetFactYear;
    property IdVei         : string       read GetIdVei          write SetIdVei;
    property ObsVei        : TStrings     read GetObsVei         write SetObsVei;
    property ImgVei        : TList        read GetImgVei         write SetImgVei;
    property PkProduct     : Integer      read GetPkProduct      write SetPkProduct;
    property FkGroupVei    : Integer      read GetFkGroupVei     write SetFkGroupVei;
    property FlagActive    : Boolean      read GetFlagActive     write SetFlagActive;
    property FkUnity       : Integer      read GetFkUnity        write SetFkUnit;
    property ProductType   : TList        read GetProductType;
    property FkVehicleOwner: Integer      read GetFkVehicleOwner write SetFkVehicleOwner;
    property DriverName    : string       read GetDriverName     write SetDriverName;
  end;

var
  CdVehicle: TCdVehicle;

implementation

uses Dado, Funcoes, FuncoesDB, ProcType, GridRow, TSysFatAux, ArqSqlTrans, DB;

{$R *.dfm}

function TCdVehicle.CheckRecord(const OldState, NewState: TDbMode): Boolean;
begin
  Result := True;
end;

procedure TCdVehicle.ClearControls;
begin
  Loading := True;
  try
    PkVehicle      := 0;
    CpcdVei        := 0.0;
    DscVei         := '';
    FkCostCenter   := 0;
    FactYear       := 1970;
    IdVei          := '';
    ObsVei         := nil;
    ImgVei         := nil;
    FkGroupVei     := 0;
    FlagActive     := True;
    FkUnity        := 0;
    FkVehicleOwner := 0;
    DriverName     := '';
  finally
    Loading := False;
  end;
end;

procedure TCdVehicle.ClearvtImages;
var
  Data: PVehicleImage;
  Node: PVirtualNode;
begin
  with vtImages do
  begin
    if RootNodeCount = 0 then exit;
    BeginUpdate;
    try
      Node   := GetFirst;
      while Node <> nil do
      begin
        Data  := GetNodeData(Node);
        if Data <> nil then
        begin
          if Data^.Image <> nil then
            Data^.Image.Free;
          Data^.Image := nil;
          Data^.Name  := '';
        end;
        Node := GetNext(Node);
      end;
      Clear;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCdVehicle.FormCreate(Sender: TObject);
begin
  inherited;
  OnCheckRecord            := CheckRecord;
  pmImages.Images          := Dados.Image16;
  vtImages.Images          := Dados.Image16;
  vtImages.Header.Images   := Dados.Image16;
  vtProdType.Images        := Dados.Image16;
  vtProdType.Header.Images := Dados.Image16;
end;

procedure TCdVehicle.FormDestroy(Sender: TObject);
begin
  inherited;
  OnCheckRecord := nil;
  ClearvtImages;
  ReleaseCombos(eFk_Produtos_Grupos, toObject);
  ReleaseTreeNodes(vtProdType);
end;

function TCdVehicle.GetCpcdVei: Double;
begin
  Result := eCpcd_Vcl.Value;
end;

function TCdVehicle.GetDriverName: string;
begin
  Result := eNom_Mot.Text;
end;

function TCdVehicle.GetDscVei: string;
begin
  Result := eDsc_Vei.Text;
end;

function TCdVehicle.GetFactYear: Integer;
begin
  Result := eAno_Vcl.AsInteger;
end;

function TCdVehicle.GetFkCostCenter: Integer;
begin
  with eFk_Centro_Custos do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdVehicle.GetFkGroupVei: Integer;
begin
  with eFk_Produtos_Grupos do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := TClassification(Items.Objects[ItemIndex]).Pk;
  end;
end;

function TCdVehicle.GetFkUnity: Integer;
begin
  with eFk_Unidades do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdVehicle.GetFkVehicleOwner: Integer;
begin
  with eFk_Fornecedores do
  begin
    Result := 0;
    if (ItemIndex > -1) and (Items.Objects[ItemIndex] <> nil) then
      Result := Integer(Items.Objects[ItemIndex]);
  end;
end;

function TCdVehicle.GetFlagActive: Boolean;
begin
  Result := lFlag_Atv.Checked;
end;

function TCdVehicle.GetIdVei: string;
begin
  Result := ePlaca_Vcl.Text;
end;

function TCdVehicle.GetImgVei: TList;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := TList.Create;
  with vtImages do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data = nil) and (Data^.DataRow <> nil) and
         (Data^.DataRow.ExternalData <> nil) then
        Result.Add(Data^.DataRow.ExternalData);
      Node := GetNext(Node);
    end;
  end;
end;

function TCdVehicle.GetObsVei: TStrings;
begin
  Result := eObs_Vei.Lines;
end;

function TCdVehicle.GetPkVehicle: Integer;
begin
  Result := StrToIntDef(ePk_Veiculos.Text, -1);
end;

function TCdVehicle.GetProductType: TList;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  Result := TList.Create;
  with vtProdType do
  begin
    Node := GetFirst;
    while (Node <> nil) do
    begin
      Data := GetNodeData(Node);
      if (Data = nil) and (Data^.DataRow <> nil) and
         (TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger) in UPDATE_MODE) then
        Result.Add(Data^.DataRow);
      Node := GetNext(Node);
    end;
  end;
end;

procedure TCdVehicle.LoadDefaults;
begin
  if (not ListLoaded) then
  begin
    eFk_Centro_Custos.Items.AddStrings(dmSysTrans.LoadCostCenter);
    eFk_Produtos_Grupos.Items.AddStrings(dmSysTrans.LoadProductGroups);
    eFk_Unidades.Items.AddStrings(dmSysTrans.LoadUnits);
    eFk_Fornecedores.Items.AddStrings(dmSysTrans.LoadCarriers);
    ListLoaded := True;
  end;
end;

procedure TCdVehicle.LoadTypeProds;
var
  Node: PVirtualNode;
  Data: PGridData;
begin
  ReleaseTreeNodes(vtProdType);
  with dmSysTrans do
  begin
    if qrSqlAux.Active then qrSqlAux.Close;
    qrSqlAux.SQL.Clear;
    qrSqlAux.SQL.Add(SqlVinculoTProd);
    vtProdType.BeginUpdate;
    Dados.StartTransaction(qrSqlAux);
    try
      if (qrSqlAux.Params.FindParam('FkProdutos') <> nil) then
        qrSqlAux.ParamByName('FkProdutos').AsInteger := Pk;
      if not qrSqlAux.Active then qrSqlAux.Open;
      while not qrSqlAux.Eof do
      begin
        Node := vtProdType.AddChild(nil);
        if (Node <> nil) then
        begin
          Data := vtProdType.GetNodeData(Node);
          if (Data <> nil) then
          begin
            Data^.Level   := 0;
            Data^.Node    := Node;
            Data^.DataRow := TDataRow.CreateFromDataSet(nil, qrSqlAux, True);
          end;
        end;
        qrSqlAux.Next;
      end;
    finally
      if qrSqlAux.Active then qrSqlAux.Close;
      Dados.CommitTransaction(qrSqlAux);
      vtProdType.EndUpdate;
    end;
  end;
end;

procedure TCdVehicle.MoveDataToControls;
var
  aItem: TDataRow;
begin
  Loading := True;
  try
    aItem          := dmSysTrans.Vehicles[Pk];
    if (aItem = nil) or (aItem.Count = 0) then
      raise Exception.Create('Veículo não encontrado');
    PkVehicle      := Pk;
    CpcdVei        := aItem.FieldByName['CPCD_VCL'].AsFloat;
    FkCostCenter   := aItem.FieldByName['FK_CENTRO_CUSTOS'].AsInteger;
    FactYear       := aItem.FieldByName['ANO_VCL'].AsInteger;;
    IdVei          := aItem.FieldByName['PLACA_VCL'].AsString;;
    if (FTypeVehicle = tvOwner) then
    begin
      aItem.Clear;
      aItem          := dmSysTrans.VehiclesProd[Pk];
      PkProduct      := aItem.FieldByName['PK_PRODUTOS'].AsInteger;
      DscVei         := aItem.FieldByName['DSC_PROD'].AsString;
      FkGroupVei     := aItem.FieldByName['FK_PRODUTOS_GRUPOS'].AsInteger;
      FlagActive     := Boolean(aItem.FieldByName['FLAG_ATV'].AsInteger);
      FkUnity        := aItem.FieldByName['FK_UNIDADES'].AsInteger;
      LoadTypeProds;
    end;
    if (FTypeVehicle = tvAgregates) then
    begin
      aItem.Clear;
      aItem          := dmSysTrans.VehiclesCarrier[Pk];
      FkVehicleOwner := aItem.FieldByName['FK_CADASTROS'].AsInteger;
      DriverName     := aItem.FieldByName['NOM_MOT'].AsString;
      DscVei         := aItem.FieldByName['DSC_VEI'].AsString;
    end;
    ImgVei         := dmSysTrans.VehiclesImg[Pk, ScrState];
    ObsVei         := dmSysTrans.VehiclesObs[Pk, ScrState];
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
end;

procedure TCdVehicle.SaveIntoDB;
var
  aItem : TDataRow;
begin
  Loading := True;
  try
    aItem          := TDataRow.Create(Self);
    aItem.AddAs('PK_VEICULOS', PkVehicle, ftInteger, SizeOf(Integer));
    aItem.AddAs('CPCD_VCL', CpcdVei, ftFloat, SizeOf(Double));
    aItem.AddAs('FK_CENTRO_CUSTOS', FkCostCenter, ftInteger, SizeOf(Integer));
    aItem.AddAs('ANO_VCL', FactYear, ftInteger, SizeOf(Integer));
    aItem.AddAs('PLACA_VCL', IdVei, ftInteger, SizeOf(Integer));
    aItem.AddAs('STATUS', Ord(ScrState), ftInteger, SizeOf(Integer));
    aItem.AddAs('TYPE_VEHICLE', Ord(FTypeVehicle), ftInteger, SizeOf(Integer));
    if (FTypeVehicle = tvOwner) then
    begin
      aItem.AddAs('DSC_PROD', DscVei, ftString, 51);
      aItem.AddAs('PK_PRODUTOS', PkProduct, ftInteger, SizeOf(Integer));
      aItem.AddAs('FK_PRODUTOS_GRUPOS', FkGroupVei, ftInteger, SizeOf(Integer));
      aItem.AddAs('FLAG_ATV', Ord(FlagActive), ftInteger, SizeOf(Integer));
      aItem.AddAs('FK_UNIDADES', Ord(FlagActive), ftInteger, SizeOf(Integer));
    end;
    if (FTypeVehicle = tvAgregates) then
    begin
      aItem.AddAs('NOM_MOT', DscVei, ftString, 51);
      aItem.AddAs('FK_CADASTROS', FkGroupVei, ftInteger, SizeOf(Integer));
    end;
    dmSysTrans.Vehicles[Pk] := aItem;
    dmSysTrans.VehiclesImg[aItem.FieldByName['PK_VEICULOS'].AsInteger, ScrState] := ImgVei;
    dmSysTrans.VehiclesObs[aItem.FieldByName['PK_VEICULOS'].AsInteger, ScrState] := ObsVei;
    aItem.Clear;
  finally
    Loading := False;
    FreeAndNil(aItem);
  end;
end;

procedure TCdVehicle.SetCpcdVei(const Value: Double);
begin
  eCpcd_Vcl.Value := Value;
end;

procedure TCdVehicle.SetDriverName(const Value: string);
begin
  eNom_Mot.Text := Value;
end;

procedure TCdVehicle.SetDscVei(const Value: string);
begin
  eDsc_Vei.Text := Value;
end;

procedure TCdVehicle.SetFactYear(const Value: Integer);
begin
  eAno_Vcl.AsInteger := Value;
end;

procedure TCdVehicle.SetFkCostCenter(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Centro_Custos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdVehicle.SetFkGroupVei(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Produtos_Grupos do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (TClassification(Items.Objects[i]).Pk = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdVehicle.SetFkMarks(const Value: Integer);
begin
  FFkMarks := Value;
  dmSysTrans.FkMark := Value;
end;

procedure TCdVehicle.SetFkModels(const Value: Integer);
begin
  FFkModels := Value;
  dmSysTrans.FkModel := Value;
end;

procedure TCdVehicle.SetFkUnit(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Unidades do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdVehicle.SetFkVehicleOwner(const Value: Integer);
var
  i: Integer;
begin
  with eFk_Fornecedores do
  begin
    ItemIndex := -1;
    for i := 0 to Items.Count - 1 do
    begin
      if (Items.Objects[i] <> nil) and (Integer(Items.Objects[i]) = Value) then
      begin
        ItemIndex := i;
        break;
      end;
    end;
  end;
end;

procedure TCdVehicle.SetFlagActive(const Value: Boolean);
begin
  lFlag_Atv.Checked := Value;
end;

procedure TCdVehicle.SetIdVei(const Value: string);
begin
  ePlaca_Vcl.Text := Value;
end;

procedure TCdVehicle.SetImgVei(const Value: TList);
var
  i: Integer;
  Node: PVirtualNode;
  Data: PVehicleImage;
begin
  ClearvtImages;
  if (Value = nil) then exit;
  with vtImages do
  begin
    for i := 0 to Value.Count - 1 do
    begin
      Node := AddChild(nil);
      if (Node <> nil) then
      begin
        Data := GetNodeData(Node);
        if (Data <> nil) then
        begin
          Data^.Image := TPicture.Create;
          Data^.Image.Assign(PVehicleImage(Value.Items[i])^.Image);
          Data^.Name  := PVehicleImage(Value.Items[i])^.Name;
        end;
      end;
    end;
  end;
end;

procedure TCdVehicle.SetObsVei(const Value: TStrings);
begin
  if (Value = nil) then
    eObs_Vei.Lines.Clear
  else
    eObs_Vei.Lines.Assign(Value);
end;

procedure TCdVehicle.SetPkVehicle(const Value: Integer);
begin
  ePk_Veiculos.Text := IntToStr(Value);
end;

procedure TCdVehicle.SetTypeVehicle(const Value: TTypeVehicle);
begin
  FTypeVehicle := Value;
  tsOwnerVehicle.TabVisible := (FTypeVehicle = tvOwner);
  tsOtherOwner.TabVisible   := (FTypeVehicle = tvAgregates);
end;

procedure TCdVehicle.vtImagesGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TVehicleImage);
end;

procedure TCdVehicle.vtImagesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PVehicleImage;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) then exit;
  CellText := Data^.Name;
end;

procedure TCdVehicle.vtImagesDrawHint(Sender: TBaseVirtualTree;
  HintCanvas: TCanvas; Node: PVirtualNode; R: TRect; Column: TColumnIndex);
var
  Data: PVehicleImage;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.Image = nil) then exit;
  HintCanvas.StretchDraw(R, Data^.Image.Graphic);
end;

procedure TCdVehicle.vtImagesGetHintSize(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var R: TRect);
var
  Data: PVehicleImage;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) and (Data^.Image = nil) then exit;
  R := Rect(0, 0, 0, 0);
  R := Rect(0, 0, Data^.Image.Width, Data^.Image.Height);
end;

procedure TCdVehicle.vtImagesGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PVehicleImage;
begin
  if (Node = nil) or (kind = ikOverlay) or (Column > 0) then exit;
  Data := Sender.GetNodeData(Node);
  Ghosted := False;
  if (Data = nil) then exit;
  ImageIndex := 32;
end;

procedure TCdVehicle.vtImagesDrawNode(Sender: TBaseVirtualTree;
  const PaintInfo: TVTPaintInfo);
var
  Data: PVehicleImage;
  S   : WideString;
  R   : TRect;
begin
  with Sender as TVirtualDrawTree, PaintInfo do
  begin
    if (Node = nil) then exit;
    Data := Sender.GetNodeData(Node);
    if (Data = nil) then exit;
    Canvas.Font.Size := 10;
    Canvas.Font.Style := [];
    if (Data^.State = dbmInsert) then
      Canvas.Font.Color := clRed
    else
      if (Data^.State = dbmDelete) then
        Canvas.Font.Color := clGray
      else
        Canvas.Font.Color := clBlue;
    SetBKMode(Canvas.Handle, TRANSPARENT);
    R := ContentRect;
    InflateRect(R, -TextMargin, 0);
    Dec(R.Right);
    Dec(R.Bottom);
    S := Data^.Name;
    if (NodeWidth - 2 * Margin) > (R.Right - R.Left) then
      S := ShortenString(Canvas.Handle, S, R.Right - R.Left, False);
    DrawTextW(Canvas.Handle, PWideChar(S), Length(S), R, DT_TOP or DT_LEFT or DT_VCENTER or DT_SINGLELINE, False);
  end;
end;

procedure TCdVehicle.vtProdTypeGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TGridData);
end;

procedure TCdVehicle.vtProdTypeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  CellText := Data^.DataRow.FieldByName['DSC_TPRD'].AsString;
end;

procedure TCdVehicle.vtProdTypeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  Data: PGridData;
begin
  if (Node = nil) then exit;
  Node.CheckType := ctCheckBox;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  Node.CheckState := csUncheckedNormal;
  if (Data^.DataRow.FindField['FK_PRODUTOS'].AsInteger > 0) then
    Node.CheckState := csCheckedNormal;
end;

procedure TCdVehicle.vtProdTypeFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data      : PGridData;
begin
  if (Node = nil) then exit;
  Data := vtProdType.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Node.CheckState = csCheckedNormal) then
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmInsert)
  else
    Data^.DataRow.FieldByName['STATUS'].AsInteger := Ord(dbmDelete);
{  if (Pk > 0) then
    ModifyProduct_X_Type(Data^.DataRow,
        TDBMode(Data^.DataRow.FieldByName['STATUS'].AsInteger), aPk)
    else
      ChangeGlobal(Self);}
end;

procedure TCdVehicle.eFk_Produtos_GruposDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  aClass : TClassification;
  aColor : TColor;
  aOffSet: Integer;
  aStr   ,
  aItmStr: string;
begin
  if (Index > TComboBox(Control).Items.Count) or
     (TComboBox(Control).Items.Objects[Index] = nil) or
     (not (TComboBox(Control).Items.Objects[Index] is TClassification)) then
  begin
    TComboBox(Control).Canvas.TextOut(Rect.Left, Rect.Top,
      TComboBox(Control).Items.Strings[Index]);
    TComboBox(Control).Canvas.Brush.Style := bsClear;
    TComboBox(Control).Canvas.DrawFocusRect(Rect);
    TComboBox(Control).Canvas.FrameRect(Rect);
    exit;
  end;
  aClass  := TClassification(TComboBox(Control).Items.Objects[Index]);
  aColor  := clGray;
  aOffSet := aClass.NivCta * 10;
  if aClass.FlagAnlSnt then
    aColor  := clWindowText;
  with (Control as TComboBox).Canvas do
  begin
    if (odSelected in State) then
      Font.Color := clWhite
    else
      Font.Color := aColor;
    aStr       := TComboBox(Control).Items.Strings[Index];
    aItmStr    := Copy(aStr, 1, Pos('|', aStr) - 1);
    Delete(aStr, 1, Pos('|', aStr));
    if ((TextWidth(Trim(aItmStr)) + Rect.Left + aOffSet) > (Rect.Left + 200)) then
    begin
      while ((TextWidth(Trim(aItmStr) + '...') + Rect.Left + aOffSet) > (Rect.Left + 200)) do
        Delete(aItmStr, Length(aItmStr), 1);
      aItmStr := aItmStr + '...'
    end;
    TextOut(Rect.Left + aOffSet, Rect.Top + 1, aItmStr);
    TextOut(Rect.Left + 200, Rect.Top + 1, aStr);
    if (odSelected in State) or
       (odFocused  in State) or
       (odHotLight in State) then
    begin
      TComboBox(Control).Canvas.Brush.Style := bsClear;
      TComboBox(Control).Canvas.DrawFocusRect(Rect);
      TComboBox(Control).Canvas.FrameRect(Rect);
    end;
  end;
end;

function TCdVehicle.GetPkProduct: Integer;
begin
  Result := StrToIntDef(ePk_Produtos.Text, 0);
end;

procedure TCdVehicle.SetPkProduct(const Value: Integer);
begin
  ePk_Produtos.Text := IntToStr(Value);
end;

end.
