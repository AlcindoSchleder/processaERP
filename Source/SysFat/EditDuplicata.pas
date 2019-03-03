unit EditDuplicata;

 {*************************************************************************}
 {*                                                                       *}
 {* Author: CSD Informatica                                               *}
 {* Copyright: © 2003 by CSD Informatica. All rights reserved.            *}
 {* Created: 03/06/2003 - DD/MM/YYYY                                      *}
 {* Modified: 03/06/2003 - DD/MM/YYYY                                     *}
 {* Version: 1.0.0.0                                                      *}
 {* License: you can freely use and distribute the included code          *}
 {*         for any purpouse, but you cannot remove this copyright        *}
 {*         notice. Send me any comments and updates, they are really     *}
 {*         appreciated. This software is licensed under MPL License,     *}
 {*         see http://www.mozilla.org/MPL/ for details                   *}
 {* Contact: (jorge@csd.com.br)                                           *}
 {*         http://www.csd.com.br                                         *}
 {*                                                                       *}
 {*************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridRow, ToolEdit, CurrEdit, ExtCtrls, StdCtrls, Mask,
  Buttons;

type
  TUpdateDuplicataEvent = procedure(adbRow : TDataRow) of object;

  TfmEditDuplicata = class(TForm)
    Panel4: TPanel;
    Label10: TStaticText;
    cmdNew: TSpeedButton;
    cmdUpdate: TSpeedButton;
    Label3: TStaticText;
    Label5: TStaticText;
    laHIST_LAN: TStaticText;
    edHIST_LAN: TEdit;
    edDTA_VENC: TDateEdit;
    edDTA_PGTO: TDateEdit;
    chkFLAG_CBR_JUR: TCheckBox;
    chkFLAG_BAIXA: TCheckBox;
    gbValues: TGroupBox;
    stVLR_VENC: TStaticText;
    stVLR_ACR_DSCT: TStaticText;
    stVLR_DSP_CBR: TStaticText;
    stVLR_ODSP: TStaticText;
    stVLR_PGTO: TStaticText;
    edVLR_VENC: TCurrencyEdit;
    edVLR_ACR_DSCT: TCurrencyEdit;
    edVLR_DSP_CBR: TCurrencyEdit;
    edVLR_ODSP: TCurrencyEdit;
    edVLR_PGTO: TCurrencyEdit;
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure cmdNewClick(Sender : TObject);
    procedure SignalizeChange(Sender : TObject);
    procedure edVLR_VENCChange(Sender : TObject);
    procedure edVLR_PGTOChange(Sender : TObject);
    procedure cmdUpdateClick(Sender : TObject);
  private
    { Private declarations }
    FdbRow: TDataRow;
    FIsNew: Boolean;
    FReadOnly: Boolean;
    FInsideMove: Boolean;
    FOnInsertDuplicata: TUpdateDuplicataEvent;
    FOnUpdateDuplicata: TUpdateDuplicataEvent;
    procedure SetdbRowToEdit(const Value : TDataRow);
    procedure EnableFields;
  public
    { Public declarations }
    property dbRowToEdit: TDataRow Write SetdbRowToEdit;
    property ReadOnly: Boolean Read FReadOnly Write FReadOnly;
    property OnInsertDuplicata: TUpdateDuplicataEvent
      Read FOnInsertDuplicata Write FOnInsertDuplicata;
    property OnUpdateDuplicata: TUpdateDuplicataEvent
      Read FOnUpdateDuplicata Write FOnUpdateDuplicata;
  end;

var
  fmEditDuplicata: TfmEditDuplicata;

implementation

uses mSysFat, ArqSqlFat, Dado;

{$R *.dfm}

{ TfmEditDuplicata }

procedure TfmEditDuplicata.EnableFields;
begin
  edDTA_VENC.Enabled      := ((not (FReadOnly)) and
                             (FdbRow.FieldByName['PK_DUPLICATAS'].AsInteger < 1));
  chkFLAG_CBR_JUR.Enabled := edDTA_VENC.Enabled;
  edDTA_PGTO.Enabled      := ((not (FReadOnly)) and (not (chkFLAG_BAIXA.Checked)));
  edVLR_VENC.Enabled      := edDTA_VENC.Enabled;
  edVLR_ACR_DSCT.Enabled  := edDTA_VENC.Enabled;
  edVLR_DSP_CBR.Enabled   := (( not (FReadOnly)) and (edDTA_PGTO.Enabled));
  edVLR_ODSP.Enabled      := (( not (FReadOnly)) and (edDTA_PGTO.Enabled));
  edVLR_PGTO.Enabled      := (( not (FReadOnly)) and (edDTA_PGTO.Enabled));
  cmdUpdate.Enabled       := False;
end;

procedure TfmEditDuplicata.SetdbRowToEdit(const Value : TDataRow);
begin
  FIsNew := (Value = nil);
  if FIsNew then
  begin
    FdbRow.Free;
    FdbRow := TDataRow.CreateFromDataSet(nil, dmSysFat.qrDuplicata, False);
  end
  else
    FdbRow.CopyRowValues(Value, False);
  if FdbRow.FieldByName['DTA_VENC'].AsDateTime = 0 then
    edDTA_VENC.Text       := ''
  else
    edDTA_VENC.Date       := FdbRow.FieldByName['DTA_VENC'].AsDateTime;
  if FdbRow.FieldByName['DTA_PGTO'].AsDateTime = 0 then
    edDTA_PGTO.Text       := ''
  else
    edDTA_PGTO.Date       := FdbRow.FieldByName['DTA_PGTO'].AsDateTime;
  chkFLAG_CBR_JUR.Checked := (FdbRow.FieldByName['FLAG_CBR_JUR'].AsInteger <> 0);
  chkFLAG_BAIXA.Checked   := (FdbRow.FieldByName['FLAG_BAIXA'].AsInteger <> 0);
  edHIST_LAN.Text         := FdbRow.FieldByName['HIST_LAN'].AsString;
  edVLR_VENC.Value        := FdbRow.FieldByName['VLR_VENC'].AsFloat;
  edVLR_ACR_DSCT.Value    := FdbRow.FieldByName['VLR_ACR_DSCT'].AsFloat;
  edVLR_DSP_CBR.Value     := FdbRow.FieldByName['VLR_DSP_CBR'].AsFloat;
  edVLR_ODSP.Value        := FdbRow.FieldByName['VLR_ODSP'].AsFloat;
  edVLR_PGTO.Value        := FdbRow.FieldByName['VLR_PGTO'].AsFloat;
  EnableFields;
end;

procedure TfmEditDuplicata.FormCreate(Sender : TObject);
begin
  with dmSysFat.qrDuplicata do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(SqlCancelDoc);
    Dados.StartTransaction(dmSysFat.qrDuplicata);
    FdbRow := TDataRow.CreateFromDataSet(nil, dmSysFat.qrDuplicata, False);
    if Active then Close;
  end;
  Dados.CommitTransaction(dmSysFat.qrDuplicata);
  FIsNew := True;
end;

procedure TfmEditDuplicata.FormDestroy(Sender : TObject);
begin
  FdbRow.Free;
  FdbRow := nil;
end;

procedure TfmEditDuplicata.cmdNewClick(Sender : TObject);
begin
  dbRowToEdit := nil;
end;

procedure TfmEditDuplicata.SignalizeChange(Sender : TObject);
begin
  if FInsideMove then
    Exit;
  if not (cmdUpdate.Enabled) then
    cmdUpdate.Enabled := True;
end;

procedure TfmEditDuplicata.edVLR_VENCChange(Sender : TObject);
begin
  SignalizeChange(Sender);
end;

procedure TfmEditDuplicata.edVLR_PGTOChange(Sender : TObject);
begin
  if edVLR_PGTO.Value < 0 then
    edVLR_PGTO.Value := 0;
  chkFLAG_BAIXA.Checked := (edVLR_PGTO.Value = edVLR_VENC.Value + edVLR_ACR_DSCT.Value);
  SignalizeChange(Sender);
end;

procedure TfmEditDuplicata.cmdUpdateClick(Sender : TObject);
var
  dtVenc, dtPgto:      TDateTime;
  MustUpdateAllFields: Boolean;
begin
  MustUpdateAllFields := ((not (FReadOnly)) and (FdbRow.FieldByName['PK_DUPLICATAS'].AsInteger < 1));
  edHIST_LAN.Text     := Trim(edHIST_LAN.Text);
  if MustUpdateAllFields then
  begin
    if edVLR_VENC.Value < 0.009 then
    begin
      if edVLR_VENC.CanFocus then
        edVLR_VENC.SetFocus;
      MessageBox(Self.Handle, 'O Valor da Duplicata deve ser informado !',
        PChar(Caption), MB_ICONSTOP);
      Exit;
    end;
    dtVenc := StrToDateDef(edDTA_VENC.Text, 0);
    if dtVenc = 0 then
    begin
      if edDTA_VENC.CanFocus then
        edDTA_VENC.SetFocus;
      MessageBox(Self.Handle, 'Data de Vencimento inválida !',
        PChar(Caption), MB_ICONSTOP);
      Exit;
    end;
    FdbRow.FieldByName['DTA_VENC'].AsDateTime  := dtVenc;
    FdbRow.FieldByName['VLR_VENC'].AsFloat     := edVLR_VENC.Value;
    FdbRow.FieldByName['VLR_ACR_DSCT'].AsFloat := edVLR_ACR_DSCT.Value;
  end;
  dtPgto := StrToDateDef(edDTA_PGTO.Text, 0);
  if ((edVLR_PGTO.Value > 0.009) and (dtPgto = 0)) then
  begin
    if edDTA_PGTO.CanFocus then
      edDTA_PGTO.SetFocus;
    MessageBox(Self.Handle, 'A Data de Pagamento deve ser especificada !',
      PChar(Caption), MB_ICONSTOP);
    Exit;
  end;
  if ((edVLR_PGTO.Value < 0.009) and (dtPgto > 0)) then
  begin
       //S:='A Data de Pagamento só pode ser especificada em conjunto com o valor do pagamento !'+#13#10+
      //    'Deseja limpar a data de pagamento ?';
       //if MessageBox(Self.Handle,PChar(S),PChar(Caption),MB_ICONWARNING OR MB_YESCANCEL)<>IDYES Then Exit;
    edDTA_PGTO.Text := '';
    dtPgto := 0;
  end;
  if ((edVLR_PGTO.Value > 0.009) and (dtPgto > 0)) then
  begin
    if (Abs(edVLR_PGTO.Value - (edVLR_VENC.Value + edVLR_ACR_DSCT.Value)) > 0.009) then
    begin
      if edVLR_PGTO.CanFocus then
        edVLR_PGTO.SetFocus;
      MessageBox(Self.Handle,
        'O Valor do Pagamento deve ser igual ao sub-total mais os acréscimos/descontos !',
        PChar(Caption), MB_ICONSTOP);
      Exit;
    end;
    FdbRow.FieldByName['DTA_PGTO'].AsDateTime  := dtPgto;
    FdbRow.FieldByName['VLR_PGTO'].AsFloat     := edVLR_PGTO.Value;
  end;
  FdbRow.FieldByName['VLR_DSP_CBR'].AsFloat    := edVLR_DSP_CBR.Value;
  FdbRow.FieldByName['VLR_ODSP'].AsFloat       := edVLR_ODSP.Value;
  FdbRow.FieldByName['HIST_LAN'].AsString      := edHIST_LAN.Text;
  FdbRow.FieldByName['FLAG_CBR_JUR'].AsInteger := Integer(chkFLAG_CBR_JUR.Checked);
  FdbRow.FieldByName['FLAG_BAIXA'].AsInteger   := Integer(chkFLAG_BAIXA.Checked);
  if FIsNew then
    if Assigned(FOnInsertDuplicata) then
      FOnInsertDuplicata(FdbRow)
    else
  else
  if Assigned(FOnUpdateDuplicata) then
    FOnUpdateDuplicata(FdbRow);
  FIsNew := False;
  EnableFields;
end;

end.
