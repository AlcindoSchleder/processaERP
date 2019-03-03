unit TrnspMem;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls;

const
  TMWM__SpecialInvalidate = WM_USER + 1111;

type

{TTransparentMemo}

  TTransparentMemo = class(TMemo)
  private
    procedure SpecialInvalidate(var Message:TMessage); message TMWM__SpecialInvalidate;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMSetText(var Message:TWMSetText); message WM_SETTEXT;
    procedure CNCTLCOLOREDIT(var Message:TWMCTLCOLOREDIT); message CN_CTLCOLOREDIT;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure GetMemoLinCol(var ALin, ACol: Integer);
    procedure MemoCursorTo(ALin, ACol: Integer);
    procedure ScrollTop;
    procedure ScrollBottom;
    procedure ScrollLineUp;
    procedure ScrollLineDown;
  end;

implementation

{TTransparentMemo}

constructor TTransparentMemo.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csCaptureMouse, csDesignInteractive,
  csClickEvents,  csSetCaption, csOpaque, csDoubleClicks,
    csReplicatable, csNoStdEvents];
end;

procedure TTransparentMemo.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
   ExStyle := ExStyle or WS_EX_TRANSPARENT and not WS_EX_WINDOWEDGE
                  and not WS_EX_STATICEDGE and not WS_EX_DLGMODALFRAME
                  and not WS_EX_CLIENTEDGE;
  end;
end;

procedure TTransparentMemo.WMHScroll(var Message: TWMHScroll);
begin
  inherited;
  PostMessage(Handle, TMWM__SpecialInvalidate, 0, 0);
end;

procedure TTransparentMemo.WMVScroll(var Message: TWMVScroll);
begin
  SendMessage(Handle, TMWM__SpecialInvalidate, 0, 0);
  inherited;
  PostMessage(Handle, TMWM__SpecialInvalidate, 0, 0);
end;

procedure TTransparentMemo.CNCTLCOLOREDIT(var Message: TWMCTLCOLOREDIT);
begin
  with Message do
  begin
    SetBkMode(ChildDC, TRANSPARENT);
    Result := GetStockObject(HOLLOW_BRUSH)
  end
end;

procedure TTransparentMemo.WMSetText(var Message:TWMSetText);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    PostMessage(Handle, TMWM__SpecialInvalidate, 0, 0)
end;

procedure TTransparentMemo.SpecialInvalidate(var Message:TMessage);
var
 r: TRect;
begin
  if Parent <> nil then
  begin
    r := ClientRect;
    r.TopLeft := Parent.ScreenToClient(ClientToScreen(r.TopLeft));
    r.BottomRight := Parent.ScreenToClient(ClientToScreen(r.BottomRight));
    InvalidateRect(Parent.Handle, @r, true);
    RedrawWindow(Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE)
  end;
end;

procedure TTransparentMemo.WMKeyDown(var Message: TWMKeyDown);
begin
  SendMessage(Handle, TMWM__SpecialInvalidate, 0, 0);
  inherited;
  PostMessage(Handle, TMWM__SpecialInvalidate, 0, 0);
end;

procedure TTransparentMemo.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1
end;

procedure TTransparentMemo.GetMemoLinCol(var ALin, ACol: Integer);
begin
  ALin := SendMessage(Self.Handle, EM_LINEFROMCHAR, SelStart, 0);
  ACol := SelStart - SendMessage(Self.Handle, EM_LINEINDEX, ALin, 0) + 1;
end;

procedure TTransparentMemo.MemoCursorTo(ALin, ACol: Integer);
begin
  SelStart := SendMessage(Self.Handle, EM_LINEINDEX, ALin, 0) + ACol - 1;
end;

procedure TTransparentMemo.ScrollTop;
begin
  SendMessage(Self.Handle, WM_VSCROLL, SB_TOP, 0);
end;

procedure TTransparentMemo.ScrollBottom;
begin
  SendMessage(Self.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TTransparentMemo.ScrollLineUp;
begin
  SendMessage(Self.Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

procedure TTransparentMemo.ScrollLineDown;
begin
  SendMessage(Self.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

end.
