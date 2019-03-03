unit MultiEdit;

{**************************************************************************}
{* TCalculator, TCalendario, TMultiEdit, TPrcComboBox: a useful           *}
{*              editbox with integrated calculator, Value (Int or Float)  *}
{*              converter, integrated calendar, DateTime converter and    *}
{*              a button that can be visible or invisible, transforming   *}
{*              the component in a multiuse tool.                         *}
{*                                                                        *}
{* Author   : Alcindo Schlder                                             *}
{* Copyright: © 2001 by Alcindo Schleder. All rights reserved.            *}
{* Created  : 22/09/2001                                                  *}
{* Modified : 22/09/2001                                                  *}
{* Version  : 1.0                                                         *}
{* License  : you can freely use and distribute the included code         *}
{*            for any purpouse, but you cannot remove this copyright      *}
{*            notice. Send me any comment and update, they are really     *}
{*            appreciated.                                                *}
{* Contact: alcindo@sistemaprocessa.com.br                                *}
{*          www.sistemaprocessa.com.br                                    *}
{**************************************************************************}

interface

uses Windows, Messages, MaskUtils, SysUtils, Classes, DB, Variants, Forms,
     Mask, Graphics, DBCtrls, Controls, Dialogs, Buttons, StdCtrls, ExtCtrls,
     Grids, DateUtils, Math, funcs, ComCtrls;

type
{ TCustomCalendar }
  TCustomCalendar = class (TCustomGrid)
  private
    FDate: TDateTime;
    FDay: Word;
    FMonth: Word;
    FMonthOffset: Integer;
    FOnChange: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnEnter: TNotifyEvent;
    FOnExit: TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FReadOnly: Boolean;
    FWeekendColor: TColor;
    FWeekends: TDaysOfWeek;
    FYear: Word;
    procedure ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer);
    function IsWeekend(ACol, ARow: Integer): Boolean;
  protected
    procedure Change; virtual;
    procedure Click; override;
    function DayNum(ACol, ARow: Integer): Integer;
    procedure DblClick; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: 
            TGridDrawState); override;
    function GetDateElement(Index: Integer): Integer;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: 
            Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); 
            override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure SetDate(const Value: TDateTime);
    procedure SetDateElement(Index: Integer; Value: Integer);
    procedure SetWeekendColor(const AValue: TColor);
    procedure SetWeekends(const AValue: TDaysOfWeek);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  public
    constructor Create(AOwner: TComponent; ADate: TDateTime = 0; AColor: TColor 
            = clWhite; AWeekColor: TColor = clRed; AWeekends: TDaysOfWeek = 
            [Sun]); reintroduce;
    destructor Destroy; override;
    procedure UpdateCalendar; virtual;
  published
    property Col;
    property Color;
    property Date: TDateTime read FDate write SetDate;
    property Day: Integer index 3 read GetDateElement write SetDateElement;
    property FixedColor;
    property GridLineWidth;
    property Hint;
    property Month: Integer index 2 read GetDateElement write SetDateElement;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property Row;
    property Selection;
    property WeekendColor: TColor read FWeekendColor write SetWeekendColor 
            default clRed;
    property Weekends: TDaysOfWeek read FWeekends write SetWeekends default 
            [Sun];
    property Width;
    property Year: Integer index 1 read GetDateElement write SetDateElement;
  end;
  

{ TCalendario }
  TCalendario = class (TCustomPanel)
  private
    FButtonHints: TStrings;
    FButtons: array[0..3] of TSpeedButton;
    FCalendar: TCustomCalendar;
    FCalendarColor: TColor;
    FDate: TDateTime;
    FGridLineWidth: Integer;
    FOnChange: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnDragDrop: TDragDropEvent;
    FOnDragOver: TDragOverEvent;
    FOnEndDrag: TEndDragEvent;
    FOnEnter: TNotifyEvent;
    FOnExit: TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseEvent;
    FOnStartDrag: TStartDragEvent;
    FPainel: TPanel;
    FpnSeTCalendario: TPanel;
    FReadOnly: Boolean;
    FSelectedMFmt: string;
    FStatus: TPanel;
    FStatusFormat: string;
    FStatusHint: string;
    FWeekendColor: TColor;
    FWeekends: TDaysOfWeek;
    procedure BoundsChanged;
    procedure SetButtonClick(Sender: TObject);
    procedure SetOnChange(Sender: TObject);
    procedure SetOnClick(Sender: TObject);
    procedure SetOnDblClick(Sender: TObject);
    procedure SetOnEnter(Sender: TObject);
    procedure SetOnExit(Sender: TObject);
    procedure SetOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: 
            TShiftState; X, Y: Integer);
    procedure SetOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: 
            Integer);
    procedure SetOnMouseUp(Sender: TObject; Button: TMouseButton; Shift: 
            TShiftState; X, Y: Integer);
  protected
    function GetDateElement(Index: Integer): Word;
    procedure SetButtonHints(AValue: TStrings);
    procedure SeTCalendarioColor(const AValue: TColor);
    procedure SetDate(const AValue: TDateTime);
    procedure SetDateElement(Index: Integer; Value: Word);
    procedure SetGridLineWidth(const AValue: Integer);
    procedure SetSelectedMFmt(const AValue: string);
    procedure SetStatusFormat(const AValue: string);
    procedure SetStatusHint(const AValue: string);
    procedure SetWeekendColor(const AValue: TColor);
    procedure SetWeekends(const AValue: TDaysOfWeek);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Action;
    property ActionLink;
    property Align;
    property Anchors;
    property BorderStyle;
    property ButtonHints: TStrings read FButtonHints write SetButtonHints;
    property CalendarColor: TColor read FCalendarColor write SeTCalendarioColor 
            default clWhite;
    property Color;
    property Date: TDateTime read FDate write SetDate;
    property Day: Word index 3 read GetDateElement write SetDateElement;
    property Enabled;
    property Font;
    property GridLineWidth: Integer read FGridLineWidth write SetGridLineWidth;
    property Height;
    property HelpContext;
    property HelpType;
    property Hint;
    property Month: Word index 2 read GetDateElement write SetDateElement;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnDragDrop: TDragDropEvent read FOnDragDrop write FOnDragDrop;
    property OnDragOver: TDragOverEvent read FOnDragOver write FOnDragOver;
    property OnEndDrag: TEndDragEvent read FOnEndDrag write FOnEndDrag;
    property OnEnter: TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit: TNotifyEvent read FOnExit write FOnExit;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnStartDrag: TStartDragEvent read FOnStartDrag write FOnStartDrag;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property SelectedMFmt: string read FSelectedMFmt write SetSelectedMFmt;
    property ShowHint;
    property StatusFormat: string read FStatusFormat write SetStatusFormat;
    property StatusHint: string read FStatusHint write SetStatusHint;
    property Tag;
    property Visible;
    property WeekendColor: TColor read FWeekendColor write SetWeekendColor 
            default clRed;
    property Weekends: TDaysOfWeek read FWeekends write SetWeekends default 
            [Sun];
    property Width;
    property Year: Word index 1 read GetDateElement write SetDateElement;
  end;
  

{ TPopupCalendar }
  TPopupCalendar = class (TCalendario)
  private
    FPopupVisible: Boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: 
            Integer); override;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl); reintroduce;
    destructor Destroy; override;
    procedure ShowPopup(Origin: TPoint);
  published
    property BorderStyle;
    property ButtonHints;
    property CalendarColor;
    property Date;
    property GridLineWidth;
    property Height;
    property HelpContext;
    property HelpType;
    property Hint;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property PopupVisible: Boolean read FPopupVisible write FPopupVisible 
            default False;
    property ReadOnly;
    property SelectedMFmt;
    property ShowHint;
    property StatusFormat;
    property StatusHint;
    property Tag;
    property Visible;
    property WeekendColor;
    property Weekends;
    property Width;
  end;
  

{ TCalcButton }
  TCalcButton = class (TSpeedButton)
  private
    FFontChanging: Boolean;
    FKind: TCalcBtnKind;
  protected
    procedure CMParentFontChanged(var Message: TMessage); message 
            CM_PARENTFONTCHANGED;
  public
    constructor CreateKind(AOwner: TComponent; AKind: TCalcBtnKind);
    property Kind: TCalcBtnKind read FKind;
  end;
  

{ TCustomCalculator }
  TCustomCalculator = class (TCustomPanel)
  private
    FAsInteger: Integer;
    FBeepOnError: Boolean;
    FButtons: array [cbNone..cbConvTo] of TCalcButton;
    FConversionRatio: Single;
    FDecimalDigits: ShortInt;
    FEnabled: Boolean;
    FHeightAnt: Integer;
    FMemory: Extended;
    FMemText: string;
    FNoComma: Boolean;
    FNumeric: Boolean;
    FOnCalcKey: TKeyPressEvent;
    FOnCancel: TNotifyEvent;
    FOnChange: TNotifyEvent;
    FOnChangeMemory: TNotifyEvent;
    FOnError: TNotifyEvent;
    FOnOK: TNotifyEvent;
    FOnResult: TNotifyEvent;
    FOperand: Double;
    FOperator: Char;
    FStatus: TCalcState;
    FText: string;
    FTypeCalc: TTypeCalc;
    FValue: Extended;
    FWidthAnt: Integer;
    procedure BoundsChanged;
    procedure BtnClick(Sender      : TObject);
    procedure CheckFirst;
    procedure Clear;
    procedure DataChanged;
    procedure Error;
    procedure SetAsInteger(const AValue: Integer);
    procedure SetConversionRatio(const AValue: Single);
    procedure SetDecimalDigits(const AValue: ShortInt);
    procedure SetValue(const AValue: Extended);
  protected
    procedure CalcKey(var Key: Char); dynamic;
    procedure ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    property TypeCalc: TTypeCalc read FTypeCalc;
  public
    constructor Create(AOwner: TComponent; ATypeCalc: TTypeCalc); reintroduce;
    destructor Destroy; override;
    property Memory: Extended read FMemory;
  published
    property AsInteger: Integer read FAsInteger write SetAsInteger default 0;
    property BeepOnError: Boolean read FBeepOnError write FBeepOnError default 
            True;
    property Color default clWhite;
    property ConversionRatio: Single read FConversionRatio write 
            SetConversionRatio;
    property DecimalDigits: ShortInt read FDecimalDigits write SetDecimalDigits 
            default 2;
    property Enabled;
    property MemText: string read FMemText;
    property NoComma: Boolean read FNoComma default False;
    property Numeric: Boolean read FNumeric default True;
    property OnCalcKey: TKeyPressEvent read FOnCalcKey write FOnCalcKey;
    property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChangeMemory: TNotifyEvent read FOnChangeMemory write 
            FOnChangeMemory;
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnOK: TNotifyEvent read FOnOK write FOnOK;
    property OnResultClick: TNotifyEvent read FOnResult write FOnResult;
    property Text: string read FText;
    property Value: Extended read FValue write SetValue;
  end;
  

{ TPopupCalculator }
  TPopupCalculator = class (TCustomCalculator)
  private
    FPopupVisible: Boolean;
  protected
    procedure CalcKeyPress(Sender: TObject; var Key: Char);
    procedure CreateParams(var Params: TCreateParams); override;
    function FindButton(var Key: Char): TCalcButton;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: 
            Integer); override;
  public
    constructor Create(AOwner: TComponent; AParent: TWinControl; AConvRatio: 
            Single = 0; ADecDigits: Integer = 2; AValField: Extended = 0; 
            ACalcColor: TColor = clBtnFace); reintroduce;
    destructor Destroy; override;
    procedure ShowPopup(Origin: TPoint);
    property Memory;
  published
    property AsInteger;
    property BorderStyle;
    property Color;
    property ConversionRatio;
    property DecimalDigits;
    property Enabled;
    property MemText;
    property NoComma;
    property Numeric;
    property OnCalcKey;
    property OnCancel;
    property OnChangeMemory;
    property OnError;
    property OnOK;
    property OnResultClick;
    property PopupVisible: Boolean read FPopupVisible write FPopupVisible 
            default False;
    property Text;
    property Value;
  end;
  

{ TCalculator }
  TCalculator = class (TCustomPanel)
  private
    FAsInteger: Integer;
    FBeepOnError: Boolean;
    FCalculator: TCustomCalculator;
    FColor: TColor;
    FConversionRatio: Single;
    FDecimalDigits: ShortInt;
    FDisplay: TEdit;
    FDisplayBorder: TBorderStyle;
    FDisplayColor: TColor;
    FDisplayFormat: string;
    FDisplayPanel: TPanel;
    FEnabled: Boolean;
    FForeignCurSymbol: string;
    FMemory: Extended;
    FNoComma: Boolean;
    FNumeric: Boolean;
    FOnCalcKey: TKeyPressEvent;
    FOnCancel: TNotifyEvent;
    FOnChange: TNotifyEvent;
    FOnError: TNotifyEvent;
    FOnOK: TNotifyEvent;
    FOnResult: TNotifyEvent;
    FOnReturnPressed: TNotifyEvent;
    FPanel: TPanel;
    FReadOnly: Boolean;
    FStatusPanel: TStatusBar;
    FText: string;
    FValue: Extended;
    procedure CalcKeyPress(Sender: TObject; var Key: Char);
    procedure CalculatorChange(Sender: TObject);
    procedure CalculatorChangeMemory(Sender: TObject);
    function FindButton(var Key: Char): TCalcButton;
    procedure SetAsInteger(const AValue: Integer);
    procedure SetColor(const AValue: TColor);
    procedure SetConversionRatio(const AValue: Single);
    procedure SetDecimalDigits(const AValue: ShortInt);
    procedure SetDisplayBorder(const AValue: TBorderStyle);
    procedure SetDisplayColor(const AValue: TColor);
    procedure SetDisplayFormat(const AValue: string);
    procedure SetFText(const AValue: string);
    procedure SetValue(const AValue: Extended);
  protected
    procedure ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer);
    procedure DataChanged; virtual;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Memory: Extended read FMemory;
  published
    property AsInteger: Integer read FAsInteger write SetAsInteger default 0;
    property BeepOnError: Boolean read FBeepOnError write FBeepOnError default 
            True;
    property BorderStyle;
    property Color: TColor read FColor write SetColor default clWhite;
    property ConversionRatio: Single read FConversionRatio write 
            SetConversionRatio;
    property DecimalDigits: ShortInt read FDecimalDigits write SetDecimalDigits 
            default 2;
    property DisplayBorder: TBorderStyle read FDisplayBorder write 
            SetDisplayBorder default bsSingle;
    property DisplayColor: TColor read FDisplayColor write SetDisplayColor 
            default clBlue;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
    property Enabled;
    property ForeignCurSymbol: string read FForeignCurSymbol write 
            FForeignCurSymbol;
    property NoComma: Boolean read FNoComma default False;
    property Numeric: Boolean read FNumeric default True;
    property OnCalcKey: TKeyPressEvent read FOnCalcKey write FOnCalcKey;
    property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnOK: TNotifyEvent read FOnOK write FOnOK;
    property OnResultClick: TNotifyEvent read FOnResult write FOnResult;
    property OnReturnPressed: TNotifyEvent read FOnReturnPressed write 
            FOnReturnPressed;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property Text: string read FText write SetFText;
    property Value: Extended read FValue write SetValue;
  end;
  

{ TBaseMaksEdit }
  TValueType = (vtCalendar, vtCalculator, vtString, vtInteger, vtFloat,
                vtCurrency);
  TBitmapKind = (bkClick, bkCustom, bkEllipsis, bkCalendar, bkCalculator);

  TBaseEdit = class (TCustomMaskEdit)
  private
    FAlignment: TAlignment;
    procedure SetAlignment(AValue: TAlignment);
  protected
    procedure CreateParams(var params:TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default 
            taLeftJustify;
  end;
  

{ TCustomMultiEdit }
  TExecDateDialog = procedure (Sender: TObject; var ADate: TDateTime; var 
          Action: Boolean) of object;
  TCustomMultiEdit = class (TCustomPanel)
  private
    FAlignment: TAlignment;
    FAsInteger: Integer;
    FAutoSelect: Boolean;
    FBevelKind: TBevelKind;
    FBlanksChar: Char;
    FButton: TSpeedButton;
    FButtonHint: string;
    FCalcColor: TColor;
    FCalculator: TPopupCalculator;
    FCalendar: TPopupCalendar;
    FCalHints: TStrings;
    FCharCase: TEditCharCase;
    FClickKey: TShortCut;
    FConversionRatio: Single;
    FDate: TDateTime;
    FDateFormat: string[10];
    FDay: Word;
    FDecimalDigits: Integer;
    FDefaultToday: Boolean;
    FDirectInput: Boolean;
    FDisplayFormat: string;
    FEdit: TBaseEdit;
    FEditMask: TEditMask;
    FEditText: string;
    FFont: TFont;
    FForeignCurSymbol: string;
    FFormatting: Boolean;
    FGridLineWidth: Integer;
    FKind: TBitmapKind;
    FMaxLength: Integer;
    FMonth: Word;
    FNoComma: Boolean;
    FNumeric: Boolean;
    FOnAcceptDate: TExecDateDialog;
    FOnButtonClick: TNotifyEvent;
    FOnChange: TNotifyEvent;
    FPasswordChar: Char;
    FPopUpColor: TColor;
    FReadOnly: Boolean;
    FSelectedMFmt: string;
    FStatusFormat: string;
    FStatusHint: string;
    FText: TMaskedText;
    FValue: Extended;
    FValueType: TValueType;
    FVarVariant: Variant;
    FVisibleButton: Boolean;
    FWeekendColor: TColor;
    FWeekends: TDaysOfWeek;
    FYear: Word;
    FYearDigits: TYearDigits;
    procedure ButtonClick(Sender: TObject);
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure DisplayValueType;
    procedure EditChange(Sender: TObject);
    procedure EditEnter(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    function GetDate: TDateTime;
    function GetDateMask: string;
    function GetMasked: Boolean;
    procedure SetAlignment(const AValue: TAlignment);
    procedure SetAsInteger(const AValue: Integer);
    procedure SetAutoSelect(const AValue: Boolean);
    procedure SetBevelKind(const AValue: TBevelKind);
    procedure SetBlanksChar(AValue: Char);
    procedure SetButtonHint(const AValue: string);
    procedure SetCharCase(const AValue: TEditCharCase);
    procedure SetCurrencyValue(AValue: string);
    procedure SetDate(const AValue: TDateTime);
    procedure SetDisplayFormat(const AValue: string);
    procedure SetEditMask(const AValue: TEditMask);
    procedure SetEditText(const AValue: string);
    procedure SetFloatValue(AValue: string);
    procedure SetFont(const AValue: TFont);
    procedure SetIntegerValue(AValue: string);
    procedure SetKind(const AValue: TBitmapKind);
    procedure SetMaxLength(const AValue: Integer);
    procedure SetPasswordChar(const AValue: Char);
    procedure SetReadOnly(const AValue: Boolean);
    procedure SetText(const AValue: TMaskedText);
    procedure SetValueType(const AValue: TValueType);
    procedure SetVisibleButton(const AValue: Boolean);
    procedure UpdateFormat;
  protected
    procedure Change; virtual;
    procedure DataChange; virtual;
    procedure DataChanged; virtual;
    function EditCanModify: Boolean; virtual;
    procedure Reset; virtual;
    procedure SelectAll; virtual;
    procedure UpdateMask; virtual;
    property Action;
    property ActionLink;
    property Align;
    property Alignment: TAlignment read FAlignment write SetAlignment default 
            taLeftJustify;
    property Anchors;
    property AsInteger: Integer read FAsInteger write SetAsInteger default 0;
    property AutoSelect: Boolean read FAutoSelect write SetAutoSelect default 
            True;
    property BevelEdges;
    property BevelInner;
    property BevelKind: TBevelKind read FBevelKind write SetBevelKind default 
            bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BlanksChar: Char read FBlanksChar write SetBlanksChar default 
            Space;
    property ButtonHint: string read FButtonHint write SetButtonHint;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default 
            ecNormal;
    property ClickKey: TShortCut read FClickKey write FClickKey;
    property Color;
    property Constraints;
    property Ctl3D;
    property Date: TDateTime read GetDate write SetDate;
    property DefaultToday: Boolean read FDefaultToday write FDefaultToday 
            default False;
    property DisplayFormat: string read FDisplayFormat write SetDisplayFormat;
    property DragMode;
    property EditMask: TEditMask read FEditMask write SetEditMask;
    property EditText: string read FEditText write SetEditText;
    property Enabled;
    property Font: TFont read FFont write SetFont;
    property Height;
    property HelpContext;
    property HelpType;
    property Hint;
    property IsMasked: Boolean read GetMasked;
    property Kind: TBitmapKind read FKind write SetKind;
    property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
    property Numeric: Boolean read FNumeric default True;
    property OnAcceptDate: TExecDateDialog read FOnAcceptDate write 
            FOnAcceptDate;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write 
            FOnButtonClick;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseUp;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar: Char read FPasswordChar write SetPasswordChar 
            default #0;
    property PopUpMenu;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Tag;
    property Text: TMaskedText read FText write SetText;
    property Value: Extended read FValue write FValue;
    property ValueType: TValueType read FValueType write SetValueType;
    property VarVariant: Variant read FVarVariant write FVarVariant;
    property Visible;
    property VisibleButton: Boolean read FVisibleButton write SetVisibleButton 
            default True;
    property Width;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
  end;
  

{ TMultiEdit }
  TMultiEdit = class (TCustomMultiEdit)
  public
    property EditText;
  published
    property Action;
    property ActionLink;
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragMode;
    property EditMask;
    property Enabled;
    property Font;
    property Height;
    property HelpContext;
    property HelpType;
    property Hint;
    property Kind;
    property MaxLength;
    property OnButtonClick;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseUp;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopUpMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Tag;
    property Text;
    property Value;
    property ValueType;
    property VarVariant;
    property Visible;
    property VisibleButton;
    property Width;
  end;
  

{ TDBMultiEdit }
  TDBMultiEdit = class (TCustomMultiEdit)
  private
    FAlignment: TAlignment;
    FCanvas: TControlCanvas;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    procedure ActiveChange(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure DataOnChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure ResetMaxLength;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
  protected
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); 
            override;
    procedure Reset; override;
    property EditMask;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Alignment;
    property Anchors;
    property AutoSelect;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property Kind;
    property MaxLength;
    property OnButtonClick;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopUpMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Value;
    property ValueType;
    property VarVariant;
    property Visible;
    property VisibleButton;
  end;
  

implementation

uses prcConst;

{$R MultiEdit.res}

var
  NullFloatStr: string;

{TPrcComboBox}

{TCustomCalendar}

{
******************************* TCustomCalendar ********************************
}
constructor TCustomCalendar.Create(AOwner: TComponent; ADate: TDateTime = 0; 
        AColor: TColor = clWhite; AWeekColor: TColor = clRed; AWeekends: 
        TDaysOfWeek = [Sun]);
begin
  inherited Create(AOwner);
  FReadOnly     := False;
  Date          := ADate;
  FixedColor    := clBlue;
  Color         := AColor;
  GridLineWidth := 0;
  Width         := 169;
  Height        := 97;
  ColCount      := 7;
  RowCount      := 7;
  FixedCols     := 0;
  FixedRows     := 1;
  ScrollBars    := ssNone;
  Options       := Options - [goRangeSelect] + [goDrawFocusSelected];
  Weekends      := [Sun];
  WeekendColor  := clRed;
  ControlStyle  := ControlStyle + [csAcceptsControls];
end;

destructor TCustomCalendar.Destroy;
begin
  inherited Destroy;
end;

procedure TCustomCalendar.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TCustomCalendar.ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
end;

procedure TCustomCalendar.Click;
var
  TempDay: Integer;
begin
  inherited Click;
  TempDay := DayNum(Col, Row);
  if TempDay <> -1 then Day := TempDay;
  if Assigned(FOnClick) then FOnClick(Self);
end;

function TCustomCalendar.DayNum(ACol, ARow: Integer): Integer;
begin
  Result := FMonthOffset + ACol + (ARow - 1) * 7;
  if (Result < 1) or (Result > MonthDays[IsLeapYear(Year), Month]) then
    Result := -1;
end;

procedure TCustomCalendar.DblClick;
begin
  inherited DblClick;
  if Assigned(FOnDblClick) then FOnDblClick(Self);
end;

procedure TCustomCalendar.DoEnter;
begin
  inherited DoEnter;
  if Assigned(FOnEnter) then FOnEnter(Self);
end;

procedure TCustomCalendar.DoExit;
begin
  inherited DoExit;
  if Assigned(FOnExit) then FOnExit(Self)
end;

procedure TCustomCalendar.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: 
        TGridDrawState);
var
  TheText: string;
  TempDay: Integer;
  FontColor: TColor;
begin
  FontColor := Canvas.Font.Color;
  if ARow = 0 then
    TheText := ShortDayNames[ACol + 1]
  else
  begin
    TheText := '';
    TempDay := DayNum(ACol, ARow);
    if TempDay <> -1 then TheText := IntToStr(TempDay);
  end;
  if ARow = 0 then
    Canvas.Font.Color := ClWhite
  else
    if IsWeekend(ACol, ARow) then
      Canvas.Font.Color := FWeekendColor
    else
      Canvas.Font.Color := FontColor;
  with ARect, Canvas do
    TextRect(ARect, Left + (Right - Left - TextWidth(TheText)) div 2,
      Top + (Bottom - Top - TextHeight(TheText)) div 2, TheText);
end;

function TCustomCalendar.GetDateElement(Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  case Index of
    1: Result := AYear;
    2: Result := AMonth;
    3: Result := ADay;
   else
       Result := -1;
  end;
end;

function TCustomCalendar.IsWeekend(ACol, ARow: Integer): Boolean;
begin
  Result := TDayOfWeekName(ACol) in FWeekends;
end;

procedure TCustomCalendar.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
        Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Assigned(FOnMouseDown) then FOnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TCustomCalendar.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if Assigned(FOnMouseMove) then FOnMouseMove(Self, Shift, X, Y);
end;

procedure TCustomCalendar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, 
        Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Assigned(FOnMouseUp) then FOnMouseUp(Self, Button, Shift, X, Y);
end;

function TCustomCalendar.SelectCell(ACol, ARow: Longint): Boolean;
begin
  if FReadOnly then
    Result := False
  else
    if DayNum(ACol, ARow) = -1 then
      Result := False
    else
      Result := inherited SelectCell(ACol, ARow);
end;

procedure TCustomCalendar.SetDate(const Value: TDateTime);
var
  AOnClick: TNotifyEvent;
begin
  if Value <> FDate then
  begin
    FDate := Value;
    DecodeDate(FDate, FYear, FMonth, FDay);
    AOnClick := FOnClick;
    FOnClick := nil;
    UpdateCalendar;
    Change;
    FOnClick := AOnClick;
  end;
end;

procedure TCustomCalendar.SetDateElement(Index: Integer; Value: Integer);
var
  AYear, AMonth, ADay: Word;
begin
  if Value > 0 then
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);
    case Index of
      1: AYear := Value;
      2: AMonth := Value;
      3: ADay := Value;
    else
      exit;
    end;
    FDate := EncodeDate(AYear, AMonth, ADay);
    UpdateCalendar;
    Change;
  end;
end;

procedure TCustomCalendar.SetWeekendColor(const AValue: TColor);
begin
  if AValue <> FWeekendColor then
  begin
    FWeekendColor := AValue;
    UpdateCalendar;
  end;
end;

procedure TCustomCalendar.SetWeekends(const AValue: TDaysOfWeek);
begin
  if AValue <> FWeekends then begin
    FWeekends := AValue;
    UpdateCalendar;
  end;
end;

procedure TCustomCalendar.UpdateCalendar;
var
  AYear, AMonth, ADay: Word;
  FirstDate: TDateTime;
begin
  if FDate <> 0 then
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);
    DecodeDate(FDate, FYear, FMonth, FDay);
    FirstDate := EncodeDate(AYear, AMonth, 1);
    FMonthOffset := 2 - SysUtils.DayOfWeek(FirstDate);
    Row := (ADay - FMonthOffset) div 7 + 1;
    Col := (ADay - FMonthOffset) mod 7;
  end;
  Refresh;
end;

procedure TCustomCalendar.WMSize(var Message: TWMSize);
var
  aGridLines: Integer;
begin
  inherited;
  if Width  < 169 then Width  := 169;
  if Height < 97  then Height := 97;
  aGridLines       := 6 * GridLineWidth;
  DefaultColWidth  := (Width  - aGridLines) div 7;
  DefaultRowHeight := (Height - aGridLines) div 7;
end;

{$IFDEF LINUX}
{$ENDIF}
{$IFDEF Win32}
{$ENDIF}

{TCalendario}

{
********************************* TCalendario **********************************
}
constructor TCalendario.Create(AOwner: TComponent);
var
  i: Integer;
  ListHint: TStrings;
begin
  inherited Create(AOwner);
  Width          := 178;
  Height         := 150;
  Hint           := SCalendarHint;
  BorderStyle    := bsSingle;
  FPainel        := TPanel.Create(Self);
  with FPainel do
  begin
    Parent       := Self;
    Top          := 3;
    Left         := 3;
    Width        := Self.Width  - 3;
    Height       := Self.Height - 3;
    BevelInner   := bvNone;
    BevelOuter   := bvNone;
    Caption      := '';
    Color        := clWhite;
  end;
  FpnSeTCalendario := TPanel.Create(Self);
  with FpnSeTCalendario do
  begin
    Parent       := FPainel;
    Caption      := '';
    Height       := 15;
    BevelInner   := bvNone;
    BevelOuter   := bvNone;
    Color        := clWhite;
    Align        := AlTop;
    ShowHint     := False;
  end;
  for i := 0 to 3 do
  begin
    FButtons[i] := TSpeedButton.Create(Self);
    with FButtons[i] do
    begin
      Parent      := FpnSeTCalendario;
      Caption     := '';
      Flat        := True;
      Height      := 15;
      Width       := 15;
      case i of
        0: Tag    := -12;
        1: Tag    := -1;
        2: Tag    :=  1;
        3: Tag    :=  12;
      end;
      if i > 1 then
        Align     := AlRight
      else
        Align     := AlLeft;
      ShowHint    := True;
      OnClick     := SetButtonClick;
      try
        FButtons[i].Glyph.LoadFromResourceName(Hinstance, ResButton + IntToStr(i));
      except
        raise Exception.CreateFmt(SErrorLoadResButton, [ResButton + IntToStr(i)]);
      end;
    end;
  end;
  FStatus        := TPanel.Create(Self);
  with FStatus do
  begin
    Parent       := FPainel;
    Align        := AlBottom;
    Caption      := NullString;
    Height       := 15;
    BevelInner   := bvNone;
    BevelOuter   := bvNone;
    Color        := clBlue;
    Font.Color   := clWhite;
    Font.Style   := [fsBold];
  end;
  FCalendar      := TCustomCalendar.Create(Self, NullDate, clwhite,
    clRed, [Sun]);
  with FCalendar do
  begin
    Parent       := FPainel;
    ScrollBars   := ssNone;
    BorderStyle  := bsNone;
    Align        := alClient;
    OnChange     := SetOnChange;
    OnClick      := SetOnClick;
    OnDblClick   := SetOnDblClick;
    OnEnter      := SetOnEnter;
    OnExit       := SetOnExit;
    OnMouseDown  := SetOnMouseDown;
    OnMouseMove  := SetOnMouseMove;
    OnMouseUp    := SetOnMouseUp;
  end;
  Date            := SysUtils.Date;
  SelectedMFmt    := SSelectedMFmt;
  StatusFormat    := SStatusFormat;
  FWeekends       := [Sun];
  FWeekendColor   := clRed;
  StatusHint      := SStatusHint;
  FButtonHints    := TStringList.Create;
  if (csDesigning in ComponentState)  then
  begin
    ListHint     := TStringList.Create;
    ListHint.Add(SPrevYear);
    ListHint.Add(SPrevMonth);
    ListHint.Add(SNextMonth);
    ListHint.Add(SNextYear);
    SetButtonHints(ListHint);
    ListHint.Free;
  end;
end;

destructor TCalendario.Destroy;
begin
  inherited;
end;

procedure TCalendario.BoundsChanged;
begin
  if Width  < 178 then Width  := 178;
  if Height < 150 then Height := 150;
end;

function TCalendario.GetDateElement(Index: Integer): Word;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  case Index of
    1: Result := AYear;
    2: Result := AMonth;
    3: Result := ADay;
   else
       Result := 0;
  end;
end;

procedure TCalendario.SetButtonClick(Sender: TObject);
var
  FYear, FMonth, FDay: Word;
begin
  DecodeDate(IncMonth(FDate, TSpeedButton(Sender).Tag), FYear, FMonth, FDay);
  Date := EncodeDate(FYear, FMonth, FDay);
end;

procedure TCalendario.SetButtonHints(AValue: TStrings);
var
  I: Integer;
begin
  if (FButtonHints <> nil) then
  begin
    FButtonHints.Clear;
    FButtonHints.Assign(AValue);
    while (FButtonHints.Count > 4) do
      FButtonHints.Delete(FButtonHints.Count - 1);
    for I := 0 to Min(FButtonHints.Count - 1, 3) do
      if FButtonHints[I] <> NullString then
        FButtons[I].Hint := FButtonHints[I];
  end;
end;

procedure TCalendario.SeTCalendarioColor(const AValue: TColor);
begin
  if FCalendarColor <> AValue then
  begin
    FCalendarColor := AValue;
    if Assigned(FCalendar) then
      FCalendar.Color := FCalendarColor;
  end;
end;

procedure TCalendario.SetDate(const AValue: TDateTime);
begin
  if FDate <> AValue then
  begin
    FDate := AValue;
    if FCalendar.Date <> FDate then
      FCalendar.Date := FDate;
    FpnSeTCalendario.Caption := FormatDateTime(FSelectedMFmt, FDate);
  end;
end;

procedure TCalendario.SetDateElement(Index: Integer; Value: Word);
var
  AYear, AMonth, ADay: Word;
begin
  if Value > NullDate then
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);
    case Index of
      1: AYear := Value;
      2: AMonth := Value;
      3: ADay := Value;
    else
      exit;
    end;
    FDate := EncodeDate(AYear, AMonth, ADay);
  end;
end;

procedure TCalendario.SetGridLineWidth(const AValue: Integer);
begin
  if FGridLineWidth <> AValue then
  begin
    FGridLineWidth := AValue;
    FCalendar.GridLineWidth := AValue;
    Width  := 178 + (FGridLineWidth * 7);
    Height := 150 + (FGridLineWidth * 7);
  end;
end;

procedure TCalendario.SetOnChange(Sender: TObject);
begin
  if Assigned(FCalendar) then
    Date := FCalendar.Date;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TCalendario.SetOnClick(Sender: TObject);
begin
  if Assigned(FOnClick) then FOnClick(Self);
end;

procedure TCalendario.SetOnDblClick(Sender: TObject);
begin
  if Assigned(FOnDblClick) then FOnDblClick(Self);
end;

procedure TCalendario.SetOnEnter(Sender: TObject);
begin
  if Assigned(FOnEnter) then FOnEnter(Self);
end;

procedure TCalendario.SetOnExit(Sender: TObject);
begin
  if Assigned(FOnExit) then FOnExit(Self);
end;

procedure TCalendario.SetOnMouseDown(Sender: TObject; Button: TMouseButton; 
        Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseDown) then FOnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TCalendario.SetOnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: 
        Integer);
begin
  if Assigned(FOnMouseMove) then FOnMouseMove(Self, Shift, X, Y);
end;

procedure TCalendario.SetOnMouseUp(Sender: TObject; Button: TMouseButton; 
        Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then FOnMouseUp(Self, Button, Shift, X, Y);
end;

procedure TCalendario.SetSelectedMFmt(const AValue: string);
var
  AuxStr: string;
begin
  if FSelectedMFmt <> AValue then
  begin
    try
      AuxStr := FormatDateTime(AValue, FDate);
    except
      raise Exception.CreateFmt(SInvalidStrDFormat, [AValue]);
    end;
    FSelectedMFmt := AValue;
    FpnSeTCalendario.Caption := FormatDateTime(FSelectedMFmt, FDate);
  end;
end;

procedure TCalendario.SetStatusFormat(const AValue: string);
var
  AuxStr: string;
begin
  if FStatusFormat <> AValue then
  begin
    try
      AuxStr := FormatDateTime(AValue, FDate);
    except
      raise Exception.CreateFmt(SInvalidStrDFormat, [AValue]);
    end;
    FStatusFormat   := AValue;
    FStatus.Caption := FormatDateTime(FStatusFormat, FDate);
  end;
end;

procedure TCalendario.SetStatusHint(const AValue: string);
begin
  if FStatusHint <> AValue then
  begin
    FStatusHint := AValue;
    FStatus.Hint := AValue;
  end;
end;

procedure TCalendario.SetWeekendColor(const AValue: TColor);
begin
  if AValue <> FWeekendColor then
  begin
    FWeekendColor := AValue;
    FCalendar.WeekendColor := AValue;
  end;
end;

procedure TCalendario.SetWeekends(const AValue: TDaysOfWeek);
begin
  if AValue <> FWeekends then begin
    FWeekends := AValue;
    FCalendar.Weekends := AValue;
  end;
end;

procedure TCalendario.WMSize(var Message: TWMSize);
begin
  if Width  < 178 then Width  := 178;
  if Height < 150 then Height := 150;
end;

{$IFDEF LINUX}
{$ENDIF}
{$IFDEF WIN32}
{$ENDIF}

  {TPopupCalendar}

// clx constructor  TPopupCalendar.Create(AOwner: TComponent; AParent: TWidgetControl;
//         AParentWidget: QWidgetH);
{
******************************** TPopupCalendar ********************************
}
constructor TPopupCalendar.Create(AOwner: TComponent; AParent: TWinControl);
  
  //      AParentWidget: QWidgetH);
  
begin
  inherited Create(AOwner);
  Self.ControlStyle    := ControlStyle + [csNoDesignVisible, csReplicatable,
                     csAcceptsControls];
  Parent               := AParent;
  Visible := False;
end;

destructor TPopupCalendar.Destroy;
begin
  inherited Destroy;
end;

procedure TPopupCalendar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style and not (WS_BORDER or WS_TABSTOP or WS_DISABLED);
end;

procedure TPopupCalendar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, 
        Y: Integer);
begin
  if Visible then Visible := False;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TPopupCalendar.ShowPopup(Origin: TPoint);
begin
  Left    := Origin.X;
  Top     := Origin.Y;
  Show;
end;

//procedure TPopupCalendar.InitWidget;
//begin
//  inherited InitWidget;
//  Visible := False;
//end;

//function  TPopupCalendar.WidgetFlags: Integer;
//begin
//  Result :=  inherited WidgetFlags
//              or Integer(WidgetFlags_WType_Popup)
//              or Integer(WidgetFlags_WStyle_Tool)
//              or Integer(WidgetFlags_WMouseNoMask)
//              or Integer(WidgetFlags_WNorthWestGravity);
//end;

function CreateCalcBtn(AParent: TCustomCalculator; AKind: TCalcBtnKind;
  AOnClick: TNotifyEvent; ATypeCalc: TTypeCalc): TCalcButton;
begin
  Result          := TCalcButton.CreateKind(AParent, AKind);
  with Result do
  begin
    ParentFont    := True;
    Parent        := AParent;
    if Kind in [cbConvFrom, cbConvTo] then
    begin
      Enabled     := False;
      Width       := 44;
    end
    else
      Width       := 21;
    Height        := 21;
    Left          := BtnPos[Kind].X;
    Top           := BtnPos[Kind].Y;
    if Kind in [cbNum0..cbNum9] then
      Caption     := IntToStr(Tag)
    else
      if Kind      = cbDcm then Caption := DecimalSeparator
    else
      if Kind in [cbSgn..cbConvTo] then
        Caption   := StrPas(BtnCaptions[Kind]);
    OnClick       := AOnClick;
    if ATypeCalc   = tcCalculator then
      Flat        := True;
  end;
end;

{ TCalcButton }

{
********************************* TCalcButton **********************************
}
constructor TCalcButton.CreateKind(AOwner: TComponent; AKind: TCalcBtnKind);
begin
  inherited Create(AOwner);
  FKind := AKind;
  if FKind in [cbNum0..cbClr] then
    Tag := Ord(Kind) - 1
  else
    Tag := -1;
  if Kind = cbEql then Width := 44;
end;

procedure TCalcButton.CMParentFontChanged(var Message: TMessage);
  
  function BtnColor(Kind: TCalcBtnKind): TColor;
  begin
    if Kind in [cbSqr, cbPcnt, cbRev, cbMP..cbMC] then
      Result := clNavy
    else
      if Kind in [cbDiv, cbMul, cbSub, cbAdd, cbEql] then
        Result := clPurple
      else
        if Kind in [cbBck, cbClr] then
          Result := clMaroon
        else
          Result := clBtnText;
  end;
  
begin
  if not FFontChanging then inherited;
  if ParentFont and not FFontChanging then begin
    FFontChanging := True;
    try
      Font.Color := BtnColor(FKind);
      ParentFont := True;
    finally
      FFontChanging := False;
    end;
  end;
end;

{ TCustomCalculator }

{
****************************** TCustomCalculator *******************************
}
constructor TCustomCalculator.Create(AOwner: TComponent; ATypeCalc: TTypeCalc);
var
  i: TCalcBtnKind;
begin
  inherited Create(AOwner);
  ControlStyle     := ControlStyle + [csNoDesignVisible, csCaptureMouse, csReplicatable];
  FTypeCalc        := ATypeCalc;
  FHeightAnt       := 128;
  FWidthAnt        := 145;
  if FTypeCalc      = tcCalcEdit then
  begin
    Width          := 147;
    Height         := 133;
    BorderStyle    := bsSingle;
  end
  else
  begin
    Align          := alClient;
    BorderStyle    := bsNone;
    ParentColor    := True;
  end;
  Caption          := NullString;
  ParentFont       := False;
  FBeepOnError     := True;
  FDecimalDigits   := DefDecimalDigits;
  FConversionRatio := NullInt;
  FMemory          := NullFloat;
  FEnabled         := True;
  FNoComma         := False;
  FNumeric         := True;
  for i := cbNum0 to cbConvTo do
    if BtnPos[i].X > 0 then
      FButtons[i]  := CreateCalcBtn(Self, i, BtnClick, FTypeCalc);
end;

destructor TCustomCalculator.Destroy;
begin
  inherited Destroy;
end;

procedure TCustomCalculator.BoundsChanged;
var
  aScale: Double;
  i: TCalcBtnKind;
begin
  if (Width <> FWidthAnt) and (FWidthAnt <> 0) then
  begin
    aScale      := ((Width - FWidthAnt) / FWidthAnt);
    if aScale < 0 then
      aScale := 1 - (aScale * -1)
    else
      aScale := (aScale + 1);
    FWidthAnt := Width;
    for i := cbNum0 to cbConvTo do
      if Assigned(FButtons[i]) then //and (BtnPos[i].X > 0) then
      begin
        FButtons[i].Left  := Trunc(FButtons[i].Left  * aScale);
        FButtons[i].Width := Trunc(FButtons[i].Width * aScale);
      end;
  end;
  if (Height <> FHeightAnt) then //and (FHeightAnt <> 0) then
  begin
    aScale      := ((Height - FHeightAnt) / FHeightAnt);
    if aScale < 0 then
      aScale := 1 - (aScale * -1)
    else
      aScale := (aScale + 1);
    FHeightAnt := Height;
    for i := cbNum0 to cbConvTo do
      if Assigned(FButtons[i]) and (BtnPos[i].Y > 0) then
      begin
        FButtons[i].Top    := Trunc(FButtons[i].Top    * aScale);
        FButtons[i].Height := Trunc(FButtons[i].Height * aScale);
      end;
  end;
end;

procedure TCustomCalculator.BtnClick(Sender      : TObject);
var
  CompTag: Char;
begin
  // String handling routines
  CompTag := Chr(0);
  case TCalcButton(Sender).Kind of
    cbNum0..cbNum9: CompTag := Chr(TComponent(Sender).Tag + Ord('0'));
    cbSgn:          CompTag := '_';
    cbDcm:          CompTag := DecimalSeparator;
    cbDiv:          CompTag := '/';
    cbMul:          CompTag := '*';
    cbSub:          CompTag := '-';
    cbAdd:          CompTag := '+';
    cbSqr:          CompTag := 'Q';
    cbPcnt:         CompTag := '%';
    cbRev:          CompTag := 'R';
    cbEql:          CompTag := '=';
    cbBck:          CompTag := #8;
    cbClr:          CompTag := 'C';
    cbConvTo:       if DecimalDigits > 0 then
                      Value     := Value / ConversionRatio
                    else
                      AsInteger := Trunc(AsInteger / ConversionRatio);
    cbConvFrom:     if DecimalDigits > 0 then
                      Value     := Value * ConversionRatio
                    else
                      AsInteger := Trunc(AsInteger * ConversionRatio);
  
    cbMP:
      if FStatus in [csValid, csFirst] then
      begin
        FStatus := csFirst;
        FMemory := FMemory + Value;
        if Assigned(FOnChangeMemory) then FOnChangeMemory(Self);
      end;
    cbMS:
      if FStatus in [csValid, csFirst] then begin
        FStatus := csFirst;
        FMemory := FMemory - Value;
        if Assigned(FOnChangeMemory) then FOnChangeMemory(Self);
      end;
    cbMR:
      if FStatus in [csValid, csFirst] then
      begin
        FStatus := csFirst;
        CheckFirst;
        FMemText := FloatToStr(FMemory);
        if DecimalDigits > 0 then
          Value     := FMemory
        else
          AsInteger := Trunc(FMemory);
        if Assigned(FOnChangeMemory) then FOnChangeMemory(Self);
      end;
    cbMC:
      begin
        FMemory := NullFloat;
        if Assigned(FOnChangeMemory) then FOnChangeMemory(Self);
      end;
    cbOk:
      begin
        if FStatus <> csError then
        begin
          Value := Value;
          if Assigned(FOnOk) then FOnOk(Self);
        end
        else
          if FBeepOnError then Beep;
      end;
    cbCancel: if Assigned(FOnCancel) then FOnCancel(Self);
  end;
  if CompTag <> '' then
    CalcKey(CompTag);
end;

procedure TCustomCalculator.CalcKey(var Key: Char);
var
  R: Double;
  DecDigi: string;
begin
  if not Numeric and (Key <> 'C') then
  begin
    FStatus := csError;
    Key := #0;
    raise Exception.CreateFmt(SCalcOnError, [FText]);
  end;
  Key := UpCase(Key);
  if (FStatus = csError) and (Key <> 'C') then Key := #0;
  if Assigned(FOnCalcKey) then FOnCalcKey(Self, Key);
  if Key in [DecimalSeparator, '.', ','] then
  begin
    if not NoComma then
    begin
      CheckFirst;
      FText := FText + DecimalSeparator;
      Exit;
    end
    else
    begin
      if BeepOnError then Beep;
      Key := #0;
    end;
  end;
  case Key of
    'R':
      if FStatus in [csValid, csFirst] then
      begin
        FStatus := csFirst;
        if Value = 0 then
          Error
        else
          if DecimalDigits > 0 then
            Value     := 1.0 / Value
          else
            AsInteger := Trunc(1.0 / AsInteger);
      end;
    'Q':
      if (FStatus in [csValid, csFirst]) and (DecimalDigits > 0) then
      begin
        FStatus := csFirst;
        if Value < 0 then
          Error
        else
          Value := Sqrt(Value);
      end
      else
        if FBeepOnError then Beep;
    '0'..'9':
      begin
        CheckFirst;
        if FText = DefaultText(FDecimalDigits) then FText := '';
        if Pos('E', FText) = 0 then
        begin
          if Pos(DecimalSeparator, FText) > 0 then
          begin
            DecDigi := Copy(FText, Pos(DecimalSeparator, FText) + 1,
                DecimalDigits);
            if DecDigi <> '' then
              if StrToInt(DecDigi) > 0 then
                if Length(DecDigi) < FDecimalDigits then
                  FText := FText + Key
                else
                  if FBeepOnError then
                    Beep
                  else
                    FText := FText
              else
                FText := FText + Key
            else
              FText := FText + Key;
          end
          else
              FText := FText + Key;
          if DecimalDigits > 0 then
            Value := StrToFloat(FText)
          else
            AsInteger := StrToInt(FText);
        end;
      end;
    #8:
      begin
        CheckFirst;
        if (Length(FText) = Length(DefaultText(FDecimalDigits))) or
           ((Length(FText) = Length(DefaultText(FDecimalDigits)) + 1) and
           (FText[1] = '-')) then
          FText := DefaultText(FDecimalDigits)
        else
          FText := FText + (System.Copy(FText, 1, Length(FText) - 1));
        if DecimalDigits > 0 then
          Value := StrToFloat(FText)
        else
          AsInteger := StrToInt(FText);
      end;
    '_': Value := - Value;
    '+', '-', '*', '/', '=', '%', #13:
      begin
        if FStatus = csValid then
        begin
          FStatus := csFirst;
          if DecimalDigits > 0 then
            R := Value
          else
            R := AsInteger;
          if Key = '%' then
            case FOperator of
              '+', '-': R := FOperand * R / 100.0;
              '*', '/': R := R / 100.0;
            end;
          case FOperator of
            '+': if DecimalDigits > 0 then
                   Value     := FOperand + R
                 else
                   AsInteger := Trunc(FOperand + R);
            '-': if DecimalDigits > 0 then
                   Value     := FOperand - R
                 else
                   AsInteger := Trunc(FOperand - R);
            '*': if DecimalDigits > 0 then
                   Value     := FOperand * R
                 else
                   AsInteger := Trunc(FOperand * R);
            '/': if R = 0 then
                   Error
                 else
                   if DecimalDigits > 0 then
                     Value     := FOperand / R
                   else
                     AsInteger := Trunc(FOperand / R);
          end;
        end;
        FOperator  := Key;
        if DecimalDigits > 0 then
          FOperand := Value
        else
          FOperand := AsInteger;
        if Key in ResultKeys then
          if Assigned(FOnResult) then FOnResult(Self);
      end;
    #27, 'C': Clear;
  //    ^C: Copy;
  //    ^V: Paste;
  end;
end;

procedure TCustomCalculator.ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  i: TCalcBtnKind;
  aScale: Double;
begin
  if (Width <> FWidthAnt) and (FWidthAnt <> 0) then
  begin
    aScale      := ((Width - FWidthAnt) / FWidthAnt);
    if aScale < 0 then
      aScale := 1 - (aScale * -1)
    else
      aScale := (aScale + 1);
    FWidthAnt := Width;
    for i := cbNum0 to cbConvTo do
      if Assigned(FButtons[i]) then //and (BtnPos[i].X > 0) then
      begin
        FButtons[i].Left  := Trunc(FButtons[i].Left  * aScale);
        FButtons[i].Width := Trunc(FButtons[i].Width * aScale);
      end;
  end;
  if (Height <> FHeightAnt) then //and (FHeightAnt <> 0) then
  begin
    aScale      := ((Height - FHeightAnt) / FHeightAnt);
    if aScale < 0 then
      aScale := 1 - (aScale * -1)
    else
      aScale := (aScale + 1);
    FHeightAnt := Height;
    for i := cbNum0 to cbConvTo do
      if Assigned(FButtons[i]) and (BtnPos[i].Y > 0) then
      begin
        FButtons[i].Top    := Trunc(FButtons[i].Top    * aScale);
        FButtons[i].Height := Trunc(FButtons[i].Height * aScale);
      end;
  end;
end;

procedure TCustomCalculator.CheckFirst;
begin
  if FStatus = csFirst then
  begin
    FStatus := csValid;
    FText := DefaultText(FDecimalDigits);
  end;
end;

procedure TCustomCalculator.Clear;
begin
  FStatus   := csFirst;
  Value     := NullFloat;
  AsInteger := NullInt;
  FText     := DefaultText(FDecimalDigits);
  FNumeric  := True;
  FOperator := '=';
  DataChanged;
end;

procedure TCustomCalculator.DataChanged;
begin
  if Numeric then
  begin
    if FDecimalDigits > 0 then
      FText := FloatToStr(Value)
    else
      FText := IntToStr(AsInteger);
  end;
  if Pos(DecimalSeparator, FText) > 0 then
    FNoComma := True
  else
    FNoComma := False;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TCustomCalculator.Error;
begin
  FStatus := csError;
  FText   := SError;
  if FBeepOnError then Beep;
  if Assigned(FOnError) then FOnError(Self);
  FNumeric := False;
  DataChanged;
end;

procedure TCustomCalculator.SetAsInteger(const AValue: Integer);
begin
  if (FAsInteger <> AValue) then
    if FDecimalDigits = 0 then
      FAsInteger := AValue
    else
      FAsInteger := 0;
  DataChanged;
end;

procedure TCustomCalculator.SetConversionRatio(const AValue: Single);
begin
  if Assigned(FButtons[cbConvFrom]) and Assigned(FButtons[cbConvFrom]) then
  begin
    if AValue <> FConversionRatio then
    begin
      FConversionRatio := AValue;
      FButtons[cbConvFrom].Enabled := FConversionRatio > 0;
      FButtons[cbConvFrom].Enabled := FConversionRatio > 0;
    end;
  end
  else
    FConversionRatio := 0;
end;

procedure TCustomCalculator.SetDecimalDigits(const AValue: ShortInt);
begin
  if (AValue < 0) or (AValue > 17) then
    raise Exception.CreateFmt(SInvalidDecimalDigits, [AValue]);
  if FDecimalDigits <> AValue then
  begin
    FDecimalDigits := AValue;
    if FDecimalDigits = 0 then
      SetValue(AsInteger)
    else
      SetAsInteger(Trunc(Value));
    FButtons[cbSqr].Enabled := FDecimalDigits > 0;
    DataChanged;
  end;
end;

procedure TCustomCalculator.SetValue(const AValue: Extended);
begin
  if (FValue <> AValue) then
    if FDecimalDigits > 0 then
      FValue := AValue
    else
      FValue := 0;
  DataChanged;
end;

procedure TCustomCalculator.WMSize(var Message: TWMSize);
var
  aScale: Double;
  i: TCalcBtnKind;
begin
  inherited;
  if (Width <> FWidthAnt) and (FWidthAnt <> 0) then
  begin
    aScale      := ((Width - FWidthAnt) / FWidthAnt);
    if aScale < 0 then
      aScale := 1 - (aScale * -1)
    else
      aScale := (aScale + 1);
    FWidthAnt := Width;
    for i := cbNum0 to cbConvTo do
      if Assigned(FButtons[i]) then //and (BtnPos[i].X > 0) then
      begin
        FButtons[i].Left  := Trunc(FButtons[i].Left  * aScale);
        FButtons[i].Width := Trunc(FButtons[i].Width * aScale);
      end;
  end;
  if (Height <> FHeightAnt) then //and (FHeightAnt <> 0) then
  begin
    aScale      := ((Height - FHeightAnt) / FHeightAnt);
    if aScale < 0 then
      aScale := 1 - (aScale * -1)
    else
      aScale := (aScale + 1);
    FHeightAnt := Height;
    for i := cbNum0 to cbConvTo do
      if Assigned(FButtons[i]) and (BtnPos[i].Y > 0) then
      begin
        FButtons[i].Top    := Trunc(FButtons[i].Top    * aScale);
        FButtons[i].Height := Trunc(FButtons[i].Height * aScale);
      end;
  end;
end;

{$IFDEF LINUX}
{$ENDIF}
{$IFDEF WIN32}
{$ENDIF}

{ TPopupCalculator }

// clx constructor TPopupCalculator.Create(AOwner: TComponent; AParent: TWidgetControl;
// clx       AParentWidget: QWidgetH; AConvRatio: Single = 0; ADecDigits: Integer = 2;
// clx       AValField: Extended = 0; ACalcColor: TColor = clBtnFace);
{
******************************* TPopupCalculator *******************************
}
constructor TPopupCalculator.Create(AOwner: TComponent; AParent: TWinControl; 
        AConvRatio: Single = 0; ADecDigits: Integer = 2; AValField: Extended = 
        0; ACalcColor: TColor = clBtnFace);
begin
  inherited Create(AOwner, tcCalcEdit);
  Self.ControlStyle    := ControlStyle + [csNoDesignVisible, csReplicatable,
                     csAcceptsControls];
  // clx ParentWidget         := AParentWidget;
  Parent               := AParent;
  ConversionRatio      := AConvRatio;
  DecimalDigits        := ADecDigits;
  if ADecDigits = 0 then
    AsInteger          := Trunc(AValField)
  else
    Value              := AValField;
  Color                := ACalcColor;
  OnKeyPress           := CalcKeyPress;
end;

destructor TPopupCalculator.Destroy;
begin
  inherited Destroy;
end;

procedure TPopupCalculator.CalcKeyPress(Sender: TObject; var Key: Char);
var
  Btn: TCalcButton;
begin
  Btn := FindButton(Key);
  if Btn <> nil then
    Btn.Click
  else
    inherited CalcKey(Key);
  Key := #0;
end;

procedure TPopupCalculator.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style and not (WS_BORDER or WS_TABSTOP or WS_DISABLED);
end;

function TPopupCalculator.FindButton(var Key: Char): TCalcButton;
  
  const
    ButtonChars = '0123456789_./*-+Q%R='#8'C';
  var
    i: Integer;
    BtnTag: LongInt;
  
begin
  if Key in [DecimalSeparator, '.', ','] then
    Key := '.'
  else
    if Key = #13 then
      Key := '='
    else
      if Key = #27 then
        Key := 'C';
  BtnTag := Pos(UpCase(Key), ButtonChars) - 1;
  if BtnTag >= 0 then
    for i := 0 to ControlCount - 1 do
    begin
      if Controls[i] is TCalcButton then
      begin
        Result := TCalcButton(Controls[i]);
        if Result.Tag = BtnTag then exit;
      end;
    end;
  Result := nil;
end;

procedure TPopupCalculator.MouseDown(Button: TMouseButton; Shift: TShiftState; 
        X, Y: Integer);
begin
  if Visible then Visible := False;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TPopupCalculator.ShowPopup(Origin: TPoint);
begin
  Left    := Origin.X;
  Top     := Origin.Y;
  Show;
end;

// clx procedure TPopupCalculator.InitWidget;
// clx begin
// clx   inherited InitWidget;
// clx   Visible := False;
// clx end;
//
// clx function TPopupCalculator.WidgetFlags: Integer;
// clx begin
// clx   Result :=  inherited WidgetFlags
// clx               or Integer(WidgetFlags_WType_Popup)
// clx               or Integer(WidgetFlags_WStyle_Tool)
// clx               or Integer(WidgetFlags_WMouseNoMask)
// clx               or Integer(WidgetFlags_WNorthWestGravity);
// clx end;

{ TCalculator }

{
********************************* TCalculator **********************************
}
constructor TCalculator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width            := 151;
  Height           := 182;
  FDecimalDigits   := DefDecimalDigits;
  FConversionRatio := 0;
  FForeignCurSymbol:= CurrencyString;
  FEnabled         := True;
  BorderStyle      := bsSingle;
  FNoComma         := True;
  FNumeric         := True;
  ParentColor      := True;
  FBeepOnError     := True;
  Color            := clWhite;
  FPanel           := TPanel.Create(Self);
  with FPanel do
  begin
    Parent         := Self;
    Top            := 3;
    Left           := 3;
    Width          := Self.Width - 3;
    Height         := Self.Height - 3;
    Caption        := NullString;
    ParentFont     := True;
    BevelInner     := bvNone;
    BevelOuter     := bvNone;
    Color          := clWhite;
  end;
  FDisplayPanel    := TPanel.Create(Self);
  with FDisplayPanel do
  begin
    Parent         := FPanel;
    ParentFont     := True;
    Height         := 28;
    Align          := AlTop;
    Caption        := NullString;
    Color          := clWhite;
    BevelInner     := bvRaised;
    BevelOuter     := bvRaised;
    TabStop        := True;
  end;
  FDisplay         := TEdit.Create(Self);
  with FDisplay do
  begin
    Parent         := FDisplayPanel;
    Top            := FDisplayPanel.Top + 4;
    Left           := FDisplayPanel.Left + 4;
    Width          := FDisplayPanel.Width - 6;
    Color          := clBlue;
    BorderStyle    := bsSingle;
    Alignment      := taRightJustify;
    Font.Color     := clWhite;
    Font.Style     := [fsBold];
    AutoSelect     := False;
    Text           := FormatFloat(GetMask(FDecimalDigits), NullFloat);
    OnkeyPress     := CalcKeyPress;
  end;
  FStatusPanel     := TStatusBar.Create(Self);
  with FStatusPanel do
  begin
    Parent         := FPanel;
    Height         := 19;
    Align          := AlBottom;
    Color          := clWhite;
    Font.Color     := clBlue;
    Font.Style     := [fsBold];
    Height         := 20;
    Panels.Add;
    Panels.Add;
    Panels[0].Width     := 20;
    Panels[0].Text      := 'M:';
    Panels[1].Alignment := taRightJustify;
  end;
  FCalculator        := TCustomCalculator.Create(Self, tcCalculator);
  with FCalculator do
  begin
    Parent           := FPanel;
    ConversionRatio  := 0;
    DecimalDigits    := FDecimalDigits;
    ForeignCurSymbol := FForeignCurSymbol;
    if FDecimalDigits = 0 then
      AsInteger      := Trunc(Value)
    else
      Value          := Value;
    Color            := clWhite;
    OnChange         := CalculatorChange;
    OnChangeMemory   := CalculatorChangeMemory;
  end;
  FAsInteger         := 0;
  FText              := NullFloatStr;
  FValue             := 0;
  SetDisplayFormat(GetMask(FDecimalDigits));
end;

destructor TCalculator.Destroy;
begin
  inherited Destroy;
end;

procedure TCalculator.CalcKeyPress(Sender: TObject; var Key: Char);
var
  Btn: TCalcButton;
begin
  Btn := FindButton(Key);
  if Btn <> nil then
    Btn.Click
  else
    FCalculator.CalcKey(Key);
  Key := #0;
end;

procedure TCalculator.CalculatorChange(Sender: TObject);
begin
  Text := FCalculator.Text;
end;

procedure TCalculator.CalculatorChangeMemory(Sender: TObject);
begin
  FMemory := FCalculator.Memory;
  FSTatusPanel.Panels[0].Text := 'M:';
  FSTatusPanel.Panels[1].Text := FormatFloat(DisplayFormat, Memory);
end;

procedure TCalculator.ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
end;

procedure TCalculator.DataChanged;
var
  ClearText: string;
begin
  if Assigned(FDisplay) then
  begin
    if Numeric then
    begin
      if FDecimalDigits = 0 then
        FDisplay.Text := FormatFloat(DisplayFormat, AsInteger)
      else
        FDisplay.Text := FormatFloat(DisplayFormat, Value);
      Invalidate;
    end
    else
      FDisplay.Text := FCalculator.Text;
    ClearText := DelChars(FDisplay.Text, '.');
    Text := ClearText;
    if Pos(DecimalSeparator, FDisplay.Text) > 0 then
      FNoComma := True
    else
      FNoComma := False;
  end;
end;

function TCalculator.FindButton(var Key: Char): TCalcButton;
  
  const
    ButtonChars = '0123456789_./*-+Q%R='#8'C';
  var
    i: Integer;
    BtnTag: LongInt;
  
begin
  if Key in [DecimalSeparator, '.', ','] then
    Key := '.'
  else
    if Key = #13 then
      Key := '='
    else
      if Key = #27 then
        Key := 'C';
  BtnTag := Pos(UpCase(Key), ButtonChars) - 1;
  if BtnTag >= 0 then
    for i := 0 to FCalculator.ControlCount - 1 do
    begin
      if FCalculator.Controls[i] is TCalcButton then
      begin
        Result := TCalcButton(FCalculator.Controls[i]);
        if Result.Tag = BtnTag then exit;
      end;
    end;
  Result := nil;
end;

procedure TCalculator.SetAsInteger(const AValue: Integer);
begin
  if (FAsInteger <> AValue) then
  begin
    if FDecimalDigits = 0 then
      FAsInteger := AValue
    else
      FAsInteger := 0;
    DataChanged;
  end;
end;

procedure TCalculator.SetColor(const AValue: TColor);
begin
  if FColor <> AValue then
  begin
    FColor := AValue;
    if Assigned(FCalculator) then FCalculator.Color := AValue;
    if Assigned(FPanel)      then FPanel.Color      := AValue;
  end;
end;

procedure TCalculator.SetConversionRatio(const AValue: Single);
begin
  if Assigned(FCalculator.FButtons[cbConvFrom]) and
     Assigned(FCalculator.FButtons[cbConvFrom]) then
  begin
    if AValue <> FConversionRatio then
    begin
      FConversionRatio := AValue;
      FCalculator.FConversionRatio := AValue;
      FCalculator.FButtons[cbConvFrom].Enabled := FConversionRatio > 0;
      FCalculator.FButtons[cbConvFrom].Enabled := FConversionRatio > 0;
    end;
  end
  else
    FConversionRatio := 0;
end;

procedure TCalculator.SetDecimalDigits(const AValue: ShortInt);
begin
  if (AValue < 0) or (AValue > 17) then
    raise Exception.CreateFmt(SInvalidDecimalDigits, [AValue]);
  if FDecimalDigits <> AValue then
  begin
    FDecimalDigits := AValue;
    if FDecimalDigits = 0 then
      SetValue(AsInteger)
    else
      SetAsInteger(Trunc(Value));
  end;
end;

procedure TCalculator.SetDisplayBorder(const AValue: TBorderStyle);
begin
  if FDisplayBorder <> AValue then
  begin
    FDisplayBorder := AValue;
    FDisplay.BorderStyle := AValue;
  end;
end;

procedure TCalculator.SetDisplayColor(const AValue: TColor);
begin
  if FDisplayColor > AValue then
  begin
    FDisplayColor := AValue;
    if Assigned(FDisplay) then FDisplay.Color := AValue;
  end;
end;

procedure TCalculator.SetDisplayFormat(const AValue: string);
begin
  if FDisplayFormat <> AValue then
  begin
    FDisplayFormat := AValue;
    DataChanged;
  end;
end;

procedure TCalculator.SetFText(const AValue: string);
var
  ClearText: string;
begin
  ClearText := DelChars(AValue, ThousandSeparator);
  if FText <> ClearText then
  begin
    FText := ClearText;
    if FNumeric then
      if FDecimalDigits = 0 then
        FAsInteger := StrToInt(ClearText)
      else
        FValue := StrToFloat(ClearText);
    DataChanged;
  end;
end;

procedure TCalculator.SetValue(const AValue: Extended);
begin
  if (FValue <> AValue) then
  begin
    if FDecimalDigits = 0 then
      FValue := 0
    else
      FValue := AValue;
    DataChanged;
  end;
end;

procedure TCalculator.WMSize(var Message: TWMSize);
begin
  inherited;
  if Assigned(FDisplayPanel) and Assigned(FDisplay) and Assigned(FPanel) then
  begin
    FPanel.SetBounds(3, 3, Width - 6, Height - 6);
    FDisplay.SetBounds(FDisplayPanel.Top + 3, FDisplayPanel.Top + 3,
                       FDisplayPanel.Width - 6, 21);
  end;
end;

// clx procedure TCalculator.ChangeBounds(ALeft, ATop, AWidth, AHeight: Integer);
{ TBaseEdit }

{
********************************** TBaseEdit ***********************************
}
constructor TBaseEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TBaseEdit.CreateParams(var params:TCreateParams);
  
  const
    Alignments : array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
  
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or Alignments[FAlignment] or ES_MULTILINE;
end;

procedure TBaseEdit.SetAlignment(AValue: TAlignment);
begin
  if FAlignment <> AValue then
  begin
    FAlignment := AValue;
    RecreateWnd;
  end;
end;

{ TDBMultiEdit }

{
******************************* TCustomMultiEdit *******************************
}
constructor TCustomMultiEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Alignment          := taLeftJustify;
  FBlanksChar        := Space;
  Height             := 21;
  BevelInner         := bvNone;
  BevelKind          := bkNone;
  BevelOuter         := bvNone;
  BorderWidth        := 0;
  BorderStyle        := bsSingle;
  Ctl3D              := True;
  Color              := clWindow;
  FVisibleButton     := True;
  FButton            := TSpeedButton.Create(Self);
  FValue             := 0;
  FValueType         := vtString;
  with FButton do
  begin
    Parent           := Self;
    Width            := 19;
    OnClick          := ButtonClick;
    SetKind(bkClick);
    Align            := alRight;
  end;
  FEdit              := TBaseEdit.Create(Self);
  with FEdit do
  begin
    AutoSize         := False;
    BevelEdges       := [beTop, beLeft, beRight, beBottom];
    BevelInner       := bvNone;
    BevelKind        := bkNone;
    CharCase         := ecNormal;
    BevelOuter       := bvNone;
    BorderStyle      := bsNone;
    BorderWidth      := 0;
    Parent           := Self;
    EditMask         := '';
    OnChange         := EditChange;
    OnEnter          := EditEnter;
    OnKeyPress       := EditKeyPress;
    OnKeyDown        := EditKeyDown;
    Align            := alClient;
  end;
  Width              := FEdit.Width + FButton.Width + 4;
  Text               := Self.Name;
end;

destructor TCustomMultiEdit.Destroy;
begin
  FEdit.Free;
  FButton.Free;
  inherited Destroy;
end;

procedure TCustomMultiEdit.ButtonClick(Sender: TObject);
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self);
end;

procedure TCustomMultiEdit.Change;
begin
  if Assigned(OnChange) then FOnChange(Self);
end;

procedure TCustomMultiEdit.Clear;
begin
  if Assigned(FEdit) then FEdit.Clear;
end;

procedure TCustomMultiEdit.CMEnter(var Message: TCMGotFocus);
begin
  FEdit.SetFocus;
  inherited;
  if Assigned(OnEnter) then OnEnter(Self);
end;

procedure TCustomMultiEdit.CMExit(var Message: TCMExit);
begin
  SetFocus;
  FEdit.CheckCursor;
  DoExit;
end;

procedure TCustomMultiEdit.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if not HandleAllocated or (GetWindowLong(Handle, GWL_STYLE) and
    ES_MULTILINE <> 0) then Change;
end;

procedure TCustomMultiEdit.DataChange;
begin
  inherited;
end;

procedure TCustomMultiEdit.DataChanged;
var
  ClearText: Extended;
begin
  if FValueType in [vtInteger, vtFloat, vtCurrency] then
    if Assigned(FEdit) then
    begin
      if Numeric then
      begin
        if FDecimalDigits > 0 then
          FEdit.Text := FormatFloat(DisplayFormat, Value)
        else
          FEdit.Text := FormatFloat(DisplayFormat, AsInteger);
        ClearText := StrToFloat(DelChars(FEdit.Text, ThousandSeparator));
        FText := FloatToStr(ClearText);
        if Pos(DecimalSeparator, FText) > 0 then
          FNoComma := True
        else
          FNoComma := False;
      end;
    end;
end;

procedure TCustomMultiEdit.DisplayValueType;
begin
  case FValueType of
    vtString  : begin FValue := 0; FVarVariant := FEditText; end;
    vtInteger : SetIntegerValue(FText);
    vtFloat   : SetFloatValue(FText);
    vtCurrency: SetCurrencyValue(FText);
  else
    begin
      FValue      := 0;
      FVarVariant := '';
    end;
  end;
end;

function TCustomMultiEdit.EditCanModify: Boolean;
begin
  Result := True;
end;

procedure TCustomMultiEdit.EditChange(Sender: TObject);
begin
  inherited;
  FText       := FEdit.Text;
  FEditText   := FEdit.EditText;
  DisplayValueType;
end;

procedure TCustomMultiEdit.EditEnter(Sender: TObject);
begin
  inherited;
  if Assigned(OnEnter) then OnEnter(Self);
end;

procedure TCustomMultiEdit.EditKeyDown(Sender: TObject; var Key: Word; Shift: 
        TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Assigned(OnKeyDown) then OnKeyDown(Self, Key, Shift);
end;

procedure TCustomMultiEdit.EditKeyPress(Sender: TObject; var Key: Char);
begin
  case FValueType of
    vtInteger : if not (Key in ['0'..'9', '-', '+']) then key := #0;
    vtFloat, vtCurrency : if not (Key in ['0'..'9', '-', '+', '.', ',']) then key := #0;
  end;
  inherited;
  if Assigned(OnKeyPress) then OnKeyPress(Self, Key);
end;

function TCustomMultiEdit.GetDate: TDateTime;
begin
  Result := 0;
  if ValueType = vtCalendar then
  begin
    if DefaultToday then
      Result := SysUtils.Date
    else
      Result := 0;
    Result := StrToDateFmtDef(FDateFormat, Text, Result);
  end;
end;

function TCustomMultiEdit.GetDateMask: string;
begin
  Result := DefDateMask(FBlanksChar, FourDigitYear);
end;

function TCustomMultiEdit.GetMasked: Boolean;
begin
  Result := EditMask <> '';
end;

procedure TCustomMultiEdit.Reset;
begin
  FEdit.Reset;
end;

procedure TCustomMultiEdit.SelectAll;
begin
  FEdit.SelectAll;
end;

procedure TCustomMultiEdit.SetAlignment(const AValue: TAlignment);
begin
  if FAlignment <> AValue then
  begin
    FAlignment := AValue;
    FEdit.Alignment := AValue;
  end;
end;

procedure TCustomMultiEdit.SetAsInteger(const AValue: Integer);
begin
  if (FAsInteger <> AValue) and Numeric then
  begin
    if FDecimalDigits = 0 then
      FAsInteger := AValue
    else
      FAsInteger := 0;
    DataChanged;
  end;
end;

procedure TCustomMultiEdit.SetAutoSelect(const AValue: Boolean);
begin
  if FAutoSelect <> AValue then
  begin
    FAutoSelect      := AValue;
    FEdit.AutoSelect := AValue;
  end;
end;

procedure TCustomMultiEdit.SetBevelKind(const AValue: TBevelKind);
begin
  if FBevelKind <> AValue then
  begin
    FBevelKind       := AValue;
    if AValue <> bkNone then
      FEdit.BorderStyle := bsNone;
    FEdit.BevelKind  := AValue;
  end;
end;

procedure TCustomMultiEdit.SetBlanksChar(AValue: Char);
begin
  if AValue <> FBlanksChar then
  begin
    if (AValue < Space) then AValue := Space;
    FBlanksChar := AValue;
    UpdateMask;
  end;
end;

procedure TCustomMultiEdit.SetButtonHint(const AValue: string);
begin
  if FButtonHint <> AValue then
  begin
    FButton.Hint := FButtonHint;
    FButtonHint  := AValue;
  end;
end;

procedure TCustomMultiEdit.SetCharCase(const AValue: TEditCharCase);
begin
  if FCharCase <> AValue then
  begin
    FCharCase      := AValue;
    FEdit.CharCase := AValue;
  end;
end;

procedure TCustomMultiEdit.SetCurrencyValue(AValue: string);
begin
  while Pos(ThousandSeparator, AValue) > 0 do
    Delete(AValue, Pos(ThousandSeparator, AValue), 1);
  try
    FValue      := StrToCurr(AValue);
    FVarVariant := FloatToStrF(StrToCurr(AValue), ffCurrency, 7, 2);
  except on E:Exception do
    begin
      FValue      := 0;
      FVarVariant := 'Error: ' + E.Message + ' ==> ' + AValue;
    end;
  end;
end;

procedure TCustomMultiEdit.SetDate(const AValue: TDateTime);
begin
  if (FDate <> AValue) then
  begin
    FDate := AValue;
    DecodeDate(FDate, FYear, FMonth, FDay);
    Text  := DateToStr(FDate);
    DataChange;
  end;
end;

procedure TCustomMultiEdit.SetDisplayFormat(const AValue: string);
begin
  if FDisplayFormat <> AValue then
  begin
    FDisplayFormat := AValue;
    DataChanged;
  end;
end;

procedure TCustomMultiEdit.SetEditMask(const AValue: TEditMask);
begin
  if FEditMask <> AValue then
  begin
    FEdit.EditMask := AValue;
    FEditMask      := AValue;
  end;
end;

procedure TCustomMultiEdit.SetEditText(const AValue: string);
begin
  if FEditText <> AValue then
  begin
    FEdit.EditText := AValue;
    FEditText := AValue;
    DisplayValueType;
  end;
end;

procedure TCustomMultiEdit.SetFloatValue(AValue: string);
begin
  while Pos(ThousandSeparator, AValue) > 0 do
    Delete(AValue, Pos(ThousandSeparator, AValue), 1);
  try
    FValue      := StrToFloat(AValue);
    FVarVariant := StrToFloat(AValue);
  except on E:Exception do
    begin
      FValue      := 0;
      FVarVariant := 'Error: ' + E.Message + ' ==> ' + AValue;
    end;
  end;
end;

procedure TCustomMultiEdit.SetFont(const AValue: TFont);
begin
  if AValue <> FFont then
  begin
    FFont.Assign(AValue);
    FEdit.Font.Assign(AValue);
  end;
end;

procedure TCustomMultiEdit.SetIntegerValue(AValue: string);
begin
  while Pos(ThousandSeparator, AValue) > 0 do
    Delete(AValue, Pos(ThousandSeparator, AValue), 1);
  try
    FValue      := Trunc(StrToFloat(AValue));
    FVarVariant := Trunc(StrToFloat(AValue));
  except on E:Exception do
    begin
      FValue      := 0;
      FVarVariant := 'Error: ' + E.Message + ' ==> ' + AValue;
    end;
  end;
end;

procedure TCustomMultiEdit.SetKind(const AValue: TBitmapKind);
begin
  FKind := AValue;
  if not Assigned(FButton.Glyph) then
    FButton.Glyph := TBitmap.Create;
  try
    case AValue of
      bkClick     : FButton.Glyph.LoadFromResourceName(HInstance, 'CLICK');
      bkCustom    : FButton.Glyph.LoadFromResourceName(HInstance, 'NONE');
      bkEllipsis  : FButton.Glyph.LoadFromResourceName(HInstance, 'ELLIPSIS');
      bkCalendar  : FButton.Glyph.LoadFromResourceName(HInstance, 'CALENDAR');
      bkCalculator: FButton.Glyph.LoadFromResourceName(HInstance, 'CALCULATOR');
    end;
  except
    FButton.Glyph.Free;
  end;
end;

procedure TCustomMultiEdit.SetMaxLength(const AValue: Integer);
begin
  if FMaxLength <> AValue then
  begin
    FMaxLength      := AValue;
    FEdit.MaxLength := AValue;
  end;
end;

procedure TCustomMultiEdit.SetPasswordChar(const AValue: Char);
begin
  if FPasswordChar <> AValue then
  begin
    FPasswordChar      := AValue;
    FEdit.PasswordChar := AValue;
  end;
end;

procedure TCustomMultiEdit.SetReadOnly(const AValue: Boolean);
begin
  if FReadOnly <> AValue then
  begin
    FReadOnly      := AValue;
    FEdit.ReadOnly := AValue;
  end;
end;

procedure TCustomMultiEdit.SetText(const AValue: TMaskedText);
begin
  if FText <> AValue then
  begin
    FEdit.Text := AValue;
    FText      := AValue;
    DisplayValueType;
  end;
end;

procedure TCustomMultiEdit.SetValueType(const AValue: TValueType);
begin
  if FValueType <> AValue then
  begin
    FValueType := AValue;
    DisplayValueType;
  end;
end;

procedure TCustomMultiEdit.SetVisibleButton(const AValue: Boolean);
begin
  if FVisibleButton <> AValue then
  begin
    FButton.Visible := AValue;
    FVisibleButton  := AValue;
  end;
end;

procedure TCustomMultiEdit.UpdateFormat;
begin
  FDateFormat := DefDateFormat(FourDigitYear);
end;

procedure TCustomMultiEdit.UpdateMask;
var
  DateValue: TDateTime;
  OldFormat: string[10];
begin
  DateValue := GetDate;
  OldFormat := FDateFormat;
  UpdateFormat;
  if (GetDateMask <> FEdit.EditMask) or (OldFormat <> FDateFormat) then
  begin
    { force update }
    FEdit.EditMask := NullString;
    FEdit.EditMask := GetDateMask;
  end;
  SetDate(DateValue);
end;

{ TDBMultiEdit }

{
********************************* TDBMultiEdit *********************************
}
constructor TDBMultiEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly        := True;
  ControlStyle              := ControlStyle + [csReplicatable];
  FDataLink                 := TFieldDataLink.Create;
  FDataLink.Control         := Self;
  FDataLink.OnDataChange    := DataOnChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData    := UpdateData;
  FDataLink.OnActiveChange  := ActiveChange;
end;

destructor TDBMultiEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TDBMultiEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
end;

procedure TDBMultiEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

procedure TDBMultiEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    inherited ReadOnly := False;
end;

procedure TDBMultiEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    FEdit.SelectAll;
    FEdit.SetFocus;
    raise;
  end;
  SetFocused(False);
  FEdit.CheckCursor;
  DoExit;
end;

procedure TDBMultiEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TDBMultiEdit.DataOnChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAlignment <> FDataLink.Field.Alignment then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if FFocused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else
    begin
      EditText := FDataLink.Field.DisplayText;
      if FDataLink.Editing and FEdit.Modified then
        FDataLink.Modified;
    end;
  end else
  begin
    FAlignment := taLeftJustify;
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name else
      EditText := '';
  end;
end;

function TDBMultiEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TDBMultiEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

function TDBMultiEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TDBMultiEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TDBMultiEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TDBMultiEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TDBMultiEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBMultiEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TDBMultiEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

procedure TDBMultiEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataOnChange(Self);
end;

procedure TDBMultiEdit.Notification(AComponent: TComponent; Operation: 
        TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
     (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TDBMultiEdit.Reset;
begin
  inherited;
  FDataLink.Reset;
  SelectAll;
end;

procedure TDBMultiEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

procedure TDBMultiEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

procedure TDBMultiEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TDBMultiEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then
      Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TDBMultiEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TDBMultiEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TDBMultiEdit.UpdateData(Sender: TObject);
begin
  FEdit.ValidateEdit;
  FDataLink.Field.Text := Text;
end;

function TDBMultiEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TDBMultiEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBMultiEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TDBMultiEdit.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

end.
