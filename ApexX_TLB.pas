unit ApexX_TLB;

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

// PASTLWTR : $Revision:   1.130.1.0.1.0.1.6  $
// File generated on 7/29/2003 3:23:37 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\ClickForms6\Tools\Sketchers\Apex\ApexX.ocx (1)
// LIBID: {A0E3B4EA-EE23-445D-9BD9-D0C90DB610F1}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\SYSTEM32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\STDVCL40.DLL)
// Errors:
//   Hint: TypeInfo 'ApexX' changed to 'ApexX_'
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
  ApexXMajorVersion = 2;
  ApexXMinorVersion = 58;

  LIBID_ApexX: TGUID = '{A0E3B4EA-EE23-445D-9BD9-D0C90DB610F1}';

  IID_IApexX: TGUID = '{EFBEA478-5F77-4E9B-B7CF-E86D58A37800}';
  DIID_IApexXEvents: TGUID = '{7D38A183-7E93-4D77-991D-8CDE871F5147}';
  CLASS_ApexX_: TGUID = '{39A081C6-8F01-4CF4-A9F4-5277CE263DBE}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TxAlignment
type
  TxAlignment = TOleEnum;
const
  taLeftJustify = $00000000;
  taRightJustify = $00000001;
  taCenter = $00000002;

// Constants for enum TxBevelCut
type
  TxBevelCut = TOleEnum;
const
  bvNone = $00000000;
  bvLowered = $00000001;
  bvRaised = $00000002;
  bvSpace = $00000003;

// Constants for enum TxBorderStyle
type
  TxBorderStyle = TOleEnum;
const
  bsNone = $00000000;
  bsSingle = $00000001;

// Constants for enum TxDragMode
type
  TxDragMode = TOleEnum;
const
  dmManual = $00000000;
  dmAutomatic = $00000001;

// Constants for enum TxMouseButton
type
  TxMouseButton = TOleEnum;
const
  mbLeft = $00000000;
  mbRight = $00000001;
  mbMiddle = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IApexX = interface;
  IApexXDisp = dispinterface;
  IApexXEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ApexX_ = IApexX;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PPUserType1 = ^IFontDisp; {*}


// *********************************************************************//
// Interface: IApexX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EFBEA478-5F77-4E9B-B7CF-E86D58A37800}
// *********************************************************************//
  IApexX = interface(IDispatch)
    ['{EFBEA478-5F77-4E9B-B7CF-E86D58A37800}']
    procedure SketchData; safecall;
    procedure ClearSketch; safecall;
    procedure CloseApex; safecall;
    procedure CloseSketch; safecall;
    procedure LoadSketch(const SketchFileName: WideString); safecall;
    procedure LoadSketch32(const SketchFileName: WideString); safecall;
    procedure LoadForAX2(const SketchFileName: WideString); safecall;
    procedure LoadDataHandle(hData: LongWord); safecall;
    procedure UpdateSubjectInfo; safecall;
    procedure NextImage; safecall;
    procedure ApexPrint; safecall;
    procedure RunDDEMacro(const sMacro: WideString); safecall;
    procedure SavePlaceableMetafile(const MetafileName: WideString); safecall;
    procedure SaveWindowsBitmapfile(const FileName: WideString); safecall;
    procedure SaveJpegImagefile(const FileName: WideString); safecall;
    function FindFirstArea: WordBool; safecall;
    function FindNextArea: WordBool; safecall;
    function SavePlaceableMetafileByPage(const MetafileName: WideString; iSketchPage: Integer): WordBool; safecall;
    procedure SetApexWindowState(iMode: Integer); safecall;
    procedure SaveAsAx2(const FileName: WideString); safecall;
    procedure SaveAsPAX(const FileName: WideString); safecall;
    procedure CopyToClipboard(hWindow: LongWord); safecall;
    function GetMetafile(iPage: Integer): Integer; safecall;
    function GetAreaNameByIndex(iIndex: Integer): WideString; safecall;
    function GetAreaCodeByIndex(iIndex: Integer): WideString; safecall;
    function GetAreaSizeByIndex(iIndex: Integer): Double; safecall;
    function GetAreaPerimeterByIndex(iIndex: Integer): Double; safecall;
    function GetAreaWallAreaByIndex(iIndex: Integer): Double; safecall;
    function GetAreaMultiplierByIndex(iIndex: Integer): Double; safecall;
    function Get_CurrentMetafile: Integer; safecall;
    function Get_DataHandle: LongWord; safecall;
    procedure Set_DataHandle(Value: LongWord); safecall;
    function Get_SketchForm: Integer; safecall;
    procedure Set_SketchForm(Value: Integer); safecall;
    function Get_SketchPages: Integer; safecall;
    function Get_CurrentPage: Integer; safecall;
    procedure Set_CurrentPage(Value: Integer); safecall;
    function Get_DataPage: Integer; safecall;
    procedure Set_DataPage(Value: Integer); safecall;
    function Get_AreaPage: Integer; safecall;
    procedure Set_AreaPage(Value: Integer); safecall;
    function Get_AreaCount: Integer; safecall;
    procedure Set_AreaCount(Value: Integer); safecall;
    procedure Set_NextArea(Param1: WordBool); safecall;
    function Get_AreaSize: Double; safecall;
    function Get_AreaMultiplier: Double; safecall;
    function Get_AreaSizeAdjusted: Double; safecall;
    function Get_AreaPerimeter: Double; safecall;
    function Get_StartMinimized: WordBool; safecall;
    procedure Set_StartMinimized(Value: WordBool); safecall;
    function Get_UpdateOnLoad: WordBool; safecall;
    procedure Set_UpdateOnLoad(Value: WordBool); safecall;
    function Get_Sketchfile: WideString; safecall;
    procedure Set_Sketchfile(const Value: WideString); safecall;
    function Get_AreaName: WideString; safecall;
    procedure Set_AreaName(const Value: WideString); safecall;
    function Get_AreaCode: WideString; safecall;
    procedure Set_AreaCode(const Value: WideString); safecall;
    function Get_Status: WideString; safecall;
    function Get_SubjectInfo1: WideString; safecall;
    procedure Set_SubjectInfo1(const Value: WideString); safecall;
    function Get_SubjectInfo2: WideString; safecall;
    procedure Set_SubjectInfo2(const Value: WideString); safecall;
    function Get_SubjectInfo3: WideString; safecall;
    procedure Set_SubjectInfo3(const Value: WideString); safecall;
    function Get_SubjectInfo4: WideString; safecall;
    procedure Set_SubjectInfo4(const Value: WideString); safecall;
    function Get_SubjectInfo5: WideString; safecall;
    procedure Set_SubjectInfo5(const Value: WideString); safecall;
    function Get_SubjectInfo6: WideString; safecall;
    procedure Set_SubjectInfo6(const Value: WideString); safecall;
    function Get_SubjectInfo7: WideString; safecall;
    procedure Set_SubjectInfo7(const Value: WideString); safecall;
    function Get_SubjectInfo8: WideString; safecall;
    procedure Set_SubjectInfo8(const Value: WideString); safecall;
    function Get_SubjectInfo9: WideString; safecall;
    procedure Set_SubjectInfo9(const Value: WideString); safecall;
    function Get_SubjectInfo10: WideString; safecall;
    procedure Set_SubjectInfo10(const Value: WideString); safecall;
    function Get_SubjectInfo11: WideString; safecall;
    procedure Set_SubjectInfo11(const Value: WideString); safecall;
    function Get_SubjectInfo12: WideString; safecall;
    procedure Set_SubjectInfo12(const Value: WideString); safecall;
    function Get_ShowSplashScreen: WordBool; safecall;
    procedure Set_ShowSplashScreen(Value: WordBool); safecall;
    function Get_ShowDiagnostics: WordBool; safecall;
    procedure Set_ShowDiagnostics(Value: WordBool); safecall;
    function Get_SplashDelay: Integer; safecall;
    procedure Set_SplashDelay(Value: Integer); safecall;
    function Get_Executable: WideString; safecall;
    procedure Set_Executable(const Value: WideString); safecall;
    function Get_LicenseID: WideString; safecall;
    procedure Set_LicenseID(const Value: WideString); safecall;
    function Get_DisableMenus: Integer; safecall;
    procedure Set_DisableMenus(Value: Integer); safecall;
    function Get_LinkStatus: WideString; safecall;
    procedure Set_LinkStatus(const Value: WideString); safecall;
    function Get_InterruptCode: Integer; safecall;
    function Get_Alignment: TxAlignment; safecall;
    procedure Set_Alignment(Value: TxAlignment); safecall;
    function Get_AutoSize: WordBool; safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    function Get_BevelInner: TxBevelCut; safecall;
    procedure Set_BevelInner(Value: TxBevelCut); safecall;
    function Get_BevelOuter: TxBevelCut; safecall;
    procedure Set_BevelOuter(Value: TxBevelCut); safecall;
    function Get_BorderStyle: TxBorderStyle; safecall;
    procedure Set_BorderStyle(Value: TxBorderStyle); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    function Get_Ctl3D: WordBool; safecall;
    procedure Set_Ctl3D(Value: WordBool); safecall;
    function Get_UseDockManager: WordBool; safecall;
    procedure Set_UseDockManager(Value: WordBool); safecall;
    function Get_DockSite: WordBool; safecall;
    procedure Set_DockSite(Value: WordBool); safecall;
    function Get_DragCursor: Smallint; safecall;
    procedure Set_DragCursor(Value: Smallint); safecall;
    function Get_DragMode: TxDragMode; safecall;
    procedure Set_DragMode(Value: TxDragMode); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_FullRepaint: WordBool; safecall;
    procedure Set_FullRepaint(Value: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    function Get_Locked: WordBool; safecall;
    procedure Set_Locked(Value: WordBool); safecall;
    function Get_ParentColor: WordBool; safecall;
    procedure Set_ParentColor(Value: WordBool); safecall;
    function Get_ParentCtl3D: WordBool; safecall;
    procedure Set_ParentCtl3D(Value: WordBool); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; safecall;
    procedure InitiateAction; safecall;
    function IsRightToLeft: WordBool; safecall;
    function UseRightToLeftReading: WordBool; safecall;
    function UseRightToLeftScrollBar: WordBool; safecall;
    function Get_Cursor: Smallint; safecall;
    procedure Set_Cursor(Value: Smallint); safecall;
    property CurrentMetafile: Integer read Get_CurrentMetafile;
    property DataHandle: LongWord read Get_DataHandle write Set_DataHandle;
    property SketchForm: Integer read Get_SketchForm write Set_SketchForm;
    property SketchPages: Integer read Get_SketchPages;
    property CurrentPage: Integer read Get_CurrentPage write Set_CurrentPage;
    property DataPage: Integer read Get_DataPage write Set_DataPage;
    property AreaPage: Integer read Get_AreaPage write Set_AreaPage;
    property AreaCount: Integer read Get_AreaCount write Set_AreaCount;
    property NextArea: WordBool write Set_NextArea;
    property AreaSize: Double read Get_AreaSize;
    property AreaMultiplier: Double read Get_AreaMultiplier;
    property AreaSizeAdjusted: Double read Get_AreaSizeAdjusted;
    property AreaPerimeter: Double read Get_AreaPerimeter;
    property StartMinimized: WordBool read Get_StartMinimized write Set_StartMinimized;
    property UpdateOnLoad: WordBool read Get_UpdateOnLoad write Set_UpdateOnLoad;
    property Sketchfile: WideString read Get_Sketchfile write Set_Sketchfile;
    property AreaName: WideString read Get_AreaName write Set_AreaName;
    property AreaCode: WideString read Get_AreaCode write Set_AreaCode;
    property Status: WideString read Get_Status;
    property SubjectInfo1: WideString read Get_SubjectInfo1 write Set_SubjectInfo1;
    property SubjectInfo2: WideString read Get_SubjectInfo2 write Set_SubjectInfo2;
    property SubjectInfo3: WideString read Get_SubjectInfo3 write Set_SubjectInfo3;
    property SubjectInfo4: WideString read Get_SubjectInfo4 write Set_SubjectInfo4;
    property SubjectInfo5: WideString read Get_SubjectInfo5 write Set_SubjectInfo5;
    property SubjectInfo6: WideString read Get_SubjectInfo6 write Set_SubjectInfo6;
    property SubjectInfo7: WideString read Get_SubjectInfo7 write Set_SubjectInfo7;
    property SubjectInfo8: WideString read Get_SubjectInfo8 write Set_SubjectInfo8;
    property SubjectInfo9: WideString read Get_SubjectInfo9 write Set_SubjectInfo9;
    property SubjectInfo10: WideString read Get_SubjectInfo10 write Set_SubjectInfo10;
    property SubjectInfo11: WideString read Get_SubjectInfo11 write Set_SubjectInfo11;
    property SubjectInfo12: WideString read Get_SubjectInfo12 write Set_SubjectInfo12;
    property ShowSplashScreen: WordBool read Get_ShowSplashScreen write Set_ShowSplashScreen;
    property ShowDiagnostics: WordBool read Get_ShowDiagnostics write Set_ShowDiagnostics;
    property SplashDelay: Integer read Get_SplashDelay write Set_SplashDelay;
    property Executable: WideString read Get_Executable write Set_Executable;
    property LicenseID: WideString read Get_LicenseID write Set_LicenseID;
    property DisableMenus: Integer read Get_DisableMenus write Set_DisableMenus;
    property LinkStatus: WideString read Get_LinkStatus write Set_LinkStatus;
    property InterruptCode: Integer read Get_InterruptCode;
    property Alignment: TxAlignment read Get_Alignment write Set_Alignment;
    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property BevelInner: TxBevelCut read Get_BevelInner write Set_BevelInner;
    property BevelOuter: TxBevelCut read Get_BevelOuter write Set_BevelOuter;
    property BorderStyle: TxBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property Ctl3D: WordBool read Get_Ctl3D write Set_Ctl3D;
    property UseDockManager: WordBool read Get_UseDockManager write Set_UseDockManager;
    property DockSite: WordBool read Get_DockSite write Set_DockSite;
    property DragCursor: Smallint read Get_DragCursor write Set_DragCursor;
    property DragMode: TxDragMode read Get_DragMode write Set_DragMode;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property FullRepaint: WordBool read Get_FullRepaint write Set_FullRepaint;
    property Font: IFontDisp read Get_Font write Set_Font;
    property Locked: WordBool read Get_Locked write Set_Locked;
    property ParentColor: WordBool read Get_ParentColor write Set_ParentColor;
    property ParentCtl3D: WordBool read Get_ParentCtl3D write Set_ParentCtl3D;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
    property Cursor: Smallint read Get_Cursor write Set_Cursor;
  end;

// *********************************************************************//
// DispIntf:  IApexXDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EFBEA478-5F77-4E9B-B7CF-E86D58A37800}
// *********************************************************************//
  IApexXDisp = dispinterface
    ['{EFBEA478-5F77-4E9B-B7CF-E86D58A37800}']
    procedure SketchData; dispid 1;
    procedure ClearSketch; dispid 2;
    procedure CloseApex; dispid 3;
    procedure CloseSketch; dispid 4;
    procedure LoadSketch(const SketchFileName: WideString); dispid 5;
    procedure LoadSketch32(const SketchFileName: WideString); dispid 6;
    procedure LoadForAX2(const SketchFileName: WideString); dispid 7;
    procedure LoadDataHandle(hData: LongWord); dispid 8;
    procedure UpdateSubjectInfo; dispid 9;
    procedure NextImage; dispid 10;
    procedure ApexPrint; dispid 11;
    procedure RunDDEMacro(const sMacro: WideString); dispid 12;
    procedure SavePlaceableMetafile(const MetafileName: WideString); dispid 13;
    procedure SaveWindowsBitmapfile(const FileName: WideString); dispid 14;
    procedure SaveJpegImagefile(const FileName: WideString); dispid 15;
    function FindFirstArea: WordBool; dispid 16;
    function FindNextArea: WordBool; dispid 17;
    function SavePlaceableMetafileByPage(const MetafileName: WideString; iSketchPage: Integer): WordBool; dispid 18;
    procedure SetApexWindowState(iMode: Integer); dispid 19;
    procedure SaveAsAx2(const FileName: WideString); dispid 20;
    procedure SaveAsPAX(const FileName: WideString); dispid 21;
    procedure CopyToClipboard(hWindow: LongWord); dispid 22;
    function GetMetafile(iPage: Integer): Integer; dispid 23;
    function GetAreaNameByIndex(iIndex: Integer): WideString; dispid 24;
    function GetAreaCodeByIndex(iIndex: Integer): WideString; dispid 25;
    function GetAreaSizeByIndex(iIndex: Integer): Double; dispid 26;
    function GetAreaPerimeterByIndex(iIndex: Integer): Double; dispid 27;
    function GetAreaWallAreaByIndex(iIndex: Integer): Double; dispid 28;
    function GetAreaMultiplierByIndex(iIndex: Integer): Double; dispid 29;
    property CurrentMetafile: Integer readonly dispid 30;
    property DataHandle: LongWord dispid 31;
    property SketchForm: Integer dispid 32;
    property SketchPages: Integer readonly dispid 33;
    property CurrentPage: Integer dispid 34;
    property DataPage: Integer dispid 35;
    property AreaPage: Integer dispid 36;
    property AreaCount: Integer dispid 37;
    property NextArea: WordBool writeonly dispid 38;
    property AreaSize: Double readonly dispid 39;
    property AreaMultiplier: Double readonly dispid 40;
    property AreaSizeAdjusted: Double readonly dispid 41;
    property AreaPerimeter: Double readonly dispid 42;
    property StartMinimized: WordBool dispid 43;
    property UpdateOnLoad: WordBool dispid 44;
    property Sketchfile: WideString dispid 45;
    property AreaName: WideString dispid 46;
    property AreaCode: WideString dispid 47;
    property Status: WideString readonly dispid 48;
    property SubjectInfo1: WideString dispid 49;
    property SubjectInfo2: WideString dispid 50;
    property SubjectInfo3: WideString dispid 51;
    property SubjectInfo4: WideString dispid 52;
    property SubjectInfo5: WideString dispid 53;
    property SubjectInfo6: WideString dispid 54;
    property SubjectInfo7: WideString dispid 55;
    property SubjectInfo8: WideString dispid 56;
    property SubjectInfo9: WideString dispid 57;
    property SubjectInfo10: WideString dispid 58;
    property SubjectInfo11: WideString dispid 59;
    property SubjectInfo12: WideString dispid 60;
    property ShowSplashScreen: WordBool dispid 61;
    property ShowDiagnostics: WordBool dispid 62;
    property SplashDelay: Integer dispid 63;
    property Executable: WideString dispid 64;
    property LicenseID: WideString dispid 65;
    property DisableMenus: Integer dispid 66;
    property LinkStatus: WideString dispid 67;
    property InterruptCode: Integer readonly dispid 68;
    property Alignment: TxAlignment dispid 69;
    property AutoSize: WordBool dispid 70;
    property BevelInner: TxBevelCut dispid 71;
    property BevelOuter: TxBevelCut dispid 72;
    property BorderStyle: TxBorderStyle dispid 73;
    property Caption: WideString dispid -518;
    property Color: OLE_COLOR dispid -501;
    property Ctl3D: WordBool dispid 74;
    property UseDockManager: WordBool dispid 75;
    property DockSite: WordBool dispid 76;
    property DragCursor: Smallint dispid 77;
    property DragMode: TxDragMode dispid 78;
    property Enabled: WordBool dispid -514;
    property FullRepaint: WordBool dispid 79;
    property Font: IFontDisp dispid -512;
    property Locked: WordBool dispid 80;
    property ParentColor: WordBool dispid 81;
    property ParentCtl3D: WordBool dispid 82;
    property Visible: WordBool dispid 83;
    property DoubleBuffered: WordBool dispid 84;
    property VisibleDockClientCount: Integer readonly dispid 85;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; dispid 87;
    procedure InitiateAction; dispid 88;
    function IsRightToLeft: WordBool; dispid 89;
    function UseRightToLeftReading: WordBool; dispid 92;
    function UseRightToLeftScrollBar: WordBool; dispid 93;
    property Cursor: Smallint dispid 94;
  end;

// *********************************************************************//
// DispIntf:  IApexXEvents
// Flags:     (4096) Dispatchable
// GUID:      {7D38A183-7E93-4D77-991D-8CDE871F5147}
// *********************************************************************//
  IApexXEvents = dispinterface
    ['{7D38A183-7E93-4D77-991D-8CDE871F5147}']
    procedure OnNewSketchData; dispid 1;
    procedure OnAreaCodeData; dispid 2;
    procedure OnNewImage; dispid 3;
    procedure OnSketchClose; dispid 4;
    procedure OnAreaChange; dispid 5;
    procedure OnSketchOpen; dispid 6;
    procedure OnLinkInterrupt; dispid 7;
    procedure OnCanResize(var NewWidth: Integer; var NewHeight: Integer; var Resize: WordBool); dispid 8;
    procedure OnClick; dispid 9;
    procedure OnConstrainedResize(var MinWidth: Integer; var MinHeight: Integer; 
                                  var MaxWidth: Integer; var MaxHeight: Integer); dispid 10;
    procedure OnDblClick; dispid 14;
    procedure OnResize; dispid 23;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TApexX
// Help String      : ApexX Control
// Default Interface: IApexX
// Def. Intf. DISP? : No
// Event   Interface: IApexXEvents
// TypeFlags        : (38) CanCreate Licensed Control
// *********************************************************************//
  TApexXOnCanResize = procedure(Sender: TObject; var NewWidth: Integer; var NewHeight: Integer; 
                                                 var Resize: WordBool) of object;
  TApexXOnConstrainedResize = procedure(Sender: TObject; var MinWidth: Integer; 
                                                         var MinHeight: Integer; 
                                                         var MaxWidth: Integer; 
                                                         var MaxHeight: Integer) of object;

  TApexX = class(TOleControl)
  private
    FOnNewSketchData: TNotifyEvent;
    FOnAreaCodeData: TNotifyEvent;
    FOnNewImage: TNotifyEvent;
    FOnSketchClose: TNotifyEvent;
    FOnAreaChange: TNotifyEvent;
    FOnSketchOpen: TNotifyEvent;
    FOnLinkInterrupt: TNotifyEvent;
    FOnCanResize: TApexXOnCanResize;
    FOnClick: TNotifyEvent;
    FOnConstrainedResize: TApexXOnConstrainedResize;
    FOnDblClick: TNotifyEvent;
    FOnResize: TNotifyEvent;
    FIntf: IApexX;
    function  GetControlInterface: IApexX;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure SketchData;
    procedure ClearSketch;
    procedure CloseApex;
    procedure CloseSketch;
    procedure LoadSketch(const SketchFileName: WideString);
    procedure LoadSketch32(const SketchFileName: WideString);
    procedure LoadForAX2(const SketchFileName: WideString);
    procedure LoadDataHandle(hData: LongWord);
    procedure UpdateSubjectInfo;
    procedure NextImage;
    procedure ApexPrint;
    procedure RunDDEMacro(const sMacro: WideString);
    procedure SavePlaceableMetafile(const MetafileName: WideString);
    procedure SaveWindowsBitmapfile(const FileName: WideString);
    procedure SaveJpegImagefile(const FileName: WideString);
    function FindFirstArea: WordBool;
    function FindNextArea: WordBool;
    function SavePlaceableMetafileByPage(const MetafileName: WideString; iSketchPage: Integer): WordBool;
    procedure SetApexWindowState(iMode: Integer);
    procedure SaveAsAx2(const FileName: WideString);
    procedure SaveAsPAX(const FileName: WideString);
    procedure CopyToClipboard(hWindow: LongWord);
    function GetMetafile(iPage: Integer): Integer;
    function GetAreaNameByIndex(iIndex: Integer): WideString;
    function GetAreaCodeByIndex(iIndex: Integer): WideString;
    function GetAreaSizeByIndex(iIndex: Integer): Double;
    function GetAreaPerimeterByIndex(iIndex: Integer): Double;
    function GetAreaWallAreaByIndex(iIndex: Integer): Double;
    function GetAreaMultiplierByIndex(iIndex: Integer): Double;
    function DrawTextBiDiModeFlagsReadingOnly: Integer;
    procedure InitiateAction; reintroduce;
    function IsRightToLeft: WordBool;
    function UseRightToLeftReading: WordBool;
    function UseRightToLeftScrollBar: WordBool;
    property  ControlInterface: IApexX read GetControlInterface;
    property  DefaultInterface: IApexX read GetControlInterface;
    property CurrentMetafile: Integer index 30 read GetIntegerProp;
    property SketchPages: Integer index 33 read GetIntegerProp;
    property NextArea: WordBool index 38 write SetWordBoolProp;
    property AreaSize: Double index 39 read GetDoubleProp;
    property AreaMultiplier: Double index 40 read GetDoubleProp;
    property AreaSizeAdjusted: Double index 41 read GetDoubleProp;
    property AreaPerimeter: Double index 42 read GetDoubleProp;
    property Status: WideString index 48 read GetWideStringProp;
    property InterruptCode: Integer index 68 read GetIntegerProp;
    property DoubleBuffered: WordBool index 84 read GetWordBoolProp write SetWordBoolProp;
    property VisibleDockClientCount: Integer index 85 read GetIntegerProp;
  published
    property  ParentFont;
    property  Align;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property DataHandle: Integer index 31 read GetIntegerProp write SetIntegerProp stored False;
    property SketchForm: Integer index 32 read GetIntegerProp write SetIntegerProp stored False;
    property CurrentPage: Integer index 34 read GetIntegerProp write SetIntegerProp stored False;
    property DataPage: Integer index 35 read GetIntegerProp write SetIntegerProp stored False;
    property AreaPage: Integer index 36 read GetIntegerProp write SetIntegerProp stored False;
    property AreaCount: Integer index 37 read GetIntegerProp write SetIntegerProp stored False;
    property StartMinimized: WordBool index 43 read GetWordBoolProp write SetWordBoolProp stored False;
    property UpdateOnLoad: WordBool index 44 read GetWordBoolProp write SetWordBoolProp stored False;
    property Sketchfile: WideString index 45 read GetWideStringProp write SetWideStringProp stored False;
    property AreaName: WideString index 46 read GetWideStringProp write SetWideStringProp stored False;
    property AreaCode: WideString index 47 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo1: WideString index 49 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo2: WideString index 50 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo3: WideString index 51 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo4: WideString index 52 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo5: WideString index 53 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo6: WideString index 54 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo7: WideString index 55 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo8: WideString index 56 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo9: WideString index 57 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo10: WideString index 58 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo11: WideString index 59 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo12: WideString index 60 read GetWideStringProp write SetWideStringProp stored False;
    property ShowSplashScreen: WordBool index 61 read GetWordBoolProp write SetWordBoolProp stored False;
    property ShowDiagnostics: WordBool index 62 read GetWordBoolProp write SetWordBoolProp stored False;
    property SplashDelay: Integer index 63 read GetIntegerProp write SetIntegerProp stored False;
    property Executable: WideString index 64 read GetWideStringProp write SetWideStringProp stored False;
    property LicenseID: WideString index 65 read GetWideStringProp write SetWideStringProp stored False;
    property DisableMenus: Integer index 66 read GetIntegerProp write SetIntegerProp stored False;
    property LinkStatus: WideString index 67 read GetWideStringProp write SetWideStringProp stored False;
    property Alignment: TOleEnum index 69 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property AutoSize: WordBool index 70 read GetWordBoolProp write SetWordBoolProp stored False;
    property BevelInner: TOleEnum index 71 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BevelOuter: TOleEnum index 72 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BorderStyle: TOleEnum index 73 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Caption: WideString index -518 read GetWideStringProp write SetWideStringProp stored False;
    property Color: TColor index -501 read GetTColorProp write SetTColorProp stored False;
    property Ctl3D: WordBool index 74 read GetWordBoolProp write SetWordBoolProp stored False;
    property UseDockManager: WordBool index 75 read GetWordBoolProp write SetWordBoolProp stored False;
    property DockSite: WordBool index 76 read GetWordBoolProp write SetWordBoolProp stored False;
    property DragCursor: Smallint index 77 read GetSmallintProp write SetSmallintProp stored False;
    property DragMode: TOleEnum index 78 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property FullRepaint: WordBool index 79 read GetWordBoolProp write SetWordBoolProp stored False;
    property Font: TFont index -512 read GetTFontProp write SetTFontProp stored False;
    property Locked: WordBool index 80 read GetWordBoolProp write SetWordBoolProp stored False;
    property ParentColor: WordBool index 81 read GetWordBoolProp write SetWordBoolProp stored False;
    property ParentCtl3D: WordBool index 82 read GetWordBoolProp write SetWordBoolProp stored False;
    property Visible: WordBool index 83 read GetWordBoolProp write SetWordBoolProp stored False;
    property Cursor: Smallint index 94 read GetSmallintProp write SetSmallintProp stored False;
    property OnNewSketchData: TNotifyEvent read FOnNewSketchData write FOnNewSketchData;
    property OnAreaCodeData: TNotifyEvent read FOnAreaCodeData write FOnAreaCodeData;
    property OnNewImage: TNotifyEvent read FOnNewImage write FOnNewImage;
    property OnSketchClose: TNotifyEvent read FOnSketchClose write FOnSketchClose;
    property OnAreaChange: TNotifyEvent read FOnAreaChange write FOnAreaChange;
    property OnSketchOpen: TNotifyEvent read FOnSketchOpen write FOnSketchOpen;
    property OnLinkInterrupt: TNotifyEvent read FOnLinkInterrupt write FOnLinkInterrupt;
    property OnCanResize: TApexXOnCanResize read FOnCanResize write FOnCanResize;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnConstrainedResize: TApexXOnConstrainedResize read FOnConstrainedResize write FOnConstrainedResize;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

procedure TApexX.InitControlData;
const
  CEventDispIDs: array [0..11] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $00000005, $00000006,
    $00000007, $00000008, $00000009, $0000000A, $0000000E, $00000017);
  CLicenseKey: array[0..38] of Word = ( $007B, $0044, $0036, $0033, $0032, $0032, $0042, $0041, $0039, $002D, $0039
    , $0046, $0043, $0033, $002D, $0034, $0046, $0032, $0045, $002D, $0039
    , $0035, $0045, $0046, $002D, $0035, $0045, $0032, $0035, $0031, $0033
    , $0034, $0031, $0039, $0043, $0030, $0033, $007D, $0000);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CControlData: TControlData2 = (
    ClassID: '{39A081C6-8F01-4CF4-A9F4-5277CE263DBE}';
    EventIID: '{7D38A183-7E93-4D77-991D-8CDE871F5147}';
    EventCount: 12;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: @CLicenseKey;
    Flags: $0000001D;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnNewSketchData) - Cardinal(Self);
end;

procedure TApexX.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IApexX;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TApexX.GetControlInterface: IApexX;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TApexX.SketchData;
begin
  DefaultInterface.SketchData;
end;

procedure TApexX.ClearSketch;
begin
  DefaultInterface.ClearSketch;
end;

procedure TApexX.CloseApex;
begin
  DefaultInterface.CloseApex;
end;

procedure TApexX.CloseSketch;
begin
  DefaultInterface.CloseSketch;
end;

procedure TApexX.LoadSketch(const SketchFileName: WideString);
begin
  DefaultInterface.LoadSketch(SketchFileName);
end;

procedure TApexX.LoadSketch32(const SketchFileName: WideString);
begin
  DefaultInterface.LoadSketch32(SketchFileName);
end;

procedure TApexX.LoadForAX2(const SketchFileName: WideString);
begin
  DefaultInterface.LoadForAX2(SketchFileName);
end;

procedure TApexX.LoadDataHandle(hData: LongWord);
begin
  DefaultInterface.LoadDataHandle(hData);
end;

procedure TApexX.UpdateSubjectInfo;
begin
  DefaultInterface.UpdateSubjectInfo;
end;

procedure TApexX.NextImage;
begin
  DefaultInterface.NextImage;
end;

procedure TApexX.ApexPrint;
begin
  DefaultInterface.ApexPrint;
end;

procedure TApexX.RunDDEMacro(const sMacro: WideString);
begin
  DefaultInterface.RunDDEMacro(sMacro);
end;

procedure TApexX.SavePlaceableMetafile(const MetafileName: WideString);
begin
  DefaultInterface.SavePlaceableMetafile(MetafileName);
end;

procedure TApexX.SaveWindowsBitmapfile(const FileName: WideString);
begin
  DefaultInterface.SaveWindowsBitmapfile(FileName);
end;

procedure TApexX.SaveJpegImagefile(const FileName: WideString);
begin
  DefaultInterface.SaveJpegImagefile(FileName);
end;

function TApexX.FindFirstArea: WordBool;
begin
  Result := DefaultInterface.FindFirstArea;
end;

function TApexX.FindNextArea: WordBool;
begin
  Result := DefaultInterface.FindNextArea;
end;

function TApexX.SavePlaceableMetafileByPage(const MetafileName: WideString; iSketchPage: Integer): WordBool;
begin
  Result := DefaultInterface.SavePlaceableMetafileByPage(MetafileName, iSketchPage);
end;

procedure TApexX.SetApexWindowState(iMode: Integer);
begin
  DefaultInterface.SetApexWindowState(iMode);
end;

procedure TApexX.SaveAsAx2(const FileName: WideString);
begin
  DefaultInterface.SaveAsAx2(FileName);
end;

procedure TApexX.SaveAsPAX(const FileName: WideString);
begin
  DefaultInterface.SaveAsPAX(FileName);
end;

procedure TApexX.CopyToClipboard(hWindow: LongWord);
begin
  DefaultInterface.CopyToClipboard(hWindow);
end;

function TApexX.GetMetafile(iPage: Integer): Integer;
begin
  Result := DefaultInterface.GetMetafile(iPage);
end;

function TApexX.GetAreaNameByIndex(iIndex: Integer): WideString;
begin
  Result := DefaultInterface.GetAreaNameByIndex(iIndex);
end;

function TApexX.GetAreaCodeByIndex(iIndex: Integer): WideString;
begin
  Result := DefaultInterface.GetAreaCodeByIndex(iIndex);
end;

function TApexX.GetAreaSizeByIndex(iIndex: Integer): Double;
begin
  Result := DefaultInterface.GetAreaSizeByIndex(iIndex);
end;

function TApexX.GetAreaPerimeterByIndex(iIndex: Integer): Double;
begin
  Result := DefaultInterface.GetAreaPerimeterByIndex(iIndex);
end;

function TApexX.GetAreaWallAreaByIndex(iIndex: Integer): Double;
begin
  Result := DefaultInterface.GetAreaWallAreaByIndex(iIndex);
end;

function TApexX.GetAreaMultiplierByIndex(iIndex: Integer): Double;
begin
  Result := DefaultInterface.GetAreaMultiplierByIndex(iIndex);
end;

function TApexX.DrawTextBiDiModeFlagsReadingOnly: Integer;
begin
  Result := DefaultInterface.DrawTextBiDiModeFlagsReadingOnly;
end;

procedure TApexX.InitiateAction;
begin
  DefaultInterface.InitiateAction;
end;

function TApexX.IsRightToLeft: WordBool;
begin
  Result := DefaultInterface.IsRightToLeft;
end;

function TApexX.UseRightToLeftReading: WordBool;
begin
  Result := DefaultInterface.UseRightToLeftReading;
end;

function TApexX.UseRightToLeftScrollBar: WordBool;
begin
  Result := DefaultInterface.UseRightToLeftScrollBar;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TApexX]);
end;

end.
