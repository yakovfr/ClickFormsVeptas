unit TOOLPADLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 9/11/2005 1:42:22 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\ClickForms7\Tools\Sketchers\AreaSketch\toolpad.ocx (1)
// LIBID: {3572365C-6FF9-4E44-B486-023E935B987A}
// LCID: 0
// Helpfile: C:\ClickForms7\Tools\Sketchers\AreaSketch\ToolPad.hlp
// HelpString: ToolPad ActiveX Control module
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
// Errors:
//   Hint: Symbol 'Type' renamed to 'type_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  TOOLPADLibMajorVersion = 1;
  TOOLPADLibMinorVersion = 0;

  LIBID_TOOLPADLib: TGUID = '{3572365C-6FF9-4E44-B486-023E935B987A}';

  DIID__DToolPad: TGUID = '{A9F0B0E2-302E-4F1B-A666-7D79648EC790}';
  DIID__DToolPadEvents: TGUID = '{2E9A5EC3-A1E7-4065-A032-5E72FD42B41F}';
  CLASS_ToolPad: TGUID = '{F17A0E18-97B6-4C4D-9277-6832DB40EC61}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DToolPad = dispinterface;
  _DToolPadEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ToolPad = _DToolPad;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PInteger1 = ^Integer; {*}


// *********************************************************************//
// DispIntf:  _DToolPad
// Flags:     (4112) Hidden Dispatchable
// GUID:      {A9F0B0E2-302E-4F1B-A666-7D79648EC790}
// *********************************************************************//
  _DToolPad = dispinterface
    ['{A9F0B0E2-302E-4F1B-A666-7D79648EC790}']
    property type_: Smallint dispid 1;
    procedure PreferredSize(var width: Integer; var height: Integer); dispid 2;
    procedure SetDrawingPad(const drawingPad: IUnknown); dispid 3;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf:  _DToolPadEvents
// Flags:     (4096) Dispatchable
// GUID:      {2E9A5EC3-A1E7-4065-A032-5E72FD42B41F}
// *********************************************************************//
  _DToolPadEvents = dispinterface
    ['{2E9A5EC3-A1E7-4065-A032-5E72FD42B41F}']
    procedure KeyPressed(nKey: Smallint); dispid 1;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TToolPad
// Help String      : ToolPad Control
// Default Interface: _DToolPad
// Def. Intf. DISP? : Yes
// Event   Interface: _DToolPadEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TToolPadKeyPressed = procedure(ASender: TObject; nKey: Smallint) of object;

  TToolPad = class(TOleControl)
  private
    FOnKeyPressed: TToolPadKeyPressed;
    FIntf: _DToolPad;
    function  GetControlInterface: _DToolPad;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure PreferredSize(var width: Integer; var height: Integer);
    procedure SetDrawingPad(const drawingPad: IUnknown);
    procedure AboutBox;
    property  ControlInterface: _DToolPad read GetControlInterface;
    property  DefaultInterface: _DToolPad read GetControlInterface;
  published
    property Anchors;
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
    property type_: Smallint index 1 read GetSmallintProp write SetSmallintProp stored False;
    property OnKeyPressed: TToolPadKeyPressed read FOnKeyPressed write FOnKeyPressed;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'AreaSketch';

  dtlOcxPage = 'AreaSketch';

implementation

uses ComObj;

procedure TToolPad.InitControlData;
const
  CEventDispIDs: array [0..0] of DWORD = (
    $00000001);
  CControlData: TControlData2 = (
    ClassID: '{F17A0E18-97B6-4C4D-9277-6832DB40EC61}';
    EventIID: '{2E9A5EC3-A1E7-4065-A032-5E72FD42B41F}';
    EventCount: 1;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnKeyPressed) - Cardinal(Self);
end;

procedure TToolPad.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DToolPad;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TToolPad.GetControlInterface: _DToolPad;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TToolPad.PreferredSize(var width: Integer; var height: Integer);
begin
  DefaultInterface.PreferredSize(width, height);
end;

procedure TToolPad.SetDrawingPad(const drawingPad: IUnknown);
begin
  DefaultInterface.SetDrawingPad(drawingPad);
end;

procedure TToolPad.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TToolPad]);
end;

end.
