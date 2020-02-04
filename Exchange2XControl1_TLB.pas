unit Exchange2XControl1_TLB;

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
// File generated on 1/16/2008 8:20:51 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files\Apex Software\Apex Version 3\ApexExchangeXControl2.ocx (1)
// LIBID: {FA08A056-EF05-4132-B106-B9BB2ED8AA06}
// LCID: 0
// Helpfile: 
// HelpString: Apex Integration Control Library v2 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\system32\stdole2.tlb)
// ************************************************************************ //
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
  Exchange2XControl1MajorVersion = 2;
  Exchange2XControl1MinorVersion = 0;

  LIBID_Exchange2XControl1: TGUID = '{FA08A056-EF05-4132-B106-B9BB2ED8AA06}';

  IID_IExchange2X: TGUID = '{5ADAE7EA-3334-4E15-B634-8B66357DD560}';
  DIID_IExchange2XEvents: TGUID = '{FF096007-C20C-4ABC-9B0A-0A34190A12B6}';
  CLASS_Exchange2X: TGUID = '{9D84003F-0B2A-41F9-8CA6-A47C96F8D81C}';

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
  IExchange2X = interface;
  IExchange2XDisp = dispinterface;
  IExchange2XEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Exchange2X = IExchange2X;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PPUserType1 = ^IFontDisp; {*}

  BrkdwnInfo = packed record
    Shape: Shortint;
    Width: Double;
    Length: Double;
    Size: Double;
  end;


// *********************************************************************//
// Interface: IExchange2X
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5ADAE7EA-3334-4E15-B634-8B66357DD560}
// *********************************************************************//
  IExchange2X = interface(IDispatch)
    ['{5ADAE7EA-3334-4E15-B634-8B66357DD560}']
    function RunDDEMacro(const sMacro: WideString): Integer; safecall;
    procedure LoadSketch32(const sFileName: WideString); safecall;
    procedure OpenSketchFile(const sFileName: WideString); safecall;
    procedure LoadForAX2(const sFileName: WideString); safecall;
    procedure LoadSketch(const sFileName: WideString); safecall;
    function GetMetafile(iPage: Integer): Integer; safecall;
    function GetAreaNameByIndex(iIndex: Integer): WideString; safecall;
    function GetAreaCodeByIndex(iIndex: Integer): WideString; safecall;
    function GetAreaSizeByIndex(iIndex: Integer): Double; safecall;
    function GetAreaPerimeterByIndex(iIndex: Integer): Double; safecall;
    function GetAreaWallAreaByIndex(iIndex: Integer): Double; safecall;
    function GetAreaMultiplierByIndex(iIndex: Integer): Double; safecall;
    function GetUniqueIdByIndex(iIndex: Integer): Integer; safecall;
    function GetAreaBrkdwnShapeByIndex(iIndex: Integer; iItem: Integer): Byte; safecall;
    function GetAreaBrkdwnLengthByIndex(iIndex: Integer; iItem: Integer): Double; safecall;
    function GetAreaBrkdwnWidthByIndex(iIndex: Integer; iItem: Integer): Double; safecall;
    function GetAreaBrkdwnSizeByIndex(iIndex: Integer; iItem: Integer): Double; safecall;
    function GetRoomCountByString(const sIndex: WideString): Integer; safecall;
    procedure StartApex; safecall;
    procedure SketchData; safecall;
    procedure SaveFile; safecall;
    procedure CloseSketch; safecall;
    procedure CloseApex; safecall;
    procedure UpdateSubjectInfo; safecall;
    procedure SetSubjectInfo; safecall;
    procedure SetSketchComment; safecall;
    procedure SetPhotoData; safecall;
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
    function Get_StartMinimized: WordBool; safecall;
    procedure Set_StartMinimized(Value: WordBool); safecall;
    function Get_ConvertGLA: WordBool; safecall;
    procedure Set_ConvertGLA(Value: WordBool); safecall;
    function Get_UpdateOnSave: WordBool; safecall;
    procedure Set_UpdateOnSave(Value: WordBool); safecall;
    function Get_UpdateOnLoad: WordBool; safecall;
    procedure Set_UpdateOnLoad(Value: WordBool); safecall;
    function Get_SketchComment: WideString; safecall;
    procedure Set_SketchComment(const Value: WideString); safecall;
    function Get_PhotoData: WideString; safecall;
    procedure Set_PhotoData(const Value: WideString); safecall;
    function Get_AreaSize: Double; safecall;
    function Get_AreaSizeAdjusted: Double; safecall;
    function Get_AreaCode: WideString; safecall;
    procedure Set_AreaCode(const Value: WideString); safecall;
    function Get_AreaCount: Integer; safecall;
    function Get_AreaBreakdownCount: Integer; safecall;
    function Get_AreaPage: Integer; safecall;
    procedure Set_AreaPage(Value: Integer); safecall;
    function Get_SketchForm: Integer; safecall;
    procedure Set_SketchForm(Value: Integer); safecall;
    function Get_DisableMenus: Integer; safecall;
    procedure Set_DisableMenus(Value: Integer); safecall;
    function Get_LicenseID: WideString; safecall;
    procedure Set_LicenseID(const Value: WideString); safecall;
    function Get_Executable: WideString; safecall;
    procedure Set_Executable(const Value: WideString); safecall;
    function Get_CurrentPage: Integer; safecall;
    procedure Set_CurrentPage(Value: Integer); safecall;
    function Get_SketchPages: Integer; safecall;
    function Get_SketchStatus: WideString; safecall;
    function Get_ApplicationStatus: WideString; safecall;
    function Get_LinkStatus: WideString; safecall;
    function Get_InterruptCode: Integer; safecall;
    function Get_LogFileName: WideString; safecall;
    procedure Set_LogFileName(const Value: WideString); safecall;
    function Get_SplashDelay: Integer; safecall;
    procedure Set_SplashDelay(Value: Integer); safecall;
    function SavePlaceableMetafileByPage(const MetafileName: WideString; iSketchPage: Integer): WordBool; safecall;
    procedure SaveWindowsBitmapfile(const FileName: WideString); safecall;
    procedure SaveJpegImagefile(const FileName: WideString); safecall;
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
    function Get_ParentBackground: WordBool; safecall;
    procedure Set_ParentBackground(Value: WordBool); safecall;
    function Get_ParentColor: WordBool; safecall;
    procedure Set_ParentColor(Value: WordBool); safecall;
    function Get_ParentCtl3D: WordBool; safecall;
    procedure Set_ParentCtl3D(Value: WordBool); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; safecall;
    procedure InitiateAction; safecall;
    function IsRightToLeft: WordBool; safecall;
    function UseRightToLeftReading: WordBool; safecall;
    function UseRightToLeftScrollBar: WordBool; safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
    function GetAreaBreakdownByIndex(iIndex: Integer; iItem: Integer): BrkdwnInfo; safecall;
    procedure UpdateSketchData; safecall;
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
    property StartMinimized: WordBool read Get_StartMinimized write Set_StartMinimized;
    property ConvertGLA: WordBool read Get_ConvertGLA write Set_ConvertGLA;
    property UpdateOnSave: WordBool read Get_UpdateOnSave write Set_UpdateOnSave;
    property UpdateOnLoad: WordBool read Get_UpdateOnLoad write Set_UpdateOnLoad;
    property SketchComment: WideString read Get_SketchComment write Set_SketchComment;
    property PhotoData: WideString read Get_PhotoData write Set_PhotoData;
    property AreaSize: Double read Get_AreaSize;
    property AreaSizeAdjusted: Double read Get_AreaSizeAdjusted;
    property AreaCode: WideString read Get_AreaCode write Set_AreaCode;
    property AreaCount: Integer read Get_AreaCount;
    property AreaBreakdownCount: Integer read Get_AreaBreakdownCount;
    property AreaPage: Integer read Get_AreaPage write Set_AreaPage;
    property SketchForm: Integer read Get_SketchForm write Set_SketchForm;
    property DisableMenus: Integer read Get_DisableMenus write Set_DisableMenus;
    property LicenseID: WideString read Get_LicenseID write Set_LicenseID;
    property Executable: WideString read Get_Executable write Set_Executable;
    property CurrentPage: Integer read Get_CurrentPage write Set_CurrentPage;
    property SketchPages: Integer read Get_SketchPages;
    property SketchStatus: WideString read Get_SketchStatus;
    property ApplicationStatus: WideString read Get_ApplicationStatus;
    property LinkStatus: WideString read Get_LinkStatus;
    property InterruptCode: Integer read Get_InterruptCode;
    property LogFileName: WideString read Get_LogFileName write Set_LogFileName;
    property SplashDelay: Integer read Get_SplashDelay write Set_SplashDelay;
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
    property ParentBackground: WordBool read Get_ParentBackground write Set_ParentBackground;
    property ParentColor: WordBool read Get_ParentColor write Set_ParentColor;
    property ParentCtl3D: WordBool read Get_ParentCtl3D write Set_ParentCtl3D;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property AlignDisabled: WordBool read Get_AlignDisabled;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
  end;

// *********************************************************************//
// DispIntf:  IExchange2XDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5ADAE7EA-3334-4E15-B634-8B66357DD560}
// *********************************************************************//
  IExchange2XDisp = dispinterface
    ['{5ADAE7EA-3334-4E15-B634-8B66357DD560}']
    function RunDDEMacro(const sMacro: WideString): Integer; dispid 201;
    procedure LoadSketch32(const sFileName: WideString); dispid 202;
    procedure OpenSketchFile(const sFileName: WideString); dispid 203;
    procedure LoadForAX2(const sFileName: WideString); dispid 204;
    procedure LoadSketch(const sFileName: WideString); dispid 205;
    function GetMetafile(iPage: Integer): Integer; dispid 206;
    function GetAreaNameByIndex(iIndex: Integer): WideString; dispid 207;
    function GetAreaCodeByIndex(iIndex: Integer): WideString; dispid 208;
    function GetAreaSizeByIndex(iIndex: Integer): Double; dispid 209;
    function GetAreaPerimeterByIndex(iIndex: Integer): Double; dispid 210;
    function GetAreaWallAreaByIndex(iIndex: Integer): Double; dispid 211;
    function GetAreaMultiplierByIndex(iIndex: Integer): Double; dispid 212;
    function GetUniqueIdByIndex(iIndex: Integer): Integer; dispid 213;
    function GetAreaBrkdwnShapeByIndex(iIndex: Integer; iItem: Integer): Byte; dispid 214;
    function GetAreaBrkdwnLengthByIndex(iIndex: Integer; iItem: Integer): Double; dispid 215;
    function GetAreaBrkdwnWidthByIndex(iIndex: Integer; iItem: Integer): Double; dispid 216;
    function GetAreaBrkdwnSizeByIndex(iIndex: Integer; iItem: Integer): Double; dispid 217;
    function GetRoomCountByString(const sIndex: WideString): Integer; dispid 218;
    procedure StartApex; dispid 219;
    procedure SketchData; dispid 220;
    procedure SaveFile; dispid 221;
    procedure CloseSketch; dispid 222;
    procedure CloseApex; dispid 223;
    procedure UpdateSubjectInfo; dispid 224;
    procedure SetSubjectInfo; dispid 225;
    procedure SetSketchComment; dispid 226;
    procedure SetPhotoData; dispid 227;
    property SubjectInfo1: WideString dispid 228;
    property SubjectInfo2: WideString dispid 229;
    property SubjectInfo3: WideString dispid 230;
    property SubjectInfo4: WideString dispid 231;
    property SubjectInfo5: WideString dispid 232;
    property SubjectInfo6: WideString dispid 233;
    property SubjectInfo7: WideString dispid 234;
    property SubjectInfo8: WideString dispid 235;
    property SubjectInfo9: WideString dispid 236;
    property SubjectInfo10: WideString dispid 237;
    property SubjectInfo11: WideString dispid 238;
    property SubjectInfo12: WideString dispid 239;
    property ShowSplashScreen: WordBool dispid 240;
    property ShowDiagnostics: WordBool dispid 241;
    property StartMinimized: WordBool dispid 242;
    property ConvertGLA: WordBool dispid 243;
    property UpdateOnSave: WordBool dispid 244;
    property UpdateOnLoad: WordBool dispid 245;
    property SketchComment: WideString dispid 246;
    property PhotoData: WideString dispid 247;
    property AreaSize: Double readonly dispid 248;
    property AreaSizeAdjusted: Double readonly dispid 249;
    property AreaCode: WideString dispid 250;
    property AreaCount: Integer readonly dispid 251;
    property AreaBreakdownCount: Integer readonly dispid 252;
    property AreaPage: Integer dispid 253;
    property SketchForm: Integer dispid 254;
    property DisableMenus: Integer dispid 255;
    property LicenseID: WideString dispid 256;
    property Executable: WideString dispid 257;
    property CurrentPage: Integer dispid 258;
    property SketchPages: Integer readonly dispid 259;
    property SketchStatus: WideString readonly dispid 260;
    property ApplicationStatus: WideString readonly dispid 261;
    property LinkStatus: WideString readonly dispid 262;
    property InterruptCode: Integer readonly dispid 263;
    property LogFileName: WideString dispid 264;
    property SplashDelay: Integer dispid 265;
    function SavePlaceableMetafileByPage(const MetafileName: WideString; iSketchPage: Integer): WordBool; dispid 266;
    procedure SaveWindowsBitmapfile(const FileName: WideString); dispid 267;
    procedure SaveJpegImagefile(const FileName: WideString); dispid 268;
    property Alignment: TxAlignment dispid 269;
    property AutoSize: WordBool dispid 270;
    property BevelInner: TxBevelCut dispid 271;
    property BevelOuter: TxBevelCut dispid 272;
    property BorderStyle: TxBorderStyle dispid 273;
    property Caption: WideString dispid -518;
    property Color: OLE_COLOR dispid -501;
    property Ctl3D: WordBool dispid 274;
    property UseDockManager: WordBool dispid 275;
    property DockSite: WordBool dispid 276;
    property DragCursor: Smallint dispid 277;
    property DragMode: TxDragMode dispid 278;
    property Enabled: WordBool dispid -514;
    property FullRepaint: WordBool dispid 279;
    property Font: IFontDisp dispid -512;
    property Locked: WordBool dispid 280;
    property ParentBackground: WordBool dispid 281;
    property ParentColor: WordBool dispid 282;
    property ParentCtl3D: WordBool dispid 283;
    property Visible: WordBool dispid 284;
    property DoubleBuffered: WordBool dispid 285;
    property AlignDisabled: WordBool readonly dispid 286;
    property VisibleDockClientCount: Integer readonly dispid 287;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; dispid 288;
    procedure InitiateAction; dispid 289;
    function IsRightToLeft: WordBool; dispid 290;
    function UseRightToLeftReading: WordBool; dispid 291;
    function UseRightToLeftScrollBar: WordBool; dispid 292;
    procedure SetSubComponent(IsSubComponent: WordBool); dispid 293;
    function GetAreaBreakdownByIndex(iIndex: Integer; iItem: Integer): {??BrkdwnInfo}OleVariant; dispid 294;
    procedure UpdateSketchData; dispid 295;
  end;

// *********************************************************************//
// DispIntf:  IExchange2XEvents
// Flags:     (4096) Dispatchable
// GUID:      {FF096007-C20C-4ABC-9B0A-0A34190A12B6}
// *********************************************************************//
  IExchange2XEvents = dispinterface
    ['{FF096007-C20C-4ABC-9B0A-0A34190A12B6}']
    procedure OnNewSketchData; dispid 201;
    procedure OnAreaCodeData; dispid 202;
    procedure OnSketchClose; dispid 203;
    procedure OnSketchOpen; dispid 204;
    procedure OnSketchSave; dispid 205;
    procedure OnApplicationOpen; dispid 206;
    procedure OnApplicationClose; dispid 207;
    procedure OnSubjectInfo; dispid 208;
    procedure OnLinkInterrupt; dispid 209;
    procedure OnCanResize(var NewWidth: Integer; var NewHeight: Integer; var Resize: WordBool); dispid 210;
    procedure OnClick; dispid 211;
    procedure OnConstrainedResize(var MinWidth: Integer; var MinHeight: Integer; 
                                  var MaxWidth: Integer; var MaxHeight: Integer); dispid 212;
    procedure OnDblClick; dispid 213;
    procedure OnResize; dispid 214;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TExchange2X
// Help String      : Exchange2X Control
// Default Interface: IExchange2X
// Def. Intf. DISP? : No
// Event   Interface: IExchange2XEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TExchange2XOnCanResize = procedure(ASender: TObject; var NewWidth: Integer; 
                                                       var NewHeight: Integer; var Resize: WordBool) of object;
  TExchange2XOnConstrainedResize = procedure(ASender: TObject; var MinWidth: Integer; 
                                                               var MinHeight: Integer; 
                                                               var MaxWidth: Integer; 
                                                               var MaxHeight: Integer) of object;

  TExchange2X = class(TOleControl)
  private
    FOnNewSketchData: TNotifyEvent;
    FOnAreaCodeData: TNotifyEvent;
    FOnSketchClose: TNotifyEvent;
    FOnSketchOpen: TNotifyEvent;
    FOnSketchSave: TNotifyEvent;
    FOnApplicationOpen: TNotifyEvent;
    FOnApplicationClose: TNotifyEvent;
    FOnSubjectInfo: TNotifyEvent;
    FOnLinkInterrupt: TNotifyEvent;
    FOnCanResize: TExchange2XOnCanResize;
    FOnClick: TNotifyEvent;
    FOnConstrainedResize: TExchange2XOnConstrainedResize;
    FOnDblClick: TNotifyEvent;
    FOnResize: TNotifyEvent;
    FIntf: IExchange2X;
    function  GetControlInterface: IExchange2X;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function RunDDEMacro(const sMacro: WideString): Integer;
    procedure LoadSketch32(const sFileName: WideString);
    procedure OpenSketchFile(const sFileName: WideString);
    procedure LoadForAX2(const sFileName: WideString);
    procedure LoadSketch(const sFileName: WideString);
    function GetMetafile(iPage: Integer): Integer;
    function GetAreaNameByIndex(iIndex: Integer): WideString;
    function GetAreaCodeByIndex(iIndex: Integer): WideString;
    function GetAreaSizeByIndex(iIndex: Integer): Double;
    function GetAreaPerimeterByIndex(iIndex: Integer): Double;
    function GetAreaWallAreaByIndex(iIndex: Integer): Double;
    function GetAreaMultiplierByIndex(iIndex: Integer): Double;
    function GetUniqueIdByIndex(iIndex: Integer): Integer;
    function GetAreaBrkdwnShapeByIndex(iIndex: Integer; iItem: Integer): Byte;
    function GetAreaBrkdwnLengthByIndex(iIndex: Integer; iItem: Integer): Double;
    function GetAreaBrkdwnWidthByIndex(iIndex: Integer; iItem: Integer): Double;
    function GetAreaBrkdwnSizeByIndex(iIndex: Integer; iItem: Integer): Double;
    function GetRoomCountByString(const sIndex: WideString): Integer;
    procedure StartApex;
    procedure SketchData;
    procedure SaveFile;
    procedure CloseSketch;
    procedure CloseApex;
    procedure UpdateSubjectInfo;
    procedure SetSubjectInfo;
    procedure SetSketchComment;
    procedure SetPhotoData;
    function SavePlaceableMetafileByPage(const MetafileName: WideString; iSketchPage: Integer): WordBool;
    procedure SaveWindowsBitmapfile(const FileName: WideString);
    procedure SaveJpegImagefile(const FileName: WideString);
    function DrawTextBiDiModeFlagsReadingOnly: Integer;
    procedure InitiateAction; reintroduce;
    function IsRightToLeft: WordBool;
    function UseRightToLeftReading: WordBool;
    function UseRightToLeftScrollBar: WordBool;
    procedure SetSubComponent(IsSubComponent: WordBool);
    function GetAreaBreakdownByIndex(iIndex: Integer; iItem: Integer): BrkdwnInfo;
    procedure UpdateSketchData;
    property  ControlInterface: IExchange2X read GetControlInterface;
    property  DefaultInterface: IExchange2X read GetControlInterface;
    property AreaSize: Double index 248 read GetDoubleProp;
    property AreaSizeAdjusted: Double index 249 read GetDoubleProp;
    property AreaCount: Integer index 251 read GetIntegerProp;
    property AreaBreakdownCount: Integer index 252 read GetIntegerProp;
    property SketchPages: Integer index 259 read GetIntegerProp;
    property SketchStatus: WideString index 260 read GetWideStringProp;
    property ApplicationStatus: WideString index 261 read GetWideStringProp;
    property LinkStatus: WideString index 262 read GetWideStringProp;
    property InterruptCode: Integer index 263 read GetIntegerProp;
    property DoubleBuffered: WordBool index 285 read GetWordBoolProp write SetWordBoolProp;
    property AlignDisabled: WordBool index 286 read GetWordBoolProp;
    property VisibleDockClientCount: Integer index 287 read GetIntegerProp;
  published
    property Anchors;
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
    property SubjectInfo1: WideString index 228 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo2: WideString index 229 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo3: WideString index 230 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo4: WideString index 231 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo5: WideString index 232 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo6: WideString index 233 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo7: WideString index 234 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo8: WideString index 235 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo9: WideString index 236 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo10: WideString index 237 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo11: WideString index 238 read GetWideStringProp write SetWideStringProp stored False;
    property SubjectInfo12: WideString index 239 read GetWideStringProp write SetWideStringProp stored False;
    property ShowSplashScreen: WordBool index 240 read GetWordBoolProp write SetWordBoolProp stored False;
    property ShowDiagnostics: WordBool index 241 read GetWordBoolProp write SetWordBoolProp stored False;
    property StartMinimized: WordBool index 242 read GetWordBoolProp write SetWordBoolProp stored False;
    property ConvertGLA: WordBool index 243 read GetWordBoolProp write SetWordBoolProp stored False;
    property UpdateOnSave: WordBool index 244 read GetWordBoolProp write SetWordBoolProp stored False;
    property UpdateOnLoad: WordBool index 245 read GetWordBoolProp write SetWordBoolProp stored False;
    property SketchComment: WideString index 246 read GetWideStringProp write SetWideStringProp stored False;
    property PhotoData: WideString index 247 read GetWideStringProp write SetWideStringProp stored False;
    property AreaCode: WideString index 250 read GetWideStringProp write SetWideStringProp stored False;
    property AreaPage: Integer index 253 read GetIntegerProp write SetIntegerProp stored False;
    property SketchForm: Integer index 254 read GetIntegerProp write SetIntegerProp stored False;
    property DisableMenus: Integer index 255 read GetIntegerProp write SetIntegerProp stored False;
    property LicenseID: WideString index 256 read GetWideStringProp write SetWideStringProp stored False;
    property Executable: WideString index 257 read GetWideStringProp write SetWideStringProp stored False;
    property CurrentPage: Integer index 258 read GetIntegerProp write SetIntegerProp stored False;
    property LogFileName: WideString index 264 read GetWideStringProp write SetWideStringProp stored False;
    property SplashDelay: Integer index 265 read GetIntegerProp write SetIntegerProp stored False;
    property Alignment: TOleEnum index 269 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property AutoSize: WordBool index 270 read GetWordBoolProp write SetWordBoolProp stored False;
    property BevelInner: TOleEnum index 271 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BevelOuter: TOleEnum index 272 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property BorderStyle: TOleEnum index 273 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Caption: WideString index -518 read GetWideStringProp write SetWideStringProp stored False;
    property Color: TColor index -501 read GetTColorProp write SetTColorProp stored False;
    property Ctl3D: WordBool index 274 read GetWordBoolProp write SetWordBoolProp stored False;
    property UseDockManager: WordBool index 275 read GetWordBoolProp write SetWordBoolProp stored False;
    property DockSite: WordBool index 276 read GetWordBoolProp write SetWordBoolProp stored False;
    property DragCursor: Smallint index 277 read GetSmallintProp write SetSmallintProp stored False;
    property DragMode: TOleEnum index 278 read GetTOleEnumProp write SetTOleEnumProp stored False;
    property Enabled: WordBool index -514 read GetWordBoolProp write SetWordBoolProp stored False;
    property FullRepaint: WordBool index 279 read GetWordBoolProp write SetWordBoolProp stored False;
    property Font: TFont index -512 read GetTFontProp write SetTFontProp stored False;
    property Locked: WordBool index 280 read GetWordBoolProp write SetWordBoolProp stored False;
    property ParentBackground: WordBool index 281 read GetWordBoolProp write SetWordBoolProp stored False;
    property ParentColor: WordBool index 282 read GetWordBoolProp write SetWordBoolProp stored False;
    property ParentCtl3D: WordBool index 283 read GetWordBoolProp write SetWordBoolProp stored False;
    property Visible: WordBool index 284 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnNewSketchData: TNotifyEvent read FOnNewSketchData write FOnNewSketchData;
    property OnAreaCodeData: TNotifyEvent read FOnAreaCodeData write FOnAreaCodeData;
    property OnSketchClose: TNotifyEvent read FOnSketchClose write FOnSketchClose;
    property OnSketchOpen: TNotifyEvent read FOnSketchOpen write FOnSketchOpen;
    property OnSketchSave: TNotifyEvent read FOnSketchSave write FOnSketchSave;
    property OnApplicationOpen: TNotifyEvent read FOnApplicationOpen write FOnApplicationOpen;
    property OnApplicationClose: TNotifyEvent read FOnApplicationClose write FOnApplicationClose;
    property OnSubjectInfo: TNotifyEvent read FOnSubjectInfo write FOnSubjectInfo;
    property OnLinkInterrupt: TNotifyEvent read FOnLinkInterrupt write FOnLinkInterrupt;
    property OnCanResize: TExchange2XOnCanResize read FOnCanResize write FOnCanResize;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnConstrainedResize: TExchange2XOnConstrainedResize read FOnConstrainedResize write FOnConstrainedResize;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TExchange2X.InitControlData;
const
  CEventDispIDs: array [0..13] of DWORD = (
    $000000C9, $000000CA, $000000CB, $000000CC, $000000CD, $000000CE,
    $000000CF, $000000D0, $000000D1, $000000D2, $000000D3, $000000D4,
    $000000D5, $000000D6);
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CControlData: TControlData2 = (
    ClassID: '{9D84003F-0B2A-41F9-8CA6-A47C96F8D81C}';
    EventIID: '{FF096007-C20C-4ABC-9B0A-0A34190A12B6}';
    EventCount: 14;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $0000001D;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnNewSketchData) - Cardinal(Self);
end;

procedure TExchange2X.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IExchange2X;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TExchange2X.GetControlInterface: IExchange2X;
begin
  CreateControl;
  Result := FIntf;
end;

function TExchange2X.RunDDEMacro(const sMacro: WideString): Integer;
begin
  Result := DefaultInterface.RunDDEMacro(sMacro);
end;

procedure TExchange2X.LoadSketch32(const sFileName: WideString);
begin
  DefaultInterface.LoadSketch32(sFileName);
end;

procedure TExchange2X.OpenSketchFile(const sFileName: WideString);
begin
  DefaultInterface.OpenSketchFile(sFileName);
end;

procedure TExchange2X.LoadForAX2(const sFileName: WideString);
begin
  DefaultInterface.LoadForAX2(sFileName);
end;

procedure TExchange2X.LoadSketch(const sFileName: WideString);
begin
  DefaultInterface.LoadSketch(sFileName);
end;

function TExchange2X.GetMetafile(iPage: Integer): Integer;
begin
  Result := DefaultInterface.GetMetafile(iPage);
end;

function TExchange2X.GetAreaNameByIndex(iIndex: Integer): WideString;
begin
  Result := DefaultInterface.GetAreaNameByIndex(iIndex);
end;

function TExchange2X.GetAreaCodeByIndex(iIndex: Integer): WideString;
begin
  Result := DefaultInterface.GetAreaCodeByIndex(iIndex);
end;

function TExchange2X.GetAreaSizeByIndex(iIndex: Integer): Double;
begin
  Result := DefaultInterface.GetAreaSizeByIndex(iIndex);
end;

function TExchange2X.GetAreaPerimeterByIndex(iIndex: Integer): Double;
begin
  Result := DefaultInterface.GetAreaPerimeterByIndex(iIndex);
end;

function TExchange2X.GetAreaWallAreaByIndex(iIndex: Integer): Double;
begin
  Result := DefaultInterface.GetAreaWallAreaByIndex(iIndex);
end;

function TExchange2X.GetAreaMultiplierByIndex(iIndex: Integer): Double;
begin
  Result := DefaultInterface.GetAreaMultiplierByIndex(iIndex);
end;

function TExchange2X.GetUniqueIdByIndex(iIndex: Integer): Integer;
begin
  Result := DefaultInterface.GetUniqueIdByIndex(iIndex);
end;

function TExchange2X.GetAreaBrkdwnShapeByIndex(iIndex: Integer; iItem: Integer): Byte;
begin
  Result := DefaultInterface.GetAreaBrkdwnShapeByIndex(iIndex, iItem);
end;

function TExchange2X.GetAreaBrkdwnLengthByIndex(iIndex: Integer; iItem: Integer): Double;
begin
  Result := DefaultInterface.GetAreaBrkdwnLengthByIndex(iIndex, iItem);
end;

function TExchange2X.GetAreaBrkdwnWidthByIndex(iIndex: Integer; iItem: Integer): Double;
begin
  Result := DefaultInterface.GetAreaBrkdwnWidthByIndex(iIndex, iItem);
end;

function TExchange2X.GetAreaBrkdwnSizeByIndex(iIndex: Integer; iItem: Integer): Double;
begin
  Result := DefaultInterface.GetAreaBrkdwnSizeByIndex(iIndex, iItem);
end;

function TExchange2X.GetRoomCountByString(const sIndex: WideString): Integer;
begin
  Result := DefaultInterface.GetRoomCountByString(sIndex);
end;

procedure TExchange2X.StartApex;
begin
  DefaultInterface.StartApex;
end;

procedure TExchange2X.SketchData;
begin
  DefaultInterface.SketchData;
end;

procedure TExchange2X.SaveFile;
begin
  DefaultInterface.SaveFile;
end;

procedure TExchange2X.CloseSketch;
begin
  DefaultInterface.CloseSketch;
end;

procedure TExchange2X.CloseApex;
begin
  DefaultInterface.CloseApex;
end;

procedure TExchange2X.UpdateSubjectInfo;
begin
  DefaultInterface.UpdateSubjectInfo;
end;

procedure TExchange2X.SetSubjectInfo;
begin
  DefaultInterface.SetSubjectInfo;
end;

procedure TExchange2X.SetSketchComment;
begin
  DefaultInterface.SetSketchComment;
end;

procedure TExchange2X.SetPhotoData;
begin
  DefaultInterface.SetPhotoData;
end;

function TExchange2X.SavePlaceableMetafileByPage(const MetafileName: WideString; 
                                                 iSketchPage: Integer): WordBool;
begin
  Result := DefaultInterface.SavePlaceableMetafileByPage(MetafileName, iSketchPage);
end;

procedure TExchange2X.SaveWindowsBitmapfile(const FileName: WideString);
begin
  DefaultInterface.SaveWindowsBitmapfile(FileName);
end;

procedure TExchange2X.SaveJpegImagefile(const FileName: WideString);
begin
  DefaultInterface.SaveJpegImagefile(FileName);
end;

function TExchange2X.DrawTextBiDiModeFlagsReadingOnly: Integer;
begin
  Result := DefaultInterface.DrawTextBiDiModeFlagsReadingOnly;
end;

procedure TExchange2X.InitiateAction;
begin
  DefaultInterface.InitiateAction;
end;

function TExchange2X.IsRightToLeft: WordBool;
begin
  Result := DefaultInterface.IsRightToLeft;
end;

function TExchange2X.UseRightToLeftReading: WordBool;
begin
  Result := DefaultInterface.UseRightToLeftReading;
end;

function TExchange2X.UseRightToLeftScrollBar: WordBool;
begin
  Result := DefaultInterface.UseRightToLeftScrollBar;
end;

procedure TExchange2X.SetSubComponent(IsSubComponent: WordBool);
begin
  DefaultInterface.SetSubComponent(IsSubComponent);
end;

function TExchange2X.GetAreaBreakdownByIndex(iIndex: Integer; iItem: Integer): BrkdwnInfo;
begin
  Result := DefaultInterface.GetAreaBreakdownByIndex(iIndex, iItem);
end;

procedure TExchange2X.UpdateSketchData;
begin
  DefaultInterface.UpdateSketchData;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TExchange2X]);
end;

end.
