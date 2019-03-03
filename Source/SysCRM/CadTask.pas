unit CadTask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VpEdPop, VpDateEdit, ExtCtrls, Buttons, vpData, Mask,
  ToolEdit, ProcUtils;

type
  TCdTasks = class(TForm)
    mDetails: TMemo;
    pButtons: TPanel;
    sbOk: TSpeedButton;
    sbCancel: TSpeedButton;
    pHeader: TPanel;
    stStatus: TStaticText;
    stCaption: TStaticText;
    imgCompleted: TImage;
    lDueDate: TStaticText;
    eDueDate: TDateEdit;
    cbComplete: TCheckBox;
    Bevel1: TBevel;
    lCompletedOn: TStaticText;
    lCreatedOn: TStaticText;
    eDescription: TEdit;
    lDescription: TStaticText;
    imgCalendar: TImage;
    stTaskStatus: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbOkClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure GlobalChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FLoading : Boolean;
    FResource: TVpResource;
    FScrMode : TDBMode;
    FTask    : TVpTask;
    procedure PopulateDialog;
    procedure DePopulateDialog;
    procedure SetScrMode(AValue: TDBMode);
    function  GetDescription: string;
    procedure SetDescription(AValue: string);
    procedure SetCreatedOn(AValue: TDate);
    procedure SetCompletedOn(AValue: TDate);
    function  GetDueDate: TDate;
    procedure SetDueDate(AValue: TDate);
    function  GetComplete: Boolean;
    procedure SetComplete(AValue: Boolean);
    function  GetDetails: string;
    procedure SetDetails(AValue: string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ATask: TVpTask;
                  AResource: TVpResource; AMode: TDBMode); reintroduce;
    property Task       : TvpTask  read FTask          write FTask;
    property ScrMode    : TDBMode  read FScrMode       write SetScrMode;
    property Description: string   read GetDescription write SetDescription;
    property CreatedOn  : TDate                        write SetCreatedOn;
    property CompletedOn: TDate                        write SetCompletedOn;
    property DueDate    : TDate    read GetDueDate     write SetDueDate;
    property Complete   : Boolean  read GetComplete    write SetComplete;
    property Details    : string   read GetDetails     write SetDetails;
  end;

{$I VpSR.INC}

var
  CdTasks: TCdTasks;

implementation

uses Dado, mSysCrm;

{$R *.dfm}

constructor TCdTasks.Create(AOwner: TComponent; ATask: TVpTask;
  AResource: TVpResource; AMode: TDBMode);
begin
  inherited Create(AOwner);
  BorderStyle       := bsNone;
  FTask             := ATask;
  FResource         := AResource;
  ScrMode           := AMode;
  stCaption.Caption := 'Cadastro de Tarefas';
  Caption           := stCaption.Caption;
end;

procedure TCdTasks.FormCreate(Sender: TObject);
begin
  Dados.Image16.GetBitmap(16, sbOk.Glyph);
  Dados.Image16.GetBitmap(56, sbCancel.Glyph);
  lDueDate.Caption     := RSDueDate;
  lDescription.Caption := RSDescription;
end;

procedure TCdTasks.FormShow(Sender: TObject);
begin
  PopulateDialog;
end;

procedure TCdTasks.FormDestroy(Sender: TObject);
begin
  FTask     := nil;
  FResource := nil;
end;

procedure TCdTasks.sbOkClick(Sender: TObject);
begin
  Task.Changed := True;
  DePopulateDialog;
  if (FScrMode in UPDATE_MODE) then
    dmSysCrm.SaveTask(FTask, FResource, FScrMode);
  Close;
end;

procedure TCdTasks.sbCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TCdTasks.DePopulateDialog;
begin
  FTask.Description := Description;
  FTask.DueDate     := DueDate;
  FTask.Complete    := Complete;
  if (FTask.CreatedOn = 0) then
    FTask.CreatedOn := Date;
  if (FTask.Complete) and (FTask.CompletedOn = 0) then
    FTask.CompletedOn := Date;
  FTask.Details     := Details;
end;

procedure TCdTasks.PopulateDialog;
var
  DaysOverdue: Integer;
begin
  FLoading    := True;
  Description := Task.Description;
  DueDate     := Task.DueDate;
  Details     := Task.Details;
  Complete    := Task.Complete;
  CompletedOn := Task.CompletedOn;
  CreatedOn   := Task.CreatedOn;
  DaysOverdue := Trunc(Now - Task.DueDate);
  if (not Task.Complete) and (DaysOverdue > 0) then
    stTaskStatus.Caption := Format(RSDlgTaskEdit + RSDaysOverdue, [DaysOverdue])
  else
    stTaskStatus.Visible := False;
  FLoading    := False;
end;

procedure TCdTasks.SetScrMode(AValue: TDBMode);
begin
  FScrMode              := AValue;
  stStatus.Color        := ColorMode[FScrMode];
  stStatus.Font.Color   := FontColorMode[FScrMode];
  stStatus.Caption      := ModeTypes[FScrMode];
end;

function  TCdTasks.GetDescription: string;
begin
  Result := eDescription.Text;
end;

procedure TCdTasks.SetDescription(AValue: string);
begin
  eDescription.Text := AValue;
end;

procedure TCdTasks.SetCreatedOn(AValue: TDate);
begin
  lCreatedOn.Caption := RSCreatedOn +  FormatDateTime(ShortDateFormat, AValue);
end;

procedure TCdTasks.SetCompletedOn(AValue: TDate);
begin
  lCompletedOn.Caption := RSCompletedOn + FormatDateTime(ShortDateFormat, AValue);
  lCompletedOn.Visible := (AValue > 0);
end;

function  TCdTasks.GetDueDate: TDate;
begin
  Result := eDueDate.Date;
end;

procedure TCdTasks.SetDueDate(AValue: TDate);
begin
  if (AValue = 0) then
    eDueDate.Clear
  else
    eDueDate.Date := AValue;
end;

function  TCdTasks.GetComplete: Boolean;
begin
  Result := cbComplete.Checked;
end;

procedure TCdTasks.SetComplete(AValue: Boolean);
begin
  cbComplete.Checked := AValue;
end;

function  TCdTasks.GetDetails: string;
begin
  Result := mDetails.Lines.Text;
end;

procedure TCdTasks.SetDetails(AValue: string);
begin
  mDetails.Lines.Text := AValue;
end;

procedure TCdTasks.GlobalChange(Sender: TObject);
begin
  if (not Assigned(FTask)) or(FLoading) or (FScrMode in UPDATE_MODE) then exit;
  if (FTask.RecordID > 0) then
    ScrMode := dbmEdit
  else
    ScrMode := dbmInsert;
  FTask.Changed := True;
end;

end.
