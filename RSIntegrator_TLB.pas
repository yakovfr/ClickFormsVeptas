unit RSIntegrator_TLB;

// ************************************************************************ //
// WARNING                                                                  //
// -------                                                                  //
// The types declared in this file were generated from data read from a     //
// Type Library. If this type library is explicitly or indirectly (via      //
// another type library referring to this type library) re-imported, or the //
// 'Refresh' command of the Type Library Editor activated while editing the //
// Type Library, the contents of this file will be regenerated and all      //
// manual modifications will be lost.                                       //
// ************************************************************************ //

// PASTLWTR : $Revision:   1.11.1.75  $
// File generated on 4/14/2008 3:04:28 PM from Type Library described below.

// ************************************************************************ //
// Type Lib: C:\RSIntegrator.ocx
// IID\LCID: {B07B7EFD-6049-4745-8E1C-0AFEC2EC439A}\0
// Helpfile: 
// HelpString: RapidSketch Integration Mediator
// Version:    1.0
// ************************************************************************ //

interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:      //
//   Type Libraries     : LIBID_xxxx                                    //
//   CoClasses          : CLASS_xxxx                                    //
//   DISPInterfaces     : DIID_xxxx                                     //
//   Non-DISP interfaces: IID_xxxx                                      //
// *********************************************************************//
const
  LIBID_RSIntegrator: TGUID = '{B07B7EFD-6049-4745-8E1C-0AFEC2EC439A}';
  IID__RapidSketch: TGUID = '{E415D419-67E5-4AC8-97B2-FD79D4F1A517}';
  DIID___RapidSketch: TGUID = '{70A5C4BC-20EE-4F4E-A8E2-3B5CA37E8090}';
  CLASS_RapidSketch: TGUID = '{CB6AD88C-84BF-43B3-857F-D9062528FDE0}';
type

// *********************************************************************//
// Forward declaration of interfaces defined in Type Library            //
// *********************************************************************//
  _RapidSketch = interface;
  _RapidSketchDisp = dispinterface;
  __RapidSketch = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                     //
// (NOTE: Here we map each CoClass to its Default Interface)            //
// *********************************************************************//
  RapidSketch = _RapidSketch;


// *********************************************************************//
// Interface: _RapidSketch
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E415D419-67E5-4AC8-97B2-FD79D4F1A517}
// *********************************************************************//
  _RapidSketch = interface(IDispatch)
    ['{E415D419-67E5-4AC8-97B2-FD79D4F1A517}']
    function FileExists(var Fname: WideString): WordBool; safecall;
    function Get_BackColor: Integer; safecall;
    procedure Set_BackColor(Param1: Integer); safecall;
    function Get_ForeColor: Integer; safecall;
    procedure Set_ForeColor(Param1: Integer); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Param1: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure Set_Font(const Param1: IFontDisp); safecall;
    function Get_BackStyle: Smallint; safecall;
    procedure Set_BackStyle(Param1: Smallint); safecall;
    function Get_BorderStyle: Smallint; safecall;
    procedure Set_BorderStyle(Param1: Smallint); safecall;
    procedure Refresh; safecall;
    function Get_Level1: WideString; safecall;
    procedure Set_Level1(const Param1: WideString); safecall;
    function Get_Level2: WideString; safecall;
    procedure Set_Level2(const Param1: WideString); safecall;
    function Get_Level3: WideString; safecall;
    procedure Set_Level3(const Param1: WideString); safecall;
    function Get_Basement: WideString; safecall;
    procedure Set_Basement(const Param1: WideString); safecall;
    function Get_TotalGLA: WideString; safecall;
    procedure Set_TotalGLA(const Param1: WideString); safecall;
    function Get_CarStorage: WideString; safecall;
    procedure Set_CarStorage(const Param1: WideString); safecall;
    function Get_Areas: WideString; safecall;
    procedure Set_Areas(const Param1: WideString); safecall;
    function Get_SketchData: WideString; safecall;
    procedure Set_SketchData(const Param1: WideString); safecall;
    function Get_Result_: WideString; safecall;
    procedure Set_Result_(const Param1: WideString); safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_FileName(const Param1: WideString); safecall;
    function Get_Command: WideString; safecall;
    procedure Set_Command(const Param1: WideString); safecall;
    function GetSketchImage(AIndex: OleVariant): OleVariant; safecall;
    function Get_PageLow: WideString; safecall;
    procedure Set_PageLow(const Param1: WideString); safecall;
    function Get_PageHigh: WideString; safecall;
    procedure Set_PageHigh(const Param1: WideString); safecall;
    function Launch(AFileName: OleVariant; AData: OleVariant; var AppName: OleVariant): Smallint; safecall;
    function Get_AppName: WideString; safecall;
    procedure Set_AppName(const Param1: WideString); safecall;
    property BackColor: Integer read Get_BackColor write Set_BackColor;
    property ForeColor: Integer read Get_ForeColor write Set_ForeColor;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property Font: IFontDisp read Get_Font write Set_Font;
    property BackStyle: Smallint read Get_BackStyle write Set_BackStyle;
    property BorderStyle: Smallint read Get_BorderStyle write Set_BorderStyle;
    property Level1: WideString read Get_Level1 write Set_Level1;
    property Level2: WideString read Get_Level2 write Set_Level2;
    property Level3: WideString read Get_Level3 write Set_Level3;
    property Basement: WideString read Get_Basement write Set_Basement;
    property TotalGLA: WideString read Get_TotalGLA write Set_TotalGLA;
    property CarStorage: WideString read Get_CarStorage write Set_CarStorage;
    property Areas: WideString read Get_Areas write Set_Areas;
    property SketchData: WideString read Get_SketchData write Set_SketchData;
    property Result_: WideString read Get_Result_ write Set_Result_;
    property FileName: WideString read Get_FileName write Set_FileName;
    property Command: WideString read Get_Command write Set_Command;
    property PageLow: WideString read Get_PageLow write Set_PageLow;
    property PageHigh: WideString read Get_PageHigh write Set_PageHigh;
    property AppName: WideString read Get_AppName write Set_AppName;
  end;

// *********************************************************************//
// DispIntf:  _RapidSketchDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E415D419-67E5-4AC8-97B2-FD79D4F1A517}
// *********************************************************************//
  _RapidSketchDisp = dispinterface
    ['{E415D419-67E5-4AC8-97B2-FD79D4F1A517}']
    function FileExists(var Fname: WideString): WordBool; dispid 1610809366;
    property BackColor: Integer dispid 1745027090;
    property ForeColor: Integer dispid 1745027089;
    property Enabled: WordBool dispid 1745027088;
    property Font: IFontDisp dispid -512;
    property BackStyle: Smallint dispid 1745027087;
    property BorderStyle: Smallint dispid 1745027086;
    procedure Refresh; dispid 1610809370;
    property Level1: WideString dispid 1745027085;
    property Level2: WideString dispid 1745027084;
    property Level3: WideString dispid 1745027083;
    property Basement: WideString dispid 1745027082;
    property TotalGLA: WideString dispid 1745027081;
    property CarStorage: WideString dispid 1745027080;
    property Areas: WideString dispid 1745027079;
    property SketchData: WideString dispid 1745027078;
    property Result_: WideString dispid 1745027077;
    property FileName: WideString dispid 1745027076;
    property Command: WideString dispid 1745027075;
    function GetSketchImage(AIndex: OleVariant): OleVariant; dispid 1610809376;
    property PageLow: WideString dispid 1745027074;
    property PageHigh: WideString dispid 1745027073;
    function Launch(AFileName: OleVariant; AData: OleVariant; var AppName: OleVariant): Smallint; dispid 1610809377;
    property AppName: WideString dispid 1745027072;
  end;

// *********************************************************************//
// DispIntf:  __RapidSketch
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {70A5C4BC-20EE-4F4E-A8E2-3B5CA37E8090}
// *********************************************************************//
  __RapidSketch = dispinterface
    ['{70A5C4BC-20EE-4F4E-A8E2-3B5CA37E8090}']
    procedure Click; dispid 3;
    procedure DblClick; dispid 4;
    procedure KeyDown(var KeyCode: Smallint; var Shift: Smallint); dispid 5;
    procedure KeyPress(var KeyAscii: Smallint); dispid 6;
    procedure KeyUp(var KeyCode: Smallint; var Shift: Smallint); dispid 7;
    procedure MouseDown(var Button: Smallint; var Shift: Smallint; var X: Single; var Y: Single); dispid 8;
    procedure MouseMove(var Button: Smallint; var Shift: Smallint; var X: Single; var Y: Single); dispid 9;
    procedure MouseUp(var Button: Smallint; var Shift: Smallint; var X: Single; var Y: Single); dispid 10;
    procedure OnSketchClose; dispid 11;
    procedure Transfer; dispid 1;
    procedure CancelAll; dispid 2;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TRapidSketch
// Help String      : 
// Default Interface: _RapidSketch
// Def. Intf. DISP? : No
// Event   Interface: __RapidSketch
// TypeFlags        : (32) Control
// *********************************************************************//
  TRapidSketchKeyDown = procedure(Sender: TObject; var KeyCode: Smallint; var Shift: Smallint) of object;
  TRapidSketchKeyPress = procedure(Sender: TObject; var KeyAscii: Smallint) of object;
  TRapidSketchKeyUp = procedure(Sender: TObject; var KeyCode: Smallint; var Shift: Smallint) of object;
  TRapidSketchMouseDown = procedure(Sender: TObject; var Button: Smallint; var Shift: Smallint; 
                                                     var X: Single; var Y: Single) of object;
  TRapidSketchMouseMove = procedure(Sender: TObject; var Button: Smallint; var Shift: Smallint; 
                                                     var X: Single; var Y: Single) of object;
  TRapidSketchMouseUp = procedure(Sender: TObject; var Button: Smallint; var Shift: Smallint; 
                                                   var X: Single; var Y: Single) of object;

  TRapidSketch = class(TOleControl)
  private
    FOn__RapidSketch_Click: TNotifyEvent;
    FOn__RapidSketch_DblClick: TNotifyEvent;
    FOn__RapidSketch_KeyDown: TRapidSketchKeyDown;
    FOn__RapidSketch_KeyPress: TRapidSketchKeyPress;
    FOn__RapidSketch_KeyUp: TRapidSketchKeyUp;
    FOn__RapidSketch_MouseDown: TRapidSketchMouseDown;
    FOn__RapidSketch_MouseMove: TRapidSketchMouseMove;
    FOn__RapidSketch_MouseUp: TRapidSketchMouseUp;
    FOnSketchClose: TNotifyEvent;
    FOnTransfer: TNotifyEvent;
    FOnCancelAll: TNotifyEvent;
    FIntf: _RapidSketch;
    function  GetControlInterface: _RapidSketch;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function FileExists(var Fname: WideString): WordBool;
    procedure Refresh;
    function GetSketchImage(AIndex: OleVariant): OleVariant;
    function Launch(AFileName: OleVariant; AData: OleVariant; var AppName: OleVariant): Smallint;
    property  ControlInterface: _RapidSketch read GetControlInterface;
    property Font: TFont index -512 read GetTFontProp write SetTFontProp;
  published
    property  ParentFont;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property BackColor: Integer index 1745027090 read GetIntegerProp write SetIntegerProp stored False;
    property ForeColor: Integer index 1745027089 read GetIntegerProp write SetIntegerProp stored False;
    property Enabled: WordBool index 1745027088 read GetWordBoolProp write SetWordBoolProp stored False;
    property BackStyle: Smallint index 1745027087 read GetSmallintProp write SetSmallintProp stored False;
    property BorderStyle: Smallint index 1745027086 read GetSmallintProp write SetSmallintProp stored False;
    property Level1: WideString index 1745027085 read GetWideStringProp write SetWideStringProp stored False;
    property Level2: WideString index 1745027084 read GetWideStringProp write SetWideStringProp stored False;
    property Level3: WideString index 1745027083 read GetWideStringProp write SetWideStringProp stored False;
    property Basement: WideString index 1745027082 read GetWideStringProp write SetWideStringProp stored False;
    property TotalGLA: WideString index 1745027081 read GetWideStringProp write SetWideStringProp stored False;
    property CarStorage: WideString index 1745027080 read GetWideStringProp write SetWideStringProp stored False;
    property Areas: WideString index 1745027079 read GetWideStringProp write SetWideStringProp stored False;
    property SketchData: WideString index 1745027078 read GetWideStringProp write SetWideStringProp stored False;
    property Result_: WideString index 1745027077 read GetWideStringProp write SetWideStringProp stored False;
    property FileName: WideString index 1745027076 read GetWideStringProp write SetWideStringProp stored False;
    property Command: WideString index 1745027075 read GetWideStringProp write SetWideStringProp stored False;
    property PageLow: WideString index 1745027074 read GetWideStringProp write SetWideStringProp stored False;
    property PageHigh: WideString index 1745027073 read GetWideStringProp write SetWideStringProp stored False;
    property AppName: WideString index 1745027072 read GetWideStringProp write SetWideStringProp stored False;
    property On__RapidSketch_Click: TNotifyEvent read FOn__RapidSketch_Click write FOn__RapidSketch_Click;
    property On__RapidSketch_DblClick: TNotifyEvent read FOn__RapidSketch_DblClick write FOn__RapidSketch_DblClick;
    property On__RapidSketch_KeyDown: TRapidSketchKeyDown read FOn__RapidSketch_KeyDown write FOn__RapidSketch_KeyDown;
    property On__RapidSketch_KeyPress: TRapidSketchKeyPress read FOn__RapidSketch_KeyPress write FOn__RapidSketch_KeyPress;
    property On__RapidSketch_KeyUp: TRapidSketchKeyUp read FOn__RapidSketch_KeyUp write FOn__RapidSketch_KeyUp;
    property On__RapidSketch_MouseDown: TRapidSketchMouseDown read FOn__RapidSketch_MouseDown write FOn__RapidSketch_MouseDown;
    property On__RapidSketch_MouseMove: TRapidSketchMouseMove read FOn__RapidSketch_MouseMove write FOn__RapidSketch_MouseMove;
    property On__RapidSketch_MouseUp: TRapidSketchMouseUp read FOn__RapidSketch_MouseUp write FOn__RapidSketch_MouseUp;
    property OnSketchClose: TNotifyEvent read FOnSketchClose write FOnSketchClose;
    property OnTransfer: TNotifyEvent read FOnTransfer write FOnTransfer;
    property OnCancelAll: TNotifyEvent read FOnCancelAll write FOnCancelAll;
  end;

procedure Register;

implementation

uses ComObj;

procedure TRapidSketch.InitControlData;
const
  CEventDispIDs: array [0..10] of DWORD = (
    $00000003, $00000004, $00000005, $00000006, $00000007, $00000008,
    $00000009, $0000000A, $0000000B, $00000001, $00000002);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CControlData: TControlData2 = (
    ClassID: '{CB6AD88C-84BF-43B3-857F-D9062528FDE0}';
    EventIID: '{70A5C4BC-20EE-4F4E-A8E2-3B5CA37E8090}';
    EventCount: 11;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil;
    Flags: $00000004;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
//  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOn__RapidSketch_Click) - Cardinal(Self);
end;

procedure TRapidSketch.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _RapidSketch;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TRapidSketch.GetControlInterface: _RapidSketch;
begin
  CreateControl;
  Result := FIntf;
end;

function TRapidSketch.FileExists(var Fname: WideString): WordBool;
begin
  Result := ControlInterface.FileExists(Fname);
end;

procedure TRapidSketch.Refresh;
begin
  ControlInterface.Refresh;
end;

function TRapidSketch.GetSketchImage(AIndex: OleVariant): OleVariant;
begin
  Result := ControlInterface.GetSketchImage(AIndex);
end;

function TRapidSketch.Launch(AFileName: OleVariant; AData: OleVariant; var AppName: OleVariant): Smallint;
begin
  Result := ControlInterface.Launch(AFileName, AData, AppName);
end;

procedure Register;
begin
  RegisterComponents('Additional',[TRapidSketch]);
end;

end.
