unit MovFunction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  TFinanceFunction = (ffOpen, ffSale, ffOut, ffIn, ffBack, ffClose);

  TfMoveFunction = class(TForm)
    PGFunction    : TPageControl;
    tsLogin       : TTabSheet;
    tsOut         : TTabSheet;
    tsIn          : TTabSheet;
    eSenha        : TEdit;
    lPassword     : TStaticText;
    StaticText1   : TStaticText;
    StaticText2   : TStaticText;
    eSangriaValue : TEdit;
    eNumValue     : TEdit;
    StaticText3   : TStaticText;
    eSupervisor   : TEdit;
    sbEntra       : TSpeedButton;
    sbOut         : TSpeedButton;
    sbIn          : TSpeedButton;
    sbCancelLogin : TSpeedButton;
    sbCancelOut   : TSpeedButton;
    sbCancelIn    : TSpeedButton;
    procedure sbEntraClick  (Sender: TObject);
    procedure aIn           (Sender: TObject);
    procedure aOut          (Sender: TObject);
    procedure sbInClick     (Sender: TObject);
    procedure sbOutClick    (Sender: TObject);
    procedure FormShow      (Sender: TObject);
    procedure CancelFunction(Sender: TObject);

  private
    FOnOkClick     : TNotifyEvent;
    FOnInClick     : TNotifyEvent;
    FOnOutClick    : TNotifyEvent;
    fOnCancelClick : TNotifyEvent;
    FFinanceFunction: TFinanceFunction;
    procedure SetFinanceFunction(const Value: TFinanceFunction);
    { Private declarations }
  public
    { Public declarations }
    property OnOkClick       : TNotifyEvent      read FOnOkClick       write FOnOkClick;
    property OnInClick       : TNotifyEvent      read FOnInClick       write FOnInClick;
    property OnOutClick      : TNotifyEvent      read FOnOutClick      write FOnOutClick;
    property OnCancelClick   : TNotifyEvent      read FOnCancelClick   write FOnCancelClick;
    property FinanceFunction : TFinanceFunction  read FFinanceFunction write SetFinanceFunction;
  end;

var
  fMoveFunction: TfMoveFunction;

implementation

{$R *.dfm}

procedure TfMoveFunction.sbEntraClick(Sender: TObject);
begin
  if (Assigned(FOnOKClick)) and (eSenha.Text = 'processa') then
    FOnOkClick(Sender)
  else
    ShowMessage('Senha Inválida!');  
end;

procedure TfMoveFunction.SetFinanceFunction(const Value: TFinanceFunction);
begin
  if (Value <> FFinanceFunction) then
  begin
    FFinanceFunction := Value;
    case FFinanceFunction of
      ffOpen  : PGFunction.ActivePage := fMoveFunction.tsLogin;
      ffSale  : ShowMessage('Sale');
      ffOut   : OnOkClick := aOut;
      ffIn    : OnOkClick := aIn;
      ffBack  : PGFunction.ActivePage := fMoveFunction.tsLogin;
      ffClose : ShowMessage('Close');
    end;
    // configura a tela aqui
  end;
end;

procedure TfMoveFunction.aIN(Sender : TObject);
begin
  if eSenha.Text = 'processa' then
    PGFunction.ActivePage := tsIn
  else
    begin
      ShowMessage('Senha Inválida!');
    end;
end;

procedure TfMoveFunction.aOut(Sender : TObject);
begin
  if eSenha.Text = 'processa' then
    PGFunction.ActivePage := tsOut
  else
    begin
      ShowMessage('Senha Inválida!');
    end;
end;

procedure TfMoveFunction.sbInClick(Sender: TObject);
begin
  if (Assigned(FOnOkClick)) and (eSenha.Text = 'processa') then
    FOnInClick(Sender);
end;

procedure TfMoveFunction.sbOutClick(Sender: TObject);
begin
  if (Assigned(FOnOkClick)) and (eSenha.Text = 'processa') then
    FOnOutClick(Sender);
end;

procedure TfMoveFunction.FormShow(Sender: TObject);
begin
  PGFunction.ActivePage := tsLogin;
  eSupervisor.SetFocus;
end;

procedure TfMoveFunction.CancelFunction(Sender : TObject);
begin
  if (Assigned(FOnCancelClick)) then
    FOnCancelClick(Sender);
end;

end.

