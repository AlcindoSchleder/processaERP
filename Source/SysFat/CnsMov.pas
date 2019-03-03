unit CnsMov;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 06/03/2003 - DD/MM/YYYY                                      *}
{* Modified: 06/03/2003 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
{* License: you can freely use and distribute the included code          *}
{*         for any purpouse, but you cannot remove this copyright        *}
{*         notice. Send me any comments and updates, they are really     *}
{*         appreciated. This software is licensed under MPL License,     *}
{*         see http://www.mozilla.org/MPL/ for details                   *}
{* Contact: (alcindo@sistemaprocessa.com.br)                             *}
{*         http://www.sistemaprocessa.com.br                             *}
{*                                                                       *}
{*************************************************************************}

interface

uses
  Graphics, SysUtils, Variants, Classes, Controls, Forms, Dialogs, ExtCtrls,
  VirtualTrees, jpeg, StdCtrls, TSysBcCx, ImgList, Types;

type
  TMessageEvent = procedure (Sender: TObject; AMsg: string; AFontColor: TColor;
                    AClear: Boolean = False) of object;

  TfrmContas = class(TForm)
    pReal: TPanel;
    imReal: TImage;
    vtReal: TVirtualStringTree;
    pPrev: TPanel;
    imPrev: TImage;
    vtForecast: TVirtualStringTree;
    sDivisor: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure TreePaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtTreeBeforeItemErase(Sender: TBaseVirtualTree;
      Canvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
      var ItemColor: TColor; var EraseAction: TItemEraseAction);
  private
    { Private declarations }
    FRealFlow     : Double;
    FPrevFlow     : Double;
    FTotalFlow    : Double;
    FPriorDate    : TDate;
    FStartBaseDate: TDate;
    FEndBaseDate  : TDate;
    FOnMessagePgto: TMessageEvent;
    procedure SetStartBaseDate(AValue: TDate);
    procedure SetEndBaseDate(AValue: TDate);
    procedure SetTotalFlow(AValue: Double);
    procedure LoadGrids(Sender: TVirtualStringTree);
  public
    { Public declarations }
    procedure TestGrids;
    property StartBaseDate: TDate         read FStartBaseDate write SetStartBaseDate;
    property EndBaseDate  : TDate         read FEndBaseDate   write SetEndBaseDate;
    property TotalFlow    : Double        read FTotalFlow     write SetTotalFlow;
    property OnMessagePgto: TMessageEvent read FOnMessagePgto write FOnMessagePgto;
  end;

var
  frmContas: TfrmContas;

resourcestring
  STotalFlowMsg = 'Total do Período Somando Realizado e Previsto: %m';

implementation

{$R *.dfm}

uses FuncoesDB, DateUtils, mSysFat, ArqSqlFat, Dado, ProcType, GridRow, DB;

procedure TfrmContas.FormCreate(Sender: TObject);
begin
  FPriorDate               := 0;
  vtReal.Images            := Dados.Image16;
  vtReal.Header.Images     := Dados.Image16;
  vtForecast.Images        := Dados.Image16;
  vtForecast.Header.Images := Dados.Image16;
  vtReal.NodeDataSize      := SizeOf(TGridData);
  vtForecast.NodeDataSize  := SizeOf(TGridData);
  FStartBaseDate           := Date - 3;
  FEndBaseDate             := IncDay(Date, 7);
end;

procedure TfrmContas.FormShow(Sender: TObject);
begin
  // Show Event
  TestGrids;
end;

procedure TfrmContas.FormDestroy(Sender: TObject);
begin
  ReleaseTreeNodes(vtReal);
  ReleaseTreeNodes(vtForecast);
end;

procedure TfrmContas.SetStartBaseDate(AValue: TDate);
begin
  FStartBaseDate := AValue;
  TestGrids;
end;

procedure TfrmContas.SetEndBaseDate(AValue: TDate);
begin
  FEndBaseDate := AValue;
  TestGrids;
end;

procedure TfrmContas.SetTotalFlow(AValue: Double);
var
  aColor: TColor;
  aMsg  : string;
begin
  FTotalFlow := AValue;
  if FTotalFlow >= 0 then
    aColor := clGreen
  else
    aColor := clRed;
  if FTotalFlow = 0 then
    aMsg := ''
  else
    aMsg := Format(STotalFlowMsg, [FTotalFlow]);
  if Assigned(FOnMessagePgto) then
    FOnMessagePgto(Self, aMsg, aColor, True);
end;

procedure TfrmContas.TestGrids;
begin
  if (FStartBaseDate > 0) and (FEndBaseDate > 0) then
  begin
    LoadGrids(vtReal);
    LoadGrids(vtForecast);
  end;
end;

procedure TfrmContas.LoadGrids(Sender: TVirtualStringTree);
var
  Node: PVirtualNode;
  Data: PGridData;
  aCta: string;
  aDta: TDate;
//  aLan: Double;
  function AddNode(ANode: PVirtualNode): PVirtualNode;
  begin
    Result := Sender.AddChild(ANode);
    if (Result <> nil) then
    begin
      Data := Sender.GetNodeData(Result);
      if (Data <> nil) then
      begin
        Data^.Level   := 0;
        Data^.Node    := Result;
        Data^.DataRow := TDataRow.CreateFromDataSet(nil, dmSysFat.qrFinance, True);
      end;
    end;
  end;
begin
  aCta := '';
  aDta := 0;
  ReleaseTreeNodes(vtForecast);
  Node := nil;
  with dmSysFat do
  begin
    if qrFinance.Active then qrFinance.Close;
    qrFinance.SQL.Clear;
    qrFinance.SQL.Add(SqlLancamentosCta);
    Dados.StartTransaction(qrFinance);
    Sender.BeginUpdate;
    try
      qrFinance.ParamByName('FkEmpresas').AsInteger := Dados.PkCompany;
      qrFinance.ParamByName('StartDate').AsDate     := FStartBaseDate;
      qrFinance.ParamByName('EndDate').AsDate       := FEndBaseDate;
//      qrFinance.ParamByName('FlagTCta').AsInteger   := Ord();
      if not qrFinance.Active then qrFinance.Open;
      while (not qrFinance.Eof) do
      begin
        if (aCta <> qrFinance.FieldByName('DSC_CTA').AsString) then
          Node := AddNode(nil);
        if (Node <> nil) then
        begin
          AddNode(Node);
          aCta := qrFinance.FieldByName('DSC_CTA').AsString;
          aDta := qrFinance.FieldByName('DTA_LAN').AsDateTime;
        end;
        qrFinance.Next;
//        aLan := Data^.DataRow.FieldByName['VLR_LAN'].AsFloat;
//        if Data^.DataRow.FieldByName['FLAG_DBCR'].AsInteger = 0 then
//          aLan := aLan * -1;
        if (aDta = qrFinance.FieldByName('DTA_LAN').AsDateTime) and
           (Data <> nil) and (Data^.DataRow <> nil) then
          Data^.DataRow.FieldByName['SLD_LAN'].AsFloat := 0;
      end;
    finally
      if qrFinance.Active then qrFinance.Close;
      Dados.CommitTransaction(qrFinance);
      Sender.EndUpdate;
    end;
  end;
  Sender.FullExpand;
  TotalFlow := FPrevFlow + FRealFlow;
end;

procedure TfrmContas.TreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: PGridData;
  aVdb: Double;
  aVcr: Double;
  aDec: Integer;
begin
  if (Node = nil) then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  aDec := Dados.DecimalPlaces;
  if (Sender.GetNodeLevel(Node) = 0) then
    case Column of
      0: CellText := DateToStr(Date);
      1: CellText := Data^.DataRow.FieldByName['DSC_CTA'].AsString;
      2: CellText := ' ';
      3: CellText := ' ';
      4: CellText := FloatToStrF(Data^.DataRow.FieldByName['SLD_CTA'].AsFloat, ffNumber, 7, aDec);
      5: CellText := ' ';
    end
  else
  begin
    aVdb := 0;
    aVcr := 0;
    if Data^.DataRow.FieldByName['FLAG_DBCR'].AsInteger = 0 then
      aVdb := Data^.DataRow.FieldByName['VLR_LAN'].AsFloat;
    if Data^.DataRow.FieldByName['FLAG_DBCR'].AsInteger = 1 then
      aVcr := Data^.DataRow.FieldByName['VLR_LAN'].AsFloat;
    case Column of
      0: CellText := Data^.DataRow.FieldByName['DTA_LAN'].AsString;
      1: CellText := Data^.DataRow.FieldByName['DSC_LAN'].AsString;
      2: if aVdb > 0 then CellText := FloatToStrF(aVdb, ffNumber, 7, aDec) else CellText := ' ';
      3: if aVcr > 0 then CellText := FloatToStrF(aVcr, ffNumber, 7, aDec) else CellText := ' ';
      4: if (Data^.DataRow.FieldByName['SLD_LAN'].AsFloat = 0) then
           CellText := ' '
         else
           CellText := FloatToStrF(Data^.DataRow.FieldByName['SLD_LAN'].AsFloat, ffNumber, 7, aDec);
      5: CellText := Data^.DataRow.FieldByName['RAZ_SOC'].AsString;
    end
  end;
end;

procedure TfrmContas.TreePaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  if (Node = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
    TargetCanvas.Font.Style := [fsBold];
end;

procedure TfrmContas.vtTreeBeforeItemErase(Sender: TBaseVirtualTree;
  Canvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
var
  Data: PGridData;
begin
  if Node = nil then exit;
  Data := Sender.GetNodeData(Node);
  if (Data = nil) or (Data^.DataRow = nil) then exit;
  if (Sender.GetNodeLevel(Node) = 0) then
  begin
    Canvas.Brush.Color := clSkyBlue;
    ItemColor          := clSkyBlue;
  end
  else
    if (Data^.DataRow.FieldByName['SLD_LAN'].AsFloat = 0) then
    begin
      Canvas.Brush.Color := clInfoBk;
      ItemColor          := clInfoBk;
    end
    else
    begin
      Canvas.Brush.Color := clInfoBk;
      ItemColor          := clMoneyGreen;
    end;
  EraseAction := eaColor;
end;

end.
