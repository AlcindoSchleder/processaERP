unit InputData;

{*************************************************************************}
{*                                                                       *}
{* Author: Alcindo Schleder                                              *}
{* Copyright: © 2003 by Alcindo Schleder. All rights reserved.           *}
{* Created: 07/01/2004 - DD/MM/YYYY                                      *}
{* Modified: 07/01/2004 - DD/MM/YYYY                                     *}
{* Version: 1.0.0.0                                                      *}
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

//uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
//  Dialogs, StdCtrls, DB, Buttons, RXCtrls, CurrEdit, Mask, Consts, ComCtrls;

{function InputTypedBox(const ACaption, APrompt: string;
  const ABoxType: TFieldType; var Value: Variant): Boolean;}

implementation

{function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

function InputTypedBox(const ACaption, APrompt: string;
  const ABoxType: TFieldType; var Value: Variant): Boolean;
var
  Form       : TForm;
  Prompt     : TLabel;
  Edit       : TControl;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      case ABoxType of
        ftVariant   ,
        ftWideString,
        ftString    : Edit := TEdit.Create(Form);
        ftSmallint  ,
        ftInteger   ,
        ftBytes     ,
        ftVarBytes  ,
        ftAutoInc   ,
        ftLargeint  ,
        ftWord      : Edit := TCurrencyEdit.Create(Form);
        ftBoolean   : Edit := TCheckBox.Create(Form);
        ftFloat     ,
        ftCurrency  ,
        ftFMTBcd    ,
        ftBCD       : Edit := TRxCalcEdit.Create(Form);
        ftDate      ,
        ftTime      ,
        ftTimeStamp ,
        ftDateTime  : Edit := TDateTimePicker.Create(Form);
      else
        Edit := TEdit.Create(Form);
      end;
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        if Edit.ClassType = TEdit then
        begin
          Width := MulDiv(164, DialogUnits.X, 4);
          TEdit(Edit).MaxLength := 255;
          TEdit(Edit).Text      := Value;
          TEdit(Edit).SelectAll;
        end;
        if Edit.ClassType = TCheckBox then
        begin
          TCheckBox(Edit).Caption := '';
          try
            TCheckBox(Edit).Checked := Value
          except
            TCheckBox(Edit).Checked := True
          end;
        end;
        if Edit.ClassType = TCurrencyEdit then
        begin
          TCurrencyEdit(Edit).DecimalPlaces := 0;
          TCurrencyEdit(Edit).DisplayFormat := ',0;- ,0';
          try
            TCurrencyEdit(Edit).Value := Value;
          except
            TCurrencyEdit(Edit).Value := 0;
          end;
          TCurrencyEdit(Edit).SelectAll;
        end;
        if Edit.ClassType = TDateTimePicker then
        begin
          try
            case ABoxType of
              ftDate, ftTimeStamp, ftDateTime:
                begin
                  TDateTimePicker(Edit).Kind := dtkDate;
                  TDateTimePicker(Edit).Date := Value;
                end;
              ftTime:
                begin
                  TDateTimePicker(Edit).Kind := dtkTime;
                  TDateTimePicker(Edit).Time := Value;
                end;
            end;
          except
            TDateTimePicker(Edit).Kind := dtkDate;
            TDateTimePicker(Edit).Date := Date;
          end;
        end;
        if Edit.ClassType = TRxCalcEdit then
        begin
          try
            TRxCalcEdit(Edit).Value := Value;
          except
            TRxCalcEdit(Edit).Value := 0;
          end;
          TRxCalcEdit(Edit).SelectAll;
        end;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        if Edit.ClassType = TEdit then
          Value := TEdit(Edit).Text;
        if Edit.ClassType = TCurrencyEdit then
          Value := TCurrencyEdit(Edit).Value;
        if Edit.ClassType = TDateTimePicker then
          case ABoxType of
            ftDate     ,
            ftTimeStamp,
            ftDateTime : Value := TDateTimePicker(Edit).Date;
            ftTime     : Value := TDateTimePicker(Edit).Time;
          end;
        if Edit.ClassType = TRxCalcEdit then
          Value := TRxCalcEdit(Edit).Value;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;}

end.
