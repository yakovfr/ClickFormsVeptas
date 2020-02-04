unit AREACALCLib_TLB;

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
// File generated on 1/21/2006 9:25:25 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\ClickForms7Components\AreaSketch\AreaSketch_w_Bluetooth\areacalc.tlb (1)
// LIBID: {6589E899-D7FF-4EA6-ABC9-011721387984}
// LCID: 0
// Helpfile: C:\ClickForms7Components\AreaSketch\AreaSketch_w_Bluetooth\helpfile.htm
// HelpString: AreaSketch ActiveX Control module
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Hint: Parameter 'label' of IAreaSketchCallback.GetLabel changed to 'label_'
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
  AREACALCLibMajorVersion = 2;
  AREACALCLibMinorVersion = 0;

  LIBID_AREACALCLib: TGUID = '{6589E899-D7FF-4EA6-ABC9-011721387984}';

  DIID__DDrawingPad: TGUID = '{ED73B4D1-3A55-41E9-9A69-3F7B092F182A}';
  DIID__DDrawingPadEvents: TGUID = '{BB77F169-4248-46A0-9BB7-513581CB8AF1}';
  CLASS_DrawingPad: TGUID = '{2F5C9C6B-4117-4A42-A836-2735A8FCF5C6}';
  DIID__DAreaSketchCalc: TGUID = '{4340D2CB-468E-40D4-8FDE-CB51E342F9F4}';
  DIID__DAreaSketchCalcEvents: TGUID = '{9A170B87-0724-44F1-AE19-DD1963AA3D6C}';
  CLASS_AreaSketchCalc: TGUID = '{D707EABF-8E54-44A4-B348-313174F73ED9}';
  DIID_IToolPadEventSink: TGUID = '{85588C6C-3E49-49EE-9165-088FDF01C17B}';
  CLASS_ToolPadEventSink: TGUID = '{63503C64-A7B0-4B95-BBD1-8535FDF516C9}';
  DIID__DToolPadEvents: TGUID = '{2E9A5EC3-A1E7-4065-A032-5E72FD42B41F}';
  DIID_IDrawingPadEventSink: TGUID = '{B7A26E38-DD19-4962-97EB-5AB174FCD75B}';
  CLASS_DrawingPadEventSink: TGUID = '{3C697FF0-5DEF-4B6D-811F-9C012C329EC2}';
  IID_IAreaSketchCallback: TGUID = '{A6D9CB49-E931-4951-8E95-81835681ECB0}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DDrawingPad = dispinterface;
  _DDrawingPadEvents = dispinterface;
  _DAreaSketchCalc = dispinterface;
  _DAreaSketchCalcEvents = dispinterface;
  IToolPadEventSink = dispinterface;
  _DToolPadEvents = dispinterface;
  IDrawingPadEventSink = dispinterface;
  IAreaSketchCallback = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DrawingPad = _DDrawingPad;
  AreaSketchCalc = _DAreaSketchCalc;
  ToolPadEventSink = IToolPadEventSink;
  DrawingPadEventSink = IDrawingPadEventSink;


// *********************************************************************//
// DispIntf:  _DDrawingPad
// Flags:     (4112) Hidden Dispatchable
// GUID:      {ED73B4D1-3A55-41E9-9A69-3F7B092F182A}
// *********************************************************************//
  _DDrawingPad = dispinterface
    ['{ED73B4D1-3A55-41E9-9A69-3F7B092F182A}']
    property AreaLineStyle: Smallint dispid 1;
    property AreaLineWidth: Smallint dispid 2;
    property AreaLineColor: OLE_COLOR dispid 3;
    property ReadOnly: WordBool dispid 4;
    property DimensionOn: WordBool dispid 22;
    property ShowPropertyToolBar: WordBool dispid 24;
    property ToolPadType: Smallint dispid 25;
    property LicServer: WideString dispid 28;
    property LicServerKey: WideString dispid 29;
    property EnableAutoZoom: WordBool dispid 31;
    property EnableSnapTo: WordBool dispid 32;
    function AddArea(const data: WideString): WordBool; dispid 5;
    procedure Zoom(percentage: Smallint); dispid 6;
    function CreateArea(const id: WideString; const name: WideString): WordBool; dispid 7;
    function NumberOfAreas: Smallint; dispid 8;
    function GetArea(index: Smallint; out id: OleVariant; out name: OleVariant; 
                     out desc: OleVariant; out status: OleVariant; out area: OleVariant; 
                     out perimeter: OleVariant): WordBool; dispid 9;
    procedure Clear; dispid 10;
    procedure SetAreaNameList(list: OleVariant); dispid 11;
    function LoadSketch(const data: WideString): WordBool; dispid 12;
    function GetSketch(out data: OleVariant): WordBool; dispid 13;
    procedure SetLabelList(labels: OleVariant); dispid 14;
    function GetSketchAsJPEG(width: Integer; height: Integer; quality: Smallint; 
                             out contents: OleVariant): WordBool; dispid 15;
    function SaveSketchAsJPEG(width: Integer; height: Integer; quality: Smallint; 
                              const fileName: WideString): WordBool; dispid 16;
    procedure KeyPressed(nKey: Smallint); dispid 17;
    procedure SetupToolPad(const pToolPad: IUnknown); dispid 18;
    function IsModified: WordBool; dispid 19;
    function SetupCallback(const pCallback: IUnknown): WordBool; dispid 20;
    function CreateAreaWithAttr(const id: WideString; const name: WideString; lineStyle: Smallint; 
                                lineWidth: Smallint; lineColor: OLE_COLOR; dimon: Smallint; 
                                const autoLabel: WideString; const showCalc: WideString; 
                                const customFields: WideString): WordBool; dispid 21;
    function GetSketchAsMetafile(hinchesX: Integer; hinchesY: Integer; out contents: OleVariant): WordBool; dispid 23;
    function SetupConfig(const data: WideString): WordBool; dispid 26;
    function SetupSymbols(const data: WideString): WordBool; dispid 27;
    function GetAreaById(const uid: WideString; out name: OleVariant; out desc: OleVariant; 
                         out status: OleVariant; out area: OleVariant; out perimeter: OleVariant): WordBool; dispid 30;
    function ConnectToDisto(connect: WordBool): WordBool; dispid 33;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf:  _DDrawingPadEvents
// Flags:     (4096) Dispatchable
// GUID:      {BB77F169-4248-46A0-9BB7-513581CB8AF1}
// *********************************************************************//
  _DDrawingPadEvents = dispinterface
    ['{BB77F169-4248-46A0-9BB7-513581CB8AF1}']
    procedure AreaAdded(const id: WideString; const name: WideString; surface: Double; 
                        perimeter: Double); dispid 1;
    procedure AreaDeleted(const id: WideString; const name: WideString); dispid 2;
    procedure AreaModified(const id: WideString; const name: WideString; surface: Double; 
                           perimeter: Double); dispid 3;
    procedure SketchCleared; dispid 4;
    procedure SketchLoaded; dispid 5;
  end;

// *********************************************************************//
// DispIntf:  _DAreaSketchCalc
// Flags:     (4112) Hidden Dispatchable
// GUID:      {4340D2CB-468E-40D4-8FDE-CB51E342F9F4}
// *********************************************************************//
  _DAreaSketchCalc = dispinterface
    ['{4340D2CB-468E-40D4-8FDE-CB51E342F9F4}']
    procedure SetupDrawingPad(const pDrawingPad: IUnknown); dispid 1;
    procedure AboutBox; dispid -552;
  end;

// *********************************************************************//
// DispIntf:  _DAreaSketchCalcEvents
// Flags:     (4096) Dispatchable
// GUID:      {9A170B87-0724-44F1-AE19-DD1963AA3D6C}
// *********************************************************************//
  _DAreaSketchCalcEvents = dispinterface
    ['{9A170B87-0724-44F1-AE19-DD1963AA3D6C}']
  end;

// *********************************************************************//
// DispIntf:  IToolPadEventSink
// Flags:     (4096) Dispatchable
// GUID:      {85588C6C-3E49-49EE-9165-088FDF01C17B}
// *********************************************************************//
  IToolPadEventSink = dispinterface
    ['{85588C6C-3E49-49EE-9165-088FDF01C17B}']
  end;

// *********************************************************************//
// DispIntf:  _DToolPadEvents
// Flags:     (4096) Dispatchable
// GUID:      {2E9A5EC3-A1E7-4065-A032-5E72FD42B41F}
// *********************************************************************//
  _DToolPadEvents = dispinterface
    ['{2E9A5EC3-A1E7-4065-A032-5E72FD42B41F}']
  end;

// *********************************************************************//
// DispIntf:  IDrawingPadEventSink
// Flags:     (4096) Dispatchable
// GUID:      {B7A26E38-DD19-4962-97EB-5AB174FCD75B}
// *********************************************************************//
  IDrawingPadEventSink = dispinterface
    ['{B7A26E38-DD19-4962-97EB-5AB174FCD75B}']
  end;

// *********************************************************************//
// Interface: IAreaSketchCallback
// Flags:     (0)
// GUID:      {A6D9CB49-E931-4951-8E95-81835681ECB0}
// *********************************************************************//
  IAreaSketchCallback = interface(IUnknown)
    ['{A6D9CB49-E931-4951-8E95-81835681ECB0}']
    function GetAreaDefinition(out id: OleVariant; out name: OleVariant; out areaDefs: OleVariant; 
                               out customFields: OleVariant): HResult; stdcall;
    function GetLabel(out label_: OleVariant): HResult; stdcall;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDrawingPad
// Help String      : DrawingPad Control
// Default Interface: _DDrawingPad
// Def. Intf. DISP? : Yes
// Event   Interface: _DDrawingPadEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TDrawingPadAreaAdded = procedure(ASender: TObject; const id: WideString; const name: WideString; 
                                                     surface: Double; perimeter: Double) of object;
  TDrawingPadAreaDeleted = procedure(ASender: TObject; const id: WideString; const name: WideString) of object;
  TDrawingPadAreaModified = procedure(ASender: TObject; const id: WideString; 
                                                        const name: WideString; surface: Double; 
                                                        perimeter: Double) of object;

  TDrawingPad = class(TOleControl)
  private
    FOnAreaAdded: TDrawingPadAreaAdded;
    FOnAreaDeleted: TDrawingPadAreaDeleted;
    FOnAreaModified: TDrawingPadAreaModified;
    FOnSketchCleared: TNotifyEvent;
    FOnSketchLoaded: TNotifyEvent;
    FIntf: _DDrawingPad;
    function  GetControlInterface: _DDrawingPad;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function AddArea(const data: WideString): WordBool;
    procedure Zoom(percentage: Smallint);
    function CreateArea(const id: WideString; const name: WideString): WordBool;
    function NumberOfAreas: Smallint;
    function GetArea(index: Smallint; out id: OleVariant; out name: OleVariant; 
                     out desc: OleVariant; out status: OleVariant; out area: OleVariant; 
                     out perimeter: OleVariant): WordBool;
    procedure Clear;
    procedure SetAreaNameList(list: OleVariant);
    function LoadSketch(const data: WideString): WordBool;
    function GetSketch(out data: OleVariant): WordBool;
    procedure SetLabelList(labels: OleVariant);
    function GetSketchAsJPEG(width: Integer; height: Integer; quality: Smallint; 
                             out contents: OleVariant): WordBool;
    function SaveSketchAsJPEG(width: Integer; height: Integer; quality: Smallint; 
                              const fileName: WideString): WordBool;
    procedure KeyPressed(nKey: Smallint);
    procedure SetupToolPad(const pToolPad: IUnknown);
    function IsModified: WordBool;
    function SetupCallback(const pCallback: IUnknown): WordBool;
    function CreateAreaWithAttr(const id: WideString; const name: WideString; lineStyle: Smallint; 
                                lineWidth: Smallint; lineColor: OLE_COLOR; dimon: Smallint; 
                                const autoLabel: WideString; const showCalc: WideString; 
                                const customFields: WideString): WordBool;
    function GetSketchAsMetafile(hinchesX: Integer; hinchesY: Integer; out contents: OleVariant): WordBool;
    function SetupConfig(const data: WideString): WordBool;
    function SetupSymbols(const data: WideString): WordBool;
    function GetAreaById(const uid: WideString; out name: OleVariant; out desc: OleVariant; 
                         out status: OleVariant; out area: OleVariant; out perimeter: OleVariant): WordBool;
    function ConnectToDisto(connect: WordBool): WordBool;
    procedure AboutBox;
    property  ControlInterface: _DDrawingPad read GetControlInterface;
    property  DefaultInterface: _DDrawingPad read GetControlInterface;
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
    property AreaLineStyle: Smallint index 1 read GetSmallintProp write SetSmallintProp stored False;
    property AreaLineWidth: Smallint index 2 read GetSmallintProp write SetSmallintProp stored False;
    property AreaLineColor: TColor index 3 read GetTColorProp write SetTColorProp stored False;
    property ReadOnly: WordBool index 4 read GetWordBoolProp write SetWordBoolProp stored False;
    property DimensionOn: WordBool index 22 read GetWordBoolProp write SetWordBoolProp stored False;
    property ShowPropertyToolBar: WordBool index 24 read GetWordBoolProp write SetWordBoolProp stored False;
    property ToolPadType: Smallint index 25 read GetSmallintProp write SetSmallintProp stored False;
    property LicServer: WideString index 28 read GetWideStringProp write SetWideStringProp stored False;
    property LicServerKey: WideString index 29 read GetWideStringProp write SetWideStringProp stored False;
    property EnableAutoZoom: WordBool index 31 read GetWordBoolProp write SetWordBoolProp stored False;
    property EnableSnapTo: WordBool index 32 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnAreaAdded: TDrawingPadAreaAdded read FOnAreaAdded write FOnAreaAdded;
    property OnAreaDeleted: TDrawingPadAreaDeleted read FOnAreaDeleted write FOnAreaDeleted;
    property OnAreaModified: TDrawingPadAreaModified read FOnAreaModified write FOnAreaModified;
    property OnSketchCleared: TNotifyEvent read FOnSketchCleared write FOnSketchCleared;
    property OnSketchLoaded: TNotifyEvent read FOnSketchLoaded write FOnSketchLoaded;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TAreaSketchCalc
// Help String      : AreaSketchCalc Control
// Default Interface: _DAreaSketchCalc
// Def. Intf. DISP? : Yes
// Event   Interface: _DAreaSketchCalcEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TAreaSketchCalc = class(TOleControl)
  private
    FIntf: _DAreaSketchCalc;
    function  GetControlInterface: _DAreaSketchCalc;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure SetupDrawingPad(const pDrawingPad: IUnknown);
    procedure AboutBox;
    property  ControlInterface: _DAreaSketchCalc read GetControlInterface;
    property  DefaultInterface: _DAreaSketchCalc read GetControlInterface;
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
  end;

// *********************************************************************//
// The Class CoToolPadEventSink provides a Create and CreateRemote method to          
// create instances of the default interface IToolPadEventSink exposed by              
// the CoClass ToolPadEventSink. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoToolPadEventSink = class
    class function Create: IToolPadEventSink;
    class function CreateRemote(const MachineName: string): IToolPadEventSink;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TToolPadEventSink
// Help String      : 
// Default Interface: IToolPadEventSink
// Def. Intf. DISP? : Yes
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TToolPadEventSinkProperties= class;
{$ENDIF}
  TToolPadEventSink = class(TOleServer)
  private
    FIntf:        IToolPadEventSink;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TToolPadEventSinkProperties;
    function      GetServerProperties: TToolPadEventSinkProperties;
{$ENDIF}
    function      GetDefaultInterface: IToolPadEventSink;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IToolPadEventSink);
    procedure Disconnect; override;
    property DefaultInterface: IToolPadEventSink read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TToolPadEventSinkProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TToolPadEventSink
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TToolPadEventSinkProperties = class(TPersistent)
  private
    FServer:    TToolPadEventSink;
    function    GetDefaultInterface: IToolPadEventSink;
    constructor Create(AServer: TToolPadEventSink);
  protected
  public
    property DefaultInterface: IToolPadEventSink read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDrawingPadEventSink provides a Create and CreateRemote method to          
// create instances of the default interface IDrawingPadEventSink exposed by              
// the CoClass DrawingPadEventSink. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDrawingPadEventSink = class
    class function Create: IDrawingPadEventSink;
    class function CreateRemote(const MachineName: string): IDrawingPadEventSink;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDrawingPadEventSink
// Help String      : 
// Default Interface: IDrawingPadEventSink
// Def. Intf. DISP? : Yes
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDrawingPadEventSinkProperties= class;
{$ENDIF}
  TDrawingPadEventSink = class(TOleServer)
  private
    FIntf:        IDrawingPadEventSink;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDrawingPadEventSinkProperties;
    function      GetServerProperties: TDrawingPadEventSinkProperties;
{$ENDIF}
    function      GetDefaultInterface: IDrawingPadEventSink;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDrawingPadEventSink);
    procedure Disconnect; override;
    property DefaultInterface: IDrawingPadEventSink read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDrawingPadEventSinkProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDrawingPadEventSink
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDrawingPadEventSinkProperties = class(TPersistent)
  private
    FServer:    TDrawingPadEventSink;
    function    GetDefaultInterface: IDrawingPadEventSink;
    constructor Create(AServer: TDrawingPadEventSink);
  protected
  public
    property DefaultInterface: IDrawingPadEventSink read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'AreaSketch';

  dtlOcxPage = 'AreaSketch';

implementation

uses ComObj;

procedure TDrawingPad.InitControlData;
const
  CEventDispIDs: array [0..4] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $00000005);
  CControlData: TControlData2 = (
    ClassID: '{2F5C9C6B-4117-4A42-A836-2735A8FCF5C6}';
    EventIID: '{BB77F169-4248-46A0-9BB7-513581CB8AF1}';
    EventCount: 5;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnAreaAdded) - Cardinal(Self);
end;

procedure TDrawingPad.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DDrawingPad;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDrawingPad.GetControlInterface: _DDrawingPad;
begin
  CreateControl;
  Result := FIntf;
end;

function TDrawingPad.AddArea(const data: WideString): WordBool;
begin
  Result := DefaultInterface.AddArea(data);
end;

procedure TDrawingPad.Zoom(percentage: Smallint);
begin
  DefaultInterface.Zoom(percentage);
end;

function TDrawingPad.CreateArea(const id: WideString; const name: WideString): WordBool;
begin
  Result := DefaultInterface.CreateArea(id, name);
end;

function TDrawingPad.NumberOfAreas: Smallint;
begin
  Result := DefaultInterface.NumberOfAreas;
end;

function TDrawingPad.GetArea(index: Smallint; out id: OleVariant; out name: OleVariant; 
                             out desc: OleVariant; out status: OleVariant; out area: OleVariant; 
                             out perimeter: OleVariant): WordBool;
begin
  Result := DefaultInterface.GetArea(index, id, name, desc, status, area, perimeter);
end;

procedure TDrawingPad.Clear;
begin
  DefaultInterface.Clear;
end;

procedure TDrawingPad.SetAreaNameList(list: OleVariant);
begin
  DefaultInterface.SetAreaNameList(list);
end;

function TDrawingPad.LoadSketch(const data: WideString): WordBool;
begin
  Result := DefaultInterface.LoadSketch(data);
end;

function TDrawingPad.GetSketch(out data: OleVariant): WordBool;
begin
  Result := DefaultInterface.GetSketch(data);
end;

procedure TDrawingPad.SetLabelList(labels: OleVariant);
begin
  DefaultInterface.SetLabelList(labels);
end;

function TDrawingPad.GetSketchAsJPEG(width: Integer; height: Integer; quality: Smallint; 
                                     out contents: OleVariant): WordBool;
begin
  Result := DefaultInterface.GetSketchAsJPEG(width, height, quality, contents);
end;

function TDrawingPad.SaveSketchAsJPEG(width: Integer; height: Integer; quality: Smallint; 
                                      const fileName: WideString): WordBool;
begin
  Result := DefaultInterface.SaveSketchAsJPEG(width, height, quality, fileName);
end;

procedure TDrawingPad.KeyPressed(nKey: Smallint);
begin
  DefaultInterface.KeyPressed(nKey);
end;

procedure TDrawingPad.SetupToolPad(const pToolPad: IUnknown);
begin
  DefaultInterface.SetupToolPad(pToolPad);
end;

function TDrawingPad.IsModified: WordBool;
begin
  Result := DefaultInterface.IsModified;
end;

function TDrawingPad.SetupCallback(const pCallback: IUnknown): WordBool;
begin
  Result := DefaultInterface.SetupCallback(pCallback);
end;

function TDrawingPad.CreateAreaWithAttr(const id: WideString; const name: WideString; 
                                        lineStyle: Smallint; lineWidth: Smallint; 
                                        lineColor: OLE_COLOR; dimon: Smallint; 
                                        const autoLabel: WideString; const showCalc: WideString; 
                                        const customFields: WideString): WordBool;
begin
  Result := DefaultInterface.CreateAreaWithAttr(id, name, lineStyle, lineWidth, lineColor, dimon, 
                                                autoLabel, showCalc, customFields);
end;

function TDrawingPad.GetSketchAsMetafile(hinchesX: Integer; hinchesY: Integer; 
                                         out contents: OleVariant): WordBool;
begin
  Result := DefaultInterface.GetSketchAsMetafile(hinchesX, hinchesY, contents);
end;

function TDrawingPad.SetupConfig(const data: WideString): WordBool;
begin
  Result := DefaultInterface.SetupConfig(data);
end;

function TDrawingPad.SetupSymbols(const data: WideString): WordBool;
begin
  Result := DefaultInterface.SetupSymbols(data);
end;

function TDrawingPad.GetAreaById(const uid: WideString; out name: OleVariant; out desc: OleVariant; 
                                 out status: OleVariant; out area: OleVariant; 
                                 out perimeter: OleVariant): WordBool;
begin
  Result := DefaultInterface.GetAreaById(uid, name, desc, status, area, perimeter);
end;

function TDrawingPad.ConnectToDisto(connect: WordBool): WordBool;
begin
  Result := DefaultInterface.ConnectToDisto(connect);
end;

procedure TDrawingPad.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure TAreaSketchCalc.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{D707EABF-8E54-44A4-B348-313174F73ED9}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TAreaSketchCalc.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DAreaSketchCalc;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TAreaSketchCalc.GetControlInterface: _DAreaSketchCalc;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TAreaSketchCalc.SetupDrawingPad(const pDrawingPad: IUnknown);
begin
  DefaultInterface.SetupDrawingPad(pDrawingPad);
end;

procedure TAreaSketchCalc.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

class function CoToolPadEventSink.Create: IToolPadEventSink;
begin
  Result := CreateComObject(CLASS_ToolPadEventSink) as IToolPadEventSink;
end;

class function CoToolPadEventSink.CreateRemote(const MachineName: string): IToolPadEventSink;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ToolPadEventSink) as IToolPadEventSink;
end;

procedure TToolPadEventSink.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{63503C64-A7B0-4B95-BBD1-8535FDF516C9}';
    IntfIID:   '{85588C6C-3E49-49EE-9165-088FDF01C17B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TToolPadEventSink.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IToolPadEventSink;
  end;
end;

procedure TToolPadEventSink.ConnectTo(svrIntf: IToolPadEventSink);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TToolPadEventSink.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TToolPadEventSink.GetDefaultInterface: IToolPadEventSink;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TToolPadEventSink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TToolPadEventSinkProperties.Create(Self);
{$ENDIF}
end;

destructor TToolPadEventSink.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TToolPadEventSink.GetServerProperties: TToolPadEventSinkProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TToolPadEventSinkProperties.Create(AServer: TToolPadEventSink);
begin
  inherited Create;
  FServer := AServer;
end;

function TToolPadEventSinkProperties.GetDefaultInterface: IToolPadEventSink;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoDrawingPadEventSink.Create: IDrawingPadEventSink;
begin
  Result := CreateComObject(CLASS_DrawingPadEventSink) as IDrawingPadEventSink;
end;

class function CoDrawingPadEventSink.CreateRemote(const MachineName: string): IDrawingPadEventSink;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DrawingPadEventSink) as IDrawingPadEventSink;
end;

procedure TDrawingPadEventSink.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{3C697FF0-5DEF-4B6D-811F-9C012C329EC2}';
    IntfIID:   '{B7A26E38-DD19-4962-97EB-5AB174FCD75B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDrawingPadEventSink.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IDrawingPadEventSink;
  end;
end;

procedure TDrawingPadEventSink.ConnectTo(svrIntf: IDrawingPadEventSink);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDrawingPadEventSink.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDrawingPadEventSink.GetDefaultInterface: IDrawingPadEventSink;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDrawingPadEventSink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDrawingPadEventSinkProperties.Create(Self);
{$ENDIF}
end;

destructor TDrawingPadEventSink.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDrawingPadEventSink.GetServerProperties: TDrawingPadEventSinkProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDrawingPadEventSinkProperties.Create(AServer: TDrawingPadEventSink);
begin
  inherited Create;
  FServer := AServer;
end;

function TDrawingPadEventSinkProperties.GetDefaultInterface: IDrawingPadEventSink;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TDrawingPad, TAreaSketchCalc]);
  RegisterComponents(dtlServerPage, [TToolPadEventSink, TDrawingPadEventSink]);
end;

end.
